Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E354D49771
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:40:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD81B8953C;
	Sun,  1 Dec 2024 16:25:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MvsHZtmL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 099A4894B4; Sun,  1 Dec 2024 16:25:41 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5278289432
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:25:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-843e9db3e65so110580139f.1
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066733; x=1733671533; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZWIMerzAshT8Z39JWWonZgfSz+ivQP/fViGlfgIdT+o=;
 b=MvsHZtmLzm2EU1o2AGvh9vNKU0mJZWg9hj581jW265KUXsNpGQtcsuHwXkWOeR5M/V
 co71jPNNZgDmI+v0PWqPNQQPC1bEGo4YWjLetWhY1Jq8qN4NuhoF2jRL/dxzqtkS/yHd
 9MvqfVSAT6X7TE85OY9Xvjg+fimcgcQ2C0iy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066733; x=1733671533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZWIMerzAshT8Z39JWWonZgfSz+ivQP/fViGlfgIdT+o=;
 b=XTO2LoRyUVGkeTHxySvZvQwiHf4U1ayFxw95sbmwFoxDWtA4K+fX+SP0icc5XPy31s
 Xdi79jvqXrRdnKzJLPv5JlA7o2TG2y1HOa7KHtDz2cpiUe+atqB6H+IVoXIvayOpZ1gR
 GojbKL6wKENNmCq+oinHrtxoeBFaifgVYshGfcc28rOAjG65JgDOjaP79jWgg1+Dt9YH
 BLc49Pr8g3dCtWnRJ3URcLhmQtome3D4G/wP0BGesc2NWVRK9eUoi1RBYx9gR7gs/tKP
 zgTaIFN6vZoJn8oRudsy3q5lnM9QBGVfR50Jq4KPbpEEMpwo3x6xS1zkAGS9kA6cQmRO
 OlIg==
X-Gm-Message-State: AOJu0Yy2wLXLcT34EbtXtlWP/kHz0Sd0R6yN+hGKcVsYbyc4ktCvDbOR
 TRH64QNk7enlF7BHnLyy5Ce6+W/H4CSgbQ4kLCnd7s7WfpMzplnVAF6AmkyugeelQc+Zr4+65Co
 =
X-Gm-Gg: ASbGncu+p8jzAsElk/wPPb6rKj5ZHbRLxMoStRRTPuEua1H6nD/0A3YdjtX1PTmlO6g
 Y2MxXVKszmO3VZFaVjf2Y5BrPxaWVlsM4yB717P9/FafIAwUHQ1M1f6lJzOM4X0ZdjOx3BAq5u3
 8wrrm1ARx0/xAC9vHcqBcekK2aneUDBfO8UNVyBZr27D59poszt129BLIMZf6iK6FzXh/lJbH35
 tT9wZR98gFiq2Fk3+6l3tcp8ViRhPIwmm1wNUI+aLUV
X-Google-Smtp-Source: AGHT+IH0KwEX5rr71rDmmjDeH+Veo9J23hLM9bjJhtZBysMIh9ae6ZPd8UzBUaSoiHgVwF/fkVlktQ==
X-Received: by 2002:a05:6602:cd:b0:835:39a8:e201 with SMTP id
 ca18e2360f4ac-844013ca42amr1066558439f.0.1733066733499; 
 Sun, 01 Dec 2024 07:25:33 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8d88sm159755239f.19.2024.12.01.07.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:25:32 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v4 07/25] efi_loader: Move some memory-function comments to
 header
Date: Sun,  1 Dec 2024 08:24:26 -0700
Message-ID: <20241201152505.1666789-8-sjg@chromium.org>
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

