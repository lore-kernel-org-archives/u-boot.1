Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2BFD44152
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 14:50:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91EFB8932F;
	Wed, 20 Nov 2024 15:50:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F4phB+3M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BDDA890D5; Wed, 20 Nov 2024 15:50:40 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 273E488EEA
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 15:50:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6d413def36cso39082766d6.3
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 06:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732114237; x=1732719037; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lhph7czFVKdLul08L+PE4mT4WmF/9AoYI7k64S95p+A=;
 b=F4phB+3MZPLk99ItvW42U5wIRu1ZDK02+lMq66EcjrOig8j55fLfx/a9JPos5ax5hc
 HaoaBw0lSC5gy1sVKLQk4d6fb0VCLZJvegNbwgm45L7uf0wfXOwj7C9B+hqbvaU4+Px+
 5Os+vi9j8LuVFdJDN8hPvQHQd6zhZASehnOAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732114237; x=1732719037;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lhph7czFVKdLul08L+PE4mT4WmF/9AoYI7k64S95p+A=;
 b=f90RLFNjYO98MfxriHSC2mJCmed7L6HwjT8i3esyBKZrVaub82j5Y9JFdD+9bMkAYQ
 0S8rJ8UmGrVRiLvK+K1slVtPD5TcP19j91Phj9z1P+FcGFqT4mn/tOjCG9T3oIX4Y30h
 QS767TBE6fqYjO2da3Gq3g0tg9ZR9ruD/ZkZBjHP/Bei/XQEQuAcqbqRtEpYjTGc2nMm
 3UKTGDsG7ggVPO5P74a1E6FnMdvitCsb1m44AVWEeoZ0SpPnsbeIoYNR8yFYkINMYqtI
 yT0uNdyWR9FCWdQPn+E3bSoYsZ7OZxT+mmvwbpdaj2qdLwg48mrg165xa5XPGoeOf+rM
 7zkA==
X-Gm-Message-State: AOJu0YxAxU8bL8MJ56MfHboQL3AMJhorCBzTrNK+6MKBHPbrPTspMwkg
 6KrJVcoFRGpMUMkNwVIMVC7QZB0zvHrgl0DW6es3vxtl7wKrM+D5Qod5ARsqHOQ=
X-Google-Smtp-Source: AGHT+IG4SHVv8ZDR4uvkvvYFI5GsSspsSW+RJR5ZQv5oye2rVMSKa1iULeaZZnnIi9AF3KM+u8EEIA==
X-Received: by 2002:a05:6214:2aa6:b0:6d3:e740:4b56 with SMTP id
 6a1803df08f44-6d4377b3513mr41169806d6.5.1732114236945; 
 Wed, 20 Nov 2024 06:50:36 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d4380b3019sm11478206d6.13.2024.11.20.06.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 06:50:36 -0800 (PST)
Date: Wed, 20 Nov 2024 08:50:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 12/39] bootm: Allow building bootm.c without
 CONFIG_SYS_BOOTM_LEN
Message-ID: <20241120145033.GB3600562@bill-the-cat>
References: <20241119131844.4078144-1-sjg@chromium.org>
 <20241119131844.4078144-13-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="W9HfSALM6QndssQc"
Content-Disposition: inline
In-Reply-To: <20241119131844.4078144-13-sjg@chromium.org>
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


--W9HfSALM6QndssQc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 06:18:17AM -0700, Simon Glass wrote:

> This code cannot be compiled by boards which don't have this option. Add
> an accessor in the header file to avoid another #ifdef
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  boot/bootm.c    | 8 ++++----
>  include/bootm.h | 8 ++++++++
>  2 files changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/boot/bootm.c b/boot/bootm.c
> index 16a43d519a8..0a1040ef923 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -633,11 +633,11 @@ static int bootm_load_os(struct bootm_headers *imag=
es, int boot_progress)
>  	load_buf =3D map_sysmem(load, 0);
>  	image_buf =3D map_sysmem(os.image_start, image_len);
>  	err =3D image_decomp(os.comp, load, os.image_start, os.type,
> -			   load_buf, image_buf, image_len,
> -			   CONFIG_SYS_BOOTM_LEN, &load_end);
> +			   load_buf, image_buf, image_len, bootm_len(),
> +			   &load_end);
>  	if (err) {
> -		err =3D handle_decomp_error(os.comp, load_end - load,
> -					  CONFIG_SYS_BOOTM_LEN, err);
> +		err =3D handle_decomp_error(os.comp, load_end - load, bootm_len(),
> +					  err);
>  		bootstage_error(BOOTSTAGE_ID_DECOMP_IMAGE);
>  		return err;
>  	}
> diff --git a/include/bootm.h b/include/bootm.h
> index c471615b08c..d174f18ac18 100644
> --- a/include/bootm.h
> +++ b/include/bootm.h
> @@ -89,6 +89,14 @@ struct bootm_info {
>  #define bootm_x86_set(_bmi, _field, _val)
>  #endif
> =20
> +static inline ulong bootm_len(void)
> +{
> +#ifdef CONFIG_SYS_BOOTM_LEN
> +	return CONFIG_SYS_BOOTM_LEN;
> +#endif
> +	return 0;
> +}
> +
>  /**
>   * bootm_init() - Set up a bootm_info struct with useful defaults
>   *

This kind of change is wrong in that it moves a build time failure to a
(potentially non-obvious) runtime failure. If we're moving to now
dynamically allocating the location where we can decompress to, then it
should be part of that abstraction. But that doesn't look to be the case
here.

--=20
Tom

--W9HfSALM6QndssQc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc99zYACgkQFHw5/5Y0
tyxRNAv+JLK+hb0Bu3Q9fCIcoeLsglmGAOhCHg0DzM58Dq2b6pu6gh6SgOIlH5ZB
6mDiBzXJTKNGZsYA3nDI+1zASjUMz1N4K5Ejf6OzEDFl5r7DDkvylZGIBRXT3uYE
lJlkq8T4Hlp04AolWGG/R3kKaeD0hZv71SHa402BQw77Od+qHs69v9hPKIDzbQKA
uD6aSFAzuV5nbTbBZ/XfARCpqiptB8XzlVzrOSaf0FQTEpfybrAkKiyxc7kIqOHq
h7Bs7jNTUG3GCMGwMFlraS0JyijQ5++0U52UiuwSoYOuIZetYF9PfZ+XkdXhKlGO
R+FObhMAYwDdzNlzGfB5lwvr7ZDEZ7I19oKGULR+3CrBQoD/tib29hPyqRIQY8n3
anManIKjKRMacR2illnjcHcjx86Dtoy0ixb+RiimUC0m+Z5DQvD4dxgxNoqxA7cg
66MTUUpYlDXTdfsa0I9PHpnRPvbV3FJJo3xexUvklNtWpE9tEXNEW44eIf/E5PCm
4VuzQfwp
=keVq
-----END PGP SIGNATURE-----

--W9HfSALM6QndssQc--
