Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD8CC47073
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:44:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EC2087B93;
	Fri, 29 Dec 2023 18:43:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GPvxemqI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A144587A03; Fri, 29 Dec 2023 18:43:46 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5384B87BA1
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:43:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3bbebe6191bso215348b6e.3
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 09:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703871822; x=1704476622; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9HuzfwQka3/aualIE6EldvO4/bkDmyufA+xptBjieNQ=;
 b=GPvxemqI2gKPk92YWZBk2SoZwH22RiNH8vFoiwpDCBjIKE5MvWP1oFzbq+Msd45EaQ
 sjvx5e8AxFTmQqrV2j2j8DGTfQ8reVMz+uGLx9/F6GDCXNy3u8IZmqEpKw7S1wBE39Ge
 WPdO7dXibP1RJYlptt3f0kYu3Z+sNCtKleTMpFkhCq9VDLPFo76KV+D/WjHLyqV+uS7u
 X7lCuiaoXGVjrp/kRKIauFObsKSySEB3bE0Mc2hJoxlXF2OnGQvkV3n2JBvk9lrhBlmr
 UdBlPoU6OGPURSYezun7gXTXLzWdcLR4mgMLwB9pbJk1FeeAxsmMrkvsM3XlwVXo4aSn
 Etrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703871822; x=1704476622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9HuzfwQka3/aualIE6EldvO4/bkDmyufA+xptBjieNQ=;
 b=VjPD1ugfQz/jdygScv4/Ta06abjnEskg2QTHAhZ+mKPicnOnuJwN+KtRBvBLIp/gQX
 rV/lFHaHLsGWlfj9H7XMV9WjWyxjkhrNAmXussRsSOx51uSo4WGZIsqaNuM37uInPgAx
 XocRlRhdQfKCgZ0AG9gCjvjDM0kIZMlgFor8EAQ5WJ25EbXxsaiBTn9BX4zxzIEC+xQ+
 Vl05tWXoPcPvY+XPvYB86GhwV9Z2nxrV3/0LcPuNjBmzJvQ7btOcBFWvY41U5gLQbd9/
 tUI/r4Dj8OgjxABR75MZ0fFu/RgCme7pqHeJyorIv/hGXG5feFg9F/qM5Fu7L9sgmOqd
 jOkg==
X-Gm-Message-State: AOJu0YwyoHs4gFPn3igAPllu7OtmhetINrbcwwRhVer8jvVG9COe3tJ+
 qtQdv6FEnAf4ShLlC9Od/TDk2su4K4B32u7PIH18uM+CSvg=
X-Google-Smtp-Source: AGHT+IHsoc+EAOPugKo0VbEe48DmXPatAPQtQSDm/tG7GZ58yiSC+3CMSNlYmCxZLogKCrm/C+BLHg==
X-Received: by 2002:a05:6808:23c4:b0:3bb:dcf8:eb00 with SMTP id
 bq4-20020a05680823c400b003bbdcf8eb00mr2048284oib.11.1703871822569; 
 Fri, 29 Dec 2023 09:43:42 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a05620a122b00b007817084e7basm1545849qkj.99.2023.12.29.09.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 09:43:42 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v5 10/11] bloblist: Add alignment to bloblist_new()
Date: Fri, 29 Dec 2023 09:42:42 -0800
Message-Id: <20231229174244.892818-11-raymond.mao@linaro.org>
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

Allow the alignment to be specified when creating a bloblist.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v3
- Keep the flag argument to align to FW handoff spec up to commit 3592349.
Changes in v4
- Minor fix to use a full ternary operator in function bloblist_new().

 common/bloblist.c  |  5 +++--
 include/bloblist.h |  3 ++-
 test/bloblist.c    | 40 ++++++++++++++++++++++------------------
 3 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index c9aecdfbd5..9daf0d2b13 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -351,7 +351,7 @@ static u32 bloblist_calc_chksum(struct bloblist_hdr *hdr)
 	return chksum;
 }
 
