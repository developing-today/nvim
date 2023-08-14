{
  description = "My own Neovim flake with nightly overlay";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };
  outputs = { self, nixpkgs, neovim-nightly-overlay }: let
      system = "x86_64-linux";
      overlay = neovim-nightly-overlay.overlay;
      pkgs = import nixpkgs { system = system; overlays = [ overlay ]; };
    in
    {
      packages.${system}.default = pkgs.neovim-nightly;
      apps.${system}.default = {
        type = "app";
        program = "${pkgs.neovim-nightly}/bin/nvim";
      };
    };
}
