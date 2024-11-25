Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A460FD59D6B
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 20:46:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0ABF89301;
	Mon, 25 Nov 2024 21:45:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZEBgDiGk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FDAE89251; Mon, 25 Nov 2024 21:45:34 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B76BF89A6C
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 21:45:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-84197b4e61aso53151039f.3
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 12:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732567530; x=1733172330; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ZehVI5HOmPAcnWd+7U7gBq0KHKVkEB160U25USk02I=;
 b=ZEBgDiGkJq4mShJo0gUIDUN5CmUUxG9mIHei+NPwZdU4pTHNIfd+AIJPdEyalHPu/W
 kd2NZZI6fnn1350ZxeJTm2n0x4McGK2+YRJwvuCzw9hmrj89XgTdLqy4gSRZltMwxI0V
 CX8DJppd/cUt8DfIIZJzp/7iu8yXhXqG1lUOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732567530; x=1733172330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4ZehVI5HOmPAcnWd+7U7gBq0KHKVkEB160U25USk02I=;
 b=Jb4OeL0I3o9d8jq1HtE36fgkdA79eaNlilrb1iGwQwYnwC2pV2gG8Rq097j7ecA4bQ
 bc5N1+LAf/Cm/7tlTMO49Vu4/L1i56gXkJew80hTYDxKYruTB++/bge6q/+G6u2m4g2X
 UILKI8FdRxgAxAx+aumyCtxwCoU8jogxchj/Yf3hdzcC9nUbVP287HNc0lpbgUBf2dez
 D+i6h1d+Su3QIhfnufbZPI1z1Q/hREBduXGpXd0TqicZkeBzlLN97+duabr3cZgNm+te
 2W5hq46Gq4mIu5n60wucmoGuce7HceHIld+bF4dOX+wU5yUdFKu5JVKt1oMHrDRFHCMF
 ogsQ==
X-Gm-Message-State: AOJu0YwjbIOlrGJjmJkQCTQ5Lpq5PGe6LmQRmoPiLmnZI95YUtETc0Id
 INf6e2bus6jN0kEYQSoz/yUneEWSd8kV/D2wD0weF2bHW+FYqn71inN2A0ifPUPLZsOkgDRXuqE
 =
X-Gm-Gg: ASbGncutineNekiJA2bO2IJmEogNSTkH2WRKAzHOPGgfPscmuuIaswje9Xzf82F3RxI
 qad6AhyEsm+QQF67lQbZB6sB9I+rb9Z4YiD0eQmsUkU+BZsINPy6nYvDp1jU5LOAdg0NxkDp3VI
 ZzSOVfS5fsy368qFkBMFDLJAVDSZoG1CDJN8R6FqCCwm4U+7fh7zSuW1nyzNZEfj8xqF665GAXK
 2R7uPd+TFK/x2tzjkk38eIB1goHhgNrDezguzYmZh/TUgo=
X-Google-Smtp-Source: AGHT+IG0mBLQMpVb5BD7e4Us86I0vgYqwj9XxtnzN38wSGmVq/8DmCvdXt0qJTEMVEVIZpVNwxO5NA==
X-Received: by 2002:a05:6602:29d4:b0:83a:a746:68a6 with SMTP id
 ca18e2360f4ac-83ecdc611d1mr1723406039f.5.1732567529981; 
 Mon, 25 Nov 2024 12:45:29 -0800 (PST)
Received: from chromium.org ([50.235.115.130])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-841ac8403a2sm26134639f.9.2024.11.25.12.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 12:45:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 07/13] efi_loader: Make more use of ulong
Date: Mon, 25 Nov 2024 13:44:46 -0700
Message-ID: <20241125204456.1525752-8-sjg@chromium.org>
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

One of the confusing parts of the EFI loader is that it uses u64 for
addresses, whereas the rest of U-Boot typically uses ulong.

There is a case on 32-bit machines where phys_addr_t can be larger than
32 bits, but this is very much the exception. Also, such machines have
mostly faded away and generally don't make use of EFI.

So in the interests of consistency, update the memory functions to use
ulong in most cases.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/efi_loader.h        |  4 ++--
 lib/efi_loader/efi_memory.c | 42 ++++++++++++++++++-------------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 0ef4c6f7dea..cae94fc4661 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -838,7 +838,7 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
  * @mem_type: EFI type of memory added
  * Return: status code
  */
