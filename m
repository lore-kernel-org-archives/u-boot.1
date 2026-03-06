Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0767FFCC055
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 18:14:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27FF183FD4;
	Fri,  6 Mar 2026 19:13:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EQg37z3V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C444A83FDE; Fri,  6 Mar 2026 19:13:49 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65A6983FD4
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 19:13:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-8cb3a8494c5so900497585a.2
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 10:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772820825; x=1773425625; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CuU8MXmwTKp0kq+6i5GkQMxwoK6uUuP1fGMgGkIEIB4=;
 b=EQg37z3VTUAfI6lBBARgow8NK7YJG0XmsCcPa+IUCSFM0uTzcpvKI8U2TEBdZXuUsc
 NZDjJ0JHR8yFQNekxhYh4xgER/Eii+vkh+6sDz9GTkLSbuGa3wOribkrB8r1tRdNkOWU
 0f+cYrf3VVsFRtq0Ldj2qMWu34yoSuaq7unYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772820825; x=1773425625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CuU8MXmwTKp0kq+6i5GkQMxwoK6uUuP1fGMgGkIEIB4=;
 b=SUhUKBpG63klqgon+7VSFV57Bhcm56VnrO8utFdYc6QOvgK03/aAYDQhiwdkrYgMZH
 LQxT2nH/gByuQTG9lEE+oIPS0FUvnx/3Youd6EjU60KsP3D/qhwOkQAynzpIvdncYpKU
 rKrJ+BNEy1vCgVCcVUwwqd5bfZihWdKcG9nNByl5CwXxVaUQK2ToEAPZMlMqyXCG7614
 YLJCsBpcyosjiP9a1FOxTmujUx/26j3Sf8qu4QudvhvWURDE+n0Z2irDh6VppiVLnHvk
 ETr1zD/FaSWLhjnzplWc6+BLtkAnvoMuxPqp9UT4lEp8g1XdddGJ8keRbvT3iOiftMsl
 X3iA==
X-Gm-Message-State: AOJu0YyCI/6n+eSJlH+OSdlg8wsEP7qFhNAbQlqRU4u8j78W0V6hnNgJ
 ejHCuqqcJ871dh/c19/m4Jis/F02spP9+ulzwb1Lj1qomrdGPQBhIlF51BkC4qVtbz9VZnIdbL0
 RwSs=
X-Gm-Gg: ATEYQzxXw+Fxd+ecP2s5k/hSVctkJ7YGekxXM9733+3i2/gNyNd0VxOCmwwhraSh8+o
 DdNW/g/blh4DKV21JPzDZnqfr1eleYZY0RmJhVO8RIR996z4Wrxeb4jzoQuRm347o2x59q6JJEw
 TBAtKaH7Lzg7j/hMW6HYnidOrlPazpUtcEe0/ELS/R3y1S5lu//NXmTLEaGRbzANDJ9NUwHY1w4
 KalGDoAD3i2zDosi0aBOn8Jxaa4nkW56tb0O2aZkEuA0gHMjb/2+0nZ28BGJEYQXjU5m1fpjgWD
 onEwvoxZ4alJ5caHuAfDhLJclNU7xSvNmcHIDE5XN8+7HxONntW+DUukmgGkMaqA72CDyNMI/Ub
 rE+7pXaYCc9pz9SDGDCVwD39UqEIGFj7eX573GUClxz7gYbIiqBtd5t8AWSl9ZZW1KPfYXW1oj4
 gjO5cerWbBGsKQUO8DpQ==
X-Received: by 2002:a05:620a:1723:b0:8b1:728f:952e with SMTP id
 af79cd13be357-8cd6d38c0cfmr416657985a.31.1772820825195; 
 Fri, 06 Mar 2026 10:13:45 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f5736c0sm155930885a.49.2026.03.06.10.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 10:13:44 -0800 (PST)
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
Subject: [PATCH v2 07/23] binman: test: Move blob test files to test/blob/
Date: Fri,  6 Mar 2026 11:12:35 -0700
Message-ID: <20260306181304.2426352-8-sjg@chromium.org>
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

