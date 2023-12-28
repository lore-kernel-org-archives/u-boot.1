Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2CEC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 16:01:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBC4887ACD;
	Thu, 28 Dec 2023 17:01:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XXXXl5OG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1763987ACD; Thu, 28 Dec 2023 17:01:51 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E117387AC9
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 17:01:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5e74b4d5445so49802947b3.1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 08:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703779307; x=1704384107; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LTcBehAaWjNhU9yAiYDtTVrGguEtk+11Zn9OIzkvCoo=;
 b=XXXXl5OGCvfdL16/Y+bSd2J9u/MvrkRIz/Nc2leNIhR5QXPkOA1zhqq4XBY2zSLvwH
 W0G3Jwotz0QG6ZEEu/v2LoXmqy0GijjxPMkPQjAYkB9yUe/b8gD/QCFmmuWmnHm9PBUT
 fxrxrr0tElVoBTBGJeNPrOBlFhBJahPjlNXhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703779307; x=1704384107;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LTcBehAaWjNhU9yAiYDtTVrGguEtk+11Zn9OIzkvCoo=;
 b=YxpUFrXw05ujNPWkhCblh9Sc0iwICiCNARROmcvUDHJvOXrpr/M+f1M9s4NkMA+RCX
 fOPaq30e5nOJrEzejvyRyknhzbpp0RKZtXL4Sx+bVuTPdWXOOnWjIN47kB7d7cKpGmXC
 ctuXVO5oMZ+EibkW0gjcgfNFtIWccQMj6qkSBBzbccc4WC8bebUbORxuxVYF25hWZhrj
 ejT9PHmFi00Sus28ZIcvVvzQFfwDzoSM3V/sUmrruJSIho9PERhvjhA3lvx6MuOlZDQj
 /DFltXzKublNUuy1iqa4BAZ5h15L9XnY9sJJsXOKojpcIobCMwxrKh41pj2sM+pakEZM
 gukg==
X-Gm-Message-State: AOJu0YyxyqFNAlLQmbOB1Ve1D4phgEmuGgQK0sg0PNm5Q4VBq51BJ6tJ
 GhTV9YUj3B0ZzUSHzOCKv4uLeTUkYemUtA==
X-Google-Smtp-Source: AGHT+IFWo2GclHjYNj0wdgX9yDf7f/AwR0vyCEIhv81SibnHlaiFQQNUdLAy6/2KkZgoDm/wHZ9SIA==
X-Received: by 2002:a81:be12:0:b0:5ef:d5e2:eae2 with SMTP id
 i18-20020a81be12000000b005efd5e2eae2mr116905ywn.21.1703779307615; 
 Thu, 28 Dec 2023 08:01:47 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 w126-20020a817b84000000b005e79f80959bsm7630097ywc.112.2023.12.28.08.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 08:01:47 -0800 (PST)
Date: Thu, 28 Dec 2023 11:01:44 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Baruch Siach <baruch@tkos.co.il>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerry Van Baren <vanbaren@cideas.com>,
 Michal Simek <michal.simek@amd.com>, Nikhil M Jain <n-jain1@ti.com>,
 Qu Wenruo <wqu@suse.com>, Sean Anderson <seanga2@gmail.com>,
 Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v5] fdt: Allow the devicetree to come from a bloblist
Message-ID: <20231228160144.GJ2652760@bill-the-cat>
References: <20231228133654.2356023-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jyKLbjQJEw9cbRvU"
Content-Disposition: inline
In-Reply-To: <20231228133654.2356023-1-sjg@chromium.org>
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


--jyKLbjQJEw9cbRvU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 01:36:54PM +0000, Simon Glass wrote:

> Standard passage provides for a bloblist to be passed from one firmware
> phase to the next. That can be used to pass the devicetree along as well.
> Add an option to support this.
>=20
> Tests for this will be added as part of the Universal Payload work.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> The discussion on this was not resolved and is now important due to the
> bloblist series from Raymond. So I am sending it again since I believe
> this is a better starting point than building on OF_BOARD
[snip]
> @@ -1662,23 +1667,42 @@ static void setup_multi_dtb_fit(void)
> =20
>  int fdtdec_setup(void)
>  {
> -	int ret;
> +	int ret =3D -ENOENT;
> +
> +	/* If allowing a bloblist, check that first */
> +	if (CONFIG_IS_ENABLED(OF_BLOBLIST)) {
> +		ret =3D bloblist_maybe_init();
> +		if (!ret) {
> +			gd->fdt_blob =3D bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
> +			if (gd->fdt_blob) {
> +				gd->fdt_src =3D FDTSRC_BLOBLIST;
> +				log_debug("Devicetree is in bloblist at %p\n",
> +					  gd->fdt_blob);
> +			} else {
> +				log_debug("No FDT found in bloblist\n");
> +				ret =3D -ENOENT;
> +			}
> +		}
> +	}
> =20
> -	/* The devicetree is typically appended to U-Boot */
> -	if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
> -		gd->fdt_blob =3D fdt_find_separate();
> -		gd->fdt_src =3D FDTSRC_SEPARATE;
> -	} else { /* embed dtb in ELF file for testing / development */
> -		gd->fdt_blob =3D dtb_dt_embedded();
> -		gd->fdt_src =3D FDTSRC_EMBED;
> +	/* Otherwise, the devicetree is typically appended to U-Boot */
> +	if (ret) {
> +		if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
> +			gd->fdt_blob =3D fdt_find_separate();
> +			gd->fdt_src =3D FDTSRC_SEPARATE;
> +		} else { /* embed dtb in ELF file for testing / development */
> +			gd->fdt_blob =3D dtb_dt_embedded();
> +			gd->fdt_src =3D FDTSRC_EMBED;
> +		}
>  	}

This whole if/else tree looks wrong today, and then wrong with this
patch. If we have an embedded device tree, which should only be used for
development (or special case needs, I _think_ some users today are using
this for security type needs), it must win and be used. The over-ride
switch was set, and should be used. Then, I don't know if we should be
saying "the user provided a tree via OF_SEPARATE, it should be used" or
"the device has passed us a tree via standard mechanism, it should be
used" is the higher priority. I really don't know which is more valid.

--=20
Tom

--jyKLbjQJEw9cbRvU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWNm+gACgkQFHw5/5Y0
tyy8kAwAmbVuuRyfUyQsD19EnXobY9LOMYnFWHzAiV5bLhuYL1v/xfXKwXz7hOXR
5itBndX5wiZfDllZScOv0p/Glr1nB4u7VX/4zPtx2tEoWK45wQeG3i1cm5TEcTkp
nGYSSZEyFjQu0SqgG9Mi037rVdUX5vPfOzlOEXISLoUCa0IQ0udPl7+c2mG3jFFd
tPH59tkRFCaLPoyB9/s6SCuizrXM+mCdIroxNtHT8+YqrlxpJ/Ej4sjbptXMNwH3
wEAar4wEhfeIyeqZmfeFMzfdBAKJesXNiEd7pZWUlsY/xk0ykQrY7jprIYTKmBj7
KhakRM9HoADMjGWoF48MBwdp4Rrf4j0orFtkylPh7VWDrBoWpwrKGzkcrNaQd2oo
PF3hzhWsxi6pdjntnQvasVadS4yXMngSegHnI3d3EkZZDdbkznxGR44pxq6wgM6b
8aGYnbCAHv1Z0wnI9863Ia2//1KmFhRc3pxF1wJ9ZYZy7aJvnysCAI4MnAkWBvXx
iWQ0awac
=eCpO
-----END PGP SIGNATURE-----

--jyKLbjQJEw9cbRvU--
