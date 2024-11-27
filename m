Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E17D6ACF7
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 17:23:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE2EE897E7;
	Wed, 27 Nov 2024 18:23:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mvB3H95m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E1FE8958D; Wed, 27 Nov 2024 18:22:59 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF0808961A
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 18:22:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6d3e9e854b8so9699366d6.1
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 09:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732728175; x=1733332975; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RJIL3wRFmOYMwFp0osGKOte/N/sWvUJAGEd8ZEf9CYA=;
 b=mvB3H95m2nlET2yQ2Wu+wHVYQLVt6S0ZCoxlAcahy1a5jDfKbfFzuxF9e5SR7b/yVu
 0tvz9xeBMOEcl4Z5lNa86WTmeF8VQ0JgIqM2LDiuFBUSLfbdrrMcy4SaTpiO0V+dYHD6
 tH3lvuescE5QyRdbMbrjya2jCkbgUii3kyN7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732728175; x=1733332975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RJIL3wRFmOYMwFp0osGKOte/N/sWvUJAGEd8ZEf9CYA=;
 b=dsTU+Yu9fkykKHrFZbwLxfdPE4dYAUe5i/j42zeJeUVZcm3+le52HFWtCGaGaeFp0n
 Dii7zxjOp5PZIuXR1qjLSOias/WrSzelE3wAPI9IOz3+Z1h10YXh3eLrU6/wxm7HyB1w
 OJZ6E5tS4egH+ySH4OcMbLmuleemEEGuzaTWaYyH9chmQy4AvLCfqt/zY0ujLJCn8/mP
 1ZiFDXU3khWIRq64Ad2rIyXZiwII17qQIjzXAT2Gstaaq6hN5ub7mqg6zqYHPsRcefOo
 Qn0NrCm4mqP3t9wahWj0ntNUtG15L5u/JiqWW/h6nbD+wP1XbXFf6X/osq280ZeHvsPn
 osWA==
X-Gm-Message-State: AOJu0YxhDVdxkKsY98OHVUS2d+hEFJrcSZnoEloDWV946tKnenWCMVFd
 Lqq6Z2AaPtVq9pE0IdPiAy1djkOk5Pi9kkkkKMzrI94Bsxf0wkHI/rjNe7sJzaByzte+kv0ul7t
 eED0=
X-Gm-Gg: ASbGncteNc/0KIdFGhPRbKwR3S2fCPcFFVUKvob7Vj7KfE36m6XNuTbMZKecJHJbFZ7
 7ZTdR2IQxTLLqFyNVp/frlCCwc/179V14cN0pLiOy3YC0nlpZshKBPlqWlQPjX7426UrzqBzthZ
 hQZnRpj9A6wYZCTpNVZrfmMFTlm8skSSvQRFDYEzVK3siuTNTth0Ekaglje09A8m89iLtCKbvH/
 LkFmykIDTEqiWcF4FI1az3SlfbLJzFdlJiHpF4Jhk5ikO5r5IsY7esg56Lwm2cFKvGKxKmG
X-Google-Smtp-Source: AGHT+IHoxfk3bwDt5rvyyCSTjB211x2DkXSfMWcbV+g7vkfRDsEHQmmGyYp/uHx8MR/Kd2RywJZPHw==
X-Received: by 2002:a05:6214:2264:b0:6d4:23c5:6adc with SMTP id
 6a1803df08f44-6d87282068cmr3538406d6.0.1732728175697; 
 Wed, 27 Nov 2024 09:22:55 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451b23e25sm67160976d6.89.2024.11.27.09.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 09:22:55 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [v6 01/12] sandbox: efi_loader: Correct use of addresses as pointers
Date: Wed, 27 Nov 2024 11:17:19 -0600
Message-ID: <20241127172247.1488685-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241127172247.1488685-1-trini@konsulko.com>
References: <20241127172247.1488685-1-trini@konsulko.com>
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

From: Simon Glass <sjg@chromium.org>

The cache-flush function is incorrect which causes a crash in the
remoteproc tests with arm64.

Fix both problems by using map_sysmem() to convert an address to a
pointer and map_to_sysmem() to convert a pointer to an address.

Also update the image-loader's cache-flushing logic.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 3286d223fd7 ("sandbox: implement invalidate_icache_all()")
Acked-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Changes in v6:
- Re-introduce

Changes in v2:
- Drop message about EFI_LOADER

 arch/sandbox/cpu/cache.c              |  8 +++++++-
 drivers/remoteproc/rproc-elf-loader.c | 18 +++++++++++-------
 lib/efi_loader/efi_image_loader.c     |  3 ++-
 3 files changed, 20 insertions(+), 9 deletions(-)
