Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1403C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 14:13:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C601D84B20;
	Fri, 10 Jul 2026 16:12:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="XlAe7/V9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1881484B28; Fri, 10 Jul 2026 16:12:58 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07A8B84B04
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 16:12:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-493f60208a5so4754145e9.3
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 07:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783692775; x=1784297575; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nxKzzJVW48jA/qqVdZmp+eod3I2NeayNOPKYwnEA35U=;
 b=XlAe7/V9XHcX6R4rwM4IQr2RXlN4OOKLhrGrTUArBW8utkkyc5lV8w2mCPqEQwlRHQ
 G5M6kNhEH94F1/qYDdN8DQKvLclqcYXxuclRGCdz77X/H3e5T0Tqef/iRqOnm8pH5Gw6
 kqUJqmCjvigddmFL/BMQEReVLKVDpMUCJjlVXA7EQbPnTyWgerDULD9Cu3atWKgGUQJ+
 8M6g0lDrhL2Y7cyGG4S8cPNITzjHeW2dXoEMR9W4iyMCQdvX+L72cc7hX9DUEyJUYFAM
 lAHxWbo3D8h4zk29OfFOxaniy2lAiHa8HI4KUlg2QTkh+ACXwEE8m32xqkHA1omKKzTL
 o0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783692775; x=1784297575;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nxKzzJVW48jA/qqVdZmp+eod3I2NeayNOPKYwnEA35U=;
 b=CPn5MlcAphqGnR2ISDVM2dg7y3/jGhnf5ZeZgA6wobN2o8u9tOfr2IoHq6k7oJh7XL
 UkO+2OjfZKmZK2posuwTmUEPtO6p8Rn+88Pu3YtqqJGZN3xcH3zbMqWMSnmM8mU/E5Po
 /DzLsDf+5R1MRRvgOvZKS6SVQBbf1xHmR7j8OlhLAh9EhecmfVHegDXkIDK/5Vo+E6Zb
 Cz4PTsmSlvWkDcBpDhZe6PiErYZGrxMfm50IwZ7o3Wyb26I/eNCzuKVac+WMLhQKeXdE
 ETuWY7W7tSrTagl9Kkswq4NWcFhx4F1zjXLgyEqK85aifDpOkl9u1Mtboc/XBavRO45F
 4YlA==
X-Gm-Message-State: AOJu0YxHscReHJCiWcFEQRcCDvKFRe+59RVNQPJiDCkj3kZdDP8nN6gH
 O4/YoB87I+SkpgJZtZXXdVAf6vk37w7xb27JYFmc7ape9ghVbEraTtpu45GY+t8+mR4=
X-Gm-Gg: AfdE7cmYy3Hgq8fzdgRoiEjVawhyqCZPcyX4EyyDNCMVeqOZ5lh4yd+5nslx3OHTNfT
 lRzCPWvQLcPfuSYTgIF/jh4AH5W0/IDJKx792I3gCQkgiAAE7/i6JRo3nUh7zmKxNsRILVcclLZ
 GEtmuNYKvPx6aNv6+fG0JkQrUioCKoFq+Kzz4ineSHcNhiR4/FzJQteQbHr/LOP5O3CTVM93Vks
 OEuo5YkO2Btn1ARV+LV2Qz1L0VddluQtUJzLhYtNsv8YLkpV9Q3LkYS/jVqN2k1xnK2vjEt9SRo
 s+Su61woXmP3034mOVwBcNFATpdk6qK8QhhW3UiBzsQrp04PNRoJP/UsiHjmCwjw6h5VPa0n8LW
 4ApW9qTYOoJTnAetnmByhI6pJgJEP33zv4glkyAHjWyPq2885vHhD9NMZOtZnct9Cu+1iKZeGDe
 X214jaP0LZ/9W5UnM7skcP+J2Fc9sIUgpZ8OExcFvG/hjdVyiFyNZygNhDcwQkGGtaUhPxUyOIf
 MN48Jd92L27mWRBdNsF4MkVBeUTp7DcrhX8kmYp1N+JHNFedHaJkPJ+0caVNAb4jRJqTuU=
X-Received: by 2002:a05:600c:c1c8:10b0:493:c3c9:218c with SMTP id
 5b1f17b1804b1-493e68cebf6mr96409265e9.30.1783692775401; 
 Fri, 10 Jul 2026 07:12:55 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2d88698sm64073205e9.1.2026.07.10.07.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 07:12:54 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 10 Jul 2026 16:12:54 +0200
Subject: [PATCH 3/9] clk: mediatek: mt8188: convert to mtk_gate_clk_data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-b4-mtk-clk-cleanup-clock-gate-drivers-v1-3-a4b5c491d9bf@baylibre.com>
References: <20260710-b4-mtk-clk-cleanup-clock-gate-drivers-v1-0-a4b5c491d9bf@baylibre.com>
In-Reply-To: <20260710-b4-mtk-clk-cleanup-clock-gate-drivers-v1-0-a4b5c491d9bf@baylibre.com>
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
 Julien Stephan <jstephan@baylibre.com>
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

MT8188 currently declares a separate U_BOOT_DRIVER, mtk_clk_tree,
probe() function and compatible table for each clock gate controller,
despite all of them sharing the same implementation.

