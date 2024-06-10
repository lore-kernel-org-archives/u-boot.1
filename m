Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1762DC27C53
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:16:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9507B8854B;
	Mon, 10 Jun 2024 03:12:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e/F6COw2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A17988528; Mon, 10 Jun 2024 03:12:48 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7BBF88477
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-254a370e7a4so484736fac.1
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981964; x=1718586764; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TWuiRkwYfnSkNX7yMTQMOdsupA1/S3nuefRl1iclhSw=;
 b=e/F6COw2Fuu322EE88hoV4i3zpO6HUOr4/C1rGyumbAY6FPSlqWe0YNukPuP1+Ezg4
 F3bCr0FYagDU0nfm58usYf9M+TWV3SzfMCYosn+MJHWdK+OAqK5jSdvwr3YnYNbatMoc
 MZ56WkeR3WsNGn0a3QzmZ2vHRz3v800i2I6kGoigGsVUVsWECZsM0ahOjsAq3tV6PgQ0
 OQ7zaRUrzKrUH2Ke46nxMxZLL+1O5z50pM4AWiBQJJ6F9UDXqjdfC6WAQ9DflBanqLIT
 LPLdnKq79ePpYVTFyCJh+eIqIFN3+oP5aOPXFTA1d4N6mxzflGEIHLbC/rrDYaTYT1Gn
 JpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981964; x=1718586764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TWuiRkwYfnSkNX7yMTQMOdsupA1/S3nuefRl1iclhSw=;
 b=SueNbweKAdSdl3AWYb6S0gOKCJLLRwj9Kwyg+Xe96zAui6vnLt9zmiF07y/cTAUnHl
 4OcK7m/GemCdif4YdXV068qMwr8Ef/ir0jcSOnXSDavq6sdE05VVH+vF0+KlyaHsFsql
 wkEtixRBxRug07efqlROqNGjNYYOuvi2cyKRclwUKt+jQGhZ/jNFRsFgpHVMbLgtWyMS
 arqYNJ75bmtJEQcgbC8CP+s5IkeOS/zp6RIw08cyXV6gnplRKfItylU9opdAbMhwayC7
 tuJnPgpYaAn1D9uIqal4xlp6WIzFCZvmKjp8FFeuD2U4NwFwTdJsYb9SxlVasdhBINR/
 2b1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2bVd3cPeD4b5DFKhN6ekv2KOAVHjxk9+HcCG/G9IDEteWaIQI8MX2mR9UvxfPicwARaEt7tqblOr9iU5HO8ZUaMoDiw==
X-Gm-Message-State: AOJu0Yxx6vU7zeyQF44WIYdK9wp4qMgtYnQ0ttRfG+c1bCzSicLAaXZ0
 QCRgQdZ/s1MAp2iTYNTTwmPqofuHyovZMBS7owMtyGfhEvE2Bfufwg96xbw/bHg=
X-Google-Smtp-Source: AGHT+IGPs59jpiyBHqYSgsvVgLK6gWvHMEqSPhN3ERAgVWMV2NWqMqKI9u3d8K8dlF9HP7M+RoAPQw==
X-Received: by 2002:a05:6870:4710:b0:254:ae7b:28ab with SMTP id
 586e51a60fabf-254ae7b2addmr1575360fac.13.1717981964440; 
 Sun, 09 Jun 2024 18:12:44 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-254b17368b2sm615173fac.4.2024.06.09.18.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:44 -0700 (PDT)
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
Subject: [PATCH v2 24/40] mmc: exynos_dw_mmc: Read upstream SDR timing
 properties
Date: Sun,  9 Jun 2024 20:12:10 -0500
Message-Id: <20240610011226.4050-25-semen.protsenko@linaro.org>
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

The obsolete "samsung,timing" dts property is now split into
"samsung,dw-mshc-ciu-div" (for holding the internal DW MMC divider
value) and "samsung,dw-mshc-sdr-timing" (for actual timing values) in
upstream Linux kernel. Rework the driver to make use of new properties
instead of the old one. All affected dts files were already updated
accordingly.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/exynos_dw_mmc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index eb2d2d204def..a6e4d76fb25a 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -228,7 +228,7 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 	struct dwmci_exynos_priv_data *priv = dev_get_priv(dev);
 	struct dwmci_host *host = &priv->host;
 	int err = 0;
-	u32 timing[3];
+	u32 div, timing[2];
 
 #ifdef CONFIG_CPU_V7A
 	const void *blob = gd->fdt_blob;
@@ -263,16 +263,16 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
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

