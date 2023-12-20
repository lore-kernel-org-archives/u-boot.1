Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF48C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 08:20:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC01D876B1;
	Wed, 20 Dec 2023 09:20:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="sJQDHF9F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 536D6875E9; Wed, 20 Dec 2023 09:20:06 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0AA2875F0
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 09:20:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1703060402; x=1705652402;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fv0AsGrLFo8tmr2EHtKVVrdGjPjH0CZ6SWqS/DYrHN8=;
 b=sJQDHF9FQEJoT7CEzjui0kRBgv7cuMR7z8tOiGCMfiPgqNOhX76OgnFkRGKPY8gM
 AcNKQ7gOWBuYw4ZGhQ0uktLxdVWKV7ms9fyP+6qEuLZS1Rz4ftLBSoezU8+tKbdR
 ijX8J5+Ja6tXkc0g9mnMGVBjNIlArYZ2psv9h59f1Yw=;
X-AuditID: ac14000a-fbefe7000000290d-4b-6582a3b28fb1
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 3F.A0.10509.2B3A2856;
 Wed, 20 Dec 2023 09:20:02 +0100 (CET)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 20 Dec
 2023 09:20:02 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Wed, 20 Dec 2023 09:19:35 +0100
Subject: [PATCH 3/4] board: phytec: phytec_som_detection: fix eeprom_data
 zero check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231220-wip-y-moog-phytec-de-upstream_som_detection_fixes-v1-3-c24f3239b4c3@phytec.de>
References: <20231220-wip-y-moog-phytec-de-upstream_som_detection_fixes-v1-0-c24f3239b4c3@phytec.de>
In-Reply-To: <20231220-wip-y-moog-phytec-de-upstream_som_detection_fixes-v1-0-c24f3239b4c3@phytec.de>
To: Fabio Estevam <festevam@gmail.com>
CC: Teresa Remmet <t.remmet@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.12.3
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsWyRpKBR3fT4qZUg+5JmhYPr/pbvN3byW7R
 /U7dgdlj56y77B5n7+xg9OjvbmENYI7isklJzcksSy3St0vgyui4MYGp4JtZxeWbL1gaGPfo
 dTFyckgImEjsnPSPtYuRi0NIYDGTxJ7P01kgnIeMEh/PfWcDqWITUJF4/OIeK4jNIqAq8fr6
 KjBbWCBMYs/y04wgNq+AoMTJmU+Amjk4mAU0Jdbv0gcJMwvIS2x/O4cZoiRF4uGxJewgthCQ
 /e/YJLA4p0CqxLnVq9hBWkUE1CROz4NqrZGYen8eO8SdwhLti24xQbTKSrw43wsVl5eYdu41
 M4QdKrH1y3amCYxCs5AcNAvhoFlIDlrAyLyKUSg3Mzk7tSgzW68go7IkNVkvJXUTIyiYRRi4
 djD2zfE4xMjEwXiIUYKDWUmEd29nU6oQb0piZVVqUX58UWlOavEhRmkOFiVx3tUdwalCAumJ
 JanZqakFqUUwWSYOTqkGRjePfR4bV5UIarM/mnjZr+lz6u+GJy4Zq1nL+SIZtvMuf2qyedO8
 vRJbvoXnas7RXS56ZDW7Z/8pJj5rKb0lrSkXTooXB8scPmRmeu6IYoagsUTsy66jlu4vVjcl
 qc+dGC0VbKT7YPXBTA+R0CvvUgrj9QsOTJy/hNNtX+TKyknN52fcWti+T4mlOCPRUIu5qDgR
 AJ32EpJUAgAA
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

In phytec_eeprom_data_init, after reading eeprom data into buffer, it is
checked whether all bytes are 0x0 by iterating over chunks of the
buffer. The offset, or index of the chunk, was never changed, leading to
repeated comparison of only the first chunk. Use array notation and
access chunk via array index to compare all chunks of the buffer.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 board/phytec/common/imx8m_som_detection.c  | 32 ++++++++++++++++++++++
 board/phytec/common/imx8m_som_detection.h  | 32 ----------------------
 board/phytec/common/phytec_som_detection.c | 43 ++++++++++++++++++++++++++++--
 board/phytec/common/phytec_som_detection.h | 38 --------------------------
 4 files changed, 73 insertions(+), 72 deletions(-)

