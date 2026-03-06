Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585D5FCC04D
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 18:14:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F96C83F9D;
	Fri,  6 Mar 2026 19:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CuSDW0lD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CFB883FC6; Fri,  6 Mar 2026 19:13:45 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 277DE83F9D
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 19:13:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-8cb38e6d164so1226648085a.3
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 10:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772820820; x=1773425620; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0B7if9uoqyKIQ7eqU5oR60QKcASlp3iVsaioBM3x8uY=;
 b=CuSDW0lDbsk6bjohunV32b9013bCgS0n8zW9r12JVR4AK1jTCtJKY56bp5N7MxgN5+
 5rUfEf6gcMtJnLk4SKnMLCEYSVbGVvLBkhwx5njglDYcXy6IXiOFz6jfqATNM2xOMkwB
 lkmdx0ZVFTVIvGHTwJBYD6DxzDBNMhJfaluMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772820820; x=1773425620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0B7if9uoqyKIQ7eqU5oR60QKcASlp3iVsaioBM3x8uY=;
 b=LE2l0cUt3REF0VtBb2JLOz1Vul+ZuEFvdj+EKZxd2T0orfJTiIKESe2WPnfZZvnPT2
 tdl45DY5EqwdaKY6Sjl9dG0vvjJBtiHesgybUEkdN5rStOy7dcnKs67E+6TOvnAfc9oe
 FqOjfpFxnahllERUFpmKt3PndVCToPIxbMcGPDvRu9lg1lOUKsLFJb1sgac1Zy7xfZeG
 5zZPVzHwX2CL/fOq7Uh6bIjq4jfibtzj/KiG9IK3g0hQeZhtFesZnijRIDPfbOpIwAqa
 Rs5lL0RjqgDwfSagWqvZ/ODNZ4UX9iHwbTzkqpKObbxkKujRj0S/4wwlGnh61BYEJ0tJ
 pweA==
X-Gm-Message-State: AOJu0YylDnOebAx06E5a/s8xOUjR0Aq/THM5kGKF3PVYAfvYkJZ9Ja1u
 PPk0qjJObDvidj+Ka6MwIeCYa3FzbLV1as+E2KwF5T8IVdVsKFcoS8ng3i5GNPE9cNEZXCmXDcm
 7sok=
X-Gm-Gg: ATEYQzx2NrBl2B24I6o3qXu/q5s4g9oucLpJP+r+W7uq/Fa3fPjuj1H5lGRzbP6FcCz
 7drU65iK7gWKEjc2sntNAaYsjh2kwgUuMwBiETLQm1AwTcLgQf6LXLvLfyDP+2fDFq+gGSYnGav
 XpPwY6tKwlRxT91SQ2F3XQ9nVxSXIZqJ/JXE02J78dZlvlCR3OCudincGd/Ei5D0AFRsm05btBy
 VBzs+HXpP7GqegJ/OvnFIjcy4M0g3ux6dNlW7FwKFIbIkwYARQhPDtZnTrwNtV3n7qW0KlPRjUU
 K49wo6pt6LMrS5pJWx7RM+Fwi1TIXaTqmTP9+LwjzlJGSSVvdYFjR9p3+1Pf4ARLyS2ovQrhdcK
 gqjM8D9DUVG2xucY/r822cuuA6O/uDRau7PRc85bKx54K977VuhKIcEixAsTpXeOkJNvR63iH+I
 ouuXaJpG0UBcMMINkdnQ==
X-Received: by 2002:a05:620a:1920:b0:8ca:55:ac72 with SMTP id
 af79cd13be357-8cd6d506075mr389335085a.61.1772820820042; 
 Fri, 06 Mar 2026 10:13:40 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f5736c0sm155930885a.49.2026.03.06.10.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 10:13:39 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v2 05/23] binman: test: Move FIT image test files to test/fit/
Date: Fri,  6 Mar 2026 11:12:33 -0700
Message-ID: <20260306181304.2426352-6-sjg@chromium.org>
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

Move about 40 test files for FIT images (signing, external data,
split-elf, encryption, alignment, firmware loadables, templates) into
a fit/ subdirectory. Drop the numeric prefixes and the redundant fit_
filename prefix, and update all references.

Rename the three signature.dts variants to have unique names:
signature.dts, signature_multi_key.dts and signature_no_nodes.dts.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

