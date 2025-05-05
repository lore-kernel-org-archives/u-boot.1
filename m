Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A09C3ABB6
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 21:27:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97C92820E8;
	Mon,  5 May 2025 23:27:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AtYijGgg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49197820EB; Mon,  5 May 2025 23:27:07 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB3FE80050
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 23:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-606440d92eeso2422551eaf.2
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 14:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746480423; x=1747085223; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=89Chc8MQQIgoSj1irhn3908g59FNILNluJ95hufyasM=;
 b=AtYijGggv96JEiJdTk0fSo2wLOTGoVXWLglERuaOh3UiwDYGNFeVDDVtyM9YHz1ckO
 o+cC7LXzlpensuGUEojZKIqw09wVZqbii23vBz50tBln2qc4Z5nT+uAE9/2hITOQ3uP0
 8rDiabkadgEBMr5vverEYiNSUB1hCbeaLMslQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746480423; x=1747085223;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=89Chc8MQQIgoSj1irhn3908g59FNILNluJ95hufyasM=;
 b=ZFPi6P67qwTj+A/WbJq28cfpP1iv62h4Ucr81zh9koib5htPDnCkf9y+JGgX5BvIYl
 gLF0CbJVpIz8bMmzc9QuHUtUk7ZqT2FkVAdAh5O4CauIjdPM8emth8TQ2T2XsrbD6B8A
 nbAXx/d9fkpPnHX9FPNveLSDoKKd44tw91payTxnQXpMs9bDoIycOXJ79r/Am/TwF5LG
 E6Yxq4aqXa7jEn0lcTU15txSP5uGNduCS9ajl89iTTBcL3qLELOWqMTqPRkZRQTdQfJE
 5B7D+1o9LTPeGBExmBnWuM6pBz0MTIN7TJEoNyUic7hWbKdbBlX/hzUT70elx+TzMxy2
 4TVw==
X-Gm-Message-State: AOJu0YzlBfMno0yeTi7RLgebsbYvPz1yhhAXOVD47aQb2Wh7Q60Fd/Yb
 vUiBkeFpkA1Y2KAiwIe5wSAwpm2FBrcOWp6ag8Fj+GnS9lQWbYg3Id3Cgbqf/Wg=
X-Gm-Gg: ASbGnctylJXjmT7R1/qI83c71p1UctotYd+Slox3qjQpwrzVllL740tv3ufZzOYopnO
 3X8nYUGji7+LOzyIr8H76VxSBl8E0PxJd4qPXGo5CGNvQuLiQbYC1nBQkkbwtqPuojYrRtoYoDP
 iwEbH+0bG2yVYsCbXOySzwQo05Wpb6thVdO55TsQaDIahc+BAuRTFxroMYtOvSq3QhiG0HnLG9o
 2rJqHHWUcpFb+ZI+csaJU8NA4+7tvVRaZXgPK0OZjF+zm4XFOPpVNSZDM/rh4sTpagj6p7z7dtN
 x+xhSV0WVw7uEEVKRpPcS+pmsdAVphIoLz9Tp1ZuN2+IofmJxSSdCfr9ZJ/lWaGvfz9h1yqmiL0
 TLw==
X-Google-Smtp-Source: AGHT+IHtgeukYwr7QzYqbpGUeQAboGt6vvCt8/++Eh6yWig1kC3A3N/mV83/BYTWZ12bRFDPQOFEGg==
X-Received: by 2002:a05:6870:7196:b0:2d4:ce45:698d with SMTP id
 586e51a60fabf-2dae82c04c8mr5116940fac.4.1746480423458; 
 Mon, 05 May 2025 14:27:03 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2daa0ee1978sm2257837fac.15.2025.05.05.14.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 14:27:02 -0700 (PDT)
