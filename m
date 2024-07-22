Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E387C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 18:02:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3785E88744;
	Mon, 22 Jul 2024 19:58:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ArNX0tW4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 857C8884F9; Mon, 22 Jul 2024 19:58:04 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6329886B6
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5d4fb707895so2504560eaf.0
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671080; x=1722275880; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iuo4s+jT2LDQjNpQvK91k3n+gM28GOOSe04ufuHr2SQ=;
 b=ArNX0tW4bHpZCbp5ppCGIt4IMbs3PJppUzCkefPJdfcr4FsadIiDcmjDcvKOo1QPwB
 QzuV/++/XSnP1lPWV9aDSfL9FKn89oAbIGBdZDKFauw54A+wvZWNKw4L/wFGfBhUEjbV
 n6GW65HSxirPMawWaFElg+WlQQ0nLcpB7rtwdkQMSn/Uvym0+nE6NbX7M0ZcRZj6b/ZC
 lq7aizyv2sfVqqtPAbKIX/OyIHgjslahY85Rz86i/x4syH0xaBkd7NSGoh7+3ceVavQa
 vkoTGppHWKycUpOLZMyyQySPHB/W7DgFN4a41ff/mzUkpo7wustOhG+5Hmoxt78ojQKk
 WqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671080; x=1722275880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iuo4s+jT2LDQjNpQvK91k3n+gM28GOOSe04ufuHr2SQ=;
 b=FQLSa+AFcngkAPN+gFKBEmoVfYgRZdY+aI95BX1UsaZLEEkriBU2DWDj72F1PDWWum
 9zf33uBeDneJRRiTCnS6vZGJIgfsADgwQ8xpmq4IHfnFvOBcE+g2NUQyUBqQJ63lNwgn
 MvSNriTwdEKqz0s3Bz5jzMeZAoh7m6GUbHPyWmLngxMJUlEL92NbN1S8sSGzwa3pt7b/
 jSlA+eJQpyEmNgMI8CPV+fN+yChCMtcOIbLadU0BfQvKoFtDEzb+fuVnYt4Gmw/T0i4f
 4xap/VdE6z/z0NAWU+fcjERaZZ8I/pQqHSWMCaIkm8dCy18UhLDFS8F4fmsvIqoEym1+
 nXhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnd8HdY7XFvEJaBPOQwFp9TQ0PHntWfyNUf7I1ccK301l5/viNWCM7I3WZpEsNTk5sjAvt/nsaA1uZTeZQwbFzVY2B2w==
X-Gm-Message-State: AOJu0YxSh0a96RnzIgAwPhkgCGGSGuHmCdQNPcpQWRx9ph4TKQGXwjCo
 0j3BHkIOAAC84eWwqyyzSfvQJ6VkzCKPvteLjWkV/TS+AmWR8hCUPXzzBbtd62c=
X-Google-Smtp-Source: AGHT+IGP/W80OV0AX7//9MpQ2/I8XFckgKT09m1S68xPe0/IL/ljbWd9w/tpw+tyYzZjnBHK/keDgQ==
X-Received: by 2002:a05:6820:198d:b0:5c6:8618:5995 with SMTP id
 006d021491bc7-5d564fea342mr10061298eaf.8.1721671080580; 
 Mon, 22 Jul 2024 10:58:00 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d55aad1dffsm1483147eaf.29.2024.07.22.10.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:58:00 -0700 (PDT)
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
Subject: [PATCH v3 26/38] mmc: exynos_dw_mmc: Read common bus-width property
Date: Mon, 22 Jul 2024 12:57:28 -0500
Message-Id: <20240722175740.6985-27-semen.protsenko@linaro.org>
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

Instead of using non-standard "samsung,bus-width" dts property, read
common "bus-width" property used in upstream Linux kernel. It's safe to
do so, as "bus-width" property was already added to corresponding nodes
in all affected Exynos device tree files.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
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

