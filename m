Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D8FC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:51:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1492F887F5;
	Thu, 25 Jul 2024 22:45:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o45cOfVQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D16188585; Thu, 25 Jul 2024 22:45:49 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3E5D8875B
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7037c464792so175957a34.2
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940345; x=1722545145; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+XUQL7vLaVVGvE2U+OSGmb2jWwlqvKIeMENURlbclfE=;
 b=o45cOfVQ4aQmmZ+soFaSMDqI84b61948X/dmAnmzIAqJjzSHaLZ8NEW58Boyssw2kS
 bjt9sOxpki7+EbcIP5qOBT0klcxnyGyT3xpVoJhafrTDfBeQ+iFClG5UQiFbOML3aw00
 edFHCc3WZ0UfjfMCPrQpociZjQn1oi5Y9S4q9RaprqSuomCS2i0JdMl9/d8lT9afYda8
 2X7XvX3FvyiEGS2WxVwBY+gHE2WEylH7RMrwJXXiLrLZWQ28TTAQwvAfFrXaHePIZuQR
 i8seN6Z7OD0a+THI1sBq75rVFtOh2biEQQbtDGqL0KL/VoNaVtAr27vKpdFE0GwlT/Y6
 mM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940345; x=1722545145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+XUQL7vLaVVGvE2U+OSGmb2jWwlqvKIeMENURlbclfE=;
 b=JvAKU736FdYmSbfGWDbMFhGGgkL/zivmrbN7na2bXHjTb6ZcZKcY+WmTUa7th3fb/i
 wvg9DXsNlWYrBcXZpARynrkPuhr/JuvY5sWOkwz6myLXCwEV5Y/yXVlUZ0bZO4W5azNM
 Z5TG3DQMGgRfsjuDgFACqKEZMRxPTG3mzAvcmjtC/E7zQvrrmt2ZKW1dPKlrRZeJoaPF
 1hYH+dMcuOPUhRF3qQ27e1R0jztoayJWeRvyj8+boaUUp16Y/xnD6SQ9/UXHjLArX45Z
 iUucWnBcn9aZIs6qoCMVb/mA5e+fUroBSOgXWdhd8aQY2c9x3rwamsJpfgaetV2dZI3O
 TAAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj+rAaHlZbYLO9U8Xo3NhOuKiIo9/2iAmY6W2Zb2fcnxAPfhOPqX4YFYrswPExJobP2mVq2SHtAim8iZOe94x3WODKbg==
X-Gm-Message-State: AOJu0YxtEkweo63xiYm072MYSpZqsr8Y3rEfrsdNlnGgotbd/Ubufz2G
 SsHnlpdtmz/HUFvcplmM9G0uX6eT6k8r9OFe00mhr37yfaZqQD5RL/e5MK3zrWQ=
X-Google-Smtp-Source: AGHT+IFcDHxz/DKIi3peARXFJj9kTXs0lCkT9QCo5nEULTFbD2x6SORI+TtKdJUiEm+awv6PPXZaUA==
X-Received: by 2002:a05:6830:6119:b0:703:6d44:41a5 with SMTP id
 46e09a7af769-7093210e9aamr3676879a34.6.1721940345488; 
 Thu, 25 Jul 2024 13:45:45 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7093071e976sm448354a34.34.2024.07.25.13.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:45 -0700 (PDT)
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
Subject: [PATCH v4 33/38] mmc: exynos_dw_mmc: Don't call dwmci_setup_cfg()
 after add_dwmci()
Date: Thu, 25 Jul 2024 15:45:15 -0500
Message-Id: <20240725204520.18134-34-semen.protsenko@linaro.org>
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

add_dwmci() is already calling dwmci_setup_cfg() internally, there is no
needed to call dwmci_setup_cfg() again in case when add_dwmci() is used
(for non-DM cases). Fix it by calling dwmci_setup_cfg() only in DM
cases, when add_dwmci() wasn't called. Also, this assignment:

    host->mmc = &plat->mmc;

is wrong in non-DM case when add_dwmci() was called, as it's creating
mmc object internally. Fix that by pulling that assignment into DM case,
when add_dwmci() isn't called.

While at it, add also this missing assignment:

    host->mmc->dev = dev;

Fixes: 3537ee879e04 ("mmc: exynos_dw_mmc: support the Driver mode for Exynos")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v4:
  - (none)

Changes in v3:
  - (none)

Changes in v2:
  - Replaced CONFIG_IS_ENABLED() with #ifdef

 drivers/mmc/exynos_dw_mmc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 41fb32c579ef..43111b749a6b 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -333,19 +333,21 @@ static int exynos_dwmmc_probe(struct udevice *dev)
 	host->clksel = exynos_dwmci_clksel;
 	host->get_mmc_clk = exynos_dwmci_get_clk;
 
-#ifndef CONFIG_DM_MMC
-	/* Add the mmc channel to be registered with mmc core */
-	if (add_dwmci(host, DWMMC_MAX_FREQ, DWMMC_MIN_FREQ)) {
+#ifdef CONFIG_BLK
+	dwmci_setup_cfg(&plat->cfg, host, DWMMC_MAX_FREQ, DWMMC_MIN_FREQ);
+	host->mmc = &plat->mmc;
+#else
+	err = add_dwmci(host, DWMMC_MAX_FREQ, DWMMC_MIN_FREQ);
+	if (err) {
 		printf("DWMMC%d registration failed\n", host->dev_index);
-		return -1;
+		return err;
 	}
 #endif
 
-	dwmci_setup_cfg(&plat->cfg, host, DWMMC_MAX_FREQ, DWMMC_MIN_FREQ);
-	host->mmc = &plat->mmc;
 	host->mmc->priv = &priv->host;
-	host->priv = dev;
 	upriv->mmc = host->mmc;
+	host->mmc->dev = dev;
+	host->priv = dev;
 
 	return dwmci_probe(dev);
 }
-- 
2.39.2

