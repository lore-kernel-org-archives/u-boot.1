Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21C2C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 21:09:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5196487954;
	Wed, 27 Dec 2023 22:08:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uFy8C/6C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32DAA87945; Wed, 27 Dec 2023 22:08:29 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4843879ED
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 22:08:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-781251ed685so431747785a.3
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 13:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703711305; x=1704316105; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mylyLqyoePTFIEEsSRrVGIWz1oVpKKYbIFZS6I6RS1Q=;
 b=uFy8C/6CSL1ZaBW8xLCu0kbR+xNwJ76/N8dCcWZUK6uPMLGhb4WpVG0tpeMr2kCUcU
 nz6+WvDoO/OLvLsJZv7rQAp7uHVeUvxOSMMos89jKA3m8e+kyrob6GbHa+eqD1iGjm5w
 XLRJsU42S8TMdQJxYKRylpo6dx7HowTduN845IAEc2lid7XrmZsPvNJGDPQQ+VEF5zp7
 WEqfVsK5z0TVfkMnGLpUsW0E6uA9SDCcrJ2xgK6OMyEQfPZr4QehmhiBthLqIfkRNdqy
 eueaCXtY68gz+zq2MeqUgcizEJTvxqip8acovV+HbNrlF5r5lUTHjsAfXZx9tbW6pCaS
 EChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703711305; x=1704316105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mylyLqyoePTFIEEsSRrVGIWz1oVpKKYbIFZS6I6RS1Q=;
 b=ZdGF/RnQJuTmOvPvUjZllsPpRLwxu8olXLgpb28r/6JRua5vfqCGoPpWD5FVgZITFA
 1U0Jd9AokkjJ+waBJ49hidrbeNdXERfuEPZ6zSGTCwrllEEmcqpnH16sq7ctDhr8JtEK
 WigNoauzpVqTJWnkwr3AabIRaa4CUVME9+BWjIVEbNxy60K9ehXeYlxP+nnLZzvCgHqB
 V/nZLw5P4wzq0sEC4oeK2bb2FzuyeWs0Kc8zyDSdgvqHVpcEfc7VfiGjTxbE1v9ZPYwl
 +zXgk3pDfvUTjEYd3nC4eaSrQuWFIG0zBuQ4RI04FVaOPthlJbG0LsH8xOW3dryC/FRx
 2W9w==
X-Gm-Message-State: AOJu0YwtE9ZNliAog53DNXUlQeNtEo+1lh3LW4jYDohdDCzSkZKJt9Vx
 rTw7e/7AKQU0xRg+M4Zx4m3qnix2112sZIXnTltFfvpXI5U=
X-Google-Smtp-Source: AGHT+IGcLLxnqLkXMruI2r0g2M9Z94BVWWsbX4B9yPM3LRps40ZIDIM57ZYBOWfWZDGyjUuPrSAyLw==
X-Received: by 2002:a05:620a:44c1:b0:781:7440:16b2 with SMTP id
 y1-20020a05620a44c100b00781744016b2mr19851qkp.102.1703711305327; 
 Wed, 27 Dec 2023 13:08:25 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 c27-20020a05620a11bb00b0078161897afcsm637107qkk.109.2023.12.27.13.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 13:08:25 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v4 11/12] bloblist: Add alignment to bloblist_new()
Date: Wed, 27 Dec 2023 13:07:09 -0800
Message-Id: <20231227210712.712937-12-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231227210712.712937-1-raymond.mao@linaro.org>
References: <20231227210712.712937-1-raymond.mao@linaro.org>
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
index 6e019087ff..2d373910b6 100644
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

