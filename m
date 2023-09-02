Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B500BCA0FF8
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 07:34:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 912A286758;
	Sat,  2 Sep 2023 09:34:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="PtWu3Qnu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12CF9847D9; Sat,  2 Sep 2023 09:34:32 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DF5D85894
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
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 0433942946; 
 Sat,  2 Sep 2023 07:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1693640069;
 bh=sXbzqCgUWFFRHYO1nu/M+AgsvymyCMZGwRm3t2BADm0=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=PtWu3QnuPdG+QOvEsi3Y03bIWTnG+fCIC+6D8r2kPoYkBdln1BIyWyD9g9sOR6Ehw
 iOzpSzZFCGiIUo/5CJMeXQhGcPBCYjOsElJhKhAB4lIr17mq1mT7X7YUVp6O0TfiBJ
 gxobVqRiAA/iFWXlaDto/xGaSfFJdqSc0xzzsrfElwLUBUu6s4/XYUAk5zivLMPgTf
 nag2t/mmMaxuVU2C86hYPZsUcnjOUG+UB2hssmkZsOf6SHEM4QX/HE13i83Xmxs3um
 Flw9A/taen5oV8qQ7DWzzbcHunMit0/Q8OmVzZgNDP8RCVHy0n87CHQT1fS6QQJ+9s
 //X8DvFGTnZ6g==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Joshua Watt <jpewhacker@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/4] part: rename disk_partition_type_uuid()
Date: Sat,  2 Sep 2023 09:35:21 +0200
Message-Id: <20230902073524.87451-2-heinrich.schuchardt@canonical.com>
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

Rename disk_partition_type_uuid to disk_partition_type_guid.

Provide function descriptions for the getter and setter.

Fixes: bcd645428c34 ("part: Add accessors for struct disk_partition type_uuid")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	new patch
---
 disk/part_efi.c |  2 +-
 include/part.h  | 26 +++++++++++++++++++++++---
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/disk/part_efi.c b/disk/part_efi.c
index 39382c5fae..b7aef3731b 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -299,7 +299,7 @@ int part_get_info_efi(struct blk_desc *desc, int part,
 	}
 	if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID)) {
 		uuid_bin_to_str(gpt_pte[part - 1].partition_type_guid.b,
-				(char *)disk_partition_type_uuid(info),
+				(char *)disk_partition_type_guid(info),
 				UUID_STR_FORMAT_GUID);
 	}
 
diff --git a/include/part.h b/include/part.h
index f321479a5e..db34bc6bb7 100644
--- a/include/part.h
+++ b/include/part.h
@@ -108,18 +108,38 @@ static inline void disk_partition_clr_uuid(struct disk_partition *info)
 }
 
 /* Accessors for struct disk_partition field ->type_guid */
-extern char *__invalid_use_of_disk_partition_type_uuid;
+extern char *__invalid_use_of_disk_partition_type_guid;
 
+/**
+ * disk_partition_type_guid() - get partition type GUID
+ *
+ * By using this function to get the partition type GUID we can use
+ * 'if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID))' instead of
+ * '#ifdef CONFIG_PARTITION_TYPE_GUID'.
+ *
+ * @info:	partition information
+ * Return:	partition type GUID
+ */
 static inline const
-char *disk_partition_type_uuid(const struct disk_partition *info)
+char *disk_partition_type_guid(const struct disk_partition *info)
 {
 #ifdef CONFIG_PARTITION_TYPE_GUID
 	return info->type_guid;
 #else
-	return __invalid_use_of_disk_partition_type_uuid;
+	return __invalid_use_of_disk_partition_type_guid;
 #endif
 }
 
+/**
+ * disk_partition_set_type_guid() - set partition type GUID
+ *
+ * By using this function to set the partition type GUID we can use
+ * 'if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID))' instead of
+ * '#ifdef CONFIG_PARTITION_TYPE_GUID'.
+ *
+ * @info:	partition information
+ * @val:	partition type GUID as string
+ */
 static inline void disk_partition_set_type_guid(struct disk_partition *info,
 						const char *val)
 {
-- 
2.40.1

