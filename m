Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 214FDEE3F10
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 19:38:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DFB986D75;
	Tue, 12 Sep 2023 21:38:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KItMb9RU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8DD986D99; Tue, 12 Sep 2023 21:38:15 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31EA686584
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 21:38:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-502d9ce31cbso225549e87.3
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 12:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694547492; x=1695152292; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=pZ4ED7V82UJpVnlUcCdVkWYKahfJa2oTjCqgwHg7CaI=;
 b=KItMb9RUCNukCZ2jpFecMyeXCt15J7ItwvUbcpT4wrMW/K8PwrtdBrNI4It8sEH+KW
 YyffgQ3cvIx2pDr7oZ25Ebg6m1cK1RtydXjDTxt2jA1cQaKHddL1SGRvrnYNf82dh7VV
 WX05m+wAI6RdeY/gX/SW/DdWe66owF7aW2gj4/xUM+hz0kPueo3ulyqPW2/E4TteUOFS
 4297yZrEpCAh+IYFZUJXuUqtDVKEAHzPXmnk7M3Em8VSHunF2Gy5v010g9pWNwFex90a
 xF4yaDZcg1XjC7xU0fkQsAq0wqEfJ4YVEcAQ6+B2jPz/+HfK2NhTt8O3/5CiUXOZdZvZ
 BIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694547492; x=1695152292;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pZ4ED7V82UJpVnlUcCdVkWYKahfJa2oTjCqgwHg7CaI=;
 b=HSI2zD6dCfvvtkelQ4Wk/uxa+0EWYgWzk0nIxeqI4canAyQYq9ogedJ+z3mBuNG6Gd
 syz5zuHpZZv/Qfd6FEtl85tuLCqp9hzxuQK/n1CLh4hYln5FM8rw7JzMYajOay2ifiZK
 hh23tDAm5sidXE4+NZ8fear1F6C1Q3picWflW5PmQX3P5j+BAZPHt5IDTc1chCi15qEV
 Xqm9UdzD5y7TRXrJSWbvauI6neoIn9Z5hzGNVo82ZN75Kx6xnTwgoZu6p5AjlyO3Wlu0
 XVAkTV5FGA5mN5NEm9yRaPZsyVuoIHXeVtuML25HTVuaoO+yAhftn4F10ED10fazItru
 Ck9g==
X-Gm-Message-State: AOJu0YzUxoJO3BY8fjJMI4WBEqFzy7Rp+cA+G2yfQX/B8k6oNK8CVe5V
 S2cB90PAns7r+U7NLrDF4DZxrygXTAybU/0WPlE=
X-Google-Smtp-Source: AGHT+IFd3Pn2KGdeWhKvW6N5eVNkDElwzKAqd5RW9SFZraUBNx0XwFYqea7597MDeK04WZ0ayGEUuX+hYW4w9g+0VlU=
X-Received: by 2002:a19:4f5a:0:b0:502:9bd7:ec79 with SMTP id
 a26-20020a194f5a000000b005029bd7ec79mr341496lfk.29.1694547492140; Tue, 12 Sep
 2023 12:38:12 -0700 (PDT)
MIME-Version: 1.0
From: Tony Dinh <mibodhi@gmail.com>
Date: Tue, 12 Sep 2023 12:38:00 -0700
Message-ID: <CAJaLiFyTMW40gdMRjQhSTcUb_4ZRtLPo119EfBih9k_bcpNbdg@mail.gmail.com>
Subject: bootstd: CACHE Misaligned operation errors (Marvell Armada 385)
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>
Content-Type: text/plain; charset="UTF-8"
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

I've been testing the boostd for a few Marvell boards and seeing this
error on the Thecus N2350 (Marvell Armada 385, dual-core CPU). The
"bootflow scan scsi" command triggered the "CACHE: Misaligned
operation at range" error. However, this error did not affect the
result of the scan, i.e. the bootflow for scsi partition was created
correctly, and u-boot is running normally.

Enabling CONFIG_SYS_DCACHE_OFF got rid of the errors altogether.
Perhaps this is a case where the DCACHE is not required and should be
turned off?

Please see the log after the break below.

All the best,
Tony

========

U-Boot 2023.10-rc4-tld-1-00036-gbb16283b81-dirty (Sep 11 2023 - 11:56:18 -0700)
Thecus N2350

SoC:   MV88F6820-A0 at 1066 MHz
DRAM:  1 GiB (533 MHz, 32-bit, ECC not enabled)
Core:  65 devices, 23 uclasses, devicetree: separate
NAND:  512 MiB
MMC:
Loading Environment from SPIFlash... SF: Detected mx25l3205d with page
size 256 Bytes, erase size 4 KiB, total 4 MiB
*** Warning - bad CRC, using default environment

Model: Thecus N2350
Net:
Warning: ethernet@70000 (eth0) using random MAC address - be:13:ae:99:49:ab
eth0: ethernet@70000
Hit any key to stop autoboot:  0

N2350 > env def -a
## Resetting to default environment

N2350 > bootdev l
Seq  Probed  Status  Uclass    Name
---  ------  ------  --------  ------------------
  0   [   ]      OK  ethernet  ethernet@70000.bootdev
