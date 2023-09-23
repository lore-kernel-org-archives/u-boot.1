Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AFBCE7A88
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0708286BFA;
	Sat, 23 Sep 2023 21:45:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aEVWWMOs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E8C586B9C; Sat, 23 Sep 2023 21:45:01 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05E7086B5D
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:44:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-79f92726f47so125237539f.3
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498296; x=1696103096; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6rhvydikjJ8xknihzFLO8tq6CGTv/YZB87PU+Vu6dbs=;
 b=aEVWWMOsUMXLL7qB0DTnaKpueM1xSuR3fE1DimsnCIF0wOHs9M6hVuhwC0qB3898IC
 dcwNOkQA+xPQlWCRDIFkGzMHskRj6zowH6XFgBV/wG9KtTYhC5obzVAtO9T1YOvZGoqU
 9uzX/0RDLLW+89HPS9/KxIodXyTm47jgBduPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498296; x=1696103096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6rhvydikjJ8xknihzFLO8tq6CGTv/YZB87PU+Vu6dbs=;
 b=whekooj/bZDm5eLllMx5HY7Jp///ZEPb5AzlPRd/yiFUj6v8oC/7qFzCAzQpyu6lOr
 xleRKncfr8iDS+zTE712xja+1FkmYwyDPnx/Uo/0C8dwqgz7yup0lYuLJyzUAmPrACtM
 UxBLc4LAW2G24Bph9bwinoDZP2bQ9JZn6n2HQ716fnxJrd6/+C7GW0odTgQQFduooP7A
 CzFbzSzH4KKT5YviUqzkh9nzYrUa2bq7kBQnd8tMXal5YuiXFT7W68CDODs1EyflXlkC
 u2M6g4Hz9DPhT9O+H3b6YBJ/2+p4ngZ0bbOFNYVvNaOwnUPfLSE/OG4Z3j8riiltHNWQ
 h+Aw==
X-Gm-Message-State: AOJu0YyIhouVWTVNLINysBmSmytt67vEifmpBAQIVg9yBN6cmtVRdLqs
 4ugujsv7PP0hBvv47059e0Pq4NnxfGiUYsAhuSs=
X-Google-Smtp-Source: AGHT+IEOZbQQx0eZhwyNOIWCkbhdNe9OiHy5Rv9Tw17H/yn/1SqWgUiYWCzPhnT4uhkZJeVTPccxyA==
X-Received: by 2002:a5e:c247:0:b0:79a:b667:4e97 with SMTP id
 w7-20020a5ec247000000b0079ab6674e97mr2904078iop.0.1695498296024; 
 Sat, 23 Sep 2023 12:44:56 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 el9-20020a0566384d8900b00439d4db47b6sm1697786jab.39.2023.09.23.12.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 12:44:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 27/27] qconfig: Update the documentation
Date: Sat, 23 Sep 2023 13:44:16 -0600
Message-ID: <20230923194424.1739224-28-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230923194424.1739224-1-sjg@chromium.org>
References: <20230923194424.1739224-1-sjg@chromium.org>
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

Update qconfig's documentation to better reflect its new purpose in life.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Update based on Heinrich's comments

Changes in v2:
- Reinstate the -C option

 doc/develop/index.rst                       |   2 +-
 doc/develop/{moveconfig.rst => qconfig.rst} | 160 ++++++--------------
 2 files changed, 47 insertions(+), 115 deletions(-)
 rename doc/develop/{moveconfig.rst => qconfig.rst} (59%)

diff --git a/doc/develop/index.rst b/doc/develop/index.rst
index 0d12484ace8a..003cdfccf112 100644
--- a/doc/develop/index.rst
+++ b/doc/develop/index.rst
@@ -88,7 +88,7 @@ Refactoring
 
    checkpatch
    coccinelle
-   moveconfig
+   qconfig
 
 Code quality
 ------------
diff --git a/doc/develop/moveconfig.rst b/doc/develop/qconfig.rst
similarity index 59%
rename from doc/develop/moveconfig.rst
rename to doc/develop/qconfig.rst
index ad8596e6c61a..8efb1eb2685c 100644
--- a/doc/develop/moveconfig.rst
+++ b/doc/develop/qconfig.rst
@@ -1,148 +1,87 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-moveconfig - Migrating and querying CONFIG options
-==================================================
+qconfig - Querying CONFIG options
+=================================
 
-Since Kconfig was introduced to U-Boot, we have worked on moving
-config options from headers to Kconfig (defconfig).
+It is not possible to see all the CONFIG options used by a board without
+building its `.config` file. This tool allows this to be done efficiently for
+all boards, or a subset, writing the results to a unified database file.
 
-This tool intends to help this tremendous work.
+This database can be queried, to find boards which used a certain combination
+of options, to aid in discovering Kconfig options which imply others.
 
