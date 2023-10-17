Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF6BCDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 19:29:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 305B386F44;
	Tue, 17 Oct 2023 21:29:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="Dc90YkXl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 718E486F54; Tue, 17 Oct 2023 21:29:42 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D418C86F20
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 21:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivprusov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 38E20100005;
 Tue, 17 Oct 2023 22:29:39 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 38E20100005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1697570979;
 bh=6Mr1wkk9gtXUmfCjSoQjN9/iDbakw/iZY7yfTB/yoxE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=Dc90YkXlqs7KZGWCu/X7gnCsnpnZNeRURt2I7Z0YFuv9zI6DelEqebdyLmfwR1xzV
 pDadSUXbIOqhUhkqbTOcNkV7OPtuyJg3LERL7Ok75M2G+fzdUHaytiDmYwR1pzwC0c
 SDnjrq/3Z69YcouZMNRQkLBbRuLH28fIo46ZDa2wDgV4WC6JuBoVqbApaj7dR4lKjL
 P3vCHRXWQB8l2gqsOTKrQkb5Ny7B0HSqyobPrNed6yh6INJv1PPk6p4fRIWEuCFOU3
 a3WmGMNKQOJQMdsIMSOEEh7J9ITqWdiTJNC4RVhUUUHdDEKVcVuKbAb2Pm2dUOe8x5
 QBCzYWoGU8ePA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue, 17 Oct 2023 22:29:38 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 17 Oct 2023 22:29:38 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>
CC: <prusovigor@gmail.com>, <kernel@sberdevices.ru>, Igor Prusov
 <ivprusov@salutedevices.com>, Chuanhong Guo <gch981213@gmail.com>, Martin
 Kurbanov <mmkurbanov@sberdevices.ru>, Dmitry Rokosov
 <ddrokosov@sberdevices.ru>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 <u-boot@lists.denx.de>
