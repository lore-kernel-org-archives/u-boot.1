Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642F9C072A2
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 02:07:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0CBE8718C;
	Thu, 16 Nov 2023 03:07:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hRje17z9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 611F486D9A; Thu, 16 Nov 2023 03:07:20 +0100 (CET)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com
 [IPv6:2607:f8b0:4864:20::92e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCCA387447
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 03:07:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-7bb3e55c120so125790241.0
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 18:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700100433; x=1700705233; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=n7UfBu7gyjzavrcyDyhHtKGlq6nr0hBX6Yqo16B77Yc=;
 b=hRje17z9V/V0Uw6z3g7ZrTCUwW9xj3FRtCFMUDWe+/aNN5Rd81RMuj4LoJAujG39xw
 Jy3NT0jFbHMbIe7VuW8PL8O8ubie/ZMEgBP/8laYYqeueFUE0c3BLSrwzmylbsHdYqdP
 w1Z+rC2Auqr2JGH8Dn//R1oKyU3OpmADV4ZXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700100433; x=1700705233;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n7UfBu7gyjzavrcyDyhHtKGlq6nr0hBX6Yqo16B77Yc=;
 b=Hj9aWZHNrRNrPsXclzWoyLmVFwCFhJoJqvtt+SrJJGSmjMJa+yW9vLReTUlfmCcdLu
 b0/paYfhuzaGEjJZ41NXy8sSvV6glWFiXW0rTLO4LL8us5R40nj8IqQIth0G7GejMsBW
 uHQqZ7g0xoHQ6o7n4NCeJuchNbbpsOKp8vMlXm1n8EyvqqeelvPt8lyrSfCeM7qAHBky
 ok3QAWXf8ti57Ia4yOV41KAQL8zeniWTJY6f+GGn6F6Iz99q5if5jfAV1H7j5N1tfpFo
 YrQUJlWJKlmfQ6Q276YntUHWE0vnv/E67yk8p0zuU3Sb3jeUAkR1f8QPyTrFbncjwWT6
 CVBg==
X-Gm-Message-State: AOJu0YzDSsPAbIxVAP1/WZ43IsXTs/AqgSaei+Z3OdV+kH45KHGf3uM+
 6dU2In23nTE3wHl9XbUe+ZBH+w==
X-Google-Smtp-Source: AGHT+IFUgHpuh6LCExCNXgP3R+PKEWpV3RJZkLMMDatgE1Xp8BVN+nsQtTFjV+gEM0VpWLp4IhvQhg==
X-Received: by 2002:a67:c089:0:b0:462:71bd:b244 with SMTP id
 x9-20020a67c089000000b0046271bdb244mr447836vsi.18.1700100433384; 
 Wed, 15 Nov 2023 18:07:13 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 y1-20020a0ce801000000b0063c71b62239sm1007432qvn.42.2023.11.15.18.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 18:07:12 -0800 (PST)
Date: Wed, 15 Nov 2023 21:07:10 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH 27/29] bootm: Adjust the parameters of bootm_find_images()
Message-ID: <20231116020710.GJ6601@bill-the-cat>
References: <20231112000923.73568-1-sjg@chromium.org>
 <20231112000923.73568-28-sjg@chromium.org>
 <20231115223800.GE6601@bill-the-cat>
 <CAPnjgZ379WFHcrVUYPTGZqhUvA95aaDKdfiqNGBOXt4hBrWrKQ@mail.gmail.com>
 <20231116014707.GI6601@bill-the-cat>
 <CAPnjgZ1v+ciAZGKgkgF3M1tzTdpFEMLJfj-xVQMLWpdmgYPzAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LN2bvKdguIo/fhQA"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1v+ciAZGKgkgF3M1tzTdpFEMLJfj-xVQMLWpdmgYPzAw@mail.gmail.com>
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


