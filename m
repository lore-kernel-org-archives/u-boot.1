Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CACBC02190
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 10:35:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0537D801A0;
	Thu, 30 Jan 2025 11:35:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yoxUlIrV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97C8C807C0; Thu, 30 Jan 2025 11:35:55 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E0E480137
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 11:35:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e460717039fso983006276.0
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 02:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738233352; x=1738838152; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Z+M/ZNbRv/+ZgaN2DKPiC4IWNLwDxHacY1oxv5IBPF0=;
 b=yoxUlIrVTaOeChwPt8ljtFlBxYasfC3+PMcIx2atk1VT7+dAOdJKOKHy/CHxu8CHHA
 M+h3f12yT2sSrM2ng5mn9sNqMnY/jkhwPgXO0rb6kokUv5Iqg6Mqlr5LBFSqtvzzOjKA
 TqwUu8UlyIi1cwrfzaptTqkZHZuHL4c9RLhsFFl+v2DuS6M6L6v/9CDkc/wf91spUyFd
 pNW3PvXckmZjUAFi/GozD4TNoq43GpQs3JBzhb/u5RkZxFfb975dN5Tvy2b20HvT6RuS
 KqtSiSwA7wb5R7mtpvLchtNfCQGt+PPsPXnCaYWQSn4oO91+XIy3K/nWe3pIG1e6Mtvp
 SUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738233352; x=1738838152;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z+M/ZNbRv/+ZgaN2DKPiC4IWNLwDxHacY1oxv5IBPF0=;
 b=cz7UD7oRBfQMcI2TGYkAyX4XoxeRHpFPHKfeW9fv71TBpa8fz0cqUtA5DavGEc14az
 e8+oqqwUKjisolulx+JjL4Cl6KJvFbbEGDwjWi4n5WZ0pl2ohZCIRtWEKuRUYBr3y+xI
 J46I9w0mm0T1+3m2rFED2cUk79risVXU1IA+ggPWL7Y7IaQSz3BivL1m/MwhY76VoSpW
 Nh+8NrtcEHTZ8bEKxZS9I7Tn6Kvr+pabE5jzGGNN0WC2aqEekNwwwZ0n4tmWAq32bGXg
 YV/XoB3fi42ZODLeCgbFLxFrh3kNuaMMfEK/r8FUABM0hMr3fZQcireXyZRmhl28hezI
 loKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVekYWb/y+0rGUbDSklBZMhEFkyLrb7jCDY+fN2goMi8cOtxX2EmkGV3UsiaMcpi2Z2GN+8Ic8=@lists.denx.de
X-Gm-Message-State: AOJu0YxsRVuIug2oOYgKGfT9UlngOCo0ZTT8UTAoTAjqhTHppg4Z9Xru
 6M+iZF3Y+NkfvQVQaUvMn/d7RtTADuXxADSbXSUl1OsugBlh1CuFAjcYv11VUrn/IESdWtjS8gV
 sTdAwBeW2UfCFICVp+mLKiTcCY+nPTfUZMymjlQ==
X-Gm-Gg: ASbGncuv42JF/jjCf8VhBaP4avqCP3YuLvYmTgb89vRUYN2Rvw6p4806hExm2iLJ4DJ
 bRP64S6oyGLGu3IGOVQ0lsDnKAcMbToN/KcwrPSis0lIxuSOjQGXhX/rdSP39bGA8gvITdUGC
X-Google-Smtp-Source: AGHT+IEegDwaMNQSMVJcTOrTGRHecbAHgTjgjUQCvNw6YWso5C0ZvPkn9CQ1PiXBVr/UwUuU4/t4HCjYwY2ih+00Ln4=
X-Received: by 2002:a05:6902:1582:b0:e54:bc9f:a7fe with SMTP id
 3f1490d57ef6-e58a4ac68afmr5693747276.20.1738233351814; Thu, 30 Jan 2025
 02:35:51 -0800 (PST)
MIME-Version: 1.0
References: <20250130072100.27297-1-ilias.apalodimas@linaro.org>
 <20250130072100.27297-2-ilias.apalodimas@linaro.org>
 <bc481af0-64f1-47f4-af19-1aba64c2ae6c@gmx.de>
In-Reply-To: <bc481af0-64f1-47f4-af19-1aba64c2ae6c@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 30 Jan 2025 12:35:16 +0200
X-Gm-Features: AWEUYZmqJ9Eo90_UJA-rspWaXOTXBmhpb1s49SiXYGcmaH83uGr_Iu5lxKdN9p4
Message-ID: <CAC_iWjKSFq-hhwzoxw9XMXj92fpmy1uz_J-kdqvYx0Ju6HcUMg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] meminfo: add memory details for armv8
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Richard Henderson <richard.henderson@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Michal Simek <michal.simek@amd.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, 
 maz@kernel.org, trini@konsulko.com, CFSworks@gmail.com
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

HI Heinrich

