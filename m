Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14D0C4332F
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 01:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C427686F67;
	Sat, 11 Nov 2023 02:50:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="aauJLu6K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F8C286F67; Sat, 11 Nov 2023 02:50:11 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53C2986FED
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 02:50:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 35322423D3; 
 Sat, 11 Nov 2023 01:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1699667405;
 bh=e2yxYk+0BvilhZVXL35IDtY1jSuW+sALZMEXJE46FCM=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
 b=aauJLu6KDOAWB8r0PW3Uf59QrNQpYYI7KMSQilcqGR5YMTixzSPY9LvEZ23OH2zYZ
 AxbiQGuLMVS7J75bi/DOu8NHrxWdB5HnEDKEnwIO0pO4nz95kpUnUFWFE0HR63KaTh
 Rfw4uYFxoybuopfpz/2SbbcclvLolbV5U9/JdDXuMQrJttG4KWzEeTnwRqsOeYk4v5
 FX0Q3Ok/Nus+TWWij9dx0VFC0yTNbSXtKtfbamUnYPLGsBdrt8FzXF2J31+gkRyRhC
 Ms2YXUaU6c0zQRNNII+6Tve7G/UELUYDpzKYTw1lym37l5x7iwOPCY8oZPRvE3o4f0
 FLNcQiRT8dPZA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Peter Griffin <peter.griffin@linaro.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Shawn Guo <shawn.guo@linaro.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: add HiSilicon board documentation to HTML docs
Date: Sat, 11 Nov 2023 02:49:59 +0100
Message-Id: <20231111014959.24865-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Add the README files for the HiSilicon boards to the HTML documentation.
This required a bit of reformatting.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 board/hisilicon/hikey/MAINTAINERS    |   1 +
 board/hisilicon/hikey/README         | 227 --------------------
 board/hisilicon/hikey960/MAINTAINERS |   1 +
 board/hisilicon/hikey960/README      | 247 ----------------------
 board/hisilicon/poplar/MAINTAINERS   |   1 +
 board/hisilicon/poplar/README        | 288 -------------------------
 doc/board/hisilicon/hikey.rst        | 261 +++++++++++++++++++++++
 doc/board/hisilicon/hikey960.rst     | 284 +++++++++++++++++++++++++
 doc/board/hisilicon/index.rst        |  11 +
 doc/board/hisilicon/poplar.rst       | 302 +++++++++++++++++++++++++++
 doc/board/index.rst                  |   1 +
 11 files changed, 862 insertions(+), 762 deletions(-)
 delete mode 100644 board/hisilicon/hikey/README
 delete mode 100644 board/hisilicon/hikey960/README
 delete mode 100644 board/hisilicon/poplar/README
 create mode 100644 doc/board/hisilicon/hikey.rst
 create mode 100644 doc/board/hisilicon/hikey960.rst
 create mode 100644 doc/board/hisilicon/index.rst
 create mode 100644 doc/board/hisilicon/poplar.rst

diff --git a/board/hisilicon/hikey/MAINTAINERS b/board/hisilicon/hikey/MAINTAINERS
index 11088eef84..1045abe124 100644
--- a/board/hisilicon/hikey/MAINTAINERS
+++ b/board/hisilicon/hikey/MAINTAINERS
@@ -2,5 +2,6 @@ HIKEY BOARD
 M:     Peter Griffin <peter.griffin@linaro.org>
 S:     Maintained
 F:     board/hisilicon/hikey
+F:     doc/board/hisilicon/hikey.rst
 F:     include/configs/hikey.h
 F:     configs/hikey_defconfig
diff --git a/board/hisilicon/hikey/README b/board/hisilicon/hikey/README
deleted file mode 100644
index 94e8397e9b..0000000000
--- a/board/hisilicon/hikey/README
+++ /dev/null
@@ -1,227 +0,0 @@
-Introduction
-============
-
-HiKey is the first certified 96Boards Consumer Edition board. The board/SoC has: -
-* HiSilicon Kirin 6220 eight-core ARM Cortex-A53 64-bit SoC running at 1.2GHz.
-* ARM Mali 450-MP4 GPU
-* 1GB 800MHz LPDDR3 DRAM
-* 4GB eMMC Flash Storage
-* microSD
-* 802.11a/b/g/n WiFi, Bluetooth
-
-The HiKey schematic can be found here: -
-https://github.com/96boards/documentation/blob/master/consumer/hikey/hikey620/hardware-docs/HiKey_schematics_LeMaker_version_Rev_A1.pdf
-
-The SoC datasheet can be found here: -
-https://github.com/96boards/documentation/blob/master/consumer/hikey/hikey620/hardware-docs/Hi6220V100_Multi-Mode_Application_Processor_Function_Description.pdf
-
-Currently the u-boot port supports: -
-* USB
-* eMMC
-* SD card
-* GPIO
-
-The HiKey U-Boot port has been tested with l-loader, booting ATF, which then boots
-U-Boot as the bl33.bin executable.
-
-Compile from source
-===================
-
-First get all the sources
-
-  > mkdir -p ~/hikey/src ~/hikey/bin
-  > cd ~/hikey/src
-  > git clone https://github.com/96boards-hikey/edk2 -b testing/hikey960_v2.5
-  > git clone https://github.com/ARM-software/arm-trusted-firmware
-  > git clone https://github.com/96boards-hikey/l-loader -b testing/hikey960_v1.2
-  > git clone https://github.com/96boards-hikey/OpenPlatformPkg -b testing/hikey960_v1.3.4
-  > git clone https://github.com/96boards-hikey/atf-fastboot
-  > wget https://snapshots.linaro.org/96boards/reference-platform/components/uefi-staging/latest/hikey/release/hisi-idt.py
-
-Get the BL30 mcuimage.bin binary. It is shipped as part of the UEFI source.
-The latest version can be obtained from the OpenPlatformPkg repo.
-
-  > cp OpenPlatformPkg/Platforms/Hisilicon/HiKey/Binary/mcuimage.bin ~/hikey/bin/
-
-Get nvme.img binary
-  > wget -P ~/hikey/bin https://snapshots.linaro.org/96boards/reference-platform/components/uefi-staging/latest/hikey/release/nvme.img
-
-Compile U-Boot
-==============
-
-  > cd ~/hikey/src/u-boot
-  > make CROSS_COMPILE=aarch64-linux-gnu- hikey_config
-  > make CROSS_COMPILE=aarch64-linux-gnu-
-  > cp u-boot.bin ~/hikey/bin
-
-Compile ARM Trusted Firmware (ATF)
-==================================
-
-  > cd ~/hikey/src/arm-trusted-firmware
-  > make CROSS_COMPILE=aarch64-linux-gnu- all fip \
-    SCP_BL2=~/hikey/bin/mcuimage.bin \
-    BL33=~/hikey/bin/u-boot.bin DEBUG=1 PLAT=hikey
-
-Copy the resulting FIP binary
-  > cp build/hikey/debug/fip.bin ~/hikey/bin
-
-Compile ATF Fastboot
-====================
-
-  > cd ~/hikey/src/atf-fastboot
-  > make CROSS_COMPILE=aarch64-linux-gnu- PLAT=hikey DEBUG=1
-
-Compile l-loader
-================
-  > cd ~/hikey/src/l-loader
-  > ln -sf ~/hikey/src/arm-trusted-firmware/build/hikey/debug/bl1.bin
-  > ln -sf ~/hikey/src/arm-trusted-firmware/build/hikey/debug/bl2.bin
-  > ln -sf ~/hikey/src/atf-fastboot/build/hikey/debug/bl1.bin fastboot.bin
-  > make hikey PTABLE_LST=aosp-8g
-
-Copy the resulting binaries
-  > cp *.img ~/hikey/bin
-  > cp l-loader.bin ~/hikey/bin
-  > cp recovery.bin ~/hikey/bin
-
-These instructions are adapted from
-https://github.com/ARM-software/arm-trusted-firmware/blob/master/docs/plat/hikey.rst
-
-FLASHING
-========
-
-1. Connect the second jumper on J15 BOOT SEL, to go into recovery mode and flash l-loader.bin with
-the hisi-idt.py utility. Then connect a USB A to B mini cable from your PC to the USB OTG port of HiKey and execute the below command.
-
-The command below assumes HiKey enumerated as the first USB serial port
-
-  > sudo python ~/hikey/src/hisi-idt.py -d /dev/ttyUSB0 --img1 ~/hikey/bin/recovery.bin
-
-2. Once LED 0 comes on solid, HiKey board should be detected as a fastboot device.
-
-  > sudo fastboot devices
-
-0123456789ABCDEF	fastboot
-
-3. Flash the images
-
-  > sudo fastboot flash ptable ~/hikey/bin/prm_ptable.img
-  > sudo fastboot flash loader ~/hikey/bin/l-loader.bin
-  > sudo fastboot flash fastboot ~/hikey/bin/fip.bin
-  > sudo fastboot flash nvme ~/hikey/bin/nvme.img
-
-4. Disconnect second jumper on J15 BOOT SEL, and reset the board and you will now (hopefully)
-   have ATF, booting u-boot from eMMC.
-
-   Note: To get USB host working, also disconnect the USB OTG cable used for flashing. Otherwise you
-   will get 'dwc_otg_core_host_init: Timeout!' errors.
-
-See working boot trace below on UART3 available at Low Speed Expansion header: -
-
-NOTICE:  BL2: v1.5(debug):v1.5-694-g6d4f6aea
-NOTICE:  BL2: Built : 09:21:42, Aug 29 2018
-INFO:    BL2: Doing platform setup
-INFO:    ddr3 rank1 init pass
-INFO:    succeed to set ddrc 150mhz
-INFO:    ddr3 rank1 init pass
-INFO:    succeed to set ddrc 266mhz
-INFO:    ddr3 rank1 init pass
-INFO:    succeed to set ddrc 400mhz
-INFO:    ddr3 rank1 init pass
-INFO:    succeed to set ddrc 533mhz
-INFO:    ddr3 rank1 init pass
-INFO:    succeed to set ddrc 800mhz
-INFO:    Samsung DDR
-INFO:    ddr test value:0xa5a55a5a
-INFO:    BL2: TrustZone: protecting 16777216 bytes of memory at 0x3f000000
-INFO:    BL2: TrustZone: protecting 4194304 bytes of memory at 0x3e800000
-INFO:    [BDID] [fff91c18] midr: 0x410fd033
-INFO:    init_acpu_dvfs: pmic version 17
-INFO:    init_acpu_dvfs: ACPU_CHIP_MAX_FREQ=0x186a00.
-INFO:    acpu_dvfs_volt_init: success!
-INFO:    acpu_dvfs_set_freq: support freq num is 5
-INFO:    acpu_dvfs_set_freq: start prof is 0x4
-INFO:    acpu_dvfs_set_freq: magic is 0x5a5ac5c5
-INFO:    acpu_dvfs_set_freq: voltage:
-INFO:      - 0: 0x49
-INFO:      - 1: 0x49
-INFO:      - 2: 0x50
-INFO:      - 3: 0x60
-INFO:      - 4: 0x78
-NOTICE:  acpu_dvfs_set_freq: set acpu freq success!INFO:    BL2: Loading image id 2
-INFO:    Loading image id=2 at address 0x1000000
-INFO:    Image id=2 loaded: 0x1000000 - 0x1023d00
-INFO:    hisi_mcu_load_image: mcu sections 0:
-INFO:    hisi_mcu_load_image:  src  = 0x1000200
-INFO:    hisi_mcu_load_image:  dst  = 0xf6000000
-INFO:    hisi_mcu_load_image:  size = 31184
-INFO:    hisi_mcu_load_image:  [SRC 0x1000200] 0x8000 0x3701 0x7695 0x7689
-INFO:    hisi_mcu_load_image:  [DST 0xf6000000] 0x8000 0x3701 0x7695 0x7689
-INFO:    hisi_mcu_load_image: mcu sections 1:
-INFO:    hisi_mcu_load_image:  src  = 0x1007bd0
-INFO:    hisi_mcu_load_image:  dst  = 0x5e00000
-INFO:    hisi_mcu_load_image:  size = 93828
-INFO:    hisi_mcu_load_image:  [SRC 0x1007bd0] 0xf000b510 0x2103fb3d 0xf0004604 0xf003fb57
-INFO:    hisi_mcu_load_image:  [DST 0x5e00000] 0xf000b510 0x2103fb3d 0xf0004604 0xf003fb57
-INFO:    hisi_mcu_load_image: mcu sections 2:
-INFO:    hisi_mcu_load_image:  src  = 0x101ea54
-INFO:    hisi_mcu_load_image:  dst  = 0x5e16e84
-INFO:    hisi_mcu_load_image:  size = 15428
-INFO:    hisi_mcu_load_image:  [SRC 0x101ea54] 0x9 0x1020640 0x10001 0x8f0d180
-INFO:    hisi_mcu_load_image:  [DST 0x5e16e84] 0x9 0x1020640 0x10001 0x8f0d180
-INFO:    hisi_mcu_load_image: mcu sections 3:
-INFO:    hisi_mcu_load_image:  src  = 0x1022698
-INFO:    hisi_mcu_load_image:  dst  = 0x5e22a10
-INFO:    hisi_mcu_load_image:  size = 3060
-INFO:    hisi_mcu_load_image:  [SRC 0x1022698] 0x0 0x0 0x0 0x0
-INFO:    hisi_mcu_load_image:  [DST 0x5e22a10] 0x0 0x0 0x0 0x0
-INFO:    hisi_mcu_load_image: mcu sections 4:
-INFO:    hisi_mcu_load_image:  src  = 0x102328c
-INFO:    hisi_mcu_load_image:  dst  = 0x5e23604
-INFO:    hisi_mcu_load_image:  size = 2616
-INFO:    hisi_mcu_load_image:  [SRC 0x102328c] 0xf80000a0 0x0 0xf80000ac 0x0
-INFO:    hisi_mcu_load_image:  [DST 0x5e23604] 0xf80000a0 0x0 0xf80000ac 0x0
-INFO:    hisi_mcu_start_run: AO_SC_SYS_CTRL2=0
-INFO:    plat_hikey_bl2_handle_scp_bl2: MCU PC is at 0x42933301
-INFO:    plat_hikey_bl2_handle_scp_bl2: AO_SC_PERIPH_CLKSTAT4 is 0x3b018f09
-WARNING: BL2: Platform setup already done!!
-INFO:    BL2: Loading image id 3
-INFO:    Loading image id=3 at address 0xf9858000
-INFO:    Image id=3 loaded: 0xf9858000 - 0xf9860058
-INFO:    BL2: Loading image id 5
-INFO:    Loading image id=5 at address 0x35000000
-INFO:    Image id=5 loaded: 0x35000000 - 0x35061cd2
-NOTICE:  BL2: Booting BL31
-INFO:    Entry point address = 0xf9858000
-INFO:    SPSR = 0x3cd
-NOTICE:  BL31: v1.5(debug):v1.5-694-g6d4f6aea
-NOTICE:  BL31: Built : 09:21:44, Aug 29 2018
-WARNING: Using deprecated integer interrupt array in gicv2_driver_data_t
-WARNING: Please migrate to using an interrupt_prop_t array
-INFO:    ARM GICv2 driver initialized
-INFO:    BL31: Initializing runtime services
-INFO:    BL31: cortex_a53: CPU workaround for disable_non_temporal_hint was applied
-INFO:    BL31: cortex_a53: CPU workaround for 843419 was applied
-INFO:    BL31: cortex_a53: CPU workaround for 855873 was applied
-INFO:    BL31: Preparing for EL3 exit to normal world
-INFO:    Entry point address = 0x35000000
-INFO:    SPSR = 0x3c9
-
-
-U-Boot 2018.09-rc1 (Aug 22 2018 - 14:55:49 +0530)hikey
-
-DRAM:  990 MiB
-HI6553 PMIC init
-MMC:   config_sd_carddetect: SD card present
-Hisilicon DWMMC: 0, Hisilicon DWMMC: 1
-Loading Environment from FAT... Unable to use mmc 1:1... Failed (-5)
-In:    uart@f7113000
-Out:   uart@f7113000
-Err:   uart@f7113000
-Net:   Net Initialization Skipped
-No ethernet found.
-Hit any key to stop autoboot:  0
-starting USB...
-USB0:   scanning bus 0 for devices... 2 USB Device(s) found
-       scanning usb for storage devices... 0 Storage Device(s) found
-       scanning usb for ethernet devices... 0 Ethernet Device(s) found
diff --git a/board/hisilicon/hikey960/MAINTAINERS b/board/hisilicon/hikey960/MAINTAINERS
index 2c98932163..a442271443 100644
--- a/board/hisilicon/hikey960/MAINTAINERS
+++ b/board/hisilicon/hikey960/MAINTAINERS
@@ -2,5 +2,6 @@ HIKEY960 BOARD
 M:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 S:     Maintained
 F:     board/hisilicon/hikey960
