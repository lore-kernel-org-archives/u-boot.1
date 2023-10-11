Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3A5CD6E77
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 14:44:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 297F086DF7;
	Wed, 11 Oct 2023 16:44:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iegCuTuV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97A5B86D12; Wed, 11 Oct 2023 16:44:14 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89F2686D12
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 16:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-d8195078f69so7454375276.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 07:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697035439; x=1697640239; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZlrEvDzi7eV7lAYKY3vqOlzFKNRo2E9wm/icyLFaGzc=;
 b=iegCuTuViJwNyEWCutfJMBNS45Nmc2iBsEGB//vuZ1+pS1XvxLORQMSg360lX0M/OG
 EeVxSqxrtCPJGu4BRatUh68vwMWlXu1mm1B8kprcISJbKe4cZs+BFqR7p8WlRjow/0i4
 yEYUr1DO4nkG/+oxE2WWiB9JcuSsPqbJsHvAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697035439; x=1697640239;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZlrEvDzi7eV7lAYKY3vqOlzFKNRo2E9wm/icyLFaGzc=;
 b=MFMFMuZJZO1X8qA6zDQNGngeuoA9XIFhJe+IKcBztFoK3oD8mCJX5/FsSMecr3pbJ1
 Tngb0XEqHkRo5O1SjkeaihtrxeQL1Lkjje7XEttWlPlw3rslM4rEGejIVpevnIAM6WYy
 6poZQt66OwvpIRpnaNR8CZ44n6FZxUcVT7uV8HWUGO7+htYhDsUm80Jn5mC6qTbkQ2gn
 FX1ohd8Fw/4NHRlkG/Ky4NWevOIR0ADZE79xU4PCEkVRm0HbPO+sZYxdZ8OaAh1iRsU6
 yX2dHEjPxNb34yoYsohC6606tLxkaPPl5MXRzTEminGuofjDQbdsKyKppJu8m5d5jNlW
 aE/Q==
X-Gm-Message-State: AOJu0YzZOFiJm3tMOWp4/DkOncbbOFUSzijl5GmJvqBhxThhiOP42GPa
 1ObIVcl0VGzUGQCog4ehHGEGUITigR/AkT7eDE08hQ==
X-Google-Smtp-Source: AGHT+IFbaOSLA/GWCUC7RGso4N8RN1pDnn9XB+nps372pQXuEX7ueFYE7JXg3p/gVkNF3l80x4jVuQ==
X-Received: by 2002:a25:e096:0:b0:d9a:5476:20d7 with SMTP id
 x144-20020a25e096000000b00d9a547620d7mr5258055ybg.22.1697035439222; 
 Wed, 11 Oct 2023 07:43:59 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a369-3392-aca4-1f00.res6.spectrum.com.
 [2603:6081:7b00:6400:a369:3392:aca4:1f00])
 by smtp.gmail.com with ESMTPSA id
 g61-20020a25a4c3000000b00d8168e226e6sm4543314ybi.47.2023.10.11.07.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 07:43:58 -0700 (PDT)
Date: Wed, 11 Oct 2023 10:43:56 -0400
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v4] bootstd: sata: Add bootstd support for ahci sata
Message-ID: <20231011144356.GA900529@bill-the-cat>
References: <20230917230649.30357-1-mibodhi@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2iY+Qg70QMaov608"
Content-Disposition: inline
In-Reply-To: <20230917230649.30357-1-mibodhi@gmail.com>
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


--2iY+Qg70QMaov608
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2023 at 04:06:48PM -0700, Tony Dinh wrote:
> Add ahci sata bootdev and corresponding hunting function.
>=20
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> Changes in v4:
> - Revise logic in bootmeth_script() to set devtype to sata for non-scsi
> SATA device
> - Rewrite sata_rescan() logic to properly remove all devices before probi=
ng
> - Add description to sata_rescan() header
>=20
> Changes in v3:
> - Correct drivers/ata/Makefile to compile sata_bootdev only if
> ahci sata is enabled.
>=20
> Changes in v2:
> - set devtype to sata in bootmeth_script for non-scsi SATA device.
>=20
>  boot/bootmeth_script.c     | 14 +++++++--
>  drivers/ata/Makefile       |  2 +-
>  drivers/ata/sata.c         | 32 ++++++++++++++++++++
>  drivers/ata/sata_bootdev.c | 62 ++++++++++++++++++++++++++++++++++++++
>  include/sata.h             |  6 ++++
>  5 files changed, 112 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/ata/sata_bootdev.c
>=20
> diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
> index 58c57a2d4b..96e0ec5efa 100644
> --- a/boot/bootmeth_script.c
> +++ b/boot/bootmeth_script.c
> @@ -190,10 +190,18 @@ static int script_boot(struct udevice *dev, struct =
bootflow *bflow)
>  	ulong addr;
>  	int ret;
> =20
> -	if (desc->uclass_id =3D=3D UCLASS_USB)
> +	if (desc->uclass_id =3D=3D UCLASS_USB) {
>  		ret =3D env_set("devtype", "usb");
> -	else
> -		ret =3D env_set("devtype", blk_get_devtype(bflow->blk));
> +	} else {
> +		/* If the uclass is AHCI, but the driver is ATA
> +		 * (not scsi), set devtype to sata
> +		 */
> +		if (!ret && IS_ENABLED(CONFIG_SATA) &&

This is a warning here as ret is uninitalized at this point.

--=20
Tom

--2iY+Qg70QMaov608
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUmtKYACgkQFHw5/5Y0
tyxmJwv/Qsc1PWCJBuhXfMnsUa5+l9ExPphhl/zZPeEgT3il9YbNeWT2mNsxO6ge
JtpO0223jmyVmPJtd9M+6mcFfXM/09UpJomtc2Y86IQ0v3hHU7H9Se/RP+shhREE
zfdoAgPsazrFgSxMR/KDAaVMM12r495wd99QUwslGso/uXYHvYt9vKXv8Yzk5kaW
GzwZvYAPs6X0D1As0CLhJN8mzxLVXlNU+0SVz6lUfEQFs3YwEuY+iA9av/9/q6k6
JrAm9Fyj/MkJxhGyXR0VFjQmLJsXf9w11Zykz7n1xFy5ffPld7Qeo4XfXCZiX2Uf
zAfL9+cPcIOvcWSBwGuzekzE9fmkFCEV5GJ+aTcUwntbHNZ6liYTwgAlPeY+DAVu
bZIkNNGldWIlV/DvKVQ9TMyw1syOfjNLtEgBn3hRUmiwCKmda1swDF8fLgdQZcfB
IY40fHXODwxrx1ta86iO6AJ42YU2lo6iVOOZDb/WeHiQ8Aqs9992ZzIlfntMXJ8H
9TH358K/
=5kev
-----END PGP SIGNATURE-----

--2iY+Qg70QMaov608--
