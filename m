Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F58C021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 10:28:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D814806FE;
	Thu, 20 Feb 2025 11:28:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="gkjFKPlK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E328580C98; Thu, 20 Feb 2025 11:28:22 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 008BB801DE
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 11:28:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1F8E33F2BC
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 10:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1740047295;
 bh=Fl3NZVGnVzYDETkHXzHVTGV5nc78dRonKN/gRZVUsGY=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=gkjFKPlKisvKEG3MMmFICHqCmOnIO3ZEHCxJyZ2OhXdx+9VeZiN/DGTE6Ve9hYVK1
 NgCRbJBm2tToz5GJgptE3nqYrESethUe+bICKi8Lbd7kW99bl85CeJTCW1TKelKYJP
 sphPjHmvtVsiFfSf3B3PF5hJphXaVOb2rHCY2UHCvP0Q5N64BG/voyWzHwN3WJ+jEo
 ZkoZeoHVlHPlcD1wxZGY36WwCusbPjU5gXSpCfRj82VTsK0mDxgTOWfwNC2WjXGhzU
 aWe90bVnDnqSyPSyE81XtkBLoxGUqrIjBAaOQBPEA1TL3eAccVsl5uWxFZVpk4Hqpk
 Z0tHmY29NsoJw==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4394c747c72so3355555e9.1
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 02:28:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740047294; x=1740652094;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fl3NZVGnVzYDETkHXzHVTGV5nc78dRonKN/gRZVUsGY=;
 b=jHRSOE0TTIp8Cv13zISsuPD4q9dDyZqyLeEnCZwH9UVzSoq6TQdEoEl/19qGYaTSt3
 rEqqUZCwJTG7yXWBZfYawdm3Hiao5AAeQCcF79edQgcrbMHsx42+l/RgZHc3lSyVZBsE
 EmtYz8ZorG6hSVD0uhzei6mTJ7OvhYiacd7MtQCxJrq3O9bd2sblkSfJ7e42ZyWpBupc
 l7gnYHhkvoprt26I9PsFcftIjBVHR5lg4dhmY9s+KKCvwynmqJ5QBhmUGQ3jna+qRDHy
 1IlZS8xBcLgJjlq3LFc4INqvObtUnhBE3moPUaThEk66aqwNOkt5YmmG98kEXxDz8Jn1
 ZCoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW14J0zFZJDCiD2MpaEAHFvBIrv/ksYX4uWYID2YoiW4Iu7rAoV+LCoqUpxixWx9p9UMfiYkmk=@lists.denx.de
X-Gm-Message-State: AOJu0YzL1+1ZCysxWGouZL2ViFZ/FB7MDW2kc+E33dRghEuN/+4BR00b
 BhRNTjT74AdZ+Dk4+Zy8Kbk6wEaBr27FzbXqUdvtdgwvN9jikyE2kRkEOpDmKrjjaQMPHwpFYSc
 va/wVMYYtnynvNNDMn4/yg7aDyyFzYzMsJe74ip4zwLZfP1UUr+Nu1FcmmUcaF7rXQ5I=
X-Gm-Gg: ASbGncucKGbwQ0pE1Q8KfiTKYXhK0gHs5RLmqoptLz1eq03YC9p2RRxe7pj9IFGe/0i
 zVWfRTN5IYx8aDF/sbCM5ajLVZj10YJlp8frQBVosUehbuwx7obYx/Ntn0ObYg7SGB6WNYHZSP6
 G994YydpEOMdQDW6xiUucDxyhdNdZgZAqagZu4VUF8CvzA/sF/xxwyEVAhs5iSrOxjLAXrIk6SV
 3EzApvLF9kKms26HkNu/qHz7/MpWgiVK3JpbYTGV9b3NOqEmF1JD95WtMEwKKTg2JvX/NhexhcC
 98V1OmpgX2sUXobsyf9ZYAv61IovkDnkrHWx6OBmPSb6lCc7My16riW/nyyqVFP3ublx
X-Received: by 2002:a05:600c:5112:b0:439:9c0e:3692 with SMTP id
 5b1f17b1804b1-439a4bdb0f4mr13769555e9.28.1740047294360; 
 Thu, 20 Feb 2025 02:28:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDqxd5Td1LRQoNcE3GA8wTYUo1NZGgOknZjmnDc2TL9B4HIvke2asBynTOzq4wEj9sItRi1w==
X-Received: by 2002:a05:600c:5112:b0:439:9c0e:3692 with SMTP id
 5b1f17b1804b1-439a4bdb0f4mr13769235e9.28.1740047293802; 
 Thu, 20 Feb 2025 02:28:13 -0800 (PST)
Received: from ?IPV6:2a02:3035:6e0:1d2:497a:3557:382b:d853?
 ([2a02:3035:6e0:1d2:497a:3557:382b:d853])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439858ec5fasm110145815e9.29.2025.02.20.02.28.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 02:28:13 -0800 (PST)
