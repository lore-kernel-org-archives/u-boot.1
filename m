Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB83606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=moaIxIF4;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=IQmdIGgu
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35D8E60A48;
	Thu, 26 Nov 2026 10:47:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3nZ7hKrNjXXL; Thu, 26 Nov 2026 10:47:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5470160A50
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795690028;
	b=aEzQ9NzS+lP1c/kfNKnKlG/tOOsMJ5kCDu21qT6fWpmId4JNBWluMD8aYsYZDQYNTqUY
	 B8Evvw/+Trd4/aMdb6BBGZ1O+8iwmPKXMJc5TERO95yYMKxPl/uqV8ayGBVh4FjJsA8NH
	 Wb75pPyjrDmsQrJCD9chRYsqbmR3h9P8XM8AVZjZQjpTIQmfrxdovq23MlyLY4gUeiBRN
	 Zue0WHuAEDZ+u8YCwQop++g4kNENMEiaO0LqcyMhDxdwnC7x03PLODTDbHppNBtJKbOzN
	 /QZGm1Tqb1Z6vH/FZIyE6ysTAi4JFRxAr9wXYJlB/ys7IcwoYf5IMQjXRfWtU6mRU+g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795690028;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0E9yF/bAwPTRoJZBUZuBu2Tvt9EyEQHVkBvvR+S4Vn0=;
	b=TC2URFQ3zKUO8G/FSawwFUPKcslNE97SP/6EIVaomwU81d/xUfZhlPbned9pucRqZUnS
	 E+0WoSz+xH7jPTBXNTyHcqXQxzmZ2dbiJbx0rl4POAa6bjcCIFMfVhabL+6U72s0lGRO9
	 Iub9qawtbtMFym8sG3E56EXrFKIDRJ4v2YsZooDWILaKKJOlkX8OfyA1MRF2clkI5EHvn
	 9fTenEFlLI7X23Hw6tB/gVp7wLvMFSpJTE0ri5dpa+TluWzkFgW34qVsu/imt60qV8VAU
	 0bbwMorXrax17pfn/7qpcrPgoZDaZdQpqo2Olef9k/6wrNXHsxIXY7DSerqR7MnPW8g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795690028;
	bh=0E9yF/bAwPTRoJZBUZuBu2Tvt9EyEQHVkBvvR+S4Vn0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=moaIxIF45N9DBCSJyD8juo9h6m1WImQ2I+IZO5WUghMgZ+YDyNp+rvgG+p9xW3WfJ
	 7UDP34jwnL8NGVTFbjyYwG5NDF5OeeNoxgl2V11JJt3xF9P6KeO1dPzuz4PqEHpg6f
	 PY875zuRmIJ3zAgKf4clhk9P6c7NKo7ChHBKsuKumbvuiyNkmkrS5j/mfGVzrHiHLb
	 otsi14AoKleERQFpKG1MN7GOq51Vmn+SnZ/l+mN4MF47tNIL/T7Tv8PeDh7GC8NeOD
	 anEMBpIojHntrODC1YmqczXtHwEjyBaTz/Rs/Fuz4PI9Q1tETfIQsIo7EQv28y00Kp
	 g+rIMW6EDu2nQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5470160A50;
	Thu, 26 Nov 2026 10:47:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8728410B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:46:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 68650408C4
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:46:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UqTOpZ92wu48 for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 10:46:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 56D60408C7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=IQmdIGgu
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 56D60408C7
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=0E9yF/bAwPTRoJZBUZuBu2Tvt9EyEQHVkBvvR+S4Vn0=; b=IQmdIGgub+m0yKiz74bjibWJub
 GK2P8ILmydskp000aCkHjbwrTpnP1+Re5KzpBA43mL94w5EI0OnJ678wqgyEaJe8yE5YYj1cl93QB
 LFc7GVwI9xhqvfMLYMbM7kFaEx/DT2Eq/E8Ou8VOeWqgQVAKIsgqhEE1PsJxnt8DC4h1W01z18JiF
 NbPy10BPP2oXukcghaCQZNvmR6PjFJF4oYm2en+Au8W/XrWtA5J624Cc9Dt+w4Jf3PKqL2/X6qGDA
 B45bpEmmZyJomw3goZD8P4KCuan5n5DNLrM+g0dZYhAX+/XyvpNPjzcCT97MHG5peWXMeQ4r+kNAr
 1xwyIwTg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1xWX07-000Nuq-0s; Thu, 26 Nov 2026 11:46:51 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1xWX06-0002PX-0b; Thu, 26 Nov 2026 11:46:50 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
