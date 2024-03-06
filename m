Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87091C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 13:52:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36F6287FA5;
	Wed,  6 Mar 2024 14:51:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="VZifOtT4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9CFF87916; Wed,  6 Mar 2024 14:49:35 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAEF987D9B
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 14:49:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 7BE35100023;
 Wed,  6 Mar 2024 16:49:29 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7BE35100023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1709732969;
 bh=5jtII+h7q1/aAlp90Ne3AWtzmgszZFsp70QyXUrHj8Y=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=VZifOtT4WtROBF7RnMluAkvFWQzc/LjoweOkyZ1T0ISedbp7w45Q1+vEAVBgaGGJF
 S+1RF5/YNjWFnNyiQ2QEnpP0IzZnyeGuHmX8gLpQwHzPsz0V0Qgxzaz0ZB9fEVQ1SM
 IvVZ/m241DRXjDw71OqjMxM8OLLVNCI+VohKG8IlX8yDsSlArzIht5Fc3m6ocRpRds
 iYrSh7drhogAn2ja2W6xmXM6kDG/46tac9NGKGoEathERMIhtpCmN2tJnL2Drkhydf
 tnsa9DJw4QiBX/rhB2t4C2RDXi/mZRrLyrzE/FPrAoijevVT227227VhD+r4vbLU+I
 HsoahxwWc36aA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed,  6 Mar 2024 16:49:29 +0300 (MSK)
Received: from user-A520M-DS3H.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Mar 2024 16:49:27 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <dario.binacchi@amarulasolutions.com>, <michael@amarulasolutions.com>,
 <frieder.schrempf@kontron.de>, <kmpark@infradead.org>, <hs@denx.de>,
 <joe.hershberger@ni.com>, <dunaev@tecon.ru>, <sjg@chromium.org>,
 <bmeng@tinylab.org>, <xypron.glpk@gmx.de>, <tobias@waldekranz.com>,
 <jpewhacker@gmail.com>, <marek.vasut+renesas@mailbox.org>,
 <kever.yang@rock-chips.com>, <jbx6244@gmail.com>,
 <abdellatif.elkhlifi@arm.com>, <mikhail.kshevetskiy@iopsys.eu>,
 <jagan@amarulasolutions.com>
CC: <kernel@salutedevices.com>, <u-boot@lists.denx.de>, Alexey Romanov
 <avromanov@salutedevices.com>
