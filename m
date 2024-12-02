Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DB4D78321
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 14:19:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81B0E89301;
	Mon,  2 Dec 2024 15:18:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vziLrsE4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2060F89301; Mon,  2 Dec 2024 15:18:59 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B83A89183
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 15:18:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6ef81222be7so14079637b3.3
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 06:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733149135; x=1733753935; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MKTDGHLnc1AjTZE/ff7EvVWCN9f2l2Zq1OqKTsnVsYY=;
 b=vziLrsE4U+IXTAra/os0tRZkLwpcagm/ySUns5z2rLbjAVIRLmVjmzRzEASxYOpGkp
 al/dB5mWmi8j3isbETbGr8Q7xhqV6QR7TfUb2SHm1B7E35uzkpsfu0fjGSqdCZNoyjvm
 O0orPRlhbX96l21xxaEJnGnqAayB7neYbPswGPrJJ6XHpN+7sRGGqIdCavJ3Gzbs2Eko
 sRz/yDWR4NU9Za+nfGSrtFPo4R/3+CR4/JjJiIJPwuw5POliDfYzXZb0SUF3yIux4cyE
 GSsykgwoRtRad6jcJ1vGuw1tBcrm3ab0pJ3LUWZY2y/LOBeH+lSAexkcla5+0YlMmI1R
 z8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733149135; x=1733753935;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MKTDGHLnc1AjTZE/ff7EvVWCN9f2l2Zq1OqKTsnVsYY=;
 b=ILbM+MjLfMImoL/YVU+POeKggVpRqFS+q6CDbEyGLM868pgioh4cjg6D5qERztvy4Z
 d9wtL4KHJN2Gw06BUbFlgETIy/xkBeT1SHZe8JARCXW99lfBNFzHTncWPmpBIXd6HHbP
 yqIlM/Wyh1QKUL1RyQX6GMNWaP4oILvA/vKbBShcOp2tJTFhlRClzcU/L06NgfCQFdEO
 lpOZp5ChmPD1/Aqg9XGB8Pd8RncQluOZy8aJEeWlpfEOAdgmOkrL0YdPwfHK1i+RZFdE
 T5ANrTKYKgPsfzRencPEz3pXlHX0AyBlwtnXEDdVYMzMnOr9sZ9rOn7vYxLXBmB4+brz
 vykg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6WYimICtL5LkcAv54IrBZlqpIEMDzS8wvbAOsWCiiNxkk7d1z+hzCQazbwSPELpxQmC3YTnc=@lists.denx.de
X-Gm-Message-State: AOJu0YzEs1kXnpejphieM0sVSzUXnLe0L2zjlgkDlkg5FR+SIuGIZMey
 IFSomA16Pphcrd9lzQwlngOd5ZvnuDTfrKNo3lxDp1DjE7Bks1ByY90EBuDDmQ1WLqosH2n8eWd
 2gQfhesdkA3dVNqySGOcAOBNJsk4BMJZqs1Ashg==
X-Gm-Gg: ASbGncuYe9mQhoNwCVPtMR7/LVP3BRgj1IMHcjwU2E9UHJnkJQsd2K4aC/3N5F+SPXe
 /rfSgT4vKEZKCQdkvwNBQ28yFQsta1Co=
X-Google-Smtp-Source: AGHT+IGo8gqu1cXRJnDmxr66yE32A8tQbX1YD7VvtbzBu3Fbj8PAzAAjWe3AS10qOcgVsyt1x9gKoXk3RJpt00SVYSk=
X-Received: by 2002:a05:690c:6e0a:b0:6ef:68b9:c956 with SMTP id
 00721157ae682-6ef68b9d006mr136728717b3.39.1733149133923; Mon, 02 Dec 2024
 06:18:53 -0800 (PST)
MIME-Version: 1.0
References: <20241128114926.458728-1-ilias.apalodimas@linaro.org>
 <58f70517-8ed4-40df-ab36-7f5595ff1e71@gmx.de>
 <CAC_iWj+wTMO8ceVy8b_nx2vQO+srfuK1JsdvMXc_pn_rL7VtFQ@mail.gmail.com>
In-Reply-To: <CAC_iWj+wTMO8ceVy8b_nx2vQO+srfuK1JsdvMXc_pn_rL7VtFQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 2 Dec 2024 16:18:17 +0200
Message-ID: <CAC_iWjJ0QfqnSuf2cA-FPvR=obyeXUEK02k0yPLMPL6+ARA8+g@mail.gmail.com>
Subject: Re: [PATCH] lmb: Fix the allocation of overlapping memory areas with
 !LMB_NONE
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Janne Grunau <j@jannau.net>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
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

