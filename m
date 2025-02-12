Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A113C02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 16:40:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80A6580C72;
	Wed, 12 Feb 2025 17:40:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MBJ5Bfd0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 084FC80077; Wed, 12 Feb 2025 17:40:09 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42C2A80079
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 17:40:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7be3d681e74so619940485a.0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 08:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739378404; x=1739983204; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/RL7pJEzUIxhqJl0bb/z3/Z46qWqf63wHxo/F2pboqc=;
 b=MBJ5Bfd0g5q925zOpKvEI0B0tgGKQf46UFYc7KqyCi3orL+QH8Z0EH8ZShiE16zaQ3
 cZ6VAwyWHda8VHkJqCNT9WntX6nWaZu7SpFWztFo/e2wmau2t64ZTOa3+PdeAaR2HsAa
 wF85IEZqZ+uWBk/TKPtg+DzFAOHXR5YhC4Gkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739378404; x=1739983204;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/RL7pJEzUIxhqJl0bb/z3/Z46qWqf63wHxo/F2pboqc=;
 b=uQNWFYr3nH3RaRrLBD3xfccO8x2dhNvIU1+reA41CaApV5pBbUaQfS/CBSwchWN97b
 b/yYEA7RN4WKnHiSao3g40BhMtzB5Q6nYAYqmVe2rX/hMz0/y1RRVMY9YDztmdGBv5/K
 4U6LX7f7UWeOrt9nCC0rbomL20zT+oLZBOc7cSCZ6BGypxFboTmn5APGmtUvOqySbzjF
 QkmbzQDIivfrVuRrke8geCppJ7BIitnC0w+iS5oUc8u1DaBHaoSW9o2fT2Cgj1Ux4KNM
 gG6+EbhMgDrYPpWmeAOb9xAMGvbsNl/MADMXTKENtHVfmmB50/ly9SnXbX6RxIvV/Hkj
 jKjw==
X-Gm-Message-State: AOJu0Yxh/SKnjAZZNwuMnEcLkw7epfjTsk+YGCwYt9q4IBRlsA0/919B
 yxWHZcgdY1vlJKsJX0NYtf99utrwsgkf1f6yZCJwsYoTcNSnXJHHxRxBeSSki2o=
X-Gm-Gg: ASbGncuUICssbgGlI3xN15S2txJ0F15L/SQRzgpJFjmgFc6CBcNGI+XwqXUbmkLHOz9
 o6demAeyNOa77eAkQJdTnccSwqnwN2ke4QRTKpfZRJipc4bS+S2AkGFEUU4mA47BAJmsn0DWPLr
 1I9RQckd4rumACC9Wq8J6XKWsWam6c6fX9yW/ykVJsWcLMhaKNo7zoHwdbn63CzAHpN0dXn+G3P
 27veZcJRaGaP06X5R2cdjw1LwUb/1nyFbwQiy2JYpG+8bVBR5rGFgv1TJ4J1s9oQbV3Hejc51aL
 v1n10JKb/lYvo0w=
X-Google-Smtp-Source: AGHT+IE2X733Hqn13zwJPntwtGapTe5t3qFvl4ECtGLdTRyRzA3A9Vu7aaePaM6uzRcg8eOLryv8+A==
X-Received: by 2002:a05:620a:2407:b0:7b6:d6cb:8b99 with SMTP id
 af79cd13be357-7c07062c4ffmr507215185a.0.1739378403890; 
 Wed, 12 Feb 2025 08:40:03 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c041e11bbbsm863469485a.50.2025.02.12.08.40.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 08:40:03 -0800 (PST)
Date: Wed, 12 Feb 2025 10:40:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250212164000.GO1233568@bill-the-cat>
References: <CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=ieT2oaHfgLf3_nC+xXA9g@mail.gmail.com>
 <20250211212222.GH1233568@bill-the-cat>
 <CAFLszTjaGsXZH6_CAbBhwJ7MAPdzdOUYn=CVBewQKCMX2CS1EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3wmBrnGD7DWucmmK"
