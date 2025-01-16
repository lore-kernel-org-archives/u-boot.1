Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5150C02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 18:32:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 492B880312;
	Thu, 16 Jan 2025 19:32:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wGbJGfrf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6BEA8033D; Thu, 16 Jan 2025 19:32:35 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85D068022B
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 19:32:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e549dd7201cso2236810276.0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 10:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737052352; x=1737657152; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lnKHurUMXVT02cOYpPdTNoSNIlnjPqSZN4115SBoUe4=;
 b=wGbJGfrfNt/Sr6Qw8tM1oz+XnIwX9dLbfdMmYgf1GAl8DwwrqszatQCsC7xR05lS3j
 jb0iumxwrxLE9dPY0Cau9Cbp4d2p7YSnol4ZkoDGexwq6MoMkQDAmq1BTSdYN2BXBe+3
 VoM1AMt8PUaL6z/qMM+zwilMaE/nSxnzmy6yNhGu3pOXM0lJ9qFBQTNMP2lFvO6jYHzH
 mhKLlRNRGjyOO0nijzJpa6utfKF4DFGUlT0zuhbZUUrK0I4XO00H5Qv661/B16MOCGl1
 oMaloPkKya+hg++DFOmEOhy5Y5hui/cr6dvBSV1hPPuYXspyYrtUtfaru5tcJA1a41kh
 NObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737052352; x=1737657152;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lnKHurUMXVT02cOYpPdTNoSNIlnjPqSZN4115SBoUe4=;
 b=kwSQ5lgjThk+7RvuE+7Gq6twq2Hf+YzSiZdW2L2jzYzeiulAjq7+F41+b362Mi/9O0
 cGphGMCRxpwoM+XDZhE1HNKtsjauBeXfnjbGYDkjA8WckK+8QVqt++AAs3o/M6NaTo+V
 TrLevgSX7Wj2fIOKHt47+wSmbpy2d14FTfDT7LThujpRuzH8dHLxgTbKHXj1mL5/qfMy
 /lEAt5TfSBe1EAmI4jQuR9iTuPwKhf7p/qfixaIFWlotEWKsEdo/L51lUZX6RNwrE13Y
 Ae2WAn2tJhiD83D/iuA7d165ze+zmyn0CCJEk37OXPuCL0kfC0186Kifw0b1nNEAMlPJ
 ARyQ==
X-Gm-Message-State: AOJu0YyWC0l2E8mi6cOU4Hj2pW2ndmGVJLy55Jzz5BIEbnoSl/qyIRc9
 LafgKT3LVavAU4V28e6AgFsqADyXLH4V5vAPkVVHh2wiiYTY8Iu/5sPydtp9qYcAGs1t+YeajGH
 lkMI9758oiHSQTntxhdM3sTVfegrxzDXfoj00Tw==
X-Gm-Gg: ASbGncufIxigaqNku9VZHIeFcv0cfeGPmC55I/R25R7M0oEIVxpBnWYkbCZAfn2rSMs
 YXW/nG2MbiT42UvskR2QsWl6nlXT4vwrTLEd5yw==
X-Google-Smtp-Source: AGHT+IGYoUJ1Hvv9LcFA4xEq0VsOKNoeg0eB0zjy8hcqL/faYWMehiUfqKhz48LYDej3qOE1I7XmCgBidivtTIyQak0=
X-Received: by 2002:a05:690c:4d88:b0:6ef:8c41:defc with SMTP id
 00721157ae682-6f531238c2amr314605937b3.11.1737052350867; Thu, 16 Jan 2025
 10:32:30 -0800 (PST)
MIME-Version: 1.0
References: <20250101195817.995321-1-sjg@chromium.org>
 <CAC_iWjKUdqGkAEXyz0LobkCgF_oX9dC1xCzz2qEWXbuOhkg=Kw@mail.gmail.com>
 <CAFLszTh3bnjisKqnDUvRCip2wdL0hJr+EM40+SbQ76h_zgg7Kg@mail.gmail.com>
 <CAFLszTiXHKdf_QUUsWpQpwv69HSGPNknkDW4JHgRUfT0r_G-aA@mail.gmail.com>
 <CAC_iWj+PwT2JmrWwrTsmHt_mGKDdhGUQgXKvzi3SCNCFxgJNRw@mail.gmail.com>
 <CAFLszThXtZjgavkzKhHbSXahONLqpT7yEYBH3bQ_1qzS=AUx+Q@mail.gmail.com>
 <CAC_iWjK5gOn4Ad=orCMhv4BY74U4E6AoOLR6rnYYHd9=-X7wEg@mail.gmail.com>
 <CAFLszThHFzKL=N=nKQGtTdZjkjY3nq85Yg+vzkBdODOcZOhoyw@mail.gmail.com>
In-Reply-To: <CAFLszThHFzKL=N=nKQGtTdZjkjY3nq85Yg+vzkBdODOcZOhoyw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 16 Jan 2025 20:31:55 +0200
X-Gm-Features: AbW1kvbzZstr5dqlRdp7BaIIyMABEmTDLxJgSJ4I5krwBRrXF0ErQphUy_io9Dc
Message-ID: <CAC_iWjKRE-B1DRY=O17_QB6eQF67ifg=DyQnio8iMARNjBbMfQ@mail.gmail.com>
Subject: Re: [PATCH] bloblist: Drop BSD license
To: Simon Glass <sjg@chromium.org>
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

