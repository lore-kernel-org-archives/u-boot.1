Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0003CF07A8
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 05:57:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1F068918D;
	Thu, 10 Oct 2024 07:56:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="aJEE636Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EB5289139; Thu, 10 Oct 2024 07:56:03 +0200 (CEST)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24005890F8
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 07:55:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 2024101005555837385f0616cdb3b522 for <u-boot@lists.denx.de>;
 Thu, 10 Oct 2024 07:55:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=NrOyHsHnUQd9bJrX18sWYtDhoGTDFlA1hXeabaqwqsU=;
 b=aJEE636QwaG7CwX+Nk/l+Uk7/OzPsiRMN/8n1z3qBLYyJ+LDg7pxDbSOUK5rAI8jugaaSb
 Vj0hRyR8YeCE+ETWyoTI3xrU5PBW/hoJu4QjfWZ0mtIBxSyUYFi0uDynu1+XI7bobR3TAxdw
 +XaFzvq230zg0Dk4rhPgZtakN2G6ipuJkE8yWqchqEJVd2RB0pc7sY/I+pZ+h6jNFXE35lLq
 S71yP0t1xRd50IMDdaPA2jW5v//Dq6QU1ZnMrGpKCh+xic7uDNMUnkPYWKDjw8u7wSQeII2B
 9P9RZZwWG9WDHgYxLJp5lmnmR1nCZ2DYyFSxdqqCccTmTQEJEaMsN8vA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bryan Brattlof <bb@ti.com>,
	Nishanth Menon <nm@ti.com>
Subject: [PATCH 10/11] sysinfo: Add driver for IOT2050 boards
Date: Thu, 10 Oct 2024 07:55:54 +0200
Message-ID: <9441245e18d8e2015880f52016fc9a7dd8cb77e9.1728539755.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1728539755.git.jan.kiszka@siemens.com>
References: <cover.1728539755.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
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

From: Li Hua Qian <huaqian.li@siemens.com>

This brings a sysinfo driver and DT entry for the IOT2050 board series.
It translates the board information passed from SE-Boot to SPL into
values that can be retrieved via the sysinfo API. Will is already used
to fill the SMBIOS table when booting via EFI.

Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
[Jan: split-off as separate patch, cleanup]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../dts/k3-am65-iot2050-common-u-boot.dtsi    |  18 +++
 configs/iot2050_defconfig                     |   1 +
 drivers/sysinfo/Kconfig                       |   7 +
 drivers/sysinfo/Makefile                      |   1 +
 drivers/sysinfo/iot2050.c                     | 143 ++++++++++++++++++
 drivers/sysinfo/iot2050.h                     |  26 ++++
 6 files changed, 196 insertions(+)
 create mode 100644 drivers/sysinfo/iot2050.c
 create mode 100644 drivers/sysinfo/iot2050.h

diff --git a/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi b/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi
index b6d2c816acc..55337179f9f 100644
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
diff --git a/configs/iot2050_defconfig b/configs/iot2050_defconfig
index 2624f0cb573..574e232d119 100644
--- a/configs/iot2050_defconfig
+++ b/configs/iot2050_defconfig
@@ -141,6 +141,7 @@ CONFIG_SOC_TI=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_CADENCE_QSPI=y
+CONFIG_SYSINFO=y
 CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_TI_SCI=y
