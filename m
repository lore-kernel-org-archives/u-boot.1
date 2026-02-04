Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41D5EA7946
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 21:50:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC1C38341A;
	Wed,  4 Feb 2026 22:50:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SbI3ATZD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D66B5838FA; Wed,  4 Feb 2026 22:50:23 +0100 (CET)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B1AF83015
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 22:50:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7d1866473b0so163267a34.1
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 13:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770241820; x=1770846620; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wXGAvLGfK5GEfsURCfVCW7Mcdw32OW4lFs57LA8pC1M=;
 b=SbI3ATZDwU7MYyXagejuG/R0ukIDO1EQ+R4sbtup1M5ewi1ciUA7UPXH1wC+GQ54oK
 DHJ3PlhOeqQTTmmdaVMc/OBKZF2s60dFwt/nQkAbjNQNrDrN7x/+qcL5ugncKYvZr3dH
 WCpJizwRHG9BUWZq3pBpebWLB50kkZqqHBgIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770241820; x=1770846620;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wXGAvLGfK5GEfsURCfVCW7Mcdw32OW4lFs57LA8pC1M=;
 b=sLmolQbAb+8XS6AgRnV1DpipEz6/9jZj9cMWWmVViX5UZ2QtPh/y7wOMmMHMdJe1EA
 uf6xMZA157Xj71XStjogGrdL68j1ILdNwRtveoTckp95Zh68RmnrCRhZfBsXzALlbkii
 1DnjFqVvDFjOdu9SxGWR5Q/HCrPPrGXYI0iCZivfQKeo3Cn0V/PIzBEREqNuGpqGOFtU
 1XnArqG3lcN6iQWJRN2yxsCsw8sTbIQQQt+mEowisPApcaahv5oi2neMZ7zwD3vbqZww
 JWhuDQbDxklnOEq6LIifo+sNH413r9S2Ukn1w5mIoEpEDyTrGBcfJpeuaEcwfisOLpsK
 JMKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6UV8v2zJ3MLByYW/Vi3MuY9nz/miYNW9k8dSpWVeemJi6DRSptihZ8q/lnO5omnqKHD/vkFI=@lists.denx.de
X-Gm-Message-State: AOJu0YzZBJTFtizMBHkclob3NQfWaJcAkaKEJoxpwAF9yr73VdvKYoCi
 XJeVzrWnxdYqkpQiwXFaSipJYEtWgBa0zoYoloaAq3J0vRVLanGKvXigpg9WL5Fk/3I=
X-Gm-Gg: AZuq6aKRDuGLip29t61hWtSzPlVrIvviwIForQ/0Q/VxtBZYCPZBFmvFdpe2AnoQTn7
 RNSRQ3tCSPoSYmXC+t+icyOEUWQzZk29KmCN/Hd3hoyEYedvilh6C/AvtTiLuwzFh3L5ONdnfQI
 06wmGo9DleNtbxgZ/+ggIOvkGYwByXwrsoEY7wqtqR7qFp3ZU3yoPES2ulqQcsJvuuQBuVqtZu7
 0SBh7IasQFl8O8YToq/jIuoA/VlJOtP5kjGOW/RJkXhV5w77m2wuSybxP5IjGG+Zm9OGn42oIuc
 pipEqAqOtIOoIfuTBtDqklz4hEt2vjQGE51XQ52O2YYfWQl619SDV0+Et2LPjZI6Slj/zXa61LE
 M812qOzDhE46KwrAcPxIQ04yQ5zeDBjoueWVmTOeYHr5To9jOet1rWot92ptdXmF6tEaLu5njfn
 lAF6dVRUZSlzxYS7Jz2u0xg7CpdP/iWVfrMFgn7TwzDLhZLipHYRTLTj7Zbks4icn66GFdO7fzT
 uvuaii+UFr7BlruHodicOL4Y8u/xznhMGEPSI8=
X-Received: by 2002:a05:6830:90e:b0:7c7:65f4:1120 with SMTP id
 46e09a7af769-7d448a79db6mr3240713a34.23.1770241819790; 
 Wed, 04 Feb 2026 13:50:19 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d44913b553sm2449409a34.13.2026.02.04.13.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 13:50:19 -0800 (PST)
Date: Wed, 4 Feb 2026 15:50:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Phil Sutter <phil@nwl.cc>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Beleswar Padhi <b-padhi@ti.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, Joel Stanley <joel@jms.id.au>,
 Kever Yang <kever.yang@rock-chips.com>,
 Michal Simek <michal.simek@amd.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Stefano Babic <sbabic@nabladev.com>
