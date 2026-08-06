Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BC3C56208
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 16:15:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B88180E9C;
	Thu,  6 Aug 2026 16:15:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tegTcvRD3Y3y; Thu,  6 Aug 2026 16:15:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 65B4580E7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786032932;
	bh=WiEoqdG/rDlynBd2ILAaf5AZOsWCRvGFFd55gIsjrpo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NwY6AyX3VbfOjJcywPJ28RC86Q3MABZRscYY1FUDjmLqMpd+uOjyvUtZdKylFLWfY
	 K7lTJOP59wl6ks1vzm45aW7DQqgygzJHPP0gUY2VA6nOEYHCs53IBA+8TvT5xSDFZx
	 D8MP5md+oJYYx290nywI61+kwYFTt5qZzAs45eN/+y9g9HHadRZ8aDd+F46ccpSTpF
	 VmE42r1nX2v2VNNsbwo23AYhaozWIx6iiOHwyAPl4C73fUX7blO+2sMbh1qdxXTJP2
	 x3IWeIzZtlIHwkhCpQZxZYiuESp8PPXF4F/bYCsbF8PoxaCPSg0NeFN9l0Bj9bvEo/
	 89MKsz+NnFO4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 65B4580E7D;
	Thu,  6 Aug 2026 16:15:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 11A46218
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:15:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EC7DA60806
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:15:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LmFJn7HqxbqI for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 16:15:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C669460808
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C669460808
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C669460808
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:15:29 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7e9d7464b71so1180892a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 09:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786032928; x=1786637728;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WiEoqdG/rDlynBd2ILAaf5AZOsWCRvGFFd55gIsjrpo=;
 b=EoB+jNjiWeWZ1CkmfSGjiqy+zdscflOn+MwIVpxJ4u0K1Zy5rPdARbKSsrLbqCqWEN
 9V9yaR28I5S+tZ3Io0hFZfDG9zP9PnjVNIQG+RPtywkR+9Ifq9Av5Jufg/3hUrV8XMXN
 Bnw1AJdUSDfDC+qT7hSaBv79ckOzWQKYiGwNeLMs0/neFvPyBDZynT4beYfh38d+6oKv
 vsuETm8PhnMAQRjSa1dGaGdAmnhT/ThVLRD4lu66wGcotc2VIM0ZtWM3MP4jQwjrvfhy
 DeJVnMnn2MHtLqkLMXTg4Sov38i8obIVyUIpb4IAXo4i6FLOpB0+67RcKduBQbpTHDZ7
 mH5w==
X-Gm-Message-State: AOJu0YwkyHlywIkoj5qvtexhe4vtsmS64dC237siMT4IN4hpFFgk2hXh
 dBzxfMaUGjhHBCK9ZbEEtuWz1LSFq/JZiAhD2YW7kuMMMtVpkZ9cKM4EJyGt29XKo4QEPw844yD
 MinRLpQQ=
X-Gm-Gg: AR+sD10Wy19QywhR0vbW6REqnF3zp7WQo9jli0ZjQfTd326w/hp88EgUIbBhr14xYTe
 yDNLt7FfPXwqOdIi3J7VPgW5TfkQxiZ3SAJPbnw2pgzmAXSQbsXRfzOmFUDiRDxZCZIuscwNs0G
 uRoWMo7A9R/dgmRrJ4hHIn68uopuhIxQTKehpyeTG96lGny+PjDVSllI6nIzDho2/jYHENTM/Sd
 Bne8tswfR22ditOxuJQzcGfmzdvfJYXbaRqq33XLQtnDzfNTBQSQ4VcaO9X3h3G9FEXZ4kpu6cU
 2adtOQh1KyriPe1KmGFooL/y+uLZfxA6CJq3v+rR4fvMNFNP/YiduYPQuO5cWT5FAYXYBfuk8Ks
 BnfXP7Z147U3N/fSk60uxbNIzCgceKAq4j5ni4gL2pQz4V5dkErEOFSvhU3kEdL6XIV/thbhBZr
 wjtNpBMkKl6buM7y0nK4mh9CPclmgxp3g5aevuvqFaS+iK/du7JxQcNUwvjIOXkga1JA==
X-Received: by 2002:a05:6830:7103:b0:7d7:fbe2:9725 with SMTP id
 46e09a7af769-7f1e5cc3c9bmr9385343a34.5.1786032928557; 
 Thu, 06 Aug 2026 09:15:28 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:beb1:8dd1:72b8:350d])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f1df568d7csm4563367a34.18.2026.08.06.09.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 09:15:28 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 06 Aug 2026 11:14:59 -0500
Subject: [PATCH 1/3] net: dwc_eth_qos_mtk: support platform-specific
 PERI_ETH_BASE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-mtk-net-mt8366-support-v1-1-5eb259ff69dd@baylibre.com>