Move about a dozen test files for blob, blob-ext, blob-ext-list,
fake-blob, and blob-symbol entries into a blob/ subdirectory. Drop
the numeric prefixes and the redundant blob_ filename prefix, and
update all references.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v1)

 tools/binman/ftest.py                         | 34 +++++++++----------
 .../test/{023_blob.dts => blob/blob.dts}      |  0
 .../test/{157_blob_ext.dts => blob/ext.dts}   |  0
 .../ext_list.dts}                             |  0
 .../ext_list_fake.dts}                        |  0
 .../ext_list_missing.dts}                     |  0
 .../ext_missing.dts}                          |  0
 .../ext_missing_sect.dts}                     |  0
 .../ext_opt.dts}                              |  0
 .../test/{217_fake_blob.dts => blob/fake.dts} |  0
 .../missing.dts}                              |  0
 .../named_by_arg.dts}                         |  0
 .../{273_blob_symbol.dts => blob/symbol.dts}  |  0
 13 files changed, 17 insertions(+), 17 deletions(-)
 rename tools/binman/test/{023_blob.dts => blob/blob.dts} (100%)
 rename tools/binman/test/{157_blob_ext.dts => blob/ext.dts} (100%)
 rename tools/binman/test/{215_blob_ext_list.dts => blob/ext_list.dts} (100%)
 rename tools/binman/test/{218_blob_ext_list_fake.dts => blob/ext_list_fake.dts} (100%)
 rename tools/binman/test/{216_blob_ext_list_missing.dts => blob/ext_list_missing.dts} (100%)
 rename tools/binman/test/{158_blob_ext_missing.dts => blob/ext_missing.dts} (100%)
 rename tools/binman/test/{159_blob_ext_missing_sect.dts => blob/ext_missing_sect.dts} (100%)
 rename tools/binman/test/{266_blob_ext_opt.dts => blob/ext_opt.dts} (100%)
 rename tools/binman/test/{217_fake_blob.dts => blob/fake.dts} (100%)
 rename tools/binman/test/{173_missing_blob.dts => blob/missing.dts} (100%)
 rename tools/binman/test/{068_blob_named_by_arg.dts => blob/named_by_arg.dts} (100%)
 rename tools/binman/test/{273_blob_symbol.dts => blob/symbol.dts} (100%)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 8e37c0bd19e..612a1bdb8cb 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -1157,7 +1157,7 @@ class TestFunctional(unittest.TestCase):
 
     def testBlobFilename(self):
         """Test that generic blobs can be provided by filename"""
-        data = self._DoReadFile('023_blob.dts')
+        data = self._DoReadFile('blob/blob.dts')
         self.assertEqual(BLOB_DATA, data)
 
     def testPackSorted(self):
@@ -1866,7 +1866,7 @@ class TestFunctional(unittest.TestCase):
         entry_args = {
             'cros-ec-rw-path': 'ecrw.bin',
         }
-        self._DoReadFileDtb('068_blob_named_by_arg.dts', entry_args=entry_args)
+        self._DoReadFileDtb('blob/named_by_arg.dts', entry_args=entry_args)
 
     def testFill(self):
         """Test for an fill entry type"""
@@ -3884,20 +3884,20 @@ class TestFunctional(unittest.TestCase):
 
     def testExtblob(self):
         """Test an image with an external blob"""
