Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A90EC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:56:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C34C8885C;
	Mon, 15 Jul 2024 15:56:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bMdhXMmv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AADE3888A3; Mon, 15 Jul 2024 15:56:18 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5709288835
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:56:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a77e2f51496so520482966b.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 06:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721051776; x=1721656576; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/x83uhAgtPmXyFX07eC/O7WLqpmAACzSVrglNL9NB4Q=;
 b=bMdhXMmvxajYgvhl69PzN2ZQcprFXCGQ0Kyn7cCkASkL7Uii4xRPaCaNqQo4c3jF7f
 byoMla3t8KZndRFZ+s80FCbUUB4QCHN1uhCneZrcRRclDwAI/Ejob54CjuOcdbI9b0s2
 RBweWEReGvUPOIwQNkRbOAZO+rd5r8f8oo3iJmzlQyUGrQywHofNpfg7R5OH19GGRGzM
 qgCfcFZHrgvLd/JyBjcJQ/qw5LbRjj5mxQaNO0x/L6RNf7LLbpjON8CqqckT3Mj6jDIw
 RxVZ3Tg389NZMzQlkHWKKIo2e/QDpdgE9gh5SDMhjk6rOFriEOND+TyCObcvZRamJM00
 MYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721051776; x=1721656576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/x83uhAgtPmXyFX07eC/O7WLqpmAACzSVrglNL9NB4Q=;
 b=Zk2hpb3B5kLVByIhNzdqoQLcyd0Ss9fojTAo7A2SJOtLJ29pjaJu7ZoCZkMezodxts
 LNX0li/7LfJGD78xj71Us1PcpjA/r4bX6V9JIHDlqvsHBIHFYYF4w8JsLyWnLPJGlba8
 AZsEeAmj6RZbh9psPYdq7def1SOQj+Jl0HDhbbFLEbvBAJpnfxvTjki26Jk2KD4d5/8c
 NPv02whIh9JbCAHs+NLmpTXTeMjDcuwRf4ka8rwnVBJjaIFrV3dg3/ykqERrsGWxi0tf
 y2Cj2IWG9OD3iPAMOIKRdWvZlmyni4GgcElVFOE+fpeHF1FqdXCzHkiGUN6O73IF1nK5
 DEHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaUdESTW1s1PYZrymjjVVRnXURbmc6jXW2S1O0R2/Os6FkHlorsJlLZ00+F0Vt/83GLVAIBGQ0wgCEJ5ROeYixc+wClw==
X-Gm-Message-State: AOJu0Yyvh/jCdQGhZ6g51n8uc+ru8kAXfmLh150TtXmp88hCjIyi2Q0M
 AJ81eypvxSh/tkN1J9crBjbW79CmrJW4LhSDD7I5DUsGPjWpGNxj
X-Google-Smtp-Source: AGHT+IHPpD+P62FtzVEMDnMZgeFr1JSMF4gFq5zl6R2/HnDqhZRyMPOo8WRtL5f7veqS69z5F1pdXg==
X-Received: by 2002:a17:907:7d8a:b0:a6f:59dc:4ece with SMTP id
 a640c23a62f3a-a780b68a9ecmr1482293066b.2.1721051775581; 
 Mon, 15 Jul 2024 06:56:15 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl.
 [31.11.218.106]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc820fb5sm214152666b.212.2024.07.15.06.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 06:56:15 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Walle <michael@walle.cc>,
 Miquel Raynal <miquel.raynal@bootlin.com>, devicetree@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 u-boot@lists.denx.de, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/2] nvmem: layouts: add U-Boot env layout
Date: Mon, 15 Jul 2024 15:54:34 +0200
Message-Id: <20240715135434.24992-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240715135434.24992-1-zajec5@gmail.com>
References: <20240715135434.24992-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Rafał Miłecki <rafal@milecki.pl>

U-Boot environment variables are stored in a specific format. Actual
data can be placed in various storage sources (MTD, UBI volume, EEPROM,
NVRAM, etc.).

Move all generic (NVMEM device independent) code from NVMEM device
driver to an NVMEM layout driver. Then add a simple NVMEM layout code on
top of it.

This allows using NVMEM layout for parsing U-Boot env data stored in any
kind of NVMEM device.

The old NVMEM glue driver stays in place for handling bindings in the
MTD context. To avoid code duplication it uses exported layout parsing
function. Please note that handling MTD & NVMEM layout bindings may be
refactored in the future.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
This change was originally sent (and approved by Miquel) as a
[PATCH V3 6/6] nvmem: layouts: add U-Boot env layout