-Installing
-----------
-
-You may need to install 'python3-asteval' for the 'asteval' module.
-
-Usage
------
-
-First, you must edit the Kconfig to add the menu entries for the configs
-you are moving.
-
-Then run this tool giving CONFIG names you want to move.
-For example, if you want to move CONFIG_CMD_USB and CONFIG_TEXT_BASE,
-simply type as follows::
-
-  $ tools/moveconfig.py CONFIG_CMD_USB CONFIG_TEXT_BASE
-
-The tool walks through all the defconfig files and move the given CONFIGs.
-
-The log is also displayed on the terminal.
-
-The log is printed for each defconfig as follows::
-
-  <defconfig_name>
-     <action1>
-     <action2>
-     <action3>
-     ...
-
-`<defconfig_name>` is the name of the defconfig.
-
-`<action*>` shows what the tool did for that defconfig.
-It looks like one of the following:
+The tool also permits syncing of defconfigs, which corrects the ordering and
+drops options which are implied by others.
 
- - Move 'CONFIG\_... '
-   This config option was moved to the defconfig
+Finally, it allows scanning the source code to look for inconsistencies in the
+use of Kconfig options.
 
- - CONFIG\_... is not defined in Kconfig.  Do nothing.
-   The entry for this CONFIG was not found in Kconfig.  The option is not
-   defined in the config header, either.  So, this case can be just skipped.
-
- - CONFIG\_... is not defined in Kconfig (suspicious).  Do nothing.
-   This option is defined in the config header, but its entry was not found
-   in Kconfig.
-   There are two common cases:
-
-     - You forgot to create an entry for the CONFIG before running
-       this tool, or made a typo in a CONFIG passed to this tool.
-     - The entry was hidden due to unmet 'depends on'.
-
-   The tool does not know if the result is reasonable, so please check it
-   manually.
-
- - 'CONFIG\_...' is the same as the define in Kconfig.  Do nothing.
-   The define in the config header matched the one in Kconfig.
-   We do not need to touch it.
-
- - Compiler is missing.  Do nothing.
-   The compiler specified for this architecture was not found
-   in your PATH environment.
-   (If -e option is passed, the tool exits immediately.)
-
- - Failed to process.
-   An error occurred during processing this defconfig.  Skipped.
-   (If -e option is passed, the tool exits immediately on error.)
-
-Finally, you will be asked, Clean up headers? [y/n]:
-
-If you say 'y' here, the unnecessary config defines are removed
-from the config headers (include/configs/\*.h).
-It just uses the regex method, so you should not rely on it.
-Just in case, please do 'git diff' to see what happened.
+Installation
+------------
 
+You may need to install 'python3-asteval' for the 'asteval' module.
 
 How does it work?
 -----------------
 
-This tool runs configuration and builds include/autoconf.mk for every
-defconfig.  The config options defined in Kconfig appear in the .config
-file (unless they are hidden because of unmet dependency.)
+When building a database (`-b`), this tool runs configuration and builds
+include/autoconf.mk for every defconfig.  The config options defined in Kconfig
+appear in the .config file (unless they are hidden because of unmet dependency.)
 On the other hand, the config options defined by board headers are seen
-in include/autoconf.mk.  The tool looks for the specified options in both
-of them to decide the appropriate action for the options.  If the given
-config option is found in the .config, but its value does not match the
-one from the board header, the config option in the .config is replaced
-with the define in the board header.  Then, the .config is synced by
-"make savedefconfig" and the defconfig is updated with it.
-
-For faster processing, this tool handles multi-threading.  It creates
+in include/autoconf.mk.
+
+When resyncing defconfigs (`-s`) the .config is synced by "make savedefconfig"
+and the defconfig is updated with it.
+
+For faster processing, this tool is multi-threaded.  It creates
 separate build directories where the out-of-tree build is run.  The
 temporary build directories are automatically created and deleted as
 needed.  The number of threads are chosen based on the number of the CPU
 cores of your system although you can change it via -j (--jobs) option.
 
+Note that `*.config` fragments are not supported.
 
 Toolchains
 ----------
 
-Appropriate toolchain are necessary to generate include/autoconf.mk
+Appropriate toolchains are necessary to generate include/autoconf.mk
 for all the architectures supported by U-Boot.  Most of them are available
-at the kernel.org site, some are not provided by kernel.org. This tool uses
-the same tools as buildman, so see that tool for setup (e.g. --fetch-arch).
+at the kernel.org site. This tool uses the same tools as
+:doc:`../build/buildman`, so you can use `buildman --fetch-arch` to fetch
+toolchains.
 
 
-Tips and trips
---------------
+Examples
+--------
 
 To sync only X86 defconfigs::
 
