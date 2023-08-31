Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A07C83F2E
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 16:53:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E428586829;
	Thu, 31 Aug 2023 18:52:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hiNQJ0SU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AA178671C; Thu, 31 Aug 2023 18:52:20 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2382486722
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:52:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6bd8639e7e5so895320a34.1
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 09:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693500735; x=1694105535; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hUh8rRDpzp1bZvVSa6qQiVtZPExsAN7mK0w8By+AVXA=;
 b=hiNQJ0SUTlY/wakPp3MsxkbBQpBLYhish+TYl+E+96Mw0zXgaRzeVJmjGgsV9zU7vP
 a2gMCROTPiPyvIrTlJNNiQhq4XnTGOoSOQqnl2dq23toHWnO5CIQLshFLSu8zdH3xhHM
 NvBdgMOLt/VXn6Mn8J0ryNjrpoAzD0AcQt4p3/Hd7WlxlzDLezYfMNjncKyiqInRsSxc
 SJyOl4HSSBUE1/a/QwfPitOorG8a71psSum2taevewscgPa2/m4JQI0oaS0jJe9l6cun
 6U5kHTWamU4T60S3JAlwDt55lMIPMpvR2Bn1gpp+Xe4SUAz4mRI2glvN2quTEEqOG+eO
 M2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693500735; x=1694105535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hUh8rRDpzp1bZvVSa6qQiVtZPExsAN7mK0w8By+AVXA=;
 b=CjMO6zLbtC5g8eh5JIDrxeCIcFB6y0P9eTiaYCO4H4W9kUygfjEATH8+cEnmg/l7Ub
 xAVSIVMjbmKWFyoX8y0V+LDKlLh0zHwXAp9pKteVO9PQbLnoXIQmb9YqvrI75PuQw/58
 K/IJtdgo610Ob5s80hSvyIqme3OsZQTMvloX99Czk9EFuT9yD5jPdPPvsf/qjf9ec/1s
 2tEjXY/2cfcCfLFSboFniUtAuGLaYGv+Zt5ra9PKCKf+ZbWK5WFb5xD2O7TTaqPIPeHB
 4OHuLMs3RVS4kbrj4OsP/b3kuspod/xhUzFw983NTXZekumk7ZJHYU0/3lh8gLnRjhVa
 gplA==
X-Gm-Message-State: AOJu0YwLwq75TFg8LdHNqmjL3Xn2XOP9X0PjQsqhjzX8begQ/F6UH/jC
 fMDVa/NbXGf2R89hej3kXqeASxRGBxg=
X-Google-Smtp-Source: AGHT+IEC8L0yWUfXtcpNdWx4ZemFBNYFesYhFbLMFf2LJlwHFQzt1/sThzX0O/YMDzlanw1AQLv++A==
X-Received: by 2002:a05:6830:11c2:b0:6b9:72be:671f with SMTP id
 v2-20020a05683011c200b006b972be671fmr6054675otq.16.1693500735200; 
 Thu, 31 Aug 2023 09:52:15 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::b66b])
 by smtp.gmail.com with ESMTPSA id
 b15-20020a9d6b8f000000b006bb334880d8sm867020otq.81.2023.08.31.09.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 09:52:14 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Enric Balletbo i Serra <eballetb@redhat.com>
Subject: [PATCH v5 8/8] cmd: gpt: Add command to swap partition order
Date: Thu, 31 Aug 2023 10:51:41 -0600
Message-Id: <20230831165144.592820-9-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831165144.592820-1-JPEWhacker@gmail.com>
References: <20230828215623.3727536-1-JPEWhacker@gmail.com>
 <20230831165144.592820-1-JPEWhacker@gmail.com>
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

Adds a command called "gpt transpose" which will swap the order two
partition table entries in the GPT partition table (but leaves them
pointing to the same locations on disk).

