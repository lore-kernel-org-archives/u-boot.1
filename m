Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F83C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 22:54:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1D0880BAA;
	Tue, 11 Feb 2025 23:54:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DfmFBron";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A78F680079; Tue, 11 Feb 2025 23:54:36 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 894B0807C0
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 23:54:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ab7ca64da5dso48544066b.0
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 14:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739314474; x=1739919274; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eNm5vPmkNymvxCGJ0Rb7Zhr9VCPZ3HYREDEpYmgmJ88=;
 b=DfmFBronxUIYCaJqLCqwMHR8yXuSu5AB6eUerQm+l4b5LTw+Ry/3QiUpm8kkEu1t8G
 iy6sLaAWUxbtWnp0IbBpBo0FbjZJwmedCbyH6v798Yn3RiQU38jyMAiLflgyKees8exB
 r6tCaHLAcwc6EWGAUOdNu+0Y4d+lXYLHTAK2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739314474; x=1739919274;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eNm5vPmkNymvxCGJ0Rb7Zhr9VCPZ3HYREDEpYmgmJ88=;
 b=spaCTT4twUxDBnBBYRJacr1zkYIVEWWTFIipLtULZViDXQZaA+fDOvjGJqyzQcG3RN
 RAKXthnUacOFvQjFvPZDX2sAf1awOz/mYdIUCzXhyUYWd9tvNWjcL1ZHiFqIit6VKaNE
 LbneLvzYB9hILcbBe/bKunUY4F+kzg61hA1MeESbW76mIfLyAn5FSvEGZHtKro+hTsOz
 fzMjO1GQHSihM3/EReFX2MGizyL2GJ+dfWTVRy/yMMKjfkRTD2Y/ct9WLOtQwrBOjqzd
 s3Fijp/4L3Gat2QQgnmQ6IXDrthKLi1tXJKB09gdpbPrXsklLutS9sMTza5/V2LfvewU
 JU0A==
X-Gm-Message-State: AOJu0YywtE/2pkzpMy2I8ZXXj19cEd3Loke22kKllsbmPVJkh8Jrq288
 nyE9wVm4gfuCDlC0xXjEYHSQYbCNp55WYd1sLYe5+po/4k3LFf/aW6B6nWA3yzTtOen5h9W0b+q
 JoN4JqYL7Isy7uaueG2kFIFBiqKl0sILS2b/kLiLQQsdAcOYZyA==
X-Gm-Gg: ASbGncvY14wvywf0NZIw6/r1NEHiTEO7sz3ZeB8r2+7UIErWNlg9XgigXDB1tKGgjCA
 pL7Kk0vBd1FTcUlCsLhGe/xxlpiFuxQPx/7w4jyUnim1P8d0E0rslnjagYQrp2IJ4IpGnacGKtd
 essLv2IXKhwsiZ3+mEqGyKepZyf1Rh
X-Google-Smtp-Source: AGHT+IHRIARQjv2zWbmiL1pX3N1GSEkbiT3zaHNWgZfa3L6KnVL9WwT9Qo3Glvm2nbeFzkdUzxB3sKLYJKRvyDM4fas=
X-Received: by 2002:a17:907:2cc5:b0:ab7:d1d0:1a84 with SMTP id
 a640c23a62f3a-ab7f2e8a301mr76722866b.4.1739314473813; Tue, 11 Feb 2025
 14:54:33 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=ieT2oaHfgLf3_nC+xXA9g@mail.gmail.com>
 <20250211212222.GH1233568@bill-the-cat>
In-Reply-To: <20250211212222.GH1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Feb 2025 15:54:21 -0700
X-Gm-Features: AWEUYZnyrSr8Xc4XoWATgqQ_z7fqJu8U3BvAbDL2Y-HKdHGT2QjxKwd_-u52nNY
Message-ID: <CAFLszTjaGsXZH6_CAbBhwJ7MAPdzdOUYn=CVBewQKCMX2CS1EQ@mail.gmail.com>
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

On Tue, 11 Feb 2025 at 14:22, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Feb 11, 2025 at 08:03:20AM -0700, Simon Glass wrote:
> > Hi,
> >
> > I just wanted to send a note to (re-)introduce my ideas[1] for the
> > next iteration of xPL.
> >
> > A recent series introduced 'xPL' as the name for the various
> > pre-U-Boot phases, so now CONFIG_XPL_BUILD means that this is any xPL
> > phase and CONFIG_SPL means this really is the SPL phase, not TPL. We
> > still use filenames and function naming which uses 'spl', but could
> > potentially adjust that.
> >
> > The major remaining problem IMO is that it is quite tricky and
> > expensive (in terms of time) to add a new phase. We also have some
> > medium-sized problems:
> >
> > a. The $(PHASE_), $(SPL_) rules in the Makefile are visually ugly and
> > can be confusing, particularly when combined with ifdef and ifneq
> >
> > b. We have both CONFIG_IS_ENABLED() and IS_ENABLED() and they mean
> > different things. For any given option, some code uses one and some
> > the other, depending on what problems people have met along the way.
> >
> > c. An option like CONFIG_FOO is ambiguous, in that it could mean that
> > the option is enabled in one or more xPL phases, or just in U-Boot
> > proper. The only way to know is to look for $(PHASE_) etc. in the
> > Makefiles and CONFIG_IS_ENABLED() in the code. This is very confusing
> > and has not scaled well.
> >
> > d. We need to retain an important feature: options from different
> > phases can depend on each other. As an example, we might want to
> > enable MMC in SPL by default, if MMC is enabled in U-Boot proper. We
> > may also want to share values between phases, such as TEXT_BASE. We
> > can do this easily today, just by adding Kconfig rules.
>
> I agree with a through c and for d there are likely some cases even if
> I'm not sure TEXT_BASE is a good example. But I'm not sure it's as
> important as the other ones.

