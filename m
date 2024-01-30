Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2523CC46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 21:45:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D8AB878CB;
	Tue, 30 Jan 2024 22:45:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QOKaFyKv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFF428792D; Tue, 30 Jan 2024 22:30:02 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC72A875FC
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 22:29:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephen.graf@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d8da50bfd9so15004895ad.1
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 13:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706650198; x=1707254998; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P8AOBi40VDTlU03/hJQ9M2O8GUEpP3sPbr8dwGDMaBg=;
 b=QOKaFyKvZ+8/eTH8zdR5LEW17X+uMsGfyS4bZC3MPs9SXB6dxJlQShH49cN7IQR6X7
 umlig+iBQCTMtNXcjmbfbt5IJtGQ7Y/Pfa9BtVjdfqKxLmkT0mNKb9QJoctuNfW7Aqym
 wSePvtvS9YzquMyXbg080JWK23qYq+Fr9AhdqX7GDU6vbf/lMVdgF2VJJJTYvCL7PUye
 WwjDaAt7cxmZYvG0RRuuKZ1E0CEGRyCmWwDGpDDqFV5jttlseU+VP/GjROnyzvuCoxAP
 ePrF2z4RZeXiaVEGmOMqPJxHJ4hxWGJ0gsJDb+eFb5CnSM4xCBZzqogcjFrY1ZmdoHj/
 epbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706650198; x=1707254998;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=P8AOBi40VDTlU03/hJQ9M2O8GUEpP3sPbr8dwGDMaBg=;
 b=LGX5Kc0jxgMGDjsID4GHQm6777wInRQYBYEpFTrTRmKOgNTTur80V0+Rw6irAU+CJa
 JdfRBwBlEN658+M8Jk/DDo/jmARKB9zAkpgFOrwUkJJszh5R0eJF2y/tjxeAa13agqKX
 FcRTqxlrG3Osq7V7TTaCqc/MueiXNV2weSqOGfdwS4pu7SIbifS6ca7OzIyG7E2GepUh
 DltFEg1q4x4lIW0ayMGs+ydkZkO+GP/rsecVYz52PRoYpxr/x2UtKLNZ8zz00BKkdhHs
 OZKaKfAz5gVm9XfC2LuDwDKaqkGbNcaZU+csWcWP945IANeSHoLD9oAgxJtnWDprAk/T
 9/Yg==
X-Gm-Message-State: AOJu0YyKZm5lD4Dxl+EiJGuJIf/kKk8X6WzkYhwmLntlQBBLMEbqFZdQ
 QMaGVVhRYbTvx2jxs9OKb2VTochHffL9Yd8AlcwkPVkfCmisDndx431Sz2Sl
X-Google-Smtp-Source: AGHT+IG3Q0eiNAQiWXhX4X80afOyJ6np0BwYwxZ8vMY4XlofNLFlv9CC8VFercYXjbqXl37Q9pKIWg==
X-Received: by 2002:a17:902:e5c3:b0:1d8:b473:b316 with SMTP id
 u3-20020a170902e5c300b001d8b473b316mr692246plf.49.1706650197840; 
 Tue, 30 Jan 2024 13:29:57 -0800 (PST)
Received: from [192.168.1.3] (d23-16-72-139.bchsia.telus.net. [23.16.72.139])
 by smtp.gmail.com with ESMTPSA id
 jy12-20020a17090342cc00b001d8d04472absm4897683plb.154.2024.01.30.13.29.57
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 13:29:57 -0800 (PST)
Message-ID: <f252aa37-c672-4fda-903b-8ec033bc35b2@gmail.com>
Date: Tue, 30 Jan 2024 13:29:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-CA
To: U-Boot Mailing List <u-boot@lists.denx.de>
From: Stephen Graf <stephen.graf@gmail.com>
Subject: usb3 device not detected on usb2 port
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 30 Jan 2024 22:45:22 +0100
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

I am using an orangepizero3 and trying to boot from spi flash and then a usb3 SSD on usb-1 port, which is usb2.  U-boot does not detect the usb3 SSD drive.

I have been booting Armbian regularly from an old usb2 hard disk drive in the same way.

After Armbian starts the usb3 SSD drive is detected by the os and works properly in the os.  Some console log output below shows the issue.

Has anyone experienced this?

*** boot from SD card

U-Boot 2024.01-rc5-armbian (Jan 13 2024 - 14:13:09 +0000) Allwinner Technology

