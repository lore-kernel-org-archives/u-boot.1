Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC94DE7C4D1
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 15:08:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 356D087522;
	Wed,  4 Oct 2023 17:07:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="oRvyZ9cV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2A59874F8; Wed,  4 Oct 2023 17:07:45 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD15387456
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 17:07:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivprusov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id B0D8210000F;
 Wed,  4 Oct 2023 18:07:38 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B0D8210000F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1696432058;
 bh=lzNWvYJSIyUtsum5+M7/YjDlfLP8F3WbUMhmLhg18Ms=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=oRvyZ9cV07cizaBSXn4T3pjjkoDUw4vl2GNOXUCcOONjzXE6Pgi3OANhaAxOmoqAa
 9RuFRyyvi2t1e4gSLvWY+aPvhOxnA8jiEVoinNaD+lknEr9HivkXTplH9TJG757P2t
 FtlIuv1M7yLdvGBPjNJR35mdp45uY+OK1CTSkS2y9e1NhrMoyREBJjFa4yqSDv+ciR
 xnd03YRQ4CXV8cWUfO5okwYUbyD4eKZDkapl6ZEhtt/xeB4MbYS5tyO4ou0m/re381
 t2eIu1UDtBY0K4c7Is/mjC22uQxThrWN7IIeDSAbHd7O6o07IJiUgAwsWl/qvUzPG5
 BeiQeEGIu+96w==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed,  4 Oct 2023 18:07:38 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 4 Oct 2023 18:07:38 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Chuanhong Guo <gch981213@gmail.com>, Dmitry Rokosov
 <ddrokosov@sberdevices.ru>, Igor Prusov <ivprusov@salutedevices.com>, Simon
 Glass <sjg@chromium.org>, Patrice Chotard <patrice.chotard@foss.st.com>
CC: <prusovigor@gmail.com>, <kernel@sberdevices.ru>, <u-boot@lists.denx.de>
Subject: [PATCH v1 1/2] mtd: spinand: rework detect procedure for different
 READ_ID operation
