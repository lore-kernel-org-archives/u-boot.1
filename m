Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02611C36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 00:57:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83EE0830EE;
	Tue,  8 Apr 2025 02:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="U92m43q/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6920E83106; Tue,  8 Apr 2025 02:57:54 +0200 (CEST)
Received: from mail-m32110.qiye.163.com (mail-m32110.qiye.163.com
 [220.197.32.110])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E35183095
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 02:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10fbf2a27;
 Tue, 8 Apr 2025 08:57:46 +0800 (GMT+08:00)
Message-ID: <2712a48d-6aa4-4aca-8b14-62583e955d54@rock-chips.com>
Date: Tue, 8 Apr 2025 08:57:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] rockchip: Add DFU to SPL for RK3588
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250211053340.92919-1-naoki@radxa.com>
 <20250211053340.92919-4-naoki@radxa.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250211053340.92919-4-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHR4dVkwfHU8eSR1OHktPQlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a9612e73f6f03afkunm10fbf2a27
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nhw6Dxw6FjJMA0M5Vj0WSzoq
 KzNPCgFVSlVKTE9PS0xIQ01MQklLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQU9MTkI3Bg++
DKIM-Signature: a=rsa-sha256;
 b=U92m43q/1p1KzxXFEaxjNNGSOrHEHpTuIkPZD1E0vasKJJW+8mFv+odNvomCPM22w0XLWDJpz+eIy23ay1sYLhfps8Gp0RbKufuiMW1oJZ0XQyZDW39NdLhByoFmNl1p9n34eNDM2XTbadSxr63QTxp2JBQ4EIN0wkp1NTZxjcs=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=BHAt6QTIxA4BdVvE8tdXeoUI24l/ePrKlsRdKVqHLnk=;
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

     Please split the code change and dts/config change into different 
patch.


Thanks,

- Kever

On 2025/2/11 13:33, FUKAUMI Naoki wrote:
> Boot the RK3588 from the USB OTG port using rkflashtool[1] or
> rkusbboot[2] and dfu-util.
>
> 1a. Download the TPL and SPL using rkflashtool
>
> $ rkflashtool l < mkimage-in-simple-bin.mkimage-rockchip-tpl
> $ rkflashtool L < mkimage-in-simple-bin.mkimage-u-boot-spl
>
> 1b. Download the TPL and SPL using rkusbboot
>
> $ rkusbboot \
> 	mkimage-in-simple-bin.mkimage-rockchip-tpl \
> 	mkimage-in-simple-bin.mkimage-u-boot-spl
>
> 2. Download the U-Boot
>
> $ dfu-util -a 0 -D u-boot.itb
>
> [1] https://github.com/linux-rockchip/rkflashtool
> [2] https://github.com/RadxaNaoki/rkusbboot
>
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> ---
>   arch/arm/dts/rk3588s-u-boot.dtsi       | 5 +++++
>   arch/arm/mach-rockchip/rk3588/rk3588.c | 1 +
>   configs/generic-rk3588_defconfig       | 9 +++++++++
>   include/configs/rk3588_common.h        | 7 +++++++
>   4 files changed, 22 insertions(+)
>
> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
> index 8880d162b11..1e961768341 100644
> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
> @@ -161,6 +161,11 @@
>   	bootph-all;
>   };
>   
> +&usb_host0_xhci {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
>   &xin24m {
>   	bootph-all;
>   };
> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
> index c1dce3ee370..662b092d811 100644
> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
> @@ -53,6 +53,7 @@ const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>   	[BROM_BOOTSOURCE_FSPI_M1] = "/spi@fe2b0000/flash@0",
>   	[BROM_BOOTSOURCE_FSPI_M2] = "/spi@fe2b0000/flash@0",
>   	[BROM_BOOTSOURCE_SD] = "/mmc@fe2c0000",
> +	[BROM_BOOTSOURCE_USB] = "/usb@fc000000",
>   };
>   
>   static struct mm_region rk3588_mem_map[] = {
> diff --git a/configs/generic-rk3588_defconfig b/configs/generic-rk3588_defconfig
> index 51e31dce3a9..0dd64783bc0 100644
> --- a/configs/generic-rk3588_defconfig
> +++ b/configs/generic-rk3588_defconfig
> @@ -21,7 +21,9 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-generic.dtb"
>   CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_ENV_SUPPORT=y
>   CONFIG_SPL_ATF=y
> +CONFIG_CMD_DFU=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_MISC=y
> @@ -41,6 +43,9 @@ CONFIG_SPL_REGMAP=y
>   CONFIG_SPL_SYSCON=y
>   # CONFIG_ADC is not set
>   CONFIG_SPL_CLK=y
> +CONFIG_DFU_RAM=y
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
> +CONFIG_SYS_DFU_MAX_FILE_SIZE=0x200000
>   # CONFIG_USB_FUNCTION_FASTBOOT is not set
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_MISC=y
> @@ -60,9 +65,13 @@ CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_SYSRESET=y
>   CONFIG_SYSRESET_PSCI=y
>   CONFIG_USB=y
> +CONFIG_SPL_DM_USB_GADGET=y
>   CONFIG_USB_DWC3=y
>   CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_SPL_USB_DWC3_GENERIC=y
>   CONFIG_USB_GADGET=y
> +CONFIG_SPL_USB_GADGET=y
>   CONFIG_USB_GADGET_DOWNLOAD=y
>   CONFIG_USB_FUNCTION_ROCKUSB=y
> +CONFIG_SPL_DFU=y
>   CONFIG_ERRNO_STR=y
> diff --git a/include/configs/rk3588_common.h b/include/configs/rk3588_common.h
> index e6654c275ac..0fad6b37589 100644
> --- a/include/configs/rk3588_common.h
> +++ b/include/configs/rk3588_common.h
> @@ -26,11 +26,18 @@
>   	"ramdisk_addr_r=0x12180000\0"	\
>   	"kernel_comp_size=0x8000000\0"
>   
> +#if defined(CONFIG_SPL_DFU) && defined(CONFIG_XPL_BUILD)
> +#define CFG_EXTRA_ENV_SETTINGS				\
> +	"dfu_alt_info_ram=u-boot.itb ram "		\
> +	__stringify(CONFIG_SPL_LOAD_FIT_ADDRESS) " "	\
> +	__stringify(CONFIG_SYS_DFU_MAX_FILE_SIZE) "\0"
> +#else
>   #define CFG_EXTRA_ENV_SETTINGS		\
>   	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
>   	"partitions=" PARTS_DEFAULT	\
>   	ENV_MEM_LAYOUT_SETTINGS		\
>   	ROCKCHIP_DEVICE_SETTINGS	\
>   	"boot_targets=" BOOT_TARGETS "\0"
> +#endif
>   
>   #endif /* __CONFIG_RK3588_COMMON_H */
