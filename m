Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D43DD70DED
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 19:16:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20E8089D8D;
	Thu, 28 Nov 2024 20:13:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RKNC7AwU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A719189D83; Thu, 28 Nov 2024 20:13:46 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09C6A89D20
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 20:13:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-71d4182b2cbso433918a34.2
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732821222; x=1733426022; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jffsvwIiNHvN8VTovz0Ux2tPwq04jROpK9oHA3iO/zk=;
 b=RKNC7AwUEAk8cISjgXLQ5QlXAIrHoIV+2sb6jpJrfdfscihx4mpcLHjiq/9K5QOGRK
 QrvV7HTYmAdo37PDFhlv/NwD3W5oTXhJnrQfR69WnChcZWOyGIvl8TLe+BEu8ndQbJU2
 T/qgPdepj1hPbBz46LpIX6RlNZOcecdLDlNTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732821222; x=1733426022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jffsvwIiNHvN8VTovz0Ux2tPwq04jROpK9oHA3iO/zk=;
 b=ktYnO1fOnDhZtk2ddQJgKAf3CFtL4+CaQ/KGluFX/pnGxwgo0UDMq1tINBgYulJVgu
 +aCup9PX3bRhtxFOZLQcBYc8NP0TmkLphNtWIsofngM1ICNUz8sAUOmmfS+Fx2arXhIC
 AsTRaW+nnHjGY4BY5j4lWSdLsAn40N733ixmv9THOnWTVODbKAzuKqqLoLs27NJjXUYb
 Y+GaEDWvWHKLRXoX/CaVWsF2HW7RLfutlE3r262Sk3le8bsjLvvZNUjby9fF0sizGTxm
 WtDDmREXTFnmOtoVymdJwnkZ5bK2Bla0q1x9lYDZHsXFms6CVCWH32/kPan/I5c4Ur5w
 /wLg==
X-Gm-Message-State: AOJu0YxyBc+Rz26WVUHOoo0HpjlUEXniGK6iy3+NcQYCbDYnfvJW9oCL
 sRPCBi33AhtU6GjaUWozS4LeTUCzNq64+1//eNUE72agLdI1AAOvEA/OuciaGDwKvAWhOai+JbE
 =
X-Gm-Gg: ASbGnculA4k0LVydtXhMxW10t8/ihriqvJq8dsiisy+4ACCyN7qeDL1HQdHB/0diqDd
 ejtU4rjmL9ic6SXVDd+OUkH5b6wkvBugz7vN3WWIFEyhWMB56WPnD0NoH25Fdx6GnijIhh+WYuB
 xkebQH0rEyvajlRGxJi5MtPszrElVB5Eqb8y61+Qf5ehHB46evj/Wa60GHzz3wWYsqpabzdmWMJ
 4FgLtPmdP3H62G+spM6isanqqwPDh0cn1wCleQtz4OIIA==
X-Google-Smtp-Source: AGHT+IEJ8HyCUgid0Wm2jHtgWqZQohs9AGn6q7iNe6q4uzqWeNRHst7pYcg2/dDPfO+JHYzBYZAzzQ==
X-Received: by 2002:a05:6830:6c0d:b0:718:105b:1185 with SMTP id
 46e09a7af769-71d65cb5a56mr7784313a34.14.1732821222113; 
 Thu, 28 Nov 2024 11:13:42 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725d873esm429521a34.54.2024.11.28.11.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 11:13:41 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Janne Grunau <j@jannau.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v3 22/28] efi_loader: Use addresses in efi_memory
Date: Thu, 28 Nov 2024 12:12:38 -0700
Message-Id: <20241128191244.900006-23-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128191244.900006-1-sjg@chromium.org>
References: <20241128191244.900006-1-sjg@chromium.org>
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

The efi_allocate_pool() call uses a pointer to refer to memory, but
efi_allocate_pages() uses an int.

This causes quite a bit of confusion, since sandbox has a distinction
between pointers and addresses.

Adjust efi_allocate/free_pages_ext() to handle the conversions.

For the efi_memory implementation, use addresses, to avoid the messy
conversions.

In general this simplifies the code, but the main benefit is that casts
are no-longer needed in most places, so the compiler can check that we
are doing the right thing.

Update the memset() parameter to be a char while we are here.

