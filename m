Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4DC8C44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:29:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3433484BF0;
	Wed, 15 Jul 2026 16:28:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="MQRtueY3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED2FF84BB8; Wed, 15 Jul 2026 16:28:35 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB4DF84BD8
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:28:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-493b779003fso23957565e9.3
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784125713; x=1784730513; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sS1GbsFtBI6yUsnICY4HF0oQOP4m8O6aJvx1WVY1voI=;
 b=MQRtueY3KYwhY03l6hLk+c79Ld1AZnkJjCPcZnfmd+epFoV2mLrs6bucoN1UZyze9f
 kP1Vzu3DAqX5x9DSDZ7jjMnTzM0EB2hnXt4qZAAiA1g6oZtuO96F+wonjKC1OlpB9hdi
 G3j1OaSdq+4W4R8s1xtIHY5BjHfFeLqfOGxH9HNnZUEklktcDqkrK34geu8nOdWAcuU/
 Z07mFxYf7JLUFNd+0E8X2uguJK+WZF1YLbljZO4/LY2cBWOR+rCgshTMvYVHjerLngNp
 Yq777gdS/OXNYaJtg4mc9cypz1LusxLZpD1qu8YV1rpzn/mdNz36ZfR4qTv9af/s307Q
 bgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125713; x=1784730513;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sS1GbsFtBI6yUsnICY4HF0oQOP4m8O6aJvx1WVY1voI=;
 b=h44w0fCAcn3pgb4BsfZVm1qkrPZIUuqQ31ALhFU9BjfkpsNNeaIle16o+XkJaiBTS6
 mwClJonyhVUwEk+8BQKeb0yGAIRtRDzSCWkVXRDE80TQdbbF1XQqe7GgzGfFValigv5c
 hIOyhac6kQ5hmDk9ViNlvyTzWoWhqEYFfT5+z4IUk7o/5n6LU5jRAJRFtBlWWrn/uaQo
 vwzjNPX38BR1iBNlvC01cFbTmgZeyO6oKYk8+UBlGAeWIK8Wch2aHkYXENucK+54vo1g
 Ndt/VRJ1qqSXNBHFwm4VZIRlMnfbGBsacWShvUTXk0WU0dYrkNTrvBILeTPE36XCDV1w
 404A==
X-Gm-Message-State: AOJu0YxHMzLrJ/b3Md7x4apJOllqt3uRrHKOi1quopL/j6TGh05ezjl4
 dBtoSBkKtKXPPVaIvsDDntMtPfhl7q6kV6mBqEIJk30ADEEqu6wBXllA06AYXvnb0Cc=
X-Gm-Gg: AfdE7ckQWHnuRytkBc/j7gga6N3l+JveAmbp5PHqhUqC8HKjpkDcM1sDV+Mi6UNqHOg
 Y4uYargr16vrdbipuAiZr38WYGK0SHtrQWtqrbJc8z41ha94wvfwiP3ZPmL0A64TvLec5hsZk27
 308SiEq98QwyIvm0eWOEm4RL1FNAaz+YBlsqeson2GnKdO+TjVhtrfCZr212175auzDdVC9I9C6
 jdtXfGtEoQ7cwBLgehIjM8BEcrIEDZfySXrM48dV3DAlfgGaT8AGoqbQx65LFIBoS/tG2h1vD0n
 2jwZ0aD3+aKHeWmA09iihmtlYO4iJ+taUP7MxYInJI2oxuNskwDz6GfMRA1hM7UC+jFvEqJodR8
 n5CRxWiFyd2Gf/1VREIp9rtw9V7FJuda5EY+LPfKr65WnFLvlUwduwpQ3Kvn+HSm+3mofbyv/pj
 mooEVAz9aE1uAI/W0ltxmPiU+KZf2JRpP1f6wBsYsS5Sp9v5TgrmunLKsUe6goNclgin23214cr
 /fcDLSchgI8BYAV+ujevjRr7JPqPwyVW8ud1aiXvD8Yo47AASDHDDAX7hIo44so6/rUPRaa
