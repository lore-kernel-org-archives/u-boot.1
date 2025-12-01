Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EBE5D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 17:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B096E83C93;
	Mon,  1 Dec 2025 18:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SWktSZs0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9E1B83C93; Mon,  1 Dec 2025 18:47:06 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EFC983C6C
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 18:47:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-3ece54945d9so1016932fac.0
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 09:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764611223; x=1765216023; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PWn/6Cf1+sh5TIB/DBcDaEpZ0Dj+V3tnv0x92S2CSDo=;
 b=SWktSZs0t4dT/khIkMZQ6Da8ITkuLT3aEfMszz1T9VCbUN5MtYZ97QOYMx8zEjipAv
 4/iOCbg1MOuFZgaW43sWQfkZzbIbF/dSoysPTGzy4v+nc9p5MVCY9FWEaOnLOThfI+ld
 WenC7Q6d4tLYzs5MePo/bqkFLdyF7deX4usNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764611223; x=1765216023;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PWn/6Cf1+sh5TIB/DBcDaEpZ0Dj+V3tnv0x92S2CSDo=;
 b=jyGJ9uN+tdLmMK0sLuTZsXl3n6SiyBK4Q1fOyb96znKv0ORNC+BetFDd3573PV+1MO
 bv6qmSFk3AQEcM1awv3FRSlVGC/yH9TpK7yJR0UzK0Jd02WaIUGG+FbFhiyFueiGDqie
 RkcvwDLK4EhrX3jZCADx8u1EISVjaCx28eMifL1kZF2FOphL41qoLtuN1hMcH/uUZMGw
 IuFCW403m5WFIQ61Hu1xcEBZP63h+TTNv6Pq7KojhatxyK2fGGJwrbnGCPYJd6JjOKer
 luiKkI0u59aHukI5oiFmcPvayepYo9tpEBu3dIv1Q47RVOM5lgSoUdw1a6cnWvCDy6r+
 fDGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgy2WEMNeinr62EJk04HgQVTODfd/fG9fXRQl34sKwKRHEgQPe3PcJEoLfXXVI07tgkep5F0g=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1Omjs6xmGPh4Ry1pj5MzkYiQ8q1X6oxJSZUEcvIsWb3r60OFC
 NjUJmck6KISJTIztTpry1u0NbJIuMNJhY7RDOcv/kah9Q0CVlp2ftuApxxIdTzWRn1c=
X-Gm-Gg: ASbGncv+UrXaD/zr+uyZnmjxeLyt33WmVizIDGFa+4Fddcc9iIva77HV1lKFL8mbsln
 JHF4uR6G2PFOmIAe0n+0XG7dKjCLVT88KO8PhOQPgIDG/ULijxwq2Oe1wHSg8RuKnpoWt55NdOx
 Ivznn/8jgXqDVJEup8srNzvuKBpiANFzeelb6aMfVLfZ6xJFXedmucwiyqrvgySGSu/T/5aN11U
 JR8vj7hsAP+8x9csxlTEeuEc8gOXttB81Xif6rWdrGfhSwdR2AngncQrI/OIRI9PxmHjvejpHXw
 YsVefnkZbDchLms/WRHZU1gC/QmQ29X3fuGW7IYxcH+sQmbL4aKJCqKKztTSbFbpgdrm0ntj6SE
 oHuwnbRd7OW2a5Eu2t+fHG9KrAOey9k5P3nMGTdpPVBjq6W7XmSb7vUaluTpol+i7286X7oyc3V
 lCNqy1n7u9/NOyqdLmqCU9JS/VxZa/8fIkYfFeyAePJNr4ZSPrpQ==
X-Google-Smtp-Source: AGHT+IFszcnudV2/UqIPh9Xcti+hWmyQUCzhS+DtCOdAGtuyYmiZIR3Q4sVZaXeThxGXhRBhZ0duFQ==
X-Received: by 2002:a05:6808:1891:b0:44f:e61d:189f with SMTP id
 5614622812f47-45115865582mr15602182b6e.13.1764611223221; 
 Mon, 01 Dec 2025 09:47:03 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-453169f9f62sm3960171b6e.8.2025.12.01.09.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 09:47:02 -0800 (PST)
Date: Mon, 1 Dec 2025 11:47:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
 Chee Tien Fong <tienfong.chee@altera.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] Fix socfpga GEN5 boot by spl+u-boot sfp on RAW
Message-ID: <20251201174700.GM303283@bill-the-cat>
References: <20251129064818.1587-1-briansune@gmail.com>
 <20251201165122.GH303283@bill-the-cat>
 <CAN7C2SAGqRqd-TXpp-ALrDzbsgBmLaxywGbw6j9w0MZipEQHnA@mail.gmail.com>
 <20251201170534.GK303283@bill-the-cat>
 <CAN7C2SBn6pq9DBO2GezyWcUVB6iZb-wQgmFyJF2ph7hV4WmiQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5jOCZEzdQppxRGgi"
Content-Disposition: inline
In-Reply-To: <CAN7C2SBn6pq9DBO2GezyWcUVB6iZb-wQgmFyJF2ph7hV4WmiQQ@mail.gmail.com>
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


