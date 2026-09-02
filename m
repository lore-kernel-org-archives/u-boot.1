Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4FDC624D3
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 13:42:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B11840A58;
	Wed,  2 Sep 2026 13:42:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hp_rKFpL_VOM; Wed,  2 Sep 2026 13:42:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788356523;
	bh=s+vosXfZX09Oom75wGdCDVEHN7P/bhWEvtlqIUofX2M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HSrZG08jDk6AbKjGPnDqOaRZjh/lTRtm74rk7ZXKSI9D3eEtFcc19qaYtxixgwlcF
	 5A57Zese39iX0HFp9pgXcjJNinnjOmD+hk182/o+7HZBPJAOSE5mVl6WJzWKjZKqJy
	 m9/VN6j9vPjczVkixhDAGwXZbnKZWpHgNKMdTX23wxgzhPeoDXDdglXhycggdWWbrL
	 KndrvmmsteaYCG0lXe5e7gYDY6aw27W9fFoqbt0xUqBqwisZidSDUuzcfVjSaJnACQ
	 32zOz8PHIa5su469y82le8mwYuZsXRrxvMwInk3yXOrLyzk4hHa1imB78vJPfYAYLk
	 6n/fdFxYi5TSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3DD5840836;
	Wed,  2 Sep 2026 13:42:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5ABD6498
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:42:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4128D4006F
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:42:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uMh0eEEWoJYm for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 13:42:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=wgrQZ3Ft
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5D04D4004D
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:42:00 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 322C74E414CE;
 Wed,  2 Sep 2026 13:41:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 030506053C;
 Wed,  2 Sep 2026 13:41:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B2B5811C792E0; 
 Wed,  2 Sep 2026 15:41:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788356516; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=s+vosXfZX09Oom75wGdCDVEHN7P/bhWEvtlqIUofX2M=;
 b=wgrQZ3FtllrsHQH9J4G31FpS5kf1LwRSlGuMlq4Xcrp+mKkgvcnpfAezwj3jATPCnsXuwQ
 qivyD/6gzwIkAgZDvpKOtGi63sAMNYExCkgjegnlb2RknuoF9VTgsbQeiHNZ/Sbrqhr/JS
 4sDN9q6WRrDl3AtsICN+TSUcPOABhBJxWKzzZjlsCtOQEkP2HesOlNG/pabc2d+Bc+OrIt
 AmScqAeWxP1skmcF3XzUTDhnsVyqlSGfEKLod+WEKwfZyRGo0TdZd3hwtqBBxivOFaOhFd
 9sWFd8R4l9U1ZPcuX7YOtfu1Ipf1Wysy9GygBZXD7in56JoASY5mhuAEt27B1A==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Wed, 02 Sep 2026 15:41:30 +0200
Subject: [PATCH v2 3/7] tools: binman: add nxp_imx93cst etype for i.MX93
 flash.bin signing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260902-imx93-secureboot-v2-3-5947b92a5072@bootlin.com>
