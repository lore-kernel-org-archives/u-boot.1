Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB45FCC050
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 18:16:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70DAB8402F;
	Fri,  6 Mar 2026 19:14:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dzcUAd+H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DCCF8402F; Fri,  6 Mar 2026 19:14:11 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1BB68382A
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 19:14:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-8cb5c9ba82bso1498256785a.2
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 10:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772820846; x=1773425646; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rMe7GwndHKiAq8L2By8CItADKTCSSX79rLLaf5mshVM=;
 b=dzcUAd+HKcN0nSos51PYe5galyjm9dHn5x1Gu7LAZj0/oq8WbteINb8kx6el0Uv1ab
 Uw8pM3kvQYrlNQjgLLS63GybVQ0ZCjKe/tB8FgDemrFy9CE3Y5qvy74z0kIxPCLgAJda
 RBWFPlFGq2lONkITDsu0B7sh17V9iI3kXCniw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772820846; x=1773425646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rMe7GwndHKiAq8L2By8CItADKTCSSX79rLLaf5mshVM=;
 b=qBCDVEeEQml1R+pEBbXn+JcGfcOpnWq9UyWLIJBWBw5wS4YckENKLIH9sZrGzDjYSh
 zCbQRMmK9xuqkQgA3jKYf5IZ+nYRDiqAMg8/Z4YK55BnIGDpqPIHt5uOMpYtTnFLmy7M
 XT8LCRQw6C8XhWo4eY/KLWUUOa8A26Bex6lc+53HzSsfILU/TFdVAv5YBfBXcj6xd+ZX
 wV9k9yZq1PJvWlxdTc5nye7hIUS4VpJ7lgZ3q3jNOCM6R1+wzgFqy/lE5uM7z9gGOkUi
 Hy1r5So9wY7plKXt3zBb5NE3rJlD1PA0a2JKuAJ7WK1KU1lCullKnKIwkDpD75JJzx0v
 eZSg==
X-Gm-Message-State: AOJu0YwaBZxFpbJ50u5xhfEB28Y6FYQEzAbqAXntU0GG9cbiFJsE5T5q
 kivQNgmk22FzLlaWjPe3oQsp7MbiLVjJLy5bAM2B8g2yRtw920vZb6Tq4BjaFP5WXBIyAvQgfsB
 a3fI=
X-Gm-Gg: ATEYQzzEejXEvsKe64T6By3skMM+su0tIR9nkdwP/6VZIsTGRIxgt5/OwoYjS7Fg6y/
 4PajzzfnWmgj4ikizPL22b0C5hOxQchxEmZAljGUcnAER2i2ggPFHT655MNI21875tK562tEKnP
 oMXr6szgVuhuVNSjQOxVr9VYtyMKXFJX76P/Tv+hX+DC1knU8/kuFG7iPiqqjU0v/zWqKI6zlWA
 D/yZ4Palv25V3jFN+WDqmL4RjECi5auaag/DFTrJqvxGHjmy0dH/3TqnGRark3xsxwHofHt9G/m
 3W10/2JgNENMW0Atq7un+lG6esKzpJb5+WSitkW/Np/pHVZ7yuL/9fQG+iLCsn3gGDXD5bUuwau
 cj8Bq0Lu67TJGmS7G2Lmf2blJ0jFNkv4MblO7BH6xuqxAy00Im+jE+e1YfSl+xxhAjrkEyf35Li
 9KTwZObuGQ797TOv2pBQ==
X-Received: by 2002:a05:620a:7114:b0:8ca:3c67:891c with SMTP id
 af79cd13be357-8cd6d51bcadmr447706385a.71.1772820844709; 
 Fri, 06 Mar 2026 10:14:04 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f5736c0sm155930885a.49.2026.03.06.10.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 10:14:03 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v2 15/23] binman: test: Move symbol test files to test/symbols/
Date: Fri,  6 Mar 2026 11:12:43 -0700
Message-ID: <20260306181304.2426352-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306181304.2426352-1-sjg@chromium.org>
References: <20260306181304.2426352-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

