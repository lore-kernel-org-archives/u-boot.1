Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC18C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 14:49:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9797080C6F;
	Sat, 15 Feb 2025 15:49:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jPI707pw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 898AD80EAF; Sat, 15 Feb 2025 15:49:03 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 355CE80756
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 15:49:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6fb2a0e4125so23016887b3.1
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 06:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739630940; x=1740235740; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=olVATQI74TG3X7SacnWqPxn1C/n/XJhlboEFrnrRSvM=;
 b=jPI707pw77ikIUAD2ssXzk6Y9L69Qt3elMEa+ZcdxenE1spxgc9OAgy51EC2jxrcMn
 XcUXszRYRuYpupICEVxXY72rQyPb/rL+aAx4petQJqVIDiNCIwZM/5DPbApqb2I23qax
 5mWSsvZ7MmSMUNhE2J08DSQbpOP2pqi4U7iCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739630940; x=1740235740;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=olVATQI74TG3X7SacnWqPxn1C/n/XJhlboEFrnrRSvM=;
 b=dmOSL3Wp/r1GL/2W2PlH1zM0ua8waoPzIS1W+7g8ZzhmP1VvHm82dtZ5zYB9oTDnjj
 +Fu4WVV+dD49jhT6lje2AChBCvqPmFvzlQcDGkczce9vJY4suqQrrv9TiWU7VLWmcj+M
 7dRGUBIw/faJmp32Fyp9ekW1GiXhN48DNYIjdMtVJV/4Yvs0pxxxVBjFsu6iOJcV7i9H
 0OYZSHjTly2D9MN2juwAxhm4RR7SxNGlRF/jDGXkeVpBs6YnDQaKt4EMh/H75QCnnLXv
 ofZLXVdxlsrYnetq8rGx3m+REA/h7cZqQyXcW3WcAtHpRL19mkj9wtFUpyIg4EAHvf0v
 G20g==
X-Gm-Message-State: AOJu0Yzk8uDBytbaz9RPDeVPzatW78oahWDbha+yWLeJnZYL6bSAbsCC
 h1+UClGyrcMw7BepcxV1xouvnA9z8BYJ++Wdi+dC2MhBM2s9M0JzdJcW1HAg8JKjIbtJMDvaZcB
 g3JY=
X-Gm-Gg: ASbGncsEEFXcirn6XReMEbMQUT1v//sh0bMWr6+67sS5tJEVZlScR1dDfs5wzXP6Fcx
 /jexrkQIKIpL3F+EUz0o/IvvpPNW9Pt5kAemybeMkqpviY09C/CSX2joyZgue7dVFV4pEAkjGDC
 iWxqFNakg1fMtH5l7m5Q/iRXoERm/izR8Ors3FRyDZzY3EwUztcWwGDqRMPhTj2sIbQAerdGSOw
 kRKTYHPI2a01sMnOUzqhsM+QK0SqsftVNRM51TaNwgjr4Ubq0KH7QadrMW2z5vrK5cDSTXoWNlQ
 pA4El0KAgphrAw==
X-Google-Smtp-Source: AGHT+IFfMYwPxl2Pl+tWR+jRXN6D9JKJzo6tyTkfI2ll+LUqllFolr05AIHZz0769aD5fCwRedUH2w==
X-Received: by 2002:a05:690c:6412:b0:6f9:8d47:35b8 with SMTP id
 00721157ae682-6fb5827e598mr30703337b3.13.1739630940021; 
 Sat, 15 Feb 2025 06:49:00 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fb35d58b94sm12446347b3.18.2025.02.15.06.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 06:48:58 -0800 (PST)
Date: Sat, 15 Feb 2025 08:48:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v2 5/6] test/py: Show info about module-loading
Message-ID: <20250215144856.GO1233568@bill-the-cat>
References: <20250209160725.1054845-1-sjg@chromium.org>
 <20250209160725.1054845-6-sjg@chromium.org>
 <20250210155252.GL1233568@bill-the-cat>
 <CAFLszTh=AuLyxUhpR5FbWbvS6xkwnnhA1Hf-nuMd+7=wOZZyNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lTEUFTal5u8k8q9N"
Content-Disposition: inline
In-Reply-To: <CAFLszTh=AuLyxUhpR5FbWbvS6xkwnnhA1Hf-nuMd+7=wOZZyNg@mail.gmail.com>
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


