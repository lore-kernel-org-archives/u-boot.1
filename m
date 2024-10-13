Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1609ECF2579
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 13:25:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DF6B88ECE;
	Sun, 13 Oct 2024 15:25:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cqxk/EoA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BFD988E8E; Sun, 13 Oct 2024 09:25:19 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEE9988E6F
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 09:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20cb7139d9dso10798155ad.1
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 00:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728804315; x=1729409115; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0JR0YjzByu8Q/5fwD+c6LnqdwrtAZnBeY2CzJ2Q8k9o=;
 b=cqxk/EoAtrCdj0yxIWKRS/yiGgu0G9SpgYE0z03s69QY5VVhqxeqxtR9jdm4of7auM
 mymkwi3YDCOUt3syGV4ICpeWrud9qlVr/qOF2lfAY1h3Nmex+hE0KIvn2mDBzaPm8OeJ
 xmRPSKpLJk6gihdc8cLuq+jEnkU/AMwWAWofbL5/zkZd2X2jfQZKsatvhrwY+Uzp8yzC
 YWTP+qrDLZDSzGnUdBE2zoO5iH8mf3w9FS3/YUP4xsp9jlIim44adifmrI6yh5r0L5Zj
 mU0ut7YY/xKF8uXIoeRfQA48Elz+zNSIMgPnBVzqT/ZERxZPa5dWQQkrQiuDZxywij2d
 ROaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728804315; x=1729409115;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0JR0YjzByu8Q/5fwD+c6LnqdwrtAZnBeY2CzJ2Q8k9o=;
 b=cLpynFNG4TBb5X19EPMaAwpgwskuuybZilCBRvvX4CCDmIGRRsa6QRpw7vqHTpQWeO
 3gAbJtstQHRRoNYjp7zUufUhHwiCiD72vNhgbaqb5Xn3JHZQMzWJFkigWX4dvN57eoja
 jgzlJPAJNje+WcP8DqQR7THEsWOD08U0jTBxMkdv9NKW47tlY/GG6beJOIPOuJzltOzA
 /VZ8ErxNF4eu7dv67016u/oEik0yTMEAiVXIBhzg+x7VhNZ39GPx5zQzSDJ1RuiibwyA
 NbJ8uYm6e48cCQ/oNjONhMSce+nSRwHNg+d5fB5lW2dzBCxMvRU5lCNzp9H/Ld0SW1cx
 IbIA==
X-Gm-Message-State: AOJu0YxE6SyQqTrqB91TqYyRBiDnXWJB3OMx1C/K+7cFj//3442+MTpI
 vGBL96PhQ3u8Yt1uan2vNoa1bYjr82qD/CKJhdjcnQd9o08DLfv2YfT4dcVG
X-Google-Smtp-Source: AGHT+IHcveUJWA62RnsI1cBOS8IktymUOT2oaas4R0o8TZ+7aPRsjm8u1CODfnmlwU0KO+pmLaP1IA==
X-Received: by 2002:a17:902:f543:b0:20c:c01d:54a8 with SMTP id
 d9443c01a7336-20cc01d5d28mr40757445ad.16.1728804314918; 
 Sun, 13 Oct 2024 00:25:14 -0700 (PDT)
