Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C2CCD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 15:39:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A16EC88BEF;
	Mon,  2 Sep 2024 17:39:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cI6E+6is";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB19488C36; Mon,  2 Sep 2024 17:39:30 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3D9788BEF
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 17:39:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6c3552ce7faso19771886d6.1
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 08:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725291567; x=1725896367; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UpucehCMDuHrTzbwyV8VA05AKaASr8zAo7/kN+GbRqw=;
 b=cI6E+6ishkwLJMVV3hccL9E5bA3VQZTsSuBwdf1e7k7zEvr0M2V73FtxBmf//32A08
 qg3mQSxkOI2McJXTxsMqAJ14EXuYwmjViISyxUzsogdqUuj2f96qY4D64UiP8yyeFZ04
 0pUOKNfsnKmXI/ZnSoe9ps9hOaptKDo97zwnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725291567; x=1725896367;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UpucehCMDuHrTzbwyV8VA05AKaASr8zAo7/kN+GbRqw=;
 b=WAqrBLevdbFtBzgcwQVF+I07n+8YirGy92oJtjjU8JzQP5RctOsnYFUmVR8QGaL9oS
 OmLxArRtdxWMyCBVZwtVkueoddeksOqeJGdMRJz16uwykH/4zmMuepN0K3C6kbMf+ERz
 USwAY9bcnkD9nfC9u7o/VxFf9X8/VyUYeUvzI+ONu+MRgxo34gwM1aytPrIKAEMB8kW1
 0br2clqNhbVL+v9U7afKiQi1InVTen2PC3apPI1sOO6rRhbeFkmiasPtqziR1sYJRAMl
 boR1L5NGf0X3ASt9Mzz9firBuvH463IeT1ErvcjtrFkTi8tRxB8ulVnFXBzbDkWvpDOK
 cpyw==
X-Gm-Message-State: AOJu0Yw8R/G48u4xPBg20hKywd1YeavCo8VnGiVAza5lflquXbwqfBAS
 WHBGay2EZjDDPIahloIvZ3TpkFV3yrM6i+XCTnZ2StI8HFX3vjHB4jW9TKOFwaU=
X-Google-Smtp-Source: AGHT+IG01f7eB2TCMA/qu+4FMCzpLkdxutiAelp6ZF7ul+crGFcXtQofvywYoPwrAjwqRKvMP/nymw==
X-Received: by 2002:a05:6214:5c42:b0:6c3:6560:af09 with SMTP id
 6a1803df08f44-6c36560af4cmr61599326d6.0.1725291567537; 
 Mon, 02 Sep 2024 08:39:27 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c340c96804sm43477276d6.93.2024.09.02.08.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 08:39:27 -0700 (PDT)
Date: Mon, 2 Sep 2024 09:39:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>
Subject: Re: [PATCH v2] ARM: imx: Wrap i.MX config options in MACH_IMX
Message-ID: <20240902153924.GY2479150@bill-the-cat>
References: <20240901003813.674730-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="o9/aZlpFQ821E50T"
Content-Disposition: inline
In-Reply-To: <20240901003813.674730-1-marek.vasut+renesas@mailbox.org>
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


--o9/aZlpFQ821E50T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 01, 2024 at 02:38:00AM +0200, Marek Vasut wrote:

> Wrap all the i.MX specific options in MACH_IMX, otherwise they keep
> showing up in other SoC vendor configurations. No functional change.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--o9/aZlpFQ821E50T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbV3CwACgkQFHw5/5Y0
tyzS2wv/cy5JqOQq0G2PLYJTPiTzFOZeGgrcjMi12RQ29Y+lLyWbEgn+jX/PwCVm
kwrSl/SayKJl51eWM5S8+pYaz7x2pjIUo+Ja+A6eLv8UlDCKtp9LE8HpMGwwDlci
Ypzd8qUK10X+3AJLS1gRmCyltpW7FdN75pT+2SwbJnHaOuLihkTVeL2CZfXm5SjH
LtfMSGtc+fXXiC5+WRZOksKG95+TO2wWOtEu7JHE92cY6mZrvIcDGqo0vMIoR7Pm
u2SJU+RX4M2+3l+/Is6wdsioINCIzQAy1/uwvLBmTIqDfx5qvhLPQtQBvnRyOJ52
jG73Q5G3uL56A6+vVfdLa4EjiOwNGqcLQ1I6Jm+V9qmAqsqIyELs81bcrJTMVBNm
mkY8EYZz0nJgkSg6iEjSn1+iKpJEBi4Qzf7TaeHY5t6jqRlSpWZPKpSDQDGojx/w
cFmoP3e3BwpFB6AxeASPfdu3e7I1EJXBzGM13cYPEW2754ANrgp2wEvF192nXdmx
+9chDVWc
=1mtv
-----END PGP SIGNATURE-----

--o9/aZlpFQ821E50T--
