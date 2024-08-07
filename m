Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBB5C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 06:32:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FD6988A45;
	Wed,  7 Aug 2024 08:32:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S4i0YsaC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9F7488AA7; Wed,  7 Aug 2024 08:32:09 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BFC588A45
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 08:32:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5bb8e62575eso757972a12.3
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 23:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723012327; x=1723617127; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MDZBZmPAx+eH8iKMNkJfaefFNWc8mY4A6ne8m3JoRlI=;
 b=S4i0YsaCN7nM3lBHV2DYtTfPOQN9rjJdGPqsQlp/wzJ5qC/FIl2dss5YzR/qfXKBWq
 DVQO+4OTBQFh4BA/MXmnvBKpB0Q999BamEcnzKZCg9Em7OyWJ3Hhnzf57KCcGv4I8Sqg
 77maL3mzmMABokIVrNBTbvDJ9n5ZqtQJSwJ1NKTLvt3A2tgvKc6NThQU8+skTbDAX3Pt
 oDeUKr6fMBrdjeQwaPj5GIAZl/RXLWwNVUq+/Kt0ECQBX+fiByiOHal1CCwyFvlpqTSs
 g33OOW/U1ZkYXHGgHpQZEZp5HlpmRUpcyJtDfeZeNtZ9sEi6gb3nIdFC2lyt3m8oWY31
 KOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723012327; x=1723617127;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MDZBZmPAx+eH8iKMNkJfaefFNWc8mY4A6ne8m3JoRlI=;
 b=XGhTYMaqa9jGH0Ux4pkMYBbx/2lWkbZvGcW3Kdk0Nh8RVqXTgtRpE0eQBhLr1BqEet
 CtWfHghCFtW6a/dRA2aYsOgIcEdveCmWXVmhuKWvRe5Zf6c2HIyxReqg8/1BHTrP277e
 80jM+kF7WezjVh0Oic+2SrX7y84NS8WQTK+SGGw3EcVmFDCO2Nc4zBwUr/vXnnlUs3mE
 3KRo3rbs3dWqUVi5ivkhc3D9xlqB1V0cGNxOKo9CIxPbQJu1IL7WpFasjN/JdR8AznqM
 bNRl0qbaQ0uYfQnzqZ6FlEV7/ENWry26sfHM0R8/NkDV4/Yoakf6yRkeKlVOX+BCOjhr
 yyng==
X-Gm-Message-State: AOJu0YxPjboL4QVH18tR/rExbvAwAIamm0Ei9pyVvTYRrXr2Qn3U2JrJ
 Rv0DUppVm9BM9Z4DBbLefsct66MO626l8ahkVgWt6wFYxTOUErMo+CrQsYEWpriHsoPteTQMDBc
 3x5HZ4W/fpTOgY8TvTXAhnvas9eliUWLsIiEmIA==
X-Google-Smtp-Source: AGHT+IGL1/p7d4nf2FsK4O+ktGFYk0/eEYrRHS80FXhssd+rYpjNvi0P5+Jxu8fGYTynngcUGgJptoq47SKNdqHWbuk=
X-Received: by 2002:a05:6402:706:b0:5a2:8f7d:aff4 with SMTP id
 4fb4d7f45d1cf-5b7f40a4cbbmr14882301a12.20.1723012326547; Tue, 06 Aug 2024
 23:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-24-sughosh.ganu@linaro.org>
 <CAFLszTibBKMmPWjApmRUxRLWj11=Nf5NTz7+bGP+n5guYeFqYw@mail.gmail.com>
 <CADg8p94pVzK4AaBsCVg4PoQmbBHMKTdzB2MiBxuOzA6=Um3kmg@mail.gmail.com>
 <CAFLszTjRMsOsxKLdhbgH3yY8Rv6yR-r3uoHycjuGh+zTAKqsZA@mail.gmail.com>
 <CADg8p96wT2tfXU8o+M+8CuoyP1YF4OwKdg1ZS+2rkZzknMKGdA@mail.gmail.com>
 <CAFLszTjShbhdrjz-p37LOkZqii2Nbdupm0BHCkGqGAAQ5+RNxg@mail.gmail.com>
In-Reply-To: <CAFLszTjShbhdrjz-p37LOkZqii2Nbdupm0BHCkGqGAAQ5+RNxg@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 7 Aug 2024 12:01:55 +0530
Message-ID: <CADg8p97+R_o0ph2ycceDp2rsxC0bD8mhU+Y=BN6=tvDOUEvFWw@mail.gmail.com>
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

