Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13490C61CE7
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 20:56:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91EC381F0D;
	Fri,  6 Jun 2025 22:56:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jlsV1a7C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62E8D82145; Fri,  6 Jun 2025 22:56:08 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E716807B1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 22:56:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-408e0986303so1880760b6e.2
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 13:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749243365; x=1749848165; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iL1pv4794qzDGdN6XvE4R4lcxKbkz4Y8jgKdiZfuRss=;
 b=jlsV1a7C0MIGrqdNZX8t3C99lvoD3Pv2M8TunaZPWXG64XYU1ndIAyyTn4i7RLE6Zq
 gy4Kl6hutNhQYNde5saesMVEhlCiJONtb230px8c1EPcbq372WuVrIbG23gNOzL/RNBA
 YeyOwK7W+vVxh8f4n5eunOEIcB5VJZBflaOuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749243365; x=1749848165;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iL1pv4794qzDGdN6XvE4R4lcxKbkz4Y8jgKdiZfuRss=;
 b=v9C/1mOdSs7S+rkUsqqnwDmuzRYchM0c4FTNJDW6tnkXK8hIYEuLX/nLI7dhQZFbTL
 7EqbDxTCWPqebil/CKO/mWNWKvzHTqj8UfgNdVROfpqN1h/+R5Unbe6IfjThtVAinET+
 wOdPPTpnav9DCG8hTDHIhp6VhF+II444Xzq9ljq1zBOAzQNxSS4u/RMmh48MdtQVaJq8
 Da0XtJSy8RmFQcABsGYf7XVtSDyAX1TIX78Po8OvSelNArweIq7lDwpgdKWJxwFKaG3A
 SrAz47l8iwl2Iu8AUGrveR+z+Vdts1AzC6dmIezRbI6vCRU1ZoY89bYjci++LWBxvl8R
 SzVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB9/BEeqcQ/XHnH/nxx7EFQAUwPRjHhGBJn1u27Zr6RqnpL6ezvW9lkUKI3APJq9S8nrC621E=@lists.denx.de
X-Gm-Message-State: AOJu0Yzrtzx6xyMqCzZyDwhsQ3AfzZhJCLyefjTbJQg/PsKb5PdHgb+n
 Zchk1cvhhmPCLWdOINeDimqTAGik1zEr5NFJ+ICH6qV8+yKbgl6aLQBFoxVlDFZZDds=
X-Gm-Gg: ASbGncuJud51MebJ6AUdxwiDcWjWJ/HazSjWonJF1wtrvhZ36/EIzuFhbKX2FsA6gkT
 jQ6BK+wvT9VG/QTqlOOFENSeNoRqtffecVzqq7xA/R0ghxUDpFy4Liy/wK4awpWkHiEgCpwKwCJ
 rxcNcknRbbnnjABr0WB5hd+Mv0obdkccs55GXyo0GKuzVsw8jiAMc/imWyLt3yikLg4kt9Aq1RM
 hEp40LmEw8PFKGDFNVz4W8wRwd9f2vPjpQlU+jOVaIEvmsnfyI2a9OYG4aIQ61ObCfJnw+ELtBt
 aq7J+aP8hppCV0KfzljbEMhfa8c8jjPMrkaCIBumSoJNTWC1RyCQLFs8wwAEIU7rQDbvLAeJBeQ
 EqLpL1hopv/mZ
X-Google-Smtp-Source: AGHT+IHHydz4842RkjPp28Q3sRiDF/pA8iVA73iLVyilUk6FIprZtflZwLqpVVKjBOaW5hqGjC2ayA==
X-Received: by 2002:a05:6808:318e:b0:3f8:3eeb:11a3 with SMTP id
 5614622812f47-409050ba574mr3618187b6e.11.1749243365018; 
 Fri, 06 Jun 2025 13:56:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60f3e66fc6fsm360548eaf.17.2025.06.06.13.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 13:56:04 -0700 (PDT)
Date: Fri, 6 Jun 2025 14:56:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Edwards <cfsworks@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] common/spl: improve error handling in spl_fit
Message-ID: <20250606205602.GD1382132@bill-the-cat>
References: <20250606193524.458095-1-mikhail.kshevetskiy@iopsys.eu>
 <20250606193524.458095-4-mikhail.kshevetskiy@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DApz30Vq0G+KqAfp"
Content-Disposition: inline
In-Reply-To: <20250606193524.458095-4-mikhail.kshevetskiy@iopsys.eu>
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


--DApz30Vq0G+KqAfp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 06, 2025 at 10:35:24PM +0300, Mikhail Kshevetskiy wrote:

> This fix possible NULL pointer dereference.
> Also some comments added about potential memory leak.
>=20
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  common/spl/spl_fit.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index 783bb84bdb5..438d1ecf124 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -703,13 +703,29 @@ static int spl_simple_fit_read(struct spl_fit_info =
*ctx,
>  	 */
>  	size =3D get_aligned_image_size(info, size, 0);
>  	buf =3D board_spl_fit_buffer_addr(size, size, 1);
> +	if (!buf)
> +		return -EIO;
> =20
>  	count =3D info->read(info, offset, size, buf);
> +	if (!count) {
> +		/*
> +		 * The memory allocated by board_spl_fit_buffer_addr()
> +		 * should be freed. Unfortunately, we don't know what
> +		 * memory allocation mechanism was used, so we'll hope
> +		 * for the best and leave it as is.
> +		 *
> +		 * To somewhat reduce memory consumption, one can try
> +		 * to reuse previously allocated memory as it's done in
> +		 * board_spl_fit_buffer_addr() from test/image/spl_load.c
> +		 */
> +		return -EIO;
> +	}
> +
>  	ctx->fit =3D buf;
>  	debug("fit read offset %lx, size=3D%lu, dst=3D%p, count=3D%lu\n",
>  	      offset, size, buf, count);
> =20
> -	return (count =3D=3D 0) ? -EIO : 0;
> +	return 0;
>  }
> =20
>  static int spl_simple_fit_parse(struct spl_fit_info *ctx)

Since you have a good comment in here can you please elaborate more in
the commit message, thanks.

--=20
Tom

--DApz30Vq0G+KqAfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhDVeIACgkQFHw5/5Y0
tywL+Av/XEwH4SIRcwJF0uWciaDKUoVOxG8Z2a9/A0U17YtLvJ9tx+yS9ExX4stu
YeAHkRInNqEDrNMmBiq+wwsOGBY+Ne6cCb8ZKYUf0to5dJoXMDoEn4cOqBFxIJ3J
uL0WmOYCWLE+PBD3IgfjKV1e5d7uq0TdJyOUzaZhd/gzdkdwgh3/YgGhrC6z0CnG
2ssFDeSMYvoNnkT74dthsrP9gkqJcX0e9/mqS2GZy7jsgBA3j76s/FhUJmpOMH+q
PZPMDAdCs+GHzfrAQod8RNl8AdEUJlNicxLuj79N3l1velXwgQ+DQLAKVR9PVhI0
F5mBkMK+YCy0J9bX85WimoHgPqojecYULBrFfua0PNtSHFdvePwvDBlbkFJH4wV+
jxtQtAJHONWI6OiUI6LtbTBOAB19k3UD5YR8GH5bdjp5eKs8YcNHP55YDMWTi9E7
uowpTGUeDh9HxFkjr3AonxNb0+Xsbwoz6mvEHJ3B5KFuRrNh7lpUwkxe07sz0P/x
Ch+QXAEl
=IwqS
-----END PGP SIGNATURE-----

--DApz30Vq0G+KqAfp--
