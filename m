Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F2EC27C40
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 16:49:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C20E864EB;
	Wed, 23 Aug 2023 18:48:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Et2U4B74";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FB52864F8; Wed, 23 Aug 2023 18:48:43 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F126864E6
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 18:48:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6bb07d274feso4348443a34.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 09:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692809319; x=1693414119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dDsrJxBFvIqZDwm7XWuR3hLSNEC+F6LQpzMswjXZk9M=;
 b=Et2U4B74Knl8TDcJ6IClBjlK+UJ50weGeO+jYMt/x7u5Ob5B7rj6Hudzk2B5u5hDDU
 4OpgerhenNi4exV3/6zxgMuAMZVfkQDIjgG5j8OkHSSL9u0kk8+rqk2dVwtrjGiKWoK6
 XSl7Tun2faiI7ESjWKM4FOXVv3/y04RaVz9D+zbNkoOFEh9RVvcHqvuZti4PhQszmnpj
 apIdT6N1IIP2KYkYPLbEQa1jqjGpY/ZfLwP/1d/kKiiDQuFmc1MFuw41y0Sj1gEu+6nM
 Ii2VvClaC4uGIKoFFI6Bu3/xVXHxDn70d1fAdQlE0JPx/KUK4mptCrvNUJyVfzARwn7n
 Ya5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692809319; x=1693414119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dDsrJxBFvIqZDwm7XWuR3hLSNEC+F6LQpzMswjXZk9M=;
 b=OPOqT+CsNgE3TkxJ0ZsuIUKN+10bn+3TEjmhS65RJkKQH64y7eMUYwl1X4Bj7BLMb1
 c5ltbYFUbdhu0r2tNL74agG2eyQTdHux6Hp/OdOB3JnhaYPrTJgcv1HNpaf61WMQIeUR
 RAEqXjxkBrVe4ojXO6tyhm8yPZWtJwfmNQRQDNu3GYLiKhuR9SQ8cUipIgpIDl8ssqYC
 9yy0hTMqWjsO4/s9RjSRgQvjrIB2FLiRxsyz9vmnD22fgENJ9TojULoSQfHLYBga17Q3
 mRn4VLpPQvpzyg9wpot/bwaY1MzfZL0bSrjg4vc2QddXsYWdD4OIOGpS8J1/3N5hw98D
 lusg==
X-Gm-Message-State: AOJu0Yx4EX7A7rsQKMZMvk0/LGEGSmzlJMoc4IBt5gYhINIT0RiZt4+J
 8jnsdIJIFp+tGthEFHJ148RJJYqX7I0=
X-Google-Smtp-Source: AGHT+IE4tDhPzpsYCGxg6qs7hq4xOeifj2Yb8+cgJcTcJEvJPEUfrkQioDFeq4e9FO5AwCmgcXnopg==
X-Received: by 2002:a05:6830:1452:b0:6b9:8357:61ba with SMTP id
 w18-20020a056830145200b006b9835761bamr15248382otp.1.1692809319184; 
 Wed, 23 Aug 2023 09:48:39 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::751c])
 by smtp.gmail.com with ESMTPSA id
 f22-20020a056830205600b006b9cb784553sm5794042otp.36.2023.08.23.09.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 09:48:38 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 8/8] cmd: gpt: Add command to swap partition order
Date: Wed, 23 Aug 2023 10:47:44 -0600
Message-Id: <20230823164755.2874792-9-JPEWhacker@gmail.com>
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

Adds a command called "gpt swap-postition" which will swap the order two
partitions are listed in the GPT partition table (but leaves them
pointing to the same locations on disk).

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 cmd/gpt.c                 | 50 +++++++++++++++++++++++++++++++++++++--
 doc/usage/cmd/gpt.rst     | 23 ++++++++++++++++++
 test/py/tests/test_gpt.py | 18 ++++++++++++++
 3 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/cmd/gpt.c b/cmd/gpt.c
index 90a60fce8b..2448889573 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -859,7 +859,7 @@ static int do_rename_gpt_parts(struct blk_desc *dev_desc, char *subcomm,
 	int partlistlen, ret, numparts = 0, partnum, i = 1, ctr1 = 0, ctr2 = 0;
 
 	if ((subcomm == NULL) || (name1 == NULL) || (name2 == NULL) ||
-	    (strcmp(subcomm, "swap") && (strcmp(subcomm, "rename"))))
+	    (strcmp(subcomm, "swap") && strcmp(subcomm, "rename") && strcmp(subcomm, "swap-position")))
 		return -EINVAL;
 
 	ret = get_disk_guid(dev_desc, disk_guid);
@@ -920,6 +920,48 @@ static int do_rename_gpt_parts(struct blk_desc *dev_desc, char *subcomm,
 			ret = -EINVAL;
 			goto out;
 		}
