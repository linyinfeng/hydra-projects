{ nixpkgs, declInput, projectName }:

let
  pkgs = builtins.trace <nixpkgs> (import nixpkgs {});
  forceDrv = file: pkgs.runCommand "spec.json" {} ''
    install --mode=444 "${file}" $out
  '';
  projects = {
    "dotfiles" = forceDrv ./projects/dotfiles.json;
  };
  jobsets = projects.${projectName};
in
{
  inherit jobsets;
}
