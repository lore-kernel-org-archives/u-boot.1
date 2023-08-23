Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940D6C3DA66
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 16:49:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED09C864D5;
	Wed, 23 Aug 2023 18:48:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fzz8ZENp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7923864D5; Wed, 23 Aug 2023 18:48:38 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC6D9864E6
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 18:48:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1c8d2606fc9so23001fac.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 09:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692809315; x=1693414115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X4WRelxrRAnOqFmLGQmdg7zW11nwR+XMf4BJDFkDnZM=;
 b=fzz8ZENpvieXG/SLAQZWtUqfawYZtnByt5/ExeTvfaVhez9d9BD+o/xUizJ2Lwey1Q
 ymQlL30mNSecPDYYbPHBHznnRMh5upvqriPboqf6OpV+6TfEH+5sPgpdgFnvXxVZl+es
 5j+KoThTBBHdIvTRmLYpxkRJmDvXNRTHmobVKGV6IkI0Q/reZ+5An8sNFy6CX5o77LwU
 GG/ufyxXcYvyuNmTYmYKur5mV4LfNR9zI1FTP9STVNAreq6Nq50CM4tvvcDDbYHD9Qvc
 yKYDVZk6HJBPl2p6SrYezPpmnFqCSFr7eanh0UrJJJo5NHnvvteWzd9PyNoMlchMetaP
 jBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692809315; x=1693414115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X4WRelxrRAnOqFmLGQmdg7zW11nwR+XMf4BJDFkDnZM=;
 b=kQI3sJ4ALQJNjU7byOmOit2gN0bSfN5j4Pq01R3ca/blY51e0v4fyhBoMIVL3Gh9Dq
 qvFewA/NCv2UdaVqbbLW01zgTq2GJKlTPdYbihCO5BIsQYnm6WlNo/uiXBk0tiCe3mXP
 UXqmeIUYCyx54TyevI+DBSwS5+fDq9r+4o8TEO96j4b/gJ+ObTdNTIGjrD2m3RVG0FyH
 7Y5Mg8WBcPPElPPbNgRFMQ2BayhapbzOUhaIInwasFS+WtnV+127OmCxHMjcKtLQHQmi
 YUqtqKAoKy58xMTmMo6iiVlERC43ksG9JjhvUaUrImxUV6iP3w1SkNKs4gD4y7UAEJHD
 JC0w==
X-Gm-Message-State: AOJu0YyowjpJXzJcQH1MF6FKVES9KaWFxbhsHZf/kQXpwuIcI0RTSwDg
 vtyyNsfYMNLnPkWDEE4XCeJEhqOOfF0=
X-Google-Smtp-Source: AGHT+IG77aOyR894aRwkuXvOdofx8q1Ue3Xln6Spsq883JHbxzLniy4Q8CAEEDhSjoB5jhxdCgl4Mg==
X-Received: by 2002:a05:6871:821:b0:1c0:a784:cf5a with SMTP id
 q33-20020a056871082100b001c0a784cf5amr7654375oap.27.1692809314759; 
 Wed, 23 Aug 2023 09:48:34 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::751c])
 by smtp.gmail.com with ESMTPSA id
 f22-20020a056830205600b006b9cb784553sm5794042otp.36.2023.08.23.09.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 09:48:34 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>, Simon Glass <sjg@chromium.org>,
 Enric Balletbo i Serra <eballetb@redhat.com>
Subject: [PATCH v2 7/8] cmd: gpt: Preserve bootable flag
Date: Wed, 23 Aug 2023 10:47:43 -0600
Message-Id: <20230823164755.2874792-8-JPEWhacker@gmail.com>
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
index fdd9c429f6..90a60fce8b 100644
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
index f9351f0274..6d79d07b09 100644
--- a/test/py/tests/test_gpt.py
+++ b/test/py/tests/test_gpt.py
@@ -134,6 +134,7 @@ def test_gpt_read_var(state_disk_image, u_boot_console):
             "size": "0x100000",
             "type": "0fc63daf-8483-4772-8e79-3d69d8477de4",
             "uuid": "33194895-67f6-4561-8457-6fdeed4f50a3",
+            "bootable": True,
         },
         {
             "name": "part2",
-- 
2.33.0