Exported functions should be documented in the header file, not the
implementation. We tend to make such updates on a piecemeal basis to
avoid a 'flag day'. Move some comments related to memory allocation to
follow the convention.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Rebase on early patch

 include/efi_loader.h        | 77 +++++++++++++++++++++++++++++++----
 lib/efi_loader/efi_memory.c | 81 -------------------------------------
 2 files changed, 69 insertions(+), 89 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index ee0cdd36500..00a1259c006 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -758,21 +758,68 @@ efi_status_t efi_next_variable_name(efi_uintn_t *size, u16 **buf,
  * Return:	size in pages
  */
 #define efi_size_in_pages(size) (((size) + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT)
-/* Allocate boot service data pool memory */
+
+/**
+ * efi_alloc() - allocate boot-services-data pool-memory
+ *
+ * Allocate memory from pool and zero it out.
+ *
+ * @size:	number of bytes to allocate
+ * Return:	pointer to allocated memory or NULL
+ */
 void *efi_alloc(size_t len);
-/* Allocate pages on the specified alignment */
+
+/**
+ * efi_alloc_aligned_pages() - allocate aligned memory pages
+ *
+ * @len:		len in bytes
+ * @memory_type:	usage type of the allocated memory
+ * @align:		alignment in bytes
+ * Return:		aligned memory or NULL
+ */
 void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align);
-/* More specific EFI memory allocator, called by EFI payloads */
+
+/**
+ * efi_allocate_pages - allocate memory pages
+ *
+ * @type:		type of allocation to be performed
+ * @memory_type:	usage type of the allocated memory
+ * @pages:		number of pages to be allocated
+ * @memory:		returns a pointer to the allocated memory
+ * Return:		status code
+ */
 efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 				enum efi_memory_type memory_type,
 				efi_uintn_t pages, uint64_t *memory);
-/* EFI memory free function. */
+
+/**
+ * efi_free_pages() - free memory pages
+ *
+ * @memory:	start of the memory area to be freed
+ * @pages:	number of pages to be freed
+ * Return:	status code
+ */
 efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages);
-/* EFI memory allocator for small allocations */
+
+/**
+ * efi_allocate_pool - allocate memory from pool
+ *
+ * @pool_type:	type of the pool from which memory is to be allocated
+ * @size:	number of bytes to be allocated
+ * @buffer:	allocated memory
+ * Return:	status code
+ */
 efi_status_t efi_allocate_pool(enum efi_memory_type pool_type,
 			       efi_uintn_t size, void **buffer);
-/* EFI pool memory free function. */
+
+/**
+ * efi_free_pool() - free memory from pool
+ *
+ * @buffer:	start of memory to be freed
+ * Return:	status code
+ */
 efi_status_t efi_free_pool(void *buffer);
+
 /* Allocate and retrieve EFI memory map */
 efi_status_t efi_get_memory_map_alloc(efi_uintn_t *map_size,
 				      struct efi_mem_desc **memory_map);
@@ -782,7 +829,21 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
 				efi_uintn_t *map_key,
 				efi_uintn_t *descriptor_size,
 				uint32_t *descriptor_version);
-/* Adds a range into the EFI memory map */
+
+/**
+ * efi_add_memory_map() - add memory area to the memory map
+ *
+ * @start:		start address of the memory area. Note that this is
+ *			actually a pointer provided as an integer. To pass in
+ *			an address, pass in (ulong)map_to_sysmem(addr)
+ * @size:		length in bytes of the memory area
+ * @memory_type:	type of memory added
+ *
+ * Return:		status code
+ *
+ * This function automatically aligns the start and size of the memory area
+ * to EFI_PAGE_SIZE.
+ */
 efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
 
 /**
@@ -793,7 +854,7 @@ efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
  * in (ulong)map_to_sysmem(addr)
  *
  * @pages:			number of pages to add
- * @memory_type:		type of memory added
+ * @memory_type:		EFI type of memory added
  * @overlap_conventional:	region may only overlap free(conventional)
  *				memory
  * Return:			status code
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 3b1c7528e92..9d0f27dbb3e 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -257,17 +257,6 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
 	return EFI_CARVE_LOOP_AGAIN;
 }
 
-/**
- * efi_add_memory_map_pg() - add pages to the memory map
- *
- * @start:			start address, must be a multiple of
- *				EFI_PAGE_SIZE
- * @pages:			number of pages to add
- * @memory_type:		type of memory added
- * @overlap_conventional:	region may only overlap free(conventional)
- *				memory
- * Return:			status code
- */
 efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
 				   int memory_type,
 				   bool overlap_conventional)
