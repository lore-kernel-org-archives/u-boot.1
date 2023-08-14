Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13304C001B0
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 17:18:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7E8086964;
	Mon, 14 Aug 2023 19:18:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ywr+txAO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94B28868D0; Mon, 14 Aug 2023 19:18:00 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BC2F86958
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 19:17:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-586a3159588so64680707b3.0
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 10:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692033477; x=1692638277;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/b5KIAUpwkWSa/kBfqxomn7zIzrjiWvQwOafUPh3oik=;
 b=Ywr+txAO5Jv2Q2fnBN79m9+qY4Qs+/+ev+KXYDLWE4g9JNWxFX1sLHmLArgKB330tY
 g6iBJHUEMkEgCx87wnTxZ7OiXhdvyY4T/IMI7u8ENHG44iiBI5UskhCFc8vcsUMGSxZ2
 6bennIfd71qvw8zMycRLlAJKvv3Vk3xRTvPzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692033477; x=1692638277;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/b5KIAUpwkWSa/kBfqxomn7zIzrjiWvQwOafUPh3oik=;
 b=hgXNoSAXdMiKgqkM8atWJeia+EuA1YlIhk/AwMbTPUFbaXbWh62D4WWg7y64TTtbdy
 XYLCf85cdk+ev+TFhjh/M/T/AGPIrAl59/WGFawBfG9VxxB6VRxThYzQZQTqowbQ9k/g
 l6AhY9K8WDg/N0k7XQf0WWKw827Kf8sIn2xmLqKvZITEzzr2wfRDHPjo+7SU/0y7jBFt
 y7kCruJyDpPYQ5RgRjZpQDrYhQgQ734McVMTs3aqnFnbVTUSN5kmYQPbw7TztBLTQyZp
 yhqHqXmllIC5da3D4y0ofyQ/jMHJMhcy9sZWqfOErJsnx/7en729lL0rPmOBmA7tBEW2
 dzrw==
X-Gm-Message-State: AOJu0Yx5o/ENWvi8OlArxu8PFRndMg1z14nKT0AHM3E91BUpruseSoZl
 s6gdz/VvyBzSY3I5nDbvawCKZQ==
X-Google-Smtp-Source: AGHT+IG8RXg24VLn3sIhibqMilDWlXKfb1KhRs7RR2ap5N1oKDzku8rWhYDDHgwv/w0McgArK2rSCw==
X-Received: by 2002:a0d:d802:0:b0:583:9935:b8ba with SMTP id
 a2-20020a0dd802000000b005839935b8bamr15666627ywe.6.1692033477292; 
 Mon, 14 Aug 2023 10:17:57 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1d1b-2873-dbaa-7ea0.res6.spectrum.com.
 [2603:6081:7b00:6400:1d1b:2873:dbaa:7ea0])
 by smtp.gmail.com with ESMTPSA id
 z20-20020a81c214000000b0058038e6609csm2847515ywc.74.2023.08.14.10.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 10:17:56 -0700 (PDT)
Date: Mon, 14 Aug 2023 13:17:55 -0400
From: Tom Rini <trini@konsulko.com>
To: Julien Panis <jpanis@baylibre.com>
Cc: u-boot@lists.denx.de, marex@denx.de, tony@atomide.com,
 rogerq@kernel.org, r-gunasekaran@ti.com, vigneshr@ti.com, nm@ti.com
Subject: Re: [PATCH v3 09/12] usb: cdns3: Handle otg mode as peripheral
Message-ID: <20230814171755.GB3630934@bill-the-cat>
References: <20230706-handle-otg-as-periph-v3-0-27e24fa17345@baylibre.com>
 <20230706-handle-otg-as-periph-v3-9-27e24fa17345@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rm3qIlpiWl61HmOe"
Content-Disposition: inline
In-Reply-To: <20230706-handle-otg-as-periph-v3-9-27e24fa17345@baylibre.com>
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


--rm3qIlpiWl61HmOe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2023 at 03:45:42PM +0200, Julien Panis wrote:

> Override 'otg' to 'peripheral' mode, since 'otg' mode
> is not yet supported by u-boot.
>=20
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> Suggested-by: Roger Quadros <rogerq@kernel.org>
> ---
>  drivers/usb/cdns3/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index 644a9791b9c9..bd763fc593e1 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -149,6 +149,10 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
> =20
>  	dr_mode =3D best_dr_mode;
> =20
> +	/* u-boot doesn't yet support OTG so limit to PERIPHERAL */
> +	if (dr_mode =3D=3D USB_DR_MODE_OTG)
> +		dr_mode =3D USB_DR_MODE_PERIPHERAL;
> +
>  #if defined(CONFIG_SPL_USB_HOST) || !defined(CONFIG_SPL_BUILD)
>  	if (dr_mode =3D=3D USB_DR_MODE_OTG || dr_mode =3D=3D USB_DR_MODE_HOST) {
>  		ret =3D cdns3_host_init(cdns);

Julien, why don't we support otg mode here?

--=20
Tom

--rm3qIlpiWl61HmOe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTaYcMACgkQFHw5/5Y0
tyzkHAv5AUgcCcg4PH2zUoFhD1CzhkeJdJyu0QU591bnrFaJbkhd0lmOOeSXn8bs
VsmZxYB6sUr1QfVS8indbd77XRSHqBndrIVvCzGgrwFcRcd4LMi+ZBrZw5WiOXpQ
7Gk6wm0pxIcsLhXVZIkXXd93gud+XANwboHy9sGaBA9V/B+cDkhD5Hh/n0dfLcE2
uN4M+1WhYDA25R9KNH+4Vg6EhOGyxNQfsIo7z6gb/M5Oikem+KU8hx9dZ1xroEHX
pIufyUlohzr4vfogVas2mW1S9Rv70x6LTX3QJcv0q/+T1Qk0XW2buQfl+rIUYl+j
LqymFMDge8aT06+80U0Q+Ln5PEqXFYUhFvYFaJcfiHe+07mXVry3KMGNoYPGb13F
JI8X2KbfhGSE02zNzAeY3EHUsSn5XBfRBwfTQvhK4LEB0jC6pRTRbLGMrsHHSz6X
LSvuRuilg2l0F04A4mjWrVL6MxKVHvK+CZzi7a37zREqRsMUPOqNqaLJTTAsz1pN
MUgvYMOb
=LhPn
-----END PGP SIGNATURE-----

--rm3qIlpiWl61HmOe--
