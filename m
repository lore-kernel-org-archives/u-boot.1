Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBE3C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 19:38:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9666488400;
	Wed,  5 Jun 2024 21:37:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gLaIw/7g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9563087F39; Wed,  5 Jun 2024 21:03:45 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A690E88280
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 21:03:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-421392b8156so2201735e9.3
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 12:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717614223; x=1718219023; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=f3P4MUFnz6jH8ZIpT84vFt6ekwmHdCr6I1GU5B/nij0=;
 b=gLaIw/7g2HZJny1E3umLXO1oup9BGX9m4x3+N57+/xiVo5K9RjEgsc+wrF9cOa2BIT
 HaIqqDkPtjqvvKAnezwOuf43tLxaxjXXOQQY7m1MdhOFRxoCvubc5Aw1NgfcfoKRyywZ
 kdOwCE9l7yS0fM8NTumog8Miqq82yXuMz/6eNzu3Xj37kwEDXeVlbTKMJhVGvJJRwlK+
 C9EOBCffo3uqr0kM5RxEX31v47swn+6Q7s/vt1Na5+RT7sF0QGvnyIjVvH5/BOOL5SWQ
 C+AlsqZ7CVgsb1qvUZ7WXtldryi/N5RXFSBJRfRCcWCp/tR6jhymWJnpIPvxSs+gq3JN
 qCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717614223; x=1718219023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f3P4MUFnz6jH8ZIpT84vFt6ekwmHdCr6I1GU5B/nij0=;
 b=UvTqhT0RXvgyxeedC+V+CngfnWdhHcgTqPL87Bi4aTjilitn+9/qQF55zB7FcEXy3k
 pSdGCZyeGHCaiOeXvewjxocltDQmNIcSIOXI4H7lpb4NIGVGXSMbV7FCQyouSBm298tn
 w9CTOVLkepTyk7sxYpLL1RFFZyMuj/NnJUxuxMhZIBr+3AicP8al5W2udV1oqv2AjRmF
 cgExI3Zb0v6cQRF269pAiQyWLQwnRl0liioG9NinT77pWH4fS2eIgrFnRD9IAfKBUUQm
 zKdgg+aqDkj02EuYtDMQavdSLuumhyFTm4GaF6yexyyJqyTMbXb3287crAC3iYry/4h/
 cnNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrCPhwT6uX9Oh6vEmuQ0MQ6N5N9tc6/giURe/B68nVhNyXH7yqkTHRFbqIFixHjJ2mbW2Awkjf73jssTr2e7GME4BO+Q==
X-Gm-Message-State: AOJu0YxYHoP5DPkHXiSp4zRRy03yAXjDWkInyMEfJgD9PNvILzlBtgyd
 jGXpD+YgBdOoEWL9ME22PIFdhp4UUYXO+3v78FV+n+vfXMz9oqwF
X-Google-Smtp-Source: AGHT+IG1d8cXpNOHPdlfLkJ5jAyHahgDYbFRlcSMpaCur3l+wZ9eE+v9eCQmcX0z3S0OdxVv2c3pJA==
X-Received: by 2002:a05:600c:458e:b0:41f:d4e1:5abc with SMTP id
 5b1f17b1804b1-421562c298fmr29125905e9.8.1717614222747; 
 Wed, 05 Jun 2024 12:03:42 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4214a4abdd5sm44772195e9.0.2024.06.05.12.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 12:03:42 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Heiko Schocher <hs@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Sam Shih <sam.shih@mediatek.com>,
 Francois Berder <fberder@outlook.fr>, Simon Glass <sjg@chromium.org>,
 Julien Masson <jmasson@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bo-Cun Chen <bc-bocun.chen@mediatek.com>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Michal Simek <michal.simek@amd.com>, John Crispin <john@phrozen.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mason Huo <mason.huo@starfivetech.com>, Stefan Roese <sr@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Sergei Antonov <saproj@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 "SkyLake.Huang" <skylake.huang@mediatek.com>,
 =?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH 03/11] spi: mtk_spim: add support for upstream mediatek,
 spi-ipm compatible
