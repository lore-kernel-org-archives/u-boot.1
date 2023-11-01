Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71B0C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 20:36:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2869287753;
	Wed,  1 Nov 2023 21:35:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AS1cHktd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C551A87B35; Wed,  1 Nov 2023 21:35:49 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC87D8771F
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 21:35:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A1KZacI105887;
 Wed, 1 Nov 2023 15:35:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698870936;
 bh=QGgMBRRB1sotP+6BMeqSy4Y3iwM6ltUUeECp1nx5jyU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=AS1cHktdGrBJb7NFPzEhUe8yFa0r2Gr6Sb9NH5tw/5N360EjHJRVjUnwT0ZQtzedz
 BM8tlEK6ZU4/ax+PW0NuW7FmuxPENKnWUXiKXAEoZlI7xd7S/2x9b30BEeQjdSJ0CK
 /0GbqjEErCAvRLv4Lv7R9BjShhLzMfQHvagYpkJk=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A1KZame060167
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 1 Nov 2023 15:35:36 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 1
 Nov 2023 15:35:35 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 1 Nov 2023 15:35:35 -0500
Received: from lelv0327.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A1KZWFY089745; 
 Wed, 1 Nov 2023 15:35:35 -0500
From: Andrew Davis <afd@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
 <nm@ti.com>, Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bryan Brattlof <bb@ti.com>, Jan Kiszka <jan.kiszka@siemens.com>, Le Jin
 <le.jin@siemens.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH 5/7] arm: mach-k3: am62x: Move board selection to mach-k3
Date: Wed, 1 Nov 2023 15:35:28 -0500
Message-ID: <20231101203530.80359-5-afd@ti.com>
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
 arch/arm/mach-k3/Kconfig          |  4 +--
 arch/arm/mach-k3/am62x/Kconfig    | 49 +++++++++++++++++++++++++++++++
 board/ti/am62x/Kconfig            | 23 ---------------
 board/toradex/verdin-am62/Kconfig | 23 ---------------
 4 files changed, 51 insertions(+), 48 deletions(-)
 create mode 100644 arch/arm/mach-k3/am62x/Kconfig

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 7293e3cb4fd..a460952f119 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -189,9 +189,9 @@ config K3_X509_SWRV
 
 source "arch/arm/mach-k3/am65x/Kconfig"
 source "arch/arm/mach-k3/am64x/Kconfig"
-source "board/ti/am62x/Kconfig"
+source "arch/arm/mach-k3/am62x/Kconfig"
 source "board/ti/am62ax/Kconfig"
 source "arch/arm/mach-k3/j721e/Kconfig"
 source "board/ti/j721s2/Kconfig"
-source "board/toradex/verdin-am62/Kconfig"
+
 endif
diff --git a/arch/arm/mach-k3/am62x/Kconfig b/arch/arm/mach-k3/am62x/Kconfig
new file mode 100644
index 00000000000..738065e3310
--- /dev/null
+++ b/arch/arm/mach-k3/am62x/Kconfig
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+#	Andrew Davis <afd@ti.com>
+
+if SOC_K3_AM625
+
+choice
+	prompt "K3 AM62x based boards"
+	optional
+
+config TARGET_AM625_A53_EVM
+	bool "TI K3 based AM625 EVM running on A53"
+	select ARM64
+	select BINMAN
+
+config TARGET_AM625_R5_EVM
+	bool "TI K3 based AM625 EVM running on R5"
+	select CPU_V7R
+	select SYS_THUMB_BUILD
+	select K3_LOAD_SYSFW
+	select RAM
+	select SPL_RAM
+	select K3_DDRSS
+	select BINMAN
+	imply SYS_K3_SPL_ATF
+
+config TARGET_VERDIN_AM62_A53
+	bool "Toradex Verdin AM62 running on A53"
+	select ARM64
+	select BINMAN
+
+config TARGET_VERDIN_AM62_R5
+	bool "Toradex Verdin AM62 running on R5"
+	select CPU_V7R
+	select SYS_THUMB_BUILD
+	select K3_LOAD_SYSFW
+	select RAM
+	select SPL_RAM
+	select K3_DDRSS
+	select BINMAN
+	imply SYS_K3_SPL_ATF
+
+endchoice
+
+source "board/ti/am62x/Kconfig"
+source "board/toradex/verdin-am62/Kconfig"
+
+endif
diff --git a/board/ti/am62x/Kconfig b/board/ti/am62x/Kconfig
index b4b70337d18..610dacfdc08 100644
--- a/board/ti/am62x/Kconfig
+++ b/board/ti/am62x/Kconfig
@@ -3,29 +3,6 @@
 # Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
 #	Suman Anna <s-anna@ti.com>
 
-choice
-	prompt "TI K3 AM62x based boards"
-	depends on SOC_K3_AM625
-	optional
-
-config TARGET_AM625_A53_EVM
-	bool "TI K3 based AM625 EVM running on A53"
-	select ARM64
-	select BINMAN
-
-config TARGET_AM625_R5_EVM
-	bool "TI K3 based AM625 EVM running on R5"
-	select CPU_V7R
-	select SYS_THUMB_BUILD
-	select K3_LOAD_SYSFW
-	select RAM
-	select SPL_RAM
-	select K3_DDRSS
-	select BINMAN
-	imply SYS_K3_SPL_ATF
-
-endchoice
-
 if TARGET_AM625_A53_EVM
 
 config SYS_BOARD
diff --git a/board/toradex/verdin-am62/Kconfig b/board/toradex/verdin-am62/Kconfig
index abc2984f250..fd65a96b3df 100644
--- a/board/toradex/verdin-am62/Kconfig
+++ b/board/toradex/verdin-am62/Kconfig
@@ -3,29 +3,6 @@
 # Copyright 2023 Toradex
 #
 
-choice
-	prompt "Toradex Verdin AM62 based boards"
-	depends on SOC_K3_AM625
-	optional
-
-config TARGET_VERDIN_AM62_A53
-	bool "Toradex Verdin AM62 running on A53"
-	select ARM64
-	select BINMAN
-
-config TARGET_VERDIN_AM62_R5
-	bool "Toradex Verdin AM62 running on R5"
-	select CPU_V7R
-	select SYS_THUMB_BUILD
-	select K3_LOAD_SYSFW
-	select RAM
-	select SPL_RAM
-	select K3_DDRSS
-	select BINMAN
-	imply SYS_K3_SPL_ATF
-
-endchoice
-
 if TARGET_VERDIN_AM62_A53
 
 config SYS_BOARD
-- 
2.39.2

