Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDD9C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:35:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64EE8885BC;
	Thu, 23 May 2024 01:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hHEy8Fxc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C145A8858B; Thu, 23 May 2024 01:32:01 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F20188579
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6f0f728d373so3079826a34.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420716; x=1717025516; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RFsfRnBUH6MHVRPiqO9BCsI1LVzb3bn4h8/9D5uegTk=;
 b=hHEy8Fxc+cx2neD10SyAyWZT8902zUhnTf2tr+4GGgf1/5IjMerMZ/XYG7acxtwowA
 bf++/wSAWPktPGj5UFpXzIwjJ27F/t4DMzqWuMoxFvieBUcLqBdQHDrSp4Y5FKouE7fw
 5ruNwOL68dEwhIxMoebubcEE7k4AbQiaHQxbWvqc+a/UpAAba7DFYt+X1iyFxoCKENgT
 EG6/pnPX1p38BYZW6fmELnhVj1GUNT45wTXnrg9myeWvuWwLXoylEKMnztYOsM+f6+i7
 kyKtGD1lFhzuN7DmUVvFtyTwx3DYFR4A85nsTiKNvRzkC/m8w+Ykw9st0uGAWhAsJdOV
 sLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420716; x=1717025516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RFsfRnBUH6MHVRPiqO9BCsI1LVzb3bn4h8/9D5uegTk=;
 b=WFRzSOV5I2Z42ooQwl5tOP9JdK8zKC+Bn6bpVGwWfdPXebKIzsEBcik/5ENIXi45gV
 oEpgB4g++y1f24XtJGklaaZEXhza/7rtA7Ogzwvx3euUUACKrsguWuDpTHE1YKuoKrST
 1oXlsHH59CI0+70n6ecjO1qZDZyYvf//a7yZz9PCP93kydFIrPbvJxfZajeQYLg2DWEe
 s5oougMohveNrah7Zfz3kdzBWf7A+M3df7lQUbBRXMw7JNoBVykrbfrqoZuRa2y7KwoG
 54pi/i+bjYZxmAKqZkufaWcBmX9CT903eZ3mfm03+8VucGVGNm8NuRhn2v5jdqcEpb8O
 35bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUZeOtuYrybTpbBuEci/oCu7M1FaPPVYNvds/iatm13A29eTMewfdOJotWLZsSrg6+sTkJV095s4gAodlquKwSC/gDMA==
X-Gm-Message-State: AOJu0YwcQJy/TIOs0yXZu76b/l0y9Sv8/fTOv26Me9CeBZ4mDq2WmOH9
 FUj0LRyz/VFBRzTTVslNEeV5cVJ6RqeDqH0XJscQaW00Zv9xwLMq960q7Zer8xw=
X-Google-Smtp-Source: AGHT+IEwnqVnq/DrQxacE+ZD7/kHU28td9FXa4W6WWTBRH3hNVMoby7vtFa1IzKKviiEBLT/gMeM9Q==
X-Received: by 2002:a05:6870:d890:b0:24c:50a8:a14b with SMTP id
 586e51a60fabf-24c68a2ee3fmr4065725fac.11.1716420716146; 
 Wed, 22 May 2024 16:31:56 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2412a3c82edsm6675180fac.12.2024.05.22.16.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:31:55 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH 22/42] mmc: exynos_dw_mmc: Obtain and use CIU clock via CCF API
Date: Wed, 22 May 2024 18:31:15 -0500
Message-Id: <20240522233135.26835-23-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240522233135.26835-1-semen.protsenko@linaro.org>
References: <20240522233135.26835-1-semen.protsenko@linaro.org>
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
 drivers/mmc/exynos_dw_mmc.c | 87 +++++++++++++++++++++++++++++++++----
 1 file changed, 79 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 6d0872e0df50..8a3f73e3739c 100644
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
+#if CONFIG_IS_ENABLED(CPU_V7A)
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
+#if CONFIG_IS_ENABLED(CPU_V7A)
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
 
+#if !CONFIG_IS_ENABLED(CPU_V7A)
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

