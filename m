Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D76FCC050
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 18:15:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FE8E8401F;
	Fri,  6 Mar 2026 19:14:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AGLOxCtg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 089EC83F2D; Fri,  6 Mar 2026 19:14:09 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C232484006
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 19:14:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-8cb3e22435fso829868385a.1
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 10:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772820842; x=1773425642; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EAvdrDE6dAqiLp7Ewhdj0/pvhH6lVHS9v8BK2g0ZopA=;
 b=AGLOxCtgyIsIDn5wQBjDE2pzuuiSVCxh3nMi0tV9EgV5ylMBxwjlPkLwcdrmFvQe+Y
 XqKRGSiyzN4NntJijc8BhUluZB+caUOLqGUIdGA5kDtxHEKuwQ/RMEkG7XSkd2WosTib
 UtKtG4nrWpfobmdxxYAkT0T26CoAaNRXejM1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772820842; x=1773425642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EAvdrDE6dAqiLp7Ewhdj0/pvhH6lVHS9v8BK2g0ZopA=;
 b=jdFCm9DTSCuWErAQHlrEbvhbXmjFB59TssXgSC8/e9v3jeWzBdksR3tLDVyLibKdfn
 I11ehS+aotkzira8XQrXuA/OzwsNP2r57K4uz1ytKSk/2MbpvH7083BgybsGIW98fEWQ
 WFbfHKpSeUU/RKs06V1QgLWaN3U/E+bAskRmyfwRUuuAYIbOBZf1ht7vztnCxc8bnS2w
 0ibVQR6ywGlEg+1kelFQbi/YNuAml/QcnH4R40LBVuVo+orZbxs5WpYuHLdDL6Ly012y
 ha2tsSbru1pWNdLuYsUIqutECkY8a+payQm0y2xw0UGOkzamj5n/n7F65DLE4m/+qMPM
 msIw==
X-Gm-Message-State: AOJu0YwSRPdTS9hKTrriASSwXnGx4UQf08kD4yZAvemgEIxN8QtggPn9
 2QtLgUjxffAWXtYV/QBu2uTf68wDu53OcZopnqDlCShamk2K/mdB0zKZeQT4SNN2jLY6xXeVgVj
 3dSw=
X-Gm-Gg: ATEYQzxxE5zFEvkQIbvIT3dv2TerLMBFrpnVtBsJ69Nkulc5wHnz0LiTJJFBC5tx7kX
 xobb7gPy08xgBNob/EU2kODdSce5MCgEm++xVSRV1efbU+HYKMa3Y7skc2B670pUheqRm4y/Fxf
 2PhvuuYpClReAHOn2iltKI8mggEUvvy9SOwp6kOL+3LOqetolLE109uYTm9sDyqAqAkr9Z0iFYV
 1Ptp4b4lMwLkbJJRe4e4JIL7Ek7jamJ2YzYbz51K3QyPlkIkiOWhoo4zbDRoL1IzFK64p0LOath
 9ma5ku9hwhqGs7/u8Hr0BwSe9ejGSC1aul4cLwL5MRYKnaXrMBc2srCBJiQx+RaYnxXIb/flAdN
 Y2vUKzKxQqM/33VDPXx4kju8F31BL+ZxONM2qxaKUxi476R18x8URxnR+iwptaZJFOy92/7eHr8
 xOCHtmJDWebMRbvq3hfA==
X-Received: by 2002:a05:620a:708d:b0:8c9:f4ed:c33e with SMTP id
 af79cd13be357-8cd6dbf32eamr346929485a.18.1772820842017; 
 Fri, 06 Mar 2026 10:14:02 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f5736c0sm155930885a.49.2026.03.06.10.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 10:14:01 -0800 (PST)
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
Subject: [PATCH v2 14/23] binman: test: Move vendor-specific test files to
 test/vendor/
Date: Fri,  6 Mar 2026 11:12:42 -0700
Message-ID: <20260306181304.2426352-15-sjg@chromium.org>
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

Move about 20 test files for vendor-specific platform support (TI, NXP
i.MX, Renesas R-Car, Rockchip, PowerPC MPC85xx) into a vendor/
subdirectory. Drop the numeric prefixes and update all references.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

