Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EE7CF11F4
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 13:25:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE627891E9;
	Thu, 10 Oct 2024 15:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="DGtNEbAd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A56988927F; Thu, 10 Oct 2024 15:25:24 +0200 (CEST)
Received: from mx2.securetransport.de (mx2.securetransport.de
 [IPv6:2a03:4000:13:6c7::1])
 by phobos.denx.de (Postfix) with ESMTP id B849789347
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 15:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1728566709;
 bh=Kbs5wNG0oX5zdBrCDk2J5dQ4K9z4NHfY+EsN5r42G+M=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=DGtNEbAdlUeD4MU70/GyPtBjVFSLVcATmnD5iWeWhY4t9b7TOF4c5X6aEyR7rLcY/
 ZcSZiHO8vfXC7WeZ/8ZGFQ+qJ3e+PkPjEnPBzB+93BpeIRMxfu6NAU90A19SMqc7GF
 4K1xhSRA7qG9RSRlMSX0Wb0wslVrY/pVAlYzpRGVscn447MmarD9jV/1Nhzb69+PSd
 kmA+8mNQ7nH2WYRcfhr5pe0DmMYvOoy6Sp6fZEWCUgz6J+fIGAcTW4RGGErfBYUvrz
 6NKUMswetg2H02zx8UAzbihMXmleeNEsMCGzRdxPHjNlMrsIvDgU0owGDaZUWiB/4U
 g1bYz/1SruQaQ==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <u-boot@lists.denx.de>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, NXP i.MX U-Boot
 Team <uboot-imx@nxp.com>, Marek Vasut <marex@denx.de>, Fabio Estevam
 <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>
Subject: [PATCH 2/2] arm64: imx8mp: Read item and serial number from EEPROM ID
 page on DH i.MX8MP DHCOM
Date: Thu, 10 Oct 2024 15:23:37 +0200
Message-ID: <20241010132337.3259-2-cniedermaier@dh-electronics.com>
X-klartext: yes
In-Reply-To: <20241010132337.3259-1-cniedermaier@dh-electronics.com>
References: <20241010132337.3259-1-cniedermaier@dh-electronics.com>
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
which contains additional write-lockable page called ID page, which
is populated with a structure containing the item and serial number.

Extend the support for parsing the item and serial number of the
EEPROM ID page. Write the item and serial number to the U-Boot
environment if the aren't there. If the environment is already
there compare it with the one from the EEPROM ID page and output
a warning if it differs.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
---
 board/dhelectronics/common/dh_common.c        | 51 ++++++++++++++++++
 board/dhelectronics/common/dh_common.h        |  2 +
 .../dh_imx8mp/imx8mp_dhcom_pdk2.c             | 53 +++++++++++++++++++
 3 files changed, 106 insertions(+)

diff --git a/board/dhelectronics/common/dh_common.c b/board/dhelectronics/common/dh_common.c
index 8ea70fc984..4c31b32e0c 100644
--- a/board/dhelectronics/common/dh_common.c
+++ b/board/dhelectronics/common/dh_common.c
@@ -11,6 +11,23 @@
 
 #include "dh_common.h"
 
