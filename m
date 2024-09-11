Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334E8EE57DB
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 21:51:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9215F88C90;
	Wed, 11 Sep 2024 23:50:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="HU4cjHKj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5AE488BD6; Wed, 11 Sep 2024 23:50:05 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AE8388BDE
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 23:50:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ddrokosov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 1A89A10002B;
 Thu, 12 Sep 2024 00:49:58 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 1A89A10002B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1726091398;
 bh=taWkRd46l4CTGbnK6pAiZZY8wGmzgNuDKE+R15ECkzk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=HU4cjHKj21oiv+fN9hDoenkP3p1qTq7TS0e2WEDw9R4ltOTM33zgFBL6rKohhb4xh
 AXuLtDGNFerk/vnwx7fA4FZrCT/iXmEzTvTU9F1DihEemjcUNiX9rQ9mZcX6UWBZZC
 U0wn8xr4MFh0HnsPpN59Xr/aWpMpv1Yovar5/mzOxCuSIKL2GQDlcfvSAH+9BuRm5o
 Q9eUrkpw7rAcMzx6PPeOq1gFOyv3di2flnX733Qg3OKWj1ILawhiihO+GJ38iKqlAC
 EDXZG0c8UPu75xte+/6t8rm/9MDRJ1N7aVndnWbDfR3NrGnrYgH0BChD4Y1qEObmQ/
 km4C797zZWsZw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 12 Sep 2024 00:49:57 +0300 (MSK)
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <igor.opaniuk@gmail.com>, <mkorpershoek@baylibre.com>, <sjg@chromium.org>, 
 <semen.protsenko@linaro.org>, <trini@konsulko.com>,
 <colin.mcallister@garmin.com>, <4.shket@gmail.com>,
 <avromanov@salutedevices.com>
CC: <u-boot@lists.denx.de>, <kernel@salutedevices.com>, <rockosov@gmail.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v2 4/6] cmd: bcb: introduce 'ab_dump' command to print BCB
 block content
Date: Thu, 12 Sep 2024 00:49:12 +0300
Message-ID: <20240911214945.15873-5-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240911214945.15873-1-ddrokosov@salutedevices.com>
References: <20240911214945.15873-1-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.28.192.196]
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187695 [Sep 12 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 32 0.3.32
 766319f57b3d5e49f2c79a76e7d7087b621090df,
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; smtp.sberdevices.ru:7.1.1,5.0.1;
 127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/09/11 19:25:00 #26555689
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

It's really helpful to have the ability to dump BCB block for debugging
A/B logic on the board supported this partition schema.

Command 'bcb ab_dump' prints all fields of bootloader_control struct
including slot_metadata for all presented slots.

Output example:
=====
> board# bcb ab_dump ubi 0#misc
> Read 512 bytes from volume misc to 000000000bf07580
> Read 512 bytes from volume misc to 000000000bf42f40
> Bootloader Control:       [misc]
> Active Slot:              _a
> Magic Number:             0x42414342
> Version:                  1
> Number of Slots:          2
> Recovery Tries Remaining: 0
> CRC:                      0x2c8b50bc (Valid)
>
> Slot[0] Metadata:
> 	- Priority:         15
> 	- Tries Remaining:  0
> 	- Successful Boot:  1
> 	- Verity Corrupted: 0
>
> Slot[1] Metadata:
> 	- Priority:         14
> 	- Tries Remaining:  7
> 	- Successful Boot:  0
> 	- Verity Corrupted: 0
====

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 boot/android_ab.c    | 68 ++++++++++++++++++++++++++++++++++++++++++++
 cmd/bcb.c            | 35 +++++++++++++++++++++++
 include/android_ab.h | 10 +++++++
 3 files changed, 113 insertions(+)

diff --git a/boot/android_ab.c b/boot/android_ab.c
index 0045c8133a8e..c93e51541019 100644
--- a/boot/android_ab.c
+++ b/boot/android_ab.c
@@ -372,3 +372,71 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
 
 	return slot;
 }
