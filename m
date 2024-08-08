Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DADEC52D6F
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 03:19:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DB7F88BD9;
	Thu,  8 Aug 2024 05:15:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SQMFCMLq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C66F88AD4; Thu,  8 Aug 2024 05:15:08 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BF4E88B1E
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 05:15:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3db14cc9066so381602b6e.3
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 20:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723086904; x=1723691704; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XgMOaDzDZtrOt6LtYkihbZiTIDSf9dvw6ZbjZCxwNSY=;
 b=SQMFCMLqwB6R0P7+5ggjY33eBquIYQwawWDTPveUcM3LAVsdmT1fLypyZ2pLLeqCGA
 do2DDFQ2PzWFFYOzoA3nYW1mADIXap9ZBdNj+0DCd/VeJH990zG0Nxmv1WTGnUTDYHGc
 uC2SOda5O3D1rD4otEY7/qNjIqJrtJovGl9OaKEJARAPsZFJySQiJBT1en0RssHF3Xso
 WoexBoHqz3/HOzQBKDd1ivPeV+0C/dJEz4nuuxqdBLOE7/RHUGfQQmADMj6sDq8kOMwp
 nZkxdbSasNVWHhx/3xxZHNVZj3G5QGBYS0dp06qT8HpmDFOUIuyp7TBdmMbuWOQ/yDt/
 FrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723086904; x=1723691704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XgMOaDzDZtrOt6LtYkihbZiTIDSf9dvw6ZbjZCxwNSY=;
 b=W2L5nsEROKIZAMonKnkswzSua78bbbzlAFcPpDw+yRk4sLtSMyXFwXsKAlaircx/8R
 EXMdzmifXif44Zhs1lS1g9IlwstrRyAtDoHjZenffEybWNw/SJUVhLT4/e+zsMx67PeA
 8vWGjwz3sE0ey6alN2rK6TN/Jsjph/04KZvfZdJf4pOLjr84ciMJT6ZnnXbuQcSgd9C+
 jlOi2Oo7hvMH+K4fUCrx3v4g64/SzaSLlBolUKYNB4nSXf58O38/6s5jcUswxoDF7ElI
 9qZnxEl9H005NYIeJByl2/f0bl45NWKOEF/KNOA1nqhIDdb2d87YlInqYFnrz2X+U3ON
 78wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/nzS9C2lZ/zrdCfjhqiB430818kk5vg+WQsVDtcLT+lw6qGydJeCj7zvRCZZzofYhQcHmoxU=@lists.denx.de
X-Gm-Message-State: AOJu0Yxwag8tnVmo1vXKuFLIPrb92OxclP3XaD7aSmEDgfCpisxEX25S
 w9cdCmGYKsQpQWUTAcARFpLaiyHGSYr472M1QA2FLDm182CqorUfF2joDGDdUFY=
X-Google-Smtp-Source: AGHT+IGWDNpUDh3Ebgt+zYbKjQEPVd3NsDpGwZRzACrbqzvMAFQw/v4Vu0M3XqXIYx/w0tUjBUsYOQ==
X-Received: by 2002:a05:6808:181b:b0:3d6:362b:5ea3 with SMTP id
 5614622812f47-3dc3b41b30bmr627735b6e.14.1723086904249; 
 Wed, 07 Aug 2024 20:15:04 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db56361a88sm4583195b6e.4.2024.08.07.20.15.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 20:15:03 -0700 (PDT)
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
Subject: [PATCH v5 26/38] mmc: exynos_dw_mmc: Read common bus-width property
Date: Wed,  7 Aug 2024 22:14:32 -0500
Message-Id: <20240808031444.9619-27-semen.protsenko@linaro.org>
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

Instead of using non-standard "samsung,bus-width" dts property, read
common "bus-width" property used in upstream Linux kernel. It's safe to
do so, as "bus-width" property was already added to corresponding nodes
in all affected Exynos device tree files.

No functional change.

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

 drivers/mmc/exynos_dw_mmc.c | 2 +-
 drivers/mmc/s5p_sdhci.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index b5c8f592c7e8..612c2d0c615d 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -274,7 +274,7 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 #endif
 
 	/* Get the bus width from the device node (Default is 4bit buswidth) */
-	host->buswidth = dev_read_u32_default(dev, "samsung,bus-width", 4);
+	host->buswidth = dev_read_u32_default(dev, "bus-width", 4);
 
 	/* Set the base address from the device node */
 	host->ioaddr = dev_read_addr_ptr(dev);
diff --git a/drivers/mmc/s5p_sdhci.c b/drivers/mmc/s5p_sdhci.c
index 80dbb38c9b36..278019f02abb 100644
--- a/drivers/mmc/s5p_sdhci.c
+++ b/drivers/mmc/s5p_sdhci.c
@@ -166,7 +166,7 @@ static int sdhci_get_config(const void *blob, int node, struct sdhci_host *host)
 	host->index = dev_id - PERIPH_ID_SDMMC0;
 
 	/* Get bus width */
-	bus_width = fdtdec_get_int(blob, node, "samsung,bus-width", 0);
+	bus_width = fdtdec_get_int(blob, node, "bus-width", 0);
 	if (bus_width <= 0) {
 		debug("MMC: Can't get bus-width\n");
 		return -EINVAL;
-- 
2.39.2

