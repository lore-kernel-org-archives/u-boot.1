Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F20C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:55:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A85A588580;
	Thu, 25 Jul 2024 22:55:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="vBL4rxLf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DD7288297; Thu, 25 Jul 2024 21:47:30 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A806882EF
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 21:47:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ddrokosov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id A4C00120009;
 Thu, 25 Jul 2024 22:47:25 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru A4C00120009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1721936845;
 bh=yel7jkLdkPnr7ZtrMHkILNiQYxSe/sCv6CzytFRizWo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=vBL4rxLf6bolv/arSYXiPRpse/eeldhXKemBaYCj9JaPBEnytVerz6zEcFZsavp9W
 qJshpwKV9aYXvYeKeBAcRi+iLi0MWGPntjYzJUogfldu/pNhytpQENCYw0m4S4lh5+
 as2dhnOY6JnTemaHZ8nOwEpy3k2sFAN6edDP9RqXSWyy91C0nXuXpjWQadJEdyiw/e
 vOr1aRopfmSegQ+x8S6Tz+V3ysGowDhwfjtMqcRlYXIyg02FuLP3o0OXG3UL5hBo0G
 G29hoPOSfmEz7SEr5TzsT+FvTVuceLxrrnFre6E0/cC1/V66ZKWWqeYlnxKqQzXcWS
 vsi290EbIwggA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 25 Jul 2024 22:47:25 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 25 Jul 2024 22:47:25 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <igor.opaniuk@gmail.com>, <mkorpershoek@baylibre.com>,
 <semen.protsenko@linaro.org>, <trini@konsulko.com>,
 <colin.mcallister@garmin.com>, <4.shket@gmail.com>,
 <avromanov@salutedevices.com>
CC: <u-boot@lists.denx.de>, <kernel@salutedevices.com>, <rockosov@gmail.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v1 2/4] cmd: ab: introduce 'ab_dump' command to print BCB
 block content
Date: Thu, 25 Jul 2024 22:47:02 +0300
Message-ID: <20240725194716.32232-3-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725194716.32232-1-ddrokosov@salutedevices.com>
References: <20240725194716.32232-1-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186723 [Jul 25 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24
 186c4d603b899ccfd4883d230c53f273b80e467f,
 {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;
 127.0.0.199:7.1.2; salutedevices.com:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/07/25 17:13:00 #26148857
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 25 Jul 2024 22:55:09 +0200
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

Command 'ab_dump' prints all fields of bootloader_control struct
including slot_metadata for all presented slots.

Output example:
=====
> board# ab_dump ubi 0#misc
> Read 512 bytes from volume misc to 000000000bf51900
> Bootloader Control: 	[misc]
> Active Slot: 		_a
> Magic Number: 		0x42414342
> Version: 		1
> Number of Slots: 	2
> Recovery Tries Remaining: 7
> CRC: 			0x61378F6F (Valid)
>
> Slot[0] Metadata:
> 	- Priority: 		15
> 	- Tries Remaining: 	4
> 	- Successful Boot: 	0
> 	- Verity Corrupted: 	0
>
> Slot[1] Metadata:
> 	- Priority: 		15
> 	- Tries Remaining: 	5
> 	- Successful Boot: 	0
> 	- Verity Corrupted: 	0
====

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 boot/android_ab.c    | 68 ++++++++++++++++++++++++++++++++++++++++++++
 cmd/ab_select.c      | 30 +++++++++++++++++++
 include/android_ab.h |  9 ++++++
 3 files changed, 107 insertions(+)

diff --git a/boot/android_ab.c b/boot/android_ab.c
index 1e5aa81b7503..359cc1a00428 100644
--- a/boot/android_ab.c
+++ b/boot/android_ab.c
@@ -363,3 +363,71 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
 
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
+	printf("Bootloader Control: \t[%s]\n", part_info->name);
+	printf("Active Slot: \t\t%s\n", abc->slot_suffix);
+	printf("Magic Number: \t\t0x%X\n", abc->magic);
+	printf("Version: \t\t%u\n", abc->version);
+	printf("Number of Slots: \t%u\n", abc->nb_slot);
+	printf("Recovery Tries Remaining: %u\n", abc->recovery_tries_remaining);
+
+	printf("CRC: \t\t\t0x%.8X", abc->crc32_le);
+
+	crc32_le = ab_control_compute_crc(abc);
+	if (abc->crc32_le != crc32_le)
+		printf(" (Invalid, Expected: \t0x%.8X)\n", crc32_le);
+	else
+		printf(" (Valid)\n");
+
+	for (i = 0; i < abc->nb_slot; ++i) {
+		slot = &abc->slot_info[i];
+		printf("\nSlot[%d] Metadata:\n", i);
+		printf("\t- Priority: \t\t%u\n", slot->priority);
+		printf("\t- Tries Remaining: \t%u\n", slot->tries_remaining);
+		printf("\t- Successful Boot: \t%u\n", slot->successful_boot);
+		printf("\t- Verity Corrupted: \t%u\n", slot->verity_corrupted);
+	}
+
+error:
+	free(abc);
+
+	return ret;
+}
diff --git a/cmd/ab_select.c b/cmd/ab_select.c
index 9e2f74573c22..1d34150ceea9 100644
--- a/cmd/ab_select.c
+++ b/cmd/ab_select.c
@@ -51,6 +51,31 @@ static int do_ab_select(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_SUCCESS;
 }
 
+static int do_ab_dump(struct cmd_tbl *cmdtp, int flag, int argc,
+		      char *const argv[])
+{
+	int ret;
+	struct blk_desc *dev_desc;
+	struct disk_partition part_info;
+
+	if (argc < 3)
+		return CMD_RET_USAGE;
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
 U_BOOT_CMD(ab_select, 5, 0, do_ab_select,
 	   "Select the slot used to boot from and register the boot attempt.",
 	   "<slot_var_name> <interface> <dev[:part|#part_name]> [--no-dec]\n"
@@ -66,3 +91,8 @@ U_BOOT_CMD(ab_select, 5, 0, do_ab_select,
 	   "    - If '--no-dec' is set, the number of tries remaining will not\n"
 	   "      decremented for the selected boot slot\n"
 );
+
+U_BOOT_CMD(ab_dump, 3, 0, do_ab_dump,
+	   "Dump boot_control information from specific partition.",
+	   "<interface> <dev[:part|#part_name]>\n"
+);
diff --git a/include/android_ab.h b/include/android_ab.h
index 1fee7582b90a..e53bf7eb6a02 100644
--- a/include/android_ab.h
+++ b/include/android_ab.h
@@ -33,4 +33,13 @@ struct disk_partition;
 int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
                    bool dec_tries);
 
+/**
+ * Dump ABC information for specific partition.
+ *
+ * @param[in] dev_desc Device description pointer
+ * @param[in] part_info Partition information
+ * Return: 0 on success, or a negative on error
+ */
+int ab_dump_abc(struct blk_desc *dev_desc, struct disk_partition *part_info);
+
 #endif /* __ANDROID_AB_H */
-- 
2.43.0

