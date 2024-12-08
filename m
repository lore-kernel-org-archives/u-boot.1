Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C738E7717D
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 00:22:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98563893D2;
	Sun,  8 Dec 2024 01:21:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xDgoHR7J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C4C3893D1; Sun,  8 Dec 2024 01:21:34 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFDA9893D2
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 01:21:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-71d4e043dd9so848992a34.1
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 16:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733617289; x=1734222089; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JhFAzQ+/yM6WDEQKu66WaKVE6rQil2zKHC0dyZ9PH3w=;
 b=xDgoHR7JpRrM5IGDoKlWJ+sVxTM0/FyMxI3Wgu7eZaaYXjq3KJiJr+E0j/9KbwrpC8
 bV/R/abW56D8XxgipRhje/9bA4Z6Y9aKBZMIvNPZP634G+ugWfxrTwpOP2Ep4glbXQkF
 DBQ6dxQ+dPr1D3ecOoMSmaBUBrS5jTWozsGE8xdH6kW4vDi5n0qLivKImt8helwMIL3a
 0EGycsbzxvspLLlGg83x9vileWlvlFE0B6BXjBmKJzOB3uMSMSKtgCd17MTEkztFQwab
 fNr0Og7P3vn7YOTMybeHm1bnY6mQzUYf/dPJ9d0cZql8OU+eBusCWXHH0pKLDaqiHhPD
 20Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733617289; x=1734222089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JhFAzQ+/yM6WDEQKu66WaKVE6rQil2zKHC0dyZ9PH3w=;
 b=MLevwB4Q1fcE6FdVGD9h/ak0ZghMdw9hykfNexVVJkSvZt3eUiZt6d0qyzSv+OBIQQ
 cM/zL+gJ5efo1gX5eiMmhS93h5ZfOfMr14gtO22C4oXOtq5f8SZPKzPwcU2zE6fLfvvX
 my82Xmcpx97OvS0/Zv6VA4TUtt0n01IfXUZo3nWTmYuh59xmxBhS2jMNRkWg9tdOaLDu
 BkMaWM5ABGYrMf43bBaJCFi1RaTKRH0GAgrkwWFSU2fQX/ZP0Lou1msp/ZCDMtnj/0+Y
 4rqHk9tT1UDO8hli7zkmHpN0cntDr7oN2JEgmc/g4zXCwkCY0X4YsoHDd8lJeoOtB4AA
 wqLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTKcVaTl9GmOvThBF14mgds5ZtrD4qSKqxDpAUwHxdBD37VMTU5ctkItoF4d3r3UEwUazfErk=@lists.denx.de
X-Gm-Message-State: AOJu0Yxss0xkhQmgc5mJIMAH+lmKzjxGxOM+5j3gJsF3oujt/wMt0Tr9
 Z1uiGT+TrS+8zUwrn7Fw9gS6pAe6VMfb3ykab/9eeRhIWwEbhzozhJLixqShc2U=
X-Gm-Gg: ASbGncvglVgezSeKdishMTlC1KSOZ9B21mIMS0BmNwCCR0U/o6gbEwTwI3OFLTcGXS0
 tTX3EA0AmEYtNK/o/9v7R3Ngq+ioXA8um8CPaJa4QTOt7/lnkiaRwPU1q+KDCYR3LEtrts0SR4m
 poMCwl4RJb4RMVj8+dm/YiJLQ3um/KNAT6M7mZe+0dGAUStN5xYRmhCf5ThwReQ7lUvuoqUZjpC
 mBYfbc77Ilhx3yHAnLxXdtIwtnnIHt/cTL5U3WYZN2tZSR9ClhzJ30=
X-Google-Smtp-Source: AGHT+IHzudUzfr+o7iglss7DzBzENuOasgJU1mgqQgrcPJ+4wrbUGS09H65kHbUAwfs7mDzoYRQKTw==
X-Received: by 2002:a9d:6a50:0:b0:71d:eb02:bae8 with SMTP id
 46e09a7af769-71deb02be26mr182603a34.8.1733617289471; 
 Sat, 07 Dec 2024 16:21:29 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc4a02827sm1544052a34.55.2024.12.07.16.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 16:21:28 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Subject: [PATCH 5/6] lmb: Improve kernel-doc comments
