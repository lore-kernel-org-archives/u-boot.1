Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4EDC3DA7E
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 11:12:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39C1F8881F;
	Tue, 30 Jul 2024 13:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65B0C8881F; Tue, 30 Jul 2024 13:12:04 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 31EEE87A55
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 13:12:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 316561007;
 Tue, 30 Jul 2024 04:12:27 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC84A3F5A1;
 Tue, 30 Jul 2024 04:11:59 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 4/5] efi_memory: get the efi_mem_list node directly
Date: Tue, 30 Jul 2024 16:41:31 +0530
Message-Id: <20240730111132.1097315-4-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730111132.1097315-1-sughosh.ganu@linaro.org>
References: <20240730111132.1097315-1-sughosh.ganu@linaro.org>
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

Use the list_for_each_entry() API to get the efi_mem_list node
directly, instead of making an additional call to list_entry().

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 lib/efi_loader/efi_memory.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 8d4f6e339d..6819c2ec90 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -127,7 +127,7 @@ static uint64_t desc_get_end(struct efi_mem_desc *desc)
  */
 static void efi_mem_sort(void)
 {
-	struct list_head *lhandle;
+	struct efi_mem_list *lmem;
 	struct efi_mem_list *prevmem = NULL;
 	bool merge_again = true;
 
@@ -136,13 +136,11 @@ static void efi_mem_sort(void)
 	/* Now merge entries that can be merged */
 	while (merge_again) {
 		merge_again = false;
-		list_for_each(lhandle, &efi_mem) {
-			struct efi_mem_list *lmem;
+		list_for_each_entry(lmem, &efi_mem, link) {
 			struct efi_mem_desc *prev;
 			struct efi_mem_desc *cur;
 			uint64_t pages;
 
-			lmem = list_entry(lhandle, struct efi_mem_list, link);
 			if (!prevmem) {
 				prevmem = lmem;
 				continue;
@@ -269,7 +267,7 @@ static efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
 					  int memory_type,
 					  bool overlap_only_ram)
 {
-	struct list_head *lhandle;
+	struct efi_mem_list *lmem;
 	struct efi_mem_list *newlist;
 	bool carve_again;
 	uint64_t carved_pages = 0;
@@ -309,11 +307,9 @@ static efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
 	/* Add our new map */
 	do {
 		carve_again = false;
-		list_for_each(lhandle, &efi_mem) {
-			struct efi_mem_list *lmem;
+		list_for_each_entry(lmem, &efi_mem, link) {
 			s64 r;
 
-			lmem = list_entry(lhandle, struct efi_mem_list, link);
 			r = efi_mem_carve_out(lmem, &newlist->desc,
 					      overlap_only_ram);
 			switch (r) {
@@ -445,7 +441,7 @@ static efi_status_t efi_check_allocated(u64 addr, bool must_be_allocated)
  */
 static uint64_t efi_find_free_memory(uint64_t len, uint64_t max_addr)
 {
-	struct list_head *lhandle;
+	struct efi_mem_list *lmem;
 
 	/*
 	 * Prealign input max address, so we simplify our matching
@@ -453,9 +449,7 @@ static uint64_t efi_find_free_memory(uint64_t len, uint64_t max_addr)
 	 */
 	max_addr &= ~EFI_PAGE_MASK;
 
-	list_for_each(lhandle, &efi_mem) {
-		struct efi_mem_list *lmem = list_entry(lhandle,
-			struct efi_mem_list, link);
+	list_for_each_entry(lmem, &efi_mem, link) {
 		struct efi_mem_desc *desc = &lmem->desc;
 		uint64_t desc_len = desc->num_pages << EFI_PAGE_SHIFT;
 		uint64_t desc_end = desc->physical_start + desc_len;
@@ -745,7 +739,7 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
 {
 	int map_entries;
 	efi_uintn_t map_size = 0;
-	struct list_head *lhandle;
+	struct efi_mem_list *lmem;
 	efi_uintn_t provided_map_size;
 
 	if (!memory_map_size)
@@ -774,10 +768,7 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
 	/* Copy list into array */
 	/* Return the list in ascending order */
 	memory_map = &memory_map[map_entries - 1];
-	list_for_each(lhandle, &efi_mem) {
-		struct efi_mem_list *lmem;
-
-		lmem = list_entry(lhandle, struct efi_mem_list, link);
+	list_for_each_entry(lmem, &efi_mem, link) {
 		*memory_map = lmem->desc;
 		memory_map--;
 	}
-- 
2.34.1