OK. No, TEXT_BASE is not a great example in my book either. But it is
true that SPL needs to know U-Boot's text base.

Here's another:

config SPL_SYS_MALLOC_F_LEN
   default SYS_MALLOC_F_LEN

config TPL_SYS_MALLOC_F
   default y if SPL_SYS_MALLOC_F

config TPL_SYS_MALLOC_F_LEN
   depends on TPL_SYS_MALLOC_F
   default SPL_SYS_MALLOC_F_LEN

>
> > Proposal
> >
> > 1. Adjust kconf to generate separate autoconf.h files for each phase.
> > These contain the values for each Kconfig option for that phase. For
> > example CONFIG_TEXT_BASE in autoconf_spl.h is SPL's text base.
> >
> > 2. Add a file to resolve the ambiguity in (c) above, listing the
> > Kconfig options which should not be enabled/valid in any xPL build.
> > There are around 200 of these.
> >
> > 3. Introduce CONFIG_PPL as a new prefix, meaning U-Boot proper (only),
> > useful in rare cases. This indicates that the option applies only to
> > U-Boot proper and is not defined in any xPL build. It is analogous to
> > CONFIG_TPL_xxx meaning 'enabled in TPL'. Only a dozen of these are
> > needed at present, basically to allow access to the value for another
> > phase, e.g. SPL wanting to find CONFIG_PPL_TEXT_BASE so that it knows
> > the address to which U-Boot should be loaded.
> >
> > 4. There is no change to the existing defconfig files, or 'make
> > menuconfig', which works just as today, including dependencies between
> > options across all phases.
> >
> > 5. (next) Expand the Kconfig language[2] to support declaring phases
> > (SPL, TPL, etc.) and remove the need for duplicating options (DM_MMC,
> > SPL_DM_MMC, TPL_DM_MMC, VPL_DM_MMC), so allowing an option to be
> > declared once for any/all phases. We can then drop the file in 2
> > above.
> >
> > With this, maintaining Kconfig options, Makefiles and adding a new
> > phase should be considerably easier.
>
> I think this will not make our life easier, it will make things harder.
>
> I think what we've reached now shows that Yamada-san was correct at the
> time in saying that we were going down the wrong path with how we
> handled SPL/TPL.

You've mentioned this quite a few times over the years. Is there a
reference to what he suggested we should do? Or perhaps it is what you
have below.

>
> My request instead is:
> - Largely drop SPL/TPL/VPL (so no DM_MMC and SPL_DM_MMC and so on, just
>   DM_MMC) as a prefix.
> - Likely need to introduce a PPL symbol as you suggest.
> - Make PPL/SPL/TPL/VPL be a choice statement when building a defconfig.

Good idea.

> - Split something like rockpro64-rk3399_defconfig in to
>   rockpro64-rk3399_ppl_defconfig
>   rockpro64-rk3399_spl_defconfig rockpro64-rk3399_tpl_defconfig
>   and add Makefile logic such that for X_defconfig as a build target but
>   not configs/X_defconfig not existing, we see if any of
>   configs/X_{ppl,spl,tpl,vpl}_defconfig exist and we run a builds in
>   subdirectories of our object directory, and then using binman combine
>   as needed.

This means splitting the existing file into a separate one for each
phase. I believe that will be hard to manage.

>   - Maybe instead the Makefile logic above we would parse X_defconfig
>     and see if it's a different format of say PHASE:file to make it
>     easier to say share a single TPL config with all rk3399, have a few
>     common SPL configs and then just a board specific PPL.
>
> This solves (a) by removing them entirely. This solves (b) by removing
> the ambiguity entirely (it will be enabled or not). As a bonus for (b)
> we can switch everyone to IS_ENABLED(CONFIG_FOO) and match up with the
> Linux Kernel again. This solves (c) again by removing it entirely.

The scheme I propose removes a-c also. I should have made that clear.

There is not a huge difference between your scheme and mine. My
question is, how do you handle (d)?

The way I see it, both schemes remove the ambiguity. Mine retains a
single deconfig file and a single 'make menuconfig' for each board.
Yours feels more like building independent U-Boot images.

Regards,
Simon
