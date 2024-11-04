Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25BFD132C8
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 13:50:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3266E88A0A;
	Mon,  4 Nov 2024 14:50:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6B3D88C75; Mon,  4 Nov 2024 14:50:38 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 9A0E7889D2
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 14:50:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris.paterson2@renesas.com
X-IronPort-AV: E=Sophos;i="6.11,257,1725289200"; d="scan'208";a="227814444"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 04 Nov 2024 22:50:35 +0900
Received: from spl2-146.example.org (unknown [10.24.1.209])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 446BE41AA3D5;
 Mon,  4 Nov 2024 22:50:26 +0900 (JST)
From: Chris Paterson <chris.paterson2@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>, Tom Rini <trini@konsulko.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 u-boot@lists.denx.de, Chris Paterson <chris.paterson2@renesas.com>
Subject: [PATCH 2/2] board: hoperun: Switch to use complete DTS files from
 upstream DTS
Date: Mon,  4 Nov 2024 13:50:12 +0000
Message-ID: <20241104135012.45814-3-chris.paterson2@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104135012.45814-1-chris.paterson2@renesas.com>
References: <20241104135012.45814-1-chris.paterson2@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

For upstream Linux kernel we use below DTBs for HiHope boards:
- r8a774a1-hihope-rzg2m-ex.dtb
- r8a774e1-hihope-rzg2h-ex.dtb
- r8a774b1-hihope-rzg2n-ex.dtb

Update the CONFIG_OF_LIST to match the above. Now that we have switched
upstream DTS, drop deleting the nodes and also rename the
r8a774*-u-boot.dtsi files to r8a774*-ex-u-boot.dtsi to match the OF_LIST
files so that the `bootph-all` property gets applied to required nodes
in upstream DTS.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 .../dts/r8a774a1-hihope-rzg2m-ex-u-boot.dtsi  |  8 ++++
 .../arm/dts/r8a774a1-hihope-rzg2m-u-boot.dtsi | 26 -----------
 arch/arm/dts/r8a774a1-u-boot.dtsi             | 42 -----------------
 .../dts/r8a774b1-hihope-rzg2n-ex-u-boot.dtsi  |  8 ++++
 .../arm/dts/r8a774b1-hihope-rzg2n-u-boot.dtsi | 26 -----------
 arch/arm/dts/r8a774b1-u-boot.dtsi             | 40 ----------------
 .../dts/r8a774e1-hihope-rzg2h-ex-u-boot.dtsi  |  8 ++++
 .../arm/dts/r8a774e1-hihope-rzg2h-u-boot.dtsi | 26 -----------
 arch/arm/dts/r8a774e1-u-boot.dtsi             | 46 -------------------
 board/hoperun/hihope-rzg2/hihope-rzg2.c       |  6 +--
 configs/hihope_rzg2_defconfig                 |  8 ++--
 11 files changed, 31 insertions(+), 213 deletions(-)
 create mode 100644 arch/arm/dts/r8a774a1-hihope-rzg2m-ex-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a774a1-hihope-rzg2m-u-boot.dtsi
 create mode 100644 arch/arm/dts/r8a774b1-hihope-rzg2n-ex-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a774b1-hihope-rzg2n-u-boot.dtsi
 create mode 100644 arch/arm/dts/r8a774e1-hihope-rzg2h-ex-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a774e1-hihope-rzg2h-u-boot.dtsi

