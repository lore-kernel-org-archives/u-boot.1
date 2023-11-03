Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A90DC4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 00:09:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 105CD876B8;
	Fri,  3 Nov 2023 01:09:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="R6J1H2jo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D283F87657; Fri,  3 Nov 2023 01:09:28 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBD9E870AC
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 01:09:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A309GrX090771;
 Thu, 2 Nov 2023 19:09:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698970156;
 bh=Nb5R6MjCe1Z5iA4m24GVMbpYDMomwzCcQXHBiQgkei0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=R6J1H2johogxZTeTCHQ2X4CN+VJfTe8It2t1/yPkhSF8/pE5CwzqLfTv24kZx2dyc
 rjHvKu+ynYCmOfjb6lrJktoMhpEj+XmBc6fQXPo3IVD9YsWLMoSuRkJd1kqQgjp/zZ
 iidBEUTTDDtN1cq1dE56mmpw6aGt5EzdrXTciF3w=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A309GCB004031
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 2 Nov 2023 19:09:16 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 2
 Nov 2023 19:09:16 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 2 Nov 2023 19:09:16 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A309Gbc018351;
 Thu, 2 Nov 2023 19:09:16 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
CC: Neha Malcom Francis <n-francis@ti.com>, Bryan Brattlof <bb@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 3/3] doc: board: ti: k3 docs: Use ::prompt
Date: Thu, 2 Nov 2023 19:09:15 -0500
Message-ID: <20231103000915.2413501-4-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231103000915.2413501-1-nm@ti.com>
References: <20231103000915.2413501-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Use prompt instead of code-block to have copy-paste friendly command
documentation.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 doc/board/ti/am62x_beagleplay.rst | 46 ++++++++---------
 doc/board/ti/am62x_sk.rst         | 18 +++----
 doc/board/ti/am64x_evm.rst        | 20 +++----
 doc/board/ti/am65x_evm.rst        | 86 +++++++++++++++----------------
 doc/board/ti/j7200_evm.rst        | 20 +++----
 doc/board/ti/j721e_evm.rst        | 40 +++++++-------
 doc/board/ti/j721s2_evm.rst       | 18 +++----
 7 files changed, 124 insertions(+), 124 deletions(-)

diff --git a/doc/board/ti/am62x_beagleplay.rst b/doc/board/ti/am62x_beagleplay.rst
index 39913b29ab2c..6518cb7e1dcc 100644
--- a/doc/board/ti/am62x_beagleplay.rst
+++ b/doc/board/ti/am62x_beagleplay.rst
@@ -55,15 +55,15 @@ Set the variables corresponding to this platform:
 .. include::  k3.rst
     :start-after: .. k3_rst_include_start_common_env_vars_defn
     :end-before: .. k3_rst_include_end_common_env_vars_defn
-.. code-block:: bash
+.. prompt:: bash $
 
- $ export UBOOT_CFG_CORTEXR="am62x_evm_r5_defconfig beagleplay_r5.config"
- $ export UBOOT_CFG_CORTEXA="am62x_evm_a53_defconfig beagleplay_a53.config"
- $ export TFA_BOARD=lite
- $ # we dont use any extra TFA parameters
- $ unset TFA_EXTRA_ARGS
- $ export OPTEE_PLATFORM=k3-am62x
- $ export OPTEE_EXTRA_ARGS="CFG_WITH_SOFTWARE_PRNG=y"
+ export UBOOT_CFG_CORTEXR="am62x_evm_r5_defconfig beagleplay_r5.config"
+ export UBOOT_CFG_CORTEXA="am62x_evm_a53_defconfig beagleplay_a53.config"
+ export TFA_BOARD=lite
+ # we dont use any extra TFA parameters
+ unset TFA_EXTRA_ARGS
+ export OPTEE_PLATFORM=k3-am62x
+ export OPTEE_EXTRA_ARGS="CFG_WITH_SOFTWARE_PRNG=y"
 
 .. include::  am62x_sk.rst
     :start-after: .. am62x_evm_rst_include_start_build_steps
@@ -174,24 +174,24 @@ boot1 partition depends on A/B update requirements.
 
 The following are the steps from Linux shell to program eMMC:
 
-.. code-block:: bash
+.. prompt:: bash #
 
