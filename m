Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EECDC0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 09:11:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B26EA82076;
	Thu, 30 Jan 2025 10:11:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pOYXnsVJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BEF382072; Thu, 30 Jan 2025 10:11:55 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E15A28201E
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 10:11:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-436a03197b2so3270395e9.2
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 01:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738228312; x=1738833112; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yWjMSR6yDOdvZAPMdevg3uebsMGMW1mPt290CVWVVmA=;
 b=pOYXnsVJCEaNgNrNofJsFdT7sL2pLTHKW3svpsOynXG9onxtqivtNQvqb73tm0VdVy
 bS8OkVw6ghH6mNlzz1hgk5/9x1RhueV/mpiwuepzjkNa84tY5wUElIc5+08L67H9e0LH
 E+R1+nRohuGmmL9RpvNrm0P5sPV6PYB8VRZpJSz2CQnDBI+HKyD30IIWJuOGfvDJo8cH
 xL+i3TK09Cm10RyxKR/WqZEO2oBfD57cxVnQ6bod5nm7dC8ZH3lX8tXdHsE8KiehzhHy
 j6TB9z/2vGExEizJYWNrrV5Mp9JBqWaaZBDDrtju0UdbWZHpUyaOttUtUO9QBpUNDGty
 OkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738228312; x=1738833112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yWjMSR6yDOdvZAPMdevg3uebsMGMW1mPt290CVWVVmA=;
 b=eEg7IdltcCkWLbDbrQldg9541MXF009REhFgzPYuvBgY2mDtw/hoYYytB8qZ0AnOAl
 ZBNLSqpnVOFFP2Rj1oMEFRwcv0zrSv+JZY7pPc6yut+nMMXzIP+aagiyjR2Sad84ZBnM
 8JtLAkHO+mAGLKwc7SNN327XWp8wBdaeQMbGQRT4QQJbas3XR0BQRxZ1dt66IeudHEB3
 l4+xGk0oNGGY1vy9oU6mPiDYdJ6II2gd6pb2KzhgKZL6bf7xr8aFKIfxCN7mB5K4Zrlk
 zha/Xm0m6D3dxQo+XSyV23Td1tTRkau6LIrEY5yhNJpHMzPXZYGgoh3vfifs5Toj7C9Q
 te7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUgqSZnYfSo5bLV6yd85dDv6IJeEqQZgh4LxCHBf+HfD1LZNNJNCcuN13voR9jS9XvRQLwBQ8=@lists.denx.de
X-Gm-Message-State: AOJu0YxcIGP+TWHa3ql3XxD+KWLQQNx76Ksomkii8C9Myl6HPTLTT8DV
 uCwIpIDX2ex4qkvxq+kMSnR6u3hZbSQ97oRDaREPlQ6+p4cKrGquK8s0QKjDXVE=
X-Gm-Gg: ASbGncuRzpsDuP+x1rKAis1ksriG3jwp0EgI0kQm49y7MNufT7ga5tkz+ElbZOfB3OM
 iPF28G/IFi7wCm9rho32d8R/RBjYdsyMMxLq8l6+HoD0JFTaFSlwtIw7NAziTGZRYlelwmms5OD
 0T7QA1S+7KuER+YZ1hEQ73BKTcAbY0sUTs6kX6SJXuQmnzoYgZvszpelxrdN9u9Qg3+e0fPoaRw
 0YmT/WiyDSJWROUSYdYPNzDNcNSVBOIuB0l4gDdf06Ue9VKL/9SvIHpn6LJjIYEE7vEWiwkgAXK
 4xSo6xYKlS0DpZYftzWmQGhQjyt+aiEpI1AV9lN99ESNc60UKQhiQZVsGYzT1KX2qW6jhhI=