On Mon, 2 Dec 2024 at 16:11, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Mon, 2 Dec 2024 at 15:37, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 28.11.24 12:49, Ilias Apalodimas wrote:
> > > At the moment the LMB allocator will return 'success' immediately on two
> > > consecutive allocations if the second one is smaller and the flags match
> > > without resizing the reserved area.
> > >
> > > This is problematic for two reasons, first of all the new updated
> > > allocation won't update the size and we end up holding more memory than
> > > needed, but most importantly it breaks the EFI SCT tests since EFI
> > > now allocates via LMB.
> > >
> > > More specifically when EFI requests a specific address twice with the
> > > EFI_ALLOCATE_ADDRESS flag set, the first allocation will succeed and
> > > update the EFI memory map. Due to the LMB behavior the second allocation
> > > will also succeed but the address ranges are already in the EFI memory
> > > map due the first allocation. EFI will then fail to update the memory map,
> > > returning EFI_OUT_OF_RESOURCES instead of EFI_NOT_FOUND which break EFI
> > > conformance.
> > >
> > > So let's remove the fast check with is problematic anyway and leave LMB
> > > resize and calculate address properly. LMB will now
> > > - try to resize the reservations for LMB_NONE
> > > - return -1 if the memory is not LMB_NONE and already reserved
> > >
> > > The LMB code needs some cleanup in that part, but since we are close to
> > > 2025.01 do the easy fix and plan to refactor it later.
> > > Also update the dm tests with the new behavior.
> > >
> > > Fixes: commit 22f2c9ed9f53 ("efi: memory: use the LMB API's for allocating and freeing memory")
> > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > ---
> > >   lib/lmb.c      |  9 ---------
> > >   test/lib/lmb.c | 22 +++++++++++++++++++++-
> > >   2 files changed, 21 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/lib/lmb.c b/lib/lmb.c
> > > index 14b9b8466ff2..3a765c11bee6 100644
> > > --- a/lib/lmb.c
> > > +++ b/lib/lmb.c
> > > @@ -201,15 +201,6 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
> > >               phys_addr_t rgnbase = rgn[i].base;
> > >               phys_size_t rgnsize = rgn[i].size;
> > >               phys_size_t rgnflags = rgn[i].flags;
> > > -             phys_addr_t end = base + size - 1;
> > > -             phys_addr_t rgnend = rgnbase + rgnsize - 1;
> > > -             if (rgnbase <= base && end <= rgnend) {
> > > -                     if (flags == rgnflags)
> > > -                             /* Already have this region, so we're done */
> > > -                             return 0;
> > > -                     else
> > > -                             return -1; /* regions with new flags */
> > > -             }
> > >
> > >               ret = lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
> > >               if (ret > 0) {
> > > diff --git a/test/lib/lmb.c b/test/lib/lmb.c
> > > index c917115b7b66..bc44dd21192f 100644
> > > --- a/test/lib/lmb.c
> > > +++ b/test/lib/lmb.c
> > > @@ -529,6 +529,26 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
> > >       ret = lmb_add(ram, ram_size);
> > >       ut_asserteq(ret, 0);
> > >
> > > +     /* Try to allocate a page twice */
> > > +     b = lmb_alloc_addr_flags(alloc_addr_a, 0x1000, LMB_NONE);
> > > +     ut_asserteq(b, alloc_addr_a);
> > > +     b = lmb_alloc_addr_flags(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
> > > +     ut_asserteq(b, 0);
> > > +     b = lmb_alloc_addr_flags(alloc_addr_a, 0x1000, LMB_NONE);
> > > +     ut_asserteq(b, alloc_addr_a);
> > > +     b = lmb_alloc_addr_flags(alloc_addr_a, 0x2000, LMB_NONE);
> > > +     ut_asserteq(b, alloc_addr_a);
> > > +     ret = lmb_free(alloc_addr_a, 0x2000);
> > > +     ut_asserteq(ret, 0);
> > > +     b = lmb_alloc_addr_flags(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
> > > +     ut_asserteq(b, alloc_addr_a);
> > > +     b = lmb_alloc_addr_flags(alloc_addr_a, 0x1000, LMB_NONE);
> > > +     ut_asserteq(b, 0);
> > > +     b = lmb_alloc_addr_flags(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
> > > +     ut_asserteq(b, 0);
> > > +     ret = lmb_free(alloc_addr_a, 0x1000);
> > > +     ut_asserteq(ret, 0);
> > > +
> > >       /*  reserve 3 blocks */
> > >       ret = lmb_reserve(alloc_addr_a, 0x10000);
> > >       ut_asserteq(ret, 0);
> > > @@ -734,7 +754,7 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
> > >
> > >       /* reserve again, same flag */
> > >       ret = lmb_reserve_flags(0x40010000, 0x10000, LMB_NOMAP);
> > > -     ut_asserteq(ret, 0);
> > > +     ut_asserteq(ret, 0xffffffff);
> >
> > lmb_reserve_flags() should return a long value < 0 on failure. Why do
> > you expect 0xffffffff?
>
> lmb_alloc_addr_flags has  a phys_addr_t (unsigned long), I can rewrite
> this as ut_asserteq(ret, -1); which is probably correct for 32/64bit

Apologies was looking into lmb_reserve_flags(). lmb_reserve_flags() is
ineed returning a long, so I'll change that to -1L

Thanks
/Ilias
>
> Cheers
> /Ilias
> >
> > Best regards
> >
> > Heinrich
> >
> > >       ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x10000,
> > >                  0, 0, 0, 0);
> > >
> >
