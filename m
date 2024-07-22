Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D225C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 18:02:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFAF588747;
	Mon, 22 Jul 2024 19:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WdRv5Sdu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18EA1886FD; Mon, 22 Jul 2024 19:58:07 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E30F8886E6
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:58:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5cebf0b37fcso2402015eaf.1
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671083; x=1722275883; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A5T7A/mEbivYIgckafzMYIBbRDiGDLtIO9ibMZLMgfY=;
 b=WdRv5SduFAOxJaBmJLCWYTDdJ2dr6E5tmHlhbKYn3XKfFwJZMhbwxL6mla++Gm0GcA
 CAqWh7Qb08JNbYSexyjgDmMUffnuxCP4kk0ODf6AGaZEZqcV41oZB/BJ0R8TeAJ0C9Vk
 plVIa/bYRSIeHMrmyZMqeKiv29LqOJz5bRhQg4AablZiwu6QfvLwjASvWGIswXWBA675
 ILih9MQeRk2xD9airCv4Na2T+uFdGhxKfB5JzqI8wb86KddnPdLLFeZ3fftAeL/F3v0e
 ETVskNU6x5Omo/fkYhbTCHRSzpisw2GvXFlLwWiVq3uPS30KWGySEv4slGu8LoPAdFma
 Uriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671083; x=1722275883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A5T7A/mEbivYIgckafzMYIBbRDiGDLtIO9ibMZLMgfY=;
 b=vGIMFYLhg+N6vIvAFAHRc2VhlrADLEVqsAwytto/aJyg8lKGLknrGikxNpbAChRJzP
 lXKzIaCeFN5qmjKcrdG4G8rsafmP0YEXgYC/LM3xqhPw0xLAKA2o+vyc79dcWNtXX1CS
 Bc1QfE/vaSZXHrEQgnac0wfu8s1KBBREaEcp+8OZSXziUCfG7VlXmyCyg4mJaWhwtGqp
 QOjJ0tW22mlk8eWLdfQlxqmmxRTKXRdI8Byf9yinAtpYrz+t6fYDRDW/OG7i++OZrNKg
 Lyv0MoZ4+wc43B3qDtdDvBgFd/ptfnXy2VzVn12V8gpSXPYYw1Hw6S6czVAx9htw3imS
 v3QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxfQ92i/CD6i20zYrwgmrGNV6Dm7PwTJpzIHsJLjCK2xlenuPIJ/laFfu+hs7mr5DiQuTz1DRiDFW8QG7koJ0HNoyKtA==
X-Gm-Message-State: AOJu0YzEFR0f8q29iwBplF8Buhdm82uGNx+7P0Bxr7NpB8Fb92H/YTtI
 MTZqF8CKz9/oftYkqKuEV3hIRn1NPcbY10MwTIlkNGLNZ8tdo3dCID9k44KqFrQ=
X-Google-Smtp-Source: AGHT+IFsnWXysSnfE7K9DhxYRevL+3P0SOkPaW/WXayREWziRwM3iKOYPhUvmVqsuTJ1tvuU1Qtbyg==
X-Received: by 2002:a05:6870:d695:b0:260:f50e:923e with SMTP id
 586e51a60fabf-26469231728mr354614fac.37.1721671082698; 
 Mon, 22 Jul 2024 10:58:02 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2610c771c34sm1757089fac.22.2024.07.22.10.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:58:02 -0700 (PDT)
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
Subject: [PATCH v3 29/38] mmc: exynos_dw_mmc: Read and use DDR timing when
 available
Date: Mon, 22 Jul 2024 12:57:31 -0500
Message-Id: <20240722175740.6985-30-semen.protsenko@linaro.org>
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

DDR timing values should be defined in "samsung,dw-mshc-ddr-timing" dts
property, and used when DDR MMC mode is selected. Read that value from
dts and use it. If it's not available, use SDR timing values instead.
This change is following upstream Linux kernel implementation.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
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

