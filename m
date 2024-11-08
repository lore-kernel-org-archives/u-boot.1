Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FE5D64070
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 17:08:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E0DC88FFC;
	Fri,  8 Nov 2024 18:08:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="Oa6z/IWC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CDA1891FD; Fri,  8 Nov 2024 18:08:18 +0100 (CET)
Received: from mx2.securetransport.de (mx2.securetransport.de
 [IPv6:2a03:4000:13:6c7::1])
 by phobos.denx.de (Postfix) with ESMTP id C7AA88860B
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 18:08:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1731085689;
 bh=UT7hEeGn2KFw773b72aFgSBSQJzrdD+w2qc1aimGSgo=;
 h=From:To:CC:Subject:Date:From;
 b=Oa6z/IWCyvhlvTHYIF2mMHb5ZVnbRt/Z4jKSnaZ1eOX5BqBJvPdOtFgqnqnkt6wNG
 brv2e8xtxFHCVJIu4aCN9rwAW1FcPcq0iKQ3W3ubFSgddTQWlAiZxHbt3TEu+3w5xR
 Dji8cTG6JiCG92YqIbAUjb0uzGqxF0ROnINEVBNtr/lNBN/3dXtoPyhtDAD2rivgEH
 vLeBbW8MTu4e9XU8vqE3OyFD7NUP0LPgsvCDDkRZjHCaFT7zzX/qXum/91ty8xE8p8
 2pS3SSSaLkQB50sm1cGoqTfbED8jqPWDJZBZ1IbrhuRH7NTTnMEZ5lYHkwKfKxf6xd
 IslEVmENcbx3w==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <u-boot@lists.denx.de>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, "NXP i.MX U-Boot
 Team" <uboot-imx@nxp.com>, Marek Vasut <marex@denx.de>, Fabio Estevam
 <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>
Subject: [PATCH V2] arm64: imx8mp: Read values from M24C32-D write-lockable
 page on DHCOM i.MX8MP
Date: Fri, 8 Nov 2024 18:06:33 +0100
Message-ID: <20241108170633.46504-1-cniedermaier@dh-electronics.com>
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

The new i.MX8M Plus DHCOM rev.200 is populated with M24C32-D EEPROM
that contains an additional write-lockable page called ID page, which
is populated with a structure containing ethernet MAC addresses, DH
item number and DH serial number.

Because the write-lockable page is not present on rev.100 i.MX8MP
DHCOM SoM, the evaluation is only be done on SoM rev. 200 and greater
by checking the hardware coding.

There may be multiple EEPROMs with an ID page on this platform, always
use the first one. The evaluation of the EEPROM ID page is done in two
steps. First, the content is read and the header of the structure is
checked. This is done to cache the content of the EEPROM ID page.
Second the content is extracted from the EEPROM buffer by requesting
it.

For the ethernet MAC address the i.MX8M Plus DHCOM currently supports
parsing address from multiple sources in the following priority order:

1) U-Boot environment 'ethaddr'/'eth1addr' environment variable
2) SoC OTP fuses
3) On-SoM EEPROM

Add support for parsing the content of this new EEPROM ID page and place
it between 2) and 3) on the priority list. The new entry is 2.5) On-SoM
EEPROM write-lockable page.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
---
V2: - Merging the two previous patches
      "arm64: imx8mp: Read MAC address from M24C32-D write-lockable page on DH i.MX8MP DHCOM if available" and
      "arm64: imx8mp: Read item and serial number from EEPROM ID page on DH i.MX8MP DHCOM"
    - Split function for reading the EEPROM ID page
      - One for reading the content and check the header to cache the EEPROM ID page
      - Second for requesting values from the content buffer
    - Use an EEPROM buffer array in function board_late_init() to cache the EEPROM ID page content
    - Add namespaces for defines
    - Improve request values names (enum)
    - Add function for reading the hardware coding
    - Adjust the mac address function to use the EEPROM ID page content buffer
    - Arrange valiables in reverse xmas tree order
