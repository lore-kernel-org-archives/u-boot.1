Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1072E784BE
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 15:39:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20B2E87166;
	Mon,  2 Oct 2023 17:39:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BqT6EW9D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 418948717A; Mon,  2 Oct 2023 17:39:39 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9876586DE1
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 17:39:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-99c136ee106so2340428366b.1
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 08:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696261176; x=1696865976; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DH9JBHtL15p5kDx36xoKgV09qAryYwk0TOZxr7Jv3cY=;
 b=BqT6EW9DJeY/zOTJIbekllid9YVCtUi+j5OjSmCcJ4pd95jytd3IR0Z+O32S7cjDeM
 PPuEqaC9IquhyMayo22ZUC16ZMor9tGXgvVxHtCLJ7Qh2gqBTAN0aPOthQRZ2V26ulZO
 nDIHgx53f+htxlsKN/DOz1IOGVzo/ZR8wDyTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696261176; x=1696865976;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DH9JBHtL15p5kDx36xoKgV09qAryYwk0TOZxr7Jv3cY=;
 b=pZrCr+QViD2HK9nc36iCUHik5OphxtlxpJm90ZMEN9rIDfEfS/KRSCEnEIYU0ran2K
 iG7VePFO1DLWNcTyRdZSG++kXKFrz11Ts2KCRvEsYnSnXXCRL4dNTCDhh52p6vGcqQsl
 Kv6y+QAYvJvaV9Ci6XkeSXjrs5anZ4Pz/3W+2G34w9kYh+4a46yy3q5H2Xe9ebaGQ9Z/
 J0zTdfBMyzLIrpjGrBfj4MXyDKZaPC3AJyaj6vpY0xjwE2KIVRhYLX39lvahosnHd3TQ
 Np0wA1CHSod4ltSsIXYA4aS/BoUiBEvTwdZQYFBVtCronczI8ZJDJbpYYw39jX5//jaL
 K2Lw==
X-Gm-Message-State: AOJu0Ywg+Klv1MsPWdZwD3jibDRZyQhi49OkLsT72ThX5exkyjhFB2Vf
 BkhKNggAEZwWo2R532muV6ALHtrIpP/ryP5fAAWp6qT9TeG+U0R63X0=
X-Google-Smtp-Source: AGHT+IHfeEbhX6zVGdFIYxawuraTyof9V4OsfAl6crrnEXI+Xuuid/Di44cH+3th/KZnznJYnsUYpVnzQxktT4tJplk=
X-Received: by 2002:a17:906:845b:b0:9ae:6538:643b with SMTP id
 e27-20020a170906845b00b009ae6538643bmr11487649ejy.38.1696261175907; Mon, 02
 Oct 2023 08:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230503145438.GB1134230@bill-the-cat>
 <0f2df366-65ca-664f-1f90-0c2aeafce8f1@prevas.dk>
 <68f445de-c903-c3a1-906f-2cf7b5675d08@prevas.dk>
 <20230925181940.GH305624@bill-the-cat>
 <08e35aab-309c-a8e1-931e-7ab142beb593@prevas.dk>
 <CAPnjgZ3jO5s3HZRjXdG-dVLNmGYnyCWnpvzRKpKhBCRQqWH33Q@mail.gmail.com>
 <20230929160230.GP305624@bill-the-cat>
 <CAPnjgZ29hTMrzey1eZreTKhEVXWvi50JWBw-kUKC2VUYgXLYsw@mail.gmail.com>
 <20231002140854.GU305624@bill-the-cat>
 <CAPnjgZ0TTNCEUHfHDr7tALx+Po9PDoD-R7zYeN2gc4wnkWqSzw@mail.gmail.com>
 <20231002151212.GY305624@bill-the-cat>
In-Reply-To: <20231002151212.GY305624@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 2 Oct 2023 09:39:18 -0600
Message-ID: <CAPnjgZ1fZjxTi8ryiVZC=Js1MDfP+PdGbJK87BA_kJe52d038w@mail.gmail.com>
Subject: Re: [PATCH] scripts/Makefile.lib: also consider
 $(CONFIG_SYS_BOARD)-u-boot.dtsi
To: Tom Rini <trini@konsulko.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
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

Hi Tom,

