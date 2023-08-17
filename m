Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B802EEB64DD
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 08:57:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9B6486A97;
	Thu, 17 Aug 2023 10:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="RpJlB+q3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8F2986AB7; Thu, 17 Aug 2023 10:57:28 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF31686A97
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 10:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=T.Remmet@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1692262643; x=1694854643;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mncopWw62wu/TebVVBpuzKN/mrPd79m+R24umAO4PvE=;
 b=RpJlB+q3vF4SsMSUjzmay6rywP26XmoAWvliH+in8g1Pa8NqOHaGoUoNjICqO4KV
 4PIuVY+TeYSRrZWzJECmQrq3PQ5ycttqq0KBaszjd2CKXmfPLMM0WvD0jhWZb6Hk
 b5ZYCYX3AC9M5IysCEIJ2UYpAmu3lJaU7OgKIV9UbQA=;
X-AuditID: ac14000a-923ff70000007ecb-ac-64dde0f38f91
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 13.D2.32459.3F0EDD46;
 Thu, 17 Aug 2023 10:57:23 +0200 (CEST)
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
Subject: [PATCH v2 1/6] board: phytec: Add common PHYTEC SoM detection
Date: Thu, 17 Aug 2023 10:57:06 +0200
Message-ID: <20230817085711.45339-2-t.remmet@phytec.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817085711.45339-1-t.remmet@phytec.de>
References: <20230817085711.45339-1-t.remmet@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsWyRpKBR/fzg7spBlcO6Fg8vOpv0X7Kx+Lt
 3k52iymP17NbdL9Td2D1mDfrBIvHzll32T3O3tnB6NHf3cLqsfHdDqYA1igum5TUnMyy1CJ9
 uwSujJ2HtjEXXPaqmNzzmbWB8b91FyMnh4SAicSnhmtsXYxcHEICS5gk5p74DeU8Y5R4O+Mc
 G0gVm4CGxNMVp5lAbBGBMomHvZ+YQWxmgcWMEqt/W4LYwgJuEpPW/2UBsVkEVCU2HHsFVs8r
 YC5xb2U7C8Q2eYn9B8+C9XIKWEg0dd9gB7GFgGoW9exihKgXlDg58wkLxHx5ieats6F2SUgc
 fPGCGaJeXmLXpZOMMDOnnXvNDGGHShzZtJppAqPQLCSjZiEZNQvJqAWMzKsYhXIzk7NTizKz
 9QoyKktSk/VSUjcxggJfhIFrB2PfHI9DjEwcjIcYJTiYlUR4e3hvpQjxpiRWVqUW5ccXleak
 Fh9ilOZgURLnvd/DlCgkkJ5YkpqdmlqQWgSTZeLglGpgNFg7eZ2zDuNnV/HCPSePXjuy+ZKB
 VVbn79bqT5XPeiKYFnptcWVO5RVekDglce6xoix7u8P7PBUClKIZH7RMv/WntEdSLTzE/etd
 sd5NL09It35Zd2AHTwBHCXfb/R+zlz02u/Nyx7G1G4+/UWQ48qTp5J6ivmCLDesPq3XlX+/M
 uXNWbYLhBiWW4oxEQy3mouJEAEQsImBqAgAA
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

Recent shipped PHYTEC SoMs come with an i2c  EEPROM containing
information about the hardware such as board revision and variant.
This can be used for RAM detection and loading device tree overlays
during kernel start.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
Changes in v2:
- none
---
 board/phytec/common/Kconfig                |   5 +
 board/phytec/common/Makefile               |  10 ++
 board/phytec/common/phytec_som_detection.c | 188 +++++++++++++++++++++
 board/phytec/common/phytec_som_detection.h | 104 ++++++++++++
 4 files changed, 307 insertions(+)
 create mode 100644 board/phytec/common/Kconfig
 create mode 100644 board/phytec/common/Makefile
 create mode 100644 board/phytec/common/phytec_som_detection.c
 create mode 100644 board/phytec/common/phytec_som_detection.h