Move about 10 test files for binman symbol patching into a symbols/
subdirectory. Drop the numeric prefixes and the redundant symbols_
filename prefix, and update all references.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v1)

 tools/binman/ftest.py                         | 24 +++++++++----------
 .../base.dts}                                 |  0
 .../base_expand.dts}                          |  0
 .../comp.dts}                                 |  0
 .../disable.dts}                              |  0
 .../{260_symbols_elf.dts => symbols/elf.dts}  |  0
 .../expand.dts}                               |  0
 .../nodtb.dts}                                |  0
 .../{187_symbols_sub.dts => symbols/sub.dts}  |  0
 .../{053_symbols.dts => symbols/symbols.dts}  |  0
 .../{149_symbols_tpl.dts => symbols/tpl.dts}  |  0
 11 files changed, 12 insertions(+), 12 deletions(-)
 rename tools/binman/test/{336_symbols_base.dts => symbols/base.dts} (100%)
 rename tools/binman/test/{337_symbols_base_expand.dts => symbols/base_expand.dts} (100%)
 rename tools/binman/test/{338_symbols_comp.dts => symbols/comp.dts} (100%)
 rename tools/binman/test/{282_symbols_disable.dts => symbols/disable.dts} (100%)
 rename tools/binman/test/{260_symbols_elf.dts => symbols/elf.dts} (100%)
 rename tools/binman/test/{197_symbols_expand.dts => symbols/expand.dts} (100%)
 rename tools/binman/test/{196_symbols_nodtb.dts => symbols/nodtb.dts} (100%)
 rename tools/binman/test/{187_symbols_sub.dts => symbols/sub.dts} (100%)
 rename tools/binman/test/{053_symbols.dts => symbols/symbols.dts} (100%)
 rename tools/binman/test/{149_symbols_tpl.dts => symbols/tpl.dts} (100%)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 3743071eb85..0e4f349aae9 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -1611,11 +1611,11 @@ class TestFunctional(unittest.TestCase):
 
     def testSymbols(self):
         """Test binman can assign symbols embedded in U-Boot"""
-        self.checkSymbols('053_symbols.dts', U_BOOT_SPL_DATA, 0x1c)
+        self.checkSymbols('symbols/symbols.dts', U_BOOT_SPL_DATA, 0x1c)
 
     def testSymbolsNoDtb(self):
         """Test binman can assign symbols embedded in U-Boot SPL"""
