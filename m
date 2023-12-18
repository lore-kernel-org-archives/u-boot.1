Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FD1C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 18:22:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBCB38763E;
	Mon, 18 Dec 2023 19:20:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QP4Om1GH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D256874F3; Mon, 18 Dec 2023 19:20:40 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 093F28765B
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 19:20:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-59067ccb090so2318489eaf.1
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 10:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702923635; x=1703528435; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XIFgjIaZRfwtD/ci0bGqXAz4pdToUM6LbnS0MXgrtJQ=;
 b=QP4Om1GHOfUBn/QyowwoCvBmYErw6PA8EGOc/CpoSj9FyzyxID0ca576J0n94lAqfC
 unA6OQdbBgMNc8S/0E84/C5yjYw+8Dx+gsKQmxqZhCb5vSDFcurqy5cwiUL+p9zfSv0A
 6ZtqMsJBAuvIc/hNW4XHwCNQvSYVkii+SK+qFln1j6nhXNcZdlofZuivjxAGRJ8s7iBl
 UFIdRC7ZC2M2OgP0fs0/NroL6mohlr5giqIVpFoAsrStgQnmb0FaUj/gQVjQs4n7xhGm
 V+z22SBFDFpLFjwbQc/dwkVSPsJZ2bvby2Vu2PSOIHN2YpGB6gW5s//fvOApJHoOLhSj
 KTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702923635; x=1703528435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XIFgjIaZRfwtD/ci0bGqXAz4pdToUM6LbnS0MXgrtJQ=;
 b=ftUrJmSMau5n7D6iMe54XDRrja97R3YjRhL0p0j2BP2zJcNkKYEy4YQgJWpcq2ql7E
 +sTls/IVQVxWmTHYWboDfAjBhuAipZw143jBHSyFssjuoFgbuyvWJKqdhWWz/mowyBap
 T2fe1/JF9Re20B3QZoW+9+tyhP19HjZ0EI4CKXTnMwm9wa/a4pyEjjz9Dfxc2FHDcy6A
 VJ9oDvNy7M89Hz4QSuoK8Vz89Dqw6or7dPCb/sPasyXHPTarukBJwbq7M1u4r/ii8rHh
 89kuv/AmOQHXRKoXCeKgg1MrgRS/gKP7rX3Xz8dW893DrZQ2siXkpU7KboJGffbQI/qi
 udFw==
X-Gm-Message-State: AOJu0Yx1Hfuj/vFRp1NLbFgKKpfpmfG3nEx6evDGq0/1ehYKjDHgBp7S
 GrZ3MS9wFw2Lr0bIzs/1pL4cbjuWWyU8Kl4WnAQ=
X-Google-Smtp-Source: AGHT+IGBVeg6i/KO6SVB06kT4KeWajHwPBmIWAiNq3EDvwRDMoy0NdQh4mbT3NLmRcy7b+XeZBvesQ==
X-Received: by 2002:a05:6358:3a1a:b0:171:a2ac:7f6a with SMTP id
 g26-20020a0563583a1a00b00171a2ac7f6amr10100123rwe.56.1702923635068; 
 Mon, 18 Dec 2023 10:20:35 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 dy7-20020ad44e87000000b0067f213933bdsm3046136qvb.2.2023.12.18.10.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 10:20:34 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v3 14/14] bloblist: Align bloblist used_size and total_size to
 spec
Date: Mon, 18 Dec 2023 10:18:59 -0800
Message-Id: <20231218181901.337515-15-raymond.mao@linaro.org>
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

Align used_size and total_size of the bloblist header to the definition
of the FW Handoff spec v0.9.
Update the related bloblist APIs and UT testcases.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- New patch file created for v2.
Changes in v3
- Keep the flag and spare values to align to FW handoff spec up to commit 3592349.

 common/bloblist.c  | 86 +++++++++++++++++++++++++++-------------------
 include/bloblist.h | 25 +++++++++-----
 test/bloblist.c    | 35 ++++++++++---------
 3 files changed, 84 insertions(+), 62 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 6d079c58f7..625e480f6b 100644
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
 	new_alloced = data_start - map_to_sysmem(hdr) +
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
@@ -363,9 +365,9 @@ int bloblist_new(ulong addr, uint size, uint flags, uint align_log2)
 	hdr->hdr_size = sizeof(*hdr);
 	hdr->flags = flags;
 	hdr->magic = BLOBLIST_MAGIC;
-	hdr->size = size;
-	hdr->alloced = hdr->hdr_size;
+	hdr->used_size = hdr->hdr_size;
 	hdr->align_log2 = align_log2 ?: BLOBLIST_BLOB_ALIGN_LOG2;
+	hdr->total_size = size;
 	hdr->chksum = 0;
 	gd->bloblist = hdr;
 
@@ -382,8 +384,13 @@ int bloblist_check(ulong addr, uint size)
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
@@ -399,7 +406,7 @@ int bloblist_finish(void)
 	struct bloblist_hdr *hdr = gd->bloblist;
 
 	hdr->chksum = bloblist_calc_chksum(hdr);
-	log_debug("Finished bloblist size %lx at %lx\n", (ulong)hdr->size,
+	log_debug("Finished bloblist size %lx at %lx\n", (ulong)hdr->used_size,
 		  (ulong)map_to_sysmem(hdr));
 
 	return 0;
@@ -414,33 +421,40 @@ ulong bloblist_get_size(void)
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
@@ -464,7 +478,7 @@ void bloblist_reloc(void *to, uint to_size, void *from, uint from_size)
 
 	memcpy(to, from, from_size);
 	hdr = to;
-	hdr->size = to_size;
+	hdr->total_size = to_size;
 }
 
 int bloblist_init(void)
