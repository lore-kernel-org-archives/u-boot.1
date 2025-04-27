Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE502C369D1
	for <u-boot@archiver.kernel.org>; Sun, 27 Apr 2025 16:16:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C710580FDE;
	Sun, 27 Apr 2025 18:16:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mcpHUHE9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B7A681E0F; Sun, 27 Apr 2025 18:16:36 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 786E480FDA
 for <u-boot@lists.denx.de>; Sun, 27 Apr 2025 18:16:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-401f6513cb2so1410753b6e.0
 for <u-boot@lists.denx.de>; Sun, 27 Apr 2025 09:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745770592; x=1746375392; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jbEvBOewQBB2OOIoiiyuOrRaGkmUl4w5GGMBe+111n0=;
 b=mcpHUHE93yFYVrXI+FMlhgEIE0fHhZrx0NT81K9PJADrWJduj4SU+0zhlJ5GnHtcnT
 aisQWDKW4gOx1HVFuKtWH4nQ75XEbf8VKp776/sAXakwhw420ncuMHyTPc5T5Msq5QzS
 H6XzGxVcUTNDPPkSCzf6sQNj983pwErl69/Lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745770592; x=1746375392;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jbEvBOewQBB2OOIoiiyuOrRaGkmUl4w5GGMBe+111n0=;
 b=sMeXzGn4rbWN+jqlA8DY7XNgv+8JF0+SeMoegJfxqgYVnSDWXWSB1PFMlFZ+PopS6j
 Cgfe9JGdbzo8Pg7+uLfomGdAaLpHD4Gv8A0h/YNQ85QaNTEAxq2AbFCB9f0EZvBUzPJF
 jbLfma/4OCHHYOv+CH61sFZoGPOMcKfGaZqfDM/Pym0FNiBtNtbloQ7fckYBSQqQMohy
 iC4rU7uE4VEz9sNpAczc0s6LGi5CXC0Gqo4Cz0K9wtmsFJ2JIRFas+n7AR+01MdjWUEl
 8nMBPfTYD6HjcDcBoMK7JCoZWqXMrb4TdBYzWOBVc9eTtJ4rNLsRmViv66gK+n+E6twx
 S3zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3X7O4Iri5gLD+fqueVBfxkY4iUpuqjadZI4QJ0ScKMp8NzEEcCo3MBe0StApQcL78SuN0JA0=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1+R5nodLQVvmrvTmQSDRWB4HwXjRP6dMFf0zXBQ/ZCXTTu8bD
 lurK3NSkcgiPhKMaws/oWkXXwUl/2gOtpDcWtwDwHPXIvIBi4XDydUOuINiKwr8=
X-Gm-Gg: ASbGncsYoPGp64p0WVq5WdURsqyq+dbhCOSX6QLwQ3Qys/rbT6np6dGJ4FNx2s7h3XW
 X0pL0NX0Y2rTxDxJqW/09GUZkPgCqhJrjKH4lYwexB4/7qxHU3uz840YUgwSM4T2BP2atNZir48
 VFfjkKF6qjdrjOshWLJLDyHuE2dUjRN1JfNTFM/dq62pwlvuACzfRbePPUEAmKqQHVyyqLg7Rmn
 rI+QK/I4dkuQ0KnnGElniqOIxhrWJsAfQTBqX5kctsB1kvH1eGU8FuzIS72WdpGL9N3MFlRiGuU
 ED4Pdn3mmcJ+nnkmZfpUjD9cqul0QpS7stzb0mLxbVJVQZORxMCww/Z1P1FaMkSfSCsxfF5b7Gx
 i/tZsrLg5YBjP
X-Google-Smtp-Source: AGHT+IF+/f+ig34Y5GP9Yji6hMdLX4OVzfYewHuk1ludXSFS7azt6RNVecqGNQbWyJrwvLNgUEzi3g==
X-Received: by 2002:a05:6808:1a07:b0:3f6:a851:fe56 with SMTP id
 5614622812f47-401ec51ab32mr6908237b6e.12.1745770591993; 
 Sun, 27 Apr 2025 09:16:31 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2da13e78ffdsm93330fac.11.2025.04.27.09.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Apr 2025 09:16:30 -0700 (PDT)
