Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51C6C4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 08:31:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB12E87ABE;
	Thu, 18 Jan 2024 09:31:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="CR9ENoqU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15CD087B72; Thu, 18 Jan 2024 09:31:16 +0100 (CET)
Received: from mail-m127206.xmail.ntesmail.com
 (mail-m127206.xmail.ntesmail.com [115.236.127.206])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A30487835
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 09:31:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=CR9ENoqUbbtRmber3KJ2PN/eFfXbYaN/TaYYR51BeVs5v40uGW8rkl8T8OKKrdMHInsqDjc9hF5wK6O6HC2FsZUPdQ1f3130PW53O10MvjXKk/4N2IieW2eKbD3dZPm2InV0Jy9Va7+7lMWeLpZwIQhjuK29ivJ2UUOlKwORyeY=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=Eauo41x7cqeBZKtL/j4yBqZJB0AGoQ8ufNU94d8TVUY=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11873.qiye.163.com (Hmail) with ESMTPA id 4A575900690;
 Thu, 18 Jan 2024 16:31:03 +0800 (CST)
Message-ID: <76b8571e-34e5-4b15-b437-869c141b048b@rock-chips.com>
Date: Thu, 18 Jan 2024 16:31:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] rockchip: board: Remove dwc3 usb init and gadget
 handler functions
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Bharat Gooty <bharat.gooty@broadcom.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 John Clark <inindev@gmail.com>, Eugen Hristev <eugen.hristev@collabora.com>
Cc: u-boot@lists.denx.de
References: <20231112174904.1581187-1-jonas@kwiboo.se>
 <20231112174904.1581187-3-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231112174904.1581187-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQktOSFZOHUIaQhlMSUtKSEpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d1bb1f3882eafkusn4a575900690
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ok06Ahw4ITwtGBA#Hx1JGjZR
 PTZPFDhVSlVKTEtOTk1NTU1PS0JOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNQ0NONwY+
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


