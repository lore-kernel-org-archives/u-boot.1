Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55124E7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 07:58:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4A1F80104;
	Mon, 16 Dec 2024 08:58:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DXnDn5tY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1C9D801BE; Mon, 16 Dec 2024 08:58:47 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0DAB8005B
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 08:58:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-385e27c75f4so2937895f8f.2
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 23:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734335924; x=1734940724;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Nt+RhxOmeHyYGUEj/khfCL1R3RBMRDGLziNBOqtyj0M=;
 b=DXnDn5tY+ERZlutyTmIsflTpLiKQpK7fyVceDjzMg3kxZcH7jZTR3BQxUZlbH+ksLt
 RyhhQ9ll/A9jybsZegcg8TysQSFf3uD88aib7LN8qlZFoZ80do6KJzN2xV2ACAUN3U7l
 yD3E/uwvMXgUQTFNA23odfh8smJhkOGD6m1BlvdXjlxHu/3JOGx6c+u/5BfK9WEiHqwu
 oZP8jb6XfvFZhabGYRQxJPOtSpA2K8MvdnmEmYavC9kTO7LM5wdOVbDsnYsFsPyLVvz+
 oDsqQJQ/iF37tSXbAk7IFUIMMPMKup0Lzux3dDEhsicf5B+ssnxKJFRrkzOY7TMAaHe3
 HCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734335924; x=1734940724;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nt+RhxOmeHyYGUEj/khfCL1R3RBMRDGLziNBOqtyj0M=;
 b=HJa99a8G/yJL/a/WmMVT5+WqT/Q987VHeTbPlz1D38nIxz/i2+U+icYOFJbghvjrAv
 qLVVlLiKjVTlPGobu2xTWWjebsXGtrn0wrQk7OxmqSXCqxw8Wen0Zbw6Sn7FymQVJddd
 DPquOLtYAqa8iI5ZKdCSK5e9KhaFgkG3SKFkhH7ZCxHnL2gQ7dmwIUFX5UL3T5+gkxhl
 T4fjF9auAI8RPHidCq3mZ7zuvCTAUUlPOCQ1TwzN+LyVvM5D8wA71sXINVW7om+0BwV+
 nMXXWlsHleRCs4bSGJ9G+I2VdRySV3LTsVGxhh+IRjPf2WzlhbT0SuldVG9crczCAd5O
 Oyww==
X-Gm-Message-State: AOJu0Yz7yZx9PF1Chgsfk7oQCCb/T/LyXoygEyVM+CxaUGTaf/4xuRcs
 5RFjW3CJ7Vv1c6Ec1zQjhnOdrfeEPo4zd6iJuVRyuxwW5qjga09+78AaHIyPBCpr8CNC5vAjNWq
 F
X-Gm-Gg: ASbGncugcv7pb5W0l3tzJoxvn4cmYVp9yN+sIZUd/OPEgm5MGGJkb7XQy+FbyJ/B3qq
 oLb3Ute7ytHamW08QSOHnFOgPCxXj4Zq2cIPk6LsP8j2LnChAtc4mMQw0AppRYRTHt1gKu6etzG
 eaOfcKccEoj/r19NhBeDpG5QdCF2sI00m0cKWj7EYrC0bCoyw1udBtdN3YAio/UbKGtMTt+kZsg
 1OJRgUUahgv8/5djbS4kZQ0w5OHTuoi8vUwN6VOutU/QngYBqFeajIIDWSUmcmtcw==
X-Google-Smtp-Source: AGHT+IHfTyiz7a6kfaAJ0/6TKdkNrPYp49r+mhNY0OEQr3JNAWwf6VsXnE2cxsAKsXRS/RsBxoHZEg==
X-Received: by 2002:a5d:64af:0:b0:385:fb2c:6034 with SMTP id
 ffacd0b85a97d-3888e0b9e49mr9398811f8f.47.1734335924059; 
 Sun, 15 Dec 2024 23:58:44 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c804a34fsm7457658f8f.76.2024.12.15.23.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 23:58:43 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nicolas Belin <nbelin@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Safae Ouajih <souajih@baylibre.com>, Ahmad
 Draidi <ar2000jp@gmail.com>
Cc: u-boot@lists.denx.de, Nicolas Belin <nbelin@baylibre.com>
Subject: Re: [PATCH 1/4] boot: android: fix extra command line support
In-Reply-To: <20241211-fix-bootargs-concatenation-v1-1-c6752bcb9dde@baylibre.com>
References: <20241211-fix-bootargs-concatenation-v1-0-c6752bcb9dde@baylibre.com>
 <20241211-fix-bootargs-concatenation-v1-1-c6752bcb9dde@baylibre.com>
Date: Mon, 16 Dec 2024 08:58:42 +0100
Message-ID: <87ikrkxdn1.fsf@baylibre.com>
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

> Check that the value at the address kcmdline_extra is not 0
> instead of checking the address value itself keeping it
> consistent with what is done for kcmdline.
>
> Fixes: b36b227b ("android: boot: support extra command line")
> Signed-off-by: Nicolas Belin <nbelin@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  boot/image-android.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/boot/image-android.c b/boot/image-android.c
> index cd01278f211d63262f2bdad7aa1176e2c1bbfedd..57158280b41c6552c82838e21=
384d925d5f7cde4 100644
> --- a/boot/image-android.c
> +++ b/boot/image-android.c
> @@ -292,7 +292,7 @@ int android_image_get_kernel(const void *hdr,
>  		len +=3D strlen(img_data.kcmdline);
>  	}
>=20=20
> -	if (img_data.kcmdline_extra) {
> +	if (*img_data.kcmdline_extra) {
>  		printf("Kernel extra command line: %s\n", img_data.kcmdline_extra);
>  		len +=3D strlen(img_data.kcmdline_extra);
>  	}
> @@ -316,7 +316,7 @@ int android_image_get_kernel(const void *hdr,
>  	if (*img_data.kcmdline)
>  		strcat(newbootargs, img_data.kcmdline);
>=20=20
> -	if (img_data.kcmdline_extra) {
> +	if (*img_data.kcmdline_extra) {
>  		strcat(newbootargs, " ");
>  		strcat(newbootargs, img_data.kcmdline_extra);
>  	}
>
> --=20
> 2.34.1
