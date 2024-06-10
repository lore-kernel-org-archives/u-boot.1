Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5982CC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:18:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB30588576;
	Mon, 10 Jun 2024 03:12:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kLPA4Wsv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B12088551; Mon, 10 Jun 2024 03:12:55 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB87A88489
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6f8d0a1e500so2842130a34.3
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981971; x=1718586771; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2YlLT6dmvIZXH7j0HvrdXolO7Eyi/HU090a4rLJVlIU=;
 b=kLPA4WsvMcyM+MauS2w/y94R+xgRNmkRmwWQY2uP2u30Z0W1+0M2XKFmJm8ZC2d5he
 Pob8ye7J1Dm7DWjI7aqdACqM43xV0oFYA4353pJxb6x/QmKrstXvr//IBaOL6w+FFR4M
 6TY0INs0i7Y6vDMtGWb8sRs5Usgi3xLHsJP7ihSjMtarie9jMQ/4yJZ88XLXHcX5oAya
 KRxmXGquk22UQhszM9HgCSnHWR5yUkkCNZJAKt/84CF3YKMmr7MfiXvIZsRGlMO59vaV
 BfqgM1QT4QNYv2STp7Cg2RcS4yqnZ4tEaBP3feMko5q77byP1KPmHeP2xyf0nf0jNGGC
 KGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981971; x=1718586771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2YlLT6dmvIZXH7j0HvrdXolO7Eyi/HU090a4rLJVlIU=;
 b=lAsvGqViGOQrtvff+EE3ndfvdHDgWCQLayQXcCwG7jnYnekdo+gqr3fqJ46UpMeww4
 G0RRHgYoibr7xl9xQ1s7UCJhnlH+3L6qK6VvkoR1AI7zbAoPAsKypNkdwsK0SRHYPt+/
 54C/8G5ur7WrE6e3jb8Tv4pcWzy+GSSVJBaLRHEtmUJkycpzwubCVB0m46WOFgSIPvRe
 j3b5/HRJjhtiWZDQhn8T35N40NwJv8h1y5seHAcFQJqpVWVpbTyux1DesTA5A37/Ozy+
 nseGXtX+S2L3Q3e96kQY2K2KerAOwfvLqUyYpgcFaSVa8FkzJM4gARhxeGWWoVsp/eRF
 TLPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/1jK4GUbm+YsUL7TjP30Q2Zer+fQMIp59laslNl5+jv7bT6v+suiZ5T2OWOU97VBzoxqKCk3rujtew6KM6qHoWs+Apw==
X-Gm-Message-State: AOJu0YxLIfLjJmKW16+lgncJApi+zCYA6KPmK4zE/yfEohobw6w1lYNv
 ZCHhBnF3HMZdA5Q+1EXVPhSqxKj8jISnv6zzxm8zcuZnQ1xy/IvwfMUVEYPUIGQ=
X-Google-Smtp-Source: AGHT+IHj+0iQfLN9O0vd8HG+aBEvrfzW0vSlCDkxNkrjgEEfBxE2B10whEeMsVIffdJBxlr27ZXpnw==
X-Received: by 2002:a9d:7403:0:b0:6f9:a404:b40e with SMTP id
 46e09a7af769-6f9a404b599mr2625446a34.9.1717981971428; 
 Sun, 09 Jun 2024 18:12:51 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ba9769304bsm1476365eaf.6.2024.06.09.18.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:51 -0700 (PDT)
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
Subject: [PATCH v2 34/40] mmc: exynos_dw_mmc: Pull all init code into probe
 function
Date: Sun,  9 Jun 2024 20:12:20 -0500
Message-Id: <20240610011226.4050-35-semen.protsenko@linaro.org>
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

There is no logical sense to split the initialization code between
multiple functions. Pull both do_dwmci_init() and
exynos_dwmci_core_init() into exynos_dwmmc_probe() to make the code more
simple and obvious.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
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

