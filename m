Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4505CC83F11
	for <u-boot@archiver.kernel.org>; Sun, 27 Aug 2023 07:42:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47EC4846D0;
	Sun, 27 Aug 2023 09:42:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="sMA6mPSI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0639E84702; Sun, 27 Aug 2023 09:42:41 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D58780726
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 09:42:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-244-162.um16.pools.vodafone-ip.de
 [62.143.244.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 637D73F111; 
 Sun, 27 Aug 2023 07:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1693122157;
 bh=nWSE17OmTnnHgVjSI8Hxkq1CS2wiqeTjerfWbDA9r/M=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=sMA6mPSI3DA0EHwafGLtu7fMvlWqWusr8rp4DeBGxrQqj9HTCwo7U9YuoIIT3ERZC
 OckgfisPG0xaoS7XMtRd3lF3vK4j/7ypO0SrCd97kmGXWgo3V/Kqgrja9IKuv6aM7y
 Z8hLxNIXk4z4x72pa3J5fbQyiV+hGUJ+OhTvpH0WvHTJTdybWMsUgJ47sDXqMnlVUJ
 cIjGEfeXqpI6lj7IJb/vBX0E6if8MGZLU8vgUcmJQuiboOMf8ry3tmNSUa9TZKNDd+
 xxrgTW4rmLgD+pKk6MUPDKK6+8D75krPZ5yqjBoNdtDyvdNh3yAXDs//L540c9fQCM
 s/3YZfrQvcPMQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Joshua Watt <jpewhacker@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd: gpt: fix gpt read
Date: Sun, 27 Aug 2023 09:43:24 +0200
Message-Id: <20230827074324.34978-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

To partition a block device the partition type GUIDs are needed but 'gpt
read' does not provide these. Add the missing parts.

Part of gpt.c has been written to work with CONFIG_PARTITION_UUIDS=n. But
when reading the disk information this is not considered. Currently we let
CONFIG_CMD_GPT select CONFIG_PARTITION_UUIDS but we should enable dropping
this requirement.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/gpt.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/cmd/gpt.c b/cmd/gpt.c
index 964056bd28..d5d525397f 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -173,7 +173,10 @@ static int calc_parts_list_len(int numparts)
 	/* see part.h for definition of struct disk_partition */
 	partlistlen += numparts * (strlen("start=MiB,") + sizeof(lbaint_t) + 1);
 	partlistlen += numparts * (strlen("size=MiB,") + sizeof(lbaint_t) + 1);
-	partlistlen += numparts * (strlen("uuid=;") + UUID_STR_LEN + 1);
+	if (CONFIG_IS_ENABLED(PARTITION_UUIDS))
+		partlistlen += numparts * (strlen("uuid=,") + UUID_STR_LEN + 1);
+	if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID))
+		partlistlen += numparts * (strlen("type=;") + UUID_STR_LEN + 1);
 	/* for the terminating null */
 	partlistlen++;
 	debug("Length of partitions_list is %d for %d partitions\n", partlistlen,
@@ -217,6 +220,12 @@ static struct disk_part *allocate_disk_part(struct disk_partition *info,
 	/* UUID_STR_LEN is correct, as uuid[]'s length is UUID_STR_LEN+1 chars */
 	newpart->gpt_part_info.uuid[UUID_STR_LEN] = '\0';
 #endif
+#ifdef CONFIG_PARTITION_TYPE_GUID
+	strncpy(newpart->gpt_part_info.type_guid, (const char *)info->type_guid,
+		UUID_STR_LEN);
+	newpart->gpt_part_info.type_guid[UUID_STR_LEN] = '\0';
+#endif
+
 	newpart->partnum = partnum;
 
 	return newpart;
@@ -254,6 +263,9 @@ static void print_gpt_info(void)
 		       curr->gpt_part_info.bootable & PART_BOOTABLE);
 #ifdef CONFIG_PARTITION_UUIDS
 		printf("UUID %s\n", curr->gpt_part_info.uuid);
+#endif
+#ifdef CONFIG_PARTITION_TYPE_GUID
+		printf("Type GUID %s\n", curr->gpt_part_info.type_guid);
 #endif
 		printf("\n");
 	}
@@ -298,10 +310,16 @@ static int create_gpt_partitions_list(int numparts, const char *guid,
 			(unsigned long long)curr->gpt_part_info.size *
 					    curr->gpt_part_info.blksz);
 		strncat(partitions_list, partstr, PART_NAME_LEN + 1);
-
+#if CONFIG_IS_ENABLED(PARTITION_UUIDS)
 		strcat(partitions_list, ",uuid=");
 		strncat(partitions_list, curr->gpt_part_info.uuid,
 			UUID_STR_LEN + 1);
+#endif
+#ifdef CONFIG_PARTITION_TYPE_GUID
+		strcat(partitions_list, ",type=");
+		strncat(partitions_list, curr->gpt_part_info.type_guid,
+			UUID_STR_LEN + 1);
+#endif
 		strcat(partitions_list, ";");
 	}
 	return 0;
-- 
2.40.1

