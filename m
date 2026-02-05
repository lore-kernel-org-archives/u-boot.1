Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67462ECD9AA
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 23:53:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B71083BDD;
	Fri,  6 Feb 2026 00:52:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GZTl90/Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E54128341A; Fri,  6 Feb 2026 00:52:20 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18C7D83AAD
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 00:52:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-4044d3ff57bso70014fac.0
 for <u-boot@lists.denx.de>; Thu, 05 Feb 2026 15:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770335537; x=1770940337;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cUGRU+3I7AeiqNyurbboDJji+YLkSPh5WMTm/6EJ72A=;
 b=GZTl90/QmvIouxrcGUTphYlqRsQtUnbe4GDkAkTZ7+dIQLjvHtnZNCQMKRO9q/YhdC
 xpUyAZ+wnk8HmgY+RaCE8gvVjYwucPJq57P4D4Z8S8wvO+x4d7q5UjUh62HFACDvYvIP
 VdZRAb778cR8hMhzHJfNfyzmZi/LN0brGKNAQqPKuvf1EvUE/gGdXFMNUKa8qqtvFgg6
 CEjZhv6kFVR5/OGJu+pzkmVGJr3xXxlvh5KzdGCXzKrZxWiQ8IEAgozPbZXtTU89wE2K
 HLRlbYH0rpNV6uIyvoWhu8PiqHh+KKU6D2B8XMhllVB1YUTjswCVMwQJ/rIejBBqGLNU
 IHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770335537; x=1770940337;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cUGRU+3I7AeiqNyurbboDJji+YLkSPh5WMTm/6EJ72A=;
 b=T8H8fs6HNyZLdvSsgrIBG2KgXuf7KO5uFHhxiUNBqSYrh1g99gyi5coy8VWF4gFbkJ
 aeZMtzpVEarZSZNfi6xSjJ7Zj3XZQwDAox2CdyAPuC57cQvwIj9Xpsb3YbaBp747zVPp
 cVOkJRP7rqfRR4jCjJzrsAH6EigNqmWeG7soNtotmq36C9d24+xzIEJDXKY+EtwAIEJh
 zCooUOTvakidU9FewAR4r2a7qz0k8CZ9zVasyqlVMCCynKXKiiOec5d8F0TqKAisg5cH
 WO1q35Nz2D7FtMXnUiR/pRa5tRbFvSBNs+qfUVEeh2MOeT/GUjnbHpJ6pjxrruo6tul1
 sLxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5wiZ8lxR10BTlS6eO67VATFIswTuwe30qQHDzEB45XbgpKAMPSCpZL6DP8G+HjU3dIOeE90A=@lists.denx.de
X-Gm-Message-State: AOJu0YwXwd84WbGBmQ/qxmEZ/wdIGOd4ULcZz7RHsNMcoS4NQoir+LVJ
 a2XhkOkSdQiyB8sQxhNgEN8WP9Uc197woh+zrMwTC4KTyzqtOARuPJ/0haD0qIOyaT8=
X-Gm-Gg: AZuq6aI70nqA5P4yxscLffqMf1OlNGAEGBj6mbeNEXwHqm9P79evh1nlfEtNtEfpLDU
 ZGvlMd8Kk4wmNeehHEzq79p9RdM7EOEb955OlVLwpl23qu1G1fe48rtjJe4afduV/CyhgV9X39S
 2e27wd4J5dG4kyWQDSUWDnAh4Rb5qJms8Mcb8m+c0kl7FmrssxJUVzhzY1eeSYD8B8/ERj6iz0i
 HSvCWJMBL2qafRhr5F1NkKQzLtLaW6qd4BNBk+4Q4xsBlgtFbKR1K1/rlPMhhnHd8UunxYHYGa1
 FEFg4BIg5h3tpwpX6oVtgnvsdMZ+XVcoeDLTnJjRbBfwiuHKP508wMhssDkZzezdATmTmI5p2bQ
 J834JT2qbuzNSsVcduaLfkt/Dd9/qvsf8aK72HJ/XnXFvEG1SC7D8nU3gxTjLhA2ZAm3PtwgmM1
 XiAd5UBuTs77LdDhM=
