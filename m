Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5CDC5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 16:25:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC9968801F;
	Tue, 27 Feb 2024 17:25:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="rwK7aPtI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00AA587EF3; Tue, 27 Feb 2024 11:04:59 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4A9087F37
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 11:04:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 2025D100533;
 Tue, 27 Feb 2024 13:04:56 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2025D100533
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1709028296;
 bh=wtsBqsVjkgXPtKWyeZValZqGaudld3koUMxS0Lb0kgQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=rwK7aPtIe7HZQAJzmYzXhdhLq/MUL6eRcBazT8v3ccsLCSHGDwJxsPE+eSLqXUDSo
 klnqj+25bjd6L66LDovy/KZye+5FNTdmbzDYcGaCDno6rspQhdaUVKBFTsJ2w4rhmp
 uTQ0+K1g/BM5sZG8ARH78Y3pLWq/6pL9Tskk6aCuncg7ohw3KtZdYgoEOCcucUZgZV
 2grei7rw89oMNu8gFyqFwnqVNRI4fpO5+q7cehOAIeMMUU8mW9W4EUPL3c69q/Jq87
 vFMOjkcmpg2fDCXrpBwQGxnSOOeYkleSm8L4hHBiuyocV6O0u0oihK3TB626SgMJF7
 p2+s9LqO3y2CA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue, 27 Feb 2024 13:04:55 +0300 (MSK)
Received: from user-A520M-DS3H.sigma.sbrf.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 13:04:54 +0300
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
Subject: [PATCH v1 1/4] drivers: introduce mtdblock abstraction
Date: Tue, 27 Feb 2024 13:04:38 +0300
Message-ID: <20240227100441.1811047-2-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227100441.1811047-1-avromanov@salutedevices.com>
References: <20240227100441.1811047-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183764 [Feb 27 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7
 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a,
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 100.64.160.123:7.1.2; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 127.0.0.199:7.1.2;
 smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, ApMailHostAddress:
 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/02/27 05:19:00 #23841006
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Tue, 27 Feb 2024 17:25:20 +0100
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

- Read algorithm:

  1. Convert start block number to start address.
  2. Read block_dev->blksz bytes using mtd_read() and
     add to start address pointer block_dev->blksz bytes,
     until the requested number of blocks have been read.

- Write algorithm:

  1. Convert start block number to start address.
  2. Round this address down by mtd->erasesize.

  Erase addr      Start addr
     |                |
     v                v
     +----------------+----------------+----------------+
     |     blksz      |      blksz     |      blksz     |
     +----------------+----------------+----------------+

  3. Calculate offset between this two addresses.
  4. Read mtd->erasesize bytes using mtd_read() into
     temporary buffer from erase address.

  Erase addr      Start addr
     |                |
     v                v
     +----------------+----------------+----------------+
     |     blksz      |      blksz     |      blksz     |
     +----------------+----------------+----------------+
     ^            mtd->erasesize = blksz * 3
     |
     |
     |

  mtd_read()
  from here

  5. Copy data from user buffer to temporary buffer with offset,
     calculated at step 3.
  6. Erase and write mtd->erasesize bytes at erase address
     pointer using mtd_erase/mtd_write().
  7. Add to erase address pointer mtd->erasesize bytes.
  8. goto 1 until the requested number of blocks have
     been written.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/block/blk-uclass.c |   1 +
 drivers/mtd/Makefile       |   1 +
 drivers/mtd/mtdblock.c     | 170 +++++++++++++++++++++++++++++++++++++
 include/linux/mtd/mtd.h    |  12 +++
 4 files changed, 184 insertions(+)
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
index c638980ea2..993b122ac4 100644
--- a/drivers/mtd/Makefile
+++ b/drivers/mtd/Makefile
@@ -26,6 +26,7 @@ obj-y += onenand/
 obj-y += spi/
 obj-$(CONFIG_MTD_UBI) += ubi/
 obj-$(CONFIG_NVMXIP) += nvmxip/
+obj-$(CONFIG_BLK) += mtdblock.o
 
 #SPL/TPL build
 else
diff --git a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
new file mode 100644
index 0000000000..0563d0b795
--- /dev/null
+++ b/drivers/mtd/mtdblock.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2024 SaluteDevices, Inc.
+ *
+ * Author: Alexey Romanov <avromanov@salutedevices.com>
+ */
+
+#include <blk.h>
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
+				 dev_seq(dev), 512, 0, &bdev);
+	if (ret) {
+		pr_err("Cannot create block device");
+		return ret;
+	}
+
+	bdesc = dev_get_uclass_plat(bdev);
+	dev_set_priv(bdev, mtd);
+	bdesc->bdev = bdev;
+
+	return 0;
+}
+
+static ulong mtd_bread(struct udevice *dev, lbaint_t start, lbaint_t blkcnt,
+		       void *dst)
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
+			pr_err("mtdblock: failed to read block 0x%lx\n", cur);
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
+static ulong mtd_bwrite(struct udevice *dev, lbaint_t start, lbaint_t blkcnt,
+			const void *src)
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
+			pr_err("mtdblock: failed to read block 0x%lx\n", cur);
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
+	int ret;
+
+	ret = device_probe(dev);
+	if (ret) {
+		pr_err("Probing %s failed (err=%d)\n", dev->name, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct blk_ops mtd_blk_ops = {
+	.read = mtd_bread,
+	.write = mtd_bwrite,
+};
+
+U_BOOT_DRIVER(mtd_blk) = {
+	.name = "mtd_blk",
+	.id = UCLASS_BLK,
+	.ops = &mtd_blk_ops,
+	.probe = mtd_blk_probe,
+};
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 09f5269887..9b997fadd1 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -26,6 +26,9 @@
 #include <dm/device.h>
 #endif
 #include <dm/ofnode.h>
+#if IS_ENABLED(CONFIG_BLK)
+#include <blk.h>
+#endif
 
 #define MAX_MTD_DEVICES 32
 #endif
@@ -412,6 +415,15 @@ int mtd_write(struct mtd_info *mtd, loff_t to, size_t len, size_t *retlen,
 int mtd_panic_write(struct mtd_info *mtd, loff_t to, size_t len, size_t *retlen,
 		    const u_char *buf);
 
+#if IS_ENABLED(CONFIG_BLK)
+static inline struct mtd_info *blk_desc_to_mtd(struct blk_desc *bdesc)
+{
+	return *((struct mtd_info **)dev_get_priv(bdesc->bdev));
+}
+
+int mtd_bind(struct udevice *dev, struct mtd_info **mtd);
+#endif
+
 int mtd_read_oob(struct mtd_info *mtd, loff_t from, struct mtd_oob_ops *ops);
 int mtd_write_oob(struct mtd_info *mtd, loff_t to, struct mtd_oob_ops *ops);
 
-- 
2.34.1

