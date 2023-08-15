Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 043AAC001DE
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 16:28:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFA8C86797;
	Tue, 15 Aug 2023 18:27:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dNAEeMve";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 847CE869D0; Tue, 15 Aug 2023 18:27:49 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C8BB869E6
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 18:27:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1c4de3b9069so1627903fac.0
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 09:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692116865; x=1692721665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R5wPzWKmN9P8lRJFqebFJCUlsDhPQrSdZc7uzW6zgso=;
 b=dNAEeMveRlr45Mrwgk3JPOCd1FZxmfb/dPlhi5aQXPMtkMOYCUZ2U3y5lCIGbTN2I8
 Cuq2htugx2cvElX51E/YvGGbk5T4hFklTVvzqWomjoxuL/SQ9emp4PSRSaLJz2W//aqW
 fX/q5+YEcPcV6KtQzLYwnhOQq8jjS3R+3OuFyqS8AFqB7H8uCfA9SgzyYxpbKRlRH5Np
 vmrqE1drMbDNZpTQ43usQOagHVhIxzHdqInkBlQNiDFwACxLIBXcvwEZEj6C9SBCSsEp
 KYdj+sGJzkxq3oEjVuG0rmn0CUx8232mVFHYF9zT39d4LXxCoSW8Z9nxD4GzLysldnFA
 npAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692116865; x=1692721665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R5wPzWKmN9P8lRJFqebFJCUlsDhPQrSdZc7uzW6zgso=;
 b=NdxPoZ0zZmWEYKvss+a3kWMrbSoWtSR5slYF1v9XGvnOCn8wY4W2qbY6AfSBG4Xeau
 akrw2g6SvRZdMYPnAkEB2fgq117VzuBEFWmePbv2apSsMLrCv1dF9MggEK74DbpcDFsW
 36k8BTvF5lSMnrwtgoeRQF+siG9AuuqKolmyzHR6+mqsa9o91lge6DZj/Ou0y416KKrw
 jyCD3IJNEIxUQFPqUFzxbzElvIUDK8HMbLiWx8rNNR/kh4YU2+lVN6tDiK2NX4LBBePr
 vcsYuCxLyTxky6OPPVbU6WGEcb3d1NMdt4RIk/xs///GjMPbKDkudiDuodzXhQ1DWG+e
 jDdA==
X-Gm-Message-State: AOJu0YyQp8a9KHz9V31rQM2dNMTzLdjwnTG6FkunTCW73W+n/+9HkCMx
 8clEkOpl7mgkdmagWbcTqf9Lsv1dAPg=
X-Google-Smtp-Source: AGHT+IG9P1F4rLPyDzK0rzrtU0eRGKsPvITnwz+slCvXMEFp7O0hzyirRruwZuNfW9NDKKcq9aho7Q==
X-Received: by 2002:a05:6870:d113:b0:1bb:a912:9339 with SMTP id
 e19-20020a056870d11300b001bba9129339mr14847819oac.7.1692116865340; 
 Tue, 15 Aug 2023 09:27:45 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6897])
 by smtp.gmail.com with ESMTPSA id
 zf26-20020a0568716a9a00b001c4f840e7bbsm2474441oab.47.2023.08.15.09.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 09:27:44 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [PATCH 2/6] cmd: gpt: Add command to set bootable flags
Date: Tue, 15 Aug 2023 10:26:56 -0600
Message-Id: <20230815162726.1524958-3-JPEWhacker@gmail.com>
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

Adds a command that can be used to modify the GPT partition table to
indicate which partitions should have the bootable flag set

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 cmd/gpt.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/cmd/gpt.c b/cmd/gpt.c
index e6f7b0319a..a4b8b2b286 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -970,6 +970,80 @@ static int do_rename_gpt_parts(struct blk_desc *dev_desc, char *subcomm,
 }
 #endif
 
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
+
 /**
  * do_gpt(): Perform GPT operations
  *
@@ -1028,6 +1102,8 @@ static int do_gpt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		   (strcmp(argv[1], "rename") == 0)) {
 		ret = do_rename_gpt_parts(blk_dev_desc, argv[1], argv[4], argv[5]);
 #endif
+	} else if ((strcmp(argv[1], "set-bootable") == 0)) {
+		ret = gpt_set_bootable(blk_dev_desc, argv[4]);
 	} else {
 		return CMD_RET_USAGE;
 	}
@@ -1081,4 +1157,8 @@ U_BOOT_CMD(gpt, CONFIG_SYS_MAXARGS, 1, do_gpt,
 	" gpt swap mmc 0 foo bar\n"
 	" gpt rename mmc 0 3 foo\n"
 #endif
+	" gpt set-bootable <interface> <dev> <list>\n"
+	"    - make partition names in list bootable\n"
+	" Example usage:\n"
+	" gpt set-bootable mmc 0 boot_a,boot_b\n"
 );
-- 
2.33.0

