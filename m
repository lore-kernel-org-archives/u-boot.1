Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C0EC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 16:22:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48D3588790;
	Fri, 19 Apr 2024 18:22:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="hFB8yJBf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 540A388775; Fri, 19 Apr 2024 17:55:57 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4956988758
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 17:55:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1713542155; x=1716134155;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S59DewJB5o1tldzmjn7vLyEyUApGCDCRrTqr9n1yJZw=;
 b=hFB8yJBfoaBdFQS2GKSBaqBD4+x0cWRuMDRCYrAwm/z/EXCiO0W0dbsqHQnfOHey
 M3nCf1RjKSJ2qXB9aR86sDm5NgpgM6WL6O9a5Ok/M0lNkf8ndHMdg+B4W0EJV6fD
 RhiNfEBEhlw0yt2V0ecHO9ljVMHKqXcudGw2e4jbMDM=;
X-AuditID: ac14000a-fadff7000000290d-6f-6622940b5593
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 2C.38.10509.B0492266;
 Fri, 19 Apr 2024 17:55:55 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 19 Apr
 2024 17:55:54 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>
CC: Yannic Moog <y.moog@phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 2/5] board: phytec: introduce eeprom struct member 'valid'
Date: Fri, 19 Apr 2024 08:55:37 -0700
Message-ID: <20240419155540.2447006-3-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240419155540.2447006-1-d.schultz@phytec.de>
References: <20240419155540.2447006-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWyRpKBR5d7ilKawdtLfBZv93ayOzB6nL2z
 gzGAMYrLJiU1J7MstUjfLoEr48Bc5YIt1hVzt69hbWDcY9DFyMkhIWAi0bbxLEsXIxeHkMAS
 JonDT5YzQTj3GSUmPp3FBFLFJqAlcWfLXGYQW0RASuJl50Ywm1nAQ2LqmT6wGmEBL4kdU96z
 gtgsAqoSTTOXs3UxcnDwClhJfJ1cC7FMXmLmpe/sIDangLXE9+1fwMYIAZWcX3yeDcTmFRCU
 ODnzCQvEeHmJ5q2zoVZJSBx88QKqXkFi9rbJjDAzp517zQxhh0oc2bSaaQKj0Cwko2YhGTUL
 yagFjMyrGIVyM5OzU4sys/UKMipLUpP1UlI3MYJCVYSBawdj3xyPQ4xMHIyHGCU4mJVEeM04
 FNOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ867uCE4VEkhPLEnNTk0tSC2CyTJxcEo1MK64IPL0
 id3FnF2hNv/9LgZfEI7fxZJ+2ifCWfnFp4NOoUWPa8wTZb0s3hrvmpYn+rPeLY5ZSnPqKY/7
 hwJjtCTWc60QvD7jtZkd/xeh3vMZHlPUrdUjg+17+zXWJE50eDet+cDEG1nLL0xpcznbEx1p
 mTzv9yxVgcOKDUsigsxeTvyZ5TdnqhJLcUaioRZzUXEiAN58fONDAgAA
X-Mailman-Approved-At: Fri, 19 Apr 2024 18:22:18 +0200
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

From: Yannic Moog <y.moog@phytec.de>

Add a new nember to the eeprom_data that indicates whether the
associated data is valid or not. Make use of this new member in the
phytec_eeprom_data_init function by setting the valid value
appropriately.
Move the eeprom data to a new struct payload that holds
the payload of the eeprom.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 board/phytec/common/imx8m_som_detection.c  | 10 ++--
 board/phytec/common/phytec_som_detection.c | 56 ++++++++++++----------
 board/phytec/common/phytec_som_detection.h | 11 +++--
 3 files changed, 45 insertions(+), 32 deletions(-)

diff --git a/board/phytec/common/imx8m_som_detection.c b/board/phytec/common/imx8m_som_detection.c
index 214b75db3b0..7571076a09e 100644
--- a/board/phytec/common/imx8m_som_detection.c
+++ b/board/phytec/common/imx8m_som_detection.c
@@ -34,10 +34,10 @@ int __maybe_unused phytec_imx8m_detect(struct phytec_eeprom_data *data)
 		data = &eeprom_data;
 
 	/* We can not do the check for early API revisions */
