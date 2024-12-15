Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E104E7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 16:48:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B90D0800B5;
	Sun, 15 Dec 2024 17:48:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X/BWEd/b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CCC480086; Sun, 15 Dec 2024 17:48:52 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ADDC80050
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 17:48:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6d89dc50927so25193496d6.3
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 08:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734281328; x=1734886128; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pkzzgG8auriSH0wi2qDuaTcOTHLwXpMJcnFKviuUotA=;
 b=X/BWEd/bb597z3TSIrebTU4tJHepvDML/v1jplQ5oxl5scOof4Za59wzUSRZKZYcwy
 G2ccdJXyMFUkgOX4iXRxVg16XKnXivjJ6+dv5eP/nINmoBcT0XLhcTw526XP5hcF6CWG
 3Tz6OqHnrQv/nSZ+i17X1tWI144fW+Q4VHef4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734281328; x=1734886128;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pkzzgG8auriSH0wi2qDuaTcOTHLwXpMJcnFKviuUotA=;
 b=ohWRXLeAcNnqrzYwns+3Hloew9xqQpkAryQh/uKYrgWnX47m1xoKX0dpHx8rY2I8g0
 gE+g71nPpvV+zuI8Ln1LgCYBdCWJCC+yvwYZ4FgrpCPe9ROc0jU6QqAQL4cBnTk9i/s0
 urTZJn1lSroemlT0X4LPrqmT6hYfWyciHAgbFDmLK8Mi8F+BTRGP/AQ7TwzW3YBLZHy8
 XGrArcd9J5VFns3yTsjRNIeL3YwOQaHvEkDv438OrOKsHqSl7G+OgST00ntuGxZ1Fdfd
 cgXS9dMjf/ONxVYtVVgecQ919K7RhDagjBydVoO4KbDEhnjrICCKiq8nfmlmOhJJUAxm
 wqHg==
X-Gm-Message-State: AOJu0YzgXv/kauOLu9ctc6LnvEW5ec73TdI5oi+xwMagPg99+62fV8WW
 WADGmcdHCWqye67AiSE6+tL6CMjDBsWQDVavAbEVroVjlJ+kZqAKq8fJJj60oho=
X-Gm-Gg: ASbGncvc/gYMnm5r/hLGuOBFyTB3+PD1nCbL1cqIeBo6ahk/csRUBO5sXVang1bZlz/
 c6qKJsG75X4bA9Li9mFxQBNDrCNpEfnojAX8C5Z4vdKH7aHHSAgWqARv4xpzbxcECuhTYm+1Seu
 vq3tiTUDXHXgaPXOiAgREGxhoHUjyIZBhbN9/IN32WlV42Sli/17Kkx4jGsWqepXP49ARjrzW+2
 NeU3lBXrTOHT3/s+nio7yeRscZZSsSyhokdoridBXpfSSMiPM/vvTBq
X-Google-Smtp-Source: AGHT+IHPMyUK2Z2LD1TxLEeJejpxr2qoZXaGczkqfXgyK+KGp3PkXBLlKKAeGoz3jXSL9Uj0ZgxkAA==
X-Received: by 2002:a05:6214:f6c:b0:6ce:2357:8a2e with SMTP id
 6a1803df08f44-6dc9684fd5dmr172422246d6.37.1734281328403; 
 Sun, 15 Dec 2024 08:48:48 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd38074dsm17986006d6.118.2024.12.15.08.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 08:48:47 -0800 (PST)
Date: Sun, 15 Dec 2024 10:48:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: Re: [PATCH] arm64: renesas: Align configuration headers
Message-ID: <20241215164844.GD1505244@bill-the-cat>
References: <20241214224529.303866-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OGUD+kHzRGF3D4ws"
Content-Disposition: inline
In-Reply-To: <20241214224529.303866-1-marek.vasut+renesas@mailbox.org>
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


--OGUD+kHzRGF3D4ws
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2024 at 11:45:11PM +0100, Marek Vasut wrote:

> Align R-Car Gen2/Gen3/Gen4 configuration header file to look
> basically the same way across these three SoC generations.
> There are subtle difference between the remaining bits in
> those files across SoC generations, but the common bits are
> now aligned. There is not much left in those headers either,
> most of the configuration is now converted to Kconfig.
>=20
> Specifically for R-Car Gen3, GIC registers have been moved
> to architecture specific header file rcar-gen3-base.h , the
> rest of the changes here are comment changes and indentation
> changes.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  .../include/mach/rcar-gen3-base.h             |  5 +++++
>  include/configs/rcar-gen2-common.h            | 10 ++++++----
>  include/configs/rcar-gen3-common.h            | 19 ++++++-------------
>  include/configs/rcar-gen4-common.h            |  8 +++-----
>  4 files changed, 20 insertions(+), 22 deletions(-)

This is good. As a follow-up, since it's a functional change, can we
just switch to the default CFG_SYS_BAUDRATE_TABLE of { 9600, 19200,
38400, 57600, 115200 } ?

--=20
Tom

--OGUD+kHzRGF3D4ws
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdfCGwACgkQFHw5/5Y0
tyyROwv/btsbWJG3XOPBvZyaJBeCqbsM3D18sNikN6hRC1BwImqrdhCn+IYJ24F5
Uwq1BewK5vCgi+30cNQqwqrD5IcGSy8bTPlqKHirszIAk8CQuByz63Lo0Hq2MqKm
fOFgrHUiMpumnBxrlcD+eX66fj8u8o106AwmNiyESKwG59gz7ypK/r90FuzeBDLf
gtgPcMW2tyl4h738/7GaccGvmbR4yDwqIlC2Sh1qa2H2dmDa+ejCobh+m9GSTtha
fd0TuJIko+H1D76ZOIgJhzv1Kzki036juVgsh7ms7v5iXw5a/S8BpQclCt50AksV
64sP5PwW6Xl1o3wfYDYHj06RsvZEydxILFt0Pnlybz+fU0EDeNgehy6unGu+GtbU
/l3sPD7NaCJeSo2QXTlvVuzwe9oOmC5z2Gx6yG6VU13RewrqEk9NiKxHSxmEieRu
EFUvMKrgCfTutRSps348isUB96kBTN4W/Ivd1K/UV1cZAU4GsuL0161pZ+vBfKbV
SJclWlYJ
=m5GF
-----END PGP SIGNATURE-----

--OGUD+kHzRGF3D4ws--
