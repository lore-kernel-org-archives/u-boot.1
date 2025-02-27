Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92E6C021B8
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 00:55:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D08D808A2;
	Thu, 27 Feb 2025 01:55:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QFVrVn75";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F17BC808A2; Thu, 27 Feb 2025 01:55:32 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0401801FB
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 01:55:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7c0ac2f439eso48981685a.0
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 16:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740617729; x=1741222529; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SCM/SHQUaX07ZK9wOQI9o4MwxKRK9LYJCLXSjuaJ99s=;
 b=QFVrVn75cNyf0JWQcTe/JRV41oFhDYB0IebA2DLa9EhCF2ejZ3TUQ8/JaaGHPYrDnP
 4JlwZqAMffH9UfTd3PmkXx8/lpj+IfClg+K6so4dnIb6DYz18ja7Buiag/r6vQ3iokwR
 VH+YIpQya5Zi88c6qDyM0o/fWPnu9p+cOAB2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740617729; x=1741222529;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SCM/SHQUaX07ZK9wOQI9o4MwxKRK9LYJCLXSjuaJ99s=;
 b=vHpWJlV9bucb25f6miiVDepL8Hc+O/2vNtq7CZ5dEdek4PTfjkBqz3SJUVde9Jacgk
 +xqeA7PnpHrufWWDqx3EYlBpNU0ksFC4G0beDJ5IcEC/p1553j7l2XJlhrOE+Iiruq7n
 Dnoc+ZB6CtdWNp7X4d+SvxpeB1cngIFzXhk+s6NgArFklfyit1XfgocVrct4ER75fUK7
 UtHR7cke56qjS7OkmDQLVacfi24/txZGWkQEZ7kzc+0Nn2tPiczyJKnLnqhZg5o0t1mc
 Inf40Y9WkuZpVdXxZz86uoMLglc3PF6K//WMfr7dhunL83tb6cyLYneuwK6AJN6xRMjp
 oaUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9qE0JVPph+p9jc3BoWNsb+kn7QBabAoMe1LeRluqyiIhDOMhPShs9yFwh2AcVd4z+BwLYxME=@lists.denx.de
X-Gm-Message-State: AOJu0YyI7620EU09Shq53dbILBpAL344Ed3onn8rcCG1AsiUdDyAhiGU
 OhjRdxmaPzKqwVumZkYofMXXpllRtZGyzH3cFOXYVfZmpK5QuyME1z1xRmbX+sk=
X-Gm-Gg: ASbGncua4bHrT8o2dBbUmGzelz/NJzJuI1jzFiq+ouaNM3/ZABTTRMBhrwauv0OsN3u
 dbr/FVABZD5kL0rITiDsIGyZ0f3bYqcumOCieORdi5+auxkZj9VvhFMEmR8ku/1KiwaNYacoV7+
 gclwQoK5WRFXBpHW35DmYyxQ2e2T2BCFWs0zEqB0sck3glxYvF/Vbwx+Euh0ATj9IadsoivzyMN
 UeW0YeeMX65SJunWVwyVW5TDC8yt0zL79HUthv41D3U9Y8K/ZtBwIopUlvGX3sBNaGjJFFFqB9d
 R0VhJefa7M8BmBU6tEbS5KTp
X-Google-Smtp-Source: AGHT+IEs6ITurkTZ75d2xGldfpr1M0ovd9QHndkgtHjT7/WzoMN0OFSVxWgSlCaGWI09NWepFkKiig==
X-Received: by 2002:a05:620a:44c6:b0:7c0:c2d7:5f2d with SMTP id
 af79cd13be357-7c0cef0e576mr2905239885a.28.1740617729455; 
 Wed, 26 Feb 2025 16:55:29 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c36fee8aafsm34673085a.13.2025.02.26.16.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 16:55:28 -0800 (PST)
Date: Wed, 26 Feb 2025 18:55:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, uboot-imx@nxp.com,
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Ludwig Nussel <ludwig.nussel@siemens.com>
Subject: Re: [PATCH 2/2] imx8mm: imx8mm_evk: fix BOOTSTD boot
Message-ID: <20250227005524.GP2640854@bill-the-cat>
References: <20250222121711.6697-1-peng.fan@oss.nxp.com>
 <20250222121711.6697-2-peng.fan@oss.nxp.com>
 <CAOMZO5Drcqztvz1jE634sumDZk6Rmw5RJ1GzvvkU0mPJoDg1RQ@mail.gmail.com>
 <CAOMZO5C3UmU45sN-JyS-qRkVbFC=wW1=OjhZ764UGbmK4YJp6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="t3xxR7JyuiaDWQ0g"
Content-Disposition: inline
In-Reply-To: <CAOMZO5C3UmU45sN-JyS-qRkVbFC=wW1=OjhZ764UGbmK4YJp6w@mail.gmail.com>
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