Date: Sat,  7 Dec 2024 18:21:20 -0600
Message-Id: <20241208002121.31887-6-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241208002121.31887-1-semen.protsenko@linaro.org>
References: <20241208002121.31887-1-semen.protsenko@linaro.org>
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

Fix warnings from kernel-doc script. Improve and unify overall style of
kernel-doc comments in lmb source files. Move all kernel-doc comments
for public functions into the header, as recommended in U-Boot
documentation, which also takes care of existing duplication. While at
it, do a bit of cosmetic cleanups as well.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 include/lmb.h | 125 ++++++++++++++++++++++++++++++--------------------
 lib/lmb.c     |  55 ----------------------
 2 files changed, 74 insertions(+), 106 deletions(-)

diff --git a/include/lmb.h b/include/lmb.h
index f221f0cce8f7..03d5fac6aa79 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -1,6 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Logical memory blocks.
+ *
+ * Copyright (C) 2001 Peter Bergner, IBM Corp.
+ */
+
 #ifndef _LINUX_LMB_H
 #define _LINUX_LMB_H
+
 #ifdef __KERNEL__
 
 #include <alist.h>
@@ -8,21 +15,15 @@
 #include <asm/u-boot.h>
 #include <linux/bitops.h>
 
-/*
- * Logical memory blocks.
- *
- * Copyright (C) 2001 Peter Bergner, IBM Corp.
- */
-
-#define LMB_ALLOC_ANYWHERE      0
-#define LMB_ALIST_INITIAL_SIZE  4
+#define LMB_ALLOC_ANYWHERE	0
+#define LMB_ALIST_INITIAL_SIZE	4
 
 /**
- * enum lmb_flags - definition of memory region attributes
- * @LMB_NONE: no special request
- * @LMB_NOMAP: don't add to mmu configuration
- * @LMB_NOOVERWRITE: the memory region cannot be overwritten/re-reserved
- * @LMB_NONOTIFY: do not notify other modules of changes to this memory region
+ * enum lmb_flags - Definition of memory region attributes
+ * @LMB_NONE: No special request
+ * @LMB_NOMAP: Don't add to MMU configuration
+ * @LMB_NOOVERWRITE: The memory region cannot be overwritten/re-reserved
+ * @LMB_NONOTIFY: Do not notify other modules of changes to this memory region
  */
 enum lmb_flags {
 	LMB_NONE		= 0,
@@ -32,11 +33,10 @@ enum lmb_flags {
 };
 
 /**
- * struct lmb_region - Description of one region.
- *
- * @base:	Base address of the region.
- * @size:	Size of the region
- * @flags:	memory region attributes
+ * struct lmb_region - Description of one region
+ * @base: Base address of the region
+ * @size: Size of the region
+ * @flags: Memory region attributes
  */
 struct lmb_region {
 	phys_addr_t base;
@@ -46,10 +46,9 @@ struct lmb_region {
 
 /**
  * struct lmb - The LMB structure
- *
- * @free_mem:	List of free memory regions
- * @used_mem:	List of used/reserved memory regions
- * @test:	Is structure being used for LMB tests
+ * @free_mem: List of free memory regions
+ * @used_mem: List of used/reserved memory regions
+ * @test: Is structure being used for LMB tests
  */
 struct lmb {
 	struct alist free_mem;
@@ -58,51 +57,77 @@ struct lmb {
 };
 
 /**
- * lmb_init() - Initialise the LMB module
+ * lmb_init() - Initialise the LMB module.
+ *
+ * Return: 0 on success, negative error code on failure.
  *
  * Initialise the LMB lists needed for keeping the memory map. There
- * are two lists, in form of alloced list data structure. One for the
+ * are two lists, in form of allocated list data structure. One for the
  * available memory, and one for the used memory. Initialise the two
  * lists as part of board init. Add memory to the available memory
  * list and reserve common areas by adding them to the used memory
  * list.
- *
- * Return: 0 on success, -ve on error
  */
 int lmb_init(void);
 
 /**
- * lmb_add_memory() - Add memory range for LMB allocations
+ * lmb_add_memory() - Add memory range for LMB allocations.
  *
  * Add the entire available memory range to the pool of memory that
  * can be used by the LMB module for allocations.
- *
- * Return: None
  */
 void lmb_add_memory(void);
 
 long lmb_add(phys_addr_t base, phys_size_t size);
-long lmb_reserve(phys_addr_t base, phys_size_t size);
+
 /**
- * lmb_reserve_flags - Reserve one region with a specific flags bitfield.
+ * lmb_reserve() - Reserve a memory region (with no special flags)
+ * @base: Base address of the memory region
+ * @size: Size of the memory region
  *
- * @base:	base address of the memory region
- * @size:	size of the memory region
- * @flags:	flags for the memory region
- * Return:	0 if OK, > 0 for coalesced region or a negative error code.
+ * Return: 0 on success, negative error code on failure.
+ */
+long lmb_reserve(phys_addr_t base, phys_size_t size);
+
+/**
+ * lmb_reserve_flags() - Reserve one region with a specific flags bitfield
+ * @base: Base address of the memory region
+ * @size: Size of the memory region
+ * @flags: Flags for the memory region
+ *
+ * Return:
+ * * %0		- Added successfully, or it's already added (only if LMB_NONE)
+ * * %-EEXIST	- The region is already added, and flags != LMB_NONE
+ * * %-1	- Failure
  */
 long lmb_reserve_flags(phys_addr_t base, phys_size_t size,
 		       enum lmb_flags flags);
+
 phys_addr_t lmb_alloc(phys_size_t size, ulong align);
 phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr);
 phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size);
 phys_size_t lmb_get_free_size(phys_addr_t addr);
 
+/**
+ * lmb_alloc_base_flags() - Allocate specified memory region with specified
+ *			    attributes
+ * @size: Size of the region requested
+ * @align: Alignment of the memory region requested
+ * @max_addr: Maximum address of the requested region
+ * @flags: Memory region attributes to be set
+ *
+ * Allocate a region of memory with the attributes specified through the
+ * parameter. The max_addr parameter is used to specify the maximum address
+ * below which the requested region should be allocated.
+ *
+ * Return: Base address on success, 0 on error.
+ */
 phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
 				 phys_addr_t max_addr, uint flags);
 
 /**
- * lmb_alloc_addr_flags() - Allocate specified memory address with specified attributes
+ * lmb_alloc_addr_flags() - Allocate specified memory address with specified
+ *			    attributes
  * @base: Base Address requested
  * @size: Size of the region requested
  * @flags: Memory region attributes to be set
@@ -111,20 +136,21 @@ phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
  * parameter. The base parameter is used to specify the base address
  * of the requested region.
  *
- * Return: base address on success, 0 on error
+ * Return: Base address on success, 0 on error.
  */
 phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
 				 uint flags);
 
 /**
- * lmb_is_reserved_flags() - test if address is in reserved region with flag bits set
+ * lmb_is_reserved_flags() - Test if address is in reserved region with flag
+ *			     bits set
+ * @addr: Address to be tested
+ * @flags: Bitmap with bits to be tested
  *
  * The function checks if a reserved region comprising @addr exists which has
  * all flag bits set which are set in @flags.
  *
- * @addr:	address to be tested
- * @flags:	bitmap with bits to be tested
- * Return:	1 if matching reservation exists, 0 otherwise
+ * Return: 1 if matching reservation exists, 0 otherwise.
  */
 int lmb_is_reserved_flags(phys_addr_t addr, int flags);
 