+/* DH item: Vendor coding */
+#define ITEM_PREFIX_NXP		0x01
+#define ITEM_PREFIX_NXP_CHR	'I'
+#define ITEM_PREFIX_ST		0x02
+#define ITEM_PREFIX_ST_CHR	'S'
+
+/*
+ * DH item: Finished state coding
+ * Bit = 0 means half finished
+ *         Prefix is 'H'
+ * Bit = 1 means finished with a customer image flashed
+ *         Prefix is 'F'
+ */
+#define ITEM_PREFIX_FIN_BIT		BIT(7)
+#define ITEM_PREFIX_FIN_HALF_CHR	'H'
+#define ITEM_PREFIX_FIN_FLASHED_CHR	'F'
+
 struct eeprom_id_page {
 	u8	id[3];		/* Identifier 'D', 'H', 'E' - 'D' is at index 0 */
 	u8	version;	/* 0x10 -- Version 1.0 */
@@ -54,6 +71,7 @@ int dh_get_value_from_eeprom_id_page(enum eip_request_values request, u8 *data,
 	ofnode node;
 	u16 c16;
 	u8 c8;
+	char soc;
 
 	eipp = (struct eeprom_id_page *)eipa;
 
@@ -136,6 +154,39 @@ int dh_get_value_from_eeprom_id_page(enum eip_request_values request, u8 *data,
 		else
 			return -EINVAL;
 		break;
+	case ITEM_NUMBER:
+		if (data_len >= 8) { /* String with 7 characters + string termination */
+			switch (eipp->item_prefix & 0xf) {
+			case ITEM_PREFIX_NXP:
+				soc = ITEM_PREFIX_NXP_CHR;
+				break;
+			case ITEM_PREFIX_ST:
+				soc = ITEM_PREFIX_ST_CHR;
+				break;
+			default:
+				return -EINVAL;
+			}
+			snprintf(data, data_len, "%c%c%05d",
+				 (eipp->item_prefix & ITEM_PREFIX_FIN_BIT) ?
+				 ITEM_PREFIX_FIN_FLASHED_CHR : ITEM_PREFIX_FIN_HALF_CHR,
+				 soc, (eipp->item_num[0] << 16) | (eipp->item_num[1] << 8)
+				       | eipp->item_num[2]);
+		} else {
+			return -EINVAL;
+		}
+		break;
+	case SN:
+		/*
+		 * data_len must be greater than the size of eipp->serial,
+		 * because there is a string termination needed.
+		 */
+		if (data_len > sizeof(eipp->serial)) {
+			data[sizeof(eipp->serial)] = 0;
+			memcpy(data, eipp->serial, sizeof(eipp->serial));
+		} else {
+			return -EINVAL;
+		}
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/board/dhelectronics/common/dh_common.h b/board/dhelectronics/common/dh_common.h
index 4c22ece435..1baa45e340 100644
--- a/board/dhelectronics/common/dh_common.h
+++ b/board/dhelectronics/common/dh_common.h
@@ -6,6 +6,8 @@
 enum eip_request_values {
 	MAC0,
 	MAC1,
+	ITEM_NUMBER,
+	SN,
 };
 
 /*
diff --git a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
index 9a8f09fcd4..8970c8fc2d 100644
--- a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
+++ b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
@@ -116,6 +116,56 @@ int dh_setup_mac_address(void)
 	return ret;
 }
 
+void dh_add_item_number_and_serial_to_env(void)
+{
+	char item_number[8];	/* String with 7 characters + string termination */
+	char *item_number_env;
+	char serial[10];	/* String with 9 characters + string termination */
+	char *serial_env;
+	int ret;
+
+	ret = dh_get_value_from_eeprom_id_page(ITEM_NUMBER, item_number, sizeof(item_number),
+					       "eeprom0");
+	if (ret) {
+		/*
+		 * The function only returns the value -ENOENT for SoM rev.100, because
+		 * the EEPROM ID page isn't available there. Therefore the output makes
+		 * no sense and will be suppressed here.
+		 */
+		if (ret != -ENOENT)
+			printf("%s: Unable to get item number form EEPROM ID page! ret = %d\n",
+			       __func__, ret);
+	} else {
+		item_number_env = env_get("vendor_item_number");
+		if (!item_number_env)
+			env_set("vendor_item_number", item_number);
+		else
+			if (strcmp(item_number_env, item_number) != 0)
+				printf("Warning: Environment vendor_item_number differs from EEPROM ID page value (%s != %s)\n",
+				       item_number_env, item_number);
+	}
+
+	ret = dh_get_value_from_eeprom_id_page(SN, serial, sizeof(serial), "eeprom0");
+	if (ret) {
+		/*
+		 * The function only returns the value -ENOENT for SoM rev.100, because
+		 * the EEPROM ID page isn't available there. Therefore the output makes
+		 * no sense and will be suppressed here.
+		 */
+		if (ret != -ENOENT)
+			printf("%s: Unable to get serial form EEPROM ID page! ret = %d\n",
+			       __func__, ret);
+	} else {
+		serial_env = env_get("SN");
+		if (!serial_env)
+			env_set("SN", serial);
+		else
+			if (strcmp(serial_env, serial) != 0)
+				printf("Warning: Environment SN differs from EEPROM ID page value (%s != %s)\n",
+				       serial_env, serial);
+	}
+}
+
 int board_init(void)
 {
 	return 0;
@@ -124,6 +174,9 @@ int board_init(void)
 int board_late_init(void)
 {
 	dh_setup_mac_address();
+
+	dh_add_item_number_and_serial_to_env();
+
 	return 0;
 }
 
-- 
2.30.2