Subject: [PATCH v1 3/6] drivers: introduce UBI block abstraction
Date: Wed, 6 Mar 2024 16:49:03 +0300
Message-ID: <20240306134906.1179285-4-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306134906.1179285-1-avromanov@salutedevices.com>
References: <20240306134906.1179285-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183875 [Feb 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7
 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a,
 {Tracking_from_domain_doesnt_match_to}, FromAlignment: s,
 ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/02/29 19:21:00 #23899999
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Wed, 06 Mar 2024 14:51:44 +0100
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

UBI block is an virtual device, that runs on top
of the MTD layer. The blocks are UBI volumes.
Intended to be used in combination with other MTD
drivers.

Despite the fact that it, like mtdblock abstraction,
it used with UCLASS_MTD, they can be used together
on the system without conflicting. For example,
using bcb command:

  # Trying to load bcb via mtdblock:
  $ bcb load mtd 0 mtd_partition_name

  # Trying to load bcb via UBI block:
  $ bcb load ubi 1 ubi_volume_name

User always must attach UBI layer (for example, using
ubi_part()) before using UBI block device.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/block/blk-uclass.c |   1 +
 drivers/mtd/ubi/Makefile   |   1 +
 drivers/mtd/ubi/block.c    | 130 +++++++++++++++++++++++++++++++++++++
 include/ubi_uboot.h        |   4 ++
 4 files changed, 136 insertions(+)
 create mode 100644 drivers/mtd/ubi/block.c

diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
index ab0a9105c9..8a457e9f70 100644
--- a/drivers/block/blk-uclass.c
+++ b/drivers/block/blk-uclass.c
@@ -38,6 +38,7 @@ static struct {
 	{ UCLASS_BLKMAP, "blkmap" },
 	{ UCLASS_RKMTD, "rkmtd" },
 	{ UCLASS_MTD, "mtd" },
+	{ UCLASS_MTD, "ubi" },
 };
 
 static enum uclass_id uclass_name_to_iftype(const char *uclass_idname)
diff --git a/drivers/mtd/ubi/Makefile b/drivers/mtd/ubi/Makefile
index 30d00fbdfe..67b1a05348 100644
--- a/drivers/mtd/ubi/Makefile
+++ b/drivers/mtd/ubi/Makefile
@@ -7,3 +7,4 @@ obj-y += attach.o build.o vtbl.o vmt.o upd.o kapi.o eba.o io.o wl.o crc32.o
 obj-$(CONFIG_MTD_UBI_FASTMAP) += fastmap.o
 obj-y += misc.o
 obj-y += debug.o
+obj-$(CONFIG_BLK) += block.o
diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
new file mode 100644
index 0000000000..95d5ef5752
--- /dev/null
+++ b/drivers/mtd/ubi/block.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2024 SaluteDevices, Inc.
+ *
+ * Author: Alexey Romanov <avromanov@salutedevices.com>
+ */
+
+#include <blk.h>
+#include <part.h>
+#include <ubi_uboot.h>
+#include <dm/device.h>
+#include <dm/device-internal.h>
+
+int ubi_bind(struct udevice *dev)
+{
+	struct blk_desc *bdesc;
+	struct udevice *bdev;
+	int ret;
+
+	ret = blk_create_devicef(dev, "ubi_blk", "blk", UCLASS_MTD,
+				 dev_seq(dev), 512, 0, &bdev);
+	if (ret) {
+		pr_err("Cannot create block device");
+		return ret;
+	}
+
+	bdesc = dev_get_uclass_plat(bdev);
+
+	bdesc->bdev = bdev;
+	bdesc->part_type = PART_TYPE_UBI;
+
+	return 0;
+}
+
+static struct ubi_device *get_ubi_device(void)
+{
+	return ubi_devices[0];
+}
+
+static char *get_volume_name(int vol_id)
+{
+	struct ubi_device *ubi = get_ubi_device();
+	int i;
+
+	for (i = 0; i < (ubi->vtbl_slots + 1); i++) {
+		struct ubi_volume *volume = ubi->volumes[i];
+
+		if (!volume)
+			continue;
+
+		if (volume->vol_id >= UBI_INTERNAL_VOL_START)
+			continue;
+
+		if (volume->vol_id == vol_id)
+			return volume->name;
+	}
+
+	return NULL;
+}
+
+static ulong ubi_bread(struct udevice *dev, lbaint_t start, lbaint_t blkcnt,
+		       void *dst)
+{
+	struct blk_desc *block_dev = dev_get_uclass_plat(dev);
+	char *volume_name = get_volume_name(block_dev->hwpart);
+	unsigned int size = blkcnt * block_dev->blksz;
+	loff_t offset = start * block_dev->blksz;
+	int ret;
+
+	if (!volume_name) {
+		pr_err("%s: failed to find volume name for blk=%ld", __func__, start);
+		return -EINVAL;
+	}
+
+	ret = ubi_volume_read(volume_name, dst, offset, size);
+	if (ret) {
+		pr_err("%s: failed to read from %s UBI volume\n", __func__, volume_name);
+		return ret;
+	}
+
+	return blkcnt;
+}
+
+static ulong ubi_bwrite(struct udevice *dev, lbaint_t start, lbaint_t blkcnt,
+			const void *src)
+{
+	struct blk_desc *block_dev = dev_get_uclass_plat(dev);
+	char *volume_name = get_volume_name(block_dev->hwpart);
+	unsigned int size = blkcnt * block_dev->blksz;
+	loff_t offset = start * block_dev->blksz;
+	int ret;
+
+	if (!volume_name) {
+		pr_err("%s: failed to find volume for blk=%ld", __func__, start);
+		return -EINVAL;
+	}
+
+	ret = ubi_volume_write(volume_name, (void *)src, offset, size);
+	if (ret) {
+		pr_err("%s: failed to write from %s UBI volume\n", __func__, volume_name);
+		return ret;
+	}
+
+	return blkcnt;
+}
+
+static int ubi_blk_probe(struct udevice *dev)
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
+static const struct blk_ops ubi_blk_ops = {
+	.read = ubi_bread,
+	.write = ubi_bwrite,
+};
+
+U_BOOT_DRIVER(ubi_blk) = {
+	.name = "ubi_blk",
+	.id = UCLASS_BLK,
+	.ops = &ubi_blk_ops,
+	.probe = ubi_blk_probe,
+};
diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
index 5f046b91a2..ff06d8005d 100644
--- a/include/ubi_uboot.h
+++ b/include/ubi_uboot.h
@@ -56,4 +56,8 @@ extern struct ubi_device *ubi_devices[];
 int cmd_ubifs_mount(char *vol_name);
 int cmd_ubifs_umount(void);
 
+#if IS_ENABLED(CONFIG_BLK)
+int ubi_bind(struct udevice *dev);
+#endif
+
 #endif
-- 
2.34.1

