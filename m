Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E89CA0FF8
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 07:35:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2887E867B5;
	Sat,  2 Sep 2023 09:34:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="H4DBltuD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DAAE863F9; Sat,  2 Sep 2023 09:34:34 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD3C186453
 for <u-boot@lists.denx.de>; Sat,  2 Sep 2023 09:34:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-244-162.um16.pools.vodafone-ip.de
 [62.143.244.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 18EF04295E; 
 Sat,  2 Sep 2023 07:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1693640070;
 bh=dxq37FYPfo2mOIKV2Vd8QWDLO/5PP6437u3N/NHKfTU=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=H4DBltuDYyUWtHrBpATW16BSJJLcmpszSj7b4c3c55yraH9fHcAU6lcObsTbhw8vb
 R1El+H3p91NG2ZluMx/1X3EaLPcUhpxbxFoMRlzCrmVgA7sCuoIn/q0DtrQS7tvBcE
 /tecLPwUrbSfX/dyZAjekGzeDiTYRZnIsLpuy6ghQwAj5Z5lt/u1cXtwFrtwu0MKuo
 mNIxu+jAWwn968ryQgxgAHyAnnzaFJGkpbZnEli0a4DwHCWQ7xlScV3cjES/W3kR3S
 24UncxQMTay/bG2tdF2OWhf+nDAt4vrjw4pFwT+JtgDs0n1q6LHmLxAxLT7S6NBAh0
 sHg13j0gQ7sNQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Joshua Watt <jpewhacker@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 4/4] cmd: gpt: fix gpt read
Date: Sat,  2 Sep 2023 09:35:24 +0200
Message-Id: <20230902073524.87451-5-heinrich.schuchardt@canonical.com>
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

To partition a block device the partition type GUIDs are needed but
'gpt read' does not provide these. Add the missing parts.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	use accessor for type_guid field
---
 cmd/gpt.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/cmd/gpt.c b/cmd/gpt.c
index e7a53747fc..8e1de24845 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -182,7 +182,9 @@ static int calc_parts_list_len(int numparts)
 	partlistlen += numparts * (strlen("start=0x,") + lbaint_size);
 	partlistlen += numparts * (strlen("size=0x,") + lbaint_size);
 	if (IS_ENABLED(CONFIG_PARTITION_UUIDS))
-		partlistlen += numparts * (strlen("uuid=;") + UUID_STR_LEN);
+		partlistlen += numparts * (strlen("uuid=,") + UUID_STR_LEN);
+	if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID))
+		partlistlen += numparts * (strlen("type=;") + UUID_STR_LEN);
 	debug("Length of partitions_list is %d for %d partitions\n",
 	      partlistlen, numparts);
 	return partlistlen;
@@ -221,6 +223,9 @@ static struct disk_part *allocate_disk_part(struct disk_partition *info,
 	if (IS_ENABLED(CONFIG_PARTITION_UUIDS))
 		disk_partition_set_uuid(&newpart->gpt_part_info,
 					disk_partition_uuid(info));
+	if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID))
+		disk_partition_set_type_guid(&newpart->gpt_part_info,
+					     disk_partition_type_guid(info));
 	newpart->partnum = partnum;
 
 	return newpart;
@@ -259,6 +264,9 @@ static void print_gpt_info(void)
 		if (CONFIG_IS_ENABLED(PARTITION_UUIDS))
 			printf("UUID %s\n",
 			       disk_partition_uuid(&curr->gpt_part_info));
+		if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID))
+			printf("Type GUID %s\n",
+			       disk_partition_type_guid(&curr->gpt_part_info));
 		printf("\n");
 	}
 }
@@ -308,6 +316,12 @@ static int create_gpt_partitions_list(int numparts, const char *guid,
 				disk_partition_uuid(&curr->gpt_part_info),
 				UUID_STR_LEN + 1);
 		}
+		if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID)) {
+			strcat(partitions_list, ",type=");
+			strncat(partitions_list,
+				disk_partition_type_guid(&curr->gpt_part_info),
+				UUID_STR_LEN + 1);
+		}
 		strcat(partitions_list, ";");
 	}
 	return 0;
-- 
2.40.1

