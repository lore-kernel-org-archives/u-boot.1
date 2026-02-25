Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB4EFD45FA
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 22:51:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3416F83642;
	Wed, 25 Feb 2026 23:51:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IqDa4872";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE3C88366F; Wed, 25 Feb 2026 23:51:19 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F67D82A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 23:51:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-8cb39647a70so14400685a.0
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 14:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772059876; x=1772664676; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JMJv0sDDNAeM8ZpkqXw/cvVpzik1x0+wDnVEQ3pHJ5U=;
 b=IqDa4872YomVG1KJ3Qt4a9rCaoEcuatNkqtIKhW6/m2G3PEFEM5nq96nIxL3kZ0lsa
 y0QLSjcR/5uWAGksJjDSv4ySchxFSj20QKEFYLN0KR1ACxsdGTtt6WRkeFYj3kZFm+SW
 5XF8HSQDWp7J0JQRrv3xdDZuywVax7X37L1KE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772059876; x=1772664676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JMJv0sDDNAeM8ZpkqXw/cvVpzik1x0+wDnVEQ3pHJ5U=;
 b=Qk6RCWr/XgpXTy7QTzZtVM5sbqi9a6FD4Ha09ioElW3/WFNm72gDGAgZcrgOA3wczM
 ctD1+vkC+qa8t7w+gvq1zFLK+G8PWB6D/RupThuXEZn3pxm+9H4VjjDZ2hqBN2W5ExSL
 PaYOzWnC6mz2RLMsiu8XKaOOT5vdLZDhiRAVakckKAuevMOhk3Zd7bezPjvMEvyECYih
 OCshCn+n76R5f8efTZLFgTmmSi1MdxZrjjRU5p4RUqQJd2EW9uG85dpKS8Id9Axe2uxj
 wsPajo99asmPtbzue/7vrTQCe1n8kSFkszcjlVgc7IyX3LeYg1PNMjM6CuykLTGXb/N9
 gCWA==
X-Gm-Message-State: AOJu0YzUoXYZIVcfv85CsHqaOL+QoO4PJto52m5ESM4PRsqLCD7EUysp
 6sKnu0MvQ4d4Tbhq2U+aiP+Wtoef8xqavqbrVmjCyIZGPurqaCOJfXWFvhpaz5mutVH1NeFyCJ1
 RdhY=
X-Gm-Gg: ATEYQzwKaYREZQ1Sz1hfkCm8L7gtajJ8BOF634JVRyeYjJsJQvo0TTBKvIzoelBPqOW
 QBfd7zvsvGKJmmfCxTqolB+Y8hXkTtmKYBFzZ3aPqT6ZMv50FKZXuZoSz+jTM8/Ohrewg6kl5OH
 DRaktW3dexmHU3pSjf2kzFw5jAWz2lupzOzjglkFL3/FLSnzLvwKSjhyeL64itGnLRQfVUeippf
 RjihKxDf3zsJFqoZ2pm04MNPLP+vmpqeshzymGNIl70qkQKepcwrss2Qtz9XRqzqfFd9dwBez25
 Z5WrkO0lTkOImqoiQaRjJIEl7GJpX/gT82SWEuubMjJPvC852ysisw7a4IcfKM0RerH/K0hEGGu
 N+2IAUPrmxpsa2sVLTqwUneyC6M4yK6gvc8dah6Fycvfhf6y4LLjjiAUtK+38D2PiUZZZ/dDUBI
 erocfXVbkr+AW2eYOM0ZS2A9hfVJCn
X-Received: by 2002:a05:620a:1a21:b0:8ca:2cf9:819d with SMTP id
 af79cd13be357-8cbbcf59191mr295221085a.26.1772059875653; 
 Wed, 25 Feb 2026 14:51:15 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf72e21bsm43730985a.44.2026.02.25.14.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 14:51:14 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <simon.glass@canonical.com>, Alice Guo <alice.guo@nxp.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de>
Subject: [PATCH 1/6] binman: test: Renumber duplicate test-file prefixes
Date: Wed, 25 Feb 2026 15:50:30 -0700
Message-ID: <20260225225040.2568118-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225225040.2568118-1-sjg@chromium.org>
References: <20260225225040.2568118-1-sjg@chromium.org>
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

