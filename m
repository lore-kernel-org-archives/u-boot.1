Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B27C47073
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:44:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7496987B87;
	Fri, 29 Dec 2023 18:43:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WQ3eLTTy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B595087B7D; Fri, 29 Dec 2023 18:43:39 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5897687BA1
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:43:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5e7c1012a42so60233537b3.3
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 09:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703871816; x=1704476616; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FxLiggeY28AuJ/8Oxa2sOMLSxh96V164A4IFdD7A9cM=;
 b=WQ3eLTTyoHczn6kXM7Pw6frSzQL5kofgSwvEcizQ0gaVdmi8h9UGcfzQ7QOjMZsjdl
 6tnSTPOew2p7MbGuJ3Os3MYBUsy23WF3Yvd2KM7hygTafGqWxSGBmaGL4Ft2LkjnjTvp
 to7bmzpaoxFaGPEy67zSm8twsKEUTN07V3o0c7KLkh5H6l8PzkZ7Ab1KAXkpZja1eMOH
 EhCezmmU2pT7yvRHnDqR/B/L+nq9/FrpjAg/VkH/3pZ4YK7lJBlioT5eLt6YFSYggytt
 sMMoYWTV92vTKBW83M9YbJE+Y+SE5fHOP3MZokS/OWLugTRUGqHkDQ9TEDyQquUu4jS5
 hDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703871816; x=1704476616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FxLiggeY28AuJ/8Oxa2sOMLSxh96V164A4IFdD7A9cM=;
 b=bYqWlBOv7qhQCTJvfxyvaXIO0x0P+7By6jFKiPbQkGdgOv8U/8FTuxFC8BGE1ZzpgW
 D1GdNskszOrWYX66SeVhTRSaoTOLPRunGprUOXLJ6Mndljko2pTHthiWtbcPxdVhZRKT
 /YtQ+N9vYeKIcbvDibidmHayIU0di0xbohcVdu5mo1c0dNRLxPK2e1F/ssNktZRLmVIY
 ANF38H+M37WtO9MFwgLESBNLdXX4ymru28he1ps2FVd+dwThKKZmZ7pKVAl6vn54Aqmo
 VUX5K8mubXpOrf3vSaPVFolGO9kxqyOQZGSHg0nxpYHAP/EklF3EJTVd7A1+dwLwieP4
 0+Yw==
X-Gm-Message-State: AOJu0YzZcxWrpO1NNgUh5JMhsFAD1H+NTvsR3DbU2BkJ3Yf6N/amVaCn
 g8vfmnl1D6QKLUt+nfaVTYDyYf+PeCQd4ImMF6DKGkLFixo=
X-Google-Smtp-Source: AGHT+IF3IkORzmj3TDNn1FRTvyJF8XLahB78gNG/BbVl42yRTvk71pX4J28YORJtFjae+P9NYC+lEA==
X-Received: by 2002:a81:80c1:0:b0:5d7:1941:3562 with SMTP id
 q184-20020a8180c1000000b005d719413562mr8960480ywf.73.1703871815926; 
 Fri, 29 Dec 2023 09:43:35 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a05620a122b00b007817084e7basm1545849qkj.99.2023.12.29.09.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 09:43:35 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v5 08/11] bloblist: Reduce blob-header size
Date: Fri, 29 Dec 2023 09:42:40 -0800
Message-Id: <20231229174244.892818-9-raymond.mao@linaro.org>
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

The v0.9 spec provides for an 8-byte header for each blob, with fewer
fields.
Drop spare value from bloblist record header.
The blob data start address should be aligned to the alignment specified
by the bloblist header.
Update the implementation to match this.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Update the blob start address to align to the alignment required by
  the bloblist header.
- Define the macros of bloblist header size and bloblist record header
  size as the size of their structures.  
Changes in v3
- Update the calculation of the bloblist record offset to make sure
  that each bloblist record data section start address fulfills the
  alignment requirement.
