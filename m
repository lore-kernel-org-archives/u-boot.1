Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8F5C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 14:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4988F828BC;
	Fri, 25 Apr 2025 16:57:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qScyMvNa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B80BB829C3; Fri, 25 Apr 2025 16:57:20 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D56FA82115
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 16:57:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53PEvFbJ2964139
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Apr 2025 09:57:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745593035;
 bh=z+TRtSKhQZZ3JbeTX2ss3HBqZlBJNXOuzicDbKMSFsA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=qScyMvNa1Ry48RtjyPaRFYJMEAgEytW1pEqSeu5xywf8VsMKYIox5n/dtffQjfJQn
 0nD6EkMa+ULfXxr9V28xi/08uuITsm4TjBB7gTOIe3xZuNIwQOrzx+V0bt1SBdnGNs
 1s4+KvCHjKzb2JUKzhWQX8w8ZYhMUy2lYAmlsmhU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53PEvFXe023323
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Apr 2025 09:57:15 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Apr 2025 09:57:15 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Apr 2025 09:57:15 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53PEvEBm067160;
 Fri, 25 Apr 2025 09:57:14 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <khasim@ti.com>, <vigneshr@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <m-chawdhry@ti.com>,
 <n-francis@ti.com>, <b-liu@ti.com>
Subject: [PATCH v5 9/9] doc: ti: am62: add falcon mode documentation
Date: Fri, 25 Apr 2025 20:26:40 +0530
Message-ID: <20250425145644.2228186-10-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425145644.2228186-1-anshuld@ti.com>
References: <20250425145644.2228186-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

This patch adds user documentation for falcon boot for am62 platforms.
The main section is added to am62x_sk.rst and other documents just
include the section. Steps to build falcon support, usage and the
modified R5 memory map have been documented.

Two svg images have also been added for reference, one for the modified
tispl_falcon.bin and other for the falcon specific fitImage format.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 doc/board/ti/am62ax_sk.rst                    |   7 +
 doc/board/ti/am62px_sk.rst                    |   7 +
 doc/board/ti/am62x_sk.rst                     | 248 ++++++++++++++++++
 doc/board/ti/img/fitImage_falcon.svg          | Bin 0 -> 5511 bytes
 .../ti/img/tifsstub_dm_tispl_falcon.bin.svg   | Bin 0 -> 9466 bytes
 5 files changed, 262 insertions(+)
 create mode 100644 doc/board/ti/img/fitImage_falcon.svg
 create mode 100644 doc/board/ti/img/tifsstub_dm_tispl_falcon.bin.svg

diff --git a/doc/board/ti/am62ax_sk.rst b/doc/board/ti/am62ax_sk.rst
index 262340ef59a..9830916e3e0 100644
--- a/doc/board/ti/am62ax_sk.rst
+++ b/doc/board/ti/am62ax_sk.rst
@@ -192,6 +192,13 @@ https://www.ti.com/lit/pdf/spruj16 under the `Boot Mode Pins` section.
 
 For SW2 and SW1, the switch state in the "ON" position = 1.
 
+Falcon Mode
+-----------
+
+.. include:: am62x_sk.rst
+    :start-after: .. am62x_evm_falcon_mode_start
+    :end-before: .. am62x_evm_falcon_mode_end
+
 Debugging U-Boot
 ----------------
 
diff --git a/doc/board/ti/am62px_sk.rst b/doc/board/ti/am62px_sk.rst
index 99bdc034869..74f6dafa238 100644
--- a/doc/board/ti/am62px_sk.rst
+++ b/doc/board/ti/am62px_sk.rst
@@ -290,6 +290,13 @@ https://www.ti.com/lit/pdf/spruj83 under the `Boot Mode Pins` section.
 
 For SW2 and SW1, the switch state in the "ON" position = 1.
 
+Falcon Mode
+-----------
+
+.. include:: am62x_sk.rst
+    :start-after: .. am62x_evm_falcon_mode_start
+    :end-before: .. am62x_evm_falcon_mode_end
+
 Debugging U-Boot
 ----------------
 
diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
index dab2970a85c..711aef3f3ab 100644
--- a/doc/board/ti/am62x_sk.rst
+++ b/doc/board/ti/am62x_sk.rst
@@ -526,6 +526,254 @@ Next, based on NET_VCI_STRING string mentioned in respective defconfig file `tib
 fetches `tispl.bin` and then `tispl.bin` fetches `u-boot.img` from TFTP server which
 completes Ethernet boot on the device.
 
+Falcon Mode
+-----------
+
+.. am62x_evm_falcon_mode_start
+
+Falcon boot flow on am62 platforms bypasses the A-core SPL and u-boot with the
+overall boot flow as below:
+
+**Normal boot flow:**
+
+* R5 SPL -> ATF -> OP-TEE -> Cortex-A SPL -> U-Boot -> Kernel
+
+**With falcon mode:**
+
+* R5 SPL -> ATF -> OP-TEE -> Kernel
+
+Build Process
+^^^^^^^^^^^^^
+
+Enabling falcon mode requires re-building ATF, R5 U-boot and the kernel fitImage
+as follows:
+
+0. Setup environment variables:
+"""""""""""""""""""""""""""""""
+
+Refer to the build procedure above for setting up the environment variables.
+
+1. Trusted Firmware-A:
+""""""""""""""""""""""
+
+.. prompt:: bash $
+
+ # Change load addresses for the kernel and DTB
+ export TFA_EXTRA_ARGS="PRELOADED_BL33_BASE=0x82000000 K3_HW_CONFIG_BASE=0x88000000"
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_tfa
+    :end-before: .. k3_rst_include_end_build_steps_tfa
+
+2. R5 SPL:
+""""""""""
+
+.. prompt:: bash $
+
+ # use the common falcon config fragment for am62 platforms
+ export $UBOOT_FALCON_CFG_FRAGMENTR="am62x_r5_falcon.config"
+ export UBOOT_CFG_CORTEXR="${UBOOT_CFG_CORTEXR} ${UBOOT_FALCON_CFG_FRAGMENTR}"
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_spl_r5
+    :end-before: .. k3_rst_include_end_build_steps_spl_r5
+
+3. fitImage:
+""""""""""""
+
+.. warning::
+
+    The ``fitImage`` available by default under ``boot/fitImage`` in rootfs of
+    the standard SDK release is not compatible with falcon mode.
+
+For secure boot in falcon mode, the compute heavy authentication required for
+the ``fitImage`` is offloaded from the slower R5 core to TIFS. This requires
+``fitImage`` to package the necessary binaries (kernel and dtb) with a
+pre-signed x509 certificate.
+
+**fitImage for falcon mode:**
+
+.. image:: img/fitImage_falcon.svg
+  :alt: fitImage for falcon boot image format
+
+Follow the steps below to create a falcon compatible ``fitImage``:
+
+* **Sources**
+
+  * **Core Secdev K3**
+
+    | **source:** https://git.ti.com/cgit/security-development-tools/core-secdev-k3
+    | **branch:** master
+
+**3.1 Environment setup**
+
+.. prompt:: bash $
+
+  export CORE_SECDEV_PATH=path/to/core-secdev-k3
+  export DTB_PATH=path/to/dtb
+  export IMAGE_PATH=path/to/kernel-image
+
+**3.2 fitImage creation**
+
+  Inside ``core-secdev-k3`` source directory, create a file ``fitImage.its``
+  with the following contents:
+
+.. code-block:: dts
+
+    /dts-v1/;
+
+    / {
+        description = "Kernel fitImage for falcon mode";
+        #address-cells = <1>;
+
+        images {
+            kernel-1 {
+                description = "Linux kernel";
+                data = /incbin/("Image.sec");
+                type = "kernel";
+                arch = "arm64";
+                os = "linux";
+                compression = "none";
+                load = <0x82000000>;
+                entry = <0x82000000>;
+            };
+            falcon.dtb {
+                description = "Flattened Device Tree blob";
+                data = /incbin/("falcon.dtb.sec");
+                type = "flat_dt";
+                arch = "arm64";
+                compression = "none";
+                load = <0x88000000>;
+                entry = <0x88000000>;
+            };
+        };
+
+        configurations {
+            default = "conf-falcon";
+            conf-falcon {
+                description = "Pre-signed Kernel and DTB";
+                kernel = "kernel-1";
+                fdt = "falcon.dtb";
+            };
+        };
+    };
+
+Create the signed binaries:
+
+.. prompt:: bash $
+
+  # copy the kernel and dtb to core-secdev-k3
+  cp $IMAGE_PATH $CORE_SECDEV_PATH/Image
+  cp $DTB_PATH $CORE_SECDEV_PATH/falcon.dtb
+  # inside core-secdev-k3 source
+  ./scripts/secure-binary-image.sh Image Image.sec
+  ./scripts/secure-binary-image.sh falcon.dtb falcon.dtb.sec
+
+Create ``fitImage`` using mkimage:
+
+.. prompt:: bash $
+
+  mkimage -f $CORE_SECDEV_PATH/fitImage.its $CORE_SECDEV_PATH/fitImage
+
+Usage
+^^^^^
+
+Falcon mode makes use of a cut down variant of the tispl binary called
+``tispl_falcon.bin`` with the Cortex-A SPL and it's corresponding DTBs removed.
+This file should be present alongside the existing ``tispl.bin`` after building
+U-Boot for the Cortex-A cores.
+
+- **tispl_falcon.bin**
+
+.. image:: img/tifsstub_dm_tispl_falcon.bin.svg
+  :alt: tispl_falcon.bin image format
+
+1. eMMC/SD Boot:
+""""""""""""""""
+
+Falcon mode for K3 devices only supports SD and eMMC in FS boot. The R5 SPL
+once loaded from the ``tiboot3.bin`` file from the boot partition looks for
+``tispl_falcon.bin``, the DTB and fitImage (or kernel image for unauthenticated
+boot) inside the boot directory of the second partition (rootfs).
+
+.. list-table::
+   :widths: 8 8 8 25
+   :header-rows: 1
+
+   * - File
+     - Copy path on SD/eMMC
+     - Partition
+     - Description
+
+   * - ``tiboot3.bin``
+     - ``/tiboot3.bin``
+     - boot (fat)
+     - R5 SPL with falcon support
+
+   * - ``tispl_falcon.bin``
+     - ``/boot/tispl_falcon.bin``
+     - rootfs (ext4)
+     - tispl binary without SPL for the A core and DTB
+
+   * - ``fitImage``
+     - ``/boot/fitImage``
+     - rootfs (ext4)
+     - kernel and dtb fitImage with pre-signed binaries
+
+2. OSPI Boot:
+"""""""""""""
+
+For OSPI boot, the ``tiboot3.bin`` and ``tispl_falcon.bin`` files should be
+flashed to the same addresses in flash as regular boot flow but the DTB and the
+fitImage (or kernel image for unauthenticated boot) are read from the rootfs's
+boot directory.
+
+Below commands can be used to download ``tiboot3.bin`` and ``tispl_falcon.bin``
+over tftp and then flash those to OSPI at their respective addresses.
+
+.. prompt:: bash =>
+
+  sf probe
+  tftp ${loadaddr} tiboot3.bin
+  sf update $loadaddr 0x0 $filesize
+  tftp ${loadaddr} tispl_falcon.bin
+  sf update $loadaddr 0x80000 $filesize
+
+R5 SPL Memory Map:
+^^^^^^^^^^^^^^^^^^
+
+.. code-block::
+
+    0x80000000 +-------------------------------+ Start of DDR
+      512KiB   |   ATF reserved memory space   | CONFIG_K3_ATF_LOAD_ADDR
+    0x80080000 +-------------------------------+
+     31.5MiB   |            Unused             |
+    0x82000000 +-------------------------------+ PRELOADED_BL33_BASE in ATF
+               |                               | CONFIG_SYS_LOAD_ADDR
+       57MiB   |   Kernel + initramfs Image    | CONFIG_SPL_LOAD_FIT_ADDRESS
+               |                               |
+    0x85900000 +-------------------------------+
+               |                               |
+               |  R5 U-Boot SPL Stack + Heap   |
+       39MiB   |       (size defined by        |
+               | SPL_STACK_R_MALLOC_SIMPLE_LEN)|
+               |                               |
+    0x88000000 +-------------------------------+ CONFIG_SPL_STACK_R_ADDR
+               |                               | K3_HW_CONFIG_BASE in ATF
+       16MiB   |          Kernel DTB           | CONFIG_SPL_PAYLOAD_ARGS_ADDR
+               |                               |
+    0x89000000 +-------------------------------+
+      331MiB   | Device Manager (DM) Load Addr |
+    0x9db00000 +-------------------------------+
+       12MiB   |          DM Reserved          |
+    0x9e700000 +-------------------------------+
+        1MiB   |            Unused             |
+    0x9e800000 +-------------------------------+ BL32_BASE in ATF
+       24MiB   |             OPTEE             |
+    0xa0000000 +-------------------------------+ End of DDR (512MiB)
+
+.. am62x_evm_falcon_mode_end
+
 Debugging U-Boot
 ----------------
 
diff --git a/doc/board/ti/img/fitImage_falcon.svg b/doc/board/ti/img/fitImage_falcon.svg
new file mode 100644
index 0000000000000000000000000000000000000000..a22e0f6564eb527814c655ec6dd5c822c05edc38
GIT binary patch
literal 5511
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
Ms+^nurCpr-4WjVe&Hw-a

literal 0
HcmV?d00001

diff --git a/doc/board/ti/img/tifsstub_dm_tispl_falcon.bin.svg b/doc/board/ti/img/tifsstub_dm_tispl_falcon.bin.svg
new file mode 100644
index 0000000000000000000000000000000000000000..7e2793c2ed9ae855a07ed493d35df8af9a736d2e
GIT binary patch
literal 9466
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
K0DfD;UBG`Rm_1wo

literal 0
HcmV?d00001

-- 
2.49.0

