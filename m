Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCFAC47073
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:44:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F24A87B9D;
	Fri, 29 Dec 2023 18:43:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IXGDYP2h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65ED287B6B; Fri, 29 Dec 2023 18:43:43 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D591487B93
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:43:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-78102c516a7so637420085a.2
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 09:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703871819; x=1704476619; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2BV8R6ujUnhDHEtX9R/LTY+sSM/koUqDBXAjsoSm6JI=;
 b=IXGDYP2h2Osa+9PprJgW7JjQfatL16A7hs80764Tam+GE/1ZWdtnrB/2p2acoQ1lC/
 4AzxntyAYyG2gy0dY037UbNd6Q9IyzwGdKmWTTcbUJFihLdscQf2hTOZGY+HmVwlShql
 rVRofcHVFx9XEp9siyfX4u1B0lk2rWnJdbKm+BkkDjWbGA6MSKaA8ESD3BCYLesBdZYS
 3HYDgOD20utmk/ZW9T/1V6vQK9lObdkcRQGYeQthqvCZ44lIfNIFk/N0vEHAikXxWhfo
 RA5oE2TOR6YXG/S/veUoU9ow0eUywB0Fv+iFGynUfNj9BQp1hPBppQagj2/uRQpv+npy
 61QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703871819; x=1704476619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2BV8R6ujUnhDHEtX9R/LTY+sSM/koUqDBXAjsoSm6JI=;
 b=majADAzKzKr8zbIeV1LP39y3tPOHAyAgodUxP0Zi9tF2RZDQ+FteYyFzGuFTqAHfLw
 oZioML31iMmzIvG1wrfIZkAc52IAlmcOsA+p9o8koOyY/ieV0abNRfPvSVBffRT/xI5O
 X7TKGR06GUggLmZDVMKVCnJ9Cq+/XupX/2KX+riShLleyG+xhJoDiIr1AU8AHmmPg9NE
 R1m4TA0esGsFTcLiX5e5riFzfqwyFjzKuGOJiqrflo2c6uXuZ3x2DDRsajZrBKH3g6z/
 Imo1uLXfiKjf7wZqgb5oIrtMRBvQ1kDcRqXS0cXMPHskeA3KFoaF9RpudQcYyb8eImNi
 QsdA==
X-Gm-Message-State: AOJu0YxqtdcdQm6zamltXE3QjrS37D4+Jmntlwem0x/fs2nMLXXEVcZy
 L2xHDOIUj+G5sr5eYjp1ZfYKcjWALAumoYLqQPnmMjuPKtQ=
X-Google-Smtp-Source: AGHT+IGZOHauAzzcoXj56FfVgGhIVv+VjeE4UepU1Woas5C0tNEbuMEU6pZTnuLFOqScKMMYQJaXSw==
X-Received: by 2002:a05:620a:558a:b0:781:5e6a:355d with SMTP id
 vq10-20020a05620a558a00b007815e6a355dmr6041457qkn.141.1703871819388; 
 Fri, 29 Dec 2023 09:43:39 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a05620a122b00b007817084e7basm1545849qkj.99.2023.12.29.09.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 09:43:38 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v5 09/11] bloblist: Adjust the bloblist header
Date: Fri, 29 Dec 2023 09:42:41 -0800
Message-Id: <20231229174244.892818-10-raymond.mao@linaro.org>
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

The v0.9 spec provides for a 24-byte header. Update the implementation
to match this.
Rename the fields of the bloblist header to align to the spec.
Adds an alignment field into the bloblist header.
Update the related bloblist APIs and UT testcases.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v3
- Update the bloblist header to align to FW handoff spec up to commit 3592349.
- Update the related testcases.
Changes in v4
- Patch #14 from v3 is squashed into this patch.

 common/bloblist.c  | 86 +++++++++++++++++++++++++++-------------------
 include/bloblist.h | 44 ++++++++++++++----------
 test/bloblist.c    | 37 ++++++++++----------
 3 files changed, 95 insertions(+), 72 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 6dc384df5c..c9aecdfbd5 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -80,7 +80,7 @@ const char *bloblist_tag_name(enum bloblist_tag_t tag)
 
 static struct bloblist_rec *bloblist_first_blob(struct bloblist_hdr *hdr)
 {
-	if (hdr->alloced <= hdr->hdr_size)
+	if (hdr->used_size <= hdr->hdr_size)
 		return NULL;
 	return (struct bloblist_rec *)((void *)hdr + hdr->hdr_size);
 }
