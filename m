Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C01FCC055
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 18:14:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 632DC83F9B;
	Fri,  6 Mar 2026 19:13:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SHFDTNri";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 827568382A; Fri,  6 Mar 2026 19:13:42 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39C5683F9A
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 19:13:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-8cd767d2d70so4727785a.3
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 10:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772820817; x=1773425617; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1uJGiejNaioerAwi/eBkP1ZoMpaqS7hajo7uvYuH3ak=;
 b=SHFDTNrisXJNNnR2iSElkDYhaiOHrU17sFUztbjXCa7zkbhQEdX79nmK/sTgm6jV0D
 qEK+1h+eOZVlK4tD2lqlK12YNakUI5Lm3dWCHa7Jh2MZkq2FR4uE0nmbudc9sXXcAVVN
 gRh9AOUO4IkUu5nPXYc0PC1AYsVIAs0As/wB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772820817; x=1773425617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1uJGiejNaioerAwi/eBkP1ZoMpaqS7hajo7uvYuH3ak=;
 b=TdrId/pxTz5+4MJdGq1neCycyvUPVUetPNNX995NWaXKnDu7rctAojEXCa4iwOxW9R
 8bFFcLiZ1U5y5j6yST+W4zjO2ucsb40+QRe6X0KlkgUwZyVHgpdHVG34WmFThgqSJVVo
 ynr937j/BKFRiiN0Wf/1g+37UO6Mujz1GvtUORxE/y0i3+b4vUV/cOQWRu+8D2ccff5c
 9+mrPA9yIopTYa1N5BF3t6VOUX+DqZ98hZAZeXPN1D2o+wSFrs9gS8xNS/TLLf+jIs7r
 kFsPzMP5kO/3aKpYsRLELeOsM3vQ/rS5Vmn0SRCsLLWwTgpmNkASXOLy0eWyt6tNB0TH
 hDIQ==
X-Gm-Message-State: AOJu0YxEQqDQ0weTcPqMHEuKOq5AMuGoZRAJ2jw2AByZliHzlTaOdum0
 i5trN7DpOvbVIH31D/ly9ul5T+DyMaMnC/dR9knOEFC3ycBNT2uUgiScAM3cr+0CeAMXPV6CY7F
 lHCc=
X-Gm-Gg: ATEYQzxSS5ivZKsFxfOpISDwzLnhB3MpHfwYTqKM8pKE6R9TM9OUMcszYcqVQpJw+zB
 OY6RTw2Xu+56E4NUURZJoSDmm0B+1YRHNJre4lirdw9IJ62KIWiT0iM6XG4VDstX86m0rlQQ5bF
 WLby1oreLbj01mNNYflAAbLdvT+338RbjBBCLyJP1hwUJNTRPiaYOryPtOByVB7A8lyxyLSHIZe
 Fbiu/e+O9nYUrFKhUc4WIhrf3E74xGcG6fu8+/YR5ul9LCRFW5OU+bpRFfXcWtQxuLTadd49ByK
 XtzT+zyAUbwMMl4tPyraZu1clZEI66+gMTWs1Q/b3H5zX5rax6CVgTAw2ShtNpgHfQeO7odfZ+W
 4Ulu3cNlwNLlMj7LET2TwMDj0MdB0BOZEXzfDr8qUf3F41evPGmIChOPqXcP9zFuQvBpa+1v3HJ
 wep9B8k6vRM/1NXsA2dA==
X-Received: by 2002:a05:620a:4589:b0:8c9:ea05:d15a with SMTP id
 af79cd13be357-8cd6d1e63dcmr426676985a.0.1772820817155; 
 Fri, 06 Mar 2026 10:13:37 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f5736c0sm155930885a.49.2026.03.06.10.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 10:13:36 -0800 (PST)
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
Subject: [PATCH v2 04/23] binman: test: Move x86 and Intel test files to
 test/x86/
Date: Fri,  6 Mar 2026 11:12:32 -0700
Message-ID: <20260306181304.2426352-5-sjg@chromium.org>
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

