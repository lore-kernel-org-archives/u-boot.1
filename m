Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A790C021AA
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 17:52:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAF8780C7E;
	Mon, 17 Feb 2025 18:52:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YR6pD4eK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 411C880C8F; Mon, 17 Feb 2025 18:52:34 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF0058083C
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 18:52:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-220e6028214so74272415ad.0
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 09:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739814750; x=1740419550; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=T43EAnpEr4cvzo5l3D7+mCncE4XmtcpNO2V3sYInGZ0=;
 b=YR6pD4eK+/X9ayjzwPIE1bLLGfF/dINr3IvqNn+4dN7w0zQtcIlFwqSLGZdFaKE8G/
 QeuMLGSBcte+pTzAl8flo0OqmCnOxYmLlb5Je+34sp53DO9yQpXc6zrZAj6z7eNdEO/u
 ohm4xve4eHxI2tf+PHWFyFJ3ties6xuPdig1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739814750; x=1740419550;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T43EAnpEr4cvzo5l3D7+mCncE4XmtcpNO2V3sYInGZ0=;
 b=iPyAkW149imh69ggudWIHh5LYtDgk8zerhaVAjV89xV0PT/nvnJ92K86tlxbEbFgjT
 2KYUUxBf0ZhEtgXsmM+bxZrQJGX51zjQy/RTzC5uyNhirsIrtvPCW7BQBxT5x0q/9m5V
 VuYeUMImssjlJbA1AfXaxoQKzkgb1ZzmQ4CaczTuaL1YHCppbIFMMkStF8YwiklWpT5P
 5ELBUTFCJaVyz/O5SRBvjYkGBliugbxmrnf4cEkVtxyHGGH/A/QLlAciMZ14HwzDkw+L
 H6vauJchBjSOpGMH4l3Y+X4RslSpvY+Lke/T4E4ktc+mKL3PLHdVwmD9LUNiwL2WIz9p
 C8fg==
X-Gm-Message-State: AOJu0YwRZNYF3UCVHyoyg7wyv9K/+kjqvC+hVWsSn8BNaw4p3v1xqqgk
 aD/ST2NFZHul+zu3RS+qBBUmxd5VHirguZf6Tb2RdRKf/N3twCfWTWTzBM/fafg=
X-Gm-Gg: ASbGncvsicWdrsFP1/HtfWnXURI13GVfM1eVbYwfUf6AQOsixbJ6A9tsNN7voi1oo8k
 WDI2pVi3djsXjphPD9r7JyZtmiugmXaHFPTKRaUgZ7fNqzQx5QVoPQMPlwCa1QUHFeBNmoX3FeH
 VwwkIuTB5XqH/+Sr7Yq0BrhoN7J5gJP7RFTfdZp+bl4AMhFP9FsCWgwk1qnDMqzzgLUpJvRXZjX
 SDG1P9pdLAy1LKD7bpT52110UqlgF9qp6lFVoguy6pMhgQ1Zg5VARL1NAGqvqz5BeKpz+a9Pw7K
 VbYuZ7MSGTLFXQ==
X-Google-Smtp-Source: AGHT+IF8SJch2JogKzyoWPN0bgC7z9bZ0+lpajh2f3CCyKHdoDJvRNnNvm83DdNG7ZpZjfQOms43Uw==
X-Received: by 2002:a05:6a20:e30b:b0:1e0:d837:c929 with SMTP id
 adf61e73a8af0-1ee8cb0e8d5mr17475863637.9.1739814750315; 
 Mon, 17 Feb 2025 09:52:30 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324275bd28sm8362229b3a.122.2025.02.17.09.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 09:52:29 -0800 (PST)
Date: Mon, 17 Feb 2025 11:52:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v2 5/6] test/py: Show info about module-loading
Message-ID: <20250217175227.GS1233568@bill-the-cat>
References: <20250209160725.1054845-1-sjg@chromium.org>
 <20250209160725.1054845-6-sjg@chromium.org>
 <20250210155252.GL1233568@bill-the-cat>
 <CAFLszTh=AuLyxUhpR5FbWbvS6xkwnnhA1Hf-nuMd+7=wOZZyNg@mail.gmail.com>
 <20250215144856.GO1233568@bill-the-cat>
 <CAFLszThWr3z_GHp1vbubgKdX4hrW4vafetA=VzGpiZ5-K0+cyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LKDo2DzTvpdi5Hm+"
Content-Disposition: inline
In-Reply-To: <CAFLszThWr3z_GHp1vbubgKdX4hrW4vafetA=VzGpiZ5-K0+cyw@mail.gmail.com>
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


