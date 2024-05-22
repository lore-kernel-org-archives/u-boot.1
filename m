Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA725C25B7A
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 14:51:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61A2688866;
	Wed, 22 May 2024 16:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="EUP9Y38k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B522A87F4B; Wed, 22 May 2024 08:18:48 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D821C887C0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 08:18:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1716358726; x=1718950726;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LQLtfF9qqFBbIu3GtEhbP5RstfUjWGZzJawwZ1x0RNI=;
 b=EUP9Y38kjdo7IhMC62y/8C/wjb/i0QifQ+Ch3O48YbtLCWRoVu8luNJqssxisnjO
 kjFS78lShLz7ClTl3XuR+Z7Oz8bXkeEyTcD3TSjwHb8SGq1KOP33i8uH1TDPMuFG
 IGcrtrrb5yI6lIK02BVbHNyaaMBs3ImCDyGYyB7QSv0=;
X-AuditID: ac14000a-03e52700000021bc-64-664d8e46b259
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 91.10.08636.64E8D466;
 Wed, 22 May 2024 08:18:46 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 22 May
 2024 08:18:45 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 3/6] board: phytec: common: Move API v2 init to new function
Date: Tue, 21 May 2024 23:18:24 -0700
Message-ID: <20240522061827.601699-4-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240522061827.601699-1-d.schultz@phytec.de>
References: <20240522061827.601699-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBLMWRmVeSWpSXmKPExsWyRpKBR9etzzfN4N0EY4u3ezvZLbrfqTsw
 eZy9s4PRo7+7hTWAKYrLJiU1J7MstUjfLoEr4+WT72wFE/krZtxsZWtg7ObpYuTkkBAwkZi5
 ehIbiC0ksIRJ4u4DpS5GLiD7PqPE06n3wBJsAloSd7bMZQaxRQTMJBatPQ8U5+BgFtCQaH/G
 BBIWFvCRWN28iBHEZhFQlVjetQ2shFfAUuL+mzCIVfISMy99ZwexOQWsJG7PXs8IsdZS4uvr
 f2BxXgFBiZMzn7CA2MxA9c1bZzND2BISB1+8YIaoV5CYvW0yI8zMaedeM0PYoRJbv2xnmsAo
 NAvJqFlIRs1CMmoBI/MqRqHczOTs1KLMbL2CjMqS1GS9lNRNjKDQFWHg2sHYN8fjECMTB+Mh
 RgkOZiUR3k1bPNOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ867uCE4VEkhPLEnNTk0tSC2CyTJx
 cEo1MLbciJM6F72V9fZlj/brB7TFvj+U0d/1kv/09h173//atSH77voHlTMZq8pzMm65a7Ko
 JkafFOOWfHor6CDHzrAdz4+mrH76gvHDz6n32X03BPlMUuEqCb9R5D/b4xZjYPCcFa/srz0K
 1vNqst3NuEhw+jslVq/gM0m/z12Y/sj7iLcEZ8SdRWFKLMUZiYZazEXFiQASf3D7SwIAAA==
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

Move the entire initialization code for API v2 into a dedicated
function. This rework will allow to easily integrate the API v3
as next step during init.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 board/phytec/common/phytec_som_detection.c | 38 +++++++++++++---------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/board/phytec/common/phytec_som_detection.c b/board/phytec/common/phytec_som_detection.c
index f0e35d8d2ec..ab2d5a7b726 100644
--- a/board/phytec/common/phytec_som_detection.c
+++ b/board/phytec/common/phytec_som_detection.c
@@ -72,11 +72,29 @@ int phytec_eeprom_read(u8 *data, int bus_num, int addr, int size, int offset)
 	return ret;
 }
 
+int phytec_eeprom_data_init_v2(struct phytec_eeprom_data *data)
+{
+	unsigned int crc;
+
+	if (!data)
+		return -1;
+
+	crc = crc8(0, (const unsigned char *)&data->payload, PHYTEC_API2_DATA_LEN);
+	debug("%s: crc: %x\n", __func__, crc);
+
+	if (crc) {
+		pr_err("%s: CRC mismatch. EEPROM data is not usable.\n",
+		       __func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int phytec_eeprom_data_init(struct phytec_eeprom_data *data,
 			    int bus_num, int addr)
 {
 	int ret, i;
-	unsigned int crc;
 	u8 *ptr;
 
 	if (!data)
@@ -104,20 +122,10 @@ int phytec_eeprom_data_init(struct phytec_eeprom_data *data,
 		goto err;
 	}
 
-	/* We are done here for early revisions */
-	if (data->payload.api_rev <= PHYTEC_API_REV1) {
-		data->valid = true;
-		return 0;
-	}
-
-	crc = crc8(0, (const unsigned char *)&data->payload, PHYTEC_API2_DATA_LEN);
-	debug("%s: crc: %x\n", __func__, crc);
-
-	if (crc) {
-		pr_err("%s: CRC mismatch. EEPROM data is not usable.\n",
-		       __func__);
-		ret = -EINVAL;
-		goto err;
+	if (data->payload.api_rev >= PHYTEC_API_REV2) {
+		ret = phytec_eeprom_data_init_v2(data);
+		if (ret)
+			goto err;
 	}
 
 	data->valid = true;
-- 
2.25.1

