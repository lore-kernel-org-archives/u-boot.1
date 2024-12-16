Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6817CE77180
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 08:41:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D38608005B;
	Mon, 16 Dec 2024 09:41:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fly/k4kb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEB2280104; Mon, 16 Dec 2024 09:41:11 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65DD38003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 09:41:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-385e27c75f4so2967748f8f.2
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 00:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734338467; x=1734943267;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=raRUIQTMT6vpJxiPdvVREn9hwnAWvX3F49LN7a81EgM=;
 b=fly/k4kbHHnvUfZ498+pbwyGOY60e1NAXyzEs1kcQA8A/5EDdJ2lNuaa929i/4vIV2
 DzykHnhqZgpOaZmuuN1HH0XC0Qu8zjBXeiDBa+86ze99RTd9fX7a5A60t28h5X6wDACI
 SysmLWtXgsyOrwx/CzW/7svT5mwqR17OZ6wmkv2Ino4/L5028S5iUVHZNPAaHZHovI3v
 9rGiYOFbClCJsEGEz31lUqN3z4PM2n1Imi0geacXvJTYiUxGs4xO5z3uAv4LQygvpGFg
 oT6GABCV8dyltFh7tCffZL7CDYBVpXxWP+ow6lmjDcP0wul9sv3iMjnzvbP2hyTm/cvN
 3MWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734338467; x=1734943267;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=raRUIQTMT6vpJxiPdvVREn9hwnAWvX3F49LN7a81EgM=;
 b=XGV/CUw0YKi3upGUuDylWnK31uMskWjQnW1MO6H8P7pz7oOgQsrQnbgEIWcnwJPXnM
 Lgwsa6tNHjEzEgz6PqUIC9vlmnrx1LePAERpeqA3MyQ75xCVo+Kgodh0UF0EJDIykh0Z
 P2LCc3iw2j8OXJWqjudZzbjMm6lr1rssWQsi9F7EVvNReHlcMkemWyOgtmvEwNHJTHbx
 MMOX4Zw5hwapbXTpMzcbkvBBkfO0pAPU2fTsJ/Hj0CGQEPUZ5ZhOZoKavssrXOukPvMQ
 stGewrgFn9gQi/f/ZZldlXUoq/TgarRT8zNHjjP16ZUp3LaWtGgw5WM97jTLUVpauguD
 kVqg==
X-Gm-Message-State: AOJu0YyC9EnLFd3zsYNnCACluvKEVyf6Y4CBEgucYYELJPA1kOot30QG
 rGx5AaGVHo2ZztxaIYzSMusSPc7lQ56bYd+DA3n+NsYrO1ru/BBgjoS92YzwVeo=
X-Gm-Gg: ASbGncvBAwmvYv+dAxOz3XUhZRxbm6pZZlKKJtvMF9mKcOczrgG8avDAZTjmidCnNgH
 hlOaRRishry9d0lmj5rHXmKJ40FdmbyN38OB42EXuyNZ+/SRvhGxp8quZ5iAM4CBKac4zVtrbqY
 NR80yIjhIarLi+6X8i51c/JWuO11rmmFZFF0s79chOfv3n0JfdJappvNETNoHUa/44+qPrdn3kQ
 pqWsKW7XHx8zDhlRj3+AHM1SqdGT7MSxgZ8iH8J6QMXgkJLvbT2dcjHb+DyzLrPmw==
X-Google-Smtp-Source: AGHT+IFhpWT6fv1o83PGF4nOV2/avRxlaeM8j5uxoha2zxxIjWIU4NnGvXg6AOZ/J/sMNrqTE0h82g==
X-Received: by 2002:a05:6000:1ac9:b0:385:f3fb:46a5 with SMTP id
 ffacd0b85a97d-3888e0c16c1mr8099696f8f.52.1734338466784; 
 Mon, 16 Dec 2024 00:41:06 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80163b8sm7376075f8f.35.2024.12.16.00.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 00:41:06 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nicolas Belin <nbelin@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Safae Ouajih <souajih@baylibre.com>, Ahmad
 Draidi <ar2000jp@gmail.com>
