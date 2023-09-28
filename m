Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40515CE7B08
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 18:50:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 816E98690B;
	Thu, 28 Sep 2023 20:50:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lnYRtIzu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 919AB86D8F; Thu, 28 Sep 2023 20:50:45 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2A2386545
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 20:50:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3214cdb4b27so12340347f8f.1
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 11:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695927043; x=1696531843; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qTUbnPiF/Ep1N8+qimp+9xfavR04lYwCdoD7i4NBlGY=;
 b=lnYRtIzuvfTOuhpCcUCRgs/USLDd5KUzvU0xDRYffbH6UckdVFsutgKrhq61XT/Vo/
 HViL3y+j661lqj3n0w9faClo6dWJvwI78coX3uEPbX0CHuN1vnT2Yi0TXhicLi7RRRFU
 hTtv9GJLaBpWvCo08xmSSAm1X3/e+bDlykEr3QQaLbYmAsMYPYiuXxL26IorMKFshv0j
 sx292SpxU+Z37t4GUzMbNUxcRV1j0F52GN10pJfRSUigRUK4cdHirI17mSGSLt+BUDhX
 0N1lLV3xHpq3JIdg31ACxdwHwXXWl9iRIwHzohh9tNfsOHs928kB/8y7Q+RNtvlkpPT6
 BXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695927043; x=1696531843;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qTUbnPiF/Ep1N8+qimp+9xfavR04lYwCdoD7i4NBlGY=;
 b=VbZKLiIvby2zMLepUC6ruKUgrRXCcGkfdrzqlK5TwScrnZ/iDLav2ilcN4G/umT2vP
 y1dK5OsXdbWPVOzJpMbDZzLJF3EO+O4BOC4PPX0YFKYsrEhATyCwqHOKwAyCD6EMGVkk
 Tpo/mGweLHoBrgBLXM2CXp4pdKkROqJZVaTTxl/g3Ad7TSjmraZh7WSvY0vHcj0LU407
 Sub5owXRFxJZb+yTEskETl+JN0m4ObUq2gKIxvJyDJxxawEJWO8LmDN5W9ASU4P8TyfB
 vkBmMTZPVkTPjkgOvqSz8kKHmlym6vC0zYhOykeKlOQYMbLPGeLTvCZoCPx1B+ELH3YL
 mqFQ==
X-Gm-Message-State: AOJu0Yymoz9174dp1Id4oI7UlkX2z2N6isrKvBu/aI3IRjsvpCaV1HR/
 SSYD4DmENbcgJBR/V+ur/8d8nalmR5YkmA==
X-Google-Smtp-Source: AGHT+IHwL+8QwGspMpZEcKYcb9pGaYalvk5cHoD9Qlaya3Jar7p9GM20ZeO7YSXBczCg3NtMljTC0w==
X-Received: by 2002:adf:e58d:0:b0:321:71ae:736c with SMTP id
 l13-20020adfe58d000000b0032171ae736cmr1878571wrm.7.1695927042852; 
 Thu, 28 Sep 2023 11:50:42 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 p14-20020adfe60e000000b003197b85bad2sm20109463wrm.79.2023.09.28.11.50.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 11:50:42 -0700 (PDT)
Message-ID: <2c0224bf-f411-27c7-d7a3-541d0aa36124@gmail.com>
Date: Thu, 28 Sep 2023 20:50:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 1/3] mtd: nand: raw: rockchip_nfc: add NAND_SKIP_BBTSCAN
 option
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, u-boot@lists.denx.de
References: <9dd66b67-e372-fcb9-ed38-7ad24d83edbb@gmail.com>
Content-Language: en-US
In-Reply-To: <9dd66b67-e372-fcb9-ed38-7ad24d83edbb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On Rockchip SoCs the first boot stages are written on NAND
with help of manufacturer software that uses a different format
then the MTD framework. Skip the automatic BBT scan with the
NAND_SKIP_BBTSCAN option to be able to pass the driver probe
function and to let the original data unchanged.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
 drivers/mtd/nand/raw/Kconfig        | 9 +++++++++
 drivers/mtd/nand/raw/rockchip_nfc.c | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index d624589a892b..72547f00fbec 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -611,6 +611,15 @@ config ROCKCHIP_NAND
 	    NFC v800: RK3308, RV1108
 	    NFC v900: PX30, RK3326

+config ROCKCHIP_NAND_SKIP_BBTSCAN
+	bool "Skip the automatic BBT scan with Rockchip NAND controllers"
+	depends on ROCKCHIP_NAND
+	default n
+	help
+	  Skip the automatic BBT scan with the NAND_SKIP_BBTSCAN
+	  option when data content is not in MTD format or
+	  must remain unchanged.
+
 config TEGRA_NAND
 	bool "Support for NAND controller on Tegra SoCs"
 	depends on ARCH_TEGRA
diff --git a/drivers/mtd/nand/raw/rockchip_nfc.c b/drivers/mtd/nand/raw/rockchip_nfc.c
index 6ad51df4acff..df6742c2f9bb 100644
--- a/drivers/mtd/nand/raw/rockchip_nfc.c
+++ b/drivers/mtd/nand/raw/rockchip_nfc.c
@@ -981,6 +981,9 @@ static int rk_nfc_nand_chip_init(ofnode node, struct rk_nfc *nfc, int devnum)
 	chip->bbt_options = NAND_BBT_USE_FLASH | NAND_BBT_NO_OOB;
 	chip->options |= NAND_NO_SUBPAGE_WRITE | NAND_USE_BOUNCE_BUFFER;

+	if (IS_ENABLED(CONFIG_ROCKCHIP_NAND_SKIP_BBTSCAN))
+		chip->options |= NAND_SKIP_BBTSCAN;
+
 	rk_nfc_hw_init(nfc);
 	ret = nand_scan_ident(mtd, nsels, NULL);
 	if (ret)
--
2.39.2