---
 board/dhelectronics/common/dh_common.c        | 198 +++++++++++++++++-
 board/dhelectronics/common/dh_common.h        |  42 +++-
 .../dh_imx8mp/imx8mp_dhcom_pdk2.c             |  90 +++++++-
 3 files changed, 322 insertions(+), 8 deletions(-)

diff --git a/board/dhelectronics/common/dh_common.c b/board/dhelectronics/common/dh_common.c
index 32c50b4f0f..22c02f36ff 100644
--- a/board/dhelectronics/common/dh_common.c
+++ b/board/dhelectronics/common/dh_common.c
@@ -7,9 +7,39 @@
 #include <dm.h>
 #include <i2c_eeprom.h>
 #include <net.h>
+#include <u-boot/crc.h>
 
 #include "dh_common.h"
 
+/* DH item: Vendor coding */
+#define DH_ITEM_PREFIX_NXP	0x01
+#define DH_ITEM_PREFIX_NXP_CHR	'I'
+#define DH_ITEM_PREFIX_ST	0x02
+#define DH_ITEM_PREFIX_ST_CHR	'S'
+
+/*
+ * DH item: Finished state coding
+ * Bit = 0 means half finished
+ *         Prefix is 'H'
+ * Bit = 1 means finished with a customer image flashed
+ *         Prefix is 'F'
+ */
+#define DH_ITEM_PREFIX_FIN_BIT		BIT(7)
+#define DH_ITEM_PREFIX_FIN_HALF_CHR	'H'
+#define DH_ITEM_PREFIX_FIN_FLASHED_CHR	'F'
+
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
+};
+
 bool dh_mac_is_in_env(const char *env)
 {
 	unsigned char enetaddr[6];
@@ -30,6 +60,169 @@ int dh_get_mac_is_enabled(const char *alias)
 	return 0;
 }
 
