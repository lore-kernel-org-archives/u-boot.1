Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A1ED70DED
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 19:13:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF2E789D0D;
	Thu, 28 Nov 2024 20:12:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DVfBH4AB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B99E8938D; Thu, 28 Nov 2024 20:12:59 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF02D89D0D
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 20:12:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-288fa5ce8f0so463448fac.3
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732821175; x=1733425975; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eDIMW9TwnaNJ33jcyLjlpcduQ8Ux8qQ3fOX8O8vCFTY=;
 b=DVfBH4AB2phe+34lcjfjla1Ox7RYSMbY02J7wB7AXCJYWSBpf8w3pzengeX4kidC/y
 BlpoGTj16zCE0KeVxICwEHB8CX5bQGTtOIR+52zllP2OaaIvKGJJ+Wsfi6AmmvRLgRtS
 n0BpHTvIW3HyPtowKO3cSI62SDFoMcs9NYnHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732821175; x=1733425975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eDIMW9TwnaNJ33jcyLjlpcduQ8Ux8qQ3fOX8O8vCFTY=;
 b=ETmnM9sdlSr689/ELFOxdCsvWcdqbGDueGaIuN+8kzI+jPhATJOCTV6wH73FUwBPVw
 1nxm1FqSDHX01FeueVUD17sHtf65r8Ki0rKFLfki1gMdjTyYJlhBeYSmH3G0M8ifS68g
 t2Qt/K3sFIBszmdoVKgzc3PVzr/07Km2OHZORXYsfRWJQsGVOgK+9f1OK+fHzIxcJK1A
 Pwo82Pih3eHEZv/pdeCKwwzSYf6/7uWjxrxwtaonpLltjg1UPtfe+x8D0aaSZCM5/NPq
 vix8qi1lkisLMJE2w11hkFEw+gogV5ZfRofzUeqISkBUC//b9xEsCvlxcbpuHJEyQMyw
 ZoaQ==
X-Gm-Message-State: AOJu0YxdzMbD4BGRqqAX/oXJ/ShJt0pZceeRd8zKoRE7JEqc8FntUCPF
 /u2zTpvMnO2qUbAo85LIjvGgDP9S/zG32nF42CbUuu/6EOau1KNIw2vxZMYrn3AlOS3iuYKfkPQ
 =
X-Gm-Gg: ASbGnct76gcZa6SoqHG+4tiDc1+UX5wf5uv8Tg1f+WUdEXRR+r25CGqe7ZXw1teEy/m
 JWU131Xngv6KSbbpTD9yNNuwZyTDCHNF6fKQaGbnTfjwkHXAbBes/YmNE8s+W54OxGX4aLkV47V
 hGeN2VNvxm+GDvS6ge5iI11scdeF/ZcSjEn+z1wCeWhnPzARv09ucpNmKgn9MPnathRk/3q9IFV
 nad4dHwJWIf+Wz1J9vofelkjCOQQ67eBUh9/yrXowcdwA==
X-Google-Smtp-Source: AGHT+IGsKGHmoEm1Kc9vN9J2yzrDMumhNPfkE3aAIXuCTIMH7p0VxeHBeyfu5GFKPKCDBhERyIT7sQ==
X-Received: by 2002:a05:6870:c07:b0:297:2643:fa25 with SMTP id
 586e51a60fabf-29dc42eadb8mr9610848fac.26.1732821175046; 
 Thu, 28 Nov 2024 11:12:55 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725d873esm429521a34.54.2024.11.28.11.12.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 11:12:53 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v3 01/28] efi: Define fields in struct efi_mem_desc
Date: Thu, 28 Nov 2024 12:12:17 -0700
Message-Id: <20241128191244.900006-2-sjg@chromium.org>
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

There is quite a bit of confusion in the EFI code as to whether a field
contains an address or a pointer. As a first step towards resolving
this, document the memory-descriptor struct, indicating that it holds
pointers, not addresses.

Dro the same for efi_add_memory_map() as it is widely used, as well as
efi_add_memory_map_pg() which is only used by lmb

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Adjust comments

Changes in v2:
- Fix missing @
- Note that this holds pointers, not addresses

 include/efi.h               | 21 +++++++++++++++++++++
 include/efi_loader.h        |  6 ++++--
 lib/efi_loader/efi_memory.c |  4 +++-
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/include/efi.h b/include/efi.h
index c559fda3004..348ff9efd16 100644
--- a/include/efi.h
+++ b/include/efi.h
@@ -273,6 +273,27 @@ enum efi_memory_type {
 #define EFI_PAGE_SIZE		(1ULL << EFI_PAGE_SHIFT)
 #define EFI_PAGE_MASK		(EFI_PAGE_SIZE - 1)
 
+/**
+ * struct efi_mem_desc - defines an EFI memory record
+ *
+ * This field implements the EFI_MEMORY_DESCRIPTOR type of the UEFI
+ * specification.
+ *
+ * Note that this struct is for use outside U-Boot, so the two 'start' fields
+ * are pointers, not addresses. Use map_to_sysmem() to convert to an address, so
+ * that sandbox operates correctly.
+ *
+ * @type (enum efi_memory_type): EFI memory-type
+ * @reserved: unused
+ * @physical_start: Start address of region in physical memory
+ * @virtual_start: Start address of region in virtual memory, which will be the
+ *	same as @physical_start before where both addresses will always be the
+ *	same before SetVirtualMemoryMap() is called as the UEFI specification
+ *	requires identity mapping.
+ * @num_pages: Number of EFI pages this record covers (each is EFI_PAGE_SIZE
+ *	bytes)
+ * @attribute: Memory attributes (see EFI_MEMORY_...)
+ */
 struct efi_mem_desc {
 	u32 type;
 	u32 reserved;
diff --git a/include/efi_loader.h b/include/efi_loader.h
index 39809eac1bc..ee0cdd36500 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -788,8 +788,10 @@ efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
 /**
  * efi_add_memory_map_pg() - add pages to the memory map
  *
- * @start:			start address, must be a multiple of
- *				EFI_PAGE_SIZE
+ * @start: start address, must be a multiple of EFI_PAGE_SIZE. Note that this
+ * is actually a pointer provided as an integer. To pass in an address, pass
+ * in (ulong)map_to_sysmem(addr)
+ *
  * @pages:			number of pages to add
  * @memory_type:		type of memory added
  * @overlap_conventional:	region may only overlap free(conventional)
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index e493934c713..f1154f73e05 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -384,7 +384,9 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
 /**
  * efi_add_memory_map() - add memory area to the memory map
  *
- * @start:		start address of the memory area
+ * @start:		start address of the memory area. Note that this is
+ *			actually a pointer provided as an integer. To pass in
+ *			an address, pass in (ulong)map_to_sysmem(addr)
  * @size:		length in bytes of the memory area
  * @memory_type:	type of memory added
  *
-- 
2.34.1

