Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6815BC2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 21:05:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C536A8851C;
	Mon, 24 Jun 2024 23:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QkWFM7Ls";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A08F088387; Mon, 24 Jun 2024 23:04:33 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67B1588400
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 23:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-363bbd51050so3804904f8f.0
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719263071; x=1719867871; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H9F/sFt2dYW7KL9uQWBndq5AT8cP+85KY8XtN7IKt7U=;
 b=QkWFM7Lswi7ydgAdG6x3vNRj33fP2A3rRr3qF8nv1mVL4N3eFb6rIxhvWa2PgNDGdA
 o2O8M7Q9tYic92nKNc0VyGGkMTgE8o6hcQ5ZRiRuo2eRvGir9LsjVQETllW2V/cYAwuD
 2n+T/YnaMF8o0qU4GLpCaJXsDuwiHTREJFLBf3jgFhzx184joTiBroeUXfZn7pM49r3Y
 SKnukIUPZBqUeeeM0bhnKgkJfFiEIcJfqoBfzRK1aQcct83C3o/Swo9ES1vg+nwm6IML
 N1SyZNrQVwQHfg43TEcFXN10t6bDON02b0wtTN3g8Q59cze6FyTQi2xPIGDFrd/mCUbi
 HAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719263071; x=1719867871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H9F/sFt2dYW7KL9uQWBndq5AT8cP+85KY8XtN7IKt7U=;
 b=F0JQxSl9Vqx8ALAHwvUXELdx6Cr0BOw+WWv4HODcFsq4bnR6KDwYr16JvYy0FUeyif
 s3bpwEpz89ZeSATlImsEOqh/c1MZyhgUnZLj1uBkP8oyONiJykcGSxtkyQhjYPDU2U7F
 0P7OROknMLtXIu7dtORAnRdnKf80df7KDoAu1OwxFr51o4O7Ugk38gx4CzJ8WT1K2Q1S
 sIywRoTrC6BXnhMMAe+rH6TP5nlN1HXfHWi07//lhO+vOYfwYcF9460JnYjsoZ74Qj7G
 lRHQGsgF3we2wp2sFA4UhVFDJDhFr68p74EaOmAjB956eT4UpoOnuuSWyIOr+DxsCaO1
 kFIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK52KcCkd5mzXpQBiWQxWdHnirUaQ5NXdWtlBYM1ORZB2OhxPrXLwoRPD2q+RyTfE3imEwquCGgkmCUpIr0lGsePwcfA==
X-Gm-Message-State: AOJu0YyoGNgqM7sRTNez3CDLpIj1zPK7UrWRAVu7IF/rdho67K9LiGN4
 t0uUKN3bB5hTh/H7ZJfY9VVdrj5FNByNcPIBmtRiWU2Rg5BFk8Ug
X-Google-Smtp-Source: AGHT+IGVb5VKjCglzuz9PDhGayyfurj+gL6DwjpleFoXvA6GvMGbvjz6DosJYh29hyd71lpAafoYEQ==
X-Received: by 2002:a05:6000:1448:b0:366:e586:9131 with SMTP id
 ffacd0b85a97d-366e58692bdmr5286808f8f.16.1719263070652; 
 Mon, 24 Jun 2024 14:04:30 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3664178f5f7sm10968228f8f.19.2024.06.24.14.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 14:04:30 -0700 (PDT)
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
 Jagan Teki <jagan@amarulasolutions.com>, John Crispin <john@phrozen.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Mason Huo <mason.huo@starfivetech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sergei Antonov <saproj@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Marek Vasut <marex@denx.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>, Sam Shih <sam.shih@mediatek.com>,
 u-boot@lists.denx.de
Subject: [PATCH v4 03/14] spi: mtk_spim: add support for upstream mediatek,
 spi-ipm compatible
Date: Mon, 24 Jun 2024 23:03:29 +0200
Message-ID: <20240624210418.19324-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240624210418.19324-1-ansuelsmth@gmail.com>
References: <20240624210418.19324-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.45.1

