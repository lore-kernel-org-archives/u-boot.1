Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41EAC83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 21:57:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEB6F864FA;
	Mon, 28 Aug 2023 23:56:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HY23hVSd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83242864D7; Mon, 28 Aug 2023 23:56:54 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 732A486503
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 23:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3a9b342c398so2386559b6e.3
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 14:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693259808; x=1693864608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iCnTGi8eQF30OzJXOC4D8zVDUO+93nvAVbIQPVXMEWk=;
 b=HY23hVSdXmaxhmXJdJhb4CYsh/7ingbowGNX9qwycjmW4t475xPt8Ov5c9puRghGBa
 Mfnglp4+8AqujLCyVLOjLsVR0MqtBBeh8XM9yyDsqhiWIQ53Fw5Ty5JHd9FInO25MwHs
 x1UHUd4oirO/xikw2ViI+Kev2K/NpJec1oxIq6UvNY2PgaAZ59I9AgLhtSay1FMg7ofR
 51R8ZIYVmqv9wgVIUP2Q2V5maCcR51SMB0dCevajBeJPGGQR7HQnB/B3xSKajKS1SHpX
 FG+bbwapmEb2UWiw+l7tcDLJpPF/60Gm1KQ5Jva4GpR6qmem7tZEKLrZJPbbqj+94hls
 llKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693259808; x=1693864608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iCnTGi8eQF30OzJXOC4D8zVDUO+93nvAVbIQPVXMEWk=;
 b=AP6hp2lrkaHit//SUdT/nA9y+qylefRVFw/AFoablNt/O3d/lIu80cRzdO6MKTVd8n
 ZHBjFhiNAiXuW2ZFdLwqzpQYlWXeG+hA/E2my2wtmAG3yIkWwpbusOkZ6iT3KO9aP1dk
 nfWzXy/b6h64pHH0v3VZtxdL6sZB8sCutE9uvQNCnUi5TMvedMf6SviiHjEpkinqt2SP
 /k1JuD4P9YS+WxHnBlRV57tyuw43Qc3uqxVuuH9bPLAOMxWTrKWfKAV924SMqH9NTvYd
 hbrMGiabt0v05w3/iosQBdAo27ia7MTT0PRkHpsEUXviCnbj+lSPD+Pgbx1baI45nHyV
 C7wA==
X-Gm-Message-State: AOJu0YzPCEYlFh35jnbwY+g6JJsR2W+E5emxjcOyxdDJPa/QRWkpUas2
 zFEDmc1qhtIY4NWVfWxjzaLKTPQvveo=
X-Google-Smtp-Source: AGHT+IEy582urUYInVLloNFU/xecrFhYNTonDe+ZNcO2G0EXI/ZG+EgAWoo1SW0MZIjzbxuSZ6hPrg==
X-Received: by 2002:aca:6502:0:b0:3a8:4dfd:4f0b with SMTP id
 m2-20020aca6502000000b003a84dfd4f0bmr10978984oim.19.1693259808411; 
 Mon, 28 Aug 2023 14:56:48 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::c239])
 by smtp.gmail.com with ESMTPSA id
 t8-20020a0568080b2800b003a7527207b5sm3856298oij.7.2023.08.28.14.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 14:56:47 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Enric Balletbo i Serra <eballetb@redhat.com>
Subject: [PATCH v4 5/8] cmd: gpt: Add command to set bootable flags
Date: Mon, 28 Aug 2023 15:56:12 -0600
Message-Id: <20230828215623.3727536-6-JPEWhacker@gmail.com>
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

Adds a command that can be used to modify the GPT partition table to
indicate which partitions should have the bootable flag set

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 cmd/gpt.c                 | 80 +++++++++++++++++++++++++++++++++++++++
 doc/usage/cmd/gpt.rst     | 12 ++++++
 test/py/tests/test_gpt.py | 22 +++++++++++
 3 files changed, 114 insertions(+)

diff --git a/cmd/gpt.c b/cmd/gpt.c
index c6c8282ac9..45fbe07404 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -972,6 +972,81 @@ static int do_rename_gpt_parts(struct blk_desc *dev_desc, char *subcomm,
 	free(partitions_list);
 	return ret;
 }
