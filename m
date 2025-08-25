Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21290C8303F
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 22:33:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4D5B828A2;
	Tue, 26 Aug 2025 00:33:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U4avWUjn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C314B8309D; Tue, 26 Aug 2025 00:33:56 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5803780819
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 00:33:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45a1b066b5eso25825045e9.1
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756161233; x=1756766033; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DN8nx/CGNWOjGtaclivL/CUAr7mgzfk178kYAEASGPo=;
 b=U4avWUjnxbsTUYsszNU1P09KwmxenS92VKPIxDAjenG3bGp1XFg50Jxg6C3T+IvH7W
 rhvoLHflrnWomdvI5hqWbGaustGFTUxdOB5wg56+LUu7L/vr5XAH0cAKSOluytHDWdCm
 FIqwRyDWUi5wIqx3B6HsEhfK8dG9WUVtMlcQhd9igy8U4SweI4zp83rWZXcsLO7gHC9n
 y8SHJbbE4cdGgmhN1DdoaKofBU653IJDi4/aM4+7CbyequuseGUpICpz6J1nVgKKUlGI
 Xd1NaVTx+3yehDPmsSVfBY2d2iKzuNZso0u+FMSldlSH53TLjXMbAmlajMmtu9hoQ/Yh
 ydqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756161233; x=1756766033;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DN8nx/CGNWOjGtaclivL/CUAr7mgzfk178kYAEASGPo=;
 b=mAeTDJYvRgTMrdf81F6Sy8f1mGChiGdo1wECOW1kUV1Csi4h1tOc41kTETl03rM+Ae
 lzlf08mDc7lDlWgSgZWoitimdXRI5/g7qOVvAkSPcsIKNs99k7AHZdZTil3NkenBZ7L/
 DYGdnBod/xOXOIVjQI7OVAkI6rHluTSNCB6O4ZDWfLrT+fm3S4qf7ZiQTdhIXnbMNfYY
 hWQYZwhERejPsySBIMP85DjtW8sb0MfjVjuhiHk4bBG8CLRPkM3HkAoVdnfZi9vbT+a1
 bfJ2u+rq30fk1U1tMfJ9ZvyimFWYADm0zl56iG6EeYw7bRHqgQFM7EQSdrOn6/UXZPYs
 C6HA==
X-Gm-Message-State: AOJu0YwekbGe5e1ZTp1cOz75gXjAql9mFKa2TfcOEH7Ocg0g05kStG62
 n+1BKhJqyx/NAau1IgZhTOQ0OczEqbmjrgttb8TvNgBWSPo58mSlSEBreewkJqpIaJE=
X-Gm-Gg: ASbGnctuSHb+KHcgx9NnyF610qeBqv72QM5GD8wMR11vcJ3YYLGIA4f9Cuy8XEzgTp5
 Kr08YSXVbnglZHYxUa+VbVLlk/bu/MxM64cMWM3tgtaKdjygVA7NSZIhkLYjWPjAfP8PpI/QHZe
 cVFLHpot4hJp5Cp3Mmrg+/OsZ2eSGM4Jj06d8dz3bOMY/PEDLqq1oqn/XIjBiaFhTb6xvmbWpMV
 tcjf33eER4QGwBFglYU5uR/r3590GB0x8Ham6bHJAXByVYFBkgtqZyjmzISkO6qnHohLLGeAgHF
 cmDz9GVDn/lg0iwl1rEvZDH3VM4/Nn6m9LUnxHG4XnJcegDdpa9ziBcW0Ue2qneSVaU9R0XuNWu
 1jF12o2dhCbElvJtIUqsWctpQRqQm
X-Google-Smtp-Source: AGHT+IF0Ne5UQ1BUTi+BILEmgt2baHldmvChtwM96nwiIPqZ5hSP75OxatU+ZZe+NrlxHEGoj6myBA==
X-Received: by 2002:a05:600c:4743:b0:458:bfe1:4a82 with SMTP id
 5b1f17b1804b1-45b5179683dmr155872265e9.16.1756161233326; 
 Mon, 25 Aug 2025 15:33:53 -0700 (PDT)
