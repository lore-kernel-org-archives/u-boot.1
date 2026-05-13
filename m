Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8CACD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 12:17:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89BD284099;
	Wed, 13 May 2026 14:17:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nZGdJFzH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCD748460C; Wed, 13 May 2026 14:17:48 +0200 (CEST)
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A111836AC
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 14:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-65c3ea2ebf7so7161645d50.0
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 05:17:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778674664; cv=none;
 d=google.com; s=arc-20240605;
 b=OSmqgql+tda5MrSQOsvRGcynkT8tJ6KfwHhIY8udn4XAmv4P6T1t54oPOXzn7/Cpzi
 D+OlDVdOAV4VRkeEUSP8uduRyByYSu1t6rJcPlVykp4TIMNJgaku+KOhOdMtq/pQVbxE
 J0MyzirHOohGNet5ItUvY4ICtownofjmGMu7fVxVevesimdkwB/V4lxTF8IXt8gUVtYr
 IPTIhnT3oirpybFSwiKjqBSu6qBV+zwpCBoapDuphfK5GNFkGjGPo0KMve2yrkJXQJEW
 hG+kLfw3bLx0I2iK9FGaHikaLWpkuYkFR7MBHxcuKKzrC+H+3lQX1/GjAWYHf2KQ1s7L
 15ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=G/EiQfJ3eJr6HO5ETSZrWbtO3leAuSMyzGbjnvaVWN8=;
 fh=afdFkhg+X0dJedjeczr8qfrLvDZpz9MX/GqWAgIgc5U=;
 b=M0DST6oXykXDFTxPeUtOOQkYnidS7psmzHhaX3pcbHh1e9mTBmkwzt629EX5+oRw38
 URPtjVWs688ZigG3E8Svo1XgVZS6Hm9zc8PJgxp+EdUAEYKLyrNlwMeVxNmQZBhgS9jq
 ljaODslWnlUK8arAcNvK9ynyowkk4avMKOoFImbvtyAXmQuUD32Az32jIH0E73c2tThU
 YHRviY9YEa5KEjq5KJJDy3q2XVcogg7JpqOObNZGQC/6H6JMq7yiPvGLxEe+5cSsSMmk
 fZFN0hU8mTav/ktQ0Fk7JoLdACg2qFXKkFgGYsJkiLIrCjTPGCedshjY3/4BsEnq5l2h
 G8DA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778674664; x=1779279464; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G/EiQfJ3eJr6HO5ETSZrWbtO3leAuSMyzGbjnvaVWN8=;
 b=nZGdJFzH2yS7LTO5OiKldNYf2As4W+ShMX2f5ETqXtc9UaP8zDST89t9sjlF6w70v2
 y2ZZOSRMjUyWU1vs2ntKcYyECppHTD4gCi9wMIIQuQlsQayDQ9+2tMEOsjwHFDxihFeU
 LaxWOtLJRKthoUujcWqP0yH5oUjoY4R0p+w9m4N1QJUIJO0WOwyv2npUjD5ZbG9j2w92
 gMUagOplvDpg0xN83i1N/zU4WgcDaH17SycSK90YhTNr10PIj6gSgu3zEePIXfTJUlla
 aJ5s1H31DLXj9LH3lTv818tHk3vBwEWqKhxrBPTa56X9iySTn/st8NmlGFmWxzUDIugD
 rZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778674664; x=1779279464;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G/EiQfJ3eJr6HO5ETSZrWbtO3leAuSMyzGbjnvaVWN8=;
 b=ZCLU2bbB5o6F7g7QZyS73MXr1bRBYNwdnZDRTLxSVLUluQbEXDBdOEXjuHQVeVBruS
 /SkGaNq7LOXqz0LNXN3U/R/XCGNcLRZUfPB1ACXqjEJlI/vKfm5Is8RaNaYg1CCX7ENL
 HhI4aaovKbVYShhHRcs3kKclxCcP8buOAJZUWsZGrq4t6eQarqujS8bWe6SvFevZfHzx
 2zgU/JJQ04uqsrOdcBV5qSZ3mkuGU8+74b9AbNRuIlz0278dDFIJsl1LtuPynq/jKsFY
 NLJoazLeAk2hlNzrIlL1HEEq5T330bCLuo9gxtvimeUnmBMs9EnHq8VlSvUjvBeHDlgN
 JkdQ==
