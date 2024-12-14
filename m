Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEBFE7716A
	for <u-boot@archiver.kernel.org>; Sat, 14 Dec 2024 22:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA8398006F;
	Sat, 14 Dec 2024 23:48:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="YALLVKzz";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ppdHc7KH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 910538007A; Sat, 14 Dec 2024 23:48:25 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 696B78006C
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 23:48:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Y9hFL6x2Mz9sbh;
 Sat, 14 Dec 2024 23:48:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734216503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ShqQzz+BvWP1NDUAnvegWNL/+LEialnhMhFgWUH3PBM=;
 b=YALLVKzz8HvnjQMW3XXjcxoqz67ut/8nRCDQLocmZB/sA8WIm6duALUcEq0rqk1Pq7Rnsf
 1INKplHazZzVKp3QmyjOkn08VSms12d14WgE4C7GG9fF3Jrd/UnCM+FL2J4ZF1zfhHOr3U
 kZMreD3tpocMJICJF0/A4YWgMLZ/3w7Zf71Svjfb41GgkqFWZBCS6ANLcF0KF6Dmsh4XAc
 cMFurWCUkZ5feb+UFs6zQ0dNlVB8jvQRZw6bTX/pSMPVV5dKprAdXMV7ilnV3ZWmlyYVzR
 iWpJi0+/jMtqgIyJXTzq0wXiYxDCZx8pMkPfzHjVx5QvVNbbSnHCo6gagSYJNw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734216501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ShqQzz+BvWP1NDUAnvegWNL/+LEialnhMhFgWUH3PBM=;
 b=ppdHc7KHUCfxGLJ5QX2rnPxj5dMBGn7V/KP5X9YNJqyKWcdBudT+3sLB6ygKYmpl9V8WpN
 Z+NAp/AEoYW7bMQa4u4D79pVC1caPJJuIjo6JfkBjBxE3Lt1lb7njK837F9zBYg/j5h/xB
 Q6Z1MRfK79II4bdq0sjEVymWSNWGKlSYf1+IFwDAzBubaYcKL5YbKWpAmz05w8PP4EUfHJ
 0l7dCu+qYtIH58Brgq5Q5YCYdpHmcIOOoNhWce12Lz0mj+2TC9QPO/QPyeL3z4YcLbkhOK
 3/IddoSuBbqQhIkxbICydynht15iW9UzSSOtaHxfD5zZjxsFqbKz1L7pB0utnQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] pinctrl: renesas: Convert to IS_ENABLED() macro
Date: Sat, 14 Dec 2024 23:47:43 +0100
Message-ID: <20241214224807.304054-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4kjufrbexkjed67mfqf9n1ottg768w5i
X-MBO-RS-ID: e4db5d28ca4af218ca6
X-Rspamd-Queue-Id: 4Y9hFL6x2Mz9sbh
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

Use the IS_ENABLED() macro to reduce amount of #ifdef use in the driver
and improve code coverage. With IS_ENABLED() macro, the code is compiled
and then optimized out, which prevents bitrot.

In case no PFC table matches the SoC in use, do not probe the driver
and instead exit with -ENODEV. This should never happen under normal
conditions, because this would mean the driver DT compatible string
match happened, but the list in probe() cannot match the model listed
in match data associated with the compatible string on which the match
did happen.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/pinctrl/renesas/pfc.c | 128 ++++++++++++----------------------
 1 file changed, 44 insertions(+), 84 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc.c b/drivers/pinctrl/renesas/pfc.c
index 2f6c3b3d1c7..db6be39a528 100644
--- a/drivers/pinctrl/renesas/pfc.c
+++ b/drivers/pinctrl/renesas/pfc.c
@@ -961,90 +961,50 @@ static int sh_pfc_pinctrl_probe(struct udevice *dev)
 	if (!priv->pfc.regs)
 		return -ENOMEM;
 
-#ifdef CONFIG_PINCTRL_PFC_R8A7790
-	if (model == SH_PFC_R8A7790)
+	if (IS_ENABLED(CONFIG_PINCTRL_PFC_R8A7790) && model == SH_PFC_R8A7790)
 		priv->pfc.info = &r8a7790_pinmux_info;
-#endif
-#ifdef CONFIG_PINCTRL_PFC_R8A7791
-	if (model == SH_PFC_R8A7791)
+	else if (IS_ENABLED(CONFIG_PINCTRL_PFC_R8A7791) && model == SH_PFC_R8A7791)
 		priv->pfc.info = &r8a7791_pinmux_info;
