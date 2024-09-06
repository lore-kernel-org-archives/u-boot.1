Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63ED0CE7AA5
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 03:07:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 876C188CC9;
	Fri,  6 Sep 2024 05:07:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r5kKsdnB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33CA688CD2; Fri,  6 Sep 2024 05:07:48 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C740A88BD6
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 05:07:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4567f52bf69so9661441cf.0
 for <u-boot@lists.denx.de>; Thu, 05 Sep 2024 20:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725592064; x=1726196864; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=O8DmyuWrllD/Mk9+Ve1tWe/uYL524iVXdQx4S38coGE=;
 b=r5kKsdnBzk/stPWgPKe0tjERZf9Kruf80VSsDMIuIkqo2zw1/aCWYrMzTGP+tCDnT3
 eehnGcTAy+4QTOqOjLrfvqgJVhsl46jcppx9ZpQhWrSAgr9gqbu50Rp+k+b99rYEECBS
 pqsIEtUuXYK/f3qtG9JJRv3VMP9vzKF/OABEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725592064; x=1726196864;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O8DmyuWrllD/Mk9+Ve1tWe/uYL524iVXdQx4S38coGE=;
 b=Fzt94PS9h/kIoGVtnEnd9LpwoKluSC1UNzljA+zhgRxBtMZpDpTjN+b2hFMZXlgt1r
 wRGRXNDFd3jrn4TL77O96UaEeeLFJThidOgb/9Jg3+SePs/V7bqnHdvEgucp5ZlInBZG
 qIheCUdpfV65Xz3S7ktDx3lKh4CznAOozvDKLQL+d8x3zsaC4jPfDGPQwlevezG1VufX
 k5lMsq1DxqQtElhboH9Amhh3uVOI/mkCzvUcH8xeQrbWB/iHO+NtQtKrTRULjBuPMBE8
 4L56SvueB222a7E+TvyhDtWOSo1nWShsADgX/79SGBL92msfYtcETVlhFKSX6DCEWLPJ
 E5rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6EC9DyNgwz39ppU1E5zIbULMTwqEID4dtW4x0Zcsgmu9gdK/FYF/JYFSkYQGFk02lN7wbnXI=@lists.denx.de
X-Gm-Message-State: AOJu0YyPtPA9XiVHYpRKPgQit3wrAZIm+UqKSd2glD2EXbxvuEFQku0s
 7NqTCSiOcZXwPj2mnpNH5rUr6QUGhnM/6CFlyh2stgNq6KanESPvgQQZjkYYgUs=
X-Google-Smtp-Source: AGHT+IHb5YRI7jVo3DoJXQpAiznR1H+RCT0+0dhRM3oI1lFQ7+dZOsJBhN6m+HCE72XP8hojhBhihw==
X-Received: by 2002:ac8:59cb:0:b0:456:8ea0:3408 with SMTP id
 d75a77b69052e-4580c6e2f1dmr16337231cf.31.1725592064229; 
 Thu, 05 Sep 2024 20:07:44 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45801b35036sm12637111cf.37.2024.09.05.20.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 20:07:43 -0700 (PDT)
Date: Thu, 5 Sep 2024 21:07:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Przemyslaw Marczak <p.marczak@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] power: regulator: Fix error code in
 regulator_list_autoset()
Message-ID: <20240906030740.GA3840904@bill-the-cat>
References: <06ee0d87-35f0-4fe4-87b2-e498b2263ee5@moroto.mountain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/Rxv+lpmUgwXV7fP"
Content-Disposition: inline
In-Reply-To: <06ee0d87-35f0-4fe4-87b2-e498b2263ee5@moroto.mountain>
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


--/Rxv+lpmUgwXV7fP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 10:09:41AM +0300, Dan Carpenter wrote:

> This condition has a bitwise & vs logical && typo so it only preserves
> odd number error codes.
>=20
> Fixes: 3b880757abca ("dm: regulator: uclass driver code cleanup")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>  drivers/power/regulator/regulator-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/r=
egulator/regulator-uclass.c
> index 77d101f262e2..de2bb3b1cd88 100644
> --- a/drivers/power/regulator/regulator-uclass.c
> +++ b/drivers/power/regulator/regulator-uclass.c
> @@ -390,7 +390,7 @@ int regulator_list_autoset(const char *list_platname[=
],
>  		ret =3D regulator_autoset_by_name(list_platname[i], &dev);
>  		if (ret !=3D -EMEDIUMTYPE && verbose)
>  			regulator_show(dev, ret);
> -		if (ret & !error)
> +		if (ret && !error)
>  			error =3D ret;
> =20
>  		if (list_devp)

Unfortunately this then leads to the (likely incorrect) test failing:
https://source.denx.de/u-boot/u-boot/-/jobs/898197#L290

--=20
Tom

--/Rxv+lpmUgwXV7fP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbacfgACgkQFHw5/5Y0
tyyr8Av/TcGK9hK6oiXX/7zQmM7f10x+veYq5lfTyHVh5IGWbR8asDsD8Nih6sEL
2A/2EAj/WXbc99CJydVO+9aZvkY9G3vjOIGLrANb+jubdnDfTXHjVXF/zynD8OGU
/2hjwC8TXX343oDFN0pYona9t/pLoeLKy4lWHuuEAOH2P22IP/qb5hAXvP58Uysw
e0orqU9B4DDESB+e75iSEazzF3wNJOhvMQ6Wkv1mjw7cDz4Uap+6/DvSAUpaJ9SB
2uJgCae1tdPm4K++rwoV9rbmtCOAXPY/MAfnKrilZwuxrHMFv9WUztP/EVuar7D+
pi5h48b6IC/DRx1849qUWhl8h4gLa3ZoevskcyjJaZrjHiouFqP+0UB4MBP7tQUn
wwZFmM9FYW8wcvTmerJ7LmJy4Tn/AZRGXwJ8pewvXpdCGqETLDPpK6l9H21qdba9
ZiBn5PjT8K2OxGCLIUiDYyW9s9Wxxki7EYP4jQ09ECmSbxHL6s5r/IlDFrKuThZM
cKFSol4G
=3teF
-----END PGP SIGNATURE-----

--/Rxv+lpmUgwXV7fP--
