Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F61C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 13:59:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FC1F882E6;
	Thu, 25 Jul 2024 15:58:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P/7ypQRr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A832880A7; Thu, 25 Jul 2024 15:58:50 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F19DD86463
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 15:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-81f861f369aso5166439f.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 06:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721915926; x=1722520726; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HOkVv/erbmRRf73nbKsYPQhbcZgVrEnGIe1CC/Li+b4=;
 b=P/7ypQRrQ3Nz0p3Uf3JB6O+8srTYVO1LML4i19IgW4cjcWut9/NwvE56rtpmpCrQ2h
 nR5nZSbEu8VlxEhbhT3relWXdbtUOV7ORSJoBTUlJgiHdtX+bBlr2obAF1A74yRI1LAQ
 C+zrXWorYEVjYITLozudEqmt78aqS1UHkq6LA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721915926; x=1722520726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HOkVv/erbmRRf73nbKsYPQhbcZgVrEnGIe1CC/Li+b4=;
 b=h2HgSvJ+sN5x66IdAw+gcsS6SAjZRT8pHZ7yjdyF7NVQXx/zSFBewInYyVdPF6vP8n
 2Dg9VdDgDBMMbItSLG6eEaANvkABCsGuvOn/VRix/Q0rBCO+AvXFVSwIIZyIJPoPhNQd
 01+oyMmbXWFuk7YlyXH58FA2tC9T2xzFmuwOPCHSQFR4KK8lQboWWZKykNPqJo+E6jPZ
 MTT0lzoldYPPhNjrfMVtBmH3J/43Kc72SSQEdpdF2K90E0yfSBVv0PUOUXaoAUqxWT8m
 599OlRyPBLxUs3i9yODYU7HuEJvZ4oZoWyNKV1cuChklOzqHSz9moLvmTSp7AosubWsu
 5WfQ==
X-Gm-Message-State: AOJu0YwidvxNVGNziUDGpAIEuF7iaLS4avw4oSICKlQV82oWrf5DElFR
 FQv67x55xFAU9Yv8I4wyNqtYwrSoL9HqUeVBUtmmi71J7xulT0WJ3mYNZwoD4XVrbUGDeuwt6S4
 =
X-Google-Smtp-Source: AGHT+IFuq88PTHcpWkA8NFVz7saYWRrtuHKosFjsKHRiCjNaUqnCE6Weu/Ia0qbdAPmh7uWEAr9NZQ==
X-Received: by 2002:a05:6e02:12e6:b0:398:a9b3:d6b1 with SMTP id
 e9e14a558f8ab-39a2197a944mr23735685ab.12.1721915926577; 
 Thu, 25 Jul 2024 06:58:46 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a23105f6bsm6015445ab.76.2024.07.25.06.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 06:58:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 5/6] efi: Use malloc() for the EFI pool
Date: Thu, 25 Jul 2024 07:56:28 -0600
Message-Id: <20240725135629.3505072-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240725135629.3505072-1-sjg@chromium.org>
References: <20240725135629.3505072-1-sjg@chromium.org>
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

This API call is intended for allocating small amounts of memory,
similar to malloc(). The current implementation rounds up to whole pages
which can waste large amounts of memory. It also implements its own
malloc()-style header on each block.

Use U-Boot's built-in malloc() instead, to avoid these problems:

- it should normally be large enough for pool allocations
- if it isn't we can enforce a minimum size for boards which use
  EFI_LOADER
- the existing mechanism may create an unwatned entry in the memory map
- it is used for most EFI allocations already

One side effect is that this seems to be showing up some bugs in the
EFI code, since the malloc() pool becomes corrupted with some tests.
This has likely crept in due to the very large gaps between allocations
(around 4KB), which provides a lot of leeway when the allocation size is
too small. Work around this by increasing the size for now, until these
(presumed) bugs are located.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/efi_loader/efi_memory.c | 93 ++++++++-----------------------------
 1 file changed, 19 insertions(+), 74 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 2945f5648c7..fabe9e3a87a 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -80,45 +80,6 @@ static LIST_HEAD(efi_mem);
 void *efi_bounce_buffer;
 #endif
 
