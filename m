Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD27C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 19:52:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 265E7875EB;
	Mon, 27 Nov 2023 20:52:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cV46uQwc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48F95877BB; Mon, 27 Nov 2023 20:52:17 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D6688761B
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 20:52:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-58d5979c676so1266262eaf.1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 11:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701114732; x=1701719532; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jsEGZm7qJYtL3ZT2qXO6CTb0/AVYsFjRVATxpvua7r4=;
 b=cV46uQwcktR3x1nlYsLw50OuK91nTNRQKz7sfAm3JdcN7CzJU6TfCDQ9Pobdq+PJ/R
 Yvfxp7mT2JqM0yxMaraaz0qbbLBUKb7GYD0znfUqBNX9DQlufexFR03tkm2jojForlMX
 6kVXcOYcDNmBNVIdKZwLpFyIRZ2O7k2wlrZU9ho2woNJQNWP3RqE3wp2K8OVa1WMVOz+
 YnLpHAQKgWi0sB7ZUaZnn3ZzjrpKSV+DJjMhn3NMqkTuo4Yg1V/RR2Y0i7pUYGGVN7p8
 Q3vVB3Z//4pOx8Vf4LHaSIC087stLIhjKHWHSry8yjGArpWlvRAvyRFnhBLnR4bTDksr
 yyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701114732; x=1701719532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jsEGZm7qJYtL3ZT2qXO6CTb0/AVYsFjRVATxpvua7r4=;
 b=hsfbo99oCAD6XsTfyOBBi+cek4S74VAl+u6z2Uz6YN+2purUgZtj93UToHz1PQ0Gbf
 WwI7cNRCTjiW+1hFuK69i0PaIswWYzf5TQMMz7IbXb0gHDfQPwhzwKWC/sPeSpb3+5Qo
 pIr7tc+LZjWgshargfgHwrfR7L7qYE4i6jmVf36DJT13ZG4sTFbuh7WhjXuHjrGTqJjQ
 b1YIu5vimdAEyFsMj2GdW4BiEw8LknlhTp0Mfu5yb64nbY30F4iarHkHpwF/mfZNUWxZ
 c5eAgtk0OHPo5VGP32BCjfpX9sVNX2Gu35uQh+NgViTVgs/M+XwJ6IiQkbSxjvDBTjk5
 wW6Q==
X-Gm-Message-State: AOJu0YyLwQhy2MYr5cpe0CBybzBc0G3jnGmjCHh1oe1ybTVgYzXzffYm
 v/bQq9o59IODTSpmzMXL/phRg5eFqE1KnUg3OUc5Hg==
X-Google-Smtp-Source: AGHT+IFOw1TEujpJJrYV+KM749ZraIXGjnx95VFFrEppFXiYRaFS0xPVmjKCxO8l/ZdmdiEIdAP7Gg==
X-Received: by 2002:a05:6359:5c25:b0:16e:3099:847c with SMTP id
 pu37-20020a0563595c2500b0016e3099847cmr6804310rwb.9.1701114732233; 
 Mon, 27 Nov 2023 11:52:12 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 g6-20020ad45106000000b0067a2061fc21sm3087047qvp.101.2023.11.27.11.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 11:52:11 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de,
	ilias.apalodimas@linaro.org,
	sjg@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Nikhil M Jain <n-jain1@ti.com>,
 Baruch Siach <baruch@tkos.co.il>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Qu Wenruo <wqu@suse.com>
Subject: [PATCH v2 02/18] bloblist: Adjust API to align in powers of 2
Date: Mon, 27 Nov 2023 11:50:13 -0800
Message-Id: <20231127195029.90951-3-raymond.mao@linaro.org>
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

The updated bloblist structure stores the alignment as a power-of-two
value in its structures. Adjust the API to use this, to avoid needing to
calling ilog2().

Drop a stale comment while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Update the bloblist alignment to align to FW handoff spec v0.9.

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
index 349ceddea5..e744c2b0c0 100644
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
@@ -126,24 +124,24 @@ static struct bloblist_rec *bloblist_findrec(uint tag)
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
@@ -167,7 +165,7 @@ static int bloblist_addrec(uint tag, int size, int align,
 }
 
 static int bloblist_ensurerec(uint tag, struct bloblist_rec **recp, int size,
-			      int align)
+			      int align_log2)
 {
 	struct bloblist_rec *rec;
 
@@ -180,7 +178,7 @@ static int bloblist_ensurerec(uint tag, struct bloblist_rec **recp, int size,
 	} else {
 		int ret;
 
-		ret = bloblist_addrec(tag, size, align, &rec);
+		ret = bloblist_addrec(tag, size, align_log2, &rec);
 		if (ret)
 			return ret;
 	}
@@ -202,22 +200,22 @@ void *bloblist_find(uint tag, int size)
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
index 3a2ec91e25..1e4f1a6342 100644
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
@@ -252,11 +254,11 @@ void *bloblist_find(uint tag, int size);
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
@@ -266,11 +268,11 @@ void *bloblist_add(uint tag, int size, int align);
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

