Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D092C47074
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:44:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF76B87B8F;
	Fri, 29 Dec 2023 18:43:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gyoFk8/U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63E2D87B84; Fri, 29 Dec 2023 18:43:30 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B23D87B8F
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:43:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-78117e97becso456627985a.3
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 09:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703871806; x=1704476606; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GourHar+ggLddfD2JCI6fj9/BDrKA96Q5UNKVu/VWKc=;
 b=gyoFk8/Uak0JXqnazqq56wx5XjnZwhd30iyTJfpeHqOsFradD/IE08ZDVEV6aVuW2o
 GXi+fjk84+7xe4R9Qj9Mrbtoy4djSK+7RvzF1vH2Dcvx5ENrq1qFEtTlMPJ7PtY+IfwU
 ut680jRhQsva2NB2L4FwMDHZZ9gcS8YgI6C3bu8hhKDC03xSXYTW9A28Bhvd6fwKi3sL
 JoCJspShOEuhAzKTll1M/7gJHkPArWtBCzmKLzTpzQ4g9cjrWXAoEFk1LBUrvknR51zw
 yidsR3XUe/BcEOVAeQNr1SdtL4HHtMMr8XIqmkP4GRTasFbJCohhbjqkrR+UXmvkJbEi
 yCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703871806; x=1704476606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GourHar+ggLddfD2JCI6fj9/BDrKA96Q5UNKVu/VWKc=;
 b=lvxnAvvtEmAbEWlM6FhxSZWY6Zoe21BQfKD+wRDQVfWJLrZCgs29JMEVU557wZhmky
 1kSc4vgP67WJf+sm/UsY5XMlme40LFhQ7cg+MQxASIlttVLWmJ7MUbhsIF41gvH+ONWc
 rrpn1snlFAUc0MV9agBpKFzTs7LiKx+Z651SYqLG3YlP1IRrktRykpees8nMhIKnqJGo
 AZgSvdo3rK1Nm0LSx6Xt1ULFNTJ7cix6whEvVAXoGy9maLimFXv3T8xogRcD2C9VDREw
 UAsAD7PXfXAEaAwGAuMS1Q4dGSYydZ59QDXxOW7wH9iup9vD0vWbHljfQYwZLbqNLRV+
 aRqQ==
X-Gm-Message-State: AOJu0Ywo9SxtoflNkYqTIizZE1m6OSArzPotwM15y08M3dL2tqiUM8Uh
 2BOgtWjLVCxCRPG93kEI5HAjdFTO/K26DVSQYbh2r38xsgg=
X-Google-Smtp-Source: AGHT+IFQVqdz0QaPs8e3dcLMembDeBNRJeH1NoZoHOjgpP+OHeBeIx/bEQ0AVd78AvVn69lVQu0/pA==
X-Received: by 2002:a05:620a:229:b0:77d:8946:11c3 with SMTP id
 u9-20020a05620a022900b0077d894611c3mr12212350qkm.34.1703871805857; 
 Fri, 29 Dec 2023 09:43:25 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a05620a122b00b007817084e7basm1545849qkj.99.2023.12.29.09.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 09:43:25 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v5 05/11] bloblist: Access record hdr_size and tag via a
 function
Date: Fri, 29 Dec 2023 09:42:37 -0800
Message-Id: <20231229174244.892818-6-raymond.mao@linaro.org>
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

Convert accesses to tag and hdr_size via function for grouping tag and
hdr_size together later.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

