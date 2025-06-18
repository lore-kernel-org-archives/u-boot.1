Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4D8C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 15:00:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03D8382E25;
	Wed, 18 Jun 2025 17:00:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Bpv/zOr2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F26BD82E25; Wed, 18 Jun 2025 16:59:59 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AC4F82E8E
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 16:59:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6fafc79bca8so82044086d6.1
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 07:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750258796; x=1750863596; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7jPkmXv/b9Xuc/SCt18sMfgiMaVgB5dm1CZl17y/EjM=;
 b=Bpv/zOr2UR1Or/Z/ChBylWBR8Z9oNg0VzPd3mD+lXAF3YhanBpIvAO1hQUM7HOrDQV
 EQrv6DJhPfeTE6sVzBIlBZXQbdrsrShImZboXHQC6l2cHXvqgfMfKWR90AwxLXlUpthy
 LsVKrJHRyk3jUpPi3owAEQJYp1dEgu8WHijBatVT9Yl5hzL1Ec1JoWZaVi9zhPxRVunC
 duDOcSHqLQrzPH6bzQWZ6TX/SqbNezVMpLGklx0TTEBozk1HzRpqvV7d7cjvdBOl+JX8
 L93Ic4Ir+T9hawcyS3rZbKi7SMfFGvEPDH6mchlXFAywUqUVF7CqAN52JgkfVlfGg6G1
 9erA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750258796; x=1750863596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7jPkmXv/b9Xuc/SCt18sMfgiMaVgB5dm1CZl17y/EjM=;
 b=Fxn9QNSA7dz03WJvkPAc+EQa2cL92Ln6E/HT3cqotgX+IXnAAv8/LWLgqZiawHipiY
 xBRc1jCTPzuFRYU3s83DPGNJXNya7LvVk5HzaufqGv4je/ACw9J9Z8ymUkdgO8fY0w3J
 4bK3O23b7B88uLsfg7UQK+oVJycYO0Z/Gaqmo6TXCly3NL2rbVQUUFGbehwuv4mwqk1X
 RFxz1jV1914i5sqJ56BMUt3hfcFQrOkBth+xuZKcjSpyUZmSjlKHj9g35HvBtLbhgeC/
 vo3N4kqpcQvAszEAQB87Y0GKskd3fb6pePyaplmFdiismzgtRCEgzMpxoZz37DqUVAoc
 9pVg==
X-Gm-Message-State: AOJu0Ywo1E8KgmWx0Wxc/ZkdbxdnKmj11FSB/lj2oMPLay7WGDZASq51
 2TXu0/ZZXILCBx/fjSL3thsJHUhhTImKdgk1v7nYlhNuquqCmkoNMVxr/I4EjKuA+iH9F4rfBLz
 6YFiT
X-Gm-Gg: ASbGncsw2zMv9DbdP0yUeG2wLG1HMhOIbdNQV4/nZRsmmKPxhpXf9QvD6Vd6N1Qnzwa
 XwM+f7ouyvTeKmuoGsOPzmXbHZwl0LCf4LWZdS8uo6mBAx3fl+XcaX+i1/IdV2KNYmmziP1tl2l
 CGOp/oGrCUbJovvjzUvO3KsYxn7I0Yc5liaxLM4k9sAO62GzrSeIBUoQfSPDY/qJR4adteKIxw9
 xUXNJwhm9Tj7UWHFjTKJZEMi3tp+Ta34so/sYQao6kMzSGw6Jlx6gPxWv/vbeUV4+ulIj8KaL7h
 hJ5NEUQIlyOoFwAbiBoRC3I6+hZo3g8Q1YxF2vPw+rEOCnlo5tZhfsKT1yQW/i8kHYjUhuJ0CSB
 jRQcOWMwF6UyGCVDOPKj4AeMP23QINVyhrVa9oZH6jbKitcY=
X-Google-Smtp-Source: AGHT+IHFBNPgr1qcI/dkrk6Z+KLwBw/EW5Ik2QNHZhCSbbTh6qGGz+ykDT3bpvItiA6jqSHhExPZ+Q==
X-Received: by 2002:a05:6214:5710:b0:6f8:997d:fc82 with SMTP id
 6a1803df08f44-6fb47772ba5mr303256906d6.3.1750258795714; 
 Wed, 18 Jun 2025 07:59:55 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-114-64.cpe.distributel.net.
 [173.206.114.64]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb4d627a14sm44736416d6.68.2025.06.18.07.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 07:59:55 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Levi Yun <yeoreum.yun@arm.com>, Harrison Mutai <harrison.mutai@arm.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 4/6] bloblist: expose 'expand_by' as an output argument
