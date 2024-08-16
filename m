Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A56CC3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 03:47:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BBAB88AC0;
	Fri, 16 Aug 2024 05:47:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rITxc3HJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B58588AC0; Fri, 16 Aug 2024 05:47:17 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27EF08847B
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 05:47:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2701c010388so299027fac.0
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 20:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723780024; x=1724384824; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Q5NerHMXepRyPGMb88lPuu0xSBYncMrVO/wdH8HQ2oY=;
 b=rITxc3HJimQZH/TByr9uEM7Ez/PKDECO7nakPuUj6yf8TS7I0TbfvXIOwj7gBx40JQ
 g+105iBUuAwQIy4vF4b7gn/JIzjfvQbdAPz4/p+mTHT1nuKeiwBTMi8h5OXiLNyMDh8A
 H2YrfcvsRYEBI0t9GmqZ/PzNNRcRim3sLGJyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723780024; x=1724384824;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q5NerHMXepRyPGMb88lPuu0xSBYncMrVO/wdH8HQ2oY=;
 b=bY2FwJR4HGiCEVA8CNfrK+h9zN6OVQIX5i3ZH5snr84nP5jtqLT9TtH5QiSq9nDK98
 T8z6gVLzztRpFX1s9SI2To1B2ux7AxaRh2A1Dnn+BjpE4j6wd1N2STCO8FYsEyGzVpcm
 A2VWqEWqmehISiYEpKX3Mm0c1PqPKTI6W2Nu0pZKaGpghKjKmKEMnT6eTjz0W4FKF1LH
 cCIdOoyXGTIp6rjFoZsR3as//uPItd1lDsJYebDesbRPJa1ftYSgV7ihuvUZ3fNraUdf
 +UIYmmFjbnjjOc6+/TgcdxY6+pQ01oQxWcIcPnULtPNRKNH7KDGaiuOH6BfYBW4qhGTq
 9q5g==
X-Gm-Message-State: AOJu0YwphXIv627rY8g962+tOTYIj4rLDHon8NxlH4dPizAxfVNdnYwO
 qiC7UnNtphwr6m4dbl3y92ArY9V2h4Jv2xldHRZoI0gFNBhTVD2hRPdp2Sc/uOg=
X-Google-Smtp-Source: AGHT+IH+jDGT3P3IVvtTjFt9l6Z+9c+3mEjWhRxwGybYiy4uDiJGduTGlZfQNAO65gqDSoMonLyKCg==
X-Received: by 2002:a05:6870:b907:b0:25e:23b4:cf3e with SMTP id
 586e51a60fabf-2701c5b218bmr1941328fac.44.1723780023693; 
 Thu, 15 Aug 2024 20:47:03 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-270044313f3sm714882fac.11.2024.08.15.20.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 20:47:02 -0700 (PDT)
Date: Thu, 15 Aug 2024 21:47:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Marek Vasut <marex@denx.de>,
 Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 06/21] mmc: Drop the blank line before accesses
Message-ID: <20240816034700.GX1626301@bill-the-cat>
References: <20240810205205.3403177-1-sjg@chromium.org>
 <20240810205205.3403177-7-sjg@chromium.org>
 <20240815170108.GU1626301@bill-the-cat>
 <CAFLszTgThyq1v+zP2z5znvzbZqTMQuNO1fkSP59KJ8BnZyiQEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rG8xPGiniDXi4wB5"
Content-Disposition: inline
In-Reply-To: <CAFLszTgThyq1v+zP2z5znvzbZqTMQuNO1fkSP59KJ8BnZyiQEg@mail.gmail.com>
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


