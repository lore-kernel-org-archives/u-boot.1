Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA7DC3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 13:57:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7768482CA0;
	Tue, 20 May 2025 15:57:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZjXPD3LS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA40F82B00; Tue, 20 May 2025 15:57:40 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8823182B00
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 15:57:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2d0920ce388so1929953fac.0
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 06:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747749457; x=1748354257; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W0Ptn7hWN/ETDMMvPfc3SiQbHjmUBzYCyNHIg3vpZGY=;
 b=ZjXPD3LS8D7h5IHMojpPoYTlfRDTur2zhsLFEF005vuSJssv6TXtbzhnAjip36tzua
 lKmxDitpcuHhzOIHonn37P5mdV4pOkQmt7onZ+3zV3gFssy7XP2LOdiQwMcuERIREb6v
 S0y1iYXnhc2OoT6mzthlm+Tcjyx7eF+vZrrBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747749457; x=1748354257;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W0Ptn7hWN/ETDMMvPfc3SiQbHjmUBzYCyNHIg3vpZGY=;
 b=A3ycCv0hFRvg8oOEayLzwswFWO3LzljCrGGaLG6gq2iPY104PvXjP+vufmGjo9yNdf
 4QR3wiFLxyBAWMRJxZIKdGkcgcaYSQ2v5yDCApAfCfx61im0zzsvzk8sDtB2M+ajgqlm
 vcgktMKdccrSThZBAcWk/wO2TtcWl8wYndr7wZn5v7uJBRoLawfIrVLhIXdfgSl4ZT02
 flyntuvFNvO+4rMQvXD3wVvIfNPT/BsumvwLNLu2Ik2DRFNXfz5oYKqn92dwcYkd0PjB
 jyit1f5f/9wCQrgy2PE4Wi+N36pourM9rPoJdMe6zQyTdVT2jsFYfKLy/OCnmIWrPvuS
 XVfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsxOTi7+9CTB47UA8a0pWJSY8fv8pRIaLLc7SnXz/jwmet2ANGWldPDKR7o2+D2DqA5YQ0dWk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3ZaF9IIkPcZ6AD0zudH2c3RYCcBjkptfrQg+dAR2/ENE8fCWP
 JZ9v4wxWk1M0Kz9qtAAeXXvwIkZikGGtKLdZ3B6B6oQ/36GZlik1+UzH4/sa+OTcgY0=
X-Gm-Gg: ASbGncsUrioi+KPvjdZOjoqRRLqdohCFe/gHS1+0MdphSoS+jNwoyxpgi1ZG4299dju
 cefJAXZw78pBeMGIAjgP1YNxSP6QDP0qkLIJegGqx/2u1cmiXFJkDoRbeOCd9U85QmL9uA6xb4K
 +V4wJw97a5Hm9c2qwugTduRp6EQJDBALDGAQzWIlDq685LUAu2mLUvbTZMxeAZ6oVTyXzfPOHyn
 1SyRUn+6lXVwqC5rLJK4aBd1Jgh9mdHgzZu8NJ243XV7K/kdDXwp0wpiRHNayyMjEPUDsg3zHvx
 iKZSz/GUsLlw+LTJ5z1tueQlO/cDULuirs2lJMudEWSiU5+bz6BN4XYbEUjwT+pRo6KN7DelGwV
 0ZyMdjUltWV9v
X-Google-Smtp-Source: AGHT+IE0Z21RrtFeJFixt6R4sgsQT5kwCkkU7NCpfNfpSq2I4YcpxHM4cgMwoLiWXzp9TNmTXOBl1Q==
X-Received: by 2002:a05:6870:f114:b0:2d9:3868:b310 with SMTP id
 586e51a60fabf-2e3c1c09e05mr9788667fac.11.1747749456876; 
 Tue, 20 May 2025 06:57:36 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c0b21cb2sm2165009fac.46.2025.05.20.06.57.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 06:57:36 -0700 (PDT)
Date: Tue, 20 May 2025 07:57:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Subject: Re: [PATCH v5 2/6] efi: stub: Change _debug_uart_putc function to
 inline
Message-ID: <20250520135734.GZ100073@bill-the-cat>
References: <20250520-silent_console-v5-0-ef9583d93285@thaumatec.com>
 <20250520-silent_console-v5-2-ef9583d93285@thaumatec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eepa+7lHTTs74buZ"
Content-Disposition: inline
In-Reply-To: <20250520-silent_console-v5-2-ef9583d93285@thaumatec.com>
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


--eepa+7lHTTs74buZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 01:36:40PM +0200, Lukasz Czechowski wrote:

> Update definition of _debug_uart_putc to static inline.
> This will allow to avoid compilation warnings about unused code
> after introduction of patch changing debug uart functions to
> dummies if CONFIG_DEBUG_UART is not set.
> This also matches the instructions in include/debug_uart.h and
> provides consistency with implementations for other platforms.
>=20
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--eepa+7lHTTs74buZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgsik4ACgkQFHw5/5Y0
tyz+8wwAmPoMQkYo68ZEMFCM1Gt7KR9BB05Yay9iqabUxPr0mEoFvKj4YYY9axc6
PdEbA3Zcohcs4kHy/RR/AhaNhq1JCFhFf4dbRjtxpdfSKjrZagRjy0glvvs6FvhS
jHX21L8EKqZ9VPChCC/jFFU1PPx5cCGAu6OvoExhuhlFpNd+SIhvnmnfWqFVoWmL
oZq/A9w5XQmcZS0N7gATthhwfZnTqSkMu8Sx2/12iG0kU9JNaf6qj7P1lZNCIG3N
sPpzzFSx391fHrqYuOy12s6tcRXYAhrCK1u4aCLaZMcscbIpwP2qOsWIbqsi3Hw4
PQN+YH0vRGPDIJwlvFuhfUOSdzAy0dcM+zmDZ2UqI4TfsXO5lAot3MTpkMQPypx6
/RSml67Zbgm1cWS7+RQupYX85WVu05cIyvzPCaeptQ+YWQTxEbNB+SfMuP/P/dM7
SomFa724taILlwo+MRve2BnnFi/nQBj7Uf0WN72du11JxToNWXcrWwewaw95B8Ul
n8aBHvGq
=+DoF
-----END PGP SIGNATURE-----

--eepa+7lHTTs74buZ--
