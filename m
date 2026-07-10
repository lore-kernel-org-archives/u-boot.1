Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B33C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 14:13:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 317E484B61;
	Fri, 10 Jul 2026 16:13:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="aDCGjxpZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 707A584B04; Fri, 10 Jul 2026 16:13:04 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDD0484B04
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 16:13:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-493c19bad03so8582825e9.2
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 07:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783692781; x=1784297581; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=94myWzNIv9dwEJwEHX6yYLXVrImSdIUQXjgFpXHA9NQ=;
 b=aDCGjxpZXAb9x8WPEsnw5RUanQR+MfHJSlywJnCc5bx0vFHWkyQilYhbJ5Lg/D3ZkZ
 2SJNuKjoXP1p4wMD08il8l1BzITQ4ejlvO4awB3j05oZYEgkkH0plVNMzzE3Q7OX5mcp
 PHJPfN5vVgc08rBRyA4EVVKx4hCIh997rCWFZ2CW82Msl/9KuQuBmcS8kB3o/n+AZVvO
 ILElY/ZJCouPXdD5PH9GlveTXWQRCPCI2hchHUIt2H3/3mn5bP0efVvE8Ahu6b5WfzIk
 QKvqN8ux4RfRLS0sV5YTYRly/Y7oRkvhpcLYKes1t744rwCz8dMaxpoA2UdSjrRG5INa
 kdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783692781; x=1784297581;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=94myWzNIv9dwEJwEHX6yYLXVrImSdIUQXjgFpXHA9NQ=;
 b=LYZ7Iho28Q+UVxqA113XuLjgvoT54KjqPRPaO988cHNrFEHY6MLy0aoUw5D8NeDx7j
 B1Un3BcVp/428gYb3kUSPMTYoeyX5fj+l9n8FWwyuVxXAvVmXGSp095H8Q4LjBfT6DAI
 w61jfhjyTfB9j+7q4DlYcOlUCmPJBOp9Rsf20cT4hjzFSAoQX4A1m/d/LUkgKoimLQBz
 wjr6BUCGaudzOKSmgeax1XRrn3ert3JIvjt6Z5hYYCFIaXyXDQnb1OVswDJLt7Z2T/6f
 MK0rpTUVzWJW4RjlB+bKRRvxavBEYwtm9FXrtY2LCZHd+DQdTcSAKBp4MBJmBTS5GAdz
 rmZg==
X-Gm-Message-State: AOJu0YzqRo0Q14al/V9t5Z5z2vkVowyOAc0b0TsRyixdnr/vPIPHiirB
 Agrq2SyxPx23tPqe0z2ycOcGqEQS432SoFK8V8SIADnMp9gj08cv4XzEFDhE/IZ8w7g=
X-Gm-Gg: AfdE7clBzB8g86/HwaXh+2RSg8qZR+XIcWP5f51aU7mr4W/GE1QLGpNayyvsrZ5OLo6
 etGHbxGy1Zf2o/VYtam5Uoo/caaK1i3DT/K2G2arFhM/VTbDwIB80d42HLLd0bSKRYP5WR3amOU
 MXqFO85njiLW8JZM6vSwgfKwKCxptN9IrW+RQ5pRkeCJPX3j65sFrseYfEMJhesH5/CZYEvXXGE
 9xibrdC3aVXzzS0jICkuSfIZAvHLldHFHqe5NVhPpI73QwtNHm5OFw5dhJ8fY7lTnrJP8HBXFjy
 fwZ96LShbADBPeI2eU90JvHAf8m23nWmhTBJdftFyz61sJvM6IuHIXYZUk3kfuJFoBtLrCULfXF
 H4/XjdzTEUjCADmsASfUqF17PsOcQbjyOnU9C1Fa5UMjIDySyiOUOuxVwBHi68EvQ2o797wJD8U
 uQTRjEijJjVFGN/r44m85RZfi5NAMR/8RquZZYypMEis2EYxA6Vk89VtDob6CsPsK6pBA0A6Y7H
 LYC0KhiukQc6cILZnTKeiSdQ6ki6GSxG769toju2FqocRW6hK27cwOobzy5GWV9l8+lBEE=
X-Received: by 2002:a05:600c:4fc6:b0:492:43d2:9e6e with SMTP id
 5b1f17b1804b1-493e68391c1mr119655325e9.9.1783692781200; 
 Fri, 10 Jul 2026 07:13:01 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2d88698sm64073205e9.1.2026.07.10.07.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 07:13:00 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 10 Jul 2026 16:12:58 +0200
Subject: [PATCH 7/9] clk: mediatek: mt7981: convert to mtk_gate_clk_data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-b4-mtk-clk-cleanup-clock-gate-drivers-v1-7-a4b5c491d9bf@baylibre.com>
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

MT7981 currently declares a separate U_BOOT_DRIVER, probe() function
and compatible table for each clock gate controller, despite all of
them sharing the same implementation.

