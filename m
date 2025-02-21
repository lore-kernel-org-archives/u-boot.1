Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0136EC021B2
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 01:30:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9F4880F56;
	Fri, 21 Feb 2025 02:30:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FPAwqQX3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAA818006D; Fri, 21 Feb 2025 02:30:36 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C1918007D
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 02:30:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5e0939c6456so2697303a12.3
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 17:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740101432; x=1740706232; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y2kdURbkTPAojBFhRwcbcpKmqYpaaowt7QcqWsdtffk=;
 b=FPAwqQX38eDb3BhpffBh2LfU4dLGF7GP5INi1X90buPK9vqGbIXXhWkD1BCoLOVEtq
 JVz/yQR8HtawoErjsKK48+rPrM63q99fz2CEJadR3N+3dPCT+TVlCav6itNbJPGirhx6
 NdeMIlW9E4Xc7pDw8Id5Xvf9DBGkg5wVEEiD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740101432; x=1740706232;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y2kdURbkTPAojBFhRwcbcpKmqYpaaowt7QcqWsdtffk=;
 b=AXVro15oEYYj41sCukaGvRMkBsWFCdUudW33fE7/k1LAugarQfqxbGuLBHdLZM6Z0C
 KMHZw99Nw42ic+OfVBbgMO9MotH6/j8+VJrwC7POAdUlE9cwbJhKvLw2foKBSpo7EvBe
 6/9ePktyFvDwKh+ZvYelntHbBn3Q0U/IViONgGRWesfkKpZes8LRMepbaPpRxf1Ft6zB
 qj+s0UDpLrZW1HSjVOfr4W0fsVrsaecGwRBXhuZpBt2NLx+DweF6ZaE7h2FBuGJejXcB
 DHM5Vli9/8FAndyRfX29Zr1g5qi6CCVnMVkO4Y/xBmI5ISmHJuI6fm9YUovb8MBDOKaY
 LEaw==
X-Gm-Message-State: AOJu0YwJJM+68fNiujig45Z0Ej6M1/L8C45xlt/sOy2ZM8vd76wbFsRM
 XpaK99QPU6BE0UosBWA71epDgDFCHfKcS9IfOWtU48g76b35zBkMAv5LeUtQG151TvqeSoFXPKR
 kQ2twloYdvTykKYKElYDfoFcoe5cc5xzkBUix
X-Gm-Gg: ASbGncvBdqNKGpn6Z40XoCVr3rKWyEwnUHp7H2WGClRCrlHtTDwYPkI8zXC+rN4cvvW
 VTnAbHJfKQ2jL7MCs31zw9W9icbx+xpvLYQtilOR9aGYYo6qxo7MWvFNx1JkfJB/unA+b+DjKD/
 VON/X75xgt
X-Google-Smtp-Source: AGHT+IHhyhxVn4/6gzz7tuCGjHjoChsZNEpvJi2yKTRL9tL+uNr/gZZUTyiaTOgbodd9ghL8mmheYvtskawzgeMcx9M=
X-Received: by 2002:a17:907:7758:b0:abb:519e:d395 with SMTP id
 a640c23a62f3a-abc0d9da124mr69350766b.20.1740101431262; Thu, 20 Feb 2025
 17:30:31 -0800 (PST)
MIME-Version: 1.0
References: <20250218144627.GC1233568@bill-the-cat>
 <CAFLszTjEawR5urHwb0MD70-0y-yyFLPgRwKNv4vxWVj8MzaWLg@mail.gmail.com>
 <20250219010708.GS1233568@bill-the-cat>
 <CAFLszTg5Q8eMPajxQ+wFgLgK=JhssN6KY9yg5kd0mW--NVypLg@mail.gmail.com>
 <20250219203406.GV1233568@bill-the-cat>
 <CAFLszTgnP7wGymh58coQBP=Rbui2O=ggXDT+Yu1pcgvCoLuFXw@mail.gmail.com>
 <20250220151643.GZ1233568@bill-the-cat>
 <CAFLszTiKbg2twYpJJTFb9bFya+5D2DsVPBGKXuw9pw6Y+cvUbg@mail.gmail.com>
 <20250220174005.GA1233568@bill-the-cat>
 <CAFLszTh=Mn9Hxe41KBB+8xjBBxVv=spV=g26tY+Hq6q43EM4=w@mail.gmail.com>
 <20250220204001.GC1233568@bill-the-cat>
In-Reply-To: <20250220204001.GC1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Feb 2025 18:30:18 -0700
X-Gm-Features: AWEUYZltlnjH8niA2Cs1kHh9jq9ntFlxly0vBwnNYuxrnUvwVJwwp5W1zdr4qPA
Message-ID: <CAFLszTjx1uQU+O=XrS6BBijpiSNtdR_-X_9LCjYZCSe+A0HC8g@mail.gmail.com>
Subject: Re: xPL Proposal
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
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

