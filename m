Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70968C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 13:38:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D95338760C;
	Tue, 31 Oct 2023 14:38:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="LS98CSEB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C85CD875F4; Tue, 31 Oct 2023 14:38:28 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6998287A88
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 14:38:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1698759506; x=1701351506;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ElkgLF1bZyBZ0GXQXJ2l/d4IKGfTpvxFHjh2RplqkhE=;
 b=LS98CSEBJdpPTzgDNxNY2dopr9aRnhYO4IfmPe37G6lbF/nSqyeJEgLI4vECRPMU
 11it/QYi0tnm6hkq3aOv3/Zm5CsBhSuB6UEIsLCNwgOY7K8PQ+G5im2JcXvxxShg
 DFayRrtcjZvFXuWJKAJXVyvcSwE/4X1/OhEsZL6XjKo=;
X-AuditID: ac14000a-41e48240000074e4-d8-65410352a5fa
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 70.AD.29924.25301456;
 Tue, 31 Oct 2023 14:38:26 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 31 Oct
 2023 14:38:25 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, <nm@ti.com>
Subject: [PATCH 2/2] doc: board: phytec: Add phyCORE-AM62x
Date: Tue, 31 Oct 2023 14:37:32 +0100
Message-ID: <20231031133732.265589-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231031133732.265589-1-w.egorov@phytec.de>
References: <20231031133732.265589-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsWyRpKBRzeI2THV4NtjVos3P84yWbzd28lu
 0f1O3YHZ4+ydHYwe/d0trB7Hb2xnCmCO4rJJSc3JLEst0rdL4Mro/iVYcF6jYtObI0wNjEsU
 uxg5OSQETCQm9U1m7mLk4hASWMwkcaD/KiuE85hR4uSumywgVWwC6hJ3NnxjBbFFBKQkXnZu
 ZAaxmQW0Jc7e2MkEYgsLWEns/7sZLM4ioCrxZtpUsHpeAQuJCU++sUFsk5eYeek7O4jNKWAp
 cf1KD5gtBFSztPk3O0S9oMTJmU9YIObLSzRvnQ21S0Li4IsXzBD18hIvLi1ngZk57dxrZgg7
 VGLrl+1MExiFZiEZNQvJqFlIRi1gZF7FKJSbmZydWpSZrVeQUVmSmqyXkrqJERTSIgxcOxj7
 5ngcYmTiYDzEKMHBrCTCe9jUIVWINyWxsiq1KD++qDQntfgQozQHi5I47/0epkQhgfTEktTs
 1NSC1CKYLBMHp1QDI4+y/mFhVqaCCGcj5Q9zvyy+/er/6ZNNKUs2mgZ93HboYFpJcA377Jfn
 or5UpV+d33zkkexzUZnJ7haG4TxFUXa/FsmFlEXVdZ5gevgnRUH9retqpZOiU4TKmk5V3X3j
 tVV7ypM5W39t/vNlf/DflF4hhiu89UJiiSErIiYVCk8wcP3umZCTo8RSnJFoqMVcVJwIAMkO
 Bd5XAgAA
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
---
 doc/board/phytec/index.rst         |   1 +
 doc/board/phytec/phycore-am62x.rst | 125 +++++++++++++++++++++++++++++
 doc/board/ti/k3.rst                |   1 +
 3 files changed, 127 insertions(+)
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
index 0000000000..46312a73bc
--- /dev/null
+++ b/doc/board/phytec/phycore-am62x.rst
@@ -0,0 +1,125 @@
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
+To boot from an uSD on a GP device simply copy the following artifacts to the
+FAT partition:
+
+* tiboot3-am62x-gp-phycore-som.bin from R5 build as tiboot3.bin
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
+Further Information
+-------------------
+
+Please see :doc:`../ti/am62x_sk` chapter for further AM62 SoC related documentation
+and https://docs.phytec.com/phycore-am62x for vendor documentation.
diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 89d70db886..f659398200 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -32,6 +32,7 @@ K3 Based SoCs
 
    am62x_beagleplay
    am62x_sk
+   ../phytec/phycore-am62x
    ../toradex/verdin-am62
    am64x_evm
    am65x_evm
-- 
2.34.1

