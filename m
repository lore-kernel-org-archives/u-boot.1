Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501D1C369DC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 02:50:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC3288209C;
	Fri,  2 May 2025 04:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d1G/KrNZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2011A8209C; Fri,  2 May 2025 04:50:46 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49B4B801BE
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 04:50:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-861525e9b0aso144190939f.3
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 19:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746154241; x=1746759041; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vamrkx58a+x/Q6uLRaUb43ZQIsys23JPGTgK3iJ5S3I=;
 b=d1G/KrNZ+U6ivnXuGGMJk7cVqURrgV+/AZQ+cfWWOT+SUD7yE8cO6uXbkVpo+fx1Cc
 zTnNCEia7EgvoEz7l6UshmZti0sm5a9wR51nk09x9Ih9SigTh1mnov1YFZzZDgdnJjlB
 GMahgYXYhuSCwzdu4+juXz9oWkpIfHsk1RLXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746154241; x=1746759041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vamrkx58a+x/Q6uLRaUb43ZQIsys23JPGTgK3iJ5S3I=;
 b=mtb4IHFcVUU2gus3p8OTzPvbAwZlFVCxJ1c8ZN2Rd/7z2HNRhQUa0xGnPJ88dPUl+J
 ny2F4JIudZ4Ck/o0x1we18tPpCrdhLNu9OfARULuggJzmv4Yd3XBS1kYuLoE0lMEDnay
 WGXOh3YZVhKx/LdOJs8DrX+tNujdWUmtRToljNlzErKtvu5bVSlm+v3/2b3XkBOfhJfr
 O0DVe1iOgeGFc3PbV9Cj+vvyBp7ZhspHj1CqevkwowLvjm/41fnyBYjtVO46ejQbZtWK
 AbkiM40s8ZosZ43T4igqmjkKYKnBbcwvOvKa4SRuudXL+ZY9y4ZlPmUgckKXy+qbfMiH
 ftqA==
X-Gm-Message-State: AOJu0YwZLymBSnEoKjmvdXezO9ETmq2meCQaAvxlR3OxY+Jioe5flkTU
 i0RQOzZSKWqk4sd2NJfyxlfLYvb6fF8EXtlmhdE+xNo4Ey0N6y6wHPk8yHrWVcuCp0/+vt1L6YA
 =
X-Gm-Gg: ASbGncvZptmwFUcuaoXek6F5FTOWl1VwbvGSGVm/H+agPE/dW8/vgES9EjS1Yr4ELeJ
 5hnphs+uDGpYRbJGaB5jyB5FiQz86dGcyEZI6Zsvs33AdLFuite9WyQ3f0Vy9seREQ8XaaVda5R
 Do7p55HntH9cIbNqyfaBwBohlBVK6xvmIkTpEk5OX3nJll6MpSGkTFdSBm5hz4H0O5MZhBbEjIk
 gPfW90FHby0pKE4o7pg4pKWyis16axR2REHDRd2feVABpVDVF5FBHR6no8T5/EBtmNOI9fPVQDs
 Rfk5zqls4sIqJrZ4CvodIZMlKGbO1y8LtATfJ+Cwv5EDuFcbBNmFLAlAxpduJeiYH/x054wJPCk
 LVg==
X-Google-Smtp-Source: AGHT+IGk+TOQfxZNaO3DoUvMuYNFsclGEw1uiTn9JKh/KjhtwDBpWau7FD9+YS4dv4SASRBrnUvPhw==
X-Received: by 2002:a05:6602:3718:b0:864:677e:ddae with SMTP id
 ca18e2360f4ac-8669f9ac967mr235860739f.6.1746154241263; 
 Thu, 01 May 2025 19:50:41 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88a918039sm166627173.55.2025.05.01.19.50.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 19:50:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/3] doc: Tidy up the hooks documentation