-        data = self._DoReadFile('157_blob_ext.dts')
+        data = self._DoReadFile('blob/ext.dts')
         self.assertEqual(REFCODE_DATA, data)
 
     def testExtblobMissing(self):
         """Test an image with a missing external blob"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('158_blob_ext_missing.dts')
+            self._DoReadFile('blob/ext_missing.dts')
         self.assertIn("Filename 'missing-file' not found in input path",
                       str(e.exception))
 
     def testExtblobMissingOk(self):
         """Test an image with an missing external blob that is allowed"""
         with terminal.capture() as (stdout, stderr):
-            ret = self._DoTestFile('158_blob_ext_missing.dts',
+            ret = self._DoTestFile('blob/ext_missing.dts',
                                    allow_missing=True)
         self.assertEqual(103, ret)
         err = stderr.getvalue()
@@ -3908,7 +3908,7 @@ class TestFunctional(unittest.TestCase):
     def testExtblobMissingOkFlag(self):
         """Test an image with an missing external blob allowed with -W"""
         with terminal.capture() as (stdout, stderr):
-            ret = self._DoTestFile('158_blob_ext_missing.dts',
+            ret = self._DoTestFile('blob/ext_missing.dts',
                                    allow_missing=True, ignore_missing=True)
         self.assertEqual(0, ret)
         err = stderr.getvalue()
@@ -3919,7 +3919,7 @@ class TestFunctional(unittest.TestCase):
     def testExtblobMissingOkSect(self):
         """Test an image with an missing external blob that is allowed"""
         with terminal.capture() as (stdout, stderr):
-            self._DoTestFile('159_blob_ext_missing_sect.dts',
+            self._DoTestFile('blob/ext_missing_sect.dts',
                              allow_missing=True)
         err = stderr.getvalue()
         self.assertRegex(err, "Image 'image'.*missing.*: blob-ext blob-ext2")
@@ -4241,7 +4241,7 @@ class TestFunctional(unittest.TestCase):
     def testBlobNamedByArgMissing(self):
         """Test handling of a missing entry arg"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('068_blob_named_by_arg.dts')
+            self._DoReadFile('blob/named_by_arg.dts')
         self.assertIn("Missing required properties/entry args: cros-ec-rw-path",
                       str(e.exception))
 
@@ -4415,7 +4415,7 @@ class TestFunctional(unittest.TestCase):
     def testMissingBlob(self):
         """Test handling of a blob containing a missing file"""
         with self.assertRaises(ValueError) as e:
-            self._DoTestFile('173_missing_blob.dts', allow_missing=True)
+            self._DoTestFile('blob/missing.dts', allow_missing=True)
         self.assertIn("Filename 'missing' not found in input path",
                       str(e.exception))
 
@@ -5212,14 +5212,14 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testExtblobList(self):
         """Test an image with an external blob list"""