On 2023/11/13 01:48, Jonas Karlman wrote:
> Remove board_usb_init() and dm_usb_gadget_handle_interrupts() functions
> related to dwc3, they use e.g. a hard-coded reg address for RK3399 and
> are obsolete with use of DM_USB_GADGET.
>
> Use of DM_USB_GADGET, USB_DWC3_GENERIC and USB_DWC3_GADGET have replaced
> same feature provided by the removed functions on RK3399 boards.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2:
> - Set DM_USB_GADGET for ARCH_ROCKCHIP when USB_DWC3_GADGET is enabled
>    to ensure same functionality is provided
> - Remove DM_USB_GADGET from a few more defconfig files
>
>   arch/arm/Kconfig                         |  1 +
>   arch/arm/mach-rockchip/board.c           | 30 +-----------------------
>   configs/nanopc-t6-rk3588_defconfig       |  1 -
>   configs/orangepi-5-plus-rk3588_defconfig |  1 -
>   configs/orangepi-5-rk3588s_defconfig     |  1 -
>   configs/rock5a-rk3588s_defconfig         |  1 -
>   configs/rock5b-rk3588_defconfig          |  1 -
>   7 files changed, 2 insertions(+), 34 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index d812685c9842..c39ae40335a0 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1974,6 +1974,7 @@ config ARCH_ROCKCHIP
>   	select DM_SERIAL
>   	select DM_SPI
>   	select DM_SPI_FLASH
> +	select DM_USB_GADGET if USB_DWC3_GADGET
>   	select ENABLE_ARM_SOC_BOOT0_HOOK
>   	select OF_CONTROL
>   	select SPI
> diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
> index 57f08e0be0e9..38a2a4b95ec0 100644
> --- a/arch/arm/mach-rockchip/board.c
> +++ b/arch/arm/mach-rockchip/board.c
> @@ -208,10 +208,8 @@ void enable_caches(void)
>   }
>   #endif
>   
> -#if defined(CONFIG_USB_GADGET)
> +#if defined(CONFIG_USB_GADGET) && defined(CONFIG_USB_GADGET_DWC2_OTG)
>   #include <usb.h>
> -
> -#if defined(CONFIG_USB_GADGET_DWC2_OTG)
>   #include <linux/usb/otg.h>
>   #include <usb/dwc2_udc.h>
>   
> @@ -287,32 +285,6 @@ int board_usb_cleanup(int index, enum usb_init_type init)
>   }
>   #endif /* CONFIG_USB_GADGET_DWC2_OTG */
>   
> -#if defined(CONFIG_USB_DWC3_GADGET) && !defined(CONFIG_DM_USB_GADGET)
> -#include <dwc3-uboot.h>
> -
> -static struct dwc3_device dwc3_device_data = {
> -	.maximum_speed = USB_SPEED_HIGH,
> -	.base = 0xfe800000,
> -	.dr_mode = USB_DR_MODE_PERIPHERAL,
> -	.index = 0,
> -	.dis_u2_susphy_quirk = 1,
> -	.hsphy_mode = USBPHY_INTERFACE_MODE_UTMIW,
> -};
> -
> -int dm_usb_gadget_handle_interrupts(struct udevice *dev)
> -{
> -	dwc3_uboot_handle_interrupt(dev);
> -	return 0;
> -}
> -
> -int board_usb_init(int index, enum usb_init_type init)
> -{
> -	return dwc3_uboot_init(&dwc3_device_data);
> -}
> -#endif /* CONFIG_USB_DWC3_GADGET */
> -
> -#endif /* CONFIG_USB_GADGET */
> -
>   #if IS_ENABLED(CONFIG_FASTBOOT)
>   int fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
>   {
> diff --git a/configs/nanopc-t6-rk3588_defconfig b/configs/nanopc-t6-rk3588_defconfig
> index 070399ce2a86..62f307a3f361 100644
> --- a/configs/nanopc-t6-rk3588_defconfig
> +++ b/configs/nanopc-t6-rk3588_defconfig
> @@ -91,7 +91,6 @@ CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_ROCKCHIP_SFC=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
> -CONFIG_DM_USB_GADGET=y
>   CONFIG_USB_XHCI_HCD=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
> diff --git a/configs/orangepi-5-plus-rk3588_defconfig b/configs/orangepi-5-plus-rk3588_defconfig
> index 04736996217e..9ebb8c2244c5 100644
> --- a/configs/orangepi-5-plus-rk3588_defconfig
> +++ b/configs/orangepi-5-plus-rk3588_defconfig
> @@ -94,7 +94,6 @@ CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_ROCKCHIP_SFC=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
> -CONFIG_DM_USB_GADGET=y
>   CONFIG_USB_XHCI_HCD=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
> diff --git a/configs/orangepi-5-rk3588s_defconfig b/configs/orangepi-5-rk3588s_defconfig
> index feb45a53853b..4b5803dce9be 100644
> --- a/configs/orangepi-5-rk3588s_defconfig
> +++ b/configs/orangepi-5-rk3588s_defconfig
> @@ -91,7 +91,6 @@ CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_ROCKCHIP_SFC=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
> -CONFIG_DM_USB_GADGET=y
>   CONFIG_USB_XHCI_HCD=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
> diff --git a/configs/rock5a-rk3588s_defconfig b/configs/rock5a-rk3588s_defconfig
> index a6471a519514..efa7bcbdcda6 100644
> --- a/configs/rock5a-rk3588s_defconfig
> +++ b/configs/rock5a-rk3588s_defconfig
> @@ -75,7 +75,6 @@ CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
> -CONFIG_DM_USB_GADGET=y
>   CONFIG_USB_XHCI_HCD=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
> diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
> index 0595325e8107..6135af04feef 100644
> --- a/configs/rock5b-rk3588_defconfig
> +++ b/configs/rock5b-rk3588_defconfig
> @@ -99,7 +99,6 @@ CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_ROCKCHIP_SFC=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
> -CONFIG_DM_USB_GADGET=y
>   CONFIG_USB_XHCI_HCD=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
