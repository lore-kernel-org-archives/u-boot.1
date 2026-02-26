Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E43FD9E1E
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 23:49:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88A5483F61;
	Fri, 27 Feb 2026 00:49:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d2Jh2/5t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC2BF83F32; Fri, 27 Feb 2026 00:48:58 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D83D283EC8
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 00:48:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-899a2f4cdddso17951726d6.2
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 15:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772149733; x=1772754533; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GasPQtdjOWulQdMHLDsmg7caPKpTMPY/W/s6DOrm2jA=;
 b=d2Jh2/5tqvaDD6K3cffhGO4WqoD+YisOVRD3Xs1oNCB5vcjJ568amA9xl8RfpXJAYw
 eOe6JBuGiBHegGEhrnZ5YdOAi9zagMNyCy1wx5K2IPT6Slk8a2csOvlGsobS03G2ndwR
 N69VNmj9o/Fy3eT2zCHUCzD9FkfApBAVKwv8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772149733; x=1772754533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GasPQtdjOWulQdMHLDsmg7caPKpTMPY/W/s6DOrm2jA=;
 b=Hz24d9bV4OPK4do6sCr32AV5qvNlzoN83LZ+Uv9+HYCNjsyu3Pko2ekdEduYXwp4j1
 bmtbKukQ/Z/RDdDlP4pz/KDvjkPD373B0xJof6m5j1OAdpB4RAcUZwTpA5bwdhW7ZBzb
 32ghk0sRN8D3Pgk+9RteGlEaAPBRujKYvSs76+D0jteAuq1+y8SX1xKaswX34CvgCy9I
 jGlmmLW+x9mMQhxxQAkHe/p+deij/VSXx1ZTSGbOwkyiG4VzjhyMYPy2IbFHMr4xLsE+
 T6eJ5+oDN2+9XOubVd8Yh8zcfK/5UywK9FCprXB47LpiMJUldxpscg4DC5wc5aB8iGl3
 Bx5Q==
X-Gm-Message-State: AOJu0YwaPy/u7nDpRHMNOYxVlolGA2NrXbHQkyXA1wOh3/RQcVcB4ZWp
 5H5Wu1VKoD8SmxJuhxT5oEUaN5pVrBzePqf/5L5mKgfScJcqECvCh33qZIFbG39HBO6rJSVHf/o
 MszA=
X-Gm-Gg: ATEYQzwkqjKNcGACpfdyNDnMvgzAqxEpaW9gQFrHpTdPfwcY0LDG+EtWwXBx6kwlnTO
 s9XNDo7zLDNhuItFWM8bqGmWG8dizF+jShU0DGd6TuisN53aOIC2zTvZvLL3rtM8VCDrAauttOh
 ZCHbGrb9lesdJevtwBmDup54X1SwyoAroGQUNdaRzMzz2ilWku4ncKwkY86k8j/veLCxqfuwL++
 Q+5TQeDrBfSVPYMsfYc2NIH3YIzE5J6bQ2KTHCN5CrsEWxoKHYnC975CR8qddBNV9kbWEvZdWNT
 56mhF+C5nvs8ZfKTaARMYZ/ZMomvOznM+EU0UzB0MRSAWDYHsEP5cAOYYnTLijYvcgvdF0StAOr
 5az1Jk//wqbnqK57nxEfIL6ebU039uu2w5qeiVJoS5TEJckAw1kdZ0gBVi3XV1nOSF19od03iDR
 5jqBE/etcrKle4lxY1QQ==
X-Received: by 2002:a05:6214:1941:b0:894:7143:3f26 with SMTP id
 6a1803df08f44-899d1dde281mr16042926d6.22.1772149733080; 
 Thu, 26 Feb 2026 15:48:53 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf68a0fbsm322024385a.22.2026.02.26.15.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 15:48:52 -0800 (PST)
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
Subject: [RFC PATCH 06/16] binman: test: Move blob test files to test/blob/
Date: Thu, 26 Feb 2026 16:47:46 -0700
Message-ID: <20260226234802.345968-7-sjg@chromium.org>
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

Move about a dozen test files for blob, blob-ext, blob-ext-list,
fake-blob, and blob-symbol entries into a blob/ subdirectory. Drop
the numeric prefixes and the redundant blob_ filename prefix, and
update all references.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

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
index 14d3538bc9e..074f3236c73 100644
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

