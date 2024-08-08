Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE181C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 03:21:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE38488C4C;
	Thu,  8 Aug 2024 05:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="C64RPkt2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61BCD88A34; Thu,  8 Aug 2024 05:15:21 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5274F88B6B
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 05:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3db12a2f530so384671b6e.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 20:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723086909; x=1723691709; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8NRQ4QXQbK1CqEg2RUXFUCwBoJYHu+XXTCKoRwHYpXA=;
 b=C64RPkt2gcPXFVJpSm1DoPuFqif/h0MDl48yJI2TiBdSVsZZ3P+mCxzV7/STKZuidg
 C5jAnkTBneUs51S3dsLPw63mkhktoWSnQ2LRqOG2YGsw7S+D6+p1QYBggcHR4z7apRWY
 lc2zmJadptEORfdmEKnPdscK79Zd8plmMa06BM87NgRBVmnQGiHehX695etreGbYhTzH
 Lf5Ws0Ibd8wlR6BsGaZSUOAmN1Peu8DP2EuH/zO7X9zyVAAj6dWB9OjWTxAH/O+NG7Ve
 BzAmOyCgAkAo10vbu91eQIGnVXbPdyu0XMjMhbSxX7atCB7m9GUVXSE/bRlH+rXC82zX
 g2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723086909; x=1723691709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8NRQ4QXQbK1CqEg2RUXFUCwBoJYHu+XXTCKoRwHYpXA=;
 b=YAnxVYVBdDE/ps89m0/0W0Lll1wkgkogvoiwfcSpqljWdMH0sE72ogH3BA6M4NVRGv
 bD2uaA2JkCSFtRZzPgWQKsmaNo9CcrMXpjwf3Xu+xta8aXCSV4qXPTL88w4wSKJ5yTjn
 BgyUHL44MHGd20WNJ1FfABznt0zeQFl+HsEJFmo1t0cZldMVk3PiTSG4TQYdGXIGuAIJ
 xKVPvz5Vw8qh6zP1ktir9Y5oKjYyT1p4RmMC+lkzilpUNs0gUVY3nbC7RNWfc2bqkSKt
 DiRAQKauj8Ns0Pd0xgZejbKFmB4fnOg9yRm3Zk/dwnQc4hKgKxYLxOzm7shKHCOHHC54
 L7Kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVC48gHoFdSMLFgo+qghLdWIJnwSFnzYi7Ct05BipSDHD6yUtuCMgV45uxlh9pR2M6C0ToPLZRnnIxCIj+TptAuCO8+gQ==
X-Gm-Message-State: AOJu0Ywz4ktPteg3gFt4+FEoSZBnSbuHluUspG9w3uzoqNbh98Skuz3P
 mRuiRBigeqI9w8ve8E2F/fvysV43LRR3p9nWUrn3Q556o/BnKC/BpqtcP1yw0tU=
X-Google-Smtp-Source: AGHT+IEXntfZe6bVupcYqTOUwPmKJUpR98hbYrpxarsM9EUPReX3guCOK/7SaaqLG3vBtAGXgFhCNg==
X-Received: by 2002:a05:6870:a450:b0:261:1e3f:777c with SMTP id
 586e51a60fabf-2692b6a4d27mr631960fac.27.1723086908694; 
 Wed, 07 Aug 2024 20:15:08 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2689a2f2269sm4360022fac.14.2024.08.07.20.15.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 20:15:08 -0700 (PDT)
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
Subject: [PATCH v5 32/38] mmc: exynos_dw_mmc: Pull all init code into probe
 function
Date: Wed,  7 Aug 2024 22:14:38 -0500
Message-Id: <20240808031444.9619-33-semen.protsenko@linaro.org>
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

There is no logical sense to split the initialization code between
multiple functions. Pull both do_dwmci_init() and
exynos_dwmci_core_init() into exynos_dwmmc_probe() to make the code more
simple and obvious.

No functional change.

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