--5jOCZEzdQppxRGgi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 02, 2025 at 01:14:43AM +0800, Sune Brian wrote:
> Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B412=E6=9C=882=E6=97=
=A5=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=881:05=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Tue, Dec 02, 2025 at 01:01:48AM +0800, Sune Brian wrote:
> > > Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B412=E6=9C=882=E6=
=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:51=E5=AF=AB=E9=81=93=EF=BC=9A
> > > >
> > > > On Sat, Nov 29, 2025 at 02:48:18PM +0800, Brian Sune wrote:
> > > >
> > > > > Thanks to Jan Kiszka had provided info on
> > > > > u-boot is not able to boot by u-boot-with-spl.sfp.
> > > > >
> > > > > All three TYPE, NUM, OFFSET mode methods
> > > > > are nonfunctional on combined raw boot.
> > > > >
> > > > > The major cause is spl+u-boot structure is
> > > > > defined as 4x[spl+zero_pad] + u-boot.img.
> > > > > Deal to this configuration since GEN5 is used,
> > > > > the spl would require to seek by an offset
> > > > > on top of the spl offset. This means for
> > > > > each spl=3D0x10000 the offset is 0x40000.
> > > > >
> > > > > However latest u-boot do not consider this
> > > > > major structure on GEN5 socfpga.
> > > > > Meanwhile, the default include file as Jan
> > > > > pointed out is completely wrong syntax and
> > > > > caused issue.
> > > > >
> > > > > Combining both concepts, the minimum fix
> > > > > patch is provide as follows.
> > > > >
> > > > > 1) Offset is control and default set to a
> > > > > proper offset under:
> > > > > SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET
> > > > >
> > > > > 2) Only GEN5 socfpga will be affected and
> > > > > minimized contamination on other devices.
> > > > >
> > > > > 3) Only one compuatation adjustment is made
> > > > > on spl_mmc_load. And simply introduce the
> > > > > offset adding by the kconfig offset control.
> > > > > It should be 0 by default and gate as well.
> > > > > So no possible harm should be done.
> > > >
> > > > This sounds like a tricky problem to solve in a "nice" looking way.
> > > >
> > > > The first thing that's unclear to me is, which of
> > > > SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR,
> > > > SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION or
> > > > SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION is being used here?
> > > >
> > > > --
> > > > Tom
> > >
> > > Hi Tom.
> > >
> > > This issue all happened due to the old "u-boot-with-spl.sfp" structur=
e.
> > > The old auto generated u-boot-with-spl.sfp that file itself has spl x=
4 and
> > > zero padding. then it inserts u-boot.img.
> > >
> > > All are user dependent and have no restriction from the beginning.
> > > SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR any sector with A2 type.
> > > SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION any partition with A2 type.
> > > All are completely dependent on the user SD MMC setup.
> > > So users can even use the last sector aka the most end of the SD MMC.
> > >
> > > That's why it is so tedious. And users even allow to simply use u-boo=
t-spl.sfp
> > > Then manually use dd  command to an offset that is in the A2 partitio=
n and
> > > load the u-boot.img
> > >
> > > I didn't even like this idea and that's why I changed to the FAT boot=
 method
> > > after 2025.07.
> > > I simply bypassed the inherent issue that Jan was faced with.
> > >
> > > So long story short either completely drop this old compatible boot f=
low or
> > > do it in a very tedious way aka spl offset on top of u-boot.img offse=
t.
> >
> > Well, wait, this doesn't make sense. The first thing is you pick which
> > of the three I asked about as to how to find everything else at boot. We
>=20
> But I am afraid that is the case. You can actually use any one of three o=
ptions
> to boot. The requirements on Altera Cyclone V or Arria V GEN5 socfpga req=
uire
> a A2 partition to seek the SPL. So this involved "TYPE" and "PAR NUM".
> Then for the complete RAW setup it simply just uses the sector offset.
>=20
> > don't need to support all three, we need to support one of them. I
> > suspect the first thing is we need a default one-of-those if SYMBOL.
> > This is what we do for MVEBU platforms which have, I suspect at least, a
> > similar odd constraint.
> >
> > --
> > Tom
>=20
> That's why I don't even like to count debugging from first place after  2=
025.07.
> SPL on A2 partition u-boot.img on FAT32 boot very fine and no issue.
> You don't even need to consider the u-boot.img offset on top of SPL offse=
t.
> Very clean.
> Jan proposed to fix the RAW backward support on the old combined
> u-boot-with-spl.sfp boot method, which is completely not a must.
>=20
> Hope this clears up some confusion.

Yes, thanks. And I think I prefer the way Jan has handled these problems
in his series, rather than this approach.

--=20
Tom

--5jOCZEzdQppxRGgi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaS3UkQAKCRAr4qD1Cr/k
ChBLAP9lUZ/L/33AeaPfA7PyDr97f0pAOOPsJ9K2COzSxIAk9gD/SjnSY9bcYaqU
qmeTTyZXEtWqIv6ObkotcsLIHXNERg8=
=DKHa
-----END PGP SIGNATURE-----

--5jOCZEzdQppxRGgi--
