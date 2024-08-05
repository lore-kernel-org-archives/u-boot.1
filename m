Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49098C3DA4A
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 11:55:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70F2C8870B;
	Mon,  5 Aug 2024 13:55:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FWnMM+X4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D75A1884C6; Mon,  5 Aug 2024 13:55:15 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F3958870B
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 13:55:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5a1337cfbb5so15725974a12.3
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 04:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722858912; x=1723463712; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y9HJXETpUPKu0tv68zbiDPmcgsdLYqpBLt6RxsniRwY=;
 b=FWnMM+X4HUnTIEZVJXje4ljAzc6e6V9bGXwIGy2lDjm3HYnFRqAK5dkbd+bDTIvvuu
 uIAZfr+zezfetkgmyJIcRIdcuUNWh1IJkGsAsQ9rlb6VQiT1/rog3bYeYXER5XaK8GXE
 +Ykf+iU1SXJyeEkgsIV0vRi7Wg9TdK/cG3C67v/TCeVjmeZUxJvf2OgnmKbX/CMFXuar
 QZIJAl2SE79LV2dL/UqllzlKnIQsPmQXE5KMuJDS8zYUaIxvpRVZB3uYcXjVF4BAnsyG
 y+vru7KUhCp0PWbCpJlgjywH+AhubZldSNX/lgH3MIwTdjbazbsGhHKL8bZZmYM+6In8
 DQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722858912; x=1723463712;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y9HJXETpUPKu0tv68zbiDPmcgsdLYqpBLt6RxsniRwY=;
 b=uq+x4ncesyJErDjZGDkkpumQDVaNpzCKoW5aB9bU1sid5gszQPdDEgm8f0D32gMOQl
 NjbnCnGNx8RGYhgw/g/B0jCudCpum7lu87Bz2v6Z0EM4GYz2bTQ6qTnjT6ThjX0nKFo0
 xiGJwVFd6aYoe3MCggLVPPFwJGxej8lYF/y3ghfELG/KbkacSVngVFQeXNk4lLCGBq+l
 lzlZnEOmIkr6BaafrNI0inR1XmcIAe9n2OUiiLnz6ZNnHcHvCUzoPwjycsHYfngDoMIV
 QbbKmHdg+3nF3rjn7J0pC5Q+K7Rf1IhNDwrrdfNdhCRwhnolJ7B+q6CPLDjAw+TIE2UX
 V7Hg==
X-Gm-Message-State: AOJu0YyYr1CFfG7MiXcghCCkZ9mf+IZOpCBvitAGwVSW1iMqYgt4SSU2
 o5gadSFCd9A9HIfXR/YFR7F7UhIyq3UAGzXLs0w8OqfDr+NKNXb+L2bbB5CVQwg7kfi//S8SKno
 2UfUv/xsq7DoswykTv9N8z3HGaxAFlXxdJ/qxYA==
X-Google-Smtp-Source: AGHT+IFFvuSGa2Oy20KlgA7DsS+sXFVwdwH8gNCm8ZamIG+m6TOwhTNdTLobRmHOWjS/yH/CXNc0x02JACF1C7ybOv4=
X-Received: by 2002:a05:6402:40c5:b0:5b9:462d:c538 with SMTP id
 4fb4d7f45d1cf-5b9462dc9aamr7517446a12.3.1722858911756; Mon, 05 Aug 2024
 04:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-24-sughosh.ganu@linaro.org>
 <CAFLszTibBKMmPWjApmRUxRLWj11=Nf5NTz7+bGP+n5guYeFqYw@mail.gmail.com>
 <CADg8p94pVzK4AaBsCVg4PoQmbBHMKTdzB2MiBxuOzA6=Um3kmg@mail.gmail.com>
 <CAFLszTjRMsOsxKLdhbgH3yY8Rv6yR-r3uoHycjuGh+zTAKqsZA@mail.gmail.com>
In-Reply-To: <CAFLszTjRMsOsxKLdhbgH3yY8Rv6yR-r3uoHycjuGh+zTAKqsZA@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 5 Aug 2024 17:25:00 +0530
Message-ID: <CADg8p96wT2tfXU8o+M+8CuoyP1YF4OwKdg1ZS+2rkZzknMKGdA@mail.gmail.com>
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

On Mon, 29 Jul 2024 at 20:56, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Mon, 29 Jul 2024 at 02:40, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Fri, 26 Jul 2024 at 05:02, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sughosh,
> > >
> > > On Wed, 24 Jul 2024 at 00:04, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > >
> > > > Add a flags parameter to the LMB API functions. The parameter can then
> > > > be used to pass any other type of reservations or allocations needed
> > > > by the callers. These will be used in a subsequent set of changes for
> > > > allocation requests coming from the EFI subsystem.
> > > >
> > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > ---
> > > > Changes since rfc: New patch
> > > >
> > > >  arch/arm/mach-apple/board.c       |  17 ++--
> > > >  arch/arm/mach-snapdragon/board.c  |   2 +-
> > > >  arch/arm/mach-stm32mp/dram_init.c |   4 +-
> > > >  arch/powerpc/cpu/mpc85xx/mp.c     |   2 +-
> > > >  arch/powerpc/lib/bootm.c          |   2 +-
> > > >  board/xilinx/common/board.c       |   4 +-
> > > >  boot/bootm.c                      |   5 +-
> > > >  boot/image-board.c                |  15 ++-
> > > >  boot/image-fdt.c                  |  15 +--
> > > >  cmd/booti.c                       |   2 +-
> > > >  cmd/bootz.c                       |   2 +-
> > > >  cmd/load.c                        |   4 +-
> > > >  drivers/iommu/apple_dart.c        |   6 +-
> > > >  drivers/iommu/sandbox_iommu.c     |   6 +-
> > > >  fs/fs.c                           |   2 +-
> > > >  include/lmb.h                     |  23 ++---
> > > >  lib/lmb.c                         |  48 ++++------
> > > >  test/lib/lmb.c                    | 150 +++++++++++++++---------------
> > > >  18 files changed, 150 insertions(+), 159 deletions(-)
> > >
> > > This negates any code-size advantage of dropping the lmb parameter.
> > >
> > > All of these are LMB_NONE. Can we have a separate function (e.g.
> > > lmb_alloc_type()) for when we actually need to specify the type?
> >
> > We will be passing different values when we call the LMB API's from
> > the EFI allocation function. This is only adding a parameter to the
> > allocation API's, which I believe is better than adding separate
> > functions which take a flag parameter only to be called from the EFI
> > subsystem.
>
> No i believe it is worse, unless there are a lot of such functions.
> The flags are a special case, not the common case.

I have done some size impact tests on the two scenarios, one where we
have a common set of lmb allocation API functions, with an added flags
parameter, and second where we have separate API's to be called from
the EFI memory module. I have put out the results of the size impact
[1].

You will see that with common API's, we are not losing much even on
boards with EFI_LOADER disabled. But otoh, on boards which have
EFI_LOADER enabled, the gains are pretty significant. I believe we
should reconsider using a common LMB API with the flags parameter.

-sughosh

[1] - https://gist.github.com/sughoshg/a20207f26e19238fef86f710134d6efd

>
> Regards,
> SImon
