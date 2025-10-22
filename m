Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C5ECCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 10:27:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B16298357F;
	Wed, 22 Oct 2025 12:26:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jZR+LILZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0D7683807; Wed, 22 Oct 2025 12:26:30 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54514832BC
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 12:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59MAQQbX246804;
 Wed, 22 Oct 2025 05:26:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761128786;
 bh=stTgCptiRJUvJa2xXoGLOqA5FJZGtHgNPdwYkIjwmx8=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=jZR+LILZGH8of2VmRa7LPqQzexS4Duk2J5GQYAcM01r2L/yihjuN+Nwtlrco/Ev2k
 cqcH92fx2Mik4Aw62DdXYrwbaCIEgY0SNnXFq2CffUaCvG4zw/cSOQ3wbYX7ECJrwM
 C6T4jI4dzU8/L3ENr39oWpnl4UYhjhPs3iwRBum0=
Received: from DFLE214.ent.ti.com (dfle214.ent.ti.com [10.64.6.72])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59MAQQi01858253
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 Oct 2025 05:26:26 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 05:26:26 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Oct 2025 05:26:26 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59MAQPwI1048730;
 Wed, 22 Oct 2025 05:26:26 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Wed, 22 Oct 2025 15:55:44 +0530
Subject: [PATCH 8/8] doc: add documentation for am6254atl SiP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251022-62sip_support-v1-8-eed08d15e76d@ti.com>
References: <20251022-62sip_support-v1-0-eed08d15e76d@ti.com>
In-Reply-To: <20251022-62sip_support-v1-0-eed08d15e76d@ti.com>
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Beleswar Padhi <b-padhi@ti.com>, Nishanth
 Menon <nm@ti.com>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Vignesh R <vigneshr@ti.com>,
 Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761128770; l=9110;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=2eJDzNowYdb5rrgHC25JYsgcnGKct/jJGdZjnrJwqFA=;
 b=UTaO3TtWwKF82/3j4y3gaea1QnDtYyIuWWnjIwzWbwHh4roiaa+y32e9OY6f8ahA47pLrUPss
 NAIx4p8PnmTA9l7AG7ACyYblqmdbALHhOVyu2GfSTt1UgUDqpTYzlVS
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Adds documentation for the newly added am6254atl EVM board along with
build instructions.

The content is largely similar to instructions for AM62x with updated
TFA and OPTEE build args to account for the changes to A53 and OPTEE's
load address.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 doc/board/ti/am6254atl_sk.rst | 313 ++++++++++++++++++++++++++++++++++++++++++
 doc/board/ti/k3.rst           |   1 +
 2 files changed, 314 insertions(+)