Convert MT8188 to use the generic mtk_gate_clk_data infrastructure.
This allows all clock gate controllers to share a single generic
driver, eliminating duplicated code while preserving the existing
behaviour.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8188.c | 161 ++++++++++----------------------------
 1 file changed, 41 insertions(+), 120 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index f73fa1fce95..cbaea9f0b2e 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -1619,11 +1619,6 @@ static const struct mtk_gate infracfg_ao_clks[] = {
 	GATE_INFRA_AO4(CLK_INFRA_AO_RG_AES_MSDCFDE_CK_0P, CLK_TOP_AES_MSDCFDE, 18),
 };
 
-static const struct mtk_clk_tree mt8188_infracfg_ao_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-};
-
 static const struct mtk_gate_regs peri_ao_cg_regs = {
 	.set_ofs = 0x10,
 	.clr_ofs = 0x14,
@@ -1662,11 +1657,6 @@ static const struct mtk_gate pericfg_ao_clks[] = {
 	GATE_PERI_AO(CLK_PERI_AO_PCIE_P0_FMEM, CLK_TOP_466M_FMEM, 24),
 };
 
-static const struct mtk_clk_tree mt8188_pericfg_ao_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-};
-
 static const struct mtk_gate_regs imp_iic_wrap_cg_regs = {
 	.set_ofs = 0xe08,
 	.clr_ofs = 0xe04,
@@ -1697,19 +1687,39 @@ static const struct mtk_gate imp_iic_wrap_en_clks[] = {
 	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_EN_AP_CLOCK_I2C6, CLK_TOP_I2C, 1),
 };
 
-const struct mtk_clk_tree mt8188_imp_iic_wrap_c_clk_tree = {
+static const struct mtk_clk_tree mt8188_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
 
-const struct mtk_clk_tree mt8188_imp_iic_wrap_w_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-};
-
-const struct mtk_clk_tree mt8188_imp_iic_wrap_en_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+MTK_GATE_CLK_DATA(infracfg_ao_clks);
+MTK_GATE_CLK_DATA(pericfg_ao_clks);
+MTK_GATE_CLK_DATA(imp_iic_wrap_c_clks);
+MTK_GATE_CLK_DATA(imp_iic_wrap_w_clks);
+MTK_GATE_CLK_DATA(imp_iic_wrap_en_clks);
+
+static const struct udevice_id of_match_mt8188_clk_gate[] = {
+	{
+		.compatible = "mediatek,mt8188-infracfg-ao",
+		.data = (ulong)&infracfg_ao_clks_data
+	},
+	{
+		.compatible = "mediatek,mt8188-pericfg-ao",
+		.data = (ulong)&pericfg_ao_clks_data
+	},
+	{
+		.compatible = "mediatek,mt8188-imp-iic-wrap-c",
+		.data = (ulong)&imp_iic_wrap_c_clks_data
+	},
+	{
+		.compatible = "mediatek,mt8188-imp-iic-wrap-w",
+		.data = (ulong)&imp_iic_wrap_w_clks_data
+	},
+	{
+		.compatible = "mediatek,mt8188-imp-iic-wrap-en",
+		.data = (ulong)&imp_iic_wrap_en_clks_data
+	},
+	{ }
 };
 
 static int mt8188_apmixedsys_probe(struct udevice *dev)
@@ -1722,41 +1732,6 @@ static int mt8188_topckgen_probe(struct udevice *dev)
 	return mtk_common_clk_init(dev, &mt8188_topckgen_clk_tree);
 }
 
-static int mt8188_infracfg_ao_probe(struct udevice *dev)
-{
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
-
-static int mt8188_imp_iic_wrap_en_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt8188_imp_iic_wrap_en_clk_tree,
-					imp_iic_wrap_en_clks,
-					ARRAY_SIZE(imp_iic_wrap_en_clks), 0);
-}
-
 static const struct udevice_id mt8188_apmixed_compat[] = {
 	{ .compatible = "mediatek,mt8188-apmixedsys", },
 	{ }
@@ -1767,30 +1742,16 @@ static const struct udevice_id mt8188_topckgen_compat[] = {
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
+static int mt8188_clk_gate_probe(struct udevice *dev)
+{
+	struct mtk_gate_clk_data *data;
 
-static const struct udevice_id mt8188_imp_iic_wrap_w_compat[] = {
-	{ .compatible = "mediatek,mt8188-imp-iic-wrap-w", },
-	{ }
-};
+	data = (void *)dev_get_driver_data(dev);
 
-static const struct udevice_id mt8188_imp_iic_wrap_en_compat[] = {
-	{ .compatible = "mediatek,mt8188-imp-iic-wrap-en", },
-	{ }
-};
+	return mtk_common_clk_gate_init(dev, &mt8188_clk_tree,
+					data->gates, data->num_gates,
+					data->gates[0].id);
+}
 
 U_BOOT_DRIVER(mt8188_clk_apmixedsys) = {
 	.name = "mt8188-apmixedsys",
@@ -1814,51 +1775,11 @@ U_BOOT_DRIVER(mt8188_clk_topckgen) = {
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
-	.id = UCLASS_CLK,
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
+U_BOOT_DRIVER(mt8188_clk_gate) = {
+	.name = "mt8188-gate-clk",
 	.id = UCLASS_CLK,
-	.of_match = mt8188_imp_iic_wrap_en_compat,
-	.probe = mt8188_imp_iic_wrap_en_probe,
+	.of_match = of_match_mt8188_clk_gate,
+	.probe = mt8188_clk_gate_probe,
 	.priv_auto = sizeof(struct mtk_cg_priv),
 	.ops = &mtk_clk_gate_ops,
 	.flags = DM_FLAG_PRE_RELOC,

-- 
2.54.0

