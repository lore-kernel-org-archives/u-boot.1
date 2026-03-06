Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10999FCC050
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 18:15:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AB4B83FC5;
	Fri,  6 Mar 2026 19:14:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y0uHwSSw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7622884008; Fri,  6 Mar 2026 19:13:59 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12BF783FF5
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 19:13:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-8cb3e22435fso829859485a.1
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 10:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772820834; x=1773425634; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MkcqcGzA/lp0L9ACiUlj/YeOyxOKbGcxtzEvOkuEfRU=;
 b=Y0uHwSSwHIhMugWg4Ng24CliT/VW8uMdx1NWg+Q+jASiWj138ZEHuPG6Ukbr3x4tDi
 1WundrJyfRw7qw/8LdwVqUXrwVHq7s5lN2PXBXZaM/ZYGsgTFtGw+yvUgGWbU6E7M9yV
 lxeJVoDpj1PdkqxP4X+KcjAdnQGTvmIyffL+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772820834; x=1773425634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MkcqcGzA/lp0L9ACiUlj/YeOyxOKbGcxtzEvOkuEfRU=;
 b=YG0KufTYd4dBf6O4tR9bjy56VfhLvn5jQqll/ikOHF6b9DTKc2nVnQce1ZJQVlKIVX
 AfNycCKB5ZLDfc5WLwdNkVMCz+u3e05IH43WnmM5tDfF5m1KBAxCKBr868R2Kbc+Buoy
 ZxEU7VqoAFpyYdCrLpF8vpUh2YewKddfNxjEb1tBZaxiaM+jwaZSjVDEUkCPYlI/EYsq
 s8YnqD4v6iyDNexyLLZh6uXAwIxel/JbP+0Di2+gB26JCU9u5DcSA5iv2AijeQoKnZgt
 /vtn/QCQBvAeUUaPhcrRlz4bmEbPZDfWfxKL3uUI7ThOHadv+vQxEvFQq038ouqeNL7C
 GJrA==
X-Gm-Message-State: AOJu0Yxx0oTYRlI4+rL+rjKEy/Mjyh6lm73Iql/ydy+9NzlY/QeYNHb4
 NTDrNLQcruxMb5Uv4/R6ElLz13SFVEC2764LdorXcYX2F1pmXPaiuhqHhQPHxJkUPa0+ieIvOZR
 Uah4=
X-Gm-Gg: ATEYQzxQ4YptbgvtCnGKhYfU3d9DG3z52wjqpHqaud/AXrydc095HtIxHupBj14EHb1
 O9Z0un+ule9T2mYkaWv1uN9tKGsrOe0JH/m3+mzh4/LEliEz+peJfk/UIclBd3OP6iqm7Fujj5u
 r0tavBjaK7CLEDD8xrsxvoEmtksEP/pkd5vjD4xIga19fkLnefITPFw3mgWawiNe72jOor1t6Gu
 AxorNE0aUmRNAfSH05UNiPOameFgVod2yZkCpoiF1Cj4XRPofWAamKpNc8v6MV6012bxB+OCAVR
 ag8r3fIsckwy/oyALc5r50JuNYxVjs/voRX4FH4Qi/EiE5nZxPzYaLzF76iJkWe7GYUOF5YyYD/
 JXnnW7d+2WtxGXeM5HHIMO4ER1MBckTVveXFmSTCFANIzMRK9Iuk+shv8NzQNUHAqfLkvLouB1B
 41kdGAa4r3+EdyRdoNww==
X-Received: by 2002:ae9:c309:0:b0:8cd:75a9:eabe with SMTP id
 af79cd13be357-8cd75a9ec4fmr54106285a.9.1772820834294; 
 Fri, 06 Mar 2026 10:13:54 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f5736c0sm155930885a.49.2026.03.06.10.13.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 10:13:53 -0800 (PST)
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
Subject: [PATCH v2 11/23] binman: test: Move mkimage test files to
 test/mkimage/
Date: Fri,  6 Mar 2026 11:12:39 -0700
Message-ID: <20260306181304.2426352-12-sjg@chromium.org>
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

