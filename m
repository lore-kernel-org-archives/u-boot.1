Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35C5C44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:28:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E24A684A6B;
	Wed, 15 Jul 2026 16:28:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="cdJOMWHY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9491F84AFF; Wed, 15 Jul 2026 16:28:24 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F1FB84ACE
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:28:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-493f25d47dcso11814225e9.1
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784125702; x=1784730502; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pIOYEXyQfO3D6jytkHWBEioEaqdzAL9PDadgYGyUhMo=;
 b=cdJOMWHYS8FMx7kUCTlUXk2sH4WyxLZlBHrc0WQjsVgvkLU8AgC7UvDxZdr2ZQTnuq
 caW0U2+HPmTaPNyZdO9ks0+e1cmOCfJYGyzS4eaPPA9uEflRhdq2n/isPuxVwpMdQLBj
 gCNE8lz+QXT2frVkmDuywsElyqrEVIMnQftGw3ubFtDXBFM4vLFm74DNV9iwURg7Cj/Y
 NH0NjoqIWhHs0aQ9veeFbdwv5aNASA/wlawQSSHfr/mPRaJCe/yY9klkg36m/0r52liv
 0GKnYv6N+HFwB9PYZw20pJF4hJOuGofnmHigAWGY11LpJqmwXcQxQ2sPxE5D0byebiQf
 sI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125702; x=1784730502;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pIOYEXyQfO3D6jytkHWBEioEaqdzAL9PDadgYGyUhMo=;
 b=OyszsNe/Zn3vne42W7jTATBYz8la2/2cYCnSX6KHAYrVJhMS7yAVRdsRX9jBtApDB0
 f5GUlWgt/0WbJIaH0TPIrBpXLznqfI8boSwYhTQFEtTCOaRW7oMJUqSQuw312QgHxNY9
 zHNbI4eE9Y7HMJALV8jRbPZtMOVxXO6LxdWRdZ2GqMgpNCTj4dVw8mmcxDLRGgnzaSwp
 KU8siPa7NOYqwPiyylwG7hy8oUEcYWriDkwHm5s1UneyNO7ASEIwzMsT8IBXQ6QcMLKK
 SUQiQbzxYT80Nz1PUzIUUI/WJtAFTVjizueVluy4oHvRfuF9RcxvnKPVCtBoXB2LXcmw
 6JHQ==
X-Gm-Message-State: AOJu0YwUhlSslIPr8H104VpASllOgXOxs6lWwlhaSgy2IUbI/P5bubwc
 ToJMDywRSavGviuadM+bWR97h4CpjM+iH78pB8uJ4U+p2q/urpR0ZcTC7B1/iGmRrg0=
X-Gm-Gg: AfdE7cnZaMHVIJ/DQHCprMtbHjlT/5kxAuVDDcnYU/nib+3wCwKscTUMtiX3Nzd+RLr
 kSa/y/wBZQJjgrj+9s5JWxHRkrrp3UurUMHPZdlTG0qAI3RTeqPl/CC2uMgObA8oU73ny1Dq3mV
 TNaKBki/w9b5v+wdxccXzoAqgZx10p0MvId2++3wuLttzOH/6cIM8WjpcM6YnOHr0agfcnINVVz
 tXuJzrI1/pROxwkoU41cFjJmBKwxQa/qVecjJRW7Yo61rTmU9mcfBN1AECbN51tFdmxcy7eGnnM
 41gKVNazUh5XHHl3zp6Vou/c4/XmksbcxwD0KFXVGqUa8zZL0Fxt1fVDq4prSWahDMI0jTGrdsp
 eV4Su3gAvO2dG0mJxRNlhn08VWUYj8fRtdBCDYiDsumxzE/s5F/jq2p/KUOL0rD9zdw+DPHIHbQ
 NCF8uZZEYuvXuUQfKZx80JvZK4J9SyLg9Kc0ENwcgV91Om3G87JhhLSAfp9a2sEgFtuXDcCP8OH
 ubsOYwojYhTsmPM3yvIo5XKJ2KANv14O9RQY2H6yXD9wtwZhGtVQvLX6flQLYxWwH89774q
X-Received: by 2002:a05:600c:3acf:b0:493:f176:dc69 with SMTP id
 5b1f17b1804b1-493f884f5f2mr177741005e9.37.1784125701730; 
 Wed, 15 Jul 2026 07:28:21 -0700 (PDT)
