Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183B5C25B7A
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 14:43:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8790888831;
	Wed, 22 May 2024 16:43:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t0OuDUbg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDC4C8883E; Wed, 22 May 2024 16:43:26 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A56B87E96
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2e724bc46bfso41817391fa.3
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 07:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716389004; x=1716993804;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0PXue2gcX01wrShCbLNV1n51q16z8JP4hxykQXuqxyk=;
 b=t0OuDUbgpx93q5gR541G6w77nAXaeWARKLcGgwOEmBDiCD/0wfSf1uTjOIVNp8ep3h
 LAbPzPJu7ChIg3d6+nnVvKaGOCHHgVMYp0BeZP5WDVxiLG9bV8Au6J/M9nux3sYyEB6U
 NMlzYbaJccfPACPvV9n4pUJvZEHVhjV2ZNawkbmW+zB/OozGLD0hb5pxMgyhOxx2s4s9
 Tk/JaOySe0nZdGX2tt8iN2i8Gzg3CkPzs314HKmWTgX55enazjHfUYgQIJ+yZ8gTWYXm
 4k4+2m1a12G/F8D3C+ONtYTUE50oLCmQW8ryjUsucRG+UXlPK+N5bRjCp7py5IJdvg3A
 7pnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716389004; x=1716993804;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0PXue2gcX01wrShCbLNV1n51q16z8JP4hxykQXuqxyk=;
 b=qL6Diu297gkVO/hHWPUSIZrXIyof/+wPP0vf18z1Yn6PWJCa2Ai0QnY1sNL21TChDP
 BNAuP/pIlsw8mjRkKiZr/q7U4btFZWfzBIxNW8UQBwidEii5v6quxEhBvvfzk4+7mc8i
 F1sywshuHMM0KabArOlb8u06gG1/UU4RZnXH2asTmP9FroZQY5iF31cjdKgf3XHZEcKA
 a/Ye3esbiAQCPQhX37LtmeZhGXJ/WqrqEt42mT8yZCUyV2grTOsxEf9PwMJS/s9nH22L
 J9mG0xLfjUT9pBKFwc32qS79jRWQal3n59tl0kPWrI2XR/3L+c4aTpDHpZF93tFRi2ql
 0v0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxBrF4foGyeqyF6WQeiPKVVTbSrQ9YdRY/siIuBLswjOAtjR4Y99VFXbOEca11071ADnt3/1nBmSG23Nco+j3rONFX7g==
X-Gm-Message-State: AOJu0Yyhmz5AWLRkFGFvP6/Ih7ocTdaLEIiLgtZ9ijzgmM0BmxuBnLr4
 jcw+zpsQ6zzz5onqnv9y3ubIMRKU29C/XkgdTQ6Sp2VnCmEW9JiQlCiANUpVVnY=
X-Google-Smtp-Source: AGHT+IF6VJr+oq9otyTf0yZhY0wDIJEV8J0YLcerE2r2ibo5HefcbIyK2LwKXH939thrTsuvccSDRw==
X-Received: by 2002:a2e:330a:0:b0:2e5:67a9:4dcf with SMTP id
 38308e7fff4ca-2e9494be817mr13390571fa.18.1716389003611; 
 Wed, 22 May 2024 07:43:23 -0700 (PDT)