Move about 40 test files for x86 and Intel platform support (ROM,
microcode, ME, IFWI, FSP, descriptor, reset16, start16, FIT) into an
x86/ subdirectory. Drop the numeric prefixes and the redundant x86_
filename prefix, and update all references.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v1)

 tools/binman/fdt_test.py                      |  2 +-
 tools/binman/ftest.py                         | 84 +++++++++----------
 .../descriptor_offset.dts}                    |  0
 .../test/{094_fmap_x86.dts => x86/fmap.dts}   |  0
 .../fmap_section.dts}                         |  0
 .../{043_intel_cmc.dts => x86/intel_cmc.dts}  |  0
 .../{147_intel_fit.dts => x86/intel_fit.dts}  |  0
 .../intel_fit_missing.dts}                    |  0
 .../{042_intel_fsp.dts => x86/intel_fsp.dts}  |  0
 .../intel_fsp_m.dts}                          |  0
 .../intel_fsp_s.dts}                          |  0
 .../intel_fsp_t.dts}                          |  0
 .../{050_intel_mrc.dts => x86/intel_mrc.dts}  |  0
 .../intel_refcode.dts}                        |  0
 .../{046_intel_vbt.dts => x86/intel_vbt.dts}  |  0
 .../{032_intel_vga.dts => x86/intel_vga.dts}  |  0
 .../no_ucode.dts}                             |  0
 .../optional_ucode.dts}                       |  0
 .../{144_x86_reset16.dts => x86/reset16.dts}  |  0
 .../reset16_spl.dts}                          |  0
 .../reset16_tpl.dts}                          |  0
 .../test/{029_x86_rom.dts => x86/rom.dts}     |  0
 .../rom_ifwi.dts}                             |  0
 .../rom_ifwi_nodata.dts}                      |  0
 .../rom_ifwi_nodesc.dts}                      |  0
 .../rom_ifwi_section.dts}                     |  0
 .../{031_x86_rom_me.dts => x86/rom_me.dts}    |  0
 .../rom_me_empty.dts}                         |  0
 .../rom_me_missing.dts}                       |  0
 .../rom_me_no_desc.dts}                       |  0
 .../single_ucode.dts}                         |  0
 .../{033_x86_start16.dts => x86/start16.dts}  |  0
 .../start16_spl.dts}                          |  0
 .../start16_tpl.dts}                          |  0
 .../symbols_tpl.dts}                          |  0
 .../tpl_ucode.dts}                            |  0
 .../test/{034_x86_ucode.dts => x86/ucode.dts} |  0
 .../ucode_missing_node.dts}                   |  0
 .../ucode_missing_node2.dts}                  |  0
 .../ucode_not_in_image.dts}                   |  0
 .../ucode_spl.dts}                            |  0
 .../ucode_spl_needs_retry.dts}                |  0
 42 files changed, 43 insertions(+), 43 deletions(-)
 rename tools/binman/test/{141_descriptor_offset.dts => x86/descriptor_offset.dts} (100%)
 rename tools/binman/test/{094_fmap_x86.dts => x86/fmap.dts} (100%)
 rename tools/binman/test/{095_fmap_x86_section.dts => x86/fmap_section.dts} (100%)
 rename tools/binman/test/{043_intel_cmc.dts => x86/intel_cmc.dts} (100%)
 rename tools/binman/test/{147_intel_fit.dts => x86/intel_fit.dts} (100%)
 rename tools/binman/test/{148_intel_fit_missing.dts => x86/intel_fit_missing.dts} (100%)
 rename tools/binman/test/{042_intel_fsp.dts => x86/intel_fsp.dts} (100%)
 rename tools/binman/test/{152_intel_fsp_m.dts => x86/intel_fsp_m.dts} (100%)
 rename tools/binman/test/{153_intel_fsp_s.dts => x86/intel_fsp_s.dts} (100%)
 rename tools/binman/test/{154_intel_fsp_t.dts => x86/intel_fsp_t.dts} (100%)
 rename tools/binman/test/{050_intel_mrc.dts => x86/intel_mrc.dts} (100%)
 rename tools/binman/test/{100_intel_refcode.dts => x86/intel_refcode.dts} (100%)
 rename tools/binman/test/{046_intel_vbt.dts => x86/intel_vbt.dts} (100%)
 rename tools/binman/test/{032_intel_vga.dts => x86/intel_vga.dts} (100%)
 rename tools/binman/test/{037_x86_no_ucode.dts => x86/no_ucode.dts} (100%)
 rename tools/binman/test/{044_x86_optional_ucode.dts => x86/optional_ucode.dts} (100%)
 rename tools/binman/test/{144_x86_reset16.dts => x86/reset16.dts} (100%)
 rename tools/binman/test/{145_x86_reset16_spl.dts => x86/reset16_spl.dts} (100%)
 rename tools/binman/test/{146_x86_reset16_tpl.dts => x86/reset16_tpl.dts} (100%)
 rename tools/binman/test/{029_x86_rom.dts => x86/rom.dts} (100%)
 rename tools/binman/test/{111_x86_rom_ifwi.dts => x86/rom_ifwi.dts} (100%)
 rename tools/binman/test/{113_x86_rom_ifwi_nodata.dts => x86/rom_ifwi_nodata.dts} (100%)
 rename tools/binman/test/{112_x86_rom_ifwi_nodesc.dts => x86/rom_ifwi_nodesc.dts} (100%)
 rename tools/binman/test/{151_x86_rom_ifwi_section.dts => x86/rom_ifwi_section.dts} (100%)
 rename tools/binman/test/{031_x86_rom_me.dts => x86/rom_me.dts} (100%)
 rename tools/binman/test/{163_x86_rom_me_empty.dts => x86/rom_me_empty.dts} (100%)
 rename tools/binman/test/{164_x86_rom_me_missing.dts => x86/rom_me_missing.dts} (100%)
 rename tools/binman/test/{030_x86_rom_me_no_desc.dts => x86/rom_me_no_desc.dts} (100%)
 rename tools/binman/test/{035_x86_single_ucode.dts => x86/single_ucode.dts} (100%)
 rename tools/binman/test/{033_x86_start16.dts => x86/start16.dts} (100%)
 rename tools/binman/test/{048_x86_start16_spl.dts => x86/start16_spl.dts} (100%)
 rename tools/binman/test/{081_x86_start16_tpl.dts => x86/start16_tpl.dts} (100%)
 rename tools/binman/test/{155_symbols_tpl_x86.dts => x86/symbols_tpl.dts} (100%)
 rename tools/binman/test/{093_x86_tpl_ucode.dts => x86/tpl_ucode.dts} (100%)
 rename tools/binman/test/{034_x86_ucode.dts => x86/ucode.dts} (100%)
 rename tools/binman/test/{038_x86_ucode_missing_node.dts => x86/ucode_missing_node.dts} (100%)
 rename tools/binman/test/{039_x86_ucode_missing_node2.dts => x86/ucode_missing_node2.dts} (100%)
 rename tools/binman/test/{040_x86_ucode_not_in_image.dts => x86/ucode_not_in_image.dts} (100%)
 rename tools/binman/test/{049_x86_ucode_spl.dts => x86/ucode_spl.dts} (100%)
 rename tools/binman/test/{058_x86_ucode_spl_needs_retry.dts => x86/ucode_spl_needs_retry.dts} (100%)

