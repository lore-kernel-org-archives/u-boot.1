Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99991C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 07:43:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8952689143;
	Fri, 26 Apr 2024 09:43:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="SFSnkGJr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31A228913E; Fri, 26 Apr 2024 09:43:26 +0200 (CEST)
Received: from mail-m127101.qiye.163.com (mail-m127101.qiye.163.com
 [115.236.127.101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3699D89153
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 09:43:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=SFSnkGJrghKzyi0KZnKahaHfuvIxx55eyZdXfEMiURV12IPeAntIJri9WMFaSROMcTKj8n17/QXOGtGnM++Ld1v5uuD9RV8FvoQhirYMozHP/TyEH3KwByoc5MJwx0wx62muvTug+ZzBKFRyWVwEv1Upc9pi3j8XzbmewUtnVeo=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=xq5VtL5tDDFuoo8QXkC4KvIeiH6wl7V79QiDmtlurHg=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 6E260900324;
 Fri, 26 Apr 2024 15:43:06 +0800 (CST)
Message-ID: <06d38233-4d50-4582-b367-991398fc4841@rock-chips.com>
Date: Fri, 26 Apr 2024 15:43:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/11] rockchip: toybrick_rk3588: use DRAM banks from
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
 <20240425-rk35xx-dram-atags-v4-8-331401a58e8e@theobroma-systems.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240425-rk35xx-dram-atags-v4-8-331401a58e8e@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh5LH1YaSR1MGkwfSEoYH0tVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
 kG
X-HM-Tid: 0a8f195ba7d703a9kunm6e260900324
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nio6CRw6ITMBDCs9HDM8Si4K
 PygwCyhVSlVKTEpPSkpMSENCTk5LVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNTkhNNwY+
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
> Similarly, because the toybrick_rk3588.c would be empty, it is simply
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
>   board/rockchip/toybrick_rk3588/Makefile          |  6 ----
>   board/rockchip/toybrick_rk3588/toybrick-rk3588.c | 39 ------------------------
>   configs/toybrick-rk3588_defconfig                |  2 --
>   3 files changed, 47 deletions(-)
>
> diff --git a/board/rockchip/toybrick_rk3588/Makefile b/board/rockchip/toybrick_rk3588/Makefile
> deleted file mode 100644
> index 75d4d9438f7..00000000000
> --- a/board/rockchip/toybrick_rk3588/Makefile
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -# SPDX-License-Identifier:     GPL-2.0+
> -#
> -# Copyright (c) 2024 Rockchip Electronics Co,. Ltd.
> -#
> -
> -obj-y += toybrick-rk3588.o
> diff --git a/board/rockchip/toybrick_rk3588/toybrick-rk3588.c b/board/rockchip/toybrick_rk3588/toybrick-rk3588.c
> deleted file mode 100644
> index e3217f70b50..00000000000
> --- a/board/rockchip/toybrick_rk3588/toybrick-rk3588.c
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * Copyright (c) 2024 Rockchip Electronics Co,. Ltd.
> - */
> -
> -#include <fdtdec.h>
> -#include <fdt_support.h>
> -
> -#ifdef CONFIG_OF_BOARD_SETUP
> -static int rk3588_add_reserved_memory_fdt_nodes(void *new_blob)
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
> -	int ret;
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
> -	return rk3588_add_reserved_memory_fdt_nodes(blob);
> -}
> -#endif
> diff --git a/configs/toybrick-rk3588_defconfig b/configs/toybrick-rk3588_defconfig
> index 6ee92e94313..675e7d89e12 100644
> --- a/configs/toybrick-rk3588_defconfig
> +++ b/configs/toybrick-rk3588_defconfig
> @@ -2,7 +2,6 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_NR_DRAM_BANKS=2
>   CONFIG_DEFAULT_DEVICE_TREE="rk3588-toybrick-x0"
>   CONFIG_ROCKCHIP_RK3588=y
>   CONFIG_SPL_SERIAL=y
> @@ -16,7 +15,6 @@ CONFIG_FIT_VERBOSE=y
>   CONFIG_SPL_FIT_SIGNATURE=y
>   CONFIG_SPL_LOAD_FIT=y
>   CONFIG_LEGACY_IMAGE_FORMAT=y
> -CONFIG_OF_BOARD_SETUP=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-toybrick-x0.dtb"
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>