Received: from localhost (lfbn-tou-1-402-59.w86-206.abo.wanadoo.fr.
 [86.206.229.59]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-354c2a40548sm9657568f8f.34.2024.05.22.07.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 07:43:22 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Roman Stratiienko <r.stratiienko@gmail.com>, sjg@chromium.org,
 eajames@linux.ibm.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 paulerwan.rio@gmail.com, u-boot@lists.denx.de, igor.opaniuk@gmail.com
Cc: r.stratiienko@gmail.com
Subject: Re: [PATCH] abootimg: Add init_boot image support
In-Reply-To: <20240519125337.2557883-1-r.stratiienko@gmail.com>
References: <20240519125337.2557883-1-r.stratiienko@gmail.com>
Date: Wed, 22 May 2024 16:43:19 +0200
Message-ID: <874japzz3s.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Roman,

Thank you for the patch.

On dim., mai 19, 2024 at 12:53, Roman Stratiienko <r.stratiienko@gmail.com>=
 wrote:

> Quote from [1]:
>
> "For devices launching with Android 13, the generic ramdisk is removed
> from the boot image and placed in a separate init_boot image.
> This change leaves the boot image with only the GKI kernel."
>
> [1]: https://source.android.com/docs/core/architecture/partitions/generic=
-boot
> Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> ---
>  boot/image-board.c |  5 ++++-
>  cmd/abootimg.c     | 26 +++++++++++++++++++++-----
>  include/image.h    |  7 +++++++
>  3 files changed, 32 insertions(+), 6 deletions(-)

This patch does not apply on:
- next: 7d24c3e06fa9 ("Merge patch series "scripts/setlocalversion sync wit=
h linux 6.9"")
- master: a7f0154c4128 ("Prepare v2024.07-rc3")

Please consider rebasing when resending.

More review below

>
> diff --git a/boot/image-board.c b/boot/image-board.c
> index 75f6906cd5..715654ff01 100644
> --- a/boot/image-board.c
> +++ b/boot/image-board.c
> @@ -414,9 +414,12 @@ static int select_ramdisk(struct bootm_headers *imag=
es, const char *select, u8 a
>  			int ret;
>  			if (IS_ENABLED(CONFIG_CMD_ABOOTIMG)) {
>  				void *boot_img =3D map_sysmem(get_abootimg_addr(), 0);
> +				void *init_boot_img =3D map_sysmem(get_ainit_bootimg_addr(), 0);
>  				void *vendor_boot_img =3D map_sysmem(get_avendor_bootimg_addr(), 0);
> +				void *ramdisk_img =3D (init_boot_img =3D=3D -1) ? boot_img :
> +									    init_boot_img;

This line introduces a build warning:

../boot/image-board.c: In function =E2=80=98select_ramdisk=E2=80=99:
../boot/image-board.c:412:68: warning: comparison between pointer and integ=
er
  412 |                                 void *ramdisk_img =3D (init_boot_im=
g =3D=3D -1) ? boot_img :
      |                                                                    =
^~

Can we please fix it in v2 ?

>=20=20
> -				ret =3D android_image_get_ramdisk(boot_img, vendor_boot_img,
> +				ret =3D android_image_get_ramdisk(ramdisk_img, vendor_boot_img,
>  								rd_datap, rd_lenp);
>  				unmap_sysmem(vendor_boot_img);

Can we please add unmap_sysmem(init_boot_img); here as well ?

>  				unmap_sysmem(boot_img);
> diff --git a/cmd/abootimg.c b/cmd/abootimg.c
> index e68c523705..7c450a3b2d 100644
> --- a/cmd/abootimg.c
> +++ b/cmd/abootimg.c
> @@ -17,6 +17,7 @@
>=20=20
>  /* Please use abootimg_addr() macro to obtain the boot image address */
>  static ulong _abootimg_addr =3D -1;
> +static ulong _ainit_bootimg_addr =3D -1;
>  static ulong _avendor_bootimg_addr =3D -1;
>=20=20
>  ulong get_abootimg_addr(void)
> @@ -24,6 +25,11 @@ ulong get_abootimg_addr(void)
>  	return (_abootimg_addr =3D=3D -1 ? image_load_addr : _abootimg_addr);
>  }
>=20=20
> +ulong get_ainit_bootimg_addr(void)
> +{
> +	return _ainit_bootimg_addr;
> +}
> +
>  ulong get_avendor_bootimg_addr(void)
>  {
>  	return _avendor_bootimg_addr;
> @@ -209,7 +215,7 @@ static int do_abootimg_addr(struct cmd_tbl *cmdtp, in=
t flag, int argc,
>  	char *endp;
>  	ulong img_addr;
>=20=20
> -	if (argc < 2 || argc > 3)
> +	if (argc < 2 || argc > 4)
>  		return CMD_RET_USAGE;
>=20=20
>  	img_addr =3D hextoul(argv[1], &endp);
> @@ -220,16 +226,26 @@ static int do_abootimg_addr(struct cmd_tbl *cmdtp, =
int flag, int argc,
>=20=20
>  	_abootimg_addr =3D img_addr;
>=20=20
> -	if (argc =3D=3D 3) {
> +	if (argc > 2) {
>  		img_addr =3D simple_strtoul(argv[2], &endp, 16);
>  		if (*endp !=3D '\0') {
> -			printf("Error: Wrong vendor image address\n");
> +			printf("Error: Wrong vendor_boot image address\n");

Nitpick: this seems like a harmless change but could be done in a
separate patch.

To me, it's fine to include this hunk, but can we mention it in the
commit message?

Something along the lines as "While at it, update wrong error handling
message when vendor_boot cannot be loaded".

>  			return CMD_RET_FAILURE;
>  		}
>=20=20
>  		_avendor_bootimg_addr =3D img_addr;
>  	}
>=20=20
> +	if (argc =3D=3D 4) {
> +		img_addr =3D simple_strtoul(argv[3], &endp, 16);
> +		if (*endp !=3D '\0') {
> +			printf("Error: Wrong init_boot image address\n");
> +			return CMD_RET_FAILURE;
> +		}
> +
> +		_ainit_bootimg_addr =3D img_addr;
> +	}
> +
>  	return CMD_RET_SUCCESS;
>  }
>=20=20
> @@ -346,7 +362,7 @@ fail:
>  }
>=20=20
>  static struct cmd_tbl cmd_abootimg_sub[] =3D {
> -	U_BOOT_CMD_MKENT(addr, 3, 1, do_abootimg_addr, "", ""),
> +	U_BOOT_CMD_MKENT(addr, 4, 1, do_abootimg_addr, "", ""),
>  	U_BOOT_CMD_MKENT(dump, 2, 1, do_abootimg_dump, "", ""),
>  	U_BOOT_CMD_MKENT(get, 5, 1, do_abootimg_get, "", ""),
>  	U_BOOT_CMD_MKENT(load, 5, 1, do_abootimg_load, "", ""),
> @@ -375,7 +391,7 @@ static int do_abootimg(struct cmd_tbl *cmdtp, int fla=
g, int argc,
>  U_BOOT_CMD(
>  	abootimg, CONFIG_SYS_MAXARGS, 0, do_abootimg,
>  	"manipulate Android Boot Image",
> -	"addr <boot_img_addr> [<vendor_boot_img_addr>]>\n"
> +	"addr <boot_img_addr> [<vendor_boot_img_addr> [<init_boot_img_addr>]]\n"
>  	"    - set the address in RAM where boot image is located\n"
>  	"      ($loadaddr is used by default)\n"

Please include the help text update in the documentation:
doc/android/boot-image.rst

>  	"abootimg dump dtb\n"
> diff --git a/include/image.h b/include/image.h
> index be3c73a72e..b1fd6b3149 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -1982,6 +1982,13 @@ bool is_android_vendor_boot_image_header(const voi=
d *vendor_boot_img);
>   */
>  ulong get_abootimg_addr(void);
>=20=20
> +/**
> + * get_ainit_bootimg_addr() - Get Android init boot image address
> + *
> + * Return: Android init boot image address
> + */
> +ulong get_ainit_bootimg_addr(void);
> +
>  /**
>   * get_avendor_bootimg_addr() - Get Android vendor boot image address
>   *
> --=20
> 2.40.1
