Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B19E606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Kg5ax5BW;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=afYUksaJ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15D8560760;
	Mon, 23 Nov 2026 14:22:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q5WaY2J7lJLr; Mon, 23 Nov 2026 14:22:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 89AD06071F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795443769;
	b=BDjv1uIz54pOxPSa8JsDFpXsi+FabT37U9IlIbsbtn5Sm2xfLn/cJzTEDQXOIzOSmhGy
	 8O91rOtb1cECe3smLURRAmk9Kwz/lrT6kMNjIlWNfLMD+PWAKmwYi+ggZ8DD7W0wD4vDz
	 tU+7BdymODUsiIAk7gcYZBBoylJy+k6tCWrfKRQQDBF7c6T3dnFnEuiraVJCVjVCKxvz8
	 fhOpHW0s5Mb2K5OTlmxVba4Gkwu/l2b5Jpgx3fRqo1NO2HmEZxl10PbBrlaHWd2oUZQh0
	 ft7AsQDKAkzb2XGN+AZh2yozVivaU5iQvxiU5SHHNM8RdafyebbZ/jlUk8EnFtEDOhg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795443769;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+2Uhj9gruFOMhoVii0uvHB7xCcQhVabNWxL0VvVFMQE=;
	b=lXClQeSoiyz7ZKIM5UCKSYZ5nQe2gQaygsl61mIkyYfG/K72DvDFojjYej76G9QCBmxm
	 yPDnXxBBSGT9Bo8EgCnhSlfFhzVe9KSFLKu5r9xcPWmGatiTZiy5H+rQybJiNmfj3qWUN
	 /r3+KdnY8AbyV77BBa2Q2dhLtAjkXblX9m7pZkkuDZwy1Spi/qbz5yGsInpWo6Q96oI13
	 nVHvqqZNCYZBvtwO6s9cAyq9u4eDij4/DDBui//hrhN7f8nKn2nBuZr5nJeosqkOnyRU/
	 JjauG7Eu6QDjOYb9j1hXIKbrqmugwVfzfTJm+NUFaG9Z/VEY4rppWzU6m9z2ts8+n+Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795443769;
	bh=+2Uhj9gruFOMhoVii0uvHB7xCcQhVabNWxL0VvVFMQE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kg5ax5BWUm4m4nNr7roc3ajgjjWG8cyYR9+ubY7mcOFH1pMRsWSPAHSj2JDmF6E95
	 hokMJrB95zwN8WU4qK22i06eOHbO3Iyc3FUZnoTbrPOQoNn4tKMhtEbD1lxX0CIWZ8
	 Z7UaOY6gRWdS6a+e4ZnyASVeHxoxxjgxHl8w5a2aXHfL0EvQNz7jynW9mzVEli7s4u
	 zgl3oyhwp1m+PGUM6RZbBUj7eO1NbLoyXJdR6NzCEz8uyCytPenunXY8bqrIYYvEZt
	 ZMJXYuJv0njWrjmNbjnIod1BDFuTsfTGI9aRUcIDo7N9TH1i0/7zCM9UZRMSGKtgWb
	 9avzJ390ldQGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 89AD06071F;
	Mon, 23 Nov 2026 14:22:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B655759
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:22:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 314B440682
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:22:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kb-4k_zWteBX for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 14:22:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4C73F40506
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=afYUksaJ
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4C73F40506
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:22:44 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 503BB1A1799;
 Mon, 23 Nov 2026 14:22:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 22D47601E1;
 Mon, 23 Nov 2026 14:22:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5326A11E6A51D; Mon, 23 Nov 2026 15:22:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795443757; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=+2Uhj9gruFOMhoVii0uvHB7xCcQhVabNWxL0VvVFMQE=;
 b=afYUksaJwsT1ZO5wo3oCmTSiianRafZBvUbG90NBzymIc0gSrsSqdKjjEkTm1rfHyAHNaP
 s+3OjTzIKvRUrR36L6qhve/5t9S2MCQRQmyDerpjRWnyHzvtYjo8MPbNObSp/PB1MfJpmh
 rvdyfjIklO6eHhdhsaJ3ypWL4bNzTRvj2rEfaLC768m+I1XGMYyh10s44p8pY6WvWqPRMi
 yquCjwuBISRVlZLoRiFGSzxdDyjW3FNJ1b/CPBWacpmPslThY9ySm1tjgIL5pAqneJuInx
 UASc2nP6sbpeO91eaMApxW6ni2cQe4GgpGsqluEC5cz3BCqtbfLARW/rJiw8DQ==
From: "Richard Genoud (Synaptics)" <richard.genoud@bootlin.com>
Date: Mon, 23 Nov 2026 15:22:00 +0100
Subject: [PATCH v2 1/8] arm: synaptics: add SL2619 SoC and RDK board
 support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261123-sl2619_base-v2-1-9e3b28c77cda@bootlin.com>
