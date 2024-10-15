Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17051D1D896
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 18:30:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DF7287D1A;
	Tue, 15 Oct 2024 20:30:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A1iT6DSF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 368FE88753; Tue, 15 Oct 2024 20:30:22 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A552B80245
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 20:30:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3e3e6f14b3aso3275320b6e.0
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 11:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729017018; x=1729621818; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=cRl6w3Xen3C7UROR6qIo+Z923ABBwYyfjdbJLtYDZto=;
 b=A1iT6DSFvdPd2foMY9L2vVy0JV+an/Q8VmBmKjaMP5QAJr/wBk6wLiN1oetd7DTH+n
 iJs0bGkzFyJgiHvccVGyeBeU05vDpI99INILrXLeQ9mzsVsuZIjVobjdnOgCom0LEBO9
 dXTUmoijuMnoYcS1Mb7E0/gI5fLRSYz+0AjLbAYcNcMTivhS6FUAqay2/8TT363e/SLY
 69xEyZBkxeU+dgrTx1wcSQWwv42Rx7IC/2kkhDoa+LgBXbhwoCniuUB1Edv1Vs1eXL9Z
 WiVALuPs51+yqHIatdjbZhp31cgzjjhiCrRuyZiXg5fu4xFmiXKB0Im7FQDzf+LMl4Bu
 0qfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729017018; x=1729621818;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cRl6w3Xen3C7UROR6qIo+Z923ABBwYyfjdbJLtYDZto=;
 b=cyw196FKUyJagJn+ljoAiF4got4kyWKiNzh3ahHGFIhqj3wfyMNlZxjyANjW/HW8HQ
 6CmbSrAntG5GszTSGp4K+unBC8Zbqf80CPp8BzExgajTR8pOZ1DXorpIjdZmf67/IzUH
 rlwTpaKtIAr4r++Q/GuJFTsodk61/sVZhLj791+uzE8kujqOUMzn3f8/PgcRG7cgwfF3
 LBTRXv5bQUzQcj7dOfZBC6O1VC2rLT5KBRcqs4nHCRK3IznxdlCRUerF/lKRFYQR1d+O
 YOck7pLxk6NhyJ1ZDO7FY5BX6vE3OBgM1RUkX+95U0X5z+8URI5/iMFbjEoPA5siB2BD
 rzVg==
X-Gm-Message-State: AOJu0YwEJT9ERPsumX4OvR4Xd+qxYlo2QtmVSdxpdnWod5crnTL3GWoF
 FBGLfjJPargMr772tA/BIeJk1R04GfjrmKa2fO3qjK1I+CYkLYgDzLA1Z6oEOnJtm9dOu12Mrtm
 KzfMZ95jFX4WDpL4NuaG5tH9MZ6mMyXsA
X-Google-Smtp-Source: AGHT+IF6JTueP/b/9xNT2e+O0RKmSvjEf06DmjXGxXBOGgJLxmwdRrqKTLFo4vMB84tA5K25GK7VpwKCp96jcxXoAjg=
X-Received: by 2002:a05:6808:1205:b0:3db:3303:834c with SMTP id
 5614622812f47-3e5f051251bmr1454760b6e.39.1729017018182; Tue, 15 Oct 2024
 11:30:18 -0700 (PDT)
MIME-Version: 1.0
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 16 Oct 2024 00:00:01 +0530
Message-ID: <CANAwSgRJO1=w40ybTHkq-BD78rPyf13JdWp_yL1qpu=xmO2V8Q@mail.gmail.com>
Subject: risc-v - efi_free_pool: illegal free
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jonas Karlman <jonas@kwiboo.se>
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

Hi All,

I am trying to create a RISC-V Archlinux image for the StarFive
VisionFive 2 v1.3B SBC.
Everything worked well initially, and I successfully until I upgraded
OpenSBI and U-Boot
to the latest versions.

I followed the instructions in the U-Boot documentation:

# u-boot/doc/board/starfive/visionfive2.rst

