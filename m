Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CFBC25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:38:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D41B888B7;
	Thu, 23 May 2024 01:32:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tYhm4UnK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 247A28858E; Thu, 23 May 2024 01:32:13 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B284D88589
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:32:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6ed3587b93bso3929517a34.1
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420726; x=1717025526; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tNm3zxNnxTGzaQjFGzkTXRPolvlW1D8U3GEIccFIC28=;
 b=tYhm4UnKMVW4/XDsvCw2mGSmILzJTj3KWXELEHhMNRSVlzZlmJx95KemrJ3n+l+0Af
 k/QFBbo0QZvAplhgzzlxbjFdu07V/JNPY6KdWNm6ZSex41duiAAZ9AiHO9CwZ5rE9V/j
 YRLKHrAAbFMeEQc5NLmYlvcyu0jAKTpNLaI0OUM1A9djkKchlm/wKdpNCd/dMW5PVDcr
 FGjyavPIdA0hCWsav0sNogN6tze0fw+7d07Q7tVSd/e9dRvwH6HAvMQuv2VWsvRw7F5o
 9wrg/8BW9ZTnCKeURldngKgFSNnKvCeUaQi13G0rBleOrWx68Ga6fUfi9E2l5I68YNSH
 8btA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420726; x=1717025526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tNm3zxNnxTGzaQjFGzkTXRPolvlW1D8U3GEIccFIC28=;
 b=uRpzE2MWuh+XH0pyO/EhgvwarzG8LolKBB/mSxMrAnAqFIaHuALFZRbOdc+Ssdk68R
 4FFQAmk2Q0+w7GlNN8fidPJebedYx/Z9X3hyVUwf/aASmqeSJ0JTuZ4gNXfMqGf3W9mj
 j/BOvo9Hj1+FY5UyBhGb7sIUMVHVCgtA6MoNGpYppMara7WDDtpsy2+w1MewCsoEMs0b
 2nRP8NQmdA884mzX8DjnEkhDcZABfk8aov4QOdfZAg05JlQCAwL6eFovn1J/keTuEUnU
 LItq7t4prABUnuNPh6Rgnh0irrVR/LyrwPYaak2Cu4NR2ooethKMPzpCzoKyVyKZulPk
 PEeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1iZG5g5kYH9PlzgIH+LSeJxqEYM5n1LezEo4S5/bfwJPVmrWLQVl4HCRIQzA9qwfVkraep7MbgGj978HUEhKtnfDChQ==
X-Gm-Message-State: AOJu0Yy8s0XCPimtXySXLxWo4B5PUD2T2VPDgy9ZrAfbw4cgedTAlgmQ
 HxsaygS+pqbARcRW3KQ0RsYLZOJU6fXzx1b7lZV5CuvDwMkYDxIqXoinMvAB842pJniGqmrU+FP
 Yl+A=
X-Google-Smtp-Source: AGHT+IGlbmrpw9xrqde2Nt0q/ECdlml4G21mpHz/B5+lqzzvs4B2xPmpfSEBsLroPI5wdREGSa3usw==
X-Received: by 2002:a9d:6313:0:b0:6ee:4039:8412 with SMTP id
 46e09a7af769-6f6699127c7mr3352642a34.33.1716420726473; 
 Wed, 22 May 2024 16:32:06 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f0ff995ccdsm4165473a34.34.2024.05.22.16.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:32:06 -0700 (PDT)
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
Subject: [PATCH 36/42] mmc: exynos_dw_mmc: Pull all init code into probe
 function
Date: Wed, 22 May 2024 18:31:29 -0500
Message-Id: <20240522233135.26835-37-semen.protsenko@linaro.org>
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

There is no logical sense to split the initialization code between
multiple functions. Pull both do_dwmci_init() and
exynos_dwmci_core_init() into exynos_dwmmc_probe() to make the code more
simple and obvious.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/exynos_dw_mmc.c | 86 +++++++++++++++----------------------
 1 file changed, 35 insertions(+), 51 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index b7c3b356f0ac..19793e7ad460 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -209,55 +209,6 @@ static void exynos_dwmci_board_init(struct dwmci_host *host)
 		exynos_dwmci_clksel(host);
 }
 
