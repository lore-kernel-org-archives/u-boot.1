Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B2DC28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 17:54:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D070A8144A;
	Sun, 30 Mar 2025 19:54:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uLiYCyr6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A974B812BC; Sun, 30 Mar 2025 19:54:49 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E26381D3B
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 19:54:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christopher.obbard@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cfb6e9031so34866205e9.0
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 10:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743357286; x=1743962086; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Mb7/WOIvDYLzsZRkdl6wcxkidUPeSSZPoPnWH36113g=;
 b=uLiYCyr6EhRsAkbNZB5G2RHCv5vI5uzGjIZJUMAsV03ROHa/nL6HfQTG8scJj0zGnQ
 iol4ZNyFzWTJdWjrCiCBWR5jxhBq42C2kQ+w7Ekc97U5wlhT4kE4HAETqAX/B6xU/vEc
 I3vgzD1vW8GCYBpBdObUCIKzlucuiHv8Xzb+a1ySa2nnoBGqDQ7oCWjdDMtv9mxp61J4
 ZQ4AtERwPI3kcMAf0ABddc+nQ1fGusToNGCDn/Fi0m4yz1a+iwTEIehqHxo9AEdg1yaC
 OeSITqff6Uely+jwM2RSfjGLYZ8+9gCAU39LsZRPWrHcmpdaXRQ8OkQouUNzgXQaDq77
 KqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743357286; x=1743962086;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mb7/WOIvDYLzsZRkdl6wcxkidUPeSSZPoPnWH36113g=;
 b=fvE0cgLlvxypsMgMafDrOmCLl2r+mCYoDzqwAXCunG+dpjg+Z4Nt88TJN8VnTlsnsZ
 9K8wv2reYW80AvHZVu7tmHuEGyGvZNPmr3fvbFZrV0eMvSA2nSCC+4k/apaR2RtIR61I
 OluuVTuxrwnQ8ielO/Ty5OLYQremrJc6LpITtW5vpDmqNrZdoIKqHo2vHbcFIjSpAkw4
 56Bww4MkWyA6KPPkaH8nHcZsta5eXz+138h29DifP2Ra4gcfeLuByX8z6o2TU6IP0HyJ
 xTugTsVCFq32vveCmt0dCxnrZDowhmKxGIavXBcvXSRJhUusA/sCPELkvwKYSDUAIzWp
 3nCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXNX9n/kgv1xmm49KL1/Y8Pxn9lMc4yeeoPgeybZe2MT94qPzlHo+oJYAAATofZn54DGeUylQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxCMXswmXrrXq1BrK1TuqeBVHUrXP7RY5YZPAUbc28UN9tvvdEm
 esUthu1grpdTcA6vVsmjSee07lMYqIRJYCFs3adXQngDogFm8IrKAJIIuBXbI9ASsFyASRwe3qU
 EZtf+3tC7ZZnU8jVG8i03R4c03gsLyQZOai2nTQ==
X-Gm-Gg: ASbGnctyz/hx1lnLlEcnIweedGZKA35NYXF8zXHy1z7MwIjOgS8RsW8N9Wx8XvmEQNy
 4eX+8z4XIki8G2Mb2lCOYNnwBoXLxLEuA3Y+6qQ0vWGZ/gf7RtYzxs/u98Jsr5RBEYRKQaBwNR/
 iyOg4THKnPYVq/wlTDG+aJ4t3O3zSAx7y87SU1mvEh5WfBxjkVfcNliWemlvHDWW5BWUL6CA==
X-Google-Smtp-Source: AGHT+IGaf9lLHTecGQ6ZkI9pMc6GP18zE1LmOfluPeqsdSJhtOmJrnHhgTdb8iLgDw3cY17Fw1je6+MBLYLBKu2FepI=
X-Received: by 2002:a05:6000:22c7:b0:390:fc5a:91c8 with SMTP id
 ffacd0b85a97d-39c1211df1bmr4121777f8f.53.1743357285740; Sun, 30 Mar 2025
 10:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250330172040.3370919-1-jonas@kwiboo.se>
 <20250330172040.3370919-3-jonas@kwiboo.se>
