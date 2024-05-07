Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AA7C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 03:32:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3543A8873C;
	Tue,  7 May 2024 05:32:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="TypPMnlx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F2F08873D; Tue,  7 May 2024 05:32:49 +0200 (CEST)
Received: from mail-m92242.xmail.ntesmail.com (mail-m92242.xmail.ntesmail.com
 [103.126.92.242])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C22728873B
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 05:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=TypPMnlxJeKUEA8CLzBle8N8I6O6KQrLu0V7pe5K92Uf74KLSr/tlPhA6YFvsSQ89OD+QVhmHvPRFFJE0IxJm3e5vYjha51RKkugRFERKvlyq/p+wGqEzi7NnLotSunueGP5lwgtSUT8FzwaiQd8DkFGA02LADT0H8ZQK0PFcfY=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=z6fEGbTqTNNFC/a4hBV2jZ+JZfYWWPssOEq7ElbCufc=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 4EDAC90027F;
 Tue,  7 May 2024 11:32:35 +0800 (CST)
Message-ID: <ecfb1813-ae9c-40bf-a244-46f269bbf4f6@rock-chips.com>
Date: Tue, 7 May 2024 11:32:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/16] rockchip: rk3328: Migrate to OF_UPSTREAM
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Tianling Shen <cnsztl@gmail.com>, David Bauer <mail@david-bauer.net>,
 Loic Devulder <ldevulder@suse.com>, Chen-Yu Tsai <wens@csie.org>,
 Banglang Huang <banglang.huang@foxmail.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240504194346.2462489-1-jonas@kwiboo.se>
 <20240504194346.2462489-4-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240504194346.2462489-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0kfGlYeTB5NSktCSEsZQk5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f511c3b9603a9kunm4edac90027f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6P006Tww6CTMBMhRMM1EJTTgQ
 H00KCxBVSlVKTEpOS05JTE5NT0pJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDQk5PNwY+
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
> All RK3328 boards has now been synced to Linux kernel v6.8 DTs and can
> migrate to use OF_UPSTREAM.
>
> Migrate all RK3328 boards to use OF_UPSTREAM.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/Makefile                         | 11 -----------
>   arch/arm/mach-rockchip/Kconfig                |  1 +
>   configs/evb-rk3328_defconfig                  |  2 +-
>   configs/nanopi-r2c-plus-rk3328_defconfig      |  2 +-
>   configs/nanopi-r2c-rk3328_defconfig           |  2 +-
>   configs/nanopi-r2s-rk3328_defconfig           |  2 +-
>   configs/orangepi-r1-plus-lts-rk3328_defconfig |  2 +-
>   configs/orangepi-r1-plus-rk3328_defconfig     |  2 +-
>   configs/roc-cc-rk3328_defconfig               |  2 +-
>   configs/rock-pi-e-rk3328_defconfig            |  2 +-
>   configs/rock64-rk3328_defconfig               |  2 +-
>   11 files changed, 10 insertions(+), 20 deletions(-)
>
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 319ec23a4fee..b7ada58695be 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -92,17 +92,6 @@ dtb-$(CONFIG_ROCKCHIP_RK3288) += \
>   	rk3288-veyron-speedy.dtb \
>   	rk3288-vyasa.dtb
>   
> -dtb-$(CONFIG_ROCKCHIP_RK3328) += \
> -	rk3328-evb.dtb \
> -	rk3328-nanopi-r2c.dtb \
> -	rk3328-nanopi-r2c-plus.dtb \
> -	rk3328-nanopi-r2s.dtb \
> -	rk3328-orangepi-r1-plus.dtb \
> -	rk3328-orangepi-r1-plus-lts.dtb \
> -	rk3328-roc-cc.dtb \
> -	rk3328-rock64.dtb \
> -	rk3328-rock-pi-e.dtb
> -
>   dtb-$(CONFIG_ROCKCHIP_RK3368) += \
>   	rk3368-lion-haikou.dtb \
>   	rk3368-sheep.dtb \
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index f1caf4f3738b..a492b0885c03 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -197,6 +197,7 @@ config ROCKCHIP_RK3328
>   	imply MISC
>   	imply MISC_INIT_R
>   	imply OF_LIVE
> +	imply OF_UPSTREAM
>   	imply PRE_CONSOLE_BUFFER
>   	imply ROCKCHIP_COMMON_BOARD
>   	imply ROCKCHIP_EFUSE
> diff --git a/configs/evb-rk3328_defconfig b/configs/evb-rk3328_defconfig
> index 53ad6777ec50..bfb85223437d 100644
> --- a/configs/evb-rk3328_defconfig
> +++ b/configs/evb-rk3328_defconfig
> @@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3328-evb"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3328-evb"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3328=y
>   CONFIG_DEBUG_UART_BASE=0xFF130000
> diff --git a/configs/nanopi-r2c-plus-rk3328_defconfig b/configs/nanopi-r2c-plus-rk3328_defconfig
> index beef682a582e..f311a0a80ba7 100644
> --- a/configs/nanopi-r2c-plus-rk3328_defconfig
> +++ b/configs/nanopi-r2c-plus-rk3328_defconfig
> @@ -6,7 +6,7 @@ CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3328-nanopi-r2c-plus"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3328-nanopi-r2c-plus"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3328=y
>   CONFIG_DEBUG_UART_BASE=0xFF130000
> diff --git a/configs/nanopi-r2c-rk3328_defconfig b/configs/nanopi-r2c-rk3328_defconfig
> index 8960c1afaba5..533dc1029f73 100644
> --- a/configs/nanopi-r2c-rk3328_defconfig
> +++ b/configs/nanopi-r2c-rk3328_defconfig
> @@ -6,7 +6,7 @@ CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3328-nanopi-r2c"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3328-nanopi-r2c"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3328=y
>   CONFIG_DEBUG_UART_BASE=0xFF130000
> diff --git a/configs/nanopi-r2s-rk3328_defconfig b/configs/nanopi-r2s-rk3328_defconfig
> index 96e67e248d32..2591a9cc8ab2 100644
> --- a/configs/nanopi-r2s-rk3328_defconfig
> +++ b/configs/nanopi-r2s-rk3328_defconfig
> @@ -6,7 +6,7 @@ CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3328-nanopi-r2s"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3328-nanopi-r2s"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3328=y
>   CONFIG_DEBUG_UART_BASE=0xFF130000
> diff --git a/configs/orangepi-r1-plus-lts-rk3328_defconfig b/configs/orangepi-r1-plus-lts-rk3328_defconfig
> index 5fbbd5fc6558..14cdbd813c81 100644
> --- a/configs/orangepi-r1-plus-lts-rk3328_defconfig
> +++ b/configs/orangepi-r1-plus-lts-rk3328_defconfig
> @@ -6,7 +6,7 @@ CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3328-orangepi-r1-plus-lts"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3328-orangepi-r1-plus-lts"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3328=y
>   CONFIG_ROCKCHIP_SPI_IMAGE=y
> diff --git a/configs/orangepi-r1-plus-rk3328_defconfig b/configs/orangepi-r1-plus-rk3328_defconfig
> index c5afe5ea6e5c..7fe58e7a1467 100644
> --- a/configs/orangepi-r1-plus-rk3328_defconfig
> +++ b/configs/orangepi-r1-plus-rk3328_defconfig
> @@ -6,7 +6,7 @@ CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3328-orangepi-r1-plus"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3328-orangepi-r1-plus"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3328=y
>   CONFIG_ROCKCHIP_SPI_IMAGE=y
> diff --git a/configs/roc-cc-rk3328_defconfig b/configs/roc-cc-rk3328_defconfig
> index 1dbd39e6b5e7..91b9422e26fb 100644
> --- a/configs/roc-cc-rk3328_defconfig
> +++ b/configs/roc-cc-rk3328_defconfig
> @@ -6,7 +6,7 @@ CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3328-roc-cc"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3328-roc-cc"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3328=y
>   CONFIG_DEBUG_UART_BASE=0xFF130000
> diff --git a/configs/rock-pi-e-rk3328_defconfig b/configs/rock-pi-e-rk3328_defconfig
> index 23029255bca2..5cc54af3ca56 100644
> --- a/configs/rock-pi-e-rk3328_defconfig
> +++ b/configs/rock-pi-e-rk3328_defconfig
> @@ -6,7 +6,7 @@ CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3328-rock-pi-e"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3328-rock-pi-e"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3328=y
>   CONFIG_DEBUG_UART_BASE=0xFF130000
> diff --git a/configs/rock64-rk3328_defconfig b/configs/rock64-rk3328_defconfig
> index b0be1d1d7633..9d77dfb7098a 100644
> --- a/configs/rock64-rk3328_defconfig
> +++ b/configs/rock64-rk3328_defconfig
> @@ -6,7 +6,7 @@ CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3328-rock64"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3328-rock64"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3328=y
>   CONFIG_ROCKCHIP_SPI_IMAGE=y
