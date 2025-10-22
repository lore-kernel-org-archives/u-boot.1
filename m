Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269DACCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 14:47:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91E638323A;
	Wed, 22 Oct 2025 16:47:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="glaHvvPj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8176E832BC; Wed, 22 Oct 2025 16:47:42 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AACA82B20
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 16:47:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-3c917ea655bso4578675fac.1
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 07:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761144459; x=1761749259; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MPujfSEr2IndZ/o6VOVuFJOC4dlJpI4ZHUjKJzo6yB0=;
 b=glaHvvPj24/zREe3VLQUGB+DzqB8I9QYKl3ljgJVGOdzXlGc/EG4cJS+zileQ1tZh6
 MpDZ0lBCjhgd4mnCfdhrzNQ4EnuXMZDqUyNLpfwW5v+KPRy6NCJ+aT3YddqBlyinhZE8
 ETMrX7vzKqWMa/9eYcpKY88N2wwcaBqQmx1kE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761144459; x=1761749259;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MPujfSEr2IndZ/o6VOVuFJOC4dlJpI4ZHUjKJzo6yB0=;
 b=OSiq40Y9x5mPG/s9nClNOeJRGDx0HCOhACpMvp+KXsJNu7CEQOtzL7TSojZtg3YK7P
 FmvaG0J14DGl+T0brrLbC+0ishilgr1HmY5Efa20eVLKkEwoefYOl9UfZv1aKTxp50D/
 888ipAkH0fwU5L4ONL/Z5SMGuYzsy6soJ0VDVbFVtqEuR20z7oWg3AlaEpYZfVR2b+FD
 InT8ZdfLKqyah66I8NJDT2vfPbzFOfkTMxHH/qo3xhgHv4QWQgHgjBo6tU/g4Su1Nvp1
 cCz4AHWpZCZdYLzyD3SXm+m5AjFBhItPTvuwvNf7x+C8GY4M026981d7s38SyXq7TJF2
 w3IA==
X-Gm-Message-State: AOJu0YxBGKC8q/LnYTu+JXPvI4BTkOrYqY47EEylC1TpTFI+o+SjPNNE
 5kfVVXHZorBkbRXI9CiNpza2OIpLU7XGs4iHhgHg4Ph4WBb0vHxYMShenrASnteGjv0=
X-Gm-Gg: ASbGncs3lk2ei6UoKP3nN+BdM7XJV8Rbeh0O/Ay/ucPGYUr16XU5NLfFecS8NvN7eM6
 1A8OaklVxJo6tRg40h2uHk8OZyTWdI+9Cbbg1u6OpfDi42wklqeOJeJaVvTbwwF5PHnGv3RxiBB
 T3uvg6LLHfHw9OMjXhkKGdV6XhIpVbhUrX/8lcgc3sziu6039igcDSHdwDChaef6Flbbiod9a6n
 qe3TM21/fvE9BbrR10PF0cL7P3gXeT8jclxgl684AW1Rs4ixQxnZEwzUbR/jmQyYhVvatgnHy2T
 wYoYaGHCp97hx6MmdrXMyfnmka46TSE2osBGeYHB2qb8IczFUcdZRK+XNffrB/98QVbehYq9qaP
 x8wD45dTlA19nCvqQfoe06fHAjkQEqEJzsDr0W6V6qU8KiQUJKb1dvNQ1a5AGzLzusNsKo9Ahe3
 I0YF3/smZaBNN2Wqg686RPjBNou3HPQ+0HOifcD64=
X-Google-Smtp-Source: AGHT+IHUjuwYRObo/TpHIgqGoDQmkRrSYdWfY2Uh5+yFvwPd94CpaRyCG1aPv1wytDSc6BOJzdFNWw==
X-Received: by 2002:a05:6870:3041:b0:3c8:f483:f1bb with SMTP id
 586e51a60fabf-3c98d0f6748mr9036609fac.38.1761144458811; 
 Wed, 22 Oct 2025 07:47:38 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c9af3b0258sm3973015fac.20.2025.10.22.07.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 07:47:37 -0700 (PDT)
