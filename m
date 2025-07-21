Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D258C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 16:31:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E43A383205;
	Mon, 21 Jul 2025 18:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qsE43tHm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A15C83214; Mon, 21 Jul 2025 18:31:37 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9949D831B5
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 18:31:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6159c26766fso2109327eaf.1
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 09:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753115493; x=1753720293; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0N7ZzIeQ6/Oy8kCFuyUwjm6cQPdTHRBiM8gbhxDZVIc=;
 b=qsE43tHmh40Yg4/f1r+P0MNc/ovuAiQecwS3hrM/6CRbuPhu3lBcvO08/auYeyvOX7
 7fTg/hB0WmGgmF4SJwr5p+PgocjgJEUtqoXte+pVu/K1hR22QRoAJWwZRBcVdommGHcP
 cJsELmdElT1N7PQqbQqWb1FAttS3o+vVVkzHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753115493; x=1753720293;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0N7ZzIeQ6/Oy8kCFuyUwjm6cQPdTHRBiM8gbhxDZVIc=;
 b=B6znVqm+5ayR9fkdHylwtWnTo982lU8LD+giJQqXm4IKgk42j+FpirWC2b/QBsPm02
 5A5wpr6s1t+KWOR1MheBjCAUseI6dJQW2U2SW3T2DslVUXYw/HuQZV555YNxQV40JpSo
 ge5JTPq07CGN/VmNHLEeUMETqoDzvpPwtxG7Mt8C66yVqlXnWuAM+VAQ7PTZAYjPfyjN
 i0K01ESN1JA4cpSrnd0bQMXJHVGRwbE4l1F8t32X9V2POp4O8iHwv3BDxHWlqZw3G60f
 eQENLeBn+aHzQvvVDBFnPzeS4SAsfJrKEeioxcWM3noQTYdYW7pX+kkoHdXl04wPYUbA
 g47Q==
X-Gm-Message-State: AOJu0YzsV0LuHHDh6LoyB2371yn+O7bI4rxI9ZCdHVXbqElHbZdMAFLW
 qSxCUgYJB5MiaswW7yiF1e1qoFMfQWId7zeXa/WW8brJ+vIztI3Kns/K3BkNmdDNiOBR8rlHrca
 YyJi0wFE=
X-Gm-Gg: ASbGncu5qRNTJK6tS7iOMcM+XqIGa8TWq35jpHdknbDE8G02xmIdEvkeTRwGm8fEFt0
 o3IkgoPtrD2iqdIJskaHV3SvR5kPX+3bZOMSNZaWWMrSO02x7tV8xnMSxdKCOA5q3H7SjFjZbF9
 6nWZsmnFO+niJ6z2jMCFz2robea324dgVKpCUbk3nI+gW6JbO3MR1CAjjkU6o96MsfO5tnI8gtm
 kWM+QDe9McMyw+zHPeeOKgdN1xOKzA/MAZfpgC9Z7aZoZ40fUtxkvHpeLGtzULcndepU8RZF99h
 iDVidlhDanprxPFaKuVsWOilJvVOPBmHA6bnOAYyspmuqt8SaaxYOdt2EjxnxqH/5bLK5fjUm38
 e/otCGMTA44faB+8jTYyKKDSPWMQuOY84o0fT0OKakd9Oh6BvVKe81eca8MmhU3LPGak=
X-Google-Smtp-Source: AGHT+IGyzIp3nkYcWvQK9KiNOTFi1ykp9M/OfIp/xyTcUr/1M8B99WSNlwRxZj0/BYXoSYsTSv/RVQ==
X-Received: by 2002:a05:6808:219d:b0:40b:4230:387f with SMTP id
 5614622812f47-41d057568d4mr13192331b6e.32.1753115492806; 
 Mon, 21 Jul 2025 09:31:32 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-615bcac92e3sm1710092eaf.15.2025.07.21.09.31.31
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 09:31:31 -0700 (PDT)
Date: Mon, 21 Jul 2025 10:31:30 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: PGP key update
Message-ID: <20250721163130.GA2847763@bill-the-cat>
References: <20250721162855.GF193579@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="R57pl4xYWyOr76Kg"
Content-Disposition: inline
In-Reply-To: <20250721162855.GF193579@bill-the-cat>
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


