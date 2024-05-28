Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119E6C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 13:35:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37A1188511;
	Tue, 28 May 2024 15:35:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="LrwVEXWk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABF05884D5; Tue, 28 May 2024 15:35:30 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A9BE884B4
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 15:35:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=T.Remmet@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1716903327; x=1719495327;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PgOr4BMQxJVkpcJ9JAkO31lW5Mmlo0Q3Z1jWVpfpBMk=;
 b=LrwVEXWk4UWLLeol2sBlBm+3ywFBzpFMaxDt86kkw16cNMzlVGGDtHqQW3vh3+4k
 RNnI/N6sh/ldv/tFaVMdw/6GPyxK76pQRtN/SnCDwl7jAP4FlyOFYM5wlHz26ITY
 0w03wP4c92mNk8MTrg2T9VVAyCN6y3IssLaOT/JiOW8=;
X-AuditID: ac14000a-03251700000021bc-27-6655dd9e1621
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 13.E8.08636.E9DD5566;
 Tue, 28 May 2024 15:35:27 +0200 (CEST)
Received: from llp-tremmet2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 28 May
 2024 15:35:26 +0200
From: Teresa Remmet <t.remmet@phytec.de>
To: <u-boot@lists.denx.de>
CC: Yannic Moog <y.moog@phytec.de>, Fabio Estevam <festevam@gmail.com>, Tom
 Rini <trini@konsulko.com>, Benjamin Hahn <B.Hahn@phytec.de>, Yashwanth
 Varakala <y.varakala@phytec.de>, Wadim Egorov <w.egorov@phytec.de>,
 <upstream@lists.phytec.de>
Subject: [PATCH 2/4] board: phytec: phycore_imx8mp: Add support for different
 RAM sizes
Date: Tue, 28 May 2024 15:35:13 +0200
Message-ID: <20240528133515.307315-3-t.remmet@phytec.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528133515.307315-1-t.remmet@phytec.de>
References: <20240528133515.307315-1-t.remmet@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWyRpKBR3f+3dA0g19JFg+v+ltMnbSZ3eLt
 3k52i+536g4sHjtn3WX3eHVgFbvH2Ts7GD36u1tYA1iiuGxSUnMyy1KL9O0SuDLebjzFUtCU
 X/Fz3TGWBsZZCV2MHBwSAiYS7V8Kuxi5OIQEljBJdDxqY+5i5ARynjJKnFxhBWKzCWhIPF1x
 mgnEFhGQknjZuZEZpIFZ4DujxJyF/ewgCWGBcIk7Hz6D2SwCqhLTt95kAVnAK2Ah0bZHBCQs
 ISAvsf/gWbD5nAKWEism9TFB7LKQuLh/D1icV0BQ4uTMJywgNjNQffPW2cwQtoTEwRcvoG6T
 l9h16SQjzMxp514zQ9ihEkc2rWaawCg0C8moWUhGzUIyagEj8ypGodzM5OzUosxsvYKMypLU
 ZL2U1E2MoAAXYeDawdg3x+MQIxMH4yFGCQ5mJRHeM5NC04R4UxIrq1KL8uOLSnNSiw8xSnOw
 KInzru4IThUSSE8sSc1OTS1ILYLJMnFwSjUwZgqrPHt5eKP1r92pmSdmPjGbZm7l+jzrZfWH
 tTWrTFs9ty5NFXnYIhrRWbQo+ZT/8yv5ST0rXJeKpki/Sry31G/P7h2bo6rZPm10uNp6/Pz0
 N8FhxmeLhOzkti7K4Crlk+F5a6df6rRmz5UHkfEWumvOqS/wf3MqIPvN/lJbr9zdiU94P1hO
 UWIpzkg01GIuKk4EABcz3rleAgAA
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

Add support for different RAM sizes and speed grades on the
phyCORE-i.MX8MP.
Add support for 1GB 1.5GHz, 1GB 2GHz, 4GB 1.5GHz,
4GB 2GHz and 8GB 2GHz RAM.
The RAM size and speed grade is detected by the information
stored in the EEPROM on the SoM.