This is fix#3/4 for: Update efi_add_memory_map() to use address

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/efi_loader.h              |  4 ++--
 lib/efi_loader/efi_bootmgr.c      |  2 +-
 lib/efi_loader/efi_boottime.c     | 40 ++++++++++++++++++++++---------
 lib/efi_loader/efi_image_loader.c |  3 ++-
 lib/efi_loader/efi_memory.c       | 38 ++++++++++-------------------
 lib/efi_loader/efi_var_mem.c      |  6 ++---
 6 files changed, 49 insertions(+), 44 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index f1ae29b04d7..4e34e1caede 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -786,7 +786,7 @@ void *efi_alloc_aligned_pages(u64 len, enum efi_memory_type mem_type,
  * @type:		type of allocation to be performed
  * @mem_type:		usage type of the allocated memory
  * @pages:		number of pages to be allocated
- * @memoryp:		returns a pointer to the allocated memory
+ * @memoryp:		returns the allocated address
  * Return:		status code
  */
 efi_status_t efi_allocate_pages(enum efi_allocate_type type,
@@ -796,7 +796,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 /**
  * efi_free_pages() - free memory pages
  *
- * @memory:	start of the memory area to be freed
+ * @memory:	start-address of the memory area to be freed
  * @pages:	number of pages to be freed
  * Return:	status code
  */
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index bb635d77b53..b05d7e2ed54 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -1302,7 +1302,7 @@ efi_status_t efi_bootmgr_run(void *fdt)
 	if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {
 		free(fdt_lo);
 		if (fdt_distro)
-			efi_free_pages((uintptr_t)fdt_distro,
+			efi_free_pages(map_to_sysmem(fdt_distro),
 				       efi_size_in_pages(fdt_size));
 	}
 
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 8f311f95d1f..84acf17dc95 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -13,6 +13,7 @@
 #include <irq_func.h>
 #include <log.h>
 #include <malloc.h>
+#include <mapmem.h>
 #include <pe.h>
 #include <time.h>
 #include <u-boot/crc.h>
@@ -416,7 +417,7 @@ static void EFIAPI efi_restore_tpl(efi_uintn_t old_tpl)
  * @type:        type of allocation to be performed
  * @mem_type:    usage type of the allocated memory
  * @pages:       number of pages to be allocated
- * @memoryp:     allocated memory
+ * @memoryp:     allocated memory (a pointer, cast to u64)
  *
  * This function implements the AllocatePages service.
  *
@@ -430,15 +431,25 @@ static efi_status_t EFIAPI efi_allocate_pages_ext(int type, int mem_type,
 						  uint64_t *memoryp)
 {
 	efi_status_t r;
+	u64 addr;
 
 	EFI_ENTRY("%d, %d, 0x%zx, %p", type, mem_type, pages, memoryp);
-	r = efi_allocate_pages(type, mem_type, pages, memoryp);
+	if (!memoryp)
+		return EFI_INVALID_PARAMETER;
+
+	/* we should not read this unless type indicates it is being used */
+	if (type == EFI_ALLOCATE_MAX_ADDRESS || type == EFI_ALLOCATE_ADDRESS)
+		addr = map_to_sysmem((void *)(uintptr_t)*memoryp);
+	r = efi_allocate_pages(type, mem_type, pages, &addr);
+	if (r == EFI_SUCCESS)
+		*memoryp = (uintptr_t)map_sysmem(addr, pages * EFI_PAGE_SIZE);
+
 	return EFI_EXIT(r);
 }
 
 /**
  * efi_free_pages_ext() - Free memory pages.
- * @memory: start of the memory area to be freed
+ * @memory: start of the memory area to be freed (a pointer, cast to u64)
  * @pages:  number of pages to be freed
  *
  * This function implements the FreePages service.
@@ -452,9 +463,12 @@ static efi_status_t EFIAPI efi_free_pages_ext(uint64_t memory,
 					      efi_uintn_t pages)
 {
 	efi_status_t r;
+	u64 addr;
 
 	EFI_ENTRY("%llx, 0x%zx", memory, pages);
-	r = efi_free_pages(memory, pages);
+	addr = map_to_sysmem((void *)(uintptr_t)memory);
+	r = efi_free_pages(addr, pages);
+
 	return EFI_EXIT(r);
 }
 
@@ -1950,8 +1964,9 @@ efi_status_t efi_load_image_from_file(struct efi_device_path *file_path,
 {
 	struct efi_file_handle *f;
 	efi_status_t ret;
-	u64 addr;
 	efi_uintn_t bs;
+	void *buf;
+	u64 addr;
 
 	/* Open file */
 	f = efi_file_from_path(file_path);
@@ -1977,10 +1992,11 @@ efi_status_t efi_load_image_from_file(struct efi_device_path *file_path,
 	}
 
 	/* Read file */
-	EFI_CALL(ret = f->read(f, &bs, (void *)(uintptr_t)addr));
+	buf = map_sysmem(addr, bs);
+	EFI_CALL(ret = f->read(f, &bs, buf));
 	if (ret != EFI_SUCCESS)
 		efi_free_pages(addr, efi_size_in_pages(bs));
-	*buffer = (void *)(uintptr_t)addr;
+	*buffer = buf;
 	*size = bs;
 error:
 	EFI_CALL(f->close(f));
@@ -2011,6 +2027,7 @@ efi_status_t efi_load_image_from_path(bool boot_policy,
 	uint64_t addr, pages;
 	const efi_guid_t *guid;
 	struct efi_handler *handler;
+	void *buf;
 
 	/* In case of failure nothing is returned */
 	*buffer = NULL;
@@ -2049,15 +2066,16 @@ efi_status_t efi_load_image_from_path(bool boot_policy,
 		ret = EFI_OUT_OF_RESOURCES;
 		goto out;
 	}
+	buf = map_sysmem(addr, buffer_size);
 	ret = EFI_CALL(load_file_protocol->load_file(
 					load_file_protocol, rem, boot_policy,
-					&buffer_size, (void *)(uintptr_t)addr));
+					&buffer_size, buf));
 	if (ret != EFI_SUCCESS)
 		efi_free_pages(addr, pages);
 out:
 	efi_close_protocol(device, guid, efi_root, NULL);
 	if (ret == EFI_SUCCESS) {
-		*buffer = (void *)(uintptr_t)addr;
+		*buffer = buf;
 		*size = buffer_size;
 	}
 
@@ -2120,7 +2138,7 @@ efi_status_t EFIAPI efi_load_image(bool boot_policy,
 		ret = efi_load_pe(*image_obj, dest_buffer, source_size, info);
 	if (!source_buffer)
 		/* Release buffer to which file was loaded */
-		efi_free_pages((uintptr_t)dest_buffer,
+		efi_free_pages(map_to_sysmem(dest_buffer),
 			       efi_size_in_pages(source_size));
 	if (ret == EFI_SUCCESS || ret == EFI_SECURITY_VIOLATION) {
 		info->system_table = &systab;
@@ -3321,7 +3339,7 @@ close_next:
 		}
 	}
 
-	efi_free_pages((uintptr_t)loaded_image_protocol->image_base,
+	efi_free_pages(map_to_sysmem(loaded_image_protocol->image_base),
 		       efi_size_in_pages(loaded_image_protocol->image_size));
 	efi_delete_handle(&image_obj->header);
 
diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index 0ddf69a0918..2f2587b32a6 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -13,6 +13,7 @@
 #include <efi_loader.h>
 #include <log.h>
 #include <malloc.h>
+#include <mapmem.h>
 #include <pe.h>
 #include <sort.h>
 #include <crypto/mscode.h>
@@ -970,7 +971,7 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 	/* Run through relocations */
 	if (efi_loader_relocate(rel, rel_size, efi_reloc,
 				(unsigned long)image_base) != EFI_SUCCESS) {
-		efi_free_pages((uintptr_t) efi_reloc,
+		efi_free_pages(map_to_sysmem(efi_reloc),
 			       (virt_size + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT);
 		ret = EFI_LOAD_ERROR;
 		goto err;
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 157ba5ec50c..a33c025fa20 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -36,9 +36,7 @@ efi_uintn_t efi_memory_map_key;
  *
  * @link: Link to prev/next node in list
  * @type: EFI memory-type
- * @base: Start address of region in physical memory. Note that this
- *	is really a pointer stored as an address, so use map_to_sysmem() to
- *	convert it to an address if needed
+ * @base: Start address of region in physical memory
  * @num_pages: Number of EFI pages this record covers (each is EFI_PAGE_SIZE
  *	bytes)
  * @attribute: Memory attributes (see EFI_MEMORY...)
@@ -298,7 +296,7 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
 	if (!newlist)
 		return EFI_OUT_OF_RESOURCES;
 	newlist->type = mem_type;
-	newlist->base = (uintptr_t)map_sysmem(start, pages * EFI_PAGE_SIZE);
+	newlist->base = start;
 	newlist->num_pages = pages;
 
 	switch (mem_type) {
@@ -435,7 +433,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 				enum efi_memory_type mem_type,
 				efi_uintn_t pages, uint64_t *memoryp)
 {
-	u64 efi_addr, len;
+	u64 len;
 	uint flags;
 	efi_status_t ret;
 	phys_addr_t addr;
@@ -462,8 +460,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 		break;
 	case EFI_ALLOCATE_MAX_ADDRESS:
 		/* Max address */
-		addr = map_to_sysmem((void *)(uintptr_t)*memoryp);
-		addr = (u64)lmb_alloc_base_flags(len, EFI_PAGE_SIZE, addr,
+		addr = (u64)lmb_alloc_base_flags(len, EFI_PAGE_SIZE, *memoryp,
 						 flags);
 		if (!addr)
 			return EFI_OUT_OF_RESOURCES;
@@ -472,8 +469,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 		if (*memoryp & EFI_PAGE_MASK)
 			return EFI_NOT_FOUND;
 
-		addr = map_to_sysmem((void *)(uintptr_t)*memoryp);
-		addr = (u64)lmb_alloc_addr_flags(addr, len, flags);
+		addr = (u64)lmb_alloc_addr_flags(*memoryp, len, flags);
 		if (!addr)
 			return EFI_NOT_FOUND;
 		break;
@@ -482,17 +478,15 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 		return EFI_INVALID_PARAMETER;
 	}
 
-	efi_addr = (u64)(uintptr_t)map_sysmem(addr, 0);
 	/* Reserve that map in our memory maps */
-	ret = efi_add_memory_map_pg(efi_addr, pages, mem_type, true);
+	ret = efi_add_memory_map_pg(addr, pages, mem_type, true);
 	if (ret != EFI_SUCCESS) {
 		/* Map would overlap, bail out */
 		lmb_free_flags(addr, (u64)pages << EFI_PAGE_SHIFT, flags);
-		unmap_sysmem((void *)(uintptr_t)efi_addr);
 		return  EFI_OUT_OF_RESOURCES;
 	}
 
-	*memoryp = efi_addr;
+	*memoryp = addr;
 
 	return EFI_SUCCESS;
 }
@@ -515,18 +509,10 @@ efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
 	}
 
 	len = (u64)pages << EFI_PAGE_SHIFT;
-	/*
-	 * The 'memory' variable for sandbox holds a pointer which has already
-	 * been mapped with map_sysmem() from efi_allocate_pages(). Convert
-	 * it back to an address LMB understands
-	 */
-	status = lmb_free_flags(map_to_sysmem((void *)(uintptr_t)memory), len,
-				LMB_NOOVERWRITE);
+	status = lmb_free_flags(memory, len, LMB_NOOVERWRITE);
 	if (status)
 		return EFI_NOT_FOUND;
 
-	unmap_sysmem((void *)(uintptr_t)memory);
-
 	return ret;
 }
 
@@ -551,7 +537,7 @@ void *efi_alloc_aligned_pages(u64 len, enum efi_memory_type mem_type,
 	if (align < EFI_PAGE_SIZE) {
 		r = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, mem_type,
 				       req_pages, &mem);
-		return (r == EFI_SUCCESS) ? (void *)(uintptr_t)mem : NULL;
+		return (r == EFI_SUCCESS) ? map_sysmem(mem, len) : NULL;
 	}
 
 	r = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, mem_type,
@@ -572,7 +558,7 @@ void *efi_alloc_aligned_pages(u64 len, enum efi_memory_type mem_type,
 		efi_free_pages(mem, free_pages);
 	}
 
-	return (void *)(uintptr_t)aligned_mem;
+	return map_sysmem(aligned_mem, len);
 }
 
 efi_status_t efi_allocate_pool(enum efi_memory_type mem_type, efi_uintn_t size,
@@ -595,7 +581,7 @@ efi_status_t efi_allocate_pool(enum efi_memory_type mem_type, efi_uintn_t size,
 	r = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, mem_type, num_pages,
 			       &addr);
 	if (r == EFI_SUCCESS) {
-		alloc = (struct efi_pool_allocation *)(uintptr_t)addr;
+		alloc = map_sysmem(addr, size);
 		alloc->num_pages = num_pages;
 		alloc->checksum = checksum(alloc);
 		*buffer = alloc->data;
@@ -641,7 +627,7 @@ efi_status_t efi_free_pool(void *buffer)
 	/* Avoid double free */
 	alloc->checksum = 0;
 
-	ret = efi_free_pages((uintptr_t)alloc, alloc->num_pages);
+	ret = efi_free_pages(map_to_sysmem(alloc), alloc->num_pages);
 
 	return ret;
 }
diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
index 5c69a1e0f3e..a96a1805865 100644
--- a/lib/efi_loader/efi_var_mem.c
+++ b/lib/efi_loader/efi_var_mem.c
@@ -7,6 +7,7 @@
 
 #include <efi_loader.h>
 #include <efi_variable.h>
+#include <mapmem.h>
 #include <u-boot/crc.h>
 
 /*
@@ -227,9 +228,8 @@ efi_status_t efi_var_mem_init(void)
 	if (ret != EFI_SUCCESS)
 		return ret;
 
-	/* TODO(sjg): This does not work on sandbox */
-	efi_var_buf = (struct efi_var_file *)(uintptr_t)memory;
-	memset(efi_var_buf, 0, EFI_VAR_BUF_SIZE);
+	efi_var_buf = map_sysmem(memory, EFI_VAR_BUF_SIZE);
+	memset(efi_var_buf, '\0', EFI_VAR_BUF_SIZE);
 	efi_var_buf->magic = EFI_VAR_FILE_MAGIC;
 	efi_var_buf->length = (uintptr_t)efi_var_buf->var -
 			      (uintptr_t)efi_var_buf;
-- 
2.34.1

