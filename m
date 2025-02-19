Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946D2C021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 00:03:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29AFA80F53;
	Wed, 19 Feb 2025 01:03:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="citw1/t6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 119D1800B3; Wed, 19 Feb 2025 01:03:26 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B887680077
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 01:03:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ab744d5e567so57954066b.1
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 16:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739923401; x=1740528201; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oawb/pxL/i4zir88wxNQt6rpBal45GqjMPpihF6EgL8=;
 b=citw1/t6IJ0tadcUPfcWv7j97GMxSaQvh5Go3JbVPmBmzidRZV14xug3gkNRp5QPtF
 GPevpe7RyW4H0GxYJNKtX26h8sofF0cSyPB3k88VKPiozCEzEf2eUNkR358Yph1qYZym
 6KOxPq1tnOWQ7OQ0+Hk+dYsdqKKW4uFMl83Zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739923401; x=1740528201;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oawb/pxL/i4zir88wxNQt6rpBal45GqjMPpihF6EgL8=;
 b=vm7qooFxDtJMT24JjAswQWoD6IJkUsmqw8Y715OFaX10rF/1sAv1MlKU7Vrvwbvj5+
 209ELN1EbvaRlbSvdi3F6Zaj4lX7IkoLCiaWclUnvyVM2tW9FKLVyJxVs6K+Lf1GfAVn
 irRXzO+TC5XRWFmQOvOWkwHAdUFYhyfr5Gsew/uGuUeN0cB21xx5Fd3gDXPCoTCQtxiT
 FCD/vm9hHZM1el5uQH68jHct5a/3y1/pdgopxgZ1slgMyJmsLRkNeXFFAiiZhmpaGpK1
 sz7bMgKfACxaqBf50HdvljeOGfABit3keOW/IAljP5ZtX9X22RGJKOyBZFYo5O2rcCm3
 BVXw==
X-Gm-Message-State: AOJu0Yz65kZ6zCGCsArE3dtypvtCD1ZBm722+fBeRZLIgX9M8EOLgEBt
 j+BMuMcFvC4IOwgKNdk0VW4IGIQ29RsA99wskpEjYM78BQ6itILlLQqMozKwzxbh7PyF7yKwFvD
 dZ6qEKf2S1tikCgVaetXtJFOT4gXPsxeWQkW/+0u8iCZwYFP/Mw==
X-Gm-Gg: ASbGncvXc7ZaHWXNgS3uGsEYQ2y4D0K6ynjrQi7/iqVAj9FfmyMHzMbXLVk2EdKuOS/
 7bv7w9UeTcRHsh6fuOyLLgUPXDtQ10rfiUbw4KJJ30OZWKeVGojmpRCEeTm25eXDDhRe8Lnr3og
 ==
X-Google-Smtp-Source: AGHT+IFmP/cPNjQEwP9rDfscVCQGekZ80s1/VDAbvwYWX9TeQ4ZlC5hl/GN/e/Wc0GSrJzewNlNK5cVtwkq5Mxm0EtM=
X-Received: by 2002:a17:907:6884:b0:abb:d334:73e7 with SMTP id
 a640c23a62f3a-abbd3347d31mr46500366b.14.1739923400866; Tue, 18 Feb 2025
 16:03:20 -0800 (PST)
MIME-Version: 1.0
References: <20250211212222.GH1233568@bill-the-cat>
 <20250217185035.GT1233568@bill-the-cat>
 <CAFLszTjeiX+40we55cH+0nmzpLvDZ5j=JQU21hZ1VQ85Arb0hQ@mail.gmail.com>
 <20250217192156.GV1233568@bill-the-cat>
 <CAFLszThTF+VQ2LduU6Ji_a-W8hYt+i38j-C7ccNZwJb+XkfwRQ@mail.gmail.com>
 <20250217194732.GY1233568@bill-the-cat>
 <20250217201751.GZ1233568@bill-the-cat>
 <CAFLszTjvoo=z8DDJjmL0_H2qKHX8vKTCVXBG+pth009HekdUOQ@mail.gmail.com>
 <20250218004025.GA1233568@bill-the-cat>
 <CAFLszTh3FD9KEzDcMOuf=otMBhV3BarTGe68Qs_w1fFa1JT2XA@mail.gmail.com>
 <20250218144627.GC1233568@bill-the-cat>
