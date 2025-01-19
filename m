Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3626DC02188
	for <u-boot@archiver.kernel.org>; Sun, 19 Jan 2025 20:18:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8EC5806F8;
	Sun, 19 Jan 2025 21:18:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l3odrJnx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D8A480085; Sun, 19 Jan 2025 21:18:32 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D414580758
 for <u-boot@lists.denx.de>; Sun, 19 Jan 2025 21:18:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-467725245a2so41600741cf.3
 for <u-boot@lists.denx.de>; Sun, 19 Jan 2025 12:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737317908; x=1737922708; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m27uLswh5Oq82EnwB1uhb5zUBG7IjboCFS5OCf4te1s=;
 b=l3odrJnxCIbsReZ4f28YmYG423sOD8Ie2NrXubD8vrGwhpRzoPDpAnxyecNwblW1WO
 ztAJMG/gWwx1GZVJ7ITJDlzTsgu5O91klyBcXd1EK6OJ1ZaP7+FdYdwGhXahO1M+TEso
 I7gS5nkyQYlQDR1m8eH9FwQtOm7QDk992y9qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737317908; x=1737922708;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m27uLswh5Oq82EnwB1uhb5zUBG7IjboCFS5OCf4te1s=;
 b=Zq8faBi9D0dnKxZw9zoxsz6r6wUuit2okq6m59+UesxIgVmLsiIVenbO2c3Mayhg5x
 INBZT0Ulmz3GyDsR7A5rCqiSyc+juKcOdRSJxU+s+4qjd/2+WCtAsrUdKSc0sKBtbHQR
 tQe1fJp3dWYwwqgZDUI3fV9hIow4Uh6+04roIqNk3qCcbC0ahiqYm4/AuTYAdYkiDiQG
 /eVsDRHbCuZf0HCtlDmUcQj8PKO0Ceiahz82yUy4VmpsejL2QH3UV3UxWWLOTLqgxFad
 JarRrT5G8HSs15D2Swvt6nlnWXkAYkJP+3Aevrx096bSvKxASNPnxfWMpNKV5ehTe/a0
 AWPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYjzZgqCjAFsCF+OK22cW5whmp8+wgTdkCiYUYZuZ9jOFU1D48fsjbjtZEBxmdKAVRxHan1pI=@lists.denx.de
X-Gm-Message-State: AOJu0YwmzO43dEdimdamYVlJuqBIpXQ1J8EUNdZYyMu/lyF5+l3rya9S
 vCj4qC1BjH3/0HXMTteI42k+zC5KwVIy64+yXZ6rw577pDIUVqljrzA9HBNOuzQ=
X-Gm-Gg: ASbGncsQbgK0UlBxEWphMlYoC2O3kf5Ztq1bkJZbL5CRqRR08AJVswQK0chYOCEHEeR
 0FwXhUp2NHw+HE13nePPu2QIU1u4M2vtNx2EMeM6UQr3DWLB+KCIbuHClatcxtaRh2QXJrNtraa
 q3WpX+a2xTWXzgvAxwg6pxXMHHH+je5YcJV2VkveBw/pHQ6sAYtrCDi3P+ZoJO9pUc2lhIRPbTJ
 cq8+1mU6DPS3TfNYd1ZwZNDKpTXUU+T7i4MaqRzRi2EUHkoco+BNsLZ1dzBUULYppA=
X-Google-Smtp-Source: AGHT+IEATaHP85BSc9CPpgMWMyGO39IjqvKcjrq+eaNxRHGcM8rZcllLPokpwBkJs7Kudx0ewl4Ktw==
X-Received: by 2002:a05:622a:58e:b0:46a:3579:d137 with SMTP id
 d75a77b69052e-46e12bbbec6mr160730101cf.43.1737317907727; 
 Sun, 19 Jan 2025 12:18:27 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e2fdde927sm7950981cf.80.2025.01.19.12.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jan 2025 12:18:26 -0800 (PST)
Date: Sun, 19 Jan 2025 14:18:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] test: str_ut.c depends on CONFIG_STRTO
Message-ID: <20250119201824.GC3476@bill-the-cat>
References: <20241113210646.88937-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="W+qP3kEJob62T1ju"
Content-Disposition: inline
In-Reply-To: <20241113210646.88937-1-heinrich.schuchardt@canonical.com>
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


--W+qP3kEJob62T1ju
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 10:06:46PM +0100, Heinrich Schuchardt wrote:

> The string conversion functions are implemented in lib/strto.c which is
> only compiled if CONFIG_STRTO=3Dy.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/test/Makefile b/test/Makefile
> index 145c952d2c3..efd5ba7acfd 100644
> --- a/test/Makefile
> +++ b/test/Makefile
> @@ -21,7 +21,7 @@ ifneq ($(CONFIG_HUSH_PARSER),)
>  obj-$(CONFIG_$(XPL_)CMDLINE) +=3D hush/
>  endif
>  obj-$(CONFIG_$(XPL_)CMDLINE) +=3D print_ut.o
> -obj-$(CONFIG_$(XPL_)CMDLINE) +=3D str_ut.o
> +obj-$(CONFIG_$(PHASE_)STRTO) +=3D str_ut.o
>  obj-$(CONFIG_UT_TIME) +=3D time_ut.o
>  obj-y +=3D ut.o

Can you please rebase this to master? Thanks.

--=20
Tom

--W+qP3kEJob62T1ju
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeNXhAACgkQFHw5/5Y0
tyxYswv/WeyPGSQldyvf8gqgwIIHU04Whj4AxUtziBdRySPoMDwawAGoA00v2+Ld
gzcuD/m2L1GnR1BnOzT3GXPHkv6b2arVKOrHj6SEf6MESNHIhkTsoUxzQlaRcKcf
PglRo1FjQ+wiQRJ1A33lqE2sbkMnvVqHCavzaOqkPck52P8riZbrZb7daQQlf2Q5
JMD26P5VbXbI5wDLfXbdaDz1BLxpDej2tUQiUrCUHl/+wLglE+G1eGm3NPYI5d95
i6gyMf1U3dyb87JuOc5jsmlJUzp/g9CDGcehGQIz51AV9Eg3u40dYGbkIJ0hTJoT
9jGIj3QsnuFslcjzBxEEmyPqk/XvHilVIMh4BVSCJ6dvTVRtiTR2OOgWkjLQbsHI
YftUb6pPPmyWzNpBEU2JOqa52dM6ki05nhqAb72QcMQPkqTBxaXgUa6DiKTTJHTb
GtrPVsgSgZ9C69DhEL980QAe/qRGTAH2GJQNf3XfYsZ/zKLtZXX+MnOQaRk1DrDk
NArRNAmt
=79rC
-----END PGP SIGNATURE-----

--W+qP3kEJob62T1ju--
