Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB332CD128A
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 18:15:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36B1188329;
	Mon,  1 Apr 2024 20:15:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NcE/5kQl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9079388087; Mon,  1 Apr 2024 20:14:58 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8376388325
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 20:14:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-22988692021so1809598fac.1
 for <u-boot@lists.denx.de>; Mon, 01 Apr 2024 11:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711995284; x=1712600084; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u5iVMbdULW5nYegdQpmdOU6oE1l8C8xRFHbn6xszsFI=;
 b=NcE/5kQlaUQ8tcCVP37c95NHe2HWV2QDY8VhMqCwjAQRCKq3ANTO28d2XG8FigMHhE
 Yltk5mmuZCMJjxyfoP8HV2/VfvmyO37JXqAOXEgQYepzUzpgkN1WwOBhcsKTa1rgZocr
 JKwLa/vshkmiZhG/lvMGy49gtogy0GJDXGR3mI5KMagqvumhyPn3sTNBntm4IwrG5yIv
 h1DFqvFzPjwhXQgLHXJruWh/gKMvy3ADSJnsLNPMBlU+SE89FA9RvRwoF78LNNHm628S
 MjfWNNIwaCuIiol7zrmR3qxLrHKMn26qpX9fRv9mxxQafF4ecbaNCNy4cJwpTL0h/zx5
 XXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711995284; x=1712600084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u5iVMbdULW5nYegdQpmdOU6oE1l8C8xRFHbn6xszsFI=;
 b=FGMe17az+wjFhi7FGg8DECunsvEalIyc8GriwxnLOuBFoGwYzbL5Fg+qZqprhqtk0K
 oDTKOBxVVaqGAWLS94ngHsB8Kj49crafDq3tgVJSwshMcCdsm+QBflVhhzQ2JNlzJUkA
 6oU3KAMUiNILQEUDh6Ggez+R/Yt7M4UpAXSdP1kxA6WBokjyJ4rKDDgoWzHBeNGyB14W
 IXremB2RZkA5LXQ2TP18Bw7X4S42WjEi1Av0aXVhxeC2GvDYfEXISJHGcG2nb14Kprgy
 LLbGdNJHaoYjfWRsZFJSKaAkvxpgzQX75NdBbM+9nlmo5k8W78YGO1ZJyBq/puqN8lnM
 sntQ==
X-Gm-Message-State: AOJu0Yyd+JsBo24nhCO2/61nntQ1w28k6mhRn2ULJ8BrPv81f2ql5qAe
 vQFvd+yqY0sfjrK7cBVF18PpUWS1Q1fN1uLvcUxX1X+N0wQBgcGby1vhbHA4
X-Google-Smtp-Source: AGHT+IGqEViPYYZ+nLUeZXjMxcMk3FtdV9fa8eiQpLKfphap5wMIFmH4rPzaVVhMeigVBFaA33IzFg==
X-Received: by 2002:a05:6870:d686:b0:22b:8fe7:e335 with SMTP id
 z6-20020a056870d68600b0022b8fe7e335mr4216318oap.5.1711995283939; 
 Mon, 01 Apr 2024 11:14:43 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 hx17-20020a056871531100b0022a0a60a9bcsm3008824oac.57.2024.04.01.11.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Apr 2024 11:14:43 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: naoki@radxa.com, cym@rock-chips.com, gajjar04akash@gmail.com,
 frattaroli.nicolas@gmail.com, jagan@edgeble.ai, cnsztl@gmail.com,
 andyshrk@163.com, chenjh@rock-chips.com, frank-w@public-files.de,
 jjriek@verizon.net, eugen.hristev@collabora.com, tom@tom-fitzhenry.me.uk,
 jonas@kwiboo.se, inindev@gmail.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, trini@konsulko.com,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [V1 PATCH 1/2] rockchip: sdram: Support getting banks from TPL for
 rk3568 and rk3588
Date: Mon,  1 Apr 2024 13:14:34 -0500
Message-Id: <20240401181435.553351-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401181435.553351-1-macroalpha82@gmail.com>
References: <20240401181435.553351-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Allow RK3568 and RK3588 based boards to get the RAM bank configuration
from the ROCKCHIP_TPL stage instead of the current logic. This fixes
both an issue where 256MB of RAM is blocked for devices with >= 4GB
of RAM and where memory holes need to be defined for devices with
>= 16GB of RAM. In the event that neither SOC is used and the
ROCKCHIP_TPL stage is not used, fall back to existing logic.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm/mach-rockchip/sdram.c | 100 +++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
index 0d9a0aef6f..e02fb03c5f 100644
--- a/arch/arm/mach-rockchip/sdram.c
+++ b/arch/arm/mach-rockchip/sdram.c
@@ -12,6 +12,7 @@
 #include <asm/io.h>
 #include <asm/arch-rockchip/sdram.h>
 #include <dm/uclass-internal.h>