--t3xxR7JyuiaDWQ0g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 07:58:26PM -0300, Fabio Estevam wrote:
> On Wed, Feb 26, 2025 at 7:47=E2=80=AFPM Fabio Estevam <festevam@gmail.com=
> wrote:
>=20
> > How can we fix this boot regression? This affects imx8mm-evk,
> > imx8mn-evk, imx8mp-evk as well.
>=20
> After adding:
>=20
> --- a/configs/imx93_11x11_evk_defconfig
> +++ b/configs/imx93_11x11_evk_defconfig
> @@ -128,3 +128,4 @@ CONFIG_ULP_WATCHDOG=3Dy
>  CONFIG_WDT=3Dy
>  CONFIG_LZO=3Dy
>  CONFIG_BZIP2=3Dy
> +CONFIG_CMD_SYSBOOT=3Dy
>=20
> I got:
>=20
> U-Boot 2025.04-rc3-00007-g57bbc4de75f6-dirty (Feb 26 2025 - 19:50:19 -030=
0)
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
> Scanning for bootflows in all bootdevs
> Seq  Method       State   Uclass    Part  Name                      Filen=
ame
> ---  -----------  ------  --------  ----  ------------------------
> ----------------
> Scanning global bootmeth 'efi_mgr':
> Cannot persist EFI variables without system partition
>   0  efi_mgr      ready   (none)       0  <NULL>
> ** Booting bootflow '<NULL>' with efi_mgr
> Loading Boot0000 'mmc 1' failed
> Loading Boot0001 'mmc 0' failed
> EFI boot manager: Cannot load any image
> Boot failed (err=3D-14)
> Scanning bootdev 'mmc@42850000.bootdev':
> Scanning bootdev 'mmc@42860000.bootdev':
>   1  extlinux     ready   mmc          1  mmc@42860000.bootdev.part
> /boot/extlinux/extlinux.conf
> ** Booting bootflow 'mmc@42860000.bootdev.part_1' with extlinux
> 1: buildroot
> missing environment variable: kernel_addr_r
> Skipping buildroot for failure retrieving kernel
> Boot failed (err=3D-14)
> No more bootdevs
>=20
> Then I did:
>=20
> =3D> setenv kernel_addr_r 0x80400000
> =3D> saveenv
>=20
> and it finally booted:
>=20
> U-Boot 2025.04-rc3-00007-g57bbc4de75f6-dirty (Feb 26 2025 - 19:50:19 -030=
0)
>=20
> Reset Status: POR
>=20
> CPU:   NXP i.MX93(52) Rev1.1 A55 at 1700 MHz
> CPU:   Industrial temperature grade  (-40C to 105C) at 45C
> Model: NXP i.MX93 11X11 EVK board
> DRAM:  2 GiB
> Core:  214 devices, 24 uclasses, devicetree: separate
> WDT:   Started watchdog@42490000 with servicing every 1000ms (40s timeout)
> MMC:   FSL_SDHC: 0, FSL_SDHC: 1
> Loading Environment from MMC... Reading from MMC(1)... OK
> In:    serial@44380000
> Out:   serial@44380000
> Err:   serial@44380000
> switch to partitions #0, OK
> mmc1 is current device
> Net:   eth0: ethernet@42890000 [PRIME], eth1: ethernet@428a0000
> Hit any key to stop autoboot:  0
> Scanning for bootflows in all bootdevs
> Seq  Method       State   Uclass    Part  Name                      Filen=
ame
> ---  -----------  ------  --------  ----  ------------------------
> ----------------
> Scanning global bootmeth 'efi_mgr':
> Cannot persist EFI variables without system partition
>   0  efi_mgr      ready   (none)       0  <NULL>
> ** Booting bootflow '<NULL>' with efi_mgr
> Loading Boot0000 'mmc 1' failed
> Loading Boot0001 'mmc 0' failed
> EFI boot manager: Cannot load any image
> Boot failed (err=3D-14)
> Scanning bootdev 'mmc@42850000.bootdev':
> Scanning bootdev 'mmc@42860000.bootdev':
>   1  extlinux     ready   mmc          1  mmc@42860000.bootdev.part
> /boot/extlinux/extlinux.conf
> ** Booting bootflow 'mmc@42860000.bootdev.part_1' with extlinux
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
>=20
> Can you please fix this for all the i.MX boards?
>=20
> Otherwise, we will have boot regressions, and the bootstd series must
> be reverted.

But what part of things here is trying to call "sysboot" as a command?

--=20
Tom

--t3xxR7JyuiaDWQ0g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme/t/kACgkQFHw5/5Y0
tyzMTQv+LpUZSczsrzwKiyIwLoGsKjMMeIGwNTBOPay4mt1aOPib2vipgfQ4tfZT
f7/phd4I7T2uW295ysUEqJ1toLMx5s+wuyMU88+/UHf5U0XezlO0GMRdAiIbRdFL
3Q+crUEL7sXrChBgk/G3tXUbxrF3r9nS869ktzGaP3oJn9dOMZilF1RISGkTTUVD
u4amzmIG01DTFg7IPxsVdCA6hJvbK5fSCIfPcusj1QS0SplKBcew/bXNk/4jCaui
dTowtduvjZC5nJSmMD+FIMpxPWMtyqqEWNPkr5bFuwEFn5sdr3PNjL1yXhTKXQPs
mA0FrvxqVkBDyS/TaD47iXYulB54DuJu+322hsS6kpWLmulE8iAvBwzoFTyWxZsV
+TWdofLmseCkA1O9ehzxZn7VCtVx+KYUWtXZbVhM01eLMuaOiltSv320FPctDSqM
qdqlnHhj953oMf0oKWewjziLitEkj7mdgEjG7fgtOFOeHSaSaxAzRqeqddkzFohB
AVOqtaHL
=wD46
-----END PGP SIGNATURE-----

--t3xxR7JyuiaDWQ0g--
