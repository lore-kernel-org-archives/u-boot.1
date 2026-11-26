Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E790606A31E
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 19:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=b9DD9oed;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eVDOncmz
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 66E3E40A01;
	Thu, 26 Nov 2026 19:01:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZICsP6q3IDar; Thu, 26 Nov 2026 19:01:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AACEA409EB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795719662;
	b=nL2PPWc1cSntbA6P72uyEgGpr7oYmAmxxaWetWjEBzhjoldlzxAz2w1k4uk3EwLvQd4J
	 z8OntkM/zeNqWB2zli2QRws+dc92+IfqY14ZC5OFKAXX2EDQhkOJL+J8DNphJZQwfpDn/
	 cVOyTQwh38scqUZrz8JWK3XHbxCkvydlYpT7PWwfAbEiC+QWHAC+2OIt+GoLGUEnyfggL
	 eKnqN58WYZPBpxB1Jm8mjixj2f9bu0tG77mi7OAQ5s8qhNcPxGmSsAJOzQaRLgrDDMEJ7
	 A0P6AOxq755/yHljIVSuTLKPoovXZ57DExZ9lSn8CiBUGxQNRqxSLEsM9M/cFtihnyg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795719662;
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
	bh=LlTtVHWH2V/CMOEaX8atg0CvgdCbAV4pwHRMV9WTQdA=;
	b=AHA+5tr5w1t28o/HgL4MN3nodtB5WFdLO2T+5qFg7SWiixwT+d5jk3/P9c1mLf4MQ+55
	 vJt5792MgsDK3L28mS/aFLPkJvCtucvycM2Wb1/+wcVeVrX58sugXyPyuvzPHLpI+GB4e
	 EpHl1U9PYYOUQmp7GZlXt9neC5mHnVd2nNsylscBkm3KbjfWBIraET+AVumPEPUIFU5kW
	 WaysAwuJk/16q0BCRj2kv/Qc1hD9v9eZU5FTV+58uQguzbbcFqkPmXeUIBH/YlKbCLiK7
	 xl2hxEEg1WZTDue0VAlhOGXaMq7pBCRjs+0k6r41JY4x+cilOuTB1j+sDYAxZa6XeQw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795719662;
	bh=LlTtVHWH2V/CMOEaX8atg0CvgdCbAV4pwHRMV9WTQdA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b9DD9oedlivpS/RYXKutkSVkxOYeC5A0EmRoKkFG5d9xn1PS0PZQKMljFoYEOGRu7
	 LVGNP5D/Fmi7wDlM8y1Gmahm2hulJEwAtMY5BDqEo/J6zrx+SJBxZyyxRW6gwg3Hyv
	 PJNYTIgxy8zqduc8HhC9RTCM2KpkqmpzunjLZp8afTJoUmy/DJ4nSTZV/6It/Hy1BN
	 HsY8cA9wA2kehWXv3bXVJEgekv37V9+vOPGCAex9+DYjBOCHKwEMK5pwhSgRJZTMR5
	 t8HIAoiLoxzUS4C1mBDadO+1Z8yg+9BrDkypauMcRxTxSebXRWlVCGyz1NksxmjpCE
	 Whm73e1+VFvBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AACEA409EB;
	Thu, 26 Nov 2026 19:01:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CE56260
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 16:12:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8F1BD4052A
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 16:12:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ged8K_CavsO5 for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 16:12:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B310D40518
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com;
 envelope-from=richard.henderson@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=eVDOncmz
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B310D40518
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 16:12:00 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2f02f04a426so58141475ad.1
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 08:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795709520; x=1796314320;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LlTtVHWH2V/CMOEaX8atg0CvgdCbAV4pwHRMV9WTQdA=;
 b=eVDOncmzWYwTsYzYYFtUVR4BrdfrqP9YLSwpdo77MU0WYHGH6AMylOXKnrsnI8ivzs
 Gm4A0hYCPAYudSEXbFDF5v8eVWHUe5i/R0LkG12nDy9fXo/NrlsbsJE5+VzVFCUdnBEk
 +fDCAEnklfyPu8BAQgcrm61wQELp613pU3GrDDBOf1/M+nwcJGevjWPsx3RMUGYo9+Ks
 tr2XZ4k6RnB61GouM+LDn7B18N7D06gwo6yc9XKsgDTRf4Nq6y4UaWDkVmMVHt9VpqXB
 5sZNlZKiGUule32vqgw2NF7uR3myW+Q2Lx7QdEnH1OOfV4UrUuZ1i96jEXM1VkcL7KrE
 ZT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795709520; x=1796314320;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LlTtVHWH2V/CMOEaX8atg0CvgdCbAV4pwHRMV9WTQdA=;
 b=eBx/yChbpzFTGvCqXN1xwCFs+Aq+JZlReHgcxT3wRBZk7Rg5J8CdoKCrsVYDSWBl1o
 wMjkHW5uBGCB/hwr4dtdh3khtJtoI9ZkHrBmL2eX/4QUYNuEoWZvXwosfPhW5HUffUDf
 G1DSX0MZs/DinxpPikgCLLETHpkAhiqN6KkybC7sQ7GjxRqdtfPT+8jZ37tYoAoNq8Yg
 H4swKrBEcNuFYTwdfZX6Lmcm6RNialvw0o3NGvHk4WLryrAya/FcXjr8dCn7uZEuPFLQ
 LHOz4ec1GKVWfnPplxjazRBBg6kL5jhqkDpjOtV8KWjaOUSAbbyh5DUJHnO1zdSuxNbn
 3l+w==
