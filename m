Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3988C46CD3
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 08:32:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F29787AF9;
	Fri, 29 Dec 2023 09:32:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C4E387732; Fri, 29 Dec 2023 09:32:48 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35ED487ADE
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 09:32:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=randolph@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3BT8WbN6082363;
 Fri, 29 Dec 2023 16:32:37 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Fri, 29 Dec 2023
 16:32:34 +0800
From: Randolph <randolph@andestech.com>
To: <u-boot@lists.denx.de>
CC: <randolph.sklin@gmail.com>, <dylan@andestech.com>, <tim609@andestech.com>, 
 Randolph <randolph@andestech.com>
Subject: [PATCH V4 1/3] doc: falcon: riscv: Falcon Mode boot on RISC-V
Date: Fri, 29 Dec 2023 16:32:21 +0800
Message-ID: <20231229083223.3867307-2-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229083223.3867307-1-randolph@andestech.com>
References: <20231229083223.3867307-1-randolph@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.173]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3BT8WbN6082363
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

Add documentation to introduce the Falcon Mode on RISC-V.
In this mode, the boot sequence is SPL -> OpenSBI -> Linux kernel.

Signed-off-by: Randolph <randolph@andestech.com>
---
 doc/develop/falcon.rst | 158 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/doc/develop/falcon.rst b/doc/develop/falcon.rst
index 8a46c0efa1..244b4ccb5c 100644
--- a/doc/develop/falcon.rst
+++ b/doc/develop/falcon.rst
@@ -256,3 +256,161 @@ the following command:
 Falcon Mode was presented at the RMLL 2012. Slides are available at:
 
 http://schedule2012.rmll.info/IMG/pdf/LSM2012_UbootFalconMode_Babic.pdf
