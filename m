Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B0EC35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 19:30:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9763F81A0E;
	Wed, 19 Mar 2025 20:30:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DpbpMckO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EEF48141E; Wed, 19 Mar 2025 20:30:08 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8116A815D1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 20:30:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52JJU0M6416363
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Mar 2025 14:30:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1742412600;
 bh=tAmlxhAXZV3YXj8GBICHNfos/9ZVP16XurZ2LFXM2A8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=DpbpMckOuyDKpBFIzhroMYKwN2i1Ucgxm/san1HGraH4FnQim8n73GogM9spzzGsL
 l78mWqwlnw3sW9GLL0uB/2poXrofPV9MuvILuqa+AZHYTWIA4iFdhWEjrF1Rshd55D
 +cSvuNhpY8gSB9kc89DfRUhrDUOEzVBeUrpsj0Ew=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52JJU03C002864
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Mar 2025 14:30:00 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Mar 2025 14:29:59 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Mar 2025 14:29:59 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52JJTwwZ025899;
 Wed, 19 Mar 2025 14:29:59 -0500
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH 3/3] arm: mach-k3: Make K3_LOAD_SYSFW and SYS_K3_SPL_ATF
 default enabled
Date: Wed, 19 Mar 2025 14:29:58 -0500
Message-ID: <20250319192958.276563-3-afd@ti.com>
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

These two symbols are always selected by default for R5 builds. These
symbols already depend on R5 builds, so make it default at their
definition to remove select/imply at each board target site.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-k3/am62ax/Kconfig     | 4 ----
 arch/arm/mach-k3/am62px/Kconfig     | 2 --
 arch/arm/mach-k3/am62x/Kconfig      | 6 ------
 arch/arm/mach-k3/am64x/Kconfig      | 4 ----
 arch/arm/mach-k3/am65x/Kconfig      | 2 --
 arch/arm/mach-k3/j721e/Kconfig      | 4 ----
 arch/arm/mach-k3/j721s2/Kconfig     | 2 --
 arch/arm/mach-k3/j722s/Kconfig      | 2 --
 arch/arm/mach-k3/j784s4/Kconfig     | 2 --
 arch/arm/mach-k3/r5/Kconfig         | 2 ++
 board/beagle/beagleboneai64/Kconfig | 2 --
 board/beagle/beagleplay/Kconfig     | 2 --
 12 files changed, 2 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-k3/am62ax/Kconfig b/arch/arm/mach-k3/am62ax/Kconfig
index 151fc6b592e..708c564f8bb 100644
--- a/arch/arm/mach-k3/am62ax/Kconfig
+++ b/arch/arm/mach-k3/am62ax/Kconfig
@@ -19,11 +19,9 @@ config TARGET_AM62A7_R5_EVM
 	bool "TI K3 based AM62A7 EVM running on R5"
 	select CPU_V7R
 	select SYS_THUMB_BUILD
-	select K3_LOAD_SYSFW
 	select RAM
 	select SPL_RAM
 	select K3_DDRSS
-	imply SYS_K3_SPL_ATF
 	imply TI_I2C_BOARD_DETECT
 
 config TARGET_PHYCORE_AM62AX_A53
@@ -38,11 +36,9 @@ config TARGET_PHYCORE_AM62AX_R5
 	bool "PHYTEC phyCORE-AM62Ax running on R5"
 	select CPU_V7R
 	select SYS_THUMB_BUILD
-	select K3_LOAD_SYSFW
 	select RAM
 	select SPL_RAM
 	select K3_DDRSS
-	imply SYS_K3_SPL_ATF
 
 endchoice
 
diff --git a/arch/arm/mach-k3/am62px/Kconfig b/arch/arm/mach-k3/am62px/Kconfig
index cd23740d7bc..c043f961723 100644
--- a/arch/arm/mach-k3/am62px/Kconfig
+++ b/arch/arm/mach-k3/am62px/Kconfig
@@ -18,11 +18,9 @@ config TARGET_AM62P5_R5_EVM
 	bool "TI K3 based AM62P5 EVM running on R5"
 	select CPU_V7R
 	select SYS_THUMB_BUILD
-	select K3_LOAD_SYSFW
 	select RAM
 	select SPL_RAM
 	select K3_DDRSS
-	imply SYS_K3_SPL_ATF
 
 endchoice
 
diff --git a/arch/arm/mach-k3/am62x/Kconfig b/arch/arm/mach-k3/am62x/Kconfig
index 0f16cfa8b92..dab83990824 100644
--- a/arch/arm/mach-k3/am62x/Kconfig
+++ b/arch/arm/mach-k3/am62x/Kconfig
@@ -18,11 +18,9 @@ config TARGET_AM625_R5_EVM
 	bool "TI K3 based AM625 EVM running on R5"
 	select CPU_V7R
 	select SYS_THUMB_BUILD
