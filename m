Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEDBC3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 03:18:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 186CF88BAB;
	Thu,  8 Aug 2024 05:15:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bI4gKXgl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E71AE88B0E; Thu,  8 Aug 2024 05:15:04 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42B968873C
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 05:15:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-260e1b5576aso381867fac.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 20:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723086899; x=1723691699; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ukmMu5LRhdgC+46ZyoYi+TUcr7hLYbVhOVtZ/x46Yl4=;
 b=bI4gKXglinr7HejNoIP4C1ZFc+CgLBJ3vGmB0dZ4jOZ2HwaD9e7rXAGlRqod7IkzyZ
 bIKdmnx8CPe0NG2u0Mt4hDRyHsIEDEQh0q6unV5YH2Wlu+SqNks6BfNU5JI31T4QufNk
 5kV4FrEJoI7LFuw+nmMStZmK0+jkdBQq4HLteWdu6fVarNrGgMqVeA5XXBkElQCGcsfh
 HaW8CJi5TXxYVIsHQAWdwtd1rpszSs3M22iWCbHDWz4r5obJh9T9Y7e9P261c1NvA/GA
 Vafe42lJCcQzNwWYOblNGJ1b/npvCZLE5sfkJ3IcKqWuTAIJwULUh8B5k7pdZIufBaOe
 aoyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723086899; x=1723691699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ukmMu5LRhdgC+46ZyoYi+TUcr7hLYbVhOVtZ/x46Yl4=;
 b=FTyY9Aspg3TY2CzMiHaYuNUamwEM99vp0TUPjo4WYTwRZO7Fad2WGGjVkRrbfKFpqM
 LRWCMtbatuRC0NJLPJGI7zgVUHi1yfGIzze4PSsYHWO520SVu0YZCaliYa04bl4nfhDa
 M9yZ6Ac+FsGxgza3Q+tnOACnaiSwTL7NvtTDh0pOuC2kM6UxI4WGsI1z+JRa+TB648zT
 UQDanTWnAV05/+fnrZJdErFEPBmRJlwuXF4Gw+v978+FoRhKJ7Qc9qxb8dMEWGu0KYbm
 YzkifqM0XiGOC54PFq8ctcOFETxlvezHEFLrh4UZsd85aUqfD303WlAskgV47nKPSA0A
 yukw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+lURhMI+L79xPyUpF8vQ8vKbh8GWlf9Gos05ZE0ky4ep2VB9KcmeQrJbxlgiC/rvr/BpNy/g=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+uj7L5sm9qZ4JB69oZI7cXqY5nVPscHV4ew9nvaxFIA+1tEej
 15GgEsbaYM/QXhFwdfmwRtGNY7vL0ksNCs2Y9YUO/iPjDthZDpOFOSFRvzUzaVs=
X-Google-Smtp-Source: AGHT+IGHcsEYreDi4VomKclO6qFuMwHHYgfrcgwty+BJacmaIqkJ8f2EhAbTq/VHAQ0PcGSBPW8xFw==
X-Received: by 2002:a05:6870:d88c:b0:261:7b0:9d66 with SMTP id
 586e51a60fabf-2692b82466bmr635063fac.50.1723086899521; 
 Wed, 07 Aug 2024 20:14:59 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2689a2a4cb8sm4336743fac.3.2024.08.07.20.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 20:14:59 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <promsoft@gmail.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Henrik Grimler <henrik@grimler.se>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v5 20/38] mmc: exynos_dw_mmc: Obtain and use CIU clock via CCF
 API
Date: Wed,  7 Aug 2024 22:14:26 -0500
Message-Id: <20240808031444.9619-21-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240808031444.9619-1-semen.protsenko@linaro.org>
References: <20240808031444.9619-1-semen.protsenko@linaro.org>
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

New Exynos chips should implement clock drivers using CCF framework. In
that case corresponding CCF functions can be used to get/set the clock
rates. Moreover, already existing get_mmc_clk() and set_mmc_clk() calls
are only implemented for CONFIG_CPU_V7A (i.e. ARM32 chips). In case of
ARM64 chips that config option is not defined, so build will crash on
linking stage, with errors like these:

    ld: drivers/mmc/exynos_dw_mmc.o:
      in function `exynos_dwmci_get_sclk':
      undefined reference to `get_mmc_clk'
    ld: drivers/mmc/exynos_dw_mmc.o:
      in function `exynos_dwmci_set_sclk':
      undefined reference to `set_mmc_clk'

Fix that issue by using CCF clocks API on ARM64 platforms for getting
and setting the source clock (sclk = SDCLKIN = CIU) rate. To implement
this, first extract the existing ARM32 clock control code into helper
functions with more generic signatures to abstract getting/setting the
sclk rate. Then add CCF clock support to those functions for ARM64
platforms.

Fixes: a082a2dde061 ("EXYNOS5: DWMMC: Added FDT support for DWMMC")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v5:
  - (none)

Changes in v4:
  - (none)

Changes in v3:
  - (none)

Changes in v2:
  - Replaced CONFIG_IS_ENABLED() with #ifdef

 drivers/mmc/exynos_dw_mmc.c | 87 +++++++++++++++++++++++++++++++++----
 1 file changed, 79 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index ed2752391603..4d28ede0d756 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -4,6 +4,7 @@
  * Jaehoon Chung <jh80.chung@samsung.com>
  */
 