Content-Disposition: inline
In-Reply-To: <CAFLszTjaGsXZH6_CAbBhwJ7MAPdzdOUYn=CVBewQKCMX2CS1EQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--3wmBrnGD7DWucmmK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 03:54:21PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 11 Feb 2025 at 14:22, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Feb 11, 2025 at 08:03:20AM -0700, Simon Glass wrote:
> > > Hi,
> > >
> > > I just wanted to send a note to (re-)introduce my ideas[1] for the
> > > next iteration of xPL.
> > >
> > > A recent series introduced 'xPL' as the name for the various
> > > pre-U-Boot phases, so now CONFIG_XPL_BUILD means that this is any xPL
> > > phase and CONFIG_SPL means this really is the SPL phase, not TPL. We
> > > still use filenames and function naming which uses 'spl', but could
> > > potentially adjust that.
> > >
> > > The major remaining problem IMO is that it is quite tricky and
> > > expensive (in terms of time) to add a new phase. We also have some
> > > medium-sized problems:
> > >
> > > a. The $(PHASE_), $(SPL_) rules in the Makefile are visually ugly and
> > > can be confusing, particularly when combined with ifdef and ifneq
> > >
> > > b. We have both CONFIG_IS_ENABLED() and IS_ENABLED() and they mean
> > > different things. For any given option, some code uses one and some
> > > the other, depending on what problems people have met along the way.
> > >
> > > c. An option like CONFIG_FOO is ambiguous, in that it could mean that
> > > the option is enabled in one or more xPL phases, or just in U-Boot
> > > proper. The only way to know is to look for $(PHASE_) etc. in the
> > > Makefiles and CONFIG_IS_ENABLED() in the code. This is very confusing
> > > and has not scaled well.
> > >
> > > d. We need to retain an important feature: options from different
> > > phases can depend on each other. As an example, we might want to
> > > enable MMC in SPL by default, if MMC is enabled in U-Boot proper. We
> > > may also want to share values between phases, such as TEXT_BASE. We
> > > can do this easily today, just by adding Kconfig rules.
> >
> > I agree with a through c and for d there are likely some cases even if
> > I'm not sure TEXT_BASE is a good example. But I'm not sure it's as
> > important as the other ones.
>=20
> OK. No, TEXT_BASE is not a great example in my book either. But it is
> true that SPL needs to know U-Boot's text base.
>=20
> Here's another:
>=20
> config SPL_SYS_MALLOC_F_LEN
>    default SYS_MALLOC_F_LEN
>=20
> config TPL_SYS_MALLOC_F
>    default y if SPL_SYS_MALLOC_F
>=20
> config TPL_SYS_MALLOC_F_LEN
>    depends on TPL_SYS_MALLOC_F
>    default SPL_SYS_MALLOC_F_LEN

Alternatively:
config SYS_MALLOC_LEN
   ... current default X if Y
   default 0x2800 if RCAR_GEN3 && !PPL
   default 0x2000 if IMX8MQ && !PPL

> > > Proposal
> > >
> > > 1. Adjust kconf to generate separate autoconf.h files for each phase.
> > > These contain the values for each Kconfig option for that phase. For
> > > example CONFIG_TEXT_BASE in autoconf_spl.h is SPL's text base.
> > >
> > > 2. Add a file to resolve the ambiguity in (c) above, listing the
> > > Kconfig options which should not be enabled/valid in any xPL build.
> > > There are around 200 of these.
> > >
> > > 3. Introduce CONFIG_PPL as a new prefix, meaning U-Boot proper (only),
> > > useful in rare cases. This indicates that the option applies only to
> > > U-Boot proper and is not defined in any xPL build. It is analogous to
> > > CONFIG_TPL_xxx meaning 'enabled in TPL'. Only a dozen of these are
> > > needed at present, basically to allow access to the value for another
> > > phase, e.g. SPL wanting to find CONFIG_PPL_TEXT_BASE so that it knows
> > > the address to which U-Boot should be loaded.
> > >
> > > 4. There is no change to the existing defconfig files, or 'make
> > > menuconfig', which works just as today, including dependencies between
> > > options across all phases.
> > >
> > > 5. (next) Expand the Kconfig language[2] to support declaring phases
> > > (SPL, TPL, etc.) and remove the need for duplicating options (DM_MMC,
> > > SPL_DM_MMC, TPL_DM_MMC, VPL_DM_MMC), so allowing an option to be
> > > declared once for any/all phases. We can then drop the file in 2
> > > above.
> > >
> > > With this, maintaining Kconfig options, Makefiles and adding a new
> > > phase should be considerably easier.
> >
> > I think this will not make our life easier, it will make things harder.
> >
> > I think what we've reached now shows that Yamada-san was correct at the
> > time in saying that we were going down the wrong path with how we
> > handled SPL/TPL.
>=20
> You've mentioned this quite a few times over the years. Is there a
> reference to what he suggested we should do? Or perhaps it is what you
> have below.

