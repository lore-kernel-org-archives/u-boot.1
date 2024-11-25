Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E914D59D6C
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 20:46:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EA2289A8A;
	Mon, 25 Nov 2024 21:45:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Bjx/NSVW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9FEE89A81; Mon, 25 Nov 2024 21:45:37 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E386489A76
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 21:45:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-84198252db1so42047239f.0
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 12:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732567533; x=1733172333; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RaQ/IWUwcpDbFA81Lj3qyfMtQ/oVETmZJYHtIGTsT4E=;
 b=Bjx/NSVWNjaSaMRBd8i6KE+2QPrQSTtsQsHXxrLA/7YdvwCBsayVZM04ya8yxsX7p9
 DVjiRmbbmPC4A9FETNvLg5OPK8vVvjkM0XkQA1CMqnfAj4nW0DuCFELYJ4mKEsdlMzIw
 degmsnugDKEFGMigE69ByV7oaE5DKAwwVAqqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732567533; x=1733172333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RaQ/IWUwcpDbFA81Lj3qyfMtQ/oVETmZJYHtIGTsT4E=;
 b=HM8lH7vihP1OttoZ5++9fvaHWGdxv/pW/DyssKLFLi32SasHC8MgIJ0zzgCzhGxmJU
 Ylrh4jOc6eIFvNXVTc/Ucxe62S4guY4fQ+v8ZPIujPWuixNB/i8NZ0r2NXrIJ9Erzzst
 3Ti6AMbTkMYQVIlj8wGo/dbSmHPnApRbde9jiow8azuyXOYuHrp9MQ9bxEED1shVPUWg
 vHlcqgVQ1G5Evrh4i3/ldhDLeP9tDGL0QYVI2Mgbt/F/HQ6l6vvYfJObHqfUfAQ9mdTM
 7jZMPCYvWp3sZdsqzmPRCXf5qI7CVEauEiHdoUv9JG8x8mhA/Rbwl1zPWCcuPU2PVvXW
 UQMQ==
X-Gm-Message-State: AOJu0YzgHOqXfg6qL5fT+/fuIB8OUhGVvrY0GldFFR2Hd8BjqXy+hwT8
 /UiWACkRTBxYOwqdw5xef7/rTJj+TeKrXz35DzRklnhu2N2l6YQ/Qz4dRJnq+pVXt6mbj3E4eZc
 =
X-Gm-Gg: ASbGnct3+SqyetqtE38ALAy3Yb9m2DMqcUdrV/+K6m7cq8wweTUo9j2wks9jv9J5BPS
 VxiFgKej30al8trUuAGFCgPKSMpamljfx6Gwh5NkbkKX7U4yqec9m545PeXp8JuyyxPgmYrJ4+1
 c4mjSUh6pNxIg9Yhx4ojX96Kk7dq32d2yovj83MyDQ6Q05ftyjpK//IMnKMsIlTIM5yoIyDUZ1G
 cSZPma+n0/VidJ5AvzD48VOtwtMyK0SiHezffVRipZ2HHc=
X-Google-Smtp-Source: AGHT+IF1LgJDoEbVWkBGNoDRU8J2E9NUng9uzB4F/RWOKf2AVyPfsRyraQJA51JFlz8U0JzPbpGmBw==
X-Received: by 2002:a05:6602:6d0c:b0:7f6:8489:2679 with SMTP id
 ca18e2360f4ac-843d7d76087mr93740639f.8.1732567532945; 
 Mon, 25 Nov 2024 12:45:32 -0800 (PST)
Received: from chromium.org ([50.235.115.130])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-841ac8403a2sm26134639f.9.2024.11.25.12.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 12:45:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Janne Grunau <j@jannau.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 08/13] efi_loader: Tidy up use of addresses
Date: Mon, 25 Nov 2024 13:44:47 -0700
Message-ID: <20241125204456.1525752-9-sjg@chromium.org>
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

The EFI loader's memory implementation is quite confusing. The EFI spec
requires that addresses are used in the calls to allocate_pages(), etc.
This is unavoidable.

