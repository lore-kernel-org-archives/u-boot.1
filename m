Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31888606A33D
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 15:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zvcClT4/;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=GlHPbYOl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 73F27811F4;
	Wed, 11 Nov 2026 15:31:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pvK8pvh0HOvz; Wed, 11 Nov 2026 15:31:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4E5C3811DE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794411078;
	b=BplSQGp1yAAHtXKZvvMsUpiHzyWgCpz5gaShZ9HEPGV1n2zsr+ktjAg33sF0WEhSBqnx
	 jSwpklLbjPf0HdNOBqL2AYn7hTV2QAiJQGWoezLs+wT2SFjcZMsn01yUJdD6h7pjo8Oyv
	 yl11Gv7ODDDH0gaeaKiljr4W3e111803ilQvXIOlip0mTouYBNw3O+5aGxofJmUMjFjDj
	 zcs9uqCWi/nAxvMurO9ENPlVTO5Bg9V0LgWXct7DRcd+Qa7OI3A2IFgkepLVWlEhNloH1
	 RzeVRr1zuNy6+khASvwTx/TUD471EqdTKXk/U30J/EBwC7Ekvpdx4XoUlJ4QWTHG0Ag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794411078;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aLy0VUPXigdYKFH9M+1A0FSUVi0qAgvX44sxUYPfjkg=;
	b=dZsbXKMKCG3rgjMyd/vxUejV/SEhDjEEYfA0G0G2DOhIuXnOnyjWn6QOpKMHPmcQkMT4
	 SZN+5HJ7f3MadrSJOfKRL3/mWfYrf0bPRMMNEXQyzjMV0xKgaGAocrpWbnECfXDH6tGbo
	 brfU2voDv/WQhjnjHs4C4wE+c43FiWrrZ1UKiH1onnBtLEhAhkegyBH3SF9+7ys52zlvP
	 9iLkCqmFgoE6cnDR3QroExMAyCYTgISaFhkPfpQqlpBGjJpeG7a2qgjKHKrIpnAyUF8BH
	 MGmiPjFUBbUgDP/0AOB9vuit4iRJOBnUnR96ohXRE5fjMX2KUpcFp+9uKBM9C2FRovA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794411078;
	bh=aLy0VUPXigdYKFH9M+1A0FSUVi0qAgvX44sxUYPfjkg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zvcClT4/sGLhAe48O7JUMtrZ52H5PHj1sGZlMIyfLw1USNM64fRw+APyWHfgKcFPp
	 k4zP5KL/vzveSHay1DhzJMX/KouMEjtHO9JTLkVEWfuMFa0rAQR2yWHbcFX2lrYt3M
	 F8Gen96fFg8qxl/dK9oii+/c0Oxtxwhg3kC4hDL6yK+Y19rqQEGjLJ2h1pGMeCjWH1
	 UttnhRaE9IFaUMbN1l4BPAZlImn6Ddfl7pZYGtaUoggrMgxrnkUKB3AHhR7X4WXG79
	 N8Dn4sz3Ypf0sHSaaflmV6BPjnQ7FVnVFC7clD/WORiijjMTlMhoLyfK6K8Dozrcsu
	 R9CpFIiiwSAYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E5C3811DE;
	Wed, 11 Nov 2026 15:31:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E24FD731
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 15:31:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C7CB540840
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 15:31:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id de6HMqiNRtC9 for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 15:31:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CB49640801
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:38e0::8faa"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:38e0::8faa; helo=smtp-8faa.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=GlHPbYOl
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch
 [IPv6:2001:1600:19:38e0::8faa])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CB49640801
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 15:31:13 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jPnYB3QLQzF2m;
 Wed, 11 Nov 2026 16:31:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794411070;
 bh=aLy0VUPXigdYKFH9M+1A0FSUVi0qAgvX44sxUYPfjkg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=GlHPbYOlRWbyZN5rD44d66UlOp7AENgvGAq6KNVaCm7R6LgLLwYXsYrcrBpu3GFlu
 tj6ZXLz3YNk/S0j1geyk2HobEfpupHv0FoF6LPP/D1oNDCvPmzv9Zz4p2c40ulz8B1
 yRA6QVzmT3p0rsfZaE64oDygfrmf1okqMPaw9yGA0dBPCdXf7kz07kDhmhrQJIriS/
 SS6dQZi5N9mA9C/SEU/KJEndprKajYXXWF8WWHHZKnbuSkEUalaR6uMbmtZDK1fXtz
 2bBtXZ3x5xqN0tFwg7GKRnV3xqaBDcDrzyDqaIVMR17Sye7HQzz7Xy4EZ9quaxWOzQ
 envp94bDJL1hg==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jPnY91m1lzgh0; Wed, 11 Nov 2026 16:31:09 +0100 (CET)
