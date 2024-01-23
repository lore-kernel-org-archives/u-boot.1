Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA96C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 02:37:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2181D8784B;
	Tue, 23 Jan 2024 03:37:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="TaRl++Bq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C910587AEC; Tue, 23 Jan 2024 03:36:58 +0100 (CET)
Received: from mail-m12761.qiye.163.com (mail-m12761.qiye.163.com
 [115.236.127.61])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64B7887707
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 03:36:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=TaRl++BqLyUE7gN/u7t2WDtia9KQAE7JL1bFzZdcWtafYWhIbeN+kOpakmkxSqn2NvGlGm1cGbU2D+RksO5N40J16+zLTt3/huRQq7DcrGKFj1X5HwMrTIBX0J4WyosAIHm1Ii6oZHAlR89k7kt2ik8JFUBEos5zCX883zMOIrg=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=+IdSZqNw6GnzYSZNiCeuOYpDKdh5icdXOT29+vwQP9Q=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11880.qiye.163.com (Hmail) with ESMTPA id C398020187;
 Tue, 23 Jan 2024 10:36:41 +0800 (CST)
Message-ID: <3c5babfa-6ce3-4629-8694-692bda20b3e5@rock-chips.com>
Date: Tue, 23 Jan 2024 10:36:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rockchip: spl: Enable caches to speed up checksum
 validation
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de
References: <20240122181631.2383743-1-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240122181631.2383743-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxoeHlZLSxhKGR9JTktNS0pVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d342d525a2eb6kusnc398020187
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NFE6Qjo6EzwjCA1LKSIqLDwL
 PQ8aFBFVSlVKTEtOQkxMT0tJTU9CVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQk5LNwY+
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

Hi Jonas,

On 2024/1/23 02:16, Jonas Karlman wrote:
> FIT checksum validation is very slow in SPL due to D-cache not being
> enabled.
>
> Enable caches in SPL to speed up FIT checksum validation, from seconds
> to milliseconds.
>
> This change enables caches in SPL on all Rockchip boards, the Kconfig
> options SPL_SYS_ICACHE_OFF and SPL_SYS_DCACHE_OFF can be enabled to
> disable caches for a specific board or SoC if needed.
It should invalidate cache before go to next stage, but the U-Boot 
proper and SPL
are using different memory area and U-Boot calls cleanup_before_linux() 
at last,
this patch should be safe in current code structure.

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever

>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> Changes in v2:
> - None
>
> This has been tested on multiple RK3288, RK3328, RK3399, RK356x and
> RK3588 boards without any issues, vendor U-Boot also enables caches in
> SPL for all SoCs.
>
> Link to RFC: https://patchwork.ozlabs.org/patch/1802303/
> ---
>   arch/arm/mach-rockchip/spl.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
> index 87280e2ba7cc..e29c841100c8 100644
> --- a/arch/arm/mach-rockchip/spl.c
> +++ b/arch/arm/mach-rockchip/spl.c
> @@ -136,6 +136,10 @@ void board_init_f(ulong dummy)
>   	}
>   	gd->ram_top = gd->ram_base + get_effective_memsize();
>   	gd->ram_top = board_get_usable_ram_top(gd->ram_size);
> +	gd->relocaddr = gd->ram_top;
> +
> +	arch_reserve_mmu();
> +	enable_caches();
>   #endif
>   	preloader_console_init();
>   }
