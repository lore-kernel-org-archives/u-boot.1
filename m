Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2493C624D7
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 13:42:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C37FF80DD6;
	Wed,  2 Sep 2026 13:42:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RaY_jgTM4w1h; Wed,  2 Sep 2026 13:42:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788356529;
	bh=xa9XP1pXZrI/hq56WRDHgO5nH8nW5oPGPimbz7pYOng=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fhy4tWq4Rtqf0Be/gCwHt75VC1XGY64r2p85txJlLUtdt0xWsJwKeB790wwzjcc/G
	 acj+m5rJxkPaF9W3mtDu8joXuBvHrcskfZn5AFotaSJgc7Fw+FkxS/zs2H8nk+8kSM
	 e+3Ut/AVBukjjLW3XeAASvSU+Ulcdgl9QRqUxj9T29Ll+bBWvZbm6E+2OpPmfZ7Rp4
	 ZghcE2rS15g1UbeKE1/JOCMgxk1/JlsZUMlkJn74B7lQkpZqc/fm03IT1coDSqN6sF
	 K0pyLoKNj+32E+bl0DbwrkV2HFMeSL82Gbbt4dzEzWE1rf5Fts9vGrZXvTxLom5yWb
	 TR9DB4OcNwdGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E14380D1C;
	Wed,  2 Sep 2026 13:42:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C628E2FD
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:42:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C3B3780AAF
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:42:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UaLs9RubZ8PK for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 13:42:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=GBLll3nH
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B7A7F809D3
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:42:07 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id E58DB4E414CD;
 Wed,  2 Sep 2026 13:42:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B8DA86053C;
 Wed,  2 Sep 2026 13:42:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9B18D11C7977F; 
 Wed,  2 Sep 2026 15:41:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788356520; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=xa9XP1pXZrI/hq56WRDHgO5nH8nW5oPGPimbz7pYOng=;
 b=GBLll3nH7RwKIO40QQlxtzMIS/MLLcC8XbPN5U3449oF9ubE1dFA/hv1cRRiq7CCWxXz9m
 GXP1pN7xp+tvPecGq+fF5RH9lg56f+4UTxI1joIIdpV6J1a0G9OAzUPl3xGzqoQ1Cu8CJs
 d6g4r82QHDr75fI3cAiCCD7W9KPFHOZOgqvcROgd+QN2DrZEbhMGZnQO5CY5REMlg8Xh9i
 ul2pRhGzi87qvN2oXkybLhWUce/F2Y3DJsz/+jMsha4Im1b5PqyWWYQWg0/1ra/QfIWynP
 YFhx5gsfYPcFsviXvUc4wf+Y1xB+XUfzj/XfoPHBGlv204bl6B2/1TWu0vk0og==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Wed, 02 Sep 2026 15:41:31 +0200
