Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E24C5AE49
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 14:33:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B04F280DF8;
	Mon, 10 Aug 2026 14:33:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bikibVW4SVBe; Mon, 10 Aug 2026 14:33:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 84C5C80E1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786372401;
	bh=xFWTKgsm4x09LrbEwfGnP4C7RtLN8NQkCXPO2SR6WYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fm2QtdZkxrCUM9orUWauAsMCol+TVCc/bw+AZYS+Yd/tJn3w4W8ULM9lChyAGZkcD
	 S8yfWAXM6Y/gVZkWdq5GsDZeu+v/87IM6l2W80WHlizDI+V+uMYajoT6WH9r1zu1PM
	 ZnY2Gjti+bQYDcMONpReWX0mv3eWeA3PQwj2ZH9TNpI0RS6oVO+nJ8Heu6toUnx3eb
	 Tp911z7eaM2OZx8JvdJXgLTSkb+tpvJuODBC660ZtMm5n1eVIFwED9HCt8zGUTkQC7
	 Kq+b92Jp9RnC4HNf5Lh8wIdVPvS79tytzI1tnvQHESg9eag0oTG0CJJYqxPlmymwdN
	 x6W8ErkzmQEBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 84C5C80E1D;
	Mon, 10 Aug 2026 14:33:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C3D29198
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 14:33:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B5B5D60720
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 14:33:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y9MqStSi1RdF for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 14:33:18 +0000 (UTC)
X-Greylist: delayed 351 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 10 Aug 2026 14:33:17 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1FA4960716
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1FA4960716
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=37.59.57.117;
 helo=out-186.mta1.migadu.com; envelope-from=funderscore@postmarketos.org;
 receiver=<UNKNOWN> 
Received: from out-186.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1FA4960716
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 14:33:17 +0000 (UTC)
Date: Mon, 10 Aug 2026 14:15:17 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: u-boot-amlogic@groups.io, tanure@linux.com, u-boot@lists.u-boot-project.org
Cc: neil.armstrong@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 funderscore@postmasteros.org, u-boot-amlogic@groups.io,
 Lucas Tanure <tanure@linux.com>
Subject: Re: [PATCH 2/4] arm: meson: add Amlogic T7 SoC family support
References: <20260806101809.72526-1-tanure@linux.com>
 <20260806101809.72526-3-tanure@linux.com>
In-Reply-To: <20260806101809.72526-3-tanure@linux.com>
Message-ID: <tjk5gh.17yic8cda9vwm@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=postmarketos.org; s=key1; t=1786372043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xFWTKgsm4x09LrbEwfGnP4C7RtLN8NQkCXPO2SR6WYQ=;
 b=p92thx0Q5eC3M/l75lS5oH0LjH+1RmSEFytF/bIhZIUBeUBA9ImD4+9XsV77SQFUTAXKPK
 TJeQktyOWmLp8d7KKA0ySp0BWahSJ9gZG3OKEf9eaniJbuGH3kCRacVXVL7wZ8pB7QoDQt
 tgplYg0m3R1xEvcGmHgBzsKxhthWzFhT/8t6JZmMPI3tj6Ls455krZzYvITxfCHxcpwmT3
 gnJAdv6n84bVEiRMs6YJyG3Pc7zzPfXcIY08SUA4MxV/zMaZBahLIeuujQMliSS//ViZSw
 JWZ6lo3zF3MsXD2tKQeZBbBrjdWq87Q8leUWD7D4gbKfObniq9kGWZ9bx2pkUQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=postmarketos.org header.i=@postmarketos.org
 header.a=rsa-sha256 header.s=key1 header.b=p92thx0Q
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

On Thu, 06 Aug 2026 10:18, "Lucas Tanure via groups.io" <tanure=linux.com@groups.io> wrote:
>Add initial support for the Amlogic T7 family (A311D2). U-Boot runs
>as BL33, loaded at address 0x0 and entered from the vendor BL31 at
>EL2, either uncompressed or LZ4-compressed inside the boot image (the
>BL31 decompresses it).
>
>The secure firmware writes the SCS device keys into the first page of
>the loaded BL33 image (2 KiB for the BL33 key followed by 2 KiB for
>the kernel key). Reserve that page with a boot0 hook, as the vendor
>U-Boot does, so the keys do not overwrite U-Boot's entry code.
>
>The firmware also enters BL33 with the non-secure watchdog running:
>disable it in board_init(), otherwise the board is reset about a
>minute after boot.
>
>The memory map leaves 0x05100000 - 0x09000000 unmapped: the secure
>world owns this span (the BL31 and BL32 runtime zones described in
>the upstream devicetree, plus further firmware-protected pages), and
>this matches the vendor bootloader's own map. The whole span is also
>added to the devicetree and EFI reserved memory at boot time so no
>allocation is placed in memory U-Boot cannot access.
>
>get_effective_memsize() is capped at 0xdf800000 because the top 8 MiB
>of the first DRAM bank contain pages the secure world protects at
>runtime; U-Boot and its heap must stay below them.
>
>Assisted-by: Claude:claude-fable-5

