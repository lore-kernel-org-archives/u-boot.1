Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8564606A31E
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 19:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gpSP+TCf;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jSfY2Blk
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6234160AC3;
	Thu, 26 Nov 2026 19:01:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vdWfbEEw1_ty; Thu, 26 Nov 2026 19:01:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7626460AA2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795719664;
	b=Wo1AAS3w/AEJe0gB+GSNmWjAE7P5JXaVValmjJVGUG2/LN/y07PXLlXJw5ZX6jyxHdwX
	 EzPIt2yhvBGFd6LrtY37wUKTpAcVv1zOx2XLYMxykfRdM7UVo6DcBinI0luif5HIu1LR3
	 SJAPrPiP9dmq/MJ3V7lzCJsYgUzUuQNv8GqccEtBGE8rRRtyzNVGBzP3XYBJFR7VtyWe+
	 s3rCwOYE6//0/6hy3qK2pE3+stlhHXydIy961HDKA604Hc6K/CBFA6ZwOCQyKlMAB960O
	 QsYxcdsoEOlGS6HvZZidLuKgohOGL41xJVyRzOxofSk1FvSqcyOtZuj7F9NwqGgHhoA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795719664;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Nm9DhTMbx4lmIgsHqSREg64MMoVLRVfZYgfbdqdXf3I=;
	b=jgoqArs1ykpu0xflhXOQz1a0uS41NEz8OyafE1KXiQ/mkFVi8eS5UV4wfzq/gLtrgkZS
	 W46WE9V2RXFCQRIAxSkgIRdKadqxmm7UysEONY4YjXcmuS6mauplIJXFrd1aAU1l4jXgv
	 RVypGL1o0NEPyi0m/94RvpxhTSL9brSFBQwqsPuAiphHAyXUh0KtRY1IOh/9e8CxRQIQe
	 gHo8aPdEjlWxx1f+v6UdwLEW5b89qiTfMQ0xzY7MZf9cjn0NYA469WJcuiASi/pIaP+Jb
	 62Uo5nrxtJv9bl3kixZK+DhK0ui68qQWAacTlTHYy6H2foGZ0Tb2fwgQX0vWe8qXmhw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795719664;
	bh=Nm9DhTMbx4lmIgsHqSREg64MMoVLRVfZYgfbdqdXf3I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gpSP+TCfzV0cmX3EAMqv2sHCkfZrW8htlCItDO7egXT4oFm5rPChDKc/3PIM59Q5e
	 Tkgy57LTSzDNsqVEkty3VIkOWDp20AaAVdsusS5jVx/Er6I2oKpazUIAOimEE5uqhg
	 dWGX7W1UANh1Erh1TB/oAsaY0XD3/+RoK42dBvBUhnQZiydUXTLTlnF0NyHYI031KR
	 sjln5Gc7ip+B3nX1V5T1G3vNV4tCqO3Svei4cQmTvLHssFiRWH/QHv1KL50HsSgRJX
	 Lc5E9zXqV4X0d2Kwzl3A+ugjqsSb9HNdqFXCjZ+PBqz7mwTU7A7KPZ+tH7QiyVoZyL
	 2g9F7mIyHa5NQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7626460AA2;
	Thu, 26 Nov 2026 19:01:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 14963260
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 16:35:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 06343811D4
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 16:35:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RA58E7YH7B08 for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 16:35:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 19B37811D3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com;
 envelope-from=richard.henderson@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=jSfY2Blk
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 19B37811D3
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 16:35:13 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3ae7626d14aso3574940a91.2
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 08:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795710913; x=1796315713;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Nm9DhTMbx4lmIgsHqSREg64MMoVLRVfZYgfbdqdXf3I=;
 b=jSfY2BlkSOd8nVxWUqSsGy3HhWmCMQXXDCmG5kn/LyXNZjUyrYUB/AIARP3DdYx8bF
 W6mXlhyXRkPZxI6EM3uOOndBwKN2WgWtn3HAUYPSJk4Ym/K+9//OqKZiCdqe74YtW/H4
 A93FAbmwxOblndZrglhbDneYS91TSe+mXJwiFyFJloHmdRRR9+TAhqae6SYtk99qys8q
 WLA3viWcuDnIioSVroSOHA7pEqNInHxxGIUzPjcZ7VtYuTzhjxSc1AMxlytCT6leUT/i
 hYgtCAPSzWSMPPOkOSIqs8n9ULTYfoYcRCdDBSGSW4Zhzfa0dYkGCnSlNg351Hz5TE8q
 2Sdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795710913; x=1796315713;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nm9DhTMbx4lmIgsHqSREg64MMoVLRVfZYgfbdqdXf3I=;
 b=deXrvvFN7/TP/nJ4gVwVxelHhSDxXL4tCUiEFJZysD0eQapVcQudlAhBWMttPHe1ou
 D+Xg8/pPQcwMuumPlbjVK1Htooe6AooR1yQtNQBT122C4lAxwSrVATPh3M6rTX3etZW7
 bK3JQbp2gGR6NC8/r3Vwo9Bghythp4aq4Jbbqdd6b+v6vdGKcuTsnL96J4wOqG7R5VtZ
 byhkdKi7r25lHfsH+7zG5qIVGS9jyUwNPjiOt3xXMpo02x8ioSlyOupLuplc0dG/PPPc
 rnFpfBhFB3u5aVkviOH5jamEp3KceKpTN00Re8sALFDJo+xz3cA60m5mu6yY0Zu07Ieb
 OKUw==
