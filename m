Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5845DC8303D
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 13:53:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0533806D8;
	Fri,  4 Jul 2025 15:53:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="azh+dMhj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7A958206E; Fri,  4 Jul 2025 15:53:45 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C337F803DF
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 15:53:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2ef461b9daeso845384fac.2
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 06:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751637222; x=1752242022; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OEq+SjbwQSb+1+YFioT2vdfT0NT5VVvGa5BbNXp389U=;
 b=azh+dMhjRtkGFPxE4p7K66ayZRGisGJzcbKUD3/tVR4ekBEf6+57YU1qpOcgDnq1Vz
 6w+TOzvKFLTjibBN1xT5xppwPHJbs0oSwxSptgDe/eWapjQwd0xe8M1vIDt/g81NLptq
 jQxrAh/3giqE7Yb34d6osmLFO3J2GlbPsv9/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751637222; x=1752242022;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OEq+SjbwQSb+1+YFioT2vdfT0NT5VVvGa5BbNXp389U=;
 b=jKfadaVAcxsvJUfp5eoXflxrP3b95E2kWR4MU5aMAUitlJRaU731BQ/UR/9HjpaFHC
 Q0w+cFEvLWofMHNzSs6KSbfE3bVjMeZPiHqj8r/IGS4B9nFRVRAKHxDzc62V/P2NZJX3
 HL+KZQqVKKNWE3mJLZDY/qmAdnt2IuivB41bxkoxPjmgo6i/0yMkmmghvmTjbPPvWigf
 l4BkV8o8/wQC/n4Tndx9lXKyGu/iDxmRADIevSaoWgvJarf6EHjMUtErUWXCU6y4Yylz
 epF8DENnR3jDaZmg+dlvvfDDI5UPL892RfPbU2OpKTueznhAZ9Fg59scbfXZ6g9V5lok
 TJqg==
X-Gm-Message-State: AOJu0YyZe3p9Fl8gTZOd3ka7gYw/WWRa5NkpyLwkytOYSQaI9uItkmjj
 ozC6xWE+e9S53SJ2JNRYpSTI+HPc190l8+r/WX+fR6S7Rwfs0AWXhSk7W2MCZ+mHUNI=
X-Gm-Gg: ASbGncsjIvj2qaIh9Cu90r7V186AkhHvH8Ib+v/u365jm2a/YWbHwJ4GwQGTMDBsFTh
 WxQW/CEIhfmTJm5OeCc3a3gEJfr/zKQYFuE9aj0vgSWEw12wRXEI697v8uxs227kE70U+h/vcEY
 UYjhhAMSkjg4Of+GilPtdEOGa9cZozJvWW0W0mLHBv2wHGRVrOmexygptht+vPUIR1tk5ZlmBET
 LAirmOOY2SpdBk6iW6IViNZjDzSV0XdeZpVT920YlkpbBZyQtgnfsxqnXDpQrt5GoFmHuSaYyNn
 j28JeDqw0/rBgX1sFqnstp0+MIQcItqxkxo1TFzUxkHKJbtItfZhb8nkPp8L+mE0halvNtJQx61
 R8IveHehPmmPPRqBHXG1p
X-Google-Smtp-Source: AGHT+IH6cQmT9rkeA9sDE15FRA36CJ93bZGVC4TpbQZgQHLg+bbIKbqqcD6OG5BATknyUH+/mK5caQ==
X-Received: by 2002:a05:6870:e0cd:b0:2e9:95cc:b855 with SMTP id
 586e51a60fabf-2f796e02e37mr1568693fac.34.1751637222227; 
 Fri, 04 Jul 2025 06:53:42 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff4c088sm527608fac.18.2025.07.04.06.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 06:53:41 -0700 (PDT)
Date: Fri, 4 Jul 2025 07:53:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, jerome.forissier@linaro.org,
 otavio@ossystems.com.br, michael@amarulasolutions.com, uboot-imx@nxp.com
Subject: Re: [PATCH] mx6sabresd: Increase CONFIG_ENV_OFFSET to fix boot
 regression
Message-ID: <20250704135338.GF6424@bill-the-cat>
References: <20250704130319.3814676-1-festevam@gmail.com>
 <20250704133105.GD6424@bill-the-cat>
 <CAOMZO5AtVXOxWjMQeVeUtbU1Z_D_DvQ+0a7OzzHUskSK8wFJ6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GCKrrLtXFal2V5dj"
Content-Disposition: inline
In-Reply-To: <CAOMZO5AtVXOxWjMQeVeUtbU1Z_D_DvQ+0a7OzzHUskSK8wFJ6w@mail.gmail.com>
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


--GCKrrLtXFal2V5dj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 04, 2025 at 10:48:26AM -0300, Fabio Estevam wrote:
> Hi Tom,
>=20
> On Fri, Jul 4, 2025 at 10:31=E2=80=AFAM Tom Rini <trini@konsulko.com> wro=
te:
>=20
> > If we correct the size limit for where the environment is today and
> > switch to CONFIG_MULTI_DTB_FIT_LZO do we fit within the limits again? We
>=20
> Yes, changing to CONFIG_MULTI_DTB_FIT_LZO generates a u-boot.img of
> 715488 bytes.
>=20
> This fits within the existing 715766 limit with a 278-byte margin, and
> the board boots.
>=20
> After disabling RTEM and PLAN9, the binary goes to 715200.
>=20
> I can submit your suggested changes to fix the boot regression in
> 2024.07, if you'd like.
>=20
> For 2024.10, we can discuss whether it is safe to use the current
> CONFIG_ENV_OFFSET, as this is a topic that has haunted us from time to
> time.

Yes please, thanks! And I would like to explore a little if some other
compression algorithm (that we don't have support for yet) might be a
larger win too, for v2025.10.

--=20
Tom

--GCKrrLtXFal2V5dj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhn3N4ACgkQFHw5/5Y0
tyxA3QwAocieavw4fxyMIIcSkrgdubjKvyDIsrGMuqRHf5RH2PXEHGGA8Pe4f42L
9hdOjudpxR1w4CyXuOiFk4jRhaMWWjqz2rTj2A9N6H+yh4kcBuYN5HaSb723Fr/4
/rzzdmybdcvszHLqFNn5nvM3xuq1oX01DAwg6JfN5H5jlDwV2vqjQtAn6d7faSec
w4YBmp8ZrX3AVt7WVnQlpNafqvWESOFhhvNWT1+cFH350k7h9bV0uIcFbnWo3ySh
688k3zDftVC7IPf2jqBg+wYb+e0WhuX60Yika+vVcrgd9YAAydhGXBTvMm65+hL8
Niyj71GDpCGIfyetl5FPagXAMPNis4xLradOUjvp26qXgVJSPht3D54pcLNWt5C6
3hLZ98+qtc+CBh3Xm5P2PDgXClhLzx7EnEAJvgkhzk9a2SSLSOCDFk2L2ep5zNJ3
a6UGahcGqSO6cCtBel8G4T3r8BfAsIsu/3Lzno6HLWyffMSV7lMdc9apueeuB/uD
ciO9BQ3M
=r7KW
-----END PGP SIGNATURE-----

--GCKrrLtXFal2V5dj--
