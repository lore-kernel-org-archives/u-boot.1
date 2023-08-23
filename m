Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544C4EE49A0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 08:09:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB9BA80812;
	Wed, 23 Aug 2023 10:09:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="380eydpf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39353807C4; Wed, 23 Aug 2023 10:09:07 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD57A8641F
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 10:09:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fee843b44cso33879945e9.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 01:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692778144; x=1693382944; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w/VvDQnvOgkYHJl1s85s4CzkV41paP6OYeL567IKNMk=;
 b=380eydpf7W7fZ5FAH5GoknHODpI9gPCO6wU6kIqxKc70o8Ac3dJrhSoBKTE1ZJG2WB
 kZYMueCsfdmuHrLc3WJ6Ad9jEzG3PGQwe3lcUmGNxARZd6zGRzlVvITr4FKisz1wszqN
 hC+Kxz0wYcrjscveMTBTj9woV4MtnFIcvnAPNqtbXO1Zcbm2c8K4JsdJv2Z+SW9rsSy7
 Dxvq/A39Tj7BrHQTAEs5IIN0RFF4m3mg0hx9yTuvpBPT17RvntuMunTizyY1y1vUA62b
 mBOJSQ1cqyLL1i6mQZkZ1Nv2KHkhFFmL+dBPgf+E9crefq69b9SBqvZkWtwLbUlgFBx5
 VFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692778144; x=1693382944;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w/VvDQnvOgkYHJl1s85s4CzkV41paP6OYeL567IKNMk=;
 b=JX9pLTAvufJfK0k6Bs1nTELtDV6usy8xTZHoAZ3xNlmj00nw6VM0OeyL4khX8tbmj9
 HvMTJI0iEYpDfOXL+7pRwmlf9w31dDc3whJQ2+qqE5bzSptLyHzQ4m4GdRPdhdyoYmjt
 aSsTLutrnM9MIO9tylAUZTNHMOCqdkgxa5N096+PR+FglIGKSJNqVxvkJcyT+GOYu4UK
 mBLvl54TRLtlSk2u3z3Qe9a6CpfMuijcjVpucSQTS9WvlDluDvxAoUglXHLm71ioSXWC
 WHCVmh1zqT6hVuQjeoNkWVFD2aZoZGM1lfRzpVzpTkWvkNPReNBN+LnRfUy6CDFwoTwu
 TJPw==
X-Gm-Message-State: AOJu0YzFhNH6mOFY21fwofjsu0fEwj8NqUj3sPCBRBBxYXRu1LmBFaP5
 XgOb36eIDOyqqYM+NMnJPIOEGQ==
X-Google-Smtp-Source: AGHT+IFw+sF+FtMy/YtJpG4Ca+cWpikEgwk+ytBC9idGMeoG0jPCZYxLyfms0dW28rfGw5vElfDJSA==
X-Received: by 2002:a05:600c:b53:b0:3f9:c82e:9d87 with SMTP id
 k19-20020a05600c0b5300b003f9c82e9d87mr9164395wmr.13.1692778144036; 
 Wed, 23 Aug 2023 01:09:04 -0700 (PDT)
Received: from localhost ([2a01:cb19:8704:be00:4f55:bd9d:611a:6c8e])
 by smtp.gmail.com with ESMTPSA id
 u4-20020a7bc044000000b003fe2bea77ccsm17978254wmc.5.2023.08.23.01.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 01:09:03 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>, Tom Rini
 <trini@konsulko.com>
Cc: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Jan
 Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>
Subject: Re: [PATCH V4 5/8] arm: dts: k3-am625-sk-binman: Add labels for
 unsigned binary
In-Reply-To: <20230822184135.2328409-6-nm@ti.com>
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-6-nm@ti.com>
Date: Wed, 23 Aug 2023 10:09:03 +0200
Message-ID: <87o7iyfae8.fsf@baylibre.com>
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

On mar., ao=C3=BBt 22, 2023 at 13:41, Nishanth Menon <nm@ti.com> wrote:

> Add labels for unsigned binary to permit over-ride.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> Cc: Simon Glass <sjg@chromium.org>
>
> Changes since V3: None
>
> V3: https://lore.kernel.org/all/20230815164440.2713726-2-nm@ti.com/
> V2: https://lore.kernel.org/u-boot/20230727234446.3651836-2-nm@ti.com/
> V1: https://lore.kernel.org/all/20230725185253.2123433-3-nm@ti.com/
>  arch/arm/dts/k3-am625-sk-binman.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625=
-sk-binman.dtsi
> index a35d6418c25f..41277bf4bfdb 100644
> --- a/arch/arm/dts/k3-am625-sk-binman.dtsi
> +++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
> @@ -389,7 +389,7 @@
>  					type =3D "flat_dt";
>  					arch =3D "arm";
>  					compression =3D "none";
> -					blob {
> +					spl_am625_sk_dtb_unsigned: blob {
>  						filename =3D SPL_AM625_SK_DTB;
>  					};
>  				};
> @@ -438,7 +438,7 @@
>  					type =3D "flat_dt";
>  					arch =3D "arm";
>  					compression =3D "none";
> -					blob {
> +					am625_sk_dtb_unsigned: blob {
>  						filename =3D AM625_SK_DTB;
>  					};
>  					hash {
> --=20
> 2.40.0
