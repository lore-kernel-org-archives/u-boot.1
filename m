Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08262606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=T0KH8CJX;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=IO1Q7//7
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D199880BA6;
	Thu, 29 Oct 2026 17:36:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RMJEWOOSRrYR; Thu, 29 Oct 2026 17:36:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DF1288100B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793295367;
	b=Rzywq5JqMvdaUlhMAxpiG6+PiS0rpnTwZSzYrFE2YpRLRJcMjEhCPiWhvRMp9hamug+z
	 GWG95Ml+Ks1VAof/LDIryXE5/+A5YuDhBgivOdxzp93326oDyQFUNiT83CgphbMTrl+ku
	 k3O3kCLWcuTWiuClPc6UgBHaHXrKFAOjquH5btcOCqfBl5VVg4jPi4981iCHj7mIalrMl
	 YFD8dCRTeItZ6VTHIi7E9aGjjP3Q/XtcKPFvJVAx3GZZF140Pm4eNS7WdQpn0A/95gKau
	 LeCHz4Vx3QcdQKeUJR1c6nh8jiQmhDuvbhhllvqR87HUd3Z1rp/v4U6K+UP7sFDWr8g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793295367;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6U03/aHY4mLDJl6QwGZbNhXmwqZe+pqOJ23fFnKg54A=;
	b=BUOqNdQ3x/4wtvU3zxiBTuvG5J65L7h99kSg0LXZW5NvpQ2ZT+IuvCwB08cubafrj3Ec
	 +grJOCRdfEnfIIsc6Qz5NK3KYOFJTsklTcPiNLr33VioisYZv1mfKM+sYpM7iZddrxiwK
	 a2xDbBjtOXdoCsiCDqksl0GaZ2axNCke+5vIIpXkf5R+2pA4fMvwfhUD9VJb694pBl7qs
	 02Pe5Hj/vOuX1OvRdNFBOwT1S3SWjFFon5F8qIPCNjaq8cO6wl46rdul4YoSDXKytrf0Y
	 BAQFUC3a3s5E0akLPKYiFrvWv6SQY0rS7SQTL5oXOU0WMv+OdoUvxsXTHL52ucxDLEw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="IO1Q7//7";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793295367;
	bh=6U03/aHY4mLDJl6QwGZbNhXmwqZe+pqOJ23fFnKg54A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T0KH8CJX78oPgtFrMadUO9VlwuPhEpjrwSE517rI8OQ+UEKztZe6QjbHBtAPfyxER
	 iys/em+vkTfqGgyN6IgTlK6xEtUPLLS2WKp1AJVihKgrmijbAdo72D2o98AeNcudKd
	 AOa5pvoQDMUytjMRCJPW5geQuuljvFPE+fUd7aaBkS+MmU8vMEdz0qeAbpMl+nL71z
	 4rdL44y54/r9LstUQ+UAsAOWEBPdDU7rS+jiqgZecU5tFMLfQcwj5u/neL32E01MNu
	 HnNkzwIxQqO6dCnz4XFgTyVcXws6VpGED3tQVkgAiSNCUVN8hahajqIRD4+NFZ1YYo
	 W8U4k1iMmpEdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF1288100B;
	Thu, 29 Oct 2026 17:36:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EC56D2E5
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:36:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DB2EF80FA7
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:36:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qQpDPopvtZX1 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 17:36:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BDFB980AE8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793295362;
 b=IMbMaUUKw5gizzsVV6c0aZuaNwJmVIGRrOmhphs+lZbFHhKgEvxCDyFChlMe5pnvOV95
 GeDBdNzvCB+owikT0YzoV9YbjGNf1j+5yxxmKDRWqxj0qq7ZKQmk8H68avVAivfhntL/G
 +5jx9a9TZGwxtjjTnuEkGzgQ/LlkgIRkyJBCdS5G5aFXKyUWPMG+KdUYNG1kGbontgp1w
 2cRx2GFt6bzLXvf1KSmRN66wnKa55Svo6cjzrYalOD6wOQRfw5fbKfBUYvX0LWmeibWu+
 WPCawzuijvPbUy8oLPl3P5UNqVjY8IBMSIYLK+DB0ukzlC5tbYSunzqqwkZZCZHkxfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793295362;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
 bh=6U03/aHY4mLDJl6QwGZbNhXmwqZe+pqOJ23fFnKg54A=;
 b=RedsP+3lKTX5uXURcZhwatNkLyjg4AuYTMabZ/rwgsWhoHVmVGXCJOVfBECqFauILhFT
 P/ReG68W+IMsHuizWhRWvwRi53fR+lT8wldgeMcCgYSAm8Bn8+2GC28hgH4k/FotatkWN
 KmxAz9ctKtk4lcCRVBgF28kI9Eh8RNDz3xQ0dRAKAwrP7ECn/8wHgK5we45WV1JrjGdlI
 nau2/o+RTE1Ihb+FlivXSE0pZ7zWBQI/kMwY9qU+hQIUT65XcYLtDCnwEFbPjq5BWDrH1
 JNmZoKzZw7SN/74qdb9/YGi7condwFUuV/iAItnPrfCCLXoyOVWKsbspnvT3Ij966dw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b="IO1Q7//7"; 
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=IO1Q7//7
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BDFB980AE8
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:36:01 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id F138AC4D3D6;
 Thu, 29 Oct 2026 17:37:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8131F6076A;
 Thu, 29 Oct 2026 17:35:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8656E1032909B; Thu, 29 Oct 2026 18:35:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793295358; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=6U03/aHY4mLDJl6QwGZbNhXmwqZe+pqOJ23fFnKg54A=;
 b=IO1Q7//7j5ieDr8yJYmzbvxuLibsqQbN5Hcm/jFxVxnbaqV3tjCWIMk9kGO+AR6VC0r1PQ
 FrwAEKftmYNFDtgKp9nYlVqSu04wSG8vRtHpkIhccs+xPhd3GQAvT6oCaEees+XxfyT1U1
 6TuKZqzt/sr/IHyU3KTZEURKSmeSV2SV9zDNJJvGmMXazxvA69YaIIdDlNz/X1+UH9Zmha
 Q4tRyzuYEJhFMwkWCo9h8PwzieLnJfQpSCEw3Jz75/4PSLFRE1eMHPBqFwhKluCCMw7zWM
 bX8+GvaNsI2Y6o2Jb1Vxt3whOo72Pjp9YWDuJffpzTqslcxsQjRFRtLXG+4o7w==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Thu, 29 Oct 2026 18:35:26 +0100
