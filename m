Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE88FCC04D
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 18:13:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2B4383F1F;
	Fri,  6 Mar 2026 19:13:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e96gwBRJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 974DE83F9B; Fri,  6 Mar 2026 19:13:37 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A97C83B86
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 19:13:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-8cb4acdacb2so1213699385a.3
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 10:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772820813; x=1773425613; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+fuzzJM1yKdvb1MSn9qa7OyUypJfJ4xtEHsbqCspF9E=;
 b=e96gwBRJarIeFpejJ+4h8nzzyL/G/De9bhlYTJfB+qT31wzEDUStnw3FGAdDf0Axpr
 gpkH93fjpIHPWkH3MenEsal27J1sQcCJR86ts4ZEqaoFYiE4DPYmneTz2j9ulbdo+eKL
 oLLF0OvqYNYQ+IRK917vDAi5/l+vn2yuhZ5kY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772820813; x=1773425613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+fuzzJM1yKdvb1MSn9qa7OyUypJfJ4xtEHsbqCspF9E=;
 b=DjGKukq2wf5AQfy8dsBvOhW+eyB4BrxBSOuGRRHuckRPUgn5W76K8RvuhAGF3OtOMJ
 ZKrBBeQWyNTkeqdip1BRhKoEKwrUo3+/EJxQiGBZ5BfLDvQvNTat4tLi/VyNKz4Q6Qec
 8xxIoelB22sB/EPoTR69CG4uycFbfuHslLRG/zPZ/L/2/qIMPtUl4vm1uAdXt02uY6x0
 WdDGhrOI7B8yvFF7bouhPGq7Erq2k0DiEYiaP0X9PY4JK8xcJifBLBVo5Tcmd9DR61dq
 0awR51yLRC0VpbAnoKOTECRWTQuLZARFbVxL5EJi/Z8YkNNWqziZjFzdaXZVavux+9Ip
 zBGQ==
X-Gm-Message-State: AOJu0YyUKnbF9DaNcJYEvy1l11Cho3NQEeuANtqUfueudQKSC8nOyLet
 KLTrImjWPDrOLmCSPQV5MDZFGQ30eMQ7PhRKJzgTUAhBqq0R2tGdEGKelOy3UHcIFafpzyI6OoA
 XsQw=
X-Gm-Gg: ATEYQzxqNkeru2ODArDnwMeALuYxgXh827QKwJUPN0Zv/5Nn6pFsQHqyL36MfYHbbbu
 6RijFNR+KxUUXhI+7qnCmuprii4SxafCWiWNoA4HAOVotuoL3wpKxEUVkfp7ldyGEi4Wryj/kqK
 XIezvAXssKAT9VCIzMY02GZwoka1ZfXL+t5QDYnD7ZC+WqW2AeT64T+FO4LHVjJJguiTRBUqxVq
 r7SgYuXdmSeE67Kqc1FkiiKLc82vjoISjHcOD5WMcuIbeD27ysJSbIkYZ89li5VWd0FhZgmfWBC
 JBmf0rlW1ED6TdzonUdBA9DylIwop2riGfZ5bT2cSiObkKOnmWLBxsnwcwSaGTxtaBJAGoEGefF
 qq/FDhRmtrHrUIsyhBjzD2zUJ9jZw+CoiS3Gl6CkfWJFZteHe2HNSylxUKKFp2+7xnSUeUYXVl9
 bsC3UIQsMSBGNBedALSQ==
X-Received: by 2002:a05:620a:4093:b0:8c9:fb26:dc6e with SMTP id
 af79cd13be357-8cd6d4b4efamr402776585a.38.1772820812339; 
 Fri, 06 Mar 2026 10:13:32 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f5736c0sm155930885a.49.2026.03.06.10.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 10:13:31 -0800 (PST)
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
Subject: [PATCH v2 02/23] binman: test: Move pack/layout test files to
 test/pack/
Date: Fri,  6 Mar 2026 11:12:30 -0700
Message-ID: <20260306181304.2426352-3-sjg@chromium.org>
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

Move about 50 test files related to basic layout, packing, alignment,
sections, and image structure into a pack/ subdirectory. Drop the
numeric prefixes from the filenames and update all references in
ftest.py, entry_test.py, and binman_tests.rst

