Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74153C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 22:47:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D40FE81197;
	Wed, 26 Feb 2025 23:47:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CET3f+/H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9C6B811B2; Wed, 26 Feb 2025 23:47:18 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5422181113
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 23:47:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-546267ed92fso258769e87.2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 14:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740610035; x=1741214835; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KyhNtKAyPxK0aegUOOXfV1ebRBf5CuxXEQyJvQesJ20=;
 b=CET3f+/HhFFqPLCtaJJfoTPg6B/rfQS0CttuUKCbRr6Pbh5hMZYBPsS0+e6hiI0EK2
 o/9T6o9xW4A6roVeNs4eZfon5Ez7tHt9/6eMZZjx4b0vjeeu0C62ls9T5lt107o+iELe
 GbnjFHtpuwDqOUmB0GWTc8/BIACQEm3gO5D+N/4+ioJEsyO+lWaJYMdyb0BLgme+ajnv
 FRZKBTjzd1yJ+eElkepQYjyezwtWJfdzhauRoqko+0CyjvJ8H3jlM53HRlesuHbuhSOI
 i+oi/S7Mp2bRQtxQP1n5fpFVcIu3HCIAMRHWVWjghfBrBrebffob8b11/s2gfGLkcFKJ
 MV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740610035; x=1741214835;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KyhNtKAyPxK0aegUOOXfV1ebRBf5CuxXEQyJvQesJ20=;
 b=pe98PYV7Z7lLoKPwMJbnUc3WbRstSf5lSLkScVsEi1BDLlFiEf5/qiDZa4/n2d7QtG
 n+qTPYaF8/duBWS+zepLBY8Mpqs1dm+ulehQ5vPw4ft53Khra3d70/iqDCrmL2K3G2FU
 Lpzetoi7bLWmQboYjQYrvGzVSjT9OXNMYbo93/NZpzkvFw5zcjgg9KmHKpaxMEedmhEL
 fi6+WAKlNM0j0kQo1d/3MbyKXkXtJDFQREdK4TrhukKXp22d8sxiXIJmy8THf08JdqLx
 g5UiNQ6G4L5f2iZuVLO8UVwKJ17f7uot6pMrnC3kNJe6bA+3Pyvh7U3sNaa19VsHpZZ3
 Zr0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0m0E6ZBUqvZWT80W7Z33qN8gf2YdIwHEsls6sX4ju1XE8fYwj4awp1LivN9MoaSGZpVNc+tQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yxr7Rp/eMvQWsVp51bCYmqz7w5IJ61JCdUpW6AB99+zZmXRH8+w
 N3GGii24Q43MqwCJ9tjkKbolxpWQYvEAMtMjVnWqeoZ7lCIDopTYr/AaWK70X6qkQrmlvgLrNqM
 vDhR5vBL+QRroPa8F6izXYUkHz0w=
X-Gm-Gg: ASbGncuF9jCmgybm0Ez3PP05nYDyqgAXchdW2UsE8TjQ0nDrcKMOOR5QunQO3/rOYO6
 BorGXj7puqrkGlhVmRoPkXUdu7oydD5PoEv8d+e0U946QZ+gJt8kPCQS6Z994Hhs9c2YZMZtWzk
 9Hu1MhU2KEqdEItIIAsohjY+JQDl1SuSR6PtdyVbk=
X-Google-Smtp-Source: AGHT+IHSDLcMcADzWEHhkaNsToCuttZERKnOcfS+VxcACjP/gfmTwK8QsrLhaBYXR0Dj+kiQrDNl9XCuBRlLxRtgGf0=
X-Received: by 2002:a05:6512:158c:b0:545:b9a:b4b8 with SMTP id
 2adb3069b0e04-548510ed8cfmr5391023e87.51.1740610035139; Wed, 26 Feb 2025
 14:47:15 -0800 (PST)
MIME-Version: 1.0
References: <20250222121711.6697-1-peng.fan@oss.nxp.com>
 <20250222121711.6697-2-peng.fan@oss.nxp.com>
In-Reply-To: <20250222121711.6697-2-peng.fan@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 26 Feb 2025 19:47:03 -0300
X-Gm-Features: AQ5f1JqZlyxgib3YotiGC9Go3CC7uqf57DVd6U58zSvDmbBn5hNwUjGLJft50-8
Message-ID: <CAOMZO5Drcqztvz1jE634sumDZk6Rmw5RJ1GzvvkU0mPJoDg1RQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] imx8mm: imx8mm_evk: fix BOOTSTD boot
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Tom Rini <trini@konsulko.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Ludwig Nussel <ludwig.nussel@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Peng,

On Sat, Feb 22, 2025 at 8:10=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Select BOOTSTD_FULL and BOOTSTD_BOOTCOMMAND
> Correct DEFAULT_FDT_FILE
> Correct env file for imx8mm_evk_fspi_defconfig
>
> Fixes: 364ba68ed1a ("imx: imx8mm_evk: Switch to BOOTSTD")
> Reported-by: Ludwig Nussel <ludwig.nussel@siemens.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

