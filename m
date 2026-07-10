Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B95BC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 14:13:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DFDC84B39;
	Fri, 10 Jul 2026 16:13:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="PtMN9BGT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9125E84A7A; Fri, 10 Jul 2026 16:12:59 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ECA884B20
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 16:12:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-493bfe9f886so5043425e9.0
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 07:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783692777; x=1784297577; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w33Lk5LGR9oDDKMuejhDB6nF5GK8hsMDs3NReC59mCY=;
 b=PtMN9BGTMNe4r2Ix29oNPU8dTn9yBHEM96ZlT7B0Fa92f40vHBvsRJ9i2icZB+5JVJ
 dmgmMPKqnRR6ftpOPPqYnxupP7HGcpWhPAFpstkfFwX8zHVEgCoc9YcjaYCX6ipSAJrb
 tPPq+LXWEtJRLP5WUjdcmBX86Lac249mK7RjbYIkfV08IhK8OGMJeWq21oL+AjEb7IXm
 rLdT4ldueu9iW91MhvmH28usTzyX6glJf5YlvbrvRLAranoFt5cI38awQTWIw6m4Fbid
 drEy3IOHh5Jfj1i5GlZ7WPo+eJuraD2g2J8etSKh0kGLB2M8+bVbV47US1SJJV9kw6UW
 9hNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783692777; x=1784297577;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w33Lk5LGR9oDDKMuejhDB6nF5GK8hsMDs3NReC59mCY=;
 b=biyGW8jfyn0Mv60p33qsi+DyL7U6wNyzhGTijaCidE/sQzKXN+6kw6u1LXuaO18lQK
 yZDxtbUlkwJgzVA35WD8NeKOyFSlShmIrhLHG2PLmeqz5sbN7ImZ5IGHaKCXcGZPXKfc
 sOg0lxBV1Nhkd9HYjSEJcyUvm6Cwn+426R6OZz/w8988YBD85frwZAKzDsVXSOt0T0HY
 /NFy0nX3MFm6W2LNVzM5aIoSoWZ9lM9VU55RaK1dAoadDEZBeBZH77CEzXC3RritBMoh
 P/W+wKrKq7ijBTjAnbFsLYEtkIHaHGAbbiMq1rBO4Gq+6Hxxc70+u2NHP1s4eAflu77D
 V8UQ==
X-Gm-Message-State: AOJu0Yzgd58BWC5u1+w67waIq44kg2jSbXtcgr3g67Aipv4ytRYICb6N
 6SlHZ0vyRkIz+7Qr+yo3NvnjewT7Sx0G5YlWa/Xs9cwvvCDPH9hSQ5CjnWadJKbApkA=
X-Gm-Gg: AfdE7cmDHpPcnn3F1xUvXBcGRDcGjvxOGYOQ18nIG3efCHH0gL8a862cd63xkQxti3I
 MoOrGDu7njBo9tAGuhhRaN59aOt8451ARuETGaW1LukBL73IAP+XOY7Jjw+jo/9IvIm0V3IhL/K
 YaW/eWpLGVMI0gEkbQNpV8bdX+XtQXNp/RGA8ANPqPdke7amF/PcVxqy0lqqA1n30S/iVknNNxf
 sEgDzSeCKCHCS5tBUn7fau9ymz50BgBWawvUc22hPcuLXp9mUNtzcbgYyFmnOpg9YcRQqkBefWh
 bjvp+x7encMr9zmvPHuwFvy1g910h3aprgxyTkjBrYubDd88Gxqdeq1zbRoL2R2YLgw+thMdg1W
 hh4h8D/Zc9/Zp42gRcDpVIbXOF53CHp8t5f1UjScH7PejlRb934eGyZfYaOKys9oAd2dDvXoI4W
 us0dTc1fKno3IjISi7ZnLerKjv7flU+UGMC1kLSQl+Sc5P65r4MVffrBIp8MZGsvKicFybwQJtc
 J+VwBSGSlqyivyqF2H4STXIP7VWb+VxFErVmfXZIEeSvCIzC8L1d5QIbmmJfK0YsDRCAcc=
X-Received: by 2002:a05:600c:c1d7:20b0:492:68f5:6b30 with SMTP id
 5b1f17b1804b1-493e69de0d0mr94649535e9.17.1783692777035; 
 Fri, 10 Jul 2026 07:12:57 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2d88698sm64073205e9.1.2026.07.10.07.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 07:12:56 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 10 Jul 2026 16:12:55 +0200
Subject: [PATCH 4/9] clk: mediatek: mt7622: convert to mtk_gate_clk_data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-b4-mtk-clk-cleanup-clock-gate-drivers-v1-4-a4b5c491d9bf@baylibre.com>
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

MT7622 currently declares a separate U_BOOT_DRIVER, probe() function
and compatible table for each clock gate controller, despite all of
them sharing the same implementation.

