Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12966C83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 21:57:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5CC68645F;
	Mon, 28 Aug 2023 23:57:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JsnA9dN5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66AAB864D7; Mon, 28 Aug 2023 23:57:02 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8018480569
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 23:56:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3a7e68f4214so2852107b6e.1
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 14:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693259817; x=1693864617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oj+RAAGRAb4FGDqUvDpL1VJNjS1BFe15yWQKCHBdUgE=;
 b=JsnA9dN5xo5FavXYXxIJE3whPEHaCAY5cbuumiV9C5K46uj0HbTBQ98CdnnMAaeXFr
 LyueIj1z10qRoBdfefZYjQEKngFSm4d2dLuYJ+0vwsJ5YyPOP3dmZPAtJFZJt/YpVJgD
 7USsdauVZPObj+5nTxGm4WJndJWygcicWGJZelF4KTac2zduKbwJuiyV7/hKEHk7S7Bw
 ZLOO/Ro2BY1nVANIo3Lvg7QOXyGfcze68PQmG1bK+cHll0HnkUYzKJ2onWl0JkVVjpby
 8EStIDiPsxw/qtQ0FpAJKpxHpaqdd9AkSvN2/T/FYDSayNmi0M0nuz1ZkArL21bxKeL/
 JtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693259817; x=1693864617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oj+RAAGRAb4FGDqUvDpL1VJNjS1BFe15yWQKCHBdUgE=;
 b=DbbmQJjwzzOkk7y0hBZQEYV+4MlIH4BgVOsWVuCWzxh1RtmWqeu4N1tkG3F7gcxHm5
 8F8P5YI1ZL7fRNnxkKBMI7ERTphsBq98wTVFClpQ6DHDcKwMJpoWA4Bf8yZAIluFOu4/
 AftaYHSL9iWLuQd/XaBhiHYc1MtgnCIwBp35SNvdcJfFm75qrWkrNIeBpYZ6zQZ20wVi
 wA8wUN8pWUCn76g6i3CzOFuwtewIjNNkkkL5dc9CLTtsqGP//F3/fLUgCrCH89hE+aPr
 mptFVGUwYO0WAZPgJoIFc1gVSX2HlOt3EonO09syPtT0WVmyaUhf9TdJKtXfJRwsOpWi
 SWyA==
X-Gm-Message-State: AOJu0YxyzPSFkWVPJ8je+BhCySZ9Qigue6SDYmQRFo29Bz/NSC/3sdhz
 zRPwxci9EcbdpAwjphKOZCmvEA3TJxQ=
X-Google-Smtp-Source: AGHT+IEqIbtxgq17aARsRcoQr0uqscR4ludC4cHDpJrM5W7y1jFpGQdBuGv9spAB6Omc2sBCL+rPKg==
X-Received: by 2002:a05:6808:208e:b0:3a8:8aa3:cc72 with SMTP id
 s14-20020a056808208e00b003a88aa3cc72mr15598523oiw.41.1693259817557; 
 Mon, 28 Aug 2023 14:56:57 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::c239])
 by smtp.gmail.com with ESMTPSA id
 t8-20020a0568080b2800b003a7527207b5sm3856298oij.7.2023.08.28.14.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 14:56:56 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Enric Balletbo i Serra <eballetb@redhat.com>
Subject: [PATCH v4 8/8] cmd: gpt: Add command to swap partition order
Date: Mon, 28 Aug 2023 15:56:15 -0600
Message-Id: <20230828215623.3727536-9-JPEWhacker@gmail.com>
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

Adds a command called "gpt swap-postition" which will swap the order two
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
index 927b6afa68..c7d3f65ff2 100644
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
@@ -920,6 +921,41 @@ static int do_rename_gpt_parts(struct blk_desc *dev_desc, char *subcomm,
 			ret = -EINVAL;
 			goto out;
 		}
+	} else if (!strcmp(subcomm, "swap-position")) {
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
+		   (strcmp(argv[1], "swap-position") == 0)) {
 		ret = do_rename_gpt_parts(blk_dev_desc, argv[1], argv[4], argv[5]);
 	} else if ((strcmp(argv[1], "set-bootable") == 0)) {
 		ret = gpt_set_bootable(blk_dev_desc, argv[4]);
@@ -1176,6 +1213,8 @@ U_BOOT_CMD(gpt, CONFIG_SYS_MAXARGS, 1, do_gpt,
 	" gpt swap <interface> <dev> <name1> <name2>\n"
 	"    - change all partitions named name1 to name2\n"
 	"      and vice-versa\n"
+	" gpt swap-position <interface> <dev> <part1> <part2>\n"
+	"    - Swap the order of the entries for part1 and part2 in the partition table\n"
 	" gpt rename <interface> <dev> <part> <name>\n"
 	"    - rename the specified partition\n"
 	" gpt set-bootable <interface> <dev> <list>\n"
@@ -1184,5 +1223,6 @@ U_BOOT_CMD(gpt, CONFIG_SYS_MAXARGS, 1, do_gpt,
 	" gpt swap mmc 0 foo bar\n"
 	" gpt rename mmc 0 3 foo\n"
 	" gpt set-bootable mmc 0 boot_a,boot_b\n"
+	" gpt swap-position mmc 0 1 2\n"
 #endif
 );
diff --git a/doc/usage/cmd/gpt.rst b/doc/usage/cmd/gpt.rst
index 288dd365c0..b2aaf4a701 100644
--- a/doc/usage/cmd/gpt.rst
+++ b/doc/usage/cmd/gpt.rst
@@ -16,6 +16,7 @@ Synopsis
     gpt set-bootable <interface> <dev> <partition list>
     gpt setenv <interface> <dev> <partition name>
     gpt swap <interface> <dev> <name1> <name2>
+    gpt swap-position <interface> <dev> <part1> <part2>
     gpt verify <interface> <dev> [<partition string>]
     gpt write <interface> <dev> <partition string>
 
@@ -126,6 +127,13 @@ Changes the names of all partitions that are named 'name1' to be 'name2', and
 all partitions named 'name2' to be 'name1'. CONFIG_CMD_GPT_RENAME=y is
 required.
 
+gpt swap-position
+~~~~~~~~~~~~~~~~~
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
+    => gpt swap-position mmc 0 1 2
+
+    => gpt setenv mmc 0 rootfs
+    => echo ${gpt_partition_entry}
+    1
+    => gpt setenv mmc 0 boot
+    => echo ${gpt_partition_entry}
+    2
diff --git a/test/py/tests/test_gpt.py b/test/py/tests/test_gpt.py
index b4c03bc3a2..5a106c038c 100644
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

