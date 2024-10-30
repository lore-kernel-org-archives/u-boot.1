Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88AF5D74977
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 06:30:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 061E088F83;
	Wed, 30 Oct 2024 07:30:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="PpAizRYv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7242388D29; Wed, 30 Oct 2024 07:30:17 +0100 (CET)
Received: from mail-m118114.qiye.163.com (mail-m118114.qiye.163.com
 [115.236.118.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2406188F83
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 07:30:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 14605777;
 Wed, 30 Oct 2024 14:30:07 +0800 (GMT+08:00)
Message-ID: <30b77026-d2d1-4823-bb73-ea915673bb78@rock-chips.com>
Date: Wed, 30 Oct 2024 14:30:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rockchip: add support for Radxa ROCK 5A with SPI NOR
 flash module
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: eugen.hristev@linaro.org, jonas@kwiboo.se, sjg@chromium.org,
 philipp.tomsich@vrull.eu
References: <20241030060727.1116-1-naoki@radxa.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241030060727.1116-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUoaH1YfSh9DSEpMQhgeHkpWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92dc1e02cf03afkunm14605777
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pkk6ERw*TzIsLQNCDUk9NjIM
 ERVPFBhVSlVKTEhLSU1CQ0tDSEJOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOTUpKNwY+
DKIM-Signature: a=rsa-sha256;
 b=PpAizRYvS0vXEItoL8jtxdNxNMfvXiI0qicCnLEG7R++1oWI/GOH7dnaoxtV7VsnVp/kaWRWobaXH6IOM4EwY40BiM8NbWnnarLh9flRTFB1TcGKRqCUShDw3ysXNVq9XMecW3Vp4cUsxaVLns6864NdCJ7tljt2KpuaDrdYRRg=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=gEfu0juBsifnLWb/wGCwi6HKPPTaOslNmAgrixrEdVI=;
 h=date:mime-version:subject:message-id:from;
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

Hi Naoki,

On 2024/10/30 14:07, FUKAUMI Naoki wrote:
> on Radxa ROCK 5A, sdhci(eMMC) and fspim0(SPI NOR flash) share pins
> (i.e. eMMC and SPI NOR flash are exclusive), new defconfig and dts
> specifically for SPI NOR flash is required.
>
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> ---
> Changes in v3
> - drop first patch
> - fix copyright
> - run savedefconfig
> - sync with changes for LED for Radxa boards
> - add more SPI NOR flash chips
> Changes in v2
> - fix subject
> ---
>   arch/arm/dts/rk3588s-rock-5a-spi-u-boot.dtsi | 32 +++++++
>   arch/arm/dts/rk3588s-rock-5a-spi.dts         |  4 +
>   board/radxa/rock5a-rk3588s/MAINTAINERS       |  5 +-
>   configs/rock5a-spi-rk3588s_defconfig         | 87 ++++++++++++++++++++
>   4 files changed, 125 insertions(+), 3 deletions(-)
>   create mode 100644 arch/arm/dts/rk3588s-rock-5a-spi-u-boot.dtsi
>   create mode 100644 arch/arm/dts/rk3588s-rock-5a-spi.dts
>   create mode 100644 configs/rock5a-spi-rk3588s_defconfig
>
> diff --git a/arch/arm/dts/rk3588s-rock-5a-spi-u-boot.dtsi b/arch/arm/dts/rk3588s-rock-5a-spi-u-boot.dtsi
> new file mode 100644
> index 00000000000..7723931d869
> --- /dev/null
> +++ b/arch/arm/dts/rk3588s-rock-5a-spi-u-boot.dtsi
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2024 Radxa Computer (Shenzhen) Co., Ltd.
> + */
> +
> +#include "rk3588s-u-boot.dtsi"
> +
> +/ {
> +	leds {
> +		io-led {
> +			default-state = "on";
> +		};
> +	};
> +};
> +
> +&fspim0_pins {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&sdhci {
> +	status = "disabled";
> +};
> +
> +&sfc {
> +	status = "okay";
> +
> +	flash@0 {
> +		bootph-pre-ram;
> +		bootph-some-ram;
> +	};
> +};
> diff --git a/arch/arm/dts/rk3588s-rock-5a-spi.dts b/arch/arm/dts/rk3588s-rock-5a-spi.dts
> new file mode 100644
> index 00000000000..780e90d041b
> --- /dev/null
> +++ b/arch/arm/dts/rk3588s-rock-5a-spi.dts
> @@ -0,0 +1,4 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +#include "rk3588s-rock-5a.dts"
> diff --git a/board/radxa/rock5a-rk3588s/MAINTAINERS b/board/radxa/rock5a-rk3588s/MAINTAINERS
> index a569efa74e3..06ebc9829f4 100644
> --- a/board/radxa/rock5a-rk3588s/MAINTAINERS
> +++ b/board/radxa/rock5a-rk3588s/MAINTAINERS
> @@ -4,6 +4,5 @@ R:	Jonas Karlman <jonas@kwiboo.se>
>   S:	Maintained
>   F:	board/radxa/rock5a-rk3588s
>   F:	include/configs/rock5a-rk3588s.h
> -F:	configs/rock5a-rk3588s_defconfig
> -F:	arch/arm/dts/rk3588s-rock-5a.dts
> -F:	arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
> +F:	configs/rock5a*
> +F:	arch/arm/dts/rk3588s-rock-5a*
> diff --git a/configs/rock5a-spi-rk3588s_defconfig b/configs/rock5a-spi-rk3588s_defconfig
> new file mode 100644
> index 00000000000..d6409a12a56
> --- /dev/null
> +++ b/configs/rock5a-spi-rk3588s_defconfig
> @@ -0,0 +1,87 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SF_DEFAULT_SPEED=24000000
> +CONFIG_SF_DEFAULT_MODE=0x2000
> +CONFIG_DEFAULT_DEVICE_TREE="rk3588s-rock-5a-spi"
> +CONFIG_ROCKCHIP_RK3588=y
> +CONFIG_ROCKCHIP_SPI_IMAGE=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_TARGET_ROCK5A_RK3588=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_SF_DEFAULT_BUS=5
> +CONFIG_DEBUG_UART_BASE=0xFEB50000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-rock-5a.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
MMC should removed
> +CONFIG_CMD_USB=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +# CONFIG_OF_UPSTREAM is not set
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_SPL_CLK=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_MISC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y

MMC relate driver should removed


Thanks,
- Kever
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_SPI_FLASH_MACRONIX=y
> +CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_SPI_FLASH_XTX=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_PHY_ROCKCHIP_USBDP=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_SPL_RAM=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SFC=y
> +CONFIG_SYSRESET=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_ERRNO_STR=y
