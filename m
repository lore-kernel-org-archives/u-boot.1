Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4508C35FFB
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 19:30:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E25D8191C;
	Wed, 19 Mar 2025 20:30:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ujd3ty9V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57E2880FF0; Wed, 19 Mar 2025 20:30:05 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C01BD810F2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 20:30:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52JJU0LU3009380
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 19 Mar 2025 14:30:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1742412600;
 bh=ZFIJAmKHGOz51VlBAwu82zfgr1zbxUi7+O/9+w66OjY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Ujd3ty9VRTuzK7/7Eq5he88TSxi4Hn07mZTMqavmlcWjPcgsBBaCNvcascPnT2oLV
 KjlZr+IlCXNH9MMpzJrwPGMki+AeSeDP0av/Tce70vXEI4fCkD4PiEgr1xevuWPnOX
 AD4/xNsjhX0C5mRP6IpFDb6h65UCn3tP75L/dU8E=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52JJU0p2025854;
 Wed, 19 Mar 2025 14:30:00 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Mar 2025 14:29:59 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Mar 2025 14:29:59 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52JJTwwY025899;
 Wed, 19 Mar 2025 14:29:59 -0500
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH 2/3] arm: mach-k3: Enable BINMAN Kconfig symbol for all ARCH_K3
Date: Wed, 19 Mar 2025 14:29:57 -0500
Message-ID: <20250319192958.276563-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250319192958.276563-1-afd@ti.com>
References: <20250319192958.276563-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

All K3 build need BINMAN support so select it under ARCH_K3,
not individually for each board target.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/Kconfig                    | 1 +
 arch/arm/mach-k3/am62ax/Kconfig     | 4 ----
 arch/arm/mach-k3/am62px/Kconfig     | 2 --
 arch/arm/mach-k3/am62x/Kconfig      | 6 ------
 arch/arm/mach-k3/am64x/Kconfig      | 4 ----
 arch/arm/mach-k3/am65x/Kconfig      | 3 ---
 arch/arm/mach-k3/j721e/Kconfig      | 4 ----
 arch/arm/mach-k3/j721s2/Kconfig     | 2 --
 arch/arm/mach-k3/j722s/Kconfig      | 2 --
 arch/arm/mach-k3/j784s4/Kconfig     | 2 --
 board/beagle/beagleboneai64/Kconfig | 2 --
 board/beagle/beagleplay/Kconfig     | 2 --
 12 files changed, 1 insertion(+), 33 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index da6f1174934..c63bb772d75 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -809,6 +809,7 @@ config ARCH_KEYSTONE
 
 config ARCH_K3
 	bool "Texas Instruments' K3 Architecture"
+	select BINMAN
 	select SPL
 	select SUPPORT_SPL
 	select FIT
diff --git a/arch/arm/mach-k3/am62ax/Kconfig b/arch/arm/mach-k3/am62ax/Kconfig
index 6f6ac35c1d8..151fc6b592e 100644
--- a/arch/arm/mach-k3/am62ax/Kconfig
+++ b/arch/arm/mach-k3/am62ax/Kconfig
@@ -12,7 +12,6 @@ choice
 config TARGET_AM62A7_A53_EVM
 	bool "TI K3 based AM62A7 EVM running on A53"
 	select ARM64
-	select BINMAN
 	select OF_SYSTEM_SETUP
 	imply TI_I2C_BOARD_DETECT
 
@@ -24,14 +23,12 @@ config TARGET_AM62A7_R5_EVM
 	select RAM
 	select SPL_RAM
 	select K3_DDRSS
-	select BINMAN
 	imply SYS_K3_SPL_ATF
 	imply TI_I2C_BOARD_DETECT
 
 config TARGET_PHYCORE_AM62AX_A53
 	bool "PHYTEC phyCORE-AM62Ax running on A53"
 	select ARM64
-	select BINMAN
 	select OF_SYSTEM_SETUP
 	imply OF_UPSTREAM
 	imply BOARD
