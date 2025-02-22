Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03327C021B2
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 17:13:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31E3680540;
	Sat, 22 Feb 2025 18:13:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740244424;
	bh=GqfP3RmT2NsRlVlaBXDDS58Z0e3+w4++SEyE/ZLDihA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IE+vhjk5f/19Lwht91Hep4MYkWPU8qMz9yXUt28pm+RiZOTfjkC+ZRoSnW9Km8Ftz
	 JLbCL4ORK3MuXIT0Smv/duOBa/9f5l5B/nj2Uh7zjKQr3rrz4bt/GikAfsCZzG7W92
	 d2Vm9KVIzZVcWUkOrrcbvFN3yC+mZngdDZDOI60UX85inlV7BxfGgdjzf7++WPwpQl
	 fGv6jUAjAme3yys/NUTZfeFCkRty4R9JIssy0qFDdL7m1RNgh2iI5OJdqSbNljSrUX
	 8FiLtgCFubWZsWyDfv4QK1v98t5iEnDvUs2UMw5aQhU9FfZpnKtbZ2lYR6Vvwc+uzP
	 LD+vwzqfq9Cyg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B013B801B0; Sat, 22 Feb 2025 18:13:43 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8769A800B6
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 18:13:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="ZCfXS1lq"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2D41D10382D37; Sat, 22 Feb 2025 18:13:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1740244420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=GqfP3RmT2NsRlVlaBXDDS58Z0e3+w4++SEyE/ZLDihA=;
 b=ZCfXS1lqYMWfRn5yrsnaIoTy0UO4p5/jq/ck7ysK50OvXLCik0PAh92eJ8zsEMoX6bEYWu
 YRsgd1mNY0c+DR0O/frPzN+vll44mvBXGXsFnkOjzjFnZ/O2xilAIHgePsJ9a2sgQ+d0t5
 31FfnuJqV8H5cFZltGU4K1+tolkUKJR3rJHGoPN8p2R/M+qyInqjyvZ1rmgqHw/deSgwux
 V5zh/HpIBhTmBaoi9dwXeddsKPYId1JKs+jPWwKGSj2MWNqE4dUy756liI/MWhULwk+8UB
 YefsV6zkaoFKeB0Ef73OBs/o5WgdWuJjkA7dVveoWG55C2L6s7IGHVeZ2Wy9/Q==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Andreas Geisreiter <ageisreiter@dh-electronics.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
Subject: [PATCH] ARM: imx: Introduce DH i.MX6 DHSOM board specific defconfigs
Date: Sat, 22 Feb 2025 18:13:26 +0100
Message-ID: <20250222171329.90917-1-marex@denx.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Move content of dh_imx6_defconfig into dh_imx6.config. Retain legacy
dh_imx6_defconfig as multi-config for all DH i.MX6 DHSOM based boards.
Introduce separate imx6_dhcom_drc02_defconfig, imx6_dhcom_pdk2_defconfig
and imx6_dhcom_picoitx_defconfig for each i.MX6 DHSOM based board, to
make build for those boards easier. No functional change.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Andreas Geisreiter <ageisreiter@dh-electronics.de>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
 configs/dh_imx6.config               | 76 ++++++++++++++++++++++++++++
 configs/dh_imx6_defconfig            | 76 +---------------------------
 configs/imx6_dhcom_drc02_defconfig   |  4 ++
 configs/imx6_dhcom_pdk2_defconfig    |  4 ++
 configs/imx6_dhcom_picoitx_defconfig |  4 ++
 5 files changed, 89 insertions(+), 75 deletions(-)
 create mode 100644 configs/dh_imx6.config
 create mode 100644 configs/imx6_dhcom_drc02_defconfig
 create mode 100644 configs/imx6_dhcom_pdk2_defconfig
 create mode 100644 configs/imx6_dhcom_picoitx_defconfig

