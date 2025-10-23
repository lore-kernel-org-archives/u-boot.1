Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16E3CCD193
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 21:48:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88C178006D;
	Thu, 23 Oct 2025 23:48:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hfnkG1iX";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="K1UINiMC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51FA380422; Thu, 23 Oct 2025 23:48:26 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 560B18003E
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 23:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ct05h1KDFz9slL;
 Thu, 23 Oct 2025 23:48:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761256104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=kBpjvo2DWVx1cvrIfkynRn8+EcmXZ077t3dD2CCSb9c=;
 b=hfnkG1iXkaFZobBc5nZ+XN4zgDkRX54uFbvFkGoPIMTGF4yDC5ImXyeurMf+h7aFBrb93P
 eyCXyq+PFfxuAcc1OO4MDrQYZX+poKT8BlKovtG9Fv7cyE+wNwFy0NQdPNk4qThr8I04XI
 JpUzIpzXGqdyUHmK6hLTA49uvCFlziOrfWInhukJyXLcvYBgodpjemC+5urUgCaAxwrT1e
 9HrDaFE0Dk+6AgwC70Aq6nIqc4wVPFrAhZlCmK8I/Uvvjky4WnDR++E4HXuJfYMXXlNu9k
 TOXi8GdRcN7Ql3WhQ4LMCjnVxrsGroSygGWmwSXlUraTh46Kl1RgTctTvIoLow==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761256102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=kBpjvo2DWVx1cvrIfkynRn8+EcmXZ077t3dD2CCSb9c=;
 b=K1UINiMCus6a1HQO3UDBuhPRoUwT1FqFBXALSEWhrdmu0bGCdp7lkHXrjp44bFWcdzcEsG
 M9zEl2vrTy/L6jZQNPJG45ISIxRilCK01qfoxrErSri9OaJRDlW14Pk5wCsJbWH5c2+wf5
 gUkj113UvzOAIiFRPuI9tp/5iTldxp4K2MULyrnX5V1oU4+fqieGo4D9Q2y0KHjFSSbfVr
 yYQ7QbsX+CNJKKHIaR4EaeL0bEldTK3uYoEzb3ZLCm68I5hDJRqWJpju/269pyFvFLGbnS
 FJSiZ3NuDxb4HPM6ar587srP9J7K0G3DHmUQK2Qi9sHMBsB9GrmreooP9jO6TQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: dts: stm32: Introduce DH STM32MP13x target
Date: Thu, 23 Oct 2025 23:47:57 +0200
Message-ID: <20251023214811.181389-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 7y1cubnpeui6qi9pujdsyx43n7bgunxx
X-MBO-RS-ID: 7103796971df1203230
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

Split the DH STM32MP13x based boards from ST STM32MP13x target,
this way the DH board specific code can be reused for STM32MP13x
DHSOM.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/mach-stm32mp/Kconfig.13x        | 12 ++++++++++
 board/dhelectronics/dh_stm32mp1/Kconfig  | 23 +++++++++++++++++++
 board/dhelectronics/dh_stm32mp1/Makefile |  3 ++-
 board/dhelectronics/dh_stm32mp1/board.c  | 28 ++++++++++++++++++++++++
 configs/stm32mp13_dhcor_defconfig        |  2 +-
 5 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-stm32mp/Kconfig.13x b/arch/arm/mach-stm32mp/Kconfig.13x
index 6a45c4e4132..e9697e34f95 100644
--- a/arch/arm/mach-stm32mp/Kconfig.13x
+++ b/arch/arm/mach-stm32mp/Kconfig.13x
@@ -17,6 +17,17 @@ config TARGET_ST_STM32MP13X
 		managed by board/st/stm32mp1.
 		The difference between board are managed with devicetree
 
+config TARGET_DH_STM32MP13X
+	bool "DH electronics STM32MP13x boards"
+	imply BOOTSTAGE
+	imply CMD_BOOTSTAGE
+	imply CMD_CLS if CMD_BMP
+	imply DISABLE_CONSOLE
+	imply PRE_CONSOLE_BUFFER
+	imply SILENT_CONSOLE
+	help
+		Target the DH DHSBC development kit with STM32MP13x SoM.
+
 endchoice
 
 config TEXT_BASE
@@ -50,6 +61,7 @@ config DEBUG_UART_CLOCK
 	default 64000000
 endif
 
+source "board/dhelectronics/dh_stm32mp1/Kconfig"
 source "board/st/stm32mp1/Kconfig"
 
 endif
