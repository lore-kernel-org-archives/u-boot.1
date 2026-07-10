Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487D5C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 14:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBB6384B30;
	Fri, 10 Jul 2026 16:13:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="gLHCpDyD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62DFD84B32; Fri, 10 Jul 2026 16:13:02 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50C8984B44
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 16:13:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4938d5f86f3so7101045e9.1
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 07:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783692780; x=1784297580; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fxBnZWMzOWdi56iMTctE/l1woDYjgipfKKkdndcUZbM=;
 b=gLHCpDyDhEFMFqqRQ2Mo2jrs+L5qjH5LX4egoFgPx5yVQtaiIss9DlTH9ygkkbJnAv
 9O8L3r47K3/92LzKXxgJnIr9MqeIATIwMEzIiOH+cpaehWUC+GgGENryox1W0CrnIunN
 79yw/J4pErFrOxmKEuTnOt0xaWe/ApVhbSws2WjcBI17TJ1Dr69ktK7xNmYNTYMcD31l
 vbjtWXY5iig6EO5Cu69IuTsuKAbq/vq1NXltjfHPXDQSMSNX38aTRGpzpucCsfb00IgU
 7+QTBB8OL+/jlvQPa0jyXYmTnR9vzDmYGwPHa5f7HiyEYCdk3Sgg29G/EIxc20N6kUpN
 dzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783692780; x=1784297580;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fxBnZWMzOWdi56iMTctE/l1woDYjgipfKKkdndcUZbM=;
 b=hKZXXSXOdXON2IH0llJB//zeXmPc+hF2zQ+qh0Jx3rYT5XgqvGJTX41Cbv87F3gwne
 c1STxkyXqaovvSBBgKhEHgooiou2d7qJ88GiMzsQ5a66Jl8Du4WZmt1zfAEsXlI7uTNR
 UBxOYVwS2QBhUQXne+wXu6iSp7XnZnZ4Fan11tx6NmFofLFq+HhBxdaV2UwlcIRK7QFR
 kMKfKv23G+nbqbPRCkvlWCnlHx6QHLsaVe/cA/U7dJ4TtYzDK+HyHWqC8Rn5bDmC25n0
 HyMV8IZyeSg2zShP+7I29JxjJ65HYd6+DJhxW0tfR8eK2hN7hIyuZy/1PGeu1x/tkXUH
 V7nQ==
X-Gm-Message-State: AOJu0YydCQCIt1cESaXGN8M9I38i7jCpbEB4HiNGts60yIzYk/QdD7UR
 +ElW4xvK6OdutCUYKmfbLfDDKnzn2lAu/Ok3EeTmzdPR6PlfbSi2CuY+2lnW2/aXvms=
X-Gm-Gg: AfdE7clTIUVErvW+yuXnCjXjOEW2KZll8DD6eb+Nx6MrFVr07sWKx/JSzBFsGyhZJYb
 Yy1PX4EcHGONGGUVQyyBQE5OiToHH3rSnOtgTOCDremKEeQG0DLVb3Y918hn67cQ4r14R8UZPxC
 g2V93vTcdbdBeKkyqe5/ZKQ2qvDBEVX6IdqKnwiFFFmL/4BkyWFlj23Xtn3xddZOIChsSDIFtSZ
 dpiJe8LvuWNIzyOX14wKGs/vGDbV+JExyObNBxvISiwHlyoyzkaoeoLXIgpN+VyEf94anoZ+Toq
 zkXemx++6KN7JIm8N1WvRDZCMm+Z0trxZ3fPKrn2f0dSIEyDwKyj6dWl9MWhixoGPSWstuAfuTt
 1cT6mMHINFOA7t0TOBQM+Y36vghiHLnZ0I7jqxG3yosPOd9pnylhL/y9odIDMHeoPgbFV3/YGgM
 fa8S5ZlHKD7UQ0GZ9qfEMdV+btbitho3nKQ8xlJImPTGSnsDfNb2iqd/FpIlCNYKfhUumslNjVg
 e+EKesEsT3PY0v3g+2ixxKX0/n5LAsI2p5Apms28lRLeG4ByI+NFAtp5RfKl0Vqmm/wQlQ=
X-Received: by 2002:a05:600c:c1d7:10b0:493:e41a:9b23 with SMTP id
 5b1f17b1804b1-493f2b24cf0mr30816725e9.1.1783692779792; 
 Fri, 10 Jul 2026 07:12:59 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2d88698sm64073205e9.1.2026.07.10.07.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 07:12:59 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 10 Jul 2026 16:12:57 +0200
Subject: [PATCH 6/9] clk: mediatek: mt7629: convert to mtk_gate_clk_data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-b4-mtk-clk-cleanup-clock-gate-drivers-v1-6-a4b5c491d9bf@baylibre.com>
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

MT7629 currently declares a separate U_BOOT_DRIVER and probe()
function for each clock gate controller, despite all of them sharing
the same implementation.

Convert MT7629 to use the generic mtk_gate_clk_data infrastructure so
that all clock gate controllers share a single probe() function.
infracfg and pericfg, which are both bound before relocation, are
merged into a single driver, as are sgmiisys and ssusbsys. ethsys
keeps its own U_BOOT_DRIVER since it additionally binds a reset
controller.

