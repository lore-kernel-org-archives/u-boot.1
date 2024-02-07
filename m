Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9248C4828D
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 09:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 599CA87CE1;
	Wed,  7 Feb 2024 10:54:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hamvb0q0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98B8B87CE6; Wed,  7 Feb 2024 10:54:19 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8847E876AE
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 10:54:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=cnsztl@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a3884b1a441so31182766b.2
 for <u-boot@lists.denx.de>; Wed, 07 Feb 2024 01:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707299657; x=1707904457; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IOM0vLOr65LT2rFSXLPFB36fsKpSagetVQqH19oUMRc=;
 b=hamvb0q0jDHS9s+ccP8TI+S9hOTxhsg+zh3CQg6/BxLu1VV9Mu9K/g561AsbnP8N9M
 9SRf9XjNOA00FKhUELhklYSud1JBhUtRi1I+5NI0OC4eKO4Bm66TQFhhhwe94MjKEwtA
 8aqQL/nmdzeO1H6Cjo3fBuvLoSV01RltpThhERbBEnJ7w0v0ZQtpepqkKuFTCaQ3bpSE
 fTfljQX9GIdRzWdPVgF0sMLwYakOdsG85rejST44ccOnNA8by7QJ1H3n79OH9qnRGLOs
 bbP1xUiivFebnct5BMPZd263IrgRhOuZ76DpMHlhImja4EnVbbxTBQNsxV8FuJRPiwfZ
 lS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707299657; x=1707904457;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IOM0vLOr65LT2rFSXLPFB36fsKpSagetVQqH19oUMRc=;
 b=LZIkDMGLKlvMCmfQhdbVQykoGoi53frlPBYrhSGt0OrUi50UxQs/NOv6IYzBcjNzNG
 pRFfv9Jt8couENB7w0j2t3OLFH9jWrfy9SeqdDCpq9Hc3jVxwx4zfgtrgpJL7MGY0GEz
 SVUC49mIM3NPpP223QBa/KRpIWYllLIP6+UIZHDevpwk5zcyokMQQNXqAaSLbGOAYM9p
 Hxx5QTQNklmopRc1GZhDH7S1tCjqFeh23HGKF2MdtOBrK9t+ua9DpasGa+3haZLYNn4G
 6HT9hvhZLooUmMn9h2U65tyDCNJN8RzAXqFEFAgLM9jbzQvKVK4jV6gxknA73c6HkZVm
 1oTg==
X-Gm-Message-State: AOJu0YxeErDrS2tezapA5BYi7VbBQMbf0ipwk7KLG0yv3CR3/X7UO0cG
 jlSWKRwnimVT+yq3gJr5iU9La6bspHNByuTftfr0G0R9AKP6J2ypGHStjcLV7fTr3NG7Aub6b04
 HFlZLCx19bWtMcttKELY2Gx0xZ8xb6Q3PxudrbAOA
X-Google-Smtp-Source: AGHT+IEWhVPw3wK7WkfIWrLzcJYm0nEvMW7KaBV+sfqZwFyp28JRq7De4icMmOC5XlHr4CR05xvxt+2PhZoPpi/Ui6Q=
X-Received: by 2002:a17:906:5607:b0:a38:634f:bdc6 with SMTP id
 f7-20020a170906560700b00a38634fbdc6mr1247799ejq.20.1707299656215; Wed, 07 Feb
 2024 01:54:16 -0800 (PST)
MIME-Version: 1.0
References: <20240207000301.3270722-1-jonas@kwiboo.se>
 <20240207000301.3270722-8-jonas@kwiboo.se>
In-Reply-To: <20240207000301.3270722-8-jonas@kwiboo.se>
From: Tianling Shen <cnsztl@gmail.com>
Date: Wed, 7 Feb 2024 17:54:03 +0800
Message-ID: <CAOP2_Thh6bg5aHOEva4Lg09xy1RoXW4RZy5kb+E12RvSOB0n_A@mail.gmail.com>
Subject: Re: [PATCH 07/15] rockchip: rk3328-orangepi-r1-plus: Update defconfig
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