-  # # Enable Boot0 boot
-  # mmc bootpart enable 1 2 /dev/mmcblk0
-  # mmc bootbus set single_backward x1 x8 /dev/mmcblk0
-  # mmc hwreset enable /dev/mmcblk0
+  # Enable Boot0 boot
+  mmc bootpart enable 1 2 /dev/mmcblk0
+  mmc bootbus set single_backward x1 x8 /dev/mmcblk0
+  mmc hwreset enable /dev/mmcblk0
 
-  # # Clear eMMC boot0
-  # echo '0' >> /sys/class/block/mmcblk0boot0/force_ro
-  # dd if=/dev/zero of=/dev/mmcblk0boot0 count=32 bs=128k
-  # # Write tiboot3.bin
-  # dd if=tiboot3.bin of=/dev/mmcblk0boot0 bs=128k
+  # Clear eMMC boot0
+  echo '0' >> /sys/class/block/mmcblk0boot0/force_ro
+  dd if=/dev/zero of=/dev/mmcblk0boot0 count=32 bs=128k
+  # Write tiboot3.bin
+  dd if=tiboot3.bin of=/dev/mmcblk0boot0 bs=128k
 
-  # # Copy the rest of the boot binaries
-  # mount /dev/mmcblk0p1 /boot/firmware
-  # cp tispl.bin /boot/firmware
-  # cp u-boot.img /boot/firmware
-  # sync
+  # Copy the rest of the boot binaries
+  mount /dev/mmcblk0p1 /boot/firmware
+  cp tispl.bin /boot/firmware
+  cp u-boot.img /boot/firmware
+  sync
 
 .. warning ::
 
diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
index d7437c6d22f7..10fd73a5cfb0 100644
--- a/doc/board/ti/am62x_sk.rst
+++ b/doc/board/ti/am62x_sk.rst
@@ -76,15 +76,15 @@ Set the variables corresponding to this platform:
 .. include::  ../ti/k3.rst
     :start-after: .. k3_rst_include_start_common_env_vars_defn
     :end-before: .. k3_rst_include_end_common_env_vars_defn
-.. code-block:: bash
+.. prompt:: bash $
 
- $ export UBOOT_CFG_CORTEXR=am62x_evm_r5_defconfig
- $ export UBOOT_CFG_CORTEXA=am62x_evm_a53_defconfig
- $ export TFA_BOARD=lite
- $ # we dont use any extra TFA parameters
- $ unset TFA_EXTRA_ARGS
- $ export OPTEE_PLATFORM=k3-am62x
- $ export OPTEE_EXTRA_ARGS="CFG_WITH_SOFTWARE_PRNG=y"
+ export UBOOT_CFG_CORTEXR=am62x_evm_r5_defconfig
+ export UBOOT_CFG_CORTEXA=am62x_evm_a53_defconfig
+ export TFA_BOARD=lite
+ # we dont use any extra TFA parameters
+ unset TFA_EXTRA_ARGS
+ export OPTEE_PLATFORM=k3-am62x
+ export OPTEE_EXTRA_ARGS="CFG_WITH_SOFTWARE_PRNG=y"
 
 .. am62x_evm_rst_include_start_build_steps
 
@@ -270,6 +270,6 @@ detailed setup information.
 
 To start OpenOCD and connect to the board
 
-.. code-block:: bash
+.. prompt:: bash $
 
   openocd -f board/ti_am625evm.cfg
diff --git a/doc/board/ti/am64x_evm.rst b/doc/board/ti/am64x_evm.rst
index db27461cb14d..05f3b34249e7 100644
--- a/doc/board/ti/am64x_evm.rst
+++ b/doc/board/ti/am64x_evm.rst
@@ -65,16 +65,16 @@ Set the variables corresponding to this platform:
 .. include::  k3.rst
     :start-after: .. k3_rst_include_start_common_env_vars_defn
     :end-before: .. k3_rst_include_end_common_env_vars_defn
-.. code-block:: bash
-
- $ export UBOOT_CFG_CORTEXR=am64x_evm_r5_defconfig
- $ export UBOOT_CFG_CORTEXA=am64x_evm_a53_defconfig
- $ export TFA_BOARD=lite
- $ # we dont use any extra TFA parameters
- $ unset TFA_EXTRA_ARGS
- $ export OPTEE_PLATFORM=k3-am64x
- $ # we dont use any extra TFA parameters
- $ unset OPTEE_EXTRA_ARGS
+.. prompt:: bash $
+
+ export UBOOT_CFG_CORTEXR=am64x_evm_r5_defconfig
+ export UBOOT_CFG_CORTEXA=am64x_evm_a53_defconfig
+ export TFA_BOARD=lite
+ # we dont use any extra TFA parameters
+ unset TFA_EXTRA_ARGS
+ export OPTEE_PLATFORM=k3-am64x
+ # we dont use any extra TFA parameters
+ unset OPTEE_EXTRA_ARGS
 
 .. am64x_evm_rst_include_start_build_steps
 
