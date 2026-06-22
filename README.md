# harrd

A TUI hardlink tool for media files. Organize your media library by creating hardlinks from torrent downloads to a structured library folder.

```
  ╔══════════════════════════════════════════════════╗
  ║                                                  ║
  ║  ╭━━━╮╭━━━╮╭━━━╮   H A R R D    ╭━━━╮╭━━━╮╭━━━╮  ║
  ║  │ ◉ ││ ◉ ││ ◉ │                │ ◉ ││ ◉ ││ ◉ │  ║
  ║  ╰━━━╯╰━━━╯╰━━━╯   H A R R D    ╰━━━╯╰━━━╯╰━━━╯  ║
  ║                                                  ║
  ╚══════════════════════════════════════════════════╝
```

## Why?

When Sonarr/Radarr don't automatically recognize your media, you need a quick way to hardlink files into a structured library. **harrd** gives you an interactive TUI to do this efficiently.

Hardlinks preserve disk space — the file exists in both locations but only uses storage once.

## Features

- **fzf-powered navigation** — browse directories visually with file previews
- **Smart detection** — automatically identifies series (S01E01, Season, etc.) and films (year + resolution, Bluray)
- **"Title (year)" subfolder** — unrecognized content gets organized with editable folder names
- **Dry-run mode** — preview what will happen, then execute for real in one step
- **Recursive mode** — process subdirectories
- **Path persistence** — source/destination saved in config, no need to re-enter each time
- **Log rotation** — automatic cleanup of operation logs

## Requirements

- [fzf](https://github.com/junegunn/fzf)
- bash 4+
- find, du, df, awk (standard utils)

## Installation

### Quick install

```bash
git clone https://github.com/YOUR_USERNAME/harrd.git
cd harrd
chmod +x install.sh
sudo ./install.sh
```

### Manual install

```bash
git clone https://github.com/YOUR_USERNAME/harrd.git
sudo cp harrd/harrd /usr/local/bin/harrd
sudo chmod +x /usr/local/bin/harrd
```

### With curl

```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/harrd/main/install.sh | sudo bash
```

## Usage

```bash
harrd              # Launch the TUI
harrd --help       # Show help
harrd --version    # Show version
```

### First launch

On first launch, you'll be prompted for your default source and destination paths. These are saved to `~/.config/hardlink-tui/config`.

### Menu options

| Key | Action |
|-----|--------|
| `1` | Launch hardlink workflow |
| `2` | Modify source/destination paths |
| `3` | Quit |
| `d` | Toggle dry-run mode |
| `r` | Toggle recursive mode |

### Workflow

1. Select source directory (where your downloads are)
2. Select destination directory (where your library is)
3. **harrd** auto-detects content type:
   - **Series**: Creates `series/Show Name/Season XX/` structure
   - **Film**: Creates `films/Movie Name (YYYY)/` structure
   - **Unknown**: Creates a "Title (year)" subfolder with manual edit option
4. Review the summary and confirm
5. If dry-run was on, choose to execute for real

## Configuration

Config is stored at `~/.config/hardlink-tui/config`:

```
SRC="/media/raid/data/torrents"
DST="/media/raid/data"
```

## File extensions handled

**Video:** `.mkv` `.mp4` `.avi` `.mov` `.webm` `.m4v` `.flv` `.wmv`

**Subtitles/Metadata:** `.srt` `.nfo` `.ass` `.sub` `.idx` `.vtt`

## License

[MIT](LICENSE)
