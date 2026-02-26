Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CCDFD9E25
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 23:49:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C6F483F6D;
	Fri, 27 Feb 2026 00:49:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GSpGrgeQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 018CB83F36; Fri, 27 Feb 2026 00:49:01 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8BFE83F5D
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 00:48:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-8c70ab3b5fcso195314185a.2
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 15:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772149735; x=1772754535; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3QV4sXVY1m6ACB4NO+Sjhwwe825KglLACis87hpomFI=;
 b=GSpGrgeQYUJ76qF6vu8Cu4ZfoceUx3k54oMI0JVeLC/hr2YCumjYgCd7Lv2NJbr13k
 vVy9BdsJLRGsJpwSrPDLgLTyt3rBC+kErYBAtYgkeTWPKOuYGaKMyHhso2snU3ItkAUl
 mzQ8c1fnAUkG5XS2SYpnrAXvDY7j8aZJTAJng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772149735; x=1772754535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3QV4sXVY1m6ACB4NO+Sjhwwe825KglLACis87hpomFI=;
 b=AZ6kJMsFbw801CCpUy2kASJ5brq8/8PHCSNudncx97vqGiZmhRjGGRA4jVR/RCx7Dg
 kSHgrPHr8JGHNZgTtDFoRBD/XIjTmMYaaR7YCB6FAqK01xIEsxY4erxBp5c1nSrvUG3h
 rX5Un70noL6gmoH/i75/bPymFk/q5N/l4iW69zvlHwvAcWnJ4VfeFuBrau9MqNQNTH3F
 +YVssYFVtoi5+C8oGrjg/KsZ3n3o6n2t7DxYD4eGs5GYYBVsEly2uJyB/5KWiJoN0WcY
 AQi4/mYcGca8pyrPCD9JQjAkAExM/AwCS5c+TKcKe61EYE7tEear22akX772erp28xpW
 xh6A==
X-Gm-Message-State: AOJu0Yz3gvstoSTfK7KEQcThug0msfYSABokjn54cHRm+LkFJOpxfR9F
 Dq2UZYjlYvvcmURzTAn9HGCiA50mDMO6BmguSEOBcwWsRppnQC8CTbriDkpbs/BDQae8KvMXdMe
 2Tw4=
X-Gm-Gg: ATEYQzxCJ3v+CEiB+OkihDzj1TtryDCipKFABBNB/7MpzmlrdFlLZh0Pm6mN54UAky0
 YgWf+nUm9ihzLUa/7+YV/bXvqz7VgRtygE9vc4j8aiBbfkeaHMndhYHom8Hmm485GAmdtFSBAZA
 xs2+ZV2LPR7mGCXqk3TkHf0Lf5xMQeXb4YIpl/SyoM/kDelXE/cNEPuZDLyqBLjET6uDwEvgmBU
 ICqh8A4QgpVhfn30fwSoKfLXFaAuONnk+6ooKkoSozGftArs2MP3MBAypMKzOK+bLADU2ErPWS6
 HlAX2Vvv0LTBBIZqZ6Te75N8ZlYN6NuMDMzTJ+BS7d1ILNiErLfyUAaDNGGmOKEfgDOH9tAs7xq
 DL80bydtKuns0J71bgnxOMwv35CU5ca3SyV81URGA5nQhDh83fiPquXhwAlIEXUNIuUvDPhNx9g
 SwuhCegXxTST0MHoy8HQ==
X-Received: by 2002:a05:620a:7108:b0:89f:8bb8:c103 with SMTP id
 af79cd13be357-8cbc8df0b7fmr118228485a.49.1772149735251; 
 Thu, 26 Feb 2026 15:48:55 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf68a0fbsm322024385a.22.2026.02.26.15.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 15:48:54 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Michal Simek <michal.simek@amd.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
Subject: [RFC PATCH 07/16] binman: test: Move security test files to
 test/security/
Date: Thu, 26 Feb 2026 16:47:47 -0700
Message-ID: <20260226234802.345968-8-sjg@chromium.org>
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

