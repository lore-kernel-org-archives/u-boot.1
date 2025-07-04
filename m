Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED46C8303D
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 13:43:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C00382F49;
	Fri,  4 Jul 2025 15:42:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BedgcWCD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B31482F6F; Fri,  4 Jul 2025 15:42:53 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 383D8806D8
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 15:42:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4a9741b513eso20255271cf.1
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 06:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751636569; x=1752241369; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CWBZVOIynCXHwJaqor+LuunjN84x4zpO7wAr4G7zw8c=;
 b=BedgcWCDwD4UTnE3oo/I3Xi+n1UmKh8U36LJYo2SrLq/RLcjcDUrvbU0g9NmlOQJbP
 UhARhjWFGihdu/4aoYPZyckKx+HU/QRsOOUVd71dxXZLyyV019kVyjC5I6kpPC8fpkmW
 lFFJ3ga1+pFROdjm8ctOcomL4pVtkNwmmGCK3lQpw6BjlsszNCgeqairudCcV71tHTER
 Of4Bz+l8JO9zl09WDhZwXy8xVqfLuXMS5RCvIfXjzJ7yaQ1j304Y9yDLKDHy7vjTVlQo
 IuSmMoIqD43QaX7x3KuE570+xrN0FHQakXFRuLEhXHPJZZUmuxoy4JKrBBwnOcw0U/bH
 lSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751636569; x=1752241369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CWBZVOIynCXHwJaqor+LuunjN84x4zpO7wAr4G7zw8c=;
 b=hmo1y3h1cL1LKtbupSMEms4hnUBXo2/ltHLN3d1fJMXDGThfj0SspIpyzNZ5ozx/qT
 4ZvMJBcD3Aag7E0hADVsHuMOhLUCjq5uhzZlZLzRwi/0yXflE50VGJnV3M//kUfOoJzK
 K9t1VpJRSbC57K0RXWPwGvtNOuIqZ7mkExyVrMatLifkhx3w3TqQhudKJk2LXKU5IK+K
 uZ9RYccOHzmyB0kihmfRJoO5AZN9kq6IaUor0yYmBqMHRi/d0+pu5beHJXCuv4hlTGlT
 LYAM3lClwfmqC4pqFJ+aMZ+xT+uqFnjUHSWb6L90RHGuiPfE0r5LeV9iosUD3F0oNwaM
 NIYA==
X-Gm-Message-State: AOJu0YwzNkQ8AAzQtyVB6wDTvT4Wwt3kstxwVJgMGqpqqCVZ7CbWNxm+
 /eXo3X9KoVnoPDBclJkEX4rkEQSlXKoI+E/+tI27yQWJw2tflMd1WEajeNcd5PvRHAeWVXOteHi
 LldFZ
X-Gm-Gg: ASbGnctZRl4aIhmuRladBkK9WywC145uQCOUl46uwEcl3GK1ZJjk6a97NOkNBke+V3Y
 rFqptsfG3VQkih+YPuPS3kZBsitC53xYzloauNv5isTk43q9rZu1ifsrsFHbIwUridSsQR9a/Iq
 f1YVnZANpHZyP0egb5Um6lOdFCw4YWXf2yJHwp21kxZtyEhyYJWD4T1sQKaO6m5TWFrxkEnX1+D
 JfvbnHUFgk7G7xaKE04mZMyFY++uDnNDNfZO/adEWd2YV5CjgV4Th6SwL7elKGJEpF+AqnhXsDb
 3t1b3Nkrrxne841Z/KFW5SaEtEtmwk72hbyNUrx2asNRi2KpjVjLeS4AxijjbYCuzDyy2J0imfY
 JM1vhn9qbr5aSqDGzYtiqJDyTaLavY/U1JnAyOU8ZEcwFDwg=
X-Google-Smtp-Source: AGHT+IHQcFVf1BZjbmhTcrpnmg5T0Krtf0EykcZgm2PK8DTTsK/8s7IHyoUH3YZODlWXRVCJsMkZSw==
X-Received: by 2002:a05:622a:250b:b0:4a8:24fa:67db with SMTP id
 d75a77b69052e-4a9963fc15amr53462041cf.1.1751636569462; 
 Fri, 04 Jul 2025 06:42:49 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-114-64.cpe.distributel.net.
 [173.206.114.64]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a79606sm14071051cf.37.2025.07.04.06.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 06:42:48 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Levi Yun <yeoreum.yun@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 4/6] bloblist: expose 'expand_by' as an output argument
Date: Fri,  4 Jul 2025 06:42:03 -0700
Message-Id: <20250704134208.2895595-5-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250704134208.2895595-1-raymond.mao@linaro.org>
References: <20250704134208.2895595-1-raymond.mao@linaro.org>
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
Changes in v2:
- None.

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
index c2d3065a43c..213285bbec6 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -73,6 +73,7 @@
 #define __BLOBLIST_H
 
 #include <mapmem.h>
+#include <errno.h>
 
 enum {
 	BLOBLIST_VERSION	= 1,
@@ -347,6 +348,7 @@ void *bloblist_ensure(uint tag, int size);
  */
 int bloblist_ensure_size_ret(uint tag, int *sizep, void **blobp);
 
+#if CONFIG_IS_ENABLED(BLOBLIST)
 /**
  * bloblist_resize() - resize a blob
  *
@@ -355,10 +357,17 @@ int bloblist_ensure_size_ret(uint tag, int *sizep, void **blobp);
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