diff --git a/board/phytec/common/imx8m_som_detection.c b/board/phytec/common/imx8m_som_detection.c
index a229eae152d..214b75db3b0 100644
--- a/board/phytec/common/imx8m_som_detection.c
+++ b/board/phytec/common/imx8m_som_detection.c
@@ -15,6 +15,8 @@
 
 extern struct phytec_eeprom_data eeprom_data;
 
+#if IS_ENABLED(CONFIG_PHYTEC_IMX8M_SOM_DETECTION)
+
 /* Check if the SoM is actually one of the following products:
  * - i.MX8MM
  * - i.MX8MN
@@ -166,3 +168,33 @@ u8 __maybe_unused phytec_get_imx8mp_rtc(struct phytec_eeprom_data *data)
 	debug("%s: rtc: %u\n", __func__, rtc);
 	return rtc;
 }
+
+#else
+
+inline int __maybe_unused phytec_imx8m_detect(struct phytec_eeprom_data *data)
+{
+	return -1;
+}
+
+inline u8 __maybe_unused
+phytec_get_imx8m_ddr_size(struct phytec_eeprom_data *data)
+{
+	return PHYTEC_EEPROM_INVAL;
+}
+
+inline u8 __maybe_unused phytec_get_imx8mp_rtc(struct phytec_eeprom_data *data)
+{
+	return PHYTEC_EEPROM_INVAL;
+}
+
+inline u8 __maybe_unused phytec_get_imx8m_spi(struct phytec_eeprom_data *data)
+{
+	return PHYTEC_EEPROM_INVAL;
+}
+
+inline u8 __maybe_unused phytec_get_imx8m_eth(struct phytec_eeprom_data *data)
+{
+	return PHYTEC_EEPROM_INVAL;
+}
+
+#endif /* IS_ENABLED(CONFIG_PHYTEC_IMX8M_SOM_DETECTION) */
diff --git a/board/phytec/common/imx8m_som_detection.h b/board/phytec/common/imx8m_som_detection.h
index 442085cfe97..0176347414f 100644
--- a/board/phytec/common/imx8m_som_detection.h
+++ b/board/phytec/common/imx8m_som_detection.h
@@ -13,42 +13,10 @@
 #define PHYTEC_IMX8MM_SOM       69
 #define PHYTEC_IMX8MP_SOM       70
 
-#if IS_ENABLED(CONFIG_PHYTEC_IMX8M_SOM_DETECTION)
-
 int __maybe_unused phytec_imx8m_detect(struct phytec_eeprom_data *data);
 u8 __maybe_unused phytec_get_imx8m_ddr_size(struct phytec_eeprom_data *data);
 u8 __maybe_unused phytec_get_imx8mp_rtc(struct phytec_eeprom_data *data);
 u8 __maybe_unused phytec_get_imx8m_spi(struct phytec_eeprom_data *data);
 u8 __maybe_unused phytec_get_imx8m_eth(struct phytec_eeprom_data *data);
 
-#else
-
-inline int __maybe_unused phytec_imx8m_detect(struct phytec_eeprom_data *data)
-{
-	return -1;
-}
-
-inline u8 __maybe_unused
-phytec_get_imx8m_ddr_size(struct phytec_eeprom_data *data)
-{
-	return PHYTEC_EEPROM_INVAL;
-}
-
-inline u8 __maybe_unused phytec_get_imx8mp_rtc(struct phytec_eeprom_data *data)
-{
-	return PHYTEC_EEPROM_INVAL;
-}
-
-inline u8 __maybe_unused phytec_get_imx8m_spi(struct phytec_eeprom_data *data)
-{
-	return PHYTEC_EEPROM_INVAL;
-}
-
-inline u8 __maybe_unused phytec_get_imx8m_eth(struct phytec_eeprom_data *data)
-{
-	return PHYTEC_EEPROM_INVAL;
-}
-
-#endif /* IS_ENABLED(CONFIG_PHYTEC_IMX8M_SOM_DETECTION) */
-
 #endif /* _PHYTEC_IMX8M_SOM_DETECTION_H */
