Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAFBC3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 19:39:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22C5086AF5;
	Fri, 25 Aug 2023 21:38:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jJyNzm1l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2618086AE7; Fri, 25 Aug 2023 21:38:57 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44A5686B20
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 21:38:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6bd0c953fd9so905290a34.3
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 12:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692992332; x=1693597132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q624xlnT8RHF/wwDApZVE4Q0U0sCYMenBoxiKOnu7bo=;
 b=jJyNzm1lHMch6PEMGj1+lp9bucerZXmEv6U9RVlxqD9JASvkMAsO7JeRza3pXCVm/d
 QMJ+DQJVa5bx/nogydak4OiIi3FBjgFju4blN/fnDl1odkxWvWB5f8zJY+THZLUSw4jv
 vGAAn6Vi7HIk3ndySAZyUzUbZ4VZ6X/seP+S9cK54KYh3DYie8gbyR/vrshMtXln/2PJ
 9wzo6hQY4VBR9Gm3ZdTGe8upaSKdIzBBrnspAtIhCTcVWfLy6GnkGYWvtZkHxeN2f/KU
 qpw10Z4poTkVOXfGSA6f8iUoJ/oCecUlDXbnrYaXG9Y9uWOwFPvTw5VeCR4TsfaT53xe
 D1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692992332; x=1693597132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q624xlnT8RHF/wwDApZVE4Q0U0sCYMenBoxiKOnu7bo=;
 b=lS/kWKHYkLF6gpQw2jIN/0SkUXIXso+mF7mIgU47qj94NQMu6wydKrCydwliZEm0cz
 la/HOcDXstciq29/0jQA5YNsBossJZpm6MTD6WbQkbpozSQPI2SJKCB3C1Qz1U3hnJHU
 FrgcsgO50o2+iA18wOmgnCVpqOEUqeGQXyoWCV0h/sw4y375QR1DeH5uSkoaIJndHreK
 owFzxKQVQERHORVP4P+5M6YdU7BIHMGLPEURyF9iDCeucBqwWPPd2NeC2dL/P3rz1TV0
 2Vge6s4tXJi9Hc7nQHQ82dfkAYVFUxvN75YflYsmUbYHmmw6TuRHbCa5aalVfWTuOKnq
 ODyw==
X-Gm-Message-State: AOJu0YwXThjCOf123I+mlRT3dri5+y4r4Qed57vGRh/8nquzXGNvjlP1
 RdvDGYHNqd4mnNmb6QH6GrbWWTL4KaE=
X-Google-Smtp-Source: AGHT+IG9pKyGjOtB3x16B4xl2U2lS+YbJ6iPQPT0h4rfsj3H0rSnP//oih8f06BTR7xgvhGafe4JSA==
X-Received: by 2002:a9d:738e:0:b0:6b8:dc53:9efd with SMTP id
 j14-20020a9d738e000000b006b8dc539efdmr6766997otk.3.1692992332170; 
 Fri, 25 Aug 2023 12:38:52 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::c239])
 by smtp.gmail.com with ESMTPSA id
 m13-20020a9d7e8d000000b006b871010cb1sm1171022otp.46.2023.08.25.12.38.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 12:38:51 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 5/8] cmd: gpt: Add command to set bootable flags
Date: Fri, 25 Aug 2023 13:38:21 -0600
Message-Id: <20230825193830.2753640-6-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230825193830.2753640-1-JPEWhacker@gmail.com>
References: <20230823164755.2874792-1-JPEWhacker@gmail.com>
 <20230825193830.2753640-1-JPEWhacker@gmail.com>
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
 doc/usage/cmd/gpt.rst     |  9 +++++
 test/py/tests/test_gpt.py | 22 +++++++++++
 3 files changed, 111 insertions(+)

diff --git a/cmd/gpt.c b/cmd/gpt.c
index 7a8990e400..1fe7f1a7db 100644
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
index 88839b8e1b..353dfb05cf 100644
--- a/doc/usage/cmd/gpt.rst
+++ b/doc/usage/cmd/gpt.rst
@@ -17,6 +17,7 @@ Synopsis
     gpt read <interface> <device no> [<varname>]
     gpt swap <interface> <dev> <name1> <name2>
     gpt rename <interface> <dev> <part> <name>
+    gpt set-bootable <interface> <dev> <partition list>
 
 Description
 -----------
@@ -137,6 +138,14 @@ CONFIG_CMD_GPT_RENAME=y is required.
 The 'gpt rename' command renames all partitions named 'part' to be 'name1'.
 CONFIG_CMD_GPT_RENAME=y is required.
 
+The 'gpt set-bootable' command sets the bootable flag for all partitions in the
+table. If the partition name is in 'partition list' (separated by ','), the
+bootable flag is set, otherwise it is cleared. CONFIG_CMD_GPT_RENAME=y is
+required.  For example, to mark only the 'boot' partition as bootable:
+
+::
+    => gpt set-bootable mmc 0 boot
+
 Configuration
 -------------
 
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

