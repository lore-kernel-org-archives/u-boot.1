Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B9CC83F1A
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 18:44:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B383283330;
	Tue, 22 Jul 2025 20:44:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CKTa0eGS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9495A833F1; Tue, 22 Jul 2025 20:44:53 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABEDE805D7
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 20:44:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a53359dea5so2836996f8f.0
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 11:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753209891; x=1753814691; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=cl9FbCf/5AmJ1Aea+AceqGTkpiUcnmS+DBMBFTpFfho=;
 b=CKTa0eGS3x8L7zWbMNwu5C0azYhyc1BCyOmCw5y+tvRYIMR0gBxRCahkW19DSn2emQ
 osziRhO0B7pLiiCpN1Z7ybVLefqbV9I2ZP2wGbTQk0DqhQztaS4fS0uRilYv2PJOTRD1
 98g9p+QRgVhg/0advQSTuNPurtPtSvmjLxDtjrl1cKVlpD+6JYZ0JloV5uT/FPg1UlZr
 GbjtQWRvd+BuGkCK9NHIM2D5S4uolhp7cVn/USdu6L953Rw17aYMJ0ZTma+ViXwLO74X
 VqKmvXIuorNIhRJlBL+VkUP9Ej/KTeXHVfTD8jin5Yi1JJYSEIyubg0aAmXRyPcd4+Nh
 6Scw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753209891; x=1753814691;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cl9FbCf/5AmJ1Aea+AceqGTkpiUcnmS+DBMBFTpFfho=;
 b=cL7E/xbTk2/XbqcQD40YUVPRRjWky2+jeiqgQ7SZICd/ouIAmr/iNLzQm0FdXgcdxY
 M9HxQqg2sCnf9KeTWCE32uQXRwwy0VTI/wjjbI1cPY93NkPuoglxdFeHEdUaYUJvph8t
 1I7vfMsmrC8SH6hze4R/g7LoDSDw9EpHvK8/P3DS67pNS4RUofA9l34z3ecsM2St0Ig6
 xT7ulk+7yPYzthRPIyWrUxV3KU6D1Vq0T1f1Foby060kagdNXGjX5YlqCwlUH9MzfC+9
 Pp0e5h5OXPDTUPA+CGILT4qvKMk0pIN68haeaXx/MF5pkMadshV8b/uiaEHoMOWgCWkG
 XigQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUD1LYcu1YGynOWrv3uyZAYm0Xvj124AHMTiEQ9hp3RADypgPMohp2o2Cg9KyNlpHzU2ukArM=@lists.denx.de
X-Gm-Message-State: AOJu0YynvlynlwHNk9gDQuk1W1+p8wvOs3FPnix3cavTfWDwNN0Ry3NR
 5RaZ3fOcv4vcFMB609LWRJZorYNP3PHS2xcjsmQY18uU20J5TEidqWLz
X-Gm-Gg: ASbGncvF+AkMqoBqyVWRmF8lixPgKM36SsEJBY29G+x98s6A16srU5LuIYk7TPEHU1H
 hifUaV0lY3rp3WZ4KqHEQHI2a3WVv5jXcIfK0u4btrGgZI/PtBSZr8RA7JEKe3G/Gzb/wFzo040
 JrKpykwpz+62agCm6zyoP9Ta8psM3Fo1p+giopkFLa6XlFgymlY7DBikKLmpW6j9/gMRIgVvk2P
 zBa3w74LEE8FNLV+zoEs8OfR46HWKfACBurj13ljpDdDjLUyQCKsP/jDz+ZWJ5+jUq0ApffuSSX
 Ol/3Gj8xJ5nOqFMnXyBEyYpa5AZVtwK3lzagUlTbdMQ9t+NMas3MYlveezwI551S0l1+0Vjzt5+
 FO646xweQ9nYswTcaK+fqS1Ih
X-Google-Smtp-Source: AGHT+IEXmuY8elXs3u49xTst+nksXNAeL1goKBYwC0TD3pwjzw24ug/cD2YKq3cab7W2yZ4tAH0q9w==
X-Received: by 2002:a05:6000:2504:b0:3a5:25e0:ab53 with SMTP id
 ffacd0b85a97d-3b768ef3ca6mr202013f8f.32.1753209890828; 
 Tue, 22 Jul 2025 11:44:50 -0700 (PDT)
Received: from Ansuel-XPS24 ([176.200.63.230])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-456485798fcsm85121685e9.24.2025.07.22.11.44.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 11:44:50 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de
Subject: [PATCH] airoha: rework RAM size handling to support multiple RAM size
Date: Tue, 22 Jul 2025 20:44:18 +0200
Message-ID: <20250722184426.6964-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.50.0
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

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/mach-airoha/an7581/init.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-airoha/an7581/init.c b/arch/arm/mach-airoha/an7581/init.c
index d149e0ee3c8..0f72365c4ab 100644
--- a/arch/arm/mach-airoha/an7581/init.c
+++ b/arch/arm/mach-airoha/an7581/init.c
@@ -2,10 +2,14 @@
 
 #include <fdtdec.h>
 #include <init.h>
+#include <linux/sizes.h>
 #include <sysreset.h>
 #include <asm/armv8/mmu.h>
+#include <asm/global_data.h>
 #include <asm/system.h>
 
+DECLARE_GLOBAL_DATA_PTR;
+
 int print_cpuinfo(void)
 {
 	printf("CPU:   Airoha AN7581\n");
@@ -14,12 +18,23 @@ int print_cpuinfo(void)
 
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
+	gd->bd->bi_dram[0].size = gd->ram_size;
+
+	return 0;
 }
 
 void reset_cpu(void)
@@ -32,12 +47,12 @@ static struct mm_region an7581_mem_map[] = {
 		/* DDR */
 		.virt = 0x80000000UL,
 		.phys = 0x80000000UL,
-		.size = 0x80000000UL,
+		.size = 0x200000000ULL,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
 	}, {
 		.virt = 0x00000000UL,
 		.phys = 0x00000000UL,
-		.size = 0x20000000UL,
+		.size = 0x40000000UL,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-- 
2.50.0

