Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2ECCD4F32
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 21:27:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F2F988B94;
	Wed,  4 Sep 2024 23:27:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BQs7XI5E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8766088B94; Wed,  4 Sep 2024 23:27:28 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49B2B88381
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 23:27:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-45684218d61so679961cf.1
 for <u-boot@lists.denx.de>; Wed, 04 Sep 2024 14:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725485245; x=1726090045; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TDFdzEJC5OZNbRLXfZiOez4H8R9E+7wPtcOqYZsvMdM=;
 b=BQs7XI5EC4Rr2p7U/+cMq/H6grLS6tVz+EJpSE2DYemoqwl53Fhd/USwEzhFnvWDW0
 hrhXNBcumUt0Yf1YL/9WBV9GQSo3TqFKgEbbBQKWGWCtX4gLdSepD3OwDyxxjtMEJdTm
 vdcJkNIhoqSZvGpfaXSjT9M+/AILmg7YUJ/3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725485245; x=1726090045;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TDFdzEJC5OZNbRLXfZiOez4H8R9E+7wPtcOqYZsvMdM=;
 b=uNkbSyVL0pwI8PLtypcEN+6HeQXA5TmstITx1+f+34XEAOkXvEOlXuHLSxOYLouBmz
 tdnt43K6eHM7xE44WLrjnU6frc1mcxWwEOzAovNd9niE1l/cRN2E+L7HTASqjfUVuCq/
 r61hA8Py4hF7180G1lrQAaq+dG85A96bVcL535upo2rRY4xwfZJelT9CfFZdtpuPitEi
 BPJ5euxXVYh04n8qpKFRd+H0zmScrxPr+BXP5JfbD1DU8LhjYO0+FwD0QI4M2QWz4YMI
 MFh21/gHWXhbhJUfuvOXu9XM8mfgA2HhB3+4BDsnayFk5k43K3xkcG1xee6VrxpvKKRy
 FIGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv0ett771fNrLJiWIMMskFRwqdxZk0b6e3V5TPGsKR2z3MyEuH8++62wjLYHEHPOTciWVZaWo=@lists.denx.de
X-Gm-Message-State: AOJu0Ywrr/kviGbWw0KqYyjVnCvWiAHyf9enDs45xd8fdLqjHtK8qfl/
 0tJYPGl2v7vRHghFTzV8Uy8JJAzge4VvoOkizF97Lx8OnEzU9qfsMxl0XabGy5c=
X-Google-Smtp-Source: AGHT+IFimwbBOR1Ukvtfui9eYYNOa0yD0QV1zHD99pX64NT6ddkHm4rcac/QpYvOHPuEYRUl9x7zNQ==
X-Received: by 2002:a05:622a:40c5:b0:453:2e51:e40a with SMTP id
 d75a77b69052e-4567f6b57f3mr244595701cf.46.1725485244867; 
 Wed, 04 Sep 2024 14:27:24 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45801b327edsm1945781cf.28.2024.09.04.14.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 14:27:24 -0700 (PDT)
Date: Wed, 4 Sep 2024 15:27:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Hiago De Franco <hiagofranco@gmail.com>, Keerthy <j-keerthy@ti.com>,
 Amjad Ouled-Ameur <aouledameur@baylibre.com>, u-boot@lists.denx.de,
 Hiago De Franco <hiago.franco@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH] fs: Fix SPL build if SPL_FS_LOADER is enabled and
 FS_LOADER is disabled
Message-ID: <20240904212721.GZ2479150@bill-the-cat>
References: <20240826181933.252020-1-hiagofranco@gmail.com>
 <20240830205119.GA3268574@bill-the-cat>
 <20240831134911.GA32220@francesco-nb>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="An19XbPV4hUSWa8a"
Content-Disposition: inline
In-Reply-To: <20240831134911.GA32220@francesco-nb>
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


