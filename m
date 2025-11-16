Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D418CCEACEF
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 12:37:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31E7D83959;
	Sun, 16 Nov 2025 13:37:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="h040My7H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E88AB83971; Sun, 16 Nov 2025 13:37:46 +0100 (CET)
Received: from mail-m32107.qiye.163.com (mail-m32107.qiye.163.com
 [220.197.32.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A251835B3
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 13:37:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.73.234])
 by smtp.qiye.163.com (Hmail) with ESMTP id 29bbf1dcd;
 Sun, 16 Nov 2025 20:37:39 +0800 (GMT+08:00)
Message-ID: <9df1bc60-404f-403e-b0fc-65ffe39827e7@rock-chips.com>
Date: Sun, 16 Nov 2025 20:37:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] rockchip: Add support for RAM boot from maskrom
 mode
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Arnaud Patard <arnaud.patard@collabora.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki <naoki@radxa.com>,
 u-boot@lists.denx.de
References: <20250802220738.3018910-1-jonas@kwiboo.se>
 <20250802220738.3018910-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250802220738.3018910-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9a8cabc94803afkunm3ffbc3f389e237
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQ00YVktNT0keHUsdTUxNH1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTEhVSUhPWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=h040My7H+cBXRBvSZFChNvrj7Y58Rettf0caJY2efDsDPm39BcgiTZnYvZja2TXudNk25JD7OM5vpajExo1NwGYftY1vhBRYemt6xTl0G4GiPbtYQIuDaM5kVefRWYz3ZHQIQ4ioVHfNwMKAjEDB8FvAnc2mtwWj8Da69rdNhuw=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=ljLP0y8iyWTckcejAGmcNlsSsIFpQFQwajloIVko6zQ=;
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


