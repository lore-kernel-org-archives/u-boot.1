Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCE5C5320E
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 13:15:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDDDF88C9E;
	Mon, 19 Aug 2024 15:15:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="R87Lykqh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BCE688C9E; Mon, 19 Aug 2024 15:15:44 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E51FD88ADB
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 15:15:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42816ca797fso35124325e9.2
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 06:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724073341; x=1724678141;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eIPXxx/3+a1yKGv6XizAYoSDt2RIEDztn62s+FPoekA=;
 b=R87LykqhoawWznc5ng2emQoJBo344j5h1EV6ZzjjuFktmNvVuF1x+t/rTrkCRMdfGp
 kwDf0QuStAVU7iXHZn6zZq2wZmVpAImjkc44dzU+wBNemo/Z5dVy4UQ0UT0arR8oncn9
 ohVWa/6w2VaWlrPFCHuYliZummeilRdF96jL0muwP1rhcz1SNhu9rUiZsJ89gPe8O5Mm
 cQEhaG6b/TKs5DUPdxIshFlPj8smdvWDYqPM1v2nAiBNVWQ05FYHrmnkMHUUKXjrYNnz
 Qkd3KkhvNj4+W9mCzdY/unSfx4glzPpmdKzwfX6CfxEJaaLyPTRyf7Oat2TFxuk9En9b
 rtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724073341; x=1724678141;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eIPXxx/3+a1yKGv6XizAYoSDt2RIEDztn62s+FPoekA=;
 b=MW2Pc0el6wj3khlbKMvoi4LJ8rIm4HI2XsQahfbmUTz3Ha56M5nmTH/tO9XlgUrQYH
 wtad8zYSQbRx3KIWpkljHmYSte+3mEbh0nRbsctYKxH6zdCnUzyhMeKeSYAc760GP3lL
 8D2NW0h914lDJRhqsCdSYT8gUhON+EFNXz3PK0IyJVnzkGBIvGXCTqU52xBgXD9RLGtI
 Tu7cV3JUIydbCuDtPgntlGvbU1FJsmylx7+Vx0i/I+ZGHU8jOdW27ItLeKObhqx9oIOU
 Mny+f5+1zgdAdhJWiwVa4sN3tkgLt0BQ2Puw0mA9KtXLHmtPnOs+ocjkVA1MkC8ZGql0
 MNzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFoUNra00vAYzIXUPHLgMydGL51uCihi4MqDFaQ6N3JD3yelAtwPakSYQ/5mt8C5BuaeB2JW80QJIjGNtGimv8P/2ZMA==
X-Gm-Message-State: AOJu0YyrUKw7GFBWFAExzRrzCqYlYgsAMN2hwPx4K2v8TbBvvkQDd2z3
 DQlWvAFgqYqmRVvE2y9eqN9gYcygm1ZmLMDUnZR+E5P1BcDbLyIyqOMtoEmpikg=
X-Google-Smtp-Source: AGHT+IGrle1uNHEQcWbsKf0QbjpaVmKeUBSYltkc7gLKjG8khbbZR+3wpXnepC+byfPA45mrN0UXwA==
X-Received: by 2002:a05:600c:5125:b0:426:6551:3174 with SMTP id
 5b1f17b1804b1-429ed7e41admr91542635e9.29.1724073340543; 
 Mon, 19 Aug 2024 06:15:40 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ded180dcsm164316815e9.4.2024.08.19.06.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 06:15:39 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Linus Walleij
 <linus.walleij@linaro.org>, Stephan Gerhold <stephan@gerhold.net>, Tom
 Rini <trini@konsulko.com>
Subject: Re: [PATCH] usb: gadget: ux500: Do not redefine ops if
 CONFIG_USB_MUSB_HOST set
In-Reply-To: <20240818200425.89045-1-marek.vasut+renesas@mailbox.org>
References: <20240818200425.89045-1-marek.vasut+renesas@mailbox.org>
Date: Mon, 19 Aug 2024 15:15:38 +0200
Message-ID: <87ed6kwt51.fsf@baylibre.com>
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

Hi Marek,

Thank you for the patch.

On dim., ao=C3=BBt 18, 2024 at 22:04, Marek Vasut <marek.vasut+renesas@mail=
box.org> wrote:

> In case CONFIG_USB_MUSB_HOST is set, the ux500_gadget_ops get overridden
> to musb_usb_ops . Simply set the ops one way or the other depending on
> whether CONFIG_USB_MUSB_HOST is set or not.
>
> Fixes: ac4bf5d48a9e ("usb: gadget: ux500: Convert interrupt handling to u=
sb_gadget_generic_ops")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/usb/musb-new/ux500.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/usb/musb-new/ux500.c b/drivers/usb/musb-new/ux500.c
> index 89dd75b7d05..be0085f403d 100644
> --- a/drivers/usb/musb-new/ux500.c
> +++ b/drivers/usb/musb-new/ux500.c
> @@ -169,16 +169,14 @@ U_BOOT_DRIVER(ux500_musb) =3D {
>  	.name		=3D "ux500-musb",
>  #ifdef CONFIG_USB_MUSB_HOST
>  	.id		=3D UCLASS_USB,
> +	.ops		=3D &musb_usb_ops,
>  #else
>  	.id		=3D UCLASS_USB_GADGET_GENERIC,
> +	.ops		=3D &ux500_gadget_ops,
>  #endif
>  	.of_match	=3D ux500_musb_ids,
> -	.ops		=3D &ux500_gadget_ops,
>  	.probe		=3D ux500_musb_probe,
>  	.remove		=3D ux500_musb_remove,
> -#ifdef CONFIG_USB_MUSB_HOST
> -	.ops		=3D &musb_usb_ops,
> -#endif
>  	.plat_auto	=3D sizeof(struct usb_plat),
>  	.priv_auto	=3D sizeof(struct ux500_glue),
>  };
> --=20
> 2.43.0