(no changes since v1)

 tools/binman/ftest.py                         | 118 +++++++++---------
 .../test/{275_fit_align.dts => fit/align.dts} |   0
 .../{227_fit_bad_dir.dts => fit/bad_dir.dts}  |   2 +-
 .../bad_dir_config.dts}                       |   2 +-
 .../bad_oper.dts}                             |   0
 .../encrypt_data.dts}                         |   0
 .../encrypt_data_no_key.dts}                  |   0
 .../external.dts}                             |   0
 .../extract_replace.dts}                      |   0
 .../test/{170_fit_fdt.dts => fit/fdt.dts}     |   0
 .../fdt_compat.dts}                           |   0
 .../{333_fit_fdt_dir.dts => fit/fdt_dir.dts}  |   0
 .../fdt_list.dts}                             |   0
 .../fdt_missing_prop.dts}                     |   0
 .../fdt_name.dts}                             |   0
 .../fdt_oper.dts}                             |   0
 .../fdt_phase.dts}                            |   0
 .../firmware_loadables.dts}                   |   0
 .../binman/test/{161_fit.dts => fit/fit.dts}  |   0
 .../{219_fit_gennode.dts => fit/gennode.dts}  |   0
 .../image_subentry_alignment.dts}             |   0
 .../key_name_hint_dir_signature.dts}          |   0
 .../missing_blob.dts}                         |   0
 .../replace_sibling.dts}                      |   0
 .../test/{280_fit_sign.dts => fit/sign.dts}   |   0
 .../signature.dts}                            |   0
 .../signature_engine.dts}                     |   0
 .../signature_engine_encrypt.dts}             |   0
 .../signature_engine_pkcs11.dts}              |   0
 .../signature_engine_pkcs11_object.dts}       |   0
 .../signature_multi_key.dts}                  |   0
 .../signature_no_nodes.dts}                   |   0
 .../split_elf.dts}                            |   0
 .../subentry_bintool.dts}                     |   0
 .../subentry_hash.dts}                        |   0
 .../tee_os_opt.dts}                           |   0
 .../tee_os_opt_bad.dts}                       |   0
 .../template.dts}                             |   0
 38 files changed, 61 insertions(+), 61 deletions(-)
 rename tools/binman/test/{275_fit_align.dts => fit/align.dts} (100%)
 rename tools/binman/test/{227_fit_bad_dir.dts => fit/bad_dir.dts} (71%)
 rename tools/binman/test/{228_fit_bad_dir_config.dts => fit/bad_dir_config.dts} (71%)
 rename tools/binman/test/{224_fit_bad_oper.dts => fit/bad_oper.dts} (100%)
 rename tools/binman/test/{343_fit_encrypt_data.dts => fit/encrypt_data.dts} (100%)
 rename tools/binman/test/{344_fit_encrypt_data_no_key.dts => fit/encrypt_data_no_key.dts} (100%)
 rename tools/binman/test/{162_fit_external.dts => fit/external.dts} (100%)
 rename tools/binman/test/{240_fit_extract_replace.dts => fit/extract_replace.dts} (100%)
 rename tools/binman/test/{170_fit_fdt.dts => fit/fdt.dts} (100%)
 rename tools/binman/test/{334_fit_fdt_compat.dts => fit/fdt_compat.dts} (100%)
 rename tools/binman/test/{333_fit_fdt_dir.dts => fit/fdt_dir.dts} (100%)
 rename tools/binman/test/{284_fit_fdt_list.dts => fit/fdt_list.dts} (100%)
 rename tools/binman/test/{171_fit_fdt_missing_prop.dts => fit/fdt_missing_prop.dts} (100%)
 rename tools/binman/test/{345_fit_fdt_name.dts => fit/fdt_name.dts} (100%)
 rename tools/binman/test/{223_fit_fdt_oper.dts => fit/fdt_oper.dts} (100%)
 rename tools/binman/test/{335_fit_fdt_phase.dts => fit/fdt_phase.dts} (100%)
 rename tools/binman/test/{276_fit_firmware_loadables.dts => fit/firmware_loadables.dts} (100%)
 rename tools/binman/test/{161_fit.dts => fit/fit.dts} (100%)
 rename tools/binman/test/{219_fit_gennode.dts => fit/gennode.dts} (100%)
 rename tools/binman/test/{167_fit_image_subentry_alignment.dts => fit/image_subentry_alignment.dts} (100%)
 rename tools/binman/test/{347_key_name_hint_dir_fit_signature.dts => fit/key_name_hint_dir_signature.dts} (100%)
 rename tools/binman/test/{168_fit_missing_blob.dts => fit/missing_blob.dts} (100%)
 rename tools/binman/test/{277_replace_fit_sibling.dts => fit/replace_sibling.dts} (100%)
 rename tools/binman/test/{280_fit_sign.dts => fit/sign.dts} (100%)
 rename tools/binman/test/{340_fit_signature.dts => fit/signature.dts} (100%)
 rename tools/binman/test/{340_fit_signature_engine.dts => fit/signature_engine.dts} (100%)
 rename tools/binman/test/{340_fit_signature_engine_encrypt.dts => fit/signature_engine_encrypt.dts} (100%)
 rename tools/binman/test/{340_fit_signature_engine_pkcs11.dts => fit/signature_engine_pkcs11.dts} (100%)
 rename tools/binman/test/{340_fit_signature_engine_pkcs11_object.dts => fit/signature_engine_pkcs11_object.dts} (100%)
 rename tools/binman/test/{341_fit_signature.dts => fit/signature_multi_key.dts} (100%)
 rename tools/binman/test/{342_fit_signature.dts => fit/signature_no_nodes.dts} (100%)
 rename tools/binman/test/{226_fit_split_elf.dts => fit/split_elf.dts} (100%)
 rename tools/binman/test/{220_fit_subentry_bintool.dts => fit/subentry_bintool.dts} (100%)
 rename tools/binman/test/{221_fit_subentry_hash.dts => fit/subentry_hash.dts} (100%)
 rename tools/binman/test/{264_tee_os_opt_fit.dts => fit/tee_os_opt.dts} (100%)
 rename tools/binman/test/{265_tee_os_opt_fit_bad.dts => fit/tee_os_opt_bad.dts} (100%)
 rename tools/binman/test/{288_template_fit.dts => fit/template.dts} (100%)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index ac944f507f9..893cf1c7c17 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -3991,7 +3991,7 @@ class TestFunctional(unittest.TestCase):
     def testSimpleFit(self):
         """Test an image with a FIT inside"""
         self._SetupSplElf()
-        data = self._DoReadFile('161_fit.dts')
+        data = self._DoReadFile('fit/fit.dts')
         self.assertEqual(U_BOOT_DATA, data[:len(U_BOOT_DATA)])
         self.assertEqual(U_BOOT_NODTB_DATA, data[-len(U_BOOT_NODTB_DATA):])
         fit_data = data[len(U_BOOT_DATA):-len(U_BOOT_NODTB_DATA)]
@@ -4000,7 +4000,7 @@ class TestFunctional(unittest.TestCase):
 
     def testSimpleFitExpandsSubentries(self):
         """Test that FIT images expand their subentries"""
-        data = self._DoReadFileDtb('161_fit.dts', use_expanded=True)[0]
+        data = self._DoReadFileDtb('fit/fit.dts', use_expanded=True)[0]
         self.assertEqual(U_BOOT_EXP_DATA, data[:len(U_BOOT_EXP_DATA)])
         self.assertEqual(U_BOOT_NODTB_DATA, data[-len(U_BOOT_NODTB_DATA):])
         fit_data = data[len(U_BOOT_EXP_DATA):-len(U_BOOT_NODTB_DATA)]
