Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB36C36002
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 15:13:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C455C82B54;
	Sun,  6 Apr 2025 17:13:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="MWqsN9+7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32B4982B8E; Sun,  6 Apr 2025 17:13:04 +0200 (CEST)
Received: from mail-m3293.qiye.163.com (mail-m3293.qiye.163.com
 [220.197.32.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4265282B46
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 17:12:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.73.2])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10d0205de;
 Sun, 6 Apr 2025 23:12:52 +0800 (GMT+08:00)
Message-ID: <3d0fd8d8-2c88-4f9f-89e4-2af52d5f9acc@rock-chips.com>
Date: Sun, 6 Apr 2025 23:12:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] board: rockchip: Add minimal generic RK3399 board
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250330172040.3370919-1-jonas@kwiboo.se>
 <20250330172040.3370919-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250330172040.3370919-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaHh1MVklKTxhDSRlMGhgdGFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTEhVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
 JLS1kG
X-HM-Tid: 0a960ba964cf03afkunm10d0205de
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6N006ERw*OjJMF0kOME9KMysL
 IhowFDBVSlVKTE9IQk5JSExITUtIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKSUtVSE1VTEhVSVlXWQgBWUFMTEtKNwY+
DKIM-Signature: a=rsa-sha256;
 b=MWqsN9+7D65H8g5B2LfWXRr8RH4hHa84wJb9XWIQ79NKZOTSxEtonaMGzrF7Qtche6j247WF46O9fVsRegiTTLLpFJElBHzvnECriu1NOWNaaiX4OwqvD3HXWwr5YcFMKpY1H9OC5Qv0ehnt7A0xNCSDaEYQ/PGKWbY0CC5B4Rc=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=KA56HuNc38GTu/li24YBpZivf3N5B+wymnVqKioio24=;
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


On 2025/3/31 01:20, Jonas Karlman wrote:
> Add a minimal generic RK3399 board that only have eMMC, SDMMC, SPI flash
> and USB OTG enabled. This defconfig can be used to boot from eMMC,
> SD-card or SPI flash on most RK3399 boards that follow reference board
> design.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: Add CONFIG_ROCKCHIP_IODOMAIN is not set
> ---
>   arch/arm/dts/rk3399-generic-u-boot.dtsi | 10 +++
>   arch/arm/dts/rk3399-generic.dts         | 83 +++++++++++++++++++++++++
>   board/rockchip/evb_rk3399/MAINTAINERS   |  6 ++
>   configs/generic-rk3399_defconfig        | 77 +++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst         |  1 +
>   5 files changed, 177 insertions(+)
>   create mode 100644 arch/arm/dts/rk3399-generic-u-boot.dtsi
>   create mode 100644 arch/arm/dts/rk3399-generic.dts
>   create mode 100644 configs/generic-rk3399_defconfig
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
> +	flash@0 {
> +		bootph-pre-ram;
> +		bootph-some-ram;
> +	};
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
> +	model = "Generic RK3399";
> +	compatible = "rockchip,rk3399";
> +
> +	aliases {
> +		mmc0 = &sdhci;
> +		mmc1 = &sdmmc;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +};
> +
> +&emmc_phy {
> +	status = "okay";
> +};
> +
> +&sdhci {
> +	bus-width = <8>;
> +	cap-mmc-highspeed;
> +	max-frequency = <150000000>;
> +	mmc-hs200-1_8v;
> +	mmc-ddr-1_8v;
> +	no-sd;
> +	no-sdio;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&sdmmc {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	disable-wp;
> +	max-frequency = <150000000>;
> +	no-mmc;
> +	no-sdio;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdmmc_bus4 &sdmmc_clk &sdmmc_cmd &sdmmc_cd>;
> +	status = "okay";
> +};
> +
> +&spi1 {
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <25000000>;
> +	};
> +};
> +
> +&u2phy0 {
> +	status = "okay";
> +};
> +
> +&u2phy0_otg {
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	status = "okay";
> +};
> +
> +&usbdrd3_0 {
> +	status = "okay";
> +};
> +
> +&usbdrd_dwc3_0 {
> +	dr_mode = "peripheral";
> +	maximum-speed = "high-speed";
> +	phys = <&u2phy0_otg>;
> +	phy-names = "usb2-phy";
> +	status = "okay";
> +};
> diff --git a/board/rockchip/evb_rk3399/MAINTAINERS b/board/rockchip/evb_rk3399/MAINTAINERS
> index 8dab3fa70f56..8319db2e976c 100644
> --- a/board/rockchip/evb_rk3399/MAINTAINERS
> +++ b/board/rockchip/evb_rk3399/MAINTAINERS
> @@ -14,6 +14,12 @@ S:      Maintained
>   F:	configs/eaidk-610-rk3399_defconfig
>   F:	arch/arm/dts/rk3399-eaidk-610*
>   
> +GENERIC-RK3399
> +M:	Jonas Karlman <jonas@kwiboo.se>
> +S:	Maintained
> +F:	configs/generic-rk3399_defconfig
> +F:	arch/arm/dts/rk3399-generic*
> +
>   KHADAS-EDGE
>   M:	Nick Xie <nick@khadas.com>
>   S:	Maintained
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
>        - FriendlyElec NanoPi M4 (nanopi-m4-rk3399)
>        - FriendlyElec NanoPi M4B (nanopi-m4b-rk3399)
>        - FriendlyARM NanoPi NEO4 (nanopi-neo4-rk3399)
> +     - Generic RK3399 (generic-rk3399)
>        - Google Bob (chromebook_bob)
>        - Google Kevin (chromebook_kevin)
>        - Khadas Edge (khadas-edge-rk3399)
