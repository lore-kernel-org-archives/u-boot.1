Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A1CCD37B0
	for <u-boot@archiver.kernel.org>; Mon, 18 Sep 2023 14:46:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0617B86A30;
	Mon, 18 Sep 2023 16:46:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nqs8yGND";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EDC5869F6; Mon, 18 Sep 2023 16:45:58 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9214086A23
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 16:45:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-59ea6064e2eso10711697b3.2
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 07:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695048355; x=1695653155; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0Clj+9XMzA0BY2LYAWVHErydFm+wIi7AoQOd1JdZu+I=;
 b=nqs8yGNDmcZRIYe0CP7KWomUQDU+sDoJUAt7wmlKqw7P1FHu0VBom9hagk1sjD3Nn9
 b5T0TLFfO+gzyjEqFk8KKrw3d4grkjSfdDVpVOCZVDw3eTOpRvs0aNe2Hz6IOTIfqwkh
 /kUFYh8BT282SQOgr+m0EACORN5q2XkpjAJ+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695048355; x=1695653155;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Clj+9XMzA0BY2LYAWVHErydFm+wIi7AoQOd1JdZu+I=;
 b=gpBRa8OhRfLI/bB0zOgfGpYp6V21NlgN6Vu16PBlzUM2oSlHFLaDYpbxhW1dGVFJ4i
 sC6LHv40OwrphCrAHuPaYZ+yyzMiAos12LRqYNMymH+rVHqWsOojTmv0KLXno7C2LRLw
 Tf93XgZ/XQO6s/X4UkMTGhGUqU2RYtl0++KS6T3gRhTHDyUv3/7ybmg3LmxehTybsM4X
 RodB6i2CxOA1ylgMmB6wSaerEpTlgVdQQGzz3d9M8nFtG0O011bcDikMYAIXNKX1XdA7
 X1pCkweRhgubYYabzLRp/RLYwfnuNm3g+0IIMUnFHIMaMr59kxTTSedQeBNM/XFylX1k
 bGhg==
X-Gm-Message-State: AOJu0YxHzo31tl35iYvO8++Wx4wjPV1Aab/PMNI2MwgBMt28Y0zg9EsZ
 7Qgi4HnfgqX3n68Lq9dLxNYamH1iFdnQxbx+rISduQ==
X-Google-Smtp-Source: AGHT+IFo3iVdnnJLei5ABok38FXfqYYkc9HIejerKslVT5lvoA80q0yliJ+bVUR5Veo5ZuQzhBb+VQ==
X-Received: by 2002:a81:9381:0:b0:592:9035:8356 with SMTP id
 k123-20020a819381000000b0059290358356mr10193976ywg.26.1695048355369; 
 Mon, 18 Sep 2023 07:45:55 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-fccb-cc62-ada8-13e0.res6.spectrum.com.
 [2603:6081:7b00:6400:fccb:cc62:ada8:13e0])
 by smtp.gmail.com with ESMTPSA id
 q5-20020a815c05000000b0058fc7604f45sm2600496ywb.130.2023.09.18.07.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Sep 2023 07:45:54 -0700 (PDT)
Date: Mon, 18 Sep 2023 10:45:52 -0400
From: Tom Rini <trini@konsulko.com>
To: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de,
 dsx724 <da@lessconfused.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>
Subject: Re: [PATCH v4 2/4] spl: fit: support for booting a LZMA-compressed
 U-boot binary
Message-ID: <20230918144552.GT305624@bill-the-cat>
References: <20230910182448.285542-1-abbaraju.manojsai@amarulasolutions.com>
 <20230917192628.363502-1-abbaraju.manojsai@amarulasolutions.com>
 <20230917192628.363502-3-abbaraju.manojsai@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wyqNjs9YJEFBO1GH"
Content-Disposition: inline
In-Reply-To: <20230917192628.363502-3-abbaraju.manojsai@amarulasolutions.com>
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


--wyqNjs9YJEFBO1GH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2023 at 12:56:26AM +0530, Manoj Sai wrote:

> If LZMA Compression support is enabled, LZMA compressed U-Boot
> binary will be placed at a specified RAM location which is
> defined at CONFIG_SYS_LOAD_ADDR and will be assigned  as the
> source address.
>=20
> image_decomp() function, will decompress the LZMA compressed
> U-Boot binary which is placed at source address(CONFIG_SYS_LOAD_ADDR)
> to the default CONFIG_SYS_TEXT_BASE location.
>=20
> spl_load_fit_image function will load the decompressed U-Boot
> binary, which is placed at the CONFIG_SYS_TEXT_BASE location.
>=20
> Signed-off-by: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
> Signed-off-by: Suniel Mahesh <sunil@amarulasolutions.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--wyqNjs9YJEFBO1GH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUIYqAACgkQFHw5/5Y0
tyyIuwv/UfRRkBFpnuMZA4SvFSlqk4/0/q03tOBScVbIUIYVSpu+CWivuXqu40yi
UQHU6proCuhLn+RjgRBUPI5KIGzzM9Wkd9KUT5YCl0e+1IQjplIiNoj9rxzpmFNv
bQOMxbsYRQY6VQDWAlGMZbfBor4aCQdAn+OMs/o0RW630gqJCnSQIL+yigKaHbDH
kYiqDZBJN7fjinuQBPs1sZiDs/jq+7JfqN15VQb1uXk6SmYg98O/RnT+wdwfM3tu
8XKjsRUBdW4mZxtRyOUyNvYZCodMMHx1D0RPwCJSAfAG3xujB6VFt7amUVoW/y05
QtmkqEjsAvtVca74sMcPKhMDzI/Xzj9QML4uMfPa+XvbmJ6dlAyLP6L5xKGiTN9F
CLJw3wcsH2BxkEl93Kr/ibLxZISyLy3QQniOftkKf9q16kxlBM5PFpsQtYKnFbbH
bY+fcOdpZbwEeHZ3ou6W4/+39J/KEyxYsD8w8PoxW6YzfWnrHuDSGOD+r7sqFlUR
hqC4lm67
=6+DN
-----END PGP SIGNATURE-----

--wyqNjs9YJEFBO1GH--
