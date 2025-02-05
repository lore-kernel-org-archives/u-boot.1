Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F71C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 17:13:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A335805E7;
	Wed,  5 Feb 2025 18:13:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=tidylabs.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=tidylabs.net header.i=@tidylabs.net header.b="TS4C4ebQ";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="ew/v0gMp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F218E806FE; Wed,  5 Feb 2025 18:13:48 +0100 (CET)
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0394380104
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 18:13:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=tidylabs.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=justin@tidylabs.net
DKIM-Signature: a=rsa-sha256;
 b=TS4C4ebQOLkyzM1GSjMF+ElxD8eEzebjMkQ+6i+9VNFSJgHD+w/SniHTYn4JvMUdAHrQlZ7xa+lDkjcVqlerNaLvv/tL/SbkQQALVgeC38ky4VF/qv2pWoIWnksiyy+RF0U1Xo0UMPzAQ4kecprWFELwjEMPw3fsSQcjvkUPF+ZHryS7zgvKeSJDtRi0f2ltRypVo3HO2ZkqagNjSebMw6eRLfPN56/8lDho8pjvGK238AR0KlyFeSvG7eG/7XRfdzrUzKZJkZnUhpWtuC6S/pYR65qm/rLRRpPIt937dCbU/RxhQwNq2re8SXCEC9VUve9g41K/6wg98+JpfuPlQA==;
 s=purelymail2; d=tidylabs.net; v=1;
 bh=P5/PznFKPpkGP8vT5HvuraoZXs9G+F4U7XRTjeoBah8=;
 h=Received:Received:Received:Received:From:Date:Subject:To; 
DKIM-Signature: a=rsa-sha256;
 b=ew/v0gMpgb42If46GUk5RvvsjjCw8Ak6lPWptFgFi/FULsrLzRqvc78l8AvqPIcS809syD9kWtFnbFSwzxLkdMlcxT7AAhZoNtU5+M4Z3OtCP313HlpjdsrNcv/xX1tWd1iwE5Qu9stX4uQ1z6zb7u9YtXgGwra8mrN3ulHZfFmWPp755iC2zvxcy5UKN1EMPpA75gufmobOawNd83EXPrFpVXSrFEb5dVLmeaE0Pmfw/Xmi21U51rCM6W5skNCFHrZYI2xkI7yEsq/IKAeCvCnagBRPIA6efy6zVs1u5xdPU5FDq7Sb+mrzIOv8ePvbK/SJH/lWIRxuRDeimRUuuQ==;
 s=purelymail2; d=purelymail.com; v=1;
 bh=P5/PznFKPpkGP8vT5HvuraoZXs9G+F4U7XRTjeoBah8=;
 h=Feedback-ID:Received:Received:Received:Received:From:Date:Subject:To; 
Feedback-ID: 81901:11097:null:purelymail
X-Pm-Original-To: u-boot@lists.denx.de
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1514980608
 for <u-boot@lists.denx.de>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 05 Feb 2025 17:13:41 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2f833af7a09so9552999a91.2
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 09:13:40 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXl21tOlV+pTTHMwgP5ZOzBY9LyGq8i+MKZJOu23JONBc8ekqPGlgGncBBOhzu6D/Z4X/oAlLU=@lists.denx.de
X-Gm-Message-State: AOJu0Yw8fCz2aIufJGhVhMEM6kuDVnchjI8mXtuKr7JVGcxlrdHuNdR0
 5u/Y1pqpw2nyDXHvbbQgV3Bg60L+GV36Ro8qm9qH9CGZfK8zhsMHVhUlpzDc/gAdEIrSN7BIzeX
 wvOq/wxYYz/JhWlMvbf1YEw4SZJE=
X-Google-Smtp-Source: AGHT+IGSr/tNXVZEiA8QDHmnxzVnxMUfq8RjumLvjb16/BXEzf5edyLp2doK93PXg1CGoRpoXp5LfF2UbDSVnKYZ4+4=
X-Received: by 2002:a17:90b:4aca:b0:2ee:3fa7:ef4d with SMTP id
 98e67ed59e1d1-2f9e0834424mr6081063a91.24.1738775620147; Wed, 05 Feb 2025
 09:13:40 -0800 (PST)