@@ -119,7 +119,7 @@ static struct bloblist_rec *bloblist_next_blob(struct bloblist_hdr *hdr,
 {
 	ulong offset = bloblist_blob_end_ofs(hdr, rec);
 
-	if (offset >= hdr->alloced)
+	if (offset >= hdr->used_size)
 		return NULL;
 	return (struct bloblist_rec *)((void *)hdr + offset);
 }
@@ -156,9 +156,9 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
 		align_log2 = BLOBLIST_BLOB_ALIGN_LOG2;
 
 	/* Figure out where the new data will start */
-	data_start = map_to_sysmem(hdr) + hdr->alloced + sizeof(*rec);
+	data_start = map_to_sysmem(hdr) + hdr->used_size + sizeof(*rec);
 
-	/* Align the address and then calculate the offset from ->alloced */
+	/* Align the address and then calculate the offset from used size */
 	aligned_start = ALIGN(data_start, 1U << align_log2) - data_start;
 
 	/* If we need to create a dummy record, create it */
@@ -172,19 +172,20 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
 			return log_msg_ret("void", ret);
 
 		/* start the record after that */
-		data_start = map_to_sysmem(hdr) + hdr->alloced + sizeof(*vrec);
+		data_start = map_to_sysmem(hdr) + hdr->used_size + sizeof(*vrec);
 	}
 
 	/* Calculate the new allocated total */
 	new_alloced = hdr->used_size + sizeof(*rec) +
 		      ALIGN(size, 1U << align_log2);
 
