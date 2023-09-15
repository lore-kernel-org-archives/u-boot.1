Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A65EEAA7D
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 00:27:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA1848699B;
	Fri, 15 Sep 2023 02:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fKUsL/En";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85530869F7; Fri, 15 Sep 2023 02:23:11 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38BA686A82
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 02:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7926a450a0aso59812239f.3
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 17:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694737388; x=1695342188; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bx2F5Jro7q3Ly4vMNeVvXNbnA3gkyktVdSbZbxje81k=;
 b=fKUsL/EnmEwsrkVfsnf+95gOYPIrKr6IWGH74VeUTRplXinqZ7OZr14X1a+0TeJKq6
 xDjM1hBt9cQ78JyAWVXrKfAFBI6tY8cr8qjTC4C1gZgQCrI1hlCwPLwO5YfssVkb2vNg
 OnhDqVvSp0diN5CIINpdSj9qHTcOgJGfCAMYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694737388; x=1695342188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bx2F5Jro7q3Ly4vMNeVvXNbnA3gkyktVdSbZbxje81k=;
 b=vYnqUmQflvN+5LQaBaXGmOVJQam24PWdNR70F7zJhW8rJ0flxYZBt5J0enLS1xCwfw
 JqoHGW1vdPFbCiO1EmKCIs9lfYTwKjkyS2aplCgxAv6CO5qFFY+WoB3ZHfMUEMjhHu+s
 jyM0dIpHA/dUkecZzRAhCxQGmfeO/ucbWnKEzNCONhZbSn9wHBOxch1xLCkSDoQylKGA
 mez42IEeV02DnMEmOw6CUr6QAVSTllzUuPWwix8t+ClOb1vpORsn74YCR3U6hS0wcSrN
 5cUAEDQOQhuV0ymRS/DkhOxXavQbLXZ1YPwD0y9DKSK+YriWSLQYGcAM+yiahCDJCp8k
 lL8A==
X-Gm-Message-State: AOJu0YwQQmd8uEa7GwnbYr4xRafvmzGuYGDV8I6cN2RMXVEzXpa8oFJl
 /VykKbZ66UM1wDDJPwuDCMxoH1hnBq4VXOcONsg=
X-Google-Smtp-Source: AGHT+IHGkaJ33tVrfTA0YnK8ojAYwHzf04zVA+tWPJWu3u1jSxUQYxiI09vL2Cc5Ouh8sE56mFWD9Q==
X-Received: by 2002:a6b:a04:0:b0:795:8805:1378 with SMTP id
 z4-20020a6b0a04000000b0079588051378mr46709ioi.9.1694737387692; 
 Thu, 14 Sep 2023 17:23:07 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 i23-20020a5e8517000000b007836e9ff198sm744796ioj.55.2023.09.14.17.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 17:23:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 27/27] qconfig: Update the documentation
Date: Thu, 14 Sep 2023 18:22:29 -0600
Message-ID: <20230915002236.798760-28-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230915002236.798760-1-sjg@chromium.org>
References: <20230915002236.798760-1-sjg@chromium.org>
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

Changes in v2:
- Reinstate the -C option

 doc/develop/index.rst                       |   2 +-
 doc/develop/{moveconfig.rst => qconfig.rst} | 144 +++++---------------
 2 files changed, 38 insertions(+), 108 deletions(-)
 rename doc/develop/{moveconfig.rst => qconfig.rst} (61%)

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
similarity index 61%
rename from doc/develop/moveconfig.rst
rename to doc/develop/qconfig.rst
index ad8596e6c61a..111e2b2545d9 100644
--- a/doc/develop/moveconfig.rst
+++ b/doc/develop/qconfig.rst
@@ -1,100 +1,37 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-moveconfig - Migrating and querying CONFIG options
-==================================================
+qconfig - Querying CONFIG options
+=================================
 
-Since Kconfig was introduced to U-Boot, we have worked on moving
-config options from headers to Kconfig (defconfig).
+It is not possible to see all the CONFIG options used by a board without
+building its `.config` file. This tool allowing this to be done efficiently for
+all boards, or a subset, writing the results to a unified database file.
 
-This tool intends to help this tremendous work.
+This database can be queried, to find boards which used a certain combination
+of options, to aid in discovering Kconfig options which imply others.
+
+The tool also permits syncing of defconfigs, which corrects the ordering and
+drops options which are implied by others.
+
+Finally, it allow scanning the source code to look for inconsistencies in the
+use of Kconfig options.
 
 Installing
 ----------
 
 You may need to install 'python3-asteval' for the 'asteval' module.
 
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
-
- - Move 'CONFIG\_... '
-   This config option was moved to the defconfig
-
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
-
-
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
+in include/autoconf.mk.
+
+When resyncing defconfigs (`-s`) the .config is synced by "make savedefconfig"
+and the defconfig is updated with it.
 
 For faster processing, this tool handles multi-threading.  It creates
 separate build directories where the out-of-tree build is run.  The
@@ -109,7 +46,7 @@ Toolchains
 Appropriate toolchain are necessary to generate include/autoconf.mk
 for all the architectures supported by U-Boot.  Most of them are available
 at the kernel.org site, some are not provided by kernel.org. This tool uses
-the same tools as buildman, so see that tool for setup (e.g. --fetch-arch).
+the same tools as buildman, so see that tool for setup (e.g. `--fetch-arch`).
 
 
 Tips and trips
@@ -117,32 +54,32 @@ Tips and trips
 
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
 
@@ -158,11 +95,11 @@ each of the x86 defconfig files.
 
 This tool can help find such configs. To use it, first build a database::
 
-    ./tools/moveconfig.py -b
+    ./tools/qconfig.py -b
 
 Then try to query it::
 
-   ./tools/moveconfig.py -i CONFIG_I8042_KEYB
+   ./tools/qconfig.py -i CONFIG_I8042_KEYB
    CONFIG_I8042_KEYB found in 33/5155 defconfigs
    28 : CONFIG_X86
    28 : CONFIG_SA_PCIEX_LENGTH
@@ -193,12 +130,12 @@ indicates that CONFIG_I8042_KEYB is not needed for the remaining 5 boards. Many
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
@@ -220,7 +157,7 @@ the size of their defconfig files.
 
 If you want to add an 'imply' to every imply config in the list, you can use::
 
-    ./tools/moveconfig.py -s -i CONFIG_SCSI -a all
+    ./tools/qconfig.py -s -i CONFIG_SCSI -a all
 
 To control which ones are displayed, use -I <list> where list is a list of
 options (use '-I help' to see possible options and their meaning).
@@ -230,7 +167,7 @@ To skip showing you options that already have an 'imply' attached, use -A.
 When you have finished adding 'imply' options you can regenerate the
 defconfig files for affected boards with something like::
 
-    git show --stat | ./tools/moveconfig.py -s -d -
+    git show --stat | ./tools/qconfig.py -s -d -
 
 This will regenerate only those defconfigs changed in the current commit.
 If you start with (say) 100 defconfigs being changed in the commit, and add
@@ -241,9 +178,9 @@ number of defconfigs changed in the commit.
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
@@ -275,9 +212,6 @@ Available options
    because SPL related options (mostly prefixed with CONFIG_SPL\_) are
    sometimes blocked by CONFIG_SPL_BUILD ifdef conditionals.
 
- -H, --headers-only
-   Only cleanup the headers; skip the defconfig processing
-
  -j, --jobs
    Specify the number of threads to run simultaneously.  If not specified,
    the number of threads is the same as the number of CPU cores.
@@ -293,10 +227,6 @@ Available options
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
2.42.0.459.ge4e396fd5e-goog