I don't recall what he proposed instead, just that when it became clear
that I wanted to move from the "S:CONFIG_FOO.." syntax for how SPL was
handled to how we're doing it today, he thought that was the wrong
direction.

> > My request instead is:
> > - Largely drop SPL/TPL/VPL (so no DM_MMC and SPL_DM_MMC and so on, just
> >   DM_MMC) as a prefix.
> > - Likely need to introduce a PPL symbol as you suggest.
> > - Make PPL/SPL/TPL/VPL be a choice statement when building a defconfig.
>=20
> Good idea.
>=20
> > - Split something like rockpro64-rk3399_defconfig in to
> >   rockpro64-rk3399_ppl_defconfig
> >   rockpro64-rk3399_spl_defconfig rockpro64-rk3399_tpl_defconfig
> >   and add Makefile logic such that for X_defconfig as a build target but
> >   not configs/X_defconfig not existing, we see if any of
> >   configs/X_{ppl,spl,tpl,vpl}_defconfig exist and we run a builds in
> >   subdirectories of our object directory, and then using binman combine
> >   as needed.
>=20
> This means splitting the existing file into a separate one for each
> phase. I believe that will be hard to manage.

Do you mean initially, or long term? Initially, it should be a bit of
shell scripting. The consolidation (ie most/all rk3399 having an
identical _spl_defconfig) can't be automated. Long term I'm not sure it
would be any different. Most of the maintenance is on resync'ing which
is automated.

> >   - Maybe instead the Makefile logic above we would parse X_defconfig
> >     and see if it's a different format of say PHASE:file to make it
> >     easier to say share a single TPL config with all rk3399, have a few
> >     common SPL configs and then just a board specific PPL.
> >
> > This solves (a) by removing them entirely. This solves (b) by removing
> > the ambiguity entirely (it will be enabled or not). As a bonus for (b)
> > we can switch everyone to IS_ENABLED(CONFIG_FOO) and match up with the
> > Linux Kernel again. This solves (c) again by removing it entirely.
>=20
> The scheme I propose removes a-c also. I should have made that clear.

Er, ok. That's not how it looked before, but I guess I'm just mistaken.

> There is not a huge difference between your scheme and mine. My
> question is, how do you handle (d)?

Well, either (d) isn't important as for example MMC wasn't a good choice
in your proposal as virtually everyone "select MMC" today or it's
handled more easily as my example above in SYS_MALLOC_LEN.

> The way I see it, both schemes remove the ambiguity. Mine retains a
> single deconfig file and a single 'make menuconfig' for each board.
> Yours feels more like building independent U-Boot images.

It is explicitly building independent U-Boot images, yes. With a wrapper
around "make all of the images for a given platform". So much of our
confusing and messy code is because we aren't doing that. And since most
modern SoCs can work as (mostly )generic SPL selects correct DTB for PPL
we really could have fewer overall build configurations.

--=20
Tom

--3wmBrnGD7DWucmmK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeszt0ACgkQFHw5/5Y0
tyxM/gwAjp3m76sQ3PRGrzRxOt3/wmb6izZLS3h/CKqnlI9Djqdk3wIUcB5k+Iq3
xP5FHnQgMpTmYo0RQqji7Bd/DOEff6AaMeoVoC6VVhoXtoEoabvcWTXVXPw4pEoT
lAYA46oC7HsTxkrP3ohtsBtA/yn3X/THn6LVsEgmL+J1ito2DRzfyYUWBz3aX8t6
vXYJiHhkJkyBOqS5QSSnDP5JeSdPHqMHI5Zg83uWbRJzcC6MDE/2/XVw3edhQ/tr
77rku/vQPZ3Yz0zNW4apbmY9tFS8HfzTnf4Prw90yJ8ToT6atuBKXNCRnTA9+X7V
FbCwS8X0fq2o6a2d0HHmmGYmuu7T8HUhotV+XLlGYFVHoZ5KBaoh70GY+linOXSX
8JQ2PQv7W8rk7A/Mg7zVVDlNF6ouqXJf91J20fZxOw0KucU8pl/zcPd+Fnnd5Bgy
rJSGzRB1GO44ZkKmzehWKxv/mfM3IgII0QbQMn837gyVyXX6/zf3SaaU4pQUitLO
2zS1MimQ
=EbZ6
-----END PGP SIGNATURE-----

--3wmBrnGD7DWucmmK--
