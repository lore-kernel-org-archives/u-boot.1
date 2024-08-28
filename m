Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE495C54E71
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 10:13:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5396288B68;
	Wed, 28 Aug 2024 12:12:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ltUMLIeE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D86E88AF8; Wed, 28 Aug 2024 12:12:30 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E32A8873C
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 12:12:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+Oliver.Gaskell.analog.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id C0C8ACE1774;
 Wed, 28 Aug 2024 10:12:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3021FC4E696;
 Wed, 28 Aug 2024 10:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724839449;
 bh=j9b1wpibXQrnSPkuG649MdKDt60jMALSwhWRzc/GrnE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=ltUMLIeE+tsyLvYF7vQg16UNyKCswU8h577NBBG8nStfyDfKQ/vPyvDO7oOOHB60x
 Y4tven0zeTKeMwDNqi21vkzpKa2LzttLFPyhecT0gCjBuxmxuVAWuSINJM95utD6IW
 T99HO9u6CzpBua/3tAofdCIeE/AeFk+qvF3BjNIFpvXHyW+BJq0uXueZhBh6suY+2r
 fqxupCODRZYVF7nWuxM7S66GnK48ZK4hVhF+D2MfnDKH4zpoDG9XYDGzPKYWTdtFzD
 ymLPSY4IzWnx4bQG7ds+fpM40UrjYcY2SeeXt7bUuMcPnl9nhZkF/8WgAAOisT5Rqv
 xXGljTJkdX35A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 2A82EC54E91;
 Wed, 28 Aug 2024 10:04:09 +0000 (UTC)
From: Oliver Gaskell via B4 Relay
 <devnull+Oliver.Gaskell.analog.com@kernel.org>
Date: Wed, 28 Aug 2024 11:02:24 +0100
Subject: [PATCH 16/20] arm: SC594-SOM-EZLITE initial support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-sc5xx-upstreaming-patches-v1-16-44d9adfdf327@analog.com>
References: <20240828-sc5xx-upstreaming-patches-v1-0-44d9adfdf327@analog.com>
In-Reply-To: <20240828-sc5xx-upstreaming-patches-v1-0-44d9adfdf327@analog.com>
To: Tom Rini <trini@konsulko.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Greg Malysa <greg.malysa@timesys.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: u-boot@lists.denx.de, adsp-linux@analog.com, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724839434; l=4489;
 i=Oliver.Gaskell@analog.com; s=20240821; h=from:subject:message-id;
 bh=uum9NeLtSBi9ikbtFFk0z++c3va2mX/FitLSal1N7RE=;
 b=GAuFiRnXKIO61sYuzeNr4sRo0vATI6HiX+p5FTOFEClKQm6jdJhOOpIQKZ7vfmbI0ElBZQPQd
 bFFtrrZt6e5C+E31G4/mwWPrZmT+giiv+fSN8D3YZ74aK7DNFDP+B6h
X-Developer-Key: i=Oliver.Gaskell@analog.com; a=ed25519;
 pk=Icq9TxwFJ6FePHS28YbBWMvtZpFWxpPQLhLA9cNvZ/Y=
X-Endpoint-Received: by B4 Relay for Oliver.Gaskell@analog.com/20240821
 with auth_id=197
X-Original-From: Oliver Gaskell <Oliver.Gaskell@analog.com>
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
Reply-To: Oliver.Gaskell@analog.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Oliver Gaskell <Oliver.Gaskell@analog.com>

Adds support for Analog Devices' SC594-SOM-EZLITE board. Includes:
- Board specific configs in mach-sc5xx/Kconfig
- Board-specific Kconfig and environment in board/adi/

Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
---
 arch/arm/mach-sc5xx/Kconfig                     |   6 +
 board/adi/sc594-som-ezlite/Kconfig              | 181 ++++++++++++++++++++++++
 board/adi/sc594-som-ezlite/sc594-som-ezlite.env |  13 ++
 3 files changed, 200 insertions(+)

diff --git a/arch/arm/mach-sc5xx/Kconfig b/arch/arm/mach-sc5xx/Kconfig
index fd7029974b..89bc60d6a5 100644
--- a/arch/arm/mach-sc5xx/Kconfig
+++ b/arch/arm/mach-sc5xx/Kconfig
@@ -51,6 +51,11 @@ if SC59X
 choice
 	prompt "SC59x 32-bit board select"
 
+config TARGET_SC594_SOM_EZLITE
+	bool
+	prompt "SC594-SOM with SOMCRR-EZLITE"
+	select ADI_CARRIER_SOMCRR_EZLITE
+
 config TARGET_SC594_SOM_EZKIT
 	bool
 	prompt "SC594-SOM with SOMCRR-EZKIT"
