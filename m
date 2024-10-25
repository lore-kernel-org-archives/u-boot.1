Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920B7D149E7
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 19:06:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D487D88FE4;
	Fri, 25 Oct 2024 21:06:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k1AQgtzp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0A1289017; Fri, 25 Oct 2024 21:06:10 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91B5988FBF
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 21:06:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a99e3b3a411so574881466b.0
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 12:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729883165; x=1730487965; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=otIfmtqkp+MOynee4XCgz0LEwoxkdqL3cDLHLkEDQXY=;
 b=k1AQgtzpciQWzjZcBF0y6J+bKovENmy80koSECVAvnpSHMlRkQ25lKQRhBkRYx/HUf
 0trXkApalF9uLDgxfKC0x0EI/1QMb7XBXxFVNsBTnOpmolHfh49sO/oGPtbr8L3Z+NVw
 U7nKZARu6j+gUCHgMtBg8/ebr+P6w6SS/wYpZdmw1E60cFgjHh24EdfiIEh1HO1Xj3hp
 nn5RfiHgpaibOYImNksoSlKKxBy2cwVu7Tv5GAL2COef4CiOqnr4YLcU0+yqwK0xTFxH
 rlN62WkkSnii/xJI6+QeYxlA7TKK3rnNa4mnR+dtiQccMsJG1b9fyMqhGVDM1mMAyZ7d
 yKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729883165; x=1730487965;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=otIfmtqkp+MOynee4XCgz0LEwoxkdqL3cDLHLkEDQXY=;
 b=LWWRdJq1mEggTSb1c6Xmg6ptoVa4ib51W51mlnCrWTwM1qc8zLHIG1itimy6naSb7s
 7MVvYNDG+0K67zMOBn7wcdCLOpe38a9MzVH8QxPEGBXD0Smlrv2VyyXl66BXX4gdQeez
 r347OhkpL1koeT3r+qb320+Qfgu/3+6EnvXdlvaUBjJlIWtXM/2ZbKvUfTT9MJK2Cwly
 GuBzCUHoNnPbl8qPxBpcizv3199XlWqE159riQiePjo68R2ZZpv4eN66dwiApR7SUn0c
 Sib52bTmS9hg4rXPyCHsZXobW6eD6qWdDiesK8iiK0DolR3bxSgnEdm5VuqUrXKSZ9g8
 mbaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaoYMeDMxu2gJKvBCHZRavyjdhFoO7k2X/xaUNb98lvqVuxtaKQgeqWTAHC4e58n+7o1f3wL8=@lists.denx.de
X-Gm-Message-State: AOJu0YyJNR8Daybh+kRDGDN6JHzbECBXt01KqY+9KaozJtvlMYMq6igk
 1YLotkPf8x3Xahkdpg5ihfNwQdG6WDzqe7ciE+NLUboKwrjKmCg9JEbuq6ksHXQ=
X-Google-Smtp-Source: AGHT+IFoGqdLZUsX/2vcFJeelxikUL+nVhdPp96+FgSxbx2CwA1liTFsKxI6hDjwdFcRhngbWQ8pBw==
X-Received: by 2002:a17:907:9281:b0:a9a:6c41:50c0 with SMTP id
 a640c23a62f3a-a9de38e4057mr43668666b.26.1729883164684; 
 Fri, 25 Oct 2024 12:06:04 -0700 (PDT)
Received: from ?IPV6:2a02:8109:888d:ff00::4? ([2a02:8109:888d:ff00::4])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30f5932fsm98283266b.168.2024.10.25.12.06.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 12:06:04 -0700 (PDT)
Message-ID: <1023cc96-fd6d-4001-931c-682805346684@linaro.org>
Date: Fri, 25 Oct 2024 21:06:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] lmb: Fix lmb_add_region_flags() return codes and
 testing
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, sughosh.ganu@linaro.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
References: <20241023152203.1218242-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20241023152203.1218242-1-ilias.apalodimas@linaro.org>
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

Hi Ilias,

On 23/10/2024 17:22, Ilias Apalodimas wrote:
> The function description says this should return 0 or -1 on failures.
> When regions coalesce though this returns the number of coalescedregions

