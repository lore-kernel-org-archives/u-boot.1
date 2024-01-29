Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B727C47DA9
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 09:13:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0FCC87CE9;
	Mon, 29 Jan 2024 10:13:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="eJ7u4EGQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E398877E2; Mon, 29 Jan 2024 10:13:25 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50DEA87CD9
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 10:13:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1706519603; x=1709111603;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5eRVRiHHDg4Q0mlBB2dIAufIbZ55Bv3KwVpRwVb/zkQ=;
 b=eJ7u4EGQgB4QBtDT6GHW8jELfyoqEuxJ3/goOtn5qqYk05DeM9NRMZqCUEo9gUuB
 olnVxnJwjm1Vk6eMJgS7TycNiUIAkGDz/nAV5BglChHKuTbp5FkgC83JcExUukzU
 gILPobOJfpMfl5I+SdE+7akWEI/9CJoujPLy8wdVzr0=;
X-AuditID: ac14000a-fadff7000000290d-17-65b76c33c786
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id F6.62.10509.33C67B56;
 Mon, 29 Jan 2024 10:13:23 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 29 Jan
 2024 10:13:23 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>
CC: <nm@ti.com>, <d-gole@ti.com>, <trini@konsulko.com>,
 <upstream@lists.phytec.de>
Subject: [PATCH 2/2] doc: board: phytec: Add phyCORE-AM64x
Date: Mon, 29 Jan 2024 10:13:14 +0100
Message-ID: <20240129091314.925120-3-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240129091314.925120-1-w.egorov@phytec.de>
References: <20240129091314.925120-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsWyRpKBR9c4Z3uqwfIv/BYtaz0s3vw4y2Qx
 ddJmdou3ezvZLbrfqTuwerw6sIrd4+ydHYwe/d0trB7Hb2xnCmCJ4rJJSc3JLEst0rdL4Mro
 2HWJrWCedsXM321MDYyvlboYOTkkBEwk5k/dw9jFyMUhJLCYSWLijDfMEM5jRoljR/4wgVSx
 CahL3NnwjRXEFhGQknjZuZEZxGYWCJFYeG0GO4gtLGAl0b5qJRuIzSKgKjHtcBdYnFfAQuLd
 zk4miG3yEjMvfQeLcwpYSmx5twlsjhBQzcOeGcwQ9YISJ2c+YYGYLy/RvHU21C4JiYMvXkDV
 y0u8uLScBWbmtHOvmSHsUIkjm1YzTWAUmoVk1Cwko2YhGbWAkXkVo1BuZnJ2alFmtl5BRmVJ
 arJeSuomRlDAizBw7WDsm+NxiJGJg/EQowQHs5II70/NralCvCmJlVWpRfnxRaU5qcWHGKU5
 WJTEeVd3BKcKCaQnlqRmp6YWpBbBZJk4OKUaGCf5Odr92/Xhc1Mk81SeKW4pfhsFZPifPD29
 KHC//rfs348Lppa1H18yl2G1fAyr1Oun9y11920vkd/5pOEj6zH9nqe51sd17IVfRs7f37qE
 eeEEn++bW7/Pdrj+n+HuZ/H588rL2Fv5uid7/7H7t6PC3+PUV8MGflGuXOaoz89euZ9Tmvb/
 6AIlluKMREMt5qLiRACamvIzZgIAAA==
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

Add documentation for PHYTEC phyCORE-AM64x SoM.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 doc/board/phytec/index.rst         |   1 +
 doc/board/phytec/phycore-am64x.rst | 159 +++++++++++++++++++++++++++++
 2 files changed, 160 insertions(+)
 create mode 100644 doc/board/phytec/phycore-am64x.rst

diff --git a/doc/board/phytec/index.rst b/doc/board/phytec/index.rst
index 965d40de4d..bf247313a3 100644
--- a/doc/board/phytec/index.rst
+++ b/doc/board/phytec/index.rst
@@ -8,5 +8,6 @@ PHYTEC
 
    imx8mm-phygate-tauri-l
    phycore-am62x
+   phycore-am64x
    phycore-imx8mm
    phycore-imx8mp
