Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352CDCDB470
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 06:59:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAF1C849D8;
	Tue, 23 Jun 2026 08:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="AciACm9Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IOpd74CI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2663C849D1; Tue, 23 Jun 2026 08:25:14 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0463D849BD
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 08:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ingo.rah@linutronix.de
From: INgo Rah <ingo.rah@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1782195911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=sekxL5oIOJJuEfaPZl2ejhRwLCZuycdwlhFSYB2ogVE=;
 b=AciACm9YCXN+t7anXp50lszDrcQwi3x5kr2zhsthjPuh1vA76I/Mnu4JpXqUh/PZU4ayM2
 Oi4gwSuBGWGp8Ic0WQK3M9M/XzZ9E6WVpDucQPZACn9NXDFd2eKbmJfO1PD3guBLJkMscG
 an8l24VBRtfs+xeCRk16X/bDfDvI7F4M3q23rlOZuxPyCvp/wLlfpjAHOqNDMkfaeT1Lq0
 4LSqBBmqlDKdoiHPkAKGAEhODfMTaRENVEABoc25D4ImTMhoHUvKb0pIgD8I77bfSTGcn8
 rfqGSNKblLGC/X1lY0cJshQvcSI2CawRhHTjQxekarnywxRJs7ecxa6HmH1OdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1782195911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=sekxL5oIOJJuEfaPZl2ejhRwLCZuycdwlhFSYB2ogVE=;
 b=IOpd74CIc2FtgEpUGhvCufIVUCuStj4P1ywK/CCl982ZC+lQBMAzMpzviBTtD7nlIZU9Bo
 R/0pdpQVZjHbBbBg==
To: u-boot@lists.denx.de
Cc: INgo Rah <ingo.rah@linutronix.de>,
 Benedikt Spranger <b.spranger@linutronix.de>,
 Gregor Herburger <gregor.herburger@linutronix.de>,
 Benjamin Hahn <B.Hahn@phytec.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Teresa Remmet <t.remmet@phytec.de>,
 Tom Rini <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de>,
 Yao Zi <me@ziyao.cc>, upstream@lists.phytec.de
Subject: [PATCH] Board phycore_imx8mm: spl: add 1 and 4GB RAM timings
Date: Tue, 23 Jun 2026 08:24:07 +0200
Message-ID: <20260623062429.532567-1-ingo.rah@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:59:38 +0200
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

The Phytec Tauri L is sold with other memory configurations then 2 GB.
Gather the memory size from the EEPROM of the underlaying PhyCore module
and set timing information accordingly.

Signed-off-by: INgo Rah <ingo.rah@linutronix.de>
Reviewed-by: Benedikt Spranger <b.spranger@linutronix.de>
Reviewed-by: Gregor Herburger <gregor.herburger@linutronix.de>
---
Board phycore_imx8mm: spl: add 1 and 4GB RAM timings
  This patch heavily borrowed code from git://git.phytec.de/u-boot-imx commit
  00ac765d6032 ("BSPIMX8M-2893 board: phycore_imx8mm: spl: add 1 and 4GB RAM
  timings") and commit 93962421d7b4 ("BSPIMX8M-2893 board: phycore_imx8mm:
  spl: add 1 and 4GB RAM timings")

 .../dts/imx8mm-phygate-tauri-l-u-boot.dtsi    |  8 ++++++
 board/phytec/common/imx8m_som_detection.h     |  7 ++++++
 board/phytec/phycore_imx8mm/lpddr4_timing.c   | 25 +++++++++++++++++++
 board/phytec/phycore_imx8mm/lpddr4_timing.h   | 12 +++++++++
 board/phytec/phycore_imx8mm/spl.c             | 24 +++++++++++++++++-
 configs/imx8mm-phygate-tauri-l_defconfig      |  1 +
 6 files changed, 76 insertions(+), 1 deletion(-)
 create mode 100644 board/phytec/phycore_imx8mm/lpddr4_timing.h

diff --git a/arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi b/arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi
index 26361780c01..79ddb1ade44 100644
--- a/arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi
@@ -29,6 +29,10 @@
 	};
 };
 
+&pinctrl_i2c1 {
+	bootph-pre-ram;
+};
+
 &pinctrl_uart3 {
 	bootph-pre-ram;
 };
@@ -73,6 +77,10 @@
 	bootph-pre-ram;
 };
 
+&i2c1 {
+	bootph-pre-ram;
+};
+
 &usdhc2 {
 	bootph-pre-ram;
 };
diff --git a/board/phytec/common/imx8m_som_detection.h b/board/phytec/common/imx8m_som_detection.h
index 0176347414f..794d3add0d5 100644
--- a/board/phytec/common/imx8m_som_detection.h
+++ b/board/phytec/common/imx8m_som_detection.h
@@ -13,6 +13,13 @@
 #define PHYTEC_IMX8MM_SOM       69
 #define PHYTEC_IMX8MP_SOM       70
 
+enum phytec_imx8mm_ddr_eeprom_code {
+	INVALID = PHYTEC_EEPROM_INVAL,
+	PHYTEC_IMX8MM_DDR_1GB = 1,
+	PHYTEC_IMX8MM_DDR_2GB = 3,
+	PHYTEC_IMX8MM_DDR_4GB = 5,
+};
+
 int __maybe_unused phytec_imx8m_detect(struct phytec_eeprom_data *data);
 u8 __maybe_unused phytec_get_imx8m_ddr_size(struct phytec_eeprom_data *data);
 u8 __maybe_unused phytec_get_imx8mp_rtc(struct phytec_eeprom_data *data);
