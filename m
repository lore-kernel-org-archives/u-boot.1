Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD24FD59D6B
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 20:46:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69D5889A7A;
	Mon, 25 Nov 2024 21:45:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Lg9JkH7b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7223689A6C; Mon, 25 Nov 2024 21:45:31 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEFB589A8C
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 21:45:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3a75c24f447so17753625ab.0
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 12:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732567527; x=1733172327; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DF1DT5Y3+TArPuLvk+mdG8gPqvhvApmtbfy8cXMg3RE=;
 b=Lg9JkH7bOK/g18PGmiSfn3ASPPwZkT9L6fsNk5slKev0M7o7DRW2mSaodyrjzCM9Js
 1bGiJesflyorsdK8Q5JNlRXLuaIeyKdU9aoMEG/l39Tkd12yK3jT+S9WvMPTkcnEpqqT
 8eGihzh9E+/DdKgrkGgWkxJz6kPSJefZXMjfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732567527; x=1733172327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DF1DT5Y3+TArPuLvk+mdG8gPqvhvApmtbfy8cXMg3RE=;
 b=Ep//kHOAX7MUBXHxtuPaCFaEjJJI9kGFq87eUsy6PM5lDfmb5slNepRnHF+AxT/gyL
 ilMh5TeJhnnuuPXWoz0N5egsf7Ms0bnvpL+UQdVjR9T4EpQId5SyGXYIDTGtmrb1Vi05
 i2y+9OIw84tKL/jkJ+QA6t+pUcWEm78gWZF1Yp1PKpZRMwUctL01W8OKOSk0xUUUo2tb
 KWGaJuJiZtN5mHCZFmiyHoM+regaje3mlfnNp60l/VN1lV0csr0d+n6+V1bpcwebSrs5
 pHjD1U80+KF/zHk3HHMnVdSyARaLjYbcr8XxNoUMlnmU9SUh7r8G0bsx41M/1A9WsPw0
 d0hw==
X-Gm-Message-State: AOJu0YzZ01TrE8i7pVfGhH7i9hh6md90G2meUmdDE/fuSNrohyRxjR/z
 OMlZJQN6bD4g9yCnz2mj5D076YZpAdLnx4WerWsZiGeGrugfz/+kz6RtBIg1JWEvzO/CWiuS28E
 =
X-Gm-Gg: ASbGncu0W30wp/N876CHuzuOOkZr7j+z38HsHYuUUvmKoOnJ1PYEgmSD8EyUrTGgz6n
 sr+JiQtWywkvwYP50DkHROGTtPKI+Gb5qMzEJysSLRbu8BrAG7d0ph2pUHdX/JCAUejBU0OZtoc
 EkKLRhH0R0kOspQEv5W8jLDLimLHThZploBDnGnpgUMdiMEKgc1m7JA5pA4fK1GOK8ZkesBD7ea
 +8Dn0iap59aa0jPT8dPXJ0uJkIshQ7Ymw6wYJcKTvGkA5Y=
X-Google-Smtp-Source: AGHT+IGNlzsJp/IXVZZgzNNzcuUDuQVJRpBaMmz9cxgdJB2k44NpqwsxLwOK+l8dJT9d1fnacSVmZA==
X-Received: by 2002:a05:6602:6b0f:b0:803:5e55:ecb2 with SMTP id
 ca18e2360f4ac-83ecdb1aa25mr1530077139f.0.1732567527090; 
 Mon, 25 Nov 2024 12:45:27 -0800 (PST)
Received: from chromium.org ([50.235.115.130])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-841ac8403a2sm26134639f.9.2024.11.25.12.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 12:45:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Janne Grunau <j@jannau.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Moritz Fischer <moritzf@google.com>, Patrick Wildt <pwildt@google.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 06/13] efi_loader: Use the enum for memory type
Date: Mon, 25 Nov 2024 13:44:45 -0700
Message-ID: <20241125204456.1525752-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241125204456.1525752-1-sjg@chromium.org>
References: <20241125204456.1525752-1-sjg@chromium.org>
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

Rather than an integer, it is better to use the enum provided, when
referring to an EFI memory-type. Update existing uses.

Call the value 'mem_type' consistently. Fix up one instance of
upper-case hex.