This usage then filters down to various functions within the
implementation. This is unfortunate, as there is no clear separation
between addresses and pointers. In some parts of the code things become
hopelessly confusing, and several bugs have crept in.

Adjust the internal functions to always use a ulong for an address or a
void * for a pointer.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/efi_loader.h              | 13 +++--
 lib/efi_loader/efi_bootmgr.c      |  9 ++--
 lib/efi_loader/efi_boottime.c     | 37 ++++++++------
 lib/efi_loader/efi_helper.c       |  7 +--
 lib/efi_loader/efi_image_loader.c |  2 +-
 lib/efi_loader/efi_memory.c       | 84 +++++++++++++------------------
 lib/efi_loader/efi_var_mem.c      |  6 +--
 7 files changed, 76 insertions(+), 82 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index cae94fc4661..c4afcf2b60b 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -791,7 +791,7 @@ void *efi_alloc_aligned_pages(u64 len, enum efi_memory_type mem_type,
  */
 efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 				enum efi_memory_type mem_type,
-				efi_uintn_t pages, uint64_t *memoryp);
+				efi_uintn_t pages, void **memoryp);
 
 /**
  * efi_free_pages() - free memory pages
@@ -800,7 +800,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
  * @pages:	number of pages to be freed
  * Return:	status code
  */
-efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages);
+efi_status_t efi_free_pages(void *memory, efi_uintn_t pages);
 
 /**
  * efi_allocate_pool - allocate memory from pool
@@ -833,7 +833,9 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
 
 /**
  * efi_add_memory_map() - Add a range into the EFI memory map
- * @start: start address, must be a multiple of EFI_PAGE_SIZE
+ * @start: start address, must be a multiple of EFI_PAGE_SIZE. Note that this
+ *	is an address, not a pointer. Use map_sysmem(start) to convert to a
+ *	pointer
  * @size: Size, in bytes
  * @mem_type: EFI type of memory added
  * Return: status code
@@ -844,8 +846,9 @@ efi_status_t efi_add_memory_map(ulong start, ulong size,
 /**
  * efi_add_memory_map_pg() - add pages to the memory map
  *
- * @start:			start address, must be a multiple of
- *				EFI_PAGE_SIZE
+ * @start: start address, must be a multiple of EFI_PAGE_SIZE. Note that this
+ *	is an address, not a pointer. Use map_sysmem(start) to convert to a
+ *	pointer
  * @pages:			number of pages to add
  * @mem_type:		EFI type of memory added
  * @overlap_conventional:	region may only overlap free(conventional)
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 8c51a6ef2ed..9e42fa03921 100644
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
@@ -497,6 +498,7 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 	 * If the file is PE-COFF image, load the downloaded file.
 	 */
 	uri_len = strlen(uridp->uri);
