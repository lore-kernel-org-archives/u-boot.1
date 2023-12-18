Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45560C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 13:38:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 487E287E04;
	Mon, 18 Dec 2023 14:37:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cRN1tuD6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83FD1871CE; Mon, 18 Dec 2023 14:37:49 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 263FC87CD0
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 14:37:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-552ff8d681aso3333616a12.1
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 05:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702906666; x=1703511466; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5NnQuhRM2aKmxMX4UvGIlLC0dqge59QIibPSitP1r8c=;
 b=cRN1tuD6c0xFKWsjnBCkYxW/yzj5ynb8JtTAopTCcl0MKuhuPhOHDT+U+mFl0hc8Xi
 oLSedzupsfKsOLI1WuyiMDIJn0G0MVGe1XwrHeiEgdySQznGPV8COdtRkhF1DtVssBlz
 JPEwtYJVKSVekv7r7SIoyWG+4GyVQAK4Ono4DS2C+O7V36kJf8R0pnm56ys2lf9BIDiX
 8aZDVrng2MNyWK0bXSZJFSYhsRf5nimkogL/tcTR3Fmzo1/v1H0ohcal08ZK3PLRMsdu
 iPsDpcgF+nhOYF6T9sEz+E3jg3Fcnw2ueJD8fMHlp76uxEnjrV6WCNkU5oWvFOINSROE
 fhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702906666; x=1703511466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5NnQuhRM2aKmxMX4UvGIlLC0dqge59QIibPSitP1r8c=;
 b=iHObDzD+XHdIv8hfljXRvuvXvUHScHJw+U14HrumzbdmFl32qvxcqHFlDzp80xviCP
 jIL6WLTRwVIH+DxnpfI3mR8MKdULs9yyZZp7JOdKqPasJeRcHLfZnCPX4qRIMAuJUkBL
 NZUnkzUwSbad+/l+cPyKwhB0pd2cFDVpNSWVG+iVC1pIZyVHZjrZYj0lksLqn9mhYQ/+
 9llFoxQA9icfex16KqabKgyfTXSH6V/D3GX5zti9JIsY8BnmgfOGQJNUYHPjjSIRLcH8
 Tyo/1pj+f4SM7h7wX57mntB2ii+cCxO0cbwbn1ranLmTZ1+lcmmU/aqqhqKGSk5F7NP7
 7kFw==
X-Gm-Message-State: AOJu0Yxy1pXq+oH5MxF4wD0gCA85rpQ2WKqPYed7msJwOifWdV+UbhYD
 0wG3dhOzgjV6UT2Hashfjn4=
X-Google-Smtp-Source: AGHT+IHfTv+BKJWGNsKj+Odg60M5z2SLEb0xSXLQVDZohpDTBi8IGg8TUepkJ6sZFipc+PIZqYgp3w==
X-Received: by 2002:a17:906:5345:b0:a1c:b707:cbd1 with SMTP id
 j5-20020a170906534500b00a1cb707cbd1mr13446680ejo.24.1702906666210; 
 Mon, 18 Dec 2023 05:37:46 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl.
 [31.11.218.106]) by smtp.gmail.com with ESMTPSA id
 f20-20020a1709067f9400b00a234907311asm1891537ejr.55.2023.12.18.05.37.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 05:37:45 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Walle <michael@walle.cc>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 4/4] nvmem: layouts: add U-Boot env layout
Date: Mon, 18 Dec 2023 14:37:22 +0100
Message-Id: <20231218133722.16150-4-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231218133722.16150-1-zajec5@gmail.com>
References: <20231218133722.16150-1-zajec5@gmail.com>
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

This patch moves all generic (NVMEM devices independent) code from NVMEM
device driver to NVMEM layout driver. Then it adds a simple NVMEM layout
code on top of it.

Thanks to proper layout it's possible to support U-Boot env data stored
on any kind of NVMEM device.

