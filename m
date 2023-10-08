Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FF9E95A82
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 08:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1F5286801;
	Sun,  8 Oct 2023 10:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="G8XkGsaU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62FEE86898; Sun,  8 Oct 2023 10:23:42 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CABDB866AA
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 10:23:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=6fed=FW=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: References: Cc:
 To: Subject: From: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1696753411;
 bh=Fgr4K4Vlo6+6wzLEYHL1xdG7y4GgpQIB4jxi4NoZ84M=;
 b=G8XkGsaUf/Raz+IZVWbDtNKsE1JfFJRNASYN3bdNun+nx5U/J+Ibj4u/Jjk2IeDKjXhrjPvs7
 MgD2topRbTATEZHnXntT2+IutOup1Ny2vr4HbdLv6Ev3GR3p7GBuzBMGZTRokXpmwiyKwNOKuxm
 mjZWq7tzcpE4pndToJO7xy6wSIVTwORZ1L2nJq5EfFS0RvLAeK2zLPWQLsyPSahiEqAPEt1hbSq
 SEb5vx9VlcH6+Vz6jYb7vu+8ZPxkzH/s3LFUGBdhkivdIv1uiWxuJDAI/p/VVp8h6nuS3lZ7P38
 Q3O/l+n7OVKaaZAoUQbw49l0i4A6dBmNx9PCN9GGLCVg==
Message-ID: <df2e3613-a7ad-d945-3620-eaaa2675cfc1@kwiboo.se>
Date: Sun, 8 Oct 2023 10:23:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From: Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH] board: rockchip: add FriendlyElec NanoPC-T6 rk3588 board
To: John Clark <inindev@gmail.com>, Kever Yang <kever.yang@rock-chips.com>
Cc: Eugen Hristev <eugen.hristev@collabora.com>, Jagan Teki
 <jagan@edgeble.ai>, Philipp Tomsich
 <philipp.tomsich@theobroma-systems.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20231007212552.11109-1-inindev@gmail.com>
Content-Language: en-US
In-Reply-To: <20231007212552.11109-1-inindev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 652267035ad66b81e81eddfc
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

Hi John,

Quick feedback below, will look at schematics and runtime test later.

On 2023-10-07 23:25, John Clark wrote:
> NanoPC-T6 is a Rockchip RK3588 based SBC by FriendlyElec.
> 
> There are four variants depending on the DRAM size: 4G/32GB eMMC, 8G/64GB eMMC,
> 16G/16MB SPI NOR, and 16G/256GB eMMC/16MB SPI NOR
> 
> Specifications:
>     CPU: Rockchip RK3588, 4x Cortex-A76 (up to 2.4GHz) + 4x Cortex-A55 (up to 1.8GHz)
>     GPU: Mali-G610 MP4
>     VPU: 8K@60fps H.265 and VP9 decoder, 8K@30fps H.264 decoder,
>          4K@60fps AV1 decoder, 8K@30fps H.264 and H.265 encoder
>     NPU: 6TOPs, supports INT4/INT8/INT16/FP16
>     RAM: 64-bit 4GB/8GB/16GB LPDDR4X at 2133MHz
>     eMMC: 0GB/32GB/64GB/256GB HS400
>     MicroSD Slot: MicroSD SDR104
>     PCIe 3.0: M.2 M-Key x1, PCIe 3.0 x4 for NVMe SSDs up to 2,500 MB/s
>     Ethernet: PCIe 2.5G 2x Ethernet (RTL8125BG)
>     PCIe 2.1: M.2 E-Key x1, PCIe 2.1 x1 and USB2.0 Host, supports M.2 WiFi and Bluetooth
>     4G Module: MiniPCIe x1, MicroSIM Card Slot x1
>     Audio Out: 3.5mm jack for stereo headphone output
>     Audio In: 2.0mm PH-2A connector for analog microphone input
>     Video Input: standard HDMI input port, up to 4Kp60
>     2x 4-lane MIPI-CSI, compatible with MIPI V1.2
>     Video Output: 2x standard HDMI output ports compatible with HDMI2.1, HDMI2.0, and HDMI1.4
>     2x 4-lane MIPI-DSI, compatible with MIPI DPHY 2.0 or CPHY 1.1
>     USB-A: USB 3.0, Type A
>     USB-C: Full function USB Type‑C port, supports DP display up to 4Kp60, USB 3.0
>     40-pin 2.54mm header connector: up to 2x SPIs, 6x UARTs, 1x I2Cs, 8x PWMs, 2x I2Ss, 28x GPIOs
>     Debug UART: 3 Pin 2.54mm header, 3V level, 1500000bps
>     Onboard IR receiver: 38KHz carrier frequency
>     RTC Battery: 2 Pin 1.27/1.25mm RTC battery input connector for low power RTC IC HYM8563TS
>     5V Fan connector
>     Working Temperature: 0C to 70C
>     Power: 5.5*2.1mm DC Jack, 12VDC input
>     Dimensions: 110x80x1.6mm (without case) / 86x114.5x30mm (with case)
> 
> Kernel commits:
> 893c17716d0c ("arm64: dts: rockchip: Add NanoPC T6")
> a721e28dfad2 ("arm64: dts: rockchip: Add NanoPC T6 PCIe Ethernet support")
> ac76b786cc37 ("arm64: dts: rockchip: Add NanoPC T6 PCIe e-key support")
> 
> Signed-off-by: John Clark <inindev@gmail.com>
> ---
> 
>  arch/arm/dts/Makefile                     |   1 +
>  arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi |  36 +
>  arch/arm/dts/rk3588-nanopc-t6.dts         | 916 ++++++++++++++++++++++
>  arch/arm/mach-rockchip/rk3588/rk3588.c    |   1 +
>  configs/nanopc-t6-rk3588_defconfig        | 113 +++
>  5 files changed, 1067 insertions(+)
>  create mode 100644 arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
>  create mode 100644 arch/arm/dts/rk3588-nanopc-t6.dts
>  create mode 100644 configs/nanopc-t6-rk3588_defconfig

