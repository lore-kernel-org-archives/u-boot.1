Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AE7C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 17:54:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CBAB81E5A;
	Sun, 30 Mar 2025 19:54:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hEkxz+fh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 224A281D3B; Sun, 30 Mar 2025 19:54:34 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1BD68171B
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 19:54:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christopher.obbard@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so21215445e9.2
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 10:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743357270; x=1743962070; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1Sa4PplqDG5bqyqW7OrWPGJTFzpmshoOcmgTgcof1SM=;
 b=hEkxz+fhO2ihOs5KM/zTlarL6RauEK7ikX8exvxOqVDG2dJOD5gJAPWafIjELftunh
 5Pxlc01i/1rUgTvzsBTrBn+zQ5J+7RMChtq6NS9jiX1hFhDbr0UGjvLe4Dps5T6SfhYr
 fNqvaeMGktbaxfRjgo/KOg19fuMCK2/f4g397gLZJHnIXHt9NhCvwKeqhAYoquCyYa/V
 otXkog0zP0VOz2QNak4m3+2DsZxssf66y2BGI0UuBnVhtWbNFRoB6clIVZEADG7YVa2b
 0N1pqUaU/QnN0G/yb8YDUomdwJOZfjmyrJIrbE78tnhVZDsWKK+R2aY4ep90aEf29Gc1
 tZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743357270; x=1743962070;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1Sa4PplqDG5bqyqW7OrWPGJTFzpmshoOcmgTgcof1SM=;
 b=ZMQsiIki70eeR7VUBB5Kt0H+FbrJxO+K5gogi5piZGm+owVKxDo2akYokqLEX+yADE
 J79cI2kFfZLq+fPzAHnnE5BlZ3S/KzEwE07Hsdd84/zgxrf+eHownHU2S1g6/hxiljXd
 +qNRkf7gO5swK5JXA5Ryenl2DoGedxQq7g9PXBwYZSI3Qf6XS4NzZhq3C8Htcm3PrqaM
 gN5dY/O5dEvxRIvki9oxoDibdfMR8FjVmtiJweKKrKGPRfdwXfSBXLC1HOJyOUGfbFJk
 suGhEtVd5afG+EYnZbQMXilx9x9OceboWqV3xe2WTRwHCfbvQZdYSNkMmDxbzXmfPMAe
 WPLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjIrXa8dOy9mhrfIcBoXFLhVlPYoXO7+OMnctWu+/leg6cKevcutdAUsfuPIvw5Hsfa/Pgkds=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1Olyti5IsEOQCjEkUulNDIPwwFloeWAQKkAPyu1WwhcJHrUyy
 eMZ5oyaNzTXpR+g0yBiPJyE237wA/Tjb+YnN7k0oXo5TPPCzuwYqI1zTFt9MxhmVDOyBXGQtXV3
 2tOMF8yc0iWymh7D6OPB+qbRquhw+w3adBesPXg==
X-Gm-Gg: ASbGncsJnMhtJlRiM9Bl6WMkmm/ZKrsdErBp+oKbPIAlDIXDChFfaKr2woZLPXfco4Z
 zj5ET1RRtpII3bpOe21XJE7sjgDKNB8DTwjwHv1oKRh+OwREkxQyU5i3zPRG0y1Jpe2OEHaF6sJ
 i3RtmVsdhr43arhpGIVyXRmR6svyb0FxSMz8VK0IWS4Zl5dEAz2U+sxbTv0FY=
X-Google-Smtp-Source: AGHT+IGDdTPTkMtLTv+g+F4B75BnXX8tkH+Qhb/WpMhaUqWKK4MQ0NVQOtPbo8ncd4iIEXax7YbBFgJtCNzpLUaMqFQ=
X-Received: by 2002:a05:600c:4593:b0:43d:42b:e186 with SMTP id
 5b1f17b1804b1-43db6223038mr53800185e9.8.1743357270053; Sun, 30 Mar 2025
 10:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250330172040.3370919-1-jonas@kwiboo.se>
 <20250330172040.3370919-2-jonas@kwiboo.se>
In-Reply-To: <20250330172040.3370919-2-jonas@kwiboo.se>
From: Christopher Obbard <christopher.obbard@linaro.org>
Date: Sun, 30 Mar 2025 18:54:19 +0100
X-Gm-Features: AQ5f1Jo0PlPCilQZ0loGaxnNXa-7LEDFTrnNtotbbTDmU4amrippdldFcJTgmzc
Message-ID: <CACr-zFD=DKawwHP6Bg7VhQ=Cyp+YCZi0bTDX_h=Cm4NWeq0XHQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] board: rockchip: Add minimal generic RK3328 board
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

