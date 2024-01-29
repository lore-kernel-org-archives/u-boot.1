Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E5AC47DDB
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 17:34:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BD9D87C44;
	Mon, 29 Jan 2024 18:34:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rYGo0+1E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EA7887C52; Mon, 29 Jan 2024 18:34:24 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 834AB87947
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 18:34:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6039716f285so21792957b3.2
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 09:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706549661; x=1707154461; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dBUtWC5LOK+rI5NY0KmiF98ex20e4/UKX5mGrDcqX3I=;
 b=rYGo0+1EGtldqliILBI6246wGT0ffYjFjk/2RaVK1Ovmmdo8hO7MsMX+/if3uvnwND
 Z3dshBNRZkqCyVPrkc4x4Lk22dDketV83BlIXVfJv6vZWJybXu18xA6ms5j1ev7a1N8R
 yAVLOIxQytDGagnZDhBl/WaPon9mJKem8kelM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706549661; x=1707154461;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dBUtWC5LOK+rI5NY0KmiF98ex20e4/UKX5mGrDcqX3I=;
 b=nPoiBbAb061D8x2S2R4MGKNA9w64HpHJDD/frrPjGWHwkBSwU4cNbg9SFecIY4FsKI
 wwH4J3Je4TZxDWWF5TdSNrKHpxiroinnQpItco4uC7TM+PQkqqFsfcgNYLg/+sCPGDUq
 lTswIAYK3gDtW/iSkFm3r7LntXS3OOlGYe6afOWvAWUOe3pd5tZDVeAm8+BxtSWdcVRM
 u5EfE9IsS5j5O4ksxP754NncQmpu5HfHB+Gz4wBELxgr9ixHgrWOKw+Yx92tTbbRk8s3
 4GG3wVJTNGHTB0yJvFaCfh/x5QCm3Rcf2rqocbWlb/Da5T8LghN/vJIcgUDHaXBxeatZ
 d5vA==
X-Gm-Message-State: AOJu0YxjT+Gr0yI9eu3bZgJQmjdsZrhrXbhS7+XqjM5zwoXHkjNgvkPI
 vDiUobZLM8cPq4j5+9+mo/axdiMv93UVrG3Ca7mCxF8lIkDLEBCjUJyRUTpho7Q=
X-Google-Smtp-Source: AGHT+IFcE/dQNk7Rvh8KugX3SXXRikgjqXst4QrfQapizXKHSPUjuaMMYSKMMhL48Un4iXCFmpEVVw==
X-Received: by 2002:a81:b3c3:0:b0:603:cbe0:465e with SMTP id
 r186-20020a81b3c3000000b00603cbe0465emr3055342ywh.20.1706549661318; 
 Mon, 29 Jan 2024 09:34:21 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 t73-20020a81834c000000b005ffddb2369dsm2618483ywf.82.2024.01.29.09.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 09:34:20 -0800 (PST)
Date: Mon, 29 Jan 2024 12:34:18 -0500
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Samuel Holland <samuel@sholland.org>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Nick Alilovic <nickalilovic@gmail.com>,
 Chuanhong Guo <gch981213@gmail.com>, linux-sunxi@lists.linux.dev,
 u-boot@lists.denx.de
Subject: Re: Pull request: u-boot-sunxi/master for v2024.04
Message-ID: <20240129173418.GA1152441@bill-the-cat>
References: <20240129155543.2439451-1-andre.przywara@arm.com>
 <20240129172449.0b9ebc9f@donnerap.manchester.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="o21KAyWGNZ5OpIQV"
Content-Disposition: inline
In-Reply-To: <20240129172449.0b9ebc9f@donnerap.manchester.arm.com>
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


--o21KAyWGNZ5OpIQV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 05:24:49PM +0000, Andre Przywara wrote:
> On Mon, 29 Jan 2024 15:55:43 +0000
> Andre Przywara <andre.przywara@arm.com> wrote:
>=20
> Hi Tom,
>=20
> > please pull the sunxi/master branch, containing the first part of the
>=20
> I just saw that the CI pipeline failed on missing maintainer entries for
> the two new boards. Is that a showstopper for you? Shall I update the
> branch, or would a follow-up patch be sufficient?

I've fixed this up myself this time, since I was doing another CI run
with this for other changes but in the future please fix these errors
before sending the PR.

--=20
Tom

--o21KAyWGNZ5OpIQV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW34ZcACgkQFHw5/5Y0
tyykswv+Ie9wTeyz9icds5xcIv0dw8+TRYhFe+uKrjcZjRE+mbVy/AP9VKKd0xAl
BIh7HQIiDyd6CCNZ4uq8eFyEUFoGeqhy4KzgJo6UlZ97mVHYskdUuGoQ/3DjRqLA
fDHGwkFNkazIXgy3rsCfdP0dv9OUXvI4BdiIIcMQYZWIIzcvmHofYL0m8j5hloa7
xg9xzD7GVd3nDBDfTS0WvEBIenZuEsgkzv8y9ML5vwDWDPermkykwLi/UrfopHLs
FFk95Eb9n+iSizftxQvd8czBHCyXOwaSVDou587lJq8t+H7lVnn+i031wnARUffy
gltlUtV9nh6uoWLf0U+xB9T/09GNUusZgKVOWm26d5GN3Y8SREnWv+HKEwIBP5Nf
ZBzJMim4mD8sx7OIGUO3hgYoT0KkFEjvViSpfNqRZEpjQGMhowBRcw+unJQULRX4
LTERrB6xQ2ClUVEPH8oOLk8w8fa2ImRbIvfg5qcEsgBP6S+XgqZD6y1hIbqSpnRO
7VMeYEUw
=ClI8
-----END PGP SIGNATURE-----

--o21KAyWGNZ5OpIQV--
