Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64085FD9E25
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 23:48:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB01383F2D;
	Fri, 27 Feb 2026 00:48:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KYhdLGJB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEF5583F2A; Fri, 27 Feb 2026 00:48:48 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB59A83F2D
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 00:48:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-8c70b5594f4so144562085a.1
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 15:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772149724; x=1772754524; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y5sGoB5yO5dk8Y/qbG/X2dScZkXG9syRLYlcDST+7C8=;
 b=KYhdLGJBx+3kflsPOcPG8w8XICJ7oyyLc1umC2F3+lw1qDIr450CXX5ohrQQi56CdY
 EbfrjrwEBf5WO998hLuxKJW/quQ6/7LCh10c34iJA6L/0kv+OOD4Uc3/hF218clXHWid
 qwzRDvTfVXOIQ135AVZlZ39JWr1oKpMVNxcKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772149724; x=1772754524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y5sGoB5yO5dk8Y/qbG/X2dScZkXG9syRLYlcDST+7C8=;
 b=KQy0gG+g8/UPv7i4MUXD0MPuNed+ywUhmRq8Oip9X7bNWfSxX/NMq4P/B4Kcwddhci
 7pl4V9EccJbNjwOUh4hw/lt6EdxpXwa789Ff4Vfry0BSvJ5LAETpgymp1w+8XW0f7f0C
 HfxPgyOL5c3x/APbpFo2O9zgkTlpo/s9tvvhsqbYvMuxb6U5TAIOcBBSEtrkl5fXRrYW
 f7S/GgtA6cQyeaYsNM/J8vcZTIESZS6118NKC7CqIn/QRXYtU1P8qOeJdfxldARkXTqM
 34P/jc4JHBYUakgGWV9ZJSE7vQz1OqV8NOHOHf/SmMgcW7dWFmRu+JwiSmXbI3fPO7KJ
 bfNQ==
X-Gm-Message-State: AOJu0YwDhnUMkLBStaen5oNq4ASF8wgSecKPLq95A9XrCI16OSS2T1Qq
 9pC/xQumBkk+lfnkvAvtdmHXW8HTea0u+1JDWJ3MoisXiOrK9e2b+Zxw1Mp+Zbn3UR9ZlhrR+7c
 kwxs=
X-Gm-Gg: ATEYQzyABY4mKBt4hR3k4gmaxhSJ7Bqq0ntSNWExY/7MDEAHAGj3BWeQtR4rER/Jo07
 JR9SW2Li4GE2y7UqkNPwGc8gGuPDbq9g566Xfwvordwao4cX7tj3EInQpmzWsesxIb0SHpEGqtq
 sZmkTtRAvSxakdmp4NIwC+w8899mFmFOwAU743xHisKCsOkoOYFCYDslBbhoRYfJuZhXfJ/e/Dt
 Okp1wVj3GHarYCIcIDV2i2IbxwDXJ4CF0qwDNSJqkdXsqxZDxUJrr52tXzwaR3ZQ7o17qF+BtmI
 kglKM23JGvj0Ttv2fCEm1Qbwlf8zvN8CP+6sZTHaYuhwbcBz53WfuBMjLQpbUjC11kh0Rmv+wfk
 3mBWBrqVvT/MyRUae1mdmQ9whTaAjUgJtGEygoNILyfcP+XN/nD9lW3hL6RN6jiSJp9znPVsss7
 bH1BLzk9ww12fRvz9Liw==
X-Received: by 2002:a05:620a:1990:b0:883:647b:6dec with SMTP id
 af79cd13be357-8cbc8c47961mr112400585a.3.1772149724036; 
 Thu, 26 Feb 2026 15:48:44 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf68a0fbsm322024385a.22.2026.02.26.15.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 15:48:43 -0800 (PST)
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
Subject: [RFC PATCH 02/16] binman: test: Move U-Boot variant test files to
 test/xpl/
Date: Thu, 26 Feb 2026 16:47:42 -0700
Message-ID: <20260226234802.345968-3-sjg@chromium.org>
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