Co-developed-by: Benjamin Hahn <B.Hahn@phytec.de>
Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
Co-developed-by: Yannic Moog <y.moog@phytec.de>
Signed-off-by: Yannic Moog <y.moog@phytec.de>
Co-developed-by: Yashwanth Varakala <y.varakala@phytec.de>
Signed-off-by: Yashwanth Varakala <y.varakala@phytec.de>
Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
 board/phytec/phycore_imx8mp/lpddr4_timing.c  | 153 +++++++++++++++++++
 board/phytec/phycore_imx8mp/lpddr4_timing.h  |  16 ++
 board/phytec/phycore_imx8mp/phycore-imx8mp.c |  11 ++
 board/phytec/phycore_imx8mp/spl.c            | 100 +++++-------
 include/configs/phycore_imx8mp.h             |   4 +-
 5 files changed, 224 insertions(+), 60 deletions(-)
 create mode 100644 board/phytec/phycore_imx8mp/lpddr4_timing.h

diff --git a/board/phytec/phycore_imx8mp/lpddr4_timing.c b/board/phytec/phycore_imx8mp/lpddr4_timing.c
index f2707b859606..9984b6c26013 100644
--- a/board/phytec/phycore_imx8mp/lpddr4_timing.c
+++ b/board/phytec/phycore_imx8mp/lpddr4_timing.c
@@ -1839,3 +1839,156 @@ struct dram_timing_info dram_timing = {
 	.ddrphy_pie_num = ARRAY_SIZE(ddr_phy_pie),
 	.fsp_table = { 3000, 400, 100, },
 };
