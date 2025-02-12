Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B86C02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 17:42:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 294F480C83;
	Wed, 12 Feb 2025 18:42:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZzkOrXSK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9F33807C0; Wed, 12 Feb 2025 18:42:01 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CDE1809D0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 18:41:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5de849a0b6cso6633410a12.2
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 09:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739382117; x=1739986917; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4+83pzwrAFjhnCJ7U/9uB42iO+ud/hPVj6Pmnz0zzlM=;
 b=ZzkOrXSK6sAWBuzRb02Qt2CbHIL0iBIYpg1Oz433L1vNwdmB1Nvu/92qoLVKH4wodD
 YGfJOpv/9Vka8GUsvBNL/RbB/2GwhVDGEwwSKJOXCOjPQNoHBpbQ96UpRskcc+ITcKDx
 S5tl7cQN/Dvtxxi6Lx9rdyZgRKwWorbnpqkzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739382117; x=1739986917;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4+83pzwrAFjhnCJ7U/9uB42iO+ud/hPVj6Pmnz0zzlM=;
 b=X2Carx4YAHCTm8EqRoRojYpKOD6tjAW7XQGupILzCpriNvUBuMrRNqB420wyIVShXE
 qO0yxwiMVyKqY/MY0OcNuf/+ni4tj+vMnEtAB11jtBOQhyY4eia3/TsQzNGpiY0hQZxi
 NFIDxSomVb8m+C4Doz8ZYKaD8bHMDXCwf9aE59kLCDvf7hDDRhM2Pjpb6ZUMxYmPvPMu
 Lp5ORqJH/SQA2oAWjehfyw2ECyeYYqY3nb5o3iQdq2rrhrd5wma2Yi+6ktFXlr/ROKqv
 JEuLW/3zXsEzyg2rBfuCjQZ8J+h2BFQf/9ZhTEpdH7u/astwA1IREiTOfi1CzbQIox+t
 uatw==
X-Gm-Message-State: AOJu0Yx/jyykfXQeTL8Ky1TCYr8QMEQHIgd1S30eWGvY/aiojsyA/UeW
 yXyBcordM49FZ4WD/uVAg+z/Z4H8gpSVpsTxu4fYG61Rbe2FFyg35KRCgHmFrwLFgfirvdhr21/
 AidXUX4J4o6vXBMk/ajUM6uLO6G/t1Nz05EK+/zJ8AW8b80bb7A==
X-Gm-Gg: ASbGncumhg4xd1XJHySrjAz4bhc8RZB+Do/eI4VoyqoWHA7VkMLDP3JCV7obFLU7Ere
 lW3UPr4gLQ70QPeqh79x/wExHcA5USmLZ+g7DO/ob+QQ+AoN2iR2BByRZdw4ufdc0TH5xgnl4OZ
 omdeOwLDmkFLfWMTsomJ67BXfxSvUtug==
X-Google-Smtp-Source: AGHT+IFOaimtNE86/kcifI+DAaFyVgFZRZ7ELPIrQ2OAgNs8bzVsU0rZHT999Q4/1KSDO+BtUYADa72AKI8kTq/5Itc=
X-Received: by 2002:a05:6402:2115:b0:5db:f26d:fff1 with SMTP id
 4fb4d7f45d1cf-5dec9fadf86mr12021a12.21.1739382117410; Wed, 12 Feb 2025
 09:41:57 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=ieT2oaHfgLf3_nC+xXA9g@mail.gmail.com>
 <20250211212222.GH1233568@bill-the-cat>
 <CAFLszTjaGsXZH6_CAbBhwJ7MAPdzdOUYn=CVBewQKCMX2CS1EQ@mail.gmail.com>
 <20250212164000.GO1233568@bill-the-cat>
In-Reply-To: <20250212164000.GO1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 12 Feb 2025 10:41:45 -0700
X-Gm-Features: AWEUYZmMo384JNxnD4PrDArbApaSdS8byjG7UKds2jK9SQgN3--Ff4R0V-Ywl1k
Message-ID: <CAFLszTghQcXGUWS-5GRtWydMzLyYKgKKi7Sd4_NikVrDGHkuzA@mail.gmail.com>
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

