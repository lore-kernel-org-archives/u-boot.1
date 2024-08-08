Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB39FC52D6F
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 03:18:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F3D188BB4;
	Thu,  8 Aug 2024 05:15:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LTh/Ngcy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CFC68873C; Thu,  8 Aug 2024 05:15:05 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E574988AE0
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 05:15:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3db16129143so366302b6e.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 20:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723086900; x=1723691700; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sgGukJlNcf0K2Z5Fvf+KW1N0Z6A0j+D44vCIr+vTCLw=;
 b=LTh/Ngcy7ysNebxg0QgMXCb0nSYslRPxuOz8GNXbc+icnFkwLUBUcHYDR5cnUSexez
 uaD7i6tmHVqcj6Mwc47kGw87x9pxRWx6WWTJ6IPTIpssYl5rvx62labta6w/a3pths3B
 fGK0A0YL0yh3h/uKTUh6cGKdjB3N53bqr6ikP7jgLLElPGjFOCrpnrIbieGKx8TYimwM
 Ywnw7xMvVCM97S1FmK2Te+9pP5mbOeHBs0pizAysm3sRPBueviAfNmf1TBWWOBdV7jlg
 WasDERjmwARG+JIuMnkjiszapXjZ031Z1SGqBNV7LFFAXnCI9J8QQHet+PqzKSiBMr/0
 c5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723086900; x=1723691700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sgGukJlNcf0K2Z5Fvf+KW1N0Z6A0j+D44vCIr+vTCLw=;
 b=rTPKnJ4wSmR17YE0H2mc7pEmspIEvMVtL3cKBcWVLEuE3Qtpc+QKM7M6ZyxsE17bO/
 OJAyvjEHI8GPlWR7skBH4dpkXnosptD5lLz1/Y/4x4X+R73WwiIWUef+5LGGhbw1sfTP
 NMXPJyNJtSha4JM+7drNMXJLCaLqYClSHGmeKQVM3vV9BP1J1Cg0Jq/+AV8UHsJbymKx
 ikc4zGKBKHpqoskx7MVi3sNeEd8ZEWtwyrHlUpD5F5gaSwZKyJAgW7r+txJT0Iw87Nqg
 yoOBRRgtHKa00/RKgtkKP5V+D4UjpbFLmHjq+5873aN8Z6khG8Ph6BpeumtAveigxDZh
 scnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDpMQKKCielbTzsr3zWyoHwfEFVTaCUjMaUsYymeQNyKJqsIugxNQzLRgH1LmnZwxmsSH5kZPDhhtJk4kLr1G7jPiZ3Q==
X-Gm-Message-State: AOJu0YwM7RGy2/0h5KdEkA3ArN+YqVzVl1vnM5HBRBwZJdBupJ0wpiwc
 +76yJ5PbAAt+ubo+hY/6WVudOW4wW7M20wDyXPHKg5rujsKW7XtMxoNNbZPLF4U=
X-Google-Smtp-Source: AGHT+IHMAKbEBb60VZearBqAbk11bmeNKPeYVJgPAETbdeRqo0D0hQ5bPiFxkn1hvtOuz25GlLqH7A==
X-Received: by 2002:a05:6808:13d2:b0:3d9:2b24:5b2 with SMTP id
 5614622812f47-3dc3b1c4ad0mr744092b6e.0.1723086900335; 
 Wed, 07 Aug 2024 20:15:00 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db56361b99sm4612825b6e.11.2024.08.07.20.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 20:15:00 -0700 (PDT)
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
Subject: [PATCH v5 21/38] mmc: exynos_dw_mmc: Use .of_to_plat for device tree
 parsing
Date: Wed,  7 Aug 2024 22:14:27 -0500
Message-Id: <20240808031444.9619-22-semen.protsenko@linaro.org>
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

exynos_dwmci_get_config() is called from the probe function and used to
read data from device tree. Make use of .of_to_plat driver callback
instead, and convert exynos_dwmci_get_config() to match its signature.

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

 drivers/mmc/exynos_dw_mmc.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 4d28ede0d756..09a59fdf0120 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -223,10 +223,13 @@ static int do_dwmci_init(struct dwmci_host *host)
 	return exynos_dwmci_core_init(host);
 }
 
-static int exynos_dwmci_get_config(struct udevice *dev, const void *blob,
-				   int node, struct dwmci_host *host,
-				   struct dwmci_exynos_priv_data *priv)
+#ifdef CONFIG_DM_MMC
+static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 {
+	const void *blob = gd->fdt_blob;
+	struct dwmci_exynos_priv_data *priv = dev_get_priv(dev);
+	struct dwmci_host *host = &priv->host;
+	int node = dev_of_offset(dev);
 	int err = 0;
 	u32 timing[3];
 
@@ -286,7 +289,6 @@ static int exynos_dwmci_get_config(struct udevice *dev, const void *blob,
 	return 0;
 }
 
-#ifdef CONFIG_DM_MMC
 static int exynos_dwmmc_probe(struct udevice *dev)
 {
 	struct exynos_mmc_plat *plat = dev_get_plat(dev);
@@ -301,10 +303,6 @@ static int exynos_dwmmc_probe(struct udevice *dev)
 		return err;
 #endif
 
-	err = exynos_dwmci_get_config(dev, gd->fdt_blob, dev_of_offset(dev),
-				      host, priv);
-	if (err)
-		return err;
 	err = do_dwmci_init(host);
 	if (err)
 		return err;
@@ -335,6 +333,7 @@ U_BOOT_DRIVER(exynos_dwmmc_drv) = {
 	.name		= "exynos_dwmmc",
 	.id		= UCLASS_MMC,
 	.of_match	= exynos_dwmmc_ids,
+	.of_to_plat	= exynos_dwmmc_of_to_plat,
 	.bind		= exynos_dwmmc_bind,
 	.ops		= &dm_dwmci_ops,
 	.probe		= exynos_dwmmc_probe,
-- 
2.39.2