X-Received: by 2002:a05:600c:e548:10b0:493:bc31:b2ae with SMTP id
 5b1f17b1804b1-495389957a1mr54317775e9.10.1784125713237; 
 Wed, 15 Jul 2026 07:28:33 -0700 (PDT)
Received: from [192.168.1.62]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm151881745e9.5.2026.07.15.07.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:28:32 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 15 Jul 2026 16:28:38 +0200
Subject: [PATCH v2 10/32] clk: mediatek: mt7981: use driver data to store
 the clock tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-10-23e907516010@baylibre.com>
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

Pass each controller's struct mtk_clk_tree through the driver data and use
the generic probe function for the MT7981 clock drivers, instead of a
dedicated probe per controller.

The fixed-pll, topckgen and infracfg controllers keep their own U_BOOT_DRIVER
since they rely on dedicated ops and on the parent bind() callback, but they
now get their tree from the compatible data. The topckgen probe still
performs its SoC specific register tweaks.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7981.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index 7efe0dcdf53..b1e08cd2dd0 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -664,29 +664,34 @@ static int mt7981_clk_probe(struct udevice *dev)
 }
 
 static const struct udevice_id mt7981_fixed_pll_compat[] = {
-	{ .compatible = "mediatek,mt7981-fixed-plls" },
-	{ .compatible = "mediatek,mt7981-apmixedsys" },
+	{
+		.compatible = "mediatek,mt7981-fixed-plls",
+		.data = (ulong)&mt7981_fixed_pll_clk_tree
+	},
+	{
+		.compatible = "mediatek,mt7981-apmixedsys",
+		.data = (ulong)&mt7981_fixed_pll_clk_tree
+	},
 	{}
 };
 
 static const struct udevice_id mt7981_topckgen_compat[] = {
-	{ .compatible = "mediatek,mt7981-topckgen" },
+	{
+		.compatible = "mediatek,mt7981-topckgen",
+		.data = (ulong)&mt7981_topckgen_clk_tree
+	},
 	{}
 };
 
-static int mt7981_fixed_pll_probe(struct udevice *dev)
-{
-	return mtk_common_clk_init(dev, &mt7981_fixed_pll_clk_tree);
-}
-
 static int mt7981_topckgen_probe(struct udevice *dev)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(dev);
+	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
 
 	priv->base = dev_read_addr_ptr(dev);
 	writel(MT7981_CLK_PDN_EN_WRITE, priv->base + MT7981_CLK_PDN);
 
-	return mtk_common_clk_init(dev, &mt7981_topckgen_clk_tree);
+	return mtk_common_clk_init(dev, tree);
 }
 
 U_BOOT_DRIVER(mt7981_clk_apmixedsys) = {
@@ -694,7 +699,7 @@ U_BOOT_DRIVER(mt7981_clk_apmixedsys) = {
 	.id = UCLASS_CLK,
 	.of_match = mt7981_fixed_pll_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt7981_fixed_pll_probe,
+	.probe = mt7981_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_fixed_pll_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -712,21 +717,19 @@ U_BOOT_DRIVER(mt7981_clk_topckgen) = {
 };
 
 static const struct udevice_id mt7981_infracfg_compat[] = {
-	{ .compatible = "mediatek,mt7981-infracfg" },
+	{
+		.compatible = "mediatek,mt7981-infracfg",
+		.data = (ulong)&mt7981_infracfg_clk_tree
+	},
 	{}
 };
 
-static int mt7981_infracfg_probe(struct udevice *dev)
-{
-	return mtk_common_clk_init(dev, &mt7981_infracfg_clk_tree);
-}
-
 U_BOOT_DRIVER(mt7981_clk_infracfg) = {
 	.name = "mt7981-clock-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = mt7981_infracfg_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt7981_infracfg_probe,
+	.probe = mt7981_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_infrasys_ops,
 	.flags = DM_FLAG_PRE_RELOC,

-- 
2.54.0

