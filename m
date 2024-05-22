Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5028FC25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:35:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E16E885CA;
	Thu, 23 May 2024 01:32:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XSIWaJl/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 820EB8852E; Thu, 23 May 2024 01:32:03 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2469A8851F
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3c99e6b8b1fso3638188b6e.1
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420712; x=1717025512; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bCjyQx/0jLeoyYpM8IqEJbONYckgIBxdTVXk9Pljolw=;
 b=XSIWaJl/p1UVz6uPTc/LGM7+xY1xkPQea1I/6hJgxnOZ777ZKWpB6tIEPhqvjroXel
 qhMMMBe3SDcu5RfM/jWKA0oBXGSkUYQronmmuVBCsyuUy/CWe2Vn0smn6I/L5IC1HUbB
 Xw0nDX//z4zNsM16Jz3FoCQ/d1+qb8O1QQ6UdDz2KUzsyO0TQcx5NAGaH/igHPDPMZA+
 W+YirwIrUH6t6YDCimDGYNGngUyLzi0/2Xii0qDNe6Ekwc/bT44yQyLlb8uuKwI3g/VC
 LSsCRkDh+owLx0XYzL1JNmE6hEjdlfYsT/4jn211FmvfNFzeciAD5k25E0Rj2ZOMYF0e
 jizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420712; x=1717025512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bCjyQx/0jLeoyYpM8IqEJbONYckgIBxdTVXk9Pljolw=;
 b=gbMb+vbZu8LaBYtLXTx1WlUfpq+YSCn+GivyEqNnafnlSBLRdslrKP6mGnNF2id5ch
 /DNiN7Cf5G7mgNU2StsLd7PQQyUWZUSDbxe+xEahhwI82M1D9VX1/bD14YNXxfUnP/WX
 QV5qyIdgoezTAHCBWUVM6ZtMc2CjSq6xxKqggDGY6wDRKjygrYXheSW6/Fb12Oqm1SRp
 BC8354w5/GNunxWO9zRhrFjxXlo6S+u66W8neO8EjfTjfPx2L53/nQTs4NJrSScPSf2Z
 oB77TXO0F3W6ztqOwKcAWOLPAa/+75Hh0CFPfZovvuzESoR7p3NNN8jhTaquaXyNuvhz
 I+DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgWA6tWWNjoG10Pi+ESpc56BiXCaI/Ot9I19/Uc+WCnvrsPU1R9kHwWpmmxeNW6lI8iOH7oijMsWVnt5kUQxqGYx2LCg==
X-Gm-Message-State: AOJu0YwR+VSfFZ2rO7ec+1YtJGFiFQOzCnG5Eh1TkfSiys4ZelHiPKnP
 9L+iUtNE6ZqtzSPoVi/Nx8cOfIKHSdvto0brgQQ0QBpSLYY0Lb3Brm8DEI8rs3E=
X-Google-Smtp-Source: AGHT+IEVORujIUeOCF5xTX6/5KjYvDT+TiLj1dHtavbodWqRRgcmkpq+SNinOM8sEjF9m2rtt/YdFw==
X-Received: by 2002:a05:6808:1583:b0:3c9:66af:3a65 with SMTP id
 5614622812f47-3cdb519857amr5408596b6e.14.1716420711838; 
 Wed, 22 May 2024 16:31:51 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3c9a12744a0sm4020731b6e.43.2024.05.22.16.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:31:51 -0700 (PDT)
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
Subject: [PATCH 19/42] mmc: exynos_dw_mmc: Fix obtaining the base address of
 controller
Date: Wed, 22 May 2024 18:31:12 -0500
Message-Id: <20240522233135.26835-20-semen.protsenko@linaro.org>
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

Getting the base address with outdated fdtdec_get_addr() API and further
casting it to (void *) leads to next build warning on ARM64 platforms:

    In function 'exynos_dwmci_get_config':
        warning: cast to pointer from integer of different size
        [-Wint-to-pointer-cast]
            host->ioaddr = (void *)base;

Use livetree API instead (dev_read_addr_ptr()), which handles this
correctly.

Fixes: a082a2dde061 ("EXYNOS5: DWMMC: Added FDT support for DWMMC")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/exynos_dw_mmc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 14cb0c05cb55..1f69e193f601 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -156,7 +156,7 @@ static int exynos_dwmci_get_config(struct udevice *dev, const void *blob,
 				   struct dwmci_exynos_priv_data *priv)
 {
 	int err = 0;
-	u32 base, timing[3];
+	u32 timing[3];
 
 	/* Extract device id for each mmc channel */
 	host->dev_id = pinmux_decode_periph_id(blob, node);
@@ -174,12 +174,11 @@ static int exynos_dwmci_get_config(struct udevice *dev, const void *blob,
 	host->buswidth = fdtdec_get_int(blob, node, "samsung,bus-width", 4);
 
 	/* Set the base address from the device node */
-	base = fdtdec_get_addr(blob, node, "reg");
-	if (!base) {
+	host->ioaddr = dev_read_addr_ptr(dev);
+	if (!host->ioaddr) {
 		printf("DWMMC%d: Can't get base address\n", host->dev_index);
 		return -EINVAL;
 	}
-	host->ioaddr = (void *)base;
 
 	/* Extract the timing info from the node */
 	err =  fdtdec_get_int_array(blob, node, "samsung,timing", timing, 3);
-- 
2.39.2

