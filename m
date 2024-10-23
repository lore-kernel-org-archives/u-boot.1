Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D95BCF539E
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 15:26:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF2508926F;
	Wed, 23 Oct 2024 17:26:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zyWHeDVH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73ED6892CF; Wed, 23 Oct 2024 17:26:47 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F48F8919C
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 17:26:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c40aea5c40so1123367a12.0
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 08:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729697201; x=1730302001; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R74p20ZdAEGVlziW4h1MIpLcx8WXmgoCjSZ5AyiUsJ8=;
 b=zyWHeDVH4GoSdMczTX5JnacrlbcaNHYtbUY2JdDLW6wvNoFWjtIuq0oMrhk+3Sakd7
 QNhBG1vqTRHHfwpAaf6ti/l44jN9/AK31JdoLM2Ea/Ny1M7XOw18/RqZkvZzgapFSgqp
 Vy908O/ARPgX5+NWVQxKCh7VhBf1f6kzzV8wf9kavc+0Kuejw+SxvDlAbaEmtwZ4IUnF
 YL7z5NAkg3Kq0h7aKzGx+E4RVuX/0HHJoFRDq08Z+v3KQNIKW2n411KDhzsIK4PKdW7v
 64gIf3A+9iCYG99cUqd7i+RbZID/d/PTSpa8c2YlEoyfC464dKMMZCeDpifkpCb2eTaH
 Y0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729697201; x=1730302001;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R74p20ZdAEGVlziW4h1MIpLcx8WXmgoCjSZ5AyiUsJ8=;
 b=j70evzlpkr6DhkhLYi4cG6yvXqRDM8kCIVRBWa6k1p9J03Xvo9ymDzmJrT0SydpYoi
 nWkkG2HCDswlX5MvfCt6EKQufm4z3T9+nNudMpBNhmsHq2uT9XlAejuS9L3oNCTr0ZOU
 yIWJoDK+nDbyVwHKab39ezSfP76TcVaVOb2aCWBgx5L/7dnIK2relh6bzI1/eVkBptGb
 H8K6ZJbth+ZEnhM2uNSCrvxdL7BGsVFz0JGvKYj0TJOpNavUD5+kOFmQimjl3mTPzH0Y
 KzaaeacgeaMN099yHLFLrkV4rzKcvHd+wTZXWxS5usU8hwUTrPeL2y6Any4CR0kwhSi+
 XRwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMX29eY0lzJ63k4AnkbiZ1eslx+KqKWmeeClG+JUA7OlcCH7eWB4I1MBPsutfUcbpK/4eLnxI=@lists.denx.de
X-Gm-Message-State: AOJu0YxI4lg3Qcmc2ZxlkqcbSCXlDTXEB5gQy91vg632rPCJqk5SGZhJ
 TuKuLvrKhWsyIP3UoNvUmREAo7/tDARPjjvSD0kgGiwd4He6g7Q15R1+8h8D/Bs=
X-Google-Smtp-Source: AGHT+IFnhMmxpzE9OBBoSXr798jzP6UHCVbO5Pst03Z8Qzpdkq5M+j1bT27Y/a/jTe4J/U5sf/Xsaw==
X-Received: by 2002:a05:6402:5193:b0:5c4:aea:5833 with SMTP id
 4fb4d7f45d1cf-5cb8b5fadcbmr3125441a12.18.1729697200932; 
 Wed, 23 Oct 2024 08:26:40 -0700 (PDT)
Received: from localhost.localdomain (ppp176092143132.access.hol.gr.
 [176.92.143.132]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66c73b50sm4493139a12.97.2024.10.23.08.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 08:26:40 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: sughosh.ganu@linaro.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Prasad Kummari <prasad.kummari@amd.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2] lmb: Remove lmb_alloc_flags()
Date: Wed, 23 Oct 2024 18:26:36 +0300
Message-ID: <20241023152637.1222691-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
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

lmb_alloc_flags() & lmb_alloc_base_flags() are just a wrappers for
_lmb_alloc_base(). Since the only difference is the max address of the
allowed allocation which _lmb_alloc_base() already supports with the
LMB_ALLOC_ANYWHERE flag, remove one of them.

