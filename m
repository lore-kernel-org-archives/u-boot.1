Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3633CD7879B
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 17:24:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5717896E0;
	Thu, 21 Nov 2024 18:24:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="ea0y+WMw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25582896EA; Thu, 21 Nov 2024 18:24:24 +0100 (CET)
Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
 by phobos.denx.de (Postfix) with ESMTP id 3E1AD896C9
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 18:24:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1732209857;
 bh=xdimxSxpD86Af0a2emgZBAmEf2oAv3uXS7W0b/kLwiA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=ea0y+WMwMLG5A31sKH8scDh8mIJ7gReS4SYD8pscPYZTc0GVMkSKB4ehvStREH4HR
 F3Pp2I/BpUS0qhN3gS138jXKxvt44ItbzhgZ9PLXR1BRD5L9FOx/+9pg4aaFloAt37
 qDR1RJLuuwNlT2eBObucUEpdRCx+Xx1DiuBZZIJVtxTQYb+ZkT1Qhp66gujLbA9MWb
 AH1hXtbu5UC4d6AG89i8XyCtPNBbfFxg+E1G1n6qRCQfXslLJ7T+t5CZtn9hERP7DV
 JbGPAfZtbnAdNNwKl/w6S60TjqIMOD6RjtO9jYpok5ZRwYmsPqu/U0FbAXKN2Z4E+A
 vkn7dczOiVu1Q==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <u-boot@lists.denx.de>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, NXP i.MX U-Boot
 Team <uboot-imx@nxp.com>, Marek Vasut <marex@denx.de>, Fabio Estevam
 <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>
Subject: [PATCH V3 3/3] board: dhelectronics: Sync env variable
 dh_som_serial_number with SN
Date: Thu, 21 Nov 2024 18:21:54 +0100
Message-ID: <20241121172154.90507-3-cniedermaier@dh-electronics.com>
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

The env variable "SN" is used to store the serial number on DH electronics
SoMs. New SoMs will use the variable "dh_som_serial_number". To ensure
compatibility, these env variables are synchronized. This is achieved
using callback functions. To avoid recursive calls, these are locked
against each other.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
---
V3: - Add this patch to the series
---
 board/dhelectronics/common/dh_common.c | 26 ++++++++++++++++++++++++++
 configs/imx8mp_dhsom.config            |  1 +
 2 files changed, 27 insertions(+)

diff --git a/board/dhelectronics/common/dh_common.c b/board/dhelectronics/common/dh_common.c
index a7b0472a09..2e3e5c483b 100644
--- a/board/dhelectronics/common/dh_common.c
+++ b/board/dhelectronics/common/dh_common.c
@@ -45,6 +45,32 @@ struct eeprom_id_page {
 #define DH_EEPROM_ID_PAGE_V1_0_DATA_LEN	(sizeof(struct eeprom_id_page) - \
 					offsetof(struct eeprom_id_page, mac0))
 
+static bool in_dh_som_serial_number;
+static bool in_SN;
+
+static int on_dh_som_serial_number(const char *name, const char *value, enum env_op op,
+				   int flags)
+{
+	in_dh_som_serial_number = true;
+	if (!in_SN)
+		env_set("SN", value);
+	in_dh_som_serial_number = false;
+	return 0;
+}
+
+U_BOOT_ENV_CALLBACK(dh_som_serial_number, on_dh_som_serial_number);
+
+static int on_SN(const char *name, const char *value, enum env_op op, int flags)
+{
+	in_SN = true;
+	if (!in_dh_som_serial_number)
+		env_set("dh_som_serial_number", value);
+	in_SN = false;
+	return 0;
+}
+
+U_BOOT_ENV_CALLBACK(SN, on_SN);
+
 bool dh_mac_is_in_env(const char *env)
 {
 	unsigned char enetaddr[6];
diff --git a/configs/imx8mp_dhsom.config b/configs/imx8mp_dhsom.config
index 416143178c..87bf3bf65e 100644
--- a/configs/imx8mp_dhsom.config
+++ b/configs/imx8mp_dhsom.config
@@ -59,6 +59,7 @@ CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=20
 CONFIG_SYS_EEPROM_SIZE=16384
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
 
+CONFIG_ENV_CALLBACK_LIST_STATIC="dh_som_serial_number:dh_som_serial_number,SN:SN,"
 CONFIG_ENV_OFFSET=0xFE0000
 CONFIG_ENV_OFFSET_REDUND=0xFF0000
 CONFIG_ENV_SECT_SIZE=0x1000
-- 
2.30.2

