Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A4CC55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 11:12:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2CB0680E06;
	Thu,  6 Aug 2026 11:12:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GQB2Zd_wuDGk; Thu,  6 Aug 2026 11:12:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5555780A95
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786014765;
	bh=a0oY5xsiT9ck6KSAFOd058b2vdpkE+6Amu/SvPq4tDU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VfZG9kkovxt7MNwfoYWGVwXqiOqq11t07BEi3wEbymbWtIfJwPRW79t3/cBNSvIIn
	 jrUx/LlkO1sxAjt5fRIYGrWh08oxrSupy8zj7sx9rAoYD1USN0SzoQm+BcOEt04dv9
	 MCSXs0xgDNSNs1cFlfgofu+363EeooyhqCcD3v3b8Yzlp80ORwm4xU4ear/vHsgzLm
	 rt/B2j+PYmPk4QoX2kXRJGM+H4vz5xIT62OEvnAV6PuPZU1p+V+U512pDU7RbFwsxC
	 vJ9NLp+I+gLAvi/5B3kMY0/VtKo9MUrRPiGp0yNt6inIfQ2gTwflBZWqoA07IGg80O
	 W6RW3DOXzI/0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5555780A95;
	Thu,  6 Aug 2026 11:12:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 03FF9282
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:12:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DEEFC40265
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:12:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vBA39mfs81Lg for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 11:12:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0003C40262
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0003C40262
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0003C40262
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:12:41 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c16879184e7so19118666b.3
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 04:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786014760; x=1786619560;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a0oY5xsiT9ck6KSAFOd058b2vdpkE+6Amu/SvPq4tDU=;
 b=VKchkM9kfVGNL4wi7swYIXnHFeB2M/HO6WkgVkNhO9Ih99DwhYVcVjdGOKFhdBbwrC
 69HQJbsIWbTgnHHiMsL7zObkQKJCe1P0M+yjHs/JRjX0M0UhAHctJwSmUdw8Ie3Wguns
 qcz67pjxuDvWIAhF+ACv9gL6+6PLkzwLJ0PsPpFSjHty0dOxC78QcO663nnWGt7Y1qIZ
 tTaChxNgtoSnYrJ3f9quFfDMUP/FKHj/dUFNd8GLtASXnrovVPD14jYuWDa+eS9nTUm8
 09tEK/nr/jWOSel1Erw2KZk0iEaQBAXqTiRjkdg6xUTjM1VLWhZ81np8rj1CLjfh0tDk
 8jvQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq/y5QLGJvlf9OXUQfgm2J1uPU02BdwIRsmxB7lU5E3PvtlT5Mo2UUJYAPHQvJs304U+f9nclE=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Ywe7NcdbVsHfIzZ+SqCXQ6eHkgtLs+pId5bBJfXCoi9PJc+q2YX
 cSNRqNv5oVBYHP/+rKpbkk0HUzua2b2T1ybqv3+8bHfzJsr0d2Idmu23
X-Gm-Gg: AR+sD13sSo9CKMxQ2z1z9zUA/Jlx5895tfXISqc4vjZBjBZSWr9Mv33qhkILSkaUwDp
 Qw1VBnZWnAcfW6zMybYPs8WEpHNDQZm0OS+SLWXOjubsjxwgxatbWhr2OruXFFjsRmaKnK2m39t
 kpJtZ36PKS1a5H9nFw7ndDMpyDolq0ZysOZuQoK51oiytUlFGBUpqi1H6Zicbqq9qsS3mTU75DR
 mtQxZM4YNhg+Yqvy9zEadrXmvCqmr2j0ahbMCAVgt6N4Nuj7ke2c5WxJXLVjc352/rIbAUxUXlo
 519gWdQVFCiIPWAoKAFM3j9XWKyxoMgkA45qhmHjo6cxcsDvyRDLBNEdKuLsmWrePeV+09D+lOy
 4VH+7AM6e+5YWaoY+TKgQrhfTuJssnre5yQr/43+Vthlf0SriWHJg1sP9FiWx+zxwSDshIWNUQj
 NGGmsSkuo5LCLqrmPHipKVL3mZmS/WxxswetAC7n8I5bOa5/f/6H3DgKEwvGZIZn1TpItV1M7fu
 lgvkDC3Hgw7TmoVGi1DnUZwWG8=
