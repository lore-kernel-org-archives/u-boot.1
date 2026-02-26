Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AA4FD9E25
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 23:49:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10C8583F37;
	Fri, 27 Feb 2026 00:49:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TkZ9km34";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DABEA83F32; Fri, 27 Feb 2026 00:48:57 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7D2F83F2A
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 00:48:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-896ff127650so22901306d6.3
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 15:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772149731; x=1772754531; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BsxQAZl91RxceYMs0mRreRq4k0ispHkMs3zI2XKY51E=;
 b=TkZ9km34Q2ew+hTcpvpUdd47hWdWYzH0SKOgo6kOX08zD9DMFuCG7LnPTYMqlDr/es
 GySUVE6Oo4UIoKtpX4707PxrFHG2z5cDASSbvu5aKWNwPEUcMJe+oiFOtJ8WGsVjwZgu
 FwT2wUWBVCwSj7NpMrQeLqmRkrYmacEyZZd6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772149731; x=1772754531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BsxQAZl91RxceYMs0mRreRq4k0ispHkMs3zI2XKY51E=;
 b=owTp34CGWLpgC+DsVhClh7qeOWIqVx3+eYPFf4CLPjZni+96CS9EKJDOhPjqSFoTub
 sjiPZH/yTtJPatX4BK3kwnhF39GtMR9bHODsAnVCmDGlOjoopwt9F8logK3/T7EbZUaR
 Y4BZ2sNcUR8jGOYg28NwWqQIJ17MWr+GbiXyHr3WuQzGYkYaAEioaugU7EHfiWCKjqmW
 8flkTrUrwR0suWtjU3SQ77euuJFLwt13bO3cNUT0FELj1Q1QpLvdVmDrUNRcJU7ggJdF
 KunuvIv4EmeFr09AP2RLxqX8544U8KYKZveRy0QdfGi9jW2jQe/2FXTuOJq9zh6bAtzK
 ms2Q==
X-Gm-Message-State: AOJu0YwFRrKDChRaY+mN+aRcLW0NN3Ua14AHzwR9UD/ydhBMEPN9bsvu
 BB6206xfwLa/Ja32yHLsgKg0F872Q+ETDxxQ3/ypun08v0DrOuWcKYJLx2N31vund6kkB3k/txK
 AQA4=
X-Gm-Gg: ATEYQzwf5/wL1LhVGhODz14OeH+6EMJhPCAjXwt3ef1F6/jTLRzhYJb6wXBydHSOA/U
 vIdQiJvqaY9cblS9ZqEKbPIQT9bR42qIr+A6Q/7cbhZ3eNgRdTdpvyJN/pvjVqlteARSITueVC3
 RZ3cZlG9ihblN5lrx0QIEFlJ2p4QyeKdS/VQxmOtJrRxQtDaJmRi7ARYdtPSWTQ+VAM+zrMN0Zh
 woNmOpgyE22WFYTicBICSfWzLWSVCjKr3bTD9oNoqQYajqia2s88UwCSU5Ix5+1MKo/I/eLlB46
 gu4OZYLZf3dkeras26EAUqEqx+9/a471R95642iXFcI/P8RdumAya8zd0Gk+1LCDt1owTLYpHxV
 pf0xBmI4bVmzsrKwBCjA9RYAZDuC2MJNAXw5GHBcwiJjVlH4r+znlt42eFyo6gppGk1RIeP76fD
 Tp4/G7aJMrAJ0k+lAKBw==
X-Received: by 2002:a05:6214:e86:b0:897:2b23:3a7d with SMTP id
 6a1803df08f44-899d1d6c84amr14991796d6.2.1772149731086; 
 Thu, 26 Feb 2026 15:48:51 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf68a0fbsm322024385a.22.2026.02.26.15.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 15:48:50 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Moteen Shah <m-shah@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
Subject: [RFC PATCH 05/16] binman: test: Move FDT/fdtmap test files to
 test/fdt/
Date: Thu, 26 Feb 2026 16:47:45 -0700
Message-ID: <20260226234802.345968-6-sjg@chromium.org>
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

