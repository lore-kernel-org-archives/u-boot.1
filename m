Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58A4E7718B
	for <u-boot@archiver.kernel.org>; Fri, 27 Dec 2024 15:51:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B78F8036D;
	Fri, 27 Dec 2024 16:51:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q1DwY77i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C19C08036E; Fri, 27 Dec 2024 16:51:15 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58CE08035E
 for <u-boot@lists.denx.de>; Fri, 27 Dec 2024 16:51:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-467a1d43821so73845331cf.1
 for <u-boot@lists.denx.de>; Fri, 27 Dec 2024 07:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735314672; x=1735919472; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LKz3Kz9dHZGoJ4TZgtPxhP0MozO+pVIkn8lXWRF9mQ8=;
 b=Q1DwY77ixHYYV5wUIQxCcEH+/3ZdBjTMzdCTzyb8eKPYoGqdzkDDRcy9Vajrlqf9wJ
 z4TdHryuv9oyrkSJURxTVEGUQxf9dIaoU7K0N/SOGW/aXbwnbkyn6DVrz9ui93fITayM
 u2nXLrKFhoyb84wfk+HFWB7zkd4M9am2xxyPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735314672; x=1735919472;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LKz3Kz9dHZGoJ4TZgtPxhP0MozO+pVIkn8lXWRF9mQ8=;
 b=Z97TgxnJk7GC1ltInhkLAuB5sCk/NFeuVHXlCBGj9XYtn9n2+S0v3b3WJeeLoj6NT/
 89K47jo5heoty1MO7zXjIA8u1MPQ7Uap2PhOf7b89hRwWxkIEuuDOvhJSftzEtDJe/2Q
 YiGl1jqxgvEXa47VTtlXavkkhtFOxrCVIb9h4OkH3+S6i4ap9P5p0PhD9Q1li2FdKanL
 1Ry6D+5zKk6wao59T5B2lzsOJbwVeNBiPj5QYghWjyKG4JPQGm/FS392My40IjXnsovl
 /T9v/Dg43wosr4Ib+Y5axBwnDMBUjPOjn/HUUN2SVZ6FwUzn2twn/8k3wE0MokIgaLkn
 gFjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIIF+wMZDlDu/SCU2l170YTSPB8MLZd9hC33ZwuptjRkloZrePcpNvr6P+ZZrc7dMjTVGAtRM=@lists.denx.de
X-Gm-Message-State: AOJu0YyRfXDYaH6ZasfCPuhFL+BI4ip2e8SWMkHHi65Z7zoKKGLZb7Hd
 07KuHhqPe5XHc2zMm1hSxO3LsRQ1sW4rU7nSHOzdnZyxMBP6ZLbGKgJN4lfPedE=
X-Gm-Gg: ASbGncsMBsLxXA1N5zeCnacwpiU9slCYoIon+5PZUDiWZ1O2kuC7blfSxl8aXZqjBQg
 wFnl9e4CSUQ68vYLrAr45koCMR8b6f07VGxozl5k17JGuzm6zkAGpqDqVtBZ/O4nvObD/QCRC7o
 ktCcim/eGhnE8SF7gzObIU45Q0QsMnWQlz2RPEABw4b/6wT0a1Z07ScdX1o/5ziLLi65lM8t4sY
 pA11ppxlibhH5wdo3/W50iR+VgyzlLFYXwdJnCI8Tg/7ki7nnL7HUEnug==
X-Google-Smtp-Source: AGHT+IFhsIVwr2w3mgGi4oqXmZ7bwDaj8LBGxaaEYPrd5HCbCeQhQU8fslegvbtlOuIikU4Yw8tq/Q==
X-Received: by 2002:ac8:7fd3:0:b0:466:9197:b4fa with SMTP id
 d75a77b69052e-46a4b188f6dmr343374811cf.21.1735314672179; 
 Fri, 27 Dec 2024 07:51:12 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e680e85sm80747961cf.34.2024.12.27.07.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Dec 2024 07:51:10 -0800 (PST)
