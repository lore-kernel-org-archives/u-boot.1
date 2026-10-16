Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B6DFCCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 09:06:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA7E1814C3;
	Fri, 16 Oct 2026 09:06:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G8YVutZ4kuOQ; Fri, 16 Oct 2026 09:06:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B451281489
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792141609;
	b=EmUP50XQL/43WBq5Hza+Ccu2DKcQNWPKIuc48NUr7gLVDmTf+PYWMwiihfw02MYRpxJl
	 dw1Fo2bJn311YNTsLe2DDNaDSH6AJOGkcCKnYuafsCUx+Oz3jrWY5NQ7JnVjCFxPHtiLL
	 iTZl+6vryjLzLtylJ/QQaJ2fSBT7f/DfIqO7ho5KlO8q17Ct4p0A9tlE4hu5NOOg2Liy+
	 QNlT3DGHMg71cS/1A3sthG6NQk6ZjWdiA5NkxyPv+vR2h6ugHYBbCTiCINgHjv3ysrcEz
	 bFe9vQxU/K6auCMOoZ6yg3nlLTyAF0WlMLDpmT/9+LDKau03G45P4FNMttmZIIMJmPg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792141609;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gviwVROZdnqAYPSG6P5uVPh2EQm3hSQ9gwWNRMA9QbA=;
	b=rk3HmLdiAB7cY15cROlZyb9Hl/u9vVrumdUhnkt8ahpCJwlp363LPw3BNPBEjU66OXSE
	 TnJltWm6b/s6w4OfJpdSmNyVYmDMcg9x6V9wOcVybTajKSY1FxQM/bnwF71kfaGx0B6sJ
	 rEhCYviGB2vCtVXl0q16r9jntdTqiD/eNIT0mGAxHWSAN9aOOPjGJJCsdKWK/YCRQ6xcd
	 qTNdDNihpg2XmPMR32uId+XBhH08BSkTKjb76kb6dJJsJ6gTjLvYNe+IqOQQleKmonuP9
	 JXTxx617++rB1n7OuO7aAEpvgA3pFDyY76ChxzC8Qqrx45GBIuhi8tkJEHQX2Z8aBqQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792141609;
	bh=gviwVROZdnqAYPSG6P5uVPh2EQm3hSQ9gwWNRMA9QbA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=biWXaV/qsDrrzPwj+R3g9HyV5M6OvDoBfG2AQcg0SDrlZmG09J0vgwgb0xbBT7ZoY
	 o7bKIlIgOgtouLEbx5xv/cxFlTpiF9MptVB+Sd/GUxWnNgN1GXg6IMKxEx43P0tjZR
	 X2Fmc2Oa8cL39vN9VtIBgTnMc1TGPPK6mKRI1NcVYRtIBJbz5g1UiGRS5UL9B4m8nq
	 4qBSjHuhJsCAbkdEQtb4+dnKBF+rD0uGHDKWf0IA3eIk5Xznf/FEs1rLQXJQsmnqMO
	 dp/9NvL8qRsARix57TmESHH4g4/o/q1x31zD5NW0F0nR0qTLnNXMkXBCnq5WFSv8pm
	 a8KSOgcEBFTgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B451281489;
	Fri, 16 Oct 2026 09:06:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CED53362
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:06:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C051340489
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:06:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tNt7W-doy1RC for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 09:06:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3815F40100
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:5550::190c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792141606;
 b=lVv7o7LtGiJHsU5Q7LkICoRZuKGhZoCa5qM2YVJtNtfJYnurJNxuSNuYH/GhmXqmCiBv
 pV15tX8ZPtpcQ7XT9ej7xcox0Oj/C3wg6ihBXIgLmLrtl+iK2efIzem8kZ+l9pUHnTflj
 alQewkd0Z2IpZw7dI4H2c7y/s57J+I7khJ9Fv3RkBC4k827lk7lmZ5/rZ/zbvRxSFId0R
 By3LuSwjiljZHEcB1HZCh7O4cLDrjh5v3cJeK2u++FidXUcWOsz6ms/91nZBdGQrS7yFo
 okwLNC6G/wKZJEGA65Fc34HO3+lp/kU3uEqRjT7Sb8CdIpzjzOpx6wmSRx0d0jKdcww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792141606;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=gviwVROZdnqAYPSG6P5uVPh2EQm3hSQ9gwWNRMA9QbA=;
 b=AtC4K59orgERjpR0hxjyUxjaF7nSTRwu8hVFbw2cvKl64jWE+w25dkHOSMPK94CQ1IS5
 RPaqH2U1uf9zwbvYDfuUiTMLZwGTGUuI3Gtmsvk5CYPL8iIlebwqEFyef86gYYaiZ5hLe
 PZ84UbUlzHnLIYO4wykVkLrPNEjNU9mng1r6Hz+oK/L9TpRVSMSQIAMoboDFBat+6THyB
 C8hsuLbopt/vlLeFIG1dOk9jxDEhd0IOd3W1b1a3pP/UeiJsMoX56UpjG8aY0bdYyJOg1
 zWPAqsM/lBYc16wMrkbvHmnV64L+nVdHg8u/AsGa+wQgyi9XP5I/MJ/kwciU+4UHrCA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=bLqxuCSN; 
 arc=none smtp.remote-ip="2001:1600:19:5550::190c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:5550::190c; helo=smtp-190c.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=bLqxuCSN
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch
 [IPv6:2001:1600:19:5550::190c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3815F40100
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:06:44 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j5fFY2p3vzPwJ;
 Fri, 16 Oct 2026 11:06:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1792141601;
 bh=gviwVROZdnqAYPSG6P5uVPh2EQm3hSQ9gwWNRMA9QbA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=bLqxuCSNvYNpY7V4Sf0F9gB2sdUxYdu89KXdjUnl421BKBkEmTLMdgXf998RYqTrv
 a9MJhwlo8eJRAKg8ZELojErNacgyTqnI4Kye9ue7MYkWyYp8/VhZ4BGQ2cMBBFbt14
 mcAssWJGyxWdG8MyYOZAGwujsOtoOPJiEywbDPJVKMKdkSYZvWj9ecgdu3bdScheWz
 2wQH8QRI8hPjvzF57tdohR0D/YwvmkwQXxzzyNqWoZNcuzOvtIzbKYz6Rl9OhnFw8+
 6+13neJpyQHKo4hdr5Y5Wkj+oY4hCNY5peSEUJ2g+x/1GTJsX6069WqyoK+/YO7abY
 0NcZH3Xe+yEsQ==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4j5fFW4KdYzcsr; Fri, 16 Oct 2026 11:06:39 +0200 (CEST)
Message-ID: <9e0762c4-57b1-4e61-adb5-32031da77c93@0leil.net>
Date: Fri, 16 Oct 2026 11:06:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] lib: Let the decompressors use unaligned loads if
 platform allows
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org,
 Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Casey Connolly
 <casey.connolly@linaro.org>, Vincent Jardin <vjardin@free.fr>,
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>,
 Kever Yang <kever.yang@rock-chips.com>
