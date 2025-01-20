Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25376C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 20:52:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97178806F8;
	Mon, 20 Jan 2025 21:52:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dPci9y7F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B4318032B; Mon, 20 Jan 2025 21:52:40 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CD4280771
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 21:52:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b6ed9ed5b9so89398085a.2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 12:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737406356; x=1738011156; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PFkIMzjN6x2WG94x48inu2DPYlvnDe4Vi669qi+Rb9k=;
 b=dPci9y7F/4lC+W4hDniXLYZmqbtHm9KINvcLfnkK8A0lJYsHzqZuQVht5ENHfK2rFR
 nBfYGbosze0YJCZXspqvVkbNScp9i7q2H8/GQsSYP8UMCU2c7fBpto2SY2QMrb6L2lwU
 PK96chTyCDdRdfDObN1k03T9PmPKoj5ZQ6P+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737406356; x=1738011156;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PFkIMzjN6x2WG94x48inu2DPYlvnDe4Vi669qi+Rb9k=;
 b=UiiMS/SDBVZzKOGFIq5FxNs8bsA4HOFchY5FVmbWOquzwMFvOMW6qW4X/P0+o9CfDR
 PtfmOvgEXPBD5jRBrA5IF52EiJy2vLQTSm2oC7w47XGSt8R97jkffLR3BT60hlJ+NphB
 LCQOZiFAR63e5QcG/diMu+pX2JTNHoXXAoBqrACpepiVZRt/7IKsIWlzrJmymX1fTzyn
 LyIzJs7kcbDTIM4zGrq500aO7ghi1LvYzNYBSkCLZMCEF6IlpNlGu5fK0HxEqqE08dCW
 rp3L4mpz5150Uc5+Gzwq6bn/xvw5JW8lYW/xaH/q0XopGP67zhj6rqIpwPH6jaDA7OjT
 HuxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTthD08naygDKGw+eIdMbwnr6M31OIUQmEPP8ylSMYAoIquaqkPiJ0RjeWcsQagsayEfmLD7k=@lists.denx.de
X-Gm-Message-State: AOJu0YyLt//TYJBpkU0355kzswu4rJ5OMvYNbT3iObwfpQkJ/1wQYelO
 b1wo7gP+CPLarwtjAFXlAjmxcxuUHmmDo+HBNm7ehZcGrSU39P9A/HuDxuL66B0=
X-Gm-Gg: ASbGnctKoj5rOGqBP4Uk5hQxmLGjQkHnwxLN/M9jQFPZbR5YgBBIGzBjIhmDbg7NSl6
 D8iHgKGfviHWQUhNAclDt1fj045tbL/tuhHqjgPdeRzjsB2x/legZpn6JiaZWDTBvGYBzEiXB+7
 HMEHHlY/Q8f8OgnEH8+7Tc19JLQCepjmmirB1SKR19nzGA2/fdoDs3ovRBDvBVhJevF6gRP8zLO
 kgZMZe2hfqIh/OzT9tk/A3WuvSexfLht+EBrhPaiFeJCbE4IC3mA6zYgNtrdHkHVbI=
X-Google-Smtp-Source: AGHT+IFCAKpjBdtWl7JeU3aKroNgpPzk2T2kNtpKCAbDwxpBvzWkIsPYpJm1YkiyFUEx6PpLunRLWA==
X-Received: by 2002:a05:620a:439b:b0:7b6:6a3b:53af with SMTP id
 af79cd13be357-7be631f5df0mr2200408285a.14.1737406356108; 
 Mon, 20 Jan 2025 12:52:36 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be614743d3sm481239785a.21.2025.01.20.12.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 12:52:35 -0800 (PST)
Date: Mon, 20 Jan 2025 14:52:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Massimiliano Minella <massimiliano.minella@se.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/1] cmd/setexpr: support concatenation of direct
 strings
Message-ID: <20250120205232.GE3476@bill-the-cat>
References: <20250105104614.7916-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="v29rMn2WZcUggmCk"
Content-Disposition: inline
In-Reply-To: <20250105104614.7916-1-heinrich.schuchardt@canonical.com>
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


--v29rMn2WZcUggmCk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 05, 2025 at 11:46:14AM +0100, Heinrich Schuchardt wrote:

> The setexpr.s command allows to concatenate two strings.
>=20
> According to the description in doc/usage/cmd/setexpr.rst the parameters
> value1 and value2 can be either direct values or pointers to a
> memory location holding the values.
>=20
> Unfortunately `setexpr.s <value1> + <value2>` fails if any of the values
> is a direct value. $? is set to false.
>=20
> * Add support for direct values in setexpr.s.
> * Correct the unit test for "setexpr.s fred 0".
> * Add a new unit test for "setexpr.s fred '1' + '3'" giving '13'.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

This causes ut_setexpr_setexpr_test_str to fail.

--=20
Tom

--v29rMn2WZcUggmCk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeOt4wACgkQFHw5/5Y0
tyyMswv+LOJznj8WJR19vB/P5dfXv4u9VN2g5un8fI/DaTXhFVQpgLNmfEPeRH5g
ub71ZSxXrP8vBp8uzAFZ9s5jNfIGN5rk4JMBIyKx7esnTozocM+Y8MBKCKwJ6ikW
zlwth2fMmnVRdisUHelVYZNNJQsIQetGKH5QDJohC/Pt9mr+6+hIx63uGlttU0t/
miki2MdjYQSYNaIXvRPUKYHNroFWvHy1DUrMY2hVuZ8OsSxB0BChqL4npISHDkGb
3n3Yuni2n504PIS2K6KWOhYDvJ+sTvpHwqFxLEvM+u7kvq93KDolIMo04yAD1+31
sNFnb0zGTdG6euep5fGbYOpgyHmT+ArRkj0YFQkYZ1itzJlwPiGd2kC4cxvZRF4g
XXZamkqLY3z69OJT8sCwqmQzzycP9hXe44ch8agJ9nusrhGrFVNP7sDQ9J/cHX+r
vrlBmemz8cr2fVe1T6duCtSda5X+wWtgTM0skl7fXla0tJzHycWb3vQPlwZ5FwO4
u7AZGRiR
=bGk2
-----END PGP SIGNATURE-----

--v29rMn2WZcUggmCk--