Date: Fri, 27 Dec 2024 09:51:06 -0600
From: Tom Rini <trini@konsulko.com>
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
Cc: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "tudor.ambarus@linaro.org" <tudor.ambarus@linaro.org>,
 "j-humphreys@ti.com" <j-humphreys@ti.com>,
 "Simek, Michal" <michal.simek@amd.com>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 "vigneshr@ti.com" <vigneshr@ti.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>,
 "seanga2@gmail.com" <seanga2@gmail.com>,
 "caleb.connolly@linaro.org" <caleb.connolly@linaro.org>,
 "sjg@chromium.org" <sjg@chromium.org>,
 "william.zhang@broadcom.com" <william.zhang@broadcom.com>,
 "stefan_b@posteo.net" <stefan_b@posteo.net>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
 "Takahiro.Kuwano@infineon.com" <Takahiro.Kuwano@infineon.com>,
 "p-mantena@ti.com" <p-mantena@ti.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [PATCH v4] mtd: spi-nor: Fix the spi_nor_read() when config
 SPI_STACKED_PARALLEL is enabled
Message-ID: <20241227155106.GC1505244@bill-the-cat>
References: <20241224153707.2054421-1-venkatesh.abbarapu@amd.com>
 <2d8cc7c5-e389-4e18-8872-ba89783488cf@denx.de>
 <SA1PR12MB86971E0E6A10C482A4F7568D980D2@SA1PR12MB8697.namprd12.prod.outlook.com>
 <20241226151726.GY1505244@bill-the-cat>
 <SA1PR12MB8697D94CADF2C51AC22EAA4D980E2@SA1PR12MB8697.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sk1LUMlplOY9b768"
Content-Disposition: inline
In-Reply-To: <SA1PR12MB8697D94CADF2C51AC22EAA4D980E2@SA1PR12MB8697.namprd12.prod.outlook.com>
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


