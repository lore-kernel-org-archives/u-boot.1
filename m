Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52821C47073
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:44:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFE4887B82;
	Fri, 29 Dec 2023 18:43:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GJTYQMbN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 303CD87B82; Fri, 29 Dec 2023 18:43:36 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10DDF87B7D
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:43:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-781161d18ecso538374785a.3
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 09:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703871812; x=1704476612; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KBjhY1hnygDY4YXM42DmxuiDO/i1MXDnzLYNLl7ug2Y=;
 b=GJTYQMbNm14zIfTOy6gTivwF0mFo0Gv5Z+bKd+51+wGiMRK/FD8/HUu69dTWvuYfZg
 a8LFP0ABR4iQrMYyjjIBAq3tP1BQEM7Jlvl9eb1MT3YXDuIKif/ffqjO0s5NQMaZ+k5Z
 ygxDEzuW1DZgyOGxAa0jpFFPr7OvCXlcmz9bTz13/QielXW2d6ehobw3Y2q5OufMqeMT
 3yQPhlNNtCVF1gyYTjd6INthP7UPfPV4aAA2Of2J//QmA6lrRaiXYLDKJW1LhREoS8Fo
 xDbVxxZn1iAC9lp16TUQ/1g97nQKp1K9lIVGyPhqr/0fUB3jMyWzsWtE4YwWuzr0pHnq
 QRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703871812; x=1704476612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KBjhY1hnygDY4YXM42DmxuiDO/i1MXDnzLYNLl7ug2Y=;
 b=p1bKrVt/ifFbDJRty/ZH3iDHe2MU5FcoUSerV4Wsj43dNw+h+meAPE/XXXcvaG4Lb1
 kuKHr/b3IjP+4mKRhPyWyHVeGXvHAdD+sARoWAL3yi6Ab1gmeCM/ZNDc+7xlW+h1laMe
 f4YPsUtGvviyIW6KpYG2cMAAC83AK9zZQExRcqhOkdg0hGfoT5Fo4SnB6ERCyZcRyMnW
 S6acH8RruAqbuzMwbDYCNqmBV3wZ8NE1qdEzskKufUPhY+vG31xmYTs42XHhfe3VUR+I
 UM/Budln6lb8KDLDcg1gP/Dt5wrpPIBgzexNYQmCN679u1qin4pjF0x/AA8XwKoE4ykP
 VhkQ==
X-Gm-Message-State: AOJu0YxbsekcXgaGdHcCujZrCfmor65GYy2UV01DzI6BrrHN/7xBa8CV
 3PANZ/NcNOeN9DQ+MB0XyOZ3QmVACET8kl0BY/2rvyGmCb0=
X-Google-Smtp-Source: AGHT+IEjaRIYiF5pXK1ckBGtjUIlWktz2IaqfF2iE2ZfulUQUvKpaBtYF9XJoiFUIyrvWeWiReRp3A==
X-Received: by 2002:a05:620a:44c3:b0:781:6359:e49e with SMTP id
 y3-20020a05620a44c300b007816359e49emr4628636qkp.20.1703871812502; 
 Fri, 29 Dec 2023 09:43:32 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a05620a122b00b007817084e7basm1545849qkj.99.2023.12.29.09.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 09:43:32 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v5 07/11] bloblist: Handle alignment with a void entry
Date: Fri, 29 Dec 2023 09:42:39 -0800
Message-Id: <20231229174244.892818-8-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231229174244.892818-1-raymond.mao@linaro.org>
References: <20231229174244.892818-1-raymond.mao@linaro.org>
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

From: Simon Glass <sjg@chromium.org>

Rather than setting the alignment using the header size, add an entirely
new entry to cover the gap left by the alignment.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v5
- Optimize how to calculate the new allocated size.

 common/bloblist.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 5b88c6c6a8..da688fe149 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -142,7 +142,7 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
 {
 	struct bloblist_hdr *hdr = gd->bloblist;
 	struct bloblist_rec *rec;
-	int data_start, new_alloced;
+	int data_start, aligned_start, new_alloced;
 
 	if (!align_log2)
 		align_log2 = BLOBLIST_ALIGN_LOG2;
@@ -151,10 +151,25 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
 	data_start = map_to_sysmem(hdr) + hdr->alloced + sizeof(*rec);
 
 	/* Align the address and then calculate the offset from ->alloced */
-	data_start = ALIGN(data_start, 1U << align_log2) - map_to_sysmem(hdr);
+	aligned_start = ALIGN(data_start, 1U << align_log2) - data_start;
+
+	/* If we need to create a dummy record, create it */
+	if (aligned_start) {
+		int void_size = aligned_start - sizeof(*rec);
+		struct bloblist_rec *vrec;
+		int ret;
+
+		ret = bloblist_addrec(BLOBLISTT_VOID, void_size, 0, &vrec);
+		if (ret)
+			return log_msg_ret("void", ret);
+
+		/* start the record after that */
+		data_start = map_to_sysmem(hdr) + hdr->alloced + sizeof(*vrec);
+	}
 
 	/* Calculate the new allocated total */
-	new_alloced = data_start + ALIGN(size, 1U << align_log2);
+	new_alloced = hdr->used_size + sizeof(*rec) +
+		      ALIGN(size, 1U << align_log2);
 
 	if (new_alloced > hdr->size) {
 		log_err("Failed to allocate %x bytes size=%x, need size=%x\n",
@@ -164,7 +179,7 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
 	rec = (void *)hdr + hdr->alloced;
 
 	rec->tag = tag;
-	rec->hdr_size = data_start - hdr->alloced;
+	rec->hdr_size = sizeof(struct bloblist_rec);
 	rec->size = size;
 	rec->spare = 0;
 
-- 
2.25.1

