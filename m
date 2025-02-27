Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65221C021B8
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 02:27:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B62EB805C3;
	Thu, 27 Feb 2025 03:27:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NQdzQywq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AC8C807FB; Thu, 27 Feb 2025 03:27:55 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2680F8006D
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 03:27:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-471fe5e0a80so4475081cf.1
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 18:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740623272; x=1741228072; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gOYDWZD5+TG2U2ASiTtQO9CtrF4FmwME5jqyhIo5nMk=;
 b=NQdzQywqaEcg94P2rAfZiYioualJv//HS3YMMlh+sgAcXlDK4yVUbmB/ui7t/7GNFk
 Qz9W/CgCX3HTcin2l4OtxS9JP8IjypOgilVh4KVWwU9YvE+8fpxcNuUWLTqG4yF8Jj2A
 WToGLjJvbpLRTJGE6Y6G1Ckit/bMDs4iSGga4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740623272; x=1741228072;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gOYDWZD5+TG2U2ASiTtQO9CtrF4FmwME5jqyhIo5nMk=;
 b=kEquXxR9kJcu2jDVREIKfqAUIrfoRtSAOgYGcLvoY17bwqVdvCIG/xAcxY5LdyuKsD
 9B1XjTAMH/qftwUnqeVm3r2VC5P82AU6N6l9uneU7TinA8G15Y3NFKFsyORX6+XeThhe
 j4orpm5oyQnsFcKeZCrRQsj7XydZ4DxvBmlWPmAALhSKmscxITgWr55L2ECUwAOSeYaf
 UUnBIRha9of86CSr7K5lCYYHqOTSmERQWzS8EuZNpyGsdZhfMxv+m/255xesjLqa+gDV
 G9aPZJzlltA9DhM1UF7DE+UMCkt5tJhmL+jQC2WOIrvnEjX/MqX5fYBr3AFQ7YaMudBs
 yjrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+OSfBKoQfMp1axxfxiEu6G/b7MzT/4fpWNqh4IuPH1n3eouF6PUxin+Zguc3zG+M5P6xvdcg=@lists.denx.de
X-Gm-Message-State: AOJu0YzglhsIxiowKs8G8fk331BjIwLjzWWN4cwyAMTZYCNt7+gAeAEX
 KW2MnSV1Av8sJoi8PP4AQKwck4hOqt0nCYjtYkOtxAcrZ3d7wRxh/92+ZP80gtc=
X-Gm-Gg: ASbGncsqM0QxoKTMTVGbV4J28sIP5opSgLsChhi3sg7rzwnsZgIXL8Gpq69PWPZM5y6
 hHx5zfuplu/JJqzNrcPBjS0SMVYMRnx58UGMGYxWmqMU4A7WSkoSeV05DHGZQYYeh7eNDT8ujBx
 ZKr9QEfvJPAfpEFp1XJQcmdf/D08nFlNyukugBCKdGrm4JDvCY6R5sBY5eZoWlW2dh9BxGUbWle
 BZ4Dis12lYq5yWGQEUthnUlI+hCEV64JIw1WAGyfs2MuU2AFSgQhn6MU1SrjKnHdIhFMjqhDGzh
 dF3uevA+k427hW3Hl6dGnNpm
X-Google-Smtp-Source: AGHT+IGDISTKwwQHEGleWZzhJ0ynJQH9k62ro5dt46xBFSHXyAeYexs+Peoa0Xmp0JVtX1XMGI128Q==
X-Received: by 2002:a05:6214:1c0d:b0:6e4:4331:aae0 with SMTP id
 6a1803df08f44-6e6b0035ebcmr309316186d6.1.1740623271960; 
 Wed, 26 Feb 2025 18:27:51 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e897634926sm4525136d6.9.2025.02.26.18.27.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 18:27:50 -0800 (PST)
Date: Wed, 26 Feb 2025 20:27:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, uboot-imx@nxp.com,
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 2/2] imx8mm: imx8mm_evk: fix BOOTSTD boot
Message-ID: <20250227022748.GS2640854@bill-the-cat>
References: <20250222121711.6697-1-peng.fan@oss.nxp.com>
 <20250222121711.6697-2-peng.fan@oss.nxp.com>
 <CAOMZO5Drcqztvz1jE634sumDZk6Rmw5RJ1GzvvkU0mPJoDg1RQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZUfmjN0WcrKPl1TI"
Content-Disposition: inline
In-Reply-To: <CAOMZO5Drcqztvz1jE634sumDZk6Rmw5RJ1GzvvkU0mPJoDg1RQ@mail.gmail.com>
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


