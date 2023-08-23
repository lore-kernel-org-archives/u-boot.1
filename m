Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC81EE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 07:50:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 016DC864B1;
	Wed, 23 Aug 2023 09:50:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="oOIW6Dz8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44E9D864B8; Wed, 23 Aug 2023 09:50:31 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F1C98649D
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 09:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31c4d5bd69cso2582667f8f.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 00:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692777029; x=1693381829; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=poPNetrsP28LzEfxEeUoQxQt14uFxPq9oXs/YVkX/XQ=;
 b=oOIW6Dz8itZCaVOw/1/tvEWFrRqp9zYoydtAXGXnCd+UVQQNvwNilq/1ABxblvG7jm
 eTxPF5A7M+tQ3z0846ba5C9FSMjE5FCjhxK7M+Gc85GP30uZmK7Hz9CnDUEZucrRkcb0
 OJef6hVAMQZy8OXhoYRFkqwCluid2+yZGr1ckk+s60NXijWc66jjclZG1gfg1tyHdFU0
 AXArrcgj8KFUi2FASt6xXlh5XwBHv25Y+EaR+knni6mM1e0lPNuB2XfBZA3JyUb8HlZO
 LiIP8l5MemNUZ96D82ljzMwoEWsSX84al/Wke22B1wDXcoefLBGunGYthnHkgvO01hW4
 vVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692777029; x=1693381829;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=poPNetrsP28LzEfxEeUoQxQt14uFxPq9oXs/YVkX/XQ=;
 b=Jx6ZFQETs498mOgAxjt8DYzsHyDuDR4pbSX7Qk9YMzkaw4BLxHKEf51XQ0XRCvS1Xh
 iohL4fPsxXNhvQjOTc8GI+sYzl5ATOknVsq8ZDLzrs1CwaykbbBC1GxHRdM0wucSemMC
 jrzMm+EyM8xOt6N/7PBy07Aw3i0meqWG5dSY/zyg0bpc2SnuC0/u4OW3BJFz71lUrNwW
 ndqdjwI9ymMxUti+jWpUqIZ4NXhO38RYlck+Wrd5IyJZX1OBQDAUEbdOxN/oGTHLI3iI
 MhySxwu539Lb+kb8iW5etYzzXxhdfva6qGgh8WiOtMHgL48AzSVhV+UvX/PefUyca33W
 WHMQ==
X-Gm-Message-State: AOJu0Yy701N05s9EPy4rt0dGGBd0+VGSols8opPE9oNjd+x7qyUTPEDX
 rrfBUn2jRl48fohsNqzvmOVuvA==
X-Google-Smtp-Source: AGHT+IGRO37hPbVHbc0Tw8PnRUoojCkQNkWQ1Hq5Yc7dDAC34Jt3EIYmLhNqaW+6SrxROR1vaXo5KQ==
X-Received: by 2002:a5d:4574:0:b0:317:7af4:5297 with SMTP id
 a20-20020a5d4574000000b003177af45297mr9242898wrc.62.1692777028854; 
 Wed, 23 Aug 2023 00:50:28 -0700 (PDT)
Received: from localhost ([2a01:cb19:8704:be00:4f55:bd9d:611a:6c8e])
 by smtp.gmail.com with ESMTPSA id
 c12-20020a5d4ccc000000b003143c6e09ccsm18058072wrt.16.2023.08.23.00.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 00:50:28 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>, Tom Rini
 <trini@konsulko.com>
Cc: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Jan
 Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V4 2/8] configs: am62x_evm*: Enable EMMC_BOOT configuration
In-Reply-To: <20230822184135.2328409-3-nm@ti.com>
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-3-nm@ti.com>
Date: Wed, 23 Aug 2023 09:50:27 +0200
Message-ID: <87wmxmfb98.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On mar., ao=C3=BBt 22, 2023 at 13:41, Nishanth Menon <nm@ti.com> wrote:

> Enable EMMC boot support for AM62x evm base configuration.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> New patch
>
>  configs/am62x_evm_a53_defconfig | 1 +
>  configs/am62x_evm_r5_defconfig  | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defc=
onfig
> index d55caabe22c9..824a99b9b6cc 100644
> --- a/configs/am62x_evm_a53_defconfig
> +++ b/configs/am62x_evm_a53_defconfig
> @@ -69,6 +69,7 @@ CONFIG_TI_K3_NAVSS_UDMA=3Dy
>  CONFIG_TI_SCI_PROTOCOL=3Dy
>  CONFIG_DM_MAILBOX=3Dy
>  CONFIG_K3_SEC_PROXY=3Dy
> +CONFIG_SUPPORT_EMMC_BOOT=3Dy
>  CONFIG_MMC_SDHCI=3Dy
>  CONFIG_MMC_SDHCI_ADMA=3Dy
>  CONFIG_SPL_MMC_SDHCI_ADMA=3Dy
> diff --git a/configs/am62x_evm_r5_defconfig b/configs/am62x_evm_r5_defcon=
fig
> index 3c5f36729842..489ee943fe31 100644
> --- a/configs/am62x_evm_r5_defconfig
> +++ b/configs/am62x_evm_r5_defconfig
> @@ -92,6 +92,7 @@ CONFIG_DM_MAILBOX=3Dy
>  CONFIG_K3_SEC_PROXY=3Dy
>  CONFIG_SPL_MISC=3Dy
>  CONFIG_ESM_K3=3Dy
> +CONFIG_SUPPORT_EMMC_BOOT=3Dy
>  CONFIG_MMC_SDHCI=3Dy
>  CONFIG_MMC_SDHCI_ADMA=3Dy
>  CONFIG_SPL_MMC_SDHCI_ADMA=3Dy
> --=20
> 2.40.0