Subject: [PATCH v2 1/1] mtd: spinand: add support for ESMT F50x1G41LB
Date: Tue, 17 Oct 2023 22:29:26 +0300
Message-ID: <20231017192926.54397-2-ivprusov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017192926.54397-1-ivprusov@salutedevices.com>
References: <20231017192926.54397-1-ivprusov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180688 [Oct 17 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 540 540
 2509a3fe0f7fdc802e7154a32be7c2dd394ab987, {Tracking_uf_ne_domains},
 {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;
 100.64.160.123:7.1.2; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 www.esmt.com.tw:7.1.1; p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;
 salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/10/17 18:29:00
X-KSMG-LinksScanning: Clean, bases: 2023/10/17 18:29:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/10/17 18:30:00 #22213411
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

Adaptation of Linux commit d74c36480a67

This patch adds support for ESMT F50L1G41LB and F50D1G41LB.
It seems that ESMT likes to use random JEDEC ID from other vendors.
Their 1G chips uses 0xc8 from GigaDevice and 2G/4G chips uses 0x2c from
Micron. For this reason, the ESMT entry is named esmt_c8 with explicit
JEDEC ID in variable name.

Datasheets:
https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/F50L1G41LB(2M).pdf
https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/F50D1G41LB(2M).pdf

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
Tested-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
---
 drivers/mtd/nand/spi/Makefile |   3 +-
 drivers/mtd/nand/spi/core.c   |   1 +
 drivers/mtd/nand/spi/esmt.c   | 137 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h   |   1 +
 4 files changed, 141 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mtd/nand/spi/esmt.c

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index 3051de4f7e..f172f4787f 100644
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-spinand-objs := core.o gigadevice.o macronix.o micron.o paragon.o toshiba.o winbond.o
+spinand-objs := core.o esmt.o gigadevice.o macronix.o micron.o paragon.o
+spinand-objs += toshiba.o winbond.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 597b088ca7..8ca33459f9 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -828,6 +828,7 @@ static const struct spinand_manufacturer *spinand_manufacturers[] = {
 	&paragon_spinand_manufacturer,
 	&toshiba_spinand_manufacturer,
 	&winbond_spinand_manufacturer,
+	&esmt_c8_spinand_manufacturer,
 };
 
 static int spinand_manufacturer_match(struct spinand_device *spinand,
diff --git a/drivers/mtd/nand/spi/esmt.c b/drivers/mtd/nand/spi/esmt.c
new file mode 100644
index 0000000000..7e07b26827
--- /dev/null
+++ b/drivers/mtd/nand/spi/esmt.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author:
+ *	Chuanhong Guo <gch981213@gmail.com> - the main driver logic
+ *	Martin Kurbanov <mmkurbanov@sberdevices.ru> - OOB layout
+ */
+
+#ifndef __UBOOT__
+#include <linux/device.h>
+#include <linux/kernel.h>
+#endif
+#include <linux/mtd/spinand.h>
+
+/* ESMT uses GigaDevice 0xc8 JECDEC ID on some SPI NANDs */
+#define SPINAND_MFR_ESMT_C8			0xc8
+
+static SPINAND_OP_VARIANTS(read_cache_variants,
+			   SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+			   SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+			   SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+			   SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants,
+			   SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+			   SPINAND_PROG_LOAD(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants,
+			   SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+			   SPINAND_PROG_LOAD(false, 0, NULL, 0));
+
+/*
+ * OOB spare area map (64 bytes)
+ *
+ * Bad Block Markers
+ * filled by HW and kernel                 Reserved
+ *   |                 +-----------------------+-----------------------+
+ *   |                 |                       |                       |
+ *   |                 |    OOB free data Area |non ECC protected      |
+ *   |   +-------------|-----+-----------------|-----+-----------------|-----+
+ *   |   |             |     |                 |     |                 |     |
+ * +-|---|----------+--|-----|--------------+--|-----|--------------+--|-----|--------------+
+ * | |   | section0 |  |     |    section1  |  |     |    section2  |  |     |    section3  |
+ * +-v-+-v-+---+----+--v--+--v--+-----+-----+--v--+--v--+-----+-----+--v--+--v--+-----+-----+
+ * |   |   |   |    |     |     |     |     |     |     |     |     |     |     |     |     |
+ * |0:1|2:3|4:7|8:15|16:17|18:19|20:23|24:31|32:33|34:35|36:39|40:47|48:49|50:51|52:55|56:63|
+ * |   |   |   |    |     |     |     |     |     |     |     |     |     |     |     |     |
+ * +---+---+-^-+--^-+-----+-----+--^--+--^--+-----+-----+--^--+--^--+-----+-----+--^--+--^--+
+ *           |    |                |     |                 |     |                 |     |
+ *           |    +----------------|-----+-----------------|-----+-----------------|-----+
+ *           |             ECC Area|(Main + Spare) - filled|by ESMT NAND HW        |
+ *           |                     |                       |                       |
+ *           +---------------------+-----------------------+-----------------------+
+ *                         OOB ECC protected Area - not used due to
+ *                         partial programming from some filesystems
+ *                             (like JFFS2 with cleanmarkers)
+ */
+
+#define ESMT_OOB_SECTION_COUNT			4
+#define ESMT_OOB_SECTION_SIZE(nand) \
+	(nanddev_per_page_oobsize(nand) / ESMT_OOB_SECTION_COUNT)
+#define ESMT_OOB_FREE_SIZE(nand) \
+	(ESMT_OOB_SECTION_SIZE(nand) / 2)
+#define ESMT_OOB_ECC_SIZE(nand) \
+	(ESMT_OOB_SECTION_SIZE(nand) - ESMT_OOB_FREE_SIZE(nand))
+#define ESMT_OOB_BBM_SIZE			2
+
+static int f50l1g41lb_ooblayout_ecc(struct mtd_info *mtd, int section,
+				    struct mtd_oob_region *region)
+{
+	struct nand_device *nand = mtd_to_nanddev(mtd);
+
+	if (section >= ESMT_OOB_SECTION_COUNT)
+		return -ERANGE;
+
+	region->offset = section * ESMT_OOB_SECTION_SIZE(nand) +
+			 ESMT_OOB_FREE_SIZE(nand);
+	region->length = ESMT_OOB_ECC_SIZE(nand);
+
+	return 0;
+}
+
+static int f50l1g41lb_ooblayout_free(struct mtd_info *mtd, int section,
+				     struct mtd_oob_region *region)
+{
+	struct nand_device *nand = mtd_to_nanddev(mtd);
+
+	if (section >= ESMT_OOB_SECTION_COUNT)
+		return -ERANGE;
+
+	/*
+	 * Reserve space for bad blocks markers (section0) and
+	 * reserved bytes (sections 1-3)
+	 */
+	region->offset = section * ESMT_OOB_SECTION_SIZE(nand) + 2;
+
+	/* Use only 2 non-protected ECC bytes per each OOB section */
+	region->length = 2;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops f50l1g41lb_ooblayout = {
+	.ecc = f50l1g41lb_ooblayout_ecc,
+	.rfree = f50l1g41lb_ooblayout_free,
+};
+
+static const struct spinand_info esmt_c8_spinand_table[] = {
+	SPINAND_INFO("F50L1G41LB",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x01),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
+	SPINAND_INFO("F50D1G41LB",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x11),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
+};
+
+static const struct spinand_manufacturer_ops esmt_spinand_manuf_ops = {
+};
+
+const struct spinand_manufacturer esmt_c8_spinand_manufacturer = {
+	.id = SPINAND_MFR_ESMT_C8,
+	.name = "ESMT",
+	.chips = esmt_c8_spinand_table,
+	.nchips = ARRAY_SIZE(esmt_c8_spinand_table),
+	.ops = &esmt_spinand_manuf_ops,
+};
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index e8d6feb970..91e61ce864 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -251,6 +251,7 @@ extern const struct spinand_manufacturer micron_spinand_manufacturer;
 extern const struct spinand_manufacturer paragon_spinand_manufacturer;
 extern const struct spinand_manufacturer toshiba_spinand_manufacturer;
 extern const struct spinand_manufacturer winbond_spinand_manufacturer;
+extern const struct spinand_manufacturer esmt_c8_spinand_manufacturer;
 
 /**
  * struct spinand_op_variants - SPI NAND operation variants
-- 
2.34.1

