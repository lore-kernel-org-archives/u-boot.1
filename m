Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF2DC25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 12:30:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 364AA888D6;
	Fri, 24 May 2024 14:28:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="XE17e5IV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA20E88646; Fri, 24 May 2024 13:13:56 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E912588647
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 13:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 76CDA10001F;
 Fri, 24 May 2024 14:13:53 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 76CDA10001F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1716549233;
 bh=DcMYF7Npu9xQJKLAMKPWXXb9W4gUvxQJ/kX+BdcvF4U=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=XE17e5IVYzhz7rbqhkpSSej6pXtfrWc+rMUOu/6o968/s93gy6nMOJdcE8oE1v2rA
 zpB6yIfcabNCzyLfyGhKbqo8/Vii1SOgVAnpGbaJsaxgMAanw9hjScrT3uqjy1yMJu
 ktuj5MNiJ5UlyWKH6J1euxhnTNsVej41HIS49w9ZKaMBOKLuBz0OPBwZw9GwdIT7aJ
 c6u+8qqw9x8iW7dVSFdurO0T4dYZOz/27uODNzvj+H+uE2AdT3gYDdo6Auhe3zF1Zh
 SUoLv4r/8Yd0GBd5JPC+pF7YjzM+nuCy9B9SZf/5qW+aZaJkprsJOxg/2sC6JvKK+4
 0E9i2ewKp9chw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Fri, 24 May 2024 14:13:53 +0300 (MSK)
Received: from user-A520M-DS3H.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 24 May 2024 14:13:52 +0300
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
Subject: [PATCH v3 5/6] disk: support UBI partitions
Date: Fri, 24 May 2024 14:13:18 +0300
Message-ID: <20240524111319.3512009-6-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524111319.3512009-1-avromanov@salutedevices.com>
References: <20240524111319.3512009-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185464 [May 24 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20
 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f,
 {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 100.64.160.123:7.1.2;
 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/05/24 05:57:00 #25251437
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Fri, 24 May 2024 14:28:51 +0200
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

UBI partition is abstraction over UBI volumes.
Can be used by UBI block device.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
Reviewed-by: Heiko Schocher <hs@denx.de>
---
 drivers/mtd/ubi/Makefile |  2 +-
 drivers/mtd/ubi/part.c   | 99 ++++++++++++++++++++++++++++++++++++++++
 include/part.h           |  2 +
 3 files changed, 102 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mtd/ubi/part.c

diff --git a/drivers/mtd/ubi/Makefile b/drivers/mtd/ubi/Makefile
index 67b1a05348..63dc428813 100644
--- a/drivers/mtd/ubi/Makefile
+++ b/drivers/mtd/ubi/Makefile
@@ -7,4 +7,4 @@ obj-y += attach.o build.o vtbl.o vmt.o upd.o kapi.o eba.o io.o wl.o crc32.o
 obj-$(CONFIG_MTD_UBI_FASTMAP) += fastmap.o
 obj-y += misc.o
 obj-y += debug.o
-obj-$(CONFIG_BLK) += block.o
+obj-$(CONFIG_BLK) += block.o part.o
diff --git a/drivers/mtd/ubi/part.c b/drivers/mtd/ubi/part.c
new file mode 100644
index 0000000000..8dd7b874af
--- /dev/null
+++ b/drivers/mtd/ubi/part.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2024 SaluteDevices, Inc.
+ *
+ * Author: Alexey Romanov <avromanov@salutedevices.com>
+ */
+
+#include <memalign.h>
+#include <part.h>
+#include <ubi_uboot.h>
+
+static inline struct ubi_device *get_ubi_device(void)
+{
+	return ubi_devices[0];
+}
+
+static struct ubi_volume *ubi_get_volume_by_index(int vol_id)
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
+			return volume;
+	}
+
+	return NULL;
+}
+
+static int __maybe_unused part_get_info_ubi(struct blk_desc *dev_desc, int part_idx,
+					    struct disk_partition *info)
+{
+	struct ubi_volume *vol;
+
+	/*
+	 * We must use part_idx - 1 instead of part_idx, because
+	 * part_get_info_by_name() start indexing at 1, not 0.
+	 * ubi volumes idexed starting at 0
+	 */
+	vol = ubi_get_volume_by_index(part_idx - 1);
+	if (!vol)
+		return 0;
+
+	snprintf(info->name, PART_NAME_LEN, vol->name);
+
+	info->start = 0;
+	info->size = vol->used_bytes / dev_desc->blksz;
+	info->blksz = dev_desc->blksz;
+
+	/* Save UBI volume ID in blk device descriptor */
+	dev_desc->hwpart = vol->vol_id;
+
+	return 0;
+}
+
+static void __maybe_unused part_print_ubi(struct blk_desc *dev_desc)
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
+		printf("%d: %s\n", volume->vol_id, volume->name);
+	}
+}
+
+static int part_test_ubi(struct blk_desc *dev_desc)
+{
+	ALLOC_CACHE_ALIGN_BUFFER(unsigned char, buffer, dev_desc->blksz);
+
+	if (blk_dread(dev_desc, 0, 1, (ulong *)buffer) != 1)
+		return -1;
+
+	return 0;
+}
+
+U_BOOT_PART_TYPE(ubi) = {
+	.name	= "ubi",
+	.part_type	= PART_TYPE_UBI,
+	.max_entries	= UBI_ENTRY_NUMBERS,
+	.get_info	= part_get_info_ptr(part_get_info_ubi),
+	.print	= part_print_ptr(part_print_ubi),
+	.test	= part_test_ubi,
+};
diff --git a/include/part.h b/include/part.h
index 40419fdf2f..72b98b3512 100644
--- a/include/part.h
+++ b/include/part.h
@@ -31,6 +31,7 @@ struct block_drvr {
 #define PART_TYPE_AMIGA		0x04
 #define PART_TYPE_EFI		0x05
 #define PART_TYPE_MTD		0x06
+#define PART_TYPE_UBI		0x07
 
 /* maximum number of partition entries supported by search */
 #define DOS_ENTRY_NUMBERS	8
@@ -38,6 +39,7 @@ struct block_drvr {
 #define MAC_ENTRY_NUMBERS	64
 #define AMIGA_ENTRY_NUMBERS	8
 #define MTD_ENTRY_NUMBERS	64
+#define UBI_ENTRY_NUMBERS	UBI_MAX_VOLUMES
 
 /*
  * Type string for U-Boot bootable partitions
-- 
2.34.1

