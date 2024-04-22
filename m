Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26ECDC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 17:54:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D937884BC;
	Mon, 22 Apr 2024 19:54:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Pyaf0cey";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76495888FB; Mon, 22 Apr 2024 19:54:27 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A607884A4
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 19:54:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8c7e=L4=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1713808449;
 bh=l2JOD4+7FpHGC8OQONo6/njFvYmqoKRutrRaq7knIBs=;
 b=Pyaf0ceyF6SEQ+H0VQJ8f99Z1yW3OOp7zf29bWZN/9tE2AyjktXJOxu+ywbSkVOmH8VwSUeNR
 18j6UbIYXmEL6toFFOWDUqzN+R0En2gbsMGv2Ol7O8XUjacFdtkP1EX2MGo4gL9wLT3zkKfefsd
 cFURnVS5hFPk+E9cn/il9ue4XeKV7VOUgZQCP5p/eljJZzghbrM86enX315vMxplgu7lEcNVK+Z
 ubY2aAtg6IyFycvGEmJDJA8/sgHCLjvTmfwDLtig9wlWCfziWnGuCmkmVzgh/rnzn0Dr/oB2Nhq
 hoxqgrlzy3xzCbBoTam4dO8ccTM0+shvHeHs5Mh+M8UQ==
Message-ID: <550c0a29-c8ce-49ab-a7eb-f1127c37c786@kwiboo.se>
Date: Mon, 22 Apr 2024 19:54:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rockchip: add support for Theobroma Systems
 SOM-RK3588-Q7 Tiger module
To: Quentin Schulz <foss+uboot@0leil.net>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Philipp
 Tomsich <philipp.tomsich@vrull.eu>, Kever Yang
 <kever.yang@rock-chips.com>, Klaus Goger
 <klaus.goger@theobroma-systems.com>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, u-boot@lists.denx.de
References: <20240422-tiger-v1-0-8816b070d748@theobroma-systems.com>
 <20240422-tiger-v1-2-8816b070d748@theobroma-systems.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240422-tiger-v1-2-8816b070d748@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 6626a440eab47a2e036995c1
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

Hi Quentin,

