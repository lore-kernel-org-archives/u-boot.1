Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3892C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 21:08:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B95188798B;
	Wed, 27 Dec 2023 22:08:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="peOeM6l2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C665879D3; Wed, 27 Dec 2023 22:08:02 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 344268798B
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 22:08:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7810c332a2cso472556985a.1
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 13:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703711278; x=1704316078; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CG1IKF8DB3ZJdWqawoRvyPo/GvjGRdLlQ/EAMpFzTk0=;
 b=peOeM6l2tFrUeTMyFWfd7WRaoVwP4/BtVdpkcaxTYUz180mKZvA+ky7ijQTbEDVL4b
 A4q9776CPj4CPZ/cOX7b1V2F1ch2i1nm/lB2FJYiZjJCbWkAqj7vShkn47IdH3NpcO67
 /0DujXrMY5oMSNbOVjmI6/co9Z2nUJ2xtkBWdFoQiRmWIvhtxDerbCxWmfj4TgRREoiU
 2lxSLNaqXFWhIz+MOn4K2JmB8KL76a4H4oDocIjPYBAKKrSV21REZoEMrR6vftV5xUlq
 ua66TIrOVjC/czbY/VHNRtNJcA3DUtzY0/HHiCc6R4rVuV25K0AA8xsa7ONDPIgKN4mG
 lAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703711278; x=1704316078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CG1IKF8DB3ZJdWqawoRvyPo/GvjGRdLlQ/EAMpFzTk0=;
 b=ghFAZS/VMpMr9lIwj/DIusY3xYpTjyvmsRV60US/kgRLl24rBMNG9UaS0z8POIby9Y
 w6PR5aDfDiJjBn4V2RzbH0sqIN/nMF2MtN00cKlt8uG1CwA/Auq4itXC4puSL1seY66A
 QuS2NPw8dOvjy8e9oejAAt/sepuTejVxG2HmhM4vfTNIYx01KHmNIkqEeteazzV07Oin
 QY6FGUHinS5Q/kZSz6T35WAm1ze7UCeQ6D+3xhMPe9HbBHxwsdXjIVJxrN5F621QoIEb
 /f4c+qJhsjY0FJyCucI+tCzSINEQNVkkQf02025ylAn12ZuViLXD5DCANPwK4Kr5iu7g
 Fwsg==
X-Gm-Message-State: AOJu0YzuABpcp7CEFds62Vc4poDikaxMOkMOjcJkmhNll5K9nFeJiHpi
 uoHbvrJMBwhl+MeSAzkxfuZw0ZyGnpb+1UKkcSuT9+NUOAk=
X-Google-Smtp-Source: AGHT+IEWJHO/OPX2cxNP2acsuTPpx/ROPWXoKHbud3LvHRmGdMc46vsVU1V1PKH+IyoSWtw1CcD6Fg==
X-Received: by 2002:a05:620a:55ba:b0:781:6d93:5c56 with SMTP id
 vr26-20020a05620a55ba00b007816d935c56mr733467qkn.152.1703711278642; 
 Wed, 27 Dec 2023 13:07:58 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 c27-20020a05620a11bb00b0078161897afcsm637107qkk.109.2023.12.27.13.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 13:07:58 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v4 05/12] bloblist: Access record hdr_size and tag via a
 function
Date: Wed, 27 Dec 2023 13:07:03 -0800
Message-Id: <20231227210712.712937-6-raymond.mao@linaro.org>
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

Convert accesses to tag and hdr_size via function for grouping tag and
hdr_size together later.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v3
- Update commit message.

 common/bloblist.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 1e78a3d4b3..168993e0a7 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -84,13 +84,23 @@ static struct bloblist_rec *bloblist_first_blob(struct bloblist_hdr *hdr)
 	return (struct bloblist_rec *)((void *)hdr + hdr->hdr_size);
 }
 
+static inline uint rec_hdr_size(struct bloblist_rec *rec)
+{
+	return rec->hdr_size;
+}
+
+static inline uint rec_tag(struct bloblist_rec *rec)
+{
+	return rec->tag;
+}
+
 static ulong bloblist_blob_end_ofs(struct bloblist_hdr *hdr,
 				   struct bloblist_rec *rec)
 {
 	ulong offset;
 
 	offset = (void *)rec - (void *)hdr;
-	offset += rec->hdr_size + ALIGN(rec->size, BLOBLIST_ALIGN);
+	offset += rec_hdr_size(rec) + ALIGN(rec->size, BLOBLIST_ALIGN);
 
 	return offset;
 }
