Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F19BC3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 03:20:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 952D388BE1;
	Thu,  8 Aug 2024 05:15:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nIuTyDrR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF0FC88B6B; Thu,  8 Aug 2024 05:15:11 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0EBC88B60
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 05:15:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3dc16d00ba6so401567b6e.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 20:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723086906; x=1723691706; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DSKAXbivnyO7PTI88YIY/YwtRuzwHbsX/v2bURPmZbc=;
 b=nIuTyDrRtLzuLu0jSdeiO79eHcLAzOmixTwwe9Dao1Pxvpn7fwtcI0Ol7UX9zIZGAq
 DnAZWSTNFTkH2w6GY1uES5FL/FV6WupRfGN4dBO47djCot3eVPHyw6kXAOZA8MrSHOnO
 PdyVmY+F26wUIKDFDdcktnHkakRi/d5TwSZGE/51qsn5GfY04z2e7ShCiCSXbaqewoHU
 wTLu1sUVhPMUioMxoyAGqShfKHaK3rLPkTXKQifL+aipyVmRig9q57ExBfedEnUWzm+p
 Da/gmzMBd1E5+ZRl/KrkRkjOczdHObB82apb06cfOtaLzU8lqb2oC1aH2h/gqbQYwDR8
 0xXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723086906; x=1723691706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DSKAXbivnyO7PTI88YIY/YwtRuzwHbsX/v2bURPmZbc=;
 b=E44Blt19n67hXqUrqSWznUgPNfEiZ0c2IItigoHTzb1wBIlkC+QnoLnCXBa2vA/JAr
 b/bgbY7iTRIIzGBi5//BhIFqAv7yVLdFDwvHJ3YOjUY+QanqPZOQrbIHaumZ2doyETWM
 w+zgEp1fn8QY7khw/ngU/Bdrq4tEL8aFXuKwPJTgvpMNsrbmhnOl/3cA8/xLEeraq0oG
 FWc+aYdbnpa6S4MMYTzR0mlxLYyGfqeRr62rgz8d9d/y489jpeN2eN6urOOhZue0pdOh
 SyEf16XTLCoIWj5hS6VSnKagAPRcKyrVEdUgFuaIshfQfy8soewBQyBCWxYa3SFPfP/A
 /uVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCURk8nXkhB3GYe1CNsNUDyfahUh4kl5QdUVkiwGLfRIs5ibsOKlG1GYuIeaow8WZHTX4O1bhoCpLPFxcGL+GHufl/M6iQ==
X-Gm-Message-State: AOJu0YxdNmy2OEEXQ5j+kZpeq6wKD4BOiXb6GlbQvDE1iAuujxZImcGh
 yjapInhQF1pjfGEahahgt2MvjHvSG24t3XwHFTBIgLY2gGqxIq/IRV+3SR8SSUM=
X-Google-Smtp-Source: AGHT+IGAlCZiKledRE/9iyTuUdTlsUSmfLpSACJLSRRqwtvewhA3c9SRzn10J6r0x7rlXAFtd6f+cw==
X-Received: by 2002:a05:6870:7815:b0:261:26ab:f89d with SMTP id
 586e51a60fabf-2692b7f6fc3mr627609fac.48.1723086906594; 
 Wed, 07 Aug 2024 20:15:06 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70a31eaf6d6sm5127643a34.30.2024.08.07.20.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 20:15:06 -0700 (PDT)
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
Subject: [PATCH v5 29/38] mmc: exynos_dw_mmc: Read and use DDR timing when
 available
Date: Wed,  7 Aug 2024 22:14:35 -0500
Message-Id: <20240808031444.9619-30-semen.protsenko@linaro.org>
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

DDR timing values should be defined in "samsung,dw-mshc-ddr-timing" dts
property, and used when DDR MMC mode is selected. Read that value from
dts and use it. If it's not available, use SDR timing values instead.
This change is following upstream Linux kernel implementation.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v5:
  - (none)

Changes in v4:
  - (none)

Changes in v3:
  - (none)

Changes in v2:
  - (none)

 drivers/mmc/exynos_dw_mmc.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index b9d655c0d5c8..32f3ea168b6c 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -52,6 +52,7 @@ struct dwmci_exynos_priv_data {
 #endif
 	struct clk clk;
 	u32 sdr_timing;
+	u32 ddr_timing;
 	const struct exynos_dwmmc_variant *chip;
 };
 
@@ -127,8 +128,14 @@ static int exynos_dwmmc_set_sclk(struct dwmci_host *host, unsigned long rate)
 static int exynos_dwmci_clksel(struct dwmci_host *host)
 {
 	struct dwmci_exynos_priv_data *priv = exynos_dwmmc_get_priv(host);
+	u32 timing;
 
-	dwmci_writel(host, priv->chip->clksel, priv->sdr_timing);
+	if (host->mmc->selected_mode == MMC_DDR_52)
+		timing = priv->ddr_timing;
+	else
+		timing = priv->sdr_timing;
+
+	dwmci_writel(host, priv->chip->clksel, timing);
 
 	return 0;
 }
@@ -305,6 +312,17 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 			priv->sdr_timing = DWMMC_MMC2_SDR_TIMING_VAL;
 	}
 
+	err = dev_read_u32_array(dev, "samsung,dw-mshc-ddr-timing", timing, 2);
+	if (err) {
+		debug("DWMMC%d: Can't get ddr-timings, using sdr-timings\n",
+		      host->dev_index);
+		priv->ddr_timing = priv->sdr_timing;
+	} else {
+		priv->ddr_timing = DWMCI_SET_SAMPLE_CLK(timing[0]) |
+				   DWMCI_SET_DRV_CLK(timing[1]) |
+				   DWMCI_SET_DIV_RATIO(div);
+	}
+
 	host->fifo_depth = dev_read_u32_default(dev, "fifo-depth", 0);
 	host->bus_hz = dev_read_u32_default(dev, "clock-frequency", 0);
 
-- 
2.39.2

