Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47EF4C77B7C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 14:43:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6CF082CFA;
	Wed, 25 Jun 2025 16:43:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rL3Rwtzc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA9B982D21; Wed, 25 Jun 2025 16:43:48 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B06582C4C
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 16:43:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-72c27166ab3so4289951a34.1
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 07:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750862623; x=1751467423; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HGfpY6F/hPQHbEqy1T1cd+GxRnYxbXYvFYCz83oeBec=;
 b=rL3RwtzckQ7qPD5U1T74vlJYl+wV9pfHriUYaU+oWzTBssAhBkvLEVPurg+DBcDLp7
 K24VIUwDB0DNYyJNoGxgYSgBKMknViHS+7L3HYwmEbAJOLr6Ltn3otl87iofebrkzRWT
 /b1aleH5EvqGGClVaNlXszpFYsC9ieLNzgjv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750862623; x=1751467423;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HGfpY6F/hPQHbEqy1T1cd+GxRnYxbXYvFYCz83oeBec=;
 b=R46zxkJcz8ORg2DjpjI8ignu/8uh3dBqYKvrVJIbjcD185Bt68evrk1PbaR/u2MI05
 hSk5elHS6I/6FhBSKuxaINkCljK5sj8oUCXg2v56bKjOAhRGcEOQQc3WrhjyxBQuyb8l
 jUTejOlYoXgJV0K6/wcwD9sd1rMwEPZJ3kLoHmxdRzhwhamEUdnuMSmC9Y0zPiYYF5Po
 5gcNJiVWR+ej6poxEPKDzRNslNND9dsvYmfxZQlCvZwDURAaxmeqjDuGhdB4b02s8wNj
 LJMqY4A+qOErFQbnDFckjVQVFii8IfXVfk0jJgyB/1yVD+ZMMg/nrB9wTrCXdSQcbapp
 YRNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp1SZ3hAn0XmFES/coPKe9V6Enz8adU+/MoAYCzoogMczoltNYCeDupwc0jA22YAOW+cz+wO4=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1IeqJpzHRSrwXGgz5CZFRkAM653FwvLRXLcbB9hf5bOEHojWC
 qp4+F5Mk9mrq5iCXJlrOcQ0vr6UBADo5FIQuah6GbhK9wG3pEvBahqQCcfaoCJge7e/aavRyc9z
 RxNH/XcI=
X-Gm-Gg: ASbGncvTqrTTUFJHMiyb1f07rUlVpk7rQMI9LUp3mjYe3oL0hO+Lsbc8i5TJxJpDc8Q
 OU10t8BjN9AkZHqRmrvq3TbI+GheKNGxPEQBraXFF4/rNtFilUAkcNeYo9qMLwnYX3uQA2Yl99J
 W16d5vK79XuNBtggGMmcIpVm3HJDSYrH6iAKOoNM6XhHMoK9QWG1PxIr1rX0iMzFZlvwPNFrDAR
 TafAUdIYgwam+mDknWsmlThVfoeyjNQjIskA3aihEJ2fZtfZuElTuPjUIF+4Q27uKoBCnmWin4Z
 oZoafhs6MEEDWjIHCJMW0cnz7gQfMC6greYyIcPbHnqpknwVDCTRNve1VhwkMkWQNpVenLjBQ/z
 3jqtD0ho2dAO8jgxlHTLV06s=
X-Google-Smtp-Source: AGHT+IF5fl8mv6itiZMM5oDp89bV/7eKTmeQx9DPEpEhaogFwmHrEwOk3ddQRlr/e2/p9hRR4uWJ2g==
X-Received: by 2002:a05:6830:2a03:b0:735:27:2703 with SMTP id
 46e09a7af769-73adc8d368emr2312260a34.26.1750862623087; 
 Wed, 25 Jun 2025 07:43:43 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a90b33b17sm2261018a34.30.2025.06.25.07.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 07:43:42 -0700 (PDT)