-/**
- * struct efi_pool_allocation - memory block allocated from pool
- *
- * @num_pages:	number of pages allocated
- * @checksum:	checksum
- * @data:	allocated pool memory
- *
- * U-Boot services each UEFI AllocatePool() request as a separate
- * (multiple) page allocation. We have to track the number of pages
- * to be able to free the correct amount later.
- *
- * The checksum calculated in function checksum() is used in FreePool() to avoid
- * freeing memory not allocated by AllocatePool() and duplicate freeing.
- *
- * EFI requires 8 byte alignment for pool allocations, so we can
- * prepend each allocation with these header fields.
- */
-struct efi_pool_allocation {
-	u64 num_pages;
-	u64 checksum;
-	char data[] __aligned(ARCH_DMA_MINALIGN);
-};
-
-/**
- * checksum() - calculate checksum for memory allocated from pool
- *
- * @alloc:	allocation header
- * Return:	checksum, always non-zero
- */
-static u64 checksum(struct efi_pool_allocation *alloc)
-{
-	u64 addr = (uintptr_t)alloc;
-	u64 ret = (addr >> 32) ^ (addr << 32) ^ alloc->num_pages ^
-		  EFI_ALLOC_POOL_MAGIC;
-	if (!ret)
-		++ret;
-	return ret;
-}
-
 /**
  * efi_mem_cmp() - comparator function for sorting memory map
  *
@@ -681,13 +642,10 @@ void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align)
  * @buffer:	allocated memory
  * Return:	status code
  */
-efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size, void **buffer)
+efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
+			       void **buffer)
 {
-	efi_status_t r;
-	u64 addr;
-	struct efi_pool_allocation *alloc;
-	u64 num_pages = efi_size_in_pages(size +
-					  sizeof(struct efi_pool_allocation));
+	void *ptr;
 
 	if (!check_allowed())
 		return EFI_UNSUPPORTED;
@@ -700,16 +658,21 @@ efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
 		return EFI_SUCCESS;
 	}
 
-	r = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, pool_type, num_pages,
-			       &addr);
-	if (r == EFI_SUCCESS) {
-		alloc = (struct efi_pool_allocation *)(uintptr_t)addr;
-		alloc->num_pages = num_pages;
-		alloc->checksum = checksum(alloc);
-		*buffer = alloc->data;
-	}
+	/*
+	 * Some tests crash on qemu_arm etc. if the correct size is allocated.
+	 * Adding 0x10 seems to fix test_efi_selftest_device_tree
+	 * Increasing it to 0x20 seems to fix test_efi_selftest_base except
+	 * for riscv64 (in CI only). But 0x100 fixes CI too.
+	 *
+	 * This workaround can be dropped once these problems are resolved
+	 */
+	ptr = memalign(8, size + 0x100);
+	if (!ptr)
+		return EFI_OUT_OF_RESOURCES;
+
+	*buffer = ptr;
 
-	return r;
+	return EFI_SUCCESS;
 }
 
 /**
@@ -742,30 +705,12 @@ void *efi_alloc(size_t size)
  */
 efi_status_t efi_free_pool(void *buffer)
 {
-	efi_status_t ret;
-	struct efi_pool_allocation *alloc;
-
 	if (!buffer)
 		return EFI_INVALID_PARAMETER;
 
-	ret = efi_check_allocated((uintptr_t)buffer, true);
-	if (ret != EFI_SUCCESS)
-		return ret;
-
-	alloc = container_of(buffer, struct efi_pool_allocation, data);
-
-	/* Check that this memory was allocated by efi_allocate_pool() */
-	if (((uintptr_t)alloc & EFI_PAGE_MASK) ||
-	    alloc->checksum != checksum(alloc)) {
-		printf("%s: illegal free 0x%p\n", __func__, buffer);
-		return EFI_INVALID_PARAMETER;
-	}
-	/* Avoid double free */
-	alloc->checksum = 0;
-
-	ret = efi_free_pages((uintptr_t)alloc, alloc->num_pages);
+	free(buffer);
 
-	return ret;
+	return EFI_SUCCESS;
 }
 
 /**
-- 
2.34.1

