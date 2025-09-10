Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64250CA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 08:37:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7226830A0;
	Wed, 10 Sep 2025 10:37:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A32mvIJX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64C218318E; Wed, 10 Sep 2025 10:37:49 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D60F982B20
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 10:37:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3e2fdddd01dso1211734f8f.2
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 01:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757493466; x=1758098266; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=9bV/A2IZu7cXNNWW/8CDxmtdrxb0bfjcbwzqF3JvNr0=;
 b=A32mvIJX6cvWsqr9XBXmneCpVfdlQBAZUYzSdzQA43freX7RTtJcQD25vV0Lp/1AFT
 EwBlJ5VVdum70cEAQRvUZweG5wUht3+DkS/5QrFkSet3ha1WMTMg9Aqhatp+ncG7d2LI
 oAhvRE9AJioWOViqn710R+7Z6buKVe9lwpknsAB4nlMc5S5eVVoJh6JJkH+uCbhGZpj9
 P2yUO6IgjqsB2FI47WE7zrjnh2+OyuPGkZP9M/h8Re5r+wytV6xOCvEOAFBw1+P2oKMd
 ClIDBYuB/H9INRlRYvf0M1sgBTXxDNhPYIsahAgAj55cteSxdqM3G7o/7K6YV45AIfTJ
 Rf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757493466; x=1758098266;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9bV/A2IZu7cXNNWW/8CDxmtdrxb0bfjcbwzqF3JvNr0=;
 b=CP9XefrrF0a26fK+gsJXi2j9IxxI5kpxzlzSY3NCcVb1qiJ6dJA4oM4bOUn6URL1ts
 Rez/HSTXVE3tC1dvRlx6mktldOGpXBvsaSid4kwqCLyMen7t7ng+wE7JUAWVki79UiHt
 7W3bIRIgK3N/lbumLaR7VoaFGkhUxSC88PlZzSLBxhycr51lXCT5YRl7C1PAy9FNx58J
 SnBoqHr/nHtvlam3xWvm9n/DJ3+H76JRC8a1s1tTT0HiC/cEnJ/g/+SZWNOaY05JcJjZ
 A4tzFsWIfgmNCuzMBo/z7ImoyyOo5QLwCvXheFUI5betFlGq6qLyHNw34qFBLqKzDfUo
 fRsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZWp4haX+/L4X1cKIL1bK/loid8bsBaDT4qF606cDnHgFq9PwZs76qmKofzuUtW6cgEJdYllA=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7uRnSKSwQztvrJyVrES9zydgbhpLEHSRVLSK5Rk02aGW+OGAO
 8YTISo+rP+3goTI+BhYWgUvdHoQbfXuhbEi20zdil3oS6GWCay/5hEkM
X-Gm-Gg: ASbGncsr+9cTU8JvZ7MzzMKY6ZFK080gVgFRPkh5NbZBsLYAK3ABSTvoc521V8OHEMM
 sf6Vm0yOMEPtB+wt/y6MxScuy3Tn3MJmLb0YijgTJ17uAP56np78FXrsx98Ek/qGAaw5gmP0/YV
 MN8sGv3np0sSyu5aDZjYy7FDq23Uy5z2Kk0nmy475EPe5j3T1AmOpKp0BIIyJM3l+OODHJZAnvo
 iS3duAp+L70DlVAf6UfrjtFcDfjP2C1XylfHX9nmPbIXcz+OEmJnZlORA/DRVvoWndvNHm4pFoS
 MhB9fk3/UXDazVrgLoehi/qdm2hmeEyPgb4huGni9u6UZHnOgjwlFChwWy35IXCJv505hWxqiU1
 UNJ4MRPw8v0eMHlahf/28MmRJ909wJCFj3yrCQpPQWWmonOklen1k2zYltMwNnXcK+YdUp3AsPC
 R8GXjF9g==
