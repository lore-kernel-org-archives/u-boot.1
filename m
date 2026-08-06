Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB18C56208
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 11:00:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6FB9680E41;
	Thu,  6 Aug 2026 11:00:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8uFgT-r59IXo; Thu,  6 Aug 2026 11:00:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1FB5380E36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786014047;
	bh=yeC6Hqt5s4JnHR3bsVVzmr7CkvTOTeNRKCd3sW6T7gA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zR4vTN/hWjOlUjLSkelzCGQ1ukdQ1XMrocUT0FsUC4sVvOdePoVXgMSOy/6MosjeG
	 aO8crAhxl+FHZKsDRmfI0+3wh5w8z8/fTQaQD0YSfbTPGrVu7rEpUCCEPhPsZ2oKxJ
	 6mrRcniWYKU+D802VyEI2Czb+K2+3opvHho/w02Sx+xxOY0GiWky2ExGdEWsbIc9qB
	 HaARx/u/G7KantRFU4EmhLhKXBo7h32O8gzkcvh/YrmZDEpk1qyu8fYurHASdj57uT
	 mCa+UuKSu4LrcVdATm3crbDfooC6rQmKrZg2yGS1LGWJ+jUhxDGJ+FTYqFRsTzv4F4
	 YVHXuJWmrxvOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1FB5380E36;
	Thu,  6 Aug 2026 11:00:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F29A1194
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 10:18:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E469E4053D
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 10:18:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vxIzZctVbFO0 for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 10:18:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.128.45;
 helo=mail-wm1-f45.google.com; envelope-from=tanurelinux@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A99FD4054B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A99FD4054B
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A99FD4054B
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 10:18:16 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-496b7622a83so16738155e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 03:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786011495; x=1786616295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yeC6Hqt5s4JnHR3bsVVzmr7CkvTOTeNRKCd3sW6T7gA=;
 b=VS1EwF2HNObRUI+TG+AQrHHLraDGO0T6CXtdSVOT/K1Pk3HdplLUdUJWMlUss2aO+g
 xBL24FmdarrLmYKGqKArnCxNEWjyjWRHN1f9Ei/jpoTxExnDbJqAdyL63Kmzo5NNVRqK
 2FNuj+9k2qNSNul1D7JTwBUezf39eY20jnoWf7zy3AgHF615TDc5IWG1VxIJyVgixfNS
 AQmv11uPhznR52fw4Wu49Y3fM6Kx82SAkmfp/1n7wC9m3746Bt10QWGeEwW5zQChb5vO
 4JCh0wA6lxvpwbXOYwktyB6mghxQQHogcpmfsHjaibcHWzzcmejsgIG5bTVqp9jIIIZe
 JNkQ==
X-Gm-Message-State: AOJu0Yz3WKeBlxL7IdJ8Hy901zVo/s5P5mbPoTfBfP8mkhUn0WT+AfZn
 Vf3p/FR+0n7Z6L6LrdQrkURFizybp4VBB5JlmdQO21beCMwnTieo8OVkbPhnHw==
X-Gm-Gg: AR+sD115Lx/Q325BchJ6xciDxMIvgIDM/n2yetX/K2Mc3c1EXkkn2is41wg/SKvIVwT
 MDm0E5zkbT7lV/Bqik3oXehib6JeT2atrzN6CkzNNONDFqnI6IADfDTXjYCWlooDTHRHYw2voHB
 mdpljh7+XXPZSEG820tG+VgBa3Cpfg+QSxpENozrotmSxzSTrvwXUvRuYpcTCgnbmQqqmT3ChCD
 bqRyUAA+GQw7bCqPyg8aKTuw94VnNJKH62z+hDufA1/bgxjlsY0qR8CYcVU9g7hN/FUOhpMS7a9
 pjLPWVf7sGB1XxqTuFhpLn21AJ5ax4YWhrQk/d/LZE28D6/+SQVuAklKOzO+/kiopAsnJsutuU/
 ycCOwssmEchjYWYKIpjvlDl2iL0B9SeWDe8NFhPFL5oE1ncOOz9zNCBGjz4c1n2yWqzfAwWdQnl
 HNWaBe2B33vjbQTQi+wGmolBrBMe0HoCaZzjvv4QaVjCIflWTE5kEb80OMIhSaQcnFRVupR1Pof
 ENSxki7XliD91RsJSivMCs+dag=
X-Received: by 2002:a05:600c:12c8:b0:495:63e4:7f78 with SMTP id
 5b1f17b1804b1-4994e7baae6mr121733175e9.10.1786011494559; 
 Thu, 06 Aug 2026 03:18:14 -0700 (PDT)
Received: from threads.localdomain ([83.106.158.114])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994e988687sm108654725e9.3.2026.08.06.03.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 03:18:14 -0700 (PDT)
From: Lucas Tanure <tanure@linux.com>
To: u-boot@lists.u-boot-project.org
Cc: neil.armstrong@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 funderscore@postmasteros.org, u-boot-amlogic@groups.io,
 Lucas Tanure <tanure@linux.com>
Subject: [PATCH 2/4] arm: meson: add Amlogic T7 SoC family support
Date: Thu,  6 Aug 2026 11:18:07 +0100
Message-ID: <20260806101809.72526-3-tanure@linux.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806101809.72526-1-tanure@linux.com>
References: <20260806101809.72526-1-tanure@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Aug 2026 11:00:31 +0000
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=fail (p=none dis=none)
 header.from=linux.com
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

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
 arch/arm/include/asm/arch-meson/boot0.h | 18 +++++
 arch/arm/mach-meson/Kconfig             | 10 +++
 arch/arm/mach-meson/Makefile            |  1 +
 arch/arm/mach-meson/board-t7.c          | 97 +++++++++++++++++++++++++
 4 files changed, 126 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-meson/boot0.h
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
diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index c687ef822a2..40aafc0b922 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -67,6 +67,15 @@ config MESON_A1
 	help
 	  Select this if your SoC is an A113L
 
+config MESON_T7
+	bool "T7"
+	select MESON64_COMMON
+	select ENABLE_ARM_SOC_BOOT0_HOOK
+	imply OF_UPSTREAM
+	help
+	  Select this if your SoC is from the Amlogic T7 family, like
+	  the A311D2 found on the Khadas VIM4 board.
+
 endchoice
 
 config SYS_SOC
@@ -91,6 +100,7 @@ config SYS_BOARD
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
index 00000000000..a6ccec25c0e
--- /dev/null
+++ b/arch/arm/mach-meson/board-t7.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2026 Lucas Tanure <tanure@linux.com>
+ */
+
+#include <init.h>
+#include <asm/arch/boot.h>
+#include <asm/arch/mem.h>
+#include <asm/armv8/mmu.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+#include <linux/compiler.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define T7_WDT_CTRL		0xfe002100
+#define T7_WDT_CTRL_EN		BIT(18)
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
+/*
+ * The secure world owns 0x05000000 - 0x09000000: it contains the BL31
+ * and BL32 runtime zones (also described as reserved-memory in the
+ * upstream devicetree) and further firmware-protected pages, and is
+ * left unmapped in t7_mem_map below. Reserve the whole span so nothing
+ * (EFI allocations, boot-time relocations) is ever placed in memory
+ * U-Boot cannot access.
+ */
+#define T7_SECMON_RSVMEM_START	0x05000000UL
+#define T7_SECMON_RSVMEM_SIZE	0x04000000UL
+
+void meson_init_reserved_memory(__maybe_unused void *fdt)
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