CPU:   Allwinner H616 (SUN50I)
Model: OrangePi Zero3
DRAM:  1 GiB
Core:  57 devices, 25 uclasses, devicetree: separate
WDT:   Not starting watchdog@30090a0
MMC:   mmc@4020000: 0
Loading Environment from FAT... Unable to use mmc 0:1...
In:    serial@5000000
Out:   serial@5000000
Err:   serial@5000000
Allwinner mUSB OTG (Peripheral)
Net:   Unsupported value 13, using default (13)
Unsupported value 13, using default (13)
eth0: ethernet@5020000using musb-hdrc, OUT ep1out IN ep1in STATUS ep2in
MAC de:ad:be:ef:00:01
HOST MAC de:ad:be:ef:00:00
RNDIS ready
, eth1: usb_ether
starting USB...
Bus usb@5200000: USB EHCI 1.00
Bus usb@5200400: USB OHCI 1.0
scanning bus usb@5200000 for devices... 1 USB Device(s) found
scanning bus usb@5200400 for devices... 1 USB Device(s) found
        scanning usb for storage devices... 0 Storage Device(s) found
Autoboot in 1 seconds, press <Space> to stop
switch to partitions #0, OK
mmc0 is current device
Scanning mmc 0:1...
Found U-Boot script /boot/boot.scr

*** test usb3 SSD in usb-1 after boot

root@orangepizero3:~# lsusb
Bus 009 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 004 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 008 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 005 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 002 Device 002: ID 152d:0578 JMicron Technology Corp. / JMicron USA Technology Corp. JMS578 SATA 6Gb/s
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 006 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 007 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub


root@orangepizero3:~# mount /dev/sda1 /mnt
mount: (hint) your fstab has been modified, but systemd still uses
        the old version; use 'systemctl daemon-reload' to reload.
root@orangepizero3:~# ls -alh /mnt
total 88K
drwxr-xr-x 19 root root 4.0K Jan 29 21:37 .
drwxr-xr-x 19 root root 4.0K Jan 16 12:29 ..
lrwxrwxrwx  1 root root    7 Jan 13 02:56 bin -> usr/bin
drwxr-xr-x  3 root root 4.0K Jan 29 21:39 boot
drwxr-xr-x  2 root root 4.0K Jan 29 21:30 dev
drwxr-xr-x 96 root root 4.0K Jan 29 21:37 etc
drwxr-xr-x  2 root root 4.0K Dec  9 13:08 home
lrwxrwxrwx  1 root root   34 Jan 29 21:32 initrd.img -> boot/initrd.img-6.7.2-edge-sunxi64
lrwxrwxrwx  1 root root   34 Jan 29 21:32 initrd.img.old -> boot/initrd.img-6.7.2-edge-sunxi64
lrwxrwxrwx  1 root root    7 Jan 13 02:56 lib -> usr/lib
drwx------  2 root root  16K Jan 29 21:37 lost+found
drwxr-xr-x  2 root root 4.0K Jan 13 02:56 media
drwxr-xr-x  2 root root 4.0K Jan 13 02:56 mnt
drwxr-xr-x  2 root root 4.0K Jan 13 02:56 opt
drwxr-xr-x  2 root root 4.0K Jan 13 02:56 proc
drwx------  3 root root 4.0K Jan 29 21:34 root
drwxr-xr-x  4 root root 4.0K Jan 29 21:38 run
lrwxrwxrwx  1 root root    8 Jan 13 02:56 sbin -> usr/sbin
drwxrwxr-x  2 root root 4.0K Jan 29 21:30 selinux
drwxr-xr-x  2 root root 4.0K Jan 13 02:56 srv
drwxr-xr-x  2 root root 4.0K Dec  9 13:08 sys
drwxrwxrwt  2 root root 4.0K Jan 13 02:57 tmp
drwxr-xr-x 11 root root 4.0K Jan 13 02:56 usr
drwxr-xr-x 12 root root 4.0K Jan 29 21:30 var
lrwxrwxrwx  1 root root   31 Jan 29 21:32 vmlinuz -> boot/vmlinuz-6.7.2-edge-sunxi64
lrwxrwxrwx  1 root root   31 Jan 29 21:32 vmlinuz.old -> boot/vmlinuz-6.7.2-edge-sunxi64



*** boot from spi flash and usb2 hard drive in usb-1

U-Boot 2024.01-rc5-armbian (Dec 25 2023 - 16:25:36 -0800) Allwinner Technology

