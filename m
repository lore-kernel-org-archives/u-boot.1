Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8BA3D6A223
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 14:17:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F418C890B1;
	Fri, 15 Nov 2024 15:17:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pciv19MF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80A47890F6; Fri, 15 Nov 2024 15:17:01 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 555DA88BB7
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:16:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7b14f3927ddso110565485a.3
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 06:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731680218; x=1732285018; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FF7N+7sIjuprePRvQXuwI+z/53xj1N2at0VR0TTdDX8=;
 b=pciv19MFj3Ol7PqWCzD4jKyXDcHjqHvvKSMIG/DY2XKAaNLO6NeyAJFB/YbaQ175yi
 aTsH/AwrG7rgvrxdxzjl40B5ZHkSNGdd8gLSmTktivi++LdjY+k7NA48QwhMLLoSFcZA
 nWw2a+PfwMIqhN/BXgGC6Vc391pWGq+1h4pIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731680218; x=1732285018;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FF7N+7sIjuprePRvQXuwI+z/53xj1N2at0VR0TTdDX8=;
 b=egSLbc4i0AXd1Q7GXLbUFDt0WApyZGqHDNfQOv2a+Hu3By5N2qJaxO+5STF7HCxg4A
 UMu61UlT/aQwio+1n7LmbzXDkf7MJ6SoAqMmzijtoZGidXpRQTe6yvc6IIN1yRRmOBPl
 7UF839IkrLvJu3EFaWwkn2kBE0MFYioMXEQPTelkOZp767APWJxvGuE78JhcFsa3Brok
 iW2bUmKLixcRGUNVXEXs4rC1igSTuvd3buEhtLESn4X3m7OqWJsG08vcZWzy/mmFK/Nt
 fgnTlHTjZGwQuaDktc8k9HvjntF2TXwZQXGKsEMas5MFh5qnlzX+o9HhkGzPqcqZQZMy
 wl9g==
X-Gm-Message-State: AOJu0YymuIroqtuf8JgRVaLIdcKXc2if4Vn6cZIZCjLw1TppmaeD0+NX
 wxjtVV9jOndUAFL6LohfhsFnlofMYR9X1JC2qKwNXBqL642v5UjMsu+2CNXd9mc=
X-Google-Smtp-Source: AGHT+IHxE0i3MKs81l+ZkhlsLVtQEDJHILtwIDdF3Z7GGNGodzY8rLJCfhLjU8qeO6kMhEhb9JfenA==
X-Received: by 2002:a05:620a:40c3:b0:7ae:5c67:e19c with SMTP id
 af79cd13be357-7b36237160cmr383510985a.55.1731680218141; 
 Fri, 15 Nov 2024 06:16:58 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35c9ad71csm162380985a.64.2024.11.15.06.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 06:16:57 -0800 (PST)
Date: Fri, 15 Nov 2024 08:16:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Jon Humphreys <j-humphreys@ti.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, jagan@amarulasolutions.com,
 vigneshr@ti.com, u-kumar1@ti.com, seanga2@gmail.com,
 caleb.connolly@linaro.org, sjg@chromium.org,
 william.zhang@broadcom.com, stefan_b@posteo.net,
 quentin.schulz@cherry.de, git@amd.com,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Subject: Re: [PATCH] mtd: spi-nor: Address the Macronix flash probe failure
Message-ID: <20241115141652.GR3600562@bill-the-cat>
References: <20241115050656.30439-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RXKa853L+s64m82K"
Content-Disposition: inline
In-Reply-To: <20241115050656.30439-1-venkatesh.abbarapu@amd.com>
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


--RXKa853L+s64m82K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 10:36:56AM +0530, Venkatesh Yadav Abbarapu wrote:

> When performing a soft reset on the OSPI flash, the default
> cmd_ext_type is set to SPI_NOR_EXT_REPEAT. However, Macronix
> flash requires the command type SPI_NOR_EXT_INVERT for soft
> reset.
>=20
> To address this issue, read the Manufacturer ID from the
> flash. If the Manufacturer ID indicates Macronix, then
> update the command type to SPI_NOR_EXT_INVERT.
>=20
> Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>  drivers/mtd/spi/spi-nor-core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-cor=
e.c
> index ec841fb13b..baf1941d76 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -4316,6 +4316,7 @@ static int spi_nor_soft_reset(struct spi_nor *nor)
>  {
>  	struct spi_mem_op op;
>  	int ret;
> +	u8 id[SPI_NOR_MAX_ID_LEN];
>  	enum spi_nor_cmd_ext ext;
> =20
>  	ext =3D nor->cmd_ext_type;
> @@ -4326,6 +4327,16 @@ static int spi_nor_soft_reset(struct spi_nor *nor)
>  #endif /* SPI_NOR_BOOT_SOFT_RESET_EXT_INVERT */
>  	}
> =20
> +	ret =3D nor->read_reg(nor, SPINOR_OP_RDID, id, SPI_NOR_MAX_ID_LEN);
> +	if (ret < 0) {
> +		dev_dbg(nor->dev, "error %d reading JEDEC ID\n", ret);
> +		return ret;
> +	}
> +
> +	if (id[0] =3D=3D  SNOR_MFR_MACRONIX) {
> +		nor->cmd_ext_type =3D SPI_NOR_EXT_INVERT;
> +	}
> +
>  	op =3D (struct spi_mem_op)SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_SRSTEN, 0=
),
>  			SPI_MEM_OP_NO_DUMMY,
>  			SPI_MEM_OP_NO_ADDR,

Is this expected to fix the problem Jon was reporting still with commit
5d40b3d384dc ("mtd: spi-nor: Add parallel and stacked memories support")
? And if so, it's missing a Fixes tag as well.

--=20
Tom

--RXKa853L+s64m82K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc3V80ACgkQFHw5/5Y0
tywtZQv+PMLAs1UZ1MliApYEKMw1cIEgx4PptsNNXRqslPb9Sleu5sCanps8MP5F
tOhIGhDq+Qtcbu5HtG3ZB41civQuQDgTl/m9kXMJ8hYlqOVpwsFBmTI8ew/1xIqz
HhKC6Beb3jtgyGD7qCYieLNSD17PlLULfvALOi6DaGIAwY4C563F4sSKufO8pynF
OlSrZvOYeE+6XIq+zmfJ6qIcFsLD5TR9YRZQIXEOnI1FjkcqGOcNG3Q2Ay/Zu+ES
nB7n222fSdpgFEYWweIWwtcuwn0AHjZ9rNNoX7IElqHqE/q19uNsntqG9rRY/kjs
VQyP9bvMU++5BxmO6EaTHj5txV2YsEnp45fq75qJX4ZGgnet8vNgzTggYAyKhNGL
FUxlYJQcRC16/FeeinvZMAmvxG7S9/f+mCH592pSNXiTjcWY1gKKk5FNf5igaOp4
8jdvF+oBjbhvJl6KprAJFmEhme2e6XmSCWKOIh1IVzEugJRpU+OoTJFLD/FxvpXv
NtgzVAOu
=miB1
-----END PGP SIGNATURE-----

--RXKa853L+s64m82K--
