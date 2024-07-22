Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4D8C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 18:03:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0C8288777;
	Mon, 22 Jul 2024 19:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="C6wV+ZRa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6514088754; Mon, 22 Jul 2024 19:58:08 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B69687919
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:58:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3d9da46ca13so2549465b6e.2
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671085; x=1722275885; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uxAqhYxXUfKOKyL9wAYDi0rYpojxZimic7j/BRNYfIw=;
 b=C6wV+ZRa+Qfo595CjxtNwEuDUgym0blBuefYCiC+l0gpUk9nHA1htO9RCs2yPctwVU
 zr+Ll/5UJp4KmkJ7IzYcoMkhYWytskyHoMU6h48ezQayJefhj1k2e1xfjYJXytKxd7br
 fqgcdaR3jeD1HArvER7kjRSVMz4YVuF7YhusKb6IKLWW7KL8Vcvn1jJt1L+2FgLdHjN8
 K80aoH3/RwWcld8j5PEBokVVj0jWx3E8gOloiiBl2rSbp36g9or16KG5mWZcUx7TPQp5
 SJE1WDM1aaXZLY3MFcn/NdiGki7Us5q7Z76Tr95PlHM9++fSzxr1w6gKY+0LHwzllPlD
 /3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671085; x=1722275885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uxAqhYxXUfKOKyL9wAYDi0rYpojxZimic7j/BRNYfIw=;
 b=eJoG67JpZY/oMDiRf/20rdS7r2NoxIwprU/bGRzidQpWl3FKfkxmphqtWfbI/qv3CA
 rzHZ66G+KdDufo6+26HMg2rqpIHxRw9aj0wl7ymwnE2YKPDwymCMCcWcJCFObOzj1Cxw
 S1Glbo6jxcmUcyyjW0x3PWEjzKcuAfFy9txB7iVKXhHt/5gXrvhN0u3aI0JLqyoCGMNw
 pryfa5zpv4oC4qb5Epd7PbMOojIIkSnqkJwPyLX8xUBHv7STligxasnemUsZyb6Onq6o
 AN3F36EyxRSyrKRFdkAI/KlECBCJyCgzuerX8Ax+MR2WT1WQZnZKMW/F/aDi3Pn/MyJ0
 x6yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV17KhVfON0twwTsG8E+wur1OHxdGoTBJdozh1gB+8Lg2UCfPX7EDIyB1NJdjITf2YF0/x+HSNcvCBgPjKNr5m9+l8ngw==
X-Gm-Message-State: AOJu0YwlVh9qqAFDWRkzsIRvx9kGcaW0Ce+JLMOuJIjvG/N+lSPuPk1E
 pwlLnybzGSFPYPkVw+XWf6zwyxvFrEFReZYkSym7t3t0DabAG5bq5UFyeqhrwxs=
X-Google-Smtp-Source: AGHT+IFiVvfsdknYf1ZdsFfCr9kYVwOnK7GI7AgZZjUW0VkcGQeNP7VUhzUwJP3IM6LoQ5+Nov03yw==
X-Received: by 2002:a05:6808:1523:b0:3d9:28e5:5865 with SMTP id
 5614622812f47-3dafd0e9993mr620865b6e.21.1721671084987; 
 Mon, 22 Jul 2024 10:58:04 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dae096bce5sm1621675b6e.7.2024.07.22.10.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:58:04 -0700 (PDT)
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
Subject: [PATCH v3 32/38] mmc: exynos_dw_mmc: Pull all init code into probe
 function
Date: Mon, 22 Jul 2024 12:57:34 -0500
Message-Id: <20240722175740.6985-33-semen.protsenko@linaro.org>
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

There is no logical sense to split the initialization code between
multiple functions. Pull both do_dwmci_init() and
exynos_dwmci_core_init() into exynos_dwmmc_probe() to make the code more
simple and obvious.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
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