diff --git a/doc/board/ti/am65x_evm.rst b/doc/board/ti/am65x_evm.rst
index 7cebb1ca62d3..1492c7342fd0 100644
--- a/doc/board/ti/am65x_evm.rst
+++ b/doc/board/ti/am65x_evm.rst
@@ -75,16 +75,16 @@ Set the variables corresponding to this platform:
 .. include::  k3.rst
     :start-after: .. k3_rst_include_start_common_env_vars_defn
     :end-before: .. k3_rst_include_end_common_env_vars_defn
-.. code-block:: bash
+.. prompt:: bash $
 
- $ export UBOOT_CFG_CORTEXR=am65x_evm_r5_defconfig
- $ export UBOOT_CFG_CORTEXA=am65x_evm_a53_defconfig
- $ export TFA_BOARD=generic
- $ # we dont use any extra TFA parameters
- $ unset TFA_EXTRA_ARGS
- $ export OPTEE_PLATFORM=k3-am65x
- $ # we dont use any extra OP-TEE parameters
- $ unset OPTEE_EXTRA_ARGS
+ export UBOOT_CFG_CORTEXR=am65x_evm_r5_defconfig
+ export UBOOT_CFG_CORTEXA=am65x_evm_a53_defconfig
+ export TFA_BOARD=generic
+ # we dont use any extra TFA parameters
+ unset TFA_EXTRA_ARGS
+ export OPTEE_PLATFORM=k3-am65x
+ # we dont use any extra OP-TEE parameters
+ unset OPTEE_EXTRA_ARGS
 
 .. am65x_evm_rst_include_start_build_steps
 
@@ -159,32 +159,32 @@ The following commands can be used to download tiboot3.bin, tispl.bin,
 u-boot.img, and sysfw.itb from an SD card and write them to the eMMC boot0
 partition at respective addresses.
 
-.. code-block:: text
+.. prompt:: bash =>
 
- => mmc dev 0 1
- => fatload mmc 1 ${loadaddr} tiboot3.bin
- => mmc write ${loadaddr} 0x0 0x400
- => fatload mmc 1 ${loadaddr} tispl.bin
- => mmc write ${loadaddr} 0x400 0x1000
- => fatload mmc 1 ${loadaddr} u-boot.img
- => mmc write ${loadaddr} 0x1400 0x2000
- => fatload mmc 1 ${loadaddr} sysfw.itb
- => mmc write ${loadaddr} 0x3600 0x800
+ mmc dev 0 1
+ fatload mmc 1 ${loadaddr} tiboot3.bin
+ mmc write ${loadaddr} 0x0 0x400
+ fatload mmc 1 ${loadaddr} tispl.bin
+ mmc write ${loadaddr} 0x400 0x1000
+ fatload mmc 1 ${loadaddr} u-boot.img
+ mmc write ${loadaddr} 0x1400 0x2000
+ fatload mmc 1 ${loadaddr} sysfw.itb
+ mmc write ${loadaddr} 0x3600 0x800
 
 To give the ROM access to the boot partition, the following commands must be
 used for the first time:
 
-.. code-block:: text
+.. prompt:: bash =>
 
- => mmc partconf 0 1 1 1
- => mmc bootbus 0 1 0 0
+ mmc partconf 0 1 1 1
+ mmc bootbus 0 1 0 0
 
 To create a software partition for the rootfs, the following command can be
 used:
 
-.. code-block:: text
+.. prompt:: bash =>
 
- => gpt write mmc 0 ${partitions}
+ gpt write mmc 0 ${partitions}
 
 eMMC layout:
 
@@ -194,11 +194,11 @@ eMMC layout:
 Kernel image and DT are expected to be present in the /boot folder of rootfs.
 To boot kernel from eMMC, use the following commands:
 
-.. code-block:: text
+.. prompt:: bash =>
 
- => setenv mmcdev 0
- => setenv bootpart 0
- => boot
+ setenv mmcdev 0
+ setenv bootpart 0
+ boot
 
 OSPI:
 -----
@@ -210,17 +210,17 @@ Below commands can be used to download tiboot3.bin, tispl.bin, u-boot.img,
 and sysfw.itb over tftp and then flash those to OSPI at their respective
 addresses.
 
