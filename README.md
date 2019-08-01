A3E-customized
=====

A customized version of A3E(-Depth_first) used in the paper [An Empirical Study of Android Test Generation Tools in Industrial Cases](https://dl.acm.org/citation.cfm?id=3240465). See [here](https://github.com/tanzirul/a3e) for the original version by Tanzirul Azim. Some implementations are still ad-hoc and improvements are welcomed.


Automatic Android App Explorer (A3E) is an automated GUI testing utility for android applications. 
It is based on [Troyd][tr] GUI testing framework. It provides two kinds of GUI exploration strategy, 
Depth-first Exploration and Targeted Exploration. To learn further, visit a3e [homepage][hm].

[hm]: http://spruce.cs.ucr.edu/a3e
[tr]: https://github.com/plum-umd/troyd

Publications
------------

* [Targeted and Depth-first Exploration for Systematic Testing of Android Apps][a3e]
  Tanzirul Azim and Iulian Neamtiu.
  Department of Computer Science & Engineering, University of California, Riverside, Sep 2013.

[a3e]: http://www.cs.ucr.edu/~neamtiu/pubs/oopsla13azim.pdf

Requirements
------------
Note: JDK 1.7 and greater is required.
To get started, install [Android SDK][sdk] first and set paths to Android
base tools, e.g., adb, aapt, etc.  You can do so by adding the followings
to your profile:

    ANDROID_HOME=$HOME/sdk # your own path here!
    export ANDROID_HOME

    PATH=$ANDROID_HOME/tools:$PATH
    PATH=$ANDROID_HOME/platform-tools:$PATH
    export PATH

The main scripts are written in [Ruby][rb] and require [RubyGems][gem], a Ruby
package manager, and [Nokogiri][xml], an XML library to manipulate
manifest files.  This tool is tested under Ruby 2.0 and Android 4.4.2.

[rb]: http://www.ruby-lang.org/
[sdk]: http://developer.android.com/sdk/index.html
[gem]: http://rubygems.org/
[xml]: http://nokogiri.org/

Depth-first exploration
-----------------------

To run depth-first exploration use the command

    $ ruby bin/rec.rb target.apk --no-rec -loop

This script starts an emulator (if no real device is connected), rebuilds
Troyd, a controller app, resigns the app under test, installs both the
controller and target apps on the emulator or real device; launches the app,
and then starts ripping the application. It then sends valid commands to the 
app interface and explore the app in a depth-first fashion. 

    
Targeted exploration
--------------------

Coming.

Record and Replay
--------------------
Feature enabled. Will update details soon.

Static Activity Transition Graph Creation
---------------------------------------------
Modify the following parameter in the wala.properties file as per your system. For example in MacOS X this path may be something
similar:

	java_runtime_dir = /Library/Java/JavaVirtualMachines/jdk1.7.0_25.jdk/Contents/Home/jre/lib

This is actually the path that contains the rt.jar or classes.jar file. This file contains the initial java classes that are loaded by the JVM when a java program runs.

After that, run 
	
	./apk2satg.sh your_apk.apk
	
The procedure may take several minutes depending on the size of the apk. The output will be two files,

your_apk.apk.g.xml: This xml file will contain the relation between parent and child activties.
your_apk.apk.g.dot: This dot file is for visualization purpose.

A3E VM
------------
To test a3e on your computer without needing to setup everything you can use this ubuntu 14.04 [VM] on virtual box. Make Sure you assign 2 GB RAM to the VM and enable 2D/3D acceleration for smooth use.

[VM]: https://www.dropbox.com/s/dzsh9u80yk8iodx/A3EVM.vdi.zip?dl=0
User Name: a3e
Password: a3e_ucr

Open terminal cd into ~/a3e and run following command to test it with Amazon,

	$ ruby bin/rec.rb aut/Amazon-33.apk --no-rec -loop

 
