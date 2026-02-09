Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7522E7E0CD
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 17:13:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B133983D0B;
	Mon,  9 Feb 2026 18:12:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Lh+z+VHc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B74698341A; Mon,  9 Feb 2026 17:40:31 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4569C805D7
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 17:40:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7cfd9b898cdso2702221a34.2
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 08:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770655228; x=1771260028;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GUJW7S413G0RwyPC/q29z3hHbdcHZIzRCOLvXMZr4NU=;
 b=Lh+z+VHcMgVqZVgOBfWdhLIzhGy1PKT7omVWSJs3VE2pSztffObxgcDFUaM427PQpC
 i/ETfrOotqGz9g+P5OvnKPQJEjYsEauPbWi8GSo4P8uGuu586jglXQfW+WbGTYrSEzkS
 ybUBNzVMs7m7MNqSV9FBFGTesiv99zrjRB0MFayJUh8mUXwdGCYMK2z9cdfVdQhg7JKK
 yc6PLNs7pyOeQyG7NfFTZbm66JsJy+muzPQUpiNMlBiIJEyLZsFwZ8hzZzXK1csr2Mkn
 6a6f97BAx+/bQY2z8D03OD4LsuhUws4ecSyRaRAxcj4G/uMSRo+8JxflBejqbmZM9+rM
 cHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770655228; x=1771260028;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GUJW7S413G0RwyPC/q29z3hHbdcHZIzRCOLvXMZr4NU=;
 b=uuBzJBD9fIGIZLKGyAKY5bFhzprlxIlvPhgoZaPWj5vi7X2T4xYClXxrUEmcM96Ph8
 01doTxVjJs0DCzryyKyr1cx/FdShYFRdrqqdvKKDSlVjCG8iH/h+o04ZU0+H9x6aGSU8
 GZWF8K/bN2bPnHWR3IIIhcsTtQqrh4ER1i1umdSVugchIVJPvMWq6HzNYuItURkxw8bw
 mGbXCXwkx7G2THpa/2mUivrm3kAwp1Jp2qOPZk1+yXnJYTwByJ3i3UTsr22mr0fqEF+5
 +AXCNeWIIlSgenSU5/gbN/LjYM6RnJRLLkbmc3b8MZzE9cRFTeNlx/SaQ8onGMy0PerI
 MUDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/5jgbMOyR9qhHzUmj/WwmN00zg0Du0D7GEFwhiVRVIqbTEHFlJ4oYFM8jqnbADMecvk7zvps=@lists.denx.de
X-Gm-Message-State: AOJu0YyyFecVxaca1abqxTLCQ6z7kc7QCBtOF+rSY+OQsIy3sWGWKvGi
 qXZ+x7mGaxNiLI8rhun3oTiK9xLFifdM3UbBEKt41+Oxlg1LkzWkVo1V93ZFtx+MjTE=
X-Gm-Gg: AZuq6aJDqtrN2U8dPxPWew8p7sceNgQRf27Aju3nycTaI20F59tGnbzXPEqxqrWJfiF
 IihB5YRcuvElPRi0HKHNjx0ph7e4giRcympUxB3d2ijW4cwwLbdJ2xlGWSwq2xzQ4Nj2C0wFF5Z
 YZMb0wIVhpm8bJbJwnV6PA+lgWj+p0gSwBADBolz/K2qIXAg9vuhkM0EXPOdGVy+YkxUZraf7gO
 EgoBK2DTa50sM0yRKO4maCP8MFXzoip1PsZ8uu3Hw0V8SmFondkMZ8nbqNtLEdzbqpCvH7NUSs4
 ziSdkM/Y3ukAnPPr3O+Vy3qAQAhMW6slUG3zMhCTTWdo0fiGT++/rhgt5wEz1lx1prx+MrIJqgF
 e5IjTc6BANu7JTIEEl62mOfc3ayiGI6r2Sej/AfW1tTzabEHQkJOxfl+yKcVrAd+UxsUCglcDt/
 oAgf//poXiy3mKCgY=
X-Received: by 2002:a05:6830:8287:b0:7cf:d4b2:d64e with SMTP id
 46e09a7af769-7d4643e57e9mr6884070a34.3.1770655227927; 
 Mon, 09 Feb 2026 08:40:27 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cee0:eb0c:b683:ad1d])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d464785d7esm7731139a34.15.2026.02.09.08.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 08:40:27 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 09 Feb 2026 10:39:31 -0600