X-Received: by 2002:a05:6820:4a12:b0:65f:698e:d5ba with SMTP id
 006d021491bc7-66d09ac2700mr411748eaf.17.1770335536807; 
 Thu, 05 Feb 2026 15:52:16 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4487:26aa:aa87:6ade])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66d3adcae3csm312165eaf.9.2026.02.05.15.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 15:52:16 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 05 Feb 2026 17:51:29 -0600
Subject: [PATCH 5/5] arm: mediatek: consolidate ARMv8 memory maps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-mtk-mach-clean-up-duplicates-v1-5-b7d4a43c18eb@baylibre.com>
References: <20260205-mtk-mach-clean-up-duplicates-v1-0-b7d4a43c18eb@baylibre.com>
In-Reply-To: <20260205-mtk-mach-clean-up-duplicates-v1-0-b7d4a43c18eb@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=13627;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=Kwg9Fa+pH00HfeucXLAsFtc/2UKCIIvcA8r6AkUWfHU=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBphS0kYFg6TFhM32vL7TDB0V97m/H2K6Fzh6Cm8
 aBFiSuyBdeJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaYUtJBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AevQH/R0nrw9UUb1grFsgBB7OrHlpVcCx/QYcfo/1r7v
 pDRueYtvuKQ2kde3sSRz4kNHQGKBSdDGn/AxfsRKvkfWXKSdY/7E5gB7+RgByJNihUuiEshW71z
 4YZwwZOQKr8Hkt9v6XvJHsaWhgL/dMPHPo5OVUhAiccxMg2CzNbi4/IAR6DfdtAOFsUkbuuaC+s
 0thGIEjEdJWYroSQo0zhKvHGuSXoTwafrvzOmL4ZQx0TeZ2Gcqi004NaOrnRaQYWdEgFq70Rd/s
 KRXq9qBJr62HAAAohsdAwTladZYf3ahTaNJYpPQuTdPEGnAUwf7zvVLC+z4s+AxBTv05Ani8+9W
 TYoY=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Fri, 06 Feb 2026 00:52:32 +0100
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

Consolidate all mem_map definitions for MediaTek ARMv8 platforms into a
single file. The size of the DDR and MMIO regions can vary, so Kconfig
options are added to configure them by target.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/Kconfig                     | 21 ++++++++++++++++
 arch/arm/mach-mediatek/Makefile                    |  1 +
 .../arm/mach-mediatek/armv8-mem-map.c              | 14 ++++-------
 arch/arm/mach-mediatek/mt7622/init.c               | 20 ---------------
 arch/arm/mach-mediatek/mt7981/init.c               | 21 ----------------
 arch/arm/mach-mediatek/mt7986/init.c               | 21 ----------------
 arch/arm/mach-mediatek/mt7987/init.c               | 21 ----------------
 arch/arm/mach-mediatek/mt7988/init.c               | 21 ----------------
 arch/arm/mach-mediatek/mt8183/init.c               | 20 ---------------
 arch/arm/mach-mediatek/mt8512/init.c               | 21 ----------------
 arch/arm/mach-mediatek/mt8516/init.c               | 20 ---------------
 arch/arm/mach-mediatek/mt8518/init.c               | 21 ----------------
 board/mediatek/mt8365_evk/MAINTAINERS              |  5 ----
 board/mediatek/mt8365_evk/Makefile                 |  3 ---
 board/mediatek/mt8390_evk/MAINTAINERS              |  6 -----
 board/mediatek/mt8390_evk/Makefile                 |  3 ---
 board/mediatek/mt8390_evk/mt8390_evk.c             | 29 ----------------------
 17 files changed, 27 insertions(+), 241 deletions(-)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index d1d2605b2cc..33717a1864f 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -130,6 +130,27 @@ config TARGET_MT8518
 
 endchoice
 
+if ARM64
+
+config MTK_MEM_MAP_DDR_SIZE
+	hex "DDR .size in mem_map"
+	default 0x200000000 if TARGET_MT7987 || TARGET_MT7988 || TARGET_MT8188
+	default 0xc0000000 if TARGET_MT8365
+	default 0x80000000 if TARGET_MT7981 || TARGET_MT7986 || TARGET_MT8183
+	default 0x40000000 if TARGET_MT7622 || TARGET_MT8512
+	default 0x20000000
+	help
+		Target-specific DDR region size in mem_map.
+
+config MTK_MEM_MAP_MMIO_SIZE
+	hex "MMIO .size in mem_map"
+	default 0x40000000 if TARGET_MT7622 || TARGET_MT7981 || TARGET_MT7986 || TARGET_MT7987 || TARGET_MT7988 || TARGET_MT8512
+	default 0x20000000
+	help
+		Target-specific MMIO region size in mem_map.
+
+endif
+
 config SYS_BOARD
 	string "Board name"
 	default "mt7622" if TARGET_MT7622
diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
index 44591bed6fa..17e645989e5 100644
--- a/arch/arm/mach-mediatek/Makefile
+++ b/arch/arm/mach-mediatek/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier:	GPL-2.0
 
+obj-$(CONFIG_ARM64) += armv8-mem-map.o
 obj-y	+= cpu.o
 obj-$(CONFIG_MTK_TZ_MOVABLE)	+= tzcfg.o
 obj-$(CONFIG_XPL_BUILD)	+= spl.o
diff --git a/board/mediatek/mt8365_evk/mt8365_evk.c b/arch/arm/mach-mediatek/armv8-mem-map.c
similarity index 55%
rename from board/mediatek/mt8365_evk/mt8365_evk.c
rename to arch/arm/mach-mediatek/armv8-mem-map.c
index 41a6febf03d..0abddb99f25 100644
--- a/board/mediatek/mt8365_evk/mt8365_evk.c
+++ b/arch/arm/mach-mediatek/armv8-mem-map.c
@@ -1,22 +1,18 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2023 BayLibre SAS
- * Author: Julien Masson <jmasson@baylibre.com>
- */
+// SPDX-License-Identifier: GPL-2.0-only
 
 #include <asm/armv8/mmu.h>
 
-static struct mm_region mt8365_evk_mem_map[] = {
+static struct mm_region mediatek_mem_map[] = {
 	{
 		/* DDR */
 		.virt = 0x40000000UL,
 		.phys = 0x40000000UL,
-		.size = 0xc0000000UL,
+		.size = CONFIG_MTK_MEM_MAP_DDR_SIZE,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
 	}, {
 		.virt = 0x00000000UL,
 		.phys = 0x00000000UL,
-		.size = 0x20000000UL,
+		.size = CONFIG_MTK_MEM_MAP_MMIO_SIZE,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
@@ -25,4 +21,4 @@ static struct mm_region mt8365_evk_mem_map[] = {
 	}
 };
 
-struct mm_region *mem_map = mt8365_evk_mem_map;
+struct mm_region *mem_map = mediatek_mem_map;
diff --git a/arch/arm/mach-mediatek/mt7622/init.c b/arch/arm/mach-mediatek/mt7622/init.c
index 368f2916224..a043ca87398 100644
--- a/arch/arm/mach-mediatek/mt7622/init.c
+++ b/arch/arm/mach-mediatek/mt7622/init.c
@@ -36,23 +36,3 @@ void reset_cpu(void)
 {
 	psci_system_reset();
 }
-
-static struct mm_region mt7622_mem_map[] = {
-	{
-		/* DDR */
-		.virt = 0x40000000UL,
-		.phys = 0x40000000UL,
-		.size = 0x40000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
-	}, {
-		.virt = 0x00000000UL,
-		.phys = 0x00000000UL,
-		.size = 0x40000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		0,
-	}
-};
-struct mm_region *mem_map = mt7622_mem_map;
diff --git a/arch/arm/mach-mediatek/mt7981/init.c b/arch/arm/mach-mediatek/mt7981/init.c
index 07da5897190..79afd6ce6be 100644
--- a/arch/arm/mach-mediatek/mt7981/init.c
+++ b/arch/arm/mach-mediatek/mt7981/init.c
@@ -30,24 +30,3 @@ void reset_cpu(void)
 {
 	psci_system_reset();
 }
-
-static struct mm_region mt7981_mem_map[] = {
-	{
-		/* DDR */
-		.virt = 0x40000000UL,
-		.phys = 0x40000000UL,
-		.size = 0x80000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
-	}, {
-		.virt = 0x00000000UL,
-		.phys = 0x00000000UL,
-		.size = 0x40000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		0,
-	}
-};
-
-struct mm_region *mem_map = mt7981_mem_map;
diff --git a/arch/arm/mach-mediatek/mt7986/init.c b/arch/arm/mach-mediatek/mt7986/init.c
index a521c95bd9d..1fe56b3f145 100644
--- a/arch/arm/mach-mediatek/mt7986/init.c
+++ b/arch/arm/mach-mediatek/mt7986/init.c
@@ -30,24 +30,3 @@ void reset_cpu(void)
 {
 	psci_system_reset();
 }
-
-static struct mm_region mt7986_mem_map[] = {
-	{
-		/* DDR */
-		.virt = 0x40000000UL,
-		.phys = 0x40000000UL,
-		.size = 0x80000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
-	}, {
-		.virt = 0x00000000UL,
-		.phys = 0x00000000UL,
-		.size = 0x40000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		0,
-	}
-};
-
-struct mm_region *mem_map = mt7986_mem_map;
diff --git a/arch/arm/mach-mediatek/mt7987/init.c b/arch/arm/mach-mediatek/mt7987/init.c
index 8b268297809..6364ab497f7 100644
--- a/arch/arm/mach-mediatek/mt7987/init.c
+++ b/arch/arm/mach-mediatek/mt7987/init.c
@@ -39,24 +39,3 @@ void reset_cpu(ulong addr)
 {
 	psci_system_reset();
 }
-
-static struct mm_region mt7987_mem_map[] = {
-	{
-		/* DDR */
-		.virt = 0x40000000UL,
-		.phys = 0x40000000UL,
-		.size = 0x200000000ULL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
-	}, {
-		.virt = 0x00000000UL,
-		.phys = 0x00000000UL,
-		.size = 0x40000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		0,
-	}
-};
-
-struct mm_region *mem_map = mt7987_mem_map;
diff --git a/arch/arm/mach-mediatek/mt7988/init.c b/arch/arm/mach-mediatek/mt7988/init.c
index 8bdd3848d26..7ff843585ec 100644
--- a/arch/arm/mach-mediatek/mt7988/init.c
+++ b/arch/arm/mach-mediatek/mt7988/init.c
@@ -38,24 +38,3 @@ void reset_cpu(ulong addr)
 {
 	psci_system_reset();
 }
-
-static struct mm_region mt7988_mem_map[] = {
-	{
-		/* DDR */
-		.virt = 0x40000000UL,
-		.phys = 0x40000000UL,
-		.size = 0x200000000ULL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
-	}, {
-		.virt = 0x00000000UL,
-		.phys = 0x00000000UL,
-		.size = 0x40000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		0,
-	}
-};
-
-struct mm_region *mem_map = mt7988_mem_map;
diff --git a/arch/arm/mach-mediatek/mt8183/init.c b/arch/arm/mach-mediatek/mt8183/init.c
index b445f3ea1e3..8dbf9c3df7e 100644
--- a/arch/arm/mach-mediatek/mt8183/init.c
+++ b/arch/arm/mach-mediatek/mt8183/init.c
@@ -47,23 +47,3 @@ int print_cpuinfo(void)
 	printf("CPU:   MediaTek MT8183\n");
 	return 0;
 }
-
-static struct mm_region mt8183_mem_map[] = {
-	{
-		/* DDR */
-		.virt = 0x40000000UL,
-		.phys = 0x40000000UL,
-		.size = 0x80000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
-	}, {
-		.virt = 0x00000000UL,
-		.phys = 0x00000000UL,
-		.size = 0x20000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		0,
-	}
-};
-struct mm_region *mem_map = mt8183_mem_map;
diff --git a/arch/arm/mach-mediatek/mt8512/init.c b/arch/arm/mach-mediatek/mt8512/init.c
index 3b48caf5196..361c589cbc2 100644
--- a/arch/arm/mach-mediatek/mt8512/init.c
+++ b/arch/arm/mach-mediatek/mt8512/init.c
@@ -59,24 +59,3 @@ int print_cpuinfo(void)
 	debug("CPU:   MediaTek MT8512\n");
 	return 0;
 }
