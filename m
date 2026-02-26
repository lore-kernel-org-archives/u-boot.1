Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCCAFD9E1E
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 23:50:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72A4183FA7;
	Fri, 27 Feb 2026 00:49:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jfcrQpib";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0855683F32; Fri, 27 Feb 2026 00:49:17 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 082C983F39
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 00:49:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-899b676b5d2so18339416d6.1
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 15:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772149748; x=1772754548; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NA2XO1Fcc4+44ZKe4VR+r+WClA/MfGGn4yUmdBnaYTs=;
 b=jfcrQpibxXBDX8h64+3iKoz17hrz0icp08A5wRhgo3wYffuHXIgfukKU8UtLMGnZ3V
 kEFRiXnIFRJ2O0KH4cTu52Yj+7vnSf/u/rWPt0pBoAkc4wn1wsQzatOd58wYdZ0/SMKJ
 Qyml74UdPLYjMaa/lXhp94mhQL/dU/T+ff1dI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772149748; x=1772754548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NA2XO1Fcc4+44ZKe4VR+r+WClA/MfGGn4yUmdBnaYTs=;
 b=nitk0HChLVfxhWHWWC8CdlFeXL+yPZxZTrJS13IkZQlhGk4rAialqAbhielJS1vDe8
 NzexlbSaELF6HrQpmST0tTO//tGSAEdmQ8fYuu9kmCn2DY5aO6TQIiJAsqm9+LQFwUQ0
 V2IgRBX2tlMH9+ExCq3I2/s4xY9l0z+5rx1tWzvpnGOsGfgJvH2j4Jnfns0RVFkVDEYn
 zJQTiILMZ0a9KexNMCrYqzfIuhcoebYPV4fYk/LK1LGDPF5gdiatFwh9BiEshKDkKDdG
 Hk7gFGGR+E5RcerVzOR5vd0yt92K9pp9foT0NQDS0XV6JsP4yL7lEcG6c7m3xlE74ls5
 Yu/A==
X-Gm-Message-State: AOJu0YzYjVSxg7FUh1VdWoS8HG56NZMVSm1pRclvhOkZZS48scpttgrW
 19aHFGYbw3Z5wENa6IjVKjbAR/2qri7+2RbZ7TUJKcCwpAKqLHugLlq6Kg9CaE38b/w9/d9xput
 fCw8=
X-Gm-Gg: ATEYQzymSuRNkCCsDa35ePDOqMsG68+ILmKPhkqPx5VWhN+MDYyUks337LPA2mDiyE5
 ONp9gqNla1YrvxWXpqyJNw34h0RiDWRtCi6P/L+P/2OMpe4UbRf6Sw5daGHMHKoJGuoBxsnxMxn
 a+0r1732gzGGlYTBGXHHCv1tPrqDiYu1iqAx8Dfa7Mh13hYyo+ME4v94QaTr1f7BF1hrorjLyNd
 bfc1OGXpfoXCTg1t0NoqrVF0Zy2624dlZV3Gzg39zvPn3EYeG1MIvKWXT8VMEVRHNvP38NMDaNN
 q9v73o7cWIgiFK1YR94LfwxR2OrwwwoEoWZgi3p3+Ajwjh4gwyDSF0t5Q1OhcBeMFyt3aV2wkn/
 IJj7K4+aXCYNX1mvYuU/VNgxrThxorvDQbah/zvBcEzZeZs1WWYiKxeej0MWqcfBkbf3pP2BW9w
 mHyFQbAW2SwcU9DnbaGw==
X-Received: by 2002:ad4:5ccb:0:b0:896:f42f:bf19 with SMTP id
 6a1803df08f44-899d1e97e4fmr15386546d6.57.1772149748214; 
 Thu, 26 Feb 2026 15:49:08 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf68a0fbsm322024385a.22.2026.02.26.15.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 15:49:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <simon.glass@canonical.com>, Alice Guo <alice.guo@nxp.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
Subject: [RFC PATCH 13/16] binman: test: Move vendor-specific test files to
 test/vendor/
Date: Thu, 26 Feb 2026 16:47:53 -0700
Message-ID: <20260226234802.345968-14-sjg@chromium.org>
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

