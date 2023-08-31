Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A98EC83F2E
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 16:53:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ABF58685B;
	Thu, 31 Aug 2023 18:52:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XNbbFNge";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBB47866BB; Thu, 31 Aug 2023 18:52:15 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07C3D867D6
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:52:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6bc886d1504so883334a34.0
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 09:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693500731; x=1694105531; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lYb+MEMaFCMM9OAmqrRdfOBLgb+XlTK+voi+yCrY1AY=;
 b=XNbbFNgeUi2c1McTbiBGAK43YMhktfDrplVHNGSWpdDQ9X8pS+7sbKWdiFFhxW/PJV
 2jvtOCnLQ8OhW44l1HdeXmB4xMLU4vbZjBrprvGNrDg6Jo3uiJAaOpbyQZ0EbKpNa+wp
 0YZ6cps9xyBml6+myN+pILJxagERVpBHksi2fQQ9KTCHjl/ks83yU5Z9/YPVhtlVOXFd
 Msm8oDNKe9Gdjd2eoLIoxAc0tQl5kAK2jgG6gK8wzuksfpTDl3hSaEkZQRw8uYYxeU79
 JwiBtqOPIehREkSPlW6KjYG7NAS8I67lnerJ0swwggi6ZWJIqX02lrwbflhX+Ofyb4Yr
 NOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693500731; x=1694105531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lYb+MEMaFCMM9OAmqrRdfOBLgb+XlTK+voi+yCrY1AY=;
 b=ZOpMXQpRpBLwZWNDkqGE+/27jhL2ridJITYgXU9utcVUK4oBiD8RV+WXqsnpjplvSS
 8+J1v7JM7PJHk9Zc3wHz0aeP/sGh9RVRLdRVAvmSxDKfw97pu4jDOk71lj8Pl1Bypd5f
 1rK6skg0zHpeiqKxeR5GUdA4XtTV5npkmccB5kJIKBLgWla5sSeRupHj+K4e91EPZxJK
 ZvuSvL7/scnXcsZMkIEevxhMuivqcI9DDMLmXv+3vXoOyl8yrm6+ElFQlHuyAKMpY3y1
 SB3m7Dul3xu5JfGq1gP4pHmgWHnLdhJrdnmL8ed7QWOFAgnfgYMuoB98OE/t+PUNldkQ
 IeWQ==
X-Gm-Message-State: AOJu0YwF2FrizMxScVDufBRuiC7N7JoKEjGG60LmueVkIOIGobR3gcnk
 tjfEIEHQUQtmePf7ZYzhk2up2BoxVb4=
X-Google-Smtp-Source: AGHT+IFD5GqzpWPY1+pciE6fVyy6ATenmVaO6pw7ZkUNGCmPn1+/Hq/WP1Gxif0fmHv8o/OUunutOg==
X-Received: by 2002:a9d:65c6:0:b0:6bc:cd0d:427e with SMTP id
 z6-20020a9d65c6000000b006bccd0d427emr5974599oth.38.1693500731128; 
 Thu, 31 Aug 2023 09:52:11 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::b66b])
 by smtp.gmail.com with ESMTPSA id
 b15-20020a9d6b8f000000b006bb334880d8sm867020otq.81.2023.08.31.09.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 09:52:10 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Enric Balletbo i Serra <eballetb@redhat.com>
Subject: [PATCH v5 7/8] cmd: gpt: Preserve bootable flag
Date: Thu, 31 Aug 2023 10:51:40 -0600
Message-Id: <20230831165144.592820-8-JPEWhacker@gmail.com>
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
2.34.1