+	source_buffer = map_sysmem(image_addr, image_size);
 	if (!strncmp(&uridp->uri[uri_len - 4], ".iso", 4) ||
 	    !strncmp(&uridp->uri[uri_len - 4], ".img", 4)) {
 		ret = prepare_loaded_image(lo_label, image_addr, image_size,
@@ -506,7 +508,8 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 
 		source_buffer = NULL;
 		source_size = 0;
-	} else if (efi_check_pe((void *)image_addr, image_size, NULL) == EFI_SUCCESS) {
+	} else if (efi_check_pe(source_buffer, image_size, NULL) ==
+			EFI_SUCCESS) {
 		/*
 		 * loaded_dp must exist until efi application returns,
 		 * will be freed in return_to_efibootmgr event callback.
@@ -518,7 +521,6 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 		if (ret != EFI_SUCCESS)
 			goto err;
 
-		source_buffer = (void *)image_addr;
 		source_size = image_size;
 	} else {
 		log_err("Error: file type is not supported\n");
@@ -1297,8 +1299,7 @@ efi_status_t efi_bootmgr_run(void *fdt)
 	if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {
 		free(fdt_lo);
 		if (fdt_distro)
-			efi_free_pages((uintptr_t)fdt_distro,
-				       efi_size_in_pages(fdt_size));
+			efi_free_pages(fdt_distro, efi_size_in_pages(fdt_size));
 	}
 
 	if (ret != EFI_SUCCESS) {
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index efd9577c9d0..5ad80ff49cb 100644
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
@@ -431,9 +432,15 @@ static efi_status_t EFIAPI efi_allocate_pages_ext(enum efi_allocate_type type,
 						  uint64_t *memoryp)
 {
 	efi_status_t r;
+	void *ptr;
 
+	/* we should not read this unless type indicates it is being used */
+	if (type == EFI_ALLOCATE_MAX_ADDRESS || type == EFI_ALLOCATE_ADDRESS)
+		ptr = (void *)(ulong)*memoryp;
 	EFI_ENTRY("%d, %d, 0x%zx, %p", type, mem_type, pages, memoryp);
-	r = efi_allocate_pages(type, mem_type, pages, memoryp);
+	r = efi_allocate_pages(type, mem_type, pages, &ptr);
+	*memoryp = (ulong)ptr;
+
 	return EFI_EXIT(r);
 }
 
@@ -455,7 +462,7 @@ static efi_status_t EFIAPI efi_free_pages_ext(uint64_t memory,
 	efi_status_t r;
 
 	EFI_ENTRY("%llx, 0x%zx", memory, pages);
-	r = efi_free_pages(memory, pages);
+	r = efi_free_pages((void *)(ulong)memory, pages);
 	return EFI_EXIT(r);
 }
 
@@ -1951,8 +1958,8 @@ efi_status_t efi_load_image_from_file(struct efi_device_path *file_path,
 {
 	struct efi_file_handle *f;
 	efi_status_t ret;
-	u64 addr;
 	efi_uintn_t bs;
+	void *ptr;
 
 	/* Open file */
 	f = efi_file_from_path(file_path);
@@ -1971,17 +1978,17 @@ efi_status_t efi_load_image_from_file(struct efi_device_path *file_path,
 	 */
 	ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
 				 EFI_BOOT_SERVICES_DATA,
-				 efi_size_in_pages(bs), &addr);
+				 efi_size_in_pages(bs), &ptr);
 	if (ret != EFI_SUCCESS) {
 		ret = EFI_OUT_OF_RESOURCES;
 		goto error;
 	}
 
 	/* Read file */
-	EFI_CALL(ret = f->read(f, &bs, (void *)(uintptr_t)addr));
+	EFI_CALL(ret = f->read(f, &bs, ptr));
 	if (ret != EFI_SUCCESS)
-		efi_free_pages(addr, efi_size_in_pages(bs));
-	*buffer = (void *)(uintptr_t)addr;
+		efi_free_pages(ptr, efi_size_in_pages(bs));
+	*buffer = ptr;
 	*size = bs;
 error:
 	EFI_CALL(f->close(f));
@@ -2009,9 +2016,10 @@ efi_status_t efi_load_image_from_path(bool boot_policy,
 	struct efi_device_path *dp, *rem;
 	struct efi_load_file_protocol *load_file_protocol = NULL;
 	efi_uintn_t buffer_size;
-	uint64_t addr, pages;
+	ulong pages;
 	const efi_guid_t *guid;
 	struct efi_handler *handler;
+	void *ptr;
 
 	/* In case of failure nothing is returned */
 	*buffer = NULL;
@@ -2045,20 +2053,20 @@ efi_status_t efi_load_image_from_path(bool boot_policy,
 		goto out;
 	pages = efi_size_in_pages(buffer_size);
 	ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, EFI_BOOT_SERVICES_DATA,
-				 pages, &addr);
+				 pages, &ptr);
 	if (ret != EFI_SUCCESS) {
 		ret = EFI_OUT_OF_RESOURCES;
 		goto out;
 	}
 	ret = EFI_CALL(load_file_protocol->load_file(
 					load_file_protocol, rem, boot_policy,
-					&buffer_size, (void *)(uintptr_t)addr));
+					&buffer_size, ptr));
 	if (ret != EFI_SUCCESS)
-		efi_free_pages(addr, pages);
+		efi_free_pages(ptr, pages);
 out:
 	efi_close_protocol(device, guid, efi_root, NULL);
 	if (ret == EFI_SUCCESS) {
-		*buffer = (void *)(uintptr_t)addr;
+		*buffer = ptr;
 		*size = buffer_size;
 	}
 
