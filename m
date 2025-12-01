Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C29D116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 17:55:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C6F583CEA;
	Mon,  1 Dec 2025 18:55:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p9UaIDpz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49F0283CF2; Mon,  1 Dec 2025 18:55:26 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19F5083CBD
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 18:55:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c765f41346so1686661a34.3
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 09:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764611723; x=1765216523; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FBqdiq/nglGrv/2Z4rY/iSZ7CKdsFSuQz2wHVpy/6k0=;
 b=p9UaIDpzotrTjX5YpxBe//xEadEt74Whl/NWkNzyQLaPyxV3t/SQEpz/KWsTuWyvD6
 6TQ9LVGxK13NWVEn6I5U/O+s8NwBoXYanuLBNDryozSoejFnjFobFG2SWmosTxxchgpT
 leQCTOh5kQOWlaJVkETprW+Rb+aR+sCOP+A/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764611723; x=1765216523;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FBqdiq/nglGrv/2Z4rY/iSZ7CKdsFSuQz2wHVpy/6k0=;
 b=J0UXMBaN4MIFCmtS1PBHUY3H6LcKnHf/moUAJKfgQCzLgPGhU4od4jYHc6Hb+Vbpix
 WXM+oZFEkxvsgravQG9XE4iizuXQ8wVKz0Qllo++7UXdUw1/Ze+qCVgE9HOqPfzJpipI
 NtF74jyapZF4Ys531U2VTmkjHRaToa3V78XIT/G3Wf0KjY8EpyljCOk5u8rqMvdZhkCA
 AWEeEISKGb+IdTyXoV7qUOKo/ka8eZMjWtlyp48v8CIYAVgcQBRYZTjEoXI8FDWzXUzs
 8AAjVWiK9hngqoJxHgHBtRKW0Q+60+jHBMOXBNKrBJqkxgTJx9YKzcPbwiZl6MfVLhx0
 YYSA==
X-Gm-Message-State: AOJu0Yzw5zBaVCf7Y6F8y7qpwNFadD9UAnnQCEaUxrGmmta52M2CM8rC
 KI9RMc7A+roOlXbpDey1f2Rp2sTFoGrip/JQ8rICw2DEUstXbH4rhDk++CscJBDhgjk=
X-Gm-Gg: ASbGncuXAMPLJ+7gWaXeSQT0o/iZvxq+mdaJ/pHjx+PGEwG5qT7PG9lryJUCpOuC0rk
 UCRtLuJdpApyHdIgabNFSTgEIBfi82kSW+CgtRtNzsXvuOGxo2d4EXh8RRgD8TsRccXYEldjAn8
 up8ibSdyWGU4LxVhLk9n3BmhyZ5TjmHO/tMvDSEGJl1VVOklChTJ9dZ8ETitdNxS1cXKYagAODm
 cO4t8ouPeouB0Rg2DNrgQKb9j/ZIR1JCm3YEEyVwhV6ACgymeEmLi2StTngC/PBEdqR+R52qxum
 Bnba6pB6C7y95h+yCyuAxwEgfyZogAM8uahZ6ECYvasQQDj0IxrDQb0LqYWYSdPgdI/vSYaFMPX
 qCaO68ROsQTJmFXlSBpFC16FFAhgFAzjCQBY5EG7JRMho/rrlDdfRjMy57LvJ5/DSBXQQGanNMl
 7J6eBj3Xf5xivPqIhYNoINK0BJz9WR1736vYcZSjgKQtkQ/LJZKw==
X-Google-Smtp-Source: AGHT+IGnR9oj/gC7GuzYJcA09R7tKJy/60aVaUqt1XitdFDoKXTFpyPGmjlRldrgTA8/hz5dOO82jA==
X-Received: by 2002:a05:6830:4108:b0:7c6:e92f:41cc with SMTP id
 46e09a7af769-7c798c4ea98mr18639725a34.21.1764611721267; 
 Mon, 01 Dec 2025 09:55:21 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90fde2292sm4893656a34.17.2025.12.01.09.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 09:55:20 -0800 (PST)
Date: Mon, 1 Dec 2025 11:55:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Simon Glass <sjg@chromium.org>, Sune Brian <briansune@gmail.com>
Subject: Re: [PATCH v2 2/5] spl: mmc: Account for
 SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE being a choice
Message-ID: <20251201175518.GB2247668@bill-the-cat>
References: <cover.1764574369.git.jan.kiszka@siemens.com>
 <56c8a3fb4a86a72839a3651dc6a7ca871b62bd01.1764574369.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CLjnG2M7Ho5xLXnZ"
Content-Disposition: inline
In-Reply-To: <56c8a3fb4a86a72839a3651dc6a7ca871b62bd01.1764574369.git.jan.kiszka@siemens.com>
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


--CLjnG2M7Ho5xLXnZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 01, 2025 at 08:32:46AM +0100, Jan Kiszka wrote:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> Add SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE as condition where so
> far SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION was enough - though often
> by chance as both options were enabled.
>=20
> Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  common/spl/spl_mmc.c | 17 +++++++++--------
>  include/part.h       |  3 ++-
>  2 files changed, 11 insertions(+), 9 deletions(-)
>=20
> diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
> index d8ce3a84614..1942e417075 100644
> --- a/common/spl/spl_mmc.c
> +++ b/common/spl/spl_mmc.c
> @@ -106,7 +106,8 @@ static int spl_mmc_find_device(struct mmc **mmcp, int=
 mmc_dev)
>  	return 0;
>  }
> =20
> -#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
> +#if defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
> +    defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
>  static int mmc_load_image_raw_partition(struct spl_image_info *spl_image,
>  					struct spl_boot_device *bootdev,
>  					struct mmc *mmc, int partition,
> @@ -419,19 +420,19 @@ int spl_mmc_load(struct spl_image_info *spl_image,
> =20
>  		raw_sect =3D spl_mmc_get_uboot_raw_sector(mmc, raw_sect);
> =20
> -#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
> -		ret =3D mmc_load_image_raw_partition(spl_image, bootdev,
> -						   mmc, raw_part,
> -						   raw_sect);
> -		if (!ret)
> -			return 0;
> -#endif
>  #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
>  		ret =3D mmc_load_image_raw_sector(spl_image, bootdev, mmc,
>  						raw_sect +
>  						spl_mmc_raw_uboot_offset(part));
>  		if (!ret)
>  			return 0;
> +#elif defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
> +      defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
> +		ret =3D mmc_load_image_raw_partition(spl_image, bootdev,
> +						   mmc, raw_part,
> +						   raw_sect);
> +		if (!ret)
> +			return 0;
>  #endif

Why do we change the order here?

--=20
Tom

--CLjnG2M7Ho5xLXnZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaS3WhgAKCRAr4qD1Cr/k
CumqAP4oC86hSXqVClQc1Tui+7r8yUlzlunfEvv9LjvBF+swcwD/cc8SuQwza91A
+JEVWXs66Y10acJyyN7LViJsk+IY1Q4=
=IZ+R
-----END PGP SIGNATURE-----

--CLjnG2M7Ho5xLXnZ--
