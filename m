Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F404BD7879D
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 17:24:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 704FA89669;
	Thu, 21 Nov 2024 18:24:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="hZW/C4E1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 758888968F; Thu, 21 Nov 2024 18:24:08 +0100 (CET)
Received: from mx3.securetransport.de (mx3.securetransport.de
 [IPv6:2a01:4f8:c0c:92be::1])
 by phobos.denx.de (Postfix) with ESMTP id 2217888815
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 18:24:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1732209840;
 bh=86N+qTR+CkLoKZ/+GvIpxgsRbZoEdLBqQYcT54WSgYw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=hZW/C4E1bVeq9C4xGkmq20gj/SMkLHRSd1w1ID7/oMOxETvP32gvJmFys7jGRcvM0
 Ai/fEiw/xlHaGr0RWHabuDWtC9UkY0nycIdaOUqCYaqY6zWqeEtcPzKeA66WFOEa4v
 3qjXtE8rUMKsFg92kk2eB1aKQ1lgq5wV7bO1ILkYVgxD6WtJf2DrdLmU0NaLxdtS4w
 3o8qHwObDa3Or5LLJu8Tow3pIAU+9c/7H48+UUH9w2W+96sy/ZZmKzZlGxrSDO5mPn
 Kzk/lTY0VKz3sz2BHVjQcM+SPnR7MREaE+ZfeIapcws4iOTisaIRZ1lChsR8vWDtga
 1dIKhNRjNwxjA==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <u-boot@lists.denx.de>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, NXP i.MX U-Boot
 Team <uboot-imx@nxp.com>, Marek Vasut <marex@denx.de>, Fabio Estevam
 <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>
Subject: [PATCH V3 2/3] arm64: imx8mp: Read values from M24C32-D
 write-lockable page on DHCOM i.MX8MP
Date: Thu, 21 Nov 2024 18:21:53 +0100
Message-ID: <20241121172154.90507-2-cniedermaier@dh-electronics.com>
X-klartext: yes
In-Reply-To: <20241121172154.90507-1-cniedermaier@dh-electronics.com>
References: <20241121172154.90507-1-cniedermaier@dh-electronics.com>
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

Because the write-lockable page is not present on rev.100 i.MX8MP DHCOM
SoM, test whether EEPROM ID page exists by setting up the i2c driver.

There may be multiple EEPROMs with an ID page on this platform, always
use the first one. The evaluation of the EEPROM ID page is done in two
steps. First, the content is read and checked. This is done to cache
the content of the EEPROM ID page. Second, the content is extracted
from the EEPROM buffer by requesting it.

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
V3: - Add #defines for the version of the EEPROM ID page data located in the header
    - Reference EEPROM ID page directly by new aliases
    - Read EEPROM content directly to the buffer by the given parameter
    - Give some variables a more meaningful name
    - Improve determination of the EEPROM ID page size
    - Validation of the EEPROM ID page data in the reading function
    - Shorten the reading function
    - Add namespace to all defines and enums
    - Use more local variable in the evaluation function for a better reading
    - Fix wrong return of the function __weak int dh_setup_mac_address()
    - Remove function for reading the hardware revision
    - Use printf for output throughout
    - After EEPROM ID page reading error call the function dh_setup_mac_address() with parameter NULL
    - Suppress error message for the hardware rev. 100 in case of return value -ENODEV
---
 board/dhelectronics/common/dh_common.c        | 175 +++++++++++++++++-
 board/dhelectronics/common/dh_common.h        |  42 ++++-
 .../dh_imx8mp/imx8mp_dhcom_pdk2.c             |  74 +++++++-
 3 files changed, 283 insertions(+), 8 deletions(-)

