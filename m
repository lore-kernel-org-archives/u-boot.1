Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85DBC001B0
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 17:17:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F9A086918;
	Mon, 14 Aug 2023 19:17:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qTiBM9g8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22ECC868D0; Mon, 14 Aug 2023 19:17:51 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22D5D86918
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 19:17:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-584034c706dso50924137b3.1
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 10:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692033468; x=1692638268;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=K4KPaU9pXfKePozQJA0YqrGDA50/SS/cDjULCOTmB78=;
 b=qTiBM9g8P77vLTPqTWjQLq/AXZPJhD9rASl/KEMWClzkJHcfDkJibGInmmvp0jZud6
 jNOLCfNGlpbjDz7rBUm8oAU5uuDtBhSYW9l7PyBC+mbXIIZdj33DcphJJCNQiSfvzQiM
 broKDQK4nGSheXS+RoOqO5jwCWvM/ODsBiNaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692033468; x=1692638268;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K4KPaU9pXfKePozQJA0YqrGDA50/SS/cDjULCOTmB78=;
 b=KStB/6hgts/blhEI9hFAV68HcVFXjRHcW409v2NTMXMt6X0GD7tMzlOQMKJYw0iA1z
 0OhAk6uzns7mg8oqmC+N2I0DG0b9KRyyNbBuldhrNNNi1C047UMIKx8RSGQOib998sM1
 2brmWk+H9yDFy/gs5WKxpIPkVRIDO81UxHg33hAkmEkwv8DMdAfHEW6tEf9IL9+XImqw
 YccrlgDQykM6GZLBCDPVaRKDi8t4C0gazXGehugOOig40QEa2UDn5cF7fzrGi6ouQmUY
 7Ns3noqjkquOR8Y6w90EcJlIZe7/fM24ER/MZpZwvuS5l72Miqf2nvUK1b0XQS6hZYoW
 V/Xw==
X-Gm-Message-State: AOJu0YySp4brTO3+e8AXl+JspEs2x5G7EMk6sHsL4LcW9L8EQ21jz6p8
 8brB8quPmc0PWSGkDeVOJfK06w==
X-Google-Smtp-Source: AGHT+IFX+qkyFeQtQhCGlJpn52W3Mv459segvazAcay6HMTt+zbrS2kvIVt/e+LBEKL5TWbncbn7sA==
X-Received: by 2002:a0d:ca55:0:b0:589:a4c6:a4ed with SMTP id
 m82-20020a0dca55000000b00589a4c6a4edmr10626643ywd.3.1692033467672; 
 Mon, 14 Aug 2023 10:17:47 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1d1b-2873-dbaa-7ea0.res6.spectrum.com.
 [2603:6081:7b00:6400:1d1b:2873:dbaa:7ea0])
 by smtp.gmail.com with ESMTPSA id
 dy17-20020a05690c271100b0057a05834754sm2849307ywb.75.2023.08.14.10.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 10:17:47 -0700 (PDT)
Date: Mon, 14 Aug 2023 13:17:44 -0400
From: Tom Rini <trini@konsulko.com>
To: Julien Panis <jpanis@baylibre.com>
Cc: u-boot@lists.denx.de, marex@denx.de, tony@atomide.com,
 rogerq@kernel.org, r-gunasekaran@ti.com, vigneshr@ti.com, nm@ti.com
Subject: Re: [PATCH v3 01/12] usb: dwc3: Handle unknown mode as otg
Message-ID: <20230814171744.GA3630934@bill-the-cat>
References: <20230706-handle-otg-as-periph-v3-0-27e24fa17345@baylibre.com>
 <20230706-handle-otg-as-periph-v3-1-27e24fa17345@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9wU0fo2A2iy172rA"
Content-Disposition: inline
In-Reply-To: <20230706-handle-otg-as-periph-v3-1-27e24fa17345@baylibre.com>
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


--9wU0fo2A2iy172rA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2023 at 03:45:34PM +0200, Julien Panis wrote:

> In case dr_mode attribute is not passed via DT,
> USB DRD controllers should default to OTG.
>=20
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> Acked-by: Roger Quadros <rogerq@kernel.org>
> ---
>  drivers/usb/dwc3/dwc3-generic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-gene=
ric.c
> index 66da5a8d6f8c..857ae806e11d 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -182,8 +182,8 @@ static int dwc3_generic_of_to_plat(struct udevice *de=
v)
>  		node =3D dev_ofnode(dev->parent);
>  		plat->dr_mode =3D usb_get_dr_mode(node);
>  		if (plat->dr_mode =3D=3D USB_DR_MODE_UNKNOWN) {
> -			pr_err("Invalid usb mode setup\n");
> -			return -ENODEV;
> +			pr_info("No USB mode specified. Using OTG.\n");
> +			plat->dr_mode =3D USB_DR_MODE_OTG;
>  		}
>  	}

Is this part OK with you Marek?

--=20
Tom

--9wU0fo2A2iy172rA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTaYbUACgkQFHw5/5Y0
tywKmgv/dc16euMIcHXSeHueSWD3yODEd70ws1SL6AKdAkObGkYvsXNlioNCyqKO
Q5esqU5FzIdm42IZQXMWd+HBL/YdZgSLfS4Rgc6PseSaNwlq8SwQjmzGCpjlf2UL
63r4Mx7GadnaOAnzSZj55pCbVvepqufru9fsASHR0PaGrz7ER+ZUJOakwaXQ1idt
pldcdXnyyupOp01soG3tVMA7/yJpX05ztEqc5hyEg754fZROxbbYhejNNFKQqhjl
PB7sfsmfoHNspGaAAeMf9ZsaeNTQsJbjbOYahesj7CvE0Vg+G0PI5ekFAx5RAZ68
diDZuP08hSl143YKNx2lDfRmwlvZ7WiK+SOqjtxIbjtUp872WzIzzFDAA/h2ahgq
PSwqqazJfzbzNVJU3d5f5vQ/h7COcEWhYN/Th+Z0ThWO6aLiPJaOmH3tZD7EXTYF
7w7L65gpjuHXjtAfN5tya9zJ8Uom7ndp37k3sDwEjq//b0LMSo3eET5rlWnzQb7w
c5XM6Bnd
=pOSu
-----END PGP SIGNATURE-----

--9wU0fo2A2iy172rA--
