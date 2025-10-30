{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  env.ALEMBIC_CONFIG = "${config.devenv.root}/backend/alembic.ini";

  # https://devenv.sh/packages/
  packages = [
    pkgs.git
    pkgs.nixd
    pkgs.nixfmt
  ];

  # https://devenv.sh/languages/
  languages = {
    python = {
      enable = true;
      directory = "${config.devenv.root}/backend";
      uv = {
        enable = true;
        sync.enable = true;
      };
      venv = {
        enable = true;
        quiet = true;
      };
    };

    javascript = {
      enable = true;
      directory = "${config.devenv.root}/frontend";
      npm.enable = true;
    };
  };

  tasks."db:migrate" = {
    exec = "alembic upgrade head";
    status = "alembic check";
  };

  # https://devenv.sh/processes/
  # processes.dev.exec = "${lib.getExe pkgs.watchexec} -n -- ls -la";
  processes = {
    "backend" = {
      exec = "flask --app main run --debug";
      cwd = "${config.devenv.root}/backend";
    };
  };

  # https://devenv.sh/services/
  services.postgres = {
    enable = true;
    listen_addresses = "localhost";
    port = 5432;
    initialDatabases = [
      {
        name = "monsters";
        user = "user";
        pass = "password";
      }
    ];
  };

  # https://devenv.sh/git-hooks/
  # git-hooks.hooks.shellcheck.enable = true;

  # See full reference at https://devenv.sh/reference/options/
}
