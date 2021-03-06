{
  description = ''Wrapper for libnetpbm'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."netpbm-master".dir   = "master";
  inputs."netpbm-master".owner = "nim-nix-pkgs";
  inputs."netpbm-master".ref   = "master";
  inputs."netpbm-master".repo  = "netpbm";
  inputs."netpbm-master".type  = "github";
  inputs."netpbm-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."netpbm-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}