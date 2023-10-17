Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD16CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 04:22:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 031B786A3C;
	Tue, 17 Oct 2023 06:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E/m7WiSd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C45586A3C; Tue, 17 Oct 2023 06:22:38 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C8BE86940
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 06:22:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-53db360294fso9254136a12.3
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 21:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697516555; x=1698121355; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cJlzgG8bk+1yt3k5qQATacv+TVM3E6pS8XLFCVuFWCE=;
 b=E/m7WiSdrppse1uDSiRaHKdeh+hCc5AKizQPzabodx+kILsQmNupbcXLMDEZz8K/qV
 oAhN3vVZbw9YnxDwkGterWx3dAz1HYFsd5G70c+zLqin5lF1F1ZgyD/fTBlaLMXckxOr
 dhLMmUiaJO5LC0EIAxK+ZDtt0lPlwp5UXxO9pKNNkMj6nFF8mVJBx8Q1gmvCsHYwuRLX
 5ORl6d7LnFzDX7zBrCLuOoTIZbJx21RB9j++L1gxk1vNfC3VPVqYGpeLjBVuvaP2d/nh
 2fNQ1ernMiveTHX3ruRVhmNByeGTuAjCHAifQOeCSvS6VJOhepa/fPSzr4TYNVjCBbWo
 l2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697516555; x=1698121355;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cJlzgG8bk+1yt3k5qQATacv+TVM3E6pS8XLFCVuFWCE=;
 b=ALcG7O0VnUuHWDrwtUMkKSoyaPCdd4bDv4uikMtj+SSCFVZ7GQM7DndkgR7f3qXUtS
 E9MoxK67KpQyWt5rnBY12yy7KasOD7PBFMQn0IEkpDHIi9oEIjztdSVXMckvhJzBoFpx
 Uowo7UNJZKencWDwGY3sy6Oe4gKXC/e8/mtr+IAr5LDhn5cj2XB3Gz90ReQQJdwL/htd
 LCw0W2E01VF5XtWP0oOxkE2aEPiC3zhQ2heHDk/Ad0q93yvKwXfejWVBU5XKp8QWLAcH
 EoJGo71fvgnesMrrajPKyXPzoAwmIenZ1F2pAOkg3MXTQlE9SUQJY7Rgkdj6+GFFJmFu
 qSng==
X-Gm-Message-State: AOJu0YyQ1znVFHPF9uB8Csu24ZVjRaQrjx3xMEP0ua/6yVjuUHn4EG6d
 Tz2d3Rppf36eIerFAPOVxA3HezAc4wN6ZP0STLA=
X-Google-Smtp-Source: AGHT+IEl5lLsNsrqCxgrg/D0wYl61SnaMuAvJE++88qIeTe6RlSt/5xfjsU2obRVNoHqnFhcjZV7Z7VtktyYqLgy804=
X-Received: by 2002:a50:9fe3:0:b0:53d:a1c0:410e with SMTP id
 c90-20020a509fe3000000b0053da1c0410emr1060874edf.7.1697516555308; Mon, 16 Oct
 2023 21:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230317162253.1049446-1-paul.liu@linaro.org>
 <20230317162253.1049446-2-paul.liu@linaro.org>
 <CAFOYHZC_Dveax85n0fLr5BFyZcLqsvUssn=J0oHyvN75bTaCUw@mail.gmail.com>
 <fac6ef1747ec318787f90a6d0c81163b@kernel.org>
 <CAFOYHZAmWj6cgXib+m3Dy+mABcwEmPWAHLUgxeBe=2JVLsgaYQ@mail.gmail.com>
 <CAFOYHZCNKJBv+J7dkoOjmPrfjr2TXB_vLqzKB2X4u0iwRpOCgA@mail.gmail.com>
 <87y1g2lsnk.wl-maz@kernel.org>
In-Reply-To: <87y1g2lsnk.wl-maz@kernel.org>
From: Chris Packham <judge.packham@gmail.com>
Date: Tue, 17 Oct 2023 17:22:23 +1300
Message-ID: <CAFOYHZBuc-tkg8jZ3wfg-8hGOY=eRxdhfMEFF_nz2LuJgRQfMQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: Use FEAT_HAFDBS to track dirty pages when
 available
To: Marc Zyngier <maz@kernel.org>
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 u-boot <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

