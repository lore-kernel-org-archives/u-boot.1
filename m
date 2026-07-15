Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A5DC44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:29:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C0A784BC3;
	Wed, 15 Jul 2026 16:28:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="UkirdwhN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 066EA84BBD; Wed, 15 Jul 2026 16:28:32 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6BC684ACE
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:28:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09aaso3816209f8f.3
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784125709; x=1784730509; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2xp3SE/+KSBWHyl/DPlLaaWO4QsXRD6Pa2bCf8iMo38=;
 b=UkirdwhNWyYT6dfZTTXhCcuOUIZx9Qa9xRrZ+EfLWLEjUdifPdI5PXIFBXCXU/iY7H
 bKkqa62MlmhhYjdHO6fiwr5KzsdwlVSZP5QKNc/zzFTnxI7AFBCCXyy+SomSGWE4Q/9K
 XvQSLZ0epEMb6pG0tyCI7eWlv1gAvNVV0EXhuS5AgIEMnRSp+LT6ZrP6S8tRIblNZiGj
 OJMqVzsivnX0w5mSE9Pqf6BGN8URAcyOPMVCFqzvyciMmP4YBySOookig9fTCGJnjjw0
 FXkS9bgfs1kCh8heiNCXE579jYzjVUwlgSw/jz2sgVATkPyel00Z2cUgGqrMT6aFdfiW
 OUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125709; x=1784730509;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2xp3SE/+KSBWHyl/DPlLaaWO4QsXRD6Pa2bCf8iMo38=;
 b=ZOFb3/1XoOhcof6MJt/ZoDSgGJ3R742+ff94xuQQuAlcIwkZ0+MWRlYaL/PvTBGGCk
 wZnuQPHbuHvpVXycHGkK9v38LFXjZeHb7H6U7vCgqNapIIVsusjtrHsLB06My6mi5eZd
 hmpQNzGC1NIihhI9SVhqCj71mma0rdoyE4BDkuAszwP5KlS3ynjSkhw/vGSrnBtPx8uq
 qr7rDGoQJv+MUGrXGGkHO0Ao/+8hp2NxSIspX13gO8X9IvhBLpKSF1ddoNulDbw5AtHT
 9hXAV19rJsBZ3PzH7dcmxNPPu4WrWrfRcgjUWhbYCW33ZIULP2XZivIaF9TWMpSvZfh6
 YQLg==
X-Gm-Message-State: AOJu0YyJbv4etl+Li+YiZY8A8vFDnJyaQwONur0qoYuSCdpv+xnvNaVa
 kE4mDlKPDh8Gp6xXRZuFUWIvrbBZwEy1yAy65EjeteO8odwk0f27LcAwIRkkNOqaHTo=
X-Gm-Gg: AfdE7ckjXT450kJ8bl0bhnMHwdQrBGI4buX4HnuCq7N0fEbeiaW30mgZaaKl6xKQ5jZ
 yg+5zWiJvOrpGEOBXiGotWRT/7isq5f3gxgALg4Uvy+f+04Qc37++5b2PZvW+9KoPgufx25nTAn
 nErVQCcroMOcXpxp4H03yGyk6actCYSjfdLOje7yWk4lxr+3lT/cvQa7xcKEWkjcQ2xlC/Lzm+x
 dxeM4oethx/nThQFKMExvX3aT2MH/ug6pvHY1Y1Dg8ZYjGsFOwLqDo8VCLsr4CS3ss0E1WdM+yl
 jBKSgb6F+CalEpR0JfUA2KooFASD2O6wEqfmTA4PRV7TAxYOhOJO5MCNnJ8dnmqt5jUNUSu7RS5
 Sd055rpq/HFAnZ2loag7l3RBhjZNXc+KlLo1U2lWSj+GSRKwzL9ORqk04dFql6IfyMVF3Ks9+J3
 G6FaJr7NBxWJW++N9HNVi/20TlDs15FXSWKC5gUdnwPZfUPd8w/qqxHWqcpKb6qphxbVbCJmZiu
 0mtLIclxJXFoW1mbIPt6AoSK3V2QE++YYMwXtfFDj8jnwGQyUdxQqNJyeDn5VQ/Fuwrzcmb
X-Received: by 2002:a05:600c:6c94:b0:493:f252:85d6 with SMTP id
 5b1f17b1804b1-495158c69a9mr63450745e9.4.1784125709256; 
 Wed, 15 Jul 2026 07:28:29 -0700 (PDT)
