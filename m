Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C8CC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 16:23:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B54E887E0;
	Fri, 19 Apr 2024 18:22:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Nz+i8hqj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93996886C1; Fri, 19 Apr 2024 17:56:05 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D1C588775
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 17:56:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1713542159; x=1716134159;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JVMaO0MWAYSYKpcl689RuKNIvfPQ6/xqVwwhg3Mt26I=;
 b=Nz+i8hqjQBV4qyVzDLjIQH2Z4UJ4OKRRw7WnewtGK44hYlUvKgyz2uZJyM4VLXoZ
 FQUCW8iE7VZtzY5TR6Z839JNLvBTN1EUWkZ2UYxjb+13j2fz20qT/me+lJutOqGs
 NR8dVKb0ApOANHHo5z1TeoEK8ByD8pUYsz3v1Y84WwA=;
X-AuditID: ac14000a-fbefe7000000290d-74-6622940feea8
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id CC.38.10509.F0492266;
 Fri, 19 Apr 2024 17:55:59 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 19 Apr
 2024 17:55:58 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>
CC: Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 5/5] board: phytec: Add SOM detection for AM6x
Date: Fri, 19 Apr 2024 08:55:40 -0700
Message-ID: <20240419155540.2447006-6-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240419155540.2447006-1-d.schultz@phytec.de>
References: <20240419155540.2447006-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsWyRpKBR5d/ilKawd1DmhZv93ayOzB6nL2z
 gzGAMYrLJiU1J7MstUjfLoEr49bhzYwFF5wqbvcdZ25gXG7excjJISFgInFt1m/GLkYuDiGB
 JUwSGyZ8hXLuM0rsm3CQDaSKTUBL4s6WucwgtoiAlMTLzo1ANgcHs4CGRPszJpCwsICdxMr2
 5ywgNouAqsSN7m6wVl4BK4kJJ/azQyyTl5h56TuYzSlgLfF9+xewkUJANecXn4eqF5Q4OfMJ
 2BxmoPrmrbOZIWwJiYMvXkDVK0jM3jaZEWbmtHOvmSHsUIkjm1YzTWAUmoVk1Cwko2YhGbWA
 kXkVo1BuZnJ2alFmtl5BRmVJarJeSuomRlCwijBw7WDsm+NxiJGJg/EQowQHs5IIrxmHYpoQ
 b0piZVVqUX58UWlOavEhRmkOFiVx3tUdwalCAumJJanZqakFqUUwWSYOTqkGRn/ZPyvyF8St
 jI14nrDszrHZPTwzUpcLXTc0aouYoc7mOSP+elvqtuqu7aKaXl23F7JGCid9shDsuPKXTful
 Voba2c2xXXsv1tRff9zhtdh5caH1vFnbOgu/T3yZ4/56beVCQ3mnqqUR/WEKS72/V3ismFd3
 ZCKb+Sbpp7fFTXzk76co6shUKbEUZyQaajEXFScCAN/ufBJEAgAA
X-Mailman-Approved-At: Fri, 19 Apr 2024 18:22:18 +0200
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

Add all functions to read each SOM option from the EEPROM
image and detect whether it's the correct product for this
image.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 board/phytec/common/Kconfig             |  18 +++
 board/phytec/common/Makefile            |   1 +
 board/phytec/common/am6_som_detection.c | 159 ++++++++++++++++++++++++
 board/phytec/common/am6_som_detection.h |  36 ++++++
 board/phytec/phycore_am62x/Kconfig      |   4 +
 board/phytec/phycore_am64x/Kconfig      |   4 +
 6 files changed, 222 insertions(+)
 create mode 100644 board/phytec/common/am6_som_detection.c
 create mode 100644 board/phytec/common/am6_som_detection.h

diff --git a/board/phytec/common/Kconfig b/board/phytec/common/Kconfig
index 3b1c5aa0d02..1077f0f4b61 100644
--- a/board/phytec/common/Kconfig
+++ b/board/phytec/common/Kconfig
@@ -11,3 +11,21 @@ config PHYTEC_IMX8M_SOM_DETECTION
 	help
 	  Support of I2C EEPROM based SoM detection. Supported
 	  for PHYTEC i.MX8MM/i.MX8MP boards