Convert MT7981 to use the generic mtk_gate_clk_data infrastructure.
sgmiisys_0 and sgmiisys_1 are merged into a single generic driver,
while ethsys keeps its own U_BOOT_DRIVER since it additionally binds
a reset controller, but shares the generic probe() function.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7981.c | 66 ++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 36 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index 4e3a1c9d835..b8064073bb6 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -751,26 +751,6 @@ static const struct mtk_gate sgmii0_cgs[] = {
 	GATE_SGMII(CLK_SGM0_CDR_CK0_EN, "sgm0_cdr_ck0_en", CLK_TOP_USB_CDR_CK, 5),
 };
 
-static int mt7981_sgmii0sys_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt7981_clk_tree,
-					sgmii0_cgs, ARRAY_SIZE(sgmii0_cgs), 0);
-}
-
-static const struct udevice_id mt7981_sgmii0sys_compat[] = {
-	{ .compatible = "mediatek,mt7981-sgmiisys_0", },
-	{}
-};
-
-U_BOOT_DRIVER(mt7981_clk_sgmii0sys) = {
-	.name = "mt7981-clock-sgmii0sys",
-	.id = UCLASS_CLK,
-	.of_match = mt7981_sgmii0sys_compat,
-	.probe = mt7981_sgmii0sys_probe,
-	.priv_auto = sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
-};
-
 static const struct mtk_gate sgmii1_cgs[] = {
 	GATE_SGMII(CLK_SGM1_TX_EN, "sgm1_tx_en", CLK_TOP_USB_TX250M, 2),
 	GATE_SGMII(CLK_SGM1_RX_EN, "sgm1_rx_en", CLK_TOP_USB_EQ_RX250M, 3),
@@ -778,22 +758,37 @@ static const struct mtk_gate sgmii1_cgs[] = {
 	GATE_SGMII(CLK_SGM1_CDR_CK1_EN, "sgm1_cdr_ck1_en", CLK_TOP_USB_CDR_CK, 5),
 };
 
-static int mt7981_sgmii1sys_probe(struct udevice *dev)
+static int mt7981_clk_gate_probe(struct udevice *dev)
 {
+	struct mtk_gate_clk_data *data;
+
+	data = (void *)dev_get_driver_data(dev);
+
 	return mtk_common_clk_gate_init(dev, &mt7981_clk_tree,
-					sgmii1_cgs, ARRAY_SIZE(sgmii1_cgs), 0);
+					data->gates, data->num_gates,
+					data->gates[0].id);
 }
 
-static const struct udevice_id mt7981_sgmii1sys_compat[] = {
-	{ .compatible = "mediatek,mt7981-sgmiisys_1", },
+MTK_GATE_CLK_DATA(sgmii0_cgs);
+MTK_GATE_CLK_DATA(sgmii1_cgs);
+
+static const struct udevice_id mt7981_clk_gate_compat[] = {
+	{
+		.compatible = "mediatek,mt7981-sgmiisys_0",
+		.data = (ulong)&sgmii0_cgs_data,
+	},
+	{
+		.compatible = "mediatek,mt7981-sgmiisys_1",
+		.data = (ulong)&sgmii1_cgs_data,
+	},
 	{}
 };
 
-U_BOOT_DRIVER(mt7981_clk_sgmii1sys) = {
-	.name = "mt7981-clock-sgmii1sys",
+U_BOOT_DRIVER(mt7981_clk_gate) = {
+	.name = "mt7981-gate-clk",
 	.id = UCLASS_CLK,
-	.of_match = mt7981_sgmii1sys_compat,
-	.probe = mt7981_sgmii1sys_probe,
+	.of_match = mt7981_clk_gate_compat,
+	.probe = mt7981_clk_gate_probe,
 	.priv_auto = sizeof(struct mtk_cg_priv),
 	.ops = &mtk_clk_gate_ops,
 };
@@ -819,12 +814,6 @@ static const struct mtk_gate eth_cgs[] = {
 	GATE_ETH(CLK_ETH_WOCPU0_EN, "eth_wocpu0_en", CLK_TOP_NETSYS_WED_MCU, 15),
 };
 
-static int mt7981_ethsys_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt7981_clk_tree,
-					eth_cgs, ARRAY_SIZE(eth_cgs), 0);
-}
-
 static int mt7981_ethsys_bind(struct udevice *dev)
 {
 	int ret = 0;
@@ -838,8 +827,13 @@ static int mt7981_ethsys_bind(struct udevice *dev)
 	return ret;
 }
 
+MTK_GATE_CLK_DATA(eth_cgs);
+
 static const struct udevice_id mt7981_ethsys_compat[] = {
-	{ .compatible = "mediatek,mt7981-ethsys", },
+	{
+		.compatible = "mediatek,mt7981-ethsys",
+		.data = (ulong)&eth_cgs_data,
+	},
 	{}
 };
 
@@ -847,7 +841,7 @@ U_BOOT_DRIVER(mt7981_clk_ethsys) = {
 	.name = "mt7981-clock-ethsys",
 	.id = UCLASS_CLK,
 	.of_match = mt7981_ethsys_compat,
-	.probe = mt7981_ethsys_probe,
+	.probe = mt7981_clk_gate_probe,
 	.bind = mt7981_ethsys_bind,
 	.priv_auto = sizeof(struct mtk_cg_priv),
 	.ops = &mtk_clk_gate_ops,

-- 
2.54.0

