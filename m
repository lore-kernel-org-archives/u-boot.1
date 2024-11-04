Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D473D132C4
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 13:40:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE42C88E4B;
	Mon,  4 Nov 2024 14:40:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ieyabTfg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE00488DA3; Mon,  4 Nov 2024 14:40:06 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A403A88A0A
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 14:40:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-8323b555a6aso240877139f.3
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 05:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730727603; x=1731332403; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=49sk/QDzLz0+2BFgLHnZzFO16Sf0EAWdbzCvDQ+ykSw=;
 b=ieyabTfgflhmLhFGcJoxFaFivIFABOK+S4ghglGM4ElPSnyCWIqdBFIkNdIOSd7Pfd
 xwpueo9JHruP7cUUy+zMni2aMxKy/7Vaak5EjIS5znb1ru9eHWQfrl5ULezEBDrcmS+X
 slQZn8mOMbIIP6IxaDFiqKQPXlYFEG8ltjptg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730727603; x=1731332403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=49sk/QDzLz0+2BFgLHnZzFO16Sf0EAWdbzCvDQ+ykSw=;
 b=O4C9e6NbdSaiP6s5L/dKxXkRAXyckjNiZc/ADGpBV965CgS2N03r8BUgx2qDLE2k+4
 T4O+pqYcLM2hxJUBfjvBDSMZxl1qC1t6vOCYABPnDu2bMRjMqE0HWt91zg38CDpPIa6d
 RounctlhMV2f4LKI8bEat9k1JkVApWbeEvwcSL6GE4fH7ZB4/EJKt++SHlrU8V92uyv9
 yaM9klH9w/iRXSm+QOBHwoTDa7Uum1JzcipzEyW0k4UU2dV7Yu5uOoMvSambPB/Recf+
 eok+JtSU7E47g28sDZoputOvILBJUo5wozfl/uT4enypKIeT4cMXFHrTKrKQpzvQAo9b
 yZww==
X-Gm-Message-State: AOJu0YzCgjK7JzK42+XiMk8h3sMi7+MlX6bJK6kvmMqTYw4GG1SJh5hp
 ZBAcVT2tkUT8cJbr4EWMOSZGaw6AbjefR3l/UeFguQTv4pB37/ZTtxpOUPCP3P8cJ7WgzJ6Aevo
 =
X-Google-Smtp-Source: AGHT+IGWvR13rAqdS6aGX9yOG3FhaIJK+L28rhzi0+cLK2iEoMxaIGLXIi8RR3Wd01QGfADOPKKwiw==
X-Received: by 2002:a05:6602:164f:b0:83a:9488:154c with SMTP id
 ca18e2360f4ac-83b64f3b524mr1587113239f.3.1730727602865; 
 Mon, 04 Nov 2024 05:40:02 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de048895f3sm1935128173.12.2024.11.04.05.40.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 05:40:02 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 1/9] sandbox: efi_loader: Correct use of addresses as pointers
Date: Mon,  4 Nov 2024 06:39:45 -0700
Message-Id: <20241104133954.840994-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104133954.840994-1-sjg@chromium.org>
References: <20241104133954.840994-1-sjg@chromium.org>
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

As discussed some time ago, it would be good to update the way
EFI_LOADER uses addresses and pointers, particularly around memory
allocation. Ideally we would use addresses internally, with pointers
only exposed via the external API, even where pointers are in fact
u64 values.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 3286d223fd7 ("sandbox: implement invalidate_icache_all()")
---

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