Move about 20 test files for vendor-specific platform support (TI, NXP
i.MX, Renesas R-Car, Rockchip, PowerPC MPC85xx) into a vendor/
subdirectory. Drop the numeric prefixes and update all references.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 doc/develop/binman_tests.rst                  |  8 +--
 tools/binman/ftest.py                         | 56 +++++++++----------
 .../nxp_ddrfw_imx95.dts}                      |  0
 .../{339_nxp_imx8.dts => vendor/nxp_imx8.dts} |  0
 .../nxp_imx8_csf.dts}                         |  0
 .../nxp_imx8_csf_fast_auth.dts}               |  0
 .../nxp_imx8_imagename.dts}                   |  0
 .../nxp_imx95.dts}                            |  0
 .../powerpc_mpc85xx_bootpg_resetvec.dts}      |  0
 .../renesas_rcar4_sa0.dts}                    |  0
 .../renesas_rcar4_sa0_size.dts}               |  0
 .../rockchip_tpl.dts}                         |  0
 .../ti_board_cfg.dts}                         |  0
 .../ti_board_cfg_combined.dts}                |  0
 .../ti_board_cfg_no_type.dts}                 |  0
 .../ti_board_cfg_phony.dts}                   |  0
 .../test/{351_ti_dm.dts => vendor/ti_dm.dts}  |  0
 .../ti_secure.dts}                            |  0
 .../ti_secure_firewall.dts}                   |  0
 .../ti_secure_firewall_missing_property.dts}  |  0
 .../ti_secure_rom.dts}                        |  0
 .../ti_secure_rom_a.dts}                      |  0
 .../ti_secure_rom_b.dts}                      |  0
 .../ti_secure_rom_combined.dts}               |  0
 24 files changed, 32 insertions(+), 32 deletions(-)
 rename tools/binman/test/{353_nxp_ddrfw_imx95.dts => vendor/nxp_ddrfw_imx95.dts} (100%)
 rename tools/binman/test/{339_nxp_imx8.dts => vendor/nxp_imx8.dts} (100%)
 rename tools/binman/test/{364_nxp_imx8_csf.dts => vendor/nxp_imx8_csf.dts} (100%)
 rename tools/binman/test/{365_nxp_imx8_csf_fast_auth.dts => vendor/nxp_imx8_csf_fast_auth.dts} (100%)
 rename tools/binman/test/{366_nxp_imx8_imagename.dts => vendor/nxp_imx8_imagename.dts} (100%)
 rename tools/binman/test/{359_nxp_imx95.dts => vendor/nxp_imx95.dts} (100%)
 rename tools/binman/test/{150_powerpc_mpc85xx_bootpg_resetvec.dts => vendor/powerpc_mpc85xx_bootpg_resetvec.dts} (100%)
 rename tools/binman/test/{357_renesas_rcar4_sa0.dts => vendor/renesas_rcar4_sa0.dts} (100%)
 rename tools/binman/test/{358_renesas_rcar4_sa0_size.dts => vendor/renesas_rcar4_sa0_size.dts} (100%)
 rename tools/binman/test/{291_rockchip_tpl.dts => vendor/rockchip_tpl.dts} (100%)
 rename tools/binman/test/{293_ti_board_cfg.dts => vendor/ti_board_cfg.dts} (100%)
 rename tools/binman/test/{294_ti_board_cfg_combined.dts => vendor/ti_board_cfg_combined.dts} (100%)
 rename tools/binman/test/{295_ti_board_cfg_no_type.dts => vendor/ti_board_cfg_no_type.dts} (100%)
 rename tools/binman/test/{352_ti_board_cfg_phony.dts => vendor/ti_board_cfg_phony.dts} (100%)
 rename tools/binman/test/{351_ti_dm.dts => vendor/ti_dm.dts} (100%)
 rename tools/binman/test/{296_ti_secure.dts => vendor/ti_secure.dts} (100%)
 rename tools/binman/test/{324_ti_secure_firewall.dts => vendor/ti_secure_firewall.dts} (100%)
 rename tools/binman/test/{325_ti_secure_firewall_missing_property.dts => vendor/ti_secure_firewall_missing_property.dts} (100%)
 rename tools/binman/test/{297_ti_secure_rom.dts => vendor/ti_secure_rom.dts} (100%)
 rename tools/binman/test/{299_ti_secure_rom_a.dts => vendor/ti_secure_rom_a.dts} (100%)
 rename tools/binman/test/{300_ti_secure_rom_b.dts => vendor/ti_secure_rom_b.dts} (100%)
 rename tools/binman/test/{298_ti_secure_rom_combined.dts => vendor/ti_secure_rom_combined.dts} (100%)

