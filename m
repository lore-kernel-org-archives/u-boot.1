Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DF0C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 03:19:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8A5288BC1;
	Thu,  8 Aug 2024 05:15:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ou1hRH3t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA91288B48; Thu,  8 Aug 2024 05:15:06 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D3F788A87
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 05:15:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3db23a60850so379696b6e.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 20:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723086902; x=1723691702; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=invefIoNeSGS3tiUpl+43dNdH+yHeDxghKAHCOxtGnQ=;
 b=ou1hRH3tJKCvZZ0vQ0XHexOVkzhUUtgpObdBXs1MnOb1TcdbQqM6t7zh9gwh7Pb7Yu
 hSPJ4LUUlhLDNUgCAuGqoteOIMrx67fmJRxoQJAYrQZ1jcaoAA6P4Fdnin+77/qJzOiG
 0TNv8cgamtJnsMDjekk+Bj6tGV8gW6u8P4S20gUGpgwiEO4+1xfPZChiEOERVyeLEXf5
 WuqJlXltiIl6mpwHq9oL88FidBqAbmscBKLCsxvdUWDv/fEVHYPGxQ15FquW/q9fjcbM
 amTdFWj80YvH3/vHaMjifjG1B0ciEapohe77+buvhUDdwLxgaQSSky/43Y/nouLVpmQX
 ihig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723086902; x=1723691702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=invefIoNeSGS3tiUpl+43dNdH+yHeDxghKAHCOxtGnQ=;
 b=NXVjTAUODnsm0deh5MmR/2xqHyO0T0W+YL/g20WJtlM6byW7/NdzjGRpwMJ+tns36I
 u3SYFhLAw9zwoBqYp454++5rfe2sNh803n8PzE884dqNX+wswV/WBZ+8PE6Qux78iVwY
 FfH1O1f1rnoz0AZGxfHT/oieDMrk44k3ukuWJTRqmapmiqwGaboq1MciBBg4cgESjisZ
 vsfyWtZD4Rfc0n1x/6/FSZOc7QZDnutLtq4wrmVIz+CkIEyUBHCcoL/6rbR93UMTY7UU
 bbZWOcUem9nhrCsQ6AVCXZpp2z/1BCUqCHjpLDvwa3OnxqTgJtvztAB1911Aj624Gq1a
 3uEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoXueGquHeBwUB63+qV2gGSIpk/yf/zrnFYmzk+qbMqdvMUrIaSqCasiEL9/RvUyVUqxVrrieKEPzknxeVDPF90OuGRw==
X-Gm-Message-State: AOJu0Yx+rtKngx3NcVwXzoilKwBymMCq1cGmBWuXFyrNwaAwU1s+rkyQ
 gk2cY3hLvjlvZOv2Y4+nLEADxhRKzeRC0RL/wirI82Dg2VGo7hjpZL/2zS1R2dc=
X-Google-Smtp-Source: AGHT+IFvjwS5MshbHskbAAoylSDJW6El0J3uwSJnYHz+gAx8n9DTliTQLDobsoc4G07TAPmbRhYqdQ==
X-Received: by 2002:a05:6808:2396:b0:3dc:1720:ffb3 with SMTP id
 5614622812f47-3dc3b4266a0mr687420b6e.23.1723086901752; 
 Wed, 07 Aug 2024 20:15:01 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db5637b600sm4663880b6e.33.2024.08.07.20.15.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 20:15:01 -0700 (PDT)
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
Subject: [PATCH v5 23/38] mmc: exynos_dw_mmc: Read upstream SDR timing
 properties
Date: Wed,  7 Aug 2024 22:14:29 -0500
Message-Id: <20240808031444.9619-24-semen.protsenko@linaro.org>
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

The obsolete "samsung,timing" dts property is now split into
"samsung,dw-mshc-ciu-div" (for holding the internal DW MMC divider
value) and "samsung,dw-mshc-sdr-timing" (for actual timing values) in
upstream Linux kernel. Rework the driver to make use of new properties
instead of the old one. All affected dts files were already updated
accordingly.

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