@@ -4009,7 +4009,7 @@ class TestFunctional(unittest.TestCase):
 
     def testSimpleFitImagePos(self):
         """Test that we have correct image-pos for FIT subentries"""
-        data, _, _, out_dtb_fname = self._DoReadFileDtb('161_fit.dts',
+        data, _, _, out_dtb_fname = self._DoReadFileDtb('fit/fit.dts',
                                                         update_dtb=True)
         dtb = fdt.Fdt(out_dtb_fname)
         dtb.Scan()
@@ -4066,7 +4066,7 @@ class TestFunctional(unittest.TestCase):
 
     def testFitExternal(self):
         """Test an image with an FIT with external images"""
-        data = self._DoReadFile('162_fit_external.dts')
+        data = self._DoReadFile('fit/external.dts')
         fit_data = data[len(U_BOOT_DATA):-2]  # _testing is 2 bytes
 
         # Size of the external-data region as set up by mkimage
@@ -4094,7 +4094,7 @@ class TestFunctional(unittest.TestCase):
 
     def testFitExternalImagePos(self):
         """Test that we have correct image-pos for external FIT subentries"""
-        data, _, _, out_dtb_fname = self._DoReadFileDtb('162_fit_external.dts',
+        data, _, _, out_dtb_fname = self._DoReadFileDtb('fit/external.dts',
                                                         update_dtb=True)
         dtb = fdt.Fdt(out_dtb_fname)
         dtb.Scan()
@@ -4151,7 +4151,7 @@ class TestFunctional(unittest.TestCase):
     def testFitMissing(self):
         """Test that binman complains if mkimage is missing"""
         with self.assertRaises(ValueError) as e:
-            self._DoTestFile('162_fit_external.dts',
+            self._DoTestFile('fit/external.dts',
                              force_missing_bintools='mkimage')
         self.assertIn("Node '/binman/fit': Missing tool: 'mkimage'",
                       str(e.exception))
@@ -4159,7 +4159,7 @@ class TestFunctional(unittest.TestCase):
     def testFitMissingOK(self):
         """Test that binman still produces a FIT image if mkimage is missing"""
         with terminal.capture() as (_, stderr):
-            self._DoTestFile('162_fit_external.dts', allow_missing=True,
+            self._DoTestFile('fit/external.dts', allow_missing=True,
                              force_missing_bintools='mkimage')
         err = stderr.getvalue()
         self.assertRegex(err, "Image 'image'.*missing bintools.*: mkimage")
@@ -4211,7 +4211,7 @@ class TestFunctional(unittest.TestCase):
         entry_args = {
             'test-id': TEXT_DATA,
         }
-        data, _, _, _ = self._DoReadFileDtb('167_fit_image_subentry_alignment.dts',
+        data, _, _, _ = self._DoReadFileDtb('fit/image_subentry_alignment.dts',
                                             entry_args=entry_args)
         dtb = fdt.Fdt.FromData(data)
         dtb.Scan()
@@ -4233,7 +4233,7 @@ class TestFunctional(unittest.TestCase):
     def testFitExtblobMissingOk(self):
         """Test a FIT with a missing external blob that is allowed"""
         with terminal.capture() as (stdout, stderr):
-            self._DoTestFile('168_fit_missing_blob.dts',
+            self._DoTestFile('fit/missing_blob.dts',
                              allow_missing=True)
         err = stderr.getvalue()
         self.assertRegex(err, "Image 'image'.*missing.*: atf-bl31")
@@ -4255,7 +4255,7 @@ class TestFunctional(unittest.TestCase):
         data = self._DoReadFile('172_scp.dts')
         self.assertEqual(SCP_DATA, data[:len(SCP_DATA)])
 
-    def CheckFitFdt(self, dts='170_fit_fdt.dts', use_fdt_list=True,
+    def CheckFitFdt(self, dts='fit/fdt.dts', use_fdt_list=True,
                     default_dt=None, use_seq_num=True):
         """Check an image with an FIT with multiple FDT images"""
         def _CheckFdt(val, expected_data):
@@ -4351,7 +4351,7 @@ class TestFunctional(unittest.TestCase):
     def testFitFdtMissingList(self):
         """Test handling of a missing 'of-list' entry arg"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('170_fit_fdt.dts')
+            self._DoReadFile('fit/fdt.dts')
         self.assertIn("Generator node requires 'of-list' entry argument",
                       str(e.exception))
 
@@ -4360,12 +4360,12 @@ class TestFunctional(unittest.TestCase):
         entry_args = {
             'of-list': '',
         }
-        data = self._DoReadFileDtb('170_fit_fdt.dts', entry_args=entry_args)[0]
+        data = self._DoReadFileDtb('fit/fdt.dts', entry_args=entry_args)[0]
 
     def testFitFdtMissingProp(self):
         """Test handling of a missing 'fit,fdt-list' property"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('171_fit_fdt_missing_prop.dts')
+            self._DoReadFile('fit/fdt_missing_prop.dts')
         self.assertIn("Generator node requires 'fit,fdt-list' property",
                       str(e.exception))
 
@@ -4376,7 +4376,7 @@ class TestFunctional(unittest.TestCase):
         }
         with self.assertRaises(ValueError) as e:
             self._DoReadFileDtb(
-                '170_fit_fdt.dts',
+                'fit/fdt.dts',
                 entry_args=entry_args,
                 extra_indirs=[os.path.join(self._indir, TEST_FDT_SUBDIR)])[0]
         self.assertIn("Generated 'default' node requires default-dt entry argument",
@@ -4390,7 +4390,7 @@ class TestFunctional(unittest.TestCase):
         }
         with self.assertRaises(ValueError) as e:
             self._DoReadFileDtb(
-                '170_fit_fdt.dts',
+                'fit/fdt.dts',
                 entry_args=entry_args,
                 extra_indirs=[os.path.join(self._indir, TEST_FDT_SUBDIR)])[0]
         self.assertIn("default-dt entry argument 'test-fdt3' not found in fdt list: test-fdt1, test-fdt2",
@@ -4402,7 +4402,7 @@ class TestFunctional(unittest.TestCase):
         control.missing_blob_help['wibble'] = 'Wibble test'
         control.missing_blob_help['another'] = 'Another test'
         with terminal.capture() as (stdout, stderr):
-            self._DoTestFile('168_fit_missing_blob.dts',
+            self._DoTestFile('fit/missing_blob.dts',
                              allow_missing=True)
         err = stderr.getvalue()
 
@@ -5507,7 +5507,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             'of-list': 'test-fdt1 test-fdt2',
         }
         data = self._DoReadFileDtb(
-            '219_fit_gennode.dts',
+            'fit/gennode.dts',
             entry_args=entry_args,
             use_real_dtb=True,
             extra_indirs=[os.path.join(self._indir, TEST_FDT_SUBDIR)])
@@ -5528,7 +5528,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             'keydir': 'devkeys',
             'bmpblk': 'bmpblk.bin',
         }
-        data, _, _, _ = self._DoReadFileDtb('220_fit_subentry_bintool.dts',
+        data, _, _, _ = self._DoReadFileDtb('fit/subentry_bintool.dts',
                 entry_args=entry_args)
 
         expected = (GBB_DATA + GBB_DATA + tools.get_bytes(0, 8) +
@@ -5541,7 +5541,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             'keydir': 'devkeys',
         }
         with terminal.capture() as (_, stderr):
-            self._DoTestFile('220_fit_subentry_bintool.dts',
+            self._DoTestFile('fit/subentry_bintool.dts',
                     force_missing_bintools='futility', entry_args=entry_args)
         err = stderr.getvalue()
         self.assertRegex(err, "Image 'image'.*missing bintools.*: futility")
@@ -5550,7 +5550,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test an image with a FIT inside"""
         self._SetupSplElf()
         data, _, _, out_dtb_name = self._DoReadFileDtb(
-            '221_fit_subentry_hash.dts', use_real_dtb=True, update_dtb=True)
+            'fit/subentry_hash.dts', use_real_dtb=True, update_dtb=True)
 
         mkimage_dtb = fdt.Fdt.FromData(data)
         mkimage_dtb.Scan()
@@ -5604,14 +5604,14 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             'default-dt': 'test-fdt2',
         }
         self._DoReadFileDtb(
-            '223_fit_fdt_oper.dts',
+            'fit/fdt_oper.dts',
             entry_args=entry_args,
             extra_indirs=[os.path.join(self._indir, TEST_FDT_SUBDIR)])[0]
 
     def testFitFdtBadOper(self):
         """Check handling of an FDT map when the section cannot be found"""
         with self.assertRaises(ValueError) as exc:
-            self._DoReadFileDtb('224_fit_bad_oper.dts')
+            self._DoReadFileDtb('fit/bad_oper.dts')
         self.assertIn("Node '/binman/fit': subnode 'images/@fdt-SEQ': Unknown operation 'unknown'",
                       str(exc.exception))
 
@@ -5635,7 +5635,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         }
         test_subdir = os.path.join(self._indir, TEST_FDT_SUBDIR)
         data = self._DoReadFileDtb(
-            '226_fit_split_elf.dts',
+            'fit/split_elf.dts',
             entry_args=entry_args,
             extra_indirs=[test_subdir])[0]
 
@@ -5728,7 +5728,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         test_subdir = os.path.join(self._indir, TEST_FDT_SUBDIR)
         with self.assertRaises(ValueError) as exc:
             self._DoReadFileDtb(
-                '226_fit_split_elf.dts',
+                'fit/split_elf.dts',
                 entry_args=entry_args,
                 extra_indirs=[test_subdir])[0]
         self.assertIn(
@@ -5755,7 +5755,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         test_subdir = os.path.join(self._indir, TEST_FDT_SUBDIR)
         with terminal.capture() as (stdout, stderr):
             self._DoTestFile(
-                '226_fit_split_elf.dts', entry_args=entry_args,
+                'fit/split_elf.dts', entry_args=entry_args,
                 extra_indirs=[test_subdir], verbosity=3, **kwargs)
             out = stdout.getvalue()
             err = stderr.getvalue()
@@ -5765,7 +5765,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test a FIT split-elf invalid fit,xxx directive in an image node"""
         if not elf.ELF_TOOLS:
             self.skipTest('Python elftools not available')
-        err = self._check_bad_fit('227_fit_bad_dir.dts')
+        err = self._check_bad_fit('fit/bad_dir.dts')
         self.assertIn(
             "Node '/binman/fit': subnode 'images/@atf-SEQ': Unknown directive 'fit,something'",
             err)
@@ -5774,7 +5774,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test a FIT split-elf with invalid fit,xxx directive in config"""
         if not elf.ELF_TOOLS:
             self.skipTest('Python elftools not available')
-        err = self._check_bad_fit('228_fit_bad_dir_config.dts')
+        err = self._check_bad_fit('fit/bad_dir_config.dts')
         self.assertEqual(
             "Node '/binman/fit': subnode 'configurations/@config-SEQ': Unknown directive 'fit,config'",
             err)
@@ -5986,7 +5986,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testExtractFit(self):
         """Test extracting a FIT section"""
-        self._DoReadFileRealDtb('240_fit_extract_replace.dts')
+        self._DoReadFileRealDtb('fit/extract_replace.dts')
         image_fname = tools.get_output_filename('image.bin')
 
         fit_data = control.ReadEntry(image_fname, 'fit')
@@ -6005,7 +6005,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testExtractFitSubentries(self):
         """Test extracting FIT section subentries"""
-        self._DoReadFileRealDtb('240_fit_extract_replace.dts')
+        self._DoReadFileRealDtb('fit/extract_replace.dts')
         image_fname = tools.get_output_filename('image.bin')
 
         for entry_path, expected in [
@@ -6024,7 +6024,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         new_data = b'x' * len(U_BOOT_DATA)
         data, expected_fdtmap, _ = self._RunReplaceCmd(
             'fit/kernel/u-boot', new_data,
-            dts='240_fit_extract_replace.dts')
+            dts='fit/extract_replace.dts')
         self.assertEqual(new_data, data)
 
         path, fdtmap = state.GetFdtContents('fdtmap')
@@ -6036,7 +6036,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         new_data = b'ub' * len(U_BOOT_NODTB_DATA)
         data, expected_fdtmap, _ = self._RunReplaceCmd(
             'fit/fdt-1/u-boot-nodtb', new_data,
-            dts='240_fit_extract_replace.dts')
+            dts='fit/extract_replace.dts')
         self.assertEqual(new_data, data)
 
         # Will be repacked, so fdtmap must change
@@ -6050,7 +6050,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         expected = new_data.ljust(len(U_BOOT_NODTB_DATA), b'\0')
         data, expected_fdtmap, _ = self._RunReplaceCmd(
             'fit/fdt-1/u-boot-nodtb', new_data,
-            dts='240_fit_extract_replace.dts')
+            dts='fit/extract_replace.dts')
         self.assertEqual(expected, data)
 
         path, fdtmap = state.GetFdtContents('fdtmap')
@@ -6510,7 +6510,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testFitTeeOsOptionalFit(self):
         """Test an image with a FIT with an optional OP-TEE binary"""
-        data = self.checkFitTee('264_tee_os_opt_fit.dts', 'tee.bin')
+        data = self.checkFitTee('fit/tee_os_opt.dts', 'tee.bin')
 
         # There should be only one node, holding the data set up in SetUpClass()
         # for tee.bin
@@ -6524,7 +6524,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertEqual(U_BOOT_DATA, node.props['data'].bytes)
 
         with terminal.capture() as (stdout, stderr):
-            self.checkFitTee('264_tee_os_opt_fit.dts', '')
+            self.checkFitTee('fit/tee_os_opt.dts', '')
         err = stderr.getvalue()
         self.assertRegex(
             err,
@@ -6536,7 +6536,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testFitTeeOsOptionalFitBad(self):
         """Test an image with a FIT with an optional OP-TEE binary"""
         with self.assertRaises(ValueError) as exc:
-            self.checkFitTee('265_tee_os_opt_fit_bad.dts', 'tee.bin')
+            self.checkFitTee('fit/tee_os_opt_bad.dts', 'tee.bin')
         self.assertIn(
             "Node '/binman/fit': subnode 'images/@tee-SEQ': Failed to read ELF file: Magic number does not match",
             str(exc.exception))
@@ -6545,14 +6545,14 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test an OP-TEE binary with wrong formats"""
         self.make_tee_bin('tee.bad1', 123)
         with self.assertRaises(ValueError) as exc:
-            self.checkFitTee('264_tee_os_opt_fit.dts', 'tee.bad1')
+            self.checkFitTee('fit/tee_os_opt.dts', 'tee.bad1')
         self.assertIn(
             "Node '/binman/fit/images/@tee-SEQ/tee-os': OP-TEE paged mode not supported",
             str(exc.exception))
 
         self.make_tee_bin('tee.bad2', 0, b'extra data')
         with self.assertRaises(ValueError) as exc:
-            self.checkFitTee('264_tee_os_opt_fit.dts', 'tee.bad2')
+            self.checkFitTee('fit/tee_os_opt.dts', 'tee.bad2')
         self.assertIn(
             "Node '/binman/fit/images/@tee-SEQ/tee-os': Invalid OP-TEE file: size mismatch (expected 0x4, have 0xe)",
             str(exc.exception))
@@ -6701,7 +6701,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testFitAlign(self):
         """Test an image with an FIT with aligned external data"""
-        data = self._DoReadFile('275_fit_align.dts')
+        data = self._DoReadFile('fit/align.dts')
         self.assertEqual(4096, len(data))
 
         dtb = fdt.Fdt.FromData(data)
@@ -6728,7 +6728,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         test_subdir = os.path.join(self._indir, TEST_FDT_SUBDIR)
         with terminal.capture() as (stdout, stderr):
             data = self._DoReadFileDtb(
-                '276_fit_firmware_loadables.dts',
+                'fit/firmware_loadables.dts',
                 entry_args=entry_args,
                 extra_indirs=[test_subdir])[0]
 
@@ -6838,7 +6838,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test an image with a FIT inside where we replace its sibling"""
         self._SetupSplElf()
         fname = TestFunctional._MakeInputFile('once', b'available once')
-        self._DoReadFileRealDtb('277_replace_fit_sibling.dts')
+        self._DoReadFileRealDtb('fit/replace_sibling.dts')
         os.remove(fname)
 
         try:
@@ -6899,7 +6899,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             self._DoTestFile('292_mkimage_missing_multiple.dts', allow_missing=False)
         self.assertIn("not found in input path", str(e.exception))
 
-    def _PrepareSignEnv(self, dts='280_fit_sign.dts'):
+    def _PrepareSignEnv(self, dts='fit/sign.dts'):
         """Prepare sign environment
 
         Create private and public keys, add pubkey into dtb.
@@ -7013,7 +7013,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             'default-dt': 'test-fdt2',
         }
         data = self._DoReadFileDtb(
-            '284_fit_fdt_list.dts',
+            'fit/fdt_list.dts',
             entry_args=entry_args,
             extra_indirs=[os.path.join(self._indir, TEST_FDT_SUBDIR)])[0]
         self.assertEqual(U_BOOT_NODTB_DATA, data[-len(U_BOOT_NODTB_DATA):])
@@ -7069,7 +7069,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testTemplateFit(self):
         """Test using a template in a FIT"""
-        fit_data = self._DoReadFile('288_template_fit.dts')
+        fit_data = self._DoReadFile('fit/template.dts')
         fname = os.path.join(self._indir, 'fit_data.fit')
         tools.write_file(fname, fit_data)
         out = tools.run('dumpimage', '-l', fname)
@@ -7776,7 +7776,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         old_dir = os.getcwd()
         try:
             os.chdir(self._indir)
-            self.CheckFitFdt('333_fit_fdt_dir.dts', False)
+            self.CheckFitFdt('fit/fdt_dir.dts', False)
         finally:
             os.chdir(old_dir)
 
@@ -7785,7 +7785,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         old_dir = os.getcwd()
         try:
             os.chdir(self._indir)
-            self.CheckFitFdt('333_fit_fdt_dir.dts', False,
+            self.CheckFitFdt('fit/fdt_dir.dts', False,
                              default_dt='rockchip/test-fdt2')
         finally:
             os.chdir(old_dir)
@@ -7798,7 +7798,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             }
         testdir, dtb_list = self.SetupAlternateDts()
         data = self._DoReadFileDtb(
-            '334_fit_fdt_compat.dts', use_real_dtb=True, update_dtb=True,
+            'fit/fdt_compat.dts', use_real_dtb=True, update_dtb=True,
             entry_args=entry_args, extra_indirs=[testdir])[0]
 
         fit_data = data[len(U_BOOT_DATA):-len(U_BOOT_NODTB_DATA)]
@@ -7831,7 +7831,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             }
         testdir, dtb_list = self.SetupAlternateDts()
         data = self._DoReadFileDtb(
-            '335_fit_fdt_phase.dts', use_real_dtb=True, update_dtb=True,
+            'fit/fdt_phase.dts', use_real_dtb=True, update_dtb=True,
             entry_args=entry_args, extra_indirs=[testdir])[0]
         fit_data = data[len(U_BOOT_DATA):-len(U_BOOT_NODTB_DATA)]
         fit = fdt.Fdt.FromData(fit_data)
@@ -7933,7 +7933,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         test_subdir = os.path.join(self._indir, TEST_FDT_SUBDIR)
         keys_subdir = os.path.join(self._indir, "keys")
         data = self._DoReadFileDtb(
-            '340_fit_signature.dts',
+            'fit/signature.dts',
             entry_args=entry_args,
             extra_indirs=[test_subdir, keys_subdir])[0]
 
@@ -7974,7 +7974,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         with unittest.mock.patch.dict('os.environ',
                                       {'OPENSSL_ENGINES': ossl_engines_path}):
             data = self._DoReadFileDtb(
-                '340_fit_signature_engine.dts',
+                'fit/signature_engine.dts',
                 entry_args=entry_args,
                 extra_indirs=[test_subdir])[0]
 
@@ -8015,7 +8015,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
         with self.assertRaises(ValueError) as e:
             self._DoReadFileDtb(
-                    '340_fit_signature_engine_encrypt.dts',
+                    'fit/signature_engine_encrypt.dts',
                     entry_args=entry_args,
                     extra_indirs=[test_subdir])
 
@@ -8075,7 +8075,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
                                       {'OPENSSL_CONF': ossl_conf,
                                        'SOFTHSM2_CONF': softhsm2_conf}):
             data = self._DoReadFileDtb(
-                '340_fit_signature_engine_pkcs11.dts',
+                'fit/signature_engine_pkcs11.dts',
                 entry_args=entry_args,
                 extra_indirs=[test_subdir])[0]
 
@@ -8153,7 +8153,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
                                        'SOFTHSM2_CONF': softhsm2_conf,
                                        'MKIMAGE_SIGN_PIN': '1234'}):
             data = self._DoReadFileDtb(
-                '340_fit_signature_engine_pkcs11_object.dts',
+                'fit/signature_engine_pkcs11_object.dts',
                 entry_args=entry_args,
                 extra_indirs=[test_subdir])[0]
 
@@ -8188,7 +8188,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         test_subdir = os.path.join(self._indir, TEST_FDT_SUBDIR)
         with self.assertRaises(ValueError) as e:
             self._DoReadFileDtb(
-                '340_fit_signature.dts',
+                'fit/signature.dts',
                 entry_args=entry_args,
                 extra_indirs=[test_subdir])[0]
         self.assertIn(
@@ -8214,7 +8214,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         keys_subdir2 = os.path.join(self._indir, "keys2")
         with self.assertRaises(ValueError) as e:
             self._DoReadFileDtb(
-                '341_fit_signature.dts',
+                'fit/signature_multi_key.dts',
                 entry_args=entry_args,
                 extra_indirs=[test_subdir, keys_subdir1, keys_subdir2])[0]
         self.assertIn(
@@ -8232,7 +8232,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         }
         test_subdir = os.path.join(self._indir, TEST_FDT_SUBDIR)
         self._DoReadFileDtb(
-            '342_fit_signature.dts',
+            'fit/signature_no_nodes.dts',
             entry_args=entry_args,
             extra_indirs=[test_subdir])[0]
 
@@ -8248,7 +8248,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         test_subdir = os.path.join(self._indir, TEST_FDT_SUBDIR)
         with self.assertRaises(ValueError) as e:
             self._DoReadFileDtb(
-                    '347_key_name_hint_dir_fit_signature.dts',
+                    'fit/key_name_hint_dir_signature.dts',
                     entry_args=entry_args,
                     extra_indirs=[test_subdir])
         self.assertIn(
@@ -8262,7 +8262,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
         keys_subdir = os.path.join(self._indir, "keys")
         data = self._DoReadFileDtb(
-            '343_fit_encrypt_data.dts',
+            'fit/encrypt_data.dts',
             extra_indirs=[keys_subdir])[0]
 
         fit = fdt.Fdt.FromData(data)
@@ -8296,13 +8296,13 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testSimpleFitEncryptedDataMissingKey(self):
         """Test an image with a FIT containing data to be encrypted but with a missing key"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('344_fit_encrypt_data_no_key.dts')
+            self._DoReadFile('fit/encrypt_data_no_key.dts')
 
         self.assertIn("Filename 'aes256.bin' not found in input path", str(e.exception))
 
     def testFitFdtName(self):
         """Test an image with an FIT with multiple FDT images using NAME"""
-        self.CheckFitFdt('345_fit_fdt_name.dts', use_seq_num=False)
+        self.CheckFitFdt('fit/fdt_name.dts', use_seq_num=False)
 
     def testRemoveTemplate(self):
         """Test whether template is removed"""
diff --git a/tools/binman/test/275_fit_align.dts b/tools/binman/test/fit/align.dts
similarity index 100%
rename from tools/binman/test/275_fit_align.dts
rename to tools/binman/test/fit/align.dts
diff --git a/tools/binman/test/227_fit_bad_dir.dts b/tools/binman/test/fit/bad_dir.dts
similarity index 71%
rename from tools/binman/test/227_fit_bad_dir.dts
rename to tools/binman/test/fit/bad_dir.dts
index 51f4816c4c2..c6d5c7b0a87 100644
--- a/tools/binman/test/227_fit_bad_dir.dts
+++ b/tools/binman/test/fit/bad_dir.dts
@@ -2,7 +2,7 @@
 
 /dts-v1/;
 
-#include "226_fit_split_elf.dts"
+#include "split_elf.dts"
 
 &atf {
 	fit,something = "bad";
diff --git a/tools/binman/test/228_fit_bad_dir_config.dts b/tools/binman/test/fit/bad_dir_config.dts
similarity index 71%
rename from tools/binman/test/228_fit_bad_dir_config.dts
rename to tools/binman/test/fit/bad_dir_config.dts
index 825a346c3e6..bae805a9523 100644
--- a/tools/binman/test/228_fit_bad_dir_config.dts
+++ b/tools/binman/test/fit/bad_dir_config.dts
@@ -2,7 +2,7 @@
 
 /dts-v1/;
 
-#include "226_fit_split_elf.dts"
+#include "split_elf.dts"
 
 &config {
 	fit,config = "bad";
diff --git a/tools/binman/test/224_fit_bad_oper.dts b/tools/binman/test/fit/bad_oper.dts
similarity index 100%
rename from tools/binman/test/224_fit_bad_oper.dts
rename to tools/binman/test/fit/bad_oper.dts
diff --git a/tools/binman/test/343_fit_encrypt_data.dts b/tools/binman/test/fit/encrypt_data.dts
similarity index 100%
rename from tools/binman/test/343_fit_encrypt_data.dts
rename to tools/binman/test/fit/encrypt_data.dts
diff --git a/tools/binman/test/344_fit_encrypt_data_no_key.dts b/tools/binman/test/fit/encrypt_data_no_key.dts
similarity index 100%
rename from tools/binman/test/344_fit_encrypt_data_no_key.dts
rename to tools/binman/test/fit/encrypt_data_no_key.dts
diff --git a/tools/binman/test/162_fit_external.dts b/tools/binman/test/fit/external.dts
similarity index 100%
rename from tools/binman/test/162_fit_external.dts
rename to tools/binman/test/fit/external.dts
diff --git a/tools/binman/test/240_fit_extract_replace.dts b/tools/binman/test/fit/extract_replace.dts
similarity index 100%
rename from tools/binman/test/240_fit_extract_replace.dts
rename to tools/binman/test/fit/extract_replace.dts
diff --git a/tools/binman/test/170_fit_fdt.dts b/tools/binman/test/fit/fdt.dts
similarity index 100%
rename from tools/binman/test/170_fit_fdt.dts
rename to tools/binman/test/fit/fdt.dts
diff --git a/tools/binman/test/334_fit_fdt_compat.dts b/tools/binman/test/fit/fdt_compat.dts
similarity index 100%
rename from tools/binman/test/334_fit_fdt_compat.dts
rename to tools/binman/test/fit/fdt_compat.dts
diff --git a/tools/binman/test/333_fit_fdt_dir.dts b/tools/binman/test/fit/fdt_dir.dts
similarity index 100%
rename from tools/binman/test/333_fit_fdt_dir.dts
rename to tools/binman/test/fit/fdt_dir.dts
diff --git a/tools/binman/test/284_fit_fdt_list.dts b/tools/binman/test/fit/fdt_list.dts
similarity index 100%
rename from tools/binman/test/284_fit_fdt_list.dts
rename to tools/binman/test/fit/fdt_list.dts
diff --git a/tools/binman/test/171_fit_fdt_missing_prop.dts b/tools/binman/test/fit/fdt_missing_prop.dts
similarity index 100%
rename from tools/binman/test/171_fit_fdt_missing_prop.dts
rename to tools/binman/test/fit/fdt_missing_prop.dts
diff --git a/tools/binman/test/345_fit_fdt_name.dts b/tools/binman/test/fit/fdt_name.dts
similarity index 100%
rename from tools/binman/test/345_fit_fdt_name.dts
rename to tools/binman/test/fit/fdt_name.dts
diff --git a/tools/binman/test/223_fit_fdt_oper.dts b/tools/binman/test/fit/fdt_oper.dts
similarity index 100%
rename from tools/binman/test/223_fit_fdt_oper.dts
rename to tools/binman/test/fit/fdt_oper.dts
diff --git a/tools/binman/test/335_fit_fdt_phase.dts b/tools/binman/test/fit/fdt_phase.dts
similarity index 100%
rename from tools/binman/test/335_fit_fdt_phase.dts
rename to tools/binman/test/fit/fdt_phase.dts
diff --git a/tools/binman/test/276_fit_firmware_loadables.dts b/tools/binman/test/fit/firmware_loadables.dts
similarity index 100%
rename from tools/binman/test/276_fit_firmware_loadables.dts
rename to tools/binman/test/fit/firmware_loadables.dts
diff --git a/tools/binman/test/161_fit.dts b/tools/binman/test/fit/fit.dts
similarity index 100%
rename from tools/binman/test/161_fit.dts
rename to tools/binman/test/fit/fit.dts
diff --git a/tools/binman/test/219_fit_gennode.dts b/tools/binman/test/fit/gennode.dts
similarity index 100%
rename from tools/binman/test/219_fit_gennode.dts
rename to tools/binman/test/fit/gennode.dts
diff --git a/tools/binman/test/167_fit_image_subentry_alignment.dts b/tools/binman/test/fit/image_subentry_alignment.dts
similarity index 100%
rename from tools/binman/test/167_fit_image_subentry_alignment.dts
rename to tools/binman/test/fit/image_subentry_alignment.dts
diff --git a/tools/binman/test/347_key_name_hint_dir_fit_signature.dts b/tools/binman/test/fit/key_name_hint_dir_signature.dts
similarity index 100%
rename from tools/binman/test/347_key_name_hint_dir_fit_signature.dts
rename to tools/binman/test/fit/key_name_hint_dir_signature.dts
diff --git a/tools/binman/test/168_fit_missing_blob.dts b/tools/binman/test/fit/missing_blob.dts
similarity index 100%
rename from tools/binman/test/168_fit_missing_blob.dts
rename to tools/binman/test/fit/missing_blob.dts
diff --git a/tools/binman/test/277_replace_fit_sibling.dts b/tools/binman/test/fit/replace_sibling.dts
similarity index 100%
rename from tools/binman/test/277_replace_fit_sibling.dts
rename to tools/binman/test/fit/replace_sibling.dts
diff --git a/tools/binman/test/280_fit_sign.dts b/tools/binman/test/fit/sign.dts
similarity index 100%
rename from tools/binman/test/280_fit_sign.dts
rename to tools/binman/test/fit/sign.dts
diff --git a/tools/binman/test/340_fit_signature.dts b/tools/binman/test/fit/signature.dts
similarity index 100%
rename from tools/binman/test/340_fit_signature.dts
rename to tools/binman/test/fit/signature.dts
diff --git a/tools/binman/test/340_fit_signature_engine.dts b/tools/binman/test/fit/signature_engine.dts
similarity index 100%
rename from tools/binman/test/340_fit_signature_engine.dts
rename to tools/binman/test/fit/signature_engine.dts
diff --git a/tools/binman/test/340_fit_signature_engine_encrypt.dts b/tools/binman/test/fit/signature_engine_encrypt.dts
similarity index 100%
rename from tools/binman/test/340_fit_signature_engine_encrypt.dts
rename to tools/binman/test/fit/signature_engine_encrypt.dts
diff --git a/tools/binman/test/340_fit_signature_engine_pkcs11.dts b/tools/binman/test/fit/signature_engine_pkcs11.dts
similarity index 100%
rename from tools/binman/test/340_fit_signature_engine_pkcs11.dts
rename to tools/binman/test/fit/signature_engine_pkcs11.dts
diff --git a/tools/binman/test/340_fit_signature_engine_pkcs11_object.dts b/tools/binman/test/fit/signature_engine_pkcs11_object.dts
similarity index 100%
rename from tools/binman/test/340_fit_signature_engine_pkcs11_object.dts
rename to tools/binman/test/fit/signature_engine_pkcs11_object.dts
diff --git a/tools/binman/test/341_fit_signature.dts b/tools/binman/test/fit/signature_multi_key.dts
similarity index 100%
rename from tools/binman/test/341_fit_signature.dts
rename to tools/binman/test/fit/signature_multi_key.dts
diff --git a/tools/binman/test/342_fit_signature.dts b/tools/binman/test/fit/signature_no_nodes.dts
similarity index 100%
rename from tools/binman/test/342_fit_signature.dts
rename to tools/binman/test/fit/signature_no_nodes.dts
diff --git a/tools/binman/test/226_fit_split_elf.dts b/tools/binman/test/fit/split_elf.dts
similarity index 100%
rename from tools/binman/test/226_fit_split_elf.dts
rename to tools/binman/test/fit/split_elf.dts
diff --git a/tools/binman/test/220_fit_subentry_bintool.dts b/tools/binman/test/fit/subentry_bintool.dts
similarity index 100%
rename from tools/binman/test/220_fit_subentry_bintool.dts
rename to tools/binman/test/fit/subentry_bintool.dts
diff --git a/tools/binman/test/221_fit_subentry_hash.dts b/tools/binman/test/fit/subentry_hash.dts
similarity index 100%
rename from tools/binman/test/221_fit_subentry_hash.dts
rename to tools/binman/test/fit/subentry_hash.dts
diff --git a/tools/binman/test/264_tee_os_opt_fit.dts b/tools/binman/test/fit/tee_os_opt.dts
similarity index 100%
rename from tools/binman/test/264_tee_os_opt_fit.dts
rename to tools/binman/test/fit/tee_os_opt.dts
diff --git a/tools/binman/test/265_tee_os_opt_fit_bad.dts b/tools/binman/test/fit/tee_os_opt_bad.dts
similarity index 100%
rename from tools/binman/test/265_tee_os_opt_fit_bad.dts
rename to tools/binman/test/fit/tee_os_opt_bad.dts
diff --git a/tools/binman/test/288_template_fit.dts b/tools/binman/test/fit/template.dts
similarity index 100%
rename from tools/binman/test/288_template_fit.dts
rename to tools/binman/test/fit/template.dts
-- 
2.43.0