Hi Jonas,

On Sun, 30 Mar 2025 at 18:21, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Add a minimal generic RK3328 board that only have eMMC, SDMMC, SPI flash
> and USB OTG enabled. This defconfig can be used to boot from eMMC,
> SD-card or SPI flash on most RK3328 boards that follow reference board
> design.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Christopher Obbard <christopher.obbard@linaro.org>

> ---
> v2: Rebase on next after TPL_HAVE_INIT_STACK change
> ---
>  arch/arm/dts/rk3328-generic-u-boot.dtsi | 39 +++++++++++
>  arch/arm/dts/rk3328-generic.dts         | 76 +++++++++++++++++++++
>  arch/arm/mach-rockchip/Kconfig          |  2 +-
>  board/rockchip/evb_rk3328/MAINTAINERS   |  6 ++
>  configs/generic-rk3328_defconfig        | 90 +++++++++++++++++++++++++
>  doc/board/rockchip/rockchip.rst         |  1 +
>  6 files changed, 213 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/dts/rk3328-generic-u-boot.dtsi
>  create mode 100644 arch/arm/dts/rk3328-generic.dts
>  create mode 100644 configs/generic-rk3328_defconfig
>
> diff --git a/arch/arm/dts/rk3328-generic-u-boot.dtsi b/arch/arm/dts/rk3328-generic-u-boot.dtsi
> new file mode 100644
> index 000000000000..af890e912dda
> --- /dev/null
> +++ b/arch/arm/dts/rk3328-generic-u-boot.dtsi
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3328-u-boot.dtsi"
> +
> +&gpio0 {
> +       /delete-property/ bootph-pre-ram;
> +};
> +
> +&pcfg_pull_down_4ma {
> +       bootph-pre-ram;
> +       bootph-some-ram;
> +};
> +
> +&spi0 {
> +       flash@0 {
> +               bootph-pre-ram;
> +               bootph-some-ram;
> +       };
> +};
> +
> +&spi0m2_clk {
> +       bootph-pre-ram;
> +       bootph-some-ram;
> +};
> +
> +&spi0m2_cs0 {
> +       bootph-pre-ram;
> +       bootph-some-ram;
> +};
> +
> +&spi0m2_rx {
> +       bootph-pre-ram;
> +       bootph-some-ram;
> +};
> +
> +&spi0m2_tx {
> +       bootph-pre-ram;
> +       bootph-some-ram;
> +};
> diff --git a/arch/arm/dts/rk3328-generic.dts b/arch/arm/dts/rk3328-generic.dts
> new file mode 100644
> index 000000000000..af0da8457167
> --- /dev/null
> +++ b/arch/arm/dts/rk3328-generic.dts
> @@ -0,0 +1,76 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Minimal generic DT for RK3328 with eMMC, SD-card, SPI flash and USB OTG enabled
> + */
> +
> +/dts-v1/;
> +#include "rk3328.dtsi"
> +
> +/ {
> +       model = "Generic RK3328";
> +       compatible = "rockchip,rk3328";
> +
> +       aliases {
> +               mmc0 = &emmc;
> +               mmc1 = &sdmmc;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial2:1500000n8";
> +       };
> +};
> +
> +&emmc {
> +       bus-width = <8>;
> +       cap-mmc-highspeed;
> +       mmc-ddr-1_8v;
> +       mmc-hs200-1_8v;
> +       no-sd;
> +       no-sdio;
> +       non-removable;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;
> +       status = "okay";
> +};
> +
> +&sdmmc0m1_pin {
> +       rockchip,pins = <0 RK_PD6 RK_FUNC_GPIO &pcfg_pull_down_4ma>;
> +};
> +
> +&sdmmc {
> +       bus-width = <4>;
> +       cap-sd-highspeed;
> +       disable-wp;
> +       no-mmc;
> +       no-sdio;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&sdmmc0_clk &sdmmc0_cmd &sdmmc0_dectn &sdmmc0_bus4 &sdmmc0m1_pin>;
> +       status = "okay";
> +};
> +
> +&spi0 {
> +       status = "okay";
> +
> +       flash@0 {
> +               compatible = "jedec,spi-nor";
> +               reg = <0>;
> +               spi-max-frequency = <25000000>;
> +       };
> +};
> +
> +&u2phy {
> +       status = "okay";
> +};
> +
> +&u2phy_otg {
> +       status = "okay";
> +};
> +
> +&uart2 {
> +       status = "okay";
> +};
> +
> +&usb20_otg {
> +       dr_mode = "peripheral";
> +       status = "okay";
> +};
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index b61d424ba638..33a9f7a4dd4b 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -201,7 +201,6 @@ config ROCKCHIP_RK3328
>         select SUPPORT_SPL
>         select SPL
>         select SUPPORT_TPL
> -       select TPL
>         select TPL_HAVE_INIT_STACK if TPL
>         imply ARMV8_CRYPTO
>         imply ARMV8_SET_SMPEN
> @@ -218,6 +217,7 @@ config ROCKCHIP_RK3328
>         imply SPL_ROCKCHIP_COMMON_BOARD
>         imply SPL_SEPARATE_BSS
>         imply SPL_SERIAL
> +       imply TPL if !ROCKCHIP_EXTERNAL_TPL
>         imply TPL_ROCKCHIP_COMMON_BOARD
>         imply TPL_SERIAL
>         help
> diff --git a/board/rockchip/evb_rk3328/MAINTAINERS b/board/rockchip/evb_rk3328/MAINTAINERS
> index 5f81be55b8e0..8c9b42fe2bbf 100644
> --- a/board/rockchip/evb_rk3328/MAINTAINERS
> +++ b/board/rockchip/evb_rk3328/MAINTAINERS
> @@ -7,6 +7,12 @@ F:      configs/evb-rk3328_defconfig
>  F:      arch/arm/dts/rk3328-evb.dts
>  F:      arch/arm/dts/rk3328-evb-u-boot.dtsi
>
> +GENERIC-RK3328
> +M:     Jonas Karlman <jonas@kwiboo.se>
> +S:     Maintained
> +F:     configs/generic-rk3328_defconfig
> +F:     arch/arm/dts/rk3328-generic*
> +
>  NANOPI-R2C-RK3328
>  M:      Tianling Shen <cnsztl@gmail.com>
>  S:      Maintained
> diff --git a/configs/generic-rk3328_defconfig b/configs/generic-rk3328_defconfig
> new file mode 100644
> index 000000000000..8d34a293fd42
> --- /dev/null
> +++ b/configs/generic-rk3328_defconfig
> @@ -0,0 +1,90 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_SF_DEFAULT_SPEED=25000000
> +CONFIG_DEFAULT_DEVICE_TREE="rk3328-generic"
> +CONFIG_DM_RESET=y
> +CONFIG_ROCKCHIP_RK3328=y
> +CONFIG_ROCKCHIP_EXTERNAL_TPL=y
> +CONFIG_ROCKCHIP_SPI_IMAGE=y
> +CONFIG_SYS_LOAD_ADDR=0x800800
> +CONFIG_DEBUG_UART_BASE=0xFF130000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +# CONFIG_BOOTMETH_VBE is not set
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-generic.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
> +CONFIG_SPL_ATF=y
> +CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> +CONFIG_CMD_MEMINFO=y
> +CONFIG_CMD_MEMINFO_MAP=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_MISC=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_ROCKUSB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_RNG=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +# CONFIG_OF_UPSTREAM is not set
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_NO_NET=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_REGMAP=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SYSCON=y
> +CONFIG_SPL_SYSCON=y
> +# CONFIG_ADC is not set
> +CONFIG_CLK=y
> +CONFIG_SPL_CLK=y
> +# CONFIG_USB_FUNCTION_FASTBOOT is not set
> +CONFIG_ROCKCHIP_GPIO=y
> +# CONFIG_ROCKCHIP_IODOMAIN is not set
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_SPI_FLASH_MACRONIX=y
> +CONFIG_SPI_FLASH_SILICONKAISER=y
> +CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_SPI_FLASH_XMC=y
> +CONFIG_SPI_FLASH_XTX=y
> +CONFIG_SPI_FLASH_ZBIT=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PINCTRL=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_RAM=y
> +CONFIG_SPL_RAM=y
> +CONFIG_DM_RNG=y
> +CONFIG_RNG_ROCKCHIP=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SPI=y
> +CONFIG_SYSRESET=y
> +CONFIG_SYSRESET_PSCI=y
> +CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_DWC2_OTG=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_USB_FUNCTION_ROCKUSB=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 1407080f1f4f..6b48187ba79d 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -66,6 +66,7 @@ List of mainline supported Rockchip boards:
>       - FriendlyElec NanoPi R2C Plus (nanopi-r2c-plus-rk3328)
>       - FriendlyElec NanoPi R2S (nanopi-r2s-rk3328)
>       - FriendlyElec NanoPi R2S Plus (nanopi-r2s-plus-rk3328)
> +     - Generic RK3328 (generic-rk3328)
>       - Pine64 Rock64 (rock64-rk3328)
>       - Radxa ROCK Pi E (rock-pi-e-rk3328)
>       - Xunlong Orange Pi R1 Plus (orangepi-r1-plus-rk3328)
> --
> 2.49.0
>
