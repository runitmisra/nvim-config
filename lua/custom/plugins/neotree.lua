return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    opts = {
      close_if_last_window = "true",
      window = {
        mappings = {
          ["l"] = "open",
        },
      },
      filesystem = {
        hijack_netrw_behaviour = "open_default",
      },
    },
  },
}