Date: Mon, 5 May 2025 15:27:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Javier Tia <javier.tia@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] test: Add setuptools to test requirements.txt
Message-ID: <20250505212700.GO5430@bill-the-cat>
References: <20250505205052.347616-1-javier.tia@linaro.org>
 <20250505210817.GN5430@bill-the-cat>
 <10b358df-35fc-4d7a-802f-f38bbc9220ac@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hr3tWhZABM54YEeC"
Content-Disposition: inline
In-Reply-To: <10b358df-35fc-4d7a-802f-f38bbc9220ac@app.fastmail.com>
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


--hr3tWhZABM54YEeC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 05, 2025 at 03:14:13PM -0600, Javier Tia wrote:
> Hi Tom,
>=20
> On Mon, May 5, 2025, at 3:08 PM, Tom Rini wrote:
> > On Mon, May 05, 2025 at 02:50:51PM -0600, Javier Tia wrote:
> >
> >> It solves the following error:
> >>=20
> >> =E2=9D=AF ./test/py/test.py --bd sandbox --build
> >> +make O=3D/u-boot/build-sandbox -s sandbox_defconfig
> >> +make O=3D/u-boot/build-sandbox -s -j32
> >> Traceback (most recent call last):
> >>   File "/u-boot/build-sandbox/../scripts/dtc/pylibfdt/setup.py", line =
23, in <module>
> >>     from setuptools import setup, Extension
> >> ModuleNotFoundError: No module named 'setuptools
> >>=20
> >> Signed-off-by: Javier Tia <javier.tia@linaro.org>
> >> ---
> >>  test/py/requirements.txt | 1 +
> >>  1 file changed, 1 insertion(+)
> >
> > This is the wrong place. You can't build U-Boot without
> > python3-setuptools being available, so it's part of the implicit or
> > explicit dependencies in doc/build/gcc.rst. I believe for Ubuntu/etc
> > it's implicit but should likely be explicit.
>=20
> What about the use case where you just want to run the U-Boot CI tests?

You still have to have built U-Boot.

> I found this problem just following the documentation at https://docs.u-b=
oot.org/en/latest/develop/py_testing.html.
>=20
> $ cd /path/to/u-boot
> $ python3 -m venv venv
> $ . ./venv/bin/activate
> $ pip install -r test/py/requirements.txt
> $ make mrproper
> $ ./test/py/test.py --bd sandbox --build

Right, and the failure comes from not being able to build U-Boot. Part
of commit 859621b47f9e ("python: Recreate test/py and tools/buildman
requirements.txt files") was to remove the parts of
test/py/requirements.txt that are not from the test/py suite, as it had
become the location for any python module required, not the test suite.

--=20
Tom

--hr3tWhZABM54YEeC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgZLRkACgkQFHw5/5Y0
tyzofQwAj7m2T+6lj4w94cyP7EAHdRCE9MYqlLdnJ4jv9W+AySO/n5BFrX5zYeR3
y62McpV1vz8jzkM1ajIoAB0iV0KPinrBMnX+mC4+6gHZgS6QV4oJzed6R6EN7D0y
fEfaxO1wcxzFa6wBd6Xjm+0qBrH8EX8l+volL/1fu0y0lLejjS2zM5/7ScPybKpD
14VyFXoxHQlVIbmYZBCYodVe38Sna/NwoAxyRME6jfpulT60GDrQmjAx146AdNa9
hd2hqEUmsjHYgHDyrgCVic6+g6gvr5THC2dRgC7SBDHObq8s0XoENqfcKrnKCfIy
EczVwiYLHF63i4pduMtD0WmgReoKqtXW8I991A4B4g8CNxn37mZ18N5cCQGOMYcj
rkcb2CL90P819nRf664bLyC6RDMqvuqJC4ksTbfKE7FjtiCRj/pVoXDCB7v8t4VT
VvoYiirgDPU0YDhPyBt1ecH7zysVcscTWI4Ellr4C/FOyaasGqpx9IMLI+3MPzNa
l6+V3cLl
=7dx5
-----END PGP SIGNATURE-----

--hr3tWhZABM54YEeC--
