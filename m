Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866BCD49776
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:44:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81F8D89649;
	Sun,  1 Dec 2024 16:26:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FV5ByVBD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACC4C89643; Sun,  1 Dec 2024 16:26:00 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA05C893C2
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:25:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-841d8dec20aso109259839f.3
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066755; x=1733671555; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yvu901T+NuTrimk9kXfuI5aDgcGPIkj7M5n4PkUJVzY=;
 b=FV5ByVBD6BK4kXhbtPq7heM1BhZPDIGcwrOAo/0J7bmejK3T/iZCWtABaUX5k7Eysy
 THGjhYvQmix1jyAUTkpQ/wg9sDz1VJI3heiMYf6oJkubJfVjk0MbA7ZdiTu7OlZhC9RH
 OYenhacXUcVh1+Zcc8eOTSc/ZGAqD9REUiq8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066755; x=1733671555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yvu901T+NuTrimk9kXfuI5aDgcGPIkj7M5n4PkUJVzY=;
 b=pM5rXjqzi1sSFOxkZcgDRYTyOqaDnisQQtLYF9TxRqxH40HYBoS+SgyXwOOboh/f4X
 CPeQ47RsrErb9mcO00d2WifLrVX9TWGBEsQWrjjWpK/D+Ku6okLD20ygY9eWpu0uVHSW
 /KaHVRPrsraKxYJ4DLHCTocFDfwyFlsBeiE4QhQGJlSpBag3tqsuKSP8ZZPYDmqmni9l
 IvqTng8xbF9Oqnck4KjLRj6u6dGtJ6fWUiUy763zqkGWfGaD7dfTK29O7VX4wjYm+3pA
 0FHatp51sKylCoWHbFFHodFQ89sh6jiwEOqVO3WyJaRdJB267ZKnlBKAYDBT4od2o4eT
 uPQw==
X-Gm-Message-State: AOJu0YxSvkeaRUrtiN7YOtMdnJKFYs9YltDLD0oTSFsHloQBwjBTv0aR
 I+Vi9HA6kFQPQ9nIjQIXDBBlRuM7JzJSlNhoZqFcYWdAMmhUX0ASmI1B4dRUEmBxKokE/XMa9jA
 =
X-Gm-Gg: ASbGnculCa5T9Ksv6Nb5r71p9cSVp7UF3INeEW4rY3YmtCUN0UQRwpr05vrrw4rRlj/
 plsfFA/Ag2zd4d3tR6xntKnclbES4FwvmgytUvTP2EC5ckgtwOsGHOlpeg7r6tqnwaEz9+XrsjD
 nRW0MFsQz+jhIDjgkVsYIrwMdlacnKk3/BshiOV2VBmOVTtDEmdfj7epPeByPcIJytDfBv2NAe2
 hOMWCZ4POHwtcVBNmYmmDZNexNmdKvwMy6/WP9Oqhgx
X-Google-Smtp-Source: AGHT+IHLDFGXYubI17xYVQvMOATw6OH7+uhYL64+MIpmwXnvxSKZ2ZvIavtrCTrF8JHPid8OsoTuKw==
X-Received: by 2002:a05:6602:610c:b0:843:daae:e16d with SMTP id
 ca18e2360f4ac-843ecf9e2f4mr1823104039f.6.1733066755067; 
 Sun, 01 Dec 2024 07:25:55 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8d88sm159755239f.19.2024.12.01.07.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:25:53 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 15/25] efi_loader: Move struct efi_mem_list fields together
Date: Sun,  1 Dec 2024 08:24:34 -0700
Message-ID: <20241201152505.1666789-16-sjg@chromium.org>
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
index b51bb367899..6e474c88784 100644
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
-	newlist->desc.type = mem_type;
-	newlist->desc.physical_start = start;
-	newlist->desc.num_pages = pages;
+	newlist->type = mem_type;
+	newlist->physical_start = start;
+	newlist->num_pages = pages;
 
 	switch (mem_type) {
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
@@ -424,12 +417,12 @@ static efi_status_t efi_check_allocated(u64 addr, bool must_be_allocated)
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
@@ -703,14 +696,14 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
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
2.43.0