Received: from [192.168.1.62]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm151881745e9.5.2026.07.15.07.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:28:21 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 15 Jul 2026 16:28:29 +0200
Subject: [PATCH v2 01/32] clk: mediatek: mt8188: deduplicate clock gate drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-1-23e907516010@baylibre.com>
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

MT8188 currently declares a separate U_BOOT_DRIVER, probe() function and
compatible table for each clock gate controller, despite all of them
sharing the same implementation.

Describe the gates directly in each controller's struct mtk_clk_tree,
reference the trees from the driver data and use the generic
mtk_clk_topckgen_ops. All the clock gate controllers can then share a
single U_BOOT_DRIVER, eliminating the duplicated code.

This also stops using mtk_common_clk_gate_init() and struct mtk_cg_priv,
which are scheduled for removal.

No functional change intended.

Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8188.c | 138 +++++++++++---------------------------
 1 file changed, 40 insertions(+), 98 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index f73fa1fce95..9f7373cfe87 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -1622,6 +1622,8 @@ static const struct mtk_gate infracfg_ao_clks[] = {
 static const struct mtk_clk_tree mt8188_infracfg_ao_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates = infracfg_ao_clks,
+	.num_gates = ARRAY_SIZE(infracfg_ao_clks),
 };
 
 static const struct mtk_gate_regs peri_ao_cg_regs = {
@@ -1665,6 +1667,8 @@ static const struct mtk_gate pericfg_ao_clks[] = {
 static const struct mtk_clk_tree mt8188_pericfg_ao_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates = pericfg_ao_clks,
+	.num_gates = ARRAY_SIZE(pericfg_ao_clks),
 };
 
 static const struct mtk_gate_regs imp_iic_wrap_cg_regs = {
@@ -1700,16 +1704,22 @@ static const struct mtk_gate imp_iic_wrap_en_clks[] = {
 const struct mtk_clk_tree mt8188_imp_iic_wrap_c_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates = imp_iic_wrap_c_clks,
+	.num_gates = ARRAY_SIZE(imp_iic_wrap_c_clks),
 };
 
 const struct mtk_clk_tree mt8188_imp_iic_wrap_w_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates = imp_iic_wrap_w_clks,
+	.num_gates = ARRAY_SIZE(imp_iic_wrap_w_clks),
 };
 
 const struct mtk_clk_tree mt8188_imp_iic_wrap_en_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates = imp_iic_wrap_en_clks,
+	.num_gates = ARRAY_SIZE(imp_iic_wrap_en_clks),
 };
 
 static int mt8188_apmixedsys_probe(struct udevice *dev)
@@ -1722,39 +1732,11 @@ static int mt8188_topckgen_probe(struct udevice *dev)
 	return mtk_common_clk_init(dev, &mt8188_topckgen_clk_tree);
 }
 
-static int mt8188_infracfg_ao_probe(struct udevice *dev)
+static int mt8188_clk_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt8188_infracfg_ao_clk_tree,
-					infracfg_ao_clks,
-					ARRAY_SIZE(infracfg_ao_clks), 0);
-}
-
-static int mt8188_pericfg_ao_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt8188_pericfg_ao_clk_tree,
-					pericfg_ao_clks,
-					ARRAY_SIZE(pericfg_ao_clks), 0);
-}
-
-static int mt8188_imp_iic_wrap_c_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt8188_imp_iic_wrap_c_clk_tree,
-					imp_iic_wrap_c_clks,
-					ARRAY_SIZE(imp_iic_wrap_c_clks), 0);
-}
-
-static int mt8188_imp_iic_wrap_w_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt8188_imp_iic_wrap_w_clk_tree,
-					imp_iic_wrap_w_clks,
-					ARRAY_SIZE(imp_iic_wrap_w_clks), 0);
-}
+	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
 