Cc: u-boot@lists.denx.de, Nicolas Belin <nbelin@baylibre.com>
Subject: Re: [PATCH 3/4] boot: android: rework bootargs concatenation
In-Reply-To: <20241211-fix-bootargs-concatenation-v1-3-c6752bcb9dde@baylibre.com>
References: <20241211-fix-bootargs-concatenation-v1-0-c6752bcb9dde@baylibre.com>
 <20241211-fix-bootargs-concatenation-v1-3-c6752bcb9dde@baylibre.com>
Date: Mon, 16 Dec 2024 09:41:05 +0100
Message-ID: <87cyhsxboe.fsf@baylibre.com>
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

Hi Nicolas,

Thank you for the patch.

On mer., d=C3=A9c. 11, 2024 at 14:53, Nicolas Belin <nbelin@baylibre.com> w=
rote:

> Rework the bootargs concatenation allocating more accurately
> the length that is needed.
> Do not forget an extra byte for the null termination byte as,
> in some cases, the allocation was 1 byte short.
>
> Fixes: 86f4695b ("image: Fix Android boot image support")
> Signed-off-by: Nicolas Belin <nbelin@baylibre.com>
> ---
>  boot/image-android.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/boot/image-android.c b/boot/image-android.c
> index 362a5c7435a3a8bcf7b674b96e31069a91a892b5..ed72a5c30424a453c1800bc61=
edbe8f33b31b341 100644
> --- a/boot/image-android.c
> +++ b/boot/image-android.c
> @@ -289,7 +289,7 @@ int android_image_get_kernel(const void *hdr,
>  	int len =3D 0;
>  	if (*img_data.kcmdline) {
>  		printf("Kernel command line: %s\n", img_data.kcmdline);
> -		len +=3D strlen(img_data.kcmdline);
> +		len +=3D strlen(img_data.kcmdline) + 1; /* Extra space character neede=
d */
>  	}
>=20=20
>  	if (*img_data.kcmdline_extra) {
> @@ -299,28 +299,28 @@ int android_image_get_kernel(const void *hdr,
>=20=20
>  	char *bootargs =3D env_get("bootargs");
>  	if (bootargs)
> -		len +=3D strlen(bootargs);
> +		len +=3D strlen(bootargs) + 1; /* Extra space character needed */

In some cases, we will allocate for an extra space character when this
is not needed.

For example, with:
* bootargs =3D "b"
* kcmdline =3D NULL
* kcmdline_extra =3D NULL

We will allocate strlen("b") + 1 + 1. But we only need to allocate
strlen("b") + 1.

Another example:
* bootargs =3D "b"
* kcmdline =3D "k"
* kcmdline_extra =3D NULL

Will allocate strlen("b") + 1 + strlen("k") + 1 + 1. But we only need:
strlen("b") + 1 + strlen("k") + 1.

How about we count the amount of elements that are not NULL to compute
the amount of spaces:
* 0 -> 0 space
* 1 -> 0 space
* 2 -> 1 space
* 3 -> 2 spaces

>=20=20
> -	char *newbootargs =3D malloc(len + 2);
> +	char *newbootargs =3D malloc(len + 1); /* +1 for the '\0' */
>  	if (!newbootargs) {
>  		puts("Error: malloc in android_image_get_kernel failed!\n");
>  		return -ENOMEM;
>  	}
> -	*newbootargs =3D '\0';
> +	*newbootargs =3D '\0'; /* set to NULL in case no components below are p=
resent */

The comment should state Null, not NULL. NULL is the pointer and Null is
the \0 character.

>=20=20
>  	if (bootargs) {
>  		strcpy(newbootargs, bootargs);
>  		strcat(newbootargs, " ");

A similar thing can be stated here. Sometimes, we add spaces which are
not needed.

Can we rework this a little to only add what is needed?

>  	}
>=20=20
> -	if (*img_data.kcmdline)
> +	if (*img_data.kcmdline) {
>  		strcat(newbootargs, img_data.kcmdline);
> -
> -	if (*img_data.kcmdline_extra) {
>  		strcat(newbootargs, " ");
> -		strcat(newbootargs, img_data.kcmdline_extra);
>  	}
>=20=20
> +	if (*img_data.kcmdline_extra)
> +		strcat(newbootargs, img_data.kcmdline_extra);
> +
>  	env_set("bootargs", newbootargs);
>  	free(newbootargs);
>=20=20
>
> --=20
> 2.34.1
