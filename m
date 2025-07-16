Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1846C83F1B
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 07:37:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40A56831B5;
	Wed, 16 Jul 2025 09:37:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bSzWTUSI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29A73831C4; Wed, 16 Jul 2025 09:37:44 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29556831A4
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 09:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a575a988f9so3642817f8f.0
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 00:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752651461; x=1753256261; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UvY+Nt7mudmoBaQoi+ep+1ExDf4+ctTNnWcnMMV/9bs=;
 b=bSzWTUSIrFr482WamglZ44sBQvIhdOTa41n2bfeEGcbKxrVfn5zC0aRYDvsdu1jn2e
 o7+ep2Y9gNXZhG9iGoQhZQdoSo6At/vcx6L/t6j4S0CFevNTyobX7ej36ofnsEuQVxCW
 ko6Psd1yeRHiJkilh+TfxkwPVuYwlYhNaXTBUdh/7hcV894nfnB8KaOCOYG1pWWaqJuN
 n3DxFC3NxY4F3BrNRV3REC3ciczunWINC+NpnXWJkhtBbpSpQ5fWZRYlUlQ0lRiW6Rrx
 SiWhbPMRzfKE0J71u+Vnnqbxgn8Y/cuBonPmIN3d8WKtrYJyoY11BPr5v8jxLP/MNplb
 x4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752651461; x=1753256261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UvY+Nt7mudmoBaQoi+ep+1ExDf4+ctTNnWcnMMV/9bs=;
 b=nB25X8YKJXQ5fQYW3aJghxO+KlV8+TStZcQw4aFglci5nywGuukDYIqNeitz46C9na
 swK1QDvkyaowLamqHP9CXyUM3qITD0dbAw1vp0Ti1vm3J3kX0ikCgajayy1HCaMobIbs
 +EqipuwhHDr7t0aFgTXZ77zmSwC4actQMwpTdXB18gFzYi2cFOcAy4UslQZ9eQ0L3b2+
 Gy0hV1pQC/8iuWUsn/FW4iDGkfqLoHb9VFQ2BBtoyRWc2fXXuOgnQXuOllruL1U5b3MA
 PidX4RSoxwsHarunlorPo5oiTGUZ3HivJY6+FewF6uDFjGdMh95+vdAQknHm7OpoXJIo
 NcOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu6jYVCrLa5soqsF+nnzt4JSXEmoFEiRazlrlcZmOM4bU61sVmayQVIOqdjMzM8SD4S+bSN7E=@lists.denx.de
X-Gm-Message-State: AOJu0YzrvupCb7viX3IFOH6K8ki9cwa7pgUt2Er62l+Z+Gnbsgliz7CO
 Xu8QBN7zGBlVL2zPa9SIk9FQpzP1eczbtVxDQdWLG53v7ceS7KOFxUp8
X-Gm-Gg: ASbGnctEA601+hLh9jgX1mPj4l75KtHIyqbRLR7FT9oncd/FpGI00lKAXhEQvcnMqtQ
 cqE3yzU4jViwmVYbKJcEJAa+TQ732ugyBNKwn7y9xUorhNa2W7TAVkNfW/iUm2DJ+QiG/LByASq
 96gtTOq2ZD/bkTyuCzZ0k1BfDOFXDKGh6zho+U82/lEO+l7uJia66ad/h3qFalQ5LTeyypehIof
 vqYmZaWd6srK6BS4Hzeq2tPU/AxWn4LbSQ4deNYHSQGtU4y/vb5EsbK8b6wG6uivUVzgr6drZoB
 afXz9QRk8JEtYfmDR2cGpGYVHBSe+skxuBM+K28efOudUO+6pGtZTPFMUKl5QcFwT2uJR94KVbU
 Lf8IaMx5ALkVlTAcSPhcyFfzQzeAi47Iy9Cr7BCsLnFLlalOKgQZZqLTzWPnb8nA1HTkLTc1B2k
 N9G9DmDZKqko5ZbkJ4MtYkKA8=
X-Google-Smtp-Source: AGHT+IF2+SgC8YUwGeZs3N2sj3/RKlaPtVUS6i9HbfZrNiUF4DJTB6gVLofS9go8rtt3DJYXtFQnUQ==
X-Received: by 2002:adf:9d8b:0:b0:3b3:a6d1:6b57 with SMTP id
 ffacd0b85a97d-3b60dd87ae0mr1269534f8f.44.1752651461411; 
 Wed, 16 Jul 2025 00:37:41 -0700 (PDT)
Received: from localhost.localdomain
 (host-212-171-170-230.retail.telecomitalia.it. [212.171.170.230])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4562e8339d8sm12485495e9.30.2025.07.16.00.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 00:37:41 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 2/2] airoha: rework RAM size handling to support multiple RAM
 size
Date: Wed, 16 Jul 2025 09:37:08 +0200
Message-ID: <20250716073716.11698-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250716073716.11698-1-ansuelsmth@gmail.com>
References: <20250716073716.11698-1-ansuelsmth@gmail.com>
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
 arch/arm/mach-airoha/an7581/init.c | 22 ++++++++++++++++++----
 arch/arm/mach-airoha/an7583/init.c | 22 ++++++++++++++++++----
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-airoha/an7581/init.c b/arch/arm/mach-airoha/an7581/init.c
index cefe9c6db9e..caf1006b22b 100644
--- a/arch/arm/mach-airoha/an7581/init.c
+++ b/arch/arm/mach-airoha/an7581/init.c
@@ -3,8 +3,11 @@
 #include <fdtdec.h>
 #include <init.h>
 #include <asm/armv8/mmu.h>
+#include <asm/global_data.h>
 #include <asm/system.h>
 
+DECLARE_GLOBAL_DATA_PTR;
+
 int print_cpuinfo(void)
 {
 	printf("CPU:   Airoha AN7581\n");
@@ -13,12 +16,23 @@ int print_cpuinfo(void)
 
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
 
 void reset_cpu(ulong addr)
@@ -31,12 +45,12 @@ static struct mm_region an7581_mem_map[] = {
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
diff --git a/arch/arm/mach-airoha/an7583/init.c b/arch/arm/mach-airoha/an7583/init.c
index 77c29290331..c00837b4234 100644
--- a/arch/arm/mach-airoha/an7583/init.c
+++ b/arch/arm/mach-airoha/an7583/init.c
@@ -4,6 +4,9 @@
 #include <init.h>
 #include <asm/armv8/mmu.h>
 #include <asm/system.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
 
 int print_cpuinfo(void)
 {
@@ -13,12 +16,23 @@ int print_cpuinfo(void)
 
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
 
 void reset_cpu(ulong addr)
@@ -31,12 +45,12 @@ static struct mm_region an7583_mem_map[] = {
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
2.48.1