@@ -45,7 +42,6 @@ config TARGET_PHYCORE_AM62AX_R5
 	select RAM
 	select SPL_RAM
 	select K3_DDRSS
-	select BINMAN
 	imply SYS_K3_SPL_ATF
 
 endchoice
diff --git a/arch/arm/mach-k3/am62px/Kconfig b/arch/arm/mach-k3/am62px/Kconfig
index 76ae86b6622..cd23740d7bc 100644
--- a/arch/arm/mach-k3/am62px/Kconfig
+++ b/arch/arm/mach-k3/am62px/Kconfig
@@ -12,7 +12,6 @@ choice
 config TARGET_AM62P5_A53_EVM
 	bool "TI K3 based AM62P5 EVM running on A53"
 	select ARM64
-	select BINMAN
 	select OF_SYSTEM_SETUP
 
 config TARGET_AM62P5_R5_EVM
@@ -23,7 +22,6 @@ config TARGET_AM62P5_R5_EVM
 	select RAM
 	select SPL_RAM
 	select K3_DDRSS
-	select BINMAN
 	imply SYS_K3_SPL_ATF
 
 endchoice
diff --git a/arch/arm/mach-k3/am62x/Kconfig b/arch/arm/mach-k3/am62x/Kconfig
index 81199ada3a1..0f16cfa8b92 100644
--- a/arch/arm/mach-k3/am62x/Kconfig
+++ b/arch/arm/mach-k3/am62x/Kconfig
@@ -12,7 +12,6 @@ choice
 config TARGET_AM625_A53_EVM
 	bool "TI K3 based AM625 EVM running on A53"
 	select ARM64
-	select BINMAN
 	select OF_SYSTEM_SETUP
 
 config TARGET_AM625_R5_EVM
@@ -23,13 +22,11 @@ config TARGET_AM625_R5_EVM
 	select RAM
 	select SPL_RAM
 	select K3_DDRSS
-	select BINMAN
 	imply SYS_K3_SPL_ATF
 
 config TARGET_PHYCORE_AM62X_A53
 	bool "PHYTEC phyCORE-AM62x running on A53"
 	select ARM64
-	select BINMAN
 	select OF_SYSTEM_SETUP
 	imply OF_UPSTREAM
 
@@ -41,14 +38,12 @@ config TARGET_PHYCORE_AM62X_R5
 	select RAM
 	select SPL_RAM
 	select K3_DDRSS
-	select BINMAN
 	select PHYTEC_K3_DDR_PATCH
 	imply SYS_K3_SPL_ATF
 
 config TARGET_VERDIN_AM62_A53
 	bool "Toradex Verdin AM62 running on A53"
 	select ARM64
-	select BINMAN
 	select OF_SYSTEM_SETUP
 	imply OF_UPSTREAM
 
@@ -60,7 +55,6 @@ config TARGET_VERDIN_AM62_R5
 	select RAM
 	select SPL_RAM
 	select K3_DDRSS
-	select BINMAN
 	imply SYS_K3_SPL_ATF
 
 endchoice
diff --git a/arch/arm/mach-k3/am64x/Kconfig b/arch/arm/mach-k3/am64x/Kconfig
index 28691ffb227..4a1cae3d0f2 100644
--- a/arch/arm/mach-k3/am64x/Kconfig
+++ b/arch/arm/mach-k3/am64x/Kconfig
@@ -12,7 +12,6 @@ choice
 config TARGET_AM642_A53_EVM
 	bool "TI K3 based AM642 EVM running on A53"
 	select ARM64
-	select BINMAN
 	imply TI_I2C_BOARD_DETECT
 
 config TARGET_AM642_R5_EVM
@@ -23,14 +22,12 @@ config TARGET_AM642_R5_EVM
 	select RAM
 	select SPL_RAM
 	select K3_DDRSS
-	select BINMAN
 	imply SYS_K3_SPL_ATF
 	imply TI_I2C_BOARD_DETECT
 
 config TARGET_PHYCORE_AM64X_A53
 	bool "PHYTEC phyCORE-AM64x running on A53"
 	select ARM64
