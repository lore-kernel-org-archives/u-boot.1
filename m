Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2D5C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 07:56:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8054588820;
	Wed, 22 May 2024 09:55:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="kW0i0MVR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 765A98812B; Wed, 22 May 2024 09:55:18 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A7568825A
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 09:55:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1716364514; x=1718956514;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4heMkgwFfwetDCtQk7BAq+NFuEZ9SyrpZTPEPetyoLM=;
 b=kW0i0MVRvW9JqAJGQ/ifok/8DKYlolZKlBzfGjq0toI0rKjOWNjdVcpQw0OVF6iA
 6h+A3eVH7WWu6J7tsdFYvjWoXjxbcWscub8PD7nqcTaQ+QbEzYbOWx6jdW9ycFbS
 vrOB+cDyVcv67Q+974mGGyVpa6mlq9ozRCZr3eJ6zJc=;
X-AuditID: ac14000a-03e52700000021bc-af-664da4e2f8c5
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id F5.F0.08636.2E4AD466;
 Wed, 22 May 2024 09:55:14 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 22 May
 2024 09:55:13 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <nm@ti.com>, <trini@konsulko.com>, <clamor95@gmail.com>,
 <d.schultz@phytec.de>, <bb@ti.com>, <jma@phytec.com>,
 <mkorpershoek@baylibre.com>, <d-gole@ti.com>, <m-chawdhry@ti.com>,
 <n-jain1@ti.com>, <afd@ti.com>, <joao.goncalves@toradex.com>,
 <michael@amarulasolutions.com>, <festevam@gmail.com>, <sjg@chromium.org>
Subject: [PATCH v2 2/5] board: phytec: Fix function definitions in AM6x SOM
 detection
Date: Wed, 22 May 2024 09:55:02 +0200
Message-ID: <20240522075505.3339347-3-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240522075505.3339347-1-w.egorov@phytec.de>
References: <20240522075505.3339347-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsWyRpKBR/fREt80g2szWS3en5rIbjH3zQFW
 iwP9vYwWLWs9LB5e9bd41tnEbHH5/k1Wi0sPUi1ONbayWLw4Npfdov//cyaLNz/OMll827KN
 0WLqpM3sFm/3drJbdL9TdxDwWPvxPqvH+xut7B6zGy6yeOycdZfd49WBVeweZ+/sYPTo725h
 9fhz8R2rx/Eb25k8Nr3yCOCK4rJJSc3JLEst0rdL4Mo4e3wiY8E2yYq/N5axNzCeFO1i5OSQ
 EDCRuHGni7WLkYtDSGAJk0TnpQ3MEM5jRonnN06zgVSxCahL3NnwjRXEFhEwk1i09jwbSBGz
 wBEmicen9jGCJIQFQiUaNmwCK2IRUJVofLOFHcTmFbCUmLftCAvEOnmJmZe+g8U5BawkZmxZ
 AxYXAqo5fXkCM0S9oMTJmU/A4sxA9c1bZzND2BISB1+8YIaol5d4cWk53Mxp514zQ9ihElu/
 bGeawCg0C8moWUhGzUIyagEj8ypGodzM5OzUosxsvYKMypLUZL2U1E2MoLgUYeDawdg3x+MQ
 IxMH4yFGCQ5mJRHeTVs804R4UxIrq1KL8uOLSnNSiw8xSnOwKInzru4IThUSSE8sSc1OTS1I
 LYLJMnFwSjUwRlWUFFtmv/s7Ie2zijn32W6v8HcHjJ6rLRNUPua2x3wxh+zbbRlPfy03Xhm3
 LeYlfwirbrOp4Bzhjootvrs1S3pMdFgvzdBY1f9a5nKu6uXAv8/0jCP2Zp3Jl7ntarN5M3u6
 wDuHmoDYqrbmWXJsHPX6X4t0V3xf/3i2KM+H/d1yK9buLtRVYinOSDTUYi4qTgQAgjDx8LkC
 AAA=
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

Functions are declared as phytec_am6* and not phytec_am62*.
Update the definitions to match the declarations.