Received: from 1064022179695 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Feb 2025 17:13:39 +0000
Received: from 1064022179695 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Feb 2025 17:13:35 +0000
MIME-Version: 1.0 (Mimestream 1.5.0)
References: <20250128213852.465664-1-justin@tidylabs.net>
 <20250128213852.465664-2-justin@tidylabs.net>
 <2214c36a-f23c-4d37-8ec3-2f1049d378ad@cherry.de>
In-Reply-To: <2214c36a-f23c-4d37-8ec3-2f1049d378ad@cherry.de>
From: Justin Klaassen <justin@tidylabs.net>
Date: Wed, 5 Feb 2025 17:13:39 +0000
X-Gmail-Original-Message-ID: <CAK2wXtkn+r0oJcoLUcmNvhbKus9k5BzT=oN-m00yJtNnx4KzeQ@mail.gmail.com>
X-Gm-Features: AWEUYZmpAezMQGtncT1KZ-pSkxarJPw-g5mFS37-CVlJMy8zNbBQq1Sl15hSAUs
Message-ID: <CAK2wXtkn+r0oJcoLUcmNvhbKus9k5BzT=oN-m00yJtNnx4KzeQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] rockchip: io-domain: Add debug logging for
 regulators during probe
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

 Hi Quentin,

On Feb 4, 2025 at 09:16:29, Quentin Schulz <quentin.schulz@cherry.de> wrote=
:

> Hi Justin,
>
> On 1/28/25 10:37 PM, Justin Klaassen wrote:
>
> [You don't often get email from justin@tidylabs.net. Learn why this is
> important at https://aka.ms/LearnAboutSenderIdentification ]
>
>
> Log the value of the regulators during initialization of the IO-domain
>
> driver to aid in debugging GPIO voltage configuration problems.
>
>
> Signed-off-by: Justin Klaassen <justin@tidylabs.net>
>
> ---
>
>
> Changes in v2:
>
> - Made added IO-domain driver logs verbose and consistent
>
>
>   drivers/misc/rockchip-io-domain.c | 7 ++++++-
>
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
>
> diff --git a/drivers/misc/rockchip-io-domain.c
> b/drivers/misc/rockchip-io-domain.c
>
> index 025b6049a9f..fdefc9c5fe3 100644
>
> --- a/drivers/misc/rockchip-io-domain.c
>
> +++ b/drivers/misc/rockchip-io-domain.c
>
> @@ -5,6 +5,8 @@
>
>    * Ported from linux drivers/soc/rockchip/io-domain.c
>
>    */
>
>
> +#define LOG_CATEGORY UCLASS_NOP
>
> +
>
>   #include <dm.h>
>
>   #include <dm/device_compat.h>
>
>   #include <regmap.h>
>
> @@ -344,8 +346,10 @@ static int rockchip_iodomain_probe(struct udevice
> *dev)
>
>                          continue;
>
>
>                  ret =3D device_get_supply_regulator(dev, supply_name, &r=
eg);
>
> -               if (ret)
>
> +               if (ret) {
>
> +                       log_debug("%s: Regulator not found\n",
> supply_name);
>
>
> Can you use dev_dbg() instead?
>

Done.


> This would match what we use for other messages in the probe function?
>
> Specifically, it could add the device name in front, which would be
> useful when debugging to highlight the IO domain device is the one
> requesting this regulator that isn't found.
>
>                          continue;
>
> +               }
>
>
>                  ret =3D regulator_autoset(reg);
>
>                  if (ret && ret !=3D -EALREADY && ret !=3D -EMEDIUMTYPE &=
&
>
> @@ -353,6 +357,7 @@ static int rockchip_iodomain_probe(struct udevice *de=
v)
>
>                          continue;
>
>
>                  uV =3D regulator_get_value(reg);
>
> +               log_debug("%s: Regulator %s at %d uV\n", supply_name,
> reg->name, uV);
>
>
> Ditto.
>

Done.


> Not sure the reg->name brings a lot since this information could be
> derived from supply_name if I'm not mistaken, but I'm not too bothered
> by it =F0=9F=99=82
>

I found reg->name to be helpful when debugging as it made it slightly
easier to find the correct regulator without having to go through a few
levels of redirection in the device tree.


>
> Cheers,
> Quentin
>

>
Thanks,
Justin
