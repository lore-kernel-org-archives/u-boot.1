Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A627C021A4
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 20:05:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7B6180C83;
	Wed, 12 Feb 2025 21:05:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TkDiKPhv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9491280C7E; Wed, 12 Feb 2025 21:05:26 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A54B1807C0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 21:05:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ab7c81b8681so32101266b.0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 12:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739390723; x=1739995523; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oyb5xrCWTPYD6P3WfxpjLerCQ0UIGvC72GWf7vFNmv0=;
 b=TkDiKPhvfktiCKjwGVURb9XZgoHUTYjpdoysCaU5i2kLJFbljQgsFNzAtFKvrxaqED
 RwjiNgGbtAu/zN6PunpCjxxPaUjZxdaRPGnff9ru2xUVDfrJAPNeq0oW3MezJw7jaVbo
 YigXOXtw1zQOh8lj813TL9h6OQpxhOPY9AP6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739390723; x=1739995523;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oyb5xrCWTPYD6P3WfxpjLerCQ0UIGvC72GWf7vFNmv0=;
 b=nkwOdIrWwDaC7B4pMRKc0s5NBnmNGJItWxBAHSYFvvTrHf31kmpagfcItSeLCvl7/r
 2Dfbug6hBIMITDuWz85QTN0VXLDG7v/Z5NAm2rFHOq89p1taBO1bukQryFHLTQXyXeZH
 IHmbL+73wlr1iOD031xit2RyfzKUoW3D7xKIphsZPXkm/VGq4/uZo25Kin6PXKg1G9MT
 4XElRfDk3fXEJqUxI4tMWDvZMW8sSgz772jeN0hCDrmsyM6ujtNFr0sjXa2vP8d+QvZM
 BxzHvSKnB7pZQBt3IfHUxLuzPClfw8YCVNvCItI3kVhFPursLmbIgCmQpeAEVMAvQFu0
 Z9hw==
X-Gm-Message-State: AOJu0Yx83aGTMiiodOkBr1JNO5bbK6dsQS/Q6VX2/awHZ0f7BofmOHCM
 I9K2VebocrCz/NrcxPRZOkOECIGwmZwl9gssuxABlIuT81HQ6k5ueKOtU14O7stU0DRdYqSGHwE
 CEC7E3sGcDoC1y4vQkfowJYi05xm3Vf4haxgL
X-Gm-Gg: ASbGncsfBlund0bqSEckmlA2HAJunzYgUxJd9e7F0HSdCe85dxfU1RmvlNOfFvFR4Ud
 llh0o36yy/ZDVaytxMW9RUxd7qzIKBoMtzRkQawxEzwAUPjhhlqo0JTjSfgCEc/GZ37u0C7Br++
 Ir1HqvMOBEFIzL845RPYwpcPetr7puBg==
X-Google-Smtp-Source: AGHT+IG/CNUnA3dd7qLuq3oF3N1LiqwGd7vzcMHTALt9wfuRU9363ojry+UVLvodSk/F92Y1QFbChB9jqH/LN5S4hMs=
X-Received: by 2002:a17:907:da5:b0:ab7:b84:544d with SMTP id
 a640c23a62f3a-ab7f376a33fmr364985566b.22.1739390722839; Wed, 12 Feb 2025
 12:05:22 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=ieT2oaHfgLf3_nC+xXA9g@mail.gmail.com>
 <20250211212222.GH1233568@bill-the-cat>
 <CAFLszTjaGsXZH6_CAbBhwJ7MAPdzdOUYn=CVBewQKCMX2CS1EQ@mail.gmail.com>
 <20250212164000.GO1233568@bill-the-cat>
 <CAFLszTghQcXGUWS-5GRtWydMzLyYKgKKi7Sd4_NikVrDGHkuzA@mail.gmail.com>
 <20250212183537.GQ1233568@bill-the-cat>
In-Reply-To: <20250212183537.GQ1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 12 Feb 2025 13:05:11 -0700
X-Gm-Features: AWEUYZnijfZJaX-vxZEYaymSRlwcX4ZasJ4oWRLblTcc5shXS3XHt8lkOBPIDso
Message-ID: <CAFLszTh5HS49DY1iqqcm_mT3tm2maUVAxyTXoP=5QxL1obw+jw@mail.gmail.com>
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

