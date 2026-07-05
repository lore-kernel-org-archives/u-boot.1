Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63C0C43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 21:20:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0519846FD;
	Sun,  5 Jul 2026 23:20:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="BP+qHfJD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4CAD84867; Sun,  5 Jul 2026 23:20:46 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 516B1846F8
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 23:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EC6EB112041; Sun,  5 Jul 2026 23:20:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1783286443; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=mE0ZkadSBEyaW7dkF4oBqy77TnPvE/oPo0896UWSrak=;
 b=BP+qHfJD+f0uVi4RRGS/fAEb2gUJfb8llGF2oWAo/8zjoQ5klECU7vr8OojS9Eg+54TFSn
 zfdSqGCNPdRZ2vCrt47OyIp+jIqGnTBNNZzrqUPvvUnMMFBmexivk80XVpLXSdXCyWo0ty
 Drx1hCM7Vt8JP6udYGZPRffBntT02NvhiRg5jOWUX3HyH2xDrjORgKhLDjg3o6pYdaUT+6
 lvLnqWZoGV8s7DpXVQo9N2lfnjlthq+r0l/xk0s8cKChb2gye/vUC1baYfDfH5EAZNeQQW
 Gq2R88c9fQsKk43IUUIWcVmWFgJ5sRsWaGYFhnwI5za9AA8I5GZzZykCo8gpxQ==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>, Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v4 1/3] binman: imx8mimage: Generate FSPI header in binman
 instead of mkimage
Date: Sun,  5 Jul 2026 23:19:05 +0200
Message-ID: <20260705212037.319801-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Stop depending on the current mkimage method of generating the FSPI
header, instead generate the FSPI header within binman itself. This
is more flexible, as the FSPI header properties can be configured
from within the board-specific DT instead of being hard-coded in
mkimage at build time.

Acked-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Cc: Yannic Moog <y.moog@phytec.de>
Cc: u-boot@lists.denx.de
---
V2: - Drop import os
    - Update class documentation, document defaults
V3: Add RB from Peng
V4: - Rename nxp,fspi-columnaddresswidth
    - Use self.Raise()
    - Fix up padding offset
---
 tools/binman/etype/nxp_imx8mimage.py          | 95 +++++++++++++++++--
 tools/binman/ftest.py                         | 23 ++---
 tools/binman/test/vendor/nxp_imx8m_fspi.dts   |  1 -
 .../nxp_imx8m_fspi_fail_columnadresswidth.dts | 19 ++++
 ...dts => nxp_imx8m_fspi_fail_devicetype.dts} |  3 +-
 .../nxp_imx8m_fspi_fail_flashpadtype.dts      | 19 ++++
 .../nxp_imx8m_fspi_fail_readsampleclksrc.dts  | 19 ++++
 .../nxp_imx8m_fspi_fail_serialclkfreq.dts     | 19 ++++
 .../test/vendor/nxp_imx8m_fspi_pass.dts       |  1 -
 9 files changed, 178 insertions(+), 21 deletions(-)
 create mode 100644 tools/binman/test/vendor/nxp_imx8m_fspi_fail_columnadresswidth.dts
 rename tools/binman/test/vendor/{nxp_imx8m_fspi_fail.dts => nxp_imx8m_fspi_fail_devicetype.dts} (83%)
 create mode 100644 tools/binman/test/vendor/nxp_imx8m_fspi_fail_flashpadtype.dts
 create mode 100644 tools/binman/test/vendor/nxp_imx8m_fspi_fail_readsampleclksrc.dts
 create mode 100644 tools/binman/test/vendor/nxp_imx8m_fspi_fail_serialclkfreq.dts

diff --git a/tools/binman/etype/nxp_imx8mimage.py b/tools/binman/etype/nxp_imx8mimage.py
index 25c43438a87..38d31b1bc09 100644
--- a/tools/binman/etype/nxp_imx8mimage.py
+++ b/tools/binman/etype/nxp_imx8mimage.py
@@ -7,7 +7,7 @@
 # configuration file and input data.
 #
 