On Mon, 2 Oct 2023 at 09:12, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 02, 2023 at 08:43:41AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 2 Oct 2023 at 08:09, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sun, Oct 01, 2023 at 07:17:27PM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 29 Sept 2023 at 10:02, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, Sep 29, 2023 at 09:15:00AM -0600, Simon Glass wrote:
> > > > > > Hi Rasmus,
> > > > > >
> > > > > > On Mon, 25 Sept 2023 at 13:05, Rasmus Villemoes
> > > > > > <rasmus.villemoes@prevas.dk> wrote:
> > > > > > >
> > > > > > > On 25/09/2023 20.19, Tom Rini wrote:
> > > > > > > > On Mon, Sep 25, 2023 at 10:27:43AM +0200, Rasmus Villemoes wrote:
> > > > > > > >> On 04/05/2023 14.35, Rasmus Villemoes wrote:
> > > > > > > >>> On 03/05/2023 16.54, Tom Rini wrote:
> > > > > > > >>
> > > > > > > >>>> The one last problem now is on stm32mp15_dhcor_basic which is a
> > > > > > > >>>> defconfig missing one from OF_LIST but including it in the its file, so
> > > > > > > >>>> the above is the patch we need.
> > > > > > > >>>>
> > > > > > > >>
> > > > > > > >> Hi Tom
> > > > > > > >>
> > > > > > > >> Can I persuade you to try something like
> > > > > > > >> https://source.denx.de/u-boot/u-boot/-/commit/a05e0d0e6b9103542a1076f9cab0005f400fa072
> > > > > > > >> again, but leaving the .dtbo targets in there?
> > > > > > > >>
> > > > > > > >> I could send a patch, but it's entirely mechanical, and not really meant
> > > > > > > >> for being applied until we know if there's more to be cleaned up.
> > > > > > > >
> > > > > > > > So what ended up being the problem I think is the case Simon pointed out
> > > > > > > > where we do take the output from "make all" and concatenate one of the
> > > > > > > > dtbs that was generated with u-boot.img or so, and it works.  But maybe
> > > > > > > > that should just list all of the valid DTBs that it needs in the
> > > > > > > > defconfig to start with? I don't quite know, it was a case I hadn't
> > > > > > > > considered at the time.
> > > > > > > >
> > > > > > >
> > > > > > > Re-reading the thread, I can't see where that was mentioned.
> > > > > > >
> > > > > > > But yes, if some boards (still) need that, and have more than one
> > > > > > > possible .dtb, the board can't set an OF_LIST different from the default
> > > > > > > consisting of DEFAULT_DEVICE_TREE because changing OF_LIST requires
> > > > > > > SPL_LOAD_FIT || MULTI_DTB_FIT.
> > > > > > >
> > > > > > > How do we figure out if such boards even exist?
> > > > > >
> > > > > > Honestly at this point I've forgotten what this is all about.
> > > > > >
> > > > > > Perhaps the easiest approach is to create a new Kconfig to control
> > > > > > whether a board-level .dtsi is included in the list of wildcard
> > > > > > searches. Then you can enable it for your board without affecting
> > > > > > others.
> > > > >
> > > > > That's getting things backwards, from what this cleanup does.  Today we
> > > > > have messy lists of "build these device trees" and then don't use most
> > > > > of them, and some of the list is just Wrong (listing dts files as an
> > > > > output).  With the series to handle dtbo files, we could remove
> > > > > virtually all of that, and the only use cases that don't Just Work still
> > > > > are the ones I forget which board you mentioned (I think it was Samsung
> > > > > tho?) where the defconfig doesn't list all of the device trees, just one
> > > > > of them, and the other 5 that we build can also be easily used.  Does
> > > > > that ring a bell?
> > > >
> > > > Yes it does...but what is the problem here?
> > >
> > > Messy and unused and incorrect Makefile content.
> >
> > The problem I see there is people using TARGET in
> > arch/arm/dts/Makefile for example. There are 80 instances of that. The
> > rules should depend on SoC (e.g. use ARCH_EXYNOS5), as Linux does it.
>
> It shouldn't be there at all since there's almost no cases where we
> "just" take an arbitrary dtb file and u-boot.img and then the system
> boot.  That's what this series is about fixing.

I'm really not sure that replacing build rules with a board CONFIG is
a good idea. I suppose part of my confusion is why the Makefile is
considered a problem?

>
> > > > The DT files for an SoC are supposed to be buildable without needing
> > > > to have the context of a particular board.
> > >
> > > They're still buildable, without an explicit rule, they just need to
> > > (like they can now) be built explicitly.
> >
> > But isn't that creating dead code? It will rot.
>
> No, that's the problem we have today, people list something in the
> Makefile, since they think they need to list something, and then put the
> device trees they use in the defconfig.

If they don't list something, it won't build, right?

>
> [snip]
> > > > I am find with making the boards list the DTs that they can run with,
> > > > if there is an easy way of doing that. CONFIG_SPL_OF_LIST is just for
> > > > SPL, I think.
> > >
> > > Yes, every board except for some use case you've described before as far
> > > as I know lists the device trees that they use in the defconfig.  Which
> > > is why there's an impetus to clean up arch/*/dts/Makefile as 95% of
> > > those lines can just be removed.
> >
> > It seems like you are wanting a board-level CONFIG which lists the DTs
> > which need to be built for that board. Is that right? You are
> > suggesting that this already exists, but I am not aware of it. Do you
> > mean SPL_OF_LIST, perhaps?
>
> I mean today CONFIG_DEFAULT_DEVICE_TREE + CONFIG_OF_LIST +
> CONFIG_SPL_OF_LIST is set and correct for everyone board except some use
> case you have, which I think is something about exynos?  And so we only
> need scripts/Makefile.dts in arch/*/dts/Makefile

Yes exynos5 boards (the original reason for DT) have / had the same
u-boot-nodtb.bin and you can add the DT you want to boot it on
particular hardware. That is one of the goals of DT.

The OF_LIST option is a little vague but I think it means that the DTs
are packaged into a FIT in u-boot.img - is that right? But they
presumably have to be built first.

I think this would be better discussed f2f.

Regards,
Simon
