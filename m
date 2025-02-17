Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56C7C021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 19:34:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3721E80BAD;
	Mon, 17 Feb 2025 20:34:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CCGroqsr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 290C180F0B; Mon, 17 Feb 2025 20:34:18 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB297807F1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 20:34:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5dca468c5e4so8617001a12.1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 11:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739820854; x=1740425654; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QLLZvuRXSOmfAjIOilo4WuWUcJ49wPP+/xpraUoalV8=;
 b=CCGroqsrYuOqs/NAn4F4Q4HSh8c1pmHa2Lhtz4X3mnCdz0erEJtbETeuc9VoUph6Tm
 315amTRxHfZgielw3fFCipv35OqADVK8j+QEFnKMZEzSu84E68Dssybgx0W+r+QVUFMa
 0H3B3D8w+ueeZPvijRiv0djO9NdD8xMXviQgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820854; x=1740425654;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QLLZvuRXSOmfAjIOilo4WuWUcJ49wPP+/xpraUoalV8=;
 b=bwONIRA9aBoj30kI4JB8mjB68alMNs/+tJdQoS7fk9ApQYzVcqgZX0IpFF220Ck3C8
 V+uYEZ+79nXTGKLF2sYtdD0FxVUmvXx+EY+afQcBgzfmiLyrclb0Q9b0uoYGSSCIbLIY
 U5C6+tX24ta/1ka49GYyPi3S79QTGT8PmfIn7So5KzEP3pKumNk0jXAqWSenGNzcL2DX
 lmoU8rc9zDfSD+xO+H2XDoovjw6azDb/GXuVOPKMNwCv0Fc4pt+SL+MafOb3/+SGYi10
 zf4PPIQ/7pub1cK5Ycii/DJYzdR9p7GFPGNp1tT5X90N6I+60+uLDKyGZxBSNC3P/PXP
 Q55g==
X-Gm-Message-State: AOJu0YzgaMTs6SvlFBselQu/2/+7vJK/k5LQG1TKroUqXYgNdXluMFnD
 +snS6SxyLx5OCk33tp1bX6vEMJVTcGfkL7zJ+05IMJjGqgbJpmg7EgiZqeRVn/M2rhTjr0QNcCK
 qpmwOZfms+pzHfBUDq0DujAbhwOfLfOkKghKeAQhbGehA1gU=
X-Gm-Gg: ASbGncuAWogeGHqwmYQpzq6aw2+JaUsq7K3SXsjl+4znuwtPGJHh4LEfl1nTnHs/Phj
 PaTQi5pcYAYPsq8q/lxSG67NnUvcs9ROFQji3AedYx66RtjzBCES1bIJoNTFYHfnJk+z4AfzFag
 ==
X-Google-Smtp-Source: AGHT+IHtuXss2EI2hK+oQMBsZ7nGYDhKR01g4h/uSUIAPf/xHcqYPvQpyqnNcWzP1mXt4XPMfcEFNtJxTNnwIQk525g=
X-Received: by 2002:a17:906:2454:b0:abb:9c8a:fbcd with SMTP id
 a640c23a62f3a-abb9c8afde3mr485707466b.53.1739820853911; Mon, 17 Feb 2025
 11:34:13 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=ieT2oaHfgLf3_nC+xXA9g@mail.gmail.com>
 <20250211212222.GH1233568@bill-the-cat>
 <20250217185035.GT1233568@bill-the-cat>
 <CAFLszTjeiX+40we55cH+0nmzpLvDZ5j=JQU21hZ1VQ85Arb0hQ@mail.gmail.com>
 <20250217192156.GV1233568@bill-the-cat>
In-Reply-To: <20250217192156.GV1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 17 Feb 2025 12:34:01 -0700
X-Gm-Features: AWEUYZlN_TyESWRsf1qiR9AOfENU08PGrbxcSliClHlEqJgAl473_irbWBl_KLg
Message-ID: <CAFLszThTF+VQ2LduU6Ji_a-W8hYt+i38j-C7ccNZwJb+XkfwRQ@mail.gmail.com>
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

