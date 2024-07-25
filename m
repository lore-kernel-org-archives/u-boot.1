Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D004EC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:49:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5132688792;
	Thu, 25 Jul 2024 22:45:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="abqXxXCL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97AB5885CF; Thu, 25 Jul 2024 22:45:42 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72EDE88570
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3db145c8010so178589b6e.3
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940339; x=1722545139; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ZFPb823dbyYcmoeeDpUw9xWqzzl5NwxCUroELGCpog=;
 b=abqXxXCL54RI3MTOP1kK2zbKNHroz5jyvbbMrCxtSEOt4Rnsbx36dhX7vrrTGBgdCm
 tvSWRUwglPMyIM1vkhiucKR4bPE48jjPK2lQHGAZlS3sMbUsObJJppfoJ8DWq2JANKRT
 l6/oLR3eisAsEsLPcpm0SSxbisRprpBmlBa2G2cYuW/w3+ulEbYxglBV4y862olgEkkb
 uZmBTAdMLJOwD8L+zz95vYkOiuUAnTsqTyVVlSIX2DV5kG6sFVK1S/SgjSSFUBJ0Km17
 aCjH+/mVmYDxXqqShD1cQ8FSv42ANGyBJq/Vk4CSUITg682webjxXI9PBnNU03u5bguj
 J+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940339; x=1722545139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9ZFPb823dbyYcmoeeDpUw9xWqzzl5NwxCUroELGCpog=;
 b=TgNbuKTqSu5BpqrUJXlm+BaFJO0VPSawDCUrNrlS3BMhH5Qj1jFVl86f5xRw0gfiDs
 pXUw/5bIznklf1zHIhyeL6njRW284cQmgwzUE8ETjiOSjtXVlSDSA871uP1Ol8vGY6JH
 bCxT7+ysIhPdRIRGJS2ckDuAfkuaHNGLRX2w4JkDNdnU7ma2qy2tw7sogM3XO+fV9LuW
 txS6UNwRBFb5ikaKHkA+G7Uxrbql9KABjVcPBacoLJtD+zlWKoQ6++ON1u3e1RmFjsL8
 gLLPHbToeaIeQh3Dh43J4UIGq85K/tM+wodQKSAEQny7nqsuL22/69KGE5TwaTDIQf2J
 TUeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVReB4qex/rmWm8cSTj9qS1IUaXjKrJrwsL8GN8UExoxfTN7teB6vgvLePzhnW+Y4WC/KZ9XlmdNBbfPxWh0OR5GXQPkg==
X-Gm-Message-State: AOJu0YwskXpe5KY0uj9h6WQbuYcXkdTiXfGAC7JeNSUzjgRSsaucpYjQ
 Kn+L93sB3v7ueBz6X/5Ak1BHtMtg6bfOpxVAicEswC2Wszqma4oLskNcmZO53Uk=
X-Google-Smtp-Source: AGHT+IGHMzqFUOVSAEkNLZjP3fvhfdRiYukIGbRBPS8I6LqZ/E7f6hWdvM5Ch7+1zGgm5tEsBtNkxg==
X-Received: by 2002:a05:6808:14c7:b0:3d9:ad9d:622f with SMTP id
 5614622812f47-3db14125766mr2973491b6e.27.1721940339193; 
 Thu, 25 Jul 2024 13:45:39 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db1357a2casm426513b6e.56.2024.07.25.13.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:38 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Minkyu Kang <promsoft@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v4 24/38] mmc: exynos_dw_mmc: Abstract CLKSEL register
Date: Thu, 25 Jul 2024 15:45:06 -0500
Message-Id: <20240725204520.18134-25-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240725204520.18134-1-semen.protsenko@linaro.org>
References: <20240725204520.18134-1-semen.protsenko@linaro.org>
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
Changes in v4:
  - (none)

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

