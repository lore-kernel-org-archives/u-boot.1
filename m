Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95265C07E8F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 975698838E;
	Mon, 22 Apr 2024 10:53:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="fFLMYiR1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7D65883A5; Mon, 22 Apr 2024 10:53:09 +0200 (CEST)
Received: from mail-m32105.qiye.163.com (mail-m32105.qiye.163.com
 [220.197.32.105])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47B4C88374
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:53:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=fFLMYiR15+wgOL5LZX1kwizlrPQz9w0KGz0NAqAvGNyElVYo2e4PFxKj1vBnoJ3YlDBPwFtEepQKONBH5OnQWOn1WaaIpubwmX93Df3QpHmLrWuu2hd5vZB5URTXMfpyEpnNnJVghPn0f67gIlbZbCvcs32j0psD2dhYytsnFSY=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=BsfyJJjx6GvwSthtO/UfoTFvrOrGdxNEq7VsI+YyhP8=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id E20D29002DD;
 Mon, 22 Apr 2024 16:52:52 +0800 (CST)
Message-ID: <ca16e0d7-81a7-49c6-b879-f309d85994e2@rock-chips.com>
Date: Mon, 22 Apr 2024 16:52:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/14] rockchip: rk3308-rock-pi-s: Update defconfig
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Akash Gajjar <gajjar04akash@gmail.com>
Cc: Andy Yan <andy.yan@rock-chips.com>, u-boot@lists.denx.de
References: <20240408181429.3676856-1-jonas@kwiboo.se>
 <20240408181429.3676856-14-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240408181429.3676856-14-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQklOHVZOQh5IGUpJSB5DHh9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f050213de03a9kunme20d29002dd
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Oi46UTo*TzMBIjkUDD5DF0kf
 MQ8KCS5VSlVKTEpITExOQkxIQ0hJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOTENNNwY+
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


On 2024/4/9 02:14, Jonas Karlman wrote:
> Update defconfig for rk3308-rock-pi-s with new defaults.
>
> Add OF_LIBFDT_OVERLAY=y to support device tree overlays.
>
> Remove the SPL_DRIVERS_MISC=y option, no misc driver is used in SPL.
>
> Remove BOOTDELAY=0, SYS_CONSOLE_INFO_QUIET=y and enable more CMD to
> allow use of U-Boot cmdline.
>
> Add DM_ETH_PHY=y and PHY_REALTEK=y to support onboard ethernet PHY.
>
> Add PHY_ROCKCHIP_INNO_USB2=y, DM_USB_GADGET=y and remove USB_DWC2=y to
> allow full use of USB 2.0 host and otg ports.
>
> Enable EFI_LOADER to allow EFI boot.
>
> Also fix use of USB 2.0 otg port by removing improper use of phy-supply
> and regulator-always-on props.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: Keep DEBUG_UART_BOARD_INIT disabled
> ---
>   arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi |  8 ++++++
>   configs/rock-pi-s-rk3308_defconfig        | 32 +++++++++--------------
>   2 files changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi b/arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi
> index 8d34ed1b3a36..a6fb8b12da38 100644
> --- a/arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi
> @@ -15,6 +15,10 @@
>   	bootph-some-ram;
>   };
>   
> +&u2phy_otg {
> +	/delete-property/ phy-supply;
> +};
> +
>   &uart0 {
>   	bootph-all;
>   	clock-frequency = <24000000>;
> @@ -32,6 +36,10 @@
>   	bootph-all;
>   };
>   
> +&vcc5v0_otg {
> +	/delete-property/ regulator-always-on;
> +};
> +
>   &vdd_core {
>   	regulator-init-microvolt = <1015000>;
>   };
> diff --git a/configs/rock-pi-s-rk3308_defconfig b/configs/rock-pi-s-rk3308_defconfig
> index 27ee24a62290..37a124eae181 100644
> --- a/configs/rock-pi-s-rk3308_defconfig
> +++ b/configs/rock-pi-s-rk3308_defconfig
> @@ -6,7 +6,6 @@ CONFIG_DEFAULT_DEVICE_TREE="rk3308-rock-pi-s"
>   CONFIG_OF_LIBFDT_OVERLAY=y
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3308=y
> -CONFIG_SPL_DRIVERS_MISC=y
>   CONFIG_TARGET_EVB_RK3308=y
>   CONFIG_DEBUG_UART_BASE=0xFF0A0000
>   CONFIG_DEBUG_UART_CLOCK=24000000
> @@ -17,28 +16,19 @@ CONFIG_ANDROID_BOOT_IMAGE=y
>   CONFIG_FIT=y
>   CONFIG_FIT_VERBOSE=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3308-rock-pi-s.dtb"
> -CONFIG_SYS_CONSOLE_INFO_QUIET=y
>   # CONFIG_DISPLAY_CPUINFO is not set
> -CONFIG_SPL_MAX_SIZE=0x20000
> +CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> -# CONFIG_CMD_BDI is not set
> -# CONFIG_CMD_CONSOLE is not set
> -# CONFIG_CMD_ELF is not set
> -# CONFIG_CMD_IMI is not set
> -# CONFIG_CMD_XIMG is not set
> +CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
> -# CONFIG_CMD_LOADB is not set
> -# CONFIG_CMD_LOADS is not set
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_USB=y
> +CONFIG_CMD_ROCKUSB=y
>   CONFIG_CMD_USB_MASS_STORAGE=y
> -# CONFIG_CMD_ITEST is not set
> -# CONFIG_CMD_SETEXPR is not set
> -# CONFIG_CMD_SLEEP is not set
> -# CONFIG_SPL_DOS_PARTITION is not set
> -# CONFIG_ISO_PARTITION is not set
> -CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
> +CONFIG_CMD_RNG=y
> +CONFIG_CMD_KASLRSEED=y
> +CONFIG_CMD_REGULATOR=y
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_LIVE=y
>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> @@ -52,9 +42,11 @@ CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_SUPPORT_EMMC_RPMB=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_ETH_PHY=y
>   CONFIG_ETH_DESIGNWARE=y
>   CONFIG_GMAC_ROCKCHIP=y
> -CONFIG_PHY=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>   CONFIG_PINCTRL=y
>   CONFIG_REGULATOR_PWM=y
>   CONFIG_DM_REGULATOR_FIXED=y
> @@ -63,15 +55,15 @@ CONFIG_RAM=y
>   CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_SYSINFO=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
> -CONFIG_USB_DWC2=y
>   CONFIG_USB_GADGET=y
>   CONFIG_USB_GADGET_DWC2_OTG=y
>   CONFIG_USB_GADGET_DOWNLOAD=y
> -CONFIG_SPL_TINY_MEMSET=y
> +CONFIG_USB_FUNCTION_ROCKUSB=y
>   CONFIG_LZO=y
>   CONFIG_ERRNO_STR=y
> -# CONFIG_EFI_LOADER is not set