Date: Thu, 26 Nov 2026 11:46:49 +0100
Subject: [PATCH 4/6] board: tqma6: unify mmc and spi configs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-update-tqma6-v1-4-a105aba78868@ew.tq-group.com>
References: <20261126-update-tqma6-v1-0-a105aba78868@ew.tq-group.com>
In-Reply-To: <20261126-update-tqma6-v1-0-a105aba78868@ew.tq-group.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot@ew.tq-group.com, 
 u-boot@lists.u-boot-project.org, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Max Merchel <max.merchel@ew.tq-group.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Paul Gerber <Paul.Gerber@tq-group.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Adam Ford <aford173@gmail.com>, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 Paul Gerber <Paul.Gerber@ew.tq-group.com>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>
X-Mailer: b4 0.14.3
X-Virus-Scanned: Clear (ClamAV 1.4.6/28194/Wed Nov 25 07:26:59 2026)
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reduce the number of defconfigs by combining SPI and MMC configurations
    - Use MMC CONFIG_ENV_OFFSET (change SPI CONFIG_ENV_OFFSET)

Define environment size, sector, offset and redundant offset for SPI
flash in defconfig and offset and redundant offset for MMC in devicetree.

Align the offset values to SPI flash sector size of 64KiB. Increase
environment size also to SPI flash sector size.

Select environment based on the boot medium.

Signed-off-by: Paul Gerber <Paul.Gerber@tq-group.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 arch/arm/dts/imx6qdl-mba6-u-boot.dtsi              |  7 ++++
 board/tq/tqma6/Kconfig                             | 24 -------------
 board/tq/tqma6/tqma6.cfg                           | 30 -----------------
 board/tq/tqma6/tqma6_mba6.c                        | 39 ++++++++++++++++++++++
 configs/tqma6_mba6_common.config                   | 12 ++++++-
 configs/tqma6_mba6_mmc.config                      |  3 --
 configs/tqma6_mba6_spi.config                      |  6 ----
 ...l_mba6_spi_defconfig => tqma6dl_mba6_defconfig} |  1 -
 configs/tqma6dl_mba6_mmc_defconfig                 |  7 ----
 ...6q_mba6_mmc_defconfig => tqma6q_mba6_defconfig} |  1 -
 configs/tqma6q_mba6_spi_defconfig                  |  7 ----
 ...6s_mba6_mmc_defconfig => tqma6s_mba6_defconfig} |  1 -
 configs/tqma6s_mba6_spi_defconfig                  |  7 ----
 13 files changed, 57 insertions(+), 88 deletions(-)

diff --git a/arch/arm/dts/imx6qdl-mba6-u-boot.dtsi b/arch/arm/dts/imx6qdl-mba6-u-boot.dtsi
index 535fd0c5e48..2572e686009 100644
--- a/arch/arm/dts/imx6qdl-mba6-u-boot.dtsi
+++ b/arch/arm/dts/imx6qdl-mba6-u-boot.dtsi
@@ -6,3 +6,10 @@
  */
 
 #include "imx6qdl-tqma6-u-boot.dtsi"
+/ {
+	config {
+		u-boot,mmc-env-offset = <0x100000>;
+		u-boot,mmc-env-offset-redundant = <0x110000>;
+	};
+};
+
diff --git a/board/tq/tqma6/Kconfig b/board/tq/tqma6/Kconfig
index 65f5be8af61..42b61cb620e 100644
--- a/board/tq/tqma6/Kconfig
+++ b/board/tq/tqma6/Kconfig
@@ -42,27 +42,6 @@ config TQMA6S
 
 endchoice
 
-choice
-	prompt "TQMa6 boot configuration"
-	default TQMA6X_MMC_BOOT
-	help
-	  Configure boot device. This is also used to implement environment
-	  location.
-
-config TQMA6X_MMC_BOOT
-	bool "MMC / SD Boot"
-	help
-	  Boot from
-	  eMMC / SD Card
-
-config TQMA6X_SPI_BOOT
-	bool "SPI NOR Boot"
-	help
-	  Boot from
-	  board SPI NOR flash
-
-endchoice
-
 choice
 	prompt "TQMa6 base board variant"
 	default MBA6
@@ -108,9 +87,6 @@ config TEXT_BASE
 config SPL_TEXT_BASE
 	default 0x00908000
 
-config IMX_CONFIG
-	default "board/tq/tqma6/tqma6.cfg"
-
 source "board/tq/common/Kconfig"
 
 endif
