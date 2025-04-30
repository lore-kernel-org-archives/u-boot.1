Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D1FC3ABA9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 14:21:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F11618210E;
	Wed, 30 Apr 2025 16:21:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K4iVeL+f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC50C82B39; Wed, 30 Apr 2025 16:21:48 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9406820E2
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 16:21:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3fbc00143d6so6022138b6e.3
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 07:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746022905; x=1746627705; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Yy0cxkphhVnSB2DSL63ILBXxC7OJINLK/WcOJD7NQBE=;
 b=K4iVeL+fFUnlGFfzLDNtJ0DgRR7O0P+Wv7aZQ3fReKYXuc7FUxnOPqF3yHyzKbaOLX
 Tpizi/bl2QTPqaH0kyjFMhAtrvYbdKj7otckh5EzaG9Nn4hO3o3FAHFnFoPAbtO6r0S4
 NjJ9ZCAxxwx+R7NkWXIv4ZzbZXY4GhmGmQF5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746022905; x=1746627705;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yy0cxkphhVnSB2DSL63ILBXxC7OJINLK/WcOJD7NQBE=;
 b=h0yjZ0fRlA0KHjinxNb3MysBIn6IttA0nk3IV4+/1bTLr5I7gApCEXHe1ELxKZIN9b
 HpFCEoM3RdegUFcD5fM95BGUbCC/VLE9tgDRomr+OLIE8AC7QFKWWP4H28INqZtR2J0w
 dLPLBb77IqGEo4vanzXeNncB5M+QhoyrpT/YqIIazhA9y8QudVlUGMQeMVcoJt6ozvwp
 DZmXvVszvG3WQbSzqDeAZe3TTvuP26fqgvPvRbSo7Ygf8wbMCU3r1Fg/Bt/J+0sAlkFl
 g3fSUTMLa/rhe9TnGfWveqb9ukD0SQjKmx54BXw5s0zzZvocf5hZofEjvIMYYJzi4IH0
 D9+g==
X-Gm-Message-State: AOJu0YyVaYRuhhBlYe7UJx1GmzZonBSTvmCCZqi+jg/BuR8DkRqIe97x
 4kgCVGTWKUqTsJMMe/afacijBVoEcYjHYD9+1QZ3pIhiof8e5wea98JXMuWG/DA=
X-Gm-Gg: ASbGncvH9BtL9RcB31yY+6mt0KHhI4dCMFmCDKj3gK755h0ZxJZbCqVQJwPZYK2+u+h
 VV3ai6ftsHAssCHlwE/tKT8A4hLnw6OWRyGLYMbdOaeLvMuny/bxtwq9Mq1z6pItEjzncJo3q2U
 hJgee1DPfgNG00mAZGizXCu8Mf0S3HeaN3/rQcZZw8XrD9Z6eqcz0SFxJN5dBtDr8icnaDQUj19
 ZNbX1W+HGyVTjTfaKV/WUl5W0KuritgqDEwrc9mQQR4HD/fspk7hJGwdKZEl6CTTTAEpG0FuRfb
 XsRJ63ceuELq1fDzTrdc33OvUJJI8JCrnUQsQVs4nWNFOTPN7FCg7o3bsKbNg4ZJzOoaNghotgK
 Taw==
X-Google-Smtp-Source: AGHT+IGfHDLNlLC3rw0bPTGqM4Zy2V4+HuGDytsoxYh5QthuPYDFTZoPX4HhK+9sOsvcGRb+u1v0RQ==
X-Received: by 2002:a05:6808:319b:b0:400:8252:a645 with SMTP id
 5614622812f47-40239e7b97emr2101362b6e.21.1746022905357; 
 Wed, 30 Apr 2025 07:21:45 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4021292d324sm814126b6e.21.2025.04.30.07.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 07:21:44 -0700 (PDT)
Date: Wed, 30 Apr 2025 08:21:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Douglas Anderson <dianders@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Leonard Anderweit <l.anderweit@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Sean Anderson <seanga2@gmail.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: Re: [PATCH 00/30] patman: Move to asyncio and other updates
Message-ID: <20250430142142.GP1261075@bill-the-cat>
References: <20250429132239.251756-1-sjg@chromium.org>
 <20250429134846.GA1261075@bill-the-cat>
 <CAFLszTgrJvgWJaCXFgefJ1bObsrGfZa6AC8C6ypFRKJQTWm5ZQ@mail.gmail.com>
 <20250429145347.GG1261075@bill-the-cat>
 <CAFLszTjG4-3hjD2c4O7XaCQVheiY050rsVEh1RTyVH7QXYatTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lODj/lOus4wUzWw3"
