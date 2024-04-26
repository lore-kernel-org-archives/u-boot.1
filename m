Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288EEC4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 07:43:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6E4B8913C;
	Fri, 26 Apr 2024 09:43:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="bd3ny1Nz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E41EA89145; Fri, 26 Apr 2024 09:43:15 +0200 (CEST)
Received: from mail-m6039.netease.com (mail-m6039.netease.com [210.79.60.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FA1F89142
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 09:43:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=bd3ny1Nz3ERyrpWf7HY8s5HFtihc6PAPsw02pMpkDCqFpm1nIGk/R7sHI5MJAZMi0sLfEpIQNyymjfbd7Wt56Lo0KlgRMRRHvyCZQ+32U1Hn0NYsd37XaFS0SLjXHyjO7MC8MbHCfziQ1tWMoiMHaugs2OkZ8fs28KEajwJvAB4=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=1waaHy1OOA2SE64fGEQqXZ767QA7ulcMZQSj+iCMmf4=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 5A2079002F7;
 Fri, 26 Apr 2024 15:42:51 +0800 (CST)
Message-ID: <62a64b39-281d-4610-ab11-669893427cf1@rock-chips.com>
Date: Fri, 26 Apr 2024 15:42:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/11] rockchip: rock5b-rk3588: use DRAM banks from
 ATAGS
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
References: <20240425-rk35xx-dram-atags-v4-0-331401a58e8e@theobroma-systems.com>
 <20240425-rk35xx-dram-atags-v4-6-331401a58e8e@theobroma-systems.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240425-rk35xx-dram-atags-v4-6-331401a58e8e@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGktJTVYYQk8fHkwfQ05JGUlVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
 kG
X-HM-Tid: 0a8f195b6dba03a9kunm5a2079002f7
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OhQ6Lxw*MjNMTSsdDDpDFzI3
 OTxPFCpVSlVKTEpPSkpMSExIQ0tIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNT0xJNwY+
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


On 2024/4/25 18:46, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> RK3588-based devices now support creating DRAM banks with proper holes
> by reading the ATAGS from Rockchip TPL blob, so let's use that mechanism
> instead.
>
> Since ft_board_setup isn't defined anymore, there's no need for
> selecting CONFIG_OF_BOARD_SETUP.
>
> Similarly, because the rock5b-rk3588.c would be empty, it is simply
> removed, with the (would-be-empty) Makefile as well.
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
>   board/radxa/rock5b-rk3588/Makefile        |  6 -----
>   board/radxa/rock5b-rk3588/rock5b-rk3588.c | 39 -------------------------------
>   configs/rock5b-rk3588_defconfig           |  2 --
>   3 files changed, 47 deletions(-)
>
> diff --git a/board/radxa/rock5b-rk3588/Makefile b/board/radxa/rock5b-rk3588/Makefile
> deleted file mode 100644
> index 95d813596da..00000000000
> --- a/board/radxa/rock5b-rk3588/Makefile
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -# SPDX-License-Identifier:     GPL-2.0+
> -#
> -# Copyright (c) 2022 Collabora Ltd.
> -#
> -
> -obj-y += rock5b-rk3588.o
> diff --git a/board/radxa/rock5b-rk3588/rock5b-rk3588.c b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
> deleted file mode 100644
> index 5c3b52b9489..00000000000
> --- a/board/radxa/rock5b-rk3588/rock5b-rk3588.c
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * Copyright (c) 2023 Collabora Ltd.
> - */
> -
> -#include <fdtdec.h>
> -#include <fdt_support.h>
> -
> -#ifdef CONFIG_OF_BOARD_SETUP
> -int rock5b_add_reserved_memory_fdt_nodes(void *new_blob)
> -{
> -	struct fdt_memory gap1 = {
> -		.start = 0x3fc000000,
> -		.end = 0x3fc4fffff,
> -	};
> -	struct fdt_memory gap2 = {
> -		.start = 0x3fff00000,
> -		.end = 0x3ffffffff,
> -	};
> -	unsigned long flags = FDTDEC_RESERVED_MEMORY_NO_MAP;
> -	unsigned int ret;
> -
> -	/*
> -	 * Inject the reserved-memory nodes into the DTS
> -	 */
> -	ret = fdtdec_add_reserved_memory(new_blob, "gap1", &gap1,  NULL, 0,
> -					 NULL, flags);
> -	if (ret)
> -		return ret;
> -
> -	return fdtdec_add_reserved_memory(new_blob, "gap2", &gap2,  NULL, 0,
> -					  NULL, flags);
> -}
> -
> -int ft_board_setup(void *blob, struct bd_info *bd)
> -{
> -	return rock5b_add_reserved_memory_fdt_nodes(blob);
> -}
> -#endif
> diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
> index ac4f1ebb4c1..ea8e3593572 100644
> --- a/configs/rock5b-rk3588_defconfig
> +++ b/configs/rock5b-rk3588_defconfig
> @@ -3,7 +3,6 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_SYS_HAS_NONCACHED_MEMORY=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_NR_DRAM_BANKS=2
>   CONFIG_SF_DEFAULT_SPEED=24000000
>   CONFIG_SF_DEFAULT_MODE=0x2000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3588-rock-5b"
> @@ -24,7 +23,6 @@ CONFIG_FIT_VERBOSE=y
>   CONFIG_SPL_FIT_SIGNATURE=y
>   CONFIG_SPL_LOAD_FIT=y
>   CONFIG_LEGACY_IMAGE_FORMAT=y
> -CONFIG_OF_BOARD_SETUP=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-rock-5b.dtb"
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>