--LKDo2DzTvpdi5Hm+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 10:21:43AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 15 Feb 2025 at 07:49, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Feb 15, 2025 at 05:17:48AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 10 Feb 2025 at 08:52, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sun, Feb 09, 2025 at 09:07:18AM -0700, Simon Glass wrote:
> > > >
> > > > > It is sometimes tricky to figure out what modules test.py is load=
ing
> > > > > when it starts up. The result can be a silent failure with no clu=
e as to
> > > > > what when wrong.
> > > > >
> > > > > Add a section which lists the modules loaded as well as those not
> > > > > found.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > (no changes since v1)
> > > > >
> > > > >  test/py/conftest.py | 33 ++++++++++++++++++++-------------
> > > > >  1 file changed, 20 insertions(+), 13 deletions(-)
> > > > >
> > > > > diff --git a/test/py/conftest.py b/test/py/conftest.py
> > > > > index 8d0e786ee5c..e59897c1f78 100644
> > > > > --- a/test/py/conftest.py
> > > > > +++ b/test/py/conftest.py
> > > > > @@ -289,19 +289,26 @@ def pytest_configure(config):
> > > > >      ubconfig =3D ArbitraryAttributeContainer()
> > > > >      ubconfig.brd =3D dict()
> > > > >      ubconfig.env =3D dict()
> > > > > -
> > > > > -    modules =3D [
> > > > > -        (ubconfig.brd, 'u_boot_board_' + board_type_filename),
> > > > > -        (ubconfig.env, 'u_boot_boardenv_' + board_type_filename),
> > > > > -        (ubconfig.env, 'u_boot_boardenv_' + board_type_filename =
+ '_' +
> > > > > -            board_identity_filename),
> > > > > -    ]
> > > > > -    for (dict_to_fill, module_name) in modules:
> > > > > -        try:
> > > > > -            module =3D __import__(module_name)
> > > > > -        except ImportError:
> > > > > -            continue
> > > > > -        dict_to_fill.update(module.__dict__)
> > > > > +    not_found =3D []
> > > > > +
> > > > > +    with log.section('Loading lab modules', 'load_modules'):
> > > > > +        modules =3D [
> > > > > +            (ubconfig.brd, 'u_boot_board_' + board_type_filename=
),
> > > > > +            (ubconfig.env, 'u_boot_boardenv_' + board_type_filen=
ame),
> > > > > +            (ubconfig.env, 'u_boot_boardenv_' + board_type_filen=
ame + '_' +
> > > > > +                board_identity_filename),
> > > > > +        ]
> > > > > +        for (dict_to_fill, module_name) in modules:
> > > > > +            try:
> > > > > +                module =3D __import__(module_name)
> > > > > +            except ImportError:
> > > > > +                not_found.append(module_name)
> > > > > +                continue
> > > > > +            dict_to_fill.update(module.__dict__)
> > > > > +            log.info(f"Loaded {module}")
> > > > > +
> > > > > +        if not_found:
> > > > > +            log.warning(f"Failed to find modules: {' '.join(not_=
found)}")
> > > >
> > > > Since no platform contains all of those files this is too verbose.
> > >
> > > So perhaps only show the message if all files are missing?
> >
> > Sure. Or a log.debug maybe?
>=20
> The log.debug() doesn't show up though and people wouldn't know where
> to look. So if you are OK with having the message only if there is
> nothing, I will do that.

Sure.

--=20
Tom

--LKDo2DzTvpdi5Hm+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmezd1sACgkQFHw5/5Y0
tyz5RAv/ep59coXyb9lK0+szoEEjFMl4JFuwxD8sUW++JTFITc5Z72PjIkNhS/lC
pdU0sYQKKBSgzW0gRs5zEjOz1ttjYl1eVfCs4su5FqYYVIAbD9BpGr9bv3lZ0bvq
P3/TxV15ypnZGVY/uvifiibHw7EQRSI7Sl7vdTnzz1aAccRlJT9IP+Fo4pQrVDd3
yePpCJ0d0n/8lnFMgVgNQwTGt+JdNsYF5GxmFxdC9Qpzf5iI1/PbkBneCHnEVGsg
URKIr0GeuKSOudLb6LCAbFp6XJlUuttqMh5Xird3tU3BtHEHbKyYVJR+/SyL2R4P
fz//9DFsDg4jwHoCdEmN9xDHWrM1tbA+j+HSIqrJLP+JLvU9auke+AOfclzfabpk
uDexFfWiU7I0EAYV6sKOW9tkTDClhdVQ88RAvYLFeT0vk0elMOp5FfZivmdp0xxm
feLkBI31zdhjQrmb8+4MfnQvvq/T73Xeq7LKK52CkVjn1wSROJOxZsz0RjpoHeuW
1ang+5Gz
=3Xxi
-----END PGP SIGNATURE-----

--LKDo2DzTvpdi5Hm+--
