Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67519FCC055
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 18:14:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1EE683FA3;
	Fri,  6 Mar 2026 19:13:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Lfm1q8yd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC19783B86; Fri,  6 Mar 2026 19:13:38 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F03083F98
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 19:13:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-8cb5c9ba82bso1498196085a.2
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 10:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772820815; x=1773425615; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/y3Lw/Z/15xzcUGuN0zzbY0k582tyjpy8Iz/nSBf7mg=;
 b=Lfm1q8ydZ4MKohsq4mN0c+SEc181Tcn0zOXvWnLzSY6vlkVcHbac31RbRXwKruIcfS
 QUpOCIXsPwqsaI+zuONw6s9tsOhwZ+oJ6WWaHP07rS4yIjW3BQMPwzRIHLxm79/auVYU
 9Q8VEqM+zdNmd5d75DWdMLLZ2IYXeAoeVbMEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772820815; x=1773425615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/y3Lw/Z/15xzcUGuN0zzbY0k582tyjpy8Iz/nSBf7mg=;
 b=XEo87TDuYDZZ4fl8k/92cicpMCXmoUYDymDCRhbAjl+7kQkgp9k2Z0zVFTuqhkwVRs
 +CrOKStvtPpZmjUhGVrqK4P8OYsA7s9iu3m7kqo0GPT7ndaSnmpniBCCyXWAFC9tNqWy
 Ee9D4fKyvTnIRpeFnesLeJBhZCVWmaPu88uudkCQM1wdhSEyltqHpLeqCwlSQUpIgMzj
 AedbfGDeXf8zKaywy0eU2F1WndzdWptFcJL7k6Xj9A7YhyRIOlxHm5963se3MBZ3PXN/
 dYqL+w3nvAroAuCxZweAxoMvh+Im/AWId0OHi9uIaOjVKdE1yr8Y3YtrZiB1+8WPR8uC
 nlRA==
X-Gm-Message-State: AOJu0Yyr5I21IqCcWR49jcBLbIbV+vkgX/5Ui09CK6pcYrJT8zsxCkxf
 sXcys7Inhi+/4vKtdnh6YHqDihm+gUKgtA9EPrnsX3EGgJqm0J5vLlGzS7RJQVr/ji3fptV+GAG
 6tUg=
X-Gm-Gg: ATEYQzw0CzQXNx6eX0NU3nTAWsDVRm3j0GO8YNgPZLjmRXWRxWVOUOJLnvYwGRgMf/F
 6HOKsrdomvmlhapURHPiaI5DePc1n+7Odf9Gc4HhkxJPYFdMcVCm2p/efLLmSTXVIzSBdy9HnmC
 SGrKqdFBGOIwyZTr45SRjwWP7PLLD/5SvbgyIZTtks/mVLxAOZOb5hrRvzQRLgf9sAfFH2Htcmw
 H5BD7yiNMSjJIjJzFIfWDhblOnMabSS+AwxcephPsZRQA9yB214ZUi7Dg/B5yCG4q+IPuJ/jHSq
 px96e6Bq8Sh2gwDwCFHsbkE+4LrtrP3YNlQTpWWfkS6eSBw4tKBFSQy2mLQrcz1k/KycEjVD+Ys
 RXVomL5zI2uOJ92/UGw1sp+WbdFo4kiNVsLNIu8GR4c2gv3fWc8zur+LEr4RHQE8h0jhm9bGnM1
 aENmd4A4N2zuFSS+YtnONsBsHI9HX3
X-Received: by 2002:a05:620a:7004:b0:8ca:2bab:a0f9 with SMTP id
 af79cd13be357-8cd6d3fadffmr434554285a.1.1772820814660; 
 Fri, 06 Mar 2026 10:13:34 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f5736c0sm155930885a.49.2026.03.06.10.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 10:13:34 -0800 (PST)
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
Subject: [PATCH v2 03/23] binman: test: Move U-Boot variant test files to
 test/xpl/
Date: Fri,  6 Mar 2026 11:12:31 -0700
Message-ID: <20260306181304.2426352-4-sjg@chromium.org>
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

Move about a dozen test files for U-Boot image variants (SPL, TPL,
VPL, DTB, nodtb, bss-pad) into an xpl/ subdirectory. Drop the
numeric prefixes and the redundant u_boot_ filename prefix, and
update all references.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

