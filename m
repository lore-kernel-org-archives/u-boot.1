Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E24E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 19:46:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E43E801CE;
	Tue, 17 Dec 2024 20:46:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oFvzjjkI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8F088021A; Tue, 17 Dec 2024 20:46:01 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 625CE80107
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 20:45:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5d0d32cd31aso7033977a12.0
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734464759; x=1735069559; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WLRMyVS+KYey5QMSD7KzEjDIJMvs4QSXcwPz9dBHxNI=;
 b=oFvzjjkIHZ7h9JTrq+NhnQqVg6wGgMhr0eMVMroCtTZm6LzUUkjPj7a2Z3i/cxEQCf
 Ru6L1BrTjNWEhm8iKKSwcpEBGx9NlWoIjb3JMTZ+H51Nat8kn5yMZ436n2t5zg8dBYNx
 SKulZphMKHc4IG8nkMj3ot2Tg187xGfM9Lx8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734464759; x=1735069559;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WLRMyVS+KYey5QMSD7KzEjDIJMvs4QSXcwPz9dBHxNI=;
 b=TNbNyf4jhKnQt2HnjnuXS7hvLKpU2fQQVpTcHxtzJAz7ohRDuDyznY/0dAs4oj48Wh
 VoArg55JObWhkjt1Fs2M5xgitgCg2+w8s9BeNClprmLGTpwXnwYn87dhKTPvG3aFx9A8
 RrNhTYcUjPjkEmT6/ZcOKEFdHbMautdHQHwChoJbYV87BiHoHjX8SHnq2ji3Izn7qgkC
 h9C+lvLmCnPhFJCyKf5B6aUFzaIuIl5NGdK3BOeFQkXJSXzRpcFlbLyCZjif7JWWIjOB
 K6079bUntpyzZn2M6OF3yKoQmimAToYJavX6APBbEhp4fIOTH/AnzB+INwMEOYV2UPrk
 YK+w==
X-Gm-Message-State: AOJu0YyCFFxkFE4eNmJ1BNquURj7xE5EZeip+2CQqxGTTWzBGzIispIt
 cF2qZ8AKWl2psEtt6xYTJ3p6YDhf2tgEJtECeO101fA60iYOYtp7b1jZvwYh+VwvYOnHxm10CYK
 VhirtOdWRlrRydUnXD+xvAAXnlgB0rU9ZjEN50nMsDxso3rw=
X-Gm-Gg: ASbGncv1WB11UyHr34HT3AaVLE36hckKltlr62e3XFH8UeHnEQyadzNJsN3dZFwECP0
 a0hJDI5X9zB/S15Uq652ZVkBZJh4jPpVPvsnMxeA=
X-Google-Smtp-Source: AGHT+IGDwaoxQaYPJCGwL0DS91SZ5i6jwJg06OolKdEa4XuDOPvkUq/2jAgH2/uQj+mNvflx6kgROlvQEC/EB5T+30o=
X-Received: by 2002:a05:6402:4492:b0:5d0:ed92:cdf6 with SMTP id
 4fb4d7f45d1cf-5d7ee3b61f2mr675193a12.19.1734464758793; Tue, 17 Dec 2024
 11:45:58 -0800 (PST)
MIME-Version: 1.0
References: <20241212151142.1562825-1-trini@konsulko.com>
 <CAFLszTiF8m7P8mBCNRhhiRQt=bcfRB3ddaaumF_EXETTXbUmDQ@mail.gmail.com>
 <20241213170736.GW1505244@bill-the-cat>
 <CAFLszTiPxTDqB9r+rdT4gARCA1HPx9ELO+tWELB1eKuijFvAeA@mail.gmail.com>
 <20241217040040.GJ1505244@bill-the-cat>
