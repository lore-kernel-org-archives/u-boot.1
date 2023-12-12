Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5675DC4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 22:53:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DE2186940;
	Tue, 12 Dec 2023 23:53:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KMDBIyjo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19E7A86940; Tue, 12 Dec 2023 23:53:49 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EA098718A
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 23:53:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5e27647dfb1so4122777b3.2
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 14:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702421625; x=1703026425; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uLW32Eyt5aRM05YghElqohfNEhFQI20p1ckRyuLTAdg=;
 b=KMDBIyjoNCV2htkBSl2+QsoYCgMZoWjQG18JMCrUEZum+XBJwXrD0mFgziLY+jP9b2
 3v06V+mpIdR4AlzVLcNF6l7NosqezSjHgwx96dFovnGv7+8bEqe2Ak7t3plJCtcfBf9Q
 HIcpWDVEG46XfN3oz4rfcsScQfqK7o/2VtFvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702421625; x=1703026425;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uLW32Eyt5aRM05YghElqohfNEhFQI20p1ckRyuLTAdg=;
 b=KvTJ/1MSrswJXWF96jXEULtAT2umz3GjF0wI+gr9Nc+d/EGlZKzBZioDFxzJzLbAm8
 TCG7bbHunhqRcTd1aN6zQ38GVNaMCJkNlPGy/+myaUkh7Fg98VhCa3HOBnK+6aYarFq7
 CxPsm4sM6OmE5Sx0RwBXzjANAJ3s89I2KtTTi1WNslwPbbOQkhCZeqWmy2zSN2z9+9UG
 EbjOZUPWXhr6t2F0qzAoAhTSOV1CcY7MAmjU6d9zQkU9BwKCexMSjJws0Sb8V/e2i9Ni
 qrBVXn2Va92k3Z+NuZ/HiSjWasXUz25j7qCwq7awBn7CI5IJ02c5Zg1BW9xcNh9LmUfZ
 lXlw==
X-Gm-Message-State: AOJu0Yxrlke+G5R5d97i6zSyJz265CsjwsuNxGhTuRGIheaf4tzCTdEG
 S/wBA0T5QL4Hzn8F4zpqVxLfVHAKKCBt3uCUNw0=
X-Google-Smtp-Source: AGHT+IGtcJ5s4F/SprSr3dslUNzvHDWPcnhPTiUqAk7TrDb30Pez5Y2H+/iMyD+Hjpns3RFBgKlOLA==
X-Received: by 2002:a81:5b85:0:b0:5d3:99b9:93a3 with SMTP id
 p127-20020a815b85000000b005d399b993a3mr3334869ywb.11.1702421625204; 
 Tue, 12 Dec 2023 14:53:45 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d78a-ada8-3cce-fa3d.res6.spectrum.com.
 [2603:6081:7b00:6400:d78a:ada8:3cce:fa3d])
 by smtp.gmail.com with ESMTPSA id
 w184-20020a8162c1000000b005dde8f48a15sm4131305ywb.4.2023.12.12.14.53.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 14:53:44 -0800 (PST)
Date: Tue, 12 Dec 2023 17:53:42 -0500
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de
Subject: Re: Pull request: please pull u-boot-imx-20231212
Message-ID: <20231212225342.GC2513409@bill-the-cat>
References: <20231212162046.744484-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FlG51BVJfxx0LvsE"
Content-Disposition: inline
In-Reply-To: <20231212162046.744484-1-festevam@gmail.com>
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


--FlG51BVJfxx0LvsE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 01:20:46PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> please pull these fixes from u-boot-imx, thanks.
>=20
> The following changes since commit 65eed687729c28431d38c6c9174da4d878fb10=
7f:
>=20
>   test/py: Disable error E0611 in two cases for pylint (2023-12-09 14:58:=
21 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-20231212
>=20
> for you to fetch changes up to d3977b130a91459592c040c0321479bd206326f9:
>=20
>   board: colibri_imx7: fix emmc detection (2023-12-12 09:33:08 -0300)
>=20
> u-boot-imx-20231212

Applied to u-boot/master, thanks!

--=20
Tom

--FlG51BVJfxx0LvsE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV45HAACgkQFHw5/5Y0
tyzEeQwAj0yGkzB/fYEN1Jg346T6gOxVeMZMoV1echRvGDq2DVbSI+OHFUcTcUuI
JpqiuiBO76K8s95QpURFJ10BODBWKXGWR4mJXWDCVayjoZqm/7UVtDXfbp7A7oAD
TjPTQ+GFTprbQWMGSwF83r5GNabDXKAA7YuB3X6LPohw/4TwEoOtzD9j7GY0z2Ix
ZmTKo7wpZIXgO/vpTiueqShyG9xENrZsw6ozJjpmfm2GZwTzQ9ldoJb1f8Q3nQn0
AZjdYTy2HsBhHVqTQxMcC+VV/4eQgy7GD1R8zRIhJ8zlY56EwJJwk2gGkjWZM8mY
c2wyxIISFSjQ0JfmtAqy4pFBJqtf3cyB+Yr9CJoiF5bENgEaGPHBLLnQ7UDf4Jbn
6DMk8tkQJFENsM95wzzdINskSen1gAaG0A/WZBaKCwpAZbnskHJVmhs39tEXJ4Oq
PfYqp8zTEmyYB6r4mLIKz+sBuRBBey7pcOIQaw8n4OycG+e5FkpSDrJThJEQFC7E
QwfKjZCN
=Gj2W
-----END PGP SIGNATURE-----

--FlG51BVJfxx0LvsE--