* coalesced regions
> which is confusing and requires special handling of the return code.
> On top of that no one is using the number of coalesced regions.
> 
> So let's just return 0 on success and adjust our selftests accordingly
> 
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Thanks for following up on this!

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   boot/image-fdt.c |  2 +-
>   lib/lmb.c        | 10 +++++-----
>   test/lib/lmb.c   | 10 +++++-----
>   3 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index 8eda521693dc..eac09059d955 100644
> --- a/boot/image-fdt.c
> +++ b/boot/image-fdt.c
> @@ -73,7 +73,7 @@ static void boot_fdt_reserve_region(u64 addr, u64 size, enum lmb_flags flags)
>   	long ret;
>   
>   	ret = lmb_reserve_flags(addr, size, flags);
> -	if (ret >= 0) {
> +	if (!ret) {
>   		debug("   reserving fdt memory region: addr=%llx size=%llx flags=%x\n",
>   		      (unsigned long long)addr,
>   		      (unsigned long long)size, flags);
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 7e90f178763b..8ce58fcb9224 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -450,7 +450,7 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
>   	}
>   
>   	if (coalesced)
> -		return coalesced;
> +		return 0;
>   
>   	if (alist_full(lmb_rgn_lst) &&
>   	    !alist_expand_by(lmb_rgn_lst, lmb_rgn_lst->alloc))
> @@ -487,7 +487,7 @@ long lmb_add(phys_addr_t base, phys_size_t size)
>   	struct alist *lmb_rgn_lst = &lmb.free_mem;
>   
>   	ret = lmb_add_region(lmb_rgn_lst, base, size);
> -	if (ret < 0)
> +	if (ret)
>   		return ret;
>   
>   	if (lmb_should_notify(LMB_NONE))
> @@ -583,8 +583,8 @@ long lmb_reserve_flags(phys_addr_t base, phys_size_t size, enum lmb_flags flags)
>   	struct alist *lmb_rgn_lst = &lmb.used_mem;
>   
>   	ret = lmb_add_region_flags(lmb_rgn_lst, base, size, flags);
> -	if (ret < 0)
> -		return -1;
> +	if (ret)
> +		return ret;
>   
>   	if (lmb_should_notify(flags))
>   		return lmb_map_update_notify(base, size, MAP_OP_RESERVE);
> @@ -651,7 +651,7 @@ static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
>   			if (rgn < 0) {
>   				/* This area isn't reserved, take it */
>   				if (lmb_add_region_flags(&lmb.used_mem, base,
> -							 size, flags) < 0)
> +							 size, flags))
>   					return 0;
>   
>   				if (lmb_should_notify(flags)) {
> diff --git a/test/lib/lmb.c b/test/lib/lmb.c
> index b2c54fb4bcb8..c917115b7b66 100644
> --- a/test/lib/lmb.c
> +++ b/test/lib/lmb.c
> @@ -473,7 +473,7 @@ static int lib_test_lmb_overlapping_reserve(struct unit_test_state *uts)
>   
>   	/* allocate overlapping region should return the coalesced count */
>   	ret = lmb_reserve(0x40011000, 0x10000);
> -	ut_asserteq(ret, 1);
> +	ut_asserteq(ret, 0);
>   	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x11000,
>   		   0, 0, 0, 0);
>   	/* allocate 3nd region */
> @@ -748,13 +748,13 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
>   
>   	/* merge after */
>   	ret = lmb_reserve_flags(0x40020000, 0x10000, LMB_NOMAP);
> -	ut_asserteq(ret, 1);
> +	ut_asserteq(ret, 0);
>   	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x20000,
>   		   0, 0, 0, 0);
>   
>   	/* merge before */
>   	ret = lmb_reserve_flags(0x40000000, 0x10000, LMB_NOMAP);
> -	ut_asserteq(ret, 1);
> +	ut_asserteq(ret, 0);
>   	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40000000, 0x30000,
>   		   0, 0, 0, 0);
>   
> @@ -770,7 +770,7 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
>   
>   	/* test that old API use LMB_NONE */
>   	ret = lmb_reserve(0x40040000, 0x10000);
> -	ut_asserteq(ret, 1);
> +	ut_asserteq(ret, 0);
>   	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, 0x40000000, 0x30000,
>   		   0x40030000, 0x20000, 0, 0);
>   
> @@ -789,7 +789,7 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
>   
>   	/* merge with 2 adjacent regions */
>   	ret = lmb_reserve_flags(0x40060000, 0x10000, LMB_NOMAP);
> -	ut_asserteq(ret, 2);
> +	ut_asserteq(ret, 0);
>   	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 3, 0x40000000, 0x30000,
>   		   0x40030000, 0x20000, 0x40050000, 0x30000);
>   

-- 
// Caleb (they/them)