In-Reply-To: <20241217040040.GJ1505244@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Dec 2024 12:45:46 -0700
Message-ID: <CAFLszTgaVwvJVoN=io-Djso1MuahhR9wr35VVORzQTYPLW9FFw@mail.gmail.com>
Subject: Re: [PATCH 1/2] bloblist: Introduce BLOBLIST_PRIOR_STAGE options
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Mon, 16 Dec 2024 at 21:00, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Dec 15, 2024 at 05:25:24PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 13 Dec 2024 at 10:07, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Dec 13, 2024 at 07:32:24AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Thu, 12 Dec 2024 at 08:11, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > Introduce an option to control if we expect that a prior stage has
> > > > > created a bloblist already and thus it is safe to scan the address. We
> > > > > need to have this be configurable because we do not (and cannot) know
> > if
> > > > > the address at CONFIG_BLOBLIST_ADDR is in regular DRAM or some special
> > > > > on-chip memory and so it may or may not be safe to read from this
> > > > > address this early.
> > > > >
> > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > ---
> > > > > Cc: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >  common/Kconfig | 32 ++++++++++++++++++++++++++++++++
> > > > >  lib/fdtdec.c   | 11 +++--------
> > > > >  2 files changed, 35 insertions(+), 8 deletions(-)
> > > > >
> > > >
> > > > Since this is the essentially the same as my OF_BLOBLIST patch, which
> > > > was rejected:
> > > >
> > > > NAK
> > > >
> > > > The issue is not whether some 'previous stage' set up a bloblist. For
> > > > example, if VPL_BLOBLIST_PRIOR_STAGE is enabled, that presumably means
> > > > that TPL set it up. But it doesn't mean that TPL put the FDT in there.
> > >
> > > This is wrong. The root problem is saying that the bloblist is in
> > > possibly uninitialized memory. The code is quite happy to NOT find the
> > > device tree in the bloblist and continue searching other paths.
> >
> > But until the bloblist is set up, it doesn't exist.
>
> An almost philosophical statement, yes. How should the generic code know
> if it exists, or does not exist? That is the question.

U-Boot code 'knows', since if this is the first phase which enables
CONFIG_IS_ENABLED(BLOBLOST), then the bloblist is available
before/after relocation as well as after RAM setup in SPL.

>
> > We should not be
> > looking for a bloblist that we know is not there yet. The bloblist is set
> > up by bloblist_init(). You seem to be imputing your own semantics for
> > bloblist.
>
> We don't know if the bloblist exists or not. That's the problem. It
> could already exist. That's the whole reason we're in this particular
> argument.

See above.

>
> > In SPL, init happens in board_init_r(), i.e. after RAM is set up. So don't
> > look in the bloblist until it is set up! It doesn't exist.
>
> Unless of course it was setup before. We don't know if it was setup
> before or not until we look. A big part of the problem is that for prior
> to U-Boot bloblist we don't need to use main DRAM, the bloblist is tiny
> and we have some other persistent memory available. Unfortunately, x86
> does not.

The only situation where this matters is for the devicetree, which I
why i created OF_BLOBLIST, a way to indicate that the bloblist should
be checked for a devicetree.

>
> > In U-Boot proper, we look for it before relocation, so we can relocate and
> > expand it for use with ACPI tables, etc.
>
> I'm not sure that's relevant. This means we've taken what we were passed
> at a fixed address and allocated more space for it and are using it
> somewhere else.

Yes

>
> > Take a look at this patch, too:
> >
> > 3d6531803e1 bloblist: Support initing from multiple places
>
> I'm not sure it's relevant. It does show we have a problem of not
> knowing if the bloblist exists, or not. And I don't think we're solving
> that right today (nor does v1 of my patch).

OK

>
> > > An alternative here would be to better document the requirements of
> > > BLOBLIST_ADDR, and then just disable it on chromebook_coral until
> > > someone is inclined to move DDR init in to TPL, or someone finds a
> > > non-main-memory address to use for BLOBLIST_ADDR or switches to using
> > > BLOBLIST_ALLOC.
> >
> > Coral's TPL runs in cache-as-ram, with a 30KB limit on code size. It cannot
> > do DDR init in TPL because the DDR blob is large (160KB?) and there is a
> > ton of setup to do first, in any case. When CAR goes away, its memory
> > vanishes, so you need to have copied the bloblist somewhere else (the
> > bloblist holds the MRC data which needs to be written to SPI flash later
> > on, when possible). This all works perfectly and there is really no need to
> > change anything.
>
> Ah, so there's some of the details finally. And oh goodness, we're
> writing to the SPI flash on each boot? That's not good for longevity...

It writes a sector each time, across an area which can hold quite a
few writes. It only writes when the details change, so it is fine.
This algorithm has worked in the field for years across tens of
millions of devices and is common on x86.

>
> > Again, you seem to be imputing semantics to bloblist which don't exist.
>
> Unfortunately some things were missed along the way, and are still
> missing.

Well we should have started from OF_BLOBLIST and then dealt with
problems as they came up. In fact, so far there are no problems which
it can't solve.

As it is, we have Raymond sending a patch to push the prior-stage mess
into TPM, for reasons which make no sense to me. It is just adding
confusion.

One other thing we would have likely done by now if my patch[1] had
gone in a year ago, is moving away from BLOBLIST_FIXED to using a
register protocol. That is more deterministic.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20230830180524.315916-31-sjg@chromium.org/