Fix up the calls in struct efi_boot_services so that they use the same
enum, adding the missing parameter names and enum efi_allocate_type.

While we are here, rename the 'memory' parameter to 'memoryp' so that it
is clear it is a return value.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/efi_api.h                |  6 ++++--
 include/efi_loader.h             | 28 ++++++++++++++-------------
 lib/efi_loader/efi_boottime.c    | 13 +++++++------
 lib/efi_loader/efi_device_path.c |  4 ++--
 lib/efi_loader/efi_memory.c      | 33 ++++++++++++++++----------------
 5 files changed, 45 insertions(+), 39 deletions(-)

diff --git a/include/efi_api.h b/include/efi_api.h
index f07d074f93b..1260df0cd58 100644
--- a/include/efi_api.h
+++ b/include/efi_api.h
@@ -69,8 +69,10 @@ struct efi_boot_services {
 	efi_status_t (EFIAPI *raise_tpl)(efi_uintn_t new_tpl);
 	void (EFIAPI *restore_tpl)(efi_uintn_t old_tpl);
 
-	efi_status_t (EFIAPI *allocate_pages)(int, int, efi_uintn_t,
-					      efi_physical_addr_t *);
+	efi_status_t (EFIAPI *allocate_pages)(enum efi_allocate_type type,
+					      enum efi_memory_type mem_type,
+					      efi_uintn_t pages,
+					      efi_physical_addr_t *memoryp);
 	efi_status_t (EFIAPI *free_pages)(efi_physical_addr_t, efi_uintn_t);
 	efi_status_t (EFIAPI *get_memory_map)(efi_uintn_t *memory_map_size,
 					      struct efi_mem_desc *desc,
diff --git a/include/efi_loader.h b/include/efi_loader.h
index ff7adc1e2a2..0ef4c6f7dea 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -773,24 +773,25 @@ void *efi_alloc(size_t len);
  * efi_alloc_aligned_pages() - allocate aligned memory pages
  *
  * @len:		len in bytes
- * @memory_type:	usage type of the allocated memory
+ * @mem_type:		usage type of the allocated memory
  * @align:		alignment in bytes
  * Return:		aligned memory or NULL
  */
-void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align);
+void *efi_alloc_aligned_pages(u64 len, enum efi_memory_type mem_type,
+			      size_t align);
 
 /**
  * efi_allocate_pages - allocate memory pages
  *
  * @type:		type of allocation to be performed
- * @memory_type:	usage type of the allocated memory
+ * @mem_type:		usage type of the allocated memory
  * @pages:		number of pages to be allocated
- * @memory:		returns a pointer to the allocated memory
+ * @memoryp:		returns a pointer to the allocated memory
  * Return:		status code
  */
 efi_status_t efi_allocate_pages(enum efi_allocate_type type,
-				enum efi_memory_type memory_type,
-				efi_uintn_t pages, uint64_t *memory);
+				enum efi_memory_type mem_type,
+				efi_uintn_t pages, uint64_t *memoryp);
 
 /**
  * efi_free_pages() - free memory pages
@@ -804,12 +805,12 @@ efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages);
 /**
  * efi_allocate_pool - allocate memory from pool
  *
- * @pool_type:	type of the pool from which memory is to be allocated
+ * @mem_type:	memory type of the pool from which memory is to be allocated
  * @size:	number of bytes to be allocated
  * @buffer:	allocated memory
  * Return:	status code
  */
-efi_status_t efi_allocate_pool(enum efi_memory_type pool_type,
+efi_status_t efi_allocate_pool(enum efi_memory_type mem_type,
 			       efi_uintn_t size, void **buffer);
 
 /**
@@ -834,10 +835,11 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
  * efi_add_memory_map() - Add a range into the EFI memory map
  * @start: start address, must be a multiple of EFI_PAGE_SIZE
  * @size: Size, in bytes
- * @memory_type: EFI type of memory added
+ * @mem_type: EFI type of memory added
  * Return: status code
  */
-efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
+efi_status_t efi_add_memory_map(u64 start, u64 size,
+				enum efi_memory_type mem_type);
 
 /**
  * efi_add_memory_map_pg() - add pages to the memory map
@@ -845,13 +847,13 @@ efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
  * @start:			start address, must be a multiple of
  *				EFI_PAGE_SIZE
  * @pages:			number of pages to add
- * @memory_type:		EFI type of memory added
+ * @mem_type:		EFI type of memory added
  * @overlap_conventional:	region may only overlap free(conventional)
  *				memory
  * Return:			status code
  */
 efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
-				   int memory_type,
+				   enum efi_memory_type mem_type,
 				   bool overlap_conventional);
 
 /* Called by board init to initialize the EFI drivers */
