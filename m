Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F709C52D71
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 06:17:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12E2B88717;
	Fri,  2 Aug 2024 08:17:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Cy3yrL00";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3245488B1F; Fri,  2 Aug 2024 08:17:20 +0200 (CEST)
Received: from mail-m49225.qiye.163.com (mail-m49225.qiye.163.com
 [45.254.49.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99BCA88717
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 08:17:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Cy3yrL00lrZSzd6fbO71Z5mIa6IKcWipcSFWAh3+3MqA3+NhRYkKm8/VtXK/LMWmblU1oM7Tb/y3Xl0vR0BQKCkwLHPStUvFEpPS/Rkhq8s/ZGYzgide2mJPbXM5GNHeXARYWALJ9Ge1sRdjr9t8d+tNnO8a1cqwOgSg5QuLMJ0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=5v5UEK/21K7Bpr+0VbTQp3FIu64rww6F3kuMMIwEoo0=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id D211F9004A2;
 Fri,  2 Aug 2024 14:17:06 +0800 (CST)
Message-ID: <3b417019-ca3d-4f05-a863-c0d39a8c3476@rock-chips.com>
Date: Fri, 2 Aug 2024 14:17:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] board: rockchip: Add Radxa ROCK S0
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: u-boot@lists.denx.de
References: <20240730194842.916502-1-jonas@kwiboo.se>
 <20240730194842.916502-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240730194842.916502-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ04YT1ZJSEtDQh4ZQ08YQh9WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9111bc1ff403a9kunmd211f9004a2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ogw6Dww6PTIzKSI3Ag8NM01K
 NA4wCw1VSlVKTElJTkxCT0lMTE9NVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNSUhLNwY+
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


On 2024/7/31 03:48, Jonas Karlman wrote:
> Radxa ROCK S0 is a single-board computer based on the Rockchip RK3308B
> SoC in an ultra-compact form factor. Add a board target for the board.
>
> Features tested on a ROCK S0 v1.2 with 512 MiB RAM and 8 GiB eMMC:
> - SD-card boot
> - eMMC boot
> - Ethernet
> - USB gadget
> - USB host
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3308-rock-s0-u-boot.dtsi | 21 ++++++++
>   board/rockchip/evb_rk3308/MAINTAINERS   |  6 +++
>   configs/rock-s0-rk3308_defconfig        | 72 +++++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst         |  1 +
>   4 files changed, 100 insertions(+)
>   create mode 100644 arch/arm/dts/rk3308-rock-s0-u-boot.dtsi
>   create mode 100644 configs/rock-s0-rk3308_defconfig
>
> diff --git a/arch/arm/dts/rk3308-rock-s0-u-boot.dtsi b/arch/arm/dts/rk3308-rock-s0-u-boot.dtsi
> new file mode 100644
> index 000000000000..84ca2ee0d5fb
> --- /dev/null
> +++ b/arch/arm/dts/rk3308-rock-s0-u-boot.dtsi
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include "rk3308-u-boot.dtsi"
> +
> +&emmc_pwren {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&uart0 {
> +	bootph-all;
> +	clock-frequency = <24000000>;
> +};
> +
> +&uart0_xfer {
> +	bootph-all;
> +};
> +
> +&vdd_core {
> +	regulator-init-microvolt = <1015000>;
> +};
> diff --git a/board/rockchip/evb_rk3308/MAINTAINERS b/board/rockchip/evb_rk3308/MAINTAINERS
> index abffbb1eb0ab..cd219c65f278 100644
> --- a/board/rockchip/evb_rk3308/MAINTAINERS
> +++ b/board/rockchip/evb_rk3308/MAINTAINERS
> @@ -12,3 +12,9 @@ R:      Jonas Karlman <jonas@kwiboo.se>
>   S:      Maintained
>   F:      configs/rock-pi-s-rk3308_defconfig
>   F:      arch/arm/dts/rk3308-rock-pi-s*
> +
> +ROCK-S0
> +M:      Jonas Karlman <jonas@kwiboo.se>
> +S:      Maintained
> +F:      configs/rock-s0-rk3308_defconfig
> +F:      arch/arm/dts/rk3308-rock-s0*
> diff --git a/configs/rock-s0-rk3308_defconfig b/configs/rock-s0-rk3308_defconfig
> new file mode 100644
> index 000000000000..074ec4cd66ba
> --- /dev/null
> +++ b/configs/rock-s0-rk3308_defconfig
> @@ -0,0 +1,72 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3308-rock-s0"
> +CONFIG_DM_RESET=y
> +CONFIG_ROCKCHIP_RK3308=y
> +CONFIG_TARGET_EVB_RK3308=y
> +CONFIG_DEBUG_UART_BASE=0xFF0A0000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +# CONFIG_DEBUG_UART_BOARD_INIT is not set
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART=y
> +CONFIG_ANDROID_BOOT_IMAGE=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3308-rock-s0.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_ROCKUSB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +CONFIG_CMD_RNG=y
> +CONFIG_CMD_KASLRSEED=y
> +CONFIG_CMD_REGULATOR=y
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_REGMAP=y
> +CONFIG_SYSCON=y
> +CONFIG_CLK=y
> +# CONFIG_USB_FUNCTION_FASTBOOT is not set
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_ROCKCHIP_IODOMAIN=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_MDIO=y
> +CONFIG_DM_ETH_PHY=y
> +CONFIG_ETH_DESIGNWARE=y
> +CONFIG_GMAC_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PINCTRL=y
> +CONFIG_REGULATOR_PWM=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_RAM=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_SYSINFO=y
> +CONFIG_SYSRESET=y
> +CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_DWC2_OTG=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_USB_FUNCTION_ROCKUSB=y
> +CONFIG_LZO=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index bedc52e03e20..82cbc6e3e0db 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -54,6 +54,7 @@ List of mainline supported Rockchip boards:
>        - Amarula Vyasa-RK3288 (vyasa-rk3288)
>   * rk3308
>        - Radxa ROCK Pi S (rock-pi-s-rk3308)
> +     - Radxa ROCK S0 (rock-s0-rk3308)
>        - Rockchip Evb-RK3308 (evb-rk3308)
>        - Roc-cc-RK3308 (roc-cc-rk3308)
>   * rk3326