Move about a dozen test files for mkimage entries into a mkimage/
subdirectory. Drop the numeric prefixes and the redundant mkimage_
filename prefix, and update all references.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v1)

 tools/binman/ftest.py                         | 32 +++++++++----------
 .../coll.dts}                                 |  0
 .../filename.dts}                             |  0
 .../image.dts}                                |  0
 .../image_bad.dts}                            |  0
 .../image_no_content.dts}                     |  0
 .../missing.dts}                              |  0
 .../missing_multiple.dts}                     |  0
 .../{156_mkimage.dts => mkimage/mkimage.dts}  |  0
 .../mult_data.dts}                            |  0
 .../mult_no_content.dts}                      |  0
 .../name.dts}                                 |  0
 .../special.dts}                              |  0
 .../{290_mkimage_sym.dts => mkimage/sym.dts}  |  0
 14 files changed, 16 insertions(+), 16 deletions(-)
 rename tools/binman/test/{247_mkimage_coll.dts => mkimage/coll.dts} (100%)
 rename tools/binman/test/{254_mkimage_filename.dts => mkimage/filename.dts} (100%)
 rename tools/binman/test/{243_mkimage_image.dts => mkimage/image.dts} (100%)
 rename tools/binman/test/{245_mkimage_image_bad.dts => mkimage/image_bad.dts} (100%)
 rename tools/binman/test/{244_mkimage_image_no_content.dts => mkimage/image_no_content.dts} (100%)
 rename tools/binman/test/{229_mkimage_missing.dts => mkimage/missing.dts} (100%)
 rename tools/binman/test/{292_mkimage_missing_multiple.dts => mkimage/missing_multiple.dts} (100%)
 rename tools/binman/test/{156_mkimage.dts => mkimage/mkimage.dts} (100%)
 rename tools/binman/test/{252_mkimage_mult_data.dts => mkimage/mult_data.dts} (100%)
 rename tools/binman/test/{253_mkimage_mult_no_content.dts => mkimage/mult_no_content.dts} (100%)
 rename tools/binman/test/{242_mkimage_name.dts => mkimage/name.dts} (100%)
 rename tools/binman/test/{283_mkimage_special.dts => mkimage/special.dts} (100%)
 rename tools/binman/test/{290_mkimage_sym.dts => mkimage/sym.dts} (100%)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 87055a53bdf..43f421178cb 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -3868,7 +3868,7 @@ class TestFunctional(unittest.TestCase):
     def testMkimage(self):
         """Test using mkimage to build an image"""
         self._SetupSplElf()
-        data = self._DoReadFile('156_mkimage.dts')
+        data = self._DoReadFile('mkimage/mkimage.dts')
 
         # Just check that the data appears in the file somewhere
         self.assertIn(U_BOOT_SPL_DATA, data)
@@ -3877,7 +3877,7 @@ class TestFunctional(unittest.TestCase):
         """Test that binman still produces an image if mkimage is missing"""
         self._SetupSplElf()
         with terminal.capture() as (_, stderr):
