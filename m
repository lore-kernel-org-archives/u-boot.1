Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA38C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 23:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88C3680F4B;
	Sun, 26 Jan 2025 00:53:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qHSVMISU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A63A480F56; Sun, 26 Jan 2025 00:53:09 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08C2180EF4
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 00:53:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6d8a3e99e32so31355716d6.2
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 15:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737849186; x=1738453986; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=B5LJE7+3qEg8rB9k52/UAI+A/hIuJKcgG8YAC6NgwW0=;
 b=qHSVMISUusKrZrAwPteIeRhV8tJcc7zqrNbObE7/FS0jxtGVVNLmTP7hZG+wngfB5W
 V7IZLO7/xVo2KI1lOXlLO6hOlF76swB7PvrGH1M1vIwOKZ717QcyjwmWhX/xldXTASkM
 8wzVPwOlpZvr3nmMZtkRwGBav6b1yLOLW+Jbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737849186; x=1738453986;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B5LJE7+3qEg8rB9k52/UAI+A/hIuJKcgG8YAC6NgwW0=;
 b=HAUJh3F8vRc7lQkZcJg2wmoobqYsOGHgadtYOHiQEJIOnNC6vWIGHMARAZ2rIKjBCy
 CMIRZLrLg8A30TfSXc2+NK+BkGczarlHRzVgnSVMqLogCGPQYeisBpThI0Lys8NgqpPh
 1HwFLDrNtQEPf8KT4LVHiaD1ykUzyuubzn9tfmW32CN6OcxailACAT6/TI0wotSF21QC
 aBpQY56rE03wQcZh8GiVcRqeThUFtsdL8ooWWmRwc/WFwC9FP2CXi9phKE41ys6ppUcf
 YgItfdXjIwTfjBZzlw7W+N9QevTmBu2QUy8ZUuuiDoIFvrBW1vDtep7zMjVYaXTLz3vy
 S14Q==
X-Gm-Message-State: AOJu0YwzArNFpEbLSgWsAmPIC5CNfq+EBzc9k0TX198fZ3IwcXOJVCd4
 YuvJIiqL9Gx5i0vGnGTn4L2gTQbRJSLi9TGF9gowi06vv6CJIDiYo23+3fxsKHg=
X-Gm-Gg: ASbGncs2pMAeJe2IceRfKM7ujmfN5//BUMqQKg8kc8Kw01UltX2WERo0F+bIWxQ0vci
 Hrx5oOKZtihf/7UttlDb2Cbd/L9ITnEHnVuOM2SkVYu4dOtROYS306xMFoD/YwFhIh4RaPOMgod
 muskTCUCUG20wvuyAWmzkRf3NAfxGgDmTuAATuYHOdaXLOTFu9zfJY5SlazsBRfJ9ZRCMrETXFE
 O8I9OcgwIB8EQ6bhwmB7DFiw/VE1uLv+Gu0pKtMzrMVqvDOmDrIHxkP0N+g5eW4TZzvZMk5Uz/Q
 I2fB
X-Google-Smtp-Source: AGHT+IF5+MhbnX/IK46uBvrwpoTj1cN6wngon2fz3gm5bBFXiVPe2SvmIDuPfvGyXVqKqypOYppRsQ==
X-Received: by 2002:a05:6214:2aa8:b0:6d8:aeda:dd93 with SMTP id
 6a1803df08f44-6e1b2235d20mr560793086d6.39.1737849185876; 
 Sat, 25 Jan 2025 15:53:05 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e20514f198sm21549856d6.41.2025.01.25.15.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 15:53:04 -0800 (PST)