--An19XbPV4hUSWa8a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 03:49:11PM +0200, Francesco Dolcini wrote:
> On Fri, Aug 30, 2024 at 02:51:19PM -0600, Tom Rini wrote:
> > On Mon, Aug 26, 2024 at 03:19:33PM -0300, Hiago De Franco wrote:
> >=20
> > > From: Hiago De Franco <hiago.franco@toradex.com>
> > >=20
> > > When SPL_FS_LOADER is set to y and FS_LOADER is not enabled, the SPL =
build
> > > fails with the following errors:
> > >=20
> > >   AR      spl/boot/built-in.o
> > >   LD      spl/u-boot-spl
> > > arm-none-linux-gnueabihf-ld.bfd: drivers/misc/fs_loader.o: in function
> > > `fw_get_filesystem_firmware':
> > > /u-boot/drivers/misc/fs_loader.c:162: undefined reference to
> > > `fs_set_blk_dev'
> > > arm-none-linux-gnueabihf-ld.bfd: /home/frh/tdx/src/u-boot/drivers/mis=
c/
> > > fs_loader.c:185: undefined reference to `fs_read'
> > > arm-none-linux-gnueabihf-ld.bfd: drivers/misc/fs_loader.o: in function
> > > `select_fs_dev':
> > > /u-boot/drivers/misc/fs_loader.c:89: undefined reference to
> > > `fs_set_blk_dev_with_part'
> > > make[1]: *** [scripts/Makefile.spl:527: spl/u-boot-spl] Error 1
> > > make: *** [Makefile:2055: spl/u-boot-spl] Error 2
> > >=20
> > > Fix it by replacing the FS_LOADER with SPL_FS_LOADER in the Makefile,=
 so
> > > the fs.c with the necessary function definitions are compiled.
> > >=20
> > > Fixes: b071a07743d4 ("drivers: misc: Makefile: Enable fs_loader compi=
lation at SPL Level")
> > > Suggested-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> > > Reviewed-by: Tom Rini <trini@konsulko.com>
> >=20
> > This leads to failure to build on sandbox_noinst_defconfig.
>=20
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -110,6 +110,7 @@ config EFI_MEDIA
>  config SPL_BLK_FS
>         bool "Load images from filesystems on block devices"
>         depends on SPL_BLK
> +       select SPL_FS_LOADER
>         help
>           Use generic support to load images from fat/ext filesystems on
>           different types of block devices such as NVMe.
>=20
>=20
> ?

I think "depends on" and sandbox_noinst_defconfig should enable
CONFIG_SPL_FS_LOADER too.

--=20
Tom

--An19XbPV4hUSWa8a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbY0LkACgkQFHw5/5Y0
tywBvwv/WiOu/Qr8bQzStA8yy0WWXE9mtUe31KYWA7naR6jjkRqDUy4ibkthwYeq
DElGycuotQnj8jDuORpNVwzS4ziJ4PzaUilmxK2dVmz1lgisprmqdlZ3wi85W/t1
+8bUdEjzh9oGJYpSOG78GMl2ydK5/cVNGV5B5siIRre2o69PSxo6DOF5j9R0Lnq2
fyLELaUFvopZbpLzJrlGYUqnCVhdG1wVOH+r+7mGD2DLekmA3wkv4PAsgbEp81Lo
BHF+VMb0XPC9kaddtTZSdcbGXHO0Y3XKDHWnT72DRpfiJ2Ya8zzyK0mVJ/+NRT/w
VoHkBlFOCeEL667gHyRZ8cpReYfwU5w5BXVQgagWfNFlzn7pRUqHKvC+DOtzlgTn
Har3uVAOX+l5x2/Bzd2IjkjWnVgaFHyFJeQ6P3Uiwo3hl7ivEVtTRFDcd+68f8zP
zh754SdDt8R3j1QnvK5z2Ke70BpJcxkkdQ0KIEUaKtooeHHuMECmNHrXEoJnWdSr
sT4HcsHV
=twuE
-----END PGP SIGNATURE-----

--An19XbPV4hUSWa8a--