X-Forwarded-Encrypted: i=1;
 AL+hErEScO57dlNEQOXgrkfszRPh8/mp/7CFh/l4DufOesFQHFTbOhsN1Oa3dAhB9qStu0k3PkOYt9Q=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/Diri9z6uFmyAV0KvyqZVT1c7X9xrsmtnRbGwCHvRwQkAGZt+U
 02TB2x2xW5txjdbHhBTAoExHodb6+0YzA9XooFCVdcDm+t55FhSj5Qhjco6vh1kRk3Q=
X-Gm-Gg: AZFdTZf9TiGLVlz5jAewetAv615pdQ7v/1vJOVUqaetwKi2ViFNfUkq6ElMDbnaJclp
 UdbTNm0gRq4qRrq8sseHuNdbvvOQ9uPxjb5ahJ3UmMrbNWaTuw+dk0qrAjR8RoF3thTL0KaXDEP
 QmxA2Xfu9FbYU7K5baPtjQ7AuEf6YXLo2OWdGCzn/sfhM9kYh2ZPJ9cNKSe1RZJ3OmrHElMtsrM
 0x02GTVgGzgsSId+t6p0ONsH31c8XTjQyUIV617+eCL6Q4uKL78ncFKAMDvhUwRzKxWMuoP2cAl
 b3riPTVScIXjbUN7IcbclTjTvIQGhwfWiNYP7K45UvyVIxTxw7ZOlbdw1vxo62zLPm2wj2C5UW5
 Eb23/Yp+sAzQjrC19xGKoUsMxqcIDDSrMjptskbZYa2pZDTwRQsnCsPNanKWtq1Mf2eTQOFLAMh
 IzoJHgNka+WX2WJgL8T0MJKY/3PAKsxA5pyg8FjASyjN/2ZagysP0doGBTTZVyPzL1nIUynKQIt
 z1/rBleD4bT4Wbns/OfwBaqoGxBYnJG/P22LZO1gjIKU5zO9QrEgQi1qNQoqTCxIPCBUcuRJlCK
 6InsI2KWSSx+sVEu/5CRceP+QBcIY0yWvkef5e8g7fY=
X-Received: by 2002:a17:90b:2f8f:b0:3b3:b0f4:1bf7 with SMTP id
 98e67ed59e1d1-3b41c8d460emr21248670a91.23.1795710912695; 
 Thu, 26 Nov 2026 08:35:12 -0800 (PST)
Received: from [172.20.3.121] ([156.19.246.27])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b44b2156c2sm14803843a91.0.2026.11.26.08.35.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 08:35:12 -0800 (PST)
Message-ID: <d19f2102-4da4-4369-b4e4-f6be0fb92500@linaro.org>
Date: Thu, 26 Nov 2026 08:35:10 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: Add RELR relocs
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com
Cc: casey.connolly@linaro.org, u-boot@lists.u-boot-project.org
References: <20261125074122.1965495-1-ilias.apalodimas@linaro.org>
 <20261125074122.1965495-2-ilias.apalodimas@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261125074122.1965495-2-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 26 Nov 2026 19:01:01 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/24/26 23:41, Ilias Apalodimas wrote:
>   ifneq ($(CONFIG_XPL_BUILD),y)
> -# Check that only R_ARM_RELATIVE relocations are generated.
> +# Check that only R_ARM_RELATIVE relocations are generated
> +# unless we compile with RELR
> +ifneq ($(CONFIG_RELR),y)
>   INPUTS-y += checkarmreloc
> +endif

No, you should still run this.  If there are non-relative relocs they 
won't be packed.  You still want the build to fail if something goes wrong.

Alternately, a different check that ensures *only* relr exists.

> +++ b/arch/arm/cpu/armv8/start.S
> @@ -89,6 +89,7 @@ pie_fixup:
>   	add     x2, x2, #:lo12:__rel_dyn_start
>   	adrp    x3, __rel_dyn_end       /* x3 <- Runtime &__rel_dyn_end */
>   	add     x3, x3, #:lo12:__rel_dyn_end
> +	b	pie_skip_reloc		/* .rela.dyn may be empty */
>   pie_fix_loop:
>   	ldp	x0, x1, [x2], #16	/* (x0, x1) <- (Link location, fixup) */
>   	ldr	x4, [x2], #8		/* x4 <- addend */
> @@ -101,6 +102,43 @@ pie_fix_loop:
>   pie_skip_reloc:
>   	cmp	x2, x3
>   	b.lo	pie_fix_loop
> +
> +#ifdef CONFIG_RELR