References: <20261123-sl2619_base-v2-0-9e3b28c77cda@bootlin.com>
In-Reply-To: <20261123-sl2619_base-v2-0-9e3b28c77cda@bootlin.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Terry Zhou <terryzhou05@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Michal Simek <michal.simek@amd.com>, Linus Walleij <linusw@kernel.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 Chris Packham <judge.packham@gmail.com>, Adam Ford <aford173@gmail.com>, 
 Marek Vasut <marex@nabladev.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Peng Fan <peng.fan@nxp.com>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Torsten Duwe <duwe@suse.de>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Guodong Xu <guodong@riscstar.com>, Yixun Lan <dlan@kernel.org>, 
 Jisheng Zhang <jszhang@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.16.1-dev-53874
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Introduce mach-synaptics to support SL2619 SoC-based boards. This adds
the platform Kconfig and build infrastructure, along with initial
SL2619 RDK board support and defconfig

Introduce SYNAPTICS_SL2619, along with ARCH_SYNAPTICS which selects
ARM64, driver model, SYS_NS16550 and GIC-v2.

Signed-off-by: Richard Genoud (Synaptics) <richard.genoud@bootlin.com>
---
 Kconfig                                          |   1 +
 MAINTAINERS                                      |   6 +
 arch/arm/Kconfig                                 |  23 +++
 arch/arm/Makefile                                |   1 +
 arch/arm/mach-synaptics/Kconfig                  |  35 +++++
 arch/arm/mach-synaptics/Makefile                 |   5 +
 arch/arm/mach-synaptics/cpu.c                    |  45 ++++++
 board/synaptics/sl2619/Kconfig                   |   9 ++
 board/synaptics/sl2619/Makefile                  |   5 +
 board/synaptics/sl2619/sl2619.c                  |  73 ++++++++++
 configs/synaptics_sl2619_defconfig               |  54 +++++++
 doc/board/index.rst                              |   1 +
 doc/board/synaptics/img/sl2610_boot_sequence.svg | 178 +++++++++++++++++++++++
 doc/board/synaptics/index.rst                    |   9 ++
 doc/board/synaptics/sl2619.rst                   | 100 +++++++++++++
 include/configs/synaptics_sl2619.h               |  14 ++
 16 files changed, 559 insertions(+)

diff --git a/Kconfig b/Kconfig
index c8cfbf5d5de2..8e91a3360a83 100644
--- a/Kconfig
+++ b/Kconfig
@@ -621,6 +621,7 @@ config SYS_LOAD_ADDR
 	hex "Address in memory to use by default"
 	default 0x01000000 if ARCH_SOCFPGA
 	default 0x02000000 if PPC || X86
+	default 0x0cf00000 if ARCH_SYNAPTICS
 	default 0x81000000 if MACH_SUNIV
 	default 0x22000000 if MACH_SUN9I
 	default 0x42000000 if ARCH_SUNXI
diff --git a/MAINTAINERS b/MAINTAINERS
index 3f4f984bebdd..5f66db5d4608 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -707,6 +707,12 @@ F:	drivers/pinctrl/sunxi/
 F:	drivers/video/sunxi/
 F:	tools/sunxi*
 
+ARM SYNAPTICS
+M:	Richard Genoud <richard.genoud@bootlin.com>
+M:	Terry Zhou <terryzhou05@gmail.com>
+S:	Maintained
+N:	synaptics
+
 ARM TEGRA
 M:	Thierry Reding <treding@nvidia.com>
 M:	Svyatoslav Ryhel <clamor95@gmail.com>
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 93a0c663043f..148287c82f7f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1292,6 +1292,27 @@ config ARCH_SUNXI
 	imply USB_GADGET
 	imply WDT
 
+config ARCH_SYNAPTICS
+	bool "Support Synaptics SoCs"
+	select ARM64
+	select CLK
+	select DM
+	select DM_RESET
+	select DM_SERIAL
+	select GICV2
+	select OF_CONTROL
+	select PSCI_RESET
+	select PINCTRL
+	select SYNAPTICS_SL2619
+	select SYSRESET
+	select SYSRESET_PSCI
+	select SYSCON
+	select SYS_NS16550
+	imply OF_UPSTREAM
+	help
+	  Support for Synaptics SoCs such as the Astra SL2610 product
+	  line.
+
 config ARCH_U8500
 	bool "ST-Ericsson U8500 Series"
 	select CPU_V7A
@@ -2441,6 +2462,8 @@ source "arch/arm/mach-stm32mp/Kconfig"
 
 source "arch/arm/mach-sunxi/Kconfig"
 
+source "arch/arm/mach-synaptics/Kconfig"
+
 source "arch/arm/mach-tegra/Kconfig"
 
 source "arch/arm/mach-u8500/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index de975fc93686..ba7d3d7cee18 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -87,6 +87,7 @@ machine-$(CONFIG_ARCH_SOCFPGA)		+= socfpga
 machine-$(CONFIG_ARCH_STM32)		+= stm32
 machine-$(CONFIG_ARCH_STM32MP)		+= stm32mp
 machine-$(CONFIG_ARCH_SUNXI)		+= sunxi
+machine-$(CONFIG_ARCH_SYNAPTICS)	+= synaptics
 machine-$(CONFIG_ARCH_TEGRA)		+= tegra
 machine-$(CONFIG_ARCH_U8500)		+= u8500
 machine-$(CONFIG_ARCH_OCTEONTX)		+= octeontx
