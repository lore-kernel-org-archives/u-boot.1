Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49802C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 19:55:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2500877FC;
	Mon, 27 Nov 2023 20:53:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RWy3pul3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BE9587809; Mon, 27 Nov 2023 20:53:16 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ADFA877FA
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 20:53:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-67a338dfca7so13241376d6.2
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 11:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701114791; x=1701719591; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7tJjNDzcWGLynwYkM18zbP4X43jvSi9v9HyRT58nBho=;
 b=RWy3pul3cMR4f1608rtuasQIDnhhI4w0UkUS3S8Jaw6vl9N1zXdw6rYoyyojEVPr6u
 PVxqWuWNS938QpZpQZNDUTCzkvS7YPPIiJ+PaAMQXX7Gylf1aCG7jiakeXIbPaj3LFSa
 bTJRNfUkMMIacqTm0Fu2RTIbB3nU/pvpvyTOXDifK6c6r9IQOZMG0TGpiTopZFRq31aq
 utuTJEqpkx4EunVDlHT/thTD3DOIXdffHGB/RkRoHw2f7FzfkwOecgVYi7plCqjuqZmr
 miFIBy8LjE/HFou3bp2uhx22TlYJGpZRkDAWo5A3NygNVxwl+RKH3KTnvfJXFMtte2ui
 8ZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701114791; x=1701719591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7tJjNDzcWGLynwYkM18zbP4X43jvSi9v9HyRT58nBho=;
 b=M+GFjpdgkygtA8qa7nTrs/WsaAMjXpo3NyAnW3Z59+t5eIgYf74C91DHcAm3Q+QYCc
 qsC10TgBtLHmSmWUnwR+msc4uzyrsfLnBMgJ89Iq7vl+1ZJ5t192fP09KmqRSvO1zXEy
 EckiBAcAVryOT9Gk8IVqXoF2bSi4LJYSU+aU3wvL6+/FdXqwtRdHFwK3kP7HZrSOMCTQ
 vzLsEoh7ry4mxSjXHCEEvZBAErusf+SlZ2vTC3uzgSZNZcUDT0T6ByOYCGAKTCs1DUQL
 TBm87bjXbw1uDHb7xB9WgpMavhG+IX+miWAKvAnqrJ9Rz4hm+OpOqcGggxb02WgU0A8h
 urfg==
X-Gm-Message-State: AOJu0YzrVEG8hCCk6bQ1++aQ073B8BnoyJWcIvXoz6WDDN6OLRYrZPxs
 JHUIRBdPHXLWECrduMxUTFNiwEuJ5JhMgLnpBVE=
X-Google-Smtp-Source: AGHT+IHHngV5AGBe0cT9SUgBYgY2XY5Pk3OW7c6b990RwLrG1KLJkfCahQqiDjSjMFVWhs5tGhkqQA==
X-Received: by 2002:a05:6214:184f:b0:67a:2659:e639 with SMTP id
 d15-20020a056214184f00b0067a2659e639mr8007028qvy.48.1701114791040; 
 Mon, 27 Nov 2023 11:53:11 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 g6-20020ad45106000000b0067a2061fc21sm3087047qvp.101.2023.11.27.11.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 11:53:10 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de,
	ilias.apalodimas@linaro.org,
	sjg@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Nikhil M Jain <n-jain1@ti.com>,
 Baruch Siach <baruch@tkos.co.il>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>,
 Qu Wenruo <wqu@suse.com>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 13/18] bloblist: Add alignment to bloblist_new()
Date: Mon, 27 Nov 2023 11:50:24 -0800
Message-Id: <20231127195029.90951-14-raymond.mao@linaro.org>
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

Allow the alignment to be specified when creating a bloblist.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 common/bloblist.c  |  5 +++--
 include/bloblist.h |  3 ++-
 test/bloblist.c    | 40 ++++++++++++++++++++++------------------
 3 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 55a7e1f591..0d482ecd71 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -341,7 +341,7 @@ static u32 bloblist_calc_chksum(struct bloblist_hdr *hdr)
 	return chksum;
 }
 
