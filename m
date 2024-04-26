Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFC6C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 07:42:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88DD88907B;
	Fri, 26 Apr 2024 09:42:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="iY2XS5Fv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22C4889111; Fri, 26 Apr 2024 09:42:23 +0200 (CEST)
Received: from mail-m32104.qiye.163.com (mail-m32104.qiye.163.com
 [220.197.32.104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E200F8907B
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 09:42:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=iY2XS5FvbaDcLWMClRsJNB1EVXX3rc4QzexboELGhOko9i7Ryv4KXAP0JhsYsunnzMYW84Xl7bP87gAJ2qflQF51Ijg63VYTfbMZW4iuuqq9gfgl9139RNY7di/gDhADDwY8kMA+UFOoDmhsoWV2zTbIGxoPDraJ4Ac96rYp8SA=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=s8cz24oeDI7sy8QbYFIIw2jQYKotuMcThWkp8lR1Bls=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 36A35900330;
 Fri, 26 Apr 2024 15:42:04 +0800 (CST)
Message-ID: <c3b1d9f6-c016-4ad2-89c1-ae92f98249e6@rock-chips.com>
Date: Fri, 26 Apr 2024 15:42:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] rockchip: NR_DRAM_BANKS now defaults to 10 when
 Rockchip TPL blob is used
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
 <20240425-rk35xx-dram-atags-v4-2-331401a58e8e@theobroma-systems.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240425-rk35xx-dram-atags-v4-2-331401a58e8e@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRofSFZJSh4YGkgeSUxJSRhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8f195ab23503a9kunm36a35900330
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Oio6Lzo4AjNLCCsCKjgyECws
 SjoKCS5VSlVKTEpPSkpMSElOTE1JVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPSE9LNwY+
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
> When Rockchip TPL blob is used, the memory areas that can be used for
> DRAM is gotten from ATAGS passed through the DRAM at a specific address.
>
> The DDR_MEM tag contains at most 10 areas, so we should default to 10 if
> Rockchip TPL blob is used. Note that it is technically possible we need
> more if one of those 10 areas overlaps with reserved memory area,
> forcing us to split it in two. But a default doesn't need to handle all
> cases, only most.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/Kconfig | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 4f22d9bde9f..644f7997a29 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -574,6 +574,9 @@ config ROCKCHIP_COMMON_STACK_ADDR
>   	imply TPL_SYS_MALLOC_F if TPL
>   	imply TPL_SYS_MALLOC_SIMPLE if TPL
>   
> +config NR_DRAM_BANKS
> +	default 10 if ROCKCHIP_EXTERNAL_TPL
> +
>   source "arch/arm/mach-rockchip/px30/Kconfig"
>   source "arch/arm/mach-rockchip/rk3036/Kconfig"
>   source "arch/arm/mach-rockchip/rk3066/Kconfig"
>
