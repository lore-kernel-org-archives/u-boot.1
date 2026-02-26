Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF03DFD9E25
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 23:50:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3890E83F69;
	Fri, 27 Feb 2026 00:49:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C04GCE1E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF4E983F2A; Fri, 27 Feb 2026 00:49:12 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80A9783F5B
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 00:49:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-8cb3a8494c5so147811185a.2
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 15:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772149741; x=1772754541; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J6oiMby/q3LycnjzTsd/33qPJtHW0cV8Xubh5OEj47U=;
 b=C04GCE1E0QXZBMdAG5687FcI1gQRYfESCmfi8VAs2Rnhk9y0fRRG6tlWNEKxcYYOod
 F1lb1xqDlR5593y4v2Z2AgoEiXdixPHycIDAHaswPd2OTBpDQJSKu8IVVXq/ADjpfIBg
 SiqSinHgSlvxfzm0z4Qo1HjbJKBAFnP6jQ2P8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772149741; x=1772754541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J6oiMby/q3LycnjzTsd/33qPJtHW0cV8Xubh5OEj47U=;
 b=poOnr+O9xybG4g4ciqADoAayPnPQFjU7efq5aCLTd9u6p4vzqeoUkoOanx8ih4YFTS
 rKuUijQHylTxOVQPUO69yi60ZA0596P8cRuap4+hqVQ/WfKjytj/o03i18UbN2FGdmHs
 G4fFPn5gkbHmoxqe4F9zD4JM9TaRHaLiRv9ThcPI4yWZ9GtWmMhiKLTdMtYqnPMyffpT
 rEOPPfpleTQOHNEpvBr43FsorkD3bgP+CSNVxwC/gdfgBGjq/Gjt7pafyElifm0fwukz
 Ncb+iQTen5z8qNpbIk35nOJxlsxYeyIagq+OR0hOAMyFAKJogAA4a6rZ6jHyiITQDRmU
 bXEA==
X-Gm-Message-State: AOJu0YxZKECeMzbCBs3/Tgp7pdPcN91qQL+5K+Ijr168Da2FOH6O1FYY
 3yD5vPTWTYtAemWfkjP7GXfwv4Lv69H6KQwNlLn3u3LbqKViwdXLOoK1YvIYG2M8iQeQcM99gK7
 acMI=
X-Gm-Gg: ATEYQzyH13738zpSwQ0rfxYMKWCMetGdJnDGxMbvCVq9LhZnfaWbBg2wG/qxSKGv3C3
 ILXX5Rp2C9DUB60s4aDpHMtNn4wXsyoAD3cwtL3dCySHZ7UFN9NuC/9dZFz/EkC3xgI8PYnfSMY
 IQcI297V7JW7fs9LnUc6AEFbGtK1qoYN4FKEz6ZTM5R86+tkYHSeZuJ94JImxVX56GdUUGClN1e
 xyUqSJ9Ewj4jlkUp9+8aGTW3X+gu14nb/282wUBR1jx2fIkODMkeUgGm52Bi2Gdi5BiCiP8DaAC
 yoVO6GUmUZPdYtv7U7qahJ7q+/OxlC4ORwzI+riazFYf7gWHjDDzCU64cxh/4nXwP9zswRbx+BQ
 S2eRIF7UZeQX5u3ucuH2SJvt4701cPw8Blzx9O7TEAm8anvfmt7+dM+yYs+0Vmy5MQXM3QXycqU
 CgENqNRQLJeg+Tu83GSA==
X-Received: by 2002:a05:620a:4402:b0:8b2:2066:ffca with SMTP id
 af79cd13be357-8cbc8eae81cmr95569185a.82.1772149741504; 
 Thu, 26 Feb 2026 15:49:01 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf68a0fbsm322024385a.22.2026.02.26.15.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 15:49:00 -0800 (PST)
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
Subject: [RFC PATCH 10/16] binman: test: Move mkimage test files to
 test/mkimage/
Date: Thu, 26 Feb 2026 16:47:50 -0700
Message-ID: <20260226234802.345968-11-sjg@chromium.org>
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

Move about a dozen test files for mkimage entries into a mkimage/
subdirectory. Drop the numeric prefixes and the redundant mkimage_
filename prefix, and update all references.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

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
index c2cea9e6618..8f5dcc2878c 100644
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

