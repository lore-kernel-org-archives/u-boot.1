Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B077BC5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:55:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7055C80BEA;
	Mon, 24 Aug 2026 13:55:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vbHfp4boQbyt; Mon, 24 Aug 2026 13:55:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787579727;
	bh=wmRSLUpyzdmGvAK889cRYMQrQ1UjQWbO9xEf33pqlu8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OfDHaNVrE3XTvIRe3xo4148h2arGYOXegNVgCfo+WpDelh9F6SM+wRUTJ0DWmy2oR
	 ectfbB9QOAbI7sZwU2zABpqQNu5KM0iIJIZSHKpt3eZhtHCpjUveJaWnKAGFXsyQcA
	 yoTMGL9B4aHH0wnR0zG/aPcDOLqenGfIG7jus4kgm+8oBB7E3mKtRQ2hkJ4XUatGAv
	 MbJJ/Gy5RusccptrgUWTtohpDTkYqED8PiFDZIsBI+3t9FFj5Y51sCLRWOyMM7ifTt
	 NstVGwfwwHOAZSf2n/3Q3EjrpUhyVkT5rPqGOm5mgwbSKXJL1sRg4h3uGQKaO/DKVr
	 DgG6kAOrU5fGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5135380BEC;
	Mon, 24 Aug 2026 13:55:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A121279
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:55:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7033F60624
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:55:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eRB5q7tvSNk2 for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 13:55:24 +0000 (UTC)
X-Greylist: delayed 586 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 24 Aug 2026 13:55:23 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=jPywnmsi
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.174;
 helo=smtp-42ae.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch
 [84.16.66.174])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DDA5C6061D
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:55:22 +0000 (UTC)
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hTBxm35dSzMcH;
 Mon, 24 Aug 2026 15:45:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787579132;
 bh=wmRSLUpyzdmGvAK889cRYMQrQ1UjQWbO9xEf33pqlu8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jPywnmsiIt3oY6Xh1OFrXocJ5+I7ke7VYj32oemSAPIrL70I5uoBExlaHVK8Ig6k6
 H05U/oLB4yBsrm5cjfCj5kua1G145v31UMnoPF3z5anLMfyRb/2Y/EQqf31g4ZgaZq
 9iIF/6ZsUhoANOfn5VOFhWUqsBr49qxqVu0/ZqQ1Egc7P333YFTqfit197bW7Ya5V9
 EZunTl22DRBj2hxH8GZ4Pc+Yor48rc0DL75arYYeCFZE0OlAOj5yichLnsOGPoMsoY
 JKYyZLz+J4Ndh4LnR0tedtm0DxglgkbyCLRKSive6H4/EQWLPJZs1/9rMX/KoQMzCb
 Yy5+lT/eZSaFg==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hTBxk6sgVzgtT; Mon, 24 Aug 2026 15:45:30 +0200 (CEST)
Message-ID: <a0ac40ac-1716-4451-a585-a1bdec39ce84@0leil.net>
Date: Mon, 24 Aug 2026 15:45:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rockchip: px30: Fix TPL_STACK overflow into BootROM
 reserved region
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20260810211405.2837550-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20260810211405.2837550-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Jonas,

On 8/10/26 11:14 PM, Jonas Karlman wrote:
> The PX30/RK3326 has 16 KiB SRAM at [0xff0e0000, 0xff0e4000), with the
> initial 4 KiB at [0xff0e0000, 0xff0e1000) reserved for BootROM at boot.
> 
> SRAM addressing only seems to use 14 bits, meaning that reading from
> 0xff0e4000+ wraps around and instead reads back data at 0xff0e0000+.
> 
> Using a TPL_STACK at 0xff0e4ff0 (16-bytes aligned) means TPL use BootROM
> reserved region for its global data, malloc area and runtime stack.
> 

This should be its own commit.

> TPL on PX30/RK3326 does not have any use for the malloc area, the
> generated GD_SIZE is typically around 304 bytes and BSS around 72 bytes.
> 

As far as I understood, this is space/size optimization and not a bug 
fix, so should therefore be its own commit.

