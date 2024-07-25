Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37019C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:50:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B24A4886BB;
	Thu, 25 Jul 2024 22:45:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BwoX+MNg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EC1088667; Thu, 25 Jul 2024 22:45:44 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED9818859B
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-70936061d0dso201399a34.2
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940341; x=1722545141; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AERAu0i38gJcVIJ0Ys3xnnSmu2uda0nUAbxFeiNbb+E=;
 b=BwoX+MNg8IZ0R3Ib4vKar5gRrfkCzTllCk+4gGWHo+xJoGP9rbZA4d6M/ZPxz8rbMp
 aMAjMB5nJRm70q+fDAn13m+9agjAurbEkqdrhbHsoZK81uXTnnFFJmrCWMAGaW95dieJ
 xQU98LrRLOE/wZ0EmLo7C0B4BpBOBkV9+VL4OzexSCWTX3ShMptMNyRZ1FgRdKrE1WJx
 kLMtflaWwdlMMxzogBIq0EamEJC0TKbfIps7L+3tw2hCPIA2F8oMjTe9ziYO9/NAqsSc
 kBDOfwduIv3GFFL9J4a5pG8Q+/TUjnWxDd/bLj95Sq7D0/u9j5FWbCxA9GjxumIhj9zJ
 WOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940341; x=1722545141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AERAu0i38gJcVIJ0Ys3xnnSmu2uda0nUAbxFeiNbb+E=;
 b=Jozl+7ssdoRwtpJOMIQHQQKlDa46pkajUMEn0Kvha01jAwl9vM6KhFkS37vI3GD5hS
 qACABF3Jh9m1aTCXnABQeKMqtfKPHEJlHvcxHKGOkMIGcDtuaL22prl3CdjFh4FwSYpB
 5re/SVxxfqOr3L/3xC4AAwFcnTKawuvOxgPilB1uw6y9t5I2ZFwwUrS7ox8TVPTfwLJz
 HhLOJ5f2wBqi3ZmQc0izZGlgFslT2jtrqcm6WVocXQdOhX+aUbs9MiGKzN6Mhyh6c3II
 iBBad62cSdrD7HtHulh3DGVShIZQ68R70GfZwn8PtkQTNDVQsz1v6ZTya1xxplftw9qJ
 RBiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEW2TE8mpGBvWdRhNhNsGRcq1kNCiKlaWxmqIyxhhDIm9E0evcHkMoBv0r4JrCk/iE1n6gI/7Ku92KkjBngbb9V3CRaA==
X-Gm-Message-State: AOJu0YzKN9R7Esd0yirrDOPReWZdxgb2SrfwL5Cf+xEli7PqDzG0ehyq
 zm08GJ4YNKdVGy6yLsM40e/J+bMEdicbY72rER7IvcFzqqQrl1wPrfXO6jESFeo=
X-Google-Smtp-Source: AGHT+IEJOY7ffudC3JbAf9y+/F62jMn71q0ocOPVFXSNKwSM5xtAJ1sprQp232M07wIZJwbCOsvC6w==
X-Received: by 2002:a05:6830:730d:b0:703:6ec7:64e1 with SMTP id
 46e09a7af769-70932010b81mr3558145a34.0.1721940340651; 
 Thu, 25 Jul 2024 13:45:40 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70930720f62sm453503a34.37.2024.07.25.13.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:40 -0700 (PDT)
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
Subject: [PATCH v4 26/38] mmc: exynos_dw_mmc: Read common bus-width property
Date: Thu, 25 Jul 2024 15:45:08 -0500
Message-Id: <20240725204520.18134-27-semen.protsenko@linaro.org>
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

Instead of using non-standard "samsung,bus-width" dts property, read
common "bus-width" property used in upstream Linux kernel. It's safe to
do so, as "bus-width" property was already added to corresponding nodes
in all affected Exynos device tree files.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
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