I have a problem with the bootstd conversion series.

I have a Buildroot image that boots U-Boot 2025.01 on imx93-evk:

U-Boot 2025.01 (Feb 26 2025 - 16:22:03 -0300)

Reset Status: POR

CPU:   NXP i.MX93(52) Rev1.1 A55 at 1700 MHz
CPU:   Industrial temperature grade  (-40C to 105C) at 37C
Model: NXP i.MX93 11X11 EVK board
DRAM:  2 GiB
Core:  199 devices, 24 uclasses, devicetree: separate
WDT:   Started watchdog@42490000 with servicing every 1000ms (40s timeout)
MMC:   FSL_SDHC: 0, FSL_SDHC: 1
Loading Environment from MMC... Reading from MMC(1)... *** Warning -
bad CRC, using default environment

In:    serial@44380000
Out:   serial@44380000
Err:   serial@44380000
switch to partitions #0, OK
mmc1 is current device
Net:   eth0: ethernet@42890000 [PRIME], eth1: ethernet@428a0000
Hit any key to stop autoboot:  0
switch to partitions #0, OK
mmc0(part 0) is current device
Scanning mmc 0:1...
65166 bytes read in 15 ms (4.1 MiB/s)
Cannot persist EFI variables without system partition
Loading Boot0000 'mmc 1' failed
Loading Boot0001 'mmc 0' failed
EFI boot manager: Cannot load any image
switch to partitions #0, OK
mmc1 is current device
Scanning mmc 1:1...
Found /boot/extlinux/extlinux.conf
Retrieving file: /boot/extlinux/extlinux.conf
1: buildroot
Retrieving file: /boot/Image
append: root=3DPARTUUID=3D6d55b936-eeb3-49c5-9b61-b69a1207b761 rootwait rw
Retrieving file: /boot/freescale/imx93-11x11-evk.dtb
## Flattened Device Tree blob at 83000000
   Booting using the fdt blob at 0x83000000
Working FDT set to 83000000
   Loading Device Tree to 000000008fff3000, end 000000008ffff442 ... OK
Working FDT set to 8fff3000

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x412fd050]
[    0.000000] Linux version 6.12.16 (fabio@fabio-Precision-3551)
(aarch64-buildroot-linux-gnu-gcc.br_real (Buildroot
2024.11-1133-g5a1515b5976a-dirty) 13.3.0, GNU ld (GNU Binutils)
2.43.1) #1 SMP PREEMPT Wed Feb 26 16:51:31 -03 2025
....

If I flash U-Boot top-of-tree into the SD card, the boot fails:

U-Boot 2025.04-rc3-00007-g57bbc4de75f6 (Feb 26 2025 - 19:35:55 -0300)

Reset Status: POR

CPU:   NXP i.MX93(52) Rev1.1 A55 at 1700 MHz
CPU:   Industrial temperature grade  (-40C to 105C) at 36C
Model: NXP i.MX93 11X11 EVK board
DRAM:  2 GiB
Core:  214 devices, 24 uclasses, devicetree: separate
WDT:   Started watchdog@42490000 with servicing every 1000ms (40s timeout)
MMC:   FSL_SDHC: 0, FSL_SDHC: 1
Loading Environment from MMC... Reading from MMC(1)... OK
In:    serial@44380000
Out:   serial@44380000
Err:   serial@44380000
switch to partitions #0, OK
mmc1 is current device
Net:   eth0: ethernet@42890000 [PRIME], eth1: ethernet@428a0000
Hit any key to stop autoboot:  0
switch to partitions #0, OK
mmc0(part 0) is current device
Scanning mmc 0:1...
65166 bytes read in 14 ms (4.4 MiB/s)
Cannot persist EFI variables without system partition
Loading Boot0000 'mmc 1' failed
Loading Boot0001 'mmc 0' failed
EFI boot manager: Cannot load any image
switch to partitions #0, OK
mmc1 is current device
Scanning mmc 1:1...
Found /boot/extlinux/extlinux.conf
Unknown command 'sysboot' - try 'help'
EXTLINUX FAILED: continuing...
Loading Boot0000 'mmc 1' failed
Loading Boot0001 'mmc 0' failed
EFI boot manager: Cannot load any image
u-boot=3D>

Even though /boot/extlinux/extlinux.conf was found, it did not succeed
in booting it.

If you want to test the same environment I am using, build a Buildroot imag=
e
using mainline Buildroot:
https://github.com/buildroot/buildroot/commit/27b3e6774fe447dc5eb12cc7f498e=
c8868eb65c9

How can we fix this boot regression? This affects imx8mm-evk,
imx8mn-evk, imx8mp-evk as well.