diff --git a/board/dhelectronics/dh_stm32mp1/Kconfig b/board/dhelectronics/dh_stm32mp1/Kconfig
index dc707c2753f..05cb97b61e6 100644
--- a/board/dhelectronics/dh_stm32mp1/Kconfig
+++ b/board/dhelectronics/dh_stm32mp1/Kconfig
@@ -20,3 +20,26 @@ config ENV_OFFSET_REDUND
 
 source "board/st/common/Kconfig"
 endif
+
+if TARGET_DH_STM32MP13X
+
+config SYS_BOARD
+	default "dh_stm32mp1"
+
+config SYS_VENDOR
+	default "dhelectronics"
+
+config SYS_CONFIG_NAME
+	default "stm32mp13_st_common"
+
+config ENV_SECT_SIZE
+	default 0x10000 if ENV_IS_IN_SPI_FLASH
+
+config ENV_OFFSET
+	default 0x3E0000 if ENV_IS_IN_SPI_FLASH
+
+config ENV_OFFSET_REDUND
+	default 0x3F0000 if ENV_IS_IN_SPI_FLASH
+
+source "board/st/common/Kconfig"
+endif
diff --git a/board/dhelectronics/dh_stm32mp1/Makefile b/board/dhelectronics/dh_stm32mp1/Makefile
index 30db1dee807..ffd221ac224 100644
--- a/board/dhelectronics/dh_stm32mp1/Makefile
+++ b/board/dhelectronics/dh_stm32mp1/Makefile
@@ -3,6 +3,7 @@
 # Copyright (C) 2018, STMicroelectronics - All Rights Reserved
 #
 
-obj-y += ../../st/common/stpmic1.o board.o
+obj-$(CONFIG_PMIC_STPMIC1) += ../../st/common/stpmic1.o
+obj-y += board.o
 
 obj-$(CONFIG_SET_DFU_ALT_INFO) += ../../st/common/stm32mp_dfu.o
diff --git a/board/dhelectronics/dh_stm32mp1/board.c b/board/dhelectronics/dh_stm32mp1/board.c
index d98b2c6e809..a9b1a0f2c34 100644
--- a/board/dhelectronics/dh_stm32mp1/board.c
+++ b/board/dhelectronics/dh_stm32mp1/board.c
@@ -692,6 +692,34 @@ void board_quiesce_devices(void)
 #endif
 }
 
+#ifdef CONFIG_TARGET_DH_STM32MP13X
+enum env_location env_get_location(enum env_operation op, int prio)
+{
+	u32 bootmode = get_bootmode();
+
+	if (prio)
+		return ENVL_UNKNOWN;
+
+	switch (bootmode & TAMP_BOOT_DEVICE_MASK) {
+	case BOOT_FLASH_SD:
+	case BOOT_FLASH_EMMC:
+		if (CONFIG_IS_ENABLED(ENV_IS_IN_MMC))
+			return ENVL_MMC;
+		else
+			return ENVL_NOWHERE;
+
+	case BOOT_FLASH_NOR:
+		if (CONFIG_IS_ENABLED(ENV_IS_IN_SPI_FLASH))
+			return ENVL_SPI_FLASH;
+		else
+			return ENVL_NOWHERE;
+
+	default:
+		return ENVL_NOWHERE;
+	}
+}
+#endif
+
 static void dh_stm32_ks8851_fixup(void *blob)
 {
 	struct gpio_desc ks8851intrn;
diff --git a/configs/stm32mp13_dhcor_defconfig b/configs/stm32mp13_dhcor_defconfig
index c21416459e6..f751deb801f 100644
--- a/configs/stm32mp13_dhcor_defconfig
+++ b/configs/stm32mp13_dhcor_defconfig
@@ -8,7 +8,7 @@ CONFIG_ENV_OFFSET=0x3E0000
 CONFIG_DEFAULT_DEVICE_TREE="st/stm32mp135f-dhcor-dhsbc"
 CONFIG_STM32MP13X=y
 CONFIG_DDR_CACHEABLE_SIZE=0x8000000
-CONFIG_TARGET_ST_STM32MP13X=y
+CONFIG_TARGET_DH_STM32MP13X=y
 CONFIG_ENV_OFFSET_REDUND=0x3F0000
 CONFIG_STM32MP15_PWR=y
 CONFIG_ARMV7_NONSEC=y
-- 
2.51.0

