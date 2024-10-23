Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0273CF5396
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 14:37:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32B9088FA7;
	Wed, 23 Oct 2024 16:37:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IG7aj5we";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB9F888FF6; Wed, 23 Oct 2024 16:37:56 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B626C88F4B
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 16:37:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-539fbbadf83so9184368e87.0
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 07:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729694272; x=1730299072; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BbeQFSnBIGPhM5qnTGMIoujxN12Sw4iFVosQUP6rFgQ=;
 b=IG7aj5weChJ8d6OpXz5GN5iOYORqQ0Um5tymKtjHUym1AzEQ5y7kaInnuU78ptE4O6
 7PFiXQVnRDZuMjusljyz+K9UWigripvwVuQIE1qPdvqiaAp6Pi1PLFWSMyCeAuNZeC3M
 6X8GZ6p2Od3jBkB0lkFEVsMeF5hZ415pRCMgrG9r5bdVFzR407F3egFaXt+XBOUz6ENz
 Cyrp3C3gR/6iPIDcqAnHP131HTuyArG3v4qOKmS/Zge2OHqnQPxvhG1gyc+2dvBK53as
 jYMe5EvQvqfrwAjT7NmfMKduIocIBzE0/1wI/eGhscVhGdJ53XD8GwngssS2RXXkjiqf
 GwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729694272; x=1730299072;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BbeQFSnBIGPhM5qnTGMIoujxN12Sw4iFVosQUP6rFgQ=;
 b=RaiVwZOtFODU5ZGTIgJy2QUM+D73+yzPb7N7TxQxV5egfowjE72e3rJx1vjghVmrYX
 FPIP/lIhq3RYOqzkloQ/P/vqcbih0kVSsrAzdvHHUnf8n3guwVKLDGaFhsB3U2vq2z7N
 qLuTsSX+sKElM89X/VwStavHmltDlz0TO5T1FLPBAX/WiRyah/f8SiNUFEqqEaJDsnX7
 IUmNNyOIJ72NCoBR/i8a/sQx87nxfWrX2k9Q54ZJcdcKvzdCmCx94hRWxRjCzT4w44f0
 08KC8Zm+YLFdNsnl/4tXsAT/eH8MWLpz5v+6FGboYFnTPcFJoDFnpCC8TEV7xpUEKZ8j
 OIpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeTSF+bcyYsuY3EzretFhT4+WuT4DsxRKDLgcpPUjVtVgQw+REZMHk5ICszX2mA8sPGHi+eP8=@lists.denx.de
X-Gm-Message-State: AOJu0YxZxcXJUdoDLoXoD6b9ufLxU3Id9ovg+dJc3TuHW0BXJZhAU5Mq
 W1Eh5NU7g/bvmKDyCdFb2in6r9iVVyKIqp7GmMqjVc63H8pxfd49IXqOLipBrp4=
X-Google-Smtp-Source: AGHT+IESjjnEYfCqJSJs3j9Xtlk/baHdAiqeeRl3DgfGY8I9GuP7SaTeIR0Qc7P43HU+zGU+AdJmfg==
X-Received: by 2002:a05:6512:e9a:b0:539:e8b5:f296 with SMTP id
 2adb3069b0e04-53b1a33e4d0mr1517716e87.33.1729694271896; 
 Wed, 23 Oct 2024 07:37:51 -0700 (PDT)
Received: from localhost.localdomain (ppp176092143132.access.hol.gr.
 [176.92.143.132]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb6696b553sm4529218a12.3.2024.10.23.07.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 07:37:51 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: sughosh.ganu@linaro.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Prasad Kummari <prasad.kummari@amd.com>,
 u-boot@lists.denx.de
Subject: [PATCH] lmb: Remove lmb_alloc_flags()
Date: Wed, 23 Oct 2024 17:37:46 +0300
Message-ID: <20241023143747.1209481-1-ilias.apalodimas@linaro.org>
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

Keep the lmb_alloc_base_flags() flags which also prints an error
on failures and adjust efi_allocate_pages() to only use one of them.

While at it clean up the duplicate function description from the header
file.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 include/lmb.h               | 26 --------------------------
 lib/efi_loader/efi_memory.c |  3 ++-
 lib/lmb.c                   | 17 -----------------
 3 files changed, 2 insertions(+), 44 deletions(-)

diff --git a/include/lmb.h b/include/lmb.h
index e46abf400c68..92464d6e1342 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -95,32 +95,6 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr);
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
index 69001ad57373..3a9edb1e565e 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -670,23 +670,6 @@ phys_addr_t lmb_alloc(phys_size_t size, ulong align)
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