+
+config PHYTEC_AM62_SOM_DETECTION
+	bool "Support SoM detection for AM62x PHYTEC platforms"
+	depends on (TARGET_PHYCORE_AM62X_A53 || TARGET_PHYCORE_AM62X_R5) && \
+		   PHYTEC_SOM_DETECTION
+	default y
+	help
+	   Support of I2C EEPROM based SoM detection. Supported
+	   for PHYTEC AM62x boards.
+
+config PHYTEC_AM64_SOM_DETECTION
+	bool "Support SoM detection for AM64x PHYTEC platforms"
+	depends on (TARGET_PHYCORE_AM64X_A53 || TARGET_PHYCORE_AM64X_R5) && \
+		   PHYTEC_SOM_DETECTION
+	default y
+	help
+	   Support of I2C EEPROM based SoM detection. Supported
+	   for PHYTEC AM64x boards.
diff --git a/board/phytec/common/Makefile b/board/phytec/common/Makefile
index 35c81741306..3feb00fd1ec 100644
--- a/board/phytec/common/Makefile
+++ b/board/phytec/common/Makefile
@@ -8,4 +8,5 @@ obj- := __dummy__.o
 endif
 
 obj-y += phytec_som_detection.o
+obj-$(CONFIG_ARCH_K3) += am6_som_detection.o
 obj-$(CONFIG_ARCH_IMX8M) += imx8m_som_detection.o
