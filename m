Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707E8D49779
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:50:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07CC589455;
	Sun,  1 Dec 2024 16:26:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CR0XgHMc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA1CF89455; Sun,  1 Dec 2024 16:26:17 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0096189287
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:26:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-84198253240so123487339f.0
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066770; x=1733671570; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WcCDoOF/e1LA1gPiPmqnSgcXDaVrM/bSqNcexr5tMpA=;
 b=CR0XgHMcgxfOW+8C2mMcBeWbNdMYbuFidgV1hZZjc8lRgx9gsl0UPoz0t3VCX/I2p5
 wi7MqgRvdJ7h10Bs9cTcL6RVu4PkZMlAqvwzPyUJ2Z1YwrTq7qEqm6iuuctIAN2OlCru
 X18ZPocVQNSADR8kVRze+wqXl6p/bS+drPBjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066770; x=1733671570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WcCDoOF/e1LA1gPiPmqnSgcXDaVrM/bSqNcexr5tMpA=;
 b=o+yv9lvFmmUc6VmbJa3VCquI9ESViZHQfp7WRpDIjF8Fky5Y+BB16oZwpuu1mGRqNF
 OJaP7TBVPnWwnHyBvxma0HUHIAZHuWyheKpvwI78yWvRVm46BmUP8xJdfHCvibKubhY+
 pMnaNM6OWAyMu0pCwWDx7QqRI6pSCJHU/VdhwEjFn8ExbHpbK5clzHCpMrNDm3eRiITD
 gDupODEvV+PsVE6NDtK8CxhDMEmKQS5gZnvk+eBxArGXGt5w2L/04U0QPUTCYi+6iwzZ
 BxcfC7TADVbP5DeEDKQxYhzc8P5JYTK4EOkOG7ScvDFMq1Pyrmraw9lQaZSnv6bCKqWk
 dcTg==
X-Gm-Message-State: AOJu0Yy0HrloIct3TENY1XRDHqBe70SUq9LzepUgTXRp9UvybnVRp8JE
 X2fb8xFRNpKjENNkUhLJOFrNtxB/seChNqI+sOJtLscmGMRWMNWmtSvFJdZM307VyUKfHEht9T8
 =
X-Gm-Gg: ASbGncsO5eVvwtD8aIqkvgO5G8HjHNuk0t5D3wAJBKMswJvWsNiv3aCxku7dRcAWSrN
 XugR6BBTEMvORge6Y/VeXoEsdBTI04KHfOxEhkmb8VQjKg01bk8vXtyvrpzrmPP74TnnQK48yij
 7fPci4ntneDf14oRbfM8jVZ1P7Ad6W/U3L2qOkO437PwXAyrD577nJ9DDphUTtu5W5Io9F59Bf5
 SRltG0KbtvUdEEhB0xp0Y3fIyjiBIFyzQ6lnzY/ar7E
X-Google-Smtp-Source: AGHT+IFOB9QwB41hB60vxUOqS08Pos5dVF42RtfGyHOepbWJIuAyfeXRXuGUwekzTGS5a6A72QgvIg==
X-Received: by 2002:a05:6602:342a:b0:835:4cb5:4fa7 with SMTP id
 ca18e2360f4ac-843ed09db4amr2276200439f.12.1733066770135; 
 Sun, 01 Dec 2024 07:26:10 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8d88sm159755239f.19.2024.12.01.07.26.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:26:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Janne Grunau <j@jannau.net>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v4 21/25] efi_loader: Update to use addresses internally
Date: Sun,  1 Dec 2024 08:24:40 -0700
Message-ID: <20241201152505.1666789-22-sjg@chromium.org>
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

This collects together several v3 patches into one, to avoid any
temporary test-breakage which would make future bisecting difficult.

For efi_memory, the efi_allocate_pool() call uses a pointer to refer to
memory, but efi_allocate_pages() uses an int. This causes quite a bit of
confusion, since sandbox has a distinction between pointers and
addresses. Adjust efi_allocate/free_pages_ext() to handle the
conversions.

Update efi_add_memory_map() function and its friend to use an address
rather than a pointer cast to an integer.

For lmb, now that efi_add_memory_map_pg() uses a address rather than a
pointer cast to an int, we can simplify the code here.

For efi_reserve_memory(), use addresses rather than pointers, so that it
doesn't have to use mapmem.

In general this simplifies the code, but the main benefit is that casts
are no-longer needed in most places, so the compiler can check that we
are doing the right thing.

For efi_add_runtime_mmio(), now that efi_add_memory_map() takes an
address rather than a pointer, do the mapping in this function.

