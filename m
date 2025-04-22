Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FADC369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 14:50:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9F1980FA8;
	Tue, 22 Apr 2025 16:50:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="SbWXyiTi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8612880FF7; Tue, 22 Apr 2025 16:50:42 +0200 (CEST)
Received: from mail-m1973182.qiye.163.com (mail-m1973182.qiye.163.com
 [220.197.31.82])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D40E38070C
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 16:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.69.12] (unknown [218.17.18.106])
 by smtp.qiye.163.com (Hmail) with ESMTP id 12bf175d3;
 Tue, 22 Apr 2025 22:50:31 +0800 (GMT+08:00)
Message-ID: <ddc8c6cc-2133-482a-a465-9d43440438cb@rock-chips.com>
Date: Tue, 22 Apr 2025 22:50:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/15] rockchip: sdram: honor CFG_SYS_SDRAM_BASE when
 defining ram regions
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu
Cc: lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com
References: <20250415215128.1475593-1-heiko@sntech.de>
 <20250415215128.1475593-2-heiko@sntech.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250415215128.1475593-2-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSxpDVktKTUgeTE9JSBlNH1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlJSkNVSkxVSkNVSktNWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0NMVUpLS1
 VLWQY+
X-HM-Tid: 0a965dfaabdd03afkunm12bf175d3
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OSo6KDo4MjJCFkk9EQweDAEC
 LzkwCwxVSlVKTE9OSEhIT0hJTEpCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlJSkNVSkxVSkNVSktNWVdZCAFZQUhKSEg3Bg++
DKIM-Signature: a=rsa-sha256;
 b=SbWXyiTiFDhHUen7HlR37MfHyg14jR3YJouuZ3pOaYVdD4Ue3KPtKhepVLH/GM8EDpY49PFUzpMvSzY2sNaWu9OXtYcVPTNbyE8shDjtgsEq1FBSS1gnSBms2BIELgFGS5Ykiz8OD+AASNf6YKkMLWZ6J/eqB/5q2XGYJSbk0tE=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=kkaW2XK+DHdArJr7RvhTm+OXAAPVT1hN/r6qG3JcvKE=;
 h=date:mime-version:subject:message-id:from;
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


On 2025/4/16 05:51, Heiko Stuebner wrote:
> Currently the sdram code for arm64 expects CFG_SYS_SDRAM_BASE to be 0.
> The ram being in front and the device-area behind it.
>
> The upcoming RK3576 uses a different layout, with the device area
> in front the ram, which then also extends past the 4G mark.
>
> Adapt both the generic zone definitions as well as the ATAG parser
> to be usable on devices where CFG_SYS_SDRAM_BASE is not 0.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/sdram.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
> index aa3f47c3f20..f20d30f3595 100644
> --- a/arch/arm/mach-rockchip/sdram.c
> +++ b/arch/arm/mach-rockchip/sdram.c
> @@ -182,9 +182,9 @@ static int rockchip_dram_init_banksize(void)
>   		 * BL31 (TF-A) reserves the first 2MB but DDR_MEM tag may not
>   		 * have it, so force this space as reserved.
>   		 */
> -		if (start_addr < SZ_2M) {
> -			size -= SZ_2M - start_addr;
> -			start_addr = SZ_2M;
> +		if (start_addr < CFG_SYS_SDRAM_BASE + SZ_2M) {
> +			size -= CFG_SYS_SDRAM_BASE + SZ_2M - start_addr;
> +			start_addr = CFG_SYS_SDRAM_BASE + SZ_2M;
>   		}
>   
>   		/*
> @@ -229,7 +229,7 @@ static int rockchip_dram_init_banksize(void)
>   					return -EINVAL;
>   				}
>   
> -				size -= rsrv_end - start_addr;
> +				size -= rsrv_end - (start_addr - CFG_SYS_SDRAM_BASE);
>   				start_addr = rsrv_end;
>   				break;
>   			}
> @@ -302,8 +302,8 @@ int dram_init_banksize(void)
>   	debug("Couldn't use ATAG (%d) to detect DDR layout, falling back...\n",
>   	      ret);
>   
> -	/* Reserve 0x200000 for ATF bl31 */
> -	gd->bd->bi_dram[0].start = 0x200000;
> +	/* Reserve 2M for ATF bl31 */
> +	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE + SZ_2M;
>   	gd->bd->bi_dram[0].size = top - gd->bd->bi_dram[0].start;
>   
>   	/* Add usable memory beyond the blob of space for peripheral near 4GB */
