Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BA2C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:49:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC4168875C;
	Thu, 25 Jul 2024 22:45:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h9A+jaC0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D95A788580; Thu, 25 Jul 2024 22:45:41 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AB6D8863C
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-709339c91f9so178368a34.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940338; x=1722545138; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C9ZIgLBY2XnIbIK9fr9v41CY3z5s1kiYpWDyp+lFXSs=;
 b=h9A+jaC0gBezTSgjiwLtdq3OndsSXnIJt2VdTrU8D0v/64akjX0sVPcNMxvjPGheRn
 V2Z4uGyKxNrWhRcmx6op5QQWXVUd79ThzzxfGnsSXoRfbMuzSVHXtHpkGM2rakJop2ps
 r+MRnggm2DO5X7qNgRisW4HfcTg9+7OGitp0aJ/sbYvWTrdqu7rYUKFdDm4Wrs2x726x
 7xN4JQ0lQ16D81m8ANv/35tPtXPoCTKT1Bvc4ES59FsNh371mxjxXcFzuTZy+9sHNloD
 bxKJLiO4PEq6O1d6L7pSLyrNzbkR2Nu+zsDiKGRuQHg0fDHoukywIupydUf41rLk3E6O
 04SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940338; x=1722545138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C9ZIgLBY2XnIbIK9fr9v41CY3z5s1kiYpWDyp+lFXSs=;
 b=gZ321Rln6jTs8IM4KajUhsZzcAZ/l7p8Nx2yEbGrIT+wiHoXKA/6wsTdUXgdSHS0C/
 4A5gdxjv6aaR2zp5Y/F5D4NpTlekraUlDMvItvQAg4ffVxumf/6YVgJMUvipAQcCv1y2
 eG/0oexbYAglvWe1yh6x77C8fMji2uhp9HR/w+Wt8zN+d6ohDtpmLb0CvqTFq1wJ6i+M
 r4uKD/2rjfr9jExbkRpTPwmwmxwPPJtyr3d/rd5gJuICerb4pifvqknM1rVpLBvD+Xxt
 fTnhaRLREybxymNJkjlylzqMHlk/nAd4LGByMAKNCAbL7E3ZHqOxq/6GWxJCi5Ty5g6p
 +xWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6lUYit84OLTgWM095kmT11R3+islUMM/Gh5HZdX/d7OoID1PSvzWyJtY0obopTEt0Vqoe1XJR5ownIV+d8xwgjCKg+w==
X-Gm-Message-State: AOJu0YyELh5TssKH6hqaVbDGf4DfOrb6+lIl32Ia1/nk7oZYJ/o7f6R0
 v65yPFqw/u/JGpGsfTYyonpVKSL2oOkTL8jnF88WLkPri8ToWF/1qt9Hp5k3ubE=
X-Google-Smtp-Source: AGHT+IFWfyHyovI4cFSsuPXU6DqYuP0siWIABMtxYCTIpYmcdfO4UMD+cHjs/pHYY31nTpwsGffNgg==
X-Received: by 2002:a05:6830:601c:b0:707:1794:6ec1 with SMTP id
 46e09a7af769-7092e6ff277mr5197675a34.20.1721940338268; 
 Thu, 25 Jul 2024 13:45:38 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7093070671fsm458214a34.21.2024.07.25.13.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:38 -0700 (PDT)
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
Subject: [PATCH v4 23/38] mmc: exynos_dw_mmc: Read upstream SDR timing
 properties
Date: Thu, 25 Jul 2024 15:45:05 -0500
Message-Id: <20240725204520.18134-24-semen.protsenko@linaro.org>
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

The obsolete "samsung,timing" dts property is now split into
"samsung,dw-mshc-ciu-div" (for holding the internal DW MMC divider
value) and "samsung,dw-mshc-sdr-timing" (for actual timing values) in
upstream Linux kernel. Rework the driver to make use of new properties
instead of the old one. All affected dts files were already updated
accordingly.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v4:
  - (none)

Changes in v3:
  - (none)

Changes in v2:
  - (none)

 drivers/mmc/exynos_dw_mmc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 50d0208b29fd..4108af47e518 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -227,7 +227,7 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 	struct dwmci_exynos_priv_data *priv = dev_get_priv(dev);
 	struct dwmci_host *host = &priv->host;
 	int err = 0;
-	u32 timing[3];
+	u32 div, timing[2];
 
 #ifdef CONFIG_CPU_V7A
 	const void *blob = gd->fdt_blob;
@@ -262,16 +262,16 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 	}
 
 	/* Extract the timing info from the node */
-	err = dev_read_u32_array(dev, "samsung,timing", timing, 3);
+	div = dev_read_u32_default(dev, "samsung,dw-mshc-ciu-div", 0);
+	err = dev_read_u32_array(dev, "samsung,dw-mshc-sdr-timing", timing, 2);
 	if (err) {
-		printf("DWMMC%d: Can't get sdr-timings for devider\n",
-				host->dev_index);
+		printf("DWMMC%d: Can't get sdr-timings\n", host->dev_index);
 		return -EINVAL;
 	}
 
-	priv->sdr_timing = (DWMCI_SET_SAMPLE_CLK(timing[0]) |
-			DWMCI_SET_DRV_CLK(timing[1]) |
-			DWMCI_SET_DIV_RATIO(timing[2]));
+	priv->sdr_timing = DWMCI_SET_SAMPLE_CLK(timing[0]) |
+			   DWMCI_SET_DRV_CLK(timing[1]) |
+			   DWMCI_SET_DIV_RATIO(div);
 
 	/* sdr_timing didn't assigned anything, use the default value */
 	if (!priv->sdr_timing) {
-- 
2.39.2

