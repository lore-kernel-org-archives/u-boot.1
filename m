Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A6ECDB483
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 14:00:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE99E86F94;
	Wed, 18 Oct 2023 16:00:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fAvQEv0V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB57286F94; Wed, 18 Oct 2023 16:00:32 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCAF786B05
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 16:00:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9ba1eb73c27so1131521566b.3
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 07:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697637629; x=1698242429; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qTUbnPiF/Ep1N8+qimp+9xfavR04lYwCdoD7i4NBlGY=;
 b=fAvQEv0VBJKYhHWCpJlf2YGRVke6nfEIX7LWU77tx9JMqYp8yc6Vu1d9B+EAuDV9Vx
 PjaaWuK8mfWWnwzmvzrlt5ZPJAQGcvl0iA2WgFeybIKCsJr7MkuzavnaoyVUu/lBEFiX
 uWveoudurw4lgxG8oG7IJX9y01wefQtndfzJ9i5W4raz14HdwyDP3kkkOnIhRWfDNCma
 iYUUZIUc5FaMA2JK7I6+qXHTn1OF1Bd9jB1UxYP76Qu5s5DScCz3iujYfJMNhBWm7F/W
 hMIv9fJcteDtrrc2Wj6csz0NXokhv3ltBvkX0tg2gwC/E1+g5u//ZlY0MaLP9f10NB2p
 uJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697637629; x=1698242429;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qTUbnPiF/Ep1N8+qimp+9xfavR04lYwCdoD7i4NBlGY=;
 b=GDomJqCTl1kd4Ax8shbJOw6swAd8FzGNLp8T/aGkQ746wScNOu/oo5QlGN6rMpuHV5
 9rg7edbhdWHe/hO5MmGca73EFg9c8/6PAox3FtBKNUaAM5j50VjSVCXFL/BlAiUDF/i/
 HfZ0s6Uih2k2FjW4shvDpfxymX2OCVlXQZOdSp2fVL8YTzyekVkcev3/od1ZVYt2eGqj
 sJayKTqdX1icjP0OmyUaqwqKBfY/FOus/sP54V93Vtq3zU0W72x3hG6iYKNnWgOwHgwH
 GLYuRmOO7/TilLL05wetZ+pBvboMXkwVXp17xoZf7UDfjAmeH5/oz3IjKKTC+Oy+LsjD
 rD4A==
X-Gm-Message-State: AOJu0YxgqOZG/zZO8COrRgkFElucc7f20TTxJZPFOqCOlVmdUVW977Jm
 U1tubbnW7HOfA4UnI0B78qo=
X-Google-Smtp-Source: AGHT+IFUIaJaFUdp80IRZbQ6T/4/DrDeYQRe9vgtolr4OWPCfLaZU6iNgx1B1kbgMYTVer2d0rmqwg==
X-Received: by 2002:a17:907:3e99:b0:9bf:30e8:5bfb with SMTP id
 hs25-20020a1709073e9900b009bf30e85bfbmr4232217ejc.48.1697637628869; 
 Wed, 18 Oct 2023 07:00:28 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 m16-20020a1709066d1000b0099bc80d5575sm1689823ejr.200.2023.10.18.07.00.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 07:00:28 -0700 (PDT)
Message-ID: <894721e5-72e4-e6ce-b59e-4d751fb66a22@gmail.com>
Date: Wed, 18 Oct 2023 16:00:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 1/8] mtd: nand: raw: rockchip_nfc: add NAND_SKIP_BBTSCAN
 option
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 marex@denx.de, u-boot@lists.denx.de
References: <7fd0d9d1-2e93-a48b-edfd-6d4fec314a60@gmail.com>
Content-Language: en-US
In-Reply-To: <7fd0d9d1-2e93-a48b-edfd-6d4fec314a60@gmail.com>
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