@@ -521,5 +526,6 @@ config PINCTRL_ADI
 source "board/adi/sc598-som-ezkit/Kconfig"
 source "board/adi/sc598-som-ezlite/Kconfig"
 source "board/adi/sc594-som-ezkit/Kconfig"
+source "board/adi/sc594-som-ezlite/Kconfig"
 
 endif
diff --git a/board/adi/sc594-som-ezlite/Kconfig b/board/adi/sc594-som-ezlite/Kconfig
new file mode 100644
index 0000000000..fb6a8235a1
--- /dev/null
+++ b/board/adi/sc594-som-ezlite/Kconfig
@@ -0,0 +1,181 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# (C) Copyright 2024 - Analog Devices, Inc.
+
+if TARGET_SC594_SOM_EZLITE
+
+config SYS_VENDOR
+	default "adi"
+
+config LDR_CPU
+	default "ADSP-SC594-0.0"
+
+config SYS_BOARD
+	default "sc594-som-ezlite"
+
+config SYS_CONFIG_NAME
+	default "sc594-som"
+
+config DEFAULT_DEVICE_TREE
+	default "sc594-som-ezlite"
+
+config SPL_MAX_SIZE
+	default 0x30000 # 256KB
+
+config ADI_IMAGE
+	default "minimal"
+
+config SPL_BSS_START_ADDR
+	hex
+	default 0x200B0000
+
+config SPL_BSS_MAX_SIZE
+	hex
+	default 0x10000 # 64K
+
+config SYS_SPL_MALLOC_START
+	hex
+	default 0x200C0000
+
+config SYS_SPL_MALLOC_SIZE
+	hex
+	default 0x10000 # 64K
+
+config SPL_STACK
+	hex
+	default 0x200E4000
+
+config SPL_STACK_SIZE
+	hex
+	default 0x14000 # 64K
+
+config TEXT_BASE
+	hex
+	default 0xB2200000
+
+config CUSTOM_SYS_INIT_SP_ADDR
+	hex
+	default 0x8203f000
+
+config SYS_LOAD_ADDR
+	hex
+	default 0x0
+
+# SPL
+
+config SPL_TEXT_BASE
+	hex
+	default 0x20080000
+
+config SPL_PAYLOAD_ARGS_ADDR
+	hex
+	default 0x80000000
+
+config SPL_OF_LIBFDT_ASSUME_MASK
+	hex
+	default 0x0
+
+# SPI Flash
+
+config SF_DEFAULT_BUS
+	default 2
+
+config SF_DEFAULT_CS
+	default 1
+
+config SF_DEFAULT_SPEED
+	default 10000000
+
+# Clocks
+
+config CGU0_DF_DIV
+	default 0
+
+config CGU0_VCO_MULT
+	default 80
+
+config CGU0_CCLK_DIV
+	default 2
+
+config CGU0_SCLK_DIV
+	default 4
+
+config CGU0_SCLK0_DIV
+	default 4
+
+config CGU0_SCLK1_DIV
+	default 2
+
+config CGU0_DCLK_DIV
+	default 2
+
+config CGU0_OCLK_DIV
+	default 16
+
+config CGU0_DIV_S1SELEX
+	default 6
+
+config CGU1_VCO_MULT
+	default 64
+
+config CGU1_DF_DIV
+	default 0
+
+config CGU1_CCLK_DIV
+	default 2
+
+config CGU1_SCLK_DIV
+	default 4
+
+config CGU1_SCLK0_DIV
+	default 4
+
+config CGU1_SCLK1_DIV
+	default 2
+
+config CGU1_DCLK_DIV
+	default 2
+
+config CGU1_OCLK_DIV
+	default 16
+
+config CGU1_DIV_S1SELEX
+	default 6
+
+config CDU0_CLKO0
+	default 1
+
+config CDU0_CLKO1
+	default 1
+
+config CDU0_CLKO2
+	default 1
+
+config CDU0_CLKO3
+	default 3
+
+config CDU0_CLKO4
+	default 3
+
+config CDU0_CLKO5
+	default 1
+
+config CDU0_CLKO6
+	default 1
+
+config CDU0_CLKO7
+	default 1
+
+config CDU0_CLKO8
+	default 3
+
+config CDU0_CLKO9
+	default 1
+
+config CDU0_CLKO10
+	default 1
+
+config CDU0_CLKO12
+	default 1
+
+endif
diff --git a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
new file mode 100644
index 0000000000..152e1f14fd
--- /dev/null
+++ b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later+ */
+
+/*
+ * (C) Copyright 2024 - Analog Devices, Inc.
+ */
+
+#include <env/adi/adi_boot.env>
+
+adi_stage2_offset=0x40000
+adi_image_offset=0x0120000
+adi_rfs_offset=0x1020000
+loadaddr=0xA2000000
+jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc594-som-ezlite.jffs2

-- 
2.34.1