I just adjusted it to the approved binding and updated commit message.
I kept Miquel's Reviewed-by tag due to minimal changes.

I've successfully tested this code using it in both ways: as NVMEM
device driver & NVMEM layout.

 MAINTAINERS                        |   1 +
 drivers/nvmem/Kconfig              |   3 +-
 drivers/nvmem/layouts/Kconfig      |  11 ++
 drivers/nvmem/layouts/Makefile     |   1 +
 drivers/nvmem/layouts/u-boot-env.c | 203 +++++++++++++++++++++++++++++
 drivers/nvmem/layouts/u-boot-env.h |  15 +++
 drivers/nvmem/u-boot-env.c         | 158 +---------------------
 7 files changed, 234 insertions(+), 158 deletions(-)
 create mode 100644 drivers/nvmem/layouts/u-boot-env.c
 create mode 100644 drivers/nvmem/layouts/u-boot-env.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 31fb0031a5e8..630d16c480dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23331,6 +23331,7 @@ U-BOOT ENVIRONMENT VARIABLES
 M:	Rafał Miłecki <rafal@milecki.pl>
 S:	Maintained
 F:	Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+F:	drivers/nvmem/layouts/u-boot-env.c
 F:	drivers/nvmem/u-boot-env.c
 
 UACCE ACCELERATOR FRAMEWORK
diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 283134498fbc..d2c384f58028 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -363,8 +363,7 @@ config NVMEM_SUNXI_SID
 config NVMEM_U_BOOT_ENV
 	tristate "U-Boot environment variables support"
 	depends on OF && MTD
-	select CRC32
-	select GENERIC_NET_UTILS
+	select NVMEM_LAYOUT_U_BOOT_ENV
 	help
 	  U-Boot stores its setup as environment variables. This driver adds
 	  support for verifying & exporting such data. It also exposes variables
diff --git a/drivers/nvmem/layouts/Kconfig b/drivers/nvmem/layouts/Kconfig
index 9c6e672fc350..5e586dfebe47 100644
--- a/drivers/nvmem/layouts/Kconfig
+++ b/drivers/nvmem/layouts/Kconfig
@@ -26,6 +26,17 @@ config NVMEM_LAYOUT_ONIE_TLV
 
 	  If unsure, say N.
 
+config NVMEM_LAYOUT_U_BOOT_ENV
+	tristate "U-Boot environment variables layout"
+	select CRC32
+	select GENERIC_NET_UTILS
+	help
+	  U-Boot stores its setup as environment variables. This driver adds
+	  support for verifying & exporting such data. It also exposes variables
+	  as NVMEM cells so they can be referenced by other drivers.
+
+	  If unsure, say N.
+
 endmenu
 
 endif
diff --git a/drivers/nvmem/layouts/Makefile b/drivers/nvmem/layouts/Makefile
index 2974bd7d33ed..4940c9db0665 100644
--- a/drivers/nvmem/layouts/Makefile
+++ b/drivers/nvmem/layouts/Makefile
@@ -5,3 +5,4 @@
 
 obj-$(CONFIG_NVMEM_LAYOUT_SL28_VPD) += sl28vpd.o
 obj-$(CONFIG_NVMEM_LAYOUT_ONIE_TLV) += onie-tlv.o
