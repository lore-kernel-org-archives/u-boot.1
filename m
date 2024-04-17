Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8471FC4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 17:00:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4A5F8846B;
	Wed, 17 Apr 2024 19:00:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="MulSl2eo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BAA68817B; Wed, 17 Apr 2024 19:00:04 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E547884A2
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 19:00:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a51addddbd4so674369766b.0
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 10:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1713373201; x=1713978001; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NC8B7yp4JVZQAjajT9apzNaVMSImmIN4aTOEArnGHq4=;
 b=MulSl2eousl+Dwqu6SYo/FUj7zUGIkohPQFEp2JguGoUbcRUINd7a5Ts4elhQcGzUg
 /oHQSjUVsAgC8Nf+NSlYRe/G5jhIWEjDWFx057qbO+LU3hxKdbsrwSbM9Xzb/92WAFkA
 NXpb1clJxTh/YhJDIQCLCMI/IxxeBJ4pS6yjHGNT9PUcE/amcGoSYE409QBiGoyyb5/C
 hE8zUSuIDLaLn7zzam5C25n4Ihz6Jm8tJxcbYyNsiR6sV9kz+KJf1FoQi9bWlA4LsoxN
 HCtbSdwrA8k2ozcs6jum7BZz1GUoydfv4i+SXz4dntR6DjBuy4C/Y7HemqGc/DiFIuZR
 E0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713373201; x=1713978001;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NC8B7yp4JVZQAjajT9apzNaVMSImmIN4aTOEArnGHq4=;
 b=CdzszcG45zgd3c21OcbyVtPLHLFDRrd2sauEHrWbbm5hJwghShhv7GYfFf6IsewLc9
 XL2HWBAkyfPID2Sq0zPB7BhmMWDu1apMA9xng+FJWyll8+mq906xBORkVACbMnrvWnbp
 CMcJ5FthCX3q9eDhQ5eW/M2+Mv5SZVN6CGzQqnL/K/MgVJd3QS/1eIq110H/La4/ddO9
 j8WiEyjQA6vMb7iO50uz+gDa0F0hDeFsqQAss9ws/r29Nd776MbJM61SpL+agF3xuO7M
 L5VCCvOfA8xq+1UsOofBnxNOff7NHVGmz7dw8KUgZ0LHb0GZ8hSAVBEUeLC0JYyaLGuF
 4e2g==
X-Gm-Message-State: AOJu0YyF2kH0BA6p89a6I92/Rq403FXxGUv+AGjxxytSDn5nAvX6nrVK
 YCgMQOhDDUWuWicx51fpWMzkNsTsD6jzkRv973xJ2Wl+TFy1CSunY73RSBhb3IuuJn3d5Jc3RMi
 t7HhlHgLuDDSIX+DFkgHL/hS9nBlFL7dzxlYk0mus5AwCzmBW
X-Google-Smtp-Source: AGHT+IGQboTJmFCksRgkgDhgLQzxKxED2faQDy5whvK8TkAliHnxX5mgTAWEWpoA5YA9TqlNSrabRtsaGOoMhlvAbo0=
X-Received: by 2002:a17:906:144d:b0:a55:6600:b33 with SMTP id
 q13-20020a170906144d00b00a5566000b33mr66402ejc.23.1713373200958; Wed, 17 Apr
 2024 10:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240325162739.1350665-1-tharvey@gateworks.com>
