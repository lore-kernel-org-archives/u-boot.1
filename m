Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A3ED69114
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:49:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA65B89D57;
	Thu, 28 Nov 2024 16:48:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GUG88Ufb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F97F89885; Thu, 28 Nov 2024 16:48:05 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC1B089CD5
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:48:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3ea405aa7b3so501410b6e.3
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732808881; x=1733413681; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pkjurNN7sHUyUF8I1SDBvWbkfsklDgupcQX4m37kHPk=;
 b=GUG88UfbjxnMkvubFNFUB8YuJvk1eQygvaiT6KyURnTv5AT5ya2PJ52xNhaJxxRdMV
 bGUWkH/vU8gXqVqkpnwRhu0uU8fu53AgveKsAk8CfP1ZI/Y6DkdJzWYrMSrpGUxfzTtV
 irVEcXOQNVQVyHQcN2Q14Zkz09VSLrbuHcn2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732808881; x=1733413681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pkjurNN7sHUyUF8I1SDBvWbkfsklDgupcQX4m37kHPk=;
 b=wNRHhb7koe3o4l7FVLoLxakYaewcGBymxoZxbpe0guZ+rSP9jRhXZOVhNvQZQRerpG
 aoSxRIWgcPy1jNtDBghTRAcUq+6YcxVXE6LqnHxSFSFZuWmuoyZOWRio/WwTALOk/N6i
 rOohceSeMjmCoNrYn1o3FKD2oX1orndpuwaz/6famH7a2aIdGUOwgkDtKGuJAOB0XsVp
 uIxinld64ldKfpdtu4Snet+kW/tUz8N7Q3gOacraw/I8fy5nYw3CcCnMBdae6cX5XoM5
 AvQ5w6LPiIkoFFPlyz1Q5/2Fi6IOPVe10DI69g1zguqXPALaG75QltxH5Vi3o0R4UH7B
 fF9A==
X-Gm-Message-State: AOJu0Yy5L/1J1/bJGIVXJ771lm9uEV4iq7cPwH/AHAEifJU0t5Yhx8UD
 InOoJiq8w1QN3DimP4AfCiB3qwMRoB5274YxDJZY2yRSha29bDTtSQbi1ZytpYrLMf0uxCOnJh0
 =
X-Gm-Gg: ASbGncvZ+jqvW/PqxoQHT/RRfMLB0t2RrwP7pcU8SAmPnU7wrirWTJAeeEd0jupoW6C
 QxnobUiJN3Vw7+wXmU4AFDmWatX3TaQO4DS/dzJ6NcF+U7JGdelbrIRTihDr7S+XNmUt/Wqgv9Z
 ux8FCchIkUMFN1xwrg252Z13mfJ0F4fqsNuTjyDdeuhL24LIzNkOZwbLMczdW8O3Ed5gimigSep
 ++Gaxv36z/LH5uoDhyGAI1UjG17/5joHjczkyAcUpxQ8Q==
X-Google-Smtp-Source: AGHT+IFYERx3TQfNMGNd5Dc/+n6VD+NosyqI1E+AzzNEaI8Akpd1hI9DtS2/HPzsYv9xghdEalaJkA==
X-Received: by 2002:a05:6808:1790:b0:3ea:4c23:db12 with SMTP id
 5614622812f47-3ea6d870447mr4847228b6e.0.1732808880768; 
 Thu, 28 Nov 2024 07:48:00 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea86347014sm305419b6e.47.2024.11.28.07.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 07:47:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Janne Grunau <j@jannau.net>,
 Moritz Fischer <moritzf@google.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v2 09/28] efi_loader: Use the enum for memory type
Date: Thu, 28 Nov 2024 08:47:08 -0700
Message-Id: <20241128154727.771871-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128154727.771871-1-sjg@chromium.org>
References: <20241128154727.771871-1-sjg@chromium.org>
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

Changes in v2:
- Drop the changes to the boottime API

 include/efi_loader.h             | 29 ++++++++++----------
 lib/efi_loader/efi_boottime.c    | 12 ++++-----
 lib/efi_loader/efi_device_path.c |  4 +--
 lib/efi_loader/efi_memory.c      | 46 +++++++++++++++++---------------
 4 files changed, 47 insertions(+), 44 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 3f75f2efcb6..a7228672f27 100644
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
@@ -837,14 +838,14 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
  *			actually a pointer provided as an integer. To pass in
  *			an address, pass in (ulong)map_to_sysmem(addr)
  * @size:		length in bytes of the memory area
- * @memory_type:	type of memory added
- *
+ * @mem_type:		EFI type of memory added
  * Return:		status code
  *
  * This function automatically aligns the start and size of the memory area
  * to EFI_PAGE_SIZE.
  */
-efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
+efi_status_t efi_add_memory_map(u64 start, u64 size,
+				enum efi_memory_type mem_type);
 
 /**
  * efi_add_memory_map_pg() - add pages to the memory map
@@ -854,13 +855,13 @@ efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
  * in (ulong)map_to_sysmem(addr)
  *
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
@@ -919,7 +920,7 @@ struct efi_device_path *efi_dp_part_node(struct blk_desc *desc, int part);
 struct efi_device_path *efi_dp_from_file(const struct efi_device_path *dp,
 					 const char *path);
 struct efi_device_path *efi_dp_from_eth(void);
-struct efi_device_path *efi_dp_from_mem(uint32_t mem_type,
+struct efi_device_path *efi_dp_from_mem(enum efi_memory_type mem_type,
 					uint64_t start_address,
 					size_t size);
 /* Determine the last device path node that is not the end node. */
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index be8e4f41ad2..8f311f95d1f 100644
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
@@ -425,14 +425,14 @@ static void EFIAPI efi_restore_tpl(efi_uintn_t old_tpl)
  *
  * Return: status code
  */
-static efi_status_t EFIAPI efi_allocate_pages_ext(int type, int memory_type,
+static efi_status_t EFIAPI efi_allocate_pages_ext(int type, int mem_type,
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
index 9d0f27dbb3e..3cece51f030 100644
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
@@ -416,8 +417,8 @@ static efi_status_t efi_check_allocated(u64 addr, bool must_be_allocated)
 }
 
 efi_status_t efi_allocate_pages(enum efi_allocate_type type,
-				enum efi_memory_type memory_type,
-				efi_uintn_t pages, uint64_t *memory)
+				enum efi_memory_type mem_type,
+				efi_uintn_t pages, uint64_t *memoryp)
 {
 	u64 efi_addr, len;
 	uint flags;
@@ -425,10 +426,9 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 	phys_addr_t addr;
 
 	/* Check import parameters */
-	if (memory_type >= EFI_PERSISTENT_MEMORY_TYPE &&
-	    memory_type <= 0x6FFFFFFF)
+	if (mem_type >= EFI_PERSISTENT_MEMORY_TYPE && mem_type <= 0x6fffffff)
 		return EFI_INVALID_PARAMETER;
-	if (!memory)
+	if (!memoryp)
 		return EFI_INVALID_PARAMETER;
 	len = (u64)pages << EFI_PAGE_SHIFT;
 	/* Catch possible overflow on 64bit systems */
@@ -447,17 +447,17 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 		break;
 	case EFI_ALLOCATE_MAX_ADDRESS:
 		/* Max address */
-		addr = map_to_sysmem((void *)(uintptr_t)*memory);
+		addr = map_to_sysmem((void *)(uintptr_t)*memoryp);
 		addr = (u64)lmb_alloc_base_flags(len, EFI_PAGE_SIZE, addr,
 						 flags);
 		if (!addr)
 			return EFI_OUT_OF_RESOURCES;
 		break;
 	case EFI_ALLOCATE_ADDRESS:
-		if (*memory & EFI_PAGE_MASK)
+		if (*memoryp & EFI_PAGE_MASK)
 			return EFI_NOT_FOUND;
 
-		addr = map_to_sysmem((void *)(uintptr_t)*memory);
+		addr = map_to_sysmem((void *)(uintptr_t)*memoryp);
 		addr = (u64)lmb_alloc_addr_flags(addr, len, flags);
 		if (!addr)
 			return EFI_NOT_FOUND;
@@ -469,7 +469,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 
 	efi_addr = (u64)(uintptr_t)map_sysmem(addr, 0);
 	/* Reserve that map in our memory maps */
-	ret = efi_add_memory_map_pg(efi_addr, pages, memory_type, true);
+	ret = efi_add_memory_map_pg(efi_addr, pages, mem_type, true);
 	if (ret != EFI_SUCCESS) {
 		/* Map would overlap, bail out */
 		lmb_free_flags(addr, (u64)pages << EFI_PAGE_SHIFT, flags);
@@ -477,7 +477,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 		return  EFI_OUT_OF_RESOURCES;
 	}
 
-	*memory = efi_addr;
+	*memoryp = efi_addr;
 
 	return EFI_SUCCESS;
 }
@@ -515,7 +515,8 @@ efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
 	return ret;
 }
 
-void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align)
+void *efi_alloc_aligned_pages(u64 len, enum efi_memory_type mem_type,
+			      size_t align)
 {
 	u64 req_pages = efi_size_in_pages(len);
 	u64 true_pages = req_pages + efi_size_in_pages(align) - 1;
@@ -533,12 +534,12 @@ void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align)
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
@@ -559,7 +560,8 @@ void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align)
 	return (void *)(uintptr_t)aligned_mem;
 }
 
-efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size, void **buffer)
+efi_status_t efi_allocate_pool(enum efi_memory_type mem_type, efi_uintn_t size,
+			       void **buffer)
 {
 	efi_status_t r;
 	u64 addr;
@@ -575,7 +577,7 @@ efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
 		return EFI_SUCCESS;
 	}
 
-	r = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, pool_type, num_pages,
+	r = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, mem_type, num_pages,
 			       &addr);
 	if (r == EFI_SUCCESS) {
 		alloc = (struct efi_pool_allocation *)(uintptr_t)addr;
-- 
2.34.1

