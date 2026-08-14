Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76746C5CFCF
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 17:07:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 45E2E40CF1;
	Fri, 14 Aug 2026 17:07:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EZL38xR-Z3Cu; Fri, 14 Aug 2026 17:07:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6B11940CF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786727275;
	bh=fuavo2OrFl0qEfFc85tHieFMRpewOGC1VL8eM0znnr0=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=MgwexNRi7TjZWaCIs9UVsMKIlFp37R2vM8S/kEmOv5CspjwqX0xUuUM2RF42JJn7W
	 3UUeLXvG9BBtYSjoY0mlgejQFpWKPgMO6SOX/LUnqBdqHbu9Q9Y4x7vHuxcWHHonhq
	 bheFAMVFwK3Wphw5naRb7woG/evU02tEOPDktqbYBUBJ2PKAhF1gamH0OQHFq+NZkG
	 Mr87hjIkq+Jb1dsI2/EGrbChocX7OtMsWjVcZ/bCAzL/oprGcc1YWOQttcE6HanKcK
	 XLQxy8xYJ3vgSwAiNbfJtvCKcdXv3aMDApP/I5Tpj69q9FeRlpCgm3f8qLlco/VHjL
	 EzIjAG6dm0TMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B11940CF2;
	Fri, 14 Aug 2026 17:07:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D1D5361
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 17:07:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 337856080C
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 17:07:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kb7oAe_Q9VCY for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 17:07:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1CCEA60671
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1CCEA60671
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1CCEA60671
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 17:07:52 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 242CF1A1647;
 Fri, 14 Aug 2026 17:07:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id ED8D86046D;
 Fri, 14 Aug 2026 17:07:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9BD9911C4EF21; 
 Fri, 14 Aug 2026 19:07:43 +0200 (CEST)
Date: Fri, 14 Aug 2026 19:07:10 +0200
Subject: [PATCH 1/5] tools: binman: add nxp_imx93cst etype for i.MX93
 flash.bin signing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260814-imx93-secureboot-v1-1-0c3c78020d03@bootlin.com>
References: <20260814-imx93-secureboot-v1-0-0c3c78020d03@bootlin.com>
In-Reply-To: <20260814-imx93-secureboot-v1-0-0c3c78020d03@bootlin.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Denis Mukhin <dmukhin@ford.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Alice Guo <alice.guo@nxp.com>, 
 =?utf-8?q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marex.vasut@mailbox.org>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6231;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=scQ4a1ry17n72rHgrn1XtAhcpO/dkmLyL7bxnOFK62o=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqf0tUzMRB7dvRI9FNqvsn/sRso4GkzexRVPbIf
 gfhAVgm/FOJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCan9LVAAKCRArAF6gG1qP
 A79VD/9UK8gTlj0DlBI/QclX5qy4mlXQI8fIkAibSGx1sWGGAKIo2DqSlXvlPFDDHNpLOs8CdHV
 IjA4GlScOF7OPwT9pcRGM071x0GYWTh8Wgn0mVNdv0Rxoo1IiIGqq4TK5zpIIApZNXOwhLA2a/k
 AZ07y0q8HbvQe81EKnmSehj+x+iLVjDkZt9h56aDWP5YhwGtuHpgCMkfF02ewBpDQrHV13P0iD6
 H+oGUE1hSy55kEMCiVPTJBIlHcmDNi52EzFUfB7khBClBMrqQx7Mbpdi9ScBNZ4wOw8GEkajwdu
 mqXuEOs5ExYYsCY6MlHlfj8bgHPmwf0R+nCLeOmqYet+Zf2IeDuRn48kN3mLlKq43qR4QaL6Z2D
 05IbriaGdwEBC7mWuNB8Yafy6a0SBgYjJpGwHRPuHG2Iyc0JntJ2w0gKF8ryTs/gykL+H0a7kyo
 +v6o0NzVBaY159Ug+rcEzrFlZ0rg7TzbI6Jfeho5k5ASF6cc4nsa39JGwkAQXY09eDIB864DqoR
 Y8qmW7lShJDoqp1lXJsloIFsbxIRPIK5QnsYmyMHrdYwDhdv09ch5mXpqmrIcVLXle94ZhDmpln
 yTi7RC/Nyqvf/HWtosh9fJl2J0ZHUkqL13AFeNfVLFET+mSE/H0YnUd0a4tlkGYMI40kqWjixxj
 ZoZbCpUketx9VaQ==
X-Developer-Key: i=jeremie.dautheribes@bootlin.com; a=openpgp;
 fpr=FB14AD9086DBB842904804092B005EA01B5A8F03
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29_via_U-Bo?=
 =?utf-8?q?ot?= <u-boot@lists.u-boot-project.org>
Reply-To: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add a new binman etype which allows signing both the SPL and U-Boot proper
sections of i.MX93 flash.bin using CST.
The implementation is largely derived from the nxp_imx8mcst etype, as the
signing procedures for both platforms are quite similar.

Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
---
 .gitignore                         |   2 +
 tools/binman/etype/nxp_imx93cst.py | 143 +++++++++++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+)

