Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA97D29C4D
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 19:18:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FC138313B;
	Mon, 19 Jan 2026 20:18:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PKa0QC5P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF8158389A; Mon, 19 Jan 2026 20:18:47 +0100 (CET)
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com
 [IPv6:2001:4860:4864:20::41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B37198003E
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 20:18:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x41.google.com with SMTP id
 586e51a60fabf-4044854464fso2314566fac.3
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 11:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768850324; x=1769455124; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lynf1XvKw1yNEI/bjsyS56lhxBpfv1KjTSwULzLYuFk=;
 b=PKa0QC5PAXDWNZmh5JzCBWDT485brTEfDL8p+T4sizILQvySVHa2eC/XtvbcPHa0Ew
 CP1Bqy7YzBqbI8BkmTlTGbynvO3ocITuqyxc0Q8z3ZmDoQSm8uC7TKo/RCDqmbinbqUd
 1immspspQI0Kv3ei4ZXMckWjOhFp4LufXkjt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768850324; x=1769455124;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lynf1XvKw1yNEI/bjsyS56lhxBpfv1KjTSwULzLYuFk=;
 b=lMxQq0bxEd19M/p0MzKSEkonmM9GvlRrtXL1npUT28cG3t4K6v0z+Tr50/+7aLeP6M
 hhqTjxlcqzBQ3on2UEYqO0+BwivYHtu9gUeTJW5oIn4Y+k6/L+LMFie3R3/I2TIsi0pl
 0n1Ft+Go2J5ZRnhuRStBAsn5N1mfxEGqq6kRgnsZZaBRfU68TVhVi4HZwbIGv5be6K2m
 bKFz5UbDBI9waSa0IR23p30OUSOh3Y9lVuAV6DW+Hlq9jxM9Y7BbYLGIZeUZTM4vzZ/H
 hX5gCkyUw9QgUiOoL5DHfe9pihv5ME8qzF/fmkhro0DvUn7hqJgDNTbioGtHeD/Lpvx+
 PDHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS+JldZsCEy+N9ifAuQgtwBHR7EQs7vGQqlAoO5gkWdIcgbAEEZAW9otg9mCbMTAqvAlmqMIk=@lists.denx.de
X-Gm-Message-State: AOJu0Yzp5ATx5FTx27V/VwMKJFg4ROCBGOHFmwVLhZOCrM9N2N/ZkXxl
 yTUEQxxSm8xtkSfoPLbrB4Brxl6UK6pyLeGPvYqL2QJGH0Y3x5CzTSld/Qyq7lc0GPM=
X-Gm-Gg: AZuq6aJe2OwGhewxFZkL9RVjj5GLAtc3yEoZv+Bx4RhbYw376jJHW/L4T52vqR2GC/r
 x9HnegoinF8FL6O8WtRjT+CWX/yKazlDcxvqz1QFTLRp1uP6IHDM4M+UvE1+5Vu1uSi+U/VMfrl
 TkX9X9zOeiHv6cI9cXTeFX4babrwuJtVkQMKE8QbBQqcX4k7FL9fMNKGDrWo6FKO7CsU3k+8ZV5
 Te8NtiZQupS4zYnW9PoGGDaiP1nijuYus+UIyHR/bi/0xJ50F7zIZ3Q8SP1e8bpBRSHvpB+qGVL
 g1km8k5sJYcHFlELhbl6chEwlfK0Ak7WG+8CTTh0qImuKsXenjsg2GVO5qhQlGKPyFpaYdeH2BQ
 JMTGaH6Gc7t+dlZ5klPMxJzTUn86OTrNgnWMjQja6ol3+TVCZQMN0oiBk6tEkde+bnrDOekCtkB
 2tyRaARpN6C6hMSYS9EYyQfnqQiLiTx5RySzn+eBd12girqSLublbu8O9INoTXzOYHDIURtGq2Z
 uO+s81+z2pJEfLyi8gNNC/GFQR5mT5UmLc0Ars=
X-Received: by 2002:a05:6870:14d5:b0:3ec:44ca:ca33 with SMTP id
 586e51a60fabf-4044c157402mr6252799fac.4.1768850324341; 
 Mon, 19 Jan 2026 11:18:44 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4044bd5d988sm7224341fac.18.2026.01.19.11.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 11:18:43 -0800 (PST)
Date: Mon, 19 Jan 2026 13:18:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Vagrant Cascadian <vagrant@debian.org>, u-boot@lists.denx.de,
 Green Wan <green.wan@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] board: unmatched: Workaround failure to find .dtb file.
