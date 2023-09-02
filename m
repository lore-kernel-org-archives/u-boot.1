Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCCCCCA0FF6
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 07:34:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4DC986411;
	Sat,  2 Sep 2023 09:34:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="BhskPpA3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76123867B5; Sat,  2 Sep 2023 09:34:34 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAEE7863F9
 for <u-boot@lists.denx.de>; Sat,  2 Sep 2023 09:34:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-244-162.um16.pools.vodafone-ip.de
 [62.143.244.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 62BA542947; 
 Sat,  2 Sep 2023 07:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1693640069;
 bh=f/rmk9tuC/rVsfZpuhfHWqgTXdxeNHsSRhgbR9zK4NU=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=BhskPpA38P5vclRUVYqAzd6Udn2O0+d6mWOZIG6mYOrmRNMIQMdWCEU6R+8yQNxm8
 n3mPAFTlv16RKayo8e6IC0Aa6pAzHn7U7J5zXXpPvct2ibmb7IAVuE1Q16mSy4FPVK
 mro2X9o1XetQuLUFEdY9e8Y9RS6b4q4SlQdmwQ2FZEnS/BcrgqAgY5tIKvHBx4Z1Kf
 cZrZLL1nQjSlncp1RKNVM4oZLKBsuT0+7Ol+z0b219aMzgo+rGnumofg0U1y4426Ct
 lqk07h5Y4Ie1XhaTFtM+cvt70UegM7odpU0ZVDMYQHugsDvRrx9Sz0UgcV/AwJkKSI
 pWYKRUMlvGIPA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Joshua Watt <jpewhacker@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 2/4] cmd: gpt: use UUID accessor more consistently
Date: Sat,  2 Sep 2023 09:35:22 +0200
Message-Id: <20230902073524.87451-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230902073524.87451-1-heinrich.schuchardt@canonical.com>
References: <20230902073524.87451-1-heinrich.schuchardt@canonical.com>
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

disk_partition_uuid() and disk_partition_set_uuid() were introduced to let
us avoid the usage of #ifdef when dealing with the field uuid of
struct disk_partition.

In allocate_disk_part() commit c5f1d005f517 ("part: Add accessors for
struct disk_partition uuid") missed to use the setter.

print_gpt_info() and create_gpt_partitions_list() are further functions
where we should use the getter.

Fixes: c5f1d005f517 ("part: Add accessors for struct disk_partition uuid")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	new patch
---
 cmd/gpt.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/cmd/gpt.c b/cmd/gpt.c
index 8969efba8c..092f7defff 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -211,10 +211,9 @@ static struct disk_part *allocate_disk_part(struct disk_partition *info,
 		PART_TYPE_LEN);
 	newpart->gpt_part_info.type[PART_TYPE_LEN - 1] = '\0';
 	newpart->gpt_part_info.bootable = info->bootable;
-	if (IS_ENABLED(CONFIG_PARTITION_UUIDS)) {
-		strlcpy(newpart->gpt_part_info.uuid, disk_partition_uuid(info),
-			UUID_STR_LEN + 1);
-	}
+	if (IS_ENABLED(CONFIG_PARTITION_UUIDS))
+		disk_partition_set_uuid(&newpart->gpt_part_info,
+					disk_partition_uuid(info));
 	newpart->partnum = partnum;
 
 	return newpart;
@@ -250,9 +249,9 @@ static void print_gpt_info(void)
 		       curr->gpt_part_info.name);
 		printf("Type %s, bootable %d\n", curr->gpt_part_info.type,
 		       curr->gpt_part_info.bootable & PART_BOOTABLE);
-#ifdef CONFIG_PARTITION_UUIDS
-		printf("UUID %s\n", curr->gpt_part_info.uuid);
-#endif
+		if (CONFIG_IS_ENABLED(PARTITION_UUIDS))
+			printf("UUID %s\n",
+			       disk_partition_uuid(&curr->gpt_part_info));
 		printf("\n");
 	}
 }
@@ -296,10 +295,12 @@ static int create_gpt_partitions_list(int numparts, const char *guid,
 			(unsigned long long)curr->gpt_part_info.size *
 					    curr->gpt_part_info.blksz);
 		strncat(partitions_list, partstr, PART_NAME_LEN + 1);
-
-		strcat(partitions_list, ",uuid=");
-		strncat(partitions_list, curr->gpt_part_info.uuid,
-			UUID_STR_LEN + 1);
+		if (CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
+			strcat(partitions_list, ",uuid=");
+			strncat(partitions_list,
+				disk_partition_uuid(&curr->gpt_part_info),
+				UUID_STR_LEN + 1);
+		}
 		strcat(partitions_list, ";");
 	}
 	return 0;
-- 
2.40.1