+
+int ab_dump_abc(struct blk_desc *dev_desc, struct disk_partition *part_info)
+{
+	struct bootloader_control *abc;
+	u32 crc32_le;
+	int i, ret;
+	struct slot_metadata *slot;
+
+	if (!dev_desc || !part_info) {
+		log_err("ANDROID: Empty device descriptor or partition info\n");
+		return -EINVAL;
+	}
+
+	ret = ab_control_create_from_disk(dev_desc, part_info, &abc, 0);
+	if (ret < 0) {
+		log_err("ANDROID: Cannot create bcb from disk %d\n", ret);
+		return ret;
+	}
+
+	if (abc->magic != BOOT_CTRL_MAGIC) {
+		log_err("ANDROID: Unknown A/B metadata: %.8x\n", abc->magic);
+		ret = -ENODATA;
+		goto error;
+	}
+
+	if (abc->version > BOOT_CTRL_VERSION) {
+		log_err("ANDROID: Unsupported A/B metadata version: %.8x\n",
+			abc->version);
+		ret = -ENODATA;
+		goto error;
+	}
+
+	if (abc->nb_slot > ARRAY_SIZE(abc->slot_info)) {
+		log_err("ANDROID: Wrong number of slots %u, expected %zu\n",
+			abc->nb_slot, ARRAY_SIZE(abc->slot_info));
+		ret = -ENODATA;
+		goto error;
+	}
+
+	printf("Bootloader Control:       [%s]\n", part_info->name);
+	printf("Active Slot:              %s\n", abc->slot_suffix);
+	printf("Magic Number:             0x%x\n", abc->magic);
+	printf("Version:                  %u\n", abc->version);
+	printf("Number of Slots:          %u\n", abc->nb_slot);
+	printf("Recovery Tries Remaining: %u\n", abc->recovery_tries_remaining);
+
+	printf("CRC:                      0x%.8x", abc->crc32_le);
+
+	crc32_le = ab_control_compute_crc(abc);
+	if (abc->crc32_le != crc32_le)
+		printf(" (Invalid, Expected: 0x%.8x)\n", crc32_le);
+	else
+		printf(" (Valid)\n");
+
+	for (i = 0; i < abc->nb_slot; ++i) {
+		slot = &abc->slot_info[i];
+		printf("\nSlot[%d] Metadata:\n", i);
+		printf("\t- Priority:         %u\n", slot->priority);
+		printf("\t- Tries Remaining:  %u\n", slot->tries_remaining);
+		printf("\t- Successful Boot:  %u\n", slot->successful_boot);
+		printf("\t- Verity Corrupted: %u\n", slot->verity_corrupted);
+	}
+
+error:
+	free(abc);
+
+	return ret;
+}
diff --git a/cmd/bcb.c b/cmd/bcb.c
index a888549eed3a..d69f6df05e15 100644
--- a/cmd/bcb.c
+++ b/cmd/bcb.c
@@ -25,6 +25,7 @@ enum bcb_cmd {
 	BCB_CMD_FIELD_DUMP,
 	BCB_CMD_STORE,
 	BCB_CMD_AB_SELECT,
+	BCB_CMD_AB_DUMP,
 };
 
 static const char * const fields[] = {
@@ -56,6 +57,8 @@ static int bcb_cmd_get(char *cmd)
 		return BCB_CMD_FIELD_DUMP;
 	if (!strcmp(cmd, "ab_select"))
 		return BCB_CMD_AB_SELECT;
+	if (!strcmp(cmd, "ab_dump"))
+		return BCB_CMD_AB_DUMP;
 	else
 		return -1;
 }
@@ -93,6 +96,10 @@ static int bcb_is_misused(int argc, char *const argv[])
 		if (argc != 4 && argc != 5)
 			goto err;
 		return 0;
+	case BCB_CMD_AB_DUMP:
+		if (argc != 3)
+			goto err;
+		return 0;
 	default:
 		printf("Error: 'bcb %s' not supported\n", argv[0]);
 		return -1;
@@ -460,6 +467,28 @@ static int do_bcb_ab_select(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_SUCCESS;
 }
 
+static int do_bcb_ab_dump(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	int ret;
+	struct blk_desc *dev_desc;
+	struct disk_partition part_info;
+
+	if (part_get_info_by_dev_and_name_or_num(argv[1], argv[2],
+						 &dev_desc, &part_info,
+						 false) < 0) {
+		return CMD_RET_FAILURE;
+	}
+
+	ret = ab_dump_abc(dev_desc, &part_info);
+	if (ret < 0) {
+		printf("Cannot dump ABC data, error %d.\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
 static struct cmd_tbl cmd_bcb_sub[] = {
 	U_BOOT_CMD_MKENT(load, CONFIG_SYS_MAXARGS, 1, do_bcb_load, "", ""),
 	U_BOOT_CMD_MKENT(set, CONFIG_SYS_MAXARGS, 1, do_bcb_set, "", ""),
@@ -469,6 +498,8 @@ static struct cmd_tbl cmd_bcb_sub[] = {
 	U_BOOT_CMD_MKENT(store, CONFIG_SYS_MAXARGS, 1, do_bcb_store, "", ""),
 	U_BOOT_CMD_MKENT(ab_select, CONFIG_SYS_MAXARGS, 1,
 			 do_bcb_ab_select, "", ""),
+	U_BOOT_CMD_MKENT(ab_dump, CONFIG_SYS_MAXARGS, 1,
+			 do_bcb_ab_dump, "", ""),
 };
 
 static int do_bcb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
@@ -522,4 +553,8 @@ U_BOOT_CMD(
 	"      the partition table. This is commonly the \"misc\" partition.\n"
 	"    - If '--no-dec' is set, the number of tries remaining will not\n"
 	"      decremented for the selected boot slot\n"
+	"\n"
+	"bcb ab_dump -\n"
+	"    Dump boot_control information from specific partition.\n"
+	"    <interface> <dev[:part|#part_name]>\n"
 );
diff --git a/include/android_ab.h b/include/android_ab.h
index 1e53879a25f1..838230e06f8c 100644
--- a/include/android_ab.h
+++ b/include/android_ab.h
@@ -36,4 +36,14 @@ struct disk_partition;
 int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
                    bool dec_tries);
 
+/**
+ * ab_dump_abc() - Dump ABC information for specific partition.
+ *
+ * @dev_desc: Device description pointer
+ * @part_info: Partition information
+ *
+ * Return: 0 on success, or a negative on error
+ */
+int ab_dump_abc(struct blk_desc *dev_desc, struct disk_partition *part_info);
+
 #endif /* __ANDROID_AB_H */
-- 
2.43.0

