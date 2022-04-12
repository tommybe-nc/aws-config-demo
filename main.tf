module "config" {
  source = "./modules/config"
}

resource "aws_security_group" "apache" {
  name        = "app-apache"
  description = "Apache security group"
  vpc_id      = var.VPC_ID
}

resource "aws_instance" "apache_1" {
  count = module.config.settings.apache_1.number_of_nodes

  subnet_id = var.subnet_ID
  vpc_security_group_ids = [
  aws_security_group.apache.id]
  ami           = data.aws_ami.centos.id
  instance_type = module.config.settings.apache_1.instance_type
  ebs_optimized = true

  ebs_block_device {
    delete_on_termination = false
    device_name           = "/dev/sdb"
    volume_type           = module.config.settings.apache_1.volume_type
    volume_size           = module.config.settings.apache_1.disk_size
  }

  tags = {
    Name     = "${module.config.settings.apache_1.tags.name}-${count.index}"
    Status   = module.config.settings.apache_1.tags.status
    Schedule = module.config.settings.apache_1.tags.schedule
    AppName  = module.config.settings.apache_1.tags.appname
    Relelase = module.config.settings.apache_1.tags.release
  }
  user_data = templatefile("apache-user-data.bash", {
    region = data.aws_region.current.name
  })
}

resource "aws_instance" "apache_2" {
  count = module.config.settings.apache_2.number_of_nodes

  subnet_id = var.subnet_ID
  vpc_security_group_ids = [
  aws_security_group.apache.id]
  ami           = data.aws_ami.centos.id
  instance_type = module.config.settings.apache_2.instance_type
  ebs_optimized = true

  ebs_block_device {
    delete_on_termination = false
    device_name           = "/dev/sdb"
    volume_type           = module.config.settings.apache_2.volume_type
    volume_size           = module.config.settings.apache_2.disk_size
  }

  tags = {
    Name     = "${module.config.settings.apache_2.tags.name}-${count.index}"
    Status   = module.config.settings.apache_2.tags.status
    Schedule = module.config.settings.apache_2.tags.schedule
    AppName  = module.config.settings.apache_2.tags.appname
    Relelase = module.config.settings.apache_2.tags.release
  }
  user_data = templatefile("apache-user-data.bash", {
    region = data.aws_region.current.name
  })
}