-	if (data->api_rev < PHYTEC_API_REV2)
+	if (data->payload.api_rev < PHYTEC_API_REV2)
 		return -1;
 
-	som = data->data.data_api2.som_no;
+	som = data->payload.data.data_api2.som_no;
 	debug("%s: som id: %u\n", __func__, som);
 
 	opt = phytec_get_opt(data);
@@ -99,7 +99,7 @@ u8 __maybe_unused phytec_get_imx8m_spi(struct phytec_eeprom_data *data)
 	if (!data)
 		data = &eeprom_data;
 
-	if (data->api_rev < PHYTEC_API_REV2)
+	if (data->payload.api_rev < PHYTEC_API_REV2)
 		return PHYTEC_EEPROM_INVAL;
 
 	opt = phytec_get_opt(data);
@@ -126,7 +126,7 @@ u8 __maybe_unused phytec_get_imx8m_eth(struct phytec_eeprom_data *data)
 	if (!data)
 		data = &eeprom_data;
 
-	if (data->api_rev < PHYTEC_API_REV2)
+	if (data->payload.api_rev < PHYTEC_API_REV2)
 		return PHYTEC_EEPROM_INVAL;
 
 	opt = phytec_get_opt(data);
@@ -154,7 +154,7 @@ u8 __maybe_unused phytec_get_imx8mp_rtc(struct phytec_eeprom_data *data)
 	if (!data)
 		data = &eeprom_data;
 
-	if (data->api_rev < PHYTEC_API_REV2)
+	if (data->payload.api_rev < PHYTEC_API_REV2)
 		return PHYTEC_EEPROM_INVAL;
 
 	opt = phytec_get_opt(data);
