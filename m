Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D5BCD5BD5
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 09:53:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09A96846E2;
	Wed, 27 May 2026 11:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="I6/jtSxJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58DDD846AA; Wed, 27 May 2026 11:52:30 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAE7A844CF
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 11:52:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=Tbv+sDm8iaJL+soStl789snPbw2VuM0O8MqIa3pxKd8=; b=I6/jtSxJt9B5OOTZq9kPckVJse
 l/Sd9/LdSBljX9ED1dz5CHpsyPJRyrqbOqHZbr9axgGEEBcTZgf0iPNvDVnvn4fiiCx/wPXcR0f34
 pvGfjJfmdxO+2v/8NYxXJp7Up4PITzqkA5GMUX5SdtCA9nK01qV6CTgrQ+227UwL3TplYnARLXSdG
 +bx/twVQJasinjRmxCbvWGmR+TmxJtS+9dRfo/Fwpnt+KoISLwnsj/mIa1e1YWNF5HD7eE6Pyg+KW
 9EQpNu66eUutYcGbPGcYqT4U1QN1vLZ1gMGwoFHC04wctiSbqgEJNHdcrOt1CM32InYeawSXK5+Al
 S4zVqZZw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wSAw5-0002Rn-1L; Wed, 27 May 2026 11:52:25 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wSAw4-000JXI-1V; Wed, 27 May 2026 11:52:25 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>,
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>
Subject: [PATCH v3 3/7] sysinfo: tq_eeprom: new driver
Date: Wed, 27 May 2026 11:51:19 +0200
Message-Id: <20260527095123.50797-4-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527095123.50797-1-Alexander.Feilke@ew.tq-group.com>
References: <20260527095123.50797-1-Alexander.Feilke@ew.tq-group.com>
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

From: Nora Schiffer <nora.schiffer@ew.tq-group.com>

