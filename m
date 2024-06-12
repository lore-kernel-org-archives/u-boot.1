Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A57BC27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 16:03:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F4628885D;
	Wed, 12 Jun 2024 18:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OoK+PLUa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB4E1883D3; Wed, 12 Jun 2024 18:02:46 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0FA588861
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 18:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6f977acff19so2432924a34.3
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 09:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718208162; x=1718812962; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tiBNTBwVAZNocbGGvA0CCTNcFtkpwavlAjlmM9RL4cg=;
 b=OoK+PLUaNuMgnGMmml4E+MCTyufYZU3y/OQSv5s4noyFAjDwPBaF8qbORDoEE8jRxh
 DQZNOIXe77L8YcZ11ynBeNgRtkI7/P4cfQWfVyKEvdscSjoKHf43gXf2Jf4U+MyHUcdO
 3Ew3AhjjZWQjIa18EmcnRVfTInmOXXlUmwDus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718208162; x=1718812962;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tiBNTBwVAZNocbGGvA0CCTNcFtkpwavlAjlmM9RL4cg=;
 b=buLA4twyG26vWvUadkNZDggwtghKXgSlgajvI99U5WOmEyjk/yj1iZf3+ZScUAJhbt
 QSgpPMJFi8GNQe1kr36J226XayqYEkZTRWbk53A8eTIurItCVPT/zcN0if2j2Hau9B6U
 I76ohVBnrZ8OO5/Au3CeAcsgcqjvQZfO7n11x3hPl0loZy8Y0bZrxyoVvLWNd6w5Rkkl
 RbYRXgZ04jl1ljvVa2AhOXPlJcXpxSkkVjqroXTUeccmTnoIO6L+uL6/LeIRodgftsr/
 U9Nq4hS4qkyqP66MPbSRHlG5fZtpWViN96SviMTQ/GDiBkVlUmxdZ/esM32yoA3v5bKy
 Ll2g==
X-Gm-Message-State: AOJu0YwniHdEExJ3mr3Ree8Fg9RZGA2uZ1S7DlD2sedNgiKJx3VM3L/r
 LBDzd98e84p3IlEii5UnCxsfVWMgwwj0F4SAZpouqZID3EVLlS41k6HJ/JwQErw=
X-Google-Smtp-Source: AGHT+IHZmioHGAmbrS6H0kCYD1vp+0sPzThMvrrDsaF5g28aKVdX7ehmaqafyWwrlqhNaNQqrublmQ==
X-Received: by 2002:a9d:7b53:0:b0:6f9:6e0b:4ac3 with SMTP id
 46e09a7af769-6fa1c21a3b4mr2541778a34.23.1718208162612; 
 Wed, 12 Jun 2024 09:02:42 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6fa50fb74fcsm202914a34.43.2024.06.12.09.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 09:02:42 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:02:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de
Subject: Re: [u-boot-test-hooks PATCH 2/4] qemu-arm64be: New board
Message-ID: <20240612160240.GX68077@bill-the-cat>
References: <20240611210025.798978-1-jiaxun.yang@flygoat.com>
 <20240611210025.798978-3-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="z29cEyDv7oGfOJ9r"
Content-Disposition: inline
In-Reply-To: <20240611210025.798978-3-jiaxun.yang@flygoat.com>
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


--z29cEyDv7oGfOJ9r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 10:00:23PM +0100, Jiaxun Yang wrote:

> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--z29cEyDv7oGfOJ9r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZpxqAACgkQFHw5/5Y0
tyxnFAv/R1ImJl7Glp//Ggitvwrj+flxD3pkDv+oPQAqH+gpsRG/gWj35an/qwJ7
2u3fQ/YhIj00sWOVvkwz7wYx4Qf/hh5qrE1DU7kk+UtLurXsdPQZOgpUZIwcINOR
L5AURl3iVh+rIt8sfhvkKJYomuXqmuTLX3M/ZWQbo7MEsXZ/SrTd2sVUISw4c/yq
NIx2Fwd0UrQrc2cVgZdIyi2S3tsd0ZYgExVy+MxyMECkbFpgLAXIFB6o9fXO2kT4
ecPPRblUjEJuNyEXILmJFjiX6zAsfWChmbxXNkozKW5iR1SgAdGCLzhDQcf7RYG+
yChH7VudYzf5cyfwqlJaYaKgQ9NnB4c8hcNdtpr7o1cc9f3ui7tkIXim9JZBb1pU
F56Qk5BBu2EuSx7iWrh8+DIvEBd/IT8yJeGZvelFMdsbtDZfoswX0mreDP6VTxZV
HJJfEqfaOi2qQ2g2NRUSJ2YTfFfQuRgRJnhG2dZSx3x1E0if7EwWlDM3qis5DbIC
8mNS0OB9
=3si1
-----END PGP SIGNATURE-----

--z29cEyDv7oGfOJ9r--