Content-Disposition: inline
In-Reply-To: <CAFLszTjG4-3hjD2c4O7XaCQVheiY050rsVEh1RTyVH7QXYatTg@mail.gmail.com>
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


--lODj/lOus4wUzWw3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 07:54:11AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 29 Apr 2025 at 08:53, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Apr 29, 2025 at 08:35:24AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 29 Apr 2025 at 07:48, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Apr 29, 2025 at 07:21:57AM -0600, Simon Glass wrote:
> > > >
> > > > > This series moves patman to use asyncio instead of ThreadPoolExec=
utor
> > > > > since it makes it easier to handle requests sent from different p=
arts
> > > > > of the code.
> > > > >
> > > > > It also includes some updates to bring patman in line with the ot=
her
> > > > > major Python tools (buildman and binman).
> > > > >
> > > > > With this series, we have a better basis to add support for synci=
ng more
> > > > > data from a patchwork server.
> > > > >
> > > > > After this, the next step it to add a new 'patman series' subcomm=
and, to
> > > > > track and manage series workflow.
> > > >
> > > > This conflicts with master, please rebase this if you intend for it=
 to
> > > > be merged to mainline.
> > >
> > > I will take a look and see what patches my tree is missing.
> > >
> > > >  And to avoid confusion, while I think managing
> > > > these python projects in this manner (and not AFAICT following pyth=
on
> > > > best practices) makes life harder for everyone else, that is not me
> > > > NAK'ing taking more patches, I continue to be compromising and "Say=
ing
> > > > Yes" to things you do that I disagree with on non-arbitrary technic=
al
> > > > grounds.
> > >
> > > I'm open to managing them in my tree if that helps. For now it seems
> > > like too much work to manage them separately, but if someone wants to
> > > volunteer to help, I could do it.
> >
> > Again, if you won't manage them standalone as seems to be normal best
> > practice,
>=20
> I wonder whether that was intended to throw shade at my approach, but
> if so I'll let it go.
>=20
> Anyway, I don't completely understand the best-practice argument,
> although I am open to it. It is extra work to set up CI, etc, but
> probably not a huge amount. If I get keen one day perhaps I will take
> a look. Just so many things on my plate already, as you know.

I'm the one who approved putting all of these tools in the main
repository initially. And I've griped in public more than once about
Python (not, you, Python) being less than ideal at times due to seeingly
ever-shifting best practices. I however make the "Python best practices"
argument because if we want to attract more developers to help with a
thing, we need to develop the thing following language specific best
practices.

And I honestly believe it would be *less* work for you overall since
there's countless tutorials on setting up all of the automated CI/CD
stuff and you could just put it on public git forge and use their
regular CI/CD flows.

--=20
Tom

--lODj/lOus4wUzWw3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgSMfYACgkQFHw5/5Y0
tyyuNgwAp+WiNViyZCKDwXqbZXW9NwslEuIBkKhvwrUFHzOM6i5OcnGLel7Yxuy2
TLERJYdUFhuzHqheuGAcEalw03yrpN38/SI92g/ApNGXsI4nby4jB4lnV0Unzjy9
Fun05UY3rU8PKUo3H/BLvQ9utWMPNRrq5O7niE1fWG99FYJHW6X1r07Usf3KZSbA
s7px5z97KSe2JoO1X5NXMOKXd8LCbbLKNSTwulrFNtwVA/VubE4jH8Wjs2n/1q9O
CnCEE2zxCvYD7PmZXEIuXu0Q9mUr04tCd/SQLgiKX9Umb8rgtAznNRjlhtrFE8us
fEUb405JKTQTu7agelwmDbKqjiDEN4npthkg3sLTGfyijeqw/sHrJ4HCgoAphN/+
AJzJHAQFPy9RUVXemMC5DX+ioduPNBw/NtoDr5vYRVGlPkA0nkqPB5aLZs2JHLQK
/rCgXseyJmkvTCYAhAZxq7qD5JB+a4M/LAzFaZzuaGp+mcLpiS/vpiEiWf71wS6z
uX0C5bf6
=SZA5
-----END PGP SIGNATURE-----

--lODj/lOus4wUzWw3--
