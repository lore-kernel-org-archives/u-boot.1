Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE3BC44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:28:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F55684B65;
	Wed, 15 Jul 2026 16:28:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="gdEXXxvZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01A5A84B55; Wed, 15 Jul 2026 16:28:27 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC62384B43
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:28:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-493f0ae9572so22962265e9.3
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784125704; x=1784730504; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2zcPDBH3rTfjnN0Sbg72S6h75M2IbtYGNIkiaoLU3GU=;
 b=gdEXXxvZ3BEw+hiTMGQPlXFLSoHO5sJX+lcdwz/h64vtfRSvRVeNEmxUR6DpsVB7qk
 IHauQ30qbm++9AKvTdjdo2Q6sByHUIEXxADQNaZSW2h1cxyjW8am+mUwnRNPICe8fOBt
 9JKVCDYQ8oxeYu9jouohZrDwaEbv4K7gHnS+NbyhSmFtJmumirvFu7LXtr43HOFBj50y
 O75LbRyQR9CuVzCIb/9dHrvpdg7DST+NATyZtNt6VLYy+O8FVD3r60mWrrKoyEIGvmPz
 UPszOu+skHT/o08yQ7qW6T6Tk392XCZxcmze7cnwRdXCy0fRwMAAKBcbwn6USEsCs5RT
 lvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125704; x=1784730504;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2zcPDBH3rTfjnN0Sbg72S6h75M2IbtYGNIkiaoLU3GU=;
 b=L9iXvxSyttyMTBQMTFiK1fMeJZAIFTqX8+mLCI79wFpi87ANOoq3pvB+t7qf9JrdCt
 5myxRizcbXMeqVKIA/xbNA6jClbC3J6vPdFPZwoIdpd0npw46Ioo2+U/yrnmLU5VIbnl
 wAzPDYvjNhrE3841JBCxhreQtQWIdK1TUpGzuSJQaAMqbUI8s1vAWE9DTlQjbE06mvmA
 9tY53j+6g+g4L9nJQIlokjQAWjBXD+i0GKJ3wsbCRW/rXOVqFWa7MDyLna77rf7mZoL+
 voj3Ja/zzBP6a5LKLDO4bno1PKvdaRgJZZMNLnhv63TOYETYuWkCEeaXoBOn/xXQrEY1
 On8g==
X-Gm-Message-State: AOJu0YxiPGMkc7RaFTg0BE/QEsQXcAig2oX0mcFzBLtaUwf/81owBECS
 Ukm3He97hBZ4lvj+msfHF865sK+cEsAJxDFMMNznLFgynVaO+o369hhW9mAvNSJU/Z4=
X-Gm-Gg: AfdE7ckLqkKk6quH8digToweDDDByasezo0oObjqR35qpQsbTiKSLv0C3eHZhhPkTAy
 4OJzsuasewa3u9oJbT7dWb6dHKIy14gvg9Aw8P+EErCIiUd2sxs/cPEwB7TFuyuP4HlBqhi+OHj
 2ncVNV47PsZgTCOA76+ZUYC1YR7Yhhelq6r9R0BLxMgwwIh4aylKRffSFTzkeesHq7U+QzWT3cE
 ckXA+9c97cCtlVo1QJ6xsyOmdM4rHp3C7RIOuOo0pkHmLuMgxEtvbYZb5R1MAIZP4ljdFOnmkQQ
 iA3sdHRdTGX0tZn8mLDsI0neyyJ2jzQ7DjqsOu8ijZx5rzpE8U003PRxOSn63nHigOve4XQyViM
 rkokGOQVAhMbvPd8xGVqtpmP4ed9yiWMU/AxdIk0X//A/wrH0vjmkFuJDBeHGmWp/MIEeYH1FEh
 qQ/9j1i0YB/Z7DGo/fAy9OQp7BP9yfEM1f1tteO5bgkDjvgDp/TAFiyWByEYpftKgk5oqwGabrY
 UpPzMjlFNrOxpoayNFiu+x44zB2Uq8ZG+S3X74xtl2Zl6IkwQs4f02mSZJvaBsEETeWS0wV
X-Received: by 2002:a05:600c:1554:b0:493:dad1:e46a with SMTP id
 5b1f17b1804b1-4953c273e38mr34487175e9.21.1784125704261; 
 Wed, 15 Jul 2026 07:28:24 -0700 (PDT)