In-Reply-To: <20250330172040.3370919-3-jonas@kwiboo.se>
From: Christopher Obbard <christopher.obbard@linaro.org>
Date: Sun, 30 Mar 2025 18:54:35 +0100
X-Gm-Features: AQ5f1JpSHiLEkq6cTRCxuuWBB50ljppbOefDY7BGYjxhPqTJQjPG78eAY8AgBP4
Message-ID: <CACr-zFDuhqZgfr7x+4eNJqOHUJ4an1WdSH0_oO1WzMC2K0_yfg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] board: rockchip: Add minimal generic RK3399 board
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
> Add a minimal generic RK3399 board that only have eMMC, SDMMC, SPI flash
> and USB OTG enabled. This defconfig can be used to boot from eMMC,
> SD-card or SPI flash on most RK3399 boards that follow reference board
> design.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Christopher Obbard <christopher.obbard@linaro.org>

> ---
> v2: Add CONFIG_ROCKCHIP_IODOMAIN is not set
> ---
>  arch/arm/dts/rk3399-generic-u-boot.dtsi | 10 +++
>  arch/arm/dts/rk3399-generic.dts         | 83 +++++++++++++++++++++++++
>  board/rockchip/evb_rk3399/MAINTAINERS   |  6 ++
>  configs/generic-rk3399_defconfig        | 77 +++++++++++++++++++++++
>  doc/board/rockchip/rockchip.rst         |  1 +
>  5 files changed, 177 insertions(+)
>  create mode 100644 arch/arm/dts/rk3399-generic-u-boot.dtsi
>  create mode 100644 arch/arm/dts/rk3399-generic.dts
>  create mode 100644 configs/generic-rk3399_defconfig
>
> diff --git a/arch/arm/dts/rk3399-generic-u-boot.dtsi b/arch/arm/dts/rk3399-generic-u-boot.dtsi
> new file mode 100644
> index 000000000000..d977b642f8d7
> --- /dev/null
> +++ b/arch/arm/dts/rk3399-generic-u-boot.dtsi
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3399-u-boot.dtsi"
> +
> +&spi1 {
> +       flash@0 {
> +               bootph-pre-ram;
> +               bootph-some-ram;
> +       };
> +};
> diff --git a/arch/arm/dts/rk3399-generic.dts b/arch/arm/dts/rk3399-generic.dts
> new file mode 100644
> index 000000000000..c698f59c565d
> --- /dev/null
> +++ b/arch/arm/dts/rk3399-generic.dts
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Minimal generic DT for RK3399 with eMMC, SD-card, SPI flash and USB OTG enabled
> + */
> +
> +/dts-v1/;
> +#include "rk3399.dtsi"
> +
> +/ {
> +       model = "Generic RK3399";
> +       compatible = "rockchip,rk3399";
> +
> +       aliases {
> +               mmc0 = &sdhci;
> +               mmc1 = &sdmmc;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial2:1500000n8";
> +       };
> +};
> +
> +&emmc_phy {
> +       status = "okay";
> +};
> +
> +&sdhci {
> +       bus-width = <8>;
> +       cap-mmc-highspeed;
> +       max-frequency = <150000000>;
> +       mmc-hs200-1_8v;
> +       mmc-ddr-1_8v;
> +       no-sd;
> +       no-sdio;
> +       non-removable;
> +       status = "okay";
> +};
> +
> +&sdmmc {
> +       bus-width = <4>;
> +       cap-sd-highspeed;
> +       disable-wp;
> +       max-frequency = <150000000>;
> +       no-mmc;
> +       no-sdio;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&sdmmc_bus4 &sdmmc_clk &sdmmc_cmd &sdmmc_cd>;
> +       status = "okay";
> +};
> +
> +&spi1 {
> +       status = "okay";
> +
> +       flash@0 {
> +               compatible = "jedec,spi-nor";
> +               reg = <0>;
> +               spi-max-frequency = <25000000>;
> +       };
> +};
> +
> +&u2phy0 {
> +       status = "okay";
> +};
> +
> +&u2phy0_otg {
> +       status = "okay";
> +};
> +
> +&uart2 {
> +       status = "okay";
> +};
> +
> +&usbdrd3_0 {
> +       status = "okay";
> +};
> +
> +&usbdrd_dwc3_0 {
> +       dr_mode = "peripheral";
> +       maximum-speed = "high-speed";
> +       phys = <&u2phy0_otg>;
> +       phy-names = "usb2-phy";
> +       status = "okay";
> +};
> diff --git a/board/rockchip/evb_rk3399/MAINTAINERS b/board/rockchip/evb_rk3399/MAINTAINERS
> index 8dab3fa70f56..8319db2e976c 100644
> --- a/board/rockchip/evb_rk3399/MAINTAINERS
> +++ b/board/rockchip/evb_rk3399/MAINTAINERS
> @@ -14,6 +14,12 @@ S:      Maintained
>  F:     configs/eaidk-610-rk3399_defconfig
>  F:     arch/arm/dts/rk3399-eaidk-610*
>
> +GENERIC-RK3399
> +M:     Jonas Karlman <jonas@kwiboo.se>
> +S:     Maintained
> +F:     configs/generic-rk3399_defconfig
> +F:     arch/arm/dts/rk3399-generic*
> +
>  KHADAS-EDGE
>  M:     Nick Xie <nick@khadas.com>
>  S:     Maintained
> diff --git a/configs/generic-rk3399_defconfig b/configs/generic-rk3399_defconfig
> new file mode 100644
> index 000000000000..3abe65bcd68a
> --- /dev/null
> +++ b/configs/generic-rk3399_defconfig
> @@ -0,0 +1,77 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_SF_DEFAULT_SPEED=25000000
> +CONFIG_DEFAULT_DEVICE_TREE="rk3399-generic"
> +CONFIG_DM_RESET=y
> +CONFIG_ROCKCHIP_RK3399=y
> +CONFIG_ROCKCHIP_EXTERNAL_TPL=y
> +CONFIG_ROCKCHIP_SPI_IMAGE=y
> +CONFIG_TARGET_EVB_RK3399=y
> +CONFIG_SYS_LOAD_ADDR=0x800800
> +CONFIG_SF_DEFAULT_BUS=1
> +CONFIG_DEBUG_UART_BASE=0xFF1A0000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_FIT_VERBOSE=y
> +# CONFIG_BOOTMETH_VBE is not set
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-generic.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
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
> +# CONFIG_ADC is not set
> +# CONFIG_USB_FUNCTION_FASTBOOT is not set
> +CONFIG_ROCKCHIP_GPIO=y
> +# CONFIG_ROCKCHIP_IODOMAIN is not set
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_SPI_FLASH_MACRONIX=y
> +CONFIG_SPI_FLASH_SILICONKAISER=y
> +CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_SPI_FLASH_XMC=y
> +CONFIG_SPI_FLASH_XTX=y
> +CONFIG_SPI_FLASH_ZBIT=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SPI=y
> +CONFIG_SYSRESET=y
> +CONFIG_SYSRESET_PSCI=y
> +CONFIG_USB=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_USB_FUNCTION_ROCKUSB=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 6b48187ba79d..5a029afae305 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -84,6 +84,7 @@ List of mainline supported Rockchip boards:
>       - FriendlyElec NanoPi M4 (nanopi-m4-rk3399)
>       - FriendlyElec NanoPi M4B (nanopi-m4b-rk3399)
>       - FriendlyARM NanoPi NEO4 (nanopi-neo4-rk3399)
> +     - Generic RK3399 (generic-rk3399)
>       - Google Bob (chromebook_bob)
>       - Google Kevin (chromebook_kevin)
>       - Khadas Edge (khadas-edge-rk3399)
> --
> 2.49.0
>