@@ -119,7 +129,7 @@ static struct bloblist_rec *bloblist_findrec(uint tag)
 		return NULL;
 
 	foreach_rec(rec, hdr) {
-		if (rec->tag == tag)
+		if (rec_tag(rec) == tag)
 			return rec;
 	}
 
@@ -158,7 +168,7 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
 	rec->spare = 0;
 
 	/* Zero the record data */
-	memset((void *)rec + rec->hdr_size, '\0', rec->size);
+	memset((void *)rec + rec_hdr_size(rec), '\0', rec->size);
 
 	hdr->alloced = new_alloced;
 	*recp = rec;
@@ -199,7 +209,7 @@ void *bloblist_find(uint tag, int size)
 	if (size && size != rec->size)
 		return NULL;
 
-	return (void *)rec + rec->hdr_size;
+	return (void *)rec + rec_hdr_size(rec);
 }
 
 void *bloblist_add(uint tag, int size, int align_log2)
@@ -209,7 +219,7 @@ void *bloblist_add(uint tag, int size, int align_log2)
 	if (bloblist_addrec(tag, size, align_log2, &rec))
 		return NULL;
 
-	return (void *)rec + rec->hdr_size;
+	return (void *)rec + rec_hdr_size(rec);
 }
 
 int bloblist_ensure_size(uint tag, int size, int align_log2, void **blobp)
@@ -220,7 +230,7 @@ int bloblist_ensure_size(uint tag, int size, int align_log2, void **blobp)
 	ret = bloblist_ensurerec(tag, &rec, size, align_log2);
 	if (ret)
 		return ret;
-	*blobp = (void *)rec + rec->hdr_size;
+	*blobp = (void *)rec + rec_hdr_size(rec);
 
 	return 0;
 }
@@ -232,7 +242,7 @@ void *bloblist_ensure(uint tag, int size)
 	if (bloblist_ensurerec(tag, &rec, size, 0))
 		return NULL;
 
-	return (void *)rec + rec->hdr_size;
+	return (void *)rec + rec_hdr_size(rec);
 }
 
 int bloblist_ensure_size_ret(uint tag, int *sizep, void **blobp)
@@ -245,7 +255,7 @@ int bloblist_ensure_size_ret(uint tag, int *sizep, void **blobp)
 		*sizep = rec->size;
 	else if (ret)
 		return ret;
-	*blobp = (void *)rec + rec->hdr_size;
+	*blobp = (void *)rec + rec_hdr_size(rec);
 
 	return 0;
 }
@@ -281,7 +291,7 @@ static int bloblist_resize_rec(struct bloblist_hdr *hdr,
 
 	/* Zero the new part of the blob */
 	if (expand_by > 0) {
-		memset((void *)rec + rec->hdr_size + rec->size, '\0',
+		memset((void *)rec + rec_hdr_size(rec) + rec->size, '\0',
 		       new_size - rec->size);
 	}
 
@@ -315,8 +325,9 @@ static u32 bloblist_calc_chksum(struct bloblist_hdr *hdr)
 	chksum = crc32(0, (unsigned char *)hdr,
 		       offsetof(struct bloblist_hdr, chksum));
 	foreach_rec(rec, hdr) {
-		chksum = crc32(chksum, (void *)rec, rec->hdr_size);
-		chksum = crc32(chksum, (void *)rec + rec->hdr_size, rec->size);
+		chksum = crc32(chksum, (void *)rec, rec_hdr_size(rec));
+		chksum = crc32(chksum, (void *)rec + rec_hdr_size(rec),
+			       rec->size);
 	}
 
 	return chksum;
@@ -424,8 +435,9 @@ void bloblist_show_list(void)
 	for (rec = bloblist_first_blob(hdr); rec;
 	     rec = bloblist_next_blob(hdr, rec)) {
 		printf("%08lx  %8x  %4x %s\n",
-		       (ulong)map_to_sysmem((void *)rec + rec->hdr_size),
-		       rec->size, rec->tag, bloblist_tag_name(rec->tag));
+		       (ulong)map_to_sysmem((void *)rec + rec_hdr_size(rec)),
+		       rec->size, rec_tag(rec),
+		       bloblist_tag_name(rec_tag(rec)));
 	}
 }
 
-- 
2.25.1

