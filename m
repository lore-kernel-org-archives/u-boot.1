Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E74C47074
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:43:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C42187B71;
	Fri, 29 Dec 2023 18:43:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wjanVyeE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED0FD87B72; Fri, 29 Dec 2023 18:43:17 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35F1987B81
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:43:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7811d1e68b0so578812485a.2
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 09:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703871793; x=1704476593; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sd96k6ark+ZOnWcWVUctdRBBIyxpO3qgRekHBQ+IF2A=;
 b=wjanVyeEYNoqBHyYe/bNZ4t3OVh9rh/uuhtoS0luJ2pK/cj3UPNeQt+wkju9+cHPdG
 KrXW98owtLve7wu2E2eBqpk9XcJ8cOLOyr+Kse7c5D3Odz4sn3KgsNf8JS4BUz1t+0lr
 o+5vs5J0397Fhtt+SgOlv4zMzHuWbubScaAf1E4lupssw75SAMdbb0PCvwl8Wb/WwdQH
 //r5BDtcvhodqlU5x9E94qVsabnsqgib8iuiTrH7VbigfuFOgdVFTV4NeOBPrFph/bPL
 j/kD0x5lJZ1uZZzXx0i7OTFsiVrUJzni2QzTk1x+ev6fbnC5Fy0R238DPSQyR4BUXZGr
 gCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703871793; x=1704476593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sd96k6ark+ZOnWcWVUctdRBBIyxpO3qgRekHBQ+IF2A=;
 b=M+L/XETANjjIzzNxiWUrNMaiHfS5QhX0dE2cV+t57uddR8dDaFHgGyZ+27AKzk73Eu
 tV0toTezTIa/KsgzzWfJ4e4xgMpQRXDToUIOFO+sdJVXA7ikcy2SLDAD/3iBgVJItkJ4
 hCxO24z/k7pFeB+LQmMndTooL9tU3+Fi/C3ixl4TDeKHLksjx8lDJOqiqP3E1wZ/YOXd
 oHo50g/o0ToCbns9o0Cpx4LDrx5a9ZLjfEwoBH20/hH7LE89H1OAqqIveAqB1AvoLovu
 pcYO/GqpgWlLBCp3qmWweMpGfoxdX/C5kttu+TUmNRAvfHKNnXNLlV37qEtPMThD28hl
 /nRg==
X-Gm-Message-State: AOJu0Yz6JQI9GNHw3HS5SF43GRQWqhjBMKwU1cv2wu9RYn2qdgftn/Rh
 ykutqOMxfRwQ2FOdsWC9FxmgMuAKp1b1MHGknOkMXqB8Lsk=
X-Google-Smtp-Source: AGHT+IG8IhuIPn/3+OotVrBhm9Mvox9yqYnTTuXFGdWgqijKpR//Kczkwadj3XobzeSApaU+5JY/Pg==
X-Received: by 2002:a05:620a:3954:b0:77f:8ded:9612 with SMTP id
 qs20-20020a05620a395400b0077f8ded9612mr15331192qkn.142.1703871793603; 
 Fri, 29 Dec 2023 09:43:13 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a05620a122b00b007817084e7basm1545849qkj.99.2023.12.29.09.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 09:43:13 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v5 02/11] bloblist: Adjust API to align in powers of 2
Date: Fri, 29 Dec 2023 09:42:34 -0800
Message-Id: <20231229174244.892818-3-raymond.mao@linaro.org>
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

The updated bloblist structure stores the alignment as a power-of-two
value in its structures. Adjust the API to use this, to avoid needing to
calling ilog2().
Update the bloblist alignment from 16 bytes to 8 bytes.
Drop a stale comment while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2
- Update the bloblist alignment to align to FW handoff spec v0.9.
Changes in v4
- Update the commit message.

 arch/x86/lib/tables.c |  3 ++-
 common/bloblist.c     | 24 +++++++++++-------------
 include/bloblist.h    | 12 +++++++-----
 test/bloblist.c       |  4 ++--
 4 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/arch/x86/lib/tables.c b/arch/x86/lib/tables.c
index 5b5070f7ca..d43e77d373 100644
--- a/arch/x86/lib/tables.c
+++ b/arch/x86/lib/tables.c
@@ -16,6 +16,7 @@
 #include <asm/mpspec.h>
 #include <asm/tables.h>
 #include <asm/coreboot_tables.h>
+#include <linux/log2.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -104,7 +105,7 @@ int write_tables(void)
 			if (!gd->arch.table_end)
 				gd->arch.table_end = rom_addr;
 			rom_addr = (ulong)bloblist_add(table->tag, size,
-						       table->align);
+						       ilog2(table->align));
 			if (!rom_addr)
 				return log_msg_ret("bloblist", -ENOBUFS);
 
diff --git a/common/bloblist.c b/common/bloblist.c
index 5606487f5b..1e78a3d4b3 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -26,8 +26,6 @@
  * start address of the data in each blob is aligned as required. Note that
  * each blob's *data* is aligned to BLOBLIST_ALIGN regardless of the alignment
  * of the bloblist itself or the blob header.
- *
- * So far, only BLOBLIST_ALIGN alignment is supported.
  */
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -128,24 +126,24 @@ static struct bloblist_rec *bloblist_findrec(uint tag)
 	return NULL;
 }
 