diff --git a/arch/arm/mach-synaptics/Kconfig b/arch/arm/mach-synaptics/Kconfig
new file mode 100644
index 000000000000..b485f438afff
--- /dev/null
+++ b/arch/arm/mach-synaptics/Kconfig
@@ -0,0 +1,35 @@
+if ARCH_SYNAPTICS
+
+config SYS_SOC
+	default "synaptics"
+
+config SYS_VENDOR
+	default "synaptics"
+
+config SYNAPTICS_SL2619
+	bool "Synaptics SL2619 SoC"
+	help
+	  The Synaptics SL2619 is a ARM64-based SoC with a dual-core Cortex-A55.
+	  including UART, SPI, USB2.0 and OTG, EMMC, etc.
+
+config SYNAPTICS_REGMEM_MAP_BASE
+	hex
+	default 0xe0000000 if SYNAPTICS_SL2619
+
+config SYNAPTICS_REGMEM_MAP_SIZE
+	hex
+	default 0x20000000 if SYNAPTICS_SL2619
+
+if SYNAPTICS_SL2619
+
+config TARGET_SL2619
+	bool "Support Synaptics SL2619 RDK board"
+	help
+	  Support for the Synaptics Astra Machina SL2619 RDK board based on the
+	  Synaptics SL2619 SoC.
+
+source "board/synaptics/sl2619/Kconfig"
+
+endif
+
+endif
diff --git a/arch/arm/mach-synaptics/Makefile b/arch/arm/mach-synaptics/Makefile
new file mode 100644
index 000000000000..5fc4b23719f7
--- /dev/null
+++ b/arch/arm/mach-synaptics/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2026 Synaptics Incorporated
+
+obj-y += cpu.o
diff --git a/arch/arm/mach-synaptics/cpu.c b/arch/arm/mach-synaptics/cpu.c
new file mode 100644
index 000000000000..2f890f6f7d5d
--- /dev/null
+++ b/arch/arm/mach-synaptics/cpu.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 Synaptics Incorporated
+ */
+
+#include <asm/armv8/mmu.h>
+#include <fdtdec.h>
+
+#define SYNAPTICS_MEM_MAP_LEN ((CONFIG_NR_DRAM_BANKS) + 2)
+/*
+ * Force synaptics_mem_map initialization since this code runs
+ * before BSS is cleared.
+ * The last entry is the sentinel
+ */
+__section(".data") static struct mm_region synaptics_mem_map[SYNAPTICS_MEM_MAP_LEN] = { 0 };
+struct mm_region *mem_map = synaptics_mem_map;
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+int dram_init_banksize(void)
+{
+	struct mm_region *reg_mem = mem_map + CONFIG_NR_DRAM_BANKS;
+	int ret;
+
+	ret = fdtdec_setup_memory_banksize();
+	if (ret)
+		return ret;
+
+	ret = mem_map_from_dram_banks(0, SYNAPTICS_MEM_MAP_LEN,
+				      PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+					     PTE_BLOCK_INNER_SHARE);
+	if (ret)
+		return ret;
+
+	reg_mem->virt = CONFIG_SYNAPTICS_REGMEM_MAP_BASE;
+	reg_mem->phys = CONFIG_SYNAPTICS_REGMEM_MAP_BASE;
+	reg_mem->size = CONFIG_SYNAPTICS_REGMEM_MAP_SIZE;
+	reg_mem->attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+		PTE_BLOCK_NON_SHARE | PTE_BLOCK_PXN | PTE_BLOCK_UXN;
+
+	return 0;
+}
diff --git a/board/synaptics/sl2619/Kconfig b/board/synaptics/sl2619/Kconfig
new file mode 100644
index 000000000000..cab256a7750d
--- /dev/null
+++ b/board/synaptics/sl2619/Kconfig
@@ -0,0 +1,9 @@
+if TARGET_SL2619
+
+config SYS_BOARD
+	default "sl2619"
+
+config SYS_CONFIG_NAME
+	default "synaptics_sl2619"
+
+endif
diff --git a/board/synaptics/sl2619/Makefile b/board/synaptics/sl2619/Makefile
new file mode 100644
index 000000000000..c658f81d1c1b
--- /dev/null
+++ b/board/synaptics/sl2619/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2026 Synaptics Incorporated
+
+obj-y := sl2619.o
diff --git a/board/synaptics/sl2619/sl2619.c b/board/synaptics/sl2619/sl2619.c
new file mode 100644
index 000000000000..9de6b20d2a5e
--- /dev/null
+++ b/board/synaptics/sl2619/sl2619.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 Synaptics Incorporated
+ */
+
+#include <asm/io.h>
+#include <dm/ofnode.h>
+#include <linux/bitops.h>
+#include <linux/errno.h>
+#include <linux/ioport.h>
+#include <linux/string.h>
+
+/* UART Software Reset Register */
+#define SYNA_UART_SRR		0x88
+/* Reset bits */
+#define SYNA_UART_RST		BIT(0)
+#define SYNA_UART_RST_FIFO_RCVR	BIT(1)
+#define SYNA_UART_RST_FIFO_XMIT	BIT(2)
+#define SYNA_UART_RST_ALL	(SYNA_UART_RST | SYNA_UART_RST_FIFO_RCVR | \
+				 SYNA_UART_RST_FIFO_XMIT)
+
+/*
+ * ROM boot code leaves the UART console in a non default state,
+ * reset it before probing the serial driver.
+ */
+static int reset_console(void)
+{
+	struct resource res;
+	const char *str;
+	ofnode node;
+	int ret;
+
+	str = ofnode_read_chosen_string("stdout-path");
+	if (!str)
+		return -ENOENT;
+
+	if (str[0] == '/') {
+		node = ofnode_path(str);
+	} else {
+		char alias[32]; /* max recommended length in DT */
+		const char *p;
+		int namelen;
+
+		p = strchr(str, ':');
+		namelen = p ? p - str : strlen(str);
+		if (namelen >= sizeof(alias))
+			return -ENAMETOOLONG;
+		memcpy(alias, str, namelen);
+		alias[namelen] = '\0';
+		node = ofnode_get_aliases_node(alias);
+	}
+
+	if (!ofnode_valid(node))
+		return -ENOENT;
+
+	ret = ofnode_read_resource(node, 0, &res);
+	if (ret)
+		return ret;
+
+	if (!ofnode_device_is_compatible(node, "syna,sl2610-uart"))
+		return -ENODEV;
+
+	writel(SYNA_UART_RST_ALL, (uintptr_t)(res.start + SYNA_UART_SRR));
+
+	return 0;
+}
+
+int board_early_init_f(void)
+{
+	reset_console();
+
+	return 0;
+}
diff --git a/configs/synaptics_sl2619_defconfig b/configs/synaptics_sl2619_defconfig
new file mode 100644
index 000000000000..63bb1de97c89
--- /dev/null
+++ b/configs/synaptics_sl2619_defconfig
@@ -0,0 +1,54 @@
+CONFIG_ARM=y
+CONFIG_POSITION_INDEPENDENT=y
+# CONFIG_ARM64_SUPPORT_AARCH32 is not set
+CONFIG_ARCH_SYNAPTICS=y
+CONFIG_SYS_MALLOC_LEN=0x10000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x10000
+CONFIG_DEFAULT_DEVICE_TREE="synaptics/sl2619-rdk"
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_DM_RESET=y
+CONFIG_SYS_BOOTM_LEN=0x4000000
+CONFIG_SYS_LOAD_ADDR=0xcf00000
+CONFIG_WATCHDOG_TIMEOUT_MSECS=0
+CONFIG_TARGET_SL2619=y
+CONFIG_BOOTSTD=y
+CONFIG_SUPPORT_RAW_INITRD=y
+CONFIG_BOOTDELAY=0
+# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
+CONFIG_DEFAULT_FDT_FILE="sl2619-rdk.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_BOARD_EARLY_INIT_F=y
+# CONFIG_BOARD_INIT is not set
+CONFIG_HUSH_PARSER=y
+# CONFIG_BOOTM_PLAN9 is not set
+# CONFIG_BOOTM_RTEMS is not set
+# CONFIG_BOOTM_VXWORKS is not set
+# CONFIG_CMD_XIMG is not set
+# CONFIG_CMD_EXPORTENV is not set
+CONFIG_CMD_NVEDIT_INFO=y
+# CONFIG_CMD_LZMADEC is not set
+# CONFIG_CMD_LOADS is not set
+# CONFIG_CMD_ITEST is not set
+# CONFIG_CMD_SOURCE is not set
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_TIMER=y
+CONFIG_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_VERSION_VARIABLE=y
+# CONFIG_NET is not set
+CONFIG_SYSCON=y
+CONFIG_BOUNCE_BUFFER=y
+# CONFIG_GPIO is not set
+# CONFIG_I2C is not set
+CONFIG_MISC=y
+# CONFIG_MMC is not set
+CONFIG_SPECIFY_CONSOLE_INDEX=y
+CONFIG_DM_SERIAL=y
+CONFIG_SERIAL_RX_BUFFER=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_PSCI=y
+# CONFIG_TOOLS_LIBCRYPTO is not set
+# CONFIG_TOOLS_KWBIMAGE is not set
diff --git a/doc/board/index.rst b/doc/board/index.rst
index cc1d181a8e1d..7a66379a5b0a 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -66,6 +66,7 @@ Board-specific doc
    st/index
    starfive/index
    ste/index