-static int mt8188_imp_iic_wrap_en_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt8188_imp_iic_wrap_en_clk_tree,
-					imp_iic_wrap_en_clks,
-					ARRAY_SIZE(imp_iic_wrap_en_clks), 0);
+	return mtk_common_clk_init(dev, tree);
 }
 
 static const struct udevice_id mt8188_apmixed_compat[] = {
@@ -1767,30 +1749,30 @@ static const struct udevice_id mt8188_topckgen_compat[] = {
 	{ }
 };
 
-static const struct udevice_id mt8188_infracfg_ao_compat[] = {
-	{ .compatible = "mediatek,mt8188-infracfg-ao", },
-	{ }
-};
-
-static const struct udevice_id mt8188_pericfg_ao_compat[] = {
-	{ .compatible = "mediatek,mt8188-pericfg-ao", },
-	{ }
-};
-
-static const struct udevice_id mt8188_imp_iic_wrap_c_compat[] = {
-	{ .compatible = "mediatek,mt8188-imp-iic-wrap-c", },
-	{ }
-};
-
-static const struct udevice_id mt8188_imp_iic_wrap_w_compat[] = {
-	{ .compatible = "mediatek,mt8188-imp-iic-wrap-w", },
+static const struct udevice_id of_match_mt8188_clk[] = {
+	{
+		.compatible = "mediatek,mt8188-infracfg-ao",
+		.data = (ulong)&mt8188_infracfg_ao_clk_tree
+	},
+	{
+		.compatible = "mediatek,mt8188-pericfg-ao",
+		.data = (ulong)&mt8188_pericfg_ao_clk_tree
+	},
+	{
+		.compatible = "mediatek,mt8188-imp-iic-wrap-c",
+		.data = (ulong)&mt8188_imp_iic_wrap_c_clk_tree
+	},
+	{
+		.compatible = "mediatek,mt8188-imp-iic-wrap-w",
+		.data = (ulong)&mt8188_imp_iic_wrap_w_clk_tree
+	},
+	{
+		.compatible = "mediatek,mt8188-imp-iic-wrap-en",
+		.data = (ulong)&mt8188_imp_iic_wrap_en_clk_tree
+	},
 	{ }
 };
 
-static const struct udevice_id mt8188_imp_iic_wrap_en_compat[] = {
-	{ .compatible = "mediatek,mt8188-imp-iic-wrap-en", },
-	{ }
-};
 
 U_BOOT_DRIVER(mt8188_clk_apmixedsys) = {
 	.name = "mt8188-apmixedsys",
@@ -1814,52 +1796,12 @@ U_BOOT_DRIVER(mt8188_clk_topckgen) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mt8188_clk_infracfg_ao) = {
-	.name = "mt8188-infracfg-ao",
-	.id = UCLASS_CLK,
-	.of_match = mt8188_infracfg_ao_compat,
-	.probe = mt8188_infracfg_ao_probe,
-	.priv_auto = sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
-U_BOOT_DRIVER(mt8188_clk_pericfg_ao) = {
-	.name = "mt8188-pericfg-ao",
-	.id = UCLASS_CLK,
-	.of_match = mt8188_pericfg_ao_compat,
-	.probe = mt8188_pericfg_ao_probe,
-	.priv_auto = sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
-U_BOOT_DRIVER(mt8188_clk_imp_iic_wrap_c) = {
-	.name = "mt8188-imp_iic_wrap_c",
+U_BOOT_DRIVER(mt8188_clk) = {
+	.name = "mt8188-clk",
 	.id = UCLASS_CLK,
-	.of_match = mt8188_imp_iic_wrap_c_compat,
-	.probe = mt8188_imp_iic_wrap_c_probe,
-	.priv_auto = sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
-U_BOOT_DRIVER(mt8188_clk_imp_iic_wrap_w) = {
-	.name = "mt8188-imp_iic_wrap_w",
-	.id = UCLASS_CLK,
-	.of_match = mt8188_imp_iic_wrap_w_compat,
-	.probe = mt8188_imp_iic_wrap_w_probe,
-	.priv_auto = sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
-U_BOOT_DRIVER(mt8188_clk_imp_iic_wrap_en) = {
-	.name = "mt8188-imp_iic_wrap_en",
-	.id = UCLASS_CLK,
-	.of_match = mt8188_imp_iic_wrap_en_compat,
-	.probe = mt8188_imp_iic_wrap_en_probe,
-	.priv_auto = sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
+	.of_match = of_match_mt8188_clk,
+	.probe = mt8188_clk_probe,
+	.priv_auto = sizeof(struct mtk_clk_priv),
+	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };

-- 
2.54.0