On Wed, 12 Feb 2025 at 11:35, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Feb 12, 2025 at 10:41:45AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 12 Feb 2025 at 09:40, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Feb 11, 2025 at 03:54:21PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, 11 Feb 2025 at 14:22, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Feb 11, 2025 at 08:03:20AM -0700, Simon Glass wrote:
> > > > > > Hi,
> > > > > >
> > > > > > I just wanted to send a note to (re-)introduce my ideas[1] for the
> > > > > > next iteration of xPL.
> > > > > >
> > > > > > A recent series introduced 'xPL' as the name for the various
> > > > > > pre-U-Boot phases, so now CONFIG_XPL_BUILD means that this is any xPL
> > > > > > phase and CONFIG_SPL means this really is the SPL phase, not TPL. We
> > > > > > still use filenames and function naming which uses 'spl', but could
> > > > > > potentially adjust that.
> > > > > >
> > > > > > The major remaining problem IMO is that it is quite tricky and
> > > > > > expensive (in terms of time) to add a new phase. We also have some
> > > > > > medium-sized problems:
> > > > > >
> > > > > > a. The $(PHASE_), $(SPL_) rules in the Makefile are visually ugly and
> > > > > > can be confusing, particularly when combined with ifdef and ifneq
> > > > > >
> > > > > > b. We have both CONFIG_IS_ENABLED() and IS_ENABLED() and they mean
> > > > > > different things. For any given option, some code uses one and some
> > > > > > the other, depending on what problems people have met along the way.
> > > > > >
> > > > > > c. An option like CONFIG_FOO is ambiguous, in that it could mean that
> > > > > > the option is enabled in one or more xPL phases, or just in U-Boot
> > > > > > proper. The only way to know is to look for $(PHASE_) etc. in the
> > > > > > Makefiles and CONFIG_IS_ENABLED() in the code. This is very confusing
> > > > > > and has not scaled well.
> > > > > >
> > > > > > d. We need to retain an important feature: options from different
> > > > > > phases can depend on each other. As an example, we might want to
> > > > > > enable MMC in SPL by default, if MMC is enabled in U-Boot proper. We
> > > > > > may also want to share values between phases, such as TEXT_BASE. We
> > > > > > can do this easily today, just by adding Kconfig rules.
> > > > >
> > > > > I agree with a through c and for d there are likely some cases even if
> > > > > I'm not sure TEXT_BASE is a good example. But I'm not sure it's as
> > > > > important as the other ones.
> > > >
> > > > OK. No, TEXT_BASE is not a great example in my book either. But it is
> > > > true that SPL needs to know U-Boot's text base.
> > > >
> > > > Here's another:
> > > >
> > > > config SPL_SYS_MALLOC_F_LEN
> > > >    default SYS_MALLOC_F_LEN
> > > >
> > > > config TPL_SYS_MALLOC_F
> > > >    default y if SPL_SYS_MALLOC_F
> > > >
> > > > config TPL_SYS_MALLOC_F_LEN
> > > >    depends on TPL_SYS_MALLOC_F
> > > >    default SPL_SYS_MALLOC_F_LEN
> > >
> > > Alternatively:
> > > config SYS_MALLOC_LEN
> > >    ... current default X if Y
> > >    default 0x2800 if RCAR_GEN3 && !PPL
> > >    default 0x2000 if IMX8MQ && !PPL
> >
> > PPL means (in my book) that we have a PPL, i.e. it is always true. It
>
> And in my proposal you're choosing between PPL, SPL, TPL, VPL.
>
> > is the same today, with SPL. We have CONFIG_SPL_BUILD which indicates
> > which build it is. If you are suggesting that SPL means that this is
> > the SPL build, then which thing tells us whether or not we have an SPL
> > build? I'm just a bit confused by this.
>
> And we wouldn't have CONFIG_SPL_BUILD because we would either be
> configuring for SPL=y or SPL=n, there's no confusion anymore.
>
> > But how can I make the TPL value of SYS_MALLOC_F_LEN the same as the
> > SPL one, with your scheme?
>
> If your question is "how do I set an arbitrary but consistent value in
> SPL and SPL" that's not enforced. But they also shouldn't be arbitrary
> and we should have sane defaults set in Kconfig, regardless of either
> proposal. While I'm trying to not get lost in the details today we have
> 80 matches on "git grep SPL_.*_LEN= configs/" and 2 for TPL and I would
> encourage someone to verify those are needed. My initial recollection is
> that most of these are from when we bumped SYS_MALLOC_F_LEN or so up to
> the commonly used default and had the few platforms that didn't use the
> new default previously switch to the old one.
>
> In other words, I don't think there's a problem here that isn't solved
> today, outside of either proposal.
>
> > So I'm still not understanding how you handle Kconfig dependencies
> > between phases with your scheme. Are you saying you don't and they are
> > not important?
>
> Basically. The majority of the cases of:
> config SPL_FOO
>    default y if FOO
>
> config TPL_FOO
>    default y if SPL_FOO
>
> Just go away because FOO is already default y or select/imply'd by
> TARGET_BAR or ARCH_BAZ.
>
> > Also, is there a single Kconfig tree for U-Boot, or are you saying you
> > want a different set of Kconfig files for each phase?
>
> Just the Kconfig files we have today. Likely with less overall lines
> since for example we could drop:
> config SPL_FS_EXT4
>         bool "Support EXT filesystems"
>         select SPL_CRC16 if EXT4_WRITE
>
> Since we already have fs/ext4/Kconfig.
>
> > > > > > Proposal
> > > > > >
> > > > > > 1. Adjust kconf to generate separate autoconf.h files for each phase.
> > > > > > These contain the values for each Kconfig option for that phase. For
> > > > > > example CONFIG_TEXT_BASE in autoconf_spl.h is SPL's text base.
> > > > > >
> > > > > > 2. Add a file to resolve the ambiguity in (c) above, listing the
> > > > > > Kconfig options which should not be enabled/valid in any xPL build.
> > > > > > There are around 200 of these.
> > > > > >
> > > > > > 3. Introduce CONFIG_PPL as a new prefix, meaning U-Boot proper (only),
> > > > > > useful in rare cases. This indicates that the option applies only to
> > > > > > U-Boot proper and is not defined in any xPL build. It is analogous to
> > > > > > CONFIG_TPL_xxx meaning 'enabled in TPL'. Only a dozen of these are
> > > > > > needed at present, basically to allow access to the value for another
> > > > > > phase, e.g. SPL wanting to find CONFIG_PPL_TEXT_BASE so that it knows
> > > > > > the address to which U-Boot should be loaded.
> > > > > >
> > > > > > 4. There is no change to the existing defconfig files, or 'make
> > > > > > menuconfig', which works just as today, including dependencies between
> > > > > > options across all phases.
> > > > > >
> > > > > > 5. (next) Expand the Kconfig language[2] to support declaring phases
> > > > > > (SPL, TPL, etc.) and remove the need for duplicating options (DM_MMC,
> > > > > > SPL_DM_MMC, TPL_DM_MMC, VPL_DM_MMC), so allowing an option to be
> > > > > > declared once for any/all phases. We can then drop the file in 2
> > > > > > above.
> > > > > >
> > > > > > With this, maintaining Kconfig options, Makefiles and adding a new
> > > > > > phase should be considerably easier.
> > > > >
> > > > > I think this will not make our life easier, it will make things harder.
> > > > >
> > > > > I think what we've reached now shows that Yamada-san was correct at the
> > > > > time in saying that we were going down the wrong path with how we
> > > > > handled SPL/TPL.
> > > >
> > > > You've mentioned this quite a few times over the years. Is there a
> > > > reference to what he suggested we should do? Or perhaps it is what you
> > > > have below.
> > >
> > > I don't recall what he proposed instead, just that when it became clear
> > > that I wanted to move from the "S:CONFIG_FOO.." syntax for how SPL was
> > > handled to how we're doing it today, he thought that was the wrong
> > > direction.
> >
> > Yes, IMO he was right about that.
> >
> > >
> > > > > My request instead is:
> > > > > - Largely drop SPL/TPL/VPL (so no DM_MMC and SPL_DM_MMC and so on, just
> > > > >   DM_MMC) as a prefix.
> > > > > - Likely need to introduce a PPL symbol as you suggest.
> > > > > - Make PPL/SPL/TPL/VPL be a choice statement when building a defconfig.
> > > >
> > > > Good idea.
> > > >
> > > > > - Split something like rockpro64-rk3399_defconfig in to
> > > > >   rockpro64-rk3399_ppl_defconfig
> > > > >   rockpro64-rk3399_spl_defconfig rockpro64-rk3399_tpl_defconfig
> > > > >   and add Makefile logic such that for X_defconfig as a build target but
> > > > >   not configs/X_defconfig not existing, we see if any of
> > > > >   configs/X_{ppl,spl,tpl,vpl}_defconfig exist and we run a builds in
> > > > >   subdirectories of our object directory, and then using binman combine
> > > > >   as needed.
> > > >
> > > > This means splitting the existing file into a separate one for each
> > > > phase. I believe that will be hard to manage.
> > >
> > > Do you mean initially, or long term? Initially, it should be a bit of
> > > shell scripting. The consolidation (ie most/all rk3399 having an
> > > identical _spl_defconfig) can't be automated. Long term I'm not sure it
> > > would be any different. Most of the maintenance is on resync'ing which
> > > is automated.
> >
> > Long term. How does 'make menuconfig' work in this case? Won't you
> > have to run it three times for SPL, TPL and PPL?
>
> Yes, you would run configure for what you're building. This is a good
> thing as it will no longer be so confusing to hunt down where SPL or TPL
> or VPL options for a specific thing reside.
>
> > > > >   - Maybe instead the Makefile logic above we would parse X_defconfig
> > > > >     and see if it's a different format of say PHASE:file to make it
> > > > >     easier to say share a single TPL config with all rk3399, have a few
> > > > >     common SPL configs and then just a board specific PPL.
> > > > >
> > > > > This solves (a) by removing them entirely. This solves (b) by removing
> > > > > the ambiguity entirely (it will be enabled or not). As a bonus for (b)
> > > > > we can switch everyone to IS_ENABLED(CONFIG_FOO) and match up with the
> > > > > Linux Kernel again. This solves (c) again by removing it entirely.
> > > >
> > > > The scheme I propose removes a-c also. I should have made that clear.
> > >
> > > Er, ok. That's not how it looked before, but I guess I'm just mistaken.
> >
> > Yes I think so...it was a major goal to remove this stuff. [1] [2]
>
> Thanks.
>
> > > > There is not a huge difference between your scheme and mine. My
> > > > question is, how do you handle (d)?
> > >
> > > Well, either (d) isn't important as for example MMC wasn't a good choice
> > > in your proposal as virtually everyone "select MMC" today or it's
> > > handled more easily as my example above in SYS_MALLOC_LEN.
> > >
> > > > The way I see it, both schemes remove the ambiguity. Mine retains a
> > > > single deconfig file and a single 'make menuconfig' for each board.
> > > > Yours feels more like building independent U-Boot images.
> > >
> > > It is explicitly building independent U-Boot images, yes. With a wrapper
> > > around "make all of the images for a given platform". So much of our
> > > confusing and messy code is because we aren't doing that. And since most
> > > modern SoCs can work as (mostly )generic SPL selects correct DTB for PPL
> > > we really could have fewer overall build configurations.
> >
> > I'd really like to see a generic aarch64 U-Boot for PPL, although it
> > would be quite large with all the drivers. Perhaps we could start by
> > having a generic Rockchip one, for example.
> >
> > Still I don't see this being strongly related to the discussion about
> > these two different schemes.
>
> Well, in your scheme how do we have say generic-aarch64_defconfig
> function on either chromebook_bob or am62x_beagleplay_a53 ? In mine,
> since everything is a separate build, generic-aarch64_defconfig has
> PPL=y, ARCH_K3=y and ROCKCHIP_RK3399=y. And then
> chromebook_bob_defconfig would say to use chromebook_bob_tpl_defconfig,
> generic-rk3399_spl_defconfig and generic-aarch64_defconfig. As a bonus
> instead of am62x_beagleplay_a53_defconfig and
> am62x_beagleplay_r5_defconfig we would have am62x_beagleplay_defconfig
> that would say to use the appropriate SPL/PPL for R5, and appropriate
> SPL/PPL for A53.
>
> But the one big huge caveat I want to make here is that "generic" images
> are useful in some use cases (I'm sure all of the regular F/OSS
> distributions would love a single actually common PPL if they can fit
> it) will strip things down. Whatever the IoT edge device closest to you
> now really won't want to ship with all the platforms enabled. Image size
> still matters.