Subject: [PATCH v2 4/7] imx93-u-boot: wrap SPL and U-Boot nodes in a CST
 node if AHAB_BOOT enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260902-imx93-secureboot-v2-4-5947b92a5072@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2229;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=ZkEmdyR3F1pUrAFHik1ktGcW3RljQLHrC1VaN9f6v+g=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqmCeV8Y+ycu6OPJhyRzXggJ/qHkKSF2+IlXfwn
 Wlfn6MnWHOJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCapgnlQAKCRArAF6gG1qP
 A5QoEACGHtdIJiCaerlQtRwbWN9IGECnxDBe7aiXEDDPyrRxI8BkRcDPLEcYrwU2nMmFb/UDkfh
 Ohnq0heERjW/4DOA/A5ULPsQ4jNT1lXRc1q9XNHPUulfYIzwiCupDotDtyTHJMI8anIRptyD6+z
 rc1UDoCLc8nUQ63ikC7O7fOc/BLKoqTp59SEl35cGQ4v0UnS6iEr2v4s3/v8FmQ/NMBNumgbyly
 FXPx+zL9eXM2KNNsbi8m63QlBkMWijTmhvyPbYG8CllYZD0TPj+bLXE7US0HPV7uzAmgj3oZzK+
 N28EAO5LhJOU7Sui9drk86jkiiabnARsWDseVA1IaC8zFPFoxq3fqZvGouV3brcaJLsZTWgkI4O
 HwYJ/gBdBiLLjGtLeaEDmynmguRWSeX7OCcD4TXgVNYf86mD5xvB+PyJL1k2WgmH/A+7fD0u63m
 xYTnF2qdD0tB3HgmNLlba7uIuGJMYP6zsOWmyjIKVM+XhAQtgVk07zorpYSfrqYIstz/Xlj1PXN
 Rupv6pYxnXJ+sPFC4Rl7zjD2WUIJIYnQSP2PTmvW+gKO6ri2pt5n28KTHy02UzHfLtcM55UEYMJ
 iAzVEnZ4DKhZ5hdaxBG7eJKHZlywYmxr3J+hHZTAuzuJkgw2J3yb4FNmYBygnxbUZ46ZYXO+ko0
 Y0mROBXX6NBjZ7w==
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

When CONFIG_AHAB_BOOT is enabled, wrap the SPL and U-Boot binman nodes in
a CST node so that binman signs them automatically.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
---
 arch/arm/dts/imx93-u-boot.dtsi | 54 +++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/arch/arm/dts/imx93-u-boot.dtsi b/arch/arm/dts/imx93-u-boot.dtsi
index bd970c955cf..569b3ef5d9c 100644
--- a/arch/arm/dts/imx93-u-boot.dtsi
+++ b/arch/arm/dts/imx93-u-boot.dtsi
@@ -47,32 +47,48 @@
 			filename = "flash.bin";
 			pad-byte = <0x00>;
 
-			spl {
-				type = "nxp-imx9image";
-				cfg-path = "spl/u-boot-spl.cfgout";
+#ifdef CONFIG_AHAB_BOOT
+			nxp-imx93cst@0 {
+				filename = "spl.signed.bin";
 				args;
-
-				boot-from = "sd";
-				soc-type = "IMX9";
-				append = "mx93a1-ahab-container.img";
-				container;
-				image = "a55", "u-boot-spl-ddr.bin", "0x2049A000";
+#endif
+				spl {
+					type = "nxp-imx9image";
+					cfg-path = "spl/u-boot-spl.cfgout";
+					args;
+
+					boot-from = "sd";
+					soc-type = "IMX9";
+					append = "mx93a1-ahab-container.img";
+					container;
+					image = "a55", "u-boot-spl-ddr.bin", "0x2049A000";
+				};
+#ifdef CONFIG_AHAB_BOOT
 			};
+#endif
 
-			u-boot {
-				type = "nxp-imx9image";
-				cfg-path = "u-boot-container.cfgout";
+#ifdef CONFIG_AHAB_BOOT
+			nxp-imx93cst@1 {
+				filename = "u-boot-container.signed.bin";
 				args;
-
-				boot-from = "sd";
-				soc-type = "IMX9";
-				container;
-				image0 = "a55", "bl31.bin", "0x204E0000";
-				image1 = "a55", "u-boot.bin", "0x80200000";
+#endif
+				u-boot {
+					type = "nxp-imx9image";
+					cfg-path = "u-boot-container.cfgout";
+					args;
+
+					boot-from = "sd";
+					soc-type = "IMX9";
+					container;
+					image0 = "a55", "bl31.bin", "0x204E0000";
+					image1 = "a55", "u-boot.bin", "0x80200000";
 #if defined(CONFIG_OPTEE)
-				image2 = "a55", "tee.bin", "0x96000000";
+					image2 = "a55", "tee.bin", "0x96000000";
 #endif
+				};
+#ifdef CONFIG_AHAB_BOOT
 			};
+#endif
 		};
 	};
 };

-- 
2.55.0