On Thu, 20 Feb 2025 at 13:40, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Feb 20, 2025 at 11:13:34AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 20 Feb 2025 at 10:40, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Feb 20, 2025 at 09:43:10AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Thu, 20 Feb 2025 at 08:16, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Feb 20, 2025 at 06:19:05AM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Wed, 19 Feb 2025 at 13:34, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Wed, Feb 19, 2025 at 07:48:17AM -0700, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Tue, 18 Feb 2025 at 18:07, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Feb 18, 2025 at 05:03:08PM -0700, Simon Glass wrote:
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Tue, 18 Feb 2025 at 07:46, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Tue, Feb 18, 2025 at 05:08:40AM -0700, Simon Glass wrote:
> > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > >
> > > > > > > > > > > > On Mon, 17 Feb 2025 at 17:40, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Mon, Feb 17, 2025 at 01:39:37PM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Mon, 17 Feb 2025 at 13:17, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Mon, Feb 17, 2025 at 01:47:32PM -0600, Tom Rini wrote:
> > > > > > > > > > > > > > > > On Mon, Feb 17, 2025 at 12:34:01PM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Mon, 17 Feb 2025 at 12:22, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > On Mon, Feb 17, 2025 at 12:11:12PM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > On Mon, 17 Feb 2025 at 11:50, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > On Tue, Feb 11, 2025 at 03:22:22PM -0600, Tom Rini wrote:
> > > > > > > > > > > > > > > > > > > > > On Tue, Feb 11, 2025 at 08:03:20AM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > > Hi,
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > I just wanted to send a note to (re-)introduce my ideas[1] for the
> > > > > > > > > > > > > > > > > > > > > > next iteration of xPL.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > A recent series introduced 'xPL' as the name for the various
> > > > > > > > > > > > > > > > > > > > > > pre-U-Boot phases, so now CONFIG_XPL_BUILD means that this is any xPL
> > > > > > > > > > > > > > > > > > > > > > phase and CONFIG_SPL means this really is the SPL phase, not TPL. We
> > > > > > > > > > > > > > > > > > > > > > still use filenames and function naming which uses 'spl', but could
> > > > > > > > > > > > > > > > > > > > > > potentially adjust that.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > The major remaining problem IMO is that it is quite tricky and
> > > > > > > > > > > > > > > > > > > > > > expensive (in terms of time) to add a new phase. We also have some
> > > > > > > > > > > > > > > > > > > > > > medium-sized problems:
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > a. The $(PHASE_), $(SPL_) rules in the Makefile are visually ugly and
> > > > > > > > > > > > > > > > > > > > > > can be confusing, particularly when combined with ifdef and ifneq
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > b. We have both CONFIG_IS_ENABLED() and IS_ENABLED() and they mean
> > > > > > > > > > > > > > > > > > > > > > different things. For any given option, some code uses one and some
> > > > > > > > > > > > > > > > > > > > > > the other, depending on what problems people have met along the way.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > c. An option like CONFIG_FOO is ambiguous, in that it could mean that
> > > > > > > > > > > > > > > > > > > > > > the option is enabled in one or more xPL phases, or just in U-Boot
> > > > > > > > > > > > > > > > > > > > > > proper. The only way to know is to look for $(PHASE_) etc. in the
> > > > > > > > > > > > > > > > > > > > > > Makefiles and CONFIG_IS_ENABLED() in the code. This is very confusing
> > > > > > > > > > > > > > > > > > > > > > and has not scaled well.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > d. We need to retain an important feature: options from different
> > > > > > > > > > > > > > > > > > > > > > phases can depend on each other. As an example, we might want to
> > > > > > > > > > > > > > > > > > > > > > enable MMC in SPL by default, if MMC is enabled in U-Boot proper. We
> > > > > > > > > > > > > > > > > > > > > > may also want to share values between phases, such as TEXT_BASE. We
> > > > > > > > > > > > > > > > > > > > > > can do this easily today, just by adding Kconfig rules.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > I agree with a through c and for d there are likely some cases even if
> > > > > > > > > > > > > > > > > > > > > I'm not sure TEXT_BASE is a good example. But I'm not sure it's as
> > > > > > > > > > > > > > > > > > > > > important as the other ones.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > Proposal
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > 1. Adjust kconf to generate separate autoconf.h files for each phase.
> > > > > > > > > > > > > > > > > > > > > > These contain the values for each Kconfig option for that phase. For
> > > > > > > > > > > > > > > > > > > > > > example CONFIG_TEXT_BASE in autoconf_spl.h is SPL's text base.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > 2. Add a file to resolve the ambiguity in (c) above, listing the
> > > > > > > > > > > > > > > > > > > > > > Kconfig options which should not be enabled/valid in any xPL build.
> > > > > > > > > > > > > > > > > > > > > > There are around 200 of these.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > 3. Introduce CONFIG_PPL as a new prefix, meaning U-Boot proper (only),
> > > > > > > > > > > > > > > > > > > > > > useful in rare cases. This indicates that the option applies only to
> > > > > > > > > > > > > > > > > > > > > > U-Boot proper and is not defined in any xPL build. It is analogous to
> > > > > > > > > > > > > > > > > > > > > > CONFIG_TPL_xxx meaning 'enabled in TPL'. Only a dozen of these are
> > > > > > > > > > > > > > > > > > > > > > needed at present, basically to allow access to the value for another
> > > > > > > > > > > > > > > > > > > > > > phase, e.g. SPL wanting to find CONFIG_PPL_TEXT_BASE so that it knows
> > > > > > > > > > > > > > > > > > > > > > the address to which U-Boot should be loaded.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > 4. There is no change to the existing defconfig files, or 'make
> > > > > > > > > > > > > > > > > > > > > > menuconfig', which works just as today, including dependencies between
> > > > > > > > > > > > > > > > > > > > > > options across all phases.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > 5. (next) Expand the Kconfig language[2] to support declaring phases
> > > > > > > > > > > > > > > > > > > > > > (SPL, TPL, etc.) and remove the need for duplicating options (DM_MMC,
> > > > > > > > > > > > > > > > > > > > > > SPL_DM_MMC, TPL_DM_MMC, VPL_DM_MMC), so allowing an option to be
> > > > > > > > > > > > > > > > > > > > > > declared once for any/all phases. We can then drop the file in 2
> > > > > > > > > > > > > > > > > > > > > > above.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > With this, maintaining Kconfig options, Makefiles and adding a new
> > > > > > > > > > > > > > > > > > > > > > phase should be considerably easier.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > I think this will not make our life easier, it will make things harder.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > I think what we've reached now shows that Yamada-san was correct at the
> > > > > > > > > > > > > > > > > > > > > time in saying that we were going down the wrong path with how we
> > > > > > > > > > > > > > > > > > > > > handled SPL/TPL.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > My request instead is:
> > > > > > > > > > > > > > > > > > > > > - Largely drop SPL/TPL/VPL (so no DM_MMC and SPL_DM_MMC and so on, just
> > > > > > > > > > > > > > > > > > > > >   DM_MMC) as a prefix.
> > > > > > > > > > > > > > > > > > > > > - Likely need to introduce a PPL symbol as you suggest.
> > > > > > > > > > > > > > > > > > > > > - Make PPL/SPL/TPL/VPL be a choice statement when building a defconfig.
> > > > > > > > > > > > > > > > > > > > > - Split something like rockpro64-rk3399_defconfig in to
> > > > > > > > > > > > > > > > > > > > >   rockpro64-rk3399_ppl_defconfig
> > > > > > > > > > > > > > > > > > > > >   rockpro64-rk3399_spl_defconfig rockpro64-rk3399_tpl_defconfig
> > > > > > > > > > > > > > > > > > > > >   and add Makefile logic such that for X_defconfig as a build target but
> > > > > > > > > > > > > > > > > > > > >   not configs/X_defconfig not existing, we see if any of
> > > > > > > > > > > > > > > > > > > > >   configs/X_{ppl,spl,tpl,vpl}_defconfig exist and we run a builds in
> > > > > > > > > > > > > > > > > > > > >   subdirectories of our object directory, and then using binman combine
> > > > > > > > > > > > > > > > > > > > >   as needed.
> > > > > > > > > > > > > > > > > > > > >   - Maybe instead the Makefile logic above we would parse X_defconfig
> > > > > > > > > > > > > > > > > > > > >     and see if it's a different format of say PHASE:file to make it
> > > > > > > > > > > > > > > > > > > > >     easier to say share a single TPL config with all rk3399, have a few
> > > > > > > > > > > > > > > > > > > > >     common SPL configs and then just a board specific PPL.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > This solves (a) by removing them entirely. This solves (b) by removing
> > > > > > > > > > > > > > > > > > > > > the ambiguity entirely (it will be enabled or not). As a bonus for (b)
> > > > > > > > > > > > > > > > > > > > > we can switch everyone to IS_ENABLED(CONFIG_FOO) and match up with the
> > > > > > > > > > > > > > > > > > > > > Linux Kernel again. This solves (c) again by removing it entirely.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Lets come back up here, to my proposal, since parts of it seem to have
> > > > > > > > > > > > > > > > > > > > not been clear enough. While what I'm proposing should work for any
> > > > > > > > > > > > > > > > > > > > platform and xPL -> xPL -> ... -> PPL, for this example let us assume
> > > > > > > > > > > > > > > > > > > > rockpro64-rk3399 supports the flow of TPL -> SPL -> PPL. Also, to
> > > > > > > > > > > > > > > > > > > > compare with today, it will be helpful to run "make
> > > > > > > > > > > > > > > > > > > > O=/tmp/rockpro64-rk3399_current rockpro64-rk3399_config" and have the
> > > > > > > > > > > > > > > > > > > > resulting .config file available.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > There shall be configs/rockpro64-rk3399_tpl_defconfig. This will contain
> > > > > > > > > > > > > > > > > > > > lines such as:
> > > > > > > > > > > > > > > > > > > > CONFIG_ARM=y
> > > > > > > > > > > > > > > > > > > > CONFIG_ARCH_ROCKCHIP=y
> > > > > > > > > > > > > > > > > > > > CONFIG_ROCKCHIP_RK3399=y
> > > > > > > > > > > > > > > > > > > > CONFIG_TPL=y
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > When you run "make O=/tmp/rockpro64-rk3399_tpl rockpro64-rk3399_tpl_defconfig"
> > > > > > > > > > > > > > > > > > > > the resulting .config file will contain lines such as:
> > > > > > > > > > > > > > > > > > > > # CONFIG_ROCKCHIP_EXTERNAL_TPL is not set
> > > > > > > > > > > > > > > > > > > > as this only makes sense in the context of building something that will
> > > > > > > > > > > > > > > > > > > > be TPL.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > A more complex example is that it will also contain:
> > > > > > > > > > > > > > > > > > > > CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Because looking at arch/arm/mach-rockchip/Makefile a bunch of that will
> > > > > > > > > > > > > > > > > > > > be able to be simplified (and spl_common.c should be renamed to
> > > > > > > > > > > > > > > > > > > > xpl_common.c) to:
> > > > > > > > > > > > > > > > > > > > obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) += spl.o spl-boot-order.o xpl_common.o
> > > > > > > > > > > > > > > > > > > > obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) += tpl.o xpl_common.o
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > The .config file here will also contain:
> > > > > > > > > > > > > > > > > > > > CONFIG_DM_SERIAL=y
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > What it will not contain is:
> > > > > > > > > > > > > > > > > > > > CONFIG_TPL_DM_SERIAL=y
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > This is because there is no 'config TPL_DM_SERIAL' option in
> > > > > > > > > > > > > > > > > > > > drivers/serial/Kconfig anymore.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > When you next run "make O=/tmp/rockpro64-rk3399_tpl all" the results in
> > > > > > > > > > > > > > > > > > > > /tmp/rockpro64-rk3399_tpl would be similar to the results as under
> > > > > > > > > > > > > > > > > > > > "/tmp/rockpro64-rk3399/tpl/" when building today.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > The contents of configs/rockpro64-rk3399_spl_defconfig would be similar
> > > > > > > > > > > > > > > > > > > > to the tpl one, except with SPL-only-ever-valid options such as
> > > > > > > > > > > > > > > > > > > > CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y but otherwise have CONFIG_DM_SERIAL=y
> > > > > > > > > > > > > > > > > > > > and no CONFIG_SPL_DM_SERIAL=y, and when building the "all" target, you
> > > > > > > > > > > > > > > > > > > > would only get similar results to what is under the spl/ directory
> > > > > > > > > > > > > > > > > > > > today.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Next we have configs/rockpro64-rk3399_ppl_defconfig.  When you run "make
> > > > > > > > > > > > > > > > > > > > O=/tmp/rockpro64-rk3399_ppl rockpro64-rk3399_ppl_defconfig" the
> > > > > > > > > > > > > > > > > > > > important difference is what you do not have. You do not have:
> > > > > > > > > > > > > > > > > > > > CONFIG_SPL=y
> > > > > > > > > > > > > > > > > > > > CONFIG_TPL=y
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Because we are not building SPL nor TPL. We're just making full U-Boot
> > > > > > > > > > > > > > > > > > > > itself. This is where in more full examples and with additional
> > > > > > > > > > > > > > > > > > > > restructure a "generic-arm64_ppl_defconfig" makes sense and be used
> > > > > > > > > > > > > > > > > > > > instead.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > This brings up what to do with "ockpro64-rk3399_defconfig". And I'm a
> > > > > > > > > > > > > > > > > > > > little unsure which of the things I mentioned above is best. It's
> > > > > > > > > > > > > > > > > > > > either:
> > > > > > > > > > > > > > > > > > > > a) Does not exist, top-level Makefile says roughly:
> > > > > > > > > > > > > > > > > > > > %_defconfig: %_tpl_defconfig %_spl_defconfig %_ppl_defconfig
> > > > > > > > > > > > > > > > > > > >   make O=$(objdir)/tpl %_tpl_defconfig all
> > > > > > > > > > > > > > > > > > > >   make O=$(objdir)/spl %_spl_defconfig all
> > > > > > > > > > > > > > > > > > > >   make O=$(objdir)/ppl %_ppl_defconfig all
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > But this might be too rigid.
> > > > > > > > > > > > > > > > > > > > b) It contains:
> > > > > > > > > > > > > > > > > > > > PHASE:VPL:rockpro64-rk3399_vpl_defconfig
> > > > > > > > > > > > > > > > > > > > PHASE:TPL:rockpro64-rk3399_tpl_defconfig
> > > > > > > > > > > > > > > > > > > > PHASE:SPL:rockpro64-rk3399_spl_defconfig
> > > > > > > > > > > > > > > > > > > > PHASE:PPL:rockpro64-rk3399_ppl_defconfig
> > > > > > > > > > > > > > > > > > > > And the top-level Makefile looks like:
> > > > > > > > > > > > > > > > > > > > %_defconfig:
> > > > > > > > > > > > > > > > > > > >   grep -q ^PHASE $@ || fatal "Invalid defconfig file, please see..."
> > > > > > > > > > > > > > > > > > > >   foreach line in $@
> > > > > > > > > > > > > > > > > > > >     make O=$(objdir)/$PHASE $CONFIGFILE all
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > It could also be some other suggestion.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Thanks for writing that up. It is somewhat clearer.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > What happens to the Makefiles? Do they still have $(PHASE_) in them?
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > No. Because CONFIG_SPL_FIT would never exist, $(CONFIG_$(PHASE_)FIT)
> > > > > > > > > > > > > > > > > > would be meaningless. Only rockpro64-rk3399_spl_defconfig would say
> > > > > > > > > > > > > > > > > > CONFIG_FIT=y (or more likely, only the resulting .config would say
> > > > > > > > > > > > > > > > > > CONFIG_FIT=y just like how configs/rockpro64-rk3399_defconfig doesn't
> > > > > > > > > > > > > > > > > > say CONFIG_FIT=y nor CONFIG_SPL_FIT=y).
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > But just above you said:
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > I believe this proposal will lead to the code and Makefiles being less
> > > > > > > > > > > > > > > > > > clear than they are today. The line:
> > > > > > > > > > > > > > > > > > drivers/Makefile:obj-$(CONFIG_$(PHASE_)BLK) += block/
> > > > > > > > > > > > > > > > > > will become:
> > > > > > > > > > > > > > > > > > drivers/Makefile:obj-$(CONFIG_BLK) += block/
> > > > > > > > > > > > > > > > > > without being clear that it could reference either full U-Boot (PPL) or
> > > > > > > > > > > > > > > > > > some xPL phase. While the same Makefile will continue to have (comments
> > > > > > > > > > > > > > > > > > my own):
> > > > > > > > > > > > > > > > > > obj-y += mtd/ # Subdirectory Makefiles control build contents
> > > > > > > > > > > > > > > > > > obj-$(CONFIG_MULTIPLEXER) += mux/ # Only valid for PPL.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > And so the situation for humans will be worse off than today because
> > > > > > > > > > > > > > > > > > while $(PHASE_) and $(XPL_) are confusing at times, they make it clear
> > > > > > > > > > > > > > > > > > what can and cannot be enabled in PPL vs xPL.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Doing "something" is not better than doing nothing in this case.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > So why is OK for your proposal to drop the $(PHASE_) stuff, but not mine?
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Because your proposal keeps CONFIG_SPL_BLK (and config SPL_BLK) and has
> > > > > > > > > > > > > > > > a .config file which says "CONFIG_SPL_BLK=y" but mine doesn't.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > With my
> > > > > > > > > > > > > > > proposal "I have a problem, and I want to see what my SPL build has with
> > > > > > > > > > > > > > > CONFIG_BLK=y. I can see hits in the source tree for CONFIG_BLK, the
> > > > > > > > > > > > > > > symbol I set, I can solve my problem."
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > There will be at least some matches, e.g. CONFIG_SPL_BLK in the
> > > > > > > > > > > > > > defconfig files and 'config SPL_BLK' in the source tree.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Yes, and that's confusing. I am arguing that your statement is more
> > > > > > > > > > > > > confusing than $(PHASE_)BLK is.
> > > > > > > > > > > >
> > > > > > > > > > > > OK
> > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Or to try and explain differently, with your proposal "I have a problem,
> > > > > > > > > > > > > > > > and I want to see what builds with CONFIG_SPL_BLK=y. Why is there no
> > > > > > > > > > > > > > > > match in the source tree for CONFIG_SPL_BLK or even SPL_BLK". With my
> > > > > > > > > > > > > > > > proposal "I have a problem, and I want to see what my SPL build has with
> > > > > > > > > > > > > > > > CONFIG_BLK=y. I can see hits in the source tree for CONFIG_BLK, the
> > > > > > > > > > > > > > > > symbol I set, I can solve my problem."
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Well, CONFIG_BLK will be in the source tree; it just means different
> > > > > > > > > > > > > > things for different phases.
> > > > > > > > > > > > >
> > > > > > > > > > > > > And it will be, with your proposal, controlled by BLK or SPL_BLK or
> > > > > > > > > > > > > TPL_BLK or VPL_BLK in the .config file but only CONFIG_BLK in Makefile
> > > > > > > > > > > > > and code.
> > > > > > > > > > > > >
> > > > > > > > > > > > > > It sounds like you want to get rid of the xPL prefixes for Kconfig
> > > > > > > > > > > > > > options, and that overrides all other considerations?
> > > > > > > > > > > > >
> > > > > > > > > > > > > It's one of the big problems we have today, and splc-working shows how
> > > > > > > > > > > > > much further the duplication must go. It's why I suggested the language
> > > > > > > > > > > > > modification before.
> > > > > > > > > > > > >
> > > > > > > > > > > > > > > My other try here was a bit unclear actually because of the confusion
> > > > > > > > > > > > > > > state your proposal gives us. Try try again directly, the problem is
> > > > > > > > > > > > > > > that CONFIG_SPL_BLK will be set (or unset) but not referenced in code.
> > > > > > > > > > > > > > > This will be true for many but not all SPL symbols as
> > > > > > > > > > > > > > > CONFIG_SPL_ROCKCHIP_COMMON_BOARD for example will still exist and need
> > > > > > > > > > > > > > > to be referenced. This is a more confusing state than $(PHASE_). $(XPL_)
> > > > > > > > > > > > > > > I think can just be replaced with $(PHASE_) but I haven't confirmed (I
> > > > > > > > > > > > > > > think it does show that the old way was confusing however).
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > OK, I think I see. You don't want people to have to 'know' that
> > > > > > > > > > > > > > CONFIG_xPL_xxx is used to control feature xxx in each xPL build?
> > > > > > > > > > > > >
> > > > > > > > > > > > > I'm saying they have to know that, and also know which symbols that's
> > > > > > > > > > > > > not true for. And that is more confusing than today. I'm saying that
> > > > > > > > > > > > > compared with today's arch/arm/mach-rockchip/Makefile the following is
> > > > > > > > > > > > > worse:
> > > > > > > > > > > > > diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
> > > > > > > > > > > > > index 5e7edc99cdc4..3b176966f75b 100644
> > > > > > > > > > > > > --- a/arch/arm/mach-rockchip/Makefile
> > > > > > > > > > > > > +++ b/arch/arm/mach-rockchip/Makefile
> > > > > > > > > > > > > @@ -29,7 +29,7 @@ ifeq ($(CONFIG_TPL_BUILD),)
> > > > > > > > > > > > >  obj-$(CONFIG_DISPLAY_CPUINFO) += cpu-info.o
> > > > > > > > > > > > >  endif
> > > > > > > > > > > > >
> > > > > > > > > > > > > -obj-$(CONFIG_$(PHASE_)RAM) += sdram.o
> > > > > > > > > > > > > +obj-$(CONFIG_RAM) += sdram.o
> > > > > > > > > > > > >
> > > > > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_PX30) += px30/
> > > > > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_RK3036) += rk3036/
> > > > > > > > > > > > >
> > > > > > > > > > > > > (And CONFIG_TPL_RAM and CONFIG_SPL_RAM still exist).
> > > > > > > > > > > > >
> > > > > > > > > > > > > And this is better:
> > > > > > > > > > > > >
> > > > > > > > > > > > > diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
> > > > > > > > > > > > > index 5e7edc99cdc4..23c30f68f878 100644
> > > > > > > > > > > > > --- a/arch/arm/mach-rockchip/Makefile
> > > > > > > > > > > > > +++ b/arch/arm/mach-rockchip/Makefile
> > > > > > > > > > > > > @@ -7,15 +7,13 @@
> > > > > > > > > > > > >  # this may have entered from ATF with the stack-pointer pointing to
> > > > > > > > > > > > >  # inaccessible/protected memory (and the bootrom-helper assumes that
> > > > > > > > > > > > >  # the stack-pointer is valid before switching to the U-Boot stack).
> > > > > > > > > > > > > -obj-spl-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
> > > > > > > > > > > > > -obj-spl-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) += spl.o spl-boot-order.o spl_common.o
> > > > > > > > > > > > > -obj-tpl-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
> > > > > > > > > > > > > -obj-tpl-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) += tpl.o spl_common.o
> > > > > > > > > > > > > -obj-tpl-$(CONFIG_ROCKCHIP_PX30) += px30-board-tpl.o
> > > > > > > > > > > > > +obj-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
> > > > > > > > > > > > > +obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) += spl.o spl-boot-order.o spl_common.o
> > > > > > > > > > > > > +obj-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
> > > > > > > > > > > > > +obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) += tpl.o spl_common.o
> > > > > > > > > > > > > +obj-$(CONFIG_ROCKCHIP_PX30) += px30-board-tpl.o
> > > > > > > > > > > > >
> > > > > > > > > > > > > -obj-spl-$(CONFIG_ROCKCHIP_RK3036) += rk3036-board-spl.o
> > > > > > > > > > > > > -
> > > > > > > > > > > > > -ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
> > > > > > > > > > > > > +obj-$(CONFIG_ROCKCHIP_RK3036) += rk3036-board-spl.o
> > > > > > > > > > > > >
> > > > > > > > > > > > >  # Always include boot_mode.o, as we bypass it (i.e. turn it off)
> > > > > > > > > > > > >  # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_REG is 0.  This way,
> > > > > > > > > > > > > @@ -23,14 +21,13 @@ ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
> > > > > > > > > > > > >  # meaning "turn it off".
> > > > > > > > > > > > >  obj-y += boot_mode.o
> > > > > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += board.o
> > > > > > > > > > > > > -endif
> > > > > > > > > > > > >
> > > > > > > > > > > > > -ifeq ($(CONFIG_TPL_BUILD),)
> > > > > > > > > > > > >  obj-$(CONFIG_DISPLAY_CPUINFO) += cpu-info.o
> > > > > > > > > > > > > -endif
> > > > > > > > > > > > >
> > > > > > > > > > > > > -obj-$(CONFIG_$(PHASE_)RAM) += sdram.o
> > > > > > > > > > > > > +obj-$(CONFIG_RAM) += sdram.o
> > > > > > > > > > > > >
> > > > > > > > > > > > > +ifdef CONFIG_PPL
> > > > > > > > > > > > > +# TODO: Audit these Makefiles see if they really must be PPL only
> > > > > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_PX30) += px30/
> > > > > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_RK3036) += rk3036/
> > > > > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_RK3066) += rk3066/
> > > > > > > > > > > > > @@ -46,10 +43,4 @@ obj-$(CONFIG_ROCKCHIP_RK3568) += rk3568/
> > > > > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_RK3588) += rk3588/
> > > > > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_RV1108) += rv1108/
> > > > > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_RV1126) += rv1126/
> > > > > > > > > > > > > -
> > > > > > > > > > > > > -# Clear out SPL objects, in case this is a TPL build
> > > > > > > > > > > > > -obj-spl-$(CONFIG_TPL_BUILD) =
> > > > > > > > > > > > > -
> > > > > > > > > > > > > -# Now add SPL/TPL objects back into the main build
> > > > > > > > > > > > > -obj-$(CONFIG_XPL_BUILD) += $(obj-spl-y)
> > > > > > > > > > > > > -obj-$(CONFIG_TPL_BUILD) += $(obj-tpl-y)
> > > > > > > > > > > > > +endif
> > > > > > > > > > > > > (CONFIG_SPL_RAM and CONFIG_TPL_RAM no longer exist as options).
> > > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > This Makefile is a very strange example. I've thought about cleaning
> > > > > > > > > > > > it up a few times, but then I know someone will say it needs to be in
> > > > > > > > > > > > its own series, etc. so I've never got around to it. Even with the
> > > > > > > > > > > > current xPL stuff (i.e. making CONFIG_SPL_BUILD mean just SPL) it is
> > > > > > > > > > > > needlessly complex.
> > > > > > > > > > >
> > > > > > > > > > > There's some complexity that can be removed here today, maybe. But not a
> > > > > > > > > > > lot of it, because it's complex to build three different things when
> > > > > > > > > > > configuring once.
> > > > > > > > > > >
> > > > > > > > > > > > Anyway, with my scheme, you can still use
> > > > > > > > > > > > CONFIG_SPL_ROCKCHIP_COMMON_BOARD if you want to. It adds SPL_ versions
> > > > > > > > > > >
> > > > > > > > > > > No. You have to use it still, with yours. Because
> > > > > > > > > > > "ROCKCHIP_COMMON_BOARD", "SPL_ROCKCHIP_COMMON_BOARD" and
> > > > > > > > > > > "TPL_ROCKCHIP_COMMON_BOARD" are the same concept of "use common board
> > > > > > > > > > > code" but different files at TPL, SPL and PPL. And you still have to
> > > > > > > > > > > with mine, because for the same reason. With mine, the Kconfig is:
> > > > > > > > > > > config SPL_ROCKCHIP_COMMON_BOARD
> > > > > > > > > > >   bool "SPL rockchip common board file"
> > > > > > > > > > >   depends on SPL
> > > > > > > > > > >
> > > > > > > > > > > config TPL_ROCKCHIP_COMMON_BOARD
> > > > > > > > > > >   bool "TPL rockchip common board file"
> > > > > > > > > > >   depends on TPL
> > > > > > > > > > >
> > > > > > > > > > > And since you are only ever configuring for TPL or SPL or PPL (or VPL or
> > > > > > > > > > > ...) the resulting config only ever asks for the appropriate one.
> > > > > > > > > > >
> > > > > > > > > > > > of symbols to autoconf_spl.h for this reason. There are also places in
> > > > > > > > > > > > the code where people directly check CONFIG_SPL_xxx and these need to
> > > > > > > > > > > > work.
> > > > > > > > > > >
> > > > > > > > > > > Yes, this is part of the confusion I keep noting with your proposal as
> > > > > > > > > > > it will be inconsistent for which symbols CONFIG_SPL_xxx is referred to
> > > > > > > > > > > in code as CONFIG_SPL_xxx or as CONFIG_xxx.
> > > > > > > > > >
> > > > > > > > > > If it is confusing, we can change all of them to CONFIG_xxx in a
> > > > > > > > > > follow-up. There is no need to mention SPL_, it just allows the
> > > > > > > > > > existing code to work without a wholesale change.
> > > > > > > > >
> > > > > > > > > No, that's not correct. Please look again at what I've written
> > > > > > > > > explaining why.
> > > > > > > >
> > > > > > > > See below.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > > > This surprised me:
> > > > > > > > > > > >
> > > > > > > > > > > > obj-$(CONFIG_RAM) += sdram.o
> > > > > > > > > > > >
> > > > > > > > > > > > Are you saying you are OK with this one, instead of, for example:
> > > > > > > > > > > >
> > > > > > > > > > > > obj-$(CONFIG_TPL_RAM) += sdram.o
> > > > > > > > > > > > obj-$(CONFIG_SPL_RAM) += sdram.o
> > > > > > > > > > > > obj-$(CONFIG_RAM) += sdram.o
> > > > > > > > > > > >
> > > > > > > > > > > > If so, why are you OK with that and not the others?
> > > > > > > > > > >
> > > > > > > > > > > Because there is no:
> > > > > > > > > > > config TPL_RAM
> > > > > > > > > > >   bool "RAM driver in TPL"
> > > > > > > > > > >
> > > > > > > > > > > in what I am proposing. That's why. There's one symbol because there's
> > > > > > > > > > > the same files being built.
> > > > > > > > > >
> > > > > > > > > > OK, well that works the same for my scheme too. Either will do.
> > > > > > > > >
> > > > > > > > > I don't see how that can work in your scheme.
> > > > > > > >
> > > > > > > > Here is the full Kconfig for that file, with my scheme:
> > > > > > > >
> > > > > > > > >>>>
> > > > > > > > # SPDX-License-Identifier: GPL-2.0+
> > > > > > > > #
> > > > > > > > # Copyright (c) 2014 Google, Inc
> > > > > > > > # Copyright (c) 2019 Rockchip Electronics Co., Ltd.
> > > > > > > >
> > > > > > > > # We don't want the bootrom-helper present in a full U-Boot build, as
> > > > > > > > # this may have entered from ATF with the stack-pointer pointing to
> > > > > > > > # inaccessible/protected memory (and the bootrom-helper assumes that
> > > > > > > > # the stack-pointer is valid before switching to the U-Boot stack).
> > > > > > > > obj-spl-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
> > > > > > > > obj-spl-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) += spl.o spl-boot-order.o
> > > > > > > > spl_common.o
> > > > > > > > obj-tpl-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
> > > > > > > > obj-tpl-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) += tpl.o spl_common.o
> > > > > > > > obj-tpl-$(CONFIG_ROCKCHIP_PX30) += px30-board-tpl.o
> > > > > > > >
> > > > > > > > obj-spl-$(CONFIG_ROCKCHIP_RK3036) += rk3036-board-spl.o
> > > > > > > >
> > > > > > > > ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
> > > > > > > >
> > > > > > > > # Always include boot_mode.o, as we bypass it (i.e. turn it off)
> > > > > > > > # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_REG is 0.  This way,
> > > > > > > > # we can have the preprocessor correctly recognise both 0x0 and 0
> > > > > > > > # meaning "turn it off".
> > > > > > > > obj-y += boot_mode.o
> > > > > > > > obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += board.o
> > > > > > > > endif
> > > > > > > >
> > > > > > > > ifeq ($(CONFIG_TPL_BUILD),)
> > > > > > > > obj-$(CONFIG_DISPLAY_CPUINFO) += cpu-info.o
> > > > > > > > endif
> > > > > > > >
> > > > > > > > obj-$(CONFIG_RAM) += sdram.o
> > > > > > > >
> > > > > > > > obj-$(CONFIG_ROCKCHIP_PX30) += px30/
> > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3036) += rk3036/
> > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3066) += rk3066/
> > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3128) += rk3128/
> > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3188) += rk3188/
> > > > > > > > obj-$(CONFIG_ROCKCHIP_RK322X) += rk322x/
> > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3288) += rk3288/
> > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3308) += rk3308/
> > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3328) += rk3328/
> > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3368) += rk3368/
> > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3399) += rk3399/
> > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3568) += rk3568/
> > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3588) += rk3588/
> > > > > > > > obj-$(CONFIG_ROCKCHIP_RV1108) += rv1108/
> > > > > > > > obj-$(CONFIG_ROCKCHIP_RV1126) += rv1126/
> > > > > > > >
> > > > > > > > # Clear out SPL objects, in case this is a TPL build
> > > > > > > > obj-spl-$(CONFIG_TPL_BUILD) =
> > > > > > > >
> > > > > > > > # Now add SPL/TPL objects back into the main build
> > > > > > > > obj-$(CONFIG_XPL_BUILD) += $(obj-spl-y)
> > > > > > > > obj-$(CONFIG_TPL_BUILD) += $(obj-tpl-y)
> > > > > > > > <<<<
> > > > > > > >
> > > > > > > > The only change is the line that was:
> > > > > > > > obj-$(CONFIG_$(PHASE_)RAM) += sdram.o
> > > > > > >
> > > > > > > Yes, that's also what I showed via unified diff format earlier, and so I
> > > > > > > agree.
> > > > > >
> > > > > > OK good.
> > > > > >
> > > > > > >
> > > > > > > > > > > > For this one:
> > > > > > > > > > > >
> > > > > > > > > > > > > +obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) += spl.o spl-boot-order.o spl_common.o
> > > > > > > > > > > >
> > > > > > > > > > > > I don't understand how it can work with your scheme, since you don't
> > > > > > > > > > > > want to have any CONFIG_SPL_ things?
> > > > > > > > > > >
> > > > > > > > > > > No, that's not what I've been saying and trying to make clear with my
> > > > > > > > > > > examples. I keep saying that there are explicitly SPL (or TPL or VPL)
> > > > > > > > > > > only options. And these need to be named as such. And so that's the
> > > > > > > > > > > confusion your proposal introduces (inconsistency about referring to a
> > > > > > > > > > > symbol that has been enabled) and mine removes entirely (we only ever
> > > > > > > > > > > refer to symbols based on their name).
> > > > > > > > > >
> > > > > > > > > > Right, but you still have 'config SPL_RAM', right? Would you keep
> > > > > > > > >
> > > > > > > > > No, again, I do not. Please re-read my proposal as you seem to keep
> > > > > > > > > making the same incorrect assumptions about it, and then saying that
> > > > > > > > > your scheme would also do that. They are very much not at all the same.
> > > > > > > >
> > > > > > > > Maybe we have reached the limits of email on this one, but I am quite
> > > > > > > > confused about your scheme. I suggested that you don't have
> > > > > > > > CONFIG_SPL_ things and you said tht was wrong. Then I asked if you
> > > > > > > > still have SPL_RAM and you said you don't. Let me try this:
> > > > > > > >
> > > > > > > > Q: In your scheme, do you have 'config SPL_RAM' and CONFIG_SPL_RAM, or
> > > > > > > > do you not?
> > > > > > >
> > > > > > > In my scheme we do not have 'config SPL_RAM' nor CONFIG_SPL_RAM as there
> > > > > > > is no case where 'config RAM' and 'CONFIG_RAM' is incorrect. Because we
> > > > > > > are never configuring and building for more than one phase.
> > > > > > >
> > > > > > > In my scheme we do have 'config SPL_ROCKCHIP_COMMON_BOARD and
> > > > > > > 'CONFIG_SPL_ROCKCHIP_COMMON_BOARD' because they are NOT the same thing
> > > > > > > as 'config ROCKCHIP_COMMON_BOARD' and 'CONFIG_ROCKCHIP_COMMON_BOARD'
> > > > > > > (and again for TPL_...). They control different code. While technically
> > > > > > > possible, I am arguing against overloading ROCKCHIP_COMMON_BOARD and
> > > > > > > having the Makefile have to do some two part check like we have today,
> > > > > > > as those are one of the pain points of adding new code.
> > > > > >
> > > > > > OK I think I have some sort of understanding now.
> > > > > >
> > > > > > Here is the patch that works for me (on top of your patch above). Note
> > > > > > that we don't have to make those changes, but they show how my scheme
> > > > > > is different in what it expects:
> > > > > >
> > > > > > diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
> > > > > > index 23c30f68f87..0593e028de4 100644
> > > > > > --- a/arch/arm/mach-rockchip/Makefile
> > > > > > +++ b/arch/arm/mach-rockchip/Makefile
> > > > > > @@ -7,27 +7,35 @@
> > > > > >  # this may have entered from ATF with the stack-pointer pointing to
> > > > > >  # inaccessible/protected memory (and the bootrom-helper assumes that
> > > > > >  # the stack-pointer is valid before switching to the U-Boot stack).
> > > > > > +ifdef CONFIG_XPL_BUILD
> > > > > >  obj-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
> > > > > > +endif
> > > > > > +ifdef CONFIG_SPL_BUILD
> > > > > >  obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) += spl.o spl-boot-order.o spl_common.o
> > > > > > -obj-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
> > > > > > +endif
> > > > > > +ifdef CONFIG_TPL_BUILD
> > > > > >  obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) += tpl.o spl_common.o
> > > > > > +endif
> > > > > >  obj-$(CONFIG_ROCKCHIP_PX30) += px30-board-tpl.o
> > > > > >
> > > > > >  obj-$(CONFIG_ROCKCHIP_RK3036) += rk3036-board-spl.o
> > > > > >
> > > > > > +ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
> > > > > > +
> > > > > >  # Always include boot_mode.o, as we bypass it (i.e. turn it off)
> > > > > >  # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_REG is 0.  This way,
> > > > > >  # we can have the preprocessor correctly recognise both 0x0 and 0
> > > > > >  # meaning "turn it off".
> > > > > >  obj-y += boot_mode.o
> > > > > >  obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += board.o
> > > > > > +endif
> > > > > >
> > > > > > +ifeq ($(CONFIG_TPL_BUILD),)
> > > > > >  obj-$(CONFIG_DISPLAY_CPUINFO) += cpu-info.o
> > > > > > +endif
> > > > > >
> > > > > >  obj-$(CONFIG_RAM) += sdram.o
> > > > > >
> > > > > > -ifdef CONFIG_PPL
> > > > > > -# TODO: Audit these Makefiles see if they really must be PPL only
> > > > > >  obj-$(CONFIG_ROCKCHIP_PX30) += px30/
> > > > > >  obj-$(CONFIG_ROCKCHIP_RK3036) += rk3036/
> > > > > >  obj-$(CONFIG_ROCKCHIP_RK3066) += rk3066/
> > > > > > @@ -43,4 +51,3 @@ obj-$(CONFIG_ROCKCHIP_RK3568) += rk3568/
> > > > > >  obj-$(CONFIG_ROCKCHIP_RK3588) += rk3588/
> > > > > >  obj-$(CONFIG_ROCKCHIP_RV1108) += rv1108/
> > > > > >  obj-$(CONFIG_ROCKCHIP_RV1126) += rv1126/
> > > > > > -endif
> > > > > > --
> > > > > > 2.43.0
> > > > > >
> > > > > >
> > > > > > Here's the full file:
> > > > > >
> > > > > > # SPDX-License-Identifier: GPL-2.0+
> > > > > > #
> > > > > > # Copyright (c) 2014 Google, Inc
> > > > > > # Copyright (c) 2019 Rockchip Electronics Co., Ltd.
> > > > > >
> > > > > > # We don't want the bootrom-helper present in a full U-Boot build, as
> > > > > > # this may have entered from ATF with the stack-pointer pointing to
> > > > > > # inaccessible/protected memory (and the bootrom-helper assumes that
> > > > > > # the stack-pointer is valid before switching to the U-Boot stack).
> > > > > > ifdef CONFIG_XPL_BUILD
> > > > > > obj-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
> > > > > > endif
> > > > > > ifdef CONFIG_SPL_BUILD
> > > > > > obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += spl.o spl-boot-order.o spl_common.o
> > > > > > endif
> > > > > > ifdef CONFIG_TPL_BUILD
> > > > > > obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += tpl.o spl_common.o
> > > > > > endif
> > > > > > obj-$(CONFIG_ROCKCHIP_PX30) += px30-board-tpl.o
> > > > > >
> > > > > > obj-$(CONFIG_ROCKCHIP_RK3036) += rk3036-board-spl.o
> > > > > >
> > > > > > ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
> > > > > >
> > > > > > # Always include boot_mode.o, as we bypass it (i.e. turn it off)
> > > > > > # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_REG is 0.  This way,
> > > > > > # we can have the preprocessor correctly recognise both 0x0 and 0
> > > > > > # meaning "turn it off".
> > > > > > obj-y += boot_mode.o
> > > > > > obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += board.o
> > > > > > endif
> > > > > >
> > > > > > ifeq ($(CONFIG_TPL_BUILD),)
> > > > > > obj-$(CONFIG_DISPLAY_CPUINFO) += cpu-info.o
> > > > > > endif
> > > > > >
> > > > > > obj-$(CONFIG_RAM) += sdram.o
> > > > > >
> > > > > > obj-$(CONFIG_ROCKCHIP_PX30) += px30/
> > > > > > obj-$(CONFIG_ROCKCHIP_RK3036) += rk3036/
> > > > > > obj-$(CONFIG_ROCKCHIP_RK3066) += rk3066/
> > > > > > obj-$(CONFIG_ROCKCHIP_RK3128) += rk3128/
> > > > > > obj-$(CONFIG_ROCKCHIP_RK3188) += rk3188/
> > > > > > obj-$(CONFIG_ROCKCHIP_RK322X) += rk322x/
> > > > > > obj-$(CONFIG_ROCKCHIP_RK3288) += rk3288/
> > > > > > obj-$(CONFIG_ROCKCHIP_RK3308) += rk3308/
> > > > > > obj-$(CONFIG_ROCKCHIP_RK3328) += rk3328/
> > > > > > obj-$(CONFIG_ROCKCHIP_RK3368) += rk3368/
> > > > > > obj-$(CONFIG_ROCKCHIP_RK3399) += rk3399/
> > > > > > obj-$(CONFIG_ROCKCHIP_RK3568) += rk3568/
> > > > > > obj-$(CONFIG_ROCKCHIP_RK3588) += rk3588/
> > > > > > obj-$(CONFIG_ROCKCHIP_RV1108) += rv1108/
> > > > > > obj-$(CONFIG_ROCKCHIP_RV1126) += rv1126/
> > > > > >
> > > > > > So we need CONFIG_SPL_BUILD when using a
> > > > > > CONFIG_SPL_ROCKCHIP_COMMON_BOARD option which I agree looks strange.
> > > > > >
> > > > > > We can't do this with my scheme:
> > > > > >
> > > > > > obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += spl.o spl-boot-order.o spl_common.o
> > > > > > obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += tpl.o spl_common.o
> > > > >
> > > > > You can't do that with any scheme, to be clear. I don't know why you're
> > > > > mentioning it.
> > > >
> > > > Just so we have a baseline.
> > > >
> > > > >
> > > > > > since that will compile both targets into whatever phases are enabled.
> > > > > >
> > > > > > To me, the ifdef I have above is less confusing than that, but I would
> > > > > > actually prefer this:
> > > > > >
> > > > > > ifdef CONFIG_ROCKCHIP_COMMON_BOARD
> > > > > > obj-$(CONFIG_SPL_BUILD) += spl.o spl-boot-order.o spl_common.o
> > > > > > obj-$(CONFIG_TPL_BUILD) += tpl.o spl_common.o
> > > > > > endif
> > > > >
> > > > > That would be less bad than what you've had earlier, yes. But I think
> > > > > mine is still clearer.
> > > >
> > > > Sure.
> > > >
> > > > >
> > > > > > Anyway, this is a strange case and I don't think it is a huge deal. In
> > > > >
> > > > > Yes, but it's not the only case like this, it's just the first one that
> > > > > came to mind.
> > > >
> > > > I've not seen that sort of construct (spl-xxx += ...) in U-Boot
> > > > before, so I don't think it is common. I am sure there are others, but
> > > > my scheme does work with existing Makefiles.
> > >
> > > It's one of many examples of the workarounds needed for "do we want this
> > > object in all phases or just some phases".
> >
> > You're being too negative IMO. Most of the time the right thing
> > happens. Yes there are corner cases but I believe you are
> > mischaracterising my scheme.
>
> It's the problem with the way things work today, not just your scheme.
> It's also one of the not infrequent pain points for what we have today
> for including / excluding something from a given phase.
>
> > > > > > general, when you enable an option for some phases you get that code
> > > > > > in those phases. When you actually *don't* want the code in a
> > > > > > particular phase, either don't set the option, or add another
> > > > > > condition.
> > > > >
> > > > > And your proposal doesn't solve that problem, still. Go back up in the
> > > > > thread and see the DWC3 example I wanted to see if was still broken, and
> > > > > is still broken.
> > > >
> > > > What is broken about it? Are you using the old series? I don't see any
> > > > changes to the Makefile there in my new series.
> > >
> > > I summarized things in the email there. And yes, your series does not
> > > address and seemingly makes even worse, the problem of
> > > including/excluding DWC3 from different phases.
> >
> > But I really don't know what is wrong with DWC3, honest! When I build
> > pinebook-pro-rk3399 I don't actually see any drivers/usb in SPL,
> > neither before or after my series. So can you please explain in a bit
> > more detail what you are getting at? The latest version is at splg4 in
> > my tree, although it's not finished.
>
> One of the first steps described in the problem statement is enabling
> USB gadget for SPL only. This then blows up due to how we have / haven't
> done workarounds for *USB_DWC3* symbols in Kconfig and also Makefile
> logic.
>
> > > > > > After all, the current Makefile code is actually a bit of a
> > > > > > workaround. Any scheme is going to have drawbacks.
> > > > >
> > > > > Yes, there's lots of workarounds. My scheme removes all of those
> > > > > workarounds once complete. What phase is being configured and built is a
> > > > > strict "pick 1 from N" and so we do not have CONFIG_SPL_BUILD,
> > > > > CONFIG_TPL_BUILD, CONFIG_XPL_BUILD, etc.
> > > >
> > > > Yes, I think that's right. For the most part my scheme will do the
> > > > same, but there will be exceptions, like the rockchip one.
> > >
> > > If you're referring to arch/arm/mach-rockchip/Makefile that could be
> > > rewritten, today, to be a little less cumbersome. It is still an example
> > > of the tricky workarounds that are needed for including/excluding
> > > objects based on phases, and is another example of how your series would
> > > not make adding a new phase easier.
> >
> > It makes it easier because you don't have to add loads of plumbing to
> > get a new phase. Also, with Kconfig changes, adding a phase could
> > become just a Kconfig thing, with everything else downstream of that,
> > There would be no need to add completely new Kconfig symbols for every
> > feature.
>
> I guess this is what you've put up in "splg4" now? I'll refrain from
> commenting until I've had a chance to see what you've done here.
>
> > > > > > With my scheme, I want to have the options for all phases in each
> > > > > > autoconf_xpl.h so that you can check an option for one phase in
> > > > > > another. That is part of my intent to (as now) have a single Kconfig
> > > > > > which covers every option in every phase. The down-side of that is
> > > > > > that you have to be aware of it.
> > > > >
> > > > > Yes, and we're going to violate a whole lot of  "least surprise" rules
> > > > > by changing how something we've borrowed from a much larger and more
> > > > > popular project works (and also how other projects which borrow it
> > > > > work).
> > > >
> > > > I don't agree with that. Linux only builds a single build. We are
> > > > always going to have to do more here than Linux. Also Linux has no
> > > > interest in taking our Kbuild patches and incidentally, held out
> > > > against FIT for 10 years! Linux will do what it wants to do. This is
> > > > U-Boot.
> > >
> > > Again, I am proposing we only do a single build.
> > >
> > > And yes, this is U-Boot where one of our key attractions is "It's just
> > > like working in the Linux Kernel, which you're likely already familiar
> > > with". So "Ah, but CONFIG_FOO doesn't mean CONFIG_FOO!" will violate
> > > that, badly.
> >
> > It means CONFIG_FOO for the phase being built, the same as your
> > scheme. From that POV all we are really talking about is the style of
> > plumbing.
> >
> > If I could think of a way to express things differently in Kconfig, I
> > would do that. I did suggest at the start some possible extensions,
> > but you don't want those either.
>
> Yes, I suggested language extensions to reduce the symbol increase of
> "splc-working". I need to look at "splg4" now as that's apparently
> entirely different before making assumptions and commenting further.
>
> > > > > > This did get me thinking though, whether with my scheme we could
> > > > > > (later) change Kconfig so that there is an SPL symbol, which is only
> > > > > > true when building SPL. Basically we would change the existing SPL to
> > > > > > HAVE_SPL, and SPL_BUILD to SPL. But we could put the 'new' SPL into
> > > > > > Kconfig, so you can depend on it, etc. Lots of options have 'depends
> > > > > > on SPL' which would mean 'depends on HAVE_SPL', but we could just
> > > > > > leave them as they are.
> > > > > >
> > > > > > So then you could use
> > > > > >
> > > > > > config SPL_ROCKCHIP_COMMON_BOARD
> > > > > >     depends on SPL
> > > > > >
> > > > > > config TPL_ROCKCHIP_COMMON_BOARD
> > > > > >     depends on TPL
> > > > > >
> > > > > > and this would work:
> > > > > >
> > > > > > obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) += spl.o spl-boot-order.o spl_common.o
> > > > > > obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) += tpl.o spl_common.o
> > > > > >
> > > > > > But there is a down-side. Because SPL_ROCKCHIP_COMMON_BOARD is not
> > > > > > enabled in the TPL build, TPL will not have visibility into that
> > > > > > option. We have effectively moved closer to your scheme: still with a
> > > > > > unified Kconfig, but completely split in the source code. Still, we
> > > > > > can control that, by having (for example) SPL_TEXT_BASE depend on the
> > > > > > new HAVE_SPL instead of SPL. That way, CONFIG_SPL_TEXT_BASE it will
> > > > > > appear in all builds.
> > > > >
> > > > > Yes, that sounds like it will make some of the existing complex logic
> > > > > even more complex, and I'm not sure of the benefit.
> > > >
> > > > Trying to split the difference between our schemes. I'm going to call
> > > > this 'option A' for my scheme.
> > > >
> > > > >
> > > > > > We also have to run the 'conf' tool multiple times.
> > > > >
> > > > > And to be clear, with my scheme that's a requirement since we're only
> > > > > building and configuring a single phase. The files I've described with
> > > > > "PHASE:XPL:file" are a nice-to-have on top bit, and not required
> > > > > especially if it leads to confusion while discussing things.
> > > >
> > > > Yes, understood.
> > > >
> > > > Basically I think both schemes work. At present I think we should go
> > > > with my scheme now, since it is pretty close to being complete and
> > > > involves minimal change to the existing Kconfig, then either do option
> > > > A, or decide to split the Kconfig completely, i.e. your scheme. It
> > > > seems that you believe my scheme is worse than the status quo, though,
> > > > right?
> > >
> > > I think we need to come up with some way to get the community to vote on
> > > your scheme or status quo. I don't think your scheme is "pretty close"
> > > to being complete and I think it will make things worse than doing
> > > nothing. I was hoping to get you to think about implementing what I
> > > proposed instead, but since I still don't think you've understood it,
> > > that's not an option either.
> >
> > I just don't like splitting the defconfig into completely different
> > files. I know that will open up all sorts of issues. For example, how
> > will this code work?:
> >
> > ulong spl_get_image_text_base(void)
> > {
> > #ifdef CONFIG_VPL
> >    if (xpl_next_phase() == PHASE_VPL)
> >       return CONFIG_VPL_TEXT_BASE;
> > #endif
> >    return xpl_next_phase() == PHASE_SPL ? CONFIG_SPL_TEXT_BASE :
> >       CONFIG_TEXT_BASE;
> > }
>
> Well, we start by asking why the FIT image being loaded isn't populated
> with the load address being valid. And then is anyone still using
> u-boot.bin and not u-boot.img and could we not just tidy away the whole
> function?

