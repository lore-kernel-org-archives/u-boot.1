Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D111C3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 19:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 064ED86B14;
	Fri, 25 Aug 2023 21:39:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="prI73+yF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AB1586B2D; Fri, 25 Aug 2023 21:39:07 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 948DC86AE7
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 21:39:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6bd066b0fd4so906173a34.2
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 12:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692992342; x=1693597142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XTy5v5KU5L8596wTjYl7vlhHz4CS62IAXgNTJZVUaQw=;
 b=prI73+yFiJmInrqX/A3ybaNsgyREKeSoxW4TG8FWwivwJmoldKZ7B2ctWBUeOonCCM
 PgflEeyMjSotdtap5dLG/MhZ14YVD9ql6ir4aw6NfVMBr/zGyOU3CT0jJdAd5w4T/lqO
 CheIeWrtueS53Mr/japs3O/iV/HJlMp9lP5H48FkSbkQbUNzExkaNhGkSw5izgpfduQC
 VeabEOIr9utVW3tShItiWKV63r0jcawALWefaPFcvPJrbHzIc6A9faiWBP5L42T1n/3/
 5O/hc2Wo6ULPBPs/fKokRIgeKc8KkEKk+CH3D1Jah02UwQPojODAUlKMxrwcxmFpNSz2
 twiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692992342; x=1693597142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XTy5v5KU5L8596wTjYl7vlhHz4CS62IAXgNTJZVUaQw=;
 b=UwebBQLn/30yOsq2W12567Cskg8txsYcbDlpP5VT7dhWXQC7G+bmsjqNqDxtNkNIdB
 CkGvgHYpTo7p7mPmBGJGScJN+Xdf/nhktwxucuQtJm/yC1UvoUV0ufCxcZenIKkA1QWT
 EwnP79xPkHepdodb0Fzs/mf7AdWeNb7UlO0bXQPQeO91AmFbfdPo8nEONyWZXNn3pUgM
 cm+VJUi4+m6OW3S6bst53/7GHl6zbvyJJv3RrLSpADWyMfs+5Sdryq7/pxDK5UHCpsSp
 FdJQewogxBnav4kXJsH6G//KrSxC7IdGfCVwZlrQMdmYELv87JGBPlw1gPMIH+raIvfF
 FxZw==
X-Gm-Message-State: AOJu0YwVBB7w2f1ceBQSw38yAPuDVll/YHQav1IOsPbLfiv7wLSMkp56
 OrHP0Qsi/cyt6NTbjBsdOM7neb1UZhc=
X-Google-Smtp-Source: AGHT+IFx0jvlya6FKwhOI4I4SDLN29WpTNLSr254Qn7pEzG0Yg5PUk4PVoUjrJnpRNHTmdsUdaVS7g==
X-Received: by 2002:a05:6830:115a:b0:6b9:d224:1a1d with SMTP id
 x26-20020a056830115a00b006b9d2241a1dmr6868938otq.19.1692992342508; 
 Fri, 25 Aug 2023 12:39:02 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::c239])
 by smtp.gmail.com with ESMTPSA id
 m13-20020a9d7e8d000000b006b871010cb1sm1171022otp.46.2023.08.25.12.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 12:39:01 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 8/8] cmd: gpt: Add command to swap partition order
Date: Fri, 25 Aug 2023 13:38:24 -0600
Message-Id: <20230825193830.2753640-9-JPEWhacker@gmail.com>
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

Adds a command called "gpt swap-postition" which will swap the order two
partitions are listed in the GPT partition table (but leaves them
pointing to the same locations on disk).

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 cmd/gpt.c                 | 52 ++++++++++++++++++++++++++++++++++++---
 doc/usage/cmd/gpt.rst     | 23 +++++++++++++++++
 test/py/tests/test_gpt.py | 18 ++++++++++++++
 3 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/cmd/gpt.c b/cmd/gpt.c
