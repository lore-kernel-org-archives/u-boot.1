Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C60FD9E25
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 23:49:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF7E383F8F;
	Fri, 27 Feb 2026 00:49:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BMqG7fas";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3664E83F4E; Fri, 27 Feb 2026 00:49:06 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BFA383EC8
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 00:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-8c711959442so228341485a.0
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 15:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772149737; x=1772754537; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YmwqsBZzx9KDaPUWdMBvWPdMU7YZ0LwYeqd74DNdjaA=;
 b=BMqG7fasEl0grz2U4NNaqe32JtVjPTPU/s3MCkRWbnLUWP6yaj2f6iwpvCO+rpDikM
 nupda3dnZRXMNXC/RoK6rxP1Ndqg8VBXqgl32OTbkdwLK8xryTTJsbHfGxV3PHCeuZla
 FfamohFQ0urH2wdNGLUdv6/KYD9UwEswmXBZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772149737; x=1772754537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YmwqsBZzx9KDaPUWdMBvWPdMU7YZ0LwYeqd74DNdjaA=;
 b=gzfgAbFnhGsZ1GQkWqqxXxMl5HxK1jtIBwer/hFlpoXBwIkadI+ZaYInAN/t/1Li1F
 dV6RY0isA5kBRbCahTPzTIb7wXjwDFOUfhPscDD1C1/8zyG69u4TBs3By3DlpXURBqc7
 vbY90B/odlWB/teEpgVGOj6i5x+seOTvhSL5axWFQtBNkyo+gYcN3bnFpkGDmGTpSAs0
 RpJWWEN0iMwkrtRPKGUe8Nir4DgkM7aClkn7QtcCEVHwakZgz+z06ELZTKinYdKkCmi3
 9vTNPOYN98LvMZelewcjvzabYgMQcY49K7PXYi1CIspVX+SOnL7xgS4Ok6TKD12TZZTL
 fAMQ==
X-Gm-Message-State: AOJu0Yy1KuctN2Aa1jx85yEiuMrmSOUjFB3FmxxNPGobrhW4o5FVjHR1
 u9C5hPNX+zCBaXcJtnXykW0qPBeFzvw2fzOfdPcaeSf+1p5bULWhZ6XTvE3BpXg9aOcFlSVHmYG
 6AcY=
X-Gm-Gg: ATEYQzwy83AIkSn1ZxvA/aRaBTZFen47WvXOFKfEqWU/YRNhZX8rmzSLGgbabnRQF+2
 ukMj4O6le8oB9mL+FYZf5ap0UUZY1b5uNTwoDmDDlc2uyX3oAbtGilfOqZQj6HV+gR6EfCy3i+J
 DTHn5D+ubJTQLzT8yiQDCev+8AANU4OPgpcAI/KCVT1QaxTPQ5iRXSPex5mNn2Ks90tUqkemHEd
 Uz0bPQHt8HpEOMmRljfAGCMc1qx12MZvzCmVtN7XVCidKLh409+xkprOXU4otXz1Ojn9jw+DeJT
 BKwQU/RkADgyIoKwxpmWIGBbi61NPQH9cIVspYirpl5/kOby9mDrjfbm2sv6HwoBm2qsr5u2Wjd
 d6wdtSl3h/07CJl9IwNaa4lSmRUl7PD3xoxVGcehzfL0DyewujHPxTv3G9LsTd/WxvSV+HGnrjw
 cmHfKvC6s4gQEfgXN+JP2+yPJ6Uua9
X-Received: by 2002:a05:620a:45a6:b0:8cb:bae9:9f42 with SMTP id
 af79cd13be357-8cbc8cde6e1mr107579085a.27.1772149737407; 
 Thu, 26 Feb 2026 15:48:57 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf68a0fbsm322024385a.22.2026.02.26.15.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 15:48:56 -0800 (PST)
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
Subject: [RFC PATCH 08/16] binman: test: Move CBFS test files to test/cbfs/
Date: Thu, 26 Feb 2026 16:47:48 -0700
Message-ID: <20260226234802.345968-9-sjg@chromium.org>
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