Subject: Re: [PATCH 02/10] arm: Update linker scripts to ensure appended
 device tree is aligned
Message-ID: <20260204215016.GF2603314@bill-the-cat>
References: <20260115222828.3931345-1-trini@konsulko.com>
 <20260115222828.3931345-3-trini@konsulko.com>
 <aYO3HOmFFVAkjfKD@orbyte.nwl.cc>
 <20260204212010.GD2603314@bill-the-cat>
 <aYO5r8Na5-fRYHgA@orbyte.nwl.cc>
 <20260204213139.GE2603314@bill-the-cat>
 <aYO8vDPa522pttDV@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1RCZ5xRLuKWEWA8i"
Content-Disposition: inline
In-Reply-To: <aYO8vDPa522pttDV@orbyte.nwl.cc>
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


--1RCZ5xRLuKWEWA8i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 04, 2026 at 10:40:12PM +0100, Phil Sutter wrote:
> On Wed, Feb 04, 2026 at 03:31:39PM -0600, Tom Rini wrote:
> > On Wed, Feb 04, 2026 at 10:27:11PM +0100, Phil Sutter wrote:
> > > On Wed, Feb 04, 2026 at 03:20:10PM -0600, Tom Rini wrote:
> > > > On Wed, Feb 04, 2026 at 10:16:12PM +0100, Phil Sutter wrote:
> > > > > Hi,
> > > > >=20
> > > > > On Thu, Jan 15, 2026 at 04:19:32PM -0600, Tom Rini wrote:
> > > > > > With commit 0535e46d55d7 ("scripts/dtc: Update to upstream vers=
ion
> > > > > > v1.7.2-35-g52f07dcca47c") it is now a fatal error to U-Boot if =
our
> > > > > > device tree is not 8-byte aligned. In commit f613a6e15ef7 ("ARM=
: OMAP2+:
> > > > > > Pad SPL binary to 8-byte alignment before DTB") Beleswar Padhi =
explains
> > > > > > that we must have ALIGN(x) statements inside of a section to en=
sure that
> > > > > > padding is included and not simply that the linker address coun=
ter is
> > > > > > incremented. To that end, this patch:
> > > > > > - Expands some linker sections to be more readable when adding =
a second
> > > > > >   statement to the section.
> > > > > > - Aligns the final section before _end (for U-Boot) or
> > > > > >   _image_binary_end or __bss_end (for xPL phases) by 8-bytes by=
 adding
> > > > > >   '. =3D ALIGN(8);' to the final section before the symbol.
> > > > > > - Ensure that we do have alignment by adding an ASSERT so that =
when not
> > > > > >   aligned we fail to link (and explain why).
> > > > > > - Remove now-spurious  '. =3D ALIGN(x);' statements that were i=
ntended to
> > > > > >   provide the above alignments.
> > > > > >=20
> > > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > >=20
> > > > > For unclear reasons, this seems to break boot via xmodem protocol=
 on my
> > > > > Synology DS414. I found this commit via 'git bisect'. The symptom=
 is:
> > > > >=20
> > > > > | kwboot version 2026.04-rc1-00098-g6ad0cf8f83db
> > > > > | Detected kwbimage v1 with SPI boot signature
> > > > > | Patching image boot signature to UART
> > > > > | Aligning image header to Xmodem block size
> > > > > | Sending boot message. Please reboot the target...\
> > > > > | Sending boot image header (67584 bytes)...
> > > > > |   0 % [........................................................=
=2E.............]
> > > > > |  13 % [........................................................=
=2E.............]
> > > > > |  26 % [........................................................=
=2E.............]
> > > > > |  39 % [........................................................=
=2E.............]
> > > > > |  53 % [........................................................=
=2E.............]
> > > > > |  66 % [........................................................=
=2E.............]
> > > > > |  79 % [........................................................=
=2E.............]
> > > > > |  92 % [......................................                  =
              ]
> > > > > | Done
> > > > > | Missing DTB
> > > > > | spl_init() failed: -2
> > > > > | ### ERROR ### Please RESET the board ###
> > > > > |=20
> > > > > |=20
> > > > > | xmodem: Connection timed out
> > > > >=20
> > > > > Debug printf()s in fdtdec_prepare_fdt() show that fdt_check_heade=
r()
> > > > > returns -FDT_ERR_BADMAGIC.
> > > > >=20
> > > > > With HEAD at a8d982e1f1726 ("x86: cpu: Fix crash on FTRACE enabled
> > > > > builds"), reverting arch/arm/cpu/u-boot-spl.lds like so:
> > > > >=20
> > > > > | @@ -41,14 +41,21 @@ SECTIONS
> > > > > |                 __binman_sym_start =3D .;
> > > > > |                 KEEP(*(SORT(.binman_sym*)));
> > > > > |                 __binman_sym_end =3D .;
> > > > > | -               . =3D ALIGN(8);
> > > > > |         }
> > > > > | =20
> > > > > | +       . =3D ALIGN(4); /* critical! */
> > > > > |         __image_copy_end =3D .;
> > > > > | +       .rel.dyn : {
> > > > > | +               __rel_dyn_start =3D .;
> > > > > | +               *(.rel*)
> > > > > | +               __rel_dyn_end =3D .;
> > > > > | +       }
> > > > > | +
> > > > > | +       . =3D ALIGN(8);
> > > > > |         _image_binary_end =3D .;
> > > > > |         _end =3D .;
> > > > > | =20
> > > > > | -       .bss : {
> > > > > | +       .bss __rel_dyn_start (OVERLAY) : {
> > > > > |                 __bss_start =3D .;
> > > > > |                 *(.bss*)
> > > > > |                  . =3D ALIGN(8);
> > > > >=20
> > > > > The SPL image starts up again and continues loading the real uboot
> > > > > image. Note that I have no idea what these changes actually do, s=
o I
> > > > > need instructions if I should dig further.
> > > >=20
> > > > Does:
> > > > https://patchwork.ozlabs.org/project/uboot/patch/20260130183635.261=
2933-1-trini@konsulko.com/
> > > > fix it?
> > >=20
> > > Sadly not, same result.
> >=20
> > Ugh. What file, specifically, do you send via xmodem? And so that maybe
> > I can more easily replicate the failure, are you using the kernel.org
> > gcc-14.2.0 toolchain or something else?
>=20
> I am building with a custom-built arm-openadk-linux-uclibceabi-gcc
> version 14.3.0. Basically what I run is:
>=20
> MYENV=3D'ARCH=3Darm CROSS_COMPILE=3D~/git/openadk-ds414/toolchain_synolog=
y-ds414_uclibc-ng_softfp_eabi_arm/usr/bin/arm-openadk-linux-uclibceabi-'
>=20
> make $MYENV clean && \
> for f in $(ls u-boot*.kwb 2>/dev/null); do rm $f; done && \
> make $MYENV ds414_defconfig && \
> make $MYENV -j12 && \
> ./tools/kwboot -a -t -p -b u-boot-*spl.kwb /dev/ttyUSB0
>=20
> With current uboot, this should be u-boot-with-spl.kwb image.
>=20
> With said patch reverted (or the above changes applied), I produce a
> working u-boot-with-spl.kwb which loads and boots linux from flash. So
> my toolchain is at least not totally broken. ;)

Right, so, for background, the following threads might shed some light
on things:
https://lore.kernel.org/u-boot/CAOMZO5DZNJ+=3DAP1spWCv7Ar6etf03H=3DDFVU=3Dm=
XZcC7QFTGoh_Q@mail.gmail.com/
https://lore.kernel.org/u-boot/20260123161907.392211-1-festevam@gmail.com/

And so to that end, can you please do:
hexdump -Cv u-boot-with-spl.kwb | grep 'd0 0d fe ed'
and let me know what that says? And the first line there should match,
content-wise at least (but not quite file offset) spl/u-boot-spl. I was
asking about your toolchain because with gcc-14.2.0 from kernel.org:
$ hexdump -Cv /tmp/ds414/spl/u-boot-spl | grep 'd0 0d fe ed'
00002ed0  6f f0 12 00 70 47 00 bf  d0 0d fe ed 00 29 05 db  |o...pG.......)=
=2E.|
$ hexdump -Cv /tmp/ds414/u-boot-with-spl.kwb | grep 'd0 0d fe ed'
00001ed0  6f f0 12 00 70 47 00 bf  d0 0d fe ed 00 29 05 db  |o...pG.......)=
=2E.|

And while this should then *work* that's luck and not design. If you can
confirm that instead 'd0 0d fe ed' is in the middle (and so 4 byte but
not 8 byte aligned) it'll at least be the same symptom as before.

--=20
Tom

--1RCZ5xRLuKWEWA8i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYO/FQAKCRAr4qD1Cr/k
Cm6sAP9tNLWfoa3GjeOffPcd7V+O505BSdxiKzZqK+PQmWN0QQD/TeZMYF0jc1Mz
sMPkiRvXoyEdeYL9DCvCuWVUr0p83Q8=
=aE3t
-----END PGP SIGNATURE-----

--1RCZ5xRLuKWEWA8i--
