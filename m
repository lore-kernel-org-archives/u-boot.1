Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDEFC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 15:22:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C186888548;
	Fri, 21 Jun 2024 17:22:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p08ha6HT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 886AF880F1; Fri, 21 Jun 2024 17:22:43 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B04688549
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 17:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3d22378c59eso1197714b6e.1
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 08:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718983359; x=1719588159; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=g+G/uip/4rzw86kez9CZ6GwBEqV7i01QSg3EBkmSTi4=;
 b=p08ha6HTwDlCZfKo0JH7JKornc9kfDubrJCGfssgBAqN+ouuHQwMJuogt9qonkDjJX
 a0zGnTeeZW+02ejcbJGFwpQadKagiMKSNY9C2VY8J8pIJib7R3qE8ON3flCSrd0xttfv
 L/p/TATOVGLenmXfD+4hogkzSkTQYvd+B6SvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718983359; x=1719588159;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g+G/uip/4rzw86kez9CZ6GwBEqV7i01QSg3EBkmSTi4=;
 b=ivL14TN5P+OrAm+myLOCLPideY0IDToSo7lX/QZJCoH4cEMSnXpMfGILNMk62YdAEu
 yDSewKAbsVR7qcOoRbfoJsHwtsQsD3jEXaHGJBn0ED84SQuC6VLhmWuvUD47EgGlG5JQ
 rP/fStKFi0mbEYMIHsYiZlB//LIC481LiBrD3n639KulNDHN2HEcXfwBonc0Upfb87Id
 3G/7QW+U8vRTaf1opboRqG+GBVLIS3uoYNRq1wywHIjubkHAOF/KukTJUP5hl2K9Wcsl
 m2GNIvQNXGaC/U0s/NUloLO5mU+/TSVLnO98WHuCyWBs2N7uHo43yepyQOOERvs/8YN3
 pByQ==
X-Gm-Message-State: AOJu0Yzvk6e3kwjCYZ172a11dnXHlUBXdQ56HWPyqrBq2RA6sYYjVNlD
 rUQfS8ZshWsnqr9+HOhLCW8svD6NwLbw6SIEaIcmFZM35ik8VZmL8Zjm0cMRXHo=
X-Google-Smtp-Source: AGHT+IFevaGDlf/S8nV5PMqSJmQr/HWZVOwWvKjIrSPFxXK8ETUxRsXfieAXkifrmL3up9kU0ymETQ==
X-Received: by 2002:a05:6808:1b10:b0:3d2:48b1:c0c1 with SMTP id
 5614622812f47-3d51b96585fmr9754741b6e.3.1718983357974; 
 Fri, 21 Jun 2024 08:22:37 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d5344ddd92sm334731b6e.12.2024.06.21.08.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 08:22:37 -0700 (PDT)
Date: Fri, 21 Jun 2024 09:22:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: Re: [PATCH v2 1/6] buildman: Add python3-coverage
Message-ID: <20240621152235.GW68077@bill-the-cat>
References: <20240621131423.2363294-1-sjg@chromium.org>
 <20240621131423.2363294-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4lnzYYexjS02bRKT"
Content-Disposition: inline
In-Reply-To: <20240621131423.2363294-2-sjg@chromium.org>
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


--4lnzYYexjS02bRKT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 07:14:17AM -0600, Simon Glass wrote:

> Add this package so we can run code-coverage tests for Binman.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--4lnzYYexjS02bRKT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ1mrsACgkQFHw5/5Y0
tywIagv/cFUJ1Vq8x90RttbPe+MmIFIgixEpeSjSv2HUyz7zsdxoMRcLtGiZjoks
AR4t1XqtAqA+61cGt3HzwRSG5R0b1OS8dlMZgQeGZL9l8vZPO8bS4MaQ2h/5Br/J
tdZDSEUALnzU49D91INcprB8QoCSz+zQ2NHcDEAt6qw0j8+PFN8v0E7ACuh+aFNx
sKdd90Fz6dx7kp5SaZbHwOdcqzB5wwct8JVsKaWRByHaBA6AJIzZ3rAq4apTuvO5
oWYQ1ZiyAx+Tt/SMj4rUmbof9EYrs/Be5lO5Y14cyx17kiq7IJ5rBwOLySlQexCf
IJfv5uNRXowAu6bdWEeo717YbQ903TadnJT+jiv4gzwONJ0aZzyzxdLcI53lfnaI
P0BmGlB+axhbwWuev/g1GhpwjErR/79onSkhVmcqxIGuVgJLjhLfKSLLURetGTbc
k7T4RScTpGrN1Bu6ig8EFyCclh5iKfW5SO7zLx19pVrE803KsMLq9PkQugGICuYV
YARJ0YYD
=LPKR
-----END PGP SIGNATURE-----

--4lnzYYexjS02bRKT--
