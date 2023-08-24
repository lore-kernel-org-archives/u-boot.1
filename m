Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BB8C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:57:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1BEC869FD;
	Thu, 24 Aug 2023 21:56:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G2SmvG9n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E167869B7; Thu, 24 Aug 2023 21:56:12 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E5DD869BF
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:56:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7923ae72111so8105139f.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692906967; x=1693511767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ILEBXximUZNfunD22cgVmuPLTyby58MJ6TwaFDz/4M=;
 b=G2SmvG9nVDKF5ZmJvVi6XhWDtGXExkft59vraKgQpJwwPQ2+GjhRiNHMUsdC6m3S+m
 4TJ6fUBJaRLeTM3ag7cgUUWYl6j9CjV9lES7ITi002oDBbKHAkSK7vlRX1RYy3qTkym5
 olSbQwzYBqNqnEAKL8srgzXdNimUFv0dVo3I4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692906967; x=1693511767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4ILEBXximUZNfunD22cgVmuPLTyby58MJ6TwaFDz/4M=;
 b=LEpRylzLCHyYgn2pk7MrPtJoZNvOc4BaSu+bMcgUL6KNDSU9zsKj+eEBWAyOO3w8A1
 TKqf5+ljjCxTUOwvmNh5A8ftqDvQQw+T2boeBtC2Yb8KC9STJ/OjeujEsbZoR/ow+3/Y
 RztSCENfVJ8XsMRhDm3V6qGWbEJbLSwfDubO8SgEZ2j7CWmd4zexzmrIpgLE7hOw92Eh
 0XTLn6Uod2GJx2h6hClRSBMhBIjvieRbPWuota0lAa7R9z1MGhG9BFaiMdgplFZUATxX
 IcJVuGN3FCEGBqwcJV0v9L3V1flXO2mKddjzpAy68btdWw8IVk8dLMmy1gHPDggi0CMK
 YVSQ==
X-Gm-Message-State: AOJu0Yyrm9671HvLmwOXs97TSJIuJq0C5aJAiwLBM7fXANiGgbUh6UKZ
 wJAhN445oLw1JRK344uvilQu+YklA1X8wKL6RXY=
X-Google-Smtp-Source: AGHT+IHFM+SIS2IIUn5pu6AWNzo6AHfJ4CtifPmDlnnMnzbDQxb6mVm+7Fuv3qQ5dFtq70T4noBYwA==
X-Received: by 2002:a5e:d90a:0:b0:790:fcc2:6e9c with SMTP id
 n10-20020a5ed90a000000b00790fcc26e9cmr7131092iop.12.1692906967235; 
 Thu, 24 Aug 2023 12:56:07 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 b22-20020a6be716000000b007925328d6ddsm12734ioh.20.2023.08.24.12.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:56:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 09/23] part: Add accessors for struct disk_partition
 type_uuid
Date: Thu, 24 Aug 2023 13:55:32 -0600
Message-ID: <20230824195553.1685996-10-sjg@chromium.org>
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

 disk/part.c     |  8 ++------
 disk/part_efi.c |  9 +++++----
 include/part.h  | 28 ++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/disk/part.c b/disk/part.c
index 91c6ac42cc83..72241b7b232c 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -370,9 +370,7 @@ int part_get_info_by_type(struct blk_desc *desc, int part, int part_type,
 	if (blk_enabled()) {
 		/* The common case is no UUID support */
 		disk_partition_clr_uuid(info);
-#ifdef CONFIG_PARTITION_TYPE_GUID
-		info->type_guid[0] = 0;
-#endif
+		disk_partition_clr_type_guid(info);
 
 		if (part_type == PART_TYPE_UNKNOWN) {
 			drv = part_driver_lookup_type(desc);
@@ -415,9 +413,7 @@ int part_get_info_whole_disk(struct blk_desc *desc,
 	strcpy((char *)info->type, BOOT_PART_TYPE);
 	strcpy((char *)info->name, "Whole Disk");
 	disk_partition_clr_uuid(info);
-#ifdef CONFIG_PARTITION_TYPE_GUID
-	info->type_guid[0] = 0;
-#endif
+	disk_partition_clr_type_guid(info);
 
 	return 0;
 }
diff --git a/disk/part_efi.c b/disk/part_efi.c
index a6f7375cd38a..208675213822 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -294,10 +294,11 @@ int part_get_info_efi(struct blk_desc *desc, int part,
 				(char *)disk_partition_uuid(info),
 				UUID_STR_FORMAT_GUID);
 	}
-#ifdef CONFIG_PARTITION_TYPE_GUID
-	uuid_bin_to_str(gpt_pte[part - 1].partition_type_guid.b,
-			info->type_guid, UUID_STR_FORMAT_GUID);
-#endif
+	if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID)) {
+		uuid_bin_to_str(gpt_pte[part - 1].partition_type_guid.b,
+				(char *)disk_partition_type_uuid(info),
+				UUID_STR_FORMAT_GUID);
+	}
 
 	log_debug("start 0x" LBAF ", size 0x" LBAF ", name %s\n", info->start,
 		  info->size, info->name);
diff --git a/include/part.h b/include/part.h
index 8e5e543c56ec..5cf1c5ec96f0 100644
--- a/include/part.h
+++ b/include/part.h
@@ -107,6 +107,34 @@ static inline void disk_partition_clr_uuid(struct disk_partition *info)
 #endif
 }
 
+/* Accessors for struct disk_partition field ->type_guid */
+extern char *__invalid_use_of_disk_partition_type_uuid;
+
+static inline const
+char *disk_partition_type_uuid(const struct disk_partition *info)
+{
+#ifdef CONFIG_PARTITION_TYPE_GUID
+	return info->type_guid;
+#else
+	return __invalid_use_of_disk_partition_type_uuid;
+#endif
+}
+
+static inline void disk_partition_set_type_guid(struct disk_partition *info,
+						const char *val)
+{
+#ifdef CONFIG_PARTITION_TYPE_GUID
+	strlcpy(info->type_guid, val, UUID_STR_LEN + 1);
+#endif
+}
+
+static inline void disk_partition_clr_type_guid(struct disk_partition *info)
+{
+#ifdef CONFIG_PARTITION_TYPE_GUID
+	*info->type_guid = '\0';
+#endif
+}
+
 struct disk_part {
 	int partnum;
 	struct disk_partition gpt_part_info;
-- 
2.42.0.rc1.204.g551eb34607-goog

