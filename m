Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345EEC4332F
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 13:38:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F01C86F1C;
	Sat, 11 Nov 2023 14:38:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MxhBJUXu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7642C86FD0; Sat, 11 Nov 2023 14:38:54 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3699186EF6
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 14:38:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50970c2115eso3960566e87.1
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 05:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699709931; x=1700314731; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y1xtkXwjxZIjoLRj4rxv11xKlTudblwEca8ejt1F0sk=;
 b=MxhBJUXuxuVuP8aTK11+SjDgDpHhARPpv+04P1FGfqssmdQ8BfE7+71yVYhByj5gzp
 65zZNHXnyeReuU9qNwmKdICnCakMVV+R7HZSpzTaXudzqwg6Kj75kKebGe7F8+m++2qS
 mxb/VZaOxT1lzeKzDt/CT8CQZnQYDBIqX6gyyuUXRWYcTy4e12OD825DEHBh1we+XQq0
 /stFfypVHYeVmeo4hDn/b8cTyozuWjsZWL6l1h5RHXCL1Fxqc4cBnE9BcTljrvKd78zy
 qZ7JxZYO/GJ3KsDe8Mb62IJnZA+KK0VIsNvtfEiVWIZm28YX7RFsAhaC9rjc3OjU4ogL
 MX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699709931; x=1700314731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y1xtkXwjxZIjoLRj4rxv11xKlTudblwEca8ejt1F0sk=;
 b=uHgNGjnm85EWYTw+NfK0vYKRAwRbW2uTD4oxE6l7uQFc+LUKsReUgCdrwbNfV5F8Yj
 2b1+qaj/6LlkBK66MhxeUQLwKY7A1gA1p4Q4eazcn6Bg+3MfTS/8RJxUTlScuIvXw5rx
 cIzK8rxAjC5L9TPj2IwSK4y1Wk0LEwyp38X9yKj4WbEnuLmoyzu9fy7Muhsmcvzgf8ZT
 5mJnfuSkDLMC7D/xRCrkP3Q64MeZ5QUGHvYNp55NemHkOYr3Tq0fhdUhn1QnWCR1Ki+V
 tcWWPaitANeYC/3KMoncHkBsG3UxQZL4ofw/tTH2shpxaPl6G+S9eDHqXxMv/UDr+t/p
 hwew==
X-Gm-Message-State: AOJu0Yy4pB04sbZvCvmGDL1CYVB6WdnZCjuizE3xwcAxYXT+hMrrW0/y
 YczpeAMmOzjgLxEs+66OWaBnCcWPS7VuUQ==
X-Google-Smtp-Source: AGHT+IFMex79WExUAFMFmwPemPhyWS35wnzsj7h40XS+7TLQuKPeZRec+v9rg65PB3CIyeEAbeRbEA==
X-Received: by 2002:a19:6745:0:b0:500:8022:3dc7 with SMTP id
 e5-20020a196745000000b0050080223dc7mr1138335lfj.10.1699709930556; 
 Sat, 11 Nov 2023 05:38:50 -0800 (PST)
Received: from user-PC.. ([178.134.170.122]) by smtp.gmail.com with ESMTPSA id
 h6-20020a0565123c8600b00509469ffb01sm277432lfv.193.2023.11.11.05.38.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 05:38:50 -0800 (PST)
From: Maksim Kiselev <bigunclemax@gmail.com>
To: u-boot@lists.denx.de
Cc: Sam Edwards <CFSworks@gmail.com>, Maksim Kiselev <bigunclemax@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v1 2/2] spi: sunxi: Add support for R329/D1/R528/T113 SPI
 controller
Date: Sat, 11 Nov 2023 16:33:08 +0300
Message-Id: <20231111133432.755363-3-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231111133432.755363-1-bigunclemax@gmail.com>
References: <20231111133432.755363-1-bigunclemax@gmail.com>
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

These SoCs have two SPI controllers that are quite similar to the SPI
on previous Allwinner SoCs. The main difference is that new SoCs
don't have a clock divider (SPI_CCR register) inside SPI IP.

Instead SPI sample mode should be configured depending on the input clock.

For now SPI input clock source selection is not supported by this driver,
and only HOSC@24MHz can be used as input clock. Therefore, according to
the, manual we could change the SPI sample mode from delay half
cycle(default) to normal.

This patch adds a quirk for this kind of SPI controllers

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
Tested-by: Sam Edwards <CFSworks@gmail.com>
---
 drivers/spi/spi-sunxi.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sunxi.c b/drivers/spi/spi-sunxi.c