On Wed, Feb 7, 2024 at 9:06=E2=80=AFAM Jonas Karlman <jonas@kwiboo.se> wrot=
e:
>
> Update defconfig for rk3328-orangepi-r1-plus boards with new defaults.
>
> Remove the SPL_DRIVERS_MISC=3Dy option, no misc driver is used in SPL.
>
> Add CONFIG_SPL_FIT_SIGNATURE=3Dy to let SPL verify an auto generated hash
> of FIT images. This help indicate if there is an issue loading any of
> the images to DRAM or SRAM. Also add LEGACY_IMAGE_FORMAT=3Dy to keep
> support for scripts.
>
> Add ROCKCHIP_EFUSE=3Dy and remove NET_RANDOM_ETHADDR=3Dy, ethaddr and
> eth1addr is set based on cpuid read from eFUSE.
>
> Add SPL_DM_SEQ_ALIAS=3Dy option to use alias sequence number in SPL.
>
> Add DM_ETH_PHY=3Dy, PHY_MOTORCOMM=3Dy, PHY_REALTEK=3Dy and remove &gmac2i=
o to
> support reset of onboard ethernet PHYs.
>
> Add PHY_ROCKCHIP_INNO_USB2=3Dy option to support the onboard USB PHY.
>
> Add RNG_ROCKCHIP=3Dy and DM_RNG=3Dy options to support the onboard random
> generator.
>
> Also add missing device tree files to MAINTAINERS file.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Tianling Shen <cnsztl@gmail.com>

Best regards,
Tianling.

