Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB1BC4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 19:53:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BABD5877BB;
	Mon, 27 Nov 2023 20:52:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MSwefjKI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A628877B6; Mon, 27 Nov 2023 20:52:34 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08A11877CE
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 20:52:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6d8029dae41so2213096a34.0
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 11:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701114748; x=1701719548; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nX6ZN+Gt3SRTsUM62vtsImzwiUCNqN4j44y3GDY/mOY=;
 b=MSwefjKIJniNc/jyJSUIhSLFeWo7r0e4F2io7oyWi8Ye8T4w06wovNESK4L3WPGt/r
 WSItoYGbSwoQvHJxEvXiK/WUrGbMzVCvUJyZ7bwKDSWyZvtHyhWG5/Opfu5uFgxObrsN
 mruAAk2xdhtu0t07CxIBevyk/RP9g2/aZ55J1rOASwKh9rAB1yUbtWFvtbmgDD5UeFiD
 3Q0MSi2siIFveH+eoyHTP4LOjUg4/bHyxgnwB6DsTcxLRLNVcKuz4o9ezP/8QcUCdf5G
 /PWcMDdZWJkO/J/hFvyMa+jkkNpVxnuMJxCfHpMRULRLvMv2iMFpGE20rnRPBH4dLd2G
 5KZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701114748; x=1701719548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nX6ZN+Gt3SRTsUM62vtsImzwiUCNqN4j44y3GDY/mOY=;
 b=SIYDVggYFM27yWS8LwpXFJVNcPgPz0Vao4ArGYRL2JWAqNlCO4us8TFQelm2MSo/9H
 9QIwksXvQVrKEPS3Vvk+BSTKtGthSr/K8jZDblhjLcd2wS/L96SyWCjYjaDlmrFysMql
 4wI3I+HXJq1vjxeHshk3oK6L9MY/D1zuh43LyWxxvHXeEiXrkSaSt1CCoX6/v9ti0Pj/
 f2aQyrws8o3BgXPfaQBzp2IrGctP0MFo9f5WXS+Icjx2e8iku4VOR6WJTJnyLTuvF9kl
 hC+rrjGlgtOG5OdctZ/4h6E+XsfozJXCO0xFi0Kpzn5h+kpZles8IklP50mASAGARaa4
 3jfA==
X-Gm-Message-State: AOJu0YxQtLU7OHLyMyHULCMnS9iZBTpTTKBeZ9+3aVejo90ij6FCjP9o
 WWQbmAgpCa7RirhSa5bOL9yYh0zGzRx8jVVUOaC+/g==
X-Google-Smtp-Source: AGHT+IGXhYo6Zti/8FKFmK+tk3dZ4aeklhrbbY4u54mwRv6uLdYHliyfbuQBoeoRkx8ORw1u7UPE7Q==
X-Received: by 2002:a9d:6f90:0:b0:6ce:29cd:b663 with SMTP id
 h16-20020a9d6f90000000b006ce29cdb663mr15608506otq.8.1701114748515; 
 Mon, 27 Nov 2023 11:52:28 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 g6-20020ad45106000000b0067a2061fc21sm3087047qvp.101.2023.11.27.11.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 11:52:28 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de,
	ilias.apalodimas@linaro.org,
	sjg@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Nikhil M Jain <n-jain1@ti.com>,
 Baruch Siach <baruch@tkos.co.il>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Qu Wenruo <wqu@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 05/18] bloblist: Access record hdr_size and tag via a
 function
Date: Mon, 27 Nov 2023 11:50:16 -0800
Message-Id: <20231127195029.90951-6-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231127195029.90951-1-raymond.mao@linaro.org>
References: <20231127195029.90951-1-raymond.mao@linaro.org>
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

These values currently use a simple field. With spec v0.9 they have moved
to a packed format. Convert most accesses to use functions, so this change
can be accomodated.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 common/bloblist.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index e744c2b0c0..f084a32cfc 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -82,13 +82,23 @@ static struct bloblist_rec *bloblist_first_blob(struct bloblist_hdr *hdr)
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
@@ -117,7 +127,7 @@ static struct bloblist_rec *bloblist_findrec(uint tag)
 		return NULL;
 
 	foreach_rec(rec, hdr) {
-		if (rec->tag == tag)
+		if (rec_tag(rec) == tag)
 			return rec;
 	}
 
@@ -156,7 +166,7 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
 	rec->spare = 0;
 
 	/* Zero the record data */
-	memset((void *)rec + rec->hdr_size, '\0', rec->size);
+	memset((void *)rec + rec_hdr_size(rec), '\0', rec->size);
 
 	hdr->alloced = new_alloced;
 	*recp = rec;
@@ -197,7 +207,7 @@ void *bloblist_find(uint tag, int size)
 	if (size && size != rec->size)
 		return NULL;
 
-	return (void *)rec + rec->hdr_size;
+	return (void *)rec + rec_hdr_size(rec);
 }
 
 void *bloblist_add(uint tag, int size, int align_log2)
@@ -207,7 +217,7 @@ void *bloblist_add(uint tag, int size, int align_log2)
 	if (bloblist_addrec(tag, size, align_log2, &rec))
 		return NULL;
 
-	return (void *)rec + rec->hdr_size;
+	return (void *)rec + rec_hdr_size(rec);
 }
 
 int bloblist_ensure_size(uint tag, int size, int align_log2, void **blobp)
@@ -218,7 +228,7 @@ int bloblist_ensure_size(uint tag, int size, int align_log2, void **blobp)
 	ret = bloblist_ensurerec(tag, &rec, size, align_log2);
 	if (ret)
 		return ret;
-	*blobp = (void *)rec + rec->hdr_size;
+	*blobp = (void *)rec + rec_hdr_size(rec);
 
 	return 0;
 }
@@ -230,7 +240,7 @@ void *bloblist_ensure(uint tag, int size)
 	if (bloblist_ensurerec(tag, &rec, size, 0))
 		return NULL;
 
-	return (void *)rec + rec->hdr_size;
+	return (void *)rec + rec_hdr_size(rec);
 }
 
 int bloblist_ensure_size_ret(uint tag, int *sizep, void **blobp)
@@ -243,7 +253,7 @@ int bloblist_ensure_size_ret(uint tag, int *sizep, void **blobp)
 		*sizep = rec->size;
 	else if (ret)
 		return ret;
-	*blobp = (void *)rec + rec->hdr_size;
+	*blobp = (void *)rec + rec_hdr_size(rec);
 
 	return 0;
 }
@@ -279,7 +289,7 @@ static int bloblist_resize_rec(struct bloblist_hdr *hdr,
 
 	/* Zero the new part of the blob */
 	if (expand_by > 0) {
-		memset((void *)rec + rec->hdr_size + rec->size, '\0',
+		memset((void *)rec + rec_hdr_size(rec) + rec->size, '\0',
 		       new_size - rec->size);
 	}
 
@@ -313,8 +323,9 @@ static u32 bloblist_calc_chksum(struct bloblist_hdr *hdr)
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
@@ -422,8 +433,9 @@ void bloblist_show_list(void)
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

