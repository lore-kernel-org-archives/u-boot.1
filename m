Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF16C25B7A
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 14:51:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C73168886B;
	Wed, 22 May 2024 16:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="lTkBDcgI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2950887D9; Wed, 22 May 2024 08:18:50 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AA0D88412
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 08:18:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1716358728; x=1718950728;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GcFJbu8dpcS7DwQ8qr+9WmZvF/Zudtn+KL3nz+sa5A0=;
 b=lTkBDcgITWuFGF/o11Pb1pS/orXHoPOaeOHzl5KIxGvc9+01LztkyHXc7hFUhCj8
 MaxEYGVUhZmBTkcFWgxTtDkoeeh4kBBw7n9xaX9AWZu3pLrbQmIA1ebAuqI7CIGD
 leKSV5WFtEF3UwPpItoPHOcNAq5E4nE+C2youWEvr4g=;
X-AuditID: ac14000a-03e52700000021bc-68-664d8e48bec9
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 53.10.08636.84E8D466;
 Wed, 22 May 2024 08:18:48 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 22 May
 2024 08:18:46 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 4/6] board: phytec: common: Add API v3
Date: Tue, 21 May 2024 23:18:25 -0700
Message-ID: <20240522061827.601699-5-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240522061827.601699-1-d.schultz@phytec.de>
References: <20240522061827.601699-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsWyRpKBR9ejzzfNYN4/YYu3ezvZLbrfqTsw
 eZy9s4PRo7+7hTWAKYrLJiU1J7MstUjfLoErY92LCSwFp/Ir3h1sY29gXBDdxcjJISFgIjFn
 7TrGLkYuDiGBJUwSD3/+Y4dw7jNKvDi+hQ2kik1AS+LOlrnMILaIgJnEorXngeIcHMwCGhLt
 z5hAwsJA4dsdRxlBbBYBVYkjnYtYQGxeAUuJb8tWM0Msk5eYeek7O4jNKWAlcXv2erB6IaCa
 r6//sUPUC0qcnPkErJcZqL5562xmCFtC4uCLF8wQ9QoSs7dNZoSZOe3ca6j5oRJbv2xnmsAo
 NAvJqFlIRs1CMmoBI/MqRqHczOTs1KLMbL2CjMqS1GS9lNRNjKDwFWHg2sHYN8fjECMTB+Mh
 RgkOZiUR3k1bPNOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ867uCE4VEkhPLEnNTk0tSC2CyTJx
 cEo1MPLvjtAVurf3ZVRplV301+WPHQVr7ng/KeafscDLef9xB63Oh63eD/x6ckXXvj+sG193
 t+S2UuGpf9yLpGa/ZXvjr1WtHvBIPzCvZfbOQ6sLq1gXGGRmflvoqfI+qNnu8o8z3osldh3b
 Mrni5aKJagpfV0ee/3T6yM9L7x7M/WAY2vtFqdzvYr4SS3FGoqEWc1FxIgAa+BCoTQIAAA==
X-Mailman-Approved-At: Wed, 22 May 2024 16:50:43 +0200
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

This API is based on a block structure with a 8 Byte large
API v3 header and various of different blocks following. It extends
our current API v2, which is always 32 Byte large, and is located
directly after v2.

Add the MAC block as first block type. It contains the physical
Ehternet interface number, a MAC address and a CRC checksum over the
MAC payload.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 board/phytec/common/Kconfig                   |   9 ++
 board/phytec/common/Makefile                  |   2 +-
 board/phytec/common/phytec_som_detection.c    | 153 ++++++++++++++++++
 board/phytec/common/phytec_som_detection.h    |   7 +
 .../common/phytec_som_detection_blocks.c      | 105 ++++++++++++
 .../common/phytec_som_detection_blocks.h      |  61 +++++++
 6 files changed, 336 insertions(+), 1 deletion(-)
 create mode 100644 board/phytec/common/phytec_som_detection_blocks.c
 create mode 100644 board/phytec/common/phytec_som_detection_blocks.h