- Update commit message.
Changes in v5
- Squash #6 from v4 into this patch.

 common/bloblist.c  | 24 +++++++++++++++---------
 include/bloblist.h | 34 ++++++++++++++++++++++------------
 test/bloblist.c    | 16 ++++++++--------
 3 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index da688fe149..6dc384df5c 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -87,12 +87,14 @@ static struct bloblist_rec *bloblist_first_blob(struct bloblist_hdr *hdr)
 
 static inline uint rec_hdr_size(struct bloblist_rec *rec)
 {
-	return rec->hdr_size;
+	return (rec->tag_and_hdr_size & BLOBLISTR_HDR_SIZE_MASK) >>
+		BLOBLISTR_HDR_SIZE_SHIFT;
 }
 
 static inline uint rec_tag(struct bloblist_rec *rec)
 {
-	return rec->tag;
+	return (rec->tag_and_hdr_size & BLOBLISTR_TAG_MASK) >>
+		BLOBLISTR_TAG_SHIFT;
 }
 
 static ulong bloblist_blob_end_ofs(struct bloblist_hdr *hdr,
@@ -101,7 +103,13 @@ static ulong bloblist_blob_end_ofs(struct bloblist_hdr *hdr,
 	ulong offset;
 
 	offset = (void *)rec - (void *)hdr;
-	offset += rec_hdr_size(rec) + ALIGN(rec->size, BLOBLIST_ALIGN);
+	/*
+	 * The data section of next TE should start from an address aligned
+	 * to 1 << hdr->align_log2.
+	 */
+	offset += rec_hdr_size(rec) + rec->size;
+	offset = round_up(offset + rec_hdr_size(rec), 1 << hdr->align_log2);
+	offset -= rec_hdr_size(rec);
 
 	return offset;
 }
@@ -145,7 +153,7 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
 	int data_start, aligned_start, new_alloced;
 
 	if (!align_log2)
-		align_log2 = BLOBLIST_ALIGN_LOG2;
+		align_log2 = BLOBLIST_BLOB_ALIGN_LOG2;
 
 	/* Figure out where the new data will start */
 	data_start = map_to_sysmem(hdr) + hdr->alloced + sizeof(*rec);
@@ -178,10 +186,8 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
 	}
 	rec = (void *)hdr + hdr->alloced;
 
-	rec->tag = tag;
-	rec->hdr_size = sizeof(struct bloblist_rec);
+	rec->tag_and_hdr_size = tag | sizeof(*rec) << BLOBLISTR_HDR_SIZE_SHIFT;
 	rec->size = size;
-	rec->spare = 0;
 
 	/* Zero the record data */
 	memset((void *)rec + rec_hdr_size(rec), '\0', rec->size);
