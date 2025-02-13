Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A52CC021A0
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 15:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81B4980F1C;
	Thu, 13 Feb 2025 16:59:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eePCxdbm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE10F80F1C; Thu, 13 Feb 2025 16:59:18 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6566180C96
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 16:59:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6f4434b5305so9136127b3.3
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 07:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739462355; x=1740067155; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QsiAZFCgCQ9BpqgQS6jTTHFvl6sjg2bULUauFMB03VY=;
 b=eePCxdbmDLsmXwelLMqol5Syp8Ve0pCWEbKaOd7w7kc9dXsA2OmGhl0o0XIAj6v646
 eJkZq4VuInNSIs4FfSu7XzTM5FgPWeBrfAlIT3K4hpbsKWBALybaD510YJuvM8Pc6B53
 srawLljvxdwEycq7GxzJ06CDwWAYu5Ybv+aiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739462355; x=1740067155;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QsiAZFCgCQ9BpqgQS6jTTHFvl6sjg2bULUauFMB03VY=;
 b=ZGcL5ExrPl8ILpdHWMnam5JNODhq8+rG7zMGMNukGQZG6mXZ1N9MddnI/xchxyHMWv
 yj6ZxxeVicL8UtRWkPnx5PHwgpJ68PBH0/aZtucb7sVZy8/NlQ8mCME+DU+1713VIaWy
 1M6B5SPjXtuNuX3AzEZBawyLdkUE0PLnN1/JVnqKhaaQomajtDPh9kMFVN99zRx9ckar
 xleUcCa83m+A1FnulOlxUrM7Mfro3iLQya6h0sxNTGafynDpLPuCSsQO0JTBliKT4Rmt
 QoZqPp1EixVq/tGKa+fx7xB5qJt1X3J3O1haJ7p3TF5Gn7Uz9gT4/VE24laf/bCRbBFs
 Cb5w==
X-Gm-Message-State: AOJu0YyFgDa2d0icCYOVFmQ/SNKHgtnMueOoCGnTD9KP/OKbFiLj/9y6
 oQ4rG1jbbOPrVh3WjGcb8rTMVt/qW2X102RS5lahXlfER6s0qQ9QyCZ3BCx0djA=
X-Gm-Gg: ASbGncuI3yz9qWpPATNxWNpttmUF8AI42jWX+AI6dKFDQvKR4g2c09h5mYCTLVsK4wF
 a9DyyPdJrBa+rqB+wYVnsamqs41yrK2ytNKnXmao1oWdnV07dkrUuzRSimcMEIfHAEZ7ymAftUK
 P/5ZQ8F49u9m5d179kYxliG0sZXMxY7qrEzkTztzQKZ31v9vIrwm002LbsIO5xmB5KJvJ0VPTZ2
 A6pbDnUCBmyzT4fCjq6pRTSfkggnqwAM0SVr2JCpSq+uqduVuj5V0sEiL7HqGDXpNZu+Pq0oGl5
 FG4ynFp0JgdYJ/M=
X-Google-Smtp-Source: AGHT+IGGINB1T2lKN2BG1zOwq8KKRmCisv7ujcxwaaayCIhRF3KY9mjBZauxWMEChNVSFqCRWx5hUQ==
X-Received: by 2002:a05:690c:62c8:b0:6f9:8436:3d2a with SMTP id
 00721157ae682-6fb32d650cbmr37656497b3.32.1739462355162; 
 Thu, 13 Feb 2025 07:59:15 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fb361bd7basm3467937b3.105.2025.02.13.07.59.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 07:59:14 -0800 (PST)
Date: Thu, 13 Feb 2025 09:59:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250213155912.GU1233568@bill-the-cat>
References: <CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=ieT2oaHfgLf3_nC+xXA9g@mail.gmail.com>
 <20250213141517.GT1233568@bill-the-cat>
 <CAFLszTib-ydH-TCE-Oi0SDGu1ASWbCbfWApTqxFFHoU3Di_nvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1DxncMk+mzE+KNCP"
Content-Disposition: inline
In-Reply-To: <CAFLszTib-ydH-TCE-Oi0SDGu1ASWbCbfWApTqxFFHoU3Di_nvw@mail.gmail.com>
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


--1DxncMk+mzE+KNCP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 07:33:20AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 13 Feb 2025 at 07:15, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Feb 11, 2025 at 08:03:20AM -0700, Simon Glass wrote:
> >
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
> > >
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
> > Here is the big problem I see with your proposal. Today our Kbuild and
> > kconfig support is very much out of date. And while my attempts to
> > resync them together haven't worked, I believe it comes down to how we
> > build *pl targets today, at least in part, because that's just not
> > a thing upstream has to do. What you're proposing here will make any
> > future resyncs even harder as more of the code will diverge from
> > upstream (as seen in your previous RFC series).
>=20
> Yes, that's true, but mostly in kconfig. I would be willing to resync
> kconfig with Linux, if that helps.

Yes, re-syncing scripts/kconfig to v6.13 (as a stand alone series) would
be helpful, thanks.

> For kbuild, my series doesn't do much there. I could perhaps offer a
> resync of fixdep.c ?

That's another part of the infrastructure that is out of date, yes.

> Did Linaro show any interest in taking on Kbuild? Linux just has a
> huge amount of build-code now. What problems do you have with U-Boot's
> current Kbuild?

Yes, it's somewhere on various people's "would like to do" list. And in
terms of problems:
- clang is broken for everything except sandbox I believe
- clang + LTO never worked for us
- Our dtc ignore warning flags are well out of date (and harder to sync
  up with)
- All of the general fixes with the Kbuild logic post v4.20 are just
  missing.

That's just off the top of my head.

--=20
Tom

--1DxncMk+mzE+KNCP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeuFsUACgkQFHw5/5Y0
tyyASAwAg1ZtBznBb5ndQ6FdmIwECYVzeoE44UAi+7sy8d0B3Le5FO+ImURZQuYq
dzI9Td0+pJKs3vq+tnHf7cVesrbi5nLRYMhcyBvprU6piRg8ivtRaYpCB63d5LeD
Q5qUuq3bOSgeDHrY/a5gaY/IsTlPX93aLFg/UytCrzKYIjCVF2YZRyqsKaVyIsgl
tiXCO4jbTP/IcujX9WaGgPWK6LvjHQQwRCy4hqo5VcoVOf5hGSpf8xwlosiZNGSE
Z8AeAZo6o/etBPhDnfFNnnPGVxW7cO2WkUTRIY1JEfJzSkLp1MbvanSqrw8kpqfv
1l+vHSXLcWZsSNfSUJl3DJ53DNoTtJtOgFCihuvth02RbIPk38bjbwOs+yybHGrn
sGuJ18xR6d/6ggIOrHaqYRRd1tCnAFlDYU6TUsn5rV0lVWmcpnmhxnDRSzQ5i7I0
pfnFTE2qwilCtt7tFe5TFwsJMPEE5HSEGmO8KfZnL/uPxwk+LBuYrflQuovHKvkU
z4vku5Ae
=qcJn
-----END PGP SIGNATURE-----

--1DxncMk+mzE+KNCP--
