#! /usr/bin/env ruby

require 'rubygems'
require 'optparse'

REC = File.dirname(__FILE__)
PARENT  =File.expand_path(File.dirname(__FILE__))+"/../temp"

require_relative 'avd'
require_relative 'troyd'
require_relative 'uid'
require_relative 'cmd'
require_relative 'act'
require_relative 'util'
include Commands

if ARGV.length < 2
  puts "target file and dev_id are not given"
  exit
end

apk = ARGV[0]
dev_id = ARGV[1]
ADB.device dev_id

# rebuild and install troyd
pkg = AAPT.pkg apk
Troyd.setenv
Troyd.rebuild pkg

# resign and install target app
# ADB.uninstall pkg
shareduid = pkg + ".shareduid.apk"
Uid.change_uid(apk, shareduid)
resigned = pkg + ".resigned.apk"
Resign.resign(shareduid, resigned)
# system("rm -f #{shareduid}")
# ADB.install resigned
APKS = REC + "/../apks"
system("mv #{resigned} #{APKS}/#{pkg}.apk")

puts "Done! Modified APK is stored at #{APKS}/#{pkg}.apk"