Same as on the first patch.

>Signed-off-by: Lucas Tanure <tanure@linux.com>
>---
> arch/arm/include/asm/arch-meson/boot0.h | 18 +++++
> arch/arm/mach-meson/Kconfig             | 10 +++
> arch/arm/mach-meson/Makefile            |  1 +
> arch/arm/mach-meson/board-t7.c          | 97 +++++++++++++++++++++++++
> 4 files changed, 126 insertions(+)
> create mode 100644 arch/arm/include/asm/arch-meson/boot0.h
> create mode 100644 arch/arm/mach-meson/board-t7.c
>
>diff --git a/arch/arm/include/asm/arch-meson/boot0.h b/arch/arm/include/asm/arch-meson/boot0.h
>new file mode 100644
>index 00000000000..3ec085ccd64
>--- /dev/null
>+++ b/arch/arm/include/asm/arch-meson/boot0.h
>@@ -0,0 +1,18 @@
>+/* SPDX-License-Identifier: GPL-2.0+ */
>+/*
>+ * (C) Copyright 2026 Lucas Tanure <tanure@linux.com>
>+ */
>+
>+#ifndef __MESON_BOOT0_H
>+#define __MESON_BOOT0_H
>+
>+/*
>+ * The T7-family secure firmware writes the SCS device keys into the
>+ * first page of the loaded BL33 image (2048 bytes for the BL33 key
>+ * followed by 2048 bytes for the kernel key). Keep that page reserved
>+ * so the keys do not overwrite U-Boot's entry code.
>+ */
>+	b	reset
>+	.space	4096
>+
>+#endif /* __MESON_BOOT0_H */
>diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
>index c687ef822a2..40aafc0b922 100644
>--- a/arch/arm/mach-meson/Kconfig
>+++ b/arch/arm/mach-meson/Kconfig
>@@ -67,6 +67,15 @@ config MESON_A1
> 	help
> 	  Select this if your SoC is an A113L
> 
>+config MESON_T7
>+	bool "T7"
>+	select MESON64_COMMON
>+	select ENABLE_ARM_SOC_BOOT0_HOOK
>+	imply OF_UPSTREAM
>+	help
>+	  Select this if your SoC is from the Amlogic T7 family, like
>+	  the A311D2 found on the Khadas VIM4 board.
>+

I would shorten this to:

	help
	  Select this if your SoC is an A311D2

to match other SoCs' help message.

> endchoice
> 
> config SYS_SOC
>@@ -91,6 +100,7 @@ config SYS_BOARD
> 	default "q200" if MESON_GXM
> 	default "s400" if MESON_AXG
> 	default "u200" if MESON_G12A
>+	default "vim4" if MESON_T7
> 	default ""
> 	help
> 	  This option contains information about board name.
>diff --git a/arch/arm/mach-meson/Makefile b/arch/arm/mach-meson/Makefile
>index 08a24d4b24f..dc2bc0ceecb 100644
>--- a/arch/arm/mach-meson/Makefile
>+++ b/arch/arm/mach-meson/Makefile
>@@ -17,3 +17,4 @@ endif
> obj-$(CONFIG_MESON_AXG) += board-axg.o
> obj-$(CONFIG_MESON_G12A) += board-g12a.o
> obj-$(CONFIG_MESON_A1) += board-a1.o
>+obj-$(CONFIG_MESON_T7) += board-t7.o
>diff --git a/arch/arm/mach-meson/board-t7.c b/arch/arm/mach-meson/board-t7.c
>new file mode 100644
>index 00000000000..a6ccec25c0e
>--- /dev/null
>+++ b/arch/arm/mach-meson/board-t7.c
>@@ -0,0 +1,97 @@
>+// SPDX-License-Identifier: GPL-2.0+
>+/*
>+ * (C) Copyright 2026 Lucas Tanure <tanure@linux.com>
>+ */
>+
>+#include <init.h>
>+#include <asm/arch/boot.h>
>+#include <asm/arch/mem.h>
>+#include <asm/armv8/mmu.h>
>+#include <asm/global_data.h>
>+#include <asm/io.h>
>+#include <linux/bitops.h>
>+#include <linux/compiler.h>
>+#include <linux/errno.h>
>+#include <linux/kernel.h>
>+
>+DECLARE_GLOBAL_DATA_PTR;
>+
>+#define T7_WDT_CTRL		0xfe002100
>+#define T7_WDT_CTRL_EN		BIT(18)
>+

