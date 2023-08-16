Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36957C001B0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 09:24:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0237B8699B;
	Wed, 16 Aug 2023 11:23:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YDT3GjlN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96BA6847C3; Wed, 16 Aug 2023 11:23:40 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB79F869CC
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 11:23:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37G9NZoo054929;
 Wed, 16 Aug 2023 04:23:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692177815;
 bh=vtwjrxt3AAuYWAKfOfrH+M+LH3IjcXc+e0Hc7wOb/Pk=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=YDT3GjlNw9GLh07ll1/8NgYfNYSFQvcyTY2Dq1puIQ8Q8SGNwpt53yVrcgbDGzPaq
 4GrV6taopVIN6JNlqsRxLdAhfQyyAAEAUUObvRl4XLKyD3s8OIPJvhOOvz08Y/wmNC
 woH4htLe1f9MOudjpEx9MeBC7ygxbWq29GoqY0Gs=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37G9NZQ8062402
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Aug 2023 04:23:35 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Aug 2023 04:23:34 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Aug 2023 04:23:34 -0500
Received: from [127.0.1.1] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37G9NJBl059893;
 Wed, 16 Aug 2023 04:23:31 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 16 Aug 2023 14:53:11 +0530
Subject: [PATCH 3/3] docs: ti: j721s2_evm: Create documentation from J7200 docs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230816-b4-upstream-j721s2-r5-pinmux-v1-3-f4548452760a@ti.com>
References: <20230816-b4-upstream-j721s2-r5-pinmux-v1-0-f4548452760a@ti.com>
In-Reply-To: <20230816-b4-upstream-j721s2-r5-pinmux-v1-0-f4548452760a@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692177800; l=6952;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=L8H6ODJ86k4Nd/R79ClrvpsnD/aTFeW3QjG7QGUgXWA=;
 b=3Szko5xyDjKCi4XkNVktpVgCskzKy5TGtl5xrZvNjL5C4mY19dJ08SnhVXz4YHDizIKOopx75
 hcE5jAQaGRYAQGZ+VaLAWsPx0uoFF5oc116IPSyw3261nl+tY8KBKlB
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=Z51yAzxWCcDqKRLHiDBrUxIdXbB21R89ms8xgECdiak=
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

The documentation is based off J7200 documentation tailored for J721S2.

TRM for J721S2: https://www.ti.com/lit/pdf/spruj28
Product Page: https://www.ti.com/product/TDA4AL-Q1

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 MAINTAINERS                 |   1 +
 doc/board/ti/j721s2_evm.rst | 228 ++++++++++++++++++++++++++++++++++++++++++++
 doc/board/ti/k3.rst         |   1 +
 3 files changed, 230 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 77a8b0ac2181..1b14ce541e91 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -667,6 +667,7 @@ F:	arch/arm/mach-omap2/
 F:	arch/arm/include/asm/arch-omap*/
 F:	arch/arm/include/asm/ti-common/
 F:	board/ti/
+F:	doc/board/ti
 F:	drivers/dma/ti*
 F:	drivers/firmware/ti_sci.*
 F:	drivers/gpio/omap_gpio.c