diff --git a/board/phytec/common/phytec_som_detection.c b/board/phytec/common/phytec_som_detection.c
index d167a77c25b..7913764be0a 100644
--- a/board/phytec/common/phytec_som_detection.c
+++ b/board/phytec/common/phytec_som_detection.c
@@ -54,6 +54,7 @@ int phytec_eeprom_data_init(struct phytec_eeprom_data *data,
 	int ret, i;
 	unsigned int crc;
 	int *ptr;
+	const unsigned int payload_size = sizeof(struct phytec_eeprom_payload);
 
 	if (!data)
 		data = &eeprom_data;
@@ -64,14 +65,13 @@ int phytec_eeprom_data_init(struct phytec_eeprom_data *data,
 	ret = i2c_get_chip_for_busnum(bus_num, addr, 2, &dev);
 	if (ret) {
 		pr_err("%s: i2c EEPROM not found: %i.\n", __func__, ret);
-		return ret;
+		goto err;
 	}
 
-	ret = dm_i2c_read(dev, 0, (uint8_t *)data,
-			  sizeof(struct phytec_eeprom_data));
+	ret = dm_i2c_read(dev, 0, (uint8_t *)data, payload_size);
 	if (ret) {
-		pr_err("%s: Unable to read EEPROM data\n", __func__);
-		return ret;
+		pr_err("%s: Unable to read EEPROM data: %i\n", __func__, ret);
+		goto err;
 	}
 #else
 	i2c_set_bus_num(bus_num);
@@ -79,36 +79,44 @@ int phytec_eeprom_data_init(struct phytec_eeprom_data *data,
 		       sizeof(struct phytec_eeprom_data));
 #endif
 
-	if (data->api_rev == 0xff) {
+	if (data->payload.api_rev == 0xff) {
 		pr_err("%s: EEPROM is not flashed. Prototype?\n", __func__);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err;
 	}
 
 	ptr = (int *)data;
-	for (i = 0; i < sizeof(struct phytec_eeprom_data); i++)
+	for (i = 0; i < payload_size; ++i)
 		if (ptr[i] != 0x0)
 			break;
 
-	if (i == sizeof(struct phytec_eeprom_data)) {
+	if (i == payload_size) {
 		pr_err("%s: EEPROM data is all zero. Erased?\n", __func__);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err;
 	}
 
 	/* We are done here for early revisions */
-	if (data->api_rev <= PHYTEC_API_REV1)
+	if (data->payload.api_rev <= PHYTEC_API_REV1) {
+		data->valid = true;
 		return 0;
+	}
 
-	crc = crc8(0, (const unsigned char *)data,
-		   sizeof(struct phytec_eeprom_data));
+	crc = crc8(0, (const unsigned char *)&data->payload, payload_size);
 	debug("%s: crc: %x\n", __func__, crc);
 
 	if (crc) {
-		pr_err("%s: CRC mismatch. EEPROM data is not usable\n",
+		pr_err("%s: CRC mismatch. EEPROM data is not usable.\n",
 		       __func__);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err;
 	}
 
+	data->valid = true;
 	return 0;
+err:
+	data->valid = false;
+	return ret;
 }
 
 void __maybe_unused phytec_print_som_info(struct phytec_eeprom_data *data)
@@ -120,10 +128,10 @@ void __maybe_unused phytec_print_som_info(struct phytec_eeprom_data *data)
 	if (!data)
 		data = &eeprom_data;
 
-	if (data->api_rev < PHYTEC_API_REV2)
+	if (data->payload.api_rev < PHYTEC_API_REV2)
 		return;
 
-	api2 = &data->data.data_api2;
+	api2 = &data->payload.data.data_api2;
 
 	/* Calculate PCB subrevision */
 	pcb_sub_rev = api2->pcb_sub_opt_rev & 0x0f;
@@ -182,10 +190,10 @@ char * __maybe_unused phytec_get_opt(struct phytec_eeprom_data *data)
 	if (!data)
 		data = &eeprom_data;
 
-	if (data->api_rev < PHYTEC_API_REV2)
-		opt = data->data.data_api0.opt;
+	if (data->payload.api_rev < PHYTEC_API_REV2)
+		opt = data->payload.data.data_api0.opt;
 	else
-		opt = data->data.data_api2.opt;
+		opt = data->payload.data.data_api2.opt;
 
 	return opt;
 }
@@ -197,10 +205,10 @@ u8 __maybe_unused phytec_get_rev(struct phytec_eeprom_data *data)
 	if (!data)
 		data = &eeprom_data;
 
-	if (data->api_rev < PHYTEC_API_REV2)
+	if (data->payload.api_rev < PHYTEC_API_REV2)
 		return PHYTEC_EEPROM_INVAL;
 
-	api2 = &data->data.data_api2;
+	api2 = &data->payload.data.data_api2;
 
 	return api2->pcb_rev;
 }
@@ -209,10 +217,10 @@ u8 __maybe_unused phytec_get_som_type(struct phytec_eeprom_data *data)
 {
 	if (!data)
 		data = &eeprom_data;
-	if (data->api_rev < PHYTEC_API_REV2)
+	if (data->payload.api_rev < PHYTEC_API_REV2)
 		return PHYTEC_EEPROM_INVAL;
 
-	return data->data.data_api2.som_type;
+	return data->payload.data.data_api2.som_type;
 }
 
 #if IS_ENABLED(CONFIG_CMD_EXTENSION)
diff --git a/board/phytec/common/phytec_som_detection.h b/board/phytec/common/phytec_som_detection.h
index ea99a687fee..0ad5c14ef4e 100644
--- a/board/phytec/common/phytec_som_detection.h
+++ b/board/phytec/common/phytec_som_detection.h
@@ -55,7 +55,7 @@ struct phytec_api2_data {
 	u8 crc8;		/* checksum */
 } __packed;
 
-struct phytec_eeprom_data {
+struct phytec_eeprom_payload {
 	u8 api_rev;
 	union {
 		struct phytec_api0_data data_api0;
@@ -63,13 +63,18 @@ struct phytec_eeprom_data {
 	} data;
 } __packed;
 
+struct phytec_eeprom_data {
+	struct phytec_eeprom_payload payload;
+	bool valid;
+};
+
 int phytec_eeprom_data_setup_fallback(struct phytec_eeprom_data *data,
 				      int bus_num, int addr,
 				      int addr_fallback);
 int phytec_eeprom_data_setup(struct phytec_eeprom_data *data,
 			     int bus_num, int addr);
-int phytec_eeprom_data_init(struct phytec_eeprom_data *data,
-			    int bus_num, int addr);
+int phytec_eeprom_data_init(struct phytec_eeprom_data *data, int bus_num,
+			    int addr);
 void __maybe_unused phytec_print_som_info(struct phytec_eeprom_data *data);
 
 char * __maybe_unused phytec_get_opt(struct phytec_eeprom_data *data);
-- 
2.25.1