In-Reply-To: <20250218144627.GC1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 18 Feb 2025 17:03:08 -0700
X-Gm-Features: AWEUYZmyMfdJPdXKZGuBQTakzQ2WObPPcyYU0-zCyCBNoUi9ADw-jTklyY9tYqQ
Message-ID: <CAFLszTjEawR5urHwb0MD70-0y-yyFLPgRwKNv4vxWVj8MzaWLg@mail.gmail.com>
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

On Tue, 18 Feb 2025 at 07:46, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Feb 18, 2025 at 05:08:40AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 17 Feb 2025 at 17:40, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Feb 17, 2025 at 01:39:37PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 17 Feb 2025 at 13:17, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Mon, Feb 17, 2025 at 01:47:32PM -0600, Tom Rini wrote:
> > > > > > On Mon, Feb 17, 2025 at 12:34:01PM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Mon, 17 Feb 2025 at 12:22, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Feb 17, 2025 at 12:11:12PM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Mon, 17 Feb 2025 at 11:50, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tue, Feb 11, 2025 at 03:22:22PM -0600, Tom Rini wrote:
> > > > > > > > > > > On Tue, Feb 11, 2025 at 08:03:20AM -0700, Simon Glass wrote:
> > > > > > > > > > > > Hi,
> > > > > > > > > > > >
> > > > > > > > > > > > I just wanted to send a note to (re-)introduce my ideas[1] for the
> > > > > > > > > > > > next iteration of xPL.
> > > > > > > > > > > >
> > > > > > > > > > > > A recent series introduced 'xPL' as the name for the various
> > > > > > > > > > > > pre-U-Boot phases, so now CONFIG_XPL_BUILD means that this is any xPL
> > > > > > > > > > > > phase and CONFIG_SPL means this really is the SPL phase, not TPL. We
> > > > > > > > > > > > still use filenames and function naming which uses 'spl', but could
> > > > > > > > > > > > potentially adjust that.
> > > > > > > > > > > >
> > > > > > > > > > > > The major remaining problem IMO is that it is quite tricky and
> > > > > > > > > > > > expensive (in terms of time) to add a new phase. We also have some
> > > > > > > > > > > > medium-sized problems:
> > > > > > > > > > > >
> > > > > > > > > > > > a. The $(PHASE_), $(SPL_) rules in the Makefile are visually ugly and
> > > > > > > > > > > > can be confusing, particularly when combined with ifdef and ifneq
> > > > > > > > > > > >
> > > > > > > > > > > > b. We have both CONFIG_IS_ENABLED() and IS_ENABLED() and they mean
> > > > > > > > > > > > different things. For any given option, some code uses one and some
> > > > > > > > > > > > the other, depending on what problems people have met along the way.
> > > > > > > > > > > >
> > > > > > > > > > > > c. An option like CONFIG_FOO is ambiguous, in that it could mean that
> > > > > > > > > > > > the option is enabled in one or more xPL phases, or just in U-Boot
> > > > > > > > > > > > proper. The only way to know is to look for $(PHASE_) etc. in the
> > > > > > > > > > > > Makefiles and CONFIG_IS_ENABLED() in the code. This is very confusing
> > > > > > > > > > > > and has not scaled well.
> > > > > > > > > > > >
> > > > > > > > > > > > d. We need to retain an important feature: options from different
> > > > > > > > > > > > phases can depend on each other. As an example, we might want to
> > > > > > > > > > > > enable MMC in SPL by default, if MMC is enabled in U-Boot proper. We
> > > > > > > > > > > > may also want to share values between phases, such as TEXT_BASE. We
> > > > > > > > > > > > can do this easily today, just by adding Kconfig rules.
> > > > > > > > > > >
> > > > > > > > > > > I agree with a through c and for d there are likely some cases even if
> > > > > > > > > > > I'm not sure TEXT_BASE is a good example. But I'm not sure it's as
> > > > > > > > > > > important as the other ones.
> > > > > > > > > > >
> > > > > > > > > > > > Proposal
> > > > > > > > > > > >
> > > > > > > > > > > > 1. Adjust kconf to generate separate autoconf.h files for each phase.
> > > > > > > > > > > > These contain the values for each Kconfig option for that phase. For
> > > > > > > > > > > > example CONFIG_TEXT_BASE in autoconf_spl.h is SPL's text base.
> > > > > > > > > > > >
> > > > > > > > > > > > 2. Add a file to resolve the ambiguity in (c) above, listing the
> > > > > > > > > > > > Kconfig options which should not be enabled/valid in any xPL build.
> > > > > > > > > > > > There are around 200 of these.
> > > > > > > > > > > >
> > > > > > > > > > > > 3. Introduce CONFIG_PPL as a new prefix, meaning U-Boot proper (only),
> > > > > > > > > > > > useful in rare cases. This indicates that the option applies only to
> > > > > > > > > > > > U-Boot proper and is not defined in any xPL build. It is analogous to
> > > > > > > > > > > > CONFIG_TPL_xxx meaning 'enabled in TPL'. Only a dozen of these are
> > > > > > > > > > > > needed at present, basically to allow access to the value for another
> > > > > > > > > > > > phase, e.g. SPL wanting to find CONFIG_PPL_TEXT_BASE so that it knows
> > > > > > > > > > > > the address to which U-Boot should be loaded.
> > > > > > > > > > > >
> > > > > > > > > > > > 4. There is no change to the existing defconfig files, or 'make
> > > > > > > > > > > > menuconfig', which works just as today, including dependencies between
> > > > > > > > > > > > options across all phases.
> > > > > > > > > > > >
> > > > > > > > > > > > 5. (next) Expand the Kconfig language[2] to support declaring phases
> > > > > > > > > > > > (SPL, TPL, etc.) and remove the need for duplicating options (DM_MMC,
> > > > > > > > > > > > SPL_DM_MMC, TPL_DM_MMC, VPL_DM_MMC), so allowing an option to be
> > > > > > > > > > > > declared once for any/all phases. We can then drop the file in 2
> > > > > > > > > > > > above.
> > > > > > > > > > > >
> > > > > > > > > > > > With this, maintaining Kconfig options, Makefiles and adding a new
> > > > > > > > > > > > phase should be considerably easier.
> > > > > > > > > > >
> > > > > > > > > > > I think this will not make our life easier, it will make things harder.
> > > > > > > > > > >
> > > > > > > > > > > I think what we've reached now shows that Yamada-san was correct at the
> > > > > > > > > > > time in saying that we were going down the wrong path with how we
> > > > > > > > > > > handled SPL/TPL.
> > > > > > > > > > >
> > > > > > > > > > > My request instead is:
> > > > > > > > > > > - Largely drop SPL/TPL/VPL (so no DM_MMC and SPL_DM_MMC and so on, just
> > > > > > > > > > >   DM_MMC) as a prefix.
> > > > > > > > > > > - Likely need to introduce a PPL symbol as you suggest.
> > > > > > > > > > > - Make PPL/SPL/TPL/VPL be a choice statement when building a defconfig.
> > > > > > > > > > > - Split something like rockpro64-rk3399_defconfig in to
> > > > > > > > > > >   rockpro64-rk3399_ppl_defconfig
> > > > > > > > > > >   rockpro64-rk3399_spl_defconfig rockpro64-rk3399_tpl_defconfig
> > > > > > > > > > >   and add Makefile logic such that for X_defconfig as a build target but
> > > > > > > > > > >   not configs/X_defconfig not existing, we see if any of
> > > > > > > > > > >   configs/X_{ppl,spl,tpl,vpl}_defconfig exist and we run a builds in
> > > > > > > > > > >   subdirectories of our object directory, and then using binman combine
> > > > > > > > > > >   as needed.
> > > > > > > > > > >   - Maybe instead the Makefile logic above we would parse X_defconfig
> > > > > > > > > > >     and see if it's a different format of say PHASE:file to make it
> > > > > > > > > > >     easier to say share a single TPL config with all rk3399, have a few
> > > > > > > > > > >     common SPL configs and then just a board specific PPL.
> > > > > > > > > > >
> > > > > > > > > > > This solves (a) by removing them entirely. This solves (b) by removing
> > > > > > > > > > > the ambiguity entirely (it will be enabled or not). As a bonus for (b)
> > > > > > > > > > > we can switch everyone to IS_ENABLED(CONFIG_FOO) and match up with the
> > > > > > > > > > > Linux Kernel again. This solves (c) again by removing it entirely.
> > > > > > > > > >
> > > > > > > > > > Lets come back up here, to my proposal, since parts of it seem to have
> > > > > > > > > > not been clear enough. While what I'm proposing should work for any
> > > > > > > > > > platform and xPL -> xPL -> ... -> PPL, for this example let us assume
> > > > > > > > > > rockpro64-rk3399 supports the flow of TPL -> SPL -> PPL. Also, to
> > > > > > > > > > compare with today, it will be helpful to run "make
> > > > > > > > > > O=/tmp/rockpro64-rk3399_current rockpro64-rk3399_config" and have the
> > > > > > > > > > resulting .config file available.
> > > > > > > > > >
> > > > > > > > > > There shall be configs/rockpro64-rk3399_tpl_defconfig. This will contain
> > > > > > > > > > lines such as:
> > > > > > > > > > CONFIG_ARM=y
> > > > > > > > > > CONFIG_ARCH_ROCKCHIP=y
> > > > > > > > > > CONFIG_ROCKCHIP_RK3399=y
> > > > > > > > > > CONFIG_TPL=y
> > > > > > > > > >
> > > > > > > > > > When you run "make O=/tmp/rockpro64-rk3399_tpl rockpro64-rk3399_tpl_defconfig"
> > > > > > > > > > the resulting .config file will contain lines such as:
> > > > > > > > > > # CONFIG_ROCKCHIP_EXTERNAL_TPL is not set
> > > > > > > > > > as this only makes sense in the context of building something that will
> > > > > > > > > > be TPL.
> > > > > > > > > >
> > > > > > > > > > A more complex example is that it will also contain:
> > > > > > > > > > CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
> > > > > > > > > >
> > > > > > > > > > Because looking at arch/arm/mach-rockchip/Makefile a bunch of that will
> > > > > > > > > > be able to be simplified (and spl_common.c should be renamed to
> > > > > > > > > > xpl_common.c) to:
> > > > > > > > > > obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) += spl.o spl-boot-order.o xpl_common.o
> > > > > > > > > > obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) += tpl.o xpl_common.o
> > > > > > > > > >
> > > > > > > > > > The .config file here will also contain:
> > > > > > > > > > CONFIG_DM_SERIAL=y
> > > > > > > > > >
> > > > > > > > > > What it will not contain is:
> > > > > > > > > > CONFIG_TPL_DM_SERIAL=y
> > > > > > > > > >
> > > > > > > > > > This is because there is no 'config TPL_DM_SERIAL' option in
> > > > > > > > > > drivers/serial/Kconfig anymore.
> > > > > > > > > >
> > > > > > > > > > When you next run "make O=/tmp/rockpro64-rk3399_tpl all" the results in
> > > > > > > > > > /tmp/rockpro64-rk3399_tpl would be similar to the results as under
> > > > > > > > > > "/tmp/rockpro64-rk3399/tpl/" when building today.
> > > > > > > > > >
> > > > > > > > > > The contents of configs/rockpro64-rk3399_spl_defconfig would be similar
> > > > > > > > > > to the tpl one, except with SPL-only-ever-valid options such as
> > > > > > > > > > CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y but otherwise have CONFIG_DM_SERIAL=y
> > > > > > > > > > and no CONFIG_SPL_DM_SERIAL=y, and when building the "all" target, you
> > > > > > > > > > would only get similar results to what is under the spl/ directory
> > > > > > > > > > today.
> > > > > > > > > >
> > > > > > > > > > Next we have configs/rockpro64-rk3399_ppl_defconfig.  When you run "make
> > > > > > > > > > O=/tmp/rockpro64-rk3399_ppl rockpro64-rk3399_ppl_defconfig" the
> > > > > > > > > > important difference is what you do not have. You do not have:
> > > > > > > > > > CONFIG_SPL=y
> > > > > > > > > > CONFIG_TPL=y
> > > > > > > > > >
> > > > > > > > > > Because we are not building SPL nor TPL. We're just making full U-Boot
> > > > > > > > > > itself. This is where in more full examples and with additional
> > > > > > > > > > restructure a "generic-arm64_ppl_defconfig" makes sense and be used
> > > > > > > > > > instead.
> > > > > > > > > >
> > > > > > > > > > This brings up what to do with "ockpro64-rk3399_defconfig". And I'm a
> > > > > > > > > > little unsure which of the things I mentioned above is best. It's
> > > > > > > > > > either:
> > > > > > > > > > a) Does not exist, top-level Makefile says roughly:
> > > > > > > > > > %_defconfig: %_tpl_defconfig %_spl_defconfig %_ppl_defconfig
> > > > > > > > > >   make O=$(objdir)/tpl %_tpl_defconfig all
> > > > > > > > > >   make O=$(objdir)/spl %_spl_defconfig all
> > > > > > > > > >   make O=$(objdir)/ppl %_ppl_defconfig all
> > > > > > > > > >
> > > > > > > > > > But this might be too rigid.
> > > > > > > > > > b) It contains:
> > > > > > > > > > PHASE:VPL:rockpro64-rk3399_vpl_defconfig
> > > > > > > > > > PHASE:TPL:rockpro64-rk3399_tpl_defconfig
> > > > > > > > > > PHASE:SPL:rockpro64-rk3399_spl_defconfig
> > > > > > > > > > PHASE:PPL:rockpro64-rk3399_ppl_defconfig
> > > > > > > > > > And the top-level Makefile looks like:
> > > > > > > > > > %_defconfig:
> > > > > > > > > >   grep -q ^PHASE $@ || fatal "Invalid defconfig file, please see..."
> > > > > > > > > >   foreach line in $@
> > > > > > > > > >     make O=$(objdir)/$PHASE $CONFIGFILE all
> > > > > > > > > >
> > > > > > > > > > It could also be some other suggestion.
> > > > > > > > >
> > > > > > > > > Thanks for writing that up. It is somewhat clearer.
> > > > > > > > >
> > > > > > > > > What happens to the Makefiles? Do they still have $(PHASE_) in them?
> > > > > > > >
> > > > > > > > No. Because CONFIG_SPL_FIT would never exist, $(CONFIG_$(PHASE_)FIT)
> > > > > > > > would be meaningless. Only rockpro64-rk3399_spl_defconfig would say
> > > > > > > > CONFIG_FIT=y (or more likely, only the resulting .config would say
> > > > > > > > CONFIG_FIT=y just like how configs/rockpro64-rk3399_defconfig doesn't
> > > > > > > > say CONFIG_FIT=y nor CONFIG_SPL_FIT=y).
> > > > > > >
> > > > > > > But just above you said:
> > > > > > >
> > > > > > > > I believe this proposal will lead to the code and Makefiles being less
> > > > > > > > clear than they are today. The line:
> > > > > > > > drivers/Makefile:obj-$(CONFIG_$(PHASE_)BLK) += block/
> > > > > > > > will become:
> > > > > > > > drivers/Makefile:obj-$(CONFIG_BLK) += block/
> > > > > > > > without being clear that it could reference either full U-Boot (PPL) or
> > > > > > > > some xPL phase. While the same Makefile will continue to have (comments
> > > > > > > > my own):
> > > > > > > > obj-y += mtd/ # Subdirectory Makefiles control build contents
> > > > > > > > obj-$(CONFIG_MULTIPLEXER) += mux/ # Only valid for PPL.
> > > > > > > >
> > > > > > > > And so the situation for humans will be worse off than today because
> > > > > > > > while $(PHASE_) and $(XPL_) are confusing at times, they make it clear
> > > > > > > > what can and cannot be enabled in PPL vs xPL.
> > > > > > > >
> > > > > > > > Doing "something" is not better than doing nothing in this case.
> > > > > > >
> > > > > > > So why is OK for your proposal to drop the $(PHASE_) stuff, but not mine?
> > > > > >
> > > > > > Because your proposal keeps CONFIG_SPL_BLK (and config SPL_BLK) and has
> > > > > > a .config file which says "CONFIG_SPL_BLK=y" but mine doesn't.
> > > > > >
> > > >
> > > > > With my
> > > > > proposal "I have a problem, and I want to see what my SPL build has with
> > > > > CONFIG_BLK=y. I can see hits in the source tree for CONFIG_BLK, the
> > > > > symbol I set, I can solve my problem."
> > > >
> > > > There will be at least some matches, e.g. CONFIG_SPL_BLK in the
> > > > defconfig files and 'config SPL_BLK' in the source tree.
> > >
> > > Yes, and that's confusing. I am arguing that your statement is more
> > > confusing than $(PHASE_)BLK is.
> >
> > OK
> >
> > >
> > > > > > Or to try and explain differently, with your proposal "I have a problem,
> > > > > > and I want to see what builds with CONFIG_SPL_BLK=y. Why is there no
> > > > > > match in the source tree for CONFIG_SPL_BLK or even SPL_BLK". With my
> > > > > > proposal "I have a problem, and I want to see what my SPL build has with
> > > > > > CONFIG_BLK=y. I can see hits in the source tree for CONFIG_BLK, the
> > > > > > symbol I set, I can solve my problem."
> > > >
> > > > Well, CONFIG_BLK will be in the source tree; it just means different
> > > > things for different phases.
> > >
> > > And it will be, with your proposal, controlled by BLK or SPL_BLK or
> > > TPL_BLK or VPL_BLK in the .config file but only CONFIG_BLK in Makefile
> > > and code.
> > >
> > > > It sounds like you want to get rid of the xPL prefixes for Kconfig
> > > > options, and that overrides all other considerations?
> > >
> > > It's one of the big problems we have today, and splc-working shows how
> > > much further the duplication must go. It's why I suggested the language
> > > modification before.
> > >
> > > > > My other try here was a bit unclear actually because of the confusion
> > > > > state your proposal gives us. Try try again directly, the problem is
> > > > > that CONFIG_SPL_BLK will be set (or unset) but not referenced in code.
> > > > > This will be true for many but not all SPL symbols as
> > > > > CONFIG_SPL_ROCKCHIP_COMMON_BOARD for example will still exist and need
> > > > > to be referenced. This is a more confusing state than $(PHASE_). $(XPL_)
> > > > > I think can just be replaced with $(PHASE_) but I haven't confirmed (I
> > > > > think it does show that the old way was confusing however).
> > > >
> > > > OK, I think I see. You don't want people to have to 'know' that
> > > > CONFIG_xPL_xxx is used to control feature xxx in each xPL build?
> > >
> > > I'm saying they have to know that, and also know which symbols that's
> > > not true for. And that is more confusing than today. I'm saying that
> > > compared with today's arch/arm/mach-rockchip/Makefile the following is
> > > worse:
> > > diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
> > > index 5e7edc99cdc4..3b176966f75b 100644
> > > --- a/arch/arm/mach-rockchip/Makefile
> > > +++ b/arch/arm/mach-rockchip/Makefile
> > > @@ -29,7 +29,7 @@ ifeq ($(CONFIG_TPL_BUILD),)
> > >  obj-$(CONFIG_DISPLAY_CPUINFO) += cpu-info.o
> > >  endif
> > >
> > > -obj-$(CONFIG_$(PHASE_)RAM) += sdram.o
> > > +obj-$(CONFIG_RAM) += sdram.o
> > >
> > >  obj-$(CONFIG_ROCKCHIP_PX30) += px30/
> > >  obj-$(CONFIG_ROCKCHIP_RK3036) += rk3036/
> > >
> > > (And CONFIG_TPL_RAM and CONFIG_SPL_RAM still exist).
> > >
> > > And this is better:
> > >
> > > diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
> > > index 5e7edc99cdc4..23c30f68f878 100644
> > > --- a/arch/arm/mach-rockchip/Makefile
> > > +++ b/arch/arm/mach-rockchip/Makefile
> > > @@ -7,15 +7,13 @@
> > >  # this may have entered from ATF with the stack-pointer pointing to
> > >  # inaccessible/protected memory (and the bootrom-helper assumes that
> > >  # the stack-pointer is valid before switching to the U-Boot stack).
> > > -obj-spl-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
> > > -obj-spl-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) += spl.o spl-boot-order.o spl_common.o
> > > -obj-tpl-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
> > > -obj-tpl-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) += tpl.o spl_common.o
> > > -obj-tpl-$(CONFIG_ROCKCHIP_PX30) += px30-board-tpl.o
> > > +obj-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
> > > +obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) += spl.o spl-boot-order.o spl_common.o
> > > +obj-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
> > > +obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) += tpl.o spl_common.o
> > > +obj-$(CONFIG_ROCKCHIP_PX30) += px30-board-tpl.o
> > >
> > > -obj-spl-$(CONFIG_ROCKCHIP_RK3036) += rk3036-board-spl.o
> > > -
> > > -ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
> > > +obj-$(CONFIG_ROCKCHIP_RK3036) += rk3036-board-spl.o
> > >
> > >  # Always include boot_mode.o, as we bypass it (i.e. turn it off)
> > >  # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_REG is 0.  This way,
> > > @@ -23,14 +21,13 @@ ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
> > >  # meaning "turn it off".
> > >  obj-y += boot_mode.o
> > >  obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += board.o
> > > -endif
> > >
> > > -ifeq ($(CONFIG_TPL_BUILD),)
> > >  obj-$(CONFIG_DISPLAY_CPUINFO) += cpu-info.o
> > > -endif
> > >
> > > -obj-$(CONFIG_$(PHASE_)RAM) += sdram.o
> > > +obj-$(CONFIG_RAM) += sdram.o
> > >
> > > +ifdef CONFIG_PPL
> > > +# TODO: Audit these Makefiles see if they really must be PPL only
> > >  obj-$(CONFIG_ROCKCHIP_PX30) += px30/
> > >  obj-$(CONFIG_ROCKCHIP_RK3036) += rk3036/
> > >  obj-$(CONFIG_ROCKCHIP_RK3066) += rk3066/
> > > @@ -46,10 +43,4 @@ obj-$(CONFIG_ROCKCHIP_RK3568) += rk3568/
> > >  obj-$(CONFIG_ROCKCHIP_RK3588) += rk3588/
> > >  obj-$(CONFIG_ROCKCHIP_RV1108) += rv1108/
> > >  obj-$(CONFIG_ROCKCHIP_RV1126) += rv1126/
> > > -
> > > -# Clear out SPL objects, in case this is a TPL build
> > > -obj-spl-$(CONFIG_TPL_BUILD) =
> > > -
> > > -# Now add SPL/TPL objects back into the main build
> > > -obj-$(CONFIG_XPL_BUILD) += $(obj-spl-y)
> > > -obj-$(CONFIG_TPL_BUILD) += $(obj-tpl-y)
> > > +endif
> > > (CONFIG_SPL_RAM and CONFIG_TPL_RAM no longer exist as options).
> > >
> >
> > This Makefile is a very strange example. I've thought about cleaning
> > it up a few times, but then I know someone will say it needs to be in
> > its own series, etc. so I've never got around to it. Even with the
> > current xPL stuff (i.e. making CONFIG_SPL_BUILD mean just SPL) it is
> > needlessly complex.
>
> There's some complexity that can be removed here today, maybe. But not a
> lot of it, because it's complex to build three different things when
> configuring once.
>
> > Anyway, with my scheme, you can still use
> > CONFIG_SPL_ROCKCHIP_COMMON_BOARD if you want to. It adds SPL_ versions
>
> No. You have to use it still, with yours. Because
> "ROCKCHIP_COMMON_BOARD", "SPL_ROCKCHIP_COMMON_BOARD" and
> "TPL_ROCKCHIP_COMMON_BOARD" are the same concept of "use common board
> code" but different files at TPL, SPL and PPL. And you still have to
> with mine, because for the same reason. With mine, the Kconfig is:
> config SPL_ROCKCHIP_COMMON_BOARD
>   bool "SPL rockchip common board file"
>   depends on SPL
>
> config TPL_ROCKCHIP_COMMON_BOARD
>   bool "TPL rockchip common board file"
>   depends on TPL
>
> And since you are only ever configuring for TPL or SPL or PPL (or VPL or
> ...) the resulting config only ever asks for the appropriate one.
>
> > of symbols to autoconf_spl.h for this reason. There are also places in
> > the code where people directly check CONFIG_SPL_xxx and these need to
> > work.
>
> Yes, this is part of the confusion I keep noting with your proposal as
> it will be inconsistent for which symbols CONFIG_SPL_xxx is referred to
> in code as CONFIG_SPL_xxx or as CONFIG_xxx.

