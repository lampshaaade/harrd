#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="/usr/local/bin"
CONFIG_DIR="$HOME/.config/hardlink-tui"
SCRIPT_NAME="harrd"

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; DIM='\033[2m'; RESET='\033[0m'

echo -e "${CYAN}${BOLD}"
echo "  ╔══════════════════════════════════╗"
echo "  ║       harrd — installer          ║"
echo "  ╚══════════════════════════════════╝"
echo -e "${RESET}"

# Check script exists
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_FILE="$SCRIPT_DIR/$SCRIPT_NAME"

if [[ ! -f "$SOURCE_FILE" ]]; then
    echo -e "${RED}Error: $SCRIPT_NAME not found in $SCRIPT_DIR${RESET}"
    exit 1
fi

# Check not running as root for config, but need root for install dir
if [[ $EUID -eq 0 ]]; then
    echo -e "${YELLOW}Warning: Running as root. Config will be created for root user.${RESET}"
fi

# Install binary
echo -e "${DIM}Installing $SCRIPT_NAME to $INSTALL_DIR...${RESET}"
install -m 755 "$SOURCE_FILE" "$INSTALL_DIR/$SCRIPT_NAME"
echo -e "${GREEN}✓ Installed to $INSTALL_DIR/$SCRIPT_NAME${RESET}"

# Create config directory
echo -e "${DIM}Creating config directory...${RESET}"
mkdir -p "$CONFIG_DIR"
echo -e "${GREEN}✓ Config directory: $CONFIG_DIR${RESET}"

# Check dependencies
echo
echo -e "${BOLD}Checking dependencies...${RESET}"
missing=()
command -v fzf >/dev/null 2>&1 || missing+=("fzf")
command -v find >/dev/null 2>&1 || missing+=("find")

if [[ ${#missing[@]} -gt 0 ]]; then
    echo -e "${YELLOW}⚠ Missing: ${missing[*]}${RESET}"
    echo -e "${DIM}  Install them with your package manager${RESET}"
else
    echo -e "${GREEN}✓ All dependencies satisfied${RESET}"
fi

echo
echo -e "${GREEN}${BOLD}Installation complete!${RESET}"
echo -e "${DIM}Run 'harrd' to start${RESET}"
echo
