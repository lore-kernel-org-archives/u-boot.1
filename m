Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390E5C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:48:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C54368871C;
	Thu, 25 Jul 2024 22:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ibGIwNJ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8784E88403; Thu, 25 Jul 2024 22:45:40 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DED188599
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3db130a872fso195076b6e.2
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940337; x=1722545137; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tDZzEFSNRWDHk7xL6UtbRz9f/m5h3OBvk0iGJDKDqCA=;
 b=ibGIwNJ0szbBS7VC3u0nnoj7voA/NPvsV5Sf167E4DLLSM8/qL3996QZcGETzgnr07
 BxEG0jIRUOgJCm21D53+6PRTR645f1KEoLmkTfh25gHpfKw3CYmPPDk6KuC04EKE2z3u
 3s3MnztZe1AD9qkz0xWM5aujRPkMjFm+mIjX3bPniVKwmdJu+QIgAkdshSV7OJ1evSpl
 B4qQVQ8q/MJ8WFgi9tFg4L1RllMKHTbiriQWCGKMJz5PiHL3iVg/jZn9JB1G1rdu9fLX
 2G8kF9QbORxYV08o6dHKCt7uXeBbXIA7LW2uRaW+/sPCbtphdT34DezH5DW9iWNrXQMu
 xfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940337; x=1722545137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tDZzEFSNRWDHk7xL6UtbRz9f/m5h3OBvk0iGJDKDqCA=;
 b=gukJKVVrEBjL2l/M0z5k5DIUaNKIdvQvAsCXc6/aZ6jQ7TKXrCgRsIv/oBLzH/kKH6
 RIOtWdAvQa+k6n4zAJF5RAwIOj4b5ydjvwwLi0YsUHgADpObdHepZ3zTUCWflsJHuegO
 0Bf4xTLpnFj6pjhpumAismgLinQuvlQ6PgV8szoERIYon2K8b8G/nz7lVNFJ5fKjn10m
 oSnXwlX65RojXukSwClfQgylvwQYa4GgOrOAUy/Rkwh44fgNOTtmeG0wOPeG0yeVMJu9
 26VBZfVLT+P/+l1jHrTbWvdOMFEVxfkq2nxiDh1HuwgF4fG2V56Fd3MWO7tJ2gfRAaWj
 hq+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJgEJtBRhCfZ/IG1xH7mYQqORCKKH/eFUY31R/PnKXgnPFP4tkhf1NYptIbAKfu7ds/oUX4xJ/MbPZB3vpCOF/7GeYjA==
X-Gm-Message-State: AOJu0YzRMNPY0SLrocZX6/c4oYV2Ta/G/YStch+8MioP6NVu9DI4rIQy
 DbsUox1HPL/YYUTSS4mjBJTUtxFVbTK+r0WpVYAVeSx7Do3wkxQQHJp+gnuAx5w=
X-Google-Smtp-Source: AGHT+IG9b8bevZtUUXPwnmtGgXwdoZQx12AX5jWEPtwNiFIKvRrkzZsOLU0MAsAciRH65HJcXWCazQ==
X-Received: by 2002:a05:6808:171c:b0:3da:a793:f116 with SMTP id
 5614622812f47-3db140ecf9fmr3574750b6e.26.1721940336851; 
 Thu, 25 Jul 2024 13:45:36 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db1341dde2sm430303b6e.17.2024.07.25.13.45.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:36 -0700 (PDT)
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
Subject: [PATCH v4 21/38] mmc: exynos_dw_mmc: Use .of_to_plat for device tree
 parsing
Date: Thu, 25 Jul 2024 15:45:03 -0500
Message-Id: <20240725204520.18134-22-semen.protsenko@linaro.org>
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

exynos_dwmci_get_config() is called from the probe function and used to
read data from device tree. Make use of .of_to_plat driver callback
instead, and convert exynos_dwmci_get_config() to match its signature.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
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

