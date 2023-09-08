Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D052EE7FF5
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 13:42:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9807E866CF;
	Fri,  8 Sep 2023 15:42:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OUDwOf+o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B7E986A1D; Fri,  8 Sep 2023 15:42:34 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 822A0864C1
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 15:42:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-d7e9d849bdfso1843069276.3
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 06:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694180550; x=1694785350; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=U0fhLuz/rxEEgYQ84fPDDMy/XjYqTy7KZ6yj0KWFEKY=;
 b=OUDwOf+o8/5Lhz2mFSfBLDsgsaBqbrA8LIyA4YyZTxUl4r4665xYVx7Xmwyo6QUTl/
 XUPkZ9rEvFB8Iy6guB50cZ8hi0EO+MUnBl+CcfPUuXb1bJ/V39JqPIZRWvliPKR46qzs
 hO+jlzdBRFBEOhjXvFXwwto+V/AQVPr1BsQQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694180550; x=1694785350;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U0fhLuz/rxEEgYQ84fPDDMy/XjYqTy7KZ6yj0KWFEKY=;
 b=eF6c36mURyxvDqRaXNuPh/MixofZRIVlhzNYQ1M6cTKqHeWoBhkdiCh1PZrDbmbLIp
 RGr/RiDNRWnWyNpcigCZFbeqtQHvrJT/woiQxmd9rlMpog6Gk61U17fuZo89SoawwfEn
 6OxBM2mui50MNTdmsT0dqYEJMkfOc+QoUbDPkwrEsZC072e4mprKemNWWmkfr5bAh3kw
 xzBNuWuv7D3wT4BZsefC5oEQo1flmNaSl29czawnpTIT1UzLjCWIeI+3NcbxPd7AUq/d
 rpysz+1GTT5leZtO4TF8PUyL5Jhl2y6ypTMvF51iLEV5dMIrr3wWRcFKJo21KrcGJGxf
 +HPQ==
X-Gm-Message-State: AOJu0YyAs6mxVR6DzrZ8KTPIpKXJG/I9iNMSHQx8VBlWfuqpGJhfgFzR
 A6eD7CkMaMb+61zhXzIOcFEeEA==
X-Google-Smtp-Source: AGHT+IE3CHC9rkiGrjbvlc8SCy3uh5sXE5gnBWgfrSZLHJMfdG7VVCUV66XayAsB7wRkRLgQ2sCm7g==
X-Received: by 2002:a25:41c9:0:b0:d7f:3ef5:13ae with SMTP id
 o192-20020a2541c9000000b00d7f3ef513aemr2230698yba.0.1694180550168; 
 Fri, 08 Sep 2023 06:42:30 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-031e-83f0-a4af-2e7d.res6.spectrum.com.
 [2603:6081:7b00:6400:31e:83f0:a4af:2e7d])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a5b0d10000000b00d77bd2fe760sm351779ybp.27.2023.09.08.06.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 06:42:29 -0700 (PDT)
Date: Fri, 8 Sep 2023 09:42:27 -0400
From: Tom Rini <trini@konsulko.com>
To: Devarsh Thakkar <devarsht@ti.com>
Cc: u-boot@lists.denx.de, praneeth@ti.com, nm@ti.com, vigneshr@ti.com,
 a-bhatia1@ti.com, j-luthra@ti.com, nsekhar@ti.com,
 jan.kiszka@siemens.com, chao.zeng@siemens.com
Subject: Re: [PATCH] configs: am65x_evm: Use envboot before distro_bootcmd
Message-ID: <20230908134227.GB305624@bill-the-cat>
References: <20230908115615.3829854-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="q+06gFbBmFqfRml0"
Content-Disposition: inline
In-Reply-To: <20230908115615.3829854-1-devarsht@ti.com>
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


--q+06gFbBmFqfRml0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 08, 2023 at 05:26:15PM +0530, Devarsh Thakkar wrote:

> Use envboot cmd before issuring distro_bootcmd as otherwise
> environment variables from uEnv.txt are not getting imported.
>=20
> The commands after distro_bootcmd have no impact since board starts
> booting after distro_bootcmd, so it need to run last after all
> environment variables are configured correctly.
>=20
> Fixes: bde6ac54905 ("configs: am65x_evm: Switch envboot out for
> distro_bootcmd")
>=20
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
> Boot logs (with display overlay) :
> https://gist.github.com/devarsht/2bac56933847d3e954d6ee275d711e27
> ---
>  configs/am65x_evm_a53_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/configs/am65x_evm_a53_defconfig b/configs/am65x_evm_a53_defc=
onfig
> index 4301553af8..4f1ef10e69 100644
> --- a/configs/am65x_evm_a53_defconfig
> +++ b/configs/am65x_evm_a53_defconfig
> @@ -34,7 +34,7 @@ CONFIG_SPL_LOAD_FIT=3Dy
>  CONFIG_SPL_LOAD_FIT_ADDRESS=3D0x81000000
>  CONFIG_OF_SYSTEM_SETUP=3Dy
>  CONFIG_DISTRO_DEFAULTS=3Dy
> -CONFIG_BOOTCOMMAND=3D"run findfdt; run distro_bootcmd; run init_${boot};=
 run boot_rprocs; run get_kern_${boot}; run get_fdt_${boot}; run get_overla=
y_${boot}; run run_kern"
> +CONFIG_BOOTCOMMAND=3D"run envboot; run distro_bootcmd;"
>  CONFIG_LOGLEVEL=3D7
>  CONFIG_CONSOLE_MUX=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x58000

This should just be switched to standard boot instead.

--=20
Tom

--q+06gFbBmFqfRml0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT7JMMACgkQFHw5/5Y0
tyylFAwAg0KrS1POfA/R6GR+4D/burWcJZMPV5Khi0k1tbMRwHPzGtg361nVHzxe
EWU/4cHTYkTGkma9+Hyw67hXHDQdYOEF/jtjYhGy5QbiloMkWN2RWBlMGj33jlYe
gTxCPadLsL49P1UpXU5e5CE5PdXLDFmWp0XrsbUax5j1qTw7BVOQkU1zyBeKykCo
rR3mBqRryzY/YrQzYrwiulpd+SA37SGlifdcUBOHNhbMrQjovJSBz62JIM1oR5PK
DnKFIzlAEsvgUZvERRFJVgjQ630zyfJXDzybu7ev7aP/Oa3cjIdhZMoXbFBI9bCg
KYNvgLKT1gkiBCp63nO8mYyo/BHa9fYMd1hkBRPfpxjSNCVhCnfBkRQn8sI9LhtC
TnbJLqsnji+NK9SQR9ND8RKzt1aktp2hVXVLf04cxPlLv5zOhZXAdLC/EmrvDwrf
CV+fSoAuVoTujkBde16xhc66cAdZbk9pLGvQEDUBR3FS3y/pwN3/DwVRkULxy98/
8+quUF1u
=WKeC
-----END PGP SIGNATURE-----

--q+06gFbBmFqfRml0--