Received: from N580G.. ([2001:8a0:c46c:a000:ba6:baf1:694:9882])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b575928b0sm123733395e9.24.2025.08.25.15.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 15:33:53 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: u-boot@lists.denx.de
Cc: Adriano Carvalho <adrianocarvalho.pt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 01/10] doc: Fix obvious typos and minor improvements
Date: Mon, 25 Aug 2025 23:32:28 +0100
Message-ID: <20250825223251.674591-2-adrianocarvalho.pt@gmail.com>
X-Mailer: git-send-email 2.48.1
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

These are fixes to what looks like obvious typos.
Some minor improvments are also included, such as:
- Write "symbolic link" instead of symlink
- Correct capitalization for LLVM (all caps)
- Remove dead link and surrounding sentence

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
---
 doc/build/clang.rst                |  8 +++---
 doc/build/gen_compile_commands.rst |  2 +-
 doc/build/tools.rst                |  9 +++----
 tools/buildman/buildman.rst        | 41 +++++++++++++++---------------
 4 files changed, 29 insertions(+), 31 deletions(-)

diff --git a/doc/build/clang.rst b/doc/build/clang.rst
index 09bb988e923..a83ecb4fdc6 100644
--- a/doc/build/clang.rst
+++ b/doc/build/clang.rst
@@ -46,9 +46,9 @@ It can also be used to compile sandbox:
 FreeBSD 11
 ----------
 
-Since llvm 3.4 is currently in the base system, the integrated assembler as
-is incapable of building U-Boot. Therefore gas from devel/arm-gnueabi-binutils
-is used instead. It needs a symlink to be picked up correctly though:
+Since LLVM 3.4 is currently in the base system, the integrated assembler is
+incapable of building U-Boot. Therefore gas from devel/arm-gnueabi-binutils is
+used instead. It needs a symbolic link to be picked up correctly though:
 
 .. code-block:: bash
 
@@ -64,7 +64,7 @@ The following commands compile U-Boot using the Clang xdev toolchain.
     gmake rpi_2_defconfig
     gmake CC="clang -target arm-freebsd-eabi --sysroot /usr/arm-freebsd" -j8
 
-Given that U-Boot will default to gcc, above commands can be
+Given that U-Boot will default to gcc, the commands above can be
 simplified with a simple wrapper script - saved as
 /usr/local/bin/arm-gnueabi-freebsd-gcc - listed below:
 
diff --git a/doc/build/gen_compile_commands.rst b/doc/build/gen_compile_commands.rst
index d503764f9e3..5eb9e4ccb0a 100644
--- a/doc/build/gen_compile_commands.rst
+++ b/doc/build/gen_compile_commands.rst
@@ -39,7 +39,7 @@ course) to have an up-to-date database.
 
 The database will be in the root of the repository. No further modifications are
 needed for it to be usable by the LSP, unless you set a name for the database
-other than it's default one (compile_commands.json).
+other than the default one (compile_commands.json).
 
 Compatible IDEs
 ---------------
diff --git a/doc/build/tools.rst b/doc/build/tools.rst
index 5bfa05b2325..1cc8eb93230 100644
--- a/doc/build/tools.rst
+++ b/doc/build/tools.rst
@@ -8,7 +8,7 @@ Building tools for Linux
 ------------------------
 
 To allow distributions to distribute all possible tools in a generic way,
-avoiding the need of specific tools building for each machine, a tools only
+avoiding the need of specific building tools for each machine, a tools-only
 defconfig file is provided.
 
 Using this, we can build the tools by doing::
@@ -30,9 +30,8 @@ installed all required packages below in order to build these host tools::
    * diffutils (3.7)
    * openssl-devel (1.1.1.d)
 
