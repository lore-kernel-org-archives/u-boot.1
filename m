Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034DDD2CDFA
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 16:31:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ABA689049;
	Tue, 22 Oct 2024 18:31:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NPDFTf31";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D1FD890CE; Tue, 22 Oct 2024 18:31:24 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C60C88FD6
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 18:31:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b1505ef7e3so341082285a.0
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 09:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729614681; x=1730219481; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iQGClOQdgxlwGWuAxyMRTZ0WvOczgZ30jhx3CEDx30g=;
 b=NPDFTf31LrMm9RW9+O6HY009zeXIZ9O6thK+dbdzgu2JKTiTaWA5GjmZkoZE3JH4nw
 VU7OzDkJyYIhxV9uLieA1YDv++silOqQ/EGly0a86GA+3uZMdUkioswp3u6T2Qm2KI3G
 L0BPsL4l+8iGF7y6Nl58BFwTsfCGxujsTxESo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729614681; x=1730219481;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iQGClOQdgxlwGWuAxyMRTZ0WvOczgZ30jhx3CEDx30g=;
 b=KcW7+3AQsCARPG5j/7wptJQLXjJotzQs7Uzw/O0cSAqNSAX070PduZaboPaa51PSo0
 mffFgoWpRfrOQbSYkEp75cMFnug5/YvBMwKPnUrDm8wCOGEe3mAhZJX/gITAszM/0JCc
 BGfJtdOo2xZ3xtg6+RFKGgb6A6RflChaAeGMd1LFpGiuWVmpkbPf6HX3WOIneXoKCMvH
 QLPT8kQdmNAau9tuQVlqwrEuEIpnd83oFm8dJYItrvaMbGltu+2mIFcWs34/tLB4/pnI
 4WN2sEcalYqp1lxLTKUhNPC2l35qulBGlWWthRFmOc3g1IAdwUie0mPkL32CIuXhQpzn
 nqvQ==
X-Gm-Message-State: AOJu0YyO3LSgmtlEd0kGQfjV5LoVRW5xrGnSK707go/GnUjqufqqMwya
 b2dnfmVZq83DKBBIFnVSumaWhXWOncoqz9L3beOjTg4nkJ5Lc7gCC+6i5joi4f10w9F8lpD+TZz
 g3Aw/jw==
X-Google-Smtp-Source: AGHT+IFyTV8QbcsiX6FhXSNu+q1eH1gCeZaNNAIt2btNhD81LCSVMrLRSf8GbjgGUV4zJy8I8ynrVg==
X-Received: by 2002:a05:620a:3187:b0:7a9:bf33:c17a with SMTP id
 af79cd13be357-7b157b6b63dmr2240493285a.33.1729614680884; 
 Tue, 22 Oct 2024 09:31:20 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b165a5c5efsm293404885a.98.2024.10.22.09.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 09:31:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCHv2 1/2] CONFIG_SYS_NONCACHED_MEMORY: Move prototypes to
 include/cpu_func.h for consistency
Date: Tue, 22 Oct 2024 10:31:17 -0600
Message-ID: <20241022163118.3128014-1-trini@konsulko.com>
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

Currently, a number of generic cache related functions have their common
prototype declared in include/cpu_func.h. Move the current set of
noncached functions there as well to match.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- New patch because of build failures noticed on v1.
---
 arch/arm/include/asm/system.h  | 16 ----------------
 arch/mips/include/asm/system.h | 14 --------------
 include/cpu_func.h             | 13 +++++++++++++
 3 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 2237d7d00668..8a932d4e192d 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -656,22 +656,6 @@ void mmu_set_region_dcache_behaviour_phys(phys_addr_t virt, phys_addr_t phys,
 void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
 				     enum dcache_option option);
 
-#ifdef CONFIG_SYS_NONCACHED_MEMORY
-/**
- * noncached_init() - Initialize non-cached memory region
- *
- * Initialize non-cached memory area. This memory region will be typically
- * located right below the malloc() area and mapped uncached in the MMU.
- *
- * It is called during the generic post-relocation init sequence.
- *
- * Return: 0 if OK
- */
-int noncached_init(void);
-
-phys_addr_t noncached_alloc(size_t size, size_t align);
-#endif /* CONFIG_SYS_NONCACHED_MEMORY */
-
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/mips/include/asm/system.h b/arch/mips/include/asm/system.h
index 89a2ac209fce..00699c4c11a5 100644
--- a/arch/mips/include/asm/system.h
+++ b/arch/mips/include/asm/system.h
@@ -286,20 +286,6 @@ static inline void instruction_hazard_barrier(void)
 /* 1MB granularity */
 #define MMU_SECTION_SHIFT	20
 #define MMU_SECTION_SIZE	(1 << MMU_SECTION_SHIFT)
-
-/**
- * noncached_init() - Initialize non-cached memory region
- *
- * Initialize non-cached memory area. This memory region will be typically
- * located right below the malloc() area and be accessed from KSEG1.
- *
- * It is called during the generic post-relocation init sequence.
- *
- * Return: 0 if OK
- */
-int noncached_init(void);
-
-phys_addr_t noncached_alloc(size_t size, size_t align);
 #endif /* CONFIG_SYS_NONCACHED_MEMORY */
 
 #endif /* _ASM_SYSTEM_H */
diff --git a/include/cpu_func.h b/include/cpu_func.h
index 45e8a0a05778..dba7d102e897 100644
--- a/include/cpu_func.h
+++ b/include/cpu_func.h
@@ -69,6 +69,19 @@ void flush_dcache_range(unsigned long start, unsigned long stop);
 void invalidate_dcache_range(unsigned long start, unsigned long stop);
 void invalidate_dcache_all(void);
 void invalidate_icache_all(void);
+/**
+ * noncached_init() - Initialize non-cached memory region
+ *
+ * Initialize non-cached memory area. This memory region will be typically
+ * located right below the malloc() area and mapped uncached in the MMU.
+ *
+ * It is called during the generic post-relocation init sequence.
+ *
+ * Return: 0 if OK
+ */
+int noncached_init(void);
+
+phys_addr_t noncached_alloc(size_t size, size_t align);
 
 enum {
 	/* Disable caches (else flush caches but leave them active) */
-- 
2.43.0

