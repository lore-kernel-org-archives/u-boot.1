Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A64DC36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 18:47:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5F9982A76;
	Sat,  5 Apr 2025 20:46:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1743878813;
	bh=1ZGUUlLNCxVIWoHyU3eSAJifTOD1fHDfFPkFu1JBeJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TrpTeHcbmGO7o5U2dQcQ78E/eKd88fHALFU8uWOJksKcDw3/3ixRQbWmzEE21//cW
	 kgXsQcYMQMWz7sBVxPksw+8Co1dVPHKR9Zykbti6Of6YMB9OhYJtJeEAK22Y5CVVFV
	 5i9PyrY5IADzw0OzXhK/5yAsBWzzU/RrJjWzzjen4S4QSs00C4Y5gFYnUlkNgzzT1Q
	 DjC+NFiwroPf7RHDENd25gE00A2SkzDz2noDNtG3lpEL9I4jkXWOswycGSOaCYtpFy
	 mUuwqIlYX9lVFfY7zJk2JiuvG3+1uWy5hvM+CWIbDY77lmDIRV5ESRtwRi6l/LCXPH
	 N0Z3ypc9JpyIg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FCB482AC2; Sat,  5 Apr 2025 20:46:52 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 284DF82AEF
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 20:46:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="T8H6YmQg"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9294310252BC3; 
 Sat,  5 Apr 2025 20:46:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1743878808; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=1ZGUUlLNCxVIWoHyU3eSAJifTOD1fHDfFPkFu1JBeJU=;
 b=T8H6YmQgHTIxxl8JmyyIYI9UfC03ll0C87OsyUZMraBTWVvRSINqIIOILcGtAUJfJBJ4eL
 iJJagyOQh9aoa+xIQRzuskZEqQRpWGmBRE0Puz3bZvJ6CVDxx3ava0qaXFjoId1QQuEY5X
 eDUB3aGm1+JPwu+WUeHGLRBLwF2KmOYEsnT+MKtm4tRV3/2xiyLgRFYWCpx2U8KV6jFVej
 HP2SijJJEImkyZsqe1A4qd5ZS2VWOV2dmfosR1knS2OWCzjiFQBfMLuWeQ+IRuYQ9+DJ9J
 XjPlYYwfi/YHps+9YPQ06EWxG/c+PkJUEMaR6CyEL5HH6anFjElNqmwyA+e9YQ==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@nabladev.com>, Heiko Schocher <hs@denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Greg Malysa <malysagreg@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 6/8] [RFC] CI: add U-Boot testing on real HW with tbot
Date: Sat,  5 Apr 2025 20:46:24 +0200
Message-Id: <20250405184626.22377-7-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250405184626.22377-1-hs@denx.de>
References: <20250405184626.22377-1-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Heiko Schocher <hs@nabladev.com>

add U-Boot tests on real hardware with tbot, which is started
from gitlab CI (no idea where it runs).

Currently one board is implemented (imx8qxp based cxg3 board).

This is a good example, as we need to get some binary blobs
for the build to get a working bootloader binary. This blobs
are stored in the tftp directory on the lab host, to which the
hardware is connected to. Tbot copies them from the lab host
to the CI host.

After build has finished, tbot copies the resulting bootloader
binaries to the lab host where with, the help of USB SDP bootmode
and uuu tool, the new flash.bin image is booted, and with USB
fastboot mode flashed into the emmc. After that worked, bootmode
is switched to emmc and the new flash.bin gets bootet (and tbot
checks the bootmode output, so we can be sure, that really the
new image boots from the correct bootdevice). A simple tbot
testcase for a ping over ethernet is done and ut command is called.

After that the test/py framework is started (from the CI host),
no external scripts are necessary for this, as all "scripts"
needed for this framework are created from tbot at runtime.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
Signed-off-by: Heiko Schocher <hs@denx.de>
---

 MAINTAINERS                                   |   5 +
 tbottesting/README.md                         | 323 ++++++++++++++++++
 tbottesting/boardtestconfig.py                |  18 +
 tbottesting/boardtests.py                     |  50 +++
 tbottesting/preparetbot.sh                    |   5 +
 tbottesting/tbotboardtests.py                 | 127 +++++++
 tbottesting/tbotconfig-hs/boardspecific.py    | 111 ++++++
 tbottesting/tbotconfig-hs/hs/README.cxg3      |  28 ++
 tbottesting/tbotconfig-hs/hs/args/argsbase    |  11 +
 tbottesting/tbotconfig-hs/hs/args/argshs      |   1 +
 .../tbotconfig-hs/hs/args/argshs-github-ci    |   7 +
 .../tbotconfig-hs/hs/args/argshs-noeth        |   3 +
 .../tbotconfig-hs/hs/args/argshs-noeth-ssh    |   5 +
 tbottesting/tbotconfig-hs/hs/cxg3.ini         | 106 ++++++
 tbottesting/tbotconfig-hs/hs/tbot.ini         | 117 +++++++
 tbottesting/tbotconfig-hs/interactive.py      |  59 ++++
 tbottesting/tbotconfig-hs/labcallbacks.py     |  76 +++++
 tbottesting/tbotconfig-hs/tc_cxg3.py          |  82 +++++
 18 files changed, 1134 insertions(+)
 create mode 100644 tbottesting/README.md
 create mode 100644 tbottesting/boardtestconfig.py
 create mode 100644 tbottesting/boardtests.py
 create mode 100755 tbottesting/preparetbot.sh
 create mode 100644 tbottesting/tbotboardtests.py
 create mode 100644 tbottesting/tbotconfig-hs/boardspecific.py
 create mode 100644 tbottesting/tbotconfig-hs/hs/README.cxg3
 create mode 100644 tbottesting/tbotconfig-hs/hs/args/argsbase
 create mode 100644 tbottesting/tbotconfig-hs/hs/args/argshs
 create mode 100644 tbottesting/tbotconfig-hs/hs/args/argshs-github-ci
 create mode 100644 tbottesting/tbotconfig-hs/hs/args/argshs-noeth
 create mode 100644 tbottesting/tbotconfig-hs/hs/args/argshs-noeth-ssh
 create mode 100644 tbottesting/tbotconfig-hs/hs/cxg3.ini
 create mode 100644 tbottesting/tbotconfig-hs/hs/tbot.ini
 create mode 100644 tbottesting/tbotconfig-hs/interactive.py
 create mode 100644 tbottesting/tbotconfig-hs/labcallbacks.py
 create mode 100644 tbottesting/tbotconfig-hs/tc_cxg3.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 042d3f6160..90a54deedb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1675,6 +1675,11 @@ F:	cmd/broadcom/chimp_boot.c
 F:	cmd/broadcom/nitro_image_load.c
 F:	cmd/broadcom/chimp_handshake.c
 