Message-ID: <20260119191841.GE3416603@bill-the-cat>
References: <877bteqx7y.fsf@wireframe>
 <e406ccb2-670c-481a-a128-d25a8973341b@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AslTDaYk6t4Ti+wG"
Content-Disposition: inline
In-Reply-To: <e406ccb2-670c-481a-a128-d25a8973341b@mailbox.org>
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


--AslTDaYk6t4Ti+wG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 07:42:59AM +0100, Marek Vasut wrote:
> On 1/19/26 1:09 AM, Vagrant Cascadian wrote:
> > The fdtdfile variable contains quotes:
> >=20
> >    printenv fdtfile
> >    fdtfile=3D"sifive/hifive-unmatched-a00.dtb"
> >=20
> > But this leads to issues which booting with an extlinux.conf format
> > file failing to find the .dtb file:
> >=20
> >    Retrieving file: /usr/lib/linux-image-6.12.63+deb13-riscv64/"sifive/=
hifive-unmatched-a00.dtb"
> >    Skipping fdtdir /usr/lib/linux-image-6.12.63+deb13-riscv64/ for fail=
ure retrieving dts
> >=20
> > Other platforms (e.g. rockpro64-rk3399) do not contain quotes in the
> > fdtfile variable, and work properly out of the box.
> >=20
> > The workaround suggested by marex is to hard-code the correct .dtb
> > value, which works for me.
> >=20
> > This has been present at least since version 2025.01, also present in
> > 2026.01. I have not yet tested against git master branch.
> >=20
> > This could probably be properly fixed by stripping the quotes in
> > whatever processes the .env file. There are numerous other boards that
> > have the same way of setting the fdtfile variable, which might
> > similarly be effected by this issue.
> >=20
> > Signed-off-by: Vagrant Cascadian <vagrant@debian.org>
> >=20
> > Not sure who all to CC on this, please feel free to forward
> > appropriately!
>=20
> ./scripts/get_maintainer.pl -f board/sifive/unmatched/
>=20
> produces a few names, added
>=20
> > ---
> >   board/sifive/unmatched/unmatched.env | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/board/sifive/unmatched/unmatched.env b/board/sifive/unmatc=
hed/unmatched.env
> > index 34425dc9efa..cdba2c8ae0e 100644
> > --- a/board/sifive/unmatched/unmatched.env
> > +++ b/board/sifive/unmatched/unmatched.env
> > @@ -16,4 +16,4 @@ partitions=3D
> >       name=3Dloader1,start=3D17K,size=3D1M,type=3D${type_guid_gpt_loade=
r1};
> >       name=3Dloader2,size=3D4MB,type=3D${type_guid_gpt_loader2};
> >       name=3Dsystem,size=3D-,bootable,type=3D${type_guid_gpt_system};=
=20
> > -fdtfile=3DCONFIG_DEFAULT_FDT_FILE
> > +fdtfile=3Dsifive/hifive-unmatched-a00.dtb
>=20
> Also +CC Peng because iMX is also affected.

I'm setting aside the question of why we have both DEFAULT_FDT_FILE and
DEFAULT_DEVICE_TREE and pointing to:
commit d085e692c98d0d7b57cc577ed9befda159cd4a40
Author: Simon Glass <sjg@chromium.org>
Date:   Wed Nov 13 08:09:37 2024 -0700

    env: Provide a work-around for unquoting fdtfile
   =20
    Some boards use a CONFIG option to specify the value of this variable.
    This is normally handled by efi_get_distro_fdt_name() but in the case
    of sunxi this does not work, since 'soc' is sunxi, but the files are
    in the allwinner directory.
   =20
    Provide a work-around for this particular case.
   =20
    Signed-off-by: Simon Glass <sjg@chromium.org>
    Reviewed-by: Tom Rini <trini@konsulko.com>

As how to address this issue as well, unless someone discovers something
still more clever to deal with quoting.

--=20
Tom

--AslTDaYk6t4Ti+wG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaW6DiQAKCRAr4qD1Cr/k
Cr86AP4two7pS4oBdzzS/L0bqKJGr99XsCG0JgnTCqeCTrZJKAD+O91T6Au7h/fr
R5D5yOiwgNTy2HUP5FbeOGSnx5AGtgk=
=JDkw
-----END PGP SIGNATURE-----

--AslTDaYk6t4Ti+wG--