X-Google-Smtp-Source: AGHT+IEE3pBJdS+5oAqMOTD6ynPMjmSkQ8KPX6hY2pYr1kjtwPrVe0eX0+YzBfb0/Q2VgVElPEbh4Q==
X-Received: by 2002:a05:600c:468e:b0:436:fb02:e68 with SMTP id
 5b1f17b1804b1-438dc3a81ecmr58690175e9.2.1738228312260; 
 Thu, 30 Jan 2025 01:11:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:14f6:2931:46df:28c5?
 ([2a01:e0a:3cb:7bb0:14f6:2931:46df:28c5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81a39sm50803455e9.35.2025.01.30.01.11.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 01:11:52 -0800 (PST)
Message-ID: <2d16982b-1f7e-4fca-817c-d929ec3f598a@linaro.org>
Date: Thu, 30 Jan 2025 10:11:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/4] arm64: mmu_change_region_attr() add an option not
 to break PTEs
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, maz@kernel.org,
 trini@konsulko.com, CFSworks@gmail.com
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?=
 <ptosi@google.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Michal Simek
 <michal.simek@amd.com>, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250130072100.27297-1-ilias.apalodimas@linaro.org>
 <20250130072100.27297-4-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250130072100.27297-4-ilias.apalodimas@linaro.org>
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

Hi Ilias,

On 1/30/25 08:20, Ilias Apalodimas wrote:
> The ARM ARM on section 8.17.1 describes the cases where
> break-before-make is required when changing live page tables.
> Since we can use this function to tweak block and page permssions,
> where BBM is not required add an extra argument to the function.
> 
> While at it add a function we can use to change the attributes of normal
> memory without breaking the pages tables first
> 
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  arch/arm/cpu/armv8/cache_v8.c           | 27 ++++++++++++++++++++++++-
>  arch/arm/cpu/armv8/fsl-layerscape/cpu.c | 10 ++++-----
>  arch/arm/include/asm/system.h           |  3 ++-
>  arch/arm/mach-snapdragon/board.c        |  2 +-
>  4 files changed, 34 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index a4ca56c8ed42..60d0870013e8 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -968,11 +968,14 @@ void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
>   * The procecess is break-before-make. The target region will be marked as
>   * invalid during the process of changing.
>   */
> -void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs)
> +void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs, bool bbm)
>  {
>  	int level;
>  	u64 r, size, start;
>  
> +	if (!bbm)
> +		goto skip_bbm;
> +
>  	start = addr;
>  	size = siz;
>  	/*
> @@ -997,6 +1000,7 @@ void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs)
>  			   gd->arch.tlb_addr + gd->arch.tlb_size);
>  	__asm_invalidate_tlb_all();
>  
> +skip_bbm:
>  	/*
>  	 * Loop through the address range until we find a page granule that fits
>  	 * our alignment constraints, then set it to the new cache attributes
> @@ -1020,6 +1024,27 @@ void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs)
>  	__asm_invalidate_tlb_all();
>  }
>  
> +void mmu_set_attrs(phys_addr_t addr, size_t size, int type)

type should be an enum

> +{
> +	u64 attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_INNER_SHARE | PTE_TYPE_VALID;
> +
> +	switch (type) {
> +	case 1:
> +	/* RO */
> +		attrs |= PTE_BLOCK_PXN | PTE_BLOCK_UXN | PTE_BLOCK_RO;
> +		break;
> +	case 2:
> +		/* RX */
> +		attrs |= PTE_BLOCK_RO;
> +		break;
> +	case 3:
> +		/* RW */
> +		attrs |= PTE_BLOCK_PXN | PTE_BLOCK_UXN;
> +	}
> +
> +	mmu_change_region_attr(addr, size, attrs, false);
> +}
> +
>  #else	/* !CONFIG_IS_ENABLED(SYS_DCACHE_OFF) */
>  
>  /*
> diff --git a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
> index d2d3e346a36f..caf1dab05936 100644
> --- a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
> +++ b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
> @@ -1573,7 +1573,7 @@ void update_early_mmu_table(void)
>  					PTE_BLOCK_MEMTYPE(MT_NORMAL)	|
>  					PTE_BLOCK_OUTER_SHARE		|
>  					PTE_BLOCK_NS			|
> -					PTE_TYPE_VALID);
> +					PTE_TYPE_VALID, true);
>  	} else {
>  		mmu_change_region_attr(
>  					CFG_SYS_SDRAM_BASE,
> @@ -1581,7 +1581,7 @@ void update_early_mmu_table(void)
>  					PTE_BLOCK_MEMTYPE(MT_NORMAL)	|
>  					PTE_BLOCK_OUTER_SHARE		|
>  					PTE_BLOCK_NS			|
> -					PTE_TYPE_VALID);
> +					PTE_TYPE_VALID, true);
>  #ifdef CONFIG_SYS_DDR_BLOCK3_BASE
>  #ifndef CONFIG_SYS_DDR_BLOCK2_SIZE
>  #error "Missing CONFIG_SYS_DDR_BLOCK2_SIZE"
> @@ -1594,7 +1594,7 @@ void update_early_mmu_table(void)
>  					PTE_BLOCK_MEMTYPE(MT_NORMAL)	|
>  					PTE_BLOCK_OUTER_SHARE		|
>  					PTE_BLOCK_NS			|
> -					PTE_TYPE_VALID);
> +					PTE_TYPE_VALID, true);
>  			mmu_change_region_attr(
>  					CONFIG_SYS_DDR_BLOCK3_BASE,
>  					gd->ram_size -
> @@ -1603,7 +1603,7 @@ void update_early_mmu_table(void)
>  					PTE_BLOCK_MEMTYPE(MT_NORMAL)	|
>  					PTE_BLOCK_OUTER_SHARE		|
>  					PTE_BLOCK_NS			|
> -					PTE_TYPE_VALID);
> +					PTE_TYPE_VALID, true);
>  		} else
>  #endif
>  		{
> @@ -1614,7 +1614,7 @@ void update_early_mmu_table(void)
>  					PTE_BLOCK_MEMTYPE(MT_NORMAL)	|
>  					PTE_BLOCK_OUTER_SHARE		|
>  					PTE_BLOCK_NS			|
> -					PTE_TYPE_VALID);
> +					PTE_TYPE_VALID, true);
>  		}
>  	}
>  }
> diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
> index dbf9ab43e280..0a8ca19e45e9 100644
> --- a/arch/arm/include/asm/system.h
> +++ b/arch/arm/include/asm/system.h
> @@ -287,8 +287,9 @@ void flush_l3_cache(void);
>   * @emerg: Also map the region in the emergency table
>   */
>  void mmu_map_region(phys_addr_t start, u64 size, bool emerg);
> -void mmu_change_region_attr(phys_addr_t start, size_t size, u64 attrs);
> +void mmu_change_region_attr(phys_addr_t start, size_t size, u64 attrs, bool bbm);
>  
> +void mmu_set_attrs(phys_addr_t addr, size_t size, int type);
>  /*
>   * smc_call() - issue a secure monitor call
>   *
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 2ef936aab757..13f4e8e640ef 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -577,7 +577,7 @@ static void carve_out_reserved_memory(void)
>  		if (i == count || start + size < res[i].start - SZ_2M) {
>  			debug("  0x%016llx - 0x%016llx: reserved\n",
>  			      start, start + size);
> -			mmu_change_region_attr(start, size, PTE_TYPE_FAULT);
> +			mmu_change_region_attr(start, size, PTE_TYPE_FAULT, true);
>  			/* If this is the final region then quit here before we index
>  			 * out of bounds...
>  			 */
