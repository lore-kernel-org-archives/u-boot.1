Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FF6C3DA66
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 01:18:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 905518651E;
	Thu, 24 Aug 2023 03:18:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XUo2QMen";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5CE88651B; Thu, 24 Aug 2023 03:18:29 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECFC98640E
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 03:18:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-34bbb4b580eso19645365ab.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 18:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692839905; x=1693444705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xCobZR7odq9uGbIETy6jMbiBLMb1hOIjCjPwxyh/+GA=;
 b=XUo2QMen6zkKKv2qlAqKpp4a04tG2Jz3qSNzFZ2Qvo99vpv0sdWb/h5Fq5BvhvtZ3E
 Yt4UBOii9kmQCexgxJBJwdp4acgXD1YQIhfUzJw9zD2AoaCVQcQrDPROTfgT8ftWpBIq
 XLkc4vDkVKp288EK1o86Phev3cqUa3jtsIuC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692839905; x=1693444705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xCobZR7odq9uGbIETy6jMbiBLMb1hOIjCjPwxyh/+GA=;
 b=aiNWZPHITGyMmnjJ6Y4KVves61H7oY3+KNcff0aHozKHLn296Chx72RLqTEFGbpglu
 S+uSyWB7XVY2W9NqhzrpfAHTZir2jmaVUm/q12T+6TTs4dOkmoquUQ4unicaSiRiv5FE
 19+CEF1MgUJP1HOH4ril1FigbuRmFSbKRxgqrFTAH+mT3IymNea3YGMH3qRC8E1+ZOc1
 +Z2uvm95VpqDWo7yptyMjJ0YuwzKRjLs1k2Vd9ngUdia4pKD3RiCQTiA06E/3XECm5mF
 j8CNMnEAukuPivfFbFMJiv0SNC4DxXQymyjFFlblXoI438C8WTdKnGrHz+9zKQB7wY+m
 PwWQ==
X-Gm-Message-State: AOJu0YzJ7L97+SRsrLUB418RsuRGYXHbK/RCEw2S2+2/ELvbmLMmT6gM
 XwbsB+spRe2VkdpTshxsRcOLgxH4dV+LjMJH2Dk=
X-Google-Smtp-Source: AGHT+IFHzmSRhyBwv1UJ2B1Ov78C3fEaDWRXR3SlJ2+RfuMgtZWxL94/nMdb0O9UkLlUQSIEZWlmsg==
X-Received: by 2002:a92:c5c9:0:b0:348:8b42:47d with SMTP id
 s9-20020a92c5c9000000b003488b42047dmr3872024ilt.28.1692839905566; 
 Wed, 23 Aug 2023 18:18:25 -0700 (PDT)
Received: from localhost.localdomain (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 g10-20020a0566380c4a00b0042b3bf0baacsm4053793jal.138.2023.08.23.18.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 18:18:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH 2/2] Revert "binman: Add a temporary hack for duplicate
 phandles"
Date: Wed, 23 Aug 2023 19:18:02 -0600
Message-ID: <20230824011804.1501058-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824011804.1501058-1-sjg@chromium.org>
References: <20230824011804.1501058-1-sjg@chromium.org>
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

The affected boards have been fixed, so drop this hack.

This reverts commit 288ae53cb73605500b7fc01e5919753c878466be.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 Makefile                |  6 ------
 tools/binman/cmdline.py |  2 --
 tools/binman/control.py |  5 -----
 tools/dtoc/fdt.py       | 12 ++++--------
 4 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/Makefile b/Makefile
index 9b90204bfe6b..033daf1695c0 100644
--- a/Makefile
+++ b/Makefile
@@ -1328,11 +1328,6 @@ u-boot.ldr:	u-boot
 # Use 'make BINMAN_VERBOSE=3' to set vebosity level
 default_dt := $(if $(DEVICE_TREE),$(DEVICE_TREE),$(CONFIG_DEFAULT_DEVICE_TREE))
 