---
 arch/sandbox/cpu/cache.c              |  8 +++++++-
 drivers/remoteproc/rproc-elf-loader.c | 18 +++++++++++-------
 lib/efi_loader/efi_image_loader.c     |  3 ++-
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/sandbox/cpu/cache.c b/arch/sandbox/cpu/cache.c
index c8a5e64214b6..96b3da47e8ed 100644
--- a/arch/sandbox/cpu/cache.c
+++ b/arch/sandbox/cpu/cache.c
@@ -4,12 +4,18 @@
  */
 
 #include <cpu_func.h>
+#include <mapmem.h>
 #include <asm/state.h>
 
 void flush_cache(unsigned long addr, unsigned long size)
 {
+	void *ptr;
+
+	ptr = map_sysmem(addr, size);
+
 	/* Clang uses (char *) parameters, GCC (void *) */
-	__builtin___clear_cache((void *)addr, (void *)(addr + size));
+	__builtin___clear_cache(map_sysmem(addr, size), ptr + size);
+	unmap_sysmem(ptr);
 }
 
 void invalidate_icache_all(void)
diff --git a/drivers/remoteproc/rproc-elf-loader.c b/drivers/remoteproc/rproc-elf-loader.c
index ab1836b3f078..0b3941b7798d 100644
--- a/drivers/remoteproc/rproc-elf-loader.c
+++ b/drivers/remoteproc/rproc-elf-loader.c
@@ -6,6 +6,7 @@
 #include <dm.h>
 #include <elf.h>
 #include <log.h>
+#include <mapmem.h>
 #include <remoteproc.h>
 #include <asm/cache.h>
 #include <dm/device_compat.h>
@@ -180,6 +181,7 @@ int rproc_elf32_load_image(struct udevice *dev, unsigned long addr, ulong size)
 	for (i = 0; i < ehdr->e_phnum; i++, phdr++) {
 		void *dst = (void *)(uintptr_t)phdr->p_paddr;
 		void *src = (void *)addr + phdr->p_offset;
+		ulong dst_addr;
 
 		if (phdr->p_type != PT_LOAD)
 			continue;
@@ -195,10 +197,11 @@ int rproc_elf32_load_image(struct udevice *dev, unsigned long addr, ulong size)
 		if (phdr->p_filesz != phdr->p_memsz)
 			memset(dst + phdr->p_filesz, 0x00,
 			       phdr->p_memsz - phdr->p_filesz);
-		flush_cache(rounddown((unsigned long)dst, ARCH_DMA_MINALIGN),
-			    roundup((unsigned long)dst + phdr->p_filesz,
+		dst_addr = map_to_sysmem(dst);
+		flush_cache(rounddown(dst_addr, ARCH_DMA_MINALIGN),
+			    roundup(dst_addr + phdr->p_filesz,
 				    ARCH_DMA_MINALIGN) -
-			    rounddown((unsigned long)dst, ARCH_DMA_MINALIGN));
+			    rounddown(dst_addr, ARCH_DMA_MINALIGN));
 	}
 
 	return 0;
@@ -377,6 +380,7 @@ int rproc_elf32_load_rsc_table(struct udevice *dev, ulong fw_addr,
 	const struct dm_rproc_ops *ops;
 	Elf32_Shdr *shdr;
 	void *src, *dst;
+	ulong dst_addr;
 
 	shdr = rproc_elf32_find_rsc_table(dev, fw_addr, fw_size);
 	if (!shdr)
@@ -398,10 +402,10 @@ int rproc_elf32_load_rsc_table(struct udevice *dev, ulong fw_addr,
 		(ulong)dst, *rsc_size);
 
 	memcpy(dst, src, *rsc_size);
-	flush_cache(rounddown((unsigned long)dst, ARCH_DMA_MINALIGN),
-		    roundup((unsigned long)dst + *rsc_size,
-			    ARCH_DMA_MINALIGN) -
-		    rounddown((unsigned long)dst, ARCH_DMA_MINALIGN));
+	dst_addr = map_to_sysmem(dst);
+	flush_cache(rounddown(dst_addr, ARCH_DMA_MINALIGN),
+		    roundup(dst_addr + *rsc_size, ARCH_DMA_MINALIGN) -
+		    rounddown(dst_addr, ARCH_DMA_MINALIGN));
 
 	return 0;
 }
diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index 0ddf69a09183..bb58cf1badb7 100644
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
@@ -977,7 +978,7 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 	}
 
 	/* Flush cache */
-	flush_cache((ulong)efi_reloc,
+	flush_cache(map_to_sysmem(efi_reloc),
 		    ALIGN(virt_size, EFI_CACHELINE_SIZE));
 
 	/*
-- 
2.43.0

