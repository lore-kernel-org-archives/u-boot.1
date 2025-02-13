Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C91C0219D
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 14:15:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F2BC80EBD;
	Thu, 13 Feb 2025 15:15:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="hv0Xtxvw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FC3880EC0; Thu, 13 Feb 2025 15:15:50 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B740E80C77
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 15:15:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A1B423FE7C
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 14:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1739456143;
 bh=wayyRJQZeGxPzaQ8ds89B07WIf2x/dOBSbjIm7duxew=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=hv0XtxvwkZ9HafHoQCWx3Mi24V6hcfGrRaLOrZuEEpoLobKt2K/0wWqhgfdb4pH4V
 jiLsjzG3r50o3c2ccLYItpTWHCoG4tTgCIh4blIGNyxtGfIdfweG/AKRyWB3dMHhdW
 85Q0eaBJD3gjpLhW2vEjmEG37XVaCgW6APV+rj9oHr+EJVeR9U+Uxl3Ao1Eq6ysL7l
 gB24QWgxwkocEtPUFFOEmJD0mbKMq9oyCYsyKSFXR7LR+rBC80PELY8i2tgLZjarD4
 ts2pg/j8apVapNzZvBbUbjMdouijso5sXIuE6tgk2OQBojV7WXUxSoK6jEW4GD9Y99
 67VN2ou1g+S0Q==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4396260f74fso6282575e9.1
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 06:15:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739456142; x=1740060942;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wayyRJQZeGxPzaQ8ds89B07WIf2x/dOBSbjIm7duxew=;
 b=ES2F+RcyJz0B730+ht4xGZS5mPkfqTc2kN4sCPWL6LWiPacK7LwLDxI48BfSDXFzQs
 EM1SdsMl2sI0mwtexNy6BeGmL0sNmw1GaEBmHuXE+v2xCS2A9CISjcVdUdQ/VACVH9fc
 r4/jIHhv33ezdAXQMMCijsXSArI/kdK9vCPi5v/kT2QHDFW3AsnT6kfUVBo1TWMI2jcb
 C2EHxK3cY69SaRaFTG3EG4qn5o2fjjpc+ccyq/kWkMqrUgK+/YlvCxkpKp+D1FlHjoYK
 P31dsfC/dFqwsj6Tt52ueRqFLfbiBFSo64rGKZkbTfJlcWQFUG60LqXx4FQsDA4CFd8/
 6IwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXOdA/HlMwoQ+UtspM8izwmgQFO+pE4C2xP7dTUMHOLWWixeb3S3f6ClTOLUDhE/Xhs33gdPU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4di5RYavA5+SoYkwJ7jtOFNLt/ZArOfp3nYffo/Fga0zLKOPD
 CffUV6QvdvrI8nSCwSHdWT4JSUwxmKsP0E5KOJFZA88AZGaaLe9wAB0Rer/4c3N5gn3jESGnqrm
 zGcaijVFaOLMoWxNDUcxzXl+Xayo98rBQp18/rT9chPYjd03qidsFVUf0L9yyfuvdQmk=
X-Gm-Gg: ASbGncsJ+z1mg0GojsomiyLn7j3HYVvAz7ed3JYjgxMGO/fMMZCGDPoxtuzA6hw/i2j
 jwEdxTAXePLOO+DfwaJuNCdC8wYciAbLtG2e/YlItKpcOFULBcH5r8NKaKAh8lpruVp87t7baM+
 yAHTWrePRfT+eQFxyKOVxYuh0vF/LgNQtL8jfAU4TpyDY0MMcnAwHHU0hB0glCDRt50DYDOIKhR
 QIUdd+/w5TgOH5cFAHZ0BKE3VRVzTS9iuqQA+lGxVTQqE2xLUvgi/aVA2jZfGuDOjWKc29/70sy
 sa9pw1Y3guPSX8WU6auLRCTS619PU2KwCpmC+EA1uhA1unzUe/LizeT6sIG3l1k+xtPRhCYL3Qr
 62A==
X-Received: by 2002:a05:600c:5489:b0:439:63cb:ff89 with SMTP id
 5b1f17b1804b1-43963cc00afmr20537955e9.25.1739456142009; 
 Thu, 13 Feb 2025 06:15:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkqAb2TJpG1gahDMwRFOmHvITjtAFRQajtqt2To+Ff8/3iEfZgYiHqPnE050JeJOE/DzUxsA==