@@ -2121,8 +2129,7 @@ efi_status_t EFIAPI efi_load_image(bool boot_policy,
 		ret = efi_load_pe(*image_obj, dest_buffer, source_size, info);
 	if (!source_buffer)
 		/* Release buffer to which file was loaded */
-		efi_free_pages((uintptr_t)dest_buffer,
-			       efi_size_in_pages(source_size));
+		efi_free_pages(dest_buffer, efi_size_in_pages(source_size));
 	if (ret == EFI_SUCCESS || ret == EFI_SECURITY_VIOLATION) {
 		info->system_table = &systab;
 		info->parent_handle = parent_image;
@@ -3322,7 +3329,7 @@ close_next:
 		}
 	}
 
-	efi_free_pages((uintptr_t)loaded_image_protocol->image_base,
+	efi_free_pages(loaded_image_protocol->image_base,
 		       efi_size_in_pages(loaded_image_protocol->image_size));
 	efi_delete_handle(&image_obj->header);
 
diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index bf96f61d3d0..1c264eabff9 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -456,7 +456,6 @@ static efi_status_t copy_fdt(void **fdtp)
 	unsigned long fdt_ram_start = -1L, fdt_pages;
 	efi_status_t ret = 0;
 	void *fdt, *new_fdt;
-	u64 new_fdt_addr;
 	uint fdt_size;
 	int i;
 
@@ -480,17 +479,15 @@ static efi_status_t copy_fdt(void **fdtp)
 	fdt_size = fdt_pages << EFI_PAGE_SHIFT;
 
 	ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
-				 EFI_ACPI_RECLAIM_MEMORY, fdt_pages,
-				 &new_fdt_addr);
+				 EFI_ACPI_RECLAIM_MEMORY, fdt_pages, &new_fdt);
 	if (ret != EFI_SUCCESS) {
 		log_err("Failed to reserve space for FDT\n");
 		goto done;
 	}
-	new_fdt = (void *)(uintptr_t)new_fdt_addr;
 	memcpy(new_fdt, fdt, fdt_totalsize(fdt));
 	fdt_set_totalsize(new_fdt, fdt_size);
 
-	*fdtp = (void *)(uintptr_t)new_fdt_addr;
+	*fdtp = new_fdt;
 done:
 	return ret;
 }
diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index 0ddf69a0918..9bd77048adf 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -970,7 +970,7 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 	/* Run through relocations */
 	if (efi_loader_relocate(rel, rel_size, efi_reloc,
 				(unsigned long)image_base) != EFI_SUCCESS) {
-		efi_free_pages((uintptr_t) efi_reloc,
+		efi_free_pages(efi_reloc,
 			       (virt_size + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT);
 		ret = EFI_LOAD_ERROR;
 		goto err;
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 4e9c372b622..f687e49c98e 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -418,9 +418,9 @@ static efi_status_t efi_check_allocated(ulong addr, bool must_be_allocated)
 
 efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 				enum efi_memory_type mem_type,
-				efi_uintn_t pages, uint64_t *memory)
+				efi_uintn_t pages, void **memoryp)
 {
-	ulong efi_addr, len;
+	ulong len;
 	uint flags;
 	efi_status_t ret;
 	phys_addr_t addr;
@@ -428,7 +428,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 	/* Check import parameters */
 	if (mem_type >= EFI_PERSISTENT_MEMORY_TYPE && mem_type <= 0x6fffffff)
 		return EFI_INVALID_PARAMETER;
-	if (!memory)
+	if (!memoryp)
 		return EFI_INVALID_PARAMETER;
 	len = (ulong)pages << EFI_PAGE_SHIFT;
 	/* Catch possible overflow on 64bit systems */
@@ -447,18 +447,18 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 		break;
 	case EFI_ALLOCATE_MAX_ADDRESS:
 		/* Max address */
-		addr = map_to_sysmem((void *)(uintptr_t)*memory);
+		addr = map_to_sysmem(*memoryp);
 		addr = (u64)lmb_alloc_base_flags(len, EFI_PAGE_SIZE, addr,
 						 flags);
 		if (!addr)
 			return EFI_OUT_OF_RESOURCES;
 		break;
 	case EFI_ALLOCATE_ADDRESS:
-		if (*memory & EFI_PAGE_MASK)
+		addr = map_to_sysmem(*memoryp);
+		if (addr & EFI_PAGE_MASK)
 			return EFI_NOT_FOUND;
 
-		addr = map_to_sysmem((void *)(uintptr_t)*memory);
-		addr = (u64)lmb_alloc_addr_flags(addr, len, flags);
+		addr = lmb_alloc_addr_flags(addr, len, flags);
 		if (!addr)
 			return EFI_NOT_FOUND;
 		break;
@@ -467,42 +467,33 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
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
-		return  EFI_OUT_OF_RESOURCES;
+		return EFI_OUT_OF_RESOURCES;
 	}
 
-	*memory = efi_addr;
+	*memoryp = map_sysmem(addr, len);
 
 	return EFI_SUCCESS;
 }
 
