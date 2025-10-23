Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79255CCD193
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 07:57:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E200B835FE;
	Thu, 23 Oct 2025 09:57:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y+npIzEW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D40C182E34; Thu, 23 Oct 2025 04:17:46 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C584B8003E
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 04:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=heyitsmemikeyy@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-339d53f4960so338014a91.3
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 19:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761185862; x=1761790662; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3aii1d3ghumCL3gzHE2PY6fH3dK9ForSOqmTbxXH4jw=;
 b=Y+npIzEWUBg5BkAJawAxv0xMUvar5g9nGPcnHxKbMo/IFPbky2LwrnunjxOE7SVdQM
 U1rbLCzwpmp85PCPwwDsVbBtFyWXB9JiLb3Pg+fl6bZnaHnTLLxn7zRL6Af3gWNiSmbd
 BJROyYCMRnPCaof0M+PagfJnG7N1uPL+iKYdp6QMAq5k4Css0Tg3q/xluR56RnCCk9KX
 hFlK2rpuEPAl3bJrOKSnFAoPvqABZvRxyVGtFbU2xJ7glcM+NEY09q4wfC16d3oHxHn4
 SnhmIURVlO0LL5MlBv4F4kPY3gVN3ppmN/l9eH4brrrUw7sh2tAOu1O24e21HEGYt7a/
 A0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761185862; x=1761790662;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3aii1d3ghumCL3gzHE2PY6fH3dK9ForSOqmTbxXH4jw=;
 b=LXtZmlPYcOZF78Qle4yuulWA5sUAYSXg5NuL1c7IdsrPFA31xOw368O4rWRuWGsbCW
 U2W09wXDNF6d+U8VlJ8R/Q19E+AT0M5MUwy6L7YXdRVQM/hnV5BOUoFPfEKzW1cwhdGC
 YOSBosJ2KCeS8Mkcc7QYqkdY0zlCye5eLWFBToTGRZHAFNs+UglYb9vJS2Rt8k/tRTYw
 ZTcgQGKwsUL3BDc2ZZ5DqaDLLEfquX3axxwHU/phMewVJn8Vk4rhJUNv2WBye/73CTOA
 Wv6vPPytpnKbmYnwXoAiGfGRBVBCTjLNWRcclsgzd8p37Z5Ggpyd4UUmtvnvKPQia+Yq
 ASUA==
X-Gm-Message-State: AOJu0YzJ5Z/U1zyI84HrD5myOq4jVvs92AyKkCsNH1PWYy8wl6hsb8jF
 CbKp6kUy8UBIJHDWOs4HrNETO0n+aBCuQx8ZBsAKnDuh+MKGIO4rOWly7WkdoMkNFCx9SjwE4hn
 LNTX0mOl7H7EqG1V2HaOCjKldZPNR5S3urgf1
X-Gm-Gg: ASbGncsO3BH2VFsC6cRTo0kzV6lcOrV5yTMWwCW+/Qljkd9oJnI/uJiSF25gXBzVkty
 6anv1d+xk/yblwOK+dJJflgawY4aXSYfQtPuWjulwcZ9j7ITTybVgQ2oOQic9Tm7WP3TRZ3H+jP
 imt2wzfm830pgQZtILjIQ7ThVJaa9TYePxWR5xRlvxlbDahWA/NMVzh8ehrkONhXsHm0E3XjlE8
 jIoM08NCwEryjSC4ct7vpfz7s9e+lz74FZRB1zy3giABRyuejZ1dA5mJQV7JxIWw/5uFT5IaGLC
 ydwfmuQxoznEOsTQEBnLjHVbByQy
X-Google-Smtp-Source: AGHT+IEwtwNt03vPZhoVQczbri1A6xJEKOEGHIeS5Cc1jWUDeszneAsph/vUJrWj8WpbYmu1/BkreMhWYyr0Nj7Ud6Q=
X-Received: by 2002:a17:903:8c6:b0:28d:18fb:bb93 with SMTP id
 d9443c01a7336-290c9c8968cmr313549615ad.7.1761185861783; Wed, 22 Oct 2025
 19:17:41 -0700 (PDT)
MIME-Version: 1.0
From: Mikeyy M <heyitsmemikeyy@gmail.com>
Date: Thu, 23 Oct 2025 13:17:30 +1100
X-Gm-Features: AWmQ_bnRBKgSTps1MiZeA3AxjM9AbJR_AFfH_AUc4vbClhNFR5vUudG_m_QUSYc
Message-ID: <CABRivRvcniwNtwfaFBRHy41mdk7gCCBFVKqgpq-TX_kxuABrHA@mail.gmail.com>
Subject: U-Boot Not Working on Raspberry Pi 5
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Thu, 23 Oct 2025 09:57:06 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

I'm trying to set up U-Boot as a bootloader on my Raspberry Pi 5 for custom
kernel development. For some reason though, I don't ever get to the U-Boot
environment at the end where I can type and input commands. It seemingly
gets stuck after BL31 (which I believe is the Arm Trusted Firmware). Any
help would be greatly appreciated.