diff --git a/board/dhelectronics/common/dh_common.c b/board/dhelectronics/common/dh_common.c
index 32c50b4f0f..a7b0472a09 100644
--- a/board/dhelectronics/common/dh_common.c
+++ b/board/dhelectronics/common/dh_common.c
@@ -7,9 +7,44 @@
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
+#define DH_EEPROM_ID_PAGE_HEADER_LEN	offsetof(struct eeprom_id_page, mac0)
+#define DH_EEPROM_ID_PAGE_V1_0		0x10
+#define DH_EEPROM_ID_PAGE_V1_0_DATA_LEN	(sizeof(struct eeprom_id_page) - \
+					offsetof(struct eeprom_id_page, mac0))
+
 bool dh_mac_is_in_env(const char *env)
 {
 	unsigned char enetaddr[6];
@@ -30,6 +65,141 @@ int dh_get_mac_is_enabled(const char *alias)
 	return 0;
 }
 
+int dh_read_eeprom_id_page(u8 *eeprom_buffer, const char *alias)
+{
+	struct eeprom_id_page *eip;
+	struct udevice *dev;
+	size_t data_len;
+	int eeprom_size;
+	u16 crc16_calc;
+	u16 crc16_eip;
+	u8 crc8_calc;
+	ofnode node;
+	int ret;
+
+	node = ofnode_path(alias);
+
+	ret = uclass_get_device_by_ofnode(UCLASS_I2C_EEPROM, node, &dev);
+	if (ret)
+		return ret;
+
+	eeprom_size = i2c_eeprom_size(dev);
+	if (eeprom_size < 0 || eeprom_size > DH_EEPROM_ID_PAGE_MAX_SIZE) {
+		eeprom_size = DH_EEPROM_ID_PAGE_MAX_SIZE;
+		printf("Warning: Cannot get valid EEPROM.ID page size! Try to read %d bytes.\n",
+		       DH_EEPROM_ID_PAGE_MAX_SIZE);
+	}
+
+	ret = i2c_eeprom_read(dev, 0x0, eeprom_buffer, eeprom_size);
+	if (ret) {
+		printf("%s: Error reading EEPROM ID page! ret = %d\n", __func__, ret);
+		return ret;
+	}
+
+	eip = (struct eeprom_id_page *)eeprom_buffer;
+
+	/* Validate header ID */
+	if (eip->id[0] != 'D' || eip->id[1] != 'H' || eip->id[2] != 'E') {
+		printf("%s: Error validating header ID! (expected DHE)\n", __func__);
+		return -EINVAL;
+	}
+
+	/* Validate header checksum */
+	crc8_calc = crc8(0xff, eeprom_buffer, offsetof(struct eeprom_id_page, header_crc8));
+	if (eip->header_crc8 != crc8_calc) {
+		printf("%s: Error validating header checksum! (expected 0x%02X)\n",
+		       __func__, crc8_calc);
+		return -EINVAL;
+	}
+
+	/* Validate header version */
+	if (eip->version == DH_EEPROM_ID_PAGE_V1_0) {
+		data_len = DH_EEPROM_ID_PAGE_V1_0_DATA_LEN;
+	} else {
+		printf("%s: Error validating version! (0x%02X is not supported)\n",
+		       __func__, eip->version);
+		return -EINVAL;
+	}
+
+	/* Validate data checksum */
+	crc16_eip = (eip->data_crc16[1] << 8) | eip->data_crc16[0];
+	crc16_calc = crc16(0xffff, eeprom_buffer + DH_EEPROM_ID_PAGE_HEADER_LEN, data_len);
+	if (crc16_eip != crc16_calc) {
+		printf("%s: Error validating data checksum! (expected 0x%02X)\n",
+		       __func__, crc16_calc);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int dh_get_value_from_eeprom_buffer(enum eip_request_values request, u8 *data, int data_len,
+				    u8 *eeprom_buffer)
+{
+	struct eeprom_id_page *eip = (struct eeprom_id_page *)eeprom_buffer;
+	char soc_chr;
+
+	if (!eeprom_buffer)
+		return -EINVAL;
+
+	/* Copy requested data */
+	switch (request) {
+	case DH_MAC0:
+		if (!is_valid_ethaddr(eip->mac0))
+			return -EINVAL;
+
+		if (data_len >= sizeof(eip->mac0))
+			memcpy(data, eip->mac0, sizeof(eip->mac0));
+		else
+			return -EINVAL;
+		break;
+	case DH_MAC1:
+		if (!is_valid_ethaddr(eip->mac1))
+			return -EINVAL;
+
+		if (data_len >= sizeof(eip->mac1))
+			memcpy(data, eip->mac1, sizeof(eip->mac1));
+		else
+			return -EINVAL;
+		break;
+	case DH_ITEM_NUMBER:
+		if (data_len < 8) /* String length must be 7 characters + string termination */
+			return -EINVAL;
+
+		const u8 soc_coded = eip->item_prefix & 0xf;
+
+		if (soc_coded == DH_ITEM_PREFIX_NXP)
+			soc_chr = DH_ITEM_PREFIX_NXP_CHR;
+		else if (soc_coded == DH_ITEM_PREFIX_ST)
+			soc_chr = DH_ITEM_PREFIX_ST_CHR;
+		else
+			return -EINVAL;
+
+		const char fin_chr = (eip->item_prefix & DH_ITEM_PREFIX_FIN_BIT) ?
+				      DH_ITEM_PREFIX_FIN_FLASHED_CHR :
+				      DH_ITEM_PREFIX_FIN_HALF_CHR;
+
+		snprintf(data, data_len, "%c%c%05d", fin_chr, soc_chr,
+			 (eip->item_num[0] << 16) | (eip->item_num[1] << 8) | eip->item_num[2]);
+		break;
+	case DH_SERIAL_NUMBER:
+		/*
+		 * data_len must be greater than the size of eip->serial,
+		 * because there is a string termination needed.
+		 */
+		if (data_len <= sizeof(eip->serial))
+			return -EINVAL;
+
+		data[sizeof(eip->serial)] = 0;
+		memcpy(data, eip->serial, sizeof(eip->serial));
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
@@ -62,7 +232,7 @@ int dh_get_mac_from_eeprom(unsigned char *enetaddr, const char *alias)
 	return 0;
 }
 
-__weak int dh_setup_mac_address(void)
+__weak int dh_setup_mac_address(u8 *eeprom_buffer)
 {
 	unsigned char enetaddr[6];
 
@@ -72,6 +242,9 @@ __weak int dh_setup_mac_address(void)
 	if (dh_get_mac_is_enabled("ethernet0"))
 		return 0;
 
+	if (!dh_get_value_from_eeprom_buffer(DH_MAC0, enetaddr, sizeof(enetaddr), eeprom_buffer))
+		return eth_env_set_enetaddr("ethaddr", enetaddr);
+
 	if (!dh_get_mac_from_eeprom(enetaddr, "eeprom0"))
 		return eth_env_set_enetaddr("ethaddr", enetaddr);
 
diff --git a/board/dhelectronics/common/dh_common.h b/board/dhelectronics/common/dh_common.h
index a2de5b1553..d050861915 100644
--- a/board/dhelectronics/common/dh_common.h
+++ b/board/dhelectronics/common/dh_common.h
@@ -3,6 +3,15 @@
  * Copyright 2022 DENX Software Engineering GmbH, Philip Oberfichtner <pro@denx.de>
  */
 
+#define DH_EEPROM_ID_PAGE_MAX_SIZE	64
+
+enum eip_request_values {
+	DH_MAC0,
+	DH_MAC1,
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
+ * (parameter alias). The data of the EEPROM ID page is verified. An error
+ * is returned for reading failures and invalid data.
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
index 78aae41235..e7b88a36bb 100644
--- a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
+++ b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
@@ -40,7 +40,7 @@ int board_phys_sdram_size(phys_size_t *size)
 	return 0;
 }
 
-static int dh_imx8_setup_ethaddr(void)
+static int dh_imx8_setup_ethaddr(u8 *eeprom_buffer)
 {
 	unsigned char enetaddr[6];
 
@@ -53,6 +53,9 @@ static int dh_imx8_setup_ethaddr(void)
 	if (!dh_imx_get_mac_from_fuse(enetaddr))
 		goto out;
 
+	if (!dh_get_value_from_eeprom_buffer(DH_MAC0, enetaddr, sizeof(enetaddr), eeprom_buffer))
+		goto out;
+
 	if (!dh_get_mac_from_eeprom(enetaddr, "eeprom0"))
 		goto out;
 
@@ -62,7 +65,7 @@ out:
 	return eth_env_set_enetaddr("ethaddr", enetaddr);
 }
 
-static int dh_imx8_setup_eth1addr(void)
+static int dh_imx8_setup_eth1addr(u8 *eeprom_buffer)
 {
 	unsigned char enetaddr[6];
 
@@ -75,6 +78,9 @@ static int dh_imx8_setup_eth1addr(void)
 	if (!dh_imx_get_mac_from_fuse(enetaddr))
 		goto increment_out;
 
+	if (!dh_get_value_from_eeprom_buffer(DH_MAC1, enetaddr, sizeof(enetaddr), eeprom_buffer))
+		goto out;
+
 	if (!dh_get_mac_from_eeprom(enetaddr, "eeprom1"))
 		goto out;
 
@@ -95,21 +101,58 @@ out:
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
+		printf("%s: Unable to get DHSOM item number from EEPROM ID page! ret = %d\n",
+		       __func__, ret);
+	} else {
+		item_number_env = env_get("dh_som_item_number");
+		if (!item_number_env)
+			env_set("dh_som_item_number", item_number);
+		else if (strcmp(item_number_env, item_number) != 0)
+			printf("Warning: Environment dh_som_item_number differs from EEPROM ID page value (%s != %s)\n",
+			       item_number_env, item_number);
+	}
+
+	ret = dh_get_value_from_eeprom_buffer(DH_SERIAL_NUMBER, serial, sizeof(serial),
+					      eeprom_buffer);
+	if (ret) {
+		printf("%s: Unable to get DHSOM serial number from EEPROM ID page! ret = %d\n",
+		       __func__, ret);
+	} else {
+		serial_env = env_get("dh_som_serial_number");
+		if (!serial_env)
+			env_set("dh_som_serial_number", serial);
+		else if (strcmp(serial_env, serial) != 0)
+			printf("Warning: Environment dh_som_serial_number differs from EEPROM ID page value (%s != %s)\n",
+			       serial_env, serial);
+	}
+}
+
 int board_init(void)
 {
 	return 0;
@@ -117,7 +160,26 @@ int board_init(void)
 
 int board_late_init(void)
 {
-	dh_setup_mac_address();
+	u8 eeprom_buffer[DH_EEPROM_ID_PAGE_MAX_SIZE] = { 0 };
+	int ret;
+
+	ret = dh_read_eeprom_id_page(eeprom_buffer, "eeprom0wl");
+	if (ret) {
+		/*
+		 * The EEPROM ID page is available on SoM rev. 200 and greater.
+		 * For SoM rev. 100 the return value will be -ENODEV. Suppress
+		 * the error message for that, because the absence cannot be
+		 * treated as an error.
+		 */
+		if (ret != -ENODEV)
+			printf("%s: Cannot read valid data from EEPROM ID page! ret = %d\n",
+			       __func__, ret);
+		dh_setup_mac_address(NULL);
+	} else {
+		dh_setup_mac_address(eeprom_buffer);
+		dh_add_item_number_and_serial_to_env(eeprom_buffer);
+	}
+
 	return 0;
 }
 
-- 
2.30.2

