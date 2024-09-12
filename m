Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73C0EED617
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 15:54:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4F138908B;
	Thu, 12 Sep 2024 17:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CMejHZTX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D2D789075; Thu, 12 Sep 2024 17:51:25 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0ACB8902B
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 17:51:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+Oliver.Gaskell.analog.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id C62E5A45704;
 Thu, 12 Sep 2024 15:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 375CEC4CED1;
 Thu, 12 Sep 2024 15:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726156275;
 bh=QjL840MjZmlFroZIMfcqgy+aUmpetyr/PPNPAZywnTk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=CMejHZTX6GNnFDZjXPjAVFo86O3N/mMgMvY7/OHGbvD34XTLswIkU6eu1C8/bjF3Q
 tQyej8wMtuZqPtkpadpTnAfNv9IGvRDzveFKgroHhujyn77Ex9e1MNP/13WjAuWw/J
 FP9ys/WMMDMDQOd9gbM/BoI7Iy2gLwGh0LK2LQo5QaFDLHtDATAnQGXKXuRCHZj3Bb
 8LE5UD6bfQ1ogWjyrfX27pvjgzdznkV3HMojFAqf7NUZu+qs+qdsnd97ld4SeRWXRj
 N0WHeQ8ed1ZZOrsKg6/S4d1VIzmI8yHqg77vGW+IoGsedeJc2XODKR9TdqPxPo/xcM
 eMGZhn2WkavoQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 31125EED617;
 Thu, 12 Sep 2024 15:51:15 +0000 (UTC)
From: Oliver Gaskell via B4 Relay
 <devnull+Oliver.Gaskell.analog.com@kernel.org>
Date: Thu, 12 Sep 2024 16:50:57 +0100
Subject: [PATCH v2 16/20] arm: SC594-SOM-EZLITE initial support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240912-sc5xx-upstreaming-patches-v2-16-1185a80df79e@analog.com>
References: <20240912-sc5xx-upstreaming-patches-v2-0-1185a80df79e@analog.com>
In-Reply-To: <20240912-sc5xx-upstreaming-patches-v2-0-1185a80df79e@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726156261; l=4389;
 i=Oliver.Gaskell@analog.com; s=20240821; h=from:subject:message-id;
 bh=/L8NMZm1pKklI8KZfDNeJIrU+vnx/Z5MLH1H53Arh/U=;
 b=S7EC4mG1vfzbH3/ozLxBuKDV5VsLUSN1JGgxyREbWq+NH79NBS6dmORWHnKnD+wv+aTVXQMwM
 UD6FtpUWkJEAb1BRDkMCNt5C86Un//ZibhSGzoq2g7mXJ9BkpNaK+1c
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
 arch/arm/mach-sc5xx/Kconfig                     |   6 ++
 board/adi/sc594-som-ezlite/Kconfig              | 133 ++++++++++++++++++++++++
 board/adi/sc594-som-ezlite/sc594-som-ezlite.env |  13 +++
 common/spl/Kconfig                              |   1 +
 4 files changed, 153 insertions(+)

diff --git a/arch/arm/mach-sc5xx/Kconfig b/arch/arm/mach-sc5xx/Kconfig
index e93f214441..b57c21cf16 100644
--- a/arch/arm/mach-sc5xx/Kconfig
+++ b/arch/arm/mach-sc5xx/Kconfig
@@ -54,6 +54,11 @@ if SC59X
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
@@ -524,5 +529,6 @@ config PINCTRL_ADI
 source "board/adi/sc598-som-ezkit/Kconfig"
 source "board/adi/sc598-som-ezlite/Kconfig"
 source "board/adi/sc594-som-ezkit/Kconfig"
+source "board/adi/sc594-som-ezlite/Kconfig"
 
 endif
diff --git a/board/adi/sc594-som-ezlite/Kconfig b/board/adi/sc594-som-ezlite/Kconfig
new file mode 100644
index 0000000000..70436955b6
--- /dev/null
+++ b/board/adi/sc594-som-ezlite/Kconfig
@@ -0,0 +1,133 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# (C) Copyright 2024 - Analog Devices, Inc.
+
+if TARGET_SC594_SOM_EZLITE
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
+config ADI_IMAGE
+	default "minimal"
+
+config CUSTOM_SYS_INIT_SP_ADDR
+	default 0x8203f000
+
+# SPL
+
+config SPL_OF_LIBFDT_ASSUME_MASK
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
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index d46984b3ea..e723ff1996 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1131,6 +1131,7 @@ config SPL_PAYLOAD_ARGS_ADDR
 	default 0x88000000 if ARCH_OMAP2PLUS
 	default 0x99000000 if ARCH_SC5XX && SC59X_64
 	default 0xA0000000 if ARCH_SC5XX && TARGET_SC594_SOM_EZKIT
+	default 0x80000000 if ARCH_SC5XX && TARGET_SC594_SOM_EZLITE
 	help
 	  Address in memory where the 'args' file, typically a device tree
 	  will be loaded in to memory.

-- 
2.34.1