Move about a dozen test files for Coreboot File System entries into a
cbfs/ subdirectory. Drop the numeric prefixes and the redundant cbfs_
filename prefix, and update all references.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 tools/binman/ftest.py                         | 28 +++++++++----------
 .../bad_arch.dts}                             |  0
 .../bad_compress.dts}                         |  0
 .../bad_type.dts}                             |  0
 .../test/{110_cbfs_name.dts => cbfs/name.dts} |  0
 .../no_contents.dts}                          |  0
 .../no_size.dts}                              |  0
 .../{114_cbfs_offset.dts => cbfs/offset.dts}  |  0
 .../test/{102_cbfs_raw.dts => cbfs/raw.dts}   |  0
 .../raw_compress.dts}                         |  0
 .../raw_ppc.dts}                              |  0
 .../replace.dts}                              |  0
 .../{104_cbfs_stage.dts => cbfs/stage.dts}    |  0
 .../{125_cbfs_update.dts => cbfs/update.dts}  |  0
 14 files changed, 14 insertions(+), 14 deletions(-)
 rename tools/binman/test/{106_cbfs_bad_arch.dts => cbfs/bad_arch.dts} (100%)
 rename tools/binman/test/{109_cbfs_bad_compress.dts => cbfs/bad_compress.dts} (100%)
 rename tools/binman/test/{126_cbfs_bad_type.dts => cbfs/bad_type.dts} (100%)
 rename tools/binman/test/{110_cbfs_name.dts => cbfs/name.dts} (100%)
 rename tools/binman/test/{108_cbfs_no_contents.dts => cbfs/no_contents.dts} (100%)
 rename tools/binman/test/{107_cbfs_no_size.dts => cbfs/no_size.dts} (100%)
 rename tools/binman/test/{114_cbfs_offset.dts => cbfs/offset.dts} (100%)
 rename tools/binman/test/{102_cbfs_raw.dts => cbfs/raw.dts} (100%)
 rename tools/binman/test/{105_cbfs_raw_compress.dts => cbfs/raw_compress.dts} (100%)
 rename tools/binman/test/{103_cbfs_raw_ppc.dts => cbfs/raw_ppc.dts} (100%)
 rename tools/binman/test/{142_replace_cbfs.dts => cbfs/replace.dts} (100%)
 rename tools/binman/test/{104_cbfs_stage.dts => cbfs/stage.dts} (100%)
 rename tools/binman/test/{125_cbfs_update.dts => cbfs/update.dts} (100%)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 12af9a30055..5284fd3a11a 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -2432,7 +2432,7 @@ class TestFunctional(unittest.TestCase):
         cbfs_util_test.py. The tests here merely check that the files added to
         the CBFS can be found in the final image.
         """
-        data = self._DoReadFile('102_cbfs_raw.dts')
+        data = self._DoReadFile('cbfs/raw.dts')
         size = 0xb0
 
         cbfs = cbfs_util.CbfsReader(data)
@@ -2444,7 +2444,7 @@ class TestFunctional(unittest.TestCase):
 
     def testCbfsArch(self):
         """Test on non-x86 architecture"""
-        data = self._DoReadFile('103_cbfs_raw_ppc.dts')
+        data = self._DoReadFile('cbfs/raw_ppc.dts')
         size = 0x100
 
         cbfs = cbfs_util.CbfsReader(data)
@@ -2462,7 +2462,7 @@ class TestFunctional(unittest.TestCase):
         elf.MakeElf(elf_fname, U_BOOT_DATA, U_BOOT_DTB_DATA)
         size = 0xb0
 
-        data = self._DoReadFile('104_cbfs_stage.dts')
+        data = self._DoReadFile('cbfs/stage.dts')
         cbfs = cbfs_util.CbfsReader(data)
         self.assertEqual(size, cbfs.rom_size)
 
@@ -2473,7 +2473,7 @@ class TestFunctional(unittest.TestCase):
     def testCbfsRawCompress(self):
         """Test handling of compressing raw files"""
         self._CheckLz4()
-        data = self._DoReadFile('105_cbfs_raw_compress.dts')
+        data = self._DoReadFile('cbfs/raw_compress.dts')
         size = 0x140
 
         cbfs = cbfs_util.CbfsReader(data)
@@ -2484,32 +2484,32 @@ class TestFunctional(unittest.TestCase):
     def testCbfsBadArch(self):
         """Test handling of a bad architecture"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('106_cbfs_bad_arch.dts')
