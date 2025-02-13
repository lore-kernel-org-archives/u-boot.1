Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC57C0219D
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 14:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE05080F03;
	Thu, 13 Feb 2025 15:15:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k99R6BSu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1313680C77; Thu, 13 Feb 2025 15:15:26 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A08A380A55
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 15:15:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6f8c58229f1so8034747b3.0
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 06:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739456121; x=1740060921; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DubjpcdwIbFLl0gFSamtmynJlE+2dDXepVLWqH1wmF0=;
 b=k99R6BSuqxmpQz5SjFARqRZ4b8cy0wazE0OmV5Tf9OfAjh1fmUsQDFp2+ucRHje+hO
 V7p1Bou+e44YNTAhrsAGQA2fIBT1cgX1ZL8+ViLuqOmejyquGPdM6cUgSRaAZvsz+OiX
 UVLKjUEDVqwg5T5xyzAtNsqR2d9NdUFUUG4lA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739456121; x=1740060921;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DubjpcdwIbFLl0gFSamtmynJlE+2dDXepVLWqH1wmF0=;
 b=q9ll6YJJyG79HdJAbPpxaRgqKiORNifZ3Baq+YIxkzIFF2EJeVh3/L7uUCCAZjuTZJ
 oGAM3cnAhoobcAtxMrandzBsABnFY04zixairNslVHZGQE95mC05nM6uDozZZQKN3YMC
 Z/9dvq3hlsUq+Goag5uyNxVxsf6rMANpvHLEMLcnA6Osw9cmf6KmaSDF4Nvi/LOfKmnT
 s93TAjdlwTRLZgNEJz+kIZkffpj17IOOygda6MysL/mpJBQsujUH72pDfnStHQs9KgN6
 NdsJbP1aI/Tag9B//O0p7JNCG7/xj/EE7u2AYkrVDQKUUhE1fiAoNlB/Lu/1/EEh3rt3
 EnIQ==
X-Gm-Message-State: AOJu0Yy4jWPuZaSEpFIbx8soK0jXyU98W/CHoyfuOtJkwdUwVc1uFKt8
 1sjk5OlJvA2tKvDOppj6VW88+IBt68kq7Idm3CWe0wofkXOWfHmnmRNRMAB9kYs=
X-Gm-Gg: ASbGncsYaSZ9wBsyQrsKQ9i8AGxkPZBkPfM78+PEcBZAxaQ3vi6Lm2YCy14Z6LwNKea
 srvsUVWHQ65Uv6FrOgon3U0t1k+G5Q9KvlH8XWqo9p/tU5aruw6pnmSDX3hyDhGd4LBB563P/mC
 tgshu2QNqIB4QzNwy9Tvzwz2LtNxeHcITepJgl7s5RHcKcbiuYlRVMqtaCaoAcC/AXBoqh6w6Cv
 xxZ66pptdB5mJE8Rk7nz1D6r4HE3vGyQ6VH8QfpsDkpA9Mb6+lGgDp3LXndDXQDQqzcFgXzx7zO
 kz13Jgp0bnhodPs=
X-Google-Smtp-Source: AGHT+IHq2CNkSeK+4TTiTgy+h/hhVqwsqj0tk4/ogmVTh7wA+gjrjBKgI63SDOmog9LNukiFNFptKQ==
X-Received: by 2002:a05:690c:3083:b0:6f9:b144:34e6 with SMTP id
 00721157ae682-6fb33d0dd76mr28823297b3.13.1739456121191; 
 Thu, 13 Feb 2025 06:15:21 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fb361bac25sm3057357b3.97.2025.02.13.06.15.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 06:15:20 -0800 (PST)
Date: Thu, 13 Feb 2025 08:15:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250213141517.GT1233568@bill-the-cat>
References: <CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=ieT2oaHfgLf3_nC+xXA9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yYzJ1GfWG7VKXI/2"
Content-Disposition: inline
In-Reply-To: <CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=ieT2oaHfgLf3_nC+xXA9g@mail.gmail.com>
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


--yYzJ1GfWG7VKXI/2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 08:03:20AM -0700, Simon Glass wrote:

> Hi,
>=20
> I just wanted to send a note to (re-)introduce my ideas[1] for the
> next iteration of xPL.
>=20
> A recent series introduced 'xPL' as the name for the various
> pre-U-Boot phases, so now CONFIG_XPL_BUILD means that this is any xPL
> phase and CONFIG_SPL means this really is the SPL phase, not TPL. We
> still use filenames and function naming which uses 'spl', but could
> potentially adjust that.
>=20
> The major remaining problem IMO is that it is quite tricky and
> expensive (in terms of time) to add a new phase. We also have some
> medium-sized problems:
>=20
> a. The $(PHASE_), $(SPL_) rules in the Makefile are visually ugly and
> can be confusing, particularly when combined with ifdef and ifneq
>=20
> b. We have both CONFIG_IS_ENABLED() and IS_ENABLED() and they mean
> different things. For any given option, some code uses one and some
> the other, depending on what problems people have met along the way.
>=20
> c. An option like CONFIG_FOO is ambiguous, in that it could mean that
> the option is enabled in one or more xPL phases, or just in U-Boot
> proper. The only way to know is to look for $(PHASE_) etc. in the
> Makefiles and CONFIG_IS_ENABLED() in the code. This is very confusing
> and has not scaled well.
>=20
> d. We need to retain an important feature: options from different
> phases can depend on each other. As an example, we might want to
> enable MMC in SPL by default, if MMC is enabled in U-Boot proper. We
> may also want to share values between phases, such as TEXT_BASE. We
> can do this easily today, just by adding Kconfig rules.
>=20
> Proposal
>=20
> 1. Adjust kconf to generate separate autoconf.h files for each phase.
> These contain the values for each Kconfig option for that phase. For
> example CONFIG_TEXT_BASE in autoconf_spl.h is SPL's text base.
>=20
> 2. Add a file to resolve the ambiguity in (c) above, listing the
> Kconfig options which should not be enabled/valid in any xPL build.
> There are around 200 of these.
>=20
> 3. Introduce CONFIG_PPL as a new prefix, meaning U-Boot proper (only),
> useful in rare cases. This indicates that the option applies only to
> U-Boot proper and is not defined in any xPL build. It is analogous to
> CONFIG_TPL_xxx meaning 'enabled in TPL'. Only a dozen of these are
> needed at present, basically to allow access to the value for another
> phase, e.g. SPL wanting to find CONFIG_PPL_TEXT_BASE so that it knows
> the address to which U-Boot should be loaded.
>=20
> 4. There is no change to the existing defconfig files, or 'make
> menuconfig', which works just as today, including dependencies between
> options across all phases.
>=20
> 5. (next) Expand the Kconfig language[2] to support declaring phases
> (SPL, TPL, etc.) and remove the need for duplicating options (DM_MMC,
> SPL_DM_MMC, TPL_DM_MMC, VPL_DM_MMC), so allowing an option to be
> declared once for any/all phases. We can then drop the file in 2
> above.
>=20
> With this, maintaining Kconfig options, Makefiles and adding a new
> phase should be considerably easier.

Here is the big problem I see with your proposal. Today our Kbuild and
kconfig support is very much out of date. And while my attempts to
resync them together haven't worked, I believe it comes down to how we
build *pl targets today, at least in part, because that's just not
a thing upstream has to do. What you're proposing here will make any
future resyncs even harder as more of the code will diverge from
upstream (as seen in your previous RFC series).

--=20
Tom

--yYzJ1GfWG7VKXI/2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmet/m4ACgkQFHw5/5Y0
tywhmgv/a98twRcF9eXpIprEj6076BJ4+ABiiDojM4QTis44tHgTEneZqCDTLCTm
xnnNSQvaGNiZTT4m8ILRxX7arddiEuO8E2U+mX7mwruhpQWnx/QLKZmPZvA5+K3R
XhdRqPfj2Q64HEwaD2s8kOGQ6Pf0vM7KCDcZRUk+4FYnAlG5DQ0LqyVgDsNUi7CN
1fEIom7DCkZGbt5xkA4RhC6CZqQ7efrIllBX9NxQZEbV7PG9UrEpDViEm6hh7HWt
UVjVwP6EfcyZbvvLyuE+H3+oKC2ooZidFRjPyDdBKoSIFAucbVOSTcmYceH7658d
k0AeSczdT2I7xrazVEwgKTWM8nOvbmeNdG5IuqTP6SxXp5zPXOUklgaTJvUoZkj8
CqnnOd3e3eU+mzNbXnsyj3ijRHIkkAQr9fgbl+LYQ3yD49Rwd7/t8aLmWKoJY2N5
VEgti7bLQWu3Ob6Xgrz1dsrzswc4FxXEkBKDQQAA7iRxbNlEO0lvsAMj2MhK2E6f
It1LKDEs
=G2nj
-----END PGP SIGNATURE-----

--yYzJ1GfWG7VKXI/2--