Fixes: 9d152c23279c ("board: phytec: Add SOM detection for AM6x")

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
Tested-by: John Ma <jma@phytec.com>
---
 board/phytec/common/am6_som_detection.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/board/phytec/common/am6_som_detection.c b/board/phytec/common/am6_som_detection.c
index 2e9884dab44..7930ab42d1c 100644
--- a/board/phytec/common/am6_som_detection.c
+++ b/board/phytec/common/am6_som_detection.c
@@ -73,7 +73,7 @@ static u8 phytec_check_opt(struct phytec_eeprom_data *data, u8 option)
  *  - The size
  *  - PHYTEC_EEPROM_INVAL when the data is invalid.
  */
-u8 __maybe_unused phytec_get_am62_ddr_size(struct phytec_eeprom_data *data)
+u8 __maybe_unused phytec_get_am6_ddr_size(struct phytec_eeprom_data *data)
 {
 	u8 ddr_id = phytec_check_opt(data, 3);
 
@@ -89,7 +89,7 @@ u8 __maybe_unused phytec_get_am62_ddr_size(struct phytec_eeprom_data *data)
  *  - Otherwise a board depended code for the size.
  *  - PHYTEC_EEPROM_INVAL when the data is invalid.
  */
-u8 __maybe_unused phytec_get_am62_spi(struct phytec_eeprom_data *data)
+u8 __maybe_unused phytec_get_am6_spi(struct phytec_eeprom_data *data)
 {
 	u8 spi = phytec_check_opt(data, 5);
 
@@ -105,7 +105,7 @@ u8 __maybe_unused phytec_get_am62_spi(struct phytec_eeprom_data *data)
  *  - 0x1 if 10/100/1000 MBit Phy is populated.
  *  - PHYTEC_EEPROM_INVAL when the data is invalid.
  */
-u8 __maybe_unused phytec_get_am62_eth(struct phytec_eeprom_data *data)
+u8 __maybe_unused phytec_get_am6_eth(struct phytec_eeprom_data *data)
 {
 	u8 eth = phytec_check_opt(data, 6);
 
@@ -121,7 +121,7 @@ u8 __maybe_unused phytec_get_am62_eth(struct phytec_eeprom_data *data)
  *  - 1 if it is populated.
  *  - PHYTEC_EEPROM_INVAL when the data is invalid.
  */
-u8 __maybe_unused phytec_get_am62_rtc(struct phytec_eeprom_data *data)
+u8 __maybe_unused phytec_get_am6_rtc(struct phytec_eeprom_data *data)
 {
 	u8 rtc = phytec_check_opt(data, 7);
 
@@ -131,28 +131,28 @@ u8 __maybe_unused phytec_get_am62_rtc(struct phytec_eeprom_data *data)
 
 #else
 
-inline int __maybe_unused phytec_am62_detect(struct phytec_eeprom_data *data)
+inline int __maybe_unused phytec_am6_detect(struct phytec_eeprom_data *data)
 {
 	return -1;
 }
 
 inline u8 __maybe_unused
-phytec_get_am62_ddr_size(struct phytec_eeprom_data *data)
+phytec_get_am6_ddr_size(struct phytec_eeprom_data *data)
 {
 	return PHYTEC_EEPROM_INVAL;
 }
 
-inline u8 __maybe_unused phytec_get_am62_spi(struct phytec_eeprom_data *data)
+inline u8 __maybe_unused phytec_get_am6_spi(struct phytec_eeprom_data *data)
 {
 	return PHYTEC_EEPROM_INVAL;
 }
 
-inline u8 __maybe_unused phytec_get_am62_eth(struct phytec_eeprom_data *data)
+inline u8 __maybe_unused phytec_get_am6_eth(struct phytec_eeprom_data *data)
 {
 	return PHYTEC_EEPROM_INVAL;
 }
 
-inline u8 __maybe_unused phytec_get_am62_rtc(struct phytec_eeprom_data *data)
+inline u8 __maybe_unused phytec_get_am6_rtc(struct phytec_eeprom_data *data)
 {
 	return PHYTEC_EEPROM_INVAL;
 }
-- 
2.34.1

