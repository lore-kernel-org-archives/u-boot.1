Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02571C71159
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 22:46:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22DEF81760;
	Tue, 17 Jun 2025 00:46:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="iFLPDk4/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NNPT9WRM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22FDC80C83; Tue, 17 Jun 2025 00:46:00 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C36B580C83
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 00:45:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bLlTd4LkBz9t8x;
 Tue, 17 Jun 2025 00:45:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1750113957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=a0NuN/1B6RXXJepbbGmxX3eJ9raxw5U5w7t+Rss0HUI=;
 b=iFLPDk4/qVtu7Tp+5o2oF++xMGAWgclwBrggwsg33DEEpcQ31bMXSPy+dzcO2+5KmPDSvp
 zC3Xb6V4zZhoDt79yMWsN31v3YTIyadCpwErHGxeO49n1pq9Y/c8raXarc+qH6WogS2fJd
 irZAkF88raiim2935T6tRRfo3V4u3AV9oWsnxvVoPTDTZO69XLfUzilPf8oeuT6j/r9yty
 erUcjvOkyU92PBode//sC9Y7znNwqfkaofodizv+bSrzZ/jfVBAggBGhOt9pIryInkBmYU
 MK3rmVuTR5EvGa84D33gMxPpUDjhNvs3qjG+gsmXpM9d3i3w30LAR0QqJ0XAAQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1750113955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=a0NuN/1B6RXXJepbbGmxX3eJ9raxw5U5w7t+Rss0HUI=;
 b=NNPT9WRMIelnoV9UwCxeYE1Z4dIaH8DPR2ZG7FOSz9ZxYC8oraGUqGl7V21IB52wDyK8K5
 eUc0h5YSqsT1tRtxHtSaoDYAvbE/LpV3yI05+Bo2yx1aRw/FFY+sX/Ymb9EzsihL2pp6n5
 3m0xsWZLneJDnvQ9VnPuP9mihaa9MSVDs04MrOVw7g5QE3jEGxfz3kJUFmF9I5iRX9O9kI
 VbSDSjVYKZOIYMMalviNg5lXSTGr9j4fsqD2lru620tyJmZ9hAKgRWhL+fFeg1MvcwsN2W
 smSDbQe9n5R07XUuBV01A9eljncBe/RHFiYGC0Z6RoHWtKzkbQPOI/zrMpoy7w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/2] binman: Add renesas_rcar4_sa0 etype
Date: Tue, 17 Jun 2025 00:45:02 +0200
Message-ID: <20250616224540.567566-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: fxknwfezn1aukj1mqjxc811idhimriuu
X-MBO-RS-ID: 7939317b19d0db10189
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

Add new etype which generates the Renesas R-Car Gen4 SA0 header.
This header is placed at the beginning of SPI NOR and describes
where should data from SPI NOR offset 0x40000 be loaded to, and
how much data should be loaded there. In case of U-Boot, this is
used to load SPL and possibly other payload(s) into RT-VRAM.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Add a test
---
 .gitignore                                    |  1 +
 tools/binman/etype/renesas_rcar4_sa0.py       | 46 +++++++++++++++++++
 tools/binman/ftest.py                         | 11 +++++
 tools/binman/test/348_renesas_rcar4_sa0.dts   | 15 ++++++
 .../test/349_renesas_rcar4_sa0_size.dts       | 20 ++++++++
 5 files changed, 93 insertions(+)
 create mode 100644 tools/binman/etype/renesas_rcar4_sa0.py
 create mode 100644 tools/binman/test/348_renesas_rcar4_sa0.dts
 create mode 100644 tools/binman/test/349_renesas_rcar4_sa0_size.dts

