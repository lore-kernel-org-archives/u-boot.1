Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E27CCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 17:03:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 704D9836D1;
	Thu, 30 Oct 2025 18:03:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KIfBjg1+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97056836D3; Thu, 30 Oct 2025 18:03:32 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 739D583642
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 18:03:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-44da99d4d40so674307b6e.2
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 10:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761843809; x=1762448609; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Zur7Fl0RORM4Z/yn7TdzYGmteZ8ZW2yROZqwDj/KEB8=;
 b=KIfBjg1+X5z9CyMJqXBh6lFquP+q3CiU6QGlc76c6WNvkdeAlTZCdCo5K+86Wc9kkb
 yJbS2z6if5VVm1Cq76WGmKxy+7TYfKp8YxKSzEopC2eylKea9CVNLLZA5qrSugPuF7BE
 QWmQxKaGg7MbpL2de3medEKMOWRcOriKMoh+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761843809; x=1762448609;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zur7Fl0RORM4Z/yn7TdzYGmteZ8ZW2yROZqwDj/KEB8=;
 b=u0A4q7qRD/aaZ76aKPzQmyCbUdQ7dDcU6N2lJoQoVhVWFhzS/yFEGZ6tFsjYVDTchY
 LBq8bWUlyAsEY7C32CC3ucNgMKOeVrZ4c9Ugo7cXyzh4mIRlB0pojB5B2Q1ZDCcFI2Dh
 MEWx1Cz+x9wYle9yUtebpjjkLtxAO8YJzTM0b3tdJj5SussyMSh46DAvfFFdj8WZG8JT
 3nZb6nCuRPtZdi3mFDHgNNlsy16jH30weJ5AECpvY4s9+i5VtulfdTyyQNO2hRnUo155
 f6f/Qd6Mk/KF3c+wYk4cTuwebflUOwNo2JzUkGrAPzPmaSX6oYG99hKYy6qwIbXTXMjg
 2KcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdfsKlnVNpiFYZnz0+ml1rVdVDKEP1tTy0QdwsFO3ZwwhDda9e7hLZb500UqB1PKuYOVV6Flk=@lists.denx.de
X-Gm-Message-State: AOJu0YxUYlJdtujig4HXhoT8jpN6NM1ZDJodG0QU3739ncgunUBu679a
 9EV4FJ/0exZBfeC8vEdKJq7ybxkxGNkIX4ovvvlfnB3OO5c1mX728mCqJ8RsMsaOFepNVY7hNBW
 LIi+t2f2dlw==
X-Gm-Gg: ASbGnct94qiAGDqSMnznwGO/WiREGOF3C7LleC3kfex1AYBsJUBRiNT6AOBg42jT9pw
 oSBI41/C+BLAsYCsZ2xelGrdX7+cav2rX/B4V8ZXjiFf8pK+rW9dWeOIvgh0GZqQQqFb3k5WJ1k
 kMQwa2sMcEUnfYYK3LYNPAn/uNd2FM8OR2vQYAXWOrXreUZisYDczE78Ps6El3MM+FtjCR9XTRY
 t/wBYZr0BURZmUY4NHu7mLq1XsbgMVadGxz+0lkrR9h4LWqCmm+OLCqQzckQiH16q77fYn7RJ6j
 Jgj2JGIe2zX+aQhY0dexNSfJmzUGzWAUkzO4ZauwBPt3U2QKMe3SFVxWRue5JDS9xRLLOVtGfqT
 W5OkWxqh2pod9EIQq+A09MOxZyVTsNMUaK49BoNWMmysfd9tW0WG1eH7K2W9z5FAGrIEF6Fgb55
 +VP/lYaDTbte/MkTNtb3SHnZ98ZLaZfc/1NG0z19Pp+GuQx45r5w==
X-Google-Smtp-Source: AGHT+IGD+14bZzvExfpiBNv6iZTKmr4DFprx0y4tdR465A5/OTP94P5Kf9m/AJOZmWrt8IvTlZ+MyA==
X-Received: by 2002:a05:6808:1b23:b0:44d:bcb0:1413 with SMTP id
 5614622812f47-44f95f8afa3mr142288b6e.46.1761843808801; 
 Thu, 30 Oct 2025 10:03:28 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44da3e59a15sm4326212b6e.8.2025.10.30.10.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 10:03:28 -0700 (PDT)
Date: Thu, 30 Oct 2025 11:03:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 U-Boot-Denx <u-boot@lists.denx.de>
Subject: Re: vexpress_fvp test.py CI errors
Message-ID: <20251030170326.GV6688@bill-the-cat>
References: <CAOMZO5Any4akaDeRNwxqhcdy_gjxQVHC3aao6sDDxqALxNsp9Q@mail.gmail.com>
 <CAOMZO5ANeCogTO+dyq9GSu7XGeW+H3OZ2CXCEsguhcrQLJwNrg@mail.gmail.com>
 <CAOf5uw=rMZZs7m2mUMV-DCw=C1d_R7uWAqzpWfYOM4TXY9Sm6A@mail.gmail.com>
 <CAOMZO5BxaAcr5BF+D1KB9hjddv4AmG3f5pzRM5edDUHBSCz1Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G30a1Sajf0XAFdDW"
Content-Disposition: inline
In-Reply-To: <CAOMZO5BxaAcr5BF+D1KB9hjddv4AmG3f5pzRM5edDUHBSCz1Pw@mail.gmail.com>
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


--G30a1Sajf0XAFdDW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 01:41:27PM -0300, Fabio Estevam wrote:
> On Thu, Oct 30, 2025 at 1:39=E2=80=AFPM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
>=20
> > ! _pytest.outcomes.Exit: Lab failure: Marking connection bad - no
> > other tests will run !
> >
> > Did you try to rerun from that stage?
>=20
> Yes, I tried to rerun it several times. It always fails.

Yes, the console access is unfortunately racey. It's why I'd like to
replace it with QEMU being the bloblist using platform.

--=20
Tom

--G30a1Sajf0XAFdDW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQOaUQAKCRAr4qD1Cr/k
CojPAQC2AjFUnIP3SmVy5NmIMUz1dbdihs4X/COPv47UUkuIzAD/b044JLX5xhh6
fJJVZN9vUdTrx9NDytSG0kzfk9GMbQ0=
=o0vf
-----END PGP SIGNATURE-----

--G30a1Sajf0XAFdDW--
