Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06D6E77187
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 23:42:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0227280214;
	Wed, 18 Dec 2024 00:42:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oTD3aNiR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C31F8021A; Wed, 18 Dec 2024 00:42:40 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB4AE801FB
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 00:42:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9a0ef5179dso891477066b.1
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 15:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734478957; x=1735083757; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NsGbfNFg1ym9hg1jls53B4iDeXT/DVwJRUWTMSmuO+o=;
 b=oTD3aNiRIJGPS/uHHM0K5KfHaXZ48rGthmKEE40dAoluVxy7tczT2EOWswIs10PuSY
 PyM2lRAcNTqalyBYGu87rf4v4t3agcsXzGmiyU2qzUbNeUCjO+gi2KgZG9pjinesYIP3
 vRQe9tfZxYoiwWb0Jru/G1k+4vzviib3EokgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734478957; x=1735083757;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NsGbfNFg1ym9hg1jls53B4iDeXT/DVwJRUWTMSmuO+o=;
 b=dJmzM/TRFOmVkBYQyIj6d1WdY2Ej4arRUYQ8Ni26mA4SCbCxyz5e4XhN26I+IZU0Fi
 vle5SBO5NIIgVaBwLlZ+ftTztmGjaEioohOly8iQGyBiLqzbTm9TlWJxw2sNExPpnScf
 q1wO23Uev9M7wEhV13HDgqVyU/+PmUPCoGypyT68MzX8wQ9pEvsXehgKwGKhQWYmQ8w8
 1HX4aNAnJ2OWzeUuYjx/WGca1d29SM4cjBYSUNvLh+/cIkwvBAWkM/Au0xDcCOhY+XpI
 qGbnuEnMeY+z92vn1ixS2kAgkSHTgipOfBKbCyr0UIqrB+wjDepbn7xRfOIwy+716kix
 SAPg==
X-Gm-Message-State: AOJu0YyyQBCrsyGmrf6s+YqhEFLWHVn3QQbJImZzMMTnKGYDQ6+qVk7s
 1RnLkbqxKZBUTHoXpYK3Vq8p7hqurh4fdj53HTouybN7tp9P0SXBUjyP6Zkp1n4waJrQX11gy9Z
 kyVxdrtffObYB/B/rpzFb/TYRLgvBHIjUU9oCtFPghkWQ21Jxng==
X-Gm-Gg: ASbGnctYmM8nrvwF7MwmxNO+nxuBCgB5Cwhd0VdK3yOFl33JBLu42/PDvSP1bDjK2OY
 WizGp8tmkCowaC/qlNHh5C3g/QHjCHnoMD3TLtdw=
X-Google-Smtp-Source: AGHT+IE/6Ixyt5xSkQQ2C2lvo5pCzL44JX59g6QLQsVrpVOzJot7gtRRmqWeig9TD+PmpF4DeKA0mFayS+UoT6rH4zU=
X-Received: by 2002:a17:907:1c0b:b0:aa6:5d30:d974 with SMTP id
 a640c23a62f3a-aabf47b43b7mr45473066b.28.1734478957221; Tue, 17 Dec 2024
 15:42:37 -0800 (PST)
MIME-Version: 1.0
References: <20241212151142.1562825-1-trini@konsulko.com>
 <CAFLszTiF8m7P8mBCNRhhiRQt=bcfRB3ddaaumF_EXETTXbUmDQ@mail.gmail.com>
 <20241213170736.GW1505244@bill-the-cat>
 <CAFLszTiPxTDqB9r+rdT4gARCA1HPx9ELO+tWELB1eKuijFvAeA@mail.gmail.com>
 <20241217040040.GJ1505244@bill-the-cat>
 <CAFLszTgaVwvJVoN=io-Djso1MuahhR9wr35VVORzQTYPLW9FFw@mail.gmail.com>
 <20241217201546.GS1505244@bill-the-cat>
