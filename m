Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035A5FD3773
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 17:15:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C739383FF5;
	Wed, 25 Feb 2026 15:47:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N1lK8Xcf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23D7584020; Wed, 25 Feb 2026 15:47:02 +0100 (CET)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4357883FF5
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 15:45:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=tempfail smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6774d63d2e0so2255161eaf.1
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 06:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772030756; x=1772635556; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DGvhStX3WSGX+qeJgfy8PFN6FSayBNjMLxZIOKQ3kSE=;
 b=N1lK8XcfhQyu6piFqBzaxrKn4rIwNJXrE7RvopLj2UCbj3eungW0SBk0dmtiNJldaa
 XH61/LKAyfLxz9CGuInUTqvZkIw5WEHCHWPgNH9tSFqDWbK9S0Y40hoAmuVTlMMzCsK6
 GkDkrRwCopAGAMSl36ttg/xtuxofvLF8rNv4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772030756; x=1772635556;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DGvhStX3WSGX+qeJgfy8PFN6FSayBNjMLxZIOKQ3kSE=;
 b=CAPVwZX4XG6PSq4PjuI6P9a4LTITIebXg+tIhoC+7MkVCbFFHXmYgV3SPh+cVzkQ/Y
 HbREJNiJRU5haQFPtrws9A5KnehZZlZ3ViAUgSVp5oRh546fQfOvDP+hN8eb0rUyZ98L
 Jb8C+x1ilZ5/S7tcizZqEC3TScdrdBWtUMaa3BfPCl5DwMMJvR4TUCxt+Cytz41mrb41
 6RoUaZlzDieB57t26748bRWFk3llVHz2oryrFB3LakIsV7+D0aW5vCYqBA5KbmcBwwp1
 H6dh+FNGFC3obpD0HGX7p28q84+wzBXX+BlvZ3huwaS2WmP/leq6zTPoHsedr3GaRhA7
 Gbdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6W/t5QFmBBoSaf4tnBU+3eWxwDbDl76BHEne0AAm9lX7JbGzTRZISANzs4FmqHPWPu4AwdSA=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9kKGic+0PT98FuovpbyD604PegF3+/9UOwUZMc+2Cx6Gz3lTs
 7bIkpVVT/wQRPLK5olfGfGttE4Hr4zUfEGJ0TNcSdmUeBS8N+XV1VAo5y4y5PtaPnKM=
X-Gm-Gg: ATEYQzwcSvKDUSOdeHg8E00ppwTOR4ih60Tkg3LSTAARMEIgW+Znb4bYaNOmglz4KK3
 pHhgDqf0/oySo3dkLpAsqXL6dG+Zohi2LcToCCiIntzo2qV0tQ+vto7NYVnpUyS3RyxVFrLSmE1
 Y9pRvwS6Y474vG5TcHZXXh9w7GM5khM3xH8+d8FH+KkJszWuZhph2u/w3NzDt/sE8hkGbpCkL/z
 kc6MW6k3ACTh8NnltB7FRvsjcIG1D5RyiizI2jwep1H0xif34oMegZY58VOzGFPpgDB7Jf2yIou
 kx4J+L/OvcYFvQe4+0UordriF9SrrArB2BvygXiRoSAF0cDs16LUAf6WEChKvQ3qBtOH2fIP+Pe
 GYfQyF0E388uvsVIEKl6Sa6MTtcWJWGdDA/eUEQvytBDuxKxFaea0kK6dFA8jGuA9tZEXAU61pH
 CcSxj9bcWt2Nq9ynmQbIxhKpCLB/GzQZWej+jnlg2Lv3wnAhG47G3VLKveLEYQ6qhG/X4Auy/Ta
 EAsiR7nqrKU2WO7V/u59dDm6OgEBPYdRkDdIIu4Jq2E7U/bBj0=
X-Received: by 2002:a05:6820:4b07:b0:66e:58f3:b500 with SMTP id
 006d021491bc7-679ef929cdfmr297388eaf.29.1772030755888; 
 Wed, 25 Feb 2026 06:45:55 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-679c5644224sm10680723eaf.6.2026.02.25.06.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 06:45:55 -0800 (PST)
Date: Wed, 25 Feb 2026 08:45:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Samuel Holland <samuel@sholland.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] drivers/power/regulator: add SPL_DM_REGULATOR_FAN53555
Message-ID: <20260225144552.GE1593142@bill-the-cat>
References: <20260225065714.48562-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AylGtJPLF4QRqvW6"
Content-Disposition: inline
In-Reply-To: <20260225065714.48562-1-heinrich.schuchardt@canonical.com>
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


--AylGtJPLF4QRqvW6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 07:57:14AM +0100, Heinrich Schuchardt wrote:

> Symbol CONFIG_SPL_DM_REGULATOR_FAN53555 is selected by
> SPL_DM_PMIC_FAN53555 and used in a Makefile. But the
> symbol definition is missing.
>=20
> Add the missing configuration symbol.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--AylGtJPLF4QRqvW6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ8LIAAKCRAr4qD1Cr/k
CtUXAQCkCsNdYWWTFo6m8B4tVjVtaXn8LiGww27KnA5YwNTQggEAlGRZl2/eV8aF
gYzxpOoxO6XgNBNnwGUZ7cb71z4SUQ0=
=Khj0
-----END PGP SIGNATURE-----

--AylGtJPLF4QRqvW6--
