Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EC6C25B7C
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:36:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84A04885B8;
	Thu, 23 May 2024 01:32:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ITkQyKVg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F13F885CF; Thu, 23 May 2024 01:32:08 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 015CB8858B
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:32:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-24c894a1d96so24909fac.3
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420721; x=1717025521; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u5/F5cv1bUxgnDB++ksU6DznGUo+QOGTzFEZiYiNIig=;
 b=ITkQyKVgklTwQIX8PqEzNlCjigB5sKnK7ayyB0CEJ+5UOOio32Mtx+xrscjBULpM4D
 nKPuvogxzIDz5lV4OocKxoU5T6Zj9UBe3dU+g+pzuhOen/EFBql5SmVaLZCTK0SjP2UM
 jjIcPGO7uCNJPgi/hMSYvJSmQerfv+jvip0hop4jnDnwuLcDPKCHQmQbG53JXGXgJ9Xj
 gOGaFFg4aARZat8ivsJzh1TcU5DhoJpzQ/4uRS0OOmk1cf3KELLNCkd0TTXY7brmiAHS
 y0ei9+Kl6Fu6uhsT+5eg3cvOIxzm8F/bqFV+kNm94/9ZBFAVwWOQvY46OT8vBoew7miQ
 1FSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420721; x=1717025521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u5/F5cv1bUxgnDB++ksU6DznGUo+QOGTzFEZiYiNIig=;
 b=o1lTfsiTC5X+5qM6Yv9RTuBg56vPqQXr510JHj8xGvTzSi/0biyFsjAV1AP7QfGeIE
 SbZl0p2cPOUqA2oZq5jMuy2YeoGUKDEkaj7B7Br1mL1zY2ZkwyBUH5feLEAQHr3zfELH
 9Qnry0WeMPuOHqnNs5LLqkYhGeKrTu4srsNGGoX4ziQWkx8YOdYCdijuL5OcY2VaojeI
 9ggdACq+5x3TJn62fcwW73TfV7NwpX4jg8/njdylJryDAMxyW0EQVQEChrLLIOLZjdb9
 ava+kS0uL+ugH1MJcBpro2njiZJK36L0vhlH98Q6BFcA77v2KGJAjZvSW5B1Or5XItP/
 p38g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUie0Vq7hepY6dzAiHGlPZ6QOvxxKsR9McNC3SXaVPz1N1HzmKN+R5oW7LQ3jxUysJ1BquNKCKXuq4bgDtoIlVh6W17QA==
X-Gm-Message-State: AOJu0YwtoRdd5lUGkIfthS3eBpDAFpIVksmQ/qgmnA6WoCwEr9KGdxwf
 PB+bkrlFV4TGpzQBoOAP4zZympyu9Bc1IOZby179NAJXinDegyXZ6FfpYTF4s2Y=
X-Google-Smtp-Source: AGHT+IEjGUE4sCIfdkXFFQVNzWyM76SXugc/ICLebc2hEqUiPR6XQGLYBnezAk0heTfuKGSwczVAdA==
X-Received: by 2002:a05:6870:8a29:b0:22e:7390:da7 with SMTP id
 586e51a60fabf-24c68d14303mr3887601fac.21.1716420720647; 
 Wed, 22 May 2024 16:32:00 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2412acd6272sm6707921fac.47.2024.05.22.16.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:32:00 -0700 (PDT)
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
Subject: [PATCH 28/42] mmc: exynos_dw_mmc: Read common bus-width property
Date: Wed, 22 May 2024 18:31:21 -0500
Message-Id: <20240522233135.26835-29-semen.protsenko@linaro.org>
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

Instead of using non-standard "samsung,bus-width" dts property, read
common "bus-width" property used in upstream Linux kernel. It's safe to
do so, as "bus-width" property was already added to corresponding nodes
in all affected Exynos device tree files.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/exynos_dw_mmc.c | 2 +-
 drivers/mmc/s5p_sdhci.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 646302f54ae6..b046ac6c55ea 100644
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
index 3b74feae68c7..0b49a9c5f2a9 100644
--- a/drivers/mmc/s5p_sdhci.c
+++ b/drivers/mmc/s5p_sdhci.c
@@ -167,7 +167,7 @@ static int sdhci_get_config(const void *blob, int node, struct sdhci_host *host)
 	host->index = dev_id - PERIPH_ID_SDMMC0;
 
 	/* Get bus width */
-	bus_width = fdtdec_get_int(blob, node, "samsung,bus-width", 0);
+	bus_width = fdtdec_get_int(blob, node, "bus-width", 0);
 	if (bus_width <= 0) {
 		debug("MMC: Can't get bus-width\n");
 		return -EINVAL;
-- 
2.39.2

