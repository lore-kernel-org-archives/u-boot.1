Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9925AC5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 15:32:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C88660732;
	Mon, 17 Aug 2026 15:32:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OqZ9nvMPKkss; Mon, 17 Aug 2026 15:32:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BEA126079A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786980745;
	bh=8e8hTeFcq2/AxhzOwBcMw/x2U50YieT0jA2YGy8T9n4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dx2895LoitVJrwCen3fKyMpZ2QrRoci4ljyudMT18lZ81UsIJXL1pT6Ju3+BXjfiR
	 1wpox6uCmEO4IxaLAW20z8AwkcIgQ7f7EzRT9OvmaWoImrMMkH1y1lOFiRV52WMjqL
	 rs3PLnzR6znieY/WOSJ7dY6stMJgWC/cbHWBhQNphA45KIPowpAKNO/5seyhQk+Idh
	 RoRCLbUKuHxyWRbd0fRhLr4o9oJ2LOOUtc7z+YM2sKQ04BbPoqmv4ycd6rg7aF/lb3
	 s52cYrt/RMn0m0fXcbmC1qDkvNvt1LmWVsta/nlKzh0qZl/tDNNgKIfEzMTwBmOGgl
	 MHNzio3G7bWKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BEA126079A;
	Mon, 17 Aug 2026 15:32:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0BBA3194
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:32:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F1E4B40105
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:32:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UM2xTlV4jVQ0 for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 15:32:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9B04A40130
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9B04A40130
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=dPimPt4R
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9B04A40130
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:32:22 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id D22F4B0055A;
 Mon, 17 Aug 2026 17:32:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1786980739;
 bh=vRjoXbKAv8mQ6rQk3HrCWlneCK80qitQOpQPP6rpNZA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dPimPt4RSq1/f65UymmdHCyvB8D96LyamAsxoPHyDf5d9GaZHtxRr8QtWGoxdfiwp
 +YrnV+p+TZxkxNbuoxs7Oj4TeKpT/BRGuSMjy7sMAZHml5JeqMwkNLM8vNlBlZ8vWT
 BHrKdLcq/J7WVkH0PCMktCeUOfl2WLQdQhf94ISfdPmZdSwRtDMvKZpYXjwmk5EpTY
 8oM7f3N1sI/f5quQRkL6fmrRnRAGwPWW5xxA8lyD9HNk9aY7SE6/YR1q/rQ3okS4CM
 t+JLbweinNuISENCPBBlyvICNno4Y32hEJZmJWAerYsVlBvaJaXrgJHHh6x1Qpgyd7
 K7AFoIjwX3D2Q==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Wasim Khan <wasim.khan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 01/23] board: nxp: add Nodebox v3 CPU Module (LX2160A) base
 port
Date: Mon, 17 Aug 2026 17:31:19 +0200
Message-ID: <20260817153144.1951036-2-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817153144.1951036-1-vjardin@free.fr>
References: <20260817153144.1951036-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Introduce TARGET_NBXV3 for the Free Mobile Nodebox v3 CPU Module, an
LX2160A based platform.

eth_nbxv3.c renames the DPAA2 Ethernet devices from a "u-boot,nickname"
DT property (EVT_DM_PRE_PROBE spy) to something more user explicit.

Currently the CONFIG_ID_EEPROM is not set since the NXP format is not
used on this board.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

 arch/arm/Kconfig                    | 12 ++++++
 arch/arm/dts/Makefile               |  1 +
 arch/arm/dts/fsl-lx2160a-nbxv3.dts  | 16 +++++++
 board/nxp/lx2160a/Kconfig           | 21 +++++++++
 board/nxp/lx2160a/MAINTAINERS       |  8 ++++
 board/nxp/lx2160a/Makefile          |  1 +
 board/nxp/lx2160a/nbxv3/Makefile    |  5 +++
 board/nxp/lx2160a/nbxv3/eth_nbxv3.c | 67 +++++++++++++++++++++++++++++
 configs/nbxv3_tfa_defconfig         | 38 ++++++++++++++++
 include/configs/nbxv3.h             | 13 ++++++
 10 files changed, 182 insertions(+)
 create mode 100644 arch/arm/dts/fsl-lx2160a-nbxv3.dts
 create mode 100644 board/nxp/lx2160a/nbxv3/Makefile
 create mode 100644 board/nxp/lx2160a/nbxv3/eth_nbxv3.c
 create mode 100644 configs/nbxv3_tfa_defconfig
 create mode 100644 include/configs/nbxv3.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1b474a346bf..fe4045548b1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1572,6 +1572,18 @@ config TARGET_LX2162AQDS
 	  Support for NXP LX2162AQDS platform.
 	  The lx2162aqds support is based on LX2160A Layerscape Architecture processor.
 
