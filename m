Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB55FE7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 13:56:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 629D48035E;
	Wed, 11 Dec 2024 14:54:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IoQPFfsv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0825A80323; Wed, 11 Dec 2024 14:54:51 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A012480317
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:54:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3a77980fe3aso2424185ab.0
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 05:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733925287; x=1734530087; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QBjhJ4SAen71BP7r95q0od+qjXKD3Jz0aSC/5v5N4R4=;
 b=IoQPFfsvqOxswSDfWl2tyjAYxnwE7dvmDhn5ag9w0nrEMaLW0Pvok3XVDWDLKDJ5Jl
 vN/PxjoLcuPYJAzppMlgnjkdNV3GQ7RYB+U4p66oJS/tg+m2NRrgWojVLxM9gnKt230A
 Y+DAULmHruXRuGLzWf2R5P6osRkOCqPlOZz+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733925287; x=1734530087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QBjhJ4SAen71BP7r95q0od+qjXKD3Jz0aSC/5v5N4R4=;
 b=rlEnaQRyPE2pjrZ0aX5zwIjHopkK8rCslVN4V0sn+o7Z2jFVdBCSebgsodxGmZMJrq
 1I4ZpMwX1KkIQ5+j02Msc8OwXeJYLbq+39cffvui6H16ph5M52xBdTLD+n0zJlFLQxFv
 SwqJZ+UAZtikS6mMMbqjzDEm9L/GkcKGEzZQ6cLp8KdY370RGt0gmiH0+MbZgZfe0HoQ
 ELXKk5s1sAAKm8i36pD8WtUP47vReZvJLwzKzIYiyyEaIMGY5HB4RhSF1FK6uo+YH5at
 DZII/QL/DRA2/cmTo75ml7pWP0lCvYiJZbRzZEQNMw/irz+UoJEvyo1sOAQz7KaLKfTx
 LEsg==
X-Gm-Message-State: AOJu0YxVEKkdrC0TT0o6Ak5OqFRMr/IGe90QtTqwqhisuCSv11yKxIWE
 oLy4gVTw9d0CC/tfCkpslPNmbXJqNZzIvo2uK+nhC+pW/xHagmpvBS7dLyonvnyxKg/LX5LxNVA
 =
X-Gm-Gg: ASbGncuhfwXCJ2SwPts9dRwJrk4IPUsigmND84oVGcyZbu5h0JAJ7WJjYODyuvFWbqI
 KaZ6fXelBgHU8pWc9k68GgAj49KN1D5VAO19ZM3fxlQwz09jo53npuRcKnTmsoxpLhX2ch9oYdY
 s6xUl1TY8UxjNdWo3jutpUioZI48SUb8u/Mzr6h/0vG/+3wJUKIxkWp7+4w4hefgqKRYs+/Gu4f
 mv3yDBjE7VesS/HRMgpDc6c2un713Yw27VeLJYFCKQ64m8wJbdyqBUa4+53F2t/VKQgszaud3Np
 hs6MIjkY9Q9U4js=
X-Google-Smtp-Source: AGHT+IHvUE1E94KgPvWK/aW1cV2ar4rRVpRCWjzd1s4+5KdnSz32MxC4HGfL8yPC+TsHCuUQXG/o+g==
X-Received: by 2002:a92:c9c6:0:b0:3a9:cde3:2ecc with SMTP id
 e9e14a558f8ab-3aa198365c7mr26061485ab.6.1733925286870; 
 Wed, 11 Dec 2024 05:54:46 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2d46f66f0sm695441173.30.2024.12.11.05.54.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 05:54:46 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 13/23] efi_loader: Move struct efi_mem_list fields together
Date: Wed, 11 Dec 2024 06:54:07 -0700
Message-Id: <20241211135418.563803-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211135418.563803-1-sjg@chromium.org>
References: <20241211135418.563803-1-sjg@chromium.org>
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

We don't need a separate struct for the values in this node. Move
everything in together, so that there is just one struct to consider.