Move about a dozen test files for U-Boot image variants (SPL, TPL,
VPL, DTB, nodtb, bss-pad) into an xpl/ subdirectory. Drop the
numeric prefixes and the redundant u_boot_ filename prefix, and
update all references.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 tools/binman/ftest.py                         | 28 +++++++++----------
 .../test/{036_u_boot_img.dts => xpl/img.dts}  |  0
 .../pack_dtb.dts}                             |  0
 .../spl_bss_pad.dts}                          |  0
 .../spl_dtb.dts}                              |  0
 .../spl_expand.dts}                           |  0
 .../spl_nodtb.dts}                            |  0
 .../test/{078_u_boot_tpl.dts => xpl/tpl.dts}  |  0
 .../tpl_bss_pad.dts}                          |  0
 .../tpl_nodtb.dts}                            |  0
 .../test/{255_u_boot_vpl.dts => xpl/vpl.dts}  |  0
 .../vpl_bss_pad.dts}                          |  0
 .../vpl_nodtb.dts}                            |  0
 13 files changed, 14 insertions(+), 14 deletions(-)
 rename tools/binman/test/{036_u_boot_img.dts => xpl/img.dts} (100%)
 rename tools/binman/test/{026_pack_u_boot_dtb.dts => xpl/pack_dtb.dts} (100%)
 rename tools/binman/test/{047_spl_bss_pad.dts => xpl/spl_bss_pad.dts} (100%)
 rename tools/binman/test/{051_u_boot_spl_dtb.dts => xpl/spl_dtb.dts} (100%)
 rename tools/binman/test/{285_spl_expand.dts => xpl/spl_expand.dts} (100%)
 rename tools/binman/test/{052_u_boot_spl_nodtb.dts => xpl/spl_nodtb.dts} (100%)
 rename tools/binman/test/{078_u_boot_tpl.dts => xpl/tpl.dts} (100%)
 rename tools/binman/test/{193_tpl_bss_pad.dts => xpl/tpl_bss_pad.dts} (100%)
 rename tools/binman/test/{192_u_boot_tpl_nodtb.dts => xpl/tpl_nodtb.dts} (100%)
 rename tools/binman/test/{255_u_boot_vpl.dts => xpl/vpl.dts} (100%)
 rename tools/binman/test/{258_vpl_bss_pad.dts => xpl/vpl_bss_pad.dts} (100%)
 rename tools/binman/test/{256_u_boot_vpl_nodtb.dts => xpl/vpl_nodtb.dts} (100%)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 9cd4317aeed..da3f6952596 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -1178,7 +1178,7 @@ class TestFunctional(unittest.TestCase):
 
     def testPackUbootDtb(self):
         """Test that a device tree can be added to U-Boot"""
-        data = self._DoReadFile('026_pack_u_boot_dtb.dts')
+        data = self._DoReadFile('xpl/pack_dtb.dts')
         self.assertEqual(U_BOOT_NODTB_DATA + U_BOOT_DTB_DATA, data)
 
     def testPackX86RomNoSize(self):
@@ -1362,7 +1362,7 @@ class TestFunctional(unittest.TestCase):
 
     def testUBootImg(self):
         """Test that u-boot.img can be put in a file"""
-        data = self._DoReadFile('036_u_boot_img.dts')
+        data = self._DoReadFile('xpl/img.dts')
         self.assertEqual(U_BOOT_IMG_DATA, data)
 
     def testNoMicrocode(self):
@@ -1454,7 +1454,7 @@ class TestFunctional(unittest.TestCase):
         """Test that we can pad SPL's BSS with zeros"""
         # ELF file with a '__bss_size' symbol
         self._SetupSplElf()
-        data = self._DoReadFile('047_spl_bss_pad.dts')
+        data = self._DoReadFile('xpl/spl_bss_pad.dts')
         self.assertEqual(U_BOOT_SPL_DATA + tools.get_bytes(0, 10) + U_BOOT_DATA,
                          data)
 
@@ -1462,7 +1462,7 @@ class TestFunctional(unittest.TestCase):
         """Test that a missing symbol is detected"""
         self._SetupSplElf('u_boot_ucode_ptr')
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('047_spl_bss_pad.dts')
+            self._DoReadFile('xpl/spl_bss_pad.dts')
         self.assertIn('Expected __bss_size symbol in spl/u-boot-spl',
                       str(e.exception))
 
