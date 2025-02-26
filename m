Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DB5C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 22:58:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FE7A8104B;
	Wed, 26 Feb 2025 23:58:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xfu8WnLX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10B6281109; Wed, 26 Feb 2025 23:58:41 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA18580FF2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 23:58:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-30795988ebeso3665131fa.3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 14:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740610718; x=1741215518; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eXXVKmzWpiEycxhwuz0RwMaoMpIKcQ8DesL7wmUMStM=;
 b=Xfu8WnLXnKusGgGF7hdeXRoaoGsn6msTdjxJBikMzFBtnK4PuGn9Mtj5ZvUrGqy7zC
 QPyZK/N7WSbloh72bZj3gOzvUQOdMOoScfpMGBATERxQl4Y9zadaD63niGcqw2zAywi2
 iRRUzUytYp1i2tORhAlSp6EtW2jK4ecNdy0DoMNsCRbBJKnDkgqOXHVRUr9abt4Pgn4M
 iFQHt8zooiLycmnfCzKhyJEqoo3CEuY1C8p1QzTwVomE3UQAd49Zk6yqqnQZpaVWaqk8
 OCoNPU200O59MiuR4NEfKAHMrY6fYoOtoIu/sPY5izheHt3m5TGUcUHijvXWfx6qe6eT
 jDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740610718; x=1741215518;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eXXVKmzWpiEycxhwuz0RwMaoMpIKcQ8DesL7wmUMStM=;
 b=tENfXX/8kOQV+PxrYgdzHxGyzp44/LHIGLGsNJDsZBffa2AIZv/FI1s+1i6S0GmuLF
 Ztl0O3xuDGDNKvi6GngirjT1NMlzFdLB2m6wReoEuOrixfpFvW1a5urdo3OZZdOOha+t
 h1la7gQ0KA5OXk/KVF1WF0vExbk6tIwP4V/i3w11WpsEQqGabyl9yfe10ULOIrobmi0l
 ci2/fTM7BC+RTI8pjy3o52wO5TgAwEGotXlAZogVfm+JYYeQBvzf+7AjVlKmS0XIRDcU
 0XGaYNlWzQx9/tvt+exgFbwOX4K7xgl9NckVtipcqUaPzjNh4frOS1YOr1fXXQN7H+Gz
 pYog==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSHnyRfAS6x6/+8nRypWLX0IGtrVw0EBw64uE3ynwkoVRJAx/lYyx33SzN9KeNDvBfUVTLBeU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4s+yD9eahaxJpPEXiKAIsWM/yhaE/HbFMnjueW4LcLHdqw20+
 VdKgz1Orm0zobt4GxlxVSH9hEsMvOIEhvJGMC8X2pt3NMHglZ+myyS/fScjI7YZf3s5rHYppXLG
 dAWHYVeTlXIW5mtEK+tw2Lp83m7I=
X-Gm-Gg: ASbGncuUtuPBBdiXkIkKOsaajM64A5hgQmCuNtKRbQUzItz+N3jRTagMTEug9WGgL0E
 rAfeVidlPfYsleyXhHcN+KfkXEcAEY/udZIBLgrDD27aZ5O8D6zlgGD/hvFT0anpDLJD2l+rZFH
 O10uJPv1Swgmicda4n60egxZYxinJjrPTE4Lldfw==
X-Google-Smtp-Source: AGHT+IEc2iFz9FoUcpuDyTXVhmWI7qbLS0NyjuCtTPYYM4qJ9wAZjWk9oyjYGxY5qJPqJ6pnD178FWsAz0go7jU641c=
X-Received: by 2002:a2e:9ad3:0:b0:302:497a:9e5b with SMTP id
 38308e7fff4ca-30a80c0f0bamr43080671fa.2.1740610717955; Wed, 26 Feb 2025
 14:58:37 -0800 (PST)
MIME-Version: 1.0
References: <20250222121711.6697-1-peng.fan@oss.nxp.com>
 <20250222121711.6697-2-peng.fan@oss.nxp.com>
 <CAOMZO5Drcqztvz1jE634sumDZk6Rmw5RJ1GzvvkU0mPJoDg1RQ@mail.gmail.com>