diff --git a/board/phytec/common/Kconfig b/board/phytec/common/Kconfig
new file mode 100644
index 000000000000..d614d45b1d60
--- /dev/null
+++ b/board/phytec/common/Kconfig
@@ -0,0 +1,5 @@
+config PHYTEC_SOM_DETECTION
+	bool "Support SoM detection for PHYTEC platforms"
+	select SPL_CRC8 if SPL
+	help
+	   Support of I2C EEPROM based SoM detection.
diff --git a/board/phytec/common/Makefile b/board/phytec/common/Makefile
new file mode 100644
index 000000000000..5fe8725ef684
--- /dev/null
+++ b/board/phytec/common/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2023 PHYTEC Messtechnik GmbH
+# Author: Teresa Remmet <t.remmet@phytec.de>
+
+ifdef CONFIG_SPL_BUILD
+# necessary to create built-in.o
+obj- := __dummy__.o
+endif
+
+obj-$(CONFIG_PHYTEC_SOM_DETECTION) += phytec_som_detection.o
diff --git a/board/phytec/common/phytec_som_detection.c b/board/phytec/common/phytec_som_detection.c
new file mode 100644
index 000000000000..366bdd4ace4b
--- /dev/null
+++ b/board/phytec/common/phytec_som_detection.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2023 PHYTEC Messtechnik GmbH
+ * Author: Teresa Remmet <t.remmet@phytec.de>
+ */
+
+#include <common.h>
+#include <asm/mach-imx/mxc_i2c.h>
+#include <asm/arch/sys_proto.h>
+#include <dm/device.h>
+#include <dm/uclass.h>
+#include <i2c.h>
+#include <u-boot/crc.h>
+
+#include "phytec_som_detection.h"
+
+struct phytec_eeprom_data eeprom_data;
+
+int phytec_eeprom_data_setup_fallback(struct phytec_eeprom_data *data,
+				      int bus_num, int addr, int addr_fallback)
+{
+	int ret;
+
+	ret = phytec_eeprom_data_init(data, bus_num, addr);
+	if (ret) {
+		pr_err("%s: init failed. Trying fall back address 0x%x\n",
+		       __func__, addr_fallback);
+		ret = phytec_eeprom_data_init(data, bus_num, addr_fallback);
+	}
+
+	if (ret)
+		pr_err("%s: EEPROM data init failed\n", __func__);
+
+	return ret;
+}
+
+int phytec_eeprom_data_setup(struct phytec_eeprom_data *data,
+			     int bus_num, int addr)
+{
+	int ret;
+
+	ret = phytec_eeprom_data_init(data, bus_num, addr);
+	if (ret)
+		pr_err("%s: EEPROM data init failed\n", __func__);
+
+	return ret;
+}
+
+int phytec_eeprom_data_init(struct phytec_eeprom_data *data,
+			    int bus_num, int addr)
+{
+	int ret, i;
+	unsigned int crc;
+	int *ptr;
+
+	if (!data)
+		data = &eeprom_data;
+
+#if CONFIG_IS_ENABLED(DM_I2C)
+	struct udevice *dev;
+
+	ret = i2c_get_chip_for_busnum(bus_num, addr, 2, &dev);
+	if (ret) {
+		pr_err("%s: i2c EEPROM not found: %i.\n", __func__, ret);
+		return ret;
+	}
+
+	ret = dm_i2c_read(dev, 0, (uint8_t *)data,
+			  sizeof(struct phytec_eeprom_data));
+	if (ret) {
+		pr_err("%s: Unable to read EEPROM data\n", __func__);
+		return ret;
+	}
+#else
+	i2c_set_bus_num(bus_num);
+	ret = i2c_read(addr, 0, 2, (uint8_t *)data,
+		       sizeof(struct phytec_eeprom_data));
+#endif
+
+	if (data->api_rev == 0xff) {
+		pr_err("%s: EEPROM is not flashed. Prototype?\n", __func__);
+		return -EINVAL;
+	}
+
+	ptr = (int *)data;
+	for (i = 0; i < sizeof(struct phytec_eeprom_data); i += sizeof(ptr))
+		if (*ptr != 0x0)
+			break;
+
+	if (i == sizeof(struct phytec_eeprom_data)) {
+		pr_err("%s: EEPROM data is all zero. Erased?\n", __func__);
+		return -EINVAL;
+	}
+
+	/* We are done here for early revisions */
+	if (data->api_rev <= PHYTEC_API_REV1)
+		return 0;
+
+	crc = crc8(0, (const unsigned char *)data,
+		   sizeof(struct phytec_eeprom_data));
+	debug("%s: crc: %x\n", __func__, crc);
+
+	if (crc) {
+		pr_err("%s: CRC mismatch. EEPROM data is not usable\n",
+		       __func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+void __maybe_unused phytec_print_som_info(struct phytec_eeprom_data *data)
+{
+	struct phytec_api2_data *api2;
+	char pcb_sub_rev;
+	unsigned int ksp_no, sub_som_type1, sub_som_type2;
+
+	if (!data)
+		data = &eeprom_data;
+
+	if (data->api_rev < PHYTEC_API_REV2)
+		return;
+
+	api2 = &data->data.data_api2;
+
+	/* Calculate PCB subrevision */
+	pcb_sub_rev = api2->pcb_sub_opt_rev & 0x0f;
+	pcb_sub_rev = pcb_sub_rev ? ((pcb_sub_rev - 1) + 'a') : ' ';
+
+	/* print standard product string */
+	if (api2->som_type <= 1) {
+		printf("SoM: %s-%03u-%s.%s PCB rev: %u%c\n",
+		       phytec_som_type_str[api2->som_type], api2->som_no,
+		       api2->opt, api2->bom_rev, api2->pcb_rev, pcb_sub_rev);
+		return;
+	}
+	/* print KSP/KSM string */
+	if (api2->som_type <= 3) {
+		ksp_no = (api2->ksp_no << 8) | api2->som_no;
+		printf("SoM: %s-%u ",
+		       phytec_som_type_str[api2->som_type], ksp_no);
+	/* print standard product based KSP/KSM strings */
+	} else {
+		switch (api2->som_type) {
+		case 4:
+			sub_som_type1 = 0;
+			sub_som_type2 = 3;
+			break;
+		case 5:
+			sub_som_type1 = 0;
+			sub_som_type2 = 2;
+			break;
+		case 6:
+			sub_som_type1 = 1;
+			sub_som_type2 = 3;
+			break;
+		case 7:
+			sub_som_type1 = 1;
+			sub_som_type2 = 2;
+			break;
+		default:
+			break;
+		};
+
+		printf("SoM: %s-%03u-%s-%03u ",
+		       phytec_som_type_str[sub_som_type1],
+		       api2->som_no, phytec_som_type_str[sub_som_type2],
+		       api2->ksp_no);
+	}
+
+	printf("Option: %s BOM rev: %s PCB rev: %u%c\n", api2->opt,
+	       api2->bom_rev, api2->pcb_rev, pcb_sub_rev);
+}
+
+char * __maybe_unused phytec_get_opt(struct phytec_eeprom_data *data)
+{
+	char *opt;
+
+	if (!data)
+		data = &eeprom_data;
+
+	if (data->api_rev < PHYTEC_API_REV2)
+		opt = data->data.data_api0.opt;
+	else
+		opt = data->data.data_api2.opt;
+
+	return opt;
+}
diff --git a/board/phytec/common/phytec_som_detection.h b/board/phytec/common/phytec_som_detection.h
new file mode 100644
index 000000000000..01f7e4652ddb
--- /dev/null
+++ b/board/phytec/common/phytec_som_detection.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2023 PHYTEC Messtechnik GmbH
+ * Author: Teresa Remmet <t.remmet@phytec.de>
+ */
+
+#ifndef _PHYTEC_SOM_DETECTION_H
+#define _PHYTEC_SOM_DETECTION_H
+
+#define PHYTEC_MAX_OPTIONS	17
+#define PHYTEC_EEPROM_INVAL	0xff
+
+#define PHYTEC_GET_OPTION(option) \
+	(((option) > '9') ? (option) - 'A' + 10 : (option) - '0')
+
+enum {
+	PHYTEC_API_REV0 = 0,
+	PHYTEC_API_REV1,
+	PHYTEC_API_REV2,
+};
+
+static const char * const phytec_som_type_str[] = {
+	"PCM",
+	"PCL",
+	"KSM",
+	"KSP",
+};
+
+struct phytec_api0_data {
+	u8 pcb_rev;		/* PCB revision of SoM */
+	u8 som_type;		/* SoM type */
+	u8 ksp_no;		/* KSP no */
+	char opt[16];		/* SoM options */
+	u8 mac[6];		/* MAC address (optional) */
+	u8 pad[5];		/* padding */
+	u8 cksum;		/* checksum */
+} __packed;
+
+struct phytec_api2_data {
+	u8 pcb_rev;		/* PCB revision of SoM */
+	u8 pcb_sub_opt_rev;	/* PCB subrevision and opt revision */
+	u8 som_type;		/* SoM type */
+	u8 som_no;		/* SoM number */
+	u8 ksp_no;		/* KSP information */
+	char opt[PHYTEC_MAX_OPTIONS]; /* SoM options */
+	char bom_rev[2];	/* BOM revision */
+	u8 mac[6];		/* MAC address (optional) */
+	u8 crc8;		/* checksum */
+} __packed;
+
+struct phytec_eeprom_data {
+	u8 api_rev;
+	union {
+		struct phytec_api0_data data_api0;
+		struct phytec_api2_data data_api2;
+	} data;
+} __packed;
+
+#if IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION)
+
+int phytec_eeprom_data_setup_fallback(struct phytec_eeprom_data *data,
+				      int bus_num, int addr,
+				      int addr_fallback);
+int phytec_eeprom_data_setup(struct phytec_eeprom_data *data,
+			     int bus_num, int addr);
+int phytec_eeprom_data_init(struct phytec_eeprom_data *data,
+			    int bus_num, int addr);
+void __maybe_unused phytec_print_som_info(struct phytec_eeprom_data *data);
+
+char * __maybe_unused phytec_get_opt(struct phytec_eeprom_data *data);
+
+#else
+
+inline int phytec_eeprom_data_setup(struct phytec_eeprom_data *data,
+				    int bus_num, int addr)
+{
+	return PHYTEC_EEPROM_INVAL;
+}
+
+inline int phytec_eeprom_data_setup_fallback(struct phytec_eeprom_data *data,
+					     int bus_num, int addr,
+					     int addr_fallback)
+{
+	return PHYTEC_EEPROM_INVAL;
+}
+
+inline int phytec_eeprom_data_init(struct phytec_eeprom_data *data,
+				   int bus_num, int addr)
+{
+	return PHYTEC_EEPROM_INVAL;
+}
+
+inline void __maybe_unused phytec_print_som_info(struct phytec_eeprom_data *data)
+{
+}
+
+inline char *__maybe_unused phytec_get_opt(struct phytec_eeprom_data *data)
+{
+	return NULL;
+}
+
+#endif /* IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION) */
+
+#endif /* _PHYTEC_SOM_DETECTION_H */
-- 
2.34.1