-efi_status_t efi_add_memory_map(u64 start, u64 size,
+efi_status_t efi_add_memory_map(ulong start, ulong size,
 				enum efi_memory_type mem_type);
 
 /**
@@ -852,7 +852,7 @@ efi_status_t efi_add_memory_map(u64 start, u64 size,
  *				memory
  * Return:			status code
  */
-efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
+efi_status_t efi_add_memory_map_pg(ulong start, ulong pages,
 				   enum efi_memory_type mem_type,
 				   bool overlap_conventional);
 
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 2c46915e5b9..4e9c372b622 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -199,10 +199,10 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
 {
 	struct efi_mem_list *newmap;
 	struct efi_mem_desc *map_desc = &map->desc;
-	uint64_t map_start = map_desc->physical_start;
-	uint64_t map_end = map_start + (map_desc->num_pages << EFI_PAGE_SHIFT);
-	uint64_t carve_start = carve_desc->physical_start;
-	uint64_t carve_end = carve_start +
+	ulong map_start = map_desc->physical_start;
+	ulong map_end = map_start + (map_desc->num_pages << EFI_PAGE_SHIFT);
+	ulong carve_start = carve_desc->physical_start;
+	ulong carve_end = carve_start +
 			     (carve_desc->num_pages << EFI_PAGE_SHIFT);
 
 	/* check whether we're overlapping */
@@ -257,17 +257,17 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
 	return EFI_CARVE_LOOP_AGAIN;
 }
 
-efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
+efi_status_t efi_add_memory_map_pg(ulong start, ulong pages,
 				   enum efi_memory_type mem_type,
 				   bool overlap_conventional)
 {
 	struct efi_mem_list *lmem;
 	struct efi_mem_list *newlist;
 	bool carve_again;
-	uint64_t carved_pages = 0;
+	ulong carved_pages = 0;
 	struct efi_event *evt;
 
-	EFI_PRINT("%s: 0x%llx 0x%llx %d %s\n", __func__,
+	EFI_PRINT("%s: 0x%lx 0x%lx %d %s\n", __func__,
 		  start, pages, mem_type, overlap_conventional ?
 		  "yes" : "no");
 
@@ -370,10 +370,10 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
 	return EFI_SUCCESS;
 }
 
-efi_status_t efi_add_memory_map(u64 start, u64 size,
+efi_status_t efi_add_memory_map(ulong start, ulong size,
 				enum efi_memory_type mem_type)
 {
-	u64 pages;
+	ulong pages;
 
 	pages = efi_size_in_pages(size + (start & EFI_PAGE_MASK));
 	start &= ~EFI_PAGE_MASK;
@@ -396,13 +396,13 @@ efi_status_t efi_add_memory_map(u64 start, u64 size,
  * @must_be_allocated:	return success if the page is allocated
  * Return:		status code
  */
-static efi_status_t efi_check_allocated(u64 addr, bool must_be_allocated)
+static efi_status_t efi_check_allocated(ulong addr, bool must_be_allocated)
 {
 	struct efi_mem_list *item;
 
 	list_for_each_entry(item, &efi_mem, link) {
-		u64 start = item->desc.physical_start;
-		u64 end = start + (item->desc.num_pages << EFI_PAGE_SHIFT);
+		ulong start = item->desc.physical_start;
+		ulong end = start + (item->desc.num_pages << EFI_PAGE_SHIFT);
 
 		if (addr >= start && addr < end) {
 			if (must_be_allocated ^
@@ -420,7 +420,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 				enum efi_memory_type mem_type,
 				efi_uintn_t pages, uint64_t *memory)
 {
-	u64 efi_addr, len;
+	ulong efi_addr, len;
 	uint flags;
 	efi_status_t ret;
 	phys_addr_t addr;
@@ -430,7 +430,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 		return EFI_INVALID_PARAMETER;
 	if (!memory)
 		return EFI_INVALID_PARAMETER;
-	len = (u64)pages << EFI_PAGE_SHIFT;
+	len = (ulong)pages << EFI_PAGE_SHIFT;
 	/* Catch possible overflow on 64bit systems */
 	if (sizeof(efi_uintn_t) == sizeof(u64) &&
 	    (len >> EFI_PAGE_SHIFT) != (u64)pages)
@@ -491,7 +491,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
  */
 efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
 {
-	u64 len;
+	ulong len;
 	long status;
 	efi_status_t ret;
 
@@ -506,7 +506,7 @@ efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
 		return EFI_INVALID_PARAMETER;
 	}
 
-	len = (u64)pages << EFI_PAGE_SHIFT;
+	len = (ulong)pages << EFI_PAGE_SHIFT;
 	/*
 	 * The 'memory' variable for sandbox holds a pointer which has already
 	 * been mapped with map_sysmem() from efi_allocate_pages(). Convert
@@ -525,10 +525,10 @@ efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
 void *efi_alloc_aligned_pages(u64 len, enum efi_memory_type mem_type,
 			      size_t align)
 {
-	u64 req_pages = efi_size_in_pages(len);
-	u64 true_pages = req_pages + efi_size_in_pages(align) - 1;
-	u64 free_pages;
-	u64 aligned_mem;
+	ulong req_pages = efi_size_in_pages(len);
+	ulong true_pages = req_pages + efi_size_in_pages(align) - 1;
+	ulong free_pages;
+	ulong aligned_mem;
 	efi_status_t r;
 	u64 mem;
 
@@ -572,7 +572,7 @@ efi_status_t efi_allocate_pool(enum efi_memory_type mem_type, efi_uintn_t size,
 	efi_status_t r;
 	u64 addr;
 	struct efi_pool_allocation *alloc;
-	u64 num_pages = efi_size_in_pages(size +
+	ulong num_pages = efi_size_in_pages(size +
 					  sizeof(struct efi_pool_allocation));
 
 	if (!buffer)
-- 
2.43.0