+TBOTTEST
+M:	Heiko Schocher <hs@nabladev.com>
+S:	Maintained
+F:	tbottesting/*
+
 TDA19988 HDMI ENCODER
 M:	Liviu Dudau <liviu.dudau@foss.arm.com>
 S:	Maintained
diff --git a/tbottesting/README.md b/tbottesting/README.md
new file mode 100644
index 0000000000..c36e089b64
--- /dev/null
+++ b/tbottesting/README.md
@@ -0,0 +1,323 @@
+# testing U-Boot with tbot
+
+This subdirectory contains a full tbot test setup for
+building, installing and running U-Boot tests in
+the U-Boot shell on the hardware. The setup here in this
+subdirectory is used with our CI in gitlab, but the same
+code runs at for example my u-boot repo @github:
+
+https://github.com/hsdenx/u-boot-test/actions
+
+(with an additional patch which configures github workflows)
+
+and at least, as tbot is a tool, you can start from shell, so of
+course you can simply call:
+
+	$ python3 boardtests.py --usetbotflags
+
+to run the same steps as gitlab CI do, which is very useful for
+testing your stuff before pushing it to your CI. So you can use
+all of this for your daily work and automate a lot of your boring
+developers task, and get the CI integration for free!
+
+Look into
+
+	tbottest/tbotconfig/interactive.py
+
+where you find examples for all "interactive" testcases, which means
+you can call:
+
+	(ubtestenv) hs@asuslap:tbottesting  [tbottesting] $ ./tbottest/newtbot_starter.py @tbotconfig-hs/hs/args/argshs-github-ci tbotconfig-hs.interactive.uboot
+	[...]
+	│   ├─[cxg3-uboot] printenv end
+	│   │    ## end=end
+	│   ├─Entering interactive shell...
+	│   ├─Press CTRL+] three times within 1 second to exit.
+	 
+	U-Boot# 
+
+and you land in the U-Boot shell on the same hardware which your CI uses.
+
+Or, if setup, you land in linux shell on the board, build host shell, or
+
+in the kas-container shell if you have setup a yocto project build with kas
+tool (Yes, as tbot handles machines you have access to all of this machines
+and can automate on them whatever you need!).
+
+
+You find all boards which are integrated in our mainline tests here
+
+[boards](./boardtestconfig.py)
+
+which is a simple list of a dictionary, short explanation of the keys:
+
+[config options](#boards_config_options)
+
+| key                | description                                                                                                                    |
+| ---                | ---                                                                                                                            |
+| boardname          | Name of the board in your lab                                                                                                  |
+| ubootpatchsubpath  | subdir on your lab hosts tftp path for your board with downstream U-Boot patches, tbot copies them from lab host to build host |
+| binsubpath         | subdir on your lab hosts tftp path for your board with binary blobs, needed for full U-Boot build                              |
+| defconfig          | defconfig name for your board                                                                                                  |
+| resultbinaries     | list of binaries, tbot transfers after successful build to your lab hosts tftp directory                                      |
+| makelist           | U-Boot is builded with buildman, but may you want to call after that some make commands too, list them here                    |
+| install            | functionname, which installs U-Boot on the board                                                                               |
+| boottest           | functionname, which boots and tests the new installed U-Boot                                                                   |
+
+If you have a full working tbot setup, [boardtests.py](./boardtests.py)
+will make the following
+
+- create the build dir on build host
+- copy the binaries found on lab hosts tftpdirectory in subdirectory ```binsubpath```
+  to the build directory on the build host
+- copy downstream U-Boot patches found on lab hosts tftpdirectory in subdirectory ```ubootpatchsubpath```
+  to the U-Boot source directory on the build host, and apply them
+- build U-Boot with buildman
+- call make target defined in ```makelist``` if needed
+- copy resulting binaries defined in ```resultbinaries``` from build host builddir
+  to lab hosts tftp directory.
+- call tbot testcase name defined ```install``` for installing the new U-Boot image
+
+  example cxg3 board:
+  set bootmode USB SDP, load SPL / U-Boot with ```uuu``` tool enter ```fastboot``` mode
+  and install SPL/U-Boot image with ```uuu``` tool.
+
+- call tbot testcase name defined ```boottest``` for booting the new U-Boot image
+
+  example cxg3 board:
+  enter emmc bootmode and boot into U-Boot, make there a ```ping``` test and
+  start ```ut``` U-Boot command.
+
+- call U-Boot test framework (in u-boot:/test/py)
+
+
+# Adding new boards
+
+in theory it should be enough to add your board here:
+
+[boardconfig](./boardtestconfig.py)
+
+and add your tbotconfig in subdirectory [tbottesting}(.)
+see as an example [tbotconfig-hs](./tbotconfig-hs)
+
+Of course, you need to add your ssh secrets to github, so contact
+me.
+
+Heiko Schocher <hs@nabladev.com>
+
+Heiko Schocher <hs@emblux.org>
+
+If you have not yet a tbotconfig, there are 2 options:
+
+- Send me the board and I add it in my lab
+
+or
+
+- create a tbotconfig
+
+  may the easiest approach to copy above folder and
+  rename it too ```tbotconfig-foobar``` and make some adaptions, described in the
+  following sections. It may help if you read [1](https://tbot.tools) and [3](https://hsdenx.github.io/tbottest/quickstart.html)
+
+
+The following sections exaplain how to adapt ```tbotconfig-hs```
+subdirectory, but please do it in your own new created ```tbotconfig-foobar```!
+
+[!NOTE]
+May we can add a script which does this automagically.
+
+If you have any issues, feel free to contact me.
+
+## setup new boards
+
+give the board a name, lets say ```foobar```
+
+add your board now in
+
+tbottesting/boardtestconfig.py
+
+(copy and paste the lines 5-15)
+
+Add replace the old boardname ```cxg3``` with the new name ```foobar```
+
+[boardname](./boardtestconfig.py#L6)
+
+Adapt also there the U-Boot build configs, see table #boards_config_options
+
+so, that this fits with the needs for your board
+
+### adapt board config in tbot.ini
+
+Keep in mind, that you can add in ```tbot.ini``` as much boards as you want!
+The following chapters are only an example for one board in tbot.ini
+
+For full explanation read:
+
+[tbottest doc: tbot.ini](https://hsdenx.github.io/tbottest/generic.html#tbot-ini-sections)
+
+
+#### adapt lab host setup
+
+adapt section [LABHOST] in
+
+[LABHOST](./tbotconfig-hs/hs/tbot.ini)
+
+to your local lab host setup, see full doc:
+
+[tbottest doc: labhost setup](https://hsdenx.github.io/tbottest/generic.html#labhost)
+
+check that you have working ssh access to your lab host!
+
+#### adapt build host setup
+
+starting tbot from github means, that we use ```[BUILDHOST_local]```
+for our U-Boot build, so you do not need to change here in this
+section anything. But if you are interested, you can add as many
+build hosts here as you have (for example big machines which do
+for you a whole yocto project build...)
+
+[tbottest doc: build host setup](https://hsdenx.github.io/tbottest/generic.html#buildhost)
+
+#### setup serial console on lab host
+
+change in [tbot.ini](tbotconfig-hs/hs/tbot.ini#L67) ```PICOCOM_cxg3```
+to ```PICOCOM_foobar```
+
+and adapt the serial device in [tbot.ini](tbotconfig-hs/hs/tbot.ini#L69)
+
+If you do not want to use ```picocom``` see doc for:
+
+[tbottest doc: kermit](https://hsdenx.github.io/tbottest/generic.html#kermit-boardname)
+[tbottest doc: script](https://hsdenx.github.io/tbottest/generic.html#scriptcom-boardname)
+
+You do not need to adapt ```tbot.flags``` for this, as
+tbottest tries to autodetect the used terminal tool:
+
+[autodetect terminal tool](https://github.com/hsdenx/tbottest/blob/master/tbottest/labgeneric.py#L269)
+
+As you see in code, you can force it with setting it in ```tbot.flags```
+
+#### setup power off / on
+
+change in [tbot.ini](tbotconfig-hs/hs/tbot.ini#L67) ```SISPMCTRL_cxg3```
+to ```SISPMCTRL_foobar```
+
+and adapt the address in [tbot.ini](tbotconfig-hs/hs/tbot.ini#L79)
+
+If you do not have a sispmctrl based controller, see doc for other
+supported devices:
+
+[gpio](https://hsdenx.github.io/tbottest/generic.html#gpiopmctrl-boardname)
+[script](https://hsdenx.github.io/tbottest/generic.html#powershellscript-boardname)
+[tinkerforge](https://hsdenx.github.io/tbottest/generic.html#tf-boardname)
+
+replace section ```SISPMCTRL_foobar``` with the power controller
+you own. You do not need to adapt tbot.flags for this, as
+tbottest tries to autodetect the used power controller:
+
+[autodetect powercontroller](https://github.com/hsdenx/tbottest/blob/master/tbottest/labgeneric.py#L161)
+
+As you see in code, you can force it with setting it in ```tbot.flags```
+
+#### bootmode setup
+
+you can setup different bootmodes for your board with section
+
+[BOOTMODE_foobar](https://hsdenx.github.io/tbottest/generic.html#bootmode-boardname)
+
+example config:
+
+[bootmode](./tbotconfig-hs/hs/tbot.ini#L109)
+
+see therefore also below section labcallbacks.py
+
+#### ethernet setup
+
+see doc:
+
+[ethernet config](https://hsdenx.github.io/tbottest/generic.html#ipsetup-boardname-ethdevice-board)
+
+example for cxg3 board and ethernet device eth0:
+
+[ethernet](./tbotconfig-hs/hs/tbot.ini#L90)
+
+adapt it to your needs!
+
+#### U-Boot Environment setup
+
+You can define a board specific U-Boot Environment in section ```[TC]```
+in your boardname.ini file through key ```ub_env```, see as an example
+
+[U-Boot Environment](tbotconfig-hs/hs/cxg3.ini#L37)
+
+Setup there all stuff you need for your tests (may, you want to boot
+linux with different setups like tftp fitImage and boot with_nfs rootfs)
+
+pattern_lab_mode = re.compile('{lab mode.*}')
+
+### boardspecific code
+
+#### labcallbacks.py
+
+There you find the functions:
+
+cxg3_ub_install
+
+  -> execute the commands, which are needed to update U-Boot on your board
+
+  This functions is called from your [boardconfig](./boardtestconfig.py#L13)
+
+cxg3_ub_boot_and_test
+
+  -> boot installed U-Boot and test. Do here tests, you want to see
+     additionally.
+
+  This functions is called from your [boardconfig](./boardtestconfig.py#L14)
+
+So this both functions depends highly on your board! Hope this example helps!
+
+cxg3_setbootmode_usb
+
+  -> function which runs on lab host. Sets USB SDP bootmode
+
+  This functions is called through tbot flag ```bootmode:usb``` and
+  your [bootmode](./tbotconfig-hs/hs/tbot.ini#L109)
+
+cxg3_setbootmode_emmc
+
+  -> function which runs on lab host. Sets emmc bootmode
+
+  This functions is called through tbot flag ```bootmode:emmc``` and
+  your [bootmode](./tbotconfig-hs/hs/tbot.ini#L109)
+
+
+So this both functions depends highly on your lab setup!
+Hope this example helps!
+
+To be continued! Bugfixes, Ideas are welcome!
+
+# Ideas / Todo
+
+- test and fix errros
+-  add more than one lab
+- add more boards to the hs lab
+- implement for custodians the old patchwork ToDo list setup
+
+  There I had a tbot setup which I started in nightly cron job,
+  which downloaded all patches from my Patchwork ToDo list, checked
+  them with checpatch.pl script, applied it to current HEAD and
+  builded for all boards in the lab U-Boot, installed it and started
+  all tests. And optionally if the tests fail, start an automated
+  git bisect session and find out, which patch breaks!
+
+  For reference an old video on youtube how this worked 8 years ago:
+
+  https://www.youtube.com/watch?v=PhaYfqOrQOg
+
+# Links
+
+[1] https://tbot.tools
+
+[2] https://tbot.tools/recipes.html
+
+[3] https://hsdenx.github.io/tbottest/quickstart.html
diff --git a/tbottesting/boardtestconfig.py b/tbottesting/boardtestconfig.py
new file mode 100644
index 0000000000..b8b370dfd9
--- /dev/null
+++ b/tbottesting/boardtestconfig.py
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+import os
+import sys
+
+boards = [
+        {
+            "boardname" : "cxg3",
+            "tbotargs"  : "@tbotconfig/hs/args/argshs-github-ci",
+            "ubootpatchsubpath": "uboot-patches",
+            "binsubpath":"binaries",
+            "defconfig":"capricorn_cxg3",
+            "resultbinaries":["flash.bin"],
+            "makelist":["flash.bin"],
+            "install":"cxg3_ub_install",
+            "boottest":"cxg3_ub_boot_and_test",
+        },
+        ]
diff --git a/tbottesting/boardtests.py b/tbottesting/boardtests.py
new file mode 100644
index 0000000000..7dbb29dd9d
--- /dev/null
+++ b/tbottesting/boardtests.py
@@ -0,0 +1,50 @@
+#!/usr/bin/python3
+# SPDX-License-Identifier: GPL-2.0+
+
+# -*- coding: utf-8 -*-
+
+import inspect
+import os
+import sys
+currentdir = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
+sys.path.insert(0, currentdir + "/tbot")
+sys.path.insert(0, currentdir + "/tbottest")
+
+from tbot.newbot import main  # noqa: E402
+
+from boardtestconfig import boards as B
+
+if __name__ == "__main__":
+    """
+    Build, install and test U-Boot for all boards
+    """
+    failed = 0
+    success = 0
+    count = 0
+    tests = len(B)
+    orgargv = sys.argv.copy()
+    for b in B:
+        count += 1
+        print(f"--------- start test {b['boardname']} {count} / {tests} suc: {success} fail: {failed} ---------")
+        newargv = orgargv.copy()
+        newargv = newargv[1:]
+        newargv.append(b['tbotargs'])
+        newargv.remove("--usetbotflags")
+        newargv.append("-f")
+        newargv.append(f"boardname:{b['boardname']}")
+        newargv.append("tbotboardtests.tbottest_one_board")
+
+        try:
+            # call tbot
+            main(newargv)
+            print(f"test {b['boardname']} succeeded")
+            success += 1
+        except Exception as e:
+            print(f"test {b['boardname']} failed with exception " + str(e))
+            failed += 1
+
+    print(f"--------- tests {count} / {tests} suc: {success} fail: {failed} ---------")
+    if failed:
+        sys.exit(1)
+
+    sys.exit(0)
diff --git a/tbottesting/preparetbot.sh b/tbottesting/preparetbot.sh
new file mode 100755
index 0000000000..8465aa3626
--- /dev/null
+++ b/tbottesting/preparetbot.sh
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+wget -q https://github.com/hsdenx/tbottest/raw/master/scripts/create_setup.sh
+chmod 777 create_setup.sh
+./create_setup.sh
diff --git a/tbottesting/tbotboardtests.py b/tbottesting/tbotboardtests.py
new file mode 100644
index 0000000000..cbc8f2b57a
--- /dev/null
+++ b/tbottesting/tbotboardtests.py
@@ -0,0 +1,127 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+import os
+import sys
+
+import tbot
+
+from tbot.context import Optional
+from tbot.machine import linux
+from tbot.machine import board
+
+from tbottest.common.ubootbuild import UBBUILDMAN
+from tbotconfig import labcallbacks
+
+from boardtestconfig import boards as B
+
+@tbot.testcase
+def tbottest_install_board(b) -> int:  # noqa: D107
+    """
+    Install the new U-Boot image on the board b
+    """
+    try:
+        tbot.log.message(tbot.log.c(f"Install bootloader image").green)
+        funcname = b['install']
+        func = getattr(labcallbacks, funcname)
+        ret = func()
+        if ret != True:
+            tbot.log.message(tbot.log.c(f"calling bootloader install failed {b['install']} with {ret}").yellow)
+            return 1
+    except Exception as e:
+        tbot.log.message(tbot.log.c(f"calling bootloader install failed {b['install']} with exception " + str(e)).yellow)
+        return 1
+
+    return 0
+
+from tbot_contrib import uboot
+
+@tbot.testcase
+def run_testpy(b, bmcfg) -> None:
+    with tbot.ctx.request(tbot.role.BuildHost) as h:
+        # location of the U-Boot paths (source and build)
+        uboot_sources = bmcfg.basedir
+        uboot_builddir = bmcfg.builddirbuildman
+
+        h.exec0("pip", "install", "-r", uboot_sources / "test/py/requirements.txt")
+        # subshell for the build environment
+        with h.subshell():
+            uboot.testpy(
+                uboot_sources,
+                testpy_args=["--maxfail", "6", f"--junitxml=/{bmcfg.builddirbuildman._local_str()}/{b['boardname']}/results.xml"],
+                uboot_builddir = uboot_builddir,
+            )
+        td = f"{uboot_sources._local_str()}/results/{b['boardname']}"
+        h.exec0("mkdir", "-p", td)
+        h.exec("cp", f"{bmcfg.builddirbuildman._local_str()}/{b['boardname']}/results.xml", f"{td}/results.xml")
+        h.exec("cp", f"{bmcfg.builddirbuildman._local_str()}/multiplexed_log.css", f"{td}/multiplexed_log.css")
+        h.exec("cp", f"{bmcfg.builddirbuildman._local_str()}/test-log.html", f"{td}/test-log.html")
+
+@tbot.testcase
+def tbottest_test_board(b, bmcfg) -> int:  # noqa: D107
+    """
+    Test the new installed U-Boot on the board b
+    """
+    try:
+        tbot.log.message(tbot.log.c(f"Boot and Test bootloader image").green)
+        funcname = b['boottest']
+        func = getattr(labcallbacks, funcname)
+        ret = func()
+        if ret != True:
+            tbot.log.message(tbot.log.c(f"calling Boot and Test failed {b['boottest']} with {ret}").yellow)
+    except Exception as e:
+        tbot.log.message(tbot.log.c(f"calling Boot and Test failed {b['boottest']} with exception " + str(e)).yellow)
+        return 1
+
+    run_testpy(b, bmcfg)
+
+    return 0
+
+@tbot.testcase
+def _tbottest_one_board(
+    lab: linux.LinuxShell = None,
+    bh: linux.LinuxShell = None,
+    b = None,
+) -> int:  # noqa: D107
+    """
+    Build, install and test U-Boot for board b
+    """
+    bmcfg = UBBUILDMAN(lab, bh, b['ubootpatchsubpath'], b["binsubpath"],
+                        b["defconfig"],
+                        b["resultbinaries"],
+                        b["makelist"])
+
+    bmcfg.bm_build_board()
+    bmcfg.bm_copy_results2lab()
+
+    if tbottest_install_board(b):
+        return 1
+
+    return tbottest_test_board(b, bmcfg)
+
+from tbottest.initconfig import generic_get_boardname
+
+@tbot.testcase
+def tbottest_one_board(
+    lab: linux.LinuxShell = None,
+    bh: linux.LinuxShell = None,
+    boardname: str = None,
+) -> int:  # noqa: D107
+    """
+    Build, install and test U-Boot for board b
+    """
+    with tbot.ctx() as cx:
+        if bh is None:
+            bh = cx.request(tbot.role.BuildHost)
+
+        if lab is None:
+            lab = cx.request(tbot.role.LabHost)
+
+        bname = generic_get_boardname()
+        for bi in B:
+            if bi['boardname'] == bname:
+                b = bi
+
+        if _tbottest_one_board(lab, bh, b):
+            raise RuntimeError(f"Testing {bname} failed")
+
+    return 0
diff --git a/tbottesting/tbotconfig-hs/boardspecific.py b/tbottesting/tbotconfig-hs/boardspecific.py
new file mode 100644
index 0000000000..c35e0ce03b
--- /dev/null
+++ b/tbottesting/tbotconfig-hs/boardspecific.py
@@ -0,0 +1,111 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+import configparser
+from configparser import ExtendedInterpolation
+
+import tbot
+
+from tbottest.initconfig import generic_get_boardname
+from tbottest.initconfig import replace_in_file
+from tbottest.initconfig import find_in_file_and_delete
+
+
+SERVERIP = None
+
+
+def cxg3_get_lab_serverip(filename: str = None):
+    """
+    helper to save ini file reads
+    """
+    global SERVERIP
+
+    if SERVERIP is not None:
+        return SERVERIP
+
+    if filename is None:
+        raise RuntimeError("serverip not setup")
+
+    # read from ini file
+    config_parser = configparser.RawConfigParser(interpolation=ExtendedInterpolation())
+    config_parser.read(filename)
+    for s in config_parser.sections():
+        if "IPSETUP" in s:
+            nm = s.split("_")[1]
+            dev = s.split("_")[2]
+
+            if nm == generic_get_boardname() and dev == "eth0":
+                SERVERIP = config_parser.get(s, "serverip")
+                return SERVERIP
+
+    raise RuntimeError("serverip setup not found")
+
+
+IPADDR = None
+
+
+def cxg3_get_board_ipaddr(filename: str = None):
+    """
+    helper to save ini file reads
+    """
+    global IPADDR
+
+    if IPADDR is not None:
+        return IPADDR
+
+    if filename is None:
+        raise RuntimeError("ipaddr not setup")
+
+    # read from ini file
+    config_parser = configparser.RawConfigParser(interpolation=ExtendedInterpolation())
+    config_parser.read(filename)
+    for s in config_parser.sections():
+        if "IPSETUP" in s:
+            nm = s.split("_")[1]
+            dev = s.split("_")[2]
+
+            if nm == generic_get_boardname() and dev == "eth0":
+                IPADDR = config_parser.get(s, "ipaddr")
+                return IPADDR
+
+    raise RuntimeError("ipaddr not found")
+
+
+def print_log(msg):
+    try:
+        if tbot.selectable.printed:
+            return
+    except:
+        pass
+
+    tbot.log.message(tbot.log.c(msg).yellow)
+
+
+def set_ub_board_specific(self):  # noqa: C901
+    """
+    sample implementation for changing U-Boot setup dependent on tbot.flags
+    """
+    if "silent" in tbot.flags:
+        self.env("console", "silent")
+
+
+def set_board_cfg(temp: str = None, filename: str = None):  # noqa: C901
+    """
+    setup board specific stuff in ini files before they get parsed
+    """
+    # print big fat warning, that example is used
+    print_log(f"TBOT.FLAGS {sorted(tbot.flags)}")
+
+    replace_in_file(filename, "@@TBOTDATE@@", "20250208")
+    boardname = generic_get_boardname()
+    print_log(f"boardname now {boardname}")
+
+    tftpsubdir = "${board}/${date}"
+    replace_in_file(filename, "@@TBOTBOARD@@", boardname)
+    replace_in_file(filename, "@@TFTPSUBDIR@@", tftpsubdir)
+    replace_in_file(filename, "@@TBOTSERVERIP@@", cxg3_get_lab_serverip(filename))
+    replace_in_file(filename, "@@TBOTIPADDR@@", cxg3_get_board_ipaddr(filename))
+    replace_in_file(filename, "@@PICOCOMDELAY@@", "3")
+
+FLAGS = {
+    "boardname": "set theboardname of the board format boardname:<name>",
+}
diff --git a/tbottesting/tbotconfig-hs/hs/README.cxg3 b/tbottesting/tbotconfig-hs/hs/README.cxg3
new file mode 100644
index 0000000000..9cc9f0a198
--- /dev/null
+++ b/tbottesting/tbotconfig-hs/hs/README.cxg3
@@ -0,0 +1,28 @@
+README
+======
+
+commandline completions
+-----------------------
+
+	$ source tbottest/completions.sh
+
+log into U-Boot
+---------------
+
+	$ ./tbottest/newtbot_starter.py @tbotconfig/cxg3/args/argscxg3-noeth tbotconfig.interactive.uboot
+
+build U-Boot
+------------
+
+	$ ./tbottest/newtbot_starter.py -f uuuloader -f buildername:local @tbotconfig/cxg3/args/argscxg3-noeth tbotconfig.tc_cxg3.tbottest_build_board
+
+bootmodes
+---------
+
+to boot from emmc pass
+
+	-f bootmode:emmc
+
+to boot with NXPs uuu tool in USB SDP mode pass
+
+	-f bootmode:usb
diff --git a/tbottesting/tbotconfig-hs/hs/args/argsbase b/tbottesting/tbotconfig-hs/hs/args/argsbase
new file mode 100644
index 0000000000..ef3e09c0a4
--- /dev/null
+++ b/tbottesting/tbotconfig-hs/hs/args/argsbase
@@ -0,0 +1,11 @@
+-c
+tbottest.labgeneric
+-c
+tbottest.boardgeneric
+-fdo_power
+-f
+inifile:tbotconfig/hs/tbot.ini
+-f
+boardfile:tbotconfig/hs/cxg3.ini
+-f
+useifconfig
diff --git a/tbottesting/tbotconfig-hs/hs/args/argshs b/tbottesting/tbotconfig-hs/hs/args/argshs
new file mode 100644
index 0000000000..e65062f59e
--- /dev/null
+++ b/tbottesting/tbotconfig-hs/hs/args/argshs
@@ -0,0 +1 @@
+@tbotconfig/hs/args/argsbase
diff --git a/tbottesting/tbotconfig-hs/hs/args/argshs-github-ci b/tbottesting/tbotconfig-hs/hs/args/argshs-github-ci
new file mode 100644
index 0000000000..95b8f313ee
--- /dev/null
+++ b/tbottesting/tbotconfig-hs/hs/args/argshs-github-ci
@@ -0,0 +1,7 @@
+@tbotconfig/hs/args/argshs-noeth
+-f
+buildername:local
+-f
+uuuloader
+-f
+selectableboardname:cxg3
diff --git a/tbottesting/tbotconfig-hs/hs/args/argshs-noeth b/tbottesting/tbotconfig-hs/hs/args/argshs-noeth
new file mode 100644
index 0000000000..b2d53e273e
--- /dev/null
+++ b/tbottesting/tbotconfig-hs/hs/args/argshs-noeth
@@ -0,0 +1,3 @@
+@tbotconfig/hs/args/argshs
+-fnoethinit
+-fnoboardethinit
diff --git a/tbottesting/tbotconfig-hs/hs/args/argshs-noeth-ssh b/tbottesting/tbotconfig-hs/hs/args/argshs-noeth-ssh
new file mode 100644
index 0000000000..a5d7673fc1
--- /dev/null
+++ b/tbottesting/tbotconfig-hs/hs/args/argshs-noeth-ssh
@@ -0,0 +1,5 @@
+@tbotconfig/hs/args/argshs-noeth
+-fnopoweroff
+-falways-on
+-fssh
+-fnouboot
diff --git a/tbottesting/tbotconfig-hs/hs/cxg3.ini b/tbottesting/tbotconfig-hs/hs/cxg3.ini
new file mode 100644
index 0000000000..44e958f6a0
--- /dev/null
+++ b/tbottesting/tbotconfig-hs/hs/cxg3.ini
@@ -0,0 +1,106 @@
+# you can replace strings in this file on boot
+# in set_board_cfg() in boardspecific.py
+#
+# see example `set-board-cfg-temp-str-none-filename-str-none`_
+[default]
+user = @@USERNAME@@
+date = @@TBOTDATE@@
+board = @@TBOTBOARD@@
+postbuild = local
+serverip = @@TBOTSERVERIP@@
+ipaddr = @@TBOTIPADDR@@
+machine = @@TBOTMACHINE@@
+denxlayer = meta-denx-kas
+denxlayerbranch = master
+vendor = denx
+tftp_subdir = @@TFTPSUBDIR@@
+deploydir = tmp/deploy/images/${machine}
+nfs_path = @@TBOTLABBASENFSPATH@@/${machine}/${postbuild}
+subdir = ${vendor}/${machine}
+rootfsname = @@ROOTFSNAME@@
+sdk_bin = name_of_sdk_shell_script
+
+[TC]
+    uboot_death_strings = ['Kernel panic']
+    tmpdir = /tmp
+    ignore_hostkey = True
+
+    ############################################
+    # U-Boot
+    ############################################
+    uboot_boot_timeout = None
+    uboot_autoboot_timeout = 0.2
+    #uboot_autoboot_prompt = Autobooting in \d{0,3} seconds, press "<Esc><Esc>" to stop
+    uboot_autoboot_prompt = Autobooting in \d{0,3}.{0,80}
+    uboot_autoboot_keys = bytearray:1b1b
+    uboot_prompt = "U-Boot# "
+    ub_env = [{"name":"serverip", "val":"${default:serverip}"}, \
+      {"name":"ipaddr", "val":"${default:ipaddr}"}, \
+      {"name":"netmask", "val":"255.255.255.0"}, \
+      {"name":"date", "val":"${default:date}"}, \
+      {"name":"end", "val":"end"}]
+
+    ############################################
+    # Linux
+    ############################################
+    linux_user = root
+    linux_password = root
+
+    linux_boot_timeout = 200
+    linux_login_delay = 3
+    linux_init_timeout = "2"
+
+    linux_init = [ \
+        {"cmd":"cat /proc/cmdline"}, \
+        {"cmd":"uname -a"}, \
+        ]
+
+    dmesg = [
+       ]
+
+    dmesg_false = [
+       "crash",
+       ]
+
+    ############################################
+    # swupdate
+    ############################################
+    swuethdevice = eth0
+    swuimage = swu-image.swu
+
+    ############################################
+    # kas
+    ############################################
+    kas = {
+       "kasurl" : "https://github.com/siemens/kas.git",
+       "kasversion" : "4.0",
+       "build_machine" : "${default:machine}",
+       "subdir" : "${default:subdir}",
+       "kascontainer" : False,
+       "git_credential_store" : "/home/${default:user}/.git-credentials",
+       "ssh_dir" : "/home/${default:user}/.ssh",
+       "kaslayer" : "git@gitlab.denx.de:denx/${default:denxlayer}",
+       "kaslayername" : "${default:denxlayer}",
+       "kaslayerbranch" : "master",
+       "kasconfigfile" : "${default:denxlayer}/kas-denx.yml",
+       "bitbakeenvinit" : "source/poky/oe-init-build-env",
+       "envinit" : ["export PATH=/home/hs/data/bins/make-4.3/bin:$${PATH}"],
+       "buildtargets" : [
+           "core-image-minimal",
+           "meta-toolchain-qt5",
+           "bitbake -c populate_sdk core-image-dev",
+           ],
+       "bitbakeoptions" : ["-q", "-q"],
+       }
+
+    kas_check_files = [
+       "${default:deploydir}/SPL",
+       "${default:deploydir}/u-boot.img",
+       "${default:deploydir}/fitImage",
+       "tmp/deploy/sdk/${default:sdk_bin}",
+       ]
+    kas_results = [
+       "SPL",
+       "u-boot.img",
+       "fitImage",
+       ]
diff --git a/tbottesting/tbotconfig-hs/hs/tbot.ini b/tbottesting/tbotconfig-hs/hs/tbot.ini
new file mode 100644
index 0000000000..a3c2daa531
--- /dev/null
+++ b/tbottesting/tbotconfig-hs/hs/tbot.ini
@@ -0,0 +1,117 @@
+# generic lab config for tbot
+#
+# ssh access to lab host / build host only through ssh keys without
+# any passwords.
+#
+# Variables which get substituted when running tbot
+
+[LABHOST]
+labname = ubmainlinelab
+hostname = ubtestinglab
+username = pi
+sshkeyfile = /home/${username}/.ssh/id_rsa
+date = @@TBOTDATE@@
+board = @@TBOTBOARD@@
+# where does tbot find tools installed on lab host
+toolsdir = /home/${username}/source
+# path to tftp directory where tftp server looks in
+# This directory is not only used for tftp.
+tftproot = /srv/tftpboot
+# or ${board}/${date}
+tftpsubdir = @@TFTPSUBDIR@@
+workdir = /work/${username}/tbot-workdir/${board}
+tmpdir = /tmp/tbot/${username}/${board}
+proxyjump = <configure proxyjumps here>
+usernamessh = <Username on ssh machine>
+labinit = ["sudo systemctl --all --no-pager restart tftpd-hpa", "sudo systemctl stop NetworkManager"]
+seggercmd = "sudo /home/pi/source/JLink_Linux_V686e_arm/JLinkExe"
+nfs_base_path = /work/pi/tbot-workdir/nfs
+shelltype = bash
+uselocking = no
+
+[BUILDHOST]
+name = threadripper-big-build
+username = hs
+hostname = 192.168.1.120
+dl_dir = /work/downloads
+sstate_dir = /work2/${username}/tbot2go/yocto-sstate
+kas_ref_dir = /work/${username}/src
+workdir = /work/big/${username}/tbot2go
+authenticator = /home/${username}/.ssh/id_rsa
+shelltype = bash
+
+[BUILDHOST_local]
+name = local-build
+username = hs
+hostname = localmachine
+# intentionally without leading "/", so tbot works in the dir, it is started
+dl_dir = work/tbottest/dl_dir
+sstate_dir = work/tbottest/yocto-sstate
+kas_ref_dir = work/tbottest/kas-ref-dir
+workdir = work/tbottest/work
+shelltype = bash
+initcmd = ["uname -a"]
+
+[BUILDHOST_someotherbuildmachine]
+name = powerfullmachine
+username = hs
+hostname = <set here the hostname of it>
+port = 22
+dl_dir = /opt/downloads
+sstate_dir = /work/${username}/yocto/yocto-sstate
+workdir = /work/${username}/yocto
+authenticator = /home/${username}/.ssh/id_rsa
+initcmd = ["cat /etc/os-release"]
+shelltype = bash
+
+[PICOCOM_cxg3]
+baudrate = 115200
+device = /dev/serial/by-id/usb-Siemens_FitzRoy_CES3088-if01-port0
+delay = 3
+noreset = True
+
+[SDWIRE]
+serial = da23
+
+# powercontrol config
+
+[SISPMCTRL_cxg3]
+device = 01:01:60:e5:e9
+port = 4
+
+[UBCFG_cxg3]
+ethintf = eth0
+
+# board ip setup
+# !! One board can have more than one ethernet device
+# so after boardname add "_<ethdevicename>"
+# and write a section for each ethernet device on the board
+
+[IPSETUP_cxg3_eth0]
+# ethernet device used on lab host
+labdevice = eth0
+netmask = 255.255.255.0
+ethaddr = 00:30:D6:2C:A6:3D
+ipaddr = 192.168.3.40
+serverip = 192.168.3.1
+
+[UUU_CONFIG_cxg3]
+cmd = SDPS: boot -f LBD/flash.bin-githubci,
+    SDPV: delay 1000,SDPV: write -f LBD/flash.bin-githubci -skipspl,
+    SDPV: jump,
+    FB: ucmd env default -a,FB: ucmd setenv fastboot_dev mmc,
+    FB: flash bootloader LBD/flash.bin-githubci,
+    FB: ucmd mmc dev 0 2,
+    FB: ucmd mmc erase 0 3000,
+    FB: ucmd saveenv,FB: ucmd saveenv,FB: Done
+
+[BOOTMODE_cxg3]
+modes = [{"name":"bootmode:usb", "func":"cxg3_setbootmode_usb"}, {"name":"bootmode:emmc", "func":"cxg3_setbootmode_emmc"} ]
+
+[SSHMACHINE]
+name = laptop-machine
+username = ${usernamessh}
+port = <add here the port you use>
+hostname = <add the hostname or ip address>
+workdir = /tmp
+toolsdir = /home/${usernamessh}/source
diff --git a/tbottesting/tbotconfig-hs/interactive.py b/tbottesting/tbotconfig-hs/interactive.py
new file mode 100644
index 0000000000..b4c1fe13c0
--- /dev/null
+++ b/tbottesting/tbotconfig-hs/interactive.py
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+import tbot
+from tbottest.boardgeneric import cfggeneric
+from tbottest.tc.kas import KAS
+
+
+# only to have interactive commands handy and do not use the ones
+# from tbot, see https://tbot.tools/quickstart.html#directory-structure
+
+
+@tbot.testcase
+def board() -> None:
+    """Open an interactive session on the board's serial console."""
+    with tbot.ctx.request(tbot.role.Board) as b:
+        b.interactive()
+
+
+@tbot.testcase
+def linux() -> None:
+    """Open an interactive session on the board's Linux shell."""
+    with tbot.ctx.request(tbot.role.BoardLinux) as lnx:
+        lnx.interactive()
+
+
+@tbot.testcase
+def uboot() -> None:
+    """Open an interactive session on the board's U-Boot shell."""
+    tbot.ctx.teardown_if_alive(tbot.role.BoardLinux)
+    with tbot.ctx.request(tbot.role.BoardUBoot) as ub:
+        ub.interactive()
+
+
+@tbot.testcase
+def lab() -> None:
+    """Start an interactive shell on the lab-host."""
+    with tbot.ctx.request(tbot.role.LabHost) as lh:
+        lh.interactive()
+
+
+@tbot.testcase
+def build() -> None:
+    """Start an interactive shell on the build-host."""
+    with tbot.ctx.request(tbot.role.BuildHost) as bh:
+        bh.exec0("cd", bh.workdir)
+        bh.interactive()
+
+
+@tbot.testcase
+def kas() -> None:
+    """Start an interactive shell on the build-host kas container"""
+    with tbot.ctx.request(tbot.role.BuildHost) as bh:
+        lab = tbot.ctx.request(tbot.role.LabHost)
+
+        cfggeneric.kas["labhost"] = lab
+        cfggeneric.kas["buildhost"] = bh
+        kas = KAS(cfggeneric.kas)
+
+        kas.kas_shell()
diff --git a/tbottesting/tbotconfig-hs/labcallbacks.py b/tbottesting/tbotconfig-hs/labcallbacks.py
new file mode 100644
index 0000000000..3c13020359
--- /dev/null
+++ b/tbottesting/tbotconfig-hs/labcallbacks.py
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+import tbot
+import time
+
+from tbot.context import Optional
+from tbot.machine import board
+from tbot.machine import linux
+
+from tbotconfig.tc_cxg3 import _cxg3_ub_install
+from tbotconfig.tc_cxg3 import _cxg3_ub_boot_and_test
+
+################################################
+## Lab specific
+################################################
+
+fitzroyinstallpath = "/home/pi/source/fitzroy-command"
+fitzroyserial = "CES3088"
+bootmode = "notset"
+
+def cxg3_lab_run_fitzroy(
+    lab: linux.LinuxShell = None,
+    mode: str = None,
+) -> None:  # noqa: D107
+    """
+    """
+    global bootmode
+
+    if bootmode != mode:
+        lab.exec0(f"{fitzroyinstallpath}/fitzroy", "-s", fitzroyserial, "bootmode", mode)
+        #lab.exec0(f"{fitzroyinstallpath}/fitzroy", "-s", fitzroyserial, "frontend", "program")
+        lab.exec0(f"{fitzroyinstallpath}/fitzroy", "-s", fitzroyserial, "reset")
+        bootmode = mode
+        time.sleep(2)
+
+
+################################################
+## callback called from ./tbottest/labgeneric.py
+################################################
+def cxg3_setbootmode_usb(
+    lab: linux.LinuxShell = None,
+) -> None:  # noqa: D107
+    """
+    set cxg3 board into bootmode USB SDP
+    """
+    cxg3_lab_run_fitzroy(lab, "usb")
+    return True
+
+def cxg3_setbootmode_emmc(
+    lab: linux.LinuxShell = None,
+) -> None:  # noqa: D107
+    """
+    set cxg3 board into bootmode emmc
+    """
+    cxg3_lab_run_fitzroy(lab, "emmc")
+    return True
+
+################################################
+## callback called from ./tbottesting/boardtests.py
+################################################
+@tbot.testcase
+def cxg3_ub_install(
+    lab: Optional[linux.LinuxShell]=None,
+    ub: Optional[board.UBootShell]=None,
+) -> bool:  # noqa: D107
+    """
+    install U-Boot with uuu tool
+    """
+    return _cxg3_ub_install(lab, ub)
+
+@tbot.testcase
+def cxg3_ub_boot_and_test(
+    lab: Optional[linux.LinuxShell]=None,
+    ub: Optional[board.UBootShell]=None,
+) -> bool:  # noqa: D107
+    return _cxg3_ub_boot_and_test(lab, ub)
diff --git a/tbottesting/tbotconfig-hs/tc_cxg3.py b/tbottesting/tbotconfig-hs/tc_cxg3.py
new file mode 100644
index 0000000000..f30b6e516b
--- /dev/null
+++ b/tbottesting/tbotconfig-hs/tc_cxg3.py
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+import os
+import re
+import sys
+import tbot
+import time
+from tbot.context import Optional
+
+from tbot.machine import linux
+from tbot.machine import board
+from tbot.machine import connector
+
+from tbottest.boardgeneric import cfggeneric
+from tbottest.tc.uboot import board_ub_unit_test
+
+cfg = cfggeneric
+si = cfg.get_default_config("serverip", "None")
+
+
+################################################
+# U-Boot
+################################################
+@tbot.testcase
+def _cxg3_ub_install(
+    lab: Optional[linux.LinuxShell]=None,
+    ub: Optional[board.UBootShell]=None,
+) -> bool:  # noqa: D107
+    """
+    install U-Boot with uuu tool
+    """
+    # install U-Boot with uuu tool
+    tbot.log.message(tbot.log.c("----------- request U-Boot from USB SDP -----------").yellow)
+    oldflags = tbot.flags.copy()
+    try:
+        tbot.flags.remove("bootmode:emmc")
+    except:
+        pass
+    tbot.flags.add("bootmode:usb")
+    tbot.flags.add("uuuloader")
+
+    with tbot.ctx() as cx:
+        if lab is None:
+            lab = cx.request(tbot.role.LabHost)
+
+        ub = cx.request(tbot.role.BoardUBoot)
+
+        if "Boot:  USB" not in ub.bootlog:
+            raise RuntimeError(f"Boot:  USB not found in U-Boot bootlog")
+
+    return True
+
+@tbot.testcase
+def _cxg3_ub_boot_and_test(
+    lab: Optional[linux.LinuxShell]=None,
+    ub: Optional[board.UBootShell]=None,
+) -> bool:  # noqa: D107
+    """
+    boot the new U-Boot from emmc and test it.
+    """
+    tbot.log.message(tbot.log.c("----------- request U-Boot from emmc-----------").yellow)
+    try:
+        tbot.flags.add("bootmode:emmc")
+        tbot.flags.remove("bootmode:usb")
+        tbot.flags.remove("uuuloader")
+    except:
+        pass
+
+    with tbot.ctx() as cx:
+        lab = cx.request(tbot.role.LabHost)
+        ub = cx.request(tbot.role.BoardUBoot)
+
+        if "Boot:  MMC0" not in ub.bootlog:
+            raise RuntimeError(f"Boot:  MMC0 not found in U-Boot bootlog")
+
+        # just a fast ethernet test, more later
+        ub.exec0("ping", si)
+
+        # may unit test command is activated, so call it
+        return board_ub_unit_test(ub)
+
+    return False
-- 
2.20.1

