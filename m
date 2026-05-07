Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837E4CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 18:59:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A42EA84B42;
	Thu,  7 May 2026 20:59:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JX+kesnc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82C5C84B45; Thu,  7 May 2026 20:59:32 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D0CD84A75
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 20:59:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so11554345e9.0
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 11:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778180370; x=1778785170; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TxJ988+iWKdUUiQQe/Qk1GYxLxuDwqH8AzdMVcPEdhQ=;
 b=JX+kesncaDvTqmKvib3BvG5jZptWSb692niTRCIIiuABJiKMtwizVxL9KHGwR4+Z1q
 jOjqt/QgIOpMvAhLC4pD3cqa2+QGPw6uIdpev9QjCxyenIbrQ916+8bEj6jSV2dmT0O0
 Qko6IP2TaJdIflpHiBvmntgBiJ9eeosdIlAcl4exr95Q8pvCM09f2NkOVMnVDxkwVVw0
 6HMEqWvH5bps/CDG6WNU8yHd9IT12NsAYre+EBfiE6Aew0sqfLirGraRX2rBRLGs3obt
 wDg09Yzxem7+FkrDIZOgbZPo+qrIHcC1GGiLZuN+QTgIHmhf7p3OR8fL0giR8lXIBOiY
 SbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778180370; x=1778785170;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TxJ988+iWKdUUiQQe/Qk1GYxLxuDwqH8AzdMVcPEdhQ=;
 b=P6/ACMX2KoN6nP/KubBowrgANOVE5B0tAORjO5GoMQyt2zyXxcB+zcjfzZINQpWZkB
 AREo4ZqCT/G8djfzoZJKkYiNLFYyao8HASkfriO4J3ppk3ldH7SZZqL34+7Ivv6w9dAW
 OqJFVvBE265MbFKGy5SK6AhyTzdGIpW20VhZ0oYwMi/XfTQ9jMTU9NsRRCprmHwO7K5n
 5JfBw1HpJP1T4OWV7AMLbl0tjufO84grxwIel7w67PorAezSQuSGDk39+ySplXTz/MY2
 05dq3q+uSGb1KEqVhRca4+v+rPxwaClW2AMAe0uhClAecofqnavpuBe95/fuxCIZXKF6
 uCDQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ95NWu1rBqqLBcUC3w+SM5OYb+AyHm+X+7W9UXor7Ul7hntoyKjZUFYXVcJh7MkcX3OUDMcCfQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzLR/O0lZ9iwU0GBGB/K6+9COg9xkAS/3i6ZMjVsRlUhwRBaTNJ
 ttbGOhUJR6KjPodJjm1Ba+WsZ40D+KCNI5YxlaIFGXU8zmIb8Kp0gt/pYkndr984JuI=
X-Gm-Gg: AeBDievXcIzZkSe3bWfJVJ44cR8Z2G7uLbXAd6JTUYUCHzUeAILaQZ+qYXqA7M1cjf3
 lECh3aIiPUvIWnCjOxCLOhAGKv+pnwS42z+Rr/aEcU4BhOAh/oegbPFjF+Q6pX475EyZQuLQ9To
 g00Wt2ZCFmCbCspbgyYfbO8Bw0ejnnAyUmXiricnumnQUopcIQCbr9XcGX6PtemJQlxmi9q/ceA
 HAF7lc9qS5HiYRVMQ9kE18iyLcWjfqIOY2SRNZ2nGJ3CmJAh1H6JoiK31cLsej2Mrxc0D1UgGob
 da+nKhK+8TRF/h3Wif9Ilz9cEFmCwsMP/bmVugf/yrzKiX2ZLtEp9HwFrYRJSX7/sLhJd1clBEL
 ks6pS0Yj4IjXhi8beXxVqtx9VSg1ghbfp3JEL3sp4aMsVaG7lfvWvYAMI6eL0YepU/VxdjpKRfb
 p9Ke0qjZsGEf8qnmUFulHWxnON0wGrrDSyB43MqdMRtwTZf7tVoeJRtqpkNDc+olNXcbykhgCbV
 S8j
