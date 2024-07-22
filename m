Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81586C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 18:02:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73E5888708;
	Mon, 22 Jul 2024 19:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qmtMmwZK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 072D788645; Mon, 22 Jul 2024 19:58:04 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CD598863B
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:58:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-70446231242so2335096a34.1
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671079; x=1722275879; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q6u5JOlmgfqULKcBSJqc1nSNBcsqabkbx6MNcU825Oc=;
 b=qmtMmwZKEei+Lyn5ys5VMujHWIKRaEz5DyqHoBOgvl7wX4K9DHA2TQAkzx2k0Sacdr
 pPym4pY+Ado0aFPCqBhl2jLpChHAMoHuYIfbzg5ikixcvRhYtPrWJqWF0tQpdeyzaHpD
 O3vZCg4o7cXWgzWXu+/BI0TacWMF5LHkc2nIZ5tpD+V7Zy7Tdi0Pm7EJv3nLbNUCtXrv
 TggeGM6a+wQzohWJ0LlGK/NZiAje2nYitYdj4d+xdZCfFM17g+Ckgv2XUD18BtwRjYHs
 hTwcq+QbNBLW18IMUjHvNplfxNCohNW31V+E6sEXlaPHgGx+27HNoF3jZmMl1jfwbo+p
 K33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671079; x=1722275879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q6u5JOlmgfqULKcBSJqc1nSNBcsqabkbx6MNcU825Oc=;
 b=s1RXj9OfFQxzqmOW36eIZsiGHFzR5neodk0lH+z+/IcCS5udhgWoqNmXqKkZW1FSOr
 HEmllW81IqSurXLxQWnvKuaN8+YssBKkDATrSRJHBAvxvuaCU9qN3vZGXlUtp83laNgF
 TtVu09TIwFcTqbqRLzYXsowEcBr3kdj+a6GSJlNmvmFXjlDSt7isaCNLGVkJubFVbjmT
 SPUwdA0/Z3XJbeM7RlpkZGl9ZU1u8d1/zZQIZDdMh+8vzwhU6zj0CIcyMLMFKJ7yV2bD
 x8rHJzoXDKGuRghvPn/uwuyfP7hHALY+xthjGG3g11I2tUAoygCXf8hjNoA9jnymxRzK
 yikA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUISMFE0pANvqPsYqKkfh5E8mqRdUK2KdGVZysH79LfjT2FW500MNjnAj1xYHc93IIECN/pmr2wUH8DsJkIGmS/Osi0Vg==
X-Gm-Message-State: AOJu0YyBW36v929m5GMSbOIgzfzehqayYmtwZz5RTW3PXHIwvWfrLJ/b
 81n8TJ6Np1wWhQypGsEWzaOJKPsDzW5pi8Av6FblDsgWhHbS58Mjl4qSdtQ/R+k=
X-Google-Smtp-Source: AGHT+IG7/kwMsSb+cY5SpzcAPWUUeYuqgc55rBhWdF4yHYi+iKQ4q2pKagKn8ed3GQAqNH4l1h71SA==
X-Received: by 2002:a05:6830:2712:b0:703:7777:244f with SMTP id
 46e09a7af769-70918099151mr748375a34.2.1721671079189; 
 Mon, 22 Jul 2024 10:57:59 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f61b2212sm1622113a34.81.2024.07.22.10.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:57:58 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>,
	Minkyu Kang <promsoft@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v3 24/38] mmc: exynos_dw_mmc: Abstract CLKSEL register
Date: Mon, 22 Jul 2024 12:57:26 -0500
Message-Id: <20240722175740.6985-25-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722175740.6985-1-semen.protsenko@linaro.org>
References: <20240722175740.6985-1-semen.protsenko@linaro.org>
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

CLKSEL register offset may vary between different Exynos chips, e.g. on
ARM64 vs ARM32 chips. Provide a way to specify its offset value for each
compatible instead of hard-coding its value in read/write calls.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - (none)

Changes in v2:
  - (none)

 drivers/mmc/exynos_dw_mmc.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 4108af47e518..fd2ced3d711d 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -33,6 +33,11 @@ struct exynos_mmc_plat {
 };
 #endif
 
+/* Chip specific data */
+struct exynos_dwmmc_variant {
+	u32 clksel;		/* CLKSEL register offset */
+};
+
 /* Exynos implmentation specific drver private data */
 struct dwmci_exynos_priv_data {
 #ifdef CONFIG_DM_MMC
@@ -40,6 +45,7 @@ struct dwmci_exynos_priv_data {
 #endif
 	struct clk clk;
 	u32 sdr_timing;
+	const struct exynos_dwmmc_variant *chip;
 };
 
 static struct dwmci_exynos_priv_data *exynos_dwmmc_get_priv(
@@ -115,13 +121,14 @@ static int exynos_dwmci_clksel(struct dwmci_host *host)
 {
 	struct dwmci_exynos_priv_data *priv = exynos_dwmmc_get_priv(host);
 
-	dwmci_writel(host, DWMCI_CLKSEL, priv->sdr_timing);
+	dwmci_writel(host, priv->chip->clksel, priv->sdr_timing);
 
 	return 0;
 }
 
 unsigned int exynos_dwmci_get_clk(struct dwmci_host *host, uint freq)
 {
+	struct dwmci_exynos_priv_data *priv = exynos_dwmmc_get_priv(host);
 	unsigned long sclk;
 	int8_t clk_div;
 	int err;
@@ -132,7 +139,7 @@ unsigned int exynos_dwmci_get_clk(struct dwmci_host *host, uint freq)
 	 * clock value to calculate the CLKDIV value.
 	 * as per user manual:cclk_in = SDCLKIN / (DIVRATIO + 1)
 	 */
-	clk_div = ((dwmci_readl(host, DWMCI_CLKSEL) >> DWMCI_DIVRATIO_BIT)
+	clk_div = ((dwmci_readl(host, priv->chip->clksel) >> DWMCI_DIVRATIO_BIT)
 			& DWMCI_DIVRATIO_MASK) + 1;
 
 	err = exynos_dwmmc_get_sclk(host, &sclk);
@@ -229,6 +236,8 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 	int err = 0;
 	u32 div, timing[2];
 
+	priv->chip = (struct exynos_dwmmc_variant *)dev_get_driver_data(dev);
+
 #ifdef CONFIG_CPU_V7A
 	const void *blob = gd->fdt_blob;
 	int node = dev_of_offset(dev);
@@ -322,9 +331,22 @@ static int exynos_dwmmc_bind(struct udevice *dev)
 	return dwmci_bind(dev, &plat->mmc, &plat->cfg);
 }
 
+static const struct exynos_dwmmc_variant exynos4_drv_data = {
+	.clksel	= DWMCI_CLKSEL,
+};
+
+static const struct exynos_dwmmc_variant exynos5_drv_data = {
+	.clksel	= DWMCI_CLKSEL,
+};
+
 static const struct udevice_id exynos_dwmmc_ids[] = {
-	{ .compatible = "samsung,exynos4412-dw-mshc" },
-	{ .compatible = "samsung,exynos-dwmmc" },
+	{
+		.compatible	= "samsung,exynos4412-dw-mshc",
+		.data		= (ulong)&exynos4_drv_data,
+	}, {
+		.compatible	= "samsung,exynos-dwmmc",
+		.data		= (ulong)&exynos5_drv_data,
+	},
 	{ }
 };
 
-- 
2.39.2