@@ -1514,13 +1514,13 @@ class TestFunctional(unittest.TestCase):
     def testSplDtb(self):
         """Test that an image with spl/u-boot-spl.dtb can be created"""
         self._SetupSplElf()
-        data = self._DoReadFile('051_u_boot_spl_dtb.dts')
+        data = self._DoReadFile('xpl/spl_dtb.dts')
         self.assertEqual(U_BOOT_SPL_DTB_DATA, data[:len(U_BOOT_SPL_DTB_DATA)])
 
     def testSplNoDtb(self):
         """Test that an image with spl/u-boot-spl-nodtb.bin can be created"""
         self._SetupSplElf()
-        data = self._DoReadFile('052_u_boot_spl_nodtb.dts')
+        data = self._DoReadFile('xpl/spl_nodtb.dts')
         self.assertEqual(U_BOOT_SPL_NODTB_DATA, data[:len(U_BOOT_SPL_NODTB_DATA)])
 
     def checkSymbols(self, dts, base_data, u_boot_offset, entry_args=None,
@@ -2031,7 +2031,7 @@ class TestFunctional(unittest.TestCase):
         """Test that an image with TPL and its device tree can be created"""
         # ELF file with a '__bss_size' symbol
         self._SetupTplElf()
-        data = self._DoReadFile('078_u_boot_tpl.dts')
+        data = self._DoReadFile('xpl/tpl.dts')
         self.assertEqual(U_BOOT_TPL_DATA + U_BOOT_TPL_DTB_DATA, data)
 
     def testUsesPos(self):
@@ -4807,7 +4807,7 @@ class TestFunctional(unittest.TestCase):
     def testTplNoDtb(self):
         """Test that an image with tpl/u-boot-tpl-nodtb.bin can be created"""
         self._SetupTplElf()
-        data = self._DoReadFile('192_u_boot_tpl_nodtb.dts')
+        data = self._DoReadFile('xpl/tpl_nodtb.dts')
         self.assertEqual(U_BOOT_TPL_NODTB_DATA,
                          data[:len(U_BOOT_TPL_NODTB_DATA)])
 
@@ -4815,7 +4815,7 @@ class TestFunctional(unittest.TestCase):
         """Test that we can pad TPL's BSS with zeros"""
         # ELF file with a '__bss_size' symbol
         self._SetupTplElf()
-        data = self._DoReadFile('193_tpl_bss_pad.dts')
+        data = self._DoReadFile('xpl/tpl_bss_pad.dts')
         self.assertEqual(U_BOOT_TPL_DATA + tools.get_bytes(0, 10) + U_BOOT_DATA,
                          data)
 
@@ -4823,7 +4823,7 @@ class TestFunctional(unittest.TestCase):
         """Test that a missing symbol is detected"""
         self._SetupTplElf('u_boot_ucode_ptr')
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('193_tpl_bss_pad.dts')
+            self._DoReadFile('xpl/tpl_bss_pad.dts')
         self.assertIn('Expected __bss_size symbol in tpl/u-boot-tpl',
                       str(e.exception))
 
@@ -6336,13 +6336,13 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test that an image with VPL and its device tree can be created"""
         # ELF file with a '__bss_size' symbol
         self._SetupVplElf()
-        data = self._DoReadFile('255_u_boot_vpl.dts')
+        data = self._DoReadFile('xpl/vpl.dts')
         self.assertEqual(U_BOOT_VPL_DATA + U_BOOT_VPL_DTB_DATA, data)
 
     def testVplNoDtb(self):
         """Test that an image with vpl/u-boot-vpl-nodtb.bin can be created"""
         self._SetupVplElf()
-        data = self._DoReadFile('256_u_boot_vpl_nodtb.dts')
+        data = self._DoReadFile('xpl/vpl_nodtb.dts')
         self.assertEqual(U_BOOT_VPL_NODTB_DATA,
                          data[:len(U_BOOT_VPL_NODTB_DATA)])
 
@@ -6374,7 +6374,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test that a missing symbol is detected"""
         self._SetupVplElf('u_boot_ucode_ptr')
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('258_vpl_bss_pad.dts')
+            self._DoReadFile('xpl/vpl_bss_pad.dts')
         self.assertIn('Expected __bss_size symbol in vpl/u-boot-vpl',
                       str(e.exception))
 
@@ -7028,7 +7028,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             'spl-bss-pad': 'y',
             'spl-dtb': 'y',
         }