CPU:   Allwinner H616 (SUN50I)
Model: OrangePi Zero3
DRAM:  1 GiB
Core:  57 devices, 25 uclasses, devicetree: separate
WDT:   Not starting watchdog@30090a0
MMC:   mmc@4020000: 0
Loading Environment from SPIFlash... SF: Detected zb25vq128 with page size 256 Bytes, erase size 4 KiB, total 16 MiB
OK
In:    serial@5000000
Out:   serial@5000000
Err:   serial@5000000
Allwinner mUSB OTG (Peripheral)
Net:   Unsupported value 13, using default (13)
Unsupported value 13, using default (13)
eth0: ethernet@5020000using musb-hdrc, OUT ep1out IN ep1in STATUS ep2in
MAC de:ad:be:ef:00:01
HOST MAC de:ad:be:ef:00:00
RNDIS ready
, eth1: usb_ether
starting USB...
Bus usb@5200000: USB EHCI 1.00
Bus usb@5200400: USB OHCI 1.0
scanning bus usb@5200000 for devices... 2 USB Device(s) found
scanning bus usb@5200400 for devices... 1 USB Device(s) found
        scanning usb for storage devices... 1 Storage Device(s) found
Autoboot in 2 seconds, press <Space> to stop
Card did not respond to voltage select! : -110

Device 0: Vendor: Toshiba  Rev: 0001 Prod: External USB 3.0
             Type: Hard Disk
             Capacity: 476940.0 MB = 465.7 GB (976773168 x 512)
... is now current device
Scanning usb 0:1...
Found U-Boot script /boot/boot.scr


*** boot from spi flash and usb3 SSD in usb-1

U-Boot 2024.01-rc5-armbian (Dec 25 2023 - 16:25:36 -0800) Allwinner Technology

CPU:   Allwinner H616 (SUN50I)
Model: OrangePi Zero3
DRAM:  1 GiB
Core:  57 devices, 25 uclasses, devicetree: separate
WDT:   Not starting watchdog@30090a0
MMC:   mmc@4020000: 0
Loading Environment from SPIFlash... SF: Detected zb25vq128 with page size 256 Bytes, erase size 4 KiB, total 16 MiB
OK
In:    serial@5000000
Out:   serial@5000000
Err:   serial@5000000
Allwinner mUSB OTG (Peripheral)
Net:   Unsupported value 13, using default (13)
Unsupported value 13, using default (13)
eth0: ethernet@5020000using musb-hdrc, OUT ep1out IN ep1in STATUS ep2in
MAC de:ad:be:ef:00:01
HOST MAC de:ad:be:ef:00:00
RNDIS ready
, eth1: usb_ether
starting USB...
Bus usb@5200000: USB EHCI 1.00
Bus usb@5200400: USB OHCI 1.0
scanning bus usb@5200000 for devices... 1 USB Device(s) found
scanning bus usb@5200400 for devices... 1 USB Device(s) found
        scanning usb for storage devices... 0 Storage Device(s) found
Autoboot in 2 seconds, press <Space> to stop
Card did not respond to voltage select! : -110

Device 0: unknown device


boot from SD card with usb3 SSD in usb1

U-Boot 2024.01-rc5-armbian (Jan 13 2024 - 14:13:09 +0000) Allwinner Technology

CPU:   Allwinner H616 (SUN50I)
Model: OrangePi Zero3
DRAM:  1 GiB
Core:  57 devices, 25 uclasses, devicetree: separate
WDT:   Not starting watchdog@30090a0
MMC:   mmc@4020000: 0
Loading Environment from FAT... Unable to use mmc 0:1...
In:    serial@5000000
Out:   serial@5000000
Err:   serial@5000000
Allwinner mUSB OTG (Peripheral)
Net:   Unsupported value 13, using default (13)
Unsupported value 13, using default (13)
eth0: ethernet@5020000using musb-hdrc, OUT ep1out IN ep1in STATUS ep2in
MAC de:ad:be:ef:00:01
HOST MAC de:ad:be:ef:00:00
RNDIS ready
, eth1: usb_ether
starting USB...
Bus usb@5200000: USB EHCI 1.00
Bus usb@5200400: USB OHCI 1.0
scanning bus usb@5200000 for devices... 1 USB Device(s) found
scanning bus usb@5200400 for devices... 1 USB Device(s) found
        scanning usb for storage devices... 0 Storage Device(s) found
Autoboot in 1 seconds, press <Space> to stop
switch to partitions #0, OK
mmc0 is current device
Scanning mmc 0:1...
Found U-Boot script /boot/boot.scr
