Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB450E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 14:33:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D3788012C;
	Fri, 13 Dec 2024 15:33:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eG39HrS3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED1F5800D7; Fri, 13 Dec 2024 15:33:23 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D74B38012C
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 15:33:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so21997555e9.2
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 06:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734100401; x=1734705201; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sF4uUh+znN4wT0AYAouES0oWk3ODKLQ7KzP6zPGV1HY=;
 b=eG39HrS3c6tQIPygwRSFO3VexA/3N9bazO0WnNgh9mgkrk2qYeF2ofI3Rp52gG5Dve
 /ZgbevK16PnM7TB/hWOK3UqIz/7IixeZc78Um4pz7SaRh5HDZiEyWiSgBpyRhzbZPIJP
 PYW0mks1IxHwseVfy8rUeHNzfsKKBVXPLv6/hOTtFZ2XzQ9dYULFJmJ5wM6JaUOeyPYY
 059sOLyp3kG7EzPhu4AZy2AsKsLEzdgDNWgch7plGiINn981wJK/5E56pY5D+JcxiDDE
 Rbna5gHQsaXAhV37CVVBe3G/6zJ/zMOd2XMMUJRqmLHs1l8J06rF/OnUk851fQ09nLbc
 c81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734100401; x=1734705201;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sF4uUh+znN4wT0AYAouES0oWk3ODKLQ7KzP6zPGV1HY=;
 b=te4bn1dPrqrI1B7edJQfwryNxAjlnAFYd/EZX8NlHpo6SbOpHEfwI3ktcGzUJJKxI0
 BBi+ADJiAorAoTWTA2jzB2UnQVH/DvCkYH4UmYcGkBvktXtSCaj1f5AUS3WdjM/C0zvn
 46LL+MxbyHHlHAw7X+k69TA42LGkAaz785ZS78/fiaHZWTPyDKe4QHdJph4/mdVmeAcv
 k48i+sqYj5063N6pIDTw7Q4Shf6Nxl/214LjvD9hakXSQhW7Koy0LdN69ieKd3AGzc5/
 rthhmOGa2utvXqy0Oz3RU1ncRpoB19bzUF+Bk84LyVasdgFu6fY6NAjltW4mop9HEJsj
 gCug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxrT0Aqqm55f6fFiCX5y9LP5ol53KRTRObHmUdPbBCzJtqMLbwusaAqqlWV5lLZy0Jwx13Hnk=@lists.denx.de
X-Gm-Message-State: AOJu0YzMqnGijBErtJdmcl6zmNNc3+vCCvcwcPGBdcG3YgIh7DWL13CE
 4D8rrRYm49LwdAk4H3ur/T17vDdZXzG74c4xFrr2WdcGL9aZLgzs
X-Gm-Gg: ASbGncvLcerOTlMVs1LWCExfP+j2uLlhQOUIbpDb7R/AlTYPKbI8eWLETaTuR5FVYQN
 V/MolJMfpxQ+QJPu24qSOJLfQLm77EaRppN1aHVQiYPdj6ZaEg5bnZYfTgd1RQdu5j4mC2m1HxX
 tlRA20oXdkNg0fP6Y8mIed/gElL7Q0wgzfGyQB3zHrPutJ98w4I2D01KCp6Jt2jz25069Wy4vom
 fIpFDwfsvo7Ev6Dq0Sb7XCSUVmK9rCJpgNz+FAAUjhnJIylwXvK07rulmXDktYWSXEhZpwWBDEj
 j7gHdy1GelWYTmmf80zRxda6KySKj9p7lpyXKGh9YqQ=
X-Google-Smtp-Source: AGHT+IHNKqyIMW7cR8nNxVDAoePFAn2NLKmkLgoq667Kshq8sFYIEnYz6oxix3QOeXPINwmSDBLxsw==
X-Received: by 2002:a05:600c:350a:b0:436:1baa:de1c with SMTP id
 5b1f17b1804b1-4362aa36cfdmr28770515e9.13.1734100400909; 
 Fri, 13 Dec 2024 06:33:20 -0800 (PST)
