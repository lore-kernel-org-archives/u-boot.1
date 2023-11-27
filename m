Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C79C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 19:54:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB807877EF;
	Mon, 27 Nov 2023 20:53:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EwOrLM0B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE64B877EF; Mon, 27 Nov 2023 20:53:02 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 899C9877CE
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 20:53:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-77d6330b20bso249474185a.1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 11:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701114779; x=1701719579; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CdKo8DRtmZt+jI+p+RlVvnhrHPi/2pkyeBwq3Z0f7+k=;
 b=EwOrLM0BNnfuwAHZCK+Gth6Am/Bga3pgpf7y0M2RHjAGOIJpuTjVY7js7sZotp9LVl
 eOhGaDOHIVYwCHGdh7KTv0GCiQSt3OMEz7a0L6h8d3AK44DgtBrtQA4GM3NeJjJkhyms
 qfumN1JpNRPyndsT52faAQSvHe93S6SaXh+oytTYqSl+OU1bqNIBYfjxioRXefr5yD6m
 1ok2I1V9DHpaYEbqBwLC1JkiSZJDMkDbsM1/extWOZwgxJBrswWTgfF1lHeVQbxHwjZb
 xyfl9n9V1NeLB3Nd4IhuUThSvjYHQdXYu4R6jrM++q1pV+ZNpFxC21rbsjLD7Gg5UqlR
 IHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701114779; x=1701719579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CdKo8DRtmZt+jI+p+RlVvnhrHPi/2pkyeBwq3Z0f7+k=;
 b=s7JrgV/AMGtOIb0CSl2cG92FXCIGlyaA6TecpDfCefn8ByumGJhECcPhAu5NBpleoZ
 cvIF19r30GBhmraDtqLq2OMnG39fjJOXRF70OlStzjZjPoBCng9yID4/VWBHwBrRxatj
 9c8mpG668e+VzO9jMR2p0yiZxVwrzl5o6HNTaGcL9LLC7XOeW0BBLVtG3V684d7qlVhd
 kfOc1SlT1If5+IwF+Li4zGiVAQHuKZqJiPuNujSxbmPXOnynxNmONQEgt22m+EVAGzSw
 194g0TdKfLuBMMe9O2/39FPwYFVoWcL7ScVIYL45zdE13GiB+8EzXOI7GoL6DMERpjqL
 NBFw==
X-Gm-Message-State: AOJu0YyQYrj4njiBx83+PsgqDNRrmQoX9LHbRdBUSmSSedb5k7CFB9cA
 VdiNwhALDX7I18ZCL7TVPTD3Tj6FbSaiV5kIHHM=
X-Google-Smtp-Source: AGHT+IFXppVKPJk7pUAuLSqXeZaj3skSUf4va9M5Vy5Uc6RKpxaNj6t7Al9trXqgBNWtcsCjJQ2iWg==
X-Received: by 2002:ad4:5042:0:b0:67a:234c:2c8a with SMTP id
 m2-20020ad45042000000b0067a234c2c8amr10675706qvq.51.1701114779144; 
 Mon, 27 Nov 2023 11:52:59 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 g6-20020ad45106000000b0067a2061fc21sm3087047qvp.101.2023.11.27.11.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 11:52:58 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de,
	ilias.apalodimas@linaro.org,
	sjg@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Nikhil M Jain <n-jain1@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 11/18] bloblist: Reduce blob-header size
Date: Mon, 27 Nov 2023 11:50:22 -0800
Message-Id: <20231127195029.90951-12-raymond.mao@linaro.org>
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

The v0.9 spec provides for an 8-byte header for each blob, with fewer
fields.
The blob start address should be aligned to the alignment specified
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

 common/bloblist.c  | 17 +++++++++--------
 include/bloblist.h | 33 ++++++++++++++++++++++-----------
 test/bloblist.c    | 16 ++++++++--------
 3 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 59a092d4cd..55a7e1f591 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -85,12 +85,14 @@ static struct bloblist_rec *bloblist_first_blob(struct bloblist_hdr *hdr)
 
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
@@ -99,7 +101,7 @@ static ulong bloblist_blob_end_ofs(struct bloblist_hdr *hdr,
 	ulong offset;
 
 	offset = (void *)rec - (void *)hdr;
-	offset += rec_hdr_size(rec) + ALIGN(rec->size, BLOBLIST_ALIGN);
+	offset += rec_hdr_size(rec) + ALIGN(rec->size, 1 << hdr->align_log2);
 
 	return offset;
 }
@@ -143,7 +145,7 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
 	int data_start, aligned_start, new_alloced;
 
 	if (!align_log2)