diff --git a/drivers/sysinfo/Kconfig b/drivers/sysinfo/Kconfig
index 2030e4babc9..df83df69ffb 100644
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
index 680dde77fe8..26ca3150999 100644
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
index 00000000000..5359d6b8d62
--- /dev/null
+++ b/drivers/sysinfo/iot2050.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Siemens AG, 2024
+ */
+
+#include <dm.h>
+#include <sysinfo.h>
+#include <net.h>
+#include <asm/arch/hardware.h>
+
+#include "iot2050.h"
+
+#define IOT2050_INFO_MAGIC		0x20502050
+
+struct iot2050_info {
+	u32 magic;
+	u16 size;
+	char name[20 + 1];
+	char serial[16 + 1];
+	char mlfb[18 + 1];
+	char uuid[32 + 1];
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
+};
+
+static int sysinfo_iot2050_detect(struct udevice *dev)
+{
+	struct sysinfo_iot2050_priv *priv = dev_get_priv(dev);
+
+	if (priv->info == NULL || priv->info->magic != IOT2050_INFO_MAGIC)
+		return -EFAULT;
+
+	return 0;
+}
+
+static int sysinfo_iot2050_get_str(struct udevice *dev, int id, size_t size,
+				   char *val)
+{
+	struct sysinfo_iot2050_priv *priv = dev_get_priv(dev);
+	char byte_str[3] = {0};
+	unsigned int n;
+
+	switch (id) {
+	case BOARD_NAME:
+		strncpy(val, priv->info->name, size);
+		break;
+	case BOARD_SERIAL:
+		strncpy(val, priv->info->serial, size);
+		break;
+	case BOARD_MLFB:
+		strncpy(val, priv->info->mlfb, size);
+		break;
+	case BOARD_UUID:
+		for (n = 0; n < min(size, (size_t)16); n++) {
+			memcpy(byte_str, priv->info->uuid + n * 2, 2);
+			val[n] = (char)hextoul(byte_str, NULL);
+		}
+		break;
+	case BOARD_A5E:
+		strncpy(val, priv->info->a5e, size);
+		break;
+	case BOARD_SEBOOT_VER:
+		strncpy(val, priv->info->seboot_version, size);
+		break;
+	case BOARD_MAC_ADDR_1:
+	case BOARD_MAC_ADDR_2:
+	case BOARD_MAC_ADDR_3:
+	case BOARD_MAC_ADDR_4:
+	case BOARD_MAC_ADDR_5:
+	case BOARD_MAC_ADDR_6:
+	case BOARD_MAC_ADDR_7:
+	case BOARD_MAC_ADDR_8:
+		memcpy(val, priv->info->mac_addr[id - BOARD_MAC_ADDR_START],
+		       ARP_HLEN);
+		return 0;
+	case BOARD_DDR_SIZE:
+		memcpy(val, &priv->info->ddr_size_mb,
+		       sizeof(priv->info->ddr_size_mb));
+		return 0;
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
+	case BOARD_MAC_ADDR_CNT:
+		*val = priv->info->mac_addr_cnt;
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
+};
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
index 00000000000..f659a8282b5
--- /dev/null
+++ b/drivers/sysinfo/iot2050.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) Siemens AG, 2024
+ */
+
+#include <sysinfo.h>
+
+enum sysinfo_id_iot2050 {
+	BOARD_MLFB		= SYSINFO_ID_SMBIOS_SYSTEM_VERSION,
+	BOARD_SERIAL		= SYSINFO_ID_SMBIOS_SYSTEM_SERIAL,
+	BOARD_UUID		= SYSINFO_ID_SMBIOS_SYSTEM_UUID,
+	BOARD_A5E		= SYSINFO_ID_SMBIOS_BASEBOARD_PRODUCT,
+	BOARD_NAME		= SYSINFO_ID_SMBIOS_BASEBOARD_VERSION,
+	BOARD_SEBOOT_VER	= SYSINFO_ID_USER + 0,
+	BOARD_MAC_ADDR_CNT	= SYSINFO_ID_USER + 1,
+	BOARD_MAC_ADDR_1	= SYSINFO_ID_USER + 2,
+	BOARD_MAC_ADDR_START	= BOARD_MAC_ADDR_1,
+	BOARD_MAC_ADDR_2	= SYSINFO_ID_USER + 3,
+	BOARD_MAC_ADDR_3	= SYSINFO_ID_USER + 4,
+	BOARD_MAC_ADDR_4	= SYSINFO_ID_USER + 5,
+	BOARD_MAC_ADDR_5	= SYSINFO_ID_USER + 6,
+	BOARD_MAC_ADDR_6	= SYSINFO_ID_USER + 7,
+	BOARD_MAC_ADDR_7	= SYSINFO_ID_USER + 8,
+	BOARD_MAC_ADDR_8	= SYSINFO_ID_USER + 9,
+	BOARD_DDR_SIZE		= SYSINFO_ID_USER + 10,
+};
-- 
2.43.0

