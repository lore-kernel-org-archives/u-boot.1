Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AF8E7717F
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 01:36:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0284A801EA;
	Wed, 11 Dec 2024 02:36:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R+PZzs6l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA114801FE; Wed, 11 Dec 2024 02:36:56 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B4C5801E8
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 02:36:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6eff5ad69a1so34311717b3.3
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 17:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733881013; x=1734485813; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bu+CRVfJsuyxqjQET3kTY6gzWOUHCIEqU01o/yX3gcc=;
 b=R+PZzs6ljflNNg/dmKRPlt+pL4lCv5bi2kbj2JnYih4UUl5vdL2TJ0r6U2bi+ch7GA
 QZMD1yW3rpDOAQzw/ZkBEJklOYM0mtM5o3SBqH/iu+5mHI7ryObLjDBd0Bqqnh/SbPbj
 6BHTqQ4BKGGMPgA3qjBB8C3DtYTG+J6evLgPbeyJlA3Et4C/YMQkPqBOzrwVR/sbV5sW
 kL3NK7UNeYIC0IgCCxEjHOnb7o4RZQR4IBg8/lzJFhezSyu+nSmwWcJE+j0ChFdg1hCf
 HbsbWOI27qwgLoKPwMGAzo+qvAgBK03TIrYAZmiMIaRAotpAsAMyoIWN0Iwq3WhVwgc2
 OyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733881013; x=1734485813;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bu+CRVfJsuyxqjQET3kTY6gzWOUHCIEqU01o/yX3gcc=;
 b=lZC4KyaqtDiM2w3ezY4/23gfvF5wULOa32K9+s3Tu8q8RvDKCbvzFqhOpcrgITFW/E
 GsP/mkunsJftU+Qvtg3TOPGYONaK548XcZcUqIOtaX8lrNP4o4YTxXZC1YwdWLTYuBQs
 26MXhXD6nD3PR3FE84U2+pw4SLYPTpzbhLQstUplCzllbwikGswltqAe+G/X+9o2DqzS
 BwifevsyyV8iHUgy9Jdrm90UPILBHuWfDfX8P4td+TyXKOCM8dcQYTHD3Ap+nbaw/zVa
 4xU43hA2o1uPREI7uxUYn3DYVC1rO683yrd3CM331J0EA69FHCu4omyKf6Ho4hCgXKkP
 UjaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4cKKr3PbTpzZh39Xyvy3gTtIUzPxJ7VmRVOEwrxGi19hkOLgYf+GMATz2MJlUukfvCLrsJpg=@lists.denx.de
X-Gm-Message-State: AOJu0YyQCtrPQ+DmfIV6g/nvL7MTBVFJSK/zPY6vB2qPMGfEXon7jxdq
 NpuSwPuncYPNmw3juWhwSaWwp0XPq0h6ZZhQ811atrO9LX8uu/Em6Re24Nq4OHU+v7OqpjOFr4M
 OX+gOTqwuJ3cqY38CyU4sdWwbvYMLc2JUg4bxlA==
X-Gm-Gg: ASbGncvdcdOZighAuld6GccvC0PGKDJ9nzG5vVdFdFZmwq613TxSdn9NZGJt9pqIG1z
 BcdipfKESsSUFib4j90dkshiUyeJFtdkQoxw=
X-Google-Smtp-Source: AGHT+IHOqMEIJe16ulBVS0pudZin55ffKcr8QQcE1WJoFq/JlYdTl7ESPhOphJ1iQDOgOGgFP7o6+LUOZm2UVqpETt8=
X-Received: by 2002:a05:690c:7309:b0:6ef:4c6c:3049 with SMTP id
 00721157ae682-6f147ff2d3fmr18331497b3.14.1733881013220; Tue, 10 Dec 2024
 17:36:53 -0800 (PST)
MIME-Version: 1.0
References: <20241208002121.31887-1-semen.protsenko@linaro.org>
 <20241208002121.31887-3-semen.protsenko@linaro.org>
 <CAC_iWjJ4X+G=3OyfYmwu9aqdmRvYjhTfS6VcJ2nirVVYqcBhVA@mail.gmail.com>
 <CADg8p95FR8vJUY+fEgVnPAa2E38QAUn3J152ctCGD2WzY8AdFg@mail.gmail.com>