Message-ID: <1fba6d0c-acac-4495-bdf4-58765efedce0@0leil.net>
Date: Wed, 11 Nov 2026 16:31:08 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] ram: rockchip: improve sdram type configs selection
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
References: <20261025-ddr-multi-v2-0-b82ff9c860ba@gmail.com>
 <20261025-ddr-multi-v2-1-b82ff9c860ba@gmail.com>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20261025-ddr-multi-v2-1-b82ff9c860ba@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Massimo,

On 10/25/26 8:30 PM, Massimo Pegorer wrote:
> Not all the SDRAM types config options named in the Kconfig are
> supported by each of the Rockchip SoCs: improve clarity adding SoC
> dependencies to the options.
> 
> Add a new RAM_ROCKCHIP_DDR3 option and remove PX30 and RV1126 sdram
> drivers fallback behaviour when no SDRAM type option is selected,
> raising a compile time error in this case, instead. The new option
> has a default true value if no other SDRAM option is true to avoid
> impacts on defconfigs.
> 
> Moreover, these drivers support only one SDRAM type at a time: when
> more options are selected, avoid debatable preemption of one over the
> others, and raise a compile time error instead.
> 
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> ---
>   drivers/ram/rockchip/Kconfig        | 24 +++++++++++------
>   drivers/ram/rockchip/sdram_px30.c   | 17 +++++++++---
>   drivers/ram/rockchip/sdram_rv1126.c | 54 +++++++++++++++++++++----------------
>   3 files changed, 60 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
> index d707d09c1c8..f51ae6a4542 100644
> --- a/drivers/ram/rockchip/Kconfig
> +++ b/drivers/ram/rockchip/Kconfig
> @@ -24,28 +24,36 @@ config RAM_ROCKCHIP_DEBUG
>   	  This is an option for developers to understand the ram drivers
>   	  initialization, configurations and etc.
>   
> +config RAM_ROCKCHIP_DDR3
> +	bool "DDR3 support for Rockchip SoCs"
> +	depends on ROCKCHIP_PX30 || ROCKCHIP_RV1126
> +	default y if !RAM_ROCKCHIP_DDR4 && !RAM_ROCKCHIP_LPDDR2 && \
> +		!RAM_ROCKCHIP_LPDDR3 && !RAM_ROCKCHIP_LPDDR4
> +	help
> +	  Enable DDR3 sdram support on Rockchip SoCs.
> +

issue: too much done in one commit

Please split this into multiple commits. I could identify:
- add SoC dependency for existing DRAM Kconfig symbols (with the change 
to the helptext to make it generic)
- add new DDR3 symbol and gate existing code with it. That is, rv1126 
and px30 should have their #else for their DDR3 timings gated by this 
symbol. A new #else can call #error so the build fails in case of 
incorrect configuration, like you did here,
- enforce only one selectable DRAM init for PX30 and RV1126,