On Wed, 12 Feb 2025 at 09:40, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Feb 11, 2025 at 03:54:21PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 11 Feb 2025 at 14:22, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Feb 11, 2025 at 08:03:20AM -0700, Simon Glass wrote:
> > > > Hi,
> > > >
> > > > I just wanted to send a note to (re-)introduce my ideas[1] for the
> > > > next iteration of xPL.
> > > >
> > > > A recent series introduced 'xPL' as the name for the various
> > > > pre-U-Boot phases, so now CONFIG_XPL_BUILD means that this is any xPL
> > > > phase and CONFIG_SPL means this really is the SPL phase, not TPL. We
> > > > still use filenames and function naming which uses 'spl', but could
> > > > potentially adjust that.
> > > >
> > > > The major remaining problem IMO is that it is quite tricky and
> > > > expensive (in terms of time) to add a new phase. We also have some
> > > > medium-sized problems:
> > > >
> > > > a. The $(PHASE_), $(SPL_) rules in the Makefile are visually ugly and
> > > > can be confusing, particularly when combined with ifdef and ifneq
> > > >
> > > > b. We have both CONFIG_IS_ENABLED() and IS_ENABLED() and they mean
> > > > different things. For any given option, some code uses one and some
> > > > the other, depending on what problems people have met along the way.
> > > >
> > > > c. An option like CONFIG_FOO is ambiguous, in that it could mean that
> > > > the option is enabled in one or more xPL phases, or just in U-Boot
> > > > proper. The only way to know is to look for $(PHASE_) etc. in the
> > > > Makefiles and CONFIG_IS_ENABLED() in the code. This is very confusing
> > > > and has not scaled well.
> > > >
> > > > d. We need to retain an important feature: options from different
> > > > phases can depend on each other. As an example, we might want to
> > > > enable MMC in SPL by default, if MMC is enabled in U-Boot proper. We
> > > > may also want to share values between phases, such as TEXT_BASE. We
> > > > can do this easily today, just by adding Kconfig rules.
> > >
> > > I agree with a through c and for d there are likely some cases even if
> > > I'm not sure TEXT_BASE is a good example. But I'm not sure it's as
> > > important as the other ones.
> >
> > OK. No, TEXT_BASE is not a great example in my book either. But it is
> > true that SPL needs to know U-Boot's text base.
> >
> > Here's another:
> >
> > config SPL_SYS_MALLOC_F_LEN
> >    default SYS_MALLOC_F_LEN
> >
> > config TPL_SYS_MALLOC_F
> >    default y if SPL_SYS_MALLOC_F
> >
> > config TPL_SYS_MALLOC_F_LEN
> >    depends on TPL_SYS_MALLOC_F
> >    default SPL_SYS_MALLOC_F_LEN
>
> Alternatively:
> config SYS_MALLOC_LEN
>    ... current default X if Y
>    default 0x2800 if RCAR_GEN3 && !PPL
>    default 0x2000 if IMX8MQ && !PPL

PPL means (in my book) that we have a PPL, i.e. it is always true. It
is the same today, with SPL. We have CONFIG_SPL_BUILD which indicates
which build it is. If you are suggesting that SPL means that this is
the SPL build, then which thing tells us whether or not we have an SPL
build? I'm just a bit confused by this.

But how can I make the TPL value of SYS_MALLOC_F_LEN the same as the
SPL one, with your scheme?

So I'm still not understanding how you handle Kconfig dependencies
between phases with your scheme. Are you saying you don't and they are
not important?

Also, is there a single Kconfig tree for U-Boot, or are you saying you
want a different set of Kconfig files for each phase?

>
> > > > Proposal
> > > >
> > > > 1. Adjust kconf to generate separate autoconf.h files for each phase.
> > > > These contain the values for each Kconfig option for that phase. For
> > > > example CONFIG_TEXT_BASE in autoconf_spl.h is SPL's text base.
> > > >
> > > > 2. Add a file to resolve the ambiguity in (c) above, listing the
> > > > Kconfig options which should not be enabled/valid in any xPL build.
> > > > There are around 200 of these.
> > > >
> > > > 3. Introduce CONFIG_PPL as a new prefix, meaning U-Boot proper (only),
> > > > useful in rare cases. This indicates that the option applies only to
> > > > U-Boot proper and is not defined in any xPL build. It is analogous to
> > > > CONFIG_TPL_xxx meaning 'enabled in TPL'. Only a dozen of these are
> > > > needed at present, basically to allow access to the value for another
> > > > phase, e.g. SPL wanting to find CONFIG_PPL_TEXT_BASE so that it knows
> > > > the address to which U-Boot should be loaded.
> > > >
> > > > 4. There is no change to the existing defconfig files, or 'make
> > > > menuconfig', which works just as today, including dependencies between
> > > > options across all phases.
> > > >
> > > > 5. (next) Expand the Kconfig language[2] to support declaring phases
> > > > (SPL, TPL, etc.) and remove the need for duplicating options (DM_MMC,
> > > > SPL_DM_MMC, TPL_DM_MMC, VPL_DM_MMC), so allowing an option to be
> > > > declared once for any/all phases. We can then drop the file in 2
> > > > above.
> > > >
> > > > With this, maintaining Kconfig options, Makefiles and adding a new
> > > > phase should be considerably easier.
> > >
> > > I think this will not make our life easier, it will make things harder.
> > >
> > > I think what we've reached now shows that Yamada-san was correct at the
> > > time in saying that we were going down the wrong path with how we
> > > handled SPL/TPL.
> >
> > You've mentioned this quite a few times over the years. Is there a
> > reference to what he suggested we should do? Or perhaps it is what you
> > have below.
>
> I don't recall what he proposed instead, just that when it became clear
> that I wanted to move from the "S:CONFIG_FOO.." syntax for how SPL was
> handled to how we're doing it today, he thought that was the wrong
> direction.