+config TARGET_NBXV3
+	bool "Support Nodebox v3 CPU Module (LX2160A)"
+	select ARCH_LX2160A
+	select ARM64
+	select ARMV8_MULTIENTRY
+	select ARCH_SUPPORT_TFABOOT
+	select BOARD_LATE_INIT
+	select GPIO_EXTRA_HEADER
+	help
+	  Support for the Free Mobile Nodebox v3 CPU Module, an LX2160A
+	  based platform.
+
 config TARGET_HIKEY
 	bool "Support HiKey 96boards Consumer Edition Platform"
 	select ARM64
diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index a02dad22f27..a1b4e283584 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -470,6 +470,7 @@ dtb-$(CONFIG_FSL_LSCH3) += fsl-ls2080a-qds.dtb \
 	fsl-ls1028a-qds-duart.dtb \
 	fsl-ls1028a-qds-lpuart.dtb \
 	fsl-lx2160a-rdb.dtb \
+	fsl-lx2160a-nbxv3.dtb \
 	fsl-lx2160a-qds.dtb \
 	fsl-lx2160a-qds-3-x-x.dtb \
 	fsl-lx2160a-qds-3-11-x.dtb \
diff --git a/arch/arm/dts/fsl-lx2160a-nbxv3.dts b/arch/arm/dts/fsl-lx2160a-nbxv3.dts
new file mode 100644
index 00000000000..32f0c207a59
--- /dev/null
+++ b/arch/arm/dts/fsl-lx2160a-nbxv3.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR X11
+/*
+ * Copyright 2026 Free Mobile - Vincent Jardin
+ *
+ * Nodebox v3 CPU Module (LX2160A). Base port; no peripheral
+ * controllers enabled.
+ */
+
+/dts-v1/;
+
+#include "fsl-lx2160a.dtsi"
+
+/ {
+	model = "Free Mobile Nodebox v3 CPU Module (LX2160A)";
+	compatible = "freemobile,nbxv3", "fsl,lx2160a";
+};
diff --git a/board/nxp/lx2160a/Kconfig b/board/nxp/lx2160a/Kconfig
index 5764c83ab08..37e8f7ff717 100644
--- a/board/nxp/lx2160a/Kconfig
+++ b/board/nxp/lx2160a/Kconfig
@@ -45,3 +45,24 @@ config SYS_CONFIG_NAME
 	default "lx2162aqds"
 
 endif
+
+if TARGET_NBXV3
+
+config SYS_BOARD
+	default "lx2160a"
+
+config SYS_VENDOR
+	default "nxp"
+
+config SYS_SOC
+	default "fsl-layerscape"
+
+config SYS_CONFIG_NAME
+	default "nbxv3"
+
+config NBXV3_DM_EVENT
+	bool
+	default y
+	select DM_EVENT
+
+endif
diff --git a/board/nxp/lx2160a/MAINTAINERS b/board/nxp/lx2160a/MAINTAINERS
index abdac1372d2..6f78e6e45d1 100644
--- a/board/nxp/lx2160a/MAINTAINERS
+++ b/board/nxp/lx2160a/MAINTAINERS
@@ -53,3 +53,11 @@ LX2162AQDS_VERIFIED_BOOT BOARD
 M:	Manish Tomar <Manish.Tomar@nxp.com>
 S:	Maintained
 F:	configs/lx2162aqds_tfa_verified_boot_defconfig
+
+NBXV3 BOARD
+M:	Vincent Jardin <vjardin@free.fr>
+S:	Maintained
+F:	board/nxp/lx2160a/nbxv3/
+F:	include/configs/nbxv3.h
+F:	configs/nbxv3_tfa_defconfig
+F:	arch/arm/dts/fsl-lx2160a-nbxv3.dts
diff --git a/board/nxp/lx2160a/Makefile b/board/nxp/lx2160a/Makefile
index c9561bfadea..9a617a1f094 100644
--- a/board/nxp/lx2160a/Makefile
+++ b/board/nxp/lx2160a/Makefile
@@ -9,3 +9,4 @@ obj-y += ddr.o
 obj-$(CONFIG_TARGET_LX2160ARDB) += eth_lx2160ardb.o
 obj-$(CONFIG_TARGET_LX2160AQDS) += eth_lx2160aqds.o
 obj-$(CONFIG_TARGET_LX2162AQDS) += eth_lx2162aqds.o