For backward compatibility with old DT bindings we need to keep old
NVMEM device driver functional. To avoid code duplication a parsing
function is exported and reused in it.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 MAINTAINERS                        |   1 +
 drivers/nvmem/Kconfig              |   3 +-
 drivers/nvmem/layouts/Kconfig      |  11 ++
 drivers/nvmem/layouts/Makefile     |   1 +
 drivers/nvmem/layouts/u-boot-env.c | 212 +++++++++++++++++++++++++++++
 drivers/nvmem/layouts/u-boot-env.h |  15 ++
 drivers/nvmem/u-boot-env.c         | 155 +--------------------
 7 files changed, 243 insertions(+), 155 deletions(-)
 create mode 100644 drivers/nvmem/layouts/u-boot-env.c
 create mode 100644 drivers/nvmem/layouts/u-boot-env.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b589218605b4..1f7e6d74cd51 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22282,6 +22282,7 @@ U-BOOT ENVIRONMENT VARIABLES
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
index 000000000000..1787cfaf45f8
--- /dev/null
+++ b/drivers/nvmem/layouts/u-boot-env.c
@@ -0,0 +1,212 @@
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
+static const struct of_device_id u_boot_env_of_match_table[] = {
+	{ .compatible = "u-boot,env", .data = (void *)U_BOOT_FORMAT_SINGLE, },
+	{ .compatible = "u-boot,env-redundant-bool", .data = (void *)U_BOOT_FORMAT_REDUNDANT, },
+	{ .compatible = "u-boot,env-redundant-count", .data = (void *)U_BOOT_FORMAT_REDUNDANT, },
+	{ .compatible = "brcm,env", .data = (void *)U_BOOT_FORMAT_BROADCOM, },
+	{},
+};
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
+	buf = kcalloc(1, dev_size, GFP_KERNEL);
+	if (!buf) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	bytes = nvmem_device_read(nvmem, 0, dev_size, buf);
+	if (bytes < 0)
+		return bytes;
+	else if (bytes != dev_size)
+		return -EIO;
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
+	crc32 = le32_to_cpu(*(__le32 *)(buf + crc32_offset));
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
+	if (err)
+		dev_err(dev, "Failed to add cells: %d\n", err);
+
+err_kfree:
+	kfree(buf);
+err_out:
+	return err;
+}
+EXPORT_SYMBOL_GPL(u_boot_env_parse);
+
+static int u_boot_env_add_cells(struct device *dev, struct nvmem_device *nvmem)
+{
+	const struct of_device_id *match;
+	struct device_node *layout_np;
+	enum u_boot_env_format format;
+
+	layout_np = of_nvmem_layout_get_container(nvmem);
+	if (!layout_np)
+		return -ENOENT;
+
+	match = of_match_node(u_boot_env_of_match_table, layout_np);
+	if (!match)
+		return -ENOENT;
+
+	format = (uintptr_t)match->data;
+
+	of_node_put(layout_np);
+
+	return u_boot_env_parse(dev, nvmem, format);
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
+static struct nvmem_layout_driver u_boot_env_layout = {
+	.driver = {
+		.owner = THIS_MODULE,
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
index ab8c9bf63d99..386b2b255c30 100644
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
@@ -69,131 +43,6 @@ static int u_boot_env_read(void *context, unsigned int offset, void *val,
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
-	buf = kcalloc(1, dev_size, GFP_KERNEL);
-	if (!buf) {
-		err = -ENOMEM;
-		goto err_out;
-	}
-
-	bytes = nvmem_device_read(nvmem, 0, dev_size, buf);
-	if (bytes < 0)
-		return bytes;
-	else if (bytes != dev_size)
-		return -EIO;
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
-	crc32 = le32_to_cpu(*(__le32 *)(buf + crc32_offset));
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
-	if (err)
-		dev_err(dev, "Failed to add cells: %d\n", err);
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
@@ -225,7 +74,7 @@ static int u_boot_env_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->nvmem))
 		return PTR_ERR(priv->nvmem);
 
-	return u_boot_env_parse(priv);
+	return u_boot_env_parse(dev, priv->nvmem, priv->format);
 }
 
 static const struct of_device_id u_boot_env_of_match_table[] = {
-- 
2.35.3