diff --git a/doc/board/ti/am6254atl_sk.rst b/doc/board/ti/am6254atl_sk.rst
new file mode 100644
index 0000000000000000000000000000000000000000..480c0b07cfa85ebae495593b40c6a34692b15cda
--- /dev/null
+++ b/doc/board/ti/am6254atl_sk.rst
@@ -0,0 +1,313 @@
+.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. sectionauthor:: Anshul Dalal <anshuld@ti.com>
+
+AM6254ATL SIP Platforms
+=======================
+
+Introduction:
+-------------
+
+The AM6254atl SIP (System In Package) provides existing :doc:`am62x_sk` with
+512MiB of DDR integrated in a single packages.
+
+More details can be found in the Technical Reference Manual:
+https://www.ti.com/lit/pdf/spruiv7
+
+Platform information:
+
+* https://www.ti.com/tool/SK-AM62-SIP
+
+Boot Flow:
+----------
+Below is the pictorial representation of boot flow:
+
+.. image:: img/boot_diagram_am62.svg
+  :alt: Boot flow diagram
+
+- Here TIFS acts as master and provides all the critical services. R5/A53
+  requests TIFS to get these services done as shown in the above diagram.
+
+Sources:
+--------
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_boot_sources
+    :end-before: .. k3_rst_include_end_boot_sources
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_boot_firmwares
+    :end-before: .. k3_rst_include_end_tifsstub
+
+Build procedure:
+----------------
+0. Setup the environment variables:
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
+.. prompt:: bash $
+
+  export UBOOT_CFG_CORTEXR=am6254atl_evm_r5_defconfig
+  export UBOOT_CFG_CORTEXA=am6254atl_evm_a53_defconfig
+  export TFA_BOARD=lite
+  export TFA_EXTRA_ARGS="PRELOADED_BL33_BASE=0x81880000 BL32_BASE=0x80080000"
+  export OPTEE_PLATFORM=k3-am62x
+  export OPTEE_EXTRA_ARGS="CFG_TZDRAM_START=0x80080000"
+
+1. Trusted Firmware-A:
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_tfa
+    :end-before: .. k3_rst_include_end_build_steps_tfa
+
+
+2. OP-TEE:
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_optee
+    :end-before: .. k3_rst_include_end_build_steps_optee
+
+3. U-Boot:
+
+* 3.1 R5:
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_spl_r5
+    :end-before: .. k3_rst_include_end_build_steps_spl_r5
+
+* 3.1.1 Alternative build of R5 for DFU boot:
+
+As the SPL size can get too big when building with support for booting both
+from local storage *and* DFU an extra config fragment should be used to enable
+DFU support (and disable storage support)
+
+.. prompt:: bash $
+
+  export UBOOT_CFG_CORTEXR="${UBOOT_CFG_CORTEXR} am62x_r5_usbdfu.config"
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_spl_r5
+    :end-before: .. k3_rst_include_end_build_steps_spl_r5
+
+* 3.2 A53:
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_uboot
+    :end-before: .. k3_rst_include_end_build_steps_uboot
+
+Target Images
+-------------
+
+In order to boot we need tiboot3.bin, tispl.bin and u-boot.img.  Each SoC
+variant (GP, HS-FS, HS-SE) requires a different source for these files.
+
+ - GP
+
+        * tiboot3-am62x-gp-evm.bin from step 3.1
+        * tispl.bin_unsigned, u-boot.img_unsigned from step 3.2
+
+ - HS-FS
+
+        * tiboot3-am62x-hs-fs-evm.bin from step 3.1
+        * tispl.bin, u-boot.img from step 3.2
+
+ - HS-SE
+
+        * tiboot3-am62x-hs-evm.bin from step 3.1
+        * tispl.bin, u-boot.img from step 3.2
+
+Image formats:
+--------------
+
+- tiboot3.bin
+
+.. image:: img/multi_cert_tiboot3.bin.svg
+  :alt: tiboot3.bin image format
+
+- tispl.bin
+
+.. image:: img/tifsstub_dm_tispl.bin.svg
+  :alt: tispl.bin image format
+
+OSPI:
+-----
+ROM supports booting from OSPI from offset 0x0.
+
+Flashing images to OSPI:
+
+Below commands can be used to download tiboot3.bin, tispl.bin, and u-boot.img,
+over tftp and then flash those to OSPI at their respective addresses.
+
+.. prompt:: bash =>
+
+  sf probe
+  tftp ${loadaddr} tiboot3.bin
+  sf update $loadaddr 0x0 $filesize
+  tftp ${loadaddr} tispl.bin
+  sf update $loadaddr 0x80000 $filesize
+  tftp ${loadaddr} u-boot.img
+  sf update $loadaddr 0x280000 $filesize
+
+Flash layout for OSPI:
+
+.. image:: img/ospi_sysfw2.svg
+  :alt: OSPI flash partition layout
+
+A53 SPL DDR Memory Layout
+-------------------------
+
+This provides an overview memory usage in A53 SPL stage.
+
+.. list-table::
+   :widths: 16 16 16
+   :header-rows: 1
+
+   * - Region
+     - Start Address
+     - End Address
+
+   * - ATF
+     - 0x80000000
+     - 0x80080000
+
+   * - OPTEE
+     - 0x80080000
+     - 0x81880000
+
+   * - TEXT BASE
+     - 0x81880000
+     - 0x818d8000
+
+   * - EMPTY
+     - 0x818d8000
+     - 0x81a00000
+
+   * - BMP IMAGE
+     - 0x81a00000
+     - 0x82377660
+
+   * - STACK
+     - 0x82377660
+     - 0x82377e60
+
+   * - GD
+     - 0x82377e60
+     - 0x80b78000
+
+   * - MALLOC
+     - 0x82378000
+     - 0x82380000
+
+   * - EMPTY
+     - 0x82380000
+     - 0x82480000
+
+   * - BSS
+     - 0x82480000
+     - 0x82500000
+
+   * - BLOBS
+     - 0x82500000
+     - 0x82500400
+
+   * - EMPTY
+     - 0x82500400
+     - 0x82800000
+
+Switch Setting for Boot Mode
+----------------------------
+
+Boot Mode pins provide means to select the boot mode and options before the
+device is powered up. After every POR, they are the main source to populate
+the Boot Parameter Tables.
+
+The following table shows some common boot modes used on AM62 platform. More
+details can be found in the Technical Reference Manual:
+https://www.ti.com/lit/pdf/spruiv7 under the `Boot Mode Pins` section.
+
+.. list-table:: Boot Modes
+   :widths: 16 16 16
+   :header-rows: 1
+
+   * - Switch Label
+     - SW2: 12345678
+     - SW3: 12345678
+
+   * - SD
+     - 01000000
+     - 11000010
+
+   * - OSPI
+     - 00000000
+     - 11001110
+
+   * - EMMC
+     - 00000000
+     - 11010010
+
+   * - UART
+     - 00000000
+     - 11011100
+
+   * - USB DFU
+     - 00000000
+     - 11001010
+
+   * - Ethernet
+     - 00110000
+     - 11000100
+
+For SW2 and SW1, the switch state in the "ON" position = 1.
+
+DFU based boot
+--------------
+
+To boot the board over DFU, set the switches to DFU mode and connect to the
+USB type C DRD port on the board. After power-on the build artifacts needs to be
+uploaded one by one with a tool like dfu-util.
+
+The initial ROM will have a DFU alt named `bootloader` for the initial R5 spl
+upload. The next stages as exposed by U-Boot have target alts matching the name
+of the artifacts, for these a USB reset has to be done after each upload.
+
+When using dfu-util the following commands can be used to boot to a U-Boot shell:
+
+.. prompt:: bash $
+
+  dfu-util -a bootloader -D tiboot3.bin
+  dfu-util -R -a tispl -D tispl.bin
+  dfu-util -R -a u-boot.img -D u-boot.img
+
+Debugging U-Boot
+----------------
+
+See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
+detailed setup information.
+
+.. warning::
+
+  **OpenOCD support since**: v0.12.0
+
+  If the default package version of OpenOCD in your development
+  environment's distribution needs to be updated, it might be necessary to
+  build OpenOCD from the source.
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_openocd_connect_XDS110
+    :end-before: .. k3_rst_include_end_openocd_connect_XDS110
+
+To start OpenOCD and connect to the board
+
+.. prompt:: bash $
+
+  openocd -f board/ti_am625evm.cfg
diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 01fb9411688708afc8ad5b74a9cd3ec2e4e998d5..fafef239e0117528e1ff9dad44904abf0dfec8a3 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -33,6 +33,7 @@ K3 Based SoCs
    am62ax_sk
    am62x_sk
    am62px_sk
+   am6254atl_sk
    am64x_evm
    am65x_evm
    j7200_evm

-- 
2.51.0