@@ -134,9 +160,7 @@ int lmb_is_reserved_flags(phys_addr_t addr, int flags);
  * @size: Size of the region to be freed
  * @flags: Memory region attributes
  *
- * Free up a region of memory.
- *
- * Return: 0 if successful, -1 on failure
+ * Return: 0 on success, negative error code on failure.
  */
 long lmb_free_flags(phys_addr_t base, phys_size_t size, uint flags);
 
@@ -160,7 +184,7 @@ static inline int lmb_read_check(phys_addr_t addr, phys_size_t len)
  * io_lmb_setup() - Initialize LMB struct
  * @io_lmb: IO LMB to initialize
  *
- * Returns: 0 on success, negative error code on failure
+ * Return: 0 on success, negative error code on failure.
  */
 int io_lmb_setup(struct lmb *io_lmb);
 
@@ -178,12 +202,13 @@ void io_lmb_teardown(struct lmb *io_lmb);
  *
  * Add the IOVA space [base, base + size] to be managed by io_lmb.
  *
- * Returns: 0 if the region addition was successful, -1 on failure
+ * Return: 0 on success, negative error code on failure.
  */
 long io_lmb_add(struct lmb *io_lmb, phys_addr_t base, phys_size_t size);
 
 /**
- * io_lmb_alloc() - Allocate specified IO memory address with specified alignment
+ * io_lmb_alloc() - Allocate specified IO memory address with specified
+ *		    alignment
  * @io_lmb: LMB to alloc from
  * @size: Size of the region requested
  * @align: Required address and size alignment
@@ -191,7 +216,7 @@ long io_lmb_add(struct lmb *io_lmb, phys_addr_t base, phys_size_t size);
  * Allocate a region of IO memory. The base parameter is used to specify the
  * base address of the requested region.
  *
- * Return: base IO address on success, 0 on error
+ * Return: Base IO address on success, 0 on error.
  */
 phys_addr_t io_lmb_alloc(struct lmb *io_lmb, phys_size_t size, ulong align);
 
