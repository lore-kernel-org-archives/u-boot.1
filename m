Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864D5C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 09:18:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63DF187695;
	Wed, 20 Dec 2023 10:18:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="WSC32QvL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3A3D87480; Wed, 20 Dec 2023 10:18:24 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36F668758C
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 10:18:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1703063900; x=1705655900;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DQmhY4DLT3SM3zk+QtKhXsTHDj6R9iCfQY2spqeQ+uQ=;
 b=WSC32QvLBmdR3sA2GEZMph8NHjeY9FyJcA/KN+iMUEP+pYptDHM6DusXG7SVeykR
 qOXtq6EPl/88XXAsCJQ4FwcFUhK0uN/ZKxT97DXTVAaFNjBzQDHN3oPP+eBCspwq
 n60mIb6Py69x5QwesvaAQdb54o84FSP083fNzmDO4y8=;
X-AuditID: ac14000a-fadff7000000290d-99-6582b15c4e05
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 3C.31.10509.C51B2856;
 Wed, 20 Dec 2023 10:18:20 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 20 Dec
 2023 10:18:19 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, <nm@ti.com>, <trini@konsulko.com>
Subject: [PATCH v4 2/2] doc: board: phytec: Add phyCORE-AM62x
Date: Wed, 20 Dec 2023 10:18:11 +0100
Message-ID: <20231220091811.80373-3-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231220091811.80373-1-w.egorov@phytec.de>
References: <20231220091811.80373-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsWyRpKBRzdmY1OqwcbNnBZvfpxlspg6aTO7
 xdu9newW3e/UHVg8Xh1Yxe5x9s4ORo/+7hZWj+M3tjMFsERx2aSk5mSWpRbp2yVwZcw4M5e9
 YL5exeeGSawNjLNUuxg5OSQETCSm3vvK2MXIxSEksJhJ4mD7LxYI5zGjxNutzcwgVWwC6hJ3
 NnxjBbFFBKQkXnZuBIszCzhKPP10nwXEFhawlZh85xBYDYuAqsThnzeYQGxeAXOJv3v62SG2
 yUvMvPQdzOYUsJBYv/QR2BwhoJqOvw9ZIOoFJU7OfMICMV9eonnrbKhdEhIHX7yAqpeXeHFp
 OQvMzGnnXjND2KESRzatZprAKDQLyahZSEbNQjJqASPzKkah3Mzk7NSizGy9gozKktRkvZTU
 TYygQBdh4NrB2DfH4xAjEwfjIUYJDmYlEd69nU2pQrwpiZVVqUX58UWlOanFhxilOViUxHlX
 dwSnCgmkJ5akZqemFqQWwWSZODilGhi1fPW3pCzs9JRPqYybvTjfUZK3ijM8v9p1Q8zuP/Im
 T78kGMovbuWv37km8rSDEIM439mEfKd883mXu/8LTjn3+soS6e6wD9q51heCDj3cH5n0uln2
 b+Xrx3wTZLflN1elVolbuIVUftY5ax1TvtPAuufE8R1vjn1L27Op7lDyKV4fncdrmJRYijMS
 DbWYi4oTAVh4iUliAgAA
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

Add documentation for PHYTEC phyCORE-AM62x SoM.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
---
 doc/board/phytec/index.rst         |   1 +
 doc/board/phytec/phycore-am62x.rst | 158 +++++++++++++++++++++++++++++
 doc/board/ti/k3.rst                |   1 +
 3 files changed, 160 insertions(+)
 create mode 100644 doc/board/phytec/phycore-am62x.rst

diff --git a/doc/board/phytec/index.rst b/doc/board/phytec/index.rst
index a5b442045e..b914cc3fbd 100644
--- a/doc/board/phytec/index.rst
+++ b/doc/board/phytec/index.rst
@@ -6,5 +6,6 @@ PHYTEC
 .. toctree::
    :maxdepth: 2
 
+   phycore-am62x
    phycore-imx8mm
    phycore-imx8mp
diff --git a/doc/board/phytec/phycore-am62x.rst b/doc/board/phytec/phycore-am62x.rst
new file mode 100644
index 0000000000..1d641a78cf
--- /dev/null
+++ b/doc/board/phytec/phycore-am62x.rst
@@ -0,0 +1,158 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. sectionauthor:: Wadim Egorov <w.egorov@phytec.de>
+
+phyCORE-AM62x
+=============
+
+The `phyCORE-AM62x <https://www.phytec.com/product/phycore-am62x>`_ is a
+SoM (System on Module) featuring TI's AM62x SoC. It can be used in combination
+with different carrier boards. This module can come with different sizes and
+models for DDR, eMMC, SPI NOR Flash and various SoCs from the AM62x family.
+
+A development Kit, called `phyBOARD-Lyra <https://www.phytec.com/product/phyboard-am62x>`_
+is used as a carrier board reference design around the AM62x SoM.
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
+ $ export UBOOT_CFG_CORTEXR=phycore_am62x_r5_defconfig
+ $ export UBOOT_CFG_CORTEXA=phycore_am62x_a53_defconfig
+ $ export TFA_BOARD=lite
+ $ # we don't use any extra TFA parameters
+ $ unset TFA_EXTRA_ARGS
+ $ export OPTEE_PLATFORM=k3-am62x
+ $ export OPTEE_EXTRA_ARGS="CFG_WITH_SOFTWARE_PRNG=y"
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
+The phyCORE-AM62x development kit supports booting from many different
+interfaces. By default, the development kit is set to boot from the micro-SD
+card. To change the boot device, DIP switches S5 and S6 can be used.
+Boot switches should be changed with power off.
+
+.. list-table:: Boot Modes
+   :widths: 16 16 16
+   :header-rows: 1
+
+   * - Switch Label
+     - SW5: 12345678
+     - SW6: 12345678
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
+Please see :doc:`../ti/am62x_sk` chapter for further AM62 SoC related documentation
+and https://docs.phytec.com/phycore-am62x for vendor documentation.
diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index f19ee56f29..dab781b2ae 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -33,6 +33,7 @@ K3 Based SoCs
    am62ax_sk
    am62x_sk
    ../beagle/am62x_beagleplay
+   ../phytec/phycore-am62x
    ../toradex/verdin-am62
    am64x_evm
    am65x_evm
-- 
2.34.1

