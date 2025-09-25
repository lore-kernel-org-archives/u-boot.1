Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF415CAC5A7
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 14:34:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CD77832AD;
	Thu, 25 Sep 2025 16:34:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Jod6Wk5o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57F31832AD; Thu, 25 Sep 2025 16:34:10 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C67A482A9E
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 16:34:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-30ccea94438so571812fac.2
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 07:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758810846; x=1759415646; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cWj+BCF4hqo+9gPgm1cYBx0bz9vOAJhBnyfDnc/cKzY=;
 b=Jod6Wk5oL4bVGFiXAi34X+zF/SZkcTR1033zpGQhhhrTE7wfX9xyZtMmT8X8OVmZBN
 ZHbi8gtn+Zpjx/81H0fLVvCtrd5z5HW+o1JEtJtO4zJcC8Wd/QxgCeDIaou4G3c3zz60
 E53pHWk9NUnTCU9CrGs9WsKjHB3fXnsC05qXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758810846; x=1759415646;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cWj+BCF4hqo+9gPgm1cYBx0bz9vOAJhBnyfDnc/cKzY=;
 b=CJ10JqWEZ86Ax3bThe+/fuoyKX+6EbZytra6LUezAs2wge8ii5KCbbBtBUFp92qv+H
 VVyxEa0RPU/+5rHNTQKt17daoTHVzFzIbEby3PQsw69BpKVYmA2f+K9Dkm5rinPmhQK+
 E8Ao7R0kwBn90PuWQrJALUCXu5qTaR6EojN1ungUx8Y+uFlcBdu3Ssob0rDWbyg+QTZo
 VqsksrPHpKfyRFXZPnX6fT/47u+17ZqjVYIz9cdFm2TSXsTMspRKci5LRoDVp9W17am1
 yqdTd+wSh64PY6sRZo8Y5xmht5xkLbt4sf3261mqa3oJhafeSxK/oyVS+te3DSXtq1Xj
 tQEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEdLqFu7n94AJydQI6IGendd5ftcJja8B7OzmBcHq+3mUnJmb+IuaSEiq1Z0F/hytSI/iPDpI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz25MnGQkcFT0k+mssJLnJ6om0eL+OkJQV3qP+g3FJz49dNikIu
 KnoCpbmAWpdmtvDMGuI1YT2G3C44MvlnXk9XogTyAXwBR7k1qwUV5c5oC/1YTkS2SK8=
X-Gm-Gg: ASbGncsri5F9OPFWwDUznOG+T8dfoN9waDnPiowmTJptn/oYIBtM449psA1+pHy3EYV
 ZpuEtquUXE0xMmEe8BRv/ZBETRrJyz/cb/EyodpzTN8/usekfvAHgcpZ9mA9VMTabVRT5nLYRQO
 7lJtWPj132Ch/JzXUyms2aAtRGPHqdusbbRRLxOO8tIwL1WD3WlVfeZnO0Q+1vm/z0y/G2a31Pf
 SK1De0wtQT7S3f+QBXQMr8W/Bdc9+drECigNUzyCs81JVPOkFX9E5/mSZbXDbWeiT0XkKe38iJg
 CuTCuZWXBvutEWHifFhelyoY7OIvpdThzFXv9H1NeBmgWM91J4ipWpNq5GkMXuZKiBe8+K9StT8
 yIyjY6YB1+Ut94JjV1kmvcf4VEeq31pV1CtlOxr/oVJ4XdHn7PSNXWxxL
X-Google-Smtp-Source: AGHT+IGFQt6s5thA4jCYYQ75UtsL/nAtb5/TXtXqHPavCKTRCjXS6fJ2U3CUNTRbC41vwIEInkz7Hw==
X-Received: by 2002:a05:6871:7bc7:b0:34c:251a:4ef2 with SMTP id
 586e51a60fabf-35ebf3f488emr2046502fac.2.1758810846463; 
 Thu, 25 Sep 2025 07:34:06 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-363b3381cd0sm590182fac.26.2025.09.25.07.34.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 07:34:05 -0700 (PDT)
Date: Thu, 25 Sep 2025 08:34:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Adam Ford <aford173@gmail.com>,
 "Derald D. Woods" <woods.technical@gmail.com>,
 Marek Vasut <marex@denx.de>, Paul Kocialkowski <contact@paulk.fr>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] am33xx: am3517 evm: Drop old musb AM35X driver
Message-ID: <20250925143403.GA685920@bill-the-cat>
References: <20250629195455.53083-1-pbrobinson@gmail.com>
 <20250629195455.53083-2-pbrobinson@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hYd8PN3exTNdbIqS"
Content-Disposition: inline
In-Reply-To: <20250629195455.53083-2-pbrobinson@gmail.com>
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


--hYd8PN3exTNdbIqS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 29, 2025 at 08:54:47PM +0100, Peter Robinson wrote:

> The USB_AM35X is a legacy driver with one remaining user. The rest
> of the am33xx devices use the USB_MUSB_TI driver for DM_USB so
> move the last user USB_MUSB_TI which is the newer musb driver
> So move to the newer driver so we can drop the old driver.
>=20
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  configs/am3517_evm_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/configs/am3517_evm_defconfig b/configs/am3517_evm_defconfig
> index 244a39cd88f..ba8552948b0 100644
> --- a/configs/am3517_evm_defconfig
> +++ b/configs/am3517_evm_defconfig
> @@ -92,6 +92,6 @@ CONFIG_OMAP3_SPI=3Dy
>  CONFIG_USB=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
>  CONFIG_USB_MUSB_HOST=3Dy
> -CONFIG_USB_MUSB_AM35X=3Dy
> +CONFIG_USB_MUSB_TI=3Dy
>  CONFIG_BCH=3Dy
>  CONFIG_SPL_TINY_MEMSET=3Dy

This patch is wrong, CONFIG_USB_MUSB_AM35X is the right symbol for the
correct "musb-new" glue code for this platform.

--=20
Tom

--hYd8PN3exTNdbIqS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNVS2gAKCRAr4qD1Cr/k
Chr8AQDkUaaWC1ALernSr5Yl+lw9ndkjq2mO+5xkhXh0pt7hMAEA9+vB7y69qA5V
2y/A3IFh15NUYyshnq30apozvRQMEQ8=
=Cr+m
-----END PGP SIGNATURE-----

--hYd8PN3exTNdbIqS--