diff --git a/board/phytec/common/am6_som_detection.c b/board/phytec/common/am6_som_detection.c
new file mode 100644
index 00000000000..2e9884dab44
--- /dev/null
+++ b/board/phytec/common/am6_som_detection.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
+ * Author: Daniel Schultz <d.schultz@phytec.de>
+ */
+
+#include <asm/arch/hardware.h>
+
+#include "am6_som_detection.h"
+
+extern struct phytec_eeprom_data eeprom_data;
+
+#if IS_ENABLED(CONFIG_PHYTEC_AM62_SOM_DETECTION) || \
+	IS_ENABLED(CONFIG_PHYTEC_AM64_SOM_DETECTION)
+
+/* Check if the SoM is actually one of the following products:
+ * - phyCORE-AM62x
+ * - phyCORE-AM64x
+ *
+ * Returns 0 in case it's a known SoM. Otherwise, returns -1.
+ */
+int phytec_am6_detect(struct phytec_eeprom_data *data)
+{
+	char *opt;
+	u8 som;
+
+	if (!data)
+		data = &eeprom_data;
+
+	/* We cannot do the check for early API revisions */
+	if (!data->valid || data->payload.api_rev < PHYTEC_API_REV2)
+		return -1;
+
+	som = data->payload.data.data_api2.som_no;
+	debug("%s: som id: %u\n", __func__, som);
+
+	opt = phytec_get_opt(data);
+	if (!opt)
+		return -1;
+
+	if (som == PHYTEC_AM62X_SOM && soc_is_am62x())
+		return 0;
+
+	if (som == PHYTEC_AM64X_SOM && soc_is_am64x())
+		return 0;
+
+	return -1;
+}
+
+static u8 phytec_check_opt(struct phytec_eeprom_data *data, u8 option)
+{
+	char *opt;
+
+	if (!data)
+		data = &eeprom_data;
+
+	if (!data->valid || data->payload.api_rev < PHYTEC_API_REV2)
+		return PHYTEC_EEPROM_INVAL;
+
+	if (option > 8)
+		return PHYTEC_EEPROM_INVAL;
+
+	opt = phytec_get_opt(data);
+	if (opt)
+		return PHYTEC_GET_OPTION(opt[option]);
+	return PHYTEC_EEPROM_INVAL;
+}
+
+/*
+ * Reads LPDDR4 ram size from EEPROM.
+ *
+ * returns:
+ *  - The size
+ *  - PHYTEC_EEPROM_INVAL when the data is invalid.
+ */
+u8 __maybe_unused phytec_get_am62_ddr_size(struct phytec_eeprom_data *data)
+{
+	u8 ddr_id = phytec_check_opt(data, 3);
+
+	pr_debug("%s: ddr id: %u\n", __func__, ddr_id);
+	return ddr_id;
+}
+
+/*
+ * Reads SPI-NOR flash size and type from EEPROM.
+ *
+ * returns:
+ *  - PHYTEC_EEPROM_VALUE_X if no SPI is poulated.
+ *  - Otherwise a board depended code for the size.
+ *  - PHYTEC_EEPROM_INVAL when the data is invalid.
+ */
+u8 __maybe_unused phytec_get_am62_spi(struct phytec_eeprom_data *data)
+{
+	u8 spi = phytec_check_opt(data, 5);
+
+	pr_debug("%s: spi: %u\n", __func__, spi);
+	return spi;
+}
+
+/*
+ * Reads Ethernet phy information from EEPROM.
+ *
+ * returns:
+ *  - 0x0 no ethernet phy is populated.
+ *  - 0x1 if 10/100/1000 MBit Phy is populated.
+ *  - PHYTEC_EEPROM_INVAL when the data is invalid.
+ */
+u8 __maybe_unused phytec_get_am62_eth(struct phytec_eeprom_data *data)
+{
+	u8 eth = phytec_check_opt(data, 6);
+
+	pr_debug("%s: eth: %u\n", __func__, eth);
+	return eth;
+}
+
+/*
+ * Reads RTC information from EEPROM.
+ *
+ * returns:
+ *  - 0 if no RTC is poulated.
+ *  - 1 if it is populated.
+ *  - PHYTEC_EEPROM_INVAL when the data is invalid.
+ */
+u8 __maybe_unused phytec_get_am62_rtc(struct phytec_eeprom_data *data)
+{
+	u8 rtc = phytec_check_opt(data, 7);
+
+	pr_debug("%s: rtc: %u\n", __func__, rtc);
+	return rtc;
+}
+
+#else
+
+inline int __maybe_unused phytec_am62_detect(struct phytec_eeprom_data *data)
+{
+	return -1;
+}
+
+inline u8 __maybe_unused
+phytec_get_am62_ddr_size(struct phytec_eeprom_data *data)
+{
+	return PHYTEC_EEPROM_INVAL;
+}
+
+inline u8 __maybe_unused phytec_get_am62_spi(struct phytec_eeprom_data *data)
+{
+	return PHYTEC_EEPROM_INVAL;
+}
+
+inline u8 __maybe_unused phytec_get_am62_eth(struct phytec_eeprom_data *data)
+{
+	return PHYTEC_EEPROM_INVAL;
+}
+
+inline u8 __maybe_unused phytec_get_am62_rtc(struct phytec_eeprom_data *data)
+{
+	return PHYTEC_EEPROM_INVAL;
+}
+#endif
diff --git a/board/phytec/common/am6_som_detection.h b/board/phytec/common/am6_som_detection.h
new file mode 100644
index 00000000000..032f9da3aab
--- /dev/null
+++ b/board/phytec/common/am6_som_detection.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
+ * Author: Daniel Schultz <d.schultz@phytec.de>
+ */
+
+#ifndef _PHYTEC_AM6_SOM_DETECTION_H
+#define _PHYTEC_AM6_SOM_DETECTION_H
+
+#include "phytec_som_detection.h"
+
+#define PHYTEC_AM62X_SOM			71
+#define PHYTEC_AM64X_SOM			72
+#define PHYTEC_EEPROM_VALUE_X			0x21
+#define PHYTEC_EEPROM_NOR_FLASH_64MB_QSPI	0xC
+
+int __maybe_unused phytec_am6_detect(struct phytec_eeprom_data *data);
+u8 __maybe_unused phytec_get_am6_ddr_size(struct phytec_eeprom_data *data);
+u8 __maybe_unused phytec_get_am6_spi(struct phytec_eeprom_data *data);
+u8 __maybe_unused phytec_get_am6_eth(struct phytec_eeprom_data *data);
+u8 __maybe_unused phytec_get_am6_rtc(struct phytec_eeprom_data *data);
+
+static inline int phytec_am6_is_qspi(struct phytec_eeprom_data *data)
+{
+	u8 spi = phytec_get_am6_spi(data);
+
+	if (spi == PHYTEC_EEPROM_VALUE_X)
+		return 0;
+	return spi <= PHYTEC_EEPROM_NOR_FLASH_64MB_QSPI;
+}
+
+static inline int phytec_am6_is_ospi(struct phytec_eeprom_data *data)
+{
+	return phytec_get_am6_spi(data) > PHYTEC_EEPROM_NOR_FLASH_64MB_QSPI;
+}
+#endif /* _PHYTEC_AM6_SOM_DETECTION_H */
diff --git a/board/phytec/phycore_am62x/Kconfig b/board/phytec/phycore_am62x/Kconfig
index b64c3451389..1de8850c6c4 100644
--- a/board/phytec/phycore_am62x/Kconfig
+++ b/board/phytec/phycore_am62x/Kconfig
@@ -14,6 +14,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
        default "phycore_am62x"
 
+source "board/phytec/common/Kconfig"
+
 endif
 
 if TARGET_PHYCORE_AM62X_R5
@@ -30,4 +32,6 @@ config SYS_CONFIG_NAME
 config SPL_LDSCRIPT
 	default "arch/arm/mach-omap2/u-boot-spl.lds"
 
+source "board/phytec/common/Kconfig"
+
 endif
diff --git a/board/phytec/phycore_am64x/Kconfig b/board/phytec/phycore_am64x/Kconfig
index 427adb6fedd..829526c3295 100644
--- a/board/phytec/phycore_am64x/Kconfig
+++ b/board/phytec/phycore_am64x/Kconfig
@@ -17,6 +17,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
        default "phycore_am64x"
 
+source "board/phytec/common/Kconfig"
+
 endif
 
 if TARGET_PHYCORE_AM64X_R5
@@ -30,4 +32,6 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
        default "phycore_am64x"
 
+source "board/phytec/common/Kconfig"
+
 endif
-- 
2.25.1

