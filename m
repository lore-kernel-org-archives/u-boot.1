Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 561A9C47DB3
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 18:50:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BD1587BAD;
	Mon, 29 Jan 2024 19:50:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mbh095pi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E7E587C52; Mon, 29 Jan 2024 19:50:30 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F5C887B89
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 19:50:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5ff7dc53ce0so25290967b3.1
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 10:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706554227; x=1707159027; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5WP99vjicGr16zVj5huAI1+J4AjoDA5WMv1nxjXuRLg=;
 b=mbh095pis7rRTZsk722h0Hbi9aee5/KFBAmMmU322bCXWjadjj91NrfnMLy7QM7OBn
 j4IZPWJnT7A13pqcrcDLlCAxxxSFKzUKgkbKpQeDruuRJV4igeZG0pRh7pr4SRxqR98F
 VLPiNRIVk2ThjiWr++8ZyqBHVcWkbBxSlHI2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706554227; x=1707159027;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5WP99vjicGr16zVj5huAI1+J4AjoDA5WMv1nxjXuRLg=;
 b=KH4EDQh6vx2yU/2+ND4q4NkEcz/eJZHsBaV7WDt1JvUB0kOlZpnlUCuUDx5wexunyG
 zMApRQqDvrhydCtao37BZ5XolYTGOQ4rHUEOm3HG4jFlNxWT9aw84j1LDG/HTvLGGscJ
 V3L4Osgn0bI5Gx+KQ8IZG79lMjMozETMKFHo3t/1YypSkgRw7qmbSjklmhrgL07YVvZV
 9FUyYEaSkRQy55f/YNyT3tzitTLK1niQPKyfkbGZLwATyh3XMICkxDFNco6ZPUsQ38v3
 wpW5o9o4RmtIj0MPSA3FXFfc7aGGNGj6l1h3p+djevAXNYmi1WWnRJtupNcPDMvTcROc
 AiRw==
X-Gm-Message-State: AOJu0YygMD0Uu6tODxc2eevYMuoZqM07rw72CP8buRITITdwZWcvBffk
 sEef9J6I/SjacGV0ockQNOtKUKndCjo8NgiJPdsMWDC2+iLVIvQzKv0wkH4ctIVnCbdVEVR8dA2
 o
X-Google-Smtp-Source: AGHT+IF6/C28VE5pRRxixOoIe1K+vubBZwhJ2LwKLe+N1hH2LGOMRoc61UCwA1ZXiWII0MRYC/hG5Q==
X-Received: by 2002:a81:ae0f:0:b0:5f8:1016:9095 with SMTP id
 m15-20020a81ae0f000000b005f810169095mr3907067ywh.61.1706554226710; 
 Mon, 29 Jan 2024 10:50:26 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 fq5-20020a05690c350500b005ff7e023754sm2598162ywb.55.2024.01.29.10.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 10:50:26 -0800 (PST)
Date: Mon, 29 Jan 2024 13:50:24 -0500
From: Tom Rini <trini@konsulko.com>
To: Jagan Teki <jagan@edgeble.ai>
Cc: u-boot@lists.denx.de
Subject: Re: Pull request: u-boot-spi/master
Message-ID: <20240129185024.GM1152441@bill-the-cat>
References: <20240129175325.5175-1-jagan@edgeble.ai>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8UPxoFzVL+Z9vVDT"
Content-Disposition: inline
In-Reply-To: <20240129175325.5175-1-jagan@edgeble.ai>
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


--8UPxoFzVL+Z9vVDT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 11:23:25PM +0530, Jagan Teki wrote:

> Hi Tom,
>=20
> Please pull this PR.
>=20
> Summary:
> - Support Infineon S28HS02GT (Takahiro)
>=20
> CI:
> - https://source.denx.de/u-boot/custodians/u-boot-spi/-/pipelines/19467
>=20
> thanks,
> Jagan.=20
>=20
> The following changes since commit 526a865fe4fea59fb2638726c26e39557eb97f=
dd:
>=20
>   Merge branch 'master-cleanup' of https://source.denx.de/u-boot/custodia=
ns/u-boot-sh (2024-01-27 20:43:20 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-spi master
>=20
> for you to fetch changes up to 16dd10951015183f87b8202b8d4c8617da4f6d44:
>=20
>   mtd: spi-nor-ids: Add Infineon(Cypress) s28hs02gt ID (2024-01-29 19:34:=
17 +0530)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--8UPxoFzVL+Z9vVDT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW382kACgkQFHw5/5Y0
tyxkLgwAl9KmbHlcg8sG5NDUN0Z+XCO0M313BDjYec5rGnfkSMKqdaFJ7tiSeneT
RWqfUnRTeNGuWCIo+KpQzfl4Qn39iN9mccOecNOcqzPCTkgM+a3On8xNGjY33Ump
NmnYFvw4MQqdgjyVlpkXuy2fR8WZE17wBnXrQh7pioM+K0iXR+E81WlQIjbdCKKQ
DykjFsZEq8GIPC0EO4hbGcN1gRa56HXMCmVMQwO9Gb/xBE6T2+of5g3WqZ/05wBq
SThl64203WpXD6F1/eurVZ/6MTxYbrN0Z/Cu5TwBFpkKu65tdYJylQiF5jWb++5O
yWnbD3XZF15FSgNM7o3aQrZe1ZuYZavEE/VvnBbqyF5357jiwQLZfvgJo4AtNBk3
Ej6pYXDi5xll6OGBvZ7Du9HcLa6nR6ad8tj3fRxmOPWKRaPKT7XWwHyXIyj7a6wH
aXmhjrCjqkr72b8YSRgE4bTjQq300D5KU2cCAHaL2TO/cUEZqE0DlA+cEbsP9vt4
1yV6SdK8
=FK/s
-----END PGP SIGNATURE-----

--8UPxoFzVL+Z9vVDT--