-
-static struct mm_region mt8512_mem_map[] = {
-	{
-		/* DDR */
-		.virt = 0x40000000UL,
-		.phys = 0x40000000UL,
-		.size = 0x40000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
-	}, {
-		.virt = 0x00000000UL,
-		.phys = 0x00000000UL,
-		.size = 0x40000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		0,
-	}
-};
-
-struct mm_region *mem_map = mt8512_mem_map;
diff --git a/arch/arm/mach-mediatek/mt8516/init.c b/arch/arm/mach-mediatek/mt8516/init.c
index 82f8c509745..1d925dd478a 100644
--- a/arch/arm/mach-mediatek/mt8516/init.c
+++ b/arch/arm/mach-mediatek/mt8516/init.c
@@ -94,23 +94,3 @@ int print_cpuinfo(void)
 	printf("CPU:   MediaTek MT8516\n");
 	return 0;
 }
-
-static struct mm_region mt8516_mem_map[] = {
-	{
-		/* DDR */
-		.virt = 0x40000000UL,
-		.phys = 0x40000000UL,
-		.size = 0x20000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
-	}, {
-		.virt = 0x00000000UL,
-		.phys = 0x00000000UL,
-		.size = 0x20000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		0,
-	}
-};
-struct mm_region *mem_map = mt8516_mem_map;
diff --git a/arch/arm/mach-mediatek/mt8518/init.c b/arch/arm/mach-mediatek/mt8518/init.c
index c04bcb63517..8fa1346021a 100644
--- a/arch/arm/mach-mediatek/mt8518/init.c
+++ b/arch/arm/mach-mediatek/mt8518/init.c
@@ -51,24 +51,3 @@ int print_cpuinfo(void)
 	printf("CPU:   MediaTek MT8518\n");
 	return 0;
 }