@@ -910,7 +912,7 @@ struct efi_device_path *efi_dp_part_node(struct blk_desc *desc, int part);
 struct efi_device_path *efi_dp_from_file(const struct efi_device_path *dp,
 					 const char *path);
 struct efi_device_path *efi_dp_from_eth(void);
-struct efi_device_path *efi_dp_from_mem(uint32_t mem_type,
+struct efi_device_path *efi_dp_from_mem(enum efi_memory_type mem_type,
 					uint64_t start_address,
 					size_t size);
 /* Determine the last device path node that is not the end node. */
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 90437e3e401..efd9577c9d0 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -414,9 +414,9 @@ static void EFIAPI efi_restore_tpl(efi_uintn_t old_tpl)
 /**
  * efi_allocate_pages_ext() - allocate memory pages
  * @type:        type of allocation to be performed
- * @memory_type: usage type of the allocated memory
+ * @mem_type:    usage type of the allocated memory
  * @pages:       number of pages to be allocated
- * @memory:      allocated memory
+ * @memoryp:     allocated memory
  *
  * This function implements the AllocatePages service.
  *
@@ -425,14 +425,15 @@ static void EFIAPI efi_restore_tpl(efi_uintn_t old_tpl)
  *
  * Return: status code
  */
-static efi_status_t EFIAPI efi_allocate_pages_ext(int type, int memory_type,
+static efi_status_t EFIAPI efi_allocate_pages_ext(enum efi_allocate_type type,
+						  enum efi_memory_type mem_type,
 						  efi_uintn_t pages,
-						  uint64_t *memory)
+						  uint64_t *memoryp)
 {
 	efi_status_t r;
 
-	EFI_ENTRY("%d, %d, 0x%zx, %p", type, memory_type, pages, memory);
-	r = efi_allocate_pages(type, memory_type, pages, memory);
+	EFI_ENTRY("%d, %d, 0x%zx, %p", type, mem_type, pages, memoryp);
+	r = efi_allocate_pages(type, mem_type, pages, memoryp);
 	return EFI_EXIT(r);
 }
 
diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index ee387e1dfd4..9c8cd35b97b 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -975,7 +975,7 @@ struct efi_device_path __maybe_unused *efi_dp_from_eth(void)
 }
 
 /* Construct a device-path for memory-mapped image */
-struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
+struct efi_device_path *efi_dp_from_mem(enum efi_memory_type mem_type,
 					uint64_t start_address,
 					size_t size)
 {
@@ -990,7 +990,7 @@ struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
 	mdp->dp.type = DEVICE_PATH_TYPE_HARDWARE_DEVICE;
 	mdp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MEMORY;
 	mdp->dp.length = sizeof(*mdp);
-	mdp->memory_type = memory_type;
+	mdp->memory_type = mem_type;
 	mdp->start_address = start_address;
 	mdp->end_address = start_address + size;
 	buf = &mdp[1];
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 7c8d9485094..2c46915e5b9 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -258,7 +258,7 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
 }
 
 efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
