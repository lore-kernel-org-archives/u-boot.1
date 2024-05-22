Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B2EC25B7A
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 14:51:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CCDD88858;
	Wed, 22 May 2024 16:50:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="pe1o7D8d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C88A887D9; Wed, 22 May 2024 08:18:46 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DE1288488
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 08:18:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1716358724; x=1718950724;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L00Wl2tUij1ZYslBNNDwznEnRdpzkczpwu8n8l2sttE=;
 b=pe1o7D8dN4WeLguT99ycGPqONSzSG2qtmpw8x0BZQNoe5JUQJwJgggdOyQjEn1on
 LwvIGPlhPG0idEtAb9TdZMvldFgUGCUCPFC0MtKvtpSXCCRnAyX/EcdeMgIswKzC
 lOp2ScVCJcJzKszrNOHd6MZJbbu4TiX6uCK1MHojCms=;
X-AuditID: ac14000a-03e52700000021bc-5a-664d8e446f86
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 6D.00.08636.44E8D466;
 Wed, 22 May 2024 08:18:44 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 22 May
 2024 08:18:43 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 1/6] board: phytec: common: Move eeprom read to new function
Date: Tue, 21 May 2024 23:18:22 -0700
Message-ID: <20240522061827.601699-2-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240522061827.601699-1-d.schultz@phytec.de>
References: <20240522061827.601699-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBLMWRmVeSWpSXmKPExsWyRpKBR9elzzfN4OplQYu3ezvZLbrfqTsw
 eZy9s4PRo7+7hTWAKYrLJiU1J7MstUjfLoEro32mcUGLUMX0P3UNjOf4uhg5OSQETCS23ehk
 72Lk4hASWMIk8eD+VFYI5z6jxLn9y5hBqtgEtCTubJkLZosImEksWnuerYuRg4NZQEOi/RkT
 SFhYwEfi/69/YCUsAqoSU1sPgMV5BSwl1s38xwaxTF5i5qXv7CA2p4CVxO3Z6xlBbCGgmq+v
 /7FD1AtKnJz5hAXEZgaqb946mxnClpA4+OIFM0S9gsTsbZMZYWZOO/eaGcIOldj6ZTvTBEah
 WUhGzUIyahaSUQsYmVcxCuVmJmenFmVm6xVkVJakJuulpG5iBIWuCAPXDsa+OR6HGJk4GA8x
 SnAwK4nwbtrimSbEm5JYWZValB9fVJqTWnyIUZqDRUmcd3VHcKqQQHpiSWp2ampBahFMlomD
 U6qBsXnaZ9ftj1a8mNk+4d21Kq/tORZeoVlPgtNWeoc3PLul5RU+JyzzFT+bps1+ZQ1ZFpYG
 hnlzch8xr24t1y3fVH3ke1yEs/uma7ulZvWtK1U7Kvllce0k1VPr9l7m3qS/8dzOzl980fza
 eoxnewyqCs/+fj7j9NM383nOFkpsvDthZ9/n73mPtiqxFGckGmoxFxUnAgAMqSWGSwIAAA==
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

We need to read multiple times from different offsets in API v3.
Move the EEPROM read logic into a dedicated function to make it
usable multiple times.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 board/phytec/common/phytec_som_detection.c | 38 ++++++++++++++--------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/board/phytec/common/phytec_som_detection.c b/board/phytec/common/phytec_som_detection.c
index b14bb3dbb7f..a089fe9bc90 100644
--- a/board/phytec/common/phytec_som_detection.c
+++ b/board/phytec/common/phytec_som_detection.c
@@ -47,16 +47,9 @@ int phytec_eeprom_data_setup(struct phytec_eeprom_data *data,
 	return ret;
 }
 
-int phytec_eeprom_data_init(struct phytec_eeprom_data *data,
-			    int bus_num, int addr)
+int phytec_eeprom_read(u8 *data, int bus_num, int addr, int size, int offset)
 {
-	int ret, i;
-	unsigned int crc;
-	u8 *ptr;
-	const unsigned int payload_size = sizeof(struct phytec_eeprom_payload);
-
-	if (!data)
-		data = &eeprom_data;
+	int ret;
 
 #if CONFIG_IS_ENABLED(DM_I2C)
 	struct udevice *dev;
@@ -64,19 +57,36 @@ int phytec_eeprom_data_init(struct phytec_eeprom_data *data,
 	ret = i2c_get_chip_for_busnum(bus_num, addr, 2, &dev);
 	if (ret) {
 		pr_err("%s: i2c EEPROM not found: %i.\n", __func__, ret);
-		goto err;
+		return ret;
 	}
 
-	ret = dm_i2c_read(dev, 0, (uint8_t *)data, payload_size);
+	ret = dm_i2c_read(dev, offset, (uint8_t *)data, size);
 	if (ret) {
 		pr_err("%s: Unable to read EEPROM data: %i\n", __func__, ret);
-		goto err;
+		return ret;
 	}
 #else
 	i2c_set_bus_num(bus_num);
-	ret = i2c_read(addr, 0, 2, (uint8_t *)data,
-		       sizeof(struct phytec_eeprom_data));
+	ret = i2c_read(addr, offset, 2, (uint8_t *)data, size);
 #endif
+	return ret;
+}
+
+int phytec_eeprom_data_init(struct phytec_eeprom_data *data,
+			    int bus_num, int addr)
+{
+	int ret, i;
+	unsigned int crc;
+	u8 *ptr;
+	const unsigned int payload_size = sizeof(struct phytec_eeprom_payload);
+
+	if (!data)
+		data = &eeprom_data;
+
+	ret = phytec_eeprom_read((u8 *)data, bus_num, addr,
+				 payload_size, 0);
+	if (ret)
+		goto err;
 
 	if (data->payload.api_rev == 0xff) {
 		pr_err("%s: EEPROM is not flashed. Prototype?\n", __func__);
-- 
2.25.1