diff --git a/doc/board/ti/j721s2_evm.rst b/doc/board/ti/j721s2_evm.rst
new file mode 100644
index 000000000000..519e43610dcf
--- /dev/null
+++ b/doc/board/ti/j721s2_evm.rst
@@ -0,0 +1,228 @@
+.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. sectionauthor:: Manorit Chawdhry <m-chawdhry@ti.com>
+
+J721S2 Platforms
+================
+
+Introduction:
+-------------
+The J721S2 family of SoCs are part of K3 Multicore SoC architecture platform
+targeting automotive applications. They are designed as a low power, high
+performance and highly integrated device architecture, adding significant
+enhancement on processing power, graphics capability, video and imaging
+processing, virtualization and coherent memory support.
+
+The device is partitioned into three functional domains, each containing
+specific processing cores and peripherals:
+
+1. Wake-up (WKUP) domain:
+        * Device Management and Security Controller (DMSC)
+
+2. Microcontroller (MCU) domain:
+        * Dual Core ARM Cortex-R5F processor
+
+3. MAIN domain:
+        * Dual core 64-bit ARM Cortex-A72
+
+More info can be found in TRM: https://www.ti.com/lit/pdf/spruj28
+
+Platform information:
+
+* https://www.ti.com/tool/J721S2XSOMXEVM
+
+Boot Flow:
+----------
+Below is the pictorial representation of boot flow:
+
+.. image:: img/boot_diagram_k3_current.svg
+
+- Here DMSC acts as master and provides all the critical services. R5/A72
+  requests DMSC to get these services done as shown in the above diagram.
+
+Sources:
+--------
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_boot_sources
+    :end-before: .. k3_rst_include_end_boot_sources
+
+Build procedure:
+----------------
+0. Setup the environment variables:
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_common_env_vars_desc
+    :end-before: .. k3_rst_include_end_common_env_vars_desc
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_board_env_vars_desc
+    :end-before: .. k3_rst_include_end_board_env_vars_desc
+
+Set the variables corresponding to this platform:
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_common_env_vars_defn
+    :end-before: .. k3_rst_include_end_common_env_vars_defn
+.. code-block:: bash
+
+ $ export UBOOT_CFG_CORTEXR=j721s2_evm_r5_defconfig
+ $ export UBOOT_CFG_CORTEXA=j721s2_evm_a72_defconfig
+ $ export TFA_BOARD=generic
+ $ export TFA_EXTRA_ARGS="K3_USART=0x8"
+ $ # This is not a typo, j784s4 is the
+ $ # OP-TEE platform for j721s2
+ $ export OPTEE_PLATFORM=k3-j784s4
+ $ export OPTEE_EXTRA_ARGS="CFG_CONSOLE_UART=0x8"
+
+.. j721s2_evm_rst_include_start_build_steps
+
+1. Trusted Firmware-A:
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_tfa
+    :end-before: .. k3_rst_include_end_build_steps_tfa
+
+
+2. OP-TEE:
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_optee
+    :end-before: .. k3_rst_include_end_build_steps_optee
+
+3. U-Boot:
+
+* 4.1 R5:
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_spl_r5
+    :end-before: .. k3_rst_include_end_build_steps_spl_r5
+
+* 4.2 A72:
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_uboot
+    :end-before: .. k3_rst_include_end_build_steps_uboot
+.. j721s2_evm_rst_include_end_build_steps
+
+Target Images
+--------------
+In order to boot we need tiboot3.bin, tispl.bin and u-boot.img. Each SoC
+variant (GP, HS-FS, HS-SE) requires a different source for these files.
+
+ - GP
+
+        * tiboot3-j721s2-gp-evm.bin from step 4.1
+        * tispl.bin_unsigned, u-boot.img_unsigned from step 4.2
+
+ - HS-FS
+
+        * tiboot3-j721s2-hs-fs-evm.bin from step 4.1
+        * tispl.bin, u-boot.img from step 4.2
+
+ - HS-SE
+
+        * tiboot3-j721s2-hs-evm.bin from step 4.1
+        * tispl.bin, u-boot.img from step 4.2
+
+Image formats:
+--------------
+
+- tiboot3.bin
+
+.. image:: img/multi_cert_tiboot3.bin.svg
+
+- tispl.bin
+
+.. image:: img/dm_tispl.bin.svg
+
+R5 Memory Map:
+--------------
+
+.. list-table::
+   :widths: 16 16 16
+   :header-rows: 1
+
+   * - Region
+     - Start Address
+     - End Address
+
+   * - SPL
+     - 0x41c00000
+     - 0x41c40000
+
+   * - EMPTY
+     - 0x41c40000
+     - 0x41c61f20
+
+   * - STACK
+     - 0x41c65f20
+     - 0x41c61f20
+
+   * - Global data
+     - 0x41c65f20
+     - 0x41c66000
+
+   * - Heap
+     - 0x41c66000
+     - 0x41c76000
+
+   * - BSS
+     - 0x41c76000
+     - 0x41c80000
+
+   * - DM DATA
+     - 0x41c80000
+     - 0x41c84130
+
+   * - EMPTY
+     - 0x41c84130
+     - 0x41cff9fc
+
+   * - MCU Scratchpad
+     - 0x41cff9fc
+     - 0x41cffbfc
+
+   * - ROM DATA
+     - 0x41cffbfc
+     - 0x41cfffff
+
+Switch Setting for Boot Mode
+----------------------------
+
+Boot Mode pins provide means to select the boot mode and options before the
+device is powered up. After every POR, they are the main source to populate
+the Boot Parameter Tables.
+
+The following table shows some common boot modes used on J721S2 platform.
+More details can be found in the Technical Reference Manual:
+https://www.ti.com/lit/pdf/spruj28 under the `Boot Mode Pins` section.
+
+.. list-table:: Boot Modes
+   :widths: 16 16 16
+   :header-rows: 1
+
+   * - Switch Label
+     - SW9: 12345678
+     - SW8: 12345678
+
+   * - SD
+     - 00000000
+     - 10000010
+
+   * - EMMC
+     - 01000000
+     - 10000000
+
+   * - OSPI
+     - 01000000
+     - 00000110
+
+   * - UART
+     - 01110000
+     - 00000000
+
+   * - USB DFU
+     - 00100000
+     - 10000000
+
+For SW8 and SW9, the switch state in the "ON" position = 1.
diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index d2f86b0a11a7..b0be048edb12 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -35,6 +35,7 @@ K3 Based SoCs
    am65x_evm
    j7200_evm
    j721e_evm
+   j721s2_evm
 
 Boot Flow Overview
 ------------------

-- 
2.41.0