diff --git a/board/phytec/phycore_imx8mm/lpddr4_timing.c b/board/phytec/phycore_imx8mm/lpddr4_timing.c
index f5a2f3268b3..73e35c7c3b9 100644
--- a/board/phytec/phycore_imx8mm/lpddr4_timing.c
+++ b/board/phytec/phycore_imx8mm/lpddr4_timing.c
@@ -1842,3 +1842,28 @@ struct dram_timing_info dram_timing = {
 	.ddrphy_pie_num = ARRAY_SIZE(ddr_phy_pie),
 	.fsp_table = { 3000, 400, 100,},
 };
+
+void set_dram_timings_1gb(void)
+{
+	dram_timing.ddrc_cfg[5].val = 0x2d0087;
+	dram_timing.ddrc_cfg[21].val = 0x8d;
+	dram_timing.ddrc_cfg[42].val = 0xf070707;
+	dram_timing.ddrc_cfg[58].val = 0x60012;
+	dram_timing.ddrc_cfg[73].val = 0x13;
+	dram_timing.ddrc_cfg[83].val = 0x30005;
+	dram_timing.ddrc_cfg[98].val = 0x5;
+}
+
+void set_dram_timings_4gb(void)
+{
+	dram_timing.ddrc_cfg[2].val = 0xa3080020;
+	dram_timing.ddrc_cfg[37].val = 0x17;
+	dram_timing.fsp_msg[0].fsp_cfg[8].val = 0x310;
+	dram_timing.fsp_msg[0].fsp_cfg[20].val = 0x3;
+	dram_timing.fsp_msg[1].fsp_cfg[9].val = 0x310;
+	dram_timing.fsp_msg[1].fsp_cfg[21].val = 0x3;
+	dram_timing.fsp_msg[2].fsp_cfg[9].val = 0x310;
+	dram_timing.fsp_msg[2].fsp_cfg[21].val = 0x3;
+	dram_timing.fsp_msg[3].fsp_cfg[10].val = 0x310;
+	dram_timing.fsp_msg[3].fsp_cfg[22].val = 0x3;
+}
diff --git a/board/phytec/phycore_imx8mm/lpddr4_timing.h b/board/phytec/phycore_imx8mm/lpddr4_timing.h
new file mode 100644
index 00000000000..5334fa5b4ee
--- /dev/null
+++ b/board/phytec/phycore_imx8mm/lpddr4_timing.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ */
+
+#ifndef __LPDDR4_TIMING_H__
+#define __LPDDR4_TIMING_H__
+
+void set_dram_timings_1gb(void);
+void set_dram_timings_4gb(void);
+
+#endif /* __LPDDR4_TIMING_H__ */
diff --git a/board/phytec/phycore_imx8mm/spl.c b/board/phytec/phycore_imx8mm/spl.c
index e688793bc74..c9f2243c819 100644
--- a/board/phytec/phycore_imx8mm/spl.c
+++ b/board/phytec/phycore_imx8mm/spl.c
@@ -16,6 +16,7 @@
 #include <log.h>
 #include <spl.h>
 
+#include "lpddr4_timing.h"
 #include "../common/imx8m_som_detection.h"
 
 #define EEPROM_ADDR		0x51
@@ -42,6 +43,7 @@ int spl_board_boot_device(enum boot_device boot_dev_spl)
 static void spl_dram_init(void)
 {
 	int ret;
+	enum phytec_imx8mm_ddr_eeprom_code size = PHYTEC_EEPROM_INVAL;
 
 	ret = phytec_eeprom_data_setup_fallback(NULL, 0, EEPROM_ADDR,
 			EEPROM_ADDR_FALLBACK);
@@ -49,10 +51,30 @@ static void spl_dram_init(void)
 		goto out;
 
 	ret = phytec_imx8m_detect(NULL);
-	if (!ret)
+	if (!ret) {
 		phytec_print_som_info(NULL);
+		size = phytec_get_imx8m_ddr_size(NULL);
+	}
 
+	switch (size) {
+	case PHYTEC_IMX8MM_DDR_1GB:
+		puts("1 GiB\n");
+		set_dram_timings_1gb();
+		break;
+	case PHYTEC_IMX8MM_DDR_2GB:
+		puts("2 GiB\n");
+		break;
+	case PHYTEC_IMX8MM_DDR_4GB:
+		puts("4 GiB\n");
+		set_dram_timings_4gb();
+		break;
+	default:
+		goto out;
+	}
+	ddr_init(&dram_timing);
+	return;
 out:
+	puts("Could not detect correct RAM size. Fall back to default.\n");
 	ddr_init(&dram_timing);
 }
 
diff --git a/configs/imx8mm-phygate-tauri-l_defconfig b/configs/imx8mm-phygate-tauri-l_defconfig
index e34f12cabf3..866e5d1dbb3 100644
--- a/configs/imx8mm-phygate-tauri-l_defconfig
+++ b/configs/imx8mm-phygate-tauri-l_defconfig
@@ -4,6 +4,7 @@ CONFIG_TEXT_BASE=0x40200000
 CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_PHYTEC_SOM_DETECTION=y
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x3C0000
 CONFIG_DM_GPIO=y
---
base-commit: f072620dc9ffda00b010783da27c41231c3a439b
branch: feature/phygate

-- 
2.47.3

