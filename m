Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34702C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 08:46:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D54B876F7;
	Wed, 20 Dec 2023 09:45:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="nIhL7/9Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4EF88765E; Wed, 20 Dec 2023 09:45:44 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4BD187646
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 09:45:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1703061940; x=1705653940;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hDjXdLDawBv0Xx+Is4OLF6TGbYFFM+t4sf98Z61kYV4=;
 b=nIhL7/9YmK5920jwoeZEyiz3fVB8D8hF5l3dvKvCW58Xb2qZS6mwhcl4q3useb7g
 opMs+CgyIz8eLRNgm7LenXO1mRDsD0WK4rylZlcGwtLGqiQKBSN/BsXgGcodhOTn
 O4IK4ktp69HsE5hxTYtdu++VSSuOuoc8xyi3U7Xp1W8=;
X-AuditID: ac14000a-fadff7000000290d-ea-6582a9b47848
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 27.E0.10509.4B9A2856;
 Wed, 20 Dec 2023 09:45:40 +0100 (CET)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 20 Dec
 2023 09:45:40 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Wed, 20 Dec 2023 09:45:35 +0100
Subject: [PATCH v2 4/5] board: phytec: som_detection: move definitions to
 source file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231220-wip-y-moog-phytec-de-upstream_som_detection_fixes-v2-4-516abadb4f49@phytec.de>
References: <20231220-wip-y-moog-phytec-de-upstream_som_detection_fixes-v2-0-516abadb4f49@phytec.de>
In-Reply-To: <20231220-wip-y-moog-phytec-de-upstream_som_detection_fixes-v2-0-516abadb4f49@phytec.de>
To: Fabio Estevam <festevam@gmail.com>
CC: Teresa Remmet <t.remmet@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.12.3
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsWyRpKBR3fLyqZUg2kHVSweXvW3eLu3k92i
 +526A7PHzll32T3O3tnB6NHf3cIawBzFZZOSmpNZllqkb5fAlTH13BOWgmnGFTf67BsYT2l3
 MXJySAiYSFyesIW5i5GLQ0hgMZPEmSe9UM5DRokrK7uZQarYBFQkHr+4xwpiswioSjQfvcAO
 YgsLhEtMWTWVCcTmFRCUODnzCUsXIwcHs4CmxPpd+iBhZgF5ie1v5zBDlKRIdC/aDWYLAdln
 +u4xgticAqkSS96dZgdpFRFQkzg9D6q1RmLq/XnsEHcKS7QvusUE0Sor8eJ8L1RcXmLaudfM
 EHaoxJFNq5kmMArNQnLQLISDZiE5aAEj8ypGodzM5OzUosxsvYKMypLUZL2U1E2MoFAWYeDa
 wdg3x+MQIxMH4yFGCQ5mJRHevZ1NqUK8KYmVValF+fFFpTmpxYcYpTlYlMR5V3cEpwoJpCeW
 pGanphakFsFkmTg4pRoY45SqDp2duVV/z3026fNp3T9P3ugova3946Kyd8RpS+e1Ow4/MJ5u
 oGGw948eT+6LyTnO19UZ3ZZH/6ioebp+9+LVv75/Vyo+uiFQ30OH3d7A6+i09y1sv3ftZig+
 YmCqWSRbfZb3vuWP544ZtUp3J7B5ff/qYtu+Y++hzJ7uic2HP24+Ef5DVImlOCPRUIu5qDgR
 ABmXq8pTAgAA
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

Move all function definitions in {phytec|imx8m}_som_detection from the
header to the source file to prevent potential linker error regarding
multiple definitions. Also move the #if blocks with the definitions.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 board/phytec/common/imx8m_som_detection.c  | 32 ++++++++++++++++++++++++
 board/phytec/common/imx8m_som_detection.h  | 32 ------------------------
 board/phytec/common/phytec_som_detection.c | 39 ++++++++++++++++++++++++++++++
 board/phytec/common/phytec_som_detection.h | 38 -----------------------------
 4 files changed, 71 insertions(+), 70 deletions(-)

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
index 724b8e844b6..f879702df45 100644
--- a/board/phytec/common/phytec_som_detection.c
+++ b/board/phytec/common/phytec_som_detection.c
@@ -16,6 +16,8 @@
 
 struct phytec_eeprom_data eeprom_data;
 
+#if IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION)
+
 int phytec_eeprom_data_setup_fallback(struct phytec_eeprom_data *data,
 				      int bus_num, int addr, int addr_fallback)
 {
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