Changes in v2:
- Rename single-node DTS files to match their entry-type node name

 tools/binman/ftest.py                         | 28 +++++++++----------
 .../pack_dtb.dts}                             |  0
 .../spl_bss_pad.dts}                          |  0
 .../test/{078_u_boot_tpl.dts => xpl/tpl.dts}  |  0
 .../tpl_bss_pad.dts}                          |  0
 .../u-boot-img.dts}                           |  0
 .../u-boot-spl-dtb.dts}                       |  0
 .../u-boot-spl-nodtb.dts}                     |  0
 .../u-boot-spl.dts}                           |  0
 .../u-boot-tpl-nodtb.dts}                     |  0
 .../u-boot-vpl-nodtb.dts}                     |  0
 .../test/{255_u_boot_vpl.dts => xpl/vpl.dts}  |  0
 .../vpl_bss_pad.dts}                          |  0
 13 files changed, 14 insertions(+), 14 deletions(-)
 rename tools/binman/test/{026_pack_u_boot_dtb.dts => xpl/pack_dtb.dts} (100%)
 rename tools/binman/test/{047_spl_bss_pad.dts => xpl/spl_bss_pad.dts} (100%)
 rename tools/binman/test/{078_u_boot_tpl.dts => xpl/tpl.dts} (100%)
 rename tools/binman/test/{193_tpl_bss_pad.dts => xpl/tpl_bss_pad.dts} (100%)
 rename tools/binman/test/{036_u_boot_img.dts => xpl/u-boot-img.dts} (100%)
 rename tools/binman/test/{051_u_boot_spl_dtb.dts => xpl/u-boot-spl-dtb.dts} (100%)
 rename tools/binman/test/{052_u_boot_spl_nodtb.dts => xpl/u-boot-spl-nodtb.dts} (100%)
 rename tools/binman/test/{285_spl_expand.dts => xpl/u-boot-spl.dts} (100%)
 rename tools/binman/test/{192_u_boot_tpl_nodtb.dts => xpl/u-boot-tpl-nodtb.dts} (100%)
 rename tools/binman/test/{256_u_boot_vpl_nodtb.dts => xpl/u-boot-vpl-nodtb.dts} (100%)
 rename tools/binman/test/{255_u_boot_vpl.dts => xpl/vpl.dts} (100%)
 rename tools/binman/test/{258_vpl_bss_pad.dts => xpl/vpl_bss_pad.dts} (100%)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index bc6ebf8bcbf..7f02bffc0a9 100644
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
+        data = self._DoReadFile('xpl/u-boot-img.dts')
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
+        data = self._DoReadFile('xpl/u-boot-spl-dtb.dts')
         self.assertEqual(U_BOOT_SPL_DTB_DATA, data[:len(U_BOOT_SPL_DTB_DATA)])
 
     def testSplNoDtb(self):
         """Test that an image with spl/u-boot-spl-nodtb.bin can be created"""
         self._SetupSplElf()
-        data = self._DoReadFile('052_u_boot_spl_nodtb.dts')
+        data = self._DoReadFile('xpl/u-boot-spl-nodtb.dts')
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
+        data = self._DoReadFile('xpl/u-boot-tpl-nodtb.dts')
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
+        data = self._DoReadFile('xpl/u-boot-vpl-nodtb.dts')
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
+        data = self._DoReadFileDtb('xpl/u-boot-spl.dts',
                                    use_expanded=True, entry_args=entry_args)[0]
 
     def testTemplate(self):
diff --git a/tools/binman/test/026_pack_u_boot_dtb.dts b/tools/binman/test/xpl/pack_dtb.dts
similarity index 100%
rename from tools/binman/test/026_pack_u_boot_dtb.dts
rename to tools/binman/test/xpl/pack_dtb.dts
diff --git a/tools/binman/test/047_spl_bss_pad.dts b/tools/binman/test/xpl/spl_bss_pad.dts
similarity index 100%
rename from tools/binman/test/047_spl_bss_pad.dts
rename to tools/binman/test/xpl/spl_bss_pad.dts
diff --git a/tools/binman/test/078_u_boot_tpl.dts b/tools/binman/test/xpl/tpl.dts
similarity index 100%
rename from tools/binman/test/078_u_boot_tpl.dts
rename to tools/binman/test/xpl/tpl.dts
diff --git a/tools/binman/test/193_tpl_bss_pad.dts b/tools/binman/test/xpl/tpl_bss_pad.dts
similarity index 100%
rename from tools/binman/test/193_tpl_bss_pad.dts
rename to tools/binman/test/xpl/tpl_bss_pad.dts
diff --git a/tools/binman/test/036_u_boot_img.dts b/tools/binman/test/xpl/u-boot-img.dts
similarity index 100%
rename from tools/binman/test/036_u_boot_img.dts
rename to tools/binman/test/xpl/u-boot-img.dts
diff --git a/tools/binman/test/051_u_boot_spl_dtb.dts b/tools/binman/test/xpl/u-boot-spl-dtb.dts
similarity index 100%
rename from tools/binman/test/051_u_boot_spl_dtb.dts
rename to tools/binman/test/xpl/u-boot-spl-dtb.dts
diff --git a/tools/binman/test/052_u_boot_spl_nodtb.dts b/tools/binman/test/xpl/u-boot-spl-nodtb.dts
similarity index 100%
rename from tools/binman/test/052_u_boot_spl_nodtb.dts
rename to tools/binman/test/xpl/u-boot-spl-nodtb.dts
diff --git a/tools/binman/test/285_spl_expand.dts b/tools/binman/test/xpl/u-boot-spl.dts
similarity index 100%
rename from tools/binman/test/285_spl_expand.dts
rename to tools/binman/test/xpl/u-boot-spl.dts
diff --git a/tools/binman/test/192_u_boot_tpl_nodtb.dts b/tools/binman/test/xpl/u-boot-tpl-nodtb.dts
similarity index 100%
rename from tools/binman/test/192_u_boot_tpl_nodtb.dts
rename to tools/binman/test/xpl/u-boot-tpl-nodtb.dts
diff --git a/tools/binman/test/256_u_boot_vpl_nodtb.dts b/tools/binman/test/xpl/u-boot-vpl-nodtb.dts
similarity index 100%
rename from tools/binman/test/256_u_boot_vpl_nodtb.dts
rename to tools/binman/test/xpl/u-boot-vpl-nodtb.dts
diff --git a/tools/binman/test/255_u_boot_vpl.dts b/tools/binman/test/xpl/vpl.dts
similarity index 100%
rename from tools/binman/test/255_u_boot_vpl.dts
rename to tools/binman/test/xpl/vpl.dts
diff --git a/tools/binman/test/258_vpl_bss_pad.dts b/tools/binman/test/xpl/vpl_bss_pad.dts
similarity index 100%
rename from tools/binman/test/258_vpl_bss_pad.dts
rename to tools/binman/test/xpl/vpl_bss_pad.dts
-- 
2.43.0