--LN2bvKdguIo/fhQA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 06:56:33PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 15 Nov 2023 at 18:47, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Nov 15, 2023 at 06:42:19PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 15 Nov 2023 at 15:38, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, Nov 11, 2023 at 05:09:12PM -0700, Simon Glass wrote:
> > > >
> > > > > Rather than passing it all the command-line args, pass in the pie=
ces
> > > > > that it needs. These are the image address, the ramdisk address/n=
ame
> > > > > and the FDT address/name.
> > > > >
> > > > > Ultimately this will allow usage of this function without being c=
alled
> > > > > from the command line.
> > > >
> > > > OK, so this goal is good.
> > > >
> > > > [snip]
> > > > > +             return bootm_find_images(img_addr, argc > 1 ? argv[=
1] : NULL,
> > > > > +                                      argc > 2 ? argv[2] : NULL,=
 0, 0);
> > > >
> > > > That we repeat this much harder to read test/if/else three times no=
w is
> > > > less good.  Can we find some way to hide the complexity here in the=
 case
> > > > where it's coming from a command and so we have argc/argv[] ?
> > >
> > > I can't really think of one. Ultimately this is coming from the fact
> > > that the booti and bootz commands directly call bootm_find_images(). I
> > > haven't got far enough to know whether that will still be true in the
> > > end, but I hope not.
> > >
> > > IMO the correct place for the logic above is in the command-processing
> > > code, where it decides which arg means what.
> > >
> > > I could imagine something like:
> > >
> > > static const char *cmd_get_arg(int argc, char *const argv[], int argn=
um)
> > > {
> > >    return argc > argnum ? argv[argnum] : NULL;
> > > }
> > >
> > > but I'm not sure that is an improvement.
> >
> > I was thinking about this more after I sent this. And I think we might
> > indeed want an inline / macro to handle this case more generally as I
> > suspect we'll have similar cases where we need argN-or-NULL as we
> > refactor other areas of code to split "here is the command" from "here
> > is the library functionality" of it. Then we'll have:
> > ulong foo =3D cmd_arg_one(argc, argv);
> > ulong bar =3D cmd_arg_two(argc, argv);
> >
> > librarycall(foo, bar, ...);
>=20
> OK I can try something. But note that the one, two terminology becomes
> confusing. Is the first argument zero or one? Also we often drop an
> argument in a subcommand to allow things to start from 0 again.
>=20
> It might be better to use first and second, instead?

Yes, please come up with a better naming scheme, I'm terrible about
stuff like that.

--=20
Tom

--LN2bvKdguIo/fhQA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVVeUsACgkQFHw5/5Y0
tyxwLQv+JOVireRseiYWpuMFRMWDh+N531DD0gWkhE7rOOjKWPXgYOjHBDhhNwG8
XIsftzaG+Re0pm0Drvs/wvRj0BOa+Gl9mm/Jr5p1I0UG7HuKP9PzMjNJMPNDkVU7
nAU7GqQZWz7S+JownoK/SUpt17kwYnFJLoHEFNi7nfksBKTIvvNxfJlzgjFCK/eV
FLHoYGqwG3+WAaOVYOtqgcqyDSnKR9wRpEf/1IVn0AeXPphXsdb4a8l/5Od3hgtr
J2SMnAvSh1mJ2Hc7XOAg66BkMMyaLiks/rlpKGv6NxiCT6Y7fit84Tz2JAdSWTI5
au573Gb2zkyiMLl5LEiwCngdOS9stgc7Cj2XJbqUcCxQ0Xxhy61DCymkudwqISyx
UTBjjXTLQd1+9JHmsUp+Tfk7gn0e4xtfuWQZoevP2FLKxS9j4sWhsYYIX/Xue6Dm
AKhVSwdn5P3yaHjURqH2xKSwmt+mpDByhnAFDp/Qs3z78gab2fs08nM0dbPW7Exj
wlLCEmVH
=mRrT
-----END PGP SIGNATURE-----

--LN2bvKdguIo/fhQA--
