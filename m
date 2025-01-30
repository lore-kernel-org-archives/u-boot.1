Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0929DC0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 09:11:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F85581FEE;
	Thu, 30 Jan 2025 10:11:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q2gXk81V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF33D82012; Thu, 30 Jan 2025 10:11:50 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9382680C85
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 10:11:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e39779a268bso770785276.1
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 01:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738228307; x=1738833107; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rm8DnwGrOv+iNMNXHGdF1zP1haK7VsDp9WHMDfJyq18=;
 b=Q2gXk81VC8tD55RFOAunjEQNwoC+PYSOgA+Y9PfC3DCGSNniG08ruWrAv+af40qNp0
 2F02Sql7q50x7SmSxKWkxXnxoF8Q99yRlroz19xXVY4Ay+/YHDtwfwkpDrvYVQs0UDnW
 fFzgyv+hw+weCKB2k8/yMsgTobC8ASzbfkLtTCRPaXKCB/SA0ZdLPPsUTqrv4BUTxNka
 fXgO5L3aYc0+YO3PljH+ibp4tMZR4H6yt7DEoC4jiQbudc3PAl2UqoBP5IQtb+kqhUPo
 Ap1IxuBj8oX5QLGLD11418wjna/inVAWSoLTEbz8eqLbpOiIHi5rrrS6/4CkWY98mhKY
 TQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738228307; x=1738833107;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rm8DnwGrOv+iNMNXHGdF1zP1haK7VsDp9WHMDfJyq18=;
 b=Z4bkpuQXJPQOv2SqnlMlofghhNaj3F6MlJHPFdbFzq8CzR49r1BhcdehDQb6tdV5LM
 HVgWRiu8pYzbdVJGOb5yRHFfwGTQi5NL7dpVAnNOHTfETNPz7XPJppXazv6+ZRKvL7Np
 PkQSkHQUYgP4TuR+Fr9liQTRA1uFkgc7NZBVjZsAErIKG/nfxJ8ntEpHDzihD3tKesnN
 zqkD/wqVKoxBnTfU/aRHldtAKdcSZu0MmhyZhXZ/7D09K6jmGMe/fsba86aRYQB7GA50
 eGPhi0fSOblX9WRSR59tZmzaXyqElMx3cPLi9edTm7/A5bj/j12rXEigMmW7CBQs7viQ
 enXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSTTUf+n/24pNgoQmz4dav6kdJ5B6kqHkTPu+8ZvCaLwx2lcQy1FphQVuJDPeNHJt2KTDNYDU=@lists.denx.de
X-Gm-Message-State: AOJu0YzhBm3gPg5aF8RTnI4bOKb9Rl6cxPvTY2DOlK5gVYhnwi6NMRax
 +eqMqe64bSXR+pZpl0OvA52ccbGXeq7LPZ+r/+jfmz5lBMDEvPtru2Irfhf0dL82J7467rUsrFD
 BjCFiZPaqM9zVw0YbNsgw6LMAz5Y3GkmOe4plcQ==
X-Gm-Gg: ASbGncuerqiuCTopB6uMTAXvzIduZskYSYzW3ArNjBRdAMzy325jBP04QnGf5IUEzrM
 LT+7bz/YaDvHtSSt1rCIdze0s5M7mf4h/1nYfwlROTSnvUjb4LGjBlzW08Dyk9EmQPNw1C6Uj
X-Google-Smtp-Source: AGHT+IFSDK/pyGasWbkR5b5v4Bm0gYgekkwH1A+7f1UHXpGNrUd59hFXQ0Z3Hm8/CH/EWVFI0d03bgPPVz1qGanY2wA=
X-Received: by 2002:a25:b006:0:b0:e5a:cc48:847d with SMTP id
 3f1490d57ef6-e5acc4884d8mr704936276.20.1738228307368; Thu, 30 Jan 2025
 01:11:47 -0800 (PST)
MIME-Version: 1.0
References: <20250130072100.27297-1-ilias.apalodimas@linaro.org>
 <20250130072100.27297-2-ilias.apalodimas@linaro.org>
 <27974e6c-caca-484c-b6c4-c960f082f24b@linaro.org>
In-Reply-To: <27974e6c-caca-484c-b6c4-c960f082f24b@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 30 Jan 2025 11:11:11 +0200
X-Gm-Features: AWEUYZmTzkw3YUMlfcLRZIgyeiOpx_CZB4OJIpQt-AFbx5q2BCskTuRDXcV_NgQ
Message-ID: <CAC_iWj+L+Cf5LEWpWzn94829MSKrsz4Fgk=sv6K6zL0xa3cseQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] meminfo: add memory details for armv8
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: maz@kernel.org, trini@konsulko.com, CFSworks@gmail.com, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Peter Robinson <pbrobinson@gmail.com>,
 =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Richard Henderson <richard.henderson@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Michal Simek <michal.simek@amd.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
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

Hi Jerome,

On Thu, 30 Jan 2025 at 11:09, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Hi Ilias,
>
> On 1/30/25 08:20, Ilias Apalodimas wrote:
> > Upcoming patches are mapping memory with RO, RW^X etc permsissions.
> > Fix the meminfo command to display them properly
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >  arch/arm/cpu/armv8/cache_v8.c    | 18 +++++++++++++++++-
> >  arch/arm/include/asm/armv8/mmu.h |  2 ++
> >  cmd/meminfo.c                    |  5 +++++
> >  3 files changed, 24 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> > index 5d6953ffedd1..a4ca56c8ed42 100644
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
> > @@ -568,6 +568,17 @@ static void pretty_print_table_attrs(u64 pte)
> >  static void pretty_print_block_attrs(u64 pte)
> >  {
> >       u64 attrs = pte & PMD_ATTRINDX_MASK;
> > +     u64 perm_attrs = pte & PMD_ATTRMASK;
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
> We could also print out the unprivileged and privileged permissions
> explicitly, for example rwxRWX or rw-RW- etc. but maybe the format
> you're proposing is more to the point since it is not detailed
> debugging info that we're after.

In a previous version I was printing PXN/UXN etc. But I thought it
would be easier to read with RO/RW/RX.

Cheers
/Ilias


>
> >
> >       switch (attrs) {
> >       case PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE):
> > @@ -1112,3 +1123,8 @@ void __weak enable_caches(void)
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
>
> Acked-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks!
If we can sort out the slight misalignment, this is one of the patches
that can go in without the rest

/Ilias