X-Received: by 2002:a17:907:c386:b0:c16:1290:11a7 with SMTP id
 a640c23a62f3a-c2039b38e14mr384917166b.1.1786014759357; 
 Thu, 06 Aug 2026 04:12:39 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c203645808dsm231894966b.55.2026.08.06.04.12.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 04:12:38 -0700 (PDT)
Message-ID: <d77e3e79-2c79-4fa8-b6fd-d37fe04f8d6b@gmail.com>
Date: Thu, 6 Aug 2026 13:12:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 9/9] rockchip: doc: remove README.rockchip
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <0ce61246-3191-4ce2-a7ea-8ab3c02cfe80@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <0ce61246-3191-4ce2-a7ea-8ab3c02cfe80@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786014760; x=1786619560;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=a0oY5xsiT9ck6KSAFOd058b2vdpkE+6Amu/SvPq4tDU=;
 b=m7LRmmloBUlLxw0W7555Fe8nXNtEew3h2OBTTy13YBKyU25m38A/LP7jah/hOCKi2Z
 Lwwf2DxTxQAX1A3Ls7zFLmJuTshn6H8Qg8ZvTDe9Zd+ka9xzXPTuDKoyTfHt3wDC4jAK
 w0zeFPvsWRsSB2TytTU8xGB7VxuzymQS0N92aU1QcAzHN5QCpZC2/FpRkkB1s2r3bhe1
 D50nHsBlukW0gDbvhePhjZmoyxOukHceJWT8lZbNq48+C4rk6NQSAOG1rOZFzAh9HjIV
 SbIsMMN2daUT8RROKQmChpyLmV4Eu52sD/uoIG8t5O+ykdtSkvPMQTcX8SeU6mBxzMoT
 YA8g==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=m7LRmmlo
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Remove README.rockchip for info that's already in
rockchip.rst or no longer applicable.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 doc/README.rockchip | 677 --------------------------------------------
 1 file changed, 677 deletions(-)
 delete mode 100644 doc/README.rockchip

