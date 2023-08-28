Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951B6C83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 21:57:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 205B1864F5;
	Mon, 28 Aug 2023 23:56:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LiTKJ4Vc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B42C8650A; Mon, 28 Aug 2023 23:56:56 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 681FF80569
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 23:56:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3a9a6a7a824so1920483b6e.1
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 14:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693259811; x=1693864611; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kxlLVMvErME2Nqgnzfw2x4l8chAGgS13F1nihcvESxw=;
 b=LiTKJ4Vcj8b+ySp+o55SN9kdNh/boBMgbUAz616pFiChDXwW26fpWmj+EjeNwwFAXd
 3iPf24ir2xwl7yOOLYAG872JCKHtjDMDZP8ajYAxif/Xvd3/TticmN2Jb9ScDdkVSEMU
 mXg1LhFB9mAYTVmOMDNljqTUA+3Rj79g11SecV1gt0cuXjKFQejOedcPGz2YPXybA+mZ
 jeXDAIr7J+ZEd4yUS0u5Co1dpTwYCld32IwIfm3IUFAzxOMHNNiurzYzSjdv9/S54afQ
 KxE+RfkJlhO2j45Q/TFIi01O+asEeN/2/opDjPVbRLyZ631ldRVQSukNqROU810QM+j/
 CEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693259811; x=1693864611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kxlLVMvErME2Nqgnzfw2x4l8chAGgS13F1nihcvESxw=;
 b=dQ6k/n4Y6eqtd6vU474wqSK8QbkAkCtRTn1O1LsLTCDoHeyFbZj+aeWbcVZBHA+X8T
 HTKMgEnDmqT50S6eqzLwSRxZItfL/kP4suGiCrEUZXMQD6LGmmYha1kLpcvc+EZSjSBR
 jz16Ul8g7hVWAp9VBr41AkZvN+dCcqhnG776KdSjchqfbJLozPOEiLhDQ74O3pJyqGNj
 lCnS9JV7caq6Aqc8iH/8F9siF3QOiBtak8ud/awIm2whLJScnDBzHQ2pCOl/MoFG9dBb
 3ZrlOX7jECXsWohd2ytcQ+LLwAtv6slWrdaikEAepBvt05cd0oK0jYvI7UQOYKx+HyyM
 7j/Q==
X-Gm-Message-State: AOJu0YxHyDNNnv3zWS2XNYYTFx8lsYYTI2BQ81zJCtxE0pvLs5Uvfjhv
 ZmDp5OORdsB4+sjEPI1b3T/Wbj7jvUE=
X-Google-Smtp-Source: AGHT+IHaSqo53aufJs3lEBQQP3C57E4fPxj4CodfQjHbv8ShE2FY2MHVqQPlTkHIP7HWM+kZGoS1ug==
X-Received: by 2002:aca:919:0:b0:3a7:64a5:aa76 with SMTP id
 25-20020aca0919000000b003a764a5aa76mr475058oij.2.1693259811481; 
 Mon, 28 Aug 2023 14:56:51 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::c239])
 by smtp.gmail.com with ESMTPSA id
 t8-20020a0568080b2800b003a7527207b5sm3856298oij.7.2023.08.28.14.56.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 14:56:50 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Enric Balletbo i Serra <eballetb@redhat.com>
Subject: [PATCH v4 6/8] cmd: gpt: Preserve type GUID if enabled
Date: Mon, 28 Aug 2023 15:56:13 -0600
Message-Id: <20230828215623.3727536-7-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230828215623.3727536-1-JPEWhacker@gmail.com>
References: <20230825193830.2753640-1-JPEWhacker@gmail.com>
 <20230828215623.3727536-1-JPEWhacker@gmail.com>
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
 cmd/gpt.c                 | 16 ++++++++++
 test/py/tests/test_gpt.py | 65 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/cmd/gpt.c b/cmd/gpt.c
index 45fbe07404..0090e02110 100644
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
diff --git a/test/py/tests/test_gpt.py b/test/py/tests/test_gpt.py
index 5d23f9b292..93007dee9a 100644
--- a/test/py/tests/test_gpt.py
+++ b/test/py/tests/test_gpt.py
@@ -16,6 +16,35 @@ the test.
 # Mark all tests here as slow
 pytestmark = pytest.mark.slow
 
+def parse_gpt_parts(disk_str):
+    """Parser a partition string into a list of partitions.
+
+    Args:
+        disk_str: The disk description string, as returned by `gpt read`
+
+    Returns:
+        A list of parsed partitions. Each partition is a dictionary with the
+        string value from each specified key in the partition description, or a
+        key with with the value True for a boolean flag
+    """
+    parts = []
+    for part_str in disk_str.split(';'):
+        part = {}
+        for option in part_str.split(","):
+            if not option:
+                continue
+
+            if "=" in option:
+                key, value = option.split("=")
+                part[key] = value
+            else:
+                part[option] = True
+
+        if part:
+            parts.append(part)
+
+    return parts
+
 class GptTestDiskImage(object):
     """Disk Image used by the GPT tests."""
 
@@ -49,11 +78,13 @@ class GptTestDiskImage(object):
                 u_boot_utils.run_and_log(u_boot_console, cmd)
                 # part1 offset 1MB size 1MB
                 cmd = ('sgdisk', '--new=1:2048:4095', '--change-name=1:part1',
+                    '--partition-guid=1:33194895-67f6-4561-8457-6fdeed4f50a3',
                     '-A 1:set:2',
                     persistent)
                 # part2 offset 2MB size 1.5MB
                 u_boot_utils.run_and_log(u_boot_console, cmd)
                 cmd = ('sgdisk', '--new=2:4096:7167', '--change-name=2:part2',
+                    '--partition-guid=2:cc9c6e4a-6551-4cb5-87be-3210f96c86fb',
                     persistent)
                 u_boot_utils.run_and_log(u_boot_console, cmd)
                 cmd = ('sgdisk', '--load-backup=' + persistent)
@@ -88,6 +119,40 @@ def test_gpt_read(state_disk_image, u_boot_console):
     assert '0x00000800	0x00000fff	"part1"' in output
     assert '0x00001000	0x00001bff	"part2"' in output
 
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_gpt')
+@pytest.mark.buildconfigspec('partition_type_guid')
+@pytest.mark.requiredtool('sgdisk')
+def test_gpt_read_var(state_disk_image, u_boot_console):
+    """Test the gpt read command."""
+
+    u_boot_console.run_command('host bind 0 ' + state_disk_image.path)
+    output = u_boot_console.run_command('gpt read host 0 gpt_parts')
+    assert 'success!' in output
+
+    output = u_boot_console.run_command('echo ${gpt_parts}')
+    parts = parse_gpt_parts(output.rstrip())
+
+    assert parts == [
+        {
+            "uuid_disk": "375a56f7-d6c9-4e81-b5f0-09d41ca89efe",
+        },
+        {
+            "name": "part1",
+            "start": "0x100000",
+            "size": "0x100000",
+            "type": "0fc63daf-8483-4772-8e79-3d69d8477de4",
+            "uuid": "33194895-67f6-4561-8457-6fdeed4f50a3",
+        },
+        {
+            "name": "part2",
+            "start": "0x200000",
+            "size": "0x180000",
+            "type": "0fc63daf-8483-4772-8e79-3d69d8477de4",
+            "uuid": "cc9c6e4a-6551-4cb5-87be-3210f96c86fb",
+        },
+    ]
+
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_gpt')
 @pytest.mark.requiredtool('sgdisk')
-- 
2.33.0