-static int bloblist_addrec(uint tag, int size, int align,
+static int bloblist_addrec(uint tag, int size, int align_log2,
 			   struct bloblist_rec **recp)
 {
 	struct bloblist_hdr *hdr = gd->bloblist;
 	struct bloblist_rec *rec;
 	int data_start, new_alloced;
 
-	if (!align)
-		align = BLOBLIST_ALIGN;
+	if (!align_log2)
+		align_log2 = BLOBLIST_ALIGN_LOG2;
 
 	/* Figure out where the new data will start */
 	data_start = map_to_sysmem(hdr) + hdr->alloced + sizeof(*rec);
 
 	/* Align the address and then calculate the offset from ->alloced */
-	data_start = ALIGN(data_start, align) - map_to_sysmem(hdr);
+	data_start = ALIGN(data_start, 1U << align_log2) - map_to_sysmem(hdr);
 
 	/* Calculate the new allocated total */
-	new_alloced = data_start + ALIGN(size, align);
+	new_alloced = data_start + ALIGN(size, 1U << align_log2);
 
 	if (new_alloced > hdr->size) {
 		log_err("Failed to allocate %x bytes size=%x, need size=%x\n",
@@ -169,7 +167,7 @@ static int bloblist_addrec(uint tag, int size, int align,
 }
 
 static int bloblist_ensurerec(uint tag, struct bloblist_rec **recp, int size,
-			      int align)
+			      int align_log2)
 {
 	struct bloblist_rec *rec;
 
@@ -182,7 +180,7 @@ static int bloblist_ensurerec(uint tag, struct bloblist_rec **recp, int size,
 	} else {
 		int ret;
 
-		ret = bloblist_addrec(tag, size, align, &rec);
+		ret = bloblist_addrec(tag, size, align_log2, &rec);
 		if (ret)
 			return ret;
 	}
@@ -204,22 +202,22 @@ void *bloblist_find(uint tag, int size)
 	return (void *)rec + rec->hdr_size;
 }
 
-void *bloblist_add(uint tag, int size, int align)
+void *bloblist_add(uint tag, int size, int align_log2)
 {
 	struct bloblist_rec *rec;
 
-	if (bloblist_addrec(tag, size, align, &rec))
+	if (bloblist_addrec(tag, size, align_log2, &rec))
 		return NULL;
 
 	return (void *)rec + rec->hdr_size;
 }
 
-int bloblist_ensure_size(uint tag, int size, int align, void **blobp)
+int bloblist_ensure_size(uint tag, int size, int align_log2, void **blobp)
 {
 	struct bloblist_rec *rec;
 	int ret;
 
-	ret = bloblist_ensurerec(tag, &rec, size, align);
+	ret = bloblist_ensurerec(tag, &rec, size, align_log2);
 	if (ret)
 		return ret;
 	*blobp = (void *)rec + rec->hdr_size;
diff --git a/include/bloblist.h b/include/bloblist.h
index 92dbfda21b..5ad1337d1f 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -76,7 +76,9 @@
 enum {
 	BLOBLIST_VERSION	= 0,
 	BLOBLIST_MAGIC		= 0xb00757a3,
-	BLOBLIST_ALIGN		= 16,
+
+	BLOBLIST_ALIGN_LOG2	= 3,
+	BLOBLIST_ALIGN		= 1 << BLOBLIST_ALIGN_LOG2,
 };
 
 /* Supported tags - add new ones to tag_name in bloblist.c */
@@ -254,11 +256,11 @@ void *bloblist_find(uint tag, int size);
  *
  * @tag:	Tag to add (enum bloblist_tag_t)
  * @size:	Size of the blob
- * @align:	Alignment of the blob (in bytes), 0 for default
+ * @align_log2:	Alignment of the blob (in bytes log2), 0 for default
  * Return: pointer to the newly added block, or NULL if there is not enough
  * space for the blob
  */
-void *bloblist_add(uint tag, int size, int align);
+void *bloblist_add(uint tag, int size, int align_log2);
 
 /**
  * bloblist_ensure_size() - Find or add a blob
@@ -268,11 +270,11 @@ void *bloblist_add(uint tag, int size, int align);
  * @tag:	Tag to add (enum bloblist_tag_t)
  * @size:	Size of the blob
  * @blobp:	Returns a pointer to blob on success
- * @align:	Alignment of the blob (in bytes), 0 for default
+ * @align_log2:	Alignment of the blob (in bytes log2), 0 for default
  * Return: 0 if OK, -ENOSPC if it is missing and could not be added due to lack
  * of space, or -ESPIPE it exists but has the wrong size
  */
-int bloblist_ensure_size(uint tag, int size, int align, void **blobp);
+int bloblist_ensure_size(uint tag, int size, int align_log2, void **blobp);
 
 /**
  * bloblist_ensure() - Find or add a blob
diff --git a/test/bloblist.c b/test/bloblist.c
index efa1e32afd..8b435e27ca 100644
--- a/test/bloblist.c
+++ b/test/bloblist.c
@@ -336,7 +336,7 @@ static int bloblist_test_align(struct unit_test_state *uts)
 
 	/* Check larger alignment */
 	for (i = 0; i < 3; i++) {
-		int align = 32 << i;
+		int align = 5 - i;
 
 		data = bloblist_add(3 + i, i * 4, align);
 		ut_assertnonnull(data);
@@ -351,7 +351,7 @@ static int bloblist_test_align(struct unit_test_state *uts)
 	ut_assertok(bloblist_new(TEST_ADDR + BLOBLIST_ALIGN, TEST_BLOBLIST_SIZE,
 				 0));
 
-	data = bloblist_add(1, 5, BLOBLIST_ALIGN * 2);
+	data = bloblist_add(1, 5, BLOBLIST_ALIGN_LOG2 + 1);
 	ut_assertnonnull(data);
 	addr = map_to_sysmem(data);
 	ut_asserteq(0, addr & (BLOBLIST_ALIGN * 2 - 1));
-- 
2.25.1

