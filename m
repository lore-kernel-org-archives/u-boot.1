Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E56E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 14:34:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD3A380104;
	Fri, 13 Dec 2024 15:34:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LfLeFYCl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5531C8012C; Fri, 13 Dec 2024 15:34:18 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E1D7800D7
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 15:34:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38634c35129so1364436f8f.3
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 06:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734100456; x=1734705256; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1mShvr7pqI19htzCOkbhJzSBp4hymRlp/UTc7C9Hgg4=;
 b=LfLeFYClnyAztByU1Sjom/H/BH6ysOkMO5syExeU7mfVDIiSS5I2TT15d773uuaQLd
 hv5InK9OfWQgosXQqmRmDgA5snOpNVOe8qIfZ10ItlXluZnyXms4i9fiqPHDFgqogHu1
 S098A/e+TpImz2kU+vM2EpSVfy5XkvGecqt1cm6oB04eIvyQDZaQSDjZzzm6eRqnWkok
 a59tN0TiNw7AUpbYnza4upQzFj0Qj4pOq7j56w8d/CBjJ183QUS4+iCTfwHCuarXxHKS
 BVnbU1jJ2yI/anutUvXB4gj/OoQX8eXNqr/kCIBtwK95CXpIWNbK2+5OhGZvKJlejM+o
 HPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734100456; x=1734705256;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1mShvr7pqI19htzCOkbhJzSBp4hymRlp/UTc7C9Hgg4=;
 b=lSm7OD+gDMFlvTHkgaqcYCQDhNu06pb3ENQ424APilY+PzHOIbwhRxBqrH/7lnI3w5
 5UwJyGZjDDWJdmoq0S2yyygGoOiWwEqaPHYgaaRbZrDX9Km1dp5E0nVo45ypElBKgN9T
 T69ovFRIVqzJgPFZViqvIIwbYzWHTn42AftnHqFoo/BFWlxL+++VA/Y3zNh/LtErdWFI
 vPv6G0qRqA0ZdKNadB9AiGREd5hH/8VnXN3GfXa3aKmnzgaKaimwcDFkVc+QO3aa4LEq
 SWF3OT3WOXf+d+RjVhFaDVJw8Eg52JJGioe7154tjydT/9VtNZWrmrFreQ7lKcLE9/tS
 8zyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBjXsbSxVrBNQRKqlFeDvrkgh/pgktptxdEAAUtibAXDYWpbaNTv2LsSf3D4jzTtuKCG2yVjs=@lists.denx.de
X-Gm-Message-State: AOJu0Yy9TXafbA7YXYKisI4m7ttKi7LcvsvT1T7AMLjOZe18IPB20DFe
 F4ZPLUVqre0zSc4KliqcNhq1JgTuWhtWl/79FaY9cpnyZ+WYwO0R
X-Gm-Gg: ASbGnctn11CyevZJbDHT7YMfXEb75Eia5YrNBIwL6jkDTttE7j35QSrmDYW2zt/m9+W
 0rMuBJqeUxeARN6JpMwnsAzQ3bZbB7brMlxV+/GzsMXIRp1aC0uCOUn1Ri6n3Qj5o7kAWG3Yn3S
 L+I8c4hcVRjN8yyinLDTFe2cuOQOthSJL/PoO0C5H61rSen55+0+QOlEdJNopQEwCMtraB9eyRw
 8rgOmUSKX9yA1+VMYBhbrLNQzGdzUo3RFwreOycag50sEESHC1tgPIHvnhVZuhfryS1Xyhi1yTw
 ol8Ix62r8gW2pirj/7bryn1Mb0vciVpBH+Y29Jpfm9c=
X-Google-Smtp-Source: AGHT+IGiWVsoFtzPCl/ngj2A+E0Fh9Jbo/0uoYilON25nsNDW1kfYNCFK6yemAGFswp4E1P64JE40w==
X-Received: by 2002:a5d:6d81:0:b0:385:f2a5:ef6a with SMTP id
 ffacd0b85a97d-38880acd559mr2545117f8f.15.1734100455644; 
 Fri, 13 Dec 2024 06:34:15 -0800 (PST)
Received: from orome (p200300e41f281900f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f28:1900:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-387824c2c9dsm7245425f8f.54.2024.12.13.06.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 06:34:15 -0800 (PST)
Date: Fri, 13 Dec 2024 15:34:13 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] driver: clk: tegra: init basic clocks on probe
Message-ID: <6m2ximkbi6q2e6hx5dzfisc7kpr47iqubxi7uc3xo2nfqps6x6@hhbmkyl7zojw>
References: <20241212100646.5646-1-clamor95@gmail.com>
 <20241212100646.5646-3-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qy7rlynvca4m5lfv"
Content-Disposition: inline
In-Reply-To: <20241212100646.5646-3-clamor95@gmail.com>
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


--qy7rlynvca4m5lfv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] driver: clk: tegra: init basic clocks on probe
MIME-Version: 1.0

On Thu, Dec 12, 2024 at 12:06:46PM +0200, Svyatoslav Ryhel wrote:
> In case DM drivers probe earlier than board clock setup is done
> init of basic clocks should be done in CAR driver probe as well.
> Add it to avoid possible clock related problems.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/clk/tegra/tegra-car-clk.c | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--qy7rlynvca4m5lfv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmdcReUACgkQ3SOs138+
s6HFDhAAqvd03pfMFEhm5YXBdZxMEo84aJfeUD319M+r+BrCwsMkKGLnxMuPKdKz
WPn0sf0Ub7Whkl1PKAfCMb+rVJzncnzKJliP2mvh31TnIPdJ+AqYTdJivj6IzlB7
ZEa5AgFdg4xsYS8uvEPDGnkx/K7PRZgiQ/lhVEA2Cxo1P9MM5tpRV/7fSeGQ4xW5
2ABE4NOVdFRlaer4uibg4dDsnEsHrv2kItbyw+kCf/NnjCwXCTAkLe2e9hjUOQ6i
6peowqSi1sk3eFS7INvEQIBLGEtLte3RyrrQd6VjCyUhbfPS65byZeSal2XKUhsw
zgCFrCY9g7my5t7Jc7KnIqnOBQgzxV7LBRHrQW0r7HCrDqCPmFmi8LtoxnH8dzCz
uzqOzmEUuebgfHsMTUANjXWSkTG6B+EZYqihVcFBa8uV4RPG+QgDx58b5KT/hcE7
M5MWuhIOP3g4/q+K24oPDxgAy+b4l4iq3xnOnAjQ8k7eO2hNed4XL18lAdgDpk8r
bsHdSfxIxb9tXlzPkr9ky2pU6MCAZmG4zpBDR5mZyj0bMYEFznAw41kNbYb15Iyy
SVJ6k6PyQESYcbhupadV4CkCeOQff4+cgim9+mlAnVBTZVwv3kWgFGS1hWq2vZfH
i8UaGCoxfJ/vY7fjI9JwZvssDKtcU4QQV/3pIsEWf5c0uKtGUoc=
=Mt5s
-----END PGP SIGNATURE-----

--qy7rlynvca4m5lfv--