Message-ID: <a23a377a-c1c8-4cd5-9090-d3205969bc21@canonical.com>
Date: Thu, 20 Feb 2025 11:28:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] lmb: check if a region can be reserved by
 lmb_reserve()
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Udit Kumar <u-kumar1@ti.com>,
 u-boot@lists.denx.de
References: <20250220095654.121634-1-sughosh.ganu@linaro.org>
 <20250220095654.121634-2-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250220095654.121634-2-sughosh.ganu@linaro.org>
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

On 20.02.25 10:56, Sughosh Ganu wrote:
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
> Add corresponding test cases which check for overlapping reservation
> requests made through lmb_reserve() and lmb_alloc_addr(). And while
> here, fix some of the comments in the test function being touched.
> 
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>

Looks good to me.

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> ---
> Changes since V1:
> * Add documentation for the lmb_can_reserve_region() function.
> * Add an additional test case where a new region is being added, and
>    the new region overlaps two different existing regions, with
>    mismatching flags.
> * Some cleanup of comments in the lib_test_lmb_overlapping_reserve()
>    function.
> 
>   lib/lmb.c      |  36 ++++++++++++++++
>   test/lib/lmb.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++--
>   2 files changed, 146 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 7ca44591e1d..d7d2c8c6dfd 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -595,6 +595,39 @@ static __maybe_unused void lmb_reserve_common_spl(void)
>   	}
>   }
>   
> +/**
> + * lmb_can_reserve_region() - check if the region can be reserved
> + * @base: base address of region to be reserved
> + * @size: size of region to be reserved
> + * @flags: flag of the region to be reserved
> + *
> + * Go through all the reserved regions and ensure that the requested
> + * region does not overlap with any existing regions. An overlap is
> + * allowed only when the flag of the request region and the existing
> + * region is LMB_NONE.
> + *
> + * Return: true if region can be reserved, false otherwise
> + */
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
>   void lmb_add_memory(void)
>   {
>   	int i;
> @@ -667,6 +700,9 @@ long lmb_reserve(phys_addr_t base, phys_size_t size, u32 flags)
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
> index fcb5f1af532..24416e83491 100644
> --- a/test/lib/lmb.c
> +++ b/test/lib/lmb.c
> @@ -471,17 +471,17 @@ static int lib_test_lmb_overlapping_reserve(struct unit_test_state *uts)
>   	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x10000,
>   		   0, 0, 0, 0);
>   
> -	/* allocate overlapping region should return the coalesced count */
> +	/* allocate overlapping region */
>   	ret = lmb_reserve(0x40011000, 0x10000, LMB_NONE);
>   	ut_asserteq(ret, 0);
>   	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x11000,
>   		   0, 0, 0, 0);
> -	/* allocate 3nd region */
> +	/* allocate 2nd region */
>   	ret = lmb_reserve(0x40030000, 0x10000, LMB_NONE);
>   	ut_asserteq(ret, 0);
>   	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, 0x40010000, 0x11000,
>   		   0x40030000, 0x10000, 0, 0);
> -	/* allocate 2nd region , This should coalesced all region into one */
> +	/* allocate 3rd region , This should coalesce all regions into one */
>   	ret = lmb_reserve(0x40020000, 0x10000, LMB_NONE);
>   	ut_assert(ret >= 0);
>   	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x30000,
> @@ -499,6 +499,41 @@ static int lib_test_lmb_overlapping_reserve(struct unit_test_state *uts)
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
> +	 * try to reserve a region adjacent to region 1 overlapping the 2nd region,
> +	 * should fail
> +	 */
> +	ret = lmb_reserve(0x40040000, 0x20000, LMB_NONE);
> +	ut_asserteq(ret, -EEXIST);
> +
> +	/*
> +	 * try to reserve a region between the two regions, but without an overlap,
> +	 * should succeed. this added region coalesces with the region 1
> +	 */
> +	ret = lmb_reserve(0x40040000, 0x10000, LMB_NONE);
> +	ut_asserteq(ret, 0);
> +	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, 0x40000000, 0x50000,
> +		   0x40050000, 0x10000, 0, 0);
> +
> +	/*
> +	 * try to reserve a region which overlaps with both the regions,
> +	 * should fail as the flags do not match
> +	 */
> +	ret = lmb_reserve(0x40020000, 0x80000, LMB_NONE);
> +	ut_asserteq(ret, -EEXIST);
> +	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, 0x40000000, 0x50000,
> +		   0x40050000, 0x10000, 0, 0);
> +
>   	lmb_pop(&store);
>   
>   	return 0;
> @@ -549,6 +584,77 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
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
> @@ -760,7 +866,7 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
>   
>   	/* reserve again, new flag */
>   	ret = lmb_reserve(0x40010000, 0x10000, LMB_NONE);
> -	ut_asserteq(ret, -1);
> +	ut_asserteq(ret, -EEXIST);
>   	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x10000,
>   		   0, 0, 0, 0);
>   