+
+void set_dram_timings_2ghz_2gb(void)
+{
+	dram_timing.ddrc_cfg[3].val = 0x1323;
+	dram_timing.ddrc_cfg[4].val = 0x1e84800;
+	dram_timing.ddrc_cfg[5].val = 0x7a0118;
+	dram_timing.ddrc_cfg[8].val = 0xc00307a3;
+	dram_timing.ddrc_cfg[9].val = 0xc50000;
+	dram_timing.ddrc_cfg[10].val = 0xf4003f;
+	dram_timing.ddrc_cfg[11].val = 0xf30000;
+	dram_timing.ddrc_cfg[14].val = 0x2028222a;
+	dram_timing.ddrc_cfg[15].val = 0x8083f;
+	dram_timing.ddrc_cfg[16].val = 0xe0e000;
+	dram_timing.ddrc_cfg[17].val = 0x12040a12;
+	dram_timing.ddrc_cfg[18].val = 0x2050f0f;
+	dram_timing.ddrc_cfg[19].val = 0x1010009;
+	dram_timing.ddrc_cfg[20].val = 0x502;
+	dram_timing.ddrc_cfg[21].val = 0x20800;
+	dram_timing.ddrc_cfg[22].val = 0xe100002;
+	dram_timing.ddrc_cfg[23].val = 0x120;
+	dram_timing.ddrc_cfg[24].val = 0xc80064;
+	dram_timing.ddrc_cfg[25].val = 0x3e8001e;
+	dram_timing.ddrc_cfg[26].val = 0x3207a12;
+	dram_timing.ddrc_cfg[28].val = 0x4a3820e;
+	dram_timing.ddrc_cfg[30].val = 0x230e;
+	dram_timing.ddrc_cfg[37].val = 0x799;
+	dram_timing.ddrc_cfg[38].val = 0x9141d1c;
+	dram_timing.ddrc_cfg[74].val = 0x302;
+	dram_timing.ddrc_cfg[83].val = 0x599;
+	dram_timing.ddrc_cfg[99].val = 0x302;
+	dram_timing.ddrc_cfg[108].val = 0x599;
+	dram_timing.ddrphy_cfg[66].val = 0x18;
+	dram_timing.ddrphy_cfg[75].val = 0x1e3;
+	dram_timing.ddrphy_cfg[77].val = 0x1e3;
+	dram_timing.ddrphy_cfg[79].val = 0x1e3;
+	dram_timing.ddrphy_cfg[145].val = 0x3e8;
+	dram_timing.fsp_msg[0].drate = 4000;
+	dram_timing.fsp_msg[0].fsp_cfg[1].val = 0xfa0;
+	dram_timing.fsp_msg[0].fsp_cfg[10].val = 0x3ff4;
+	dram_timing.fsp_msg[0].fsp_cfg[11].val = 0xf3;
+	dram_timing.fsp_msg[0].fsp_cfg[15].val = 0x3ff4;
+	dram_timing.fsp_msg[0].fsp_cfg[16].val = 0xf3;
+	dram_timing.fsp_msg[0].fsp_cfg[22].val = 0xf400;
+	dram_timing.fsp_msg[0].fsp_cfg[23].val = 0xf33f;
+	dram_timing.fsp_msg[0].fsp_cfg[28].val = 0xf400;
+	dram_timing.fsp_msg[0].fsp_cfg[29].val = 0xf33f;
+	dram_timing.fsp_msg[3].drate = 4000;
+	dram_timing.fsp_msg[3].fsp_cfg[1].val = 0xfa0;
+	dram_timing.fsp_msg[3].fsp_cfg[11].val = 0x3ff4;
+	dram_timing.fsp_msg[3].fsp_cfg[12].val = 0xf3;
+	dram_timing.fsp_msg[3].fsp_cfg[16].val = 0x3ff4;
+	dram_timing.fsp_msg[3].fsp_cfg[17].val = 0xf3;
+	dram_timing.fsp_msg[3].fsp_cfg[23].val = 0xf400;
+	dram_timing.fsp_msg[3].fsp_cfg[24].val = 0xf33f;
+	dram_timing.fsp_msg[3].fsp_cfg[29].val = 0xf400;
+	dram_timing.fsp_msg[3].fsp_cfg[30].val = 0xf33f;
+	dram_timing.ddrphy_pie[480].val = 0x465;
+	dram_timing.ddrphy_pie[481].val = 0xfa;
+	dram_timing.ddrphy_pie[482].val = 0x9c4;
+	dram_timing.fsp_table[0] = 4000;
+}
+
+void set_dram_timings_1_5ghz_1gb(void)
+{
+	dram_timing.ddrc_cfg[3].val = 0x1233;
+	dram_timing.ddrc_cfg[5].val = 0x5b0087;
+	dram_timing.ddrc_cfg[6].val = 0x61027f10;
+	dram_timing.ddrc_cfg[7].val = 0x7b0;
+	dram_timing.ddrc_cfg[11].val = 0xf30000;
+	dram_timing.ddrc_cfg[23].val = 0x8d;
+	dram_timing.ddrc_cfg[45].val = 0xf070707;
+	dram_timing.ddrc_cfg[59].val = 0x1031;
+	dram_timing.ddrc_cfg[62].val = 0xc0012;
+	dram_timing.ddrc_cfg[77].val = 0x13;
+	dram_timing.ddrc_cfg[84].val = 0x1031;
+	dram_timing.ddrc_cfg[87].val = 0x30005;
+	dram_timing.ddrc_cfg[102].val = 0x5;
+	dram_timing.ddrphy_cfg[75].val = 0x1e3;
+	dram_timing.ddrphy_cfg[77].val = 0x1e3;
+	dram_timing.ddrphy_cfg[79].val = 0x1e3;
+	dram_timing.fsp_msg[0].fsp_cfg[11].val = 0xf3;
+	dram_timing.fsp_msg[0].fsp_cfg[16].val = 0xf3;
+	dram_timing.fsp_msg[0].fsp_cfg[23].val = 0xf32d;
+	dram_timing.fsp_msg[0].fsp_cfg[29].val = 0xf32d;
+	dram_timing.fsp_msg[3].fsp_cfg[12].val = 0xf3;
+	dram_timing.fsp_msg[3].fsp_cfg[17].val = 0xf3;
+	dram_timing.fsp_msg[3].fsp_cfg[24].val = 0xf32d;
+	dram_timing.fsp_msg[3].fsp_cfg[30].val = 0xf32d;
+}
+
+void set_dram_timings_2ghz_1gb(void)
+{
+	set_dram_timings_2ghz_2gb();
+	dram_timing.ddrc_cfg[5].val = 0x7a00b4;
+	dram_timing.ddrc_cfg[23].val = 0xbc;
+	dram_timing.ddrc_cfg[45].val = 0xf070707;
+	dram_timing.ddrc_cfg[62].val = 0xc0012;
+	dram_timing.ddrc_cfg[77].val = 0x13;
+	dram_timing.ddrc_cfg[87].val = 0x30005;
+	dram_timing.ddrc_cfg[102].val = 0x5;
+}
+
+void set_dram_timings_1_5ghz_4gb(void)
+{
+	dram_timing.ddrc_cfg[2].val = 0xa3080020;
+	dram_timing.ddrc_cfg[39].val = 0x17;
+	dram_timing.fsp_msg[0].fsp_cfg[9].val = 0x310;
+	dram_timing.fsp_msg[0].fsp_cfg[21].val = 0x3;
+	dram_timing.fsp_msg[1].fsp_cfg[10].val = 0x310;
+	dram_timing.fsp_msg[1].fsp_cfg[22].val = 0x3;
+	dram_timing.fsp_msg[2].fsp_cfg[10].val = 0x310;
+	dram_timing.fsp_msg[2].fsp_cfg[22].val = 0x3;
+	dram_timing.fsp_msg[3].fsp_cfg[10].val = 0x310;
+	dram_timing.fsp_msg[3].fsp_cfg[22].val = 0x3;
+}
+
+void set_dram_timings_2ghz_4gb(void)
+{
+	set_dram_timings_2ghz_2gb();
+	dram_timing.ddrc_cfg[2].val = 0xa3080020;
+	dram_timing.ddrc_cfg[39].val = 0x17;
+	dram_timing.fsp_msg[0].fsp_cfg[9].val = 0x310;
+	dram_timing.fsp_msg[0].fsp_cfg[21].val = 0x3;
+	dram_timing.fsp_msg[1].fsp_cfg[10].val = 0x310;
+	dram_timing.fsp_msg[1].fsp_cfg[22].val = 0x3;
+	dram_timing.fsp_msg[2].fsp_cfg[10].val = 0x310;
+	dram_timing.fsp_msg[2].fsp_cfg[22].val = 0x3;
+	dram_timing.fsp_msg[3].fsp_cfg[10].val = 0x310;
+	dram_timing.fsp_msg[3].fsp_cfg[22].val = 0x3;
+}
+
+void set_dram_timings_2ghz_8gb(void)
+{
+	set_dram_timings_2ghz_2gb();
+	dram_timing.ddrc_cfg[2].val = 0xa3080020;
+	dram_timing.ddrc_cfg[5].val = 0x7a017c;
+	dram_timing.ddrc_cfg[23].val = 0x184;
+	dram_timing.ddrc_cfg[39].val = 0x18;
+	dram_timing.ddrc_cfg[46].val = 0xf07;
+	dram_timing.ddrc_cfg[62].val = 0xc0026;
+	dram_timing.ddrc_cfg[77].val = 0x27;
+	dram_timing.ddrc_cfg[87].val = 0x3000a;
+	dram_timing.ddrc_cfg[102].val = 0xa;
+
+	dram_timing.fsp_msg[0].fsp_cfg[9].val = 0x310;
+	dram_timing.fsp_msg[0].fsp_cfg[21].val = 0x3;
+	dram_timing.fsp_msg[1].fsp_cfg[10].val = 0x310;
+	dram_timing.fsp_msg[1].fsp_cfg[22].val = 0x3;
+	dram_timing.fsp_msg[2].fsp_cfg[10].val = 0x310;
+	dram_timing.fsp_msg[2].fsp_cfg[22].val = 0x3;
+	dram_timing.fsp_msg[3].fsp_cfg[10].val = 0x310;
+	dram_timing.fsp_msg[3].fsp_cfg[22].val = 0x3;
+}
diff --git a/board/phytec/phycore_imx8mp/lpddr4_timing.h b/board/phytec/phycore_imx8mp/lpddr4_timing.h
new file mode 100644
index 000000000000..1c10e085a92a
--- /dev/null
+++ b/board/phytec/phycore_imx8mp/lpddr4_timing.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
+ */
+
+#ifndef __LPDDR4_TIMING_H__
+#define __LPDDR4_TIMING_H__
+
+void set_dram_timings_2ghz_2gb(void);
+void set_dram_timings_2ghz_1gb(void);
+void set_dram_timings_2ghz_4gb(void);
+void set_dram_timings_1_5ghz_1gb(void);
+void set_dram_timings_1_5ghz_4gb(void);
+void set_dram_timings_2ghz_8gb(void);
+
+#endif /* __LPDDR4_TIMING_H__ */
diff --git a/board/phytec/phycore_imx8mp/phycore-imx8mp.c b/board/phytec/phycore_imx8mp/phycore-imx8mp.c
index dbdd6bb79373..af54fbd8f559 100644
--- a/board/phytec/phycore_imx8mp/phycore-imx8mp.c
+++ b/board/phytec/phycore_imx8mp/phycore-imx8mp.c
@@ -10,6 +10,7 @@
 #include <asm/io.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <env.h>
