Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A71C54F30
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 19:29:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9345882B34;
	Sun, 25 May 2025 21:29:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="TnQs/MhP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EE7C82B37; Sun, 25 May 2025 21:29:46 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABCAF82B27
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 21:29:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=671e=YK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1748201382;
 bh=hpQMJ4LmEQC2q6g9qEdG489N+DRMdZg8J1yAtSzP31w=;
 b=TnQs/MhPban+t6fGxCm+8Z7Yzhjc1nm75Tj7KNYQ8MU0EW6NLdjNBR73w/++I5EeFXVLVjovK
 +tBZs6PS/MKlhZ3qFTHIB/4C7wcrtpdS9QIK3NSls7uLaDB7PP6L8OQXm4p8/GxY+AKsBMFc/wu
 6Wo2B7zKEf2AMCRoObodMlns99WLIKzs3K2oblLVVM1wSAxGSJR9rCTXv9kHQHNjOW71DWuT8l+
 VyhmSeqEGPY31r90ycUoNbMaC10lKCfpuAqjGKKtme2lL1D91ZEUPs42ZwQ1QWGmGWrkGHal8oe
 OKZpfNPfIOqHgVtyEJ8OPBOREWlR+s4JIPs9U11JfJOA==
X-Forward-Email-ID: 68336fa2a0e3f2dd0ce2394a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <0ca1b3c9-6245-4001-894e-066db00789a4@kwiboo.se>
Date: Sun, 25 May 2025 21:29:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/25] rockchip: Add symbols for spl_reloc
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
References: <20250525104801.1440260-1-sjg@chromium.org>
 <20250525104801.1440260-15-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250525104801.1440260-15-sjg@chromium.org>
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

On 2025-05-25 12:47, Simon Glass wrote:
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

As mentioned in a prior version of this patch, this is already declared
a few lines above.

>  		CPUDIR/start.o (.text*)
> +
> +		/* put relocation code all together */
> +		//. = . + 0xc0;

What is the purpose of this?

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

Same as before, this is already defined a few lines above.

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