diff --git a/configs/dh_imx6.config b/configs/dh_imx6.config
new file mode 100644
index 00000000000..01db41be2a0
--- /dev/null
+++ b/configs/dh_imx6.config
@@ -0,0 +1,76 @@
+#include <configs/imx_dhsom.config>
+
+CONFIG_ARM=y
+CONFIG_ARCH_MX6=y
+CONFIG_MX6QDL=y
+CONFIG_TARGET_DHCOMIMX6=y
+CONFIG_SPL_SYS_L2_PL310=y
+CONFIG_MX6_DDRCAL=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_OF_UPSTREAM=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_MULTI_DTB_FIT=y
+CONFIG_LTO=y
+
+CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=y
+CONFIG_SYS_I2C_MXC=y
+CONFIG_SYS_MALLOC_F_LEN=0x1000
+CONFIG_SYS_MAXARGS=32
+CONFIG_SYS_MEMTEST_END=0x20000000
+CONFIG_SYS_MEMTEST_START=0x10000000
+CONFIG_SYS_MONITOR_LEN=409600
+CONFIG_SYS_PBSIZE=532
+
+CONFIG_SYS_BOOTCOUNT_ADDR=0x020CC068
+CONFIG_SYS_BOOTCOUNT_BE=y
+CONFIG_BOOTCOUNT_LIMIT=y
+CONFIG_BOOTDELAY=3
+
+CONFIG_BZIP2=y
+CONFIG_CMD_SATA=y
+CONFIG_CMD_UNZIP=y
+CONFIG_CMD_WDT=y
+CONFIG_DISTRO_DEFAULTS=y
+
+CONFIG_ENV_OFFSET=0x100000
+CONFIG_ENV_OFFSET_REDUND=0x110000
+CONFIG_ENV_SECT_SIZE=0x10000
+CONFIG_ENV_SIZE=0x4000
+
+# CONFIG_CMD_SCSI is not set
+CONFIG_AHCI=y
+CONFIG_BOUNCE_BUFFER=y
+CONFIG_DWC_AHSATA=y
+CONFIG_LBA48=y
+CONFIG_SCSI=y
+
+CONFIG_ARP_TIMEOUT=200
+CONFIG_ETHPRIME="FEC"
+CONFIG_USE_ETHPRIME=y
+CONFIG_PHYLIB=y
+
+CONFIG_SF_DEFAULT_SPEED=25000000
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_UNLOCK_ALL=y
+
+CONFIG_MISC=y
+
+CONFIG_PINCTRL_IMX6=y
+
+CONFIG_SDP_LOADADDR=0x17ffffc0
+CONFIG_SPL_FIT=y
+CONFIG_SPL_SPI=y
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_SPL_USB_HOST=y
+CONFIG_SPL_USB_SDP_SUPPORT=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1000000
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x11400
+CONFIG_CI_UDC=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+
+CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
diff --git a/configs/dh_imx6_defconfig b/configs/dh_imx6_defconfig
index 43ac5a567ba..552d743b7df 100644
--- a/configs/dh_imx6_defconfig
+++ b/configs/dh_imx6_defconfig
@@ -1,78 +1,4 @@
-#include <configs/imx_dhsom.config>
+#include <configs/dh_imx6.config>
 
-CONFIG_ARM=y
-CONFIG_ARCH_MX6=y
-CONFIG_MX6QDL=y
-CONFIG_TARGET_DHCOMIMX6=y
-CONFIG_SPL_SYS_L2_PL310=y
 CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6q-dhcom-pdk2"
