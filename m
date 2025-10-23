Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAC1CCD193
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 21:49:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 480BA835FE;
	Thu, 23 Oct 2025 23:49:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dHKzrN+X";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="L18wB3mO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 819C6835B3; Thu, 23 Oct 2025 23:49:12 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81D518003E
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 23:49:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ct06Z2YYhz9thc;
 Thu, 23 Oct 2025 23:49:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761256150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=w3KTPYyYKcRJm6YwNZcC82u0HEITFxzKDLPL12WUOmk=;
 b=dHKzrN+XOc3CbTB9+pTWPe/84kAB6O3mINewYvaCDN5ZKfG2zm81qHX9AiJEzxvYsBz1kj
 I2SS44kvyyAXLcJiAP+yw9JyBQ/wJ0joqN3KbgqnsJzoqOY4mgN+RonDTuuaYJWX73RCms
 N3jEJhpcrL1XIsaOB+iQc0gGDaN3wCObnk5Po5iAiNxQimJCe6VuveGGCt0M/I+rOI1bHR
 Vz7OCGW9MWu9cJvknKPY2yrd/LxTZ5VEHMg8JbTPw9IjnxA+rjpG0wrIPFn8oINjDNiMKp
 t6at2USJ60kCAOkEIAkmFYM02Kx7a8XJlErUizhDoQTJU81a+p6IrX7aMGm6xA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=L18wB3mO;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761256148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=w3KTPYyYKcRJm6YwNZcC82u0HEITFxzKDLPL12WUOmk=;
 b=L18wB3mOjw9JoDBWygcxURNo7/OadnepM56LhlJKMvEYmoA1HOhTBVagxurki0y18o61p4
 790XK0Gh8o5ctjsUB00GxdwgcBRAX8XJRrie1ohtm9/+/x3Dh9v9xi2RjgtZDDp5UWVn9Y
 qaMdx1Ry3QCkj0+/e/+AKmf05UEs3uHbN2Sm30fsFLPNvZrq4+qEDP1qXSeBdgYiXV3Kyt
 TqN+a1C+i+MGerEmMRo3VY9FeO5NG3TF65HhdLxUwNO9hl+BUkHLi4ElGGW/oR1mCwfBbY
 kiQ+dkxqILntunUxv/h7rZ2RpVs+aAHEF2prQT/i83yrKK3BRSVukIFCic7KrQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 1/3] board: dhelectronics: Move
 dh_add_item_number_and_serial_to_env() to common code
Date: Thu, 23 Oct 2025 23:48:24 +0200
Message-ID: <20251023214855.181410-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: dygbab7pxr9xch5gkghknfeg76uqawfx
X-MBO-RS-ID: 49610a680fbb4128ec2
X-Rspamd-Queue-Id: 4ct06Z2YYhz9thc
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

Move dh_add_item_number_and_serial_to_env() to common code, so it
can be used by both STM32MP13xx and iMX8MP DHSOM. No functional
change.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 board/dhelectronics/common/dh_common.c        | 37 +++++++++++++++++++
 board/dhelectronics/common/dh_common.h        |  9 +++++
 .../dh_imx8mp/imx8mp_dhcom_pdk2.c             | 37 -------------------
 3 files changed, 46 insertions(+), 37 deletions(-)

diff --git a/board/dhelectronics/common/dh_common.c b/board/dhelectronics/common/dh_common.c
index 6101ecc7ebc..e7ee23aa8ce 100644
--- a/board/dhelectronics/common/dh_common.c
+++ b/board/dhelectronics/common/dh_common.c
@@ -246,3 +246,40 @@ __weak int dh_setup_mac_address(struct eeprom_id_page *eip)
 	printf("%s: Unable to set mac address!\n", __func__);
 	return -ENXIO;
 }