-				   int memory_type,
+				   enum efi_memory_type mem_type,
 				   bool overlap_conventional)
 {
 	struct efi_mem_list *lmem;
@@ -268,10 +268,10 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
 	struct efi_event *evt;
 
 	EFI_PRINT("%s: 0x%llx 0x%llx %d %s\n", __func__,
-		  start, pages, memory_type, overlap_conventional ?
+		  start, pages, mem_type, overlap_conventional ?
 		  "yes" : "no");
 
-	if (memory_type >= EFI_MAX_MEMORY_TYPE)
+	if (mem_type >= EFI_MAX_MEMORY_TYPE)
 		return EFI_INVALID_PARAMETER;
 
 	if (!pages)
@@ -281,12 +281,12 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
 	newlist = calloc(1, sizeof(*newlist));
 	if (!newlist)
 		return EFI_OUT_OF_RESOURCES;
-	newlist->desc.type = memory_type;
+	newlist->desc.type = mem_type;
 	newlist->desc.physical_start = start;
 	newlist->desc.virtual_start = start;
 	newlist->desc.num_pages = pages;
 
-	switch (memory_type) {
+	switch (mem_type) {
 	case EFI_RUNTIME_SERVICES_CODE:
 	case EFI_RUNTIME_SERVICES_DATA:
 		newlist->desc.attribute = EFI_MEMORY_WB | EFI_MEMORY_RUNTIME;
@@ -370,14 +370,15 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
 	return EFI_SUCCESS;
 }
 
-efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type)
+efi_status_t efi_add_memory_map(u64 start, u64 size,
+				enum efi_memory_type mem_type)
 {
 	u64 pages;
 
 	pages = efi_size_in_pages(size + (start & EFI_PAGE_MASK));
 	start &= ~EFI_PAGE_MASK;
 
-	return efi_add_memory_map_pg(start, pages, memory_type, false);
+	return efi_add_memory_map_pg(start, pages, mem_type, false);
 }
 
 /**
@@ -416,7 +417,7 @@ static efi_status_t efi_check_allocated(u64 addr, bool must_be_allocated)
 }
 
 efi_status_t efi_allocate_pages(enum efi_allocate_type type,
-				enum efi_memory_type memory_type,
+				enum efi_memory_type mem_type,
 				efi_uintn_t pages, uint64_t *memory)
 {
 	u64 efi_addr, len;
@@ -425,8 +426,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 	phys_addr_t addr;
 
 	/* Check import parameters */
-	if (memory_type >= EFI_PERSISTENT_MEMORY_TYPE &&
-	    memory_type <= 0x6FFFFFFF)
+	if (mem_type >= EFI_PERSISTENT_MEMORY_TYPE && mem_type <= 0x6fffffff)
 		return EFI_INVALID_PARAMETER;
 	if (!memory)
 		return EFI_INVALID_PARAMETER;
@@ -469,7 +469,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 
 	efi_addr = (u64)(uintptr_t)map_sysmem(addr, 0);
 	/* Reserve that map in our memory maps */
-	ret = efi_add_memory_map_pg(efi_addr, pages, memory_type, true);
+	ret = efi_add_memory_map_pg(efi_addr, pages, mem_type, true);
 	if (ret != EFI_SUCCESS) {
 		/* Map would overlap, bail out */
 		lmb_free_flags(addr, (u64)pages << EFI_PAGE_SHIFT, flags);
@@ -522,7 +522,8 @@ efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
 	return ret;
 }
 
-void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align)
+void *efi_alloc_aligned_pages(u64 len, enum efi_memory_type mem_type,
+			      size_t align)
 {
 	u64 req_pages = efi_size_in_pages(len);
 	u64 true_pages = req_pages + efi_size_in_pages(align) - 1;
@@ -540,12 +541,12 @@ void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align)
 		return NULL;
 
 	if (align < EFI_PAGE_SIZE) {
-		r = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, memory_type,
+		r = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, mem_type,
 				       req_pages, &mem);
 		return (r == EFI_SUCCESS) ? (void *)(uintptr_t)mem : NULL;
 	}
 
-	r = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, memory_type,
+	r = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, mem_type,
 			       true_pages, &mem);
 	if (r != EFI_SUCCESS)
 		return NULL;
@@ -566,7 +567,7 @@ void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align)
 	return (void *)(uintptr_t)aligned_mem;
 }
 
-efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size, void **buffer)
+efi_status_t efi_allocate_pool(enum efi_memory_type mem_type, efi_uintn_t size, void **buffer)
 {
 	efi_status_t r;
 	u64 addr;
@@ -582,7 +583,7 @@ efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
 		return EFI_SUCCESS;
 	}
 
-	r = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, pool_type, num_pages,
+	r = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, mem_type, num_pages,
 			       &addr);
 	if (r == EFI_SUCCESS) {
 		alloc = (struct efi_pool_allocation *)(uintptr_t)addr;
-- 
2.43.0

