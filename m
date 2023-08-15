Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669DDC001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 16:28:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40E72869D8;
	Tue, 15 Aug 2023 18:27:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UaxDu/aF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAECA869D8; Tue, 15 Aug 2023 18:27:55 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAD22869E6
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 18:27:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6bcaa6d5e2cso4829889a34.3
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 09:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692116872; x=1692721672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rkgHqqSIVH6gh14H9vyjVYckcAz2btzhjjMLbFEWnx4=;
 b=UaxDu/aFO+ZuoKF6s22VrP4RdcOhWw1udcbfoNcAtosrQE52qEVruHCzW3vltqMFFf
 9UVdD7zHh84gVTUbWoBD56GY0NmeXRBibpl+sC6/ySbDCIDy8UVamfaam0A8IwpXGl+6
 O2mR0Z71hJz9SfKFo3k/H/fhWEicXz+B3+LFLZ12qe8lmk0xcjlE02KXfm+uaO8153fp
 bQmC3Ncb+b7XFoZL8vvYjZMooSPg9yviJ3QBkUfyWg1MFLN2rr949ImUqG6GYWYVRHYH
 3YsAXmUfrc8PvL+K1VteQRBzxLH1i+tMidM0GCIWQ3ekY2b3QkINVY2UAphvZ8vxS1Kf
 4tbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692116872; x=1692721672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rkgHqqSIVH6gh14H9vyjVYckcAz2btzhjjMLbFEWnx4=;
 b=geDUQttvCFfFzvAv0cFyOthXE+e/HM0AGtoEhKCFABOJ8LLJus0EZlu/BY+UPu+LdH
 flNw/RLRUDlpDTlPUVvgg7q5aGIi9lMMlOxW3sn+Wf9zQRjQFBLO4h762A5B2kliIiSA
 wD446g60xxhL2ra2HLDPVFI+2hog2kgq7BShXQ87NAsBw9B1uU3EhkoN6HAoPsmyrz2e
 IGzeYWM7JnWjfxiU0mKfCoq5A5WL0QzYiD7uneBACKscalJMiVAA9v0+oU6dJO/grbr1
 xrs0+TJDg1oCBvVHj47mIWoFb+ueZCnq+HbJSAf9YyfhCKuVU3aeRFnVkObNAReoN5Dg
 M5YA==
X-Gm-Message-State: AOJu0YyTyIoJGpWeq267AHB2r5eunfLpzWADljoOsTFy6FXrNZYt6n1x
 wDXl3O75R1XJwXfzzi4vdkjy1zC0xfE=
X-Google-Smtp-Source: AGHT+IENZ9346puQOwr0lK/QPyWMg6OmzIwvKvMNqRXpOTV/IH+Z+Xhzp2bGeS2zQ7U7HeUFdV3YQA==
X-Received: by 2002:a05:6870:5588:b0:1bb:4bb3:ecee with SMTP id
 n8-20020a056870558800b001bb4bb3eceemr13798373oao.31.1692116871745; 
 Tue, 15 Aug 2023 09:27:51 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6897])
 by smtp.gmail.com with ESMTPSA id
 zf26-20020a0568716a9a00b001c4f840e7bbsm2474441oab.47.2023.08.15.09.27.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 09:27:51 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [PATCH 4/6] cmd: gpt: Preserve type GUID if enabled
Date: Tue, 15 Aug 2023 10:26:58 -0600
Message-Id: <20230815162726.1524958-5-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230815162726.1524958-1-JPEWhacker@gmail.com>
References: <20230815162726.1524958-1-JPEWhacker@gmail.com>
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

If CONFIG_PARTITION_TYPE_GUID is enabled, the type GUID will be
preserved when writing out the partition string. It was already
respected when writing out partitions; this ensures that if you capture
the current partition layout and write it back (such as when renaming),
the type GUIDs are preserved.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 cmd/gpt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/cmd/gpt.c b/cmd/gpt.c
index bc08799512..c6fbd94ba2 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -173,6 +173,9 @@ static int calc_parts_list_len(int numparts)
 	/* see part.h for definition of struct disk_partition */
 	partlistlen += numparts * (strlen("start=MiB,") + sizeof(lbaint_t) + 1);
 	partlistlen += numparts * (strlen("size=MiB,") + sizeof(lbaint_t) + 1);
+#ifdef CONFIG_PARTITION_TYPE_GUID
+	partlistlen += numparts * (strlen("type=,") + UUID_STR_LEN + 1);
+#endif
 	partlistlen += numparts * (strlen("uuid=;") + UUID_STR_LEN + 1);
 	/* for the terminating null */
 	partlistlen++;
@@ -211,6 +214,11 @@ static struct disk_part *allocate_disk_part(struct disk_partition *info,
 		PART_TYPE_LEN);
 	newpart->gpt_part_info.type[PART_TYPE_LEN - 1] = '\0';
 	newpart->gpt_part_info.bootable = info->bootable;
+#ifdef CONFIG_PARTITION_TYPE_GUID
+	strncpy(newpart->gpt_part_info.type_guid, (const char *)info->type_guid,
+		UUID_STR_LEN);
+	newpart->gpt_part_info.type_guid[UUID_STR_LEN] = '\0';
+#endif
 #ifdef CONFIG_PARTITION_UUIDS
 	strncpy(newpart->gpt_part_info.uuid, (const char *)info->uuid,
 		UUID_STR_LEN);
@@ -252,6 +260,9 @@ static void print_gpt_info(void)
 		       curr->gpt_part_info.name);
 		printf("Type %s, bootable %d\n", curr->gpt_part_info.type,
 		       curr->gpt_part_info.bootable & PART_BOOTABLE);
+#ifdef CONFIG_PARTITION_TYPE_GUID
+		printf("Type GUID %s\n", curr->gpt_part_info.type_guid);
+#endif
 #ifdef CONFIG_PARTITION_UUIDS
 		printf("UUID %s\n", curr->gpt_part_info.uuid);
 #endif
@@ -299,6 +310,11 @@ static int create_gpt_partitions_list(int numparts, const char *guid,
 					    curr->gpt_part_info.blksz);
 		strncat(partitions_list, partstr, PART_NAME_LEN + 1);
 
+#ifdef CONFIG_PARTITION_TYPE_GUID
+		strcat(partitions_list, ",type=");
+		strncat(partitions_list, curr->gpt_part_info.type_guid,
+			UUID_STR_LEN + 1);
+#endif
 		strcat(partitions_list, ",uuid=");
 		strncat(partitions_list, curr->gpt_part_info.uuid,
 			UUID_STR_LEN + 1);
-- 
2.33.0