-            self._DoTestFile('156_mkimage.dts',
+            self._DoTestFile('mkimage/mkimage.dts',
                              force_missing_bintools='mkimage')
         err = stderr.getvalue()
         self.assertRegex(err, "Image 'image'.*missing bintools.*: mkimage")
@@ -5809,7 +5809,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testMkimageMissingBlob(self):
         """Test using mkimage to build an image"""
         with terminal.capture() as (stdout, stderr):
-            self._DoTestFile('229_mkimage_missing.dts', allow_missing=True,
+            self._DoTestFile('mkimage/missing.dts', allow_missing=True,
                              allow_fake_blobs=True)
         err = stderr.getvalue()
         self.assertRegex(
@@ -6118,7 +6118,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testMkimageImagename(self):
         """Test using mkimage with -n holding the data too"""
         self._SetupSplElf()
-        data = self._DoReadFile('242_mkimage_name.dts')
+        data = self._DoReadFile('mkimage/name.dts')
 
         # Check that the data appears in the file somewhere
         self.assertIn(U_BOOT_SPL_DATA, data)
@@ -6136,7 +6136,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testMkimageImage(self):
         """Test using mkimage with -n holding the data too"""
         self._SetupSplElf()
-        data = self._DoReadFile('243_mkimage_image.dts')
+        data = self._DoReadFile('mkimage/image.dts')
 
         # Check that the data appears in the file somewhere
         self.assertIn(U_BOOT_SPL_DATA, data)
@@ -6158,7 +6158,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test using mkimage with -n and no data"""
         self._SetupSplElf()
         with self.assertRaises(ValueError) as exc:
-            self._DoReadFile('244_mkimage_image_no_content.dts')
+            self._DoReadFile('mkimage/image_no_content.dts')
         self.assertIn('Could not complete processing of contents',
                       str(exc.exception))
 
@@ -6166,7 +6166,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test using mkimage with imagename node and data-to-imagename"""
         self._SetupSplElf()
         with self.assertRaises(ValueError) as exc:
-            self._DoReadFile('245_mkimage_image_bad.dts')
+            self._DoReadFile('mkimage/image_bad.dts')
         self.assertIn('Cannot use both imagename node and data-to-imagename',
                       str(exc.exception))
 
@@ -6181,7 +6181,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testMkimageCollection(self):
         """Test using a collection referring to an entry in a mkimage entry"""
         self._SetupSplElf()
-        data = self._DoReadFile('247_mkimage_coll.dts')
+        data = self._DoReadFile('mkimage/coll.dts')
         expect = U_BOOT_SPL_DATA + U_BOOT_DATA
         self.assertEqual(expect, data[:len(expect)])
 
@@ -6269,7 +6269,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test passing multiple files to mkimage in a mkimage entry"""
         self._SetupSplElf()
         self._SetupTplElf()
-        data = self._DoReadFile('252_mkimage_mult_data.dts')
+        data = self._DoReadFile('mkimage/mult_data.dts')
         # Size of files are packed in their 4B big-endian format
         expect = struct.pack('>I', len(U_BOOT_TPL_DATA))
         expect += struct.pack('>I', len(U_BOOT_SPL_DATA))
@@ -6291,7 +6291,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             'spl-bss-pad': 'y',
             'spl-dtb': 'y',
         }
-        data = self._DoReadFileDtb('252_mkimage_mult_data.dts',
+        data = self._DoReadFileDtb('mkimage/mult_data.dts',
                                    use_expanded=True, entry_args=entry_args)[0]
         pad_len = 10
         tpl_expect = U_BOOT_TPL_DATA
@@ -6320,14 +6320,14 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test passing multiple data files to mkimage with one data file having no content"""
         self._SetupSplElf()
         with self.assertRaises(ValueError) as exc:
-            self._DoReadFile('253_mkimage_mult_no_content.dts')
+            self._DoReadFile('mkimage/mult_no_content.dts')
         self.assertIn('Could not complete processing of contents',
                       str(exc.exception))
 
     def testMkimageFilename(self):
         """Test using mkimage to build a binary with a filename"""
         self._SetupSplElf()
-        retcode = self._DoTestFile('254_mkimage_filename.dts')
+        retcode = self._DoTestFile('mkimage/filename.dts')
         self.assertEqual(0, retcode)
         fname = tools.get_output_filename('mkimage-test.bin')
         self.assertTrue(os.path.exists(fname))
@@ -6891,12 +6891,12 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testMkimageMissingBlobMultiple(self):
         """Test missing blob with mkimage entry and multiple-data-files"""
         with terminal.capture() as (stdout, stderr):
-            self._DoTestFile('292_mkimage_missing_multiple.dts', allow_missing=True)
+            self._DoTestFile('mkimage/missing_multiple.dts', allow_missing=True)
         err = stderr.getvalue()
         self.assertIn("is missing external blobs and is non-functional", err)
 
         with self.assertRaises(ValueError) as e:
-            self._DoTestFile('292_mkimage_missing_multiple.dts', allow_missing=False)
+            self._DoTestFile('mkimage/missing_multiple.dts', allow_missing=False)
         self.assertIn("not found in input path", str(e.exception))
 
     def _PrepareSignEnv(self, dts='fit/sign.dts'):
@@ -7002,7 +7002,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testMkimageSpecial(self):
         """Test mkimage ignores special hash-1 node"""
-        data = self._DoReadFile('283_mkimage_special.dts')
+        data = self._DoReadFile('mkimage/special.dts')
 
         # Just check that the data appears in the file somewhere
         self.assertIn(U_BOOT_DATA, data)
@@ -7085,7 +7085,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testMkimageSymbols(self):
         """Test using mkimage to build an image with symbols in it"""
         self._SetupSplElf('u_boot_binman_syms')
-        data = self._DoReadFile('290_mkimage_sym.dts')
+        data = self._DoReadFile('mkimage/sym.dts')
 
         image = control.images['image']
         entries = image.GetEntries()
diff --git a/tools/binman/test/247_mkimage_coll.dts b/tools/binman/test/mkimage/coll.dts
similarity index 100%
rename from tools/binman/test/247_mkimage_coll.dts
rename to tools/binman/test/mkimage/coll.dts
diff --git a/tools/binman/test/254_mkimage_filename.dts b/tools/binman/test/mkimage/filename.dts
similarity index 100%
rename from tools/binman/test/254_mkimage_filename.dts
rename to tools/binman/test/mkimage/filename.dts
diff --git a/tools/binman/test/243_mkimage_image.dts b/tools/binman/test/mkimage/image.dts
similarity index 100%
rename from tools/binman/test/243_mkimage_image.dts
rename to tools/binman/test/mkimage/image.dts
diff --git a/tools/binman/test/245_mkimage_image_bad.dts b/tools/binman/test/mkimage/image_bad.dts
similarity index 100%
rename from tools/binman/test/245_mkimage_image_bad.dts
rename to tools/binman/test/mkimage/image_bad.dts
diff --git a/tools/binman/test/244_mkimage_image_no_content.dts b/tools/binman/test/mkimage/image_no_content.dts
similarity index 100%
rename from tools/binman/test/244_mkimage_image_no_content.dts
rename to tools/binman/test/mkimage/image_no_content.dts
diff --git a/tools/binman/test/229_mkimage_missing.dts b/tools/binman/test/mkimage/missing.dts
similarity index 100%
rename from tools/binman/test/229_mkimage_missing.dts
rename to tools/binman/test/mkimage/missing.dts
diff --git a/tools/binman/test/292_mkimage_missing_multiple.dts b/tools/binman/test/mkimage/missing_multiple.dts
similarity index 100%
rename from tools/binman/test/292_mkimage_missing_multiple.dts
rename to tools/binman/test/mkimage/missing_multiple.dts
diff --git a/tools/binman/test/156_mkimage.dts b/tools/binman/test/mkimage/mkimage.dts
similarity index 100%
rename from tools/binman/test/156_mkimage.dts
rename to tools/binman/test/mkimage/mkimage.dts
diff --git a/tools/binman/test/252_mkimage_mult_data.dts b/tools/binman/test/mkimage/mult_data.dts
similarity index 100%
rename from tools/binman/test/252_mkimage_mult_data.dts
rename to tools/binman/test/mkimage/mult_data.dts
diff --git a/tools/binman/test/253_mkimage_mult_no_content.dts b/tools/binman/test/mkimage/mult_no_content.dts
similarity index 100%
rename from tools/binman/test/253_mkimage_mult_no_content.dts
rename to tools/binman/test/mkimage/mult_no_content.dts
diff --git a/tools/binman/test/242_mkimage_name.dts b/tools/binman/test/mkimage/name.dts
similarity index 100%
rename from tools/binman/test/242_mkimage_name.dts
rename to tools/binman/test/mkimage/name.dts
diff --git a/tools/binman/test/283_mkimage_special.dts b/tools/binman/test/mkimage/special.dts
similarity index 100%
rename from tools/binman/test/283_mkimage_special.dts
rename to tools/binman/test/mkimage/special.dts
diff --git a/tools/binman/test/290_mkimage_sym.dts b/tools/binman/test/mkimage/sym.dts
similarity index 100%
rename from tools/binman/test/290_mkimage_sym.dts
rename to tools/binman/test/mkimage/sym.dts
-- 
2.43.0

