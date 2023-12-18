Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C15EC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 18:20:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26723874ED;
	Mon, 18 Dec 2023 19:20:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HrS53/j5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FE9F870D5; Mon, 18 Dec 2023 19:20:00 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02DA9874ED
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 19:19:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-67f0cfd3650so28108646d6.3
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 10:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702923596; x=1703528396; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CG1IKF8DB3ZJdWqawoRvyPo/GvjGRdLlQ/EAMpFzTk0=;
 b=HrS53/j5CQw3vjrnADpf1ckbxD/BGMUPHmPndcNsDu44UFo3KVH8vDTwPsTXVtl5tX
 pHmvHXqdOQ9vKShWu+RCXUFX9qXzylCAWRUKG4VlirH3zk8a1oSWHy3aH6WKp3Lrq7sd
 i1hIumq/K+Vg0OrvN8TQnjPCA8a244wgRcYkRAK3zyaLq6eLXvFJWkx5Szw7y9mf2p4X
 ti5VeaN8+3YGiWUJTBXxDsIm3Whl67fJx19cMLmpK/vPNFlKqBQdicAHuHBsY+41Jeoq
 j/RlCdJco1nxpn/GIvkPJZJDyTT4lEX1e6j/wCh60qJzBVqKsPDUMTM+t/F0Ulu3RGGM
 CiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702923596; x=1703528396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CG1IKF8DB3ZJdWqawoRvyPo/GvjGRdLlQ/EAMpFzTk0=;
 b=Nc27VoMnM8heAg+e/Dfa0AOaOEKSTCgYzRfPTswzowMy9R420YIyiGdd2ApT/vAg0v
 38TxKvZEKidnYvriuHopKpdRz2QKx/xQ0Ij6SECrYjxn8ABANPp17oZoTOA2UVIms6el
 b6q3UDQxjw3dYXNRhL8biu7BYGcald3xlFhWsfWROdOd3TiVD9gQtKK0Pm4ZcFpmWky3
 QYNb5OqLsbf7LJg91aougO8Y00WLicxfm1Zti7PedvvW5PDuhWaP1lKdkiMUafXzd/od
 62Ft8v1WdksUn6JfX0yFbfBP4OKWCxo1yzgBNyHS3ldhsmHbqROfn2KhTHAPJNpPYFt0
 TEgw==
X-Gm-Message-State: AOJu0YzbcT0ZKiv6eYmfxcJ4ES6Z3iNsARdnKze01QOP6RuMuhA/MDCj
 syNNKPgh5r+NSyPiWYk/hvkwasH1MPqfZs87jHc=
X-Google-Smtp-Source: AGHT+IHOD0mon3mF24B1TlfzRSPaUFnXpEuKwaLq6HeWsacznRKrU14aYQTye+T7g7RBrmSTk6u3Fg==
X-Received: by 2002:a0c:d690:0:b0:67c:ae8:add0 with SMTP id
 k16-20020a0cd690000000b0067c0ae8add0mr17170120qvi.69.1702923596635; 
 Mon, 18 Dec 2023 10:19:56 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 dy7-20020ad44e87000000b0067f213933bdsm3046136qvb.2.2023.12.18.10.19.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 10:19:56 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v3 05/14] bloblist: Access record hdr_size and tag via a
 function
Date: Mon, 18 Dec 2023 10:18:50 -0800
Message-Id: <20231218181901.337515-6-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218181901.337515-1-raymond.mao@linaro.org>
References: <20231218181901.337515-1-raymond.mao@linaro.org>
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