diff --git a/board/phytec/common/Kconfig b/board/phytec/common/Kconfig
index 1077f0f4b61..668afe2a534 100644
--- a/board/phytec/common/Kconfig
+++ b/board/phytec/common/Kconfig
@@ -4,6 +4,13 @@ config PHYTEC_SOM_DETECTION
 	help
 	   Support of I2C EEPROM based SoM detection.
 
+config PHYTEC_SOM_DETECTION_BLOCKS
+	bool "Extend SoM detection with block support"
+	depends on PHYTEC_SOM_DETECTION
+	help
+	   Extend the I2C EEPROM based SoM detection with API v3. This API
+	   introduces blocks with different payloads.
+
 config PHYTEC_IMX8M_SOM_DETECTION
 	bool "Support SoM detection for i.MX8M PHYTEC platforms"
 	depends on ARCH_IMX8M && PHYTEC_SOM_DETECTION
@@ -16,6 +23,7 @@ config PHYTEC_AM62_SOM_DETECTION
 	bool "Support SoM detection for AM62x PHYTEC platforms"
 	depends on (TARGET_PHYCORE_AM62X_A53 || TARGET_PHYCORE_AM62X_R5) && \
 		   PHYTEC_SOM_DETECTION
+	select PHYTEC_SOM_DETECTION_BLOCKS
 	default y
 	help
 	   Support of I2C EEPROM based SoM detection. Supported
@@ -25,6 +33,7 @@ config PHYTEC_AM64_SOM_DETECTION
 	bool "Support SoM detection for AM64x PHYTEC platforms"
 	depends on (TARGET_PHYCORE_AM64X_A53 || TARGET_PHYCORE_AM64X_R5) && \
 		   PHYTEC_SOM_DETECTION
+	select PHYTEC_SOM_DETECTION_BLOCKS
 	default y
 	help
 	   Support of I2C EEPROM based SoM detection. Supported
diff --git a/board/phytec/common/Makefile b/board/phytec/common/Makefile
index c34fc503059..446c481a6e6 100644
--- a/board/phytec/common/Makefile
+++ b/board/phytec/common/Makefile
@@ -9,6 +9,6 @@ else
 obj-$(CONFIG_ARCH_K3) += k3/
 endif
 
-obj-y += phytec_som_detection.o
+obj-y += phytec_som_detection.o phytec_som_detection_blocks.o
 obj-$(CONFIG_ARCH_K3) += am6_som_detection.o
 obj-$(CONFIG_ARCH_IMX8M) += imx8m_som_detection.o
