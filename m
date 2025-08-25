Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0370ECA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 22:35:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B86D2830E4;
	Tue, 26 Aug 2025 00:34:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q+hc4Fd4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B467E831BB; Tue, 26 Aug 2025 00:34:40 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 319338313F
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 00:34:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45a1b0d224dso25165775e9.3
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756161277; x=1756766077; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yk1RG2dUuvjf1RHUSN6q6hBllrszx6HR/XPRb4fiiCA=;
 b=Q+hc4Fd4yU1F0cU+wAGR79/f8covdH5K/lXKl0FmluH2ylpTY9bjz81mWRAD2sgu5u
 fdh6jaJuRlEHrl5fMFyu7o/NyVwzjsAI8PDnOzG86MPwlBJgSAzPyZmcE2W8A9EB4s4N
 vJOyfj9hWvexuI2n5iY2MuuN4W53t6YsKfIUYLGfAzJoV0DkGuXUsZbCK8uCiwpTWjLZ
 IeAZWooGglGBRaKi+Bdgo20REwBaZfR/xiZ9EZk96rMnnKlUvhJKU4RMhYgxzfSBLSSH
 lu+X4cI2+UtuKOliClUuc4OvPLTWQd3695diAJ6kfkwoYRJfvYphFWSKBm4xqcfC6t+Q
 UzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756161277; x=1756766077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yk1RG2dUuvjf1RHUSN6q6hBllrszx6HR/XPRb4fiiCA=;
 b=MZQ+vwqH7hgCubvDz19xiwiXHdnfxoV+KKi8GQuDvZgJ88+U7t1bPyzpVdeTSBRtS0
 aoXh88z3PsCFWovhpct64lkCTqI8shKd7UFJUTF8aRcQydsMIOVl/IE5Pj86IvChiTaC
 w8ASAtxBiE/nzyQ4qB/bSu2P9P61pgbOdCnmTH9tT1JQoYpU925HORVbaz/oOxvjcWkQ
 n2AEjZQiv8RROn35wFsrbj2xlPsHN65h5O/i8MKh3oMvd2cEyUaWGQMDc4/vvCCuRh5J
 2iX4t55B8X1bkWL3mWksj688wEs8Ob9eNu0zUN/hWdmcK9cdDL0L70gslcNz1+ESpmgS
 7+OA==
X-Gm-Message-State: AOJu0YwM2wMCLkAZsFUsFV9rqOlk4BXsD66ZEb6zw6XtlSZDuhYfaw6w
 t/7ufVJaEcsCs/0OKQnlo5MSWdTgUbCZuQT7BWX05d+ax7/CIlgqru9VeafrEPrRz9k=
X-Gm-Gg: ASbGncvwOBl3QLtAOeQau1HTBjHAf0cWPiO2Ca+B2nwNwVFnTj6noFvm0pJ5hsQXKNT
 v6bDR9pan/rvEiinVhfQbraCYjXhV0cSFixnrn/VfTCsA0QM/aW1oSbtKtqu0mkDX6jJ4H5JORw
 T9ZZAP4C34OMsT4u+V0xwlHt5TBBmqIR+mp1GpSMhfXnClz79acAMyojGv6JZvJ5jFTP5VCkTbu
 z1KHG2T0l7/OIZszejUk1wQTPtaRlKVbPdQMITYKoF0F9P55b8gFpo5fzIHF8Ia3hftyGgtlkd6
 QaEdVtBrSSkZnvShJGJOOJj9eShIGhnNnQ3m9BgdoqemA+3B+A1zcPV9D9omOaqaMShowaQHkOq
 Sf3RRDV0BP80aXv74kShkc9QQL6n3v2mwkiphqy8=
X-Google-Smtp-Source: AGHT+IGed6qPMDzcVDokg2HfKe2BkSZ6/Cx9fDJDa1reXloSRwrPIe3F7zIo5qRCEWb+78rd1ZdINg==
X-Received: by 2002:a05:600c:4e90:b0:458:a559:a693 with SMTP id
 5b1f17b1804b1-45b517b957emr131930745e9.18.1756161276931; 
 Mon, 25 Aug 2025 15:34:36 -0700 (PDT)