Move about 30 test files for FDT update, fdtmap, DTB compression,
alternates, and bootph into an fdt/ subdirectory. Drop the numeric
prefixes and the redundant fdt_ filename prefix, and update all
references.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 tools/binman/ftest.py                         | 104 +++++++++---------
 .../alternates_fdt.dts}                       |   0
 .../alternates_fdtgrep.dts}                   |   0
 .../alternates_inval.dts}                     |   0
 .../alternates_spl.dts}                       |   0
 .../alternates_vpl.dts}                       |   0
 .../bootph_prop.dts}                          |   0
 .../compress_dtb.dts}                         |   0
 .../compress_dtb_invalid.dts}                 |   0
 .../compress_dtb_prepend_invalid.dts}         |   0
 .../compress_dtb_prepend_length.dts}          |   0
 .../compress_dtb_zstd.dts}                    |   0
 .../decode_image.dts}                         |   0
 .../decode_image_nohdr.dts}                   |   0
 .../test/{115_fdtmap.dts => fdt/fdtmap.dts}   |   0
 .../fdtmap_alt_format.dts}                    |   0
 .../fdtmap_hdr.dts}                           |   0
 .../fdtmap_hdr_endbad.dts}                    |   0
 .../fdtmap_hdr_middle.dts}                    |   0
 .../fdtmap_hdr_missing.dts}                   |   0
 .../fdtmap_hdr_nosize.dts}                    |   0
 .../fdtmap_hdr_pos.dts}                       |   0
 .../fdtmap_hdr_start.dts}                     |   0
 .../fdtmap_hdr_startbad.dts}                  |   0
 .../hdr_no_location.dts}                      |   0
 .../test/{194_fdt_incl.dts => fdt/incl.dts}   |   0
 .../incl_tpl.dts}                             |   0
 .../incl_vpl.dts}                             |   0
 .../list_fdtmap.dts}                          |   0
 .../no_alt_format.dts}                        |   0
 .../{060_fdt_update.dts => fdt/update.dts}    |   0
 .../update_all.dts}                           |   0
 .../update_all_repack.dts}                    |   0
 .../update_bad.dts}                           |   0
 34 files changed, 52 insertions(+), 52 deletions(-)
 rename tools/binman/test/{328_alternates_fdt.dts => fdt/alternates_fdt.dts} (100%)
 rename tools/binman/test/{329_alternates_fdtgrep.dts => fdt/alternates_fdtgrep.dts} (100%)
 rename tools/binman/test/{332_alternates_inval.dts => fdt/alternates_inval.dts} (100%)
 rename tools/binman/test/{331_alternates_spl.dts => fdt/alternates_spl.dts} (100%)
 rename tools/binman/test/{330_alternates_vpl.dts => fdt/alternates_vpl.dts} (100%)
 rename tools/binman/test/{347_bootph_prop.dts => fdt/bootph_prop.dts} (100%)
 rename tools/binman/test/{124_compress_dtb.dts => fdt/compress_dtb.dts} (100%)
 rename tools/binman/test/{250_compress_dtb_invalid.dts => fdt/compress_dtb_invalid.dts} (100%)
 rename tools/binman/test/{248_compress_dtb_prepend_invalid.dts => fdt/compress_dtb_prepend_invalid.dts} (100%)
 rename tools/binman/test/{249_compress_dtb_prepend_length.dts => fdt/compress_dtb_prepend_length.dts} (100%)
 rename tools/binman/test/{251_compress_dtb_zstd.dts => fdt/compress_dtb_zstd.dts} (100%)
 rename tools/binman/test/{128_decode_image.dts => fdt/decode_image.dts} (100%)
 rename tools/binman/test/{129_decode_image_nohdr.dts => fdt/decode_image_nohdr.dts} (100%)
 rename tools/binman/test/{115_fdtmap.dts => fdt/fdtmap.dts} (100%)
 rename tools/binman/test/{213_fdtmap_alt_format.dts => fdt/fdtmap_alt_format.dts} (100%)
 rename tools/binman/test/{116_fdtmap_hdr.dts => fdt/fdtmap_hdr.dts} (100%)
 rename tools/binman/test/{137_fdtmap_hdr_endbad.dts => fdt/fdtmap_hdr_endbad.dts} (100%)
 rename tools/binman/test/{135_fdtmap_hdr_middle.dts => fdt/fdtmap_hdr_middle.dts} (100%)
 rename tools/binman/test/{119_fdtmap_hdr_missing.dts => fdt/fdtmap_hdr_missing.dts} (100%)
 rename tools/binman/test/{138_fdtmap_hdr_nosize.dts => fdt/fdtmap_hdr_nosize.dts} (100%)
 rename tools/binman/test/{118_fdtmap_hdr_pos.dts => fdt/fdtmap_hdr_pos.dts} (100%)
 rename tools/binman/test/{117_fdtmap_hdr_start.dts => fdt/fdtmap_hdr_start.dts} (100%)
 rename tools/binman/test/{136_fdtmap_hdr_startbad.dts => fdt/fdtmap_hdr_startbad.dts} (100%)
 rename tools/binman/test/{120_hdr_no_location.dts => fdt/hdr_no_location.dts} (100%)
 rename tools/binman/test/{194_fdt_incl.dts => fdt/incl.dts} (100%)
 rename tools/binman/test/{195_fdt_incl_tpl.dts => fdt/incl_tpl.dts} (100%)
 rename tools/binman/test/{257_fdt_incl_vpl.dts => fdt/incl_vpl.dts} (100%)
 rename tools/binman/test/{130_list_fdtmap.dts => fdt/list_fdtmap.dts} (100%)
 rename tools/binman/test/{214_no_alt_format.dts => fdt/no_alt_format.dts} (100%)
 rename tools/binman/test/{060_fdt_update.dts => fdt/update.dts} (100%)
 rename tools/binman/test/{082_fdt_update_all.dts => fdt/update_all.dts} (100%)
 rename tools/binman/test/{134_fdt_update_all_repack.dts => fdt/update_all_repack.dts} (100%)
 rename tools/binman/test/{061_fdt_update_bad.dts => fdt/update_bad.dts} (100%)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 11b56277346..14d3538bc9e 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -1677,7 +1677,7 @@ class TestFunctional(unittest.TestCase):
 
     def testUpdateFdt(self):
         """Test that we can update the device tree with offset/size info"""