@@ -494,7 +508,7 @@ int bloblist_init(void)
 				    addr, ret);
 		} else {
 			/* Get the real size, if it is not what we expected */
-			size = gd->bloblist->size;
+			size = gd->bloblist->total_size;
 		}
 	}
 	if (ret) {
diff --git a/include/bloblist.h b/include/bloblist.h
index e3c86808b4..84fc943819 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -175,12 +175,12 @@ enum bloblist_tag_t {
  * @hdr_size: Size of this header, normally sizeof(struct bloblist_hdr). The
  *	first bloblist_rec starts at this offset from the start of the header
  * @align_log2: Power of two of the maximum alignment required by this list
- * @alloced: Total size allocated so far for this bloblist. This starts out as
+ * @used_size: Size allocated so far for this bloblist. This starts out as
  *	sizeof(bloblist_hdr) since we need at least that much space to store a
  *	valid bloblist
- * @size: Total size of the bloblist (non-zero if valid) including this header.
- *	The bloblist extends for this many bytes from the start of this header.
- *	When adding new records, the bloblist can grow up to this size.
+ * @total_size: The number of total bytes that the bloblist can occupy.
+ *	Any blob producer must check if there is sufficient space before adding
+ *	a record to the bloblist.
  * @flags: Space for BLOBLISTF... flags (none yet)
  * @spare: Spare space (for future use)
  */
@@ -190,8 +190,8 @@ struct bloblist_hdr {
 	u8 version;
 	u8 hdr_size;
 	u8 align_log2;
-	u32 alloced;
-	u32 size;
+	u32 used_size;
+	u32 total_size;
 	u32 flags;
 	u32 spare;
 };
@@ -366,10 +366,10 @@ int bloblist_finish(void);
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
@@ -385,6 +385,13 @@ ulong bloblist_get_base(void);
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
index 29abd46862..17d9dd03d0 100644
--- a/test/bloblist.c
+++ b/test/bloblist.c
@@ -107,7 +107,8 @@ static int bloblist_test_blob(struct unit_test_state *uts)
 	hdr = clear_bloblist();
 	ut_assertnull(bloblist_find(TEST_TAG, TEST_BLOBLIST_SIZE));
 	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
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
@@ -274,10 +275,10 @@ static int bloblist_test_cmd_info(struct unit_test_state *uts)
 	ut_silence_console(uts);
 	console_record_reset();
 	run_command("bloblist info", 0);
-	ut_assert_nextline("base:     %lx", (ulong)map_to_sysmem(hdr));
-	ut_assert_nextline("size:     400    1 KiB");
-	ut_assert_nextline("alloced:  50     80 Bytes");
-	ut_assert_nextline("free:     3b0    944 Bytes");
+	ut_assert_nextline("base:       %lx", (ulong)map_to_sysmem(hdr));
+	ut_assert_nextline("total size: 400    1 KiB");
+	ut_assert_nextline("used size:  50     80 Bytes");
+	ut_assert_nextline("free:       3b0    944 Bytes");
 	ut_assert_console_end();
 	ut_unsilence_console(uts);
 
@@ -431,7 +432,7 @@ static int bloblist_test_grow(struct unit_test_state *uts)
 
 	ut_asserteq(sizeof(struct bloblist_hdr) +
 		    sizeof(struct bloblist_rec) * 2 + small_size * 2,
-		    hdr->alloced);
+		    hdr->used_size);
 
 	/* Resize the first one */
 	ut_assertok(bloblist_resize(TEST_TAG, small_size + 4));
@@ -453,7 +454,7 @@ static int bloblist_test_grow(struct unit_test_state *uts)
 	ut_asserteq(sizeof(struct bloblist_hdr) +
 		    sizeof(struct bloblist_rec) * 2 + small_size * 2 +
 		    BLOBLIST_BLOB_ALIGN,
-		    hdr->alloced);
+		    hdr->used_size);
 
 	return 0;
 }
@@ -483,7 +484,7 @@ static int bloblist_test_shrink(struct unit_test_state *uts)
 	hdr = ptr;
 	ut_asserteq(sizeof(struct bloblist_hdr) +
 		    sizeof(struct bloblist_rec) * 2 + small_size * 2,
-		    hdr->alloced);
+		    hdr->used_size);
 
 	/* Resize the first one */
 	new_size = small_size - BLOBLIST_ALIGN - 4;
@@ -503,7 +504,7 @@ static int bloblist_test_shrink(struct unit_test_state *uts)
 	ut_asserteq(sizeof(struct bloblist_hdr) +
 		    sizeof(struct bloblist_rec) * 2 + small_size * 2 -
 		    BLOBLIST_ALIGN,
-		    hdr->alloced);
+		    hdr->used_size);
 
 	return 0;
 }
@@ -531,12 +532,12 @@ static int bloblist_test_resize_fail(struct unit_test_state *uts)
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
 
@@ -568,9 +569,9 @@ static int bloblist_test_resize_last(struct unit_test_state *uts)
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
@@ -588,8 +589,8 @@ static int bloblist_test_resize_last(struct unit_test_state *uts)
 
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

