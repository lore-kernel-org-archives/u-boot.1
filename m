Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD60CCD1A5
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 08:14:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61FCF83631;
	Fri, 24 Oct 2025 10:14:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="j/pDlrWd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4933E8363D; Fri, 24 Oct 2025 10:14:23 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97AA483631
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 10:14:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59O8EJHU1864692;
 Fri, 24 Oct 2025 03:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761293659;
 bh=gKV3SRfUzN7SeIQatqXcBImL6Um2zlARTH4l12I5c58=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=j/pDlrWdoTrlxOlXn9flcvWZP+Q488+UEvkO5nr2Bd35rUBHnaGuN4R6V0nMt9Jrv
 +Uf7rpyXzvAHRVt5jLtgna0lRSNYuPrGDfIWyqQY+QN+kNUx2tSHcpIgrHcnpyUyqx
 AGi/rUfysv8R7PZoZ2qUep+etzZcszyhXlZjq7y0=
Received: from DLEE212.ent.ti.com (dlee212.ent.ti.com [157.170.170.114])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59O8EJvW3028606
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 24 Oct 2025 03:14:19 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Oct
 2025 03:14:18 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Oct 2025 03:14:18 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59O8EHv5035165;
 Fri, 24 Oct 2025 03:14:18 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>
Subject: [PATCH v3 4/4] doc: develop: add docs for secure falcon mode
Date: Fri, 24 Oct 2025 13:44:07 +0530
Message-ID: <20251024081408.1610102-5-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024081408.1610102-1-anshuld@ti.com>
References: <20251024081408.1610102-1-anshuld@ti.com>
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

This patch documents the newly added SPL_OS_BOOT_SECURE option that
enables authenticated boot in falcon mode.

The document provides steps for using secure falcon mode on ARM64 taking
TI's AM62x EVM as an example.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 doc/develop/falcon.rst | 252 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 252 insertions(+)

diff --git a/doc/develop/falcon.rst b/doc/develop/falcon.rst
index 5689d5b93a7..528a9c389bf 100644
--- a/doc/develop/falcon.rst
+++ b/doc/develop/falcon.rst
@@ -82,6 +82,14 @@ CONFIG_CMD_SPL_WRITE_SIZE
 CONFIG_SPL_OS_BOOT
     Activate Falcon Mode.
 
+CONFIG_SPL_OS_BOOT_ARGS
+    Allow SPL to load args file for the kernel in Falcon Mode. This option can
+    be disabled if the device-tree is packaged directly in the FIT payload.
+
+CONFIG_SPL_OS_BOOT_SECURE
+    Enable secure boot for Falcon Mode, which provides an additional layer of
+    security by authenticating the boot process using a signed FIT image.
+
 Function that a board must implement
 ------------------------------------
 
@@ -187,6 +195,250 @@ Falcon Mode was presented at the RMLL 2012. Slides are available at:
 
 http://schedule2012.rmll.info/IMG/pdf/LSM2012_UbootFalconMode_Babic.pdf
 
