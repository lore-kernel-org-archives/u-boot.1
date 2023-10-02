Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50519E784B7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 14:44:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C146786DD1;
	Mon,  2 Oct 2023 16:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I1w5EYrK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2F7787163; Mon,  2 Oct 2023 16:44:03 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D61486D91
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 16:44:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-99c136ee106so2328343966b.1
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 07:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696257841; x=1696862641; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rVRPrVuxyfcM4VUYPa9FkostVVokY8+ImAtSDoy5aBQ=;
 b=I1w5EYrKD0gonzaSAI9ixeDp1FcJg5+8z+WIDULtnXlBaTgVbhcNslwx/Zk+hE6qoV
 BC8H+Z8KS0KE7JJ5Cv98BhFU1oVkWYOUaKMB2PdMEUndT/bGbWT2EH57qDIfwhDf1orQ
 g+gTn2qlbNsLXEbhoXZkzPZ09Z3RrRTVZ25TU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696257841; x=1696862641;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rVRPrVuxyfcM4VUYPa9FkostVVokY8+ImAtSDoy5aBQ=;
 b=fe0fyl22NswR7cQGJuKjs8KlD3USPpY4d53N4HA9k8S7xXdk8uSnUQjh1mg16s5vQa
 G5s6YeIl9wSkBpV47PZ5ibnRNvXAiTKGpDpQ9Wym2GZ2jCGiy21bcLQrWDyyqdKTHU6E
 VmLp6POV4RgxlSgl1z57YxuaFz7Q6fNdymOKWA0GfhzX6JtBELOQ1N7BzaXqZsAKfHL1
 HRm9qb+aL5kG5mb8tt9R6UooYv54XiZufl5tYYC5tZgBN0gHuLIAaU5aDmH1XyXOfXPN
 nnI6sDdQry68H/6VpuCn8qV2TyXz7GzM9AGhhQdNLa8MzTg8UJXLqxzfdUIliyfduBKv
 imgw==
X-Gm-Message-State: AOJu0Yz4lu5W10QQ8FqJKkTiMQ/2qwmRBYCYQX1f+6pdMk2HFMqSJO/u
 VcRLF2SeaDj9r9v+6NqHqlkBwRSyA1O97wQOHwbZcgNUHNlU9TzM9zWCJg==
X-Google-Smtp-Source: AGHT+IHaFRkBnil8WuEJEZdyR8HkHDhB2INA+47by8MruDy+VDrDW5OUIBa76yhKWqVNUO5djlcEo0YdfiMtNAUrSAU=
X-Received: by 2002:a17:907:7702:b0:9ae:5270:46d5 with SMTP id
 kw2-20020a170907770200b009ae527046d5mr9489483ejc.73.1696257840857; Mon, 02
 Oct 2023 07:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <40c79f7b-205d-0b48-7ee2-e052eaa1317f@prevas.dk>
 <20230503135158.GY1134230@bill-the-cat>
 <20230503145438.GB1134230@bill-the-cat>
 <0f2df366-65ca-664f-1f90-0c2aeafce8f1@prevas.dk>
 <68f445de-c903-c3a1-906f-2cf7b5675d08@prevas.dk>
 <20230925181940.GH305624@bill-the-cat>
 <08e35aab-309c-a8e1-931e-7ab142beb593@prevas.dk>
 <CAPnjgZ3jO5s3HZRjXdG-dVLNmGYnyCWnpvzRKpKhBCRQqWH33Q@mail.gmail.com>
 <20230929160230.GP305624@bill-the-cat>
 <CAPnjgZ29hTMrzey1eZreTKhEVXWvi50JWBw-kUKC2VUYgXLYsw@mail.gmail.com>
 <20231002140854.GU305624@bill-the-cat>
In-Reply-To: <20231002140854.GU305624@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 2 Oct 2023 08:43:41 -0600
Message-ID: <CAPnjgZ0TTNCEUHfHDr7tALx+Po9PDoD-R7zYeN2gc4wnkWqSzw@mail.gmail.com>
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

