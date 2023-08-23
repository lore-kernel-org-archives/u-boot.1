Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52802C3DA66
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 17:11:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CA4D8647B;
	Wed, 23 Aug 2023 19:11:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GPmy9App";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6DFE8647B; Wed, 23 Aug 2023 19:11:27 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 529A686478
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 19:11:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-58dce1f42d6so923577b3.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 10:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692810684; x=1693415484;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3dN4ymocaYpxXgZRCm7jR2sdVM6ot45wXvvYh5YHeK4=;
 b=GPmy9App6YgsHkFWDjpdzDO7fv4lFI4f8h4qyspi2LS1mGscK4qkoF5nSs3+XOyu1H
 CWIQVXJ+lw4t6o/cQLOX3E7nVf3h/hlSCNEHQ9ue9DcitzM6dS7RJBSl7e/dhYqKvQSP
 DfrXYhQXPva2H/N/ITRqaAWz90H/cYkBQqGdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692810684; x=1693415484;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3dN4ymocaYpxXgZRCm7jR2sdVM6ot45wXvvYh5YHeK4=;
 b=bvxPqjlb3bhePnFFt1mkNEBpKGMT8JK7YYT+dmnr8ugNrO4W+oC2WolVAAeFVYUhiC
 tmtsZ5j7M7E4hlRsnfVQPnTfp4vTMq0r1SyrhBjSq5vcnTEIouN0nwUYX5l+GpvJ6UJz
 34KPKZ5VLkMX50EswHXE4LBEBV8KpM47Sw6dEQszdZT7iVFYmw6e7i1PC52PhUvM9TAF
 f9eFEcxCc/5zRSmX6NXJRcakjKAfOhiMBO8UMx8oQzuve+O0/z9jWnY8rAH6oOBLuQa0
 CxiVf8aZs9HVwohZkdGwU0D+thTFBTySI4oKXjKWyRPgjApQujT+4IuHUrIrua0k2pDL
 s15A==
X-Gm-Message-State: AOJu0YysbWOK5LNqVWfMad+1f5BF6FnbbK6RD93epN+WucP+HKQHgmei
 rLz8hyxuXIXb4V82E8wyAPApq+xjWM2aBhPYdtv6XA==
X-Google-Smtp-Source: AGHT+IEUrlKzYqxARICwpzUDSmDmCh7tKvGxRq+Ho2XzKGU+whdBPhAJCaTt0EemsgbID5nzoakQMQ==
X-Received: by 2002:a81:9290:0:b0:58e:c394:37c9 with SMTP id
 j138-20020a819290000000b0058ec39437c9mr11955064ywg.10.1692810684030; 
 Wed, 23 Aug 2023 10:11:24 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 y123-20020a0dd681000000b0058e37788bf7sm3446685ywd.72.2023.08.23.10.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 10:11:23 -0700 (PDT)
Date: Wed, 23 Aug 2023 13:11:21 -0400
From: Tom Rini <trini@konsulko.com>
To: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] usb: dwc3: Fix renaming SPL_USB_HOST_SUPPORT to
 SPL_USB_HOST
Message-ID: <20230823171121.GP3953269@bill-the-cat>
References: <20230823142227.69923-1-oleksandr.suvorov@foundries.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dUyFiHg7C4BGyGZB"
Content-Disposition: inline
In-Reply-To: <20230823142227.69923-1-oleksandr.suvorov@foundries.io>
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


--dUyFiHg7C4BGyGZB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 05:22:19PM +0300, Oleksandr Suvorov wrote:

> In the usb/dwc3-layerscape driver the first option should be renamed
> to the latter as well. Do it.
>=20
> Fixes: 333e4a621df ("Rename SPL_USB_HOST_SUPPORT to SPL_USB_HOST")
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
> ---
>=20
>  drivers/usb/dwc3/dwc3-layerscape.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/dwc3/dwc3-layerscape.c b/drivers/usb/dwc3/dwc3-l=
ayerscape.c
> index 79cf71f7a85..77801c10084 100644
> --- a/drivers/usb/dwc3/dwc3-layerscape.c
> +++ b/drivers/usb/dwc3/dwc3-layerscape.c
> @@ -134,7 +134,7 @@ U_BOOT_DRIVER(dwc3_layerscape_peripheral) =3D {
>  };
>  #endif
> =20
> -#if defined(CONFIG_SPL_USB_HOST_SUPPORT) || \
> +#if defined(CONFIG_SPL_USB_HOST) || \
>  	!defined(CONFIG_SPL_BUILD) && defined(CONFIG_USB_HOST)
>  static int dwc3_layerscape_host_probe(struct udevice *dev)
>  {
> @@ -194,7 +194,7 @@ static int dwc3_layerscape_bind(struct udevice *dev)
>  		driver =3D "dwc3-layerscape-peripheral";
>  		break;
>  #endif
> -#if defined(CONFIG_SPL_USB_HOST_SUPPORT) || !defined(CONFIG_SPL_BUILD)
> +#if defined(CONFIG_SPL_USB_HOST) || !defined(CONFIG_SPL_BUILD)
>  	case USB_DR_MODE_HOST:
>  		dev_dbg(dev, "Using host mode\n");
>  		driver =3D "dwc3-layerscape-host";

This is incomplete as now that we have CONFIG_SPL_USB_HOST instead of
CONFIG_SPL_USB_HOST_SUPPORT that means we can use
CONFIG_IS_ENABLED(USB_HOST) which is true for (SPL_BUILD&&SPL_USB_HOST) ||
(!SPL_BUILD&&USB_HOST).

--=20
Tom

--dUyFiHg7C4BGyGZB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmPbYACgkQFHw5/5Y0
tyx4cwv/VXQ+xck71JFDtUfPap+5C1MTms0rUgaxOpfLNHo1uaE877Aer8eZBGqU
Z6OCZSzP9VB+diLPq84srYg21gvVkL1Qe5bswUyl9DxsoQSLOIsybG3llkSQmFXG
1laKtYmFG3w5G+iCcoc8fJZvOrRJCPMMh3aVT/4dLz+nkf0L5i8jeEYMTHGlavCg
UNFULCNHI6mYfFvuPlEhaPWCQjvuAaP3BYDisVjyiwlLEso/k56bC4c2kAkdj3+C
runwvkZCZx2WDGHuKZ9vlDWkaKcNfhvMu6je4ta/4rhpojv4W/R+ALCBFMJGW5Ka
BfO6IBvd8cRZ/1V9Uu9JFBTof3BMEoIAQzK202K1aizCrdeTabsiUg3VyHoKWYjE
U7T+UdohD4eHQrsmJokYffhCVkyfkDLkAI1IQ1NXDEUjyW+15l+GyBazS/FGNOu1
RzoDlpf/pJqN5rieWl69MbLVeUvCyJ1bozuP28RNNwORSyHoletdO94GhMh1gkqL
BHNPVi2+
=DcIg
-----END PGP SIGNATURE-----

--dUyFiHg7C4BGyGZB--
