# Shot list

A gallery for this theme, capturable in one sitting (~10 minutes). The point of
the set is the thing the current single `preview.png` cannot show: **the glass
has moving water behind it**, and the material is what changes, not the palette.

Save everything into `docs/media/` as `NN-name.png` (or `.gif` / `.mp4`), then
link the ones worth keeping from `README.md`.

## Before you start

```sh
mkdir -p docs/media
omarchy theme set "Apple Glass"
omarchy-aquarium-toggle on
```

Set `OMARCHY_SCREENSHOT_DIR` to the media directory, or just move the files
afterwards:

```sh
export OMARCHY_SCREENSHOT_DIR="$PWD/docs/media"
```

Full-screen capture, no picker:

```sh
omarchy screenshot fullscreen save
```

Close anything personal first — the shots are going into a public repo.

## The shots

Numbers are the intended gallery order.

- [ ] **01 — hero: glass over water.** Aquarium **on**. Two windows overlapping
      by about a third: a terminal (foot or kitty, `btop` or `fastfetch`
      running) in front, a browser or file manager behind it. Focus the
      terminal so the front window carries the active rim light and the back one
      the dim border. Bar visible. This is the shot that has to sell the theme —
      make sure a fish or a caustic highlight is visibly *behind* the glass, not
      beside it.
- [ ] **02 — the same frame, aquarium off.** `omarchy-aquarium-toggle off`, put
      `backgrounds/1-sequoia-dusk.jpg` up, do not move a single window, capture
      again. 01 and 02 side by side is the argument. Turn the aquarium back on
      afterwards.
- [ ] **03 — motion (the one that cannot be faked).** A 3–5 second clip of the
      idle desktop from shot 01, water moving behind the panes, nothing else
      happening. Nothing static conveys this.

      ```sh
      omarchy screenrecord --fullscreen        # start
      omarchy screenrecord --stop-recording    # stop
      ffmpeg -i <clip>.mp4 -vf "fps=15,scale=960:-1:flags=lanczos,split[a][b];[a]palettegen[p];[b][p]paletteuse" docs/media/03-motion.gif
      ```

      Keep it under ~5 MB so GitHub plays it inline.
- [ ] **04 — depth stack.** Three or four terminals cascaded with visible
      overlap, each showing different content. `blur.xray` means each pane blurs
      to the water rather than to the pane below, so the stack should not turn
      to mud — that is the claim this shot has to back up.
- [ ] **05 — the app launcher.** `SUPER + ALT + SPACE` (`omarchy-menu toggle
      apps`). Type a couple of characters so the list is filtered and one row
      carries the blue selection. Windows still visible behind the scrim — the
      scrim is only 0.42, so they should be.
- [ ] **06 — the Omarchy menu.** `SUPER + SPACE` (`omarchy-menu toggle`), one
      submenu deep, so the scrim, the card and the selected row are all in
      frame.
- [ ] **07 — the bar, close up.** Crop or region-capture the top bar over a
      *busy* part of the wallpaper — that is where a 0.55-alpha surface either
      holds its text or does not.

      ```sh
      omarchy screenshot region save
      ```
- [ ] **08 — a notification on glass.** Trigger one and catch it before it
      expires:

      ```sh
      notify-send "Apple Glass" "Notification banners are 0.68-alpha glass." && sleep 1 && omarchy screenshot fullscreen save
      ```
- [ ] **09 — controls.** The control center or the network / volume panel open,
      with a hover or keyboard focus visible so the blue focus ring shows. That
      ring is a deliberate difference from Omarchy's default and it deserves a
      frame.
- [ ] **10 — the lock screen.** `session_lock_blur` is on, so the desktop is
      still there, frosted. Run the capture from a background shell, since you
      cannot type while locked:

      ```sh
      (sleep 6; grim docs/media/10-lock.png) & omarchy-shell lock lock
      ```

      If the compositor refuses to capture while locked, skip this one rather
      than shipping a black rectangle.
- [ ] **11 — terminals at full alpha.** One terminal with a code file or a diff
      open. Terminals are exempt from compositor blur here, so the water behind
      them stays sharp while the text stays fully opaque — that contrast against
      the frosted shell surfaces is the whole point of the exemption.
- [ ] **12 — the pair.** For the auto-appearance story: shot 01's exact window
      arrangement, captured once under `Apple Glass` and once under
      `Apple Glass Light` (`omarchy theme set "Apple Glass Light"`), so the two
      READMEs can show the same desktop at 8am and at 10pm. Set the theme back
      afterwards, or let `omarchy-auto-appearance` do it.

## Afterwards

- [ ] Replace or keep `preview.png` as the single top-of-README image; put the
      rest in a `## Gallery` section.
- [ ] Add the same 12 to `apple-glass-light`, under its own theme.
- [ ] The 01 / 02 pair and the 03 clip are also what an r/unixporn post needs.