+   synaptics/index
    tbs/index
    thead/index
    theobroma-systems/index
diff --git a/doc/board/synaptics/img/sl2610_boot_sequence.svg b/doc/board/synaptics/img/sl2610_boot_sequence.svg
new file mode 100644
index 000000000000..a0b356b46a24
--- /dev/null
+++ b/doc/board/synaptics/img/sl2610_boot_sequence.svg
@@ -0,0 +1,178 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
+<svg width="800px" height="600px" viewBox="40 59 1047 740" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
+  <defs/>
+  <g id="Arrière-plan"/>
+  <g id="Background"/>
+  <g id="Background"/>
+  <g id="Background"/>
+  <g id="Background"/>
+  <g id="Background"/>
+  <g id="Hintergrund"/>
+  <g id="Background">
+    <g>
+      <rect style="fill: #e5e5e5; fill-opacity: 1; stroke-opacity: 1; stroke-width: 2; stroke: #868686" x="896.2" y="627" width="153" height="149" rx="0" ry="0"/>
+      <text font-size="12.8" style="fill: #000000; fill-opacity: 1; stroke: none;text-anchor:middle;font-family:sans-serif;font-style:normal;font-weight:normal" x="972.7" y="707.2">
+        <tspan x="972.7" y="707.2"></tspan>
+      </text>
+    </g>
+    <g>
+      <rect style="fill: #e5e5e5; fill-opacity: 1; stroke-opacity: 1; stroke-width: 2; stroke: #868686" x="736.2" y="464" width="312.8" height="149" rx="0" ry="0"/>
+      <text font-size="12.8" style="fill: #000000; fill-opacity: 1; stroke: none;text-anchor:middle;font-family:sans-serif;font-style:normal;font-weight:normal" x="892.6" y="544.2">
+        <tspan x="892.6" y="544.2"></tspan>
+      </text>
+    </g>
+    <g>
+      <rect style="fill: #e5e5e5; fill-opacity: 1; stroke-opacity: 1; stroke-width: 2; stroke: #868686" x="561.2" y="286" width="153" height="149" rx="0" ry="0"/>
+      <text font-size="12.8" style="fill: #000000; fill-opacity: 1; stroke: none;text-anchor:middle;font-family:sans-serif;font-style:normal;font-weight:normal" x="637.7" y="366.2">
+        <tspan x="637.7" y="366.2"></tspan>
+      </text>
+    </g>
+    <g>
+      <rect style="fill: #e5e5e5; fill-opacity: 1; stroke-opacity: 1; stroke-width: 2; stroke: #868686" x="359.2" y="285" width="153" height="149" rx="0" ry="0"/>
+      <text font-size="12.8" style="fill: #000000; fill-opacity: 1; stroke: none;text-anchor:middle;font-family:sans-serif;font-style:normal;font-weight:normal" x="435.7" y="365.2">
+        <tspan x="435.7" y="365.2"></tspan>
+      </text>
+    </g>
+    <g>
+      <rect style="fill: #e5e5e5; fill-opacity: 1; stroke-opacity: 1; stroke-width: 2; stroke: #868686" x="363.2" y="85" width="153" height="149" rx="0" ry="0"/>
+      <text font-size="12.8" style="fill: #000000; fill-opacity: 1; stroke: none;text-anchor:middle;font-family:sans-serif;font-style:normal;font-weight:normal" x="439.7" y="165.2">
+        <tspan x="439.7" y="165.2"></tspan>
+      </text>
+    </g>
+    <rect style="fill: #ffacac; fill-opacity: 1; stroke-opacity: 1; stroke-width: 2; stroke: #cc1f1a" x="172" y="100" width="120" height="120" rx="0" ry="0"/>
+    <text font-size="12.8" style="fill: #000000; fill-opacity: 1; stroke: none;text-anchor:middle;font-family:sans-serif;font-style:normal;font-weight:normal" x="236" y="82.7">
+      <tspan x="236" y="82.7">Stored in ROM</tspan>
+    </text>
+    <line style="fill: none; stroke-opacity: 1; stroke-width: 2; stroke: #a34804" x1="140" y1="260" x2="1082" y2="264"/>
+    <text font-size="16.9333" style="fill: #000000; fill-opacity: 1; stroke: none;text-anchor:start;font-family:sans-serif;font-style:normal;font-weight:normal" x="40" y="160">
+      <tspan x="40" y="160">Cortex M3</tspan>
+    </text>
+    <rect style="fill: #fff8a8; fill-opacity: 1; stroke-opacity: 1; stroke-width: 2; stroke: #d9cb2f" x="378" y="302" width="120" height="120" rx="0" ry="0"/>
+    <text font-size="12.8" style="fill: #000000; fill-opacity: 1; stroke: none;text-anchor:middle;font-family:sans-serif;font-style:normal;font-weight:normal" x="232" y="152">
+      <tspan x="232" y="152">ROM</tspan>
+      <tspan x="232" y="168">code</tspan>
+    </text>
+    <g>
+      <polyline style="fill: none; stroke-opacity: 1; stroke-width: 2; stroke: #000000" points="442.2,220 438,220 438,292.264 "/>
+      <polygon style="fill: #000000; fill-opacity: 1; stroke-opacity: 1; stroke-width: 2; stroke: #000000" fill-rule="evenodd" points="438,299.764 433,289.764 438,292.264 443,289.764 "/>
+    </g>
+    <g>
+      <polyline style="fill: none; stroke-opacity: 1; stroke-width: 2; stroke: #000000" points="292,160 292,160 372.464,160 "/>
+      <polygon style="fill: #000000; fill-opacity: 1; stroke-opacity: 1; stroke-width: 2; stroke: #000000" fill-rule="evenodd" points="379.964,160 369.964,165 372.464,160 369.964,155 "/>
+    </g>
+    <text font-size="16.9333" style="fill: #000000; fill-opacity: 1; stroke: none;text-anchor:start;font-family:sans-serif;font-style:normal;font-weight:normal" x="40" y="360">
+      <tspan x="40" y="360">Cortex M52</tspan>
+    </text>
+    <line style="fill: none; stroke-opacity: 1; stroke-width: 2; stroke: #a34804" x1="140.4" y1="460" x2="1078" y2="461"/>
+    <g>
+      <line style="fill: none; stroke-opacity: 1; stroke-width: 2; stroke: #000000" x1="498" y1="362" x2="567.264" y2="362"/>
+      <polygon style="fill: #000000; fill-opacity: 1; stroke-opacity: 1; stroke-width: 2; stroke: #000000" fill-rule="evenodd" points="574.764,362 564.764,367 567.264,362 564.764,357 "/>
+    </g>
+    <text font-size="12.8" style="fill: #000000; fill-opacity: 1; stroke: none;text-anchor:middle;font-family:sans-serif;font-style:normal;font-weight:normal" x="438" y="354">
+      <tspan x="438" y="354">System Manager</tspan>
+      <tspan x="438" y="370">Bootloader</tspan>
+    </text>
+    <rect style="fill: #c5e387; fill-opacity: 1; stroke-opacity: 1; stroke-width: 2; stroke: #6a8954" x="748" y="477" width="118" height="120" rx="0" ry="0"/>
+    <text font-size="12.8" style="fill: #000000; fill-opacity: 1; stroke: none;text-anchor:middle;font-family:sans-serif;font-style:normal;font-weight:normal" x="807" y="541.731">
+      <tspan x="807" y="541.731">TF-A</tspan>
+    </text>
+    <text font-size="16.9333" style="fill: #000000; fill-opacity: 1; stroke: none;text-anchor:start;font-family:sans-serif;font-style:normal;font-weight:normal" x="40" y="560">
+      <tspan x="40" y="560">Cortex A55</tspan>
+    </text>
+    <rect style="fill: #c5e387; fill-opacity: 1; stroke-opacity: 1; stroke-width: 2; stroke: #6a8954" x="911" y="638" width="120" height="120" rx="0" ry="0"/>
+    <text font-size="12.8" style="fill: #000000; fill-opacity: 1; stroke: none;text-anchor:middle;font-family:sans-serif;font-style:normal;font-weight:normal" x="971" y="702.95">
+      <tspan x="971" y="702.95">U-Boot</tspan>
+    </text>
+    <g>
+      <line style="fill: none; stroke-opacity: 1; stroke-width: 2; stroke: #000000" x1="971.5" y1="596.5" x2="971.117" y2="628.265"/>
+      <polygon style="fill: #000000; fill-opacity: 1; stroke-opacity: 1; stroke-width: 2; stroke: #000000" fill-rule="evenodd" points="971.027,635.764 966.148,625.705 971.117,628.265 976.147,625.825 "/>
+    </g>
+    <text font-size="12.8" style="fill: #000000; fill-opacity: 1; stroke: none;text-anchor:start;font-family:sans-serif;font-style:normal;font-weight:normal" x="980" y="609.95">
+      <tspan x="980" y="609.95">Runs</tspan>
+    </text>
+    <line style="fill: none; stroke-opacity: 1; stroke-width: 2; stroke-dasharray: 20; stroke: #cc1f1a" x1="1086" y1="620" x2="145" y2="620"/>
+    <text font-size="12.8" style="fill: #000000; fill-opacity: 1; stroke: none;text-anchor:start;font-family:sans-serif;font-style:normal;font-weight:normal" x="402" y="660">
+      <tspan x="402" y="660">Normal world</tspan>
+    </text>
+    <text font-size="12.8" style="fill: #000000; fill-opacity: 1; stroke: none;text-anchor:start;font-family:sans-serif;font-style:normal;font-weight:normal" x="402" y="580">
+      <tspan x="402" y="580">Secure world</tspan>
+    </text>
+    <text font-size="12.8" style="fill: #000000; fill-opacity: 1; stroke: none;text-anchor:middle;font-family:sans-serif;font-style:normal;font-weight:normal" x="438" y="73">
+      <tspan x="438" y="73">Bundled in spk.bin</tspan>
+    </text>
+    <text font-size="12.8" style="fill: #000000; fill-opacity: 1; stroke: none;text-anchor:middle;font-family:sans-serif;font-style:normal;font-weight:normal" x="869" y="455">
+      <tspan x="869" y="455">Bundled in tkz.subimg</tspan>
+    </text>
+    <text font-size="12.8" style="fill: #000000; fill-opacity: 1; stroke: none;text-anchor:start;font-family:sans-serif;font-style:normal;font-weight:normal" x="882" y="556">
+      <tspan x="882" y="556"></tspan>
+    </text>
+    <text font-size="12.8" style="fill: #000000; fill-opacity: 1; stroke: none;text-anchor:middle;font-family:sans-serif;font-style:normal;font-weight:normal" x="977" y="795">
+      <tspan x="977" y="795">Bundled in bl.subimg</tspan>
+    </text>
+    <rect style="fill: #c5e387; fill-opacity: 1; stroke-opacity: 1; stroke-width: 2; stroke: #6a8954" x="914" y="476.5" width="115" height="120" rx="0" ry="0"/>
+    <text font-size="12.8" style="fill: #000000; fill-opacity: 1; stroke: none;text-anchor:middle;font-family:sans-serif;font-style:normal;font-weight:normal" x="971.5" y="541.231">
+      <tspan x="971.5" y="541.231">OP-TEE</tspan>
+    </text>
+    <g>
+      <line style="fill: none; stroke-opacity: 1; stroke-width: 2; stroke: #000000" x1="866" y1="537" x2="904.264" y2="536.601"/>
+      <polygon style="fill: #000000; fill-opacity: 1; stroke-opacity: 1; stroke-width: 2; stroke: #000000" fill-rule="evenodd" points="911.764,536.523 901.817,541.627 904.264,536.601 901.713,531.628 "/>
+    </g>
+    <text font-size="12.8" style="fill: #000000; fill-opacity: 1; stroke: none;text-anchor:middle;font-family:sans-serif;font-style:normal;font-weight:normal" x="891.376" y="522.2">
+      <tspan x="891.376" y="522.2">Runs</tspan>
+    </text>
+    <text font-size="12.8" style="fill: #000000; fill-opacity: 1; stroke: none;text-anchor:middle;font-family:sans-serif;font-style:normal;font-weight:normal" x="541" y="318.95">
+      <tspan x="541" y="318.95">Loads</tspan>
+      <tspan x="541" y="334.95">and</tspan>
+      <tspan x="541" y="350.95">runs</tspan>
+    </text>
+    <g>
+      <polyline style="fill: none; stroke-opacity: 1; stroke-width: 2; stroke: #000000" points="638.2,422 638.4,422 638.4,537 738.264,537 "/>
+      <polygon style="fill: #000000; fill-opacity: 1; stroke-opacity: 1; stroke-width: 2; stroke: #000000" fill-rule="evenodd" points="745.764,537 735.764,542 738.264,537 735.764,532 "/>
+    </g>
+    <text font-size="12.8" style="fill: #000000; fill-opacity: 1; stroke: none;text-anchor:middle;font-family:sans-serif;font-style:normal;font-weight:normal" x="328" y="106.95">
+      <tspan x="328" y="106.95">Loads</tspan>
+      <tspan x="328" y="122.95">and</tspan>
+      <tspan x="328" y="138.95">runs</tspan>
+    </text>
+    <rect style="fill: #ffacac; fill-opacity: 1; stroke-opacity: 1; stroke-width: 2; stroke: #cc1f1a" x="382.2" y="100" width="120" height="120" rx="0" ry="0"/>
+    <text font-size="12.8" style="fill: #000000; fill-opacity: 1; stroke: none;text-anchor:middle;font-family:sans-serif;font-style:normal;font-weight:normal" x="440" y="155">
+      <tspan x="440" y="155">SPK</tspan>
+    </text>
+    <text font-size="12.8" style="fill: #000000; fill-opacity: 1; stroke: none;text-anchor:middle;font-family:sans-serif;font-style:normal;font-weight:normal" x="417" y="249.731">
+      <tspan x="417" y="249.731">Loads</tspan>
+      <tspan x="417" y="265.731">and</tspan>
+      <tspan x="417" y="281.731">runs</tspan>
+    </text>
+    <text font-size="12.8" style="fill: #000000; fill-opacity: 1; stroke: none;text-anchor:middle;font-family:sans-serif;font-style:normal;font-weight:normal" x="435" y="452">
+      <tspan x="435" y="452">Bundled in m52bl.bin</tspan>
+    </text>
+    <rect style="fill: #fff8a8; fill-opacity: 1; stroke-opacity: 1; stroke-width: 2; stroke: #d9cb2f" x="578.2" y="302" width="120" height="120" rx="0" ry="0"/>
+    <text font-size="12.8" style="fill: #000000; fill-opacity: 1; stroke: none;text-anchor:middle;font-family:sans-serif;font-style:normal;font-weight:normal" x="639" y="358">
+      <tspan x="639" y="358">System Manager</tspan>
+      <tspan x="639" y="374">Firmware</tspan>
+    </text>
+    <text font-size="12.8" style="fill: #000000; fill-opacity: 1; stroke: none;text-anchor:middle;font-family:sans-serif;font-style:normal;font-weight:normal" x="640" y="279">
+      <tspan x="640" y="279">Bundled in sysmgr.subimg</tspan>
+    </text>
+    <g>
+      <polyline style="fill: none; stroke-opacity: 1; stroke-width: 2; stroke: #000000" points="714.2,360.5 971,360.5 971,462.264 "/>
+      <polygon style="fill: #000000; fill-opacity: 1; stroke-opacity: 1; stroke-width: 2; stroke: #000000" fill-rule="evenodd" points="971,469.764 966,459.764 971,462.264 976,459.764 "/>
+    </g>
+    <text font-size="12.8" style="fill: #000000; fill-opacity: 1; stroke: none;text-anchor:start;font-family:sans-serif;font-style:normal;font-weight:normal" x="802" y="355">
+      <tspan x="802" y="355">Loads</tspan>
+    </text>
+    <g>
+      <polyline style="fill: none; stroke-opacity: 1; stroke-width: 2; stroke: #000000" points="638.3,422 638,422 638,702 900.264,702 "/>
+      <polygon style="fill: #000000; fill-opacity: 1; stroke-opacity: 1; stroke-width: 2; stroke: #000000" fill-rule="evenodd" points="907.764,702 897.764,707 900.264,702 897.764,697 "/>
+    </g>
+    <text font-size="12.8" style="fill: #000000; fill-opacity: 1; stroke: none;text-anchor:start;font-family:sans-serif;font-style:normal;font-weight:normal" x="678" y="693">
+      <tspan x="678" y="693">Loads</tspan>
+    </text>
+    <text font-size="12.8" style="fill: #000000; fill-opacity: 1; stroke: none;text-anchor:middle;font-family:sans-serif;font-style:normal;font-weight:normal" x="690" y="498.95">
+      <tspan x="690" y="498.95">Loads</tspan>
+      <tspan x="690" y="514.95">and</tspan>
+      <tspan x="690" y="530.95">runs</tspan>
+    </text>
+  </g>
+</svg>
diff --git a/doc/board/synaptics/index.rst b/doc/board/synaptics/index.rst
new file mode 100644
index 000000000000..03624fa904e1
--- /dev/null
+++ b/doc/board/synaptics/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Synaptics
+=========
+
+.. toctree::
+   :maxdepth: 2
+
+   sl2619
diff --git a/doc/board/synaptics/sl2619.rst b/doc/board/synaptics/sl2619.rst
new file mode 100644
index 000000000000..8be37d0696d6
--- /dev/null
+++ b/doc/board/synaptics/sl2619.rst
@@ -0,0 +1,100 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Synaptics Astra SL2619 RDK
+==========================
+
+The Synaptics SL2619 is an ARM64 SoC with a dual-core Cortex-A55. The
+SL2619 RDK (Astra Machina) is the corresponding reference design.
+
+Official documentation can be found here:
+https://synaptics-astra.github.io/doc/v/latest
+
+Along with official github page:
+https://github.com/synaptics-astra
+
+Mainline support
+----------------
+
+This is early stage support with:
+
+1. ns16550 UART
+2. CPU reset via PSCI
+3. Generic ARMv8 core timer
+
+Boot Flow
+---------
+Below is the pictorial representation of boot flow:
+
+.. image:: img/sl2610_boot_sequence.svg
+   :alt: Boot flow diagram
+
+Building
+--------
+
+U-Boot
+^^^^^^
+.. code-block:: console
+
+   export CROSS_COMPILE=aarch64-linux-gnu-
+   make synaptics_sl2619_defconfig
+   make
+
+This will generate ``u-boot.bin``.
+
+Generate ``bl.subimg``
+^^^^^^^^^^^^^^^^^^^^^^
+
+The boot flow expect a bootloader encapsulated in a ``bl.subimg`` file.
+
+Synaptics provides tools in order to do that.
+
+In U-Boot parent's directory:
+
+.. code-block:: console
+
+    git clone -b scarthgap_6.12_v2.5.0 https://github.com/synaptics-astra/build.git
+    git clone -b scarthgap_6.12_v2.5.0 https://github.com/synaptics-astra/security.git
+    git clone https://github.com/synaptics-astra/usb-tool.git
+
+    build/tools/bin/in_extras.py BOOT_LOADER_GENX_V3 in_boot_loader_extras.bin 0x00000000 0x00000000 0x600000 0x600000
+    build/tools/bin/gen_x_secure_image --chip-name=klamath --chip-rev=A0 \
+    	--img_type=BOOT_LOADER --key_type=ree --length=0x0 \
+    	--extras=in_boot_loader_extras.bin \
+    	--workdir-security-tools=build/tools/lib/sec_tools/bin \
+    	--workdir-security-keys=security/keys/chip/klamath/A0 \
+    	--tool-version=genx_v3 \
+    	--in_payload=u-boot/u-boot.bin \
+    	--out_store=usb-tool/astra-usbboot-images/sl2619/bl.subimg
+
+Booting
+-------
+
+USB-BOOT
+^^^^^^^^
+
+Reset the board while pressing the USB_BOOT button, then:
+
+.. code-block:: console
+
+    sudo ./usb-tool/bin/linux/x86_64/astra-boot -b bootloader usb-tool/astra-usbboot-images/sl2619
+
+Console
+-------
+
+The console is on UART0 (``sm_uart0``, 0xe5030000) at 115200n8.
+
+Sample boot log
+---------------
+
+.. code-block:: none
+
+   U-Boot 2027.01-rc2-00018-g4294c0eea931 (Nov 20 2026 - 09:56:16 +0100)
+
+   Model: Synaptics SL2619 RDK
+   DRAM:  2 GiB
+   Core:  29 devices, 13 uclasses, devicetree: separate
+   Loading Environment from nowhere... OK
+   In:    serial@e5030000
+   Out:   serial@e5030000
+   Err:   serial@e5030000
+   =>
diff --git a/include/configs/synaptics_sl2619.h b/include/configs/synaptics_sl2619.h
new file mode 100644
index 000000000000..b1729f814045
--- /dev/null
+++ b/include/configs/synaptics_sl2619.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Configuration settings for the Synaptics sl2619 RDK board.
+ *
+ * Copyright 2026 Synaptics Incorporated
+ */
+
+#ifndef __SYNAPTICS_SL2619_H
+#define __SYNAPTICS_SL2619_H
+
+#define GICD_BASE 0xf7e59000
+#define GICC_BASE 0xf7e5a000
+
+#endif /* __SYNAPTICS_SL2619_H */

-- 
2.55.0