-CONFIG_MX6_DDRCAL=y
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_OF_LIST="nxp/imx/imx6q-dhcom-pdk2 nxp/imx/imx6dl-dhcom-pdk2 nxp/imx/imx6s-dhcom-drc02 nxp/imx/imx6dl-dhcom-picoitx"
-CONFIG_OF_UPSTREAM=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_MULTI_DTB_FIT=y
-CONFIG_LTO=y
-
-CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=y
-CONFIG_SYS_I2C_MXC=y
-CONFIG_SYS_MALLOC_F_LEN=0x1000
-CONFIG_SYS_MAXARGS=32
-CONFIG_SYS_MEMTEST_END=0x20000000
-CONFIG_SYS_MEMTEST_START=0x10000000
-CONFIG_SYS_MONITOR_LEN=409600
-CONFIG_SYS_PBSIZE=532
-
-CONFIG_SYS_BOOTCOUNT_ADDR=0x020CC068
-CONFIG_SYS_BOOTCOUNT_BE=y
-CONFIG_BOOTCOUNT_LIMIT=y
-CONFIG_BOOTDELAY=3
-
-CONFIG_BZIP2=y
-CONFIG_CMD_SATA=y
-CONFIG_CMD_UNZIP=y
-CONFIG_CMD_WDT=y
-CONFIG_DISTRO_DEFAULTS=y
-
-CONFIG_ENV_OFFSET=0x100000
-CONFIG_ENV_OFFSET_REDUND=0x110000
-CONFIG_ENV_SECT_SIZE=0x10000
-CONFIG_ENV_SIZE=0x4000
-
-# CONFIG_CMD_SCSI is not set
-CONFIG_AHCI=y
-CONFIG_BOUNCE_BUFFER=y
-CONFIG_DWC_AHSATA=y
-CONFIG_LBA48=y
-CONFIG_SCSI=y
-
-CONFIG_ARP_TIMEOUT=200
-CONFIG_ETHPRIME="FEC"
-CONFIG_USE_ETHPRIME=y
-CONFIG_PHYLIB=y
-
-CONFIG_SF_DEFAULT_SPEED=25000000
-CONFIG_SPI_FLASH_GIGADEVICE=y
-CONFIG_SPI_FLASH_MACRONIX=y
-CONFIG_SPI_FLASH_SPANSION=y
-CONFIG_SPI_FLASH_UNLOCK_ALL=y
-
-CONFIG_MISC=y
-
-CONFIG_PINCTRL_IMX6=y
-
-CONFIG_SDP_LOADADDR=0x17ffffc0
-CONFIG_SPL_FIT=y
-CONFIG_SPL_SPI=y
-CONFIG_SPL_SPI_FLASH_SUPPORT=y
-CONFIG_SPL_SPI_LOAD=y
-CONFIG_SPL_USB_GADGET=y
-CONFIG_SPL_USB_HOST=y
-CONFIG_SPL_USB_SDP_SUPPORT=y
-CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1000000
-CONFIG_SYS_SPI_U_BOOT_OFFS=0x11400
-CONFIG_CI_UDC=y
-CONFIG_USB_GADGET_DOWNLOAD=y
-
-CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
diff --git a/configs/imx6_dhcom_drc02_defconfig b/configs/imx6_dhcom_drc02_defconfig
new file mode 100644
index 00000000000..72a0498d9b2
--- /dev/null
+++ b/configs/imx6_dhcom_drc02_defconfig
@@ -0,0 +1,4 @@
+#include <configs/dh_imx6.config>
+
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6s-dhcom-drc02"
+CONFIG_OF_LIST="nxp/imx/imx6s-dhcom-drc02"
diff --git a/configs/imx6_dhcom_pdk2_defconfig b/configs/imx6_dhcom_pdk2_defconfig
new file mode 100644
index 00000000000..6cc81f624f7
--- /dev/null
+++ b/configs/imx6_dhcom_pdk2_defconfig
@@ -0,0 +1,4 @@
+#include <configs/dh_imx6.config>
+
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6q-dhcom-pdk2"
+CONFIG_OF_LIST="nxp/imx/imx6q-dhcom-pdk2 nxp/imx/imx6dl-dhcom-pdk2"
diff --git a/configs/imx6_dhcom_picoitx_defconfig b/configs/imx6_dhcom_picoitx_defconfig
new file mode 100644
index 00000000000..837aab6810f
--- /dev/null
+++ b/configs/imx6_dhcom_picoitx_defconfig
@@ -0,0 +1,4 @@
+#include <configs/dh_imx6.config>
+
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6dl-dhcom-picoitx"
+CONFIG_OF_LIST="nxp/imx/imx6dl-dhcom-picoitx"
-- 
2.47.2