X-Received: by 2002:a05:600c:34c8:b0:486:fd5c:2b35 with SMTP id
 5b1f17b1804b1-48e51f2f85emr171224235e9.13.1778180369620; 
 Thu, 07 May 2026 11:59:29 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538d2878sm229917545e9.15.2026.05.07.11.59.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 11:59:29 -0700 (PDT)
Message-ID: <e5c62ceb-906e-40ac-a4bc-f573d7e748ac@linaro.org>
Date: Thu, 7 May 2026 20:59:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] armv8: mmu: support unmapping regions with
 set_one_region()
Content-Language: en-US
To: Anshul Dalal <anshuld@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20260504183721.646712-1-casey.connolly@linaro.org>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260504183721.646712-1-casey.connolly@linaro.org>
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

After discussing more with Ilias off-list it's become clear that this
was the wrong approach. I have an improved fix working which I'll post
shortly.

On 04/05/2026 20:37, Casey Connolly wrote:
> Currently set_one_region() implicitly assumes that we want to map a
> region and aggressively splits blocks into tables to do this, but when
> called with PTE_TYPE_FAULT to unmap a currently mapped region it may
> try to unnecessarily split blocks which doesn't make sense if the entire
> block should actually be unmapped. In the end it then has to walk every
> single page and create a bunch of empty tables.
> 
> Introduce a check for this kind of behaviour and optimise with a fast
> path, if we're unmapping a region >= the size of this entry then we can
> just unmap the entire PTE and whatever it contains.
> 
> This fixes some bogus empty tables being left behind when carving out
> reserved memory regions on Qualcomm, and should improve the performance
> of the break-before-make in mmu_change_region_attr().
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
> Changes in v2:
>  - Update pte_type() to correctly check the PTE_TYPE_VALID bit
>  - Explicitly unset both bits of PTE_TYPE_MASK to be extra safe
>  - V1: https://lore.kernel.org/u-boot/20260504175511.585797-1-casey.connolly@linaro.org/
> ---
>  arch/arm/cpu/armv8/cache_v8.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index 39479df7b21f..b6506e8523be 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -162,9 +162,9 @@ u64 get_tcr(u64 *pips, u64 *pva_bits)
>  #define MAX_PTE_ENTRIES 512
>  
>  static int pte_type(u64 *pte)
>  {
> -	return *pte & PTE_TYPE_MASK;
> +	return *pte & PTE_TYPE_VALID ? *pte & PTE_TYPE_MASK : PTE_TYPE_FAULT;
>  }
>  
>  /* Returns the LSB number for a PTE on level <level> */
>  static int level2shift(int level)
> @@ -939,8 +939,20 @@ static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
>  	int levelshift = level2shift(level);
>  	u64 levelsize = 1ULL << levelshift;
>  	u64 *pte = find_pte(start, level);
>  
> +	/*
> +	 * If we're trying to unmap a region then check if it's already unmapped or if it's bigger
> +	 * then the PTE we're looking at right now, in the first case we can do nothing and in the
> +	 * second case we just need to unmap this page/block.
> +	 * Otherwise we will needlessly create new tables until we have traversed every single page
> +	 * in the region.
> +	 */
> +	if (attrs == PTE_TYPE_FAULT && (pte_type(pte) == PTE_TYPE_FAULT || size >= levelsize)) {
> +		*pte &= ~(PMD_ATTRMASK | PTE_TYPE_MASK);
> +		return levelsize;
> +	}
> +
>  	/* Can we can just modify the current level block PTE? */
>  	if (is_aligned(start, size, levelsize)) {
>  		if (flag) {
>  			*pte &= ~PMD_ATTRMASK;
> @@ -1081,8 +1093,12 @@ void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs)
>  	flush_dcache_range(gd->arch.tlb_addr,
>  			   gd->arch.tlb_addr + gd->arch.tlb_size);
>  	__asm_invalidate_tlb_all();
>  
> +	/* If we were unmapping a region then we're done! */
> +	if (attrs == PTE_TYPE_FAULT)
> +		return;
> +
>  	mmu_change_region_attr_nobreak(addr, siz, attrs);
>  }
>  
>  int pgprot_set_attrs(phys_addr_t addr, size_t size, enum pgprot_attrs perm)

-- 
// Casey (she/her)