Date: Wed,  5 Jun 2024 21:02:10 +0200
Message-ID: <20240605190220.17616-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605190220.17616-1-ansuelsmth@gmail.com>
References: <20240605190220.17616-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Jun 2024 21:37:35 +0200
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

Upstream kernel linux use a different compatible mediatek,spi-ipm.

Add support for this compatible and add handling for the additional
clock similar to how it's done by the upstream driver and handling for
all the property enabled by default.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/spi/mtk_spim.c | 45 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/mtk_spim.c b/drivers/spi/mtk_spim.c
index 90f4c3cecb9..b360eca2b91 100644
--- a/drivers/spi/mtk_spim.c
+++ b/drivers/spi/mtk_spim.c
@@ -137,6 +137,8 @@ struct mtk_spim_capability {
  * @state:		Controller state
  * @sel_clk:		Pad clock
  * @spi_clk:		Core clock
+ * @parent_clk:		Parent clock (needed for mediatek,spi-ipm, upstream DTSI)
+ * @hclk:		HCLK clock (needed for mediatek,spi-ipm, upstream DTSI)
  * @pll_clk_rate:	Controller's PLL source clock rate, which is different
  *			from SPI bus clock rate
  * @xfer_len:		Current length of data for transfer
@@ -151,6 +153,7 @@ struct mtk_spim_priv {
 	void __iomem *base;
 	u32 state;
 	struct clk sel_clk, spi_clk;
+	struct clk parent_clk, hclk;
 	u32 pll_clk_rate;
 	u32 xfer_len;
 	struct mtk_spim_capability hw_cap;
@@ -650,7 +653,21 @@ static int mtk_spim_probe(struct udevice *dev)
 	if (!priv->base)
 		return -EINVAL;
 
-	mtk_spim_get_attr(priv, dev);
+	/*
+	 * Upstream linux driver for ipm design enable all the modes
+	 * and setup the calibrarion values directly in the driver with
+	 * standard values.
+	 */
+	if (device_is_compatible(dev, "mediatek,spi-ipm")) {
+		priv->hw_cap.enhance_timing = true;
+		priv->hw_cap.dma_ext = true;
+		priv->hw_cap.ipm_design = true;
+		priv->hw_cap.support_quad = true;
+		priv->sample_sel = 0;
+		priv->tick_dly = 2;
+	} else {
+		mtk_spim_get_attr(priv, dev);
+	}
 
 	ret = clk_get_by_name(dev, "sel-clk", &priv->sel_clk);
 	if (ret < 0) {
@@ -664,8 +681,31 @@ static int mtk_spim_probe(struct udevice *dev)
 		return ret;
 	}
 
-	clk_enable(&priv->sel_clk);
+	/*
+	 * Upstream DTSI use a different compatible that provide additional
+	 * clock instead of the assigned-clock implementation.
+	 */
+	if (device_is_compatible(dev, "mediatek,spi-ipm")) {
+		ret = clk_get_by_name(dev, "parent-clk", &priv->parent_clk);
+		if (ret < 0) {
+			dev_err(dev, "failed to get parent-clk\n");
+			return ret;
+		}
+
+		ret = clk_get_by_name(dev, "hclk", &priv->hclk);
+		if (ret < 0) {
+			dev_err(dev, "failed to get hclk\n");
+			return ret;
+		}
+
+		clk_enable(&priv->parent_clk);
+		clk_set_parent(&priv->sel_clk, &priv->parent_clk);
+
+		clk_enable(&priv->hclk);
+	}
+
 	clk_enable(&priv->spi_clk);
+	clk_enable(&priv->sel_clk);
 
 	priv->pll_clk_rate = clk_get_rate(&priv->spi_clk);
 	if (priv->pll_clk_rate == 0)
@@ -698,6 +738,7 @@ static const struct dm_spi_ops mtk_spim_ops = {
 
 static const struct udevice_id mtk_spim_ids[] = {
 	{ .compatible = "mediatek,ipm-spi" },
+	{ .compatible = "mediatek,spi-ipm", },
 	{}
 };
 
-- 
2.43.0

