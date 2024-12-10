Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B22E7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 23:44:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D748680200;
	Wed, 11 Dec 2024 00:44:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GdVKzk4B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1601D80209; Wed, 11 Dec 2024 00:44:09 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95BB1801DB
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 00:44:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6eff5f6fe07so1310327b3.1
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 15:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733874245; x=1734479045; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qGI3gluMY5GJpMJ+HnOVjyFUkNMJlH45eFtn9b9jb+s=;
 b=GdVKzk4BTVE8CPznrG2Eo7fHl+ljfT6+lD7ugndM5+L9h0LnQlQ7GZgtIQwM4ztbTP
 TrOkPd0tCz4qHJvXWzIjIUKEqQzMNRyfDSKqpTBZtB0i6TjBwp3OPq5h4kDmRamJ70lJ
 lqfS0BdUDmf7UbaaR0a8oFu07AQZxasQTIn1WnPnBNxhjP65atormYQCWY/bChYPR2ZD
 urZ22cZZAKahP1Z21pkYm1swulA8GUTFWJr5qOvtNzYx1yqFOtd9OMEJMHZe83NaDH7s
 ms+6mINg6GSZO0PZyYESErTOPxVQDOXX8J9DUStU1wpDZ1Zuq01WPi4Ez1W0lxkOdckr
 9QWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733874245; x=1734479045;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qGI3gluMY5GJpMJ+HnOVjyFUkNMJlH45eFtn9b9jb+s=;
 b=SmTbqRovehCHi0x83Yd+5vA3DvrV+lAry26PpsQiWakW0z6GnxB3fAyD2KhXeK29sd
 UQKrnKxg4RLgvybHBc/WnLif07VNv3uuixyGt7iFfnG5QDyPT6J73FEJif0og5TmaT3B
 MtW1tFx1t0U8d1R25s30rkivmHSLhKRFVoTj/JvfKlJKWy6QVLwm/HkcjmPMK9arUG/P
 ss9N3pBHOEdkkGZXG8Csf4hV+ueDG8x1oVRURKzHcXKTxRDpDzeD7fGxrkpuIfFtsQM/
 dF5BYRA5N43Ro6aBRbvFTjkZGLwz3SEy+HdFU8dKsiQM/Gvg6ew3hlL1tUaP3iMB3Fkl
 cMdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnbxK0Z60H3kkKHlTGM5bYDjw0qLPhqjgv1PxkWIcgDeJHPK8J+tVHb4CVNzrtkyynFCiH7A0=@lists.denx.de
X-Gm-Message-State: AOJu0YzmZKPl1Ha9lkYCeMPz/ruz1++Wz3w/pRTA1DpZAfsbBMhNhVwc
 sMbF3lDH4zVoBgn0GxhwUkd2o811n7HSs1gIbNbuIwSIardE639Cn4vuJxRd3BUsNJNONuh8IVp
 zJSrC67UidIqKAClyYWMWS2q8YjjvHQkuUMr5+A==
X-Gm-Gg: ASbGncsc4youedN37Cn/MIWbPHy5Lszd6oonU5kUsDWLJGYI3UKxeLvL7t/Z2jXUB6H
 46pStQ2mzj2s1WAbDB9BVhKsWK32Q449fWdM=
X-Google-Smtp-Source: AGHT+IFj4BulpIRt8IH/8Xmr+HfRR62UMZnIef8hF8TGvW4SbkF8bfpODEA1ATN24OiFHjQJ/L/mh2fzayJifGo1+a8=
X-Received: by 2002:a05:690c:3388:b0:6f0:697:da5f with SMTP id
 00721157ae682-6f148b8f58cmr6779307b3.14.1733874245392; Tue, 10 Dec 2024
 15:44:05 -0800 (PST)