--R57pl4xYWyOr76Kg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 10:28:55AM -0600, Tom Rini wrote:

> Hey all,
>=20
> As my current PGP key is set to expire August 1st, 2025, I've uploaded a
> new PGP key to keys.openpgp.org and it can be downloaded at:
> https://keys.openpgp.org/vks/v1/by-fingerprint/F3CEA8743D60E0192F9B4C7A2B=
E2A0F50ABFE40A
>=20
> And it is also directly:
> -----BEGIN PGP PUBLIC KEY BLOCK-----
>=20
> mDMEaH5oTRYJKwYBBAHaRw8BAQdA18301v5FNSVds7WVopJ4ekpR0S+AY61nVav/
> VF1hh8+0IFRob21hcyBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+iJkEExYKAEEW
> IQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaH5oTQIbAwUJBaOagAULCQgHAgIiAgYV
> CgkICwIEFgIDAQIeBwIXgAAKCRAr4qD1Cr/kCkgdAP9c/73P+3pMozxS+EIeLXNe
> clCNeJZL4AcqND8DPyZhpgD/esYQqJgmQDsCvYvH3T2QcGPAIYf2Pg4m8qKGMyg0
> WgWJAbMEEAEKAB0WIQQaPH9w4I+rFweAm78UfDn/ljS3LAUCaH5pfAAKCRAUfDn/
> ljS3LPxgDACg9KLwZG90uc+p2CYdp0rpdcSUoLnx0PTBmUpPoektxo4g7i4FSOcU
> SwEe2rZfNYouS01kqvPXyk1F5NZ3h85fnX3tv7h6W7qSlRM/TojAvrIhk+IMcEu+
> qf6nVfCwPLGH0xNVilMN8biF49ST0IDgl1CMVRKT3o5y7OFd6gMwYf2jV4wJxLdw
> Xoyz7A6TeFVaaXA8KeFF2qB21pNLA9Z1LiOZXvwdwbQFdNt40+TYL7M3MTEADnsV
> 3OXB9CGYmHrynpOSx4UXbM4DLJgcB5JV3chBoo5+oM6C38NLu5oncM2rKFvwXa52
> AKZ4PvN7WgaQeKhJ3eod8OLXmdXWGertGyoNRYYbUCLgIPIg2Hq55hu9LIatSFgB
> fdsFxYZMTUkwAB5EQn34afP0KoHMgmifW82Qv3eAJI7nR88pLjqT0VgNsM83kttm
> cSj99wO3zyGz16OWCXTgg56PeJRuCivPi6OGThARGUSV2OZMYNPygCX1QsCGZIwO
> JqIiqTkG/Mi4OARofmhNEgorBgEEAZdVAQUBAQdAB4oWETud72ovPGZXArCtneYl
> KF44NAxR2rtb120fJGwDAQgHiH4EGBYKACYWIQTzzqh0PWDgGS+bTHor4qD1Cr/k
> CgUCaH5oTQIbDAUJBaOagAAKCRAr4qD1Cr/kCqmOAQDFP/Gpm3T3Te3pcZyBOqWB
> Ozg2gOLy27t3bYDPI58jUAD/a03zFbdIoGQeqe/5IQeVisXoxWxP0/UokNH4wfQx
> ywQ=3D
> =3D4xwD
> -----END PGP PUBLIC KEY BLOCK-----
>=20
> This key has been signed with my old key and I'll reply to this message
> and sign with the new key shortly.

And here's me using my new keys too.

--=20
Tom

--R57pl4xYWyOr76Kg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaH5rYQAKCRAr4qD1Cr/k
ClyjAQCjF0/YlyqKs20/2xyUyc+8WqX4SvPWNQfMYNXADmTmzAEA12ur2fxMBMgD
jnLPDX2XJps1XoI9WdtkcWWmKJ5WLgY=
=5R7a
-----END PGP SIGNATURE-----

--R57pl4xYWyOr76Kg--
