Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8518C3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 15:26:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C02787E13;
	Mon, 29 Jul 2024 17:26:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dV26EQ1x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CE408785E; Mon, 29 Jul 2024 17:26:46 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 563798855C
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 17:26:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6bb687c3cceso6064736d6.0
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 08:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722266803; x=1722871603; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kQY+hdpLd5EQSjL7zXJWEmiECyn4x6jSR+Sf9ASZGeg=;
 b=dV26EQ1xK6SeOejHZfHTHjYLaEuRAcWZd41ZEuXVn2EbkgqarCXe9hjlI0Jeoe+T84
 Fzs64S92UjsSdQIgQrEPQKmrXgSifZPrEDCqr04LiifQN2I5/bXxWDRkawHCcO1g7CLI
 QXoOdHpO2cOkTZpuH8hAX1fLpr8nMiOn5tKSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266803; x=1722871603;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kQY+hdpLd5EQSjL7zXJWEmiECyn4x6jSR+Sf9ASZGeg=;
 b=ZtGMdBY7H0TZh+OrgoyveARkCoVewDWlcsaAdj9JaYqJVSpIuEbUTT1N7ZwJSjxgMF
 jwfsJ5gBqeXJJGVPBblOmmVnm0AnWE/2Ze2KLa6b1FD5wddo6K27zIJsoiXxhfFqOb3r
 z8PZeoLb9ULZQoJSc+JSQPAxvAuc2LFCBMmjlODcIbefbqiH9OOvmFUtzNIqOTBqDp3D
 Wsqvdo6BgTM6cigoDkXPrhyVL1lICMuOTvO/SG9yGb7fXKxms9DP+gwm11N/hW7RrCW5
 Y7KaFceoGqbEv+0Q5Ybd0ArSVwOnP1V1NcPrybLE5h0tSlaJvDFweFxPQBTRUW44s1bS
 jTfg==
X-Gm-Message-State: AOJu0YybvGIZTBOvrgMt1XzWh0FxKIe5BHH2enrjSOMIxVHSQ526W+px
 8MY5jHDI+7uHCmX4RhEYqxHXrili3qrH+VgRK02i9W6o15slX8mw4Ohb92BeTxEp34LNOoX9/65
 enMx1njmLECGFQbjh3SKJGoMw1MvoVCphbUUU
X-Google-Smtp-Source: AGHT+IGt+jLAYnZlQpt2UZMF/spVFAAr4kX6/Rk18ehw2PaYe+WmSt7cbOh/FDS0wdJ4DcGr2TWrSnykb9dbXM0PkjI=
X-Received: by 2002:a05:6214:2483:b0:6b7:9a1c:713b with SMTP id
 6a1803df08f44-6bb55aa2fb8mr95752806d6.35.1722266803314; Mon, 29 Jul 2024
 08:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-24-sughosh.ganu@linaro.org>
 <CAFLszTibBKMmPWjApmRUxRLWj11=Nf5NTz7+bGP+n5guYeFqYw@mail.gmail.com>
 <CADg8p94pVzK4AaBsCVg4PoQmbBHMKTdzB2MiBxuOzA6=Um3kmg@mail.gmail.com>
In-Reply-To: <CADg8p94pVzK4AaBsCVg4PoQmbBHMKTdzB2MiBxuOzA6=Um3kmg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:26:32 -0600
Message-ID: <CAFLszTjRMsOsxKLdhbgH3yY8Rv6yR-r3uoHycjuGh+zTAKqsZA@mail.gmail.com>
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

On Mon, 29 Jul 2024 at 02:40, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Fri, 26 Jul 2024 at 05:02, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Wed, 24 Jul 2024 at 00:04, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > Add a flags parameter to the LMB API functions. The parameter can then
> > > be used to pass any other type of reservations or allocations needed
> > > by the callers. These will be used in a subsequent set of changes for
> > > allocation requests coming from the EFI subsystem.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > > Changes since rfc: New patch
> > >
> > >  arch/arm/mach-apple/board.c       |  17 ++--
> > >  arch/arm/mach-snapdragon/board.c  |   2 +-
> > >  arch/arm/mach-stm32mp/dram_init.c |   4 +-
> > >  arch/powerpc/cpu/mpc85xx/mp.c     |   2 +-
> > >  arch/powerpc/lib/bootm.c          |   2 +-
> > >  board/xilinx/common/board.c       |   4 +-
> > >  boot/bootm.c                      |   5 +-
> > >  boot/image-board.c                |  15 ++-
> > >  boot/image-fdt.c                  |  15 +--
> > >  cmd/booti.c                       |   2 +-
> > >  cmd/bootz.c                       |   2 +-
> > >  cmd/load.c                        |   4 +-
> > >  drivers/iommu/apple_dart.c        |   6 +-
> > >  drivers/iommu/sandbox_iommu.c     |   6 +-
> > >  fs/fs.c                           |   2 +-
> > >  include/lmb.h                     |  23 ++---
> > >  lib/lmb.c                         |  48 ++++------
> > >  test/lib/lmb.c                    | 150 +++++++++++++++---------------
> > >  18 files changed, 150 insertions(+), 159 deletions(-)
> >
> > This negates any code-size advantage of dropping the lmb parameter.
> >
> > All of these are LMB_NONE. Can we have a separate function (e.g.
> > lmb_alloc_type()) for when we actually need to specify the type?
>
> We will be passing different values when we call the LMB API's from
> the EFI allocation function. This is only adding a parameter to the
> allocation API's, which I believe is better than adding separate
> functions which take a flag parameter only to be called from the EFI
> subsystem.

No i believe it is worse, unless there are a lot of such functions.
The flags are a special case, not the common case.

Regards,
SImon
