Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D116C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:15:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE8E28850B;
	Mon, 10 Jun 2024 03:12:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wna+KWkr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D52A884FC; Mon, 10 Jun 2024 03:12:44 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 482EA88489
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6f971cb3c9cso824252a34.1
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981960; x=1718586760; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bCjyQx/0jLeoyYpM8IqEJbONYckgIBxdTVXk9Pljolw=;
 b=wna+KWkrWcTjK35R6v8trTsTmg078Kzev3XZWjbtvL7YlFxHy1A/Ad4BMNfylVPozx
 dZZI6rWPCnbo0hapH+YSx/xT6YmAofYGVluCSDpWceZfRgIxfai//bWpOJrj2nBKio9e
 htG17SAgIUxCqa1wORc6HQ4hQOaKuOl1jVJvDyQ60sWKPnv1fQSCaCHQjGn2Xjx+Rvfw
 WXCukQqvTPaUb8jKkp3dTIOcjby5nMmNCaZKfHULU7OEy/aBrgUrq0RW3MP8iFEOtmrb
 3E8cMd6FncosD6koikmcqV7zuPyFVRegk3RXdWi8zyfsPzdCuB7RsQzDuFyiUTN6NmDx
 T0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981960; x=1718586760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bCjyQx/0jLeoyYpM8IqEJbONYckgIBxdTVXk9Pljolw=;
 b=AmHQJgTKmLnWWoCXjIbn70hBlGHHkkJpPF2DcNFLfxQL/JUOsgioDwqK7IKBOPki7O
 hLbBLPpgPB8UxKA9XhnMLlqB/beq43sYdOIRSwPgns40M+nMWQaOR43h3l98KBR/G4rD
 Wm1C7E2+xHXOpwmRUC7c9IJEmJiMOmUo1opudVq1189InOSKoL6q2+hFl6fqnAQ6SwWN
 i/Kr8ZoyWKblgFXA3OO5Q1CjFetFPTUP7Vle+SYaBcCaRi6MrzdLhBv/VKttONdoXIwO
 RGcx8WU2MXAL/7U9cNJv4Uf5D6d45HZGcvw+/GkyvGNk2kgetLd26X7QPgqwOS0OuM6G
 SIEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBQ+vltC8IXkKsMib5Vrq/ibp7Br0/zT8Wevjnhfjt+shw0kF1GvSDl5iG79RBeCeb9C+LduB7lwlzh24ARi/g5Jt6eA==
X-Gm-Message-State: AOJu0YwqFfYTCaYq9CLlA1nzCGf9+pkWH34aB3wbasqciH5abzoNiG7H
 W+HqcayFoQAPNeDPG+gz0G68dVy1HT2JOfMQvT7StAIPceG3ALcfddVxzJmKwQ0=
X-Google-Smtp-Source: AGHT+IEzAIIuyF5cv3MK+H2hIAUqqd2ZdswMo+Gmeu0ZFs1b59PzG9WjYAyxOGpIjXJBTeVgHehUUw==
X-Received: by 2002:a9d:6a44:0:b0:6f9:80a2:c4de with SMTP id
 46e09a7af769-6f980a2c5f8mr4775853a34.32.1717981960018; 
 Sun, 09 Jun 2024 18:12:40 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f977ccd4aasm735991a34.65.2024.06.09.18.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:39 -0700 (PDT)
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
Subject: [PATCH v2 18/40] mmc: exynos_dw_mmc: Fix obtaining the base address
 of controller
Date: Sun,  9 Jun 2024 20:12:04 -0500
Message-Id: <20240610011226.4050-19-semen.protsenko@linaro.org>
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

