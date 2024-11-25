Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B02D59D6C
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 20:45:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0924189A7D;
	Mon, 25 Nov 2024 21:45:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y0fjSb6S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F8B889A89; Mon, 25 Nov 2024 21:45:28 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB44189251
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 21:45:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-84197b4e61aso53147239f.3
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 12:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732567524; x=1733172324; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zdwYsvXjQCF3CrvMPxr1AMePKZkMfA0NKI7XMYkrJXY=;
 b=Y0fjSb6S2ZD0keqEPS9vKpNaVjGkDW1yAsTHRIfKBdAUES0TPT59Pl2n2ZrR4tg+SV
 UoQh+0ih2YBU6NZI9UkDzENTHDx3Qvnf1DeWHPQQzFTxqolzos1KPDxa+Gz2wjH/BUCj
 CC2nMqPHRLwNEcGBWeSnoxFWAlXfGSsvmT/ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732567524; x=1733172324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zdwYsvXjQCF3CrvMPxr1AMePKZkMfA0NKI7XMYkrJXY=;
 b=aHPi8rX/I1MxEi5PoKtncBmIkLAx3fF1ej4zWXhJwreFk9lqmJCGvPwqMV1L2huqv0
 um4VML6CIWqjBtET6Anm9KN1BZ2jnalrPT9zEmzyhk2ScA06ayJFTIHLUWbWFJBhehfW
 xFBgqUj250LLPRLV3hr7KJ9hrIFKESl14yEX6Vxa6sV9MdHDAfsyIpbBwT+9OqTuN34z
 puHEHSBkQ8Kg1kLHvNZmUUzTGhPCx+TdnyYikRXt80GjOCG0wxpBWdvv1TGJLz8+dCbV
 DcqgZ9dzqclu2j8JrauHvCekNbR2NywGk4F+HZ1BCdAQgOBU1PO3XoUW5szyZh4xAaoF
 /BNQ==
X-Gm-Message-State: AOJu0YynOh+Qo/irPKC0YyQhRGfVJkNIpObyIXmo25vvYOJtV+d3bNFu
 XeKY3jQ1UYEeC32W7DytnL+8EYVBRoxn7OKEe1OHp2j5owUNnU0oLK/hcbnjbGvDdp2OcELANqA
 =
X-Gm-Gg: ASbGncvdf+URHTGq0vPu17d9qilNrHgbZMY6j/h9wS1ZhS5CXBvwXk1c7jodFtFPPpk
 zkVAZ8KpwB+jTXNEdS0oFwrPz0Bb3aRhioXw3xeVUK1g2DUwyacsXtDn3VAgX5Q5Ni+9yeFzXpj
 VN/MvCLXiPUcHZRm5gOqTtYB+TYz/mu9gd17eer/yGwsOxYBITC/vMxKv7KOuA8M09ogu8Qjhy6
 Z+MJ2WYI7AlaH5Fw2PPni7fgaNWoOp7rUq5oxR7uaanKQA=
X-Google-Smtp-Source: AGHT+IEF9xb1b9yNWV/Mp7ZlQoRJkFspecvAPNUj/8Dy8trQqo3vT8C4XChmiI8WpxAbibpKZAkYpQ==
X-Received: by 2002:a05:6602:6d84:b0:82a:9cab:9be1 with SMTP id
 ca18e2360f4ac-83ecdd0962emr1458246839f.12.1732567524058; 
 Mon, 25 Nov 2024 12:45:24 -0800 (PST)
Received: from chromium.org ([50.235.115.130])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-841ac8403a2sm26134639f.9.2024.11.25.12.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 12:45:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 05/13] efi_loader: Move some memory-function comments to header
Date: Mon, 25 Nov 2024 13:44:44 -0700
Message-ID: <20241125204456.1525752-6-sjg@chromium.org>
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

Exported functions should be documented in the header file, not the
implementation. We tend to make such updates on a piecemeal basis to
avoid a 'flag day'. Move some comments related to memory allocation to
follow the convention.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/efi_loader.h        | 70 ++++++++++++++++++++++++++++++++-----
 lib/efi_loader/efi_memory.c | 62 --------------------------------
 2 files changed, 62 insertions(+), 70 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 39809eac1bc..ff7adc1e2a2 100644
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
@@ -782,7 +829,14 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
 				efi_uintn_t *map_key,
 				efi_uintn_t *descriptor_size,
 				uint32_t *descriptor_version);
-/* Adds a range into the EFI memory map */
+
+/**
+ * efi_add_memory_map() - Add a range into the EFI memory map
+ * @start: start address, must be a multiple of EFI_PAGE_SIZE
+ * @size: Size, in bytes
+ * @memory_type: EFI type of memory added
+ * Return: status code
+ */
 efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
 
 /**
@@ -791,7 +845,7 @@ efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
  * @start:			start address, must be a multiple of
  *				EFI_PAGE_SIZE
  * @pages:			number of pages to add
- * @memory_type:		type of memory added
+ * @memory_type:		EFI type of memory added
  * @overlap_conventional:	region may only overlap free(conventional)
  *				memory
  * Return:			status code
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 8b01821a993..7c8d9485094 100644
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
@@ -381,18 +370,6 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
 	return EFI_SUCCESS;
 }
 
-/**
- * efi_add_memory_map() - add memory area to the memory map
- *
- * @start:		start address of the memory area
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
@@ -438,15 +415,6 @@ static efi_status_t efi_check_allocated(u64 addr, bool must_be_allocated)
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
@@ -554,14 +522,6 @@ efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
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
@@ -606,14 +566,6 @@ void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align)
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
@@ -642,14 +594,6 @@ efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
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
@@ -664,12 +608,6 @@ void *efi_alloc(size_t size)
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
-- 
2.43.0

