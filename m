Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC50C5DF87
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:17:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB2FA61036;
	Fri, 21 Aug 2026 13:17:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ee5kRqqBiixg; Fri, 21 Aug 2026 13:17:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318080;
	bh=Y1BMh1FQCKfQgkMOYAGM2kVSF9egcf+N7e2yoEbuF5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LKKKJcK4EG3croq6VBdgUW4nK6CANOjZ49nPxglOwp3r7tU/uaf1+wTR0dMXlLLL0
	 2YJzF87OjYDh2Q77BtSlV2ujuS7OlzjxpiZNAbRT/ZnRBst/5mw58A8Ry6Upx1M51T
	 wrg8aQoOY4whGYFQxauOVrc5u8RmU0Ji4pb41T+GoBxMnjcIXT8uRhPpqr9wmRexlF
	 K5Zg9Q37thOmkAiic3BUtivfVxyKGcPZwQjNw0Lxap5qHTvhLo1VaWa91tb6eulQPE
	 nETZimejsI463RH4cwUDyFC80U5bobICxzHW3xRSQ8NdpJyfzqF46xdIqXV3lBnslU
	 xqpeV7XlgH/Fw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 33EDA60EDD;
	Fri, 21 Aug 2026 13:14:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C0023476
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:46:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B19A240930
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:46:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HJoPGPdTMdun for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:46:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.221.45;
 helo=mail-wr1-f45.google.com; envelope-from=tanurelinux@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=linux.com
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AA14C40911
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:46:11 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-4799b3f7c83so556052f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787301969; x=1787906769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y1BMh1FQCKfQgkMOYAGM2kVSF9egcf+N7e2yoEbuF5M=;
 b=BKFAXt0HrDP/bMP/Xlt9Fb51md7akfu4E776mKunP4tiOnkPHtmZbCRtoifDs5jNog
 RZvJrCiJ8nCHm9IKJ96PH+VJvHCvqsgR/Wn8vaq/YQ+Lq9K4Ks8ddX4fwAlMdXQHF3wN
 f3KVESLSyycNWtSAvccEWfx7Iw+ULAOkA9XdJTQlqN7xZV730/GUgs2iMW8dotMWttUR
 z5phf0qkVWPPlZ+uNEGAO7YHbSC5O//61W3oCEQsLJeI9QPoQuzJI6BuEv4gbSV8YKEV
 OiwOgTBI8c8jnnVVkwZEG0BEb6qbuLLqnCJG5YMseTekm6a9FGL1pPf9vIg4O6WAbeFc
 pYiA==
X-Gm-Message-State: AOJu0YyQL46IbkRJbjL6u2XD5SH2cHrvZqFFiGxXgnfZrzaxe4dx1Svt
 3mJ+V96qlNGm22i12BD+Cnl6YyxLrXVrXpdUM1x4ATfmpSv9ShbRsx2g8Y/Dwg==
X-Gm-Gg: AR+sD11PDPQtEEe4+pF3KIuFVCqaGPqwcnfsf3aOyrBTCZcUBEpMiu6pi/cFlkWRCqA
 YQ+GK4pn/dqeThEvza7PnSXr6MfF6pVZPKsGwUWbw3+zGBXkrL+z2/JYjxyjY1QKl5vNeHgZg2j
 vXt7ATgCSY47g/3apOs2PUs37lqEcxhTPxXOIhfMja5wVuqHH4ncmT7/Nh9Sf2jka4LgD/Ya8iw
 5KHre7+QKEHstWtx4d6JWibJg6JBYkhYPME/gyTqQyQq4A586Kxusl4v6cTss5VHUqSjhmoofjX
 IWNWNecmoIM7WOdPwuPQC5uUtc7KXk88sijsLxRxU9xXa+Rpi8fSrL+p10F3wVWpchdJA2ntNs7
 hv3h8LnrsNlbhEvrWm6/7qc7S9p3Jj9ocT/FrAHuzu0RSVWC/P+YtVLBaNlAEj4OW3ylLJODeV0
 CYKsFG4wnKpqmkJ2B4lo+7d7PkgRRPwjISV8SfVtNKw5zRiyDXTGdmCcmo0J6XG4p3sIo8bmVhr
 nHul4N8ubSqT4AkmYWW/7USNOI=
