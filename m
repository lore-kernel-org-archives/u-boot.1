Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587B1C46CA1
	for <u-boot@archiver.kernel.org>; Mon, 18 Sep 2023 12:13:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBA028082A;
	Mon, 18 Sep 2023 14:12:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A867786958; Mon, 18 Sep 2023 14:12:50 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 658BC8082A
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 14:12:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=randolph@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 38ICCfR5050594;
 Mon, 18 Sep 2023 20:12:41 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Mon, 18 Sep 2023 20:12:37 +0800
From: Randolph <randolph@andestech.com>
To: <u-boot@lists.denx.de>
CC: <randolph.sklin@gmail.com>, <dylan@andestech.com>, <tim609@andestech.com>, 
 Randolph <randolph@andestech.com>
Subject: [PATCH V2 3/3] dts: andes: add SPL config option for itb layout
Date: Mon, 18 Sep 2023 20:11:36 +0800
Message-ID: <20230918121136.2295900-4-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918121136.2295900-1-randolph@andestech.com>
References: <20230918121136.2295900-1-randolph@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 38ICCfR5050594
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

Add SPL_LOAD_FIT_CONFIG for binman itb layout selection

Signed-off-by: Randolph <randolph@andestech.com>
---
 arch/riscv/dts/ae350-u-boot.dtsi     | 1 +
 arch/riscv/dts/ae350_32.dts          | 1 -
 arch/riscv/dts/ae350_64.dts          | 1 -
 board/AndesTech/ae350/Kconfig        | 6 ++++++
 configs/ae350_rv32_defconfig         | 1 +
 configs/ae350_rv32_spl_defconfig     | 1 +
 configs/ae350_rv32_spl_xip_defconfig | 1 +
 configs/ae350_rv32_xip_defconfig     | 1 +
 configs/ae350_rv64_defconfig         | 1 +
 configs/ae350_rv64_spl_defconfig     | 1 +
 configs/ae350_rv64_spl_xip_defconfig | 1 +
 configs/ae350_rv64_xip_defconfig     | 1 +
 12 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/dts/ae350-u-boot.dtsi b/arch/riscv/dts/ae350-u-boot.dtsi
