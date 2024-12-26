Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC93DE77188
	for <u-boot@archiver.kernel.org>; Thu, 26 Dec 2024 15:17:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE0A580384;
	Thu, 26 Dec 2024 16:17:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P+cb4F7c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DFD4803B7; Thu, 26 Dec 2024 16:17:35 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2FE88036D
 for <u-boot@lists.denx.de>; Thu, 26 Dec 2024 16:17:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b6e5c74cb7so463920385a.2
 for <u-boot@lists.denx.de>; Thu, 26 Dec 2024 07:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735226251; x=1735831051; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Mh2Mq1Mp6R1puzFnRipN+3FnNBohaXWhQUKwmhVirZ4=;
 b=P+cb4F7cFm6hZJz9nVdPDNkoF05/jjZt06uhEXHT9qpy0qabIXbG1VlO6pJ5+dOKFv
 PF1EtE9xKBZpvrsv4uQNoRYBHsDyN+K1yufAf1AJxZbfzHiIrF13WN757pHX5gQ3PMRl
 My8Ex2FXHdcexfhN9UeBx2/g7eXxtma3QkFBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735226251; x=1735831051;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mh2Mq1Mp6R1puzFnRipN+3FnNBohaXWhQUKwmhVirZ4=;
 b=NYx3kb+exuIKZ4VA2IQwmvvTXiw25+T8F0jKIL4j4pLJOms9RqW2rhwwqCVx7g8k5e
 PMaKqPBM442U10MrIwjK7+ST9egzfBWCbqg+/HGuWn+wzF7ykENwaKbFBcGYv+mRzIUo
 M5bhtjDEb4VCB5o5PKOGJ06I6D0p9fJJsQUDybeMyqKP7tJTMJ3HGZtG+EYa8lolsMcu
 rSkA1ZCgNbjg1CgcFzZZmpStV2pxTJV6EOsG37WFecOBKMoEARKt2Otmsm5gNR80rNoS
 u3KdcHWL4eqaaLKiMbMKsEsGaGavAiWS6SJie+W7sA331NYkOT6xhhwVyIprt2jiCUac
 a/xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvLT+zitwHGBZKUpWb770j8kn93RjK0STQjLhMC4r/tRMs2zGNHCwd5e46csbQjZMns3Ycia8=@lists.denx.de
X-Gm-Message-State: AOJu0YwvqUyukCr9EeD/r96oEpInWRU/X3DMeOtdufcFtlQ36GrvM2Mk
 TZpDF72jOZwhXzyJDX0CkuHLXfNExbs24mt3ExccgH9X9zqZyYaBoozqlQyFej8=
X-Gm-Gg: ASbGncsHY+y84OqeK6QwCZ2SQEVp22gKnS+cqX3EinMyB1S39hRSQR9VEFuGc8PuMtP
 93boVdXp2YsX7T7eYjQaL8/0ZzST0nLh0C8+gNjYIN+X5EQUgRx04JhEm8fxcc87rpidLciFACz
 mR0x9R11ImlIdB4595zy5tVuu42nlNdCjKhP+I60w7HxHEZEfYprBKTnhm9Kd/aoxKgnxFuJbEK
 lhbteD6uFcR9xsneDipu2O8kZNoCkVD9IgAObesernG+jkgz7zCgl/1VQ==
X-Google-Smtp-Source: AGHT+IG95h0p/5H96bO79jEeys2RXuDRdM4k7kIDStWQIZdQbBEh16B3vntngKhEyX9NdlFuBu6OxQ==
X-Received: by 2002:a05:620a:4711:b0:7b6:d90f:e4ca with SMTP id
 af79cd13be357-7b9ba79c17cmr3265104785a.26.1735226251404; 
 Thu, 26 Dec 2024 07:17:31 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac2bd0b9sm626675785a.23.2024.12.26.07.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Dec 2024 07:17:30 -0800 (PST)
Date: Thu, 26 Dec 2024 09:17:26 -0600
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
Message-ID: <20241226151726.GY1505244@bill-the-cat>
References: <20241224153707.2054421-1-venkatesh.abbarapu@amd.com>
 <2d8cc7c5-e389-4e18-8872-ba89783488cf@denx.de>
 <SA1PR12MB86971E0E6A10C482A4F7568D980D2@SA1PR12MB8697.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CSnYyJjYg631zN12"
Content-Disposition: inline
In-Reply-To: <SA1PR12MB86971E0E6A10C482A4F7568D980D2@SA1PR12MB8697.namprd12.prod.outlook.com>
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