+            self._DoReadFile('cbfs/bad_arch.dts')
         self.assertIn("Invalid architecture 'bad-arch'", str(e.exception))
 
     def testCbfsNoSize(self):
         """Test handling of a missing size property"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('107_cbfs_no_size.dts')
+            self._DoReadFile('cbfs/no_size.dts')
         self.assertIn('entry must have a size property', str(e.exception))
 
     def testCbfsNoContents(self):
         """Test handling of a CBFS entry which does not provide contentsy"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('108_cbfs_no_contents.dts')
+            self._DoReadFile('cbfs/no_contents.dts')
         self.assertIn('Could not complete processing of contents',
                       str(e.exception))
 
     def testCbfsBadCompress(self):
         """Test handling of a bad architecture"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('109_cbfs_bad_compress.dts')
+            self._DoReadFile('cbfs/bad_compress.dts')
         self.assertIn("Invalid compression in 'u-boot': 'invalid-algo'",
                       str(e.exception))
 
     def testCbfsNamedEntries(self):
         """Test handling of named entries"""
-        data = self._DoReadFile('110_cbfs_name.dts')
+        data = self._DoReadFile('cbfs/name.dts')
 
         cbfs = cbfs_util.CbfsReader(data)
         self.assertIn('FRED', cbfs.files)
@@ -2589,7 +2589,7 @@ class TestFunctional(unittest.TestCase):
         Like all CFBS tests, this is just checking the logic that calls
         cbfs_util. See cbfs_util_test for fully tests (e.g. test_cbfs_offset()).
         """
-        data = self._DoReadFile('114_cbfs_offset.dts')
+        data = self._DoReadFile('cbfs/offset.dts')
         size = 0x200
 
         cbfs = cbfs_util.CbfsReader(data)
@@ -2731,7 +2731,7 @@ class TestFunctional(unittest.TestCase):
     def testCbfsUpdateFdt(self):
         """Test that we can update the device tree with CBFS offset/size info"""
         self._CheckLz4()
