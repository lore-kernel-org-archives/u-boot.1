Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F63EED615
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 15:54:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C18689098;
	Thu, 12 Sep 2024 17:51:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NiH4RH2m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A075589080; Thu, 12 Sep 2024 17:51:25 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59B5C8902C
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 17:51:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+Oliver.Gaskell.analog.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 219F4A45706;
 Thu, 12 Sep 2024 15:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13E53C4CED2;
 Thu, 12 Sep 2024 15:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726156275;
 bh=hxID9cwGEcs8ZFto39g+IaDq720lCXdthpOYPRIKO8w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=NiH4RH2mOTFPQ/waOPiwVUmc+UHKoy1GDVfFeRr0E6RbaM660Guictf6D7QWdZYDK
 Xw6cbmFLQs3EZ35CI+bGXkWeDcz+N62JATxQ+L78aCig5GGGlbHr7p/QPwljKRspO5
 e9GLuTLDqshcBLWXwoAPxsM9FW6rmOcfindnL/sjRhhuV7No+WjuoS3h9EQoTMnUzB
 6zTM8zA7lWsLKpJQATNzl68g1ib1eRA4kFRvZQqTU0Gr+kkL7l1ggCsQF75Hk9qgwS
 mO/ufIr0/NF6OJxsP7LHCiU0IY3rspH97QrkaXXgxzyMZeUAz381asFH0IUZ6nQmeu
 ozbXbrNXvClLQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 0D943EED618;
 Thu, 12 Sep 2024 15:51:15 +0000 (UTC)
From: Oliver Gaskell via B4 Relay
 <devnull+Oliver.Gaskell.analog.com@kernel.org>
Date: Thu, 12 Sep 2024 16:50:55 +0100
Subject: [PATCH v2 14/20] arm: SC598-SOM-EZLITE initial support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240912-sc5xx-upstreaming-patches-v2-14-1185a80df79e@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726156261; l=3357;
 i=Oliver.Gaskell@analog.com; s=20240821; h=from:subject:message-id;
 bh=LIbJ4xU5u0+JhTg9c+FZMUjiLTWrXEID7qo27uALXrE=;
 b=vZMQvrGZXLos/E4d23vStEbPtdXfhf2wNyL7FsahNeGgtBja/QOVxafKiuCpuKeMf8+thl+Tu
 gFQCNf7Sn0ID5Lc3jMYO0X7RqouG2PikJ+zuoj218oao/xlSBtH8B1/
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

Adds support for Analog Devices' SC598-SOM-EZLITE board. Includes:
- Board specific configs in mach-sc5xx/Kconfig
- Board-specific Kconfig and environment in board/adi/

Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
---
 arch/arm/mach-sc5xx/Kconfig                     |   6 ++
 board/adi/sc598-som-ezlite/Kconfig              | 100 ++++++++++++++++++++++++
 board/adi/sc598-som-ezlite/sc598-som-ezlite.env |  13 +++
 3 files changed, 119 insertions(+)

diff --git a/arch/arm/mach-sc5xx/Kconfig b/arch/arm/mach-sc5xx/Kconfig
index 4e587eb0b3..e3d3a4c89e 100644
--- a/arch/arm/mach-sc5xx/Kconfig
+++ b/arch/arm/mach-sc5xx/Kconfig
@@ -54,6 +54,11 @@ if SC59X_64
 choice
 	prompt "SC59x 64-bit board select"
 
+config TARGET_SC598_SOM_EZLITE
+	bool
+	prompt "SC598-SOM with SOMCRR-EZLITE"
+	select ADI_CARRIER_SOMCRR_EZLITE
+
 config TARGET_SC598_SOM_EZKIT
 	bool
 	prompt "SC598-SOM with SOMCRR-EZKIT"
@@ -503,5 +508,6 @@ config PINCTRL_ADI
 	default y
 
 source "board/adi/sc598-som-ezkit/Kconfig"
+source "board/adi/sc598-som-ezlite/Kconfig"
 
 endif
diff --git a/board/adi/sc598-som-ezlite/Kconfig b/board/adi/sc598-som-ezlite/Kconfig
new file mode 100644
index 0000000000..3312316ebd
--- /dev/null
+++ b/board/adi/sc598-som-ezlite/Kconfig
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# (C) Copyright 2024 - Analog Devices, Inc.
+
+if TARGET_SC598_SOM_EZLITE
+
+config LDR_CPU
+	default "ADSP-SC598-0.0"
+
+config SYS_BOARD
+	default "sc598-som-ezlite"
+
+config SYS_CONFIG_NAME
+	default "sc598-som"
+
+config DEFAULT_DEVICE_TREE
+	default "sc598-som-ezlite"
+
+config ADI_IMAGE
+	default "minimal"
+
+config CUSTOM_SYS_INIT_SP_ADDR
+	default 0x96000000
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
+# Clock Configs
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
+	default 3
+
+config CGU0_OCLK_DIV
+	default 8
+
+config CGU0_DIV_S1SELEX
+	default 6
+
+config CGU1_VCO_MULT
+	default 72
+
+config CGU1_DF_DIV
+	default 0
+
+config CGU1_CCLK_DIV
+	default 16
+
+config CGU1_SCLK_DIV
+	default 8
+
+config CGU1_SCLK0_DIV
+	default 4
+
+config CGU1_SCLK1_DIV
+	default 2
+
+config CGU1_DCLK_DIV
+	default 18
+
+config CGU1_OCLK_DIV
+	default 16
+
+config CGU1_DIV_S0SELEX
+	default 36
+
+config CGU1_DIV_S1SELEX
+	default 90
+
+endif
diff --git a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
new file mode 100644
index 0000000000..036c9ae759
--- /dev/null
+++ b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
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
+adi_image_offset=0x01a0000
+adi_rfs_offset=0x1020000
+loadaddr=0x90000000
+jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc598-som-ezlite.jffs2

-- 
2.34.1