Date: Thu,  1 May 2025 20:50:18 -0600
Message-ID: <20250502025026.4140184-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502025026.4140184-1-sjg@chromium.org>
References: <20250502025026.4140184-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Now that these files are within the repo, link the documentation to the
normal U-Boot documentation. Update directory paths and convert it to
rST format.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/index.rst                         |  1 +
 doc/develop/py_testing.rst                    | 22 +++---
 .../README.md => doc/develop/test_hooks.rst   | 72 +++++++++++--------
 3 files changed, 54 insertions(+), 41 deletions(-)
 rename test/hooks/README.md => doc/develop/test_hooks.rst (87%)

diff --git a/doc/develop/index.rst b/doc/develop/index.rst
index d9f2a838207..ffbb3aeb466 100644
--- a/doc/develop/index.rst
+++ b/doc/develop/index.rst
@@ -85,6 +85,7 @@ Testing
    tests_writing
    tests_sandbox
    binman_tests
+   test_hooks
 
 Refactoring
 -----------
diff --git a/doc/develop/py_testing.rst b/doc/develop/py_testing.rst
index fb153a277fc..c65de27369b 100644
--- a/doc/develop/py_testing.rst
+++ b/doc/develop/py_testing.rst
@@ -314,6 +314,8 @@ via `$PATH`. These scripts implement certain actions on behalf of the test
 suite. This keeps the test suite simple and isolated from system variances
 unrelated to U-Boot features.
 
+For more details see :doc:`test_hooks`.
+
 Hook scripts
 ~~~~~~~~~~~~
 
@@ -404,9 +406,9 @@ saving wear on the flash chip(s).
 Examples
 ''''''''
 
-https://source.denx.de/u-boot/u-boot-test-hooks contains some working example hook
+The directory `test/hooks` contains some working example hook
 scripts, and may be useful as a reference when implementing hook scripts for
-your platform. These scripts are not considered part of U-Boot itself.
+your platform. These scripts are considered part of U-Boot itself.
 
 Board-type-specific configuration
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -469,16 +471,16 @@ instances of:
 Complete invocation example
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Assuming that you have installed the hook scripts into $HOME/ubtest/bin, and
-any required environment configuration Python modules into $HOME/ubtest/py,
-then you would likely invoke the test script as follows:
+Assuming that you have installed U-Boot `$UBOOT`, any new hooks into
+`$UBOOT/test/hooks/bin` and any new configuration Python modules into
+`$UBOOT/test/hooks/py`, then you would likely invoke the test script as follows:
 
 If U-Boot has already been built:
 
 .. code-block:: bash
 
-    PATH=$HOME/ubtest/bin:$PATH \
-    PYTHONPATH=${HOME}/ubtest/py/${HOSTNAME}:${PYTHONPATH} \
+    PATH=$UBOOT/test/hooks/bin:$PATH \
+    PYTHONPATH=$UBOOT/test/hooks/py/${HOSTNAME}:${PYTHONPATH} \
     ./test/py/test.py --bd seaboard
 
 If you want the test script to compile U-Boot for you too, then you likely
@@ -488,7 +490,7 @@ follows:
 .. code-block:: bash
 
     CROSS_COMPILE=arm-none-eabi- \
-    PATH=$HOME/ubtest/bin:$PATH \
+    PATH=$UBOOT/test/hooks/bin:$PATH \
     PYTHONPATH=${HOME}/ubtest/py/${HOSTNAME}:${PYTHONPATH} \
     ./test/py/test.py --bd seaboard --build
 
@@ -496,8 +498,8 @@ or, using buildman to handle it:
 
 .. code-block:: bash
 
-    PATH=$HOME/ubtest/bin:$PATH \
-    PYTHONPATH=${HOME}/ubtest/py/${HOSTNAME}:${PYTHONPATH} \
+    PATH=$UBOOT/test/hooks/bin:$PATH \
+    PYTHONPATH=$UBOOT/test/hooks/py/${HOSTNAME}:${PYTHONPATH} \
     ./test/py/test.py --bd seaboard --build --buildman
 
 Writing tests