-import os
+import struct
 
 from collections import OrderedDict
 
@@ -25,8 +25,26 @@ class Entry_nxp_imx8mimage(Entry_mkimage):
         - nxp,boot-from - device to boot from (e.g. 'sd')
         - nxp,loader-address - loader address (SPL text base)
         - nxp,rom-version - BootROM version ('2' for i.MX8M Nano and Plus)
-        - nxp,fspi-header-filename - FSPI header file name (CONFIG_FSPI_CONF_FILE).
-            Used only if 'nxp,boot-from == "fspi"' .
+
+    Properties / Entry arguments for FSPI boot mode (nxp,boot-from = "fspi"):
+        - nxp,fspi-columnaddresswidth - FSPI column address width
+            (3 - HyperFlash, 12/13 - Serial NAND, 0 - Otherwise (default))
+        - nxp,fspi-controllermisc-diffclk - FSPI differential clock enable (default off)
+        - nxp,fspi-controllermisc-wordaddr - FSPI word addressable enable (default off)
+        - nxp,fspi-controllermisc-safecfg - FSPI safe configuration frequency (default off)
+        - nxp,fspi-controllermisc-padovr - FSPI pad setting override (default off)
+        - nxp,fspi-controllermisc-ddrmode - FSPI DDR mode (default off)
+        - nxp,fspi-lutcustomseq - FSPI use LUT sequence parameters (default off)
+        - nxp,fspi-devicetype - FSPI device type
+            (1 - SPI NOR (default), 2 - Serial NAND)
+        - nxp,fspi-flasha1size - FSPI device size (default 0x10000000)
+        - nxp,fspi-flashpadtype - FSPI flash pad type
+            (1 - Single pad (default), 2 - Dual pads, 4 - Quad pads, 8 - Octal pads)
+        - nxp,fspi-readsampleclksrc - FSPI clock source
+            (0 - Internal loopback (default), 1 - loopback from DQS pad, 3 - Flash provided DQS).
+        - nxp,fspi-serialclkfreq - FSPI clock frequency
+            (1 - 30 MHz, 2 - 50 MHz (default), 3 - 60 MHz, 4 - 75 MHz, 5 - 80 MHz,
+             6 - 100 MHz, 7 - 133 MHz, 8 - 166 MHz).
     """
 
     def __init__(self, section, etype, node):
@@ -37,9 +55,30 @@ class Entry_nxp_imx8mimage(Entry_mkimage):
     def ReadNode(self):
         super().ReadNode()
         self.boot_from = fdt_util.GetString(self._node, 'nxp,boot-from')
-        self.fspi_header = fdt_util.GetString(self._node, 'nxp,fspi-header-filename', 'fspi_header.bin')
+        self.fspi_columnadresswidth = fdt_util.GetInt(self._node, 'nxp,fspi-columnaddresswidth', 0)
+        self.fspi_controllermisc_diffclk = fdt_util.GetBool(self._node, 'nxp,fspi-controllermisc-diffclk')
+        self.fspi_controllermisc_wordaddr = fdt_util.GetBool(self._node, 'nxp,fspi-controllermisc-wordaddr')
+        self.fspi_controllermisc_safecfg = fdt_util.GetBool(self._node, 'nxp,fspi-controllermisc-safecfg')
+        self.fspi_controllermisc_padovr = fdt_util.GetBool(self._node, 'nxp,fspi-controllermisc-padovr')
+        self.fspi_controllermisc_ddrmode = fdt_util.GetBool(self._node, 'nxp,fspi-controllermisc-ddrmode')
+        self.fspi_devicetype = fdt_util.GetInt(self._node, 'nxp,fspi-devicetype', 1)
+        self.fspi_flasha1size = fdt_util.GetInt(self._node, 'nxp,fspi-flasha1size', 0x10000000)
+        self.fspi_flashpadtype = fdt_util.GetInt(self._node, 'nxp,fspi-flashpadtype', 1)
+        self.fspi_lutcustomseq = fdt_util.GetBool(self._node, 'nxp,fspi-lutcustomseq')
+        self.fspi_readsampleclksrc = fdt_util.GetInt(self._node, 'nxp,fspi-readsampleclksrc', 0)
+        self.fspi_serialclkfreq = fdt_util.GetInt(self._node, 'nxp,fspi-serialclkfreq', 2)
         self.loader_address = fdt_util.GetInt(self._node, 'nxp,loader-address')
         self.rom_version = fdt_util.GetInt(self._node, 'nxp,rom-version')
+        if not self.fspi_columnadresswidth in [ 0, 3, 12, 13 ]:
+            self.Raise('nxp,fspi-columnaddresswidth can be 0, 3, 12, 13 only.')
+        if not self.fspi_devicetype in [ 1, 2 ]:
+            self.Raise('nxp,fspi-devicetype can be 1, 2 only.')
+        if not self.fspi_flashpadtype in [ 1, 2, 4, 8 ]:
+            self.Raise('nxp,fspi-flashpadtype can be 1, 2, 4, 8 only.')
+        if not self.fspi_readsampleclksrc in [ 0, 1, 3 ]:
+            self.Raise('nxp,fspi-readsampleclksrc can be 0, 1, 3 only.')
+        if not self.fspi_serialclkfreq in [ 1, 2, 3, 4, 5, 6, 7, 8 ]:
+            self.Raise('nxp,fspi-serialclkfreq can be 1..8 only.')
         self.ReadEntries()
 
     def BuildSectionData(self, required):
@@ -59,9 +98,51 @@ class Entry_nxp_imx8mimage(Entry_mkimage):
         if self.mkimage.run_cmd(*args) is not None:
             outdata = tools.read_file(output_fname)
             if self.boot_from == 'fspi':
-                spidata = tools.read_file(os.path.join(tools.get_output_dir(), self.fspi_header))
-                if len(spidata) != 448:
-                    raise ValueError("FSPI header is not 448 Bytes long")
+                # 0x00 ... Tag
+                spidata = struct.pack('<I', 0x42464346)
+                # 0x04 ... Version
+                spidata += struct.pack('<I', 0x56010000)
+                # 0x08 ... Reserved
+                spidata += struct.pack('<I', 0)
+                # 0x0c ... readSampleClkSrc (LSByte at 0x0c), dataHoldTime,
+                #          dataSetupTime, columnAdressWidth (MSByte at 0x0f)
+                spidata += struct.pack('<I', 0x00030300 |
+                    (self.fspi_columnadresswidth << 24) |
+                    self.fspi_readsampleclksrc)
+
+                # 0x10..0x3f ... Padding
+                spidata += tools.get_bytes(0, 0x30)
+
+                # 0x40 ... controllerMiscOption
+                spidata += struct.pack('<I',
+                    ((1 << 0) if self.fspi_controllermisc_diffclk else 0) |
+                    ((1 << 3) if self.fspi_controllermisc_wordaddr else 0) |
+                    ((1 << 4) if self.fspi_controllermisc_safecfg else 0) |
+                    ((1 << 5) if self.fspi_controllermisc_padovr else 0) |
+                    ((1 << 6) if self.fspi_controllermisc_ddrmode else 0))
+
+                # 0x44 ... deviceType (LSByte at 0x44), sflashPadType,
+                #          serialClkFreq, lutCustomSeqEnable (MSByte at 0x47)
+                spidata += struct.pack('<I',
+                    ((1 << 24) if self.fspi_lutcustomseq else 0) |
+                    (self.fspi_serialclkfreq << 16) |
+                    (self.fspi_flashpadtype << 8) |
+                    self.fspi_devicetype)
+
+                # 0x48..0x4f ... Padding
+                spidata += tools.get_bytes(0, 0x8)
+
+                # 0x50 ... flashA1Size
+                spidata += struct.pack('<I', self.fspi_flasha1size)
+
+                # 0x54..0x7f ... Padding
+                spidata += tools.get_bytes(0, 0x2c)
+
+                # 0x80 ... lookupTable
+                spidata += struct.pack('<I', 0x0818040b)
+                spidata += struct.pack('<I', 0x24043008)
+
+                # 0x88..0xfff ... Padding (end of FSPI block is 0x1bf, align to 4k)
                 spidata += tools.get_bytes(0, 0x1000 - len(spidata))
                 outdata = spidata + outdata
             return outdata
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index bf98b268ac1..03c9d42aeeb 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -8101,17 +8101,18 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testNxpImx8MFSPI(self):
         """Test that binman can produce an iMX8m FSPI image"""
-        testdir = tempfile.mkdtemp(prefix='binman.')
-
-        tools.write_file(os.path.join(testdir, 'fspi_header.bin'), tools.get_bytes(0, 448))
-        with terminal.capture():
-            self._DoTestFile('vendor/nxp_imx8m_fspi.dts', output_dir=testdir)
-            self._DoTestFile('vendor/nxp_imx8m_fspi_pass.dts', output_dir=testdir)
-
-        tools.write_file(os.path.join(testdir, 'fspi_header_fail.bin'), tools.get_bytes(0, 4097))
-        with terminal.capture():
-            with self.assertRaises(ValueError) as e:
-                self._DoTestFile('vendor/nxp_imx8m_fspi_fail.dts', output_dir=testdir)
+        self._DoTestFile('vendor/nxp_imx8m_fspi.dts')
+        self._DoTestFile('vendor/nxp_imx8m_fspi_pass.dts')
+        with self.assertRaises(ValueError) as e:
+            self._DoTestFile('vendor/nxp_imx8m_fspi_fail_columnadresswidth.dts')
+        with self.assertRaises(ValueError) as e:
+            self._DoTestFile('vendor/nxp_imx8m_fspi_fail_devicetype.dts')
+        with self.assertRaises(ValueError) as e:
+            self._DoTestFile('vendor/nxp_imx8m_fspi_fail_flashpadtype.dts')
+        with self.assertRaises(ValueError) as e:
+            self._DoTestFile('vendor/nxp_imx8m_fspi_fail_readsampleclksrc.dts')
+        with self.assertRaises(ValueError) as e:
+            self._DoTestFile('vendor/nxp_imx8m_fspi_fail_serialclkfreq.dts')
 
     def testNxpHeaderDdrfw(self):
         """Test that binman can add a header to DDR PHY firmware images"""
diff --git a/tools/binman/test/vendor/nxp_imx8m_fspi.dts b/tools/binman/test/vendor/nxp_imx8m_fspi.dts
index ae6cc5981e6..140e9bea2e7 100644
--- a/tools/binman/test/vendor/nxp_imx8m_fspi.dts
+++ b/tools/binman/test/vendor/nxp_imx8m_fspi.dts
@@ -10,7 +10,6 @@
 		nxp-imx8mimage {
 			args;	/* TODO: Needed by mkimage etype superclass */
 			nxp,boot-from = "fspi";
-			nxp,fspi-header-filename = "fspi_header.bin";
 			nxp,rom-version = <1>;
 			nxp,loader-address = <0x10>;
 		};
diff --git a/tools/binman/test/vendor/nxp_imx8m_fspi_fail_columnadresswidth.dts b/tools/binman/test/vendor/nxp_imx8m_fspi_fail_columnadresswidth.dts
new file mode 100644
index 00000000000..95efa33b5bf
--- /dev/null
+++ b/tools/binman/test/vendor/nxp_imx8m_fspi_fail_columnadresswidth.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		nxp-imx8mimage {
+			args;	/* TODO: Needed by mkimage etype superclass */
+			nxp,boot-from = "fspi";
+			nxp,rom-version = <2>;
+			nxp,loader-address = <0x10>;
+			/* Bogus value */
+			nxp,fspi-columnaddresswidth = <1>;
+		};
+	};
+};
diff --git a/tools/binman/test/vendor/nxp_imx8m_fspi_fail.dts b/tools/binman/test/vendor/nxp_imx8m_fspi_fail_devicetype.dts
similarity index 83%
rename from tools/binman/test/vendor/nxp_imx8m_fspi_fail.dts
rename to tools/binman/test/vendor/nxp_imx8m_fspi_fail_devicetype.dts
index 5a0d758e5a3..f3b343f942f 100644
--- a/tools/binman/test/vendor/nxp_imx8m_fspi_fail.dts
+++ b/tools/binman/test/vendor/nxp_imx8m_fspi_fail_devicetype.dts
@@ -10,9 +10,10 @@
 		nxp-imx8mimage {
 			args;	/* TODO: Needed by mkimage etype superclass */
 			nxp,boot-from = "fspi";
-			nxp,fspi-header-filename = "fspi_header_fail.bin";
 			nxp,rom-version = <2>;
 			nxp,loader-address = <0x10>;
+			/* Bogus value */
+			nxp,fspi-devicetype = <3>;
 		};
 	};
 };
diff --git a/tools/binman/test/vendor/nxp_imx8m_fspi_fail_flashpadtype.dts b/tools/binman/test/vendor/nxp_imx8m_fspi_fail_flashpadtype.dts
new file mode 100644
index 00000000000..515f81ba9f4
--- /dev/null
+++ b/tools/binman/test/vendor/nxp_imx8m_fspi_fail_flashpadtype.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		nxp-imx8mimage {
+			args;	/* TODO: Needed by mkimage etype superclass */
+			nxp,boot-from = "fspi";
+			nxp,rom-version = <2>;
+			nxp,loader-address = <0x10>;
+			/* Bogus value */
+			nxp,fspi-flashpadtype = <9>;
+		};
+	};
+};
diff --git a/tools/binman/test/vendor/nxp_imx8m_fspi_fail_readsampleclksrc.dts b/tools/binman/test/vendor/nxp_imx8m_fspi_fail_readsampleclksrc.dts
new file mode 100644
index 00000000000..b409a6099a3
--- /dev/null
+++ b/tools/binman/test/vendor/nxp_imx8m_fspi_fail_readsampleclksrc.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		nxp-imx8mimage {
+			args;	/* TODO: Needed by mkimage etype superclass */
+			nxp,boot-from = "fspi";
+			nxp,rom-version = <2>;
+			nxp,loader-address = <0x10>;
+			/* Bogus value */
+			nxp,fspi-readsampleclksrc = <2>;
+		};
+	};
+};
diff --git a/tools/binman/test/vendor/nxp_imx8m_fspi_fail_serialclkfreq.dts b/tools/binman/test/vendor/nxp_imx8m_fspi_fail_serialclkfreq.dts
new file mode 100644
index 00000000000..a71522838e8
--- /dev/null
+++ b/tools/binman/test/vendor/nxp_imx8m_fspi_fail_serialclkfreq.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		nxp-imx8mimage {
+			args;	/* TODO: Needed by mkimage etype superclass */
+			nxp,boot-from = "fspi";
+			nxp,rom-version = <2>;
+			nxp,loader-address = <0x10>;
+			/* Bogus value */
+			nxp,fspi-serialclkfreq = <9>;
+		};
+	};
+};
diff --git a/tools/binman/test/vendor/nxp_imx8m_fspi_pass.dts b/tools/binman/test/vendor/nxp_imx8m_fspi_pass.dts
index 448d93d277a..1545cf6e44c 100644
--- a/tools/binman/test/vendor/nxp_imx8m_fspi_pass.dts
+++ b/tools/binman/test/vendor/nxp_imx8m_fspi_pass.dts
@@ -10,7 +10,6 @@
 		nxp-imx8mimage {
 			args;	/* TODO: Needed by mkimage etype superclass */
 			nxp,boot-from = "fspi";
-			/* Default nxp,fspi-header-filename = "fspi_header.bin"; */
 			nxp,rom-version = <2>;
 			nxp,loader-address = <0x10>;
 		};
-- 
2.53.0