index aef9159b7a..ff5725501f 100644
--- a/arch/riscv/dts/ae350-u-boot.dtsi
+++ b/arch/riscv/dts/ae350-u-boot.dtsi
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MIT)
+#include CONFIG_SPL_LOAD_FIT_CONFIG
 
 / {
 	cpus {
diff --git a/arch/riscv/dts/ae350_32.dts b/arch/riscv/dts/ae350_32.dts
index 61af6d5465..2caabad888 100644
--- a/arch/riscv/dts/ae350_32.dts
+++ b/arch/riscv/dts/ae350_32.dts
@@ -2,7 +2,6 @@
 
 /dts-v1/;
 
-#include "binman.dtsi"
 #include "ae350-u-boot.dtsi"
 
 / {
diff --git a/arch/riscv/dts/ae350_64.dts b/arch/riscv/dts/ae350_64.dts
index 8c7db29b4f..9d5f6c743c 100644
--- a/arch/riscv/dts/ae350_64.dts
+++ b/arch/riscv/dts/ae350_64.dts
@@ -2,7 +2,6 @@
 
 /dts-v1/;
 
-#include "binman.dtsi"
 #include "ae350-u-boot.dtsi"
 
 / {
diff --git a/board/AndesTech/ae350/Kconfig b/board/AndesTech/ae350/Kconfig
index a85e7d6351..49a2f8ec23 100644
--- a/board/AndesTech/ae350/Kconfig
+++ b/board/AndesTech/ae350/Kconfig
@@ -41,4 +41,10 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply SPL_RAM_DEVICE
 	imply OF_HAS_PRIOR_STAGE
 
+config SPL_LOAD_FIT_CONFIG
+	string "Default FIT configuration for SPL"
+	depends on SPL_LOAD_FIT
+	help
+	  Specify corresponding FIT configuration for SPL modes.
+
 endif
diff --git a/configs/ae350_rv32_defconfig b/configs/ae350_rv32_defconfig
index 2fbb87a9b3..eea919249d 100644
--- a/configs/ae350_rv32_defconfig
+++ b/configs/ae350_rv32_defconfig
@@ -10,6 +10,7 @@ CONFIG_SYS_PROMPT="RISC-V # "
 CONFIG_SYS_MONITOR_LEN=786432
 CONFIG_SYS_LOAD_ADDR=0x100000
 CONFIG_TARGET_ANDES_AE350=y
+CONFIG_SPL_LOAD_FIT_CONFIG="binman.dtsi"
 CONFIG_FIT=y
 CONFIG_SYS_MONITOR_BASE=0x88000000
 CONFIG_DISTRO_DEFAULTS=y
diff --git a/configs/ae350_rv32_spl_defconfig b/configs/ae350_rv32_spl_defconfig
index b28a0a84fb..0d100bdbb1 100644
--- a/configs/ae350_rv32_spl_defconfig
+++ b/configs/ae350_rv32_spl_defconfig
@@ -13,6 +13,7 @@ CONFIG_SPL=y
 CONFIG_SYS_LOAD_ADDR=0x100000
 CONFIG_TARGET_ANDES_AE350=y
 CONFIG_RISCV_SMODE=y
+CONFIG_SPL_LOAD_FIT_CONFIG="binman.dtsi"
 # CONFIG_AVAILABLE_HARTS is not set
 CONFIG_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x10000000
diff --git a/configs/ae350_rv32_spl_xip_defconfig b/configs/ae350_rv32_spl_xip_defconfig
index 5e8f1b3631..0284d18e58 100644
--- a/configs/ae350_rv32_spl_xip_defconfig
+++ b/configs/ae350_rv32_spl_xip_defconfig
@@ -14,6 +14,7 @@ CONFIG_SPL=y
 CONFIG_SYS_LOAD_ADDR=0x100000
 CONFIG_TARGET_ANDES_AE350=y
 CONFIG_RISCV_SMODE=y
+CONFIG_SPL_LOAD_FIT_CONFIG="binman.dtsi"
 CONFIG_SPL_XIP=y
 CONFIG_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x80010000
diff --git a/configs/ae350_rv32_xip_defconfig b/configs/ae350_rv32_xip_defconfig
index f1c1e5bc00..1b01b881ed 100644
--- a/configs/ae350_rv32_xip_defconfig
+++ b/configs/ae350_rv32_xip_defconfig
@@ -10,6 +10,7 @@ CONFIG_SYS_PROMPT="RISC-V # "
 CONFIG_SYS_MONITOR_LEN=786432
 CONFIG_SYS_LOAD_ADDR=0x100000
 CONFIG_TARGET_ANDES_AE350=y
+CONFIG_SPL_LOAD_FIT_CONFIG="binman.dtsi"
 CONFIG_XIP=y
 CONFIG_FIT=y
 CONFIG_SYS_MONITOR_BASE=0x88000000
diff --git a/configs/ae350_rv64_defconfig b/configs/ae350_rv64_defconfig
index 3f30842a8e..cd13fc58a5 100644
--- a/configs/ae350_rv64_defconfig
+++ b/configs/ae350_rv64_defconfig
@@ -9,6 +9,7 @@ CONFIG_DEFAULT_DEVICE_TREE="ae350_64"
 CONFIG_SYS_PROMPT="RISC-V # "
 CONFIG_SYS_LOAD_ADDR=0x100000
 CONFIG_TARGET_ANDES_AE350=y
+CONFIG_SPL_LOAD_FIT_CONFIG="binman.dtsi"
 CONFIG_ARCH_RV64I=y
 CONFIG_FIT=y
 CONFIG_SYS_MONITOR_BASE=0x88000000
diff --git a/configs/ae350_rv64_spl_defconfig b/configs/ae350_rv64_spl_defconfig
index 1592ec811a..2d32aea041 100644
--- a/configs/ae350_rv64_spl_defconfig
+++ b/configs/ae350_rv64_spl_defconfig
@@ -13,6 +13,7 @@ CONFIG_SYS_LOAD_ADDR=0x100000
 CONFIG_TARGET_ANDES_AE350=y
 CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
+CONFIG_SPL_LOAD_FIT_CONFIG="binman.dtsi"
 # CONFIG_AVAILABLE_HARTS is not set
 CONFIG_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x10000000
diff --git a/configs/ae350_rv64_spl_xip_defconfig b/configs/ae350_rv64_spl_xip_defconfig
index 97f961b6c9..f2fea9d28e 100644
--- a/configs/ae350_rv64_spl_xip_defconfig
+++ b/configs/ae350_rv64_spl_xip_defconfig
@@ -14,6 +14,7 @@ CONFIG_SYS_LOAD_ADDR=0x100000
 CONFIG_TARGET_ANDES_AE350=y
 CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
+CONFIG_SPL_LOAD_FIT_CONFIG="binman.dtsi"
 CONFIG_SPL_XIP=y
 CONFIG_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x80010000
diff --git a/configs/ae350_rv64_xip_defconfig b/configs/ae350_rv64_xip_defconfig
index cabbf75f84..88c3869f75 100644
--- a/configs/ae350_rv64_xip_defconfig
+++ b/configs/ae350_rv64_xip_defconfig
@@ -9,6 +9,7 @@ CONFIG_DEFAULT_DEVICE_TREE="ae350_64"
 CONFIG_SYS_PROMPT="RISC-V # "
 CONFIG_SYS_LOAD_ADDR=0x100000
 CONFIG_TARGET_ANDES_AE350=y
+CONFIG_SPL_LOAD_FIT_CONFIG="binman.dtsi"
 CONFIG_ARCH_RV64I=y
 CONFIG_XIP=y
 CONFIG_FIT=y
-- 
2.34.1