In-Reply-To: <20241217201546.GS1505244@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Dec 2024 16:42:26 -0700
Message-ID: <CAFLszTh6euHToEvwF_Trmr0fhotxCVipj=wYafOkyx-6jujo-w@mail.gmail.com>
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

On Tue, 17 Dec 2024 at 13:15, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Dec 17, 2024 at 12:45:46PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 16 Dec 2024 at 21:00, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sun, Dec 15, 2024 at 05:25:24PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 13 Dec 2024 at 10:07, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, Dec 13, 2024 at 07:32:24AM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Thu, 12 Dec 2024 at 08:11, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > Introduce an option to control if we expect that a prior stage has
> > > > > > > created a bloblist already and thus it is safe to scan the address. We
> > > > > > > need to have this be configurable because we do not (and cannot) know
> > > > if
> > > > > > > the address at CONFIG_BLOBLIST_ADDR is in regular DRAM or some special
> > > > > > > on-chip memory and so it may or may not be safe to read from this
> > > > > > > address this early.
> > > > > > >
> > > > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > > > ---
> > > > > > > Cc: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >  common/Kconfig | 32 ++++++++++++++++++++++++++++++++
> > > > > > >  lib/fdtdec.c   | 11 +++--------
> > > > > > >  2 files changed, 35 insertions(+), 8 deletions(-)
> > > > > > >
> > > > > >
> > > > > > Since this is the essentially the same as my OF_BLOBLIST patch, which
> > > > > > was rejected:
> > > > > >
> > > > > > NAK
> > > > > >
> > > > > > The issue is not whether some 'previous stage' set up a bloblist. For
> > > > > > example, if VPL_BLOBLIST_PRIOR_STAGE is enabled, that presumably means
> > > > > > that TPL set it up. But it doesn't mean that TPL put the FDT in there.
> > > > >
> > > > > This is wrong. The root problem is saying that the bloblist is in
> > > > > possibly uninitialized memory. The code is quite happy to NOT find the
> > > > > device tree in the bloblist and continue searching other paths.
> > > >
> > > > But until the bloblist is set up, it doesn't exist.
> > >
> > > An almost philosophical statement, yes. How should the generic code know
> > > if it exists, or does not exist? That is the question.
> >
> > U-Boot code 'knows', since if this is the first phase which enables
> > CONFIG_IS_ENABLED(BLOBLOST), then the bloblist is available
> > before/after relocation as well as after RAM setup in SPL.
>
> And when U-Boot isn't the first stage?

The only case where that matters is for the devicetree, so we have
OF_BLOBLIST to control whether U-Boot looks for it. Eventually we can
drop BLOBLIST_FIXED and use registers, perhaps even on x86, which will
make things easier.

>
> > > > We should not be
> > > > looking for a bloblist that we know is not there yet. The bloblist is set
> > > > up by bloblist_init(). You seem to be imputing your own semantics for
> > > > bloblist.
> > >
> > > We don't know if the bloblist exists or not. That's the problem. It
> > > could already exist. That's the whole reason we're in this particular
> > > argument.
> >
> > See above.
>
> Yes, you seem to be missing the case where U-Boot isn't the first stage.

I really can't see how you came to that conclusion. Just enable
OF_BLOBLIST - in fact we can enable it for almost all boards today and
it won't harm anything.

>
> > > > In SPL, init happens in board_init_r(), i.e. after RAM is set up. So don't
> > > > look in the bloblist until it is set up! It doesn't exist.
> > >
> > > Unless of course it was setup before. We don't know if it was setup
> > > before or not until we look. A big part of the problem is that for prior
> > > to U-Boot bloblist we don't need to use main DRAM, the bloblist is tiny
> > > and we have some other persistent memory available. Unfortunately, x86
> > > does not.
> >
> > The only situation where this matters is for the devicetree, which I
> > why i created OF_BLOBLIST, a way to indicate that the bloblist should
> > be checked for a devicetree.
>
> Yes, you keep looking at this from the wrong direction and seem to have
> backed yourself in to a corner. Why are you insisting that for the
> normal use case of memory infos and maybe display parameters we need to
> carve out a hunk of main memory? A bloblist is perfectly capable of NOT
> containing things. We can avoid having to care about what phase of
> things we're in too.

