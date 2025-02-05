Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7BDC02194
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:21:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0D4A80F12;
	Wed,  5 Feb 2025 14:15:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XQGH/FPA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2131180207; Wed,  5 Feb 2025 11:32:57 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0B4280040
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 11:32:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e46ebe19489so5283803276.2
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 02:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738751573; x=1739356373; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YPmb8SKv0xShH3E5G4Ya8r79thKUsfgv5+ZiQR3y/eQ=;
 b=XQGH/FPAFakLJTUwwgOg6t5ZzJG83F7eEp8YhntTtrrJ5qT4W6FgadSQ8spaT8sg9V
 3oII/mIfRvnkHfZ5qqF3DTCVsczTd/wGfyD4tCMnnp/Pyu+S+PyoaNEc0ASoJDbBEbMw
 lsqxsfD5lOvvOzZQbzCLLykyfsRL5hQWk6UgDK8w3NBvpwwFUOZ8z+ZF8t39uZ5uIr59
 UlRuwYhyf2/8+PRHP6/jXL1MtipkcwqNzd5E8qGstzfdTZKlUKmE/8DpuCxc9mMHve2k
 Ap/+2wlkv+6PYk1O4P491luAFgYAKNttFJ33P7suSzBq8JIhPeyravfxZ0BsgKFk4S6Q
 XFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738751573; x=1739356373;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YPmb8SKv0xShH3E5G4Ya8r79thKUsfgv5+ZiQR3y/eQ=;
 b=vaFNsbfBErvuH7CzopVijUrW+54PJQARhVV7Hqu9k7Oj3au+sAPvDIgujq5zH5nnF5
 nC66ZXMuiz1QjI1NU6iIEUUs1uOiqnfdgIhpZpPSRMIkfZi70CUrQqdqAKgj69/uDvV9
 JJ60wcniMgSWRslX0FlYyraPzsxnMvZXyUn5lFgRxUmefwnpGTA0bRM9RDX8nS+9Pdpc
 fhd27JUf5udhkBKSQlVxR8d3TW3PR1Ulj5Ijo+3M8cRUQeBpxrdAsFPfYcEhGIe+ZaQd
 cmlHSdwj5nUOrJB3PiDvcJPC62J8/Jl86TTDRSpmzPnu4faFw5RFHCMuMoYBU6IVq9hb
 6zFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYPMHm88APWmPjieXdEIUddhXfKE4ReM+AkWfYxcMKsSgFp+6ib44p605qSb4CJtn7dbHSaZY=@lists.denx.de
X-Gm-Message-State: AOJu0Ywh70+l1JK2x+aIhX5Xj3KBplT/ZHVNxr2jNdXbHTTVvbm7Xyx6
 HJHlCp7X9UloWfr+OzI3ore0nWYtxmGMBwprJ/FHGCNMu58FFTtTHYNkV8b2T6L4SyD2RsmdZX+
 7N2Co4++uy4Qe2w837/J8IZfPZ28OMhG2MOzV2g==
X-Gm-Gg: ASbGncvpAjaYa0qfqRZFDE5jYgylIasxFe9LZUIzM0cmKIYXr+ekU7SOIsrA7CHVh9G
 i+INJIFUmoZEHJSa5nNxJqBpAP28ClZBZCJqmDxq2P4mUsokjgNmtV4RF1Zwlploj7ik2yZdL
X-Google-Smtp-Source: AGHT+IFSUyWo9TF5/RTDT0NP7sr7rl8NAWvFguMJ0/toTc4BJDn5IHXmGa82uSJdk5nUCUY9qGLaVSaT8ozoJeyxs4I=
X-Received: by 2002:a05:6902:1a4a:b0:e5b:fed:7b48 with SMTP id
 3f1490d57ef6-e5b25c09e6bmr1784553276.43.1738751573396; Wed, 05 Feb 2025
 02:32:53 -0800 (PST)
MIME-Version: 1.0
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
 <20250205071714.635518-2-ilias.apalodimas@linaro.org>
 <445a0c31-5a18-42e7-bb95-e380437d57f4@linaro.org>
In-Reply-To: <445a0c31-5a18-42e7-bb95-e380437d57f4@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 5 Feb 2025 12:32:17 +0200
X-Gm-Features: AWEUYZmJuLZIefuARVF6Z42Gix7jOXA8dnGB5rIdLhEV27t_shgWs9X8z4AKTMM
Message-ID: <CAC_iWjK_6hEMHR9UApr0DxbUmtgC9bDpJvM73aKdHrvbGBh9xw@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] meminfo: add memory details for armv8
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: xypron.glpk@gmx.de, trini@konsulko.com, 
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Huan Wang <alison.wang@nxp.com>, Angelo Dureghello <angelo@kernel-space.org>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Marek Vasut <marex@denx.de>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>, 
 =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, 
 Peter Hoyes <Peter.Hoyes@arm.com>, Andre Przywara <andre.przywara@arm.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Stefan Roese <sr@denx.de>, Jagan Teki <jagan@amarulasolutions.com>, 
 Alex Shumsky <alexthreed@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Joshua Watt <jpewhacker@gmail.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Michal Simek <michal.simek@amd.com>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, 
 uboot-snps-arc@synopsys.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 05 Feb 2025 14:15:26 +0100
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

