Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59480C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:38:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E51BC883BB;
	Mon, 22 Apr 2024 10:38:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="IzxpWMWl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7AAF88346; Mon, 22 Apr 2024 10:38:09 +0200 (CEST)
Received: from mail-m24106.xmail.ntesmail.com (mail-m24106.xmail.ntesmail.com
 [45.195.24.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A6FE883D4
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:38:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=IzxpWMWlJOPD48V19ZP2wt8a1OtyMV2xfGxRYU4UFbePadOUhlL+A1b+CTHwMkF3VQykiZkbYx6Q2itLLQPIvRd69tBXFDM1pDvqbhcJzHShRUF2ApArcl4iW9B0LDXfEGkpgDO5kemdr3jgBsf4loQGMGEmkaztghWw36lpnQU=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=5WjfQjxe9Afv6NxtYZuKi3CRvStprbqzK8pHFIiOEQE=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 11C5E900315;
 Mon, 22 Apr 2024 16:37:48 +0800 (CST)
Message-ID: <0bcf90bc-9e20-4bdb-86b0-71a16636b518@rock-chips.com>
Date: Mon, 22 Apr 2024 16:37:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/11] rockchip: rk356x: use DRAM banks from ATAGS
To: Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 John Clark <inindev@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
 Eugen Hristev <eugen.hristev@collabora.com>, Andy Yan <andyshrk@163.com>,
 Elon Zhang <zhangzj@rock-chips.com>, Joshua Riek <jjriek@verizon.net>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Jagan Teki <jagan@edgeble.ai>,
 Frank Wunderlich <frank-w@public-files.de>,
 Joseph Chen <chenjh@rock-chips.com>, Tianling Shen <cnsztl@gmail.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Akash Gajjar <gajjar04akash@gmail.com>
Cc: u-boot@lists.denx.de, Chris Morgan <macromorgan@hotmail.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20240415-rk35xx-dram-atags-v3-0-5bc5475b3c0d@theobroma-systems.com>
 <20240415-rk35xx-dram-atags-v3-11-5bc5475b3c0d@theobroma-systems.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240415-rk35xx-dram-atags-v3-11-5bc5475b3c0d@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR0eTFYZQh9PSx9JHk1JTExVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04f44a7a03a9kunm11c5e900315
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PVE6SRw*KzMDMjocNA0XFSg8
 LRAaCQFVSlVKTEpITExOS0xLT0hNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSUJCSjcG
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


On 2024/4/15 22:17, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> RK356x-based devices now support creating DRAM banks with proper holes
> by reading the ATAGS from Rockchip TPL blob, so let's use that mechanism
> instead.
>
> The CONFIG_NR_DRAM_BANK now defaults to 10 which is a safe bet for
> reading banks from ATAGS, so let's use the default value instead.
>
> Co-developed-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/anbernic-rgxx3-rk3566_defconfig   | 1 -
>   configs/bpi-r2-pro-rk3568_defconfig       | 1 -
>   configs/evb-rk3568_defconfig              | 1 -
>   configs/generic-rk3568_defconfig          | 1 -
>   configs/lubancat-2-rk3568_defconfig       | 1 -
>   configs/nanopi-r5c-rk3568_defconfig       | 1 -
>   configs/nanopi-r5s-rk3568_defconfig       | 1 -
>   configs/odroid-m1-rk3568_defconfig        | 1 -
>   configs/pinetab2-rk3566_defconfig         | 1 -
>   configs/quartz64-a-rk3566_defconfig       | 1 -
>   configs/quartz64-b-rk3566_defconfig       | 1 -
>   configs/radxa-cm3-io-rk3566_defconfig     | 1 -
>   configs/radxa-e25-rk3568_defconfig        | 1 -
>   configs/rock-3a-rk3568_defconfig          | 1 -
>   configs/soquartz-blade-rk3566_defconfig   | 1 -
>   configs/soquartz-cm4-rk3566_defconfig     | 1 -
>   configs/soquartz-model-a-rk3566_defconfig | 1 -
>   17 files changed, 17 deletions(-)
>
> diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
> index c8c9238f96f..aa3809e00c1 100644
> --- a/configs/anbernic-rgxx3-rk3566_defconfig
> +++ b/configs/anbernic-rgxx3-rk3566_defconfig
> @@ -3,7 +3,6 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_SPL_GPIO=y
> -CONFIG_NR_DRAM_BANKS=2
>   CONFIG_DEFAULT_DEVICE_TREE="rk3566-anbernic-rgxx3"
>   CONFIG_ROCKCHIP_RK3568=y
>   CONFIG_SPL_ROCKCHIP_BACK_TO_BROM=y
> diff --git a/configs/bpi-r2-pro-rk3568_defconfig b/configs/bpi-r2-pro-rk3568_defconfig
> index 5cc95241ba4..0f85dc63c55 100644
> --- a/configs/bpi-r2-pro-rk3568_defconfig
> +++ b/configs/bpi-r2-pro-rk3568_defconfig
> @@ -2,7 +2,6 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_NR_DRAM_BANKS=2
>   CONFIG_DEFAULT_DEVICE_TREE="rk3568-bpi-r2-pro"
>   CONFIG_ROCKCHIP_RK3568=y
>   CONFIG_SPL_SERIAL=y
> diff --git a/configs/evb-rk3568_defconfig b/configs/evb-rk3568_defconfig
> index 6e8061f5f48..f2f429d33c4 100644
> --- a/configs/evb-rk3568_defconfig
> +++ b/configs/evb-rk3568_defconfig
> @@ -2,7 +2,6 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_NR_DRAM_BANKS=2
>   CONFIG_DEFAULT_DEVICE_TREE="rk3568-evb"
>   CONFIG_ROCKCHIP_RK3568=y
>   CONFIG_SPL_SERIAL=y
> diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
> index e7d5e55bbfd..8f4a6259a27 100644
> --- a/configs/generic-rk3568_defconfig
> +++ b/configs/generic-rk3568_defconfig
> @@ -2,7 +2,6 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_NR_DRAM_BANKS=2
>   CONFIG_DEFAULT_DEVICE_TREE="rk3568-generic"
>   CONFIG_ROCKCHIP_RK3568=y
>   CONFIG_SPL_SERIAL=y
> diff --git a/configs/lubancat-2-rk3568_defconfig b/configs/lubancat-2-rk3568_defconfig
> index 1c50a0ccbe6..ea67b6a7286 100644
> --- a/configs/lubancat-2-rk3568_defconfig
> +++ b/configs/lubancat-2-rk3568_defconfig
> @@ -2,7 +2,6 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_NR_DRAM_BANKS=2
>   CONFIG_DEFAULT_DEVICE_TREE="rk3568-lubancat-2"
>   CONFIG_ROCKCHIP_RK3568=y
>   CONFIG_SPL_SERIAL=y
> diff --git a/configs/nanopi-r5c-rk3568_defconfig b/configs/nanopi-r5c-rk3568_defconfig
> index 0f1a9461a0c..00743b7f926 100644
> --- a/configs/nanopi-r5c-rk3568_defconfig
> +++ b/configs/nanopi-r5c-rk3568_defconfig
> @@ -3,7 +3,6 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_SYS_HAS_NONCACHED_MEMORY=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_NR_DRAM_BANKS=2
>   CONFIG_DEFAULT_DEVICE_TREE="rk3568-nanopi-r5c"
>   CONFIG_ROCKCHIP_RK3568=y
>   CONFIG_SPL_SERIAL=y
> diff --git a/configs/nanopi-r5s-rk3568_defconfig b/configs/nanopi-r5s-rk3568_defconfig
> index 4ebf0cc9ee8..91e3a19dea6 100644
> --- a/configs/nanopi-r5s-rk3568_defconfig
> +++ b/configs/nanopi-r5s-rk3568_defconfig
> @@ -3,7 +3,6 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_SYS_HAS_NONCACHED_MEMORY=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_NR_DRAM_BANKS=2
>   CONFIG_DEFAULT_DEVICE_TREE="rk3568-nanopi-r5s"
>   CONFIG_ROCKCHIP_RK3568=y
>   CONFIG_SPL_SERIAL=y
> diff --git a/configs/odroid-m1-rk3568_defconfig b/configs/odroid-m1-rk3568_defconfig
> index b5ed9e4bc98..e749f9af9d2 100644
> --- a/configs/odroid-m1-rk3568_defconfig
> +++ b/configs/odroid-m1-rk3568_defconfig
> @@ -2,7 +2,6 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_NR_DRAM_BANKS=2
>   CONFIG_SF_DEFAULT_SPEED=24000000
>   CONFIG_SF_DEFAULT_MODE=0x1000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3568-odroid-m1"
> diff --git a/configs/pinetab2-rk3566_defconfig b/configs/pinetab2-rk3566_defconfig
> index bc7a77aa52f..940aa16a465 100644
> --- a/configs/pinetab2-rk3566_defconfig
> +++ b/configs/pinetab2-rk3566_defconfig
> @@ -3,7 +3,6 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_SPL_GPIO=y
> -CONFIG_NR_DRAM_BANKS=2
>   CONFIG_SF_DEFAULT_MODE=0x1000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3566-pinetab2-v2.0"
>   CONFIG_ROCKCHIP_RK3568=y
> diff --git a/configs/quartz64-a-rk3566_defconfig b/configs/quartz64-a-rk3566_defconfig
> index fef80439d89..535e34fb990 100644
> --- a/configs/quartz64-a-rk3566_defconfig
> +++ b/configs/quartz64-a-rk3566_defconfig
> @@ -3,7 +3,6 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_SPL_GPIO=y
> -CONFIG_NR_DRAM_BANKS=2
>   CONFIG_SF_DEFAULT_SPEED=24000000
>   CONFIG_SF_DEFAULT_MODE=0x2000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3566-quartz64-a"
> diff --git a/configs/quartz64-b-rk3566_defconfig b/configs/quartz64-b-rk3566_defconfig
> index bb541ed1af6..e197defd3af 100644
> --- a/configs/quartz64-b-rk3566_defconfig
> +++ b/configs/quartz64-b-rk3566_defconfig
> @@ -2,7 +2,6 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_NR_DRAM_BANKS=2
>   CONFIG_SF_DEFAULT_SPEED=24000000
>   CONFIG_SF_DEFAULT_MODE=0x2000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3566-quartz64-b"
> diff --git a/configs/radxa-cm3-io-rk3566_defconfig b/configs/radxa-cm3-io-rk3566_defconfig
> index bf61db44d3a..d23ab57ada5 100644
> --- a/configs/radxa-cm3-io-rk3566_defconfig
> +++ b/configs/radxa-cm3-io-rk3566_defconfig
> @@ -2,7 +2,6 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_NR_DRAM_BANKS=2
>   CONFIG_DEFAULT_DEVICE_TREE="rk3566-radxa-cm3-io"
>   CONFIG_ROCKCHIP_RK3568=y
>   CONFIG_SPL_SERIAL=y
> diff --git a/configs/radxa-e25-rk3568_defconfig b/configs/radxa-e25-rk3568_defconfig
> index 43aa8ec20e4..dbb77b85f5d 100644
> --- a/configs/radxa-e25-rk3568_defconfig
> +++ b/configs/radxa-e25-rk3568_defconfig
> @@ -3,7 +3,6 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_SYS_HAS_NONCACHED_MEMORY=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_NR_DRAM_BANKS=2
>   CONFIG_DEFAULT_DEVICE_TREE="rk3568-radxa-e25"
>   CONFIG_ROCKCHIP_RK3568=y
>   CONFIG_SPL_SERIAL=y
> diff --git a/configs/rock-3a-rk3568_defconfig b/configs/rock-3a-rk3568_defconfig
> index c161bc974fb..b06b57fe0bf 100644
> --- a/configs/rock-3a-rk3568_defconfig
> +++ b/configs/rock-3a-rk3568_defconfig
> @@ -2,7 +2,6 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_NR_DRAM_BANKS=2
>   CONFIG_SF_DEFAULT_SPEED=24000000
>   CONFIG_SF_DEFAULT_MODE=0x2000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3568-rock-3a"
> diff --git a/configs/soquartz-blade-rk3566_defconfig b/configs/soquartz-blade-rk3566_defconfig
> index b9ac6b9f33d..9d565c162ef 100644
> --- a/configs/soquartz-blade-rk3566_defconfig
> +++ b/configs/soquartz-blade-rk3566_defconfig
> @@ -2,7 +2,6 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_NR_DRAM_BANKS=2
>   CONFIG_DEFAULT_DEVICE_TREE="rk3566-soquartz-blade"
>   CONFIG_ROCKCHIP_RK3568=y
>   CONFIG_SPL_SERIAL=y
> diff --git a/configs/soquartz-cm4-rk3566_defconfig b/configs/soquartz-cm4-rk3566_defconfig
> index e87a6392c52..fe2c771db71 100644
> --- a/configs/soquartz-cm4-rk3566_defconfig
> +++ b/configs/soquartz-cm4-rk3566_defconfig
> @@ -2,7 +2,6 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_NR_DRAM_BANKS=2
>   CONFIG_DEFAULT_DEVICE_TREE="rk3566-soquartz-cm4"
>   CONFIG_ROCKCHIP_RK3568=y
>   CONFIG_SPL_SERIAL=y
> diff --git a/configs/soquartz-model-a-rk3566_defconfig b/configs/soquartz-model-a-rk3566_defconfig
> index b2c1684515e..db9eee21751 100644
> --- a/configs/soquartz-model-a-rk3566_defconfig
> +++ b/configs/soquartz-model-a-rk3566_defconfig
> @@ -2,7 +2,6 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_NR_DRAM_BANKS=2
>   CONFIG_DEFAULT_DEVICE_TREE="rk3566-soquartz-model-a"
>   CONFIG_ROCKCHIP_RK3568=y
>   CONFIG_SPL_SERIAL=y
>