+
+Falcon Mode Boot on RISC-V
+--------------------------
+
+Introduction
+~~~~~~~~~~~~
+
+In the RISC-V environment, OpenSBI is required to enable a supervisor mode
+binary to execute certain privileged operations. The typical boot sequence on
+RISC-V is SPL -> OpenSBI -> U-Boot -> Linux kernel. SPL will load and start
+the OpenSBI initializations, then OpenSBI will bring up the next image, U-Boot
+proper. The OpenSBI binary must be prepared in advance of the U-Boot build
+process and it will be packed together with U-Boot into a file called
+u-boot.itb.
+
+The Falcon Mode on RISC-V platforms is a distinct boot sequence. Borrowing
+ideas from the U-Boot Falcon Mode on ARM, it skips the U-Boot proper phase
+in the normal boot process and allows OpenSBI to load and start the Linux
+kernel. Its boot sequence is SPL -> OpenSBI -> Linux kernel. The OpenSBI
+binary and Linux kernel binary must be prepared prior to the U-Boot build
+process and they will be packed together as a FIT image named linux.itb in
+this process.
+
+CONFIG_SPL_LOAD_FIT_OPENSBI_OS_BOOT enables the Falcon Mode boot on RISC-V.
+This configuration setting tells OpenSBI that Linux kernel is its next OS
+image and makes it load and start the kernel afterwards.
+
+Note that the Falcon Mode boot bypasses a lot of initializations by U-Boot.
+If the Linux kernel expects hardware initializations by U-Boot, make sure to
+port the relevant code to the SPL build process.
+
+Configuration
+~~~~~~~~~~~~~
+
+CONFIG_SPL_LOAD_FIT_ADDRESS
+    Specifies the address to load u-boot.itb in a normal boot. When the Falcon
+    Mode boot is enabled, it specifies the load address of linux.itb.
+
+CONFIG_SYS_TEXT_BASE
+    Specifies the address of the text section for a u-boot proper in a normal
+    boot. When the Falcon Mode boot is enabled, it specifies the text section
+    address for the Linux kernel image.
+
+CONFIG_SPL_PAYLOAD_ARGS_ADDR
+    The address in the RAM to which the FDT blob is to be moved by the SPL.
+    SPL places the FDT blob right after the kernel. As the kernel does not
+    include the BSS section in its size calculation, SPL ends up placing
+    the FDT blob within the BSS section of the kernel. This may cause the
+    FDT blob to be cleared during kernel BSS initialization. To avoid the
+    issue, be sure to move the FDT blob out of the kernel first.
+
+CONFIG_SPL_LOAD_FIT_OPENSBI_OS_BOOT
+    Activates the Falcon Mode boot on RISC-V.
+
+Example for Andes AE350 Board
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+A FDT blob is required to boot the Linux kernel from the SPL. Andes AE350
+platforms generally come with a builtin dtb. To load a custom DTB, follow
+these steps:
+
+1. Load the custom DTB to SDRAM::
+
+        => fatload mmc 0:1 0x20000000 user_custom.dtb
+
+2. Set the SPI speed::
+
+        => sf probe 0:0 50000000 0
+
+3. Erase sectors from the SPI Flash::
+
+        => sf erase 0xf0000 0x10000
+
+4. Write the FDT blob to the erased sectors of the Flash::
+
+        => sf write 0x20000000 0xf0000 0x10000
+
+Console Log of AE350 Falcon Mode Boot
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+::
+
+        U-Boot SPL 2023.01-00031-g777ecdea66 (Oct 31 2023 - 18:41:36 +0800)
+        Trying to boot from RAM
+
+        OpenSBI v1.2-51-g7304e42
+           ____                    _____ ____ _____
+          / __ \                  / ____|  _ \_   _|
+         | |  | |_ __   ___ _ __ | (___ | |_) || |
+         | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
+         | |__| | |_) |  __/ | | |____) | |_) || |_
+          \____/| .__/ \___|_| |_|_____/|____/_____|
+                | |
+                |_|
+
+        Platform Name             : andestech,ax25
+        Platform Features         : medeleg
+        Platform HART Count       : 1
+        Platform IPI Device       : andes_plicsw
+        Platform Timer Device     : andes_plmt @ 60000000Hz
+        Platform Console Device   : uart8250
+        Platform HSM Device       : andes_smu
+        Platform PMU Device       : andes_pmu
+        Platform Reboot Device    : atcwdt200
+        Platform Shutdown Device  : ---
+        Firmware Base             : 0x0
+        Firmware Size             : 196 KB
+        Runtime SBI Version       : 1.0
+
+        Domain0 Name              : root
+        Domain0 Boot HART         : 0
+        Domain0 HARTs             : 0*
+        Domain0 Region00          : 0x0000000000000000-0x000000000003ffff ()
+        Domain0 Region01          : 0x00000000e6000000-0x00000000e60fffff (I,R)
+        Domain0 Region02          : 0x00000000e6400000-0x00000000e67fffff (I)
+        Domain0 Region03          : 0x0000000000000000-0xffffffffffffffff (R,W,X)
+        Domain0 Next Address      : 0x0000000001800000
+        Domain0 Next Arg1         : 0x0000000001700000
+        Domain0 Next Mode         : S-mode
+        Domain0 SysReset          : yes
+
+        Boot HART ID              : 0
+        Boot HART Domain          : root
+        Boot HART Priv Version    : v1.11
+        Boot HART Base ISA        : rv64imafdcx
+        Boot HART ISA Extensions  : none
+        Boot HART PMP Count       : 8
+        Boot HART PMP Granularity : 4
+        Boot HART PMP Address Bits: 31
+        Boot HART MHPM Count      : 4
+        Boot HART MHPM Bits       : 64
+        Boot HART MIDELEG         : 0x0000000000000222
+        Boot HART MEDELEG         : 0x000000000000b109
+        [    0.000000] Linux version 6.1.47-09019-g0584b09ad862-dirty
+        [    0.000000] OF: fdt: Ignoring memory range 0x0 - 0x1800000
+        [    0.000000] Machine model: andestech,ax25
+        [    0.000000] earlycon: sbi0 at I/O port 0x0 (options '')
+        [    0.000000] printk: bootconsole [sbi0] enabled
+        [    0.000000] Disabled 4-level and 5-level paging
+        [    0.000000] efi: UEFI not found.
+        [    0.000000] Zone ranges:
+        [    0.000000]   DMA32    [mem 0x0000000001800000-0x000000003fffffff]
+        [    0.000000]   Normal   empty
+        [    0.000000] Movable zone start for each node
+        [    0.000000] Early memory node ranges
+        [    0.000000]   node   0: [mem 0x0000000001800000-0x000000003fffffff]
+        [    0.000000] Initmem setup node 0 [mem 0x0000000001800000-0x000000003fffffff]
+        [    0.000000] SBI specification v1.0 detected
+        [    0.000000] SBI implementation ID=0x1 Version=0x10002
+        [    0.000000] SBI TIME extension detected
+        [    0.000000] SBI IPI extension detected
+        [    0.000000] SBI RFENCE extension detected
+        [    0.000000] SBI SRST extension detected
+        [    0.000000] SBI HSM extension detected
+        [    0.000000] riscv: base ISA extensions acim
+        [    0.000000] riscv: ELF capabilities acim
+        [    0.000000] percpu: Embedded 18 pages/cpu s35000 r8192 d30536 u73728
+        [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 252500
-- 
2.34.1