diff --git a/doc/README.rockchip b/doc/README.rockchip
deleted file mode 100644
index 5a608ed0bce3..000000000000
--- a/doc/README.rockchip
+++ /dev/null
@@ -1,677 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Copyright (C) 2015 Google. Inc
-# Written by Simon Glass <sjg@chromium.org>
-
-U-Boot on Rockchip
-==================
-
-A wide range of Rockchip SoCs are supported in mainline U-Boot
-
-Warning
-=======
-This document is being moved to doc/board/rockchip, so information on it
-might be incomplete or outdated.
-
-Prerequisites
-=============
-
-You will need:
-
-   - Firefly RK3288 board or something else with a supported RockChip SoC
-   - Power connection to 5V using the supplied micro-USB power cable
-   - Separate USB serial cable attached to your computer and the Firefly
-        (connect to the micro-USB connector below the logo)
-   - rkflashtool [3]
-   - openssl (sudo apt-get install openssl)
-   - Serial UART connection [4]
-   - Suitable ARM cross compiler, e.g.:
-        sudo apt-get install gcc-4.7-arm-linux-gnueabi
-
-Building
-========
-
-1. To build RK3288 board:
-
-   CROSS_COMPILE=arm-linux-gnueabi- make O=firefly firefly-rk3288_defconfig all
-
-    (or you can use another cross compiler if you prefer)
-
-2. To build RK3308 board:
-
-   See doc/board/rockchip/rockchip.rst
-
-3. To build RK3399 board:
-
-   Option 1: Package the image with Rockchip miniloader:
-
-   - Compile U-Boot
-
-     => cd /path/to/u-boot
-     => make nanopi-neo4-rk3399_defconfig
-     => make
-
-   - Get the rkbin
-
-     => git clone https://github.com/rockchip-linux/rkbin.git
-
-   - Create trust.img
-
-     => cd /path/to/rkbin
-     => ./tools/trust_merger RKTRUST/RK3399TRUST.ini
-
-   - Create uboot.img
-
-     => cd /path/to/rkbin
-     => ./tools/loaderimage --pack --uboot /path/to/u-boot/u-boot-dtb.bin uboot.img
-
-     (Get trust.img and uboot.img)
-
-   Option 2: Package the image with SPL:
-
-   - Export cross compiler path for aarch64
-
-   - Compile ATF
-
-     => git clone https://github.com/TrustedFirmware-A/trusted-firmware-a.git
-     => cd trusted-firmware-a
-
-     (export cross compiler path for Cortex-M0 MCU likely arm-none-eabi-)
-     => make realclean
-     => make CROSS_COMPILE=aarch64-linux-gnu- PLAT=rk3399
-
-    (export bl31.elf)
-    => export BL31=/path/to/trusted-firmware-a/build/rk3399/release/bl31/bl31.elf
-
-   - Compile PMU M0 firmware
-
-     This is optional for most of the rk3399 boards.
-
-     => git clone git://git.theobroma-systems.com/rk3399-cortex-m0.git
-     => cd rk3399-cortex-m0
-
-     (export cross compiler path for Cortex-M0 PMU)
-     => make CROSS_COMPILE=arm-cortex_m0-eabi-
-
-     (export rk3399m0.bin)
-     => export PMUM0=/path/to/rk3399-cortex-m0/rk3399m0.bin
-
-   - Compile U-Boot
-
-     => cd /path/to/u-boot
-     => make orangepi-rk3399_defconfig
-     => make
-
-     (Get spl/u-boot-spl-dtb.bin, u-boot.itb images and some boards would get
-      spl/u-boot-spl.bin since it doesn't enable CONFIG_SPL_OF_CONTROL
-
-      If TPL enabled on the target, get tpl/u-boot-tpl-dtb.bin or tpl/u-boot-tpl.bin
-      if CONFIG_TPL_OF_CONTROL not enabled)
-
-Writing to the board with USB
-=============================
-
-For USB to work you must get your board into ROM boot mode, either by erasing
-your MMC or (perhaps) holding the recovery button when you boot the board.
-To erase your MMC, you can boot into Linux and type (as root)
-
-   dd if=/dev/zero of=/dev/mmcblk0 bs=1M
-
-Connect your board's OTG port to your computer.
-
-To create a suitable image and write it to the board:
-
-   ./firefly-rk3288/tools/mkimage -n rk3288 -T rkimage -d \
-	./firefly-rk3288/spl/u-boot-spl-dtb.bin out && \
-   cat out | openssl rc4 -K 7c4e0304550509072d2c7b38170d1711 | rkflashtool l
-
-If all goes well you should something like:
-
-   U-Boot SPL 2015.07-rc1-00383-ge345740-dirty (Jun 03 2015 - 10:06:49)
-   Card did not respond to voltage select!
-   spl: mmc init failed with error: -17
-   ### ERROR ### Please RESET the board ###
-
-You will need to reset the board before each time you try. Yes, that's all
-it does so far. If support for the Rockchip USB protocol or DFU were added
-in SPL then we could in principle load U-Boot and boot to a prompt from USB
-as several other platforms do. However it does not seem to be possible to
-use the existing boot ROM code from SPL.
-
-
-Writing to the eMMC with USB on ROC-RK3308-CC
-=============================================
-For USB to work you must get your board into Bootrom mode,
-either by erasing the eMMC or short circuit the GND and D0
-on core board.
-
-Connect the board to your computer via tyepc.
-=> rkdeveloptool db rk3308_loader_v1.26.117.bin
-=> rkdeveloptool wl 0x40 idbloader.img
-=> rkdeveloptool wl 0x4000 u-boot.itb
-=> rkdeveloptool rd
-
-Then you will see the boot log from Debug UART at baud rate 1500000:
-DDR Version V1.26
-REGFB: 0x00000032, 0x00000032
-In
-589MHz
-DDR3
- Col=10 Bank=8 Row=14 Size=256MB
-msch:1
-Returning to boot ROM...
-
-U-Boot SPL 2020.01-rc1-00225-g34b681327f (Nov 14 2019 - 10:58:04 +0800)
-Trying to boot from MMC1
-INFO:    Preloader serial: 2
-NOTICE:  BL31: v1.3(release):30f1405
-NOTICE:  BL31: Built : 17:08:28, Sep 23 2019
-INFO:    Lastlog: last=0x100000, realtime=0x102000, size=0x2000
-INFO:    ARM GICv2 driver initialized
-INFO:    Using opteed sec cpu_context!
-INFO:    boot cpu mask: 1
-INFO:    plat_rockchip_pmu_init: pd status 0xe b
-INFO:    BL31: Initializing runtime services
-WARNING: No OPTEE provided by BL2 boot loader, Booting device without OPTEE initialization. SMC`s destined for OPTEE will rK
-ERROR:   Error initializing runtime service opteed_fast
-INFO:    BL31: Preparing for EL3 exit to normal world
-INFO:    Entry point address = 0x600000
-INFO:    SPSR = 0x3c9
-
-
-U-Boot 2020.01-rc1-00225-g34b681327f (Nov 14 2019 - 10:58:47 +0800)
-
-Model: Firefly ROC-RK3308-CC board
-DRAM:  254 MiB
-MMC:   dwmmc@ff480000: 0, dwmmc@ff490000: 1
-rockchip_dnl_key_pressed read adc key val failed
-Net:   No ethernet found.
-Hit any key to stop autoboot:  0
-Card did not respond to voltage select!
-switch to partitions #0, OK
-mmc1(part 0) is current device
-Scanning mmc 1:4...
-Found /extlinux/extlinux.conf
-Retrieving file: /extlinux/extlinux.conf
-151 bytes read in 3 ms (48.8 KiB/s)
-1:      kernel-mainline
-Retrieving file: /Image
-14737920 bytes read in 377 ms (37.3 MiB/s)
-append: earlycon=uart8250,mmio32,0xff0c0000 console=ttyS2,1500000n8
-Retrieving file: /rk3308-roc-cc.dtb
-28954 bytes read in 4 ms (6.9 MiB/s)
-Flattened Device Tree blob at 01f00000
-Booting using the fdt blob at 0x1f00000
-## Loading Device Tree to 000000000df3a000, end 000000000df44119 ... OK
-
-Starting kernel ...
-[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd042]
-[    0.000000] Linux version 5.4.0-rc1-00040-g4dc2d508fa47-dirty (andy@B150) (gcc version 6.3.1 20170404 (Linaro GCC 6.3-209
-[    0.000000] Machine model: Firefly ROC-RK3308-CC board
-[    0.000000] earlycon: uart8250 at MMIO32 0x00000000ff0c0000 (options '')
-[    0.000000] printk: bootconsole [uart8250] enabled
-
-Booting from an SD card
-=======================
-
-To write an image that boots from an SD card (assumed to be /dev/sdc):
-
-   ./firefly-rk3288/tools/mkimage -n rk3288 -T rksd -d \
-	firefly-rk3288/spl/u-boot-spl-dtb.bin out && \
-   sudo dd if=out of=/dev/sdc seek=64 && \
-   sudo dd if=firefly-rk3288/u-boot-dtb.img of=/dev/sdc seek=16384
-
-This puts the Rockchip header and SPL image first and then places the U-Boot
-image at block 16384 (i.e. 8MB from the start of the SD card). This
-corresponds with this setting in U-Boot:
-
-   #define CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR	0x4000
-
-Put this SD (or micro-SD) card into your board and reset it. You should see
-something like:
-
-   U-Boot 2016.01-rc2-00309-ge5bad3b-dirty (Jan 02 2016 - 23:41:59 -0700)
-
-   Model: Radxa Rock 2 Square
-   DRAM:  2 GiB
-   MMC:   dwmmc@ff0f0000: 0, dwmmc@ff0c0000: 1
-   *** Warning - bad CRC, using default environment
-
-   In:    serial
-   Out:   vop@ff940000.vidconsole
-   Err:   serial
-   Net:   Net Initialization Skipped
-   No ethernet found.
-   Hit any key to stop autoboot:  0
-   =>
-
-The rockchip bootrom can load and boot an initial spl, then continue to
-load a second-stage bootloader (ie. U-Boot) as soon as the control is returned
-to the bootrom. Both the RK3288 and the RK3036 use this special boot sequence.
-The configuration option enabling this is:
-
-	CONFIG_SPL_ROCKCHIP_BACK_TO_BROM=y
-
-You can create the image via the following operations:
-
-   ./firefly-rk3288/tools/mkimage -n rk3288 -T rksd -d \
-	firefly-rk3288/spl/u-boot-spl-dtb.bin out && \
-   cat firefly-rk3288/u-boot-dtb.bin >> out && \
-   sudo dd if=out of=/dev/sdc seek=64
-
-Or:
-   ./firefly-rk3288/tools/mkimage -n rk3288 -T rksd -d \
-	firefly-rk3288/spl/u-boot-spl-dtb.bin:firefly-rk3288/u-boot-dtb.bin \
-	out && \
-   sudo dd if=out of=/dev/sdc seek=64
-
-If you have an HDMI cable attached you should see a video console.
-
-For evb_rk3036 board:
-	./evb-rk3036/tools/mkimage -n rk3036 -T rksd  -d evb-rk3036/spl/u-boot-spl.bin out && \
-	cat evb-rk3036/u-boot-dtb.bin >> out && \
-	sudo dd if=out of=/dev/sdc seek=64
-
-Or:
-	./evb-rk3036/tools/mkimage -n rk3036 -T rksd -d \
-		evb-rk3036/spl/u-boot-spl.bin:evb-rk3036/u-boot-dtb.bin out && \
-	sudo dd if=out of=/dev/sdc seek=64
-
-Note: rk3036 SDMMC and debug uart use the same iomux, so if you boot from SD, the
-      debug uart must be disabled
-
-
-Booting from an SD card on RK3288 with TPL
-==========================================
-
-Since the size of SPL can't be exceeded 0x8000 bytes in RK3288, it is not possible add
-new SPL features like Falcon mode or etc.
-
-So introduce TPL so-that adding new features to SPL is possible because now TPL should
-run minimal with code like DDR, clock etc and rest of new features in SPL.
-
-As of now TPL is added on Vyasa-RK3288 board.
-
-To write an image that boots from an SD card (assumed to be /dev/mmcblk0):
-
-    sudo dd if=idbloader.img of=/dev/mmcblk0 seek=64 &&
-    sudo dd if=u-boot-dtb.img of=/dev/mmcblk0 seek=16384
-
-Booting from an SD card on RK3188
-=================================
-
-For rk3188 boards the general storage onto the card stays the same as
-described above, but the image creation needs a bit more care.
-
-The bootrom of rk3188 expects to find a small 1kb loader which returns
-control to the bootrom, after which it will load the real loader, which
-can then be up to 29kb in size and does the regular ddr init.  This is
-handled by a single image (built as the SPL stage) that tests whether
-it is handled for the first or second time via code executed from the
-boot0-hook.
-
-Additionally the rk3188 requires everything the bootrom loads to be
-rc4-encrypted. Except for the very first stage the bootrom always reads
-and decodes 2kb pages, so files should be sized accordingly.
-
-# copy tpl, pad to 1020 bytes and append spl
-tools/mkimage -n rk3188 -T rksd -d spl/u-boot-spl.bin out
-
-# truncate, encode and append u-boot.bin
-truncate -s %2048 u-boot.bin
-cat u-boot.bin | split -b 512 --filter='openssl rc4 -K 7C4E0304550509072D2C7B38170D1711' >> out
-
-Booting from an SD card on Pine64 Rock64 (RK3328)
-=================================================
-
-For Rock64 rk3328 board the following three parts are required:
-TPL, SPL, and the u-boot image tree blob.
-
-  - Write TPL/SPL image at 64 sector
-
-    => sudo dd if=idbloader.img of=/dev/mmcblk0 seek=64
-
-  - Write u-boot image tree blob at 16384 sector
-
-    => sudo dd if=u-boot.itb of=/dev/mmcblk0 seek=16384
-
-Booting from an SD card on RK3399
-=================================
-
-To write an image that boots from an SD card (assumed to be /dev/sdc):
-
-Option 1: Package the image with Rockchip miniloader:
-
-  - Create idbloader.img
-
-    => cd /path/to/u-boot
-    => ./tools/mkimage  -n rk3399 -T rksd -d /path/to/rkbin/bin/rk33/rk3399_ddr_800MHz_v1.20.bin idbloader.img
-    => cat /path/to/rkbin/bin/rk33/rk3399_miniloader_v1.19.bin >> idbloader.img
-
-  - Write idbloader.img at 64 sector
-
-    => sudo dd if=idbloader.img of=/dev/sdc seek=64
-
-  - Write trust.img at 24576
-
-    => sudo dd if=trust.img of=/dev/sdc seek=24576
-
-  - Write uboot.img at 16384 sector
-
-    => sudo dd if=uboot.img of=/dev/sdc seek=16384
-    => sync
-
-Put this SD (or micro-SD) card into your board and reset it. You should see
-something like:
-
-DDR Version 1.20 20190314
-In
-Channel 0: DDR3, 933MHz
-Bus Width=32 Col=10 Bank=8 Row=15 CS=1 Die Bus-Width=16 Size=1024MB
-no stride
-ch 0 ddrconfig = 0x101, ddrsize = 0x20
-pmugrf_os_reg[2] = 0x10006281, stride = 0x17
-OUT
-Boot1: 2019-03-14, version: 1.19
-CPUId = 0x0
-ChipType = 0x10, 239
-mmc: ERROR: SDHCI ERR:cmd:0x102,stat:0x18000
-mmc: ERROR: Card did not respond to voltage select!
-emmc reinit
-mmc: ERROR: SDHCI ERR:cmd:0x102,stat:0x18000
-mmc: ERROR: Card did not respond to voltage select!
-emmc reinit
-mmc: ERROR: SDHCI ERR:cmd:0x102,stat:0x18000
-mmc: ERROR: Card did not respond to voltage select!
-SdmmcInit=2 1
-mmc0:cmd5,20
-SdmmcInit=0 0
-BootCapSize=0
-UserCapSize=60543MB
-FwPartOffset=2000 , 0
-StorageInit ok = 45266
-SecureMode = 0
-SecureInit read PBA: 0x4
-SecureInit read PBA: 0x404
-SecureInit read PBA: 0x804
-SecureInit read PBA: 0xc04
-SecureInit read PBA: 0x1004
-SecureInit read PBA: 0x1404
-SecureInit read PBA: 0x1804
-SecureInit read PBA: 0x1c04
-SecureInit ret = 0, SecureMode = 0
-atags_set_bootdev: ret:(0)
-GPT 0x3380ec0 signature is wrong
-recovery gpt...
-GPT 0x3380ec0 signature is wrong
-recovery gpt fail!
-LoadTrust Addr:0x4000
-No find bl30.bin
-Load uboot, ReadLba = 2000
-hdr 0000000003380880 + 0x0:0x88,0x41,0x3e,0x97,0xe6,0x61,0x54,0x23,0xe9,0x5a,0xd1,0x2b,0xdc,0x2f,0xf9,0x35,
-
-Load OK, addr=0x200000, size=0x9c9c0
-RunBL31 0x10000
-NOTICE:  BL31: v1.3(debug):370ab80
-NOTICE:  BL31: Built : 09:23:41, Mar  4 2019
-NOTICE:  BL31: Rockchip release version: v1.1
-INFO:    GICv3 with legacy support detected. ARM GICV3 driver initialized in EL3
-INFO:    Using opteed sec cpu_context!
-INFO:    boot cpu mask: 0
-INFO:    plat_rockchip_pmu_init(1181): pd status 3e
-INFO:    BL31: Initializing runtime services
-INFO:    BL31: Initializing BL32
-INF [0x0] TEE-CORE:init_primary_helper:337: Initializing (1.1.0-195-g8f090d20 #6 Fri Dec  7 06:11:20 UTC 2018 aarch64)
-
-INF [0x0] TEE-CORE:init_primary_helper:338: Release version: 1.2
-
-INF [0x0] TEE-CORE:init_teecore:83: teecore inits done
-INFO:    BL31: Preparing for EL3 exit to normal world
-INFO:    Entry point address = 0x200000
-INFO:    SPSR = 0x3c9
-
-
-U-Boot 2019.04-rc4-00136-gfd121f9641-dirty (Apr 16 2019 - 14:02:47 +0530)
-
-Model: FriendlyARM NanoPi NEO4
-DRAM:  1022 MiB
-MMC:   dwmmc@fe310000: 2, dwmmc@fe320000: 1, sdhci@fe330000: 0
-Loading Environment from MMC... *** Warning - bad CRC, using default environment
-
-In:    serial@ff1a0000
-Out:   serial@ff1a0000
-Err:   serial@ff1a0000
-Model: FriendlyARM NanoPi NEO4
-Net:   eth0: ethernet@fe300000
-Hit any key to stop autoboot:  0
-=>
-
-Option 2: Package the image with SPL:
-
-  - Prefix rk3399 header to SPL image
-
-    => cd /path/to/u-boot
-    => ./tools/mkimage -n rk3399 -T rksd -d spl/u-boot-spl-dtb.bin out
-
-  - Write prefixed SPL at 64th sector
-
-    => sudo dd if=out of=/dev/sdc seek=64
-
-  - Write U-Boot proper at 16384 sector
-
-    => sudo dd if=u-boot.itb of=/dev/sdc seek=16384
-    => sync
-
-Put this SD (or micro-SD) card into your board and reset it. You should see
-something like:
-
-U-Boot SPL board init
-Trying to boot from MMC1
-
-
-U-Boot 2019.01-00004-g14db5ee998 (Mar 11 2019 - 13:18:41 +0530)
-
-Model: Orange Pi RK3399 Board
-DRAM:  2 GiB
-MMC:   dwmmc@fe310000: 2, dwmmc@fe320000: 1, sdhci@fe330000: 0
-Loading Environment from MMC... OK
-In:    serial@ff1a0000
-Out:   serial@ff1a0000
-Err:   serial@ff1a0000
-Model: Orange Pi RK3399 Board
-Net:   eth0: ethernet@fe300000
-Hit any key to stop autoboot:  0
-=>
-
-Option 3: Package the image with TPL:
-
-  - Write tpl+spl at 64th sector
-
-    => sudo dd if=idbloader.img of=/dev/sdc seek=64
-
-  - Write U-Boot proper at 16384 sector
-
-    => sudo dd if=u-boot.itb of=/dev/sdc seek=16384
-    => sync
-
-Put this SD (or micro-SD) card into your board and reset it. You should see
-something like:
-
-U-Boot TPL board init
-Trying to boot from BOOTROM
-Returning to boot ROM...
-
-U-Boot SPL board init
-Trying to boot from MMC1
-
-
-U-Boot 2019.07-rc1-00241-g5b3244767a (May 08 2019 - 10:51:06 +0530)
-
-Model: Orange Pi RK3399 Board
-DRAM:  2 GiB
-MMC:   dwmmc@fe310000: 2, dwmmc@fe320000: 1, sdhci@fe330000: 0
-Loading Environment from MMC... OK
-In:    serial@ff1a0000
-Out:   serial@ff1a0000
-Err:   serial@ff1a0000
-Model: Orange Pi RK3399 Board
-Net:   eth0: ethernet@fe300000
-Hit any key to stop autoboot:  0
-=>
-
-Using fastboot on rk3288
-========================
-- Write GPT partition layout to mmc device which fastboot want to use it to
-store the image
-
-        => gpt write mmc 1 $partitions
-
-- Invoke fastboot command to prepare
-
-        => fastboot 1
-
-- Start fastboot request on PC
-
-        fastboot -i 0x2207 flash loader evb-rk3288/spl/u-boot-spl-dtb.bin
-
-You should see something like:
-
-        => fastboot 1
-        WARNING: unknown variable: partition-type:loader
-        Starting download of 357796 bytes
-        ..
-        downloading of 357796 bytes finished
-        Flashing Raw Image
-        ........ wrote 357888 bytes to 'loader'
-
-Booting from SPI
-================
-
-To write an image that boots from SPI flash (e.g. for the Haier Chromebook or
-Bob):
-
-   ./chromebook_jerry/tools/mkimage -n rk3288 -T rkspi \
-	-d chromebook_jerry/spl/u-boot-spl-dtb.bin spl.bin && \
-   dd if=spl.bin of=spl-out.bin bs=128K conv=sync && \
-   cat spl-out.bin chromebook_jerry/u-boot-dtb.img >out.bin && \
-   dd if=out.bin of=out.bin.pad bs=4M conv=sync
-
-This converts the SPL image to the required SPI format by adding the Rockchip
-header and skipping every second 2KB block. Then the U-Boot image is written at
-offset 128KB and the whole image is padded to 4MB which is the SPI flash size.
-The position of U-Boot is controlled with this setting in U-Boot:
-
-   #define CONFIG_SYS_SPI_U_BOOT_OFFS	0x20000
-
-If you have a Dediprog em100pro connected then you can write the image with:
-
-      sudo em100 -s -c GD25LQ32 -d out.bin.pad -r
-
-When booting you should see something like:
-
-   U-Boot SPL 2015.07-rc2-00215-g9a58220-dirty (Jun 23 2015 - 12:11:32)
-
-
-   U-Boot 2015.07-rc2-00215-g9a58220-dirty (Jun 23 2015 - 12:11:32 -0600)
-
-   Model: Google Jerry
-   DRAM:  2 GiB
-   MMC:
-   Using default environment
-
-   In:    serial@ff690000
-   Out:   serial@ff690000
-   Err:   serial@ff690000
-   =>
-
-Future work
-===========
-
-Immediate priorities are:
-
-- USB host
-- USB device
-- Run CPU at full speed (code exists but we only see ~60 DMIPS maximum)
-- NAND flash
-- Boot U-Boot proper over USB OTG (at present only SPL works)
-
-
-Development Notes
-=================
-
-There are plenty of patches in the links below to help with this work.
-
-[1] https://github.com/rkchrome/uboot.git
-[2] https://github.com/linux-rockchip/u-boot-rockchip.git branch u-boot-rk3288
-[3] https://github.com/linux-rockchip/rkflashtool.git
-[4] http://wiki.t-firefly.com/index.php/Firefly-RK3288/Serial_debug/en
-
-rkimage
--------
-
-rkimage.c produces an SPL image suitable for sending directly to the boot ROM
-over USB OTG. This is a very simple format - just the string RK32 (as 4 bytes)
-followed by u-boot-spl-dtb.bin.
-
-The boot ROM loads image to 0xff704000 which is in the internal SRAM. The SRAM
-starts at 0xff700000 and extends to 0xff718000 where we put the stack.
-
-rksd
-----
-
-rksd.c produces an image consisting of 32KB of empty space, a header and
-u-boot-spl-dtb.bin. The header is defined by 'struct header0_info' although
-most of the fields are unused by U-Boot. We just need to specify the
-signature, a flag and the block offset and size of the SPL image.
-
-The header occupies a single block but we pad it out to 4 blocks. The header
-is encoding using RC4 with the key 7c4e0304550509072d2c7b38170d1711. The SPL
-image can be encoded too but we don't do that.
-
-The maximum size of u-boot-spl-dtb.bin which the boot ROM will read is 32KB,
-or 0x40 blocks. This is a severe and annoying limitation. There may be a way
-around this limitation, since there is plenty of SRAM, but at present the
-board refuses to boot if this limit is exceeded.
-
-The image produced is padded up to a block boundary (512 bytes). It should be
-written to the start of an SD card using dd.
-
-Since this image is set to load U-Boot from the SD card at block offset,
-CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR, dd should be used to write
-u-boot-dtb.img to the SD card at that offset. See above for instructions.
-
-rkspi
------
-
-rkspi.c produces an image consisting of a header and u-boot-spl-dtb.bin. The
-resulting image is then spread out so that only the first 2KB of each 4KB
-sector is used. The header is the same as with rksd and the maximum size is
-also 32KB (before spreading). The image should be written to the start of
-SPI flash.
-
-See above for instructions on how to write a SPI image.
-
-Device tree and driver model
-----------------------------
-
-Where possible driver model is used to provide a structure to the
-functionality. Device tree is used for configuration. However these have an
-overhead and in SPL with a 32KB size limit some shortcuts have been taken.
-In general all Rockchip drivers should use these features, with SPL-specific
-modifications where required.
-
-GPT partition layout
-----------------------------
-
-Rockchip use a unified GPT partition layout  in open source support.
-With this GPT partition layout, uboot can be compatilbe with other components,
-like miniloader, trusted-os, arm-trust-firmware.
-
-There are some documents about partitions in the links below.
-http://rockchip.wikidot.com/partitions
-
---
-Jagan Teki <jagan@amarulasolutions.com>
-27 Mar 2019
-Simon Glass <sjg@chromium.org>
-24 June 2015
-- 
2.39.5