I used the following commands to update the latest image to SPI flash:

  sf probe
  fatload mmc 1:3 $kernel_addr_r u-boot.itb
  sf update $kernel_addr_r 0x100000 $filesize

  fatload mmc 1:3 $kernel_addr_r u-boot-spl.bin.normal.out
  sf update $kernel_addr_r 0x0 $filesize

However, when booting from SPI flash, it fails and attempts to boot
the kernel image
from SD card.

Please let me know if you have any way to help resolve this issue.

Here is the log for successful booting.

[1] https://pastebin.com/SnNrpr3H

Thanks
-Anand

---
U-Boot SPL 2024.10-00741-g080bb8480a4e (Oct 09 2024 - 04:41:14 +0530)
DDR version: dc2e84f0.
Trying to boot from SPI

OpenSBI v1.5-82-g2ffa0a1
Build time: 2024-10-09 04:40:49 +0530
Build compiler: gcc version 14.2.0 (GCC)
   ____                    _____ ____ _____
  / __ \                  / ____|  _ \_   _|
 | |  | |_ __   ___ _ __ | (___ | |_) || |
 | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
 | |__| | |_) |  __/ | | |____) | |_) || |_
  \____/| .__/ \___|_| |_|_____/|____/_____|
        | |
        |_|

Platform Name             : StarFive VisionFive 2 v1.3B
Platform Features         : medeleg
Platform HART Count       : 5
Platform IPI Device       : aclint-mswi
Platform Timer Device     : aclint-mtimer @ 4000000Hz
Platform Console Device   : uart8250
Platform HSM Device       : ---
Platform PMU Device       : ---
Platform Reboot Device    : pm-reset
Platform Shutdown Device  : pm-reset
Platform Suspend Device   : ---
Platform CPPC Device      : ---
Firmware Base             : 0x40000000
Firmware Size             : 367 KB
Firmware RW Offset        : 0x40000
Firmware RW Size          : 111 KB
Firmware Heap Offset      : 0x51000
Firmware Heap Size        : 43 KB (total), 2 KB (reserved), 11 KB
(used), 29 KB (free)
Firmware Scratch Size     : 4096 B (total), 424 B (used), 3672 B (free)
Runtime SBI Version       : 2.0

Domain0 Name              : root
Domain0 Boot HART         : 4
Domain0 HARTs             : 0*,1*,2*,3*,4*
Domain0 Region00          : 0x0000000010000000-0x0000000010000fff M:
(I,R,W) S/U: (R,W)
Domain0 Region01          : 0x0000000002000000-0x000000000200ffff M:
(I,R,W) S/U: ()
Domain0 Region02          : 0x0000000040040000-0x000000004005ffff M:
(R,W) S/U: ()
Domain0 Region03          : 0x0000000040000000-0x000000004003ffff M:
(R,X) S/U: ()
Domain0 Region04          : 0x000000000c000000-0x000000000fffffff M:
(I,R,W) S/U: (R,W)
Domain0 Region05          : 0x0000000000000000-0xffffffffffffffff M:
() S/U: (R,W,X)
Domain0 Next Address      : 0x0000000040200000
Domain0 Next Arg1         : 0x0000000040400000
Domain0 Next Mode         : S-mode
Domain0 SysReset          : yes
Domain0 SysSuspend        : yes

Boot HART ID              : 4
Boot HART Domain          : root
Boot HART Priv Version    : v1.11
Boot HART Base ISA        : rv64imafdcbx
Boot HART ISA Extensions  : zihpm,sdtrig
Boot HART PMP Count       : 8
Boot HART PMP Granularity : 12 bits
Boot HART PMP Address Bits: 34
Boot HART MHPM Info       : 2 (0x00000018)
Boot HART Debug Triggers  : 8 triggers
Boot HART MIDELEG         : 0x0000000000000222
Boot HART MEDELEG         : 0x000000000000b109


U-Boot 2024.10-00741-g080bb8480a4e (Oct 09 2024 - 04:41:14 +0530)

