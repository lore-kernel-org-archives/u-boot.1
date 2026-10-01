Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF05CA5FD6
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 16:27:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 929E98123C;
	Thu,  1 Oct 2026 16:27:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1BUEtgXrcmQQ; Thu,  1 Oct 2026 16:27:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AB7B381222
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790872022;
	b=Ja7uD2Z60vfbv+DLNKKmB7DuHqtmxCuKpSocmYrAGwIhZBx/xeH5k35vuIiOE5OPtjZt
	 vPGUU7rO+QxFMZ3PzxJpKoczySFtgVqTJnNXFJqJoYId8kytPpOPDpemyctgp5RppDCgN
	 ZzbPupXevK1lP7oUZWb12MMJkOQ2Ue3A4Os9ULqieWdmgJchThShFo3iXPMyfiLIV9ryA
	 vBXS7yRx2KST+tZbW0RyABxD5ipnvbSHVjhar0HBuRYNGqLr+QnNNFTrcwbhmfjw8RHIJ
	 OBclsWueuiBr6VOSJdsSSFOuRZ+n0NqBMDslx8ZCRhDYdlDwn1+abGOQb67txOo+rkg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790872022;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hDOzg7TayypKLmacIemnVASbQssZF064XWWJSmelFgg=;
	b=QWngnXhfpOPmYKU6zkTeSEbQk0gpAiptMaF03AcxhLO6oRRCGLDZ63iSu1XxGpEphaYb
	 voSg5lKKI8weIbAEbAPV/c9oGch7W46mEeA4Dp06hCQWdwjVLav0KlOXKDUtg11eVis3o
	 RfAXBJJAYoiS9qlZP8vQXKLJ/zgPuxzcCdUY3cgLKB845bEhtjeDaBueeD9eumk3zTnG2
	 AjaZAxIQ8XXTGEoUEWBmsyGSHvIaDXj9WdNeRLLgYOcvGr46k1jYTMqOjQev8gAsBh5gC
	 vrjEc6n0+L4S5By3weTulN2xSYsVpgyRxzcFZWpd+PadMiv5QeLlReoj5zy+YxHkpQA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790872022;
	bh=hDOzg7TayypKLmacIemnVASbQssZF064XWWJSmelFgg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qR/IyX5RaOIcLjYZPRzsx7jTcfTsDC44WHQolxZucCqQmkcr7HbVi7ik+NaOBeOIE
	 ABM5ejCcpLYyRz4USE6S6ai8knBXb1Vd+LFtLrYj/53ttPnZfhjtSHdgJXoHFNPS30
	 Tktx2F9puuWNWxDdcIf58f2FAiz+J9dhsjyO8iRAr6y5z17euzCxukjSsd6+pF1WuX
	 ga+R4o9/BJ+swuPk2NF6e4VW1T+UFdjjstTTB5Otzips7o4vG/OslFzEk9TU6nVknK
	 K/Y0bc/E/oYiVxbS+4OCrWVNisDTzHUaWlr4n085GSZ9JNS1YITZuYiK73/2QXtrCO
	 UWTXIntvMaA3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB7B381222;
	Thu,  1 Oct 2026 16:27:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D690E32A
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:27:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C868640185
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:27:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Iq0Cd-2uuiS2 for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 16:27:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org F38BE40098
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790872020;
 b=QrGBZK8lkhOO8U9FZRysL2hxVsvP63a49vNQIvL3VdKGmQKezxnsgqc/hbnuKiIcmpiw
 uyFT/ioXK4NgTkaLmpU7H50LeDdf6DkXmVrvrFrble3hxVp/tz6+kSNzFJijnTh62y9TP
 r/Hl9NsmsaRg7uD9jj5uYINC6OjKZUSBdX5csSFractlQ2TgeZoSYRfP0vngG4ITYH6uF
 J5hNgfeMn/ytX3Bh71Iwn95Bqoer38NXltqYS5uqjdITy9kRY9oTLBk8QCXaQub+UCTDM
 dIsw0fkTr5qQzP9jvLVE1tsluZy9NLFA6P49YQWbu7PswLrtqIp+QcTtUPi4UqSYEwg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790872020;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
 bh=hDOzg7TayypKLmacIemnVASbQssZF064XWWJSmelFgg=;
 b=EV1jgxuzD1VY4Mit18nDLWKplwMWWlF3BeViEZJfir5JRBW+eGP0IJfyTazn3hdq3eg5
 1/s44do5L3YEP7cIB2HEG+5L6zW60nh7ku2ztk6ux9QmifnwebFa4wAk0OaarehJzx3Q5
 XJjMc0Wh08ZziJdA3/D8haODkvEheyZfxFK2aj8nTSteodnihY5++Yc6LftmddW/OCVDQ
 dwJzlf2VfKz44Z8hAjIcU5uFr8VzbLEj4WUZ+drscbEvZvEw6L1PiSY0Sb2JDg+5Fy9Dw
 JaKybuvIB0yMmv6vvZz5jNxrhNJ6QR6zQRKQBmdbHifdAyuDk09KVAiB13RWVGY+yDQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=c+i2SIgQ; 
 arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=c+i2SIgQ
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F38BE40098
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:26:59 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id EFEE81A18B7;
 Thu,  1 Oct 2026 16:26:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C1A2360343;
 Thu,  1 Oct 2026 16:26:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A9EDE103282DF; 
 Thu,  1 Oct 2026 18:26:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790872015; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=hDOzg7TayypKLmacIemnVASbQssZF064XWWJSmelFgg=;
 b=c+i2SIgQOJq6FEfeBTSHqJS+nS/ZTUMMONvXm46D2y6xnGlHoJ+JGykkAqPcJ73ZYQRHwV
 3sTXrsNEpJqH3w5OVlL0NWFH0M5w3qnS+NEUZf15ne4xFxxkIvWltubeWseWQ1vSiBTTth
 Y3NQzVJ/dNtqU/rBTz07XBCD7n8l9fGTjtRV/OUkkGsVy01GX+w07d45P3Eckj108puO56
 Aq357qkR2VvGVo2FCWpGDn/3kPqwmwPVHKPEtH16F7bFfztoBEENpZH5pKb+d9qllJBs/5
 0j8zHVwprBCiV3lCtG0tizTVCiP27pPV7yfet11t/mxLaGbApx4LVa9uL53/yQ==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Thu, 01 Oct 2026 18:26:20 +0200
