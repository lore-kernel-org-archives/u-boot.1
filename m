Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA23FC3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 16:01:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FA798129B;
	Mon, 31 Mar 2025 18:01:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bkADHF0S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BFA68171B; Mon, 31 Mar 2025 18:01:13 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 147D481026
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 18:01:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-72c7332128eso553471a34.0
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 09:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743436870; x=1744041670; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KmLattv02mLkZQP73ZhMB0si5vB+flpxwAYnItHWf5A=;
 b=bkADHF0Sk0JCVoBKbj8gdYYoliq4Etk+X0oHVYlbuwV5cVLu+bRL0o1f8YDmSDIpW9
 K1IGgrMap/2kxYgsRyaZX3KYUs3+ZGusTkBzyccCQ6rbDHNPDVFEQD6IeYlkQsLB/lcv
 7/yAuPz4IgaHvdqwx4PJIYWDEnx2cp+qib+Rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743436870; x=1744041670;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KmLattv02mLkZQP73ZhMB0si5vB+flpxwAYnItHWf5A=;
 b=XG7XcTGqX1ZSFNJNOwKCbZOLW6e2pgyJxV3KFM00UjTj5K1b36+vc4ZXO7VAPQK//S
 tbRu2pIVeHB1Ak5ddc/Fey9I/lrcB8pNVKoX35yIkNJC3K6/wQ9yiI7em3hHujMLGKrn
 MrmsJAKNfFM+kzitD/55wcEp4uQva/LUwrFJ330oAezwsVWIvbzejx5l0sqoYo8DnWBQ
 kgt2PPm02hvMvwV8v8qLVje3Le8O3qiLwNFc6+/Jvi9aVnKSv7+BDt86TBRPWQrQ0bCl
 7mieq9sGa3VEUxDUqOJEPyZS0MJLaFoQtBYVANViS2V0KHjOwRbDuNqUZXCMP4IhbCUT
 yt8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPZ0Ea8tRZ1z/Jaq9aULraORKyqX6ej/Mmxmiwe45zPNzJn9nJHnqqIEmRpJ4ue6QwaU9DAII=@lists.denx.de
X-Gm-Message-State: AOJu0YzPaEQ1HprALjqMkQycpuxn5oQphh9kkuKdGVTLKOzHOMSISiAe
 Q1eLxJBf0MrYIL6R3IdCH7fKzZwBy0TPacrJvUsUXAkq8I11hGmyR6ay7B3f1Mg=
X-Gm-Gg: ASbGncuVXGcRsoDLSG4C2Vq5v1Luopm35qRmIXyrpsRKY9fmiqPSFqlXFtiKVzTrNCD
 KA4RnowQHHwBlh/gobX5+YfUsTrTXWfrFIVhsDPlV7+JJbm2Wk+b2ixSglVcc9OCho07NMUj4E/
 RX+e5QrQxGvsA7je6Pays6r+CG8Ua3yjJjGf8INkQnDoHOMVzjXB3J0vmtVg3o1WWgmfy47UD5b
 E15BGxEAG514pUvy+dxNNbKRPk296+aEPkx93z77NVo+tn0sFsFDGPZObc336DM/z2R0e2c4cjk
 rsWQPOW3H1pAodaPpXnFM8Cawrh0eSOq0IsA+KusXS8CO69/r42abvw2VyJzeldbJco/AaH2YeH
 UOzLG3Q==
X-Google-Smtp-Source: AGHT+IEccOAjqvK6U0BLryD8WqWk0HV0mwXYnbBokc7eqg9tAiwd2qlubzfycdktahXH/kvauXi5tQ==
X-Received: by 2002:a05:6830:6b04:b0:727:876:c849 with SMTP id
 46e09a7af769-72c6383bc82mr6823314a34.27.1743436869690; 
 Mon, 31 Mar 2025 09:01:09 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c58092510sm1519944a34.10.2025.03.31.09.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 09:01:08 -0700 (PDT)
Date: Mon, 31 Mar 2025 10:01:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 10/18] video: annotate switch/case fall-through
Message-ID: <20250331160106.GA93000@bill-the-cat>
References: <20250327153313.2105227-1-andre.przywara@arm.com>
 <20250327153313.2105227-11-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0PjG73k6AST7qvGn"
Content-Disposition: inline
In-Reply-To: <20250327153313.2105227-11-andre.przywara@arm.com>
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


--0PjG73k6AST7qvGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 03:33:05PM +0000, Andre Przywara wrote:

> The generic DM video code uses an implicit switch/case fallthrough to
> provide fallback code paths when certain colour depths are not enabled.
>=20
> Add our "fallthrough;" statement-like macro to the video_fill() function
> to avoid a warning when GCC's -Wimplicit-fallthrough warning option is
> enabled.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/video/video-uclass.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
> index ff4f2199585..c684c994b61 100644
> --- a/drivers/video/video-uclass.c
> +++ b/drivers/video/video-uclass.c
> @@ -245,6 +245,7 @@ int video_fill(struct udevice *dev, u32 colour)
>  				*ppix++ =3D colour;
>  			break;
>  		}
> +		fallthrough;
>  	case VIDEO_BPP32:
>  		if (CONFIG_IS_ENABLED(VIDEO_BPP32)) {
>  			u32 *ppix =3D priv->fb;
> @@ -254,6 +255,7 @@ int video_fill(struct udevice *dev, u32 colour)
>  				*ppix++ =3D colour;
>  			break;
>  		}
> +		fallthrough;
>  	default:
>  		memset(priv->fb, colour, priv->fb_size);
>  		break;

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--0PjG73k6AST7qvGn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfqvEIACgkQFHw5/5Y0
tyxxwwv/VvcItyNTFxxi4i4QJsYjPT5A6dMdDI6jccor/E+q2+NVeo5AjZg2VTdl
q4Bk6V3d/rKF02qFiio4Xw3HV48Kd5Go/lJ07tTHz8shTKDLOR/Axy+HAAp/0AJX
u5kF5adYrKK6zDmwm2aeQsmaOmSrpgcYr57ComifOnmBsPjWUc7ZCL8hfCpDZn0T
OW7uluii99ELOS8xYgLlA8VranJrvXR/xqTKmQZPws5plpyYs7mCJHs5U+lap2J9
ijg7I69KuW7SNRFcr6GICeAA6t/cbWBmJ2I5dCd6yjQOHmLjwYND6zFcepJ7XSQf
zjKtGfVAslkVso0k6yz1duMDaztdjFlFb7gDnenCY8plxPpV2+pBksYRqufquvV9
FNsNlOjNiTigXaGqZ/arGn8tMlG5TZBwlRUirz9muk9eve8ipQlQ+dtX14BSLm1T
gO79SvsMUXkEd84H9xfL+wEJf58NfV4X0yLw/8s9xzhkOs14P6+fx9snvH7807Ph
7E0Qyktx
=xJKe
-----END PGP SIGNATURE-----

--0PjG73k6AST7qvGn--