--lTEUFTal5u8k8q9N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 05:17:48AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 10 Feb 2025 at 08:52, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Feb 09, 2025 at 09:07:18AM -0700, Simon Glass wrote:
> >
> > > It is sometimes tricky to figure out what modules test.py is loading
> > > when it starts up. The result can be a silent failure with no clue as=
 to
> > > what when wrong.
> > >
> > > Add a section which lists the modules loaded as well as those not
> > > found.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  test/py/conftest.py | 33 ++++++++++++++++++++-------------
> > >  1 file changed, 20 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/test/py/conftest.py b/test/py/conftest.py
> > > index 8d0e786ee5c..e59897c1f78 100644
> > > --- a/test/py/conftest.py
> > > +++ b/test/py/conftest.py
> > > @@ -289,19 +289,26 @@ def pytest_configure(config):
> > >      ubconfig =3D ArbitraryAttributeContainer()
> > >      ubconfig.brd =3D dict()
> > >      ubconfig.env =3D dict()
> > > -
> > > -    modules =3D [
> > > -        (ubconfig.brd, 'u_boot_board_' + board_type_filename),
> > > -        (ubconfig.env, 'u_boot_boardenv_' + board_type_filename),
> > > -        (ubconfig.env, 'u_boot_boardenv_' + board_type_filename + '_=
' +
> > > -            board_identity_filename),
> > > -    ]
> > > -    for (dict_to_fill, module_name) in modules:
> > > -        try:
> > > -            module =3D __import__(module_name)
> > > -        except ImportError:
> > > -            continue
> > > -        dict_to_fill.update(module.__dict__)
> > > +    not_found =3D []
> > > +
> > > +    with log.section('Loading lab modules', 'load_modules'):
> > > +        modules =3D [
> > > +            (ubconfig.brd, 'u_boot_board_' + board_type_filename),
> > > +            (ubconfig.env, 'u_boot_boardenv_' + board_type_filename),
> > > +            (ubconfig.env, 'u_boot_boardenv_' + board_type_filename =
+ '_' +
> > > +                board_identity_filename),
> > > +        ]
> > > +        for (dict_to_fill, module_name) in modules:
> > > +            try:
> > > +                module =3D __import__(module_name)
> > > +            except ImportError:
> > > +                not_found.append(module_name)
> > > +                continue
> > > +            dict_to_fill.update(module.__dict__)
> > > +            log.info(f"Loaded {module}")
> > > +
> > > +        if not_found:
> > > +            log.warning(f"Failed to find modules: {' '.join(not_foun=
d)}")
> >
> > Since no platform contains all of those files this is too verbose.
>=20
> So perhaps only show the message if all files are missing?

Sure. Or a log.debug maybe?

--=20
Tom

--lTEUFTal5u8k8q9N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmewqVgACgkQFHw5/5Y0
tyzdEwv+O/DM9KpghyH3/8X1MkfVHdFtbSnGpAOLmAXtsDPftFyq8ve9KEPI4B/u
CHGSrTT3oekCeLM3OVkA+RGacqPVDIz98gxkNn7YxVKJfZK+fR2+SeIaa36aAGNe
rtlSex9BrhNb4AnxAMcp2QWeAsEOTK1RjU9uW6TpwFC4BAeIxeSN7GycU7haRL7/
vHQnf31zN6KlhCh7VvUFhhlVZVAuucdlMoqEBoM/QD4Ad6fKGmDon4RKq1//93+f
FeFbGJAEyCkr2A4LmeRy0GvvKKTcE6tzR8/7aWBb7lhWav+Y3VngrsVI0332olX5
3Kw3VcHQi/8NuV4ijS5wkFgUP/eGfpcoRrCPVzplyG0eqp0oZ1oL6Zt+N1RWyTdR
vrqSDC6zqJ5H0WTADbDERw9GkgqYmKEQfCMYxiurjUg7WBbS1KalP60shRoOuHz0
kfFmmTmAVGzk/FhiV1mNyiQX4NqL8SGJcA4BOvgs29Fmrp+S5tRod2H6wpyUQotN
9rSRpg/P
=Gkrh
-----END PGP SIGNATURE-----

--lTEUFTal5u8k8q9N--
