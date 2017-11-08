# Class one::config
#
class one::config (
  $ssh_pub_key  = $one::ssh_pub_key,
  $ssh_priv_key = $one::ssh_priv_key_param,
){

  validate_string($ssh_pub_key)
  validate_string($ssh_priv_key)

  File {
    owner => 'oneadmin',
    group => 'oneadmin',
  }

  file { '/var/lib/one':
    ensure => directory,
    mode   => '0750',
  } ->

  file { '/var/lib/one/.ssh':
    ensure  => directory,
    mode    => '0700',
    recurse => true,
  } ->

  file { '/var/lib/one/.ssh/id_dsa':
    ensure  => file,
    content => $ssh_priv_key,
    mode    => '0600',
  } ->

  file { '/var/lib/one/.ssh/id_dsa.pub':
    ensure  => file,
    content => $ssh_pub_key,
    mode    => '0644',
  } ->

  file { '/var/lib/one/.ssh/authorized_keys':
    ensure  => file,
    mode    => '0644',
    content => $ssh_pub_key,
  } ->

  file { '/var/lib/one/.ssh/config':
    ensure => file,
    mode   => '0644',
    source => 'puppet:///modules/one/ssh_one_config',
  } ->

  file { '/var/lib/one/bin':
    ensure => directory,
    mode   => '0755',
  } ->

  file { '/var/lib/one/etc':
    ensure => directory,
    mode   => '0755',
  }
}