Note that this also fixes the gate lookup of infracfg: its clock IDs
start at CLK_INFRA_DBGCLK_PD (1), but the driver passed a gate offset
of 0 to mtk_common_clk_gate_init(), so any infracfg gate request
(e.g. CLK_INFRA_TRNG_PD, referenced by the rng node) resolved to the
wrong gate. The generic probe() derives the offset from the ID of the
first gate in the table, which is correct for all controllers.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7629.c | 109 +++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 67 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index aee340aeb37..11c6de2718b 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -641,22 +641,15 @@ static int mt7629_topckgen_probe(struct udevice *dev)
 	return mtk_common_clk_init(dev, &mt7629_topckgen_clk_tree);
 }
 
-static int mt7629_infracfg_probe(struct udevice *dev)
+static int mt7629_clk_gate_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7629_clk_tree, infra_cgs,
-					ARRAY_SIZE(infra_cgs), 0);
-}
+	struct mtk_gate_clk_data *data;
 
-static int mt7629_pericfg_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt7629_clk_tree, peri_cgs,
-					ARRAY_SIZE(peri_cgs), CLK_PERI_PWM1_PD);
-}
+	data = (void *)dev_get_driver_data(dev);
 
-static int mt7629_ethsys_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt7629_clk_tree, eth_cgs,
-					ARRAY_SIZE(eth_cgs), 0);
+	return mtk_common_clk_gate_init(dev, &mt7629_clk_tree,
+					data->gates, data->num_gates,
+					data->gates[0].id);
 }
 
 static int mt7629_ethsys_bind(struct udevice *dev)
@@ -672,18 +665,6 @@ static int mt7629_ethsys_bind(struct udevice *dev)
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
@@ -694,28 +675,41 @@ static const struct udevice_id mt7629_topckgen_compat[] = {
 	{ }
 };
 
-static const struct udevice_id mt7629_infracfg_compat[] = {
-	{ .compatible = "mediatek,mt7629-infracfg", },
-	{ }
-};
-
-static const struct udevice_id mt7629_pericfg_compat[] = {
-	{ .compatible = "mediatek,mt7629-pericfg", },
+MTK_GATE_CLK_DATA(infra_cgs);
+MTK_GATE_CLK_DATA(peri_cgs);
+static const struct udevice_id mt7629_clk_gate_compat[] = {
+	{
+		.compatible = "mediatek,mt7629-infracfg",
+		.data = (ulong)&infra_cgs_data
+	},
+	{
+		.compatible = "mediatek,mt7629-pericfg",
+		.data = (ulong)&peri_cgs_data
+	},
 	{ }
 };
 
+MTK_GATE_CLK_DATA(eth_cgs);
 static const struct udevice_id mt7629_ethsys_compat[] = {
-	{ .compatible = "mediatek,mt7629-ethsys", },
+	{
+		.compatible = "mediatek,mt7629-ethsys",
+		.data = (ulong)&eth_cgs_data
+	},
 	{ }
 };
 
-static const struct udevice_id mt7629_sgmiisys_compat[] = {
-	{ .compatible = "mediatek,mt7629-sgmiisys", },
-	{ }
-};
+MTK_GATE_CLK_DATA(sgmii_cgs);
+MTK_GATE_CLK_DATA(ssusb_cgs);
 
-static const struct udevice_id mt7629_ssusbsys_compat[] = {
-	{ .compatible = "mediatek,mt7629-ssusbsys" },
+static const struct udevice_id mt7629_clk_gate_phy_compat[] = {
+	{
+		.compatible = "mediatek,mt7629-sgmiisys",
+		.data = (ulong)&sgmii_cgs_data
+	},
+	{
+		.compatible = "mediatek,mt7629-ssusbsys",
+		.data = (ulong)&ssusb_cgs_data
+	},
 	{ }
 };
 
@@ -754,21 +748,11 @@ U_BOOT_DRIVER(mt7629_clk_topckgen) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mt7629_clk_infracfg) = {
-	.name = "mt7629-clock-infracfg",
+U_BOOT_DRIVER(mt7629_clk_gate) = {
+	.name = "mt7629-gate-clk",
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
+	.of_match = mt7629_clk_gate_compat,
+	.probe = mt7629_clk_gate_probe,
 	.priv_auto	= sizeof(struct mtk_cg_priv),
 	.ops = &mtk_clk_gate_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -778,26 +762,17 @@ U_BOOT_DRIVER(mt7629_clk_ethsys) = {
 	.name = "mt7629-clock-ethsys",
 	.id = UCLASS_CLK,
 	.of_match = mt7629_ethsys_compat,
-	.probe = mt7629_ethsys_probe,
+	.probe = mt7629_clk_gate_probe,
 	.bind = mt7629_ethsys_bind,
 	.priv_auto	= sizeof(struct mtk_cg_priv),
 	.ops = &mtk_clk_gate_ops,
 };
 
-U_BOOT_DRIVER(mt7629_clk_sgmiisys) = {
-	.name = "mt7629-clock-sgmiisys",
-	.id = UCLASS_CLK,
-	.of_match = mt7629_sgmiisys_compat,
-	.probe = mt7629_sgmiisys_probe,
-	.priv_auto	= sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
-};
-
-U_BOOT_DRIVER(mt7629_clk_ssusbsys) = {
-	.name = "mt7629-clock-ssusbsys",
+U_BOOT_DRIVER(mt7629_clk_gate_phy) = {
+	.name = "mt7629-gate-clk-phy",
 	.id = UCLASS_CLK,
-	.of_match = mt7629_ssusbsys_compat,
-	.probe = mt7629_ssusbsys_probe,
+	.of_match = mt7629_clk_gate_phy_compat,
+	.probe = mt7629_clk_gate_probe,
 	.priv_auto	= sizeof(struct mtk_cg_priv),
 	.ops = &mtk_clk_gate_ops,
 };

-- 
2.54.0

