Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0180BC3064D
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:35:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FF928858C;
	Thu, 27 Jun 2024 13:35:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kjcM5Hsw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A477E885A8; Thu, 27 Jun 2024 13:35:13 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C61858858C
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ec6796f5a0so3393751fa.2
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 04:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719488111; x=1720092911; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=utf5+9G6LggobQY0sGGPIQtfxU7R/CFMMbFMfWer48k=;
 b=kjcM5HswicUhw0pvdSXCBJuf9vXdkkDeMlUR6/aKphZbbMqkHi+y+lbAJxPCaLgR6g
 WJMSqLgC6IVfpLdoeAMLLacFee009rW7VgVjcA14n2Ojeh9xrXN0eQoq9Xy9/gvalDX+
 wur5LvZ3EWspNH01Xbrb4SMqzP52ApChmH7IlIYm/YR7TSDkec25Nf9c++NOAgxyVeee
 E4zddmJJTmsx7tsdL0OJYrGtiy0ruWEur/fKgU/RqKqgVeUUW8bEOP7+Bhz4pVJc0lZ4
 GhhvOAbu6Ng0jqPCwYq49dhqMyoABTekkyY6OuSKyMGZKaNd55LSTpFoNI3ahBE/j6sC
 GLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719488111; x=1720092911;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=utf5+9G6LggobQY0sGGPIQtfxU7R/CFMMbFMfWer48k=;
 b=CEKdx7neHzNnHtlr5x97viuAnR9T7dDiTRnzlWa8vJ6cwjv9tM7stIzv4O06XxPC3p
 dwwuDVbPU8uJBprBHWH74yzAqjK0w2JP8sB/Id0FAJ2vmsOjbCezgoYKvwVg4VNzY636
 FZ7Bb1K49G2k8Rx8bDtDLGKkLZ8iOiWa9COZnpmY3BrCCT9FOwrhFOehRngA4gg1IJnK
 oSTecjD9RFKLqAnF0iQkSqshMOGy+O57jCVgJkag0OY9NJdomRJS4WtfiHf0vI62pn1s
 nxahuhjbIkE3hGyusm4F4iC+zj5DXJz/tb+HA4/68K9ks/aASA19SYbD1RJ+Wp8BqXSl
 kNZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJPDt55ov98frdaW5gB7PdAaKT6Qidkd3UNxCIU1Nh8luYcHKNvncCgmk6Z9QOPMlc729UebFzeQorM3quC4UcRQ1tag==
X-Gm-Message-State: AOJu0YzGJeBhljJA1c9VsBFvdrFZT8e5fUajsHLI9e0TowA/eWUkIaln
 56PWHNMsZvOmnZOQcYuVX8j0WEL+JTjQrMgoAggepC0Pr0E4ZkOjL43FNjj7cU7EqH8+KVF7+ip
 zt/HEe4vn4erRPxzQYwaq5wTKFgk=
X-Google-Smtp-Source: AGHT+IE1TeJ/G2Zm+eomcQd83LuALUkhfG7srhPjolLAWbjae291VTFLU/agCjrRiR1wxGXfE8xxZPZFjy/VmMOQmWo=
X-Received: by 2002:a2e:bc08:0:b0:2ec:6196:55e4 with SMTP id
 38308e7fff4ca-2ec61965794mr84903841fa.2.1719488110813; Thu, 27 Jun 2024
 04:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240627112232.99507-1-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240627112232.99507-1-mikhail.kshevetskiy@iopsys.eu>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 27 Jun 2024 08:34:59 -0300
Message-ID: <CAOMZO5CcOA6-w8QB3radO4NXUYNfWNEzs16ACf1yvvce6b2s-Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: soft_spi: fix miso gpio property name
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Fabio Estevam <festevam@denx.de>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 William Zhang <william.zhang@broadcom.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Jun 27, 2024 at 8:31=E2=80=AFAM Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/spi/soft_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/soft_spi.c b/drivers/spi/soft_spi.c
> index 0fa14339bdc..3fe62818a44 100644
> --- a/drivers/spi/soft_spi.c
> +++ b/drivers/spi/soft_spi.c
> @@ -272,7 +272,7 @@ static int soft_spi_probe(struct udevice *dev)
>         ret =3D gpio_request_by_name(dev, "gpio-miso", 0, &plat->miso,
>                                    GPIOD_IS_IN);
>         if (ret)
> -               ret =3D gpio_request_by_name(dev, "gpio-miso", 0, &plat->=
miso,
> +               ret =3D gpio_request_by_name(dev, "miso-gpios", 0, &plat-=
>miso,

We should support the deprecated 'gpio-miso' property and the
preferred 'miso-gpios' one.

The same applies for  gpio-sck and gpio-mosi.


>                                            GPIOD_IS_IN);
>         if (ret)
>                 plat->flags |=3D SPI_MASTER_NO_RX;
> --
> 2.43.0
>