-#endif
-#ifdef CONFIG_PINCTRL_PFC_R8A7792
-	if (model == SH_PFC_R8A7792)
+	else if (IS_ENABLED(CONFIG_PINCTRL_PFC_R8A7792) && model == SH_PFC_R8A7792)
 		priv->pfc.info = &r8a7792_pinmux_info;
-#endif
-#ifdef CONFIG_PINCTRL_PFC_R8A7793
-	if (model == SH_PFC_R8A7793)
+	else if (IS_ENABLED(CONFIG_PINCTRL_PFC_R8A7793) && model == SH_PFC_R8A7793)
 		priv->pfc.info = &r8a7793_pinmux_info;
-#endif
-#ifdef CONFIG_PINCTRL_PFC_R8A7794
-	if (model == SH_PFC_R8A7794)
+	else if (IS_ENABLED(CONFIG_PINCTRL_PFC_R8A7794) && model == SH_PFC_R8A7794)
 		priv->pfc.info = &r8a7794_pinmux_info;
-#endif
-#ifdef CONFIG_PINCTRL_PFC_R8A77951
-	if (model == SH_PFC_R8A7795)
+	else if (IS_ENABLED(CONFIG_PINCTRL_PFC_R8A77951) && model == SH_PFC_R8A7795)
 		priv->pfc.info = &r8a77951_pinmux_info;
-#endif
-#ifdef CONFIG_PINCTRL_PFC_R8A77960
-	if (model == SH_PFC_R8A77960)
+	else if (IS_ENABLED(CONFIG_PINCTRL_PFC_R8A77960) && model == SH_PFC_R8A77960)
 		priv->pfc.info = &r8a77960_pinmux_info;
-#endif
-#ifdef CONFIG_PINCTRL_PFC_R8A77961
-	if (model == SH_PFC_R8A77961)
+	else if (IS_ENABLED(CONFIG_PINCTRL_PFC_R8A77961) && model == SH_PFC_R8A77961)
 		priv->pfc.info = &r8a77961_pinmux_info;
-#endif
-#ifdef CONFIG_PINCTRL_PFC_R8A774A1
-	if (model == SH_PFC_R8A774A1)
+	else if (IS_ENABLED(CONFIG_PINCTRL_PFC_R8A774A1) && model == SH_PFC_R8A774A1)
 		priv->pfc.info = &r8a774a1_pinmux_info;
-#endif
-#ifdef CONFIG_PINCTRL_PFC_R8A774B1
-	if (model == SH_PFC_R8A774B1)
+	else if (IS_ENABLED(CONFIG_PINCTRL_PFC_R8A774B1) && model == SH_PFC_R8A774B1)
 		priv->pfc.info = &r8a774b1_pinmux_info;
-#endif
-#ifdef CONFIG_PINCTRL_PFC_R8A774C0
-	if (model == SH_PFC_R8A774C0)
+	else if (IS_ENABLED(CONFIG_PINCTRL_PFC_R8A774C0) && model == SH_PFC_R8A774C0)
 		priv->pfc.info = &r8a774c0_pinmux_info;
-#endif
-#ifdef CONFIG_PINCTRL_PFC_R8A774E1
-	if (model == SH_PFC_R8A774E1)
+	else if (IS_ENABLED(CONFIG_PINCTRL_PFC_R8A774E1) && model == SH_PFC_R8A774E1)
 		priv->pfc.info = &r8a774e1_pinmux_info;
-#endif
-#ifdef CONFIG_PINCTRL_PFC_R8A77965
-	if (model == SH_PFC_R8A77965)
+	else if (IS_ENABLED(CONFIG_PINCTRL_PFC_R8A77965) && model == SH_PFC_R8A77965)
 		priv->pfc.info = &r8a77965_pinmux_info;
-#endif
-#ifdef CONFIG_PINCTRL_PFC_R8A77970
-	if (model == SH_PFC_R8A77970)
+	else if (IS_ENABLED(CONFIG_PINCTRL_PFC_R8A77970) && model == SH_PFC_R8A77970)
 		priv->pfc.info = &r8a77970_pinmux_info;
-#endif
-#ifdef CONFIG_PINCTRL_PFC_R8A77980
-	if (model == SH_PFC_R8A77980)
+	else if (IS_ENABLED(CONFIG_PINCTRL_PFC_R8A77980) && model == SH_PFC_R8A77980)
 		priv->pfc.info = &r8a77980_pinmux_info;