Subject: [PATCH v6 3/9] binman: add nxp_imx93cst etype for i.MX93 flash.bin
 signing
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261029-imx93-secureboot-v6-3-27b9c987e25f@bootlin.com>
References: <20261029-imx93-secureboot-v6-0-27b9c987e25f@bootlin.com>
In-Reply-To: <20261029-imx93-secureboot-v6-0-27b9c987e25f@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4839;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=Vtd1lQlnX5e8a1EhufFEuByUB2knlIaddb3DjszAoEI=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBq44Psd9nRmDZxLXGzLYLIfIYl3iB1dhIGUgsIe
 X5UI67ZGzSJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCauOD7AAKCRArAF6gG1qP
 A2+HEACZDoq0VK7sKgMvWANZf5xvCne493H+9I9Gzj1W3hjgZ+uqVoJO1YBG/PJ2t0exa0KIR8g
 6C15ZDbF2m/J+fO/F1n8gK0Q/WGNTFK1DGhd3ISUU4U9B7ULecnedcpW367Dw9WIpglZFLZX4de
 SeVwnbuuPlc+JCVV68VoSWHKq+fTa9JI7tdxmN/44AVUo/Q2upAPRqcCtLs4+4+/5FnRP5u/2XB
 YgQmJlfR85kLp6KxVwdLwgfcTcLiRQkqfHnqUNe/+A8l0T37fUMXrvwDLeiD4rb3aOMX322jqPQ
 4wqYdoIwPAw3Y/q+t08NdoTIaDqzEy/farxwATD+rRE6YSftkvbhxR2Zi5hXB5XK2MLacXUqhMB
 iPy1vXb6vM80AyYoJxi71ewWoakGbberkAldyWImpBFidFD08/OUOT0SMWxBh49IJ+osahyfaOQ
 1YNgPRmY2c1r9M02TKvZJnQhSozFp34/sJm7MoUQgiy0gtrOiQt1c6+R+Vt0zxWxGRcPFL2eYak
 D+Af3iQz6oyWdFbOtSEt5MKleTv6JLdxDrXUBWnyNKIP2lKwr/yr153lL3R0YAk+IcgGhW26UCL
 hBglJdQ51kzkOQhMGDp2uJsPVokGJGnUzsPXub+G6IvEJ3xtAGLN9R6WCpz/avmkG32sOIJMZ3+
 kyUV/aZfRhL18FQ==
X-Developer-Key: i=jeremie.dautheribes@bootlin.com; a=openpgp;
 fpr=FB14AD9086DBB842904804092B005EA01B5A8F03
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a binman etype which allows signing the SPL and U-Boot proper
sections of the i.MX93 flash.bin using CST and AHAB. The implementation
reuses the shared functionality from the nxp_imxcst base etype.

Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
---
 .gitignore                         |   2 +
 tools/binman/etype/nxp_imx93cst.py | 111 +++++++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+)

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
index 00000000000..d89502b2ea4
--- /dev/null
+++ b/tools/binman/etype/nxp_imx93cst.py
@@ -0,0 +1,111 @@
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
2.56.0

