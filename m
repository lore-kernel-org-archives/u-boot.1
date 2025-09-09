Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DFCCA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 22:58:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7560E83290;
	Wed, 10 Sep 2025 00:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QDZ9rEPh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B72983287; Wed, 10 Sep 2025 00:58:06 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13F748319C
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 00:58:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45b9853e630so56479495e9.0
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 15:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757458681; x=1758063481; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=maD3VuBKc4lPPoCkh51cbMn11eG3qUyKd5NgnYtlnRU=;
 b=QDZ9rEPh9KqQPkKKfHMQLZesQPDHUMwLrFfxUfZMdhLM8jDvFT5dycmEFmtSdF2A6S
 4DXc8zVGLABDnvAQKFPOvAKMc1B+TH/uWxJ6pT3a8wU+6ADq7pthmT2dMMdwIG9gnF9U
 +PFnj6BdYu/aa2LIclXNlJNjMiE0ZLUVLt2RqvGVfEToG8WVuQeJ1mR0oquDmaLVvOsf
 vWEA5D4LuToXJ2GOxVyvIRsdtLaW/C/nvyWOcH0GohsxCaBOF1uaH/bvPOwGiYJRqR8M
 yDmWKQGbF3N68C+g/m7V5DPW2Ak7KwUQ05nXUSduwAn+sqHRXpgREapCywNBdhqoSzDV
 Bg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757458681; x=1758063481;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=maD3VuBKc4lPPoCkh51cbMn11eG3qUyKd5NgnYtlnRU=;
 b=KgQGWykGaT37vnW+O/R6/o6h3KrdLUXwjDOFi7lE9waDRjVNwCuYGvxvb5e8Sm3Xe/
 +wRkmBKY4SYM9HwHMtFWn8GFOTkarUpuaX86XR+diaN5LJxyW+pRfP/LRCMLVmjbTuRm
 PcEmb8u3khw7fIOw/sqzDHDpcRev8w21iX5wIaVgCkZuHtx46U2QhFuaR4+GR0/xSAuM
 cp98/vuMhyk12XHAGMrBu2oF+Njnju6nd+5MV/FaEoXFPxlPbmzgAtrseI13nFnOeyjp
 ozMUuNViR3LyXoumgnnAf9VjKctoM1gKEtOmjHVWwzDzaBy5N5/FbNIPOu0YpKIXX9cA
 lipg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPFsbnmo6aPui1LUw2ggRdl9Hz4LfO5qc24jad/WtMzGLsRDi6sUc8J0acqvVWZOCR42vXHOE=@lists.denx.de
X-Gm-Message-State: AOJu0YxzhIZ17HRiEPEw2oWEaX8YC+CJqtzVPdO5KJf/Eo+HkcJDfLyL
 uLjhjFessGgxcfKM6djaMdElr9p5c1cRNo+ohlV2aUVb0ziIYfmqZ0Fq
X-Gm-Gg: ASbGncsbG3tQIzMYFK94mTF3TWAxhXTqKxXLtuD/9pRYjVxQCuG6oSMQRs5BfSFNPPm
 u1Ua1Z4vE2bQCnK3DI1HSBZ2u7OfxcyTbVr0zf+j5Tv83ZelkKtMXT9Lz6447sSGbmUOTkgjnA/
 Te8RLK+MxMW9cnEuImRpGaINsGTepQ612qPJafKq0VWZ/n6hKyx1W3P8lITLLth/tuLvn7MGbs+
 CFrqFX+dIp6YOMvvJ80baClIxjVBtq2yjMPkqOY1RIairPI/JT/TL8aLB5M+5hXx9cqKTpxFpPa
 ZLVNgC9T0l0Dx7BTFtNbgPeKMG8Wy4/SnMvcz1Z7fl73MZ5e/9wmEQgWEPf3Ea75mlfKfDRGfMP
 g0Pl6ZWP51cNkZZ9MmPENDpVuNsBexOdVp5bWBDTawC7v7RfD1z2eG7Duhmab18HO/BaEPoky9I
 Veb6xfrw==
X-Google-Smtp-Source: AGHT+IFI6HTg5aVX9j0J4NzmDpcbvezWJs1Gb1+sDDbK2XlU7Iy9tJLQLDJD+DeovHiYwt7fowin5A==
X-Received: by 2002:a05:6000:400f:b0:3dc:eb5:501e with SMTP id
 ffacd0b85a97d-3e63736fc36mr10526448f8f.18.1757458681296; 
 Tue, 09 Sep 2025 15:58:01 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it.
 [95.249.236.54]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-45df81cbce6sm4570245e9.5.2025.09.09.15.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 15:58:00 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, u-boot@lists.denx.de
Subject: [PATCH v2] airoha: rework RAM size handling to support multiple RAM
 size
Date: Wed, 10 Sep 2025 00:57:31 +0200
Message-ID: <20250909225751.19544-1-ansuelsmth@gmail.com>
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

Also rework the memory map to account for 2 memyro map. The first one of
2GB for 32bit DMA and for safe usage of U-Boot. The second one for the
rest of the RAM since up to 8GB are supported.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
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