Convert MT7622 to use the generic mtk_gate_clk_data infrastructure.
The pciesys and ethsys controllers additionally bind a reset
controller, so they are grouped in a dedicated driver that shares the
generic probe() function, with a single bind() implementation
replacing the two duplicated copies. The remaining controllers
(sgmiisys, ssusbsys) are handled by a single generic driver.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7622.c | 113 +++++++++++++-------------------------
 1 file changed, 39 insertions(+), 74 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 76bc31f06d2..d01e2fe53bf 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -707,32 +707,18 @@ static int mt7622_pericfg_probe(struct udevice *dev)
 	return mtk_common_clk_init(dev, &mt7622_peri_clk_tree);
 }
 
-static int mt7622_pciesys_probe(struct udevice *dev)
+static int mt7622_clk_gate_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7622_clk_tree, pcie_cgs,
-					ARRAY_SIZE(pcie_cgs), 0);
-}
+	struct mtk_gate_clk_data *data;
 
-static int mt7622_pciesys_bind(struct udevice *dev)
-{
-	int ret = 0;
+	data = (void *)dev_get_driver_data(dev);
 
-	if (IS_ENABLED(CONFIG_RESET_MEDIATEK)) {
-	ret = mediatek_reset_bind(dev, ETHSYS_HIFSYS_RST_CTRL_OFS, 1);
-	if (ret)
-		debug("Warning: failed to bind reset controller\n");
-	}
-
-	return ret;
+	return mtk_common_clk_gate_init(dev, &mt7622_clk_tree,
+					data->gates, data->num_gates,
+					data->gates[0].id);
 }
 
-static int mt7622_ethsys_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt7622_clk_tree, eth_cgs,
-					ARRAY_SIZE(eth_cgs), 0);
-}
-
-static int mt7622_ethsys_bind(struct udevice *dev)
+static int mt7622_clk_gate_reset_bind(struct udevice *dev)
 {
 	int ret = 0;
 
@@ -745,18 +731,6 @@ static int mt7622_ethsys_bind(struct udevice *dev)
 	return ret;
 }
 
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
@@ -777,18 +751,33 @@ static const struct udevice_id mt7622_pericfg_compat[] = {
 	{ }
 };
 
-static const struct udevice_id mt7622_pciesys_compat[] = {
-	{ .compatible = "mediatek,mt7622-pciesys", },
-	{ }
-};
+MTK_GATE_CLK_DATA(pcie_cgs);
+MTK_GATE_CLK_DATA(eth_cgs);
 
-static const struct udevice_id mt7622_ethsys_compat[] = {
-	{ .compatible = "mediatek,mt7622-ethsys", },
+static const struct udevice_id mt7622_clk_gate_reset_compat[] = {
+	{
+		.compatible = "mediatek,mt7622-pciesys",
+		.data = (ulong)&pcie_cgs_data
+	},
+	{
+		.compatible = "mediatek,mt7622-ethsys",
+		.data = (ulong)&eth_cgs_data
+	},
 	{ }
 };
 
-static const struct udevice_id mt7622_sgmiisys_compat[] = {
-	{ .compatible = "mediatek,mt7622-sgmiisys", },
+MTK_GATE_CLK_DATA(sgmii_cgs);
+MTK_GATE_CLK_DATA(ssusb_cgs);
+
+static const struct udevice_id mt7622_clk_gate_compat[] = {
+	{
+		.compatible = "mediatek,mt7622-sgmiisys",
+		.data = (ulong)&sgmii_cgs_data
+	},
+	{
+		.compatible = "mediatek,mt7622-ssusbsys",
+		.data = (ulong)&ssusb_cgs_data
+	},
 	{ }
 };
 
@@ -797,11 +786,6 @@ static const struct udevice_id mt7622_mcucfg_compat[] = {
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
@@ -852,40 +836,21 @@ U_BOOT_DRIVER(mt7622_clk_pericfg) = {
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
-	.id = UCLASS_CLK,
-	.of_match = mt7622_ethsys_compat,
-	.probe = mt7622_ethsys_probe,
-	.bind = mt7622_ethsys_bind,
-	.priv_auto	= sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
-};
-
-U_BOOT_DRIVER(mt7622_clk_sgmiisys) = {
-	.name = "mt7622-clock-sgmiisys",
+U_BOOT_DRIVER(mt7622_clk_gate_reset) = {
+	.name = "mt7622-gate-clk-reset",
 	.id = UCLASS_CLK,
-	.of_match = mt7622_sgmiisys_compat,
-	.probe = mt7622_sgmiisys_probe,
+	.of_match = mt7622_clk_gate_reset_compat,
+	.probe = mt7622_clk_gate_probe,
+	.bind = mt7622_clk_gate_reset_bind,
 	.priv_auto	= sizeof(struct mtk_cg_priv),
 	.ops = &mtk_clk_gate_ops,
 };
 
-U_BOOT_DRIVER(mt7622_clk_ssusbsys) = {
-	.name = "mt7622-clock-ssusbsys",
+U_BOOT_DRIVER(mt7622_clk_gate) = {
+	.name = "mt7622-gate-clk",
 	.id = UCLASS_CLK,
-	.of_match = mt7622_ssusbsys_compat,
-	.probe = mt7622_ssusbsys_probe,
+	.of_match = mt7622_clk_gate_compat,
+	.probe = mt7622_clk_gate_probe,
 	.priv_auto	= sizeof(struct mtk_cg_priv),
 	.ops = &mtk_clk_gate_ops,
 };

-- 
2.54.0

