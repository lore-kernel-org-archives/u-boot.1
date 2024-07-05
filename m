Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A188C3271E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 19:51:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D645588629;
	Fri,  5 Jul 2024 21:51:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SHEdSikj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC22B88395; Fri,  5 Jul 2024 21:51:03 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4BF688629
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 21:51:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5c46dcf9f0eso1096120eaf.1
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 12:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720209060; x=1720813860; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=62SABgMIqzsm4epy8jx89WgRUu52tXinNNx8ySJbfkA=;
 b=SHEdSikjMMi7Vy99SQmxFFy4g8IwyQW5ZV2dbUjF26M7SLUkEfg3vGhuQmNBiF0fGX
 ve2/mx1cL/S+fmJpIFWzdvtNfW1Doyn8hL6gHC3S2md6McJeQRTpE8jW0XegsXKCI6dC
 /3mxE8HmfJy9JS0BwAN7qzgW8f3X5Wx0tMitU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720209060; x=1720813860;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=62SABgMIqzsm4epy8jx89WgRUu52tXinNNx8ySJbfkA=;
 b=cF2pqxBR4uHhY62u+5vivzoFJkN/5QY9TDbG1j0zhFW+mbJpL4HGimP+yokwOVaZI2
 MRdBa2gh0D5ayUWbTyHGFTmSSb0CX3aA0F1sTfq8pWsTimWOT35cZtNA+Pak2D4Hl/WH
 fvYhTGEcL2M7PpZpu7L6XotkefxNBbYaI6ztvWKYCXZeoTFtcmUFqnmvbsAUjlZrKHS7
 /M8NUDhoT1oLB2l8p8MVlKO09byraJfP4+i46vWnlGNfJhH/XDz9EqHZCf3FDgohTliV
 cMcbAtHgeiPi7Ajd4shfxYWlhiUF70sWgHQufCB4xybrd8JKK4z3B9nEKBpzFj+2CY2q
 vMaA==
X-Gm-Message-State: AOJu0YwLlnSaK2VyiZ9GCpzEQd4avEyET81yzurzItVDFUF1sOCugSZn
 Wdbi9+1W5VdyR97xgZ1NczpnyUsDHN9dFq05PZbi35WViieqQrFKjoykIGB3U0P+OhL655zVeto
 iVynVyg==
X-Google-Smtp-Source: AGHT+IEsiDzVQXbtt+r9GNr/vp5NDfBKNJp/mONY2u2MSrLB31JwCCDrsK2emD997ygVo3SKB+UkYA==
X-Received: by 2002:a05:6870:b508:b0:25e:101c:28cf with SMTP id
 586e51a60fabf-25e2bf2ba6dmr4813565fac.51.1720209060326; 
 Fri, 05 Jul 2024 12:51:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25d8e339b40sm3836724fac.43.2024.07.05.12.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 12:50:59 -0700 (PDT)
Date: Fri, 5 Jul 2024 13:50:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
Subject: Re: [RFC PATCH v2 38/48] lib: Kconfig: add a config symbol for
 getting lmb memory map updates
Message-ID: <20240705195057.GP38804@bill-the-cat>
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-39-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZV8DrAAI3y2q2pSj"
Content-Disposition: inline
In-Reply-To: <20240704073544.670249-39-sughosh.ganu@linaro.org>
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


--ZV8DrAAI3y2q2pSj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2024 at 01:05:34PM +0530, Sughosh Ganu wrote:

> Add a Kconfig symbol to enable getting updates on any memory map
> changes that might be done by the LMB module. This notification
> mechanism can then be used to have a synchronous view of allocated and
> free memory.
>=20
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1:
> * Change the description to highlight only LMB notifications.
> * Add a separate line for dependencies.
>=20
>  lib/Kconfig | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 7eea517b3b..b422183a0f 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -74,6 +74,16 @@ config HAVE_PRIVATE_LIBGCC
>  config LIB_UUID
>  	bool
> =20
> +config MEM_MAP_UPDATE_NOTIFY
> +	bool "Get notified of any changes to the LMB memory map"
> +	depends on EVENT && LMB && EFI_LOADER
> +	default y
> +	help
> +	  Enable this option to get notification on any changes to the
> +	  memory that is allocated or freed by the LMB module. This will
> +	  allow different modules that allocate memory or maintain a memory
> +	  map to have a synchronous view of available and allocated memory.

This needs to be select'd when it's going to be used, opting out of
making sure memory reservations are obeyed isn't a good idea.

--=20
Tom

--ZV8DrAAI3y2q2pSj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaITqEACgkQFHw5/5Y0
tywUkgv6Ai3Vj3oQioLEAdTJHF+vhadCHyqEThNTiiYDS5zfGukToqhAltHKs9jh
v/Dh1IhgUWKGRLPRjKnpSZ8iiBP9yQTZ+kLcWh/Ng4X0tccVk1cmpbo/vvkno9Zm
zhi0wHtJgTZEC4CbgxFh5DIONSfCKjP2Irs8+iXv4MYX9gAePbQysr+W9sWH4akP
EzZyRRecF/JsAEDBii1RjtyjScZilAC7S+o1kovcux9Edp+brX3Gd/XLqoXcVTKv
aW3jwU+hVcSGKpjP7z35+/o3n4bbHA6e7VAthAMQfY3WVS0Rawp2B3v5l7vtEnGf
pymy1wwdF4YAwkKGpIS8InhbsuKMOptw4Jub1If09xMHKXuy3EIN4hmMoYZ7pgxa
T99L/dTAzihzr2qocAEVD7SHexVzfSPvD4+AZJzaQp39ejp615vjACR56zqxeBq0
KvPO0Jdkr4le3lvKEgbroBhbelWCDo9gF8/JKO9SmZwWHr2vlhEJvn3mfwm12TiS
izS9WNg7
=tGQh
-----END PGP SIGNATURE-----

--ZV8DrAAI3y2q2pSj--
