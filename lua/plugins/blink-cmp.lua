local M = {}
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
M.setup = function()
  require("blink.cmp").setup({
    keymap = {
      preset = 'default',
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide' },
      ['<CR>'] = { 'select_and_accept' ,'fallback'},
      ['<C-p>'] = { 'select_prev', 'fallback' },
      ['<C-n>'] = { 'select_next', 'fallback' },
      ['<Tab>'] = { 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
    },
    
    
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-cmp-copilot",
          score_offset = 100,
        async = true,
          transform_items = function(_, items)
            local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
            local kind_idx = #CompletionItemKind + 1
            CompletionItemKind[kind_idx] = "Copilot"
            for _, item in ipairs(items) do
              item. kind = kind_idx
            end
            
            return items
          end,
        },
      },
    },
    
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
      
      kind_icons = {
        Copilot = "",
        Text = '󰉿',
        Method = '󰊕',
        Function = '󰊕',
        Constructor = '󰒓',
        Field = '󰜢',
        Variable = '󰆦',
        Property = '󰖷',
        Class = '󱡠',
        Interface = '󱡠',
        Struct = '󱡠',
        Module = '󰅩',
        Unit = '󰪚',
        Value = '󰦨',
        Enum = '󰦨',
        EnumMember = '󰦨',
        Keyword = '󰻾',
        Constant = '󰏿',
        Snippet = '󱄽',
        Color = '󰏘',
        File = '󰈔',
        Reference = '󰬲',
        Folder = '󰉋',
        Event = '󱐋',
        Operator = '󰪚',
        TypeParameter = '󰬛',
      },
    },
    
    completion = {
      -- menu = {
      --   draw = {
      --     columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
      --   },
      -- },
      menu = {
        draw = {
            -- We don't need label_description now because label and label_description are already
            -- combined together in label by colorful-menu.nvim.
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            components = {
                label = {
                    text = function(ctx)
                        return require("colorful-menu").blink_components_text(ctx)
                    end,
                    highlight = function(ctx)
                        return require("colorful-menu").blink_components_highlight(ctx)
                    end,
                },
            },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
    },
  })
  
  -- 自定义高亮颜色
  M.setup_highlights()
end

M.setup_highlights = function()
  local highlights = {
    BlinkCmpKindText = { fg = "#a6e3a1" },
    BlinkCmpKindMethod = { fg = "#89b4fa" },
    BlinkCmpKindFunction = { fg = "#89b4fa" },
    BlinkCmpKindConstructor = { fg = "#f9e2af" },
    BlinkCmpKindField = { fg = "#eba0ac" },
    BlinkCmpKindVariable = { fg = "#cba6f7" },
    BlinkCmpKindClass = { fg = "#f38ba8" },
    BlinkCmpKindInterface = { fg = "#fab387" },
    BlinkCmpKindModule = { fg = "#94e2d5" },
    BlinkCmpKindProperty = { fg = "#f5c2e7" },
    BlinkCmpKindKeyword = { fg = "#cdd6f4" },
    BlinkCmpKindSnippet = { fg = "#a6e3a1" },
    BlinkCmpKindCopilot = { fg = "#6e738d" },
    BlinkCmpKindColor = { fg = "#f38ba8" },
    BlinkCmpKindFile = { fg = "#89b4fa" },
    BlinkCmpKindReference = { fg = "#f9e2af" },
    BlinkCmpKindFolder = { fg = "#89b4fa" },
    BlinkCmpKindEnum = { fg = "#fab387" },
    BlinkCmpKindConstant = { fg = "#eba0ac" },
  }
  
  for group, colors in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, colors)
  end
end

-- 自动执行 setup
M.setup()

return M
