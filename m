Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA76C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 17:35:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D2DE82A27;
	Tue, 15 Apr 2025 19:35:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="GYedKHnZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7182082A5E; Tue, 15 Apr 2025 19:35:43 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E62FA82102
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 19:35:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f7e1=XC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1744738540;
 bh=T8yXsexG8pZVQsi2Ud56CFOnIWJykkSKqp4K6TjjFrQ=;
 b=GYedKHnZ0zqP5MeULAUiHSz85l7Ia0DaEfEXMk1bXa9bXB8Tw81vi1WgtCiRFO1M2X22sUwDv
 +0TT7V7D+qODErPoTi8PLpdtNT1A6xvzH/nBE/r9rGSQ7GAUOIWi31+qNL42uZ5+JFXNPMEIcEq
 s1+GKyid7F0vHHPxfzf9q5d/5I48F4GH5RhdtJsrymzbTsPZwIj2UfRxviecsFDqZKC6gn7QunY
 rS7b18Sr5TIdc9Csj21EluBDeywxcoFy4hIEKOJCS+Yu6Yx5yj3vQmlKutPTO4uFbKc4lQTv9VJ
 ehyIdib5sQCo8+zrotBgLAPzndO+2zrXUMIN1fh+hfUQ==
X-Forward-Email-ID: 67fe98e6999e81140c54a3a7
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <a1f9c618-96ce-493e-ba1e-bd00b505f558@kwiboo.se>
Date: Tue, 15 Apr 2025 19:35:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/16] rockchip: sdram: honor CFG_SYS_SDRAM_BASE when
 defining ram regions
To: Heiko Stuebner <heiko@sntech.de>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, quentin.schulz@cherry.de,
 detlev.casanova@collabora.com, u-boot@lists.denx.de,
 sebastian.reichel@collabora.com
References: <20250414200111.1357867-1-heiko@sntech.de>
 <20250414200111.1357867-2-heiko@sntech.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250414200111.1357867-2-heiko@sntech.de>
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

On 2025-04-14 22:00, Heiko Stuebner wrote:
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
> ---
>  arch/arm/mach-rockchip/sdram.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
> index aa3f47c3f20..f6d9c503bfd 100644
> --- a/arch/arm/mach-rockchip/sdram.c
> +++ b/arch/arm/mach-rockchip/sdram.c
> @@ -182,9 +182,9 @@ static int rockchip_dram_init_banksize(void)
>  		 * BL31 (TF-A) reserves the first 2MB but DDR_MEM tag may not
>  		 * have it, so force this space as reserved.
>  		 */
> -		if (start_addr < SZ_2M) {
> -			size -= SZ_2M - start_addr;
> -			start_addr = SZ_2M;
> +		if (start_addr < SZ_2M + CFG_SYS_SDRAM_BASE) {

A small nitpick for consistency:

	if (start_addr < CFG_SYS_SDRAM_BASE + SZ_2M) {

That would result in 4x grep-able "CFG_SYS_SDRAM_BASE + SZ_2M" in this
file.

Regards,
Jonas

> +			size -= CFG_SYS_SDRAM_BASE + SZ_2M - start_addr;
> +			start_addr = CFG_SYS_SDRAM_BASE + SZ_2M;
>  		}
>  
>  		/*
> @@ -229,7 +229,7 @@ static int rockchip_dram_init_banksize(void)
>  					return -EINVAL;
>  				}
>  
> -				size -= rsrv_end - start_addr;
> +				size -= rsrv_end - (start_addr - CFG_SYS_SDRAM_BASE);
>  				start_addr = rsrv_end;
>  				break;
>  			}
> @@ -302,8 +302,8 @@ int dram_init_banksize(void)
>  	debug("Couldn't use ATAG (%d) to detect DDR layout, falling back...\n",
>  	      ret);
>  
> -	/* Reserve 0x200000 for ATF bl31 */
> -	gd->bd->bi_dram[0].start = 0x200000;
> +	/* Reserve 2M for ATF bl31 */
> +	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE + SZ_2M;
>  	gd->bd->bi_dram[0].size = top - gd->bd->bi_dram[0].start;
>  
>  	/* Add usable memory beyond the blob of space for peripheral near 4GB */

