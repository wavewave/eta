{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let

  config = self: super: {
           };
  haskellPackages = pkgs.haskellPackages.override { overrides = config; }; 
    #haskell.packages.ghc7103.override { overrides = config; };
    #haskell.packages.ghc7103.override {
    #  overrides = import ./lts-6-27.nix { inherit pkgs stdenv; };
    #};

  hsenv = haskellPackages.ghcWithPackages (p: with p;
            [ aeson alex array base bytestring Cabal digest blaze-builder extra
              containers cpphs deepseq directory
              exceptions filepath ghc-paths happy haskeline hpc mtl path
              path-io process shake stdenv text time transformers turtle
              unix unix-compat zip

              shake parsec network-uri HTTP
            ]);

in

stdenv.mkDerivation {
  name = "eta-dev";
  buildInputs = [ hsenv jdk ];
}