-/**
- * efi_free_pages() - free memory pages
- *
- * @memory:	start of the memory area to be freed
- * @pages:	number of pages to be freed
- * Return:	status code
- */
-efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
+efi_status_t efi_free_pages(void *memory, efi_uintn_t pages)
 {
-	ulong len;
+	ulong addr, len;
 	long status;
 	efi_status_t ret;
 
-	ret = efi_check_allocated(memory, true);
+	addr = map_to_sysmem(memory);
+	ret = efi_check_allocated(addr, true);
 	if (ret != EFI_SUCCESS)
 		return ret;
 
 	/* Sanity check */
-	if (!memory || (memory & EFI_PAGE_MASK) || !pages) {
-		printf("%s: illegal free 0x%llx, 0x%zx\n", __func__,
-		       memory, pages);
+	if (!addr || (addr & EFI_PAGE_MASK) || !pages) {
+		printf("%s: illegal free %lx, %zx\n", __func__, addr, pages);
 		return EFI_INVALID_PARAMETER;
 	}
 
@@ -512,12 +503,11 @@ efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
 	 * been mapped with map_sysmem() from efi_allocate_pages(). Convert
 	 * it back to an address LMB understands
 	 */
-	status = lmb_free_flags(map_to_sysmem((void *)(uintptr_t)memory), len,
-				LMB_NOOVERWRITE);
+	status = lmb_free_flags(map_to_sysmem(memory), len, LMB_NOOVERWRITE);
 	if (status)
 		return EFI_NOT_FOUND;
 
-	unmap_sysmem((void *)(uintptr_t)memory);
+	unmap_sysmem(memory);
 
 	return ret;
 }
@@ -528,9 +518,9 @@ void *efi_alloc_aligned_pages(u64 len, enum efi_memory_type mem_type,
 	ulong req_pages = efi_size_in_pages(len);
 	ulong true_pages = req_pages + efi_size_in_pages(align) - 1;
 	ulong free_pages;
-	ulong aligned_mem;
+	void *aligned_ptr;
 	efi_status_t r;
-	u64 mem;
+	void *ptr;
 
 	/* align must be zero or a power of two */
 	if (align & (align - 1))
@@ -542,35 +532,35 @@ void *efi_alloc_aligned_pages(u64 len, enum efi_memory_type mem_type,
 
 	if (align < EFI_PAGE_SIZE) {
 		r = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, mem_type,
-				       req_pages, &mem);
-		return (r == EFI_SUCCESS) ? (void *)(uintptr_t)mem : NULL;
+				       req_pages, &ptr);
+		return (r == EFI_SUCCESS) ? ptr : NULL;
 	}
 
 	r = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, mem_type,
-			       true_pages, &mem);
+			       true_pages, &ptr);
 	if (r != EFI_SUCCESS)
 		return NULL;
 
-	aligned_mem = ALIGN(mem, align);
+	aligned_ptr = (void *)ALIGN((ulong)ptr, align);
 	/* Free pages before alignment */
-	free_pages = efi_size_in_pages(aligned_mem - mem);
+	free_pages = efi_size_in_pages(aligned_ptr - ptr);
 	if (free_pages)