CPU:   sifive,u74-mc
Model: StarFive VisionFive 2 v1.3B
DRAM:  8 GiB
Core:  136 devices, 26 uclasses, devicetree: board
WDT:   Not starting watchdog@13070000
MMC:   mmc@16010000: 0, mmc@16020000: 1
Loading Environment from SPIFlash... SF: Detected gd25lq128 with page
size 256 Bytes, erase size 4 KiB, total 16 MiB
*** Warning - bad CRC, using default environment

StarFive EEPROM format v2

--------EEPROM INFO--------
Vendor : StarFive Technology Co., Ltd.
Product full SN: VF7110B1-2253-D008E000-00002905
data version: 0x2
PCB revision: 0xb2
BOM revision: A
Ethernet MAC0 address: 6c:cf:39:00:38:7b
Ethernet MAC1 address: 6c:cf:39:00:38:7c
--------EEPROM INFO--------

starfive_7110_pcie pcie@2b000000: Starfive PCIe bus probed.
starfive_7110_pcie pcie@2c000000: Starfive PCIe bus probed.
In:    serial@10000000
Out:   serial@10000000
Err:   serial@10000000
Net:   eth0: ethernet@16030000, eth1: ethernet@16040000
starting USB...
Bus xhci_pci: Register 5000420 NbrPorts 5
Starting the controller
USB XHCI 1.00
scanning bus xhci_pci for devices... 2 USB Device(s) found
       scanning usb for storage devices... 0 Storage Device(s) found
Working FDT set to ff72da20
Hit any key to stop autoboot:  0
Card did not respond to voltage select! : -110
** Booting bootflow '<NULL>' with efi_mgr
Loading Boot0000 'mmc 1' failed
Loading Boot0001 'nvme 0' failed
EFI boot manager: Cannot load any image
Boot failed (err=-14)
Card did not respond to voltage select! : -110
** Booting bootflow 'mmc@16020000.bootdev.part_3' with extlinux
1:      Arch Linux Risc-V
Retrieving file: /Image
Retrieving file: /initramfs-linux.img
append: root=UUID=2b8de04b-ccd2-44f0-9406-5571a51fba02 rw console=tty1
console=ttyS0,115200 earlycon rootwait swiotlb=65536
nvme_core.default_ps_max_latency_us=2000
Retrieving file: /dtbs/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb
## Flattened Device Tree blob at 46000000
   Booting using the fdt blob at 0x46000000
Working FDT set to 46000000
   Loading Ramdisk to fdd8e000, end fe728d27 ... OK
   Loading Device Tree to 00000000fdd81000, end 00000000fdd8d480 ... OK
Working FDT set to fdd81000

Starting kernel ...

efi_free_pool: illegal free 0x00000000fe725040
efi_free_pool: illegal free 0x00000000fe722040
efi_free_pool: illegal free 0x00000000fe720040
efi_free_pool: illegal free 0x00000000fe71e040
efi_free_pool: illegal free 0x00000000fe71c040
Unhandled exception: Load access fault
EPC: 00000000fffad720 RA: 00000000fff99092 TVAL: 0000007501137dc0
EPC: 0000000040267720 RA: 0000000040253092 reloc adjusted

SP:  00000000ff72c5e0 GP:  00000000ff735e40 TP:  0000000000000004
T0:  00000000ff72c690 T1:  00000000fff4739e T2:  72326973635f6d6f
S0:  00000000fe6fb040 S1:  00000000fff47060 A0:  00000000fffb50c8
A1:  00000000fffb50c8 A2:  0000000000000010 A3:  f253f47501137dc0
A4:  0000000000000000 A5:  f253f47501137dc0 A6:  e194eddf6491caa3
A7:  0000000000000000 S2:  00000000fffd9cb8 S3:  0000000000000001
S4:  0000000000000000 S5:  0000000000000001 S6:  00000000fffd9cb8
S7:  0000000000000007 S8:  00000000ff7852c0 S9:  00000000fe729000
S10: 0000000000000001 S11: 0000000040000000 T3:  00000000fdd8afff
T4:  ffffffffffffffe0 T5:  0000000000ff0000 T6:  00000000ff785310

Code: 1463 00e6 4501 8082 87b3 00e6 8533 00e5 (c783 0007)


resetting ...
pmic_ops: cannot read pmic power register