-#endif
-#ifdef CONFIG_PINCTRL_PFC_R8A77990
-	if (model == SH_PFC_R8A77990)
+	else if (IS_ENABLED(CONFIG_PINCTRL_PFC_R8A77990) && model == SH_PFC_R8A77990)
 		priv->pfc.info = &r8a77990_pinmux_info;
-#endif
-#ifdef CONFIG_PINCTRL_PFC_R8A77995
-	if (model == SH_PFC_R8A77995)
+	else if (IS_ENABLED(CONFIG_PINCTRL_PFC_R8A77995) && model == SH_PFC_R8A77995)
 		priv->pfc.info = &r8a77995_pinmux_info;
-#endif
-#ifdef CONFIG_PINCTRL_PFC_R8A779A0
-	if (model == SH_PFC_R8A779A0)
+	else if (IS_ENABLED(CONFIG_PINCTRL_PFC_R8A779A0) && model == SH_PFC_R8A779A0)
 		priv->pfc.info = &r8a779a0_pinmux_info;
-#endif
-#ifdef CONFIG_PINCTRL_PFC_R8A779F0
-	if (model == SH_PFC_R8A779F0)
+	else if (IS_ENABLED(CONFIG_PINCTRL_PFC_R8A779F0) && model == SH_PFC_R8A779F0)
 		priv->pfc.info = &r8a779f0_pinmux_info;
-#endif
-#ifdef CONFIG_PINCTRL_PFC_R8A779G0
-	if (model == SH_PFC_R8A779G0)
+	else if (IS_ENABLED(CONFIG_PINCTRL_PFC_R8A779G0) && model == SH_PFC_R8A779G0)
 		priv->pfc.info = &r8a779g0_pinmux_info;
-#endif
-#ifdef CONFIG_PINCTRL_PFC_R8A779H0
-	if (model == SH_PFC_R8A779H0)
+	else if (IS_ENABLED(CONFIG_PINCTRL_PFC_R8A779H0) && model == SH_PFC_R8A779H0)
 		priv->pfc.info = &r8a779h0_pinmux_info;
-#endif
+	else
+		return -ENODEV;
 
 	priv->pmx.pfc = &priv->pfc;
 	sh_pfc_init_ranges(&priv->pfc);