Changes in v2:
- Move doc-reference updates from the doc patch into this patch

 doc/develop/binman_tests.rst                  | 12 ++---
 tools/binman/ftest.py                         | 44 +++++++++----------
 .../nxp_ddrfw_imx95.dts}                      |  0
 .../{339_nxp_imx8.dts => vendor/nxp_imx8.dts} |  0
 .../nxp_imx95.dts}                            |  0
 .../powerpc_mpc85xx_bootpg_resetvec.dts}      |  0
 .../renesas_rcar4_sa0.dts}                    |  0
 .../renesas_rcar4_sa0_size.dts}               |  0
 .../rockchip_tpl.dts}                         |  0
 .../ti_board_cfg.dts}                         |  0
 .../ti_board_cfg_combined.dts}                |  0
 .../ti_board_cfg_no_type.dts}                 |  0
 .../ti_board_cfg_phony.dts}                   |  0
 .../test/{225_ti_dm.dts => vendor/ti_dm.dts}  |  0
 .../ti_secure.dts}                            |  0
 .../ti_secure_firewall.dts}                   |  0
 .../ti_secure_firewall_missing_property.dts}  |  0
 .../ti_secure_rom.dts}                        |  0
 .../ti_secure_rom_a.dts}                      |  0
 .../ti_secure_rom_b.dts}                      |  0
 .../ti_secure_rom_combined.dts}               |  0
 21 files changed, 28 insertions(+), 28 deletions(-)
 rename tools/binman/test/{346_nxp_ddrfw_imx95.dts => vendor/nxp_ddrfw_imx95.dts} (100%)
 rename tools/binman/test/{339_nxp_imx8.dts => vendor/nxp_imx8.dts} (100%)
 rename tools/binman/test/{350_nxp_imx95.dts => vendor/nxp_imx95.dts} (100%)
 rename tools/binman/test/{150_powerpc_mpc85xx_bootpg_resetvec.dts => vendor/powerpc_mpc85xx_bootpg_resetvec.dts} (100%)
 rename tools/binman/test/{348_renesas_rcar4_sa0.dts => vendor/renesas_rcar4_sa0.dts} (100%)
 rename tools/binman/test/{349_renesas_rcar4_sa0_size.dts => vendor/renesas_rcar4_sa0_size.dts} (100%)
 rename tools/binman/test/{291_rockchip_tpl.dts => vendor/rockchip_tpl.dts} (100%)
 rename tools/binman/test/{293_ti_board_cfg.dts => vendor/ti_board_cfg.dts} (100%)
 rename tools/binman/test/{294_ti_board_cfg_combined.dts => vendor/ti_board_cfg_combined.dts} (100%)
 rename tools/binman/test/{295_ti_board_cfg_no_type.dts => vendor/ti_board_cfg_no_type.dts} (100%)
 rename tools/binman/test/{323_ti_board_cfg_phony.dts => vendor/ti_board_cfg_phony.dts} (100%)
 rename tools/binman/test/{225_ti_dm.dts => vendor/ti_dm.dts} (100%)
 rename tools/binman/test/{296_ti_secure.dts => vendor/ti_secure.dts} (100%)
 rename tools/binman/test/{324_ti_secure_firewall.dts => vendor/ti_secure_firewall.dts} (100%)
 rename tools/binman/test/{325_ti_secure_firewall_missing_property.dts => vendor/ti_secure_firewall_missing_property.dts} (100%)
 rename tools/binman/test/{297_ti_secure_rom.dts => vendor/ti_secure_rom.dts} (100%)
 rename tools/binman/test/{299_ti_secure_rom_a.dts => vendor/ti_secure_rom_a.dts} (100%)
 rename tools/binman/test/{300_ti_secure_rom_b.dts => vendor/ti_secure_rom_b.dts} (100%)
 rename tools/binman/test/{298_ti_secure_rom_combined.dts => vendor/ti_secure_rom_combined.dts} (100%)

diff --git a/doc/develop/binman_tests.rst b/doc/develop/binman_tests.rst
index c7fa9ae6199..3be7d43cd3f 100644
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
@@ -610,7 +610,7 @@ In the above example, here are some possible steps:
 
         Entry_section.SetImagePos(self, image_pos)
 
-   The solution is to add an entry, e.g. in ``340_nxp_imx8_non_empty.dts``:
+   The solution is to add an entry, e.g. in ``vendor/nxp_imx8_non_empty.dts``:
 
    .. code-block:: devicetree
 
@@ -641,7 +641,7 @@ In the above example, here are some possible steps:
 
        def testNxpImx8ImageNonEmpty(self):
            """Test that binman can produce an iMX8 image with something in it"""
-            data = self._DoReadFile('340_nxp_imx8_non_empty.dts')
+            data = self._DoReadFile('vendor/nxp_imx8_non_empty.dts')
             # check data here
 
    With that, the second red bit goes away, because the for() loop is now used.
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 43292941576..3743071eb85 100644
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
@@ -2130,7 +2130,7 @@ class TestFunctional(unittest.TestCase):
 
             # Unfortunately, compiling a source file always results in a file
             # called source.dtb (see fdt_util.EnsureCompiled()). The test
-            # source file (e.g. test/075_fdt_update_all.dts) thus does not enter
+            # source file (e.g. test/fdt/fdt_update_all.dts) thus does not enter
             # binman as a file called u-boot.dtb. To fix this, copy the file
             # over to the expected place.
             start = 0