Date: Wed, 18 Jun 2025 07:59:26 -0700
Message-Id: <20250618145930.2652304-5-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250618145930.2652304-1-raymond.mao@linaro.org>
References: <20250618145930.2652304-1-raymond.mao@linaro.org>
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

Some advanced usecases of bloblist needs to know the actual bytes
expanded or shrunk after blob resizing.
For example, to support applying DT overlay from bloblist, firstly
the FDT blob needs to be resized for potential size increasing after
applying overlay. If the DT overlay blob is one of the following blobs
of the FDT, its address will be shifted after FDT blob resizing.
Thus, returning 'expand_by' helps the caller to get the shifted data
pointer when it comes to get the overlay for applying.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 common/bloblist.c      | 16 ++++++++--------
 include/bloblist.h     | 11 ++++++++++-
 test/common/bloblist.c | 17 +++++++++++------
 3 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 550c0c78ffc..ae5273785eb 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -311,14 +311,14 @@ int bloblist_ensure_size_ret(uint tag, int *sizep, void **blobp)
 
 static int bloblist_resize_rec(struct bloblist_hdr *hdr,
 			       struct bloblist_rec *rec,
-			       int new_size)
+			       int new_size, int *expand_by)
 {
-	int expand_by;	/* Number of bytes to expand by (-ve to contract) */
 	int new_alloced;
 	ulong next_ofs;	/* Offset of the record after @rec */
 
-	expand_by = ALIGN(new_size - rec->size, BLOBLIST_BLOB_ALIGN);
-	new_alloced = ALIGN(hdr->used_size + expand_by, BLOBLIST_BLOB_ALIGN);
+	*expand_by = ALIGN(new_size - rec->size, BLOBLIST_BLOB_ALIGN);
+	new_alloced = ALIGN(hdr->used_size + *expand_by, BLOBLIST_BLOB_ALIGN);
+
 	if (new_size < 0) {
 		log_debug("Attempt to shrink blob size below 0 (%x)\n",
 			  new_size);
@@ -334,13 +334,13 @@ static int bloblist_resize_rec(struct bloblist_hdr *hdr,
 	/* Move the following blobs up or down, if this is not the last */
 	next_ofs = bloblist_blob_end_ofs(hdr, rec);
 	if (next_ofs != hdr->used_size) {
-		memmove((void *)hdr + next_ofs + expand_by,
+		memmove((void *)hdr + next_ofs + *expand_by,
 			(void *)hdr + next_ofs, hdr->used_size - next_ofs);
 	}
 	hdr->used_size = new_alloced;
 
 	/* Zero the new part of the blob */
-	if (expand_by > 0) {
+	if (*expand_by > 0) {
 		memset((void *)rec + rec_hdr_size(rec) + rec->size, '\0',
 		       new_size - rec->size);
 	}
@@ -351,7 +351,7 @@ static int bloblist_resize_rec(struct bloblist_hdr *hdr,
 	return 0;
 }
 
-int bloblist_resize(uint tag, int new_size)
+int bloblist_resize(uint tag, int new_size, int *expand_by)
 {
 	struct bloblist_hdr *hdr = gd->bloblist;
 	struct bloblist_rec *rec;
@@ -360,7 +360,7 @@ int bloblist_resize(uint tag, int new_size)
 	rec = bloblist_findrec(tag);
 	if (!rec)
 		return log_msg_ret("find", -ENOENT);
-	ret = bloblist_resize_rec(hdr, rec, new_size);
+	ret = bloblist_resize_rec(hdr, rec, new_size, expand_by);
 	if (ret)
 		return log_msg_ret("resize", ret);
 
diff --git a/include/bloblist.h b/include/bloblist.h
index b40e04fe2d3..0aaeb9ef7f1 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -73,6 +73,7 @@
 #define __BLOBLIST_H
 
 #include <mapmem.h>
+#include <errno.h>
 
 enum {
 	BLOBLIST_VERSION	= 1,
@@ -337,6 +338,7 @@ void *bloblist_ensure(uint tag, int size);
  */
 int bloblist_ensure_size_ret(uint tag, int *sizep, void **blobp);
 
+#if CONFIG_IS_ENABLED(BLOBLIST)
 /**
  * bloblist_resize() - resize a blob
  *
@@ -345,10 +347,17 @@ int bloblist_ensure_size_ret(uint tag, int *sizep, void **blobp);
  *
  * @tag:	Tag to add (enum bloblist_tag_t)
  * @new_size:	New size of the blob (>0 to expand, <0 to contract)
+ * @expand_by:	Number of bytes actually expanded by (-ve to contract)
  * Return: 0 if OK, -ENOSPC if the bloblist does not have enough space, -ENOENT
  * if the tag is not found
  */
-int bloblist_resize(uint tag, int new_size);
+int bloblist_resize(uint tag, int new_size, int *expand_by);
+#else
+static inline int bloblist_resize(uint tag, int new_size, int *expand_by)
+{
+	return -EPERM;
+}
+#endif
 
 /**
  * bloblist_new() - Create a new, empty bloblist of a given size
diff --git a/test/common/bloblist.c b/test/common/bloblist.c
index 797bde27025..c087d95c4b2 100644
--- a/test/common/bloblist.c
+++ b/test/common/bloblist.c
@@ -401,6 +401,7 @@ static int bloblist_test_grow(struct unit_test_state *uts)
 	void *blob1, *blob2, *blob1_new;
 	struct bloblist_hdr *hdr;
 	void *ptr;
+	int expand_by;
 
 	ptr = map_sysmem(TEST_ADDR, TEST_BLOBLIST_SIZE);
 	hdr = ptr;
@@ -422,7 +423,7 @@ static int bloblist_test_grow(struct unit_test_state *uts)
 		    hdr->used_size);
 
 	/* Resize the first one */
-	ut_assertok(bloblist_resize(TEST_TAG, small_size + 4));
+	ut_assertok(bloblist_resize(TEST_TAG, small_size + 4, &expand_by));
 
 	/* The first one should not have moved, just got larger */
 	blob1_new = bloblist_find(TEST_TAG, small_size + 4);
@@ -455,6 +456,7 @@ static int bloblist_test_shrink(struct unit_test_state *uts)
 	struct bloblist_hdr *hdr;
 	int new_size;
 	void *ptr;
+	int expand_by;
 
 	ptr = map_sysmem(TEST_ADDR, TEST_BLOBLIST_SIZE);
 
@@ -475,7 +477,7 @@ static int bloblist_test_shrink(struct unit_test_state *uts)
 
 	/* Resize the first one */
 	new_size = small_size - BLOBLIST_ALIGN - 4;
-	ut_assertok(bloblist_resize(TEST_TAG, new_size));
+	ut_assertok(bloblist_resize(TEST_TAG, new_size, &expand_by));
 
 	/* The first one should not have moved, just got smaller */
 	blob1_new = bloblist_find(TEST_TAG, new_size);
@@ -505,6 +507,7 @@ static int bloblist_test_resize_fail(struct unit_test_state *uts)
 	void *blob1, *blob2;
 	int new_size;
 	void *ptr;
+	int expand_by;
 
 	ptr = map_sysmem(TEST_ADDR, TEST_BLOBLIST_SIZE);
 
@@ -522,11 +525,12 @@ static int bloblist_test_resize_fail(struct unit_test_state *uts)
 		    hdr->used_size);
 
 	/* Resize the first one, to check the boundary conditions */
-	ut_asserteq(-EINVAL, bloblist_resize(TEST_TAG, -1));
+	ut_asserteq(-EINVAL, bloblist_resize(TEST_TAG, -1, &expand_by));
 
 	new_size = small_size + (hdr->total_size - hdr->used_size);
-	ut_asserteq(-ENOSPC, bloblist_resize(TEST_TAG, new_size + 1));
-	ut_assertok(bloblist_resize(TEST_TAG, new_size));
+	ut_asserteq(-ENOSPC, bloblist_resize(TEST_TAG, new_size + 1,
+					     &expand_by));
+	ut_assertok(bloblist_resize(TEST_TAG, new_size, &expand_by));
 
 	return 0;
 }
@@ -540,6 +544,7 @@ static int bloblist_test_resize_last(struct unit_test_state *uts)
 	void *blob1, *blob2, *blob2_new;
 	int alloced_val;
 	void *ptr;
+	int expand_by;
 
 	ptr = map_sysmem(TEST_ADDR, TEST_BLOBLIST_SIZE);
 	memset(ptr, ERASE_BYTE, TEST_BLOBLIST_SIZE);
@@ -561,7 +566,7 @@ static int bloblist_test_resize_last(struct unit_test_state *uts)
 	ut_asserteq((u8)ERASE_BYTE, *((u8 *)hdr + hdr->used_size));
 
 	/* Resize the second one, checking nothing changes */
-	ut_asserteq(0, bloblist_resize(TEST_TAG2, small_size + 4));
+	ut_asserteq(0, bloblist_resize(TEST_TAG2, small_size + 4, &expand_by));
 
 	blob2_new = bloblist_find(TEST_TAG2, small_size + 4);
 	ut_asserteq_ptr(blob2, blob2_new);
-- 
2.25.1