+
+void dh_add_item_number_and_serial_to_env(struct eeprom_id_page *eip)
+{
+	char *item_number_env;
+	char item_number[8];	/* String with 7 characters + string termination */
+	char *serial_env;
+	char serial[10];	/* String with 9 characters + string termination */
+	int ret;
+
+	ret = dh_get_value_from_eeprom_buffer(DH_ITEM_NUMBER, item_number, sizeof(item_number),
+					      eip);
+	if (ret) {
+		printf("%s: Unable to get DHSOM item number from EEPROM ID page! ret = %d\n",
+		       __func__, ret);
+	} else {
+		item_number_env = env_get("dh_som_item_number");
+		if (!item_number_env)
+			env_set("dh_som_item_number", item_number);
+		else if (strcmp(item_number_env, item_number))
+			printf("Warning: Environment dh_som_item_number differs from EEPROM ID page value (%s != %s)\n",
+			       item_number_env, item_number);
+	}
+
+	ret = dh_get_value_from_eeprom_buffer(DH_SERIAL_NUMBER, serial, sizeof(serial),
+					      eip);
+	if (ret) {
+		printf("%s: Unable to get DHSOM serial number from EEPROM ID page! ret = %d\n",
+		       __func__, ret);
+	} else {
+		serial_env = env_get("dh_som_serial_number");
+		if (!serial_env)
+			env_set("dh_som_serial_number", serial);
+		else if (strcmp(serial_env, serial))
+			printf("Warning: Environment dh_som_serial_number differs from EEPROM ID page value (%s != %s)\n",
+			       serial_env, serial);
+	}
+}
diff --git a/board/dhelectronics/common/dh_common.h b/board/dhelectronics/common/dh_common.h
index c4693c60618..b4f31bdb88e 100644
--- a/board/dhelectronics/common/dh_common.h
+++ b/board/dhelectronics/common/dh_common.h
@@ -107,7 +107,16 @@ int dh_get_value_from_eeprom_buffer(enum eip_request_values request, u8 *data, i
 
 /*
  * dh_setup_mac_address - Try to get MAC address from various locations and write it to env
+ * @eip: ID EEPROM buffer
  *
  * Return: 0 if OK, other value on error
  */
 int dh_setup_mac_address(struct eeprom_id_page *eip);
+
+/*
+ * dh_add_item_number_and_serial_to_env - Try to get DH IDs from WLP write them to env
+ * @eip: ID EEPROM buffer
+ *
+ * Return: 0 if OK, other value on error
+ */
+void dh_add_item_number_and_serial_to_env(struct eeprom_id_page *eip);
diff --git a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
index 3a890c5920c..5c35a5bf447 100644
--- a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
+++ b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
@@ -116,43 +116,6 @@ int dh_setup_mac_address(struct eeprom_id_page *eip)
 	return ret;
 }
 
-void dh_add_item_number_and_serial_to_env(struct eeprom_id_page *eip)
-{
-	char *item_number_env;
-	char item_number[8];	/* String with 7 characters + string termination */
-	char *serial_env;
-	char serial[10];	/* String with 9 characters + string termination */
-	int ret;
-
-	ret = dh_get_value_from_eeprom_buffer(DH_ITEM_NUMBER, item_number, sizeof(item_number),
-					      eip);
-	if (ret) {
-		printf("%s: Unable to get DHSOM item number from EEPROM ID page! ret = %d\n",
-		       __func__, ret);
-	} else {
-		item_number_env = env_get("dh_som_item_number");
-		if (!item_number_env)
-			env_set("dh_som_item_number", item_number);
-		else if (strcmp(item_number_env, item_number))
-			printf("Warning: Environment dh_som_item_number differs from EEPROM ID page value (%s != %s)\n",
-			       item_number_env, item_number);
-	}
-
-	ret = dh_get_value_from_eeprom_buffer(DH_SERIAL_NUMBER, serial, sizeof(serial),
-					      eip);
-	if (ret) {
-		printf("%s: Unable to get DHSOM serial number from EEPROM ID page! ret = %d\n",
-		       __func__, ret);
-	} else {
-		serial_env = env_get("dh_som_serial_number");
-		if (!serial_env)
-			env_set("dh_som_serial_number", serial);
-		else if (strcmp(serial_env, serial))
-			printf("Warning: Environment dh_som_serial_number differs from EEPROM ID page value (%s != %s)\n",
-			       serial_env, serial);
-	}
-}
-
 int board_late_init(void)
 {
 	u8 eeprom_buffer[DH_EEPROM_ID_PAGE_MAX_SIZE] = { 0 };
-- 
2.51.0