Date: Sat, 25 Jan 2025 17:53:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 3/4] test/py: Show info about module-loading
Message-ID: <20250125235301.GP60249@bill-the-cat>
References: <20250125213150.1608395-1-sjg@chromium.org>
 <20250125213150.1608395-4-sjg@chromium.org>
 <20250125214317.GC60249@bill-the-cat>
 <CAFLszTg+ZFn55j31CZMisvjg-e25R+q57pW-Dt-6zFqjSVwwtw@mail.gmail.com>
 <20250125230200.GM60249@bill-the-cat>
 <CAFLszTiyE+9x+dRxznic__y1P2XDcFFiMn1_9w5HqF_v3AQHMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rKH8g+81lQHJ+ttu"
Content-Disposition: inline
In-Reply-To: <CAFLszTiyE+9x+dRxznic__y1P2XDcFFiMn1_9w5HqF_v3AQHMA@mail.gmail.com>
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


--rKH8g+81lQHJ+ttu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 04:39:19PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 25 Jan 2025 at 16:02, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Jan 25, 2025 at 04:00:05PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sat, 25 Jan 2025 at 14:43, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, Jan 25, 2025 at 02:31:38PM -0700, Simon Glass wrote:
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
> > > > >  test/py/conftest.py | 33 ++++++++++++++++++++-------------
> > > > >  1 file changed, 20 insertions(+), 13 deletions(-)
> > > > >
> > > > > diff --git a/test/py/conftest.py b/test/py/conftest.py
> > > > > index 5096c20ed65..23435b7db3c 100644
> > > > > --- a/test/py/conftest.py
> > > > > +++ b/test/py/conftest.py
> > > > > @@ -286,19 +286,26 @@ def pytest_configure(config):
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
> > > > >
> > > > >      ubconfig.buildconfig =3D dict()
> > > >
> > > > We won't see this warning normally, only if some level of verbosity=
 is
> > > > used, yes? It's normal to not have both u_boot_boardenv files for
> > > > example.
> > >
> > > There is a '[-] Section: Loading lab modules' section so you only see
> > > it if you open that.
> > >
> > > I feel that test.py is a bit cryptic at present.
> >
> > I don't follow you, sorry. Open what where?
>=20
> I mean that the section is collapsed unless you click to open it (when
> viewed in a web browser).

Oh, right,
https://u-boot.source-pages.denx.de/-/u-boot/-/jobs/1005206/artifacts/test-=
log.html
and similar. Yes, anything you want to improve to that part is fine with
me. I occasionally look at
https://source.denx.de/u-boot/u-boot/-/pipelines/24337/test_report?job_name=
=3Dcoreboot+test.py
for example but just generally make sure CI saves those reports off for
people / tooling that wants to consume them.
https://source.denx.de/u-boot/u-boot/-/jobs/1005206 is what I pay most
attention to (and similar output locally).

--=20
Tom

--rKH8g+81lQHJ+ttu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeVeV0ACgkQFHw5/5Y0
tyysQwv/Xglcr7aRKXdxI9lMRCtKw8wR8iIYK9//3BVR156vFSJdUoJkwI29BA2j
fYaYP+rkYgmF4ocpoNmHyHhETJh7dDvAKGdgSjdrWbthZUvsayNLeaa0AtzxiQVI
kbE/vQMYJu7Zn6KDtT4LoAZet9XzK//WW5+KKPJanOyIa6incXpsS4m1MkXT1paa
2XrOREm1zb5C32PxtKvuS66wMmEluFncmUsE8BrouIahAjdV9t2BY2MbkQL91hVK
czI5/RmVgAOnjY59UmkxWQ5gCTE7sM6TuF/shX4kUEe8cA4GGsNMi3Mbg0wzkYra
I34dzMNezHnn5a1JpTlXLWqb8jKJBWAhgJv2f6I01v+IZNkubKyU/cIejHm3YZds
ffgfS7kAMhDKvjUwf6i+cnovH67M8bBQVoHsVGm6NBlLCFbmzyroQISODfkYobTm
rWIhyGJTGQilcvt6y4gvEutmrBHB1s2AAkpfSzWwI7FglcMZNIESqm4p90QpGh+N
XATalG51
=R6SG
-----END PGP SIGNATURE-----

--rKH8g+81lQHJ+ttu--