Received: from [192.168.1.62]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm151881745e9.5.2026.07.15.07.28.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:28:23 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 15 Jul 2026 16:28:31 +0200
Subject: [PATCH v2 03/32] clk: mediatek: mt7622: deduplicate clock gate drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-3-23e907516010@baylibre.com>
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

MT7622 declares a separate U_BOOT_DRIVER, probe() function and compatible
table for each clock gate controller, despite all of them sharing the same
implementation.

Describe the gates directly in each controller's struct mtk_clk_tree,
reference the trees from the driver data and use the generic
mtk_clk_topckgen_ops. Clock gate controllers that share the same DM flags
and bind() callback can then share a single U_BOOT_DRIVER: the pciesys and
ethsys controllers, which both bind a reset controller at the same offset,
are merged into one driver, and the sgmiisys and ssusbsys controllers into
another.

This also stops using mtk_common_clk_gate_init() and struct mtk_cg_priv,
which are scheduled for removal.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7622.c | 148 ++++++++++++++++----------------------
 1 file changed, 63 insertions(+), 85 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 76bc31f06d2..ec81e5f84e5 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -652,9 +652,32 @@ static const struct mtk_clk_tree mt7622_peri_clk_tree = {
 	.num_gates = ARRAY_SIZE(peri_cgs),
 };
 
-static const struct mtk_clk_tree mt7622_clk_tree = {
+static const struct mtk_clk_tree mt7622_pcie_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates = pcie_cgs,
+	.num_gates = ARRAY_SIZE(pcie_cgs),
+};
+
+static const struct mtk_clk_tree mt7622_eth_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates = eth_cgs,
+	.num_gates = ARRAY_SIZE(eth_cgs),
+};
+
+static const struct mtk_clk_tree mt7622_sgmii_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates = sgmii_cgs,
+	.num_gates = ARRAY_SIZE(sgmii_cgs),
+};
+
+static const struct mtk_clk_tree mt7622_ssusb_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates = ssusb_cgs,
+	.num_gates = ARRAY_SIZE(ssusb_cgs),
 };
 
 static int mt7622_mcucfg_probe(struct udevice *dev)
@@ -707,56 +730,26 @@ static int mt7622_pericfg_probe(struct udevice *dev)
 	return mtk_common_clk_init(dev, &mt7622_peri_clk_tree);
 }
 
-static int mt7622_pciesys_probe(struct udevice *dev)
+static int mt7622_clk_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7622_clk_tree, pcie_cgs,
-					ARRAY_SIZE(pcie_cgs), 0);
+	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
+
+	return mtk_common_clk_init(dev, tree);
 }
 
-static int mt7622_pciesys_bind(struct udevice *dev)
+static int mt7622_reset_bind(struct udevice *dev)
 {
 	int ret = 0;
 
 	if (IS_ENABLED(CONFIG_RESET_MEDIATEK)) {
-	ret = mediatek_reset_bind(dev, ETHSYS_HIFSYS_RST_CTRL_OFS, 1);
-	if (ret)
-		debug("Warning: failed to bind reset controller\n");
+		ret = mediatek_reset_bind(dev, ETHSYS_HIFSYS_RST_CTRL_OFS, 1);
+		if (ret)
+			debug("Warning: failed to bind reset controller\n");
 	}
 
 	return ret;
 }
 