>   config RAM_ROCKCHIP_DDR4
>   	bool "DDR4 support for Rockchip SoCs"
> +	depends on ROCKCHIP_PX30 || ROCKCHIP_RV1126
>   	help
> -	  This enables DDR4 sdram support instead of the default DDR3 support
> -	  on Rockchip SoCs.
> +	  Enable DDR4 sdram support on Rockchip SoCs.
>   
>   config RAM_ROCKCHIP_LPDDR2
>   	bool "LPDDR2 support for Rockchip SoCs"
> +	depends on ROCKCHIP_PX30
>   	help
> -	  This enables LPDDR2 sdram support instead of the default DDR3 support
> -	  on Rockchip SoCs.
> +	  Enable LPDDR2 sdram support on Rockchip SoCs.
>   
>   config RAM_ROCKCHIP_LPDDR3
>   	bool "LPDDR3 support for Rockchip SoCs"
> +	depends on ROCKCHIP_PX30
>   	help
> -	  This enables LPDDR3 sdram support instead of the default DDR3 support
> -	  on Rockchip SoCs.
> +	  Enable LPDDR3 sdram support on Rockchip SoCs.
>   
>   config RAM_ROCKCHIP_LPDDR4
> +	depends on ROCKCHIP_RK3399 || ROCKCHIP_RV1126
>   	bool "LPDDR4 support for Rockchip SoCs"
>   	help
> -	  This enables LPDDR4 sdram code support for the platforms based
> -	  on Rockchip SoCs.
> +	  Enable LPDDR4 sdram support on Rockchip SoCs.
>   

Because I checked, and for future reference:

PX30 supports LPDDR2/LPDDR3/DDR3/DDR4. Only one selectable at a time 
currently.
RK3368 only supports DDR3.
RK3066 supports DDR3/LPDDR3 but only DDR3 is used (MK808 device, 
configuration via Device Tree and OF_PLATDATA)
RK3188 supports DDR3/LPDDR3 but only DDR3 is used (Radxa Rock, 
configuration via Device Tree and OF_PLATDATA)
RK322x supports DDR3/LPDDR2/LPDDR3 but only DDR3 is used (RK3229 EVB, 
configuration via Device Tree and OF_PLATDATA)
RK3288 supports DDR3/LPDDR3, both used via e.g. Rock Pi N8 (LDDR3) and 
Rock2 Square (DDR3), configuration via device tree and OF_PLATDATA)
RK3328 supports DDR3/LPDDR3/DDR4, all used, via e.g. Rock Pi E (DDR3), 
Rock64 (LPDDR3) and Orange Pi R1S Plus (DDR4).
RK3399 supports DDR3/LPDDR3/LDDR4, all used, via e.g. Puma (DDR3), Gru 
Bob (LPDDR3), PinePhone Pro (LPDDR4). Either DDR3/LPDDR3 or LPDDR4, not 
both. We should check for this in the driver.
RV1126 supports DDR3/DDR4/LPDDR3/LPDDR4, but no timings for LPDDR3. Only 
one selectable at a time currently.

The common theme though is that they are all configured via Device Tree 
(via OF_PLATDATA) where the dramtype is hardcoded, and this here would 
be the first to try to do autodetection of the DRAM and init properly.

>   endif # RAM_ROCKCHIP
> diff --git a/drivers/ram/rockchip/sdram_px30.c b/drivers/ram/rockchip/sdram_px30.c
> index 37e62120504..c7ff924b2c5 100644
> --- a/drivers/ram/rockchip/sdram_px30.c
> +++ b/drivers/ram/rockchip/sdram_px30.c
> @@ -123,15 +123,24 @@ u32 addrmap[][8] = {
>   
>   struct dram_info dram_info;
>   
> +#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR3) + \
> +	IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4) + \
> +	IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2) + \
> +	IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3) > 1
> +#error "This driver only supports one DRAM configuration at a time"
> +#endif
> +
>   struct px30_sdram_params sdram_configs[] = {
> -#if defined(CONFIG_RAM_ROCKCHIP_DDR4)
> +#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR3)
> +#include	"sdram-px30-ddr3-detect-333.inc"
> +#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4)
>   #include	"sdram-px30-ddr4-detect-333.inc"
> -#elif defined(CONFIG_RAM_ROCKCHIP_LPDDR2)
> +#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2)
>   #include	"sdram-px30-lpddr2-detect-333.inc"
> -#elif defined(CONFIG_RAM_ROCKCHIP_LPDDR3)
> +#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3)

question: what's the benefit to switch defined() to IS_ENABLED?

It almost made me miss the fact this reorders the DRAM timings array.

I think the reordering should be made in a separate commit, possibly the 
one where it's possible to select more than one

Cheers,
Quentin
