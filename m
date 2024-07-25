Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9ECFC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:49:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DA0988732;
	Thu, 25 Jul 2024 22:45:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lhzV/thR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58E7F882EF; Thu, 25 Jul 2024 22:45:41 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B379885C5
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5d5c2ac3410so72574eaf.2
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940336; x=1722545136; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SDSW/FQ0raQJfa8ItZTqmxPmyzRYX/IJa/0gNS33P20=;
 b=lhzV/thRiNik8TzS7YfKKzr+soLxq0+Jj7HJMyUR7MYyJxPnME+BHFXMGrVvgT8AJY
 ATHpI5bU3IfmmM0c4oGVcSOn2YjBQV9rzVEcqFDnbwDNCTZkdSqM0PH/kMbO+vQQEMQD
 Q84CX7R3O4pr/gGlq/35g7wjPp1dFWjXe4RXwP9DqTCBp3rNIRLAd7yGapE1v78VuDEE
 /fJo09n4IXgJl6Hbx4VfyUPlVXeK44Jgf+by+JvRI7+odG+3KMcQhKJ3YaWO6Svis2mg
 sr5VdiYz3rHlEUFVoC7RQ7ZnEte+xzkIuiWm59YITHZObcNW8r+Xp9bQ27x27qm/fCER
 Z1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940336; x=1722545136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SDSW/FQ0raQJfa8ItZTqmxPmyzRYX/IJa/0gNS33P20=;
 b=V3Of63rrhLUs1MdIhpC3uH31ysGvbuPPxadt9+pjKEIj5NQaFXG2Li8B1CSZLoJtfd
 uxfxpcYtHbsLa7V4TLrqzYS1Do3yRWAQSZTArxkrgbGT7hc56PLfDkg1pKEh+MNsLacU
 CYmB0erdx4/XbzwLWSZOKWy7Ky/AU0ntKUeqWh9T8RUFkf4Ni0Ak2HfWR/UWsgdHIZ7H
 YYmuR6zBs6HmfEQuLBUEwqnVQzF7p2HDhd7SOHB2KP4YwsmiX7FDPREmQdHAKX1Jj9fj
 VePifniPlYuU2pUz2YdWtdymM8+dLIfsfngfsaqwrpM6b8R3oLNICgv2XYLLbfiqCJFs
 7Khw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkPF0ezu9pHw5o52zSRk78NcoRmqnXWefYEvK5tslvz2xpsTRDyH9VoLLo4s4wRmQV83PehUR9jIVdI+o/vmVOfRIH/g==
X-Gm-Message-State: AOJu0YypAqpPJZoziOnP0+DM6VZqkdQChhtn1QuW8o+8vzupR6QMerpz
 +/5oPbOqKrKK9UmVZr4rR3d/UOiCX5VO2S8npX07jFqedukbKwD6AD788zZl6N8=
X-Google-Smtp-Source: AGHT+IEG17c0dGkY0PneEI4vevh0DJbvVy9RbqarzTiBNSDPw3GWtsBg2oF4sV7plcbeb5rMPsSyVQ==
X-Received: by 2002:a4a:ee17:0:b0:5d5:b226:2ffa with SMTP id
 006d021491bc7-5d5b42f7cf8mr4252972eaf.7.1721940336205; 
 Thu, 25 Jul 2024 13:45:36 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d5b346d58csm266472eaf.6.2024.07.25.13.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:35 -0700 (PDT)
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
Subject: [PATCH v4 20/38] mmc: exynos_dw_mmc: Obtain and use CIU clock via CCF
 API
Date: Thu, 25 Jul 2024 15:45:02 -0500
Message-Id: <20240725204520.18134-21-semen.protsenko@linaro.org>
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