On Mon, 17 Feb 2025 at 12:22, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Feb 17, 2025 at 12:11:12PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 17 Feb 2025 at 11:50, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Feb 11, 2025 at 03:22:22PM -0600, Tom Rini wrote:
> > > > On Tue, Feb 11, 2025 at 08:03:20AM -0700, Simon Glass wrote:
> > > > > Hi,
> > > > >
> > > > > I just wanted to send a note to (re-)introduce my ideas[1] for the
> > > > > next iteration of xPL.
> > > > >
> > > > > A recent series introduced 'xPL' as the name for the various
> > > > > pre-U-Boot phases, so now CONFIG_XPL_BUILD means that this is any xPL
> > > > > phase and CONFIG_SPL means this really is the SPL phase, not TPL. We
> > > > > still use filenames and function naming which uses 'spl', but could
> > > > > potentially adjust that.
> > > > >
> > > > > The major remaining problem IMO is that it is quite tricky and
> > > > > expensive (in terms of time) to add a new phase. We also have some
> > > > > medium-sized problems:
> > > > >
> > > > > a. The $(PHASE_), $(SPL_) rules in the Makefile are visually ugly and
> > > > > can be confusing, particularly when combined with ifdef and ifneq
> > > > >
> > > > > b. We have both CONFIG_IS_ENABLED() and IS_ENABLED() and they mean
> > > > > different things. For any given option, some code uses one and some
> > > > > the other, depending on what problems people have met along the way.
> > > > >
> > > > > c. An option like CONFIG_FOO is ambiguous, in that it could mean that
> > > > > the option is enabled in one or more xPL phases, or just in U-Boot
> > > > > proper. The only way to know is to look for $(PHASE_) etc. in the
> > > > > Makefiles and CONFIG_IS_ENABLED() in the code. This is very confusing
> > > > > and has not scaled well.
> > > > >
> > > > > d. We need to retain an important feature: options from different
> > > > > phases can depend on each other. As an example, we might want to
> > > > > enable MMC in SPL by default, if MMC is enabled in U-Boot proper. We
> > > > > may also want to share values between phases, such as TEXT_BASE. We
> > > > > can do this easily today, just by adding Kconfig rules.
> > > >
> > > > I agree with a through c and for d there are likely some cases even if
> > > > I'm not sure TEXT_BASE is a good example. But I'm not sure it's as
> > > > important as the other ones.
> > > >
> > > > > Proposal
> > > > >
> > > > > 1. Adjust kconf to generate separate autoconf.h files for each phase.
> > > > > These contain the values for each Kconfig option for that phase. For
> > > > > example CONFIG_TEXT_BASE in autoconf_spl.h is SPL's text base.
> > > > >
> > > > > 2. Add a file to resolve the ambiguity in (c) above, listing the
> > > > > Kconfig options which should not be enabled/valid in any xPL build.
> > > > > There are around 200 of these.
> > > > >
> > > > > 3. Introduce CONFIG_PPL as a new prefix, meaning U-Boot proper (only),
> > > > > useful in rare cases. This indicates that the option applies only to
> > > > > U-Boot proper and is not defined in any xPL build. It is analogous to
> > > > > CONFIG_TPL_xxx meaning 'enabled in TPL'. Only a dozen of these are
> > > > > needed at present, basically to allow access to the value for another
> > > > > phase, e.g. SPL wanting to find CONFIG_PPL_TEXT_BASE so that it knows
> > > > > the address to which U-Boot should be loaded.
> > > > >
> > > > > 4. There is no change to the existing defconfig files, or 'make
> > > > > menuconfig', which works just as today, including dependencies between
> > > > > options across all phases.
> > > > >
> > > > > 5. (next) Expand the Kconfig language[2] to support declaring phases
> > > > > (SPL, TPL, etc.) and remove the need for duplicating options (DM_MMC,
> > > > > SPL_DM_MMC, TPL_DM_MMC, VPL_DM_MMC), so allowing an option to be
> > > > > declared once for any/all phases. We can then drop the file in 2
> > > > > above.
> > > > >
> > > > > With this, maintaining Kconfig options, Makefiles and adding a new
> > > > > phase should be considerably easier.
> > > >
> > > > I think this will not make our life easier, it will make things harder.
> > > >
> > > > I think what we've reached now shows that Yamada-san was correct at the
> > > > time in saying that we were going down the wrong path with how we
> > > > handled SPL/TPL.
> > > >
> > > > My request instead is:
> > > > - Largely drop SPL/TPL/VPL (so no DM_MMC and SPL_DM_MMC and so on, just
> > > >   DM_MMC) as a prefix.
> > > > - Likely need to introduce a PPL symbol as you suggest.
> > > > - Make PPL/SPL/TPL/VPL be a choice statement when building a defconfig.
> > > > - Split something like rockpro64-rk3399_defconfig in to
> > > >   rockpro64-rk3399_ppl_defconfig
> > > >   rockpro64-rk3399_spl_defconfig rockpro64-rk3399_tpl_defconfig
> > > >   and add Makefile logic such that for X_defconfig as a build target but
> > > >   not configs/X_defconfig not existing, we see if any of
> > > >   configs/X_{ppl,spl,tpl,vpl}_defconfig exist and we run a builds in
> > > >   subdirectories of our object directory, and then using binman combine
> > > >   as needed.
> > > >   - Maybe instead the Makefile logic above we would parse X_defconfig
> > > >     and see if it's a different format of say PHASE:file to make it
> > > >     easier to say share a single TPL config with all rk3399, have a few
> > > >     common SPL configs and then just a board specific PPL.
> > > >
> > > > This solves (a) by removing them entirely. This solves (b) by removing
> > > > the ambiguity entirely (it will be enabled or not). As a bonus for (b)
> > > > we can switch everyone to IS_ENABLED(CONFIG_FOO) and match up with the
> > > > Linux Kernel again. This solves (c) again by removing it entirely.
> > >
> > > Lets come back up here, to my proposal, since parts of it seem to have
> > > not been clear enough. While what I'm proposing should work for any
> > > platform and xPL -> xPL -> ... -> PPL, for this example let us assume
> > > rockpro64-rk3399 supports the flow of TPL -> SPL -> PPL. Also, to
> > > compare with today, it will be helpful to run "make
> > > O=/tmp/rockpro64-rk3399_current rockpro64-rk3399_config" and have the
> > > resulting .config file available.
> > >
> > > There shall be configs/rockpro64-rk3399_tpl_defconfig. This will contain
> > > lines such as:
> > > CONFIG_ARM=y
> > > CONFIG_ARCH_ROCKCHIP=y
> > > CONFIG_ROCKCHIP_RK3399=y
> > > CONFIG_TPL=y
> > >
> > > When you run "make O=/tmp/rockpro64-rk3399_tpl rockpro64-rk3399_tpl_defconfig"
> > > the resulting .config file will contain lines such as:
> > > # CONFIG_ROCKCHIP_EXTERNAL_TPL is not set
> > > as this only makes sense in the context of building something that will
> > > be TPL.
> > >
> > > A more complex example is that it will also contain:
> > > CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
> > >
> > > Because looking at arch/arm/mach-rockchip/Makefile a bunch of that will
> > > be able to be simplified (and spl_common.c should be renamed to
> > > xpl_common.c) to:
> > > obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) += spl.o spl-boot-order.o xpl_common.o
> > > obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) += tpl.o xpl_common.o
> > >
> > > The .config file here will also contain:
> > > CONFIG_DM_SERIAL=y
> > >
> > > What it will not contain is:
> > > CONFIG_TPL_DM_SERIAL=y
> > >
> > > This is because there is no 'config TPL_DM_SERIAL' option in
> > > drivers/serial/Kconfig anymore.
> > >
> > > When you next run "make O=/tmp/rockpro64-rk3399_tpl all" the results in
> > > /tmp/rockpro64-rk3399_tpl would be similar to the results as under
> > > "/tmp/rockpro64-rk3399/tpl/" when building today.
> > >
> > > The contents of configs/rockpro64-rk3399_spl_defconfig would be similar
> > > to the tpl one, except with SPL-only-ever-valid options such as
> > > CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y but otherwise have CONFIG_DM_SERIAL=y
> > > and no CONFIG_SPL_DM_SERIAL=y, and when building the "all" target, you
> > > would only get similar results to what is under the spl/ directory
> > > today.
> > >
> > > Next we have configs/rockpro64-rk3399_ppl_defconfig.  When you run "make
> > > O=/tmp/rockpro64-rk3399_ppl rockpro64-rk3399_ppl_defconfig" the
> > > important difference is what you do not have. You do not have:
> > > CONFIG_SPL=y
> > > CONFIG_TPL=y
> > >
> > > Because we are not building SPL nor TPL. We're just making full U-Boot
> > > itself. This is where in more full examples and with additional
> > > restructure a "generic-arm64_ppl_defconfig" makes sense and be used
> > > instead.
> > >
> > > This brings up what to do with "ockpro64-rk3399_defconfig". And I'm a
> > > little unsure which of the things I mentioned above is best. It's
> > > either:
> > > a) Does not exist, top-level Makefile says roughly:
> > > %_defconfig: %_tpl_defconfig %_spl_defconfig %_ppl_defconfig
> > >   make O=$(objdir)/tpl %_tpl_defconfig all
> > >   make O=$(objdir)/spl %_spl_defconfig all
> > >   make O=$(objdir)/ppl %_ppl_defconfig all
> > >
> > > But this might be too rigid.
> > > b) It contains:
> > > PHASE:VPL:rockpro64-rk3399_vpl_defconfig
> > > PHASE:TPL:rockpro64-rk3399_tpl_defconfig
> > > PHASE:SPL:rockpro64-rk3399_spl_defconfig
> > > PHASE:PPL:rockpro64-rk3399_ppl_defconfig
> > > And the top-level Makefile looks like:
> > > %_defconfig:
> > >   grep -q ^PHASE $@ || fatal "Invalid defconfig file, please see..."
> > >   foreach line in $@
> > >     make O=$(objdir)/$PHASE $CONFIGFILE all
> > >
> > > It could also be some other suggestion.
> >
> > Thanks for writing that up. It is somewhat clearer.
> >
> > What happens to the Makefiles? Do they still have $(PHASE_) in them?
>
> No. Because CONFIG_SPL_FIT would never exist, $(CONFIG_$(PHASE_)FIT)
> would be meaningless. Only rockpro64-rk3399_spl_defconfig would say
> CONFIG_FIT=y (or more likely, only the resulting .config would say
> CONFIG_FIT=y just like how configs/rockpro64-rk3399_defconfig doesn't
> say CONFIG_FIT=y nor CONFIG_SPL_FIT=y).

But just above you said:

> I believe this proposal will lead to the code and Makefiles being less
> clear than they are today. The line:
> drivers/Makefile:obj-$(CONFIG_$(PHASE_)BLK) += block/
> will become:
> drivers/Makefile:obj-$(CONFIG_BLK) += block/
> without being clear that it could reference either full U-Boot (PPL) or
> some xPL phase. While the same Makefile will continue to have (comments
> my own):
> obj-y += mtd/ # Subdirectory Makefiles control build contents
> obj-$(CONFIG_MULTIPLEXER) += mux/ # Only valid for PPL.
>
> And so the situation for humans will be worse off than today because
> while $(PHASE_) and $(XPL_) are confusing at times, they make it clear
> what can and cannot be enabled in PPL vs xPL.
>
> Doing "something" is not better than doing nothing in this case.

So why is OK for your proposal to drop the $(PHASE_) stuff, but not mine?

Regards,
Simon