diff --git a/doc/develop/binman_tests.rst b/doc/develop/binman_tests.rst
index c7fa9ae6199..2bdb7756465 100644
--- a/doc/develop/binman_tests.rst
+++ b/doc/develop/binman_tests.rst
@@ -457,7 +457,7 @@ can, which contains the new etype. Put it in a numbered file in
 ``tool/binman/test`` so that it comes last. All the numbers are unique and there
 are no gaps.
 
-Example from ``tools/binman/test/339_nxp_imx8.dts``:
+Example from ``tools/binman/test/vendor/nxp_imx8.dts``:
 
 .. code-block:: devicetree
 
@@ -493,7 +493,7 @@ Then create your test by adding a new function at the end of ``ftest.py``:
 
     def testNxpImx8Image(self):
         """Test that binman can produce an iMX8 image"""
-        self._DoTestFile('339_nxp_imx8.dts')
+        self._DoTestFile('vendor/nxp_imx8.dts')
 
 This uses the test file that you created. It doesn't check anything, it just
 runs the image description through binman.
@@ -517,7 +517,7 @@ The next step is to update it to actually check the output:
 
     def testNxpImx8Image(self):
         """Test that binman can produce an iMX8 image"""
-        data = self._DoReadFile('339_nxp_imx8.dts')
+        data = self._DoReadFile('vendor/nxp_imx8.dts')
         print('data', len(data))
 
 The ``_DoReadFile()`` function is documented in the code. It returns the image
@@ -573,7 +573,7 @@ In the above example, here are some possible steps:
        def testNxpImx8ImageMkimageMissing(self):
            """Test that binman can produce an iMX8 image"""
            with terminal.capture() as (_, stderr):
