Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E378AC4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 06:57:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4607887A00;
	Thu, 18 Jan 2024 07:57:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="IUvD3oDe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54F2A87A0E; Thu, 18 Jan 2024 07:57:33 +0100 (CET)
Received: from mail-m24125.xmail.ntesmail.com (mail-m24125.xmail.ntesmail.com
 [45.195.24.125])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20BFE878E9
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 07:57:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=IUvD3oDeaHBN2zuk9GOEJ3cHcIlgtj3SbRS0d2qMHS6bRcjLLXy3euPB81XChFD3v0tL0JiC/4/fSI7iSbTGgPKwEgC0bwEcOp3Zoe/QC/ROx5NQHhz4yUV4W8yv0E9FUWwZFL+KXdgYtY/Caks1XgGjN8KyaOit0h5cGSPrV/s=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=ab/T6oTIJQZedokTOPUKH3bJ6LoDpqP5fTVaPIhsUO4=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11873.qiye.163.com (Hmail) with ESMTPA id 0A6D9900302;
 Thu, 18 Jan 2024 14:57:21 +0800 (CST)
Message-ID: <d126202c-c8b3-47b0-8928-fc5fc2603649@rock-chips.com>
Date: Thu, 18 Jan 2024 14:57:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] rockchip: rk3399: simplify logic for getting SPL
 boot medium DT node
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>, heiko@sntech.de,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de, jonas@kwiboo.se,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20240117-rk3588-spl-boot-dev-v3-0-72cb989e6da8@theobroma-systems.com>
 <20240117-rk3588-spl-boot-dev-v3-1-72cb989e6da8@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240117-rk3588-spl-boot-dev-v3-1-72cb989e6da8@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkNOHlYZGkhIQ01JTh0fH01VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d1b5c294b2eafkusn0a6d9900302
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Okk6SDo5DjwqURAzFlYSMB4N
 SS9PCwpVSlVKTEtOTk1KS09KTElOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPSktMNwY+
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
> In preparation of moving spl_perform_fixups to spl-boot-order.c, let's
> simplify the logic around mapping the BOOT_DEVICE_x enum index to a DT
> node by using an instantiated array of chars instead of creating a new
> data structure on the fly.
>
> This will make it easier to only define the spl_boot_devices array in
> the appropriate SoC file in an upcoming commit.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
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
