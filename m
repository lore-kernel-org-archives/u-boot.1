Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EF9C87FDA
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 05:03:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B384C83487;
	Mon, 11 Aug 2025 07:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UrBufTzd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7071832AD; Mon, 11 Aug 2025 01:38:22 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADB3E83278
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 01:38:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3b7910123a0so3536380f8f.1
 for <u-boot@lists.denx.de>; Sun, 10 Aug 2025 16:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754869100; x=1755473900; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uWYDZZoC8PmN6q/li5YVA5U7JEzUDGYwK6ua90/b5xo=;
 b=UrBufTzdXAsYc6ftSPMPtO8HMabOOveJ2RjzSpuzr7iVRgBJxhh8rZNuhuUITu6w2A
 Js2L0zmzXQKrowaKSWoiIaLyCXtzcNQ6N6BocPAYN2IA+QgdZTepHZuPASVirJjJZxzw
 Ipvmn8ebR7D8QHNpqWwQrJ5f1R4i9xlCPOWUxuPJsYu2KLHmUOFMZAcb1Mb3zXF4yVOw
 tL/wLr4PL9H41I5A7AROfcqmqaYUK2CDMO5ZfRHe+GoR33xLkp/7vHYON4tUEG/l/5oY
 thN4L+p4z0zpWNjdHy+ZdBHcgoNehLFGEcZ8S4Ky2VDG8CypcQttChyZM1sASs/ZK05L
 IVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754869100; x=1755473900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uWYDZZoC8PmN6q/li5YVA5U7JEzUDGYwK6ua90/b5xo=;
 b=vyI1WY5hO4A1kumeg3LTgRcb5dEMYWXv038DuPF30JQ+Y6vb1BEcAs9u/cgZHi6Wa6
 a4KY35d4/+WY5oUD2WGuw6AOrfoxAi/hRhHf+7W/0K4QM38Zsr9qdW5dN3fa2apMQ5LO
 J4+lAaxpqQIuk2qgV8TZZ/tZh1weVXiEuGP5RfwpotD8iCV5m3dZxVtaIQ47LzAc2HaD
 vCEbB2PAoSlEA2a5Q6HQ8s7m0sxQXa6GeZkMQkiiRB6MERO9ArN+6VEOtGc/wbu18wSR
 qscjnW0xMn5JVCCKhgFU2s0Z7ZA8qQIGxTidNj6ik5Mf3mGPLxK7J664MuyVpMjd/GdQ
 dm4A==
X-Gm-Message-State: AOJu0YxSjPKyAET7PYhihbtWtOurbcC6FLlDF2hm7oQnM+mP6VT5xunf
 6MREvowYR/c1LUiDL6Nf5sxwE9OINr/u8yniPl5NLZd2yt3zqzRKQhbmDizoqA==
X-Gm-Gg: ASbGnctd30adZXKydAAF/dWplasTUWfItkfUyjhcGVn4/72icYd7dQFbwEScs8q9Yxk
 4pnCz1ad78hDcUq/JWuD9iwz2O1qyp+7ml9zvb4/vm2yd9cKgfZ51pyLyCnVhVnzjEQFuxfPle9
 jbGBaFcSv/WFSV95ynQhxvmfH5HDzbvnL+TDOBVywE5HSso6Sq3fyKT235yv4wjqxLbNHqCCTb8
 b1kdemDe1mkAaSitVzwmW2ZnDKMThHZq1TTZVFMEF1hq0g1LHPgxcxXu1fl11EtjpSEd3v/IsPC
 J+X6eszzQ4d+UxdwbmyxxPzkoArC5Au4DQn/9rEbSa7l9SMiiNiiHf1LsAzUwLCr9DbtBuTc5ui
 b7VIy4ivK/9OdZIEavtUIwKMm0Q4YzQ==
X-Google-Smtp-Source: AGHT+IEciUyP/tUdVjFf84YOpBaADIIKJSNm8KCmbJoBSrFYOeSQgqcTNh/ghecATYVRT2HcNyBUTw==
X-Received: by 2002:a05:6000:288c:b0:3b7:b3f2:f8b3 with SMTP id
 ffacd0b85a97d-3b900b7afa0mr7855385f8f.38.1754869099694; 
 Sun, 10 Aug 2025 16:38:19 -0700 (PDT)
Received: from N580G.. ([2001:8a0:c46c:a000:d911:da6:779c:bd3b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e585586esm242339815e9.13.2025.08.10.16.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Aug 2025 16:38:19 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: u-boot@lists.denx.de
Cc: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Subject: [PATCH 03/10] doc: Fix typos and improve wording in
 tools/buildman/buildman.rst
Date: Mon, 11 Aug 2025 00:37:34 +0100
Message-ID: <20250810233742.51902-4-adrianocarvalho.pt@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
References: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 11 Aug 2025 07:02:48 +0200
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

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
---
 tools/buildman/buildman.rst | 49 ++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index 8c45a841024..a9d5543a1a4 100644
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
 
@@ -1176,7 +1175,7 @@ Use the -L (--no-lto) flag to disable LTO.
 Doing a simple build
 --------------------
 
-In some cases you just want to build a single board and get the full output, use
+In some cases you just want to build a single board and get the full output. Use
 the -w option, for example:
 
 .. code-block:: bash
@@ -1262,7 +1261,7 @@ Some options have values, in which case you can change them:
     buildman -a 'BOOTCOMMAND="echo hello"' CONFIG_SYS_LOAD_ADDR=0x1000
 
 Note that you must put quotes around string options and the whole thing must be
-in single quotes, to make sure the shell leave it alone.
+in single quotes, to make sure the shell leaves it alone.
 
 If you try to set an option that does not exist, or that cannot be changed for
 some other reason (e.g. it is 'selected' by another option), then buildman
@@ -1281,8 +1280,8 @@ shows an error::
 
 One major caveat with this feature with branches (-b) is that buildman does not
 name the output directories differently when you change the configuration, so
-doing the same build again with different configuration will not trigger a
-rebuild. You can use -f to work around that.
+doing the same build with a different configuration will not trigger a rebuild.
+You can use -f to work around that.
 
 
 Other options
@@ -1344,7 +1343,7 @@ directory.
 Build summary
 -------------
 
-When buildman finishes it shows a summary, something like this::
+When buildman finishes it shows a summary. Something like this::
 
     Completed: 5 total built, duration 0:00:21, rate 0.24
 
@@ -1378,7 +1377,7 @@ Use the `--maintainer-check` option to check this::
    WARNING: board/mikrotik/crs3xx-98dx3236/MAINTAINERS: missing defconfig ending at line 7
    WARNING: no maintainers for 'clearfog_spi'
 
-Buildman returns with an exit code of 2 if there area any warnings.
+Buildman returns with an exit code of 2 if there are any warnings.
 
 An experimental `--full-check option` also checks for boards which don't have a
 CONFIG_TARGET_xxx where xxx corresponds to their defconfig filename. This is
-- 
2.48.1

