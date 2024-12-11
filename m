Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8BBE7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 13:55:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E82D98021F;
	Wed, 11 Dec 2024 14:54:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X4SrppjU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80DC68021F; Wed, 11 Dec 2024 14:54:39 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08A2B801CE
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:54:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a7e108b491so52596005ab.3
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 05:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733925275; x=1734530075; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gGPLpQA0q7FmZAC3Mjog4U33Op74zTAxu6Iqbziq+GQ=;
 b=X4SrppjUbeTXF0bpteGYqFtwwjJ87CYlw+XI+HsaSWbPTgPiouc0TYqzJuUnbnNXmE
 fgjrT8nHh6P478V7Hwum9ZgJr+NnqP5rc+9/RnrPNDKc1sqClI4sPqsObYEXO6BBGBUD
 ffgnNOt+VHrBefeqyehZRhoxCR5+XDPfdA1xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733925275; x=1734530075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gGPLpQA0q7FmZAC3Mjog4U33Op74zTAxu6Iqbziq+GQ=;
 b=wy8JFRx5ZDXnZLPqA2R9zdYBe9zjs8RUvIcS6Fr5RLaazwlG5SFfY6tsc9GwmQTpYM
 ftgOgI+icqY4uyxIE7+aF4S6oN8h2+llej5LsglGcddLMcx4nd0TR6jpqxoKgany1cm4
 wCwhtOo2S/6lSpHCC78qM3Pp5b/tGvUeZJva8DIfBqpVxdqGjlIvFgf33JyWlAWDQro0
 E2bUcT0eIeRyxDq5M0/5pglfnGAzyCTEHuqU0HZAQ9EYjCaF6L0SPE67W8dS0+W3oVNe
 GTTbBH2Sgg19vXB551h/xlPpyVYKNl44XklhDz5dj+c8BSz0GsAZ6mXO2JQjwDRFDqzs
 vbJw==
X-Gm-Message-State: AOJu0Yw3MuolnljabF0cItArTty4DTYXFJzHWPZVU6oAauJWV/TOyBmU
 83yq+qp+tchlOZdPhuNRflYSj/8iYCmSorscnIjRyGHV5hnJ40MS0VOCmbDw+4AWnvUjGPxPNHM
 =
X-Gm-Gg: ASbGncvUhJOlKavL8nj+qoU8OhhlyFuxp9DMyVYUVClGtcxEOKzF/q/FK06+pTiZMbr
 MSZPOSpX8X4oLr/bWi8+vtmNdD5nDPkvKK19nz9Bs7KHJT66fJ5erqNHN+t7iqUv4Xip7KYKExP
 sbI05umKIYzXjl8JO62YwWzI2JjzvQd4BPgkO8pEwWXLzRIazW0fmPD5YNMpGcZgN7hIsrjq/I7
 vGD4YQMiR1BFwhDKkxe0IT94J2aw4YeKC/I8SNSRaarLmfXYhSIg92ipd5p+MyD18PIeQ18Safl
 RNcWTImt8Dj1JLI=
X-Google-Smtp-Source: AGHT+IHistVnUmFo+nEQTGdnujIoWdw8ZlqyxmP1arhmb8Oo5c9iliWaX+4eaTW1qhLXnCQUeNHqmg==
X-Received: by 2002:a05:6e02:3283:b0:3a7:e86a:e803 with SMTP id
 e9e14a558f8ab-3aa0616244cmr36381835ab.8.1733925274731; 
 Wed, 11 Dec 2024 05:54:34 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2d46f66f0sm695441173.30.2024.12.11.05.54.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 05:54:33 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v5 06/23] efi_loader: Move some memory-function comments to
 header
Date: Wed, 11 Dec 2024 06:54:00 -0700
Message-Id: <20241211135418.563803-7-sjg@chromium.org>
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
index f1154f73e05..4bc6d12a1fe 100644
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
2.34.1

