Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25624C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 19:55:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F97987800;
	Mon, 27 Nov 2023 20:53:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I2mngx3k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34B5387800; Mon, 27 Nov 2023 20:53:32 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5E50877FB
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 20:53:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-67a51d80a02so3840416d6.2
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 11:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701114808; x=1701719608; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OBdRB1XOMlkgxEbT0B1rKFeG1/Um799ti9YDcusOvAo=;
 b=I2mngx3kLlpB+4diptxK6j6uN5GtTTTZvcK+kLXAT9yZRUj1TGuiq4NnZSbEO3jdf0
 74fw7nGJGB4cuZnR3mw09r0IaOXNvtxTR6sAZWlAjzEO/Scb0I/tSKBtL3FBVu6h6yWT
 hRFWqAyC6peqJN0RUc8B/sbLfCVQVviDJurObmnwboHTnJbeDQUL4A2ie1CXkkwGLPyf
 R8M2TEqwWDlgfrsDfBydLStUIyBbVLsn3PCWfPKAgTGwRq91WxnMG6ZrD6lqwBlvh8vZ
 DJaULZstuJNYZK7uSYpBNy3738UDVd+DdbQO9Cm3LBeFweGO8s+Ai3hsv9yIeFxAGD0T
 yK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701114808; x=1701719608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OBdRB1XOMlkgxEbT0B1rKFeG1/Um799ti9YDcusOvAo=;
 b=I0wrf587WNcpUampQjWx89s7IKTJsrFsgBvUd5o+n5mkBsl2ed5+yPj7EO6GQyk6gh
 OWjw2GZPpTNS54Gz1Y5UdX2a3Ch+uWWWtb8axcxtAycEYl9vFniiH7VNEGOn361MFTNh
 8+wHBFazGMOQa1/ClpoaJQyNLori8zQOGfNWQj9MOmcC3SS2fCq8UEsWiLD7gxV2aUMH
 u+Vuj3LWp7eaOL/h2JeeN6As7tZCHUp94soQGLeapfU9x+NRK9jtchZ+5RztrfDqwifI
 oZhseDXjF9qS9sTm9X0y/T7o4dCRPrkO4c3Lg7wM3yQguMoN6YpF/t3WpV86r0cyblPd
 vpwg==
X-Gm-Message-State: AOJu0YzMXX7ysZh+s7K0JMcM8YUOTGztCIZKiR7YxIEtp2B2ely69LmX
 HzCu/Xj0Vt5dDKQtl4awAOoAdpBNGtm3UfsaUmE=
X-Google-Smtp-Source: AGHT+IG2JeYaEpMjiZyc92kzdP2PI/AGp9GmV5QeC8lGNFb/OAaKhNppB2uUFU6Vvj3smNgNdhCFKw==
X-Received: by 2002:a05:6214:b0c:b0:65b:2660:f58b with SMTP id
 u12-20020a0562140b0c00b0065b2660f58bmr13636237qvj.12.1701114808206; 
 Mon, 27 Nov 2023 11:53:28 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 g6-20020ad45106000000b0067a2061fc21sm3087047qvp.101.2023.11.27.11.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 11:53:27 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de,
	ilias.apalodimas@linaro.org,
	sjg@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Nikhil M Jain <n-jain1@ti.com>,
 Baruch Siach <baruch@tkos.co.il>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 16/18] bloblist: Align bloblist used_size and total_size to
 spec
Date: Mon, 27 Nov 2023 11:50:27 -0800
Message-Id: <20231127195029.90951-17-raymond.mao@linaro.org>
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

Align used_size and total_size of the bloblist header to the definition
of the FW Handoff spec v0.9.
Update the related bloblist APIs and UT testcases.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- New patch file created for v2.

 common/bloblist.c  | 86 +++++++++++++++++++++++++++-------------------
 include/bloblist.h | 26 ++++++++------
 test/bloblist.c    | 35 ++++++++++---------
 3 files changed, 84 insertions(+), 63 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 0d482ecd71..91d69e9439 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -78,7 +78,7 @@ const char *bloblist_tag_name(enum bloblist_tag_t tag)
 
 static struct bloblist_rec *bloblist_first_blob(struct bloblist_hdr *hdr)
 {
-	if (hdr->alloced <= hdr->hdr_size)
+	if (hdr->used_size <= hdr->hdr_size)
 		return NULL;
 	return (struct bloblist_rec *)((void *)hdr + hdr->hdr_size);
 }