+obj-$(CONFIG_TARGET_NBXV3) += nbxv3/
diff --git a/board/nxp/lx2160a/nbxv3/Makefile b/board/nxp/lx2160a/nbxv3/Makefile
new file mode 100644
index 00000000000..90ef2734eec
--- /dev/null
+++ b/board/nxp/lx2160a/nbxv3/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright 2026 Free Mobile - Vincent Jardin
+#
+
+obj-y += eth_nbxv3.o
diff --git a/board/nxp/lx2160a/nbxv3/eth_nbxv3.c b/board/nxp/lx2160a/nbxv3/eth_nbxv3.c
new file mode 100644
index 00000000000..eb91d47add5
--- /dev/null
+++ b/board/nxp/lx2160a/nbxv3/eth_nbxv3.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 Free Mobile - Vincent Jardin
+ *
+ * Nodebox v3 CPU Module Ethernet wiring.
+ *
+ * For all the boards, there are 3 mainly usable ethernet ports:
+ *   - DPMAC17 to RGMII1 to Realtek RTL8211FD-CG, which is the main
+ *     management port
+ *   - DPMAC13 to USXGMII13 to LAN8023 port (ptp0)
+ *   - DPMAC14 to USXGMII14 to LAN8023 port (ptp1)
+ *   - Some carrier boards may enable some SGMII ports too
+ */
+
+#include <dm.h>
+#include <dm/device.h>
+#include <dm/ofnode.h>
+#include <dm/uclass.h>
+#include <event.h>
+#include <netdev.h>
+#include <exports.h>
+#include <fsl-mc/fsl_mc.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int board_eth_init(struct bd_info *bis)
+{
+	return 0;
+}
+
+#if defined(CONFIG_RESET_PHY_R)
+void reset_phy(void)
+{
+#if defined(CONFIG_FSL_MC_ENET)
+	mc_env_boot();
+#endif
+}
+#endif /* CONFIG_RESET_PHY_R */
+
+/*
+ * Enforce the per DPMAC u-boot,nickname DT property as the U-Boot device
+ * name, so `dm tree` and `setenv ethact ...` show role based names
+ * (lanconsole0, ptp0, ptp1) instead of the auto generated
+ * DPMAC<n>@<phy-mode> string from drivers/net/ldpaa_eth/ldpaa_eth.c.
+ *
+ * It is triggered on EVT_DM_PRE_PROBE (not POST_PROBE) so the rename lands
+ * before eth_post_probe() in net/eth-uclass.c which would have printed a
+ * "Warning: ... using random MAC address" banner.
+ *
+ * Note: it requires CONFIG_DM_EVENT, which shall be force selected via
+ * NBXV3_DM_EVENT in board/nxp/lx2160a/Kconfig.
+ */
+static int nbxv3_eth_apply_nickname(void *ctx, struct event *event)
+{
+	struct udevice *dev = event->data.dm.dev;
+	const char *nick;
+
+	if (device_get_uclass_id(dev) != UCLASS_ETH)
+		return 0;
+
+	nick = ofnode_read_string(dev_ofnode(dev), "u-boot,nickname");
+	if (!nick)
+		return 0;
+
+	return device_set_name(dev, nick);
+}
+EVENT_SPY_FULL(EVT_DM_PRE_PROBE, nbxv3_eth_apply_nickname);
diff --git a/configs/nbxv3_tfa_defconfig b/configs/nbxv3_tfa_defconfig
new file mode 100644
index 00000000000..86b5b44ec09
--- /dev/null
+++ b/configs/nbxv3_tfa_defconfig
@@ -0,0 +1,38 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_GIC_V3_ITS=y
+CONFIG_TARGET_NBXV3=y
+CONFIG_TFABOOT=y
+CONFIG_TEXT_BASE=0x82000000
+CONFIG_SYS_MALLOC_LEN=0x202000
+CONFIG_SYS_MALLOC_F_LEN=0x6000
+CONFIG_NR_DRAM_BANKS=3
+CONFIG_ENV_SIZE=0x4000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="fsl-lx2160a-nbxv3"
+CONFIG_SYS_MONITOR_LEN=958464
+CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT=y
+CONFIG_SEC_FIRMWARE_ARMV8_PSCI=y
+CONFIG_OF_BOARD_FIXUP=y
+CONFIG_SYS_FSL_NUM_CC_PLLS=4
+CONFIG_REMAKE_ELF=y
+CONFIG_MP=y
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
+# CONFIG_EFI_LOADER is not set
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_SYS_PBSIZE=532
+# CONFIG_ID_EEPROM is not set
+CONFIG_CMDLINE_PS_SUPPORT=y
+CONFIG_CMD_HISTORY=y
+CONFIG_CMD_LOG=y
+CONFIG_OF_CONTROL=y
+CONFIG_DYNAMIC_DDR_CLK_FREQ=y
+CONFIG_DDR_ECC=y
+CONFIG_ECC_INIT_VIA_DDRCONTROLLER=y
+CONFIG_SYS_FSL_DDR_INTLV_256B=y
+CONFIG_DM_I2C=y
+# CONFIG_FSL_MC_ENET is not set
+CONFIG_DM_SERIAL=y
+CONFIG_PL01X_SERIAL=y
+CONFIG_WDT=y
+CONFIG_WDT_SBSA=y
diff --git a/include/configs/nbxv3.h b/include/configs/nbxv3.h
new file mode 100644
index 00000000000..6ed86639a3c
--- /dev/null
+++ b/include/configs/nbxv3.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2026 Free Mobile - Vincent Jardin
+ *
+ * Nodebox v3 CPU Module config header.
+ */
+
+#ifndef __NBXV3_H
+#define __NBXV3_H
+
+#include "lx2160a_common.h"
+
+#endif /* __NBXV3_H */
-- 
2.43.0

