Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9E8D70DEB
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 19:15:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A2D089D76;
	Thu, 28 Nov 2024 20:13:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JXrbhfGl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7071A89D4D; Thu, 28 Nov 2024 20:13:35 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BB0289D63
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 20:13:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2689e7a941fso646267fac.3
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732821211; x=1733426011; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hpl36AxffD+3HZTlJTMndbR6x1OkFzNOIv3+gL+27fw=;
 b=JXrbhfGlLqsBHCLo38tH0CgQCDGOYhysOANKsqaGqp5j9NQeI69JsBr9/wuCQVqB2p
 HK+/Yil1jZaLHVGFKdtWd9zd2YyZnGp1L3GppumgWO6Kd0RxyLIoiPDikadYTBiU9wet
 wpPdSsyTxn67jOwXuyhEjJ8gSHtUmjDzMjpuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732821211; x=1733426011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hpl36AxffD+3HZTlJTMndbR6x1OkFzNOIv3+gL+27fw=;
 b=NP1Fqlpkfo50u/3lREk5JGQ1GbkO6Etfk0PSd1qSnvC47eOnZVgtb5tL1k2jC7sJ9y
 fn4RdLI70THPuvLgn8l8ayqC639QSvVehU37iCysWXc0UivkVCGvlnSMImX5OI2YdaFi
 NFgGiAoWQI7w8zaSpSRzaz+SJYtE1Blqh95P8LKxkHMA5f42IkRWspHHFWUU9VtWZch8
 Slr3e5/3xEog7MV0UCnDZvpVEkrao5GSWMukANHrFy8A66iNJD/uHD48/gS3iQznqmJ1
 xirRS1LSSwnHAiwbMlLThMBTtjVKrkt0kKtrIfjL0xat5iXS6vt8xCX/mKiJ+IY4TiyU
 xctg==
X-Gm-Message-State: AOJu0YxkzmyearbGULUwwz0wx0o75PJ6lUPfyA12Odm/0//kzfeE9r5j
 HcJAeFEJadp8dHx4N+7sXaMopQ9heMCsTCqtElzipoXdwK4uXBIinZTHII9jTzXcy6xHyR45iro
 =
X-Gm-Gg: ASbGncsxDEuY+ZNQaffD5dNDd2za28qit2oIiEZeXBA85k5/x9M4jzSUwgZ9K9f1CJt
 R1QGhxPuwhHW1mwyYHCd3qtGbYu8rRVQNqylnYbNT9Mnvh4FpoEnJIwpKOXszlcf4C/YBKbvvcE
 Wh3o+R1BP6NF3hYeuOl4WiNUxFKyOTWPWR58KDWtzv2yXHHco9L/arVkp+KgSHNTGUhwbmKyhqN
 V3/jyeMXhIhiZttiH+/8rRIHpyeA8cbgJb/DxVNzhX5oQ==
X-Google-Smtp-Source: AGHT+IGw9JJyj6uSQxgGJlfGN+0VMinS0d3O0gnvZVPvyj3ts88OS4Knv2p04Q1k5FI7IUEla5qG6Q==
X-Received: by 2002:a05:6870:3909:b0:296:df26:8a6e with SMTP id
 586e51a60fabf-29dc47b00efmr7691163fac.35.1732821211320; 
 Thu, 28 Nov 2024 11:13:31 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725d873esm429521a34.54.2024.11.28.11.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 11:13:29 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 17/28] efi_loader: Rename physical_start to base
Date: Thu, 28 Nov 2024 12:12:33 -0700
Message-Id: <20241128191244.900006-18-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128191244.900006-1-sjg@chromium.org>
References: <20241128191244.900006-1-sjg@chromium.org>
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
2.34.1