Date: Sun, 27 Apr 2025 10:16:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <ziyao@disroot.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Anton Blanchard <antonb@tenstorrent.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de,
 Nathaniel Hourt <I@nathaniel.land>
Subject: Re: [PATCH 1/2] Makefile: Strip leading spaces when preprocessing
 generated_defconfig
Message-ID: <20250427161627.GZ5495@bill-the-cat>
References: <20250427145011.17331-1-ziyao@disroot.org>
 <20250427145011.17331-2-ziyao@disroot.org>
 <1526A781-5592-43DE-94F2-221DAA484192@gmx.de>
 <aA5RcIbI7uhsGmu8@pie.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LWTI2JxiiKlTaCDk"
Content-Disposition: inline
In-Reply-To: <aA5RcIbI7uhsGmu8@pie.lan>
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


--LWTI2JxiiKlTaCDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 27, 2025 at 03:46:56PM +0000, Yao Zi wrote:
> On Sun, Apr 27, 2025 at 05:19:04PM +0200, Heinrich Schuchardt wrote:
> > Am 27. April 2025 16:50:10 MESZ schrieb Yao Zi <ziyao@disroot.org>:
> > >Clang's preprocessor may emit extra spaces for lines starting with '#'.
> > >Lines with these extra characters cannot be handled by Kconfig and will
> > >be ignored with warnings like,
> > >
> >=20
> >=20
> > Do you have an example for reprocing the issue?
>=20
> Sure,
>=20
> 	clang-19 -E -nostdinc -P -I . -undef -x assembler-with-cpp \
> 		configs/starfive_visionfive2_defconfig
>=20
> or a smaller example for demonstrating the behaviour,
>=20
> 	cat << EOF | clang -E -P -x assembler-with-cpp -
> 	# comment line
> 	normal line
> 	EOF
>=20
> and you could see the strange indentation. For reproducing the exact
> Kconfig warnings,
>=20
> 	make ARCH=3Driscv \
> 		CC=3D'clang-19 --target=3Driscv64-unknown-linux-musl' \
> 		starfive_visionfive2_defconfig
>=20
> (Clang is called clang-19 on my machine)
>=20
> > Is there an understanding why Clang behaves in this way?
>=20
> Sadly I have no idea. I guess it may serve for improving
> human-readability of the preprocessed output.

This is https://github.com/llvm/llvm-project/issues/78778

--=20
Tom

--LWTI2JxiiKlTaCDk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgOWFgACgkQFHw5/5Y0
tyz6nQv+LXgX/m2GC4Qn91qDNBheIWijm6g3wN1bun4dVeHHDWyaExEJOsNn3Vik
sITAixpoYMFNtal/+sYQZncHnWqEJFuWQdnQd0HxNeJSOeED4axP2LnKGsiR8+xd
4qrZh21zLlv7Msfv/iCUf81o2uYa+7qsbJJ51mvhuewsdKdP2+2ZUl2FdML22hc7
7pwuvmnm0kubIWCbgU4Gese+i4s6JSQVQ9y4zHF18E/hONthlm97j836jFjD0xre
+SCGQLsiPKD6YOEJfyYD6IK34lzICZns+NAoUjX78i5SjEDEUO65Rcs/z++wgoIN
NYVi0QLPEyqp5d/31VrmV6pIf4yodp7httRxS+Ifl/pgTrIz59JnYicegVd5zzK7
aLIeVUUxLLx41rathK1iS1pF5PpZlzUgA7MK0Muir+I335Okc+EDJEPokWaP0X3Y
h5nZq9I8znpW7UodxE8aJTVCYbKuNgfIdF4/sLU1fCXmdMdj6XrHG0EGyXUwSsJ8
7pADFelt
=RQna
-----END PGP SIGNATURE-----

--LWTI2JxiiKlTaCDk--