@@ -201,9 +226,7 @@ phys_addr_t io_lmb_alloc(struct lmb *io_lmb, phys_size_t size, ulong align);
  * @base: Base Address of region to be freed
  * @size: Size of the region to be freed
  *
- * Free up a region of IOVA space.
- *
- * Return: 0 if successful, -1 on failure
+ * Return: 0 on success, negative error code on failure.
  */
 long io_lmb_free(struct lmb *io_lmb, phys_addr_t base, phys_size_t size);
 
diff --git a/lib/lmb.c b/lib/lmb.c
index 8c1c9b0f67c8..eee3bd37d446 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -609,14 +609,6 @@ static __maybe_unused void lmb_reserve_common_spl(void)
 	}
 }
 
-/**
- * lmb_add_memory() - Add memory range for LMB allocations
- *
- * Add the entire available memory range to the pool of memory that
- * can be used by the LMB module for allocations.
- *
- * Return: None
- */
 void lmb_add_memory(void)
 {
 	int i;
@@ -673,16 +665,6 @@ long lmb_add(phys_addr_t base, phys_size_t size)
 	return lmb_map_update_notify(base, size, MAP_OP_ADD, LMB_NONE);
 }
 
-/**
- * lmb_free_flags() - Free up a region of memory
- * @base: Base Address of region to be freed
- * @size: Size of the region to be freed
- * @flags: Memory region attributes
- *
- * Free up a region of memory.
- *
- * Return: 0 if successful, negative error code on failure
- */
 long lmb_free_flags(phys_addr_t base, phys_size_t size,
 		    uint flags)
 {
@@ -790,19 +772,6 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr)
 	return alloc;
 }
 
-/**
- * lmb_alloc_base_flags() - Allocate specified memory region with specified attributes
- * @size: Size of the region requested
- * @align: Alignment of the memory region requested
- * @max_addr: Maximum address of the requested region
- * @flags: Memory region attributes to be set
- *
- * Allocate a region of memory with the attributes specified through the
- * parameter. The max_addr parameter is used to specify the maximum address
- * below which the requested region should be allocated.
- *
- * Return: base address on success, 0 on error
- */
 phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
 				 phys_addr_t max_addr, uint flags)
 {
@@ -851,18 +820,6 @@ phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size)
 	return _lmb_alloc_addr(base, size, LMB_NONE);
 }
 
-/**
- * lmb_alloc_addr_flags() - Allocate specified memory address with specified attributes
- * @base: Base Address requested
- * @size: Size of the region requested
- * @flags: Memory region attributes to be set
- *
- * Allocate a region of memory with the attributes specified through the
- * parameter. The base parameter is used to specify the base address
- * of the requested region.
- *
- * Return: base address on success, 0 on error
- */
 phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
 				 uint flags)
 {
@@ -935,18 +892,6 @@ static int lmb_setup(bool test)
 	return 0;
 }
 
-/**
- * lmb_init() - Initialise the LMB module
- *
- * Initialise the LMB lists needed for keeping the memory map. There
- * are two lists, in form of alloced list data structure. One for the
- * available memory, and one for the used memory. Initialise the two
- * lists as part of board init. Add memory to the available memory
- * list and reserve common areas by adding them to the used memory
- * list.
- *
- * Return: 0 on success, -ve on error
- */
 int lmb_init(void)
 {
 	int ret;
-- 
2.39.5