-	select BINMAN
 	imply BOARD
 	imply SPL_BOARD
 	imply OF_UPSTREAM
@@ -43,7 +40,6 @@ config TARGET_PHYCORE_AM64X_R5
 	select RAM
 	select SPL_RAM
 	select K3_DDRSS
-	select BINMAN
 	imply SYS_K3_SPL_ATF
 
 endchoice
diff --git a/arch/arm/mach-k3/am65x/Kconfig b/arch/arm/mach-k3/am65x/Kconfig
index 72a8298aebf..e823549b535 100644
--- a/arch/arm/mach-k3/am65x/Kconfig
+++ b/arch/arm/mach-k3/am65x/Kconfig
@@ -14,7 +14,6 @@ config TARGET_AM654_A53_EVM
 	select ARM64
 	select SYS_DISABLE_DCACHE_OPS
 	select BOARD_LATE_INIT
-	select BINMAN
 	imply TI_I2C_BOARD_DETECT
 	select OF_UPSTREAM
 
@@ -24,7 +23,6 @@ config TARGET_AM654_R5_EVM
 	select SYS_THUMB_BUILD
 	select K3_LOAD_SYSFW
 	select K3_AM654_DDRSS
-	select BINMAN
 	imply SYS_K3_SPL_ATF
 	imply TI_I2C_BOARD_DETECT
 
@@ -34,7 +32,6 @@ config TARGET_IOT2050_A53
 	select ARM64
 	select BOARD_LATE_INIT
 	select SYS_DISABLE_DCACHE_OPS
-	select BINMAN
 	help
 	  This builds U-Boot for the IOT2050 devices.
 
diff --git a/arch/arm/mach-k3/j721e/Kconfig b/arch/arm/mach-k3/j721e/Kconfig
index 0761b82b15a..32d5bbfda66 100644
--- a/arch/arm/mach-k3/j721e/Kconfig
+++ b/arch/arm/mach-k3/j721e/Kconfig
@@ -15,7 +15,6 @@ config TARGET_J721E_A72_EVM
 	select BOARD_LATE_INIT
 	imply TI_I2C_BOARD_DETECT
 	select SYS_DISABLE_DCACHE_OPS
-	select BINMAN
 
 config TARGET_J721E_R5_EVM
 	bool "TI K3 based J721E EVM running on R5"
@@ -25,7 +24,6 @@ config TARGET_J721E_R5_EVM
 	select RAM
 	select SPL_RAM
 	select K3_DDRSS
-	select BINMAN
 	imply SYS_K3_SPL_ATF
 	imply TI_I2C_BOARD_DETECT
 
@@ -36,7 +34,6 @@ config TARGET_J7200_A72_EVM
 	select BOARD_LATE_INIT
 	imply TI_I2C_BOARD_DETECT
 	select SYS_DISABLE_DCACHE_OPS
-	select BINMAN
 
 config TARGET_J7200_R5_EVM
 	bool "TI K3 based J7200 EVM running on R5"
@@ -46,7 +43,6 @@ config TARGET_J7200_R5_EVM
 	select RAM
 	select SPL_RAM
 	select K3_DDRSS
-	select BINMAN
 	imply SYS_K3_SPL_ATF
 	imply TI_I2C_BOARD_DETECT
 
diff --git a/arch/arm/mach-k3/j721s2/Kconfig b/arch/arm/mach-k3/j721s2/Kconfig
index 8b54c0401b6..4872166fefd 100644
--- a/arch/arm/mach-k3/j721s2/Kconfig
+++ b/arch/arm/mach-k3/j721s2/Kconfig
@@ -15,7 +15,6 @@ config TARGET_J721S2_A72_EVM
 	select BOARD_LATE_INIT
 	imply TI_I2C_BOARD_DETECT
 	select SYS_DISABLE_DCACHE_OPS
-	select BINMAN
 
 config TARGET_J721S2_R5_EVM
 	bool "TI K3 based J721S2 EVM running on R5"
