Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B80C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:49:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B44388744;
	Thu, 25 Jul 2024 22:45:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K9aA87y0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2BEC8859B; Thu, 25 Jul 2024 22:45:41 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D38F888580
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7037a208ff5so205003a34.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940337; x=1722545137; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vKX68i68F/KIbsQOD2K1dhvAle2Wr9F2LfPYr7ptEtY=;
 b=K9aA87y02K0RMPATTulcjDPyHb0Hk80CzSgjbwf5Zs0YdGNYkMtXB9413U78eY5FCj
 y19tp8jc+VJTcc0BvWCYPuqYj9d3VUcdIq7JEtKybT6D8EYpZOxUjRfvoBTBbUasgDnq
 ji3vP9CoOBItboleBeXYfayNgw+hqVpkvLO2S4AyaaIIyXN+kAvSsps+X3ciRIvn20+C
 /lynSvbOJEylb3/9vvETtDSnvl75ZoV7J6BgUF7G43BinZDuIyJz4UtY5emta6z/3xN/
 Ohod2JEpV/Aqyi9zZcgINbRQRoDY7/zudBeT2KtNiue0TQujoQLhbYox/mUn6O3rH5yZ
 5idw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940337; x=1722545137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vKX68i68F/KIbsQOD2K1dhvAle2Wr9F2LfPYr7ptEtY=;
 b=w7LRb67o1IhDIIzl75tF12VMUO+fblCAvlGHHEa85lcgWbz0mSzq3N3EbBJ6/puvJJ
 9swwpx6bco/4FZefRWBjq0HjA+bNp2I3Yo5S4ycEcICEe3EGcLSvm7CoPF97cenBfdfu
 TcpNZlEGEFpQee6nr/7aRrLn1aOf26t0XRqbgne0GWVHmygqFCDE23iG5skSFBryVe/t
 afT39Nud9R8UI0Hae+K2lI4Kvsozmnp34UXvv6CXDyoyr3FgJCLa370g7xjOEkruYu1c
 fUo7lG84+z2IAgqJ03xS4XQaI6+/D0He+gfLHE6pgyYr12MFIBl8uxDUrSjUfYoY+Hse
 j0iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB2HDYGoH6LHW/d1OqEVB3Rjy3sXk8jhP2y2vpF7aT7wEli/n0uf5oDVyGNacjwMA9U3DOsmWzcv2uR6+nDB6FNBsu4w==
X-Gm-Message-State: AOJu0YxjHAHrWSpM1PgWjmun98aEVe4odc84CztjKPjo8Z5wHSIhT7S0
 84OIFdVsyN0Z+58UTeG7Kj8Q02iL76TXdkHSqeyv7VViZpXLyAtN0oKSKpPsEFI=
X-Google-Smtp-Source: AGHT+IHQ1ja3r7sk/WMEsH9tu17zMf9UALxxz7BpcJW4eOGAr5gQgHORs0NPNKRb4RAwXl9aBEnqcQ==
X-Received: by 2002:a05:6830:3c0a:b0:703:6003:11f4 with SMTP id
 46e09a7af769-7093222f9d4mr4003657a34.14.1721940337568; 
 Thu, 25 Jul 2024 13:45:37 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70930778280sm447440a34.64.2024.07.25.13.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:37 -0700 (PDT)
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
Subject: [PATCH v4 22/38] mmc: exynos_dw_mmc: Convert to use livetree API
Date: Thu, 25 Jul 2024 15:45:04 -0500
Message-Id: <20240725204520.18134-23-semen.protsenko@linaro.org>
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

Update the driver to use livetree API instead of FDT one.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v4:
  - (none)

Changes in v3:
  - (none)

Changes in v2:
  - Moved exynos_dwmmc_of_to_plat() under #ifdef CONFIG_DM_MMC stanza

 drivers/mmc/exynos_dw_mmc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 09a59fdf0120..50d0208b29fd 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -6,9 +6,7 @@
 
 #include <clk.h>
 #include <dwmmc.h>
-#include <fdtdec.h>
 #include <asm/global_data.h>
-#include <linux/libfdt.h>
 #include <malloc.h>
 #include <errno.h>
 #include <asm/arch/dwmmc.h>
@@ -226,18 +224,19 @@ static int do_dwmci_init(struct dwmci_host *host)
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

