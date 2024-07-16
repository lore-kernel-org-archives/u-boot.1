Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C97C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 06:30:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3AFA88602;
	Tue, 16 Jul 2024 08:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CB8zvfJe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C22B88385; Tue, 16 Jul 2024 08:30:39 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E73888602
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 08:30:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-58ba3e38027so5376737a12.1
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 23:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721111437; x=1721716237; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Jr46pKXohn9chrBmFIKoYcKCJDkwRDqauwz3Y/IG6VY=;
 b=CB8zvfJeQOfhLdaw+QFA7D4wIzSCSMchgMc7kIQdaM2OC/xS+rqDw03aLDyhWqgver
 FUanXIJwBHxZIUNPQVp/VOm5vsq5J93o/8PdIXA8R3VAlxXQI//+e5hPzwMnvdrsJ1Lu
 +H7yxS+Gftyu39wCYiumLuq9ESxM1jqQhxtDlqcHW/rGnwi7etu47rwtNyl7UoT1BU2X
 +lCpFJgkz31WTPIpRQGzoxwu9XNyVmYIVdAQdvXm6w7U7FwEGKIdl/r/8YdYF/wc9zC3
 PcUGBBUbCNHVm13uVas1UX+NBfZhf2U0GJpGsk4ofUv+MXWFuYmQK3f11jGDUaZUQWu7
 0Ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721111437; x=1721716237;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jr46pKXohn9chrBmFIKoYcKCJDkwRDqauwz3Y/IG6VY=;
 b=xGV6UqQFsJ+YAhh0cCqPBb/WH1kmfIxC0Ce9p2qQNTt+gnHqTBoE0z5FJ0Rtyqdo8Y
 HAwG34hGOLeErDCynoA+n9Zp9AxQMegfhEGcLLtlMA+yBzUkylNFjcyN8iM+dEgT8GIR
 KKwDDv9IhSo5JsMy4oARBjcz04GRCkES98jQXgGRcK9pb1lijgpF8nvMSapTo/2RMlcT
 /5cEIwydyV5Ov3PkQkdfEqebKbVq2Cn0jcI2p0XSCHB5Jlwfb1THl5usfSR73b43DeX9
 WCCwGRT8IYbUh9NXIYTXN/6uXtvsB7ruoaaDtbWygk+/+pV6zuOMYCylLxwP3uibjQBw
 1TBw==
X-Gm-Message-State: AOJu0YzFbOn6q1XJhQYsUBIucci5rPOl360bhJuOa8XZPmmUd4RtWS2N
 biLrGyYsBlSIfiNB2mKQl5wJoHqn373g6QvjQcWJ+f+DwHb99ndQlU6ah0Szffe0xCGaoUsWZlv
 N+uAvCnmTtxqc21mhaEQ6unI98sZwWkkOgzeVZA==
X-Google-Smtp-Source: AGHT+IFAK9XeVQxa4cyFdPx0YH4qUtBJColoThRzKQvpAYTNpoGxiwh8xzqbCsrAWfl41kfEigw76jYhmU1U3yUKN1Q=
X-Received: by 2002:a05:6402:26c6:b0:57c:c2b6:176d with SMTP id
 4fb4d7f45d1cf-59ef00abb97mr779398a12.32.1721111436713; Mon, 15 Jul 2024
 23:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-10-sughosh.ganu@linaro.org>
 <CAFLszTiN1K4tazqaBBCS37VHVtJ0ise2RQC2AGaLKg1SMFj9JQ@mail.gmail.com>
 <CADg8p974419Rqisf0qwH46FVobDYsxuLjnD5UV4kGRPcK7_vCg@mail.gmail.com>
 <CAFLszTjH=fvN3bWTieqfmKvdT9mdKRzBV4+zBBftD4Vg9ZwX=Q@mail.gmail.com>
In-Reply-To: <CAFLszTjH=fvN3bWTieqfmKvdT9mdKRzBV4+zBBftD4Vg9ZwX=Q@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 16 Jul 2024 12:00:25 +0530
Message-ID: <CADg8p96Xc3vmfTf6GWFyzGBAMvZ2KM=-kBYRPGyi0RyP7R8_wQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/48] lmb: remove call to lmb_init()
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
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

hi Simon,

On Mon, 15 Jul 2024 at 17:09, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Mon, 15 Jul 2024 at 10:31, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > hi Simon,
> >
> > On Sat, 13 Jul 2024 at 20:45, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > kHi Sughosh,
> > >
> > > On Thu, 4 Jul 2024 at 08:36, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > >
> > > > The LMB module will be changed to have persistent and global memory
> > > > maps of available and used memory. With this change, there won't be
> > > > any need to explicitly initialise the LMB memory maps. Remove the call
> > > > to the lmb_init() function.
> > > >
> > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > ---
> > > > Changes since V1: New patch
> > > >
> > > >  arch/arm/mach-stm32mp/dram_init.c |  1 -
> > > >  board/xilinx/common/board.c       |  1 -
> > > >  drivers/iommu/apple_dart.c        |  1 -
> > > >  drivers/iommu/sandbox_iommu.c     |  1 -
> > > >  include/lmb.h                     |  1 -
> > > >  lib/lmb.c                         | 18 ------------------
> > > >  test/lib/lmb.c                    | 18 ------------------
> > > >  7 files changed, 41 deletions(-)
> > >
> > > I can't actually find the call to lmb_init(). Where is it?
> >
> > Sorry, I do not understand this question. This patch removes the
> > lmb_init() definition, as well as calls to the function from the rest
> > of the files.
>
> I see later you add lmb_mem_regions_init() so that there are two init
> functions. We should really only have one.

Okay, let me see how I can put the functionality of lmb_init() needed
for the tests into the lmb_mem_regions_init() function.

-sughosh

>
> Regards,
> Simon