-        data = self._DoReadFileDtb('215_blob_ext_list.dts',
+        data = self._DoReadFileDtb('blob/ext_list.dts',
                                    allow_fake_blobs=False)
         self.assertEqual(REFCODE_DATA + FSP_M_DATA, data[0])
 
     def testExtblobListMissing(self):
         """Test an image with a missing external blob"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFileDtb('216_blob_ext_list_missing.dts',
+            self._DoReadFileDtb('blob/ext_list_missing.dts',
                                 allow_fake_blobs=False)
         self.assertIn("Filename 'missing-file' not found in input path",
                       str(e.exception))
@@ -5227,7 +5227,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testExtblobListMissingOk(self):
         """Test an image with an missing external blob that is allowed"""
         with terminal.capture() as (stdout, stderr):
-            self._DoTestFile('216_blob_ext_list_missing.dts',
+            self._DoTestFile('blob/ext_list_missing.dts',
                              allow_missing=True, allow_fake_blobs=False)
         err = stderr.getvalue()
         self.assertRegex(err, "Image 'image'.*missing.*: blob-ext")
@@ -5441,7 +5441,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testFakeBlob(self):
         """Test handling of faking an external blob"""
         with terminal.capture() as (stdout, stderr):
-            self._DoTestFile('217_fake_blob.dts', allow_missing=True,
+            self._DoTestFile('blob/fake.dts', allow_missing=True,
                              allow_fake_blobs=True)
         err = stderr.getvalue()
         self.assertRegex(
@@ -5451,7 +5451,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testExtblobListFaked(self):
         """Test an extblob with missing external blob that are faked"""
         with terminal.capture() as (stdout, stderr):
-            self._DoTestFile('216_blob_ext_list_missing.dts',
+            self._DoTestFile('blob/ext_list_missing.dts',
                              allow_fake_blobs=True)
         err = stderr.getvalue()
         self.assertRegex(err, "Image 'image'.*faked.*: blob-ext-list")
@@ -6560,7 +6560,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testExtblobMissingOptional(self):
         """Test an image with an external blob that is optional"""
         with terminal.capture() as (stdout, stderr):
-            data = self._DoReadFileDtb('266_blob_ext_opt.dts',
+            data = self._DoReadFileDtb('blob/ext_opt.dts',
                                        allow_fake_blobs=False)[0]
         self.assertEqual(REFCODE_DATA, data)
         self.assertNotIn(MISSING_DATA, data)
@@ -6568,7 +6568,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testExtblobFakedOptional(self):
         """Test an image with an external blob that is optional"""
         with terminal.capture() as (stdout, stderr):
-            data = self._DoReadFile('266_blob_ext_opt.dts')
+            data = self._DoReadFile('blob/ext_opt.dts')
         self.assertEqual(REFCODE_DATA, data)
         err = stderr.getvalue()
         self.assertRegex(
@@ -6659,7 +6659,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         TestFunctional._MakeInputFile('blob_syms.bin',
             tools.read_file(self.ElfTestFile('blob_syms.bin')))
 
-        data = self._DoReadFile('273_blob_symbol.dts')
+        data = self._DoReadFile('blob/symbol.dts')
 
         syms = elf.GetSymbols(elf_fname, ['binman', 'image'])
         addr = elf.GetSymbolAddress(elf_fname, '__my_start_sym')
diff --git a/tools/binman/test/023_blob.dts b/tools/binman/test/blob/blob.dts
similarity index 100%
rename from tools/binman/test/023_blob.dts
rename to tools/binman/test/blob/blob.dts
diff --git a/tools/binman/test/157_blob_ext.dts b/tools/binman/test/blob/ext.dts
similarity index 100%
rename from tools/binman/test/157_blob_ext.dts
rename to tools/binman/test/blob/ext.dts
diff --git a/tools/binman/test/215_blob_ext_list.dts b/tools/binman/test/blob/ext_list.dts
similarity index 100%
rename from tools/binman/test/215_blob_ext_list.dts
rename to tools/binman/test/blob/ext_list.dts
diff --git a/tools/binman/test/218_blob_ext_list_fake.dts b/tools/binman/test/blob/ext_list_fake.dts
similarity index 100%
rename from tools/binman/test/218_blob_ext_list_fake.dts
rename to tools/binman/test/blob/ext_list_fake.dts
diff --git a/tools/binman/test/216_blob_ext_list_missing.dts b/tools/binman/test/blob/ext_list_missing.dts
similarity index 100%
rename from tools/binman/test/216_blob_ext_list_missing.dts
rename to tools/binman/test/blob/ext_list_missing.dts
diff --git a/tools/binman/test/158_blob_ext_missing.dts b/tools/binman/test/blob/ext_missing.dts
similarity index 100%
rename from tools/binman/test/158_blob_ext_missing.dts
rename to tools/binman/test/blob/ext_missing.dts
diff --git a/tools/binman/test/159_blob_ext_missing_sect.dts b/tools/binman/test/blob/ext_missing_sect.dts
similarity index 100%
rename from tools/binman/test/159_blob_ext_missing_sect.dts
rename to tools/binman/test/blob/ext_missing_sect.dts
diff --git a/tools/binman/test/266_blob_ext_opt.dts b/tools/binman/test/blob/ext_opt.dts
similarity index 100%
rename from tools/binman/test/266_blob_ext_opt.dts
rename to tools/binman/test/blob/ext_opt.dts
diff --git a/tools/binman/test/217_fake_blob.dts b/tools/binman/test/blob/fake.dts
similarity index 100%
rename from tools/binman/test/217_fake_blob.dts
rename to tools/binman/test/blob/fake.dts
diff --git a/tools/binman/test/173_missing_blob.dts b/tools/binman/test/blob/missing.dts
similarity index 100%
rename from tools/binman/test/173_missing_blob.dts
rename to tools/binman/test/blob/missing.dts
diff --git a/tools/binman/test/068_blob_named_by_arg.dts b/tools/binman/test/blob/named_by_arg.dts
similarity index 100%
rename from tools/binman/test/068_blob_named_by_arg.dts
rename to tools/binman/test/blob/named_by_arg.dts
diff --git a/tools/binman/test/273_blob_symbol.dts b/tools/binman/test/blob/symbol.dts
similarity index 100%
rename from tools/binman/test/273_blob_symbol.dts
rename to tools/binman/test/blob/symbol.dts
-- 
2.43.0

