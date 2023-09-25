Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44ED9CE7A81
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 09:26:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9000B86C16;
	Mon, 25 Sep 2023 11:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 128E886BF7; Mon, 25 Sep 2023 11:26:29 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEB6686BE7
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 11:26:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=randolph@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 38P9QGLf060890;
 Mon, 25 Sep 2023 17:26:16 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Mon, 25 Sep 2023 17:26:13 +0800
From: Randolph <randolph@andestech.com>
To: <u-boot@lists.denx.de>
CC: <randolph.sklin@gmail.com>, <dylan@andestech.com>, <tim609@andestech.com>, 
 Randolph <randolph@andestech.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH V3 1/2] configs: andes: add vender prefix for target name
Date: Mon, 25 Sep 2023 17:24:51 +0800
Message-ID: <20230925092452.1402614-2-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925092452.1402614-1-randolph@andestech.com>
References: <20230925092452.1402614-1-randolph@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 38P9QGLf060890
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

Modify "CONFIG_TARGET_AE350" to "CONFIG_TARGET_ANDES_AE350"

Signed-off-by: Randolph <randolph@andestech.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
 arch/riscv/Kconfig                   | 4 ++--
 arch/riscv/dts/Makefile              | 2 +-
 board/AndesTech/ae350/Kconfig        | 2 +-
 configs/ae350_rv32_defconfig         | 2 +-
 configs/ae350_rv32_spl_defconfig     | 2 +-
 configs/ae350_rv32_spl_xip_defconfig | 2 +-
 configs/ae350_rv32_xip_defconfig     | 2 +-
 configs/ae350_rv64_defconfig         | 2 +-
 configs/ae350_rv64_spl_defconfig     | 2 +-
 configs/ae350_rv64_spl_xip_defconfig | 2 +-
 configs/ae350_rv64_xip_defconfig     | 2 +-
 11 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6771d8d919..aff1f33665 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -8,8 +8,8 @@ choice
 	prompt "Target select"
 	optional
 
-config TARGET_AE350
-	bool "Support ae350"
+config TARGET_ANDES_AE350
+	bool "Support Andes ae350"
 
 config TARGET_MICROCHIP_ICICLE
 	bool "Support Microchip PolarFire-SoC Icicle Board"
diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index f1525cb668..be6c8a4227 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-dtb-$(CONFIG_TARGET_AE350) += ae350_32.dtb ae350_64.dtb
+dtb-$(CONFIG_TARGET_ANDES_AE350) += ae350_32.dtb ae350_64.dtb
 dtb-$(CONFIG_TARGET_MICROCHIP_ICICLE) += mpfs-icicle-kit.dtb
 dtb-$(CONFIG_TARGET_QEMU_VIRT) += qemu-virt32.dtb qemu-virt64.dtb
 dtb-$(CONFIG_TARGET_OPENPITON_RISCV64) += openpiton-riscv64.dtb
diff --git a/board/AndesTech/ae350/Kconfig b/board/AndesTech/ae350/Kconfig
index 75815bf99a..a85e7d6351 100644
--- a/board/AndesTech/ae350/Kconfig
+++ b/board/AndesTech/ae350/Kconfig
@@ -1,4 +1,4 @@
-if TARGET_AE350
+if TARGET_ANDES_AE350
 
 config SYS_CPU
 	default "andesv5"
diff --git a/configs/ae350_rv32_defconfig b/configs/ae350_rv32_defconfig
index 06a683d986..2fbb87a9b3 100644
--- a/configs/ae350_rv32_defconfig
+++ b/configs/ae350_rv32_defconfig
@@ -9,7 +9,7 @@ CONFIG_DEFAULT_DEVICE_TREE="ae350_32"
 CONFIG_SYS_PROMPT="RISC-V # "
 CONFIG_SYS_MONITOR_LEN=786432
 CONFIG_SYS_LOAD_ADDR=0x100000
-CONFIG_TARGET_AE350=y
+CONFIG_TARGET_ANDES_AE350=y
 CONFIG_FIT=y
 CONFIG_SYS_MONITOR_BASE=0x88000000
 CONFIG_DISTRO_DEFAULTS=y
diff --git a/configs/ae350_rv32_spl_defconfig b/configs/ae350_rv32_spl_defconfig
index 75e55ba724..4adc1134ba 100644
--- a/configs/ae350_rv32_spl_defconfig
+++ b/configs/ae350_rv32_spl_defconfig
@@ -11,7 +11,7 @@ CONFIG_SYS_MONITOR_LEN=786432
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x100000
 CONFIG_SPL=y
 CONFIG_SYS_LOAD_ADDR=0x100000
