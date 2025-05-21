local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font_size = 13
config.font = wezterm.font_with_fallback {
  'JetBrainsMonoNL Nerd Font',
  'Noto Sans Mono', -- Fallback for missing glyphs
  'Monospace', -- Final fallback
}
--config.harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' }

--COLORS:
--require the colorschem
local colorscheme = require 'colorschemes'
--set neovim colorscheme same as system
local neovim_colorscheme = colorscheme
--change background
neovim_colorscheme.background = '#1a1b26'
config.colors = colorscheme
--local neovim_background = '#1a1b26'

--config.color_scheme = 'tokyonight'
--config.color_scheme = "Belafonte Night"
--config.color_scheme = 'Abernathy'

--function to change color when we use nvim
local function update_background(window, pane)
  local process_name = pane:get_foreground_process_name()
  if process_name:find 'nvim' then
    -- neovim terminal
    window:set_config_overrides {
      window_background_opacity = 0.85, --0.9
      colors = neovim_colorscheme,
      force_reverse_video_cursor = true, -- Default is false, but ensure it’s not true
      window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
      },
    }
  else
    -- normall terminal
    window:set_config_overrides {
      window_background_opacity = 0.7,
      colors = colorscheme, -- Reset to the original colorscheme
      force_reverse_video_cursor = true, -- Default is false, but ensure it’s not true
    }
  end
end
-- Event handler for when a pane is created or updated
wezterm.on('update-status', function(window, pane)
  update_background(window, pane)
end)

--WALLPAPER:
--config.window_background_image = '/home/arshia/wallpapers/windows-1920x1080.png'
config.window_background_opacity = 0.5

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.enable_wayland = false
config.adjust_window_size_when_changing_font_size = false

-- Hide the title bar
--config.window_decorations = 'NONE'
config.window_decorations = 'RESIZE'

--KEYBINDS
config.keys = {
  {
    mods = 'CTRL|ALT',
    key = '2',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    mods = 'CTRL|ALT',
    key = '3',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
}

return config
