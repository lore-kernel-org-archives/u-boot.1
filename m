Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12563C3DA6F
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 16:49:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7210864D7;
	Wed, 23 Aug 2023 18:48:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iWY9KfR1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BA41864D5; Wed, 23 Aug 2023 18:48:35 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3630864E7
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 18:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6bcd4b5ebbaso4332534a34.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 09:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692809310; x=1693414110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rZn3w5l2ox4qiLsc7HsoNfpZGiykkJWopiWiL2z2jvw=;
 b=iWY9KfR1NiC557xz3QxGvc90aCt2AU4U1XZQoGhmUmJT/6xZxRVuay6XSw5aHQOeQK
 HrcprBUKUjB9IlBzHYTvSa70dL6fTxNtphwwDLfVsbmIjO6ysPofs07BJlXRnhDMWOWX
 TpvDolhCqlPXLEdhabjI/adbsHEs6VLdx4XFM+YGlZEbYbwdFGT0vwDA9w/4Jg73T0Vr
 SfuWJn4lh1FkTchtEpTvs6phrRvANVy5XxmCEy+ly4YUl77/f+oA5lwOE+tAvFDhggiG
 0zvz3O2H8aFwbHO2wBIvWZfkYdlFwZGmuct+wmLUpaIWRxB1KmNSWPPsxpYIdIY7HMzx
 HCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692809310; x=1693414110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rZn3w5l2ox4qiLsc7HsoNfpZGiykkJWopiWiL2z2jvw=;
 b=CPWWNwqFZeX50v5ZeVv/GaMS/kCX8CkT3pW3sio3EjspAcXBvY+ZAKP4bAttZaCUyV
 FngBDZL7SQPfpALqokowsqgB50Sg+8CQMtKk4Yo8WgutJu/yjIDd23l9hNb/NxkI8tq8
 UJOH0kciZ4y8k+YgEvjQ6LLuhUmr3HDVtS+fp3TKH1z1/5LJV6GiH15NGFS2CVZHbc+o
 JPFi5ktIRGtbVhqtLmT/ROLhxa6cscBtjSOeCePr4lSwbI4QcRy9Q+CSgVFPukqZUOOB
 lu5xw7/vpMaOLl1GS8VyMgRU1sdMgDIOQcHBD4MLInxT/0fQ55/csKdk5VzfnIE+FQWW
 VzrQ==
X-Gm-Message-State: AOJu0YyLQl+n1lf/0+PCCNx2bydyqfvsyJ0njU52/vwaeLHb088A89Y7
 PmAlL1je64FxD6rCP3zceYZ7Gm01F+Y=
X-Google-Smtp-Source: AGHT+IH3qGg/dsH0AYDkWuleEOo8k4Nn04UGBmQNYF94fglUGtuaAD7VEXZKMTUS9c2k2RU12bRhyg==
X-Received: by 2002:a05:6830:1682:b0:6b9:a926:4a12 with SMTP id
 k2-20020a056830168200b006b9a9264a12mr16108964otr.28.1692809310670; 
 Wed, 23 Aug 2023 09:48:30 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::751c])
 by smtp.gmail.com with ESMTPSA id
 f22-20020a056830205600b006b9cb784553sm5794042otp.36.2023.08.23.09.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 09:48:30 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>, Simon Glass <sjg@chromium.org>,
 Enric Balletbo i Serra <eballetb@redhat.com>
Subject: [PATCH v2 6/8] cmd: gpt: Preserve type GUID if enabled
Date: Wed, 23 Aug 2023 10:47:42 -0600
Message-Id: <20230823164755.2874792-7-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230823164755.2874792-1-JPEWhacker@gmail.com>
References: <20230815162726.1524958-1-JPEWhacker@gmail.com>
 <20230823164755.2874792-1-JPEWhacker@gmail.com>
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
 cmd/gpt.c                 | 16 +++++++++++
 test/py/tests/test_gpt.py | 57 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/cmd/gpt.c b/cmd/gpt.c
index 70a01f7da1..fdd9c429f6 100644
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
index 8203515e05..f9351f0274 100644
--- a/test/py/tests/test_gpt.py
+++ b/test/py/tests/test_gpt.py
@@ -16,6 +16,26 @@ the test.
 # Mark all tests here as slow
 pytestmark = pytest.mark.slow
 
+def parse_gpt_parts(s):
+    """Part a partition string into a list of partitions"""
+    parts = []
+    for part_str in s.split(';'):
+        part = {}
+        for option in part_str.split(","):
+            if not option:
+                continue
+
+            if "=" in option:
+                k, v = option.split("=")
+                part[k] = v
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
 
@@ -49,11 +69,13 @@ class GptTestDiskImage(object):
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
@@ -88,6 +110,40 @@ def test_gpt_read(state_disk_image, u_boot_console):
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
@@ -263,3 +319,4 @@ def test_gpt_write(state_disk_image, u_boot_console):
     assert '0x00001000	0x00001bff	"second"' in output
     output = u_boot_console.run_command('gpt guid host 0')
     assert '375a56f7-d6c9-4e81-b5f0-09d41ca89efe' in output
+
-- 
2.33.0