> Current memory layout possibly looks something like:
> 
>    [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
>      [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
>        [0xff0e09f0, 0xff0e0ff0)    1536 bytes  malloc area (unused)
>        [0xff0e08c0, 0xff0e09f0)     304 bytes  global data
>        [0xff0e08c0]                            stack pointer
>      [0xff0e1000, 0xff0e4000)        12 KiB   TPL area
>        [0xff0e1000, 0xff0e3800)      10 KiB    code
>        [0xff0e3800, 0xff0e3848)      72 bytes  BSS
> 
> Update TPL_STACK to use the top of SRAM address and reduce MALLOC_F_LEN
> to 0x0 to avoid overflowing global data and stack into BootROM reserved
> region.
> 

Aren't we then missing a build-time check to make sure this is not possible?

> After those changes the memory layout looks something like:
> 
>    [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
>      [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
>      [0xff0e1000, 0xff0e4000)        12 KiB   TPL area
>        [0xff0e1000, 0xff0e3800)      10 KiB    code
>        [0xff0e3800, 0xff0e3848)      72 bytes  BSS
>        [0xff0e3ed0, 0xff0e4000)     304 bytes  global data
>        [0xff0e3ed0]                            stack pointer
>          [0xff0e3848, 0xff0e3ed0)  1672 bytes  stack area
> 
> With these changes the TPL_MAX_SIZE can safely be extended to 11 KiB,
> leaving enough for the stack to grow down around 648 bytes before it
> starts to overlap into TPL or BSS.
> 
> And with all changes the memory layout looks something like:
> 
>    [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
>      [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
>      [0xff0e1000, 0xff0e4000)        12 KiB   TPL area
>        [0xff0e1000, 0xff0e3c00)      11 KiB    code
>        [0xff0e3c00, 0xff0e3c48)      72 bytes  BSS
>        [0xff0e3ed0, 0xff0e4000)     304 bytes  global data
>        [0xff0e3ed0]                            stack pointer
>          [0xff0e3c48, 0xff0e3ed0)   648 bytes  stack area
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> The overflow/wrapping was runtime validated on a RK3326 ODROID-GO Super
> by printing out content of [0xff0e0000, 0xff0e5000] and comparing the
> initial 4 KiB with the 16-20 KiB and the data matched 1:1.
> 

How did you test that? md.l on either address results in a Synchronous 
Abort on my PX30 without your patch. We could also just write a random 
pattern only at one address, and if it appears at the other address as 
well, then you've discovered an address wrap indeed.

> Changes in v2:
> - Mention BSS in commit message
> - Update spelling in commit message
> - Collect r-b tag
> 
> With the patch "global_data: Only include driver model fields when DM is
> enabled" [1], the stack area can grow down an additional 48 bytes before
> it starts to overlap into TPL or BSS.
> 
> [1] https://patch.msgid.link/20260810204828.2836359-1-jonas@kwiboo.se/
> ---
>   arch/arm/mach-rockchip/px30/Kconfig | 4 ++--
>   common/spl/Kconfig.tpl              | 2 +-
>   tools/rkcommon.c                    | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-rockchip/px30/Kconfig b/arch/arm/mach-rockchip/px30/Kconfig
> index adba1b49a52b..cc0632cf7b2d 100644
> --- a/arch/arm/mach-rockchip/px30/Kconfig
> +++ b/arch/arm/mach-rockchip/px30/Kconfig
> @@ -81,10 +81,10 @@ config TPL_TEXT_BASE
>   	default 0xff0e1000
>   
>   config TPL_STACK
> -	default 0xff0e4fff
> +	default 0xff0e4000
>   
>   config TPL_SYS_MALLOC_F_LEN
> -	default 0x600
> +	default 0x0

Disable malloc in TPL on PX30 instead, that's actually what you want to 
be doing and not "reserve 0 bytes for malloc". That's gated by 
TPL_SYS_MALLOC_F.

>   
>   config DEBUG_UART_CHANNEL
>   	int "Mux channel to use for debug UART2/UART3"
> diff --git a/common/spl/Kconfig.tpl b/common/spl/Kconfig.tpl
> index a535b61ecd35..cdb9cb188c7c 100644
> --- a/common/spl/Kconfig.tpl
> +++ b/common/spl/Kconfig.tpl
> @@ -129,7 +129,7 @@ config TPL_MAX_SIZE
>   	default 0x2e000 if ROCKCHIP_RK3399
>   	default 0x8000 if ROCKCHIP_RK3288 || ROCKCHIP_RV1126
>   	default 0x7000 if ROCKCHIP_RK322X || ROCKCHIP_RK3328 || ROCKCHIP_RK3368
> -	default 0x2800 if ROCKCHIP_PX30
> +	default 0x2c00 if ROCKCHIP_PX30
>   	default 0x0
>   	help
>   	  The maximum size (in bytes) of the TPL stage.
> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
> index b39777fc0607..872fc21c039d 100644
> --- a/tools/rkcommon.c
> +++ b/tools/rkcommon.c
> @@ -137,7 +137,7 @@ struct spl_info {
>   };
>   
>   static struct spl_info spl_infos[] = {
> -	{ "px30", "RK33", 0x2800, false, RK_HEADER_V1 },
> +	{ "px30", "RK33", 0x2c00, false, RK_HEADER_V1 },

Downstream actually has 0x3000 there with the justification that SRAM is 
16KiB and BootROM has 4KiB reserved for the stack, c.f. 3bbe0d2f9129 
("tools: rkcommon: add rk3326 and correct spl size for px30"), why are 
we still 0x400 below?

Cheers,
Quentin
