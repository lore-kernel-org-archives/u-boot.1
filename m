Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07690C4828D
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 09:53:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 131F8877FB;
	Wed,  7 Feb 2024 10:53:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LVg6Vtww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F16BD876AE; Wed,  7 Feb 2024 10:53:05 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 664CA87CD2
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 10:53:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=cnsztl@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-55fc7f63639so485855a12.1
 for <u-boot@lists.denx.de>; Wed, 07 Feb 2024 01:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707299582; x=1707904382; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NaLdmtnMzBVWdjvj5rlaL7xV8pSpBa3EC9vf210d+C0=;
 b=LVg6VtwwZ98zmhjTQn+rBdRdXh3BLhY6/ueecOCvNfNvvZKHXQxwNjY953upPfqD0z
 C/sIEKrEYckfxzRhr0oEII9qNp1/aipP0qOXLXpuKsBvPiDCZsLKoY7yWfAbZBs9FN9i
 JpAE6xT45jy/jN8yOBRBkaAWA2rwxH5yuAERffzsk+5VAgzhZrkYQ/yeoUa81Y80I4n1
 O1Tb3Z4t0EzcX+Ac6Uu9atl6b88UlccOWoikPzcsYgcmFTCWLBL1I2LLmNTTv+JbtH2P
 bO3ChTW/bhGstCKjw5BTIRWwfBjP1cpUAQ80cTe1cq703WP4SHJmxdhs3t8QxXFPc1hG
 xklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707299582; x=1707904382;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NaLdmtnMzBVWdjvj5rlaL7xV8pSpBa3EC9vf210d+C0=;
 b=fqFX8vFsmmg1XWWe327+v2FN01rSQp6ZyLbrVIsBZR5Dh0mDcWsUMpdVMrL+5gy9yx
 PDZFRUfZtVcM55z/scurtebGc/4CjGJlhrtaybLqvfDMyaFEKCof8VqgvPwyS3QCqQHy
 74GY+7S7TcECzwRYIs+TzVbmtPPVbCA43DYvbY/LrF3b4OvCfP13u6yRR2j/exOaPj5S
 /DylOwTedcenzDbBcr+d3mWKoWGtznzKkl/4FKhIFr5Tauzpysqu1qPu8HRTtzdGc8l4
 dG/TmpchYIzJlTcp9gFUaX2YMqAuqQ5PnPX5ikCpAwbDSuN+A2vY2EdJCLycaBlSkTp/
 S5jQ==
X-Gm-Message-State: AOJu0YwL4yEv0j3NnMNzQ7NMnDhWcUHzu6+AukwU4dqQEWlHyjqHbMHi
 i4r7hUimh/bSh2ien9WjuOG8qfu9JpgNPaoIeB3S3f5q+tV+LZy4Upqa4hRCXzbp8zJV3meFoGm
 6gMKS4pl+lZzrUOCm3SIdGQVYxUY=
X-Google-Smtp-Source: AGHT+IGpW4vWZwccXUvd2UsOd7k67/+muDLDSVqefsFcZ2ql0qDQ6aMAeOuhbmuetFJHAcuceWTDaTY3S5cVsGmYfXg=
X-Received: by 2002:a17:907:784e:b0:a36:f811:44f5 with SMTP id
 lb14-20020a170907784e00b00a36f81144f5mr3041429ejc.47.1707299581176; Wed, 07
 Feb 2024 01:53:01 -0800 (PST)
MIME-Version: 1.0
References: <20240207000301.3270722-1-jonas@kwiboo.se>
 <20240207000301.3270722-16-jonas@kwiboo.se>
In-Reply-To: <20240207000301.3270722-16-jonas@kwiboo.se>
From: Tianling Shen <cnsztl@gmail.com>
Date: Wed, 7 Feb 2024 17:52:48 +0800
Message-ID: <CAOP2_Tj-ixCb_VbY17GUFyA+0VVuk=5B4iU9sZQiQpm5G9TrBg@mail.gmail.com>
Subject: Re: [PATCH 15/15] rockchip: rk3328-orangepi-r1-plus: Enable boot from
 SPI NOR flash
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

Hi Jonas,

On Wed, Feb 7, 2024 at 8:14=E2=80=AFAM Jonas Karlman <jonas@kwiboo.se> wrot=
e:
>
> Add Kconfig options to enable support for booting from SPI NOR flash on
> Orange Pi R1 Plus boards.
>
> The generated bootable u-boot-rockchip-spi.bin that can be written to
> 0x0 of SPI NOR flash. The FIT image is loaded from 0x60000, same as on
> RK35xx boards.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Thanks for your great work!

Reviewed-by: Tianling Shen <cnsztl@gmail.com>

Best regards,
Tianling.