-		efi_free_pages(mem, free_pages);
+		efi_free_pages(ptr, free_pages);
 
 	/* Free trailing pages */
 	free_pages = true_pages - (req_pages + free_pages);
 	if (free_pages) {
-		mem = aligned_mem + req_pages * EFI_PAGE_SIZE;
-		efi_free_pages(mem, free_pages);
+		ptr = aligned_ptr + req_pages * EFI_PAGE_SIZE;
+		efi_free_pages(ptr, free_pages);
 	}
 
-	return (void *)(uintptr_t)aligned_mem;
+	return aligned_ptr;
 }
 
 efi_status_t efi_allocate_pool(enum efi_memory_type mem_type, efi_uintn_t size, void **buffer)
 {
 	efi_status_t r;
-	u64 addr;
+	void *ptr;
 	struct efi_pool_allocation *alloc;
 	ulong num_pages = efi_size_in_pages(size +
 					  sizeof(struct efi_pool_allocation));
@@ -584,9 +574,9 @@ efi_status_t efi_allocate_pool(enum efi_memory_type mem_type, efi_uintn_t size,
 	}
 
 	r = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, mem_type, num_pages,
-			       &addr);
+			       &ptr);
 	if (r == EFI_SUCCESS) {
-		alloc = (struct efi_pool_allocation *)(uintptr_t)addr;
+		alloc = ptr;
 		alloc->num_pages = num_pages;
 		alloc->checksum = checksum(alloc);
 		*buffer = alloc->data;
@@ -617,7 +607,7 @@ efi_status_t efi_free_pool(void *buffer)
 	if (!buffer)
 		return EFI_INVALID_PARAMETER;
 
-	ret = efi_check_allocated((uintptr_t)buffer, true);
+	ret = efi_check_allocated(map_to_sysmem(buffer), true);
 	if (ret != EFI_SUCCESS)
 		return ret;
 
@@ -632,7 +622,7 @@ efi_status_t efi_free_pool(void *buffer)
 	/* Avoid double free */
 	alloc->checksum = 0;
 
-	ret = efi_free_pages((uintptr_t)alloc, alloc->num_pages);
+	ret = efi_free_pages(alloc, alloc->num_pages);
 
 	return ret;
 }
@@ -788,14 +778,10 @@ int efi_memory_init(void)
 
 #ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
 	/* Request a 32bit 64MB bounce buffer region */
-	uint64_t efi_bounce_buffer_addr = 0xffffffff;
-
 	if (efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS, EFI_BOOT_SERVICES_DATA,
 			       (64 * 1024 * 1024) >> EFI_PAGE_SHIFT,
-			       &efi_bounce_buffer_addr) != EFI_SUCCESS)
+			       &efi_bounce_buffer) != EFI_SUCCESS)
 		return -1;
-
-	efi_bounce_buffer = (void*)(uintptr_t)efi_bounce_buffer_addr;
 #endif
 
 	return 0;
diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
index 139e16aad7c..f3f8a25642d 100644
--- a/lib/efi_loader/efi_var_mem.c
+++ b/lib/efi_loader/efi_var_mem.c
@@ -216,17 +216,17 @@ efi_var_mem_notify_virtual_address_map(struct efi_event *event, void *context)
 
 efi_status_t efi_var_mem_init(void)
 {
-	u64 memory;
+	void *ptr;
 	efi_status_t ret;
 	struct efi_event *event;
 
 	ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
 				 EFI_RUNTIME_SERVICES_DATA,
 				 efi_size_in_pages(EFI_VAR_BUF_SIZE),
-				 &memory);
+				 &ptr);
 	if (ret != EFI_SUCCESS)
 		return ret;
-	efi_var_buf = (struct efi_var_file *)(uintptr_t)memory;
+	efi_var_buf = ptr;
 	memset(efi_var_buf, 0, EFI_VAR_BUF_SIZE);
 	efi_var_buf->magic = EFI_VAR_FILE_MAGIC;
 	efi_var_buf->length = (uintptr_t)efi_var_buf->var -
-- 
2.43.0

