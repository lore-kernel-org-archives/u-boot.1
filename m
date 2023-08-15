Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5765C001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 16:28:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D23CC869AD;
	Tue, 15 Aug 2023 18:28:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YXv8BA8z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E40D5869F4; Tue, 15 Aug 2023 18:28:03 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2B98869AB
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 18:28:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1c4af84667bso2826059fac.1
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 09:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692116875; x=1692721675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N3x87ISuThCwxAXeGOpgTSzjHcDwylELLiW5fTw25xE=;
 b=YXv8BA8z6DzT0Yx0vlqJ9GB6oK9/qRMpYDZD9FZ699VHuLDE6TJSEXja8DBVTL/0vK
 Q1m4UWeAgtM/un59OjJhnxP+7gF1bwIqt2OTbJh03evA7C/6bdCO1tCtqIzNEPDgI2FE
 UDOjwQAM4XtHvY11+04MpWxzYwv9/ICJhBA6cEkGQ7rulj1BabNI9GwBuCqbHmVffiN5
 m4l4oUK7j7t15dwZ3RDxQVAXzixm1DP+ztmgepcloeEnmNrurwF8cpKsEQ3TmGYhTvlT
 U7vmShkKzM4QWsBROnt9fV4XXLNAGzIkrgr7GXp6uCGhNgBz4QYf6PRyL8ig9jlWE9+M
 g+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692116875; x=1692721675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N3x87ISuThCwxAXeGOpgTSzjHcDwylELLiW5fTw25xE=;
 b=O+Z+mzWzEArPM7Sjh+P7qjJM5Oc8SDyeqdDT0KgVihEdhf+N7Di1jVynaKpwWqOzka
 0z2QZ3tioUjTpSYCmz4Cqu3rxP24w4c9lAJ6F9HiwxBTTAKmJLeNqNg+mTChkvvqgkHE
 UFNMKIkIn3+s8DS/aIKxxkAZQPK+VKORul0O5U5EnN0o80J56U43nsN/KWLuq5Y4FBdc
 E+6Zsx/N9Z47Zm2KQ1qMnFpxEqZHVqbSleCje3h0R+FT/wfE4my5uk+GKqJGEOJMDj44
 YjOO3Ik5lChmnUgjVjmT9PlR1a1gNJQrUKmVnANTTGCqeu9sXWNpiHOpeEJswQZ2q0I0
 ipUw==
X-Gm-Message-State: AOJu0Yw8KZckD2nBJFlE9PrvE6zyI1wfL4/j+pkyKL7t45IRRledcXlg
 Am5GvNYF3Jrfn/W8At/tYRPEET8sPcs=
X-Google-Smtp-Source: AGHT+IGwzEwZ322CVMp85b6daDSOISQPH36poOogmacg75RnuMCPzjb7EIp7jYvIiuRPEsLVJvZBtg==
X-Received: by 2002:a05:6871:554:b0:1be:c87d:c670 with SMTP id
 t20-20020a056871055400b001bec87dc670mr13317156oal.47.1692116874933; 
 Tue, 15 Aug 2023 09:27:54 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6897])
 by smtp.gmail.com with ESMTPSA id
 zf26-20020a0568716a9a00b001c4f840e7bbsm2474441oab.47.2023.08.15.09.27.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 09:27:54 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [PATCH 5/6] cmd: gpt: Preserve bootable flag
Date: Tue, 15 Aug 2023 10:26:59 -0600
Message-Id: <20230815162726.1524958-6-JPEWhacker@gmail.com>
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

Sets the bootable flag when constructing the partition string from the
current partition configuration. This ensures that when the partitions
are written back (for example, when renaming a partition), the flag is
preserved.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 cmd/gpt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/cmd/gpt.c b/cmd/gpt.c
index c6fbd94ba2..58564436d3 100644
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
-- 
2.33.0