Received: from orome (p200300e41f281900f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f28:1900:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4362557c608sm51179555e9.16.2024.12.13.06.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 06:33:20 -0800 (PST)
Date: Fri, 13 Dec 2024 15:33:18 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/2] driver: clk: tegra: partially support PLL clocks
Message-ID: <22h44kvaqrm7zod7e5g7jwgn4cupll6sw62yh2lhn3vricqprm@egfbb7akgifn>
References: <20241212100646.5646-1-clamor95@gmail.com>
 <20241212100646.5646-2-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mh24eo4xcm7m5awo"
Content-Disposition: inline
In-Reply-To: <20241212100646.5646-2-clamor95@gmail.com>
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


--mh24eo4xcm7m5awo
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/2] driver: clk: tegra: partially support PLL clocks
MIME-Version: 1.0

On Thu, Dec 12, 2024 at 12:06:45PM +0200, Svyatoslav Ryhel wrote:
> Return PLL id into struct clk if PLL is parsed from device
> tree instead of throwing an error. Allow requesting PLL
> clock rate via get_rate op.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/clk/tegra/tegra-car-clk.c | 49 ++++++++++++++++++++++++-------
>  1 file changed, 39 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/clk/tegra/tegra-car-clk.c b/drivers/clk/tegra/tegra-=
car-clk.c
> index 1d61f8dc378..dd4d7791120 100644
> --- a/drivers/clk/tegra/tegra-car-clk.c
> +++ b/drivers/clk/tegra/tegra-car-clk.c
> @@ -10,6 +10,9 @@
>  #include <asm/arch/clock.h>
>  #include <asm/arch-tegra/clk_rst.h>
> =20
> +#define TEGRA_CAR_CLK_PLL	BIT(0)
> +#define TEGRA_CAR_CLK_PERIPH	BIT(1)
> +
>  static int tegra_car_clk_request(struct clk *clk)
>  {
>  	debug("%s(clk=3D%p) (dev=3D%p, id=3D%lu)\n", __func__, clk, clk->dev,
> @@ -20,30 +23,50 @@ static int tegra_car_clk_request(struct clk *clk)
>  	 * varies per SoC) are the peripheral clocks, which use a numbering
>  	 * scheme that matches HW registers 1:1. There are other clock IDs
>  	 * beyond this that are assigned arbitrarily by the Tegra CAR DT
> -	 * binding. Due to the implementation of this driver, it currently
> -	 * only supports the peripheral IDs.
> +	 * binding.
>  	 */
> -	if (clk->id >=3D PERIPH_ID_COUNT)
> -		return -EINVAL;
> +	if (!(clk->id >=3D PERIPH_ID_COUNT)) {

Maybe just do clk->id < PERIPH_ID_COUNT and get rid of the negation?
Seems a bit more straightforward.

> +		clk->data |=3D TEGRA_CAR_CLK_PERIPH;
> +		return 0;
> +	}
> =20
> -	return 0;
> +	/* If check for periph failed, then check for PLL clock id */
> +	int id =3D clk_id_to_pll_id(clk->id);
> +
> +	if (clock_id_is_pll(id)) {
> +		clk->id =3D id;
> +		clk->data |=3D TEGRA_CAR_CLK_PLL;
> +		return 0;
> +	}
> +
> +	return -EINVAL;
>  }
> =20
>  static ulong tegra_car_clk_get_rate(struct clk *clk)
>  {
> -	enum clock_id parent;
> +	if (clk->data & TEGRA_CAR_CLK_PLL)
> +		return clock_get_rate(clk->id);
> =20
> -	debug("%s(clk=3D%p) (dev=3D%p, id=3D%lu)\n", __func__, clk, clk->dev,
> -	      clk->id);
> +	if (clk->data & TEGRA_CAR_CLK_PERIPH) {
> +		enum clock_id parent;
> =20
> -	parent =3D clock_get_periph_parent(clk->id);
> -	return clock_get_periph_rate(clk->id, parent);
> +		debug("%s(clk=3D%p) (dev=3D%p, id=3D%lu)\n", __func__,
> +		      clk, clk->dev, clk->id);

Is there any specific reason why you moved the debug() call into the
branch? It looks like it was supposed to be a simple function tracing
message, so it would probably be useful to have for PLL clocks as well.

> +
> +		parent =3D clock_get_periph_parent(clk->id);
> +		return clock_get_periph_rate(clk->id, parent);
> +	}
> +
> +	return -1U;
>  }
> =20
>  static ulong tegra_car_clk_set_rate(struct clk *clk, ulong rate)
>  {
>  	enum clock_id parent;
> =20
> +	if (clk->data & TEGRA_CAR_CLK_PLL)
> +		return 0;
> +
>  	debug("%s(clk=3D%p, rate=3D%lu) (dev=3D%p, id=3D%lu)\n", __func__, clk,=
 rate,
>  	      clk->dev, clk->id);

Same here.

> =20
> @@ -53,6 +76,9 @@ static ulong tegra_car_clk_set_rate(struct clk *clk, ul=
ong rate)
> =20
>  static int tegra_car_clk_enable(struct clk *clk)
>  {
> +	if (clk->data & TEGRA_CAR_CLK_PLL)
> +		return 0;
> +
>  	debug("%s(clk=3D%p) (dev=3D%p, id=3D%lu)\n", __func__, clk, clk->dev,
>  	      clk->id);

And here.

> =20
> @@ -63,6 +89,9 @@ static int tegra_car_clk_enable(struct clk *clk)
> =20
>  static int tegra_car_clk_disable(struct clk *clk)
>  {
> +	if (clk->data & TEGRA_CAR_CLK_PLL)
> +		return 0;
> +
>  	debug("%s(clk=3D%p) (dev=3D%p, id=3D%lu)\n", __func__, clk, clk->dev,
>  	      clk->id);
> =20

And here, too.

Thierry

--mh24eo4xcm7m5awo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmdcRa4ACgkQ3SOs138+
s6G9FQ/9F36x1yJUuI+zuQaCKaHC68HZdji1ScsdrwYN5937qidRi3esewUTztI6
ZpEJ9I6xU+DvQnqa3duotR942yVYH1dB+EX7ywJ3sPqEnjdxp1gSKqzAZWtU8Ag3
jAztkVTEQvj9AEJfDdUOEVZ6rhAsySAWVKo2HT+o9bZ7pIT4tYCG3fHEgNWVPv8p
BM9vO+Fvwf87VaS5yNOiWIZeRQZEQu8crS9mxHjJwTd6CK5vp4gUOhQMqK9GRNt5
A8M4TXeCpcJrRqgXic4+/W2EXEGG/yV95d03fwp91YbakO5OTzzypot9d3w/Pq8e
tTamtjBUG/VOHTy/rg4ltvUOd+YqZvqvL3r36znQwhTKYQh0O2hmXuI4lK6wCCuy
1R7gwr1IFYW5B8JSJsvJY299Oq+V2DAt30pRx59nZtmRgyeaXI2GQaekOU/EyaXg
5HgHMGuSYcVcHNLmszE8VEDstRBnV6SGUVxIwA5cEVJ0gN1aSfvXlDSXZl6WO06C
r/KBFhWtLJzSUKzvxpLd8WPLCvu9qCXsbRM9shUsp0qvk9mBOSbyXhhsa3WErMAF
KNFI61QJFE6oHRSqdElYfOPQYLiht3Xi7uWbx6JHhWOuZcOOTgceyYLmw4SVbZ47
DFKySwM7pqqvkAAQt4u//RN4/ai7ZNV6INukfqs9hrqpSbSdliI=
=6Waz
-----END PGP SIGNATURE-----

--mh24eo4xcm7m5awo--
