Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B266DE7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 08:42:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40AE38005B;
	Mon, 16 Dec 2024 09:42:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="M5M4Pmzn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3B2480104; Mon, 16 Dec 2024 09:42:23 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AC3E8003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 09:42:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-432d86a3085so24193055e9.2
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 00:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734338541; x=1734943341;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=f5EnHhRnRUmtMV8cY7REZ8H4dcFNjzrSOqL6c7AQCs0=;
 b=M5M4PmznCm6wbwEL75ei06+gDeyLZHDYTiYSBDp+UU888cF7pHFXX4vEr5PRe2Ue/H
 jZkQLGpv44fCHuEGQX4rxu7TqtDlFEmdqgRx7wtq+IrwYFonNZIv1H+c67jrRgJAKG0j
 GRL4M6rcAeDYH10YQk5CLFg2OicQrBvUAw0hfEoOMvFDlMS0uGXoWJPyFN9/46zOMe99
 tOnuvi6wQGTLMlueFYfgE5T4L0oI0W5o04bRfj7odlbi1RUcKfWr7b+FTL+oF2ECpahw
 mQtjH8FpucbTIsL4M3xuO0xyz7aaIVX8glW3BLApXAbSBwJlIfZDALg4/J4iuo5r3cXj
 Iz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734338541; x=1734943341;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f5EnHhRnRUmtMV8cY7REZ8H4dcFNjzrSOqL6c7AQCs0=;
 b=ZydbWMFwpY+pC/kvv0AaNgj5Sna+JnPkhjq4HPxwPRKSlmHSyhxVNJ6aiz297E4O8t
 UtamiR8YRNhnPnpVZvKtZiwzM8UZgAJoqM3XK5BKFs8Uk45LtcBcEJsiwqwSJ/LRn55K
 O5Sd+cvXTBpykuZ3u89yFrhyeDgCQd2Q9DT4ABfMK0a7KPjqQRYfGrpWPcf8WL8hWIOe
 pepdDw85KposS/EwsgIfN+zHqebNh1fBsi/9kDiccobbLnaUA4GVyOveGppYxZLzEzwp
 ugUWOY/x52v/+rfH/Q/yQ1x/D8s6Fyz5EYq7Re0Bhs4Pt74Ea0e5GHu60hNlONkb0x+t
 IgtA==
X-Gm-Message-State: AOJu0YyE0LxQIA8k7hdC+efKsUcnQDmfygwUOMe1sHxDgtnekybXCT2z
 +GoR/74yhXy5Rnzs81KSkqBDaGWo7esOGo9WBbq3DatdVI2Y9W9V0Zub9W7+oIw=
X-Gm-Gg: ASbGncvV1zh4AleyAwrjgw3kCuaL0YIxfNdSD5ZM+z4x7L8MfvwKytnR45pAH3OYp2f
 +HEEazPgamFPqR0yF8/yYyTiO6r183o3BCBIpXxeJayMgstRFqn6dTeAPz5XA+ea/O+NJVgUr0P
 rq+0ObCv6ueZMG2XtQtDtJ5VBJDPAL1yHcMQRZPlUQcO0LeHCWP3S5RdRIRkqUTYQ7MjZN5v/qL
 xUsTdvsOQKGXTCUQECJz+SirDPHUJ6hSUmstvECrpIfVb5pb+4T07uEXRI/ycXFmw==
X-Google-Smtp-Source: AGHT+IHT4tZueJN0VORsScK9qRFkmRA/VAMuZEXy2ajPQ+ZDE1qOnrim53lIqfmrnUIbHD3J74+/XA==
X-Received: by 2002:a05:600c:1c07:b0:434:ff25:1988 with SMTP id
 5b1f17b1804b1-4362aaa9632mr87747075e9.32.1734338541031; 
 Mon, 16 Dec 2024 00:42:21 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80120f9sm7483658f8f.15.2024.12.16.00.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 00:42:20 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nicolas Belin <nbelin@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Safae Ouajih <souajih@baylibre.com>, Ahmad
 Draidi <ar2000jp@gmail.com>
Cc: u-boot@lists.denx.de, Nicolas Belin <nbelin@baylibre.com>
Subject: Re: [PATCH 4/4] boot: android: reorder the length calculation order
In-Reply-To: <20241211-fix-bootargs-concatenation-v1-4-c6752bcb9dde@baylibre.com>
References: <20241211-fix-bootargs-concatenation-v1-0-c6752bcb9dde@baylibre.com>
 <20241211-fix-bootargs-concatenation-v1-4-c6752bcb9dde@baylibre.com>
Date: Mon, 16 Dec 2024 09:42:19 +0100
Message-ID: <87a5cwxbmc.fsf@baylibre.com>
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

> Keep the same order (bootargs then kcmdline then kcmdline_extra)
> for both the length calculation and the string concatenation steps.
>
> Signed-off-by: Nicolas Belin <nbelin@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  boot/image-android.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/boot/image-android.c b/boot/image-android.c
> index ed72a5c30424a453c1800bc61edbe8f33b31b341..a76f028090d0470842bbf559b=
638175949c527f0 100644
> --- a/boot/image-android.c
> +++ b/boot/image-android.c
> @@ -287,6 +287,11 @@ int android_image_get_kernel(const void *hdr,
>  	       kernel_addr, DIV_ROUND_UP(img_data.kernel_size, 1024));
>=20=20
>  	int len =3D 0;
> +	char *bootargs =3D env_get("bootargs");
> +
> +	if (bootargs)
> +		len +=3D strlen(bootargs) + 1; /* Extra space character needed */
> +
>  	if (*img_data.kcmdline) {
>  		printf("Kernel command line: %s\n", img_data.kcmdline);
>  		len +=3D strlen(img_data.kcmdline) + 1; /* Extra space character neede=
d */
> @@ -297,10 +302,6 @@ int android_image_get_kernel(const void *hdr,
>  		len +=3D strlen(img_data.kcmdline_extra);
>  	}
>=20=20
> -	char *bootargs =3D env_get("bootargs");
> -	if (bootargs)
> -		len +=3D strlen(bootargs) + 1; /* Extra space character needed */
> -
>  	char *newbootargs =3D malloc(len + 1); /* +1 for the '\0' */
>  	if (!newbootargs) {
>  		puts("Error: malloc in android_image_get_kernel failed!\n");
>
> --=20
> 2.34.1
