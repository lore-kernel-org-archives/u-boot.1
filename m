Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446A5CD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 12:21:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9050848BB;
	Tue,  5 May 2026 14:21:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Sbls5Drr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 150F0848BE; Tue,  5 May 2026 14:21:46 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98E67848B8
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 14:21:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4891d7164ddso27266855e9.3
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 05:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777983703; x=1778588503; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ey82zrIR76Cm2ed3wHlOFpltNVS7SZzB8mVKjOnGcDA=;
 b=Sbls5Drrfib8fSdXf9Yd3LEzNGsQYH88FTm0iN5IjrmtJaR8PGKdIPGDesE0wPD3Ln
 iN/CSUuNcNyA/aCw6vGh7P85LtpiG71+bIsUVFAznjdPa0uAqfzWB2vG1gEdLGdoV5fA
 rE9aF4tK1wHHxt+zqhQO41P5kzqVE90BRHoAv6OvHd+iJNpN77JNh6JAuFbK90hlYl8g
 XERJKVEozqmyA83xFwvTLd5bl/8Ii0+ysxUfhUz4aQVC/vGmESl+gisNpN5bXLYML6r/
 f5oVNXG8ZVLt5yt9cbbt6LLHzy0CT0AOvr2p2jtgvyfrLXVBoWyWONbot0FG/7GGtvDW
 FHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777983703; x=1778588503;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ey82zrIR76Cm2ed3wHlOFpltNVS7SZzB8mVKjOnGcDA=;
 b=hJWyf8D5k/ETGoUzJbTVBDJ761StaROeLS92SPyDzWcz2sBbxvOm1S0pc3lNpxe5x+
 RZ0sjQnrYgqHiR46K5ZtCJ2N+1iDNPGfG460edTS6zc/2omVB17V9EzxRubChBmi05dl
 /ZGpsXerWlXgIukmqO9nh0XvTM/dADXjT424me/VCzZLAN9nWKVhlXuT7kqJmIOSqdTF
 3H9raEmh7DJvF3cur9f5zqYWqIk7SK/W++t1qPkj8mOfVuVjsSuhdi+Vh4bq0xGH4uYB
 sRz591LtHB+UPa5l0FkDh57vPRJAIg5djx8K3WGNSFrgt6/gMBEOKaHgUPxi3TrA+L26
 4UDw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8OMwpyykAgMWcIuzPxrE/Q2IyLypxtGHtl7dgRX5WmpimblKDqKoxYiIfRDkERO5q9KVo3PTU=@lists.denx.de
X-Gm-Message-State: AOJu0YwjLRPkXMOdB9qWNm96YnLNxlY3h3L6J9iWySqQfb2wgHBf66Rr
 rzIR5HWaFierzxY4PK2m5UoSNyHpxm9E06UJ1d9EBCHjrbwbPSr55D/h2t4LXhMwo4ZcE7YVof/
 txDAAf8Y=
X-Gm-Gg: AeBDietaE+aJgaHXDkQRnPzM48UFJhj2AH7QbeWw8sL4U4UOcvnKf3WMVfNCoYBZ+Rk
 rqUbUAmnXLOR7mdXkzoq7qpFge94KNFkJ0W6ZJxm56/pwTF06CuLfRlRrASpp3ZPiq4ucVXiEDX
 jWgPIn9JNj7p9TFyl2DY/dqA6W3CvP+tk/zY+UWLesKkzA9YbF1qvaeiMCNqHGFZRUbARjRnQlM
 tS2k/xtg8OgHiGv2oaed9KCjpIYHFpPLgjVJI2W3C/Zj8HySdfs0SNQuy09pBj2I7rpefXO7GxY
 6ho6CmsfyqgCPRfZArFfLr/XIXNeKng6pwY9A1g/JcwckJTsd8TivSGIqaMx3IbaV2KESbK9qur
 GEsz6t2WK6ZtbdDW2QTl0zOnWaswc++WEJjBDwc1aS63MVL9OkV94z8GK9dZuvtCHcHujlynhlh
 GXFfawa616KeCRsQCWbkyzVW1l62FYzNGJ6RpMzyMT+bYpDfuDva5al5Oh3Fa3sw7bOm1F0i+lD
 Oq1
