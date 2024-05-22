Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DEBEC25B7A
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 14:39:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D92087E96;
	Wed, 22 May 2024 16:39:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oWJ4rlza";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40DD388378; Wed, 22 May 2024 16:39:15 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2043087E52
 for <U-Boot@lists.denx.de>; Wed, 22 May 2024 16:39:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-43df3b00becso18441141cf.2
 for <U-Boot@lists.denx.de>; Wed, 22 May 2024 07:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716388752; x=1716993552; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2Pnzr2i5P1iN952flDGsCt5hhai6Mu6o2kGn/temWFI=;
 b=oWJ4rlzaHXkxU1/1q18Mgzgj2mAkXOLcwixDvzPHs2cIjgJk7AUETTRoJR3wTOqU0W
 oxSumcusa0NnT/TYRg7CEZF7oLxcCAapYdjOmntKO7FXB9gjBPpHaBLQ/Zse+qGsFx9V
 8ooM+IrE+mau8/F/XdY0j4JTCl3/LSIwQcPeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716388752; x=1716993552;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Pnzr2i5P1iN952flDGsCt5hhai6Mu6o2kGn/temWFI=;
 b=jFhamDUfw60Bd8yC4tUlBmkbeXtRVRCD21MWmxwLZToPWBmTRIyrcrT9qODp0vCn6y
 rK0pLHS/ItL69aRORTSHPiySK4mUnoMNTHR4TIs5CUkBB7/dK2o0ki3sFGWTGl267PMR
 BFOjUMoOuKP98qTp7crUjrPoOeNiv+2CGctRzx35AxomtkEQB9/nKkzVEweiIJf6gL76
 G9yKCxepKEHlObvFg9nliJgARzkopM/SqM/Om53rlJ5T0G+P6dWZGDt40cfTb8z2CLUc
 gebA8TmnEgn57H4bvAkhwfZvCml9Coop3HTdFA7XATuzXLPUOKdmdG+aT59yU+2vvv2P
 NvSQ==
X-Gm-Message-State: AOJu0Yy0WzI/t6OVfTWZ+xH8KyaPojnS9URqGufLowp5ZDhJWmD9Gasf
 Wh79NjUh54LqxWr73mlAZvf3gY0s0DwCuN3cmdGWrWOOn+8BpQoHhxjI9IU1CfE=
X-Google-Smtp-Source: AGHT+IGNqRO8ASsWxRjoi4+jhxOxRcur0HzYNnxMn6S1GVENno1vDLq/8dh1X5A18Ojk6KaW+awOtQ==
X-Received: by 2002:a05:622a:1111:b0:43a:b531:5e88 with SMTP id
 d75a77b69052e-43f9e172db8mr25441801cf.68.1716388751857; 
 Wed, 22 May 2024 07:39:11 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf340569sm1377212385a.136.2024.05.22.07.39.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 07:39:11 -0700 (PDT)
Date: Wed, 22 May 2024 08:39:08 -0600
From: Tom Rini <trini@konsulko.com>
To: "Brunham, Kalen" <kalen.brunham@intel.com>
Cc: "U-Boot@lists.denx.de" <U-Boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Message-ID: <20240522143908.GI2568172@bill-the-cat>
References: <DM4PR11MB5296B1B9F0CFC701A8B11284E3EE2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <DM4PR11MB52961423BCE12552857A12A8E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521162543.GU2568172@bill-the-cat>
 <DM4PR11MB529670F5CFDA6B4EDA7B7206E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521164659.GZ2568172@bill-the-cat>
 <DM4PR11MB529668DA50F05F26AAD229F0E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521181534.GD2568172@bill-the-cat>
 <DM4PR11MB5296769279BCDD505F614E6BE3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521234624.GF2568172@bill-the-cat>
 <DM4PR11MB5296918A0447369D6B27891DE3EB2@DM4PR11MB5296.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="l4Ou51KEcrO1Ffsk"
Content-Disposition: inline
In-Reply-To: <DM4PR11MB5296918A0447369D6B27891DE3EB2@DM4PR11MB5296.namprd11.prod.outlook.com>
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


--l4Ou51KEcrO1Ffsk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 01:25:51PM +0000, Brunham, Kalen wrote:

> Hi Tom,
>=20
> I'm using a defconfig that does not enable any of the configs listed on t=
he default likes for config BLK (MMC, USB, SCSI, etc.), but I do have DM en=
abled. I cannot however enable BLK as CONFIG_BLK=3Dy is ignored. My current=
 hypothesis is that BLK is being forced to N by the select BLK in other Kco=
nfig files, but I'm not sure.=20
>=20
> Here's the Kconfig for drivers/block:
>=20
> config BLK
> 	bool # "Support block devices"
> 	depends on DM
> 	default y if MMC || USB || SCSI || NVME || IDE || AHCI || SATA
> 	default y if EFI_MEDIA || VIRTIO_BLK || PVBLOCK
>=20
> My current flow is:
> make mrproper
> make socfpga_agilex5_defconfig
> ./scripts/kconfig/merge_config.sh -O ./ ./.config ../../my_uboot_config.t=
xt
>=20
> Here my_uboot_config.txt hsd:
>=20
> CONFIG_MMC=3Dn
> CONFIG_USB=3Dn
> CONFIG_DM_MMC=3Dn
> CONFIG_SPL_DM_MMC=3Dn
> CONFIG_BLK=3Dy
> CONFIG_EFI_LOADER=3Dy
> CONFIG_CMD_BOOTEFI=3Dy
> CONFIG_EFI_LOADER=3Dy
> CONFIG_CMD_BOOTEFI_HELLO_COMPILE=3Dy
> CONFIG_CMD_BOOTEFI_HELLO=3Dy
>=20
> The only way I was able to get BLK set to Y was to add another default li=
ke || DM_SPI_FLASH, since I do enable SPI flash in this config.=20

And why are you trying to enable BLK without any block devices?

--=20
Tom

--l4Ou51KEcrO1Ffsk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZOA4gACgkQFHw5/5Y0
tyxk8Qv/ZrxVyMsDi2dTDxgLih4pBW0tuZ0k5H9R/CqQR7oNtt4ZQEEH7HJ60oR5
kKj3xFQRtH9rH48mGK3SK+rmJL5MmX3DhUhNL0KkYEQlJ/CzaJMeM0blwil8gaAH
YFzYqSKzulsitr0Q/1q3DWW80shWmP8kX5yjenogMGWuN0vsDBSkUA4mnPTYUd2M
yxawnYJQxcbBNZtX01Gip0EK1yUhyAV+AjH+rOihfKddc+IebHJ4BVHG+j0AS0an
rHhF0cC2VXgfzjeZgS9y8V3nZ4NVDwIziivcGDn6xCd+Hw5YP4vtpUPZ245lxrAv
CkLJaqKeQiHRuZgoztVwSauaYCxb4CLzWctI9Q9+m8snRnTuPYRqStGuvbhVWftz
DoSzgIYuNGSeEh9EH9wGbUEkik+iMxhRle0EPiF7hEb4/ebPZMyED8qi0OVX19ID
PmwVVu4mCVxjP+WHGa38hI2GLneYQuog5ZF15J5Pg/TwKkGzUiF52mRyFr84HTyZ
Uv7uU1AI
=6S21
-----END PGP SIGNATURE-----

--l4Ou51KEcrO1Ffsk--