References: <20260902-imx93-secureboot-v2-0-5947b92a5072@bootlin.com>
In-Reply-To: <20260902-imx93-secureboot-v2-0-5947b92a5072@bootlin.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Marek Vasut <marex@nabladev.com>, Denis Mukhin <dmukhin@ford.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Simona Toaca <simona.toaca@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Christophe Guerreiro <christophe.guerreiro@non.se.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4868;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=N8qvNPa18KBg1qdkKVtxeeyM9eXAdu3T+okoo4fHV24=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqmCeU2pi0JinMsvzzjt5C99Uvfk8Dlf1OoR7M1
 Xb8r4bNrvCJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCapgnlAAKCRArAF6gG1qP
 A2mwEADIkxcbNZRoKNIZu/58AukX/rXLUqO0MVt+YIxeH2tshV4aaIk6e8GH8uwLpu+nxsVqtZF
 tfV+BsMx/97TrF3i4rTAmpxltlx4LUtUKn3yjCKntH3vtNxVawDA10mKZZ9XZdZH0RMgErcj8Pm
 seQ279AEeBcmlYur9NoVbvmfbOdIrtp4ayC3Cq8AfK3KcyuOtJmm2c8Pp5RbxC0HTxk6DAHx/kh
 b/qNublanWKBpzBsd2P9yCBUUT6obzrTZslLce1LmJOIdG81eyA8NYO79ZwTvhwTWVVlOdsGNiz
 ijKospQvsLPpG87aQ8KO1/ECteTAPoaWcJOMyNp1zf4eWqL93RzF6AYpwOIyYQSa4/HLEgaTKdh
 Tj7LzhkCpUmeg6a0VquM7rkJwNyg+675/d5tK/0TYyj7siiDRhS2B/uRG9pUttgt6CKNz6Du2yv
 SR5dsgOVZ1WHNkzukfrzahpuJzh9jZk3nnGEH/m4dCs+npSHbs9OqIFPr2NNAocW8DZTpxgr5LA
 1CkpqOPW8qLuxc9x6Br5BSpRSgndtDuKVkKVPxXKH8KWYwf4fBfym2u3CWyf4QxVgjENEXmfFXz
 CqpBN/BdN7LI1JhcniZxC8DWpPGoNm2twjih3fj/QSMfXLkPt+p5GIb2fHNO0mneh8vSf59Y0Ta
 cQXMAvAvDkBvO0g==
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add a binman etype which allows signing the SPL and U-Boot proper
sections of the i.MX93 flash.bin using CST and AHAB. The implementation
reuses the shared functionality from the nxp_imxcst base etype.

Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
---
 .gitignore                         |   2 +
 tools/binman/etype/nxp_imx93cst.py | 112 +++++++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+)

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
index 00000000000..41326728c5d
--- /dev/null
+++ b/tools/binman/etype/nxp_imx93cst.py
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright 2026 (C) Bootlin
+# Author: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
+#
+# Derived from nxp_imx8mcst.py
+# Copyright 2023-2024 Marek Vasut <marex@denx.de>
+
+# Entry-type module for generating the i.MX93 code signing tool
+# input configuration file and invocation of cst on generated
+# input configuration file and input data to be signed.
+#
+
+import os
+import struct
+
+from binman.etype.nxp_imxcst import Entry_nxp_imxcst
+from dtoc import fdt_util
+
+CONTAINER_HDR_TAG = 0x87
+SPL_CONTAINER_OFFSET = 1024  # 0x400
+CONTAINER_HDR_SIZE = 16
+AHAB_IMAGE_ENTRY_FLAGS_OFFSET = 24
+ELE_IMAGE_CORE_AND_TYPE = 0x66
+
+KEY_NAME = 'sha384_secp384r1_v3_usr_crt'
+
+CSF_CONFIG_TEMPLATE = f'''
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
+  Offsets = 0x0 0x0
+
+'''
+
+
+class Entry_nxp_imx93cst(Entry_nxp_imxcst):
+    """NXP i.MX93 CST .cfg file generator and cst invoker
+
+    Properties / Entry arguments:
+        - nxp,srk-table - full path to SRK_1_2_3_4_table.bin
+        - nxp,srk-crt - full path to the SRK Key SRK1_sha384_secp384r1_v3_usr_crt.pem
+
+    The nxp,srk-table and nxp,srk-crt properties can be overridden with
+    the SRK_TABLE and SRK_KEY environment variables, respectively.
+    """
+
+    def ReadNode(self):
+        super().ReadNode()
+        self.srk_crt = os.getenv(
+            'SRK_KEY',
+            fdt_util.GetString(self._node, 'nxp,srk-crt', f'SRK1_{KEY_NAME}.pem'),
+        )
+        self.ReadEntries()
+
+    def BuildSectionData(self, required):
+        data, _, uniq = self.collect_contents_to_file(self._entries.values(), 'input')
+
+        flags_offset = CONTAINER_HDR_SIZE + AHAB_IMAGE_ENTRY_FLAGS_OFFSET
+
+        # Give up early if the input is too short to contain the container
+        # header fields read below
+        if len(data) < flags_offset + 4:
+            return data
+
+        if data[3] != CONTAINER_HDR_TAG:
+            # Unknown section type, pass input data through.
+            return data
+
+        hdr_addr = 0
+
+        # The SPL AHAB image can optionally contain and start with the ELE FW,
+        # which is already signed by NXP.
+        # In this case, the SPL container header address is not 0x0.
+
+        image_flags = struct.unpack('<I', data[flags_offset : flags_offset + 4])[0]
+        # Detect the ELE FW from the core/type fields of its image entries
+        if (image_flags & 0xFF) == ELE_IMAGE_CORE_AND_TYPE:
+            hdr_addr = SPL_CONTAINER_OFFSET
+
+        # Extract the signing offset from the i.MX container
+        signoffset = struct.unpack('<H', data[hdr_addr + 12 : hdr_addr + 14])[0]
+
+        # The signing offset is relative to the container header address,
+        # so compute the absolute signing offset address
+        signoffset = signoffset + hdr_addr
+
+        # Write out customized data to be signed
+        output_dname = self.write_input_data(data, uniq)
+
+        # Generate CST configuration file used to sign payload
+        config = self.get_config(CSF_CONFIG_TEMPLATE)
+        config['Install SRK']['File'] = f'"{self.srk_table}"'
+        config['Install SRK']['Source'] = f'"{self.srk_crt}"'
+        config['Authenticate Data']['File'] = f'"{output_dname}"'
+        config['Authenticate Data']['Offsets'] = f'{hdr_addr:#x} {signoffset:#x}'
+
+        cfg_fname = self.write_config(config, uniq)
+
+        outdata = self.run_cst(cfg_fname, uniq)
+        if outdata is not None:
+            return outdata
+        return data

-- 
2.55.0

