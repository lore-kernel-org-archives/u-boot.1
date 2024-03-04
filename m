Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B18C54E49
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 23:44:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78FC387FAA;
	Tue,  5 Mar 2024 00:43:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KpCRWIsK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A73B871C7; Tue,  5 Mar 2024 00:43:58 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E707987FC7
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 00:43:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-788336bf46fso19941885a.1
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 15:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709595835; x=1710200635; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/JXSU52biiNd0wshcI11Vb1V26cXYr48d89UzpXUYeo=;
 b=KpCRWIsKUIuNCzQNBp4Pxs+2cloNIRn1t76ZDrEORgmsxz1kkThs1l5tTRNC2sFrHM
 qcY0hVnLz3ka5/FwPDLHD2oGNXYy/tFER+t5FL36sYK+E3YpsufhiVleqylr6m4eYeMu
 eOclHWAEKZXkoO0MKgZauRj/8qe4VKCcaIgbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709595835; x=1710200635;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/JXSU52biiNd0wshcI11Vb1V26cXYr48d89UzpXUYeo=;
 b=c1OsFF3e1tUYwrsQqrHx7Kvkg5mh6DtnhUlW0b26zYmWfCF1eBqnl0dCSAwxLQHbIq
 PgWNOHWyIuT1pZn3k7LxKKPO9iL6h8kRxgeW/cz/Am0Dq1Yd0HYeBIk4yali7ToGAhzF
 zY9pSurLnmgDTP7mpKbpDpAhnWPzRtgqosrFlI5P2viWYf7p8xAy894u+q1SAk3EKKdq
 /DacXpoZsYmypx603A5ivdRX4oJ0sH+wT8whyRusko7K9nZNay+VvSbdSt6TFniSr2pi
 Lr+j5ERWGU6E1WYDzGBe6tH+fZaxhs9CftSLHkoOzm/bKmSOHowTCt1jGZAh9a7P2ORG
 9pLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULv25003UoRTUsnC+i7Xif7N5H0gZQhphsAOOOteKTi8KX5PG/iCZ5uUTZ+uHTyrn3jEGK5ZOP5WrjgbE/n6V0+Zcqdg==
X-Gm-Message-State: AOJu0YyT5rETIErEXeOX2aB0boJ9ZMwgSBER6xjyCXX1vvR/c35VXcRV
 j4Pyjjo8MB3k5PvUyuQ6XHqAFes/dq5o5jaEJUdvY0Tcrk8jqtdwSlX/adf9WGY=
X-Google-Smtp-Source: AGHT+IEbYaImD0SOQ8yg5X688VjtiNoZJXrEN7l7CuO5sGru4aL2x7z0QIs7oKwOWupaZorvvWB++w==
X-Received: by 2002:a05:620a:88f:b0:788:34fa:3845 with SMTP id
 b15-20020a05620a088f00b0078834fa3845mr381119qka.0.1709595834662; 
 Mon, 04 Mar 2024 15:43:54 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 pj36-20020a05620a1da400b00787fd080d28sm4704758qkn.74.2024.03.04.15.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 15:43:54 -0800 (PST)
Date: Mon, 4 Mar 2024 18:43:52 -0500
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Joao Paulo Goncalves <joao.goncalves@toradex.com>, u-boot@lists.denx.de,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 1/2] arm: mach-k3: am62: Get soc max temperature by
 grade
Message-ID: <20240304234352.GQ1523872@bill-the-cat>
References: <20240208092951.11769-1-francesco@dolcini.it>
 <20240208092951.11769-2-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TmIKkvpfLfPoB4Ya"
Content-Disposition: inline
In-Reply-To: <20240208092951.11769-2-francesco@dolcini.it>
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


--TmIKkvpfLfPoB4Ya
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 10:29:50AM +0100, Francesco Dolcini wrote:

> From: Joao Paulo Goncalves <joao.goncalves@toradex.com>
>=20
> AM62x SoC is available in multiple temperature grade:
> - Commercial: 0=B0 to 95=B0 C
> - Industrial: -40=B0 to 105=B0 C
> - Automotive: -40=B0 to 125=B0 C
>=20
> Add a new function that returns the am62 max temperature value
> accordingly to its temperature grade in Celsius.
>=20
> Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Applied to u-boot/next, thanks!

--=20
Tom

--TmIKkvpfLfPoB4Ya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXmXLUACgkQFHw5/5Y0
tywuAAv/X9SusMhdA79UHA1krkix7TvQAjB5QxJ9T6HsZStULqZLXhfPsXTIs6FP
20MonlKf+92UKep4crvQZiBeqT2dsE5KCqhGgVDctfYy0Tv0IV0hrRetw3kODNvU
1Th7yrrf2gdCtLJVZqHqfuetsavC8nESftwuhqi0SO/ekbBwUJ3tGYeJXw9nGoCu
47zBrSFUULL0hKMMJ3CpXJdBzPYFy4bYWwi6vS97N99tFHoq9U5y+dUiGaN8rWen
NOB0Qn/ILRJ6yGBuz/v2jTn63fJUMwk7Wn8mYoRBAtY2VTgGWhvb9unrCB+Qyskv
x8hDTl4L0d4uYmVGsu9O7W5CfeyChuT6n9rbmAphAdc+LoviLzUqSAJxYiekeYcd
tBw8gk7SDWZJ2VmlJAoX7PxFVSu/arJ5LI0MmPkhqASjdQbDldJ8uD6BqEp34euu
fMHYrc1YUwPdl4PyKP3YnZAqtBOoZFPXqJEMniOe+cmXeuGQOgi1KYbJ2rTgOCF4
Rqfytseo
=r2yj
-----END PGP SIGNATURE-----

--TmIKkvpfLfPoB4Ya--
