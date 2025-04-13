Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8BBEC369AE
	for <u-boot@archiver.kernel.org>; Sun, 13 Apr 2025 09:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E30A828AB;
	Sun, 13 Apr 2025 11:39:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ElQk6CUy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC43F829B8; Sun, 13 Apr 2025 11:39:55 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26FAE820EA
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 11:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8059=W7=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1744537191;
 bh=eCnX26WmJlfvsqid0ubhSInDz0/fUn0oVoSqhTyQ0XY=;
 b=ElQk6CUyik9AauwynLUALmFSVpa/6FmMaVZLQ/pM3mXEFZzdUtJahuN2oLoaVEH8iyqWECZbK
 xPiYwjYJsZgkZgZ3Anlq9AezrWdZm6zBa4xDazqrmBc5bOO/PJWPU/mVVmSxZwaujDRb0RUJNKB
 ybDpnkCNh8at4zU8DkeynxqqbXnYluQqWtjDx/yQZh+q9Pe2tkq7dmSnMlTKeuzRfasaMrjmn8E
 MOpYbiRmxjxSVlhgfV0B4DL0fz3BvDJewbXpny9J6x8Drxbp/bK4fXqdK55Lof1mMeXDYYwsUCl
 a4HeMzJbN6GU+37iF0+sNebzpJrIbJXHw5fw3qpQHA0A==
X-Forward-Email-ID: 67fb86643367ea6d19bb6028
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <12b364ef-7139-4fd9-89c7-502b42df0347@kwiboo.se>
Date: Sun, 13 Apr 2025 11:39:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] rockchip: Add DFU to SPL for RK3588
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
 <20250211053340.92919-4-naoki@radxa.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250211053340.92919-4-naoki@radxa.com>
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
>  arch/arm/dts/rk3588s-u-boot.dtsi       | 5 +++++
>  arch/arm/mach-rockchip/rk3588/rk3588.c | 1 +
>  configs/generic-rk3588_defconfig       | 9 +++++++++
>  include/configs/rk3588_common.h        | 7 +++++++
>  4 files changed, 22 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
> index 8880d162b11..1e961768341 100644
> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
> @@ -161,6 +161,11 @@
>  	bootph-all;
>  };
>  
> +&usb_host0_xhci {
> +	bootph-pre-ram;

Please wrap bootph-pre-ram in IS_ENABLED(CONFIG_SPL_DFU) or similar, we
do not need or want to include the usb node in SPL unless SPL_DFU have
been enabled for the build.


> +	bootph-some-ram;

I do not think USB is needed in U-Boot proper pre-reloc phase, please
drop bootph-some-ram.

> +};
> +
>  &xin24m {
>  	bootph-all;
>  };
> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
> index c1dce3ee370..662b092d811 100644
> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
> @@ -53,6 +53,7 @@ const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>  	[BROM_BOOTSOURCE_FSPI_M1] = "/spi@fe2b0000/flash@0",
>  	[BROM_BOOTSOURCE_FSPI_M2] = "/spi@fe2b0000/flash@0",
>  	[BROM_BOOTSOURCE_SD] = "/mmc@fe2c0000",
> +	[BROM_BOOTSOURCE_USB] = "/usb@fc000000",
>  };
>  
>  static struct mm_region rk3588_mem_map[] = {
> diff --git a/configs/generic-rk3588_defconfig b/configs/generic-rk3588_defconfig
> index 51e31dce3a9..0dd64783bc0 100644
> --- a/configs/generic-rk3588_defconfig
> +++ b/configs/generic-rk3588_defconfig
> @@ -21,7 +21,9 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-generic.dtb"
>  CONFIG_SPL_MAX_SIZE=0x40000
>  CONFIG_SPL_PAD_TO=0x7f8000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_ENV_SUPPORT=y
>  CONFIG_SPL_ATF=y
> +CONFIG_CMD_DFU=y
>  CONFIG_CMD_GPIO=y
>  CONFIG_CMD_GPT=y
>  CONFIG_CMD_MISC=y
> @@ -41,6 +43,9 @@ CONFIG_SPL_REGMAP=y
>  CONFIG_SPL_SYSCON=y
>  # CONFIG_ADC is not set
>  CONFIG_SPL_CLK=y
> +CONFIG_DFU_RAM=y
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
> +CONFIG_SYS_DFU_MAX_FILE_SIZE=0x200000
>  # CONFIG_USB_FUNCTION_FASTBOOT is not set
>  CONFIG_ROCKCHIP_GPIO=y
>  CONFIG_MISC=y
> @@ -60,9 +65,13 @@ CONFIG_SYS_NS16550_MEM32=y
>  CONFIG_SYSRESET=y
>  CONFIG_SYSRESET_PSCI=y
>  CONFIG_USB=y
> +CONFIG_SPL_DM_USB_GADGET=y
>  CONFIG_USB_DWC3=y
>  CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_SPL_USB_DWC3_GENERIC=y
>  CONFIG_USB_GADGET=y
> +CONFIG_SPL_USB_GADGET=y
>  CONFIG_USB_GADGET_DOWNLOAD=y
>  CONFIG_USB_FUNCTION_ROCKUSB=y
> +CONFIG_SPL_DFU=y
>  CONFIG_ERRNO_STR=y
> diff --git a/include/configs/rk3588_common.h b/include/configs/rk3588_common.h
> index e6654c275ac..0fad6b37589 100644
> --- a/include/configs/rk3588_common.h
> +++ b/include/configs/rk3588_common.h
> @@ -26,11 +26,18 @@
>  	"ramdisk_addr_r=0x12180000\0"	\
>  	"kernel_comp_size=0x8000000\0"
>  
> +#if defined(CONFIG_SPL_DFU) && defined(CONFIG_XPL_BUILD)
> +#define CFG_EXTRA_ENV_SETTINGS				\
> +	"dfu_alt_info_ram=u-boot.itb ram "		\
> +	__stringify(CONFIG_SPL_LOAD_FIT_ADDRESS) " "	\
> +	__stringify(CONFIG_SYS_DFU_MAX_FILE_SIZE) "\0"

Is this not needed using DFU in U-Boot proper? And if we use this in
U-Boot proper the load addresses may need to change to match other load
addresses used for booting?

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
>  #endif /* __CONFIG_RK3588_COMMON_H */