These should probably go in a header file? E.g. asm/arch/t7.h?

>+int board_init(void)
>+{
>+	/*
>+	 * The secure firmware boots BL33 with the watchdog running,
>+	 * disable it.
>+	 */
>+	writel(readl(T7_WDT_CTRL) & ~T7_WDT_CTRL_EN, T7_WDT_CTRL);

In the future it might make sense to write a proper watchdog driver.
Though I'm also guilty for doing it this way in U-Boot SPL gxbb/gxl (I
think eventually I'll remove this handling there and have U-Boot
proper manage the watchdog).

Then you can drop this board_init() function entirely. With that said
I won't feel bad if you keep it that way for now.

>+
>+	return 0;
>+}
>+
>+/*
>+ * The secure world owns 0x05000000 - 0x09000000: it contains the BL31
>+ * and BL32 runtime zones (also described as reserved-memory in the
>+ * upstream devicetree) and further firmware-protected pages, and is
>+ * left unmapped in t7_mem_map below. Reserve the whole span so nothing
>+ * (EFI allocations, boot-time relocations) is ever placed in memory
>+ * U-Boot cannot access.
>+ */
>+#define T7_SECMON_RSVMEM_START	0x05000000UL
>+#define T7_SECMON_RSVMEM_SIZE	0x04000000UL
>+

This too, should probably go in a header file.

>+void meson_init_reserved_memory(__maybe_unused void *fdt)
>+{

Why __maybe_unused ?

>+	meson_board_add_reserved_memory(fdt, T7_SECMON_RSVMEM_START,
>+					T7_SECMON_RSVMEM_SIZE);
>+}
>+
>+int meson_get_boot_device(void)
>+{
>+	return -ENOSYS;
>+}
>+
>+phys_size_t get_effective_memsize(void)
>+{
>+	/*
>+	 * The top 8 MiB of the first DRAM bank contain pages the secure
>+	 * world protects at runtime, keep U-Boot below them.
>+	 */
>+	return min(gd->ram_size, (phys_size_t)0xdf800000);
>+}
>+
>+static struct mm_region t7_mem_map[] = {
>+	{
>+		/* DRAM below the secure monitor reserved zone */
>+		.virt = 0x00000000UL,
>+		.phys = 0x00000000UL,
>+		.size = 0x05100000UL,
>+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>+			 PTE_BLOCK_INNER_SHARE
>+	}, {
>+		/*
>+		 * DRAM between the secure monitor reserved zone and the
>+		 * end of the first bank. 0x05100000 - 0x09000000 is
>+		 * protected by the secure world and must not be mapped.
>+		 */
>+		.virt = 0x09000000UL,
>+		.phys = 0x09000000UL,
>+		.size = 0xd7000000UL,
>+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>+			 PTE_BLOCK_INNER_SHARE
>+	}, {
>+		/* Peripherals, GIC, ... */
>+		.virt = 0xe0000000UL,
>+		.phys = 0xe0000000UL,
>+		.size = 0x20000000UL,
>+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>+			 PTE_BLOCK_NON_SHARE |
>+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
>+	}, {
>+		/* List terminator */
>+		0,
>+	}
>+};
>+
>+struct mm_region *mem_map = t7_mem_map;
>-- 
>2.55.0
>
>
>
>-=-=-=-=-=-=-=-=-=-=-=-
>Groups.io Links: You receive all messages sent to this group.
>View/Reply Online (#3015): https://groups.io/g/u-boot-amlogic/message/3015
>Mute This Topic: https://groups.io/mt/120681747/8399868
>Group Owner: u-boot-amlogic+owner@groups.io
>Unsubscribe: https://groups.io/g/u-boot-amlogic/unsub [funderscore@postmarketos.org]
>-=-=-=-=-=-=-=-=-=-=-=-
>
>
Best regards,
Ferass