Move about 20 test files for signing, encryption, hash, pre-load,
x509, and Xilinx bootgen entries into a security/ subdirectory. Drop
the numeric prefixes and update all references.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 tools/binman/ftest.py                         | 52 +++++++++----------
 .../encrypted_invalid_iv_file.dts}            |  0
 .../encrypted_key_file.dts}                   |  0
 .../encrypted_key_source.dts}                 |  0
 .../encrypted_missing_key.dts}                |  0
 .../encrypted_no_algo.dts}                    |  0
 .../test/{090_hash.dts => security/hash.dts}  |  0
 .../hash_bad_algo.dts}                        |  0
 .../hash_no_algo.dts}                         |  0
 .../hash_section.dts}                         |  0
 .../key_name_hint_dir_spl_pubkey_dtb.dts}     |  0
 .../pre_load.dts}                             |  0
 .../pre_load_invalid_algo.dts}                |  0
 .../pre_load_invalid_key.dts}                 |  0
 .../pre_load_invalid_padding.dts}             |  0
 .../pre_load_invalid_sha.dts}                 |  0
 .../pre_load_pkcs.dts}                        |  0
 .../pre_load_pss.dts}                         |  0
 .../section_ignore_hash_signature.dts}        |  0
 .../sign_non_fit.dts}                         |  0
 .../spl_pubkey_dtb.dts}                       |  0
 .../x509_cert.dts}                            |  0
 .../xilinx_bootgen_sign.dts}                  |  0
 .../xilinx_bootgen_sign_enc.dts}              |  0
 24 files changed, 26 insertions(+), 26 deletions(-)
 rename tools/binman/test/{302_encrypted_invalid_iv_file.dts => security/encrypted_invalid_iv_file.dts} (100%)
 rename tools/binman/test/{305_encrypted_key_file.dts => security/encrypted_key_file.dts} (100%)
 rename tools/binman/test/{304_encrypted_key_source.dts => security/encrypted_key_source.dts} (100%)
 rename tools/binman/test/{303_encrypted_missing_key.dts => security/encrypted_missing_key.dts} (100%)
 rename tools/binman/test/{301_encrypted_no_algo.dts => security/encrypted_no_algo.dts} (100%)
 rename tools/binman/test/{090_hash.dts => security/hash.dts} (100%)
 rename tools/binman/test/{092_hash_bad_algo.dts => security/hash_bad_algo.dts} (100%)
 rename tools/binman/test/{091_hash_no_algo.dts => security/hash_no_algo.dts} (100%)
 rename tools/binman/test/{099_hash_section.dts => security/hash_section.dts} (100%)
 rename tools/binman/test/{356_key_name_hint_dir_spl_pubkey_dtb.dts => security/key_name_hint_dir_spl_pubkey_dtb.dts} (100%)
 rename tools/binman/test/{230_pre_load.dts => security/pre_load.dts} (100%)
 rename tools/binman/test/{235_pre_load_invalid_algo.dts => security/pre_load_invalid_algo.dts} (100%)
 rename tools/binman/test/{236_pre_load_invalid_key.dts => security/pre_load_invalid_key.dts} (100%)
 rename tools/binman/test/{233_pre_load_invalid_padding.dts => security/pre_load_invalid_padding.dts} (100%)
 rename tools/binman/test/{234_pre_load_invalid_sha.dts => security/pre_load_invalid_sha.dts} (100%)
 rename tools/binman/test/{231_pre_load_pkcs.dts => security/pre_load_pkcs.dts} (100%)
 rename tools/binman/test/{232_pre_load_pss.dts => security/pre_load_pss.dts} (100%)
 rename tools/binman/test/{165_section_ignore_hash_signature.dts => security/section_ignore_hash_signature.dts} (100%)
 rename tools/binman/test/{281_sign_non_fit.dts => security/sign_non_fit.dts} (100%)
 rename tools/binman/test/{306_spl_pubkey_dtb.dts => security/spl_pubkey_dtb.dts} (100%)
 rename tools/binman/test/{279_x509_cert.dts => security/x509_cert.dts} (100%)
 rename tools/binman/test/{307_xilinx_bootgen_sign.dts => security/xilinx_bootgen_sign.dts} (100%)
 rename tools/binman/test/{308_xilinx_bootgen_sign_enc.dts => security/xilinx_bootgen_sign_enc.dts} (100%)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 074f3236c73..12af9a30055 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -2261,7 +2261,7 @@ class TestFunctional(unittest.TestCase):
 
     def testHash(self):
         """Test hashing of the contents of an entry"""