OK thanks for the details. I think I have a reasonable idea of what
you are proposing, now. It would work, but is quite radical, IMO.
That's not necessarily a bad thing, but in my mind I see a sequencing
possibility.

A few points from my side:

1. I would love to see the defconfig files reduce in size, with more
and better defaults. One way to do this would be to enforce a maximum
length. I added a feature to qconfig to allow finding common options
among boards (the -i flag), but I'm not sure if many people use it.

2. Generic boards is something I have been pushing for years (in fact
it is why I originally introduced devicetree), but I'm not seeing a
lot of traction.

3. Iit seems that you want to remove all the 'if SPL' pieces and just
rely on the current PPL configuration. But how will that work? There
are tons of features which don't work in SPL, or are not relevant, or
have special 'small' versions. That is a *lot* of Kconfig refactoring
just to get something working, isn't it? With my scheme there is no
Kconfig change needed initially - it can be done later as needed /
desirable.

4. My scheme splits the config into separate files. Yours makes the
split earlier, at the Kconfig level. So it seems that we could go with
my scheme to get us to a split config, then, after that, decide
whether to move that split earlier to Kconfig itself. The choices
would then be to use your scheme (Kconfig refactoring, splitting
defconfigs and some rework), or to do my scheme (which would require
enhancing the Kconfig language a bit just for U-Boot and some optional
rework over time). Both schemes would need a small amount of
build-logic changes, but I'm not sure yet what that would look like.

Does that sound right?

Regards,
Simon