-        self.checkSymbols('196_symbols_nodtb.dts',
+        self.checkSymbols('symbols/nodtb.dts',
                           U_BOOT_SPL_NODTB_DATA + U_BOOT_SPL_DTB_DATA,
                           0x38)
 
@@ -3833,7 +3833,7 @@ class TestFunctional(unittest.TestCase):
         """Test binman can assign symbols embedded in U-Boot TPL in a section"""
         self._SetupSplElf('u_boot_binman_syms')
         self._SetupTplElf('u_boot_binman_syms')
-        self._CheckSymbolsTplSection('149_symbols_tpl.dts',
+        self._CheckSymbolsTplSection('symbols/tpl.dts',
                                      [0x04, 0x20, 0x10 + 0x3c, 0x04])
 
     def testSymbolsTplSectionX86(self):
@@ -4756,7 +4756,7 @@ class TestFunctional(unittest.TestCase):
 
     def testSymbolsSubsection(self):
         """Test binman can assign symbols from a subsection"""
-        self.checkSymbols('187_symbols_sub.dts', U_BOOT_SPL_DATA, 0x1c)
+        self.checkSymbols('symbols/sub.dts', U_BOOT_SPL_DATA, 0x1c)
 
     def testReadImageEntryArg(self):
         """Test reading an image that would need an entry arg to generate"""
@@ -5007,7 +5007,7 @@ class TestFunctional(unittest.TestCase):
         entry_args = {
             'spl-dtb': '1',
         }
-        self.checkSymbols('197_symbols_expand.dts', U_BOOT_SPL_NODTB_DATA +
+        self.checkSymbols('symbols/expand.dts', U_BOOT_SPL_NODTB_DATA +
                           U_BOOT_SPL_DTB_DATA, 0x38,
                           entry_args=entry_args, use_expanded=True)
 
@@ -6406,7 +6406,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self._SetupTplElf('u_boot_binman_syms')
         self._SetupVplElf('u_boot_binman_syms')
         self._SetupSplElf('u_boot_binman_syms')
-        data = self._DoReadFileDtb('260_symbols_elf.dts')[0]
+        data = self._DoReadFileDtb('symbols/elf.dts')[0]
         image_fname = tools.get_output_filename('image.bin')
 
         image = control.images['image']
@@ -6449,7 +6449,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         try:
             elf.ELF_TOOLS = False
             with self.assertRaises(ValueError) as exc:
-                self._DoReadFileDtb('260_symbols_elf.dts')
+                self._DoReadFileDtb('symbols/elf.dts')
         finally:
             elf.ELF_TOOLS = True
         self.assertIn(
@@ -6987,7 +6987,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testSymbolNoWrite(self):
         """Test disabling of symbol writing"""
         self._SetupSplElf()
-        self.checkSymbols('282_symbols_disable.dts', U_BOOT_SPL_DATA, 0x1c,
+        self.checkSymbols('symbols/disable.dts', U_BOOT_SPL_DATA, 0x1c,
                           no_write_symbols=True)
 
     def testSymbolNoWriteExpanded(self):
@@ -6995,7 +6995,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         entry_args = {
             'spl-dtb': '1',
         }
-        self.checkSymbols('282_symbols_disable.dts', U_BOOT_SPL_NODTB_DATA +
+        self.checkSymbols('symbols/disable.dts', U_BOOT_SPL_NODTB_DATA +
                           U_BOOT_SPL_DTB_DATA, 0x38,
                           entry_args=entry_args, use_expanded=True,
                           no_write_symbols=True)
@@ -7874,7 +7874,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testSymbolsBase(self):
         """Test handling of symbols-base"""
-        self.checkSymbols('336_symbols_base.dts', U_BOOT_SPL_DATA, 0x1c,
+        self.checkSymbols('symbols/base.dts', U_BOOT_SPL_DATA, 0x1c,
                           symbols_base=0)
 
     def testSymbolsBaseExpanded(self):
@@ -7882,7 +7882,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         entry_args = {
             'spl-dtb': '1',
         }
-        self.checkSymbols('337_symbols_base_expand.dts', U_BOOT_SPL_NODTB_DATA +
+        self.checkSymbols('symbols/base_expand.dts', U_BOOT_SPL_NODTB_DATA +
                           U_BOOT_SPL_DTB_DATA, 0x38,
                           entry_args=entry_args, use_expanded=True,
                           symbols_base=0)
@@ -7890,7 +7890,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testSymbolsCompressed(self):
         """Test binman complains about symbols from a compressed section"""
         with terminal.capture() as (stdout, stderr):
-            self.checkSymbols('338_symbols_comp.dts', U_BOOT_SPL_DATA, None)
+            self.checkSymbols('symbols/comp.dts', U_BOOT_SPL_DATA, None)
         out = stdout.getvalue()
         self.assertIn('Symbol-writing: no value for /binman/section/u-boot',
                       out)
diff --git a/tools/binman/test/336_symbols_base.dts b/tools/binman/test/symbols/base.dts
similarity index 100%
rename from tools/binman/test/336_symbols_base.dts
rename to tools/binman/test/symbols/base.dts
diff --git a/tools/binman/test/337_symbols_base_expand.dts b/tools/binman/test/symbols/base_expand.dts
similarity index 100%
rename from tools/binman/test/337_symbols_base_expand.dts
rename to tools/binman/test/symbols/base_expand.dts
diff --git a/tools/binman/test/338_symbols_comp.dts b/tools/binman/test/symbols/comp.dts
similarity index 100%
rename from tools/binman/test/338_symbols_comp.dts
rename to tools/binman/test/symbols/comp.dts
diff --git a/tools/binman/test/282_symbols_disable.dts b/tools/binman/test/symbols/disable.dts
similarity index 100%
rename from tools/binman/test/282_symbols_disable.dts
rename to tools/binman/test/symbols/disable.dts
diff --git a/tools/binman/test/260_symbols_elf.dts b/tools/binman/test/symbols/elf.dts
similarity index 100%
rename from tools/binman/test/260_symbols_elf.dts
rename to tools/binman/test/symbols/elf.dts
diff --git a/tools/binman/test/197_symbols_expand.dts b/tools/binman/test/symbols/expand.dts
similarity index 100%
rename from tools/binman/test/197_symbols_expand.dts
rename to tools/binman/test/symbols/expand.dts
diff --git a/tools/binman/test/196_symbols_nodtb.dts b/tools/binman/test/symbols/nodtb.dts
similarity index 100%
rename from tools/binman/test/196_symbols_nodtb.dts
rename to tools/binman/test/symbols/nodtb.dts
diff --git a/tools/binman/test/187_symbols_sub.dts b/tools/binman/test/symbols/sub.dts
similarity index 100%
rename from tools/binman/test/187_symbols_sub.dts
rename to tools/binman/test/symbols/sub.dts
diff --git a/tools/binman/test/053_symbols.dts b/tools/binman/test/symbols/symbols.dts
similarity index 100%
rename from tools/binman/test/053_symbols.dts
rename to tools/binman/test/symbols/symbols.dts
diff --git a/tools/binman/test/149_symbols_tpl.dts b/tools/binman/test/symbols/tpl.dts
similarity index 100%
rename from tools/binman/test/149_symbols_tpl.dts
rename to tools/binman/test/symbols/tpl.dts
-- 
2.43.0

