Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6772EE77188
	for <u-boot@archiver.kernel.org>; Mon, 30 Dec 2024 14:22:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 707AA805EA;
	Mon, 30 Dec 2024 15:22:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HKFQk/oq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72A2D805EB; Mon, 30 Dec 2024 15:22:14 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D496805C1
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 15:22:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b6f95d2eafso909566185a.3
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 06:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735568531; x=1736173331; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eRRUck8fbLg+v60yusDfNefFfsU1TTmVagEyGLqxUeU=;
 b=HKFQk/oq0fuo19xj3HF5jRRAVZkr0vXlnG3EhbMJqnnzB/prOh+KusdFUD4H+sKpil
 Vfa7SNlfYpPhgaWA6jn6S0i2F9XjPlQXUFqpFnCUtIoFZDlcNYkW901TbGev4W+UnCLy
 +qwbNUJRon/TrzPaRATUcnWwDdk9DLjeAXl74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735568531; x=1736173331;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eRRUck8fbLg+v60yusDfNefFfsU1TTmVagEyGLqxUeU=;
 b=WibgLh2UjSLmpq6cIpzhLaezxR3icfQSii+Ap5mc68JJb79ae2tJX9IZ5OK7mXLKsq
 wdR/UkFlFYU/ZpH4goBoga0J3ztR52GpvbbxYEFch2QDu3Eb1Jji6xtbuKLE+udE0suR
 SwnShgVR5DhOJBDUXde7epp0C3UHnH0C9taG+S8vGWJoz27+HvPu2nrWy8g7yQoCQyH6
 irlhnNON5ubPZ0V/Oil8Qjfa+SeAY0y6aUdkUy6cwE2+lUApflndXy+ssvqfeIxaNgLJ
 uL0StQuE2RW1ce5dUmxnRDgUlkubrmnyMOwl3rOmgXseJL/ed3dAXRI3Q57If6zxVFd4
 zbqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV947h+ndTKmdUkCnATFZFoE/4y02a0s4+U41Y6qXZD9OGj6am7Ll85aT3JJoWoI4jag6zM3/w=@lists.denx.de
X-Gm-Message-State: AOJu0YzBRx8nc3YZqJS5BzepYAIoc8Eg8Vq8LM0uqAKgSKtUEKdPoS3w
 LHy0K4ACK2yQ6vfaAAEHEqL4wWb2C5mEFJyQn3/LRjPWiqKzmkwWWCVWSu9KM2w=
X-Gm-Gg: ASbGncsnnos1AFs6vsFaPyWTQwB5CAMmaz6m4epZS8OHRt6Qu6JnRtbMm53V3vUdSdy
 cQDtgU3b4UVYRWV2qMrZbW8qGwChdr6b3nv9Be7g6NOkghU0N9UBLHUYUcCVe64LETgcFPgSFlE
 v2/mN0DBGwWzF+as6ilXNiAh50YPh3PBcieFnbpxVfnVwOiv/K6EvEz+ut1PFIttGj2zzPlZIRn
 trNWMtfAn+bkne2F3SquPHguoY+KVQDzvQ6JxZVMv44nJuDbG8lRGSX0Q==
X-Google-Smtp-Source: AGHT+IFOAAwhG+AKIqxH05cnyvkRCllVpEUMmLxwUmb79/6e0PqvTqUKTC94f0+N0BVvAoedrQFXIQ==
X-Received: by 2002:a05:620a:40d2:b0:7b6:eed4:695c with SMTP id
 af79cd13be357-7b9ba79d2cdmr5109293085a.32.1735568530816; 
 Mon, 30 Dec 2024 06:22:10 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac2dfeaesm920884385a.40.2024.12.30.06.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 06:22:09 -0800 (PST)
Date: Mon, 30 Dec 2024 08:22:05 -0600
From: Tom Rini <trini@konsulko.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 u-boot@lists.denx.de, tudor.ambarus@linaro.org, j-humphreys@ti.com,
 marex@denx.de, michal.simek@amd.com, jagan@amarulasolutions.com,
 vigneshr@ti.com, seanga2@gmail.com, caleb.connolly@linaro.org,
 sjg@chromium.org, william.zhang@broadcom.com, stefan_b@posteo.net,
 quentin.schulz@cherry.de, Takahiro.Kuwano@infineon.com,
 p-mantena@ti.com, git@amd.com
Subject: Re: [PATCH v6] mtd: spi-nor: Fix the spi_nor_read() when config
 SPI_STACKED_PARALLEL is enabled
Message-ID: <20241230142205.GB3476@bill-the-cat>
References: <20241230070206.2178551-1-venkatesh.abbarapu@amd.com>
 <54dc7b9a-32f7-4a37-af51-69095d28956f@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eaAbLsiGDq6wxOGS"
Content-Disposition: inline
In-Reply-To: <54dc7b9a-32f7-4a37-af51-69095d28956f@ti.com>
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