X-Received: by 2002:a05:600c:5489:b0:439:63cb:ff89 with SMTP id
 5b1f17b1804b1-43963cc00afmr20537525e9.25.1739456141602; 
 Thu, 13 Feb 2025 06:15:41 -0800 (PST)
Received: from [192.168.103.102]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439617da784sm19728295e9.5.2025.02.13.06.15.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 06:15:40 -0800 (PST)
Message-ID: <7947ea7e-a2e3-4ae1-abb1-9d4c9d506017@canonical.com>
Date: Thu, 13 Feb 2025 15:15:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] lmb: check if a region can be reserved by
 lmb_reserve()
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Udit Kumar <u-kumar1@ti.com>,
 u-boot@lists.denx.de
References: <20250213131104.186663-1-sughosh.ganu@linaro.org>
 <20250213131104.186663-2-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250213131104.186663-2-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 13.02.25 14:11, Sughosh Ganu wrote:
> The logic used in lmb_alloc() takes into consideration the existing
> reserved regions, and ensures that the allocated region does not
> overlap with any existing allocated regions. The lmb_reserve()
> function is not doing any such checks -- the requested region might
> overlap with an existing region. This also shows up with
> lmb_alloc_addr() as this function ends up calling lmb_reserve().
> 
> Add a function which checks if the region requested is overlapping
> with an existing reserved region, and allow for the reservation to
> happen only if both the regions have LMB_NONE flag, which allows
> re-requesting of the region. In any other scenario of an overlap, have
> lmb_reserve() return -EEXIST, implying that the requested region is
> already reserved.
> 
> Also add corresponding test cases which checks for overlapping
> reservation requests made through lmb_reserve() and lmb_alloc_addr().
> 
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>   lib/lmb.c      |  23 ++++++++++++
>   test/lib/lmb.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 122 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 7ca44591e1d..aeaf120f57d 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -595,6 +595,26 @@ static __maybe_unused void lmb_reserve_common_spl(void)
>   	}
>   }
>   

Every new function should get a Sphinx style description.

> +static bool lmb_can_reserve_region(phys_addr_t base, phys_size_t size,
> +				   u32 flags)
> +{
> +	uint i;
> +	struct lmb_region *lmb_reserved = lmb.used_mem.data;
> +
> +	for (i = 0; i < lmb.used_mem.count; i++) {
> +		u32 rgnflags = lmb_reserved[i].flags;
> +		phys_addr_t rgnbase = lmb_reserved[i].base;
> +		phys_size_t rgnsize = lmb_reserved[i].size;
> +
> +		if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {
> +			if (flags != LMB_NONE || flags != rgnflags)
> +				return false;
> +		}
> +	}
> +
> +	return true;
> +}
> +

This seems to duplicate code in lmb_resize_regions(). Can we reduce the 
code size by using a common function?

Best regards

Heinrich