@@ -1054,127 +1014,127 @@ static int sh_pfc_pinctrl_probe(struct udevice *dev)
 }
 
 static const struct udevice_id sh_pfc_pinctrl_ids[] = {
-#ifdef CONFIG_PINCTRL_PFC_R8A7790
+#if IS_ENABLED(CONFIG_PINCTRL_PFC_R8A7790)
 	{
 		.compatible = "renesas,pfc-r8a7790",
 		.data = SH_PFC_R8A7790,
 	},
 #endif
-#ifdef CONFIG_PINCTRL_PFC_R8A7791
+#if IS_ENABLED(CONFIG_PINCTRL_PFC_R8A7791)
 	{
 		.compatible = "renesas,pfc-r8a7791",
 		.data = SH_PFC_R8A7791,
 	},
 #endif
-#ifdef CONFIG_PINCTRL_PFC_R8A7792
+#if IS_ENABLED(CONFIG_PINCTRL_PFC_R8A7792)
 	{
 		.compatible = "renesas,pfc-r8a7792",
 		.data = SH_PFC_R8A7792,
 	},
 #endif
-#ifdef CONFIG_PINCTRL_PFC_R8A7793
+#if IS_ENABLED(CONFIG_PINCTRL_PFC_R8A7793)
 	{
 		.compatible = "renesas,pfc-r8a7793",
 		.data = SH_PFC_R8A7793,
 	},
 #endif
-#ifdef CONFIG_PINCTRL_PFC_R8A7794
+#if IS_ENABLED(CONFIG_PINCTRL_PFC_R8A7794)
 	{
 		.compatible = "renesas,pfc-r8a7794",
 		.data = SH_PFC_R8A7794,
 	},
 #endif
-#ifdef CONFIG_PINCTRL_PFC_R8A77951
+#if IS_ENABLED(CONFIG_PINCTRL_PFC_R8A77951)
 	{
 		.compatible = "renesas,pfc-r8a7795",
 		.data = SH_PFC_R8A7795,
 	},
 #endif
-#ifdef CONFIG_PINCTRL_PFC_R8A77960
+#if IS_ENABLED(CONFIG_PINCTRL_PFC_R8A77960)
 	{
 		.compatible = "renesas,pfc-r8a7796",
 		.data = SH_PFC_R8A77960,
 	},
 #endif
-#ifdef CONFIG_PINCTRL_PFC_R8A77961
+#if IS_ENABLED(CONFIG_PINCTRL_PFC_R8A77961)
 	{
 		.compatible = "renesas,pfc-r8a77961",
 		.data = SH_PFC_R8A77961,
 	},
 #endif
-#ifdef CONFIG_PINCTRL_PFC_R8A774A1
+#if IS_ENABLED(CONFIG_PINCTRL_PFC_R8A774A1)
 	{
 		.compatible = "renesas,pfc-r8a774a1",
 		.data = SH_PFC_R8A774A1,
 	},
 #endif
-#ifdef CONFIG_PINCTRL_PFC_R8A774B1
+#if IS_ENABLED(CONFIG_PINCTRL_PFC_R8A774B1)
 	{
 		.compatible = "renesas,pfc-r8a774b1",
 		.data = SH_PFC_R8A774B1,
 	},
 #endif
-#ifdef CONFIG_PINCTRL_PFC_R8A774C0
+#if IS_ENABLED(CONFIG_PINCTRL_PFC_R8A774C0)
 	{
 		.compatible = "renesas,pfc-r8a774c0",
 		.data = SH_PFC_R8A774C0,
 	},
 #endif
-#ifdef CONFIG_PINCTRL_PFC_R8A774E1
+#if IS_ENABLED(CONFIG_PINCTRL_PFC_R8A774E1)
 	{
 		.compatible = "renesas,pfc-r8a774e1",
 		.data = SH_PFC_R8A774E1,
 	},
 #endif
-#ifdef CONFIG_PINCTRL_PFC_R8A77965
+#if IS_ENABLED(CONFIG_PINCTRL_PFC_R8A77965)
 	{
 		.compatible = "renesas,pfc-r8a77965",
 		.data = SH_PFC_R8A77965,
 	},
 #endif
-#ifdef CONFIG_PINCTRL_PFC_R8A77970
+#if IS_ENABLED(CONFIG_PINCTRL_PFC_R8A77970)
 	{
 		.compatible = "renesas,pfc-r8a77970",
 		.data = SH_PFC_R8A77970,
 	},
 #endif
-#ifdef CONFIG_PINCTRL_PFC_R8A77980
+#if IS_ENABLED(CONFIG_PINCTRL_PFC_R8A77980)
 	{
 		.compatible = "renesas,pfc-r8a77980",
 		.data = SH_PFC_R8A77980,
 	},
 #endif
-#ifdef CONFIG_PINCTRL_PFC_R8A77990
+#if IS_ENABLED(CONFIG_PINCTRL_PFC_R8A77990)
 	{
 		.compatible = "renesas,pfc-r8a77990",
 		.data = SH_PFC_R8A77990,
 	},
 #endif
-#ifdef CONFIG_PINCTRL_PFC_R8A77995
+#if IS_ENABLED(CONFIG_PINCTRL_PFC_R8A77995)
 	{
 		.compatible = "renesas,pfc-r8a77995",
 		.data = SH_PFC_R8A77995,
 	},
 #endif
-#ifdef CONFIG_PINCTRL_PFC_R8A779A0
+#if IS_ENABLED(CONFIG_PINCTRL_PFC_R8A779A0)
 	{
 		.compatible = "renesas,pfc-r8a779a0",
 		.data = SH_PFC_R8A779A0,
 	},
 #endif
-#ifdef CONFIG_PINCTRL_PFC_R8A779F0
+#if IS_ENABLED(CONFIG_PINCTRL_PFC_R8A779F0)
 	{
 		.compatible = "renesas,pfc-r8a779f0",
 		.data = SH_PFC_R8A779F0,
 	},
 #endif
-#ifdef CONFIG_PINCTRL_PFC_R8A779G0
+#if IS_ENABLED(CONFIG_PINCTRL_PFC_R8A779G0)
 	{
 		.compatible = "renesas,pfc-r8a779g0",
 		.data = SH_PFC_R8A779G0,
 	},
 #endif
-#ifdef CONFIG_PINCTRL_PFC_R8A779H0
+#if IS_ENABLED(CONFIG_PINCTRL_PFC_R8A779H0)
 	{
 		.compatible = "renesas,pfc-r8a779h0",
 		.data = SH_PFC_R8A779H0,
-- 
2.45.2