Signed-off-by: Simon Glass <simon.glass@canonical.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v1)

 doc/develop/binman_tests.rst                  |   2 +-
 tools/binman/entry_test.py                    |   2 +-
 tools/binman/ftest.py                         | 120 +++++++++---------
 .../4gb_and_skip_at_start_together.dts}       |   0
 .../align_default.dts}                        |   0
 .../assume_size.dts}                          |   0
 .../assume_size_ok.dts}                       |   0
 .../{007_bad_align.dts => pack/bad_align.dts} |   0
 .../change_size.dts}                          |   0
 .../dual_image.dts}                           |   0
 .../test/{003_empty.dts => pack/empty.dts}    |   0
 .../entry_extend.dts}                         |   0
 .../entry_extend_section.dts}                 |   0
 .../entry_extend_twice.dts}                   |   0
 .../entry_shrink.dts}                         |   0
 .../expand_size_bad.dts}                      |   0
 .../extend_size.dts}                          |   0
 .../extend_size_bad.dts}                      |   0
 .../image_name.dts}                           |   0
 .../{021_image_pad.dts => pack/image_pad.dts} |   0
 .../{001_invalid.dts => pack/invalid.dts}     |   0
 .../invalid_entry.dts}                        |   0
 .../missing_node.dts}                         |   0
 .../test/{008_pack.dts => pack/pack.dts}      |   0
 .../pack_4gb_no_size.dts}                     |   0
 .../pack_4gb_outside.dts}                     |   0
 .../pack_align_power2.dts}                    |   0
 .../pack_align_section.dts}                   |   0
 .../pack_align_size_power2.dts}               |   0
 .../pack_extra.dts}                           |   0
 .../pack_image_align.dts}                     |   0
 .../pack_image_overflow.dts}                  |   0
 .../pack_image_size.dts}                      |   0
 .../pack_inv_align.dts}                       |   0
 .../pack_inv_image_align.dts}                 |   0
 .../pack_inv_image_align_power2.dts}          |   0
 .../pack_inv_size_align.dts}                  |   0
 .../pack_overflow.dts}                        |   0
 .../pack_overlap.dts}                         |   0
 .../pack_overlap_zero.dts}                    |   0
 .../pack_zero_size.dts}                       |   0
 .../pad_in_sections.dts}                      |   0
 .../section_align.dts}                        |   0
 .../section_inner.dts}                        |   0
 .../section_pad.dts}                          |   0
 .../sections_offset.dts}                      |   0
 .../test/{005_simple.dts => pack/simple.dts}  |   0
 .../skip_at_start.dts}                        |   0
 .../skip_at_start_pad.dts}                    |   0
 .../skip_at_start_section_pad.dts}            |   0
 .../test/{024_sorted.dts => pack/sorted.dts}  |   0
 .../unit_address.dts}                         |   0
 .../{079_uses_pos.dts => pack/uses_pos.dts}   |   0
 53 files changed, 62 insertions(+), 62 deletions(-)
 rename tools/binman/test/{098_4gb_and_skip_at_start_together.dts => pack/4gb_and_skip_at_start_together.dts} (100%)
 rename tools/binman/test/{200_align_default.dts => pack/align_default.dts} (100%)
 rename tools/binman/test/{326_assume_size.dts => pack/assume_size.dts} (100%)
 rename tools/binman/test/{327_assume_size_ok.dts => pack/assume_size_ok.dts} (100%)
 rename tools/binman/test/{007_bad_align.dts => pack/bad_align.dts} (100%)
 rename tools/binman/test/{059_change_size.dts => pack/change_size.dts} (100%)
 rename tools/binman/test/{006_dual_image.dts => pack/dual_image.dts} (100%)
 rename tools/binman/test/{003_empty.dts => pack/empty.dts} (100%)
 rename tools/binman/test/{121_entry_extend.dts => pack/entry_extend.dts} (100%)
 rename tools/binman/test/{123_entry_extend_section.dts => pack/entry_extend_section.dts} (100%)
 rename tools/binman/test/{122_entry_extend_twice.dts => pack/entry_extend_twice.dts} (100%)
 rename tools/binman/test/{140_entry_shrink.dts => pack/entry_shrink.dts} (100%)
 rename tools/binman/test/{225_expand_size_bad.dts => pack/expand_size_bad.dts} (100%)
 rename tools/binman/test/{088_extend_size.dts => pack/extend_size.dts} (100%)
 rename tools/binman/test/{089_extend_size_bad.dts => pack/extend_size_bad.dts} (100%)
 rename tools/binman/test/{022_image_name.dts => pack/image_name.dts} (100%)
 rename tools/binman/test/{021_image_pad.dts => pack/image_pad.dts} (100%)
 rename tools/binman/test/{001_invalid.dts => pack/invalid.dts} (100%)
 rename tools/binman/test/{004_invalid_entry.dts => pack/invalid_entry.dts} (100%)
 rename tools/binman/test/{002_missing_node.dts => pack/missing_node.dts} (100%)
 rename tools/binman/test/{008_pack.dts => pack/pack.dts} (100%)
 rename tools/binman/test/{027_pack_4gb_no_size.dts => pack/pack_4gb_no_size.dts} (100%)
 rename tools/binman/test/{028_pack_4gb_outside.dts => pack/pack_4gb_outside.dts} (100%)
 rename tools/binman/test/{010_pack_align_power2.dts => pack/pack_align_power2.dts} (100%)
 rename tools/binman/test/{131_pack_align_section.dts => pack/pack_align_section.dts} (100%)
 rename tools/binman/test/{011_pack_align_size_power2.dts => pack/pack_align_size_power2.dts} (100%)
 rename tools/binman/test/{009_pack_extra.dts => pack/pack_extra.dts} (100%)
 rename tools/binman/test/{018_pack_image_align.dts => pack/pack_image_align.dts} (100%)
 rename tools/binman/test/{016_pack_image_overflow.dts => pack/pack_image_overflow.dts} (100%)
 rename tools/binman/test/{017_pack_image_size.dts => pack/pack_image_size.dts} (100%)
 rename tools/binman/test/{012_pack_inv_align.dts => pack/pack_inv_align.dts} (100%)
 rename tools/binman/test/{019_pack_inv_image_align.dts => pack/pack_inv_image_align.dts} (100%)
 rename tools/binman/test/{020_pack_inv_image_align_power2.dts => pack/pack_inv_image_align_power2.dts} (100%)
 rename tools/binman/test/{013_pack_inv_size_align.dts => pack/pack_inv_size_align.dts} (100%)
 rename tools/binman/test/{015_pack_overflow.dts => pack/pack_overflow.dts} (100%)
 rename tools/binman/test/{014_pack_overlap.dts => pack/pack_overlap.dts} (100%)
 rename tools/binman/test/{160_pack_overlap_zero.dts => pack/pack_overlap_zero.dts} (100%)
 rename tools/binman/test/{025_pack_zero_size.dts => pack/pack_zero_size.dts} (100%)
 rename tools/binman/test/{166_pad_in_sections.dts => pack/pad_in_sections.dts} (100%)
 rename tools/binman/test/{181_section_align.dts => pack/section_align.dts} (100%)
 rename tools/binman/test/{267_section_inner.dts => pack/section_inner.dts} (100%)
 rename tools/binman/test/{180_section_pad.dts => pack/section_pad.dts} (100%)
 rename tools/binman/test/{101_sections_offset.dts => pack/sections_offset.dts} (100%)
 rename tools/binman/test/{005_simple.dts => pack/simple.dts} (100%)
 rename tools/binman/test/{177_skip_at_start.dts => pack/skip_at_start.dts} (100%)
 rename tools/binman/test/{178_skip_at_start_pad.dts => pack/skip_at_start_pad.dts} (100%)
 rename tools/binman/test/{179_skip_at_start_section_pad.dts => pack/skip_at_start_section_pad.dts} (100%)
 rename tools/binman/test/{024_sorted.dts => pack/sorted.dts} (100%)
 rename tools/binman/test/{054_unit_address.dts => pack/unit_address.dts} (100%)
 rename tools/binman/test/{079_uses_pos.dts => pack/uses_pos.dts} (100%)

diff --git a/doc/develop/binman_tests.rst b/doc/develop/binman_tests.rst
index 5e44686b8ad..745ca259d44 100644
--- a/doc/develop/binman_tests.rst
+++ b/doc/develop/binman_tests.rst
@@ -331,7 +331,7 @@ Here is a simple test:
 
     def testSimple(self):
         """Test a simple binman with a single file"""
-        data = self._DoReadFile('005_simple.dts')
+        data = self._DoReadFile('pack/simple.dts')
         self.assertEqual(U_BOOT_DATA, data)
 
 This test tells Binman to build an image using the description. Then it checks