diff --git a/.gitignore b/.gitignore
index 272257a77bb..bb03833b5f2 100644
--- a/.gitignore
+++ b/.gitignore
@@ -75,6 +75,7 @@ fit-dtb.blob*
 /keep-syms-lto.*
 /*imx8mimage*
 /*imx8mcst*
+/*rcar4-sa0*
 /drivers/video/u_boot_logo.S
 /test/overlay/test-fdt-overlay.dtbo.S
 /test/overlay/test-fdt-overlay-stacked.dtbo.S
diff --git a/tools/binman/etype/renesas_rcar4_sa0.py b/tools/binman/etype/renesas_rcar4_sa0.py
new file mode 100644
index 00000000000..3a7c0988fdc
--- /dev/null
+++ b/tools/binman/etype/renesas_rcar4_sa0.py
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright 2025 Marek Vasut <marek.vasut+renesas@mailbox.org>
+#
+# Entry-type module for generating the Renesas R-Car Gen4 SA0 header.
+#
+
+import os
+import struct
+
+from binman.etype.section import Entry_section
+from dtoc import fdt_util
+from u_boot_pylib import tools
+
+RCAR_GEN4_SF_HEADER_SIZE    = 0x40000
+RCAR_GEN4_SF_MAX_LOAD_SIZE  = 0xec000
+
+class Entry_renesas_rcar4_sa0(Entry_section):
+    """Renesas R-Car Gen4 SA0 generator"""
+
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node)
+        self.required_props = ['renesas,loader-address']
+
+    def ReadNode(self):
+        self.loader_address = fdt_util.GetInt(self._node, 'renesas,loader-address')
+        super().ReadNode()
+
+    def BuildSectionData(self, required):
+        data = super().BuildSectionData(required)[RCAR_GEN4_SF_HEADER_SIZE:]
+
+        # Offset 0x0000 / Value 0x00000000
+        header = struct.pack('<I', 0)
+        header += tools.get_bytes(0xff, 0x3008)
+        # Offset 0x300c / Value 0x00000000
+        header += struct.pack('<I', 0)
+        header += tools.get_bytes(0xff, 0x144)
+        # Offset 0x3154 / Value (payload load address)
+        header += struct.pack('<I', self.loader_address)
+        header += tools.get_bytes(0xff, 0x10c)
+        # Offset 0x3264 / Value (payload size in 4-byte words, aligned to 4k)
+        header += struct.pack('<I', int(tools.align(len(data), 0x1000) / 4))
+        header += tools.get_bytes(0xff, 0x3cd98)
+        if len(data) > RCAR_GEN4_SF_MAX_LOAD_SIZE:
+            self.Raise(f'SRAM data longer than {RCAR_GEN4_SF_MAX_LOAD_SIZE} Bytes')
+
+        return header + data
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 4cf7dfc8216..4d040c9767e 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -5582,6 +5582,17 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         data = self._DoReadFile('347_bl1.dts')
         self.assertEqual(ATF_BL1_DATA, data[:len(ATF_BL1_DATA)])
 
+    def testRenesasRCarGen4SA0Image(self):
+        """Test that binman can produce an Renesas R-Car Gen4 SA0 image"""
+        self._DoTestFile('348_renesas_rcar4_sa0.dts')
+
+    def testRenesasRCarGen4SA0ImageSize(self):
+        """Test that binman can not produce large Renesas R-Car Gen4 SA0 image"""
+        with self.assertRaises(ValueError) as exc:
+            self._DoTestFile('349_renesas_rcar4_sa0_size.dts')
+        self.assertIn("Node '/binman/renesas-rcar4-sa0': SRAM data longer than 966656 Bytes",
+                      str(exc.exception))
+
     def testFitFdtOper(self):
         """Check handling of a specified FIT operation"""
         entry_args = {
diff --git a/tools/binman/test/348_renesas_rcar4_sa0.dts b/tools/binman/test/348_renesas_rcar4_sa0.dts
new file mode 100644
index 00000000000..4a8717520f2
--- /dev/null
+++ b/tools/binman/test/348_renesas_rcar4_sa0.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		renesas-rcar4-sa0 {
+			filename = "sa0.bin";
+			renesas,loader-address = <0x10>;
+		};
+	};
+};
diff --git a/tools/binman/test/349_renesas_rcar4_sa0_size.dts b/tools/binman/test/349_renesas_rcar4_sa0_size.dts
new file mode 100644
index 00000000000..eaf4507260b
--- /dev/null
+++ b/tools/binman/test/349_renesas_rcar4_sa0_size.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		renesas-rcar4-sa0 {
+			filename = "sa0.bin";
+			renesas,loader-address = <0x10>;
+
+			fill {	/* Oversize fill to cover size check */
+				size = <0x140000>;
+				fill-byte = [ff];
+			};
+		};
+	};
+};
-- 
2.47.2

