Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985DCC0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 22:24:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE00D80EF6;
	Thu, 30 Jan 2025 23:24:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="m7dEBn0Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D174980F18; Thu, 30 Jan 2025 23:24:24 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4245180EEB
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 23:24:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2de8=UX=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1738275861;
 bh=W9u5ayWxXBVH+Llon9SKy/zIcSqknnNkZXHF/ZYEGjg=;
 b=m7dEBn0ZwsFWO/uLnN1rBA3HNon788w+v6Rh8fnGvuYxfWM44Z8BflP6DgfPLaY2TSO6bLrXt
 5xM4ElRfrwMnof0ePN7lGbMbMpbsEYqHPci31hJ/gc/kxmsIcPxTRg2i2nHjKNtpGHqAlLCAkxg
 cpVWurVFWF3jjHKeVgQkWyjd/qbxM11QGb1rIpbK1/bYX7/gNr3HJ1Od0Cq53epHiMFcCnRKANF
 VzMbdfCaTue6bP2QBh36lpvG9P9y6Vr+G9PJlbU4JkZRJsBv3fYG+vWV43lZ4Sc1p5JP33qb9J9
 1ABWkBsiUaIrnnwyfUhP5PWEqQxnGcnJWP4DGtaXQiLg==
X-Forward-Email-ID: 679bfc072d70e7e05883faa1
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <067ba03e-b5cf-42cd-a15f-aa001d436af0@kwiboo.se>
Date: Thu, 30 Jan 2025 23:23:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/20] rockchip: sdram: honor CFG_SYS_SDRAM_BASE when
 defining ram regions
To: Heiko Stuebner <heiko@sntech.de>
Cc: "sjg@chromium.org" <sjg@chromium.org>,
 "philipp.tomsich@vrull.eu" <philipp.tomsich@vrull.eu>,
 "kever.yang@rock-chips.com" <kever.yang@rock-chips.com>,
 "lukma@denx.de" <lukma@denx.de>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "joe.hershberger@ni.com" <joe.hershberger@ni.com>,
 "rfried.dev@gmail.com" <rfried.dev@gmail.com>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
 "detlev.casanova@collabora.com" <detlev.casanova@collabora.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "sebastian.reichel@collabora.com" <sebastian.reichel@collabora.com>
References: <20241121142731.1202209-1-heiko@sntech.de>
 <20241121142731.1202209-9-heiko@sntech.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20241121142731.1202209-9-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Heiko,

On 2024-11-21 15:27, Heiko Stuebner wrote:
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
> ---
>  arch/arm/mach-rockchip/sdram.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
> index 1fb01e1c4b1..4e2af55d6e1 100644
> --- a/arch/arm/mach-rockchip/sdram.c
> +++ b/arch/arm/mach-rockchip/sdram.c
> @@ -181,9 +181,9 @@ static int rockchip_dram_init_banksize(void)
>  		 * BL31 (TF-A) reserves the first 2MB but DDR_MEM tag may not
>  		 * have it, so force this space as reserved.
>  		 */
> -		if (start_addr < SZ_2M) {
> -			size -= SZ_2M - start_addr;
> -			start_addr = SZ_2M;
> +		if (start_addr < SZ_2M + CFG_SYS_SDRAM_BASE) {
> +			size -= SZ_2M - (start_addr - CFG_SYS_SDRAM_BASE);
> +			start_addr = SZ_2M + CFG_SYS_SDRAM_BASE;

For consistency these should be changed to CFG_SYS_SDRAM_BASE + SZ_2M.

>  		}
>  
>  		/*
> @@ -228,7 +228,7 @@ static int rockchip_dram_init_banksize(void)
>  					return -EINVAL;
>  				}
>  
> -				size -= rsrv_end - start_addr;
> +				size -= rsrv_end - (start_addr - CFG_SYS_SDRAM_BASE);
>  				start_addr = rsrv_end;
>  				break;
>  			}
> @@ -302,7 +302,7 @@ int dram_init_banksize(void)
>  	      ret);
>  
>  	/* Reserve 0x200000 for ATF bl31 */
> -	gd->bd->bi_dram[0].start = 0x200000;
> +	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE + 0x200000;

This can be changed to SZ_2M instead of 0x200000 and 2M in the comment.

>  	gd->bd->bi_dram[0].size = top - gd->bd->bi_dram[0].start;
>  
>  	/* Add usable memory beyond the blob of space for peripheral near 4GB */

Beside above nitpicks this is

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

