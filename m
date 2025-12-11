Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F635D41C2C
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 12:27:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A66E98389A;
	Thu, 11 Dec 2025 13:27:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="MtyknLdX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B969A83A26; Thu, 11 Dec 2025 13:27:14 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 815808312A
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 13:27:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=db6d=6S=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1765456025;
 bh=WnC9ISfWyLVn/Jsa0wo/BYkWDGBVihEezOuUoXKYsmM=;
 b=MtyknLdXq5q99LDuss3tMiJzudvUe65kLraLYSLMaDVK2w4GJcbvpLw0iqH+axPdndmYiLKMh
 eB6wKgAQqy4WZ3HKNVp9nKKSmbk2+fsz9kyG8/tDF2QoNwb/vzNvxK4x2hQtbn4+EfxWcZ++OPB
 UtZ6DgraAlxhs5VMrj/p/YmlsNZiu85l9JGGJtX1vVXYs6WDvAQ6AiMAaX+U4VeLXxuLMYDKM6B
 0TDpt26T2Lfl38+wfVf+4xpBxc0wXu9MLnM9hJCT+euLxgJFI3LWcNkMEXhzeZG9VVojJWyp4SB
 FF6ct8clWxtVYMzzlWIEiGIZ6X/ybBnEjh5xjdvFzyYQ==
X-Forward-Email-ID: 693ab897138b35e7e7178af7
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.6.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <f616ea88-9d87-4960-bf02-62f0fbd1b206@kwiboo.se>
Date: Thu, 11 Dec 2025 13:27:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] common/spl: fit: Avoid directly loading images to
 load_addr
To: Alexey Charkov <alchark@gmail.com>
Cc: u-boot@lists.denx.de
References: <20251210-rk3576-ufs-v1-0-a3f9e76eb66e@gmail.com>
 <20251210-rk3576-ufs-v1-1-a3f9e76eb66e@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20251210-rk3576-ufs-v1-1-a3f9e76eb66e@gmail.com>
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

Hi Alexey,

On 12/10/2025 9:10 PM, Alexey Charkov wrote:
> Load images unconditionally to a known-safe location (which is
> CONFIG_SYS_LOAD_ADDR) to be later relocated to its desired load address.
> 
> Some storage devices may be unable to directly load each of the images
> listed in a FIT to their desired load addresses, as is the case with
> e.g. booting from UFS storage on Rockchip RK3576, where part of the
> ATF should end up in SRAM but the UFS controller cannot directly write
> there.
> 
> Furthermore, the code down the line does a memmove or image decompression
> from the original src_ptr, anyway, so there shouldn't be any performance
> implications from this change.

If I am not mistaken the memmove will try to move the src_ptr into
load_addr and as long as they are same this is a no-op, so I am
expecting this will have performance implications.

I suggest we instead try to configure the rk3576 firewall to allow the
UFS controller to access SRAM (SYSMEM) similar to how this is allowed on
e.g. rk3588. Please see U-Boot rk3576.c and rk3588.c, and also TF-A
plat/rockchip/rk3576/drivers/secure/firewall.c.

For other Rockchip SoCs we have also used non-DMA mode or a bounce
buffer to work around similar issue in the drivers.

On a final note I would not fully trust the SYS_LOAD_ADDR addr on
Rockchip platform, to my knowledge this is not really used for anything
and because of this have not fully been considered when other static
load addresses have been picked, so this could introduce some unintended
overlaps.

Regards,
Jonas

> 
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
>  common/spl/spl_fit.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index a588d13eb402..f10c0ca7d281 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -291,11 +291,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
>  			return 0;
>  		}
>  
> -		if (spl_decompression_enabled() &&
> -		    (image_comp == IH_COMP_GZIP || image_comp == IH_COMP_LZMA))
> -			src_ptr = map_sysmem(ALIGN(CONFIG_SYS_LOAD_ADDR, ARCH_DMA_MINALIGN), len);
> -		else
> -			src_ptr = map_sysmem(ALIGN(load_addr, ARCH_DMA_MINALIGN), len);
> +		src_ptr = map_sysmem(ALIGN(CONFIG_SYS_LOAD_ADDR, ARCH_DMA_MINALIGN), len);
>  		length = len;
>  
>  		overhead = get_aligned_image_overhead(info, offset);
> 

