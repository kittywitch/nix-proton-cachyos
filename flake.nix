{
  description = "Proton CachyOS build";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      source = builtins.fromJSON (builtins.readFile ./source.json);
    in {
      packages.${system} = {
        proton-cachyos = pkgs.callPackage ./default.nix {
          inherit source;
        };
        default = self.packages.${system}.proton-cachyos;
      };
    };
}