-		align_log2 = BLOBLIST_ALIGN_LOG2;
+		align_log2 = BLOBLIST_BLOB_ALIGN_LOG2;
 
 	/* Figure out where the new data will start */
 	data_start = map_to_sysmem(hdr) + hdr->alloced + sizeof(*rec);
@@ -176,8 +178,7 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
 	}
 	rec = (void *)hdr + hdr->alloced;
 
-	rec->tag = tag;
-	rec->hdr_size = sizeof(struct bloblist_rec);
+	rec->tag_and_hdr_size = tag | sizeof(*rec) << BLOBLISTR_HDR_SIZE_SHIFT;
 	rec->size = size;
 
 	/* Zero the record data */
@@ -281,8 +282,8 @@ static int bloblist_resize_rec(struct bloblist_hdr *hdr,
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
index ab7a7fc299..745bcdd227 100644
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
 	BLOBLIST_MAGIC		= 0x6ed0ff,
 
+	BLOBLIST_BLOB_ALIGN_LOG2 = 3,
+	BLOBLIST_BLOB_ALIGN	 = 1 << BLOBLIST_BLOB_ALIGN_LOG2,
+
 	BLOBLIST_ALIGN_LOG2	= 3,
 	BLOBLIST_ALIGN		= 1 << BLOBLIST_ALIGN_LOG2,
 };
@@ -195,17 +198,25 @@ struct bloblist_hdr {
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
  */
 struct bloblist_rec {
-	u32 tag;
-	u32 hdr_size;
+	u32 tag_and_hdr_size;
 	u32 size;
-	u32 _spare;
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
index 32256be772..7e65f30518 100644
--- a/test/bloblist.c
+++ b/test/bloblist.c
@@ -261,8 +261,8 @@ static int bloblist_test_cmd_info(struct unit_test_state *uts)
 	run_command("bloblist info", 0);
 	ut_assert_nextline("base:     %lx", (ulong)map_to_sysmem(hdr));
 	ut_assert_nextline("size:     400    1 KiB");
-	ut_assert_nextline("alloced:  70     112 Bytes");
-	ut_assert_nextline("free:     390    912 Bytes");
+	ut_assert_nextline("alloced:  58     88 Bytes");
+	ut_assert_nextline("free:     3a8    936 Bytes");
 	ut_assert_console_end();
 	ut_unsilence_console(uts);
 
@@ -320,12 +320,12 @@ static int bloblist_test_align(struct unit_test_state *uts)
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
 
@@ -340,7 +340,7 @@ static int bloblist_test_align(struct unit_test_state *uts)
 	}
 
 	/* Check alignment with an bloblist starting on a smaller alignment */
-	hdr = map_sysmem(TEST_ADDR + BLOBLIST_ALIGN, TEST_BLOBLIST_SIZE);
+	hdr = map_sysmem(TEST_ADDR + BLOBLIST_BLOB_ALIGN, TEST_BLOBLIST_SIZE);
 	memset(hdr, ERASE_BYTE, TEST_BLOBLIST_SIZE);
 	memset(hdr, '\0', sizeof(*hdr));
 	ut_assertok(bloblist_new(TEST_ADDR + BLOBLIST_ALIGN,
@@ -349,7 +349,7 @@ static int bloblist_test_align(struct unit_test_state *uts)
 	data = bloblist_add(1, 5, BLOBLIST_ALIGN_LOG2 + 1);
 	ut_assertnonnull(data);
 	addr = map_to_sysmem(data);
-	ut_asserteq(0, addr & (BLOBLIST_ALIGN * 2 - 1));
+	ut_asserteq(0, addr & (BLOBLIST_BLOB_ALIGN * 2 - 1));
 
 	return 0;
 }
@@ -437,7 +437,7 @@ static int bloblist_test_grow(struct unit_test_state *uts)
 	hdr = ptr;
 	ut_asserteq(sizeof(struct bloblist_hdr) +
 		    sizeof(struct bloblist_rec) * 2 + small_size * 2 +
-		    BLOBLIST_ALIGN,
+		    BLOBLIST_BLOB_ALIGN,
 		    hdr->alloced);
 
 	return 0;
@@ -572,7 +572,7 @@ static int bloblist_test_resize_last(struct unit_test_state *uts)
 	ut_asserteq((u8)ERASE_BYTE, *((u8 *)hdr + alloced_val + 4));
 
 	/* Check that the new top of the allocated blobs has not been touched */
-	alloced_val += BLOBLIST_ALIGN;
+	alloced_val += BLOBLIST_BLOB_ALIGN;
 	ut_asserteq(alloced_val, hdr->alloced);
 	ut_asserteq((u8)ERASE_BYTE, *((u8 *)hdr + hdr->alloced));
 
-- 
2.25.1

