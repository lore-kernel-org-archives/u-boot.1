Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B87C48286
	for <u-boot@archiver.kernel.org>; Sun,  4 Feb 2024 10:45:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D2F287AEC;
	Sun,  4 Feb 2024 11:45:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="HW9Lq1YI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D7D587BCE; Sun,  4 Feb 2024 11:45:37 +0100 (CET)
Received: from mail-m92250.xmail.ntesmail.com (mail-m92250.xmail.ntesmail.com
 [103.126.92.250])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5429879F3
 for <u-boot@lists.denx.de>; Sun,  4 Feb 2024 11:45:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=HW9Lq1YIQyYPhW+Kmp7nuBfbCOYR6OGA1CQsU3BvvVhpAc6/rRwNNwWW9gYXkyATd2Y90zA1oddQCIiXelSfn7blKUa23PnVJf7u8Fr73jDdzaK/Wli5BEhy3JgG9WCAOQkeYb2UgjM9hW3azdOKjRb+yNpGlgChWDAzeQNe1gc=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=V0iF2EHO212iw26nqJewRR03LAAbq/N0qcf4Me+Vmgk=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 1FF4A900208;
 Sun,  4 Feb 2024 18:45:13 +0800 (CST)
Message-ID: <71f45740-0ff4-445a-a941-69c079dae421@rock-chips.com>
Date: Sun, 4 Feb 2024 18:45:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] rockchip: rk3399: simplify logic for getting SPL
 boot medium DT node
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: heiko@sntech.de, u-boot@lists.denx.de, jonas@kwiboo.se,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20240118-rk3588-spl-boot-dev-v5-0-a8df3e50f486@theobroma-systems.com>
 <20240118-rk3588-spl-boot-dev-v5-1-a8df3e50f486@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240118-rk3588-spl-boot-dev-v5-1-a8df3e50f486@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx5DHlZOTx5KH0xNQ0xJHUJVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d73b8e4bb03a9kunm1ff4a900208
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pz46ISo5NjMOOT5RPg4vQkpP
 SxYwFDVVSlVKTEtMS09ITkpIQ0NNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPSElONwY+
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

Hi  Quentin,

     Could you help to rebase and send this patch again?

     I can't see the version v5 on patchwork.


Thanks,

- Kever

On 2024/1/18 21:55, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> In preparation of moving spl_perform_fixups to spl-boot-order.c, let's
> simplify the logic around mapping the BOOT_DEVICE_x enum index to a DT
> node by using an instantiated array of chars instead of creating a new
> data structure on the fly.
>
> This will make it easier to factor out the code handling the SPL boot
> medium detection by having spl_decode_boot_device common to all SoCs.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>   arch/arm/mach-rockchip/rk3399/rk3399.c | 34 +++++++++++++++++++---------------
>   1 file changed, 19 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
> index 14565d2ed9f..60d95c81cd2 100644
> --- a/arch/arm/mach-rockchip/rk3399/rk3399.c
> +++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
> @@ -175,23 +175,27 @@ void board_debug_uart_init(void)
>   #endif
>   
>   #if defined(CONFIG_SPL_BUILD) && !defined(CONFIG_TPL_BUILD)
> +const char * const spl_boot_devices[BOOT_DEVICE_NONE + 1] = {
> +	[BOOT_DEVICE_MMC2] = "/mmc@fe320000",
> +	[BOOT_DEVICE_MMC1] = "/mmc@fe330000",
> +	[BOOT_DEVICE_SPI] = "/spi@ff1d0000/flash@0",
> +};
> +
>   const char *spl_decode_boot_device(u32 boot_device)
>   {
> -	int i;
> -	static const struct {
> -		u32 boot_device;
> -		const char *ofpath;
> -	} spl_boot_devices_tbl[] = {
> -		{ BOOT_DEVICE_MMC2, "/mmc@fe320000" },
> -		{ BOOT_DEVICE_MMC1, "/mmc@fe330000" },
> -		{ BOOT_DEVICE_SPI, "/spi@ff1d0000/flash@0" },
> -	};
> -
> -	for (i = 0; i < ARRAY_SIZE(spl_boot_devices_tbl); ++i)
> -		if (spl_boot_devices_tbl[i].boot_device == boot_device)
> -			return spl_boot_devices_tbl[i].ofpath;
> -
> -	return NULL;
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
>   }
>   
>   void spl_perform_fixups(struct spl_image_info *spl_image)
>