diff --git a/arch/arm/dts/r8a774a1-hihope-rzg2m-ex-u-boot.dtsi b/arch/arm/dts/r8a774a1-hihope-rzg2m-ex-u-boot.dtsi
new file mode 100644
index 000000000000..dd5a208cc1b4
--- /dev/null
+++ b/arch/arm/dts/r8a774a1-hihope-rzg2m-ex-u-boot.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source extras for U-Boot for the Hihope RZ/G2M board
+ *
+ * Copyright (C) 2021-2024 Renesas Electronics Corporation
+ */
+
+#include "r8a774a1-u-boot.dtsi"
diff --git a/arch/arm/dts/r8a774a1-hihope-rzg2m-u-boot.dtsi b/arch/arm/dts/r8a774a1-hihope-rzg2m-u-boot.dtsi
deleted file mode 100644
index 3ad619bdb90a..000000000000
--- a/arch/arm/dts/r8a774a1-hihope-rzg2m-u-boot.dtsi
+++ /dev/null
@@ -1,26 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source extras for U-Boot for the Hihope RZ/G2M board
- *
- * Copyright (C) 2021 Renesas Electronics Corporation
- */
-
-#include "r8a774a1-u-boot.dtsi"
-
-&gpio3 {
-	bt_reg_on{
-		gpio-hog;
-		gpios = <13 GPIO_ACTIVE_HIGH>;
-		output-low;
-		line-name = "bt-reg-on";
-	};
-};
-
-&gpio4 {
-	wlan_reg_on{
-		gpio-hog;
-		gpios = <6 GPIO_ACTIVE_HIGH>;
-		output-low;
-		line-name = "wlan-reg-on";
-	};
-};
diff --git a/arch/arm/dts/r8a774a1-u-boot.dtsi b/arch/arm/dts/r8a774a1-u-boot.dtsi
index 38f5bfe85fca..3530eeb27183 100644
--- a/arch/arm/dts/r8a774a1-u-boot.dtsi
+++ b/arch/arm/dts/r8a774a1-u-boot.dtsi
@@ -10,45 +10,3 @@
 &extalr_clk {
 	bootph-all;
 };
-
-/delete-node/ &audma0;
-/delete-node/ &audma1;
-/delete-node/ &can0;
-/delete-node/ &can1;
-/delete-node/ &canfd;
-/delete-node/ &csi20;
-/delete-node/ &csi40;
-/delete-node/ &du;
-/delete-node/ &fcpf0;
-/delete-node/ &fcpvb0;
-/delete-node/ &fcpvd0;
-/delete-node/ &fcpvd1;
-/delete-node/ &fcpvd2;
-/delete-node/ &fcpvi0;
-/delete-node/ &hdmi0;
-/delete-node/ &lvds0;
-/delete-node/ &rcar_sound;
-/delete-node/ &sound_card;
-/delete-node/ &vin0;
-/delete-node/ &vin1;
-/delete-node/ &vin2;
-/delete-node/ &vin3;
-/delete-node/ &vin4;
-/delete-node/ &vin5;
-/delete-node/ &vin6;
-/delete-node/ &vin7;
-/delete-node/ &vspb;
-/delete-node/ &vspd0;
-/delete-node/ &vspd1;
-/delete-node/ &vspd2;
-/delete-node/ &vspi0;
-
-/ {
-	/delete-node/ hdmi0-out;
-};
-
-/ {
-	soc {
-		/delete-node/ fdp1@fe940000;
-	};
-};
diff --git a/arch/arm/dts/r8a774b1-hihope-rzg2n-ex-u-boot.dtsi b/arch/arm/dts/r8a774b1-hihope-rzg2n-ex-u-boot.dtsi
new file mode 100644
index 000000000000..b378cabb22c7
--- /dev/null
+++ b/arch/arm/dts/r8a774b1-hihope-rzg2n-ex-u-boot.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source extras for U-Boot for the Hihope RZ/G2N board
+ *
+ * Copyright (C) 2021-2024 Renesas Electronics Corp.
+ */
+
+#include "r8a774b1-u-boot.dtsi"
diff --git a/arch/arm/dts/r8a774b1-hihope-rzg2n-u-boot.dtsi b/arch/arm/dts/r8a774b1-hihope-rzg2n-u-boot.dtsi
deleted file mode 100644
index 6f2f6c71c2f4..000000000000
--- a/arch/arm/dts/r8a774b1-hihope-rzg2n-u-boot.dtsi
+++ /dev/null
@@ -1,26 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source extras for U-Boot for the Hihope RZ/G2N board
- *
- * Copyright (C) 2021 Renesas Electronics Corp.
- */
-
-#include "r8a774b1-u-boot.dtsi"
-
-&gpio3 {
-	bt_reg_on{
-		gpio-hog;
-		gpios = <13 GPIO_ACTIVE_HIGH>;
-		output-low;
-		line-name = "bt-reg-on";
-	};
-};
-
-&gpio4 {
-	wlan_reg_on{
-		gpio-hog;
-		gpios = <6 GPIO_ACTIVE_HIGH>;
-		output-low;
-		line-name = "wlan-reg-on";
-	};
-};
diff --git a/arch/arm/dts/r8a774b1-u-boot.dtsi b/arch/arm/dts/r8a774b1-u-boot.dtsi
index d4890ebc298e..07aeabc46b4a 100644
--- a/arch/arm/dts/r8a774b1-u-boot.dtsi
+++ b/arch/arm/dts/r8a774b1-u-boot.dtsi
@@ -10,43 +10,3 @@
 &extalr_clk {
 	bootph-all;
 };