References: <20260806-mtk-net-mt8366-support-v1-0-5eb259ff69dd@baylibre.com>
In-Reply-To: <20260806-mtk-net-mt8366-support-v1-0-5eb259ff69dd@baylibre.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4909; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=ch1TgzJOGXb3VtVmxVWg2vAtj+6frP8Wbn3nY8lL68s=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqdLMKLNkvypNR9XVeN2ULPnxhJzW98I/4x656C
 Xk5Ji4YOdyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanSzChYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ADPcIAJnuV3sIbxvWXiQ91y3J8ewC5YEKHvXYKMwDedq
 MhqpUn8NJ8sgYX7a4hbuKP/ZhC9UjxrbFxoCo/rvKvK4xEmCSsCqUZeqTp7VPF1DA+vXrSEdy+r
 a9J1gnHxD7Yo3dn+ItBkNazBzRBN+QYKcTJPfYO1GRiZbsEeI6xq0U7iSWMkJ7xJJmrM2l1MBZI
 uloE7iZDd3yED3AQBjouRKNwUg36MpkJWCHAz37oJKNKDvJmlHsTX/a+HUVY+8pa5csxe1T6F2K
 17ioiMVrSXb7cl2DD2HLRTVcP7gI6fla/gfBw2jOraHEBvvcWlMTnRhmKyLMqIZ6zWeyE2pxxrC
 HG/E=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786032928; x=1786637728;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WiEoqdG/rDlynBd2ILAaf5AZOsWCRvGFFd55gIsjrpo=;
 b=CH8BuU38PPo4h/yJFrAZFr73IjiMfZuTJt5o5e8K4XS3cil061N6tH0IiCYEEqDUgQ
 sAaYW3sUiCw874DCFcHcXLznU9Mfo+2QgYoHbZoeRhi47fqeCfA6WMB3RRzJuEPoR3pt
 NP2Oe7W+iTcu8gBJlLNzBrbfeG/woUdtlkwG8IIUaUsMQPqiDazSewS+yJu5D4VHS4SH
 0eHiKBIemBqig1Tvbs5EYGOou9j0Eep3tumk5r23uYVPp/V8e7OOJremLHvnq30l48zj
 LVADYtrz2r+BuDWbPBWNyeuV6ElmkE0JZNPAJGWATh3qPM3AGXKNPDowVmHs4UOrslxG
 GSqA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=CH8BuU38
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add infrastructure to support future MediaTek platforms that have a
different PERI_ETH_BASE address. There are at least 3 different known
base address for this.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/net/dwc_eth_qos_mtk.c | 58 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 50 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dwc_eth_qos_mtk.c b/drivers/net/dwc_eth_qos_mtk.c
index 43e1085dfe5..a113870dc8a 100644
--- a/drivers/net/dwc_eth_qos_mtk.c
+++ b/drivers/net/dwc_eth_qos_mtk.c
@@ -18,9 +18,11 @@
  * Peri Configuration register is SoC specific,
  * so add a SoC specific prefix.
  */
-#define MT8189_PERI_ETH_CTRL0		0x270
-#define MT8189_PERI_ETH_CTRL1		0x274
-#define MT8189_PERI_ETH_CTRL2		0x278
+#define MT8189_PERI_ETH_BASE		0x270
+
+#define MTK_PERI_ETH_CTRL0(base)	((base) + 0x0)
+#define MTK_PERI_ETH_CTRL1(base)	((base) + 0x4)
+#define MTK_PERI_ETH_CTRL2(base)	((base) + 0x8)
 
 #define EQOS_MTK_RMII_CLK_SRC_INTERNAL	BIT(28)
 #define EQOS_MTK_RMII_CLK_SRC_RXC	BIT(27)
