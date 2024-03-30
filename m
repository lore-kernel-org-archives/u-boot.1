Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA6BC6FD1F
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 05:05:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 363A58827A;
	Sat, 30 Mar 2024 06:05:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AyxfgOve";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 264AF87D37; Sat, 30 Mar 2024 06:05:27 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27B608826E
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 06:05:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6e68d358974so1188707a34.3
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 22:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711775123; x=1712379923; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AAKRLEVB4wL8k8Cc30EtF4gY2Od9w3wBt7BBNolqAKU=;
 b=AyxfgOveXq5qTcqnbKFuUzv1kNKie5GrNSeXKlu4IhmHTx5UhJggSjcYouQ2ZL9oYi
 geg6SNDrx5XFG1qV3gr+D9erIwuLViIE45+ZhZUbajcGOxy7ngh4qaqzRpA+1NGWIFdw
 V6bpsnH4DTbWvuGDL7YQfPmEV5o69bR6oU9wk1FHzymaw7NqB83vQiGk+NM4ayJ3BcOI
 7oziU9P4orTtzfdMDkMVaddZTNvw2A9Kn5ad3Hdf9PT4BWNXhzls/ih1TA6HnLALkBm0
 rWRl4YY/TyupyGTXukoVW13Iyg9p9u5z9qm5MW5xUm1P9PzAMGMG8MvBIoDzbtvcwBj9
 HDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711775123; x=1712379923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AAKRLEVB4wL8k8Cc30EtF4gY2Od9w3wBt7BBNolqAKU=;
 b=et2QA83n8+rstgMiaPFXQQ4NHSu5jOkkLMNkv5JdW6zAGuHrQK/0tdSwFgSQfI2vpb
 p/1zSzLI/cauV2vh+ljRTOu4Sup8bQqIUYSDqnwMNhlW53AOGS88aTtKbaH6rv4lTBe0
 oHK1FZyohvh8vpf7JNpbeMo5XtYPKY8+41entsOzW5Fe/hv/iGwl3+Clbn8Bhqeha45l
 dRAhqut5p0rxWGVsdaXStb68s0X4KODQ/KJChUUkpEZhypXnyk5oC13+NgLTUMcAMoan
 Fp6SwOX74tAEQAv5zBowh4pfFfr0OXk+MtJhYEwMuMk+uKQ0d+NCPy1Wln0v/4nuKS/y
 uU1Q==
X-Gm-Message-State: AOJu0YxOtjEwjZiTkoYMH2/wK0UMzVcTvB+qFsFabpogvL9rM0BwTJnY
 FQ8ikBBw8qe3sbM3fwRmW8Qasp/F1C5CeObQpkiM3eP3qES5hVTv1uSlNDGr
X-Google-Smtp-Source: AGHT+IFrS+mkmKSEXzUCrAJkZFP/YmBbt2+rU2UM7w2KLXX4dzYkpKWOU/R5sG8W8chA3XDzSuEM4Q==
X-Received: by 2002:a05:6870:d686:b0:221:f921:467e with SMTP id
 z6-20020a056870d68600b00221f921467emr4820823oap.21.1711775122742; 
 Fri, 29 Mar 2024 22:05:22 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 on7-20020a0568715a0700b0022a73f32f11sm1427634oac.32.2024.03.29.22.05.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 22:05:22 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: eugen.hristev@collabora.com, kever.yang@rock-chips.com, xypron.glpk@gmx.de,
 cym@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 jonas@kwiboo.se, trini@konsulko.com, Chris Morgan <macromorgan@hotmail.com>
Subject: [RFC 2/2] rockchip: rk3588: Add SoC specific RAM bank logic
Date: Sat, 30 Mar 2024 00:05:15 -0500
Message-Id: <20240330050515.470025-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240330050515.470025-1-macroalpha82@gmail.com>
References: <20240330050515.470025-1-macroalpha82@gmail.com>
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

