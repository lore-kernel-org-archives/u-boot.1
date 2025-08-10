Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A531BC87FD2
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 05:03:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A73C834D4;
	Mon, 11 Aug 2025 07:02:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gaJsqbch";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14EAB83278; Mon, 11 Aug 2025 01:38:25 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE9448329B
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 01:38:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-458c063baeaso21098665e9.1
 for <u-boot@lists.denx.de>; Sun, 10 Aug 2025 16:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754869102; x=1755473902; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G+NluKV+7NI59AelaiddXowjVx2Tl0x0OADfCZ+FlsE=;
 b=gaJsqbchMkyaKAAWr4r3YhKuMftAsQHEO8Q1m0oky6vQfr6VY5tcQh4Vcstf5ZLHZ2
 nuM8JDSW+GG21ys6MzMLsFoqKy5HcALbmwZSd8+t6AWHiSYrj1LWipxl2S3kZLUrwUOE
 dYPwDjiILDgAeKf3h+PjKNgKGQ+G0wlWMLGJP2C8Mw85cqCL9tIw/aYMhvmclrgTWIAg
 VsXxYNQlH73sRDQavASRCyXJjGnEuGRMdul80nCe10/JiN/UADzSJQ1FC7pEDU1CrisP
 NSdv3fo9/KAT3VQ5p0c9pTfmEPIqVTNjZgl263nbHsK9Poi2TjQdDRCqUjP8QW0Pxn1B
 jFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754869102; x=1755473902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G+NluKV+7NI59AelaiddXowjVx2Tl0x0OADfCZ+FlsE=;
 b=bCfvL3YqJFvIejSw5ZhveH3MipocdHj6tHpMIuSzdpwzffAiw1la3+MsfCzvpwXLjc
 XYvAMc1NucTfZC9iqYFgChctExkhP4LesI/bt8Td2byhffarX4EKBvp00uHzmqYt6+cm
 nZVn3qNcXUxhWsJ+WgvYqprdE2BbIP4gHqboKakeIr+DzAfA7wzBki7Odh8QYmdF7uhJ
 BOqCbppsqMkEbA55Rz0xD6Sn126twqyCr2VrGLupfjmnXKVeT8ye3FeAYPVeyjZf8/O5
 41otHZVYn04QLJsiNkBl+2BQIiaa2dU5kSGiGuhISuxJ0fHLpOAu3LRN+7PqQV92XtMQ
 0CpQ==
X-Gm-Message-State: AOJu0YwSTi69RFNErBXT7b6Y3NxM5bLcPkHxpp+M4qMPG0UJcyMEdFPJ
 TZJIAV580Gt9CWMSfC5EETcOkeVGBRtDRy1uSeuo6jfQYRqHvRRHpfUDo7m7sw==
X-Gm-Gg: ASbGncvAFLDOteIlCw7iiikzYW23RI83aRqjmZtvTGFOO8fz10zJ/5uePkfemEvFGIo
 Mefdn75QIsXXpzExvF3tcK4JSA9b+aiui0SsznpMVq2mttVB10pcTOrBpOiUV5GLec80XlijpAh
 HmtRVh3HxA5jiGfAy+1iPDc/eiNO7OY+N0xndcjrX9mkvySaNaMdFuGNlJFhsoW6d5aQOti6iUH
 3yIDSZGx4oB11yhEdb9yhTU+rZIm2ySyCK/RaJM9bUILsNRy1Iri7bBmYLSfFcI8906e1D4L18d
 OHFhrDnzbPy3tXDPHkksloy5cWk7ay+ACn1VFGLZo0cSvd0oSe5XDpSJ+Pbtwx7a5ejqDqtD0ph
 1km0yiQuFtXpgt6C/qCUH0o432mJ2Qg==
X-Google-Smtp-Source: AGHT+IHVL69WFpQUjYp2OFQRwwGsiPj1Sjxqy7h17tRWvd6qiZ/jRwatGplFXWaJ7l/bxIuGUGSmHw==
X-Received: by 2002:a05:600c:3542:b0:458:bfe1:4a91 with SMTP id
 5b1f17b1804b1-459f4f0f38dmr80566785e9.20.1754869101645; 
 Sun, 10 Aug 2025 16:38:21 -0700 (PDT)
Received: from N580G.. ([2001:8a0:c46c:a000:d911:da6:779c:bd3b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e585586esm242339815e9.13.2025.08.10.16.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Aug 2025 16:38:21 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: u-boot@lists.denx.de
Cc: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Subject: [PATCH 04/10] doc: Quote all long form options using double ticks in
 tools/buildman/buildman.rst
Date: Mon, 11 Aug 2025 00:37:35 +0100
Message-ID: <20250810233742.51902-5-adrianocarvalho.pt@gmail.com>
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

Otherwise, the two dashes are rendered as just one.

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
---
 tools/buildman/buildman.rst | 50 ++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index a9d5543a1a4..48938044520 100644
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
@@ -1287,7 +1287,7 @@ You can use -f to work around that.
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

