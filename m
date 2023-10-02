Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B71E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:45:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34F70874CD;
	Mon,  2 Oct 2023 03:23:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bE8k3zWi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72D91874F8; Mon,  2 Oct 2023 03:23:28 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6409C8634D
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:23:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50307acd445so24393241e87.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209795; x=1696814595; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l+IVK7V1eZFpHzzP7FUmcKzZiL9ukt5RbgAyrKEtLZY=;
 b=bE8k3zWikbsB++xoFyLLR944NB0elmXSGM5A27BXEN9CHH/5XKmSi1PoKTaOrQL4lC
 RN4aVq4orfm0cWuDJpeXrNGASDDnxN62ZPrU3sM/GVQzrpsuRHjLnOlWwrd5VST1kMY/
 RrZ2GL6eOKInkqf6FTol41O2Qog4PsKfhXuH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209795; x=1696814595;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l+IVK7V1eZFpHzzP7FUmcKzZiL9ukt5RbgAyrKEtLZY=;
 b=NuJ1/r0My10HW3klOVbKWf9csF/cLh/ZdMlJ1GxE/5XLZnEywDblwO+LWcx1Dml6XG
 Ux5j4pftn1dZtbbdsFWHXTPihc9GF8i4ooMwMyOmLNL9pIWU3kvP8i1HTah29DPzmCvy
 ZLz+F7xt6PQ7LsKKK+OtlekdNNWzhjQRHPTJMK7jx3URSIqoNmhoT2XSmH8QiOzVXht0
 uxEyntT3OIvbKYp8WH1GTsAO7h2J7UNhFdcONyChy0HM4AP6RZ/U7RslRf4DjiPVJhcr
 4noRE4vqbXqXBMAzLnCAVfEDSr0imhOqWQqFT9PS80+4d3jjj2We6RTHBZsrIpE2T0Jp
 9yVQ==
X-Gm-Message-State: AOJu0YxZzymIPJS8C7IhO/HMQDDt51vX30/QWpxhbFxg/FlER3S8hxGj
 pLj0ctt9h1sBbMGzmM/4Ks3EeXkPuze8L58TD3RY1OGFCf244HKMyC4=
X-Google-Smtp-Source: AGHT+IGhtlU4eyH1vn6rUPeltAG1VgY/9nFe567audIQZDo5nV0Tfy+2128SHCmOTKmceNOA1uUXMgLVznWLTUL9CoU=
X-Received: by 2002:a05:6512:318a:b0:500:8fcb:e0c9 with SMTP id
 i10-20020a056512318a00b005008fcbe0c9mr8811393lfe.69.1696209795150; Sun, 01
 Oct 2023 18:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230427162100.GE1134230@bill-the-cat>
 <20230427173113.GG1134230@bill-the-cat>
 <40c79f7b-205d-0b48-7ee2-e052eaa1317f@prevas.dk>
 <20230503135158.GY1134230@bill-the-cat>
 <20230503145438.GB1134230@bill-the-cat>
 <0f2df366-65ca-664f-1f90-0c2aeafce8f1@prevas.dk>
 <68f445de-c903-c3a1-906f-2cf7b5675d08@prevas.dk>
 <20230925181940.GH305624@bill-the-cat>
 <08e35aab-309c-a8e1-931e-7ab142beb593@prevas.dk>
 <CAPnjgZ3jO5s3HZRjXdG-dVLNmGYnyCWnpvzRKpKhBCRQqWH33Q@mail.gmail.com>
 <20230929160230.GP305624@bill-the-cat>
In-Reply-To: <20230929160230.GP305624@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:17:27 -0600
Message-ID: <CAPnjgZ29hTMrzey1eZreTKhEVXWvi50JWBw-kUKC2VUYgXLYsw@mail.gmail.com>
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

On Fri, 29 Sept 2023 at 10:02, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Sep 29, 2023 at 09:15:00AM -0600, Simon Glass wrote:
> > Hi Rasmus,
> >
> > On Mon, 25 Sept 2023 at 13:05, Rasmus Villemoes
> > <rasmus.villemoes@prevas.dk> wrote:
> > >
> > > On 25/09/2023 20.19, Tom Rini wrote:
> > > > On Mon, Sep 25, 2023 at 10:27:43AM +0200, Rasmus Villemoes wrote:
> > > >> On 04/05/2023 14.35, Rasmus Villemoes wrote:
> > > >>> On 03/05/2023 16.54, Tom Rini wrote:
> > > >>
> > > >>>> The one last problem now is on stm32mp15_dhcor_basic which is a
> > > >>>> defconfig missing one from OF_LIST but including it in the its file, so
> > > >>>> the above is the patch we need.
> > > >>>>
> > > >>
> > > >> Hi Tom
> > > >>
> > > >> Can I persuade you to try something like
> > > >> https://source.denx.de/u-boot/u-boot/-/commit/a05e0d0e6b9103542a1076f9cab0005f400fa072
> > > >> again, but leaving the .dtbo targets in there?
> > > >>
> > > >> I could send a patch, but it's entirely mechanical, and not really meant
> > > >> for being applied until we know if there's more to be cleaned up.
> > > >
> > > > So what ended up being the problem I think is the case Simon pointed out
> > > > where we do take the output from "make all" and concatenate one of the
> > > > dtbs that was generated with u-boot.img or so, and it works.  But maybe
> > > > that should just list all of the valid DTBs that it needs in the
> > > > defconfig to start with? I don't quite know, it was a case I hadn't
> > > > considered at the time.
> > > >
> > >
> > > Re-reading the thread, I can't see where that was mentioned.
> > >
> > > But yes, if some boards (still) need that, and have more than one
> > > possible .dtb, the board can't set an OF_LIST different from the default
> > > consisting of DEFAULT_DEVICE_TREE because changing OF_LIST requires
> > > SPL_LOAD_FIT || MULTI_DTB_FIT.
> > >
> > > How do we figure out if such boards even exist?
> >
> > Honestly at this point I've forgotten what this is all about.
> >
> > Perhaps the easiest approach is to create a new Kconfig to control
> > whether a board-level .dtsi is included in the list of wildcard
> > searches. Then you can enable it for your board without affecting
> > others.
>
> That's getting things backwards, from what this cleanup does.  Today we
> have messy lists of "build these device trees" and then don't use most
> of them, and some of the list is just Wrong (listing dts files as an
> output).  With the series to handle dtbo files, we could remove
> virtually all of that, and the only use cases that don't Just Work still
> are the ones I forget which board you mentioned (I think it was Samsung
> tho?) where the defconfig doesn't list all of the device trees, just one
> of them, and the other 5 that we build can also be easily used.  Does
> that ring a bell?

Yes it does...but what is the problem here?

The DT files for an SoC are supposed to be buildable without needing
to have the context of a particular board.

I don't know what the point of the dtbo files is...is that for using
overlays somehow at runtime?

The defconfig does not need to mention all the DTs...we just need to
make sure they get built.

Is this another instance of something that needs cleaning up, like the
config fragments?

I am find with making the boards list the DTs that they can run with,
if there is an easy way of doing that. CONFIG_SPL_OF_LIST is just for
SPL, I think.

Regards,
Simon