On Mon, 2 Oct 2023 at 08:09, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Oct 01, 2023 at 07:17:27PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 29 Sept 2023 at 10:02, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Sep 29, 2023 at 09:15:00AM -0600, Simon Glass wrote:
> > > > Hi Rasmus,
> > > >
> > > > On Mon, 25 Sept 2023 at 13:05, Rasmus Villemoes
> > > > <rasmus.villemoes@prevas.dk> wrote:
> > > > >
> > > > > On 25/09/2023 20.19, Tom Rini wrote:
> > > > > > On Mon, Sep 25, 2023 at 10:27:43AM +0200, Rasmus Villemoes wrote:
> > > > > >> On 04/05/2023 14.35, Rasmus Villemoes wrote:
> > > > > >>> On 03/05/2023 16.54, Tom Rini wrote:
> > > > > >>
> > > > > >>>> The one last problem now is on stm32mp15_dhcor_basic which is a
> > > > > >>>> defconfig missing one from OF_LIST but including it in the its file, so
> > > > > >>>> the above is the patch we need.
> > > > > >>>>
> > > > > >>
> > > > > >> Hi Tom
> > > > > >>
> > > > > >> Can I persuade you to try something like
> > > > > >> https://source.denx.de/u-boot/u-boot/-/commit/a05e0d0e6b9103542a1076f9cab0005f400fa072
> > > > > >> again, but leaving the .dtbo targets in there?
> > > > > >>
> > > > > >> I could send a patch, but it's entirely mechanical, and not really meant
> > > > > >> for being applied until we know if there's more to be cleaned up.
> > > > > >
> > > > > > So what ended up being the problem I think is the case Simon pointed out
> > > > > > where we do take the output from "make all" and concatenate one of the
> > > > > > dtbs that was generated with u-boot.img or so, and it works.  But maybe
> > > > > > that should just list all of the valid DTBs that it needs in the
> > > > > > defconfig to start with? I don't quite know, it was a case I hadn't
> > > > > > considered at the time.
> > > > > >
> > > > >
> > > > > Re-reading the thread, I can't see where that was mentioned.
> > > > >
> > > > > But yes, if some boards (still) need that, and have more than one
> > > > > possible .dtb, the board can't set an OF_LIST different from the default
> > > > > consisting of DEFAULT_DEVICE_TREE because changing OF_LIST requires
> > > > > SPL_LOAD_FIT || MULTI_DTB_FIT.
> > > > >
> > > > > How do we figure out if such boards even exist?
> > > >
> > > > Honestly at this point I've forgotten what this is all about.
> > > >
> > > > Perhaps the easiest approach is to create a new Kconfig to control
> > > > whether a board-level .dtsi is included in the list of wildcard
> > > > searches. Then you can enable it for your board without affecting
> > > > others.
> > >
> > > That's getting things backwards, from what this cleanup does.  Today we
> > > have messy lists of "build these device trees" and then don't use most
> > > of them, and some of the list is just Wrong (listing dts files as an
> > > output).  With the series to handle dtbo files, we could remove
> > > virtually all of that, and the only use cases that don't Just Work still
> > > are the ones I forget which board you mentioned (I think it was Samsung
> > > tho?) where the defconfig doesn't list all of the device trees, just one
> > > of them, and the other 5 that we build can also be easily used.  Does
> > > that ring a bell?
> >
> > Yes it does...but what is the problem here?
>
> Messy and unused and incorrect Makefile content.

The problem I see there is people using TARGET in
arch/arm/dts/Makefile for example. There are 80 instances of that. The
rules should depend on SoC (e.g. use ARCH_EXYNOS5), as Linux does it.

>
> > The DT files for an SoC are supposed to be buildable without needing
> > to have the context of a particular board.
>
> They're still buildable, without an explicit rule, they just need to
> (like they can now) be built explicitly.

But isn't that creating dead code? It will rot.

>
> > I don't know what the point of the dtbo files is...is that for using
> > overlays somehow at runtime?
>
> I think that side-tracked you from my question.
>
> > The defconfig does not need to mention all the DTs...we just need to
> > make sure they get built.
>
> Why?  This is the use case that I don't understand and isn't obvious.
>
> > Is this another instance of something that needs cleaning up, like the
> > config fragments?
>
> No, this isn't like the config fragments.
>
> > I am find with making the boards list the DTs that they can run with,
> > if there is an easy way of doing that. CONFIG_SPL_OF_LIST is just for
> > SPL, I think.
>
> Yes, every board except for some use case you've described before as far
> as I know lists the device trees that they use in the defconfig.  Which
> is why there's an impetus to clean up arch/*/dts/Makefile as 95% of
> those lines can just be removed.

It seems like you are wanting a board-level CONFIG which lists the DTs
which need to be built for that board. Is that right? You are
suggesting that this already exists, but I am not aware of it. Do you
mean SPL_OF_LIST, perhaps?

Regards,
Simon
