Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5435C021A9
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 05:36:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7699F80F6B;
	Tue, 18 Feb 2025 06:35:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=baocheng.su@siemens.com header.b="em0xLmGK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D84E80017; Tue, 18 Feb 2025 03:36:49 +0100 (CET)
Received: from mta-65-228.siemens.flowmailer.net
 (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 615B28001F
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 03:36:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=baocheng.su@siemens.com
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id
 20250218023646d5c63dea37db35d9af for <u-boot@lists.denx.de>;
 Tue, 18 Feb 2025 03:36:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=baocheng.su@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=+O4dUswAtbfKnruru3KveUJ1+rYukum9ac2lU024NxM=;
 b=em0xLmGK1qg7pJbdyEP2BCB3o156k1Q5YKk28Gh+EuH3rDVHl1TpkJ4brGAgfGdRAVmAB5
 zwcBePlu12BoWrFwm4yBRKifz6yDzXmpmgkPxNrnJUm7inAooI5oqfZQfQMoMIGsrV9TjfVT
 GJqkTtFsArgChlx3uIN8ozSDB567L/oyLRmWaRcqoQ20XOhGw48LTQIZaClT1LWNg+KYIMRH
 v0dHQCH0Rf9kFHAVLz/FT/+0XHCHVA7D3UTXsHO//z8gP6luh2oozlSxWPfnV08zG+LK9BY4
 Z3b0mJi5aZsFDrbA8OAX2iNByNsQMzq2nNXlLbouISnl88c/wXs6NR0Q==;
From: Baocheng Su <baocheng.su@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bryan Brattlof <bb@ti.com>, Nishanth Menon <nm@ti.com>,
 Li Hua Qian <huaqian.li@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Baocheng Su <baocheng.su@siemens.com>
Subject: [PATCH v4 4/5] sysinfo: Add driver for IOT2050 boards
Date: Tue, 18 Feb 2025 10:36:13 +0800
Message-Id: <20250218023614.52574-5-baocheng.su@siemens.com>
In-Reply-To: <20250218023614.52574-1-baocheng.su@siemens.com>
References: <20250218023614.52574-1-baocheng.su@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-909155:519-21489:flowmailer
X-Mailman-Approved-At: Tue, 18 Feb 2025 06:35:12 +0100
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

This brings a sysinfo driver and DT entry for the IOT2050 board series.
It translates the board information passed from SE-Boot to SPL into
values that can be retrieved via the sysinfo API. Will is already used
to fill the SMBIOS table when booting via EFI.

Signed-off-by: Baocheng Su <baocheng.su@siemens.com>
Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
[Jan: split-off as separate patch, cleanup]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

---

Changes in v4:
- Drop the SYSINFO in iot2050_defconfig, this will be auto selected in
  the TARGET_IOT2050_A53

Changes in v3:
- remove the sysinfo id mapping prior to SYSID_USER
- keep some iot2050 specific sysinfo ids to explicitly express the
  original naming. They are pairing cased with the SYSID_SM_* in the
  get_str hook
- convert device-specific format of UUID to SMBios binary format when
  probing, with the help of uuid_str_to_bin
- s/strncpy/strlcpy/g
- move the 'case RAM_SIZE' into get_int hook
- add get_data hook for the SMBios UUID. Meanwhile still keep the
  'BOARD_UUID' string for the u-boot environment
- hook the get_item_count and get_data_by_index for the MAC addresses

 .../dts/k3-am65-iot2050-common-u-boot.dtsi    |  18 ++
 drivers/sysinfo/Kconfig                       |   7 +
 drivers/sysinfo/Makefile                      |   1 +
 drivers/sysinfo/iot2050.c                     | 202 ++++++++++++++++++
 drivers/sysinfo/iot2050.h                     |  14 ++
 5 files changed, 242 insertions(+)
 create mode 100644 drivers/sysinfo/iot2050.c
 create mode 100644 drivers/sysinfo/iot2050.h

diff --git a/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi b/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi
index b6d2c816acc2..55337179f9f3 100644
--- a/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi
+++ b/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi
@@ -14,6 +14,24 @@
 		spi0 = &ospi0;
 	};
 
