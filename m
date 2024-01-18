Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32508C47077
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 06:58:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAC1987B43;
	Thu, 18 Jan 2024 07:58:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="L4MjwND6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7D1C87B43; Thu, 18 Jan 2024 07:58:10 +0100 (CET)
Received: from mail-m127172.xmail.ntesmail.com
 (mail-m127172.xmail.ntesmail.com [115.236.127.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9DAC87B50
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 07:58:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=L4MjwND6R63smSU1+VibGnW8gSkQc/b5opL+ZjP74ABPCyMHv+IDt4fv4ORFzOml/fWLHnSHmbQmqwBI5GZqRQINB1r4gHWfml4HEr9nFsLmBYah21oHS6ks6GNIxylcW2EY0mUMcIMwOy4dCErOF9W+B5jCkd0YIz0mUCWADXc=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=x8Vm+ig2KbQfATRmqXY74FMOw2pqP62mtyHzCzjbZG0=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11873.qiye.163.com (Hmail) with ESMTPA id E6C129004A0;
 Thu, 18 Jan 2024 14:57:58 +0800 (CST)
Message-ID: <7dd60667-06b2-4271-937f-7f419f7d396a@rock-chips.com>
Date: Thu, 18 Jan 2024 14:57:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] rockchip: find U-boot proper boot device by
 inverting the logic that sets it
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>, heiko@sntech.de,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de, jonas@kwiboo.se,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20240117-rk3588-spl-boot-dev-v3-0-72cb989e6da8@theobroma-systems.com>
 <20240117-rk3588-spl-boot-dev-v3-4-72cb989e6da8@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240117-rk3588-spl-boot-dev-v3-4-72cb989e6da8@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0lIQlYfQk5ITB0YGksYGB9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d1b5cbd922eafkusne6c129004a0
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6K0k6Iyo4EzwaURBLS0tLME83
 MEIKCwxVSlVKTEtOTk1KS0xCTEtLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDT0lCNwY+
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


On 2024/1/18 01:22, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> BOOT_DEVICE_* is set by spl_node_to_boot_device() depending on the block
> device number associated with the MMC device the SPL used to load U-Boot
> proper from. It is NOT related to the mmc alias in the Device Tree.
>
> For SPI flashes, all SPI flashes will return BOOT_DEVICE_SPI so there's
> currently no way to know from which one the SPL loaded U-Boot proper
> from. Therefore, let's just find the first valid candidate in
> /chosen/u-boot,spl-boot-order that is a SPI flash and return that path.
> This is a best effort.
>
> While the original implementation may have worked, using the exact same
> mechanism but in inverted fashion makes it less likely to have
> surprising corner-cases or side-effects.
>
> A nice side-effect is that all existing and future Rockchip SoCs now
> automatically have their /chosen/u-boot,spl-boot-device set.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/px30/px30.c      |  7 ---
>   arch/arm/mach-rockchip/rk3399/rk3399.c  |  6 ---
>   arch/arm/mach-rockchip/spl-boot-order.c | 91 ++++++++++++++++++++++++++-------
>   3 files changed, 73 insertions(+), 31 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/px30/px30.c b/arch/arm/mach-rockchip/px30/px30.c
> index 7676adcb044..fc7456e680c 100644
> --- a/arch/arm/mach-rockchip/px30/px30.c
> +++ b/arch/arm/mach-rockchip/px30/px30.c
> @@ -443,10 +443,3 @@ void board_debug_uart_init(void)
>   #endif /* CONFIG_DEBUG_UART_BASE && CONFIG_DEBUG_UART_BASE == ... */
>   }
>   #endif /* CONFIG_DEBUG_UART_BOARD_INIT */
> -
> -#if defined(CONFIG_SPL_BUILD) && !defined(CONFIG_TPL_BUILD)
> -const char * const spl_boot_devices[BOOT_DEVICE_NONE + 1] = {
> -	[BOOT_DEVICE_MMC2] = "/mmc@ff370000",
> -	[BOOT_DEVICE_MMC1] = "/mmc@ff390000",
> -};
> -#endif
> diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
> index 6929de5603c..801a4a6662e 100644
> --- a/arch/arm/mach-rockchip/rk3399/rk3399.c
> +++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
> @@ -175,12 +175,6 @@ void board_debug_uart_init(void)
>   #endif
>   
>   #if defined(CONFIG_SPL_BUILD) && !defined(CONFIG_TPL_BUILD)
> -const char * const spl_boot_devices[BOOT_DEVICE_NONE + 1] = {
> -	[BOOT_DEVICE_MMC2] = "/mmc@fe320000",
> -	[BOOT_DEVICE_MMC1] = "/mmc@fe330000",
> -	[BOOT_DEVICE_SPI] = "/spi@ff1d0000/flash@0",
> -};
> -
>   static void rk3399_force_power_on_reset(void)
>   {
>   	ofnode node;
> diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
> index 55d0976fb0a..f2cb17224e8 100644
> --- a/arch/arm/mach-rockchip/spl-boot-order.c
> +++ b/arch/arm/mach-rockchip/spl-boot-order.c
> @@ -10,6 +10,7 @@
>   #include <mmc.h>
>   #include <spl.h>
>   #include <asm/global_data.h>
> +#include <dm/uclass-internal.h>
>   
>   #if CONFIG_IS_ENABLED(OF_LIBFDT)
>   /**
> @@ -163,30 +164,84 @@ void board_boot_order(u32 *spl_boot_list)
>   		spl_boot_list[0] = spl_boot_device();
>   }
>   
> -__weak const char * const spl_boot_devices[BOOT_DEVICE_NONE + 1] = {};
> -
> -const char *spl_decode_boot_device(u32 boot_device)
> +int spl_decode_boot_device(u32 boot_device, char *buf, size_t buflen)
>   {
> -	const char *spl_bootdevice_ofpath = NULL;
> +	struct udevice *dev;
> +	int dev_num, ret;
> +
> +	if (boot_device == BOOT_DEVICE_SPI) {
> +		/* Revert spl_node_to_boot_device() logic to find appropriate SPI flash device */
> +
> +		/*
> +		 * Devices with multiple SPI flash devices will take the first SPI flash found in
> +		 * /chosen/u-boot,spl-boot-order.
> +		 */
> +		const void *blob = gd->fdt_blob;
> +		int chosen_node = fdt_path_offset(blob, "/chosen");
> +		int elem;
> +		int node;
> +		const char *conf;
> +
> +		if (chosen_node < 0) {
> +			debug("%s: /chosen not found\n", __func__);
> +			return -ENODEV;
> +		}
> +
> +		for (elem = 0;
> +		     (conf = fdt_stringlist_get(blob, chosen_node,
> +						"u-boot,spl-boot-order", elem, NULL));
> +		     elem++) {
> +			const char *alias;
> +
> +			/* Handle the case of 'same device the SPL was loaded from' */
> +			if (strncmp(conf, "same-as-spl", 11) == 0) {
> +				conf = board_spl_was_booted_from();
> +				if (!conf)
> +					continue;
> +			}
> +
> +			/* First check if the list element is an alias */
> +			alias = fdt_get_alias(blob, conf);
> +			if (alias)
> +				conf = alias;
> +
> +			/* Try to resolve the config item (or alias) as a path */
> +			node = fdt_path_offset(blob, conf);
> +			if (node < 0) {
> +				debug("%s: could not find %s in FDT\n", __func__, conf);
> +				continue;
> +			}
> +
> +			ret = uclass_find_device_by_of_offset(UCLASS_SPI_FLASH, node, &dev);
> +			if (ret) {
> +				debug("%s: could not find udevice for %s\n", __func__, conf);
> +				continue;
> +			}
>   
> -	if (boot_device < ARRAY_SIZE(spl_boot_devices))
> -		spl_bootdevice_ofpath = spl_boot_devices[boot_device];
> +			return ofnode_get_path(dev_ofnode(dev), buf, buflen);
> +		}
> +
> +		return -ENODEV;
> +	}
>   
> -	if (spl_bootdevice_ofpath)
> -		debug("%s: spl_bootdevice_id %x maps to '%s'\n",
> -		      __func__, boot_device, spl_bootdevice_ofpath);
> -	else
> -		debug("%s: failed to resolve spl_bootdevice_id %x\n",
> -		      __func__, boot_device);
> +	dev_num = (boot_device == BOOT_DEVICE_MMC1) ? 0 : 1;
> +
> +	ret = blk_find_device(UCLASS_MMC, dev_num, &dev);
> +	if (ret) {
> +		debug("%s: could not find blk device for MMC device %d: %d\n",
> +		      __func__, dev_num, ret);
> +		return ret;
> +	}
>   
> -	return spl_bootdevice_ofpath;
> +	dev = dev_get_parent(dev);
> +	return ofnode_get_path(dev_ofnode(dev), buf, buflen);
>   }
>   
>   void spl_perform_fixups(struct spl_image_info *spl_image)
>   {
>   	void *blob = spl_image->fdt_addr;
> -	const char *boot_ofpath;
> -	int chosen;
> +	char boot_ofpath[512];
> +	int chosen, ret;
>   
>   	/*
>   	 * Inject the ofpath of the device the full U-Boot (or Linux in
> @@ -196,9 +251,9 @@ void spl_perform_fixups(struct spl_image_info *spl_image)
>   	if (!blob)
>   		return;
>   
> -	boot_ofpath = spl_decode_boot_device(spl_image->boot_device);
> -	if (!boot_ofpath) {
> -		pr_err("%s: could not map boot_device to ofpath\n", __func__);
> +	ret = spl_decode_boot_device(spl_image->boot_device, boot_ofpath, sizeof(boot_ofpath));
> +	if (ret) {
> +		pr_err("%s: could not map boot_device to ofpath: %d\n", __func__, ret);
>   		return;
>   	}
>   
>