-   ./tools/moveconfig.py -s -d <(grep -l X86 configs/*)
+   ./tools/qconfig.py -s -d <(grep -l X86 configs/*)
 
 or::
 
-   grep -l X86 configs/* | ./tools/moveconfig.py -s -d -
+   grep -l X86 configs/* | ./tools/qconfig.py -s -d -
 
 To process CONFIG_CMD_FPGAD only for a subset of configs based on path match::
 
    ls configs/{hrcon*,iocon*,strider*} | \
-       ./tools/moveconfig.py -Cy CONFIG_CMD_FPGAD -d -
+       ./tools/qconfig.py -C CONFIG_CMD_FPGAD -d -
 
 
 Finding boards with particular CONFIG combinations
 --------------------------------------------------
 
-You can use `moveconfig.py` to figure out which boards have a CONFIG enabled, or
+You can use `qconfig.py` to figure out which boards have a CONFIG enabled, or
 which do not. To use it, first build a database::
 
-    ./tools/moveconfig.py -b
+    ./tools/qconfig.py -b
 
 Then you can run queries using the `-f` flag followed by a list of CONFIG terms.
 Each term is CONFIG name, with or without a tilde (~) prefix. The tool searches
 for boards which match the CONFIG name, or do not match if tilde is used. For
 example, to find boards which enabled CONFIG_SCSI but not CONFIG_BLK::
 
-    tools/moveconfig.py -f SCSI ~BLK
+    tools/qconfig.py -f SCSI ~BLK
     3 matches
     pg_wcom_seli8_defconfig highbank_defconfig pg_wcom_expu1_defconfig
 
@@ -158,11 +97,11 @@ each of the x86 defconfig files.
 
 This tool can help find such configs. To use it, first build a database::
 
-    ./tools/moveconfig.py -b
+    ./tools/qconfig.py -b
 
 Then try to query it::
 
-   ./tools/moveconfig.py -i CONFIG_I8042_KEYB
+   ./tools/qconfig.py -i CONFIG_I8042_KEYB
    CONFIG_I8042_KEYB found in 33/5155 defconfigs
    28 : CONFIG_X86
    28 : CONFIG_SA_PCIEX_LENGTH
@@ -193,12 +132,12 @@ indicates that CONFIG_I8042_KEYB is not needed for the remaining 5 boards. Many
 of the options listed are not suitable as they are not related. E.g. it would be
 odd for CONFIG_RAMBASE to imply CONFIG_I8042_KEYB.
 
-Using this search you can reduce the size of moveconfig patches.
+Using this search you can reduce the size of qconfig patches.
 
 You can automatically add 'imply' statements in the Kconfig with the -a
 option::
 
-    ./tools/moveconfig.py -s -i CONFIG_SCSI \
+    ./tools/qconfig.py -s -i CONFIG_SCSI \
             -a CONFIG_ARCH_LS1021A,CONFIG_ARCH_LS1043A
 
 This will add 'imply SCSI' to the two CONFIG options mentioned, assuming that
@@ -220,7 +159,7 @@ the size of their defconfig files.
 
 If you want to add an 'imply' to every imply config in the list, you can use::
 
-    ./tools/moveconfig.py -s -i CONFIG_SCSI -a all
+    ./tools/qconfig.py -s -i CONFIG_SCSI -a all
 
 To control which ones are displayed, use -I <list> where list is a list of
 options (use '-I help' to see possible options and their meaning).
@@ -230,7 +169,7 @@ To skip showing you options that already have an 'imply' attached, use -A.
 When you have finished adding 'imply' options you can regenerate the
 defconfig files for affected boards with something like::
 
-    git show --stat | ./tools/moveconfig.py -s -d -
+    git show --stat | ./tools/qconfig.py -s -d -
 
 This will regenerate only those defconfigs changed in the current commit.
 If you start with (say) 100 defconfigs being changed in the commit, and add
@@ -241,9 +180,9 @@ number of defconfigs changed in the commit.
 Available options
 -----------------
 
- -c, --color
-   Surround each portion of the log with escape sequences to display it
-   in color on the terminal.
+ --nocolour
+   Disables colouring of output. This is normally used when writing to a
+   terminal.
 
  -C, --commit
    Create a git commit with the changes when the operation is complete. A
@@ -275,9 +214,6 @@ Available options
    because SPL related options (mostly prefixed with CONFIG_SPL\_) are
    sometimes blocked by CONFIG_SPL_BUILD ifdef conditionals.
 
- -H, --headers-only
-   Only cleanup the headers; skip the defconfig processing
-
  -j, --jobs
    Specify the number of threads to run simultaneously.  If not specified,
    the number of threads is the same as the number of CPU cores.
@@ -293,10 +229,6 @@ Available options
  -v, --verbose
    Show any build errors as boards are built
 
- -y, --yes
-   Instead of prompting, automatically go ahead with all operations. This
-   includes cleaning up headers, the config whitelist and the README.
-
 To see the complete list of supported options, run::
 
-  tools/moveconfig.py -h
+  tools/qconfig.py -h
-- 
2.42.0.515.g380fc7ccd1-goog

