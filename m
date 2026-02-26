Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E424FD9E1E
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 23:50:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2677083EC8;
	Fri, 27 Feb 2026 00:49:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hGqKZnfI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD76E83F32; Fri, 27 Feb 2026 00:49:16 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E57E683F82
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 00:49:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-8cb38e86cf2so146920385a.1
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 15:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772149750; x=1772754550; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cM3PnxVJM9OkVbTEeFFm7mAFOCk8s53ZBSXTfLwLGmI=;
 b=hGqKZnfI/nRrNFDuYyKcfFx+xhUupHlnUtckXPDAgRtZ55gDACtf6HoxhEYyPbVgk/
 B5Ae2v4UlnAj8k1PQgSlHNmkpo0B5Bl3HeJXKh1HLYwXtFRXT9nNVeEsJ4V/iNnv9B+8
 Le4BXACWadzq1o+aNIH4RBzn0aMQoxxwmZpiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772149750; x=1772754550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cM3PnxVJM9OkVbTEeFFm7mAFOCk8s53ZBSXTfLwLGmI=;
 b=eNxzcW+bDzsRgGvnEp+pSgJn3i0oGS6sDqQvlovNMlIrgILFbiaYzFKOyDfDZ7Bjq4
 UsiBm0SQjay8r4oiUjrxkg700ovJcJ32+89gWI6ERSAUbYb2UFcAnZQKGyDUdQuFC+yx
 ASE6OkYbYjNv9jxqlPICvDfaXu2T96BU7xkwkceEkOnZ6Ah8CAeCiyeuY73to5rwohXE
 JvxpkOk7CRCOScSHJSBMxCUhz9MU33phvoLqy0gsHR3XElgIfHwRqv8P3/i8Od3mPyy+
 P1Xc2Dbv+JGeaKBGXGmQ/OQcvMM5c+hPJTlU921KKH0hq0g6bPR0Zr7QzqnyLmkrxi1O
 HbYw==
X-Gm-Message-State: AOJu0Yz/WL4poVgthtjXXBMo21qTHX/kYF4aQ8jdTIfm0AH645b74Qgh
 NVPqLmGhjIzOcNCNA0AcQRq/f5BOnuXvIiOcnC+9NyYhl9UCpe8vTVtgIY84niz7IaOoXP+RzN0
 b9gU=
X-Gm-Gg: ATEYQzzR5LUAbfnsyKpr1Y8agF4AAZBNwZ/7EGsk2P/nn7TAon3LaCC6HufyuEIDqOv
 hFnmawZ2/64qUooBBRa67jLr3OxHfufXy3j+rHZYdQ7OvVuNm4shzkl6eSrj6nETyDQRvMAxWBc
 Wfq9YAqv0MMemp/1arkdBf2ef38vRlk224o60VeyMPgkZo8wmrpaNeEy4BzGgu9uyDNgbJGxFqv
 5+BR+T5hl9Wrl3N+S1+HkFQP+V5Qsmf9Vd2Qij/U9Vvu4zGliowFyMxyz6tdLGVRUW6DTR4a4Hd
 xZ+JUwkF+yiMiiW79QNELxC2+CMLFPSCpd4wGDTgEeSIts8ycnEOmXvwgTw95HzeGrh1f+BeWvu
 pSW/E/O8vsUGQeWrq95vj0p8/rkEy9nUBDVgv8zJFDUOIhKdFrrvxFKXNVKLEd+ps7lhoiWJlgk
 W5E+0ww/ltN9HDbjvD8g==
X-Received: by 2002:a05:620a:4496:b0:8c7:1a0d:7d9d with SMTP id
 af79cd13be357-8cbc8e54ac7mr92158785a.81.1772149750192; 
 Thu, 26 Feb 2026 15:49:10 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf68a0fbsm322024385a.22.2026.02.26.15.49.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 15:49:09 -0800 (PST)
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
Subject: [RFC PATCH 14/16] binman: test: Move symbol test files to
 test/symbols/
Date: Thu, 26 Feb 2026 16:47:54 -0700
Message-ID: <20260226234802.345968-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226234802.345968-1-sjg@chromium.org>
References: <20260226234802.345968-1-sjg@chromium.org>
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
---

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
index f15a9eb01e1..0ca4d935dae 100644
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

