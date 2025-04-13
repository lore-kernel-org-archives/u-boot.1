Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C158C3601E
	for <u-boot@archiver.kernel.org>; Sun, 13 Apr 2025 09:52:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97F5A828AB;
	Sun, 13 Apr 2025 11:52:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="CT4UAn0a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 234F782A7F; Sun, 13 Apr 2025 11:52:16 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E29F582131
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 11:52:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8059=W7=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1744537931;
 bh=EWOXWd8Jl4xpr7QcwuZ3k1FTgHZycpsoJX1chVpKlJY=;
 b=CT4UAn0ajx2TSPrnzU4LFcyS/dhLlHBFunVQaCAEov/cmNDDR00WEIvG58vuMGjO1Tf7VvuBB
 q0XOC/aYyVr8TZdegw/5/5D0Ol32eij9C1rtc5vxh+CIhgr3UdKla2mEFjQgjxEeS5K0u5J+S/e
 6PWAm5JT2DlUAxzmn/aoDZYU9U/W4YArH1GS5MeytLhs3R7E27URDF0tVvw2VGBesFnV3jnN/vR
 ssc/EJqUybDvZPgzyPs7qnV9wnejnbZTNZx+XNzh9I4LMWuDY7ongjZEGC1BTHk9UAANV/VQj27
 4LxssTu0awWkSEQgEyOiScEj/EvhEg1Ir6vGNSYlpKxQ==
X-Forward-Email-ID: 67fb89453367ea6d19bb6202
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <c103bd5c-f67d-4708-a24b-ec84fe462efb@kwiboo.se>
Date: Sun, 13 Apr 2025 11:51:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] rockchip: Add DFU to SPL for RK3568
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, trini@konsulko.com, quentin.schulz@cherry.de,
 jagan@amarulasolutions.com, dsimic@manjaro.org, pbrobinson@gmail.com,
 liujianfeng1994@gmail.com, paulk@sys-base.io, ricardo@pardini.net,
 heiko@sntech.de, macromorgan@hotmail.com, michal.simek@amd.com,
 seb-dev@mail.de, christopher.obbard@linaro.org, ilias.apalodimas@linaro.org,
 marex@denx.de, mkorpershoek@baylibre.com, xypron.glpk@gmx.de,
 jerome.forissier@linaro.org
References: <20250211053340.92919-1-naoki@radxa.com>
 <20250211053340.92919-5-naoki@radxa.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250211053340.92919-5-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi,