>   void lmb_add_memory(void)
>   {
>   	int i;
> @@ -667,6 +687,9 @@ long lmb_reserve(phys_addr_t base, phys_size_t size, u32 flags)
>   	long ret = 0;
>   	struct alist *lmb_rgn_lst = &lmb.used_mem;
>   
> +	if (!lmb_can_reserve_region(base, size, flags))
> +		return -EEXIST;
> +
>   	ret = lmb_add_region_flags(lmb_rgn_lst, base, size, flags);
>   	if (ret)
>   		return ret;
> diff --git a/test/lib/lmb.c b/test/lib/lmb.c
> index fcb5f1af532..6b995c976dd 100644
> --- a/test/lib/lmb.c
> +++ b/test/lib/lmb.c
> @@ -499,6 +499,32 @@ static int lib_test_lmb_overlapping_reserve(struct unit_test_state *uts)
>   	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40000000, 0x40000,
>   		   0, 0, 0, 0);
>   
> +	/* try to allocate overlapping region with a different flag, should fail */
> +	ret = lmb_reserve(0x40008000, 0x1000, LMB_NOOVERWRITE);
> +	ut_asserteq(ret, -EEXIST);
> +
> +	/* allocate another region at 0x40050000 with a different flag */
> +	ret = lmb_reserve(0x40050000, 0x10000, LMB_NOOVERWRITE);
> +	ut_asserteq(ret, 0);
> +	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, 0x40000000, 0x40000,
> +		   0x40050000, 0x10000, 0, 0);
> +
> +	/*
> +	 * try to allocate a region adjacent to region 1 overlapping the 2nd region,
> +	 * should fail
> +	 */
> +	ret = lmb_reserve(0x40040000, 0x20000, LMB_NONE);
> +	ut_asserteq(ret, -EEXIST);
> +
> +	/*
> +	 * try to allocate a region between the two regions, but without an overlap,
> +	 * should succeed. this added region coalesces with the region 1
> +	 */
> +	ret = lmb_reserve(0x40040000, 0x10000, LMB_NONE);
> +	ut_asserteq(ret, 0);
> +	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, 0x40000000, 0x50000,
> +		   0x40050000, 0x10000, 0, 0);
> +
>   	lmb_pop(&store);
>   
>   	return 0;
> @@ -549,6 +575,78 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
>   	ret = lmb_free(alloc_addr_a, 0x1000);
>   	ut_asserteq(ret, 0);
>   
> +	/*
> +	 * Add two regions with different flags, region1 and region2 with
> +	 * a gap between them.
> +	 * Try adding another region, adjacent to region 1 and overlapping
> +	 * region 2. Should fail.
> +	 */
> +	a = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NONE);
> +	ut_asserteq(a, alloc_addr_a);
> +
> +	b = lmb_alloc_addr(alloc_addr_a + 0x4000, 0x1000, LMB_NOOVERWRITE);
> +	ut_asserteq(b, alloc_addr_a + 0x4000);
> +	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, a, 0x1000,
> +		   b, 0x1000, 0, 0);
> +
> +	c = lmb_alloc_addr(alloc_addr_a + 0x1000, 0x5000, LMB_NONE);
> +	ut_asserteq(c, 0);
> +	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, a, 0x1000,
> +		   b, 0x1000, 0, 0);
> +
> +	ret = lmb_free(a, 0x1000);
> +	ut_asserteq(ret, 0);
> +	ret = lmb_free(b, 0x1000);
> +	ut_asserteq(ret, 0);
> +
> +
> +	/*
> +	 * Add two regions with same flags(LMB_NONE), region1 and region2
> +	 * with a gap between them.
> +	 * Try adding another region, adjacent to region 1 and overlapping
> +	 * region 2. Should succeed. All regions should coalesce into a
> +	 * single region.
> +	 */
> +	a = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NONE);
> +	ut_asserteq(a, alloc_addr_a);
> +
> +	b = lmb_alloc_addr(alloc_addr_a + 0x4000, 0x1000, LMB_NONE);
> +	ut_asserteq(b, alloc_addr_a + 0x4000);
> +	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, a, 0x1000,
> +		   b, 0x1000, 0, 0);
> +
> +	c = lmb_alloc_addr(alloc_addr_a + 0x1000, 0x5000, LMB_NONE);
> +	ut_asserteq(c, alloc_addr_a + 0x1000);
> +	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, a, 0x6000,
> +		   0, 0, 0, 0);
> +
> +	ret = lmb_free(a, 0x6000);
> +	ut_asserteq(ret, 0);
> +
> +	/*
> +	 * Add two regions with same flags(LMB_NOOVERWRITE), region1 and
> +	 * region2 with a gap between them.
> +	 * Try adding another region, adjacent to region 1 and overlapping
> +	 * region 2. Should fail.
> +	 */
> +	a = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
> +	ut_asserteq(a, alloc_addr_a);
> +
> +	b = lmb_alloc_addr(alloc_addr_a + 0x4000, 0x1000, LMB_NOOVERWRITE);
> +	ut_asserteq(b, alloc_addr_a + 0x4000);
> +	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, a, 0x1000,
> +		   b, 0x1000, 0, 0);
> +
> +	c = lmb_alloc_addr(alloc_addr_a + 0x1000, 0x5000, LMB_NOOVERWRITE);
> +	ut_asserteq(c, 0);
> +	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, a, 0x1000,
> +		   b, 0x1000, 0, 0);
> +
> +	ret = lmb_free(a, 0x1000);
> +	ut_asserteq(ret, 0);
> +	ret = lmb_free(b, 0x1000);
> +	ut_asserteq(ret, 0);
> +
>   	/*  reserve 3 blocks */
>   	ret = lmb_reserve(alloc_addr_a, 0x10000, LMB_NONE);
>   	ut_asserteq(ret, 0);
> @@ -760,7 +858,7 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
>   
>   	/* reserve again, new flag */
>   	ret = lmb_reserve(0x40010000, 0x10000, LMB_NONE);
> -	ut_asserteq(ret, -1);
> +	ut_asserteq(ret, -EEXIST);
>   	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x10000,
>   		   0, 0, 0, 0);
>   