On 2025/8/3 06:07, Jonas Karlman wrote:
> The BootROM in Rockchip SoCs will enter maskrom mode when boot firmware
> cannot be found in nand/spi/mmc storage.
>
> In maskrom mode the USB OTG port can accept one of two custom commands.
>
> Initially a 0x471 command to load TPL into SRAM. After TPL has been
> executed and it has returned back-to-BROM, a 0x472 command to load SPL
> into start of DRAM.
>
> Add two binman images that can be used to RAM boot from maskrom mode:
> - u-boot-rockchip-usb471.bin that contains TPL to init DRAM.
> - u-boot-rockchip-usb472.bin that contains SPL and the normal FIT
>    payload with i.e. U-Boot proper, TF-A and FDT.
>
> A config fragment rockchip-ramboot.config can be used to enable building
> of these two binman images, e.g.:
>
>    make generic-rk3588_defconfig rockchip-ramboot.config
>
> These binman images can be used with the proprietary rkbin boot_merger
> tool to create a special loader image that can be used with tools such
> as rkdeveloptool or rockusb tools to RAM boot from maskrom, e.g.:
>
>    Create loader image:
>      $ ../rkbin/tools/boot_merger ./RK3588MINIALL.ini
>
>    Boot from maskrom:
>      $ rkdeveloptool db u-boot-rockchip-rk3588-loader.bin
>     or
>      $ rockusb download-boot u-boot-rockchip-rk3588-loader.bin
>
> Another option that does not require use of proprietary tools is using
> open source tools such as rkflashtool or rkusbboot that can load the
> binman images directly without any need to first create a special loader
> image to RAM boot from maskrom, e.g.:
>
>    $ rkflashtool l < u-boot-rockchip-usb471.bin
>    $ rkflashtool L < u-boot-rockchip-usb472.bin
>   or
>    $ rkusbboot u-boot-rockchip-usb471.bin u-boot-rockchip-usb472.bin
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Tested-by: Arnaud Patard <arnaud.patard@collabora.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Changes in v3:
> - Use read_brom_bootsource_id() to support RAM boot on RK3576
> - Add a rockchip-ramboot.config fragment to enable the Kconfig option
> - Update commit message to highlight that the binman images can be used
>    directly without use of the proprietary rkbin boot_merger tool
>
> Changes in v2:
> - Use fit_template instead of common_part
> - Collect t-b tag
> ---
>   arch/arm/dts/rockchip-u-boot.dtsi       | 33 +++++++++++++++++++++++++
>   arch/arm/mach-rockchip/Kconfig          |  8 ++++++
>   arch/arm/mach-rockchip/spl-boot-order.c | 14 ++++++++---
>   board/rockchip/rockchip-ramboot.config  |  1 +
>   boot/Kconfig                            |  3 +++
>   5 files changed, 56 insertions(+), 3 deletions(-)
>   create mode 100644 board/rockchip/rockchip-ramboot.config
>
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index cc2feed6464f..71d7623fe2ca 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -226,5 +226,38 @@
>   		};
>   	};
>   #endif /* CONFIG_ROCKCHIP_SPI_IMAGE */
> +
> +#ifdef CONFIG_ROCKCHIP_MASKROM_IMAGE
> +	simple-bin-usb471 {
> +		filename = "u-boot-rockchip-usb471.bin";
> +
> +#ifdef CONFIG_ROCKCHIP_EXTERNAL_TPL
> +		rockchip-tpl {
> +		};
> +#elif defined(CONFIG_TPL)
> +		u-boot-tpl {
> +			no-write-symbols;
> +		};
> +#endif
> +	};
> +
> +	simple-bin-usb472 {
> +		filename = "u-boot-rockchip-usb472.bin";
> +		pad-byte = <0x00>;
> +
> +		u-boot-spl {
> +			no-write-symbols;
> +		};
> +
> +#ifdef HAS_FIT
> +		fit {
> +			insert-template = <&fit_template>;
> +#else
> +		u-boot-img {
> +#endif
> +			offset = <(CONFIG_SPL_LOAD_FIT_ADDRESS - CFG_SYS_SDRAM_BASE)>;
> +		};
> +	};
> +#endif /* CONFIG_ROCKCHIP_MASKROM_IMAGE */
>   };
>   #endif /* CONFIG_SPL */
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index c9ce30760292..e32e49ff59ac 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -706,6 +706,14 @@ config ROCKCHIP_SPI_IMAGE
>   	  option to produce a SPI-flash image containing U-Boot. The image
>   	  is built by binman. U-Boot sits near the start of the image.
>   
> +config ROCKCHIP_MASKROM_IMAGE
> +	bool "Build a maskrom mode image for Rockchip"
> +	depends on TPL || ROCKCHIP_EXTERNAL_TPL
> +	select SPL_RAM_DEVICE
> +	help
> +	  Rockchip SoCs support maskrom mode boot over USB. Enable this
> +	  option to produce maskrom mode boot images containing U-Boot.
> +
>   config LNX_KRNL_IMG_TEXT_OFFSET_BASE
>   	default TEXT_BASE
>   
> diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
> index 6b1b84dc86d1..15f1cba8e8fd 100644
> --- a/arch/arm/mach-rockchip/spl-boot-order.c
> +++ b/arch/arm/mach-rockchip/spl-boot-order.c
> @@ -8,6 +8,7 @@
>   #include <log.h>
>   #include <mmc.h>
>   #include <spl.h>
> +#include <asm/arch-rockchip/bootrom.h>
>   #include <asm/global_data.h>
>   #include <dm/uclass-internal.h>
>   
> @@ -98,15 +99,22 @@ __weak const char *board_spl_was_booted_from(void)
>   
>   void board_boot_order(u32 *spl_boot_list)
>   {
> +	int idx = 0;
> +
> +	/* Add RAM boot for maskrom mode boot over USB */
> +	if (BROM_BOOTSOURCE_ID_ADDR && CONFIG_IS_ENABLED(RAM_DEVICE) &&
> +	    read_brom_bootsource_id() == BROM_BOOTSOURCE_USB) {
> +		spl_boot_list[idx++] = BOOT_DEVICE_RAM;
> +	}
> +
>   	/* In case of no fdt (or only plat), use spl_boot_device() */
>   	if (!CONFIG_IS_ENABLED(OF_CONTROL) || CONFIG_IS_ENABLED(OF_PLATDATA)) {
> -		spl_boot_list[0] = spl_boot_device();
> +		spl_boot_list[idx++] = spl_boot_device();
>   		return;
>   	}
>   
>   	const void *blob = gd->fdt_blob;
>   	int chosen_node = fdt_path_offset(blob, "/chosen");
> -	int idx = 0;
>   	int elem;
>   	int boot_device;
>   	int node;
> @@ -115,7 +123,7 @@ void board_boot_order(u32 *spl_boot_list)
>   	if (chosen_node < 0) {
>   		debug("%s: /chosen not found, using spl_boot_device()\n",
>   		      __func__);
> -		spl_boot_list[0] = spl_boot_device();
> +		spl_boot_list[idx++] = spl_boot_device();
>   		return;
>   	}
>   
> diff --git a/board/rockchip/rockchip-ramboot.config b/board/rockchip/rockchip-ramboot.config
> new file mode 100644
> index 000000000000..312363e542b7
> --- /dev/null
> +++ b/board/rockchip/rockchip-ramboot.config
> @@ -0,0 +1 @@
> +CONFIG_ROCKCHIP_MASKROM_IMAGE=y
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 2ff6f0037384..2afad56ddfa6 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -257,6 +257,9 @@ config SPL_LOAD_FIT_ADDRESS
>   	hex "load address of fit image"
>   	depends on SPL_LOAD_FIT
>   	default 0x44000000 if ARCH_IMX8M
> +	default 0x60080000 if ARCH_ROCKCHIP && SPL_TEXT_BASE = 0x60000000
> +	default 0x40200000 if ARCH_ROCKCHIP && SPL_TEXT_BASE = 0x40000000
> +	default 0x00200000 if ARCH_ROCKCHIP && SPL_TEXT_BASE = 0x00000000
>   	default 0x0
>   	help
>   	  Specify the load address of the fit image that will be loaded
