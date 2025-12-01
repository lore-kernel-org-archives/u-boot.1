Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410B4D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 20:01:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6E1883D4A;
	Mon,  1 Dec 2025 21:01:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gyzVxtJp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CF2883D8B; Mon,  1 Dec 2025 21:01:40 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3831883D39
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 21:01:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-657509d761dso2379345eaf.0
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 12:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764619297; x=1765224097; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=d7r+u4G/RmWaImffZOCyv3vUh5Ba0D1Am2W/BKGnYn4=;
 b=gyzVxtJpxZc/wLlZ8tRihh/V0on8tL2tmqieX0nlIDXf70vEA8rYVXuZaYCofnAQtw
 26AcmIVAqWftO4h41dS5Ui6p2IPTE4XQI6jI6XYaUPJ9mM0FQ3HS9J86QF0OAyeTM6ao
 bsX+bazJW2yAsrach6YvPrsBv1aJWdoAJWdpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764619297; x=1765224097;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d7r+u4G/RmWaImffZOCyv3vUh5Ba0D1Am2W/BKGnYn4=;
 b=urzVWXQr58YlVpowTjLfnQgYUC+WUe7nKWautLGHSgFgckBk4P8IM9NjgOb5+IXLWX
 pqzcOeRw7xs5xptk0oWwhtSRMr3UmYgkaBUGbSP76sIFBEbwkKkPAfeYUuN97u7h7wU+
 EMjTUAxpQgcOQ5T+niG2NI8kePVmVK1wPVUNlHNuqlvt5WZDJJTGYJyVSgcUlqDLGEeb
 1jatQnYH0rUuf4ARxu7kXla5KIXRhfyTavgp9OsbRyFPAbUKBNswN1hrwNYYC9adysiQ
 4RqrAM12MI0Kovbq8RphPe+sH6DutY5lzko1B/TDm0tP3sCRMRx2RSEYcCoDxZ9UrDST
 rudg==
X-Gm-Message-State: AOJu0YxyrXNOmV2jtPN9yKECGEPiZTBP6SF5OK0AystdCWEgpjvBfVdn
 2eSmHOFeCfiVCR+iJinFGQnCeWDdSpurMSFmE1EVbKs1twgxqXZYxk4bVgt81A8fpkL1YtfylX1
 syVW334g=
X-Gm-Gg: ASbGncupsH6HAmAodkxAtvkluy75Jku641sEJHhKHoOcliNqZ179d06mrNlFAubSTWe
 QpCR+UwNhD5yvUcTNx60v7fqXj8vDmRahMqQf2rTLQpC0Tq2cMB9i8yzCXuyXvWTcMYsh2Ox4O9
 T7RbmGRLn07UA1jf3MmJpJavSdpbDBpPvrhN3G/be17djqJaQ1Ult6aYGLvr5KAWAYUHpe5bUTV
 0UtcTMvt6XGrPQ2A8ziFhhIo9Lfobgv9So95t1IST/I26Dy/g84ekMgvNmTaMMChce8Azn/gs4H
 oqCG2TPmcmQsWwfMWEQinAEpvVYvgyeIGEMmX8f60HTpzms7smYm9wNMS0J+osTPnHQ3caoTIEP
 ZpIiolJokEFllBUs5r+TPRwFswqFbo/iwpNSsRMrW5ojMWRBnK46MJ6TiuCpuDSgfzW7NOoaB6j
 xccwBzXdRmXMu9zs1DXutADQBKOL14fKUqi/rtB3zsLwVoMH4Ysg==
X-Google-Smtp-Source: AGHT+IH6Wi/fFHHJGe1KhSgjH1XW610l+PQUbk1ZEvnZmsKWMELEjDo9IVyDV6G+ZDwzQq3usLA0sw==
X-Received: by 2002:a05:6820:1890:b0:657:4e49:83b7 with SMTP id
 006d021491bc7-6579206444bmr15157491eaf.1.1764619296639; 
 Mon, 01 Dec 2025 12:01:36 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dd023f61sm5887680fac.16.2025.12.01.12.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 12:01:36 -0800 (PST)
