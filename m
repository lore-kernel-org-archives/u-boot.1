Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CC1C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 14:51:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03E8E88860;
	Wed, 22 May 2024 16:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="ozfQI6rS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AE3F88488; Wed, 22 May 2024 08:18:47 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D77B87F4B
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 08:18:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1716358725; x=1718950725;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cGWuQpxSiOY9088iRp8e2GFNOh6i8HZ+fna9pv+Opts=;
 b=ozfQI6rSaqzTlDZ8zYUwMLwGMYL2QNomOozKwXPTST7rw3vxFE7c6k/NMkHIfMJz
 ED2D/3TbtgQ1byyos0JVbmH3wCjIOxWzykeEbEyWtciVlPWyaTk2VGCrUwZrMed5
 aQFK9McPUBaZyT3Oa0NCSKUeEx6/znTV6uloy/fbdDQ=;
X-AuditID: ac14000a-03251700000021bc-5f-664d8e45b5de
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 10.10.08636.54E8D466;
 Wed, 22 May 2024 08:18:45 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 22 May
 2024 08:18:44 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 2/6] board: phytec: common: Define PHYTEC_API2_DATA_LEN
Date: Tue, 21 May 2024 23:18:23 -0700
Message-ID: <20240522061827.601699-3-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240522061827.601699-1-d.schultz@phytec.de>
References: <20240522061827.601699-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsWyRpKBR9e1zzfNYMVhZYu3ezvZLbrfqTsw
 eZy9s4PRo7+7hTWAKYrLJiU1J7MstUjfLoEr4+eNlcwFhwUrDrW/ZG9gXMXXxcjJISFgIvHw
 6g1GEFtIYAmTROvkxC5GLiD7PqPEiwPNYAk2AS2JO1vmMoPYIgJmEovWnmfrYuTgYBbQkGh/
 xgQSFhZwlzi5+S4riM0ioCpxYNo+dhCbV8BSYnn3KnaIXfISMy99B7M5Bawkbs9eD7XXUuLr
 639Q9YISJ2c+YQGxmYHqm7fOZoawJSQOvnjBDFGvIDF722RGmJnTzr1mhrBDJbZ+2c40gVFo
 FpJRs5CMmoVk1AJG5lWMQrmZydmpRZnZegUZlSWpyXopqZsYQcErwsC1g7FvjschRiYOxkOM
 EhzMSiK8m7Z4pgnxpiRWVqUW5ccXleakFh9ilOZgURLnXd0RnCokkJ5YkpqdmlqQWgSTZeLg
 lGpgZPzY5vjxQ86LYvU96ivmbXXv5Kniq9pVaL08YPr7K9tf6osfq5OQfnYtaK2jvETY+a6n
 38+JNj/f+GnB4s8tEzbzfpNpfcW1Vk35aZisSe5kt/aJFRsetB6bHP38zOF7x2VDQ4rma1Qs
 yX3H3Kyfz3l1xbxbFySS3jnFlnhbxx+yO6x26iG/pxJLcUaioRZzUXEiAIzo/tFMAgAA
X-Mailman-Approved-At: Wed, 22 May 2024 16:50:43 +0200
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

The EEPROM image length for API v2 is fixed to 32 bytes. No need
to use sizeof while this value won't change. This value is
also be required for API v3 to know where the API v3 header starts.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 board/phytec/common/phytec_som_detection.c | 9 ++++-----
 board/phytec/common/phytec_som_detection.h | 2 ++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/board/phytec/common/phytec_som_detection.c b/board/phytec/common/phytec_som_detection.c
index a089fe9bc90..f0e35d8d2ec 100644
--- a/board/phytec/common/phytec_som_detection.c
+++ b/board/phytec/common/phytec_som_detection.c
@@ -78,13 +78,12 @@ int phytec_eeprom_data_init(struct phytec_eeprom_data *data,
 	int ret, i;
 	unsigned int crc;
 	u8 *ptr;
-	const unsigned int payload_size = sizeof(struct phytec_eeprom_payload);
 
 	if (!data)
 		data = &eeprom_data;
 
 	ret = phytec_eeprom_read((u8 *)data, bus_num, addr,
-				 payload_size, 0);
+				 PHYTEC_API2_DATA_LEN, 0);
 	if (ret)
 		goto err;
 
@@ -95,11 +94,11 @@ int phytec_eeprom_data_init(struct phytec_eeprom_data *data,
 	}
 
 	ptr = (u8 *)data;
-	for (i = 0; i < payload_size; ++i)
+	for (i = 0; i < PHYTEC_API2_DATA_LEN; ++i)
 		if (ptr[i] != 0x0)
 			break;
 
-	if (i == payload_size) {
+	if (i == PHYTEC_API2_DATA_LEN) {
 		pr_err("%s: EEPROM data is all zero. Erased?\n", __func__);
 		ret = -EINVAL;
 		goto err;
@@ -111,7 +110,7 @@ int phytec_eeprom_data_init(struct phytec_eeprom_data *data,
 		return 0;
 	}
 
-	crc = crc8(0, (const unsigned char *)&data->payload, payload_size);
+	crc = crc8(0, (const unsigned char *)&data->payload, PHYTEC_API2_DATA_LEN);
 	debug("%s: crc: %x\n", __func__, crc);
 
 	if (crc) {
diff --git a/board/phytec/common/phytec_som_detection.h b/board/phytec/common/phytec_som_detection.h
index 0ad5c14ef4e..1ccf36c8e7a 100644
--- a/board/phytec/common/phytec_som_detection.h
+++ b/board/phytec/common/phytec_som_detection.h
@@ -10,6 +10,8 @@
 #define PHYTEC_MAX_OPTIONS	17
 #define PHYTEC_EEPROM_INVAL	0xff
 
+#define PHYTEC_API2_DATA_LEN	32
+
 #define PHYTEC_GET_OPTION(option) \
 	(((option) > '9') ? (option) - 'A' + 10 : (option) - '0')
 
-- 
2.25.1