On Tue, Oct 17, 2023 at 12:21=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrot=
e:
>
> On Mon, 16 Oct 2023 02:42:08 +0100,
> Chris Packham <judge.packham@gmail.com> wrote:
> >
> > On Sun, Oct 15, 2023 at 10:29=E2=80=AFAM Chris Packham <judge.packham@g=
mail.com> wrote:
> > >
> > >
> > >
> > > On Sat, 14 Oct 2023, 11:04 am Marc Zyngier, <maz@kernel.org> wrote:
> > >>
> > >> On 2023-10-13 03:40, Chris Packham wrote:
> > >> > Hi Marc, Paul,
> > >> >
> > >> > On Sat, Mar 18, 2023 at 5:23=E2=80=AFAM Ying-Chun Liu (PaulLiu)
> > >> > <paul.liu@linaro.org> wrote:
> > >> >>
> > >> >> From: Marc Zyngier <maz@kernel.org>
> > >> >>
> > >> >> Some recent arm64 cores have a facility that allows the page
> > >> >> table walker to track the dirty state of a page. This makes it
> > >> >> really efficient to perform CMOs by VA as we only need to look
> > >> >> at dirty pages.
> > >> >>
> > >> >> Signed-off-by: Marc Zyngier <maz@kernel.org>
> > >> >> [ Paul: pick from the Android tree. Rebase to the upstream ]
> > >> >> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> > >> >> Cc: Tom Rini <trini@konsulko.com>
> > >> >> Link:
> > >> >> https://android.googlesource.com/platform/external/u-boot/+/3c433=
724e6f830a6b2edd5ec3d4a504794887263
> > >> >
> > >> > I think this may have caused a regression for the Marvell AC5X
> > >> > board(s). I found that v2023.07 locked up at boot but v2023.01 was
> > >> > fine. The lockup seemed to be in the 'Net:' init probably just as =
the
> > >> > mvneta driver was being initialised.
> > >> >
> > >> > A git bisect led me to this change although for this specific chan=
ge
> > >> > instead of the lockup I get a crash so maybe I'm actually hitting =
a
> > >> > different issue.
> > >> >
> > >> > Any thoughts as to why this may have caused problems?
> > >>
> > >> Not really. What CPUs does this platform have? What is the offending
> > >> driver doing to trigger the issue? Can you provide some level of
> > >> tracing?
> > >
> > >
> > > The Marvell AC5X is a network switch ASIC with an integrated ARMv8 CP=
U (8.1 specifically I think).
> > >
> > > I think there is something that the mvneta driver is doing triggering=
 the issue. I have another AC5X based board without an Ethernet port that b=
oots just fine (this is also why I didn't notice earlier).
> > >
> > > I'll try and get some more debug out when I'm back in the office
> > >
> >
> > The thing the mvneta driver does that upsets things appears to be
> >
> >     mmu_set_region_dcache_behaviour((phys_addr_t)bd_space, BD_SPACE,
> >                                                           DCACHE_OFF);
> >
> > I can comment that line out and everything works.
>
> This leads to two questions:
>
> - is the device cache coherent, in which case it doesn't need the
>   memory being non-cacheable? If everything is OK, then why the switch
>   to device memory?

I'll be honest and say I understand less than 50% of that. The network
transfer does seem to work without the call so perhaps the device is
cache coherent but this seems to be a common thing in many drivers so
I'd assume that on such platforms this should be innocuous. It's
totally possible I haven't done a good job of setting up the CPU or
informing the rest of the system about it. I did just take a lot of
the code from the Marvell SDK and clean it up without really
understanding what most of it did.

>
> - what goes wrong when these attributes are applied? do we have to
>   split a block mapping?
>
> Instrumenting the MMU code would certainly help understanding what
> goes wrong here.

I did do that a little bit. At first I thought there was a possible
infinite loop in mmu_set_region_dcache_behaviour(). Squinting at
things you could naively say that if set_one_region() failed to find
an entry then it would loop forever but if that happened I'd have some
debug saying that it failed. Things seem to go south after
__asm_switch_ttbr(gd->arch.tlb_emerg) which did get me thinking that
perhaps the emergency tables aren't setup (or at least aren't set up
in a way that allows debug output). That's about as far as I got
debugging wise, I'll try and spend some more time digging into the MMU
code.

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
