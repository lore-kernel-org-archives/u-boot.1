Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B0EC6FA8F
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 21:42:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68B6186521;
	Wed, 30 Aug 2023 23:42:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l37FeOQ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DE0B86529; Wed, 30 Aug 2023 23:42:07 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88241803AB
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 23:42:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5924093a9b2so2944057b3.2
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 14:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693431723; x=1694036523; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l1VhVp7ctWGfGjnfkUHYZ0psFUMCYXhG+t1pabQwUGk=;
 b=l37FeOQ7/VDkm1eJMc8+Pu3Vt69RmxZcsCDDIkrr7fHzEfaAu9xb6+sIgTPr6qS5Bw
 +mZyoaNkGuDjJENtkz27/uXtXRLaZIea5QVM4QMofaPViW8IlgBgNyragzzUOMpnpsur
 bR7QNj1y4Bl3ngiLhGPPFYWarAreuzIDDLI7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693431723; x=1694036523;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1VhVp7ctWGfGjnfkUHYZ0psFUMCYXhG+t1pabQwUGk=;
 b=GqHlhfnbNlyCyH3j/ZL/v0yX6HBcw3g+lWmhvBQP8TI9vrr46+AdLDvFN/rVYZPS1f
 a//nRENnELB5z0mgV3VFsOA+j0Z+/c+Zgx4JOJ3RYZib0ekSdapWzvhPf7AhrhtN38RL
 pP10cQXx3iyA+IGJ+jRWvYCqJDlJoTwkxP38Nz1DyqeG6RIPFqPZ34KAWAXchmyNgtDj
 UUHh9WzcR1qphjyYdex9HIVCjc0Yg9yuCeEW5J6zaJ29gkIaHMpR9+N/79DIEkNdYz+a
 3Se3CsBwJDSX/bLbZCbbIWDpUjtajwYuGLcpu/kovO2cpNxLFLYC4Ca0htxNLZxQCBFv
 U3cQ==
X-Gm-Message-State: AOJu0Yx0PvRACLt50bEejMKXuWxJKjSWZakHQZ3+PX/nc90epdIRNtC4
 LL7MjfKEL+8h3D7G3mBx5EfDGPDy3V33+8JR3KcIBw==
X-Google-Smtp-Source: AGHT+IHE5DLWCM8IBAI7k/cgSXQ0YrY3XuWzvV+AxZ9pbpm8BN99oOGab1aGQm1QrB1AvIADucq/kw==
X-Received: by 2002:a81:7309:0:b0:594:ea4f:f5a7 with SMTP id
 o9-20020a817309000000b00594ea4ff5a7mr3368842ywc.31.1693431723298; 
 Wed, 30 Aug 2023 14:42:03 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-39b1-0d8a-4eb9-f110.res6.spectrum.com.
 [2603:6081:7b00:6400:39b1:d8a:4eb9:f110])
 by smtp.gmail.com with ESMTPSA id
 e9-20020a81dd09000000b0058d4eaa6fe0sm32692ywn.52.2023.08.30.14.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 14:42:02 -0700 (PDT)
Date: Wed, 30 Aug 2023 17:42:01 -0400
From: Tom Rini <trini@konsulko.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 32/32] pci: serial: Support reading PCI-register size
 with base
Message-ID: <20230830214201.GM3101304@bill-the-cat>
References: <20230830183913.mpj6achf3prjoanb@pali>
 <20230830190422.GE3101304@bill-the-cat>
 <20230830191036.hecw3vyabdsczxrb@pali>
 <20230830194157.GF3101304@bill-the-cat>
 <20230830194409.a7acogmn54gajmk6@pali>
 <20230830205145.t75fkjhnc7kjux3z@pali>
 <20230830210842.GG3101304@bill-the-cat>
 <20230830211316.5ywrzq6gmxzvdl4o@pali>
 <20230830212620.GH3101304@bill-the-cat>
 <20230830212934.tl2bnmmls2ajdj46@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/F9ESSxYizyjF7Wa"
Content-Disposition: inline
In-Reply-To: <20230830212934.tl2bnmmls2ajdj46@pali>
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


--/F9ESSxYizyjF7Wa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 11:29:34PM +0200, Pali Roh=E1r wrote:

> There were no answers.
>=20
> On Wednesday 30 August 2023 17:26:20 Tom Rini wrote:
> > I'm trimming the CC list. All of those points you list were addressed
> > and answered in your last long running argument. You need to decide what
> > is best for you moving forward and I would ask that it not involve
> > complaining that you're being asked to review code that you're a listed
> > maintainer of.
> >=20
> > On Wed, Aug 30, 2023 at 11:13:16PM +0200, Pali Roh=E1r wrote:
> > > Seems that you completely miss the point of the argument, then the on=
ly
> > > option for such people is to repeat them. Or have I repeat you again
> > > that you have not answered the first question, why you are asking for
> > > review from somebody who you are ignoring and not taking into account?
> > > You do not want to answer this question, right? So you rather change a
> > > topic and talking about something totally different.
> > >=20
> > > On Wednesday 30 August 2023 17:08:42 Tom Rini wrote:
> > > > I don't think it's worth re-hashing the same arguments over and ove=
r.
> > > > There is no "my persons", there is the public community.  If you no
> > > > longer wish to participate, I can remove you from the maintainers
> > > > entries you're listed in.  But please stop with the long arguments
> > > > unrelated to the patches at hand when there's a dozen people and ot=
her
> > > > lists on CC.
> > > >=20
> > > > On Wed, Aug 30, 2023 at 10:51:45PM +0200, Pali Roh=E1r wrote:
> > > > > So lets recap what you and your persons have done in last 6 month=
s:
> > > > >=20
> > > > > * Ignored my changes
> > > > > * Ignored my reviews
> > > > > * Ignored my reminders

Not ignored, changes requested and refused.  Compromises refused.
Apologies from others who had said they would pick up the platform and
push it, but did not have time ignored.

> > > > > * Ignored my regression reports

Not ignored, debugged, problems with your platform implementation
reported and questions asked, patches provided to help you debug the
problem on the single place that seems to show a problem which no one
else can reproduce ignored.

--=20
Tom

--/F9ESSxYizyjF7Wa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTvt6gACgkQFHw5/5Y0
tyyeiwwAsHEWykItqnSnHAUM/u2qqSSNjymCFsA/3a/vYKntHnvUhyZnjp4MQ+Pv
CVX9QOVsBR1rDLN8MgGiHOe+JEBaLVwkVK0st6UyQxaim+uy3asAcCPcrmIcS+1D
1UHIC6nrO3otlVNWChJaiPNCzd5x1Nh7nCgazI8tI0Xc/uDw6wcnmYgGk+Z0ugif
xJ2kI844w/lasenXRXH5qiMGYD+SjffV6hr92TaM+kEtYMrUa89XBtgftaJhMKtM
PTEH5oqU/0u+7/ST2hCdKREx5xXKT2qWcPN6qibUPj4AMgCaKi5BdsS9pcaf1nnN
wsFrbL/xqCPM/XdnWcDKdZYEjMMnys00IeoKizkim4ypUZ+kfHm3SiRY3zuZasV/
6TXE5T8DIlNCYqJXt1ZRt98jxjkjoot6D/6H7H4aIWpaYEyp1di3O0UT0+lxFcz5
E3LI6CkNa8g3Nd5vQyCzC4Pa5wkQ16D6fds5p5wVJn/D3BwQw4s/GRXKCkNsfXwX
Y/NH7cLT
=mOGJ
-----END PGP SIGNATURE-----

--/F9ESSxYizyjF7Wa--