Subject: [PATCH v5 3/9] binman: add nxp_imx93cst etype for i.MX93 flash.bin
 signing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-imx93-secureboot-v5-3-d97dea41bd1f@bootlin.com>
References: <20261001-imx93-secureboot-v5-0-d97dea41bd1f@bootlin.com>
In-Reply-To: <20261001-imx93-secureboot-v5-0-d97dea41bd1f@bootlin.com>
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
 Christophe Guerreiro <christophe.guerreiro@non.se.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Lei Xu <lei.xu@nxp.com>, Joseph Guo <qijian.guo@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4913;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=ToHY/lcSpuqeajOv8URgUYHIAZA2lpBFwEO3LAeoo6o=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqvom4wX4OUrcjTAbebEXKD9USUYpoyswCI0K+e
 oRnkM/xX9KJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCar6JuAAKCRArAF6gG1qP
 A386D/9kAuS/XUlMsptczOdEBU3oAYmJZ3PsYEMJt4LvU7y1/jrLgvs1dwl1ZSAbLQHLqSAOY2o
 N/GtfGIZe4sywKkF4y019qWFLlKS5GzxJIq5lz5SPZfXVey1V81/GdAWNHYpX02o531GO2eDaY3
 YQbPQExDHB1nbar25wbf35cBjhmjZG06o8tydiy0BFhSiV1UTcGbB86Up8dsKdA7sxPqJUfe0ir
 AOD8HTy0HlXpL/262DaU9tOKiFKgfgCYNCEzAxAjT8rWNKd209LypyvJ1I0BdkdQt6x8TXGnEZZ
 OhVuKiF4KbUOdLG6iQbpSaDKdf9X4j3sHpSmDyQ2HiM8XnFvc0MMsOOynq/G5+sQI26c04FFsx8
 huCbnW4uJovv7x0CeKocB/au0ogGgZR247Ig2vkM28MVfAyVzmsnxZ97iPvvngkmADc0ynXs4UF
 sGxJAy2DqaQYRz7u93keII7XqfVvDP7XKSdYVn10lC/p22dYgYsSkIN6KWPTz3V/Je6wdJw0FbZ
 IZ+StH+LRnOnAeBT5m5VrRBs0jYt4aslrqT6Q9v/waTnDBM0ziYOpYQQDD41GZ8jtwXuxwd7+g9
 5lXLE8WnnQKQo4WGlyJFzpBQ/oTtyivTE67BugoTbu4++mD++IFWE5jRi78ufKbd6cfV5e4Ew6P
 hpnkKNK1+ZhCMWQ==
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

Reviewed-by: Simon Glass <sjg@chromium.org>
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