X-Received: by 2002:a05:600c:1386:b0:485:3f30:6250 with SMTP id
 5b1f17b1804b1-48a988b5623mr225994715e9.20.1777983702666; 
 Tue, 05 May 2026 05:21:42 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48d17714dc8sm34098235e9.4.2026.05.05.05.21.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 05:21:42 -0700 (PDT)
Message-ID: <400255c8-2997-4630-b087-c5e94e25e3b3@linaro.org>
Date: Tue, 5 May 2026 14:21:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] armv8: mmu: support unmapping regions with
 set_one_region()
Content-Language: en-US
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Anshul Dalal <anshuld@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20260504175511.585797-1-casey.connolly@linaro.org>
 <afm_cdgq-bXwcLLn@sumit-xelite>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <afm_cdgq-bXwcLLn@sumit-xelite>
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



On 05/05/2026 11:59, Sumit Garg wrote:
> On Mon, May 04, 2026 at 07:53:54PM +0200, Casey Connolly wrote:
>> Currently set_one_region() implicitly assumes that we want to map a
>> region and aggressively splits blocks into tables to do this, but when
>> called with PTE_TYPE_FAULT to unmap a currently mapped region it may
>> try to unnecessarily split blocks which doesn't make sense if the entire
>> block should actually be unmapped. In the end it then has to walk every
>> single page and create a bunch of empty tables.
>>
>> Introduce a check for this kind of behaviour and optimise with a fast
>> path, if we're unmapping a region >= the size of this entry then we can
>> just unmap the entire PTE and whatever it contains.
>>
>> This fixes some bogus empty tables being left behind when carving out
>> reserved memory regions on Qualcomm, and should improve the performance
>> of the break-before-make in mmu_change_region_attr().
>>
>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>> ---
>>  arch/arm/cpu/armv8/cache_v8.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
> 
> Nice optimization, FWIW:
> 
> Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Tested-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Could you drop this on the v2 instead? Sorry for the confusion this
version had a silly bug.
> 
> -Sumit
> 
>>
>> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
>> index 39479df7b21f..b1a1fd571341 100644
>> --- a/arch/arm/cpu/armv8/cache_v8.c
>> +++ b/arch/arm/cpu/armv8/cache_v8.c
>> @@ -939,8 +939,20 @@ static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
>>  	int levelshift = level2shift(level);
>>  	u64 levelsize = 1ULL << levelshift;
>>  	u64 *pte = find_pte(start, level);
>>  
>> +	/*
>> +	 * If we're trying to unmap a region then check if it's already unmapped or if it's bigger
>> +	 * then the PTE we're looking at right now, in the first case we can do nothing and in the
>> +	 * second case we just need to unmap this page/block.
>> +	 * Otherwise we will needlessly create new tables until we have traversed every single page
>> +	 * in the region.
>> +	 */
>> +	if (attrs == PTE_TYPE_FAULT && (pte_type(pte) == PTE_TYPE_FAULT || size >= levelsize)) {
>> +		*pte &= ~PMD_ATTRMASK;
>> +		return levelsize;
>> +	}
>> +
>>  	/* Can we can just modify the current level block PTE? */
>>  	if (is_aligned(start, size, levelsize)) {
>>  		if (flag) {
>>  			*pte &= ~PMD_ATTRMASK;
>> @@ -1081,8 +1093,12 @@ void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs)
>>  	flush_dcache_range(gd->arch.tlb_addr,
>>  			   gd->arch.tlb_addr + gd->arch.tlb_size);
>>  	__asm_invalidate_tlb_all();
>>  
>> +	/* If we were unmapping a region then we're done! */
>> +	if (attrs == PTE_TYPE_FAULT)
>> +		return;
>> +
>>  	mmu_change_region_attr_nobreak(addr, siz, attrs);
>>  }
>>  
>>  int pgprot_set_attrs(phys_addr_t addr, size_t size, enum pgprot_attrs perm)
>> -- 
>> 2.53.0
>>

-- 
// Casey (she/her)