MIME-Version: 1.0
References: <20241208002121.31887-1-semen.protsenko@linaro.org>
 <20241208002121.31887-3-semen.protsenko@linaro.org>
 <CAC_iWjJ4X+G=3OyfYmwu9aqdmRvYjhTfS6VcJ2nirVVYqcBhVA@mail.gmail.com>
In-Reply-To: <CAC_iWjJ4X+G=3OyfYmwu9aqdmRvYjhTfS6VcJ2nirVVYqcBhVA@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 10 Dec 2024 17:43:54 -0600
Message-ID: <CAPLW+4=FuRPjib7ZNhRKvb-pKVUZy4XU9CrL28GQ0=9r_7dR2w@mail.gmail.com>
Subject: Re: [PATCH 2/6] lmb: Return -EEXIST in lmb_add_region_flags() if
 region already added
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
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

On Sun, Dec 8, 2024 at 12:50=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Sam,
>
> On Sun, 8 Dec 2024 at 02:21, Sam Protsenko <semen.protsenko@linaro.org> w=
rote:
> >
> > An attempt to add the already added LMB region (with exactly the same
> > start address, size and flags) using lmb_add_region_flags() ends up in
> > lmb_addrs_overlap() check, which eventually leads to either returning 0
> > if 'flags' is LMB_NONE, or -1 otherwise. It makes it impossible for the
> > user of this function to catch the case when the region is already adde=
d
> > and differentiate it from regular errors. That in turn may lead to
> > incorrect error handling in the caller code, like reporting misleading
> > errors or interrupting the normal code path where it could be treated a=
s
> > the normal case. An example is boot_fdt_reserve_region() function, whic=
h
> > might be called twice (e.g. during board startup in initr_lmb(), and
> > then during 'booti' command booting the OS), thus trying to reserve
> > exactly the same memory regions described in device tree twice, which
> > produces an error message on second call.
> >
> > Implement the detection of cases when the already added region is tryin=
g
> > to be added again, and return -EEXIST error code in case the region
> > exists and it's not LMB_NONE; for LMB_NONE return 0, to conform to unit
> > tests (specifically test_alloc_addr() in test/lib/lmb.c) and the
> > preferred behavior described in commit 1d9aa4a283da ("lmb: Fix the
> > allocation of overlapping memory areas with !LMB_NONE"). The change of
> > lmb_add_region_flags() return values is described in the table below:
> >
> >     Return case                        Pre-1d9   1d9    New
> >     -----------------------------------------------------------
> >     Added successfully                    0      0      0
> >     Failed to add                         -1     -1     -1
> >     Already added, flags =3D=3D LMB_NONE      0      0      0
> >     Already added, flags !=3D LMB_NONE      0      -1     -EEXIST
> >
> > Rework all affected functions and their documentation. Also fix the
> > corresponding unit test which checks reserving the same region with the
> > same flags to account for the changed return value.
> >
> > No functional change is intended (by this patch itself).
> >
> > Fixes: 1d9aa4a283da ("lmb: Fix the allocation of overlapping memory are=
as with !LMB_NONE")
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> >  lib/lmb.c      | 18 ++++++++++++++----
> >  test/lib/lmb.c |  2 +-
> >  2 files changed, 15 insertions(+), 5 deletions(-)
> >
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index 713f072f75ee..ce0dc49345fb 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -183,8 +183,10 @@ static long lmb_resize_regions(struct alist *lmb_r=
gn_lst,
> >   * the function might resize an already existing region or coalesce tw=
o
> >   * adjacent regions.
> >   *
> > - *
> > - * Returns: 0 if the region addition successful, -1 on failure
> > + * Return:
> > + * * %0                - Added successfully, or it's already added (on=
ly if LMB_NONE)
> > + * * %-EEXIST  - The region is already added, and flags !=3D LMB_NONE
> > + * * %-1       - Failure
> >   */
> >  static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_=
t base,
> >                                  phys_size_t size, enum lmb_flags flags=
)
> > @@ -202,6 +204,14 @@ static long lmb_add_region_flags(struct alist *lmb=
_rgn_lst, phys_addr_t base,
> >                 phys_size_t rgnsize =3D rgn[i].size;
> >                 enum lmb_flags rgnflags =3D rgn[i].flags;
> >
> > +               /* Already have this region, so we're done */
> > +               if (base =3D=3D rgnbase && size =3D=3D rgnsize && flags=
 =3D=3D rgnflags) {
> > +                       if (flags =3D=3D LMB_NONE)
> > +                               return 0;
> > +                       else
> > +                               return -EEXIST;
> > +               }
>
> The change looks sane and I did plan to clean up LMB after the release
> with similar logic.
> But I wonder should we return -EEXIST here or a few lines below in
> 'else if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {'
>

Yes, that makes sense. That's actually the exact line of code I
initially debugged the problem to. Adding the "exactly the same
region" corner case was a bad idea, because it misses the case when a
region was coalesced with some other region, and is now contained
inside of a bigger block. I will rework that in v2.

> There are two cases we return -1 there, we could return -EEXIST. Somethin=
g like
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 3a765c11bee6..f3d5b616c376 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -226,7 +226,7 @@ static long lmb_add_region_flags(struct alist
> *lmb_rgn_lst, phys_addr_t base,
>                                 coalesced++;
>                                 break;
>                         } else {
> -                               return -1;
> +                               return -EEXIST;
>                         }
>                 }
>         }
>
> I am not sure about the lmb_resize_regions() failure, I think we
> should return a different error
>

