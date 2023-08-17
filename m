Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABE8EB64DD
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 08:57:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF53C86AAB;
	Thu, 17 Aug 2023 10:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="ku56yv/W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F57F86A92; Thu, 17 Aug 2023 10:57:29 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2518086AA0
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 10:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=T.Remmet@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1692262644; x=1694854644;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ldoBLF+pLazhO0NVa501PmNBD2x8vXofUYbvYE9Tb6g=;
 b=ku56yv/WUqaCJ8RLgMdI9OcXTpUolhR/cj9HIrnfg4Hj8JRGx0AeeFzXszpBfpQ5
 00KtLoHcxN9/30JI+e3NTfCyB/KRI085yf03kkX4+43tgv0XpLa7J9RGZNpoqxmE
 G07ZPSxnskws4kMUoRjwaeLNeVukFgixgy6T7ffDnTA=;
X-AuditID: ac14000a-917fe70000007ecb-ad-64dde0f42fb2
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 73.D2.32459.4F0EDD46;
 Thu, 17 Aug 2023 10:57:24 +0200 (CEST)
Received: from llp-tremmet2.fritz.box (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Aug
 2023 10:57:23 +0200
From: Teresa Remmet <t.remmet@phytec.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP i
 . MX U-Boot Team" <uboot-imx@nxp.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Yannic Moog
 <y.moog@phytec.de>, Daniel Schultz <d.schultz@phytec.de>, Wadim Egorov
 <w.egorov@phytec.de>
Subject: [PATCH v2 2/6] board: phytec: common: Add imx8m specific EEPROM
 detection support
Date: Thu, 17 Aug 2023 10:57:07 +0200
Message-ID: <20230817085711.45339-3-t.remmet@phytec.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817085711.45339-1-t.remmet@phytec.de>
References: <20230817085711.45339-1-t.remmet@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsWyRpKBR/fLg7spBhtWMls8vOpv0X7Kx+Lt
 3k52iymP17NbdL9Td2D1mDfrBIvHzll32T3O3tnB6NHf3cLqsfHdDqYA1igum5TUnMyy1CJ9
 uwSujIcHHzEVLLCu+L15K0sD43WDLkZODgkBE4kVk6cxdzFycQgJLGGSuPHuPCuE84xR4u2M
 c2wgVWwCGhJPV5xmArFFBMokHvZ+YgaxmQUWM0qs/m0JYgsLREls+tPBDmKzCKhKPFxyC8zm
 FTCXuPinhxFim7zE/oNnwXo5BSwkmrpvgNUIAdUs6tnFCFEvKHFy5hMWiPnyEs1bZ0PtkpA4
 +OIFM0S9vMSuSyfhZk4795oZwg6VOLJpNdMERqFZSEbNQjJqFpJRCxiZVzEK5WYmZ6cWZWbr
 FWRUlqQm66WkbmIEBb4IA9cOxr45HocYmTgYDzFKcDArifD28N5KEeJNSaysSi3Kjy8qzUkt
 PsQozcGiJM57v4cpUUggPbEkNTs1tSC1CCbLxMEp1cBYY2zFVMi0p3HDbYco/Solvo2yQYv5
 fj46l9Dz6M65+SUcl3JySwzn7DfgOvlWe/7NhZUF/yL7169c1MlZ87ZiJoeAwkOVI2cufXwS
 eSu3eolP74HYLT/m/dG5KLd94YEZyoL8Ll6iZRtFTzzIvqNcGNh4Z0/vY85zsk6nlOYfbtod
 vaO1ZK68EktxRqKhFnNRcSIAoRMAPWoCAAA=
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

Add imx8m specific detection part. Which includes checking the
EEPROM data for article number options.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
Changes in v2:
- remove blank line at EOF
- fix string conversion to integer
- fix typo s/revsions/revisions
---
 board/phytec/common/Kconfig               |   8 ++
 board/phytec/common/Makefile              |   1 +
 board/phytec/common/imx8m_som_detection.c | 168 ++++++++++++++++++++++
 board/phytec/common/imx8m_som_detection.h |  54 +++++++
 4 files changed, 231 insertions(+)
 create mode 100644 board/phytec/common/imx8m_som_detection.c
 create mode 100644 board/phytec/common/imx8m_som_detection.h

diff --git a/board/phytec/common/Kconfig b/board/phytec/common/Kconfig
index d614d45b1d60..3b1c5aa0d02b 100644
--- a/board/phytec/common/Kconfig
+++ b/board/phytec/common/Kconfig
@@ -3,3 +3,11 @@ config PHYTEC_SOM_DETECTION
 	select SPL_CRC8 if SPL
 	help
 	   Support of I2C EEPROM based SoM detection.
+
+config PHYTEC_IMX8M_SOM_DETECTION
+	bool "Support SoM detection for i.MX8M PHYTEC platforms"
+	depends on ARCH_IMX8M && PHYTEC_SOM_DETECTION
+	default y
+	help
+	  Support of I2C EEPROM based SoM detection. Supported
+	  for PHYTEC i.MX8MM/i.MX8MP boards
diff --git a/board/phytec/common/Makefile b/board/phytec/common/Makefile
index 5fe8725ef684..fe28964ce21c 100644
--- a/board/phytec/common/Makefile
+++ b/board/phytec/common/Makefile
@@ -8,3 +8,4 @@ obj- := __dummy__.o
 endif
 
 obj-$(CONFIG_PHYTEC_SOM_DETECTION) += phytec_som_detection.o
+obj-$(CONFIG_PHYTEC_IMX8M_SOM_DETECTION) += imx8m_som_detection.o
diff --git a/board/phytec/common/imx8m_som_detection.c b/board/phytec/common/imx8m_som_detection.c
new file mode 100644
index 000000000000..c6c96ed19cb3
--- /dev/null
+++ b/board/phytec/common/imx8m_som_detection.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2023 PHYTEC Messtechnik GmbH
+ * Author: Teresa Remmet <t.remmet@phytec.de>
+ */
+
+#include <common.h>
+#include <asm/arch/sys_proto.h>
+#include <dm/device.h>
+#include <dm/uclass.h>
+#include <i2c.h>
+#include <u-boot/crc.h>
+
+#include "imx8m_som_detection.h"
+
+extern struct phytec_eeprom_data eeprom_data;
+
+/* Check if the SoM is actually one of the following products:
+ * - i.MX8MM
+ * - i.MX8MN
+ * - i.MX8MP
+ * - i.MX8MQ
+ *
+ * Returns 0 in case it's a known SoM. Otherwise, returns -1.
+ */
+u8 __maybe_unused phytec_imx8m_detect(struct phytec_eeprom_data *data)
+{
+	char *opt;
+	u8 som;
+
+	/* We can not do the check for early API revisions */
+	if (data->api_rev < PHYTEC_API_REV2)
+		return -1;
+
+	if (!data)
+		data = &eeprom_data;
+
+	som = data->data.data_api2.som_no;
+	debug("%s: som id: %u\n", __func__, som);
+
+	opt = phytec_get_opt(data);
+	if (!opt)
+		return -1;
+
+	if (som == PHYTEC_IMX8MP_SOM && is_imx8mp())
+		return 0;
+
+	if (som == PHYTEC_IMX8MM_SOM) {
+		if ((PHYTEC_GET_OPTION(opt[0]) != 0) &&
+		    (PHYTEC_GET_OPTION(opt[1]) == 0) && is_imx8mm())
+			return 0;
+		else if ((PHYTEC_GET_OPTION(opt[0]) == 0) &&
+			 (PHYTEC_GET_OPTION(opt[1]) != 0) && is_imx8mn())
+			return 0;
+	}
+
+	if (som == PHYTEC_IMX8MQ_SOM && is_imx8mq())
+		return 0;
+
+	pr_err("%s: SoM ID does not match. Wrong EEPROM data?\n", __func__);
+	return -1;
+}
+
+/*
+ * All PHYTEC i.MX8M boards have RAM size definition at the
+ * same location.
+ */
+u8 __maybe_unused phytec_get_imx8m_ddr_size(struct phytec_eeprom_data *data)
+{
+	char *opt;
+	u8 ddr_id;
+
+	if (!data)
+		data = &eeprom_data;
+
+	opt = phytec_get_opt(data);
+	if (opt)
+		ddr_id = PHYTEC_GET_OPTION(opt[2]);
+	else
+		ddr_id = PHYTEC_EEPROM_INVAL;
+
+	debug("%s: ddr id: %u\n", __func__, ddr_id);
+	return ddr_id;
+}
+
+/*
+ * Filter SPI-NOR flash information. All i.MX8M boards have this at
+ * the same location.
+ * returns: 0x0 if no SPI is populated. Otherwise a board depended
+ * code for the size. PHYTEC_EEPROM_INVAL when the data is invalid.
+ */
+u8 __maybe_unused phytec_get_imx8m_spi(struct phytec_eeprom_data *data)
+{
+	char *opt;
+	u8 spi;
+
+	if (!data)
+		data = &eeprom_data;
+
+	if (data->api_rev < PHYTEC_API_REV2)
+		return PHYTEC_EEPROM_INVAL;
+
+	opt = phytec_get_opt(data);
+	if (opt)
+		spi = PHYTEC_GET_OPTION(opt[4]);
+	else
+		spi = PHYTEC_EEPROM_INVAL;
+
+	debug("%s: spi: %u\n", __func__, spi);
+	return spi;
+}
+
+/*
+ * Filter ethernet phy information. All i.MX8M boards have this at
+ * the same location.
+ * returns: 0x0 if no ethernet phy is populated. 0x1 if it is populated.
+ * PHYTEC_EEPROM_INVAL when the data is invalid.
+ */
+u8 __maybe_unused phytec_get_imx8m_eth(struct phytec_eeprom_data *data)
+{
+	char *opt;
+	u8 eth;
+
+	if (!data)
+		data = &eeprom_data;
+
+	if (data->api_rev < PHYTEC_API_REV2)
+		return PHYTEC_EEPROM_INVAL;
+
+	opt = phytec_get_opt(data);
+	if (opt) {
+		eth = PHYTEC_GET_OPTION(opt[5]);
+		eth &= 0x1;
+	} else {
+		eth = PHYTEC_EEPROM_INVAL;
+	}
+
+	debug("%s: eth: %u\n", __func__, eth);
+	return eth;
+}
+
+/*
+ * Filter RTC information for phyCORE-i.MX8MP.
+ * returns: 0 if no RTC is populated. 1 if it is populated.
+ * PHYTEC_EEPROM_INVAL when the data is invalid.
+ */
+u8 __maybe_unused phytec_get_imx8mp_rtc(struct phytec_eeprom_data *data)
+{
+	char *opt;
+	u8 rtc;
+
+	if (!data)
+		data = &eeprom_data;
+
+	if (data->api_rev < PHYTEC_API_REV2)
+		return PHYTEC_EEPROM_INVAL;
+
+	opt = phytec_get_opt(data);
+	if (opt) {
+		rtc = PHYTEC_GET_OPTION(opt[5]);
+		rtc &= 0x4;
+		rtc = !(rtc >> 2);
+	} else {
+		rtc = PHYTEC_EEPROM_INVAL;
+	}
+	debug("%s: rtc: %u\n", __func__, rtc);
+	return rtc;
+}
diff --git a/board/phytec/common/imx8m_som_detection.h b/board/phytec/common/imx8m_som_detection.h
new file mode 100644
index 000000000000..88d3037bf363
--- /dev/null
+++ b/board/phytec/common/imx8m_som_detection.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2023 PHYTEC Messtechnik GmbH
+ * Author: Teresa Remmet <t.remmet@phytec.de>
+ */
+
+#ifndef _PHYTEC_IMX8M_SOM_DETECTION_H
+#define _PHYTEC_IMX8M_SOM_DETECTION_H
+
+#include "phytec_som_detection.h"
+
+#define PHYTEC_IMX8MQ_SOM       66
+#define PHYTEC_IMX8MM_SOM       69
+#define PHYTEC_IMX8MP_SOM       70
+
+#if IS_ENABLED(CONFIG_PHYTEC_IMX8M_SOM_DETECTION)
+
+u8 __maybe_unused phytec_imx8m_detect(struct phytec_eeprom_data *data);
+u8 __maybe_unused phytec_get_imx8m_ddr_size(struct phytec_eeprom_data *data);
+u8 __maybe_unused phytec_get_imx8mp_rtc(struct phytec_eeprom_data *data);
+u8 __maybe_unused phytec_get_imx8m_spi(struct phytec_eeprom_data *data);
+u8 __maybe_unused phytec_get_imx8m_eth(struct phytec_eeprom_data *data);
+
+#else
+
+inline u8 __maybe_unused phytec_imx8m_detect(struct phytec_eeprom_data *data)
+{
+	return -1;
+}
+
+inline u8 __maybe_unused
+phytec_get_imx8m_ddr_size(struct phytec_eeprom_data *data)
+{
+	return PHYTEC_EEPROM_INVAL;
+}
+
+inline u8 __maybe_unused phytec_get_imx8mp_rtc(struct phytec_eeprom_data *data)
+{
+	return PHYTEC_EEPROM_INVAL;
+}
+
+inline u8 __maybe_unused phytec_get_imx8m_spi(struct phytec_eeprom_data *data)
+{
+	return PHYTEC_EEPROM_INVAL;
+}
+
+inline u8 __maybe_unused phytec_get_imx8m_eth(struct phytec_eeprom_data *data)
+{
+	return PHYTEC_EEPROM_INVAL;
+}
+
+#endif /* IS_ENABLED(CONFIG_PHYTEC_IMX8M_SOM_DETECTION) */
+
+#endif /* _PHYTEC_IMX8M_SOM_DETECTION_H */
-- 
2.34.1

