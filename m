Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D468FCCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 15:34:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 574798331F;
	Mon,  3 Nov 2025 16:34:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="et+h6NVp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F397838A5; Mon,  3 Nov 2025 16:34:16 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 941F280050
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 16:34:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-3c9c379af8aso3045328fac.1
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 07:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762184052; x=1762788852; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P6MGOKQ6Bi/fi0fJlvkEgVLhBk3a72j7KRpQtCm1ogY=;
 b=et+h6NVp5x2P2s/F+qOoZSR81vhHnGFHJInaajjpyk8gS7FErDsvj2m3oVZ3o2vmre
 OroXNm8WGgvKCSJOOJlSwkCbqP7jriQsw8cbTHEzEC5qrrtEZay8ndYw88OVwdU3h0MY
 9Uaxm4QFkiDPUTr8lYeZHWSGbR9rE6qvjo624=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762184052; x=1762788852;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P6MGOKQ6Bi/fi0fJlvkEgVLhBk3a72j7KRpQtCm1ogY=;
 b=gfNKPOJ5EX+vejwZFstlgSNrKjuvELZBAn3bo9k4vjkUNbkz9LRW1q9K58+suA6ymA
 d5yeiVmTOl/jpOK2noT/DPvGtzSv+6wAqguvfOD9Cx0VmukcCJKT534TPXIBJ7aOScxv
 lWZJEaERbRsl2P0o4gJPZNeFAng94OfgMWiKgbSrlHRxWZ7h0fs3ftxYVwi497z+ciP8
 yUvVf7hWceMqCOiI+wvdKX6RIaoco6LKcH5H4h/SbBKyTKcIaVn2lypMJCzOY4Kfi9A0
 l5HoC3eF5M/YHHfAi4+6NvdQp9O5DwxdDmgtp+tLiiCxKag+WU6PSR6C4PFzVHx23N0c
 vPWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7ymJjxn7KZCAcjdqVZe/s1Jvt8SXSHWX4ztsWdR/CQ7UWDycfq+x9hZ9K3EUEk0S28e4YznI=@lists.denx.de
X-Gm-Message-State: AOJu0YwXmPWcZXJmR0If2t17fF5RSfUF9iiFfe+ODd/CdZt9g2X/66kc
 a9rauZdYLO9fcFY6oWR3d6TENmleByH50r6NGk++wbuG2aoHY8rE3pLJFwnvG2MO0FE=
X-Gm-Gg: ASbGncsGxdBftw6PSTpVcC8zBBnx4L48nJhr+kiHNaa+ba7qNe5ncd2Lan3pXr/xQPK
 o0jpLOeM8404dK8CZdfbgkdjnIRJmSey7moxbdZQk47mUb0bfDxsMdgkwK1OGDjix3G36O3TXcM
 AXP83EIQNP398KSIFH+n/fn4OQOpUtzn2T3/9aEtZJYfUPdjaeD/uNwC1Od6vDdFd9OXSFZsXYV
 AxuLL7Fov6jZrnzGcjQ5J5yUzP1m0nW0RyFF34xmrXUWj1T3mh36jsou1FSg3Kt6R146WJg/Azp
 eoGVPmJdrNtCCReFbIw8G6ilzqn64M4f60U5NiSYUoHkUfKY9OzfrBLqwPDl71B+Yl8xadnM4I+
 0o0BMM5oogki9rkRFNzj1h/fSqvAEz0Pb5Oh/FAc2pHwte+w/xyKcbE03jwaD9tHqZetLx2JDTX
 BqFtfjf2Pn95eNkbPV5i7znqDNE7wYyMiApNePezDazEC6MJRfEXZ7NDG+F2ij
X-Google-Smtp-Source: AGHT+IG6lkXEPSSpKpoY2BLPjKVU+6C4eOiz0jKCy42AFORWlYpNEWqp0uey4GRrxfANszqDS3lEDw==
X-Received: by 2002:a05:6870:b626:b0:3c9:77fb:dc3b with SMTP id
 586e51a60fabf-3d8a5d009bdmr8082050fac.18.1762184052232; 
 Mon, 03 Nov 2025 07:34:12 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3dff736d560sm143337fac.18.2025.11.03.07.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 07:34:11 -0800 (PST)
Date: Mon, 3 Nov 2025 09:34:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: Re: [PATCH 10/19] dt-bindings: reset: Add reset support for Airoha
 EN7523
Message-ID: <20251103153409.GN6688@bill-the-cat>
References: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
 <20251101004503.2379529-11-mikhail.kshevetskiy@iopsys.eu>
 <20251103143808.GL6688@bill-the-cat>
 <db279009-c0dd-4649-8bb5-6cfcc00d378f@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LJWcsjjIA8BoTS+g"
Content-Disposition: inline
In-Reply-To: <db279009-c0dd-4649-8bb5-6cfcc00d378f@iopsys.eu>
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


--LJWcsjjIA8BoTS+g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 03, 2025 at 06:24:24PM +0300, Mikhail Kshevetskiy wrote:
>=20
> On 11/3/25 17:38, Tom Rini wrote:
> > On Sat, Nov 01, 2025 at 03:44:54AM +0300, Mikhail Kshevetskiy wrote:
> >
> >> Introduce reset capability for EN7523 device-tree binding
> >>
> >> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> >> ---
> >>  .../dt-bindings/reset/airoha,en7523-reset.h   | 61 +++++++++++++++++++
> >>  1 file changed, 61 insertions(+)
> >>  create mode 100644 include/dt-bindings/reset/airoha,en7523-reset.h
> >>
> >> diff --git a/include/dt-bindings/reset/airoha,en7523-reset.h b/include=
/dt-bindings/reset/airoha,en7523-reset.h
> >> new file mode 100644
> >> index 00000000000..bb0a28673d6
> >> --- /dev/null
> >> +++ b/include/dt-bindings/reset/airoha,en7523-reset.h
> >> @@ -0,0 +1,61 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> >> +/*
> >> + * Copyright (C) 2024 iopsys Software Solutions AB.
> >> + * Copyright (C) 2025 Genexis AB.
> >> + *
> >> + * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> >> + *
> >> + * based on
> >> + *   dts/upstream/include/dt-bindings/reset/airoha,en7581-reset.h
> >> + * by Lorenzo Bianconi <lorenzo@kernel.org>
> >> + */
> > This is as good a place as any I suppose, so what is the status on
> > upstreaming all of the bindings/etc changes for this platform? Thanks.
> >
>=20
> It was sent to linux kernel already:
>=20
> https://lore.kernel.org/lkml/20251017201126.493496-1-mikhail.kshevetskiy@=
iopsys.eu/
>=20
> Patches was reviewed, but not=A0 merged up to a moment. No any activity
> since last resend

OK, thanks. We can probably just keep an eye on this and move to
OF_UPSTREAM in hopefully early 2026 then?

--=20
Tom

--LJWcsjjIA8BoTS+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQjLbgAKCRAr4qD1Cr/k
CiSIAQCAX1yE3KjoRq9jnePziDrP8eLADc6xo6wMejbeoM8B8gD+Is8TSS24EzAB
eGmN69UUvs2hARbp6kpGXWum/JksDgM=
=gMOY
-----END PGP SIGNATURE-----

--LJWcsjjIA8BoTS+g--