X-Google-Smtp-Source: AGHT+IEpcKN6HHdVoNqTIdmG+ucnLGUPjTsKGe7ZAJNoS5YAyP4r2b+zIUK48wiQIjPJI83/8lZoVQ==
X-Received: by 2002:a5d:5d05:0:b0:3ce:f0a5:d594 with SMTP id
 ffacd0b85a97d-3e641e3cba1mr13484514f8f.13.1757493466082; 
 Wed, 10 Sep 2025 01:37:46 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it.
 [95.249.236.54]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3e75223ea3csm5988810f8f.49.2025.09.10.01.37.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 01:37:45 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, u-boot@lists.denx.de
Subject: [PATCH v3] airoha: rework RAM size handling to support multiple RAM
 size
Date: Wed, 10 Sep 2025 10:37:35 +0200
Message-ID: <20250910083737.9263-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
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

There are multiple version of the same reference board with different
RAM size and it's not enough to base the RAM size entirely from DT. To
better support it use the get_ram_size way to scan for the actual RAM
size of Airoha SoC and increase the size of the memory map.

Also rework the memory map to account for 2 memory map. The first one of
2GB for 32bit DMA and for safe usage of U-Boot. The second one for the
rest of the RAM since up to 8GB are supported.

Reviewed-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v3:
- Fix typo memyro
Changes v2:
- Add memory map to support full 8GB
- Assign 2gb to first memory map for U-Boot

 arch/arm/mach-airoha/an7581/init.c | 40 +++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-airoha/an7581/init.c b/arch/arm/mach-airoha/an7581/init.c
index d149e0ee3c8..11992027d92 100644
--- a/arch/arm/mach-airoha/an7581/init.c
+++ b/arch/arm/mach-airoha/an7581/init.c
@@ -2,10 +2,16 @@
 
 #include <fdtdec.h>
 #include <init.h>
+#include <linux/sizes.h>
 #include <sysreset.h>
 #include <asm/armv8/mmu.h>
+#include <asm/global_data.h>
 #include <asm/system.h>
 
+#define CFG_MAX_MEM_MAPPED  SZ_2G
+
+DECLARE_GLOBAL_DATA_PTR;
+
 int print_cpuinfo(void)
 {
 	printf("CPU:   Airoha AN7581\n");
@@ -14,12 +20,28 @@ int print_cpuinfo(void)
 
 int dram_init(void)
 {
-	return fdtdec_setup_mem_size_base();
+	int ret;
+
+	ret = fdtdec_setup_mem_size_base();
+	if (ret)
+		return ret;
+
+	gd->ram_size = get_ram_size((void *)gd->ram_base, SZ_8G);
+
+	return 0;
 }
 
 int dram_init_banksize(void)
 {
-	return fdtdec_setup_memory_banksize();
+	gd->bd->bi_dram[0].start = gd->ram_base;
+	gd->bd->bi_dram[0].size = get_effective_memsize();
+
+	if (gd->ram_size > SZ_2G) {
+		gd->bd->bi_dram[1].start = gd->ram_base + SZ_2G;
+		gd->bd->bi_dram[1].size = gd->ram_size - SZ_2G;
+	}
+
+	return 0;
 }
 
 void reset_cpu(void)
@@ -29,20 +51,26 @@ void reset_cpu(void)
 
 static struct mm_region an7581_mem_map[] = {
 	{
-		/* DDR */
+		/* DDR, 32-bit area */
 		.virt = 0x80000000UL,
 		.phys = 0x80000000UL,
-		.size = 0x80000000UL,
+		.size = SZ_2G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
+	}, {
+		/* DDR, 64-bit area */
+		.virt = 0x100000000UL,
+		.phys = 0x100000000UL,
+		.size = SZ_4G + SZ_2G,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
 	}, {
 		.virt = 0x00000000UL,
 		.phys = 0x00000000UL,
-		.size = 0x20000000UL,
+		.size = 0x40000000UL,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
 	}, {
-		0,
+		/* List terminator */
 	}
 };
 struct mm_region *mem_map = an7581_mem_map;
-- 
2.51.0