diff --git a/tools/binman/fdt_test.py b/tools/binman/fdt_test.py
index 564c1770820..ef659c0f276 100644
--- a/tools/binman/fdt_test.py
+++ b/tools/binman/fdt_test.py
@@ -36,7 +36,7 @@ class TestFdt(unittest.TestCase):
         node.DeleteProp('data')
 
     def testFdtNormal(self):
-        fname = self.GetCompiled('034_x86_ucode.dts')
+        fname = self.GetCompiled('x86/ucode.dts')
         dt = FdtScan(fname)
         self._DeleteProp(dt)
 
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 7f02bffc0a9..ac944f507f9 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -1211,7 +1211,7 @@ class TestFunctional(unittest.TestCase):
     def testPackX86Rom(self):
         """Test that a basic x86 ROM can be created"""
         self._SetupSplElf()
-        data = self._DoReadFile('029_x86_rom.dts')
+        data = self._DoReadFile('x86/rom.dts')
         self.assertEqual(U_BOOT_DATA + tools.get_bytes(0, 3) + U_BOOT_SPL_DATA +
                          tools.get_bytes(0, 2), data)
 
@@ -1220,7 +1220,7 @@ class TestFunctional(unittest.TestCase):
         try:
             TestFunctional._MakeInputFile('descriptor-empty.bin', b'')
             with self.assertRaises(ValueError) as e:
-                self._DoTestFile('163_x86_rom_me_empty.dts')
+                self._DoTestFile('x86/rom_me_empty.dts')
             self.assertIn("Node '/binman/intel-descriptor': Cannot find Intel Flash Descriptor (FD) signature",
                           str(e.exception))
         finally:
@@ -1229,14 +1229,14 @@ class TestFunctional(unittest.TestCase):
     def testPackX86RomBadDesc(self):
         """Test that the Intel requires a descriptor entry"""
         with self.assertRaises(ValueError) as e:
-            self._DoTestFile('030_x86_rom_me_no_desc.dts')
+            self._DoTestFile('x86/rom_me_no_desc.dts')
         self.assertIn("Node '/binman/intel-me': No offset set with "
                       "offset-unset: should another entry provide this correct "
                       "offset?", str(e.exception))
 
     def testPackX86RomMe(self):
         """Test that an x86 ROM with an ME region can be created"""
-        data = self._DoReadFile('031_x86_rom_me.dts')
+        data = self._DoReadFile('x86/rom_me.dts')
         expected_desc = tools.read_file(self.TestFile('descriptor.bin'))
         if data[:0x1000] != expected_desc:
             self.fail('Expected descriptor binary at start of image')
@@ -1244,12 +1244,12 @@ class TestFunctional(unittest.TestCase):
 
     def testPackVga(self):
         """Test that an image with a VGA binary can be created"""
-        data = self._DoReadFile('032_intel_vga.dts')
+        data = self._DoReadFile('x86/intel_vga.dts')
         self.assertEqual(VGA_DATA, data[:len(VGA_DATA)])
 
     def testPackStart16(self):
         """Test that an image with an x86 start16 region can be created"""
-        data = self._DoReadFile('033_x86_start16.dts')
+        data = self._DoReadFile('x86/start16.dts')
         self.assertEqual(X86_START16_DATA, data[:len(X86_START16_DATA)])
 
     def testPackPowerpcMpc85xxBootpgResetvec(self):
@@ -1318,7 +1318,7 @@ class TestFunctional(unittest.TestCase):
             u-boot.dtb with the microcode removed
             the microcode
         """
-        first, pos_and_size = self._RunMicrocodeTest('034_x86_ucode.dts',
+        first, pos_and_size = self._RunMicrocodeTest('x86/ucode.dts',
                                                      U_BOOT_NODTB_DATA)
         self.assertEqual(b'nodtb with microcode' + pos_and_size +
                          b' somewhere in here', first)
@@ -1335,7 +1335,7 @@ class TestFunctional(unittest.TestCase):
         # We need the libfdt library to run this test since only that allows
         # finding the offset of a property. This is required by
         # Entry_u_boot_dtb_with_ucode.ObtainContents().
-        data = self._DoReadFile('035_x86_single_ucode.dts', True)
+        data = self._DoReadFile('x86/single_ucode.dts', True)
 
         second = data[len(U_BOOT_NODTB_DATA):]
 
@@ -1368,21 +1368,21 @@ class TestFunctional(unittest.TestCase):
     def testNoMicrocode(self):
         """Test that a missing microcode region is detected"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('037_x86_no_ucode.dts', True)
