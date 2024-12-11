Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B46E77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 02:26:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BE048022E;
	Wed, 11 Dec 2024 03:26:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uBJATvEX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 044428022E; Wed, 11 Dec 2024 03:26:05 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48DF48023A
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 03:25:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3eb4da24f3bso1414243b6e.1
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 18:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733883956; x=1734488756; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZO8TXtqf2xRIVOtoc49ccfZf5XLnyi2rq2LUb4sCKyg=;
 b=uBJATvEXhHm3/PVbkfuPxD1DEMLg9ab3pv3pQ0WoWIY5DfHDIHbCvWyaGmma/2RpBy
 ZgDGYLQ/U2uWD7qfNOCgF51Ai2PlFKRjRzZ5n6rBSgleeBAFDb3E2ldqKsCh4535Jca8
 yOZRNTdU04bnfBG766EP/rGc+QwXJ00lPZNq1V4dxKIR22VIPomGmP4i/7IeR3ixoTU4
 qwflPgt33W2R6PNZz02fyYCKInq+b2wi1Apgehgj0v2ZtLNVoKGcMHbbHa2qXrVR3VZZ
 GnPVEcokVka4MJLA6rmB/mkj2e+806T3v7SAqCiPmaAy81OvHF/M1wlKhzQNlwLomR/a
 If7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733883956; x=1734488756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZO8TXtqf2xRIVOtoc49ccfZf5XLnyi2rq2LUb4sCKyg=;
 b=PDX0kcuMPyMURAqXDNLlwQjbdzYFy0guRdKp2Dt28yF8mfWiOQwwrDWPBZNYVCeB73
 XCWYE6yk9cNr+NONlXhHMSr19pRDoKiTjWn3A/enYkV32tz63Lya2FpcW8fCvHZnryGO
 uK0XF0LvzMPAR/fuOxtI9fmb1ZBHoMGI9gV/g09qaCWcO8Drzcu8v4mGeD6By9g4Fmma
 +SRX6XixJBPzou9VnP7cS3DlIR9uywMDANN0wkiCOyfkckOjldtUNrZkhEkFZC3m9E5i
 f0fW5qHXPsNwS0QSayl/sgWWopI1bGYmxmXBZRk0rHsy/xx4D3FyF8X01PiQ4NJQsA8c
 uMOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcrQE1U8tdZTJmS/d7DOylKbmRp0ndLa2T0XM3JLRMekOyjG5jCJyCfP19MsjoaJr3VWJjnfw=@lists.denx.de
X-Gm-Message-State: AOJu0YyqMs/9ORPbpy2A1xJHhEb7rnIILtGaTaDqQ0RPhN3m5W4/ZYKX
 9qC/R30QqAehI0eMl9joHtF/KlQO7DO3vBva/ciec1RfKfrtYibfxsL87cd9to4=
X-Gm-Gg: ASbGncuwZq+RUtN7PnA05X3A0dDnLDmdjJdSPy0Cfz3WuGKVD/uDFp5RNoyta5DYu49
 CSBp2to4F2gPwfdhSE+vcl8BFew97Kh5s51HHo7sLS5JJg5KjTz+3hr8hQcr0n6mVhtYi1VaAB0
 sbqmcB7IAPQChpIT4hn6LHECmU1usLvaiCrRgEcgUOPS2mI1iV7W8Tf6aLML+wZRi4tyG3FU62F
 PE4QwEBdUa9jF5C0XjaRtDEgE8DlX6w6YVRWV3HYFiUMD8Z4wts7JJLiPc=
X-Google-Smtp-Source: AGHT+IF4qItJtJVX5D54s91Bq5y0QKzbx7fhXWjqGcGdybQ1qKPdzhiGS1M1CvAgtQURU/kKfMvkEw==
X-Received: by 2002:a05:6808:1b2c:b0:3ea:5d19:63c8 with SMTP id
 5614622812f47-3eb85ae336cmr830824b6e.6.1733883955934; 
 Tue, 10 Dec 2024 18:25:55 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e11447b0fsm412398a34.57.2024.12.10.18.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 18:25:55 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Subject: [PATCH v2 4/4] lmb: Improve kernel-doc comments
Date: Tue, 10 Dec 2024 20:25:50 -0600
Message-Id: <20241211022550.2995-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241211022550.2995-1-semen.protsenko@linaro.org>
References: <20241211022550.2995-1-semen.protsenko@linaro.org>
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
documentation [1]:

    Non-trivial functions should have a comment which describes what
    they do. If it is an exported function, put the comment in the
    header file so the API is in one place. If it is a static function,
    put it in the C file.

This also takes care of existing duplication. While at it, do a bit of
cosmetic cleanups as well.

No functional change.

[1] doc/develop/codingstyle.rst

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2:
  - Added Acked-by tag from Ilias
  - Provided the excerpt from U-Boot doc about comments for public API

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
index 40f03151929c..f9880a8dc62b 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -601,14 +601,6 @@ static __maybe_unused void lmb_reserve_common_spl(void)
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
@@ -665,16 +657,6 @@ long lmb_add(phys_addr_t base, phys_size_t size)
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
@@ -782,19 +764,6 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr)
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
@@ -843,18 +812,6 @@ phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size)
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
@@ -927,18 +884,6 @@ static int lmb_setup(bool test)
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

