{ lib
, stdenv
, fetchurl
, zstd
, source
}:

stdenv.mkDerivation {
  name = "proton-cachyos";
  version = "${source.base}-${source.release}-${source.build}";

  src = fetchurl {
    inherit (source) url hash;
  };

  nativeBuildInputs = [ zstd ];

  installPhase = ''
    tar -I zstd -xf $src
    mkdir -p $out/share/steam/compatibilitytools.d
    mv usr/share/steam/compatibilitytools.d/proton-cachyos $out/share/steam/compatibilitytools.d/
    ln -s $out/share/steam/compatibilitytools.d/proton-cachyos/files/lib/wine/x86_64-unix/*.so $out/share/steam/compatibilitytools.d/proton-cachyos/files/lib/wine/
  '';

  meta = with lib; {
    description = "CachyOS Proton build with additional patches and optimizations";
    homepage = "https://github.com/CachyOS/proton-cachyos";
    license = licenses.bsd3;
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ kimjongbing ];
  };
}
