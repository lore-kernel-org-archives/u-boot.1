Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E08E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 13:54:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1FEE8021C;
	Wed, 11 Dec 2024 14:54:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MMM7cwvu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AF6280241; Wed, 11 Dec 2024 14:54:30 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D94778021C
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:54:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3a7deec316aso23624915ab.1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 05:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733925266; x=1734530066; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5I5lPwpqnRvaK+Jclr0jN1lXyWvHITlu2wnSSWsShgk=;
 b=MMM7cwvumW9PJGHkSdxAx6WNgl1qWGRvQ0S5XG8NLzfj1xrrlHtVXG4t94YrgbAWBP
 OGqQ4cm0XveMP4dqBSwAK0h/i6+PFhDxGvZejWd/wLSMD8T3DhMW/pu+QEDtqT3rxbfd
 chcpeq0pks1OXKzVmxLfgtCIilZzr+dUYhW3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733925266; x=1734530066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5I5lPwpqnRvaK+Jclr0jN1lXyWvHITlu2wnSSWsShgk=;
 b=ZvTJ8NwnrEdAFWG9wCJHVSrOFU5MzDdyNmMKN9Cg1Q+JnmcLH9MSHeeCkAfMUmR9tc
 nBb85nws9uQ4LQj1kQnc6hUhzvSHneBOW/15/unNX41+0XNDiIWVhq1DPM1Sdlto2zaf
 3EJw4dLYAi4J+AempO/vNXK03YeXRZ9/+os/N2leazg136wxSbMN1+BSdk3XF99IbZ/y
 WV4Ilk4OSC1AZPAfk5TOlyhwH0YIKpw/fNo1h304fEuVA5EYbYNsP68p2IOPdn9t5TWO
 mrhaL14AZf/RWCWys0EYRq7ZWfSKumlyMzXKT9QHeLDTLYi3WggNEqEKmEKL/zP6hAar
 8DMA==
X-Gm-Message-State: AOJu0YyoFBRYte143YNyTopYjokqTXP1dgUsiJDXD9oZWKZ8uQiNZpzP
 uDbkBN7gIRi78ZV8mdwWSP4RviBtUIOE8mosgNFUi3gONJkZkVhBzwxD614FQAoykqlbxHrrRZI
 =
X-Gm-Gg: ASbGncvM8ARF5hRSOH/h9MC9bH7Db+DSk3yYZF2RvBHu3tZX7LmIGN3IWBjPYxVD1Fn
 gZWg/eeHcBE/zBTa5Z1W2LtNOeWx2qlQSObAWO6VNDIUvgJ0rh7KbP69U7+ExZj8uHNgZyepGGV
 4bh9rVy0mmLnXWBz2G2lYkE0mnKspfOjtCup3nbIfkTgYAd6Kg69TcmPnjJc9vzpJKpUZpVBnLR
 RKDAdmN4nAUm8lUGKXi+DhAj6moiwwUtB2/ktOwHXSdQfaZCNL6gXaQ21GldfJ4LRDCoje2Pl1H
 08xuDtrhovG1z6g=
X-Google-Smtp-Source: AGHT+IFrW7gIeMn2vlOPdbMI0wCTXVILh5RJbEV5e9t9MrOe+WKKEMYbPxKTbhvFi6Tm0s4pXsnBnQ==
X-Received: by 2002:a05:6e02:1c29:b0:3a7:4eee:b7b9 with SMTP id
 e9e14a558f8ab-3aa06beeae8mr32619365ab.13.1733925266083; 
 Wed, 11 Dec 2024 05:54:26 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2d46f66f0sm695441173.30.2024.12.11.05.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 05:54:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v5 01/23] efi: Define fields in struct efi_mem_desc
Date: Wed, 11 Dec 2024 06:53:55 -0700
Message-Id: <20241211135418.563803-2-sjg@chromium.org>
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

There is quite a bit of confusion in the EFI code as to whether a field
contains an address or a pointer. As a first step towards resolving
this, document the memory-descriptor struct, indicating that it holds
pointers, not addresses.

Dro the same for efi_add_memory_map() as it is widely used, as well as
efi_add_memory_map_pg() which is only used by lmb

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

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
index ebd7e11d6e3..58838e3ff2c 100644
--- a/include/efi.h
+++ b/include/efi.h
@@ -276,6 +276,27 @@ enum efi_memory_type {
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

