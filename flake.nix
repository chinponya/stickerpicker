{
  inputs = {
    pypi-deps-db = {
      url = "github:DavHau/pypi-deps-db";
      flake = false;
    };
    mach-nix = {
      url = "github:DavHau/mach-nix/3.5.0";
      inputs.pypi-deps-db.follows = "pypi-deps-db";
    };
  };

  outputs = { self, nixpkgs, mach-nix, ... }: {
    devShell.x86_64-linux = let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      mach-nix-package = import mach-nix {
        inherit pkgs;
        python = "python39Full";
      };
    in mach-nix-package.mkPythonShell {
      requirements = ''
        ${builtins.readFile ./requirements.txt}
      '';
    };
  };
}