> ---
>  arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi |  6 ------
>  arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi     |  6 ------
>  board/rockchip/evb_rk3328/MAINTAINERS                |  2 ++
>  configs/orangepi-r1-plus-lts-rk3328_defconfig        | 12 ++++++++++--
>  configs/orangepi-r1-plus-rk3328_defconfig            | 12 ++++++++++--
>  doc/board/rockchip/rockchip.rst                      |  2 ++
>  6 files changed, 24 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi b/arch/=
arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
> index 5aaa5ccb15c1..8a4189c6f1cc 100644
> --- a/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
> @@ -28,12 +28,6 @@
>         bootph-pre-ram;
>  };
>
> -&gmac2io {
> -       snps,reset-gpio =3D <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
> -       snps,reset-active-low;
> -       snps,reset-delays-us =3D <0 10000 50000>;
> -};
> -
>  &spi0 {
>         spi_flash: spiflash@0 {
>                 bootph-all;
> diff --git a/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi b/arch/arm/=
dts/rk3328-orangepi-r1-plus-u-boot.dtsi
> index 6d3db86dce6a..2e3b6a77a268 100644
> --- a/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
> @@ -28,12 +28,6 @@
>         bootph-pre-ram;
>  };
>
> -&gmac2io {
> -       snps,reset-gpio =3D <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
> -       snps,reset-active-low;
> -       snps,reset-delays-us =3D <0 10000 50000>;
> -};
> -
>  &spi0 {
>         spi_flash: spiflash@0 {
>                 bootph-all;
> diff --git a/board/rockchip/evb_rk3328/MAINTAINERS b/board/rockchip/evb_r=
k3328/MAINTAINERS
> index b88727acad26..675b72dd060c 100644
> --- a/board/rockchip/evb_rk3328/MAINTAINERS
> +++ b/board/rockchip/evb_rk3328/MAINTAINERS
> @@ -32,12 +32,14 @@ ORANGEPI-R1-PLUS-RK3328
>  M:      Tianling Shen <cnsztl@gmail.com>
>  S:      Maintained
>  F:      configs/orangepi-r1-plus-rk3328_defconfig
> +F:      arch/arm/dts/rk3328-orangepi-r1-plus.dts
>  F:      arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
>
>  ORANGEPI-R1-PLUS-LTS-RK3328
>  M:      Tianling Shen <cnsztl@gmail.com>
>  S:      Maintained
>  F:      configs/orangepi-r1-plus-lts-rk3328_defconfig
> +F:      arch/arm/dts/rk3328-orangepi-r1-plus-lts.dts
>  F:      arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
>
>  ROC-RK3328-CC
> diff --git a/configs/orangepi-r1-plus-lts-rk3328_defconfig b/configs/oran=
gepi-r1-plus-lts-rk3328_defconfig
> index d3d9417509e9..937ef003d85b 100644
> --- a/configs/orangepi-r1-plus-lts-rk3328_defconfig
> +++ b/configs/orangepi-r1-plus-lts-rk3328_defconfig
> @@ -15,7 +15,6 @@ CONFIG_ROCKCHIP_RK3328=3Dy
>  CONFIG_TPL_ROCKCHIP_COMMON_BOARD=3Dy
>  CONFIG_TPL_LIBCOMMON_SUPPORT=3Dy
>  CONFIG_TPL_LIBGENERIC_SUPPORT=3Dy
> -CONFIG_SPL_DRIVERS_MISC=3Dy
>  CONFIG_SPL_STACK_R_ADDR=3D0x600000
>  CONFIG_SPL_STACK=3D0x400000
>  CONFIG_TPL_SYS_MALLOC_F_LEN=3D0x800
> @@ -26,7 +25,9 @@ CONFIG_DEBUG_UART=3Dy
>  # CONFIG_ANDROID_BOOT_IMAGE is not set
>  CONFIG_FIT=3Dy
>  CONFIG_FIT_VERBOSE=3Dy
> +CONFIG_SPL_FIT_SIGNATURE=3Dy
>  CONFIG_SPL_LOAD_FIT=3Dy
> +CONFIG_LEGACY_IMAGE_FORMAT=3Dy
>  CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3328-orangepi-r1-plus-lts.dtb"
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> @@ -57,8 +58,8 @@ CONFIG_TPL_OF_PLATDATA=3Dy
>  CONFIG_ENV_IS_IN_MMC=3Dy
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
>  CONFIG_SYS_MMC_ENV_DEV=3D1
> -CONFIG_NET_RANDOM_ETHADDR=3Dy
>  CONFIG_TPL_DM=3Dy
> +CONFIG_SPL_DM_SEQ_ALIAS=3Dy
>  CONFIG_REGMAP=3Dy
>  CONFIG_SPL_REGMAP=3Dy
>  CONFIG_TPL_REGMAP=3Dy
> @@ -72,11 +73,16 @@ CONFIG_FASTBOOT_CMD_OEM_FORMAT=3Dy
>  CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
>  CONFIG_MISC=3Dy
> +CONFIG_ROCKCHIP_EFUSE=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_SPI_FLASH_GIGADEVICE=3Dy
> +CONFIG_PHY_MOTORCOMM=3Dy
> +CONFIG_PHY_REALTEK=3Dy
> +CONFIG_DM_ETH_PHY=3Dy
>  CONFIG_ETH_DESIGNWARE=3Dy
>  CONFIG_GMAC_ROCKCHIP=3Dy
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=3Dy
>  CONFIG_PINCTRL=3Dy
>  CONFIG_SPL_PINCTRL=3Dy
>  CONFIG_DM_PMIC=3Dy
> @@ -91,6 +97,8 @@ CONFIG_PWM_ROCKCHIP=3Dy
>  CONFIG_RAM=3Dy
>  CONFIG_SPL_RAM=3Dy
>  CONFIG_TPL_RAM=3Dy
> +CONFIG_DM_RNG=3Dy
> +CONFIG_RNG_ROCKCHIP=3Dy
>  CONFIG_BAUDRATE=3D1500000
>  CONFIG_DEBUG_UART_SHIFT=3D2
>  CONFIG_SYS_NS16550_MEM32=3Dy
> diff --git a/configs/orangepi-r1-plus-rk3328_defconfig b/configs/orangepi=
-r1-plus-rk3328_defconfig
> index 9356e87132e7..563a1ac6ecd4 100644
> --- a/configs/orangepi-r1-plus-rk3328_defconfig
> +++ b/configs/orangepi-r1-plus-rk3328_defconfig
> @@ -15,7 +15,6 @@ CONFIG_ROCKCHIP_RK3328=3Dy
>  CONFIG_TPL_ROCKCHIP_COMMON_BOARD=3Dy
>  CONFIG_TPL_LIBCOMMON_SUPPORT=3Dy
>  CONFIG_TPL_LIBGENERIC_SUPPORT=3Dy
> -CONFIG_SPL_DRIVERS_MISC=3Dy
>  CONFIG_SPL_STACK_R_ADDR=3D0x600000
>  CONFIG_SPL_STACK=3D0x400000
>  CONFIG_TPL_SYS_MALLOC_F_LEN=3D0x800
> @@ -26,7 +25,9 @@ CONFIG_DEBUG_UART=3Dy
>  # CONFIG_ANDROID_BOOT_IMAGE is not set
>  CONFIG_FIT=3Dy
>  CONFIG_FIT_VERBOSE=3Dy
> +CONFIG_SPL_FIT_SIGNATURE=3Dy
>  CONFIG_SPL_LOAD_FIT=3Dy
> +CONFIG_LEGACY_IMAGE_FORMAT=3Dy
>  CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3328-orangepi-r1-plus.dtb"
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> @@ -57,8 +58,8 @@ CONFIG_TPL_OF_PLATDATA=3Dy
>  CONFIG_ENV_IS_IN_MMC=3Dy
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
>  CONFIG_SYS_MMC_ENV_DEV=3D1
> -CONFIG_NET_RANDOM_ETHADDR=3Dy
>  CONFIG_TPL_DM=3Dy
> +CONFIG_SPL_DM_SEQ_ALIAS=3Dy
>  CONFIG_REGMAP=3Dy
>  CONFIG_SPL_REGMAP=3Dy
>  CONFIG_TPL_REGMAP=3Dy
> @@ -72,11 +73,16 @@ CONFIG_FASTBOOT_CMD_OEM_FORMAT=3Dy
>  CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
>  CONFIG_MISC=3Dy
> +CONFIG_ROCKCHIP_EFUSE=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_SPI_FLASH_GIGADEVICE=3Dy
> +CONFIG_PHY_MOTORCOMM=3Dy
> +CONFIG_PHY_REALTEK=3Dy
> +CONFIG_DM_ETH_PHY=3Dy
>  CONFIG_ETH_DESIGNWARE=3Dy
>  CONFIG_GMAC_ROCKCHIP=3Dy
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=3Dy
>  CONFIG_PINCTRL=3Dy
>  CONFIG_SPL_PINCTRL=3Dy
>  CONFIG_DM_PMIC=3Dy
> @@ -91,6 +97,8 @@ CONFIG_PWM_ROCKCHIP=3Dy
>  CONFIG_RAM=3Dy
>  CONFIG_SPL_RAM=3Dy
>  CONFIG_TPL_RAM=3Dy
> +CONFIG_DM_RNG=3Dy
> +CONFIG_RNG_ROCKCHIP=3Dy
>  CONFIG_BAUDRATE=3D1500000
>  CONFIG_DEBUG_UART_SHIFT=3D2
>  CONFIG_SYS_NS16550_MEM32=3Dy
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchi=
p.rst
> index 77360e0ff155..f65381cc7b0b 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -66,6 +66,8 @@ List of mainline supported Rockchip boards:
>       - FriendlyElec NanoPi R2S (nanopi-r2s-rk3328)
>       - Pine64 Rock64 (rock64-rk3328)
>       - Radxa ROCK Pi E (rock-pi-e-rk3328)
> +     - Xunlong Orange Pi R1 Plus (orangepi-r1-plus-rk3328)
> +     - Xunlong Orange Pi R1 Plus LTS (orangepi-r1-plus-lts-rk3328)
>  * rk3368
>       - GeekBox (geekbox)
>       - PX5 EVB (evb-px5)
> --
> 2.43.0
>
