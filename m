Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696B5C8303F
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 22:34:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A7EA830B4;
	Tue, 26 Aug 2025 00:34:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B6ZwHDZZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E572E830B5; Tue, 26 Aug 2025 00:34:13 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 747DB830B4
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 00:34:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3c46686d1e6so3070033f8f.3
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756161250; x=1756766050; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B8P1iEDcu4+Rdd8kc4QfxwTSC77YPlkyqTbUWDFKNeU=;
 b=B6ZwHDZZKH/mVo3auSsk9CVHtlzbgw5jnzKBh7NRNkF3mYGxslbNlBoDRrxHyUXDwj
 IZglTOOkSFv8mNyfg0PA0GWSB6LM031XMbUq31YmhQJ9mEA5xoB0NdSr8fu58wZEDxM6
 OwCUqb6tt58HkqTKM/hVqMPGEF9pZR2MPiKB/1aynMBNb0ldEQxI2yiMIJ++XYrrctN3
 itR302wOPbkhIOJNQg3C2ihe5GDXbJHQ00dy/M4mYSpw7qV/QWiX4cAigC+jjqca+rf4
 a4eZ5iYdsb5M12NIGnOGD16Ol8HwBNg8Zt+IpdNXTFnHEVp81h5X0A6VDk/1uLNJUf12
 vQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756161250; x=1756766050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B8P1iEDcu4+Rdd8kc4QfxwTSC77YPlkyqTbUWDFKNeU=;
 b=lkaBDbUW/iFLqOkmsQQN1gTVjsMcNk60uURFp5rtubcaWLxZqbe0mjpNsGXkRsOT1P
 aI4bLduRB4sNLbVIBbwGHNffqMj1nu1YkNBF21F1+RFKRuH/3FF8rTJ21EKh7aTDJEbr
 Fda9tq7uTc5qPPsVYRvwh7PebBAM3n7F1h2+NwEM/U/CKhu3beVH/UPaee3FXTXzOhje
 0dR2PCgA97L7DmyiOOIq/ReXqpS2MiEUnU24nV+nXyB+jyoefDO5wYL2Np7Phu/PiTzI
 x8n2eEvm1bV6bN3ApM0VaXhtCc44yzmGPXIvJI9WZkhwUGcc0ysW+Y+N0ejTkhOm3sp9
 lKCg==
X-Gm-Message-State: AOJu0Yw1Tdc2YniyDGKGH418QxL1i1j/AS8l5YFwUUCPuD9Axf60p5Ok
 DDH2oRJyJ6ecrXVAMp4kam4sHPue8yb4+a5X4gpvPtomIUH3uW7LiRBODSU6Q7a7Vmw=
X-Gm-Gg: ASbGncvMotWB3+5ZJIeMRe9DqCRbSwiwjCr6HmGvXDRSlOJnXDedVIQmpElQqsiO5pn
 s7qbezZemE1Qqqoe5i5qFAcMm4PFC/GZpyWKdr1vq8ZISN6Z/V/+47UP4LQsxKjoor7XnRT2CJJ
 goj/gzkGN+8nLFi6b6l5Rr9jgS1V+zEU58xQwQL/6KsZfpoVcHiMYuh5Pk1FqOVt5Sg5daFXBYV
 ypJxBPFP8VeFOVRs+rfQRpRWibvblVw1yRG/fLAkxWX2YVJ6B5rPYWGGOFxh/A6yDXkNTycOFcK
 8tKD9dBaqoEhyIjHhKwVAtKAX/sHkHl9ShcN7AxIl8DGRb6hu9KCltpVV891lEALjULo9+0e9JN
 YejF87KIF7MTP1YxiCPPAhO4wD0SP
X-Google-Smtp-Source: AGHT+IE9+ujHvbcRXj/daSWkGQUZQKkvh8kd1JzEDKVx7No58zSEQYC4JnKi1XO8kofdGYS8JiVrWA==
X-Received: by 2002:a05:6000:238a:b0:3b7:940e:6520 with SMTP id
 ffacd0b85a97d-3c5daefc7ccmr10297863f8f.18.1756161249632; 
 Mon, 25 Aug 2025 15:34:09 -0700 (PDT)
Received: from N580G.. ([2001:8a0:c46c:a000:ba6:baf1:694:9882])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b575928b0sm123733395e9.24.2025.08.25.15.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 15:34:09 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: u-boot@lists.denx.de
Cc: Adriano Carvalho <adrianocarvalho.pt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 02/10] doc: Quote all long form options using double
 backticks/grave accents