Devicetree is the only 'strange' thing here because we need to look at
it early.  For Raymond's patch, it shouldn't need any conditions.

>
> > > > In U-Boot proper, we look for it before relocation, so we can relocate and
> > > > expand it for use with ACPI tables, etc.
> > >
> > > I'm not sure that's relevant. This means we've taken what we were passed
> > > at a fixed address and allocated more space for it and are using it
> > > somewhere else.
> >
> > Yes
> >
> > >
> > > > Take a look at this patch, too:
> > > >
> > > > 3d6531803e1 bloblist: Support initing from multiple places
> > >
> > > I'm not sure it's relevant. It does show we have a problem of not
> > > knowing if the bloblist exists, or not. And I don't think we're solving
> > > that right today (nor does v1 of my patch).
> >
> > OK
> >
> > >
> > > > > An alternative here would be to better document the requirements of
> > > > > BLOBLIST_ADDR, and then just disable it on chromebook_coral until
> > > > > someone is inclined to move DDR init in to TPL, or someone finds a
> > > > > non-main-memory address to use for BLOBLIST_ADDR or switches to using
> > > > > BLOBLIST_ALLOC.
> > > >
> > > > Coral's TPL runs in cache-as-ram, with a 30KB limit on code size. It cannot
> > > > do DDR init in TPL because the DDR blob is large (160KB?) and there is a
> > > > ton of setup to do first, in any case. When CAR goes away, its memory
> > > > vanishes, so you need to have copied the bloblist somewhere else (the
> > > > bloblist holds the MRC data which needs to be written to SPI flash later
> > > > on, when possible). This all works perfectly and there is really no need to
> > > > change anything.
> > >
> > > Ah, so there's some of the details finally. And oh goodness, we're
> > > writing to the SPI flash on each boot? That's not good for longevity...
> >
> > It writes a sector each time, across an area which can hold quite a
> > few writes. It only writes when the details change, so it is fine.
> > This algorithm has worked in the field for years across tens of
> > millions of devices and is common on x86.
>
> To be clear, I wasn't saying that its your design.

No, it isn't my design, but I would be happy if it were. You were
suggesting it had a longevity problem, so I wanted to explain it.

>
> > > > Again, you seem to be imputing semantics to bloblist which don't exist.
> > >
> > > Unfortunately some things were missed along the way, and are still
> > > missing.
> >
> > Well we should have started from OF_BLOBLIST and then dealt with
> > problems as they came up. In fact, so far there are no problems which
> > it can't solve.
> >
> > As it is, we have Raymond sending a patch to push the prior-stage mess
> > into TPM, for reasons which make no sense to me. It is just adding
> > confusion.
> >
> > One other thing we would have likely done by now if my patch[1] had
> > gone in a year ago, is moving away from BLOBLIST_FIXED to using a
> > register protocol. That is more deterministic.
> >
> > Regards,
> > Simon
> >
> > [1] https://patchwork.ozlabs.org/project/uboot/patch/20230830180524.315916-31-sjg@chromium.org/
>
> I think once again your obsession with OF_BLOBLIST and device tree is
> causing you to miss everything else. Today we can take a *bloblist* via
> register. Linaro wrote that, even. The next problem really is that we
> can't pass that bloblist along to the next stage because all of the
> U-Boot side of things assumes fixed address.

Perhaps if we had applied OF_BLOBLIST a year ago, so my special 3
ancient chromebooks that nobody cares about or uses apart from me,
worked, we could have got bloblist to where it should be today. You
are missing the big picture, but stopping me from pursuing it.

I am disappointed that it is only at this stage that you have shown
any interest in getting my special 3 ancient chromebooks running.

Regards,
Simon