--sk1LUMlplOY9b768
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 27, 2024 at 04:48:47AM +0000, Abbarapu, Venkatesh wrote:
> Hi,
>=20
> > -----Original Message-----
> > From: Tom Rini <trini@konsulko.com>
> > Sent: Thursday, December 26, 2024 8:47 PM
> > To: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>
> > Cc: Marek Vasut <marex@denx.de>; u-boot@lists.denx.de;
> > tudor.ambarus@linaro.org; j-humphreys@ti.com; Simek, Michal
> > <michal.simek@amd.com>; jagan@amarulasolutions.com; vigneshr@ti.com; u-
> > kumar1@ti.com; seanga2@gmail.com; caleb.connolly@linaro.org;
> > sjg@chromium.org; william.zhang@broadcom.com; stefan_b@posteo.net;
> > quentin.schulz@cherry.de; Takahiro.Kuwano@infineon.com; p-mantena@ti.co=
m; git
> > (AMD-Xilinx) <git@amd.com>
> > Subject: Re: [PATCH v4] mtd: spi-nor: Fix the spi_nor_read() when config
> > SPI_STACKED_PARALLEL is enabled
> >=20
> > On Thu, Dec 26, 2024 at 03:34:33AM +0000, Abbarapu, Venkatesh wrote:
> > > Hi,
> > >
> > > > -----Original Message-----
> > > > From: Marek Vasut <marex@denx.de>
> > > > Sent: Thursday, December 26, 2024 2:19 AM
> > > > To: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>;
> > > > u-boot@lists.denx.de; tudor.ambarus@linaro.org; j-humphreys@ti.com
> > > > Cc: Simek, Michal <michal.simek@amd.com>;
> > > > jagan@amarulasolutions.com; vigneshr@ti.com; u-kumar1@ti.com;
> > > > trini@konsulko.com; seanga2@gmail.com; caleb.connolly@linaro.org;
> > > > sjg@chromium.org; william.zhang@broadcom.com; stefan_b@posteo.net;
> > > > quentin.schulz@cherry.de; Takahiro.Kuwano@infineon.com;
> > > > p-mantena@ti.com; git (AMD-Xilinx) <git@amd.com>
> > > > Subject: Re: [PATCH v4] mtd: spi-nor: Fix the spi_nor_read() when
> > > > config SPI_STACKED_PARALLEL is enabled
> > > >
> > > > On 12/24/24 4:37 PM, Venkatesh Yadav Abbarapu wrote:
> > > >
> > > > [...]
> > > >
> > > > > @@ -1593,18 +1596,22 @@ static int spi_nor_read(struct mtd_info
> > > > > *mtd, loff_t
> > > > from, size_t len,
> > > > >   	}
> > > > >
> > > > >   	while (len) {
> > > > > -		bank =3D (u32)from / SZ_16M;
> > > > > -		if (nor->flags & SNOR_F_HAS_PARALLEL)
> > > > > -			bank /=3D 2;
> > > > > +		read_len =3D len;
> > > > > +		offset =3D from;
> > > > >
> > > > > -		rem_bank_len =3D SZ_16M * (bank + 1);
> > > > > -		if (nor->flags & SNOR_F_HAS_PARALLEL)
> > > > > -			rem_bank_len *=3D 2;
> > > > > -		rem_bank_len -=3D from;
> > > > > +		if (CONFIG_IS_ENABLED(SPI_FLASH_BAR)) {
> > > > > +			bank =3D (u32)from / SZ_16M;
> > > > > +			if (nor->flags & SNOR_F_HAS_PARALLEL)
> > > > > +				bank /=3D 2;
> > > > Is this code which operates on (nor->flags & SNOR_F_HAS_PARALLEL)
> > > > really supposed to be enabled if (CONFIG_IS_ENABLED(SPI_FLASH_BAR))
> > > > is SET or instead if STACKED_PARALLEL symbol is SET ?
> > >
> > > The FLASH_BAR and STACKED_PARALLEL configs are independent. They
> > won't depend on each other.
> >=20
> > At this point in the release cycle, I'd really rather see things as:
> > if (CONFIG_SPI_STACKED_PARALLEL) {
> >   ... anything needed for the new support mode ..
> > } else {
> >   ... the way it used to be ...
> > }
> >=20
> > And for v2025.04 we can move the codebase forward. But I'm worried at t=
his point
> > I'm going to have to revert all of the stacked stuff, which could get m=
essy, in order to
> > avoid regressions elsewhere.
>=20
> I am updating the parallel/stacked code based on the config
> SPI_STACKED_PARALLEL and not touching the default code.

Right, but to be clear, are you bringing back the default code to the
state  / algorithms it was in for v2024.10?

--=20
Tom

--sk1LUMlplOY9b768
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmduzN8ACgkQFHw5/5Y0
tyxJQwwApHHnq0nvVRQnW6Y8vBW7DhpvrIUJ10QxxConmDV+tcNNxXSBGLfMBnow
1si4GQIUSI60UNjZYWJguGwWkTL4TeR295d1x2S6gMu6LW9SvN5V7PAXMGDa6Eii
aNuyLlAXFSR4mlf8ks9cB72jZ9C1G1E0lJ2iCEyb2g2VrGIXJ0X+JLkVLdSX1Vj1
Q2foRGaa9eKtr0M4bWGL3z7UyBLFHDBvPgJCvRZY5g5LXJAZSAHuzMKPfeuc0A0F
Ju91MAZyBWvEjn8H8zVLSSyt0lvuDXF2No7gY28oZdY6ikER2/lyhA+Zh/VX+jL+
oRwTmRJn55DhhuT8cgXhPLAVt/NZfFQssbQjwtCTUWykIQweXCzTJX5WyJjMreZj
8pJKwBLmWjI5TylN0+qiNxLhaeFiBieuQpLae5AVviSS6SxiESU6Q9b/MDzD1jxG
ysSVu+MnDtnv5g6VtKx6+BnDCRgQtC0cGY9L4AQ6Ya12oDQfsvCknnnBqevnohJq
paPImByT
=Qnx/
-----END PGP SIGNATURE-----

--sk1LUMlplOY9b768--