diff --git a/doc/board/phytec/phycore-am64x.rst b/doc/board/phytec/phycore-am64x.rst
new file mode 100644
index 0000000000..202b756dc4
--- /dev/null
+++ b/doc/board/phytec/phycore-am64x.rst
@@ -0,0 +1,159 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. sectionauthor:: Wadim Egorov <w.egorov@phytec.de>
+
+phyCORE-AM64x
+=============
+
+The `phyCORE-AM64x <https://www.phytec.com/product/phycore-am64x>`_ is a
+SoM (System on Module) featuring TI's AM64x SoC. It can be used in combination
+with different carrier boards. This module can come with different sizes and
+models for DDR, eMMC, SPI NOR Flash and various SoCs from the AM64x family.
+
+A development Kit, called `phyBOARD-Lyra <https://www.phytec.com/product/phyboard-am64x>`_
+is used as a carrier board reference design around the AM64x SoM.
+
+Quickstart
+----------
+
+* Download sources and TI firmware blobs
+* Build Trusted Firmware-A
+* Build OP-TEE
+* Build U-Boot for the R5
+* Build U-Boot for the A53
+* Create bootable uSD Card
+* Boot
+
+Sources
+-------
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_boot_sources
+    :end-before: .. k3_rst_include_end_boot_sources
+
+Build procedure
+---------------
+
+Setup the environment variables:
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_common_env_vars_desc
+    :end-before: .. k3_rst_include_end_common_env_vars_desc
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_board_env_vars_desc
+    :end-before: .. k3_rst_include_end_board_env_vars_desc
+
+Set the variables corresponding to this platform:
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_common_env_vars_defn
+    :end-before: .. k3_rst_include_end_common_env_vars_defn
+.. code-block:: bash
+
+ $ export UBOOT_CFG_CORTEXR=phycore_am64x_r5_defconfig
+ $ export UBOOT_CFG_CORTEXA=phycore_am64x_a53_defconfig
+ $ export TFA_BOARD=lite
+ $ # we don't use any extra TFA parameters
+ $ unset TFA_EXTRA_ARGS
+ $ export OPTEE_PLATFORM=k3-am64x
+ # we don't use any extra OPTEE parameters
+ unset OPTEE_EXTRA_ARGS
+
+.. include::  ../ti/am62x_sk.rst
+    :start-after: .. am62x_evm_rst_include_start_build_steps
+    :end-before: .. am62x_evm_rst_include_end_build_steps
+
+uSD Card creation
+-----------------
+
+Use fdisk to partition the uSD card. The layout should look similar to:
+
+.. code-block:: bash
+
+ $ sudo fdisk -l /dev/mmcblk0
+ Disk /dev/mmcblk0: 7.56 GiB, 8120172544 bytes, 15859712 sectors
+ Units: sectors of 1 * 512 = 512 bytes
+ Sector size (logical/physical): 512 bytes / 512 bytes
+ I/O size (minimum/optimal): 512 bytes / 512 bytes
+ Disklabel type: dos
+ Disk identifier: 0x6583d9a3
+
+ Device         Boot  Start     End Sectors   Size Id Type
+ /dev/mmcblk0p1 *      2048  264191  262144   128M  c W95 FAT32 (LBA)
+ /dev/mmcblk0p2      264192 1934953 1670762 815.8M 83 Linux
+
+
+Once partitioned, the boot partition has to be formatted with a FAT filesystem.
+Assuming the uSD card is `/dev/mmcblk0`:
+
+.. code-block:: bash
+
+ $ mkfs.vfat /dev/mmcblk0p1
+
+To boot from a micro SD card on a HSFS device simply copy the following
+artifacts to the FAT partition:
+
+* tiboot3.bin from R5 build as tiboot3.bin
+* tispl.bin_unsigned from Cortex-A build as tispl.bin
+* u-boot.img_unsigned from Cortex-A build as u-boot.img
+
+Boot
+----
+
+Put the uSD card in the slot on the board and apply power. Check the serial
+console for output.
+
+Flash to SPI NOR
+----------------
+
+Below commands can be used to flash the SPI NOR flash; assuming
+tiboot3.bin, tispl.bin and u-boot.img are stored on the uSD card.
+
+.. code-block:: bash
+
+  sf probe
+  fatload mmc 1 ${loadaddr} tiboot3.bin
+  sf update $loadaddr 0x0 $filesize
+  fatload mmc 1 ${loadaddr} tispl.bin
+  sf update $loadaddr 0x80000 $filesize
+  fatload mmc 1 ${loadaddr} u-boot.img
+  sf update $loadaddr 0x280000 $filesize
+
+
+Boot Modes
+----------
+
+The phyCORE-AM64x development kit supports booting from many different
+interfaces. By default, the development kit is set to boot from the micro-SD
+card. To change the boot device, DIP switches S5 and S6 can be used.
+Boot switches should be changed with power off.
+
+.. list-table:: Boot Modes
+   :widths: 16 16 16
+   :header-rows: 1
+
+   * - Switch Label
+     - SW3: 12345678
+     - SW4: 12345678
+
+   * - uSD
+     - 11000010
+     - 01000000
+
+   * - eMMC
+     - 11010010
+     - 00000000
+
+   * - OSPI
+     - 11010000
+     - 10000000
+
+   * - UART
+     - 11011100
+     - 00000000
+
+Further Information
+-------------------
+
+Please see :doc:`../ti/am64x_evm` chapter for further AM64 SoC related documentation
+and https://docs.phytec.com/phycore-am64x for vendor documentation.
-- 
2.34.1

