{ fetchFromGitHub
, lib
, stdenv
, python3
, sassc
, sass
}:

stdenv.mkDerivation rec {
  pname = "mint-themes";
  version = "2.0.2";

  src = fetchFromGitHub {
    owner = "linuxmint";
    repo = pname;
    # they don't exactly do tags, it's just a named commit
    rev = "695285c7240c3ed63dd18562bbe169542b30c319";
    hash = "sha256-GL3kCl1WpeoBiZGN7otNrQvJJMdG8Dc6A1g2f49Ywy4=";
  };

  nativeBuildInputs = [
    python3
    sassc
    sass
  ];

  preBuild = ''
    patchShebangs .
  '';

  installPhase = ''
    mkdir -p $out
    mv usr/share $out
  '';

  meta = with lib; {
    homepage = "https://github.com/linuxmint/mint-themes";
    description = "Mint-X and Mint-Y themes for the cinnamon desktop";
    license = licenses.gpl3; # from debian/copyright
    platforms = platforms.linux;
    maintainers = teams.cinnamon.members;
  };
}
