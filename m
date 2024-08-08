Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3988C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 03:20:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6825088B99;
	Thu,  8 Aug 2024 05:15:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JLLYAjm4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A83E88C06; Thu,  8 Aug 2024 05:15:20 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CA8388C15
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 05:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-70943713472so208175a34.2
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 20:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723086909; x=1723691709; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m4DMU5JktK+PKeTe51YJVJuuv8p8NLdnwCctV/VHPMo=;
 b=JLLYAjm44UrhvVj+S8skfR0o671Mad+ySLPF09H/zwyAiqZKOzy23u8I8C+XNWhf4t
 iANtnewzoHzZduubZH6NuUaU4+oAXJkZaqqEugWUrWirY1pHOE/9X8Wz1b5TR82BqYUE
 tNia6FmMxT/wEoqdXV+HJFQWcYg+5+wvtxmaRvpSTXmD8KddW6ye2RgwCY6A4kY5JCvb
 nk9crbfsFYoh93j+59L3hEPp79PjvBWQ+E4gWV0271Tjl4DsncWnhyLpHBRbWmKW0kCL
 8StE68v7QATUXV77UWRkPUJDHOF0dfT46wdVnVkeTFeEP7gz1kKjO1QphE6hfTpX/jqf
 Z0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723086909; x=1723691709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m4DMU5JktK+PKeTe51YJVJuuv8p8NLdnwCctV/VHPMo=;
 b=ei3gkmx/JD/831LtbCC+4m636bGF5v0ycAo/RcWPTLg/geckyIq6o5RX5H3Y7upfZH
 vKIkxbuyibYXwya3ZqzjV25L58hCTe+6HmfA82N7XM6Lxz23LVRmxvEYNtnRGCdPxB0d
 kMPPnLpBWyuRSLQmOQ+rvI4TH7syvYi9Zn2GDwbyEorCZtK13b/IBvwqlz1lPurPsTQI
 5FaGaJihT51ZAwk/lf4SnsxRGjIfKG8u81hoqaTASbzZJLShFT5kog/m3Oyb/nFhvLuC
 N6nRvAYVTpM3D9VtbCR29aECHNwt0jNrvCPJPv+a0wH+YqsFMrJWbJ7uxyhVQDSlwZna
 pnUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDiD9rTLkqWC/tg+2yM6m8IeIvT++sY3l6NrCE1+3z/zUSMXx0Fg+WBeoarucST67dPwX54Ye2evoniqPaBpBh3UoD+Q==
X-Gm-Message-State: AOJu0YxOEk7TZ04lbfcb2rhsUhS/gwEJ0+j3JSYKgHGznanOBhZ3gJJh
 xAG1ymfPNqdGDm0+W76sUjC5gwClSnxILDQ5iCEsbyT1CujCRFKCBoKQOsJW5s8=
X-Google-Smtp-Source: AGHT+IHg/GOnxuMCQatdJAe7QnkG6nWB4G5PJNiZS1VrHxMlYM1Eia8ZONLCQJwjYX06ONgwMbMDKQ==
X-Received: by 2002:a05:6830:6301:b0:703:6ca6:27 with SMTP id
 46e09a7af769-70b4fc493cdmr996833a34.16.1723086909437; 
 Wed, 07 Aug 2024 20:15:09 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70a31eaf6d6sm5127661a34.30.2024.08.07.20.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 20:15:09 -0700 (PDT)
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
Subject: [PATCH v5 33/38] mmc: exynos_dw_mmc: Don't call dwmci_setup_cfg()
 after add_dwmci()
Date: Wed,  7 Aug 2024 22:14:39 -0500
Message-Id: <20240808031444.9619-34-semen.protsenko@linaro.org>
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

add_dwmci() is already calling dwmci_setup_cfg() internally, there is no
needed to call dwmci_setup_cfg() again in case when add_dwmci() is used
(for non-DM cases). Fix it by calling dwmci_setup_cfg() only in DM
cases, when add_dwmci() wasn't called. Also, this assignment:

    host->mmc = &plat->mmc;

is wrong in non-DM case when add_dwmci() was called, as it's creating
mmc object internally. Fix that by pulling that assignment into DM case,
when add_dwmci() isn't called.

While at it, add also this missing assignment:

    host->mmc->dev = dev;

Fixes: 3537ee879e04 ("mmc: exynos_dw_mmc: support the Driver mode for Exynos")
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

 drivers/mmc/exynos_dw_mmc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 41fb32c579ef..43111b749a6b 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -333,19 +333,21 @@ static int exynos_dwmmc_probe(struct udevice *dev)
 	host->clksel = exynos_dwmci_clksel;
 	host->get_mmc_clk = exynos_dwmci_get_clk;
 
-#ifndef CONFIG_DM_MMC
-	/* Add the mmc channel to be registered with mmc core */
-	if (add_dwmci(host, DWMMC_MAX_FREQ, DWMMC_MIN_FREQ)) {
+#ifdef CONFIG_BLK
+	dwmci_setup_cfg(&plat->cfg, host, DWMMC_MAX_FREQ, DWMMC_MIN_FREQ);
+	host->mmc = &plat->mmc;
+#else
+	err = add_dwmci(host, DWMMC_MAX_FREQ, DWMMC_MIN_FREQ);
+	if (err) {
 		printf("DWMMC%d registration failed\n", host->dev_index);
-		return -1;
+		return err;
 	}
 #endif
 
-	dwmci_setup_cfg(&plat->cfg, host, DWMMC_MAX_FREQ, DWMMC_MIN_FREQ);
-	host->mmc = &plat->mmc;
 	host->mmc->priv = &priv->host;
-	host->priv = dev;
 	upriv->mmc = host->mmc;
+	host->mmc->dev = dev;
+	host->priv = dev;
 
 	return dwmci_probe(dev);
 }
-- 
2.39.2

