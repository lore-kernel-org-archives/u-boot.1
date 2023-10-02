Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CBCE7490C
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 18:58:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3F9B871CF;
	Mon,  2 Oct 2023 20:57:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Slal89Y2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85050871B3; Mon,  2 Oct 2023 20:57:25 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 160F0871F3
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 20:57:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5a1f00b75aaso1301137b3.2
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 11:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696273040; x=1696877840; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FEqNB4t383yM5ODg6zEr/xdVgOxtcJG/XEUyaw0XqOQ=;
 b=Slal89Y201mqIU3fn/MvG1p411KEI6MvOHTLxVA3VLuEqKy/SFfcNzW2Q1FOIsmFMH
 +k/zXnItFGwdxSlEXR4mKqVdaHM/v9B+ylKfk2eWGPwT6LxXWYNyLl4KF1cxOQ/xIs8O
 4uSBoF2u0b9dPfUJug/+fw2GPlwshCjlvjMig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696273040; x=1696877840;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FEqNB4t383yM5ODg6zEr/xdVgOxtcJG/XEUyaw0XqOQ=;
 b=r3FENNwJeFTbFIpyZ5EZCe6hBUiCFpczyKZaE5hqUW5T6fi6+4YrKTvCny3C8cK35f
 3KWksyQX5AKIZ6+4JdgZwCvi+AYUsHsiliHM+4qbqoPZJYqrvc8YLR2PVILUorJ9n4ao
 ae6KN6gJzo2YOn2n+TTP80Y+0vumWhnblWuRvQIPuZg/SwpwZxCLQaytOGr5fbUoXSjE
 LBfeQW19ZEPSss/8l2W53Uhvn6UMQEuz7wfNJpkAa9t+2xbY9mK7XFtV+2rkPqbyPH9c
 IkCYjscDLySyGqc+1gEdiV1cRRhRKnLrzOOQpLyYVBL7nLnxd2xYZiPqiInXKiCW7k6Z
 F2tQ==
X-Gm-Message-State: AOJu0YwXSm2Qx4nOGuQfNsZ6z5keKL/IXOmGCBOCgNQ8U0HD8LcrH/H8
 upsSJZfeOOTFhhylMoe1squWoUUzqtNqku1yjR/57D3WZQ1HpkCXzl8=
X-Google-Smtp-Source: AGHT+IHjtCn2xzJfOS3xEwdlQLR+WkuU5ZGhPgWskJwehqDbjd0KbfSjleGtjZicZce2eZ/D68x48+9DAFtPSZVXOqM=
X-Received: by 2002:a81:df11:0:b0:59b:dbb7:5c74 with SMTP id
 c17-20020a81df11000000b0059bdbb75c74mr10928925ywn.32.1696273039370; Mon, 02
 Oct 2023 11:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <68f445de-c903-c3a1-906f-2cf7b5675d08@prevas.dk>
 <20230925181940.GH305624@bill-the-cat>
 <08e35aab-309c-a8e1-931e-7ab142beb593@prevas.dk>
 <CAPnjgZ3jO5s3HZRjXdG-dVLNmGYnyCWnpvzRKpKhBCRQqWH33Q@mail.gmail.com>
 <20230929160230.GP305624@bill-the-cat>
 <CAPnjgZ29hTMrzey1eZreTKhEVXWvi50JWBw-kUKC2VUYgXLYsw@mail.gmail.com>
 <20231002140854.GU305624@bill-the-cat>
 <CAPnjgZ0TTNCEUHfHDr7tALx+Po9PDoD-R7zYeN2gc4wnkWqSzw@mail.gmail.com>
 <20231002151212.GY305624@bill-the-cat>
 <CAPnjgZ1fZjxTi8ryiVZC=Js1MDfP+PdGbJK87BA_kJe52d038w@mail.gmail.com>
 <20231002162203.GZ305624@bill-the-cat>
In-Reply-To: <20231002162203.GZ305624@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 2 Oct 2023 12:56:38 -0600
Message-ID: <CAPnjgZ0K-pP9FUxn-k+XeWZTdt+Z4XafpgJRJ5eUM7izZ8==PA@mail.gmail.com>
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

