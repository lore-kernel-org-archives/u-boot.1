Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE070C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 18:01:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57166886B6;
	Mon, 22 Jul 2024 19:58:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MnK8Jtpl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9652688645; Mon, 22 Jul 2024 19:58:00 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74AF6884DC
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:57:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3d9234b77dfso2604917b6e.0
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671077; x=1722275877; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y37Oe49jpSOYUz8ibpLrcyDInbVzJikIkqAZ8DtZNaI=;
 b=MnK8JtplByCLqcqoRMWj7vdQgu0A4Q6PsXPKfVL3BB+AoOQupMaiva0EDLGS9Fe8Bh
 xrh97ce6zMsP54a4QeUxuW476Pln1jMz0iLhOQBCiyUBC5T/sPGxNM/ynwIgh0TM1ZLp
 Bl1DZ4dxnFYblFFpeFdQ55wlBX7iwzWwp7QRZ/u7fF1cqRYic94HdMBp+umbZrknsBa1
 b1IAxFDd3YrqCrV/eO87jxmkuI0OdM7qRAzwCCwjRQT9aJM8uVkRQIfPoqWLqHBX5vXG
 HZClqcBL16oVjK9x6MZFGnRHaNytq/vW3W+UMrFs9u0TfcZVZRgtX1ESMe1+XQQyjfV3
 kaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671077; x=1722275877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y37Oe49jpSOYUz8ibpLrcyDInbVzJikIkqAZ8DtZNaI=;
 b=QcUqNYiHY/3KSi8U6vSwnzU2q6pd+1NYVUUp2TDRSNCTzXIZBCKbygS48KvACoWDqs
 Fuy5m7ag0gLmYlnOnqCbK6jqznaOOvPZc3jHW6c7Et4wCLRFZXqgZomgk3C9hbDKcTnC
 P09SMhYBzu9c2gGnFfumZ+sKa0LJZ+FSnW/i3zL7/JIYShN4AISkYsfCg937pWgU7/p+
 EZAV/OfgpgUFtmy4FAgFiiS2eQCg9uaDaxfYjaYG9J6Wrey5dsgM2+9rpbKd/m5FqqMI
 BecybV+w6POGu5MHfvE7FTBx4ubfN3V7BXbeUgAPGArWNTfxuOJXRxtp12LReiqYx6Bv
 S33Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXM9hmbF8qyHziISxZUXokGiwc9Yh1nAWK5f5u+KFt1bHIYI1ga7gagwrJYrl5UpNX08RdPgin4TJjouXMdmg/zVze64A==
X-Gm-Message-State: AOJu0Yx0SbBKVQyWyUk8TG8nnWW0NusohsJENEjqrNYiKeuAwbVzR5wy
 mPzIsKeuUKLQH7Ngces3sXXwsdBDUiS4Mt0sZl/renqc+W3GS+XpBj5N0tnGKXc=
X-Google-Smtp-Source: AGHT+IFwAXyOjpC+9bUd+LSTBl7IZcAxzsGh6jL24hDDk3CE4E/Tj3xqBncoeCk4Vw8esvyIKDC3dg==
X-Received: by 2002:a05:6808:2006:b0:3d9:dc70:1119 with SMTP id
 5614622812f47-3dae97f708amr8441045b6e.46.1721671077180; 
 Mon, 22 Jul 2024 10:57:57 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dae097c6aesm1600548b6e.18.2024.07.22.10.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:57:56 -0700 (PDT)
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
Subject: [PATCH v3 21/38] mmc: exynos_dw_mmc: Use .of_to_plat for device tree
 parsing
Date: Mon, 22 Jul 2024 12:57:23 -0500
Message-Id: <20240722175740.6985-22-semen.protsenko@linaro.org>
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

exynos_dwmci_get_config() is called from the probe function and used to
read data from device tree. Make use of .of_to_plat driver callback
instead, and convert exynos_dwmci_get_config() to match its signature.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
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