On Wed, 15 Jan 2025 at 03:18, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Tue, 14 Jan 2025 at 12:34, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Tue, 14 Jan 2025 at 15:15, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Tue, 14 Jan 2025 at 01:40, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Fri, 10 Jan 2025 at 16:54, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi again Ilias,
> > > > >
> > > > > On Thu, 2 Jan 2025 at 18:41, Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > Hi Ilias,
> > > > > >
> > > > > > On Fri, 3 Jan 2025 at 08:15, Ilias Apalodimas
> > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > >
> > > > > > >
> > > > > > > Apologies for the formatting, replying on mobile.
> > > > > > >
> > > > > > > On Wed, Jan 1, 2025, 21:58 Simon Glass <sjg@chromium.org> wrote:
> > > > > > >>
> > > > > > >> Linaro has decided to write their own version of bloblist from scratch,
> > > > > > >> so there is no point in having a non-GPL license on this file. Change
> > > > > > >> it, to better fit with the U-Boot project.
> > > > > > >
> > > > > > >
> > > > > > > Apart from the commit message being wrong, it's also intentionally provoking. There was no bloblist in TF-A.
> > > > > > >
> > > > > > > The TF-A code is implementing the firmware hand-off spec [0], which Linaro participated in the creation. The U-Boot implementation was adjusted to adhere to the same spec after the TF-A code was merged.
> > > > > >
> > > > > > The U-Boot series was [1], for reference. This was mostly about using
> > > > > > different tags and shrinking the headers. My clear understanding was
> > > > > > that we were going to try to have a single codebase, which is why I
> > > > > > changed the license.
> > > > > >
> > > > > > So, since you have a different view of events, why did Linaro write it
> > > > > > from scratch? Was it to avoid having U-Boot code in TF-A? Or was the
> > > > > > author just unaware of the original intention?
> > > >
> > > > I am not sure I am following 'from scratch'. Firmware handoff is a doc
> > > > describing a list. Raymond implemented it in U-Boot and TF-A.
> > >
> > > So in your mind, Raymond implemented it in U-Boot? Have you taken a
> > > look at 'git log' or 'git blame'?
> > >
> > > > The right way to do this is to move the firmware handoff code to a
> > > > library that can be used across projects.
> > >
> > > Not always. Probably not in this case. It has quite a bit of logic
> > > which depends on its environment. So I think it is better to have
> > > 'similar' code in several projects. Certainly, writing it from scratch
> > > (meaning not based on existing code) is not the best approach.
> > >
> > > >
> > > > > It isn't relevant for
> > > > > > the commit message, but if you can find out I would be interested.
> > > > >
> > > > > Just following up on this as I'm not sure of the status of this patch.
> > > > > Can you perhaps write your own commit message with your version of
> > > > > what Linaro has done?
> > > >
> > > > "The non-GPL license was inadvertently added, remove it". Raymond
> > > > wrote that code so I don't think he minds removing the extra license.
> > >
> > > Again, please check your assertion here. I for one am very surprised
> > > to hear that Raymond wrote the bloblist code :-)
> >
> > All of the patches carry his co-developed by or his signed off by. A
> > big portion of those are sent by you as well
>
> So here you are referring just to the patches which changed the header
> formats, not the original bloblist code.

I never said bloblist in any of my emails. I only mentioned the
firmware handoff.

>
> >
> > >
> > > But it does help to explain why you objected to my commit message.
> >
> > The reason I object to the commit message is because it's
> > *intentionally* misleading.
> > The BSD-3 clause was added by you in 6c9e3d1fc0859 with the intention
> > of other projects using 'bloblist'.
>
> Yes, that's why I added the license, since I was led to believe that
> TF-A would use the U-Boot code with some modifications.
>
> >
> > The actual firmware handoff code was added much later in e266d2731145.
> > All of the patches in that series is co-developped by Raymond. Those
> > were added Wed Dec 27 while the TF-A patches were merged much much
> > earlier. commit 3ba2c15147c in TF-A was merged Tue Jul 25
>
> The original bloblist impl was in 2018:
>
> commit 9f407d4ef092c2ce7ab0f4f366aee252611dab3c
> Author: Simon Glass <sjg@chromium.org>
> Date:   Thu Nov 15 18:43:50 2018 -0700
>
>     Add core support for a bloblist to convey data from SPL
>
>     At present there is no standard way in U-Boot to pass information from SPL
>     to U-Boot proper. But sometimes SPL wants to convey information to U-Boot
>     that U-Boot cannot easily figure out. For example, if SPL sets up SDRAM
>     then it might want to pass the size of SDRAM, or the location of each
>     bank, to U-Boot proper.
>
>     Add a new 'bloblist' feature which provides this. A bloblist is set up in
>     the first phase of U-Boot that runs (i.e. TPL or SPL). The location of
>     this info may be in SRAM or CAR (x86 cache-as-RAM) or somewhere else.
>     ...
>

So the tl;dr is that when the firmware handoff code was added in TF-A,
there was no u-boot implementation. It all got added afterwards.
The way the development happened is that Raymond implemented the TF-A
code, and also plugged in the transfer mechanism so we use that info.
The fact that there was a similar implementation in U-Boot, which did
not adhere to the standard to begin with doesn't justify your commit
message. As I said we didn't decide to write a 'bloblist' we
implemented the spec in TF-A.

/Ilias

> Regards,
> Simon