@@ -284,8 +290,8 @@ static int bloblist_resize_rec(struct bloblist_hdr *hdr,
 	int new_alloced;	/* New value for @hdr->alloced */
 	ulong next_ofs;	/* Offset of the record after @rec */
 
-	expand_by = ALIGN(new_size - rec->size, BLOBLIST_ALIGN);
-	new_alloced = ALIGN(hdr->alloced + expand_by, BLOBLIST_ALIGN);
+	expand_by = ALIGN(new_size - rec->size, BLOBLIST_BLOB_ALIGN);
+	new_alloced = ALIGN(hdr->alloced + expand_by, BLOBLIST_BLOB_ALIGN);
 	if (new_size < 0) {
 		log_debug("Attempt to shrink blob size below 0 (%x)\n",
 			  new_size);
diff --git a/include/bloblist.h b/include/bloblist.h
index 255ac8d554..7024d7bf9e 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -24,11 +24,11 @@
  * which would add to code size. For Thumb-2 the code size needed in SPL is
  * approximately 940 bytes (e.g. for chromebook_bob).
  *
- * 5. Bloblist uses 16-byte alignment internally and is designed to start on a
- * 16-byte boundary. Its headers are multiples of 16 bytes. This makes it easier
- * to deal with data structures which need this level of alignment, such as ACPI
- * tables. For use in SPL and TPL the alignment can be relaxed, since it can be
- * relocated to an aligned address in U-Boot proper.
+ * 5. Bloblist uses 8-byte alignment internally and is designed to start on a
+ * 8-byte boundary. Its headers are 8 bytes long. It is possible to achieve
+ * larger alignment (e.g. 16 bytes) by adding a dummy header, For use in SPL and
+ * TPL the alignment can be relaxed, since it can be relocated to an aligned
+ * address in U-Boot proper.
  *
  * 6. Bloblist is designed to be passed to Linux as reserved memory. While linux
  * doesn't understand the bloblist header, it can be passed the indivdual blobs.
@@ -77,6 +77,9 @@ enum {
 	BLOBLIST_VERSION	= 1,
 	BLOBLIST_MAGIC		= 0x4a0fb10b,
 
+	BLOBLIST_BLOB_ALIGN_LOG2 = 3,
+	BLOBLIST_BLOB_ALIGN	 = 1 << BLOBLIST_BLOB_ALIGN_LOG2,
+
 	BLOBLIST_ALIGN_LOG2	= 3,
 	BLOBLIST_ALIGN		= 1 << BLOBLIST_ALIGN_LOG2,
 };
@@ -199,18 +202,25 @@ struct bloblist_hdr {
  *
  * NOTE: Only exported for testing purposes. Do not use this struct.
  *
- * @tag: Tag indicating what the record contains
- * @hdr_size: Size of this header, normally sizeof(struct bloblist_rec). The
- *	record's data starts at this offset from the start of the record
+ * @tag_and_hdr_size: Tag indicating what the record contains (bottom 24 bits), and
+ *	size of this header (top 8 bits), normally sizeof(struct bloblist_rec).
+ *	The record's data starts at this offset from the start of the record
  * @size: Size of record in bytes, excluding the header size. This does not
  *	need to be aligned (e.g. 3 is OK).
- * @spare: Spare space for other things
  */
 struct bloblist_rec {
-	u32 tag;
-	u32 hdr_size;
+	u32 tag_and_hdr_size;
 	u32 size;
-	u32 spare;
+};
+
+enum {
+	BLOBLISTR_TAG_SHIFT		= 0,
+	BLOBLISTR_TAG_MASK		= 0xffffffU << BLOBLISTR_TAG_SHIFT,
+	BLOBLISTR_HDR_SIZE_SHIFT	= 24,
+	BLOBLISTR_HDR_SIZE_MASK		= 0xffU << BLOBLISTR_HDR_SIZE_SHIFT,
+
+	BLOBLIST_HDR_SIZE		= sizeof(struct bloblist_hdr),
+	BLOBLIST_REC_HDR_SIZE		= sizeof(struct bloblist_rec),
 };
 
 /**
diff --git a/test/bloblist.c b/test/bloblist.c
index 49ac4b92ae..e6070041d3 100644
--- a/test/bloblist.c
+++ b/test/bloblist.c
@@ -272,8 +272,8 @@ static int bloblist_test_cmd_info(struct unit_test_state *uts)
 	run_command("bloblist info", 0);
 	ut_assert_nextline("base:     %lx", (ulong)map_to_sysmem(hdr));
 	ut_assert_nextline("size:     400    1 KiB");
-	ut_assert_nextline("alloced:  70     112 Bytes");
-	ut_assert_nextline("free:     390    912 Bytes");
+	ut_assert_nextline("alloced:  58     88 Bytes");
+	ut_assert_nextline("free:     3a8    936 Bytes");
 	ut_assert_console_end();
 	ut_unsilence_console(uts);
 
@@ -331,12 +331,12 @@ static int bloblist_test_align(struct unit_test_state *uts)
 		data = bloblist_add(i, size, 0);
 		ut_assertnonnull(data);
 		addr = map_to_sysmem(data);
-		ut_asserteq(0, addr & (BLOBLIST_ALIGN - 1));
+		ut_asserteq(0, addr & (BLOBLIST_BLOB_ALIGN - 1));
 
 		/* Only the bytes in the blob data should be zeroed */
 		for (j = 0; j < size; j++)
 			ut_asserteq(0, data[j]);
-		for (; j < BLOBLIST_ALIGN; j++)
+		for (; j < BLOBLIST_BLOB_ALIGN; j++)
 			ut_asserteq(ERASE_BYTE, data[j]);
 	}
 
@@ -351,7 +351,7 @@ static int bloblist_test_align(struct unit_test_state *uts)
 	}
 
 	/* Check alignment with an bloblist starting on a smaller alignment */
-	hdr = map_sysmem(TEST_ADDR + BLOBLIST_ALIGN, TEST_BLOBLIST_SIZE);
+	hdr = map_sysmem(TEST_ADDR + BLOBLIST_BLOB_ALIGN, TEST_BLOBLIST_SIZE);
 	memset(hdr, ERASE_BYTE, TEST_BLOBLIST_SIZE);
 	memset(hdr, '\0', sizeof(*hdr));
 	ut_assertok(bloblist_new(TEST_ADDR + BLOBLIST_ALIGN, TEST_BLOBLIST_SIZE,
@@ -360,7 +360,7 @@ static int bloblist_test_align(struct unit_test_state *uts)
 	data = bloblist_add(1, 5, BLOBLIST_ALIGN_LOG2 + 1);
 	ut_assertnonnull(data);
 	addr = map_to_sysmem(data);
-	ut_asserteq(0, addr & (BLOBLIST_ALIGN * 2 - 1));
+	ut_asserteq(0, addr & (BLOBLIST_BLOB_ALIGN * 2 - 1));
 
 	return 0;
 }
@@ -448,7 +448,7 @@ static int bloblist_test_grow(struct unit_test_state *uts)
 	hdr = ptr;
 	ut_asserteq(sizeof(struct bloblist_hdr) +
 		    sizeof(struct bloblist_rec) * 2 + small_size * 2 +
-		    BLOBLIST_ALIGN,
+		    BLOBLIST_BLOB_ALIGN,
 		    hdr->alloced);
 
 	return 0;
@@ -583,7 +583,7 @@ static int bloblist_test_resize_last(struct unit_test_state *uts)
 	ut_asserteq((u8)ERASE_BYTE, *((u8 *)hdr + alloced_val + 4));
 
 	/* Check that the new top of the allocated blobs has not been touched */
-	alloced_val += BLOBLIST_ALIGN;
+	alloced_val += BLOBLIST_BLOB_ALIGN;
 	ut_asserteq(alloced_val, hdr->alloced);
 	ut_asserteq((u8)ERASE_BYTE, *((u8 *)hdr + hdr->alloced));
 
-- 
2.25.1

