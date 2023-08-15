Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3643C001DE
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 16:28:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AE87869F0;
	Tue, 15 Aug 2023 18:28:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XCPAByLQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D490869D6; Tue, 15 Aug 2023 18:28:02 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42C348671F
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 18:28:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-56c96982829so4207229eaf.0
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 09:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692116878; x=1692721678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aZZk4XUIpHgcE/+sd2ZqBwmQcYIJHk3Aqz2T3RYr6AQ=;
 b=XCPAByLQU9CbhGElBJD7XzMAkCuT3NxTOuiQu4///FjbiIYf8ZdRFb25HEhcoHsp+c
 UUW5oRNKWHKj8cJ9EFVq4EARh19B1glSZ5uvFGIcGFAEvHhVIVMM9a/CVrrsuCvIb3hE
 CXouPZCrvYS3kP06BBOKfYEvZ+LMxHLetNJrPpxIutP4rsOA/UaxWurfnxw7XvsCL0kY
 9u26ryXBhyhr1SovGEiB2UeQv1j5W8u4HBaP8WWeByYLmmKFigRhAWhaQuPRGqL1auM5
 q+EfMfP4t+T9dnJTlxX5ts7fQW/gsHZ+nqxgD+qo5kxm1j74WePT56w5he/6jriEP4KF
 lHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692116878; x=1692721678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aZZk4XUIpHgcE/+sd2ZqBwmQcYIJHk3Aqz2T3RYr6AQ=;
 b=RcZdlQkIQ2pAU1/ukDZNAqA8IO9H6TMhxIT9LaC5HJL1M+GhLkdldGVFmQo9j4kHXS
 IWBE+M+9/+QcdYS89uctWPv+3Cn0lG9V4z6KB2ulDpXu6jPVrOZkdsGw4CxhfQ4pp5OW
 cBByLE3EleJji7cOzBu36bPK6CpDoBhcoqJyvpl3KTmpcUCV5AB7FI7Om0JuEMS83tBy
 kP/JcQlCnwHvn91te02NcqqCQikIUCtfN2uJ5Hh3Tyhr5UZMUpqUG+ZKZpzftHTE41Bd
 b5wl3yxUbuQVsUeW0vAdoGqRz363teKtHMKQNSlRurOOYhbIF77k2WMCIA5RQv1oVvnG
 4vdg==
X-Gm-Message-State: AOJu0YyTunD0BEpUyeycAWahNdwE5DMg/tcVpYtCq3TW1i92kxsUdxMM
 7d/9fAavfgzfVSbj6U65+835IX7tCtQ=
X-Google-Smtp-Source: AGHT+IHl3VKWmvBDI36uBKIQfSBvMy3feZSP/alUupzPSnZgTlQjk0nFFb9OplY9KBwl5UVxlitwpQ==
X-Received: by 2002:a05:6870:179f:b0:1b0:5141:4c6e with SMTP id
 r31-20020a056870179f00b001b051414c6emr13062622oae.26.1692116878239; 
 Tue, 15 Aug 2023 09:27:58 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6897])
 by smtp.gmail.com with ESMTPSA id
 zf26-20020a0568716a9a00b001c4f840e7bbsm2474441oab.47.2023.08.15.09.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 09:27:57 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [PATCH 6/6] cmd: gpt: Add command to swap partition order
Date: Tue, 15 Aug 2023 10:27:00 -0600
Message-Id: <20230815162726.1524958-7-JPEWhacker@gmail.com>
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

Adds a command called "gpt swap-postition" which will swap the order two
partitions are listed in the GPT partition table (but leaves them
pointing to the same locations on disk).

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 cmd/gpt.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/cmd/gpt.c b/cmd/gpt.c
index 58564436d3..c8a2b5ae7b 100644
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
 #endif
 	} else if ((strcmp(argv[1], "set-bootable") == 0)) {
@@ -1175,11 +1218,14 @@ U_BOOT_CMD(gpt, CONFIG_SYS_MAXARGS, 1, do_gpt,
 	" gpt swap <interface> <dev> <name1> <name2>\n"
 	"    - change all partitions named name1 to name2\n"
 	"      and vice-versa\n"
+	" gpt swap-position <interface> <dev> <part1> <part2>\n"
+	"    - Swap the order of name1 with name2 in the partition table\n"
 	" gpt rename <interface> <dev> <part> <name>\n"
 	"    - rename the specified partition\n"
 	" Example usage:\n"
 	" gpt swap mmc 0 foo bar\n"
 	" gpt rename mmc 0 3 foo\n"
+	" gpt swap-partitions mmc 0 1 2\n"
 #endif
 	" gpt set-bootable <interface> <dev> <list>\n"
 	"    - make partition names in list bootable\n"
-- 
2.33.0

