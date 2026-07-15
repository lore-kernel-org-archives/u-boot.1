Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12536C4450E
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:30:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77B1184C28;
	Wed, 15 Jul 2026 16:28:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="MHjUyLuV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27C5E84C1D; Wed, 15 Jul 2026 16:28:43 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CE0884B43
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:28:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-493ae59eca6so12184325e9.1
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784125720; x=1784730520; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rKt8u3QY2q4/HoheeK/ztffK06AV9CGKv4aZENrmaoA=;
 b=MHjUyLuVpFpDq2zjry2u4hcq7UbgH2zRLkroZKkeyCSYRs/bvKzPwTxMA7XrvWIBRu
 Sf4RzVLsNHWNNCikzrcKA87yUmOSrSd4xoeOSOJ8UrVp/Sh69F7ND6y79RnjRtmoUKwT
 0EH0HQmXbu56FLBf2mMFO5tdKbTwt8e0XH/Cp0/1C4fVHKi13nBUy3b7CPhDIT37a0NB
 MSbM4uUiAPFRrZaoaUw/ZGQJfOW62xF3fYrNjx9btGswP6BCl/mJ0dIA33iJjbMJ1p0J
 JQ9p/sL8JD8YL3gZzyLpbNTnsCN3QHbuzudUAc1EVTYe4L6uY4fQnHv7A/zALDo/DE7J
 T3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125720; x=1784730520;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rKt8u3QY2q4/HoheeK/ztffK06AV9CGKv4aZENrmaoA=;
 b=Xo0p1R3EMVAJm4WrpYUd2oEjJGlMwMFjo0SfJfvLy1eh6yjuKj8gF0DT2iGAOvNVk4
 K18PRiD2UMrYhKblzG1hY/MRH0dpgSDnwIwdItuE1A5Y/fpXmE38FUkoMT05H54r5aBA
 ckvCFQ+Iodu6Has3iEBr856bW2SJrq1pB9PE5cf1Xd/DuMiJuoynNFJKvhR7ARHyW1XP
 nqKy5r3UuaYm4aGJ2zGtXPnwWTwkLWIvas/eGx4nEBm4i3FteAZKjbd2ebkRxb9Hk9tb
 hrFvpbkTv/q/2yYpaMF0UG8mNyr2nYLGIZbEMLnmHwMkSx9coqnyW5g21L9DMOGSuzNB
 bTvQ==
X-Gm-Message-State: AOJu0Yw002BuOsyyJCiSGTqkfdICmlrMWGo2eYmxUY0JuVqkZFpsg0kL
 xxveMZ1TVsemZ8HYp/y1nPAkJR+Jc4ySkBufW4wBAQyOcnaIx+OmxkPZYOe4LJmZgNs=
X-Gm-Gg: AfdE7cks+4eGJQHaNrbLkGt7qzrdW8m6tsAZ1nA4JQTcqJ7W5yX7x4Ji4rDyX1UBqR8
 V402tBxYcp39CoUXKcFu5CIPfFLoPAlwu/z3lPJYr5837XZo0/ojO+zzAc5lCfBQILbdK1kICuz
 baFFZcrukiz3McU7qZjoaajVw+jO88I7S3sVxjf9xETxKxbFVHKYm9aeTQTyhEX+CCxvikQ4toy
 xN0HFhHHRBpPIU7SP9i5oGQdPuUPc47CfuiM04gR25DAoKcwlNMVXGANqowdNEsSd0j49upxiSU
 DGPt1wPmc0Hjqb23ypS6VED/YumBRPq24pcuRODPLabYt7KiOkHLR74q4xbpSuZd3oFjfgYr6Kz
 plQetIR/1p/MVDltuY28Zre/uLn5/AuQeQV9h1HRROiAMNLI8fCiE/dxORvH5tr50mcukina0GI
 CmQrjpUhRv/l8dHLJHeTk4hMv6kFa739oT7VtE+FoEVaitxTiH0XNM8Q6tC6KEh5wBsspSyscp3
 Ck5K4wehOm62+K+BFp4cmwAj37U/Pp+4KVWpOp8GJyjoe4Dj6tPyAGrrJu8/AlXj+w6d2StA/+t
 bEKz7Ow=
