Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D00D49776
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:54:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DE6B89671;
	Sun,  1 Dec 2024 16:26:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hm5PpUkD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7DF9896A6; Sun,  1 Dec 2024 16:26:06 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BE7689287
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:26:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-843e9db3e65so110584839f.1
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066759; x=1733671559; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g50jFbQilotfdpO+wQO3TVa/I0OIG9ioszP1TilLaV0=;
 b=hm5PpUkDp/vNRo++kXntjX923pZ7mTiz4RTopltEA7y2Z5d6yzHxNX7Trgi3akqsTU
 6XrPhvGekzOjsopkrIN90wHybFEhLy7n9toVjvgINcvWIihwLY00gnGLFEE1VchXA4HZ
 VjbooqVVJufHEtBqTNH+p8arqz1AnHPYcKSZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066759; x=1733671559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g50jFbQilotfdpO+wQO3TVa/I0OIG9ioszP1TilLaV0=;
 b=SJawfbOrwW3ycL/tG2GKc5dVJkMSjjITDLR6kk/80Vhexj0Uk/xOY8YPv5TYyWRgU/
 JD9zzMBHjQxdO+mPPiW4QuWVhSu9Gm8KJWZ44IhEEk2m9mfqkj0hDJNGVptp+I6rxgqi
 EjfnhhAmbiG4kHgMNLTFiq6C/h5ZqbYcdiZY/X6wUXf3gNdwcFRggUynW+DEwWhAzdva
 mpwLDf4Mo16bQuBU9Zu4AOo75TWs3M4PbJ586l/cDy9UvBrBlleC+FLwp7nmGQbCFdTo
 S/An9FYfB5qh520ZOy0sPAD7/nHkanSOlQuFi64UsheSp51Hf9bjX6Nuc8ArUcw62akV
 rEiQ==
X-Gm-Message-State: AOJu0YwjS4bzgYkszFjc1Xqn0n/FJQ+ib0ToXciad3OR54627GzvLTIg
 YptubYZqZIfD5RtFX+uhAre722QoUtMd6dhpWZKJpUEZwRTHp2ewNOq8NKGy/7ueXTglSUJRR5M
 =
X-Gm-Gg: ASbGncvA2G7UvUlc3TO16/cU8GHAiHDcCBF4u7VTD1PyHqB0qgXvqTg3uJ8otmW4HUh
 6mZ4SwkRpYmxaoJXU7418j/9U372cDM6JiiPHe9Z57C4sgyGqFhkbONgrbGrTStuys+K+KulBwo
 Z5OXPfGuudvj0ayYnRillyo3tddOkbR7h4JUDuOKGt8+KB1FYL1uk8j/BAZrnGqUG6es9+XVUmh
 dVXlwKYlMiOLVI8+DjXUKG2XbMfyxp1G2cFEijO8xNS
X-Google-Smtp-Source: AGHT+IFStFAaUw0kyeNa8TXua7mjOvxzXStLA1DYT8ulJDinjls76mXklgBbG0qDIHdJpjpwXsIejQ==
X-Received: by 2002:a05:6602:160d:b0:83a:ae9d:9300 with SMTP id
 ca18e2360f4ac-84401506111mr1113565039f.3.1733066759514; 
 Sun, 01 Dec 2024 07:25:59 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8d88sm159755239f.19.2024.12.01.07.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:25:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 17/25] efi_loader: Rename physical_start to base
Date: Sun,  1 Dec 2024 08:24:36 -0700
Message-ID: <20241201152505.1666789-18-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201152505.1666789-1-sjg@chromium.org>
References: <20241201152505.1666789-1-sjg@chromium.org>
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

The word 'physical' suggests that there is an associated virtual address
but there is not. Use 'base' since this is the base address of a region.

Change some uint64_t and remove some brackets to keep checkpatch happy.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_memory.c | 38 ++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index dbcba99ae39..89f22388fc4 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -36,7 +36,7 @@ efi_uintn_t efi_memory_map_key;
  *
  * @link: Link to prev/next node in list
  * @type: EFI memory-type
