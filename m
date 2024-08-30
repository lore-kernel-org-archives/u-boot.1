Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D34CA0EF3
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 20:51:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C73FC88CD5;
	Fri, 30 Aug 2024 22:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mm9ipziQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ABA088CF2; Fri, 30 Aug 2024 22:51:27 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E11E88AB2
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 22:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6b8f13f28fbso19831217b3.1
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 13:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725051084; x=1725655884; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+IiyI5aZxaCiccS/t61R6QOrbQ0cOLDYyjocJPBMfyo=;
 b=mm9ipziQSPEidtDCbB9k8U7wp1gmO59OdB1UfMmw1E6aVoVwXHc6aotTZ3w34OlaTw
 eTEBpXip0ekhHIS34euVQm55Dd8tOmjKQp/QwoIWfgyLaI9tSqNmlfShRcvbKEpLGhZq
 WUj4soG+1d9YJhY20BX4ULldqynIV3nbWt9e0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725051084; x=1725655884;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+IiyI5aZxaCiccS/t61R6QOrbQ0cOLDYyjocJPBMfyo=;
 b=pkrS6KtAgIYpoZDlpKDVY6q/c5EngY7iqtjwT7jhjfclCDvXW16Q6iZFeoG37pGY+x
 lXYkPSLmjJvUBygfKHfv/hrsENJBBX/HJR257LsXkwYUJkAEFpM4igV51hdWAVa8fiIW
 5FJCog8ZJIWGckVgJaf8P9/69Obz847rw/e1QipNA+EyihIaAZd+k4I/b8tG/t5dazCR
 pkoyii+2b7zSGlhteNWl1sxk6abLmhzm92BeqOIAG4CBgtuV+2FndvCJ0y0Uifo/DVct
 rVE72S8rUlbJrzQShRqaCf+auMYldgB9JiKc4maFb4cyyVFgrFo0ibdiXC95Tlqo8cAZ
 8fkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqs7OHfWw6hL5ZexXk/5H4hqzP/Tdqk7oXmmvZ0m3Obv8KzwchivX5iDI+IZ2gg7zZiv2jeaE=@lists.denx.de
X-Gm-Message-State: AOJu0Yzvpm3lPdRGFJJkeKMy0HbQPXeTUuT0So5tff7ylxMSJy58aWxk
 dYR74EhNr1TvW1Vw3mJj4HLT99Wdcc62cFRUnHlSp7eqo+AZyrNcQ9QFMwPUUNY=
X-Google-Smtp-Source: AGHT+IGHNzOmvrE6Ccsdt0CxqQ8dZ8VXQ49b5GehAsOzUvBuRV3ZnDiI7RMx3kLeWTNhzDh/f+S9Fg==
X-Received: by 2002:a05:690c:108:b0:64b:893f:fc28 with SMTP id
 00721157ae682-6d4102f705dmr28881307b3.46.1725051084103; 
 Fri, 30 Aug 2024 13:51:24 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a806c255d6sm177971085a.45.2024.08.30.13.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 13:51:22 -0700 (PDT)
Date: Fri, 30 Aug 2024 14:51:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Keerthy <j-keerthy@ti.com>,
 Amjad Ouled-Ameur <aouledameur@baylibre.com>, u-boot@lists.denx.de,
 Hiago De Franco <hiago.franco@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH] fs: Fix SPL build if SPL_FS_LOADER is enabled and
 FS_LOADER is disabled
Message-ID: <20240830205119.GA3268574@bill-the-cat>
References: <20240826181933.252020-1-hiagofranco@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JFaevNp+gmKIs4MS"
Content-Disposition: inline
In-Reply-To: <20240826181933.252020-1-hiagofranco@gmail.com>
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


--JFaevNp+gmKIs4MS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 03:19:33PM -0300, Hiago De Franco wrote:

> From: Hiago De Franco <hiago.franco@toradex.com>
>=20
> When SPL_FS_LOADER is set to y and FS_LOADER is not enabled, the SPL build
> fails with the following errors:
>=20
>   AR      spl/boot/built-in.o
>   LD      spl/u-boot-spl
> arm-none-linux-gnueabihf-ld.bfd: drivers/misc/fs_loader.o: in function
> `fw_get_filesystem_firmware':
> /u-boot/drivers/misc/fs_loader.c:162: undefined reference to
> `fs_set_blk_dev'
> arm-none-linux-gnueabihf-ld.bfd: /home/frh/tdx/src/u-boot/drivers/misc/
> fs_loader.c:185: undefined reference to `fs_read'
> arm-none-linux-gnueabihf-ld.bfd: drivers/misc/fs_loader.o: in function
> `select_fs_dev':
> /u-boot/drivers/misc/fs_loader.c:89: undefined reference to
> `fs_set_blk_dev_with_part'
> make[1]: *** [scripts/Makefile.spl:527: spl/u-boot-spl] Error 1
> make: *** [Makefile:2055: spl/u-boot-spl] Error 2
>=20
> Fix it by replacing the FS_LOADER with SPL_FS_LOADER in the Makefile, so
> the fs.c with the necessary function definitions are compiled.
>=20
> Fixes: b071a07743d4 ("drivers: misc: Makefile: Enable fs_loader compilati=
on at SPL Level")
> Suggested-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>

This leads to failure to build on sandbox_noinst_defconfig.

> ---
>  fs/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/Makefile b/fs/Makefile
> index 7b05c79e0ccf..a3ee0a361d3d 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -5,7 +5,7 @@
>  # Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
> =20
>  ifdef CONFIG_SPL_BUILD
> -obj-$(CONFIG_FS_LOADER) +=3D fs.o
> +obj-$(CONFIG_SPL_FS_LOADER) +=3D fs.o
>  obj-$(CONFIG_SPL_FS_FAT) +=3D fat/
>  obj-$(CONFIG_SPL_FS_EXT4) +=3D ext4/
>  obj-$(CONFIG_SPL_FS_CBFS) +=3D cbfs/

--=20
Tom

--JFaevNp+gmKIs4MS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbSMMQACgkQFHw5/5Y0
tyypxgv/VBnFF7QsYrDX7ALEhRAVzTYfOi112qXBTbUpcbAAu6guyInAfWvTWIUF
qiBTi6XvYthcAuvFI9ZyKlpT+TcLxnixsImm3mIxPUxZ84JGN7Oh0MmnegSewSVx
aLZ/bzW1P/Xnmq0aDm+DyI5syQg0x9TT19xOcgejXAgeOQXrmf8wL77vnVYPIbqZ
srKMtb8ScYghlyG285ChKmDQmB+QzwlJfr04p6/BHf44DqYuQ3VjYJe/a8lOsvBo
G6f0SP3uexjW+lJdV+07bVNuYY8LF0R+Ma+kXCwG6T7h/tAJ82BaOItizHz6/dm/
GjgebUPZ1+DuRhlcMo8jI1JPXKWJO8JhasQEyQsMOACRxUvdpwOyjmpYR+EwaOZA
KyEL41KOreSdhEdBCxlhFSQsGK/IEJAugjujxwZH2zbc2Pv8Lwf8Nn+clHebM7X7
DgKil7jnCPQ8pMnVs3UBmhd/IEtFlmQSjM/qLcQ92vw3wHPdQFOmC0hEfQOi/Xb8
CGvIc4gB
=7Ret
-----END PGP SIGNATURE-----

--JFaevNp+gmKIs4MS--