References: <20261002-unaligned-decomp-v2-0-675466ced78a@flipper.net>
 <20261002-unaligned-decomp-v2-1-675466ced78a@flipper.net>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20261002-unaligned-decomp-v2-1-675466ced78a@flipper.net>
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

Hi Alexey,

On 10/2/26 12:04 PM, Alexey Charkov wrote:
> ARM passes -mstrict-align (-mno-unaligned-access on ARMv7) to everything,
> because when the MMU is off any unaligned access there faults. The
> compiler then has to assemble every wide unaligned load out of single
> bytes: one ldr becomes eight ldrb and seven orr/lsl.
> 
> This is especially painful for decompressors which refill their buffer
> in 64-bit words. On a Rockchip RK3576 SPL, zstd unpacks a 30MiB Falcon
> mode Linux kernel in 1947ms built this way and 596ms without the flag,
> and the SPL gets 2.3KiB smaller by cutting down on the byte-wise loads and
> ORs. gzip, whose inflate walks its input a byte at a time anyway, gains
> 6%.
> 
> Add ASSUME_UNALIGNED_ACCESS_OK for a platform to state that the MMU is on
> by the time it unpacks an image, and let the decompression libraries drop
> the flag when it is set. The arch exports the flag it added rather than
> lib/ naming it, so this stays correct for anything else which adds one.
> 
> No functional change anywhere until the symbol is selected.
> 



> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   arch/Kconfig                 | 35 +++++++++++++++++++++++++++++++++++
>   arch/arm/cpu/armv7/config.mk |  3 +++
>   arch/arm/cpu/armv8/config.mk |  3 +++
>   lib/Makefile                 |  3 +++
>   lib/lzma/Makefile            |  8 ++++++++
>   lib/lzo/Makefile             |  8 ++++++++
>   lib/zlib/Makefile            |  8 ++++++++
>   lib/zstd/Makefile            |  8 ++++++++
>   8 files changed, 76 insertions(+)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 8d63afeb138e..606b9d79ecd8 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -27,6 +27,41 @@ config SUPPORT_LITTLE_ENDIAN
>   	bool
>   	default y if !SUPPORT_BIG_ENDIAN
>   
> +config ASSUME_UNALIGNED_ACCESS_OK

I only see changes in ARM and ARM64 config.mk, should this (and SPL) 
symbol depends on ARM/ARM64 maybe? I see in the second patch you're 
adding another dependency on !SPL_SYS_DCACHE_OFF, any reason for it not 
to be a dependency in the main symbol in this file here?

This is very compressor/decompressor-specific, should we rename the 
symbol so it's clear only those would/should be impacted by this symbol 
(hoping that its usage doesn't get extended in the future).

> +	bool
> +	help
> +	  Assume that an unaligned access cannot fault by the time U-Boot
> +	  proper unpacks an image, and build the decompression libraries
> +	  without the architecture's strict-alignment flag on that basis.
> +
> +	  Architectures whose unaligned accesses fault while the MMU is off
> +	  pass such a flag to everything, which makes the compiler assemble
> +	  each wide unaligned load out of single bytes. That is both slower
> +	  and larger, and a decompressor refilling its bit buffer in machine
> +	  words can spend up to four times as long for it.
> +
> +	  The assumption holds only once the MMU is on, which on most
> +	  platforms has not happened by the time an image is unpacked, and
> +	  nothing checks it. Select it from code which enables the MMU

Crazy idea, but should we add a flag that specifies whether the MMU (and 
dcache?) has been set up, and then read that flag in places where we 
have this assumption? Then we could at least clearly hard fail on this 
flag not being set and tell the user something went wrong before the 
system does a HW fault by itself?

Cheers,
Quentin
