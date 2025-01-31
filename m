Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65233C0218F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 22:52:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF35280FA4;
	Fri, 31 Jan 2025 23:52:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Fhzx48aK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2894F80FA8; Fri, 31 Jan 2025 23:52:33 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E78C380E90
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 23:52:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7bcf32a6582so226002785a.1
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 14:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738363950; x=1738968750; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JSAe1z0gpjdxymO1pOpECtxiNdplc1rhOHNmuq8HsCI=;
 b=Fhzx48aK1hdWlzfDbFcblfoRZNw/8V2mR7AkLdxSD1MuiYKDL8q1B6jrqegGCI9Is0
 3e6rxInPT59WBBbI1afH68j7iiM5mgWaPsjgiw3NT42kXADzdJWgKnaSO0GBCKtZhbSI
 DoJbIzEg349VwcMh0TmTYu73+sbvEVtXHuZWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738363950; x=1738968750;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JSAe1z0gpjdxymO1pOpECtxiNdplc1rhOHNmuq8HsCI=;
 b=Tfh8WoS7/iQ1AyofGeksfDeTAGj5pCGd0DJcewZwHT3f59TP54QGkSuwxQ7MMNilow
 Pe7gTBgUqT8NSUI5mFjk2lVtDJFqysQlgAxZNYluU4VOu7CWMdjUH3ux4J7zfarqM/FZ
 Mg2NcK8I2sQrCMbVBPQcaewl+j0/iNUbJMo7zsGpcQDQDzMlB0sm+onFD630Gi527AQ9
 lbScHSpzqhzALxUbLR2PZXydwRTE+chnDiYjmXAZ4JyN1g1WOo67lKy1I4+OmLEXEUn9
 a+YImYMV0GNOKy8os1j4viAt607N6moMdx65rQjR29MLxslUED0iLozmri2WBrEk6wRO
 ektw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvcT+qfSHaySNKrkSv6QCgXJ2JGarORp22IWwVp3My06JLeo3Nu7GHhoTfzh+tWJkRJ61LrK8=@lists.denx.de
X-Gm-Message-State: AOJu0YzzOUfTQp7ax5Uw/1QcjLXNs/cR/tPHFuc0A0qOLLjT8II0cwXm
 8tXsKMf725cCTagC9QoMEQozhwQT8i1yWs5wswpZQlYZMp3NF4DopZj3rsOgQTA=
X-Gm-Gg: ASbGncs1FRmsS8oqW7rSBtfYzdfCsVZDrLDbf5FMmD1RrYS4l1pTPXlDg0g+3wV8fib
 0sXVetIclxsdNTvp428o5MbTPwpqX54RbGPIPe07BXwaNtXsCZ+GikM3somis7QcWDBDoSxNCy1
 haYMsWGmCRqh8FwSGtzX0752TG3LgxoC3hV+taMLTTwcsLZmkYQt6kkWweTAlC5ALkpgVYM/KAN
 9rnYOeVOLL4pTdV5Pn5Q77IvmuOdoGJ9cvcWnjdet5l7+6MdVpJl86+mqT22HY7yBj7N7NWLz4Y
 h/pOqUqlWAgQHAo=
X-Google-Smtp-Source: AGHT+IEIYWaekI6cMuHEdShypjLR8cOArgjjaweiBfjpFYl96ymGEkuxpmae6k5TTP2ZVfDnSR7Elg==
X-Received: by 2002:a05:620a:454b:b0:7b6:da2d:73e5 with SMTP id
 af79cd13be357-7bffcd13040mr2101681985a.27.1738363949730; 
 Fri, 31 Jan 2025 14:52:29 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a90cf9csm236992085a.106.2025.01.31.14.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 14:52:28 -0800 (PST)
