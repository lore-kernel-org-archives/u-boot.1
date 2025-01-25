Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955C9C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 23:02:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3383180F10;
	Sun, 26 Jan 2025 00:02:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c82+G/B1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 777A680EF4; Sun, 26 Jan 2025 00:02:07 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42FDB80F53
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 00:02:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6d8e773ad77so27972006d6.2
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 15:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737846124; x=1738450924; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aPqH/7nld7YwPB7Wb02EqlKcvgfChyH3ZmSgG2oXFUU=;
 b=c82+G/B1l7uowZc0raPFXCPXebKso9EhWN0MwhBOqfiki5pexSBWGBKlCbUAsAIReN
 6BKARbtXdYfEHYtm/dILUnRrGzoDq9DuJRpSydHetR4AbhXm3yTIuozpXnPhj3oc29Dm
 rVLJSMTzI8MERt23QtpN/SE+70UH1nU9Bw9I8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737846124; x=1738450924;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aPqH/7nld7YwPB7Wb02EqlKcvgfChyH3ZmSgG2oXFUU=;
 b=qRSZ3Jkcg0/mwpKrpdh4F0OzvKJkHY/upxJmBZU5NnyRqY2o/5UjdpluRYwmpfQqAR
 avmyqu5Z67/FE3rubsWt5EXpRX8OHEKTKrfFqYGus/5NoqXfsrUqiyCjgEoXiNH4QOig
 UWy3H1fxlxhe7UohmJzj78PStYD1oKNIwXsqRaz4VQ2+YFQ2dcqFs1gawEsFB3TdHUpy
 hXhVxNJk+T34qIPS+1oGCDmGyTFrVa8TnPCnUl9mJqwifXKbih7cXxU1vOFsaT7SMn8b
 2MxDb0bhxjL8ZhZcqpMKtDbsuNs1XPa4PJXtrOwjF/rxLs6AZXaO2CU/wLK2tqnALXxu
 I/pQ==
X-Gm-Message-State: AOJu0Yx6nR3R2KuGP1NST3RtZVsr0K8Utk1UhZbv0HG92lCrSmy/BbHy
 zWDWCN/b8MweUPjn9nd0TpbGUifEMV0hW4ZUaIEu1DrNTBqsWGMEhne2CPvG878=
X-Gm-Gg: ASbGncvpEJaEOQkL/y+aYIL7qtOxyURHGLNgSe5jSw+HOKsWjPGLn4xS17WvS/AGn4q
 cPopfmFdFQYfRbGToUoSvSDlfL8ZV+n2zrgDoLFbTU8eXQN+le8PPKjUlMrWNL4DpE2SWyfXGaw
 +pP5+yYew+7xTsSbUplxnxrIiBg4/ysPn6OVC4DB8cuupD6BgATTygm9viB2KM7ZInprX0W3+k2
 E14VeYik/HyZaF3Hu6kijWRtR/DOXfqVDF55GdhAWjJJQhLlTdjAKcxdCDqc7A63QTQMyITfFUy
 pMGvx2oobbkhC48=
X-Google-Smtp-Source: AGHT+IG/hFHRL4HhmdZIaYjwcPXZu4xhH1A1Wk0fXaHEapcfy+sbSZ5wyN16IEYJpaH1uZQ1IAuq2Q==
X-Received: by 2002:a05:6214:1306:b0:6cb:e648:863e with SMTP id
 6a1803df08f44-6e1b2235398mr518973076d6.43.1737846124040; 
 Sat, 25 Jan 2025 15:02:04 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e205ac44e4sm21197526d6.124.2025.01.25.15.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 15:02:02 -0800 (PST)
Date: Sat, 25 Jan 2025 17:02:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 3/4] test/py: Show info about module-loading
Message-ID: <20250125230200.GM60249@bill-the-cat>
References: <20250125213150.1608395-1-sjg@chromium.org>
 <20250125213150.1608395-4-sjg@chromium.org>
 <20250125214317.GC60249@bill-the-cat>
 <CAFLszTg+ZFn55j31CZMisvjg-e25R+q57pW-Dt-6zFqjSVwwtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mMKNHhC0WxJB8VAj"
Content-Disposition: inline
In-Reply-To: <CAFLszTg+ZFn55j31CZMisvjg-e25R+q57pW-Dt-6zFqjSVwwtw@mail.gmail.com>
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


--mMKNHhC0WxJB8VAj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 04:00:05PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 25 Jan 2025 at 14:43, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Jan 25, 2025 at 02:31:38PM -0700, Simon Glass wrote:
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
> > >  test/py/conftest.py | 33 ++++++++++++++++++++-------------
> > >  1 file changed, 20 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/test/py/conftest.py b/test/py/conftest.py
> > > index 5096c20ed65..23435b7db3c 100644
> > > --- a/test/py/conftest.py
> > > +++ b/test/py/conftest.py
> > > @@ -286,19 +286,26 @@ def pytest_configure(config):
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
> > >
> > >      ubconfig.buildconfig =3D dict()
> >
> > We won't see this warning normally, only if some level of verbosity is
> > used, yes? It's normal to not have both u_boot_boardenv files for
> > example.
>=20
> There is a '[-] Section: Loading lab modules' section so you only see
> it if you open that.
>=20
> I feel that test.py is a bit cryptic at present.

I don't follow you, sorry. Open what where?

--=20
Tom

--mMKNHhC0WxJB8VAj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeVbWgACgkQFHw5/5Y0
tyz2aAwApc6L9SlKQ3BWiG+RIoG+RV8/b4XXRpBoz77/p/EV1a2433EYwgu02yjW
UVUdbg5jfXdYVzEC3c/1cqzCUB0n3Zucfl/k7XoBl2pioi0HAlSsNP9RmF9l0xQ/
0JpFa4lpfXv5P0wG91uAyq5lo++hnxloummWjr4pnfYzhmmyul/weiNiClVx2OOp
iB5XTAbzSlQWj9oCbX1iKv+CimUGOp7KY40Y2shHU6XeA+2bFANPGNDrChM1yVpv
4s9WeQt5IxmGjzdkU32csGAnkkxiMMFIKgYdnUT56vh9z17Q104ENww0B69Kcavs
3+AAp7sigeYRNccaK9rjp8vRJmeE5nOvyC4b5bo8MO7zqRH6IadRTiKuAp7pl+4N
ep+b9PraKwXo/Hl0sUCVhP01+kTJ7tSzml9Fv3LpQNkZQSl3bLb95LqDIWIBSWP1
w1DhJR7ZxxrH4slLXOT6lW/LjVBGy+RZjNtI0NE7D/KsYrhHh6k4AQmH20w5RRC4
WtL7mXD7
=Nd/6
-----END PGP SIGNATURE-----

--mMKNHhC0WxJB8VAj--