With RELR, the above pie_fix_loop *will* be empty, not may be.
So why are you compiling it in at all?

> +	/*
> +	 * Fix .relr.dyn relocations. Entries hold link-time addresses
> +	 * while x9 holds the run-vs-link offset and the addend is the value
> +	 * already stored in the place.
> +	 */
> +	adrp	x2, __relr_dyn_start	/* x2 <- Runtime &__relr_dyn_start */
> +	add	x2, x2, #:lo12:__relr_dyn_start
> +	adrp	x3, __relr_dyn_end	/* x3 <- Runtime &__relr_dyn_end */
> +	add	x3, x3, #:lo12:__relr_dyn_end
> +	b	pie_relr_next
> +pie_relr_loop:
> +	ldr	x4, [x2], #8		/* x4 <- RELR entry */
> +	tbnz	x4, #0, pie_relr_bitmap
> +	add	x5, x4, x9		/* x5 <- Runtime address of the word */
> +	ldr	x6, [x5]
> +	add	x6, x6, x9
> +	str	x6, [x5], #8		/* x5 <- Start of the next bitmap */
> +	b	pie_relr_next
> +pie_relr_bitmap:
> +	mov	x7, x5
> +	lsr	x4, x4, #1
> +pie_relr_bit:
> +	tbz	x4, #0, pie_relr_skip_bit
> +	ldr	x6, [x7]
> +	add	x6, x6, x9
> +	str	x6, [x7]
> +pie_relr_skip_bit:
> +	add	x7, x7, #8
> +	lsr	x4, x4, #1
> +	cbnz	x4, pie_relr_bit
> +	add	x5, x5, #(63 * 8)	/* Each bitmap covers 63 words */
> +pie_relr_next:
> +	cmp	x2, x3
> +	b.lo	pie_relr_loop
> +#endif
>   pie_fixup_done:
>   #endif
>   
> diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
> index 231ab28b50cd..73f0230629cc 100644
> --- a/arch/arm/cpu/armv8/u-boot.lds
> +++ b/arch/arm/cpu/armv8/u-boot.lds
> @@ -149,6 +149,15 @@ SECTIONS
>   		. = ALIGN(8);
>   	}
>   
> +#ifdef CONFIG_RELR
> +	.relr.dyn ALIGN (8) : {
> +		__relr_dyn_start = .;
> +		*(.relr.dyn)
> +		__relr_dyn_end = .;
> +		. = ALIGN(8);
> +	}
> +#endif
> +
>   	_end = .;
>   
>   	/*
> diff --git a/arch/arm/lib/relocate_64.c b/arch/arm/lib/relocate_64.c
> index 6f7a50f2264e..0572fe2d29f8 100644
> --- a/arch/arm/lib/relocate_64.c
> +++ b/arch/arm/lib/relocate_64.c
> @@ -43,12 +43,19 @@ void notrace relocate_code(ulong dest)
>   	u64 size = (u64)__image_copy_end - src;
>   	const Elf64_Rela *rela = (const Elf64_Rela *)__rel_dyn_start;
>   	const Elf64_Rela *rela_end = (const Elf64_Rela *)__rel_dyn_end;
> +#if IS_ENABLED(CONFIG_RELR)
> +	const u64 *relr = (const u64 *)__relr_dyn_start;
> +	const u64 *relr_end = (const u64 *)__relr_dyn_end;
> +	u64 run_to_copy;
> +	u64 *place = NULL;
> +#endif
>   	u64 sctlr;
>   	u64 offset;
>   
>   	if (src == dest)
>   		return;
>   	memcpy((void *)dest, (void *)src, size);
> +
>   	/*
>   	 * r_offset and r_addend are link-time values, so the offset to apply
>   	 * is link-to-copy
> @@ -65,6 +72,27 @@ void notrace relocate_code(ulong dest)
>   		*(u64 *)(rela->r_offset + offset) = rela->r_addend + offset;
>   	}
>   
> +#if IS_ENABLED(CONFIG_RELR)
> +	/*
> +	 * RELR entries hold link-time addresses, so the location is found
> +	 * with the link-to-copy offset. The addend is the value already
> +	 * stored in the word, which pie_fixup has shifted to the run
> +	 * address, so it is adjusted by the run-to-copy offset.
> +	 */
> +	run_to_copy = dest - src;
> +	for (; relr < relr_end; relr++) {
> +		if ((*relr & 1) == 0) {
> +			place = (u64 *)(*relr + offset);
> +			*place++ += run_to_copy;
> +		} else {
> +			for (u64 *p = place, r = *relr >> 1; r; p++, r >>= 1)
> +				if (r & 1)
> +					*p += run_to_copy;
> +			place += 63;
> +		}
> +	}
> +#endif

Similarly.


r~