In-Reply-To: <CAOMZO5Drcqztvz1jE634sumDZk6Rmw5RJ1GzvvkU0mPJoDg1RQ@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 26 Feb 2025 19:58:26 -0300
X-Gm-Features: AQ5f1JocZozHufJ387SEatqXDYr8kL70RB0rLf7HTs43-p2Q24KBBStJ7HvCNA4
Message-ID: <CAOMZO5C3UmU45sN-JyS-qRkVbFC=wW1=OjhZ764UGbmK4YJp6w@mail.gmail.com>
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

On Wed, Feb 26, 2025 at 7:47=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:

> How can we fix this boot regression? This affects imx8mm-evk,
> imx8mn-evk, imx8mp-evk as well.

After adding:

--- a/configs/imx93_11x11_evk_defconfig
+++ b/configs/imx93_11x11_evk_defconfig
@@ -128,3 +128,4 @@ CONFIG_ULP_WATCHDOG=3Dy
 CONFIG_WDT=3Dy
 CONFIG_LZO=3Dy
 CONFIG_BZIP2=3Dy
+CONFIG_CMD_SYSBOOT=3Dy

I got:

U-Boot 2025.04-rc3-00007-g57bbc4de75f6-dirty (Feb 26 2025 - 19:50:19 -0300)

Reset Status: POR

CPU:   NXP i.MX93(52) Rev1.1 A55 at 1700 MHz
CPU:   Industrial temperature grade  (-40C to 105C) at 36C
Model: NXP i.MX93 11X11 EVK board
DRAM:  2 GiB
Core:  214 devices, 24 uclasses, devicetree: separate
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
Scanning for bootflows in all bootdevs
Seq  Method       State   Uclass    Part  Name                      Filenam=
e
---  -----------  ------  --------  ----  ------------------------
----------------
Scanning global bootmeth 'efi_mgr':
Cannot persist EFI variables without system partition
  0  efi_mgr      ready   (none)       0  <NULL>
** Booting bootflow '<NULL>' with efi_mgr
Loading Boot0000 'mmc 1' failed
Loading Boot0001 'mmc 0' failed
EFI boot manager: Cannot load any image
Boot failed (err=3D-14)
Scanning bootdev 'mmc@42850000.bootdev':
Scanning bootdev 'mmc@42860000.bootdev':
  1  extlinux     ready   mmc          1  mmc@42860000.bootdev.part
/boot/extlinux/extlinux.conf
** Booting bootflow 'mmc@42860000.bootdev.part_1' with extlinux
1: buildroot
missing environment variable: kernel_addr_r
Skipping buildroot for failure retrieving kernel
Boot failed (err=3D-14)
No more bootdevs

Then I did:

=3D> setenv kernel_addr_r 0x80400000
=3D> saveenv

and it finally booted:

U-Boot 2025.04-rc3-00007-g57bbc4de75f6-dirty (Feb 26 2025 - 19:50:19 -0300)

Reset Status: POR

CPU:   NXP i.MX93(52) Rev1.1 A55 at 1700 MHz
CPU:   Industrial temperature grade  (-40C to 105C) at 45C
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
Scanning for bootflows in all bootdevs
Seq  Method       State   Uclass    Part  Name                      Filenam=
e
---  -----------  ------  --------  ----  ------------------------
----------------
Scanning global bootmeth 'efi_mgr':
Cannot persist EFI variables without system partition
  0  efi_mgr      ready   (none)       0  <NULL>
** Booting bootflow '<NULL>' with efi_mgr
Loading Boot0000 'mmc 1' failed
Loading Boot0001 'mmc 0' failed
EFI boot manager: Cannot load any image
Boot failed (err=3D-14)
Scanning bootdev 'mmc@42850000.bootdev':
Scanning bootdev 'mmc@42860000.bootdev':
  1  extlinux     ready   mmc          1  mmc@42860000.bootdev.part
/boot/extlinux/extlinux.conf
** Booting bootflow 'mmc@42860000.bootdev.part_1' with extlinux
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

Can you please fix this for all the i.MX boards?

Otherwise, we will have boot regressions, and the bootstd series must
be reverted.