+            self._DoReadFile('x86/no_ucode.dts', True)
         self.assertIn("Node '/binman/u-boot-dtb-with-ucode': No /microcode "
                       "node found in ", str(e.exception))
 
     def testMicrocodeWithoutNode(self):
         """Test that a missing u-boot-dtb-with-ucode node is detected"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('038_x86_ucode_missing_node.dts', True)
+            self._DoReadFile('x86/ucode_missing_node.dts', True)
         self.assertIn("Node '/binman/u-boot-with-ucode-ptr': Cannot find "
                 "microcode region u-boot-dtb-with-ucode", str(e.exception))
 
     def testMicrocodeWithoutNode2(self):
         """Test that a missing u-boot-ucode node is detected"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('039_x86_ucode_missing_node2.dts', True)
+            self._DoReadFile('x86/ucode_missing_node2.dts', True)
         self.assertIn("Node '/binman/u-boot-with-ucode-ptr': Cannot find "
             "microcode region u-boot-ucode", str(e.exception))
 
@@ -1406,7 +1406,7 @@ class TestFunctional(unittest.TestCase):
     def testMicrocodeNotInImage(self):
         """Test that microcode must be placed within the image"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('040_x86_ucode_not_in_image.dts', True)
+            self._DoReadFile('x86/ucode_not_in_image.dts', True)
         self.assertIn("Node '/binman/u-boot-with-ucode-ptr': Microcode "
                 "pointer _dt_ucode_base_size at fffffe14 is outside the "
                 "section ranging from 00000000 to 0000002e", str(e.exception))
@@ -1415,7 +1415,7 @@ class TestFunctional(unittest.TestCase):
         """Test that we can cope with an image without microcode (e.g. qemu)"""
         TestFunctional._MakeInputFile('u-boot',
             tools.read_file(self.ElfTestFile('u_boot_no_ucode_ptr')))
-        data, dtb, _, _ = self._DoReadFileDtb('044_x86_optional_ucode.dts', True)
+        data, dtb, _, _ = self._DoReadFileDtb('x86/optional_ucode.dts', True)
 
         # Now check the device tree has no microcode
         self.assertEqual(U_BOOT_NODTB_DATA, data[:len(U_BOOT_NODTB_DATA)])
@@ -1437,17 +1437,17 @@ class TestFunctional(unittest.TestCase):
 
     def testPackFsp(self):
         """Test that an image with a FSP binary can be created"""
-        data = self._DoReadFile('042_intel_fsp.dts')
+        data = self._DoReadFile('x86/intel_fsp.dts')
         self.assertEqual(FSP_DATA, data[:len(FSP_DATA)])
 
     def testPackCmc(self):
         """Test that an image with a CMC binary can be created"""
-        data = self._DoReadFile('043_intel_cmc.dts')
+        data = self._DoReadFile('x86/intel_cmc.dts')
         self.assertEqual(CMC_DATA, data[:len(CMC_DATA)])
 
     def testPackVbt(self):
         """Test that an image with a VBT binary can be created"""
-        data = self._DoReadFile('046_intel_vbt.dts')
+        data = self._DoReadFile('x86/intel_vbt.dts')
         self.assertEqual(VBT_DATA, data[:len(VBT_DATA)])
 
     def testSplBssPad(self):
@@ -1468,7 +1468,7 @@ class TestFunctional(unittest.TestCase):
 
     def testPackStart16Spl(self):
         """Test that an image with an x86 start16 SPL region can be created"""
-        data = self._DoReadFile('048_x86_start16_spl.dts')
+        data = self._DoReadFile('x86/start16_spl.dts')
         self.assertEqual(X86_START16_SPL_DATA, data[:len(X86_START16_SPL_DATA)])
 
     def _PackUbootSplMicrocode(self, dts, ucode_second=False):
@@ -1494,7 +1494,7 @@ class TestFunctional(unittest.TestCase):
     def testPackUbootSplMicrocode(self):
         """Test that x86 microcode can be handled correctly in SPL"""
         self._SetupSplElf()
-        self._PackUbootSplMicrocode('049_x86_ucode_spl.dts')
+        self._PackUbootSplMicrocode('x86/ucode_spl.dts')
 
     def testPackUbootSplMicrocodeReorder(self):
         """Test that order doesn't matter for microcode entries
