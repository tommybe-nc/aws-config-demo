locals {
  file_prefix = "./${terraform.workspace}"
  workspace_path_yml = "${local.file_prefix}.yml"
  workspace_path_yaml = "${local.file_prefix}.yaml"
  workspace = fileexists(local.workspace_path_yml) ? file(local.workspace_path_yml) : fileexists(local.workspace_path_yaml) ? file(local.workspace_path_yaml) : yamlencode({})
  settings = yamldecode(local.workspace)
}

output "settings" {
  value = local.settings
}