Add a comment about physical_start, so it is clear that it is really
a pointer.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_memory.c | 85 +++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 46 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index f3aaa0e9288..89e001fa753 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -28,36 +28,29 @@ DECLARE_GLOBAL_DATA_PTR;
 efi_uintn_t efi_memory_map_key;
 
 /**
- * struct priv_mem_desc - defines an memory region
+ * struct efi_mem_list - defines an EFI memory record
  *
  * Note that this struct is for use inside U-Boot and is not visible to the
  * EFI application, other than through calls to efi_get_memory_map(), where this
  * internal format is converted to the external struct efi_mem_desc format.
  *
+ * @link: Link to prev/next node in list
  * @type: EFI memory-type
- * @physical_start: Start address of region in physical memory
+ * @physical_start: Start address of region in physical memory. Note that this
+ *	is really a pointer stored as an address, so use map_to_sysmem() to
+ *	convert it to an address if needed
  * @num_pages: Number of EFI pages this record covers (each is EFI_PAGE_SIZE
  *	bytes)
  * @attribute: Memory attributes (see EFI_MEMORY...)
  */
-struct priv_mem_desc {
+struct efi_mem_list {
+	struct list_head link;
 	enum efi_memory_type type;
 	efi_physical_addr_t physical_start;
 	u64 num_pages;
 	u64 attribute;
 };
 
-/**
- * struct efi_mem_list - defines an EFI memory record
- *
- * @link: Link to prev/next node in list
- * @desc: Memory information about this node
- */
-struct efi_mem_list {
-	struct list_head link;
-	struct priv_mem_desc desc;
-};
-
 #define EFI_CARVE_NO_OVERLAP		-1
 #define EFI_CARVE_LOOP_AGAIN		-2
 #define EFI_CARVE_OVERLAPS_NONRAM	-3
@@ -128,9 +121,9 @@ static int efi_mem_cmp(void *priv, struct list_head *a, struct list_head *b)
 	struct efi_mem_list *mema = list_entry(a, struct efi_mem_list, link);
 	struct efi_mem_list *memb = list_entry(b, struct efi_mem_list, link);
 
-	if (mema->desc.physical_start == memb->desc.physical_start)
+	if (mema->physical_start == memb->physical_start)
 		return 0;
-	else if (mema->desc.physical_start < memb->desc.physical_start)
+	else if (mema->physical_start < memb->physical_start)
 		return 1;
 	else
 		return -1;
@@ -139,12 +132,12 @@ static int efi_mem_cmp(void *priv, struct list_head *a, struct list_head *b)
 /**
  * desc_get_end() - get end address of memory area
  *
- * @desc:	memory descriptor
+ * @node:	memory node
  * Return:	end address + 1
  */
-static uint64_t desc_get_end(struct priv_mem_desc *desc)
+static uint64_t desc_get_end(struct efi_mem_list *node)
 {
-	return desc->physical_start + (desc->num_pages << EFI_PAGE_SHIFT);
+	return node->physical_start + (node->num_pages << EFI_PAGE_SHIFT);
 }
 
 /**
@@ -164,8 +157,8 @@ static void efi_mem_sort(void)
 	while (merge_again) {
 		merge_again = false;
 		list_for_each_entry(lmem, &efi_mem, link) {
-			struct priv_mem_desc *prev;
-			struct priv_mem_desc *cur;
+			struct efi_mem_list *prev;
+			struct efi_mem_list *cur;
 			uint64_t pages;
 
 			if (!prevmem) {
@@ -173,8 +166,8 @@ static void efi_mem_sort(void)
 				continue;
 			}
 
-			cur = &lmem->desc;
-			prev = &prevmem->desc;
+			cur = lmem;
+			prev = prevmem;
 
 			if ((desc_get_end(cur) == prev->physical_start) &&
 			    (prev->type == cur->type) &&
@@ -219,11 +212,11 @@ static void efi_mem_sort(void)
  * to re-add the already carved out pages to the mapping.
  */
 static s64 efi_mem_carve_out(struct efi_mem_list *map,
-			     struct priv_mem_desc *carve_desc,
+			     struct efi_mem_list *carve_desc,
 			     bool overlap_conventional)
 {
 	struct efi_mem_list *newmap;
-	struct priv_mem_desc *map_desc = &map->desc;
+	struct efi_mem_list *map_desc = map;
 	uint64_t map_start = map_desc->physical_start;
 	uint64_t map_end = map_start + (map_desc->num_pages << EFI_PAGE_SHIFT);
 	uint64_t carve_start = carve_desc->physical_start;
@@ -249,8 +242,8 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
 			list_del(&map->link);
 			free(map);
 		} else {
-			map->desc.physical_start = carve_end;
-			map->desc.num_pages = (map_end - carve_end)
+			map->physical_start = carve_end;
+			map->num_pages = (map_end - carve_end)
 					      >> EFI_PAGE_SHIFT;
 		}
 
@@ -268,10 +261,10 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
 	newmap = calloc(1, sizeof(*newmap));
 	if (!newmap)
 		return EFI_CARVE_OUT_OF_RESOURCES;
-	newmap->desc.type = map->desc.type;
-	newmap->desc.physical_start = carve_start;
-	newmap->desc.num_pages = (map_end - carve_start) >> EFI_PAGE_SHIFT;
-	newmap->desc.attribute = map->desc.attribute;
+	newmap->type = map->type;
+	newmap->physical_start = carve_start;
+	newmap->num_pages = (map_end - carve_start) >> EFI_PAGE_SHIFT;
+	newmap->attribute = map->attribute;
 	/* Insert before current entry (descending address order) */
 	list_add_tail(&newmap->link, &map->link);
 
@@ -305,20 +298,20 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
 	newlist = calloc(1, sizeof(*newlist));
 	if (!newlist)
 		return EFI_OUT_OF_RESOURCES;
-	newlist->desc.type = memory_type;
-	newlist->desc.physical_start = start;
-	newlist->desc.num_pages = pages;
+	newlist->type = memory_type;
+	newlist->physical_start = start;
+	newlist->num_pages = pages;
 
 	switch (memory_type) {
 	case EFI_RUNTIME_SERVICES_CODE:
 	case EFI_RUNTIME_SERVICES_DATA:
-		newlist->desc.attribute = EFI_MEMORY_WB | EFI_MEMORY_RUNTIME;
+		newlist->attribute = EFI_MEMORY_WB | EFI_MEMORY_RUNTIME;
 		break;
 	case EFI_MMAP_IO:
-		newlist->desc.attribute = EFI_MEMORY_RUNTIME;
+		newlist->attribute = EFI_MEMORY_RUNTIME;
 		break;
 	default:
-		newlist->desc.attribute = EFI_MEMORY_WB;
+		newlist->attribute = EFI_MEMORY_WB;
 		break;
 	}
 
@@ -328,7 +321,7 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
 		list_for_each_entry(lmem, &efi_mem, link) {
 			s64 r;
 
-			r = efi_mem_carve_out(lmem, &newlist->desc,
+			r = efi_mem_carve_out(lmem, newlist,
 					      overlap_conventional);
 			switch (r) {
 			case EFI_CARVE_OUT_OF_RESOURCES:
@@ -423,12 +416,12 @@ static efi_status_t efi_check_allocated(u64 addr, bool must_be_allocated)
 	struct efi_mem_list *item;
 
 	list_for_each_entry(item, &efi_mem, link) {
-		u64 start = item->desc.physical_start;
-		u64 end = start + (item->desc.num_pages << EFI_PAGE_SHIFT);
+		u64 start = item->physical_start;
+		u64 end = start + (item->num_pages << EFI_PAGE_SHIFT);
 
 		if (addr >= start && addr < end) {
 			if (must_be_allocated ^
-			    (item->desc.type == EFI_CONVENTIONAL_MEMORY))
+			    (item->type == EFI_CONVENTIONAL_MEMORY))
 				return EFI_SUCCESS;
 			else
 				return EFI_NOT_FOUND;
@@ -701,14 +694,14 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
 	/* Return the list in ascending order */
 	memory_map = &memory_map[map_entries - 1];
 	list_for_each_entry(lmem, &efi_mem, link) {
-		memory_map->type = lmem->desc.type;
+		memory_map->type = lmem->type;
 		memory_map->reserved = 0;
-		memory_map->physical_start = lmem->desc.physical_start;
+		memory_map->physical_start = lmem->physical_start;
 
 		/* virtual and physical are always the same */
-		memory_map->virtual_start = lmem->desc.physical_start;
-		memory_map->num_pages = lmem->desc.num_pages;
-		memory_map->attribute = lmem->desc.attribute;
+		memory_map->virtual_start = lmem->physical_start;
+		memory_map->num_pages = lmem->num_pages;
+		memory_map->attribute = lmem->attribute;
 		memory_map--;
 	}
 
-- 
2.34.1

