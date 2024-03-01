Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43143C5478C
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 18:54:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08AB288168;
	Fri,  1 Mar 2024 19:54:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q1iL7oO3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3FE58815F; Fri,  1 Mar 2024 19:54:00 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3B558815E
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 19:53:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6095dfcb461so23830137b3.2
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 10:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709319237; x=1709924037; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YoVIrX1uEaOdTIYUS6eUZDHtZP1B8ZeJRuXaLzYEyYo=;
 b=Q1iL7oO3NWkymefZJfQU73ZToCk9RXduoTEMd25uyCyxnqvYmuBOa1Oq/9q5NRNPZc
 iZyCNgKEaTbyf/anntOM16646KmMVuZg1OsqzvOdpSak0BRNM0d/szPGB1+wNs/FPFKk
 x5VfTFMgYdMhbUjV8mtX3QNEjCsRLzmNIH7Js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709319237; x=1709924037;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YoVIrX1uEaOdTIYUS6eUZDHtZP1B8ZeJRuXaLzYEyYo=;
 b=lB0aN+CKn/6QAaYfe1i4VUxQ12lYoM5icMF6vezEh6EBBGwPcdDiKf532y3o5JXUYW
 ivOtyEpa+62r5bRKfaIsOvTsznDVzqmCQKWiXIZgDEN27izQhwuUgcCr1ELfFlYUR/o7
 stxBb+GJmZ+Lf430HAeL987PPEYsXVlGfMHRd8mvNAEVLALPnRjy0KEJYSx+totjGpfM
 GTL1XI6Kc65i7DW06HwtlqIBN/Tnki7jC0//A7Iasr6bUUtcvq1GK3+bG+zckUzXi8hj
 G5l9Pxxa4U3LMscXKYevgZn1AyXWjOCn36ouACc2AM0xvO+bBROcYHgvdZzfhKzMCnAK
 4w8g==
X-Gm-Message-State: AOJu0YwC0No3IPGHh27t2qgqrBIoNZGsdhxO/vi8VwyIch+9OEbiqcR3
 f5vunlLqPk5BHiVnlmINmISVSI4zjMJ95sl+sdHR4PoGGpvW+3YydJi6shrzBC5szGNxOtYI/DS
 x
X-Google-Smtp-Source: AGHT+IHbogyafeZByvIMsDfaLLR0gmiGILtZSrdmuURD4uNv6vVgeUwba4Tvw/vEHxsrkcfhc/QnJw==
X-Received: by 2002:a05:690c:ec8:b0:609:87d8:50b7 with SMTP id
 cs8-20020a05690c0ec800b0060987d850b7mr2318029ywb.18.1709319236889; 
 Fri, 01 Mar 2024 10:53:56 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 u128-20020a0dd286000000b006079e8f3572sm1094754ywd.85.2024.03.01.10.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 10:53:56 -0800 (PST)
Date: Fri, 1 Mar 2024 13:53:54 -0500
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Florian Schmaus <flo@geekplace.eu>
Subject: Re: [PATCH] pylibfdt: Fix "invalid escape sequence '\w'" in setup.py
Message-ID: <20240301185354.GB3040305@bill-the-cat>
References: <20240220135248.1277809-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6W/qrUKnSqlSRAro"
Content-Disposition: inline
In-Reply-To: <20240220135248.1277809-1-trini@konsulko.com>
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


--6W/qrUKnSqlSRAro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 08:52:48AM -0500, Tom Rini wrote:

> From: Florian Schmaus <flo@geekplace.eu>
>=20
> Once u-boot's build system invokes
>=20
> python3 scripts/dtc/pylibfdt/setup.py --quiet build_ext --inplace
>=20
> it may fail with
>=20
> scripts/dtc/pylibfdt/setup.py:40: SyntaxWarning: invalid escape sequence =
'\w'
>   RE_KEY_VALUE =3D re.compile('(?P<key>\w+) *(?P<plus>[+])?=3D *(?P<value=
>.*)$')
>=20
> depending on the used Python version.
>=20
> Explicitly mark the regex string as raw string to avoid the warning.
>=20
> Signed-off-by: Florian Schmaus <flo@geekplace.eu>
> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot/master, thanks!

--=20
Tom

--6W/qrUKnSqlSRAro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXiJEIACgkQFHw5/5Y0
tyy/xAwAp+/lEL78H+UxmVoqngpEJmfzuh8x8AiJp9ukQxLk7Sjt9a/hg0nJ4YR4
zvoN0aJqhlTXNFU7FY5qazHrxhKSJLbzIU362e7Vr0Z75/fkQ5v2HFOrm3L0Nmz0
ChRfBhABM9CvI1OihSSHp+GSEyBiyFO1qZuT45Dtxr5mRr6ebNYns4Br1A4Bq4bh
a2R89g+LA+denMWH40lmvORR7kVOLRXjY2PFgInv3LCTzm7y+nUYgJ5Fiz0SvbV/
b9t5c/vJ++scKAmOa9D3UX/K2lhBXacc2q77EToGoISOBQHZ3hYnT36rIzH+2FfT
Z+cHCBWIiV7OePLYv/1cngs41uVpynEtIQKfCApEPW2bfYEYWuaoaRfMMJS6MvpD
aKsHhKgkNn7Wjw/i3Cs5DzzeHOlreA2jvsvSr89CmY/AW5Jz+X/j6G6ulpxc7Llg
5tgSQN4tAbN7pevISpll3QZdiECFof4JHxc5uUL0XirbVChM7Sk1+eL8XcQTAg43
yZhf2lvb
=T0QW
-----END PGP SIGNATURE-----

--6W/qrUKnSqlSRAro--
