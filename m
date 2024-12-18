Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A00E7718A
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 13:01:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FAA08021D;
	Wed, 18 Dec 2024 14:01:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HChCHEdH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7E1C80274; Wed, 18 Dec 2024 14:01:14 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61FFB80214
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 14:01:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-53df6322ea7so8543168e87.0
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 05:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734526871; x=1735131671;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hPnNNedavKK0TnUuq30LWwHzQXVPMNihyse4SePW4wg=;
 b=HChCHEdH3Sh3kFCiATq+FJxBwsGYmvT9x14ReNwjOtXxRmFbvDr8Uso/LyYznmSE6f
 ccbB7W7CJrxdhn2NEaT1hayWTCY2focSKFkIe0oqFsD9MSC/J5iaufLMiU26tlsfgH4z
 XE+6OXHqFlG/XDU8qjlPypB8r8vIlZGRim15iXANy7WjYRR4Rst/Ldauma5PQs7r91C2
 960OFmMPAtk7LMd+ZlxDrYCIRuOFnrdMHwJ5w5Kn36yzEsWSU8v6Gn4ApOCzWpBamYuu
 osAvYy0fp92nnpCPezs6qvnr0y1QQXNZVueedV7l79pyy+W5J4Cyk7H7pU75U9H77p3c
 zK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734526871; x=1735131671;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hPnNNedavKK0TnUuq30LWwHzQXVPMNihyse4SePW4wg=;
 b=VhmUkasnHborzekihkx0zcEJoThkbTTd3zoNoK5LmHOE62Yjgw+BV3t7D7QY1gNkLL
 BQuGE+5w04M1/P+UPErX44JfRRiHTNgdYuIoQ+0p6XuvY0I9Or0GP9VmX5F/f8VS94H5
 FOyx+GyK+SGJEnEu3aInY+gAYh2z9IVge7D01NTXs2ChwrXRmBtnNutZgN32Wof4Bytl
 d4zEp2knha/NY7Kjlu/GzpMViDBN2uDATf6Go6WqOhfVrdQV6SmeMHfScBWJkh3GGIeF
 v5QGR4WV1tMQSNbHuHRs+s0XRE/iYyKgKDGS0m87XhCbb0ZkmaZVflE6ngeeLo8PNLfS
 iLPA==
X-Gm-Message-State: AOJu0YwQKoZLO/S1Qn0GcLtgqoYlnHectLSKoZeU2zg2L/S/LJoLQSky
 TWCat/hBUbDVBqi9TnuIxuEVoT4XePYzMCvsCss60Tx7gNG1cni093SuDz8lsGQ=
X-Gm-Gg: ASbGncvrTOL7Cov5pNrV7zJADFRqYkEes4SB48A98z8Iaf3t0i388VnBjnOe/Gov19v
 o76DdcP+MfH7lOG6FDdmEj0Fn+lVjQIYG+rOCb8W8v8433UwPCMNKe5mmMs4mjpWCuAVSeoa/+H
 Ne5U+dmMqS5V9zrghjUeGQCFF1Lw5e5bZObJ0BPNPvkP1T2NmDGBKmwiSVLdzVqqCXZNI3Wid5G
 +rgaXcpiCxMGtGj25xXaNsK0AYMXkNa5sacSIhA5t0/xKvV8/PbANEBNI8l3U/L3g==
X-Google-Smtp-Source: AGHT+IGHApuLOspEVea2cr70rKU7oCBamOthKCttpbc57g1Wz4Ot7D403V7BRPryFAMsJCDJVJ/vuA==
X-Received: by 2002:a05:6512:3c8e:b0:53e:350a:7294 with SMTP id
 2adb3069b0e04-541ed903a36mr837703e87.37.1734526870418; 
 Wed, 18 Dec 2024 05:01:10 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54120c1394esm1448253e87.187.2024.12.18.05.01.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 05:01:09 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, vigneshr@ti.com, bb@ti.com,
 trini@konsulko.com, lukma@denx.de, n-francis@ti.com, afd@ti.com,
 glaroque@baylibre.com, sjoerd@collabora.com, martyn.welch@collabora.com,
 rasmus.villemoes@prevas.dk, caleb.connolly@linaro.org, j-humphreys@ti.com,
 rogerq@kernel.org, nm@ti.com
Cc: u-boot@lists.denx.de, srk@ti.com, s-vadapalli@ti.com
Subject: Re: [PATCH v2 3/5] configs: am62px_evm_a53_defconfig: enable USB
 DFU support
In-Reply-To: <20241218124542.3519447-4-s-vadapalli@ti.com>
References: <20241218124542.3519447-1-s-vadapalli@ti.com>
 <20241218124542.3519447-4-s-vadapalli@ti.com>
Date: Wed, 18 Dec 2024 14:01:06 +0100
Message-ID: <875xnhw3fx.fsf@baylibre.com>
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

Hi Siddharth,

Thank you for the patch.

On mer., d=C3=A9c. 18, 2024 at 18:15, Siddharth Vadapalli <s-vadapalli@ti.c=
om> wrote:

> The config fragment "am62x_a53_usbdfu.config" which adds USB DFU support
> for AM62x SoC is applicable to the AM62Px SoC as well. Hence, include it
> in "am62px_evm_a53_defconfig" in order to enable support for USB DFU
> flash and boot. Remove those configs from "am62px_evm_a53_defconfig" which
> are present in the "am62x_a53_usbdfu.config" config fragment that is being
> included.
>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> This patch has been newly introduced in this series based on the
> discussion at:
> https://patchwork.ozlabs.org/project/uboot/patch/20241217131658.2920799-3=
-s-vadapalli@ti.com/#3432702
>
>  configs/am62px_evm_a53_defconfig | 24 +-----------------------
>  1 file changed, 1 insertion(+), 23 deletions(-)
>
> diff --git a/configs/am62px_evm_a53_defconfig b/configs/am62px_evm_a53_de=
fconfig
> index 9635beb1b27..9862b1f9a16 100644
> --- a/configs/am62px_evm_a53_defconfig
> +++ b/configs/am62px_evm_a53_defconfig
> @@ -41,14 +41,11 @@ CONFIG_SPL_SYS_MMCSD_RAW_MODE=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x1400
>  CONFIG_SPL_DMA=3Dy
> -CONFIG_SPL_ENV_SUPPORT=3Dy
>  CONFIG_SPL_FS_LOAD_PAYLOAD_NAME=3D"u-boot.img"
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_DM_MAILBOX=3Dy
>  CONFIG_SPL_DM_SPI_FLASH=3Dy
>  CONFIG_SPL_POWER_DOMAIN=3Dy
> -CONFIG_SPL_RAM_SUPPORT=3Dy
> -CONFIG_SPL_RAM_DEVICE=3Dy
>  # CONFIG_SPL_SPI_FLASH_TINY is not set
>  CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
> @@ -58,14 +55,12 @@ CONFIG_SPL_YMODEM_SUPPORT=3Dy
>  CONFIG_CMD_BOOTEFI_SELFTEST=3Dy
>  CONFIG_CMD_NVEDIT_EFI=3Dy
>  CONFIG_CMD_CLK=3Dy
> -CONFIG_CMD_DFU=3Dy
>  CONFIG_CMD_GPIO=3Dy
>  CONFIG_CMD_GPT=3Dy
>  CONFIG_CMD_I2C=3Dy
>  CONFIG_CMD_MMC=3Dy
>  CONFIG_CMD_MTD=3Dy
>  CONFIG_CMD_REMOTEPROC=3Dy
> -CONFIG_CMD_USB=3Dy
>  CONFIG_CMD_USB_MASS_STORAGE=3Dy
>  CONFIG_CMD_EFIDEBUG=3Dy
>  CONFIG_CMD_TIME=3Dy
> @@ -85,17 +80,12 @@ CONFIG_SPL_DM_DEVICE_REMOVE=3Dy
>  CONFIG_SPL_DM_SEQ_ALIAS=3Dy
>  CONFIG_REGMAP=3Dy
>  CONFIG_SPL_REGMAP=3Dy
> -CONFIG_SPL_SYSCON=3Dy
>  CONFIG_SPL_OF_TRANSLATE=3Dy
>  CONFIG_CLK=3Dy
>  CONFIG_SPL_CLK=3Dy
>  CONFIG_CLK_TI_SCI=3Dy
> -CONFIG_DFU_MMC=3Dy
>  CONFIG_DFU_MTD=3Dy
> -CONFIG_DFU_RAM=3Dy
>  CONFIG_DFU_SF=3Dy
> -CONFIG_SYS_DFU_DATA_BUF_SIZE=3D0x40000
> -CONFIG_SYS_DFU_MAX_FILE_SIZE=3D0x800000
>  CONFIG_DMA_CHANNELS=3Dy
>  CONFIG_TI_K3_NAVSS_UDMA=3Dy
>  CONFIG_USB_FUNCTION_FASTBOOT=3Dy
> @@ -164,22 +154,10 @@ CONFIG_SYSRESET=3Dy
>  CONFIG_SPL_SYSRESET=3Dy
>  CONFIG_SYSRESET_TI_SCI=3Dy
>  CONFIG_DM_THERMAL=3Dy
> -CONFIG_USB=3Dy
> -CONFIG_DM_USB_GADGET=3Dy
> -CONFIG_SPL_DM_USB_GADGET=3Dy
>  CONFIG_SPL_USB_HOST=3Dy
> -CONFIG_USB_XHCI_HCD=3Dy
> -CONFIG_USB_DWC3=3Dy
> -CONFIG_USB_DWC3_GENERIC=3Dy
> -CONFIG_SPL_USB_DWC3_GENERIC=3Dy
>  CONFIG_SPL_USB_STORAGE=3Dy
> -CONFIG_USB_GADGET=3Dy
> -CONFIG_SPL_USB_GADGET=3Dy
> -CONFIG_USB_GADGET_MANUFACTURER=3D"Texas Instruments"
> -CONFIG_USB_GADGET_VENDOR_NUM=3D0x0451
> -CONFIG_USB_GADGET_PRODUCT_NUM=3D0x6165
> -CONFIG_SPL_DFU=3Dy
>  CONFIG_FS_FAT_MAX_CLUSTSIZE=3D16384
>  CONFIG_EFI_SET_TIME=3Dy
>=20=20
>  #include <configs/k3_efi_capsule.config>
> +#include <configs/am62x_a53_usbdfu.config>
> --=20
> 2.43.0
