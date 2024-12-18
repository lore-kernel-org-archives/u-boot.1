Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8730E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 10:49:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4482680274;
	Wed, 18 Dec 2024 11:49:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cCq+d1Rz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5907C802EF; Wed, 18 Dec 2024 11:49:53 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 278EC80239
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 11:49:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so39413815e9.0
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 02:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734518990; x=1735123790;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4xBNlvgqUGEApB87kVZ6flIifTlPgshkT+U2kdzhmAo=;
 b=cCq+d1RzLLgvsfdmcuus92j6Dyn5sdsEcv87ix9fSmNPyOPUcP1zttjicWNHl78wfN
 +dCmUWGvpMRuP51hGDK4y8uE5qffB0EC8pj1TQc9sFAUyasbrZhWJ9GOM901xm18iPnk
 RcywXskvA8piUFpR4pjTpckzWDY+S27fUARl91F2aQzB6Np42eXyWxdDSaJ5C1GJwuR6
 ElJU01FSDfJnTY6Y0T2YOpwKglVuBvrXs3Ko4fOcwhcv61iV76erOiLpCJOokpuCqn4T
 LMWQfNhx59DEiUHpve0/0VRx70JneQiNNlmvJId23DCrHmo52x1L25k56W2DstEgyHRR
 fH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734518990; x=1735123790;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4xBNlvgqUGEApB87kVZ6flIifTlPgshkT+U2kdzhmAo=;
 b=UnhtP/2MI7r2N1fYYEYCidBAlp5TK+2ULM0W3fpVW7W+jvEUz0zNOlSrTWLMIy+DCx
 qQOW4gPf8558jfEi32QtMMU213/vWmMG93eV5Wdf54AOGoWPUjA7Grxle4WvJimGUGAZ
 uE3bzsgq7aDVNeJibaEKIZjFxOZ8TIm+f5S8RU3w/UmYmYxJLME1OxeDoy55jUAzbHbI
 kivWA+SNXzcycvF8rRP0JFYKAV3OlZFbo4ST1S8V70o0/Fn0kIROdQ76VLm8qerJQ0Fx
 eJ4E26d7zjRm+A6HlEyrkz2U55Wv/jjiz5xFm+OHZvmU8Y/wvsipa8pCIACHpD08PHR7
 7NeQ==
X-Gm-Message-State: AOJu0YzdSL8shXSh4g54mfHT5r5wiSp46FFy3/gukKMZHmAoLvB7TBEN
 h5JpKNO/FwYJ+c5TUo/yVxdWFPKipUZVmP6H97dsoBqAgvYn1WltEOJ6wNespJg=
X-Gm-Gg: ASbGnctWASdf6ruNbCkoJwcKwxC15xrRAHjYRFlIz1+0zI9+h/BGbaRaFO/I83jQ/Ri
 jofTO8xSnQlGyU73aasYmrv/l4QDZ5DFXayLfMyzVsD5Blbb7CQND1GJFRZE5DhnQlW2XRVugiO
 HeOCerL5nBgsHrawY5oTqK9iQB3G8D4x+9SC+QwVcKnNsDpiZaT3vpHpZ4MifPaappu/gJRYp+d
 AOg45ZiAvZZzr9jSkHs5rYSYnK1d7bYagSsiVVKZwKxVZ/Y/eCCpWRPC+jrrDLO7w==
X-Google-Smtp-Source: AGHT+IEALmazRsDIf6XqixTqIB6fDwam1TKvyGBOPNUggTiVxfsVeuDkq3/h0HZXMdlJ7K7JCXXD7g==
X-Received: by 2002:a05:6000:4b1b:b0:388:c75d:be97 with SMTP id
 ffacd0b85a97d-388e4d6a547mr2315097f8f.11.1734518990449; 
 Wed, 18 Dec 2024 02:49:50 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656afc217sm16441515e9.8.2024.12.18.02.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 02:49:50 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nicolas Belin <nbelin@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Safae Ouajih <souajih@baylibre.com>, Ahmad
 Draidi <ar2000jp@gmail.com>
