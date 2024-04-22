Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CF9C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:43:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69531883DF;
	Mon, 22 Apr 2024 10:43:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="cEGjDAp+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77658883D8; Mon, 22 Apr 2024 10:43:23 +0200 (CEST)
Received: from mail-m19731104.qiye.163.com (mail-m19731104.qiye.163.com
 [220.197.31.104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62A2788379
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:43:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=cEGjDAp+awK1frUaM1mZ+nmgJtZHLT7AeX12vTJ/UOlTVEswpWlow158v7axpvH3VKQOE0l5XpPuMcjmGjS9z0e+Kb6oy9tu0sultAtzaCcTcBVgQnonyyHXaEdZkUJyJOZSJXMn+YygRgnGYZt79AOG5SjJyWdIWAs0Tu8pirw=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=PeyOSbiyeeblF+Ur4bzFbUupOZpufbBqzjdbPxIUGAo=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 514389002FD;
 Mon, 22 Apr 2024 16:43:04 +0800 (CST)
Message-ID: <7eb2b762-bdf2-4089-ae39-2059de47e245@rock-chips.com>
Date: Mon, 22 Apr 2024 16:43:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] rockchip: rk3308: Sort imply statements
 alphabetically
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de
References: <20240408181429.3676856-1-jonas@kwiboo.se>
 <20240408181429.3676856-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240408181429.3676856-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx9KGVZNTBgaTU0aHhpKQkpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04f918b003a9kunm514389002fd
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NzI6Ixw5SjNMCDpKQjYoPBQt
 FS0aFA9VSlVKTEpITExOSENOSU9OVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISUhONwY+
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


On 2024/4/9 02:13, Jonas Karlman wrote:
> Sort imply statements under ROCKCHIP_RK3308 alphabetically and remove
> the config SPL_SERIAL statement from soc Kconfig file, it is already
> implyed in arch Kconfig.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: No change
> ---
>   arch/arm/mach-rockchip/Kconfig        | 8 ++++----
>   arch/arm/mach-rockchip/rk3308/Kconfig | 3 ---
>   2 files changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index f68a0a48949a..2fde8655d18a 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -161,13 +161,13 @@ config ROCKCHIP_RK3308
>   	select SPL_ATF_NO_PLATFORM_PARAM
>   	select SPL_LOAD_FIT
>   	imply ROCKCHIP_COMMON_BOARD
> -	imply SPL_ROCKCHIP_COMMON_BOARD
>   	imply SPL_CLK
> -	imply SPL_REGMAP
> -	imply SPL_SYSCON
>   	imply SPL_RAM
> -	imply SPL_SERIAL
> +	imply SPL_REGMAP
> +	imply SPL_ROCKCHIP_COMMON_BOARD
>   	imply SPL_SEPARATE_BSS
> +	imply SPL_SERIAL
> +	imply SPL_SYSCON
>   	help
>   	  The Rockchip RK3308 is a ARM-based Soc which embedded with quad
>   	  Cortex-A35 and highly integrated audio interfaces.
> diff --git a/arch/arm/mach-rockchip/rk3308/Kconfig b/arch/arm/mach-rockchip/rk3308/Kconfig
> index 749e9995d91f..fac966207a92 100644
> --- a/arch/arm/mach-rockchip/rk3308/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3308/Kconfig
> @@ -23,9 +23,6 @@ config ROCKCHIP_COMMON_STACK_ADDR
>   config TEXT_BASE
>   	default 0x00600000
>   
> -config SPL_SERIAL
> -	default y
> -
>   source "board/rockchip/evb_rk3308/Kconfig"
>   source "board/firefly/firefly-rk3308/Kconfig"
>   