@@ -1503,12 +1503,12 @@ class TestFunctional(unittest.TestCase):
         u-boot-ucode entry we have not yet seen the u-boot-dtb-with-ucode
         entry, so we reply on binman to try later.
         """
-        self._PackUbootSplMicrocode('058_x86_ucode_spl_needs_retry.dts',
+        self._PackUbootSplMicrocode('x86/ucode_spl_needs_retry.dts',
                                     ucode_second=True)
 
     def testPackMrc(self):
         """Test that an image with an MRC binary can be created"""
-        data = self._DoReadFile('050_intel_mrc.dts')
+        data = self._DoReadFile('x86/intel_mrc.dts')
         self.assertEqual(MRC_DATA, data[:len(MRC_DATA)])
 
     def testSplDtb(self):
@@ -2055,7 +2055,7 @@ class TestFunctional(unittest.TestCase):
 
     def testPackStart16Tpl(self):
         """Test that an image with an x86 start16 TPL region can be created"""
-        data = self._DoReadFile('081_x86_start16_tpl.dts')
+        data = self._DoReadFile('x86/start16_tpl.dts')
         self.assertEqual(X86_START16_TPL_DATA, data[:len(X86_START16_TPL_DATA)])
 
     def testSelectImage(self):
@@ -2304,14 +2304,14 @@ class TestFunctional(unittest.TestCase):
             the microcode
         """
         self._SetupTplElf('u_boot_ucode_ptr')