@@ -381,20 +370,6 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
 	return EFI_SUCCESS;
 }
 
-/**
- * efi_add_memory_map() - add memory area to the memory map
- *
- * @start:		start address of the memory area. Note that this is
- *			actually a pointer provided as an integer. To pass in
- *			an address, pass in (ulong)map_to_sysmem(addr)
- * @size:		length in bytes of the memory area
- * @memory_type:	type of memory added
- *
- * Return:		status code
- *
- * This function automatically aligns the start and size of the memory area
- * to EFI_PAGE_SIZE.
- */
 efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type)
 {
 	u64 pages;
@@ -440,15 +415,6 @@ static efi_status_t efi_check_allocated(u64 addr, bool must_be_allocated)
 	return EFI_NOT_FOUND;
 }
 
-/**
- * efi_allocate_pages - allocate memory pages
- *
- * @type:		type of allocation to be performed
- * @memory_type:	usage type of the allocated memory
- * @pages:		number of pages to be allocated
- * @memory:		allocated memory
- * Return:		status code
- */
 efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 				enum efi_memory_type memory_type,
 				efi_uintn_t pages, uint64_t *memory)
@@ -516,13 +482,6 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 	return EFI_SUCCESS;
 }
 
-/**
- * efi_free_pages() - free memory pages
- *
- * @memory:	start of the memory area to be freed
- * @pages:	number of pages to be freed
- * Return:	status code
- */
 efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
 {
 	u64 len;
@@ -556,14 +515,6 @@ efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
 	return ret;
 }
 
-/**
- * efi_alloc_aligned_pages() - allocate aligned memory pages
- *
- * @len:		len in bytes
- * @memory_type:	usage type of the allocated memory
- * @align:		alignment in bytes
- * Return:		aligned memory or NULL
- */
 void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align)
 {
 	u64 req_pages = efi_size_in_pages(len);
@@ -608,14 +559,6 @@ void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align)
 	return (void *)(uintptr_t)aligned_mem;
 }
 
-/**
- * efi_allocate_pool - allocate memory from pool
- *
- * @pool_type:	type of the pool from which memory is to be allocated
- * @size:	number of bytes to be allocated
- * @buffer:	allocated memory
- * Return:	status code
- */
 efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size, void **buffer)
 {
 	efi_status_t r;
@@ -644,14 +587,6 @@ efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
 	return r;
 }
 
-/**
- * efi_alloc() - allocate boot services data pool memory
- *
- * Allocate memory from pool and zero it out.
- *
- * @size:	number of bytes to allocate
- * Return:	pointer to allocated memory or NULL
- */
 void *efi_alloc(size_t size)
 {
 	void *buf;
@@ -666,12 +601,6 @@ void *efi_alloc(size_t size)
 	return buf;
 }
 
-/**
- * efi_free_pool() - free memory from pool
- *
- * @buffer:	start of memory to be freed
- * Return:	status code
- */
 efi_status_t efi_free_pool(void *buffer)
 {
 	efi_status_t ret;
@@ -793,16 +722,6 @@ efi_status_t efi_get_memory_map_alloc(efi_uintn_t *map_size,
 	return ret;
 }
 
-/**
- * efi_add_known_memory() - add memory types to the EFI memory map
- *
- * This function is to be used to add different memory types other
- * than EFI_CONVENTIONAL_MEMORY to the EFI memory map. The conventional
- * memory is handled by the LMB module and gets added to the memory
- * map through the LMB module.
- *
- * This function may be overridden for architectures specific purposes.
- */
 __weak void efi_add_known_memory(void)
 {
 }
-- 
2.43.0