-        _, _, _, out_dtb_fname = self._DoReadFileDtb('090_hash.dts',
+        _, _, _, out_dtb_fname = self._DoReadFileDtb('security/hash.dts',
                 use_real_dtb=True, update_dtb=True)
         dtb = fdt.Fdt(out_dtb_fname)
         dtb.Scan()
@@ -2272,19 +2272,19 @@ class TestFunctional(unittest.TestCase):
 
     def testHashNoAlgo(self):
         with self.assertRaises(ValueError) as e:
-            self._DoReadFileDtb('091_hash_no_algo.dts', update_dtb=True)
+            self._DoReadFileDtb('security/hash_no_algo.dts', update_dtb=True)
         self.assertIn("Node \'/binman/u-boot\': Missing \'algo\' property for "
                       'hash node', str(e.exception))
 
     def testHashBadAlgo(self):
         with self.assertRaises(ValueError) as e:
-            self._DoReadFileDtb('092_hash_bad_algo.dts', update_dtb=True)
+            self._DoReadFileDtb('security/hash_bad_algo.dts', update_dtb=True)
         self.assertIn("Node '/binman/u-boot': Unknown hash algorithm 'invalid'",
                       str(e.exception))
 
     def testHashSection(self):
         """Test hashing of the contents of an entry"""
-        _, _, _, out_dtb_fname = self._DoReadFileDtb('099_hash_section.dts',
+        _, _, _, out_dtb_fname = self._DoReadFileDtb('security/hash_section.dts',
                 use_real_dtb=True, update_dtb=True)
         dtb = fdt.Fdt(out_dtb_fname)
         dtb.Scan()
@@ -4166,7 +4166,7 @@ class TestFunctional(unittest.TestCase):
 
     def testSectionIgnoreHashSignature(self):
         """Test that sections ignore hash, signature nodes for its data"""
-        data = self._DoReadFile('165_section_ignore_hash_signature.dts')
+        data = self._DoReadFile('security/section_ignore_hash_signature.dts')
         expected = (U_BOOT_DATA + U_BOOT_DATA)
         self.assertEqual(expected, data)
 
@@ -5822,7 +5822,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
         }
         data = self._DoReadFileDtb(
-            '230_pre_load.dts', entry_args=entry_args,
+            'security/pre_load.dts', entry_args=entry_args,
             extra_indirs=[os.path.join(self._binman_dir, 'test')])[0]
 
         image_fname = tools.get_output_filename('image.bin')
@@ -5836,7 +5836,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testPreLoadNoKey(self):
         """Test an image with a pre-load heade0r with missing key"""
         with self.assertRaises(FileNotFoundError) as exc:
-            self._DoReadFile('230_pre_load.dts')
+            self._DoReadFile('security/pre_load.dts')
         self.assertIn("No such file or directory: 'dev.key'",
                       str(exc.exception))
 
@@ -5845,7 +5845,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         entry_args = {
             'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
         }
-        data = self._DoReadFileDtb('231_pre_load_pkcs.dts',
+        data = self._DoReadFileDtb('security/pre_load_pkcs.dts',
                                    entry_args=entry_args)[0]
         self.assertEqual(PRE_LOAD_MAGIC, data[:len(PRE_LOAD_MAGIC)])
         self.assertEqual(PRE_LOAD_VERSION, data[4:4 + len(PRE_LOAD_VERSION)])
@@ -5856,7 +5856,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         entry_args = {
             'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
         }
-        data = self._DoReadFileDtb('232_pre_load_pss.dts',
+        data = self._DoReadFileDtb('security/pre_load_pss.dts',
                                    entry_args=entry_args)[0]
         self.assertEqual(PRE_LOAD_MAGIC, data[:len(PRE_LOAD_MAGIC)])
         self.assertEqual(PRE_LOAD_VERSION, data[4:4 + len(PRE_LOAD_VERSION)])
@@ -5868,7 +5868,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
         }
         with self.assertRaises(ValueError) as e:
-            self._DoReadFileDtb('233_pre_load_invalid_padding.dts',
+            self._DoReadFileDtb('security/pre_load_invalid_padding.dts',
                                 entry_args=entry_args)
 
     def testPreLoadInvalidSha(self):
@@ -5877,13 +5877,13 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
         }
         with self.assertRaises(ValueError) as e:
-            self._DoReadFileDtb('234_pre_load_invalid_sha.dts',
+            self._DoReadFileDtb('security/pre_load_invalid_sha.dts',
                                 entry_args=entry_args)
 
     def testPreLoadInvalidAlgo(self):
         """Test an image with a pre-load header with an invalid algo"""
         with self.assertRaises(ValueError) as e:
-            data = self._DoReadFile('235_pre_load_invalid_algo.dts')
+            data = self._DoReadFile('security/pre_load_invalid_algo.dts')
 
     def testPreLoadInvalidKey(self):
         """Test an image with a pre-load header with an invalid key"""
@@ -5891,7 +5891,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
         }
         with self.assertRaises(ValueError) as e:
-            data = self._DoReadFileDtb('236_pre_load_invalid_key.dts',
+            data = self._DoReadFileDtb('security/pre_load_invalid_key.dts',
                                        entry_args=entry_args)
 
     def _CheckSafeUniqueNames(self, *images):
@@ -6863,7 +6863,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         entry_args = {
             'keyfile': keyfile,
         }
-        data = self._DoReadFileDtb('279_x509_cert.dts',
+        data = self._DoReadFileDtb('security/x509_cert.dts',
                                    entry_args=entry_args)[0]
         cert = data[:-4]
         self.assertEqual(U_BOOT_DATA, data[-4:])
@@ -6877,7 +6877,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             'keyfile': 'keyfile',
         }
         with terminal.capture() as (_, stderr):
-            self._DoTestFile('279_x509_cert.dts',
+            self._DoTestFile('security/x509_cert.dts',
                              force_missing_bintools='openssl',
                              entry_args=entry_args)
         err = stderr.getvalue()
@@ -6963,7 +6963,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test a non-FIT entry cannot be signed"""
         is_signed = False
         fit, fname, private_key, _ = self._PrepareSignEnv(
-            '281_sign_non_fit.dts')
+            'security/sign_non_fit.dts')
 
         # do sign with private key
         with self.assertRaises(ValueError) as e:
@@ -7272,7 +7272,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testEncryptedNoAlgo(self):
         """Test encrypted node with missing required properties"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFileDtb('301_encrypted_no_algo.dts')
+            self._DoReadFileDtb('security/encrypted_no_algo.dts')
         self.assertIn(
             "Node '/binman/fit/images/u-boot/encrypted': 'encrypted' entry is missing properties: algo iv-filename",
             str(e.exception))
@@ -7280,21 +7280,21 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testEncryptedInvalidIvfile(self):
         """Test encrypted node with invalid iv file"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFileDtb('302_encrypted_invalid_iv_file.dts')
+            self._DoReadFileDtb('security/encrypted_invalid_iv_file.dts')
         self.assertIn("Filename 'invalid-iv-file' not found in input path",
                       str(e.exception))
 
     def testEncryptedMissingKey(self):
         """Test encrypted node with missing key properties"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFileDtb('303_encrypted_missing_key.dts')
+            self._DoReadFileDtb('security/encrypted_missing_key.dts')
         self.assertIn(
             "Node '/binman/fit/images/u-boot/encrypted': Provide either 'key-filename' or 'key-source'",
             str(e.exception))
 
     def testEncryptedKeySource(self):
         """Test encrypted node with key-source property"""
-        data = self._DoReadFileDtb('304_encrypted_key_source.dts')[0]
+        data = self._DoReadFileDtb('security/encrypted_key_source.dts')[0]
 
         dtb = fdt.Fdt.FromData(data)
         dtb.Scan()
@@ -7308,7 +7308,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testEncryptedKeyFile(self):
         """Test encrypted node with key-filename property"""
-        data = self._DoReadFileDtb('305_encrypted_key_file.dts')[0]
+        data = self._DoReadFileDtb('security/encrypted_key_file.dts')[0]
 
         dtb = fdt.Fdt.FromData(data)
         dtb.Scan()
@@ -7324,7 +7324,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testKeyNameHintIsPathSplPubkeyDtb(self):
         """Test that binman errors out on key-name-hint being a path"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('356_key_name_hint_dir_spl_pubkey_dtb.dts')
+            self._DoReadFile('security/key_name_hint_dir_spl_pubkey_dtb.dts')
         self.assertIn(
             'Node \'/binman/u-boot-spl-pubkey-dtb\': \'keys/key\' is a path not a filename',
             str(e.exception))
@@ -7333,7 +7333,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test u_boot_spl_pubkey_dtb etype"""
         data = tools.read_file(self.TestFile("key.pem"))
         self._MakeInputFile("key.crt", data)
-        self._DoReadFileRealDtb('306_spl_pubkey_dtb.dts')
+        self._DoReadFileRealDtb('security/spl_pubkey_dtb.dts')
         image = control.images['image']
         entries = image.GetEntries()
         dtb_entry = entries['u-boot-spl-pubkey-dtb']
@@ -7358,7 +7358,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self._MakeInputFile("ssk.pem", data)
         self._SetupPmuFwlElf()
         self._SetupSplElf()
-        self._DoReadFileRealDtb('307_xilinx_bootgen_sign.dts')
+        self._DoReadFileRealDtb('security/xilinx_bootgen_sign.dts')
         image_fname = tools.get_output_filename('image.bin')
 
         # Read partition header table and check if authentication is enabled
@@ -7387,7 +7387,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self._MakeInputFile("ssk.pem", data)
         self._SetupPmuFwlElf()
         self._SetupSplElf()
-        self._DoReadFileRealDtb('308_xilinx_bootgen_sign_enc.dts')
+        self._DoReadFileRealDtb('security/xilinx_bootgen_sign_enc.dts')
         image_fname = tools.get_output_filename('image.bin')
 
         # Read boot header in order to verify encryption source and
@@ -7420,7 +7420,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self._SetupPmuFwlElf()
         self._SetupSplElf()
         with terminal.capture() as (_, stderr):
-            self._DoTestFile('307_xilinx_bootgen_sign.dts',
+            self._DoTestFile('security/xilinx_bootgen_sign.dts',
                              force_missing_bintools='bootgen')
         err = stderr.getvalue()
         self.assertRegex(err,
diff --git a/tools/binman/test/302_encrypted_invalid_iv_file.dts b/tools/binman/test/security/encrypted_invalid_iv_file.dts
similarity index 100%
rename from tools/binman/test/302_encrypted_invalid_iv_file.dts
rename to tools/binman/test/security/encrypted_invalid_iv_file.dts
diff --git a/tools/binman/test/305_encrypted_key_file.dts b/tools/binman/test/security/encrypted_key_file.dts
similarity index 100%
rename from tools/binman/test/305_encrypted_key_file.dts
rename to tools/binman/test/security/encrypted_key_file.dts
diff --git a/tools/binman/test/304_encrypted_key_source.dts b/tools/binman/test/security/encrypted_key_source.dts
similarity index 100%
rename from tools/binman/test/304_encrypted_key_source.dts
rename to tools/binman/test/security/encrypted_key_source.dts
diff --git a/tools/binman/test/303_encrypted_missing_key.dts b/tools/binman/test/security/encrypted_missing_key.dts
similarity index 100%
rename from tools/binman/test/303_encrypted_missing_key.dts
rename to tools/binman/test/security/encrypted_missing_key.dts
diff --git a/tools/binman/test/301_encrypted_no_algo.dts b/tools/binman/test/security/encrypted_no_algo.dts
similarity index 100%
rename from tools/binman/test/301_encrypted_no_algo.dts
rename to tools/binman/test/security/encrypted_no_algo.dts
diff --git a/tools/binman/test/090_hash.dts b/tools/binman/test/security/hash.dts
similarity index 100%
rename from tools/binman/test/090_hash.dts
rename to tools/binman/test/security/hash.dts
diff --git a/tools/binman/test/092_hash_bad_algo.dts b/tools/binman/test/security/hash_bad_algo.dts
similarity index 100%
rename from tools/binman/test/092_hash_bad_algo.dts
rename to tools/binman/test/security/hash_bad_algo.dts
diff --git a/tools/binman/test/091_hash_no_algo.dts b/tools/binman/test/security/hash_no_algo.dts
similarity index 100%
rename from tools/binman/test/091_hash_no_algo.dts
rename to tools/binman/test/security/hash_no_algo.dts
diff --git a/tools/binman/test/099_hash_section.dts b/tools/binman/test/security/hash_section.dts
similarity index 100%
rename from tools/binman/test/099_hash_section.dts
rename to tools/binman/test/security/hash_section.dts
diff --git a/tools/binman/test/356_key_name_hint_dir_spl_pubkey_dtb.dts b/tools/binman/test/security/key_name_hint_dir_spl_pubkey_dtb.dts
similarity index 100%
rename from tools/binman/test/356_key_name_hint_dir_spl_pubkey_dtb.dts
rename to tools/binman/test/security/key_name_hint_dir_spl_pubkey_dtb.dts
diff --git a/tools/binman/test/230_pre_load.dts b/tools/binman/test/security/pre_load.dts
similarity index 100%
rename from tools/binman/test/230_pre_load.dts
rename to tools/binman/test/security/pre_load.dts
diff --git a/tools/binman/test/235_pre_load_invalid_algo.dts b/tools/binman/test/security/pre_load_invalid_algo.dts
similarity index 100%
rename from tools/binman/test/235_pre_load_invalid_algo.dts
rename to tools/binman/test/security/pre_load_invalid_algo.dts
diff --git a/tools/binman/test/236_pre_load_invalid_key.dts b/tools/binman/test/security/pre_load_invalid_key.dts
similarity index 100%
rename from tools/binman/test/236_pre_load_invalid_key.dts
rename to tools/binman/test/security/pre_load_invalid_key.dts
diff --git a/tools/binman/test/233_pre_load_invalid_padding.dts b/tools/binman/test/security/pre_load_invalid_padding.dts
similarity index 100%
rename from tools/binman/test/233_pre_load_invalid_padding.dts
rename to tools/binman/test/security/pre_load_invalid_padding.dts
diff --git a/tools/binman/test/234_pre_load_invalid_sha.dts b/tools/binman/test/security/pre_load_invalid_sha.dts
similarity index 100%
rename from tools/binman/test/234_pre_load_invalid_sha.dts
rename to tools/binman/test/security/pre_load_invalid_sha.dts
diff --git a/tools/binman/test/231_pre_load_pkcs.dts b/tools/binman/test/security/pre_load_pkcs.dts
similarity index 100%
rename from tools/binman/test/231_pre_load_pkcs.dts
rename to tools/binman/test/security/pre_load_pkcs.dts
diff --git a/tools/binman/test/232_pre_load_pss.dts b/tools/binman/test/security/pre_load_pss.dts
similarity index 100%
rename from tools/binman/test/232_pre_load_pss.dts
rename to tools/binman/test/security/pre_load_pss.dts
diff --git a/tools/binman/test/165_section_ignore_hash_signature.dts b/tools/binman/test/security/section_ignore_hash_signature.dts
similarity index 100%
rename from tools/binman/test/165_section_ignore_hash_signature.dts
rename to tools/binman/test/security/section_ignore_hash_signature.dts
diff --git a/tools/binman/test/281_sign_non_fit.dts b/tools/binman/test/security/sign_non_fit.dts
similarity index 100%
rename from tools/binman/test/281_sign_non_fit.dts
rename to tools/binman/test/security/sign_non_fit.dts
diff --git a/tools/binman/test/306_spl_pubkey_dtb.dts b/tools/binman/test/security/spl_pubkey_dtb.dts
similarity index 100%
rename from tools/binman/test/306_spl_pubkey_dtb.dts
rename to tools/binman/test/security/spl_pubkey_dtb.dts
diff --git a/tools/binman/test/279_x509_cert.dts b/tools/binman/test/security/x509_cert.dts
similarity index 100%
rename from tools/binman/test/279_x509_cert.dts
rename to tools/binman/test/security/x509_cert.dts
diff --git a/tools/binman/test/307_xilinx_bootgen_sign.dts b/tools/binman/test/security/xilinx_bootgen_sign.dts
similarity index 100%
rename from tools/binman/test/307_xilinx_bootgen_sign.dts
rename to tools/binman/test/security/xilinx_bootgen_sign.dts
diff --git a/tools/binman/test/308_xilinx_bootgen_sign_enc.dts b/tools/binman/test/security/xilinx_bootgen_sign_enc.dts
similarity index 100%
rename from tools/binman/test/308_xilinx_bootgen_sign_enc.dts
rename to tools/binman/test/security/xilinx_bootgen_sign_enc.dts
-- 
2.43.0