-Note the version numbers in these parentheses above are the package versions
-at the time being when writing this document. The MSYS2 installer tested is
-http://repo.msys2.org/distrib/x86_64/msys2-x86_64-20190524.exe.
+Note that the version numbers in parentheses above are the package versions at
+the time of writing this document.
 
 There are 3 MSYS subsystems installed: MSYS2, MinGW32 and MinGW64. Each
 subsystem provides an environment to build Windows applications. The MSYS2
@@ -50,7 +49,7 @@ Launch the MSYS2 shell of the MSYS2 environment, and do the following::
 Building without Python
 -----------------------
 
-The tools-only builds bytes pylibfdt by default. To disable this, use the
+The tools-only builds pylibfdt by default. To disable this, use the
 NO_PYTHON variable::
 
    NO_PYTHON=1 make tools-only_defconfig tools-only
diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index 8c45a841024..a30cd645bc0 100644
--- a/tools/buildman/buildman.rst
+++ b/tools/buildman/buildman.rst
@@ -22,10 +22,10 @@ example Raspberry Pi 2):
 What is this?
 -------------
 
-This tool handles building U-Boot to check that you have not broken it
-with your patch series. It can build each individual commit and report
-which boards fail on which commits, and which errors come up. It aims
-to make full use of multi-processor machines.
+This tool builds U-Boot to check that you have not broken it with your
+patch series. It can build each individual commit and report which boards
+fail on which commits, and which errors come up. It aims to make full use
+of multi-processor machines.
 
 A key feature of buildman is its output summary, which allows warnings,
 errors or image size increases in a particular commit or board to be
@@ -83,7 +83,7 @@ incremental build (i.e. not using 'make xxx_defconfig' unless you use -C).
 Eventually the thread reaches the last commit and stops. If a commit causes
 an error or warning, buildman will try it again after reconfiguring (but see
 -Q). Thus some commits may be built twice, with the first result silently
-discarded. Lots of errors and warnings will causes lots of reconfigures and your
+discarded. Lots of errors and warnings will cause lots of reconfigures and your
 build will be very slow. This is because a file that produces just a warning
 would not normally be rebuilt in an incremental build. Once a thread finishes
 building all the commits for a board, it starts on the commits for another
@@ -154,7 +154,7 @@ means to build all arm boards except nvidia, freescale and anything ending
 with 'ball'.
 
 For building specific boards you can use the --boards (or --bo) option, which
-takes a comma-separated list of board target names and be used multiple times
+takes a comma-separated list of board target names and can be used multiple times
 on the command line:
 
 .. code-block:: bash
@@ -212,7 +212,7 @@ Setting up
    The toolchain-alias section indicates that the i386 toolchain should be used
    to build x86 commits.
 
-   Note that you can also specific exactly toolchain prefixes if you like::
+   Note that you can also specify toolchain prefixes if you like::
 
       [toolchain-prefix]
       arm: /opt/arm-eabi-4.6/bin/arm-eabi-
@@ -243,9 +243,9 @@ Setting up
 
    This tells buildman to use a compiler wrapper in front of CROSS_COMPILE. In
    this example, ccache. It doesn't affect the toolchain scan. The wrapper is
-   added when CROSS_COMPILE environtal variable is set. The name in this
-   section is ignored. If more than one line is provided, only the last one
-   is taken.
+   added when the CROSS_COMPILE environment variable is set. The tag name in
+   this section is not important. If more than one line is provided, only the
+   last one is used.
 
 #. Make sure you have the required Python pre-requisites
 
@@ -484,7 +484,7 @@ Setting up
 How to run it
 -------------
 
