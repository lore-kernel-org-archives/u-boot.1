Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7CAC4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 11:01:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E88CE8856C;
	Tue, 23 Apr 2024 13:01:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="javzWHdp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55D458856C; Tue, 23 Apr 2024 13:01:24 +0200 (CEST)
Received: from mail-m127209.xmail.ntesmail.com
 (mail-m127209.xmail.ntesmail.com [115.236.127.209])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67037884F0
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 13:01:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=javzWHdp+cMfvlWzj1d3eRgTGbNdHXJl2546x6ZyqLdVusEEFVyerh9dUtTlHvdsgivVOmkY8BMTtDpapkxGsa2Jiew0okDQ0jOAcaR8MTvosX/CGLSfTGKDG6fcYUsNlRhkpdj0aR5bTs2yn/FH891NngllStXaJQf6dqW5Hsw=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=eWH9AKCO+6MkxIFYwR5eKheK1Pm3hhjnHbqQeSDcn9Q=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 2D0E790033A;
 Tue, 23 Apr 2024 19:01:09 +0800 (CST)
Message-ID: <38ad5d3f-0fd1-4555-bfc9-f8106acf78a8@rock-chips.com>
Date: Tue, 23 Apr 2024 19:01:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/31] rockchip: rk3399: Sort imply statements
 alphabetically
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-4-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240331202921.262323-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0oZH1ZISB9KTBhOTUgaSUJVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f0a9ddf0e03a9kunm2d0e790033a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OUk6Cww4EjMDNj0KKU4*GlEY
 SE4aCjJVSlVKTEpIQ0xLS01CQ0JPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISkNLNwY+
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


On 2024/4/1 04:28, Jonas Karlman wrote:
> Sort imply statements under ROCKCHIP_RK3399 alphabetically.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/Kconfig | 28 ++++++++++++++--------------
>   1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 22eccaaf5cb1..c0010fbb6887 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -260,30 +260,30 @@ config ROCKCHIP_RK3399
>   	select DM_PMIC
>   	select DM_REGULATOR_FIXED
>   	select BOARD_LATE_INIT
> +	imply BOOTSTD_FULL
> +	imply CMD_BOOTCOUNT if BOOTCOUNT_LIMIT
> +	imply MISC
> +	imply MISC_INIT_R
>   	imply PARTITION_TYPE_GUID
>   	imply PRE_CONSOLE_BUFFER
>   	imply ROCKCHIP_COMMON_BOARD
> +	imply ROCKCHIP_EFUSE
>   	imply ROCKCHIP_SDRAM_COMMON
>   	imply SPL_ROCKCHIP_COMMON_BOARD
> -	imply TPL_SERIAL
> +	imply SYS_BOOTCOUNT_SINGLEWORD if BOOTCOUNT_LIMIT
> +	imply TPL_CLK
> +	imply TPL_DM
> +	imply TPL_DRIVERS_MISC
>   	imply TPL_LIBCOMMON_SUPPORT
>   	imply TPL_LIBGENERIC_SUPPORT
> +	imply TPL_OF_CONTROL
> +	imply TPL_RAM
> +	imply TPL_REGMAP
> +	imply TPL_ROCKCHIP_COMMON_BOARD
> +	imply TPL_SERIAL
>   	imply TPL_SYS_MALLOC_SIMPLE
> -	imply TPL_DRIVERS_MISC
> -	imply TPL_OF_CONTROL
> -	imply TPL_DM
> -	imply TPL_REGMAP
>   	imply TPL_SYSCON
> -	imply TPL_RAM
> -	imply TPL_CLK
>   	imply TPL_TINY_MEMSET
> -	imply TPL_ROCKCHIP_COMMON_BOARD
> -	imply SYS_BOOTCOUNT_SINGLEWORD if BOOTCOUNT_LIMIT
> -	imply BOOTSTD_FULL
> -	imply CMD_BOOTCOUNT if BOOTCOUNT_LIMIT
> -	imply MISC
> -	imply ROCKCHIP_EFUSE
> -	imply MISC_INIT_R
>   	help
>   	  The Rockchip RK3399 is a ARM-based SoC with a dual-core Cortex-A72
>   	  and quad-core Cortex-A53.
