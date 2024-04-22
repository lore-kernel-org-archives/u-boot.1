Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC394C10F15
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:35:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39F0388387;
	Mon, 22 Apr 2024 10:35:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="LASCqDTn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2F788838B; Mon, 22 Apr 2024 10:35:28 +0200 (CEST)
Received: from mail-m127168.xmail.ntesmail.com
 (mail-m127168.xmail.ntesmail.com [115.236.127.168])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BD0C88346
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:35:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=LASCqDTn1+Jkf7g+aPmdpT74rbVFKtwgsI939vEFAQLnl/EQLgvDr5FKk9OhtVlNd94KoiQYAd86mP0+0/v7i2zUg1olDaeajzQSy9vTsBpvSQM/UvG+F0705t4g92g9PLO7+LbBUaK9Um/kd3uEjKBV/A3PHMXmRCDnxp4OsSw=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=1g5YcgrQ0YCWbPTg9MdqU+4FvDWen4BLv634woE3dZo=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 57B819002EC;
 Mon, 22 Apr 2024 16:35:09 +0800 (CST)
Message-ID: <3d3217ab-187d-42de-8f0e-783009e58d6c@rock-chips.com>
Date: Mon, 22 Apr 2024 16:35:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/11] rockchip: rock5b-rk3588: use DRAM banks from
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
References: <20240415-rk35xx-dram-atags-v3-0-5bc5475b3c0d@theobroma-systems.com>
 <20240415-rk35xx-dram-atags-v3-6-5bc5475b3c0d@theobroma-systems.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240415-rk35xx-dram-atags-v3-6-5bc5475b3c0d@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh5IGlZKQxhMS0hIS0hNT0hVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04f1dc2503a9kunm57b819002ec
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pww6Ixw6NTMMKjoiNBMDEjIs
 CT9PCUNVSlVKTEpITExPQkpKS0NNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
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


On 2024/4/15 22:16, Quentin Schulz wrote:
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
> index 58c7c44fb4f..3603e175a0b 100644
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