-First do a dry run using the -n flag: (replace <branch> with a real, local
+First do a dry run using the -n flag (replace <branch> with a real, local
 branch with a valid upstream):
 
 .. code-block:: bash
@@ -898,7 +898,7 @@ The .buildman settings file
 
 The .buildman file provides information about the available toolchains and
 also allows build flags to be passed to 'make'. It consists of several
-sections, with the section name in square brackets. Within each section are
+sections, with the section name in square brackets. Within each section there are
 a set of (tag, value) pairs.
 
 '[global]' section
@@ -939,8 +939,7 @@ a set of (tag, value) pairs.
 '[toolchain-prefix]' section
     This can be used to provide the full toolchain-prefix for one or more
     architectures. The full CROSS_COMPILE prefix must be provided. These
-    typically have a higher priority than matches in the '[toolchain]', due to
-    this prefix.
+    typically have a higher priority than matches in the '[toolchain]'.
 
     The tilde character ``~`` is supported in paths, to represent the home
     directory.
@@ -1062,7 +1061,7 @@ For example::
     + u-boot.cfg: CONFIG_SPL_ENV_SUPPORT=1 CONFIG_SPL_NET=1
     + u-boot-spl.cfg: CONFIG_SPL_MMC=1 CONFIG_SPL_NAND_SUPPORT=1
     + all: CONFIG_SPL_ENV_SUPPORT=1 CONFIG_SPL_MMC=1 CONFIG_SPL_NAND_SUPPORT=1 CONFIG_SPL_NET=1
-    am335x_evm_usbspl :
+    am335x_evm_usbspl:
     + u-boot.cfg: CONFIG_SPL_ENV_SUPPORT=1 CONFIG_SPL_NET=1
     + u-boot-spl.cfg: CONFIG_SPL_MMC=1 CONFIG_SPL_NAND_SUPPORT=1
     + all: CONFIG_SPL_ENV_SUPPORT=1 CONFIG_SPL_MMC=1 CONFIG_SPL_NAND_SUPPORT=1 CONFIG_SPL_NET=1
@@ -1073,15 +1072,15 @@ This shows that commit 44 enabled three new options for the board
 am335x_evm_usbspl which were not enabled in commit 43. There is also a
 summary for 'arm' showing all the changes detected for that architecture.
 In this case there is only one board with changes, so 'arm' output is the
-same as 'am335x_evm_usbspl'/
+same as 'am335x_evm_usbspl'.
 
 The -K option uses the u-boot.cfg, spl/u-boot-spl.cfg and tpl/u-boot-tpl.cfg
 files which are produced by a build. If all you want is to check the
 configuration you can in fact avoid doing a full build, using --config-only.
-This tells buildman to configuration U-Boot and create the .cfg files, but not
+This tells buildman to configure U-Boot and create the .cfg files, but not
 actually build the source. This is 5-10 times faster than doing a full build.
 
-By default buildman considers the follow two configuration methods
+By default buildman considers the following two configuration methods
 equivalent::
 
    #define CONFIG_SOME_OPTION
@@ -1089,7 +1088,7 @@ equivalent::
    CONFIG_SOME_OPTION=y
 
 The former would appear in a header filer and the latter in a defconfig
-file. The achieve this, buildman considers 'y' to be '1' in configuration
+file. To achieve this, buildman considers 'y' to be '1' in configuration
 variables. This avoids lots of useless output when converting a CONFIG
 option to Kconfig. To disable this behaviour, use --squash-config-y.
 
@@ -1364,7 +1363,7 @@ regeneration of the file - in that case buildman exits after writing the file
 with exit code 2 if there was an error in the maintainer files. To use the
 default filename, use a hyphen, i.e. `-R -`.
 
-You should use 'buildman -nv <criteria>' instead of greoing the boards.cfg file,
+You should use 'buildman -nv <criteria>' instead of greping the boards.cfg file,
 since it may be dropped altogether in future.
 
 
@@ -1378,7 +1377,7 @@ Use the `--maintainer-check` option to check this::
    WARNING: board/mikrotik/crs3xx-98dx3236/MAINTAINERS: missing defconfig ending at line 7
    WARNING: no maintainers for 'clearfog_spi'
 
-Buildman returns with an exit code of 2 if there area any warnings.
+Buildman returns with an exit code of 2 if there are any warnings.
 
 An experimental `--full-check option` also checks for boards which don't have a
 CONFIG_TARGET_xxx where xxx corresponds to their defconfig filename. This is
-- 
2.48.1

