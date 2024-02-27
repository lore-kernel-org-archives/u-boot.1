Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92838C5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 16:25:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC0BD88039;
	Tue, 27 Feb 2024 17:25:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="ikEEJMTd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A431C87F37; Tue, 27 Feb 2024 11:05:06 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B023287F64
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 11:04:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 3AD75120550;
 Tue, 27 Feb 2024 13:04:58 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 3AD75120550
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1709028298;
 bh=zKZFprH8/tCHcKIr/KKupFDbPeIYAUI9SNVpstQPpm8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=ikEEJMTdeH3DPcVyWO08TgAbf91vJ1PLw3H8SH3C8xGiMdJzK3UdSBofqE9tGbldh
 IKz3X7zMa4qPwO+0HcAMVXEtM3rZdbalgArF31BhCK3RnSqX5TJN75tV4MJfYabWO9
 2Eei5ZqigoD3Lvp9uJGqUset3O7ikAwLEFtqgiwV0YHR3tHO3lMJwED0ZAbWzH/erm
 /ENAzu6Hxdm2jcTBwM+dSD3ajRtn9muQYgBXL2Jcpv3JpCCeLDuCdDoHjLkENpGyMd
 8DVgauxAcT0kyyQc1Eq9s2CHFYEKAOh5lKf6u+hvEJBGiQ6L3Xpsx/e5eMAITJRIQF
 zM2YaQBskfSxw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue, 27 Feb 2024 13:04:58 +0300 (MSK)
Received: from user-A520M-DS3H.sigma.sbrf.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 13:04:56 +0300
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
Subject: [PATCH v1 2/4] disk: support MTD partitions
Date: Tue, 27 Feb 2024 13:04:39 +0300
Message-ID: <20240227100441.1811047-3-avromanov@salutedevices.com>
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
 {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;
 smtp.sberdevices.ru:7.1.1,5.0.1; 127.0.0.199:7.1.2; salutedevices.com:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s,
 ApMailHostAddress: 100.64.160.123
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

Add new MTD partition driver, which can be useful with
mtdblock driver combination.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 disk/part.c           |  5 +++-
 drivers/mtd/Kconfig   |  1 +
 drivers/mtd/mtdpart.c | 69 +++++++++++++++++++++++++++++++++++++++++++
 include/part.h        |  2 ++
 4 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/disk/part.c b/disk/part.c
index 36b88205ec..0fc5cc0419 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -304,7 +304,8 @@ static void print_part_header(const char *type, struct blk_desc *desc)
 	CONFIG_IS_ENABLED(DOS_PARTITION) || \
 	CONFIG_IS_ENABLED(ISO_PARTITION) || \
 	CONFIG_IS_ENABLED(AMIGA_PARTITION) || \
-	CONFIG_IS_ENABLED(EFI_PARTITION)
+	CONFIG_IS_ENABLED(EFI_PARTITION) || \
+	CONFIG_IS_ENABLED(MTD_PARTITIONS)
 	puts ("\nPartition Map for ");
 	switch (desc->uclass_id) {
 	case UCLASS_IDE:
@@ -343,6 +344,8 @@ static void print_part_header(const char *type, struct blk_desc *desc)
 	case UCLASS_BLKMAP:
 		puts("BLKMAP");
 		break;
+	case UCLASS_MTD:
+		puts("MTD");
 	default:
 		printf("UNKNOWN(%d)", desc->uclass_id);
 		break;
diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 1902351719..40272f7e50 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -2,6 +2,7 @@ menu "MTD Support"
 
 config MTD_PARTITIONS
 	bool
+	select PARTITIONS
 
 config MTD
 	bool "Enable MTD layer"
diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 4886392a1c..608908c193 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -21,6 +21,8 @@
 
 #include <common.h>
 #include <malloc.h>
+#include <memalign.h>
+#include <part.h>
 #include <linux/bug.h>
 #include <linux/errno.h>
 #include <linux/compat.h>
@@ -1055,3 +1057,70 @@ uint64_t mtd_get_device_size(const struct mtd_info *mtd)
 	return mtd->size;
 }
 EXPORT_SYMBOL_GPL(mtd_get_device_size);
+
+static struct mtd_info *mtd_get_partition_by_index(struct mtd_info *mtd, int index)
+{
+	struct mtd_info *part;
+	int i = 0;
+
+	list_for_each_entry(part, &mtd->partitions, node)
+		if (i++ == index)
+			return part;
+
+	debug("Partition with idx=%d not found on MTD device %s\n", index, mtd->name);
+	return NULL;
+}
+
+static int __maybe_unused part_get_info_mtd(struct blk_desc *dev_desc, int part_idx,
+					    struct disk_partition *info)
+{
+	struct mtd_info *master = blk_desc_to_mtd(dev_desc);
+	struct mtd_info *part;
+
+	if (!master) {
+		pr_err("MTD device is NULL\n");
+		return -EINVAL;
+	}
+
+	part = mtd_get_partition_by_index(master, part_idx);
+	if (!part) {
+		debug("Failed to find partition with idx=%d\n", part_idx);
+		return -EINVAL;
+	}
+
+	snprintf(info->name, PART_NAME_LEN, part->name);
+	info->start = part->offset / dev_desc->blksz;
+	info->size = part->size / dev_desc->blksz;
+	info->blksz = dev_desc->blksz;
+
+	return 0;
+}
+
+static void __maybe_unused part_print_mtd(struct blk_desc *dev_desc)
+{
+	struct mtd_info *master = blk_desc_to_mtd(dev_desc);
+	struct mtd_info *part;
+
+	list_for_each_entry(part, &master->partitions, node)
+		printf("- 0x%012llx-0x%012llx : \"%s\"\n",
+		       part->offset, part->offset + part->size, part->name);
+}
+
+static int part_test_mtd(struct blk_desc *dev_desc)
+{
+	ALLOC_CACHE_ALIGN_BUFFER(unsigned char, buffer, dev_desc->blksz);
+
+	if (blk_dread(dev_desc, 0, 1, (ulong *)buffer) != 1)
+		return -1;
+
+	return 0;
+}
+
+U_BOOT_PART_TYPE(mtd) = {
+	.name		= "MTD",
+	.part_type	= PART_TYPE_MTD,
+	.max_entries	= MTD_ENTRY_NUMBERS,
+	.get_info	= part_get_info_ptr(part_get_info_mtd),
+	.print		= part_print_ptr(part_print_mtd),
+	.test		= part_test_mtd,
+};
diff --git a/include/part.h b/include/part.h
index db34bc6bb7..f7f3773a95 100644
--- a/include/part.h
+++ b/include/part.h
@@ -30,12 +30,14 @@ struct block_drvr {
 #define PART_TYPE_ISO		0x03
 #define PART_TYPE_AMIGA		0x04
 #define PART_TYPE_EFI		0x05
+#define PART_TYPE_MTD		0x06
 
 /* maximum number of partition entries supported by search */
 #define DOS_ENTRY_NUMBERS	8
 #define ISO_ENTRY_NUMBERS	64
 #define MAC_ENTRY_NUMBERS	64
 #define AMIGA_ENTRY_NUMBERS	8
+#define MTD_ENTRY_NUMBERS	64
 /*
  * Type string for U-Boot bootable partitions
  */
-- 
2.34.1