---  ------  ------  --------  ------------------
(1 bootdev)

N2350 > bootdev hunt scsi
Hunting with: scsi
pcie0.0: Link down
pcie1.0: Link down
scanning bus for devices...
SATA link 0 timeout.
Target spinup took 0 ms.
AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
flags: 64bit ncq led only pmp fbss pio slum part sxs
  Device 0: (1:0) Vendor: ATA Prod.: ST750LX003-1AC15 Rev: SM12
            Type: Hard Disk
            Capacity: 715404.8 MB = 698.6 GB (1465149168 x 512)

N2350 > bootflow scan usb
Bus usb@58000: USB EHCI 1.00
Bus usb3@f0000: MVEBU XHCI INIT controller @ 0xf10f4000
Register 2000120 NbrPorts 2
Starting the controller
USB XHCI 1.00
Bus usb3@f8000: MVEBU XHCI INIT controller @ 0xf10fc000
Register 2000120 NbrPorts 2
Starting the controller
USB XHCI 1.00
scanning bus usb@58000 for devices... 1 USB Device(s) found
scanning bus usb3@f0000 for devices... 1 USB Device(s) found
scanning bus usb3@f8000 for devices... 2 USB Device(s) found
** File not found /boot/boot.bmp **

N2350 > bootflow scan scsi
CACHE: Misaligned operation at range [3fb7fe48, 3fb80248]
CACHE: Misaligned operation at range [3fb7fe48, 3fb80248]
CACHE: Misaligned operation at range [3fb7fe48, 3fb80248]
ERROR: v7_outer_cache_inval_range - start address is not aligned - 0x3fb7fe48
ERROR: v7_outer_cache_inval_range - stop address is not aligned - 0x3fb80248
** File not found /boot/boot.bmp **
** File not found /boot/boot.bmp **

N2350 > bootflow scan scsi
CACHE: Misaligned operation at range [3fb88a88, 3fb88e88]
CACHE: Misaligned operation at range [3fb88a88, 3fb88e88]
CACHE: Misaligned operation at range [3fb88a88, 3fb88e88]
ERROR: v7_outer_cache_inval_range - start address is not aligned - 0x3fb88a88
ERROR: v7_outer_cache_inval_range - stop address is not aligned - 0x3fb88e88
** File not found /boot/boot.bmp **
** File not found /boot/boot.bmp **

N2350 > bootflow l
Showing all bootflows
Seq  Method       State   Uclass    Part  Name                      Filename
---  -----------  ------  --------  ----  ------------------------
----------------
  0  script       ready   scsi         1  ahci_scsi.id1lun0.bootdev
/boot/boot.scr
  1  script       ready   usb_mass_    1  usb_mass_storage.lun0.boo
/boot/boot.scr
---  -----------  ------  --------  ----  ------------------------
----------------
(2 bootflows, 2 valid)

N2350 > boot
Scanning for bootflows in all bootdevs
Seq  Method       State   Uclass    Part  Name                      Filename
---  -----------  ------  --------  ----  ------------------------
----------------
Scanning global bootmeth 'efi_mgr':
Hunting with: mmc
Scanning bootdev 'ahci_scsi.id1lun0.bootdev':
CACHE: Misaligned operation at range [3fb91d08, 3fb92108]
CACHE: Misaligned operation at range [3fb91d08, 3fb92108]
CACHE: Misaligned operation at range [3fb91d08, 3fb92108]
ERROR: v7_outer_cache_inval_range - start address is not aligned - 0x3fb91d08
ERROR: v7_outer_cache_inval_range - stop address is not aligned - 0x3fb92108
** File not found /boot/boot.bmp **
  0  script       ready   scsi         1  ahci_scsi.id1lun0.bootdev
/boot/boot.scr
** Booting bootflow 'ahci_scsi.id1lun0.bootdev.part_1' with script
Booting with distro boot script
loading uImage from scsi 0:1 ...
5118888 bytes read in 120 ms (40.7 MiB/s)
loading uInitrd from scsi 0:1 ...
7355687 bytes read in 197 ms (35.6 MiB/s)
loading DTB file from scsi 0:1 ...
20906 bytes read in 16 ms (1.2 MiB/s)
## Booting kernel from Legacy Image at 01000000 ...
   Image Name:   Linux-6.4.11-mvebu-tld-1
   Created:      2023-08-20  17:34:55 UTC
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    5118824 Bytes = 4.9 MiB
   Load Address: 00008000
   Entry Point:  00008000
   Verifying Checksum ... OK
## Loading init Ramdisk from Legacy Image at 02200000 ...
   Image Name:   initramfs-6.4.11-mvebu-tld-1
   Created:      2023-08-20  17:34:57 UTC
   Image Type:   ARM Linux RAMDisk Image (gzip compressed)
   Data Size:    7355623 Bytes = 7 MiB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 02000000
   Booting using the fdt blob at 0x2000000
Working FDT set to 2000000


Starting kernel ...

   Loading Kernel Image
   Loading Ramdisk to 0f8fc000, end 0ffffce7 ... OK
   Loading Device Tree to 0f8f3000, end 0f8fb1a9 ... OK
Working FDT set to f8f3000

Starting kernel ...