diff --git a/test/hooks/README.md b/doc/develop/test_hooks.rst
similarity index 87%
rename from test/hooks/README.md
rename to doc/develop/test_hooks.rst
index ecf8a46c4a5..c86b45b38b9 100644
--- a/test/hooks/README.md
+++ b/doc/develop/test_hooks.rst
@@ -1,17 +1,20 @@
-# Introduction
+Hardware testing
+================
 
-This repository contains working example support ("hook") scripts for U-Boot's
+The ``test/hooks`` directory contains support ("hook") scripts for U-Boot's
 built-in test framework. That framework is located in the `test/py/` directory
 in the U-Boot source tree.
 
 You may use these examples as a reference when creating your own hook scripts,
-or even derive your own scripts directly from the files in this repository.
+or even derive your own scripts directly from the files in ``test/hooks``.
 
-# Contributing
+Contributing
+------------
 
-See [Contributing.md](Contributing.md).
+Please send a patch to the U-Boot as per :doc:`process`
 
-# Flashing Philosophy
+Flashing Philosophy
+-------------------
 
 U-Boot may be installed onto a target device either by:
 
@@ -22,14 +25,15 @@ U-Boot may be installed onto a target device either by:
   download needs to happen every time the target board is reset, since the
   desired binary is not permanently stored on the system.
 
-The example scripts in this repository take the second approach. This approach
+The example scripts in ``test/hooks`` take the second approach. This approach
 avoids modifying the device's flash memory for each U-Boot binary to be tested,
 which should increase longevity of the device. This does mean that the
 implementation of the `test/py/` hook scripts is slightly inconsistent with
 their naming; `u-boot-test-flash` does nothing whereas `u-boot-test-reset`
 downloads U-Boot into RAM rather than only performing a simple system reset.
 
-# USB Port Paths
+USB Port Paths
+--------------
 
 When multiple USB devices of the same type are attached to the same system, some
 mechanism for differentiating between them is required, in order for software to
@@ -52,7 +56,7 @@ numbers form the balance of the USB port path.
 Linux uses the format `${bus}-${port}.${port}.${port}...` to represent the USB
 port path.
 
-For example:
+For example::
 
     +--------------+
     | PC           |
@@ -78,7 +82,7 @@ experimentation using tools such as `picocom` or `mount` and `ls`.
 
 Once a device node has been identified, use udevadm to query all known
 information about the device, then find an entry with `SUBSYSTEMS=="usb"` and a
-`KERNELS` value in the format of a USB port path:
+`KERNELS` value in the format of a USB port path::
 
     $ udevadm info -a /dev/ttyUSB2
     ...
@@ -109,7 +113,7 @@ information about the device, then find an entry with `SUBSYSTEMS=="usb"` and a
 
 Here, the USB port path is "`3-6`".
 
-or:
+or::
 
     $ udevadm info -a /dev/bus/usb/003/086
     ....
@@ -120,9 +124,10 @@ or:
 
 Here, the USB port path is "`3-10.4`".
 
-# udev Rules
+udev Rules
+----------
 
-See the `udev/` directory in this repository.
+See the `test/hooks/udev/` directory.
 
 Testing should be performed as a non-root user. This requires that the relevant
 device nodes have non-default permissions. udev rules may be used to achieve
@@ -145,9 +150,10 @@ path.
 
 The example udev rules demonstrate both of these types of rules.
 
-# Scripts and Binaries
+Scripts and Binaries
+--------------------
 
-See the `bin/` directory in this repository.
+See the `test/hooks/bin/` directory.
 
 Scripts exist to power on, power off, flash, and reset Tegra boards, and access
 their serial console. The U-Boot test framework expects these scripts to exist
@@ -175,10 +181,11 @@ more than include a board-specific configuration file, and then include another
 file specific to implementation the desired action.
 
 Board configuration files are located in