diff --git a/.gitignore b/.gitignore
index 0e09715cc60..5cb135fc58c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -82,6 +82,8 @@ fit-dtb.blob*
 /keep-syms-lto.*
 /*imx8mimage*
 /*imx8mcst*
+/*imx9image*
+/*imx93cst*
 /*rcar4-sa0*
 /drivers/video/u_boot_logo.bmp.S
 /test/fdt_overlay/test-fdt-overlay-stacked.dtbo.S
diff --git a/tools/binman/etype/nxp_imx93cst.py b/tools/binman/etype/nxp_imx93cst.py
new file mode 100644
index 00000000000..e1528b13102
--- /dev/null
+++ b/tools/binman/etype/nxp_imx93cst.py
@@ -0,0 +1,143 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright 2026 (C) Bootlin
+# Author: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
+#
+# Derived from nxp_imx8mcst.py
+# Copyright 2023-2024 Marek Vasut <marex@denx.de>
+
+
+# Entry-type module for generating the i.MX93 code signing tool
+# input configuration file and invocation of cst on generated
+# input configuration file and input data to be signed.
+#
+
+import configparser
+import os
+import struct
+
+from binman.etype.mkimage import Entry_mkimage
+from binman.etype.section import Entry_section
+from dtoc import fdt_util
+from u_boot_pylib import tools
+
+CONTAINER_HDR_TAG = 0x87
+SPL_CONTAINER_OFFSET = 1024  # 0x400
+CONTAINER_HDR_SIZE = 16
+AHAB_IMAGE_ENTRY_FLAGS_OFFSET = 24
+ELE_IMAGE_CORE_AND_TYPE = 0x66
+
+KEY_NAME = "sha384_secp384r1_v3_usr_crt"
+
+CSF_CONFIG_TEMPLATE = f"""
+[Header]
+  Target = AHAB
+  Version = 1.0
+
+[Install SRK]
+  File = "SRK_1_2_3_4_table.bin"
+  Source = "SRK1_{KEY_NAME}.pem"
+  Source index = 0
+  Source set = OEM
+  Revocations = 0x0
+
+[Authenticate Data]
+  File = "data.bin"
+  Offsets	= 0x400	       0x490
+
+"""
+
+
+class Entry_nxp_imx93cst(Entry_mkimage):
+    """NXP i.MX93 CST .cfg file generator and cst invoker"""
+
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node)
+
+    def ReadNode(self):
+        super().ReadNode()
+        self.srk_table = os.getenv(
+            "SRK_TABLE",
+            fdt_util.GetString(self._node, "nxp,srk-table", "SRK_1_2_3_4_table.bin"),
+        )
+        self.srk_crt = os.getenv(
+            "SRK_KEY",
+            fdt_util.GetString(self._node, "nxp,srk-crt", f"SRK1_{KEY_NAME}.pem"),
+        )
+        self.ReadEntries()
+
+    def BuildSectionData(self, required):
+        data, input_fname, uniq = self.collect_contents_to_file(
+            self._entries.values(), "input"
+        )
+
+        if struct.unpack("<B", data[3:4])[0] != CONTAINER_HDR_TAG:
+            # Unknown section type, pass input data through.
+            return data
+
+        hdr_addr = 0
+
+        # The SPL AHAB image can optionally contain and start with the ELE FW,
+        # which is already signed by NXP.
+        # In this case, the SPL container header address is not 0x0.
+
+        flags_offset = CONTAINER_HDR_SIZE + AHAB_IMAGE_ENTRY_FLAGS_OFFSET
+        image_flags = struct.unpack("<I", data[flags_offset : flags_offset + 4])[0]
+        # Detect the ELE FW from the core/type fields of its image entries
+        if (image_flags & 0xFF) == ELE_IMAGE_CORE_AND_TYPE:
+            hdr_addr = SPL_CONTAINER_OFFSET
+
+        # Extract the signing offset from the i.MX container
+        signoffset = struct.unpack("<H", data[hdr_addr + 12 : hdr_addr + 14])[0]
+
+        # The signing offset is relative to the container header address,
+        # so compute the absolute signing offset address
+        signoffset = signoffset + hdr_addr
+
+        # Write out customized data to be signed
+        output_dname = tools.get_output_filename(f"nxp.cst-input-data.{uniq}")
+        tools.write_file(output_dname, data)
+
+        # Generate CST configuration file used to sign payload
+        cfg_fname = tools.get_output_filename(f"nxp.csf-config-txt.{uniq}")
+        config = configparser.ConfigParser()
+        # Do not make key names lowercase
+        config.optionxform = str
+        # Load configuration template and modify keys of interest
+        config.read_string(CSF_CONFIG_TEMPLATE)
+        config["Install SRK"]["File"] = f'"{self.srk_table}"'
+        config["Install SRK"]["Source"] = f'"{self.srk_crt}"'
+        config["Authenticate Data"]["File"] = f'"{output_dname}"'
+        config["Authenticate Data"]["Offsets"] = f"{hdr_addr:#x} {signoffset:#x}"
+
+        with open(cfg_fname, "w") as cfgf:
+            config.write(cfgf)
+
+        output_fname = tools.get_output_filename(f"nxp.csf-output-blob.{uniq}")
+        args = ["-i", cfg_fname, "-o", output_fname]
+        if self.cst.run_cmd(*args) is not None:
+            outdata = tools.read_file(output_fname)
+            return outdata
+        else:
+            # Bintool is missing; just use the input data as the output
+            self.record_missing_bintool(self.cst)
+            return data
+
+    def SetImagePos(self, image_pos):
+        # Customized SoC specific SetImagePos which skips the mkimage etype
+        # implementation and removes the 0x48 offset introduced there. That
+        # offset is only used for uImage/fitImage, which is not the case in
+        # here.
+        upto = 0x00
+        for entry in super().GetEntries().values():
+            entry.SetOffsetSize(upto, None)
+
+            # Give up if any entries lack a size
+            if entry.size is None:
+                return
+            upto += entry.size
+
+        Entry_section.SetImagePos(self, image_pos)
+
+    def AddBintools(self, btools):
+        super().AddBintools(btools)
+        self.cst = self.AddBintool(btools, "cst")

-- 
2.55.0