X-Received: by 2002:a05:600d:8444:10b0:493:e46a:ab with SMTP id
 5b1f17b1804b1-493f8837638mr146753735e9.34.1784125720558; 
 Wed, 15 Jul 2026 07:28:40 -0700 (PDT)
Received: from [192.168.1.62]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm151881745e9.5.2026.07.15.07.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:28:40 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 15 Jul 2026 16:28:43 +0200
Subject: [PATCH v2 15/32] clk: mediatek: mt7988: deduplicate clock gate drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-15-23e907516010@baylibre.com>
References: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-0-23e907516010@baylibre.com>
In-Reply-To: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-0-23e907516010@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, Daniel Golle <daniel@makrotopia.org>, 
 Julien Stephan <jstephan@baylibre.com>, Sam Shih <sam.shih@mediatek.com>
X-Mailer: b4 0.15.2
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

MT7988 declares a separate U_BOOT_DRIVER, probe() function and compatible
table for each clock gate controller, despite all of them sharing the same
implementation.

Describe the gates directly in each controller's struct mtk_clk_tree,
reference the trees from the driver data and use the generic
mtk_clk_topckgen_ops. The two sgmiisys controllers, which share the same DM
flags and (absent) bind() callback, are merged into a single U_BOOT_DRIVER;
ethdma and ethwarp keep their own drivers since they bind reset controllers
at different offsets.

This also stops using mtk_common_clk_gate_init() and struct mtk_cg_priv,
which are scheduled for removal.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7988.c | 104 ++++++++++++++++++--------------------
 1 file changed, 49 insertions(+), 55 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index ebad78a9151..2a848032c8a 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -838,10 +838,12 @@ static const struct mtk_clk_tree mt7988_infracfg_clk_tree = {
 	.type = MTK_CLK_TREE_INFRASYS,
 };
 
-static const struct mtk_clk_tree mt7988_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-};
+static int mt7988_clk_probe(struct udevice *dev)
+{
+	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
+
+	return mtk_common_clk_init(dev, tree);
+}
 
 static const struct udevice_id mt7988_fixed_pll_compat[] = {
 	{ .compatible = "mediatek,mt7988-fixed-plls" },
@@ -933,11 +935,12 @@ static const struct mtk_gate ethdma_mtk_gate[] = {
 	GATE_ETHDMA(CLK_ETHDMA_FE_EN, "ethdma_fe_en", CLK_TOP_NETSYS_2X_SEL, 6),
 };
 
-static int mt7988_ethdma_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt7988_clk_tree, ethdma_mtk_gate,
-					ARRAY_SIZE(ethdma_mtk_gate), 0);
-}
+static const struct mtk_clk_tree mt7988_ethdma_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates = ethdma_mtk_gate,
+	.num_gates = ARRAY_SIZE(ethdma_mtk_gate),
+};
 
 static int mt7988_ethdma_bind(struct udevice *dev)
 {
@@ -955,6 +958,7 @@ static int mt7988_ethdma_bind(struct udevice *dev)
 static const struct udevice_id mt7988_ethdma_compat[] = {
 	{
 		.compatible = "mediatek,mt7988-ethdma",
+		.data = (ulong)&mt7988_ethdma_clk_tree
 	},
 	{}
 };
@@ -963,10 +967,10 @@ U_BOOT_DRIVER(mt7988_clk_ethdma) = {
 	.name = "mt7988-clock-ethdma",
 	.id = UCLASS_CLK,
 	.of_match = mt7988_ethdma_compat,
-	.probe = mt7988_ethdma_probe,
+	.probe = mt7988_clk_probe,
 	.bind = mt7988_ethdma_bind,
-	.priv_auto = sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
+	.priv_auto = sizeof(struct mtk_clk_priv),
+	.ops = &mtk_clk_topckgen_ops,
 };
 
 /* SGMIISYS_0 */
@@ -991,27 +995,11 @@ static const struct mtk_gate sgmiisys_0_mtk_gate[] = {
 	GATE_SGMII0(CLK_SGM0_RX_EN, "sgm0_rx_en", CLK_TOP_XTAL, 3),
 };
 
-static int mt7988_sgmiisys_0_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt7988_clk_tree,
-					sgmiisys_0_mtk_gate,
-					ARRAY_SIZE(sgmiisys_0_mtk_gate), 0);
-}
-
-static const struct udevice_id mt7988_sgmiisys_0_compat[] = {
-	{
-		.compatible = "mediatek,mt7988-sgmiisys_0",
-	},
-	{}
-};
-
-U_BOOT_DRIVER(mt7988_clk_sgmiisys_0) = {
-	.name = "mt7988-clock-sgmiisys_0",
-	.id = UCLASS_CLK,
-	.of_match = mt7988_sgmiisys_0_compat,
-	.probe = mt7988_sgmiisys_0_probe,
-	.priv_auto = sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
+static const struct mtk_clk_tree mt7988_sgmiisys_0_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates = sgmiisys_0_mtk_gate,
+	.num_gates = ARRAY_SIZE(sgmiisys_0_mtk_gate),
 };
 
 /* SGMIISYS_1 */
