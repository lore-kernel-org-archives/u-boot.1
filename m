Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EFA2C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 03:33:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0911988742;
	Tue,  7 May 2024 05:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="BUQGhOEL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9250588740; Tue,  7 May 2024 05:33:23 +0200 (CEST)
Received: from mail-m104.netease.com (mail-m104.netease.com [154.81.10.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D037F88743
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 05:33:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=BUQGhOELoyA325RF6kNVLEK5pl0SsaypbgQzs3fQd9xMCMlylcfPIEz/YDLt/PO7VD9kOsv0MBezfkIe/1sJgfIb/ESIvKlQB+rkpqvv+u7NJIFKOTBWZq+7Y54DYyxG6J8MCdsHdjIE29Y1sijvi7VjqA2ODGGsgmwXwv6kR8M=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=pma3bxh5EcLgZn/7VG7XBHZwe5jkuSPr0Cx0RXx6N8M=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id A123790027B;
 Tue,  7 May 2024 11:33:02 +0800 (CST)
Message-ID: <03c11f1e-646f-4ee4-8eab-2fec41c3789a@rock-chips.com>
Date: Tue, 7 May 2024 11:33:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] rockchip: rk3399: Migrate to OF_UPSTREAM
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Nick Xie <nick@khadas.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Deepak Das <deepakdas.linux@gmail.com>, Alexandre Vicenzi <linux@alxd.me>,
 Xiaobo Tian <peterwillcn@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>, Levin Du
 <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>,
 FUKAUMI Naoki <naoki@radxa.com>,
 Christopher Obbard <chris.obbard@collabora.com>
Cc: u-boot@lists.denx.de
References: <20240504194346.2462489-1-jonas@kwiboo.se>
 <20240504194346.2462489-6-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240504194346.2462489-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhhJTlZKTx1NH04eSkgYHUhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8f511ca83403a9kunma123790027b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MDo6CQw4HDMCIhQtSko3TToJ
 SxwaFDBVSlVKTEpOS05JTENPSEhCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJSUxCTDcG
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
> All RK3399 boards has now been synced to Linux kernel v6.8 DTs and can
> migrate to use OF_UPSTREAM.
>
> Migrate RK3399 boards that exists in Linux v6.8 to use OF_UPSTREAM.
>
> Following target is not migrated to use OF_UPSTREAM:
> - nanopi-m4-2gb-rk3399: DDR3 variant of nanopi-m4-rk3399 (LPDDR3)
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/Makefile                        | 31 --------------------
>   arch/arm/mach-rockchip/Kconfig               |  1 +
>   configs/chromebook_bob_defconfig             |  2 +-
>   configs/chromebook_kevin_defconfig           |  2 +-
>   configs/eaidk-610-rk3399_defconfig           |  2 +-
>   configs/evb-rk3399_defconfig                 |  2 +-
>   configs/ficus-rk3399_defconfig               |  2 +-
>   configs/firefly-rk3399_defconfig             |  2 +-
>   configs/khadas-edge-captain-rk3399_defconfig |  2 +-
>   configs/khadas-edge-rk3399_defconfig         |  2 +-
>   configs/khadas-edge-v-rk3399_defconfig       |  2 +-
>   configs/leez-rk3399_defconfig                |  2 +-
>   configs/nanopc-t4-rk3399_defconfig           |  2 +-
>   configs/nanopi-m4-2gb-rk3399_defconfig       |  1 +
>   configs/nanopi-m4-rk3399_defconfig           |  2 +-
>   configs/nanopi-m4b-rk3399_defconfig          |  2 +-
>   configs/nanopi-neo4-rk3399_defconfig         |  2 +-
>   configs/nanopi-r4s-rk3399_defconfig          |  2 +-
>   configs/orangepi-rk3399_defconfig            |  2 +-
>   configs/pinebook-pro-rk3399_defconfig        |  2 +-
>   configs/pinephone-pro-rk3399_defconfig       |  2 +-
>   configs/puma-rk3399_defconfig                |  2 +-
>   configs/roc-pc-mezzanine-rk3399_defconfig    |  2 +-
>   configs/roc-pc-rk3399_defconfig              |  2 +-
>   configs/rock-4c-plus-rk3399_defconfig        |  2 +-
>   configs/rock-4se-rk3399_defconfig            |  2 +-
>   configs/rock-pi-4-rk3399_defconfig           |  2 +-
>   configs/rock-pi-4c-rk3399_defconfig          |  2 +-
>   configs/rock-pi-n10-rk3399pro_defconfig      |  2 +-
>   configs/rock960-rk3399_defconfig             |  2 +-
>   configs/rockpro64-rk3399_defconfig           |  2 +-
>   31 files changed, 30 insertions(+), 59 deletions(-)
>
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index b7ada58695be..7a65d98635ae 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -98,37 +98,6 @@ dtb-$(CONFIG_ROCKCHIP_RK3368) += \
>   	rk3368-geekbox.dtb \
>   	rk3368-px5-evb.dtb \
>   
> -dtb-$(CONFIG_ROCKCHIP_RK3399) += \
> -	rk3399-evb.dtb \
> -	rk3399-eaidk-610.dtb \
> -	rk3399-ficus.dtb \
> -	rk3399-firefly.dtb \
> -	rk3399-gru-bob.dtb \
> -	rk3399-gru-kevin.dtb \
> -	rk3399-khadas-edge.dtb \
> -	rk3399-khadas-edge-captain.dtb \
> -	rk3399-khadas-edge-v.dtb \
> -	rk3399-leez-p710.dtb \
> -	rk3399-nanopc-t4.dtb \
> -	rk3399-nanopi-m4.dtb \
> -	rk3399-nanopi-m4-2gb.dtb \
> -	rk3399-nanopi-m4b.dtb \
> -	rk3399-nanopi-neo4.dtb \
> -	rk3399-nanopi-r4s.dtb \
> -	rk3399-orangepi.dtb \
> -	rk3399-pinebook-pro.dtb \
> -	rk3399-pinephone-pro.dtb \
> -	rk3399-puma-haikou.dtb \
> -	rk3399-roc-pc.dtb \
> -	rk3399-roc-pc-mezzanine.dtb \
> -	rk3399-rock-4c-plus.dtb \
> -	rk3399-rock-4se.dtb \
> -	rk3399-rock-pi-4a.dtb \
> -	rk3399-rock-pi-4c.dtb \
> -	rk3399-rock960.dtb \
> -	rk3399-rockpro64.dtb \
> -	rk3399pro-rock-pi-n10.dtb
> -
>   dtb-$(CONFIG_ROCKCHIP_RK3568) += \
>   	rk3566-anbernic-rgxx3.dtb \
>   	rk3566-pinetab2-v0.1.dtb \
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index a492b0885c03..a2c81489452e 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -272,6 +272,7 @@ config ROCKCHIP_RK3399
>   	imply MISC_INIT_R
>   	imply OF_LIBFDT_OVERLAY
>   	imply OF_LIVE
> +	imply OF_UPSTREAM
>   	imply PARTITION_TYPE_GUID
>   	imply PHY_GIGE if GMAC_ROCKCHIP
>   	imply PRE_CONSOLE_BUFFER
> diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
> index 9e15d9e3b8f6..acfe3934104f 100644
> --- a/configs/chromebook_bob_defconfig
> +++ b/configs/chromebook_bob_defconfig
> @@ -9,7 +9,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3399-gru-bob"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-gru-bob"
>   CONFIG_SPL_TEXT_BASE=0xff8c2000
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
> diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
> index a79703c0a138..95fdb418d82b 100644
> --- a/configs/chromebook_kevin_defconfig
> +++ b/configs/chromebook_kevin_defconfig
> @@ -9,7 +9,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3399-gru-kevin"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-gru-kevin"
>   CONFIG_SPL_TEXT_BASE=0xff8c2000
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
> diff --git a/configs/eaidk-610-rk3399_defconfig b/configs/eaidk-610-rk3399_defconfig
> index d9cde9ecced5..aedb4570ef8a 100644
> --- a/configs/eaidk-610-rk3399_defconfig
> +++ b/configs/eaidk-610-rk3399_defconfig
> @@ -4,7 +4,7 @@ CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3399-eaidk-610"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-eaidk-610"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
>   CONFIG_TARGET_EVB_RK3399=y
> diff --git a/configs/evb-rk3399_defconfig b/configs/evb-rk3399_defconfig
> index 334259f73eb2..756d6952de1f 100644
> --- a/configs/evb-rk3399_defconfig
> +++ b/configs/evb-rk3399_defconfig
> @@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3399-evb"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-evb"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
>   CONFIG_TARGET_EVB_RK3399=y
> diff --git a/configs/ficus-rk3399_defconfig b/configs/ficus-rk3399_defconfig
> index 0d97b7ecb3c7..dce8093376d6 100644
> --- a/configs/ficus-rk3399_defconfig
> +++ b/configs/ficus-rk3399_defconfig
> @@ -4,7 +4,7 @@ CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3399-ficus"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-ficus"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
>   CONFIG_TARGET_ROCK960_RK3399=y
> diff --git a/configs/firefly-rk3399_defconfig b/configs/firefly-rk3399_defconfig
> index 9c94ac2f3012..edacef29edfc 100644
> --- a/configs/firefly-rk3399_defconfig
> +++ b/configs/firefly-rk3399_defconfig
> @@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3399-firefly"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-firefly"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
>   CONFIG_TARGET_EVB_RK3399=y
> diff --git a/configs/khadas-edge-captain-rk3399_defconfig b/configs/khadas-edge-captain-rk3399_defconfig
> index 67086d9f2fc2..60d4770cb0e4 100644
> --- a/configs/khadas-edge-captain-rk3399_defconfig
> +++ b/configs/khadas-edge-captain-rk3399_defconfig
> @@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_SF_DEFAULT_SPEED=10000000
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3399-khadas-edge-captain"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-khadas-edge-captain"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
>   CONFIG_ROCKCHIP_SPI_IMAGE=y
> diff --git a/configs/khadas-edge-rk3399_defconfig b/configs/khadas-edge-rk3399_defconfig
> index f752731dec01..1321ca1ea59e 100644
> --- a/configs/khadas-edge-rk3399_defconfig
> +++ b/configs/khadas-edge-rk3399_defconfig
> @@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_SF_DEFAULT_SPEED=10000000
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3399-khadas-edge"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-khadas-edge"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
>   CONFIG_ROCKCHIP_SPI_IMAGE=y
> diff --git a/configs/khadas-edge-v-rk3399_defconfig b/configs/khadas-edge-v-rk3399_defconfig
> index cb05a47f812b..3898142c5c7c 100644
> --- a/configs/khadas-edge-v-rk3399_defconfig
> +++ b/configs/khadas-edge-v-rk3399_defconfig
> @@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_SF_DEFAULT_SPEED=10000000
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3399-khadas-edge-v"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-khadas-edge-v"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
>   CONFIG_ROCKCHIP_SPI_IMAGE=y
> diff --git a/configs/leez-rk3399_defconfig b/configs/leez-rk3399_defconfig
> index 903125aa5c1d..ea96e1ef758f 100644
> --- a/configs/leez-rk3399_defconfig
> +++ b/configs/leez-rk3399_defconfig
> @@ -4,7 +4,7 @@ CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3399-leez-p710"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-leez-p710"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
>   CONFIG_TARGET_EVB_RK3399=y
> diff --git a/configs/nanopc-t4-rk3399_defconfig b/configs/nanopc-t4-rk3399_defconfig
> index 3e89f3dcabd0..c63f4c076d55 100644
> --- a/configs/nanopc-t4-rk3399_defconfig
> +++ b/configs/nanopc-t4-rk3399_defconfig
> @@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3399-nanopc-t4"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-nanopc-t4"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
>   CONFIG_TARGET_EVB_RK3399=y
> diff --git a/configs/nanopi-m4-2gb-rk3399_defconfig b/configs/nanopi-m4-2gb-rk3399_defconfig
> index 10bd9fba5388..08c21ee6e5d2 100644
> --- a/configs/nanopi-m4-2gb-rk3399_defconfig
> +++ b/configs/nanopi-m4-2gb-rk3399_defconfig
> @@ -30,6 +30,7 @@ CONFIG_CMD_USB=y
>   # CONFIG_CMD_SETEXPR is not set
>   CONFIG_CMD_TIME=y
>   CONFIG_SPL_OF_CONTROL=y
> +# CONFIG_OF_UPSTREAM is not set
>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> diff --git a/configs/nanopi-m4-rk3399_defconfig b/configs/nanopi-m4-rk3399_defconfig
> index f5305549716c..ad01431cc3ae 100644
> --- a/configs/nanopi-m4-rk3399_defconfig
> +++ b/configs/nanopi-m4-rk3399_defconfig
> @@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3399-nanopi-m4"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-nanopi-m4"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
>   CONFIG_TARGET_EVB_RK3399=y
> diff --git a/configs/nanopi-m4b-rk3399_defconfig b/configs/nanopi-m4b-rk3399_defconfig
> index 70de7e0a6d7f..34f892d5d3c1 100644
> --- a/configs/nanopi-m4b-rk3399_defconfig
> +++ b/configs/nanopi-m4b-rk3399_defconfig
> @@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3399-nanopi-m4b"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-nanopi-m4b"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
>   CONFIG_TARGET_EVB_RK3399=y
> diff --git a/configs/nanopi-neo4-rk3399_defconfig b/configs/nanopi-neo4-rk3399_defconfig
> index 7f936636d419..f38235489ff7 100644
> --- a/configs/nanopi-neo4-rk3399_defconfig
> +++ b/configs/nanopi-neo4-rk3399_defconfig
> @@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3399-nanopi-neo4"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-nanopi-neo4"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
>   CONFIG_TARGET_EVB_RK3399=y
> diff --git a/configs/nanopi-r4s-rk3399_defconfig b/configs/nanopi-r4s-rk3399_defconfig
> index ef74628fb284..ada04b46cb16 100644
> --- a/configs/nanopi-r4s-rk3399_defconfig
> +++ b/configs/nanopi-r4s-rk3399_defconfig
> @@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3399-nanopi-r4s"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-nanopi-r4s"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
>   CONFIG_TARGET_EVB_RK3399=y
> diff --git a/configs/orangepi-rk3399_defconfig b/configs/orangepi-rk3399_defconfig
> index 2d0c9b77e584..5dfbdeaf17f5 100644
> --- a/configs/orangepi-rk3399_defconfig
> +++ b/configs/orangepi-rk3399_defconfig
> @@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3399-orangepi"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-orangepi"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
>   CONFIG_TARGET_EVB_RK3399=y
> diff --git a/configs/pinebook-pro-rk3399_defconfig b/configs/pinebook-pro-rk3399_defconfig
> index 8ac6ddd49dea..5d3e32f9108e 100644
> --- a/configs/pinebook-pro-rk3399_defconfig
> +++ b/configs/pinebook-pro-rk3399_defconfig
> @@ -7,7 +7,7 @@ CONFIG_NR_DRAM_BANKS=1
>   CONFIG_SF_DEFAULT_SPEED=10000000
>   CONFIG_ENV_SIZE=0x8000
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3399-pinebook-pro"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-pinebook-pro"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
>   CONFIG_ROCKCHIP_SPI_IMAGE=y
> diff --git a/configs/pinephone-pro-rk3399_defconfig b/configs/pinephone-pro-rk3399_defconfig
> index 1bb7b35a255c..0eade88068f4 100644
> --- a/configs/pinephone-pro-rk3399_defconfig
> +++ b/configs/pinephone-pro-rk3399_defconfig
> @@ -6,7 +6,7 @@ CONFIG_NR_DRAM_BANKS=1
>   CONFIG_SF_DEFAULT_SPEED=10000000
>   CONFIG_ENV_SIZE=0x8000
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3399-pinephone-pro"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-pinephone-pro"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
>   CONFIG_ROCKCHIP_SPI_IMAGE=y
> diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
> index 5edba19e6ce8..34a0b575991e 100644
> --- a/configs/puma-rk3399_defconfig
> +++ b/configs/puma-rk3399_defconfig
> @@ -7,7 +7,7 @@ CONFIG_NR_DRAM_BANKS=1
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_ENV_SIZE=0x3000
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3399-puma-haikou"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-puma-haikou"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
>   CONFIG_ROCKCHIP_BOOT_MODE_REG=0x0
> diff --git a/configs/roc-pc-mezzanine-rk3399_defconfig b/configs/roc-pc-mezzanine-rk3399_defconfig
> index 8141f803cf3b..a57899bfdfa0 100644
> --- a/configs/roc-pc-mezzanine-rk3399_defconfig
> +++ b/configs/roc-pc-mezzanine-rk3399_defconfig
> @@ -8,7 +8,7 @@ CONFIG_SF_DEFAULT_SPEED=30000000
>   CONFIG_ENV_SIZE=0x8000
>   CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_ENV_SECT_SIZE=0x1000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3399-roc-pc-mezzanine"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-roc-pc-mezzanine"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
>   CONFIG_ROCKCHIP_SPI_IMAGE=y
> diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defconfig
> index b8adf430e9ea..b45f0e0a8994 100644
> --- a/configs/roc-pc-rk3399_defconfig
> +++ b/configs/roc-pc-rk3399_defconfig
> @@ -8,7 +8,7 @@ CONFIG_SF_DEFAULT_SPEED=30000000
>   CONFIG_ENV_SIZE=0x8000
>   CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_ENV_SECT_SIZE=0x1000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3399-roc-pc"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-roc-pc"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
>   CONFIG_ROCKCHIP_SPI_IMAGE=y
> diff --git a/configs/rock-4c-plus-rk3399_defconfig b/configs/rock-4c-plus-rk3399_defconfig
> index e97fde17acc2..80dc44986e71 100644
> --- a/configs/rock-4c-plus-rk3399_defconfig
> +++ b/configs/rock-4c-plus-rk3399_defconfig
> @@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_SF_DEFAULT_SPEED=10000000
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-4c-plus"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-rock-4c-plus"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
>   CONFIG_ROCKCHIP_SPI_IMAGE=y
> diff --git a/configs/rock-4se-rk3399_defconfig b/configs/rock-4se-rk3399_defconfig
> index 13f5f84b9836..f52d4bf9913b 100644
> --- a/configs/rock-4se-rk3399_defconfig
> +++ b/configs/rock-4se-rk3399_defconfig
> @@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_SF_DEFAULT_SPEED=10000000
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-4se"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-rock-4se"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
>   CONFIG_ROCKCHIP_SPI_IMAGE=y
> diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-rk3399_defconfig
> index d474d91053c1..e71c4588b942 100644
> --- a/configs/rock-pi-4-rk3399_defconfig
> +++ b/configs/rock-pi-4-rk3399_defconfig
> @@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_SF_DEFAULT_SPEED=10000000
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-pi-4a"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-rock-pi-4a"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
>   CONFIG_ROCKCHIP_SPI_IMAGE=y
> diff --git a/configs/rock-pi-4c-rk3399_defconfig b/configs/rock-pi-4c-rk3399_defconfig
> index 50c6755246f2..14373933a34f 100644
> --- a/configs/rock-pi-4c-rk3399_defconfig
> +++ b/configs/rock-pi-4c-rk3399_defconfig
> @@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_SF_DEFAULT_SPEED=10000000
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-pi-4c"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-rock-pi-4c"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
>   CONFIG_ROCKCHIP_SPI_IMAGE=y
> diff --git a/configs/rock-pi-n10-rk3399pro_defconfig b/configs/rock-pi-n10-rk3399pro_defconfig
> index 6d93b9e58003..ec995a54a0ee 100644
> --- a/configs/rock-pi-n10-rk3399pro_defconfig
> +++ b/configs/rock-pi-n10-rk3399pro_defconfig
> @@ -4,7 +4,7 @@ CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3399pro-rock-pi-n10"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399pro-rock-pi-n10"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
>   CONFIG_TARGET_EVB_RK3399=y
> diff --git a/configs/rock960-rk3399_defconfig b/configs/rock960-rk3399_defconfig
> index 3ea872a2ca3e..8fff3ed17c24 100644
> --- a/configs/rock960-rk3399_defconfig
> +++ b/configs/rock960-rk3399_defconfig
> @@ -3,7 +3,7 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock960"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-rock960"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
>   CONFIG_TARGET_ROCK960_RK3399=y
> diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
> index 4e1af37a1559..fc0804a0b80d 100644
> --- a/configs/rockpro64-rk3399_defconfig
> +++ b/configs/rockpro64-rk3399_defconfig
> @@ -7,7 +7,7 @@ CONFIG_NR_DRAM_BANKS=1
>   CONFIG_SF_DEFAULT_SPEED=10000000
>   CONFIG_ENV_SIZE=0x8000
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3399-rockpro64"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-rockpro64"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
>   CONFIG_ROCKCHIP_SPI_IMAGE=y
