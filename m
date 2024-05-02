Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B63DC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:43:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40CE388CFE;
	Thu,  2 May 2024 03:34:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qc3Y2O92";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB43988CAC; Thu,  2 May 2024 03:34:21 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3095F88D14
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:34:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-436ee76c3b8so57817161cf.1
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613657; x=1715218457; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vNWVSPlbreaoPCm8YB5SmyBmPlDwoguZzfOs2sS6jwo=;
 b=Qc3Y2O92VkDsy4OAqkUPr1Mr3Nw7v3e7RtFAv7ZGpzSlo0TM+7TNXqrFB1Axjevt3B
 Pr8bjlpZrMR0Lo323zoXbMpZk8bEpJmzRtIhs2vfPbDNN+ZjHsVWiKZOxbAmseCxeq6B
 6RlebDJZEWk2YppdWa9HwI6g8Hm5e2rFd9Yio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613657; x=1715218457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vNWVSPlbreaoPCm8YB5SmyBmPlDwoguZzfOs2sS6jwo=;
 b=s/3FUeqqtnojSCAAqygRAJupv1txT714ZgDIrN+oukw1rcxbHsa4ALJ1SHuECyT1PE
 7CpeM0HSb+DMO13S60AYgYYMpaqNi+XZ1AlKVRDpFSnx1h9LtUtaE+frytevMxEtz39s
 TcIiBP9oMjl5lgeJ1+JIAzySiT7tZMSflR+7+pJoluRNEsGTlgacgmzkHATeST7fuuds
 KWoAA/9uNPOmgKVBcVjU/GnKLl013H6POIyvRoBNQXieZNbr0h98rIXQFNWZ7rJws4vS
 rUncuyiAR3T+Dwk75brdFf8O08G9YcXupoYB2ymHFQq8F8/Ma6iGYrZB80Ip7XbG0zlx
 CU+w==
X-Gm-Message-State: AOJu0Yx2EZAPPq8JGliMhoqAzk2dwJ15k0Kl091ppHzBmvAPZhoW42AL
 nxFWo6V1nmCEZRuT0/2UjOfWMsQnC26PwA6AczKRuoikIaR4Ud99O4bsnxGo/FkJvuQKxlKRd33
 NrAQsYq1V
X-Google-Smtp-Source: AGHT+IHXysDEPeg0UYlBiagy07czCRo3kGpr2w0SkMn+eqqDbMwk1DsG/ni+w9b6j07p9z0OnQKnTQ==
X-Received: by 2002:ac8:7d51:0:b0:43a:e2c7:bf66 with SMTP id
 h17-20020ac87d51000000b0043ae2c7bf66mr4638563qtb.11.1714613656698; 
 Wed, 01 May 2024 18:34:16 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.34.15
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:34:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 81/81] common.h: Remove this file and all references
Date: Wed,  1 May 2024 19:31:38 -0600
Message-Id: <20240502013138.2383421-81-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
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

With all files that had included this file directly having been updated,
we can now remove this file.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 doc/develop/codingstyle.rst           |  8 ++-----
 doc/develop/tests_writing.rst         |  1 -
 include/common.h                      | 33 ---------------------------
 scripts/Makefile.autoconf             |  4 ++--
 scripts/gen_ll_addressable_symbols.sh |  2 +-
 tools/dtoc/dtb_platdata.py            |  3 ---
 tools/dtoc/test_dtoc.py               |  3 ---
 7 files changed, 5 insertions(+), 49 deletions(-)
 delete mode 100644 include/common.h

diff --git a/doc/develop/codingstyle.rst b/doc/develop/codingstyle.rst
index f6248cdcb1e1..fa3cd6aec82e 100644
--- a/doc/develop/codingstyle.rst
+++ b/doc/develop/codingstyle.rst
@@ -110,9 +110,8 @@ Include files
 
 You should follow this ordering in U-Boot. In all cases, they should be listed
 in alphabetical order. First comes headers which are located directly in our
-top-level include diretory. This excludes the common.h header file which is to
-be removed. Second are headers within subdirectories, Finally directory-local
-includes should be listed. See this example:
+top-level include diretory. Second are headers within subdirectories, Finally
+directory-local includes should be listed. See this example:
 
 .. code-block:: C
 
@@ -129,9 +128,6 @@ For files that need to be compiled for the host (e.g. tools), you need to use
 ``#ifndef USE_HOSTCC`` to avoid including U-Boot specific include files. See
 common/image.c for an example.
 
-If you encounter code which still uses <common.h> a patch to remove that and
-replace it with any required include files directly is much appreciated.
-
 If your file uses driver model, include <dm.h> in the C file. Do not include
 dm.h in a header file. Try to use forward declarations (e.g. ``struct
 udevice``) instead.
diff --git a/doc/develop/tests_writing.rst b/doc/develop/tests_writing.rst
index bb1145da268b..44b544fa78b4 100644
--- a/doc/develop/tests_writing.rst
+++ b/doc/develop/tests_writing.rst
@@ -281,7 +281,6 @@ new one of those, you should add a new suite.
 Create a new file in test/ or a subdirectory and define a macro to register the
 suite. For example::
 
-   #include <common.h>
    #include <console.h>
    #include <mapmem.h>
    #include <dm/test.h>