-
-/delete-node/ &audma0;
-/delete-node/ &audma1;
-/delete-node/ &can0;
-/delete-node/ &can1;
-/delete-node/ &canfd;
-/delete-node/ &csi20;
-/delete-node/ &csi40;
-/delete-node/ &du;
-/delete-node/ &fcpf0;
-/delete-node/ &fcpvb0;
-/delete-node/ &fcpvd0;
-/delete-node/ &fcpvd1;
-/delete-node/ &fcpvi0;
-/delete-node/ &hdmi0;
-/delete-node/ &lvds0;
-/delete-node/ &rcar_sound;
-/delete-node/ &sound_card;
-/delete-node/ &vin0;
-/delete-node/ &vin1;
-/delete-node/ &vin2;
-/delete-node/ &vin3;
-/delete-node/ &vin4;
-/delete-node/ &vin5;
-/delete-node/ &vin6;
-/delete-node/ &vin7;
-/delete-node/ &vspb;
-/delete-node/ &vspd0;
-/delete-node/ &vspd1;
-/delete-node/ &vspi0;
-
-/ {
-	/delete-node/ hdmi0-out;
-};
-
-/ {
-	soc {
-		/delete-node/ fdp1@fe940000;
-	};
-};
diff --git a/arch/arm/dts/r8a774e1-hihope-rzg2h-ex-u-boot.dtsi b/arch/arm/dts/r8a774e1-hihope-rzg2h-ex-u-boot.dtsi
new file mode 100644
index 000000000000..560bea46ad7d
--- /dev/null
+++ b/arch/arm/dts/r8a774e1-hihope-rzg2h-ex-u-boot.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source extras for U-Boot for the Hihope RZ/G2H board
+ *
+ * Copyright (C) 2020-2024 Renesas Electronics Corp.
+ */
+
+#include "r8a774e1-u-boot.dtsi"
diff --git a/arch/arm/dts/r8a774e1-hihope-rzg2h-u-boot.dtsi b/arch/arm/dts/r8a774e1-hihope-rzg2h-u-boot.dtsi
deleted file mode 100644
index 8e57e03c899b..000000000000
--- a/arch/arm/dts/r8a774e1-hihope-rzg2h-u-boot.dtsi
+++ /dev/null
@@ -1,26 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source extras for U-Boot for the Hihope RZ/G2H board
- *
- * Copyright (C) 2020 Renesas Electronics Corp.
- */
-
-#include "r8a774e1-u-boot.dtsi"
-
-&gpio3 {
-	bt_reg_on{
-		gpio-hog;
-		gpios = <13 GPIO_ACTIVE_HIGH>;
-		output-low;
-		line-name = "bt-reg-on";
-	};
-};
-
-&gpio4 {
-	wlan_reg_on{
-		gpio-hog;
-		gpios = <6 GPIO_ACTIVE_HIGH>;
-		output-low;
-		line-name = "wlan-reg-on";
-	};
-};
diff --git a/arch/arm/dts/r8a774e1-u-boot.dtsi b/arch/arm/dts/r8a774e1-u-boot.dtsi
index 45ef5b782409..2202731ccb34 100644
--- a/arch/arm/dts/r8a774e1-u-boot.dtsi
+++ b/arch/arm/dts/r8a774e1-u-boot.dtsi
@@ -10,49 +10,3 @@
 &extalr_clk {
 	bootph-all;
 };