Date: Wed, 22 Oct 2025 08:47:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 2/3] doc: askenv: Reword and remove return value
Message-ID: <20251022144735.GK6688@bill-the-cat>
References: <20251021202820.1272414-1-trini@konsulko.com>
 <20251021202820.1272414-3-trini@konsulko.com>
 <0fb1e175-6e50-4f2a-a1e2-98ffe3108998@cherry.de>
 <20251022134929.GH6688@bill-the-cat>
 <cc194cf3-ccca-4e66-b3f5-e60cce7da20a@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aVVj1WTsdMxo5w3F"
Content-Disposition: inline
In-Reply-To: <cc194cf3-ccca-4e66-b3f5-e60cce7da20a@cherry.de>
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


--aVVj1WTsdMxo5w3F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 04:06:09PM +0200, Quentin Schulz wrote:
> On 10/22/25 3:49 PM, Tom Rini wrote:
> > On Wed, Oct 22, 2025 at 11:28:15AM +0200, Quentin Schulz wrote:
> > > Hi Tom,
> > >=20
> > > On 10/21/25 10:25 PM, Tom Rini wrote:
> > > > With the addition of general text about how the return value is han=
dled,
> > > > remove the examples from the askenv documentation as they are all n=
ormal
> > > > expected results.
> > > >=20
> > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > ---
> > > > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > > ---
> > > >    doc/usage/cmd/askenv.rst | 27 +++------------------------
> > > >    1 file changed, 3 insertions(+), 24 deletions(-)
> > > >=20
> > > > diff --git a/doc/usage/cmd/askenv.rst b/doc/usage/cmd/askenv.rst
> > > > index e2b3c5379aea..a8867ce4d266 100644
> > > > --- a/doc/usage/cmd/askenv.rst
> > > > +++ b/doc/usage/cmd/askenv.rst
> > > [...]
> > > > -Return Value of askenv command, when used without any other argume=
nts:
> > > > -
> > > > -::
> > > > -
> > > > -    =3D> askenv;echo $?
> > > > -    askenv - get environment variables from stdin
> > > > -
> > > > -    Usage:
> > > > -    askenv name [message] [size]
> > > > -        - display 'message' and get environment variable 'name' fr=
om stdin (max 'size' chars)
> > > > -    1
> > >=20
> > > Shouldn't that be -1 here to match the expected return value when the=
 syntax
> > > is incorrect?
> > >=20
> > > If it is 1, then it's a difference to the expected return value and t=
hus
> > > should be documented below?
> >=20
> > This was included seemingly to include the built-in help message
> > in-text. If desired, we should figure out how to do that automatically
> > and for all commands.
> >=20
>=20
> Agreed, it'd be awesome to extract the _usage part of U_BOOT_CMDs as summ=
ary
> for doc/usage/cmd/*.rst and _help part as the synopsis part so that they
> don't need to be kept in sync (at least that part).
>=20
> > This is separate from what I see this morning right now of any invalid
> > usage returning "1" and not "-1".
> >=20
> > This is from sandbox build yesterday on top of tree:
> > =3D> loadm y y y y y y
> > loadm - load binary blob from source address to destination address
> >=20
> > Usage:
> > loadm [src_addr] [dst_addr] [size]
> >       - load a binary blob from one memory location to other from src_a=
ddr to dst_addr by size bytes
> > =3D> echo $?
> > 1
> >=20
>=20
> Then patch 1 is wrong? Or rather, what is moved in patch 1 is wrong?
>=20
> """
> values are 0 on success, -1 on a usage related errors, i. e. invalid synt=
ax
> and 1 on any other error.
> """
>=20
> loadm y y y y y y would be an invalid syntax, meaning the return value is
> expected to be -1 according to the definition above.

Yes. So while internally we do differentiate between failure of the
command and invalid syntax, we do not seem to populate that to the user.
I had misread one of the headers, so I'll rework the first patch.
Thanks!

--=20
Tom

--aVVj1WTsdMxo5w3F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPjuhAAKCRAr4qD1Cr/k
CvooAQCfOaE5de4ofy6KQbBQgYlNS8BFzXOoUjchwYKzcb78gQD/U6wQTCydghaO
u+ATLm0MjFfQrf6t3Yw2JduiL8TT/Qw=
=SGl7
-----END PGP SIGNATURE-----

--aVVj1WTsdMxo5w3F--
