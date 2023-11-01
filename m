Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7363C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 20:37:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A686187CEB;
	Wed,  1 Nov 2023 21:35:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qR4mFcM/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B8268707A; Wed,  1 Nov 2023 21:35:50 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AF96876FF
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 21:35:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A1KZbtf044370;
 Wed, 1 Nov 2023 15:35:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698870937;
 bh=dV92vIzu4InSttH9/VIVjoaIAHZ7d8dCj6XNVnXIg3k=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=qR4mFcM/ExGFnc4vW1C/Vg5pBmEnf/8RPxckNAKS99XVJskIhnRExMTonQe5VpHst
 A7zscYr95AlPDQ3N5wNlI8wjxD9i4P4zrhLr1Laqggi6uHPpPsry6jvySkfd1F+x9k
 +vxw+kOX13ulwPOZmZBst/REpdkyjySrVtA8MUyc=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A1KZbig060181
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 1 Nov 2023 15:35:37 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 1
 Nov 2023 15:35:37 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 1 Nov 2023 15:35:37 -0500
Received: from lelv0327.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A1KZWFa089745; 
 Wed, 1 Nov 2023 15:35:37 -0500
From: Andrew Davis <afd@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
 <nm@ti.com>, Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bryan Brattlof <bb@ti.com>, Jan Kiszka <jan.kiszka@siemens.com>, Le Jin
 <le.jin@siemens.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH 7/7] arm: mach-k3: j721s2: Move board selection to mach-k3
Date: Wed, 1 Nov 2023 15:35:30 -0500
Message-ID: <20231101203530.80359-7-afd@ti.com>
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
 arch/arm/mach-k3/Kconfig        |  2 +-
 arch/arm/mach-k3/j721s2/Kconfig | 36 +++++++++++++++++++++++++++++++++
 board/ti/j721s2/Kconfig         | 27 -------------------------
 3 files changed, 37 insertions(+), 28 deletions(-)
 create mode 100644 arch/arm/mach-k3/j721s2/Kconfig

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index cd7dc5140ac..06722faf8b6 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -192,6 +192,6 @@ source "arch/arm/mach-k3/am64x/Kconfig"
 source "arch/arm/mach-k3/am62x/Kconfig"
 source "arch/arm/mach-k3/am62ax/Kconfig"
 source "arch/arm/mach-k3/j721e/Kconfig"
-source "board/ti/j721s2/Kconfig"
+source "arch/arm/mach-k3/j721s2/Kconfig"
 
 endif
diff --git a/arch/arm/mach-k3/j721s2/Kconfig b/arch/arm/mach-k3/j721s2/Kconfig
new file mode 100644
index 00000000000..8b54c0401b6
--- /dev/null
+++ b/arch/arm/mach-k3/j721s2/Kconfig
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+#	Andrew Davis <afd@ti.com>
+
+if SOC_K3_J721S2
+
+choice
+	prompt "K3 J721S2 based boards"
+	optional
+
+config TARGET_J721S2_A72_EVM
+	bool "TI K3 based J721S2 EVM running on A72"
+	select ARM64
+	select BOARD_LATE_INIT
+	imply TI_I2C_BOARD_DETECT
+	select SYS_DISABLE_DCACHE_OPS
+	select BINMAN
+
+config TARGET_J721S2_R5_EVM
+	bool "TI K3 based J721S2 EVM running on R5"
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
+source "board/ti/j721s2/Kconfig"
+
+endif
diff --git a/board/ti/j721s2/Kconfig b/board/ti/j721s2/Kconfig
index a4a5d16ba21..40853a8fd66 100644
--- a/board/ti/j721s2/Kconfig
+++ b/board/ti/j721s2/Kconfig
@@ -3,33 +3,6 @@
 # Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
 #	David Huang <d-huang@ti.com>
 
-choice
-	prompt "K3 J721S2 board"
-	depends on SOC_K3_J721S2
-	optional
-
-config TARGET_J721S2_A72_EVM
-	bool "TI K3 based J721S2 EVM running on A72"
-	select ARM64
-	select BOARD_LATE_INIT
-	imply TI_I2C_BOARD_DETECT
-	select SYS_DISABLE_DCACHE_OPS
-	select BINMAN
-
-config TARGET_J721S2_R5_EVM
-	bool "TI K3 based J721S2 EVM running on R5"
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
 if TARGET_J721S2_A72_EVM
 
 config SYS_BOARD
-- 
2.39.2