-        data = self._DoReadFileDtb('285_spl_expand.dts',
+        data = self._DoReadFileDtb('xpl/spl_expand.dts',
                                    use_expanded=True, entry_args=entry_args)[0]
 
     def testTemplate(self):
diff --git a/tools/binman/test/036_u_boot_img.dts b/tools/binman/test/xpl/img.dts
similarity index 100%
rename from tools/binman/test/036_u_boot_img.dts
rename to tools/binman/test/xpl/img.dts
diff --git a/tools/binman/test/026_pack_u_boot_dtb.dts b/tools/binman/test/xpl/pack_dtb.dts
similarity index 100%
rename from tools/binman/test/026_pack_u_boot_dtb.dts
rename to tools/binman/test/xpl/pack_dtb.dts
diff --git a/tools/binman/test/047_spl_bss_pad.dts b/tools/binman/test/xpl/spl_bss_pad.dts
similarity index 100%
rename from tools/binman/test/047_spl_bss_pad.dts
rename to tools/binman/test/xpl/spl_bss_pad.dts
diff --git a/tools/binman/test/051_u_boot_spl_dtb.dts b/tools/binman/test/xpl/spl_dtb.dts
similarity index 100%
rename from tools/binman/test/051_u_boot_spl_dtb.dts
rename to tools/binman/test/xpl/spl_dtb.dts
diff --git a/tools/binman/test/285_spl_expand.dts b/tools/binman/test/xpl/spl_expand.dts
similarity index 100%
rename from tools/binman/test/285_spl_expand.dts
rename to tools/binman/test/xpl/spl_expand.dts
diff --git a/tools/binman/test/052_u_boot_spl_nodtb.dts b/tools/binman/test/xpl/spl_nodtb.dts
similarity index 100%
rename from tools/binman/test/052_u_boot_spl_nodtb.dts
rename to tools/binman/test/xpl/spl_nodtb.dts
diff --git a/tools/binman/test/078_u_boot_tpl.dts b/tools/binman/test/xpl/tpl.dts
similarity index 100%
rename from tools/binman/test/078_u_boot_tpl.dts
rename to tools/binman/test/xpl/tpl.dts
diff --git a/tools/binman/test/193_tpl_bss_pad.dts b/tools/binman/test/xpl/tpl_bss_pad.dts
similarity index 100%
rename from tools/binman/test/193_tpl_bss_pad.dts
rename to tools/binman/test/xpl/tpl_bss_pad.dts
diff --git a/tools/binman/test/192_u_boot_tpl_nodtb.dts b/tools/binman/test/xpl/tpl_nodtb.dts
similarity index 100%
rename from tools/binman/test/192_u_boot_tpl_nodtb.dts
rename to tools/binman/test/xpl/tpl_nodtb.dts
diff --git a/tools/binman/test/255_u_boot_vpl.dts b/tools/binman/test/xpl/vpl.dts
similarity index 100%
rename from tools/binman/test/255_u_boot_vpl.dts
rename to tools/binman/test/xpl/vpl.dts
diff --git a/tools/binman/test/258_vpl_bss_pad.dts b/tools/binman/test/xpl/vpl_bss_pad.dts
similarity index 100%
rename from tools/binman/test/258_vpl_bss_pad.dts
rename to tools/binman/test/xpl/vpl_bss_pad.dts
diff --git a/tools/binman/test/256_u_boot_vpl_nodtb.dts b/tools/binman/test/xpl/vpl_nodtb.dts
similarity index 100%
rename from tools/binman/test/256_u_boot_vpl_nodtb.dts
rename to tools/binman/test/xpl/vpl_nodtb.dts
-- 
2.43.0

