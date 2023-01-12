{
  description = "system configuration for ..."; # TODO: update me! (e.g. the hostname)

  inputs = {
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs.url = "github:NixOS/nixpkgs/..."; # TODO: update me! (e.g. `nixos-22.11`, `nixpkgs-22.11-darwin`)

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/..."; # TODO: update me! (e.g. `nixos-unstable`, `nixpkgs-unstable`)

    sys.url = "github:sersorrel/sys";
    sys.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs: let
    system = "..."; # TODO: update me! (e.g. `x86_64-linux`, `aarch64-darwin`)
  in {
    darwinConfigurations.default = inputs.darwin.lib.darwinSystem {
      inherit system;
      inputs = { inherit inputs; };
      modules = [ inputs.sys.darwinModules.default ({ config, ... }: {
        _module.args = { unstable = import inputs.nixpkgs-unstable { inherit system; inherit (config.nixpkgs) config overlays; }; };
        system.stateVersion = "4";
      }) ];
    };
    homeConfigurations.default = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      extraSpecialArgs = { inherit inputs; };
      modules = [ inputs.sys.homeModules.default ({ config, ... }: {
        _module.args = { unstable = import inputs.nixpkgs-unstable { inherit system; inherit (config.nixpkgs) config overlays; }; };
        home.homeDirectory = "..."; # TODO: update me!
        home.username = "..."; # TODO: update me!
        home.stateVersion = "22.11";
      }) ];
    };
    nixosConfigurations.default = inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [ inputs.sys.nixosModules.default ({ config, ... }: {
        _module.args = { unstable = import inputs.nixpkgs-unstable { inherit system; inherit (config.nixpkgs) config overlays; }; };
        system.stateVersion = "22.11";
      }) ];
    };
  };
}