-.. code-block:: text
+.. prompt:: bash =>
 
- => sf probe
- => tftp ${loadaddr} tiboot3.bin
- => sf update $loadaddr 0x0 $filesize
- => tftp ${loadaddr} tispl.bin
- => sf update $loadaddr 0x80000 $filesize
- => tftp ${loadaddr} u-boot.img
- => sf update $loadaddr 0x280000 $filesize
- => tftp ${loadaddr} sysfw.itb
- => sf update $loadaddr 0x6C0000 $filesize
+ sf probe
+ tftp ${loadaddr} tiboot3.bin
+ sf update $loadaddr 0x0 $filesize
+ tftp ${loadaddr} tispl.bin
+ sf update $loadaddr 0x80000 $filesize
+ tftp ${loadaddr} u-boot.img
+ sf update $loadaddr 0x280000 $filesize
+ tftp ${loadaddr} sysfw.itb
+ sf update $loadaddr 0x6C0000 $filesize
 
 Flash layout for OSPI:
 
@@ -233,10 +233,10 @@ ospi.rootfs just like in SD card case. U-Boot looks for UBI volume named
 
 To boot kernel from OSPI, at the U-Boot prompt:
 
-.. code-block:: text
+.. prompt:: bash =>
 
- => setenv boot ubi
- => boot
+ setenv boot ubi
+ boot
 
 UART:
 -----
@@ -280,7 +280,7 @@ is fully loaded (from sysfw.itb) and started.
 Example bash script sequence for running on a Linux host PC feeding all boot
 artifacts needed to the device:
 
-.. code-block:: text
+.. prompt:: bash $
 
  MCU_DEV=/dev/ttyUSB1
  MAIN_DEV=/dev/ttyUSB0
@@ -314,6 +314,6 @@ detailed setup information.
 
 To start OpenOCD and connect to the board
 
-.. code-block:: bash
+.. prompt:: bash $
 
   openocd -f board/ti_am654evm.cfg
diff --git a/doc/board/ti/j7200_evm.rst b/doc/board/ti/j7200_evm.rst
index bcf8dc1c5f0d..42bf933af053 100644
--- a/doc/board/ti/j7200_evm.rst
+++ b/doc/board/ti/j7200_evm.rst
@@ -64,16 +64,16 @@ Set the variables corresponding to this platform:
 .. include::  k3.rst
     :start-after: .. k3_rst_include_start_common_env_vars_defn
     :end-before: .. k3_rst_include_end_common_env_vars_defn
-.. code-block:: bash
+.. prompt:: bash $
 
- $ export UBOOT_CFG_CORTEXR=j7200_evm_r5_defconfig
- $ export UBOOT_CFG_CORTEXA=j7200_evm_a72_defconfig
- $ export TFA_BOARD=generic
- $ # we dont use any extra TFA parameters
- $ unset TFA_EXTRA_ARGS
- $ export OPTEE_PLATFORM=k3-j7200
- $ # we dont use any extra OP-TEE parameters
- $ unset OPTEE_EXTRA_ARGS
+ export UBOOT_CFG_CORTEXR=j7200_evm_r5_defconfig
+ export UBOOT_CFG_CORTEXA=j7200_evm_a72_defconfig
+ export TFA_BOARD=generic
+ # we dont use any extra TFA parameters
+ unset TFA_EXTRA_ARGS
+ export OPTEE_PLATFORM=k3-j7200
+ # we dont use any extra OP-TEE parameters
+ unset OPTEE_EXTRA_ARGS
 
 .. j7200_evm_rst_include_start_build_steps
 
@@ -225,6 +225,6 @@ detailed setup information.
 
 To start OpenOCD and connect to the board
 
-.. code-block:: bash
+.. prompt:: bash $
 
   openocd -f board/ti_j7200evm.cfg
diff --git a/doc/board/ti/j721e_evm.rst b/doc/board/ti/j721e_evm.rst
index cadaac017811..c51029fce46b 100644
--- a/doc/board/ti/j721e_evm.rst
+++ b/doc/board/ti/j721e_evm.rst
@@ -69,16 +69,16 @@ Set the variables corresponding to this platform:
 .. include::  k3.rst
     :start-after: .. k3_rst_include_start_common_env_vars_defn
     :end-before: .. k3_rst_include_end_common_env_vars_defn
-.. code-block:: bash
+.. prompt:: bash $
 