In-Reply-To: <CADg8p95FR8vJUY+fEgVnPAa2E38QAUn3J152ctCGD2WzY8AdFg@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 10 Dec 2024 19:36:41 -0600
Message-ID: <CAPLW+4mMwqNw2AtXN_DUjF2R_WbTixfOUABFXinXUUiNjSzuRQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] lmb: Return -EEXIST in lmb_add_region_flags() if
 region already added
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Dec 9, 2024 at 1:08=E2=80=AFAM Sughosh Ganu <sughosh.ganu@linaro.or=
g> wrote:
>
> On Sun, 8 Dec 2024 at 12:20, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Sam,
> >
> > On Sun, 8 Dec 2024 at 02:21, Sam Protsenko <semen.protsenko@linaro.org>=
 wrote:
> > >
> > > An attempt to add the already added LMB region (with exactly the same
> > > start address, size and flags) using lmb_add_region_flags() ends up i=
n
> > > lmb_addrs_overlap() check, which eventually leads to either returning=
 0
> > > if 'flags' is LMB_NONE, or -1 otherwise. It makes it impossible for t=
he
> > > user of this function to catch the case when the region is already ad=
ded
> > > and differentiate it from regular errors. That in turn may lead to
> > > incorrect error handling in the caller code, like reporting misleadin=
g
> > > errors or interrupting the normal code path where it could be treated=
 as
> > > the normal case. An example is boot_fdt_reserve_region() function, wh=
ich
> > > might be called twice (e.g. during board startup in initr_lmb(), and
> > > then during 'booti' command booting the OS), thus trying to reserve
> > > exactly the same memory regions described in device tree twice, which
> > > produces an error message on second call.
> > >
> > > Implement the detection of cases when the already added region is try=
ing
> > > to be added again, and return -EEXIST error code in case the region
> > > exists and it's not LMB_NONE; for LMB_NONE return 0, to conform to un=
it
> > > tests (specifically test_alloc_addr() in test/lib/lmb.c) and the
> > > preferred behavior described in commit 1d9aa4a283da ("lmb: Fix the
> > > allocation of overlapping memory areas with !LMB_NONE"). The change o=
f
> > > lmb_add_region_flags() return values is described in the table below:
> > >
> > >     Return case                        Pre-1d9   1d9    New
> > >     -----------------------------------------------------------
> > >     Added successfully                    0      0      0
> > >     Failed to add                         -1     -1     -1
> > >     Already added, flags =3D=3D LMB_NONE      0      0      0
> > >     Already added, flags !=3D LMB_NONE      0      -1     -EEXIST
> > >
> > > Rework all affected functions and their documentation. Also fix the
> > > corresponding unit test which checks reserving the same region with t=
he
> > > same flags to account for the changed return value.
> > >
> > > No functional change is intended (by this patch itself).
> > >
> > > Fixes: 1d9aa4a283da ("lmb: Fix the allocation of overlapping memory a=
reas with !LMB_NONE")
> > > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > > ---
> > >  lib/lmb.c      | 18 ++++++++++++++----
> > >  test/lib/lmb.c |  2 +-
> > >  2 files changed, 15 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/lib/lmb.c b/lib/lmb.c
> > > index 713f072f75ee..ce0dc49345fb 100644
> > > --- a/lib/lmb.c
> > > +++ b/lib/lmb.c
> > > @@ -183,8 +183,10 @@ static long lmb_resize_regions(struct alist *lmb=
_rgn_lst,
> > >   * the function might resize an already existing region or coalesce =
two
> > >   * adjacent regions.
> > >   *
> > > - *
> > > - * Returns: 0 if the region addition successful, -1 on failure
> > > + * Return:
> > > + * * %0                - Added successfully, or it's already added (=
only if LMB_NONE)
> > > + * * %-EEXIST  - The region is already added, and flags !=3D LMB_NON=
E
> > > + * * %-1       - Failure
> > >   */
> > >  static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_add=
r_t base,
> > >                                  phys_size_t size, enum lmb_flags fla=
gs)
> > > @@ -202,6 +204,14 @@ static long lmb_add_region_flags(struct alist *l=
mb_rgn_lst, phys_addr_t base,
> > >                 phys_size_t rgnsize =3D rgn[i].size;
> > >                 enum lmb_flags rgnflags =3D rgn[i].flags;
> > >
> > > +               /* Already have this region, so we're done */
> > > +               if (base =3D=3D rgnbase && size =3D=3D rgnsize && fla=
gs =3D=3D rgnflags) {
> > > +                       if (flags =3D=3D LMB_NONE)
> > > +                               return 0;
> > > +                       else
> > > +                               return -EEXIST;
> > > +               }
> >
> > The change looks sane and I did plan to clean up LMB after the release
> > with similar logic.
> > But I wonder should we return -EEXIST here or a few lines below in
> > 'else if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {'
> >
> > There are two cases we return -1 there, we could return -EEXIST. Someth=
ing like
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index 3a765c11bee6..f3d5b616c376 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -226,7 +226,7 @@ static long lmb_add_region_flags(struct alist
> > *lmb_rgn_lst, phys_addr_t base,
> >                                 coalesced++;
> >                                 break;
> >                         } else {
> > -                               return -1;
> > +                               return -EEXIST;
> >                         }
> >                 }
> >         }
> >
>
> +1 for this approach. Otherwise we are effectively reverting 1d9aa4a283da=
.
>

