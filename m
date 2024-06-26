Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84B2C30653
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 12:30:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5348B8850B;
	Wed, 26 Jun 2024 14:29:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="v0oloWYK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5169388096; Wed, 26 Jun 2024 12:44:58 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30DD888216
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 12:44:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id B33B2100014;
 Wed, 26 Jun 2024 13:44:55 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B33B2100014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1719398695;
 bh=BaZxKL8bi1ClzqvrvudGys/6xJaJYlH/ZKnljnCGi44=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=v0oloWYKY5/RrK2UVIMerfjY6RMAtV8eXF3vZxMbjZ3hnT0PKcSd9Fbwc1VSP3ydH
 awSsQy/0HBJefaMxHN0GeuGPh/OeqM+KGoP6S1bmvx6m7obR9RW8YEwgft9vK7l107
 kvJARfTjzKBFd1/FpU8WV07Q4+dCAqGfN74sdzpAfNrqseX6X4qAYbhCLngiXwT81C
 K/zKk5TeqV/RksJqX8CDdXEkGVMIxqKpg4BZ5MB7XOJWdkPxImIxaPqIQyVbmW7V1v
 Tc9J+qY/yTr4eXZxgejrEcSmQVs5T0DhfbBNubkWw9cbq+Il5beLMQYM6pv85uR0Ys
 rqxyNkil+f2jQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed, 26 Jun 2024 13:44:55 +0300 (MSK)
Received: from user-A520M-DS3H.sigma.sbrf.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 26 Jun 2024 13:44:53 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <dario.binacchi@amarulasolutions.com>, <michael@amarulasolutions.com>,
 <frieder.schrempf@kontron.de>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>, <bmeng@tinylab.org>,
 <tobias@waldekranz.com>, <jpewhacker@gmail.com>,
 <marek.vasut+renesas@mailbox.org>, <kever.yang@rock-chips.com>,
 <jbx6244@gmail.com>, <abdellatif.elkhlifi@arm.com>, <michal.simek@amd.com>,
 <mikhail.kshevetskiy@iopsys.eu>, <patrice.chotard@foss.st.com>
CC: <kernel@salutedevices.com>, <u-boot@lists.denx.de>, Alexey Romanov
 <avromanov@salutedevices.com>