Received: from [192.168.1.62]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm151881745e9.5.2026.07.15.07.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:28:28 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 15 Jul 2026 16:28:35 +0200
Subject: [PATCH v2 07/32] clk: mediatek: mt7629: deduplicate clock gate drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-7-23e907516010@baylibre.com>
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

MT7629 declares a separate U_BOOT_DRIVER, probe() function and compatible
table for each clock gate controller, despite all of them sharing the same
implementation.

Describe the gates directly in each controller's struct mtk_clk_tree,
reference the trees from the driver data and use the generic
mtk_clk_topckgen_ops. Controllers that share the same DM flags and bind()
callback are then merged: infracfg and pericfg into one pre-relocation
driver, sgmiisys and ssusbsys into another. ethsys keeps its own driver as
it binds a reset controller.

While at it, this fixes a latent off-by-one in the infracfg gate lookup: its
clock IDs start at CLK_INFRA_DBGCLK_PD (1), but the old code passed a gate
offset of 0, so requesting e.g. CLK_INFRA_TRNG_PD resolved to the wrong
gate. The offset is now taken from the first gate ID, like the other
controllers.

This also stops using mtk_common_clk_gate_init() and struct mtk_cg_priv,
which are scheduled for removal.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7629.c | 145 +++++++++++++++++++-------------------
 1 file changed, 71 insertions(+), 74 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index aee340aeb37..2edf085970f 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -598,9 +598,41 @@ static const struct mtk_clk_tree mt7629_topckgen_clk_tree = {
 	.type = MTK_CLK_TREE_TOPCKGEN,
 };
 
-static const struct mtk_clk_tree mt7629_clk_tree = {
+static const struct mtk_clk_tree mt7629_infracfg_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates_offs = CLK_INFRA_DBGCLK_PD,
+	.gates = infra_cgs,
+	.num_gates = ARRAY_SIZE(infra_cgs),
+};
+
+static const struct mtk_clk_tree mt7629_pericfg_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates_offs = CLK_PERI_PWM1_PD,
+	.gates = peri_cgs,
+	.num_gates = ARRAY_SIZE(peri_cgs),
+};
+
+static const struct mtk_clk_tree mt7629_ethsys_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates = eth_cgs,
+	.num_gates = ARRAY_SIZE(eth_cgs),
+};
+
+static const struct mtk_clk_tree mt7629_sgmii_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates = sgmii_cgs,
+	.num_gates = ARRAY_SIZE(sgmii_cgs),
+};
+
+static const struct mtk_clk_tree mt7629_ssusb_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates = ssusb_cgs,
+	.num_gates = ARRAY_SIZE(ssusb_cgs),
 };
 
 static int mt7629_mcucfg_probe(struct udevice *dev)
@@ -641,22 +673,11 @@ static int mt7629_topckgen_probe(struct udevice *dev)
 	return mtk_common_clk_init(dev, &mt7629_topckgen_clk_tree);
 }
 
-static int mt7629_infracfg_probe(struct udevice *dev)
+static int mt7629_clk_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7629_clk_tree, infra_cgs,
-					ARRAY_SIZE(infra_cgs), 0);
-}
+	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
 
-static int mt7629_pericfg_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt7629_clk_tree, peri_cgs,
-					ARRAY_SIZE(peri_cgs), CLK_PERI_PWM1_PD);
-}
-
-static int mt7629_ethsys_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt7629_clk_tree, eth_cgs,
-					ARRAY_SIZE(eth_cgs), 0);
+	return mtk_common_clk_init(dev, tree);
 }
 
 static int mt7629_ethsys_bind(struct udevice *dev)
@@ -672,18 +693,6 @@ static int mt7629_ethsys_bind(struct udevice *dev)
 	return ret;
 }
 
