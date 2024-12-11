Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45437E77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 13:57:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65E418036E;
	Wed, 11 Dec 2024 14:55:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SRlwe1oR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4068D803A9; Wed, 11 Dec 2024 14:55:02 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 820A4800C2
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:54:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-844d5444b3dso4637839f.1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 05:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733925298; x=1734530098; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I/TlBMqsvmq4V46cGmsblVOAG5FBrRkt1zaaoOsN24k=;
 b=SRlwe1oRubGJyIeONGrCV0BtgpvD1n4jJa0uhUw8+G2yXuzIOBcz0iX/6aHkcHD4TJ
 Fq8teFolMK8+L+YeS9UBQoRoCVfuXHPp5B+I5lnHxpYDDmgYb/r5zg+6q3I5pCdzhGAF
 U7ZVnogMKEyZFO6BIdIiVb0AEpX8iAd1igEAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733925298; x=1734530098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I/TlBMqsvmq4V46cGmsblVOAG5FBrRkt1zaaoOsN24k=;
 b=XrHxM15RYNy3BSs41oHdmK5Eia6Fl5BqtBxK+6vcTJcMF3+xKjOA13e6A6uSbV9cFx
 4/4y8GfoZ/HGhotQf+GIP3mVixJMtxB1tXIP6/noedkVW7m4TcR5Z4x7RvkemTfLvRgf
 TaPuIFGh9dG/+VXTGyUL6yyL5+93MLJiCMtUBbBMy0H27B/2JqRXi6rdJ81370MPtxbH
 Ck3NpZ4Rf9UeDTg+y7Si9QqZP7UTyQg/851xGjzIFRr5ijMe7rGMKK9oNASXBocCi+zu
 b+2d8iUCzSlPypHfDPz2dMMOZUGqY6j6xQH4QFXa+twZIsZ27HsqhR0sKSIkF4OudOQ5
 +U8w==
X-Gm-Message-State: AOJu0YwNAHUnSP08EqKUh4XINOBVWINCFr93OqzM/PriYcC2O95ABOrb
 r729OBrInjAGxW9ibNxwmYit9+2Xs2YYBphZWNBpRKUpS9D8BR8IfqlJ51ZoZ9kMzlZz2EIMtds
 =
X-Gm-Gg: ASbGnctfZWq4oxJo0Sz8vGyvMMTwcDDKswooPggb/VXbn7bnRMnvHGkNeuO1yiJ0102
 xVvRQi7D5q01hp3K0YW/wXVAm2J6JGryTxHLFxsabvaRr+bCOxDCIx3uOmUnVIOKqkYQ8gk9ji1
 M2wt4hhf7WpiEbu0ej2rsdxZ++Xn3k4/UATMTvMH25GMOD0KpusMsFgRqU/Er6546g7Sgq2ObKz
 yq4RQ5KmNzCjL6wQxg5z6rOr2xlDjiExcywlnYcubUklzCBVyh98eb2tQlzf9QQQkLgP+jQv38O
 UamePac3AFBeg1U=
X-Google-Smtp-Source: AGHT+IFgYUs4bXLZ10l0G9XTFzPzxHjtEpNpoxDMxczCgHD0Pg1o8E2ZCSRat3Qlnhx5RiVP2PaqpQ==
X-Received: by 2002:a5e:8b05:0:b0:841:ab27:acac with SMTP id
 ca18e2360f4ac-844cd0b9183mr327139939f.2.1733925297657; 
 Wed, 11 Dec 2024 05:54:57 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2d46f66f0sm695441173.30.2024.12.11.05.54.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 05:54:56 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Janne Grunau <j@jannau.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v5 19/23] efi_loader: Update to use addresses internally
Date: Wed, 11 Dec 2024 06:54:13 -0700
Message-Id: <20241211135418.563803-20-sjg@chromium.org>
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

(no changes since v4)

Changes in v4:
- Combine the various pointer-to-address patches into one

 include/efi_loader.h              | 13 +++++------
 lib/efi_loader/efi_bootmgr.c      |  3 ++-
 lib/efi_loader/efi_boottime.c     | 37 ++++++++++++++++++++++--------
 lib/efi_loader/efi_dt_fixup.c     |  4 ----
 lib/efi_loader/efi_image_loader.c |  3 ++-
 lib/efi_loader/efi_memory.c       | 38 ++++++++++---------------------
 lib/efi_loader/efi_runtime.c      |  3 ++-
 lib/efi_loader/efi_var_mem.c      |  6 ++---
 lib/lmb.c                         | 10 +++-----
 9 files changed, 57 insertions(+), 60 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 3bfc56ebb5b..9143471c1ce 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -795,7 +795,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 /**
  * efi_free_pages() - free memory pages
  *
- * @memory:	start of the memory area to be freed
+ * @memory:	start-address of the memory area to be freed
  * @pages:	number of pages to be freed
  * Return:	status code
  */
@@ -833,9 +833,9 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
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
  * @memory_type:	type of memory added
  *
@@ -850,9 +850,8 @@ efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
  * efi_add_memory_map_pg() - add pages to the memory map
  *
  * @start: start address, must be a multiple of EFI_PAGE_SIZE. Note that this
