Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A992FC25B5C
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 03:30:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3089A88727;
	Tue,  7 May 2024 05:30:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ZnZFkh0L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A19088727; Tue,  7 May 2024 05:30:05 +0200 (CEST)
Received: from mail-m127212.xmail.ntesmail.com
 (mail-m127212.xmail.ntesmail.com [115.236.127.212])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D89978872D
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 05:30:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=ZnZFkh0L2gI5Bo7As1Uxa98tvyaUuwsZAspeMBMq2w1FURKp/xJU3ijGlom52Gi9g7vKrOe2R/lLbPwYFW7QxWliH74S7jdyUVn51FyBBspUg+A2Q1TL6YKOQpP+C+dkGJgG1TeV5ii2naykKqK9LaHz7TDd0/h1w/j8+yUUHp0=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=P6jZFUmX4+igHoEnY1f7gb1QeywjmFQxuAQfsbPHvDw=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 887FB90027D;
 Tue,  7 May 2024 11:29:46 +0800 (CST)
Message-ID: <e78a718b-0b47-4829-b4e8-5d88bbaae4c4@rock-chips.com>
Date: Tue, 7 May 2024 11:29:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] rockchip: rk3308: Migrate to OF_UPSTREAM
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar <gajjar04akash@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240504194346.2462489-1-jonas@kwiboo.se>
 <20240504194346.2462489-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240504194346.2462489-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU8eSVZKH0kdQ0tNHksfSxpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8f5119a7b503a9kunm887fb90027d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NU06Txw4GjNCNhQPIw0sKQkC
 OTMKC01VSlVKTEpOS05JTkNMSE5PVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTk9ONwY+
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


On 2024/5/5 03:42, Jonas Karlman wrote:
> All RK3308 boards has now been synced to Linux kernel v6.8 DTs and can
> migrate to use OF_UPSTREAM.
>
> Migrate all RK3308 boards to use OF_UPSTREAM.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/Makefile              | 5 -----
>   arch/arm/mach-rockchip/Kconfig     | 1 +
>   configs/evb-rk3308_defconfig       | 2 +-
>   configs/roc-cc-rk3308_defconfig    | 2 +-
>   configs/rock-pi-s-rk3308_defconfig | 2 +-
>   5 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index c9f1b25ad647..319ec23a4fee 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -92,11 +92,6 @@ dtb-$(CONFIG_ROCKCHIP_RK3288) += \
>   	rk3288-veyron-speedy.dtb \
>   	rk3288-vyasa.dtb
>   
> -dtb-$(CONFIG_ROCKCHIP_RK3308) += \
> -	rk3308-evb.dtb \
> -	rk3308-roc-cc.dtb \
> -	rk3308-rock-pi-s.dtb
> -
>   dtb-$(CONFIG_ROCKCHIP_RK3328) += \
>   	rk3328-evb.dtb \
>   	rk3328-nanopi-r2c.dtb \
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 262cb7cba3ea..f1caf4f3738b 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -166,6 +166,7 @@ config ROCKCHIP_RK3308
>   	imply LEGACY_IMAGE_FORMAT
>   	imply MISC
>   	imply MISC_INIT_R
> +	imply OF_UPSTREAM
>   	imply RNG_ROCKCHIP
>   	imply ROCKCHIP_COMMON_BOARD
>   	imply ROCKCHIP_OTP
> diff --git a/configs/evb-rk3308_defconfig b/configs/evb-rk3308_defconfig
> index 04a94e13a68a..f4c2ea12adaa 100644
> --- a/configs/evb-rk3308_defconfig
> +++ b/configs/evb-rk3308_defconfig
> @@ -2,7 +2,7 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_DEFAULT_DEVICE_TREE="rk3308-evb"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3308-evb"
>   CONFIG_OF_LIBFDT_OVERLAY=y
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3308=y
> diff --git a/configs/roc-cc-rk3308_defconfig b/configs/roc-cc-rk3308_defconfig
> index ef58bd657532..862ea4301f25 100644
> --- a/configs/roc-cc-rk3308_defconfig
> +++ b/configs/roc-cc-rk3308_defconfig
> @@ -3,7 +3,7 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_SPL_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="rk3308-roc-cc"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3308-roc-cc"
>   CONFIG_OF_LIBFDT_OVERLAY=y
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3308=y
> diff --git a/configs/rock-pi-s-rk3308_defconfig b/configs/rock-pi-s-rk3308_defconfig
> index 37a124eae181..c15ba3d8a451 100644
> --- a/configs/rock-pi-s-rk3308_defconfig
> +++ b/configs/rock-pi-s-rk3308_defconfig
> @@ -2,7 +2,7 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_DEFAULT_DEVICE_TREE="rk3308-rock-pi-s"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3308-rock-pi-s"
>   CONFIG_OF_LIBFDT_OVERLAY=y
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3308=y