-        first, pos_and_size = self._RunMicrocodeTest('093_x86_tpl_ucode.dts',
+        first, pos_and_size = self._RunMicrocodeTest('x86/tpl_ucode.dts',
                                                      U_BOOT_TPL_NODTB_DATA)
         self.assertEqual(b'tplnodtb with microc' + pos_and_size +
                          b'ter somewhere in here', first)
 
     def testFmapX86(self):
         """Basic test of generation of a flashrom fmap"""
-        data = self._DoReadFile('094_fmap_x86.dts')
+        data = self._DoReadFile('x86/fmap.dts')
         fhdr, fentries = fmap_util.DecodeFmap(data[32:])
         expected = U_BOOT_DATA + MRC_DATA + tools.get_bytes(ord('a'), 32 - 7)
         self.assertEqual(expected, data[:32])
@@ -2335,7 +2335,7 @@ class TestFunctional(unittest.TestCase):
 
     def testFmapX86Section(self):
         """Basic test of generation of a flashrom fmap"""
-        data = self._DoReadFile('095_fmap_x86_section.dts')
+        data = self._DoReadFile('x86/fmap_section.dts')
         expected = U_BOOT_DATA + MRC_DATA + tools.get_bytes(ord('b'), 32 - 7)
         self.assertEqual(expected, data[:32])
         fhdr, fentries = fmap_util.DecodeFmap(data[36:])
@@ -2401,7 +2401,7 @@ class TestFunctional(unittest.TestCase):
 
     def testPackRefCode(self):
         """Test that an image with an Intel Reference code binary works"""
-        data = self._DoReadFile('100_intel_refcode.dts')
+        data = self._DoReadFile('x86/intel_refcode.dts')
         self.assertEqual(REFCODE_DATA, data[:len(REFCODE_DATA)])
 
     def testSectionOffset(self):
@@ -2556,20 +2556,20 @@ class TestFunctional(unittest.TestCase):
     def testPackX86RomIfwi(self):
         """Test that an x86 ROM with Integrated Firmware Image can be created"""
         self._SetupIfwi('fitimage.bin')
-        data = self._DoReadFile('111_x86_rom_ifwi.dts')
+        data = self._DoReadFile('x86/rom_ifwi.dts')
         self._CheckIfwi(data)
 
     def testPackX86RomIfwiNoDesc(self):
         """Test that an x86 ROM with IFWI can be created from an ifwi.bin file"""
         self._SetupIfwi('ifwi.bin')
-        data = self._DoReadFile('112_x86_rom_ifwi_nodesc.dts')
+        data = self._DoReadFile('x86/rom_ifwi_nodesc.dts')
         self._CheckIfwi(data)
 
     def testPackX86RomIfwiNoData(self):
         """Test that an x86 ROM with IFWI handles missing data"""
         self._SetupIfwi('ifwi.bin')
         with self.assertRaises(ValueError) as e:
-            data = self._DoReadFile('113_x86_rom_ifwi_nodata.dts')
+            data = self._DoReadFile('x86/rom_ifwi_nodata.dts')
         self.assertIn('Could not complete processing of contents',
                       str(e.exception))
 
@@ -2577,7 +2577,7 @@ class TestFunctional(unittest.TestCase):
         """Test that binman still produces an image if ifwitool is missing"""
         self._SetupIfwi('fitimage.bin')
         with terminal.capture() as (_, stderr):
-            self._DoTestFile('111_x86_rom_ifwi.dts',
+            self._DoTestFile('x86/rom_ifwi.dts',
                              force_missing_bintools='ifwitool')
         err = stderr.getvalue()
         self.assertRegex(err,
@@ -3554,7 +3554,7 @@ class TestFunctional(unittest.TestCase):
 
     def testDescriptorOffset(self):
         """Test that the Intel descriptor is always placed at at the start"""
-        data = self._DoReadFileDtb('141_descriptor_offset.dts')
+        data = self._DoReadFileDtb('x86/descriptor_offset.dts')
         image = control.images['image']
         entries = image.GetEntries()
         desc = entries['intel-descriptor']
@@ -3778,22 +3778,22 @@ class TestFunctional(unittest.TestCase):
 
     def testPackReset16(self):
         """Test that an image with an x86 reset16 region can be created"""
-        data = self._DoReadFile('144_x86_reset16.dts')
+        data = self._DoReadFile('x86/reset16.dts')
         self.assertEqual(X86_RESET16_DATA, data[:len(X86_RESET16_DATA)])
 
     def testPackReset16Spl(self):
         """Test that an image with an x86 reset16-spl region can be created"""
-        data = self._DoReadFile('145_x86_reset16_spl.dts')
+        data = self._DoReadFile('x86/reset16_spl.dts')
         self.assertEqual(X86_RESET16_SPL_DATA, data[:len(X86_RESET16_SPL_DATA)])
 
     def testPackReset16Tpl(self):
         """Test that an image with an x86 reset16-tpl region can be created"""
-        data = self._DoReadFile('146_x86_reset16_tpl.dts')
+        data = self._DoReadFile('x86/reset16_tpl.dts')
         self.assertEqual(X86_RESET16_TPL_DATA, data[:len(X86_RESET16_TPL_DATA)])
 
     def testPackIntelFit(self):
         """Test that an image with an Intel FIT and pointer can be created"""
-        data = self._DoReadFile('147_intel_fit.dts')
+        data = self._DoReadFile('x86/intel_fit.dts')
         self.assertEqual(U_BOOT_DATA, data[:len(U_BOOT_DATA)])
         fit = data[16:32];
         self.assertEqual(b'_FIT_   \x01\x00\x00\x00\x00\x01\x80}' , fit)
@@ -3807,7 +3807,7 @@ class TestFunctional(unittest.TestCase):
     def testPackIntelFitMissing(self):
         """Test detection of a FIT pointer with not FIT region"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('148_intel_fit_missing.dts')
+            self._DoReadFile('x86/intel_fit_missing.dts')
         self.assertIn("'intel-fit-ptr' section must have an 'intel-fit' sibling",
                       str(e.exception))
 
@@ -3840,29 +3840,29 @@ class TestFunctional(unittest.TestCase):
         """Test binman can assign symbols in a section with end-at-4gb"""
         self._SetupSplElf('u_boot_binman_syms_x86')
         self._SetupTplElf('u_boot_binman_syms_x86')
-        self._CheckSymbolsTplSection('155_symbols_tpl_x86.dts',
+        self._CheckSymbolsTplSection('x86/symbols_tpl.dts',
                                      [0xffffff04, 0xffffff20, 0xffffff3c,
                                       0x04])
 
     def testPackX86RomIfwiSectiom(self):
         """Test that a section can be placed in an IFWI region"""
         self._SetupIfwi('fitimage.bin')
-        data = self._DoReadFile('151_x86_rom_ifwi_section.dts')
+        data = self._DoReadFile('x86/rom_ifwi_section.dts')
         self._CheckIfwi(data)
 
     def testPackFspM(self):
         """Test that an image with a FSP memory-init binary can be created"""
-        data = self._DoReadFile('152_intel_fsp_m.dts')
+        data = self._DoReadFile('x86/intel_fsp_m.dts')
         self.assertEqual(FSP_M_DATA, data[:len(FSP_M_DATA)])
 
     def testPackFspS(self):
         """Test that an image with a FSP silicon-init binary can be created"""
-        data = self._DoReadFile('153_intel_fsp_s.dts')
+        data = self._DoReadFile('x86/intel_fsp_s.dts')
         self.assertEqual(FSP_S_DATA, data[:len(FSP_S_DATA)])
 
     def testPackFspT(self):
         """Test that an image with a FSP temp-ram-init binary can be created"""
-        data = self._DoReadFile('154_intel_fsp_t.dts')
+        data = self._DoReadFile('x86/intel_fsp_t.dts')
         self.assertEqual(FSP_T_DATA, data[:len(FSP_T_DATA)])
 
     def testMkimage(self):
@@ -3927,7 +3927,7 @@ class TestFunctional(unittest.TestCase):
     def testPackX86RomMeMissingDesc(self):
         """Test that an missing Intel descriptor entry is allowed"""
         with terminal.capture() as (stdout, stderr):
-            self._DoTestFile('164_x86_rom_me_missing.dts', allow_missing=True)
+            self._DoTestFile('x86/rom_me_missing.dts', allow_missing=True)
         err = stderr.getvalue()
         self.assertRegex(err, "Image 'image'.*missing.*: intel-descriptor")
 
@@ -3937,7 +3937,7 @@ class TestFunctional(unittest.TestCase):
         pathname = os.path.join(self._indir, 'fitimage.bin')
         os.remove(pathname)
         with terminal.capture() as (stdout, stderr):
-            self._DoTestFile('111_x86_rom_ifwi.dts', allow_missing=True)
+            self._DoTestFile('x86/rom_ifwi.dts', allow_missing=True)
         err = stderr.getvalue()
         self.assertRegex(err, "Image 'image'.*missing.*: intel-ifwi")
 
diff --git a/tools/binman/test/141_descriptor_offset.dts b/tools/binman/test/x86/descriptor_offset.dts
similarity index 100%
rename from tools/binman/test/141_descriptor_offset.dts
rename to tools/binman/test/x86/descriptor_offset.dts
diff --git a/tools/binman/test/094_fmap_x86.dts b/tools/binman/test/x86/fmap.dts
similarity index 100%
rename from tools/binman/test/094_fmap_x86.dts
rename to tools/binman/test/x86/fmap.dts
diff --git a/tools/binman/test/095_fmap_x86_section.dts b/tools/binman/test/x86/fmap_section.dts
similarity index 100%
rename from tools/binman/test/095_fmap_x86_section.dts
rename to tools/binman/test/x86/fmap_section.dts
diff --git a/tools/binman/test/043_intel_cmc.dts b/tools/binman/test/x86/intel_cmc.dts
similarity index 100%
rename from tools/binman/test/043_intel_cmc.dts
rename to tools/binman/test/x86/intel_cmc.dts
diff --git a/tools/binman/test/147_intel_fit.dts b/tools/binman/test/x86/intel_fit.dts
similarity index 100%
rename from tools/binman/test/147_intel_fit.dts
rename to tools/binman/test/x86/intel_fit.dts
diff --git a/tools/binman/test/148_intel_fit_missing.dts b/tools/binman/test/x86/intel_fit_missing.dts
similarity index 100%
rename from tools/binman/test/148_intel_fit_missing.dts
rename to tools/binman/test/x86/intel_fit_missing.dts
diff --git a/tools/binman/test/042_intel_fsp.dts b/tools/binman/test/x86/intel_fsp.dts
similarity index 100%
rename from tools/binman/test/042_intel_fsp.dts
rename to tools/binman/test/x86/intel_fsp.dts
diff --git a/tools/binman/test/152_intel_fsp_m.dts b/tools/binman/test/x86/intel_fsp_m.dts
similarity index 100%
rename from tools/binman/test/152_intel_fsp_m.dts
rename to tools/binman/test/x86/intel_fsp_m.dts
diff --git a/tools/binman/test/153_intel_fsp_s.dts b/tools/binman/test/x86/intel_fsp_s.dts
similarity index 100%
rename from tools/binman/test/153_intel_fsp_s.dts
rename to tools/binman/test/x86/intel_fsp_s.dts
diff --git a/tools/binman/test/154_intel_fsp_t.dts b/tools/binman/test/x86/intel_fsp_t.dts
similarity index 100%
rename from tools/binman/test/154_intel_fsp_t.dts
rename to tools/binman/test/x86/intel_fsp_t.dts
diff --git a/tools/binman/test/050_intel_mrc.dts b/tools/binman/test/x86/intel_mrc.dts
similarity index 100%
rename from tools/binman/test/050_intel_mrc.dts
rename to tools/binman/test/x86/intel_mrc.dts
diff --git a/tools/binman/test/100_intel_refcode.dts b/tools/binman/test/x86/intel_refcode.dts
similarity index 100%
rename from tools/binman/test/100_intel_refcode.dts
rename to tools/binman/test/x86/intel_refcode.dts
diff --git a/tools/binman/test/046_intel_vbt.dts b/tools/binman/test/x86/intel_vbt.dts
similarity index 100%
rename from tools/binman/test/046_intel_vbt.dts
rename to tools/binman/test/x86/intel_vbt.dts
diff --git a/tools/binman/test/032_intel_vga.dts b/tools/binman/test/x86/intel_vga.dts
similarity index 100%
rename from tools/binman/test/032_intel_vga.dts
rename to tools/binman/test/x86/intel_vga.dts
diff --git a/tools/binman/test/037_x86_no_ucode.dts b/tools/binman/test/x86/no_ucode.dts
similarity index 100%
rename from tools/binman/test/037_x86_no_ucode.dts
rename to tools/binman/test/x86/no_ucode.dts
diff --git a/tools/binman/test/044_x86_optional_ucode.dts b/tools/binman/test/x86/optional_ucode.dts
similarity index 100%
rename from tools/binman/test/044_x86_optional_ucode.dts
rename to tools/binman/test/x86/optional_ucode.dts
diff --git a/tools/binman/test/144_x86_reset16.dts b/tools/binman/test/x86/reset16.dts
similarity index 100%
rename from tools/binman/test/144_x86_reset16.dts
rename to tools/binman/test/x86/reset16.dts
diff --git a/tools/binman/test/145_x86_reset16_spl.dts b/tools/binman/test/x86/reset16_spl.dts
similarity index 100%
rename from tools/binman/test/145_x86_reset16_spl.dts
rename to tools/binman/test/x86/reset16_spl.dts
diff --git a/tools/binman/test/146_x86_reset16_tpl.dts b/tools/binman/test/x86/reset16_tpl.dts
similarity index 100%
rename from tools/binman/test/146_x86_reset16_tpl.dts
rename to tools/binman/test/x86/reset16_tpl.dts
diff --git a/tools/binman/test/029_x86_rom.dts b/tools/binman/test/x86/rom.dts
similarity index 100%
rename from tools/binman/test/029_x86_rom.dts
rename to tools/binman/test/x86/rom.dts
diff --git a/tools/binman/test/111_x86_rom_ifwi.dts b/tools/binman/test/x86/rom_ifwi.dts
similarity index 100%
rename from tools/binman/test/111_x86_rom_ifwi.dts
rename to tools/binman/test/x86/rom_ifwi.dts
diff --git a/tools/binman/test/113_x86_rom_ifwi_nodata.dts b/tools/binman/test/x86/rom_ifwi_nodata.dts
similarity index 100%
rename from tools/binman/test/113_x86_rom_ifwi_nodata.dts
rename to tools/binman/test/x86/rom_ifwi_nodata.dts
diff --git a/tools/binman/test/112_x86_rom_ifwi_nodesc.dts b/tools/binman/test/x86/rom_ifwi_nodesc.dts
similarity index 100%
rename from tools/binman/test/112_x86_rom_ifwi_nodesc.dts
rename to tools/binman/test/x86/rom_ifwi_nodesc.dts
diff --git a/tools/binman/test/151_x86_rom_ifwi_section.dts b/tools/binman/test/x86/rom_ifwi_section.dts
similarity index 100%
rename from tools/binman/test/151_x86_rom_ifwi_section.dts
rename to tools/binman/test/x86/rom_ifwi_section.dts
diff --git a/tools/binman/test/031_x86_rom_me.dts b/tools/binman/test/x86/rom_me.dts
similarity index 100%
rename from tools/binman/test/031_x86_rom_me.dts
rename to tools/binman/test/x86/rom_me.dts
diff --git a/tools/binman/test/163_x86_rom_me_empty.dts b/tools/binman/test/x86/rom_me_empty.dts
similarity index 100%
rename from tools/binman/test/163_x86_rom_me_empty.dts
rename to tools/binman/test/x86/rom_me_empty.dts
diff --git a/tools/binman/test/164_x86_rom_me_missing.dts b/tools/binman/test/x86/rom_me_missing.dts
similarity index 100%
rename from tools/binman/test/164_x86_rom_me_missing.dts
rename to tools/binman/test/x86/rom_me_missing.dts
diff --git a/tools/binman/test/030_x86_rom_me_no_desc.dts b/tools/binman/test/x86/rom_me_no_desc.dts
similarity index 100%
rename from tools/binman/test/030_x86_rom_me_no_desc.dts
rename to tools/binman/test/x86/rom_me_no_desc.dts
diff --git a/tools/binman/test/035_x86_single_ucode.dts b/tools/binman/test/x86/single_ucode.dts
similarity index 100%
rename from tools/binman/test/035_x86_single_ucode.dts
rename to tools/binman/test/x86/single_ucode.dts
diff --git a/tools/binman/test/033_x86_start16.dts b/tools/binman/test/x86/start16.dts
similarity index 100%
rename from tools/binman/test/033_x86_start16.dts
rename to tools/binman/test/x86/start16.dts
diff --git a/tools/binman/test/048_x86_start16_spl.dts b/tools/binman/test/x86/start16_spl.dts
similarity index 100%
rename from tools/binman/test/048_x86_start16_spl.dts
rename to tools/binman/test/x86/start16_spl.dts
diff --git a/tools/binman/test/081_x86_start16_tpl.dts b/tools/binman/test/x86/start16_tpl.dts
similarity index 100%
rename from tools/binman/test/081_x86_start16_tpl.dts
rename to tools/binman/test/x86/start16_tpl.dts
diff --git a/tools/binman/test/155_symbols_tpl_x86.dts b/tools/binman/test/x86/symbols_tpl.dts
similarity index 100%
rename from tools/binman/test/155_symbols_tpl_x86.dts
rename to tools/binman/test/x86/symbols_tpl.dts
diff --git a/tools/binman/test/093_x86_tpl_ucode.dts b/tools/binman/test/x86/tpl_ucode.dts
similarity index 100%
rename from tools/binman/test/093_x86_tpl_ucode.dts
rename to tools/binman/test/x86/tpl_ucode.dts
diff --git a/tools/binman/test/034_x86_ucode.dts b/tools/binman/test/x86/ucode.dts
similarity index 100%
rename from tools/binman/test/034_x86_ucode.dts
rename to tools/binman/test/x86/ucode.dts
diff --git a/tools/binman/test/038_x86_ucode_missing_node.dts b/tools/binman/test/x86/ucode_missing_node.dts
similarity index 100%
rename from tools/binman/test/038_x86_ucode_missing_node.dts
rename to tools/binman/test/x86/ucode_missing_node.dts
diff --git a/tools/binman/test/039_x86_ucode_missing_node2.dts b/tools/binman/test/x86/ucode_missing_node2.dts
similarity index 100%
rename from tools/binman/test/039_x86_ucode_missing_node2.dts
rename to tools/binman/test/x86/ucode_missing_node2.dts
diff --git a/tools/binman/test/040_x86_ucode_not_in_image.dts b/tools/binman/test/x86/ucode_not_in_image.dts
similarity index 100%
rename from tools/binman/test/040_x86_ucode_not_in_image.dts
rename to tools/binman/test/x86/ucode_not_in_image.dts
diff --git a/tools/binman/test/049_x86_ucode_spl.dts b/tools/binman/test/x86/ucode_spl.dts
similarity index 100%
rename from tools/binman/test/049_x86_ucode_spl.dts
rename to tools/binman/test/x86/ucode_spl.dts
diff --git a/tools/binman/test/058_x86_ucode_spl_needs_retry.dts b/tools/binman/test/x86/ucode_spl_needs_retry.dts
similarity index 100%
rename from tools/binman/test/058_x86_ucode_spl_needs_retry.dts
rename to tools/binman/test/x86/ucode_spl_needs_retry.dts
-- 
2.43.0

