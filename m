Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA7AC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 08:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26FED8892F;
	Fri,  9 Aug 2024 10:25:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v6Ux8/k6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9603488581; Fri,  9 Aug 2024 10:25:08 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1265D889B8
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 10:25:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5a156556fb4so2169756a12.3
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 01:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723191905; x=1723796705; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bz4kf34hMMAbbP8SbPReKJqiCmfw6Qvf+hQA2Ft3LkE=;
 b=v6Ux8/k6IT0NOIrNBOAolols4CtzBhzaK0kaqf61UdNMOpanEoUybt2m0+Ord3VeG5
 rCWOX5dOGYLqzxu/A2dFm7Jt011eCa0CJ7RDPX4w0l7BMAs6amiXiUeySTfh5T6DBDkZ
 JNMyrkDZQiQNkEu+gX+u7j5LZHA9LmeFi3C06EB7yCPlncxmz+gHqXezRDb8SveJV1q3
 2Sdr43ARszGJpaZTkPGyyrFRN6EzWFQE2V3f/1V38ZVt4B3uAXougGlA+R2Tfezs2Ylj
 z6/2J3nV1RB1TAyfUY0bvxWeIjMcFyLgBOs+ey9EQawz/fHKi7lwLDU0xb9HmpNNHVHL
 G35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723191905; x=1723796705;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bz4kf34hMMAbbP8SbPReKJqiCmfw6Qvf+hQA2Ft3LkE=;
 b=P1CtVEj2UrMaHKsPiL1bbBF14uw3HUF1TobF+lLcjHbTLcCHNwlZOGC/BmniGXLw/V
 UL4g/tVKuMPNyqHg2TBlEzYzh17V7e8ra8AaABhHjAJcLKiD5PDw/0vLsMSFr9uqhSnQ
 L7Ou+GhL4ENf+hTNF6heIB8ODdM9MJ3z/DKJ/bHWcCoNTt0sjmJUk0YxMvlUApLBVq5H
 PO1vJTtDkLfLupc0gMu+1tv8kAUEk3FdH4O3Cebaa9gNXwBYNLFQoLNqdoyEfgTvKjuw
 XOlo2qmYDEiW2zTYVvXfqX6WQH4xi0Ww6+6uuhTVAGZOoVCvCGVvYpcBpoDLNN2Z9fPI
 oBGA==
X-Gm-Message-State: AOJu0YzETPmbmilct1WxWRw7S6gPbcJ2gNx7BD/ts4ZgZuADLmmQolcc
 pcPXSwkdbsAzHWI586BX+czjtLdfog/HhicqqRzAkbDIRFBY+QLYV/tXCU7UFxKT1Q6DZA4/LDJ
 V87FblhVvUYdNd/dArkg4b34Xc6UpnbzYG0kKdw==
X-Google-Smtp-Source: AGHT+IFqRldML3GkRJrdZRGwKYzYTI8NS2zQNNsours1QEArSL0LSEJ8h9RvLqE40eGbyDQMkYnJK7WopT63XYfdkZ0=
X-Received: by 2002:a05:6402:1d52:b0:5a2:c1b1:4cc with SMTP id
 4fb4d7f45d1cf-5bd0a617c06mr725963a12.26.1723191905246; Fri, 09 Aug 2024
 01:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-24-sughosh.ganu@linaro.org>
 <CAFLszTibBKMmPWjApmRUxRLWj11=Nf5NTz7+bGP+n5guYeFqYw@mail.gmail.com>
 <CADg8p94pVzK4AaBsCVg4PoQmbBHMKTdzB2MiBxuOzA6=Um3kmg@mail.gmail.com>
 <CAFLszTjRMsOsxKLdhbgH3yY8Rv6yR-r3uoHycjuGh+zTAKqsZA@mail.gmail.com>
 <CADg8p96wT2tfXU8o+M+8CuoyP1YF4OwKdg1ZS+2rkZzknMKGdA@mail.gmail.com>
 <CAFLszTjShbhdrjz-p37LOkZqii2Nbdupm0BHCkGqGAAQ5+RNxg@mail.gmail.com>
 <CADg8p97+R_o0ph2ycceDp2rsxC0bD8mhU+Y=BN6=tvDOUEvFWw@mail.gmail.com>
 <CAFLszTgCVfTE7J8hPbosck2VYXaG6W9XMA=XyQJCETkThq+YmQ@mail.gmail.com>
In-Reply-To: <CAFLszTgCVfTE7J8hPbosck2VYXaG6W9XMA=XyQJCETkThq+YmQ@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 9 Aug 2024 13:54:53 +0530
Message-ID: <CADg8p95qdLUWSyMQM3uQ+szPHoe2H=SxvdEczyNCFWG2ZdK5JQ@mail.gmail.com>
Subject: Re: [PATCH 23/40] lmb: add a flags parameter to the API's
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