+#include <init.h>
 #include <miiphy.h>
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -56,3 +57,13 @@ int board_late_init(void)
 
 	return 0;
 }
+
+int board_phys_sdram_size(phys_size_t *size)
+{
+	if (!size)
+		return -EINVAL;
+
+	*size = get_ram_size((void *)PHYS_SDRAM, PHYS_SDRAM_SIZE + PHYS_SDRAM_2_SIZE);
+
+	return 0;
+}
diff --git a/board/phytec/phycore_imx8mp/spl.c b/board/phytec/phycore_imx8mp/spl.c
index 492ce3b7ca6e..f24f09301f1e 100644
--- a/board/phytec/phycore_imx8mp/spl.c
+++ b/board/phytec/phycore_imx8mp/spl.c
@@ -21,6 +21,7 @@
 #include <power/pca9450.h>
 #include <spl.h>
 
+#include "lpddr4_timing.h"
 #include "../common/imx8m_som_detection.h"
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -33,9 +34,19 @@ int spl_board_boot_device(enum boot_device boot_dev_spl)
 	return BOOT_DEVICE_BOOTROM;
 }
 
+enum phytec_imx8mp_ddr_eeprom_code {
+	PHYTEC_IMX8MP_DDR_1GB = 2,
+	PHYTEC_IMX8MP_DDR_2GB = 3,
+	PHYTEC_IMX8MP_DDR_4GB = 5,
+	PHYTEC_IMX8MP_DDR_8GB = 7,
+	PHYTEC_IMX8MP_DDR_4GB_2GHZ = 8,
+};
+
 void spl_dram_init(void)
 {
 	int ret;
+	bool use_2ghz_timings = false;
+	enum phytec_imx8mp_ddr_eeprom_code size = PHYTEC_EEPROM_INVAL;
 
 	ret = phytec_eeprom_data_setup_fallback(NULL, 0, EEPROM_ADDR,
 						EEPROM_ADDR_FALLBACK);
@@ -49,67 +60,38 @@ void spl_dram_init(void)
 	u8 rev = phytec_get_rev(NULL);
 	u8 somtype = phytec_get_som_type(NULL);
 
-	if (rev != PHYTEC_EEPROM_INVAL && (rev >= 3 || (somtype == SOM_TYPE_PCL && rev >= 1))) {
-		dram_timing.ddrc_cfg[3].val = 0x1323;
-		dram_timing.ddrc_cfg[4].val = 0x1e84800;
-		dram_timing.ddrc_cfg[5].val = 0x7a0118;
-		dram_timing.ddrc_cfg[8].val = 0xc00307a3;
-		dram_timing.ddrc_cfg[9].val = 0xc50000;
-		dram_timing.ddrc_cfg[10].val = 0xf4003f;
-		dram_timing.ddrc_cfg[11].val = 0xf30000;
-		dram_timing.ddrc_cfg[14].val = 0x2028222a;
-		dram_timing.ddrc_cfg[15].val = 0x8083f;
-		dram_timing.ddrc_cfg[16].val = 0xe0e000;
-		dram_timing.ddrc_cfg[17].val = 0x12040a12;
-		dram_timing.ddrc_cfg[18].val = 0x2050f0f;
-		dram_timing.ddrc_cfg[19].val = 0x1010009;
-		dram_timing.ddrc_cfg[20].val = 0x502;
-		dram_timing.ddrc_cfg[21].val = 0x20800;
-		dram_timing.ddrc_cfg[22].val = 0xe100002;
-		dram_timing.ddrc_cfg[23].val = 0x120;
-		dram_timing.ddrc_cfg[24].val = 0xc80064;
-		dram_timing.ddrc_cfg[25].val = 0x3e8001e;
-		dram_timing.ddrc_cfg[26].val = 0x3207a12;
-		dram_timing.ddrc_cfg[28].val = 0x4a3820e;
-		dram_timing.ddrc_cfg[30].val = 0x230e;
-		dram_timing.ddrc_cfg[37].val = 0x799;
-		dram_timing.ddrc_cfg[38].val = 0x9141d1c;
-		dram_timing.ddrc_cfg[74].val = 0x302;
-		dram_timing.ddrc_cfg[83].val = 0x599;
-		dram_timing.ddrc_cfg[99].val = 0x302;
-		dram_timing.ddrc_cfg[108].val = 0x599;
-		dram_timing.ddrphy_cfg[66].val = 0x18;
-		dram_timing.ddrphy_cfg[75].val = 0x1e3;
-		dram_timing.ddrphy_cfg[77].val = 0x1e3;
-		dram_timing.ddrphy_cfg[79].val = 0x1e3;
-		dram_timing.ddrphy_cfg[145].val = 0x3e8;
-		dram_timing.fsp_msg[0].drate = 4000;
-		dram_timing.fsp_msg[0].fsp_cfg[1].val = 0xfa0;
-		dram_timing.fsp_msg[0].fsp_cfg[10].val = 0x3ff4;
-		dram_timing.fsp_msg[0].fsp_cfg[11].val = 0xf3;
-		dram_timing.fsp_msg[0].fsp_cfg[15].val = 0x3ff4;
-		dram_timing.fsp_msg[0].fsp_cfg[16].val = 0xf3;
-		dram_timing.fsp_msg[0].fsp_cfg[22].val = 0xf400;
-		dram_timing.fsp_msg[0].fsp_cfg[23].val = 0xf33f;
-		dram_timing.fsp_msg[0].fsp_cfg[28].val = 0xf400;
-		dram_timing.fsp_msg[0].fsp_cfg[29].val = 0xf33f;
-		dram_timing.fsp_msg[3].drate = 4000;
-		dram_timing.fsp_msg[3].fsp_cfg[1].val = 0xfa0;
-		dram_timing.fsp_msg[3].fsp_cfg[11].val = 0x3ff4;
-		dram_timing.fsp_msg[3].fsp_cfg[12].val = 0xf3;
-		dram_timing.fsp_msg[3].fsp_cfg[16].val = 0x3ff4;
-		dram_timing.fsp_msg[3].fsp_cfg[17].val = 0xf3;
-		dram_timing.fsp_msg[3].fsp_cfg[23].val = 0xf400;
-		dram_timing.fsp_msg[3].fsp_cfg[24].val = 0xf33f;
-		dram_timing.fsp_msg[3].fsp_cfg[29].val = 0xf400;
-		dram_timing.fsp_msg[3].fsp_cfg[30].val = 0xf33f;
-		dram_timing.ddrphy_pie[480].val = 0x465;
-		dram_timing.ddrphy_pie[481].val = 0xfa;
-		dram_timing.ddrphy_pie[482].val = 0x9c4;
-		dram_timing.fsp_table[0] = 4000;
+	if (rev != PHYTEC_EEPROM_INVAL && (rev >= 3 || (somtype == SOM_TYPE_PCL && rev >= 1)))
+		use_2ghz_timings = true;
+
+	size = phytec_get_imx8m_ddr_size(NULL);
+
+	switch (size) {
+	case PHYTEC_IMX8MP_DDR_1GB:
+		if (use_2ghz_timings)
+			set_dram_timings_2ghz_1gb();
+		else
+			set_dram_timings_1_5ghz_1gb();
+		break;
+	case PHYTEC_IMX8MP_DDR_2GB:
+		if (use_2ghz_timings)
+			set_dram_timings_2ghz_2gb();
+		break;
+	case PHYTEC_IMX8MP_DDR_4GB:
+		set_dram_timings_1_5ghz_4gb();
+		break;
+	case PHYTEC_IMX8MP_DDR_4GB_2GHZ:
+		set_dram_timings_2ghz_4gb();
+		break;
+	case PHYTEC_IMX8MP_DDR_8GB:
+		set_dram_timings_2ghz_8gb();
+		break;
+	default:
+		goto out;
 	}
-
+	ddr_init(&dram_timing);
+	return;
 out:
+	printf("Could not detect correct RAM size. Fallback to default.\n");
 	ddr_init(&dram_timing);
 }
 
diff --git a/include/configs/phycore_imx8mp.h b/include/configs/phycore_imx8mp.h
index 206c4d50d276..299fabc6a99b 100644
--- a/include/configs/phycore_imx8mp.h
+++ b/include/configs/phycore_imx8mp.h
@@ -22,6 +22,8 @@
 #define CFG_SYS_SDRAM_BASE		0x40000000
 
 #define PHYS_SDRAM			0x40000000
-#define PHYS_SDRAM_SIZE			0x80000000
+#define PHYS_SDRAM_SIZE                 (SZ_2G + SZ_1G) /* 3GB */
+#define PHYS_SDRAM_2                    0x100000000
+#define PHYS_SDRAM_2_SIZE               (SZ_4G + SZ_1G) /* 5GB */
 
 #endif /* __PHYCORE_IMX8MP_H */
-- 
2.34.1

