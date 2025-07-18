Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C287DC83F1A
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 01:16:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F4B38354B;
	Fri, 18 Jul 2025 03:16:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZGiTwHjJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BABE835B2; Fri, 18 Jul 2025 03:15:58 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 406388353A
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 03:15:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-60efc773b5fso928982eaf.3
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 18:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752801355; x=1753406155; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=sgcB/sJsRY149C1A3IYQvRRyZclIriPT19gOHbEgrt4=;
 b=ZGiTwHjJ5oMiIpS3mwDy+AH2+/aG7qj4zN4dG+9wPSUp+bmzE/sfn4/gGFldE9s1Uy
 2FWMP4ay8NVIvGwj+SV6yIcZ5nH8NF/He3RZ4SgMsMzWTKO8hjWWrn2L4uCaIFQBpDtV
 2tWhR1GJsIwZyHSrh/ZS2BHleUmTNhVxAMjLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752801355; x=1753406155;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sgcB/sJsRY149C1A3IYQvRRyZclIriPT19gOHbEgrt4=;
 b=gsF5FpelJTJD3ExyIqEyWl7v21Rs4+WILqTKcXhtrIOQwRkDMRW0aO2klI/9sAKRR+
 CHYn+34GKz3Qlvn9QuGyCxuaHwfWUA/6m+BNqJJmqwvPIqA7EjEx1QDxU8/mUyRUyj65
 YOg/rDr/NkbEbVkL+tSpq+dn2zSwQCE0TKE66JDsKNHdheWOPABuBML3WOB73ZI9q0Yu
 rZNlpMX4SZhvYxC2uhknXO44OgV7kddElG+tbJcStRUyOtRMCGNJVNbOuiQx1IjzmsCd
 Ld95+OshO7her4oBBBwHj3FaHnPP65W4BUrkaoTb9Zbm34SJoY+vK7DIKUNWsmgZAZdA
 rK/g==
X-Gm-Message-State: AOJu0YwHcKY3sOIeGDHuKp3Amic1LO+tZuqWfADwosClv4hY45WUXBa3
 BpFp7ihKzjrp4yKCK96Q8ALm464S6Sq5+SkJG5f+d/2OJYjGBAKiG4G0olEh15bR4lkZAQngUee
 Gb+8+UWI=
X-Gm-Gg: ASbGncsPgHv/BfVHrtTbx3yyMMxgjuwrn1Z2AXIWl1YDAIA9+pBzsMrTPMJG326UkTw
 ak5bBy74grJx3TUAT6NULuutXB4MgS287axUttkS0TrD4tbzwAZze7gH+OCqtSHGQ46BFtFK7L+
 MJoHq6FwgH1e3bg4dHjMSj0Wl0gHRvNDEs5zc2yDFiey8IAygIIaRmiMeQPI/0/7M6kOqt7OIFs
 AZvpJCE3KEWwCwyn+MvZ30WycNV9pXLRCX4pTd5Ry/WbkCXfdeDd8oSrckn7O3GdsO5QTmZpur1
 nIyERrsLXT9l4LUE+gJ4TsXWe9aI5GAohYd77TIUXM+rQPvsYHDfwxurn6RlATqIcELWrJoj70w
 W1EIVRQBMVOau/yqXTAGi/m4LgYsh+5bsz7A62S6gEILxXM7a7v7Qppw6Ev4=
X-Google-Smtp-Source: AGHT+IE3yGpZQVaqnPfZnrh9IOFPr8Oc0seaZXE6QxZgyz0DPQMvm9yfefb+PXx4g50yg6QEH1avTg==
X-Received: by 2002:a05:6871:9d11:b0:2c8:5831:8d4 with SMTP id
 586e51a60fabf-2ffaf5a4a38mr6866190fac.39.1752801354804; 
 Thu, 17 Jul 2025 18:15:54 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3010478ee09sm202039fac.46.2025.07.17.18.15.53
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 18:15:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] sandbox: Add more dummy functions to mimic other architectures
Date: Thu, 17 Jul 2025 19:15:52 -0600
Message-ID: <20250718011552.1334023-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

This adds more common functions found on other architectures that will
allow for more compile-testing of drivers. These are either dummy
functions as we do not need them or mappings to existing functions,
similar to how other architectures handle it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/sandbox/include/asm/dma-mapping.h | 27 ++++++++++++++++++++++++++
 arch/sandbox/include/asm/io.h          | 13 +++++++++++++
 arch/sandbox/include/asm/processor.h   |  3 ++-
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/sandbox/include/asm/dma-mapping.h b/arch/sandbox/include/asm/dma-mapping.h
index 853b0877b33d..410760c2231a 100644
--- a/arch/sandbox/include/asm/dma-mapping.h
+++ b/arch/sandbox/include/asm/dma-mapping.h
@@ -1 +1,28 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copied from arch/arm/include/asm/dma-mapping.h which is:
+ *
+ * (C) Copyright 2007
+ * Stelian Pop <stelian@popies.net>
+ * Lead Tech Design <www.leadtechdesign.com>
+ */
+
+#ifndef __ASM_SANDBOX_DMA_MAPPING_H
+#define __ASM_SANDBOX_DMA_MAPPING_H
+
+#include <asm/cache.h>
+#include <linux/types.h>
+#include <malloc.h>
+
+static inline void *dma_alloc_coherent(size_t len, unsigned long *handle)
+{
+	*handle = (unsigned long)memalign(ARCH_DMA_MINALIGN, ROUND(len, ARCH_DMA_MINALIGN));
+	return (void *)*handle;
+}
+
+static inline void dma_free_coherent(void *addr)
+{
+	free(addr);
+}
+
+#endif
diff --git a/arch/sandbox/include/asm/io.h b/arch/sandbox/include/asm/io.h
index 11ed89e00710..72953828f96a 100644
--- a/arch/sandbox/include/asm/io.h
+++ b/arch/sandbox/include/asm/io.h
@@ -12,6 +12,9 @@ static inline void sync(void)
 {
 }
 
+#define mb()	sync()
+#define dmb()	sync()
+
 enum sandboxio_size_t {
 	SB_SIZE_8,
 	SB_SIZE_16,
@@ -53,6 +56,16 @@ void sandbox_write(void *addr, unsigned int val, enum sandboxio_size_t size);
 #define writeq(v, addr) sandbox_write((void *)addr, v, SB_SIZE_64)
 #endif
 
+#define readb_relaxed			readb
+#define readw_relaxed			readw
+#define readl_relaxed			readl
+#define readq_relaxed			readq
+
+#define writeb_relaxed			writeb
+#define writew_relaxed			writew
+#define writel_relaxed			writel
+#define writeq_relaxed			writeq
+
 /*
  * Clear and set bits in one shot. These macros can be used to clear and
  * set multiple bits in a register using a single call. These macros can
diff --git a/arch/sandbox/include/asm/processor.h b/arch/sandbox/include/asm/processor.h
index 8dced6006bd0..6521274efb01 100644
--- a/arch/sandbox/include/asm/processor.h
+++ b/arch/sandbox/include/asm/processor.h
@@ -6,6 +6,7 @@
 #ifndef _ASM_PROCESSOR_H
 #define _ASM_PROCESSOR_H
 
-/* This file is required for PCI */
+/* Assorted dummy functions */
+#define cpu_relax()
 
 #endif
-- 
2.43.0

