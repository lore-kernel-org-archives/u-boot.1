Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20803C52D6F
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 03:18:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30A5488B8E;
	Thu,  8 Aug 2024 05:15:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OfsbG1QR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DBEC88A7A; Thu,  8 Aug 2024 05:15:03 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D92F88AFF
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 05:15:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-261112c303bso388187fac.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 20:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723086897; x=1723691697; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W/Opz58k2M9Rm+jtv1QysddzT+5tlN71aNOiKrAKmsI=;
 b=OfsbG1QR8b2P9lNFp5eO5ziF6500ld4jBXmlrUgn951cTS9hi8jyh+AmjtC13T54vH
 ZuTcopshwkMxYmvwR3GqC9/vwvIiZzsT9nG4VD50vZh3pJPpYZFUk/Q3msaNFjdtif+O
 QSU8B2z6duu9YBa6LVcGoenwiexaiHcec8+fa5vnz8dkBFrFRCLP8byR4wkrNWTiYPyp
 67rajmpEsY5MuXqu0quHlGKRn2bheMkoaEQYinP5sbFAAAjt0H8Ya4L1dxbRULVMFirC
 UJoQuYI7+lPNvEXxf6Q16K3d1iPbZYFJI9zcctRogF9CjiwIiuqGzQiqlq4EDnt2SPZ7
 1fQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723086897; x=1723691697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W/Opz58k2M9Rm+jtv1QysddzT+5tlN71aNOiKrAKmsI=;
 b=wOKNArGQ9gk1f4q5JkIcCY8TpZFwSPWCWNwlnEwdEqRev/d6jjnQlOSbPZUj6j9yFR
 pVrs7tiqPmXMefENuRIPJaG9eF70QQvxrMvQZiDjsiGeHNyVtJvoBJ6Yg/iMDf4lLxit
 Hj5zqlQxoqJy2RWy3Li2duM3PUZhlh2dC6KJFIro5n8yC5ftYj34chbpr4+Nj9+CsfxC
 y8ZYltiw0r8w0VJLmQ1fbjcAufwv7EwRPomi24+vHeAYx9k6sGQ3wHAuhp2xMjSDJpSS
 EsS/fzeCQJsQFXv4VAayIJ7A768tmXlADaeVFdRgLomdLx2PE0FVLvmmRTWpixgNzb0x
 Evpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnXZu1KUN/viKQuHi6kuCYjx8pasTRIxOey2CtZzmCpxuhFfSxi55lLgF55tjlWqitCkafuvnJBFri5v/H1S6yQGjfLg==
X-Gm-Message-State: AOJu0YxWg+wt19ssACJ9nfZv7SgtFF1kUdaU4T+LKIsXWaoB4GZPZHXr
 /ZZ4vQsBJ31CJBY+RujrgmXX9PdcunTHPInCGOFfXS+xrOC8S6r1VjURSza+yd8=
X-Google-Smtp-Source: AGHT+IF3GnPWbT16I6zohXnI1xu6ODfNhn5WafKNBgzbqOLdQYJhoX/u7JL5U+RpYgbsrx6imVEkRQ==
X-Received: by 2002:a05:6870:b69f:b0:261:e19:4587 with SMTP id
 586e51a60fabf-2692b61801cmr761131fac.6.1723086897413; 
 Wed, 07 Aug 2024 20:14:57 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2689a2f2269sm4359925fac.14.2024.08.07.20.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 20:14:57 -0700 (PDT)
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
Subject: [PATCH v5 17/38] mmc: exynos_dw_mmc: Fix obtaining the base address
 of controller
Date: Wed,  7 Aug 2024 22:14:23 -0500
Message-Id: <20240808031444.9619-18-semen.protsenko@linaro.org>
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
Changes in v5:
  - (none)

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

