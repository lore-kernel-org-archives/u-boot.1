Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5802CF11F4
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 13:25:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 170508935D;
	Thu, 10 Oct 2024 15:25:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="TDun4AaC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94FD98935D; Thu, 10 Oct 2024 15:25:16 +0200 (CEST)
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
 by phobos.denx.de (Postfix) with ESMTP id 91708892D0
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 15:25:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1728566700;
 bh=X21axcoNujiobbRy7J7c9xPljPwPuGoN39IQKIY6thU=;
 h=From:To:CC:Subject:Date:From;
 b=TDun4AaCy3V9x/UwL9sRn4YmwE4xjcz8SKte1H3WL+1nubsuzAC/jHZyyPtc0xMv4
 nOh104BWALu569MmYr17MvaXgax0CzvWk15UmKWFBkmLM5Q/vL5VEqmWkkVkXQnall
 gkZdxQWId2RLNwLQp/Z5LW4WPimrvNnhbUkQbUaeIB6Dcvrti0UKRN0yeUkvc6I+EI
 hNVT2lIsNd/t2BPC9ZQfI1cHf09aeEGlB23mPdGU38nt/rjVXsiL6y3RSJMnr6b8JU
 OR9lqhVQDTXVhjEw7mo4WvNHqYetL1DTUke3UE84UlU01ujuPUvLXr9sXBk8dF7B+l
 XxUtxvAU6BE8Q==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <u-boot@lists.denx.de>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, NXP i.MX U-Boot
 Team <uboot-imx@nxp.com>, Marek Vasut <marex@denx.de>, Fabio Estevam
 <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>
Subject: [PATCH 1/2] arm64: imx8mp: Read MAC address from M24C32-D
 write-lockable page on DH i.MX8MP DHCOM if available
Date: Thu, 10 Oct 2024 15:23:36 +0200
Message-ID: <20241010132337.3259-1-cniedermaier@dh-electronics.com>
X-klartext: yes
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

The i.MX8M Plus DHCOM currently supports parsing ethernet MAC address
from multiple sources in the following priority order:

1) U-Boot environment 'ethaddr'/'eth1addr' environment variable
2) SoC OTP fuses
3) On-SoM EEPROM

The new i.MX8M Plus DHCOM rev.200 is populated with M24C32-D EEPROM
which contains additional write-lockable page, which can also be
populated with a structure containing ethernet MAC address.

Add support for parsing the content of this new write-lockable page
and place it between 2) and 3) on the priority list. The new entry is
2.5) On-SoM EEPROM write-lockable page

Because the write-lockable page is not present on rev.100 i.MX8MP DHCOM
SoM, test whether EEPROM ID page exists in DT and whether it is enabled
first. If so, read the entire ID page out, validate it, and determine
whether EEPROM MAC address is populated in it in DH specific format. If
so, use the MAC address. There may be multiple EEPROMs with an ID page
on this platform, always use the first one.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
---
 board/dhelectronics/common/dh_common.c        | 113 ++++++++++++++++++
 board/dhelectronics/common/dh_common.h        |  23 ++++
 .../dh_imx8mp/imx8mp_dhcom_pdk2.c             |   6 +
 3 files changed, 142 insertions(+)

diff --git a/board/dhelectronics/common/dh_common.c b/board/dhelectronics/common/dh_common.c
index 32c50b4f0f..8ea70fc984 100644
--- a/board/dhelectronics/common/dh_common.c
+++ b/board/dhelectronics/common/dh_common.c
@@ -7,9 +7,22 @@
 #include <dm.h>
 #include <i2c_eeprom.h>
 #include <net.h>
+#include <u-boot/crc.h>
 
 #include "dh_common.h"
 
+struct eeprom_id_page {
+	u8	id[3];		/* Identifier 'D', 'H', 'E' - 'D' is at index 0 */
+	u8	version;	/* 0x10 -- Version 1.0 */
+	u8	data_crc16[2];	/* [1] is MSbyte */
+	u8	header_crc8;
+	u8	mac0[6];
+	u8	mac1[6];
+	u8	item_prefix;	/* H/F is coded in MSbits, Vendor coding starts at LSbits */
+	u8	item_num[3];	/* [2] is MSbyte */
+	u8	serial[9];	/* [8] is MSbyte */
+} __packed;
+
 bool dh_mac_is_in_env(const char *env)
 {
 	unsigned char enetaddr[6];
@@ -30,6 +43,106 @@ int dh_get_mac_is_enabled(const char *alias)
 	return 0;
 }
 
