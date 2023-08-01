-- Map leader key to Space
vim.g.mapleader = " "


--[[
========== Install Plugins ==========
--]]
vim.cmd [[packadd packer.nvim]]
require('packer').startup(function(use)
  -- Packer
  -- Plugin manager managing itself managing plugins
  use 'wbthomason/packer.nvim'

  -- Gruvbox Colorscheme
  -- Making Neovim less ugly
  use "ellisonleao/gruvbox.nvim"
  vim.cmd [[colorscheme gruvbox]]

  -- Treesitter
  -- Proper syntax highlighting. Monkey brain like color text
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- Lualine
  -- Look at the pretty statusline! with useful features too
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  -- Telescope
  -- Godlike fuzzy finder with tons of builtin features
  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Autopairs
  -- Add closing brackets and quotes automatically so that I don't get carpel tunnel
  use "windwp/nvim-autopairs"

  -- LSP Zero
  -- An all-in-one LSP setup plugin because I am lazy (I know I don't use lazy plugin manager. Shut up)
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {                                      -- Optional
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.api.nvim_command, 'MasonUpdate')
        end,
      },
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'L3MON4D3/LuaSnip'},     -- Required
    }
  }

  -- Neodev
  -- LSP for Neovim's lua API making editing init.lua bareable
  use 'folke/neodev.nvim'

  -- Which Key
  -- Helpful popup at the bottom showing what the keymaps do because I forget
  use {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {}
    end
  }

  -- Gitsigns
  -- Shows me which lines were changed in git. Again, because I forget. Also hunk actions!
  use { "lewis6991/gitsigns.nvim" }



end)

--[[
========== Set Vim configuration options ========== 
--]]

-- Set relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Set highlight on current cursorline and cursorcolumn
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

-- Expand tabs to 4 spaces by default
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true

-- Better colors
vim.opt.termguicolors = true

-- Search options
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.joinspaces = true
vim.opt.smartcase = true
vim.opt.showmatch = true

-- Leave some lines when scrolling
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 3

-- Normal backspace
vim.opt.backspace = "indent,start,eol"

-- Split new windows to bottom and right only
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Menu
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"

-- Completion options
vim.opt.completeopt = 'menuone,noselect'

-- Faster updatetime
vim.opt.updatetime = 250

-- Turn on filetype plugins
vim.cmd[[filetype plugin on]]

-- Disable comments on pressing enter
vim.cmd[[autocmd FileType * setlocal formatoptions-=cro]]


--[[
========== Configure Plugins ========== 
--]]


-- Configure Treesitter
require'nvim-treesitter.configs'.setup{
  ensure_installed = { "lua", "c", "vim", "vimdoc", "go", "yaml", "json", "python" },
  highlight = {
    enable = true,
  },
}

-- Configure Lualine
require('lualine').setup {
  options = {
    theme = 'gruvbox',
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
  },
}


-- Configure Autopairs
require("nvim-autopairs").setup {}

-- Configure Neodev
require("neodev").setup({})


-- Configure LSP Zero
local lsp = require('lsp-zero').preset({})
local cmp = require('cmp')

cmp.setup({
  preselect = cmp.PreselectMode.None,
  mapping = {
    ['<Tab>'] = cmp.mapping.confirm({select = true}),
  },
})

lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({buffer = bufnr})
end)

-- Configure Lua Language server
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

-- Configure Python Language server
require('lspconfig').pyright.setup({})
lsp.setup()


-- Configure gitsigns
require('gitsigns').setup()

--[[
========== Configure Keymaps ========== 
--]]

local wk = require("which-key")

-- Keymaps for Telescope
local builtin = require('telescope.builtin')

wk.register({
  f = {
    name = "+[F]ind",
    f = { builtin.find_files, "Find Files" },
    g = { builtin.live_grep, "Find(grep) in current buffer" },
    b = { builtin.buffers, "Find open buffers" },
    r = { builtin.lsp_references, "Find references" },
  },
}, { prefix = "<leader>" })

-- Navigation

-- Remap for dealing with word wrap
-- No need to register this with which-key
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