On Thu, 30 Jan 2025 at 12:01, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 1/30/25 07:20, Ilias Apalodimas wrote:
> > Upcoming patches are mapping memory with RO, RW^X etc permsissions.
> > Fix the meminfo command to display them properly
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >   arch/arm/cpu/armv8/cache_v8.c    | 18 +++++++++++++++++-
> >   arch/arm/include/asm/armv8/mmu.h |  2 ++
> >   cmd/meminfo.c                    |  5 +++++
> >   3 files changed, 24 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> > index 5d6953ffedd1..a4ca56c8ed42 100644
> > --- a/arch/arm/cpu/armv8/cache_v8.c
> > +++ b/arch/arm/cpu/armv8/cache_v8.c
> > @@ -421,7 +421,7 @@ static int count_ranges(void)
> >       return count;
> >   }
> >
> > -#define ALL_ATTRS (3 << 8 | PMD_ATTRINDX_MASK)
> > +#define ALL_ATTRS (3 << 8 | PMD_ATTRMASK)
> >   #define PTE_IS_TABLE(pte, level) (pte_type(&(pte)) == PTE_TYPE_TABLE && (level) < 3)
> >
> >   enum walker_state {
> > @@ -568,6 +568,17 @@ static void pretty_print_table_attrs(u64 pte)
> >   static void pretty_print_block_attrs(u64 pte)
> >   {
> >       u64 attrs = pte & PMD_ATTRINDX_MASK;
> > +     u64 perm_attrs = pte & PMD_ATTRMASK;
>
> The variable perm_attrs is not needed. You could use pte directly.
>
> > +
> > +     if ((perm_attrs & PTE_BLOCK_PXN) && (perm_attrs & PTE_BLOCK_UXN) &&
> > +         perm_attrs & PTE_BLOCK_RO)
> > +             printf("%-5s", " | RO");
> > +     else if ((perm_attrs & PTE_BLOCK_PXN) && (perm_attrs & PTE_BLOCK_UXN))
> > +             printf("%-5s", " | RW");
> > +     else if (perm_attrs & PTE_BLOCK_RO)
> > +             printf("%-5s", " | RX");
> > +     else
> > +             printf("%-5s", " | RWX");
>
> The string has 6 characters. "%-5s" does not match!

Ah thanks! That's the misalignment i was chasing

> As the string length is known using a length identifier is superfluous.
>
> It would be helpful to add descriptions to the flags in
> arch/arm/include/asm/armv8/mmu.h.
>
> https://documentation-service.arm.com/static/5efa1d23dbdee951c1ccdec5
> describes:
>
> "The Unprivileged Execute Never (UXN) and Privileged Execute Never (PXN)
> attributes can be set separately. This is used to prevent, for example,
> application code running with kernel privilege, or attempts to execute
> kernel code while in an unprivileged state."
>
> Shouldn't we show the values of UXN and PXN separately?

I had that on my initial patches. But then I decided it's too Arm
specific to print it.
I was hoping more archs would fix that so I preferred RO, RW, RX since
it's arch agnosticI don't mind re-adding it.

Thanks for taking a look!

Cheers
/Ilias
>
> E.g:
>
> printf("%s%s%s\",
>         pte & PTE_BLOCK_RO  ? " | RO " : "",
>         pte & PTE_BLOCK_PXN ? " | PXN" : "",
>         pte & PTE_BLOCK_UXN ? " | UXN" : "");
>
> Best regards
>
> Heinrich
>
> >
> >       switch (attrs) {
> >       case PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE):
> > @@ -1112,3 +1123,8 @@ void __weak enable_caches(void)
> >       icache_enable();
> >       dcache_enable();
> >   }
> > +
> > +void arch_dump_mem_attrs(void)
> > +{
> > +     dump_pagetable(gd->arch.tlb_addr, get_tcr(NULL, NULL));
> > +}
> > diff --git a/arch/arm/include/asm/armv8/mmu.h b/arch/arm/include/asm/armv8/mmu.h
> > index 0ab681c893d3..6af8cd111a44 100644
> > --- a/arch/arm/include/asm/armv8/mmu.h
> > +++ b/arch/arm/include/asm/armv8/mmu.h
> > @@ -66,6 +66,7 @@
> >   #define PTE_BLOCK_NG                (1 << 11)
> >   #define PTE_BLOCK_PXN               (UL(1) << 53)
> >   #define PTE_BLOCK_UXN               (UL(1) << 54)
> > +#define PTE_BLOCK_RO            (UL(1) << 7)
> >
> >   /*
> >    * AttrIndx[2:0]
> > @@ -75,6 +76,7 @@
> >   #define PMD_ATTRMASK                (PTE_BLOCK_PXN          | \
> >                                PTE_BLOCK_UXN          | \
> >                                PMD_ATTRINDX_MASK      | \
> > +                              PTE_BLOCK_RO           | \
> >                                PTE_TYPE_VALID)
> >
> >   /*
> > diff --git a/cmd/meminfo.c b/cmd/meminfo.c
> > index 5e83d61c2dd3..3915e2bbb268 100644
> > --- a/cmd/meminfo.c
> > +++ b/cmd/meminfo.c
> > @@ -15,6 +15,10 @@
> >
> >   DECLARE_GLOBAL_DATA_PTR;
> >
> > +void __weak arch_dump_mem_attrs(void)
> > +{
> > +}
> > +
> >   static void print_region(const char *name, ulong base, ulong size, ulong *uptop)
> >   {
> >       ulong end = base + size;
> > @@ -54,6 +58,7 @@ static int do_meminfo(struct cmd_tbl *cmdtp, int flag, int argc,
> >
> >       puts("DRAM:  ");
> >       print_size(gd->ram_size, "\n");
> > +     arch_dump_mem_attrs();
> >
> >       if (!IS_ENABLED(CONFIG_CMD_MEMINFO_MAP))
> >               return 0;
>
