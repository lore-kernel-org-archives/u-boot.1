Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69501C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 20:35:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A744C87743;
	Wed,  1 Nov 2023 21:35:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LQUQffR3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC09087724; Wed,  1 Nov 2023 21:35:41 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8501876FC
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 21:35:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A1KZXVj103068;
 Wed, 1 Nov 2023 15:35:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698870933;
 bh=9qqhsxG7QwBMYLlLcP5EM54b1Gmwto6tPzjDzzLC3Q4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=LQUQffR3iQlWJbxb3UkTXffT7X9ok8x0/Q28qiUh5uWhQcEgOZdJufHc5xqFHTHgv
 ZMeKn4x7O4HB2GtCZguNae5oDrJFOO7dIJzwOUKNuEJlEclI4b0CaYnBaUHIyIkOWP
 LV3rt3+ZaSsuoIIuAyJgZ0m7IcLAug9N3JBKvt/k=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A1KZXxk020196
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 1 Nov 2023 15:35:33 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 1
 Nov 2023 15:35:33 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 1 Nov 2023 15:35:33 -0500
Received: from lelv0327.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A1KZWFV089745; 
 Wed, 1 Nov 2023 15:35:32 -0500
From: Andrew Davis <afd@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
 <nm@ti.com>, Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bryan Brattlof <bb@ti.com>, Jan Kiszka <jan.kiszka@siemens.com>, Le Jin
 <le.jin@siemens.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH 2/7] arm: mach-k3: j721e: Move board selection to mach-k3
Date: Wed, 1 Nov 2023 15:35:25 -0500
Message-ID: <20231101203530.80359-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231101203530.80359-1-afd@ti.com>
References: <20231101203530.80359-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Currently each set of board targets from a vendor is selected inside
the board directory for that vendor. This has the problem of multiple
targets, one from each vendor, being selectable at the same time.
For instance you can select both TARGET_AM654_A53_EVM and
TARGET_IOT2050_A53 in the same build.

To fix this we need to move the target board choice to a common location
for each parent SoC selection. Do this in arch/arm/mach-k3.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-k3/Kconfig       |  2 +-
 arch/arm/mach-k3/j721e/Kconfig | 56 ++++++++++++++++++++++++++++++++++
 board/ti/j721e/Kconfig         | 47 ----------------------------
 3 files changed, 57 insertions(+), 48 deletions(-)
 create mode 100644 arch/arm/mach-k3/j721e/Kconfig

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 9168bf842dc..d5fdabe4293 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -191,7 +191,7 @@ source "board/ti/am65x/Kconfig"
 source "board/ti/am64x/Kconfig"
 source "board/ti/am62x/Kconfig"
 source "board/ti/am62ax/Kconfig"
-source "board/ti/j721e/Kconfig"
+source "arch/arm/mach-k3/j721e/Kconfig"
 source "board/siemens/iot2050/Kconfig"
 source "board/ti/j721s2/Kconfig"
 source "board/toradex/verdin-am62/Kconfig"
diff --git a/arch/arm/mach-k3/j721e/Kconfig b/arch/arm/mach-k3/j721e/Kconfig
new file mode 100644
index 00000000000..07cdb5cb517
--- /dev/null
+++ b/arch/arm/mach-k3/j721e/Kconfig
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+#	Andrew Davis <afd@ti.com>
+
+if SOC_K3_J721E
+
+choice
+	prompt "K3 J721E based boards"
+	optional
+
+config TARGET_J721E_A72_EVM
+	bool "TI K3 based J721E EVM running on A72"
+	select ARM64
+	select BOARD_LATE_INIT
+	imply TI_I2C_BOARD_DETECT
+	select SYS_DISABLE_DCACHE_OPS
+	select BINMAN
+
+config TARGET_J721E_R5_EVM
+	bool "TI K3 based J721E EVM running on R5"
+	select CPU_V7R
+	select SYS_THUMB_BUILD
+	select K3_LOAD_SYSFW
+	select RAM
+	select SPL_RAM
+	select K3_DDRSS
+	select BINMAN
+	imply SYS_K3_SPL_ATF
+	imply TI_I2C_BOARD_DETECT
+
+config TARGET_J7200_A72_EVM
+	bool "TI K3 based J7200 EVM running on A72"
+	select ARM64
+	select BOARD_LATE_INIT
+	imply TI_I2C_BOARD_DETECT
+	select SYS_DISABLE_DCACHE_OPS
+	select BINMAN
+
+config TARGET_J7200_R5_EVM
+	bool "TI K3 based J7200 EVM running on R5"
+	select CPU_V7R
+	select SYS_THUMB_BUILD
+	select K3_LOAD_SYSFW
+	select RAM
+	select SPL_RAM
+	select K3_DDRSS
+	select BINMAN
+	imply SYS_K3_SPL_ATF
+	imply TI_I2C_BOARD_DETECT
+
+endchoice
+
+source "board/ti/j721e/Kconfig"
+
+endif
diff --git a/board/ti/j721e/Kconfig b/board/ti/j721e/Kconfig
index 23867ad8e04..c18ba5a2745 100644
--- a/board/ti/j721e/Kconfig
+++ b/board/ti/j721e/Kconfig
@@ -3,53 +3,6 @@
 # Copyright (C) 2018-2019 Texas Instruments Incorporated - http://www.ti.com/
 #	Lokesh Vutla <lokeshvutla@ti.com>
 
-choice
-	prompt "K3 J721E based boards"
-	depends on SOC_K3_J721E
-	optional
-
-config TARGET_J721E_A72_EVM
-	bool "TI K3 based J721E EVM running on A72"
-	select ARM64
-	select BOARD_LATE_INIT
-	imply TI_I2C_BOARD_DETECT
-	select SYS_DISABLE_DCACHE_OPS
-	select BINMAN
-
-config TARGET_J721E_R5_EVM
-	bool "TI K3 based J721E EVM running on R5"
-	select CPU_V7R
-	select SYS_THUMB_BUILD
-	select K3_LOAD_SYSFW
-	select RAM
-	select SPL_RAM
-	select K3_DDRSS
-	select BINMAN
-	imply SYS_K3_SPL_ATF
-	imply TI_I2C_BOARD_DETECT
-
-config TARGET_J7200_A72_EVM
-	bool "TI K3 based J7200 EVM running on A72"
-	select ARM64
-	select BOARD_LATE_INIT
-	imply TI_I2C_BOARD_DETECT
-	select SYS_DISABLE_DCACHE_OPS
-	select BINMAN
-
-config TARGET_J7200_R5_EVM
-	bool "TI K3 based J7200 EVM running on R5"
-	select CPU_V7R
-	select SYS_THUMB_BUILD
-	select K3_LOAD_SYSFW
-	select RAM
-	select SPL_RAM
-	select K3_DDRSS
-	select BINMAN
-	imply SYS_K3_SPL_ATF
-	imply TI_I2C_BOARD_DETECT
-
-endchoice
-
 if TARGET_J721E_A72_EVM
 
 config SYS_BOARD
-- 
2.39.2