-        data, _, _, out_dtb_fname = self._DoReadFileDtb('125_cbfs_update.dts',
+        data, _, _, out_dtb_fname = self._DoReadFileDtb('cbfs/update.dts',
                                                         update_dtb=True)
         dtb = fdt.Fdt(out_dtb_fname)
         dtb.Scan()
@@ -2755,7 +2755,7 @@ class TestFunctional(unittest.TestCase):
     def testCbfsBadType(self):
         """Test an image header with a no specified location is detected"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('126_cbfs_bad_type.dts')
+            self._DoReadFile('cbfs/bad_type.dts')
         self.assertIn("Unknown cbfs-type 'badtype'", str(e.exception))
 
     def testList(self):
@@ -3565,7 +3565,7 @@ class TestFunctional(unittest.TestCase):
         """Test replacing a single file in CBFS without changing the size"""
         self._CheckLz4()
         expected = b'x' * len(U_BOOT_DATA)
-        data = self._DoReadFileRealDtb('142_replace_cbfs.dts')
+        data = self._DoReadFileRealDtb('cbfs/replace.dts')
         updated_fname = tools.get_output_filename('image-updated.bin')
         tools.write_file(updated_fname, data)
         entry_name = 'section/cbfs/u-boot'
@@ -3578,7 +3578,7 @@ class TestFunctional(unittest.TestCase):
         """Test replacing a single file in CBFS with one of a different size"""
         self._CheckLz4()
         expected = U_BOOT_DATA + b'x'
-        data = self._DoReadFileRealDtb('142_replace_cbfs.dts')
+        data = self._DoReadFileRealDtb('cbfs/replace.dts')
         updated_fname = tools.get_output_filename('image-updated.bin')
         tools.write_file(updated_fname, data)
         entry_name = 'section/cbfs/u-boot'
diff --git a/tools/binman/test/106_cbfs_bad_arch.dts b/tools/binman/test/cbfs/bad_arch.dts
similarity index 100%
rename from tools/binman/test/106_cbfs_bad_arch.dts
rename to tools/binman/test/cbfs/bad_arch.dts
diff --git a/tools/binman/test/109_cbfs_bad_compress.dts b/tools/binman/test/cbfs/bad_compress.dts
similarity index 100%
rename from tools/binman/test/109_cbfs_bad_compress.dts
rename to tools/binman/test/cbfs/bad_compress.dts
diff --git a/tools/binman/test/126_cbfs_bad_type.dts b/tools/binman/test/cbfs/bad_type.dts
similarity index 100%
rename from tools/binman/test/126_cbfs_bad_type.dts
rename to tools/binman/test/cbfs/bad_type.dts
diff --git a/tools/binman/test/110_cbfs_name.dts b/tools/binman/test/cbfs/name.dts
similarity index 100%
rename from tools/binman/test/110_cbfs_name.dts
rename to tools/binman/test/cbfs/name.dts
diff --git a/tools/binman/test/108_cbfs_no_contents.dts b/tools/binman/test/cbfs/no_contents.dts
similarity index 100%
rename from tools/binman/test/108_cbfs_no_contents.dts
rename to tools/binman/test/cbfs/no_contents.dts
diff --git a/tools/binman/test/107_cbfs_no_size.dts b/tools/binman/test/cbfs/no_size.dts
similarity index 100%
rename from tools/binman/test/107_cbfs_no_size.dts
rename to tools/binman/test/cbfs/no_size.dts
diff --git a/tools/binman/test/114_cbfs_offset.dts b/tools/binman/test/cbfs/offset.dts
similarity index 100%
rename from tools/binman/test/114_cbfs_offset.dts
rename to tools/binman/test/cbfs/offset.dts
diff --git a/tools/binman/test/102_cbfs_raw.dts b/tools/binman/test/cbfs/raw.dts
similarity index 100%
rename from tools/binman/test/102_cbfs_raw.dts
rename to tools/binman/test/cbfs/raw.dts
diff --git a/tools/binman/test/105_cbfs_raw_compress.dts b/tools/binman/test/cbfs/raw_compress.dts
similarity index 100%
rename from tools/binman/test/105_cbfs_raw_compress.dts
rename to tools/binman/test/cbfs/raw_compress.dts
diff --git a/tools/binman/test/103_cbfs_raw_ppc.dts b/tools/binman/test/cbfs/raw_ppc.dts
similarity index 100%
rename from tools/binman/test/103_cbfs_raw_ppc.dts
rename to tools/binman/test/cbfs/raw_ppc.dts
diff --git a/tools/binman/test/142_replace_cbfs.dts b/tools/binman/test/cbfs/replace.dts
similarity index 100%
rename from tools/binman/test/142_replace_cbfs.dts
rename to tools/binman/test/cbfs/replace.dts
diff --git a/tools/binman/test/104_cbfs_stage.dts b/tools/binman/test/cbfs/stage.dts
similarity index 100%
rename from tools/binman/test/104_cbfs_stage.dts
rename to tools/binman/test/cbfs/stage.dts
diff --git a/tools/binman/test/125_cbfs_update.dts b/tools/binman/test/cbfs/update.dts
similarity index 100%
rename from tools/binman/test/125_cbfs_update.dts
rename to tools/binman/test/cbfs/update.dts
-- 
2.43.0