X-Gm-Message-State: AOJu0YwrWln4zWFq6ydjcvg+9+hwVWwIhm1DRjzf3KxmiL79ABeDoF3i
 FbJtxyaOxUqvZdXeXGS5vSqiBvdUtNpyxVDh56QxNxXBrFNfl111GXXn/AmsY8y4T8hPme+RK6C
 NeT2zd+jhIuSobMVzm+s34mqfMeKWF+bJYW3k2+djf8LuLEvRHg+9dKU=
X-Gm-Gg: Acq92OH8a9eDToc7EJ43+hVJDr5spkQDlXBSTmc6xQgpe52PFjAQoE7m48O2ajjROnT
 IdZN0EbOFYwjtiM9Q1LMLempqe9u9dt2pFQ3hW5frq6aXoXDDAgyvFX1C7onht5rA9gfvuesZ3K
 m8Ol+qUH9vDjzlftjOXH7vkXnjUVdV+PzQTQKCavmwW7pJAi67oxnLf5mMVWHCL6wbrlcl9A6bC
 ggVkAn/hjI5Y3lfBUJezCaLyQhJst+MX3U7Yzw+k8jc89LMCLHEWomThk/Cyy9fgsr6y0YWCshl
 mZnNo92/TJjNonqwRWlE7nvkEjIBLW8um3Sh/W/VW47Q/kmjPvWS6Kplp6uNJezFtf3gCItzq6K
 ZCuNSrUZQV094PLt9lcb1m8moHLo1oRMm0xRUFTwWChYL+PEibCF3otJvxa15znOHKX8jBXh+NX
 UOdXYtT1yNlCCmx7DqcAJXgGxiamc/f5tKTSW7oz2SInbFfY1JQd02l67DG/UKaabvqdCQmS5P2
 e4zk9AHqVsj3IjzZ8LKuNyjlev5i9IS++m3YXYGLlIdvGA2hDxU0Z4clh4v0cCm24tUq+Jefsp4
 sFyst7uAJL3G0iAHajvHp89vHSwdqPo7FgaIRpq5JgO5AfqK67lPISKwdYf/G8WDvHw1TDnS1DG
 BGicpgw==
X-Received: by 2002:a53:a4cd:0:b0:652:53cc:dfb3 with SMTP id
 956f58d0204a3-65df63d3eccmr2241494d50.52.1778674663855; Wed, 13 May 2026
 05:17:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-b4-mmu-unmap-fixes-v4-0-fab802f647c9@linaro.org>
 <20260512-b4-mmu-unmap-fixes-v4-4-fab802f647c9@linaro.org>
 <CAC_iWjKgQhx2G1hpjBSzqKE0QJmuGFNoiMWE5=JNZaJvcA-9HQ@mail.gmail.com>
In-Reply-To: <CAC_iWjKgQhx2G1hpjBSzqKE0QJmuGFNoiMWE5=JNZaJvcA-9HQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 13 May 2026 15:17:07 +0300
X-Gm-Features: AVHnY4LpeUeDxKRYW3YkUjhzHetno54fWArkdmeIFNihgj8EOObo2rts01J2xVw
Message-ID: <CAC_iWjJi-cD+UkO5Z5_hMCRE01DeXv8o9gTtJH8mreu5b1xxPA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] armv8: mmu: fix and optimise explicitly unmapping
 regions
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

Replying to myself here, but as we discussed in private the *pte &=
~0; is basically a nop as well

Cheers
/Ilias