-static int exynos_dwmci_core_init(struct dwmci_host *host)
-{
-	unsigned long freq;
-	int err;
-
-	if (host->bus_hz)
-		freq = host->bus_hz;
-	else
-		freq = DWMMC_MAX_FREQ;
-
-	err = exynos_dwmmc_set_sclk(host, freq);
-	if (err) {
-		printf("DWMMC%d: failed to set clock rate on probe (%d); "
-		       "continue anyway\n", host->dev_index, err);
-	}
-
-	host->name = "EXYNOS DWMMC";
-	host->board_init = exynos_dwmci_board_init;
-	host->caps = MMC_MODE_DDR_52MHz;
-	host->clksel = exynos_dwmci_clksel;
-	host->get_mmc_clk = exynos_dwmci_get_clk;
-
-#if !CONFIG_IS_ENABLED(DM_MMC)
-	/* Add the mmc channel to be registered with mmc core */
-	if (add_dwmci(host, DWMMC_MAX_FREQ, DWMMC_MIN_FREQ)) {
-		printf("DWMMC%d registration failed\n", host->dev_index);
-		return -1;
-	}
-#endif
-
-	return 0;
-}
-
-static int do_dwmci_init(struct dwmci_host *host)
-{
-#if CONFIG_IS_ENABLED(CPU_V7A)
-	int flag, err;
-
-	flag = host->buswidth == 8 ? PINMUX_FLAG_8BIT_MODE : PINMUX_FLAG_NONE;
-	err = exynos_pinmux_config(host->dev_id, flag);
-	if (err) {
-		printf("DWMMC%d not configure\n", host->dev_index);
-		return err;
-	}
-#endif
-
-	return exynos_dwmci_core_init(host);
-}
-
 static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 {
 	struct dwmci_exynos_priv_data *priv = dev_get_priv(dev);
@@ -345,6 +296,7 @@ static int exynos_dwmmc_probe(struct udevice *dev)
 	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
 	struct dwmci_exynos_priv_data *priv = dev_get_priv(dev);
 	struct dwmci_host *host = &priv->host;
+	unsigned long freq;
 	int err;
 
 #if !CONFIG_IS_ENABLED(CPU_V7A)
@@ -353,9 +305,41 @@ static int exynos_dwmmc_probe(struct udevice *dev)
 		return err;
 #endif
 
-	err = do_dwmci_init(host);
-	if (err)
+#if CONFIG_IS_ENABLED(CPU_V7A)
+	int flag;
+
+	flag = host->buswidth == 8 ? PINMUX_FLAG_8BIT_MODE : PINMUX_FLAG_NONE;
+	err = exynos_pinmux_config(host->dev_id, flag);
+	if (err) {
+		printf("DWMMC%d not configure\n", host->dev_index);
 		return err;
+	}
+#endif
+
+	if (host->bus_hz)
+		freq = host->bus_hz;
+	else
+		freq = DWMMC_MAX_FREQ;
+
+	err = exynos_dwmmc_set_sclk(host, freq);
+	if (err) {
+		printf("DWMMC%d: failed to set clock rate on probe (%d); "
+		       "continue anyway\n", host->dev_index, err);
+	}
+
+	host->name = "EXYNOS DWMMC";
+	host->board_init = exynos_dwmci_board_init;
+	host->caps = MMC_MODE_DDR_52MHz;
+	host->clksel = exynos_dwmci_clksel;
+	host->get_mmc_clk = exynos_dwmci_get_clk;
+
+#if !CONFIG_IS_ENABLED(DM_MMC)
+	/* Add the mmc channel to be registered with mmc core */
+	if (add_dwmci(host, DWMMC_MAX_FREQ, DWMMC_MIN_FREQ)) {
+		printf("DWMMC%d registration failed\n", host->dev_index);
+		return -1;
+	}
+#endif
 
 	dwmci_setup_cfg(&plat->cfg, host, DWMMC_MAX_FREQ, DWMMC_MIN_FREQ);
 	host->mmc = &plat->mmc;
-- 
2.39.2

