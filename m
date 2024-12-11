Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EFFE7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 13:56:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A5EE8033D;
	Wed, 11 Dec 2024 14:54:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MUWFlLz/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9466280330; Wed, 11 Dec 2024 14:54:55 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F38DF8036D
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:54:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-841d8dec299so463797039f.3
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 05:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733925291; x=1734530091; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u7bzpU5tkhyN2il0E8+BzXc4Vn//fGmhiOPnRRpNr9E=;
 b=MUWFlLz/9uhpJXAl5+b6c/5r1sqyFCa1HLaEsBIJrey3DtqyLb5TlvH1L1NOfDLFdD
 LF+aao4nuoZBy/Loi69XQ95jF6GOfcbTQHa+d8KmvOZo/zGaFRETZ1ZqD4CCNnJ8w/+V
 TYxeSyJi8iAHo5OMHjiHPq3DWfwCWHeNaOxqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733925291; x=1734530091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u7bzpU5tkhyN2il0E8+BzXc4Vn//fGmhiOPnRRpNr9E=;
 b=UlyLEisM1pdflCFsWwgSVoqI0HWKzDf5MVBa6PnaE2C+yvURg63svDGJxmexPdhAQd
 NPoO4HIRTyECMeaDwLzpf3hWOkQZBPOFNW/3ZdX/DK5TpW5heRbCehsycZxCYntAuu99
 hTNmN1iuATxo76bTviWqz2IwpAqHIaKk6ZhePOnx1RziBxKqynQ785ASdwwYF5pNpfLP
 cQQLsQvLd5/AI0VcL4G2ej42fxlF0t+o4gs5oETU+y/h18IIElEdA7AQYiPamdHPo3IF
 hjoQHVqdpYwK4HT9ZZdzWmaSP7gWEIeJobJVgJDA2cE81cHICQxKiLwpXZ9PYalQgkNR
 c/wA==
X-Gm-Message-State: AOJu0Yx1xuwNey6lcAk1ZgdH49prHPMulivG6Kg8WbyEYj3Dwlde0B5f
 /E97e4Va3+bqAQpBXQhcCgumUjeOs6+IcgvJTQ9g2JlQzWF1xoG7VV5iKc0Mvzi3CR1awpRBlBM
 =
X-Gm-Gg: ASbGnct/JQyp6CGUz/PyLVw8W/3wGvLvxZzk/p/8I9r7+Mh74Vsy3I5B54peNpZZCW9
 1/E9U739FvdLcmHaxa1lWY4QxYKv0TKLcnUE2KCkTPZBDdCpZB99mAOxqmBIGA7zwPt2uCNsAMH
 PPpT62Ebtf3IfTSDZCVhgxRzpBLHIkjsrd4V7Mbnx0ik++ezcPY63SlNnvFdxsdjzxKnDEKvHCh
 58Yw9NAzRwLoSQwZT7y1xWmS+ZXCAEmJueKFxva03gacrJGSciw4aqxUF2sBboHQ8ktsbojuFAL
 wof0hHAF511yTBk=
X-Google-Smtp-Source: AGHT+IEjxy+h1v0mnUDZw9UP0Aiv3jzVU/9zTCBUQ+59zSAjf7nFj5YQo3FKbSQ5QoNS3KDR0EUKTQ==
X-Received: by 2002:a05:6602:1485:b0:82c:e4e1:2e99 with SMTP id
 ca18e2360f4ac-844cb684329mr334240439f.11.1733925291198; 
 Wed, 11 Dec 2024 05:54:51 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2d46f66f0sm695441173.30.2024.12.11.05.54.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 05:54:50 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 15/23] efi_loader: Rename physical_start to base
Date: Wed, 11 Dec 2024 06:54:09 -0700
Message-Id: <20241211135418.563803-16-sjg@chromium.org>
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

The word 'physical' suggests that there is an associated virtual address
but there is not. Use 'base' since this is the base address of a region.

Change some uint64_t and remove some brackets to keep checkpatch happy.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_memory.c | 38 ++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 42319ceb16f..0f149f99c7d 100644
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
 	newlist->type = memory_type;
-	newlist->physical_start = start;
+	newlist->base = start;
 	newlist->num_pages = pages;
 
 	switch (memory_type) {
@@ -415,7 +415,7 @@ static efi_status_t efi_check_allocated(u64 addr, bool must_be_allocated)
 	struct mem_node *item;
 
 	list_for_each_entry(item, &efi_mem, link) {
-		u64 start = item->physical_start;
+		u64 start = item->base;
 		u64 end = start + (item->num_pages << EFI_PAGE_SHIFT);
 
 		if (addr >= start && addr < end) {
@@ -695,10 +695,10 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
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

