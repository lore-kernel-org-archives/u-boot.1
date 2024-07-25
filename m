Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6E4C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:48:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F07CB8863C;
	Thu, 25 Jul 2024 22:45:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L8KxWYhZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08DF88860C; Thu, 25 Jul 2024 22:45:38 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7633088403
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-260e6298635so299979fac.1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940334; x=1722545134; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lsJbcyCvg89puDca1y77AVKb4GyP0NkPuWZdHw+/E+Y=;
 b=L8KxWYhZIGiASGM0OblrQuoxvgeFIzBmXglOZ2i0u6COu+6nZ4ezSbO0nD35njunjf
 y4r4SLJAV/C9dIBB46yh5Chh2pvTMMpUjNouKmU2lGAPM+EGkgSYwLI9QE2bXZmiIBoq
 axmatO9FFpBqfs9X3n9oayubdmy53ko9OwnkrqwjX2LazHgnADMwBBCtNI5gJXR76fg1
 DrJifbs9N1l4N8hzkrZU5ZwESjJtnKptDTkPdgvYi8pCI9T2aEv9L/+nq3K+afUxvl7m
 Gwi3dSWHl937YpIQ9d8dykI1PRP5FLoqW2kf2TNoxdgg6oubjbmbvrmLkt0JqdIcecFn
 hW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940334; x=1722545134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lsJbcyCvg89puDca1y77AVKb4GyP0NkPuWZdHw+/E+Y=;
 b=acwMQCOAO3c0JcXwVHuAxGqocQi2mOGR8v3Anz7n+nS9gc4bcXfBoHWgInxaX7t3f/
 cJFRgobXKp/Kfhb1lE907vpU3D7v3oOSD1KIJ5MwTVLB/uA8ZADnJT/jhWaaBkpoPY2y
 bntiOyMmhLthgxR6B3qsdfEAWQvri5L6QnLffK832qPU1axHazlaxBNhm/o4ZWgxTeiR
 0L6Lj/6ck6WciGZXfKYGaWmsBbQy1RiUoKQspIAym/XglaBo9ZKIee1llhjzdvLZkwxy
 iPm6iBWy970xoUcorVjmRM8N3a6tNoKh63TjvNOygF0Mpg9qkPh3rSRiCtq/+5edqNX2
 YkVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrPYo9ksLsBNeEbnRvl9yTDdSh26Au6K09DbhzbHwy2yC2Fe62iOMG4+1xFpIVB+rrE10i7eSiRRk5RzaA+qe8tPPvSA==
X-Gm-Message-State: AOJu0YwXsMNgfvpgRJvExtJ5PIkTxv7JQHKEGWM15LrpGxztjVh4ciAt
 UScZ6vIkHmDscbMF/IFgra/csVufWNiHiE+3UnIC0/5qji4fHRambS9ApJhRjSs=
X-Google-Smtp-Source: AGHT+IGEtWHUERsDbifKCRhrbPhTC67Hh5arZqSwNdY50rp7BzYKSKi1uxMELJz4FhnkH6Fb9jYctg==
X-Received: by 2002:a05:6870:3a27:b0:261:184f:4ef1 with SMTP id
 586e51a60fabf-2648e8ebaafmr2413298fac.15.1721940334044; 
 Thu, 25 Jul 2024 13:45:34 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7093070671fsm458194a34.21.2024.07.25.13.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:33 -0700 (PDT)
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
Subject: [PATCH v4 17/38] mmc: exynos_dw_mmc: Fix obtaining the base address
 of controller
Date: Thu, 25 Jul 2024 15:44:59 -0500
Message-Id: <20240725204520.18134-18-semen.protsenko@linaro.org>
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
Changes in v4:
  - (none)

Changes in v3:
  - (none)

Changes in v2:
  - (none)

 drivers/mmc/exynos_dw_mmc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 377c9e6d90b9..a86d58663c1b 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -155,7 +155,7 @@ static int exynos_dwmci_get_config(struct udevice *dev, const void *blob,
 				   struct dwmci_exynos_priv_data *priv)
 {
 	int err = 0;
-	u32 base, timing[3];
+	u32 timing[3];
 
 	/* Extract device id for each mmc channel */
 	host->dev_id = pinmux_decode_periph_id(blob, node);
@@ -173,12 +173,11 @@ static int exynos_dwmci_get_config(struct udevice *dev, const void *blob,
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