--eaAbLsiGDq6wxOGS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2024 at 03:03:39PM +0530, Kumar, Udit wrote:
> Hello Venkatesh,
>=20
> On 12/30/2024 12:32 PM, Venkatesh Yadav Abbarapu wrote:
> > Update the spi_nor_read() function based on the config SPI_FLASH_BAR
> > and update the length and bank calculation by spliting the memory of
> > 16MB size banks only when the address width is 3byte.
> > Fix the read issue for 4byte address width by passing the entire
> > length to the read function.
> >=20
> > Fixes: 5d40b3d384 ("mtd: spi-nor: Add parallel and stacked memories sup=
port")
> > Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> > ---
> > Changes in v2:
> > - Update the nor read for parallel configuration and for other case
> >    keep the code as is.
> > - Fixed the commit description.
> >   - Tested the changes with s25fl128s flash  Zynq> sf probe 0 0 0
> >   SF: Detected s25fl128s with page size 256 Bytes, erase size 64 KiB,  =
total 16 MiB  Zynq> time sf erase 0x0 0x1000000;mw.b 0x8000 aabbccdd 0x1000=
000;time  Zynq> sf write 0x8000 0x0 0x1000000;mw.b 0x8008000 0x0 0x1000000;=
time  Zynq> sf read 0x8008000 0x0 0x1000000;cmp.b 0x8000 0x8008000 0x1000000
> >   SF: 16777216 bytes @ 0x0 Erased: OK
> >=20
> >   time: 32.464 seconds
> >   device 0 whole chip
> >   SF: 16777216 bytes @ 0x0 Written: OK
> >=20
> >   time: 15.515 seconds
> >   device 0 whole chip
> >   SF: 16777216 bytes @ 0x0 Read: OK
> >=20
> >   time: 1.557 seconds
> >   Total of 16777216 byte(s) were the same
> >=20
> > Changes in v3:
> > - Compile out the parallel code in spi_nor_erase() if the SPI_STACKED_P=
ARALLEL
> >    is enabled.
> >=20
> > Changes in v4:
> > - Update the bank calculation only when SPL_FLASH_BAR is enabled.
> >=20
> > Changes in v5:
> > - Update the parallel code in the spi_nor_read() only if the SPI_STACKE=
D_PARALLEL
> >    config is enabled.
> >=20
> > Changes in v6:
> > - Remove the hardcoded address width for 4byte.
> > - Move the length condition with rem_bank_len under SPI_FLASH_BAR flag.
> > ---
> >   drivers/mtd/spi/spi-nor-core.c | 75 ++++++++++++++++++++--------------
> >   1 file changed, 44 insertions(+), 31 deletions(-)
> >=20
> > diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-c=
ore.c
> > index ec841fb13bd..6f352c5c0e2 100644
> > --- a/drivers/mtd/spi/spi-nor-core.c
> > +++ b/drivers/mtd/spi/spi-nor-core.c
> > @@ -1130,17 +1130,19 @@ static int spi_nor_erase(struct mtd_info *mtd, =
struct erase_info *instr)
> >   			goto erase_err;
> >   		}
> >   		offset =3D addr;
> > -		if (nor->flags & SNOR_F_HAS_PARALLEL)
> > -			offset /=3D 2;
> > -
> > -		if (nor->flags & SNOR_F_HAS_STACKED) {
> > -			if (offset >=3D (mtd->size / 2))
> > -				nor->spi->flags |=3D SPI_XFER_U_PAGE;
> > -			else
> > -				nor->spi->flags &=3D ~SPI_XFER_U_PAGE;
> > +		if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
> > +			if (nor->flags & SNOR_F_HAS_PARALLEL)
> > +				offset /=3D 2;
> > +
> > +			if (nor->flags & SNOR_F_HAS_STACKED) {
> > +				if (offset >=3D (mtd->size / 2))
> > +					nor->spi->flags |=3D SPI_XFER_U_PAGE;
> > +				else
> > +					nor->spi->flags &=3D ~SPI_XFER_U_PAGE;
> > +			}
>=20
> I believe SNOR_F_HAS_PARALLEL and SNOR_F_HAS_STACKED flags are specific to
> your use case.
>=20
> which should be set if flash is parallel and/or stacked, then why you want
> to protect with another
>=20
> =A0if=A0 (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL).

Because at this point in the release cycle I really really want these
isolated from the rest of the code paths, given the problems we've seen.
I expect some cleanups for v2025.04 that will get wider testing than
happened for what will be in v2025.01.

--=20
Tom

--eaAbLsiGDq6wxOGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdyrIYACgkQFHw5/5Y0
tywRCwv/e41lZjXHzUskfT8LlRmIrpHrKxySrB8brd9aEnDadYwZAIRzF9+uKtEP
xqC9mW3ER2Q8sjTWL+JrZ/MSuvXsPF65oeQUeGcJjdnRTIcSCGIyszpF3xWp1xer
C+1yizsincryInCczBcG0xeWxP8uOaJIRXSwiFUmxmWXLGJadWyw/e9JsmZ7CFTS
1P34KSiH8X1z/ivKq/gCJK++VDUph5bd7TZ9btBT5nvkyEI7IPR8Ct5fQQujGrA5
iX97yRmFNm0VDSWMJ/GkIalOnMWTNO+u/7GMmkPZIe52zAmtcod5lQZCWc/O0bPo
U7RMLAndXB1EwlZQsjkLqL40EO3BRyYJPOzQyXdD7KoFQHqgvOXT0xUFjTLDcITZ
8fmv/QftE3p9/HJ34d2FONOKvJ8OgIEGkYhb7ePYi+Sa5uCKbAQu0o/JXCTqmHMp
J3QFZmZbR1JRlv1MCLteb1YQmiHp0JXsfqja3YJvdBrDXn+8yj81mO551dDupsts
LZCpbbt/
=ef0j
-----END PGP SIGNATURE-----

--eaAbLsiGDq6wxOGS--