In-Reply-To: <20240325162739.1350665-1-tharvey@gateworks.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 17 Apr 2024 09:59:49 -0700
Message-ID: <CAJ+vNU3QHCV=69yau+v0yYK5i_dvTydGvzMyne=nbBveq8VveQ@mail.gmail.com>
Subject: Re: [PATCH] imx8m*-venice: enable TPM support
To: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Mar 25, 2024 at 9:27=E2=80=AFAM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> Enable support for TPM2 devices. As the ATTPM20P TPM2 used on the
> Gateworks Venice boards hangs off the SPI bus we enable SPI support
> as well.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  configs/imx8mm_venice_defconfig | 10 ++++++++++
>  configs/imx8mn_venice_defconfig | 10 ++++++++++
>  configs/imx8mp_venice_defconfig | 10 ++++++++++
>  3 files changed, 30 insertions(+)
>
> diff --git a/configs/imx8mm_venice_defconfig b/configs/imx8mm_venice_defc=
onfig
> index cb6b97d097c1..86928687df2d 100644
> --- a/configs/imx8mm_venice_defconfig
> +++ b/configs/imx8mm_venice_defconfig
> @@ -68,6 +68,7 @@ CONFIG_CMD_TIME=3Dy
>  CONFIG_CMD_UUID=3Dy
>  CONFIG_CMD_PMIC=3Dy
>  CONFIG_CMD_REGULATOR=3Dy
> +CONFIG_CMD_TPM=3Dy
>  CONFIG_CMD_EXT4_WRITE=3Dy
>  # CONFIG_ISO_PARTITION is not set
>  # CONFIG_SPL_EFI_PARTITION is not set
> @@ -127,14 +128,20 @@ CONFIG_SPL_DM_PMIC_MP5416=3Dy
>  CONFIG_DM_REGULATOR=3Dy
>  CONFIG_DM_REGULATOR_FIXED=3Dy
>  CONFIG_DM_REGULATOR_GPIO=3Dy
> +# CONFIG_DM_RNG is not set
>  CONFIG_DM_SERIAL=3Dy
>  CONFIG_MXC_UART=3Dy
> +CONFIG_SPI=3Dy
> +CONFIG_DM_SPI=3Dy
> +CONFIG_MXC_SPI=3Dy
>  CONFIG_SYSRESET=3Dy
>  CONFIG_SPL_SYSRESET=3Dy
>  CONFIG_SYSRESET_PSCI=3Dy
>  CONFIG_SYSRESET_WATCHDOG=3Dy
>  CONFIG_DM_THERMAL=3Dy
>  CONFIG_IMX_TMU=3Dy
> +# CONFIG_TPM_V1 is not set
> +CONFIG_TPM2_TIS_SPI=3Dy
>  CONFIG_USB=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
>  CONFIG_USB_HOST_ETHER=3Dy
> @@ -152,4 +159,7 @@ CONFIG_USB_GADGET_PRODUCT_NUM=3D0xa4a5
>  CONFIG_CI_UDC=3Dy
>  CONFIG_USB_GADGET_DOWNLOAD=3Dy
>  CONFIG_IMX_WATCHDOG=3Dy
> +CONFIG_TPM=3Dy
> +# CONFIG_SPL_SHA512 is not set
> +# CONFIG_SPL_SHA384 is not set
>  CONFIG_HEXDUMP=3Dy
> diff --git a/configs/imx8mn_venice_defconfig b/configs/imx8mn_venice_defc=
onfig
> index 0a4fba5f1ca8..6bb0f015a9bf 100644
> --- a/configs/imx8mn_venice_defconfig
> +++ b/configs/imx8mn_venice_defconfig
> @@ -71,6 +71,7 @@ CONFIG_CMD_TIME=3Dy
>  CONFIG_CMD_UUID=3Dy
>  CONFIG_CMD_PMIC=3Dy
>  CONFIG_CMD_REGULATOR=3Dy
> +CONFIG_CMD_TPM=3Dy
>  CONFIG_CMD_EXT4_WRITE=3Dy
>  # CONFIG_ISO_PARTITION is not set
>  # CONFIG_SPL_EFI_PARTITION is not set
> @@ -128,14 +129,20 @@ CONFIG_SPL_DM_PMIC_MP5416=3Dy
>  CONFIG_DM_REGULATOR=3Dy
>  CONFIG_DM_REGULATOR_FIXED=3Dy
>  CONFIG_DM_REGULATOR_GPIO=3Dy
> +# CONFIG_DM_RNG is not set
>  CONFIG_DM_SERIAL=3Dy
>  CONFIG_MXC_UART=3Dy
> +CONFIG_SPI=3Dy
> +CONFIG_DM_SPI=3Dy
> +CONFIG_MXC_SPI=3Dy
>  CONFIG_SYSRESET=3Dy
>  CONFIG_SPL_SYSRESET=3Dy
>  CONFIG_SYSRESET_PSCI=3Dy
>  CONFIG_SYSRESET_WATCHDOG=3Dy
>  CONFIG_DM_THERMAL=3Dy
>  CONFIG_IMX_TMU=3Dy
> +# CONFIG_TPM_V1 is not set
> +CONFIG_TPM2_TIS_SPI=3Dy
>  CONFIG_USB=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
>  CONFIG_USB_HOST_ETHER=3Dy
> @@ -153,4 +160,7 @@ CONFIG_USB_GADGET_PRODUCT_NUM=3D0xa4a5
>  CONFIG_CI_UDC=3Dy
>  CONFIG_USB_GADGET_DOWNLOAD=3Dy
>  CONFIG_IMX_WATCHDOG=3Dy
> +CONFIG_TPM=3Dy
> +# CONFIG_SPL_SHA512 is not set
> +# CONFIG_SPL_SHA384 is not set
>  CONFIG_HEXDUMP=3Dy
> diff --git a/configs/imx8mp_venice_defconfig b/configs/imx8mp_venice_defc=
onfig
> index 6e4addc7728f..b1055ef2f066 100644
> --- a/configs/imx8mp_venice_defconfig
> +++ b/configs/imx8mp_venice_defconfig
> @@ -73,6 +73,7 @@ CONFIG_CMD_TIME=3Dy
>  CONFIG_CMD_UUID=3Dy
>  CONFIG_CMD_PMIC=3Dy
>  CONFIG_CMD_REGULATOR=3Dy
> +CONFIG_CMD_TPM=3Dy
>  CONFIG_CMD_EXT4_WRITE=3Dy
>  # CONFIG_ISO_PARTITION is not set
>  # CONFIG_SPL_EFI_PARTITION is not set
> @@ -135,14 +136,20 @@ CONFIG_SPL_DM_PMIC_MP5416=3Dy
>  CONFIG_DM_REGULATOR=3Dy
>  CONFIG_DM_REGULATOR_FIXED=3Dy
>  CONFIG_DM_REGULATOR_GPIO=3Dy
> +# CONFIG_DM_RNG is not set
>  CONFIG_DM_SERIAL=3Dy
>  CONFIG_MXC_UART=3Dy
> +CONFIG_SPI=3Dy
> +CONFIG_DM_SPI=3Dy
> +CONFIG_MXC_SPI=3Dy
>  CONFIG_SYSRESET=3Dy
>  CONFIG_SPL_SYSRESET=3Dy
>  CONFIG_SYSRESET_PSCI=3Dy
>  CONFIG_SYSRESET_WATCHDOG=3Dy
>  CONFIG_DM_THERMAL=3Dy
>  CONFIG_IMX_TMU=3Dy
> +# CONFIG_TPM_V1 is not set
> +CONFIG_TPM2_TIS_SPI=3Dy
>  CONFIG_USB=3Dy
>  CONFIG_USB_XHCI_HCD=3Dy
>  CONFIG_USB_XHCI_DWC3=3Dy
> @@ -160,4 +167,7 @@ CONFIG_USB_ETHER_MCS7830=3Dy
>  CONFIG_USB_ETHER_RTL8152=3Dy
>  CONFIG_USB_ETHER_SMSC95XX=3Dy
>  CONFIG_IMX_WATCHDOG=3Dy
> +CONFIG_TPM=3Dy
> +# CONFIG_SPL_SHA512 is not set
> +# CONFIG_SPL_SHA384 is not set
>  CONFIG_HEXDUMP=3Dy
> --
> 2.25.1
>

Fabio,

This one got tagged as 'changes requested' in patchwork but I'm not
clear why. Are there any issues with this?

Best Regards,

Tim