Subject: [PATCH v2 6/7] arm: mediatek: consolidate ARMv8 memory maps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-mtk-mach-clean-up-duplicates-v2-6-e3b22282c74d@baylibre.com>
References: <20260209-mtk-mach-clean-up-duplicates-v2-0-e3b22282c74d@baylibre.com>
In-Reply-To: <20260209-mtk-mach-clean-up-duplicates-v2-0-e3b22282c74d@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=13348;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=2JiSZM2AoHp9CztPoQCowsq/dkCaZZ4Ly67X2JF9JCM=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpig3pe+JKqwfn9srcQRJyFc/qTYHEZdrGtWpd0
 QeFSGOc//+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaYoN6RYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A6ewH/j2Xvry/djjXdxwXMDv3ZhgIyLrw5kkZqhLAY/E
 7Wogf/l8nrqwggZxRa0CUaxXJBpnDM7qV6iHQVde74IiFdVrsMDIDsKvA06/SqFpR+E1ByJ0bMZ
 L3acMizxpr0OEyE3+wYV1Vn/rXt2Tpe+MQRI94FCEz1o0Zo7lZPzq9vPC7qhgp+CeleakmqbUvh
 4IpouMrMjS1cYQ77VfpC66j78Tv7o+fRqbcSCTV6tZn/MtpgeUXVh9vFhb0JhSzgBpcq6Ie/6GO
 5q0yCbhHdAbl5czLvsxO7fMbwFUpjgCAkLWf1ohQnHE4bpXcQkDe/xAGwxy9VPnSfM/EePVC8Zg
 1xCc=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Mon, 09 Feb 2026 18:12:16 +0100
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
v2 changes:
* Don't delete defconfig entries in MAINTAINERS.
---
 arch/arm/mach-mediatek/Kconfig                     | 21 ++++++++++++++++
 arch/arm/mach-mediatek/Makefile                    |  1 +
 .../arm/mach-mediatek/armv8-mem-map.c              | 16 +++++-------
 arch/arm/mach-mediatek/mt7622/init.c               | 20 ---------------
 arch/arm/mach-mediatek/mt7981/init.c               | 21 ----------------
 arch/arm/mach-mediatek/mt7986/init.c               | 21 ----------------
 arch/arm/mach-mediatek/mt7987/init.c               | 21 ----------------
 arch/arm/mach-mediatek/mt7988/init.c               | 21 ----------------
 arch/arm/mach-mediatek/mt8183/init.c               | 20 ---------------
 arch/arm/mach-mediatek/mt8512/init.c               | 21 ----------------
 arch/arm/mach-mediatek/mt8516/init.c               | 20 ---------------
 arch/arm/mach-mediatek/mt8518/init.c               | 21 ----------------
 board/mediatek/MAINTAINERS                         |  2 --
 board/mediatek/mt8365_evk/Makefile                 |  3 ---
 board/mediatek/mt8390_evk/Makefile                 |  3 ---
 board/mediatek/mt8390_evk/mt8390_evk.c             | 29 ----------------------
 16 files changed, 28 insertions(+), 233 deletions(-)

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
similarity index 54%
rename from board/mediatek/mt8365_evk/mt8365_evk.c
rename to arch/arm/mach-mediatek/armv8-mem-map.c
index 41a6febf03d..3587a2a9dd2 100644
--- a/board/mediatek/mt8365_evk/mt8365_evk.c
+++ b/arch/arm/mach-mediatek/armv8-mem-map.c
@@ -1,28 +1,24 @@
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
 	}, {
-		0,
+		/* List terminator */
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
diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 3345c87d30b..5d19892e26b 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -1,12 +1,10 @@
 MT8365 EVK
 M:	Julien Masson <jmasson@baylibre.com>
 S:	Maintained
-F:	board/mediatek/mt8365_evk/
 F:	configs/mt8365_evk_defconfig
 
 MT8390 EVK
 M:	Julien Masson <jmasson@baylibre.com>
 M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
 S:	Maintained
-F:	board/mediatek/mt8390_evk/
 F:	configs/mt8390_evk_defconfig
diff --git a/board/mediatek/mt8365_evk/Makefile b/board/mediatek/mt8365_evk/Makefile
deleted file mode 100644
index 90fc92b28c5..00000000000
--- a/board/mediatek/mt8365_evk/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier:	GPL-2.0
-
-obj-y += mt8365_evk.o
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

