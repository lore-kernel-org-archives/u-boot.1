Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB3AC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 20:36:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04F9C8707A;
	Wed,  1 Nov 2023 21:35:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RI2yPjUa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6AE287702; Wed,  1 Nov 2023 21:35:48 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F5928770F
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 21:35:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A1KZYcR044359;
 Wed, 1 Nov 2023 15:35:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698870934;
 bh=TPPDD+KWK+eWDAPpragtuWYebVrBCqfQ31wAHrj14aM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=RI2yPjUaeZhtG7jHrZqEiiqe07H6aR7ddu73fsYni0IqYApIcspVQifExHv6vSFGP
 XGBIYhGOkuRwZNX1SRub/TpdrAYLh7DOCGkd/8XMZSPDBUMIz+rGSkU+7F+q9nMTMi
 CHF4hY9pfh39yB2T21/5SD6SdMuGLvzteImXWCMQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A1KZYAb046310
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 1 Nov 2023 15:35:34 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 1
 Nov 2023 15:35:34 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 1 Nov 2023 15:35:34 -0500
Received: from lelv0327.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A1KZWFW089745; 
 Wed, 1 Nov 2023 15:35:33 -0500
From: Andrew Davis <afd@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
 <nm@ti.com>, Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bryan Brattlof <bb@ti.com>, Jan Kiszka <jan.kiszka@siemens.com>, Le Jin
 <le.jin@siemens.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH 3/7] arm: mach-k3: am65x: Move board selection to mach-k3
Date: Wed, 1 Nov 2023 15:35:26 -0500
Message-ID: <20231101203530.80359-3-afd@ti.com>
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
 arch/arm/mach-k3/Kconfig                     |  3 +-
 {board/ti => arch/arm/mach-k3}/am65x/Kconfig | 46 +++++++-------------
 board/siemens/iot2050/Kconfig                | 10 -----
 board/ti/am65x/Kconfig                       | 25 -----------
 4 files changed, 17 insertions(+), 67 deletions(-)
 copy {board/ti => arch/arm/mach-k3}/am65x/Kconfig (52%)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index d5fdabe4293..01889e9d7cf 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -187,12 +187,11 @@ config K3_X509_SWRV
 	help
 	  SWRV for X509 certificate used for boot images
 
-source "board/ti/am65x/Kconfig"
+source "arch/arm/mach-k3/am65x/Kconfig"
 source "board/ti/am64x/Kconfig"
 source "board/ti/am62x/Kconfig"
 source "board/ti/am62ax/Kconfig"
 source "arch/arm/mach-k3/j721e/Kconfig"
-source "board/siemens/iot2050/Kconfig"
 source "board/ti/j721s2/Kconfig"
 source "board/toradex/verdin-am62/Kconfig"
 endif
diff --git a/board/ti/am65x/Kconfig b/arch/arm/mach-k3/am65x/Kconfig
similarity index 52%
copy from board/ti/am65x/Kconfig
copy to arch/arm/mach-k3/am65x/Kconfig
index 7c1bcfc899c..f17b641e136 100644
--- a/board/ti/am65x/Kconfig
+++ b/arch/arm/mach-k3/am65x/Kconfig
@@ -1,11 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Copyright (C) 2017-2018 Texas Instruments Incorporated - http://www.ti.com/
-#	Lokesh Vutla <lokeshvutla@ti.com>
+# Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+#	Andrew Davis <afd@ti.com>
+
+if SOC_K3_AM654
 
 choice
 	prompt "K3 AM65 based boards"
-	depends on SOC_K3_AM654
 	optional
 
 config TARGET_AM654_A53_EVM
@@ -26,34 +27,19 @@ config TARGET_AM654_R5_EVM
 	imply SYS_K3_SPL_ATF
 	imply TI_I2C_BOARD_DETECT
 
-endchoice
-
-if TARGET_AM654_A53_EVM
-
-config SYS_BOARD
-       default "am65x"
-
-config SYS_VENDOR
-       default "ti"
-
-config SYS_CONFIG_NAME
-       default "am65x_evm"
-
-source "board/ti/common/Kconfig"
-
-endif
-
-if TARGET_AM654_R5_EVM
-
-config SYS_BOARD
-       default "am65x"
-
-config SYS_VENDOR
-       default "ti"
+config TARGET_IOT2050_A53
+	bool "IOT2050 running on A53"
+	depends on SOC_K3_AM654
+	select ARM64
+	select BOARD_LATE_INIT
+	select SYS_DISABLE_DCACHE_OPS
+	select BINMAN
+	help
+	  This builds U-Boot for the IOT2050 devices.
 
-config SYS_CONFIG_NAME
-       default "am65x_evm"
+endchoice
 
-source "board/ti/common/Kconfig"
+source "board/ti/am65x/Kconfig"
+source "board/siemens/iot2050/Kconfig"
 
 endif
diff --git a/board/siemens/iot2050/Kconfig b/board/siemens/iot2050/Kconfig
index 737cda64744..96dcfc41000 100644
--- a/board/siemens/iot2050/Kconfig
+++ b/board/siemens/iot2050/Kconfig
@@ -6,16 +6,6 @@
 #   Le Jin <le.jin@siemens.com>
 #   Jan Kiszka <jan.kiszka@siemens.com>
 
-config TARGET_IOT2050_A53
-	bool "IOT2050 running on A53"
-	depends on SOC_K3_AM654
-	select ARM64
-	select BOARD_LATE_INIT
-	select SYS_DISABLE_DCACHE_OPS
-	select BINMAN
-	help
-	  This builds U-Boot for the IOT2050 devices.
-
 if TARGET_IOT2050_A53
 
 config SYS_BOARD
diff --git a/board/ti/am65x/Kconfig b/board/ti/am65x/Kconfig
index 7c1bcfc899c..9102f1d54aa 100644
--- a/board/ti/am65x/Kconfig
+++ b/board/ti/am65x/Kconfig
@@ -3,31 +3,6 @@
 # Copyright (C) 2017-2018 Texas Instruments Incorporated - http://www.ti.com/
 #	Lokesh Vutla <lokeshvutla@ti.com>
 
-choice
-	prompt "K3 AM65 based boards"
-	depends on SOC_K3_AM654
-	optional
-
-config TARGET_AM654_A53_EVM
-	bool "TI K3 based AM654 EVM running on A53"
-	select ARM64
-	select SYS_DISABLE_DCACHE_OPS
-	select BOARD_LATE_INIT
-	select BINMAN
-	imply TI_I2C_BOARD_DETECT
-
-config TARGET_AM654_R5_EVM
-	bool "TI K3 based AM654 EVM running on R5"
-	select CPU_V7R
-	select SYS_THUMB_BUILD
-	select K3_LOAD_SYSFW
-	select K3_AM654_DDRSS
-	select BINMAN
-	imply SYS_K3_SPL_ATF
-	imply TI_I2C_BOARD_DETECT
-
-endchoice
-
 if TARGET_AM654_A53_EVM
 
 config SYS_BOARD
-- 
2.39.2

