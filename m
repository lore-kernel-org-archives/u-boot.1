Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0622EE7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 13:56:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8C80802D5;
	Wed, 11 Dec 2024 14:54:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mR48wybY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3577B8036E; Wed, 11 Dec 2024 14:54:53 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D870D8031E
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:54:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3a7d690479eso37542145ab.0
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 05:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733925289; x=1734530089; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rI2NitIZWJwgFmzHXOnwQiUzfVEiMUXgBFKD+P02Ajo=;
 b=mR48wybYqZZCaQz2iiFgnKamKvzMP+nqPcCKQFtE3XerCwr8u7pGwLOMQFLBEc2aL+
 wvXebPUauDkS0ZsOFwAmfQ6Z4pF1cNZ/M2wTc6s/LnnpabjV3SpRCVJtpbnQA6pXcTsc
 P6JIXTwHbe1U7DGR7r2ZbdnaWFSLqr6CejQgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733925289; x=1734530089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rI2NitIZWJwgFmzHXOnwQiUzfVEiMUXgBFKD+P02Ajo=;
 b=dZQIr/Jaq5HHJgu6hbQYHJx9fBnBeF846Ouf7pAccbfXas75Xx4yT9jGYIR2xOcECp
 RMONgRDuA5r12j8f52X6MkTKxuDnbJY5QVN+oH77j7KIgoQ8UbWU9sujJyGzMVdvFIW2
 yNkgcYG284nDh9RK9tWsPLvJkk/bG4K93xHfBBwd/96tBqW9YxDCKlfUXm8xHP6WJ7q+
 9l3P/iYLe/ISJHZBXjRNx3Q4ADHqZWZK1DFF14LFlHeu2VV0TTX5JeUFJwpdkrki/gJK
 i6huF/eSwKUNRRol63yMNb4DVK0CLP2FDgCLKZtO7MMWkAfzzwVz2WNVtu3/dGrVTeMg
 o7hQ==
X-Gm-Message-State: AOJu0Yye+wrspymXoLeT4buKxAD8KXdVwVw78bfkx5b0DHQrAHBEisaz
 ufprcjjeExScU/ebE8D9i0fjjKTJIkA4Hzgsaecf0NppwmjqRanFR1PmM/IPlEKOgGG694JxXjM
 =
X-Gm-Gg: ASbGncuUG2EeiN/+oipeXA33YV3ACzstc9Pbb6h96VUOPDUZy3NL1ImFDMRgjCBnA3C
 wUna7bccQHOPUJnRzeBG7VKjUnq0qS0Nm9WzQ5Y/NhyyD+IpeOky04SmMwEW8ec/i4hu3XVCUMA
 fZbS0znYN/ERW/NJr+ROKLyGgovJ/D0JXUMwXf0U9/tJgI/67hl/VATJdnCQEk/cOITVwQpG5Jc
 DY28H7dTS663cXZo4k4DqVxHjafXNGkgshwn/cSViJNAuBvIGzQeDt2++AWsPqjOs2M1NYmFwX9
 qHyj131s0QunKxk=
X-Google-Smtp-Source: AGHT+IGeUueErlGK/PlJ3OA2H8NffGqwO6IYMjdHHtf1dxcs62G9PsgmKNKBdw1tbmo/aK1t2WlBhg==
X-Received: by 2002:a05:6e02:12c3:b0:3a7:e047:733f with SMTP id
 e9e14a558f8ab-3aa054de4bfmr37719555ab.1.1733925289117; 
 Wed, 11 Dec 2024 05:54:49 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2d46f66f0sm695441173.30.2024.12.11.05.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 05:54:47 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 14/23] efi_loader: Rename struct efi_mem_list to mem_node
Date: Wed, 11 Dec 2024 06:54:08 -0700
Message-Id: <20241211135418.563803-15-sjg@chromium.org>
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

This struct is really a node in the list, not a list itself. Also it
doesn't need an efi_ prefix. Rename it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_memory.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 89e001fa753..42319ceb16f 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -28,7 +28,7 @@ DECLARE_GLOBAL_DATA_PTR;
 efi_uintn_t efi_memory_map_key;
 
 /**
- * struct efi_mem_list - defines an EFI memory record
+ * struct mem_node - defines an EFI memory record
  *
  * Note that this struct is for use inside U-Boot and is not visible to the
  * EFI application, other than through calls to efi_get_memory_map(), where this
@@ -43,7 +43,7 @@ efi_uintn_t efi_memory_map_key;
  *	bytes)
  * @attribute: Memory attributes (see EFI_MEMORY...)
  */
