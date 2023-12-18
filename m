Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65306C46CA2
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 18:21:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80F3C8765E;
	Mon, 18 Dec 2023 19:20:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ul34CFE2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 747F38765E; Mon, 18 Dec 2023 19:20:31 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0494087509
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 19:20:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-42588e94019so35367191cf.0
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 10:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702923627; x=1703528427; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZBfjHWENQCjh6sm/CoLeelAQTAXKsmE2laL1wzYv2S4=;
 b=Ul34CFE2W9Hg9B7tj4HgaH82AXkdgc3UUnfZCToyazOJTR/6I1B9voU98h3rKHV4VO
 EYYJDF580pZ6Cyh+IQd0oku8IpQDgiGvwMScOFJvWqCN1N9DHXEV+WHcD35jAX4KVANz
 L526152pULGpR9RMS8I4vmhh+iWLj1Aj3Hf98lB8zCDmdfuU2eoSuLH4ecSouAOwvBpO
 6VlJbmtRxrL+NPO/paM6NGy2E/V4wK6jlrp99v8BIWy/8xbPeDFa4rT3VZtkzwyJExpP
 aY3SrZvsNMQ1akX9x4GyfLQeQ9OWgzetkyl0hcDfI2Hy92kLsFnNVaD2oR0X5ETLdXhN
 myBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702923627; x=1703528427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZBfjHWENQCjh6sm/CoLeelAQTAXKsmE2laL1wzYv2S4=;
 b=IHYFP9cX/s6jkROYMNPnTdOGPfI0CbTNiCJqvKl2BcqiSYArX3CVp2gGQmMRw3VWJI
 mupBRca9cerJY3HsDS9jd7Ua27jKxgWvbxYRHcAplxC6AyCvm9k8JxdtYuZY1kYi/7pX
 ZM7fQgKUZmn7x8KzBA6rrlaJmrH0c8sYwyzMKuOn+597hUld8/bPkhDmUIPFBy4q6iJH
 c4PpVmU/sg3VForO3E5g+2M/uH1db8r4/hv3pf0Vo4C/x/WsDC/qiXkYaokFn2bI8TN0
 EiW3HqYsr3kMoFf5uVTor3f4ZOoGVM0QjUGz2DEmpwpjS9aYWjcKtDZU5/C5Z5pKRQOg
 rvvA==
X-Gm-Message-State: AOJu0Yyp5i2rb2jF91DpA2J6abn6dgvNfhW1uNx2BR87vLVASnZhUW5F
 3WW/HLB69Ik8hVs0tpo/xvJrwflQx+xNphbQNUo=
X-Google-Smtp-Source: AGHT+IH/8i9vkN8n0dq8PM6tRirS+TUnTYQ2REt3EdhjS2yLtfYBVRO7TBNEvNL9z0+8Sc3ERAzuMA==
X-Received: by 2002:a05:6214:238d:b0:67f:268f:ecac with SMTP id
 fw13-20020a056214238d00b0067f268fecacmr5557102qvb.18.1702923627183; 
 Mon, 18 Dec 2023 10:20:27 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 dy7-20020ad44e87000000b0067f213933bdsm3046136qvb.2.2023.12.18.10.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 10:20:26 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v3 12/14] bloblist: Add alignment to bloblist_new()
Date: Mon, 18 Dec 2023 10:18:57 -0800
Message-Id: <20231218181901.337515-13-raymond.mao@linaro.org>
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

From: Simon Glass <sjg@chromium.org>

Allow the alignment to be specified when creating a bloblist.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v3
- Keep the flag argument to align to FW handoff spec up to commit 3592349.

 common/bloblist.c  |  5 +++--
 include/bloblist.h |  3 ++-
 test/bloblist.c    | 40 ++++++++++++++++++++++------------------
 3 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 1c97d61e4a..6d079c58f7 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -349,7 +349,7 @@ static u32 bloblist_calc_chksum(struct bloblist_hdr *hdr)
 	return chksum;
 }
 
-int bloblist_new(ulong addr, uint size, uint flags)
+int bloblist_new(ulong addr, uint size, uint flags, uint align_log2)
 {
 	struct bloblist_hdr *hdr;
 
@@ -365,6 +365,7 @@ int bloblist_new(ulong addr, uint size, uint flags)
 	hdr->magic = BLOBLIST_MAGIC;
 	hdr->size = size;
 	hdr->alloced = hdr->hdr_size;
+	hdr->align_log2 = align_log2 ?: BLOBLIST_BLOB_ALIGN_LOG2;
 	hdr->chksum = 0;
 	gd->bloblist = hdr;
 
@@ -508,7 +509,7 @@ int bloblist_init(void)
 		}
 		log_debug("Creating new bloblist size %lx at %lx\n", size,
 			  addr);