diff --git a/tools/binman/entry_test.py b/tools/binman/entry_test.py
index 40d74d401a2..7f00358e008 100644
--- a/tools/binman/entry_test.py
+++ b/tools/binman/entry_test.py
@@ -26,7 +26,7 @@ class TestEntry(unittest.TestCase):
     def GetNode(self):
         binman_dir = os.path.dirname(os.path.realpath(sys.argv[0]))
         fname = fdt_util.EnsureCompiled(
-            os.path.join(binman_dir,('test/005_simple.dts')))
+            os.path.join(binman_dir,('test/pack/simple.dts')))
         dtb = fdt.FdtScan(fname)
         return dtb.GetNode('/binman/u-boot')
 
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index a96789d4f1c..bc6ebf8bcbf 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -816,7 +816,7 @@ class TestFunctional(unittest.TestCase):
 
     def testBoard(self):
         """Test that we can run it with a specific board"""
-        self._SetupDtb('005_simple.dts', 'sandbox/u-boot.dtb')
+        self._SetupDtb('pack/simple.dts', 'sandbox/u-boot.dtb')
         TestFunctional._MakeInputFile('sandbox/u-boot.bin', U_BOOT_DATA)
         result = self._DoBinman('build', '-n', '-b', 'sandbox')
         self.assertEqual(0, result)
@@ -843,19 +843,19 @@ class TestFunctional(unittest.TestCase):
         will come from the device-tree compiler (dtc).
         """
         with self.assertRaises(Exception) as e:
-            self._RunBinman('build', '-d', self.TestFile('001_invalid.dts'))
+            self._RunBinman('build', '-d', self.TestFile('pack/invalid.dts'))
         self.assertIn("FATAL ERROR: Unable to parse input tree",
                 str(e.exception))
 
     def testMissingNode(self):
         """Test that a device tree without a 'binman' node generates an error"""
         with self.assertRaises(Exception) as e:
-            self._DoBinman('build', '-d', self.TestFile('002_missing_node.dts'))
+            self._DoBinman('build', '-d', self.TestFile('pack/missing_node.dts'))
         self.assertIn("does not have a 'binman' node", str(e.exception))
 
     def testEmpty(self):
         """Test that an empty binman node works OK (i.e. does nothing)"""
-        result = self._RunBinman('build', '-d', self.TestFile('003_empty.dts'))
+        result = self._RunBinman('build', '-d', self.TestFile('pack/empty.dts'))
         self.assertEqual(0, len(result.stderr))
         self.assertEqual(0, result.return_code)
 
@@ -863,25 +863,25 @@ class TestFunctional(unittest.TestCase):
         """Test that an invalid entry is flagged"""
         with self.assertRaises(Exception) as e:
             result = self._RunBinman('build', '-d',
-                                     self.TestFile('004_invalid_entry.dts'))
+                                     self.TestFile('pack/invalid_entry.dts'))
         self.assertIn("Unknown entry type 'not-a-valid-type' in node "
                 "'/binman/not-a-valid-type'", str(e.exception))
 
     def testSimple(self):
         """Test a simple binman with a single file"""
-        data = self._DoReadFile('005_simple.dts')
+        data = self._DoReadFile('pack/simple.dts')
         self.assertEqual(U_BOOT_DATA, data)
 
     def testSimpleDebug(self):
         """Test a simple binman run with debugging enabled"""
-        self._DoTestFile('005_simple.dts', debug=True)
+        self._DoTestFile('pack/simple.dts', debug=True)
 
     def testDual(self):
         """Test that we can handle creating two images
 
         This also tests image padding.
         """
-        retcode = self._DoTestFile('006_dual_image.dts')
+        retcode = self._DoTestFile('pack/dual_image.dts')
         self.assertEqual(0, retcode)
 
         image = control.images['image1']
@@ -905,13 +905,13 @@ class TestFunctional(unittest.TestCase):
     def testBadAlign(self):
         """Test that an invalid alignment value is detected"""
         with self.assertRaises(ValueError) as e:
-            self._DoTestFile('007_bad_align.dts')
+            self._DoTestFile('pack/bad_align.dts')
         self.assertIn("Node '/binman/u-boot': Alignment 23 must be a power "
                       "of two", str(e.exception))
 
     def testPackSimple(self):
         """Test that packing works as expected"""
-        retcode = self._DoTestFile('008_pack.dts')
+        retcode = self._DoTestFile('pack/pack.dts')
         self.assertEqual(0, retcode)
         self.assertIn('image', control.images)
         image = control.images['image']
@@ -953,7 +953,7 @@ class TestFunctional(unittest.TestCase):
 
     def testPackExtra(self):
         """Test that extra packing feature works as expected"""
-        data, _, _, out_dtb_fname = self._DoReadFileDtb('009_pack_extra.dts',
+        data, _, _, out_dtb_fname = self._DoReadFileDtb('pack/pack_extra.dts',
                                                         update_dtb=True)
 
         self.assertIn('image', control.images)
@@ -1059,35 +1059,35 @@ class TestFunctional(unittest.TestCase):
     def testPackAlignPowerOf2(self):
         """Test that invalid entry alignment is detected"""
         with self.assertRaises(ValueError) as e:
-            self._DoTestFile('010_pack_align_power2.dts')
+            self._DoTestFile('pack/pack_align_power2.dts')
         self.assertIn("Node '/binman/u-boot': Alignment 5 must be a power "
                       "of two", str(e.exception))
 
     def testPackAlignSizePowerOf2(self):
         """Test that invalid entry size alignment is detected"""
         with self.assertRaises(ValueError) as e:
-            self._DoTestFile('011_pack_align_size_power2.dts')
+            self._DoTestFile('pack/pack_align_size_power2.dts')
         self.assertIn("Node '/binman/u-boot': Alignment size 55 must be a "
                       "power of two", str(e.exception))
 
     def testPackInvalidAlign(self):
         """Test detection of an offset that does not match its alignment"""
         with self.assertRaises(ValueError) as e:
-            self._DoTestFile('012_pack_inv_align.dts')
+            self._DoTestFile('pack/pack_inv_align.dts')
         self.assertIn("Node '/binman/u-boot': Offset 0x5 (5) does not match "
                       "align 0x4 (4)", str(e.exception))
 
     def testPackInvalidSizeAlign(self):
         """Test that invalid entry size alignment is detected"""
         with self.assertRaises(ValueError) as e:
-            self._DoTestFile('013_pack_inv_size_align.dts')
+            self._DoTestFile('pack/pack_inv_size_align.dts')
         self.assertIn("Node '/binman/u-boot': Size 0x5 (5) does not match "
                       "align-size 0x4 (4)", str(e.exception))
 
     def testPackOverlap(self):
         """Test that overlapping regions are detected"""
         with self.assertRaises(ValueError) as e:
-            self._DoTestFile('014_pack_overlap.dts')
+            self._DoTestFile('pack/pack_overlap.dts')
         self.assertIn("Node '/binman/u-boot-align': Offset 0x3 (3) overlaps "
                       "with previous entry '/binman/u-boot' ending at 0x4 (4)",
                       str(e.exception))
@@ -1095,20 +1095,20 @@ class TestFunctional(unittest.TestCase):
     def testPackEntryOverflow(self):
         """Test that entries that overflow their size are detected"""
         with self.assertRaises(ValueError) as e:
-            self._DoTestFile('015_pack_overflow.dts')
+            self._DoTestFile('pack/pack_overflow.dts')
         self.assertIn("Node '/binman/u-boot': Entry contents size is 0x4 (4) "
                       "but entry size is 0x3 (3)", str(e.exception))
 
     def testPackImageOverflow(self):
         """Test that entries which overflow the image size are detected"""
         with self.assertRaises(ValueError) as e:
-            self._DoTestFile('016_pack_image_overflow.dts')
+            self._DoTestFile('pack/pack_image_overflow.dts')
         self.assertIn("Section '/binman': contents size 0x4 (4) exceeds section "
                       "size 0x3 (3)", str(e.exception))
 
     def testPackImageSize(self):
         """Test that the image size can be set"""
-        retcode = self._DoTestFile('017_pack_image_size.dts')
+        retcode = self._DoTestFile('pack/pack_image_size.dts')
         self.assertEqual(0, retcode)
         self.assertIn('image', control.images)
         image = control.images['image']
@@ -1116,7 +1116,7 @@ class TestFunctional(unittest.TestCase):
 
     def testPackImageSizeAlign(self):
         """Test that image size alignemnt works as expected"""
-        retcode = self._DoTestFile('018_pack_image_align.dts')
+        retcode = self._DoTestFile('pack/pack_image_align.dts')
         self.assertEqual(0, retcode)
         self.assertIn('image', control.images)
         image = control.images['image']
@@ -1125,27 +1125,27 @@ class TestFunctional(unittest.TestCase):
     def testPackInvalidImageAlign(self):
         """Test that invalid image alignment is detected"""
         with self.assertRaises(ValueError) as e:
-            self._DoTestFile('019_pack_inv_image_align.dts')
+            self._DoTestFile('pack/pack_inv_image_align.dts')
         self.assertIn("Section '/binman': Size 0x7 (7) does not match "
                       "align-size 0x8 (8)", str(e.exception))
 
     def testPackAlignPowerOf2Inv(self):
         """Test that invalid image alignment is detected"""
         with self.assertRaises(ValueError) as e:
-            self._DoTestFile('020_pack_inv_image_align_power2.dts')
+            self._DoTestFile('pack/pack_inv_image_align_power2.dts')
         self.assertIn("Image '/binman': Alignment size 131 must be a power of "
                       "two", str(e.exception))
 
     def testImagePadByte(self):
         """Test that the image pad byte can be specified"""
         self._SetupSplElf()
-        data = self._DoReadFile('021_image_pad.dts')
+        data = self._DoReadFile('pack/image_pad.dts')
         self.assertEqual(U_BOOT_SPL_DATA + tools.get_bytes(0xff, 1) +
                          U_BOOT_DATA, data)
 
     def testImageName(self):
         """Test that image files can be named"""
-        retcode = self._DoTestFile('022_image_name.dts')
+        retcode = self._DoTestFile('pack/image_name.dts')
         self.assertEqual(0, retcode)
         image = control.images['image1']
         fname = tools.get_output_filename('test-name')
@@ -1163,7 +1163,7 @@ class TestFunctional(unittest.TestCase):
     def testPackSorted(self):
         """Test that entries can be sorted"""
         self._SetupSplElf()
-        data = self._DoReadFile('024_sorted.dts')
+        data = self._DoReadFile('pack/sorted.dts')
         self.assertEqual(tools.get_bytes(0, 1) + U_BOOT_SPL_DATA +
                          tools.get_bytes(0, 2) + U_BOOT_DATA, data)
 
@@ -1171,7 +1171,7 @@ class TestFunctional(unittest.TestCase):
         """Test that an entry at offset 0 is not given a new offset"""
         self._SetupSplElf()
         with self.assertRaises(ValueError) as e:
-            self._DoTestFile('025_pack_zero_size.dts')
+            self._DoTestFile('pack/pack_zero_size.dts')
         self.assertIn("Node '/binman/u-boot-spl': Offset 0x0 (0) overlaps "
                       "with previous entry '/binman/u-boot' ending at 0x4 (4)",
                       str(e.exception))
@@ -1185,7 +1185,7 @@ class TestFunctional(unittest.TestCase):
         """Test that the end-at-4gb property requires a size property"""
         self._SetupSplElf()
         with self.assertRaises(ValueError) as e:
-            self._DoTestFile('027_pack_4gb_no_size.dts')
+            self._DoTestFile('pack/pack_4gb_no_size.dts')
         self.assertIn("Image '/binman': Section size must be provided when "
                       "using end-at-4gb", str(e.exception))
 
@@ -1194,7 +1194,7 @@ class TestFunctional(unittest.TestCase):
         together"""
         self._SetupSplElf()
         with self.assertRaises(ValueError) as e:
-            self._DoTestFile('098_4gb_and_skip_at_start_together.dts')
+            self._DoTestFile('pack/4gb_and_skip_at_start_together.dts')
         self.assertIn("Image '/binman': Provide either 'end-at-4gb' or "
                       "'skip-at-start'", str(e.exception))
 
@@ -1202,7 +1202,7 @@ class TestFunctional(unittest.TestCase):
         """Test that the end-at-4gb property checks for offset boundaries"""
         self._SetupSplElf()
         with self.assertRaises(ValueError) as e:
-            self._DoTestFile('028_pack_4gb_outside.dts')
+            self._DoTestFile('pack/pack_4gb_outside.dts')
         self.assertIn("Node '/binman/u-boot': Offset 0x0 (0) size 0x4 (4) "
                       "is outside the section '/binman' starting at "
                       '0xffffffe0 (4294967264) of size 0x20 (32)',
@@ -1621,7 +1621,7 @@ class TestFunctional(unittest.TestCase):
 
     def testPackUnitAddress(self):
         """Test that we support multiple binaries with the same name"""
-        data = self._DoReadFile('054_unit_address.dts')
+        data = self._DoReadFile('pack/unit_address.dts')
         self.assertEqual(U_BOOT_DATA + U_BOOT_DATA, data)
 
     def testSections(self):
@@ -1669,7 +1669,7 @@ class TestFunctional(unittest.TestCase):
         try:
             state.SetAllowEntryExpansion(False)
             with self.assertRaises(ValueError) as e:
-                self._DoReadFile('059_change_size.dts', True)
+                self._DoReadFile('pack/change_size.dts', True)
             self.assertIn("Node '/binman/_testing': Cannot update entry size from 2 to 3",
                           str(e.exception))
         finally:
@@ -2037,7 +2037,7 @@ class TestFunctional(unittest.TestCase):
     def testUsesPos(self):
         """Test that the 'pos' property cannot be used anymore"""
         with self.assertRaises(ValueError) as e:
-           data = self._DoReadFile('079_uses_pos.dts')
+           data = self._DoReadFile('pack/uses_pos.dts')
         self.assertIn("Node '/binman/u-boot': Please use 'offset' instead of "
                       "'pos'", str(e.exception))
 
@@ -2065,7 +2065,7 @@ class TestFunctional(unittest.TestCase):
         # We should only get the expected message in verbose mode
         for verbosity in (0, 2):
             with terminal.capture() as (stdout, stderr):
-                retcode = self._DoTestFile('006_dual_image.dts',
+                retcode = self._DoTestFile('pack/dual_image.dts',
                                            verbosity=verbosity,
                                            images=['image2'])
             self.assertEqual(0, retcode)
@@ -2231,7 +2231,7 @@ class TestFunctional(unittest.TestCase):
 
     def testExtendSize(self):
         """Test an extending entry"""
-        data, _, map_data, _ = self._DoReadFileDtb('088_extend_size.dts',
+        data, _, map_data, _ = self._DoReadFileDtb('pack/extend_size.dts',
                                                    map=True)
         expect = (tools.get_bytes(ord('a'), 8) + U_BOOT_DATA +
                   MRC_DATA + tools.get_bytes(ord('b'), 1) + U_BOOT_DATA +
@@ -2255,7 +2255,7 @@ class TestFunctional(unittest.TestCase):
         """Test an extending entry which fails to provide contents"""
         with terminal.capture() as (stdout, stderr):
             with self.assertRaises(ValueError) as e:
-                self._DoReadFileDtb('089_extend_size_bad.dts', map=True)
+                self._DoReadFileDtb('pack/extend_size_bad.dts', map=True)
         self.assertIn("Node '/binman/_testing': Cannot obtain contents when "
                       'expanding entry', str(e.exception))
 
@@ -2384,7 +2384,7 @@ class TestFunctional(unittest.TestCase):
         """Test that overlapping regions are detected"""
         with terminal.capture() as (stdout, stderr):
             with self.assertRaises(ValueError) as e:
-                self._DoTestFile('014_pack_overlap.dts', map=True)
+                self._DoTestFile('pack/pack_overlap.dts', map=True)
         map_fname = tools.get_output_filename('image.map')
         self.assertEqual("Wrote map file '%s' to show errors\n" % map_fname,
                          stdout.getvalue())
@@ -2406,7 +2406,7 @@ class TestFunctional(unittest.TestCase):
 
     def testSectionOffset(self):
         """Tests use of a section with an offset"""
-        data, _, map_data, _ = self._DoReadFileDtb('101_sections_offset.dts',
+        data, _, map_data, _ = self._DoReadFileDtb('pack/sections_offset.dts',
                                                    map=True)
         self.assertEqual('''ImagePos    Offset      Size  Name
 00000000  00000000  00000038  image
@@ -2691,7 +2691,7 @@ class TestFunctional(unittest.TestCase):
 
     def testEntryExpand(self):
         """Test extending an entry after it is packed"""
-        data = self._DoReadFile('121_entry_extend.dts')
+        data = self._DoReadFile('pack/entry_extend.dts')
         self.assertEqual(b'aaa', data[:3])
         self.assertEqual(U_BOOT_DATA, data[3:3 + len(U_BOOT_DATA)])
         self.assertEqual(b'aaa', data[-3:])
@@ -2699,13 +2699,13 @@ class TestFunctional(unittest.TestCase):
     def testEntryExtendBad(self):
         """Test extending an entry after it is packed, twice"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('122_entry_extend_twice.dts')
+            self._DoReadFile('pack/entry_extend_twice.dts')
         self.assertIn("Image '/binman': Entries changed size after packing",
                       str(e.exception))
 
     def testEntryExtendSection(self):
         """Test extending an entry within a section after it is packed"""
-        data = self._DoReadFile('123_entry_extend_section.dts')
+        data = self._DoReadFile('pack/entry_extend_section.dts')
         self.assertEqual(b'aaa', data[:3])
         self.assertEqual(U_BOOT_DATA, data[3:3 + len(U_BOOT_DATA)])
         self.assertEqual(b'aaa', data[-3:])
@@ -2845,7 +2845,7 @@ class TestFunctional(unittest.TestCase):
 
     def testFindFdtmapMissing(self):
         """Test failing to locate an FDP map"""
-        data = self._DoReadFile('005_simple.dts')
+        data = self._DoReadFile('pack/simple.dts')
         self.assertEqual(None, fdtmap.LocateFdtmap(data))
 
     def testFindImageHeader(self):
@@ -2869,7 +2869,7 @@ class TestFunctional(unittest.TestCase):
 
     def testFindImageHeaderMissing(self):
         """Test failing to locate an image header"""
-        data = self._DoReadFile('005_simple.dts')
+        data = self._DoReadFile('pack/simple.dts')
         self.assertEqual(None, image_header.LocateHeaderOffset(data))
 
     def testReadImage(self):
@@ -2899,7 +2899,7 @@ class TestFunctional(unittest.TestCase):
 
     def testReadImageFail(self):
         """Test failing to read an image image's FDT map"""
-        self._DoReadFile('005_simple.dts')
+        self._DoReadFile('pack/simple.dts')
         image_fname = tools.get_output_filename('image.bin')
         with self.assertRaises(ValueError) as e:
             image = Image.FromFile(image_fname)
@@ -2944,7 +2944,7 @@ class TestFunctional(unittest.TestCase):
 
     def testListCmdFail(self):
         """Test failing to list an image"""
-        self._DoReadFile('005_simple.dts')
+        self._DoReadFile('pack/simple.dts')
         tmpdir = None
         try:
             tmpdir, updated_fname = self._SetupImageInTmpdir()
@@ -3236,7 +3236,7 @@ class TestFunctional(unittest.TestCase):
 
     def testPackAlignSection(self):
         """Test that sections can have alignment"""
-        self._DoReadFile('131_pack_align_section.dts')
+        self._DoReadFile('pack/pack_align_section.dts')
 
         self.assertIn('image', control.images)
         image = control.images['image']
@@ -3533,7 +3533,7 @@ class TestFunctional(unittest.TestCase):
         """Test contracting an entry after it is packed"""
         try:
             state.SetAllowEntryContraction(True)
-            data = self._DoReadFileDtb('140_entry_shrink.dts',
+            data = self._DoReadFileDtb('pack/entry_shrink.dts',
                                        update_dtb=True)[0]
         finally:
             state.SetAllowEntryContraction(False)
@@ -3543,7 +3543,7 @@ class TestFunctional(unittest.TestCase):
 
     def testEntryShrinkFail(self):
         """Test not being allowed to contract an entry after it is packed"""
-        data = self._DoReadFileDtb('140_entry_shrink.dts', update_dtb=True)[0]
+        data = self._DoReadFileDtb('pack/entry_shrink.dts', update_dtb=True)[0]
 
         # In this case there is a spare byte at the end of the data. The size of
         # the contents is only 1 byte but we still have the size before it
@@ -3943,7 +3943,7 @@ class TestFunctional(unittest.TestCase):
 
     def testPackOverlapZero(self):
         """Test that zero-size overlapping regions are ignored"""
-        self._DoTestFile('160_pack_overlap_zero.dts')
+        self._DoTestFile('pack/pack_overlap_zero.dts')
 
     def _CheckSimpleFitData(self, fit_data, kernel_data, fdt1_data):
         # The data should be inside the FIT
@@ -4173,7 +4173,7 @@ class TestFunctional(unittest.TestCase):
     def testPadInSections(self):
         """Test pad-before, pad-after for entries in sections"""
         data, _, _, out_dtb_fname = self._DoReadFileDtb(
-            '166_pad_in_sections.dts', update_dtb=True)
+            'pack/pad_in_sections.dts', update_dtb=True)
         expected = (U_BOOT_DATA + tools.get_bytes(ord('!'), 12) +
                     U_BOOT_DATA + tools.get_bytes(ord('!'), 6) +
                     U_BOOT_DATA)
@@ -4448,7 +4448,7 @@ class TestFunctional(unittest.TestCase):
 
     def testSkipAtStart(self):
         """Test handling of skip-at-start section"""
-        data = self._DoReadFile('177_skip_at_start.dts')
+        data = self._DoReadFile('pack/skip_at_start.dts')
         self.assertEqual(U_BOOT_DATA, data)
 
         image = control.images['image']
@@ -4465,7 +4465,7 @@ class TestFunctional(unittest.TestCase):
 
     def testSkipAtStartPad(self):
         """Test handling of skip-at-start section with padded entry"""
-        data = self._DoReadFile('178_skip_at_start_pad.dts')
+        data = self._DoReadFile('pack/skip_at_start_pad.dts')
         before = tools.get_bytes(0, 8)
         after = tools.get_bytes(0, 4)
         all = before + U_BOOT_DATA + after
@@ -4485,7 +4485,7 @@ class TestFunctional(unittest.TestCase):
 
     def testSkipAtStartSectionPad(self):
         """Test handling of skip-at-start section with padding"""
-        data = self._DoReadFile('179_skip_at_start_section_pad.dts')
+        data = self._DoReadFile('pack/skip_at_start_section_pad.dts')
         before = tools.get_bytes(0, 8)
         after = tools.get_bytes(0, 4)
         all = before + U_BOOT_DATA + after
@@ -4506,7 +4506,7 @@ class TestFunctional(unittest.TestCase):
 
     def testSectionPad(self):
         """Testing padding with sections"""
-        data = self._DoReadFile('180_section_pad.dts')
+        data = self._DoReadFile('pack/section_pad.dts')
         expected = (tools.get_bytes(ord('&'), 3) +
                     tools.get_bytes(ord('!'), 5) +
                     U_BOOT_DATA +
@@ -4516,7 +4516,7 @@ class TestFunctional(unittest.TestCase):
 
     def testSectionAlign(self):
         """Testing alignment with sections"""
-        data = self._DoReadFileDtb('181_section_align.dts', map=True)[0]
+        data = self._DoReadFileDtb('pack/section_align.dts', map=True)[0]
         expected = (b'\0' +                         # fill section
                     tools.get_bytes(ord('&'), 1) +   # padding to section align
                     b'\0' +                         # fill section
@@ -5033,7 +5033,7 @@ class TestFunctional(unittest.TestCase):
 
     def testAlignDefault(self):
         """Test that default alignment works on sections"""
-        data = self._DoReadFile('200_align_default.dts')
+        data = self._DoReadFile('pack/align_default.dts')
         expected = (U_BOOT_DATA + tools.get_bytes(0, 8 - len(U_BOOT_DATA)) +
                     U_BOOT_DATA)
         # Special alignment for section
@@ -5618,7 +5618,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def test_uses_expand_size(self):
         """Test that the 'expand-size' property cannot be used anymore"""
         with self.assertRaises(ValueError) as e:
-           data = self._DoReadFile('225_expand_size_bad.dts')
+           data = self._DoReadFile('pack/expand_size_bad.dts')
         self.assertIn(
             "Node '/binman/u-boot': Please use 'extend-size' instead of 'expand-size'",
             str(e.exception))
@@ -6580,7 +6580,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testSectionInner(self):
         """Test an inner section with a size"""
-        data = self._DoReadFile('267_section_inner.dts')
+        data = self._DoReadFile('pack/section_inner.dts')
         expected = U_BOOT_DATA + tools.get_bytes(0, 12)
         self.assertEqual(expected, data)
 
@@ -7615,7 +7615,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def test_assume_size(self):
         """Test handling of the assume-size property for external blob"""
         with self.assertRaises(ValueError) as e:
-            self._DoTestFile('326_assume_size.dts', allow_missing=True,
+            self._DoTestFile('pack/assume_size.dts', allow_missing=True,
                              allow_fake_blobs=True)
         self.assertIn("contents size 0xa (10) exceeds section size 0x9 (9)",
                       str(e.exception))
@@ -7623,7 +7623,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def test_assume_size_ok(self):
         """Test handling of the assume-size where it fits OK"""
         with terminal.capture() as (stdout, stderr):
-            self._DoTestFile('327_assume_size_ok.dts', allow_missing=True,
+            self._DoTestFile('pack/assume_size_ok.dts', allow_missing=True,
                              allow_fake_blobs=True)
         err = stderr.getvalue()
         self.assertRegex(
@@ -7633,7 +7633,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def test_assume_size_no_fake(self):
         """Test handling of the assume-size where it fits OK"""
         with terminal.capture() as (stdout, stderr):
-            self._DoTestFile('327_assume_size_ok.dts', allow_missing=True)
+            self._DoTestFile('pack/assume_size_ok.dts', allow_missing=True)
         err = stderr.getvalue()
         self.assertRegex(
             err,
diff --git a/tools/binman/test/098_4gb_and_skip_at_start_together.dts b/tools/binman/test/pack/4gb_and_skip_at_start_together.dts
similarity index 100%
rename from tools/binman/test/098_4gb_and_skip_at_start_together.dts
rename to tools/binman/test/pack/4gb_and_skip_at_start_together.dts
diff --git a/tools/binman/test/200_align_default.dts b/tools/binman/test/pack/align_default.dts
similarity index 100%
rename from tools/binman/test/200_align_default.dts
rename to tools/binman/test/pack/align_default.dts
diff --git a/tools/binman/test/326_assume_size.dts b/tools/binman/test/pack/assume_size.dts
similarity index 100%
rename from tools/binman/test/326_assume_size.dts
rename to tools/binman/test/pack/assume_size.dts
diff --git a/tools/binman/test/327_assume_size_ok.dts b/tools/binman/test/pack/assume_size_ok.dts
similarity index 100%
rename from tools/binman/test/327_assume_size_ok.dts
rename to tools/binman/test/pack/assume_size_ok.dts
diff --git a/tools/binman/test/007_bad_align.dts b/tools/binman/test/pack/bad_align.dts
similarity index 100%
rename from tools/binman/test/007_bad_align.dts
rename to tools/binman/test/pack/bad_align.dts
diff --git a/tools/binman/test/059_change_size.dts b/tools/binman/test/pack/change_size.dts
similarity index 100%
rename from tools/binman/test/059_change_size.dts
rename to tools/binman/test/pack/change_size.dts
diff --git a/tools/binman/test/006_dual_image.dts b/tools/binman/test/pack/dual_image.dts
similarity index 100%
rename from tools/binman/test/006_dual_image.dts
rename to tools/binman/test/pack/dual_image.dts
diff --git a/tools/binman/test/003_empty.dts b/tools/binman/test/pack/empty.dts
similarity index 100%
rename from tools/binman/test/003_empty.dts
rename to tools/binman/test/pack/empty.dts
diff --git a/tools/binman/test/121_entry_extend.dts b/tools/binman/test/pack/entry_extend.dts
similarity index 100%
rename from tools/binman/test/121_entry_extend.dts
rename to tools/binman/test/pack/entry_extend.dts
diff --git a/tools/binman/test/123_entry_extend_section.dts b/tools/binman/test/pack/entry_extend_section.dts
similarity index 100%
rename from tools/binman/test/123_entry_extend_section.dts
rename to tools/binman/test/pack/entry_extend_section.dts
diff --git a/tools/binman/test/122_entry_extend_twice.dts b/tools/binman/test/pack/entry_extend_twice.dts
similarity index 100%
rename from tools/binman/test/122_entry_extend_twice.dts
rename to tools/binman/test/pack/entry_extend_twice.dts
diff --git a/tools/binman/test/140_entry_shrink.dts b/tools/binman/test/pack/entry_shrink.dts
similarity index 100%
rename from tools/binman/test/140_entry_shrink.dts
rename to tools/binman/test/pack/entry_shrink.dts
diff --git a/tools/binman/test/225_expand_size_bad.dts b/tools/binman/test/pack/expand_size_bad.dts
similarity index 100%
rename from tools/binman/test/225_expand_size_bad.dts
rename to tools/binman/test/pack/expand_size_bad.dts
diff --git a/tools/binman/test/088_extend_size.dts b/tools/binman/test/pack/extend_size.dts
similarity index 100%
rename from tools/binman/test/088_extend_size.dts
rename to tools/binman/test/pack/extend_size.dts
diff --git a/tools/binman/test/089_extend_size_bad.dts b/tools/binman/test/pack/extend_size_bad.dts
similarity index 100%
rename from tools/binman/test/089_extend_size_bad.dts
rename to tools/binman/test/pack/extend_size_bad.dts
diff --git a/tools/binman/test/022_image_name.dts b/tools/binman/test/pack/image_name.dts
similarity index 100%
rename from tools/binman/test/022_image_name.dts
rename to tools/binman/test/pack/image_name.dts
diff --git a/tools/binman/test/021_image_pad.dts b/tools/binman/test/pack/image_pad.dts
similarity index 100%
rename from tools/binman/test/021_image_pad.dts
rename to tools/binman/test/pack/image_pad.dts
diff --git a/tools/binman/test/001_invalid.dts b/tools/binman/test/pack/invalid.dts
similarity index 100%
rename from tools/binman/test/001_invalid.dts
rename to tools/binman/test/pack/invalid.dts
diff --git a/tools/binman/test/004_invalid_entry.dts b/tools/binman/test/pack/invalid_entry.dts
similarity index 100%
rename from tools/binman/test/004_invalid_entry.dts
rename to tools/binman/test/pack/invalid_entry.dts
diff --git a/tools/binman/test/002_missing_node.dts b/tools/binman/test/pack/missing_node.dts
similarity index 100%
rename from tools/binman/test/002_missing_node.dts
rename to tools/binman/test/pack/missing_node.dts
diff --git a/tools/binman/test/008_pack.dts b/tools/binman/test/pack/pack.dts
similarity index 100%
rename from tools/binman/test/008_pack.dts
rename to tools/binman/test/pack/pack.dts
diff --git a/tools/binman/test/027_pack_4gb_no_size.dts b/tools/binman/test/pack/pack_4gb_no_size.dts
similarity index 100%
rename from tools/binman/test/027_pack_4gb_no_size.dts
rename to tools/binman/test/pack/pack_4gb_no_size.dts
diff --git a/tools/binman/test/028_pack_4gb_outside.dts b/tools/binman/test/pack/pack_4gb_outside.dts
similarity index 100%
rename from tools/binman/test/028_pack_4gb_outside.dts
rename to tools/binman/test/pack/pack_4gb_outside.dts
diff --git a/tools/binman/test/010_pack_align_power2.dts b/tools/binman/test/pack/pack_align_power2.dts
similarity index 100%
rename from tools/binman/test/010_pack_align_power2.dts
rename to tools/binman/test/pack/pack_align_power2.dts
diff --git a/tools/binman/test/131_pack_align_section.dts b/tools/binman/test/pack/pack_align_section.dts
similarity index 100%
rename from tools/binman/test/131_pack_align_section.dts
rename to tools/binman/test/pack/pack_align_section.dts
diff --git a/tools/binman/test/011_pack_align_size_power2.dts b/tools/binman/test/pack/pack_align_size_power2.dts
similarity index 100%
rename from tools/binman/test/011_pack_align_size_power2.dts
rename to tools/binman/test/pack/pack_align_size_power2.dts
diff --git a/tools/binman/test/009_pack_extra.dts b/tools/binman/test/pack/pack_extra.dts
similarity index 100%
rename from tools/binman/test/009_pack_extra.dts
rename to tools/binman/test/pack/pack_extra.dts
diff --git a/tools/binman/test/018_pack_image_align.dts b/tools/binman/test/pack/pack_image_align.dts
similarity index 100%
rename from tools/binman/test/018_pack_image_align.dts
rename to tools/binman/test/pack/pack_image_align.dts
diff --git a/tools/binman/test/016_pack_image_overflow.dts b/tools/binman/test/pack/pack_image_overflow.dts
similarity index 100%
rename from tools/binman/test/016_pack_image_overflow.dts
rename to tools/binman/test/pack/pack_image_overflow.dts
diff --git a/tools/binman/test/017_pack_image_size.dts b/tools/binman/test/pack/pack_image_size.dts
similarity index 100%
rename from tools/binman/test/017_pack_image_size.dts
rename to tools/binman/test/pack/pack_image_size.dts
diff --git a/tools/binman/test/012_pack_inv_align.dts b/tools/binman/test/pack/pack_inv_align.dts
similarity index 100%
rename from tools/binman/test/012_pack_inv_align.dts
rename to tools/binman/test/pack/pack_inv_align.dts
diff --git a/tools/binman/test/019_pack_inv_image_align.dts b/tools/binman/test/pack/pack_inv_image_align.dts
similarity index 100%
rename from tools/binman/test/019_pack_inv_image_align.dts
rename to tools/binman/test/pack/pack_inv_image_align.dts
diff --git a/tools/binman/test/020_pack_inv_image_align_power2.dts b/tools/binman/test/pack/pack_inv_image_align_power2.dts
similarity index 100%
rename from tools/binman/test/020_pack_inv_image_align_power2.dts
rename to tools/binman/test/pack/pack_inv_image_align_power2.dts
diff --git a/tools/binman/test/013_pack_inv_size_align.dts b/tools/binman/test/pack/pack_inv_size_align.dts
similarity index 100%
rename from tools/binman/test/013_pack_inv_size_align.dts
rename to tools/binman/test/pack/pack_inv_size_align.dts
diff --git a/tools/binman/test/015_pack_overflow.dts b/tools/binman/test/pack/pack_overflow.dts
similarity index 100%
rename from tools/binman/test/015_pack_overflow.dts
rename to tools/binman/test/pack/pack_overflow.dts
diff --git a/tools/binman/test/014_pack_overlap.dts b/tools/binman/test/pack/pack_overlap.dts
similarity index 100%
rename from tools/binman/test/014_pack_overlap.dts
rename to tools/binman/test/pack/pack_overlap.dts
diff --git a/tools/binman/test/160_pack_overlap_zero.dts b/tools/binman/test/pack/pack_overlap_zero.dts
similarity index 100%
rename from tools/binman/test/160_pack_overlap_zero.dts
rename to tools/binman/test/pack/pack_overlap_zero.dts
diff --git a/tools/binman/test/025_pack_zero_size.dts b/tools/binman/test/pack/pack_zero_size.dts
similarity index 100%
rename from tools/binman/test/025_pack_zero_size.dts
rename to tools/binman/test/pack/pack_zero_size.dts
diff --git a/tools/binman/test/166_pad_in_sections.dts b/tools/binman/test/pack/pad_in_sections.dts
similarity index 100%
rename from tools/binman/test/166_pad_in_sections.dts
rename to tools/binman/test/pack/pad_in_sections.dts
diff --git a/tools/binman/test/181_section_align.dts b/tools/binman/test/pack/section_align.dts
similarity index 100%
rename from tools/binman/test/181_section_align.dts
rename to tools/binman/test/pack/section_align.dts
diff --git a/tools/binman/test/267_section_inner.dts b/tools/binman/test/pack/section_inner.dts
similarity index 100%
rename from tools/binman/test/267_section_inner.dts
rename to tools/binman/test/pack/section_inner.dts
diff --git a/tools/binman/test/180_section_pad.dts b/tools/binman/test/pack/section_pad.dts
similarity index 100%
rename from tools/binman/test/180_section_pad.dts
rename to tools/binman/test/pack/section_pad.dts
diff --git a/tools/binman/test/101_sections_offset.dts b/tools/binman/test/pack/sections_offset.dts
similarity index 100%
rename from tools/binman/test/101_sections_offset.dts
rename to tools/binman/test/pack/sections_offset.dts
diff --git a/tools/binman/test/005_simple.dts b/tools/binman/test/pack/simple.dts
similarity index 100%
rename from tools/binman/test/005_simple.dts
rename to tools/binman/test/pack/simple.dts
diff --git a/tools/binman/test/177_skip_at_start.dts b/tools/binman/test/pack/skip_at_start.dts
similarity index 100%
rename from tools/binman/test/177_skip_at_start.dts
rename to tools/binman/test/pack/skip_at_start.dts
diff --git a/tools/binman/test/178_skip_at_start_pad.dts b/tools/binman/test/pack/skip_at_start_pad.dts
similarity index 100%
rename from tools/binman/test/178_skip_at_start_pad.dts
rename to tools/binman/test/pack/skip_at_start_pad.dts
diff --git a/tools/binman/test/179_skip_at_start_section_pad.dts b/tools/binman/test/pack/skip_at_start_section_pad.dts
similarity index 100%
rename from tools/binman/test/179_skip_at_start_section_pad.dts
rename to tools/binman/test/pack/skip_at_start_section_pad.dts
diff --git a/tools/binman/test/024_sorted.dts b/tools/binman/test/pack/sorted.dts
similarity index 100%
rename from tools/binman/test/024_sorted.dts
rename to tools/binman/test/pack/sorted.dts
diff --git a/tools/binman/test/054_unit_address.dts b/tools/binman/test/pack/unit_address.dts
similarity index 100%
rename from tools/binman/test/054_unit_address.dts
rename to tools/binman/test/pack/unit_address.dts
diff --git a/tools/binman/test/079_uses_pos.dts b/tools/binman/test/pack/uses_pos.dts
similarity index 100%
rename from tools/binman/test/079_uses_pos.dts
rename to tools/binman/test/pack/uses_pos.dts
-- 
2.43.0