X-Received: by 2002:a05:600c:198c:b0:499:9eb8:a1d7 with SMTP id
 5b1f17b1804b1-499b844b91bmr59118505e9.9.1787301969215; 
 Fri, 21 Aug 2026 01:46:09 -0700 (PDT)
Received: from threads.localdomain ([83.106.158.114])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e747esm22978115e9.4.2026.08.21.01.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:46:08 -0700 (PDT)
From: Lucas Tanure <tanure@linux.com>
To: u-boot@lists.u-boot-project.org
Cc: neil.armstrong@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 funderscore@postmasteros.org, u-boot-amlogic@groups.io
Subject: [PATCH v2 2/4] arm: meson: add Amlogic T7 SoC family support
Date: Fri, 21 Aug 2026 09:46:01 +0100
Message-ID: <20260821084603.25974-3-tanure@linux.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821084603.25974-1-tanure@linux.com>
References: <20260821084603.25974-1-tanure@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:12:32 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add initial support for the Amlogic T7 family (A311D2). U-Boot runs
as BL33, loaded at address 0x0 and entered from the vendor BL31 at
EL2, either uncompressed or LZ4-compressed inside the boot image (the
BL31 decompresses it).

The secure firmware writes the SCS device keys into the first page of
the loaded BL33 image (2 KiB for the BL33 key followed by 2 KiB for
the kernel key). Reserve that page with a boot0 hook, as the vendor
U-Boot does, so the keys do not overwrite U-Boot's entry code.

The firmware also enters BL33 with the non-secure watchdog running:
disable it in board_init(), otherwise the board is reset about a
minute after boot.

The memory map leaves 0x05100000 - 0x09000000 unmapped: the secure
world owns this span (the BL31 and BL32 runtime zones described in
the upstream devicetree, plus further firmware-protected pages), and
this matches the vendor bootloader's own map. The whole span is also
added to the devicetree and EFI reserved memory at boot time so no
allocation is placed in memory U-Boot cannot access.

get_effective_memsize() is capped at 0xdf800000 because the top 8 MiB
of the first DRAM bank contain pages the secure world protects at
runtime; U-Boot and its heap must stay below them.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 arch/arm/include/asm/arch-meson/boot0.h | 18 ++++++
 arch/arm/include/asm/arch-meson/t7.h    | 25 ++++++++
 arch/arm/mach-meson/Kconfig             |  9 +++
 arch/arm/mach-meson/Makefile            |  1 +
 arch/arm/mach-meson/board-t7.c          | 82 +++++++++++++++++++++++++
 5 files changed, 135 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-meson/boot0.h
 create mode 100644 arch/arm/include/asm/arch-meson/t7.h
 create mode 100644 arch/arm/mach-meson/board-t7.c

diff --git a/arch/arm/include/asm/arch-meson/boot0.h b/arch/arm/include/asm/arch-meson/boot0.h
new file mode 100644
index 00000000000..3ec085ccd64
--- /dev/null
+++ b/arch/arm/include/asm/arch-meson/boot0.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2026 Lucas Tanure <tanure@linux.com>
+ */
+
+#ifndef __MESON_BOOT0_H
+#define __MESON_BOOT0_H
+
+/*
+ * The T7-family secure firmware writes the SCS device keys into the
+ * first page of the loaded BL33 image (2048 bytes for the BL33 key
+ * followed by 2048 bytes for the kernel key). Keep that page reserved
+ * so the keys do not overwrite U-Boot's entry code.
+ */
+	b	reset
+	.space	4096
+
+#endif /* __MESON_BOOT0_H */
diff --git a/arch/arm/include/asm/arch-meson/t7.h b/arch/arm/include/asm/arch-meson/t7.h
new file mode 100644
index 00000000000..e0a90329082
--- /dev/null
+++ b/arch/arm/include/asm/arch-meson/t7.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2026 Lucas Tanure <tanure@linux.com>
+ */
+
+#ifndef __T7_H__
+#define __T7_H__
+
+#include <linux/bitops.h>
+
+#define T7_WDT_CTRL		0xfe002100
+#define T7_WDT_CTRL_EN		BIT(18)
+
+/*
+ * The secure world owns 0x05000000 - 0x09000000: it contains the BL31
+ * and BL32 runtime zones (also described as reserved-memory in the
+ * upstream devicetree) and further firmware-protected pages, and is
+ * left unmapped in the T7 memory map. Reserve the whole span so nothing
+ * (EFI allocations, boot-time relocations) is ever placed in memory
+ * U-Boot cannot access.
+ */
+#define T7_SECMON_RSVMEM_START	0x05000000UL
+#define T7_SECMON_RSVMEM_SIZE	0x04000000UL
+
+#endif /* __T7_H__ */
diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index c687ef822a2..1a8bab8391f 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -67,6 +67,14 @@ config MESON_A1
 	help
 	  Select this if your SoC is an A113L
 