-		ret = bloblist_new(addr, size, 0);
+		ret = bloblist_new(addr, size, 0, 0);
 	} else {
 		log_debug("Found existing bloblist size %lx at %lx\n", size,
 			  addr);
diff --git a/include/bloblist.h b/include/bloblist.h
index 5dba630adb..8f0286fda7 100644
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
index a083259d0c..29abd46862 100644
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
 	ut_asserteq(TEST_BLOBLIST_SIZE, bloblist_get_size());
 	ut_asserteq(TEST_ADDR, bloblist_get_base());
 	ut_asserteq(map_to_sysmem(hdr), TEST_ADDR);
@@ -144,7 +144,7 @@ static int bloblist_test_blob_ensure(struct unit_test_state *uts)
 
 	/* At the start there should be no records */
 	clear_bloblist();
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
 
 	/* Test with an empty bloblist */
 	size = TEST_SIZE;
@@ -176,7 +176,7 @@ static int bloblist_test_bad_blob(struct unit_test_state *uts)
 	void *data;
 
 	hdr = clear_bloblist();
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
 	data = hdr + 1;
 	data += sizeof(struct bloblist_rec);
 	ut_asserteq_addr(data, bloblist_ensure(TEST_TAG, TEST_SIZE));
@@ -192,7 +192,7 @@ static int bloblist_test_checksum(struct unit_test_state *uts)
 	char *data, *data2;
 
 	hdr = clear_bloblist();
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
 	ut_assertok(bloblist_finish());
 	ut_assertok(bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
 
@@ -217,6 +217,10 @@ static int bloblist_test_checksum(struct unit_test_state *uts)
 	ut_asserteq(-EIO, bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
 	hdr->chksum--;
 
+	hdr->align_log2++;
+	ut_asserteq(-EIO, bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
+	hdr->align_log2--;
+
 	/* Make sure the checksum changes when we add blobs */
 	data = bloblist_add(TEST_TAG, TEST_SIZE, 0);
 	ut_asserteq(-EIO, bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
@@ -262,7 +266,7 @@ static int bloblist_test_cmd_info(struct unit_test_state *uts)
 	char *data, *data2;
 
 	hdr = clear_bloblist();
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
 	data = bloblist_ensure(TEST_TAG, TEST_SIZE);
 	data2 = bloblist_ensure(TEST_TAG2, TEST_SIZE2);
 
@@ -288,7 +292,7 @@ static int bloblist_test_cmd_list(struct unit_test_state *uts)
 	char *data, *data2;
 
 	hdr = clear_bloblist();
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
 	data = bloblist_ensure(TEST_TAG, TEST_SIZE);
 	data2 = bloblist_ensure(TEST_TAG2, TEST_SIZE2);
 
@@ -318,7 +322,7 @@ static int bloblist_test_align(struct unit_test_state *uts)
 
 	/* At the start there should be no records */
 	hdr = clear_bloblist();
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
 	ut_assertnull(bloblist_find(TEST_TAG, TEST_BLOBLIST_SIZE));
 
 	/* Check the default alignment */
@@ -355,7 +359,7 @@ static int bloblist_test_align(struct unit_test_state *uts)
 	memset(hdr, ERASE_BYTE, TEST_BLOBLIST_SIZE);
 	memset(hdr, '\0', sizeof(*hdr));
 	ut_assertok(bloblist_new(TEST_ADDR + BLOBLIST_ALIGN, TEST_BLOBLIST_SIZE,
-				 0));
+				 0, 0));
 
 	data = bloblist_add(1, 5, BLOBLIST_ALIGN_LOG2 + 1);
 	ut_assertnonnull(data);
@@ -376,7 +380,7 @@ static int bloblist_test_reloc(struct unit_test_state *uts)
 	ulong new_addr;
 	ulong new_size;
 
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
 	old_ptr = map_sysmem(TEST_ADDR, TEST_BLOBLIST_SIZE);
 
 	/* Add one blob and then one that won't fit */
@@ -415,7 +419,7 @@ static int bloblist_test_grow(struct unit_test_state *uts)
 	memset(hdr, ERASE_BYTE, TEST_BLOBLIST_SIZE);
 
 	/* Create two blobs */
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
 	blob1 = bloblist_add(TEST_TAG, small_size, 0);
 	ut_assertnonnull(blob1);
 	ut_assertok(check_zero(blob1, small_size));
@@ -467,7 +471,7 @@ static int bloblist_test_shrink(struct unit_test_state *uts)
 	ptr = map_sysmem(TEST_ADDR, TEST_BLOBLIST_SIZE);
 
 	/* Create two blobs */
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
 	blob1 = bloblist_add(TEST_TAG, small_size, 0);
 	ut_assertnonnull(blob1);
 	strcpy(blob1, test1_str);
@@ -517,7 +521,7 @@ static int bloblist_test_resize_fail(struct unit_test_state *uts)
 	ptr = map_sysmem(TEST_ADDR, TEST_BLOBLIST_SIZE);
 
 	/* Create two blobs */
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
 	blob1 = bloblist_add(TEST_TAG, small_size, 0);
 	ut_assertnonnull(blob1);
 
@@ -554,7 +558,7 @@ static int bloblist_test_resize_last(struct unit_test_state *uts)
 	hdr = ptr;
 
 	/* Create two blobs */
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
 	blob1 = bloblist_add(TEST_TAG, small_size, 0);
 	ut_assertnonnull(blob1);
 
@@ -599,7 +603,7 @@ static int bloblist_test_blob_maxsize(struct unit_test_state *uts)
 
 	/* At the start there should be no records */
 	clear_bloblist();
-	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
 
 	/* Add a blob that takes up all space */
 	size = TEST_BLOBLIST_SIZE - sizeof(struct bloblist_hdr) -
-- 
2.25.1