Quite a few test files reuse number prefixes that already exist in the
test numbering. Test .dts files are supposed to start with unique
numbers.

Renumber conflicting files and update the references in ftest.py

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 tools/binman/ftest.py                         | 26 +++++++++----------
 .../test/{225_ti_dm.dts => 351_ti_dm.dts}     |  0
 ...g_phony.dts => 352_ti_board_cfg_phony.dts} |  0
 ...drfw_imx95.dts => 353_nxp_ddrfw_imx95.dts} |  0
 .../binman/test/{347_bl1.dts => 354_bl1.dts}  |  0
 ...> 355_key_name_hint_dir_fit_signature.dts} |  0
 ... 356_key_name_hint_dir_spl_pubkey_dtb.dts} |  0
 ...car4_sa0.dts => 357_renesas_rcar4_sa0.dts} |  0
 ...ize.dts => 358_renesas_rcar4_sa0_size.dts} |  0
 .../{350_nxp_imx95.dts => 359_nxp_imx95.dts}  |  0
 ...ngine.dts => 360_fit_signature_engine.dts} |  0
 ...s => 361_fit_signature_engine_encrypt.dts} |  0
 ...ts => 362_fit_signature_engine_pkcs11.dts} |  0
 ...63_fit_signature_engine_pkcs11_object.dts} |  0
 14 files changed, 13 insertions(+), 13 deletions(-)
 rename tools/binman/test/{225_ti_dm.dts => 351_ti_dm.dts} (100%)
 rename tools/binman/test/{323_ti_board_cfg_phony.dts => 352_ti_board_cfg_phony.dts} (100%)
 rename tools/binman/test/{346_nxp_ddrfw_imx95.dts => 353_nxp_ddrfw_imx95.dts} (100%)
 rename tools/binman/test/{347_bl1.dts => 354_bl1.dts} (100%)
 rename tools/binman/test/{347_key_name_hint_dir_fit_signature.dts => 355_key_name_hint_dir_fit_signature.dts} (100%)
 rename tools/binman/test/{348_key_name_hint_dir_spl_pubkey_dtb.dts => 356_key_name_hint_dir_spl_pubkey_dtb.dts} (100%)
 rename tools/binman/test/{348_renesas_rcar4_sa0.dts => 357_renesas_rcar4_sa0.dts} (100%)
 rename tools/binman/test/{349_renesas_rcar4_sa0_size.dts => 358_renesas_rcar4_sa0_size.dts} (100%)
 rename tools/binman/test/{350_nxp_imx95.dts => 359_nxp_imx95.dts} (100%)
 rename tools/binman/test/{340_fit_signature_engine.dts => 360_fit_signature_engine.dts} (100%)
 rename tools/binman/test/{340_fit_signature_engine_encrypt.dts => 361_fit_signature_engine_encrypt.dts} (100%)
 rename tools/binman/test/{340_fit_signature_engine_pkcs11.dts => 362_fit_signature_engine_pkcs11.dts} (100%)
 rename tools/binman/test/{340_fit_signature_engine_pkcs11_object.dts => 363_fit_signature_engine_pkcs11_object.dts} (100%)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index a53e37f31b3..208ac3896dd 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -5578,22 +5578,22 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testPackTiDm(self):
         """Test that an image with a TI DM binary can be created"""
-        data = self._DoReadFile('225_ti_dm.dts')
+        data = self._DoReadFile('351_ti_dm.dts')
         self.assertEqual(TI_DM_DATA, data[:len(TI_DM_DATA)])
 
     def testPackBl1(self):
         """test if an image with a bl1 binary can be created"""
-        data = self._DoReadFile('347_bl1.dts')
+        data = self._DoReadFile('354_bl1.dts')
         self.assertEqual(ATF_BL1_DATA, data[:len(ATF_BL1_DATA)])
 
     def testRenesasRCarGen4SA0Image(self):
         """Test that binman can produce an Renesas R-Car Gen4 SA0 image"""
-        self._DoTestFile('348_renesas_rcar4_sa0.dts')
+        self._DoTestFile('357_renesas_rcar4_sa0.dts')
 
     def testRenesasRCarGen4SA0ImageSize(self):
         """Test that binman can not produce large Renesas R-Car Gen4 SA0 image"""
         with self.assertRaises(ValueError) as exc:
-            self._DoTestFile('349_renesas_rcar4_sa0_size.dts')
+            self._DoTestFile('358_renesas_rcar4_sa0_size.dts')
         self.assertIn("Node '/binman/renesas-rcar4-sa0': SRAM data longer than 966656 Bytes",
                       str(exc.exception))
 
@@ -7181,7 +7181,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testTIBoardConfigLint(self):
         """Test that an incorrectly linted config file would generate error"""
         with self.assertRaises(ValueError) as e:
-            data = self._DoReadFile('323_ti_board_cfg_phony.dts')
+            data = self._DoReadFile('352_ti_board_cfg_phony.dts')
         self.assertIn("Yamllint error", str(e.exception))
 
     def testTIBoardConfigCombined(self):
@@ -7324,7 +7324,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testKeyNameHintIsPathSplPubkeyDtb(self):
         """Test that binman errors out on key-name-hint being a path"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('348_key_name_hint_dir_spl_pubkey_dtb.dts')
+            self._DoReadFile('356_key_name_hint_dir_spl_pubkey_dtb.dts')
         self.assertIn(
             'Node \'/binman/u-boot-spl-pubkey-dtb\': \'keys/key\' is a path not a filename',
             str(e.exception))
@@ -7901,7 +7901,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testNxpHeaderDdrfw(self):
         """Test that binman can add a header to DDR PHY firmware images"""
-        data = self._DoReadFile('346_nxp_ddrfw_imx95.dts')
+        data = self._DoReadFile('353_nxp_ddrfw_imx95.dts')
         self.assertEqual(len(IMX_LPDDR_IMEM_DATA).to_bytes(4, 'little') +
                          len(IMX_LPDDR_DMEM_DATA).to_bytes(4, 'little') +
                          IMX_LPDDR_IMEM_DATA + IMX_LPDDR_DMEM_DATA, data)
@@ -7915,7 +7915,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         container_path = os.path.join(testdir, 'mx95b0-ahab-container.img')
         with open(container_path, 'w') as f:
             f.write(bytes([0x87]).decode('latin1') * 32768)
-        self._DoTestFile('350_nxp_imx95.dts', output_dir=testdir)
+        self._DoTestFile('359_nxp_imx95.dts', output_dir=testdir)
 
     def testFitSignSimple(self):
         """Test that image with FIT and signature nodes can be signed"""
@@ -7973,7 +7973,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         with unittest.mock.patch.dict('os.environ',
                                       {'OPENSSL_ENGINES': ossl_engines_path}):
             data = self._DoReadFileDtb(
-                '340_fit_signature_engine.dts',
+                '360_fit_signature_engine.dts',
                 entry_args=entry_args,
                 extra_indirs=[test_subdir])[0]
 
@@ -8014,7 +8014,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
         with self.assertRaises(ValueError) as e:
             self._DoReadFileDtb(
-                    '340_fit_signature_engine_encrypt.dts',
+                    '361_fit_signature_engine_encrypt.dts',
                     entry_args=entry_args,
                     extra_indirs=[test_subdir])
 
@@ -8074,7 +8074,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
                                       {'OPENSSL_CONF': ossl_conf,
                                        'SOFTHSM2_CONF': softhsm2_conf}):
             data = self._DoReadFileDtb(
-                '340_fit_signature_engine_pkcs11.dts',
+                '362_fit_signature_engine_pkcs11.dts',
                 entry_args=entry_args,
                 extra_indirs=[test_subdir])[0]
 
@@ -8152,7 +8152,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
                                        'SOFTHSM2_CONF': softhsm2_conf,
                                        'MKIMAGE_SIGN_PIN': '1234'}):
             data = self._DoReadFileDtb(
-                '340_fit_signature_engine_pkcs11_object.dts',
+                '363_fit_signature_engine_pkcs11_object.dts',
                 entry_args=entry_args,
                 extra_indirs=[test_subdir])[0]
 
@@ -8247,7 +8247,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         test_subdir = os.path.join(self._indir, TEST_FDT_SUBDIR)
         with self.assertRaises(ValueError) as e:
             self._DoReadFileDtb(
-                    '347_key_name_hint_dir_fit_signature.dts',
+                    '355_key_name_hint_dir_fit_signature.dts',
                     entry_args=entry_args,
                     extra_indirs=[test_subdir])
         self.assertIn(
diff --git a/tools/binman/test/225_ti_dm.dts b/tools/binman/test/351_ti_dm.dts
similarity index 100%
rename from tools/binman/test/225_ti_dm.dts
rename to tools/binman/test/351_ti_dm.dts
diff --git a/tools/binman/test/323_ti_board_cfg_phony.dts b/tools/binman/test/352_ti_board_cfg_phony.dts
similarity index 100%
rename from tools/binman/test/323_ti_board_cfg_phony.dts
rename to tools/binman/test/352_ti_board_cfg_phony.dts
diff --git a/tools/binman/test/346_nxp_ddrfw_imx95.dts b/tools/binman/test/353_nxp_ddrfw_imx95.dts
similarity index 100%
rename from tools/binman/test/346_nxp_ddrfw_imx95.dts
rename to tools/binman/test/353_nxp_ddrfw_imx95.dts
diff --git a/tools/binman/test/347_bl1.dts b/tools/binman/test/354_bl1.dts
similarity index 100%
rename from tools/binman/test/347_bl1.dts
rename to tools/binman/test/354_bl1.dts
diff --git a/tools/binman/test/347_key_name_hint_dir_fit_signature.dts b/tools/binman/test/355_key_name_hint_dir_fit_signature.dts
similarity index 100%
rename from tools/binman/test/347_key_name_hint_dir_fit_signature.dts
rename to tools/binman/test/355_key_name_hint_dir_fit_signature.dts
diff --git a/tools/binman/test/348_key_name_hint_dir_spl_pubkey_dtb.dts b/tools/binman/test/356_key_name_hint_dir_spl_pubkey_dtb.dts
similarity index 100%
rename from tools/binman/test/348_key_name_hint_dir_spl_pubkey_dtb.dts
rename to tools/binman/test/356_key_name_hint_dir_spl_pubkey_dtb.dts
diff --git a/tools/binman/test/348_renesas_rcar4_sa0.dts b/tools/binman/test/357_renesas_rcar4_sa0.dts
similarity index 100%
rename from tools/binman/test/348_renesas_rcar4_sa0.dts
rename to tools/binman/test/357_renesas_rcar4_sa0.dts
diff --git a/tools/binman/test/349_renesas_rcar4_sa0_size.dts b/tools/binman/test/358_renesas_rcar4_sa0_size.dts
similarity index 100%
rename from tools/binman/test/349_renesas_rcar4_sa0_size.dts
rename to tools/binman/test/358_renesas_rcar4_sa0_size.dts
diff --git a/tools/binman/test/350_nxp_imx95.dts b/tools/binman/test/359_nxp_imx95.dts
similarity index 100%
rename from tools/binman/test/350_nxp_imx95.dts
rename to tools/binman/test/359_nxp_imx95.dts
diff --git a/tools/binman/test/340_fit_signature_engine.dts b/tools/binman/test/360_fit_signature_engine.dts
similarity index 100%
rename from tools/binman/test/340_fit_signature_engine.dts
rename to tools/binman/test/360_fit_signature_engine.dts
diff --git a/tools/binman/test/340_fit_signature_engine_encrypt.dts b/tools/binman/test/361_fit_signature_engine_encrypt.dts
similarity index 100%
rename from tools/binman/test/340_fit_signature_engine_encrypt.dts
rename to tools/binman/test/361_fit_signature_engine_encrypt.dts
diff --git a/tools/binman/test/340_fit_signature_engine_pkcs11.dts b/tools/binman/test/362_fit_signature_engine_pkcs11.dts
similarity index 100%
rename from tools/binman/test/340_fit_signature_engine_pkcs11.dts
rename to tools/binman/test/362_fit_signature_engine_pkcs11.dts
diff --git a/tools/binman/test/340_fit_signature_engine_pkcs11_object.dts b/tools/binman/test/363_fit_signature_engine_pkcs11_object.dts
similarity index 100%
rename from tools/binman/test/340_fit_signature_engine_pkcs11_object.dts
rename to tools/binman/test/363_fit_signature_engine_pkcs11_object.dts
-- 
2.43.0