+int dh_read_eeprom_id_page(u8 *eeprom_buffer, const char *alias)
+{
+	u8 buffer[DH_EEPROM_ID_PAGE_MAX_SIZE] = { 0 };
+	struct eeprom_id_page *eipp;
+	struct udevice *dev;
+	int eeprom_size;
+	char path[128];
+	ofnode node;
+	int len;
+	int ret;
+	u8 c8;
+
+	node = ofnode_path(alias);
+	if (!ofnode_valid(node)) {
+		printf("%s: ofnode for %s not found!", __func__, alias);
+		return -ENOENT;
+	}
+
+	ret = ofnode_get_path(node, path, sizeof(path));
+	if (ret)
+		return ret;
+
+	len = strlen(path);
+	if (len <= 0)
+		return -EINVAL;
+
+	if (path[len - 1] == '0')
+		path[len - 1] = '8';
+	else if (path[len - 1] == '3')
+		path[len - 1] = 'b';
+	else
+		return -ENOENT;
+
+	node = ofnode_path(path);
+	if (!ofnode_valid(node))	/* ID page not present in DT */
+		return -ENOENT;
+
+	if (!ofnode_is_enabled(node))	/* ID page not enabled in DT */
+		return -ENOENT;
+
+	eeprom_size = ofnode_read_u32_default(node, "pagesize", 32);
+	if (eeprom_size > DH_EEPROM_ID_PAGE_MAX_SIZE) {
+		eeprom_size = DH_EEPROM_ID_PAGE_MAX_SIZE;
+		log_warning("Warning: Read data from EEPROM ID page truncated to %d bytes\n",
+			    DH_EEPROM_ID_PAGE_MAX_SIZE);
+	}
+
+	ret = uclass_get_device_by_ofnode(UCLASS_I2C_EEPROM, node, &dev);
+	if (ret) {
+		printf("%s: Cannot find ID page! Check DT, maybe EEPROM ID page is enabled but not populated! ret = %d\n",
+		       __func__, ret);
+		return ret;
+	}
+
+	ret = i2c_eeprom_read(dev, 0x0, buffer, eeprom_size);
+	if (ret) {
+		printf("%s: Error reading ID page! ret = %d\n", __func__, ret);
+		return ret;
+	}
+
+	eipp = (struct eeprom_id_page *)buffer;
+
+	/* Validate header magic */
+	if (eipp->id[0] != 'D' || eipp->id[1] != 'H' || eipp->id[2] != 'E')
+		return -EINVAL;
+
+	/* Validate header checksum */
+	c8 = crc8(0xff, buffer, offsetof(struct eeprom_id_page, header_crc8));
+	if (eipp->header_crc8 != c8)
+		return -EINVAL;
+
+	/* Here the data has a valid header, so that all data can be copied */
+	memcpy(eeprom_buffer, buffer, eeprom_size);
+
+	return 0;
+}
+
+int dh_get_value_from_eeprom_buffer(enum eip_request_values request, u8 *data, int data_len,
+				    u8 *eeprom_buffer)
+{
+	struct eeprom_id_page *eipp;
+	char soc;
+	u16 c16;
+	u8 c8;
+
+	eipp = (struct eeprom_id_page *)eeprom_buffer;
+
+	/* Validate header magic */
+	if (eipp->id[0] != 'D' || eipp->id[1] != 'H' || eipp->id[2] != 'E')
+		return -EINVAL;
+
+	/* Validate header checksum */
+	c8 = crc8(0xff, eeprom_buffer, offsetof(struct eeprom_id_page, header_crc8));
+	if (eipp->header_crc8 != c8)
+		return -EINVAL;
+
+	/* Validate header version */
+	if (eipp->version != 0x10)
+		return -EINVAL;
+
+	/* Validate structure checksum */
+	c16 = crc16(0xffff, eeprom_buffer + offsetof(struct eeprom_id_page, mac0),
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
+	case DH_ITEM_NUMBER:
+		if (data_len < 8) /* String length must be 7 characters + string termination */
+			return -EINVAL;
+
+		switch (eipp->item_prefix & 0xf) {
+		case DH_ITEM_PREFIX_NXP:
+			soc = DH_ITEM_PREFIX_NXP_CHR;
+			break;
+		case DH_ITEM_PREFIX_ST:
+			soc = DH_ITEM_PREFIX_ST_CHR;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		snprintf(data, data_len, "%c%c%05d",
+			 (eipp->item_prefix & DH_ITEM_PREFIX_FIN_BIT) ?
+			 DH_ITEM_PREFIX_FIN_FLASHED_CHR : DH_ITEM_PREFIX_FIN_HALF_CHR,
+			 soc, (eipp->item_num[0] << 16) | (eipp->item_num[1] << 8)
+			       | eipp->item_num[2]);
+		break;
+	case DH_SERIAL_NUMBER:
+		/*
+		 * data_len must be greater than the size of eipp->serial,
+		 * because there is a string termination needed.
+		 */
+		if (data_len <= sizeof(eipp->serial))
+			return -EINVAL;
+
+		data[sizeof(eipp->serial)] = 0;
+		memcpy(data, eipp->serial, sizeof(eipp->serial));
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
@@ -62,7 +255,7 @@ int dh_get_mac_from_eeprom(unsigned char *enetaddr, const char *alias)
 	return 0;
 }
 
-__weak int dh_setup_mac_address(void)
+__weak int dh_setup_mac_address(u8 *eeprom_buffer)
 {
 	unsigned char enetaddr[6];
 
@@ -72,6 +265,9 @@ __weak int dh_setup_mac_address(void)
 	if (dh_get_mac_is_enabled("ethernet0"))
 		return 0;
 
+	if (!dh_get_value_from_eeprom_buffer(MAC0, enetaddr, sizeof(enetaddr), eeprom_buffer))
+		return 0;
+
 	if (!dh_get_mac_from_eeprom(enetaddr, "eeprom0"))
 		return eth_env_set_enetaddr("ethaddr", enetaddr);
 
diff --git a/board/dhelectronics/common/dh_common.h b/board/dhelectronics/common/dh_common.h
index a2de5b1553..60806c452a 100644
--- a/board/dhelectronics/common/dh_common.h
+++ b/board/dhelectronics/common/dh_common.h
@@ -3,6 +3,15 @@
  * Copyright 2022 DENX Software Engineering GmbH, Philip Oberfichtner <pro@denx.de>
  */
 
+#define DH_EEPROM_ID_PAGE_MAX_SIZE	64
+
+enum eip_request_values {
+	MAC0,
+	MAC1,
+	DH_ITEM_NUMBER,
+	DH_SERIAL_NUMBER,
+};
+
 /*
  * dh_mac_is_in_env - Check if MAC address is already set
  *
@@ -28,9 +37,40 @@ int dh_get_mac_is_enabled(const char *alias);
  */
 int dh_get_mac_from_eeprom(unsigned char *enetaddr, const char *alias);
 
+/*
+ * dh_read_eeprom_id_page() - Read EEPROM ID page content into given buffer
+ * @eeprom_buffer:	Buffer for EEPROM ID page content
+ * @alias:		Alias for EEPROM device tree node
+ *
+ * Read the content of the EEPROM ID page into the given buffer (parameter
+ * eeprom_buffer). The EEPROM device is selected via alias device tree name
+ * (parameter alias). The header of the EEPROM ID page is verified. An error
+ * is returned for reading failures and invalid header data.
+ *
+ * Return: 0 if OK, other value on error
+ */
+int dh_read_eeprom_id_page(u8 *eeprom_buffer, const char *alias);
+
+/*
+ * dh_get_value_from_eeprom_buffer() - Get value from EEPROM buffer
+ * @eip_request_values:	Requested value as enum
+ * @data:		Buffer where value is to be stored
+ * @data_len:		Length of the value buffer
+ * @eeprom_buffer:	EEPROM buffer from which the data is parsed
+ *
+ * Gets the value specified by the parameter eip_request_values from the EEPROM
+ * buffer (parameter eeprom_buffer). The data is written to the specified data
+ * buffer (parameter data). If the length of the data (parameter data_len) is
+ * not sufficient to copy the data into the buffer, an error is returned.
+ *
+ * Return: 0 if OK, other value on error
+ */
+int dh_get_value_from_eeprom_buffer(enum eip_request_values request, u8 *data, int data_len,
+				    u8 *eeprom_buffer);
+
 /*
  * dh_setup_mac_address - Try to get MAC address from various locations and write it to env
  *
  * Return: 0 if OK, other value on error
  */
-int dh_setup_mac_address(void);
+int dh_setup_mac_address(u8 *eeprom_buffer);
diff --git a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
index 78aae41235..16c76b5dac 100644
--- a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
+++ b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
@@ -40,7 +40,26 @@ int board_phys_sdram_size(phys_size_t *size)
 	return 0;
 }
 
-static int dh_imx8_setup_ethaddr(void)
+int dh_get_som_rev(void)
+{
+	int ret;
+
+	/*
+	 * The hardware revision numbers are binary coded with 3 GPIOs:
+	 * 0x0 = Rev. 100
+	 * 0x1 = Rev. 200
+	 * 0x2 = Rev. 300
+	 * ...
+	 */
+	ret = !!(readl(GPIO3_BASE_ADDR) & BIT(14));
+	ret |= !!(readl(GPIO4_BASE_ADDR) & BIT(19)) << 1;
+	ret |= !!(readl(GPIO3_BASE_ADDR) & BIT(25)) << 2;
+	ret = ret * 100 + 100;
+
+	return ret;
+}
+
+static int dh_imx8_setup_ethaddr(u8 *eeprom_buffer)
 {
 	unsigned char enetaddr[6];
 
@@ -53,6 +72,11 @@ static int dh_imx8_setup_ethaddr(void)
 	if (!dh_imx_get_mac_from_fuse(enetaddr))
 		goto out;
 
+	/* The EEPROM ID page is available on SoM rev. 200 and greater. */
+	if ((dh_get_som_rev() > 100) &&
+	    (!dh_get_value_from_eeprom_buffer(MAC0, enetaddr, sizeof(enetaddr), eeprom_buffer)))
+		goto out;
+
 	if (!dh_get_mac_from_eeprom(enetaddr, "eeprom0"))
 		goto out;
 
@@ -62,7 +86,7 @@ out:
 	return eth_env_set_enetaddr("ethaddr", enetaddr);
 }
 
-static int dh_imx8_setup_eth1addr(void)
+static int dh_imx8_setup_eth1addr(u8 *eeprom_buffer)
 {
 	unsigned char enetaddr[6];
 
@@ -75,6 +99,11 @@ static int dh_imx8_setup_eth1addr(void)
 	if (!dh_imx_get_mac_from_fuse(enetaddr))
 		goto increment_out;
 
+	/* The EEPROM ID page is available on SoM rev. 200 and greater. */
+	if ((dh_get_som_rev() > 100) &&
+	    (!dh_get_value_from_eeprom_buffer(MAC1, enetaddr, sizeof(enetaddr), eeprom_buffer)))
+		goto out;
+
 	if (!dh_get_mac_from_eeprom(enetaddr, "eeprom1"))
 		goto out;
 
@@ -95,21 +124,58 @@ out:
 	return eth_env_set_enetaddr("eth1addr", enetaddr);
 }
 
-int dh_setup_mac_address(void)
+int dh_setup_mac_address(u8 *eeprom_buffer)
 {
 	int ret;
 
-	ret = dh_imx8_setup_ethaddr();
+	ret = dh_imx8_setup_ethaddr(eeprom_buffer);
 	if (ret)
 		printf("%s: Unable to setup ethaddr! ret = %d\n", __func__, ret);
 
-	ret = dh_imx8_setup_eth1addr();
+	ret = dh_imx8_setup_eth1addr(eeprom_buffer);
 	if (ret)
 		printf("%s: Unable to setup eth1addr! ret = %d\n", __func__, ret);
 
 	return ret;
 }
 
+void dh_add_item_number_and_serial_to_env(u8 *eeprom_buffer)
+{
+	char *item_number_env;
+	char item_number[8];	/* String with 7 characters + string termination */
+	char *serial_env;
+	char serial[10];	/* String with 9 characters + string termination */
+	int ret;
+
+	ret = dh_get_value_from_eeprom_buffer(DH_ITEM_NUMBER, item_number, sizeof(item_number),
+					      eeprom_buffer);
+	if (ret) {
+		printf("%s: Unable to get item number from EEPROM ID page! ret = %d\n",
+		       __func__, ret);
+	} else {
+		item_number_env = env_get("vendor_item_number");
+		if (!item_number_env)
+			env_set("vendor_item_number", item_number);
+		else if (strcmp(item_number_env, item_number) != 0)
+			log_warning("Warning: Environment vendor_item_number differs from EEPROM ID page value (%s != %s)\n",
+				    item_number_env, item_number);
+	}
+
+	ret = dh_get_value_from_eeprom_buffer(DH_SERIAL_NUMBER, serial, sizeof(serial),
+					      eeprom_buffer);
+	if (ret) {
+		printf("%s: Unable to get serial from EEPROM ID page! ret = %d\n",
+		       __func__, ret);
+	} else {
+		serial_env = env_get("SN");
+		if (!serial_env)
+			env_set("SN", serial);
+		else if (strcmp(serial_env, serial) != 0)
+			log_warning("Warning: Environment SN differs from EEPROM ID page value (%s != %s)\n",
+				    serial_env, serial);
+	}
+}
+
 int board_init(void)
 {
 	return 0;
@@ -117,7 +183,19 @@ int board_init(void)
 
 int board_late_init(void)
 {
-	dh_setup_mac_address();
+	u8 eeprom_buffer[DH_EEPROM_ID_PAGE_MAX_SIZE] = { 0 };
+	int ret;
+
+	/* The EEPROM ID page is available on SoM rev. 200 and greater. */
+	if (dh_get_som_rev() > 100) {
+		ret = dh_read_eeprom_id_page(eeprom_buffer, "eeprom0");
+		if (ret)
+			printf("%s: Cannot read from EEPROM ID page! ret = %d\n", __func__, ret);
+		else
+			dh_add_item_number_and_serial_to_env(eeprom_buffer);
+	}
+	dh_setup_mac_address(eeprom_buffer);
+
 	return 0;
 }
 
-- 
2.30.2