+obj-$(CONFIG_NVMEM_LAYOUT_U_BOOT_ENV) += u-boot-env.o
diff --git a/drivers/nvmem/layouts/u-boot-env.c b/drivers/nvmem/layouts/u-boot-env.c
new file mode 100644
index 000000000000..5217dc4a52f8
--- /dev/null
+++ b/drivers/nvmem/layouts/u-boot-env.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 - 2023 Rafał Miłecki <rafal@milecki.pl>
+ */
+
+#include <linux/crc32.h>
+#include <linux/etherdevice.h>
+#include <linux/export.h>
+#include <linux/if_ether.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+
+#include "u-boot-env.h"
+
+struct u_boot_env_image_single {
+	__le32 crc32;
+	uint8_t data[];
+} __packed;
+
+struct u_boot_env_image_redundant {
+	__le32 crc32;
+	u8 mark;
+	uint8_t data[];
+} __packed;
+
+struct u_boot_env_image_broadcom {
+	__le32 magic;
+	__le32 len;
+	__le32 crc32;
+	DECLARE_FLEX_ARRAY(uint8_t, data);
+} __packed;
+
+static int u_boot_env_read_post_process_ethaddr(void *context, const char *id, int index,
+						unsigned int offset, void *buf, size_t bytes)
+{
+	u8 mac[ETH_ALEN];
+
+	if (bytes != 3 * ETH_ALEN - 1)
+		return -EINVAL;
+
+	if (!mac_pton(buf, mac))
+		return -EINVAL;
+
+	if (index)
+		eth_addr_add(mac, index);
+
+	ether_addr_copy(buf, mac);
+
+	return 0;
+}
+
+static int u_boot_env_parse_cells(struct device *dev, struct nvmem_device *nvmem, uint8_t *buf,
+				  size_t data_offset, size_t data_len)
+{
+	char *data = buf + data_offset;
+	char *var, *value, *eq;
+
+	for (var = data;
+	     var < data + data_len && *var;
+	     var = value + strlen(value) + 1) {
+		struct nvmem_cell_info info = {};
+
+		eq = strchr(var, '=');
+		if (!eq)
+			break;
+		*eq = '\0';
+		value = eq + 1;
+
+		info.name = devm_kstrdup(dev, var, GFP_KERNEL);
+		if (!info.name)
+			return -ENOMEM;
+		info.offset = data_offset + value - data;
+		info.bytes = strlen(value);
+		info.np = of_get_child_by_name(dev->of_node, info.name);
+		if (!strcmp(var, "ethaddr")) {
+			info.raw_len = strlen(value);
+			info.bytes = ETH_ALEN;
+			info.read_post_process = u_boot_env_read_post_process_ethaddr;
+		}
+
+		nvmem_add_one_cell(nvmem, &info);
+	}
+
+	return 0;
+}
+
+int u_boot_env_parse(struct device *dev, struct nvmem_device *nvmem,
+		     enum u_boot_env_format format)
+{
+	size_t crc32_data_offset;
+	size_t crc32_data_len;
+	size_t crc32_offset;
+	__le32 *crc32_addr;
+	size_t data_offset;
+	size_t data_len;
+	size_t dev_size;
+	uint32_t crc32;
+	uint32_t calc;
+	uint8_t *buf;
+	int bytes;
+	int err;
+
+	dev_size = nvmem_dev_size(nvmem);
+
+	buf = kzalloc(dev_size, GFP_KERNEL);
+	if (!buf) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	bytes = nvmem_device_read(nvmem, 0, dev_size, buf);
+	if (bytes < 0) {
+		err = bytes;
+		goto err_kfree;
+	} else if (bytes != dev_size) {
+		err = -EIO;
+		goto err_kfree;
+	}
+
+	switch (format) {
+	case U_BOOT_FORMAT_SINGLE:
+		crc32_offset = offsetof(struct u_boot_env_image_single, crc32);
+		crc32_data_offset = offsetof(struct u_boot_env_image_single, data);
+		data_offset = offsetof(struct u_boot_env_image_single, data);
+		break;
+	case U_BOOT_FORMAT_REDUNDANT:
+		crc32_offset = offsetof(struct u_boot_env_image_redundant, crc32);
+		crc32_data_offset = offsetof(struct u_boot_env_image_redundant, data);
+		data_offset = offsetof(struct u_boot_env_image_redundant, data);
+		break;
+	case U_BOOT_FORMAT_BROADCOM:
+		crc32_offset = offsetof(struct u_boot_env_image_broadcom, crc32);
+		crc32_data_offset = offsetof(struct u_boot_env_image_broadcom, data);
+		data_offset = offsetof(struct u_boot_env_image_broadcom, data);
+		break;
+	}
+	crc32_addr = (__le32 *)(buf + crc32_offset);
+	crc32 = le32_to_cpu(*crc32_addr);
+	crc32_data_len = dev_size - crc32_data_offset;
+	data_len = dev_size - data_offset;
+
+	calc = crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L;
+	if (calc != crc32) {
+		dev_err(dev, "Invalid calculated CRC32: 0x%08x (expected: 0x%08x)\n", calc, crc32);
+		err = -EINVAL;
+		goto err_kfree;
+	}
+
+	buf[dev_size - 1] = '\0';
+	err = u_boot_env_parse_cells(dev, nvmem, buf, data_offset, data_len);
+
+err_kfree:
+	kfree(buf);
+err_out:
+	return err;
+}
+EXPORT_SYMBOL_GPL(u_boot_env_parse);
+
+static int u_boot_env_add_cells(struct nvmem_layout *layout)
+{
+	struct device *dev = &layout->dev;
+	enum u_boot_env_format format;
+
+	format = (uintptr_t)device_get_match_data(dev);
+
+	return u_boot_env_parse(dev, layout->nvmem, format);
+}
+
+static int u_boot_env_probe(struct nvmem_layout *layout)
+{
+	layout->add_cells = u_boot_env_add_cells;
+
+	return nvmem_layout_register(layout);
+}
+
+static void u_boot_env_remove(struct nvmem_layout *layout)
+{
+	nvmem_layout_unregister(layout);
+}
+
+static const struct of_device_id u_boot_env_of_match_table[] = {
+	{ .compatible = "u-boot,env", .data = (void *)U_BOOT_FORMAT_SINGLE, },
+	{ .compatible = "u-boot,env-redundant-bool", .data = (void *)U_BOOT_FORMAT_REDUNDANT, },
+	{ .compatible = "u-boot,env-redundant-count", .data = (void *)U_BOOT_FORMAT_REDUNDANT, },
+	{ .compatible = "brcm,env", .data = (void *)U_BOOT_FORMAT_BROADCOM, },
+	{},
+};
+
+static struct nvmem_layout_driver u_boot_env_layout = {
+	.driver = {
+		.name = "u-boot-env-layout",
+		.of_match_table = u_boot_env_of_match_table,
+	},
+	.probe = u_boot_env_probe,
+	.remove = u_boot_env_remove,
+};
+module_nvmem_layout_driver(u_boot_env_layout);
+
+MODULE_AUTHOR("Rafał Miłecki");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(of, u_boot_env_of_match_table);
diff --git a/drivers/nvmem/layouts/u-boot-env.h b/drivers/nvmem/layouts/u-boot-env.h
new file mode 100644
index 000000000000..dd5f280ac047
--- /dev/null
+++ b/drivers/nvmem/layouts/u-boot-env.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _LINUX_NVMEM_LAYOUTS_U_BOOT_ENV_H
+#define _LINUX_NVMEM_LAYOUTS_U_BOOT_ENV_H
+
+enum u_boot_env_format {
+	U_BOOT_FORMAT_SINGLE,
+	U_BOOT_FORMAT_REDUNDANT,
+	U_BOOT_FORMAT_BROADCOM,
+};
+
+int u_boot_env_parse(struct device *dev, struct nvmem_device *nvmem,
+		     enum u_boot_env_format format);
+
+#endif  /* ifndef _LINUX_NVMEM_LAYOUTS_U_BOOT_ENV_H */
diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index 936e39b20b38..ced414fc9e60 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -3,23 +3,15 @@
  * Copyright (C) 2022 Rafał Miłecki <rafal@milecki.pl>
  */
 