On Mon, 2 Oct 2023 at 10:22, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 02, 2023 at 09:39:18AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 2 Oct 2023 at 09:12, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Oct 02, 2023 at 08:43:41AM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 2 Oct 2023 at 08:09, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sun, Oct 01, 2023 at 07:17:27PM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Fri, 29 Sept 2023 at 10:02, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Fri, Sep 29, 2023 at 09:15:00AM -0600, Simon Glass wrote:
> > > > > > > > Hi Rasmus,
> > > > > > > >
> > > > > > > > On Mon, 25 Sept 2023 at 13:05, Rasmus Villemoes
> > > > > > > > <rasmus.villemoes@prevas.dk> wrote:
> > > > > > > > >
> > > > > > > > > On 25/09/2023 20.19, Tom Rini wrote:
> > > > > > > > > > On Mon, Sep 25, 2023 at 10:27:43AM +0200, Rasmus Villemoes wrote:
> > > > > > > > > >> On 04/05/2023 14.35, Rasmus Villemoes wrote:
> > > > > > > > > >>> On 03/05/2023 16.54, Tom Rini wrote:
> > > > > > > > > >>
> > > > > > > > > >>>> The one last problem now is on stm32mp15_dhcor_basic which is a
> > > > > > > > > >>>> defconfig missing one from OF_LIST but including it in the its file, so
> > > > > > > > > >>>> the above is the patch we need.
> > > > > > > > > >>>>
> > > > > > > > > >>
> > > > > > > > > >> Hi Tom
> > > > > > > > > >>
> > > > > > > > > >> Can I persuade you to try something like
> > > > > > > > > >> https://source.denx.de/u-boot/u-boot/-/commit/a05e0d0e6b9103542a1076f9cab0005f400fa072
> > > > > > > > > >> again, but leaving the .dtbo targets in there?
> > > > > > > > > >>
> > > > > > > > > >> I could send a patch, but it's entirely mechanical, and not really meant
> > > > > > > > > >> for being applied until we know if there's more to be cleaned up.
> > > > > > > > > >
> > > > > > > > > > So what ended up being the problem I think is the case Simon pointed out
> > > > > > > > > > where we do take the output from "make all" and concatenate one of the
> > > > > > > > > > dtbs that was generated with u-boot.img or so, and it works.  But maybe
> > > > > > > > > > that should just list all of the valid DTBs that it needs in the
> > > > > > > > > > defconfig to start with? I don't quite know, it was a case I hadn't
> > > > > > > > > > considered at the time.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Re-reading the thread, I can't see where that was mentioned.
> > > > > > > > >
> > > > > > > > > But yes, if some boards (still) need that, and have more than one
> > > > > > > > > possible .dtb, the board can't set an OF_LIST different from the default
> > > > > > > > > consisting of DEFAULT_DEVICE_TREE because changing OF_LIST requires
> > > > > > > > > SPL_LOAD_FIT || MULTI_DTB_FIT.
> > > > > > > > >
> > > > > > > > > How do we figure out if such boards even exist?
> > > > > > > >
> > > > > > > > Honestly at this point I've forgotten what this is all about.
> > > > > > > >
> > > > > > > > Perhaps the easiest approach is to create a new Kconfig to control
> > > > > > > > whether a board-level .dtsi is included in the list of wildcard
> > > > > > > > searches. Then you can enable it for your board without affecting
> > > > > > > > others.
> > > > > > >
> > > > > > > That's getting things backwards, from what this cleanup does.  Today we
> > > > > > > have messy lists of "build these device trees" and then don't use most
> > > > > > > of them, and some of the list is just Wrong (listing dts files as an
> > > > > > > output).  With the series to handle dtbo files, we could remove
> > > > > > > virtually all of that, and the only use cases that don't Just Work still
> > > > > > > are the ones I forget which board you mentioned (I think it was Samsung
> > > > > > > tho?) where the defconfig doesn't list all of the device trees, just one
> > > > > > > of them, and the other 5 that we build can also be easily used.  Does
> > > > > > > that ring a bell?
> > > > > >
> > > > > > Yes it does...but what is the problem here?
> > > > >
> > > > > Messy and unused and incorrect Makefile content.
> > > >
> > > > The problem I see there is people using TARGET in
> > > > arch/arm/dts/Makefile for example. There are 80 instances of that. The
> > > > rules should depend on SoC (e.g. use ARCH_EXYNOS5), as Linux does it.
> > >
> > > It shouldn't be there at all since there's almost no cases where we
> > > "just" take an arbitrary dtb file and u-boot.img and then the system
> > > boot.  That's what this series is about fixing.
> >
> > I'm really not sure that replacing build rules with a board CONFIG is
> > a good idea. I suppose part of my confusion is why the Makefile is
> > considered a problem?
>
> Because it's duplicative and as Rasmus points out, often wrong.