-CONFIG_TARGET_AE350=y
+CONFIG_TARGET_ANDES_AE350=y
 CONFIG_RISCV_SMODE=y
 # CONFIG_AVAILABLE_HARTS is not set
 CONFIG_FIT=y
diff --git a/configs/ae350_rv32_spl_xip_defconfig b/configs/ae350_rv32_spl_xip_defconfig
index c2221b891e..e19eb546a6 100644
--- a/configs/ae350_rv32_spl_xip_defconfig
+++ b/configs/ae350_rv32_spl_xip_defconfig
@@ -12,7 +12,7 @@ CONFIG_SYS_MONITOR_LEN=786432
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x100000
 CONFIG_SPL=y
 CONFIG_SYS_LOAD_ADDR=0x100000
-CONFIG_TARGET_AE350=y
+CONFIG_TARGET_ANDES_AE350=y
 CONFIG_RISCV_SMODE=y
 CONFIG_SPL_XIP=y
 CONFIG_FIT=y
diff --git a/configs/ae350_rv32_xip_defconfig b/configs/ae350_rv32_xip_defconfig
index 6d19400c2d..f1c1e5bc00 100644
--- a/configs/ae350_rv32_xip_defconfig
+++ b/configs/ae350_rv32_xip_defconfig
@@ -9,7 +9,7 @@ CONFIG_DEFAULT_DEVICE_TREE="ae350_32"
 CONFIG_SYS_PROMPT="RISC-V # "
 CONFIG_SYS_MONITOR_LEN=786432
 CONFIG_SYS_LOAD_ADDR=0x100000
-CONFIG_TARGET_AE350=y
+CONFIG_TARGET_ANDES_AE350=y
 CONFIG_XIP=y
 CONFIG_FIT=y
 CONFIG_SYS_MONITOR_BASE=0x88000000
diff --git a/configs/ae350_rv64_defconfig b/configs/ae350_rv64_defconfig
index 0d7f0a552e..3f30842a8e 100644
--- a/configs/ae350_rv64_defconfig
+++ b/configs/ae350_rv64_defconfig
@@ -8,7 +8,7 @@ CONFIG_ENV_SECT_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="ae350_64"
 CONFIG_SYS_PROMPT="RISC-V # "
 CONFIG_SYS_LOAD_ADDR=0x100000
-CONFIG_TARGET_AE350=y
+CONFIG_TARGET_ANDES_AE350=y
 CONFIG_ARCH_RV64I=y
 CONFIG_FIT=y
 CONFIG_SYS_MONITOR_BASE=0x88000000
diff --git a/configs/ae350_rv64_spl_defconfig b/configs/ae350_rv64_spl_defconfig
index 6a72b5a047..629c5bab77 100644
--- a/configs/ae350_rv64_spl_defconfig
+++ b/configs/ae350_rv64_spl_defconfig
@@ -10,7 +10,7 @@ CONFIG_SYS_PROMPT="RISC-V # "
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x100000
 CONFIG_SPL=y
 CONFIG_SYS_LOAD_ADDR=0x100000
-CONFIG_TARGET_AE350=y
+CONFIG_TARGET_ANDES_AE350=y
 CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
 # CONFIG_AVAILABLE_HARTS is not set
diff --git a/configs/ae350_rv64_spl_xip_defconfig b/configs/ae350_rv64_spl_xip_defconfig
index 43581c79b1..4557e05445 100644
--- a/configs/ae350_rv64_spl_xip_defconfig
+++ b/configs/ae350_rv64_spl_xip_defconfig
@@ -11,7 +11,7 @@ CONFIG_SYS_PROMPT="RISC-V # "
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x100000
 CONFIG_SPL=y
 CONFIG_SYS_LOAD_ADDR=0x100000
-CONFIG_TARGET_AE350=y
+CONFIG_TARGET_ANDES_AE350=y
 CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
 CONFIG_SPL_XIP=y
diff --git a/configs/ae350_rv64_xip_defconfig b/configs/ae350_rv64_xip_defconfig
index 02d7694489..cabbf75f84 100644
--- a/configs/ae350_rv64_xip_defconfig
+++ b/configs/ae350_rv64_xip_defconfig
@@ -8,7 +8,7 @@ CONFIG_ENV_SECT_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="ae350_64"
 CONFIG_SYS_PROMPT="RISC-V # "
 CONFIG_SYS_LOAD_ADDR=0x100000
-CONFIG_TARGET_AE350=y
+CONFIG_TARGET_ANDES_AE350=y
 CONFIG_ARCH_RV64I=y
 CONFIG_XIP=y
 CONFIG_FIT=y
-- 
2.34.1