- * is actually a pointer provided as an integer. To pass in an address, pass
- * in (ulong)map_to_sysmem(addr)
- *
+ *	is an address, not a pointer. Use map_to_sysmem(ptr) if you need to pass
+ *	in a pointer
  * @pages:			number of pages to add
  * @memory_type:		EFI type of memory added
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
index 47ed22b1d9e..ffe43accd1e 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -431,15 +431,25 @@ static efi_status_t EFIAPI efi_allocate_pages_ext(int type, int memory_type,
 						  uint64_t *memory)
 {
 	efi_status_t r;
+	u64 addr;
 
 	EFI_ENTRY("%d, %d, 0x%zx, %p", type, memory_type, pages, memory);
-	r = efi_allocate_pages(type, memory_type, pages, memory);
+	if (!memory)
+		return EFI_INVALID_PARAMETER;
+
+	/* we should not read this unless type indicates it is being used */
+	if (type == EFI_ALLOCATE_MAX_ADDRESS || type == EFI_ALLOCATE_ADDRESS)
+		addr = map_to_sysmem((void *)(uintptr_t)*memory);
+	r = efi_allocate_pages(type, memory_type, pages, &addr);
+	if (r == EFI_SUCCESS)
+		*memory = (uintptr_t)map_sysmem(addr, pages * EFI_PAGE_SIZE);
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
index 6475b94f951..2995f1b13f5 100644
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
@@ -434,7 +432,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 				enum efi_memory_type memory_type,
 				efi_uintn_t pages, uint64_t *memory)
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
-		addr = map_to_sysmem((void *)(uintptr_t)*memory);
-		addr = (u64)lmb_alloc_base_flags(len, EFI_PAGE_SIZE, addr,
+		addr = (u64)lmb_alloc_base_flags(len, EFI_PAGE_SIZE, *memory,
 						 flags);
 		if (!addr)
 			return EFI_OUT_OF_RESOURCES;
@@ -472,8 +469,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 		if (*memory & EFI_PAGE_MASK)
 			return EFI_NOT_FOUND;
 
-		addr = map_to_sysmem((void *)(uintptr_t)*memory);
-		addr = (u64)lmb_alloc_addr_flags(addr, len, flags);
+		addr = (u64)lmb_alloc_addr_flags(*memory, len, flags);
 		if (!addr)
 			return EFI_NOT_FOUND;
 		break;
@@ -482,17 +478,15 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 		return EFI_INVALID_PARAMETER;
 	}
 
-	efi_addr = (u64)(uintptr_t)map_sysmem(addr, 0);
 	/* Reserve that map in our memory maps */
-	ret = efi_add_memory_map_pg(efi_addr, pages, memory_type, true);
+	ret = efi_add_memory_map_pg(addr, pages, memory_type, true);
 	if (ret != EFI_SUCCESS) {
 		/* Map would overlap, bail out */
 		lmb_free_flags(addr, (u64)pages << EFI_PAGE_SHIFT, flags);
-		unmap_sysmem((void *)(uintptr_t)efi_addr);
 		return  EFI_OUT_OF_RESOURCES;
 	}
 
-	*memory = efi_addr;
+	*memory = addr;
 
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
 
@@ -550,7 +536,7 @@ void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align)
 	if (align < EFI_PAGE_SIZE) {
 		r = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, memory_type,
 				       req_pages, &mem);
-		return (r == EFI_SUCCESS) ? (void *)(uintptr_t)mem : NULL;
+		return (r == EFI_SUCCESS) ? map_sysmem(mem, len) : NULL;
 	}
 
 	r = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, memory_type,
@@ -571,7 +557,7 @@ void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align)
 		efi_free_pages(mem, free_pages);
 	}
 
-	return (void *)(uintptr_t)aligned_mem;
+	return map_sysmem(aligned_mem, len);
 }
 
 efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size, void **buffer)
@@ -593,7 +579,7 @@ efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
 	r = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, pool_type, num_pages,
 			       &addr);
 	if (r == EFI_SUCCESS) {
-		alloc = (struct efi_pool_allocation *)(uintptr_t)addr;
+		alloc = map_sysmem(addr, size);
 		alloc->num_pages = num_pages;
 		alloc->checksum = checksum(alloc);
 		*buffer = alloc->data;
@@ -624,7 +610,7 @@ efi_status_t efi_free_pool(void *buffer)
 	if (!buffer)
 		return EFI_INVALID_PARAMETER;
 
-	ret = efi_check_allocated((uintptr_t)buffer, true);
+	ret = efi_check_allocated(map_to_sysmem(buffer), true);
 	if (ret != EFI_SUCCESS)
 		return ret;
 
@@ -639,7 +625,7 @@ efi_status_t efi_free_pool(void *buffer)
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
index 3a765c11bee..73d5aaf191e 100644
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
@@ -439,7 +438,6 @@ static bool lmb_should_notify(enum lmb_flags flags)
 static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size, u8 op,
 				 enum lmb_flags flags)
 {
-	u64 efi_addr;
 	u64 pages;
 	efi_status_t status;
 
@@ -451,11 +449,10 @@ static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size, u8 op,
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
@@ -465,7 +462,6 @@ static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size, u8 op,
 			status & ~EFI_ERROR_MASK);
 		return -1;
 	}
-	unmap_sysmem((void *)(uintptr_t)efi_addr);
 
 	return 0;
 }
-- 
2.34.1