+	} else if(!strcmp(subcomm, "swap-position")) {
+		int idx1, idx2;
+		struct disk_partition first, second;
+		idx1 = simple_strtoul(name1, NULL, 10);
+		if (idx1 <= 0 || idx1 > numparts) {
+			printf("Illegal partition number %s\n", name1);
+			ret = -EINVAL;
+			goto out;
+		}
+		idx2 = simple_strtoul(name2, NULL, 10);
+		if (idx2 <= 0 || idx2 > numparts) {
+			printf("Illegal partition number %s\n", name2);
+			ret = -EINVAL;
+			goto out;
+		}
+		if (idx1 == idx2) {
+			printf("Cannot swap partition with itself\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		i = 1;
+		list_for_each(pos, &disk_partitions) {
+			curr = list_entry(pos, struct disk_part, list);
+			if (i == idx1) {
+				first = curr->gpt_part_info;
+			} else if (i == idx2) {
+				second = curr->gpt_part_info;
+			}
+			i++;
+		}
+
+		i = 1;
+		list_for_each(pos, &disk_partitions) {
+			curr = list_entry(pos, struct disk_part, list);
+			if (i == idx1) {
+				curr->gpt_part_info = second;
+			} else if (i == idx2) {
+				curr->gpt_part_info = first;
+			}
+			i++;
+		}
 	} else { /* rename */
 		if (strlen(name2) > PART_NAME_LEN) {
 			printf("Names longer than %d characters are truncated.\n", PART_NAME_LEN);
@@ -1122,7 +1164,8 @@ static int do_gpt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	} else if (strcmp(argv[1], "read") == 0) {
 		ret = do_get_gpt_info(blk_dev_desc, (argc == 5) ? argv[4] : NULL);
 	} else if ((strcmp(argv[1], "swap") == 0) ||
-		   (strcmp(argv[1], "rename") == 0)) {
+		   (strcmp(argv[1], "rename") == 0) ||
+		   (strcmp(argv[1], "swap-position") == 0)) {
 		ret = do_rename_gpt_parts(blk_dev_desc, argv[1], argv[4], argv[5]);
 	} else if ((strcmp(argv[1], "set-bootable") == 0)) {
 		ret = gpt_set_bootable(blk_dev_desc, argv[4]);
@@ -1175,6 +1218,8 @@ U_BOOT_CMD(gpt, CONFIG_SYS_MAXARGS, 1, do_gpt,
 	" gpt swap <interface> <dev> <name1> <name2>\n"
 	"    - change all partitions named name1 to name2\n"
 	"      and vice-versa\n"
+	" gpt swap-position <interface> <dev> <part1> <part2>\n"
+	"    - Swap the order of name1 with name2 in the partition table\n"
 	" gpt rename <interface> <dev> <part> <name>\n"
 	"    - rename the specified partition\n"
 	" gpt set-bootable <interface> <dev> <list>\n"
@@ -1183,5 +1228,6 @@ U_BOOT_CMD(gpt, CONFIG_SYS_MAXARGS, 1, do_gpt,
 	" gpt swap mmc 0 foo bar\n"
 	" gpt rename mmc 0 3 foo\n"
 	" gpt set-bootable mmc 0 boot_a,boot_b\n"
+	" gpt swap-position mmc 0 1 2\n"
 #endif
 );
diff --git a/doc/usage/cmd/gpt.rst b/doc/usage/cmd/gpt.rst
index c7a56ad825..f3f778d383 100644
--- a/doc/usage/cmd/gpt.rst
+++ b/doc/usage/cmd/gpt.rst
@@ -17,6 +17,7 @@ Synopsis
     gpt read <interface> <device no> [<varname>]
     gpt swap <interface> <dev> <name1> <name2>
     gpt rename <interface> <dev> <part> <name>
+    gpt swap-position <interface> <dev> <part1> <part2>
     gpt set-bootable <interface> <dev> <partition list>
 
 Description
@@ -136,6 +137,28 @@ CONFIG_CMD_GPT_RENAME=y is required.
 The 'gpt rename' command renames all partitions named 'part' to be 'name1'.
 CONFIG_CMD_GPT_RENAME=y is required.
 
+The 'gpt swap-position' command swaps the order of two partition index in the
+partition table, but otherwise leaves the actual partition data untouched. For
+example, to swap the order of the 'boot' and 'rootfs' partitions in the disk
+described above, you would do:
+
+::
+    => gpt setenv mmc 0 rootfs
+    => echo ${gpt_partition_entry}
+    2
+    => gpt setenv mmc 0 boot
+    => echo ${gpt_partition_entry}
+    1
+
+    => gpt swap-position mmc 0 1 2
+
+    => gpt setenv mmc 0 rootfs
+    => echo ${gpt_partition_entry}
+    1
+    => gpt setenv mmc 0 boot
+    => echo ${gpt_partition_entry}
+    2
+
 The 'gpt set-bootable' command sets the bootable flag for all partitions in the
 table. If the partition name is in 'partition list' (separated by ','), the
 bootable flag is set, otherwise it is cleared. CONFIG_CMD_GPT_RENAME=y is
diff --git a/test/py/tests/test_gpt.py b/test/py/tests/test_gpt.py
index 6d79d07b09..af25bcd998 100644
--- a/test/py/tests/test_gpt.py
+++ b/test/py/tests/test_gpt.py
@@ -321,3 +321,21 @@ def test_gpt_write(state_disk_image, u_boot_console):
     output = u_boot_console.run_command('gpt guid host 0')
     assert '375a56f7-d6c9-4e81-b5f0-09d41ca89efe' in output
 
+@pytest.mark.buildconfigspec('cmd_gpt')
+@pytest.mark.buildconfigspec('cmd_gpt_rename')
+@pytest.mark.buildconfigspec('cmd_part')
+@pytest.mark.requiredtool('sgdisk')
+def test_gpt_swap_position(state_disk_image, u_boot_console):
+    """Test the gpt swap-position command."""
+
+    u_boot_console.run_command('host bind 0 ' + state_disk_image.path)
+    output = u_boot_console.run_command('part list host 0')
+    assert '1\t0x00000800\t0x00000fff\t"part1"' in output
+    assert '2\t0x00001000\t0x00001bff\t"part2"' in output
+
+    output = u_boot_console.run_command('gpt swap-position host 0 1 2')
+    assert 'success!' in output
+
+    output = u_boot_console.run_command('part list host 0')
+    assert '2\t0x00000800\t0x00000fff\t"part1"' in output
+    assert '1\t0x00001000\t0x00001bff\t"part2"' in output
-- 
2.33.0

