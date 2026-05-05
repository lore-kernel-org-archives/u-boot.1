Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED3ECD342F
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 09:59:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61B078486B;
	Tue,  5 May 2026 11:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f6/ZdOaH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB09284877; Tue,  5 May 2026 11:59:22 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CE72846D5
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 11:59:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 64B546012B;
 Tue,  5 May 2026 09:59:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691B8C2BCB4;
 Tue,  5 May 2026 09:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777975159;
 bh=n+MaJebMAPTtmdUGF5zptnJY6g2KWgyUiJ1JCfiGwRM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f6/ZdOaHSESH+CXeERImIdGciKuNC5TzERhbtv3MV5A/kgqtpxb3aTt6S8JNOYkKD
 zLdgW/CvJZbffafrlBSTtooO6HA7/oR5+8cIJbsuPtsDMR3eexavSLMiudwtOwKvCa
 c4ZyuwyrRH3eESxruD9UUc3Y2UOLZNeOMadw8AMlmixKk+wuSpp4Ls+1zvzPzoJxSq
 CkxPEAs9ammI1pqcVNQikxLobp7f9gLQKcbbFI4PYkIVuJH58FMX4x+EkI5wQeTHXH
 MYtq9yvAxsHv4U5eCSDhlw2XZYkqLLvW4yIyIk0At0yZ1cyPrcAGnkeZjjwJaX+eUH
 S72Ue/6e/KJ9g==
Date: Tue, 5 May 2026 15:29:13 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Anshul Dalal <anshuld@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH] armv8: mmu: support unmapping regions with
 set_one_region()
Message-ID: <afm_cdgq-bXwcLLn@sumit-xelite>
References: <20260504175511.585797-1-casey.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504175511.585797-1-casey.connolly@linaro.org>
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

On Mon, May 04, 2026 at 07:53:54PM +0200, Casey Connolly wrote:
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
>  arch/arm/cpu/armv8/cache_v8.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Nice optimization, FWIW:

Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Tested-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index 39479df7b21f..b1a1fd571341 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
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
> +		*pte &= ~PMD_ATTRMASK;
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
> -- 
> 2.53.0
> 
