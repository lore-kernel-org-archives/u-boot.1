Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3354CC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 15:45:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D85B878ED;
	Thu, 11 Jul 2024 17:45:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Hp9n4bDs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 462C487F5C; Thu, 11 Jul 2024 17:45:27 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 067508704E
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 17:45:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3d94293f12fso426209b6e.3
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 08:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720712724; x=1721317524; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SV19XBw0D7t7taaUCbSa3ycSbNVZkGoncVtum+Jsc1U=;
 b=Hp9n4bDsPkaHf7ChKaC1NF/4iakisvf2DOwWgp71x1KppV0xxj5lBhkONJ9KPhkSqY
 ioUh9up/QddrK2FcSVUS5vz3/QByR0y4h91mYJ5JFzC6Hd1jGkFhC5UT0H2xP0ERZ7Ye
 /BVWvYGXpULbAFiEkDd850KITiOFiNY/Z6GNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720712724; x=1721317524;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SV19XBw0D7t7taaUCbSa3ycSbNVZkGoncVtum+Jsc1U=;
 b=HF6pjms/E5oU6fYlVHwiT/J2dkzqZnQyXV9q3gqfQWWbQs4Fz78V7qoBcEuJlzCXz0
 0+GTbM1CZvLBIMjWPC0ZNIsHrh2EyZwe1I+oBzbKjqkxfutZoPO4X4//UDnGnBAkqpAo
 ZkC6JVecxkzxQV6it4W32rEsRCkHlt5r6PwEuOzNfVBUY1HW1szzjDNnK4sE4E/jJpnm
 f2UNYhjdNwfkFgus9LTelp4jZs7dX7F6LlfdGyrqKWVfPv+cjrsGERvycjFCz5PFuHWt
 e9MLoSy15jpR9I2C02hKmTNcp5CGkb4h61xiJTB3F0CQWC1/DkQLEiJK9mX9U3QQPP69
 IOPQ==
X-Gm-Message-State: AOJu0YwGpLbHHYeC5sXnlaHdD7jITJ1uJepV9arAeXwEQ6D+xR7nXGr5
 wd8fsnqq8er9yTsNbiYEdJAhJscH9stUlNo7LzVJhmymZi67Wnv69otu4WbcxQ0=
X-Google-Smtp-Source: AGHT+IGcT8gZu21nNlVKs7aY7ZQnU37tN6VF0CbNrmDeVofiJpkXbT/tH1prNrvrPSTI3sU6DJuAcA==
X-Received: by 2002:a05:6808:1451:b0:3d2:2833:73e6 with SMTP id
 5614622812f47-3d93c07839fmr9723665b6e.46.1720712723735; 
 Thu, 11 Jul 2024 08:45:23 -0700 (PDT)
Received: from bill-the-cat ([172.58.30.202]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79f190b6bf2sm300002685a.135.2024.07.11.08.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 08:45:23 -0700 (PDT)
Date: Thu, 11 Jul 2024 09:45:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Richard Weinberger <richard@nod.at>
Cc: u-boot@lists.denx.de, Jixiong.Hu@mediatek.com, sjg@chromium.org,
 patrick.delaunay@foss.st.com, ilias.apalodimas@linaro.org,
 seanga2@gmail.com, xypron.glpk@gmx.de, upstream+uboot@sigma-star.at
Subject: Re: [PATCH 2/2] ext4: Fix zalloc()
Message-ID: <20240711154517.GA2391959@bill-the-cat>
References: <20240702194223.31998-1-richard@nod.at>
 <20240702194223.31998-2-richard@nod.at>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1gZhQA3e9flRsAAg"
Content-Disposition: inline
In-Reply-To: <20240702194223.31998-2-richard@nod.at>
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


--1gZhQA3e9flRsAAg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2024 at 09:42:23PM +0200, Richard Weinberger wrote:

> The zalloc() function suffers from two problems.
> 1. If memalign() fails it will return NULL and memset() will use a NULL p=
ointer.
> 2. memalign() itself seems to crash when more than 2^32 bytes are request=
ed.
>=20
> So, check the return value of memalign() and allocate only of size is les=
s than
> CONFIG_SYS_MALLOC_LEN.
>=20
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
> FWIW, I didn't investigate further why memalign() fails for large sizes.
> Maybe this is an issue on it's own.
>=20
> Thanks,
> //richard
> ---
>  fs/ext4/ext4_common.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/ext4/ext4_common.h b/fs/ext4/ext4_common.h
> index 84500e990a..0d1f72ae01 100644
> --- a/fs/ext4/ext4_common.h
> +++ b/fs/ext4/ext4_common.h
> @@ -43,8 +43,14 @@
> =20
>  static inline void *zalloc(size_t size)
>  {
> -	void *p =3D memalign(ARCH_DMA_MINALIGN, size);
> -	memset(p, 0, size);
> +	void *p =3D NULL;
> +
> +	if (size < CONFIG_SYS_MALLOC_LEN)
> +		p =3D memalign(ARCH_DMA_MINALIGN, size);
> +
> +	if (p)
> +		memset(p, 0, size);
> +
>  	return p;
>  }

The problem here is that "zalloc" is inline and so this change causes
about 1KiB of growth on platforms which enable ext4 and so at least
mx6sabresd now overflows it's maximum size. Looking harder, I think the
best solution here would be for ext4 to stop using its own wrapper and
instead call our kzalloc compatibility function.

--=20
Tom

--1gZhQA3e9flRsAAg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaP/goACgkQFHw5/5Y0
tyyUogwAlE4HeL2UHusrtwSdJiboHVXr4CyIL+b+EpDTUWSYIFAgvrkyj9AnHFWz
f289YPbExSk2dyug603KK85XNSR87589EMYpzxuIeLNobVAZEoKdgVW4AXyUJpeU
qWofk786igQwuspYcPKuiRi7wZf+kUn4l/RI0LQVfvebXdi/YfSSlSqEi3LfUP/+
hbqsscR7Pg2LfRatjrbdzZ6ikii8eGk3YopCvYLk6cuCmNDycGulf0WJ10h1LVVC
tleEhfB5VjKnve4qoak/q7vmfh2x4DXb2ADG/Zdlx/nR4nRBwH9HKwcF7ch2otMK
ursuDe5ESzefrhyqurf9uFaZqvupcs2qh9tRep7lZ0LexOdxVbOoRrI29ESOiCpU
K6BZ43j3Iol7xnUEbxsaIXRchzJx3+L7BEZ68goD3815clLUa7+pKrFu6dQm0C+u
ZSmxQd+8BjdHCnx8q7XUCHbHnJl7HCuBoK44jzYDAuJN63FgIEDwfaWMR+RVEuSo
nNXdurLP
=KaCT
-----END PGP SIGNATURE-----

--1gZhQA3e9flRsAAg--
