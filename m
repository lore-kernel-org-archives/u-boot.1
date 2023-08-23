Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D30C3DA66
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 16:48:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E55586467;
	Wed, 23 Aug 2023 18:48:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KIKtgNSE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0F54864D9; Wed, 23 Aug 2023 18:48:29 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF00C864F3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 18:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6bcac140aaaso4467340a34.2
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 09:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692809306; x=1693414106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2EU2DWjq/W3SE3bSv5lUMksSoNisp5Ux7FOzvbjiVxA=;
 b=KIKtgNSEnNv8g4OCUYH3B/rAGG7W8RS35lfb+VfbgCUj0VAuBORDc7Sb9xGP7Ez0VE
 aeelBu42GjoIwSRCWVbkLF7vUsOMjh98Dn4WI51txKY8pHjxI7hLGfnxECGQy8VFFaS2
 na+gJlPxiBNT2FV+CzoxxRZo6a4sRLLsPBa+SFCcgglqFLirYQdzyPeUg9Z5ZOwtDqvy
 G3m9mJFsStUs17TTvmypwvIa81BRAgk5KVsmgSsPW+tx9yOn7JkuaJTj76Qhc8BGr21i
 EjlFoeR6aS6lTnaB1+CYSXu9fGg4XmNN02CXuc+HcK/pd+YjbL3R9zDlZMwQWGaQERXD
 3geQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692809306; x=1693414106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2EU2DWjq/W3SE3bSv5lUMksSoNisp5Ux7FOzvbjiVxA=;
 b=a7Ycr7VguPmk7QFjcvIlNLujrh0RlKkAHjdoPVHotABCeagHmte6oWlrvKQireB4AE
 WYaj0WfT84tnu2a+8Ti5FC52/aGf+WWTg14KT3imtDauftwNHCFzsFDEqc62y+qweAOj
 9BuAPsMeJN55uHmQ/Lr2//6tIIj/AXnsbG41ln13Gy4TfTB8xRQMRw242KGHFI2Y4MPq
 jbvZ7U47QfLqxbQ/Z+xyPYnu/ZYIydnkWm3i40LumYvtUI9na3fek1I3V8bONAP9xYyO
 yCL7NdyQhWXWd6MsVE0k30sUMdqbnwd38j9Fpmmd+8iANm2quVOHMvD69vSEnZSM+iL6
 7c5Q==
X-Gm-Message-State: AOJu0Ywzp04CztYxpJ/DO2JcYQ0/lNNgDcwYkwkTOTscLMwMGBWvO8yd
 vNVFR+ZyYbN4Jk+acCfPaAqUaMDSX00=
X-Google-Smtp-Source: AGHT+IG+IhWn6KI8VmP6xmMr3EaTTcv9BR2J3m9GLzATV12QFB2BuEeOBi3Oym5mRGZlkAtAHI3BtQ==
X-Received: by 2002:a05:6830:11d7:b0:6b9:e35e:8dd with SMTP id
 v23-20020a05683011d700b006b9e35e08ddmr15028228otq.2.1692809305683; 
 Wed, 23 Aug 2023 09:48:25 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::751c])
 by smtp.gmail.com with ESMTPSA id
 f22-20020a056830205600b006b9cb784553sm5794042otp.36.2023.08.23.09.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 09:48:25 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 5/8] cmd: gpt: Add command to set bootable flags
Date: Wed, 23 Aug 2023 10:47:41 -0600
Message-Id: <20230823164755.2874792-6-JPEWhacker@gmail.com>
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

Adds a command that can be used to modify the GPT partition table to
indicate which partitions should have the bootable flag set

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 cmd/gpt.c                 | 79 +++++++++++++++++++++++++++++++++++++++
 doc/usage/cmd/gpt.rst     |  9 +++++
 test/py/tests/test_gpt.py | 22 +++++++++++
 3 files changed, 110 insertions(+)

diff --git a/cmd/gpt.c b/cmd/gpt.c
index 7a8990e400..70a01f7da1 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -972,6 +972,80 @@ static int do_rename_gpt_parts(struct blk_desc *dev_desc, char *subcomm,
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
+
+	int ret = get_disk_guid(blk_dev_desc, disk_guid);
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
@@ -1031,6 +1105,8 @@ static int do_gpt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	} else if ((strcmp(argv[1], "swap") == 0) ||
 		   (strcmp(argv[1], "rename") == 0)) {
 		ret = do_rename_gpt_parts(blk_dev_desc, argv[1], argv[4], argv[5]);
+	} else if ((strcmp(argv[1], "set-bootable") == 0)) {
+		ret = gpt_set_bootable(blk_dev_desc, argv[4]);
 #endif
 	} else {
 		return CMD_RET_USAGE;
@@ -1082,8 +1158,11 @@ U_BOOT_CMD(gpt, CONFIG_SYS_MAXARGS, 1, do_gpt,
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
index c9d15b2cba..c7a56ad825 100644
--- a/doc/usage/cmd/gpt.rst
+++ b/doc/usage/cmd/gpt.rst
@@ -17,6 +17,7 @@ Synopsis
     gpt read <interface> <device no> [<varname>]
     gpt swap <interface> <dev> <name1> <name2>
     gpt rename <interface> <dev> <part> <name>
+    gpt set-bootable <interface> <dev> <partition list>
 
 Description
 -----------
@@ -135,6 +136,14 @@ CONFIG_CMD_GPT_RENAME=y is required.
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
index 1537ceb8c8..8203515e05 100644
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

