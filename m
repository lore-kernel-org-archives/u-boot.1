Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F98C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 09:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0527D87823;
	Wed, 17 Jan 2024 10:21:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="jU3kql77";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6F7A87823; Wed, 17 Jan 2024 10:21:12 +0100 (CET)
Received: from mail-m24125.xmail.ntesmail.com (mail-m24125.xmail.ntesmail.com
 [45.195.24.125])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D04BB878EE
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 10:21:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=jU3kql77dBzWTVsA1sEFmgk67O6WBPpjq4JKfKLSve9gzOXbZNHGPBV51GDP+9cNN+VHNHjf5v64a0ujOQuFKte+ue6FmrMydYZSuzSLeBhjmJ72yB+s3KLBYh1ssYwtLq5NP+Dh0xn8H9vEI5TuztboPex3VQVw2tve4ggOyus=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=rGzAgsJTZSJxLEq38dy4GbwnC7p0e2a0cnyTTthapQk=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11880.qiye.163.com (Hmail) with ESMTPA id D707320861;
 Wed, 17 Jan 2024 17:21:00 +0800 (CST)
Message-ID: <4ab8ff65-f40b-4802-aaf4-b329dd40aa32@rock-chips.com>
Date: Wed, 17 Jan 2024 17:21:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v2 6/6] rockchip: rk3128: remove noop file
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de, jonas@kwiboo.se,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, heiko@sntech.de
References: <20231108-rk3588-spl-boot-dev-v2-0-e67e26202c85@theobroma-systems.com>
 <20231108-rk3588-spl-boot-dev-v2-6-e67e26202c85@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231108-rk3588-spl-boot-dev-v2-6-e67e26202c85@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR1IQlZOT05CTE4fHktJGExVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d16b954772eb6kusnd707320861
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PBA6DBw5IjwiPhMLGiJMTwhR
 KzhPFApVSlVKTEtOT0NISU1KT01DVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIS0NDNwY+
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


On 2023/11/9 01:25, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> arch_cpu_init is already returning 0 in its weak definition in
> common/board_f.c so let's just remove the file entirely since nothing
> else is done in it.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/rk3128/Makefile |  1 -
>   arch/arm/mach-rockchip/rk3128/rk3128.c | 13 -------------
>   2 files changed, 14 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/rk3128/Makefile b/arch/arm/mach-rockchip/rk3128/Makefile
> index 50e11175423..8df1a60a348 100644
> --- a/arch/arm/mach-rockchip/rk3128/Makefile
> +++ b/arch/arm/mach-rockchip/rk3128/Makefile
> @@ -4,6 +4,5 @@
>   # SPDX-License-Identifier:     GPL-2.0+
>   #
>   
> -obj-y += rk3128.o
>   obj-y += syscon_rk3128.o
>   obj-y += clk_rk3128.o
> diff --git a/arch/arm/mach-rockchip/rk3128/rk3128.c b/arch/arm/mach-rockchip/rk3128/rk3128.c
> deleted file mode 100644
> index 8f8f4951bae..00000000000
> --- a/arch/arm/mach-rockchip/rk3128/rk3128.c
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * Copyright (c) 2017 Rockchip Electronics Co., Ltd
> - */
> -#include <common.h>
> -#include <init.h>
> -
> -int arch_cpu_init(void)
> -{
> -	/* We do some SoC one time setting here. */
> -
> -	return 0;
> -}
>
