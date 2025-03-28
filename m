Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71351C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 16:29:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B511D81951;
	Fri, 28 Mar 2025 17:29:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ou35mXrk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6E2081E13; Fri, 28 Mar 2025 17:29:12 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 767638144A
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 17:29:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=72be=WQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1743179348;
 bh=oloJ4qauf6Ks8RrMc1uCCDAks5px9OVwXRoaQuIh6hg=;
 b=ou35mXrkH5UMmao4s2A9e7KtlzqKQl16MvqR5FHV9HOk94/AO4fTWvyB4x01BOOVxALAJFb10
 FBj6lbPKVCkUdk3q1j2WeAHnRYX4acgbLZove1nW7yzJGGtuN4HOQMgl75sIsDW2L1ZQBkN4PQk
 Axa0wPZbgNtZhVw6twk7ltw2HRqNggMb2JtDv41lHrF1qeacVLdsSy1f2/vhvp8KzUoShONHoDl
 ushTtxNJMtzhmg0/7wZfUEenzHUXe9H5GlEAqORlu+fjzNk7Bs2DyJrxrWcFR9SqWa0uWZ9utk3
 bUg5fom6RgZSXjhqavpVtQg4LbNBcl0ZlVitOr+pPSCg==
X-Forward-Email-ID: 67e6ce5337e81528de2ba574
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <ae3b68a5-95b7-4d45-a86f-ecad460b104a@kwiboo.se>
Date: Fri, 28 Mar 2025 17:29:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/31] rockchip: Add symbols for spl_reloc
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tom Rini <trini@konsulko.com>, huang lin <hl@rock-chips.com>
References: <20250328153522.3555472-1-sjg@chromium.org>
 <20250328153522.3555472-21-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250328153522.3555472-21-sjg@chromium.org>
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

Hi Simon,

On 2025-03-28 16:35, Simon Glass wrote:
> Add various symbols so that this feature works as intended. This allows
> xPL to copy the relocating-jump code up to the top of memory, then use
> it to decompress and start the next phase.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  arch/arm/mach-rockchip/u-boot-tpl-v8.lds | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> index 958a1b70aef..842bd4eb07f 100644
> --- a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> +++ b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> @@ -25,10 +25,21 @@ SECTIONS
>  	__image_copy_start = ADDR(.text);
>  	.text : {
>  		. = ALIGN(8);
> +		__image_copy_start = .;

__image_copy_start is defined a few lines above,
why is this duplication needed?

>  		CPUDIR/start.o (.text*)
> +
> +		/* put relocation code all together */
> +		//. = . + 0xc0;
> +		_rcode_start = .;
> +		*(.text.rcode)
> +		*(.text.rdata)
> +		_rcode_end = .;
> +
>  		*(.text*)
>  	}
>  
> +	_rcode_size = _rcode_end - _rcode_start;
> +
>  	.rodata : {
>  		. = ALIGN(8);
>  		*(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*)))
> @@ -48,6 +59,7 @@ SECTIONS
>  	__image_copy_end = .;
>  	_end = .;
>  	_image_binary_end = .;
> +	__image_copy_end = .;

__image_copy_end is defined a few lines above,
why is this duplication needed?

Regards,
Jonas

>  
>  	.bss ALIGN(8) : {
>  		__bss_start = .;
> @@ -55,6 +67,7 @@ SECTIONS
>  		. = ALIGN(8);
>  		__bss_end = .;
>  	}
> +	__bss_size = __bss_end - __bss_start;
>  
>  	/DISCARD/ : { *(.dynsym) }
>  	/DISCARD/ : { *(.dynstr*) }

