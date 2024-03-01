Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD66C5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 23:33:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 166DC88151;
	Sat,  2 Mar 2024 00:33:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Sd1zuNCY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2D3188157; Sat,  2 Mar 2024 00:33:37 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C22F4877EC
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 00:33:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-60978e6f9a3so22058227b3.3
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 15:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709336013; x=1709940813; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WyKeZZUOTEb0ydzWQ1bHxDvJ0v++N/NRr5hdMn+9X18=;
 b=Sd1zuNCYlmVJuMgWIyowY3N4NKzaWThi0OjTNQ7yywKhaM/uHx8MfIV+hxN7T8pGP0
 6b9yFMZduCNHDqqTqXXd+iJ00qxu8aA2mkDq330JFjXSA0bJp08JQnDMSMcuBRMsmiJy
 HJccP42+oOapHpbYLX34Ks2jx5nMp1cJUYk/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709336013; x=1709940813;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WyKeZZUOTEb0ydzWQ1bHxDvJ0v++N/NRr5hdMn+9X18=;
 b=cEpG/lhTXDkXc0WLTj3fpZWWwtUw3xSs+TSPUXIcm9hnvjZL58p7h5nPZom/3vfJ/M
 j3t6CYOGH4KtYnJLy8ICEPP34vtTNUhGObMjH2nFXFe/PzHP5g987JqtNMX+CMhAjkFD
 m2ycWsk7pEXgcaQQzpZv098nYz7wtuB/TcwxGWY8nsMmSLbFSo5rt1qdL+u0jbvbQrXO
 dSPafQwzLTqi2GNLCvXbUF2VcSIeUsk/uKC2lnZa+gA1krZsmucxSVMnKtvbsuOTCP3B
 E+JN4IU82V/BTPNmTjpqMvW5Aul7twlkkrBCsPvWBWhKW9af+D+uHveFGc++AQx5TaXD
 LKWA==
X-Gm-Message-State: AOJu0YzfxuTTvlYc/XR/r68bplaFssDiWXwu8BPO7qjhYPDFdWsyTicS
 L5xtr3HWKotyNWVCiXInNS7NL5AeziVtqJ0w62CvEtXWKS3e1gjPe5l1fMAdfaA=
X-Google-Smtp-Source: AGHT+IFO55SY/RJsdjvCyTX/WXzlU9n/ndwU6KY2uA6f2LsrbrSS59u/snqDClBi9UAZLAW0i/oHYw==
X-Received: by 2002:a25:c713:0:b0:dcd:3338:a3c5 with SMTP id
 w19-20020a25c713000000b00dcd3338a3c5mr2910694ybe.33.1709336012939; 
 Fri, 01 Mar 2024 15:33:32 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 x16-20020a056902051000b00dcdb990f93bsm986574ybs.64.2024.03.01.15.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:33:32 -0800 (PST)
Date: Fri, 1 Mar 2024 18:33:30 -0500
From: Tom Rini <trini@konsulko.com>
To: Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Marek Vasut <marex@denx.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v3 2/2] spl: Add support for booting from ESP
Message-ID: <20240301233330.GA1496871@bill-the-cat>
References: <20240122111022.229805-1-mchitale@ventanamicro.com>
 <20240122111022.229805-3-mchitale@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XuqrKa5LmQGX0NaU"
Content-Disposition: inline
In-Reply-To: <20240122111022.229805-3-mchitale@ventanamicro.com>
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


--XuqrKa5LmQGX0NaU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 04:40:22PM +0530, Mayuresh Chitale wrote:

> Some platforms as described by EBBR specification may store images in
> the FIRMWARE directory of the UEFI system partition(ESP). Add support
> to boot from the EFI system partition if it is enabled for a platform.
>=20
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
[snip]
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index cf7ffc9b112..48e4e43196a 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1292,6 +1292,14 @@ config SPL_SATA_RAW_U_BOOT_SECTOR
>  	  Sector on the SATA disk to load U-Boot from, when the SATA disk is be=
ing
>  	  used in raw mode. Units: SATA disk sectors (1 sector =3D 512 bytes).
> =20
> +config SPL_ESP_BOOT
> +	bool "Load next stage boot image from the UEFI system partition"
> +	default y if BOOT_DEFAULTS
> +	select SPL_PARTITION_TYPE_GUID
> +	help
> +	  When enabled, first try to boot from the UEFI system partition as
> +	  described in the Ch.4 of the EBBR specification.
> +
>  config SPL_NVME
>  	bool "NVM Express device support"
>  	depends on BLK

This introduces:
WARNING: unmet direct dependencies detected for SPL_PARTITION_TYPE_GUID
  Depends on [n]: SPL_EFI_PARTITION [=3Dn]
  Selected by [y]:
  - SPL_ESP_BOOT [=3Dy] && SPL [=3Dy]

On for example coreboot64.

--=20
Tom

--XuqrKa5LmQGX0NaU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXiZcoACgkQFHw5/5Y0
tyyqjgwAgEERUeaEnQlU0/mJ4G5aOubIJFAFtcfCe1YDwPKA+Osg3OQN4Pg4/P2V
Thi0x2UFEE6Ue7mjk99+7lb7JBpXl363R33RjQu7D0e9sG0y6beMaDDJL2/3bPXN
/KqoNOf48YF6jsiaWh0g1/A5aw+XRq4+Sn8yamE8q8lS1HDcro0Oz9jYPzhj4gBZ
1BSmQsK7pM69Q1FICvCOngewrwUVD9nAYr1kR/mmkfMAxuiWAraUCv9OquD+8Y5x
fgiK2MYNzBelmUhe3STLGpYqFLHa7g6Hu8/Zke81VwMMU4vkyhQ6LBcZEz3u/Q39
pACNU+GXTfzr/Z3cKxZDoOloPX5vN5VYT6XJuOD/L354GMFU12PCcOifliE936Ue
Ku2PkNLH3VozgWBhX5y3gXUowvm/A/OMivO3Xq9QXu28z6kzRRo/dySpXUksLkX8
5Cjh3wD6Q4OE/eCCLQp8A7jfqoLNCZrpW9IIRrvL5YQ+uFvtepVPucSNV0HwHH7N
z9qOkGHT
=JLa0
-----END PGP SIGNATURE-----

--XuqrKa5LmQGX0NaU--
