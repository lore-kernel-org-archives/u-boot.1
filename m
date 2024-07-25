Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599BEC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:51:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B71CC887E3;
	Thu, 25 Jul 2024 22:45:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DsRg6ywl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44316886F0; Thu, 25 Jul 2024 22:45:49 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1441088722
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-70936061d0dso201434a34.2
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940345; x=1722545145; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kD77CVfMk1cUO1TrAtNGPeBZuXDZ/fZHKeorr0i7dQY=;
 b=DsRg6ywlRVMi7HRbe8WSxZktz+igo0toTP0w1Cv2g76t6mLJTNt30Wb6U7bsj8sQVx
 QQOxg3GNa2Nf32xcK76dgqZll9Sz2LDhrKjX+Bh1GNrjFGDn9Inzjb3ALCrz98iLU0rv
 UTIID+wtiqrMpsc4qAMWf2POOwLqYzzTPykmZCAjA1LF6/epvstAFM6nuwVa2Ku06KAs
 DuMi1XWDYzYeRixlnfBfhzGBgwEDP93CB92Ud1cBZPzTsOEY7HhpLouHz0D23/8b8kio
 uPKpWG9JmfikjIpnJqki2jDNTL9ZFgSTWXMvSgZcZJVVdU2rjC/rc2Zp8qTp6cByicxC
 aqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940345; x=1722545145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kD77CVfMk1cUO1TrAtNGPeBZuXDZ/fZHKeorr0i7dQY=;
 b=UWfV1WeFsPhVY4o9MhfreqwGauD3LIDkiSC4rO/NlrEiGfCt6ST7gB4cXZwgWhoeoC
 bx7OMgNItVOUP38EKy8s3HZMIzoPiyc5PR1RC+5UA0JAWd6fyam7iMR18DAmqMjs9SP9
 jg/35ByGRCRCMEpIC0uKcRKCnb0k7KNMy1k1HM9Qgip7eRkUHxaDbVFrKluHoJUb9Wi7
 y/MXsMQHgK1OkWr3+VAKDEs6d0nc4D65K37fEGnwfpsoOzLBfBySsDMxtesenFWeCOlQ
 KlPXpbKD9KozozTFf7O0JzPGMGy5xZu76QcFRINPeDNGCE3xOjH+sBln/vy/0NRxmOEU
 oeGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDTPSffpdkqjB5k+Igv4A8cSqoydZUHrOg57AGjik+1Drrf0XeyWl7b1ksJiMZeLCzyVR+O6aoVKlU2IUC3Ct2ByBSaQ==
X-Gm-Message-State: AOJu0YzlXtVymfSln9R87lvHOT1NkuI3ScZEOj0f1ZeBOKh5yQ8Me78Z
 JGtgjFO+tTRjE5hoLJZz4HMJZJESUygeWaf0IacpxmrWrRLvn94dGIxWR6har98=
X-Google-Smtp-Source: AGHT+IE2fjMMyHUeLJft27pvMyqYQW1z93OfAknAbieUSa9QM9XMEaAPAG6N+d56IBmDC0E35W8wMw==
X-Received: by 2002:a05:6830:6217:b0:700:d506:cfe9 with SMTP id
 46e09a7af769-7093223d036mr4184298a34.19.1721940344826; 
 Thu, 25 Jul 2024 13:45:44 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70930729601sm463428a34.40.2024.07.25.13.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:44 -0700 (PDT)
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
Subject: [PATCH v4 32/38] mmc: exynos_dw_mmc: Pull all init code into probe
 function
Date: Thu, 25 Jul 2024 15:45:14 -0500
Message-Id: <20240725204520.18134-33-semen.protsenko@linaro.org>
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

There is no logical sense to split the initialization code between
multiple functions. Pull both do_dwmci_init() and
exynos_dwmci_core_init() into exynos_dwmmc_probe() to make the code more
simple and obvious.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v4:
  - (none)

Changes in v3:
  - (none)

Changes in v2:
  - Replaced CONFIG_IS_ENABLED() with #ifdef

 drivers/mmc/exynos_dw_mmc.c | 86 +++++++++++++++----------------------
 1 file changed, 35 insertions(+), 51 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 29241edf7915..41fb32c579ef 100644
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
-#ifndef CONFIG_DM_MMC
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
-#ifdef CONFIG_CPU_V7A
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
 #ifdef CONFIG_DM_MMC
 static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 {
@@ -345,6 +296,7 @@ static int exynos_dwmmc_probe(struct udevice *dev)
 	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
 	struct dwmci_exynos_priv_data *priv = dev_get_priv(dev);
 	struct dwmci_host *host = &priv->host;
+	unsigned long freq;
 	int err;
 
 #ifndef CONFIG_CPU_V7A
@@ -353,9 +305,41 @@ static int exynos_dwmmc_probe(struct udevice *dev)
 		return err;
 #endif
 
-	err = do_dwmci_init(host);
-	if (err)
+#ifdef CONFIG_CPU_V7A
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
+#ifndef CONFIG_DM_MMC
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

