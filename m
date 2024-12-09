Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192B6E77173
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 07:08:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B6B78954F;
	Mon,  9 Dec 2024 08:08:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BCChNTf6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEF278916B; Mon,  9 Dec 2024 08:08:04 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBA11895A8
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 08:08:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5d3dce16a3dso2873843a12.1
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 23:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733728080; x=1734332880; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wgYHyHxbA6YtfjAXMUzp3f0uHTuvtcPDNIoVUZhhSMY=;
 b=BCChNTf6SSt/Y7JYkv0FxFKh6YmGL8xiO1XJpPc9fiWDC6TXwQt5IqMpYBf1gTu4iD
 19GKUOdLQ/ZV2e3oki66XbVcnt4BREKC8FExF3f9OeNbbSTmT3Bmf/zl2MilBWDlC4p0
 SBKJ30c2V2xk/TOrbXUQI59qo3l/a54Nf2VkrSQYom8qLY42OpargJttwlhB1EWgLG0Y
 Uyhia5Qs/UL5pXGhsAtdNBNIY4HrLTWXACcVLPoXmZzWU1m2BNYXy21dKhsqFnnvuIqt
 ln3u0BKDSLo/5OgAIet85+3u1f5EMAqZoaxGyN2DXGV5XoT86kJoIOpVtaMTkIxQYwar
 xTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733728080; x=1734332880;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wgYHyHxbA6YtfjAXMUzp3f0uHTuvtcPDNIoVUZhhSMY=;
 b=wtSFU2ODE9Bn7qK2NMWdbNfrIgS6XiF5iMQEkkOaolcJGs45NyxkZWC+R5vNFQuXrJ
 yOJPWEe1oL2dS1LVpRjzrjlyRm/Ey3qOCIoCltyZ1oFQtThvWKPfYN0wUBXLzWEDK1/F
 iyLPBP0QFPQMPEOl0zQQts/Zt5CNlXV4lluUMgPM1YEzmCayso/C5AYyN2roAgWQw5i0
 YGj3cHEqluGX6DzrZe+GnK5J5crD0j0asmTZWylkdfrvbML+SITBezyPL0gnAOQPKZoZ
 B5snUXVIuuO12D5BJuvcBWM2rHmfBlO6F/z9hVhrny/cVqk9+gtPwXyYrJyTnldsPw4A
 ShJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLgJdrzSKyVCJIA6nc2M4+1vPXQ2xxkao8aEPYGcmIkrcK914L5joLskwF/RBXP2ZZECrxmAs=@lists.denx.de
X-Gm-Message-State: AOJu0YzGuqGkua/qTP0/hdMd3JbAuUlirnPS5ds5DdjDURzPF5ppdGrv
 LSVD/p6LCUrL3lGe018i/FkluPuAIa1B7Rc0GBFZNcdxWNiIKvgRLaMk3w7TvaNE6OBVJmCGAMg
 iLGgOlhIYqktoKyrre460Omfc7TFsxew1t3hLHA==
X-Gm-Gg: ASbGnctgvqGwUyu7uj8+GG0cCyalckq6UWFuw83/eFcMzLax5Mr1nv/CxUpclzh83Ui
 c9WAFEICW5uM7jkrCz20Kf2I1HoYLhJoU
X-Google-Smtp-Source: AGHT+IFA4E2j0iDFHXktZyrs4iWM/U55495w6gOfZVabMa/erVaiJQRktDl6UkW7Y+XaqGvj6lEyQouy5NlGZxzkLKI=
X-Received: by 2002:a05:6402:e83:b0:5d0:f6ed:4cd1 with SMTP id
 4fb4d7f45d1cf-5d3bd95f112mr12983354a12.10.1733728080331; Sun, 08 Dec 2024
 23:08:00 -0800 (PST)
MIME-Version: 1.0
References: <20241208002121.31887-1-semen.protsenko@linaro.org>
 <20241208002121.31887-3-semen.protsenko@linaro.org>
 <CAC_iWjJ4X+G=3OyfYmwu9aqdmRvYjhTfS6VcJ2nirVVYqcBhVA@mail.gmail.com>
In-Reply-To: <CAC_iWjJ4X+G=3OyfYmwu9aqdmRvYjhTfS6VcJ2nirVVYqcBhVA@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 9 Dec 2024 12:37:48 +0530
Message-ID: <CADg8p95FR8vJUY+fEgVnPAa2E38QAUn3J152ctCGD2WzY8AdFg@mail.gmail.com>
Subject: Re: [PATCH 2/6] lmb: Return -EEXIST in lmb_add_region_flags() if
 region already added
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
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