diff --git a/board/tq/tqma6/tqma6.cfg b/board/tq/tqma6/tqma6.cfg
deleted file mode 100644
index 3395433dc09..00000000000
--- a/board/tq/tqma6/tqma6.cfg
+++ /dev/null
@@ -1,30 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (c) 2016-2025 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
- * D-82229 Seefeld, Germany.
- * Author: Markus Niebel
- *
- * ##########################################################################
- *
- * Refer doc/imx/mkimage/imximage.txt for more details about how-to configure
- * and create imximage boot image
- *
- * The syntax is taken as close as possible with the kwbimage
- */
-
-/* image version */
-IMAGE_VERSION 2
-
-#include <config.h>
-
-/*
- * Boot Device : one of
- * spi, sd (the board has no nand neither onenand)
- */
-#if defined(CONFIG_TQMA6X_MMC_BOOT)
-BOOT_FROM      sd
-#elif defined(CONFIG_TQMA6X_SPI_BOOT)
-BOOT_FROM      spi
-#else
-#error
-#endif
diff --git a/board/tq/tqma6/tqma6_mba6.c b/board/tq/tqma6/tqma6_mba6.c
index 45fef41d61d..e8d166dfef1 100644
--- a/board/tq/tqma6/tqma6_mba6.c
+++ b/board/tq/tqma6/tqma6_mba6.c
@@ -10,6 +10,7 @@
  */
 
 #include <env.h>
+#include <env_internal.h>
 #include <spl.h>
 
 #include <asm/arch/mx6-pins.h>
@@ -105,4 +106,42 @@ int tq_bb_board_late_init(void)
 	return 0;
 }
 
+enum env_location env_get_location(enum env_operation op, int prio)
+{
+	u32 bmode = imx6_src_get_boot_mode();
+	u8 imx6_bmode = (bmode & IMX6_BMODE_MASK) >> IMX6_BMODE_SHIFT;
+
+	switch (imx6_bmode) {
+	case IMX6_BMODE_SD:
+	case IMX6_BMODE_ESD:
+	case IMX6_BMODE_MMC:
+	case IMX6_BMODE_EMMC:
+		if (prio == 0)
+			return ENVL_MMC;
+		break;
+	case IMX6_BMODE_SERIAL_ROM:
+		switch ((imx6_bmode & IMX6_BMODE_SERIAL_ROM_MASK) >>
+			IMX6_BMODE_SERIAL_ROM_SHIFT) {
+		case IMX6_BMODE_ECSPI1:
+		case IMX6_BMODE_ECSPI2:
+		case IMX6_BMODE_ECSPI3:
+		case IMX6_BMODE_ECSPI4:
+		case IMX6_BMODE_ECSPI5:
+			if (prio == 0)
+				return ENVL_SPI_FLASH;
+			break;
+		default:
+			if (prio == 0)
+				return ENVL_NOWHERE;
+			break;
+		}
+	default:
+		if (prio == 0)
+			return ENVL_NOWHERE;
+		break;
+	}
+
+	return ENVL_UNKNOWN;
+}
+
 #endif /* !IS_ENABLED(CONFIG_SPL_BUILD) */
diff --git a/configs/tqma6_mba6_common.config b/configs/tqma6_mba6_common.config
index 2fd444d0f66..b707ffcf7c0 100644
--- a/configs/tqma6_mba6_common.config
+++ b/configs/tqma6_mba6_common.config
@@ -6,7 +6,9 @@ CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_SF_DEFAULT_SPEED=50000000
-CONFIG_ENV_SIZE=0x2000
+CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0x100000
+CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_TARGET_TQMA6=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0xb000
 CONFIG_SPL_MMC=y
@@ -14,6 +16,7 @@ CONFIG_SPL_SERIAL=y
 CONFIG_SPL_STACK_R_ADDR=0x18000000
 CONFIG_SPL_STACK_R=y
 CONFIG_SPL=y
+CONFIG_ENV_OFFSET_REDUND=0x110000
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_SYS_MEMTEST_START=0x28000000
@@ -28,10 +31,12 @@ CONFIG_FDT_FIXUP_PARTITIONS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run mmcboot"
 CONFIG_SYS_PBSIZE=532
+CONFIG_SPL_RAW_IMAGE_SUPPORT=y
 CONFIG_SPL_LEGACY_IMAGE_FORMAT=y
 CONFIG_SPL_FIT_IMAGE_TINY=y
 CONFIG_SPL_DMA=y
 CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x11400
 CONFIG_SPL_WATCHDOG=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_MAXARGS=32
