Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D90C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 15:52:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B45784A73;
	Fri, 10 Jul 2026 17:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="ovdHj1zi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A99B84AA5; Fri, 10 Jul 2026 17:52:28 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27CE48497A
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 17:52:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7e9f5637634so719515a34.3
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 08:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783698745; x=1784303545; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aZGmHUIXYEXy32bfsNuP/WyncJmSKzwYIRsdR4ZxPdw=;
 b=ovdHj1ziqjnuYjSC9AdaHKsiFJFBTQKeu4akXlVKgkkZErUE0CqZZTX3BinzxBCL+O
 SQj1+HOVQHu0wjX2yVxyKIhcZqGjDtkfNQwL5WsL7pNCmST9LFShIJ71922uDMvc4Stx
 M/+Feel1nyvtjFlTjenkkZtpT4w4hzDMF2cBbZuTVI+awC3XBqnGG8k3q076HYNWIloS
 3Tz+HzqtHDY5HfQea2jAjBtKll8nHp/jgPRp2O3NcG7P8gmRiKTFVbKdawf7/d1ZRLzt
 fDR9FbvCW2mp9ZAnaT5jsxsv7XRV0O9tsEYVRqOw5JwdyYyPJoNwibHuheGY2rlk0GSB
 XiIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783698745; x=1784303545;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aZGmHUIXYEXy32bfsNuP/WyncJmSKzwYIRsdR4ZxPdw=;
 b=YYuYAvX/RNhyOVYDcfVHC5/ZOMqIrh5WaV6IJUt36JntBde9yEp6lxXQrvAoew6ATq
 ytwHi1HukAMrBbJZxlyy/nLk7gzZlVrI3XVqDcca/BhOUZCnhY/hp0AyIJlrJZJcqDqL
 4tORNgp2L+cXjeMNAgWiyWyhEslDiIV8z9F9xba7T1MkjgliY24JaS2AgGv8fZJJl+DO
 44sqhxoKLMMvt2izIXXGK9kZTMRy0jKn4JSwR6sw70v9oO3x7GoQDaUzITMehO9emU0B
 UnvABVDvN15AXO2VTCdAoJtWvj3Sq/hMdoWKs7xi9eZYk/DSTL1QnjAxhd5tCKW8dkf6
 UfdQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/aTe6qaiFp0aVmszkYoChfX2gICESXc9322SyLCQWBcqOdqwy55vInAEKp0Lwuu0HS5qlNfVs=@lists.denx.de
X-Gm-Message-State: AOJu0YxY9CjJuCqYzSgixp7XdWvk/ZxCph8JZrL8+LIzya+pn8QDWvnK
 7uEff8Z+3EJZ5A8NkxqLcPmkr7Hsu8yhR3Q7oGiF8gr6vgZc+8ASXwrKbgmfPhrM/Qk=
X-Gm-Gg: AfdE7clv4Wc2oa/z6t0yrbgzVLhkFR3JhIbiBXtjTtkjdpjCF+XzkmS75oJZFp0pxyL
 TF1wusT+gfCWSvek5oO1S/imGaPTQP7VDZHXaHXCrqB9mXGH47et0SjxZRF5f0TeAzjtBd84+8Z
 4or1EWWY4N/xmB/DGsIHx9lLq2bOwWUnRznD3wTkOaZl+78Xhux8sfaWN5ehxoB7cL2umH/mhpP
 vqqxM76WPcbECpFyn1Z4v+YGFeUuMyU5P0rxOTVmkRZgvBhi+e8S/TgKqMuj0rADj7pTprjTEMB
 MHhvaTDiCPo4P91mCcbCmUcTIRNqCxIpd7swxhjbQldxsHBmpyXgjQKOak6Qo7ZOWZX3YdJKKb0
 IBX8cOtDxRZqD3V+cF8C9284KKGPdc4plAKdVQSjkPZBJTV0FPybyetcapKa1QcQL3rrLybCAz/
 z5vR6YB5zZQrXmftlQrmYutgXk2E1Ty7G32ex/bbAxHkzfTjbG5EJE+7Oxpzml
X-Received: by 2002:a05:6820:201a:b0:6a3:19a6:dc1f with SMTP id
 006d021491bc7-6a36da5424cmr8927165eaf.33.1783698744802; 
 Fri, 10 Jul 2026 08:52:24 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:1b03:95c:fbd4:4d00?
 ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcaf742e1sm6777768a34.8.2026.07.10.08.52.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 08:52:23 -0700 (PDT)
