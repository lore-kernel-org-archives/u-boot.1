Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDE8C52D6F
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 21:52:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C982088B22;
	Tue,  6 Aug 2024 23:51:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f8TEvFAF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F2D988AE3; Tue,  6 Aug 2024 23:51:14 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8568C88AE8
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 23:51:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-75a6c290528so757671a12.1
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 14:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722981069; x=1723585869; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sVvYkxjvKtbBex6K2ayzyTMyjmbOSqIZwQO1gcU5mtY=;
 b=f8TEvFAFNhurdLmd2gYx9qlDiDXuHB9FFb5yabZr7pBdCLIOZ/uth5E+5+2LzQdbm8
 CLOlqZATOTvIa2mm/6XsZZut5az5k9zXWEaL7tpcaLNyEXHnIpibL//uD1DRszDDcLI3
 7ezDVzHMYRAoC/T9t489xdS+oVf4n2OX0Samc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722981069; x=1723585869;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sVvYkxjvKtbBex6K2ayzyTMyjmbOSqIZwQO1gcU5mtY=;
 b=Q8NOPLt97Jb5rLKDbao9JHSYPwEqJTmMREa6kf++NJ0XghyskFsPjEdmOZvw9zWx/K
 2jX/FQXJqbkMeApC2JUarERdPr03BTfYQWuiRTAkdshG/lmLKLTT2g+eB5f+gMTm9kH5
 FBgxWTgZ62QJssTrm8AckkukEvLKAENZXK8nLvU4OLHU5pwPzYfBujeFeoHR5pVL9q6Z
 i1Sa3fg/NadzXY5R7mmOXSDX2Vb9Vm7E2nQuJ+yHngn4wzRm3KNctdaK4rIINc//GQn1
 QQvcuAEk0EsIEVa4A8Kv74cM4pv1gOdpewerKFHcCLVCZA6FgggAU5texpJINzoGI0PJ
 OCHQ==
X-Gm-Message-State: AOJu0YxbQXTpCjNMYE7USENYrp/dsFvny+L6lkNznetzXccvCMGRPntP
 OYuvK+bSDElQZEUuyKivAMx9/6w2baHN4hKAjnhjB9nT6NefYTHa6/M1SQpx4i/UgSZLvDysFGn
 bUcpzffTBpe4x2det/dobh18M0ZUoTQcDpOU50bARa6ht6Vw=
X-Google-Smtp-Source: AGHT+IEg+tUxs73ngEkq8kbKbeTHZnhBTvoXHzL/Wi1WBY+T/nV/xvt4UFwDIvfjqBi5fQ14k++f1CnhPiRvDMCXZSE=
X-Received: by 2002:a17:90b:2712:b0:2c9:9ad5:7ca2 with SMTP id
 98e67ed59e1d1-2cff943187cmr16748808a91.13.1722981068968; Tue, 06 Aug 2024
 14:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-24-sughosh.ganu@linaro.org>
 <CAFLszTibBKMmPWjApmRUxRLWj11=Nf5NTz7+bGP+n5guYeFqYw@mail.gmail.com>
 <CADg8p94pVzK4AaBsCVg4PoQmbBHMKTdzB2MiBxuOzA6=Um3kmg@mail.gmail.com>
 <CAFLszTjRMsOsxKLdhbgH3yY8Rv6yR-r3uoHycjuGh+zTAKqsZA@mail.gmail.com>
 <CADg8p96wT2tfXU8o+M+8CuoyP1YF4OwKdg1ZS+2rkZzknMKGdA@mail.gmail.com>
In-Reply-To: <CADg8p96wT2tfXU8o+M+8CuoyP1YF4OwKdg1ZS+2rkZzknMKGdA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Aug 2024 15:50:47 -0600
Message-ID: <CAFLszTjShbhdrjz-p37LOkZqii2Nbdupm0BHCkGqGAAQ5+RNxg@mail.gmail.com>
Subject: Re: [PATCH 23/40] lmb: add a flags parameter to the API's
To: Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Sughosh,

On Mon, 5 Aug 2024 at 05:55, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Mon, 29 Jul 2024 at 20:56, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Mon, 29 Jul 2024 at 02:40, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > On Fri, 26 Jul 2024 at 05:02, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Sughosh,
> > > >
> > > > On Wed, 24 Jul 2024 at 00:04, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > >
> > > > > Add a flags parameter to the LMB API functions. The parameter can then
> > > > > be used to pass any other type of reservations or allocations needed
> > > > > by the callers. These will be used in a subsequent set of changes for
> > > > > allocation requests coming from the EFI subsystem.
> > > > >
> > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > ---
> > > > > Changes since rfc: New patch
> > > > >
> > > > >  arch/arm/mach-apple/board.c       |  17 ++--
> > > > >  arch/arm/mach-snapdragon/board.c  |   2 +-
> > > > >  arch/arm/mach-stm32mp/dram_init.c |   4 +-
> > > > >  arch/powerpc/cpu/mpc85xx/mp.c     |   2 +-
> > > > >  arch/powerpc/lib/bootm.c          |   2 +-
> > > > >  board/xilinx/common/board.c       |   4 +-
> > > > >  boot/bootm.c                      |   5 +-
> > > > >  boot/image-board.c                |  15 ++-
> > > > >  boot/image-fdt.c                  |  15 +--
> > > > >  cmd/booti.c                       |   2 +-
> > > > >  cmd/bootz.c                       |   2 +-
> > > > >  cmd/load.c                        |   4 +-
> > > > >  drivers/iommu/apple_dart.c        |   6 +-
> > > > >  drivers/iommu/sandbox_iommu.c     |   6 +-
> > > > >  fs/fs.c                           |   2 +-
> > > > >  include/lmb.h                     |  23 ++---
> > > > >  lib/lmb.c                         |  48 ++++------
> > > > >  test/lib/lmb.c                    | 150 +++++++++++++++---------------
> > > > >  18 files changed, 150 insertions(+), 159 deletions(-)
> > > >
> > > > This negates any code-size advantage of dropping the lmb parameter.
> > > >
> > > > All of these are LMB_NONE. Can we have a separate function (e.g.
> > > > lmb_alloc_type()) for when we actually need to specify the type?
> > >
> > > We will be passing different values when we call the LMB API's from
> > > the EFI allocation function. This is only adding a parameter to the
> > > allocation API's, which I believe is better than adding separate
> > > functions which take a flag parameter only to be called from the EFI
> > > subsystem.
> >
> > No i believe it is worse, unless there are a lot of such functions.
> > The flags are a special case, not the common case.
>
> I have done some size impact tests on the two scenarios, one where we
> have a common set of lmb allocation API functions, with an added flags
> parameter, and second where we have separate API's to be called from
> the EFI memory module. I have put out the results of the size impact
> [1].
>
> You will see that with common API's, we are not losing much even on
> boards with EFI_LOADER disabled. But otoh, on boards which have
> EFI_LOADER enabled, the gains are pretty significant. I believe we
> should reconsider using a common LMB API with the flags parameter.

Thanks for looking at it.

Did you do special versions of just lmb_alloc() and lmb_add() which
call the flags versions? It seems that there is no size advantage with
EFI_LOADER and only a small one with !EFI_LOADER. Can you please point
me to the code?

Regards,
Simon


>
> [1] - https://gist.github.com/sughoshg/a20207f26e19238fef86f710134d6efd
>
> >
> > Regards,
> > SImon
