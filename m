Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29509C25B7C
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:36:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6328D8858E;
	Thu, 23 May 2024 01:32:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="npLkz7fB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91762885A9; Thu, 23 May 2024 01:32:05 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61F5187D57
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:31:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-244bdd730dcso2599391fac.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420718; x=1717025518; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sISNUoerHOAo3xxswhYPELGlcEVeYbVIN5eV2B3jZRM=;
 b=npLkz7fBenyvnAfOIN47FfckKDwpJxM50mTkWDM429/mP1BxNhWc+ZMyx9ZSo3DWyo
 c1b+53K6u80uHHS40Z3FtH+X1TeAeYgPwUGhk1uPj8yqdtYsz06Ulf5zW/956wFOsKAg
 U1CgMuYZuZOh27aqljmuukGnpE5L0PfBNr3WfIkxf+t6eYmS+Rd0K3h63n/CGILI0rZ7
 +MgPAetETNnskmAwUAQw3T/5D5eRYita+UieyYOyECIpNFGWbpWnOfDu3Tbvvsjv3S04
 ObcVSOcSxKVI0arT9ycdp5RGYeBmp77OOKpj49beXW8D2aNExpVQvKstTUjIuOC6FvhS
 cq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420718; x=1717025518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sISNUoerHOAo3xxswhYPELGlcEVeYbVIN5eV2B3jZRM=;
 b=WeSu1DWNCkfoK4ze5deejYa26/WRd3S5Ai5Rgfe1Nl2Xv+hM106UwkkiBvZENf9UT2
 aBKQSKmPXbAIIX19TKsrw9sJGB8x3fOvr0YO1/F8aDsyF6w2Wia0jldliv/LnJSzrrbw
 ba+RhI1wDpul5hBVUsvpmcww6lAUbIl2CjlKja2/S6sO0Xd1OAZZRbZObUAQVYFd74uJ
 SeMyDAoQa9IjvUn5Yd+ZdCZqKTXvuAyO73COww2qTCHeurOgBnMECUp88yPus6qlpQ0E
 HQxcoIUjaUnBvd32Z/TY+gMhQNZDB8Wgjz8wAPqrcCM+41w7tHFJyV/SJwJuxv5SEmDH
 i2nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVW8/vg1EgSgTpUiOtaj0+KcW4010CGo14/k5i3LqexfZ3XLFeUaxCuSYU7O7I71bIV7NcalMCfx+3lg49riVkU4hic0g==
X-Gm-Message-State: AOJu0YzoqU1Lo++zxnE1jvApY54LR97bC8Im5buk/9hzalZNYSykD7EZ
 EWF/aj2ooQZfBXGSpM9qQciai5vmQItOgxbUMYg8TTOcHqGI93pTT93Y5aAgM7s=
X-Google-Smtp-Source: AGHT+IE/P9cLDGcvqyENJwcdwHXoOGKqulnYQuWjlQ8sDY2gjByPmhLj5pqtFF3LJxy6QKyUli1xgg==
X-Received: by 2002:a05:6870:3048:b0:24c:54ee:a77e with SMTP id
 586e51a60fabf-24c68e06f07mr3163921fac.35.1716420717701; 
 Wed, 22 May 2024 16:31:57 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f0ec2e566dsm4758323a34.15.2024.05.22.16.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:31:57 -0700 (PDT)
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
Subject: [PATCH 24/42] mmc: exynos_dw_mmc: Convert to use livetree API
Date: Wed, 22 May 2024 18:31:17 -0500
Message-Id: <20240522233135.26835-25-semen.protsenko@linaro.org>
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

Update the driver to use livetree API instead of FDT one.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/exynos_dw_mmc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 34485311c107..84382c606a1f 100644
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
@@ -226,18 +224,19 @@ static int do_dwmci_init(struct dwmci_host *host)
 
 static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 {
-	const void *blob = gd->fdt_blob;
 	struct dwmci_exynos_priv_data *priv = dev_get_priv(dev);
 	struct dwmci_host *host = &priv->host;
-	int node = dev_of_offset(dev);
 	int err = 0;
 	u32 timing[3];
 
 #if CONFIG_IS_ENABLED(CPU_V7A)
+	const void *blob = gd->fdt_blob;
+	int node = dev_of_offset(dev);
+
 	/* Extract device id for each mmc channel */
 	host->dev_id = pinmux_decode_periph_id(blob, node);
 
-	host->dev_index = fdtdec_get_int(blob, node, "index", host->dev_id);
+	host->dev_index = dev_read_u32_default(dev, "index", host->dev_id);
 	if (host->dev_index == host->dev_id)
 		host->dev_index = host->dev_id - PERIPH_ID_SDMMC0;
 
@@ -253,7 +252,7 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 #endif
 
 	/* Get the bus width from the device node (Default is 4bit buswidth) */
-	host->buswidth = fdtdec_get_int(blob, node, "samsung,bus-width", 4);
+	host->buswidth = dev_read_u32_default(dev, "samsung,bus-width", 4);
 
 	/* Set the base address from the device node */
 	host->ioaddr = dev_read_addr_ptr(dev);
@@ -263,7 +262,7 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 	}
 
 	/* Extract the timing info from the node */
-	err =  fdtdec_get_int_array(blob, node, "samsung,timing", timing, 3);
+	err = dev_read_u32_array(dev, "samsung,timing", timing, 3);
 	if (err) {
 		printf("DWMMC%d: Can't get sdr-timings for devider\n",
 				host->dev_index);
@@ -283,8 +282,8 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
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