-int bloblist_new(ulong addr, uint size, uint flags)
+int bloblist_new(ulong addr, uint size, uint flags, uint align_log2)
 {
 	struct bloblist_hdr *hdr;
 
@@ -367,6 +367,7 @@ int bloblist_new(ulong addr, uint size, uint flags)
 	hdr->magic = BLOBLIST_MAGIC;
 	hdr->used_size = hdr->hdr_size;
 	hdr->total_size = size;
+	hdr->align_log2 = align_log2 ? align_log2 : BLOBLIST_BLOB_ALIGN_LOG2;
 	hdr->chksum = 0;
 	gd->bloblist = hdr;
 
@@ -522,7 +523,7 @@ int bloblist_init(void)
 		}
 		log_debug("Creating new bloblist size %lx at %lx\n", size,
 			  addr);
-		ret = bloblist_new(addr, size, 0);
+		ret = bloblist_new(addr, size, 0, 0);
 	} else {
 		log_debug("Found existing bloblist size %lx at %lx\n", size,
 			  addr);
diff --git a/include/bloblist.h b/include/bloblist.h
index 4ec4b3d449..145e5c0242 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -330,10 +330,11 @@ int bloblist_resize(uint tag, int new_size);
  * @addr: Address of bloblist
  * @size: Initial size for bloblist
  * @flags: Flags to use for bloblist
+ * @align_log2: Log base 2 of maximum alignment provided by this bloblist
  * Return: 0 if OK, -EFAULT if addr is not aligned correctly, -ENOSPC is the
  * area is not large enough
  */
-int bloblist_new(ulong addr, uint size, uint flags);
+int bloblist_new(ulong addr, uint size, uint flags, uint align_log2);
 
 /**
  * bloblist_check() - Check if a bloblist exists
diff --git a/test/bloblist.c b/test/bloblist.c
index 2b06ce844f..17d9dd03d0 100644
--- a/test/bloblist.c
+++ b/test/bloblist.c
@@ -72,15 +72,15 @@ static int bloblist_test_init(struct unit_test_state *uts)
 	hdr = clear_bloblist();
 	ut_asserteq(-ENOENT, bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
 	ut_asserteq_ptr(NULL, bloblist_check_magic(TEST_ADDR));
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
 	ut_asserteq_ptr(hdr, bloblist_check_magic(TEST_ADDR));
 	hdr->version++;
 	ut_asserteq(-EPROTONOSUPPORT, bloblist_check(TEST_ADDR,
 						     TEST_BLOBLIST_SIZE));
 
-	ut_asserteq(-ENOSPC, bloblist_new(TEST_ADDR, 0xc, 0));
-	ut_asserteq(-EFAULT, bloblist_new(1, TEST_BLOBLIST_SIZE, 0));
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
+	ut_asserteq(-ENOSPC, bloblist_new(TEST_ADDR, 0xc, 0, 0));
+	ut_asserteq(-EFAULT, bloblist_new(1, TEST_BLOBLIST_SIZE, 0, 0));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
 
 	ut_asserteq(-EIO, bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
 	ut_assertok(bloblist_finish());
@@ -106,7 +106,7 @@ static int bloblist_test_blob(struct unit_test_state *uts)
 	/* At the start there should be no records */
 	hdr = clear_bloblist();
 	ut_assertnull(bloblist_find(TEST_TAG, TEST_BLOBLIST_SIZE));
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
 	ut_asserteq(sizeof(struct bloblist_hdr), bloblist_get_size());
 	ut_asserteq(TEST_BLOBLIST_SIZE, bloblist_get_total_size());
 	ut_asserteq(TEST_ADDR, bloblist_get_base());
@@ -145,7 +145,7 @@ static int bloblist_test_blob_ensure(struct unit_test_state *uts)
 
 	/* At the start there should be no records */
 	clear_bloblist();
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
 
 	/* Test with an empty bloblist */
 	size = TEST_SIZE;
@@ -177,7 +177,7 @@ static int bloblist_test_bad_blob(struct unit_test_state *uts)
 	void *data;
 
 	hdr = clear_bloblist();
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
 	data = hdr + 1;
 	data += sizeof(struct bloblist_rec);
 	ut_asserteq_addr(data, bloblist_ensure(TEST_TAG, TEST_SIZE));
@@ -193,7 +193,7 @@ static int bloblist_test_checksum(struct unit_test_state *uts)
 	char *data, *data2;
 
 	hdr = clear_bloblist();
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
 	ut_assertok(bloblist_finish());
 	ut_assertok(bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
 
@@ -218,6 +218,10 @@ static int bloblist_test_checksum(struct unit_test_state *uts)
 	ut_asserteq(-EIO, bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
 	hdr->chksum--;
 
+	hdr->align_log2++;
+	ut_asserteq(-EIO, bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
+	hdr->align_log2--;
+
 	/* Make sure the checksum changes when we add blobs */
 	data = bloblist_add(TEST_TAG, TEST_SIZE, 0);
 	ut_asserteq(-EIO, bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
@@ -263,7 +267,7 @@ static int bloblist_test_cmd_info(struct unit_test_state *uts)
 	char *data, *data2;
 
 	hdr = clear_bloblist();
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
 	data = bloblist_ensure(TEST_TAG, TEST_SIZE);
 	data2 = bloblist_ensure(TEST_TAG2, TEST_SIZE2);
 
@@ -289,7 +293,7 @@ static int bloblist_test_cmd_list(struct unit_test_state *uts)
 	char *data, *data2;
 
 	hdr = clear_bloblist();
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
 	data = bloblist_ensure(TEST_TAG, TEST_SIZE);
 	data2 = bloblist_ensure(TEST_TAG2, TEST_SIZE2);
 
@@ -319,7 +323,7 @@ static int bloblist_test_align(struct unit_test_state *uts)
 
 	/* At the start there should be no records */
 	hdr = clear_bloblist();
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
 	ut_assertnull(bloblist_find(TEST_TAG, TEST_BLOBLIST_SIZE));
 
 	/* Check the default alignment */
@@ -356,7 +360,7 @@ static int bloblist_test_align(struct unit_test_state *uts)
 	memset(hdr, ERASE_BYTE, TEST_BLOBLIST_SIZE);
 	memset(hdr, '\0', sizeof(*hdr));
 	ut_assertok(bloblist_new(TEST_ADDR + BLOBLIST_ALIGN, TEST_BLOBLIST_SIZE,
-				 0));
+				 0, 0));
 
 	data = bloblist_add(1, 5, BLOBLIST_ALIGN_LOG2 + 1);
 	ut_assertnonnull(data);
@@ -377,7 +381,7 @@ static int bloblist_test_reloc(struct unit_test_state *uts)
 	ulong new_addr;
 	ulong new_size;
 
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
 	old_ptr = map_sysmem(TEST_ADDR, TEST_BLOBLIST_SIZE);
 
 	/* Add one blob and then one that won't fit */
@@ -416,7 +420,7 @@ static int bloblist_test_grow(struct unit_test_state *uts)
 	memset(hdr, ERASE_BYTE, TEST_BLOBLIST_SIZE);
 
 	/* Create two blobs */
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
 	blob1 = bloblist_add(TEST_TAG, small_size, 0);
 	ut_assertnonnull(blob1);
 	ut_assertok(check_zero(blob1, small_size));
@@ -468,7 +472,7 @@ static int bloblist_test_shrink(struct unit_test_state *uts)
 	ptr = map_sysmem(TEST_ADDR, TEST_BLOBLIST_SIZE);
 
 	/* Create two blobs */
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
 	blob1 = bloblist_add(TEST_TAG, small_size, 0);
 	ut_assertnonnull(blob1);
 	strcpy(blob1, test1_str);
@@ -518,7 +522,7 @@ static int bloblist_test_resize_fail(struct unit_test_state *uts)
 	ptr = map_sysmem(TEST_ADDR, TEST_BLOBLIST_SIZE);
 
 	/* Create two blobs */
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
 	blob1 = bloblist_add(TEST_TAG, small_size, 0);
 	ut_assertnonnull(blob1);
 
@@ -555,7 +559,7 @@ static int bloblist_test_resize_last(struct unit_test_state *uts)
 	hdr = ptr;
 
 	/* Create two blobs */
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
 	blob1 = bloblist_add(TEST_TAG, small_size, 0);
 	ut_assertnonnull(blob1);
 
@@ -600,7 +604,7 @@ static int bloblist_test_blob_maxsize(struct unit_test_state *uts)
 
 	/* At the start there should be no records */
 	clear_bloblist();
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
 
 	/* Add a blob that takes up all space */
 	size = TEST_BLOBLIST_SIZE - sizeof(struct bloblist_hdr) -
-- 
2.25.1