I'll send v2 soon, addressing all comments and including this suggestion.

> Sam, can you please check if this change also fixes the issue that you
> see. Thanks.
>

Indeed. Three birds with one stone :) Meaning the sandbox one is fixed
as well. That was a really good suggestion, to move -EEXIST. Thanks
for letting me know about fixed cases!

> -sughosh
>
> > I am not sure about the lmb_resize_regions() failure, I think we
> > should return a different error
> >
> > > +
> > >                 ret =3D lmb_addrs_adjacent(base, size, rgnbase, rgnsi=
ze);
> > >                 if (ret > 0) {
> > >                         if (flags !=3D rgnflags)
> > > @@ -667,7 +677,7 @@ long lmb_add(phys_addr_t base, phys_size_t size)
> > >   *
> > >   * Free up a region of memory.
> > >   *
> > > - * Return: 0 if successful, -1 on failure
> > > + * Return: 0 if successful, negative error code on failure
> > >   */
> > >  long lmb_free_flags(phys_addr_t base, phys_size_t size,
> > >                     uint flags)
> > > @@ -818,7 +828,7 @@ static phys_addr_t _lmb_alloc_addr(phys_addr_t ba=
se, phys_size_t size,
> > >                                       lmb_memory[rgn].size,
> > >                                       base + size - 1, 1)) {
> > >                         /* ok, reserve the memory */
> > > -                       if (lmb_reserve_flags(base, size, flags) >=3D=
 0)
> > > +                       if (!lmb_reserve_flags(base, size, flags))
> > >                                 return base;
> > >                 }
> > >         }
> > > diff --git a/test/lib/lmb.c b/test/lib/lmb.c
> > > index 0bd29e2a4fe7..48c3c966f8f2 100644
> > > --- a/test/lib/lmb.c
> > > +++ b/test/lib/lmb.c
> > > @@ -754,7 +754,7 @@ static int lib_test_lmb_flags(struct unit_test_st=
ate *uts)
> > >
> > >         /* reserve again, same flag */
> > >         ret =3D lmb_reserve_flags(0x40010000, 0x10000, LMB_NOMAP);
> > > -       ut_asserteq(ret, -1L);
> > > +       ut_asserteq(ret, -EEXIST);
> > >         ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0=
x10000,
> > >                    0, 0, 0, 0);
> > >
> > > --
> > > 2.39.5
> > >
> >
> > Other than that it looks good thanks for fixing this!
> > Regards
> > /Ilias
