{ config, pkgs, ... }:

{
  imports =
    [
    ];

  # boot.kernelPackages = pkgs.linuxPackages_latest;

  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "fr";
    defaultLocale = "fr_FR.UTF-8";
  };

  time.timeZone = "Europe/Paris";

  services = {
    locate = {
      enable = true;
      period = "00 13 * * *";
    };

    openssh.enable = true;

    printing = {
      enable = true;
      drivers = [ pkgs.foomatic_filters ];
    };

    xserver = {
      enable = true;
      layout = "fr";
      xkbVariant = "oss";
      xkbOptions = "eurosign:e";

      displayManager.kdm.enable = true;
      desktopManager.kde4.enable = true;
    };

    virtualboxHost.enable = true;

    redis = {
      enable = true;
      bind = "127.0.0.1";
      extraConfig = "maxclients 950";
    };
  };

  fonts = {
    enableCoreFonts = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs ; [
      liberation_ttf
      ttf_bitstream_vera
      dejavu_fonts
      terminus_font
      bakoma_ttf
      clearlyU
      cm_unicode
      andagii
      bakoma_ttf
      inconsolata
      gentium
      vistafonts
      ubuntu_font_family
    ];

  };

  nixpkgs.config = {
    allowUnfree = true;
    firefox.enableAdobeFlash = true;
  };

  environment = {
    systemPackages = with pkgs; [
      # Tools
      htop iotop wget tree tmux silver-searcher git

      # X
      oxygen-gtk2 oxygen-gtk3
      firefoxWrapper

      # Misc
      fish aspellDicts.fr
    ] ++ (with kde4; [ kmix yakuake okular ksshaskpass kwalletmanager ark kdeplasma_addons kscreensaver gwenview ksnapshot ]);

    variables.EDITOR = "emacs";

    shellInit = ''
      export GTK_PATH=$GTK_PATH:${pkgs.oxygen_gtk}/lib/gtk-2.0
      export GTK2_RC_FILES=$GTK2_RC_FILES:${pkgs.oxygen_gtk}/share/themes/oxygen-gtk/gtk-2.0/gtkrc
    '';
  };

  # Delete temp files after 10 days
  systemd.tmpfiles.rules = [ "d /tmp 1777 root root 10d" ];


}