Yes, IMO he was right about that.

>
> > > My request instead is:
> > > - Largely drop SPL/TPL/VPL (so no DM_MMC and SPL_DM_MMC and so on, just
> > >   DM_MMC) as a prefix.
> > > - Likely need to introduce a PPL symbol as you suggest.
> > > - Make PPL/SPL/TPL/VPL be a choice statement when building a defconfig.
> >
> > Good idea.
> >
> > > - Split something like rockpro64-rk3399_defconfig in to
> > >   rockpro64-rk3399_ppl_defconfig
> > >   rockpro64-rk3399_spl_defconfig rockpro64-rk3399_tpl_defconfig
> > >   and add Makefile logic such that for X_defconfig as a build target but
> > >   not configs/X_defconfig not existing, we see if any of
> > >   configs/X_{ppl,spl,tpl,vpl}_defconfig exist and we run a builds in
> > >   subdirectories of our object directory, and then using binman combine
> > >   as needed.
> >
> > This means splitting the existing file into a separate one for each
> > phase. I believe that will be hard to manage.
>
> Do you mean initially, or long term? Initially, it should be a bit of
> shell scripting. The consolidation (ie most/all rk3399 having an
> identical _spl_defconfig) can't be automated. Long term I'm not sure it
> would be any different. Most of the maintenance is on resync'ing which
> is automated.

Long term. How does 'make menuconfig' work in this case? Won't you
have to run it three times for SPL, TPL and PPL?

>
> > >   - Maybe instead the Makefile logic above we would parse X_defconfig
> > >     and see if it's a different format of say PHASE:file to make it
> > >     easier to say share a single TPL config with all rk3399, have a few
> > >     common SPL configs and then just a board specific PPL.
> > >
> > > This solves (a) by removing them entirely. This solves (b) by removing
> > > the ambiguity entirely (it will be enabled or not). As a bonus for (b)
> > > we can switch everyone to IS_ENABLED(CONFIG_FOO) and match up with the
> > > Linux Kernel again. This solves (c) again by removing it entirely.
> >
> > The scheme I propose removes a-c also. I should have made that clear.
>
> Er, ok. That's not how it looked before, but I guess I'm just mistaken.

Yes I think so...it was a major goal to remove this stuff. [1] [2]

>
> > There is not a huge difference between your scheme and mine. My
> > question is, how do you handle (d)?
>
> Well, either (d) isn't important as for example MMC wasn't a good choice
> in your proposal as virtually everyone "select MMC" today or it's
> handled more easily as my example above in SYS_MALLOC_LEN.
>
> > The way I see it, both schemes remove the ambiguity. Mine retains a
> > single deconfig file and a single 'make menuconfig' for each board.
> > Yours feels more like building independent U-Boot images.
>
> It is explicitly building independent U-Boot images, yes. With a wrapper
> around "make all of the images for a given platform". So much of our
> confusing and messy code is because we aren't doing that. And since most
> modern SoCs can work as (mostly )generic SPL selects correct DTB for PPL
> we really could have fewer overall build configurations.

I'd really like to see a generic aarch64 U-Boot for PPL, although it
would be quite large with all the drivers. Perhaps we could start by
having a generic Rockchip one, for example.

Still I don't see this being strongly related to the discussion about
these two different schemes.

Regards,
Simon

>
> --
> Tom

[1] https://patchwork.ozlabs.org/project/uboot/patch/20230212231638.1134219-96-sjg@chromium.org/
[2] https://patchwork.ozlabs.org/project/uboot/patch/20230212231638.1134219-89-sjg@chromium.org/
