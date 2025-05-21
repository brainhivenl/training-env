{
  pkgs,
  ...
}:

{
  packages = with pkgs; [
    nixd
    k3d
    ko
    skaffold
    kubernetes-helm
    kubectl
    postgresql_16
  ];

  languages = {
    go.enable = true;
  };

  tasks."k3d:setup" = {
    exec = "(k3d cluster list | grep training) || k3d cluster create -c config.yaml && sed -i 's/127\.0\.0\.1/k3d-training-server-0/g' kubeconfig";
    before = [ "devenv:enterShell" ];
  };

  env.KUBECONFIG = "kubeconfig";
}