@@ -25,7 +24,6 @@ config TARGET_J721S2_R5_EVM
 	select RAM
 	select SPL_RAM
 	select K3_DDRSS
-	select BINMAN
 	imply SYS_K3_SPL_ATF
 	imply TI_I2C_BOARD_DETECT
 
diff --git a/arch/arm/mach-k3/j722s/Kconfig b/arch/arm/mach-k3/j722s/Kconfig
index 39d38ea5cf5..ce63168187e 100644
--- a/arch/arm/mach-k3/j722s/Kconfig
+++ b/arch/arm/mach-k3/j722s/Kconfig
@@ -12,7 +12,6 @@ choice
 config TARGET_J722S_A53_EVM
 	bool "TI K3 based J722S EVM running on A53"
 	select ARM64
-	select BINMAN
 	select OF_SYSTEM_SETUP
 
 config TARGET_J722S_R5_EVM
@@ -23,7 +22,6 @@ config TARGET_J722S_R5_EVM
 	select RAM
 	select SPL_RAM
 	select K3_DDRSS
-	select BINMAN
 	imply SYS_K3_SPL_ATF
 
 endchoice
diff --git a/arch/arm/mach-k3/j784s4/Kconfig b/arch/arm/mach-k3/j784s4/Kconfig
index 1eadfb346a3..c6a3689ce08 100644
--- a/arch/arm/mach-k3/j784s4/Kconfig
+++ b/arch/arm/mach-k3/j784s4/Kconfig
@@ -14,7 +14,6 @@ config TARGET_J784S4_A72_EVM
 	select ARM64
 	select BOARD_LATE_INIT
 	select SYS_DISABLE_DCACHE_OPS
-	select BINMAN
 
 config TARGET_J784S4_R5_EVM
 	bool "TI K3 based J784S4 EVM running on R5"
@@ -24,7 +23,6 @@ config TARGET_J784S4_R5_EVM
 	select RAM
 	select SPL_RAM
 	select K3_DDRSS
-	select BINMAN
 	imply SYS_K3_SPL_ATF
 
 endchoice
diff --git a/board/beagle/beagleboneai64/Kconfig b/board/beagle/beagleboneai64/Kconfig
index 0f21582614d..41f3f02f5c3 100644
--- a/board/beagle/beagleboneai64/Kconfig
+++ b/board/beagle/beagleboneai64/Kconfig
@@ -13,7 +13,6 @@ config TARGET_J721E_A72_BEAGLEBONEAI64
 	bool "BeagleBoard.org J721E BeagleBone AI-64 running on A72"
 	select ARM64
 	select SYS_DISABLE_DCACHE_OPS
-	select BINMAN
 
 config TARGET_J721E_R5_BEAGLEBONEAI64
 	bool "BeagleBoard.org J721E BeagleBone AI-64 running on R5"
@@ -23,7 +22,6 @@ config TARGET_J721E_R5_BEAGLEBONEAI64
 	select RAM
 	select SPL_RAM
 	select K3_DDRSS
-	select BINMAN
 	imply SYS_K3_SPL_ATF
 
 endchoice
diff --git a/board/beagle/beagleplay/Kconfig b/board/beagle/beagleplay/Kconfig
index 592b53e493c..d691a0c5e02 100644
--- a/board/beagle/beagleplay/Kconfig
+++ b/board/beagle/beagleplay/Kconfig
@@ -11,7 +11,6 @@ choice
 config TARGET_AM625_A53_BEAGLEPLAY
 	bool "BeagleBoard.org AM625 BeaglePlay running on A53"
 	select ARM64
-	select BINMAN
 	select OF_SYSTEM_SETUP
 
 config TARGET_AM625_R5_BEAGLEPLAY
@@ -22,7 +21,6 @@ config TARGET_AM625_R5_BEAGLEPLAY
 	select RAM
 	select SPL_RAM
 	select K3_DDRSS
-	select BINMAN
 	imply SYS_K3_SPL_ATF
 
 endchoice
-- 
2.39.2