index 0479b3a6a4..3c39446258 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -858,8 +858,9 @@ static int do_rename_gpt_parts(struct blk_desc *dev_desc, char *subcomm,
 	u8 part_count = 0;
 	int partlistlen, ret, numparts = 0, partnum, i = 1, ctr1 = 0, ctr2 = 0;
 
-	if ((subcomm == NULL) || (name1 == NULL) || (name2 == NULL) ||
-	    (strcmp(subcomm, "swap") && (strcmp(subcomm, "rename"))))
+	if (!subcomm || !name1 || !name2 ||
+	    (strcmp(subcomm, "swap") && strcmp(subcomm, "rename") &&
+	     strcmp(subcomm, "swap-position")))
 		return -EINVAL;
 
 	ret = get_disk_guid(dev_desc, disk_guid);
@@ -920,6 +921,47 @@ static int do_rename_gpt_parts(struct blk_desc *dev_desc, char *subcomm,
 			ret = -EINVAL;
 			goto out;
 		}
+	} else if (!strcmp(subcomm, "swap-position")) {
+		int idx1, idx2;
+		struct disk_partition first, second;
+
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
+			if (i == idx1)
+				first = curr->gpt_part_info;
+			else if (i == idx2)
+				second = curr->gpt_part_info;
+			i++;
+		}
+
+		i = 1;
+		list_for_each(pos, &disk_partitions) {
+			curr = list_entry(pos, struct disk_part, list);
+			if (i == idx1)
+				curr->gpt_part_info = second;
+			else if (i == idx2)
+				curr->gpt_part_info = first;
+			i++;
+		}
 	} else { /* rename */
 		if (strlen(name2) > PART_NAME_LEN) {
 			printf("Names longer than %d characters are truncated.\n", PART_NAME_LEN);
@@ -1123,7 +1165,8 @@ static int do_gpt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	} else if (strcmp(argv[1], "read") == 0) {
 		ret = do_get_gpt_info(blk_dev_desc, (argc == 5) ? argv[4] : NULL);
 	} else if ((strcmp(argv[1], "swap") == 0) ||
-		   (strcmp(argv[1], "rename") == 0)) {
+		   (strcmp(argv[1], "rename") == 0) ||
+		   (strcmp(argv[1], "swap-position") == 0)) {
 		ret = do_rename_gpt_parts(blk_dev_desc, argv[1], argv[4], argv[5]);
 	} else if ((strcmp(argv[1], "set-bootable") == 0)) {
 		ret = gpt_set_bootable(blk_dev_desc, argv[4]);
@@ -1176,6 +1219,8 @@ U_BOOT_CMD(gpt, CONFIG_SYS_MAXARGS, 1, do_gpt,
 	" gpt swap <interface> <dev> <name1> <name2>\n"
 	"    - change all partitions named name1 to name2\n"
 	"      and vice-versa\n"
+	" gpt swap-position <interface> <dev> <part1> <part2>\n"
+	"    - Swap the order of name1 with name2 in the partition table\n"
 	" gpt rename <interface> <dev> <part> <name>\n"
 	"    - rename the specified partition\n"
 	" gpt set-bootable <interface> <dev> <list>\n"
@@ -1184,5 +1229,6 @@ U_BOOT_CMD(gpt, CONFIG_SYS_MAXARGS, 1, do_gpt,
 	" gpt swap mmc 0 foo bar\n"
 	" gpt rename mmc 0 3 foo\n"
 	" gpt set-bootable mmc 0 boot_a,boot_b\n"
+	" gpt swap-position mmc 0 1 2\n"
 #endif
 );
diff --git a/doc/usage/cmd/gpt.rst b/doc/usage/cmd/gpt.rst
index 353dfb05cf..bc14bda6e5 100644
--- a/doc/usage/cmd/gpt.rst
+++ b/doc/usage/cmd/gpt.rst
@@ -17,6 +17,7 @@ Synopsis
     gpt read <interface> <device no> [<varname>]
     gpt swap <interface> <dev> <name1> <name2>
     gpt rename <interface> <dev> <part> <name>
+    gpt swap-position <interface> <dev> <part1> <part2>
     gpt set-bootable <interface> <dev> <partition list>
 
 Description
@@ -138,6 +139,28 @@ CONFIG_CMD_GPT_RENAME=y is required.
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
index 666d387ac8..3d23b98cea 100644
--- a/test/py/tests/test_gpt.py
+++ b/test/py/tests/test_gpt.py
@@ -330,3 +330,21 @@ def test_gpt_write(state_disk_image, u_boot_console):
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