+int dh_get_value_from_eeprom_id_page(enum eip_request_values request, u8 *data,
+				     int data_len, const char *alias)
+{
+	struct eeprom_id_page *eipp;
+	struct udevice *dev;
+	static u8 eipa[32];
+	char path[128];
+	int len, ret;
+	ofnode node;
+	u16 c16;
+	u8 c8;
+
+	eipp = (struct eeprom_id_page *)eipa;
+
+	if (!(eipp->id[0] == 'D' && eipp->id[1] == 'H' && eipp->id[2] == 'E')) {
+		node = ofnode_path(alias);
+		if (!ofnode_valid(node)) {
+			printf("%s: ofnode for %s not found!", __func__, alias);
+			return -ENOENT;
+		}
+
+		ret = ofnode_get_path(node, path, sizeof(path));
+		if (ret)
+			return ret;
+
+		len = strlen(path);
+		if (len <= 0)
+			return -EINVAL;
+
+		if (path[len - 1] == '0')
+			path[len - 1] = '8';
+		else if (path[len - 1] == '3')
+			path[len - 1] = 'b';
+		else
+			return -ENOENT;
+
+		node = ofnode_path(path);
+		if (!ofnode_valid(node))	/* ID page not present in DT */
+			return -ENOENT;
+
+		if (!ofnode_is_enabled(node))	/* ID page not enabled in DT */
+			return -ENOENT;
+
+		ret = uclass_get_device_by_ofnode(UCLASS_I2C_EEPROM, node, &dev);
+		if (ret) {
+			printf("%s: Cannot find ID page! ret = %d\n", __func__, ret);
+			return ret;
+		}
+
+		ret = i2c_eeprom_read(dev, 0x0, eipa, sizeof(eipa));
+		if (ret) {
+			printf("%s: Error reading ID page! ret = %d\n", __func__, ret);
+			return ret;
+		}
+	}
+
+	/* Validate header checksum */
+	c8 = crc8(0xff, eipa, offsetof(struct eeprom_id_page, header_crc8));
+	if (eipp->header_crc8 != c8)
+		return -EINVAL;
+
+	/* Validate header magic */
+	if (eipp->id[0] != 'D' || eipp->id[1] != 'H' || eipp->id[2] != 'E')
+		return -EINVAL;
+
+	/* Validate header version */
+	if (eipp->version != 0x10)
+		return -EINVAL;
+
+	/* Validate structure checksum */
+	c16 = crc16(0xffff, eipa + offsetof(struct eeprom_id_page, mac0),
+		    sizeof(*eipp) - offsetof(struct eeprom_id_page, mac0));
+	if (((eipp->data_crc16[1] << 8) | eipp->data_crc16[0]) != c16)
+		return -EINVAL;
+
+	/* Copy requested data */
+	switch (request) {
+	case MAC0:
+		if (!is_valid_ethaddr(eipp->mac0))
+			return -EINVAL;
+		if (data_len >= sizeof(eipp->mac0))
+			memcpy(data, eipp->mac0, sizeof(eipp->mac0));
+		else
+			return -EINVAL;
+		break;
+	case MAC1:
+		if (!is_valid_ethaddr(eipp->mac1))
+			return -EINVAL;
+		if (data_len >= sizeof(eipp->mac1))
+			memcpy(data, eipp->mac1, sizeof(eipp->mac1));
+		else
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int dh_get_mac_from_eeprom(unsigned char *enetaddr, const char *alias)
 {
 	struct udevice *dev;
diff --git a/board/dhelectronics/common/dh_common.h b/board/dhelectronics/common/dh_common.h
index a2de5b1553..4c22ece435 100644
--- a/board/dhelectronics/common/dh_common.h
+++ b/board/dhelectronics/common/dh_common.h
@@ -3,6 +3,11 @@
  * Copyright 2022 DENX Software Engineering GmbH, Philip Oberfichtner <pro@denx.de>
  */
 
+enum eip_request_values {
+	MAC0,
+	MAC1,
+};
+
 /*
  * dh_mac_is_in_env - Check if MAC address is already set
  *
@@ -28,6 +33,24 @@ int dh_get_mac_is_enabled(const char *alias);
  */
 int dh_get_mac_from_eeprom(unsigned char *enetaddr, const char *alias);
 
+/*
+ * dh_get_value_from_eeprom_id_page() - Get value from EEPROM ID page
+ * @eip_request_values:	Requested value as enum
+ * @data:		Buffer where value is to be stored
+ * @data_len:		Length of the value buffer
+ * @alias:		Alias for EEPROM device tree node
+ *
+ * Gets the value specified by the parameter eip_request_values from the ID
+ * page of the specified EEPROM. The EEPROM device is selected via alias
+ * device tree name (parameter alias). The data is written to the specified
+ * data buffer (parameter data). If the length of the data (parameter data_len)
+ * is not sufficient to copy the data into the buffer, an error is returned.
+ *
+ * Return: 0 if OK, other value on error
+ */
+int dh_get_value_from_eeprom_id_page(enum eip_request_values request, u8 *data,
+				     int data_len, const char *alias);
+
 /*
  * dh_setup_mac_address - Try to get MAC address from various locations and write it to env
  *
diff --git a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
index 78aae41235..9a8f09fcd4 100644
--- a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
+++ b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
@@ -53,6 +53,9 @@ static int dh_imx8_setup_ethaddr(void)
 	if (!dh_imx_get_mac_from_fuse(enetaddr))
 		goto out;
 
+	if (!dh_get_value_from_eeprom_id_page(MAC0, enetaddr, sizeof(enetaddr), "eeprom0"))
+		goto out;
+
 	if (!dh_get_mac_from_eeprom(enetaddr, "eeprom0"))
 		goto out;
 
@@ -75,6 +78,9 @@ static int dh_imx8_setup_eth1addr(void)
 	if (!dh_imx_get_mac_from_fuse(enetaddr))
 		goto increment_out;
 
+	if (!dh_get_value_from_eeprom_id_page(MAC1, enetaddr, sizeof(enetaddr), "eeprom0"))
+		goto out;
+
 	if (!dh_get_mac_from_eeprom(enetaddr, "eeprom1"))
 		goto out;
 
-- 
2.30.2

