Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075BFC27C53
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:18:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EB8788578;
	Mon, 10 Jun 2024 03:12:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LIXHxZY+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CEDA88589; Mon, 10 Jun 2024 03:12:56 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F31588545
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5b53bb4bebaso2077353eaf.0
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981972; x=1718586772; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I61V32c8HMJSoXG/mwzY2zs9W+T36XeIqY6DmpufeGw=;
 b=LIXHxZY+QlWeQU7Z+WFWGLT1+2OlsKc+iGLy9ZKKOS0yEOoVZsLz/DA5h8Twgqt2LF
 sfLP/bOf8CRbVIVne4qk0hBZkVnLKrn4n8T7iBtoQ2WDiS+zidTNtVoZsDuQENTqtZPf
 zM93VV83mMOwSwLP0uTpo7NTFHUziKgwvH1EGDyER05sxYfxN4+amj7IGWYD5LcnGqid
 vXvXgt9QRFufmGf1KTFrVDx5SRTLI/53DPoWgz95grkubbs9vQQnmAH3Yfh/MlWCjF+v
 ufpUypVUPTMN74UD/Kvasy2mJCTHaTNEE5ZzhFiWGqWd+FqzdvPfG3/BpqJlSh1bZsMk
 upmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981972; x=1718586772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I61V32c8HMJSoXG/mwzY2zs9W+T36XeIqY6DmpufeGw=;
 b=au76mq2KRaZttdF961QQHOG9PoMLVm+redIHLTzDwOH2HfMDzi/77UWM8j72GpF5qY
 KcdcJchRuB2zD1+uvqZpK7y7C9mx/A41L5CHuThOg+EI1bodA4uuvsWZ21CeRTQkPrhk
 vSIEZM2yQsClFBUf0LcOxW6ukqKaQ394G7bJo6kukgRsrovfrH8gFNe7wvf8SAaaA8I9
 MrezRs9S5n218X+wDyEVYi0OTYceu27q1ZxZht+RrMjHiqL+kYPs+SwBNDLTk2q8jVat
 6jurmO1dC7jIUmcvjxyk8zOdAHAPR+7vcB6QaRNmsTCei5Nw7iMrVbAA3UFkFgK3fUUi
 gzCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJBd1E3lXYreOyKAmxmKs3lKO70j0OZdeHOXekSmVxQ0hVCq+WbWn6Sr9q+8MXqFPSdiLE4poXvCJIMzdF4Zi/dbcHWw==
X-Gm-Message-State: AOJu0Ywo1S9AKOwpqFpDAJCu0oqrNXvAsSJyJv6aYJIAYiTIuVkUuDCY
 EJpLtPULSLL4YPUwHq0ZG21QmPrWVcKXMdxukqtrtjkL/l80VsX/692HzzAVzes=
X-Google-Smtp-Source: AGHT+IE7l5yv0M3+pxQn/KEUarxRYzF7wmHl2q7gCE5tSFoPK1EcSORrRzIjE7bqR4DbljyMu7FQ/w==
X-Received: by 2002:a05:6820:2220:b0:5bb:672:4067 with SMTP id
 006d021491bc7-5bb06724307mr960400eaf.7.1717981972160; 
 Sun, 09 Jun 2024 18:12:52 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5bb079d205fsm117081eaf.18.2024.06.09.18.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:51 -0700 (PDT)
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
Subject: [PATCH v2 35/40] mmc: exynos_dw_mmc: Don't call dwmci_setup_cfg()
 after add_dwmci()
Date: Sun,  9 Jun 2024 20:12:21 -0500
Message-Id: <20240610011226.4050-36-semen.protsenko@linaro.org>
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