-	select K3_LOAD_SYSFW
 	select RAM
 	select SPL_RAM
 	select K3_DDRSS
-	imply SYS_K3_SPL_ATF
 
 config TARGET_PHYCORE_AM62X_A53
 	bool "PHYTEC phyCORE-AM62x running on A53"
@@ -34,12 +32,10 @@ config TARGET_PHYCORE_AM62X_R5
 	bool "PHYTEC phyCORE-AM62x running on R5"
 	select CPU_V7R
 	select SYS_THUMB_BUILD
-	select K3_LOAD_SYSFW
 	select RAM
 	select SPL_RAM
 	select K3_DDRSS
 	select PHYTEC_K3_DDR_PATCH
-	imply SYS_K3_SPL_ATF
 
 config TARGET_VERDIN_AM62_A53
 	bool "Toradex Verdin AM62 running on A53"
@@ -51,11 +47,9 @@ config TARGET_VERDIN_AM62_R5
 	bool "Toradex Verdin AM62 running on R5"
 	select CPU_V7R
 	select SYS_THUMB_BUILD
-	select K3_LOAD_SYSFW
 	select RAM
 	select SPL_RAM
 	select K3_DDRSS
-	imply SYS_K3_SPL_ATF
 
 endchoice
 
diff --git a/arch/arm/mach-k3/am64x/Kconfig b/arch/arm/mach-k3/am64x/Kconfig
index 4a1cae3d0f2..06f57a35349 100644
--- a/arch/arm/mach-k3/am64x/Kconfig
+++ b/arch/arm/mach-k3/am64x/Kconfig
@@ -18,11 +18,9 @@ config TARGET_AM642_R5_EVM
 	bool "TI K3 based AM642 EVM running on R5"
 	select CPU_V7R
 	select SYS_THUMB_BUILD
-	select K3_LOAD_SYSFW
 	select RAM
 	select SPL_RAM
 	select K3_DDRSS
-	imply SYS_K3_SPL_ATF
 	imply TI_I2C_BOARD_DETECT
 
 config TARGET_PHYCORE_AM64X_A53
@@ -36,11 +34,9 @@ config TARGET_PHYCORE_AM64X_R5
 	bool "PHYTEC phyCORE-AM64x running on R5"
 	select CPU_V7R
 	select SYS_THUMB_BUILD
-	select K3_LOAD_SYSFW
 	select RAM
 	select SPL_RAM
 	select K3_DDRSS
-	imply SYS_K3_SPL_ATF
 
 endchoice
 
diff --git a/arch/arm/mach-k3/am65x/Kconfig b/arch/arm/mach-k3/am65x/Kconfig
index e823549b535..58b7d15e980 100644
--- a/arch/arm/mach-k3/am65x/Kconfig
+++ b/arch/arm/mach-k3/am65x/Kconfig
@@ -21,9 +21,7 @@ config TARGET_AM654_R5_EVM
 	bool "TI K3 based AM654 EVM running on R5"
 	select CPU_V7R
 	select SYS_THUMB_BUILD
-	select K3_LOAD_SYSFW
 	select K3_AM654_DDRSS
-	imply SYS_K3_SPL_ATF
 	imply TI_I2C_BOARD_DETECT
 
 config TARGET_IOT2050_A53
diff --git a/arch/arm/mach-k3/j721e/Kconfig b/arch/arm/mach-k3/j721e/Kconfig
index 32d5bbfda66..b5785bdff98 100644
--- a/arch/arm/mach-k3/j721e/Kconfig
+++ b/arch/arm/mach-k3/j721e/Kconfig
@@ -20,11 +20,9 @@ config TARGET_J721E_R5_EVM
 	bool "TI K3 based J721E EVM running on R5"
 	select CPU_V7R
 	select SYS_THUMB_BUILD
-	select K3_LOAD_SYSFW
 	select RAM
 	select SPL_RAM
 	select K3_DDRSS
-	imply SYS_K3_SPL_ATF
 	imply TI_I2C_BOARD_DETECT
 
 config TARGET_J7200_A72_EVM
@@ -39,11 +37,9 @@ config TARGET_J7200_R5_EVM
 	bool "TI K3 based J7200 EVM running on R5"
 	select CPU_V7R
 	select SYS_THUMB_BUILD
-	select K3_LOAD_SYSFW
 	select RAM
 	select SPL_RAM
 	select K3_DDRSS