Date: Fri, 31 Jan 2025 16:52:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: make tests skips the DM tests
Message-ID: <20250131225226.GS1233568@bill-the-cat>
References: <92438c16-1b8b-4e90-a44c-285140f59f0f@gmx.de>
 <e3ed313a-847d-4307-8c58-f40e8fcee86f@gmx.de>
 <CAFLszTiqw1J+0tQT1rDzX8ENGATm46t4MQytCyr7QJL18xG0ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UUiUqISWZ+Am2K8+"
Content-Disposition: inline
In-Reply-To: <CAFLszTiqw1J+0tQT1rDzX8ENGATm46t4MQytCyr7QJL18xG0ug@mail.gmail.com>
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


--UUiUqISWZ+Am2K8+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 12:54:52PM -0700, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Thu, 30 Jan 2025 at 01:32, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
> >
> > On 1/30/25 08:08, Heinrich Schuchardt wrote:
> > > Hello Simon,
> > >
> > > when running 'make tests' locally I get:
> > >
> > > test/py/tests/test_dm.py .
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > short test summary info
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > SKIPPED [2] test/py/conftest.py:625: .config feature "sandbox" enabled
> > > SKIPPED [1] test/py/tests/test_bootstage.py:39: No bootstage environm=
ent
> > > file is defined
> > > SKIPPED [1] test/py/tests/test_cat/test_cat.py:8: Setup failed
> > > SKIPPED [1] test/py/tests/test_dfu.py:114: got empty parameter set
> > > ['env__usb_dev_port'], function test_dfu at /test/py/tests/test_dfu.p=
y:113
> > > !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! _pytest.outcomes.Exit: Lab failure:
> > > Timeout executing 'dm drivers
> > > ': Marking connection bad - no other tests will run
> > > !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
> > >
> > >
> > > Shouldn't the required boardenv_* files be generated by running 'make
> > > tests'?
> > >
> > > Best regards
> > >
> > > Heinrich
> >
> > When installing all packages mentioned in tools/docker/Dockerfile the DM
> > tests are executed.
>=20
> What about test/py/requirements.txt ?
>=20
> Really we should document the packages needed. The doc/build/gcc.rst
> file is supposed to do that, where it says 'Depending on the build
> targets further packages maybe needed'. So perhaps we could add things
> there, and even split out the things needed for tests?

Having been kicking things around a little locally, we really need to
add tools/buildman/requirements.txt and update
tools/buildman/requirements.txt and test/py/requirements.txt, and then
tell people they're expected to use a virtual environment like normal
best practices. Otherwise things just start failing to build left and
right due to missing this-or-that python module.

I started that a little bit today even before getting side-tracked on
the SPI pytest.

--=20
Tom

--UUiUqISWZ+Am2K8+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmedVCIACgkQFHw5/5Y0
tyxWBgv/b2S2zIYDQIeZK5DP0F1lzw8JqowqELMn/FUyDu0hgstxdJf/CxS9VcEb
uXQ0NIH4bFCW83nVm0+7MrNEWkX161neqVrQTqRxJHrCG0pTr+f+szT0PeMNSHB9
C2BjvvdTz3u/PQAJA2n5brCg8JBwyJzJyZ9cVyt90vkzF2ubh+a3tEz2kP1rYTLo
TSulEfmMScT5SEeUY9UV9lWXfwm9rQ4oO4QrL6ac7tarClaBw32Ej2xfW+mYctJ5
BmOeiRtW5MkRd9uHJ/GkJqOi4Y+mkyWOKnnBcE4LDc4/AvZ4RruO1aLdpEFZiUYa
eWa7TJZ6W+fPz64DzQUHXmg+m2wMecL0TTBIm1cFDjU65GpzRz2gD+/gu3NOpIXy
xXNItwm/fkbs/lv1zcdxsygnjrdVsr9hVnq9z19LOzCIensF4mo7GZRqPDfpp0kh
H5No7KwRDqX5rMaThJNd/6Vos8WOqvNA4yzsizD6T+c4ohiCSFnztvZC3RR5ZF1C
WzZaPVSu
=DDWq
-----END PGP SIGNATURE-----

--UUiUqISWZ+Am2K8+--
