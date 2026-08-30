-- Apple Glass — the Liquid Glass surface treatment.
--
-- Loaded by default.hypr.omarchy *after* Omarchy's own looknfeel and window
-- rules, so everything here wins while this theme is current and is gone the
-- moment another theme is set. Nothing outside this theme directory changes.

local active_border_color = { colors = { "rgba(ffffffcc)", "rgba(ffffff40)" }, angle = 135 }
local inactive_border_color = "rgba(ffffff1f)"

hl.config({
  general = {
    -- A hairline rim rather than a frame: on glass the edge is a highlight.
    border_size = 1,
    gaps_in = 6,
    gaps_out = 12,

    col = {
      active_border = active_border_color,
      inactive_border = inactive_border_color,
    },
  },

  group = {
    col = {
      border_active = active_border_color,
      border_inactive = inactive_border_color,
      border_locked_active = active_border_color,
      border_locked_inactive = inactive_border_color,
    },
  },

  decoration = {
    -- rounding_power > 2 bends the corner into a squircle, the continuous
    -- curve macOS uses, instead of a plain circular quarter-arc.
    rounding = 14,
    rounding_power = 2.6,

    -- macOS window shadow: wide, soft, and dropped slightly downward.
    shadow = {
      enabled = true,
      range = 32,
      render_power = 3,
      offset = { 0, 8 },
      color = "rgba(0000006e)",
      color_inactive = "rgba(00000038)",
    },

    blur = {
      enabled = true,

      -- 20/4, picked by A/B screenshots against the live aquarium: 8/3 read
      -- as clear glass (the scene's shapes are already soft) and 12-16/3 as a
      -- light frost. 20/4 is the deep macOS-style material -- distant fish
      -- melt into the glass, large near ones still drift through as shapes.
      -- The 4th pass is the one real cost increase; size alone is free in
      -- dual-kawase.
      size = 20,
      passes = 4,
      new_optimizations = true,

      -- Blur behind every surface regardless of its own alpha, so an app that
      -- paints its own translucency (Ghostty, Chromium) gets the material too.
      ignore_opacity = true,

      -- Every pane blurs straight through to the aquarium (bottom layer), not
      -- to the windows behind it: the whole desktop is glass over water. Also
      -- cheaper when windows stack, since translucency no longer compounds.
      xray = true,

      -- Tuned against the animated water, not a static wallpaper: the aquarium
      -- is already saturated, so vibrancy backs off from 0.28 -- at that level
      -- the panes glow blue instead of reading as neutral graphite glass.
      vibrancy = 0.18,
      vibrancy_darkness = 0.1,

      -- A trace of grain. Real frosted glass is never perfectly smooth, and
      -- the noise also hides banding -- but against a moving backdrop static
      -- grain shimmers, so it sits a step lower than it would over stills.
      noise = 0.02,
      -- Neutral contrast: boosting it made the caustic highlights pulse
      -- behind text as they drifted past.
      contrast = 1.0,
      brightness = 1.0,

      popups = true,
      popups_ignorealpha = 0.4,
      special = true,
    },
  },

  misc = {
    -- Glass over the desktop while locked, matching macOS's lock blur.
    session_lock_blur = true,
  },
})

-- Windows. Omarchy's defaults tag everything `default-opacity` and then apply
-- "0.985 0.96" -- nearly opaque, so blur never shows. Re-apply over that tag so
-- apps that already opted out (video, VMs, Steam, PiP, browsers) stay opaque.
o.window({ tag = "default-opacity" }, { opacity = "0.90 0.82" })

-- Terminals carry their glass in the terminal itself (window.opacity in this
-- theme's alacritty.toml, alpha in its foot.ini, background_opacity in its kitty.conf): the background is
-- translucent but glyphs stay at full alpha. So the compositor must NOT also
-- dim the surface, or the text fades along with it. Keep a whisper of dimming
-- on unfocused terminals. org.omarchy.agent is foot too (the Claude window).
-- no_blur keeps the aquarium crisp behind the glass: foot skips compositor
-- blur anyway (it hints its surface opaque), which is where this look comes
-- from; kitty declares real alpha, so without this rule the 20/4 material
-- frosts its backdrop into a featureless slab that reads as an opaque window.
o.window({ class = "^(Alacritty|foot|footclient|kitty|org\\.omarchy\\.agent)$" }, { opacity = "1.0 0.95", no_blur = true })

-- Shell surfaces. These are layer-shell, not windows, so they need blur turned
-- on per namespace. Listed explicitly: omarchy-background must NOT be blurred
-- (it *is* the backdrop), and the drag/dismiss helper layers have nothing to
-- show. ignore_alpha skips the fully-transparent margins around a card, which
-- would otherwise render as a floating blurred rectangle.
local glass_surfaces = table.concat({
  "omarchy-bar",
  "omarchy-menu",
  "omarchy-notifications",
  -- Notification center sidebar (phmatray.notification-center shell plugin).
  "phmatray-notification-center",
  -- Control center sidebar (macarchy.control-center shell plugin).
  "macarchy-control-center",
  "omarchy-osd",
  "omarchy-polkit",
  "omarchy-reminders",
  "omarchy-clipboard",
  "omarchy-emojis",
  "omarchy-image-selector",
  "omarchy-keyboard-panel",
  "omarchy-network-qr",
  "omarchy-network-speedtest",
  "omarchy-disk-speedtest",
  "omarchy-speed-test",
  -- The Cmd+Tab app switcher (macarchy.switcher shell plugin).
  "macarchy-switcher",
  -- The dock, when one is running. Harmless when it is not.
  "nwg-dock",
}, "|")

hl.layer_rule({
  match = { namespace = "^(" .. glass_surfaces .. ")$" },
  blur = true,
  blur_popups = true,
  ignore_alpha = 0.1,
})
