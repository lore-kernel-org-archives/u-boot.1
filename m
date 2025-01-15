Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A712E77188
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 01:18:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1E42806D6;
	Wed, 15 Jan 2025 02:18:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YMdw1A/r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AF3E80702; Wed, 15 Jan 2025 02:18:14 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6308E8069A
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 02:18:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aaedd529ba1so866640866b.1
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736903892; x=1737508692; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zq2NET+yJ++A+YGlZPnBIVgYrSTmPdzzWKi74+VrUxI=;
 b=YMdw1A/rSBaFmmwzVzvcQwO8vBD+c47U3sib5NEyE+cRzkuJGFnLKxyUczDpfIlnB7
 0IQK7SClWCFg4myCZFZs+PjxRW5lj0C64jOiQMVY7qjefifRdFyb9JHyOgCnmDUfpHXP
 ykRy5wz1N4y5+sUx9sw78c/lNS8/Sv5fcXkbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736903892; x=1737508692;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zq2NET+yJ++A+YGlZPnBIVgYrSTmPdzzWKi74+VrUxI=;
 b=saQACVG01GoxeOM2lwW/ELP8MK7tpZsLBw55DfwRYsLaYhlYPdWXZBRCwNUIuCX6UE
 r2KIGmfHB0v7QXLMD7LWfkEhDZzUhHZBefqfwQ26wRfk9UP+QOi9sFvz8YDrIP1q793Y
 AXdZy1w5lXasl8fg4gSkDvLKBn8av/vnWXMxvys2MpDDbGysBF35AB8L2RvsZuraaTR3
 o12znZuFgrWnR+Me9D/ERBMNU8WMFoZexUuw1KOTKUAOdqfXnwnxtlBQbGhfc6c5eZ6j
 8uG+9j9EIQjWXjynk+cpGGRUUXvyKZOEbMH91x0v9tmWopr9o/0werT5BuLRkol6Ib/z
 Iw5g==
X-Gm-Message-State: AOJu0YwMhIBJjHVWuouIgig0fHfS+0ss7CtAj18ZiPhxHt9eniAcumdK
 D9omBH/63KtiZU8jSMbAU+MxygndSkrdGM0HB23Nzk1ce+EBT9Bdlm3Czbg21yz+SoIyVkRP5PP
 vhgh2Uluy8qRKZ/VN3rXlkZ9X/sV9MLFcV4Em
X-Gm-Gg: ASbGncutP30NmYp6S8dxAkkMtu2Ln4ApMkaVUMnUqeRJw2rQ85AueR6s3U1iV/+YHYl
 KGsh6IUR/2SMpC789ztCveYP+eswUL1WFeYxAcCw=
X-Google-Smtp-Source: AGHT+IG3gnKO9lETktFX3h2mWRFYztA5+68ozn9Gx9nlFHxSzk9NXNwwzlunZeGWjzxXxci3nS7DIokY9mAx0Bg8/fw=
X-Received: by 2002:a05:6402:26cf:b0:5d4:55e:f99e with SMTP id
 4fb4d7f45d1cf-5d972e1d7dfmr67006688a12.18.1736903891869; Tue, 14 Jan 2025
 17:18:11 -0800 (PST)
MIME-Version: 1.0
References: <20250101195817.995321-1-sjg@chromium.org>
 <CAC_iWjKUdqGkAEXyz0LobkCgF_oX9dC1xCzz2qEWXbuOhkg=Kw@mail.gmail.com>
 <CAFLszTh3bnjisKqnDUvRCip2wdL0hJr+EM40+SbQ76h_zgg7Kg@mail.gmail.com>
 <CAFLszTiXHKdf_QUUsWpQpwv69HSGPNknkDW4JHgRUfT0r_G-aA@mail.gmail.com>
 <CAC_iWj+PwT2JmrWwrTsmHt_mGKDdhGUQgXKvzi3SCNCFxgJNRw@mail.gmail.com>
 <CAFLszThXtZjgavkzKhHbSXahONLqpT7yEYBH3bQ_1qzS=AUx+Q@mail.gmail.com>
 <CAC_iWjK5gOn4Ad=orCMhv4BY74U4E6AoOLR6rnYYHd9=-X7wEg@mail.gmail.com>
In-Reply-To: <CAC_iWjK5gOn4Ad=orCMhv4BY74U4E6AoOLR6rnYYHd9=-X7wEg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 14 Jan 2025 18:18:00 -0700
X-Gm-Features: AbW1kvaYUuuHaIxFJAsxxjRs0jyAPGAP1tzo9TOFHvHBGs0Lxdxg3SFhr6AQDHE
Message-ID: <CAFLszThHFzKL=N=nKQGtTdZjkjY3nq85Yg+vzkBdODOcZOhoyw@mail.gmail.com>
Subject: Re: [PATCH] bloblist: Drop BSD license
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Ilias,