-static int mt7629_sgmiisys_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt7629_clk_tree, sgmii_cgs,
-					ARRAY_SIZE(sgmii_cgs), 0);
-}
-
-static int mt7629_ssusbsys_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt7629_clk_tree, ssusb_cgs,
-					ARRAY_SIZE(ssusb_cgs), 0);
-}
-
 static const struct udevice_id mt7629_apmixed_compat[] = {
 	{ .compatible = "mediatek,mt7629-apmixedsys" },
 	{ }
@@ -694,28 +703,35 @@ static const struct udevice_id mt7629_topckgen_compat[] = {
 	{ }
 };
 
-static const struct udevice_id mt7629_infracfg_compat[] = {
-	{ .compatible = "mediatek,mt7629-infracfg", },
-	{ }
-};
-
-static const struct udevice_id mt7629_pericfg_compat[] = {
-	{ .compatible = "mediatek,mt7629-pericfg", },
+static const struct udevice_id of_match_mt7629_infracfg[] = {
+	{
+		.compatible = "mediatek,mt7629-infracfg",
+		.data = (ulong)&mt7629_infracfg_tree
+	},
+	{
+		.compatible = "mediatek,mt7629-pericfg",
+		.data = (ulong)&mt7629_pericfg_tree
+	},
 	{ }
 };
 
 static const struct udevice_id mt7629_ethsys_compat[] = {
-	{ .compatible = "mediatek,mt7629-ethsys", },
-	{ }
-};
-
-static const struct udevice_id mt7629_sgmiisys_compat[] = {
-	{ .compatible = "mediatek,mt7629-sgmiisys", },
+	{
+		.compatible = "mediatek,mt7629-ethsys",
+		.data = (ulong)&mt7629_ethsys_tree
+	},
 	{ }
 };
 
-static const struct udevice_id mt7629_ssusbsys_compat[] = {
-	{ .compatible = "mediatek,mt7629-ssusbsys" },
+static const struct udevice_id of_match_mt7629_clk[] = {
+	{
+		.compatible = "mediatek,mt7629-sgmiisys",
+		.data = (ulong)&mt7629_sgmii_clk_tree
+	},
+	{
+		.compatible = "mediatek,mt7629-ssusbsys",
+		.data = (ulong)&mt7629_ssusb_clk_tree
+	},
 	{ }
 };
 
@@ -757,20 +773,10 @@ U_BOOT_DRIVER(mt7629_clk_topckgen) = {
 U_BOOT_DRIVER(mt7629_clk_infracfg) = {
 	.name = "mt7629-clock-infracfg",
 	.id = UCLASS_CLK,
-	.of_match = mt7629_infracfg_compat,
-	.probe = mt7629_infracfg_probe,
-	.priv_auto	= sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
-U_BOOT_DRIVER(mt7629_clk_pericfg) = {
-	.name = "mt7629-clock-pericfg",
-	.id = UCLASS_CLK,
-	.of_match = mt7629_pericfg_compat,
-	.probe = mt7629_pericfg_probe,
-	.priv_auto	= sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
+	.of_match = of_match_mt7629_infracfg,
+	.probe = mt7629_clk_probe,
+	.priv_auto	= sizeof(struct mtk_clk_priv),
+	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -778,26 +784,17 @@ U_BOOT_DRIVER(mt7629_clk_ethsys) = {
 	.name = "mt7629-clock-ethsys",
 	.id = UCLASS_CLK,
 	.of_match = mt7629_ethsys_compat,
-	.probe = mt7629_ethsys_probe,
+	.probe = mt7629_clk_probe,
 	.bind = mt7629_ethsys_bind,
-	.priv_auto	= sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
-};
-
-U_BOOT_DRIVER(mt7629_clk_sgmiisys) = {
-	.name = "mt7629-clock-sgmiisys",
-	.id = UCLASS_CLK,
-	.of_match = mt7629_sgmiisys_compat,
-	.probe = mt7629_sgmiisys_probe,
-	.priv_auto	= sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
+	.priv_auto	= sizeof(struct mtk_clk_priv),
+	.ops = &mtk_clk_topckgen_ops,
 };
 
-U_BOOT_DRIVER(mt7629_clk_ssusbsys) = {
-	.name = "mt7629-clock-ssusbsys",
+U_BOOT_DRIVER(mt7629_clk) = {
+	.name = "mt7629-clk",
 	.id = UCLASS_CLK,
-	.of_match = mt7629_ssusbsys_compat,
-	.probe = mt7629_ssusbsys_probe,
-	.priv_auto	= sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
+	.of_match = of_match_mt7629_clk,
+	.probe = mt7629_clk_probe,
+	.priv_auto	= sizeof(struct mtk_clk_priv),
+	.ops = &mtk_clk_topckgen_ops,
 };

-- 
2.54.0

