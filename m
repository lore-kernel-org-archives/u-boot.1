Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB7EC6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:57:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B076869EA;
	Thu, 24 Aug 2023 21:56:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CWI0PRbC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6EC1869C2; Thu, 24 Aug 2023 21:56:11 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC4CC869B7
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-7909307ecd1so6797139f.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692906966; x=1693511766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oe0qaReqkmedDJ2yYf6XkbQoItq8L36xltNLcEGO/Ys=;
 b=CWI0PRbCBp4MVAmHl9i8DhcE9smWdeGC5TWpCwDUr4MW66JmRMukQNJS9H/zImWAbr
 vv+nfdK6vJz5k2kaH5v1Mcj9yLS7IfbDSpoUXuV+s26CBMyerubM2QBfpUryw/amXlKj
 wqbvHZYPxZJwu3DZCbBbZcJUsD2E5K9gEWtGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692906966; x=1693511766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oe0qaReqkmedDJ2yYf6XkbQoItq8L36xltNLcEGO/Ys=;
 b=ODRq/AH85PrieB1PKibfnFZIiTVop10BMLbF913krNzCHfZFr398NNig/jDch25Q3I
 WkFfpRlBx94LkV/pnVkhCyiVq+q6APIq0j+CqQ0ZIQIfmH+UI4IvIP7HAUru/5FmmCSj
 RaAXwc+Q1jMV4v2CyAdwg/4UfXFehnTGPG6OXwf9TFluGh1RtgZIkqFDBOhkOPjCFfzr
 LWkWYhBw3fz0I96cu1WuUyjyrYI2EiJcp08VdwGFQSBIDUVcq9Szv+BTRD3gETm5rQlX
 E5BPJWQAbDUbATNcectx9F51ZHVOLesVAhzJ+gYW765T/l2vNbJKy90YfM81vpQcKP3C
 eKNg==
X-Gm-Message-State: AOJu0Yz4TF+v4KwgoyQ0EaNoPejkaXeLnM+3CLrsttIYcfCjxqer0ao8
 eKcXaW0K7AQ1+pJa79ohZNO/0eJgaEsmlFR12Po=
X-Google-Smtp-Source: AGHT+IHSKbJi6QdUgY04GkTQ+ANUj9sNdFZuCIDdDESQRegni+pmJqS7rY1Crd0gGf1G6zQmOF581g==
X-Received: by 2002:a6b:f107:0:b0:791:1e87:b47a with SMTP id
 e7-20020a6bf107000000b007911e87b47amr7779020iog.14.1692906966510; 
 Thu, 24 Aug 2023 12:56:06 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 b22-20020a6be716000000b007925328d6ddsm12734ioh.20.2023.08.24.12.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:56:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 08/23] part: Add accessors for struct disk_partition uuid
Date: Thu, 24 Aug 2023 13:55:31 -0600
Message-ID: <20230824195553.1685996-9-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824195553.1685996-1-sjg@chromium.org>
References: <20230824195553.1685996-1-sjg@chromium.org>
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

This field is only present when a CONFIG is set. To avoid annoying #ifdefs
in the source code, add accessors. Update all code to use it.

Note that the accessor is optional. It can be omitted if it is known that
the option is enabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/gpt.c       | 10 ++++------
 disk/part.c     |  8 ++------
 disk/part_dos.c | 17 ++++++++---------
 disk/part_efi.c | 31 ++++++++++++++++---------------
 fs/fat/fat.c    |  4 +---
 include/part.h  | 27 +++++++++++++++++++++++++++
 6 files changed, 58 insertions(+), 39 deletions(-)

diff --git a/cmd/gpt.c b/cmd/gpt.c
index 007a68eaa72a..8969efba8c80 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -211,12 +211,10 @@ static struct disk_part *allocate_disk_part(struct disk_partition *info,
 		PART_TYPE_LEN);
 	newpart->gpt_part_info.type[PART_TYPE_LEN - 1] = '\0';
 	newpart->gpt_part_info.bootable = info->bootable;
