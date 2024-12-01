Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7496BD4977B
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:44:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 290518969C;
	Sun,  1 Dec 2024 16:26:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jsccFwOP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EAF989696; Sun,  1 Dec 2024 16:26:05 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A0D58962A
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:25:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-8418ecda199so118386439f.2
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066757; x=1733671557; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AW0XnmMME9UqgxKPvJBL8ZssBvVLRSh//KOM5Pl5lHY=;
 b=jsccFwOPvIDqoJHBSaljL3QiudaWhxtKs7Lou7GPL4q2pY9PZZEbjyHc+VilqN8nPO
 8wPGbGT466QrgFBkTBHla4VLQ1Su1XE+t3VeSDc8QFYAkWbt+SAv0M2VYa78Z7N9ADJD
 o+4mMAC17AkhCnPX23qn61Zb/aM/3pkqzI2xE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066757; x=1733671557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AW0XnmMME9UqgxKPvJBL8ZssBvVLRSh//KOM5Pl5lHY=;
 b=DQnJIEQo/J63bknFnd715XKenPdDsItKZ2mYdickGG22sAACSrg0CmOvBCwH52qAir
 QQeqiWsIa9SSUp3kJnJmbW+vpj9c86vizWMrtDd+driZkkuMOV/ImVeRamlr8mN41ksn
 i3vFNY4c14IgCSHXNx1NwJZdlTZJiqMGrxVSF/9pCMcsCi7V5nisqwXspKfnMEm6qKKB
 BS6/7HgAf5NzwX3DLCMvQxitBBiuGxW5vDVpqnFZPCjtiqBtXX4Y0g4FHKIo2k6iJbCP
 RmDZ217muvL/bPTZMkvbgKzc6V6IOZQ+/zLWnqI2ivGN7+9irjZOTAPInKawmQVw5czs
 Mwug==
X-Gm-Message-State: AOJu0YzHXHYfTPwFB4R83toLJ6KrsDBvV8oggUP92SZZ33Y63WPoQ6NW
 N+1dpp666VMYFev2PqDgdqhvej/7BkL2aN0R6rDXxT4RX9fhYmlleQr70DnU4E8gj5jYb5FMRus
 =
X-Gm-Gg: ASbGncs63g0hF6CBSI2iDXV7Gr1yu3g5TMW6HhVU+jQWEhiKg+I0P/N6MyqO5Lhs8lb
 VjwDhkYPgsVbZFO3uffBvjwbAWd3Q+dMFDiWSUZydEyJus9+nYvMPjT0EaxQorpD2yyD3wOGteM
 c+Ewf/6X05CSnplFJQLmmEzp3969Jj8hmMS3WWbTp5LU+3NRkj9An0JDFH78IijMaDQHtru7K5m
 FPPStQNb+/+XXEHcv+y1vnpjJyOrYxkwHrbD3849DhT
X-Google-Smtp-Source: AGHT+IHmY4cLPEQGgW0yDxEC0n48PZdHX+TPAfNM6tYkPd8HCr04S2GcV+V5+OcUuBd3d5uDArQe2g==
X-Received: by 2002:a05:6602:6c1c:b0:841:a9d3:3b30 with SMTP id
 ca18e2360f4ac-843ecf9f733mr1948132039f.1.1733066757472; 
 Sun, 01 Dec 2024 07:25:57 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8d88sm159755239f.19.2024.12.01.07.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:25:55 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 16/25] efi_loader: Rename struct efi_mem_list to mem_node
Date: Sun,  1 Dec 2024 08:24:35 -0700
Message-ID: <20241201152505.1666789-17-sjg@chromium.org>
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

This struct is really a node in the list, not a list itself. Also it
doesn't need an efi_ prefix. Rename it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_memory.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 6e474c88784..dbcba99ae39 100644
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
 				   enum efi_memory_type mem_type,
 				   bool overlap_conventional)
 {
-	struct efi_mem_list *lmem;
-	struct efi_mem_list *newlist;
+	struct mem_node *lmem;
+	struct mem_node *newlist;
 	bool carve_again;
 	uint64_t carved_pages = 0;
 	struct efi_event *evt;
@@ -414,7 +413,7 @@ efi_status_t efi_add_memory_map(u64 start, u64 size,
  */
 static efi_status_t efi_check_allocated(u64 addr, bool must_be_allocated)
 {
-	struct efi_mem_list *item;
+	struct mem_node *item;
 
 	list_for_each_entry(item, &efi_mem, link) {
 		u64 start = item->physical_start;
@@ -666,7 +665,7 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
 {
 	size_t map_entries;
 	efi_uintn_t map_size = 0;
-	struct efi_mem_list *lmem;
+	struct mem_node *lmem;
 	efi_uintn_t provided_map_size;
 
 	if (!memory_map_size)
-- 
2.43.0