Subject: [PATCH v6 2/3] drivers: introduce mtdblock abstraction
Date: Wed, 26 Jun 2024 13:44:39 +0300
Message-ID: <20240626104440.2811686-3-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626104440.2811686-1-avromanov@salutedevices.com>
References: <20240626104440.2811686-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186156 [Jun 26 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20
 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f,
 {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; salutedevices.com:7.1.1;
 127.0.0.199:7.1.2;
 100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/06/26 09:49:00 #25717626
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Wed, 26 Jun 2024 14:29:28 +0200
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

MTD block - abstraction over MTD subsystem, allowing
to read and write in blocks using BLK UCLASS.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/block/blk-uclass.c |   1 +
 drivers/mtd/Makefile       |   3 +
 drivers/mtd/mtdblock.c     | 227 +++++++++++++++++++++++++++++++++++++
 include/linux/mtd/mtd.h    |  25 ++++
 4 files changed, 256 insertions(+)
 create mode 100644 drivers/mtd/mtdblock.c

diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
index 77066da352..ab0a9105c9 100644
--- a/drivers/block/blk-uclass.c
+++ b/drivers/block/blk-uclass.c
@@ -37,6 +37,7 @@ static struct {
 	{ UCLASS_PVBLOCK, "pvblock" },
 	{ UCLASS_BLKMAP, "blkmap" },
 	{ UCLASS_RKMTD, "rkmtd" },
+	{ UCLASS_MTD, "mtd" },
 };
 
 static enum uclass_id uclass_name_to_iftype(const char *uclass_idname)
diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
index c2fc80b10f..d87b4d32a5 100644
--- a/drivers/mtd/Makefile
+++ b/drivers/mtd/Makefile
@@ -26,6 +26,9 @@ obj-y += onenand/
 obj-y += spi/
 obj-$(CONFIG_MTD_UBI) += ubi/
 obj-$(CONFIG_NVMXIP) += nvmxip/
+ifdef CONFIG_MTD
+obj-$(CONFIG_BLK) += mtdblock.o
+endif
 
 #SPL/TPL build
 else
diff --git a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
new file mode 100644
index 0000000000..66a79b8c56
--- /dev/null
+++ b/drivers/mtd/mtdblock.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * MTD block - abstraction over MTD subsystem, allowing
+ * to read and write in blocks using BLK UCLASS.
+ *
+ * - Read algorithm:
+ *
+ *   1. Convert start block number to start address.
+ *   2. Read block_dev->blksz bytes using mtd_read() and
+ *      add to start address pointer block_dev->blksz bytes,
+ *      until the requested number of blocks have been read.
+ *
+ * - Write algorithm:
+ *
+ *   1. Convert start block number to start address.
+ *   2. Round this address down by mtd->erasesize.
+ *
+ *   Erase addr      Start addr
+ *      |                |
+ *      v                v
+ *      +----------------+----------------+----------------+
+ *      |     blksz      |      blksz     |      blksz     |
+ *      +----------------+----------------+----------------+
+ *
+ *   3. Calculate offset between this two addresses.
+ *   4. Read mtd->erasesize bytes using mtd_read() into
+ *      temporary buffer from erase address.
+ *
+ *   Erase addr      Start addr
+ *      |                |
+ *      v                v
+ *      +----------------+----------------+----------------+
+ *      |     blksz      |      blksz     |      blksz     |
+ *      +----------------+----------------+----------------+
+ *      ^
+ *      |
+ *      |
+ *   mtd_read()
+ *   from here
+ *
+ *   5. Copy data from user buffer to temporary buffer with offset,
+ *      calculated at step 3.
+ *   6. Erase and write mtd->erasesize bytes at erase address
+ *      pointer using mtd_erase/mtd_write().
+ *   7. Add to erase address pointer mtd->erasesize bytes.
+ *   8. goto 1 until the requested number of blocks have
+ *      been written.
+ *
+ * (C) Copyright 2024 SaluteDevices, Inc.
+ *
+ * Author: Alexey Romanov <avromanov@salutedevices.com>
+ */
+
+#include <blk.h>
+#include <part.h>
+#include <dm/device.h>
+#include <dm/device-internal.h>
+#include <linux/mtd/mtd.h>
+
+int mtd_bind(struct udevice *dev, struct mtd_info **mtd)
+{
+	struct blk_desc *bdesc;
+	struct udevice *bdev;
+	int ret;
+
+	ret = blk_create_devicef(dev, "mtd_blk", "blk", UCLASS_MTD,
+				 -1, 512, 0, &bdev);
+	if (ret) {
+		pr_err("Cannot create block device\n");
+		return ret;
+	}
+
+	bdesc = dev_get_uclass_plat(bdev);
+	dev_set_priv(bdev, mtd);
+	bdesc->bdev = bdev;
+	bdesc->part_type = PART_TYPE_MTD;
+
+	return 0;
+}
+
+static ulong mtd_blk_read(struct udevice *dev, lbaint_t start, lbaint_t blkcnt,
+			  void *dst)
+{
+	struct blk_desc *block_dev = dev_get_uclass_plat(dev);
+	struct mtd_info *mtd = blk_desc_to_mtd(block_dev);
+	unsigned int sect_size = block_dev->blksz;
+	lbaint_t cur = start;
+	ulong read_cnt = 0;
+
+	while (read_cnt < blkcnt) {
+		int ret;
+		loff_t sect_start = cur * sect_size;
+		size_t retlen;
+
+		ret = mtd_read(mtd, sect_start, sect_size, &retlen, dst);
+		if (ret)
+			return ret;
+
+		if (retlen != sect_size) {
+			pr_err("mtdblock: failed to read block 0x" LBAF "\n", cur);
+			return -EIO;
+		}
+
+		cur++;
+		dst += sect_size;
+		read_cnt++;
+	}
+
+	return read_cnt;
+}
+
+static int mtd_erase_write(struct mtd_info *mtd, uint64_t start, const void *src)
+{
+	int ret;
+	size_t retlen;
+	struct erase_info erase = { 0 };
+
+	erase.mtd = mtd;
+	erase.addr = start;
+	erase.len = mtd->erasesize;
+
+	ret = mtd_erase(mtd, &erase);
+	if (ret)
+		return ret;
+
+	ret = mtd_write(mtd, start, mtd->erasesize, &retlen, src);
+	if (ret)
+		return ret;
+
+	if (retlen != mtd->erasesize) {
+		pr_err("mtdblock: failed to read block at 0x%llx\n", start);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static ulong mtd_blk_write(struct udevice *dev, lbaint_t start, lbaint_t blkcnt,
+			   const void *src)
+{
+	struct blk_desc *block_dev = dev_get_uclass_plat(dev);
+	struct mtd_info *mtd = blk_desc_to_mtd(block_dev);
+	unsigned int sect_size = block_dev->blksz;
+	lbaint_t cur = start, blocks_todo = blkcnt;
+	ulong write_cnt = 0;
+	u8 *buf;
+	int ret = 0;
+
+	buf = malloc(mtd->erasesize);
+	if (!buf)
+		return -ENOMEM;
+
+	while (blocks_todo > 0) {
+		loff_t sect_start = cur * sect_size;
+		loff_t erase_start = ALIGN_DOWN(sect_start, mtd->erasesize);
+		u32 offset = sect_start - erase_start;
+		size_t cur_size = min_t(size_t,  mtd->erasesize - offset,
+					blocks_todo * sect_size);
+		size_t retlen;
+		lbaint_t written;
+
+		ret = mtd_read(mtd, erase_start, mtd->erasesize, &retlen, buf);
+		if (ret)
+			goto out;
+
+		if (retlen != mtd->erasesize) {
+			pr_err("mtdblock: failed to read block 0x" LBAF "\n", cur);
+			ret = -EIO;
+			goto out;
+		}
+
+		memcpy(buf + offset, src, cur_size);
+
+		ret = mtd_erase_write(mtd, erase_start, buf);
+		if (ret)
+			goto out;
+
+		written = cur_size / sect_size;
+
+		blocks_todo -= written;
+		cur += written;
+		src += cur_size;
+		write_cnt += written;
+	}
+
+out:
+	free(buf);
+
+	if (ret)
+		return ret;
+
+	return write_cnt;
+}
+
+static int mtd_blk_probe(struct udevice *dev)
+{
+	struct blk_desc *bdesc;
+	struct mtd_info *mtd;
+	int ret;
+
+	ret = device_probe(dev);
+	if (ret) {
+		pr_err("Probing %s failed (err=%d)\n", dev->name, ret);
+		return ret;
+	}
+
+	bdesc = dev_get_uclass_plat(dev);
+	mtd = blk_desc_to_mtd(bdesc);
+
+	if (mtd_type_is_nand(mtd))
+		pr_warn("MTD device '%s' is NAND, please use UBI devices instead\n",
+			mtd->name);
+
+	return 0;
+}
+
+static const struct blk_ops mtd_blk_ops = {
+	.read = mtd_blk_read,
+	.write = mtd_blk_write,
+};
+
+U_BOOT_DRIVER(mtd_blk) = {
+	.name = "mtd_blk",
+	.id = UCLASS_BLK,
+	.ops = &mtd_blk_ops,
+	.probe = mtd_blk_probe,
+};
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index ee18a63e46..4a3c393471 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -26,6 +26,7 @@
 #include <dm/device.h>
 #endif
 #include <dm/ofnode.h>
+#include <blk.h>
 
 #define MAX_MTD_DEVICES 32
 #endif
@@ -412,6 +413,30 @@ int mtd_write(struct mtd_info *mtd, loff_t to, size_t len, size_t *retlen,
 int mtd_panic_write(struct mtd_info *mtd, loff_t to, size_t len, size_t *retlen,
 		    const u_char *buf);
 
+#if CONFIG_IS_ENABLED(BLK)
+static inline struct mtd_info *blk_desc_to_mtd(struct blk_desc *bdesc)
+{
+	void *priv = dev_get_priv(bdesc->bdev);
+
+	if (!priv)
+		return NULL;
+
+	return *((struct mtd_info **)priv);
+}
+
+int mtd_bind(struct udevice *dev, struct mtd_info **mtd);
+#else
+static inline struct mtd_info *blk_desc_to_mtd(struct blk_desc *bdesc)
+{
+	return NULL;
+}
+
+static inline int mtd_bind(struct udevice *dev, struct mtd_info **mtd)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 int mtd_read_oob(struct mtd_info *mtd, loff_t from, struct mtd_oob_ops *ops);
 int mtd_write_oob(struct mtd_info *mtd, loff_t to, struct mtd_oob_ops *ops);
 
-- 
2.34.1