-	if (new_alloced > hdr->size) {
-		log_err("Failed to allocate %x bytes size=%x, need size=%x\n",
-			size, hdr->size, new_alloced);
+	if (new_alloced > hdr->total_size) {
+		log_err("Failed to allocate %x bytes\n", size);
+		log_err("Used size=%x, total size=%x\n",
+			hdr->used_size, hdr->total_size);
 		return log_msg_ret("bloblist add", -ENOSPC);
 	}
-	rec = (void *)hdr + hdr->alloced;
+	rec = (void *)hdr + hdr->used_size;
 
 	rec->tag_and_hdr_size = tag | sizeof(*rec) << BLOBLISTR_HDR_SIZE_SHIFT;
 	rec->size = size;
@@ -192,7 +193,7 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
 	/* Zero the record data */
 	memset((void *)rec + rec_hdr_size(rec), '\0', rec->size);
 
-	hdr->alloced = new_alloced;
+	hdr->used_size = new_alloced;
 	*recp = rec;
 
 	return 0;
@@ -287,29 +288,30 @@ static int bloblist_resize_rec(struct bloblist_hdr *hdr,
 			       int new_size)
 {
 	int expand_by;	/* Number of bytes to expand by (-ve to contract) */
-	int new_alloced;	/* New value for @hdr->alloced */
+	int new_alloced;
 	ulong next_ofs;	/* Offset of the record after @rec */
 
 	expand_by = ALIGN(new_size - rec->size, BLOBLIST_BLOB_ALIGN);
-	new_alloced = ALIGN(hdr->alloced + expand_by, BLOBLIST_BLOB_ALIGN);
+	new_alloced = ALIGN(hdr->used_size + expand_by, BLOBLIST_BLOB_ALIGN);
 	if (new_size < 0) {
 		log_debug("Attempt to shrink blob size below 0 (%x)\n",
 			  new_size);
 		return log_msg_ret("size", -EINVAL);
 	}
-	if (new_alloced > hdr->size) {
-		log_err("Failed to allocate %x bytes size=%x, need size=%x\n",
-			new_size, hdr->size, new_alloced);
+	if (new_alloced > hdr->total_size) {
+		log_err("Failed to allocate %x bytes\n", new_size);
+		log_err("Used size=%x, total size=%x\n",
+			hdr->used_size, hdr->total_size);
 		return log_msg_ret("alloc", -ENOSPC);
 	}
 
 	/* Move the following blobs up or down, if this is not the last */
 	next_ofs = bloblist_blob_end_ofs(hdr, rec);
-	if (next_ofs != hdr->alloced) {
+	if (next_ofs != hdr->used_size) {
 		memmove((void *)hdr + next_ofs + expand_by,
 			(void *)hdr + next_ofs, new_alloced - next_ofs);
 	}
-	hdr->alloced = new_alloced;
+	hdr->used_size = new_alloced;
 
 	/* Zero the new part of the blob */
 	if (expand_by > 0) {
@@ -343,7 +345,7 @@ static u32 bloblist_calc_chksum(struct bloblist_hdr *hdr)
 {
 	u8 chksum;
 
-	chksum = table_compute_checksum(hdr, hdr->alloced);
+	chksum = table_compute_checksum(hdr, hdr->used_size);
 	chksum += hdr->chksum;
 
 	return chksum;
@@ -363,8 +365,8 @@ int bloblist_new(ulong addr, uint size, uint flags)
 	hdr->hdr_size = sizeof(*hdr);
 	hdr->flags = flags;
 	hdr->magic = BLOBLIST_MAGIC;
-	hdr->size = size;
-	hdr->alloced = hdr->hdr_size;
+	hdr->used_size = hdr->hdr_size;
+	hdr->total_size = size;
 	hdr->chksum = 0;
 	gd->bloblist = hdr;
 
@@ -381,8 +383,13 @@ int bloblist_check(ulong addr, uint size)
 		return log_msg_ret("Bad magic", -ENOENT);
 	if (hdr->version != BLOBLIST_VERSION)
 		return log_msg_ret("Bad version", -EPROTONOSUPPORT);
-	if (size && hdr->size != size)
-		return log_msg_ret("Bad size", -EFBIG);
+	if (!hdr->total_size || (size && hdr->total_size != size))
+		return log_msg_ret("Bad total size", -EFBIG);
+	if (hdr->used_size > hdr->total_size)
+		return log_msg_ret("Bad used size", -ENOENT);
+	if (hdr->hdr_size != sizeof(struct bloblist_hdr))
+		return log_msg_ret("Bad header size", -ENOENT);
+
 	chksum = bloblist_calc_chksum(hdr);
 	if (hdr->chksum != chksum) {
 		log_err("Checksum %x != %x\n", hdr->chksum, chksum);
@@ -398,7 +405,7 @@ int bloblist_finish(void)
 	struct bloblist_hdr *hdr = gd->bloblist;
 
 	hdr->chksum = bloblist_calc_chksum(hdr);
-	log_debug("Finished bloblist size %lx at %lx\n", (ulong)hdr->size,
+	log_debug("Finished bloblist size %lx at %lx\n", (ulong)hdr->used_size,
 		  (ulong)map_to_sysmem(hdr));
 
 	return 0;
@@ -413,33 +420,40 @@ ulong bloblist_get_size(void)
 {
 	struct bloblist_hdr *hdr = gd->bloblist;
 
-	return hdr->size;
+	return hdr->used_size;
+}
+
+ulong bloblist_get_total_size(void)
+{
+	struct bloblist_hdr *hdr = gd->bloblist;
+
+	return hdr->total_size;
 }
 
-void bloblist_get_stats(ulong *basep, ulong *sizep, ulong *allocedp)
+void bloblist_get_stats(ulong *basep, ulong *tsizep, ulong *usizep)
 {
 	struct bloblist_hdr *hdr = gd->bloblist;
 
 	*basep = map_to_sysmem(gd->bloblist);
-	*sizep = hdr->size;
-	*allocedp = hdr->alloced;
+	*tsizep = hdr->total_size;
+	*usizep = hdr->used_size;
 }
 
 static void show_value(const char *prompt, ulong value)
 {
-	printf("%s:%*s %-5lx  ", prompt, 8 - (int)strlen(prompt), "", value);
+	printf("%s:%*s %-5lx  ", prompt, 10 - (int)strlen(prompt), "", value);
 	print_size(value, "\n");
 }
 
 void bloblist_show_stats(void)
 {
-	ulong base, size, alloced;
+	ulong base, tsize, usize;
 
-	bloblist_get_stats(&base, &size, &alloced);
-	printf("base:     %lx\n", base);
-	show_value("size", size);
-	show_value("alloced", alloced);
-	show_value("free", size - alloced);
+	bloblist_get_stats(&base, &tsize, &usize);
+	printf("base:       %lx\n", base);
+	show_value("total size", tsize);
+	show_value("used size", usize);
+	show_value("free", tsize - usize);
 }
 
 void bloblist_show_list(void)
@@ -463,7 +477,7 @@ void bloblist_reloc(void *to, uint to_size, void *from, uint from_size)
 
 	memcpy(to, from, from_size);
 	hdr = to;
-	hdr->size = to_size;
+	hdr->total_size = to_size;
 }
 
 int bloblist_init(void)
@@ -493,7 +507,7 @@ int bloblist_init(void)
 				    addr, ret);
 		} else {
 			/* Get the real size, if it is not what we expected */
-			size = gd->bloblist->size;
+			size = gd->bloblist->total_size;
 		}
 	}
 	if (ret) {
diff --git a/include/bloblist.h b/include/bloblist.h
index 7024d7bf9e..4ec4b3d449 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -166,32 +166,33 @@ enum bloblist_tag_t {
  * from the last.
  *
  * @magic: BLOBLIST_MAGIC
+ * @chksum: checksum for the entire bloblist allocated area. Since any of the
+ *	blobs can be altered after being created, this checksum is only valid
+ *	when the bloblist is finalized before jumping to the next stage of boot.
+ *	This is the value needed to make all checksummed bytes sum to 0
  * @version: BLOBLIST_VERSION
  * @hdr_size: Size of this header, normally sizeof(struct bloblist_hdr). The
  *	first bloblist_rec starts at this offset from the start of the header
- * @flags: Space for BLOBLISTF... flags (none yet)
- * @size: Total size of the bloblist (non-zero if valid) including this header.
- *	The bloblist extends for this many bytes from the start of this header.
- *	When adding new records, the bloblist can grow up to this size.
- * @alloced: Total size allocated so far for this bloblist. This starts out as
+ * @align_log2: Power of two of the maximum alignment required by this list
+ * @used_size: Size allocated so far for this bloblist. This starts out as
  *	sizeof(bloblist_hdr) since we need at least that much space to store a
  *	valid bloblist
+ * @total_size: The number of total bytes that the bloblist can occupy.
+ *	Any blob producer must check if there is sufficient space before adding
+ *	a record to the bloblist.
+ * @flags: Space for BLOBLISTF... flags (none yet)
  * @spare: Spare space (for future use)
- * @chksum: checksum for the entire bloblist allocated area. Since any of the
- *	blobs can be altered after being created, this checksum is only valid
- *	when the bloblist is finalised before jumping to the next stage of boot.
- *	This is the value needed to make all checksummed bytes sum to 0
  */
 struct bloblist_hdr {
 	u32 magic;
-	u32 version;
-	u32 hdr_size;
+	u8 chksum;
+	u8 version;
+	u8 hdr_size;
+	u8 align_log2;
+	u32 used_size;
+	u32 total_size;
 	u32 flags;
-
-	u32 size;
-	u32 alloced;
 	u32 spare;
-	u32 chksum;
 };
 
 /**
@@ -363,10 +364,10 @@ int bloblist_finish(void);
  * This returns useful information about the bloblist
  *
  * @basep: Returns base address of bloblist
- * @sizep: Returns the number of bytes used in the bloblist
- * @allocedp: Returns the total space allocated to the bloblist
+ * @tsizep: Returns the total number of bytes of the bloblist
+ * @usizep: Returns the number of used bytes of the bloblist
  */
-void bloblist_get_stats(ulong *basep, ulong *sizep, ulong *allocedp);
+void bloblist_get_stats(ulong *basep, ulong *tsizep, ulong *usizep);
 
 /**
  * bloblist_get_base() - Get the base address of the bloblist
@@ -382,6 +383,13 @@ ulong bloblist_get_base(void);
  */
 ulong bloblist_get_size(void);
 
+/**
+ * bloblist_get_total_size() - Get the total size of the bloblist
+ *
+ * Return: the size in bytes
+ */
+ulong bloblist_get_total_size(void);
+
 /**
  * bloblist_show_stats() - Show information about the bloblist
  *
diff --git a/test/bloblist.c b/test/bloblist.c
index e6070041d3..2b06ce844f 100644
--- a/test/bloblist.c
+++ b/test/bloblist.c
@@ -78,7 +78,7 @@ static int bloblist_test_init(struct unit_test_state *uts)
 	ut_asserteq(-EPROTONOSUPPORT, bloblist_check(TEST_ADDR,
 						     TEST_BLOBLIST_SIZE));
 
-	ut_asserteq(-ENOSPC, bloblist_new(TEST_ADDR, 0x10, 0));
+	ut_asserteq(-ENOSPC, bloblist_new(TEST_ADDR, 0xc, 0));
 	ut_asserteq(-EFAULT, bloblist_new(1, TEST_BLOBLIST_SIZE, 0));
 	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
 
@@ -107,7 +107,8 @@ static int bloblist_test_blob(struct unit_test_state *uts)
 	hdr = clear_bloblist();
 	ut_assertnull(bloblist_find(TEST_TAG, TEST_BLOBLIST_SIZE));
 	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
-	ut_asserteq(TEST_BLOBLIST_SIZE, bloblist_get_size());
+	ut_asserteq(sizeof(struct bloblist_hdr), bloblist_get_size());
+	ut_asserteq(TEST_BLOBLIST_SIZE, bloblist_get_total_size());
 	ut_asserteq(TEST_ADDR, bloblist_get_base());
 	ut_asserteq(map_to_sysmem(hdr), TEST_ADDR);
 
@@ -205,9 +206,9 @@ static int bloblist_test_checksum(struct unit_test_state *uts)
 	ut_asserteq(-EIO, bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
 	hdr->flags++;
 
-	hdr->size--;
+	hdr->total_size--;
 	ut_asserteq(-EFBIG, bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
-	hdr->size++;
+	hdr->total_size++;
 
 	hdr->spare++;
 	ut_asserteq(-EIO, bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
@@ -270,10 +271,10 @@ static int bloblist_test_cmd_info(struct unit_test_state *uts)
 	ut_silence_console(uts);
 	console_record_reset();
 	run_command("bloblist info", 0);
-	ut_assert_nextline("base:     %lx", (ulong)map_to_sysmem(hdr));
-	ut_assert_nextline("size:     400    1 KiB");
-	ut_assert_nextline("alloced:  58     88 Bytes");
-	ut_assert_nextline("free:     3a8    936 Bytes");
+	ut_assert_nextline("base:       %lx", (ulong)map_to_sysmem(hdr));
+	ut_assert_nextline("total size: 400    1 KiB");
+	ut_assert_nextline("used size:  50     80 Bytes");
+	ut_assert_nextline("free:       3b0    944 Bytes");
 	ut_assert_console_end();
 	ut_unsilence_console(uts);
 
@@ -427,7 +428,7 @@ static int bloblist_test_grow(struct unit_test_state *uts)
 
 	ut_asserteq(sizeof(struct bloblist_hdr) +
 		    sizeof(struct bloblist_rec) * 2 + small_size * 2,
-		    hdr->alloced);
+		    hdr->used_size);
 
 	/* Resize the first one */
 	ut_assertok(bloblist_resize(TEST_TAG, small_size + 4));
@@ -449,7 +450,7 @@ static int bloblist_test_grow(struct unit_test_state *uts)
 	ut_asserteq(sizeof(struct bloblist_hdr) +
 		    sizeof(struct bloblist_rec) * 2 + small_size * 2 +
 		    BLOBLIST_BLOB_ALIGN,
-		    hdr->alloced);
+		    hdr->used_size);
 
 	return 0;
 }
@@ -479,7 +480,7 @@ static int bloblist_test_shrink(struct unit_test_state *uts)
 	hdr = ptr;
 	ut_asserteq(sizeof(struct bloblist_hdr) +
 		    sizeof(struct bloblist_rec) * 2 + small_size * 2,
-		    hdr->alloced);
+		    hdr->used_size);
 
 	/* Resize the first one */
 	new_size = small_size - BLOBLIST_ALIGN - 4;
@@ -499,7 +500,7 @@ static int bloblist_test_shrink(struct unit_test_state *uts)
 	ut_asserteq(sizeof(struct bloblist_hdr) +
 		    sizeof(struct bloblist_rec) * 2 + small_size * 2 -
 		    BLOBLIST_ALIGN,
-		    hdr->alloced);
+		    hdr->used_size);
 
 	return 0;
 }
@@ -527,12 +528,12 @@ static int bloblist_test_resize_fail(struct unit_test_state *uts)
 	hdr = ptr;
 	ut_asserteq(sizeof(struct bloblist_hdr) +
 		    sizeof(struct bloblist_rec) * 2 + small_size * 2,
-		    hdr->alloced);
+		    hdr->used_size);
 
 	/* Resize the first one, to check the boundary conditions */
 	ut_asserteq(-EINVAL, bloblist_resize(TEST_TAG, -1));
 