Sure, but we can't even get sunxi bootstd or LED over the line. How do
you imagine we could retire the legacy image?

>
> But then if yes we need that function, we would do:
>
> config PPL_TEXT_BASE
>         hex "Static load address for full U-Boot, formerly TEXT_BASE"
>         depends on PPL || SPL
>         ... current default 0xABC if BAR list for TEXT_BASE
>
> config TPL_TEXT_BASE
>         hex "Static load address for TPL phase of U-Boot"
>         depends on TPL
>         ... default 0xABC if BAR list
>
> config VPL_TEXT_BASE
>         hex "Static load address for VPL phase of U-Boot"
>         depends on (TPL && SUPPORTS_VPL) || VPL
>         ... default 0xABC if BAR list
>
> config SPL_TEXT_BASE
>         hex "Static load address for SPL phase of U-Boot"
>         depends on ((TPL || VPL) && SUPPORTS_SPL) || SPL
>         ... current set of default 0xABC if BAR list
>
> ulong spl_get_image_text_base(void)
> {
> #if defined(CONFIG_TPL) && defined(CONFIG_SUPPORTS_VPL)
>         return CONFIG_VPL_TEXT_BASE;
> #elif (defined(CONFIG_TPL) || defined(CONFIG_VPL)) && \
>                 defined(CONFIG_SUPPORTS_SPL)
>         return CONFIG_SPL_TEXT_BASE;
> #else
>         return CONFIG_PPL_TEXT_BASE;
> #endif
> }
>
> And I assume one of your objections to the above is that we've removed
> the macro functions that evaluate to 0 and let the optimizer discard
> things (except for CC_OPTIMIZE_FOR_DEBUG related problems). But I also
> see clever macros like that as a hindrance to understanding the code.