To me, that is under the control of the board maintainers. They should
not put CONFIG_SYS_BOARD in the DT...it obviously goes against what DT
is for and I'm not sure what binding would allow it anyway.

If it helps, I could do a little series to remove those? I think it is
just arch/arm/dts/rockchip-optee.dtsi ?

This seems like a case of throwing the baby out with the bathwater.

>
> > > > > > The DT files for an SoC are supposed to be buildable without needing
> > > > > > to have the context of a particular board.
> > > > >
> > > > > They're still buildable, without an explicit rule, they just need to
> > > > > (like they can now) be built explicitly.
> > > >
> > > > But isn't that creating dead code? It will rot.
> > >
> > > No, that's the problem we have today, people list something in the
> > > Makefile, since they think they need to list something, and then put the
> > > device trees they use in the defconfig.
> >
> > If they don't list something, it won't build, right?
>
> No, everyone builds fine since CONFIG_DEFAULT_DEVICE_TREE is pretty much
> always set.  And for run time, if we need more, *OF_LIST gets set.

OK, makes sense. So what DT does u-boot.bin contain in that case? Just
the default? And u-boot.img contains a FIT with all of them?

>
> > > [snip]
> > > > > > I am find with making the boards list the DTs that they can run with,
> > > > > > if there is an easy way of doing that. CONFIG_SPL_OF_LIST is just for
> > > > > > SPL, I think.
> > > > >
> > > > > Yes, every board except for some use case you've described before as far
> > > > > as I know lists the device trees that they use in the defconfig.  Which
> > > > > is why there's an impetus to clean up arch/*/dts/Makefile as 95% of
> > > > > those lines can just be removed.
> > > >
> > > > It seems like you are wanting a board-level CONFIG which lists the DTs
> > > > which need to be built for that board. Is that right? You are
> > > > suggesting that this already exists, but I am not aware of it. Do you
> > > > mean SPL_OF_LIST, perhaps?
> > >
> > > I mean today CONFIG_DEFAULT_DEVICE_TREE + CONFIG_OF_LIST +
> > > CONFIG_SPL_OF_LIST is set and correct for everyone board except some use
> > > case you have, which I think is something about exynos?  And so we only
> > > need scripts/Makefile.dts in arch/*/dts/Makefile
> >
> > Yes exynos5 boards (the original reason for DT) have / had the same
> > u-boot-nodtb.bin and you can add the DT you want to boot it on
> > particular hardware. That is one of the goals of DT.
>
> Yes, but "and you concat the two files" isn't common.  We _can_ keep the
> EXYNOS list, if that's actually being used.  But most of that list is
> not, as far as I can tell, because the flow is "U-Boot binarie(s) + DTB
> files + stuff" to get the correctly formatted blob for the firmware.

I believe rockchip allows just the DT to be changed, to work on a
board with the same SoC. In principle it would be possible to build a
common u-boot-nodtb.bin too, e.g. for 32-bit.

We are trying to use DT (and not custom C code) to deal with the
differences between boards. So long as that is preserved, I am happy
enough.

>
> > The OF_LIST option is a little vague but I think it means that the DTs
> > are packaged into a FIT in u-boot.img - is that right? But they
> > presumably have to be built first.
>
> No, they don't have to be built first because scripts/Makefile.dts
> ensures that we build everything in *OF_LIST.

That is from this commit:

3609e1dc5f4 dts: automatically build necessary .dtb files

which was for use by custom boards using a private branch. Did it have
a wider purpose that I didn't understand?

Regards,
Simon
