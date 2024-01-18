Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9150C4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 06:57:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41E7887B42;
	Thu, 18 Jan 2024 07:57:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Wt+g9KtC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6152187B6C; Thu, 18 Jan 2024 07:57:53 +0100 (CET)
Received: from mail-m12824.netease.com (mail-m12824.netease.com
 [103.209.128.24])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB2F2878E9
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 07:57:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Wt+g9KtCYXAippWUJOKcrAl/3z/2s1p6ZVtCS0CPbZ1GRk1N+aWKX6dmYb4tHtZwxpD9JPr2gMuY3iTU9JGHA2PeOwLXEurmWGqox4Kp1lCX+MSdFrAemW2RWbBNRtfGyy6/kL983qhhHFr1k+Iv1EWf5lMeo27Yiccmhmd4Gw8=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=pieufuC5ZEWe5UEZhL3miKoQi8mE+8anGlGkSn6YAcw=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11873.qiye.163.com (Hmail) with ESMTPA id 881E4900477;
 Thu, 18 Jan 2024 14:57:44 +0800 (CST)
Message-ID: <1cf849d9-085e-4c06-83c6-f9e1b6bc7c51@rock-chips.com>
Date: Thu, 18 Jan 2024 14:57:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] rockchip: factor out spl_perform_fixups into
 common spl-boot-order
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>, heiko@sntech.de,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de, jonas@kwiboo.se,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20240117-rk3588-spl-boot-dev-v3-0-72cb989e6da8@theobroma-systems.com>
 <20240117-rk3588-spl-boot-dev-v3-3-72cb989e6da8@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240117-rk3588-spl-boot-dev-v3-3-72cb989e6da8@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh5CHVYZThpLTh0aTENNQx1VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d1b5c85512eafkusn881e4900477
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mhg6Mzo4MDwpTRAqPFEJMEgP
 GQlPChpVSlVKTEtOTk1KS01OSUNCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDSU9ONwY+
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
> All SoCs are susceptible to wanting to know which storage medium was
> used to load U-Boot SPL. So instead of reimplementing the same functions
> in SoCs over and over again (here just rk3399 and px30 but rk3588 is
> coming), let's just put all this in common into spl-boot-order.c
> allowing to support a new SoC just by defining the spl_boot_devices
> array in the appropriate SoC file.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/px30/px30.c      | 46 -------------------------------
>   arch/arm/mach-rockchip/rk3399/rk3399.c  | 46 -------------------------------
>   arch/arm/mach-rockchip/spl-boot-order.c | 49 +++++++++++++++++++++++++++++++++
>   3 files changed, 49 insertions(+), 92 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/px30/px30.c b/arch/arm/mach-rockchip/px30/px30.c
> index 8937677d79e..7676adcb044 100644
> --- a/arch/arm/mach-rockchip/px30/px30.c
> +++ b/arch/arm/mach-rockchip/px30/px30.c
> @@ -449,50 +449,4 @@ const char * const spl_boot_devices[BOOT_DEVICE_NONE + 1] = {
>   	[BOOT_DEVICE_MMC2] = "/mmc@ff370000",
>   	[BOOT_DEVICE_MMC1] = "/mmc@ff390000",
>   };
> -
> -const char *spl_decode_boot_device(u32 boot_device)
> -{
> -	const char *spl_bootdevice_ofpath = NULL;
> -
> -	if (boot_device < ARRAY_SIZE(spl_boot_devices))
> -		spl_bootdevice_ofpath = spl_boot_devices[boot_device];
> -
> -	if (spl_bootdevice_ofpath)
> -		debug("%s: spl_bootdevice_id %x maps to '%s'\n",
> -		      __func__, boot_device, spl_bootdevice_ofpath);
> -	else
> -		debug("%s: failed to resolve spl_bootdevice_id %x\n",
> -		      __func__, boot_device);
> -
> -	return spl_bootdevice_ofpath;
> -}
> -
> -void spl_perform_fixups(struct spl_image_info *spl_image)
> -{
> -	void *blob = spl_image->fdt_addr;
> -	const char *boot_ofpath;
> -	int chosen;
> -
> -	/*
> -	 * Inject the ofpath of the device the full U-Boot (or Linux in
> -	 * Falcon-mode) was booted from into the FDT, if a FDT has been
> -	 * loaded at the same time.
> -	 */
> -	if (!blob)
> -		return;
> -
> -	boot_ofpath = spl_decode_boot_device(spl_image->boot_device);
> -	if (!boot_ofpath) {
> -		pr_err("%s: could not map boot_device to ofpath\n", __func__);
> -		return;
> -	}
> -
> -	chosen = fdt_find_or_add_subnode(blob, 0, "chosen");
> -	if (chosen < 0) {
> -		pr_err("%s: could not find/create '/chosen'\n", __func__);
> -		return;
> -	}
> -	fdt_setprop_string(blob, chosen,
> -			   "u-boot,spl-boot-device", boot_ofpath);
> -}
>   #endif
> diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
> index 60d95c81cd2..6929de5603c 100644
> --- a/arch/arm/mach-rockchip/rk3399/rk3399.c
> +++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
> @@ -181,52 +181,6 @@ const char * const spl_boot_devices[BOOT_DEVICE_NONE + 1] = {
>   	[BOOT_DEVICE_SPI] = "/spi@ff1d0000/flash@0",
>   };
>   
> -const char *spl_decode_boot_device(u32 boot_device)
> -{
> -	const char *spl_bootdevice_ofpath = NULL;
> -
> -	if (boot_device < ARRAY_SIZE(spl_boot_devices))
> -		spl_bootdevice_ofpath = spl_boot_devices[boot_device];
> -
> -	if (spl_bootdevice_ofpath)
> -		debug("%s: spl_bootdevice_id %x maps to '%s'\n",
> -		      __func__, boot_device, spl_bootdevice_ofpath);
> -	else
> -		debug("%s: failed to resolve spl_bootdevice_id %x\n",
> -		      __func__, boot_device);
> -
> -	return spl_bootdevice_ofpath;
> -}
> -
> -void spl_perform_fixups(struct spl_image_info *spl_image)
> -{
> -	void *blob = spl_image->fdt_addr;
> -	const char *boot_ofpath;
> -	int chosen;
> -
> -	/*
> -	 * Inject the ofpath of the device the full U-Boot (or Linux in
> -	 * Falcon-mode) was booted from into the FDT, if a FDT has been
> -	 * loaded at the same time.
> -	 */
> -	if (!blob)
> -		return;
> -
> -	boot_ofpath = spl_decode_boot_device(spl_image->boot_device);
> -	if (!boot_ofpath) {
> -		pr_err("%s: could not map boot_device to ofpath\n", __func__);
> -		return;
> -	}
> -
> -	chosen = fdt_find_or_add_subnode(blob, 0, "chosen");
> -	if (chosen < 0) {
> -		pr_err("%s: could not find/create '/chosen'\n", __func__);
> -		return;
> -	}
> -	fdt_setprop_string(blob, chosen,
> -			   "u-boot,spl-boot-device", boot_ofpath);
> -}
> -
>   static void rk3399_force_power_on_reset(void)
>   {
>   	ofnode node;
> diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
> index 93b8e7de4d0..55d0976fb0a 100644
> --- a/arch/arm/mach-rockchip/spl-boot-order.c
> +++ b/arch/arm/mach-rockchip/spl-boot-order.c
> @@ -5,6 +5,7 @@
>   
>   #include <common.h>
>   #include <dm.h>
> +#include <fdt_support.h>
>   #include <log.h>
>   #include <mmc.h>
>   #include <spl.h>
> @@ -161,4 +162,52 @@ void board_boot_order(u32 *spl_boot_list)
>   	if (idx == 0)
>   		spl_boot_list[0] = spl_boot_device();
>   }
> +
> +__weak const char * const spl_boot_devices[BOOT_DEVICE_NONE + 1] = {};
> +
> +const char *spl_decode_boot_device(u32 boot_device)
> +{
> +	const char *spl_bootdevice_ofpath = NULL;
> +
> +	if (boot_device < ARRAY_SIZE(spl_boot_devices))
> +		spl_bootdevice_ofpath = spl_boot_devices[boot_device];
> +
> +	if (spl_bootdevice_ofpath)
> +		debug("%s: spl_bootdevice_id %x maps to '%s'\n",
> +		      __func__, boot_device, spl_bootdevice_ofpath);
> +	else
> +		debug("%s: failed to resolve spl_bootdevice_id %x\n",
> +		      __func__, boot_device);
> +
> +	return spl_bootdevice_ofpath;
> +}
> +
> +void spl_perform_fixups(struct spl_image_info *spl_image)
> +{
> +	void *blob = spl_image->fdt_addr;
> +	const char *boot_ofpath;
> +	int chosen;
> +
> +	/*
> +	 * Inject the ofpath of the device the full U-Boot (or Linux in
> +	 * Falcon-mode) was booted from into the FDT, if a FDT has been
> +	 * loaded at the same time.
> +	 */
> +	if (!blob)
> +		return;
> +
> +	boot_ofpath = spl_decode_boot_device(spl_image->boot_device);
> +	if (!boot_ofpath) {
> +		pr_err("%s: could not map boot_device to ofpath\n", __func__);
> +		return;
> +	}
> +
> +	chosen = fdt_find_or_add_subnode(blob, 0, "chosen");
> +	if (chosen < 0) {
> +		pr_err("%s: could not find/create '/chosen'\n", __func__);
> +		return;
> +	}
> +	fdt_setprop_string(blob, chosen,
> +			   "u-boot,spl-boot-device", boot_ofpath);
> +}
>   #endif
>