--CSnYyJjYg631zN12
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 26, 2024 at 03:34:33AM +0000, Abbarapu, Venkatesh wrote:
> Hi,
>=20
> > -----Original Message-----
> > From: Marek Vasut <marex@denx.de>
> > Sent: Thursday, December 26, 2024 2:19 AM
> > To: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>; u-boot@lists.denx=
=2Ede;
> > tudor.ambarus@linaro.org; j-humphreys@ti.com
> > Cc: Simek, Michal <michal.simek@amd.com>; jagan@amarulasolutions.com;
> > vigneshr@ti.com; u-kumar1@ti.com; trini@konsulko.com; seanga2@gmail.com;
> > caleb.connolly@linaro.org; sjg@chromium.org; william.zhang@broadcom.com;
> > stefan_b@posteo.net; quentin.schulz@cherry.de; Takahiro.Kuwano@infineon=
=2Ecom;
> > p-mantena@ti.com; git (AMD-Xilinx) <git@amd.com>
> > Subject: Re: [PATCH v4] mtd: spi-nor: Fix the spi_nor_read() when config
> > SPI_STACKED_PARALLEL is enabled
> >=20
> > On 12/24/24 4:37 PM, Venkatesh Yadav Abbarapu wrote:
> >=20
> > [...]
> >=20
> > > @@ -1593,18 +1596,22 @@ static int spi_nor_read(struct mtd_info *mtd,=
 loff_t
> > from, size_t len,
> > >   	}
> > >
> > >   	while (len) {
> > > -		bank =3D (u32)from / SZ_16M;
> > > -		if (nor->flags & SNOR_F_HAS_PARALLEL)
> > > -			bank /=3D 2;
> > > +		read_len =3D len;
> > > +		offset =3D from;
> > >
> > > -		rem_bank_len =3D SZ_16M * (bank + 1);
> > > -		if (nor->flags & SNOR_F_HAS_PARALLEL)
> > > -			rem_bank_len *=3D 2;
> > > -		rem_bank_len -=3D from;
> > > +		if (CONFIG_IS_ENABLED(SPI_FLASH_BAR)) {
> > > +			bank =3D (u32)from / SZ_16M;
> > > +			if (nor->flags & SNOR_F_HAS_PARALLEL)
> > > +				bank /=3D 2;
> > Is this code which operates on (nor->flags & SNOR_F_HAS_PARALLEL) really
> > supposed to be enabled if (CONFIG_IS_ENABLED(SPI_FLASH_BAR)) is SET or
> > instead if STACKED_PARALLEL symbol is SET ?
>=20
> The FLASH_BAR and STACKED_PARALLEL configs are independent. They won't de=
pend on each other.

At this point in the release cycle, I'd really rather see things as:
if (CONFIG_SPI_STACKED_PARALLEL) {
  ... anything needed for the new support mode ..
} else {
  ... the way it used to be ...
}

And for v2025.04 we can move the codebase forward. But I'm worried at
this point I'm going to have to revert all of the stacked stuff, which
could get messy, in order to avoid regressions elsewhere.

--=20
Tom

--CSnYyJjYg631zN12
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdtc4IACgkQFHw5/5Y0
tyyouAv/br552IfHrHzUi5+xEr2T2PHRypOZcGJU88vgLjGFdS45d0rYayEHDo80
qfIx58pOoFT8gGRliR61NEtU7Zckh9G2tWaCSpqx+9xrsvGCTEiAiMTuM6OZ8fZj
41yDtsZPp0hq1BoI5EEJheSAlIsJ4GQGlb26FESzv+cZEsMURVLgyYyAQv6BE7bb
WeAll5jBSeFqfEmtAh5afn2+ypJuX2KzrIJu9d4Hd95BBGd6zuMEua/yi8XMpRzO
YoLWRbBm2T2dHGDRrerOlx3wwYPjAngdOCoGl/dyz98ebKNs5nqFXIUR1VtlOoDJ
esrr4q85KnKL/YSFMl/75Paas9xBewRbgW++uv/+NZ+sohTHqOkdxl5ABLD55UGl
AaoQxUZlO5W+mxM16+7TvGMrci3oeA7x+Z4NLBssOZC1vDAHzNVx7iyjgIW5Jlng
20PCvZZEFYd0Ukn3lCu8jRbXBSaMI3vA5GazqZMTbVQIJXy1yZbyOlxd/8ML1/OF
SIx/59RZ
=dnYW
-----END PGP SIGNATURE-----

--CSnYyJjYg631zN12--
