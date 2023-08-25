Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0D8C3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 19:39:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3D6D86B18;
	Fri, 25 Aug 2023 21:39:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BUxp5KDb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D04C286B18; Fri, 25 Aug 2023 21:39:03 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CDFC86AE7
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 21:39:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6bd0a0a6766so911502a34.2
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 12:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692992339; x=1693597139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UyVmFY05PN1bHxu6ZEysTqtWkkAvwcl3ZjdbXDm9EAc=;
 b=BUxp5KDbvNkbclZBRNmBZYmX6tyihLcYpbnbAZAbOBpsLn34bDkrFQzA72/01oUfkO
 PwaLBxXdtun/JPQvqYGITpN5Ec/GKQ7tP4BqYWhfHU/c5vYaxCIJsW7aQtadkeNIa64z
 Eyl2aMN/KTJ40HrZ/LfNnb1rpSGnWrfsaOyWoFP3T0UfuLfk3QzZK0KjKLFZ+bNq6idf
 aJWRreIiSsj7POoFE/Njy37YpMHNklE93RMV4sCbRF1L8Atu1K12wGGq3ICQGynwLRyK
 xV/HDBxeUMLr3P7ZQsa+52CRN94yF3eHb1LgXqtCNfTDkjo/upYUJHz/zFiVvI8MiyDM
 2cDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692992339; x=1693597139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UyVmFY05PN1bHxu6ZEysTqtWkkAvwcl3ZjdbXDm9EAc=;
 b=Cb3h00F7dq0SKYFuh7X7XV7sJdINXgOYxDrGX32hZkvBx4WuaUoEm9+th9oQpsY5Vv
 SE7pKpklpBsXVMcxaf4r422WGjdBlFYRi7b1wKxPcd5kVVp4cSjZNnEAI7vIC/Jcbd9L
 ffCCBUnqHdvzFV8KNoWo0/afbycWTpd25R8H4DcJfiAh93qQ5nP0vgjK/uNptwnvaLB3
 3wCck4XfUHM5zvbHGs7SFjwZw/sVR+g9s7AfIxqtM5H/bk1SKRuVhLaoqAvpBDlEXbLe
 V02fWC+y1qLcXbs6MEkOQWOao1GAmN0o18h3luAWdA3sTo1wwAxz5L1QS8gADq8Ktyrv
 zAQA==
X-Gm-Message-State: AOJu0YzYRiFYuArsPja33Dg7r0rpCXjDZyox/Y/9TahDFv1jzVPGtJI5
 y2ZO0Uut6Fqa2gittQaGYqIaJb8ABgU=
X-Google-Smtp-Source: AGHT+IH216pOyVLCaftuRZx9R1aA4H10RjU+i1wTBcXPRZtfz/sRTJgpB911xgoX7Lbs6EBiF+Ujqw==
X-Received: by 2002:a05:6830:1e49:b0:6b9:742a:750e with SMTP id
 e9-20020a0568301e4900b006b9742a750emr6294203otj.2.1692992339197; 
 Fri, 25 Aug 2023 12:38:59 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::c239])
 by smtp.gmail.com with ESMTPSA id
 m13-20020a9d7e8d000000b006b871010cb1sm1171022otp.46.2023.08.25.12.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 12:38:58 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>, Simon Glass <sjg@chromium.org>,
 Enric Balletbo i Serra <eballetb@redhat.com>
Subject: [PATCH v3 7/8] cmd: gpt: Preserve bootable flag
Date: Fri, 25 Aug 2023 13:38:23 -0600
Message-Id: <20230825193830.2753640-8-JPEWhacker@gmail.com>
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
index b7d861aa1e..0479b3a6a4 100644
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
index 09a90f026f..666d387ac8 100644
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

