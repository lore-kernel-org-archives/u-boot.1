Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68A3C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 14:01:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 219EF88DFA;
	Wed, 21 Aug 2024 16:00:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eMG/rO1p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71A7988DD5; Wed, 21 Aug 2024 16:00:13 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E5FD88DEB
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 16:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5d5cbe88f70so3958346eaf.0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 07:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724248808; x=1724853608; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Fm440EvBuMXO5KTkNxDa1PHBm2YCesA1b3wcK8UcH5A=;
 b=eMG/rO1p/3w47wMTHgw7KC8lAKofUe2gvqfjO4WjEMYj8Ig6XaoP03mOrpLRL2svnH
 +70JFL1VSLpm1cW1+csKlpSbjMhe5O+5O4+Irv45tZnlwaj76uXRztyES7H6H64k4sdH
 Z6dwOH4rYlg2WAnDkPrLev7RdXNZPgmUGw7ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724248808; x=1724853608;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fm440EvBuMXO5KTkNxDa1PHBm2YCesA1b3wcK8UcH5A=;
 b=UppYnIU75OT2UP+lhZsv/zHQaYcCt2Io2qaUZ/FCe+cOFYnq8EfUap/jMHTRKt+nlb
 SKpeFQ+RPI98OAnzmbN8ab+reDuYBDqGfz6c5/yBa7lo0eJ4U3JzH3bXkCYy/9m4tZwh
 W9rDyc2TbIKQbBbbJprMO5yTsD8Vg1ajdoCbyaIv9CVEIzNvciA6E0UeGwExqK1TDNB8
 vw6VNMc9evz5ckpWWsIci4/E5LVXU8+xAcyeo8CJRrGbl//s6Q7ADqoAwRAh1V8O9Xbt
 ktiYeQcDxMYoMC8EBU4bSTlHDL/y/sT5QP2L9AFXsUFauC8mtqW52L0lTroO62UQ6N3t
 Bn8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrvVz9PdVt4xOTYz7jfp3A3GfTX8jZ5ypQVD+OxvkETVwjNc6O3c5+Vv3lmmg3vxVxTaDqj9s=@lists.denx.de
X-Gm-Message-State: AOJu0YwLtijntqJolGoUS211maGsNbK5xQ8ifNUbdGfZ4FYvcdS4dUNZ
 nlPoSFmdnWV/U9Ac0BTfF0+qi+67DbSQLK57ewvdXdbM0jmNaxEwHzoK1a8fuN6RJexHfHv6Qia
 L2cbnWkvkZj3HUETW4zNXfuJR9NslGXtPcq2A
X-Google-Smtp-Source: AGHT+IEQXHfupn133cwczeovi0DTCGIfsdkLtBqBKEWxLS4SUANRMYU7kAoYX4XszFjR6v9NP6DbdzxtVQtoxAzUGMs=
X-Received: by 2002:a05:6358:75a8:b0:1ac:660a:6fec with SMTP id
 e5c5f4694b2df-1b59fbf0011mr312480455d.20.1724248807667; Wed, 21 Aug 2024
 07:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240821-b4-rb3gen2-v2-0-49b07633f3a8@linaro.org>
 <20240821-b4-rb3gen2-v2-6-49b07633f3a8@linaro.org>
In-Reply-To: <20240821-b4-rb3gen2-v2-6-49b07633f3a8@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Aug 2024 07:59:56 -0600
Message-ID: <CAFLszTgFv7nkfSFgz_tto1xgwrDqf6Qg-yBn1BgUpAB0hoDxFQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] configs: add qcm6490_defconfig
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 21 Aug 2024 at 07:43, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Introduce a defconfig for the RB3 Gen 2 and other QCM6490 boards with a
> dedicated uefi partition. These can replace EDK2 entirely with U-Boot.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  MAINTAINERS               |  1 +
>  configs/qcm6490_defconfig | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index daaf0345d0e8..7ab39d91a553 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -616,8 +616,9 @@ M:  Neil Armstrong <neil.armstrong@linaro.org>
>  R:     Sumit Garg <sumit.garg@linaro.org>
>  L:     u-boot-qcom@groups.io
>  S:     Maintained
>  T:     git https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git
> +F:     configs/qcm6490_defconfig
>  F:     drivers/*/*/pm8???-*
>  F:     drivers/gpio/msm_gpio.c
>  F:     drivers/mmc/msm_sdhci.c
>  F:     drivers/phy/msm8916-usbh-phy.c
> diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
> new file mode 100644
> index 000000000000..25413ac9ed5a
> --- /dev/null
> +++ b/configs/qcm6490_defconfig
> @@ -0,0 +1,18 @@
> +# Configuration for building U-Boot to be flashed
> +# to the uefi partition of QCM6490 dev boards with
> +# the "Linux Embedded" partition layout (which have
> +# a dedicated "uefi" partition for edk2/U-Boot)
> +
> +#include "qcom_defconfig"
> +
> +CONFIG_DEBUG_UART=y
> +CONFIG_DEBUG_UART_ANNOUNCE=y
> +CONFIG_DEBUG_UART_BASE=0x994000
> +CONFIG_DEBUG_UART_MSM_GENI=y
> +CONFIG_DEBUG_UART_CLOCK=14745600
> +
> +# Address where U-Boot will be loaded
> +CONFIG_TEXT_BASE=0x9fc00000
> +CONFIG_REMAKE_ELF=y
> +
> +CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
>
> --
> 2.46.0
>