-static int mt7622_ethsys_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt7622_clk_tree, eth_cgs,
-					ARRAY_SIZE(eth_cgs), 0);
-}
-
-static int mt7622_ethsys_bind(struct udevice *dev)
-{
-	int ret = 0;
-
-#if CONFIG_IS_ENABLED(RESET_MEDIATEK)
-	ret = mediatek_reset_bind(dev, ETHSYS_HIFSYS_RST_CTRL_OFS, 1);
-	if (ret)
-		debug("Warning: failed to bind reset controller\n");
-#endif
-
-	return ret;
-}
-
-static int mt7622_sgmiisys_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt7622_clk_tree, sgmii_cgs,
-					ARRAY_SIZE(sgmii_cgs), 0);
-}
-
-static int mt7622_ssusbsys_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt7622_clk_tree, ssusb_cgs,
-					ARRAY_SIZE(ssusb_cgs), 0);
-}
-
 static const struct udevice_id mt7622_apmixed_compat[] = {
 	{ .compatible = "mediatek,mt7622-apmixedsys" },
 	{ }
@@ -777,18 +770,27 @@ static const struct udevice_id mt7622_pericfg_compat[] = {
 	{ }
 };
 
-static const struct udevice_id mt7622_pciesys_compat[] = {
-	{ .compatible = "mediatek,mt7622-pciesys", },
-	{ }
-};
-
-static const struct udevice_id mt7622_ethsys_compat[] = {
-	{ .compatible = "mediatek,mt7622-ethsys", },
+static const struct udevice_id of_match_mt7622_clk_eth[] = {
+	{
+		.compatible = "mediatek,mt7622-pciesys",
+		.data = (ulong)&mt7622_pcie_clk_tree
+	},
+	{
+		.compatible = "mediatek,mt7622-ethsys",
+		.data = (ulong)&mt7622_eth_clk_tree
+	},
 	{ }
 };
 
-static const struct udevice_id mt7622_sgmiisys_compat[] = {
-	{ .compatible = "mediatek,mt7622-sgmiisys", },
+static const struct udevice_id of_match_mt7622_clk[] = {
+	{
+		.compatible = "mediatek,mt7622-sgmiisys",
+		.data = (ulong)&mt7622_sgmii_clk_tree
+	},
+	{
+		.compatible = "mediatek,mt7622-ssusbsys",
+		.data = (ulong)&mt7622_ssusb_clk_tree
+	},
 	{ }
 };
 
@@ -797,11 +799,6 @@ static const struct udevice_id mt7622_mcucfg_compat[] = {
 	{ }
 };
 
-static const struct udevice_id mt7622_ssusbsys_compat[] = {
-	{ .compatible = "mediatek,mt7622-ssusbsys" },
-	{ }
-};
-
 U_BOOT_DRIVER(mt7622_mcucfg) = {
 	.name = "mt7622-mcucfg",
 	.id = UCLASS_SYSCON,
@@ -852,40 +849,21 @@ U_BOOT_DRIVER(mt7622_clk_pericfg) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mt7622_clk_pciesys) = {
-	.name = "mt7622-clock-pciesys",
-	.id = UCLASS_CLK,
-	.of_match = mt7622_pciesys_compat,
-	.probe = mt7622_pciesys_probe,
-	.bind = mt7622_pciesys_bind,
-	.priv_auto	= sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
-};
-
-U_BOOT_DRIVER(mt7622_clk_ethsys) = {
-	.name = "mt7622-clock-ethsys",
+U_BOOT_DRIVER(mt7622_clk_eth) = {
+	.name = "mt7622-clk-eth",
 	.id = UCLASS_CLK,
-	.of_match = mt7622_ethsys_compat,
-	.probe = mt7622_ethsys_probe,
-	.bind = mt7622_ethsys_bind,
-	.priv_auto	= sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
-};
-
-U_BOOT_DRIVER(mt7622_clk_sgmiisys) = {
-	.name = "mt7622-clock-sgmiisys",
-	.id = UCLASS_CLK,
-	.of_match = mt7622_sgmiisys_compat,
-	.probe = mt7622_sgmiisys_probe,
-	.priv_auto	= sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
+	.of_match = of_match_mt7622_clk_eth,
+	.probe = mt7622_clk_probe,
+	.bind = mt7622_reset_bind,
+	.priv_auto	= sizeof(struct mtk_clk_priv),
+	.ops = &mtk_clk_topckgen_ops,
 };
 
-U_BOOT_DRIVER(mt7622_clk_ssusbsys) = {
-	.name = "mt7622-clock-ssusbsys",
+U_BOOT_DRIVER(mt7622_clk) = {
+	.name = "mt7622-clk",
 	.id = UCLASS_CLK,
-	.of_match = mt7622_ssusbsys_compat,
-	.probe = mt7622_ssusbsys_probe,
-	.priv_auto	= sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
+	.of_match = of_match_mt7622_clk,
+	.probe = mt7622_clk_probe,
+	.priv_auto	= sizeof(struct mtk_clk_priv),
+	.ops = &mtk_clk_topckgen_ops,
 };

-- 
2.54.0