+#include <clk.h>
 #include <dwmmc.h>
 #include <fdtdec.h>
 #include <asm/global_data.h>
@@ -15,6 +16,7 @@
 #include <asm/arch/pinmux.h>
 #include <asm/arch/power.h>
 #include <asm/gpio.h>
+#include <linux/err.h>
 #include <linux/printk.h>
 
 #define	DWMMC_MAX_CH_NUM		4
@@ -38,6 +40,7 @@ struct dwmci_exynos_priv_data {
 #ifdef CONFIG_DM_MMC
 	struct dwmci_host host;
 #endif
+	struct clk clk;
 	u32 sdr_timing;
 };
 
@@ -51,6 +54,61 @@ static struct dwmci_exynos_priv_data *exynos_dwmmc_get_priv(
 #endif
 }
 
+/**
+ * exynos_dwmmc_get_sclk - Get source clock (SDCLKIN) rate
+ * @host: MMC controller object
+ * @rate: Will contain clock rate, Hz
+ *
+ * Return: 0 on success or negative value on error
+ */
+static int exynos_dwmmc_get_sclk(struct dwmci_host *host, unsigned long *rate)
+{
+#ifdef CONFIG_CPU_V7A
+	*rate = get_mmc_clk(host->dev_index);
+#else
+	struct dwmci_exynos_priv_data *priv = exynos_dwmmc_get_priv(host);
+
+	*rate = clk_get_rate(&priv->clk);
+#endif
+
+	if (IS_ERR_VALUE(*rate))
+		return *rate;
+
+	return 0;
+}
+
+/**
+ * exynos_dwmmc_set_sclk - Set source clock (SDCLKIN) rate
+ * @host: MMC controller object
+ * @rate: Desired clock rate, Hz
+ *
+ * Return: 0 on success or negative value on error
+ */
+static int exynos_dwmmc_set_sclk(struct dwmci_host *host, unsigned long rate)
+{
+	int err;
+
+#ifdef CONFIG_CPU_V7A
+	unsigned long sclk;
+	unsigned int div;
+
+	err = exynos_dwmmc_get_sclk(host, &sclk);
+	if (err)
+		return err;
+
+	div = DIV_ROUND_UP(sclk, rate);
+	set_mmc_clk(host->dev_index, div);
+#else
+	struct dwmci_exynos_priv_data *priv = exynos_dwmmc_get_priv(host);
+
+	err = clk_set_rate(&priv->clk, rate);
+	if (err < 0)
+		return err;
+#endif
+
+	return 0;
+}
+
 /*
  * Function used as callback function to initialise the
  * CLKSEL register for every mmc channel.
@@ -68,6 +126,7 @@ unsigned int exynos_dwmci_get_clk(struct dwmci_host *host, uint freq)
 {
 	unsigned long sclk;
 	int8_t clk_div;
+	int err;
 
 	/*
 	 * Since SDCLKIN is divided inside controller by the DIVRATIO
@@ -77,7 +136,13 @@ unsigned int exynos_dwmci_get_clk(struct dwmci_host *host, uint freq)
 	 */
 	clk_div = ((dwmci_readl(host, DWMCI_CLKSEL) >> DWMCI_DIVRATIO_BIT)
 			& DWMCI_DIVRATIO_MASK) + 1;
-	sclk = get_mmc_clk(host->dev_index);
+
+	err = exynos_dwmmc_get_sclk(host, &sclk);
+	if (err) {
+		printf("DWMMC%d: failed to get clock rate (%d)\n",
+		       host->dev_index, err);
+		return 0;
+	}
 
 	/*
 	 * Assume to know divider value.
@@ -107,19 +172,19 @@ static void exynos_dwmci_board_init(struct dwmci_host *host)
 
 static int exynos_dwmci_core_init(struct dwmci_host *host)
 {
-	unsigned int div;
-	unsigned long freq, sclk;
+	unsigned long freq;
+	int err;
 
 	if (host->bus_hz)
 		freq = host->bus_hz;
 	else
 		freq = DWMMC_MAX_FREQ;
 
-	/* request mmc clock vlaue of 52MHz.  */
-	sclk = get_mmc_clk(host->dev_index);
-	div = DIV_ROUND_UP(sclk, freq);
-	/* set the clock divisor for mmc */
-	set_mmc_clk(host->dev_index, div);
+	err = exynos_dwmmc_set_sclk(host, freq);
+	if (err) {
+		printf("DWMMC%d: failed to set clock rate on probe (%d); "
+		       "continue anyway\n", host->dev_index, err);
+	}
 
 	host->name = "EXYNOS DWMMC";
 #ifdef CONFIG_EXYNOS5420
@@ -230,6 +295,12 @@ static int exynos_dwmmc_probe(struct udevice *dev)
 	struct dwmci_host *host = &priv->host;
 	int err;
 
+#ifndef CONFIG_CPU_V7A
+	err = clk_get_by_index(dev, 1, &priv->clk); /* ciu */
+	if (err)
+		return err;
+#endif
+
 	err = exynos_dwmci_get_config(dev, gd->fdt_blob, dev_of_offset(dev),
 				      host, priv);
 	if (err)
-- 
2.39.2

