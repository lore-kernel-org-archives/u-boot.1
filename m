Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03710C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 17:16:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 703D388005;
	Thu, 25 Jul 2024 19:16:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c2USTcni";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82824880DE; Thu, 25 Jul 2024 19:16:29 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BEDF88263
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 19:16:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7035d5eec5aso62135a34.1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 10:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721927785; x=1722532585; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SU2NJ4ZTMkvGo8YhfAzQcQ548Ftp8osuh8PqgICkJFI=;
 b=c2USTcniY6wQyy425/CrB06f332UvupsRX+8tHa8u02FjXJtVxYERmm/1ahnReUS6s
 yB9FUfZOJQQspHsofb6fe8gXdHTzUBs47nOpjLElereagxZsvxkgfLVWoVlqcZ+m+xOY
 Z+K2xADY7bKhxGFbla7CZXJwcdbvkFiNKca24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721927785; x=1722532585;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SU2NJ4ZTMkvGo8YhfAzQcQ548Ftp8osuh8PqgICkJFI=;
 b=TuSBZ9Q2ohNse8Tt6cMWMqEt0KM6AtyRAciOqdoHTc0iSf6JZ96/DC+juanvRy6wKA
 150LXZ7TcQwYUUqcsQcSsuiHjKeavCY8qQoeRtGJPtnxers2ZlYnMPd/o5GblP3+nTKU
 kovzFB23AKbnRs+3H8SllPuYutHkrs0s3RYEbybBd3ZBkgjU2YO+SW8dlf35OBEcgdk3
 NyiyzztSBk4MrbK9v9XT29pboNnG/YxwG+XEiWxyhOYnmxofJ5TuL8xBH177ApvioAgh
 0HKXinxG8FdnPY0gOSjxlyBdC2BlyLQnko9ISnxjsQi1Kmi+D5/ZEbA6XgFNZqITq98f
 scKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZehLbgVWqEOchPALkYZwiVkrfwp1SXQhjtv7CCl2M/5qHKjr+P4Uoqcwziey/+6bux/4a3chKdb/whwitz1ciwTw7PA==
X-Gm-Message-State: AOJu0YwTMy6gRWIU6Jw09V4XYfjOszfbJbQjisYRFkK4XR8J4AN3ngnD
 Ym8goaYDGM7w+MtA6rIoLA7Bm5L001VI0E5BIr7EmMOYPG23RWzBELFaDBBspzE=
X-Google-Smtp-Source: AGHT+IH9RwLjOuHoC+DXq8VGFS07NyaUIADISK/5Mzk6LFJAxE1/OpjeIT60YOW1GJai14KkgtC8AQ==
X-Received: by 2002:a05:6870:8186:b0:261:a26:9319 with SMTP id
 586e51a60fabf-266cc39cef2mr2642896fac.24.1721927785153; 
 Thu, 25 Jul 2024 10:16:25 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-45.totalplay.net.
 [187.190.202.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2653e7d4ef5sm351089fac.34.2024.07.25.10.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 10:16:24 -0700 (PDT)
Date: Thu, 25 Jul 2024 11:16:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dmitrii Merkurev <dimorinny@google.com>
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20240725171622.GZ989285@bill-the-cat>
References: <20240723141844.GF989285@bill-the-cat>
 <87ttgf5emw.fsf@baylibre.com>
 <5329b5b4-b54d-4c4d-aedc-c21c3da5f9ee@gmx.de>
 <87o76n5d1a.fsf@baylibre.com>
 <A6FA1C43-24E9-4738-9AE0-E0E67E71CA65@gmx.de>
 <20240724224027.GP989285@bill-the-cat>
 <87ikwt523y.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fSDZl0ZrEWZjbOJ2"
Content-Disposition: inline
In-Reply-To: <87ikwt523y.fsf@baylibre.com>
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


--fSDZl0ZrEWZjbOJ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 10:04:33AM +0200, Mattijs Korpershoek wrote:
> On mer., juil. 24, 2024 at 16:40, Tom Rini <trini@konsulko.com> wrote:
>=20
> [...]
>=20
> >> >
> >> >Ok, so does that mean that you agree that this code is safe and we do=
n't
> >> >need any further action to fix it?
> >>=20
> >> No fix needed.
> >>=20
> >> Tom just needs to nark it in Coverity as "intended".
> >
> > Thanks. I'll copy/paste the explanation in and close it next time I'm
> > over there.
>=20
> I've done it already, added a lore link to this thread as justification.

Thanks!

--=20
Tom

--fSDZl0ZrEWZjbOJ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaiiGYACgkQFHw5/5Y0
tyzy/Av+IxavwVxS6oXH4YyyOUtla1MedFX4n/V3XHYPzHF9yel86oGUV02th52S
9IrD7qo6MA8ALiL1RiUX+UoZaxRTc+Pm0uEadUgGz8bODxIVcJqXj2FZm9lVNH5u
QdZeEGfIOSE5qfHMrLvHlNBKKZAKh1Jx9Cw0GoNy6oZ3WoTz3c7lqFXXWUyVV3an
5rlCTeunuZ5BVQmONM/ilqmC3ffwldUg0+MPI6d8j0JWaHId7k/PLGHlv7gqlDJp
oGyEoBxu2ZKlyhR6LIhVQwWG8JfYRGL6zykaah6f4Z6mcGXkywvFDKlRZ4idDkKa
0++j3AxM5c1aH77dlcifXCN3Hz4S4twgt8j+VWmATocjPC5tdgPUSazraKAoRxzD
MAnMKzx82LJh1tR2RzhAoiZMSxzSEbeq+gciKsygBxKBMMmwpN3jIXPheKuSZRLD
q4EIhH2DU1FAagUhsSOMig4n3uAoG42syYy5bS1qINu1vi3dRsG2E7XjXcsTDZIE
gKqP7V7Y
=X15I
-----END PGP SIGNATURE-----

--fSDZl0ZrEWZjbOJ2--