On 2025-02-11 06:33, FUKAUMI Naoki wrote:
> Boot the RK3568 from the USB OTG port using rkflashtool[1] or
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
>  arch/arm/dts/rk356x-u-boot.dtsi        | 5 +++++
>  arch/arm/mach-rockchip/rk3568/rk3568.c | 1 +
>  configs/generic-rk3568_defconfig       | 9 +++++++++
>  include/configs/rk3568_common.h        | 7 +++++++
>  4 files changed, 22 insertions(+)
> 
> diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
> index 24a976cf7e2..8d2485586bd 100644
> --- a/arch/arm/dts/rk356x-u-boot.dtsi
> +++ b/arch/arm/dts/rk356x-u-boot.dtsi
> @@ -170,6 +170,11 @@
>  	bootph-all;
>  };
>  
> +&usb_host0_xhci {
> +	bootph-pre-ram;
> +	bootph-some-ram;

Same as in the RK3588 review, and same goes for remaining SoCs.

Please drop the bootph-some-ram and wrap the bootph-pre-ram in
IF_ENABLED(CONFIG_SPL_DFU).

> +};
> +
>  &xin24m {
>  	bootph-all;
>  };
> diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
> index c2b96902d2d..b087c08b3d0 100644
> --- a/arch/arm/mach-rockchip/rk3568/rk3568.c
> +++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
> @@ -88,6 +88,7 @@ const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>  	[BROM_BOOTSOURCE_EMMC] = "/mmc@fe310000",
>  	[BROM_BOOTSOURCE_SPINOR] = "/spi@fe300000/flash@0",
>  	[BROM_BOOTSOURCE_SD] = "/mmc@fe2b0000",
> +	[BROM_BOOTSOURCE_USB] = "/usb@fcc00000",
>  };
>  
>  struct mm_region *mem_map = rk3568_mem_map;
> diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
> index f79f0e84400..32c6fdc2846 100644
> --- a/configs/generic-rk3568_defconfig
> +++ b/configs/generic-rk3568_defconfig
> @@ -25,9 +25,11 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-generic.dtb"
>  CONFIG_SPL_MAX_SIZE=0x40000
>  CONFIG_SPL_PAD_TO=0x7f8000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_ENV_SUPPORT=y
>  CONFIG_SPL_SPI_LOAD=y
>  CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
>  CONFIG_SPL_ATF=y
> +CONFIG_CMD_DFU=y
>  CONFIG_CMD_GPIO=y
>  CONFIG_CMD_GPT=y
>  CONFIG_CMD_MISC=y
> @@ -47,6 +49,9 @@ CONFIG_SPL_REGMAP=y
>  CONFIG_SPL_SYSCON=y
>  # CONFIG_ADC is not set
>  CONFIG_SPL_CLK=y
> +CONFIG_DFU_RAM=y
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
> +CONFIG_SYS_DFU_MAX_FILE_SIZE=0x200000
>  # CONFIG_USB_FUNCTION_FASTBOOT is not set
>  CONFIG_ROCKCHIP_GPIO=y
>  CONFIG_MISC=y
> @@ -74,9 +79,13 @@ CONFIG_ROCKCHIP_SFC=y
>  CONFIG_SYSRESET=y
>  CONFIG_SYSRESET_PSCI=y
>  CONFIG_USB=y
> +CONFIG_SPL_DM_USB_GADGET=y
>  CONFIG_USB_DWC3=y
>  CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_SPL_USB_DWC3_GENERIC=y

Back when Eugen Hristev sent a "rockchip: rk3588: add support for DFU in
SPL" series [1] there was a few dwc3 patches required for stable
operation. Are these no longer required or was only for rk3588 dwc3
affected?

[1] https://patchwork.ozlabs.org/cover/1815387/

>  CONFIG_USB_GADGET=y
> +CONFIG_SPL_USB_GADGET=y
>  CONFIG_USB_GADGET_DOWNLOAD=y
>  CONFIG_USB_FUNCTION_ROCKUSB=y
> +CONFIG_SPL_DFU=y
>  CONFIG_ERRNO_STR=y
> diff --git a/include/configs/rk3568_common.h b/include/configs/rk3568_common.h
> index 09b7b71c6af..7b6aeca2a15 100644
> --- a/include/configs/rk3568_common.h
> +++ b/include/configs/rk3568_common.h
> @@ -27,11 +27,18 @@
>  	"ramdisk_addr_r=0x12180000\0"	\
>  	"kernel_comp_size=0x8000000\0"
>  
> +#if defined(CONFIG_SPL_DFU) && defined(CONFIG_XPL_BUILD)
> +#define CFG_EXTRA_ENV_SETTINGS				\
> +	"dfu_alt_info_ram=u-boot.itb ram "		\
> +	__stringify(CONFIG_SPL_LOAD_FIT_ADDRESS) " "	\
> +	__stringify(CONFIG_SYS_DFU_MAX_FILE_SIZE) "\0"

Same as in the RK3588 review, and same goes for remaining SoCs.

Do we not need to set similar for U-Boot proper if we want to use DFU
from U-Boot cli?

Regards,
Jonas

> +#else
>  #define CFG_EXTRA_ENV_SETTINGS		\
>  	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
>  	"partitions=" PARTS_DEFAULT	\
>  	ENV_MEM_LAYOUT_SETTINGS		\
>  	ROCKCHIP_DEVICE_SETTINGS	\
>  	"boot_targets=" BOOT_TARGETS "\0"
> +#endif
>  
>  #endif /* __CONFIG_RK3568_COMMON_H */