Actually, my objection is that it is very confusing. Mixing TPL and
VPL and SPL. We have to do this for every symbol that depends on or
uses a default from another phase??

> We
> would also change xpl_phase() to:
> static inline enum xpl_phase_t xpl_phase(void)
> {
> #ifdef CONFIG_TPL
>         return PHASE_TPL;
> #elif defined(CONFIG_VPL)
>         return PHASE_VPL;
> #elif defined(CONFIG_SPL)
>         return PHASE_SPL;
> #else
>         DECLARE_GLOBAL_DATA_PTR;
>
>         if (!(gd->flags & GD_FLG_RELOC))
>                 return PHASE_BOARD_F;
>         else
>                 return PHASE_BOARD_R;
> #endif
> }
>
> But could not use it above because we will not globally have *TEXT_BASE
> defined. And I don't worry about keeping these in sync between different
> defconfig files as they are SoC dependent features. And maybe it's a
> sign that my notion that we should have these defaults in the main
> symbol, rather than arch/... various subdirs .../Kconfig was wrong and
> has discouraged setting appropriate defaults. Because in this specific
> example, FPGA-fun aside, it's not very arbitrary as to what address
> space where is available to use when. Well Known Defaults should be
> provided.

I'm not sure, but yes, perhaps arch/ or even board/ is a better place.

>
> > > But imagine you aren't interested in
> > > hearing No and not doing it, again.
> >
> > Not particularly, but I could just do nothing on this.
>
> I will look at "splg4" once it's somewhere on source.denx.de and I can
> look at it, and refrain from otherwise assuming how it solves the
> problems I had seen previously.

I pushed an updated version to dm/splg-working but it is not very
updated. Still needs more work.

Regards,
Simon