diff --git a/board/phytec/common/phytec_som_detection.c b/board/phytec/common/phytec_som_detection.c
index ab2d5a7b726..166c3eae565 100644
--- a/board/phytec/common/phytec_som_detection.c
+++ b/board/phytec/common/phytec_som_detection.c
@@ -91,6 +91,134 @@ int phytec_eeprom_data_init_v2(struct phytec_eeprom_data *data)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION_BLOCKS)
+
+int phytec_eeprom_data_init_v3_block(struct phytec_eeprom_data *data,
+				     struct phytec_api3_block_header *header,
+				     u8 *payload)
+{
+	struct phytec_api3_element *element = NULL;
+	struct phytec_api3_element *list_iterator;
+
+	if (!header)
+		return -1;
+	if (!payload)
+		return -1;
+
+	debug("%s: block type: %i\n", __func__, header->block_type);
+	switch (header->block_type) {
+	case PHYTEC_API3_BLOCK_MAC:
+		element = phytec_blocks_init_mac(header, payload);
+		break;
+	default:
+		debug("%s: Unknown block type %i\n", __func__,
+		      header->block_type);
+	}
+	if (!element)
+		return -1;
+
+	if (!data->payload.block_head) {
+		data->payload.block_head = element;
+		return 0;
+	}
+
+	list_iterator = data->payload.block_head;
+	while (list_iterator && list_iterator->next)
+		list_iterator = list_iterator->next;
+	list_iterator->next = element;
+
+	return 0;
+}
+
+int phytec_eeprom_data_init_v3(struct phytec_eeprom_data *data,
+			       int bus_num, int addr)
+{
+	int ret, i;
+	struct phytec_api3_header header;
+	unsigned int crc;
+	u8 *payload;
+	int block_addr;
+	struct phytec_api3_block_header *block_header;
+
+	if (!data)
+		return -1;
+
+	ret = phytec_eeprom_read((uint8_t *)&header, bus_num, addr,
+				 PHYTEC_API3_DATA_HEADER_LEN,
+				 PHYTEC_API2_DATA_LEN);
+	if (ret) {
+		pr_err("%s: Failed to read API v3 data header.\n", __func__);
+		goto err;
+	}
+
+	crc = crc8(0, (const unsigned char *)&header,
+		   PHYTEC_API3_DATA_HEADER_LEN);
+	debug("%s: crc: %x\n", __func__, crc);
+	if (crc) {
+		pr_err("%s: CRC mismatch. API3 header is unusable.\n",
+		       __func__);
+		goto err;
+	}
+
+	debug("%s: data length: %i\n", __func__, header.data_length);
+	payload = malloc(header.data_length);
+	if (!payload) {
+		pr_err("%s: Unable to allocate memory\n", __func__);
+		goto err_payload;
+	}
+
+	ret = phytec_eeprom_read(payload, bus_num, addr, header.data_length,
+				 PHYTEC_API3_DATA_HEADER_LEN +
+				 PHYTEC_API2_DATA_LEN);
+	if (ret) {
+		pr_err("%s: Failed to read API v3 data payload.\n", __func__);
+		goto err_payload;
+	}
+
+	block_addr = 0;
+	debug("%s: block count: %i\n", __func__, header.block_count);
+	for (i = 0; i < header.block_count; i++) {
+		debug("%s: block_addr: %i\n", __func__, block_addr);
+		block_header = (struct phytec_api3_block_header *)
+			&payload[block_addr];
+		crc = crc8(0, (const unsigned char *)block_header,
+			   PHYTEC_API3_BLOCK_HEADER_LEN);
+
+		debug("%s: crc: %x\n", __func__, crc);
+		if (crc) {
+			pr_err("%s: CRC mismatch. API3 block header is unusable\n",
+			       __func__);
+			goto err_payload;
+		}
+
+		ret = phytec_eeprom_data_init_v3_block(data, block_header,
+			&payload[block_addr + PHYTEC_API3_BLOCK_HEADER_LEN]);
+		/* Ignore failed block initialization and continue. */
+		if (ret)
+			debug("%s: Unable to create block with index %i.\n",
+			      __func__, i);
+
+		block_addr = block_header->next_block;
+	}
+
+	free(payload);
+	return 0;
+err_payload:
+	free(payload);
+err:
+	return -1;
+}
+
+#else
+
+inline int phytec_eeprom_data_init_v3(struct phytec_eeprom_data *data,
+				      int bus_num, int addr)
+{
+	return 0;
+}
+
+#endif
+
 int phytec_eeprom_data_init(struct phytec_eeprom_data *data,
 			    int bus_num, int addr)
 {
@@ -104,6 +232,7 @@ int phytec_eeprom_data_init(struct phytec_eeprom_data *data,
 				 PHYTEC_API2_DATA_LEN, 0);
 	if (ret)
 		goto err;
+	data->payload.block_head = NULL;
 
 	if (data->payload.api_rev == 0xff) {
 		pr_err("%s: EEPROM is not flashed. Prototype?\n", __func__);
@@ -128,6 +257,13 @@ int phytec_eeprom_data_init(struct phytec_eeprom_data *data,
 			goto err;
 	}
 
+	if (IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION_BLOCKS))
+		if (data->payload.api_rev >= PHYTEC_API_REV3) {
+			ret = phytec_eeprom_data_init_v3(data, bus_num, addr);
+			if (ret)
+				goto err;
+		}
+
 	data->valid = true;
 	return 0;
 err:
@@ -265,6 +401,17 @@ struct extension *phytec_add_extension(const char *name, const char *overlay,
 }
 #endif /* IS_ENABLED(CONFIG_CMD_EXTENSION) */
 
+struct phytec_api3_element *
+	__maybe_unused phytec_get_block_head(struct phytec_eeprom_data *data)
+{
+	if (!data)
+		data = &eeprom_data;
+	if (!data->valid)
+		return NULL;
+
+	return data->payload.block_head;
+}
+
 #else
 
 inline int phytec_eeprom_data_setup(struct phytec_eeprom_data *data,
@@ -305,6 +452,12 @@ u8 __maybe_unused phytec_get_som_type(struct phytec_eeprom_data *data)
 	return PHYTEC_EEPROM_INVAL;
 }
 
+inline struct phytec_api3_element * __maybe_unused
+	phytec_get_block_head(struct phytec_eeprom_data *data)
+{
+	return NULL;
+}
+
 #if IS_ENABLED(CONFIG_CMD_EXTENSION)
 inline struct extension *phytec_add_extension(const char *name,
 					      const char *overlay,
diff --git a/board/phytec/common/phytec_som_detection.h b/board/phytec/common/phytec_som_detection.h
index 1ccf36c8e7a..5e35a13cb21 100644
--- a/board/phytec/common/phytec_som_detection.h
+++ b/board/phytec/common/phytec_som_detection.h
@@ -7,6 +7,8 @@
 #ifndef _PHYTEC_SOM_DETECTION_H
 #define _PHYTEC_SOM_DETECTION_H
 
+#include "phytec_som_detection_blocks.h"
+
 #define PHYTEC_MAX_OPTIONS	17
 #define PHYTEC_EEPROM_INVAL	0xff
 
@@ -19,6 +21,7 @@ enum {
 	PHYTEC_API_REV0 = 0,
 	PHYTEC_API_REV1,
 	PHYTEC_API_REV2,
+	PHYTEC_API_REV3,
 };
 
 enum phytec_som_type_str {
@@ -63,6 +66,7 @@ struct phytec_eeprom_payload {
 		struct phytec_api0_data data_api0;
 		struct phytec_api2_data data_api2;
 	} data;
+	struct phytec_api3_element *block_head;
 } __packed;
 
 struct phytec_eeprom_data {
@@ -88,4 +92,7 @@ struct extension *phytec_add_extension(const char *name, const char *overlay,
 				       const char *other);
 #endif /* IS_ENABLED(CONFIG_CMD_EXTENSION) */
 
+struct phytec_api3_element *
+	__maybe_unused phytec_get_block_head(struct phytec_eeprom_data *data);
+
 #endif /* _PHYTEC_SOM_DETECTION_H */
diff --git a/board/phytec/common/phytec_som_detection_blocks.c b/board/phytec/common/phytec_som_detection_blocks.c
new file mode 100644
index 00000000000..5f3c27ef0c2
--- /dev/null
+++ b/board/phytec/common/phytec_som_detection_blocks.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
+ * Author: Daniel Schultz <d.schultz@phytec.de>
+ */
+
+#include <malloc.h>
+#include <u-boot/crc.h>
+#include <net.h>
+#include <vsprintf.h>
+
+#include "phytec_som_detection_blocks.h"
+
+#if IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION_BLOCKS)
+
+struct phytec_api3_element *
+	phytec_blocks_init_mac(struct phytec_api3_block_header *header,
+			       uint8_t *payload)
+{
+	struct phytec_api3_element *element;
+	struct phytec_api3_block_mac *mac;
+	unsigned int crc;
+	unsigned int len = sizeof(struct phytec_api3_block_mac);
+
+	if (!header)
+		return NULL;
+	if (!payload)
+		return NULL;
+
+	element = (struct phytec_api3_element *)
+			calloc(8, PHYTEC_API3_ELEMENT_HEADER_SIZE + len);
+	if (!element) {
+		pr_err("%s: Unable to allocate memory\n", __func__);
+		return NULL;
+	}
+	element->block_type = header->block_type;
+	memcpy(&element->block.mac, payload, len);
+	mac = &element->block.mac;
+
+	debug("%s: interface: %i\n", __func__, mac->interface);
+	debug("%s: MAC %pM\n", __func__, mac->address);
+
+	crc = crc8(0, (const unsigned char *)mac, len);
+	debug("%s: crc: %x\n", __func__, crc);
+	if (crc) {
+		pr_err("%s: CRC mismatch. API3 block payload is unusable\n",
+		       __func__);
+		return NULL;
+	}
+
+	return element;
+}
+
+int __maybe_unused
+	phytec_blocks_add_mac_to_env(struct phytec_api3_element *element)
+{
+	char enetenv[9] = "ethaddr";
+	char buf[ARP_HLEN_ASCII + 1];
+	struct phytec_api3_block_mac *block = &element->block.mac;
+	int ret;
+
+	if (!is_valid_ethaddr(block->address)) {
+		pr_err("%s: Invalid MAC address in block.\n", __func__);
+		return -1;
+	}
+
+	if (block->interface > 0) {
+		ret = sprintf(enetenv, "eth%iaddr", block->interface);
+		if (ret != 8) {
+			pr_err("%s: Unable to create env string\n", __func__);
+			return -1;
+		}
+	}
+
+	ret = sprintf(buf, "%pM", block->address);
+	if (ret != ARP_HLEN_ASCII) {
+		pr_err("%s: Unable to convert MAC address\n", __func__);
+		return -1;
+	}
+	ret = env_set(enetenv, buf);
+	if (ret) {
+		pr_err("%s: Failed to set MAC address to env.\n", __func__);
+		return -1;
+	}
+
+	debug("%s: Added %s to %s\n", __func__, buf, enetenv);
+	return 0;
+}
+
+#else
+
+inline struct phytec_api3_element *
+	phytec_api3_init_mac_block(struct phytec_api3_block_header *header,
+				   uint8_t *payload)
+{
+	return NULL;
+}
+
+inline int __maybe_unused
+	phytec_blocks_add_mac_to_env(struct phytec_api3_element *element)
+{
+	return -1;
+}
+
+#endif
diff --git a/board/phytec/common/phytec_som_detection_blocks.h b/board/phytec/common/phytec_som_detection_blocks.h
new file mode 100644
index 00000000000..2a5a83c9039
--- /dev/null
+++ b/board/phytec/common/phytec_som_detection_blocks.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
+ * Author: Daniel Schultz <d.schultz@phytec.de>
+ */
+
+#ifndef _PHYTEC_SOM_DETECTION_BLOCKS_H
+#define _PHYTEC_SOM_DETECTION_BLOCKS_H
+
+#define PHYTEC_API3_DATA_HEADER_LEN	8
+#define PHYTEC_API3_BLOCK_HEADER_LEN	4
+#define PHYTEC_API3_PAYLOAD_START					      \
+	(PHYTEC_API2_DATA_LEN + PHYTEC_API3_DATA_HEADER_LEN)
+
+#define PHYTEC_API3_ELEMENT_HEADER_SIZE					      \
+	(sizeof(struct phytec_api3_element *) +				      \
+		sizeof(enum phytec_api3_block_types))
+
+#define PHYTEC_API3_FOREACH_BLOCK(elem, data)				      \
+	for (elem = phytec_get_block_head(data); elem; elem = elem->next)
+
+struct phytec_api3_header {
+	u16 data_length;	/* Total length in Bytes of all blocks */
+	u8 block_count;		/* Number of blocks */
+	u8 sub_version;		/* Block specification version */
+	u8 reserved[3];		/* Reserved */
+	u8 crc8;		/* checksum */
+} __packed;
+
+struct phytec_api3_block_header {
+	u8 block_type;		/* Block payload identifier */
+	u16 next_block;		/* Address of the next block */
+	u8 crc8;		/* checksum */
+} __packed;
+
+enum phytec_api3_block_types {
+	PHYTEC_API3_BLOCK_MAC = 0,
+};
+
+struct phytec_api3_block_mac {
+	u8 interface;		/* Ethernet interface number */
+	u8 address[6];		/* MAC-Address */
+	u8 crc8;		/* checksum */
+} __packed;
+
+struct phytec_api3_element {
+	struct phytec_api3_element *next;
+	enum phytec_api3_block_types block_type;
+	union {
+		struct phytec_api3_block_mac mac;
+	} block;
+} __packed;
+
+struct phytec_api3_element *
+	phytec_blocks_init_mac(struct phytec_api3_block_header *header,
+			       uint8_t *payload);
+
+int __maybe_unused
+phytec_blocks_add_mac_to_env(struct phytec_api3_element *element);
+
+#endif /* _PHYTEC_SOM_DETECTION_BLOCKS_H */
-- 
2.25.1