-# Temporary workaround for Venice boards
-ifneq ($(CONFIG_TARGET_IMX8MM_VENICE),$(CONFIG_TARGET_IMX8MN_VENICE),$(CONFIG_TARGET_IMX8MP_VENICE),)
-ignore_dups := --ignore-dup-phandles
-endif
-
 quiet_cmd_binman = BINMAN  $@
 cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
 		$(foreach f,$(BINMAN_TOOLPATHS),--toolpath $(f)) \
@@ -1354,7 +1349,6 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
 		-a spl-dtb=$(CONFIG_SPL_OF_REAL) \
 		-a tpl-dtb=$(CONFIG_TPL_OF_REAL) \
 		-a pre-load-key-path=${PRE_LOAD_KEY_PATH} \
-		$(ignore_dups) \
 		$(BINMAN_$(@F))
 
 OBJCOPYFLAGS_u-boot.ldr.hex := -I binary -O ihex
diff --git a/tools/binman/cmdline.py b/tools/binman/cmdline.py
index 39c61c2c0322..9632ec115e5d 100644
--- a/tools/binman/cmdline.py
+++ b/tools/binman/cmdline.py
@@ -126,8 +126,6 @@ controlled by a description in the board device tree.'''
             help='Comma-separated list of bintools to consider missing (for testing)')
     build_parser.add_argument('-i', '--image', type=str, action='append',
             help='Image filename to build (if not specified, build all)')
-    build_parser.add_argument('--ignore-dup-phandles', action='store_true',
-            help='Temporary option to ignore duplicate phandles')
     build_parser.add_argument('-I', '--indir', action='append',
             help='Add a path to the list of directories to use for input files')
     build_parser.add_argument('-m', '--map', action='store_true',
diff --git a/tools/binman/control.py b/tools/binman/control.py
index 459489558125..c6d3205b8c25 100644
--- a/tools/binman/control.py
+++ b/tools/binman/control.py
@@ -22,7 +22,6 @@ from binman import bintool
 from binman import cbfs_util
 from binman import elf
 from binman import entry
-from dtoc import fdt
 from dtoc import fdt_util
 from u_boot_pylib import command
 from u_boot_pylib import tools
@@ -817,10 +816,6 @@ def Binman(args):
         cbfs_util.VERBOSE = args.verbosity > 2
         state.use_fake_dtb = args.fake_dtb
 
-        # Temporary hack
-        if args.ignore_dup_phandles: # pragma: no cover
-            fdt.IGNORE_DUP_PHANDLES = True
-
         # Normally we replace the 'u-boot' etype with 'u-boot-expanded', etc.
         # When running tests this can be disabled using this flag. When not
         # updating the FDT in image, it is not needed by binman, but we use it
diff --git a/tools/dtoc/fdt.py b/tools/dtoc/fdt.py
index 0b20d52f3136..5963925146a5 100644
--- a/tools/dtoc/fdt.py
+++ b/tools/dtoc/fdt.py
@@ -15,9 +15,6 @@ from libfdt import QUIET_NOTFOUND
 from u_boot_pylib import tools
 from u_boot_pylib import tout
 
-# Temporary hack
-IGNORE_DUP_PHANDLES = False
-
 # This deals with a device tree, presenting it as an assortment of Node and
 # Prop objects, representing nodes and properties, respectively. This file
 # contains the base classes and defines the high-level API. You can use
@@ -342,11 +339,10 @@ class Node:
         if phandle:
             dup = self._fdt.phandle_to_node.get(phandle)
             if dup:
-                if not IGNORE_DUP_PHANDLES:
-                    raise ValueError(
-                        f'Duplicate phandle {phandle} in nodes {dup.path} and {self.path}')
-            else:
-                self._fdt.phandle_to_node[phandle] = self
+                raise ValueError(
+                    f'Duplicate phandle {phandle} in nodes {dup.path} and {self.path}')
+
+            self._fdt.phandle_to_node[phandle] = self
 
         offset = fdt_obj.first_subnode(self.Offset(), QUIET_NOTFOUND)
         while offset >= 0:
-- 
2.42.0.rc1.204.g551eb34607-goog