-
-static struct mm_region mt8518_mem_map[] = {
-	{
-		/* DDR */
-		.virt = 0x40000000UL,
-		.phys = 0x40000000UL,
-		.size = 0x20000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
-	}, {
-		.virt = 0x00000000UL,
-		.phys = 0x00000000UL,
-		.size = 0x20000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		0,
-	}
-};
-
-struct mm_region *mem_map = mt8518_mem_map;
diff --git a/board/mediatek/mt8365_evk/MAINTAINERS b/board/mediatek/mt8365_evk/MAINTAINERS
deleted file mode 100644
index e0d65efe812..00000000000
--- a/board/mediatek/mt8365_evk/MAINTAINERS
+++ /dev/null
@@ -1,5 +0,0 @@
-MT8365 EVK
-M:	Julien Masson <jmasson@baylibre.com>
-S:	Maintained
-F:	board/mediatek/mt8365_evk/
-F:	configs/mt8365_evk_defconfig
diff --git a/board/mediatek/mt8365_evk/Makefile b/board/mediatek/mt8365_evk/Makefile
deleted file mode 100644
index 90fc92b28c5..00000000000
--- a/board/mediatek/mt8365_evk/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier:	GPL-2.0
-
-obj-y += mt8365_evk.o
diff --git a/board/mediatek/mt8390_evk/MAINTAINERS b/board/mediatek/mt8390_evk/MAINTAINERS
deleted file mode 100644
index d46b8b2e156..00000000000
--- a/board/mediatek/mt8390_evk/MAINTAINERS
+++ /dev/null
@@ -1,6 +0,0 @@
-MT8390 EVK
-M:	Julien Masson <jmasson@baylibre.com>
-M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
-S:	Maintained
-F:	board/mediatek/mt8390_evk/
-F:	configs/mt8390_evk_defconfig
diff --git a/board/mediatek/mt8390_evk/Makefile b/board/mediatek/mt8390_evk/Makefile
deleted file mode 100644
index a26d46838c4..00000000000
--- a/board/mediatek/mt8390_evk/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier:	GPL-2.0
-
-obj-y += mt8390_evk.o
diff --git a/board/mediatek/mt8390_evk/mt8390_evk.c b/board/mediatek/mt8390_evk/mt8390_evk.c
deleted file mode 100644
index 5731199bf83..00000000000
--- a/board/mediatek/mt8390_evk/mt8390_evk.c
+++ /dev/null
@@ -1,29 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2026 BayLibre SAS
- * Author: Julien Masson <jmasson@baylibre.com>
- */
-
-#include <linux/types.h>
-#include <asm/armv8/mmu.h>
-
-static struct mm_region mt8390_evk_mem_map[] = {
-	{
-		/* DDR */
-		.virt = 0x40000000UL,
-		.phys = 0x40000000UL,
-		.size = 0x200000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
-	}, {
-		.virt = 0x00000000UL,
-		.phys = 0x00000000UL,
-		.size = 0x20000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		0,
-	}
-};
-
-struct mm_region *mem_map = mt8390_evk_mem_map;

-- 
2.43.0