- $ export UBOOT_CFG_CORTEXR=j721e_evm_r5_defconfig
- $ export UBOOT_CFG_CORTEXA=j721e_evm_a72_defconfig
- $ export TFA_BOARD=generic
- $ # we dont use any extra TFA parameters
- $ unset TFA_EXTRA_ARGS
- $ export OPTEE_PLATFORM=k3-j721e
- $ # we dont use any extra OP-TEE parameters
- $ unset OPTEE_EXTRA_ARGS
+ export UBOOT_CFG_CORTEXR=j721e_evm_r5_defconfig
+ export UBOOT_CFG_CORTEXA=j721e_evm_a72_defconfig
+ export TFA_BOARD=generic
+ # we dont use any extra TFA parameters
+ unset TFA_EXTRA_ARGS
+ export OPTEE_PLATFORM=k3-j721e
+ # we dont use any extra OP-TEE parameters
+ unset OPTEE_EXTRA_ARGS
 
 .. j721e_evm_rst_include_start_build_steps
 
@@ -202,17 +202,17 @@ Below commands can be used to download tiboot3.bin, tispl.bin, u-boot.img,
 and sysfw.itb over tftp and then flash those to OSPI at their respective
 addresses.
 
-.. code-block:: text
+.. prompt:: bash =>
 
- => sf probe
- => tftp ${loadaddr} tiboot3.bin
- => sf update $loadaddr 0x0 $filesize
- => tftp ${loadaddr} tispl.bin
- => sf update $loadaddr 0x80000 $filesize
- => tftp ${loadaddr} u-boot.img
- => sf update $loadaddr 0x280000 $filesize
- => tftp ${loadaddr} sysfw.itb
- => sf update $loadaddr 0x6C0000 $filesize
+ sf probe
+ tftp ${loadaddr} tiboot3.bin
+ sf update $loadaddr 0x0 $filesize
+ tftp ${loadaddr} tispl.bin
+ sf update $loadaddr 0x80000 $filesize
+ tftp ${loadaddr} u-boot.img
+ sf update $loadaddr 0x280000 $filesize
+ tftp ${loadaddr} sysfw.itb
+ sf update $loadaddr 0x6C0000 $filesize
 
 Flash layout for OSPI:
 
@@ -254,6 +254,6 @@ detailed setup information.
 
 To start OpenOCD and connect to the board
 
-.. code-block:: bash
+.. prompt:: bash $
 
   openocd -f board/ti_j721eevm.cfg
diff --git a/doc/board/ti/j721s2_evm.rst b/doc/board/ti/j721s2_evm.rst
index fec2acabe845..1b7317e6cce2 100644
--- a/doc/board/ti/j721s2_evm.rst
+++ b/doc/board/ti/j721s2_evm.rst
@@ -75,15 +75,15 @@ Set the variables corresponding to this platform:
 .. include::  k3.rst
     :start-after: .. k3_rst_include_start_common_env_vars_defn
     :end-before: .. k3_rst_include_end_common_env_vars_defn
-.. code-block:: bash
+.. prompt:: bash $
 
- $ export UBOOT_CFG_CORTEXR=j721s2_evm_r5_defconfig
- $ export UBOOT_CFG_CORTEXA=j721s2_evm_a72_defconfig
- $ export TFA_BOARD=generic
- $ export TFA_EXTRA_ARGS="K3_USART=0x8"
- $ # The following is not a typo, j784s4 is the OP-TEE platform for j721s2
- $ export OPTEE_PLATFORM=k3-j784s4
- $ export OPTEE_EXTRA_ARGS="CFG_CONSOLE_UART=0x8"
+ export UBOOT_CFG_CORTEXR=j721s2_evm_r5_defconfig
+ export UBOOT_CFG_CORTEXA=j721s2_evm_a72_defconfig
+ export TFA_BOARD=generic
+ export TFA_EXTRA_ARGS="K3_USART=0x8"
+ # The following is not a typo, j784s4 is the OP-TEE platform for j721s2
+ export OPTEE_PLATFORM=k3-j784s4
+ export OPTEE_EXTRA_ARGS="CFG_CONSOLE_UART=0x8"
 
 .. j721s2_evm_rst_include_start_build_steps
 
@@ -296,7 +296,7 @@ Debugging U-Boot on J721S2-EVM
 
 To start OpenOCD and connect to the board
 
-.. code-block:: bash
+.. prompt:: bash $
 
   openocd -f board/ti_j721s2evm.cfg
 
-- 
2.40.0