Date: Wed, 4 Oct 2023 18:07:03 +0300
Message-ID: <20231004150704.49945-2-ivprusov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004150704.49945-1-ivprusov@salutedevices.com>
References: <20231004150704.49945-1-ivprusov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180354 [Oct 04 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 535 535
 da804c0ea8918f802fc60e7a20ba49783d957ba2,
 {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1; salutedevices.com:7.1.1;
 100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/10/04 12:58:00 #22056622
X-KSMG-AntiVirus-Status: Clean, skipped
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

Adaptation of Linux commit f1541773af49.

Currently there are 3 different variants of read_id implementation:
1. opcode only. Found in GD5FxGQ4xF.
2. opcode + 1 addr byte. Found in GD5GxGQ4xA/E
3. opcode + 1 dummy byte. Found in other currently supported chips.

Original implementation was for variant 1 and let detect function
of chips with variant 2 and 3 to ignore the first byte. This isn't
robust:

1. For chips of variant 2, if SPI master doesn't keep MOSI low
during read, chip will get a random id offset, and the entire id
buffer will shift by that offset, causing detect failure.

2. For chips of variant 1, if it happens to get a devid that equals
to manufacture id of variant 2 or 3 chips, it'll get incorrectly
detected.

This patch reworks detect procedure to address problems above. New
logic do detection for all variants separatedly, in 1-2-3 order.
Since all current detect methods do exactly the same id matching
procedure, unify them into core.c and remove detect method from
manufacture_ops.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---
 drivers/mtd/nand/spi/core.c       | 85 +++++++++++++++++++++++--------
 drivers/mtd/nand/spi/gigadevice.c | 30 +++--------
 drivers/mtd/nand/spi/macronix.c   | 45 ++++++----------
 drivers/mtd/nand/spi/micron.c     | 50 ++++++++----------
 drivers/mtd/nand/spi/toshiba.c    | 66 +++++++++++-------------
 drivers/mtd/nand/spi/winbond.c    | 34 +++----------
 include/linux/mtd/spinand.h       | 66 ++++++++++++++++--------
 7 files changed, 185 insertions(+), 191 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 4ee11e812d..3ea746fd13 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -17,6 +17,7 @@
 #include <linux/mtd/spinand.h>
 #include <linux/of.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 #else
@@ -452,10 +453,11 @@ out:
 	return status & STATUS_BUSY ? -ETIMEDOUT : 0;
 }
 
-static int spinand_read_id_op(struct spinand_device *spinand, u8 *buf)
+static int spinand_read_id_op(struct spinand_device *spinand, u8 naddr,
+			      u8 ndummy, u8 *buf)
 {
-	struct spi_mem_op op = SPINAND_READID_OP(0, spinand->scratchbuf,
-						 SPINAND_MAX_ID_LEN);
+	struct spi_mem_op op = SPINAND_READID_OP(
+		naddr, ndummy, spinand->scratchbuf, SPINAND_MAX_ID_LEN);
 	int ret;
 
 	ret = spi_mem_exec_op(spinand->slave, &op);
@@ -837,24 +839,63 @@ static const struct spinand_manufacturer *spinand_manufacturers[] = {
 	&winbond_spinand_manufacturer,
 };
 
-static int spinand_manufacturer_detect(struct spinand_device *spinand)
+static int spinand_manufacturer_match(struct spinand_device *spinand,
+				      enum spinand_readid_method rdid_method)
 {
+	u8 *id = spinand->id.data;
 	unsigned int i;
 	int ret;
 
 	for (i = 0; i < ARRAY_SIZE(spinand_manufacturers); i++) {
-		ret = spinand_manufacturers[i]->ops->detect(spinand);
-		if (ret > 0) {
-			spinand->manufacturer = spinand_manufacturers[i];
-			return 0;
-		} else if (ret < 0) {
-			return ret;
-		}
+		const struct spinand_manufacturer *manufacturer =
+			spinand_manufacturers[i];
+
+		if (id[0] != manufacturer->id)
+			continue;
+
+		ret = spinand_match_and_init(spinand,
+					     manufacturer->chips,
+					     manufacturer->nchips,
+					     rdid_method);
+		if (ret < 0)
+			continue;
+
+		spinand->manufacturer = manufacturer;
+		return 0;
 	}
 
 	return -ENOTSUPP;
 }
 
+static int spinand_id_detect(struct spinand_device *spinand)
+{
+	u8 *id = spinand->id.data;
+	int ret;
+
+	ret = spinand_read_id_op(spinand, 0, 0, id);
+	if (ret)
+		return ret;
+	ret = spinand_manufacturer_match(spinand, SPINAND_READID_METHOD_OPCODE);
+	if (!ret)
+		return 0;
+
+	ret = spinand_read_id_op(spinand, 1, 0, id);
+	if (ret)
+		return ret;
+	ret = spinand_manufacturer_match(spinand,
+					 SPINAND_READID_METHOD_OPCODE_ADDR);
+	if (!ret)
+		return 0;
+
+	ret = spinand_read_id_op(spinand, 0, 1, id);
+	if (ret)
+		return ret;
+	ret = spinand_manufacturer_match(spinand,
+					 SPINAND_READID_METHOD_OPCODE_DUMMY);
+
+	return ret;
+}
+
 static int spinand_manufacturer_init(struct spinand_device *spinand)
 {
 	if (spinand->manufacturer->ops->init)
@@ -910,9 +951,9 @@ spinand_select_op_variant(struct spinand_device *spinand,
  * @spinand: SPI NAND object
  * @table: SPI NAND device description table
  * @table_size: size of the device description table
+ * @rdid_method: read id method to match
  *
- * Should be used by SPI NAND manufacturer drivers when they want to find a
- * match between a device ID retrieved through the READ_ID command and an
++ * Match between a device ID retrieved through the READ_ID command and an
  * entry in the SPI NAND description table. If a match is found, the spinand
  * object will be initialized with information provided by the matching
  * spinand_info entry.
@@ -921,8 +962,10 @@ spinand_select_op_variant(struct spinand_device *spinand,
  */
 int spinand_match_and_init(struct spinand_device *spinand,
 			   const struct spinand_info *table,
-			   unsigned int table_size, u8 devid)
+			   unsigned int table_size,
+			   enum spinand_readid_method rdid_method)
 {
+	u8 *id = spinand->id.data;
 	struct nand_device *nand = spinand_to_nand(spinand);
 	unsigned int i;
 
@@ -930,13 +973,17 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		const struct spinand_info *info = &table[i];
 		const struct spi_mem_op *op;
 
-		if (devid != info->devid)
+		if (rdid_method != info->devid.method)
+			continue;
+
+		if (memcmp(id + 1, info->devid.id, info->devid.len))
 			continue;
 
 		nand->memorg = table[i].memorg;
 		nand->eccreq = table[i].eccreq;
 		spinand->eccinfo = table[i].eccinfo;
 		spinand->flags = table[i].flags;
+		spinand->id.len = 1 + table[i].devid.len;
 		spinand->select_target = table[i].select_target;
 
 		op = spinand_select_op_variant(spinand,
@@ -972,13 +1019,7 @@ static int spinand_detect(struct spinand_device *spinand)
 	if (ret)
 		return ret;
 
-	ret = spinand_read_id_op(spinand, spinand->id.data);
-	if (ret)
-		return ret;
-
-	spinand->id.len = SPINAND_MAX_ID_LEN;
-
-	ret = spinand_manufacturer_detect(spinand);
+	ret = spinand_id_detect(spinand);
 	if (ret) {
 		dev_err(spinand->slave->dev, "unknown raw ID %02x %02x %02x %02x\n",
 			spinand->id.data[0], spinand->id.data[1],
diff --git a/drivers/mtd/nand/spi/gigadevice.c b/drivers/mtd/nand/spi/gigadevice.c
index a2c93486f4..affd764e54 100644
--- a/drivers/mtd/nand/spi/gigadevice.c
+++ b/drivers/mtd/nand/spi/gigadevice.c
@@ -158,7 +158,8 @@ static const struct mtd_ooblayout_ops gd5fxgqxxexxg_ooblayout = {
 };
 
 static const struct spinand_info gigadevice_spinand_table[] = {
-	SPINAND_INFO("GD5F1GQ4UExxG", 0xd1,
+	SPINAND_INFO("GD5F1GQ4UExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0xd1),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&gd5fxgq4_read_cache_variants,
@@ -167,7 +168,8 @@ static const struct spinand_info gigadevice_spinand_table[] = {
 		     0,
 		     SPINAND_ECCINFO(&gd5fxgqxxexxg_ooblayout,
 				     gd5fxgq4xexxg_ecc_get_status)),
-	SPINAND_INFO("GD5F1GQ5UExxG", 0x51,
+	SPINAND_INFO("GD5F1GQ5UExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x51),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 1, 1, 1),
 		     NAND_ECCREQ(4, 512),
 		     SPINAND_INFO_OP_VARIANTS(&gd5f1gq5_read_cache_variants,
@@ -178,33 +180,13 @@ static const struct spinand_info gigadevice_spinand_table[] = {
 				     gd5fxgq5xexxg_ecc_get_status)),
 };
 
-static int gigadevice_spinand_detect(struct spinand_device *spinand)
-{
-	u8 *id = spinand->id.data;
-	int ret;
-
-	/*
-	 * For GD NANDs, There is an address byte needed to shift in before IDs
-	 * are read out, so the first byte in raw_id is dummy.
-	 */
-	if (id[1] != SPINAND_MFR_GIGADEVICE)
-		return 0;
-
-	ret = spinand_match_and_init(spinand, gigadevice_spinand_table,
-				     ARRAY_SIZE(gigadevice_spinand_table),
-				     id[2]);
-	if (ret)
-		return ret;
-
-	return 1;
-}
-
 static const struct spinand_manufacturer_ops gigadevice_spinand_manuf_ops = {
-	.detect = gigadevice_spinand_detect,
 };
 
 const struct spinand_manufacturer gigadevice_spinand_manufacturer = {
 	.id = SPINAND_MFR_GIGADEVICE,
 	.name = "GigaDevice",
+	.chips = gigadevice_spinand_table,
+	.nchips = ARRAY_SIZE(gigadevice_spinand_table),
 	.ops = &gigadevice_spinand_manuf_ops,
 };
diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index 6d643a8000..08f7d69d8c 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -105,7 +105,8 @@ static int mx35lf1ge4ab_ecc_get_status(struct spinand_device *spinand,
 }
 
 static const struct spinand_info macronix_spinand_table[] = {
-	SPINAND_INFO("MX35LF1GE4AB", 0x12,
+	SPINAND_INFO("MX35LF1GE4AB",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x12),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 1, 1, 1),
 		     NAND_ECCREQ(4, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -114,7 +115,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     mx35lf1ge4ab_ecc_get_status)),
-	SPINAND_INFO("MX35LF2GE4AB", 0x22,
+	SPINAND_INFO("MX35LF2GE4AB",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x22),
 		     NAND_MEMORG(1, 2048, 64, 64, 2048, 2, 1, 1),
 		     NAND_ECCREQ(4, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -122,7 +124,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
-	SPINAND_INFO("MX35UF4GE4AD", 0xb7,
+	SPINAND_INFO("MX35UF4GE4AD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xb7),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -131,7 +134,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     mx35lf1ge4ab_ecc_get_status)),
-	SPINAND_INFO("MX35UF2GE4AD", 0xa6,
+	SPINAND_INFO("MX35UF2GE4AD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa6),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -140,7 +144,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     mx35lf1ge4ab_ecc_get_status)),
-	SPINAND_INFO("MX35UF2GE4AC", 0xa2,
+	SPINAND_INFO("MX35UF2GE4AC",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa2),
 		     NAND_MEMORG(1, 2048, 64, 64, 2048, 1, 1, 1),
 		     NAND_ECCREQ(4, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -149,7 +154,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     mx35lf1ge4ab_ecc_get_status)),
-	SPINAND_INFO("MX35UF1GE4AD", 0x96,
+	SPINAND_INFO("MX35UF1GE4AD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x96),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -158,7 +164,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     mx35lf1ge4ab_ecc_get_status)),
-	SPINAND_INFO("MX35UF1GE4AC", 0x92,
+	SPINAND_INFO("MX35UF1GE4AC",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x92),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 1, 1, 1),
 		     NAND_ECCREQ(4, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -170,33 +177,13 @@ static const struct spinand_info macronix_spinand_table[] = {
 
 };
 
-static int macronix_spinand_detect(struct spinand_device *spinand)
-{
-	u8 *id = spinand->id.data;
-	int ret;
-
-	/*
-	 * Macronix SPI NAND read ID needs a dummy byte, so the first byte in
-	 * raw_id is garbage.
-	 */
-	if (id[1] != SPINAND_MFR_MACRONIX)
-		return 0;
-
-	ret = spinand_match_and_init(spinand, macronix_spinand_table,
-				     ARRAY_SIZE(macronix_spinand_table),
-				     id[2]);
-	if (ret)
-		return ret;
-
-	return 1;
-}
-
 static const struct spinand_manufacturer_ops macronix_spinand_manuf_ops = {
-	.detect = macronix_spinand_detect,
 };
 
 const struct spinand_manufacturer macronix_spinand_manufacturer = {
 	.id = SPINAND_MFR_MACRONIX,
 	.name = "Macronix",
+	.chips = macronix_spinand_table,
+	.nchips = ARRAY_SIZE(macronix_spinand_table),
 	.ops = &macronix_spinand_manuf_ops,
 };
diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 6bacf14aaf..cecd3db958 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -120,7 +120,8 @@ static int micron_8_ecc_get_status(struct spinand_device *spinand,
 
 static const struct spinand_info micron_spinand_table[] = {
 	/* M79A 2Gb 3.3V */
-	SPINAND_INFO("MT29F2G01ABAGD", 0x24,
+	SPINAND_INFO("MT29F2G01ABAGD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x24),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 2, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -130,7 +131,8 @@ static const struct spinand_info micron_spinand_table[] = {
 		     SPINAND_ECCINFO(&micron_8_ooblayout,
 				     micron_8_ecc_get_status)),
 	/* M79A 2Gb 1.8V */
-	SPINAND_INFO("MT29F2G01ABBGD", 0x25,
+	SPINAND_INFO("MT29F2G01ABBGD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x25),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 2, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -140,7 +142,8 @@ static const struct spinand_info micron_spinand_table[] = {
 		     SPINAND_ECCINFO(&micron_8_ooblayout,
 				     micron_8_ecc_get_status)),
 	/* M78A 1Gb 3.3V */
-	SPINAND_INFO("MT29F1G01ABAFD", 0x14,
+	SPINAND_INFO("MT29F1G01ABAFD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x14),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -150,7 +153,8 @@ static const struct spinand_info micron_spinand_table[] = {
 		     SPINAND_ECCINFO(&micron_8_ooblayout,
 				     micron_8_ecc_get_status)),
 	/* M78A 1Gb 1.8V */
-	SPINAND_INFO("MT29F1G01ABAFD", 0x15,
+	SPINAND_INFO("MT29F1G01ABAFD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x15),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -160,7 +164,8 @@ static const struct spinand_info micron_spinand_table[] = {
 		     SPINAND_ECCINFO(&micron_8_ooblayout,
 				     micron_8_ecc_get_status)),
 	/* M79A 4Gb 3.3V */
-	SPINAND_INFO("MT29F4G01ADAGD", 0x36,
+	SPINAND_INFO("MT29F4G01ADAGD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x36),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 2, 1, 2),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -171,7 +176,8 @@ static const struct spinand_info micron_spinand_table[] = {
 				     micron_8_ecc_get_status),
 		     SPINAND_SELECT_TARGET(micron_select_target)),
 	/* M70A 4Gb 3.3V */
-	SPINAND_INFO("MT29F4G01ABAFD", 0x34,
+	SPINAND_INFO("MT29F4G01ABAFD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x34),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -181,7 +187,8 @@ static const struct spinand_info micron_spinand_table[] = {
 		     SPINAND_ECCINFO(&micron_8_ooblayout,
 				     micron_8_ecc_get_status)),
 	/* M70A 4Gb 1.8V */
-	SPINAND_INFO("MT29F4G01ABBFD", 0x35,
+	SPINAND_INFO("MT29F4G01ABBFD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x35),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -191,7 +198,8 @@ static const struct spinand_info micron_spinand_table[] = {
 		     SPINAND_ECCINFO(&micron_8_ooblayout,
 				     micron_8_ecc_get_status)),
 	/* M70A 8Gb 3.3V */
-	SPINAND_INFO("MT29F8G01ADAFD", 0x46,
+	SPINAND_INFO("MT29F8G01ADAFD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x46),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 1, 1, 2),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -202,7 +210,8 @@ static const struct spinand_info micron_spinand_table[] = {
 				     micron_8_ecc_get_status),
 		     SPINAND_SELECT_TARGET(micron_select_target)),
 	/* M70A 8Gb 1.8V */
-	SPINAND_INFO("MT29F8G01ADBFD", 0x47,
+	SPINAND_INFO("MT29F8G01ADBFD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x47),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 1, 1, 2),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -214,26 +223,6 @@ static const struct spinand_info micron_spinand_table[] = {
 		     SPINAND_SELECT_TARGET(micron_select_target)),
 };
 
-static int micron_spinand_detect(struct spinand_device *spinand)
-{
-	u8 *id = spinand->id.data;
-	int ret;
-
-	/*
-	 * Micron SPI NAND read ID need a dummy byte,
-	 * so the first byte in raw_id is dummy.
-	 */
-	if (id[1] != SPINAND_MFR_MICRON)
-		return 0;
-
-	ret = spinand_match_and_init(spinand, micron_spinand_table,
-				     ARRAY_SIZE(micron_spinand_table), id[2]);
-	if (ret)
-		return ret;
-
-	return 1;
-}
-
 static int micron_spinand_init(struct spinand_device *spinand)
 {
 	/*
@@ -248,12 +237,13 @@ static int micron_spinand_init(struct spinand_device *spinand)
 }
 
 static const struct spinand_manufacturer_ops micron_spinand_manuf_ops = {
-	.detect = micron_spinand_detect,
 	.init = micron_spinand_init,
 };
 
 const struct spinand_manufacturer micron_spinand_manufacturer = {
 	.id = SPINAND_MFR_MICRON,
 	.name = "Micron",
+	.chips = micron_spinand_table,
+	.nchips = ARRAY_SIZE(micron_spinand_table),
 	.ops = &micron_spinand_manuf_ops,
 };
diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
index c2cd3b426b..e057b08c70 100644
--- a/drivers/mtd/nand/spi/toshiba.c
+++ b/drivers/mtd/nand/spi/toshiba.c
@@ -111,7 +111,8 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
 
 static const struct spinand_info toshiba_spinand_table[] = {
 	/* 3.3V 1Gb (1st generation) */
-	SPINAND_INFO("TC58CVG0S3HRAIG", 0xC2,
+	SPINAND_INFO("TC58CVG0S3HRAIG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xC2),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -121,7 +122,8 @@ static const struct spinand_info toshiba_spinand_table[] = {
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
 				     tx58cxgxsxraix_ecc_get_status)),
 	/* 3.3V 2Gb (1st generation) */
-	SPINAND_INFO("TC58CVG1S3HRAIG", 0xCB,
+	SPINAND_INFO("TC58CVG1S3HRAIG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xCB),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -131,7 +133,8 @@ static const struct spinand_info toshiba_spinand_table[] = {
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
 				     tx58cxgxsxraix_ecc_get_status)),
 	/* 3.3V 4Gb (1st generation) */
-	SPINAND_INFO("TC58CVG2S0HRAIG", 0xCD,
+	SPINAND_INFO("TC58CVG2S0HRAIG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xCD),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -141,7 +144,8 @@ static const struct spinand_info toshiba_spinand_table[] = {
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
 				     tx58cxgxsxraix_ecc_get_status)),
 	/* 1.8V 1Gb (1st generation) */
-	SPINAND_INFO("TC58CYG0S3HRAIG", 0xB2,
+	SPINAND_INFO("TC58CYG0S3HRAIG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xB2),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -151,7 +155,8 @@ static const struct spinand_info toshiba_spinand_table[] = {
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
 				     tx58cxgxsxraix_ecc_get_status)),
 	/* 1.8V 2Gb (1st generation) */
-	SPINAND_INFO("TC58CYG1S3HRAIG", 0xBB,
+	SPINAND_INFO("TC58CYG1S3HRAIG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xBB),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -161,7 +166,8 @@ static const struct spinand_info toshiba_spinand_table[] = {
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
 				     tx58cxgxsxraix_ecc_get_status)),
 	/* 1.8V 4Gb (1st generation) */
-	SPINAND_INFO("TC58CYG2S0HRAIG", 0xBD,
+	SPINAND_INFO("TC58CYG2S0HRAIG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xBD),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -176,7 +182,8 @@ static const struct spinand_info toshiba_spinand_table[] = {
 	 * QE_BIT.
 	 */
 	/* 3.3V 1Gb (2nd generation) */
-	SPINAND_INFO("TC58CVG0S3HRAIJ", 0xE2,
+	SPINAND_INFO("TC58CVG0S3HRAIJ",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xE2),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -186,7 +193,8 @@ static const struct spinand_info toshiba_spinand_table[] = {
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
 				     tx58cxgxsxraix_ecc_get_status)),
 	/* 3.3V 2Gb (2nd generation) */
-	SPINAND_INFO("TC58CVG1S3HRAIJ", 0xEB,
+	SPINAND_INFO("TC58CVG1S3HRAIJ",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xEB),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -196,7 +204,8 @@ static const struct spinand_info toshiba_spinand_table[] = {
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
 				     tx58cxgxsxraix_ecc_get_status)),
 	/* 3.3V 4Gb (2nd generation) */
-	SPINAND_INFO("TC58CVG2S0HRAIJ", 0xED,
+	SPINAND_INFO("TC58CVG2S0HRAIJ",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xED),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -206,7 +215,8 @@ static const struct spinand_info toshiba_spinand_table[] = {
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
 				     tx58cxgxsxraix_ecc_get_status)),
 	/* 3.3V 8Gb (2nd generation) */
-	SPINAND_INFO("TH58CVG3S0HRAIJ", 0xE4,
+	SPINAND_INFO("TH58CVG3S0HRAIJ",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xE4),
 		     NAND_MEMORG(1, 4096, 256, 64, 4096, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -216,7 +226,8 @@ static const struct spinand_info toshiba_spinand_table[] = {
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
 				     tx58cxgxsxraix_ecc_get_status)),
 	/* 1.8V 1Gb (2nd generation) */
-	SPINAND_INFO("TC58CYG0S3HRAIJ", 0xD2,
+	SPINAND_INFO("TC58CYG0S3HRAIJ",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xD2),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -226,7 +237,8 @@ static const struct spinand_info toshiba_spinand_table[] = {
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
 				     tx58cxgxsxraix_ecc_get_status)),
 	/* 1.8V 2Gb (2nd generation) */
-	SPINAND_INFO("TC58CYG1S3HRAIJ", 0xDB,
+	SPINAND_INFO("TC58CYG1S3HRAIJ",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xDB),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -236,7 +248,8 @@ static const struct spinand_info toshiba_spinand_table[] = {
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
 				     tx58cxgxsxraix_ecc_get_status)),
 	/* 1.8V 4Gb (2nd generation) */
-	SPINAND_INFO("TC58CYG2S0HRAIJ", 0xDD,
+	SPINAND_INFO("TC58CYG2S0HRAIJ",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xDD),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -246,7 +259,8 @@ static const struct spinand_info toshiba_spinand_table[] = {
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
 				     tx58cxgxsxraix_ecc_get_status)),
 	/* 1.8V 8Gb (2nd generation) */
-	SPINAND_INFO("TH58CYG3S0HRAIJ", 0xD4,
+	SPINAND_INFO("TH58CYG3S0HRAIJ",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xD4),
 		     NAND_MEMORG(1, 4096, 256, 64, 4096, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -257,33 +271,13 @@ static const struct spinand_info toshiba_spinand_table[] = {
 				     tx58cxgxsxraix_ecc_get_status)),
 };
 
-static int toshiba_spinand_detect(struct spinand_device *spinand)
-{
-	u8 *id = spinand->id.data;
-	int ret;
-
-	/*
-	 * Toshiba SPI NAND read ID needs a dummy byte,
-	 * so the first byte in id is garbage.
-	 */
-	if (id[1] != SPINAND_MFR_TOSHIBA)
-		return 0;
-
-	ret = spinand_match_and_init(spinand, toshiba_spinand_table,
-				     ARRAY_SIZE(toshiba_spinand_table),
-				     id[2]);
-	if (ret)
-		return ret;
-
-	return 1;
-}
-
 static const struct spinand_manufacturer_ops toshiba_spinand_manuf_ops = {
-	.detect = toshiba_spinand_detect,
 };
 
 const struct spinand_manufacturer toshiba_spinand_manufacturer = {
 	.id = SPINAND_MFR_TOSHIBA,
 	.name = "Toshiba",
+	.chips = toshiba_spinand_table,
+	.nchips = ARRAY_SIZE(toshiba_spinand_table),
 	.ops = &toshiba_spinand_manuf_ops,
 };
diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index c119486efb..0ce53d3041 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -79,7 +79,8 @@ static int w25m02gv_select_target(struct spinand_device *spinand,
 }
 
 static const struct spinand_info winbond_spinand_table[] = {
-	SPINAND_INFO("W25M02GV", 0xAB,
+	SPINAND_INFO("W25M02GV",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xAB),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 1, 1, 2),
 		     NAND_ECCREQ(1, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -88,7 +89,8 @@ static const struct spinand_info winbond_spinand_table[] = {
 		     0,
 		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL),
 		     SPINAND_SELECT_TARGET(w25m02gv_select_target)),
-	SPINAND_INFO("W25N01GV", 0xAA,
+	SPINAND_INFO("W25N01GV",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xAA),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 1, 1, 1),
 		     NAND_ECCREQ(1, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -98,31 +100,6 @@ static const struct spinand_info winbond_spinand_table[] = {
 		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL)),
 };
 
-/**
- * winbond_spinand_detect - initialize device related part in spinand_device
- * struct if it is a Winbond device.
- * @spinand: SPI NAND device structure
- */
-static int winbond_spinand_detect(struct spinand_device *spinand)
-{
-	u8 *id = spinand->id.data;
-	int ret;
-
-	/*
-	 * Winbond SPI NAND read ID need a dummy byte,
-	 * so the first byte in raw_id is dummy.
-	 */
-	if (id[1] != SPINAND_MFR_WINBOND)
-		return 0;
-
-	ret = spinand_match_and_init(spinand, winbond_spinand_table,
-				     ARRAY_SIZE(winbond_spinand_table), id[2]);
-	if (ret)
-		return ret;
-
-	return 1;
-}
-
 static int winbond_spinand_init(struct spinand_device *spinand)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
@@ -142,12 +119,13 @@ static int winbond_spinand_init(struct spinand_device *spinand)
 }
 
 static const struct spinand_manufacturer_ops winbond_spinand_manuf_ops = {
-	.detect = winbond_spinand_detect,
 	.init = winbond_spinand_init,
 };
 
 const struct spinand_manufacturer winbond_spinand_manufacturer = {
 	.id = SPINAND_MFR_WINBOND,
 	.name = "Winbond",
+	.chips = winbond_spinand_table,
+	.nchips = ARRAY_SIZE(winbond_spinand_table),
 	.ops = &winbond_spinand_manuf_ops,
 };
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 15bcd59f34..3a2d55ac45 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -39,9 +39,9 @@
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_NO_DATA)
 
-#define SPINAND_READID_OP(ndummy, buf, len)				\
+#define SPINAND_READID_OP(naddr, ndummy, buf, len)			\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x9f, 1),				\
-		   SPI_MEM_OP_NO_ADDR,					\
+		   SPI_MEM_OP_ADDR(naddr, 0, 1),			\
 		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
 		   SPI_MEM_OP_DATA_IN(len, buf, 1))
 
@@ -153,37 +153,46 @@ struct spinand_device;
  * @data: buffer containing the id bytes. Currently 4 bytes large, but can
  *	  be extended if required
  * @len: ID length
- *
- * struct_spinand_id->data contains all bytes returned after a READ_ID command,
- * including dummy bytes if the chip does not emit ID bytes right after the
- * READ_ID command. The responsibility to extract real ID bytes is left to
- * struct_manufacurer_ops->detect().
  */
 struct spinand_id {
 	u8 data[SPINAND_MAX_ID_LEN];
 	int len;
 };
 
+enum spinand_readid_method {
+	SPINAND_READID_METHOD_OPCODE,
+	SPINAND_READID_METHOD_OPCODE_ADDR,
+	SPINAND_READID_METHOD_OPCODE_DUMMY,
+};
+
+/**
+ * struct spinand_devid - SPI NAND device id structure
+ * @id: device id of current chip
+ * @len: number of bytes in device id
+ * @method: method to read chip id
+ *	    There are 3 possible variants:
+ *	    SPINAND_READID_METHOD_OPCODE: chip id is returned immediately
+ *	    after read_id opcode.
+ *	    SPINAND_READID_METHOD_OPCODE_ADDR: chip id is returned after
+ *	    read_id opcode + 1-byte address.
+ *	    SPINAND_READID_METHOD_OPCODE_DUMMY: chip id is returned after
+ *	    read_id opcode + 1 dummy byte.
+ */
+struct spinand_devid {
+	const u8 *id;
+	const u8 len;
+	const enum spinand_readid_method method;
+};
+
 /**
  * struct manufacurer_ops - SPI NAND manufacturer specific operations
- * @detect: detect a SPI NAND device. Every time a SPI NAND device is probed
- *	    the core calls the struct_manufacurer_ops->detect() hook of each
- *	    registered manufacturer until one of them return 1. Note that
- *	    the first thing to check in this hook is that the manufacturer ID
- *	    in struct_spinand_device->id matches the manufacturer whose
- *	    ->detect() hook has been called. Should return 1 if there's a
- *	    match, 0 if the manufacturer ID does not match and a negative
- *	    error code otherwise. When true is returned, the core assumes
- *	    that properties of the NAND chip (spinand->base.memorg and
- *	    spinand->base.eccreq) have been filled
  * @init: initialize a SPI NAND device
  * @cleanup: cleanup a SPI NAND device
  *
  * Each SPI NAND manufacturer driver should implement this interface so that
- * NAND chips coming from this vendor can be detected and initialized properly.
+ * NAND chips coming from this vendor can be initialized properly.
  */
 struct spinand_manufacturer_ops {
-	int (*detect)(struct spinand_device *spinand);
 	int (*init)(struct spinand_device *spinand);
 	void (*cleanup)(struct spinand_device *spinand);
 };
@@ -193,10 +202,15 @@ struct spinand_manufacturer_ops {
  * @id: manufacturer ID
  * @name: manufacturer name
  * @ops: manufacturer operations
+ * @devid_len: number of bytes in device ID
+ * @chips: supported SPI NANDs under current manufacturer
+ * @nchips: number of SPI NANDs available in chips array
  */
 struct spinand_manufacturer {
 	u8 id;
 	char *name;
+	const struct spinand_info *chips;
+	const size_t nchips;
 	const struct spinand_manufacturer_ops *ops;
 };
 
@@ -268,7 +282,7 @@ struct spinand_ecc_info {
  */
 struct spinand_info {
 	const char *model;
-	u8 devid;
+	struct spinand_devid devid;
 	u32 flags;
 	struct nand_memory_organization memorg;
 	struct nand_ecc_req eccreq;
@@ -282,6 +296,13 @@ struct spinand_info {
 			     unsigned int target);
 };
 
+#define SPINAND_ID(__method, ...)					\
+	{								\
+		.id = (const u8[]){ __VA_ARGS__ },			\
+		.len = sizeof((u8[]){ __VA_ARGS__ }),			\
+		.method = __method,					\
+	}
+
 #define SPINAND_INFO_OP_VARIANTS(__read, __write, __update)		\
 	{								\
 		.read_cache = __read,					\
@@ -440,9 +461,10 @@ static inline void spinand_set_ofnode(struct spinand_device *spinand,
 }
 #endif /* __UBOOT__ */
 
-int spinand_match_and_init(struct spinand_device *dev,
+int spinand_match_and_init(struct spinand_device *spinand,
 			   const struct spinand_info *table,
-			   unsigned int table_size, u8 devid);
+			   unsigned int table_size,
+			   enum spinand_readid_method rdid_method);
 
 int spinand_upd_cfg(struct spinand_device *spinand, u8 mask, u8 val);
 int spinand_select_target(struct spinand_device *spinand, unsigned int target);
-- 
2.34.1