+#include <linux/errno.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -35,11 +36,110 @@ struct tos_parameter_t {
 	s64 reserve[8];
 };
 
+/* Tag magic */
+#define ATAGS_CORE_MAGIC	0x54410001
+#define ATAGS_DDR_MEM_MAGIC	0x54410052
+
+/* Tag size and offset */
+#define ATAGS_SIZE		SZ_8K
+#define ATAGS_OFFSET		(SZ_2M - ATAGS_SIZE)
+#define ATAGS_PHYS_BASE		(CFG_SYS_SDRAM_BASE + ATAGS_OFFSET)
+
+/* ATAGS memory structure. */
+struct tag_ddr_mem {
+	u32 count;
+	u32 version;
+	u64 bank[20];
+	u32 flags;
+	u32 data[2];
+	u32 hash;
+} __packed;
+
+/**
+ * rockchip_dram_init_banksize() - Get RAM banks from Rockchip TPL
+ *
+ * Iterate through the defined ATAGS memory location to first find a
+ * valid core header, then find a valid ddr_info header. Sanity check
+ * the number of banks found. Then, iterate through the data to add
+ * each individual memory bank. Perform fixups on memory banks that
+ * overlap with a reserved space. If an error condition is received,
+ * it is expected that memory bank setup will fall back on existing
+ * logic. If ROCKCHIP_EXTERNAL_TPL is false then immediately return,
+ * and if neither ROCKCHIP_RK3588 or ROCKCHIP_RK3568 is enabled
+ * immediately return.
+ *
+ * Return number of banks found on success or negative on error.
+ */
+__weak int rockchip_dram_init_banksize(void)
+{
+	struct tag_ddr_mem *ddr_info;
+	size_t val;
+	size_t addr = ATAGS_PHYS_BASE;
+	int i;
+
+	if (!IS_ENABLED(CONFIG_ROCKCHIP_EXTERNAL_TPL))
+		return 0;
+	if (!IS_ENABLED(CONFIG_ROCKCHIP_RK3588) &&
+	    !IS_ENABLED(CONFIG_ROCKCHIP_RK3568))
+		return 0;
+
+	if (!IS_ENABLED(CONFIG_ROCKCHIP_EXTERNAL_TPL))
+		return -EPERM;
+
+	while (addr < (ATAGS_PHYS_BASE + ATAGS_SIZE)) {
+		val = readl(addr);
+		if (val == ATAGS_CORE_MAGIC)
+			break;
+		addr += 4;
+	}
+	if (addr >= (ATAGS_PHYS_BASE + ATAGS_SIZE))
+		return -ENODATA;
+
+	while (addr < (ATAGS_PHYS_BASE + ATAGS_SIZE)) {
+		val = readl(addr);
+		if (val == ATAGS_DDR_MEM_MAGIC)
+			break;
+		addr += 4;
+	}
+	if (addr >= (ATAGS_PHYS_BASE + ATAGS_SIZE))
+		return -ENODATA;
+
+	ddr_info = (void *)addr + 4;
+	if (!ddr_info->count || ddr_info->count > CONFIG_NR_DRAM_BANKS)
+		return -ENODATA;
+
+	for (i = 0; i < (ddr_info->count); i++) {
+		size_t start_addr = ddr_info->bank[i];
+		size_t size = ddr_info->bank[(i + ddr_info->count)];
+		size_t tmp;
+
+		if (start_addr < SZ_2M) {
+			tmp = SZ_2M - start_addr;
+			start_addr = SZ_2M;
+			size = size - tmp;
+		}
+
+		if (start_addr >= SDRAM_MAX_SIZE && start_addr < SZ_4G)
+			start_addr = SZ_4G;
+
+		tmp = start_addr + size;
+		if (tmp > SDRAM_MAX_SIZE && tmp < SZ_4G)
+			size = SDRAM_MAX_SIZE - start_addr;
+
+		gd->bd->bi_dram[i].start = start_addr;
+		gd->bd->bi_dram[i].size = size;
+	}
+
+	return i;
+}
+
 int dram_init_banksize(void)
 {
 	size_t ram_top = (unsigned long)(gd->ram_size + CFG_SYS_SDRAM_BASE);
 	size_t top = min((unsigned long)ram_top, (unsigned long)(gd->ram_top));
 
+	if (rockchip_dram_init_banksize() > 0)
+		return 0;
 #ifdef CONFIG_ARM64
 	/* Reserve 0x200000 for ATF bl31 */
 	gd->bd->bi_dram[0].start = 0x200000;
-- 
2.34.1

