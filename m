Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678CCC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:17:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3333088531;
	Mon, 10 Jun 2024 03:12:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rgfEHlg1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A47DC88528; Mon, 10 Jun 2024 03:12:52 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88DC088489
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-254a2d8485eso505228fac.0
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981969; x=1718586769; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=55XoD0qZ6rPWBZDZapID6wE7jRP2k4cdPOFCXFxhOtc=;
 b=rgfEHlg16nzNreNjUG28u2QTTKSr5nLNiEHjBl56L96o49YtmFUaZNlLfh28siiIOM
 RQ5uek1DIz+Onu/Amwjc14DFL0RhtGE3r3xsk7jJOt0fqz+XC6vjIKAoeDEIK9t2UdmD
 rLn/8zR1+xRP9NV94P3bc4d5L9PDRQwGVOOuXfNrzt3eY751OaMmPBxHYtX0ZUpdB3H7
 VyNL/k9O8UG5veRitRC3hPZi5ZdZ/L7pdXWgp1E3g/lyjO0HyX3wrQEpErf9848YtDQr
 SSzKZdSYJ6KHNSs3s0+Uq+jVWD7xYJ7smEgGNKOeosKicddpgYRl1l5QnsKHd+FAAYyN
 69kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981969; x=1718586769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=55XoD0qZ6rPWBZDZapID6wE7jRP2k4cdPOFCXFxhOtc=;
 b=RLuzHJfxUK96ccxi+henR34bLYu+aFWmQv4cNPiIevXT47bvbXE3lao44mN2dHflT7
 +q/Q0HWksIElhbhhqU+emyB73hNzeJo/5SxoGoXJfEZhL9fA3v5ivVl68bfYAo6PCXl2
 HpPNKFWSlDfG/HB4J4sLglCJCXEatZF9ApjEMd0Ci2os7FC1zqNhbpw5kdxGJ1v2v49/
 uHJibHvs8vITVpX5kMM/iyxzYztaA8Qln8hLzDHVqs9QfKdZ2ueZNUC2qtHyxeLJjqW1
 FDPBr/5+hS2kALTXxgxOYGJDCsczSXXr2qTupet4W5QSNb+Db4DpvzDW8jfRhX/2oGPz
 RDNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOphHRL0bm1dPc277T8zmkcuYVyrEgsN1vaGqRY8JpLl6boqdX1d6ZIfvNPVJ3RRN7DP6ubrJMZbvT7QTLvZg+67D3og==
X-Gm-Message-State: AOJu0YxpzJGI/UlQEHzImJb/NpAcd54ZyahZi0JwkMTnyS4vw0SBoh6v
 EsDSvOp4MPCOLcv9zgQuh5z7pa/T/45sQK0zhf5yzVXjpBku7igF3u0FRN/wizc=
X-Google-Smtp-Source: AGHT+IHjvMfdtcGIPzb9nI024pTw/niyymNh5U7edhqy7wkOAH9JCFrFxrZN0wuw7AiS4v+1Cy/Fkg==
X-Received: by 2002:a05:6871:3329:b0:254:9812:9294 with SMTP id
 586e51a60fabf-25498129f6dmr5460823fac.15.1717981968535; 
 Sun, 09 Jun 2024 18:12:48 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-254bf960c44sm392456fac.37.2024.06.09.18.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:48 -0700 (PDT)
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
Subject: [PATCH v2 30/40] mmc: exynos_dw_mmc: Read and use DDR timing when
 available
Date: Sun,  9 Jun 2024 20:12:16 -0500
Message-Id: <20240610011226.4050-31-semen.protsenko@linaro.org>
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

DDR timing values should be defined in "samsung,dw-mshc-ddr-timing" dts
property, and used when DDR MMC mode is selected. Read that value from
dts and use it. If it's not available, use SDR timing values instead.
This change is following upstream Linux kernel implementation.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/exynos_dw_mmc.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 69ba19e9edca..ef03eac5657b 100644
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
@@ -306,6 +313,17 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
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

