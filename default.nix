{ nixpkgs, declInput, projectName }:

let
  pkgs = builtins.trace <nixpkgs> (import nixpkgs {});
  forceDrv = file: pkgs.runCommand "spec.json" {} ''
    install --mode=444 "${file}" $out
  '';
  jobsets = forceDrv ./projects/${projectName}.json;
in
{
  inherit jobsets;
}