- * @physical_start: Start address of region in physical memory. Note that this
+ * @base: Start address of region in physical memory. Note that this
  *	is really a pointer stored as an address, so use map_to_sysmem() to
  *	convert it to an address if needed
  * @num_pages: Number of EFI pages this record covers (each is EFI_PAGE_SIZE
@@ -46,7 +46,7 @@ efi_uintn_t efi_memory_map_key;
 struct mem_node {
 	struct list_head link;
 	enum efi_memory_type type;
-	efi_physical_addr_t physical_start;
+	efi_physical_addr_t base;
 	u64 num_pages;
 	u64 attribute;
 };
@@ -121,9 +121,9 @@ static int efi_mem_cmp(void *priv, struct list_head *a, struct list_head *b)
 	struct mem_node *mema = list_entry(a, struct mem_node, link);
 	struct mem_node *memb = list_entry(b, struct mem_node, link);
 
-	if (mema->physical_start == memb->physical_start)
+	if (mema->base == memb->base)
 		return 0;
-	else if (mema->physical_start < memb->physical_start)
+	else if (mema->base < memb->base)
 		return 1;
 	else
 		return -1;
@@ -137,7 +137,7 @@ static int efi_mem_cmp(void *priv, struct list_head *a, struct list_head *b)
  */
 static uint64_t desc_get_end(struct mem_node *node)
 {
-	return node->physical_start + (node->num_pages << EFI_PAGE_SHIFT);
+	return node->base + (node->num_pages << EFI_PAGE_SHIFT);
 }
 
 /**
@@ -169,13 +169,13 @@ static void efi_mem_sort(void)
 			cur = lmem;
 			prev = prevmem;
 
-			if ((desc_get_end(cur) == prev->physical_start) &&
-			    (prev->type == cur->type) &&
-			    (prev->attribute == cur->attribute)) {
+			if (desc_get_end(cur) == prev->base &&
+			    prev->type == cur->type &&
+			    prev->attribute == cur->attribute) {
 				/* There is an existing map before, reuse it */
 				pages = cur->num_pages;
 				prev->num_pages += pages;
-				prev->physical_start -= pages << EFI_PAGE_SHIFT;
+				prev->base -= pages << EFI_PAGE_SHIFT;
 				list_del(&lmem->link);
 				free(lmem);
 
@@ -216,10 +216,10 @@ static s64 efi_mem_carve_out(struct mem_node *map, struct mem_node *carve_desc,
 {
 	struct mem_node *newmap;
 	struct mem_node *map_desc = map;
-	uint64_t map_start = map_desc->physical_start;
-	uint64_t map_end = map_start + (map_desc->num_pages << EFI_PAGE_SHIFT);
-	uint64_t carve_start = carve_desc->physical_start;
-	uint64_t carve_end = carve_start +
+	u64 map_start = map_desc->base;
+	u64 map_end = map_start + (map_desc->num_pages << EFI_PAGE_SHIFT);
+	u64 carve_start = carve_desc->base;
+	u64 carve_end = carve_start +
 			     (carve_desc->num_pages << EFI_PAGE_SHIFT);
 
 	/* check whether we're overlapping */
@@ -241,7 +241,7 @@ static s64 efi_mem_carve_out(struct mem_node *map, struct mem_node *carve_desc,
 			list_del(&map->link);
 			free(map);
 		} else {
-			map->physical_start = carve_end;
+			map->base = carve_end;
 			map->num_pages = (map_end - carve_end)
 					      >> EFI_PAGE_SHIFT;
 		}
@@ -261,7 +261,7 @@ static s64 efi_mem_carve_out(struct mem_node *map, struct mem_node *carve_desc,
 	if (!newmap)
 		return EFI_CARVE_OUT_OF_RESOURCES;
 	newmap->type = map->type;
-	newmap->physical_start = carve_start;
+	newmap->base = carve_start;
 	newmap->num_pages = (map_end - carve_start) >> EFI_PAGE_SHIFT;
 	newmap->attribute = map->attribute;
 	/* Insert before current entry (descending address order) */
@@ -298,7 +298,7 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
 	if (!newlist)
 		return EFI_OUT_OF_RESOURCES;
 	newlist->type = mem_type;
-	newlist->physical_start = start;
+	newlist->base = start;
 	newlist->num_pages = pages;
 
 	switch (mem_type) {
@@ -416,7 +416,7 @@ static efi_status_t efi_check_allocated(u64 addr, bool must_be_allocated)
 	struct mem_node *item;
 
 	list_for_each_entry(item, &efi_mem, link) {
-		u64 start = item->physical_start;
+		u64 start = item->base;
 		u64 end = start + (item->num_pages << EFI_PAGE_SHIFT);
 
 		if (addr >= start && addr < end) {
@@ -697,10 +697,10 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
 	list_for_each_entry(lmem, &efi_mem, link) {
 		memory_map->type = lmem->type;
 		memory_map->reserved = 0;
-		memory_map->physical_start = lmem->physical_start;
+		memory_map->physical_start = lmem->base;
 
 		/* virtual and physical are always the same */
-		memory_map->virtual_start = lmem->physical_start;
+		memory_map->virtual_start = lmem->base;
 		memory_map->num_pages = lmem->num_pages;
 		memory_map->attribute = lmem->attribute;
 		memory_map--;
-- 
2.43.0