Update the memset() parameter to be a char while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Combine the various pointer-to-address patches into one

 include/efi_loader.h              | 15 ++++++------
 lib/efi_loader/efi_bootmgr.c      |  3 ++-
 lib/efi_loader/efi_boottime.c     | 39 ++++++++++++++++++++++---------
 lib/efi_loader/efi_dt_fixup.c     |  4 ----
 lib/efi_loader/efi_image_loader.c |  3 ++-
 lib/efi_loader/efi_memory.c       | 38 ++++++++++--------------------
 lib/efi_loader/efi_runtime.c      |  3 ++-
 lib/efi_loader/efi_var_mem.c      |  6 ++---
 lib/lmb.c                         | 10 +++-----
 9 files changed, 59 insertions(+), 62 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 4c346addae3..4e34e1caede 100644
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
@@ -834,9 +834,9 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
 /**
  * efi_add_memory_map() - add memory area to the memory map
  *
- * @start:		start address of the memory area. Note that this is
- *			actually a pointer provided as an integer. To pass in
- *			an address, pass in (ulong)map_to_sysmem(addr)
+ * @start:		start address, must be a multiple of EFI_PAGE_SIZE. Note
+ *			that this is an address, not a pointer. Use
+ *			map_to_sysmem(ptr) if you need to pass in a pointer
  * @size:		length in bytes of the memory area
  * @mem_type:		EFI type of memory added
  * Return:		status code
@@ -851,9 +851,8 @@ efi_status_t efi_add_memory_map(u64 start, u64 size,
  * efi_add_memory_map_pg() - add pages to the memory map
  *
  * @start: start address, must be a multiple of EFI_PAGE_SIZE. Note that this
- * is actually a pointer provided as an integer. To pass in an address, pass
- * in (ulong)map_to_sysmem(addr)
- *
+ *	is an address, not a pointer. Use map_to_sysmem(ptr) if you need to pass
+ *	in a pointer
  * @pages:			number of pages to add
  * @mem_type:		EFI type of memory added
  * @overlap_conventional:	region may only overlap free(conventional)
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index bb635d77b53..30d4ce09e7e 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -14,6 +14,7 @@
 #include <efi.h>
 #include <log.h>
 #include <malloc.h>
+#include <mapmem.h>
 #include <net.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
@@ -1302,7 +1303,7 @@ efi_status_t efi_bootmgr_run(void *fdt)
 	if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {
 		free(fdt_lo);
 		if (fdt_distro)
-			efi_free_pages((uintptr_t)fdt_distro,
+			efi_free_pages(map_to_sysmem(fdt_distro),
 				       efi_size_in_pages(fdt_size));
 	}
 
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 3ea239fda41..e81a6d38db8 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -417,7 +417,7 @@ static void EFIAPI efi_restore_tpl(efi_uintn_t old_tpl)
  * @type:        type of allocation to be performed
  * @mem_type:    usage type of the allocated memory
  * @pages:       number of pages to be allocated
- * @memoryp:     allocated memory
+ * @memoryp:     allocated memory (a pointer, cast to u64)
  *
  * This function implements the AllocatePages service.
  *
@@ -431,15 +431,25 @@ static efi_status_t EFIAPI efi_allocate_pages_ext(int type, int mem_type,
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
@@ -453,9 +463,12 @@ static efi_status_t EFIAPI efi_free_pages_ext(uint64_t memory,
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
 
@@ -1951,8 +1964,9 @@ efi_status_t efi_load_image_from_file(struct efi_device_path *file_path,
 {
 	struct efi_file_handle *f;
 	efi_status_t ret;
-	u64 addr;
 	efi_uintn_t bs;
+	void *buf;
+	u64 addr;
 
 	/* Open file */
 	f = efi_file_from_path(file_path);