On Sun, 8 Dec 2024 at 12:20, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Sam,
>
> On Sun, 8 Dec 2024 at 02:21, Sam Protsenko <semen.protsenko@linaro.org> wrote:
> >
> > An attempt to add the already added LMB region (with exactly the same
> > start address, size and flags) using lmb_add_region_flags() ends up in
> > lmb_addrs_overlap() check, which eventually leads to either returning 0
> > if 'flags' is LMB_NONE, or -1 otherwise. It makes it impossible for the
> > user of this function to catch the case when the region is already added
> > and differentiate it from regular errors. That in turn may lead to
> > incorrect error handling in the caller code, like reporting misleading
> > errors or interrupting the normal code path where it could be treated as
> > the normal case. An example is boot_fdt_reserve_region() function, which
> > might be called twice (e.g. during board startup in initr_lmb(), and
> > then during 'booti' command booting the OS), thus trying to reserve
> > exactly the same memory regions described in device tree twice, which
> > produces an error message on second call.
> >
> > Implement the detection of cases when the already added region is trying
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
> >     Already added, flags == LMB_NONE      0      0      0
> >     Already added, flags != LMB_NONE      0      -1     -EEXIST
> >
> > Rework all affected functions and their documentation. Also fix the
> > corresponding unit test which checks reserving the same region with the
> > same flags to account for the changed return value.
> >
> > No functional change is intended (by this patch itself).
> >
> > Fixes: 1d9aa4a283da ("lmb: Fix the allocation of overlapping memory areas with !LMB_NONE")
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
> > @@ -183,8 +183,10 @@ static long lmb_resize_regions(struct alist *lmb_rgn_lst,
> >   * the function might resize an already existing region or coalesce two
> >   * adjacent regions.
> >   *
> > - *
> > - * Returns: 0 if the region addition successful, -1 on failure
> > + * Return:
> > + * * %0                - Added successfully, or it's already added (only if LMB_NONE)
> > + * * %-EEXIST  - The region is already added, and flags != LMB_NONE
> > + * * %-1       - Failure
> >   */
> >  static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
> >                                  phys_size_t size, enum lmb_flags flags)
> > @@ -202,6 +204,14 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
> >                 phys_size_t rgnsize = rgn[i].size;
> >                 enum lmb_flags rgnflags = rgn[i].flags;
> >
> > +               /* Already have this region, so we're done */
> > +               if (base == rgnbase && size == rgnsize && flags == rgnflags) {
> > +                       if (flags == LMB_NONE)
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
> There are two cases we return -1 there, we could return -EEXIST. Something like
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

+1 for this approach. Otherwise we are effectively reverting 1d9aa4a283da.

Sam, can you please check if this change also fixes the issue that you
see. Thanks.

-sughosh

> I am not sure about the lmb_resize_regions() failure, I think we
> should return a different error
>
> > +
> >                 ret = lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
> >                 if (ret > 0) {
> >                         if (flags != rgnflags)
> > @@ -667,7 +677,7 @@ long lmb_add(phys_addr_t base, phys_size_t size)
> >   *
> >   * Free up a region of memory.
> >   *
> > - * Return: 0 if successful, -1 on failure
> > + * Return: 0 if successful, negative error code on failure
> >   */
> >  long lmb_free_flags(phys_addr_t base, phys_size_t size,
> >                     uint flags)
> > @@ -818,7 +828,7 @@ static phys_addr_t _lmb_alloc_addr(phys_addr_t base, phys_size_t size,
> >                                       lmb_memory[rgn].size,
> >                                       base + size - 1, 1)) {
> >                         /* ok, reserve the memory */
> > -                       if (lmb_reserve_flags(base, size, flags) >= 0)
> > +                       if (!lmb_reserve_flags(base, size, flags))
> >                                 return base;
> >                 }
> >         }
> > diff --git a/test/lib/lmb.c b/test/lib/lmb.c
> > index 0bd29e2a4fe7..48c3c966f8f2 100644
> > --- a/test/lib/lmb.c
> > +++ b/test/lib/lmb.c
> > @@ -754,7 +754,7 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
> >
> >         /* reserve again, same flag */
> >         ret = lmb_reserve_flags(0x40010000, 0x10000, LMB_NOMAP);
> > -       ut_asserteq(ret, -1L);
> > +       ut_asserteq(ret, -EEXIST);
> >         ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x10000,
> >                    0, 0, 0, 0);
> >
> > --
> > 2.39.5
> >
>
> Other than that it looks good thanks for fixing this!
> Regards
> /Ilias