Keep the lmb_alloc_base_flags() which also prints an error on failures
and adjust efi_allocate_pages() to only use one of them.

While at it clean up the duplicate function description from the header
file.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
changes since v1:
- Move the needed lmb defines to lmb.h

 include/lmb.h               | 29 +++--------------------------
 lib/efi_loader/efi_memory.c |  3 ++-
 lib/lmb.c                   | 20 --------------------
 3 files changed, 5 insertions(+), 47 deletions(-)

diff --git a/include/lmb.h b/include/lmb.h
index e46abf400c68..2201d6f2b67b 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -14,6 +14,9 @@
  * Copyright (C) 2001 Peter Bergner, IBM Corp.
  */

+#define LMB_ALLOC_ANYWHERE      0
+#define LMB_ALIST_INITIAL_SIZE  4
+
 /**
  * enum lmb_flags - definition of memory region attributes
  * @LMB_NONE: no special request
@@ -95,32 +98,6 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr);
 phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size);
 phys_size_t lmb_get_free_size(phys_addr_t addr);

-/**
- * lmb_alloc_flags() - Allocate memory region with specified attributes
- * @size: Size of the region requested
- * @align: Alignment of the memory region requested
- * @flags: Memory region attributes to be set
- *
- * Allocate a region of memory with the attributes specified through the
- * parameter.
- *
- * Return: base address on success, 0 on error
- */
-phys_addr_t lmb_alloc_flags(phys_size_t size, ulong align, uint flags);
-
-/**
- * lmb_alloc_base_flags() - Allocate specified memory region with specified attributes
- * @size: Size of the region requested
- * @align: Alignment of the memory region requested
- * @max_addr: Maximum address of the requested region
- * @flags: Memory region attributes to be set
- *
- * Allocate a region of memory with the attributes specified through the
- * parameter. The max_addr parameter is used to specify the maximum address
- * below which the requested region should be allocated.
- *
- * Return: base address on success, 0 on error
- */
 phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
 				 phys_addr_t max_addr, uint flags);

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 3d742fa19150..9f3f08769977 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -472,7 +472,8 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 	switch (type) {
 	case EFI_ALLOCATE_ANY_PAGES:
 		/* Any page */
-		addr = (u64)lmb_alloc_flags(len, EFI_PAGE_SIZE, flags);
+		addr = (u64)lmb_alloc_base_flags(len, EFI_PAGE_SIZE,
+						 LMB_ALLOC_ANYWHERE, flags);
 		if (!addr)
 			return EFI_OUT_OF_RESOURCES;
 		break;
diff --git a/lib/lmb.c b/lib/lmb.c
index 69001ad57373..890e2cbfdf6b 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -27,9 +27,6 @@ DECLARE_GLOBAL_DATA_PTR;
 #define MAP_OP_FREE		(u8)0x2
 #define MAP_OP_ADD		(u8)0x3

-#define LMB_ALLOC_ANYWHERE	0
-#define LMB_ALIST_INITIAL_SIZE	4
-
 static struct lmb lmb;

 static bool lmb_should_notify(enum lmb_flags flags)
@@ -670,23 +667,6 @@ phys_addr_t lmb_alloc(phys_size_t size, ulong align)
 	return lmb_alloc_base(size, align, LMB_ALLOC_ANYWHERE);
 }

-/**
- * lmb_alloc_flags() - Allocate memory region with specified attributes
- * @size: Size of the region requested
- * @align: Alignment of the memory region requested
- * @flags: Memory region attributes to be set
- *
- * Allocate a region of memory with the attributes specified through the
- * parameter.
- *
- * Return: base address on success, 0 on error
- */
-phys_addr_t lmb_alloc_flags(phys_size_t size, ulong align, uint flags)
-{
-	return _lmb_alloc_base(size, align, LMB_ALLOC_ANYWHERE,
-			       flags);
-}
-
 phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr)
 {
 	phys_addr_t alloc;
--
2.45.2

