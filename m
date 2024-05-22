Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E43C25B7C
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:36:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9361C88579;
	Thu, 23 May 2024 01:32:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lfqNk+4n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A358C8852E; Thu, 23 May 2024 01:32:03 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1343E8857F
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:31:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6f7c661d597so158161a34.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420717; x=1717025517; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wJXQMBfuIQqS0GoSfwIGNelhLpODn13dbr4qe3xr8Fs=;
 b=lfqNk+4nFP95+ZTFAX1UJ/bXLZIYORG8iQjNZiagWq9yKpdhQMOx2c0rvMKVoxxAVR
 72J3QEqRK0MQZaLVKv2Z6XI4d2AU0uHQjsYQp78ac9qiG/Q2PhWAiKyb3nxyW9+QSpBF
 OLqaBk6i4D/vr8BfiPPbeEVRQmAtXwS8lASWcVMRAgCo4fJHna2gkzUgRi0w4taePxir
 J19NM9v0fwLRFN1MwtwUoea+Ezkwlldwtda6fXAXanwkysPTMGr82gfnYR3J/BY42hFI
 78UB7SeS0+BSDiVg/0+0gDyjZvkc3G1Zv1+CcWlITxrOdpqrt9MuLPtfHCAjjpFRjzOv
 SqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420717; x=1717025517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wJXQMBfuIQqS0GoSfwIGNelhLpODn13dbr4qe3xr8Fs=;
 b=c5UHPDVwlT0HZAVnvszakTxfG5t7Lo9RE3uCNPZRHMLgfWVw3wVvcx83/p+B9PvBR/
 dGApltAZQHeLbdjHtfzesUByp8kpGiDkPxkFOjB+uDTBps6gJljxJe3ATkdMG9QPc9a8
 YCWH9dQhZyKVq5zVkS5mMSsCyHnxL5jfgbXi6agrsRYLLZbmdGD0Qfg1Vhq52sLw39FJ
 oL4ThSYDACIw1IjennUqj8S7twwttlD3op0RYpS++RFMSweD2nvpAk9b6rjDwTD4Jh4h
 j9qidDzNF09Cu1d0eTozMmSuT65vfcVPMhcnBLIUss9sBmO7UFZkBpVnmS+qienMYY6a
 Nyqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+wTV7M4EqQcM2aiIr4VdpLHzucJ9tufiWZpQO4xChL102vR4ExToA7348PShNal5UxOhYllUP7KzRgxHEGb2BroUoTA==
X-Gm-Message-State: AOJu0YyZfhPgP5B9mvEyrofEb3Z1gbRFdjAcVCP0pKMjgYZX9c7AkIJx
 fwSJgyE0uNQk5/cTaeOa9yH4nTy7Ctw0KxZzBHbWDCwjGPb86JNLXnLRuEDXPvY=
X-Google-Smtp-Source: AGHT+IF8oLtzYSxA/ty5e0OZdemof2JKYbPf6xyw4XDXbTDbKfYXTHhq0c3UmvLz+0idCZhUcCeHmw==
X-Received: by 2002:a05:6870:f102:b0:245:4299:8b6a with SMTP id
 586e51a60fabf-24c8382adeamr350803fac.24.1716420716803; 
 Wed, 22 May 2024 16:31:56 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-24c6a000bbfsm556631fac.54.2024.05.22.16.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:31:56 -0700 (PDT)
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
Subject: [PATCH 23/42] mmc: exynos_dw_mmc: Use .of_to_plat for device tree
 parsing
Date: Wed, 22 May 2024 18:31:16 -0500
Message-Id: <20240522233135.26835-24-semen.protsenko@linaro.org>
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

exynos_dwmci_get_config() is called from the probe function and used to
read data from device tree. Make use of .of_to_plat driver callback
instead, and convert exynos_dwmci_get_config() to match its signature.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/exynos_dw_mmc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 8a3f73e3739c..34485311c107 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -224,10 +224,12 @@ static int do_dwmci_init(struct dwmci_host *host)
 	return exynos_dwmci_core_init(host);
 }
 
-static int exynos_dwmci_get_config(struct udevice *dev, const void *blob,
-				   int node, struct dwmci_host *host,
-				   struct dwmci_exynos_priv_data *priv)
+static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 {
+	const void *blob = gd->fdt_blob;
+	struct dwmci_exynos_priv_data *priv = dev_get_priv(dev);
+	struct dwmci_host *host = &priv->host;
+	int node = dev_of_offset(dev);
 	int err = 0;
 	u32 timing[3];
 
@@ -302,10 +304,6 @@ static int exynos_dwmmc_probe(struct udevice *dev)
 		return err;
 #endif
 
-	err = exynos_dwmci_get_config(dev, gd->fdt_blob, dev_of_offset(dev),
-				      host, priv);
-	if (err)
-		return err;
 	err = do_dwmci_init(host);
 	if (err)
 		return err;
@@ -336,6 +334,7 @@ U_BOOT_DRIVER(exynos_dwmmc_drv) = {
 	.name		= "exynos_dwmmc",
 	.id		= UCLASS_MMC,
 	.of_match	= exynos_dwmmc_ids,
+	.of_to_plat	= exynos_dwmmc_of_to_plat,
 	.bind		= exynos_dwmmc_bind,
 	.ops		= &dm_dwmci_ops,
 	.probe		= exynos_dwmmc_probe,
-- 
2.39.2