diff --git a/include/common.h b/include/common.h
deleted file mode 100644
index a79c2bb49931..000000000000
--- a/include/common.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Common header file for U-Boot
- *
- * This file still includes quite a few headers that should be included
- * individually as needed. Patches to remove things are welcome.
- *
- * (C) Copyright 2000-2009
- * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
- */
-
-#ifndef __COMMON_H_
-#define __COMMON_H_	1
-
-#ifndef __ASSEMBLY__		/* put C only stuff in this section */
-#include <config.h>
-#include <errno.h>
-#include <time.h>
-#include <linux/types.h>
-#include <linux/string.h>
-#include <stdarg.h>
-#include <stdio.h>
-#include <linux/kernel.h>
-#include <asm/u-boot.h> /* boot information for Linux kernel */
-#include <vsprintf.h>
-#endif	/* __ASSEMBLY__ */
-
-/* Pull in stuff for the build system */
-#ifdef DO_DEPS_ONLY
-# include <env_internal.h>
-#endif
-
-#endif	/* __COMMON_H_ */
diff --git a/scripts/Makefile.autoconf b/scripts/Makefile.autoconf
index 8208ffe22744..b42f9b525fea 100644
--- a/scripts/Makefile.autoconf
+++ b/scripts/Makefile.autoconf
@@ -45,7 +45,7 @@ c_flags := $(KBUILD_CFLAGS) $(KBUILD_CPPFLAGS) $(PLATFORM_CPPFLAGS) \
 
 quiet_cmd_autoconf_dep = GEN     $@
       cmd_autoconf_dep = $(CC) -x c -DDO_DEPS_ONLY -M -MP $(c_flags) \
-	-MQ include/config/auto.conf $(srctree)/include/common.h > $@ || {	\
+	-MQ include/config/auto.conf include/config.h > $@ || {	\
 		rm $@; false;							\
 	}
 include/autoconf.mk.dep: include/config.h FORCE
@@ -70,7 +70,7 @@ quiet_cmd_autoconf = GEN     $@
 
 quiet_cmd_u_boot_cfg = CFG     $@
       cmd_u_boot_cfg = \
-	$(CPP) $(c_flags) $2 -DDO_DEPS_ONLY -dM $(srctree)/include/common.h > $@.tmp && { \
+	$(CPP) $(c_flags) $2 -DDO_DEPS_ONLY -dM include/config.h > $@.tmp && { \
 		grep 'define CONFIG_' $@.tmp | \
 			sed '/define CONFIG_IS_ENABLED(/d;/define CONFIG_IF_ENABLED_INT(/d;/define CONFIG_VAL(/d;' > $@; \
 		rm $@.tmp;						\
diff --git a/scripts/gen_ll_addressable_symbols.sh b/scripts/gen_ll_addressable_symbols.sh
index d0864804aafb..13f670ae0ef0 100755
--- a/scripts/gen_ll_addressable_symbols.sh
+++ b/scripts/gen_ll_addressable_symbols.sh
@@ -10,6 +10,6 @@
 
 set -e
 
-echo '#include <common.h>'
+echo '#include <linux/compiler.h>'
 $@ 2>/dev/null | grep -oe '_u_boot_list_2_[a-zA-Z0-9_]*_2_[a-zA-Z0-9_]*' | \
 	sort -u | sed -e 's/^\(.*\)/extern char \1[];\n__ADDRESSABLE(\1);/'
diff --git a/tools/dtoc/dtb_platdata.py b/tools/dtoc/dtb_platdata.py
index 39f416cfd806..89066e6403fc 100644
--- a/tools/dtoc/dtb_platdata.py
+++ b/tools/dtoc/dtb_platdata.py
@@ -835,7 +835,6 @@ class DtbPlatdata():
 
     def generate_uclasses(self):
         self.out('\n')
-        self.out('#include <common.h>\n')
         self.out('#include <dm.h>\n')
         self.out('#include <dt-structs.h>\n')
         self.out('\n')
@@ -1059,7 +1058,6 @@ class DtbPlatdata():
         self.out('/* Allow use of U_BOOT_DRVINFO() in this file */\n')
         self.out('#define DT_PLAT_C\n')
         self.out('\n')
-        self.out('#include <common.h>\n')
         self.out('#include <dm.h>\n')
         self.out('#include <dt-structs.h>\n')
         self.out('\n')
@@ -1092,7 +1090,6 @@ class DtbPlatdata():
         See the documentation in doc/driver-model/of-plat.rst for more
         information.
         """
-        self.out('#include <common.h>\n')
         self.out('#include <dm.h>\n')
         self.out('#include <dt-structs.h>\n')
         self.out('\n')
diff --git a/tools/dtoc/test_dtoc.py b/tools/dtoc/test_dtoc.py
index 597c93e8a870..c4a0889aebe7 100755
--- a/tools/dtoc/test_dtoc.py
+++ b/tools/dtoc/test_dtoc.py
@@ -63,7 +63,6 @@ C_HEADER = C_HEADER_PRE + '''
 /* Allow use of U_BOOT_DRVINFO() in this file */
 #define DT_PLAT_C
 
-#include <common.h>
 #include <dm.h>
 #include <dt-structs.h>
 '''
@@ -417,7 +416,6 @@ U_BOOT_DRVINFO(spl_test3) = {
 '''
     uclass_text_inst = '''
 
-#include <common.h>
 #include <dm.h>
 #include <dt-structs.h>
 
@@ -521,7 +519,6 @@ DM_UCLASS_INST(testfdt) = {
  * This was generated by dtoc from a .dtb (device tree binary) file.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dt-structs.h>
 
-- 
2.34.1

