Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299FFFCC055
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 18:15:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C590883FE9;
	Fri,  6 Mar 2026 19:13:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kwrp3Eh1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1933C83FEE; Fri,  6 Mar 2026 19:13:54 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E94783FE9
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 19:13:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-8c6f21c2d81so899126185a.2
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 10:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772820830; x=1773425630; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BQsQiJ1tCxvwwFf/kJp7sG0FpeDCs7DhNir0VpPG04g=;
 b=kwrp3Eh1JEGchfJUZes22/u90TzfdzMiiJmsXNzgRWzwi4MOA5p+5QNTNHqzExJlNc
 cmkhv86mMBATHCANzVH/MGapMGndfafTHouScF9PM88CPnB43wnQq4+uODoF6y6ZyDgt
 Zs7sNc06SRa5NHJ3d3TxQXPDahFwmcDX6G39o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772820830; x=1773425630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BQsQiJ1tCxvwwFf/kJp7sG0FpeDCs7DhNir0VpPG04g=;
 b=dX/e+ngWLK3mPmkg4kyAHV+e2uW9sPW0B6+fWA+1+PreLfT/gkcMqaZQ918UdVLLte
 bjGlFU4ObRysOVzJrX50u9CPztJFbolEIhow5Gy1ie6Ex4JGyJQiLdPcMx9QXg3NA6YD
 0fH+kChXqm9IAkQsJ52up9X+NWjTdBzK4UxaccBMy4WEeHpGKt1ruy98/0/Rlm9nIXz7
 k0wFCBKNEytPGdf2nQj4iDWAL512Nak3oV2wJO5eAftdKGGhNAUSLjzcrc41k6XIMw9P
 JA2HDxzRQ79fPzjFVvMs2BT5+Bo+tu0PLY+J1GLNNb0ufIKW4nJi8LZk/LCHnxc7g/Cx
 Sucw==
X-Gm-Message-State: AOJu0YzCuRkooRiLuvj5OVZkUaVjXKPpHVqYfTlhn0oX4dkQVlcTNvKL
 U0ACwvLZMPyWpwX0t2fGTPoCRReur7eZF05rIIcEKjrm4sY4G4kFnXPwYUjiZdIgQknO1O2xVuc
 fp00=
X-Gm-Gg: ATEYQzwbpia4quclvqLOF66gRNAEw8uMDyDQxiiScfjZL8+0gkm7GEdTCxQQ7ai+VNQ
 7WkJg0vWujCQeEqg19m5DB5MV2yRdUuVxdGVNapWQrlR7QL8yPkiZv7vVqX8wOjoKtTgcxNhMbN
 sNJYYfpHpliaYLqEGk7JT49L6zHdUHwB6q50G+y3N2MPUeUUMi7mx6BRjl495rjbFAHfpNs9zWO
 m5ESNHwCX2rzJgKvreXgE+RLfnYMbKG/sJQqxg0pxiNAqGTFT+gUrZShHO/XNArQNvfWfm940II
 pcKqJmSS0U+AMMqQAynIEOgrLSsdE4vnIHNeHNTbb8PGIi4ES29BM1Uk8TCj/vjHvcZVLEXJnuV
 i2vWL77BHk7cp7sBMvbOy8QRsj0NJG5wuSUlMXuoUHUYW9utInNJ3TrS1UttNUUQmtAu/G55Ouc
 VbH6mCi3Nfs86Rw6ZvvQ==
X-Received: by 2002:a05:620a:25c7:b0:8c9:fb65:7f0d with SMTP id
 af79cd13be357-8cd6d40c598mr399089185a.28.1772820829674; 
 Fri, 06 Mar 2026 10:13:49 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f5736c0sm155930885a.49.2026.03.06.10.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 10:13:49 -0800 (PST)
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
Subject: [PATCH v2 09/23] binman: test: Move CBFS test files to test/cbfs/
Date: Fri,  6 Mar 2026 11:12:37 -0700
Message-ID: <20260306181304.2426352-10-sjg@chromium.org>
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

Move about a dozen test files for Coreboot File System entries into a
cbfs/ subdirectory. Drop the numeric prefixes and the redundant cbfs_
filename prefix, and update all references.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v1)

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
index 9ceb85f2b28..d43bb9183bb 100644
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