@@ -111,7 +111,7 @@ static struct bloblist_rec *bloblist_next_blob(struct bloblist_hdr *hdr,
 {
 	ulong offset = bloblist_blob_end_ofs(hdr, rec);
 
-	if (offset >= hdr->alloced)
+	if (offset >= hdr->used_size)
 		return NULL;
 	return (struct bloblist_rec *)((void *)hdr + offset);
 }
@@ -148,9 +148,9 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
 		align_log2 = BLOBLIST_BLOB_ALIGN_LOG2;
 
 	/* Figure out where the new data will start */
-	data_start = map_to_sysmem(hdr) + hdr->alloced + sizeof(*rec);
+	data_start = map_to_sysmem(hdr) + hdr->used_size + sizeof(*rec);
 
-	/* Align the address and then calculate the offset from ->alloced */
+	/* Align the address and then calculate the offset from used size */
 	aligned_start = ALIGN(data_start, 1U << align_log2) - data_start;
 
 	/* If we need to create a dummy record, create it */
@@ -164,19 +164,20 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
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
@@ -184,7 +185,7 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
 	/* Zero the record data */
 	memset((void *)rec + rec_hdr_size(rec), '\0', rec->size);
 
-	hdr->alloced = new_alloced;
+	hdr->used_size = new_alloced;
 	*recp = rec;
 
 	return 0;
@@ -279,29 +280,30 @@ static int bloblist_resize_rec(struct bloblist_hdr *hdr,
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
@@ -335,7 +337,7 @@ static u32 bloblist_calc_chksum(struct bloblist_hdr *hdr)
 {
 	u8 chksum;
 
-	chksum = table_compute_checksum(hdr, hdr->alloced);
+	chksum = table_compute_checksum(hdr, hdr->used_size);
 	chksum += hdr->chksum;
 
 	return chksum;
@@ -354,9 +356,9 @@ int bloblist_new(ulong addr, uint size, uint align_log2)
 	hdr->version = BLOBLIST_VERSION;
 	hdr->hdr_size = sizeof(*hdr);
 	hdr->magic = BLOBLIST_MAGIC;
-	hdr->size = size;
-	hdr->alloced = hdr->hdr_size;
+	hdr->used_size = hdr->hdr_size;
 	hdr->align_log2 = align_log2 ?: BLOBLIST_BLOB_ALIGN_LOG2;
+	hdr->total_size = size;
 	hdr->chksum = 0;
 	gd->bloblist = hdr;
 
@@ -373,8 +375,13 @@ int bloblist_check(ulong addr, uint size)
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
@@ -390,7 +397,7 @@ int bloblist_finish(void)
 	struct bloblist_hdr *hdr = gd->bloblist;
 
 	hdr->chksum = bloblist_calc_chksum(hdr);
-	log_debug("Finished bloblist size %lx at %lx\n", (ulong)hdr->size,
+	log_debug("Finished bloblist size %lx at %lx\n", (ulong)hdr->used_size,
 		  (ulong)map_to_sysmem(hdr));
 
 	return 0;
@@ -405,33 +412,40 @@ ulong bloblist_get_size(void)
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
@@ -455,7 +469,7 @@ void bloblist_reloc(void *to, uint to_size, void *from, uint from_size)
 
 	memcpy(to, from, from_size);
 	hdr = to;
-	hdr->size = to_size;
+	hdr->total_size = to_size;
 }
 
 int bloblist_init(void)
@@ -485,7 +499,7 @@ int bloblist_init(void)
 				    addr, ret);
 		} else {
 			/* Get the real size, if it is not what we expected */
-			size = gd->bloblist->size;
+			size = gd->bloblist->total_size;
 		}
 	}
 	if (ret) {
diff --git a/include/bloblist.h b/include/bloblist.h
index 148a94fcd1..0f5afec9f4 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -173,12 +173,12 @@ enum bloblist_tag_t {
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
  */
 struct bloblist_hdr {
 	u32 magic;
@@ -186,9 +186,8 @@ struct bloblist_hdr {
 	u8 version;
 	u8 hdr_size;
 	u8 align_log2;
-
-	u32 alloced;
-	u32 size;
+	u32 used_size;
+	u32 total_size;
 };
 
 /**
@@ -360,10 +359,10 @@ int bloblist_finish(void);
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
@@ -379,6 +378,13 @@ ulong bloblist_get_base(void);
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
index b72603ba9a..dd8e228ea2 100644
--- a/test/bloblist.c
+++ b/test/bloblist.c
@@ -104,7 +104,8 @@ static int bloblist_test_blob(struct unit_test_state *uts)
 	hdr = clear_bloblist();
 	ut_assertnull(bloblist_find(TEST_TAG, TEST_BLOBLIST_SIZE));
 	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
-	ut_asserteq(TEST_BLOBLIST_SIZE, bloblist_get_size());
+	ut_asserteq(sizeof(struct bloblist_hdr), bloblist_get_size());
+	ut_asserteq(TEST_BLOBLIST_SIZE, bloblist_get_total_size());
 	ut_asserteq(TEST_ADDR, bloblist_get_base());
 	ut_asserteq(map_to_sysmem(hdr), TEST_ADDR);
 
@@ -198,9 +199,9 @@ static int bloblist_test_checksum(struct unit_test_state *uts)
 	 * change the size or alloced fields, since that will crash the code.
 	 * It has to rely on these being correct.
 	 */
-	hdr->size--;
+	hdr->total_size--;
 	ut_asserteq(-EFBIG, bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
-	hdr->size++;
+	hdr->total_size++;
 
 	hdr->chksum++;
 	ut_asserteq(-EIO, bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
@@ -263,10 +264,10 @@ static int bloblist_test_cmd_info(struct unit_test_state *uts)
 	ut_silence_console(uts);
 	console_record_reset();
 	run_command("bloblist info", 0);
-	ut_assert_nextline("base:     %lx", (ulong)map_to_sysmem(hdr));
-	ut_assert_nextline("size:     400    1 KiB");
-	ut_assert_nextline("alloced:  48     72 Bytes");
-	ut_assert_nextline("free:     3b8    952 Bytes");
+	ut_assert_nextline("base:       %lx", (ulong)map_to_sysmem(hdr));
+	ut_assert_nextline("total size: 400    1 KiB");
+	ut_assert_nextline("used size:  48     72 Bytes");
+	ut_assert_nextline("free:       3b8    952 Bytes");
 	ut_assert_console_end();
 	ut_unsilence_console(uts);
 
@@ -420,7 +421,7 @@ static int bloblist_test_grow(struct unit_test_state *uts)
 
 	ut_asserteq(sizeof(struct bloblist_hdr) +
 		    sizeof(struct bloblist_rec) * 2 + small_size * 2,
-		    hdr->alloced);
+		    hdr->used_size);
 
 	/* Resize the first one */
 	ut_assertok(bloblist_resize(TEST_TAG, small_size + 4));
@@ -442,7 +443,7 @@ static int bloblist_test_grow(struct unit_test_state *uts)
 	ut_asserteq(sizeof(struct bloblist_hdr) +
 		    sizeof(struct bloblist_rec) * 2 + small_size * 2 +
 		    BLOBLIST_BLOB_ALIGN,
-		    hdr->alloced);
+		    hdr->used_size);
 
 	return 0;
 }
@@ -472,7 +473,7 @@ static int bloblist_test_shrink(struct unit_test_state *uts)
 	hdr = ptr;
 	ut_asserteq(sizeof(struct bloblist_hdr) +
 		    sizeof(struct bloblist_rec) * 2 + small_size * 2,
-		    hdr->alloced);
+		    hdr->used_size);
 
 	/* Resize the first one */
 	new_size = small_size - BLOBLIST_ALIGN - 4;
@@ -492,7 +493,7 @@ static int bloblist_test_shrink(struct unit_test_state *uts)
 	ut_asserteq(sizeof(struct bloblist_hdr) +
 		    sizeof(struct bloblist_rec) * 2 + small_size * 2 -
 		    BLOBLIST_ALIGN,
-		    hdr->alloced);
+		    hdr->used_size);
 
 	return 0;
 }
@@ -520,12 +521,12 @@ static int bloblist_test_resize_fail(struct unit_test_state *uts)
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
 
@@ -557,9 +558,9 @@ static int bloblist_test_resize_last(struct unit_test_state *uts)
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
@@ -577,8 +578,8 @@ static int bloblist_test_resize_last(struct unit_test_state *uts)
 
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

