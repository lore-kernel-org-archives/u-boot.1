Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538D6C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 14:23:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0B5C87995;
	Thu, 28 Dec 2023 15:23:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jWaaUMOF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5275987A45; Thu, 28 Dec 2023 15:23:18 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37E20878FA
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 15:23:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5eb072c0b69so31775457b3.0
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 06:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703773395; x=1704378195; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=19X7mih7hKZ6LPQAsysvbqrcwKh4Y71rvGv7r4ilF5o=;
 b=jWaaUMOFz2qTUQ2VFuUBuMdCVUtgCQRRv4Dj5K/h5RnTGAhkQG3YvncmedZKI5Ir4G
 u/ogm07g8zQSm7pWBUWpQZGgJ7CH1t/W9P5LezdIME6uF3B4X+mKL1Ezuu+RHdnSVQln
 u5v5jvbBH3YOHhBAQN4ehvKcG9NFQ41G3ySf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703773395; x=1704378195;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=19X7mih7hKZ6LPQAsysvbqrcwKh4Y71rvGv7r4ilF5o=;
 b=NcYb5sTLGGNq9dbT4ymfkxhJaOeFyHBp1P7/i5BALkSDXbeoTXddaevF4DDtWMp8Y/
 aKjllssVO6ITXWmPtskdcAJRDJm6kGOOtP2JyEEU8LuA4MDA6P/4SBDKMjb17C2ZfWgX
 6slERAheeRzlqYr/s6IIBXVqZOJYv1+KRdb3RquDhwJBuiznOJPBQD5HReWTNRN1UY/6
 gQHRT4W95ovHWZ20kZPvKaoMWUk8vXmfM5FW4E1CDuFzvQ/6Q1rjFGnEkua36ifVtPw8
 OKChYJqp6TlPtm2wng/3h4lY9xfZNf5/3josnzJVgrshPIW65yr2YbAuToHN6qyDsOMC
 0oxA==
X-Gm-Message-State: AOJu0YxN1SgBqB7XPOWJzvrTVNc1MN6i4fR3ngyGK759J5YELasixyaL
 RKH/jBn1trKH0lpoHL9HLUrOY5TckLFBzA==
X-Google-Smtp-Source: AGHT+IGdFcH30nnyv+LXNlbNy1jGSTUENokDr3ERBNAvK9gk2yMomp8HX3WZYJtwgSmVqJ+t3BS9rg==
X-Received: by 2002:a0d:c846:0:b0:5e4:aa0d:b432 with SMTP id
 k67-20020a0dc846000000b005e4aa0db432mr7312072ywd.86.1703773394848; 
 Thu, 28 Dec 2023 06:23:14 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 o190-20020a0de5c7000000b005e6ea0165dasm7559114ywe.56.2023.12.28.06.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 06:23:14 -0800 (PST)
Date: Thu, 28 Dec 2023 09:23:11 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Andreas =?iso-8859-1?Q?Bie=DFmann?= <andreas@biessmann.org>,
 Michal Simek <michal.simek@amd.com>,
 Michal Simek <monstr@monstr.eu>, Minkyu Kang <mk7.kang@samsung.com>,
 Scott McNutt <smcnutt@psyent.com>, Thomas Chou <thomas@wytron.com.tw>
Subject: Re: [PATCH 0/9] dts: Move to SoC-specific build rules
Message-ID: <20231228142311.GD2652760@bill-the-cat>
References: <20231227082405.2202246-1-sjg@chromium.org>
 <20231227132156.GQ2652760@bill-the-cat>
 <CAFLszThBrAVSH2jYxhxFSETqr4za+BqjZBBjLaDokc1ZdrXXRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EpwqTx7mSVGb/0XM"
Content-Disposition: inline
In-Reply-To: <CAFLszThBrAVSH2jYxhxFSETqr4za+BqjZBBjLaDokc1ZdrXXRw@mail.gmail.com>
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


--EpwqTx7mSVGb/0XM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 01:37:07PM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, Dec 27, 2023 at 1:21=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Wed, Dec 27, 2023 at 08:23:56AM +0000, Simon Glass wrote:
> >
> > > U-Boot builds devicetree binaries from its source tree. As part of the
> > > Kconfig conversion, the Makefiles were updated to align with how this
> > > is done in Linux: a single target for each SoC is used to build all t=
he
> > > .dtb files for that SoC.
> > >
> > > Since then, the Makefiles have devolved in some cases, resulting in
> > > lots of target-specific build rules. Also Linux has moved to using
> > > subdirectories for each vendor.
> > >
> > > Recent work aims to allow U-Boot to directly use devicetree files from
> > > Linux. This would be easier if the directory structure were the same.
> > > Another recent discussion involved dropping the build rules altogethe=
r.
> > >
> > > This series makes a start at cleaning up some of the build rules, to
> > > reduce the amount of code and make it easier to add new boards for the
> > > same SoC.
> > >
> > > One issue is that the ARCH_xxx Kconfig options between U-Boot and Lin=
ux
> > > are not always the same. Given the large number of SoCs and boards
> > > supported by U-Boot, it would be useful to align these where possible.
> >
> > I don't know why we should start with this now, and further not being on
> > top of Sumit's series to remove our duplicate dts files. And that's
> > where we can have the conversation about for which cases it even makes
> > sense to build all of the dts files for a given SoC.
>=20
> This is a completely different series - there are no conflicts with
> Sumit's series so it can be applied before or after it.
>=20
> My goal here is to clean up our build rules, rather than just throwing
> them all away, for reasons we have discussed previously. I filed [1]
> to track that.

Yes, I'm saying we shouldn't be doing anything this series does until
after Sumit's series has landed. Along with the fact that I don't like
what's going on in this series.

--=20
Tom

--EpwqTx7mSVGb/0XM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWNhMkACgkQFHw5/5Y0
tywWaQv9FlP8SyjDjCAxoKRCcHjGnT6DfiURpwopFsziaok0U9iDNpB+sqWkrQCF
ORSfVR3ypVTlBeww+v3Sg9aid7TF+/BALf6cHpL7o0E64PDKnwJBwcOlN4vzrkPK
y/59gNBcOXRj81IgFo2HvNLxepyS2XqizJ5DrULNAmCt39zG+IXWuuoVlzxUC9T0
q/Wjlo6Dxpk7SIBg6j6I0bu5XLrbHui26P2XmP9BCv8afFRq7lJZ1Ek/8sqMckfw
bXfBMAYOf/4Kw3qZXH+W3JG3BpGp7I7aegmB6XETcrIdlItb58LUQnMIl9ma+9jk
qMCPb8umaFShohyiDWly3Z9ZQ+AFEGzyj3ywgpebluc2+HNp4Vorb92trqCQqoCU
ywep0Vuu7DOPzmBWG2v/z8Yp8BVAa9lFF5jebr165lNgH24RoDESl6jMJc5db7/T
lIYAMu0zCuZF2zymyAqSWo1yleXkV8jzb1/rg6ja50xWVes2t24CIe5A9ocGa32S
WltsFEPW
=oJXC
-----END PGP SIGNATURE-----

--EpwqTx7mSVGb/0XM--
