Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB903C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 21:08:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 370C0879E4;
	Wed, 27 Dec 2023 22:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UwH4ZMBQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9433C878FF; Wed, 27 Dec 2023 22:08:16 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71BA08770A
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 22:08:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3bbbd4d2b4aso1060106b6e.0
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 13:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703711293; x=1704316093; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xgb2cKdn7cOAUVgfIbnLpCQYwhDWdtB6PDT7Tm5ir7U=;
 b=UwH4ZMBQ1+9+e61LK+4Ul1XGfZoRtzgqpF8PPr1V834O27trA9lhK5ZngZWBL9aH9S
 s/485EU8JnZXtvDMHk7Me+Rhs9WpUda4mfXj/j9joVcpNS4tAEOddN59Rfv6hScAsTck
 xKQ451Ff1keqs7EBYVBvmsY+BTfCJC13dbaQufwegLqLpy3hVqLUg6EfroSAJWB9QPwG
 MmSKt0OpOY8mGlR9Jn0l3PqzGsYiRprkTUdIiKKCU7M5MH7ttBekARKBI/v1Neteh5q7
 5JNsGL/qeXzYJDT6XQ+jBVOtXOHjXNWYaRdoqFExdPB0ctfqBdTlABOjbs3VDvtI0C6F
 4oNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703711293; x=1704316093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xgb2cKdn7cOAUVgfIbnLpCQYwhDWdtB6PDT7Tm5ir7U=;
 b=AaavCAckmeDkhgdP4ZFqx8wv5lW7g9OZNueMkswUCMco8cDXSDSjoDX9BQiUBzGb93
 sNhUdi6gRQDoqpCtPy3j8gonzrww3VeBakFyBSmWG3Fot7pjfoPqcxBhgF4StqiARvc0
 LiNljXhBzoG7CykvABzjuGbhWIDACIHT5QkhFWZJuVn8y0NX7E1kN6WV6KhJh6ThR5UM
 CVvMN3Yd8M6/l/+v+yHPQM8LSX3pBmR8r+gjtkbxWCZoB5yknpgKh6FmiAMUDZSZ+go0
 tFiBtjLZTpJQcMxnw7OH3nbDNVDT9qZzl9gYW1vtsjSvq31Zsk0UmN27h6XarXIaYwAj
 SasQ==
X-Gm-Message-State: AOJu0YzUw5mDP4rixwBxPLd/lytksYn6UyeOKb3hqRB3/5Y6RJEBvksV
 oQXur7chX7sWQXtrPb8zG0l1RhEtDxJf8kltSMgxwGIsMFw=
X-Google-Smtp-Source: AGHT+IFVjPILKYvtZejD3GeR4InGDRMwb1fEaRZb6ds533kXve7/+NNkEoGUHoij2oDYBNAp1pTRIw==
X-Received: by 2002:a05:6808:bd0:b0:3bb:93e7:8c3d with SMTP id
 o16-20020a0568080bd000b003bb93e78c3dmr7766783oik.8.1703711293038; 
 Wed, 27 Dec 2023 13:08:13 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 c27-20020a05620a11bb00b0078161897afcsm637107qkk.109.2023.12.27.13.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 13:08:12 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v4 08/12] bloblist: Handle alignment with a void entry
Date: Wed, 27 Dec 2023 13:07:06 -0800
Message-Id: <20231227210712.712937-9-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231227210712.712937-1-raymond.mao@linaro.org>
References: <20231227210712.712937-1-raymond.mao@linaro.org>
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
---
 common/bloblist.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 705d9c6ae9..73dbbc01c0 100644
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
+	new_alloced = data_start - map_to_sysmem(hdr) +
+		ALIGN(size, 1U << align_log2);
 
 	if (new_alloced > hdr->size) {
 		log_err("Failed to allocate %x bytes size=%x, need size=%x\n",
@@ -164,7 +179,7 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
 	rec = (void *)hdr + hdr->alloced;
 
 	rec->tag = tag;
-	rec->hdr_size = data_start - hdr->alloced;
+	rec->hdr_size = sizeof(struct bloblist_rec);
 	rec->size = size;
 
 	/* Zero the record data */
-- 
2.25.1