Date: Wed, 25 Jun 2025 08:43:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Safae Ouajih <souajih@baylibre.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] cmd: abootimg: Prevent use of unintialised variable
Message-ID: <20250625144340.GP4003484@bill-the-cat>
References: <20250625-abootimg_fix-v1-1-ce1645ac9879@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TrVRZP7V2Y9zK5o1"
Content-Disposition: inline
In-Reply-To: <20250625-abootimg_fix-v1-1-ce1645ac9879@linaro.org>
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


--TrVRZP7V2Y9zK5o1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 12:15:53PM +0100, Andrew Goodbody wrote:
> vhdr can be used when not initialised so detect this condition
> and exit early to prevent the problem.
>=20
> This issue was found with Smatch.
>=20
> Fixes: 636da2039aea (android: boot: support boot image header version 3 a=
nd 4)
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  cmd/abootimg.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/cmd/abootimg.c b/cmd/abootimg.c
> index ae7a1a7c83b..6065be9de6a 100644
> --- a/cmd/abootimg.c
> +++ b/cmd/abootimg.c
> @@ -100,16 +100,16 @@ static int abootimg_get_dtb_load_addr(int argc, cha=
r *const argv[])
>  	hdr =3D map_sysmem(abootimg_addr(), sizeof(*hdr));
>  	if (get_avendor_bootimg_addr() !=3D -1)
>  		vhdr =3D map_sysmem(get_avendor_bootimg_addr(), sizeof(*vhdr));
> +	else
> +		return CMD_RET_FAILURE;

Do we need an unmap_system(hdr) here as well?

> =20
>  	if (!android_image_get_data(hdr, vhdr, &img_data)) {
> -		if (get_avendor_bootimg_addr() !=3D -1)
> -			unmap_sysmem(vhdr);
> +		unmap_sysmem(vhdr);
>  		unmap_sysmem(hdr);
>  		return CMD_RET_FAILURE;
>  	}
> =20
> -	if (get_avendor_bootimg_addr() !=3D -1)
> -		unmap_sysmem(vhdr);
> +	unmap_sysmem(vhdr);
>  	unmap_sysmem(hdr);
> =20
>  	if (img_data.header_version < 2) {
>=20
> ---
> base-commit: 903eb123236ccbd8ef05d43507a2a910b785bd56
> change-id: 20250625-abootimg_fix-51600dc8356a
>=20
> Best regards,
> --=20
> Andrew Goodbody <andrew.goodbody@linaro.org>
>=20

--=20
Tom

--TrVRZP7V2Y9zK5o1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhcCxgACgkQFHw5/5Y0
tyxbpgv+IJ5UPLsM2mKJ2sV2hKQc8YwVNUqhTTy+KgjlQIbPdaeYY8tIMaksyiYS
omddjPE/WTmt4UHQCO49rKPK3e8KkClag3GC3vm+x1xFtqVuHTns2Np83E/beA6j
kmEUoLHvbPkhtg36nTC8PPtrOSi3ED+bplVuq7GkxGP2yvHezIir31pAeYPCL6Z0
nOvp2+K9+zgaZKcz2ZL/O6nyz0k/ububQ1qsP9nigcnTVbsPL7JtqlcYWsR9lHBr
9r4guxO3+jqj/pEvZ3BVZ0GJ9uVu8eWx+XHm5vbZqfvTWVARQY6oINDybw5jjPnW
+PQTfTONC781Gxu5IP8Vg8fnAM4zk8wKDIy5n9w5USEE8CRnxAwgLiac5B0wlUHQ
wx1iwX/6jn8yeROjQ7aA5QhO3ms7PztCovQgt510kjoLE8zodWk5k29dGyGNI3ca
j8BPoHEm8VMNvNUDWpJlhmggCIud45jdDSO3OANdJ4a9jKOy56eAkaJzHotkpZwP
noqf+AHb
=CFky
-----END PGP SIGNATURE-----

--TrVRZP7V2Y9zK5o1--