+	sysinfo {
+		compatible = "siemens,sysinfo-iot2050";
+		/* TI_SRAM_SCRATCH_BOARD_EEPROM_START */
+		offset = <0x40280000>;
+		bootph-all;
+
+		smbios {
+			system {
+				manufacturer = "SIEMENS AG";
+				product = "SIMATIC IOT2050";
+			};
+
+			baseboard {
+				manufacturer = "SIEMENS AG";
+			};
+		};
+	};
+
 	leds {
 		bootph-all;
 		status-led-red {
diff --git a/drivers/sysinfo/Kconfig b/drivers/sysinfo/Kconfig
index 2030e4babc9f..df83df69ffb3 100644
--- a/drivers/sysinfo/Kconfig
+++ b/drivers/sysinfo/Kconfig
@@ -31,6 +31,13 @@ config SYSINFO_RCAR3
 	help
 	  Support querying SoC version information for Renesas R-Car Gen3.
 
+config SYSINFO_IOT2050
+	bool "Enable sysinfo driver for the Siemens IOT2050"
+	depends on TARGET_IOT2050_A53
+	default y if TARGET_IOT2050_A53
+	help
+	  Support querying device information for Siemens IOT2050.
+
 config SYSINFO_SANDBOX
 	bool "Enable sysinfo driver for the Sandbox board"
 	help
diff --git a/drivers/sysinfo/Makefile b/drivers/sysinfo/Makefile
index 680dde77fe88..26ca31509997 100644
--- a/drivers/sysinfo/Makefile
+++ b/drivers/sysinfo/Makefile
@@ -5,6 +5,7 @@
 obj-y += sysinfo-uclass.o
 obj-$(CONFIG_SYSINFO_GAZERBEAM) += gazerbeam.o
 obj-$(CONFIG_SYSINFO_GPIO) += gpio.o
+obj-$(CONFIG_SYSINFO_IOT2050) += iot2050.o
 obj-$(CONFIG_SYSINFO_RCAR3) += rcar3.o
 obj-$(CONFIG_SYSINFO_SANDBOX) += sandbox.o
 obj-$(CONFIG_SYSINFO_SMBIOS) += smbios.o
diff --git a/drivers/sysinfo/iot2050.c b/drivers/sysinfo/iot2050.c
new file mode 100644
index 000000000000..579a9f4711db
--- /dev/null
+++ b/drivers/sysinfo/iot2050.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Siemens AG, 2025
+ */
+
+#include <dm.h>
+#include <sysinfo.h>
+#include <net.h>
+#include <u-boot/uuid.h>
+#include <asm/arch/hardware.h>
+
+#include "iot2050.h"
+
+#define IOT2050_INFO_MAGIC		0x20502050
+
+#define IOT2050_UUID_STR_LEN		(32)
+
+struct iot2050_info {
+	u32 magic;
+	u16 size;
+	char name[20 + 1];
+	char serial[16 + 1];
+	char mlfb[18 + 1];
+	char uuid[IOT2050_UUID_STR_LEN + 1];
+	char a5e[18 + 1];
+	u8 mac_addr_cnt;
+	u8 mac_addr[8][ARP_HLEN];
+	char seboot_version[40 + 1];
+	u8 padding[3];
+	u32 ddr_size_mb;
+} __packed;
+
+/**
+ * struct sysinfo_iot2050_priv - sysinfo private data
+ * @info: iot2050 board info
+ */
+struct sysinfo_iot2050_priv {
+	struct iot2050_info *info;
+	u8 uuid_smbios[16];
+};
+
+static int sysinfo_iot2050_detect(struct udevice *dev)
+{
+	struct sysinfo_iot2050_priv *priv = dev_get_priv(dev);
+
+	if (!priv->info || priv->info->magic != IOT2050_INFO_MAGIC)
+		return -EFAULT;
+
+	return 0;
+}
+
+static int sysinfo_iot2050_get_str(struct udevice *dev, int id, size_t size,
+				   char *val)
+{
+	struct sysinfo_iot2050_priv *priv = dev_get_priv(dev);
+
+	switch (id) {
+	case BOARD_NAME:
+	case SYSID_SM_BASEBOARD_VERSION:
+		strlcpy(val, priv->info->name, size);
+		break;
+	case SYSID_SM_SYSTEM_SERIAL:
+		strlcpy(val, priv->info->serial, size);
+		break;
+	case BOARD_MLFB:
+	case SYSID_SM_SYSTEM_VERSION:
+		strlcpy(val, priv->info->mlfb, size);
+		break;
+	case BOARD_UUID:
+		strlcpy(val, priv->info->uuid, size);
+		break;
+	case BOARD_A5E:
+	case SYSID_SM_BASEBOARD_PRODUCT:
+		strlcpy(val, priv->info->a5e, size);
+		break;
+	case BOARD_SEBOOT_VER:
+	case SYSID_PRIOR_STAGE_VERSION:
+		strlcpy(val, priv->info->seboot_version, size);
+		break;
+	default:
+		return -EINVAL;
+	};
+
+	val[size - 1] = '\0';
+	return 0;
+}
+
+static int sysinfo_iot2050_get_int(struct udevice *dev, int id, int *val)
+{
+	struct sysinfo_iot2050_priv *priv = dev_get_priv(dev);
+
+	switch (id) {
+	case SYSID_BOARD_RAM_SIZE_MB:
+		*val = priv->info->ddr_size_mb;
+		return 0;
+	default:
+		return -EINVAL;
+	};
+}
+
+static int sysinfo_iot2050_get_data(struct udevice *dev, int id, void **data,
+				    size_t *size)
+{
+	struct sysinfo_iot2050_priv *priv = dev_get_priv(dev);
+
+	switch (id) {
+	case SYSID_SM_SYSTEM_UUID:
+		*data = priv->uuid_smbios;
+		*size = 16;
+		return 0;
+	default:
+		return -EINVAL;
+	};
+}
+
+static int sysinfo_iot2050_get_item_count(struct udevice *dev, int id)
+{
+	struct sysinfo_iot2050_priv *priv = dev_get_priv(dev);
+
+	switch (id) {
+	case SYSID_BOARD_MAC_ADDR:
+		return priv->info->mac_addr_cnt;
+	default:
+		return -EINVAL;
+	};
+}
+
+static int sysinfo_iot2050_get_data_by_index(struct udevice *dev, int id,
+					     int index, void **data,
+					     size_t *size)
+{
+	struct sysinfo_iot2050_priv *priv = dev_get_priv(dev);
+
+	switch (id) {
+	case SYSID_BOARD_MAC_ADDR:
+		if (index >= priv->info->mac_addr_cnt)
+			return -EINVAL;
+		*data = priv->info->mac_addr[index];
+		*size = ARP_HLEN;
+		return 0;
+	default:
+		return -EINVAL;
+	};
+}
+
+static const struct sysinfo_ops sysinfo_iot2050_ops = {
+	.detect = sysinfo_iot2050_detect,
+	.get_str = sysinfo_iot2050_get_str,
+	.get_int = sysinfo_iot2050_get_int,
+	.get_data = sysinfo_iot2050_get_data,
+	.get_item_count = sysinfo_iot2050_get_item_count,
+	.get_data_by_index = sysinfo_iot2050_get_data_by_index,
+};
+
+/**
+ * @brief Convert the IOT2050 UUID string to the SMBIOS format
+ *
+ * @param uuid_raw The IOT2050 UUID string parsed from the eeprom
+ * @param uuid_smbios The buffer to hold the SMBIOS formatted UUID
+ */
+static void sysinfo_iot2050_convert_uuid(const char *uuid_iot2050,
+					 u8 *uuid_smbios)
+{
+	char uuid_rfc4122_str[IOT2050_UUID_STR_LEN + 4 + 1] = {0};
+	char *tmp = uuid_rfc4122_str;
+
+	for (int i = 0; i < 16; i++) {
+		memcpy(tmp, uuid_iot2050 + i * 2, 2);
+		tmp += 2;
+		if (i == 3 || i == 5 || i == 7 || i == 9)
+			*tmp++ = '-';
+	}
+	uuid_str_to_bin(uuid_rfc4122_str, uuid_smbios, UUID_STR_FORMAT_GUID);
+}
+
+static int sysinfo_iot2050_probe(struct udevice *dev)
+{
+	struct sysinfo_iot2050_priv *priv = dev_get_priv(dev);
+	unsigned long offset;
+
+	offset = dev_read_u32_default(dev, "offset",
+				      TI_SRAM_SCRATCH_BOARD_EEPROM_START);
+	priv->info = (struct iot2050_info *)offset;
+
+	sysinfo_iot2050_convert_uuid(priv->info->uuid, priv->uuid_smbios);
+
+	return 0;
+}
+
+static const struct udevice_id sysinfo_iot2050_ids[] = {
+	{ .compatible = "siemens,sysinfo-iot2050" },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(sysinfo_iot2050) = {
+	.name           = "sysinfo_iot2050",
+	.id             = UCLASS_SYSINFO,
+	.of_match       = sysinfo_iot2050_ids,
+	.ops		= &sysinfo_iot2050_ops,
+	.priv_auto	= sizeof(struct sysinfo_iot2050_priv),
+	.probe          = sysinfo_iot2050_probe,
+};
diff --git a/drivers/sysinfo/iot2050.h b/drivers/sysinfo/iot2050.h
new file mode 100644
index 000000000000..657221db0960
--- /dev/null
+++ b/drivers/sysinfo/iot2050.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) Siemens AG, 2025
+ */
+
+#include <sysinfo.h>
+
+enum sysinfo_id_iot2050 {
+	BOARD_MLFB		= SYSID_USER,
+	BOARD_A5E,
+	BOARD_NAME,
+	BOARD_UUID,
+	BOARD_SEBOOT_VER,
+};
-- 
2.39.5