Received: from aristo-b7flip.. ([124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c212d19sm46306375ad.191.2024.10.13.00.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 00:25:14 -0700 (PDT)
From: Wei Ming Chen <jj251510319013@gmail.com>
To: u-boot@lists.denx.de
Cc: andy.tang@nxp.com, trini@konsulko.com, sjg@chromium.org,
 Wei Ming Chen <jj251510319013@gmail.com>
Subject: [PATCH] configs: ls1028a: Fix bootefi issue on Layerscape ls1028ardb
 platform
Date: Sun, 13 Oct 2024 15:24:35 +0800
Message-Id: <20241013072435.1506107-1-jj251510319013@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Oct 2024 15:25:06 +0200
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

Without this patch, there will be error indicating that
"Cannot use 64 bit addresses with SDMA", and the booting
process will stuck.

please see full boot log below

U-Boot 2022.04-g18185931 (Sep 11 2024 - 13:15:30 +0800)

SoC:  LS1028AE Rev1.0 (0x870b0010)
Clock Configuration:
       CPU0(A72):1500 MHz  CPU1(A72):1500 MHz
       Bus:      400  MHz  DDR:      1600 MT/s
Reset Configuration Word (RCW):
       00000000: 3c004010 00000030 00000000 00000000
       00000010: 00000000 018f0000 0030c000 00000000
       00000020: 020031a0 00002580 00000000 00003296
       00000030: 00000000 00000010 00000000 00000000
       00000040: 00000000 00000000 00000000 00000000
       00000050: 00000000 00000000 00000000 00000000
       00000060: 00000000 00000000 200e705a 00000000
       00000070: bb580000 00000000
Model: LS1028A RDB Board
Board: LS1028AE Rev1.0-RDB, Version: C, boot from SD
FPGA: v8 (RDB)
SERDES1 Reference : Clock1 = 100.00MHz Clock2 = 100.00MHz
DRAM:  3.9 GiB
DDR    3.9 GiB (DDR4, 32-bit, CL=11, ECC on)
Using SERDES1 Protocol: 47960 (0xbb58)
PCIe1: pcie@3400000 Root Complex: no link
PCIe2: pcie@3500000 Root Complex: x1 gen2
Core:  45 devices, 22 uclasses, devicetree: separate
WDT:   Started watchdog@c000000 with servicing (60s timeout)
WDT:   Started watchdog@c010000 with servicing (60s timeout)
MMC:   FSL_SDHC: 0, FSL_SDHC: 1
Loading Environment from MMC... *** Warning - bad CRC, using default environment

EEPROM: Invalid ID (ff ff ff ff)
In:    serial
Out:   serial
Err:   serial
SEC0:  RNG instantiated
Net:
Warning: enetc-0 (eth0) using random MAC address - d2:9b:a5:37:7b:b5
eth0: enetc-0
Warning: enetc-2 (eth1) using random MAC address - ca:57:11:de:de:cb
, eth1: enetc-2, eth2: swp0, eth3: swp1, eth4: swp2, eth5: swp3
Hit any key to stop autoboot:  0
Trying load HDP firmware from SD..
switch to partitions #0, OK
mmc0 is current device
Device: FSL_SDHC
Manufacturer ID: 9f
OEM: 5449
Name: SD32G
Bus Speed: 50000000
Mode: SD High Speed (50MHz)
Rd Block Len: 512
SD version 3.0
High Capacity: Yes
Capacity: 28.9 GiB
Bus Width: 4-bit
Erase Group Size: 512 Bytes

MMC read: dev # 0, block # 18944, count 512 ... 512 blocks read: OK
Loading hdp firmware from 0x00000000a0000000 offset 0x0000000000002000
Loading hdp firmware Complete
switch to partitions #0, OK
mmc0 is current device
Scanning mmc 0:1...
** Unable to read file / **
Failed to load '/'
libfdt fdt_check_header(): FDT_ERR_BADMAGIC
Scanning disk mmc@2140000.blk...
Scanning disk mmc@2150000.blk...
Found 7 disks
ERROR: invalid device tree
Found EFI removable media binary efi/boot/bootaa64.efi
981992 bytes read in 44 ms (21.3 MiB/s)
libfdt fdt_check_header(): FDT_ERR_BADMAGIC
WARNING could not find node vivante,gc: FDT_ERR_NOTFOUND.
Booting /efi\boot\bootaa64.efi
Cannot use 64 bit addresses with SDMA
Error reading cluster
** Unable to read file /efi/boot/grubaa64.efi **
Unexpected return from initial read: Device Error, buffersize 29D790
Failed to load image ぀￢ : Device Error
start_image() returned Device Error
EFI LOAD FAILED: continuing...
switch to partitions #0, OK
mmc1(part 0) is current device
Scanning mmc 1:1...
** Unable to read file / **
Failed to load '/'
libfdt fdt_check_header(): FDT_ERR_BADMAGIC
BootOrder not defined
EFI boot manager: Cannot load any image
Scanning mmc 1:2...
** Unable to read file / **
Failed to load '/'
libfdt fdt_check_header(): FDT_ERR_BADMAGIC
BootOrder not defined
EFI boot manager: Cannot load any image
starting USB...
Bus usb@3100000: Register 200017f NbrPorts 2
Starting the controller
USB XHCI 1.00
Bus usb@3110000: Register 200017f NbrPorts 2
Starting the controller
USB XHCI 1.00
scanning bus usb@3100000 for devices... 1 USB Device(s) found
scanning bus usb@3110000 for devices... 1 USB Device(s) found
       scanning usb for storage devices... 0 Storage Device(s) found

Device 0: unknown device
Trying load from SD ...
switch to partitions #0, OK
mmc0 is current device
Device: FSL_SDHC
Manufacturer ID: 9f
OEM: 5449
Name: SD32G
Bus Speed: 50000000
Mode: SD High Speed (50MHz)
Rd Block Len: 512
SD version 3.0
High Capacity: Yes
Capacity: 28.9 GiB
Bus Width: 4-bit
Erase Group Size: 512 Bytes

MMC read: dev # 0, block # 32768, count 81920 ... 81920 blocks read: OK
Wrong Image Format for bootm command
ERROR: can't get kernel image!

Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
---
 configs/ls1028ardb_tfa_defconfig | 1 +
 include/configs/ls1028ardb.h     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/ls1028ardb_tfa_defconfig b/configs/ls1028ardb_tfa_defconfig
index 17230d0d97..90f22ea3ba 100644
--- a/configs/ls1028ardb_tfa_defconfig
+++ b/configs/ls1028ardb_tfa_defconfig
@@ -101,3 +101,4 @@ CONFIG_USB_ETHER_ASIX88179=y
 CONFIG_USB_ETHER_RTL8152=y
 CONFIG_WDT=y
 CONFIG_WDT_SP805=y
+CONFIG_FSL_ESDHC_SUPPORT_ADMA2=y
diff --git a/include/configs/ls1028ardb.h b/include/configs/ls1028ardb.h
index d44ce45fd6..9c869ee684 100644
--- a/include/configs/ls1028ardb.h
+++ b/include/configs/ls1028ardb.h
@@ -53,6 +53,7 @@
 #define CFG_EXTRA_ENV_SETTINGS		\
 	"board=ls1028ardb\0"			\
 	"hwconfig=fsl_ddr:bank_intlv=auto\0"	\
+	"fdtfile=fsl-ls1028a-rdb.dtb\0"         \
 	"ramdisk_addr=0x800000\0"		\
 	"ramdisk_size=0x2000000\0"		\
 	"bootm_size=0x10000000\0"		\
-- 
2.34.1

