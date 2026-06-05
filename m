Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3021CD6E7D
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 17:45:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1375849AF;
	Fri,  5 Jun 2026 19:45:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KIukB6FF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28D0C849BB; Fri,  5 Jun 2026 19:45:50 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 746DB8499C
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 19:45:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-bec4ac6a9a0so23798366b.3
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 10:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780681547; x=1781286347; darn=lists.denx.de;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LCzvbB+oJ5HMSfqu3kSMipZO9Qa/5ClCbOwJV2v6sCo=;
 b=KIukB6FFPN7X35606gzC8yggrqfOQW8BoYmi88xtQvfB3n+JW+T8QMxz+bhlrsZ1d8
 scmppATMl7IlvWU+ftdESgK38ypNTTHxp+BRketDBanoWyNZZc6TCOkxFeoU1lwcVUpA
 E2Ob//S51efw3KNDIEEvcozclN/9QQ1Jf1gbsVUD/x2SioGy4TjEG9guyklNt80t+pVE
 R3jO/p4wYTbP9DIhaJYNAC6xEP3gw+rwNVdawdlS+UFHaJTu20j+HIeZcYWYvRIY5+Jq
 Y0aHy7WPcXP+9OfWZssnlqKWxmikrdeHefTL7b1cqB7uPvvYItSfACYTN7OOYbVoVtxm
 uCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780681547; x=1781286347;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LCzvbB+oJ5HMSfqu3kSMipZO9Qa/5ClCbOwJV2v6sCo=;
 b=iAYw0qaXBEtjN582BmXtesMT5jDUB7QINC0U96XLvj8JQyyUw7F1Nqn/7KEip0bEUG
 T1qQnD+XSCGXdFVqRtgdEFEzs1mZQzM9HzcO2LG0hp1ATQ0H+K7RyyxbeODn5QNDEOZV
 xHxrIVpFtwuMXLNumee5vH7SOzcLGsdsl/tOnN+yyvx/XIHLhHG7i+W6eGQSnFFdlTI2
 fcUICKcaB+K5eDzck33I1nKFA2GoARlRKwpVQxbl2WIqZpVQT1qY9GlqPsjwwzknJiVp
 y49lEyik0loggi/O1GB9dCqh5xmVzWLtiOO5NI4ToJB8ATYP/3bGxoHb761/JEAPO3OE
 8BPQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/7Y4+h9bbmXVfEj1sitOj+GuqNFDisJtBbhxwJ5KtPcm5TW+roQ3BE08ZFulF3aq8PTXXeYB4=@lists.denx.de
X-Gm-Message-State: AOJu0YznYCj97t1xQds264So+Z88C7OJTRoo9VXtlK2EuGdaGrITPYtM
 7ktZEM0jMs7nmx7fxRUTC8aYUvh88CeDQBqXv8UaukhtZYuiuTH6wt35
X-Gm-Gg: Acq92OH/JPUV1GtKSNvzkydI8x3DDf4tkMn+Hr3bfOlMGEt1/armdtwclJndUqGPCp1
 ljYvSXWGANtMVEbNHiUqo/Sex3Bzc7kGKnORybELq7p5Y8S0zi5i2aU0Sz9jAN6KOfdnGJIa6cR
 eQflbR85KbSgPjsRHAV866jLMNY3CWu9Qv5bOJBDciYOgUCBM2cjO1CKtGyCR55wwJpTgcF0T3P
 Kfq8bbsDHXI2tG/V3Dj5ggqJ4q+nMrsIUyVmcVRh9PcIsFomgD+hHu7EkLx+oXNzxjaxD1dUz93
 qXEYpd6CsNDQQh9uhs/RUr3kzShfaXP9I/3hgFpGEp1NOXZcd2h2BQXNHxyY2O755rAscsRv8Te
 6743qlrU3CyzitmwwDtI/w2pu7iWEk2s1ghAyS082pBnIeMEwF1RaAIa5JKzzMo+Xo6XZnolYDt
 8+wUyA30//s7t4PzxNxbw/4sBkFGtTgmnQGrg8/fxjKkXUvCLobRFywqZ8h5UN7QXuxQeXRbblY
 sA4fJHCmQA=
X-Received: by 2002:a17:907:7351:b0:bec:19c3:51f6 with SMTP id
 a640c23a62f3a-bf36cecc9cfmr99256466b.0.1780681546424; 
 Fri, 05 Jun 2026 10:45:46 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf0558f3885sm487175166b.54.2026.06.05.10.45.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2026 10:45:45 -0700 (PDT)
Message-ID: <e1a0fa32-5418-4f66-98ae-f0e85451dcd2@gmail.com>
Date: Fri, 5 Jun 2026 19:45:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] doc: clean up README.rockchip
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 u-boot@lists.denx.de
Content-Language: en-US, ar-EG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Clean up README.rockchip for info that's already in
rockchip.rst or no longer applicable for the subjects:

Prerequisites
Building
Writing
Booting (except for rk3036/rk3188)
Using fastboot on rk3288
Booting from SPI
Future work
Development Notes
Device tree and driver model

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 doc/README.rockchip | 563 --------------------------------------------
 1 file changed, 563 deletions(-)

diff --git a/doc/README.rockchip b/doc/README.rockchip
index 96fa49d697bc..82df9d084439 100644
--- a/doc/README.rockchip
+++ b/doc/README.rockchip
@@ -13,260 +13,9 @@ Warning
 This document is being moved to doc/board/rockchip, so information on it
 might be incomplete or outdated.

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
 Booting from an SD card
 =======================

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
 For evb_rk3036 board:
 	./evb-rk3036/tools/mkimage -n rk3036 -T rksd  -d evb-rk3036/spl/u-boot-spl.bin out && \
 	cat evb-rk3036/u-boot-dtb.bin >> out && \
@@ -280,23 +29,6 @@ Or:
 Note: rk3036 SDMMC and debug uart use the same iomux, so if you boot from SD, the
       debug uart must be disabled

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
 Booting from an SD card on RK3188
 =================================

@@ -321,291 +53,6 @@ tools/mkimage -n rk3188 -T rksd -d spl/u-boot-spl.bin out
 truncate -s %2048 u-boot.bin
 cat u-boot.bin | split -b 512 --filter='openssl rc4 -K 7C4E0304550509072D2C7B38170D1711' >> out

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
 rkimage
 -------

@@ -657,16 +104,6 @@ rkmux.py
 You can use this script to create #defines for SoC register access. See the
 script for usage.

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
 GPT partition layout
 ----------------------------

--
2.39.5

