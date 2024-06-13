Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B407FC27C75
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 12:44:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDAF088908;
	Thu, 13 Jun 2024 14:43:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H4xh03AJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9814888F9; Thu, 13 Jun 2024 13:10:19 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4E4D888F6
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 13:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-57cb9efd8d1so609264a12.0
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 04:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718277017; x=1718881817; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=f3P4MUFnz6jH8ZIpT84vFt6ekwmHdCr6I1GU5B/nij0=;
 b=H4xh03AJyjm261JpKxzFpE6WkO5AB6TEEJHRZd00JbOMX1ebXWAD1xCWfCJXNMY57o
 iJfZGsCFwWq5pF7oGRYJ77JFhYsFd7Y3CIs5zXyTL0vWrDUdPYfjUuGFVXhMt2Of2/gm
 tsjH1uV/C/25HNxb99o9h4dJFEiCufHjvGYvz136aJUnzUJiPqBDSCxeyMuOhPdTyMtz
 JU12J9qhFl90dkbYwJ0qhsVlcLDa/Kmedz6BeAY5WFMj4GdGNXXEvSI2cf/UXvw0N4W8
 pwbIWOq3GHkNhLLpFR6iEunMSqbfAIz7CPueYFUaKsoGrBOQMztC0FQDZ69aidD8sHxx
 5M1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718277017; x=1718881817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f3P4MUFnz6jH8ZIpT84vFt6ekwmHdCr6I1GU5B/nij0=;
 b=dZaZwRPxizB6FeuwtOI2KCVf9Xte0LbZmMDDmnc3I7x/7ByZvLknTDiD1e8i8+yT/7
 Rq+S4TJyoYfOp1YtCLor/1J5Strao4i/EnrQ5x/xAxRJx8Bmovlp/AqMcbo9T1N6zUu5
 aimtsrkSmuSffJA4fSAhJme8ppWYF4cbXmDZMYbohsyXc8hAr+XHMi1KML3lON094H5B
 /oLzobpJWsOACtMRc4k3spMd5c4Fwor8Imk3VXbfl0MSftf22kgY5PiomCjyKyu5G6CB
 AJG6BvN0GMP6+VHxeWjbwdkvQXRe0mIwtsfdXIHRqy/76L3qTTT2I8eGDcAnOC8O5r4G
 fDWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWdFhvYPc15E7URQRp2YRoBKnnb5bA02QFYLIBQR9Psbe8PMP9arbYNgxygXOF9cG72GStQgaXifRH2OxdFzxXJ5PeRA==
X-Gm-Message-State: AOJu0YwzYZNqLEeDdsqg8YzTSOGWiW8LI9Tl4EA9wJCQaF+k0vh8lPeU
 NyD8U2zIVPh/IHjDR9RfgM38WFpAuPRy+6RAjXPRmFamH0sgZK1N
X-Google-Smtp-Source: AGHT+IH0EgvryHl87x83tzRJpuiBJ1rpfzdZr0Y7qNyiWnTr1QIDKSj4IifhHfhjOl5NHHvVyY8IDA==
X-Received: by 2002:a17:906:dfe3:b0:a6f:4746:4ee7 with SMTP id
 a640c23a62f3a-a6f5240b7damr175675966b.11.1718277016897; 
 Thu, 13 Jun 2024 04:10:16 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a6f56f416dfsm60580366b.164.2024.06.13.04.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 04:10:16 -0700 (PDT)
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
 Jagan Teki <jagan@amarulasolutions.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sergei Antonov <saproj@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mason Huo <mason.huo@starfivetech.com>,
 Mark Kettenis <kettenis@openbsd.org>, Sumit Garg <sumit.garg@linaro.org>,
 John Crispin <john@phrozen.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Minda Chen <minda.chen@starfivetech.com>, Marek Vasut <marex@denx.de>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Stefan Roese <sr@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Sam Shih <sam.shih@mediatek.com>, u-boot@lists.denx.de
Subject: [PATCH v2 03/14] spi: mtk_spim: add support for upstream mediatek,
 spi-ipm compatible
Date: Thu, 13 Jun 2024 13:09:21 +0200
Message-ID: <20240613110949.11076-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613110949.11076-1-ansuelsmth@gmail.com>
References: <20240613110949.11076-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Jun 2024 14:43:53 +0200
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