+Secure Falcon Mode
+------------------
+
+Introduction
+~~~~~~~~~~~~
+
+Secure Falcon Mode is an enhancement to Falcon Mode that provides additional
+security features. It authenticates the boot process using a signed FIT Image
+and restricts certain features that are inherently insecure.
+
+Configuration
+~~~~~~~~~~~~~
+
+To enable Secure Falcon Mode, the ``CONFIG_SPL_OS_BOOT_SECURE`` option must be
+set. This option modifies the behavior of Falcon Mode in the following ways:
+
+1. Fallback Mechanism:
+^^^^^^^^^^^^^^^^^^^^^^
+
+Unlike regular Falcon Mode, which falls back to the standard U-Boot boot flow
+if kernel booting fails, Secure Falcon Mode disables this fallback mechanism. If
+the secure boot process fails, the boot process will not proceed.
+
+2. Signed FIT Image:
+^^^^^^^^^^^^^^^^^^^^
+
+Secure Falcon Mode requires a signed FIT, which contains the kernel and
+device tree, to boot the system. The ``falcon_args_file`` environment variable
+is ignored, and instead, the device tree is read from the signed FIT. This
+ensures the authenticity and integrity of the boot process.
+
+Example
+~~~~~~~
+
+Secure falcon mode can be enabled on TI AM62x EVM as follows with SD boot mode:
+
+1. Prepare the device-tree:
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+To optimize performance, the SPL in Falcon Mode expects the FIT to contain a
+device-tree with fixups already applied. Such a device-tree can be generated
+using the spl export command as follows:
+
+**Setting bootargs**
+
+Set the bootargs environment variable to the desired value:
+
+.. prompt:: bash =>
+
+        env set bootargs 'console=ttyS2,115200n8 root=/dev/mmcblk1p2 rw rootfstype=ext4 rootwait'
+
+**Read FIT from SD**
+
+Load the FIT image from the SD card:
+
+.. prompt:: bash =>
+
+        load mmc 1:2 0x90000000 /boot/fitImage
+
+**Generate device-tree**
+
+Use the ``spl export`` command to generate a device-tree with fixups applied:
+
+.. prompt:: bash =>
+
+        spl export fdt 0x90000000
+
+**Save the device-tree**
+
+Write the generated device-tree to the SD card:
+
+.. prompt:: bash =>
+
+        fatwrite mmc 1:1 $fdtargsaddr k3-am625-sk-falcon.dtb $fdtargslen
+
+2. Create the FIT Image:
+^^^^^^^^^^^^^^^^^^^^^^^^
+
+Create a new FIT image that includes the fixed device-tree generated in the
+previous step. You will also need to add a signature node to the SPL's DTB
+containing the keys to authenticate the new FIT.
+
+Create a ``fitImage.its`` file with the following contents:
+
+.. code-block:: dts
+
+    /dts-v1/;
+
+    / {
+        description = "Kernel fitImage";
+        #address-cells = <1>;
+
+        images {
+            kernel {
+                description = "Linux kernel";
+                data = /incbin/("Image");
+                type = "kernel";
+                arch = "arm64";
+                os = "linux";
+                compression = "none";
+                load = <0x82000000>;
+                entry = <0x82000000>;
+                hash-1 {
+                    algo = "sha512";
+                };
+            };
+
+            fdt-falcon {
+                description = "Flattened Device Tree blob";
+                data = /incbin/("k3-am625-sk-falcon.dtb");
+                type = "flat_dt";
+                arch = "arm64";
+                compression = "none";
+                load = <0x88000000>;
+                entry = <0x88000000>;
+                hash-1 {
+                    algo = "sha512";
+                };
+            };
+        };
+
+        configurations {
+            default = "conf-ti_am625";
+
+            conf-ti_am625 {
+                description = "Linux kernel, FDT blob";
+                kernel = "kernel";
+                fdt = "fdt-falcon";
+                hash-1 {
+                    algo = "sha512";
+                };
+
+                signature-1 {
+                    algo = "sha512,rsa4096";
+                    key-name-hint = "custMpk";
+                    padding = "pkcs-1.5";
+                    sign-images = "kernel", "fdt-falcon";
+                };
+            };
+        };
+    };
+
+Then, use the mkimage tool to create the FIT image and modify SPL's DTB:
+
+.. prompt:: bash $
+
+        tools/mkimage -f fitImage.its -K build/spl/dts/ti/k3-am625-sk.dtb -k arch/arm/mach-k3/keys -r fitImage
+
+3. Rebuild U-Boot SPL:
+^^^^^^^^^^^^^^^^^^^^^^
+
+With the newly created ``fitImage`` written to the boot partition of the SD card
+and the keys added to the SPL's device-tree, you can rebuild the SPL with the
+following configuration fragment to enable Falcon Mode:
+
+::
+
+        CONFIG_SPL_OS_BOOT=y
+        CONFIG_SPL_OS_BOOT_SECURE=y
+        CONFIG_SPL_FIT_SIGNATURE=y
+        CONFIG_SPL_RSA=y
+
+        # Only support MMC falcon mode
+        CONFIG_SPL_SPI_FLASH_SUPPORT=n
+        CONFIG_SPL_NOR_SUPPORT=n
+        CONFIG_SPL_NAND_SUPPORT=n
+
+        # We don't need TIFS authenticating the FIT
+        CONFIG_SPL_FIT_IMAGE_POST_PROCESS=n
+
+        # Modify memory map to allow more space for the larger FIT
+        CONFIG_SPL_STACK_R_ADDR=0x88000000
+        CONFIG_SPL_LOAD_FIT_ADDRESS=0x82000000
+        CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x4000000
+
+Console Log
+~~~~~~~~~~~
+
+The following console log output shows the boot process with Secure Falcon Mode
+enabled:
+
+::
+
+        U-Boot SPL 2025.10-rc5-00482-ge14055bfa9d1-dirty (Oct 09 2025 - 14:31:50 +0530)
+        SYSFW ABI: 4.0 (firmware rev 0x000b '11.0.7--v11.00.07 (Fancy Rat)')
+        SPL initial stack usage: 1968 bytes
+        Trying to boot from MMC2
+        ## Checking hash(es) for config conf-ti_am625 ... sha512,rsa4096:custMpk+ OK
+        ## Checking hash(es) for Image kernel ... sha512+ OK
+        ## Checking hash(es) for Image fdt-falcon ... sha512+ OK
+        [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
+        [    0.000000] Linux version 6.6.58-ti-01497-ga7758da17c28-dirty (oe-user@oe-host) (aarch64-oe-linux-gcc (GCC) 14.2.0, GNU ld (GNU Binutils) 2.43.1
+        .20241111) #1 SMP PREEMPT Wed Nov 27 13:23:15 UTC 2024
+        [    0.000000] KASLR enabled
+        [    0.000000] Machine model: Texas Instruments AM625 SK
+        [    0.000000] efi: UEFI not found.
+        [    0.000000] Reserved memory: created CMA memory pool at 0x00000000f8000000, size 128 MiB
+        [    0.000000] OF: reserved mem: initialized node linux,cma, compatible id shared-dma-pool
+        [    0.000000] OF: reserved mem: 0x00000000f8000000..0x00000000ffffffff (131072 KiB) map reusable linux,cma
+        [    0.000000] OF: reserved mem: 0x0000000080000000..0x000000008007ffff (512 KiB) nomap non-reusable tfa@80000000
+        [    0.000000] OF: reserved mem: 0x000000009c700000..0x000000009c7fffff (1024 KiB) map non-reusable ramoops@9c700000
+        [    0.000000] Reserved memory: created DMA memory pool at 0x000000009c800000, size 3 MiB
+        [    0.000000] OF: reserved mem: initialized node ipc-memories@9c800000, compatible id shared-dma-pool
+        [    0.000000] OF: reserved mem: 0x000000009c800000..0x000000009cafffff (3072 KiB) nomap non-reusable ipc-memories@9c800000
+        [    0.000000] Reserved memory: created DMA memory pool at 0x000000009cb00000, size 1 MiB
+        [    0.000000] OF: reserved mem: initialized node m4f-dma-memory@9cb00000, compatible id shared-dma-pool
+        [    0.000000] OF: reserved mem: 0x000000009cb00000..0x000000009cbfffff (1024 KiB) nomap non-reusable m4f-dma-memory@9cb00000
+        [    0.000000] Reserved memory: created DMA memory pool at 0x000000009cc00000, size 14 MiB
+        [    0.000000] OF: reserved mem: initialized node m4f-memory@9cc00000, compatible id shared-dma-pool
+        [    0.000000] OF: reserved mem: 0x000000009cc00000..0x000000009d9fffff (14336 KiB) nomap non-reusable m4f-memory@9cc00000
+        [    0.000000] Reserved memory: created DMA memory pool at 0x000000009da00000, size 1 MiB
+        [    0.000000] OF: reserved mem: initialized node r5f-dma-memory@9da00000, compatible id shared-dma-pool
+        [    0.000000] OF: reserved mem: 0x000000009da00000..0x000000009dafffff (1024 KiB) nomap non-reusable r5f-dma-memory@9da00000
+        [    0.000000] Reserved memory: created DMA memory pool at 0x000000009db00000, size 12 MiB
+        [    0.000000] OF: reserved mem: initialized node r5f-memory@9db00000, compatible id shared-dma-pool
+        [    0.000000] OF: reserved mem: 0x000000009db00000..0x000000009e6fffff (12288 KiB) nomap non-reusable r5f-memory@9db00000
+        [    0.000000] OF: reserved mem: 0x000000009e800000..0x000000009fffffff (24576 KiB) nomap non-reusable optee@9e800000
+        [    0.000000] Zone ranges:
+        [    0.000000]   DMA      [mem 0x0000000080000000-0x00000000ffffffff]
+        [    0.000000]   DMA32    empty
+        [    0.000000]   Normal   empty
+        [    0.000000] Movable zone start for each node
+        [    0.000000] Early memory node ranges
+        [    0.000000]   node   0: [mem 0x0000000080000000-0x000000008007ffff]
+        [    0.000000]   node   0: [mem 0x0000000080080000-0x000000009c7fffff]
+        [    0.000000]   node   0: [mem 0x000000009c800000-0x000000009e6fffff]
+        [    0.000000]   node   0: [mem 0x000000009e700000-0x000000009e7fffff]
+        [    0.000000]   node   0: [mem 0x000000009e800000-0x000000009fffffff]
+        [    0.000000]   node   0: [mem 0x00000000a0000000-0x00000000ffffffff]
+        [    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x00000000ffffffff]
+        [    0.000000] psci: probing for conduit method from DT.
+        [    0.000000] psci: PSCIv1.1 detected in firmware.
+        [    0.000000] psci: Using standard PSCI v0.2 function IDs
+        [    0.000000] psci: Trusted OS migration not required
+        [    0.000000] psci: SMC Calling Convention v1.5
+        [    0.000000] percpu: Embedded 20 pages/cpu s43176 r8192 d30552 u81920
+        [    0.000000] Detected VIPT I-cache on CPU0
+        [    0.000000] CPU features: detected: GIC system register CPU interface
+        [    0.000000] CPU features: kernel page table isolation forced ON by KASLR
+        [    0.000000] CPU features: detected: Kernel page table isolation (KPTI)
+        [    0.000000] CPU features: detected: ARM erratum 845719
+        [    0.000000] alternatives: applying boot alternatives
+        [    0.000000] Kernel command line: console=ttyS2,115200n8 root=/dev/mmcblk1p2 rw rootfstype=ext4 rootwait
+
 Falcon Mode Boot on RISC-V
 --------------------------
 
-- 
2.51.0