On Tue, 14 Jan 2025 at 12:34, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Tue, 14 Jan 2025 at 15:15, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Tue, 14 Jan 2025 at 01:40, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Fri, 10 Jan 2025 at 16:54, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi again Ilias,
> > > >
> > > > On Thu, 2 Jan 2025 at 18:41, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Ilias,
> > > > >
> > > > > On Fri, 3 Jan 2025 at 08:15, Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > >
> > > > > > Apologies for the formatting, replying on mobile.
> > > > > >
> > > > > > On Wed, Jan 1, 2025, 21:58 Simon Glass <sjg@chromium.org> wrote:
> > > > > >>
> > > > > >> Linaro has decided to write their own version of bloblist from scratch,
> > > > > >> so there is no point in having a non-GPL license on this file. Change
> > > > > >> it, to better fit with the U-Boot project.
> > > > > >
> > > > > >
> > > > > > Apart from the commit message being wrong, it's also intentionally provoking. There was no bloblist in TF-A.
> > > > > >
> > > > > > The TF-A code is implementing the firmware hand-off spec [0], which Linaro participated in the creation. The U-Boot implementation was adjusted to adhere to the same spec after the TF-A code was merged.
> > > > >
> > > > > The U-Boot series was [1], for reference. This was mostly about using
> > > > > different tags and shrinking the headers. My clear understanding was
> > > > > that we were going to try to have a single codebase, which is why I
> > > > > changed the license.
> > > > >
> > > > > So, since you have a different view of events, why did Linaro write it
> > > > > from scratch? Was it to avoid having U-Boot code in TF-A? Or was the
> > > > > author just unaware of the original intention?
> > >
> > > I am not sure I am following 'from scratch'. Firmware handoff is a doc
> > > describing a list. Raymond implemented it in U-Boot and TF-A.
> >
> > So in your mind, Raymond implemented it in U-Boot? Have you taken a
> > look at 'git log' or 'git blame'?
> >
> > > The right way to do this is to move the firmware handoff code to a
> > > library that can be used across projects.
> >
> > Not always. Probably not in this case. It has quite a bit of logic
> > which depends on its environment. So I think it is better to have
> > 'similar' code in several projects. Certainly, writing it from scratch
> > (meaning not based on existing code) is not the best approach.
> >
> > >
> > > > It isn't relevant for
> > > > > the commit message, but if you can find out I would be interested.
> > > >
> > > > Just following up on this as I'm not sure of the status of this patch.
> > > > Can you perhaps write your own commit message with your version of
> > > > what Linaro has done?
> > >
> > > "The non-GPL license was inadvertently added, remove it". Raymond
> > > wrote that code so I don't think he minds removing the extra license.
> >
> > Again, please check your assertion here. I for one am very surprised
> > to hear that Raymond wrote the bloblist code :-)
>
> All of the patches carry his co-developed by or his signed off by. A
> big portion of those are sent by you as well

So here you are referring just to the patches which changed the header
formats, not the original bloblist code.

>
> >
> > But it does help to explain why you objected to my commit message.
>
> The reason I object to the commit message is because it's
> *intentionally* misleading.
> The BSD-3 clause was added by you in 6c9e3d1fc0859 with the intention
> of other projects using 'bloblist'.

Yes, that's why I added the license, since I was led to believe that
TF-A would use the U-Boot code with some modifications.

>
> The actual firmware handoff code was added much later in e266d2731145.
> All of the patches in that series is co-developped by Raymond. Those
> were added Wed Dec 27 while the TF-A patches were merged much much
> earlier. commit 3ba2c15147c in TF-A was merged Tue Jul 25

The original bloblist impl was in 2018:

commit 9f407d4ef092c2ce7ab0f4f366aee252611dab3c
Author: Simon Glass <sjg@chromium.org>
Date:   Thu Nov 15 18:43:50 2018 -0700

    Add core support for a bloblist to convey data from SPL

    At present there is no standard way in U-Boot to pass information from SPL
    to U-Boot proper. But sometimes SPL wants to convey information to U-Boot
    that U-Boot cannot easily figure out. For example, if SPL sets up SDRAM
    then it might want to pass the size of SDRAM, or the location of each
    bank, to U-Boot proper.

    Add a new 'bloblist' feature which provides this. A bloblist is set up in
    the first phase of U-Boot that runs (i.e. TPL or SPL). The location of
    this info may be in SRAM or CAR (x86 cache-as-RAM) or somewhere else.
    ...

Regards,
Simon
