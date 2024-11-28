Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC0FD70DED
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 19:15:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2DFF89D58;
	Thu, 28 Nov 2024 20:13:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YxNe1WEj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 720D489D62; Thu, 28 Nov 2024 20:13:32 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 212DB89D58
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 20:13:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3ea49150430so560302b6e.1
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732821208; x=1733426008; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pWVBY3M5tyhC3dQA9kiaTF8E/QU0SSWgW4TXo6cSMQE=;
 b=YxNe1WEjQV7kuWMlB9lNbcVwtkKNTZUyFU20TRacyXOER+MTHOumiJy2gAJMwDp/m+
 spGpXicRR0WjZLGs47GA/a8EhNBwOqBFVQHPl9DJKVyq3DNaPWLk0RmAyRTlzW1BJyG6
 jTEf4EV94yHbNfgKy5za4OGEpovkKnNN4dhtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732821208; x=1733426008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pWVBY3M5tyhC3dQA9kiaTF8E/QU0SSWgW4TXo6cSMQE=;
 b=m9A8OfLODPfwwRk5pF/c0IISAjyYMnwGw8AKil0yjUb0Hpch91GPk12cYkuwCeZzpW
 aZlNRDpsHhxMzTWPMChxgNw4j/bOiHkUrMfB6tfmoMlfJlqmexG2LpGq0lBoqdtXWb/z
 UPNCe+oVDXysJYzFaWPDNvZYUrKA2L+IYzAZ+1T9StyRgxKXzrXegXlVdMXpDNok+/3p
 BjCdDmaC24OiEIwX/l/8HDwsuXfI9MglGhqHEdSf3wYE3psBXlLrOiFlWTF8VPj52xX2
 lij8emlPWVLFO2mvQdQ5Aq43neI+bxE5PYWf4COGwbgyiMwNWE/EEFlCkoK/LmRim6Sw
 w1/Q==
X-Gm-Message-State: AOJu0YyOkuaTGukcp1BZHE5aW8pupVqxxa0FWRakNmILrJ5PCvb7E+9r
 1QZNcqvkXT9JrkWpA9KyEeCTmvaqCLHSZWzW+lvMhn2IdCQ00FehO2JFWwR8Ny3nipHuP4KW4fU
 =
X-Gm-Gg: ASbGncsNk60aURe6biRfqGCBZpyyjhqaRIYLEgC06vqXW/1aES7kprCTEKquZzYE+oN
 reeWtT4ro7MQDhgDOviqh4DDip4wcQA82ufG3/ft04vt/TmH+09yO4ljHTyADLnZApg/Yx/dpf+
 zZo0B14dhOvfostKLSRy33t3QMdd+8I76IqQ81QJ0fNFJvx6AP28wvvCbJaooyiWEufV/+FgLrl
 z8JBXXq3YMIVyQ/n2PSrBhTJ+dWRgGECa7i4Yjp9tW3Lw==
X-Google-Smtp-Source: AGHT+IHikg+TX9s46wfQchlOcfR/RS9tj5AoyCGn/ei7aNssl+0iYWMhC37t3YpwbquHuJdbN8C+Dg==
X-Received: by 2002:a05:6830:441e:b0:71d:625e:cf2c with SMTP id
 46e09a7af769-71d65cbca86mr9364244a34.17.1732821208385; 
 Thu, 28 Nov 2024 11:13:28 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725d873esm429521a34.54.2024.11.28.11.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 11:13:26 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 16/28] efi_loader: Rename struct efi_mem_list to mem_node
Date: Thu, 28 Nov 2024 12:12:32 -0700
Message-Id: <20241128191244.900006-17-sjg@chromium.org>
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
2.34.1