--rG8xPGiniDXi4wB5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 09:34:38PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 15 Aug 2024 at 18:01, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Aug 10, 2024 at 02:51:50PM -0600, Simon Glass wrote:
> >
> > > Several mmc subcommand print a blank line before starting and after
> > > finishing. It isn't necessary to do both, so drop the first one.
> > >
> > > It is questionable whether these command should produce any output at
> > > all, but leave it for now.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  cmd/mmc.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/cmd/mmc.c b/cmd/mmc.c
> > > index 7244a90f4dc..ff7b8e555ba 100644
> > > --- a/cmd/mmc.c
> > > +++ b/cmd/mmc.c
> > > @@ -238,7 +238,7 @@ static int do_mmcrpmb_read(struct cmd_tbl *cmdtp,=
 int flag,
> > >       if (argc =3D=3D 5)
> > >               key_addr =3D (void *)hextoul(argv[4], NULL);
> > >
> > > -     printf("\nMMC RPMB read: dev # %d, block # %d, count %d ... ",
> > > +     printf("MMC RPMB read: dev # %d, block # %d, count %d ... ",
> > >              curr_device, blk, cnt);
> > >       n =3D  mmc_rpmb_read(mmc, addr, blk, cnt, key_addr);
> > >
> > > @@ -265,7 +265,7 @@ static int do_mmcrpmb_write(struct cmd_tbl *cmdtp=
, int flag,
> > >       cnt =3D hextoul(argv[3], NULL);
> > >       key_addr =3D (void *)hextoul(argv[4], NULL);
> > >
> > > -     printf("\nMMC RPMB write: dev # %d, block # %d, count %d ... ",
> > > +     printf("MMC RPMB write: dev # %d, block # %d, count %d ... ",
> > >              curr_device, blk, cnt);
> > >       n =3D  mmc_rpmb_write(mmc, addr, blk, cnt, key_addr);
> > >
> > > @@ -362,7 +362,7 @@ static int do_mmc_read(struct cmd_tbl *cmdtp, int=
 flag,
> > >       if (!mmc)
> > >               return CMD_RET_FAILURE;
> > >
> > > -     printf("\nMMC read: dev # %d, block # %d, count %d ... ",
> > > +     printf("MMC read: dev # %d, block # %d, count %d ... ",
> > >              curr_device, blk, cnt);
> > >
> > >       n =3D blk_dread(mmc_get_blk_desc(mmc), blk, cnt, addr);
> > > @@ -411,7 +411,7 @@ static int do_mmc_sparse_write(struct cmd_tbl *cm=
dtp, int flag,
> > >       if (!mmc)
> > >               return CMD_RET_FAILURE;
> > >
> > > -     printf("\nMMC Sparse write: dev # %d, block # %d ... ",
> > > +     printf("MMC Sparse write: dev # %d, block # %d ... ",
> > >              curr_device, blk);
> > >
> > >       if (mmc_getwp(mmc) =3D=3D 1) {
> > > @@ -455,7 +455,7 @@ static int do_mmc_write(struct cmd_tbl *cmdtp, in=
t flag,
> > >       if (!mmc)
> > >               return CMD_RET_FAILURE;
> > >
> > > -     printf("\nMMC write: dev # %d, block # %d, count %d ... ",
> > > +     printf("MMC write: dev # %d, block # %d, count %d ... ",
> > >              curr_device, blk, cnt);
> > >
> > >       if (mmc_getwp(mmc) =3D=3D 1) {
> > > @@ -484,7 +484,7 @@ static int do_mmc_erase(struct cmd_tbl *cmdtp, in=
t flag,
> > >       if (!mmc)
> > >               return CMD_RET_FAILURE;
> > >
> > > -     printf("\nMMC erase: dev # %d, block # %d, count %d ... ",
> > > +     printf("MMC erase: dev # %d, block # %d, count %d ... ",
> > >              curr_device, blk, cnt);
> > >
> > >       if (mmc_getwp(mmc) =3D=3D 1) {
> >
> > Did you confirm things look right still, on hardware?
>=20
> Yes that's why I decided to drop it. See here for example:
>=20
> $ ub-int ff3399
> Building U-Boot in sourcedir for firefly-rk3399
> Bootstrapping U-Boot from dir /tmp/b/firefly-rk3399
> Writing U-Boot using method rockchip
>=20
> U-Boot TPL 2024.10-rc2-00093-gcbaae70baf39 (Aug 15 2024 - 13:27:51)
> Channel 0: DDR3, 800MHz
> BW=3D32 Col=3D10 Bk=3D8 CS0 Row=3D15 CS1 Row=3D15 CS=3D2 Die BW=3D16 Size=
=3D2048MB
> Channel 1: DDR3, 800MHz
> BW=3D32 Col=3D10 Bk=3D8 CS0 Row=3D15 CS1 Row=3D15 CS=3D2 Die BW=3D16 Size=
=3D2048MB
> 256B stride
> Trying to boot from BOOTROM
> Returning to boot ROM...
>=20
> U-Boot SPL 2024.10-rc2-00093-gcbaae70baf39 (Aug 15 2024 - 13:27:51 -0600)
> Trying to boot from MMC2
> ## Checking hash(es) for config config-1 ... OK
> ## Checking hash(es) for Image atf-1 ... sha256+ OK
> ## Checking hash(es) for Image u-boot ... sha256+ OK
> ## Checking hash(es) for Image fdt-1 ... sha256+ OK
> ## Checking hash(es) for Image atf-2 ... sha256+ OK
> ## Checking hash(es) for Image atf-3 ... sha256+ OK
> ## Checking hash(es) for Image atf-4 ... sha256+ OK
> load_simple_fit: Skip load 'atf-5': image size is 0!
>=20
>=20
> U-Boot 2024.10-rc2-00093-gcbaae70baf39 (Aug 15 2024 - 13:27:51 -0600)
>=20
> SoC: Rockchip rk3399
> Reset cause: POR
> Model: Firefly-RK3399 Board
> DRAM:  4 GiB (effective 3.9 GiB)
> PMIC:  RK808
> Core:  308 devices, 29 uclasses, devicetree: separate
> MMC:   mmc@fe310000: 3, mmc@fe320000: 1, mmc@fe330000: 0
> Loading Environment from MMC... Reading from MMC(1)... *** Warning -
> bad CRC, using default environment
>=20
> In:    serial@ff1a0000
> Out:   serial@ff1a0000
> Err:   serial@ff1a0000
> Model: Firefly-RK3399 Board
> Net:   eth0: ethernet@fe300000
> Hit any key to stop autoboot:  0
> =3D> mmc read 1000 0 100
>=20
> MMC read: dev # 0, block # 0, count 256 ... 256 blocks read: OK
> =3D>
>=20
> With this patch, the blank line above is gone.

Ah thanks.

> BTW, this whole series is marked as needing changes. I've dropped the
> wget patches. Should I send it again, or just wait?

Yeah, wait a bit for other feedback, esp from the corstone-1000 people,
and repost.

--=20
Tom

--rG8xPGiniDXi4wB5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma+y7EACgkQFHw5/5Y0
tyzdLgwAr0vawSSq4r8mr+LLJfaVW1a7i720p1Neo0JkmyOkZ/T1jaU/51oCX21n
ufI/bgbPJDCCWd9nE6vDgaqfguF/JC2zSuVfaEtoJT/w0vyqV3hjYiN5y0dAdmmu
PG7CL/Wlc9+osDGdlvbYu7WvkL/qOp1DcffnntwHSWoRl+iPqufmYTTMr/h78axR
uvbKu4HCyfL2UY5Esv8OBTT3LCh6NzaT+i4t4lfjOkgjOMFv/U/CNIi2eLVbOa2n
Wbyp+ueqNqipnYLIAxYzUzAhjPBDW8hcne4fdDKfQn+tH+Zo79DUNTdV6MPaCkiE
1vrIpRhgyLADUTb0/VOOAiqj2mHCAiMtmj3clxBBU4gc50qh/QOObo3eHOLxwadp
n08XwDScwBfrgaKhiapWXPh+7giFm4a5GLcklrkUQKf5FRbpzMhWJDromCuMovWI
8cZbVwMTx0gVmKCbMvsXdog5f8g/RUR75seZaIo41qmdWQoHLAJ60cx7WM8bqFHV
P8F/JiSN
=9Y8L
-----END PGP SIGNATURE-----

--rG8xPGiniDXi4wB5--
