Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8A2C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 18:01:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0029886F9;
	Mon, 22 Jul 2024 19:58:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K6c8z6aH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A7F588680; Mon, 22 Jul 2024 19:58:01 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2816B885B6
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:57:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5d569bee00aso1210270eaf.1
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671078; x=1722275878; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/b5CybBjcPiiP7smg/py0/KgdE7Vq4Zga0bVxyrVDvQ=;
 b=K6c8z6aHp4wwr87E5DnKPoOoCPRE8H/zKtxbx3qqPN0jcS93i65ctBddzruyGlM1MR
 H8cOvdNCEkCCT4hGhghjDfJiqsbevtHrM6RXLSl5huMThLXQq+fjI7upE7EGRn9OTE+a
 JsmvQ4xcokbh13WGDXjNmN/0j0FlWxCF1aTEcmDlOREmLVd4kavPH5XXMC4B9ekZ1X4o
 aTRB7mH+0OOd9l4sFbuBOzTZEyuIbSg1T9hAo+KL2Tk9ANtJ7N3DSZPzs5MRifL0Aghr
 GdzNUJ3m3JYbIVLXgvETCjvOver3TY1phc3W5Ep5bGxhmUWoM3R2XWmzxrVmnOX3pztN
 OUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671078; x=1722275878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/b5CybBjcPiiP7smg/py0/KgdE7Vq4Zga0bVxyrVDvQ=;
 b=vxbEOW1WFqfr/IHP/0PsmuWlMc/Cw4GXl0NYaKmVyYMg4y9F7uoRMxvYMpEH4DdLiB
 MoMVKJ2OvF359pBY4pZCCcd3ETJQYEbchLtiOP1Gcp58dmZnCrYnHEhlf0CijSttncWx
 gQFQNHB49rU1I4TG0JpMGjmkE/Kd5FdLbvmGKxdsH2FYwhey8cSQr/Y+jR814dVp5qZ/
 Ivmew5iZyvlRWOC1nPqgyO5n89WrLt9EfHMvVq3at3iPfpN2faaDzD0N9s97XaQmsuWX
 IfcIMsIpoTv1BF5yJUMUMihHnfdCLxEqzdUoYEOAjY9CepcA2YyylA2heorF4ObJLg1A
 oWGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz1++e1rWTiBCjaYuAPVCV21S+CA4rCthKm6g7PbfKc4zz0gijkki2eyTfr39Fzs8l9Glc9ARIDNwCF0WYvBN52mpGig==
X-Gm-Message-State: AOJu0Yx1s2DVaF8vSwkAZ8dmTbVQAkpYz2nIDF734i+sCNrxwYYt/IK2
 SZWuXhsJ5aLztOn0JTsv1JVDMXyneCLXow59OmN9vSj85h+pgUdxg3v7fYNBfr4=
X-Google-Smtp-Source: AGHT+IGcmSG8PCn47755EFhHm1S815ZTNMQeAc/MbMAWZ36dxspyGh8oaz5qi9k+PnVM8pZw/68LJA==
X-Received: by 2002:a05:6820:88f:b0:5ca:581e:d604 with SMTP id
 006d021491bc7-5d564eab6b3mr10090529eaf.2.1721671077841; 
 Mon, 22 Jul 2024 10:57:57 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d55a831d85sm1405389eaf.18.2024.07.22.10.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:57:57 -0700 (PDT)
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
Subject: [PATCH v3 22/38] mmc: exynos_dw_mmc: Convert to use livetree API
Date: Mon, 22 Jul 2024 12:57:24 -0500
Message-Id: <20240722175740.6985-23-semen.protsenko@linaro.org>
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

Update the driver to use livetree API instead of FDT one.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - (none)

Changes in v2:
  - Moved exynos_dwmmc_of_to_plat() under #ifdef CONFIG_DM_MMC stanza

 drivers/mmc/exynos_dw_mmc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 09a59fdf0120..50d0208b29fd 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -6,9 +6,7 @@
 
 #include <clk.h>
 #include <dwmmc.h>
-#include <fdtdec.h>
 #include <asm/global_data.h>
-#include <linux/libfdt.h>
 #include <malloc.h>
 #include <errno.h>
 #include <asm/arch/dwmmc.h>
@@ -226,18 +224,19 @@ static int do_dwmci_init(struct dwmci_host *host)
 #ifdef CONFIG_DM_MMC
 static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 {
-	const void *blob = gd->fdt_blob;
 	struct dwmci_exynos_priv_data *priv = dev_get_priv(dev);
 	struct dwmci_host *host = &priv->host;
-	int node = dev_of_offset(dev);
 	int err = 0;
 	u32 timing[3];
 
 #ifdef CONFIG_CPU_V7A
+	const void *blob = gd->fdt_blob;
+	int node = dev_of_offset(dev);
+
 	/* Extract device id for each mmc channel */
 	host->dev_id = pinmux_decode_periph_id(blob, node);
 
-	host->dev_index = fdtdec_get_int(blob, node, "index", host->dev_id);
+	host->dev_index = dev_read_u32_default(dev, "index", host->dev_id);
 	if (host->dev_index == host->dev_id)
 		host->dev_index = host->dev_id - PERIPH_ID_SDMMC0;
 
@@ -253,7 +252,7 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 #endif
 
 	/* Get the bus width from the device node (Default is 4bit buswidth) */
-	host->buswidth = fdtdec_get_int(blob, node, "samsung,bus-width", 4);
+	host->buswidth = dev_read_u32_default(dev, "samsung,bus-width", 4);
 
 	/* Set the base address from the device node */
 	host->ioaddr = dev_read_addr_ptr(dev);
@@ -263,7 +262,7 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 	}
 
 	/* Extract the timing info from the node */
-	err =  fdtdec_get_int_array(blob, node, "samsung,timing", timing, 3);
+	err = dev_read_u32_array(dev, "samsung,timing", timing, 3);
 	if (err) {
 		printf("DWMMC%d: Can't get sdr-timings for devider\n",
 				host->dev_index);
@@ -283,8 +282,8 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 	}
 
 	host->fifo_depth = dev_read_u32_default(dev, "fifo-depth", 0);
-	host->bus_hz = fdtdec_get_int(blob, node, "bus_hz", 0);
-	host->div = fdtdec_get_int(blob, node, "div", 0);
+	host->bus_hz = dev_read_u32_default(dev, "bus_hz", 0);
+	host->div = dev_read_u32_default(dev, "div", 0);
 
 	return 0;
 }
-- 
2.39.2

