Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5EDC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:50:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B65578875D;
	Thu, 25 Jul 2024 22:45:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fFnagMNs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20A5E88730; Thu, 25 Jul 2024 22:45:46 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F16F88863E
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-708adad61f8so197679a34.1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940343; x=1722545143; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s2Pqoyr35+7fx/+L9NHlNn9vjAMBq6pejH5ouGBVKPI=;
 b=fFnagMNsYO+3prDgSATE8fYe1kxmqZEZdVemd/27cBHUTqY+qOEKaZI/BdTDyX00zc
 vJ0DdHBKzgiLhpYkVT/Aeh8fToKZoOeR78f0DoJ3eQx6Ui672ILfcx3QPuFtSmgeJUnK
 EwUFiHXh1t1ixyAR+zAQiC6K9aPC2rAiB6J0u82AUCDpLK+nBjEoPuYjFlttJy64cFhw
 3LOad0ZNiAW8+SAPF+iqajgPJ1W0rbQq5aYLu2tFJb+5zNsKYjqzkYFzWAxeW2vqNfvU
 WWca2WwdmlP4kFXLOND3Yyj/66S9eTLow9xzpreyGndG1k+6DgIdeiIH2Kr5Wan+C1Be
 FLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940343; x=1722545143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s2Pqoyr35+7fx/+L9NHlNn9vjAMBq6pejH5ouGBVKPI=;
 b=FQ12BL1wvOb5qJMF8hDLXXtOvft0sFeLYi6p4He1Du7hztw+XFBg5im05ch826l1k7
 RiGEMcBDNqPMuQk/mDSvc2VNTwQHajp7h4eJTYqvm4UpgRe8lOtD6oWHF959Jzj1Ppg1
 c4VTi985MyMTPhzRjvV3gfl5VURAt6Oj+USWLkZWR8AcpqtNxbyfEL+TTyuDZ/kS8sHv
 HJjkZm3Vfm/lkLTDOkur+CSCwXCuuSaS3bsN5Qz7Lup46MmNX2iMiMfck4snoJjcmQTd
 /Zjm8Ae0h4TWQ0NMGeWAIlj3qKVb1a3zTX5nXs0uLd8R9mnFYAuG2LlxeMst3PcYAo7N
 z0kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRB+2sbujBVu0Bt6/RwDx0swZue+Xy7udsDoJQCLrmI0/TW4coEytenuralrSFxeAcVwMY7wlE/n/H19adZ7iVeW75fg==
X-Gm-Message-State: AOJu0YwUO7hSY/H/94/5uMg4ITWx/gTgiLnbPlsAlbEda5QIav1S9KjB
 vwStoll2COhKju7mSvAR+7SXq9Ym7WXPAsJefraqrGI8KTv7KT0O5wFPx/4KR/c=
X-Google-Smtp-Source: AGHT+IFFZ2mhxm0iEkr/HdarNpg703U6n8ZU9gthGqzotScF26FYaJKdtAftAAvS3CWV/o313+VrHA==
X-Received: by 2002:a05:6830:388a:b0:709:30eb:dfcb with SMTP id
 46e09a7af769-7093223599emr4099788a34.18.1721940342772; 
 Thu, 25 Jul 2024 13:45:42 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d5b349a4desm249334eaf.11.2024.07.25.13.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:42 -0700 (PDT)
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
Subject: [PATCH v4 29/38] mmc: exynos_dw_mmc: Read and use DDR timing when
 available
Date: Thu, 25 Jul 2024 15:45:11 -0500
Message-Id: <20240725204520.18134-30-semen.protsenko@linaro.org>
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

DDR timing values should be defined in "samsung,dw-mshc-ddr-timing" dts
property, and used when DDR MMC mode is selected. Read that value from
dts and use it. If it's not available, use SDR timing values instead.
This change is following upstream Linux kernel implementation.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
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