> ---
>  configs/orangepi-r1-plus-lts-rk3328_defconfig | 8 ++++++++
>  configs/orangepi-r1-plus-rk3328_defconfig     | 8 ++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/configs/orangepi-r1-plus-lts-rk3328_defconfig b/configs/oran=
gepi-r1-plus-lts-rk3328_defconfig
> index 937ef003d85b..968110c8cd6f 100644
> --- a/configs/orangepi-r1-plus-lts-rk3328_defconfig
> +++ b/configs/orangepi-r1-plus-lts-rk3328_defconfig
> @@ -13,6 +13,7 @@ CONFIG_DEFAULT_DEVICE_TREE=3D"rk3328-orangepi-r1-plus-l=
ts"
>  CONFIG_DM_RESET=3Dy
>  CONFIG_ROCKCHIP_RK3328=3Dy
>  CONFIG_TPL_ROCKCHIP_COMMON_BOARD=3Dy
> +CONFIG_ROCKCHIP_SPI_IMAGE=3Dy
>  CONFIG_TPL_LIBCOMMON_SUPPORT=3Dy
>  CONFIG_TPL_LIBGENERIC_SUPPORT=3Dy
>  CONFIG_SPL_STACK_R_ADDR=3D0x600000
> @@ -20,6 +21,8 @@ CONFIG_SPL_STACK=3D0x400000
>  CONFIG_TPL_SYS_MALLOC_F_LEN=3D0x800
>  CONFIG_DEBUG_UART_BASE=3D0xFF130000
>  CONFIG_DEBUG_UART_CLOCK=3D24000000
> +CONFIG_SPL_SPI_FLASH_SUPPORT=3Dy
> +CONFIG_SPL_SPI=3Dy
>  CONFIG_SYS_LOAD_ADDR=3D0x800800
>  CONFIG_DEBUG_UART=3Dy
>  # CONFIG_ANDROID_BOOT_IMAGE is not set
> @@ -42,6 +45,8 @@ CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_POWER=3Dy
> +CONFIG_SPL_SPI_LOAD=3Dy
> +CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x60000
>  CONFIG_SPL_ATF=3Dy
>  CONFIG_SPL_ATF_NO_PLATFORM_PARAM=3Dy
>  CONFIG_TPL_SYS_MALLOC_SIMPLE=3Dy
> @@ -76,7 +81,10 @@ CONFIG_MISC=3Dy
>  CONFIG_ROCKCHIP_EFUSE=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=3Dy
>  CONFIG_SPI_FLASH_GIGADEVICE=3Dy
> +CONFIG_SPI_FLASH_MACRONIX=3Dy
> +CONFIG_SPI_FLASH_WINBOND=3Dy
>  CONFIG_PHY_MOTORCOMM=3Dy
>  CONFIG_PHY_REALTEK=3Dy
>  CONFIG_DM_ETH_PHY=3Dy
> diff --git a/configs/orangepi-r1-plus-rk3328_defconfig b/configs/orangepi=
-r1-plus-rk3328_defconfig
> index 563a1ac6ecd4..7038f09f202c 100644
> --- a/configs/orangepi-r1-plus-rk3328_defconfig
> +++ b/configs/orangepi-r1-plus-rk3328_defconfig
> @@ -13,6 +13,7 @@ CONFIG_DEFAULT_DEVICE_TREE=3D"rk3328-orangepi-r1-plus"
>  CONFIG_DM_RESET=3Dy
>  CONFIG_ROCKCHIP_RK3328=3Dy
>  CONFIG_TPL_ROCKCHIP_COMMON_BOARD=3Dy
> +CONFIG_ROCKCHIP_SPI_IMAGE=3Dy
>  CONFIG_TPL_LIBCOMMON_SUPPORT=3Dy
>  CONFIG_TPL_LIBGENERIC_SUPPORT=3Dy
>  CONFIG_SPL_STACK_R_ADDR=3D0x600000
> @@ -20,6 +21,8 @@ CONFIG_SPL_STACK=3D0x400000
>  CONFIG_TPL_SYS_MALLOC_F_LEN=3D0x800
>  CONFIG_DEBUG_UART_BASE=3D0xFF130000
>  CONFIG_DEBUG_UART_CLOCK=3D24000000
> +CONFIG_SPL_SPI_FLASH_SUPPORT=3Dy
> +CONFIG_SPL_SPI=3Dy
>  CONFIG_SYS_LOAD_ADDR=3D0x800800
>  CONFIG_DEBUG_UART=3Dy
>  # CONFIG_ANDROID_BOOT_IMAGE is not set
> @@ -42,6 +45,8 @@ CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_POWER=3Dy
> +CONFIG_SPL_SPI_LOAD=3Dy
> +CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x60000
>  CONFIG_SPL_ATF=3Dy
>  CONFIG_SPL_ATF_NO_PLATFORM_PARAM=3Dy
>  CONFIG_TPL_SYS_MALLOC_SIMPLE=3Dy
> @@ -76,7 +81,10 @@ CONFIG_MISC=3Dy
>  CONFIG_ROCKCHIP_EFUSE=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=3Dy
>  CONFIG_SPI_FLASH_GIGADEVICE=3Dy
> +CONFIG_SPI_FLASH_MACRONIX=3Dy
> +CONFIG_SPI_FLASH_WINBOND=3Dy
>  CONFIG_PHY_MOTORCOMM=3Dy
>  CONFIG_PHY_REALTEK=3Dy
>  CONFIG_DM_ETH_PHY=3Dy
> --
> 2.43.0
>