--ZUfmjN0WcrKPl1TI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 07:47:03PM -0300, Fabio Estevam wrote:
> Hi Peng,
>=20
> On Sat, Feb 22, 2025 at 8:10=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.=
com> wrote:
> >
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Select BOOTSTD_FULL and BOOTSTD_BOOTCOMMAND
> > Correct DEFAULT_FDT_FILE
> > Correct env file for imx8mm_evk_fspi_defconfig
> >
> > Fixes: 364ba68ed1a ("imx: imx8mm_evk: Switch to BOOTSTD")
> > Reported-by: Ludwig Nussel <ludwig.nussel@siemens.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
>=20
> I have a problem with the bootstd conversion series.
>=20
> I have a Buildroot image that boots U-Boot 2025.01 on imx93-evk:
>=20
> U-Boot 2025.01 (Feb 26 2025 - 16:22:03 -0300)
>=20
> Reset Status: POR
>=20
> CPU:   NXP i.MX93(52) Rev1.1 A55 at 1700 MHz
> CPU:   Industrial temperature grade  (-40C to 105C) at 37C
> Model: NXP i.MX93 11X11 EVK board
> DRAM:  2 GiB
> Core:  199 devices, 24 uclasses, devicetree: separate
> WDT:   Started watchdog@42490000 with servicing every 1000ms (40s timeout)
> MMC:   FSL_SDHC: 0, FSL_SDHC: 1
> Loading Environment from MMC... Reading from MMC(1)... *** Warning -
> bad CRC, using default environment
>=20
> In:    serial@44380000
> Out:   serial@44380000
> Err:   serial@44380000
> switch to partitions #0, OK
> mmc1 is current device
> Net:   eth0: ethernet@42890000 [PRIME], eth1: ethernet@428a0000
> Hit any key to stop autoboot:  0
> switch to partitions #0, OK
> mmc0(part 0) is current device
> Scanning mmc 0:1...
> 65166 bytes read in 15 ms (4.1 MiB/s)
> Cannot persist EFI variables without system partition
> Loading Boot0000 'mmc 1' failed
> Loading Boot0001 'mmc 0' failed
> EFI boot manager: Cannot load any image
> switch to partitions #0, OK
> mmc1 is current device
> Scanning mmc 1:1...
> Found /boot/extlinux/extlinux.conf
> Retrieving file: /boot/extlinux/extlinux.conf
> 1: buildroot
> Retrieving file: /boot/Image
> append: root=3DPARTUUID=3D6d55b936-eeb3-49c5-9b61-b69a1207b761 rootwait rw
> Retrieving file: /boot/freescale/imx93-11x11-evk.dtb
> ## Flattened Device Tree blob at 83000000
>    Booting using the fdt blob at 0x83000000
> Working FDT set to 83000000
>    Loading Device Tree to 000000008fff3000, end 000000008ffff442 ... OK
> Working FDT set to 8fff3000
>=20
> Starting kernel ...
>=20
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x412fd050]
> [    0.000000] Linux version 6.12.16 (fabio@fabio-Precision-3551)
> (aarch64-buildroot-linux-gnu-gcc.br_real (Buildroot
> 2024.11-1133-g5a1515b5976a-dirty) 13.3.0, GNU ld (GNU Binutils)
> 2.43.1) #1 SMP PREEMPT Wed Feb 26 16:51:31 -03 2025
> ....
>=20
> If I flash U-Boot top-of-tree into the SD card, the boot fails:
>=20
> U-Boot 2025.04-rc3-00007-g57bbc4de75f6 (Feb 26 2025 - 19:35:55 -0300)
>=20
> Reset Status: POR
>=20
> CPU:   NXP i.MX93(52) Rev1.1 A55 at 1700 MHz
> CPU:   Industrial temperature grade  (-40C to 105C) at 36C
> Model: NXP i.MX93 11X11 EVK board
> DRAM:  2 GiB
> Core:  214 devices, 24 uclasses, devicetree: separate
> WDT:   Started watchdog@42490000 with servicing every 1000ms (40s timeout)
> MMC:   FSL_SDHC: 0, FSL_SDHC: 1
> Loading Environment from MMC... Reading from MMC(1)... OK

Did you reset the environment at some point to be the new default?

> In:    serial@44380000
> Out:   serial@44380000
> Err:   serial@44380000
> switch to partitions #0, OK
> mmc1 is current device
> Net:   eth0: ethernet@42890000 [PRIME], eth1: ethernet@428a0000
> Hit any key to stop autoboot:  0
> switch to partitions #0, OK
> mmc0(part 0) is current device
> Scanning mmc 0:1...
> 65166 bytes read in 14 ms (4.4 MiB/s)
> Cannot persist EFI variables without system partition
> Loading Boot0000 'mmc 1' failed
> Loading Boot0001 'mmc 0' failed
> EFI boot manager: Cannot load any image
> switch to partitions #0, OK
> mmc1 is current device
> Scanning mmc 1:1...
> Found /boot/extlinux/extlinux.conf
> Unknown command 'sysboot' - try 'help'
> EXTLINUX FAILED: continuing...

As the "EXTLINUX FAILED" message comes from the old environment distro
boot, not bootstd. And so that's what's calling sysboot.

--=20
Tom

--ZUfmjN0WcrKPl1TI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme/zaQACgkQFHw5/5Y0
tywniQwAuIEhqrXme1bgWXO4bev5w7uk1UU7waru7ib84ZwsLpPxw918Fp5bdgEQ
9CXVH2rcXij3dyBwvBVNtt7pltcLszUkXJQWmDjHEwnaif8iusAvH4PdGtkoo7mj
Kx3lAr78uPcupJnhvxy9voqqkOPAxCVldyW5m4DFJVLdqh+PHfE1ybVobe04vJ/U
isSup1rbolKOwdT37RtYPngZfRma33ftkvqVnHOqaz9VKY2WbpC1QvfeqzXNWlPm
hDJIgP19yRdAl65uNAuUKFs3VvL7lrxb0m2jOS/H7Q5BWdeFnMcf1RBKbI2DC1V8
GeW56bN0bphnZ6q01oaLy7wDw2DvMnfYumiQQjuc3FBRN0WVJT4D3R8r2fQetjaS
yVURjB16sRynGt6gHEAzZMwmePBGrn0J6hdVJiOShG9WtCuflsThFA1qZZW3ILmq
W+5d3SxjZDrtI7yOu7pajUACIBFSq3JXS2r1a9EiVs/S1/mfbAUgRJu0HbDye9IG
ZVEIhJ6d
=mYba
-----END PGP SIGNATURE-----

--ZUfmjN0WcrKPl1TI--