@@ -1978,10 +1992,11 @@ efi_status_t efi_load_image_from_file(struct efi_device_path *file_path,
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
@@ -2012,6 +2027,7 @@ efi_status_t efi_load_image_from_path(bool boot_policy,
 	uint64_t addr, pages;
 	const efi_guid_t *guid;
 	struct efi_handler *handler;
+	void *buf;
 
 	/* In case of failure nothing is returned */
 	*buffer = NULL;
@@ -2050,15 +2066,16 @@ efi_status_t efi_load_image_from_path(bool boot_policy,
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
 
@@ -2121,7 +2138,7 @@ efi_status_t EFIAPI efi_load_image(bool boot_policy,
 		ret = efi_load_pe(*image_obj, dest_buffer, source_size, info);
 	if (!source_buffer)
 		/* Release buffer to which file was loaded */
-		efi_free_pages((uintptr_t)dest_buffer,
+		efi_free_pages(map_to_sysmem(dest_buffer),
 			       efi_size_in_pages(source_size));
 	if (ret == EFI_SUCCESS || ret == EFI_SECURITY_VIOLATION) {
 		info->system_table = &systab;
@@ -3322,7 +3339,7 @@ close_next:
 		}
 	}
 
-	efi_free_pages((uintptr_t)loaded_image_protocol->image_base,
+	efi_free_pages(map_to_sysmem(loaded_image_protocol->image_base),
 		       efi_size_in_pages(loaded_image_protocol->image_size));
 	efi_delete_handle(&image_obj->header);
 
diff --git a/lib/efi_loader/efi_dt_fixup.c b/lib/efi_loader/efi_dt_fixup.c
index 0dac94b0c6c..72d5d432a42 100644
--- a/lib/efi_loader/efi_dt_fixup.c
+++ b/lib/efi_loader/efi_dt_fixup.c
@@ -9,7 +9,6 @@
 #include <efi_loader.h>
 #include <efi_rng.h>
 #include <fdtdec.h>
-#include <mapmem.h>
 
 const efi_guid_t efi_guid_dt_fixup_protocol = EFI_DT_FIXUP_PROTOCOL_GUID;
 
@@ -26,9 +25,6 @@ static void efi_reserve_memory(u64 addr, u64 size, bool nomap)
 	int type;
 	efi_uintn_t ret;
 
-	/* Convert from sandbox address space. */
-	addr = (uintptr_t)map_sysmem(addr, 0);
-
 	if (nomap)
 		type = EFI_RESERVED_MEMORY_TYPE;
 	else
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
index b3ba67413ee..5a6794652d1 100644
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
@@ -626,7 +612,7 @@ efi_status_t efi_free_pool(void *buffer)
 	if (!buffer)
 		return EFI_INVALID_PARAMETER;
 
-	ret = efi_check_allocated((uintptr_t)buffer, true);
+	ret = efi_check_allocated(map_to_sysmem(buffer), true);
 	if (ret != EFI_SUCCESS)
 		return ret;
 
@@ -641,7 +627,7 @@ efi_status_t efi_free_pool(void *buffer)
 	/* Avoid double free */
 	alloc->checksum = 0;
 
-	ret = efi_free_pages((uintptr_t)alloc, alloc->num_pages);
+	ret = efi_free_pages(map_to_sysmem(alloc), alloc->num_pages);
 
 	return ret;
 }
diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
index 9d3b940afbd..37ed5963e2b 100644
--- a/lib/efi_loader/efi_runtime.c
+++ b/lib/efi_loader/efi_runtime.c
@@ -13,6 +13,7 @@
 #include <efi_variable.h>
 #include <log.h>
 #include <malloc.h>
+#include <mapmem.h>
 #include <rtc.h>
 #include <asm/global_data.h>
 #include <u-boot/crc.h>
@@ -930,7 +931,7 @@ out:
 efi_status_t efi_add_runtime_mmio(void **mmio_ptr, u64 len)
 {
 	struct efi_runtime_mmio_list *newmmio;
-	uint64_t addr = *(uintptr_t *)mmio_ptr;
+	u64 addr = map_to_sysmem(*mmio_ptr);
 	efi_status_t ret;
 
 	ret = efi_add_memory_map(addr, len, EFI_MMAP_IO);
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
diff --git a/lib/lmb.c b/lib/lmb.c
index 14b9b8466ff..588787d2a90 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -10,7 +10,6 @@
 #include <efi_loader.h>
 #include <event.h>
 #include <image.h>
-#include <mapmem.h>
 #include <lmb.h>
 #include <log.h>
 #include <malloc.h>
@@ -448,7 +447,6 @@ static bool lmb_should_notify(enum lmb_flags flags)
 static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size, u8 op,
 				 enum lmb_flags flags)
 {
-	u64 efi_addr;
 	u64 pages;
 	efi_status_t status;
 
@@ -460,11 +458,10 @@ static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size, u8 op,
 	if (!lmb_should_notify(flags))
 		return 0;
 
-	efi_addr = (uintptr_t)map_sysmem(addr, 0);
-	pages = efi_size_in_pages(size + (efi_addr & EFI_PAGE_MASK));
-	efi_addr &= ~EFI_PAGE_MASK;
+	pages = efi_size_in_pages(size + (addr & EFI_PAGE_MASK));
+	addr &= ~EFI_PAGE_MASK;
 
-	status = efi_add_memory_map_pg(efi_addr, pages,
+	status = efi_add_memory_map_pg(addr, pages,
 				       op == MAP_OP_RESERVE ?
 				       EFI_BOOT_SERVICES_DATA :
 				       EFI_CONVENTIONAL_MEMORY,
@@ -474,7 +471,6 @@ static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size, u8 op,
 			status & ~EFI_ERROR_MASK);
 		return -1;
 	}
-	unmap_sysmem((void *)(uintptr_t)efi_addr);
 
 	return 0;
 }
-- 
2.43.0

