{
  description = "template machine flake for my system configurations";

  outputs = { self }: {
    templates.default = {
      path = ./default;
      description = "template machine flake for my system configurations";
      welcomeText = ''
        ## Things you should do now
        - remove any outputs and inputs that are irrelevant for this configuration (e.g. nix-darwin)
        - update everything with a "TODO" comment (e.g. `description`)
      '';
    };
  };
}
