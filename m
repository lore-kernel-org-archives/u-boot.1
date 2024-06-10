Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F01DC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:16:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44BF288535;
	Mon, 10 Jun 2024 03:12:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LCzfGqp/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00624884AA; Mon, 10 Jun 2024 03:12:46 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD79288468
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6f9611fc320so1026303a34.2
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981962; x=1718586762; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FG2Oxenjnbcd30HfuLqSQ1Lz7rLB218tcgxxzpWdkac=;
 b=LCzfGqp/IjfN4BQtrjnxSg6+wxpJfG0UtjXzxZtrGdzaa6BzG8K00zi2X1GyyxmY1S
 vkmTYe+KhzSeI9LcAPnlT22gUcch/9Xyn7MVqNS3BIly7uzjTqoypM/0PKQj/+1P3A6f
 DpYnEfManSwaV0MJTlmMif5HOoiJC8IGiriKQJ37Itd5Ro0Hx9ZRRzBTZNEsISBB/x3n
 9jsc+4YaJLUyV+MlRS0HpXMvQZeUtew0ltdIQLsS29dswBfSXwe5XAov+tbwnIENIu6U
 qUqMnhDMFf0A5Keik9a1WPwtNgWaw0nNWlq9v7toV7ExSCbTTMhTCaThS4b7lKt23a5P
 c50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981962; x=1718586762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FG2Oxenjnbcd30HfuLqSQ1Lz7rLB218tcgxxzpWdkac=;
 b=UWnFQUvVn9gPdh8a7pjpdmUTI1Gv6id8Wk63BU9OYmPCIMxw0sA/e7JHLtPPMQKNwh
 cNBEIA3su+Vso5c+84gsYVaec6CXBltlZkioQqkipzgciRWQLDoTnTEApJi/Gi0Cx5jo
 FkhMefeO5uqV4tQmAV9zUFudzgNzvGKNgW0PKwDwL1B5c+dNzA8MB9dscr0hMUHoHA2S
 wuX75PRyGCi1qlsoVfIoyOxEsMH66TS5B1QE3XTvLaz6pmbvqfyMjO0AehUKFy81iR4d
 ehHzrffIZCtQMuOwCc8c2KfLvfUCwb5/gg31UeKslrurkrH+AVk9rc7xjcRxbSxo4krU
 K5Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+iIyX4tVFEvn5r7NJr29CT8G5oD9AP02Xo4AKsNTbQ7EkskIjozEPRzv1w5WusEJ7CHXK3+aRk2Mu4IZC+84OvtkuFg==
X-Gm-Message-State: AOJu0Yz3oNhCe0M80Y9aUe14vNWFelNlVR8xdCLEaIkCdRmNoKnLoEe6
 sOqU74pzRqJsZZw2s59aaEu4xZx3CuHZvtxOrYJ32YtEfXtOTfbI/VzPrkqWWFo=
X-Google-Smtp-Source: AGHT+IF79kc3fy1HnLRctQym3abuj3YbKoqwr4SICzPS4m1AOjEXV+dGWsTtEz5T9a0OFM93MCbsKw==
X-Received: by 2002:a05:6830:20c1:b0:6f9:8000:53e5 with SMTP id
 46e09a7af769-6f9800064f0mr4728689a34.23.1717981962193; 
 Sun, 09 Jun 2024 18:12:42 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f992005002sm561690a34.42.2024.06.09.18.12.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:41 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v2 21/40] mmc: exynos_dw_mmc: Obtain and use CIU clock via CCF
 API
Date: Sun,  9 Jun 2024 20:12:07 -0500
Message-Id: <20240610011226.4050-22-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610011226.4050-1-semen.protsenko@linaro.org>
References: <20240610011226.4050-1-semen.protsenko@linaro.org>
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
Changes in v2:
  - Replaced CONFIG_IS_ENABLED() with #ifdef

 drivers/mmc/exynos_dw_mmc.c | 87 +++++++++++++++++++++++++++++++++----
 1 file changed, 79 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 2ed8429d0a40..de39a8d7f3c1 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -4,6 +4,7 @@
  * Jaehoon Chung <jh80.chung@samsung.com>
  */
 
+#include <clk.h>
 #include <common.h>
 #include <dwmmc.h>
 #include <fdtdec.h>
@@ -16,6 +17,7 @@
 #include <asm/arch/pinmux.h>
 #include <asm/arch/power.h>
 #include <asm/gpio.h>
+#include <linux/err.h>
 #include <linux/printk.h>
 
 #define	DWMMC_MAX_CH_NUM		4
@@ -39,6 +41,7 @@ struct dwmci_exynos_priv_data {
 #ifdef CONFIG_DM_MMC
 	struct dwmci_host host;
 #endif
+	struct clk clk;
 	u32 sdr_timing;
 };
 
@@ -52,6 +55,61 @@ static struct dwmci_exynos_priv_data *exynos_dwmmc_get_priv(
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
@@ -69,6 +127,7 @@ unsigned int exynos_dwmci_get_clk(struct dwmci_host *host, uint freq)
 {
 	unsigned long sclk;
 	int8_t clk_div;
+	int err;
 
 	/*
 	 * Since SDCLKIN is divided inside controller by the DIVRATIO
@@ -78,7 +137,13 @@ unsigned int exynos_dwmci_get_clk(struct dwmci_host *host, uint freq)
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
@@ -108,19 +173,19 @@ static void exynos_dwmci_board_init(struct dwmci_host *host)
 
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
@@ -231,6 +296,12 @@ static int exynos_dwmmc_probe(struct udevice *dev)
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

