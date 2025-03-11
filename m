Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B95C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 18:38:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E16E881870;
	Tue, 11 Mar 2025 19:37:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B743080F9C; Tue, 11 Mar 2025 19:31:05 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 397F0801FB
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 19:31:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 572A52B;
 Tue, 11 Mar 2025 11:31:13 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 796E33F694;
 Tue, 11 Mar 2025 11:30:57 -0700 (PDT)
Date: Tue, 11 Mar 2025 18:30:54 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, mark.kettenis@xs4all.nl, Alexey Brodkin
 <alexey.brodkin@synopsys.com>, Eugeniy Paltsev
 <Eugeniy.Paltsev@synopsys.com>, Tom Rini <trini@konsulko.com>, Huan Wang
 <alison.wang@nxp.com>, Angelo Dureghello <angelo@kernel-space.org>, Thomas
 Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, Marek Vasut <marex@denx.de>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Max Filippov <jcmvbkbc@gmail.com>, Simon Glass
 <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, Caleb Connolly
 <caleb.connolly@linaro.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, =?UTF-8?B?UGllcnJlLUNsw6ltZW50?= Tosi
 <ptosi@google.com>, Richard Henderson <richard.henderson@linaro.org>, Sam
 Edwards <CFSworks@gmail.com>, Peter Hoyes <Peter.Hoyes@arm.com>, Patrick
 Rudolph <patrick.rudolph@9elements.com>, Mayuresh Chitale
 <mchitale@ventanamicro.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Alex Shumsky <alexthreed@gmail.com>, Joshua Watt
 <jpewhacker@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>, Evgeny
 Bachinin <EABachinin@salutedevices.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Michal Simek <michal.simek@amd.com>, Rasmus
 Villemoes <rasmus.villemoes@prevas.dk>, Jonas Jelonek
 <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v4 4/6] arm64: mmu_change_region_attr() add an option
 not to break PTEs
Message-ID: <20250311183054.38dc735e@donnerap.manchester.arm.com>
In-Reply-To: <20250301164922.397441-5-ilias.apalodimas@linaro.org>
References: <20250301164922.397441-1-ilias.apalodimas@linaro.org>
 <20250301164922.397441-5-ilias.apalodimas@linaro.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 11 Mar 2025 19:37:25 +0100
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

On Sat,  1 Mar 2025 18:49:02 +0200
Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:

Hi Ilias,

> The ARM ARM on section 8.17.1 describes the cases where

Thanks for referencing the ARM ARM! The section name would be D8.17.1, and
please mention the version of the document, since the numbering is not
stable across the different releases. So something like:

The ARM ARM (Rev L.a) in section D8.17.1 ("Using break-before-make when
updating translation table entries") ...

> break-before-make is required when changing live page tables.
> Since we can use this function to tweak block and page permssions,
> where BBM is not required add an extra argument to the function.

It looks like one of the two existing users of this function (the
snapdragon code) just calls this function with attr=PTE_TYPE_FAULT, so
that would not need to call the full BBM version.
The Layerscape code indeed requires it, though.

> While at it add a function description.

I think these sentences describe the v2 and older, but don't fit the
current patch anymore.

> 
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  arch/arm/cpu/armv8/cache_v8.c | 48 ++++++++++++++++++++---------------
>  arch/arm/include/asm/system.h | 18 +++++++++++++
>  2 files changed, 46 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index c4b3da4a8da7..29100913bc82 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -967,61 +967,69 @@ void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
>  	flush_dcache_range(real_start, real_start + real_size);
>  }
>  
> -/*
> - * Modify MMU table for a region with updated PXN/UXN/Memory type/valid bits.
> - * The procecess is break-before-make. The target region will be marked as
> - * invalid during the process of changing.
> - */
> -void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs)
> +void mmu_change_region_attr_nobreak(phys_addr_t addr, size_t siz, u64 attrs)
>  {
>  	int level;
>  	u64 r, size, start;
>  
> -	start = addr;
> -	size = siz;
>  	/*
>  	 * Loop through the address range until we find a page granule that fits
> -	 * our alignment constraints, then set it to "invalid".
> +	 * our alignment constraints, then set it to the new cache attributes

It's not cache attributes (those would require BBM), but "permissions" or
just attributes.

Otherwise this looks correct, just changing the permission indeed does not
require BBM, so it's just the comment and the commit message that might
need changing. And clever function split up!

Cheers,
Andre

>  	 */
> +	start = addr;
> +	size = siz;
>  	while (size > 0) {
>  		for (level = 1; level < 4; level++) {
> -			/* Set PTE to fault */
> -			r = set_one_region(start, size, PTE_TYPE_FAULT, true,
> -					   level);
> +			/* Set PTE to new attributes */
> +			r = set_one_region(start, size, attrs, true, level);
>  			if (r) {
> -				/* PTE successfully invalidated */
> +				/* PTE successfully updated */
>  				size -= r;
>  				start += r;
>  				break;
>  			}
>  		}
>  	}
> -
>  	flush_dcache_range(gd->arch.tlb_addr,
>  			   gd->arch.tlb_addr + gd->arch.tlb_size);
>  	__asm_invalidate_tlb_all();
> +}
> +
> +/*
> + * Modify MMU table for a region with updated PXN/UXN/Memory type/valid bits.
> + * The procecess is break-before-make. The target region will be marked as
> + * invalid during the process of changing.
> + */
> +void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs)
> +{
> +	int level;
> +	u64 r, size, start;
>  
> +	start = addr;
> +	size = siz;
>  	/*
>  	 * Loop through the address range until we find a page granule that fits
> -	 * our alignment constraints, then set it to the new cache attributes
> +	 * our alignment constraints, then set it to "invalid".
>  	 */
> -	start = addr;
> -	size = siz;
>  	while (size > 0) {
>  		for (level = 1; level < 4; level++) {
> -			/* Set PTE to new attributes */
> -			r = set_one_region(start, size, attrs, true, level);
> +			/* Set PTE to fault */
> +			r = set_one_region(start, size, PTE_TYPE_FAULT, true,
> +					   level);
>  			if (r) {
> -				/* PTE successfully updated */
> +				/* PTE successfully invalidated */
>  				size -= r;
>  				start += r;
>  				break;
>  			}
>  		}
>  	}
> +
>  	flush_dcache_range(gd->arch.tlb_addr,
>  			   gd->arch.tlb_addr + gd->arch.tlb_size);
>  	__asm_invalidate_tlb_all();
> +
> +	mmu_change_region_attr_nobreak(addr, siz, attrs);
>  }
>  
>  #else	/* !CONFIG_IS_ENABLED(SYS_DCACHE_OFF) */
> diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
> index 091082281c73..849b3d0efb7a 100644
> --- a/arch/arm/include/asm/system.h
> +++ b/arch/arm/include/asm/system.h
> @@ -303,8 +303,26 @@ void flush_l3_cache(void);
>   * @emerg: Also map the region in the emergency table
>   */
>  void mmu_map_region(phys_addr_t start, u64 size, bool emerg);
> +
> +/**
> + * mmu_change_region_attr() - change a mapped region attributes
> + *
> + * @start: Start address of the region
> + * @size:  Size of the region
> + * @aatrs: New attributes
> + */
>  void mmu_change_region_attr(phys_addr_t start, size_t size, u64 attrs);
>  
> +/**
> + * mmu_change_region_attr_nobreak() - change a mapped region attributes without doing
> + *                                    break-before-make
> + *
> + * @start: Start address of the region
> + * @size:  Size of the region
> + * @aatrs: New attributes
> + */
> +void mmu_change_region_attr_nobreak(phys_addr_t addr, size_t size, u64 attrs);
> +
>  /*
>   * smc_call() - issue a secure monitor call
>   *

