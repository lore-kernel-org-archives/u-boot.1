Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0D9E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 03:28:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A25598031D;
	Fri,  3 Jan 2025 04:28:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="CR3w/NNN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7408580374; Fri,  3 Jan 2025 04:28:54 +0100 (CET)
Received: from mail-m49212.qiye.163.com (mail-m49212.qiye.163.com
 [45.254.49.212])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8153B800D7
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 04:28:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 791f362c;
 Fri, 3 Jan 2025 11:28:45 +0800 (GMT+08:00)
Message-ID: <885024ba-cbb7-43d9-ac0c-8cb6ea9c33b9@rock-chips.com>
Date: Fri, 3 Jan 2025 11:28:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm: dts: rockchip: add rk3318 A95X Z2 board
To: Johan Jonker <jbx6244@gmail.com>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, u-boot@lists.denx.de
References: <d0bcf1f6-3698-4e5f-8f2c-fcb99bde7602@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <d0bcf1f6-3698-4e5f-8f2c-fcb99bde7602@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU1OSFYdSUJNTkwYTEpJTE5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a942a3552fc03afkunm791f362c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MzY6Fgw4AzIXPS08EUkfPxwo
 LSJPFApVSlVKTEhOQ0xPQklMTk9DVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNSk1INwY+
DKIM-Signature: a=rsa-sha256;
 b=CR3w/NNNP4f98/HNSIHytO4vJkWAfWXDVEx4EX3UQEHThLvWjOMdJGtaLXUrB3OwOCuFdGIsy7/5aHNe7cOt+Zta3RZv78VEo6e8E/OJlmZmb6AedmLAEiWi7/EIjAvnWjecBnskpXUCSajHZSMMl89rAiRs4HcY7pGIowMirTY=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=SXF5xC5YcyPsvC2SeQCtTz2o1ckQtEZ4ziDU0f8OkA4=;
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