Date: Mon, 1 Dec 2025 14:01:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Simon Glass <sjg@chromium.org>, Sune Brian <briansune@gmail.com>
Subject: Re: [PATCH v2 2/5] spl: mmc: Account for
 SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE being a choice
Message-ID: <20251201200133.GX303283@bill-the-cat>
References: <cover.1764574369.git.jan.kiszka@siemens.com>
 <56c8a3fb4a86a72839a3651dc6a7ca871b62bd01.1764574369.git.jan.kiszka@siemens.com>
 <20251201175518.GB2247668@bill-the-cat>
 <8a3bc250-48fd-468b-8ca5-630c0d819f8f@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OJ7ibMCNMvMrVLOg"
Content-Disposition: inline
In-Reply-To: <8a3bc250-48fd-468b-8ca5-630c0d819f8f@siemens.com>
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


--OJ7ibMCNMvMrVLOg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 01, 2025 at 08:59:26PM +0100, Jan Kiszka wrote:
> On 01.12.25 18:55, Tom Rini wrote:
> > On Mon, Dec 01, 2025 at 08:32:46AM +0100, Jan Kiszka wrote:
> >=20
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> Add SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE as condition where so
> >> far SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION was enough - though often
> >> by chance as both options were enabled.
> >>
> >> Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> ---
> >>  common/spl/spl_mmc.c | 17 +++++++++--------
> >>  include/part.h       |  3 ++-
> >>  2 files changed, 11 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
> >> index d8ce3a84614..1942e417075 100644
> >> --- a/common/spl/spl_mmc.c
> >> +++ b/common/spl/spl_mmc.c
> >> @@ -106,7 +106,8 @@ static int spl_mmc_find_device(struct mmc **mmcp, =
int mmc_dev)
> >>  	return 0;
> >>  }
> >> =20
> >> -#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
> >> +#if defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
> >> +    defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
> >>  static int mmc_load_image_raw_partition(struct spl_image_info *spl_im=
age,
> >>  					struct spl_boot_device *bootdev,
> >>  					struct mmc *mmc, int partition,
> >> @@ -419,19 +420,19 @@ int spl_mmc_load(struct spl_image_info *spl_imag=
e,
> >> =20
> >>  		raw_sect =3D spl_mmc_get_uboot_raw_sector(mmc, raw_sect);
> >> =20
> >> -#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
> >> -		ret =3D mmc_load_image_raw_partition(spl_image, bootdev,
> >> -						   mmc, raw_part,
> >> -						   raw_sect);
> >> -		if (!ret)
> >> -			return 0;
> >> -#endif
> >>  #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
> >>  		ret =3D mmc_load_image_raw_sector(spl_image, bootdev, mmc,
> >>  						raw_sect +
> >>  						spl_mmc_raw_uboot_offset(part));
> >>  		if (!ret)
> >>  			return 0;
> >> +#elif defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
> >> +      defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
> >> +		ret =3D mmc_load_image_raw_partition(spl_image, bootdev,
> >> +						   mmc, raw_part,
> >> +						   raw_sect);
> >> +		if (!ret)
> >> +			return 0;
> >>  #endif
> >=20
> > Why do we change the order here?
> >=20
>=20
> Because v1 tried #if ...USE_SECTOR #else - and failed. Leftover. If
> preferred, I can keep the original order. OTOH, it's the order of mode
> enumerations now.

OK, order of enumerations makes sense. Please re-word to explain this
change as intentional and why and with that:

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--OJ7ibMCNMvMrVLOg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaS30GgAKCRAr4qD1Cr/k
Cj1wAQDrBTuYYXNpRAZC8r4TOhJst9YjzBp0k7rLZCb6EUWHFwEA3UTwvRxDDZ/1
q2Ty6W/SlYOAQTKxJ8FHdC35Q4CYKAI=
=HThj
-----END PGP SIGNATURE-----

--OJ7ibMCNMvMrVLOg--
