Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8B3C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 18:01:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0050388669;
	Mon, 22 Jul 2024 19:58:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ua9nEsEq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66B8F88645; Mon, 22 Jul 2024 19:58:00 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C333F8863B
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:57:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5d5846f799dso420019eaf.3
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671076; x=1722275876; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CGa3gMIJW2chTqaZtwdlvxZx8ygHbDg82FUsQVJNvCE=;
 b=Ua9nEsEqC46fDl7YxABRXmjVCCLgvaykrlMPLmX4Fn9SsK5JdqOnls4Hfm+wNA54k9
 BM8FasqggCpmZv+sB73SxvmhMVAJseutndde3S/yjtmFRbseZkxAvOtwQDW5kkVTKSqW
 ZwsvjD+N5huw/Z0QiqRPL2sh47hpiXZ4+UBMXL0e+V6gW00JDAp1oIhQLK+shiUO/I5f
 UuoBLKAWukmpn1bDZDOH4NxvgE1h/UUmo3FW2N8Yp97USbrBAkswdgho3Pjl0hKF4Zxc
 ICa4viDdQ1TxZHC9kHoi0kThuuUYY3+AsVzn0A9r+fwGScjf9bkvXmjSWvu/RH/cj4SY
 rhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671076; x=1722275876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CGa3gMIJW2chTqaZtwdlvxZx8ygHbDg82FUsQVJNvCE=;
 b=gmOIIiVGqZuzl7hpiRbIB8W7wWV3JTqJHyFZqSuXQK/MqjeOL5k1Bzp1Pv2AFOab+X
 LYrskQW1b8Df/VjXhqFudYeBVm5MRiNilv12SdsMXk16DzjX/+CVxjeCtDJIVZsrKArZ
 GTl+2MxJaER2BqRIVGBKv4+DlE+S48TGItIPDdPA1JZEWn/MDryngjrWMvbqg5Ps+maN
 wUtv2MBVzOY1p31mIO8+RKTKnrtnFDxGCJtsQmX79uEbND8jDCr/qYd3iz8FcPADJv1o
 TsbtpsB2OiAWMqS6Fb51CXMnMMF/R1rY08aTq3WUdreSFRotpCHttuts50Pph9MUB/dR
 Qopw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU976ifyYT4+Ncc8RqPyz37rlCcyf8b/BFF/xO0H7byeYYRSs00EfDf849yUArLQkffhXkD35rFgWdGxvmq54DHseykIg==
X-Gm-Message-State: AOJu0YwoHU9zN281I3dRIV9R/5d5CbMq7sNgbvFSlxb/49uyvRdJL6lp
 GEdD9uUkLb7nbAmgNve07olTpenxZhmjKms50U45fUQxVtPFYFpzzCIgQWtp//I=
X-Google-Smtp-Source: AGHT+IFr2YKf3Y1FlbXI2XRfMnS+y/QX3OYeD0nf2T9CPcKX+msrIHHfZg0SioOayaxmoHrwzpgsnQ==
X-Received: by 2002:a4a:ee83:0:b0:5c4:5cbc:b1b5 with SMTP id
 006d021491bc7-5d564cfc26dmr10181747eaf.0.1721671076451; 
 Mon, 22 Jul 2024 10:57:56 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d55a8042f8sm1411239eaf.8.2024.07.22.10.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:57:56 -0700 (PDT)
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
Subject: [PATCH v3 20/38] mmc: exynos_dw_mmc: Obtain and use CIU clock via CCF
 API
Date: Mon, 22 Jul 2024 12:57:22 -0500
Message-Id: <20240722175740.6985-21-semen.protsenko@linaro.org>
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