If it is confusing, we can change all of them to CONFIG_xxx in a
follow-up. There is no need to mention SPL_, it just allows the
existing code to work without a wholesale change.

>
> > This surprised me:
> >
> > obj-$(CONFIG_RAM) += sdram.o
> >
> > Are you saying you are OK with this one, instead of, for example:
> >
> > obj-$(CONFIG_TPL_RAM) += sdram.o
> > obj-$(CONFIG_SPL_RAM) += sdram.o
> > obj-$(CONFIG_RAM) += sdram.o
> >
> > If so, why are you OK with that and not the others?
>
> Because there is no:
> config TPL_RAM
>   bool "RAM driver in TPL"
>
> in what I am proposing. That's why. There's one symbol because there's
> the same files being built.

OK, well that works the same for my scheme too. Either will do.

>
> > For this one:
> >
> > > +obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) += spl.o spl-boot-order.o spl_common.o
> >
> > I don't understand how it can work with your scheme, since you don't
> > want to have any CONFIG_SPL_ things?
>
> No, that's not what I've been saying and trying to make clear with my
> examples. I keep saying that there are explicitly SPL (or TPL or VPL)
> only options. And these need to be named as such. And so that's the
> confusion your proposal introduces (inconsistency about referring to a
> symbol that has been enabled) and mine removes entirely (we only ever
> refer to symbols based on their name).