On 2024/12/8 23:36, Johan Jonker wrote:
> The rk3318 A95X Z2 boards are sold as TV box.
> No further documentation is given, but from the dts files
> extracted it seems that the rk3318 processor is simulair
> to the rk3328. Included is an extra dtsi file for U-Boot
> specific properties. The DT is already located in
> the /dts/upstream directory.
>
> Features:
>
> CPU: RK3318 Quad-Core Cortex-A53
> GPU: Mali-450
> RAM: 2/4GB DDR3
> ROM: EMMC 16/32/64GB
> HDMI: HDMI 2.0a for 4k@60Hz
> Ethernet: 10/100M standard RJ-45
> WiFi: 2.4G+5G WIFI, 802.11 b/g/n
> Bluetooth: 4.0
> 1 x USB 3.0
> 1 x USB 2.0
> 1 x Micro SD card slot
> 1 x SPDIF
> 1 x AV
> 1 x DC IN
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3318-a95x-z2-u-boot.dtsi |  9 +++
>   board/rockchip/evb_rk3328/MAINTAINERS   |  6 ++
>   configs/a95x-z2-rk3318_defconfig        | 94 +++++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst         |  4 +-
>   4 files changed, 112 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm/dts/rk3318-a95x-z2-u-boot.dtsi
>   create mode 100644 configs/a95x-z2-rk3318_defconfig
>
> diff --git a/arch/arm/dts/rk3318-a95x-z2-u-boot.dtsi b/arch/arm/dts/rk3318-a95x-z2-u-boot.dtsi
> new file mode 100644
> index 000000000000..e21fd6e07df7
> --- /dev/null
> +++ b/arch/arm/dts/rk3318-a95x-z2-u-boot.dtsi
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include "rk3328-u-boot.dtsi"
> +#include "rk3328-sdram-ddr3-666.dtsi"
> +
> +&usb20_otg {
> +	dr_mode = "otg";
> +};
> +
> diff --git a/board/rockchip/evb_rk3328/MAINTAINERS b/board/rockchip/evb_rk3328/MAINTAINERS
> index 5f81be55b8e0..fe642a56a690 100644
> --- a/board/rockchip/evb_rk3328/MAINTAINERS
> +++ b/board/rockchip/evb_rk3328/MAINTAINERS
> @@ -1,3 +1,9 @@
> +A95X-Z2-RK3318
> +M:      Johan Jonker <jbx6244@gmail.com>
> +S:      Maintained
> +F:      configs/a95x-z2-rk3318_defconfig
> +F:      arch/arm/dts/rk3318-a95x-z2-u-boot.dtsi
> +
>   EVB-RK3328
>   M:      Kever Yang <kever.yang@rock-chips.com>
>   S:      Maintained
> diff --git a/configs/a95x-z2-rk3318_defconfig b/configs/a95x-z2-rk3318_defconfig
> new file mode 100644
> index 000000000000..9cb6a67ad5ae
> --- /dev/null
> +++ b/configs/a95x-z2-rk3318_defconfig
> @@ -0,0 +1,94 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_SF_DEFAULT_SPEED=20000000
> +CONFIG_ENV_OFFSET=0x3F8000
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3318-a95x-z2"
> +CONFIG_DM_RESET=y
> +CONFIG_ROCKCHIP_RK3328=y
> +CONFIG_SYS_LOAD_ADDR=0x800800
> +CONFIG_DEBUG_UART_BASE=0xFF130000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_DEBUG_UART=y
> +# CONFIG_ANDROID_BOOT_IMAGE is not set
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3318-a95x-z2.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_ATF=y
> +CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> +CONFIG_CMD_BOOTZ=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_ROCKUSB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +# CONFIG_CMD_SETEXPR is not set
> +# CONFIG_CMD_NET is not set
> +CONFIG_CMD_TIME=y
> +CONFIG_CMD_REGULATOR=y
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_TPL_OF_CONTROL=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_TPL_OF_PLATDATA=y
> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SYS_MMC_ENV_DEV=1
> +CONFIG_TPL_DM=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_REGMAP=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_TPL_REGMAP=y
> +CONFIG_SYSCON=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_TPL_SYSCON=y
> +CONFIG_CLK=y
> +CONFIG_SPL_CLK=y
> +CONFIG_FASTBOOT_BUF_ADDR=0x800800
> +CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +# CONFIG_NETDEVICES is not set
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PINCTRL=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_SPL_DM_REGULATOR_FIXED=y
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_RAM=y
> +CONFIG_SPL_RAM=y
> +CONFIG_TPL_RAM=y
> +CONFIG_DM_RNG=y
> +CONFIG_RNG_ROCKCHIP=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_SYSINFO=y
> +CONFIG_SYSRESET=y
> +# CONFIG_TPL_SYSRESET is not set
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_DWC2_OTG=y
> +CONFIG_USB_FUNCTION_ROCKUSB=y
> +CONFIG_SPL_TINY_MEMSET=y
> +CONFIG_TPL_TINY_MEMSET=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 9bab86d23479..ec325c4fe558 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -57,6 +57,8 @@ List of mainline supported Rockchip boards:
>        - Radxa ROCK S0 (rock-s0-rk3308)
>        - Rockchip Evb-RK3308 (evb-rk3308)
>        - Roc-cc-RK3308 (roc-cc-rk3308)
> +* rk3318
> +     - A95X Z2 (a95x-z2-rk3318)
>   * rk3326
>        - ODROID-GO Advance (odroid-go2)
>   * rk3328
> @@ -190,7 +192,7 @@ TPL
>
>   For some SoCs U-Boot sources lack of support to inizialize DRAM.
>   In these cases, to get a fully functional image following :ref:`PackageWithTPLandSPL`, use DDR binary provided by Rockchip rkbin repository as ROCKCHIP_TPL when building U-Boot.
> -Otherwise, follow :ref:`PackageWithRockchipMiniloader`.
> +Otherwise, follow :ref:`PackageWithRockchipMiniloader`.
>
>   U-Boot
>   ^^^^^^
> --
> 2.39.5
>
>