-
-/delete-node/ &audma0;
-/delete-node/ &audma1;
-/delete-node/ &can0;
-/delete-node/ &can1;
-/delete-node/ &canfd;
-/delete-node/ &csi20;
-/delete-node/ &csi40;
-/delete-node/ &du;
-/delete-node/ &fcpf0;
-/delete-node/ &fcpf1;
-/delete-node/ &fcpvb0;
-/delete-node/ &fcpvb1;
-/delete-node/ &fcpvd0;
-/delete-node/ &fcpvd1;
-/delete-node/ &fcpvi0;
-/delete-node/ &fcpvi1;
-/delete-node/ &hdmi0;
-/delete-node/ &lvds0;
-/delete-node/ &rcar_sound;
-/delete-node/ &sound_card;
-/delete-node/ &vin0;
-/delete-node/ &vin1;
-/delete-node/ &vin2;
-/delete-node/ &vin3;
-/delete-node/ &vin4;
-/delete-node/ &vin5;
-/delete-node/ &vin6;
-/delete-node/ &vin7;
-/delete-node/ &vspbc;
-/delete-node/ &vspbd;
-/delete-node/ &vspd0;
-/delete-node/ &vspd1;
-/delete-node/ &vspi0;
-/delete-node/ &vspi1;
-
-/ {
-	/delete-node/ hdmi0-out;
-};
-
-/ {
-	soc {
-		/delete-node/ fdp1@fe940000;
-		/delete-node/ fdp1@fe944000;
-	};
-};
diff --git a/board/hoperun/hihope-rzg2/hihope-rzg2.c b/board/hoperun/hihope-rzg2/hihope-rzg2.c
index 0966e257464a..8b635ef71aca 100644
--- a/board/hoperun/hihope-rzg2/hihope-rzg2.c
+++ b/board/hoperun/hihope-rzg2/hihope-rzg2.c
@@ -96,15 +96,15 @@ static bool is_hoperun_hihope_rzg2_board(const char *board_name)
 int board_fit_config_name_match(const char *name)
 {
 	if (is_hoperun_hihope_rzg2_board("hoperun,hihope-rzg2m") &&
-	    !strcmp(name, "r8a774a1-hihope-rzg2m-u-boot"))
+	    !strcmp(name, "r8a774a1-hihope-rzg2m-ex"))
 		return 0;
 
 	if (is_hoperun_hihope_rzg2_board("hoperun,hihope-rzg2n") &&
-	    !strcmp(name, "r8a774b1-hihope-rzg2n-u-boot"))
+	    !strcmp(name, "r8a774b1-hihope-rzg2n-ex"))
 		return 0;
 
 	if (is_hoperun_hihope_rzg2_board("hoperun,hihope-rzg2h") &&
-	    !strcmp(name, "r8a774e1-hihope-rzg2h-u-boot"))
+	    !strcmp(name, "r8a774e1-hihope-rzg2h-ex"))
 		return 0;
 
 	return -1;
diff --git a/configs/hihope_rzg2_defconfig b/configs/hihope_rzg2_defconfig
index f51660300c6b..c9753e136577 100644
--- a/configs/hihope_rzg2_defconfig
+++ b/configs/hihope_rzg2_defconfig
@@ -8,18 +8,18 @@ CONFIG_ARCH_CPU_INIT=y
 CONFIG_TEXT_BASE=0x50000000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFE0000
-CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a774a1-hihope-rzg2m"
+CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a774a1-hihope-rzg2m-ex"
 CONFIG_TARGET_HIHOPE_RZG2=y
 # CONFIG_SPL is not set
 CONFIG_USE_BOOTARGS=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="tftp 0x48080000 Image; tftp 0x48000000 Image-r8a774a1-hihope-rzg2m.dtb; booti 0x48080000 - 0x48000000"
-CONFIG_DEFAULT_FDT_FILE="r8a774a1-hihope-rzg2m.dtb"
+CONFIG_BOOTCOMMAND="tftp 0x48080000 Image; tftp 0x48000000 Image-r8a774a1-hihope-rzg2m-ex.dtb; booti 0x48080000 - 0x48000000"
+CONFIG_DEFAULT_FDT_FILE="r8a774a1-hihope-rzg2m-ex.dtb"
 # CONFIG_BOARD_EARLY_INIT_F is not set
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PART=y
 CONFIG_CMD_USB=y
-CONFIG_OF_LIST="renesas/r8a774a1-hihope-rzg2m renesas/r8a774b1-hihope-rzg2n renesas/r8a774e1-hihope-rzg2h"
+CONFIG_OF_LIST="renesas/r8a774a1-hihope-rzg2m-ex renesas/r8a774b1-hihope-rzg2n-ex renesas/r8a774e1-hihope-rzg2h-ex"
 CONFIG_MULTI_DTB_FIT_LZO=y
 CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
 CONFIG_ENV_IS_IN_MMC=y
-- 
2.43.0