No, that seems like a different case. I think all 'region exists'
cases for !LMB_NONE are handled in the code you referenced above, and
all LMB_NONE cases are handled below, in "if (coalesced) return 0;"
code.

Right now it looks like only LMB_NONE regions can be merged. I wonder
if it's intended, because it's not mentioned in corresponding LMB_*
flags documentation, other than LMB_NOOVERWRITE. Also, commit "lmb:
allow for resizing lmb regions" only mentions LMB_NOOVERWRITE.
Anyways, that's out of scope here I guess.

> > +
> >                 ret =3D lmb_addrs_adjacent(base, size, rgnbase, rgnsize=
);
> >                 if (ret > 0) {
> >                         if (flags !=3D rgnflags)
> > @@ -667,7 +677,7 @@ long lmb_add(phys_addr_t base, phys_size_t size)
> >   *
> >   * Free up a region of memory.
> >   *
> > - * Return: 0 if successful, -1 on failure
> > + * Return: 0 if successful, negative error code on failure
> >   */
> >  long lmb_free_flags(phys_addr_t base, phys_size_t size,
> >                     uint flags)
> > @@ -818,7 +828,7 @@ static phys_addr_t _lmb_alloc_addr(phys_addr_t base=
, phys_size_t size,
> >                                       lmb_memory[rgn].size,
> >                                       base + size - 1, 1)) {
> >                         /* ok, reserve the memory */
> > -                       if (lmb_reserve_flags(base, size, flags) >=3D 0=
)
> > +                       if (!lmb_reserve_flags(base, size, flags))
> >                                 return base;
> >                 }
> >         }
> > diff --git a/test/lib/lmb.c b/test/lib/lmb.c
> > index 0bd29e2a4fe7..48c3c966f8f2 100644
> > --- a/test/lib/lmb.c
> > +++ b/test/lib/lmb.c
> > @@ -754,7 +754,7 @@ static int lib_test_lmb_flags(struct unit_test_stat=
e *uts)
> >
> >         /* reserve again, same flag */
> >         ret =3D lmb_reserve_flags(0x40010000, 0x10000, LMB_NOMAP);
> > -       ut_asserteq(ret, -1L);
> > +       ut_asserteq(ret, -EEXIST);
> >         ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x1=
0000,
> >                    0, 0, 0, 0);
> >
> > --
> > 2.39.5
> >
>
> Other than that it looks good thanks for fixing this!
> Regards
> /Ilias