+F:     doc/board/hisilicon/hikey960.rst
 F:     include/configs/hikey960.h
 F:     configs/hikey960_defconfig
diff --git a/board/hisilicon/hikey960/README b/board/hisilicon/hikey960/README
deleted file mode 100644
index 6e01862f8a..0000000000
--- a/board/hisilicon/hikey960/README
+++ /dev/null
@@ -1,247 +0,0 @@
-Introduction
-============
-
-HiKey960 is one of the 96Boards Consumer Edition board from HiSilicon.
-The board/SoC has: -
-* HiSilicon Kirin960 (HI3660) SoC with 4xCortex-A73 and 4xCortex-A53
-* ARM Mali G71 MP8 GPU
-* 3GB LPDDR4 SDRAM
-* 32GB UFS Flash Storage
-* microSD
-* 802.11a/b/g/n WiFi, Bluetooth
-
-More information about this board can be found in 96Boards website:
-https://www.96boards.org/product/hikey960/
-
-Currently the u-boot port supports: -
-* SD card
-
-Compile from source
-===================
-
-First get all the sources
-
-  > mkdir -p ~/hikey960/src ~/hikey960/bin
-  > cd ~/hikey960/src
-  > git clone https://github.com/ARM-software/arm-trusted-firmware
-  > git clone https://github.com/96boards-hikey/OpenPlatformPkg -b testing/hikey960_v1.3.4
-  > git clone https://github.com/96boards-hikey/l-loader -b testing/hikey960_v1.2
-  > wget http://snapshots.linaro.org/reference-platform/components/uefi-staging/123/hikey960/release/config
-  > wget http://snapshots.linaro.org/reference-platform/components/uefi-staging/123/hikey960/release/hisi-sec_usb_xloader.img
-  > wget http://snapshots.linaro.org/reference-platform/components/uefi-staging/123/hikey960/release/hisi-sec_uce_boot.img
-  > wget http://snapshots.linaro.org/reference-platform/components/uefi-staging/123/hikey960/release/hisi-sec_xloader.img
-  > wget http://snapshots.linaro.org/reference-platform/components/uefi-staging/123/hikey960/release/recovery.bin
-  > wget http://snapshots.linaro.org/reference-platform/components/uefi-staging/123/hikey960/release/hikey_idt
-
-Get the SCP_BL2 lpm3.img binary. It is shipped as part of the UEFI source.
-The latest version can be obtained from the OpenPlatformPkg repo.
-
-  > cp OpenPlatformPkg/Platforms/Hisilicon/HiKey960/Binary/lpm3.img ~/hikey960/bin/
-
-Compile U-Boot
-==============
-
-  > cd ~/hikey960/src/u-boot
-  > make CROSS_COMPILE=aarch64-linux-gnu- hikey960_defconfig
-  > make CROSS_COMPILE=aarch64-linux-gnu-
-  > cp u-boot.bin ~/hikey960/bin/
-
-Compile ARM Trusted Firmware (ATF)
-==================================
-
-  > cd ~/hikey960/src/arm-trusted-firmware
-  > make CROSS_COMPILE=aarch64-linux-gnu- all fip \
-    SCP_BL2=~/hikey960/bin/lpm3.img \
-    BL33=~/hikey960/bin/u-boot.bin DEBUG=1 PLAT=hikey960
-
-Copy the resulting FIP binary
-  > cp build/hikey960/debug/fip.bin ~/hikey960/bin
-
-Compile l-loader
-================
-  > cd ~/hikey960/src/l-loader
-  > ln -sf ~/hikey960/src/arm-trusted-firmware/build/hikey960/debug/bl1.bin
-  > ln -sf ~/hikey960/src/arm-trusted-firmware/build/hikey960/debug/bl2.bin
-  > ln -sf ~/hikey960/src/arm-trusted-firmware/build/hikey960/debug/fip.bin
-  > ln -sf ~/hikey960/bin/u-boot.bin
-  > make hikey960 PTABLE_LST=linux-32g NS_BL1U=u-boot.bin
-
-Copy the resulting binaries
-  > cp *.img ~/hikey960/bin
-  > cp l-loader.bin ~/hikey960/bin
-
-These instructions are adapted from
-https://github.com/ARM-software/arm-trusted-firmware/blob/master/docs/plat/hikey960.rst
-
-Setup Console
-=============
-
-Install ser2net. Use telnet as the console since UEFI in recovery mode
-output window fails to display in minicom.
-
-  > sudo apt-get install ser2net
-
-Configure ser2net
-
-  > sudo vi /etc/ser2net.conf
-
-Append one line for serial-over-USB in #ser2net.conf
-
-  > 2004:telnet:0:/dev/ttyUSB0:115200 8DATABITS NONE 1STOPBIT banner
-
-Start ser2net
-
-  > sudo killall ser2net
-  > sudo ser2net -u
-
-Open the console.
-
-  > telnet localhost 2004
-
-And you could open the console remotely, too.
-
-Flashing
-========
-
-1. Boot Hikey960 into recovery mode as per the below document:
-https://github.com/96boards/documentation/blob/master/consumer/hikey/hikey960/installation/board-recovery.md
-
-Once Hikey960 is in recovery mode, flash the recovery binary:
-
-  > cd ~/hikey960/src
-  > chmod +x ./hikey_idt
-  > sudo ./hikey_idt -c config -p /dev/ttyUSB1
-
-Now move to the Hikey960 console and press `f` during UEFI boot. This
-will allow the board to boot into fastboot mode. Once the board is in
-fastboot mode, you should see the ID of the HiKey960 board using the
-following command
-
-  > sudo fastboot devices
-
-1ED3822A018E3372	fastboot
-
-3. Flash the images
-
-Now, the images can be flashed using fastboot:
-
-  > sudo fastboot flash ptable ~/hikey960/bin/prm_ptable.img
-  > sudo fastboot flash xloader ~/hikey960/bin/hisi-sec_xloader.img
-  > sudo fastboot flash fastboot ~/hikey960/bin/l-loader.bin
-  > sudo fastboot flash fip ~/hikey960/bin/fip.bin
-
-4. Set the "Boot Mode" switch to OFF position for normal boot mode.
-Then power on HiKey960
-
-Observe the console traces using UART6 on the Low Speed Expansion header:
-
-NOTICE:  BL2: v2.1(debug):v2.1-531-g3ee48f40
-NOTICE:  BL2: Built : 18:15:58, Aug  2 2019
-INFO:    BL2: Doing platform setup
-INFO:    UFS LUN0 contains 1024 blocks with 4096-byte size
-INFO:    UFS LUN1 contains 1024 blocks with 4096-byte size
-INFO:    UFS LUN2 contains 2048 blocks with 4096-byte size
-INFO:    UFS LUN3 contains 7805952 blocks with 4096-byte size
-INFO:    ufs: change power mode success
-INFO:    BL2: Loading image id 2
-INFO:    Loading image id=2 at address 0x89c80000
-INFO:    Image id=2 loaded: 0x89c80000 - 0x89cb5088
-INFO:    BL2: Initiating SCP_BL2 transfer to SCP
-INFO:    BL2: SCP_BL2: 0x89c80000@0x35088
-INFO:    BL2: SCP_BL2 HEAD:
-INFO:    BL2: SCP_BL2 0x7000 0x179 0x159 0x149
-INFO:    BL2: SCP_BL2 0x189 0x18b 0x18d 0x0
-INFO:    BL2: SCP_BL2 0x0 0x0 0x0 0x18f
-INFO:    BL2: SCP_BL2 0x191 0x0 0x193 0x195
-INFO:    BL2: SCP_BL2 0x18fd 0x18fd 0x18fd 0x18fd
-INFO:    BL2: SCP_BL2 0x18fd 0x18fd 0x18fd 0x18fd
-INFO:    BL2: SCP_BL2 0x18fd 0x18fd 0x18fd 0x18fd
-INFO:    BL2: SCP_BL2 0x4d454355 0x43494741 0x424d554e 0x21215245
-INFO:    BL2: SCP_BL2 0x4a054904 0x42912000 0xf841bfbc 0xe7fa0b04
-INFO:    BL2: SCP_BL2 0xb88cf000 0x3b18 0x3d1c 0x6809493e
-INFO:    BL2: SCP_BL2 0x4613680a 0x201f102 0xf0002a04 0x600a804c
-INFO:    BL2: SCP_BL2 0x204f04f 0xf203fb02 0xf102440a 0x60100204
-INFO:    BL2: SCP_BL2 0x160f04f 0xf103fb01 0x68004834 0x61044408
-INFO:    BL2: SCP_BL2 0x61866145 0xf8c061c7 0xf8c08020 0xf8c09024
-INFO:    BL2: SCP_BL2 0xf8c0a028 0xf3efb02c 0xf3ef8208 0x68118309
-INFO:    BL2: SCP_BL2 0xf1026401 0xf0110204 0xbf070f04 0x46113220
-INFO:    BL2: SCP_BL2 TAIL:
-INFO:    BL2: SCP_BL2 0x0 0x0 0x0 0x0
-INFO:    BL2: SCP_BL2 0x0 0x0 0x0 0x0
-INFO:    BL2: SCP_BL2 0x0 0x0 0x0 0x0
-INFO:    BL2: SCP_BL2 0x0 0x0 0x0 0x0
-INFO:    BL2: SCP_BL2 0x0 0x0 0x0 0x0
-INFO:    BL2: SCP_BL2 0x0 0x0 0x0 0x0
-INFO:    BL2: SCP_BL2 0x0 0x0 0x0 0x0
-INFO:    BL2: SCP_BL2 0x0 0x0 0x0 0x0
-INFO:    BL2: SCP_BL2 0x0 0x0 0x0 0x0
-INFO:    BL2: SCP_BL2 0x0 0x0 0x0 0x0
-INFO:    BL2: SCP_BL2 0x0 0x19cad151 0x19b80040 0x0
-INFO:    BL2: SCP_BL2 0x0 0x0 0x0 0x0
-INFO:    BL2: SCP_BL2 0x0 0x0 0x0 0x0
-INFO:    BL2: SCP_BL2 0x0 0x0 0x0 0x0
-INFO:    BL2: SCP_BL2 0x0 0x0 0x0 0x0
-INFO:    BL2: SCP_BL2 0x0 0x0 0x0 0x0
-INFO:    BL2: SCP_BL2 transferred to SCP
-INFO:    start fw loading
-INFO:    fw load success
-WARNING: BL2: Platform setup already done!!
-INFO:    BL2: Loading image id 3
-INFO:    Loading image id=3 at address 0x1ac58000
-INFO:    Image id=3 loaded: 0x1ac58000 - 0x1ac63024
-INFO:    BL2: Loading image id 5
-INFO:    Loading image id=5 at address 0x1ac98000
-INFO:    Image id=5 loaded: 0x1ac98000 - 0x1ad0819c
-NOTICE:  BL2: Booting BL31
-INFO:    Entry point address = 0x1ac58000
-INFO:    SPSR = 0x3cd
-NOTICE:  BL31: v2.1(debug):v2.1-531-g3ee48f40
-NOTICE:  BL31: Built : 18:16:01, Aug  2 2019
-INFO:    ARM GICv2 driver initialized
-INFO:    BL31: Initializing runtime services
-INFO:    BL31: cortex_a53: CPU workaround for 855873 was applied
-INFO:    plat_setup_psci_ops: sec_entrypoint=0x1ac580fc
-INFO:    BL31: Preparing for EL3 exit to normal world
-INFO:    Entry point address = 0x1ac98000
-INFO:    SPSR = 0x3c9
-
-
-U-Boot 2019.07-00628-g286f05a6fc-dirty (Aug 02 2019 - 17:14:05 +0530)
-Hikey960
-
-DRAM:  3 GiB
-PSCI:  v1.1
-MMC:   dwmmc1@ff37f000: 0
-Loading Environment from EXT4... ** File not found /uboot.env **
-
-** Unable to read "/uboot.env" from mmc0:2 **
-In:    serial@fff32000
-Out:   serial@fff32000
-Err:   serial@fff32000
-Net:   Net Initialization Skipped
-No ethernet found.
-Hit any key to stop autoboot:  0
-switch to partitions #0, OK
-mmc0 is current device
-Scanning mmc 0:1...
-Found /extlinux/extlinux.conf
-Retrieving file: /extlinux/extlinux.conf
-201 bytes read in 12 ms (15.6 KiB/s)
-1:      hikey960-kernel
-Retrieving file: /Image
-24689152 bytes read in 4377 ms (5.4 MiB/s)
-append: earlycon=pl011,mmio32,0xfff32000 console=ttyAMA6,115200 rw root=/dev/mmcblk0p2 rot
-Retrieving file: /hi3660-hikey960.dtb
-35047 bytes read in 14 ms (2.4 MiB/s)
-## Flattened Device Tree blob at 10000000
-   Booting using the fdt blob at 0x10000000
-   Using Device Tree in place at 0000000010000000, end 000000001000b8e6
-
-Starting kernel ...
-
-[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
-[    0.000000] Linux version 5.2.0-03138-gd75da80dce39 (mani@Mani-XPS-13-9360) (gcc versi9
-[    0.000000] Machine model: HiKey960
-[    0.000000] earlycon: pl11 at MMIO32 0x00000000fff32000 (options '')
-[    0.000000] printk: bootconsole [pl11] enabled
-[    0.000000] efi: Getting EFI parameters from FDT:
diff --git a/board/hisilicon/poplar/MAINTAINERS b/board/hisilicon/poplar/MAINTAINERS
index 9c045eaeb1..bfd4a9be66 100644
--- a/board/hisilicon/poplar/MAINTAINERS
+++ b/board/hisilicon/poplar/MAINTAINERS
@@ -3,5 +3,6 @@ M:     Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
 M:     Shawn Guo <shawn.guo@linaro.org>
 S:     Maintained
 F:     board/hisilicon/poplar
+F:     doc/board/hisilicon/poplar.rst
 F:     include/configs/poplar.h
 F:     configs/poplar_defconfig
diff --git a/board/hisilicon/poplar/README b/board/hisilicon/poplar/README
deleted file mode 100644
index 77dcc3ba11..0000000000
--- a/board/hisilicon/poplar/README
+++ /dev/null
@@ -1,288 +0,0 @@
-================================================================================
-			Board Information
-================================================================================
-
-Developed by HiSilicon, the board features the Hi3798C V200 with an
-integrated quad-core 64-bit ARM Cortex A53 processor and high
-performance Mali T720 GPU, making it capable of running any commercial
-set-top solution based on Linux or Android. Its high performance
-specification also supports a premium user experience with up to H.265
-HEVC decoding of 4K video at 60 frames per second.
-
-SOC  Hisilicon Hi3798CV200
-CPU  Quad-core ARM Cortex-A53 64 bit
-DRAM DDR3/3L/4 SDRAM interface, maximum 32-bit data width 2 GB
-USB  Two USB 2.0 ports One USB 3.0 ports
-CONSOLE  USB-micro port for console support
-ETHERNET  1 GBe Ethernet
-PCIE  One PCIe 2.0 interfaces
-JTAG  8-Pin JTAG
-EXPANSION INTERFACE  Linaro 96Boards Low Speed Expansion slot
-DIMENSION Standard 160×120 mm 96Boards Enterprice Edition form factor
-WIFI  802.11AC 2*2 with Bluetooth
-CONNECTORS  One connector for Smart Card One connector for TSI
-
-
-================================================================================
-			BUILD INSTRUCTIONS
-================================================================================
-
-Note of warning:
-================
-
-U-Boot has a *strong* dependency with the l-loader and the arm trusted firmware
-repositories.
-
-The boot sequence is:
-	l-loader --> arm_trusted_firmware --> u-boot
-
-U-Boot needs to be aware of the BL31 runtime location and size to avoid writing
-over it. Currently, BL31 is being placed below the kernel text offset (check
-poplar.c) but this could change in the future.
-
-The current version of u-boot has been tested with:
- - https://github.com/Linaro/poplar-l-loader.git
-
-	commit f0988698dcc5c08bd0a8f50aa0457e138a5f438c
-	Author: Alex Elder <elder@linaro.org>
-	Date:   Fri Jun 16 08:57:59 2017 -0500
-
-    l-loader: use external memory region definitions
-
-    The ARM Trusted Firmware code now has a header file that collects
-    all the definitions for the memory regions used for its boot stages.
-    Include that file where needed, and use the definitions found therein
-
-    Signed-off-by: Alex Elder <elder@linaro.org>
-
-
- - https://github.com/Linaro/poplar-arm-trusted-firmware.git
-
-	commit 6ac42dd3be13c99aa8ce29a15073e2f19d935f68
-	Author: Alex Elder <elder@linaro.org>
-	Date:   Fri Jun 16 09:24:50 2017 -0500
-
-    poplar: define memory regions in a separate file
-
-    Separate the definitions for memory regions used for the BL stage
-    images and FIP into a new file.  The "l-loader" image uses knowledge
-    of the sizes and locations of these memory regions, and it can now
-    include this (external) header to get these definitions, rather than
-    having to make coordinated changes to both code bases.
-
-    The new file has a complete set of definitions (more than may be
-    required by one or the other user).  It also includes a summary of
-    how the boot process works, and how it uses these regions.
-
-    It should now be relatively easy to adjust the sizes and locations
-    of these memory regions, or to add to them (e.g. for TEE).
-
-    Signed-off-by: Alex Elder <elder@linaro.org>
-
-
-Compile from source:
-====================
-
-Get all the sources
-
-  > mkdir -p ~/poplar/src ~/poplar/bin
-  > cd ~/poplar/src
-  > git clone https://github.com/Linaro/poplar-l-loader.git l-loader
-  > git clone https://github.com/Linaro/poplar-arm-trusted-firmware.git atf
-  > git clone https://github.com/Linaro/poplar-u-boot.git u-boot
-
-Make sure you are using the correct branch on each one of these repositories.
-The definition of "correct" might change over time (at this moment in time this
-would be the "latest" branch).
-
-Compile U-Boot:
-===============
-
-  Prerequisite:
-  # sudo apt-get install device-tree-compiler
-
-  > cd ~/poplar/src/u-boot
-  > make CROSS_COMPILE=aarch64-linux-gnu- poplar_defconfig
-  > make CROSS_COMPILE=aarch64-linux-gnu-
-  > cp u-boot.bin ~/poplar/bin
-
-Compile ARM Trusted Firmware (ATF):
-===================================
-
-  > cd ~/poplar/src/atf
-  > make CROSS_COMPILE=aarch64-linux-gnu- all fip \
-		SPD=none BL33=~/poplar/bin/u-boot.bin DEBUG=1 PLAT=poplar
-
-Copy resulting binaries
-  > cp build/hi3798cv200/debug/bl1.bin ~/poplar/src/l-loader/atf/
-  > cp build/hi3798cv200/debug/fip.bin ~/poplar/src/l-loader/atf/
-
-Compile l-loader:
-=================
-
-  > cd ~/poplar/src/l-loader
-  > make clean
-  > make CROSS_COMPILE=arm-linux-gnueabi-
-
-   Due to BootROM requiremets, rename l-loader.bin to fastboot.bin:
-  > cp l-loader.bin ~/poplar/bin/fastboot.bin
-
-
-================================================================================
-			FLASH INSTRUCTIONS
-================================================================================
-
-Two methods:
-
-Using USB debrick support:
-	Copy fastboot.bin to a FAT partition on the USB drive and reboot the
-       poplar board while pressing S3(usb_boot).
-
-       The system will execute the new u-boot and boot into a shell which you
-       can then use to write to eMMC.
-
-Using U-BOOT from shell:
-	1) using AXIS usb ethernet dongle and tftp
-	2) using FAT formated USB drive
-
-
-1. TFTP (USB ethernet dongle)
-=============================
-
-Plug a USB AXIS ethernet dongle on any of the USB2 ports on the Poplar board.
-Copy fastboot.bin to your tftp server.
-In u-boot make sure your network is properly setup.
-
-Then
-
-=> tftp 0x30000000 fastboot.bin
-starting USB...
-USB0:   USB EHCI 1.00
-scanning bus 0 for devices... 1 USB Device(s) found
-USB1:   USB EHCI 1.00
-scanning bus 1 for devices... 3 USB Device(s) found
-       scanning usb for storage devices... 0 Storage Device(s) found
-       scanning usb for ethernet devices... 1 Ethernet Device(s) found
-Waiting for Ethernet connection... done.
-Using asx0 device
-TFTP from server 192.168.1.4; our IP address is 192.168.1.10
-Filename 'poplar/fastboot.bin'.
-Load address: 0x30000000
-Loading: #################################################################
-	 #################################################################
-	 ###############################################################
-	 2 MiB/s
-done
-Bytes transferred = 983040 (f0000 hex)
-
-=> mmc write 0x30000000 0 0x780
-
-MMC write: dev # 0, block # 0, count 1920 ... 1920 blocks written: OK
-=> reset
-
-
-2. USING USB FAT DRIVE
-=======================
-
-Copy fastboot.bin to any partition on a FAT32 formated usb flash drive.
-Enter the uboot prompt
-
-=> fatls usb 0:2
-   983040   fastboot.bin
-
-1 file(s), 0 dir(s)
-
-=> fatload usb 0:2 0x30000000 fastboot.bin
-reading fastboot.bin
-983040 bytes read in 44 ms (21.3 MiB/s)
-
-=> mmc write 0x30000000 0 0x780
-
-MMC write: dev # 0, block # 0, count 1920 ... 1920 blocks written: OK
-
-
-================================================================================
-				BOOT TRACE
-================================================================================
-
-Bootrom start
-Boot Media: eMMC
-Decrypt auxiliary code ...OK
-
-lsadc voltage min: 000000FE, max: 000000FF, aver: 000000FE, index: 00000000
-
-Entry boot auxiliary code
-
-Auxiliary code - v1.00
-DDR code - V1.1.2 20160205
-Build: Mar 24 2016 - 17:09:44
-Reg Version:  v134
-Reg Time:     2016/03/18 09:44:55
-Reg Name:     hi3798cv2dmb_hi3798cv200_ddr3_2gbyte_8bitx4_4layers.reg
-
-Boot auxiliary code success
-Bootrom success
-
-LOADER:  Switched to aarch64 mode
-LOADER:  Entering ARM TRUSTED FIRMWARE
-LOADER:  CPU0 executes at 0x000ce000
-
-INFO:    BL1: 0xe1000 - 0xe7000 [size = 24576]
-NOTICE:  Booting Trusted Firmware
-NOTICE:  BL1: v1.3(debug):v1.3-372-g1ba9c60
-NOTICE:  BL1: Built : 17:51:33, Apr 30 2017
-INFO:    BL1: RAM 0xe1000 - 0xe7000
-INFO:    BL1: Loading BL2
-INFO:    Loading image id=1 at address 0xe9000
-INFO:    Image id=1 loaded at address 0xe9000, size = 0x5008
-NOTICE:  BL1: Booting BL2
-INFO:    Entry point address = 0xe9000
-INFO:    SPSR = 0x3c5
-NOTICE:  BL2: v1.3(debug):v1.3-372-g1ba9c60
-NOTICE:  BL2: Built : 17:51:33, Apr 30 2017
-INFO:    BL2: Loading BL31
-INFO:    Loading image id=3 at address 0x129000
-INFO:    Image id=3 loaded at address 0x129000, size = 0x8038
-INFO:    BL2: Loading BL33
-INFO:    Loading image id=5 at address 0x37000000
-INFO:    Image id=5 loaded at address 0x37000000, size = 0x58f17
-NOTICE:  BL1: Booting BL31
-INFO:    Entry point address = 0x129000
-INFO:    SPSR = 0x3cd
-INFO:    Boot bl33 from 0x37000000 for 364311 Bytes
-NOTICE:  BL31: v1.3(debug):v1.3-372-g1ba9c60
-NOTICE:  BL31: Built : 17:51:33, Apr 30 2017
-INFO:    BL31: Initializing runtime services
-INFO:    BL31: Preparing for EL3 exit to normal world
-INFO:    Entry point address = 0x37000000
-INFO:    SPSR = 0x3c9
-
-
-U-Boot 2017.05-rc2-00130-gd2255b0 (Apr 30 2017 - 17:51:28 +0200)poplar
-
-Model: HiSilicon Poplar Development Board
-BOARD: Hisilicon HI3798cv200 Poplar
-DRAM:  1 GiB
-MMC:   Hisilicon DWMMC: 0
-In:    serial@f8b00000
-Out:   serial@f8b00000
-Err:   serial@f8b00000
-Net:   Net Initialization Skipped
-No ethernet found.
-
-Hit any key to stop autoboot:  0
-starting USB...
-USB0:   USB EHCI 1.00
-scanning bus 0 for devices... 1 USB Device(s) found
-USB1:   USB EHCI 1.00
-scanning bus 1 for devices... 4 USB Device(s) found
-       scanning usb for storage devices... 1 Storage Device(s) found
-       scanning usb for ethernet devices... 1 Ethernet Device(s) found
-
-USB device 0:
-    Device 0: Vendor: SanDisk Rev: 1.00 Prod: Cruzer Blade
-	    Type: Removable Hard Disk
-	    Capacity: 7632.0 MB = 7.4 GB (15630336 x 512)
-... is now current device
-Scanning usb 0:1...
-=>
diff --git a/doc/board/hisilicon/hikey.rst b/doc/board/hisilicon/hikey.rst
new file mode 100644
index 0000000000..8038a24fe1
--- /dev/null
+++ b/doc/board/hisilicon/hikey.rst
@@ -0,0 +1,261 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+HiKey board
+###########
+
+Introduction
+============
+
+HiKey is the first certified 96Boards Consumer Edition board. The board/SoC has:
+
+* HiSilicon Kirin 6220 eight-core ARM Cortex-A53 64-bit SoC running at 1.2GHz.
+* ARM Mali 450-MP4 GPU
+* 1GB 800MHz LPDDR3 DRAM
+* 4GB eMMC Flash Storage
+* microSD
+* 802.11a/b/g/n WiFi, Bluetooth
+
+The HiKey schematic can be found here:
+https://github.com/96boards/documentation/blob/master/consumer/hikey/hikey620/hardware-docs/HiKey_schematics_LeMaker_version_Rev_A1.pdf
+
+The SoC datasheet can be found here:
+https://github.com/96boards/documentation/blob/master/consumer/hikey/hikey620/hardware-docs/Hi6220V100_Multi-Mode_Application_Processor_Function_Description.pdf
+
+Currently the u-boot port supports:
+
+* USB
+* eMMC
+* SD card
+* GPIO
+
+The HiKey U-Boot port has been tested with l-loader, booting ATF, which then
+boots U-Boot as the bl33.bin executable.
+
+Compile from source
+===================
+
+First get all the sources
+
+.. code-block:: bash
+
+  mkdir -p ~/hikey/src ~/hikey/bin
+  cd ~/hikey/src
+  git clone https://github.com/96boards-hikey/edk2 -b testing/hikey960_v2.5
+  git clone https://github.com/ARM-software/arm-trusted-firmware
+  git clone https://github.com/96boards-hikey/l-loader -b testing/hikey960_v1.2
+  git clone https://github.com/96boards-hikey/OpenPlatformPkg -b testing/hikey960_v1.3.4
+  git clone https://github.com/96boards-hikey/atf-fastboot
+  wget https://snapshots.linaro.org/96boards/reference-platform/components/uefi-staging/latest/hikey/release/hisi-idt.py
+
+Get the BL30 mcuimage.bin binary. It is shipped as part of the UEFI source.
+The latest version can be obtained from the OpenPlatformPkg repo.
+
+.. code-block:: bash
+
+  cp OpenPlatformPkg/Platforms/Hisilicon/HiKey/Binary/mcuimage.bin ~/hikey/bin/
+
+Get nvme.img binary
+
+.. code-block:: bash
+
+  wget -P ~/hikey/bin https://snapshots.linaro.org/96boards/reference-platform/components/uefi-staging/latest/hikey/release/nvme.img
+
+Compile U-Boot
+==============
+
+.. code-block:: bash
+
+  cd ~/hikey/src/u-boot
+  make CROSS_COMPILE=aarch64-linux-gnu- hikey_config
+  make CROSS_COMPILE=aarch64-linux-gnu-
+  cp u-boot.bin ~/hikey/bin
+
+Compile ARM Trusted Firmware (ATF)
+==================================
+
+.. code-block:: bash
+
+  cd ~/hikey/src/arm-trusted-firmware
+  make CROSS_COMPILE=aarch64-linux-gnu- all fip \
+    SCP_BL2=~/hikey/bin/mcuimage.bin \
+    BL33=~/hikey/bin/u-boot.bin DEBUG=1 PLAT=hikey
+
+Copy the resulting FIP binary
+
+.. code-block:: bash
+
+  cp build/hikey/debug/fip.bin ~/hikey/bin
+
+Compile ATF Fastboot
+====================
+
+.. code-block:: bash
+
+  cd ~/hikey/src/atf-fastboot
+  make CROSS_COMPILE=aarch64-linux-gnu- PLAT=hikey DEBUG=1
+
+Compile l-loader
+================
+
+.. code-block:: bash
+
+  cd ~/hikey/src/l-loader
+  ln -sf ~/hikey/src/arm-trusted-firmware/build/hikey/debug/bl1.bin
+  ln -sf ~/hikey/src/arm-trusted-firmware/build/hikey/debug/bl2.bin
+  ln -sf ~/hikey/src/atf-fastboot/build/hikey/debug/bl1.bin fastboot.bin
+  make hikey PTABLE_LST=aosp-8g
+
+Copy the resulting binaries
+
+.. code-block:: bash
+
+  cp *.img ~/hikey/bin
+  cp l-loader.bin ~/hikey/bin
+  cp recovery.bin ~/hikey/bin
+
+These instructions are adapted from
+https://github.com/ARM-software/arm-trusted-firmware/blob/master/docs/plat/hikey.rst
+
+Flashing
+========
+
+1. Connect the second jumper on J15 BOOT SEL, to go into recovery mode and flash l-loader.bin with
+the hisi-idt.py utility. Then connect a USB A to B mini cable from your PC to the USB OTG port of HiKey and execute the below command.
+
+The command below assumes HiKey enumerated as the first USB serial port
+
+.. code-block:: bash
+
+  sudo python ~/hikey/src/hisi-idt.py -d /dev/ttyUSB0 --img1 ~/hikey/bin/recovery.bin
+
+2. Once LED 0 comes on solid, HiKey board should be detected as a fastboot device.
+
+.. code-block::
+
+  sudo fastboot devices
+
+  0123456789ABCDEF	fastboot
+
+3. Flash the images
+
+.. code-block::
+
+  sudo fastboot flash ptable ~/hikey/bin/prm_ptable.img
+  sudo fastboot flash loader ~/hikey/bin/l-loader.bin
+  sudo fastboot flash fastboot ~/hikey/bin/fip.bin
+  sudo fastboot flash nvme ~/hikey/bin/nvme.img
+
+4. Disconnect second jumper on J15 BOOT SEL, and reset the board and you will now (hopefully)
+   have ATF, booting u-boot from eMMC.
+
+   Note: To get USB host working, also disconnect the USB OTG cable used for flashing. Otherwise you
+   will get 'dwc_otg_core_host_init: Timeout!' errors.
+
+See working boot trace below on UART3 available at Low Speed Expansion header::
+
+  NOTICE:  BL2: v1.5(debug):v1.5-694-g6d4f6aea
+  NOTICE:  BL2: Built : 09:21:42, Aug 29 2018
+  INFO:    BL2: Doing platform setup
+  INFO:    ddr3 rank1 init pass
+  INFO:    succeed to set ddrc 150mhz
+  INFO:    ddr3 rank1 init pass
+  INFO:    succeed to set ddrc 266mhz
+  INFO:    ddr3 rank1 init pass
+  INFO:    succeed to set ddrc 400mhz
+  INFO:    ddr3 rank1 init pass
+  INFO:    succeed to set ddrc 533mhz
+  INFO:    ddr3 rank1 init pass
+  INFO:    succeed to set ddrc 800mhz
+  INFO:    Samsung DDR
+  INFO:    ddr test value:0xa5a55a5a
+  INFO:    BL2: TrustZone: protecting 16777216 bytes of memory at 0x3f000000
+  INFO:    BL2: TrustZone: protecting 4194304 bytes of memory at 0x3e800000
+  INFO:    [BDID] [fff91c18] midr: 0x410fd033
+  INFO:    init_acpu_dvfs: pmic version 17
+  INFO:    init_acpu_dvfs: ACPU_CHIP_MAX_FREQ=0x186a00.
+  INFO:    acpu_dvfs_volt_init: success!
+  INFO:    acpu_dvfs_set_freq: support freq num is 5
+  INFO:    acpu_dvfs_set_freq: start prof is 0x4
+  INFO:    acpu_dvfs_set_freq: magic is 0x5a5ac5c5
+  INFO:    acpu_dvfs_set_freq: voltage:
+  INFO:      - 0: 0x49
+  INFO:      - 1: 0x49
+  INFO:      - 2: 0x50
+  INFO:      - 3: 0x60
+  INFO:      - 4: 0x78
+  NOTICE:  acpu_dvfs_set_freq: set acpu freq success!INFO:    BL2: Loading image id 2
+  INFO:    Loading image id=2 at address 0x1000000
+  INFO:    Image id=2 loaded: 0x1000000 - 0x1023d00
+  INFO:    hisi_mcu_load_image: mcu sections 0:
+  INFO:    hisi_mcu_load_image:  src  = 0x1000200
+  INFO:    hisi_mcu_load_image:  dst  = 0xf6000000
+  INFO:    hisi_mcu_load_image:  size = 31184
+  INFO:    hisi_mcu_load_image:  [SRC 0x1000200] 0x8000 0x3701 0x7695 0x7689
+  INFO:    hisi_mcu_load_image:  [DST 0xf6000000] 0x8000 0x3701 0x7695 0x7689
+  INFO:    hisi_mcu_load_image: mcu sections 1:
+  INFO:    hisi_mcu_load_image:  src  = 0x1007bd0
+  INFO:    hisi_mcu_load_image:  dst  = 0x5e00000
+  INFO:    hisi_mcu_load_image:  size = 93828
+  INFO:    hisi_mcu_load_image:  [SRC 0x1007bd0] 0xf000b510 0x2103fb3d 0xf0004604 0xf003fb57
+  INFO:    hisi_mcu_load_image:  [DST 0x5e00000] 0xf000b510 0x2103fb3d 0xf0004604 0xf003fb57
+  INFO:    hisi_mcu_load_image: mcu sections 2:
+  INFO:    hisi_mcu_load_image:  src  = 0x101ea54
+  INFO:    hisi_mcu_load_image:  dst  = 0x5e16e84
+  INFO:    hisi_mcu_load_image:  size = 15428
+  INFO:    hisi_mcu_load_image:  [SRC 0x101ea54] 0x9 0x1020640 0x10001 0x8f0d180
+  INFO:    hisi_mcu_load_image:  [DST 0x5e16e84] 0x9 0x1020640 0x10001 0x8f0d180
+  INFO:    hisi_mcu_load_image: mcu sections 3:
+  INFO:    hisi_mcu_load_image:  src  = 0x1022698
+  INFO:    hisi_mcu_load_image:  dst  = 0x5e22a10
+  INFO:    hisi_mcu_load_image:  size = 3060
+  INFO:    hisi_mcu_load_image:  [SRC 0x1022698] 0x0 0x0 0x0 0x0
+  INFO:    hisi_mcu_load_image:  [DST 0x5e22a10] 0x0 0x0 0x0 0x0
+  INFO:    hisi_mcu_load_image: mcu sections 4:
+  INFO:    hisi_mcu_load_image:  src  = 0x102328c
+  INFO:    hisi_mcu_load_image:  dst  = 0x5e23604
+  INFO:    hisi_mcu_load_image:  size = 2616
+  INFO:    hisi_mcu_load_image:  [SRC 0x102328c] 0xf80000a0 0x0 0xf80000ac 0x0
+  INFO:    hisi_mcu_load_image:  [DST 0x5e23604] 0xf80000a0 0x0 0xf80000ac 0x0
+  INFO:    hisi_mcu_start_run: AO_SC_SYS_CTRL2=0
+  INFO:    plat_hikey_bl2_handle_scp_bl2: MCU PC is at 0x42933301
+  INFO:    plat_hikey_bl2_handle_scp_bl2: AO_SC_PERIPH_CLKSTAT4 is 0x3b018f09
+  WARNING: BL2: Platform setup already done!!
+  INFO:    BL2: Loading image id 3
+  INFO:    Loading image id=3 at address 0xf9858000
+  INFO:    Image id=3 loaded: 0xf9858000 - 0xf9860058
+  INFO:    BL2: Loading image id 5
+  INFO:    Loading image id=5 at address 0x35000000
+  INFO:    Image id=5 loaded: 0x35000000 - 0x35061cd2
+  NOTICE:  BL2: Booting BL31
+  INFO:    Entry point address = 0xf9858000
+  INFO:    SPSR = 0x3cd
+  NOTICE:  BL31: v1.5(debug):v1.5-694-g6d4f6aea
+  NOTICE:  BL31: Built : 09:21:44, Aug 29 2018
+  WARNING: Using deprecated integer interrupt array in gicv2_driver_data_t
+  WARNING: Please migrate to using an interrupt_prop_t array
+  INFO:    ARM GICv2 driver initialized
+  INFO:    BL31: Initializing runtime services
+  INFO:    BL31: cortex_a53: CPU workaround for disable_non_temporal_hint was applied
+  INFO:    BL31: cortex_a53: CPU workaround for 843419 was applied
+  INFO:    BL31: cortex_a53: CPU workaround for 855873 was applied
+  INFO:    BL31: Preparing for EL3 exit to normal world
+  INFO:    Entry point address = 0x35000000
+  INFO:    SPSR = 0x3c9
+
+  U-Boot 2018.09-rc1 (Aug 22 2018 - 14:55:49 +0530)hikey
+
+  DRAM:  990 MiB
+  HI6553 PMIC init
+  MMC:   config_sd_carddetect: SD card present
+  Hisilicon DWMMC: 0, Hisilicon DWMMC: 1
+  Loading Environment from FAT... Unable to use mmc 1:1... Failed (-5)
+  In:    uart@f7113000
+  Out:   uart@f7113000
+  Err:   uart@f7113000
+  Net:   Net Initialization Skipped
+  No ethernet found.
+  Hit any key to stop autoboot:  0
+  starting USB...
+  USB0:   scanning bus 0 for devices... 2 USB Device(s) found
+         scanning usb for storage devices... 0 Storage Device(s) found
+         scanning usb for ethernet devices... 0 Ethernet Device(s) found
diff --git a/doc/board/hisilicon/hikey960.rst b/doc/board/hisilicon/hikey960.rst
new file mode 100644
index 0000000000..93e983b99f
--- /dev/null
+++ b/doc/board/hisilicon/hikey960.rst
@@ -0,0 +1,284 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+HiKey960 board
+##############
+
+Introduction
+============
+
+HiKey960 is one of the 96Boards Consumer Edition board from HiSilicon.
+The board/SoC has:
+
+* HiSilicon Kirin960 (HI3660) SoC with 4xCortex-A73 and 4xCortex-A53
+* ARM Mali G71 MP8 GPU
+* 3GB LPDDR4 SDRAM
+* 32GB UFS Flash Storage
+* microSD
+* 802.11a/b/g/n WiFi, Bluetooth
+
+More information about this board can be found in 96Boards website:
+https://www.96boards.org/product/hikey960/
+
+Currently the u-boot port supports:
+
+* SD card
+
+Compile from source
+===================
+
+First get all the sources
+
+.. code-block:: bash
+
+  mkdir -p ~/hikey960/src ~/hikey960/bin
+  cd ~/hikey960/src
+  git clone https://github.com/ARM-software/arm-trusted-firmware
+  git clone https://github.com/96boards-hikey/OpenPlatformPkg -b testing/hikey960_v1.3.4
+  git clone https://github.com/96boards-hikey/l-loader -b testing/hikey960_v1.2
+  wget http://snapshots.linaro.org/reference-platform/components/uefi-staging/123/hikey960/release/config
+  wget http://snapshots.linaro.org/reference-platform/components/uefi-staging/123/hikey960/release/hisi-sec_usb_xloader.img
+  wget http://snapshots.linaro.org/reference-platform/components/uefi-staging/123/hikey960/release/hisi-sec_uce_boot.img
+  wget http://snapshots.linaro.org/reference-platform/components/uefi-staging/123/hikey960/release/hisi-sec_xloader.img
+  wget http://snapshots.linaro.org/reference-platform/components/uefi-staging/123/hikey960/release/recovery.bin
+  wget http://snapshots.linaro.org/reference-platform/components/uefi-staging/123/hikey960/release/hikey_idt
+
+Get the SCP_BL2 lpm3.img binary. It is shipped as part of the UEFI source.
+The latest version can be obtained from the OpenPlatformPkg repo.
+
+.. code-block:: bash
+
+  cp OpenPlatformPkg/Platforms/Hisilicon/HiKey960/Binary/lpm3.img ~/hikey960/bin/
+
+Compile U-Boot
+==============
+
+.. code-block:: bash
+
+  cd ~/hikey960/src/u-boot
+  make CROSS_COMPILE=aarch64-linux-gnu- hikey960_defconfig
+  make CROSS_COMPILE=aarch64-linux-gnu-
+  cp u-boot.bin ~/hikey960/bin/
+
+Compile ARM Trusted Firmware (ATF)
+==================================
+
+.. code-block:: bash
+
+  cd ~/hikey960/src/arm-trusted-firmware
+  make CROSS_COMPILE=aarch64-linux-gnu- all fip \
+    SCP_BL2=~/hikey960/bin/lpm3.img \
+    BL33=~/hikey960/bin/u-boot.bin DEBUG=1 PLAT=hikey960
+
+Copy the resulting FIP binary
+
+.. code-block:: bash
+
+  cp build/hikey960/debug/fip.bin ~/hikey960/bin
+
+Compile l-loader
+================
+
+.. code-block:: bash
+
+  cd ~/hikey960/src/l-loader
+  ln -sf ~/hikey960/src/arm-trusted-firmware/build/hikey960/debug/bl1.bin
+  ln -sf ~/hikey960/src/arm-trusted-firmware/build/hikey960/debug/bl2.bin
+  ln -sf ~/hikey960/src/arm-trusted-firmware/build/hikey960/debug/fip.bin
+  ln -sf ~/hikey960/bin/u-boot.bin
+  make hikey960 PTABLE_LST=linux-32g NS_BL1U=u-boot.bin
+
+Copy the resulting binaries
+
+.. code-block:: bash
+
+  cp *.img ~/hikey960/bin
+  cp l-loader.bin ~/hikey960/bin
+
+These instructions are adapted from
+https://github.com/ARM-software/arm-trusted-firmware/blob/master/docs/plat/hikey960.rst
+
+Setup console
+=============
+
+Install ser2net. Use telnet as the console since UEFI in recovery mode
+output window fails to display in minicom.
+
+.. code-block:: bash
+
+  sudo apt-get install ser2net
+
+Configure ser2net
+
+.. code-block:: bash
+
+  sudo vi /etc/ser2net.conf
+
+Append one line for serial-over-USB in #ser2net.conf
+
+  2004:telnet:0:/dev/ttyUSB0:115200 8DATABITS NONE 1STOPBIT banner
+
+Start ser2net
+
+.. code-block:: bash
+
+  sudo killall ser2net
+  sudo ser2net -u
+
+Open the console.
+
+.. code-block:: bash
+
+  telnet localhost 2004
+
+And you could open the console remotely, too.
+
+Flashing
+========
+
+1. Boot Hikey960 into recovery mode as per the below document:
+https://github.com/96boards/documentation/blob/master/consumer/hikey/hikey960/installation/board-recovery.md
+
+Once Hikey960 is in recovery mode, flash the recovery binary:
+
+.. code-block:: bash
+
+  cd ~/hikey960/src
+  chmod +x ./hikey_idt
+  sudo ./hikey_idt -c config -p /dev/ttyUSB1
+
+Now move to the Hikey960 console and press `f` during UEFI boot. This
+will allow the board to boot into fastboot mode. Once the board is in
+fastboot mode, you should see the ID of the HiKey960 board using the
+following command
+
+.. code-block:: bash
+
+  sudo fastboot devices
+
+  1ED3822A018E3372	fastboot
+
+3. Flash the images
+
+Now, the images can be flashed using fastboot:
+
+.. code-block:: bash
+
+  sudo fastboot flash ptable ~/hikey960/bin/prm_ptable.img
+  sudo fastboot flash xloader ~/hikey960/bin/hisi-sec_xloader.img
+  sudo fastboot flash fastboot ~/hikey960/bin/l-loader.bin
+  sudo fastboot flash fip ~/hikey960/bin/fip.bin
+
+4. Set the "Boot Mode" switch to OFF position for normal boot mode.
+Then power on HiKey960
+
+Observe the console traces using UART6 on the Low Speed Expansion header::
+
+  NOTICE:  BL2: v2.1(debug):v2.1-531-g3ee48f40
+  NOTICE:  BL2: Built : 18:15:58, Aug  2 2019
+  INFO:    BL2: Doing platform setup
+  INFO:    UFS LUN0 contains 1024 blocks with 4096-byte size
+  INFO:    UFS LUN1 contains 1024 blocks with 4096-byte size
+  INFO:    UFS LUN2 contains 2048 blocks with 4096-byte size
+  INFO:    UFS LUN3 contains 7805952 blocks with 4096-byte size
+  INFO:    ufs: change power mode success
+  INFO:    BL2: Loading image id 2
+  INFO:    Loading image id=2 at address 0x89c80000
+  INFO:    Image id=2 loaded: 0x89c80000 - 0x89cb5088
+  INFO:    BL2: Initiating SCP_BL2 transfer to SCP
+  INFO:    BL2: SCP_BL2: 0x89c80000@0x35088
+  INFO:    BL2: SCP_BL2 HEAD:
+  INFO:    BL2: SCP_BL2 0x7000 0x179 0x159 0x149
+  INFO:    BL2: SCP_BL2 0x189 0x18b 0x18d 0x0
+  INFO:    BL2: SCP_BL2 0x0 0x0 0x0 0x18f
+  INFO:    BL2: SCP_BL2 0x191 0x0 0x193 0x195
+  INFO:    BL2: SCP_BL2 0x18fd 0x18fd 0x18fd 0x18fd
+  INFO:    BL2: SCP_BL2 0x18fd 0x18fd 0x18fd 0x18fd
+  INFO:    BL2: SCP_BL2 0x18fd 0x18fd 0x18fd 0x18fd
+  INFO:    BL2: SCP_BL2 0x4d454355 0x43494741 0x424d554e 0x21215245
+  INFO:    BL2: SCP_BL2 0x4a054904 0x42912000 0xf841bfbc 0xe7fa0b04
+  INFO:    BL2: SCP_BL2 0xb88cf000 0x3b18 0x3d1c 0x6809493e
+  INFO:    BL2: SCP_BL2 0x4613680a 0x201f102 0xf0002a04 0x600a804c
+  INFO:    BL2: SCP_BL2 0x204f04f 0xf203fb02 0xf102440a 0x60100204
+  INFO:    BL2: SCP_BL2 0x160f04f 0xf103fb01 0x68004834 0x61044408
+  INFO:    BL2: SCP_BL2 0x61866145 0xf8c061c7 0xf8c08020 0xf8c09024
+  INFO:    BL2: SCP_BL2 0xf8c0a028 0xf3efb02c 0xf3ef8208 0x68118309
+  INFO:    BL2: SCP_BL2 0xf1026401 0xf0110204 0xbf070f04 0x46113220
+  INFO:    BL2: SCP_BL2 TAIL:
+  INFO:    BL2: SCP_BL2 0x0 0x0 0x0 0x0
+  INFO:    BL2: SCP_BL2 0x0 0x0 0x0 0x0
+  INFO:    BL2: SCP_BL2 0x0 0x0 0x0 0x0
+  INFO:    BL2: SCP_BL2 0x0 0x0 0x0 0x0
+  INFO:    BL2: SCP_BL2 0x0 0x0 0x0 0x0
+  INFO:    BL2: SCP_BL2 0x0 0x0 0x0 0x0
+  INFO:    BL2: SCP_BL2 0x0 0x0 0x0 0x0
+  INFO:    BL2: SCP_BL2 0x0 0x0 0x0 0x0
+  INFO:    BL2: SCP_BL2 0x0 0x0 0x0 0x0
+  INFO:    BL2: SCP_BL2 0x0 0x0 0x0 0x0
+  INFO:    BL2: SCP_BL2 0x0 0x19cad151 0x19b80040 0x0
+  INFO:    BL2: SCP_BL2 0x0 0x0 0x0 0x0
+  INFO:    BL2: SCP_BL2 0x0 0x0 0x0 0x0
+  INFO:    BL2: SCP_BL2 0x0 0x0 0x0 0x0
+  INFO:    BL2: SCP_BL2 0x0 0x0 0x0 0x0
+  INFO:    BL2: SCP_BL2 0x0 0x0 0x0 0x0
+  INFO:    BL2: SCP_BL2 transferred to SCP
+  INFO:    start fw loading
+  INFO:    fw load success
+  WARNING: BL2: Platform setup already done!!
+  INFO:    BL2: Loading image id 3
+  INFO:    Loading image id=3 at address 0x1ac58000
+  INFO:    Image id=3 loaded: 0x1ac58000 - 0x1ac63024
+  INFO:    BL2: Loading image id 5
+  INFO:    Loading image id=5 at address 0x1ac98000
+  INFO:    Image id=5 loaded: 0x1ac98000 - 0x1ad0819c
+  NOTICE:  BL2: Booting BL31
+  INFO:    Entry point address = 0x1ac58000
+  INFO:    SPSR = 0x3cd
+  NOTICE:  BL31: v2.1(debug):v2.1-531-g3ee48f40
+  NOTICE:  BL31: Built : 18:16:01, Aug  2 2019
+  INFO:    ARM GICv2 driver initialized
+  INFO:    BL31: Initializing runtime services
+  INFO:    BL31: cortex_a53: CPU workaround for 855873 was applied
+  INFO:    plat_setup_psci_ops: sec_entrypoint=0x1ac580fc
+  INFO:    BL31: Preparing for EL3 exit to normal world
+  INFO:    Entry point address = 0x1ac98000
+  INFO:    SPSR = 0x3c9
+
+  U-Boot 2019.07-00628-g286f05a6fc-dirty (Aug 02 2019 - 17:14:05 +0530)
+  Hikey960
+
+  DRAM:  3 GiB
+  PSCI:  v1.1
+  MMC:   dwmmc1@ff37f000: 0
+  Loading Environment from EXT4... ** File not found /uboot.env **
+
+  ** Unable to read "/uboot.env" from mmc0:2 **
+  In:    serial@fff32000
+  Out:   serial@fff32000
+  Err:   serial@fff32000
+  Net:   Net Initialization Skipped
+  No ethernet found.
+  Hit any key to stop autoboot:  0
+  switch to partitions #0, OK
+  mmc0 is current device
+  Scanning mmc 0:1...
+  Found /extlinux/extlinux.conf
+  Retrieving file: /extlinux/extlinux.conf
+  201 bytes read in 12 ms (15.6 KiB/s)
+  1:      hikey960-kernel
+  Retrieving file: /Image
+  24689152 bytes read in 4377 ms (5.4 MiB/s)
+  append: earlycon=pl011,mmio32,0xfff32000 console=ttyAMA6,115200 rw root=/dev/mmcblk0p2 rot
+  Retrieving file: /hi3660-hikey960.dtb
+  35047 bytes read in 14 ms (2.4 MiB/s)
+  ## Flattened Device Tree blob at 10000000
+     Booting using the fdt blob at 0x10000000
+     Using Device Tree in place at 0000000010000000, end 000000001000b8e6
+
+  Starting kernel ...
+
+  [  0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
+  [  0.000000] Linux version 5.2.0-03138-gd75da80dce39 (mani@Mani-XPS-13-9360) (gcc versi9
+  [  0.000000] Machine model: HiKey960
+  [  0.000000] earlycon: pl11 at MMIO32 0x00000000fff32000 (options '')
+  [  0.000000] printk: bootconsole [pl11] enabled
+  [  0.000000] efi: Getting EFI parameters from FDT:
diff --git a/doc/board/hisilicon/index.rst b/doc/board/hisilicon/index.rst
new file mode 100644
index 0000000000..5455b766f2
--- /dev/null
+++ b/doc/board/hisilicon/index.rst
@@ -0,0 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+HiSilicon
+=========
+
+.. toctree::
+   :maxdepth: 2
+
+   hikey
+   hikey960
+   poplar
diff --git a/doc/board/hisilicon/poplar.rst b/doc/board/hisilicon/poplar.rst
new file mode 100644
index 0000000000..0fccc14b80
--- /dev/null
+++ b/doc/board/hisilicon/poplar.rst
@@ -0,0 +1,302 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Poplar board
+############
+
+Board Information
+=================
+
+Developed by HiSilicon, the board features the Hi3798C V200 with an
+integrated quad-core 64-bit ARM Cortex A53 processor and high
+performance Mali T720 GPU, making it capable of running any commercial
+set-top solution based on Linux or Android. Its high performance
+specification also supports a premium user experience with up to H.265
+HEVC decoding of 4K video at 60 frames per second.
+
+* SOC  Hisilicon Hi3798CV200
+* CPU  Quad-core ARM Cortex-A53 64 bit
+* DRAM DDR3/3L/4 SDRAM interface, maximum 32-bit data width 2 GB
+* USB  Two USB 2.0 ports One USB 3.0 ports
+* CONSOLE  USB-micro port for console support
+* ETHERNET  1 GBe Ethernet
+* PCIE  One PCIe 2.0 interfaces
+* JTAG  8-Pin JTAG
+* EXPANSION INTERFACE  Linaro 96Boards Low Speed Expansion slot
+* DIMENSION Standard 160×120 mm 96Boards Enterprice Edition form factor
+* WIFI  802.11AC 2*2 with Bluetooth
+* CONNECTORS  One connector for Smart Card One connector for TSI
+
+Build instructions
+==================
+
+.. note::
+
+  U-Boot has a **strong** dependency with the l-loader and the ARM trusted
+  firmware repositories.
+
+The boot sequence is::
+
+    l-loader --> arm_trusted_firmware --> U-Boot
+
+U-Boot needs to be aware of the BL31 runtime location and size to avoid writing
+over it. Currently, BL31 is being placed below the kernel text offset (check
+poplar.c) but this could change in the future.
+
+The current version of U-Boot has been tested with
+
+- https://github.com/Linaro/poplar-l-loader.git::
+
+    commit f0988698dcc5c08bd0a8f50aa0457e138a5f438c
+    Author: Alex Elder <elder@linaro.org>
+    Date:   Fri Jun 16 08:57:59 2017 -0500
+
+    l-loader: use external memory region definitions
+
+    The ARM Trusted Firmware code now has a header file that collects
+    all the definitions for the memory regions used for its boot stages.
+    Include that file where needed, and use the definitions found therein
+
+    Signed-off-by: Alex Elder <elder@linaro.org>
+
+- https://github.com/Linaro/poplar-arm-trusted-firmware.git::
+
+    commit 6ac42dd3be13c99aa8ce29a15073e2f19d935f68
+    Author: Alex Elder <elder@linaro.org>
+    Date:   Fri Jun 16 09:24:50 2017 -0500
+
+    poplar: define memory regions in a separate file
+
+    Separate the definitions for memory regions used for the BL stage
+    images and FIP into a new file.  The "l-loader" image uses knowledge
+    of the sizes and locations of these memory regions, and it can now
+    include this (external) header to get these definitions, rather than
+    having to make coordinated changes to both code bases.
+
+    The new file has a complete set of definitions (more than may be
+    required by one or the other user).  It also includes a summary of
+    how the boot process works, and how it uses these regions.
+
+    It should now be relatively easy to adjust the sizes and locations
+    of these memory regions, or to add to them (e.g. for TEE).
+
+    Signed-off-by: Alex Elder <elder@linaro.org>
+
+
+Compile from source
+-------------------
+
+Get all the sources
+
+.. code-block:: bash
+
+  mkdir -p ~/poplar/src ~/poplar/bin
+  cd ~/poplar/src
+  git clone https://github.com/Linaro/poplar-l-loader.git l-loader
+  git clone https://github.com/Linaro/poplar-arm-trusted-firmware.git atf
+  git clone https://github.com/Linaro/poplar-U-Boot.git U-Boot
+
+Make sure you are using the correct branch on each one of these repositories.
+The definition of "correct" might change over time (at this moment in time this
+would be the "latest" branch).
+
+Compile U-Boot
+~~~~~~~~~~~~~~
+
+Prerequisite:
+
+.. code-block:: bash
+
+  sudo apt-get install device-tree-compiler
+
+.. code-block:: bash
+
+  cd ~/poplar/src/U-Boot
+  make CROSS_COMPILE=aarch64-linux-gnu- poplar_defconfig
+  make CROSS_COMPILE=aarch64-linux-gnu-
+  cp U-Boot.bin ~/poplar/bin
+
+Compile ARM Trusted Firmware (ATF)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: bash
+
+  cd ~/poplar/src/atf
+  make CROSS_COMPILE=aarch64-linux-gnu- all fip \
+       SPD=none BL33=~/poplar/bin/U-Boot.bin DEBUG=1 PLAT=poplar
+
+Copy resulting binaries
+
+.. code-block:: bash
+
+  cp build/hi3798cv200/debug/bl1.bin ~/poplar/src/l-loader/atf/
+  cp build/hi3798cv200/debug/fip.bin ~/poplar/src/l-loader/atf/
+
+Compile l-loader
+~~~~~~~~~~~~~~~~
+
+.. code-block:: bash
+
+  cd ~/poplar/src/l-loader
+  make clean
+  make CROSS_COMPILE=arm-linux-gnueabi-
+
+Due to BootROM requiremets, rename l-loader.bin to fastboot.bin:
+
+.. code-block:: bash
+
+  cp l-loader.bin ~/poplar/bin/fastboot.bin
+
+Flash instructions
+==================
+
+Two methods:
+
+Using USB debrick support
+    Copy fastboot.bin to a FAT partition on the USB drive and reboot the
+    poplar board while pressing S3(usb_boot).
+
+    The system will execute the new U-Boot and boot into a shell which you
+    can then use to write to eMMC.
+
+Using U-BOOT from shell
+    1) using AXIS usb ethernet dongle and tftp
+    2) using FAT formated USB drive
+
+Flash using TFTP (USB ethernet dongle)
+--------------------------------------
+
+Plug a USB AXIS ethernet dongle on any of the USB2 ports on the Poplar board.
+Copy fastboot.bin to your tftp server.
+In U-Boot make sure your network is properly setup.
+
+Then::
+
+  => tftp 0x30000000 fastboot.bin
+  starting USB...
+  USB0:   USB EHCI 1.00
+  scanning bus 0 for devices... 1 USB Device(s) found
+  USB1:   USB EHCI 1.00
+  scanning bus 1 for devices... 3 USB Device(s) found
+         scanning usb for storage devices... 0 Storage Device(s) found
+         scanning usb for ethernet devices... 1 Ethernet Device(s) found
+  Waiting for Ethernet connection... done.
+  Using asx0 device
+  TFTP from server 192.168.1.4; our IP address is 192.168.1.10
+  Filename 'poplar/fastboot.bin'.
+  Load address: 0x30000000
+  Loading: #################################################################
+       #################################################################
+       ###############################################################
+       2 MiB/s
+  done
+  Bytes transferred = 983040 (f0000 hex)
+
+  => mmc write 0x30000000 0 0x780
+
+  MMC write: dev # 0, block # 0, count 1920 ... 1920 blocks written: OK
+  => reset
+
+Flash using USB FAT drive
+-------------------------
+
+Copy fastboot.bin to any partition on a FAT32 formated usb flash drive.
+Enter the uboot prompt::
+
+  => fatls usb 0:2
+     983040   fastboot.bin
+
+  1 file(s), 0 dir(s)
+
+  => fatload usb 0:2 0x30000000 fastboot.bin
+  reading fastboot.bin
+  983040 bytes read in 44 ms (21.3 MiB/s)
+
+  => mmc write 0x30000000 0 0x780
+
+  MMC write: dev # 0, block # 0, count 1920 ... 1920 blocks written: OK
+
+Boot trace
+==========
+
+::
+
+  Bootrom start
+  Boot Media: eMMC
+  Decrypt auxiliary code ...OK
+
+  lsadc voltage min: 000000FE, max: 000000FF, aver: 000000FE, index: 00000000
+
+  Entry boot auxiliary code
+
+  Auxiliary code - v1.00
+  DDR code - V1.1.2 20160205
+  Build: Mar 24 2016 - 17:09:44
+  Reg Version:  v134
+  Reg Time:     2016/03/18 09:44:55
+  Reg Name:     hi3798cv2dmb_hi3798cv200_ddr3_2gbyte_8bitx4_4layers.reg
+
+  Boot auxiliary code success
+  Bootrom success
+
+  LOADER:  Switched to aarch64 mode
+  LOADER:  Entering ARM TRUSTED FIRMWARE
+  LOADER:  CPU0 executes at 0x000ce000
+
+  INFO:    BL1: 0xe1000 - 0xe7000 [size = 24576]
+  NOTICE:  Booting Trusted Firmware
+  NOTICE:  BL1: v1.3(debug):v1.3-372-g1ba9c60
+  NOTICE:  BL1: Built : 17:51:33, Apr 30 2017
+  INFO:    BL1: RAM 0xe1000 - 0xe7000
+  INFO:    BL1: Loading BL2
+  INFO:    Loading image id=1 at address 0xe9000
+  INFO:    Image id=1 loaded at address 0xe9000, size = 0x5008
+  NOTICE:  BL1: Booting BL2
+  INFO:    Entry point address = 0xe9000
+  INFO:    SPSR = 0x3c5
+  NOTICE:  BL2: v1.3(debug):v1.3-372-g1ba9c60
+  NOTICE:  BL2: Built : 17:51:33, Apr 30 2017
+  INFO:    BL2: Loading BL31
+  INFO:    Loading image id=3 at address 0x129000
+  INFO:    Image id=3 loaded at address 0x129000, size = 0x8038
+  INFO:    BL2: Loading BL33
+  INFO:    Loading image id=5 at address 0x37000000
+  INFO:    Image id=5 loaded at address 0x37000000, size = 0x58f17
+  NOTICE:  BL1: Booting BL31
+  INFO:    Entry point address = 0x129000
+  INFO:    SPSR = 0x3cd
+  INFO:    Boot bl33 from 0x37000000 for 364311 Bytes
+  NOTICE:  BL31: v1.3(debug):v1.3-372-g1ba9c60
+  NOTICE:  BL31: Built : 17:51:33, Apr 30 2017
+  INFO:    BL31: Initializing runtime services
+  INFO:    BL31: Preparing for EL3 exit to normal world
+  INFO:    Entry point address = 0x37000000
+  INFO:    SPSR = 0x3c9
+
+  U-Boot 2017.05-rc2-00130-gd2255b0 (Apr 30 2017 - 17:51:28 +0200)poplar
+
+  Model: HiSilicon Poplar Development Board
+  BOARD: Hisilicon HI3798cv200 Poplar
+  DRAM:  1 GiB
+  MMC:   Hisilicon DWMMC: 0
+  In:    serial@f8b00000
+  Out:   serial@f8b00000
+  Err:   serial@f8b00000
+  Net:   Net Initialization Skipped
+  No ethernet found.
+
+  Hit any key to stop autoboot:  0
+  starting USB...
+  USB0:   USB EHCI 1.00
+  scanning bus 0 for devices... 1 USB Device(s) found
+  USB1:   USB EHCI 1.00
+  scanning bus 1 for devices... 4 USB Device(s) found
+         scanning usb for storage devices... 1 Storage Device(s) found
+         scanning usb for ethernet devices... 1 Ethernet Device(s) found
+
+  USB device 0:
+      Device 0: Vendor: SanDisk Rev: 1.00 Prod: Cruzer Blade
+          Type: Removable Hard Disk
+          Capacity: 7632.0 MB = 7.4 GB (15630336 x 512)
+  ... is now current device
+  Scanning usb 0:1...
+  =>
diff --git a/doc/board/index.rst b/doc/board/index.rst
index 35dd3bcf5f..531e547e7e 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -26,6 +26,7 @@ Board-specific doc
    gateworks/index
    google/index
    highbank/index
+   hisilicon/index
    htc/index
    intel/index
    kontron/index
-- 
2.40.1