@@ -1036,27 +1024,32 @@ static const struct mtk_gate sgmiisys_1_mtk_gate[] = {
 	GATE_SGMII1(CLK_SGM1_RX_EN, "sgm1_rx_en", CLK_TOP_XTAL, 3),
 };
 
-static int mt7988_sgmiisys_1_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt7988_clk_tree,
-					sgmiisys_1_mtk_gate,
-					ARRAY_SIZE(sgmiisys_1_mtk_gate), 0);
-}
+static const struct mtk_clk_tree mt7988_sgmiisys_1_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates = sgmiisys_1_mtk_gate,
+	.num_gates = ARRAY_SIZE(sgmiisys_1_mtk_gate),
+};
 
-static const struct udevice_id mt7988_sgmiisys_1_compat[] = {
+static const struct udevice_id of_match_mt7988_sgmiisys[] = {
+	{
+		.compatible = "mediatek,mt7988-sgmiisys_0",
+		.data = (ulong)&mt7988_sgmiisys_0_clk_tree
+	},
 	{
 		.compatible = "mediatek,mt7988-sgmiisys_1",
+		.data = (ulong)&mt7988_sgmiisys_1_clk_tree
 	},
 	{}
 };
 
-U_BOOT_DRIVER(mt7988_clk_sgmiisys_1) = {
-	.name = "mt7988-clock-sgmiisys_1",
+U_BOOT_DRIVER(mt7988_clk_sgmiisys) = {
+	.name = "mt7988-clock-sgmiisys",
 	.id = UCLASS_CLK,
-	.of_match = mt7988_sgmiisys_1_compat,
-	.probe = mt7988_sgmiisys_1_probe,
-	.priv_auto = sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
+	.of_match = of_match_mt7988_sgmiisys,
+	.probe = mt7988_clk_probe,
+	.priv_auto = sizeof(struct mtk_clk_priv),
+	.ops = &mtk_clk_topckgen_ops,
 };
 
 /* ETHWARP */
@@ -1083,12 +1076,12 @@ static const struct mtk_gate ethwarp_mtk_gate[] = {
 		     CLK_TOP_NETSYS_MCU_SEL, 15),
 };
 
-static int mt7988_ethwarp_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt7988_clk_tree,
-					ethwarp_mtk_gate,
-					ARRAY_SIZE(ethwarp_mtk_gate), 0);
-}
+static const struct mtk_clk_tree mt7988_ethwarp_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates = ethwarp_mtk_gate,
+	.num_gates = ARRAY_SIZE(ethwarp_mtk_gate),
+};
 
 static int mt7988_ethwarp_bind(struct udevice *dev)
 {
@@ -1106,6 +1099,7 @@ static int mt7988_ethwarp_bind(struct udevice *dev)
 static const struct udevice_id mt7988_ethwarp_compat[] = {
 	{
 		.compatible = "mediatek,mt7988-ethwarp",
+		.data = (ulong)&mt7988_ethwarp_clk_tree
 	},
 	{}
 };
@@ -1114,8 +1108,8 @@ U_BOOT_DRIVER(mt7988_clk_ethwarp) = {
 	.name = "mt7988-clock-ethwarp",
 	.id = UCLASS_CLK,
 	.of_match = mt7988_ethwarp_compat,
-	.probe = mt7988_ethwarp_probe,
+	.probe = mt7988_clk_probe,
 	.bind = mt7988_ethwarp_bind,
-	.priv_auto = sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
+	.priv_auto = sizeof(struct mtk_clk_priv),
+	.ops = &mtk_clk_topckgen_ops,
 };

-- 
2.54.0