-#ifdef CONFIG_PARTITION_UUIDS
-	strncpy(newpart->gpt_part_info.uuid, (const char *)info->uuid,
-		UUID_STR_LEN);
-	/* UUID_STR_LEN is correct, as uuid[]'s length is UUID_STR_LEN+1 chars */
-	newpart->gpt_part_info.uuid[UUID_STR_LEN] = '\0';
-#endif
+	if (IS_ENABLED(CONFIG_PARTITION_UUIDS)) {
+		strlcpy(newpart->gpt_part_info.uuid, disk_partition_uuid(info),
+			UUID_STR_LEN + 1);
+	}
 	newpart->partnum = partnum;
 
 	return newpart;
diff --git a/disk/part.c b/disk/part.c
index 9190e8806187..91c6ac42cc83 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -368,10 +368,8 @@ int part_get_info_by_type(struct blk_desc *desc, int part, int part_type,
 	struct part_driver *drv;
 
 	if (blk_enabled()) {
-#if CONFIG_IS_ENABLED(PARTITION_UUIDS)
 		/* The common case is no UUID support */
-		info->uuid[0] = 0;
-#endif
+		disk_partition_clr_uuid(info);
 #ifdef CONFIG_PARTITION_TYPE_GUID
 		info->type_guid[0] = 0;
 #endif
@@ -416,9 +414,7 @@ int part_get_info_whole_disk(struct blk_desc *desc,
 	info->bootable = 0;
 	strcpy((char *)info->type, BOOT_PART_TYPE);
 	strcpy((char *)info->name, "Whole Disk");
-#if CONFIG_IS_ENABLED(PARTITION_UUIDS)
-	info->uuid[0] = 0;
-#endif
+	disk_partition_clr_uuid(info);
 #ifdef CONFIG_PARTITION_TYPE_GUID
 	info->type_guid[0] = 0;
 #endif
diff --git a/disk/part_dos.c b/disk/part_dos.c
index cc050ca8c49f..33374384373a 100644
--- a/disk/part_dos.c
+++ b/disk/part_dos.c
@@ -231,10 +231,8 @@ static int part_get_info_extended(struct blk_desc *desc,
 		return -1;
 	}
 
-#if CONFIG_IS_ENABLED(PARTITION_UUIDS)
-	if (!ext_part_sector)
+	if (CONFIG_IS_ENABLED(PARTITION_UUIDS) && !ext_part_sector)
 		disksig = get_unaligned_le32(&buffer[DOS_PART_DISKSIG_OFFSET]);
-#endif
 
 	ret = part_get_info_whole_disk(desc, &wdinfo);
 	if (ret)
@@ -263,9 +261,12 @@ static int part_get_info_extended(struct blk_desc *desc,
 			/* sprintf(info->type, "%d, pt->sys_ind); */
 			strcpy((char *)info->type, "U-Boot");
 			info->bootable = get_bootable(pt);
-#if CONFIG_IS_ENABLED(PARTITION_UUIDS)
-			sprintf(info->uuid, "%08x-%02x", disksig, part_num);
-#endif
+			if (CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
+				char str[12];
+
+				sprintf(str, "%08x-%02x", disksig, part_num);
+				disk_partition_set_uuid(info, str);
+			}
 			info->sys_ind = pt->sys_ind;
 			return 0;
 		}
@@ -302,9 +303,7 @@ static int part_get_info_extended(struct blk_desc *desc,
 			info->blksz = DOS_PART_DEFAULT_SECTOR;
 		info->bootable = 0;
 		strcpy((char *)info->type, "U-Boot");
-#if CONFIG_IS_ENABLED(PARTITION_UUIDS)
-		info->uuid[0] = 0;
-#endif
+		disk_partition_clr_uuid(info);
 		return 0;
 	}
 
diff --git a/disk/part_efi.c b/disk/part_efi.c
index 4ac21868d088..a6f7375cd38a 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -289,10 +289,11 @@ int part_get_info_efi(struct blk_desc *desc, int part,
 		 print_efiname(&gpt_pte[part - 1]));
 	strcpy((char *)info->type, "U-Boot");
 	info->bootable = get_bootable(&gpt_pte[part - 1]);
-#if CONFIG_IS_ENABLED(PARTITION_UUIDS)
-	uuid_bin_to_str(gpt_pte[part - 1].unique_partition_guid.b, info->uuid,
-			UUID_STR_FORMAT_GUID);
-#endif
+	if (CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
+		uuid_bin_to_str(gpt_pte[part - 1].unique_partition_guid.b,
+				(char *)disk_partition_uuid(info),
+				UUID_STR_FORMAT_GUID);
+	}
 #ifdef CONFIG_PARTITION_TYPE_GUID
 	uuid_bin_to_str(gpt_pte[part - 1].partition_type_guid.b,
 			info->type_guid, UUID_STR_FORMAT_GUID);
@@ -415,10 +416,7 @@ int gpt_fill_pte(struct blk_desc *desc,
 			le64_to_cpu(gpt_h->last_usable_lba);
 	int i, k;
 	size_t efiname_len, dosname_len;
-#if CONFIG_IS_ENABLED(PARTITION_UUIDS)
-	char *str_uuid;
 	unsigned char *bin_uuid;
-#endif
 #ifdef CONFIG_PARTITION_TYPE_GUID
 	char *str_type_guid;
 	unsigned char *bin_type_guid;
@@ -487,16 +485,19 @@ int gpt_fill_pte(struct blk_desc *desc,
 			&partition_basic_data_guid, 16);
 #endif
 
-#if CONFIG_IS_ENABLED(PARTITION_UUIDS)
-		str_uuid = partitions[i].uuid;
-		bin_uuid = gpt_e[i].unique_partition_guid.b;
+		if (CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
+			const char *str_uuid;
+
+			str_uuid = disk_partition_uuid(&partitions[i]);
+			bin_uuid = gpt_e[i].unique_partition_guid.b;
 
-		if (uuid_str_to_bin(str_uuid, bin_uuid, UUID_STR_FORMAT_GUID)) {
-			log_debug("Partition no. %d: invalid guid: %s\n",
-				  i, str_uuid);
-			return -EINVAL;
+			if (uuid_str_to_bin(str_uuid, bin_uuid,
+					    UUID_STR_FORMAT_GUID)) {
+				log_debug("Partition no. %d: invalid guid: %s\n",
+					  i, str_uuid);
+				return -EINVAL;
+			}
 		}
-#endif
 
 		/* partition attributes */
 		memset(&gpt_e[i].attributes, 0,
diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index d1476aa433d6..8ff1fd0ec835 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -110,9 +110,7 @@ int fat_register_device(struct blk_desc *dev_desc, int part_no)
 		info.name[0] = 0;
 		info.type[0] = 0;
 		info.bootable = 0;
-#if CONFIG_IS_ENABLED(PARTITION_UUIDS)
-		info.uuid[0] = 0;
-#endif
+		disk_partition_clr_uuid(&info);
 	}
 
 	return fat_set_blk_dev(dev_desc, &info);
diff --git a/include/part.h b/include/part.h
index 3a6be75421dd..8e5e543c56ec 100644
--- a/include/part.h
+++ b/include/part.h
@@ -80,6 +80,33 @@ struct disk_partition {
 #endif
 };
 
+/* Accessors for struct disk_partition field ->uuid */
+extern char *__invalid_use_of_disk_partition_uuid;
+
+static inline const char *disk_partition_uuid(const struct disk_partition *info)
+{
+#if CONFIG_IS_ENABLED(PARTITION_UUIDS)
+	return info->uuid;
+#else
+	return __invalid_use_of_disk_partition_uuid;
+#endif
+}
+
+static inline void disk_partition_set_uuid(struct disk_partition *info,
+					   const char *val)
+{
+#if CONFIG_IS_ENABLED(PARTITION_UUIDS)
+	strlcpy(info->uuid, val, UUID_STR_LEN + 1);
+#endif
+}
+
+static inline void disk_partition_clr_uuid(struct disk_partition *info)
+{
+#if CONFIG_IS_ENABLED(PARTITION_UUIDS)
+	*info->uuid = '\0';
+#endif
+}
+
 struct disk_part {
 	int partnum;
 	struct disk_partition gpt_part_info;
-- 
2.42.0.rc1.204.g551eb34607-goog