+
+/**
+ * gpt_set_bootable() - Set bootable flags for partitions
+ *
+ * Sets the bootable flag for any partition names in the comma separated list of
+ * partition names. Any partitions not in the list have their bootable flag
+ * cleared
+ *
+ * @desc: block device descriptor
+ * @name: Comma separated list of partition names
+ *
+ * @Return: '0' on success and -ve error on failure
+ */
+static int gpt_set_bootable(struct blk_desc *blk_dev_desc, char *const part_list)
+{
+	char *name;
+	char disk_guid[UUID_STR_LEN + 1];
+	struct list_head *pos;
+	struct disk_part *curr;
+	struct disk_partition *partitions = NULL;
+	int part_count = 0;
+	int ret = get_disk_guid(blk_dev_desc, disk_guid);
+
+	if (ret < 0)
+		return ret;
+
+	ret = get_gpt_info(blk_dev_desc);
+	if (ret <= 0)
+		goto out;
+
+	part_count = ret;
+	partitions = malloc(sizeof(*partitions) * part_count);
+	if (!partitions) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* Copy partitions and clear bootable flag */
+	part_count = 0;
+	list_for_each(pos, &disk_partitions) {
+		curr = list_entry(pos, struct disk_part, list);
+		partitions[part_count] = curr->gpt_part_info;
+		partitions[part_count].bootable &= ~PART_BOOTABLE;
+		part_count++;
+	}
+
+	name = strtok(part_list, ",");
+	while (name) {
+		bool found = false;
+
+		for (int i = 0; i < part_count; i++) {
+			if (strcmp((char *)partitions[i].name, name) == 0) {
+				partitions[i].bootable |= PART_BOOTABLE;
+				found = true;
+			}
+		}
+
+		if (!found) {
+			printf("Warning: No partition matching '%s' found\n",
+			       name);
+		}
+
+		name = strtok(NULL, ",");
+	}
+
+	ret = gpt_restore(blk_dev_desc, disk_guid, partitions, part_count);
+
+out:
+	del_gpt_info();
+
+	if (partitions)
+		free(partitions);
+
+	return ret;
+}
 #endif
 
 /**
@@ -1031,6 +1106,8 @@ static int do_gpt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	} else if ((strcmp(argv[1], "swap") == 0) ||
 		   (strcmp(argv[1], "rename") == 0)) {
 		ret = do_rename_gpt_parts(blk_dev_desc, argv[1], argv[4], argv[5]);
+	} else if ((strcmp(argv[1], "set-bootable") == 0)) {
+		ret = gpt_set_bootable(blk_dev_desc, argv[4]);
 #endif
 	} else {
 		return CMD_RET_USAGE;
@@ -1082,8 +1159,11 @@ U_BOOT_CMD(gpt, CONFIG_SYS_MAXARGS, 1, do_gpt,
 	"      and vice-versa\n"
 	" gpt rename <interface> <dev> <part> <name>\n"
 	"    - rename the specified partition\n"
+	" gpt set-bootable <interface> <dev> <list>\n"
+	"    - make partition names in list bootable\n"
 	" Example usage:\n"
 	" gpt swap mmc 0 foo bar\n"
 	" gpt rename mmc 0 3 foo\n"
+	" gpt set-bootable mmc 0 boot_a,boot_b\n"
 #endif
 );
diff --git a/doc/usage/cmd/gpt.rst b/doc/usage/cmd/gpt.rst
index b505b159d0..288dd365c0 100644
--- a/doc/usage/cmd/gpt.rst
+++ b/doc/usage/cmd/gpt.rst
@@ -13,6 +13,7 @@ Synopsis
     gpt read <interface> <dev> [<varname>]
     gpt rename <interface> <dev> <part> <name>
     gpt repair <interface> <dev>
+    gpt set-bootable <interface> <dev> <partition list>
     gpt setenv <interface> <dev> <partition name>
     gpt swap <interface> <dev> <name1> <name2>
     gpt verify <interface> <dev> [<partition string>]
@@ -90,6 +91,13 @@ gpt repair
 
 Repairs the GPT partition tables if it they become corrupted.
 
+gpt set-bootable
+~~~~~~~~~~~~~~~~
+
+Sets the bootable flag for all partitions in the table. If the partition name
+is in 'partition list' (separated by ','), the bootable flag is set, otherwise
+it is cleared. CONFIG_CMD_GPT_RENAME=y is required.
+
 gpt setenv
 ~~~~~~~~~~
 
@@ -187,3 +195,7 @@ Get the GUID for a disk::
     => gpt guid mmc gpt_disk_uuid
     => echo ${gpt_disk_uuid}
     bec9fc2a-86c1-483d-8a0e-0109732277d7
+
+Set the bootable flag for the 'boot' partition and clear it for all others::
+
+    => gpt set-bootable mmc 0 boot
diff --git a/test/py/tests/test_gpt.py b/test/py/tests/test_gpt.py
index 946858800d..5d23f9b292 100644
--- a/test/py/tests/test_gpt.py
+++ b/test/py/tests/test_gpt.py
@@ -222,6 +222,28 @@ def test_gpt_swap_partitions(state_disk_image, u_boot_console):
     assert '0x00000800	0x00000fff	"part2"' in output
     assert '0x00001000	0x00001bff	"part1"' in output
 
+@pytest.mark.buildconfigspec('cmd_gpt')
+@pytest.mark.buildconfigspec('cmd_gpt_rename')
+@pytest.mark.buildconfigspec('cmd_part')
+@pytest.mark.requiredtool('sgdisk')
+def test_gpt_set_bootable(state_disk_image, u_boot_console):
+    """Test the gpt set-bootable command."""
+
+    u_boot_console.run_command('host bind 0 ' + state_disk_image.path)
+    parts = ('part2', 'part1')
+    for bootable in parts:
+        output = u_boot_console.run_command(f'gpt set-bootable host 0 {bootable}')
+        assert 'success!' in output
+
+        for p in parts:
+            output = u_boot_console.run_command(f'gpt setenv host 0 {p}')
+            assert 'success!' in output
+            output = u_boot_console.run_command('echo ${gpt_partition_bootable}')
+            if p == bootable:
+                assert output.rstrip() == '1'
+            else:
+                assert output.rstrip() == '0'
+
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_gpt')
 @pytest.mark.buildconfigspec('cmd_part')
-- 
2.33.0