-               self._DoTestFile('339_nxp_imx8.dts',
+               self._DoTestFile('vendor/nxp_imx8.dts',
                                 force_missing_bintools='mkimage')
            err = stderr.getvalue()
            self.assertRegex(err, "Image 'image'.*missing bintools.*: mkimage")
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 604efb8b996..f15a9eb01e1 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -1255,7 +1255,7 @@ class TestFunctional(unittest.TestCase):
     def testPackPowerpcMpc85xxBootpgResetvec(self):
         """Test that an image with powerpc-mpc85xx-bootpg-resetvec can be
         created"""
-        data = self._DoReadFile('150_powerpc_mpc85xx_bootpg_resetvec.dts')
+        data = self._DoReadFile('vendor/powerpc_mpc85xx_bootpg_resetvec.dts')
         self.assertEqual(PPC_MPC85XX_BR_DATA, data[:len(PPC_MPC85XX_BR_DATA)])
 
     def _RunMicrocodeTest(self, dts_fname, nodtb_data, ucode_second=False):
@@ -5578,7 +5578,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testPackTiDm(self):
         """Test that an image with a TI DM binary can be created"""
-        data = self._DoReadFile('351_ti_dm.dts')
+        data = self._DoReadFile('vendor/ti_dm.dts')
         self.assertEqual(TI_DM_DATA, data[:len(TI_DM_DATA)])
 
     def testPackBl1(self):
@@ -5588,12 +5588,12 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testRenesasRCarGen4SA0Image(self):
         """Test that binman can produce an Renesas R-Car Gen4 SA0 image"""
-        self._DoTestFile('357_renesas_rcar4_sa0.dts')
+        self._DoTestFile('vendor/renesas_rcar4_sa0.dts')
 
     def testRenesasRCarGen4SA0ImageSize(self):
         """Test that binman can not produce large Renesas R-Car Gen4 SA0 image"""
         with self.assertRaises(ValueError) as exc:
-            self._DoTestFile('358_renesas_rcar4_sa0_size.dts')
+            self._DoTestFile('vendor/renesas_rcar4_sa0_size.dts')
         self.assertIn("Node '/binman/renesas-rcar4-sa0': SRAM data longer than 966656 Bytes",
                       str(exc.exception))
 
@@ -6885,7 +6885,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testPackRockchipTpl(self):
         """Test that an image with a Rockchip TPL binary can be created"""
-        data = self._DoReadFile('291_rockchip_tpl.dts')
+        data = self._DoReadFile('vendor/rockchip_tpl.dts')
         self.assertEqual(ROCKCHIP_TPL_DATA, data[:len(ROCKCHIP_TPL_DATA)])
 
     def testMkimageMissingBlobMultiple(self):
@@ -7175,25 +7175,25 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testTIBoardConfig(self):
         """Test that a schema validated board config file can be generated"""
-        data = self._DoReadFile('293_ti_board_cfg.dts')
+        data = self._DoReadFile('vendor/ti_board_cfg.dts')
         self.assertEqual(TI_BOARD_CONFIG_DATA, data)
 
     def testTIBoardConfigLint(self):
         """Test that an incorrectly linted config file would generate error"""
         with self.assertRaises(ValueError) as e:
-            data = self._DoReadFile('352_ti_board_cfg_phony.dts')
+            data = self._DoReadFile('vendor/ti_board_cfg_phony.dts')
         self.assertIn("Yamllint error", str(e.exception))
 
     def testTIBoardConfigCombined(self):
         """Test that a schema validated combined board config file can be generated"""
-        data = self._DoReadFile('294_ti_board_cfg_combined.dts')
+        data = self._DoReadFile('vendor/ti_board_cfg_combined.dts')
         configlen_noheader = TI_BOARD_CONFIG_DATA * 4
         self.assertGreater(data, configlen_noheader)
 
     def testTIBoardConfigNoDataType(self):
         """Test that error is thrown when data type is not supported"""
         with self.assertRaises(ValueError) as e:
-            data = self._DoReadFile('295_ti_board_cfg_no_type.dts')
+            data = self._DoReadFile('vendor/ti_board_cfg_no_type.dts')
         self.assertIn("Schema validation error", str(e.exception))
 
     def testPackTiSecure(self):
@@ -7202,7 +7202,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         entry_args = {
             'keyfile': keyfile,
         }
-        data = self._DoReadFileDtb('296_ti_secure.dts',
+        data = self._DoReadFileDtb('vendor/ti_secure.dts',
                                    entry_args=entry_args)[0]
         self.assertGreater(len(data), len(TI_UNSECURE_DATA))
 
@@ -7212,9 +7212,9 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         entry_args = {
             'keyfile': keyfile,
         }
-        data_no_firewall = self._DoReadFileDtb('296_ti_secure.dts',
+        data_no_firewall = self._DoReadFileDtb('vendor/ti_secure.dts',
                                    entry_args=entry_args)[0]
-        data_firewall = self._DoReadFileDtb('324_ti_secure_firewall.dts',
+        data_firewall = self._DoReadFileDtb('vendor/ti_secure_firewall.dts',
                                    entry_args=entry_args)[0]
         self.assertGreater(len(data_firewall),len(data_no_firewall))
 
@@ -7225,7 +7225,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             'keyfile': keyfile,
         }
         with self.assertRaises(ValueError) as e:
-            data_firewall = self._DoReadFileDtb('325_ti_secure_firewall_missing_property.dts',
+            data_firewall = self._DoReadFileDtb('vendor/ti_secure_firewall_missing_property.dts',
                                        entry_args=entry_args)[0]
         self.assertRegex(str(e.exception), "Node '/binman/ti-secure': Subnode 'firewall-0-2' is missing properties: id,region")
 
@@ -7237,7 +7237,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             'keyfile': keyfile,
         }
         with terminal.capture() as (_, stderr):
-            self._DoTestFile('296_ti_secure.dts',
+            self._DoTestFile('vendor/ti_secure.dts',
                              force_missing_bintools='openssl',
                              entry_args=entry_args)
         err = stderr.getvalue()
@@ -7249,11 +7249,11 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         entry_args = {
             'keyfile': keyfile,
         }
-        data = self._DoReadFileDtb('297_ti_secure_rom.dts',
+        data = self._DoReadFileDtb('vendor/ti_secure_rom.dts',
                                 entry_args=entry_args)[0]
-        data_a = self._DoReadFileDtb('299_ti_secure_rom_a.dts',
+        data_a = self._DoReadFileDtb('vendor/ti_secure_rom_a.dts',
                                 entry_args=entry_args)[0]
-        data_b = self._DoReadFileDtb('300_ti_secure_rom_b.dts',
+        data_b = self._DoReadFileDtb('vendor/ti_secure_rom_b.dts',
                                 entry_args=entry_args)[0]
         self.assertGreater(len(data), len(TI_UNSECURE_DATA))
         self.assertGreater(len(data_a), len(TI_UNSECURE_DATA))
@@ -7265,7 +7265,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         entry_args = {
             'keyfile': keyfile,
         }
-        data = self._DoReadFileDtb('298_ti_secure_rom_combined.dts',
+        data = self._DoReadFileDtb('vendor/ti_secure_rom_combined.dts',
                                 entry_args=entry_args)[0]
         self.assertGreater(len(data), len(TI_UNSECURE_DATA))
 
@@ -7897,12 +7897,12 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testNxpImx8Image(self):
         """Test that binman can produce an iMX8 image"""
-        self._DoTestFile('339_nxp_imx8.dts')
+        self._DoTestFile('vendor/nxp_imx8.dts')
 
     def testNxpImx8ImageMissing(self):
         """Test that binman produces an iMX8 image if mkimage is missing"""
         with terminal.capture() as (_, stderr):
-            self._DoTestFile('339_nxp_imx8.dts',
+            self._DoTestFile('vendor/nxp_imx8.dts',
                              force_missing_bintools='mkimage')
         err = stderr.getvalue()
         self.assertRegex(err, "Image 'image'.*missing bintools.*: mkimage")
@@ -7910,7 +7910,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testNxpImx8ImagePos(self):
         """Test SetImagePos for iMX8 image"""
         with terminal.capture() as (_, stderr):
-            self._DoTestFile('339_nxp_imx8.dts', update_dtb=True,
+            self._DoTestFile('vendor/nxp_imx8.dts', update_dtb=True,
                              force_missing_bintools='mkimage')
         err = stderr.getvalue()
         self.assertRegex(err, "Image 'image'.*missing bintools.*: mkimage")
@@ -7925,7 +7925,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         ivt_data += b'\x00' * 36
         self._MakeInputFile('imx8m-ivt.bin', ivt_data)
         with terminal.capture() as (_, stderr):
-            self._DoTestFile('364_nxp_imx8_csf.dts',
+            self._DoTestFile('vendor/nxp_imx8_csf.dts',
                              force_missing_bintools='cst')
         err = stderr.getvalue()
         self.assertRegex(err, "Image 'image'.*missing bintools.*: cst")
@@ -7938,7 +7938,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         fit_data += b'\x00' * 60
         self._MakeInputFile('imx8m-fit.bin', fit_data)
         with terminal.capture() as (_, stderr):
-            self._DoTestFile('365_nxp_imx8_csf_fast_auth.dts',
+            self._DoTestFile('vendor/nxp_imx8_csf_fast_auth.dts',
                              force_missing_bintools='cst')
         err = stderr.getvalue()
         self.assertRegex(err, "Image 'image'.*missing bintools.*: cst")
@@ -7948,14 +7948,14 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         # Trigger the pass-through path use data with neither IVT nor FIT magic
         data = b'\x00' * 64
         self._MakeInputFile('imx8m-ivt.bin', data)
-        self._DoTestFile('364_nxp_imx8_csf.dts', force_missing_bintools='cst')
+        self._DoTestFile('vendor/nxp_imx8_csf.dts', force_missing_bintools='cst')
 
     def testNxpImx8ImageSizeNone(self):
         """Test SetImagePos() early return when an entry has no size"""
         # The imagename entry is in GetEntries() but not packed, so has
         # size=None, which triggers the early-return guard in SetImagePos()
         with terminal.capture() as (_, stderr):
-            self._DoTestFile('366_nxp_imx8_imagename.dts',
+            self._DoTestFile('vendor/nxp_imx8_imagename.dts',
                              force_missing_bintools='mkimage')
 
     def testNxpImx8mCSTSigned(self):
@@ -7981,7 +7981,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
         with unittest.mock.patch.object(bintool.Bintool, 'run_cmd',
                                         new=fake_cst_run_cmd):
-            self._DoTestFile('364_nxp_imx8_csf.dts')
+            self._DoTestFile('vendor/nxp_imx8_csf.dts')
 
     def testNxpImx8mCSTBintool(self):
         """Test the cst bintool run() and fetch() methods"""
@@ -8007,7 +8007,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testNxpHeaderDdrfw(self):
         """Test that binman can add a header to DDR PHY firmware images"""
-        data = self._DoReadFile('353_nxp_ddrfw_imx95.dts')
+        data = self._DoReadFile('vendor/nxp_ddrfw_imx95.dts')
         self.assertEqual(len(IMX_LPDDR_IMEM_DATA).to_bytes(4, 'little') +
                          len(IMX_LPDDR_DMEM_DATA).to_bytes(4, 'little') +
                          IMX_LPDDR_IMEM_DATA + IMX_LPDDR_DMEM_DATA, data)
@@ -8022,7 +8022,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         with open(container_path, 'w') as f:
             f.write(bytes([0x87]).decode('latin1') * 32768)
         with terminal.capture():
-            self._DoTestFile('359_nxp_imx95.dts', output_dir=testdir)
+            self._DoTestFile('vendor/nxp_imx95.dts', output_dir=testdir)
 
     def testFitSignSimple(self):
         """Test that image with FIT and signature nodes can be signed"""
diff --git a/tools/binman/test/353_nxp_ddrfw_imx95.dts b/tools/binman/test/vendor/nxp_ddrfw_imx95.dts
similarity index 100%
rename from tools/binman/test/353_nxp_ddrfw_imx95.dts
rename to tools/binman/test/vendor/nxp_ddrfw_imx95.dts
diff --git a/tools/binman/test/339_nxp_imx8.dts b/tools/binman/test/vendor/nxp_imx8.dts
similarity index 100%
rename from tools/binman/test/339_nxp_imx8.dts
rename to tools/binman/test/vendor/nxp_imx8.dts
diff --git a/tools/binman/test/364_nxp_imx8_csf.dts b/tools/binman/test/vendor/nxp_imx8_csf.dts
similarity index 100%
rename from tools/binman/test/364_nxp_imx8_csf.dts
rename to tools/binman/test/vendor/nxp_imx8_csf.dts
diff --git a/tools/binman/test/365_nxp_imx8_csf_fast_auth.dts b/tools/binman/test/vendor/nxp_imx8_csf_fast_auth.dts
similarity index 100%
rename from tools/binman/test/365_nxp_imx8_csf_fast_auth.dts
rename to tools/binman/test/vendor/nxp_imx8_csf_fast_auth.dts
diff --git a/tools/binman/test/366_nxp_imx8_imagename.dts b/tools/binman/test/vendor/nxp_imx8_imagename.dts
similarity index 100%
rename from tools/binman/test/366_nxp_imx8_imagename.dts
rename to tools/binman/test/vendor/nxp_imx8_imagename.dts
diff --git a/tools/binman/test/359_nxp_imx95.dts b/tools/binman/test/vendor/nxp_imx95.dts
similarity index 100%
rename from tools/binman/test/359_nxp_imx95.dts
rename to tools/binman/test/vendor/nxp_imx95.dts
diff --git a/tools/binman/test/150_powerpc_mpc85xx_bootpg_resetvec.dts b/tools/binman/test/vendor/powerpc_mpc85xx_bootpg_resetvec.dts
similarity index 100%
rename from tools/binman/test/150_powerpc_mpc85xx_bootpg_resetvec.dts
rename to tools/binman/test/vendor/powerpc_mpc85xx_bootpg_resetvec.dts
diff --git a/tools/binman/test/357_renesas_rcar4_sa0.dts b/tools/binman/test/vendor/renesas_rcar4_sa0.dts
similarity index 100%
rename from tools/binman/test/357_renesas_rcar4_sa0.dts
rename to tools/binman/test/vendor/renesas_rcar4_sa0.dts
diff --git a/tools/binman/test/358_renesas_rcar4_sa0_size.dts b/tools/binman/test/vendor/renesas_rcar4_sa0_size.dts
similarity index 100%
rename from tools/binman/test/358_renesas_rcar4_sa0_size.dts
rename to tools/binman/test/vendor/renesas_rcar4_sa0_size.dts
diff --git a/tools/binman/test/291_rockchip_tpl.dts b/tools/binman/test/vendor/rockchip_tpl.dts
similarity index 100%
rename from tools/binman/test/291_rockchip_tpl.dts
rename to tools/binman/test/vendor/rockchip_tpl.dts
diff --git a/tools/binman/test/293_ti_board_cfg.dts b/tools/binman/test/vendor/ti_board_cfg.dts
similarity index 100%
rename from tools/binman/test/293_ti_board_cfg.dts
rename to tools/binman/test/vendor/ti_board_cfg.dts
diff --git a/tools/binman/test/294_ti_board_cfg_combined.dts b/tools/binman/test/vendor/ti_board_cfg_combined.dts
similarity index 100%
rename from tools/binman/test/294_ti_board_cfg_combined.dts
rename to tools/binman/test/vendor/ti_board_cfg_combined.dts
diff --git a/tools/binman/test/295_ti_board_cfg_no_type.dts b/tools/binman/test/vendor/ti_board_cfg_no_type.dts
similarity index 100%
rename from tools/binman/test/295_ti_board_cfg_no_type.dts
rename to tools/binman/test/vendor/ti_board_cfg_no_type.dts
diff --git a/tools/binman/test/352_ti_board_cfg_phony.dts b/tools/binman/test/vendor/ti_board_cfg_phony.dts
similarity index 100%
rename from tools/binman/test/352_ti_board_cfg_phony.dts
rename to tools/binman/test/vendor/ti_board_cfg_phony.dts
diff --git a/tools/binman/test/351_ti_dm.dts b/tools/binman/test/vendor/ti_dm.dts
similarity index 100%
rename from tools/binman/test/351_ti_dm.dts
rename to tools/binman/test/vendor/ti_dm.dts
diff --git a/tools/binman/test/296_ti_secure.dts b/tools/binman/test/vendor/ti_secure.dts
similarity index 100%
rename from tools/binman/test/296_ti_secure.dts
rename to tools/binman/test/vendor/ti_secure.dts
diff --git a/tools/binman/test/324_ti_secure_firewall.dts b/tools/binman/test/vendor/ti_secure_firewall.dts
similarity index 100%
rename from tools/binman/test/324_ti_secure_firewall.dts
rename to tools/binman/test/vendor/ti_secure_firewall.dts
diff --git a/tools/binman/test/325_ti_secure_firewall_missing_property.dts b/tools/binman/test/vendor/ti_secure_firewall_missing_property.dts
similarity index 100%
rename from tools/binman/test/325_ti_secure_firewall_missing_property.dts
rename to tools/binman/test/vendor/ti_secure_firewall_missing_property.dts
diff --git a/tools/binman/test/297_ti_secure_rom.dts b/tools/binman/test/vendor/ti_secure_rom.dts
similarity index 100%
rename from tools/binman/test/297_ti_secure_rom.dts
rename to tools/binman/test/vendor/ti_secure_rom.dts
diff --git a/tools/binman/test/299_ti_secure_rom_a.dts b/tools/binman/test/vendor/ti_secure_rom_a.dts
similarity index 100%
rename from tools/binman/test/299_ti_secure_rom_a.dts
rename to tools/binman/test/vendor/ti_secure_rom_a.dts
diff --git a/tools/binman/test/300_ti_secure_rom_b.dts b/tools/binman/test/vendor/ti_secure_rom_b.dts
similarity index 100%
rename from tools/binman/test/300_ti_secure_rom_b.dts
rename to tools/binman/test/vendor/ti_secure_rom_b.dts
diff --git a/tools/binman/test/298_ti_secure_rom_combined.dts b/tools/binman/test/vendor/ti_secure_rom_combined.dts
similarity index 100%
rename from tools/binman/test/298_ti_secure_rom_combined.dts
rename to tools/binman/test/vendor/ti_secure_rom_combined.dts
-- 
2.43.0