Message-ID: <cb527477-b1e4-452c-b61d-fbcea090891e@baylibre.com>
Date: Fri, 10 Jul 2026 10:52:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] clk: mediatek: mt8188: convert to mtk_gate_clk_data
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Chris Chen <chris-qj.chen@mediatek.com>, Julien Masson
 <jmasson@baylibre.com>, Daniel Golle <daniel@makrotopia.org>
References: <20260710-b4-mtk-clk-cleanup-clock-gate-drivers-v1-0-a4b5c491d9bf@baylibre.com>
 <20260710-b4-mtk-clk-cleanup-clock-gate-drivers-v1-3-a4b5c491d9bf@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260710-b4-mtk-clk-cleanup-clock-gate-drivers-v1-3-a4b5c491d9bf@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 7/10/26 9:12 AM, Julien Stephan wrote:
> MT8188 currently declares a separate U_BOOT_DRIVER, mtk_clk_tree,
> probe() function and compatible table for each clock gate controller,
> despite all of them sharing the same implementation.
> 
> Convert MT8188 to use the generic mtk_gate_clk_data infrastructure.
> This allows all clock gate controllers to share a single generic
> driver, eliminating duplicated code while preserving the existing
> behaviour.
> 
> No functional change intended.
> 
Since the recent clock changes I made (still under review on list),
I was hoping we could avoid using struct mtk_gate and mtk_common_clk_gate_init()
in new code so we could eventually remove them. It should now be possible
to use struct mtk_clk_tree and mtk_common_clk_init() instead with
mtk_clk_topckgen_ops.

So something like this (untested):

---
diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index f73fa1fce95..84256ad5c5a 100644
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
@@ -1697,19 +1701,49 @@ static const struct mtk_gate imp_iic_wrap_en_clks[] = {
 	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_EN_AP_CLOCK_I2C6, CLK_TOP_I2C, 1),
 };
 
-const struct mtk_clk_tree mt8188_imp_iic_wrap_c_clk_tree = {
+static const struct mtk_clk_tree mt8188_imp_iic_wrap_c_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates = imp_iic_wrap_c_clks,
+	.num_gates = ARRAY_SIZE(imp_iic_wrap_c_clks),
 };
 
-const struct mtk_clk_tree mt8188_imp_iic_wrap_w_clk_tree = {
+static const struct mtk_clk_tree mt8188_imp_iic_wrap_w_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates = imp_iic_wrap_w_clks,
+	.num_gates = ARRAY_SIZE(imp_iic_wrap_w_clks),
 };
 
-const struct mtk_clk_tree mt8188_imp_iic_wrap_en_clk_tree = {
+static const struct mtk_clk_tree mt8188_imp_iic_wrap_en_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates = imp_iic_wrap_en_clks,
+	.num_gates = ARRAY_SIZE(imp_iic_wrap_en_clks),
+};
+
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
+	{ }
 };
 
 static int mt8188_apmixedsys_probe(struct udevice *dev)
@@ -1722,39 +1756,12 @@ static int mt8188_topckgen_probe(struct udevice *dev)
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
+/* REVISIT: could be made into a common function shared by all drivers. */
+static int mt8188_clk_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt8188_imp_iic_wrap_w_clk_tree,
-					imp_iic_wrap_w_clks,
-					ARRAY_SIZE(imp_iic_wrap_w_clks), 0);
-}
+	struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
 
-static int mt8188_imp_iic_wrap_en_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt8188_imp_iic_wrap_en_clk_tree,
-					imp_iic_wrap_en_clks,
-					ARRAY_SIZE(imp_iic_wrap_en_clks), 0);
+	return mtk_common_clk_init(dev, tree);
 }
 
 static const struct udevice_id mt8188_apmixed_compat[] = {
@@ -1767,31 +1774,6 @@ static const struct udevice_id mt8188_topckgen_compat[] = {
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
-	{ }
-};
-
-static const struct udevice_id mt8188_imp_iic_wrap_en_compat[] = {
-	{ .compatible = "mediatek,mt8188-imp-iic-wrap-en", },
-	{ }
-};
-
 U_BOOT_DRIVER(mt8188_clk_apmixedsys) = {
 	.name = "mt8188-apmixedsys",
 	.id = UCLASS_CLK,
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
+U_BOOT_DRIVER(mt8188_clk) = {
+	.name = "mt8188-clk",
 	.id = UCLASS_CLK,
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

