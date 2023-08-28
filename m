Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C66C83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 21:57:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67CF3864F3;
	Mon, 28 Aug 2023 23:57:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gQ1UdAQ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C14FE86514; Mon, 28 Aug 2023 23:56:58 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0471D86503
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 23:56:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3a751d2e6ecso2864150b6e.0
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 14:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693259814; x=1693864614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dbMkUCOgHB/MaTvBadHlamPvJgceTAYtdNmPuLfeEXE=;
 b=gQ1UdAQ09MvmIND22ld/p4m7e1/7Ly2X9JAvarmTycsHyzoeg8Uf+lIk3ffp9M+Ow6
 CEcotXRtZ4gY41Mcet6DvNDekQGS0n92hQPRv/UowrglwBkGPXX7LOUB7HqO8IhE379S
 LJ2A0COqrEQzB9sVdg/vPLZw54EudLduGsN3kSciXwbyc9VUeSn93TEX4EMtnm4QfMdm
 08SBlCji+V+5EzFGK3EzavjvDjy1uLSdUKGptDJFzCD42YIqQGiVV/DvVhIWvbtEiNE8
 heCZPyKRMKWJDRH9XNL/a5iuVny5gvhdecXN18DBfVUP1Lmy3VqnnBVQ2hd+8NiU0IWL
 nLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693259814; x=1693864614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dbMkUCOgHB/MaTvBadHlamPvJgceTAYtdNmPuLfeEXE=;
 b=K4chQKEWh56S0fSdxa18B6qEbAmaTVpRZLxTvDhjJNKUvGWAjXIH4lytiZz1pVVL2k
 pKuYL+mlMY2vXPl484ZzsSN+1Pb4b1mj+LRPoPS/4TNvJi2vi009o3B/Ko/7sDYhZ2Yd
 vqkf09i0cHSN6S8lFsWzlejY5piFVpD+nfAU4W4V7LNl1Au89J/yD7xVYp6WzALKDwVX
 dQuo1GO0SdQWMzdpZR+35rAsZVPQTNo3lxqQun4GAgIvCvY0RhdbIf3etbk7PM101QCq
 Ne65Aif4b8bulZgEkXezdSgTiCa+tPOHvKMSa5MybwCnqp27ktGTkBdxSNfqxOlTta24
 HQIQ==
X-Gm-Message-State: AOJu0YxWEBbOKdlPeQbQeZr0SkwkHQfMKFdxKxS8OnQ5v1hNAiG8PNzN
 hapwpydyy1G1JYsQAKhoHGIdT+xOvdQ=
X-Google-Smtp-Source: AGHT+IGBnOvc2TPSTJIxmVue8wzRY/lYjDlYFtBNKq+Elqe2fOLsbGsyl4Y5KIFsDzHp7G/IMIeX9w==
X-Received: by 2002:a54:4f10:0:b0:3a4:8ac7:3407 with SMTP id
 e16-20020a544f10000000b003a48ac73407mr13250256oiy.42.1693259814046; 
 Mon, 28 Aug 2023 14:56:54 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::c239])
 by smtp.gmail.com with ESMTPSA id
 t8-20020a0568080b2800b003a7527207b5sm3856298oij.7.2023.08.28.14.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 14:56:53 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Enric Balletbo i Serra <eballetb@redhat.com>
Subject: [PATCH v4 7/8] cmd: gpt: Preserve bootable flag
Date: Mon, 28 Aug 2023 15:56:14 -0600
Message-Id: <20230828215623.3727536-8-JPEWhacker@gmail.com>
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

Sets the bootable flag when constructing the partition string from the
current partition configuration. This ensures that when the partitions
are written back (for example, when renaming a partition), the flag is
preserved.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 cmd/gpt.c                 | 3 +++
 test/py/tests/test_gpt.py | 1 +
 2 files changed, 4 insertions(+)

diff --git a/cmd/gpt.c b/cmd/gpt.c
index 0090e02110..927b6afa68 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -176,6 +176,7 @@ static int calc_parts_list_len(int numparts)
 #ifdef CONFIG_PARTITION_TYPE_GUID
 	partlistlen += numparts * (strlen("type=,") + UUID_STR_LEN + 1);
 #endif
+	partlistlen += numparts * strlen("bootable,");
 	partlistlen += numparts * (strlen("uuid=;") + UUID_STR_LEN + 1);
 	/* for the terminating null */
 	partlistlen++;
@@ -318,6 +319,8 @@ static int create_gpt_partitions_list(int numparts, const char *guid,
 		strcat(partitions_list, ",uuid=");
 		strncat(partitions_list, curr->gpt_part_info.uuid,
 			UUID_STR_LEN + 1);
+		if (curr->gpt_part_info.bootable & PART_BOOTABLE)
+			strcat(partitions_list, ",bootable");
 		strcat(partitions_list, ";");
 	}
 	return 0;
diff --git a/test/py/tests/test_gpt.py b/test/py/tests/test_gpt.py
index 93007dee9a..b4c03bc3a2 100644
--- a/test/py/tests/test_gpt.py
+++ b/test/py/tests/test_gpt.py
@@ -143,6 +143,7 @@ def test_gpt_read_var(state_disk_image, u_boot_console):
             "size": "0x100000",
             "type": "0fc63daf-8483-4772-8e79-3d69d8477de4",
             "uuid": "33194895-67f6-4561-8457-6fdeed4f50a3",
+            "bootable": True,
         },
         {
             "name": "part2",
-- 
2.33.0