Date: Mon, 25 Aug 2025 23:32:29 +0100
Message-ID: <20250825223251.674591-3-adrianocarvalho.pt@gmail.com>
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

Otherwise, the two dashes are rendered as just one.

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
---
 tools/buildman/buildman.rst | 50 ++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index a30cd645bc0..3b51b9ed2b3 100644
--- a/tools/buildman/buildman.rst
+++ b/tools/buildman/buildman.rst
@@ -100,8 +100,8 @@ threads do not affect the state of your git repository. Any checkouts done
 by the thread affect only the working directory for that thread.
 
 Buildman automatically selects the correct tool chain for each board. You
-must supply suitable tool chains (see --fetch-arch), but buildman takes care
-of selecting the right one.
+must supply suitable tool chains (see ``--fetch-arch``), but buildman takes
+care of selecting the right one.
 
 Buildman generally builds a branch (with the -b flag), and in this case
 builds the upstream commit as well, for comparison. So even if you have one
@@ -153,9 +153,9 @@ You can also use -x to specifically exclude some boards. For example:
 means to build all arm boards except nvidia, freescale and anything ending
 with 'ball'.
 
-For building specific boards you can use the --boards (or --bo) option, which
-takes a comma-separated list of board target names and can be used multiple times
-on the command line:
+For building specific boards you can use the ``--boards`` (or ``--bo``) option,
+which takes a comma-separated list of board target names and can be used
+multiple times on the command line:
 
 .. code-block:: bash
 
@@ -492,7 +492,7 @@ branch with a valid upstream):
    ./tools/buildman/buildman -b <branch> -n
 
 If it can't detect the upstream branch, try checking out the branch, and
-doing something like 'git branch --set-upstream-to upstream/master'
+doing something like ``git branch --set-upstream-to upstream/master``
 or something similar. Buildman will try to guess a suitable upstream branch
 if it can't find one (you will see a message like "Guessing upstream as ...").
 You can also use the -c option to manually specify the number of commits to