On Wed, 5 Feb 2025 at 11:27, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
>
>
> On 2/5/25 08:16, Ilias Apalodimas wrote:
> > Upcoming patches are mapping memory with RO, RW^X etc permsissions.
> > Fix the meminfo command to display them properly
> >
> > Acked-by: Jerome Forissier <jerome.forissier@linaro.org>
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >  arch/arm/cpu/armv8/cache_v8.c    | 26 +++++++++++++++++++++++---
> >  arch/arm/include/asm/armv8/mmu.h |  2 ++
> >  cmd/meminfo.c                    |  5 +++++
> >  3 files changed, 30 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> > index 5d6953ffedd1..c4b3da4a8da7 100644
> > --- a/arch/arm/cpu/armv8/cache_v8.c
> > +++ b/arch/arm/cpu/armv8/cache_v8.c
> > @@ -421,7 +421,7 @@ static int count_ranges(void)
> >       return count;
> >  }
> >
> > -#define ALL_ATTRS (3 << 8 | PMD_ATTRINDX_MASK)
> > +#define ALL_ATTRS (3 << 8 | PMD_ATTRMASK)
> >  #define PTE_IS_TABLE(pte, level) (pte_type(&(pte)) == PTE_TYPE_TABLE && (level) < 3)
> >
> >  enum walker_state {
> > @@ -568,6 +568,20 @@ static void pretty_print_table_attrs(u64 pte)
> >  static void pretty_print_block_attrs(u64 pte)
> >  {
> >       u64 attrs = pte & PMD_ATTRINDX_MASK;
> > +     u64 perm_attrs = pte & PMD_ATTRMASK;
> > +     char mem_attrs[16] = { 0 };
>
> 11 is enough is seems?

I can but OTOH, I prefer defining the arrays aligned. I dont think
anyone will miss 5 bytes!

Cheers
/Ilias
>
> > +     int cnt = 0;
> > +
> > +     if (perm_attrs & PTE_BLOCK_PXN)
> > +             cnt += snprintf(mem_attrs + cnt, sizeof(mem_attrs) - cnt, "PXN ");
> > +     if (perm_attrs & PTE_BLOCK_UXN)
> > +             cnt += snprintf(mem_attrs + cnt, sizeof(mem_attrs) - cnt, "UXN ");
> > +     if (perm_attrs & PTE_BLOCK_RO)
> > +             cnt += snprintf(mem_attrs + cnt, sizeof(mem_attrs) - cnt, "RO");
> > +     if (!mem_attrs[0])
> > +             snprintf(mem_attrs, sizeof(mem_attrs), "RWX ");
> > +
> > +     printf(" | %-10s", mem_attrs);
> >
> >       switch (attrs) {
> >       case PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE):
> > @@ -613,6 +627,7 @@ static void print_pte(u64 pte, int level)
> >  {
> >       if (PTE_IS_TABLE(pte, level)) {
> >               printf(" %-5s", "Table");
> > +             printf(" %-12s", "|");
> >               pretty_print_table_attrs(pte);
> >       } else {
> >               pretty_print_pte_type(pte);
> > @@ -642,9 +657,9 @@ static bool pagetable_print_entry(u64 start_attrs, u64 end, int va_bits, int lev
> >
> >       printf("%*s", indent * 2, "");
> >       if (PTE_IS_TABLE(start_attrs, level))
> > -             printf("[%#011llx]%14s", _addr, "");
> > +             printf("[%#016llx]%19s", _addr, "");
> >       else
> > -             printf("[%#011llx - %#011llx]", _addr, end);
> > +             printf("[%#016llx - %#016llx]", _addr, end);
> >
> >       printf("%*s | ", (3 - level) * 2, "");
> >       print_pte(start_attrs, level);
> > @@ -1112,3 +1127,8 @@ void __weak enable_caches(void)
> >       icache_enable();
> >       dcache_enable();
> >  }
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
> >  #define PTE_BLOCK_NG         (1 << 11)
> >  #define PTE_BLOCK_PXN                (UL(1) << 53)
> >  #define PTE_BLOCK_UXN                (UL(1) << 54)
> > +#define PTE_BLOCK_RO            (UL(1) << 7)
> >
> >  /*
> >   * AttrIndx[2:0]
> > @@ -75,6 +76,7 @@
> >  #define PMD_ATTRMASK         (PTE_BLOCK_PXN          | \
> >                                PTE_BLOCK_UXN          | \
> >                                PMD_ATTRINDX_MASK      | \
> > +                              PTE_BLOCK_RO           | \
> >                                PTE_TYPE_VALID)
> >
> >  /*
> > diff --git a/cmd/meminfo.c b/cmd/meminfo.c
> > index 5e83d61c2dd3..3915e2bbb268 100644
> > --- a/cmd/meminfo.c
> > +++ b/cmd/meminfo.c
> > @@ -15,6 +15,10 @@
> >
> >  DECLARE_GLOBAL_DATA_PTR;
> >
> > +void __weak arch_dump_mem_attrs(void)
> > +{
> > +}
> > +
> >  static void print_region(const char *name, ulong base, ulong size, ulong *uptop)
> >  {
> >       ulong end = base + size;
> > @@ -54,6 +58,7 @@ static int do_meminfo(struct cmd_tbl *cmdtp, int flag, int argc,
> >
> >       puts("DRAM:  ");
> >       print_size(gd->ram_size, "\n");
> > +     arch_dump_mem_attrs();
> >
> >       if (!IS_ENABLED(CONFIG_CMD_MEMINFO_MAP))
> >               return 0;
