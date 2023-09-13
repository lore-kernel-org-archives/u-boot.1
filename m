Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358A3CA5539
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 16:20:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3255F869D1;
	Wed, 13 Sep 2023 18:20:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YR4+xICT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDFEA869E1; Wed, 13 Sep 2023 18:20:05 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EA5F867D2
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 18:20:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-d7e904674aeso6125449276.3
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 09:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694622001; x=1695226801; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WNtcwOi4xHNb6EEqCkmG7dodVCFzD1H2bUZkJ9C84Ns=;
 b=YR4+xICT5WVTrjWHXGYdHT7ZmfCXvQjlM/QgffWv/pnEX+Wkvq+aYHMurnjiK4+mw1
 MMq104PmkNhq/W+QWBww769qVPzIHEw+8IYxpzM6VLEF260snAJplLYLD0jAy9lo1HCH
 dY0+EXGf0YPXhFRdP6JLo9QgSOkddQQJNG6do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694622001; x=1695226801;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WNtcwOi4xHNb6EEqCkmG7dodVCFzD1H2bUZkJ9C84Ns=;
 b=DfvgzTZXPLdxj91mN0PZKythjUtDHD3VrBtckLxSRBPxa3OkEC6/Od7eLYL1n1A8AK
 0tU9OG4YZLiypU+v67Qjp/ZR7j5F+l3xnhzKk8s4kQ8nBshGIWjS2n9PUNWKJSxmpyvj
 HEfYfJ9yIqzuoEP4NKesOS2Iq+V8AiuvOFHoqZcz4f2c8mTQ6wtQdvUJPFufkXQwYrxC
 xfkU4KFav2xQQegCDfNzLdE7HTbYzjWZZQCBPTDYNopFpNxa395Q8ngf+TWnJEffObZd
 ORYl3YnyCt6kVNxeuKUEaicpZkw5VOydJJ9t5wqocfkvIBBiTvj0jIYO1vn7CJ2qF2nM
 F4BQ==
X-Gm-Message-State: AOJu0YywdSBv/Yw1vy1iuVCiveGnwnN745tevoooQpXuVEZI/3owmxnA
 76DxLg5fNa2ZuzLpDWZtFEh6oQ==
X-Google-Smtp-Source: AGHT+IGhzko0wpEauWSywdSuUPegfontcFc+/Sfer9jRMtidvuvdvuHG/WDIjkfkVkb6z8xqTHqwiQ==
X-Received: by 2002:a05:6902:18ca:b0:d74:3924:2141 with SMTP id
 ck10-20020a05690218ca00b00d7439242141mr3511296ybb.15.1694622001635; 
 Wed, 13 Sep 2023 09:20:01 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2580-cbcf-c7bd-45ce.res6.spectrum.com.
 [2603:6081:7b00:6400:2580:cbcf:c7bd:45ce])
 by smtp.gmail.com with ESMTPSA id
 10-20020a25190a000000b00babcd913630sm2810176ybz.3.2023.09.13.09.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 09:20:00 -0700 (PDT)
Date: Wed, 13 Sep 2023 12:19:58 -0400
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?Q?Jo=E3o?= Marcos Costa <jmcosta944@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, sjg@chromium.org, antoningodard@pm.me,
 Y.Moog@phytec.de
Subject: Re: [PATCH v3 0/7] Port gen_compile_commands.py from Linux to U-Boot
Message-ID: <20230913161958.GL305624@bill-the-cat>
References: <20230902145310.107054-1-jmcosta944@gmail.com>
 <CABfBAmBirBMaSBfJWNbBQrDJYY0be8n7xaFf6aC=m=Wx0P6uMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="B8BhivcKd/LPUyAB"
Content-Disposition: inline
In-Reply-To: <CABfBAmBirBMaSBfJWNbBQrDJYY0be8n7xaFf6aC=m=Wx0P6uMw@mail.gmail.com>
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


--B8BhivcKd/LPUyAB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 03:28:07PM +0200, Jo=E3o Marcos Costa wrote:
> Hello,
>=20
> Em s=E1b., 2 de set. de 2023 =E0s 16:53, Joao Marcos Costa <jmcosta944@gm=
ail.com>
> escreveu:
>=20
> > Hello U-Boot community,
> >
> > I'm submitting a patch series that ports the gen_compile_commands.py
> > script from the Linux kernel's sources to U-Boot. This script, original=
ly
> > located in scripts/clang-tools/gen_compile_commands.py, enables the
> > generation of compile_commands.json file for improved code navigation
> > and analysis. The series consists of the initial script import, the
> > necessary modifications for U-Boot compatibility, and finally some
> > documentation.
> >
> > Your feedback on these contributions would be greatly appreciated.
> >
> > Best regards,
> >
> > Changes in v3:
> > - Add documentation to index and fix syntax issues
> > - Add reference to documentation in doc/build/tools
> > Changes in v2:
> > - Add compile_commands.json to gitignore
> > - Add documentation
> >
> > Joao Marcos Costa (7):
> >   scripts: Port Linux's gen_compile_commands.py to U-Boot
> >   scripts/gen_compile_commands.py: adapt _LINE_PATTERN
> >   scripts/gen_compile_commands.py: fix docstring
> >   scripts/gen_compile_commands.py: add acknowledgments
> >   .gitignore: add compile_commands.json
> >   doc: add documentation for gen_compile_commands.py
> >   doc: add new section to build/tools
> >
> >  .gitignore                         |   3 +
> >  doc/build/gen_compile_commands.rst |  47 ++++++
> >  doc/build/index.rst                |   1 +
> >  doc/build/tools.rst                |  13 ++
> >  scripts/gen_compile_commands.py    | 230 +++++++++++++++++++++++++++++
> >  5 files changed, 294 insertions(+)
> >  create mode 100644 doc/build/gen_compile_commands.rst
> >  create mode 100755 scripts/gen_compile_commands.py
> >
> > --
> > 2.41.0
> >
> >
> Any updates?

Heinrich, were you happy with the doc patches?

--=20
Tom

--B8BhivcKd/LPUyAB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUB4SsACgkQFHw5/5Y0
tyzMSQv/RzojCGSSTaMMNtSt60OYgX5RX72CePeGP9Yt8htCOVcmyUPY+OSUuWPA
a60r1ZAGZZMlYRAybf0rhAa69abscgHbkZ9NRTLXqaWq45RgmFE8tpLVBn373cuk
DMDQVe868m69YuV9b88BCAiDD1mP/8Vks9+Cv82GiJY3AQCFFLP8ZQdAtCoWVGMu
aIkW7pqRFgZbDh7FP2Js/9OdQWCVK98kcPkpUfiK1Xvd8W8fbHhkYTYLQKIlz1eQ
atS2JqnnXLaaW6OcWqEpyUiMV3AovPFxB3Oj4SgN0etUDFz/8DPQ7bu9SAkAX/ES
AdWInTOhq8VfySGhcDjg0w3M5pp76b43eY6u5akKNg3N3jniLY34ZtuPCiO/l63k
ml4uXxF9MFG09yWJDLcEY/9ZIKkEG3b6TzzDY+WQTdo61N44UT90Cs5z3IcQjBiF
9n5AO6rb0sy7/Ilt1KutgXcXHD81CX9VZmHNZNV+mgwH/nhr+YTPclr+RN24ujmF
4OKw0feK
=3/u1
-----END PGP SIGNATURE-----

--B8BhivcKd/LPUyAB--