@@ -731,17 +731,17 @@ Note that the 'text' region and 'rodata' are split out. You should add the
 two together to get the total read-only size (reported as the first column
 in the output from binutil's 'size' utility).
 
-A useful option is --step which lets you skip some commits. For example
---step 2 will show the image sizes for only every 2nd commit (so it will
+A useful option is ``--step`` which lets you skip some commits. For example
+``--step 2`` will show the image sizes for only every 2nd commit (so it will
 compare the image sizes of the 1st, 3rd, 5th... commits). You can also use
---step 0 which will compare only the first and last commits. This is useful
+``--step 0`` which will compare only the first and last commits. This is useful
 for an overview of how your entire series affects code size. It will build
 only the upstream commit and your final branch commit.
 
 You can also use -d to see a detailed size breakdown for each board. This
 list is sorted in order from largest growth to largest reduction.
 
-It is even possible to go a little further with the -B option (--bloat). This
+It is even possible to go a little further with the -B option (``--bloat``). This
 shows where U-Boot has bloated, breaking the size change down to the function
 level. Example output is below::
 
@@ -924,7 +924,7 @@ a set of (tag, value) pairs.
     This lists the available toolchains. The tag here doesn't matter, but
     make sure it is unique. The value is the path to the toolchain. Buildman
     will look in that path for a file ending in 'gcc'. It will then execute
-    it to check that it is a C compiler, passing only the --version flag to
+    it to check that it is a C compiler, passing only the ``--version`` flag to
     it. If the return code is 0, buildman assumes that it is a valid C
     compiler. It uses the first part of the name as the architecture and
     strips off the last part when setting the CROSS_COMPILE environment
@@ -1005,7 +1005,7 @@ By default, buildman doesn't execute 'make mrproper' prior to building the
 first commit for each board. This reduces the amount of work 'make' does, and
 hence speeds up the build. To force use of 'make mrproper', use -the -m flag.
 This flag will slow down any buildman invocation, since it increases the amount
-of work done on any build. An alternative is to use the --fallback-mrproper
+of work done on any build. An alternative is to use the ``--fallback-mrproper``
 flag, which retries the build with 'make mrproper' only after a build failure.
 
 One possible application of buildman is as part of a continual edit, build,
@@ -1040,7 +1040,7 @@ of the source tree, thus allowing rapid tested evolution of the code::
 
     ./tools/buildman/buildman -Pr tegra
 
-Note also the `--dtc-skip` option which uses the system device-tree compiler to
+Note also the ``--dtc-skip`` option which uses the system device-tree compiler to
 avoid needing to build it for each board. This can save 10-20% of build time.
 An alternative is to set DTC=/path/to/dtc when running buildman.
 
@@ -1076,7 +1076,7 @@ same as 'am335x_evm_usbspl'.
 
 The -K option uses the u-boot.cfg, spl/u-boot-spl.cfg and tpl/u-boot-tpl.cfg
 files which are produced by a build. If all you want is to check the
-configuration you can in fact avoid doing a full build, using --config-only.
+configuration you can in fact avoid doing a full build, using ``--config-only``.
 This tells buildman to configure U-Boot and create the .cfg files, but not
 actually build the source. This is 5-10 times faster than doing a full build.
 
@@ -1090,7 +1090,7 @@ equivalent::
 The former would appear in a header filer and the latter in a defconfig
 file. To achieve this, buildman considers 'y' to be '1' in configuration
 variables. This avoids lots of useless output when converting a CONFIG
-option to Kconfig. To disable this behaviour, use --squash-config-y.
+option to Kconfig. To disable this behaviour, use ``--squash-config-y``.
 
 
 Checking the environment
@@ -1165,7 +1165,7 @@ Link-time optimisation (LTO) is designed to reduce code size by globally
 optimising the U-Boot build. Unfortunately this can dramatically slow down
 builds. This is particularly noticeable when running a lot of builds.
 
-Use the -L (--no-lto) flag to disable LTO.
+Use the -L (``--no-lto``) flag to disable LTO.
 
 .. code-block:: bash
 
@@ -1195,7 +1195,7 @@ each error line. Also, buildman prints information about what it is about to do,
 along with a summary at the end.
 
 When using buildman from an IDE, it is helpful to drop this behaviour. Use the
--I/--ide option for that. You might find -W helpful also so that warnings do
+``-I/--ide`` option for that. You might also find -W helpful so that warnings do
 not cause the build to fail:
 
 .. code-block:: bash
@@ -1287,7 +1287,7 @@ rebuild. You can use -f to work around that.
 Other options
 -------------
 
-Buildman has various other command-line options. Try --help to see them.
+Buildman has various other command-line options. Try ``--help`` to see them.
 
 To find out what toolchain prefix buildman will use for a build, use the -A
 option.
@@ -1325,11 +1325,11 @@ figure out the root cause of the build failure.
 
 For situations where buildman is invoked from multiple running processes, it is
 sometimes useful to have buildman wait until the others have finished. Use the
---process-limit option for this: --process-limit 1 will allow only one buildman
-to process jobs at a time.
+``--process-limit`` option for this: ``--process-limit 1`` will allow only one
+buildman to process jobs at a time.
 
 To build a particular target, rather than the default U-Boot target, use the
-`--target` option. This is unlikely to be useful unless you are building a
+``--target`` option. This is unlikely to be useful unless you are building a
 single board.
 
 Buildman normally builds out-of-tree, meaning that the source directory is not
@@ -1358,7 +1358,7 @@ Using boards.cfg
 
 This file is no-longer needed by buildman but it is still generated in the
 working directory. This helps avoid a delay on every build, since scanning all
-the Kconfig files takes a few seconds. Use the `-R <filename>` flag to force
+the Kconfig files takes a few seconds. Use the ``-R <filename>`` flag to force
 regeneration of the file - in that case buildman exits after writing the file
 with exit code 2 if there was an error in the maintainer files. To use the
 default filename, use a hyphen, i.e. `-R -`.
@@ -1371,7 +1371,7 @@ Checking maintainers
 --------------------
 
 Sometimes a board is added without a corresponding entry in a MAINTAINERS file.
-Use the `--maintainer-check` option to check this::
+Use the ``--maintainer-check`` option to check this::
 
    $ buildman --maintainer-check
    WARNING: board/mikrotik/crs3xx-98dx3236/MAINTAINERS: missing defconfig ending at line 7
@@ -1379,8 +1379,8 @@ Use the `--maintainer-check` option to check this::
 
 Buildman returns with an exit code of 2 if there are any warnings.
 
-An experimental `--full-check option` also checks for boards which don't have a
-CONFIG_TARGET_xxx where xxx corresponds to their defconfig filename. This is
+An experimental ``--full-check option`` also checks for boards which don't have
+a CONFIG_TARGET_xxx where xxx corresponds to their defconfig filename. This is
 not strictly necessary, but may be useful information.
 
 
-- 
2.48.1