On Thu, 8 Aug 2024 at 19:58, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Wed, 7 Aug 2024 at 00:32, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Wed, 7 Aug 2024 at 03:21, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sughosh,
> > >
> > > On Mon, 5 Aug 2024 at 05:55, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > >
> > > > On Mon, 29 Jul 2024 at 20:56, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Sughosh,
> > > > >
> > > > > On Mon, 29 Jul 2024 at 02:40, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > > >
> > > > > > On Fri, 26 Jul 2024 at 05:02, Simon Glass <sjg@chromium.org> wrote:
> > > > > > >
> > > > > > > Hi Sughosh,
> > > > > > >
> > > > > > > On Wed, 24 Jul 2024 at 00:04, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > > > > >
> > > > > > > > Add a flags parameter to the LMB API functions. The parameter can then
> > > > > > > > be used to pass any other type of reservations or allocations needed
> > > > > > > > by the callers. These will be used in a subsequent set of changes for
> > > > > > > > allocation requests coming from the EFI subsystem.
> > > > > > > >
> > > > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > > > ---
> > > > > > > > Changes since rfc: New patch
> > > > > > > >
> > > > > > > >  arch/arm/mach-apple/board.c       |  17 ++--
> > > > > > > >  arch/arm/mach-snapdragon/board.c  |   2 +-
> > > > > > > >  arch/arm/mach-stm32mp/dram_init.c |   4 +-
> > > > > > > >  arch/powerpc/cpu/mpc85xx/mp.c     |   2 +-
> > > > > > > >  arch/powerpc/lib/bootm.c          |   2 +-
> > > > > > > >  board/xilinx/common/board.c       |   4 +-
> > > > > > > >  boot/bootm.c                      |   5 +-
> > > > > > > >  boot/image-board.c                |  15 ++-
> > > > > > > >  boot/image-fdt.c                  |  15 +--
> > > > > > > >  cmd/booti.c                       |   2 +-
> > > > > > > >  cmd/bootz.c                       |   2 +-
> > > > > > > >  cmd/load.c                        |   4 +-
> > > > > > > >  drivers/iommu/apple_dart.c        |   6 +-
> > > > > > > >  drivers/iommu/sandbox_iommu.c     |   6 +-
> > > > > > > >  fs/fs.c                           |   2 +-
> > > > > > > >  include/lmb.h                     |  23 ++---
> > > > > > > >  lib/lmb.c                         |  48 ++++------
> > > > > > > >  test/lib/lmb.c                    | 150 +++++++++++++++---------------
> > > > > > > >  18 files changed, 150 insertions(+), 159 deletions(-)
> > > > > > >
> > > > > > > This negates any code-size advantage of dropping the lmb parameter.
> > > > > > >
> > > > > > > All of these are LMB_NONE. Can we have a separate function (e.g.
> > > > > > > lmb_alloc_type()) for when we actually need to specify the type?
> > > > > >
> > > > > > We will be passing different values when we call the LMB API's from
> > > > > > the EFI allocation function. This is only adding a parameter to the
> > > > > > allocation API's, which I believe is better than adding separate
> > > > > > functions which take a flag parameter only to be called from the EFI
> > > > > > subsystem.
> > > > >
> > > > > No i believe it is worse, unless there are a lot of such functions.
> > > > > The flags are a special case, not the common case.
> > > >
> > > > I have done some size impact tests on the two scenarios, one where we
> > > > have a common set of lmb allocation API functions, with an added flags
> > > > parameter, and second where we have separate API's to be called from
> > > > the EFI memory module. I have put out the results of the size impact
> > > > [1].
> > > >
> > > > You will see that with common API's, we are not losing much even on
> > > > boards with EFI_LOADER disabled. But otoh, on boards which have
> > > > EFI_LOADER enabled, the gains are pretty significant. I believe we
> > > > should reconsider using a common LMB API with the flags parameter.
> > >
> > > Thanks for looking at it.
> > >
> > > Did you do special versions of just lmb_alloc() and lmb_add() which
> > > call the flags versions? It seems that there is no size advantage with
> > > EFI_LOADER and only a small one with !EFI_LOADER. Can you please point
> > > me to the code?
> >
> > For the separate API version, I introduced new versions
> > lmb_alloc_flags(), lmb_alloc_base_flags(), lmb_alloc_addr_flags() and
> > lmb_free_flags(), which are being called from the EFI memory module. I
> > have pushed the two branches [1] [2] on my github. Please take a look.
> >
> > Btw, both these branches are based on your v5 of the alist patches,
> > and also incorporate the stack based implementation for running the
> > lmb tests. So except for either having common API's, or not, there are
> > no other differences between the two. Thanks.
>
> Thanks for the info.
>
> The non-flags functions can call the flags functions, so that you
> don't create a new code path. Something like this:
>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 726e6c38227..0a251c587fe 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -528,7 +528,7 @@ long lmb_free_flags(phys_addr_t base, phys_size_t size,
>
>  long lmb_free(phys_addr_t base, phys_size_t size)
>  {
> -       return __lmb_free(base, size);
> +       return lmb_free_flags(base, size, LMB_NONE);
>  }
>
>  long lmb_reserve_flags(phys_addr_t base, phys_size_t size, enum
> lmb_flags flags)
> @@ -624,7 +624,7 @@ static phys_addr_t __lmb_alloc_base(phys_size_t
> size, ulong align,
>
>  phys_addr_t lmb_alloc(phys_size_t size, ulong align)
>  {
> -       return lmb_alloc_base(size, align, LMB_ALLOC_ANYWHERE);
> +       return lmb_alloc_flags(size, align, LMB_NONE);
>  }
>
>  phys_addr_t lmb_alloc_flags(phys_size_t size, ulong align, uint flags)
> @@ -635,15 +635,7 @@ phys_addr_t lmb_alloc_flags(phys_size_t size,
> ulong align, uint flags)
>
>  phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr)
>  {
> -       phys_addr_t alloc;
> -
> -       alloc = __lmb_alloc_base(size, align, max_addr, LMB_NONE);
> -
> -       if (alloc == 0)
> -               printf("ERROR: Failed to allocate 0x%lx bytes below 0x%lx.\n",
> -                      (ulong)size, (ulong)max_addr);
> -
> -       return alloc;
> +       return lmb_alloc_base_flags(size, align, max_addr, LMB_NONE);
>  }
>
>  phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
> @@ -691,7 +683,7 @@ static phys_addr_t __lmb_alloc_addr(phys_addr_t
> base, phys_size_t size,
>   */
>  phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size)
>  {
> -       return __lmb_alloc_addr(base, size, LMB_NONE);
> +       return lmb_alloc_addr_flags(base, size, LMB_NONE);
>  }
>
>  phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
>
> But it only saves about 40 bytes on Thumb2. You can save another 16 by
> using the placeholder API:

Can you please explain the issue that you see with having a common set
of API's with the flags parameter added? The way I see it, the API's
are already undergoing a change where we are removing the struct lmb
instance as a parameter from all the API functions. With the change
that I propose, we are simply replacing the lmb instance parameter
with the flags parameter. So arguably we are not adding any additional
size here. Also, like the size tests show, we get a pretty good size
benefit when the EFI_LOADER is enabled.

So, if your argument is to keep the API's similar to their earlier
form, I think that they are undergoing a change in any case, so adding
the flags parameter is not so much of an issue. If there is any
problem that I am missing, I would like to understand that before we
go with separate API's. Thanks.

-sughosh

>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 0a251c587fe..f6c8f06629c 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -416,13 +416,12 @@ static long lmb_add_region_flags(struct alist
> *lmb_rgn_lst, phys_addr_t base,
>         if (coalesced)
>                 return coalesced;
>
> -       if (alist_full(lmb_rgn_lst) &&
> -           !alist_expand_by(lmb_rgn_lst, lmb_rgn_lst->alloc))
> +       if (!alist_add_placeholder(lmb_rgn_lst))
>                 return -1;
>         rgn = lmb_rgn_lst->data;
>
>         /* Couldn't coalesce the LMB, so add it to the sorted table. */
> -       for (i = lmb_rgn_lst->count; i >= 0; i--) {
> +       for (i = lmb_rgn_lst->count - 1; i >= 0; i--) {
>                 if (i && base < rgn[i - 1].base) {
>                         rgn[i] = rgn[i - 1];
>                 } else {
> @@ -433,8 +432,6 @@ static long lmb_add_region_flags(struct alist
> *lmb_rgn_lst, phys_addr_t base,
>                 }
>         }
>
> -       lmb_rgn_lst->count++;
> -
>         return 0;
>  }
>
> @@ -444,7 +441,6 @@ static long lmb_add_region(struct alist
> *lmb_rgn_lst, phys_addr_t base,
>         return lmb_add_region_flags(lmb_rgn_lst, base, size, LMB_NONE);
>  }
>
> -/* This routine may be called with relocation disabled. */
>  long lmb_add(phys_addr_t base, phys_size_t size)
>  {
>         long ret;
>
> --
> 2.34.1
>
> (patches are a bit rough, but I didn't think it worth sending them to
> the ML as real patches)
>
> If I am correct and we don't need to publish events, then that will
> save a little more space.
>
> Regards,
> Simon
>
> >
> > -sughosh
> >
> > [1] - https://github.com/sughoshg/u-boot/tree/lmb_efi_common_apis_nrfc_v2
> > [2] - https://github.com/sughoshg/u-boot/tree/lmb_efi_separate_flags_apis_nrfc_v2
> >
> > >
> > > Regards,
> > > Simon
> > >
> > >
> > > >
> > > > [1] - https://gist.github.com/sughoshg/a20207f26e19238fef86f710134d6efd
> > > >
> > > > >
> > > > > Regards,
> > > > > SImon