This can be useful for swapping bootloaders in systems that use an A/B
partitioning scheme where the bootrom is hard coded to look for the
bootloader in a specific index in the GPT partition table.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 cmd/gpt.c                 | 46 ++++++++++++++++++++++++++++++++++++---
 doc/usage/cmd/gpt.rst     | 25 +++++++++++++++++++++
 test/py/tests/test_gpt.py | 19 ++++++++++++++++
 3 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/cmd/gpt.c b/cmd/gpt.c
index 927b6afa68..58b2c904a1 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -858,8 +858,9 @@ static int do_rename_gpt_parts(struct blk_desc *dev_desc, char *subcomm,
 	u8 part_count = 0;
 	int partlistlen, ret, numparts = 0, partnum, i = 1, ctr1 = 0, ctr2 = 0;
 
-	if ((subcomm == NULL) || (name1 == NULL) || (name2 == NULL) ||
-	    (strcmp(subcomm, "swap") && (strcmp(subcomm, "rename"))))
+	if (!subcomm || !name1 || !name2 ||
+	    (strcmp(subcomm, "swap") && strcmp(subcomm, "rename") &&
+	     strcmp(subcomm, "transpose")))
 		return -EINVAL;
 
 	ret = get_disk_guid(dev_desc, disk_guid);
@@ -920,6 +921,41 @@ static int do_rename_gpt_parts(struct blk_desc *dev_desc, char *subcomm,
 			ret = -EINVAL;
 			goto out;
 		}
+	} else if (!strcmp(subcomm, "transpose")) {
+		int idx1, idx2;
+		struct disk_partition* first = NULL;
+		struct disk_partition* second= NULL;
+		struct disk_partition tmp_part;
+
+		idx1 = simple_strtoul(name1, NULL, 10);
+		idx2 = simple_strtoul(name2, NULL, 10);
+		if (idx1 == idx2) {
+			printf("Cannot swap partition with itself\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		list_for_each(pos, &disk_partitions) {
+			curr = list_entry(pos, struct disk_part, list);
+			if (curr->partnum == idx1)
+				first = &curr->gpt_part_info;
+			else if (curr->partnum == idx2)
+				second = &curr->gpt_part_info;
+		}
+		if (!first) {
+			printf("Illegal partition number %s\n", name1);
+			ret = -EINVAL;
+			goto out;
+		}
+		if (!second) {
+			printf("Illegal partition number %s\n", name2);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		tmp_part = *first;
+		*first = *second;
+		*second = tmp_part;
 	} else { /* rename */
 		if (strlen(name2) > PART_NAME_LEN) {
 			printf("Names longer than %d characters are truncated.\n", PART_NAME_LEN);
@@ -1123,7 +1159,8 @@ static int do_gpt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	} else if (strcmp(argv[1], "read") == 0) {
 		ret = do_get_gpt_info(blk_dev_desc, (argc == 5) ? argv[4] : NULL);
 	} else if ((strcmp(argv[1], "swap") == 0) ||
-		   (strcmp(argv[1], "rename") == 0)) {
+		   (strcmp(argv[1], "rename") == 0) ||
+		   (strcmp(argv[1], "transpose") == 0)) {
 		ret = do_rename_gpt_parts(blk_dev_desc, argv[1], argv[4], argv[5]);
 	} else if ((strcmp(argv[1], "set-bootable") == 0)) {
 		ret = gpt_set_bootable(blk_dev_desc, argv[4]);
@@ -1176,6 +1213,8 @@ U_BOOT_CMD(gpt, CONFIG_SYS_MAXARGS, 1, do_gpt,
 	" gpt swap <interface> <dev> <name1> <name2>\n"
 	"    - change all partitions named name1 to name2\n"
 	"      and vice-versa\n"
+	" gpt transpose <interface> <dev> <part1> <part2>\n"
+	"    - Swap the order of the entries for part1 and part2 in the partition table\n"
 	" gpt rename <interface> <dev> <part> <name>\n"
 	"    - rename the specified partition\n"
 	" gpt set-bootable <interface> <dev> <list>\n"
@@ -1184,5 +1223,6 @@ U_BOOT_CMD(gpt, CONFIG_SYS_MAXARGS, 1, do_gpt,
 	" gpt swap mmc 0 foo bar\n"
 	" gpt rename mmc 0 3 foo\n"
 	" gpt set-bootable mmc 0 boot_a,boot_b\n"
+	" gpt transpose mmc 0 1 2\n"
 #endif
 );
diff --git a/doc/usage/cmd/gpt.rst b/doc/usage/cmd/gpt.rst
index 288dd365c0..f6115ecb0e 100644
--- a/doc/usage/cmd/gpt.rst
+++ b/doc/usage/cmd/gpt.rst
@@ -16,6 +16,7 @@ Synopsis
     gpt set-bootable <interface> <dev> <partition list>
     gpt setenv <interface> <dev> <partition name>
     gpt swap <interface> <dev> <name1> <name2>
+    gpt transpose <interface> <dev> <part1> <part2>
     gpt verify <interface> <dev> [<partition string>]
     gpt write <interface> <dev> <partition string>
 
@@ -126,6 +127,13 @@ Changes the names of all partitions that are named 'name1' to be 'name2', and
 all partitions named 'name2' to be 'name1'. CONFIG_CMD_GPT_RENAME=y is
 required.
 
+gpt transpose
+~~~~~~~~~~~~~
+
+Swaps the order of two partition table entries with indexes 'part1' and 'part2'
+in the partition table, but otherwise leaves the actual partition data
+untouched.
+
 gpt verify
 ~~~~~~~~~~
 
@@ -199,3 +207,20 @@ Get the GUID for a disk::
 Set the bootable flag for the 'boot' partition and clear it for all others::
 
     => gpt set-bootable mmc 0 boot
+
+Swap the order of the 'boot' and 'rootfs' partition table entries::
+    => gpt setenv mmc 0 rootfs
+    => echo ${gpt_partition_entry}
+    2
+    => gpt setenv mmc 0 boot
+    => echo ${gpt_partition_entry}
+    1
+
+    => gpt transpose mmc 0 1 2
+
+    => gpt setenv mmc 0 rootfs
+    => echo ${gpt_partition_entry}
+    1
+    => gpt setenv mmc 0 boot
+    => echo ${gpt_partition_entry}
+    2
diff --git a/test/py/tests/test_gpt.py b/test/py/tests/test_gpt.py
index b4c03bc3a2..6e135b663e 100644
--- a/test/py/tests/test_gpt.py
+++ b/test/py/tests/test_gpt.py
@@ -329,3 +329,22 @@ def test_gpt_write(state_disk_image, u_boot_console):
     assert '0x00001000	0x00001bff	"second"' in output
     output = u_boot_console.run_command('gpt guid host 0')
     assert '375a56f7-d6c9-4e81-b5f0-09d41ca89efe' in output
+
+@pytest.mark.buildconfigspec('cmd_gpt')
+@pytest.mark.buildconfigspec('cmd_gpt_rename')
+@pytest.mark.buildconfigspec('cmd_part')
+@pytest.mark.requiredtool('sgdisk')
+def test_gpt_transpose(state_disk_image, u_boot_console):
+    """Test the gpt transpose command."""
+
+    u_boot_console.run_command('host bind 0 ' + state_disk_image.path)
+    output = u_boot_console.run_command('part list host 0')
+    assert '1\t0x00000800\t0x00000fff\t"part1"' in output
+    assert '2\t0x00001000\t0x00001bff\t"part2"' in output
+
+    output = u_boot_console.run_command('gpt transpose host 0 1 2')
+    assert 'success!' in output
+
+    output = u_boot_console.run_command('part list host 0')
+    assert '2\t0x00000800\t0x00000fff\t"part1"' in output
+    assert '1\t0x00001000\t0x00001bff\t"part2"' in output
-- 
2.34.1