Right, but you still have 'config SPL_RAM', right? Would you keep
CONFIG_IS_ENABLED() with your scheme? What goes in the autoconf_spl.h
file? Is it CONFIG_RAM or CONFIG_SPL_RAM ? If the former then your
'obj-$(CONFIG_RAM)' is confusing because you said you want to know if
something is multi-phase or not. If the latter, then yours has the
same 'confusion' as mine.

Or are you talking about a wholesale rework of Kconfig, changing
everything to work in a new way?

>
> > Also, while we are talking about Makefiles, your scheme requires a lot
> > of rework to get right. It won't 'just work' with existing Makefiles.
>
> In that we change from "one config, multiple passes through the entire
> source tree" to "one config, one pass through the entire source tree",
> yes, in the end it would.

OK

>
> > My scheme does, but for a handle of tweaks,
> > e.g.drivers/phy/cadence/Makefile . It even allows the $(PHASE_) things
> > to be kept.
>
> As part of iterative implementation of it, what I'm proposing could
> likely fake defining CONFIG_SPL_BUILD, etc so that Makefiles don't have
> to be cleaned up right away. And $(PHASE_) could also be removed over
> time (since it would be an empty string) if we wanted to go that route.
>
> > It also works (so far as I can tell) with your changes
> > above.
>
> I continue to not see how that's possible. The only commonality is that
> we would both remove $(PHASE_) / $(XPL_) from the Makefiles.

It's possible because my scheme produces essentially the same
autoconf.h files as yours, just by a different means.

IMO there is not a huge difference between our schemes and I can
clearly see that mine can come before yours and that yours is a
possible next step along the path after that.

I still don't understand if what you don't like about my scheme is
based on a misunderstanding of what it does, or a genuine flaw in my
scheme.

Regards,
Simon