This is missing addition of the board to the list in board documentation
and an entry in the evb_rk3588 MAINTAINERS file.

[...]

> diff --git a/arch/arm/dts/rk3588-nanopc-t6.dts b/arch/arm/dts/rk3588-nanopc-t6.dts
> new file mode 100644
> index 0000000000..965bf5263d
> --- /dev/null
> +++ b/arch/arm/dts/rk3588-nanopc-t6.dts
> @@ -0,0 +1,916 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
> + * Copyright (c) 2023 Thomas McKahan
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/usb/pd.h>
> +#include "rk3588.dtsi"
> +
> +/ {
> +	model = "FriendlyElec NanoPC-T6";
> +	compatible = "friendlyarm,nanopc-t6", "rockchip,rk3588";
> +
> +	aliases {
> +		mmc0 = &sdhci;
> +		mmc1 = &sdmmc;
> +		serial2 = &uart2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	sound {
> +		compatible = "simple-audio-card";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hp_det>;
> +
> +		simple-audio-card,name = "realtek,rt5616-codec";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,mclk-fs = <256>;
> +
> +		simple-audio-card,hp-det-gpio = <&gpio1 RK_PC4 GPIO_ACTIVE_LOW>;
> +		simple-audio-card,hp-pin-name = "Headphones";
> +
> +		simple-audio-card,widgets =
> +			"Headphone", "Headphones",
> +			"Microphone", "Microphone Jack";
> +		simple-audio-card,routing =
> +			"Headphones", "HPOL",
> +			"Headphones", "HPOR",
> +			"MIC1", "Microphone Jack",
> +			"Microphone Jack", "micbias1";
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&i2s0_8ch>;
> +		};
> +		simple-audio-card,codec {
> +			sound-dai = <&rt5616>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		sys_led: led-0 {
> +			gpios = <&gpio2 RK_PB7 GPIO_ACTIVE_HIGH>;
> +			label = "system-led";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&sys_led_pin>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		usr_led: led-1 {
> +			gpios = <&gpio2 RK_PC0 GPIO_ACTIVE_HIGH>;
> +			label = "user-led";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&usr_led_pin>;
> +		};
> +	};

sound and leds node is out of order compared to mmind/for-next tree.
Rest of the device tree seem to be a 1:1 copy.

https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/tree/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts?h=for-next

[...]

> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
> index b1f535fad5..e08ebfa39b 100644
> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
> @@ -40,6 +40,7 @@ DECLARE_GLOBAL_DATA_PTR;
>  const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>  	[BROM_BOOTSOURCE_EMMC] = "/mmc@fe2e0000",
>  	[BROM_BOOTSOURCE_SPINOR] = "/spi@fe2b0000/flash@0",
> +	[BROM_BOOTSOURCE_SPINAND] = "/spi@fe2b0000/flash@0",

Hum, maybe we need to look at using the atags to determine boot device.
We now have 3 different bootsource values representing same dt node.

>  	[BROM_BOOTSOURCE_SD] = "/mmc@fe2c0000",
>  	[BROM_BOOTSOURCE_SPINOR_RK3588] = "/spi@fe2b0000/flash@0",
>  };
> diff --git a/configs/nanopc-t6-rk3588_defconfig b/configs/nanopc-t6-rk3588_defconfig
> new file mode 100644
> index 0000000000..a1d20b0770
> --- /dev/null
> +++ b/configs/nanopc-t6-rk3588_defconfig
> @@ -0,0 +1,113 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_SYS_HAS_NONCACHED_MEMORY=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_TEXT_BASE=0x00a00000
> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
> +CONFIG_NR_DRAM_BANKS=2
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
> +CONFIG_SF_DEFAULT_SPEED=24000000
> +CONFIG_SF_DEFAULT_MODE=0x2000
> +CONFIG_DEFAULT_DEVICE_TREE="rk3588-nanopc-t6"
> +CONFIG_ROCKCHIP_RK3588=y
> +CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
> +CONFIG_ROCKCHIP_SPI_IMAGE=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SPL_STACK_R_ADDR=0x600000
> +CONFIG_TARGET_EVB_RK3588=y
> +CONFIG_SPL_STACK=0x400000
> +CONFIG_DEBUG_UART_BASE=0xFEB50000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_OF_BOARD_SETUP=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-nanopc-t6.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_PCI_INIT_R=y

This should not be needed and may slow down boot from e.g. eMMC when
there is no PCIe devices attached. Standard boot should init pci after
it has tested faster boot targets.

> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0x4000000
> +CONFIG_SPL_BSS_MAX_SIZE=0x4000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK_R=y
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x100000

We use 0x60000 for other rk35xx boards, odroid-m1 use 0x100000 because
board vendor have existing partitions defined in the device tree.

> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_USB=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_SPL_CLK=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_SF_DEFAULT_BUS=5
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_MACRONIX=y
> +CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_SPI_FLASH_XTX=y
> +CONFIG_PHYLIB=y
> +CONFIG_RTL8169=y
> +CONFIG_NVME_PCI=y
> +CONFIG_PCIE_DW_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_PHY_ROCKCHIP_USBDP=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_REGULATOR_PWM=y

This could be dropped, there is no use of pwm-regulator in the DT.

> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_SPL_RAM=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SFC=y
> +CONFIG_SYSRESET=y
> +CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
> +CONFIG_USB_XHCI_HCD=y
> +# CONFIG_USB_XHCI_DWC3_OF_SIMPLE is not set

You can drop this line, only the pre-mainline usb3 nodes in -u-boot.dtsi
use a rk3399 compatible that would load this driver. I will also send
two series that make this driver obsolete on rockchip platform.

- First series will sync compatible of usb3 nodes with collabora rk3588
  tree, removing the use of the rk3399 compatible.
- Second series will switch rk3399 boards to use dwc3-generic and drop
  the use of dwc3-of-simple driver.

> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_SPL_USB_DWC3_GENERIC=y

This is not really needed, usb nodes are not included in the spl dtb.

Regards,
Jonas

> +CONFIG_USB_HOST_ETHER=y
> +CONFIG_USB_ETHER_ASIX=y
> +CONFIG_USB_ETHER_ASIX88179=y
> +CONFIG_USB_ETHER_MCS7830=y
> +CONFIG_USB_ETHER_RTL8152=y
> +CONFIG_USB_ETHER_SMSC95XX=y
> +CONFIG_ERRNO_STR=y