Add SoC specific RAM bank logic for the rk3588 boards. This logic
works by reading the ATAGS created by the ROCKCHIP_TPL stage and
applies fixups on those to ensure we aren't stepping on any
reserved memory addresses.

The existing logic requires us to define memory holes to allow
devices with 16GB or more RAM to function properly, as well as
blocking up to 256MB of otherwise accessible RAM.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm/mach-rockchip/rk3588/rk3588.c | 93 ++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
index 38e95a6e2b..73ff742ffc 100644
--- a/arch/arm/mach-rockchip/rk3588/rk3588.c
+++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
@@ -7,10 +7,14 @@
 #include <common.h>
 #include <spl.h>
 #include <asm/armv8/mmu.h>
+#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <asm/arch-rockchip/ioc_rk3588.h>
+#include <linux/errno.h>
+
+DECLARE_GLOBAL_DATA_PTR;
 
 #define FIREWALL_DDR_BASE		0xfe030000
 #define FW_DDR_MST5_REG			0x54
@@ -35,6 +39,15 @@
 #define BUS_IOC_GPIO2D_IOMUX_SEL_H	0x5c
 #define BUS_IOC_GPIO3A_IOMUX_SEL_L	0x60
 
+/* Tag magic */
+#define ATAG_CORE_MAGIC		0x54410001
+#define ATAG_DDR_MEM_MAGIC	0x54410052
+
+/* Tag size and offset */
+#define ATAGS_SIZE		(0x2000) /* 8K */
+#define ATAGS_OFFSET		(SZ_2M - ATAGS_SIZE)
+#define ATAGS_PHYS_BASE		(CFG_SYS_SDRAM_BASE + ATAGS_OFFSET)
+
 /**
  * Boot-device identifiers used by the BROM on RK3588 when device is booted
  * from SPI flash. IOMUX used for SPI flash affect the value used by the BROM
@@ -83,6 +96,16 @@ static struct mm_region rk3588_mem_map[] = {
 
 struct mm_region *mem_map = rk3588_mem_map;
 
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
 /* GPIO0B_IOMUX_SEL_H */
 enum {
 	GPIO0B5_SHIFT		= 4,
@@ -130,6 +153,76 @@ void rockchip_stimer_init(void)
 }
 #endif
 
+/**
+ * rk_get_ram_banks() - Get RAM banks from Rockchip TPL stage
+ *
+ * Iterate through the defined ATAGS memory location to first find a
+ * valid core header, then find a valid ddr_info header. Sanity check
+ * the number of banks found. Then, iterate through the data to add
+ * each individual memory bank. Perform fixups on memory banks that
+ * overlap with a reserved space. If an error condition is received,
+ * it is expected that memory bank setup will fall back on existing
+ * logic. If CONFIG_IS_ENABLED(ROCKCHIP_EXTERNAL_TPL) is false then
+ * immediately return.
+ *
+ * Return 0 on success or negative on error.
+ */
+int rk_get_ram_banks(void)
+{
+	struct tag_ddr_mem *ddr_info;
+	size_t val;
+	size_t addr = ATAGS_PHYS_BASE;
+
+	if (!IS_ENABLED(CONFIG_ROCKCHIP_EXTERNAL_TPL))
+		return -EPERM;
+
+	while (addr < (ATAGS_PHYS_BASE + ATAGS_SIZE)) {
+		val = readl(addr);
+		if (val == ATAG_CORE_MAGIC)
+			break;
+		addr += 4;
+	}
+	if (addr >= (ATAGS_PHYS_BASE + ATAGS_SIZE))
+		return -ENODATA;
+
+	while (addr < (ATAGS_PHYS_BASE + ATAGS_SIZE)) {
+		val = readl(addr);
+		if (val == ATAG_DDR_MEM_MAGIC)
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
+	for (int i = 0; i < (ddr_info->count); i++) {
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
+	return 0;
+}
+
 #ifndef CONFIG_TPL_BUILD
 int arch_cpu_init(void)
 {
-- 
2.34.1