Introduce a sysinfo driver that can be instantiated from the device,
which will provide information from the EEPROM found on all TQ-Systems
SoMs.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 MAINTAINERS                                   |   1 +
 configs/tqma7_common.config                   |   1 +
 .../sysinfo/tq,eeprom-sysinfo.txt             |  36 ++++
 drivers/sysinfo/Kconfig                       |   8 +
 drivers/sysinfo/Makefile                      |   1 +
 drivers/sysinfo/tq_eeprom.c                   | 203 ++++++++++++++++++
 include/sysinfo/tq_eeprom.h                   |  24 +++
 7 files changed, 274 insertions(+)
 create mode 100644 doc/device-tree-bindings/sysinfo/tq,eeprom-sysinfo.txt
 create mode 100644 drivers/sysinfo/tq_eeprom.c
 create mode 100644 include/sysinfo/tq_eeprom.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ea646f618a5..4ac87264090 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1877,6 +1877,7 @@ S:	Maintained
 W:	https://www.tq-group.com/en/products/tq-embedded/
 F:	board/tq/*
 F:	doc/board/tq/*
+F:	drivers/sysinfo/tq_eeprom.c
 F:	include/configs/tq*.h
 F:	include/env/tq/*
 
diff --git a/configs/tqma7_common.config b/configs/tqma7_common.config
index 7e5e31a14ab..9b055849ad1 100644
--- a/configs/tqma7_common.config
+++ b/configs/tqma7_common.config
@@ -77,6 +77,7 @@ CONFIG_I2C_DEFAULT_BUS_NUMBER=0x3
 CONFIG_SYS_I2C_MXC=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
+CONFIG_NVMEM=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
 CONFIG_MTD=y
diff --git a/doc/device-tree-bindings/sysinfo/tq,eeprom-sysinfo.txt b/doc/device-tree-bindings/sysinfo/tq,eeprom-sysinfo.txt
new file mode 100644
index 00000000000..678fff0e812
--- /dev/null
+++ b/doc/device-tree-bindings/sysinfo/tq,eeprom-sysinfo.txt
@@ -0,0 +1,36 @@
+TQ EEPROM Sysinfo Driver
+------------------------
+
+This binding describes a sysinfo provider which retrieves system
+identification information from an I2C EEPROM device.
+
+Required properties:
+
+- compatible: "tq,eeprom-sysinfo"
+- nvmem-cells: phandle referencing the nvmem cell
+- nvmem-cell-names: string, should be "device_info"
+
+Example:
+
+&i2c1 {
+	eeprom@50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+
+		nvmem-layout {
+			compatible = "fixed-layout";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			module_info: module-info@20 {
+				reg = <0x20 0x60>;
+			};
+		};
+	};
+};
+
+sysinfo {
+	compatible = "tq,eeprom-sysinfo";
+	nvmem-cells = <&module_info>;
+	nvmem-cell-names = "device_info";
+};
diff --git a/drivers/sysinfo/Kconfig b/drivers/sysinfo/Kconfig
index df83df69ffb..6922dac9170 100644
--- a/drivers/sysinfo/Kconfig
+++ b/drivers/sysinfo/Kconfig
@@ -59,4 +59,12 @@ config SYSINFO_GPIO
 	  This ternary number is then mapped to a board revision name using
 	  device tree properties.
 
+config SYSINFO_TQ_EEPROM
+	bool "Enable TQ-Systems EEPROM sysinfo driver"
+	depends on I2C_EEPROM
+	depends on SPL_I2C_EEPROM || !SPL_SYSINFO
+	help
+	  Support querying EEPROM of TQ-Systems SOMs to determine board
+	  information.
+
 endif
diff --git a/drivers/sysinfo/Makefile b/drivers/sysinfo/Makefile
index 26ca3150999..d21fb3c2270 100644
--- a/drivers/sysinfo/Makefile
+++ b/drivers/sysinfo/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_SYSINFO_IOT2050) += iot2050.o
 obj-$(CONFIG_SYSINFO_RCAR3) += rcar3.o
 obj-$(CONFIG_SYSINFO_SANDBOX) += sandbox.o
 obj-$(CONFIG_SYSINFO_SMBIOS) += smbios.o
+obj-$(CONFIG_SYSINFO_TQ_EEPROM) += tq_eeprom.o
diff --git a/drivers/sysinfo/tq_eeprom.c b/drivers/sysinfo/tq_eeprom.c
new file mode 100644
index 00000000000..63be07b664e
--- /dev/null
+++ b/drivers/sysinfo/tq_eeprom.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2014-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Nora Schiffer
+ */
+
+#include <dm.h>
+#include <log.h>
+#include <net.h>
+#include <dm/device_compat.h>
+#include <linux/build_bug.h>
+#include <linux/ctype.h>
+#include <nvmem.h>
+#include <sysinfo/tq_eeprom.h>
+
+#define TQ_EE_RSV1_BYTES		10
+#define TQ_EE_SERIAL_BYTES		8
+#define TQ_EE_RSV2_BYTES		8
+#define TQ_EE_BDID_BYTES		0x40
+
+struct tq_eeprom_data {
+	u8 mac[ETH_ALEN];		/* 0x20 ... 0x25 */
+	u8 rsv1[TQ_EE_RSV1_BYTES];
+	u8 serial[TQ_EE_SERIAL_BYTES];	/* 0x30 ... 0x37 */
+	u8 rsv2[TQ_EE_RSV2_BYTES];
+	u8 id[TQ_EE_BDID_BYTES];	/* 0x40 ... 0x7f */
+};
+
+static_assert(sizeof(struct tq_eeprom_data) == 0x60,
+	      "struct tq_eeprom_data has incorrect size");
+
+/**
+ * struct sysinfo_tq_eeprom_priv - sysinfo private data
+ */
+struct sysinfo_tq_eeprom_priv {
+	struct nvmem_cell device_info_cell;
+
+	/* Reserve extra space for \0 in id and serial */
+	char id[TQ_EE_BDID_BYTES + 1];
+	char serial[TQ_EE_SERIAL_BYTES + 1];
+	u8 mac[ETH_ALEN];
+};
+
+static void tq_eeprom_parse_id(struct udevice *dev, const struct tq_eeprom_data *data)
+{
+	struct sysinfo_tq_eeprom_priv *priv = dev_get_priv(dev);
+	int i;
+
+	for (i = 0; i < sizeof(data->id); i++) {
+		if (!(isprint(data->id[i]) && isascii(data->id[i])))
+			break;
+	}
+
+	if (i == 0)
+		dev_warn(dev, "no valid model name in EEPROM\n");
+
+	snprintf(priv->id, sizeof(priv->id), "%.*s", i, data->id);
+}
+
+static int tq_eeprom_serial_len(const struct tq_eeprom_data *data, bool allow_upper)
+{
+	int i;
+
+	for (i = 0; i < sizeof(data->serial); i++) {
+		if (!(isdigit(data->serial[i]) || (allow_upper && isupper(data->serial[i]))))
+			break;
+	}
+
+	return i;
+}
+
+static void tq_eeprom_parse_serial(struct udevice *dev, const struct tq_eeprom_data *data)
+{
+	struct sysinfo_tq_eeprom_priv *priv = dev_get_priv(dev);
+	bool use_new_format;
+	int len;
+
+	use_new_format = data->serial[0] == 'T' && data->serial[1] == 'Q';
+
+	len = tq_eeprom_serial_len(data, use_new_format);
+
+	/* For now, only serial numbers with the exact size of the field are accepted */
+	if (len != sizeof(data->serial)) {
+		dev_warn(dev, "no valid serial number in EEPROM\n");
+		len = 0;
+	}
+
+	snprintf(priv->serial, sizeof(priv->serial), "%.*s", len, data->serial);
+}
+
+static int tq_eeprom_dump(const struct sysinfo_tq_eeprom_priv *priv)
+{
+	printf("TQ EEPROM:\n");
+	printf("  ID:  %s\n", priv->id[0] ? priv->id : "<invalid>");
+	printf("  SN:  %s\n", priv->serial[0] ? priv->serial : "<invalid>");
+	printf("  MAC: ");
+	if (is_valid_ethaddr(priv->mac))
+		printf("%pM\n", priv->mac);
+	else
+		printf("<invalid>\n");
+
+	return 0;
+}
+
+static int sysinfo_tq_eeprom_detect(struct udevice *dev)
+{
+	struct sysinfo_tq_eeprom_priv *priv = dev_get_priv(dev);
+	struct tq_eeprom_data data;
+	int ret;
+
+	ret = nvmem_cell_read(&priv->device_info_cell, (u8 *)&data, sizeof(data));
+	if (ret < 0) {
+		dev_err(dev, "EEPROM read failed: %d\n", ret);
+		return ret;
+	}
+
+	tq_eeprom_parse_id(dev, &data);
+	tq_eeprom_parse_serial(dev, &data);
+	memcpy(priv->mac, data.mac, ETH_ALEN);
+
+	if (!IS_ENABLED(CONFIG_SPL_BUILD))
+		tq_eeprom_dump(priv);
+
+	return 0;
+}
+
+static int sysinfo_tq_eeprom_get_str(struct udevice *dev, int id, size_t size, char *val)
+{
+	struct sysinfo_tq_eeprom_priv *priv = dev_get_priv(dev);
+
+	switch (id) {
+	case SYSID_TQ_MODEL:
+		if (!priv->id[0])
+			return -ENODATA;
+
+		strlcpy(val, priv->id, size);
+		return 0;
+
+	case SYSID_TQ_SERIAL:
+		if (!priv->serial[0])
+			return -ENODATA;
+
+		strlcpy(val, priv->serial, size);
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int sysinfo_tq_eeprom_get_data(struct udevice *dev, int id, void **data, size_t *size)
+{
+	struct sysinfo_tq_eeprom_priv *priv = dev_get_priv(dev);
+
+	switch (id) {
+	case SYSID_TQ_MAC_ADDR:
+		if (!is_valid_ethaddr(priv->mac))
+			return -ENODATA;
+
+		*data = priv->mac;
+		*size = sizeof(priv->mac);
+
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct sysinfo_ops sysinfo_tq_eeprom_ops = {
+	.detect = sysinfo_tq_eeprom_detect,
+	.get_str = sysinfo_tq_eeprom_get_str,
+	.get_data = sysinfo_tq_eeprom_get_data,
+};
+
+static int sysinfo_tq_eeprom_probe(struct udevice *dev)
+{
+	struct sysinfo_tq_eeprom_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = nvmem_cell_get_by_name(dev, "device_info", &priv->device_info_cell);
+	if (ret) {
+		dev_err(dev, "device_info not found: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct udevice_id sysinfo_tq_eeprom_ids[] = {
+	{ .compatible = "tq,eeprom-sysinfo" },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(sysinfo_tq_eeprom) = {
+	.name           = "sysinfo_tq_eeprom",
+	.id             = UCLASS_SYSINFO,
+	.of_match       = sysinfo_tq_eeprom_ids,
+	.ops		= &sysinfo_tq_eeprom_ops,
+	.priv_auto	= sizeof(struct sysinfo_tq_eeprom_priv),
+	.probe          = sysinfo_tq_eeprom_probe,
+};
diff --git a/include/sysinfo/tq_eeprom.h b/include/sysinfo/tq_eeprom.h
new file mode 100644
index 00000000000..6b1bddd7ce0
--- /dev/null
+++ b/include/sysinfo/tq_eeprom.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2023-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Nora Schiffer
+ */
+
+#ifndef __SYSINFO_TQ_EEPROM_H__
+#define __SYSINFO_TQ_EEPROM_H__
+
+#include <sysinfo.h>
+
+enum {
+	/* Model string of TQ-Systems SOM. This is different from BOARD_MODEL,
+	 * which usually combines SOM and baseboard names for TQ hardware
+	 */
+	SYSID_TQ_MODEL = SYSID_USER,
+	/* SOM serial number */
+	SYSID_TQ_SERIAL,
+	/* MAC address */
+	SYSID_TQ_MAC_ADDR,
+};
+
+#endif /* __SYSINFO_TQ_EEPROM_H__ */
-- 
2.34.1