-int bloblist_new(ulong addr, uint size)
+int bloblist_new(ulong addr, uint size, uint align_log2)
 {
 	struct bloblist_hdr *hdr;
 
@@ -356,6 +356,7 @@ int bloblist_new(ulong addr, uint size)
 	hdr->magic = BLOBLIST_MAGIC;
 	hdr->size = size;
 	hdr->alloced = hdr->hdr_size;
+	hdr->align_log2 = align_log2 ?: BLOBLIST_BLOB_ALIGN_LOG2;
 	hdr->chksum = 0;
 	gd->bloblist = hdr;
 
@@ -499,7 +500,7 @@ int bloblist_init(void)
 		}
 		log_debug("Creating new bloblist size %lx at %lx\n", size,
 			  addr);
-		ret = bloblist_new(addr, size);
+		ret = bloblist_new(addr, size, 0);
 	} else {
 		log_debug("Found existing bloblist size %lx at %lx\n", size,
 			  addr);
diff --git a/include/bloblist.h b/include/bloblist.h
index 57625ea004..c419c0d923 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -324,10 +324,11 @@ int bloblist_resize(uint tag, int new_size);
  *
  * @addr: Address of bloblist
  * @size: Initial size for bloblist
+ * @align_log2: Log base 2 of maximum alignment provided by this bloblist
  * Return: 0 if OK, -EFAULT if addr is not aligned correctly, -ENOSPC is the
  * area is not large enough
  */
-int bloblist_new(ulong addr, uint size);
+int bloblist_new(ulong addr, uint size, uint align_log2);
 
 /**
  * bloblist_check() - Check if a bloblist exists
diff --git a/test/bloblist.c b/test/bloblist.c
index be237c6155..b72603ba9a 100644
--- a/test/bloblist.c
+++ b/test/bloblist.c
@@ -72,15 +72,15 @@ static int bloblist_test_init(struct unit_test_state *uts)
 	hdr = clear_bloblist();
 	ut_asserteq(-ENOENT, bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
 	ut_asserteq_ptr(NULL, bloblist_check_magic(TEST_ADDR));
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
 	ut_asserteq_ptr(hdr, bloblist_check_magic(TEST_ADDR));
 	hdr->version++;
 	ut_asserteq(-EPROTONOSUPPORT, bloblist_check(TEST_ADDR,
 						     TEST_BLOBLIST_SIZE));
 
-	ut_asserteq(-ENOSPC, bloblist_new(TEST_ADDR, 0xc));
-	ut_asserteq(-EFAULT, bloblist_new(1, TEST_BLOBLIST_SIZE));
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE));
+	ut_asserteq(-ENOSPC, bloblist_new(TEST_ADDR, 0xc, 0));
+	ut_asserteq(-EFAULT, bloblist_new(1, TEST_BLOBLIST_SIZE, 0));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
 
 	ut_asserteq(-EIO, bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
 	ut_assertok(bloblist_finish());
@@ -103,7 +103,7 @@ static int bloblist_test_blob(struct unit_test_state *uts)
 	/* At the start there should be no records */
 	hdr = clear_bloblist();
 	ut_assertnull(bloblist_find(TEST_TAG, TEST_BLOBLIST_SIZE));
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
 	ut_asserteq(TEST_BLOBLIST_SIZE, bloblist_get_size());
 	ut_asserteq(TEST_ADDR, bloblist_get_base());
 	ut_asserteq(map_to_sysmem(hdr), TEST_ADDR);
@@ -141,7 +141,7 @@ static int bloblist_test_blob_ensure(struct unit_test_state *uts)
 
 	/* At the start there should be no records */
 	clear_bloblist();
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
 
 	/* Test with an empty bloblist */
 	size = TEST_SIZE;
@@ -173,7 +173,7 @@ static int bloblist_test_bad_blob(struct unit_test_state *uts)
 	void *data;
 
 	hdr = clear_bloblist();
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
 	data = hdr + 1;
 	data += sizeof(struct bloblist_rec);
 	ut_asserteq_addr(data, bloblist_ensure(TEST_TAG, TEST_SIZE));
@@ -189,7 +189,7 @@ static int bloblist_test_checksum(struct unit_test_state *uts)
 	char *data, *data2;
 
 	hdr = clear_bloblist();
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
 	ut_assertok(bloblist_finish());
 	ut_assertok(bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
 
@@ -206,6 +206,10 @@ static int bloblist_test_checksum(struct unit_test_state *uts)
 	ut_asserteq(-EIO, bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
 	hdr->chksum--;
 
+	hdr->align_log2++;
+	ut_asserteq(-EIO, bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
+	hdr->align_log2--;
+
 	/* Make sure the checksum changes when we add blobs */
 	data = bloblist_add(TEST_TAG, TEST_SIZE, 0);
 	ut_asserteq(-EIO, bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
@@ -251,7 +255,7 @@ static int bloblist_test_cmd_info(struct unit_test_state *uts)
 	char *data, *data2;
 
 	hdr = clear_bloblist();
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
 	data = bloblist_ensure(TEST_TAG, TEST_SIZE);
 	data2 = bloblist_ensure(TEST_TAG2, TEST_SIZE2);
 
@@ -277,7 +281,7 @@ static int bloblist_test_cmd_list(struct unit_test_state *uts)
 	char *data, *data2;
 
 	hdr = clear_bloblist();
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
 	data = bloblist_ensure(TEST_TAG, TEST_SIZE);
 	data2 = bloblist_ensure(TEST_TAG2, TEST_SIZE2);
 
@@ -307,7 +311,7 @@ static int bloblist_test_align(struct unit_test_state *uts)
 
 	/* At the start there should be no records */
 	hdr = clear_bloblist();
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
 	ut_assertnull(bloblist_find(TEST_TAG, TEST_BLOBLIST_SIZE));
 
 	/* Check the default alignment */
@@ -344,7 +348,7 @@ static int bloblist_test_align(struct unit_test_state *uts)
 	memset(hdr, ERASE_BYTE, TEST_BLOBLIST_SIZE);
 	memset(hdr, '\0', sizeof(*hdr));
 	ut_assertok(bloblist_new(TEST_ADDR + BLOBLIST_ALIGN,
-				 TEST_BLOBLIST_SIZE));
+				 TEST_BLOBLIST_SIZE, 0));
 
 	data = bloblist_add(1, 5, BLOBLIST_ALIGN_LOG2 + 1);
 	ut_assertnonnull(data);
@@ -365,7 +369,7 @@ static int bloblist_test_reloc(struct unit_test_state *uts)
 	ulong new_addr;
 	ulong new_size;
 
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
 	old_ptr = map_sysmem(TEST_ADDR, TEST_BLOBLIST_SIZE);
 
 	/* Add one blob and then one that won't fit */
@@ -404,7 +408,7 @@ static int bloblist_test_grow(struct unit_test_state *uts)
 	memset(hdr, ERASE_BYTE, TEST_BLOBLIST_SIZE);
 
 	/* Create two blobs */
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
 	blob1 = bloblist_add(TEST_TAG, small_size, 0);
 	ut_assertnonnull(blob1);
 	ut_assertok(check_zero(blob1, small_size));
@@ -456,7 +460,7 @@ static int bloblist_test_shrink(struct unit_test_state *uts)
 	ptr = map_sysmem(TEST_ADDR, TEST_BLOBLIST_SIZE);
 
 	/* Create two blobs */
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
 	blob1 = bloblist_add(TEST_TAG, small_size, 0);
 	ut_assertnonnull(blob1);
 	strcpy(blob1, test1_str);
@@ -506,7 +510,7 @@ static int bloblist_test_resize_fail(struct unit_test_state *uts)
 	ptr = map_sysmem(TEST_ADDR, TEST_BLOBLIST_SIZE);
 
 	/* Create two blobs */
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
 	blob1 = bloblist_add(TEST_TAG, small_size, 0);
 	ut_assertnonnull(blob1);
 
@@ -543,7 +547,7 @@ static int bloblist_test_resize_last(struct unit_test_state *uts)
 	hdr = ptr;
 
 	/* Create two blobs */
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
 	blob1 = bloblist_add(TEST_TAG, small_size, 0);
 	ut_assertnonnull(blob1);
 
@@ -588,7 +592,7 @@ static int bloblist_test_blob_maxsize(struct unit_test_state *uts)
 
 	/* At the start there should be no records */
 	clear_bloblist();
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
 
 	/* Add a blob that takes up all space */
 	size = TEST_BLOBLIST_SIZE - sizeof(struct bloblist_hdr) -
-- 
2.25.1

