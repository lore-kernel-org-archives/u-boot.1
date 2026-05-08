Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9676CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 08:49:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC3CA84C6E;
	Fri,  8 May 2026 10:48:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="HTluKOFR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D132084C3B; Fri,  8 May 2026 10:48:55 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C503F84C3F
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 10:48:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=bT5wr7KubC9tZo4WEjEqeyzRz7PhP8wIr7D4alAz+qE=; b=HTluKOFR534WHHfTK/ermlqTFs
 OIuegliEC13cToHABQTb2KMvvn3QAGvQZqIIRC5YCFedrptHkeFZDXOXNA4ncU2AOkaG+qSxHNxQ6
 Z9y7Y7j3qkn6ca0rlhuxDZJFGdiqvN1gkQWNWmctqAAfGGDH7J84WVGB5NUtHWMqohuhUVJs3l307
 75OkrAjpG13IXUN2edytszMjx+6Rz3QFfJlBJxnGtdVX4VXBPQUdU7T3sQRTo8NBLnBPkq1MwwDKH
 dEudjrz7Fon3tAb171oGIIMEHzSYuh/0K57zh0dLiCOFXqrfnMAny6cUtDu+im9F51F0C9/qNqjCu
 +ofSws4A==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wLGt9-0009a0-2Q; Fri, 08 May 2026 10:48:51 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wLGt8-000KsG-2d; Fri, 08 May 2026 10:48:51 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.denx.de
Cc: Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>, Max Merchel <Max.Merchel@ew.tq-group.com>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>
Subject: [PATCH 3/6] sysinfo: tq_eeprom: new driver
Date: Fri,  8 May 2026 10:48:31 +0200
Message-Id: <20260508084834.45637-4-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260508084834.45637-1-Alexander.Feilke@ew.tq-group.com>
References: <20260508084834.45637-1-Alexander.Feilke@ew.tq-group.com>
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
 drivers/sysinfo/Kconfig     |   8 ++
 drivers/sysinfo/Makefile    |   1 +
 drivers/sysinfo/tq_eeprom.c | 223 ++++++++++++++++++++++++++++++++++++
 include/sysinfo/tq_eeprom.h |  24 ++++
 4 files changed, 256 insertions(+)
 create mode 100644 drivers/sysinfo/tq_eeprom.c
 create mode 100644 include/sysinfo/tq_eeprom.h

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
index 00000000000..b10803f9b5a
--- /dev/null
+++ b/drivers/sysinfo/tq_eeprom.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2014-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Nora Schiffer
+ */
+
+#include <display_options.h>
+#include <dm.h>
+#include <i2c_eeprom.h>
+#include <log.h>
+#include <net.h>
+#include <dm/device_compat.h>
+#include <linux/ctype.h>
+#include <linux/sizes.h>
+#include <sysinfo/tq_eeprom.h>
+
+#define TQ_EE_RSV0_BYTES		0x20
+#define TQ_EE_RSV1_BYTES		10
+#define TQ_EE_SERIAL_BYTES		8
+#define TQ_EE_RSV2_BYTES		8
+#define TQ_EE_BDID_BYTES		0x40
+
+struct tq_eeprom_data {
+	u8 rsv0[TQ_EE_RSV0_BYTES];
+	u8 mac[ETH_ALEN];		/* 0x20 ... 0x25 */
+	u8 rsv1[TQ_EE_RSV1_BYTES];
+	u8 serial[TQ_EE_SERIAL_BYTES];	/* 0x30 ... 0x37 */
+	u8 rsv2[TQ_EE_RSV2_BYTES];
+	u8 id[TQ_EE_BDID_BYTES];	/* 0x40 ... 0x7f */
+};
+
+static_assert(sizeof(struct tq_eeprom_data) == 0x80,
+	      "struct tq_eeprom_data has incorrect size");
+
+/**
+ * struct sysinfo_tq_eeprom_priv - sysinfo private data
+ */
+struct sysinfo_tq_eeprom_priv {
+	struct udevice *i2c_eeprom;
+	int offset;
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
+static int tq_eeprom_serial_len_old(const struct tq_eeprom_data *data)
+{
+	int i;
+
+	for (i = 0; i < sizeof(data->serial); i++) {
+		if (!isdigit(data->serial[i]))
+			break;
+	}
+
+	return i;
+}
+
+static int tq_eeprom_serial_len_new(const struct tq_eeprom_data *data)
+{
+	int i;
+
+	for (i = 0; i < sizeof(data->serial); i++) {
+		if (!(isdigit(data->serial[i]) || isupper(data->serial[i])))
+			break;
+	}
+
+	return i;
+}
+
+static void tq_eeprom_parse_serial(struct udevice *dev, const struct tq_eeprom_data *data)
+{
+	struct sysinfo_tq_eeprom_priv *priv = dev_get_priv(dev);
+	int len;
+
+	if (data->serial[0] == 'T' && data->serial[1] == 'Q')
+		len = tq_eeprom_serial_len_new(data);
+	else
+		len = tq_eeprom_serial_len_old(data);
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
+	ret = i2c_eeprom_read(priv->i2c_eeprom, priv->offset,
+			      (u8 *)&data, sizeof(data));
+	if (ret < 0) {
+		dev_err(dev, "EEPROM read failed: %d\n", ret);
+		return -EIO;
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
+	ret = uclass_get_device_by_phandle(UCLASS_I2C_EEPROM, dev, "i2c-eeprom",
+					   &priv->i2c_eeprom);
+	if (ret) {
+		dev_err(dev, "i2c-eeprom backing device not found: %d\n", ret);
+		return ret;
+	}
+
+	priv->offset = dev_read_u32_default(dev, "offset", 0);
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

