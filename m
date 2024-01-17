Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB87C47422
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 10:16:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB4D087B2A;
	Wed, 17 Jan 2024 11:16:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="EVkJKgGL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1133787B30; Wed, 17 Jan 2024 11:16:22 +0100 (CET)
Received: from mail-m127219.xmail.ntesmail.com
 (mail-m127219.xmail.ntesmail.com [115.236.127.219])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A214D87A0B
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 11:16:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=EVkJKgGL0AI+TgZ+Dc5WZG//SQ0xINTD6qLzUrEK5YD42CECZClsNDvP3T3Dw19nO0wPnRBXswNWM1mm1NT2tz5q8qb+LlS9vgDe7pz5sRRNkjTAfPama0Nksx9CT9BpIdLKXTnoiGPfU7FooS5BZ5EPySKOGmOcfEsXkY+ThQ4=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=5YGHEZI6ATsI9+5CZtyTbsQY77YNnmhXiG8UhDKGqow=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11880.qiye.163.com (Hmail) with ESMTPA id 023A120843;
 Wed, 17 Jan 2024 18:16:09 +0800 (CST)
Message-ID: <ec946f62-94b3-4dcf-8193-3478cacc224a@rock-chips.com>
Date: Wed, 17 Jan 2024 18:16:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v2 4/6] rockchip: rk3588: insert
 u-boot,spl-boot-device into U-Boot device tree
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de, jonas@kwiboo.se,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, heiko@sntech.de
References: <20231108-rk3588-spl-boot-dev-v2-0-e67e26202c85@theobroma-systems.com>
 <20231108-rk3588-spl-boot-dev-v2-4-e67e26202c85@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231108-rk3588-spl-boot-dev-v2-4-e67e26202c85@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxlOH1YfHUJOSR8ZTh4ZSxlVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d16ebd2d12eb6kusn023a120843
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pj46PQw5DjwoHBMWTAIvSihD
 DkJPCjFVSlVKTEtOT0NNTkxLQ0pKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPS0hONwY+
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

Hi Quentin,

On 2023/11/9 01:25, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> It is possible to boot U-Boot proper from a different storage medium
> than the one used by the BOOTROM to load the SPL. This information is
> stored in the u-boot,spl-boot-device Device Tree property and is
> accessible from U-Boot proper so that it has knowledge at runtime where
> it was loaded from.
>
> Let's add support for this feature for rk3588 the same way it was done
> for px30 and rk3399.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>   arch/arm/mach-rockchip/rk3588/rk3588.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
> index b1f535fad50..fde5f281b0a 100644
> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
> @@ -163,3 +163,11 @@ int arch_cpu_init(void)
>   	return 0;
>   }
>   #endif
> +
> +#if defined(CONFIG_SPL_BUILD) && !defined(CONFIG_TPL_BUILD)
> +const char * const spl_boot_devices[BOOT_DEVICE_NONE + 1] = {
> +	[BOOT_DEVICE_MMC2] = "/mmc@fe2e0000",
> +	[BOOT_DEVICE_MMC1] = "/mmc@fe2c0000",

This may be wrong because I found that the mmc0 alias is not the same 
for all the boards.

Rockchip platform do set SD card alias as mmc0 before no alias used by 
kernel, and after kernel enable

the use of alias, the different board has different mmc0:

arch/arm/dts/rk3588-rock-5b.dts:        mmc0 = &sdhci;
arch/arm/dts/rk3588-edgeble-neu6b.dtsi:        mmc0 = &sdhci;
arch/arm/dts/rk3588s-orangepi-5.dts:        mmc0 = &sdmmc;
arch/arm/dts/rk3588s-rock-5a.dts:        mmc0 = &sdhci;
arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi:        mmc0 = &sdmmc;
arch/arm/dts/rk3588-edgeble-neu6a.dtsi:        mmc0 = &sdhci;
arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi:        mmc0 = &sdmmc;
arch/arm/dts/rk3588-quartzpro64.dts:        mmc0 = &sdhci;
arch/arm/dts/rk3588-evb1-v10.dts:        mmc0 = &sdhci;
arch/arm/dts/rk3588-orangepi-5-plus.dts:        mmc0 = &sdhci;
arch/arm/dts/rk3588-nanopc-t6.dts:        mmc0 = &sdhci;


Thanks,
- Kever
> +	[BOOT_DEVICE_SPI] = "/spi@fe2b0000/flash@0",
> +};
> +#endif
>