Received: from N580G.. ([2001:8a0:c46c:a000:ba6:baf1:694:9882])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b575928b0sm123733395e9.24.2025.08.25.15.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 15:34:36 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: u-boot@lists.denx.de
Cc: Adriano Carvalho <adrianocarvalho.pt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 09/10] doc: Capitalize the word Buildman whenever it's used
 as a proper noun
Date: Mon, 25 Aug 2025 23:32:36 +0100
Message-ID: <20250825223251.674591-10-adrianocarvalho.pt@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250825223251.674591-2-adrianocarvalho.pt@gmail.com>
References: <20250825223251.674591-2-adrianocarvalho.pt@gmail.com>
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

This consistency reads a bit nicer.

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
---
 doc/build/reproducible.rst  |   2 +-
 tools/buildman/buildman.rst | 108 ++++++++++++++++++------------------
 2 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/doc/build/reproducible.rst b/doc/build/reproducible.rst
index 8b030f469d7..1512129e374 100644
--- a/doc/build/reproducible.rst
+++ b/doc/build/reproducible.rst
@@ -24,4 +24,4 @@ This date is shown when we launch U-Boot:
     ./u-boot -T
     U-Boot 2023.01 (Jan 01 2023 - 00:00:00 +0000)
 
-The same effect can be obtained with buildman using the `-r` flag.
+The same effect can be obtained with Buildman using the `-r` flag.
diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index 6b382942ac8..dee95847175 100644
--- a/tools/buildman/buildman.rst
+++ b/tools/buildman/buildman.rst
@@ -6,7 +6,7 @@ Buildman build tool
 Quick-start
 -----------
 