@@ -55,6 +57,7 @@
 
 struct eqos_mtk_priv {
 	struct regmap *peri_regmap;
+	const struct eqos_mtk_soc_data *soc_data;
 	bool rmii_clk_from_mac;
 	bool rmii_rxc;
 	u32 tx_delay_stage;
@@ -63,6 +66,32 @@ struct eqos_mtk_priv {
 	bool rx_inv;
 };
 
+struct eqos_mtk_soc_data {
+	const char *compatible;
+	u32 peri_eth_base;
+};
+
+static const struct eqos_mtk_soc_data eqos_mtk_soc_data[] = {
+	{
+		.compatible = "mediatek,mt8189-gmac",
+		.peri_eth_base = MT8189_PERI_ETH_BASE,
+	},
+	{ }
+};
+
+static const struct eqos_mtk_soc_data *eqos_mtk_get_soc_data(struct udevice *dev)
+{
+	const struct eqos_mtk_soc_data *data = eqos_mtk_soc_data;
+
+	while (data->compatible) {
+		if (device_is_compatible(dev, data->compatible))
+			return data;
+		data++;
+	}
+
+	return NULL;
+}
+
 static int mtk_clk_init(struct udevice *dev)
 {
 	struct eqos_priv *eqos = dev_get_priv(dev);
@@ -87,6 +116,7 @@ static int mtk_set_delay(struct udevice *dev)
 {
 	struct eth_pdata *pdata = dev_get_plat(dev);
 	struct eqos_mtk_priv *mtk_pdata = pdata->priv_pdata;
+	u32 peri_eth_base = mtk_pdata->soc_data->peri_eth_base;
 	u32 gtxc_delay_val = 0, delay_val = 0, rmii_delay_val = 0;
 
 	switch (pdata->phy_interface) {
@@ -176,15 +206,17 @@ static int mtk_set_delay(struct udevice *dev)
 	}
 
 	regmap_update_bits(mtk_pdata->peri_regmap,
-			   MT8189_PERI_ETH_CTRL0,
+			   MTK_PERI_ETH_CTRL0(peri_eth_base),
 			   EQOS_MTK_RGMII_TXC_PHASE_CTRL |
 			   EQOS_MTK_DLY_GTXC_ENABLE |
 			   EQOS_MTK_DLY_GTXC_INV |
 			   EQOS_MTK_DLY_GTXC_STAGE_FINE |
 			   EQOS_MTK_DLY_GTXC_STAGES,
 			   gtxc_delay_val);
-	regmap_write(mtk_pdata->peri_regmap, MT8189_PERI_ETH_CTRL1, delay_val);
-	regmap_write(mtk_pdata->peri_regmap, MT8189_PERI_ETH_CTRL2, rmii_delay_val);
+	regmap_write(mtk_pdata->peri_regmap,
+		     MTK_PERI_ETH_CTRL1(peri_eth_base), delay_val);
+	regmap_write(mtk_pdata->peri_regmap,
+		     MTK_PERI_ETH_CTRL2(peri_eth_base), rmii_delay_val);
 
 	return 0;
 }
@@ -195,6 +227,7 @@ static int mtk_set_interface(struct udevice *dev)
 	struct eqos_mtk_priv *mtk_pdata = pdata->priv_pdata;
 	int rmii_clk_from_mac = mtk_pdata->rmii_clk_from_mac ? EQOS_MTK_RMII_CLK_SRC_INTERNAL : 0;
 	int rmii_rxc = mtk_pdata->rmii_rxc ? EQOS_MTK_RMII_CLK_SRC_RXC : 0;
+	u32 peri_eth_base = mtk_pdata->soc_data->peri_eth_base;
 	u32 intf_val = 0;
 
 	/* select phy interface in top control domain */
@@ -222,7 +255,8 @@ static int mtk_set_interface(struct udevice *dev)
 
 	intf_val |= EQOS_MTK_TXC_OUT_OP;
 
-	regmap_write(mtk_pdata->peri_regmap, MT8189_PERI_ETH_CTRL0, intf_val);
+	regmap_write(mtk_pdata->peri_regmap,
+		     MTK_PERI_ETH_CTRL0(peri_eth_base), intf_val);
 
 	return 0;
 }
@@ -290,6 +324,13 @@ static int eqos_probe_resources_mtk(struct udevice *dev)
 	if (!mtk_pdata)
 		return -ENOMEM;
 
+	mtk_pdata->soc_data = eqos_mtk_get_soc_data(dev);
+	if (!mtk_pdata->soc_data) {
+		dev_err(dev, "missing MTK SoC data\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
 	pdata->priv_pdata = mtk_pdata;
 
 	ret = mtk_config_dt(dev);
@@ -384,6 +425,7 @@ static int eqos_fix_mac_speed_mtk(struct udevice *dev)
 	struct eqos_priv *eqos = dev_get_priv(dev);
 	struct eth_pdata *pdata = dev_get_plat(dev);
 	struct eqos_mtk_priv *mtk_pdata = pdata->priv_pdata;
+	u32 peri_eth_base = mtk_pdata->soc_data->peri_eth_base;
 
 	debug("%s(dev=%p):\n", __func__, dev);
 
@@ -394,7 +436,7 @@ static int eqos_fix_mac_speed_mtk(struct udevice *dev)
 	case PHY_INTERFACE_MODE_RGMII_ID:
 		if (eqos->phy->speed == SPEED_1000)
 			regmap_update_bits(mtk_pdata->peri_regmap,
-					   MT8189_PERI_ETH_CTRL0,
+					   MTK_PERI_ETH_CTRL0(peri_eth_base),
 					   EQOS_MTK_RGMII_TXC_PHASE_CTRL |
 					   EQOS_MTK_DLY_GTXC_ENABLE |
 					   EQOS_MTK_DLY_GTXC_INV |

-- 
2.43.0

