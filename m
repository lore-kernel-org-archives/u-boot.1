Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A83FC71150
	for <u-boot@archiver.kernel.org>; Sun, 15 Jun 2025 10:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1ADA80C83;
	Sun, 15 Jun 2025 12:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DNdnBQs/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="q+/o/E9p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93F2C82C30; Sun, 15 Jun 2025 12:50:32 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3ECE806D8
 for <u-boot@lists.denx.de>; Sun, 15 Jun 2025 12:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bKqfZ39n3z9t4g;
 Sun, 15 Jun 2025 12:50:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749984630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tA/R+7O6mL30r2EJXCuaE9hb1Mh35fPtrc6DqUPIGJA=;
 b=DNdnBQs/xM2B22mN/aaXQ3IFdkAONhRR4Ok9CDjNfDuCj6L5SJMfDU4rovKThbFKg+biLg
 2pyZVPWFmtNNkJUTQ+psuEkkEaR8uL77uKJ3CxNA5zXj+d4EJA0dwns/EQWYN1kmgnxzea
 2E9isHdNbvzRxjtg+xe+BxxB1AR6mIoIwB6hxAzqZ/C6lLgTxeGV13Akt6I3KYSbGzPHmF
 bw9j3pA6Uxex2vG5ewul25ViVh6mSKCiAak4sgo7pyXl1J/r0rasYyoZeK9FxTWeWC7X+D
 2/sd4hC43MmnYLv1yNG6a/5hlu9c9f+HxCzDjeEo4SXPK42JGxyXk9ljsAlNjA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749984628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tA/R+7O6mL30r2EJXCuaE9hb1Mh35fPtrc6DqUPIGJA=;
 b=q+/o/E9pX+KLUnLGQiMkrAq8Mu6tlVhqQNA6YBLDjnylLbbQpil5KncMCD6hLPqetK98/6
 rtSjuARle+vmvYheczrD+dZ7H0bmd0Ae20STShGM9CxwD5SCXOsSspVvPXhnMB8n8x2PgA
 FOOo9zWOInmSvGGraZ65smJS3YBP4mqD0LeHGx06IIrlpgLn50ePTjTYp1iswJA3XuK9Zm
 Q4Awg0EHjIGzrIG06Gi4w1iFD8jeC0R28vIMOCqT1t8r1yXM7GWvBxPEmOpy2qRaP1uSnS
 Ki+ZkU8A1fkYiur9VR3dpqNzXpjwMy7KSPakkzma6z+uKu/BulftjQb3js91YQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] binman: Add renesas_rcar4_sa0 etype
Date: Sun, 15 Jun 2025 12:50:14 +0200
Message-ID: <20250615105019.15257-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b8a3aebe24fd5624c10
X-MBO-RS-META: mkb8zs3g88ccp4qien5r4c5ik3kqwejd
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
 .gitignore                              |  1 +
 tools/binman/etype/renesas_rcar4_sa0.py | 46 +++++++++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100644 tools/binman/etype/renesas_rcar4_sa0.py

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
-- 
2.47.2