@@ -5578,7 +5578,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testPackTiDm(self):
         """Test that an image with a TI DM binary can be created"""
-        data = self._DoReadFile('225_ti_dm.dts')
+        data = self._DoReadFile('vendor/ti_dm.dts')
         self.assertEqual(TI_DM_DATA, data[:len(TI_DM_DATA)])
 
     def testPackBl1(self):
@@ -5588,12 +5588,12 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testRenesasRCarGen4SA0Image(self):
         """Test that binman can produce an Renesas R-Car Gen4 SA0 image"""
-        self._DoTestFile('348_renesas_rcar4_sa0.dts')
+        self._DoTestFile('vendor/renesas_rcar4_sa0.dts')
 
     def testRenesasRCarGen4SA0ImageSize(self):
         """Test that binman can not produce large Renesas R-Car Gen4 SA0 image"""
         with self.assertRaises(ValueError) as exc:
-            self._DoTestFile('349_renesas_rcar4_sa0_size.dts')
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
-            data = self._DoReadFile('323_ti_board_cfg_phony.dts')
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
 
@@ -7897,11 +7897,11 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testNxpImx8Image(self):
         """Test that binman can produce an iMX8 image"""
-        self._DoTestFile('339_nxp_imx8.dts')
+        self._DoTestFile('vendor/nxp_imx8.dts')
 
     def testNxpHeaderDdrfw(self):
         """Test that binman can add a header to DDR PHY firmware images"""
-        data = self._DoReadFile('346_nxp_ddrfw_imx95.dts')
+        data = self._DoReadFile('vendor/nxp_ddrfw_imx95.dts')
         self.assertEqual(len(IMX_LPDDR_IMEM_DATA).to_bytes(4, 'little') +
                          len(IMX_LPDDR_DMEM_DATA).to_bytes(4, 'little') +
                          IMX_LPDDR_IMEM_DATA + IMX_LPDDR_DMEM_DATA, data)
@@ -7916,7 +7916,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         with open(container_path, 'w') as f:
             f.write(bytes([0x87]).decode('latin1') * 32768)
         with terminal.capture():
-            self._DoTestFile('350_nxp_imx95.dts', output_dir=testdir)
+            self._DoTestFile('vendor/nxp_imx95.dts', output_dir=testdir)
 
     def testFitSignSimple(self):
         """Test that image with FIT and signature nodes can be signed"""
diff --git a/tools/binman/test/346_nxp_ddrfw_imx95.dts b/tools/binman/test/vendor/nxp_ddrfw_imx95.dts
similarity index 100%
rename from tools/binman/test/346_nxp_ddrfw_imx95.dts
rename to tools/binman/test/vendor/nxp_ddrfw_imx95.dts
diff --git a/tools/binman/test/339_nxp_imx8.dts b/tools/binman/test/vendor/nxp_imx8.dts
similarity index 100%
rename from tools/binman/test/339_nxp_imx8.dts
rename to tools/binman/test/vendor/nxp_imx8.dts
diff --git a/tools/binman/test/350_nxp_imx95.dts b/tools/binman/test/vendor/nxp_imx95.dts
similarity index 100%
rename from tools/binman/test/350_nxp_imx95.dts
rename to tools/binman/test/vendor/nxp_imx95.dts
diff --git a/tools/binman/test/150_powerpc_mpc85xx_bootpg_resetvec.dts b/tools/binman/test/vendor/powerpc_mpc85xx_bootpg_resetvec.dts
similarity index 100%
rename from tools/binman/test/150_powerpc_mpc85xx_bootpg_resetvec.dts
rename to tools/binman/test/vendor/powerpc_mpc85xx_bootpg_resetvec.dts
diff --git a/tools/binman/test/348_renesas_rcar4_sa0.dts b/tools/binman/test/vendor/renesas_rcar4_sa0.dts
similarity index 100%
rename from tools/binman/test/348_renesas_rcar4_sa0.dts
rename to tools/binman/test/vendor/renesas_rcar4_sa0.dts
diff --git a/tools/binman/test/349_renesas_rcar4_sa0_size.dts b/tools/binman/test/vendor/renesas_rcar4_sa0_size.dts
similarity index 100%
rename from tools/binman/test/349_renesas_rcar4_sa0_size.dts
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
diff --git a/tools/binman/test/323_ti_board_cfg_phony.dts b/tools/binman/test/vendor/ti_board_cfg_phony.dts
similarity index 100%
rename from tools/binman/test/323_ti_board_cfg_phony.dts
rename to tools/binman/test/vendor/ti_board_cfg_phony.dts
diff --git a/tools/binman/test/225_ti_dm.dts b/tools/binman/test/vendor/ti_dm.dts
similarity index 100%
rename from tools/binman/test/225_ti_dm.dts
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

