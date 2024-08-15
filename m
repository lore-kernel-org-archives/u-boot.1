Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F017C52D7C
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 16:57:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F4E988A7D;
	Thu, 15 Aug 2024 18:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Gta84U55";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBAB688A7F; Thu, 15 Aug 2024 18:57:23 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7B72887D4
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 18:57:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5d5bb2ac2ddso556604eaf.0
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 09:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723741036; x=1724345836; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6wT6b8tY5wtfZdd3C8cAUi+oeUtMWzJjEyL41kS6qeY=;
 b=Gta84U559Al0uatFcHYbLvE/Vr+RASMMiNIpdd5IJlt2JAmNxgDhwEK9L+Aza7SNg4
 vC9CWqmhfXYpJrFc+FJzyRPXXy5m1wCcoyZnt9spyr74l4bMysHKHPQ5xTjVy2iHRxRy
 F3uR4zW1nHveC/hRz0Qmzon7eJ5x9c4EvxOkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723741036; x=1724345836;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6wT6b8tY5wtfZdd3C8cAUi+oeUtMWzJjEyL41kS6qeY=;
 b=T3wV2qooQkp3NNS2HVeanq0sk64qiV7mmPCVLmyOwwyZSoG7Jpirs3xqmUZXRBwKG7
 h69C350Pp8q0OUWVQHSyDZyypcSQt9z/mPIJ6byytqj4ILQcJSRzyRqrdr5eYsPyan10
 6UKWox3OEWDFSyaBQk0bXxO1BVedgCgAsn5fnyrMYpkCOmNe7BTGnJmBxG61K6SOBh68
 y5cpfAFbuT/V7nqc6vzTbAhY5u5+v5iD7zNx/KtGQIWrzYNqsTWjHyM3nmBjJapzR52s
 mgBHeezrHhQc9LrNSs39kYXhwUOVIuC+Al7lIv8OWXQqcCaR7cMj23zKyFYrrrvkw3pp
 bCyw==
X-Gm-Message-State: AOJu0YwxQeYfJ23rEKEAu9oUdPHTPSwgQ4T5Xh69GrnjhefJhDSUu00/
 4yhxzCIiNUX5wtmVpeDOioIMOqn6lKeZXYJEnhDZKuo4ZOkVDRDWslEKRu19psE=
X-Google-Smtp-Source: AGHT+IHXcs20OD7XeUAEJYsY/1m38aioXyvSodE50vHpjYX5YHeOSYIOKi6m24r4TxxlYB50oTODHA==
X-Received: by 2002:a05:6820:1c81:b0:5da:73a3:f2c3 with SMTP id
 006d021491bc7-5da99668839mr12132eaf.3.1723741035949; 
 Thu, 15 Aug 2024 09:57:15 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5da8cd67ee3sm346160eaf.9.2024.08.15.09.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 09:57:15 -0700 (PDT)
Date: Thu, 15 Aug 2024 10:57:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v3 02/40] nvmxip: Avoid probing on boot
Message-ID: <20240815165713.GT1626301@bill-the-cat>
References: <20240811145209.4191404-1-sjg@chromium.org>
 <20240811145209.4191404-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5/aYIa/gBZkPg5o6"
Content-Disposition: inline
In-Reply-To: <20240811145209.4191404-3-sjg@chromium.org>
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


--5/aYIa/gBZkPg5o6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 08:51:31AM -0600, Simon Glass wrote:

> Devices should be probed when they are used, not before. Drop this
> boot-time probing.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  drivers/mtd/nvmxip/nvmxip-uclass.c | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/drivers/mtd/nvmxip/nvmxip-uclass.c b/drivers/mtd/nvmxip/nvmx=
ip-uclass.c
> index 58e8c3fb74b..d18bd0e3d6b 100644
> --- a/drivers/mtd/nvmxip/nvmxip-uclass.c
> +++ b/drivers/mtd/nvmxip/nvmxip-uclass.c
> @@ -53,14 +53,7 @@ int nvmxip_probe(struct udevice *udev)
>  	return 0;
>  }
> =20
> -static int nvmxip_post_bind(struct udevice *udev)
> -{
> -	dev_or_flags(udev, DM_FLAG_PROBE_AFTER_BIND);
> -	return 0;
> -}
> -
>  UCLASS_DRIVER(nvmxip) =3D {
>  	.name	   =3D "nvmxip",
>  	.id	   =3D UCLASS_NVMXIP,
> -	.post_bind =3D nvmxip_post_bind,
>  };

Since this is essentially a corstone-1000 driver, adding the
maintainers.

--=20
Tom

--5/aYIa/gBZkPg5o6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma+M2kACgkQFHw5/5Y0
tywK3gv/UJp9/vBGk73yUd+nVJED0mOrFquxYFvcbozKwNy1LYIDlwETtSOcjWsE
GXcZq1mE54jOq2rMW6ilViPC3ykT3xyuPMM8yigekyNZwfEtwEm0EcgWyloyKFsr
4BS5cJxFFZlN+IUd1jdC1ZuCODmZ4fXDGZG5++Fc5ISgBLCsz+s7kku1J0WV77pg
WcV0Gjr6vUKbtai0AOYMqtet0ZJm0zz5PRBI86eXn8YIIUlyCE+j4Y1+eFaMXgJv
ku3kG+wwksdha0zEsU9DT1srN52q0CVCPSEoDiilNqrlZHsGXEUGaNWkMroHi3kk
GH3iq7OhG7A0zdEEGXJYON1HMdFyN9282UXnpefCZTntV6wKLp4lkcrcFJl9Gm+v
ysjf92Ogj7UW/AoyjyLJMJtLZhtqmTvl2IPJQRmXvHPBFkQbFHAFemZIkwasENUk
wqUbLefV3ZkuvpkVYVbFzKWpU+aOxSBspPpAk/tNvwAT8n5/nWC3qB4hMVbOAuv7
oHA0b5Zj
=J0O9
-----END PGP SIGNATURE-----

--5/aYIa/gBZkPg5o6--