index c56d82d998..9ec6b359e2 100644
--- a/drivers/spi/spi-sunxi.c
+++ b/drivers/spi/spi-sunxi.c
@@ -117,6 +117,8 @@ enum sun4i_spi_bits {
 	SPI_TCR_XCH,
 	SPI_TCR_CS_MANUAL,
 	SPI_TCR_CS_LEVEL,
+	SPI_TCR_SDC,
+	SPI_TCR_SDM,
 	SPI_FCR_TF_RST,
 	SPI_FCR_RF_RST,
 	SPI_FSR_RF_CNT_MASK,
@@ -128,6 +130,7 @@ struct sun4i_spi_variant {
 	u32 fifo_depth;
 	bool has_soft_reset;
 	bool has_burst_ctl;
+	bool has_clk_ctl;
 };
 
 struct sun4i_spi_plat {
@@ -302,7 +305,19 @@ static int sun4i_spi_claim_bus(struct udevice *dev)
 	setbits_le32(SPI_REG(priv, SPI_TCR), SPI_BIT(priv, SPI_TCR_CS_MANUAL) |
 		     SPI_BIT(priv, SPI_TCR_CS_ACTIVE_LOW));
 
-	sun4i_spi_set_speed_mode(dev->parent);
+	if (priv->variant->has_clk_ctl) {
+		sun4i_spi_set_speed_mode(dev->parent);
+	} else {
+		/*
+		 * At this moment there is no ability to change input clock.
+		 * Therefore, we can only use default HOSC@24MHz clock and
+		 * set SPI sampling mode to normal
+		 */
+		clrsetbits_le32(SPI_REG(priv, SPI_TCR),
+				SPI_BIT(priv, SPI_TCR_SDC) |
+				SPI_BIT(priv, SPI_TCR_SDM),
+				SPI_BIT(priv, SPI_TCR_SDM));
+	}
 
 	return 0;
 }
@@ -516,6 +531,8 @@ static const u32 sun6i_spi_bits[] = {
 	[SPI_TCR_CS_MASK]	= 0x30,
 	[SPI_TCR_CS_MANUAL]	= BIT(6),
 	[SPI_TCR_CS_LEVEL]	= BIT(7),
+	[SPI_TCR_SDC]		= BIT(11),
+	[SPI_TCR_SDM]		= BIT(13),
 	[SPI_TCR_XCH]		= BIT(31),
 	[SPI_FCR_RF_RST]	= BIT(15),
 	[SPI_FCR_TF_RST]	= BIT(31),
@@ -526,6 +543,7 @@ static const struct sun4i_spi_variant sun4i_a10_spi_variant = {
 	.regs			= sun4i_spi_regs,
 	.bits			= sun4i_spi_bits,
 	.fifo_depth		= 64,
+	.has_clk_ctl		= true,
 };
 
 static const struct sun4i_spi_variant sun6i_a31_spi_variant = {
@@ -534,6 +552,7 @@ static const struct sun4i_spi_variant sun6i_a31_spi_variant = {
 	.fifo_depth		= 128,
 	.has_soft_reset		= true,
 	.has_burst_ctl		= true,
+	.has_clk_ctl		= true,
 };
 
 static const struct sun4i_spi_variant sun8i_h3_spi_variant = {
@@ -542,6 +561,15 @@ static const struct sun4i_spi_variant sun8i_h3_spi_variant = {
 	.fifo_depth		= 64,
 	.has_soft_reset		= true,
 	.has_burst_ctl		= true,
+	.has_clk_ctl		= true,
+};
+
+static const struct sun4i_spi_variant sun50i_r329_spi_variant = {
+	.regs			= sun6i_spi_regs,
+	.bits			= sun6i_spi_bits,
+	.fifo_depth		= 64,
+	.has_soft_reset		= true,
+	.has_burst_ctl		= true,
 };
 
 static const struct udevice_id sun4i_spi_ids[] = {
@@ -557,6 +585,10 @@ static const struct udevice_id sun4i_spi_ids[] = {
 	  .compatible = "allwinner,sun8i-h3-spi",
 	  .data = (ulong)&sun8i_h3_spi_variant,
 	},
+	{
+	  .compatible = "allwinner,sun50i-r329-spi",
+	  .data = (ulong)&sun50i_r329_spi_variant,
+	},
 	{ /* sentinel */ }
 };
 
-- 
2.40.1

