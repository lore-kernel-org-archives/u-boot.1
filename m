Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B12D42B86
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:11:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10ACC89445;
	Tue, 12 Nov 2024 15:11:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c2t3fzBP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA1C789445; Tue, 12 Nov 2024 15:11:16 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 986688943F
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:11:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3a4d1633df9so19642465ab.2
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731420673; x=1732025473; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f7c5KNi5lvnaKFzRD0dvG5UXgrqwo1FMaNX5nE5bDEY=;
 b=c2t3fzBPAfu2TWUWxMIWn7O+GrZb2pr2gl582rQ8vcnpbdT6g9zXBE2rafbvYip7fQ
 EtiGAWaVcGnFwJpdNcwwT4OcArzy5INNukdYsW2lk8vq7kCz8KwE0IOYHIePQz8k/fqe
 M+7InQiR6FfiYRHgQz1QTSLaa6I4x7A+KzAKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731420673; x=1732025473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f7c5KNi5lvnaKFzRD0dvG5UXgrqwo1FMaNX5nE5bDEY=;
 b=mc6XooMS8r92u7Ri8J0pCRWNhbOt4zjmULNSNJq3Xccn++xdsPeksEADufIOmNwnTD
 5ZZaiLJxDOz9MIb6NGSW9tDyGBk8pJbU09LFHu356SCPOIGJ3Krli54KhC0oXz5v1jgN
 0/QVk3vkTabg3bdpj2zIh6yv+LN8FebEkzpU4yefuQfAFCGxz6fz7c3OBV5FseBKeRVs
 xKK5R4pSaNdRVlDog+Z1PqD3ieZHgBmJHYHzZFEFadlv10+6PWH5w5ED4nrj+AMzkpsR
 L5stUG3DdEsvksu5vux4/2EBmWkQ4zEy1NupYqNpfrzsKQmpwzQRSjxvevf4RQi406pX
 35Uw==
X-Gm-Message-State: AOJu0Yyggo75zwRAbutKmQk+TxIHvtnX94y1SH13LOekyPrbyH2fxqwS
 PGRDtIjpMbEkK9urD9myYikgoeru6WSbSRi7CnaGPIMWOQPSDl7lV5jofN4PHIdllLd7xXpjNhQ
 =
X-Google-Smtp-Source: AGHT+IH5IEbvegOXNGYyPcRIKGIF9ZOXcq18XDIXgVT2hv1Z8Mah7pfyFhXMOLxK35niPJwrPQsEeg==
X-Received: by 2002:a05:6e02:190b:b0:3a6:b445:dc9c with SMTP id
 e9e14a558f8ab-3a6f1993119mr172340785ab.3.1731420672595; 
 Tue, 12 Nov 2024 06:11:12 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de783d11f0sm1977776173.0.2024.11.12.06.11.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 06:11:11 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v3 1/9] sandbox: efi_loader: Correct use of addresses as
 pointers
Date: Tue, 12 Nov 2024 07:10:57 -0700
Message-Id: <20241112141105.640189-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112141105.640189-1-sjg@chromium.org>
References: <20241112141105.640189-1-sjg@chromium.org>
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

The cache-flush function is incorrect which causes a crash in the
remoteproc tests with arm64.

Fix both problems by using map_sysmem() to convert an address to a
pointer and map_to_sysmem() to convert a pointer to an address.

Also update the image-loader's cache-flushing logic.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 3286d223fd7 ("sandbox: implement invalidate_icache_all()")
---

(no changes since v2)

Changes in v2:
- Drop message about EFI_LOADER

 arch/sandbox/cpu/cache.c              |  8 +++++++-
 drivers/remoteproc/rproc-elf-loader.c | 18 +++++++++++-------
 lib/efi_loader/efi_image_loader.c     |  3 ++-
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/sandbox/cpu/cache.c b/arch/sandbox/cpu/cache.c
index c8a5e64214b..96b3da47e8e 100644
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
index ab1836b3f07..0b3941b7798 100644
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
index 0ddf69a0918..bb58cf1badb 100644
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
2.34.1