On Wed, 7 Aug 2024 at 03:21, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Mon, 5 Aug 2024 at 05:55, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Mon, 29 Jul 2024 at 20:56, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sughosh,
> > >
> > > On Mon, 29 Jul 2024 at 02:40, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > >
> > > > On Fri, 26 Jul 2024 at 05:02, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Sughosh,
> > > > >
> > > > > On Wed, 24 Jul 2024 at 00:04, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > > >
> > > > > > Add a flags parameter to the LMB API functions. The parameter can then
> > > > > > be used to pass any other type of reservations or allocations needed
> > > > > > by the callers. These will be used in a subsequent set of changes for
> > > > > > allocation requests coming from the EFI subsystem.
> > > > > >
> > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > ---
> > > > > > Changes since rfc: New patch
> > > > > >
> > > > > >  arch/arm/mach-apple/board.c       |  17 ++--
> > > > > >  arch/arm/mach-snapdragon/board.c  |   2 +-
> > > > > >  arch/arm/mach-stm32mp/dram_init.c |   4 +-
> > > > > >  arch/powerpc/cpu/mpc85xx/mp.c     |   2 +-
> > > > > >  arch/powerpc/lib/bootm.c          |   2 +-
> > > > > >  board/xilinx/common/board.c       |   4 +-
> > > > > >  boot/bootm.c                      |   5 +-
> > > > > >  boot/image-board.c                |  15 ++-
> > > > > >  boot/image-fdt.c                  |  15 +--
> > > > > >  cmd/booti.c                       |   2 +-
> > > > > >  cmd/bootz.c                       |   2 +-
> > > > > >  cmd/load.c                        |   4 +-
> > > > > >  drivers/iommu/apple_dart.c        |   6 +-
> > > > > >  drivers/iommu/sandbox_iommu.c     |   6 +-
> > > > > >  fs/fs.c                           |   2 +-
> > > > > >  include/lmb.h                     |  23 ++---
> > > > > >  lib/lmb.c                         |  48 ++++------
> > > > > >  test/lib/lmb.c                    | 150 +++++++++++++++---------------
> > > > > >  18 files changed, 150 insertions(+), 159 deletions(-)
> > > > >
> > > > > This negates any code-size advantage of dropping the lmb parameter.
> > > > >
> > > > > All of these are LMB_NONE. Can we have a separate function (e.g.
> > > > > lmb_alloc_type()) for when we actually need to specify the type?
> > > >
> > > > We will be passing different values when we call the LMB API's from
> > > > the EFI allocation function. This is only adding a parameter to the
> > > > allocation API's, which I believe is better than adding separate
> > > > functions which take a flag parameter only to be called from the EFI
> > > > subsystem.
> > >
> > > No i believe it is worse, unless there are a lot of such functions.
> > > The flags are a special case, not the common case.
> >
> > I have done some size impact tests on the two scenarios, one where we
> > have a common set of lmb allocation API functions, with an added flags
> > parameter, and second where we have separate API's to be called from
> > the EFI memory module. I have put out the results of the size impact
> > [1].
> >
> > You will see that with common API's, we are not losing much even on
> > boards with EFI_LOADER disabled. But otoh, on boards which have
> > EFI_LOADER enabled, the gains are pretty significant. I believe we
> > should reconsider using a common LMB API with the flags parameter.
>
> Thanks for looking at it.
>
> Did you do special versions of just lmb_alloc() and lmb_add() which
> call the flags versions? It seems that there is no size advantage with
> EFI_LOADER and only a small one with !EFI_LOADER. Can you please point
> me to the code?

For the separate API version, I introduced new versions
lmb_alloc_flags(), lmb_alloc_base_flags(), lmb_alloc_addr_flags() and
lmb_free_flags(), which are being called from the EFI memory module. I
have pushed the two branches [1] [2] on my github. Please take a look.

Btw, both these branches are based on your v5 of the alist patches,
and also incorporate the stack based implementation for running the
lmb tests. So except for either having common API's, or not, there are
no other differences between the two. Thanks.

-sughosh

[1] - https://github.com/sughoshg/u-boot/tree/lmb_efi_common_apis_nrfc_v2
[2] - https://github.com/sughoshg/u-boot/tree/lmb_efi_separate_flags_apis_nrfc_v2

>
> Regards,
> Simon
>
>
> >
> > [1] - https://gist.github.com/sughoshg/a20207f26e19238fef86f710134d6efd
> >
> > >
> > > Regards,
> > > SImon