-`bin/${hostname}/conf.${board_type}_${board_identity}`. These files are
-segregated by hostname so that the repository can be used directly across
+`test/hooks/bin/${hostname}/conf.${board_type}_${board_identity}`. These files
+are segregated by hostname so that the repository can be used directly across
 multiple different test machines, without the need for host-specific branches or
-post-checkout configuration.
+post-checkout configuration. Your scripts can also exist outside the U-Boot
+repo if that is helpful.
 
 The board configuration file defines which mechanism is used for each possible
 action, and any parameters associated with it. For example, downloading U-Boot
@@ -187,8 +194,8 @@ T124 or earlier, or L4T's `exec-uboot.sh` for boards containing T210 or newer.
 These scripts. In each case, the directory name where the tool is installed must
 be defined.
 
-Each action is implemented in a script fragment directly in the `bin/` directory,
-with filename `${action_type}.${implementation_name}`.
+Each action is implemented in a script fragment directly in the`test/hooks/bin/`
+directory, with filename `${action_type}.${implementation_name}`.
 
 If using these scripts directly for testing Tegra devices, it is likely that
 you will not need to create new `download.*` implementations, but will need to
@@ -199,7 +206,8 @@ scripts must be replicated once per board instance, or their actions somehow
 serialized, since they copy files into their own directories when executing, and
 hence parallel execution would cause incorrect operation.
 
-## Labgrid Integration
+Labgrid Integration
+-------------------
 
 Labgrid is a python library for embedded-board-control. It includes a client
 program which is used to integrate with the U-Boot pytests.
@@ -208,9 +216,9 @@ Since Labgrid has all the information necessary to build and boot on a lab,
 there is no per-board configuration required. The various flash.xxx and
 recovery.xxx scripts are not used. To set it up, one implementation is:
 
-- In your bin/$hostname directory, create an executable file
+- In the test/hooks/bin/$hostname directory, create an executable file
   `common-labgrid-sjg` and set your crossbar and environment information, for
-  example:
+  example::
 
       # Hostname and port for the gRPC coordinator
       export LG_COORDINATOR=kea:20408
@@ -219,7 +227,7 @@ recovery.xxx scripts are not used. To set it up, one implementation is:
       export LG_ENV="/path/to/kea_env.cfg"
 
       # Location of the U-Boot test hooks
-      export UB_TEST_HOOKS=/path/to/u-boot-test-hooks
+      export UB_TEST_HOOKS=/path/to/u-boot/test/hooks
 
       # Make sure only one buildman can run at a time, since it uses all CPUs
       export BUILDMAN_PROCESS_LIMIT=1
@@ -258,10 +266,11 @@ variables must be set as per your lab:
 - `LG_ENV` must point at the labgrid yaml file that describes your lab.
 
 In order for a given platform to be tested, it must be acquired before starting
-tests and then released once complete. See the bin/konsulko-labgrid directory
-for example boards using this method.
+tests and then released once complete. See the `test/hooks/bin/konsulko-labgrid`
+directory for example boards using this method.
 
-## Dependencies
+Dependencies
+------------
 
 The example scripts depend on various external tools, the installation location
 of which must be specified in the board configuration files:
@@ -280,9 +289,10 @@ of which must be specified in the board configuration files:
 U-Boot's test framework also requires a `dfu-util` that supports the -p
 command-line option. Most distros provide this nowadays.
 
-# Python Modules
+Python Modules
+--------------
 
-See the `py/` directory in this repository.
+See the `test/hooks/py/` directory.
 
 A Python module exists for each board and defines numerous parameters used by
 the U-Boot test framework. The framework expects to simply import these modules
@@ -292,5 +302,5 @@ These modules are again located in a separate directory for each host, so that
 the repository may be shared across hosts.
 
 For complete details re: the required content of these Python modules, please
-see `test/py/README.md` in the U-boot source tree, and also the comments in some
-individual test files in `test/py/tests/test_*.py`.
+see :doc:`py_testing` and also the comments in some individual test files in
+`test/py/tests/test_*.py`.
-- 
2.43.0

