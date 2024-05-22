Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73DFC25B7C
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:37:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC4FE8854E;
	Thu, 23 May 2024 01:32:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H9ztOLXi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 027FE88551; Thu, 23 May 2024 01:32:11 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34FCF88593
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3c9a0042e7dso2817619b6e.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420723; x=1717025523; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=leXg5M9IJZvGZQdRki2akuLu9l5aNtTu1JiIhuyNyJg=;
 b=H9ztOLXiDSgbc8/JcHddVMKvIIUJ0Gd0DmkdWPEn2B+nYMkRjaT9xngKRtm8HKrcBU
 inzVFveGQBKDxW9YNNxm+XSZPWl/hriFCEd6yXgJLbmmFIv85S4KZjqH/olgN+EEuAWc
 unviKbuzyJ12JU5IhcCKrt6BT80LTZnrVlt+qVp18Dju/CWccUOljPot1Vb/5+IzsORP
 Ng0LoebYAcM4krg86TwqyN4q0JKeds5XZ+iD956G7io4FBgUFcVxhdsCiE5ivxTM1+KR
 ZMvaubrubC/bDK0ph2Mr16vhr2S2YNXj4blYLd3L89uNk9rVFfZiTrcr2dS+wMy6EZL9
 fgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420723; x=1717025523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=leXg5M9IJZvGZQdRki2akuLu9l5aNtTu1JiIhuyNyJg=;
 b=EOwpgU1oPiTBcLwOn2gpq1ZBLA9vwdERlqs9gXycRr1o0nJ6W4GIaLEd1cRy/tk73L
 u8uSAHX22i8SGIgth4bAeqDlhQqIB8ZOaJu89F9i64l/6vbjQx25kZ2aOVuPmMEtYf5/
 sZmHppqph76jw5Mxmd4o3Sgrnd/W9NdQWXhWyPlU+U8q2lMsQH00kkcp7cN8bAIJ1OyA
 TVqCpJ/Be1KMiqWaFX2LO1tSSAPDR0gGuZ3bCbvI+o6tpbuzlF7eOfBEPx4hTE9Muf1y
 cYQsWacWaNXg6/7w5bDVh6PyoXNGezexwp5I+d2oYslLR0nHSbJEUq2qAMn6ocJsXBXC
 J3tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrsIPzKkTvCIf82SvPbJWwQXdKB1+HlQ4efYTfv333i+f6ucX+Tb3AWqxv6xVuk78W1FUY5j7J9v4Zmxf/ZrBkYrI2xw==
X-Gm-Message-State: AOJu0YwK2EjxKGwr3c1t6OY+96+ihGCeHjG6S5WzW39pQHrVgx7uufTW
 2QTG+L80Iyq/rdrWGoX7kxCOTW8vq+z8Y6ljSmO0dsbdAHP9wAOVKnF0Pg3yVPk=
X-Google-Smtp-Source: AGHT+IE8b20sSHRU/tA8i10VvBPycczbsHSM6bSvnfq84hZ8KeCUMA5mVT7cUhJ+RSPUCIRRv8/Uqg==
X-Received: by 2002:a05:6808:2393:b0:3c9:7a7b:a7cd with SMTP id
 5614622812f47-3cdbb525531mr4261577b6e.51.1716420722896; 
 Wed, 22 May 2024 16:32:02 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3c9cb0ef7desm2148993b6e.56.2024.05.22.16.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:32:02 -0700 (PDT)
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
Subject: [PATCH 31/42] mmc: exynos_dw_mmc: Read and use DDR timing when
 available
Date: Wed, 22 May 2024 18:31:24 -0500
Message-Id: <20240522233135.26835-32-semen.protsenko@linaro.org>
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

DDR timing values should be defined in "samsung,dw-mshc-ddr-timing" dts
property, and used when DDR MMC mode is selected. Read that value from
dts and use it. If it's not available, use SDR timing values instead.
This change is following upstream Linux kernel implementation.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/exynos_dw_mmc.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 91300f67b9fe..d3708ecb6407 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -53,6 +53,7 @@ struct dwmci_exynos_priv_data {
 #endif
 	struct clk clk;
 	u32 sdr_timing;
+	u32 ddr_timing;
 	const struct exynos_dwmmc_variant *chip;
 };
 
@@ -128,8 +129,14 @@ static int exynos_dwmmc_set_sclk(struct dwmci_host *host, unsigned long rate)
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