Setup:

   - U-Boot version: v2025.10
   - Built with: make CROSS_COMPILE=aarch64-linux-gnu- rpi_arm64_defconfig
   - Connection: Using the dedicated 3-pin debug UART header with
   USB-to-serial adapter
   - SD card has: u-boot.bin, bcm2712-rpi-5-b.dtb, and config.txt

This is my specific adapter:
https://www.amazon.com.au/Debugger-Raspberry-Connector-Debugging-Transmission/dp/B0CZP8DZK8
which I plug into my laptop, and run the command: *sudo minicom -D
/dev/ttyACM0 -b 115200*. I am specifically using the dedicated 3-pin UART
header which is new on the Rpi5.

My config.txt is

> arm_64bit=1
> kernel=u-boot.bin
> device_tree=bcm2712-rpi-5-b.dtb
> os_check=0
> # Enable UART0
> enable_uart=1
> core_freq_min=500



Here is my output after connecting to minicom:

Welcome to minicom 2.9
> OPTIONS: I18n
> Port /dev/ttyACM0, 00:28:12
> Press CTRL-A Z for help on special keys
>   1.02 RPi: BOOTSYS release VERSION:5855b10b DATE: 2025/06/13 TIME:
> 10:39:26
>   1.02 BOOTMODE: 0x06 partition 0 build-ts BUILD_TIMESTAMP=1749807566
> serial 0d57824f boardrev c049
>   1.03 AON_RESET: 00000003 PM_RSTS 00001000
>   1.04 POWER_OFF_ON_HALT: 0 WAIT_FOR_POWER_BUTTON 0 power-on-reset 1
>   1.05 RP1_BOOT chip ID: 0x20001927
>   1.05 PCIEx1: PWR 0 DET_WAKE 0
>   1.05 part 00000000 reset_info 00000000
>   1.06 PMIC reset-event 00000000 rtc 00000001 alarm 00000000 enabled 0
>   1.06 uSD voltage 3.3V
>   1.07 SDRAM_CONFIG: 15
>   1.07 Initialising SDRAM rank 2 total-size: 32 Gbit 4267 (0x15 0x15)
>   1.08 DDR 4267 1 0 32 152 BL:1
>   2.94 OTP boardrev c04171 bootrom a a
>   2.94 Customer key hash
> 0000000000000000000000000000000000000000000000000000000000000000
>   2.95 VC-JTAG unlocked
>   2.97 RP1_BOOT chip ID: 0x20001927
>   3.61 RP1_BOOT chip ID: 0x20001927
>   3.61 RP1_BOOT: fw size 46888
>   4.25 PCI2 init
>   4.25 PCI2 reset
>   4.30 PCIe scan 00001de4:00000001
>   4.30 RP1_CHIP_INFO 20001927
>   4.30 RPi: BOOTLOADER release VERSION:5855b10b DATE: 2025/06/13 TIME:
> 10:39:26
>   4.31 BOOTMODE: 0x06 partition 0 build-ts BUILD_TIMESTAMP=1749807566
> serial 0d57824f boardrev c045
>   4.32 PCIEx1: PWR 0 DET_WAKE 0
>   4.24 M.2 PCIe HAT not detected.
>   4.34 usb_pd_init status 3
>   4.34 USB_PD CONFIG 0 41
>   4.42 XHCI-STOP
>   4.42 xHC0 ver: 272 HCS: 03000440 140000f1 07ff000a HCC: 0240fe6d
>   4.43 USBSTS 1
>   4.43 xHC0 ver: 272 HCS: 03000440 140000f1 07ff000a HCC: 0240fe6d
>   4.43 xHC0 ports 3 slots 64 intrs 4
>   4.45 XHCI-STOP
>   4.45 xHC1 ver: 272 HCS: 03000440 140000f1 07ff000a HCC: 0240fe6d
>   4.45 USBSTS 1
>   4.45 xHC1 ver: 272 HCS: 03000440 140000f1 07ff000a HCC: 0240fe6d
>   4.46 xHC1 ports 3 slots 64 intrs 4
>   4.47 USB-PD: src-cap PDO object1 0x0a01912c
>   4.47 Current 3000 mA
>   4.47 Voltage 5000 mV
>   4.47 USB-PD: src-cap PDO object2 0x0002d12c
>   4.48 Current 3000 mA
>   4.48 Voltage 9000 mV
>   4.48 USB-PD: src-cap PDO object3 0x0004b12c
>   4.48 Current 3000 mA
>   4.49 Voltage 15000 mV
>   4.49 USB-PD: src-cap PDO object4 0x00064145
>   4.49 Current 3250 mA
>   4.49 Voltage 20000 mV
>   4.50 USB-PD: src-cap PDO object5 0xc0dc323c
>   4.50 USB-PD: src-cap PDO object6 0xc1a4323c
>   4.10 Boot mode: SD (01) order f4
>   9.17 SD HOST: 200000000 CTL0: 0x00800000 BUS: 400000 Hz actual: 390625
> HZ div: 512 (256) status:6
>   9.18 SD HOST: 200000000 CTL0: 0x00800f00 BUS: 400000 Hz actual: 390625
> HZ div: 512 (256) status:6
>   9.40 OCR c0ff8000 [340]
> CID: 00035344534e363447856a498e400198
> CSD: 400e0032db790001dbd37f800a404000
>   9.41 SD: bus-width: 4 spec: 2 SCR: 0x02458487 0x00000000
>   9.42 SD HOST: 200000000 CTL0: 0x00800f04 BUS: 50000000 Hz actual:
> 50000000 HZ div: 4 (2) status:2
>   9.43 MBR: 0x00000800,124733440 type: 0x0b
>   9.43 MBR: 0x00000000,       0 type: 0x00
>   9.43 MBR: 0x00000000,       0 type: 0x00
>   9.44 MBR: 0x00000000,       0 type: 0x00
>   9.46 Trying partition: 0
>   9.92 type: 32 lba: 2048 'mkfs.fat' ' NO NAME    ' clusters 1948483 (64)
>   9.49 rsc 64 fat-sectors 15232 root dir cluster 2 sectors 0 entries 0
>   9.50 FAT32 clusters 1948483
>   9.50 [sdcard] autoboot.txt not found
>   9.50 Select partition rsts 0 C(boot_partition) 0 EEPROM config 0 result 1
>   9.15 Trying partition: 1
>   9.17 type: 32 lba: 2048 'mkfs.fat' ' NO NAME    ' clusters 1948483 (64)
>   9.52 rsc 64 fat-sectors 15232 root dir cluster 2 sectors 0 entries 0
>   9.53 FAT32 clusters 1948483
>   9.40 Read config.txt bytes      122 hnd 0x76
>   9.54 [sdcard] pieeprom.upd not found
>   9.45 usb_max_current_enable default 0 max-current 3000
>   9.55 Selecting USB low current limit
>   9.55 MESS:00:00:09.557951:0: *** Restart logging
>   9.62 Read /config.txt bytes      122 hnd 0x76
>   9.66 Read /config.txt bytes      122 hnd 0x76
>   9.57 MESS:00:00:09.571810:0: Initial voltage 800000 temp 30136
>   9.77 MESS:00:00:09.772217:0: avs_2712: AVS pred 9012 901200 temp 30136
>   9.77 MESS:00:00:09.775819:0: vpred 901 mV +0
>   9.78 MESS:00:00:09.784492:0: FB framebuffer_swap 1
>   9.78 MESS:00:00:09.786357:0: Select resolution HDMI0/2 hotplug 0
> max_mode 2
>   9.79 MESS:00:00:09.793247:0: Select resolution HDMI1/2 hotplug 0
> max_mode 2
>   9.80 Loading 'bcm2712-rpi-5-b.dtb' to 0x00000000 offset 0x100
>   9.15 Read bcm2712-rpi-5-b.dtb bytes    78728 hnd 0x3c
>   9.37  /overlays/overlay_map.dtb
>   9.38  /overlays/bcm2712d0.dtbo
>   9.86 PCIEx1: PWR 0 DET_WAKE 0
>   9.80 Read /config.txt bytes      122 hnd 0x76
>   9.94 [sdcard] /cmdline.txt not found
>   9.44  /cmdline.txt
>   9.94 MESS:00:00:09.946696:0: Failed to open command line file
> 'cmdline.txt'
>  10.13 MESS:00:00:10.131602:0: RPM 0, max RPM 0
>  10.16 BMD "armstub8-2712.bin" not found
>  10.63 fs_open: 'armstub8-2712.bin'
>  10.16 Loading 'u-boot.bin' to 0x00000000 offset 0x200000
>  10.04 Read u-boot.bin bytes   700232 hnd 0x5b
>  10.20 MESS:00:00:10.206013:0: Kernel relocated to 0x80000
>  10.21 MESS:00:00:10.210874:0: Device tree loaded to 0x2efec600 (size
> 0x13957)
>  10.21 PCI1 reset
>  10.22 PCI2 reset
>  10.23 set_reboot_order 0
>  10.23 set_reboot_arg1 0
>  10.24 USB-OTG disconnect
>  10.28 MESS:00:00:10.283221:0: BSC_A no ACK
>  10.28 MESS:00:00:10.284454:0: BSC_A no ACK
>  10.28 MESS:00:00:10.288380:0: BSC_A no ACK
>  10.31 MESS:00:00:10.312311:0: BSC_B no ACK
>  10.31 MESS:00:00:10.313538:0: BSC_B no ACK
>  10.31 MESS:00:00:10.317473:0: BSC_B no ACK
>  10.34 MESS:00:00:10.341242:0: Starting OS 10341 ms
>  10.34 MESS:00:00:10.346852:0: 00000040: -> 00000480
>  10.34 MESS:00:00:10.348705:0: 00000030: -> 00100080
>  10.35 MESS:00:00:10.353418:0: 00000034: -> 00100080
>  10.35 MESS:00:00:10.358131:0: 00000038: -> 00100080
>  10.36 MESS:00:00:10.362844:0: 0000003c: -> 00100080
> NOTICE:  BL31: v2.6(release):v2.6-240-gfc45bc492
> NOTICE:  BL31: Built : 12:55:13, Dec  4 2024