+config MESON_T7
+	bool "T7"
+	select MESON64_COMMON
+	select ENABLE_ARM_SOC_BOOT0_HOOK
+	imply OF_UPSTREAM
+	help
+	  Select this if your SoC is an A311D2
+
 endchoice
 
 config SYS_SOC
@@ -91,6 +99,7 @@ config SYS_BOARD
 	default "q200" if MESON_GXM
 	default "s400" if MESON_AXG
 	default "u200" if MESON_G12A
+	default "vim4" if MESON_T7
 	default ""
 	help
 	  This option contains information about board name.
diff --git a/arch/arm/mach-meson/Makefile b/arch/arm/mach-meson/Makefile
index 08a24d4b24f..dc2bc0ceecb 100644
--- a/arch/arm/mach-meson/Makefile
+++ b/arch/arm/mach-meson/Makefile
@@ -17,3 +17,4 @@ endif
 obj-$(CONFIG_MESON_AXG) += board-axg.o
 obj-$(CONFIG_MESON_G12A) += board-g12a.o
 obj-$(CONFIG_MESON_A1) += board-a1.o
+obj-$(CONFIG_MESON_T7) += board-t7.o
diff --git a/arch/arm/mach-meson/board-t7.c b/arch/arm/mach-meson/board-t7.c
new file mode 100644
index 00000000000..c2725a4304f
--- /dev/null
+++ b/arch/arm/mach-meson/board-t7.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2026 Lucas Tanure <tanure@linux.com>
+ */
+
+#include <init.h>
+#include <asm/arch/boot.h>
+#include <asm/arch/mem.h>
+#include <asm/arch/t7.h>
+#include <asm/armv8/mmu.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int board_init(void)
+{
+	/*
+	 * The secure firmware boots BL33 with the watchdog running,
+	 * disable it.
+	 */
+	writel(readl(T7_WDT_CTRL) & ~T7_WDT_CTRL_EN, T7_WDT_CTRL);
+
+	return 0;
+}
+
+void meson_init_reserved_memory(void *fdt)
+{
+	meson_board_add_reserved_memory(fdt, T7_SECMON_RSVMEM_START,
+					T7_SECMON_RSVMEM_SIZE);
+}
+
+int meson_get_boot_device(void)
+{
+	return -ENOSYS;
+}
+
+phys_size_t get_effective_memsize(void)
+{
+	/*
+	 * The top 8 MiB of the first DRAM bank contain pages the secure
+	 * world protects at runtime, keep U-Boot below them.
+	 */
+	return min(gd->ram_size, (phys_size_t)0xdf800000);
+}
+
+static struct mm_region t7_mem_map[] = {
+	{
+		/* DRAM below the secure monitor reserved zone */
+		.virt = 0x00000000UL,
+		.phys = 0x00000000UL,
+		.size = 0x05100000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		/*
+		 * DRAM between the secure monitor reserved zone and the
+		 * end of the first bank. 0x05100000 - 0x09000000 is
+		 * protected by the secure world and must not be mapped.
+		 */
+		.virt = 0x09000000UL,
+		.phys = 0x09000000UL,
+		.size = 0xd7000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		/* Peripherals, GIC, ... */
+		.virt = 0xe0000000UL,
+		.phys = 0xe0000000UL,
+		.size = 0x20000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* List terminator */
+		0,
+	}
+};
+
+struct mm_region *mem_map = t7_mem_map;
-- 
2.55.0