X-Forwarded-Encrypted: i=1;
 AL+hErFkp4SiIIshAq+RvbL6cN/cKBTTswmEf9dGbO3g6sJPay05TUsoYIoA+mbKlw1FSOQy/brTfww=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+9VODNLoUoZB3G2dszGTbjnCVilGSa2b4LRvtEJ4KU+k/DQcl6
 HBiqj1sqz3SBV+v1a3IUZI+6QYX1+ghxARfsam+CObmMGa3WCUurshpw6qdmzVEgCio=
X-Gm-Gg: AZFdTZe331fLB54zFZM1vp14XU2MINkWgQ1+U/xY+P0v2kIhnd6HeuT+JgrinIxshDg
 Rll7Cs/BxsMilhr1Al4x1+3uuEbQ8WJ0d16CIPOzibW2RgAAUi1rJKjFKpyhrUH+VivL9vADUJB
 IWcIh44Df61j+M0t48DTJ2QFATGujinLbN0vySgNfAng1zZnCAY2pyTmowbdJDMoLtCgJ6VDAYj
 e1+rxiQawHSM3SCg5GEBm1Gcn9+mZCTUercewDoGiiLWsvuu9JHiDiwQbvmmkLtyNvYKq2xnxrx
 yiPOFgxg7fBBTdBQxkXCkmHDCmyR/YnDzbE88NmZqk3eSE7+zK7T1VwYynVQRPomC9MgdMg9r44
 ifxoCbxAVnxmMGBgGHK61HgaZ25lju/yX/CmUtN8Dslckn568GM5UD/o7DpcvZ0S28Y4Q8SgxbC
 p+E3urpTpBAvHDkUggv0h32L45Mg3fFof36h7CnA3rCaxZL2D61cYB7lsq24pn3jzuIGnMnFjgw
 qEUwfJ0ePLp4mdxjwmGtMwgKkv28s4hgOcud/eqjBUOP6OPEKEE42NZRjLJbf1QNa4BvxezhnDe
 SiW02XSCs88T9FTibHeJOp6eCK5abk3C2tIabDI7SCo=
X-Received: by 2002:a17:903:230a:b0:2ef:e755:bba2 with SMTP id
 d9443c01a7336-2f03f2b6004mr221389425ad.62.1795709519460; 
 Thu, 26 Nov 2026 08:11:59 -0800 (PST)
Received: from [172.20.3.121] ([156.19.246.27])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f191464sm108360285ad.1.2026.11.26.08.11.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 08:11:59 -0800 (PST)
Message-ID: <ef34ded1-ade9-4c79-8f4a-4eb7e817a68b@linaro.org>
Date: Thu, 26 Nov 2026 08:11:51 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: relocate: convert relocate_code to C
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com
Cc: casey.connolly@linaro.org, u-boot@lists.u-boot-project.org
References: <20261125074122.1965495-1-ilias.apalodimas@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261125074122.1965495-1-ilias.apalodimas@linaro.org>
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/24/26 23:41, Ilias Apalodimas wrote:
> +/**
> + * relocate_code() - copy U-Boot to its final location and fix it up
> + *
> + * @dest: destination address, gd->relocaddr
> + *
> + * This is entered from _main in crt0_64.S with sp and gd already
> + * pointing to the relocated area and with lr pointing to the relocated
> + * copy of relocation_return, so returning from here continues execution
> + * in the new image.
> + *
> + * Constraints for this function, since it runs from the old image and
> + * before BSS is usable:
> + * - It must not touch BSS. On arm64 .bss overlays .rela.dyn
> + * - It must not rely on anything that needs relocating in the destination.
> + *   Symbol addresses are generated PC-relative (adrp/add, -fno-pic), so they
> + *   resolve to the runtime location of the currently executing image, which
> + *   is already correct, either because we run at CONFIG_TEXT_BASE or because
> + *   pie_fixup has fixed up the running image in place.
> + * - It must not be instrumented.
> + */
> +void notrace relocate_code(ulong dest)
> +{
> +	u64 src = (u64)__image_copy_start;
> +	u64 size = (u64)__image_copy_end - src;
> +	const Elf64_Rela *rela = (const Elf64_Rela *)__rel_dyn_start;
> +	const Elf64_Rela *rela_end = (const Elf64_Rela *)__rel_dyn_end;
> +	u64 sctlr;
> +	u64 offset;
> +
> +	if (src == dest)
> +		return;
> +	memcpy((void *)dest, (void *)src, size);
> +	/*
> +	 * r_offset and r_addend are link-time values, so the offset to apply
> +	 * is link-to-copy
> +	 */
> +	offset = dest - CONFIG_TEXT_BASE;
> +
> +	/*
> +	 * We have a makefile check that aborts if reloc entries are not
> +	 * R_AARCH64_RELATIVE.
> +	 */
> +	for (; rela < rela_end; rela++) {
> +		if (ELF64_R_TYPE(rela->r_info) != R_AARCH64_RELATIVE)
> +			continue;
> +		*(u64 *)(rela->r_offset + offset) = rela->r_addend + offset;
> +	}

If you've got a build-time check that all reloc entries are RELATIVE, 
why are you checking again at runtime?

> +
> +	sctlr = get_sctlr();
> +	if (sctlr & CR_C) {
> +		__asm_flush_dcache_range(dest, dest + size);
> +		__asm_flush_l3_dcache();
> +	} else {
> +		/* Non-cacheable stores need to complete before we fetch new code */
> +		asm volatile("dsb sy" : : : "memory");
> +	}
> +
> +	if (sctlr & CR_I)
> +		asm volatile("ic iallu\n\tdsb nsh\n\tisb" : : : "memory");

isb here is redundant with the one below.

> +
> +	/* Always discard anything already fetched/prefetched */
> +	asm volatile("isb" : : : "memory");
> +}


r~