-        _, _, _, out_dtb_fname = self._DoReadFileDtb('060_fdt_update.dts',
+        _, _, _, out_dtb_fname = self._DoReadFileDtb('fdt/update.dts',
                                                      update_dtb=True)
         dtb = fdt.Fdt(out_dtb_fname)
         dtb.Scan()
@@ -1707,7 +1707,7 @@ class TestFunctional(unittest.TestCase):
     def testUpdateFdtBad(self):
         """Test that we detect when ProcessFdt never completes"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFileDtb('061_fdt_update_bad.dts', update_dtb=True)
+            self._DoReadFileDtb('fdt/update_bad.dts', update_dtb=True)
         self.assertIn('Could not complete processing of Fdt: remaining '
                       '[<binman.etype._testing.Entry__testing',
                         str(e.exception))
@@ -2082,7 +2082,7 @@ class TestFunctional(unittest.TestCase):
         """Test that all device trees are updated with offset/size info"""
         self._SetupSplElf()
         self._SetupTplElf()
-        data = self._DoReadFileRealDtb('082_fdt_update_all.dts')
+        data = self._DoReadFileRealDtb('fdt/update_all.dts')
 
         base_expected = {
             'offset': 0,
@@ -2125,7 +2125,7 @@ class TestFunctional(unittest.TestCase):
     def testUpdateFdtOutput(self):
         """Test that output DTB files are updated"""
         try:
-            data, dtb_data, _, _ = self._DoReadFileDtb('082_fdt_update_all.dts',
+            data, dtb_data, _, _ = self._DoReadFileDtb('fdt/update_all.dts',
                     use_real_dtb=True, update_dtb=True, reset_dtbs=False)
 
             # Unfortunately, compiling a source file always results in a file
@@ -2607,7 +2607,7 @@ class TestFunctional(unittest.TestCase):
 
     def testFdtmap(self):
         """Test an FDT map can be inserted in the image"""
-        data = self.data = self._DoReadFileRealDtb('115_fdtmap.dts')
+        data = self.data = self._DoReadFileRealDtb('fdt/fdtmap.dts')
         fdtmap_data = data[len(U_BOOT_DATA):]
         magic = fdtmap_data[:8]
         self.assertEqual(b'_FDTMAP_', magic)
@@ -2631,7 +2631,7 @@ class TestFunctional(unittest.TestCase):
 
     def testFdtmapNoMatch(self):
         """Check handling of an FDT map when the section cannot be found"""
-        self.data = self._DoReadFileRealDtb('115_fdtmap.dts')
+        self.data = self._DoReadFileRealDtb('fdt/fdtmap.dts')
 
         # Mangle the section name, which should cause a mismatch between the
         # correct FDT path and the one expected by the section
@@ -2646,7 +2646,7 @@ class TestFunctional(unittest.TestCase):
 
     def testFdtmapHeader(self):
         """Test an FDT map and image header can be inserted in the image"""
-        data = self.data = self._DoReadFileRealDtb('116_fdtmap_hdr.dts')
+        data = self.data = self._DoReadFileRealDtb('fdt/fdtmap_hdr.dts')
         fdtmap_pos = len(U_BOOT_DATA)
         fdtmap_data = data[fdtmap_pos:]
         fdt_data = fdtmap_data[16:]
@@ -2659,7 +2659,7 @@ class TestFunctional(unittest.TestCase):
 
     def testFdtmapHeaderStart(self):
         """Test an image header can be inserted at the image start"""
-        data = self.data = self._DoReadFileRealDtb('117_fdtmap_hdr_start.dts')
+        data = self.data = self._DoReadFileRealDtb('fdt/fdtmap_hdr_start.dts')
         fdtmap_pos = 0x100 + len(U_BOOT_DATA)
         hdr_data = data[:8]
         self.assertEqual(b'BinM', hdr_data[:4])
@@ -2668,7 +2668,7 @@ class TestFunctional(unittest.TestCase):
 
     def testFdtmapHeaderPos(self):
         """Test an image header can be inserted at a chosen position"""
-        data = self.data = self._DoReadFileRealDtb('118_fdtmap_hdr_pos.dts')
+        data = self.data = self._DoReadFileRealDtb('fdt/fdtmap_hdr_pos.dts')
         fdtmap_pos = 0x100 + len(U_BOOT_DATA)
         hdr_data = data[0x80:0x88]
         self.assertEqual(b'BinM', hdr_data[:4])
@@ -2678,14 +2678,14 @@ class TestFunctional(unittest.TestCase):
     def testHeaderMissingFdtmap(self):
         """Test an image header requires an fdtmap"""
         with self.assertRaises(ValueError) as e:
-            self.data = self._DoReadFileRealDtb('119_fdtmap_hdr_missing.dts')
+            self.data = self._DoReadFileRealDtb('fdt/fdtmap_hdr_missing.dts')
         self.assertIn("'image_header' section must have an 'fdtmap' sibling",
                       str(e.exception))
 
     def testHeaderNoLocation(self):
         """Test an image header with a no specified location is detected"""
         with self.assertRaises(ValueError) as e:
-            self.data = self._DoReadFileRealDtb('120_hdr_no_location.dts')
+            self.data = self._DoReadFileRealDtb('fdt/hdr_no_location.dts')
         self.assertIn("Invalid location 'None', expected 'start' or 'end'",
                       str(e.exception))
 
@@ -2713,7 +2713,7 @@ class TestFunctional(unittest.TestCase):
     def testCompressDtb(self):
         """Test that compress of device-tree files is supported"""
         self._CheckLz4()
-        data = self.data = self._DoReadFileRealDtb('124_compress_dtb.dts')
+        data = self.data = self._DoReadFileRealDtb('fdt/compress_dtb.dts')
         self.assertEqual(U_BOOT_DATA, data[:len(U_BOOT_DATA)])
         comp_data = data[len(U_BOOT_DATA):]
         orig = self._decompress(comp_data)
@@ -2837,7 +2837,7 @@ class TestFunctional(unittest.TestCase):
     def testFindFdtmap(self):
         """Test locating an FDT map in an image"""
         self._CheckLz4()
-        data = self.data = self._DoReadFileRealDtb('128_decode_image.dts')
+        data = self.data = self._DoReadFileRealDtb('fdt/decode_image.dts')
         image = control.images['image']
         entries = image.GetEntries()
         entry = entries['fdtmap']
@@ -2851,7 +2851,7 @@ class TestFunctional(unittest.TestCase):
     def testFindImageHeader(self):
         """Test locating a image header"""
         self._CheckLz4()
-        data = self.data = self._DoReadFileRealDtb('128_decode_image.dts')
+        data = self.data = self._DoReadFileRealDtb('fdt/decode_image.dts')
         image = control.images['image']
         entries = image.GetEntries()
         entry = entries['fdtmap']
@@ -2860,7 +2860,7 @@ class TestFunctional(unittest.TestCase):
 
     def testFindImageHeaderStart(self):
         """Test locating a image header located at the start of an image"""
-        data = self.data = self._DoReadFileRealDtb('117_fdtmap_hdr_start.dts')
+        data = self.data = self._DoReadFileRealDtb('fdt/fdtmap_hdr_start.dts')
         image = control.images['image']
         entries = image.GetEntries()
         entry = entries['fdtmap']
@@ -2875,7 +2875,7 @@ class TestFunctional(unittest.TestCase):
     def testReadImage(self):
         """Test reading an image and accessing its FDT map"""
         self._CheckLz4()
-        data = self.data = self._DoReadFileRealDtb('128_decode_image.dts')
+        data = self.data = self._DoReadFileRealDtb('fdt/decode_image.dts')
         image_fname = tools.get_output_filename('image.bin')
         orig_image = control.images['image']
         image = Image.FromFile(image_fname)
@@ -2891,7 +2891,7 @@ class TestFunctional(unittest.TestCase):
     def testReadImageNoHeader(self):
         """Test accessing an image's FDT map without an image header"""
         self._CheckLz4()
-        data = self._DoReadFileRealDtb('129_decode_image_nohdr.dts')
+        data = self._DoReadFileRealDtb('fdt/decode_image_nohdr.dts')
         image_fname = tools.get_output_filename('image.bin')
         image = Image.FromFile(image_fname)
         self.assertTrue(isinstance(image, Image))
@@ -2908,7 +2908,7 @@ class TestFunctional(unittest.TestCase):
     def testListCmd(self):
         """Test listing the files in an image using an Fdtmap"""
         self._CheckLz4()
-        data = self._DoReadFileRealDtb('130_list_fdtmap.dts')
+        data = self._DoReadFileRealDtb('fdt/list_fdtmap.dts')
 
         # lz4 compression size differs depending on the version
         image = control.images['image']
@@ -2963,7 +2963,7 @@ class TestFunctional(unittest.TestCase):
             expected: Expected list of filenames to be returned, in order
         """
         self._CheckLz4()
-        self._DoReadFileRealDtb('130_list_fdtmap.dts')
+        self._DoReadFileRealDtb('fdt/list_fdtmap.dts')
         image_fname = tools.get_output_filename('image.bin')
         image = Image.FromFile(image_fname)
         lines = image.GetListEntries(paths)[1]
@@ -3009,7 +3009,7 @@ class TestFunctional(unittest.TestCase):
             data from entry
         """
         self._CheckLz4()
-        self._DoReadFileRealDtb('130_list_fdtmap.dts')
+        self._DoReadFileRealDtb('fdt/list_fdtmap.dts')
         image_fname = tools.get_output_filename('image.bin')
         return control.ReadEntry(image_fname, entry_name, decomp)
 
@@ -3079,7 +3079,7 @@ class TestFunctional(unittest.TestCase):
     def testExtractCmd(self):
         """Test extracting a file fron an image on the command line"""
         self._CheckLz4()
-        self._DoReadFileRealDtb('130_list_fdtmap.dts')
+        self._DoReadFileRealDtb('fdt/list_fdtmap.dts')
         fname = os.path.join(self._indir, 'output.extact')
         tmpdir = None
         try:
@@ -3096,7 +3096,7 @@ class TestFunctional(unittest.TestCase):
     def testExtractOneEntry(self):
         """Test extracting a single entry fron an image """
         self._CheckLz4()
-        self._DoReadFileRealDtb('130_list_fdtmap.dts')
+        self._DoReadFileRealDtb('fdt/list_fdtmap.dts')
         image_fname = tools.get_output_filename('image.bin')
         fname = os.path.join(self._indir, 'output.extact')
         control.ExtractEntries(image_fname, fname, None, ['u-boot'])
@@ -3141,7 +3141,7 @@ class TestFunctional(unittest.TestCase):
             path = os.path.join(outdir, name)
             os.rmdir(path)
 
-        self._DoReadFileRealDtb('130_list_fdtmap.dts')
+        self._DoReadFileRealDtb('fdt/list_fdtmap.dts')
         image_fname = tools.get_output_filename('image.bin')
         outdir = os.path.join(self._indir, 'extract')
         einfos = control.ExtractEntries(image_fname, None, outdir, [], decomp)
@@ -3202,7 +3202,7 @@ class TestFunctional(unittest.TestCase):
     def testExtractSelectedEntries(self):
         """Test extracting some entries"""
         self._CheckLz4()
-        self._DoReadFileRealDtb('130_list_fdtmap.dts')
+        self._DoReadFileRealDtb('fdt/list_fdtmap.dts')
         image_fname = tools.get_output_filename('image.bin')
         outdir = os.path.join(self._indir, 'extract')
         einfos = control.ExtractEntries(image_fname, None, outdir,
@@ -3217,7 +3217,7 @@ class TestFunctional(unittest.TestCase):
     def testExtractNoEntryPaths(self):
         """Test extracting some entries"""
         self._CheckLz4()
-        self._DoReadFileRealDtb('130_list_fdtmap.dts')
+        self._DoReadFileRealDtb('fdt/list_fdtmap.dts')
         image_fname = tools.get_output_filename('image.bin')
         with self.assertRaises(ValueError) as e:
             control.ExtractEntries(image_fname, 'fname', None, [])
@@ -3227,7 +3227,7 @@ class TestFunctional(unittest.TestCase):
     def testExtractTooManyEntryPaths(self):
         """Test extracting some entries"""
         self._CheckLz4()
-        self._DoReadFileRealDtb('130_list_fdtmap.dts')
+        self._DoReadFileRealDtb('fdt/list_fdtmap.dts')
         image_fname = tools.get_output_filename('image.bin')
         with self.assertRaises(ValueError) as e:
             control.ExtractEntries(image_fname, 'fname', None, ['a', 'b'])
@@ -3414,7 +3414,7 @@ class TestFunctional(unittest.TestCase):
         """Test that all device trees are updated with offset/size info"""
         self._SetupSplElf()
         self._SetupTplElf()
-        data = self._DoReadFileRealDtb('134_fdt_update_all_repack.dts')
+        data = self._DoReadFileRealDtb('fdt/update_all_repack.dts')
         SECTION_SIZE = 0x300
         DTB_SIZE = 602
         FDTMAP_SIZE = 608
@@ -3476,27 +3476,27 @@ class TestFunctional(unittest.TestCase):
     def testFdtmapHeaderMiddle(self):
         """Test an FDT map in the middle of an image when it should be at end"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFileRealDtb('135_fdtmap_hdr_middle.dts')
+            self._DoReadFileRealDtb('fdt/fdtmap_hdr_middle.dts')
         self.assertIn("Invalid sibling order 'middle' for image-header: Must be at 'end' to match location",
                       str(e.exception))
 
     def testFdtmapHeaderStartBad(self):
         """Test an FDT map in middle of an image when it should be at start"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFileRealDtb('136_fdtmap_hdr_startbad.dts')
+            self._DoReadFileRealDtb('fdt/fdtmap_hdr_startbad.dts')
         self.assertIn("Invalid sibling order 'end' for image-header: Must be at 'start' to match location",
                       str(e.exception))
 
     def testFdtmapHeaderEndBad(self):
         """Test an FDT map at the start of an image when it should be at end"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFileRealDtb('137_fdtmap_hdr_endbad.dts')
+            self._DoReadFileRealDtb('fdt/fdtmap_hdr_endbad.dts')
         self.assertIn("Invalid sibling order 'start' for image-header: Must be at 'end' to match location",
                       str(e.exception))
 
     def testFdtmapHeaderNoSize(self):
         """Test an image header at the end of an image with undefined size"""
-        self._DoReadFileRealDtb('138_fdtmap_hdr_nosize.dts')
+        self._DoReadFileRealDtb('fdt/fdtmap_hdr_nosize.dts')
 
     def testReplaceResize(self):
         """Test replacing a single file in an entry with a larger file"""
@@ -4867,7 +4867,7 @@ class TestFunctional(unittest.TestCase):
             'spl-bss-pad': 'y',
             'tpl-dtb': '',
         }
-        self._DoReadFileDtb('194_fdt_incl.dts', use_expanded=True,
+        self._DoReadFileDtb('fdt/incl.dts', use_expanded=True,
                             entry_args=entry_args)
         image = control.images['image']
         entries = image.GetEntries()
@@ -4907,7 +4907,7 @@ class TestFunctional(unittest.TestCase):
             'tpl-bss-pad': 'y',
             'tpl-dtb': 'y',
         }
-        self._DoReadFileDtb('195_fdt_incl_tpl.dts', use_expanded=True,
+        self._DoReadFileDtb('fdt/incl_tpl.dts', use_expanded=True,
                             entry_args=entry_args)
         image = control.images['image']
         entries = image.GetEntries()
@@ -4934,7 +4934,7 @@ class TestFunctional(unittest.TestCase):
             'spl-bss-pad': 'n',
             'tpl-dtb': '',
         }
-        self._DoReadFileDtb('194_fdt_incl.dts', use_expanded=True,
+        self._DoReadFileDtb('fdt/incl.dts', use_expanded=True,
                             entry_args=entry_args)
         image = control.images['image']
         entries = image.GetEntries()
@@ -4956,7 +4956,7 @@ class TestFunctional(unittest.TestCase):
             'tpl-bss-pad': '',
             'tpl-dtb': 'y',
         }
-        self._DoReadFileDtb('195_fdt_incl_tpl.dts', use_expanded=True,
+        self._DoReadFileDtb('fdt/incl_tpl.dts', use_expanded=True,
                             entry_args=entry_args)
         image = control.images['image']
         entries = image.GetEntries()
@@ -4986,7 +4986,7 @@ class TestFunctional(unittest.TestCase):
         # Build the image. It includes two separate devicetree binaries, each
         # with their own contents, but all contain the binman definition.
         data = self._DoReadFileDtb(
-            '194_fdt_incl.dts', use_real_dtb=True, use_expanded=True,
+            'fdt/incl.dts', use_real_dtb=True, use_expanded=True,
             update_dtb=True, entry_args=entry_args)[0]
         pad_len = 10
 
@@ -5081,7 +5081,7 @@ class TestFunctional(unittest.TestCase):
         begin_sym = 'dtb_embed_begin'
         end_sym = 'dtb_embed_end'
         retcode = self._DoTestFile(
-            '060_fdt_update.dts', update_dtb=True,
+            'fdt/update.dts', update_dtb=True,
             update_fdt_in_elf=','.join([infile,outfile,begin_sym,end_sym]))
         self.assertEqual(0, retcode)
 
@@ -5121,7 +5121,7 @@ class TestFunctional(unittest.TestCase):
     def testUpdateFdtInElfInvalid(self):
         """Test that invalid args are detected with --update-fdt-in-elf"""
         with self.assertRaises(ValueError) as e:
-            self._DoTestFile('060_fdt_update.dts', update_fdt_in_elf='fred')
+            self._DoTestFile('fdt/update.dts', update_fdt_in_elf='fred')
         self.assertIn("Invalid args ['fred'] to --update-fdt-in-elf",
                       str(e.exception))
 
@@ -5135,7 +5135,7 @@ class TestFunctional(unittest.TestCase):
         end_sym = 'wrong_end'
         with self.assertRaises(ValueError) as e:
             self._DoTestFile(
-                '060_fdt_update.dts',
+                'fdt/update.dts',
                 update_fdt_in_elf=','.join([infile,outfile,begin_sym,end_sym]))
         self.assertIn("Expected two symbols 'wrong_begin' and 'wrong_end': got 0:",
                       str(e.exception))
@@ -5150,7 +5150,7 @@ class TestFunctional(unittest.TestCase):
         end_sym = 'dtb_embed_end'
         with self.assertRaises(ValueError) as e:
             self._DoTestFile(
-                '060_fdt_update.dts', update_dtb=True,
+                'fdt/update.dts', update_dtb=True,
                 update_fdt_in_elf=','.join([infile,outfile,begin_sym,end_sym]))
         self.assertRegex(
             str(e.exception),
@@ -5178,7 +5178,7 @@ class TestFunctional(unittest.TestCase):
 
     def testAltFormat(self):
         """Test that alternative formats can be used to extract"""
-        self._DoReadFileRealDtb('213_fdtmap_alt_format.dts')
+        self._DoReadFileRealDtb('fdt/fdtmap_alt_format.dts')
 
         try:
             tmpdir, updated_fname = self._SetupImageInTmpdir()
@@ -6188,13 +6188,13 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testCompressDtbPrependInvalid(self):
         """Test that invalid header is detected"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFileDtb('248_compress_dtb_prepend_invalid.dts')
+            self._DoReadFileDtb('fdt/compress_dtb_prepend_invalid.dts')
         self.assertIn("Node '/binman/u-boot-dtb': Invalid prepend in "
                       "'u-boot-dtb': 'invalid'", str(e.exception))
 
     def testCompressDtbPrependLength(self):
         """Test that compress with length header works as expected"""
-        data = self._DoReadFileRealDtb('249_compress_dtb_prepend_length.dts')
+        data = self._DoReadFileRealDtb('fdt/compress_dtb_prepend_length.dts')
         image = control.images['image']
         entries = image.GetEntries()
         self.assertIn('u-boot-dtb', entries)
@@ -6227,7 +6227,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testInvalidCompress(self):
         """Test that invalid compress algorithm is detected"""
         with self.assertRaises(ValueError) as e:
-            self._DoTestFile('250_compress_dtb_invalid.dts')
+            self._DoTestFile('fdt/compress_dtb_invalid.dts')
         self.assertIn("Unknown algorithm 'invalid'", str(e.exception))
 
     def testCompUtilCompressions(self):
@@ -6261,7 +6261,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testCompressDtbZstd(self):
         """Test that zstd compress of device-tree files failed"""
         with self.assertRaises(ValueError) as e:
-            self._DoTestFile('251_compress_dtb_zstd.dts')
+            self._DoTestFile('fdt/compress_dtb_zstd.dts')
         self.assertIn("Node '/binman/u-boot-dtb': The zstd compression "
                       "requires a length header", str(e.exception))
 
@@ -6354,7 +6354,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             'vpl-bss-pad': 'y',
             'vpl-dtb': 'y',
         }
-        self._DoReadFileDtb('257_fdt_incl_vpl.dts', use_expanded=True,
+        self._DoReadFileDtb('fdt/incl_vpl.dts', use_expanded=True,
                             entry_args=entry_args)
         image = control.images['image']
         entries = image.GetEntries()
@@ -7724,7 +7724,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testAlternatesFdt(self):
         """Test handling of alternates-fdt etype"""
         self._SetupTplElf()
-        dtbs = self.CheckAlternates('328_alternates_fdt.dts', 'tpl',
+        dtbs = self.CheckAlternates('fdt/alternates_fdt.dts', 'tpl',
                                     U_BOOT_TPL_NODTB_DATA)
         for dtb in dtbs.values():
             # Check for the node with the tag
@@ -7738,7 +7738,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testAlternatesFdtgrep(self):
         """Test handling of alternates-fdt etype using fdtgrep"""
         self._SetupTplElf()
-        dtbs = self.CheckAlternates('329_alternates_fdtgrep.dts', 'tpl',
+        dtbs = self.CheckAlternates('fdt/alternates_fdtgrep.dts', 'tpl',
                                     U_BOOT_TPL_NODTB_DATA)
         for dtb in dtbs.values():
             # Check for the node with the tag
@@ -7753,20 +7753,20 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testAlternatesFdtgrepVpl(self):
         """Test handling of alternates-fdt etype using fdtgrep with vpl"""
         self._SetupVplElf()
-        dtbs = self.CheckAlternates('330_alternates_vpl.dts', 'vpl',
+        dtbs = self.CheckAlternates('fdt/alternates_vpl.dts', 'vpl',
                                     U_BOOT_VPL_NODTB_DATA)
 
     def testAlternatesFdtgrepSpl(self):
         """Test handling of alternates-fdt etype using fdtgrep with spl"""
         self._SetupSplElf()
-        dtbs = self.CheckAlternates('331_alternates_spl.dts', 'spl',
+        dtbs = self.CheckAlternates('fdt/alternates_spl.dts', 'spl',
                                     U_BOOT_SPL_NODTB_DATA)
 
     def testAlternatesFdtgrepInval(self):
         """Test alternates-fdt etype using fdtgrep with invalid phase"""
         self._SetupSplElf()
         with self.assertRaises(ValueError) as e:
-            dtbs = self.CheckAlternates('332_alternates_inval.dts', 'spl',
+            dtbs = self.CheckAlternates('fdt/alternates_inval.dts', 'spl',
                                         U_BOOT_SPL_NODTB_DATA)
         self.assertIn("Invalid U-Boot phase 'bad-phase': Use tpl/vpl/spl",
                       str(e.exception))
@@ -8423,7 +8423,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testBootphPropagation(self):
         """Test that bootph-* properties are propagated correctly to supernodes"""
         _, _, _, out_dtb_fname = self._DoReadFileDtb(
-                '347_bootph_prop.dts', use_real_dtb=True, update_dtb=True)
+                'fdt/bootph_prop.dts', use_real_dtb=True, update_dtb=True)
         dtb = fdt.Fdt(out_dtb_fname)
         dtb.Scan()
         root = dtb.GetRoot()
diff --git a/tools/binman/test/328_alternates_fdt.dts b/tools/binman/test/fdt/alternates_fdt.dts
similarity index 100%
rename from tools/binman/test/328_alternates_fdt.dts
rename to tools/binman/test/fdt/alternates_fdt.dts
diff --git a/tools/binman/test/329_alternates_fdtgrep.dts b/tools/binman/test/fdt/alternates_fdtgrep.dts
similarity index 100%
rename from tools/binman/test/329_alternates_fdtgrep.dts
rename to tools/binman/test/fdt/alternates_fdtgrep.dts
diff --git a/tools/binman/test/332_alternates_inval.dts b/tools/binman/test/fdt/alternates_inval.dts
similarity index 100%
rename from tools/binman/test/332_alternates_inval.dts
rename to tools/binman/test/fdt/alternates_inval.dts
diff --git a/tools/binman/test/331_alternates_spl.dts b/tools/binman/test/fdt/alternates_spl.dts
similarity index 100%
rename from tools/binman/test/331_alternates_spl.dts
rename to tools/binman/test/fdt/alternates_spl.dts
diff --git a/tools/binman/test/330_alternates_vpl.dts b/tools/binman/test/fdt/alternates_vpl.dts
similarity index 100%
rename from tools/binman/test/330_alternates_vpl.dts
rename to tools/binman/test/fdt/alternates_vpl.dts
diff --git a/tools/binman/test/347_bootph_prop.dts b/tools/binman/test/fdt/bootph_prop.dts
similarity index 100%
rename from tools/binman/test/347_bootph_prop.dts
rename to tools/binman/test/fdt/bootph_prop.dts
diff --git a/tools/binman/test/124_compress_dtb.dts b/tools/binman/test/fdt/compress_dtb.dts
similarity index 100%
rename from tools/binman/test/124_compress_dtb.dts
rename to tools/binman/test/fdt/compress_dtb.dts
diff --git a/tools/binman/test/250_compress_dtb_invalid.dts b/tools/binman/test/fdt/compress_dtb_invalid.dts
similarity index 100%
rename from tools/binman/test/250_compress_dtb_invalid.dts
rename to tools/binman/test/fdt/compress_dtb_invalid.dts
diff --git a/tools/binman/test/248_compress_dtb_prepend_invalid.dts b/tools/binman/test/fdt/compress_dtb_prepend_invalid.dts
similarity index 100%
rename from tools/binman/test/248_compress_dtb_prepend_invalid.dts
rename to tools/binman/test/fdt/compress_dtb_prepend_invalid.dts
diff --git a/tools/binman/test/249_compress_dtb_prepend_length.dts b/tools/binman/test/fdt/compress_dtb_prepend_length.dts
similarity index 100%
rename from tools/binman/test/249_compress_dtb_prepend_length.dts
rename to tools/binman/test/fdt/compress_dtb_prepend_length.dts
diff --git a/tools/binman/test/251_compress_dtb_zstd.dts b/tools/binman/test/fdt/compress_dtb_zstd.dts
similarity index 100%
rename from tools/binman/test/251_compress_dtb_zstd.dts
rename to tools/binman/test/fdt/compress_dtb_zstd.dts
diff --git a/tools/binman/test/128_decode_image.dts b/tools/binman/test/fdt/decode_image.dts
similarity index 100%
rename from tools/binman/test/128_decode_image.dts
rename to tools/binman/test/fdt/decode_image.dts
diff --git a/tools/binman/test/129_decode_image_nohdr.dts b/tools/binman/test/fdt/decode_image_nohdr.dts
similarity index 100%
rename from tools/binman/test/129_decode_image_nohdr.dts
rename to tools/binman/test/fdt/decode_image_nohdr.dts
diff --git a/tools/binman/test/115_fdtmap.dts b/tools/binman/test/fdt/fdtmap.dts
similarity index 100%
rename from tools/binman/test/115_fdtmap.dts
rename to tools/binman/test/fdt/fdtmap.dts
diff --git a/tools/binman/test/213_fdtmap_alt_format.dts b/tools/binman/test/fdt/fdtmap_alt_format.dts
similarity index 100%
rename from tools/binman/test/213_fdtmap_alt_format.dts
rename to tools/binman/test/fdt/fdtmap_alt_format.dts
diff --git a/tools/binman/test/116_fdtmap_hdr.dts b/tools/binman/test/fdt/fdtmap_hdr.dts
similarity index 100%
rename from tools/binman/test/116_fdtmap_hdr.dts
rename to tools/binman/test/fdt/fdtmap_hdr.dts
diff --git a/tools/binman/test/137_fdtmap_hdr_endbad.dts b/tools/binman/test/fdt/fdtmap_hdr_endbad.dts
similarity index 100%
rename from tools/binman/test/137_fdtmap_hdr_endbad.dts
rename to tools/binman/test/fdt/fdtmap_hdr_endbad.dts
diff --git a/tools/binman/test/135_fdtmap_hdr_middle.dts b/tools/binman/test/fdt/fdtmap_hdr_middle.dts
similarity index 100%
rename from tools/binman/test/135_fdtmap_hdr_middle.dts
rename to tools/binman/test/fdt/fdtmap_hdr_middle.dts
diff --git a/tools/binman/test/119_fdtmap_hdr_missing.dts b/tools/binman/test/fdt/fdtmap_hdr_missing.dts
similarity index 100%
rename from tools/binman/test/119_fdtmap_hdr_missing.dts
rename to tools/binman/test/fdt/fdtmap_hdr_missing.dts
diff --git a/tools/binman/test/138_fdtmap_hdr_nosize.dts b/tools/binman/test/fdt/fdtmap_hdr_nosize.dts
similarity index 100%
rename from tools/binman/test/138_fdtmap_hdr_nosize.dts
rename to tools/binman/test/fdt/fdtmap_hdr_nosize.dts
diff --git a/tools/binman/test/118_fdtmap_hdr_pos.dts b/tools/binman/test/fdt/fdtmap_hdr_pos.dts
similarity index 100%
rename from tools/binman/test/118_fdtmap_hdr_pos.dts
rename to tools/binman/test/fdt/fdtmap_hdr_pos.dts
diff --git a/tools/binman/test/117_fdtmap_hdr_start.dts b/tools/binman/test/fdt/fdtmap_hdr_start.dts
similarity index 100%
rename from tools/binman/test/117_fdtmap_hdr_start.dts
rename to tools/binman/test/fdt/fdtmap_hdr_start.dts
diff --git a/tools/binman/test/136_fdtmap_hdr_startbad.dts b/tools/binman/test/fdt/fdtmap_hdr_startbad.dts
similarity index 100%
rename from tools/binman/test/136_fdtmap_hdr_startbad.dts
rename to tools/binman/test/fdt/fdtmap_hdr_startbad.dts
diff --git a/tools/binman/test/120_hdr_no_location.dts b/tools/binman/test/fdt/hdr_no_location.dts
similarity index 100%
rename from tools/binman/test/120_hdr_no_location.dts
rename to tools/binman/test/fdt/hdr_no_location.dts
diff --git a/tools/binman/test/194_fdt_incl.dts b/tools/binman/test/fdt/incl.dts
similarity index 100%
rename from tools/binman/test/194_fdt_incl.dts
rename to tools/binman/test/fdt/incl.dts
diff --git a/tools/binman/test/195_fdt_incl_tpl.dts b/tools/binman/test/fdt/incl_tpl.dts
similarity index 100%
rename from tools/binman/test/195_fdt_incl_tpl.dts
rename to tools/binman/test/fdt/incl_tpl.dts
diff --git a/tools/binman/test/257_fdt_incl_vpl.dts b/tools/binman/test/fdt/incl_vpl.dts
similarity index 100%
rename from tools/binman/test/257_fdt_incl_vpl.dts
rename to tools/binman/test/fdt/incl_vpl.dts
diff --git a/tools/binman/test/130_list_fdtmap.dts b/tools/binman/test/fdt/list_fdtmap.dts
similarity index 100%
rename from tools/binman/test/130_list_fdtmap.dts
rename to tools/binman/test/fdt/list_fdtmap.dts
diff --git a/tools/binman/test/214_no_alt_format.dts b/tools/binman/test/fdt/no_alt_format.dts
similarity index 100%
rename from tools/binman/test/214_no_alt_format.dts
rename to tools/binman/test/fdt/no_alt_format.dts
diff --git a/tools/binman/test/060_fdt_update.dts b/tools/binman/test/fdt/update.dts
similarity index 100%
rename from tools/binman/test/060_fdt_update.dts
rename to tools/binman/test/fdt/update.dts
diff --git a/tools/binman/test/082_fdt_update_all.dts b/tools/binman/test/fdt/update_all.dts
similarity index 100%
rename from tools/binman/test/082_fdt_update_all.dts
rename to tools/binman/test/fdt/update_all.dts
diff --git a/tools/binman/test/134_fdt_update_all_repack.dts b/tools/binman/test/fdt/update_all_repack.dts
similarity index 100%
rename from tools/binman/test/134_fdt_update_all_repack.dts
rename to tools/binman/test/fdt/update_all_repack.dts
diff --git a/tools/binman/test/061_fdt_update_bad.dts b/tools/binman/test/fdt/update_bad.dts
similarity index 100%
rename from tools/binman/test/061_fdt_update_bad.dts
rename to tools/binman/test/fdt/update_bad.dts
-- 
2.43.0