Cc: u-boot@lists.denx.de, Nicolas Belin <nbelin@baylibre.com>
Subject: Re: [PATCH v2 3/3] boot: android: rework bootargs concatenation
In-Reply-To: <20241217-fix-bootargs-concatenation-v2-3-b2fd7cf4e130@baylibre.com>
References: <20241217-fix-bootargs-concatenation-v2-0-b2fd7cf4e130@baylibre.com>
 <20241217-fix-bootargs-concatenation-v2-3-b2fd7cf4e130@baylibre.com>
Date: Wed, 18 Dec 2024 11:49:49 +0100
Message-ID: <87pllpw9iq.fsf@baylibre.com>
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

On mar., d=C3=A9c. 17, 2024 at 14:29, Nicolas Belin <nbelin@baylibre.com> w=
rote:

> Rework the bootargs concatenation allocating more accurately
> the length that is needed.
> Do not forget an extra byte for the null termination byte as,
> in some cases, the allocation was 1 byte short.
>
> Fixes: 86f4695b ("image: Fix Android boot image support")
> Signed-off-by: Nicolas Belin <nbelin@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  boot/image-android.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
>
> diff --git a/boot/image-android.c b/boot/image-android.c
> index 362a5c7435a3a8bcf7b674b96e31069a91a892b5..61ac312db7ad9ba6c55727469=
dd4ded61824c67c 100644
> --- a/boot/image-android.c
> +++ b/boot/image-android.c
> @@ -287,37 +287,40 @@ int android_image_get_kernel(const void *hdr,
>  	       kernel_addr, DIV_ROUND_UP(img_data.kernel_size, 1024));
>=20=20
>  	int len =3D 0;
> +	char *bootargs =3D env_get("bootargs");
> +
> +	if (bootargs)
> +		len +=3D strlen(bootargs);
> +
>  	if (*img_data.kcmdline) {
>  		printf("Kernel command line: %s\n", img_data.kcmdline);
> -		len +=3D strlen(img_data.kcmdline);
> +		len +=3D strlen(img_data.kcmdline) + (len ? 1 : 0); /* +1 for extra sp=
ace */
>  	}
>=20=20
>  	if (*img_data.kcmdline_extra) {
>  		printf("Kernel extra command line: %s\n", img_data.kcmdline_extra);
> -		len +=3D strlen(img_data.kcmdline_extra);
> +		len +=3D strlen(img_data.kcmdline_extra) + (len ? 1 : 0); /* +1 for ex=
tra space */
>  	}
>=20=20
> -	char *bootargs =3D env_get("bootargs");
> -	if (bootargs)
> -		len +=3D strlen(bootargs);
> -
> -	char *newbootargs =3D malloc(len + 2);
> +	char *newbootargs =3D malloc(len + 1); /* +1 for the '\0' */
>  	if (!newbootargs) {
>  		puts("Error: malloc in android_image_get_kernel failed!\n");
>  		return -ENOMEM;
>  	}
> -	*newbootargs =3D '\0';
> +	*newbootargs =3D '\0'; /* set to Null in case no components below are p=
resent */
>=20=20
> -	if (bootargs) {
> +	if (bootargs)
>  		strcpy(newbootargs, bootargs);
> -		strcat(newbootargs, " ");
> -	}
>=20=20
> -	if (*img_data.kcmdline)
> +	if (*img_data.kcmdline) {
> +		if (*newbootargs) /* If there is something in newbootargs, a space is =
needed */
> +			strcat(newbootargs, " ");
>  		strcat(newbootargs, img_data.kcmdline);
> +	}
>=20=20
>  	if (*img_data.kcmdline_extra) {
> -		strcat(newbootargs, " ");
> +		if (*newbootargs) /* If there is something in newbootargs, a space is =
needed */
> +			strcat(newbootargs, " ");
>  		strcat(newbootargs, img_data.kcmdline_extra);
>  	}
>=20=20
>
> --=20
> 2.34.1
