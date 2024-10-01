{
  description = "Pokemon Emerald decompilation project development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";

    porymap.url = "github:frothymarrow/porymap";
    porymap.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    porymap,
  }: let
    system = "aarch64-darwin";

    pkgs = import nixpkgs {
      inherit system;
    };
  in {
    formatter.${system} = pkgs.alejandra;

    devShells.${system}.default = pkgs.mkShell {
      packages = [
        porymap.packages.${system}.default
        pkgs.gcc-arm-embedded
        pkgs.pkg-config
        pkgs.libpng
      ];
    };
  };
}
