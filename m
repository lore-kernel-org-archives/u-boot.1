Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB38ACD4F21
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 18:14:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17E3388908;
	Wed,  4 Sep 2024 20:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oWyOAyb4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECB5288B89; Wed,  4 Sep 2024 20:14:24 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D77A187705
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 20:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-70f79f1e1fbso2440412a34.1
 for <u-boot@lists.denx.de>; Wed, 04 Sep 2024 11:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725473661; x=1726078461; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7gfVyaRpgGXyWnECOIeajv3VovyI396glDkcGesuj/o=;
 b=oWyOAyb4OpKLt8TyHaGL4+EwjTBelfIJPu3WJ0UDlTH/Q2KWC20bc/K2P0ZlZeEKvP
 kY2AQO/Wo/6XaTOJgrq9zH6kdHTe/p+ZJiQffHxRzcy6HZo44XFDYy/S0OpqGA26Xzen
 9dtSx2Qi5/H2JlwOJNhF3K0hfZXMcp+qy/Tcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725473661; x=1726078461;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7gfVyaRpgGXyWnECOIeajv3VovyI396glDkcGesuj/o=;
 b=AYQrQZEh7zf5fU8Iyeg0XnmETXqra+qMC/4wAGX/lQGBLLaHjOfNCvEjydIl+NmtBn
 XJl/BE9RquCWECY5ZWkvyZf4akXhAOd+KrlAte92VmuT/+5ssddNXtyxle17x3eRLKgA
 7zOlzy8fDjYveVcgXTisBh+m64A2BOhzoPIX5T5sRxQP+xrhewD5n/MGSCg/oaM0vWK0
 7x1PUl9ru9rBtYLQ+0KJFaC+O3phOvvbShtT1R70EYTfI/YL8naYMfd2GsXti0CcfSe+
 Nwi6zFqhIuuu46rtlRb657wsLsiTdnFboVnaMnlR5rjQnYGDzlMX7vVQaq/ykDDMLOUj
 wMhA==
X-Gm-Message-State: AOJu0YydNw3HreEaqILoVJn/36RUjHWW6Y565REfHjFJD0v6UZkDboHl
 nUxB92hMmTcSzAEw8Na9I2N8yCtA3rCPXaRGtTYNPmngotqfNFi0QldrTSO8VmE=
X-Google-Smtp-Source: AGHT+IHs6e5st/ASLGQQeUp9mjpPj/5fOaaDZceXYjhPlDXfHe5uQLtNytfUQ2zljIl19otCSQ2jSA==
X-Received: by 2002:a05:6830:d02:b0:70f:331e:90f6 with SMTP id
 46e09a7af769-70f5c466677mr30179486a34.23.1725473661531; 
 Wed, 04 Sep 2024 11:14:21 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c5201e46a4sm473016d6.53.2024.09.04.11.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 11:14:20 -0700 (PDT)
Date: Wed, 4 Sep 2024 12:14:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Apurva Nandan <a-nandan@ti.com>, Bryan Brattlof <bb@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>
Subject: Re: [PATCH 07/18] ram: Support driver model in TPL
Message-ID: <20240904181417.GU2479150@bill-the-cat>
References: <20240828014538.3322013-1-sjg@chromium.org>
 <20240828014538.3322013-8-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WCwoIY6wxbBT3HsZ"
Content-Disposition: inline
In-Reply-To: <20240828014538.3322013-8-sjg@chromium.org>
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


--WCwoIY6wxbBT3HsZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 07:45:26PM -0600, Simon Glass wrote:

> Some boards want to use RAM in TPL so add an option for that.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  drivers/ram/Kconfig | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/ram/Kconfig b/drivers/ram/Kconfig
> index a64d2dff68d..f7e357f24da 100644
> --- a/drivers/ram/Kconfig
> +++ b/drivers/ram/Kconfig
> @@ -26,6 +26,15 @@ config TPL_RAM
>  	  TPL, enable this option. It might provide a cleaner interface to
>  	  setting up RAM (e.g. SDRAM / DDR) within TPL.
> =20
> +config VPL_RAM
> +	bool "Enable RAM support in VPL"
> +	depends on RAM && VPL

Subject and commit say TPL, but this is VPL.

--=20
Tom

--WCwoIY6wxbBT3HsZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbYo3kACgkQFHw5/5Y0
tywHpQv/ZbWkEWMhcOvKxtWrrwjgMd2ZABWbkbzXNBMV2WF9/M1Sv7r17/7XnXwx
hQ6YBoWXXTT0FzDTm0grPHv9lvf+1ECczMCa70I5HGdhLiiLF2HpuyTENtav6X7a
wZ4/DCfyJhla2RpZYWF4BOu8LgKBwk8Mnxn4C8S0phA0YQs12OTXgvS/qIciwdQx
GqDyCIzw0oRpb3sJNDqEPhsI91bthR7N47p9ZmSFDFgy34GiZ+5o1HAmtYqlzcKU
pqpDyg4NhMVOLTLESxStkZMW75eFI0kaHnpK8INiQkP4wNbwaD0YPqn2JW8BXPW5
u5lJtyopv5blSisGky05Abcmrb93LhZ0oVcBOwzSjzariMZcJ1ZIJdUcKnEa9k2q
Nsa9ogJTrkNpm0o9X19pxFjKg2E+ZR7MGZcZoNaaJr60xFG6PGx+wjHdbOHKPQST
OCsn3JE+KdeqBI4ITJxt5bDsuiEuoU0dl/WhZEwxjUxo4A9y3spaIh+7UwQ8l6Co
Uu3lC/nI
=USTX
-----END PGP SIGNATURE-----

--WCwoIY6wxbBT3HsZ--