On 2024-04-22 18:41, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> The RK3588-Q7 SoM is a Qseven-compatible (70mm x 70mm, MXM-230
> connector) system-on-module from Theobroma Systems, featuring the
> Rockchip RK3588.
> 
> It provides the following feature set:
>  * up to 16GB LPDDR4x
>  * on-module eMMC
>  * SD card (on a baseboard) via edge connector
>  * Gigabit Ethernet with on-module GbE PHY
>  * HDMI/eDP
>  * MIPI-DSI
>  * 4x MIPI-CSI (3x on FPC connectors, 1x over Q7)
>  * HDMI input over FPC connector
>  * CAN
>  * USB
>    - 1x USB 3.0 dual-role (direct connection)
>    - 2x USB 3.0 host + 1x USB 2.0 host
>  * PCIe
>    - 1x PCIe 2.1 Gen3, 4 lanes
>    - 2xSATA / 2x PCIe 2.1 Gen1, 2 lanes
>  * on-module ATtiny816 companion controller, implementing:
>    - low-power RTC functionality (ISL1208 emulation)
>    - fan controller (AMC6821 emulation)
>   * on-module Secure Element with Global Platform 2.2.1 compliant
>     JavaCard environment
> 
> The support is added for Tiger on Haikou devkit, similarly to RK3399
> Puma and PX30 Ringneck.
> 
> The DTS and DTSI are taken from upstream Linux kernel v6.9-rc4.
> 
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>  arch/arm/dts/Makefile                              |   1 +
>  arch/arm/dts/rk3588-tiger-haikou-u-boot.dtsi       |  54 ++
>  arch/arm/dts/rk3588-tiger-haikou.dts               | 266 ++++++++
>  arch/arm/dts/rk3588-tiger.dtsi                     | 690 +++++++++++++++++++++
>  arch/arm/mach-rockchip/rk3588/Kconfig              |  31 +
>  board/theobroma-systems/tiger_rk3588/Kconfig       |  16 +
>  board/theobroma-systems/tiger_rk3588/MAINTAINERS   |  13 +
>  board/theobroma-systems/tiger_rk3588/Makefile      |  10 +
>  .../theobroma-systems/tiger_rk3588/tiger_rk3588.c  |  53 ++
>  configs/tiger-rk3588_defconfig                     | 114 ++++
>  doc/board/rockchip/rockchip.rst                    |   1 +
>  doc/board/theobroma-systems/index.rst              |   1 +
>  doc/board/theobroma-systems/tiger_rk3588.rst       | 102 +++
>  include/configs/tiger_rk3588.h                     |  15 +
>  14 files changed, 1367 insertions(+)
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index b1c9c6222e5..ef901642a0a 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -180,6 +180,7 @@ dtb-$(CONFIG_ROCKCHIP_RK3588) += \
>  	rk3588-quartzpro64.dtb \
>  	rk3588s-rock-5a.dtb \
>  	rk3588-rock-5b.dtb \
> +	rk3588-tiger-haikou.dtb \
>  	rk3588-turing-rk1.dtb
>  
>  dtb-$(CONFIG_ROCKCHIP_RV1108) += \
> diff --git a/arch/arm/dts/rk3588-tiger-haikou-u-boot.dtsi b/arch/arm/dts/rk3588-tiger-haikou-u-boot.dtsi
> new file mode 100644
> index 00000000000..4259399193a
> --- /dev/null
> +++ b/arch/arm/dts/rk3588-tiger-haikou-u-boot.dtsi
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2024 Theobroma Systems Design und Consulting GmbH
> + */
> +
> +#include "rk3588-u-boot.dtsi"
> +
> +/ {
> +	chosen {
> +		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
> +	};
> +};
> +
> +&emmc_pwrseq {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&emmc_reset {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&gpio2 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&sdhci {
> +	/* U-Boot currently cannot handle anything below HS200 for eMMC on RK3588 */
> +	/delete-property/ mmc-ddr-1_8v;
> +	/delete-property/ cap-mmc-highspeed;
> +};
> +
> +/* Q7 USB P0 */
> +&u2phy1 {
> +	status = "okay";
> +};
> +
> +&u2phy1_otg {
> +	status = "okay";
> +};
> +
> +&usbdp_phy1 {
> +	status = "okay";
> +};
> +
> +&usbdp_phy1_u3 {
> +	status = "okay";
> +};
> +
> +&usb_host1_xhci {
> +	status = "okay";
> +};

Following should be added to possible fix uart2 pinctrl in SPL:

  &uart2m2_xfer {
	bootph-all;
  };

[snip]

> diff --git a/configs/tiger-rk3588_defconfig b/configs/tiger-rk3588_defconfig
> new file mode 100644
> index 00000000000..6545445bba1
> --- /dev/null
> +++ b/configs/tiger-rk3588_defconfig
> @@ -0,0 +1,114 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SPL_GPIO=y
> +CONFIG_SF_DEFAULT_SPEED=24000000
> +CONFIG_SF_DEFAULT_MODE=0x2000
> +CONFIG_ENV_SIZE=0x1f000
> +CONFIG_DEFAULT_DEVICE_TREE="rk3588-tiger-haikou"
> +CONFIG_ROCKCHIP_RK3588=y
> +CONFIG_ROCKCHIP_BOOT_MODE_REG=0x0
> +CONFIG_SPL_SERIAL=y
> +CONFIG_DEBUG_UART_CHANNEL=2
> +CONFIG_TARGET_TIGER_RK3588=y
> +CONFIG_DEBUG_UART_BASE=0xfeb50000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +# CONFIG_BOOTMETH_VBE is not set
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-tiger-haikou.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_CYCLIC=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_ATF=y
> +# CONFIG_BOOTM_NETBSD is not set
> +# CONFIG_BOOTM_PLAN9 is not set
> +# CONFIG_BOOTM_RTEMS is not set
> +# CONFIG_BOOTM_VXWORKS is not set
> +# CONFIG_CMD_ELF is not set
> +CONFIG_CMD_ADC=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +# CONFIG_CMD_LOADB is not set
> +# CONFIG_CMD_LOADS is not set
> +CONFIG_CMD_MMC=y
> +# CONFIG_CMD_SF is not set
> +CONFIG_CMD_USB=y
> +# CONFIG_CMD_SETEXPR is not set
> +# CONFIG_CMD_MII is not set
> +# CONFIG_CMD_BLOCK_CACHE is not set
> +# CONFIG_CMD_EFICONFIG is not set
> +CONFIG_CMD_PMIC=y
> +CONFIG_CMD_REGULATOR=y
> +CONFIG_CMD_EROFS=y
> +CONFIG_CMD_SQUASHFS=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +# CONFIG_OF_TAG_MIGRATE is not set
> +CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_ENV_OVERWRITE=y
> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_BUTTON=y
> +CONFIG_BUTTON_GPIO=y
> +CONFIG_SPL_CLK=y
> +CONFIG_CLK_GPIO=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_IO_VOLTAGE=y
> +CONFIG_SPL_MMC_IO_VOLTAGE=y
> +CONFIG_MMC_UHS_SUPPORT=y
> +CONFIG_SPL_MMC_UHS_SUPPORT=y
> +CONFIG_MMC_HS400_ES_SUPPORT=y
> +CONFIG_SPL_MMC_HS400_ES_SUPPORT=y
> +CONFIG_MMC_HS400_SUPPORT=y
> +CONFIG_SPL_MMC_HS400_SUPPORT=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +# CONFIG_SPI_FLASH is not set
> +CONFIG_SF_DEFAULT_BUS=5
> +CONFIG_PHY_MICREL=y
> +CONFIG_PHY_MICREL_KSZ90X1=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_PHY_ROCKCHIP_USBDP=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_REGULATOR_RK8XX=y
> +CONFIG_SPL_RAM=y
> +CONFIG_SCSI=y
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SPI=y
> +CONFIG_SYSRESET=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_XHCI_DWC3=y

Please use USB_DWC3_GENERIC instead of USB_XHCI_DWC3.

Regards,
Jonas

> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_ERRNO_STR=y

[snip]