@@ -62,7 +67,12 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_MMC_USE_DT=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
diff --git a/configs/tqma6_mba6_mmc.config b/configs/tqma6_mba6_mmc.config
deleted file mode 100644
index a25184378e0..00000000000
--- a/configs/tqma6_mba6_mmc.config
+++ /dev/null
@@ -1,3 +0,0 @@
-CONFIG_ENV_OFFSET=0x100000
-CONFIG_ENV_IS_IN_MMC=y
-# CONFIG_DISPLAY_BOARDINFO is not set
diff --git a/configs/tqma6_mba6_spi.config b/configs/tqma6_mba6_spi.config
deleted file mode 100644
index 5e161b1e16c..00000000000
--- a/configs/tqma6_mba6_spi.config
+++ /dev/null
@@ -1,6 +0,0 @@
-CONFIG_ENV_OFFSET=0x80000
-CONFIG_ENV_SECT_SIZE=0x10000
-CONFIG_TQMA6X_SPI_BOOT=y
-CONFIG_ENV_OFFSET_REDUND=0x90000
-CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_ENV_REDUNDANT=y
diff --git a/configs/tqma6dl_mba6_spi_defconfig b/configs/tqma6dl_mba6_defconfig
similarity index 82%
rename from configs/tqma6dl_mba6_spi_defconfig
rename to configs/tqma6dl_mba6_defconfig
index bee18e7fc43..febb1e74346 100644
--- a/configs/tqma6dl_mba6_spi_defconfig
+++ b/configs/tqma6dl_mba6_defconfig
@@ -1,5 +1,4 @@
 #include <configs/tqma6_mba6_common.config>
-#include <configs/tqma6_mba6_spi.config>
 
 CONFIG_MX6DL=y
 CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6dl-mba6b"
diff --git a/configs/tqma6dl_mba6_mmc_defconfig b/configs/tqma6dl_mba6_mmc_defconfig
deleted file mode 100644
index 09e821b995a..00000000000
--- a/configs/tqma6dl_mba6_mmc_defconfig
+++ /dev/null
@@ -1,7 +0,0 @@
-#include <configs/tqma6_mba6_common.config>
-#include <configs/tqma6_mba6_mmc.config>
-
-CONFIG_MX6DL=y
-CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6dl-mba6b"
-CONFIG_OF_LIST="nxp/imx/imx6dl-mba6a nxp/imx/imx6dl-mba6b"
-CONFIG_MULTI_DTB_FIT=y
diff --git a/configs/tqma6q_mba6_mmc_defconfig b/configs/tqma6q_mba6_defconfig
similarity index 82%
rename from configs/tqma6q_mba6_mmc_defconfig
rename to configs/tqma6q_mba6_defconfig
index ed2961c599b..306d805c97e 100644
--- a/configs/tqma6q_mba6_mmc_defconfig
+++ b/configs/tqma6q_mba6_defconfig
@@ -1,5 +1,4 @@
 #include <configs/tqma6_mba6_common.config>
-#include <configs/tqma6_mba6_mmc.config>
 
 CONFIG_MX6Q=y
 CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6q-mba6b"
diff --git a/configs/tqma6q_mba6_spi_defconfig b/configs/tqma6q_mba6_spi_defconfig
deleted file mode 100644
index dd49741ae7c..00000000000
--- a/configs/tqma6q_mba6_spi_defconfig
+++ /dev/null
@@ -1,7 +0,0 @@
-#include <configs/tqma6_mba6_common.config>
-#include <configs/tqma6_mba6_spi.config>
-
-CONFIG_MX6Q=y
-CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6q-mba6b"
-CONFIG_OF_LIST="nxp/imx/imx6q-mba6a nxp/imx/imx6q-mba6b"
-CONFIG_MULTI_DTB_FIT=y
diff --git a/configs/tqma6s_mba6_mmc_defconfig b/configs/tqma6s_mba6_defconfig
similarity index 82%
rename from configs/tqma6s_mba6_mmc_defconfig
rename to configs/tqma6s_mba6_defconfig
index c8197c67645..7cab0eee593 100644
--- a/configs/tqma6s_mba6_mmc_defconfig
+++ b/configs/tqma6s_mba6_defconfig
@@ -1,5 +1,4 @@
 #include <configs/tqma6_mba6_common.config>
-#include <configs/tqma6_mba6_mmc.config>
 
 CONFIG_MX6S=y
 CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6dl-mba6b"
diff --git a/configs/tqma6s_mba6_spi_defconfig b/configs/tqma6s_mba6_spi_defconfig
deleted file mode 100644
index e200e0c5480..00000000000
--- a/configs/tqma6s_mba6_spi_defconfig
+++ /dev/null
@@ -1,7 +0,0 @@
-#include <configs/tqma6_mba6_common.config>
-#include <configs/tqma6_mba6_spi.config>
-
-CONFIG_MX6S=y
-CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6dl-mba6b"
-CONFIG_OF_LIST="nxp/imx/imx6dl-mba6a nxp/imx/imx6dl-mba6b"
-CONFIG_MULTI_DTB_FIT=y

-- 
2.53.0