-struct efi_mem_list {
+struct mem_node {
 	struct list_head link;
 	enum efi_memory_type type;
 	efi_physical_addr_t physical_start;
@@ -118,8 +118,8 @@ static u64 checksum(struct efi_pool_allocation *alloc)
  */
 static int efi_mem_cmp(void *priv, struct list_head *a, struct list_head *b)
 {
-	struct efi_mem_list *mema = list_entry(a, struct efi_mem_list, link);
-	struct efi_mem_list *memb = list_entry(b, struct efi_mem_list, link);
+	struct mem_node *mema = list_entry(a, struct mem_node, link);
+	struct mem_node *memb = list_entry(b, struct mem_node, link);
 
 	if (mema->physical_start == memb->physical_start)
 		return 0;
@@ -135,7 +135,7 @@ static int efi_mem_cmp(void *priv, struct list_head *a, struct list_head *b)
  * @node:	memory node
  * Return:	end address + 1
  */
-static uint64_t desc_get_end(struct efi_mem_list *node)
+static uint64_t desc_get_end(struct mem_node *node)
 {
 	return node->physical_start + (node->num_pages << EFI_PAGE_SHIFT);
 }
@@ -147,8 +147,8 @@ static uint64_t desc_get_end(struct efi_mem_list *node)
  */
 static void efi_mem_sort(void)
 {
-	struct efi_mem_list *lmem;
-	struct efi_mem_list *prevmem = NULL;
+	struct mem_node *lmem;
+	struct mem_node *prevmem = NULL;
 	bool merge_again = true;
 
 	list_sort(NULL, &efi_mem, efi_mem_cmp);
@@ -157,8 +157,8 @@ static void efi_mem_sort(void)
 	while (merge_again) {
 		merge_again = false;
 		list_for_each_entry(lmem, &efi_mem, link) {
-			struct efi_mem_list *prev;
-			struct efi_mem_list *cur;
+			struct mem_node *prev;
+			struct mem_node *cur;
 			uint64_t pages;
 
 			if (!prevmem) {
@@ -211,12 +211,11 @@ static void efi_mem_sort(void)
  * In case of EFI_CARVE_OVERLAPS_NONRAM it is the callers responsibility
  * to re-add the already carved out pages to the mapping.
  */
-static s64 efi_mem_carve_out(struct efi_mem_list *map,
-			     struct efi_mem_list *carve_desc,
+static s64 efi_mem_carve_out(struct mem_node *map, struct mem_node *carve_desc,
 			     bool overlap_conventional)
 {
-	struct efi_mem_list *newmap;
-	struct efi_mem_list *map_desc = map;
+	struct mem_node *newmap;
+	struct mem_node *map_desc = map;
 	uint64_t map_start = map_desc->physical_start;
 	uint64_t map_end = map_start + (map_desc->num_pages << EFI_PAGE_SHIFT);
 	uint64_t carve_start = carve_desc->physical_start;
@@ -278,8 +277,8 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
 				   int memory_type,
 				   bool overlap_conventional)
 {
-	struct efi_mem_list *lmem;
-	struct efi_mem_list *newlist;
+	struct mem_node *lmem;
+	struct mem_node *newlist;
 	bool carve_again;
 	uint64_t carved_pages = 0;
 	struct efi_event *evt;
@@ -413,7 +412,7 @@ efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type)
  */
 static efi_status_t efi_check_allocated(u64 addr, bool must_be_allocated)
 {
-	struct efi_mem_list *item;
+	struct mem_node *item;
 
 	list_for_each_entry(item, &efi_mem, link) {
 		u64 start = item->physical_start;
@@ -664,7 +663,7 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
 {
 	size_t map_entries;
 	efi_uintn_t map_size = 0;
-	struct efi_mem_list *lmem;
+	struct mem_node *lmem;
 	efi_uintn_t provided_map_size;
 
 	if (!memory_map_size)
-- 
2.34.1

