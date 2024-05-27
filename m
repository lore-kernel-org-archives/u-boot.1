Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03529C25B78
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 16:07:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D13F881D7;
	Mon, 27 May 2024 18:07:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TgbbvRim";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C552288224; Mon, 27 May 2024 18:07:15 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E4B18803E
 for <U-Boot@lists.denx.de>; Mon, 27 May 2024 18:07:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6f8edde24b3so701108a34.2
 for <U-Boot@lists.denx.de>; Mon, 27 May 2024 09:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716826032; x=1717430832; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=19FqNlQNThNHDVzupdiNlsvcps+AIAJJsp5+Q+bhjA0=;
 b=TgbbvRimzIOqKbA+P/8jFQr2MXE9YZJp4j2mpoBBExWAnf0H9dJDcZDEmX0DY+XVvU
 gtS3MB6m5k5KE7SFs2LSPk4e9Gd19mf+9bxIqhVbXPBlsB64pH9bh9QRyCY89AiUlV26
 XZyvZjT4YGVMxQ7J1uXC5ryHYG+ceU9CXpHxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716826032; x=1717430832;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=19FqNlQNThNHDVzupdiNlsvcps+AIAJJsp5+Q+bhjA0=;
 b=CxtYxvLJp/3mOqK4iHfjI3Zh6gn3ERI2rnYF8JCMAvSxfJMdHhHtLKTaFI9wVWaxX9
 jMcY3goSgyEAqBz4YzggVIVarlKcbB5bNXUPN/Y2Jn/Ad733jyCvbeFD/QcKeiMy26VE
 wJBYbunJop0OaAb9ny7SCzifrAJylJG1OpwEPZOzzP61e4ZYCXYaKF090fHzECpjhVes
 0r2H+CWH53kdAmtjsZyyHGQZl1ZfnltDgMlC0f08CAbcYxqjMDOXskBeebGtUnl/DSs/
 CYfFRDaZvXya//hl0ExkVv+WGDGQxkkzo2ZwblmmJPIM8EKfxUq3b1nWecxkVYugpTrZ
 BWMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+s39eGK16xaOCvHZC8FIrgTg3o4wNT056jyTbAOJnJNVUU1ewv0TT18ATZQ2p/TrEuwpwpWefyao1eFbE9mmWMoGcvw==
X-Gm-Message-State: AOJu0YzapWdeaB/xfG+GXAbWsOAO6eDjKh7mJSu4sdWMEvvd1fOqJTeN
 KwJ9q1sBpl7yN/YvfQEB56rUBepDP5lv/T1EKrkiHSMpJLk6OXQEMNFkDjCDUfW+erAH5wLBnJe
 Z
X-Google-Smtp-Source: AGHT+IGqt8MsMCIItggVgzrqVuK6DR9MzSWcqDCmYSYTnGSoqhpvHKtGr3vq7jJR8stlFYhXgV7ojw==
X-Received: by 2002:a05:6358:52d4:b0:18d:8fd8:e523 with SMTP id
 e5c5f4694b2df-197e53174ccmr1376310655d.15.1716826031970; 
 Mon, 27 May 2024 09:07:11 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794c87c3b06sm41023885a.73.2024.05.27.09.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 09:07:11 -0700 (PDT)
Date: Mon, 27 May 2024 10:07:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: "Brunham, Kalen" <kalen.brunham@intel.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "U-Boot@lists.denx.de" <U-Boot@lists.denx.de>
Subject: Re: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Message-ID: <20240527160708.GJ2568172@bill-the-cat>
References: <DM4PR11MB5296B1B9F0CFC701A8B11284E3EE2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <DM4PR11MB52961423BCE12552857A12A8E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521162543.GU2568172@bill-the-cat>
 <DM4PR11MB529670F5CFDA6B4EDA7B7206E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521164659.GZ2568172@bill-the-cat>
 <DM4PR11MB529668DA50F05F26AAD229F0E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521181534.GD2568172@bill-the-cat>
 <d5887c6d-fc80-4f89-be51-db9b8da3863f@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bcfxScqw9zLqNoVZ"
Content-Disposition: inline
In-Reply-To: <d5887c6d-fc80-4f89-be51-db9b8da3863f@app.fastmail.com>
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


--bcfxScqw9zLqNoVZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 25, 2024 at 05:20:43PM +0100, Jiaxun Yang wrote:
>=20
>=20
> =E5=9C=A82024=E5=B9=B45=E6=9C=8821=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8B=
=E5=8D=887:15=EF=BC=8CTom Rini=E5=86=99=E9=81=93=EF=BC=9A
> [...]
> >
> > We have long not done a great job with the U-Boot standalone API stuff,
> > and for a number of years at this point a lot of the use cases it was
> > used for could instead be filled by making an EFI application. There's a
> > well defined API there, there's lots of examples, and frankly for the
> > license related questions, makes a much nicer answer.
>=20
> Hi Tom + U-Boot EFI folks,
>=20
> Sorry for chime in here.
>=20
> AFAIK there are quite a lot of users of U-Boot API in MIPS world, mostly =
for
> Bare mental applications to perform chip diagnostic or programming stuff.

To be clear, I'm not saying we need to get rid of the ability to run
random bare metal apps. Just the bit where U-Boot exposes some API for a
few functions. We do not test it, and I do not know how well it works.
For what we provide there I would think just doing whatever one normally
does for basic stdio functionality on bare metal would be fine instead.

But I do need to be louder about my intentions here before just doing
it, so that others which do need / use it can chime in.

--=20
Tom

--bcfxScqw9zLqNoVZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZUr6kACgkQFHw5/5Y0
tyw9lwv9Es/EAltYzHTytg+expr5GnKptDEWKmvXQNHmcjFv6dUiMcNjsFzvrkY6
ciWYNXuRjmDTC4OCbeudvXNjrXRQWzM6w8Z1xmjflJ2bBDWd1Cfq6Jwqvx3Feolw
U5IsrvpOhrioKvoRqPJzlEPLedvUINa5TNwT9/KOCQzC44Y5lvGGqSRDfJylyiCR
ks9pxk2SppSwN/kKUhOVeum4p0G0fFlZyZ9zplIbLIFgwELrxRdbTupvLw7inaoy
8td9Nw3924T7QmkAwM4OPYS4+tTj2dPhxu1oGBr5kFMkG7Gl1saNvg1gkigo4WWe
eM/wFFBV3aCtKoaNXKddn8RIg70yd7D0Q7Kf0g0e/5xcX27vKbTWHqo6SytpPWqB
dkx0SZeOsaxhbiZP6VFxntrot/84JJVxnZH/g96llDBTAWRgcRaoszOYv4BAzmhQ
MueHVJGv60E9ydPB/YdyGRwQrq7Fbb8DHZROsH20RZsTTevRDUlO8wGas86EOHC1
KhmHAz96
=Bc7o
-----END PGP SIGNATURE-----

--bcfxScqw9zLqNoVZ--