-	new_size = small_size + (hdr->size - hdr->alloced);
+	new_size = small_size + (hdr->total_size - hdr->used_size);
 	ut_asserteq(-ENOSPC, bloblist_resize(TEST_TAG, new_size + 1));
 	ut_assertok(bloblist_resize(TEST_TAG, new_size));
 
@@ -564,9 +565,9 @@ static int bloblist_test_resize_last(struct unit_test_state *uts)
 	/* Check the byte after the last blob */
 	alloced_val = sizeof(struct bloblist_hdr) +
 		    sizeof(struct bloblist_rec) * 2 + small_size * 2;
-	ut_asserteq(alloced_val, hdr->alloced);
+	ut_asserteq(alloced_val, hdr->used_size);
 	ut_asserteq_ptr((void *)hdr + alloced_val, blob2 + small_size);
-	ut_asserteq((u8)ERASE_BYTE, *((u8 *)hdr + hdr->alloced));
+	ut_asserteq((u8)ERASE_BYTE, *((u8 *)hdr + hdr->used_size));
 
 	/* Resize the second one, checking nothing changes */
 	ut_asserteq(0, bloblist_resize(TEST_TAG2, small_size + 4));
@@ -584,8 +585,8 @@ static int bloblist_test_resize_last(struct unit_test_state *uts)
 
 	/* Check that the new top of the allocated blobs has not been touched */
 	alloced_val += BLOBLIST_BLOB_ALIGN;
-	ut_asserteq(alloced_val, hdr->alloced);
-	ut_asserteq((u8)ERASE_BYTE, *((u8 *)hdr + hdr->alloced));
+	ut_asserteq(alloced_val, hdr->used_size);
+	ut_asserteq((u8)ERASE_BYTE, *((u8 *)hdr + hdr->used_size));
 
 	return 0;
 }
-- 
2.25.1