On Wed, 13 May 2026 at 14:57, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Casey,
>
> On Tue, 12 May 2026 at 14:13, Casey Connolly <casey.connolly@linaro.org> wrote:
> >
> > As more platforms start ensuring they explicitly unmap reserved-memory
> > regions a few issues have appeared with how the existing dynamic mapping
> > code works. Fix these and get a small optimisation as well.
> >
> > 1. Teach pte_type() to actually respect the PTE_TYPE_VALID bit
> > 2. Don't walk the TLB a second time if we call mmu_change_region_attr()
> >    with PTE_TYPE_FAULT (since it would just be a slow nop)
> > 3. Fix how set_one_region() decides to split blocks.
> >
> > Today set_one_region() will always split blocks until it reaches the
> > smallest granule size (4k) and then update all of these pages. This
> > appears to be due to a big in how is_aligned() is implemented, since
> > it only evaluates to true if addr and size are both multiples of the
> > current granule size, so a mapping aligned to 2M which is 4M in size
> > will cleanly result in 2 blocks being set, but a mapping aligned to
> > 2M which is 4M + 8k in size will result in blocks being split and 1026
> > individual pages being set.
> >
> > While for the address it is correct to enforce that it is aligned to
> > the current granule size, we only need to check if the region size is
> > greater than the current granule size. This allows us to simplify our
> > second example above to only 4 entries being updated (assuming no blocks
> > have to be split) since we only need to update 2 blocks to map the first
> > 4M, drastically improving the best-case performance.
> >
> > In the case where the address is 4k aligned rather than 2M aligned we
> > will still be restricted to mapping 4k pages until we reach 2M alignment
> > where we could then map a larger 2M granule which previously would never
> > happen.
> >
> > Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> > ---
> >  arch/arm/cpu/armv8/cache_v8.c | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> > index e9ce6335ee9e..bcfc36603adb 100644
> > --- a/arch/arm/cpu/armv8/cache_v8.c
> > +++ b/arch/arm/cpu/armv8/cache_v8.c
> > @@ -162,9 +162,9 @@ u64 get_tcr(u64 *pips, u64 *pva_bits)
> >  #define MAX_PTE_ENTRIES 512
> >
> >  static int pte_type(u64 *pte)
> >  {
> > -       return *pte & PTE_TYPE_MASK;
> > +       return *pte & PTE_TYPE_VALID ? *pte & PTE_TYPE_MASK : PTE_TYPE_FAULT;
> >  }
> >
> >  /* Returns the LSB number for a PTE on level <level> */
> >  static int level2shift(int level)
> > @@ -980,11 +980,12 @@ u64 *__weak arch_get_page_table(void) {
> >
> >         return NULL;
> >  }
> >
> > +/* Checks if the current PTE is an aligned subset of the region */
> >  static bool is_aligned(u64 addr, u64 size, u64 align)
> >  {
> > -       return !(addr & (align - 1)) && !(size & (align - 1));
> > +       return !(addr & (align - 1)) && size >= align;
> >  }
> >
> >  /* Use flag to indicate if attrs has more than d-cache attributes */
> >  static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
> > @@ -992,11 +993,16 @@ static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
> >         int levelshift = level2shift(level);
> >         u64 levelsize = 1ULL << levelshift;
> >         u64 *pte = find_pte(start, level);
> >
> > -       /* Can we can just modify the current level block PTE? */
> > +       /* Can we can just modify the current level block/page? */
> >         if (is_aligned(start, size, levelsize)) {
> > -               if (flag) {
> > +               if (attrs == PTE_TYPE_FAULT) {
> > +                       if (pte_type(pte) == PTE_TYPE_TABLE)
>
> The code will still unmap the wrong regions here. One easy to way to
> reprod this is apply this for QEMU, enabme meminfo and have a look at
> the output.
>
> index 38f0ec5f2fbb..c001ccca878d 100644
> --- a/board/emulation/qemu-arm/qemu-arm.c
> +++ b/board/emulation/qemu-arm/qemu-arm.c
> @@ -114,6 +114,7 @@ int board_late_init(void)
>         if (CONFIG_IS_ENABLED(USB_KEYBOARD))
>                 usb_init();
>
> +       mmu_change_region_attr(0x50100000, 0x200000, PTE_TYPE_FAULT);
>         return 0;
>  }
>
> So, what I think is happening is that pte_type() doesn't take the
> level into account. But For L3 entries PTE_TYPE_TABLE (which is really
> PTE_TYPE_PAGE for that level) will alway be true on level 3.
>
> Cheers
> /Ilias
>
> /Ilias
> > +                               *pte &= ~0;
> > +                       else
> > +                               *pte &= ~(PMD_ATTRMASK | PTE_TYPE_MASK | PTE_BLOCK_INNER_SHARE);
> > +               } else if (flag) {
> >                         *pte &= ~PMD_ATTRMASK;
> >                         *pte |= attrs & PMD_ATTRMASK;
> >                 } else {
> >                         *pte &= ~PMD_ATTRINDX_MASK;
> > @@ -1097,8 +1103,12 @@ void mmu_change_region_attr(phys_addr_t addr, size_t size, u64 attrs)
> >         flush_dcache_range(gd->arch.tlb_addr,
> >                            gd->arch.tlb_addr + gd->arch.tlb_size);
> >         __asm_invalidate_tlb_all();
> >
> > +       /* If we were unmapping a region then we have nothing to make and can return. */
> > +       if (attrs == PTE_TYPE_FAULT)
> > +               return;
> > +
> >         mmu_change_region_attr_nobreak(addr, size, attrs);
> >  }
> >
> >  int pgprot_set_attrs(phys_addr_t addr, size_t size, enum pgprot_attrs perm)
> >
> > --
> > 2.53.0
> >
