Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AFFC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:50:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF9AB8838B;
	Mon, 22 Apr 2024 10:50:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="jQPqYRfC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B84F88374; Mon, 22 Apr 2024 10:50:23 +0200 (CEST)
Received: from mail-m127158.xmail.ntesmail.com
 (mail-m127158.xmail.ntesmail.com [115.236.127.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EA788838E
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:50:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=jQPqYRfCZAJrXKI5EtGV1ry/ILVuKK/TRwmMpH6dFiYSSwgM9m0SHG0BJhKUEzbJxxABzSUG8nU7Frjak6JP2CUYcttj84bE/QYptKPU8kSCysyNDRR4FhxeD+b0oEuvuoqpzo+plxXwSUhEFdavgaihHHdPza8YPw5opPelG9k=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=GXfDFeK76CCZ8xoKeQp0ZTpG8QX3cvDA77ONoGSZEUc=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 437FB90031D;
 Mon, 22 Apr 2024 16:50:08 +0800 (CST)
Message-ID: <e81a920d-e8db-4e98-a221-ea13e00c8937@rock-chips.com>
Date: Mon, 22 Apr 2024 16:50:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/14] rockchip: rk3308-evb: Update defconfig
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: Akash Gajjar <gajjar04akash@gmail.com>, u-boot@lists.denx.de
References: <20240408181429.3676856-1-jonas@kwiboo.se>
 <20240408181429.3676856-12-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240408181429.3676856-12-jonas@kwiboo.se>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx8fTVYeQk1PS0gYGEJLSEpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04ff907103a9kunm437fb90031d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PD46CBw4GDMCCDouK0sWCTkU
 GDIaFEpVSlVKTEpITExOQ0tCSElOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKS0pKQjcG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On 2024/4/9 02:14, Jonas Karlman wrote:
> Update defconfig for rk3308-evb with new defaults.
>
> Add OF_LIBFDT_OVERLAY=y to support device tree overlays.
>
> Remove the SPL_DRIVERS_MISC=y option, no misc driver is used in SPL.
>
> Use DEBUG_UART_BASE=0xFF0E0000 and disable DEBUG_UART_BOARD_INIT to
> make debug uart use uart4, same as stdout-path prop.

Why this change happen? I think rk3308-evb is using UART2 on 0xFF0C0000.


Thanks,

- Kever

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
> Signed-off-by: Jonas Karlman<jonas@kwiboo.se>
> ---
> v2: Fix DEBUG_UART_BASE and disable DEBUG_UART_BOARD_INIT
> ---
>   configs/evb-rk3308_defconfig | 37 +++++++++++++++---------------------
>   1 file changed, 15 insertions(+), 22 deletions(-)
>
> diff --git a/configs/evb-rk3308_defconfig b/configs/evb-rk3308_defconfig
> index 9dc7d9c0caea..04a94e13a68a 100644
> --- a/configs/evb-rk3308_defconfig
> +++ b/configs/evb-rk3308_defconfig
> @@ -3,41 +3,32 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_DEFAULT_DEVICE_TREE="rk3308-evb"
> +CONFIG_OF_LIBFDT_OVERLAY=y
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3308=y
> -CONFIG_SPL_DRIVERS_MISC=y
>   CONFIG_TARGET_EVB_RK3308=y
> -CONFIG_DEBUG_UART_BASE=0xFF0C0000
> +CONFIG_DEBUG_UART_BASE=0xFF0E0000
>   CONFIG_DEBUG_UART_CLOCK=24000000
> +# CONFIG_DEBUG_UART_BOARD_INIT is not set
>   CONFIG_SYS_LOAD_ADDR=0xc00800
>   CONFIG_DEBUG_UART=y
>   CONFIG_ANDROID_BOOT_IMAGE=y
>   CONFIG_FIT=y
>   CONFIG_FIT_VERBOSE=y
> -CONFIG_BOOTDELAY=0
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3308-evb.dtb"
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
> @@ -51,9 +42,11 @@ CONFIG_SYS_I2C_ROCKCHIP=y
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
> @@ -62,15 +55,15 @@ CONFIG_RAM=y
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
