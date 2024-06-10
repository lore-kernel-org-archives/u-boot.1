Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C0EC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:16:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F3B088521;
	Mon, 10 Jun 2024 03:12:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YHK9vz/o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60FAF88520; Mon, 10 Jun 2024 03:12:47 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DFC58849A
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2548c80efc6so765993fac.0
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981964; x=1718586764; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QdG9IFJkxoV/UQBfpzafL1e9Z4kE65JOukEssVS2O7g=;
 b=YHK9vz/on3HTRaX+vQWomV0HQ/FPqRbrq3KCXwFCK/8yffIdytb70Ss7+H04oGZjXz
 ghM4yIzdiLj/C3mC/nReyVS694VqHjo4GifQR95QxO2EJApwRMjrYHkElRTbEdl95qrN
 R6QQIKyUIoLAFzN7utuGQqMN7iInkAlOC42xcJ9schjQZqmmVhq93F5RYm8KMre63O3P
 kPcDvdR5IrrcYg9lR98CiPHUiKgDpriofxXBZgx0GJMQuhNqotvXgW9HykTvct/0Yz4b
 zLm5QryNYW0WWiW3mns2aYdWciBXXbLmzNW2NKgDNLfYcJ4uupSkR82e+ronP7Bsyi2L
 KiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981964; x=1718586764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QdG9IFJkxoV/UQBfpzafL1e9Z4kE65JOukEssVS2O7g=;
 b=M/74OxkrjIo/YOlYl+SlbvbHO4fSQmTE+OxwaMNcoOp8gLfvIkOEEaW8fYh/v4bisN
 mvKjDvE6DBuC/4wmE/vai05Fq49RkFrPd0Ar5WM3IUu8XRh5UzWWNyEML10v+X7g42GE
 UCaVlA6wRXx+GmeFzBYEZOIqmsHSNfFo0Y4OFIH93WK6C8WD29Y8k+vPIyqbzyTTE+3P
 M97pwC9q3LIjIiWzrI/yGLVb3wVzuvE3HxJD07yce5wZ6Ne1W8WV5bkMpEuPtlP9YRcI
 YTlzzoJX3G4D305hx9qjBSDRtaYTuZG8ffupP60HikQtB+vH25XTQWlhzyPxubOXH2Hy
 Cxsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1Dl/6MnMWY4QcWmGS7fJOR1IbASYYWENnUk7fk5o3uUn915woh5h8X9+Qm3m6h1i0Z6KkHOXZU7xFg3j2ztwowa0eRg==
X-Gm-Message-State: AOJu0YyzRskRTrmXuqsGIH6VJz81h7E0KvVhFQ6hSoQkEqN7LnwFj5i1
 3rnKIzPGx2Sg51bbiLs4Tm49o/dA/8/wukmByHVGdG25kDRoSzmH9+juQq6lPqs=
X-Google-Smtp-Source: AGHT+IHuEGKqqy4vHxxPJbRZNp74SAKi8x7+cPXaoZUldoPMoHhFzwjYsxTCacWJex04S94LX5vAbQ==
X-Received: by 2002:a05:6870:89a4:b0:254:b08f:8fcd with SMTP id
 586e51a60fabf-254b08f9432mr1367574fac.20.1717981963739; 
 Sun, 09 Jun 2024 18:12:43 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-254aed4cbe4sm649653fac.15.2024.06.09.18.12.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:43 -0700 (PDT)
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
Subject: [PATCH v2 23/40] mmc: exynos_dw_mmc: Convert to use livetree API
Date: Sun,  9 Jun 2024 20:12:09 -0500
Message-Id: <20240610011226.4050-24-semen.protsenko@linaro.org>
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

Update the driver to use livetree API instead of FDT one.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - Moved exynos_dwmmc_of_to_plat() under #ifdef CONFIG_DM_MMC stanza

 drivers/mmc/exynos_dw_mmc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 95c64b9eda54..eb2d2d204def 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -7,9 +7,7 @@
 #include <clk.h>
 #include <common.h>
 #include <dwmmc.h>
-#include <fdtdec.h>
 #include <asm/global_data.h>
-#include <linux/libfdt.h>
 #include <malloc.h>
 #include <errno.h>
 #include <asm/arch/dwmmc.h>
@@ -227,18 +225,19 @@ static int do_dwmci_init(struct dwmci_host *host)
 #ifdef CONFIG_DM_MMC
 static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 {
-	const void *blob = gd->fdt_blob;
 	struct dwmci_exynos_priv_data *priv = dev_get_priv(dev);
 	struct dwmci_host *host = &priv->host;
-	int node = dev_of_offset(dev);
 	int err = 0;
 	u32 timing[3];
 
 #ifdef CONFIG_CPU_V7A
+	const void *blob = gd->fdt_blob;
+	int node = dev_of_offset(dev);
+
 	/* Extract device id for each mmc channel */
 	host->dev_id = pinmux_decode_periph_id(blob, node);
 
-	host->dev_index = fdtdec_get_int(blob, node, "index", host->dev_id);
+	host->dev_index = dev_read_u32_default(dev, "index", host->dev_id);
 	if (host->dev_index == host->dev_id)
 		host->dev_index = host->dev_id - PERIPH_ID_SDMMC0;
 
@@ -254,7 +253,7 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 #endif
 
 	/* Get the bus width from the device node (Default is 4bit buswidth) */
-	host->buswidth = fdtdec_get_int(blob, node, "samsung,bus-width", 4);
+	host->buswidth = dev_read_u32_default(dev, "samsung,bus-width", 4);
 
 	/* Set the base address from the device node */
 	host->ioaddr = dev_read_addr_ptr(dev);
@@ -264,7 +263,7 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 	}
 
 	/* Extract the timing info from the node */
-	err =  fdtdec_get_int_array(blob, node, "samsung,timing", timing, 3);
+	err = dev_read_u32_array(dev, "samsung,timing", timing, 3);
 	if (err) {
 		printf("DWMMC%d: Can't get sdr-timings for devider\n",
 				host->dev_index);
@@ -284,8 +283,8 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 	}
 
 	host->fifo_depth = dev_read_u32_default(dev, "fifo-depth", 0);
-	host->bus_hz = fdtdec_get_int(blob, node, "bus_hz", 0);
-	host->div = fdtdec_get_int(blob, node, "div", 0);
+	host->bus_hz = dev_read_u32_default(dev, "bus_hz", 0);
+	host->div = dev_read_u32_default(dev, "div", 0);
 
 	return 0;
 }
-- 
2.39.2