-	imply SYS_K3_SPL_ATF
 	imply TI_I2C_BOARD_DETECT
 
 endchoice
diff --git a/arch/arm/mach-k3/j721s2/Kconfig b/arch/arm/mach-k3/j721s2/Kconfig
index 4872166fefd..fc3ef7f617a 100644
--- a/arch/arm/mach-k3/j721s2/Kconfig
+++ b/arch/arm/mach-k3/j721s2/Kconfig
@@ -20,11 +20,9 @@ config TARGET_J721S2_R5_EVM
 	bool "TI K3 based J721S2 EVM running on R5"
 	select CPU_V7R
 	select SYS_THUMB_BUILD
-	select K3_LOAD_SYSFW
 	select RAM
 	select SPL_RAM
 	select K3_DDRSS
-	imply SYS_K3_SPL_ATF
 	imply TI_I2C_BOARD_DETECT
 
 endchoice
diff --git a/arch/arm/mach-k3/j722s/Kconfig b/arch/arm/mach-k3/j722s/Kconfig
index ce63168187e..59f7403677c 100644
--- a/arch/arm/mach-k3/j722s/Kconfig
+++ b/arch/arm/mach-k3/j722s/Kconfig
@@ -18,11 +18,9 @@ config TARGET_J722S_R5_EVM
 	bool "TI K3 based J722S EVM running on R5"
 	select CPU_V7R
 	select SYS_THUMB_BUILD
-	select K3_LOAD_SYSFW
 	select RAM
 	select SPL_RAM
 	select K3_DDRSS
-	imply SYS_K3_SPL_ATF
 
 endchoice
 
diff --git a/arch/arm/mach-k3/j784s4/Kconfig b/arch/arm/mach-k3/j784s4/Kconfig
index c6a3689ce08..f5973fe06b5 100644
--- a/arch/arm/mach-k3/j784s4/Kconfig
+++ b/arch/arm/mach-k3/j784s4/Kconfig
@@ -19,11 +19,9 @@ config TARGET_J784S4_R5_EVM
 	bool "TI K3 based J784S4 EVM running on R5"
 	select CPU_V7R
 	select SYS_THUMB_BUILD
-	select K3_LOAD_SYSFW
 	select RAM
 	select SPL_RAM
 	select K3_DDRSS
-	imply SYS_K3_SPL_ATF
 
 endchoice
 
diff --git a/arch/arm/mach-k3/r5/Kconfig b/arch/arm/mach-k3/r5/Kconfig
index 12335880e10..45acceefeae 100644
--- a/arch/arm/mach-k3/r5/Kconfig
+++ b/arch/arm/mach-k3/r5/Kconfig
@@ -1,4 +1,5 @@
 config K3_LOAD_SYSFW
+	default y
 	bool
 
 config K3_OPP_LOW
@@ -61,6 +62,7 @@ config K3_SYSFW_IMAGE_SPI_OFFS
 
 config SYS_K3_SPL_ATF
 	bool "Start Cortex-A from SPL"
+	default y
 	help
 	  Enabling this will try to start Cortex-A (typically with ATF)
 	  after SPL from R5.
diff --git a/board/beagle/beagleboneai64/Kconfig b/board/beagle/beagleboneai64/Kconfig
index 41f3f02f5c3..f9a20ed9372 100644
--- a/board/beagle/beagleboneai64/Kconfig
+++ b/board/beagle/beagleboneai64/Kconfig
@@ -18,11 +18,9 @@ config TARGET_J721E_R5_BEAGLEBONEAI64
 	bool "BeagleBoard.org J721E BeagleBone AI-64 running on R5"
 	select CPU_V7R
 	select SYS_THUMB_BUILD
-	select K3_LOAD_SYSFW
 	select RAM
 	select SPL_RAM
 	select K3_DDRSS
-	imply SYS_K3_SPL_ATF
 
 endchoice
 
diff --git a/board/beagle/beagleplay/Kconfig b/board/beagle/beagleplay/Kconfig
index d691a0c5e02..538b5abf480 100644
--- a/board/beagle/beagleplay/Kconfig
+++ b/board/beagle/beagleplay/Kconfig
@@ -17,11 +17,9 @@ config TARGET_AM625_R5_BEAGLEPLAY
 	bool "BeagleBoard.org AM625 BeaglePlay running on R5"
 	select CPU_V7R
 	select SYS_THUMB_BUILD
-	select K3_LOAD_SYSFW
 	select RAM
 	select SPL_RAM
 	select K3_DDRSS
-	imply SYS_K3_SPL_ATF
 
 endchoice
 
-- 
2.39.2

