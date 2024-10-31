Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECDCD767F7
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 18:52:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B7918929F;
	Thu, 31 Oct 2024 19:52:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S9RlyBX4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 730FE892A2; Thu, 31 Oct 2024 19:52:05 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 595C288E67
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 19:52:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7b1507c42faso182667385a.0
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 11:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730400722; x=1731005522; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7MBgG/eU8+asc/XU3tpsAaiqXadxoQlREFyGFi8l7jM=;
 b=S9RlyBX4n5180kFKuGzwtPVYMyrk5Uev7cqxNk7+0+Oyn7NiOkZSXrKI6FIuRe3RqF
 Xi+JL/fuwPDPYhL+44b9q9DuBKdPfcqPajQRZ1nNY2p0ABy7TSU0jFQqyqneOPevPHXT
 UxxgkOq0DRPudLuybB+S01/MqgZgnpWt7wLEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730400722; x=1731005522;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7MBgG/eU8+asc/XU3tpsAaiqXadxoQlREFyGFi8l7jM=;
 b=i7QEv0jWw1dOQmg7z1Xf0CSaPJmiM7BqKhFBK9BAEkHhXL5WsJBX1FkX+xYffUZbym
 er2rgtIIQQBouwrWH6V4mxyoLWkUYQ1zei4i6e1Ej7ogAOm0f732J/2Xh8PGwELLkOAV
 H4qaEPB5nr12uWwAQPe+9tAzm+8rTy2cdinvK5s2UKsfwlE4vxwZtMhjUW+q4k3NVDjC
 k2rd8nvZvcP/20vgHFGzLQ/U15Jzsqu6+JGjdHC2XRqXW6MPBNIyWfFgD4VRiN4MbfXq
 Mfbr2nGPtHELDPKPvglyyPsOp3BaDLVDXtk8gZ0QcJmZoxweiJyoSlWE5f+iv943bsvG
 r+VQ==
X-Gm-Message-State: AOJu0YzIPLWY31KvTifKv20ppmCwoULtZM0RiMTjqjQW8ttAtHo+7txO
 urakTjKS65QobWPJyBuS7QZ/xlpr3o/39tVHJJgvb2tAVLDagmcKvXRN2+u1/UwSwURoMOKN8Rd
 zo2k=
X-Google-Smtp-Source: AGHT+IHkzOuyRXnHu1BPp0t6z5wUhVxAlX3UOxjSSOd8xA8tpHj6hfI11QzCEmZfCb7Pd+PM87GBUg==
X-Received: by 2002:a05:620a:46a3:b0:7b1:21c9:d1ad with SMTP id
 af79cd13be357-7b2fa655064mr184889185a.23.1730400722134; 
 Thu, 31 Oct 2024 11:52:02 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f3a83159sm95538485a.116.2024.10.31.11.52.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 11:52:00 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:51:58 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] mtd: spi-nor: Guard SPI_STACKED_PARALLEL with DM_SPI check
Message-ID: <20241031185158.GE3600562@bill-the-cat>
References: <20241031183732.3602102-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="j0+R08H1N3MRJH7h"
Content-Disposition: inline
In-Reply-To: <20241031183732.3602102-1-trini@konsulko.com>
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


--j0+R08H1N3MRJH7h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 12:37:32PM -0600, Tom Rini wrote:
> While we want to compile the SPI_STACKED_PARALLEL code everywhere we
> can, it must first be guarded with an #if for DM_SPI as not all cases
> where we have this code built, such as in SPL, will have the relevant
> DM_SPI option enabled.
>=20
> Fixes: 43423cdc5dc1 ("mtd: spi-nor: Always build SPI_STACKED_PARALLEL cod=
e")
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  drivers/mtd/spi/spi-nor-core.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-cor=
e.c
> index a3a62fff213e..ec841fb13bd4 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -3166,6 +3166,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
>  		spi_nor_post_sfdp_fixups(nor, params);
>  	}
> =20
> +#if CONFIG_IS_ENABLED(DM_SPI)
>  	if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
>  		u64 flash_size[SNOR_FLASH_CNT_MAX] =3D { 0 };
>  		struct udevice *dev =3D nor->spi->dev;
> @@ -3227,6 +3228,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
>  			params->page_size <<=3D 1;
>  		}
>  	}
> +#endif
> =20
>  	spi_nor_late_init_fixups(nor, params);
> =20

Whoops, forgot to CC Marek.

--=20
Tom

--j0+R08H1N3MRJH7h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcj0c4ACgkQFHw5/5Y0
tyzMAAwAiTU8EnU0V31TvVWyeyoCxjJu2mVn2UX7M9IoDlhRl89D1sjF4qdWpq4/
PjxrhLUPGwRnNh27p5gSIP6tc/EOTeXYw/hDM54g8fjnZvfviRCQ1V1bie4k+zNm
4TuRFqZ5hEB17UHcphmMa4vLQL9H+Nsr8lxIVMMiY6Kd58uy7ZWfuIEaFHBA+R+x
oKmTyaW2cn0MvIdHW16SPhjl5u6idGVYkBkiuwLaLkBoyW9dHEozRp8txgY1/QHv
twUUeDEPMqdBzB+nzU2xj4/1n4WCs/TUOoKJfmQ0OG0uBqhUy0zmtmeQMfc+Da0b
GG87K2QKpuHg59LfPaGYSTn8OTbKfekZKoBCJ4J4aZDrXYDKJJAchyczk8evTpAn
i9iHfIlOTftLoE4JOlBs8BIK3TJfibv9AKoyw9qK4EVnB2WpUkaJcf3VAPcmrF9+
hB0XaLjK+OC4Zx8GmsXB17RDIT+XzCyB73yYppp2UPOV00M0pfUC+RBSuLBrmqlC
DMumKMWT
=Y8Yz
-----END PGP SIGNATURE-----

--j0+R08H1N3MRJH7h--