-#include <linux/crc32.h>
-#include <linux/etherdevice.h>
-#include <linux/if_ether.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mtd/mtd.h>
-#include <linux/nvmem-consumer.h>
 #include <linux/nvmem-provider.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-enum u_boot_env_format {
-	U_BOOT_FORMAT_SINGLE,
-	U_BOOT_FORMAT_REDUNDANT,
-	U_BOOT_FORMAT_BROADCOM,
-};
+#include "layouts/u-boot-env.h"
 
 struct u_boot_env {
 	struct device *dev;
@@ -29,24 +21,6 @@ struct u_boot_env {
 	struct mtd_info *mtd;
 };
 
-struct u_boot_env_image_single {
-	__le32 crc32;
-	uint8_t data[];
-} __packed;
-
-struct u_boot_env_image_redundant {
-	__le32 crc32;
-	u8 mark;
-	uint8_t data[];
-} __packed;
-
-struct u_boot_env_image_broadcom {
-	__le32 magic;
-	__le32 len;
-	__le32 crc32;
-	DECLARE_FLEX_ARRAY(uint8_t, data);
-} __packed;
-
 static int u_boot_env_read(void *context, unsigned int offset, void *val,
 			   size_t bytes)
 {
@@ -69,134 +43,6 @@ static int u_boot_env_read(void *context, unsigned int offset, void *val,
 	return 0;
 }
 
-static int u_boot_env_read_post_process_ethaddr(void *context, const char *id, int index,
-						unsigned int offset, void *buf, size_t bytes)
-{
-	u8 mac[ETH_ALEN];
-
-	if (bytes != 3 * ETH_ALEN - 1)
-		return -EINVAL;
-
-	if (!mac_pton(buf, mac))
-		return -EINVAL;
-
-	if (index)
-		eth_addr_add(mac, index);
-
-	ether_addr_copy(buf, mac);
-
-	return 0;
-}
-
-static int u_boot_env_add_cells(struct u_boot_env *priv, uint8_t *buf,
-				size_t data_offset, size_t data_len)
-{
-	struct nvmem_device *nvmem = priv->nvmem;
-	struct device *dev = priv->dev;
-	char *data = buf + data_offset;
-	char *var, *value, *eq;
-
-	for (var = data;
-	     var < data + data_len && *var;
-	     var = value + strlen(value) + 1) {
-		struct nvmem_cell_info info = {};
-
-		eq = strchr(var, '=');
-		if (!eq)
-			break;
-		*eq = '\0';
-		value = eq + 1;
-
-		info.name = devm_kstrdup(dev, var, GFP_KERNEL);
-		if (!info.name)
-			return -ENOMEM;
-		info.offset = data_offset + value - data;
-		info.bytes = strlen(value);
-		info.np = of_get_child_by_name(dev->of_node, info.name);
-		if (!strcmp(var, "ethaddr")) {
-			info.raw_len = strlen(value);
-			info.bytes = ETH_ALEN;
-			info.read_post_process = u_boot_env_read_post_process_ethaddr;
-		}
-
-		nvmem_add_one_cell(nvmem, &info);
-	}
-
-	return 0;
-}
-
-static int u_boot_env_parse(struct u_boot_env *priv)
-{
-	struct nvmem_device *nvmem = priv->nvmem;
-	struct device *dev = priv->dev;
-	size_t crc32_data_offset;
-	size_t crc32_data_len;
-	size_t crc32_offset;
-	__le32 *crc32_addr;
-	size_t data_offset;
-	size_t data_len;
-	size_t dev_size;
-	uint32_t crc32;
-	uint32_t calc;
-	uint8_t *buf;
-	int bytes;
-	int err;
-
-	dev_size = nvmem_dev_size(nvmem);
-
-	buf = kzalloc(dev_size, GFP_KERNEL);
-	if (!buf) {
-		err = -ENOMEM;
-		goto err_out;
-	}
-
-	bytes = nvmem_device_read(nvmem, 0, dev_size, buf);
-	if (bytes < 0) {
-		err = bytes;
-		goto err_kfree;
-	} else if (bytes != dev_size) {
-		err = -EIO;
-		goto err_kfree;
-	}
-
-	switch (priv->format) {
-	case U_BOOT_FORMAT_SINGLE:
-		crc32_offset = offsetof(struct u_boot_env_image_single, crc32);
-		crc32_data_offset = offsetof(struct u_boot_env_image_single, data);
-		data_offset = offsetof(struct u_boot_env_image_single, data);
-		break;
-	case U_BOOT_FORMAT_REDUNDANT:
-		crc32_offset = offsetof(struct u_boot_env_image_redundant, crc32);
-		crc32_data_offset = offsetof(struct u_boot_env_image_redundant, data);
-		data_offset = offsetof(struct u_boot_env_image_redundant, data);
-		break;
-	case U_BOOT_FORMAT_BROADCOM:
-		crc32_offset = offsetof(struct u_boot_env_image_broadcom, crc32);
-		crc32_data_offset = offsetof(struct u_boot_env_image_broadcom, data);
-		data_offset = offsetof(struct u_boot_env_image_broadcom, data);
-		break;
-	}
-	crc32_addr = (__le32 *)(buf + crc32_offset);
-	crc32 = le32_to_cpu(*crc32_addr);
-	crc32_data_len = dev_size - crc32_data_offset;
-	data_len = dev_size - data_offset;
-
-	calc = crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L;
-	if (calc != crc32) {
-		dev_err(dev, "Invalid calculated CRC32: 0x%08x (expected: 0x%08x)\n", calc, crc32);
-		err = -EINVAL;
-		goto err_kfree;
-	}
-
-	buf[dev_size - 1] = '\0';
-	err = u_boot_env_add_cells(priv, buf, data_offset, data_len);
-
-err_kfree:
-	kfree(buf);
-err_out:
-	return err;
-}
-
 static int u_boot_env_probe(struct platform_device *pdev)
 {
 	struct nvmem_config config = {
@@ -228,7 +74,7 @@ static int u_boot_env_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->nvmem))
 		return PTR_ERR(priv->nvmem);
 
-	return u_boot_env_parse(priv);
+	return u_boot_env_parse(dev, priv->nvmem, priv->format);
 }
 
 static const struct of_device_id u_boot_env_of_match_table[] = {
-- 
2.35.3