diff --git a/board/phytec/common/phytec_som_detection.c b/board/phytec/common/phytec_som_detection.c
index 55562731270..f879702df45 100644
--- a/board/phytec/common/phytec_som_detection.c
+++ b/board/phytec/common/phytec_som_detection.c
@@ -16,6 +16,8 @@
 
 struct phytec_eeprom_data eeprom_data;
 
+#if IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION)
+
 int phytec_eeprom_data_setup_fallback(struct phytec_eeprom_data *data,
 				      int bus_num, int addr, int addr_fallback)
 {
@@ -83,8 +85,8 @@ int phytec_eeprom_data_init(struct phytec_eeprom_data *data,
 	}
 
 	ptr = (int *)data;
-	for (i = 0; i < sizeof(struct phytec_eeprom_data); i += sizeof(ptr))
-		if (*ptr != 0x0)
+	for (i = 0; i < sizeof(struct phytec_eeprom_data); i++)
+		if (ptr[i] != 0x0)
 			break;
 
 	if (i == sizeof(struct phytec_eeprom_data)) {
@@ -201,3 +203,40 @@ u8 __maybe_unused phytec_get_rev(struct phytec_eeprom_data *data)
 
 	return api2->pcb_rev;
 }
+
+#else
+
+inline int phytec_eeprom_data_setup(struct phytec_eeprom_data *data,
+				    int bus_num, int addr)
+{
+	return PHYTEC_EEPROM_INVAL;
+}
+
+inline int phytec_eeprom_data_setup_fallback(struct phytec_eeprom_data *data,
+					     int bus_num, int addr,
+					     int addr_fallback)
+{
+	return PHYTEC_EEPROM_INVAL;
+}
+
+inline int phytec_eeprom_data_init(struct phytec_eeprom_data *data,
+				   int bus_num, int addr)
+{
+	return PHYTEC_EEPROM_INVAL;
+}
+
+inline void __maybe_unused phytec_print_som_info(struct phytec_eeprom_data *data)
+{
+}
+
+inline char *__maybe_unused phytec_get_opt(struct phytec_eeprom_data *data)
+{
+	return NULL;
+}
+
+u8 __maybe_unused phytec_get_rev(struct phytec_eeprom_data *data)
+{
+	return PHYTEC_EEPROM_INVAL;
+}
+
+#endif /* IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION) */
diff --git a/board/phytec/common/phytec_som_detection.h b/board/phytec/common/phytec_som_detection.h
index c68e2302cc4..11009240875 100644
--- a/board/phytec/common/phytec_som_detection.h
+++ b/board/phytec/common/phytec_som_detection.h
@@ -56,8 +56,6 @@ struct phytec_eeprom_data {
 	} data;
 } __packed;
 
-#if IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION)
-
 int phytec_eeprom_data_setup_fallback(struct phytec_eeprom_data *data,
 				      int bus_num, int addr,
 				      int addr_fallback);
@@ -70,40 +68,4 @@ void __maybe_unused phytec_print_som_info(struct phytec_eeprom_data *data);
 char * __maybe_unused phytec_get_opt(struct phytec_eeprom_data *data);
 u8 __maybe_unused phytec_get_rev(struct phytec_eeprom_data *data);
 
-#else
-
-inline int phytec_eeprom_data_setup(struct phytec_eeprom_data *data,
-				    int bus_num, int addr)
-{
-	return PHYTEC_EEPROM_INVAL;
-}
-
-inline int phytec_eeprom_data_setup_fallback(struct phytec_eeprom_data *data,
-					     int bus_num, int addr,
-					     int addr_fallback)
-{
-	return PHYTEC_EEPROM_INVAL;
-}
-
-inline int phytec_eeprom_data_init(struct phytec_eeprom_data *data,
-				   int bus_num, int addr)
-{
-	return PHYTEC_EEPROM_INVAL;
-}
-
-inline void __maybe_unused phytec_print_som_info(struct phytec_eeprom_data *data)
-{
-}
-
-inline char *__maybe_unused phytec_get_opt(struct phytec_eeprom_data *data)
-{
-	return NULL;
-}
-
-u8 __maybe_unused phytec_get_rev(struct phytec_eeprom_data *data)
-{
-	return PHYTEC_EEPROM_INVAL;
-}
-#endif /* IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION) */
-
 #endif /* _PHYTEC_SOM_DETECTION_H */

-- 
2.34.1