-If you just want to quickly set up buildman so you can build something (for
+If you just want to quickly set up Buildman so you can build something (for
 example Raspberry Pi 2):
 
 .. code-block:: bash
@@ -27,7 +27,7 @@ patch series. It can build each individual commit and report which boards
 fail on which commits, and which errors come up. It aims to make full use
 of multi-processor machines.
 
-A key feature of buildman is its output summary, which allows warnings,
+A key feature of Buildman is its output summary, which allows warnings,
 errors or image size increases in a particular commit or board to be
 quickly identified and the offending commit pinpointed. This can be a big
 help for anyone working with >10 patches at a time.
@@ -63,7 +63,7 @@ can be run repeatedly on the same branch after making changes to commits on
 that branch. In this case it will automatically rebuild commits which have
 changed (and remove its old results for that commit). It is possible to build
 a branch for one board, then later build it for another board. This adds to
-the output, so now you have results for two boards. If you want buildman to
+the output, so now you have results for two boards. If you want Buildman to
 re-build a commit it has already built (e.g. because of a toolchain update),
 use the -f flag.
 
@@ -81,7 +81,7 @@ a time. A thread starts at the first commit, configures the source for your
 board and builds it. Then it checks out the next commit and does an
 incremental build (i.e. not using 'make xxx_defconfig' unless you use -C).
 Eventually the thread reaches the last commit and stops. If a commit causes
-an error or warning, buildman will try it again after reconfiguring (but see
+an error or warning, Buildman will try it again after reconfiguring (but see
 -Q). Thus some commits may be built twice, with the first result silently
 discarded. Lots of errors and warnings will cause lots of reconfigures and your
 build will be very slow. This is because a file that produces just a warning
@@ -100,14 +100,14 @@ threads do not affect the state of your git repository. Any checkouts done
 by the thread affect only the working directory for that thread.
 
 Buildman automatically selects the correct tool chain for each board. You
-must supply suitable tool chains (see ``--fetch-arch``), but buildman takes
+must supply suitable tool chains (see ``--fetch-arch``), but Buildman takes
 care of selecting the right one.
 
 Buildman generally builds a branch (with the -b flag), and in this case
 builds the upstream commit as well, for comparison. So even if you have one
 commit in your branch, two commits will be built. Put all your commits in a
 branch, set the branch's upstream to a valid value, and all will be well.
-Otherwise buildman will perform random actions. Use -n to check what the
+Otherwise Buildman will perform random actions. Use -n to check what the
 random actions might be.
 
 Buildman effectively has two modes: without -s it builds, with -s it
@@ -115,7 +115,7 @@ summarises the results of previous (or active) builds.
 
 If you just want to build the current source tree, leave off the -b flag.
 This will display results and errors as they happen. You can still look at
-them later using -se. Note that buildman will assume that the source has
+them later using -se. Note that Buildman will assume that the source has
 changed, and will build all specified boards in this case.
 
 Buildman is optimised for building many commits at once, for many boards.
@@ -183,7 +183,7 @@ Setting up
       git checkout -b my-branch origin/master
       # Add some commits to the branch, reading for testing
 
-#. Create ~/.buildman to tell buildman where to find tool chains (see
+#. Create ~/.buildman to tell Buildman where to find tool chains (see
    buildman_settings_ for details). As an example::
 
       # Buildman settings file
@@ -222,18 +222,18 @@ Setting up
       [toolchain-prefix]
       arm: /opt/arm-eabi-4.6/bin/arm-eabi-gcc
 
-   This tells buildman that you want to use this exact toolchain for the arm
+   This tells Buildman that you want to use this exact toolchain for the arm
    architecture. This will override any toolchains found by searching using the
    [toolchain] settings.
 
-   Since the toolchain prefix is an explicit request, buildman will report an
+   Since the toolchain prefix is an explicit request, Buildman will report an
    error if a toolchain is not found with that prefix. The current PATH will be
    searched, so it is possible to use::
 
       [toolchain-prefix]
       arm: arm-none-eabi-
 
-   and buildman will find arm-none-eabi-gcc in /usr/bin if you have it
+   and Buildman will find arm-none-eabi-gcc in /usr/bin if you have it
    installed.
 
    Another example::
@@ -241,7 +241,7 @@ Setting up
       [toolchain-wrapper]
       wrapper: ccache
 
-   This tells buildman to use a compiler wrapper in front of CROSS_COMPILE. In
+   This tells Buildman to use a compiler wrapper in front of CROSS_COMPILE. In
    this example, ccache. It doesn't affect the toolchain scan. The wrapper is
    added when the CROSS_COMPILE environment variable is set. The tag name in
    this section is not important. If more than one line is provided, only the
@@ -440,7 +440,7 @@ Setting up
    You can download toolchains and update the [toolchain] section of the
    settings file to find them.
 
-   To make this easier, buildman can automatically download and install
+   To make this easier, Buildman can automatically download and install
    toolchains from kernel.org. First list the available architectures::
 
       $ ./tools/buildman/buildman --fetch-arch list
@@ -541,7 +541,7 @@ As an example::
 This shows that it will build all 1059 boards, using 4 threads (because
 we have a 4-core CPU). Each thread will run with -j1, meaning that each
 make job will use a single CPU. The list of commits to be built helps you
-confirm that things look about right. Notice that buildman has chosen a
+confirm that things look about right. Notice that Buildman has chosen a
 'base' directory for you, immediately above your source tree.
 
 Buildman works entirely inside the base directory, here ../lcd9b,
@@ -653,7 +653,7 @@ But if you did want to see just the errors for lubbock, use:
 If you see error lines marked with '-', that means that the errors were fixed
 by that commit. Sometimes commits can be in the wrong order, so that a
 breakage is introduced for a few commits and fixed by later commits. This
-shows up clearly with buildman. You can then reorder the commits and try
+shows up clearly with Buildman. You can then reorder the commits and try
 again.
 
 At commit 16, the error moves: you can see that the old error at line 120
@@ -683,7 +683,7 @@ err
    Output from stderr, if any. Errors and warnings appear here.
 
 log
-   Output from stdout. Normally there isn't any since buildman runs in silent
+   Output from stdout. Normally there isn't any since Buildman runs in silent
    mode. Use -V to force a verbose build (this passes V=1 to 'make')
 
 toolchain
@@ -938,7 +938,7 @@ a set of (tag, value) pairs.
     make sure it is unique. The value is the path to the toolchain. Buildman
     will look in that path for a file ending in 'gcc'. It will then execute
     it to check that it is a C compiler, passing only the ``--version`` flag to
-    it. If the return code is 0, buildman assumes that it is a valid C
+    it. If the return code is 0, Buildman assumes that it is a valid C
     compiler. It uses the first part of the name as the architecture and
     strips off the last part when setting the CROSS_COMPILE environment
     variable (parts are delimited with a hyphen).
@@ -961,12 +961,12 @@ a set of (tag, value) pairs.
     This converts toolchain architecture names to U-Boot names. For example,
     if an x86 toolchains is called i386-linux-gcc it will not normally be
     used for architecture 'x86'. Adding 'x86: i386 x86_64' to this section
-    will tell buildman that the i386 and x86_64 toolchains can be used for
+    will tell Buildman that the i386 and x86_64 toolchains can be used for
     the x86 architecture.
 
 '[make-flags]' section
     U-Boot's build system supports a few flags (such as BUILD_TAG) which
-    affect the build product. These flags can be specified in the buildman
+    affect the build product. These flags can be specified in the Buildman
     settings file. They can also be useful when building U-Boot against other
     open source software.
 
@@ -995,7 +995,7 @@ Quick Sanity Check
 ------------------
 
 If you have made changes and want to do a quick sanity check of the
-currently checked-out source, run buildman without the -b flag. This will
+currently checked-out source, run Buildman without the -b flag. This will
 build the selected boards and display build status as it runs (i.e. -v is
 enabled automatically). Use -e to see errors/warnings as well.
 
@@ -1014,29 +1014,29 @@ will build commits in us-buildman that are not in upstream/master.
 Building Faster
 ---------------
 
-By default, buildman doesn't execute 'make mrproper' prior to building the
+By default, Buildman doesn't execute 'make mrproper' prior to building the
 first commit for each board. This reduces the amount of work 'make' does, and
 hence speeds up the build. To force use of 'make mrproper', use -the -m flag.
-This flag will slow down any buildman invocation, since it increases the amount
+This flag will slow down any Buildman invocation, since it increases the amount
 of work done on any build. An alternative is to use the ``--fallback-mrproper``
 flag, which retries the build with 'make mrproper' only after a build failure.
 
-One possible application of buildman is as part of a continual edit, build,
-edit, build, ... cycle; repeatedly applying buildman to the same change or
+One possible application of Buildman is as part of a continual edit, build,
+edit, build, ... cycle; repeatedly applying Buildman to the same change or
 series of changes while making small incremental modifications to the source
 each time. This provides quick feedback regarding the correctness of recent
-modifications. In this scenario, buildman's default choice of build directory
+modifications. In this scenario, Buildman's default choice of build directory
 causes more build work to be performed than strictly necessary.
 
-By default, each buildman thread uses a single directory for all builds. When a
+By default, each Buildman thread uses a single directory for all builds. When a
 thread builds multiple boards, the configuration built in this directory will
 cycle through various different configurations, one per board built by the
 thread. Variations in the configuration will force a rebuild of affected source
-files when a thread switches between boards. Ideally, such buildman-induced
+files when a thread switches between boards. Ideally, such Buildman-induced
 rebuilds would not happen, thus allowing the build to operate as efficiently as
-the build system and source changes allow. buildman's -P flag may be used to
+the build system and source changes allow. Buildman's -P flag may be used to
 enable this; -P causes each board to be built in a separate (board-specific)
-directory, thus avoiding any buildman-induced configuration changes in any
+directory, thus avoiding any Buildman-induced configuration changes in any
 build directory.
 
 U-Boot's build system embeds information such as a build timestamp into the
@@ -1055,7 +1055,7 @@ of the source tree, thus allowing rapid tested evolution of the code::
 
 Note also the ``--dtc-skip`` option which uses the system device-tree compiler to
 avoid needing to build it for each board. This can save 10-20% of build time.
-An alternative is to set DTC=/path/to/dtc when running buildman.
+An alternative is to set DTC=/path/to/dtc when running Buildman.
 
 Checking configuration
 ----------------------
@@ -1090,10 +1090,10 @@ same as 'am335x_evm_usbspl'.
 The -K option uses the u-boot.cfg, spl/u-boot-spl.cfg and tpl/u-boot-tpl.cfg
 files which are produced by a build. If all you want is to check the
 configuration you can in fact avoid doing a full build, using ``--config-only``.
-This tells buildman to configure U-Boot and create the .cfg files, but not
+This tells Buildman to configure U-Boot and create the .cfg files, but not
 actually build the source. This is 5-10 times faster than doing a full build.
 
-By default buildman considers the following two configuration methods
+By default Buildman considers the following two configuration methods
 equivalent::
 
    #define CONFIG_SOME_OPTION
@@ -1101,7 +1101,7 @@ equivalent::
    CONFIG_SOME_OPTION=y
 
 The former would appear in a header filer and the latter in a defconfig
-file. To achieve this, buildman considers 'y' to be '1' in configuration
+file. To achieve this, Buildman considers 'y' to be '1' in configuration
 variables. This avoids lots of useless output when converting a CONFIG
 option to Kconfig. To disable this behaviour, use ``--squash-config-y``.
 
@@ -1132,7 +1132,7 @@ and 'brppt1_spi', removing a trailing semicolon. 'brppt1_nand' gained an a
 value for 'altbootcmd', but lost one for ' altbootcmd'.
 
 The -U option uses the u-boot.env files which are produced by a build.
-Internally, buildman writes out an out-env file into the build directory for
+Internally, Buildman writes out an out-env file into the build directory for
 later comparison.
 
 defconfig fragments
@@ -1202,12 +1202,12 @@ specify the output directory with -o when using -w.
 Support for IDEs (Integrated Development Environments)
 ------------------------------------------------------
 
-Normally buildman summarises the output and shows information indicating the
+Normally Buildman summarises the output and shows information indicating the
 meaning of each line of output. For example a '+' symbol appears at the start of
-each error line. Also, buildman prints information about what it is about to do,
+each error line. Also, Buildman prints information about what it is about to do,
 along with a summary at the end.
 
-When using buildman from an IDE, it is helpful to drop this behaviour. Use the
+When using Buildman from an IDE, it is helpful to drop this behaviour. Use the
 ``-I/--ide`` option for that. You might also find -W helpful so that warnings do
 not cause the build to fail:
 
@@ -1227,12 +1227,12 @@ Typically a missing external blob causes a build failure. For build testing of
 a lot of boards, or boards for which you do not have the blobs, you can use the
 -M flag to allow missing blobs. This marks the build as if it succeeded,
 although with warnings shown, including 'Some images are invalid'. If any boards
-fail in this way, buildman exits with status 101.
+fail in this way, Buildman exits with status 101.
 
-To convert warnings to errors, use -E. To make buildman return success with
+To convert warnings to errors, use -E. To make Buildman return success with
 these warnings, use -W.
 
-It is generally safe to default to enabling -M for all runs of buildman, so long
+It is generally safe to default to enabling -M for all runs of Buildman, so long
 as you check the exit code. To do this, add::
 
    allow-missing = "always"
@@ -1278,7 +1278,7 @@ be in single quotes to ensure that the shell recognizes it as a single
 argument.
 
 If you try to set an option that does not exist, or that cannot be changed for
-some other reason (e.g. it is 'selected' by another option), then buildman
+some other reason (e.g. it is 'selected' by another option), then Buildman
 shows an error::
 
    $ buildman --board sandbox -a FRED
@@ -1292,7 +1292,7 @@ shows an error::
    FRED                  Missing expected line: CONFIG_FRED=y
 
 
-One major caveat with this feature with branches (-b) is that buildman does not
+One major caveat with this feature with branches (-b) is that Buildman does not
 name the output directories differently when you change the configuration, so
 re-launching Buildman with an updated configuration will not trigger a rebuild.
 You can use -f to work around that.
@@ -1303,7 +1303,7 @@ Other options
 
 Buildman has various other command-line options. Try ``--help`` to see them.
 
-To find out what toolchain prefix buildman will use for a build, use the -A
+To find out what toolchain prefix Buildman will use for a build, use the -A
 option.
 
 To request that compiler warnings be promoted to errors, use -E. This passes the
@@ -1326,21 +1326,21 @@ warnings are found. Note that it can be useful to combine -E and -W. This means
 that all compiler warnings will produce failures (code 100) and all other
 warnings will produce success (since 101 is changed to 0).
 
-If there are both warnings and errors, errors win, so buildman returns 100.
+If there are both warnings and errors, errors win, so Buildman returns 100.
 
 The -y option is provided (for use with -s) to ignore the bountiful device-tree
-warnings. Similarly, -Y tells buildman to ignore the migration warnings.
+warnings. Similarly, -Y tells Buildman to ignore the migration warnings.
 
-Sometimes you might get an error in a thread that is not handled by buildman,
+Sometimes you might get an error in a thread that is not handled by Buildman,
 perhaps due to a failure of a tool that it calls. You might see the output, but
-then buildman hangs. Failing to handle any eventuality is a bug in buildman and
+then Buildman hangs. Failing to handle any eventuality is a bug in Buildman and
 should be reported. But you can use -T0 to disable threading and hopefully
 figure out the root cause of the build failure.
 
-For situations where buildman is invoked from multiple running processes, it is
-sometimes useful to have buildman wait until the others have finished. Use the
+For situations where Buildman is invoked from multiple running processes, it is
+sometimes useful to have Buildman wait until the others have finished. Use the
 ``--process-limit`` option for this: ``--process-limit 1`` will allow only one
-buildman to process jobs at a time.
+Buildman to process jobs at a time.
 
 To build a particular target, rather than the default U-Boot target, use the
 ``--target`` option. This is unlikely to be useful unless you are building a
@@ -1348,7 +1348,7 @@ single board.
 
 Buildman normally builds out-of-tree, meaning that the source directory is not
 disturbed by the build. Use `-i` to do an in-tree build instead. Note that this
-does not affect the source directory, since buildman creates a separate git
+does not affect the source directory, since Buildman creates a separate git
 'worktree' for each board. This means that it is possible to do an in-tree
 build of an entire branch, or even a 'current source' build for multiple boards.
 As a special case, you can use `-wi` to do an in-tree build in the current
@@ -1370,10 +1370,10 @@ U-Boot build.
 Using boards.cfg
 ----------------
 
-This file is no-longer needed by buildman but it is still generated in the
+This file is no-longer needed by Buildman but it is still generated in the
 working directory. This helps avoid a delay on every build, since scanning all
 the Kconfig files takes a few seconds. Use the ``-R <filename>`` flag to force
-regeneration of the file - in that case buildman exits after writing the file
+regeneration of the file - in that case Buildman exits after writing the file
 with exit code 2 if there was an error in the maintainer files. To use the
 default filename, use a hyphen, i.e. `-R -`.
 
@@ -1422,7 +1422,7 @@ Credits
 -------
 
 Thanks to Grant Grundler <grundler@chromium.org> for his ideas for improving
-the build speed by building all commits for a board instead of the other
+the build speed by building all commits for a board instead of the other 
 way around.
 
 .. sectionauthor:: Simon Glass
-- 
2.48.1

