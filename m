Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B6FFC61DCD
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 19:50:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 10EC380EDC;
	Thu, 27 Aug 2026 19:50:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n-voXKKxO5JF; Thu, 27 Aug 2026 19:50:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787860247;
	bh=XSbml9Qo6dCyefMLfeUu9jUgePjvelsPL2Hh/2Ky4bs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UaMoAYn5LnOZeqgl48XXWUzt+ELwd0ORP8VNwKpPS2HNhycJjZ1sT4rW9u0xxUwjH
	 G6MZc3bTWeoO8fYVGeVKIcCgtUv9klCxVNHyhQrHlRKz5GvXkR98d/YFBIosXyLs0E
	 tLjvnb91FcJBiPZiCXh6F1DdIM677eVrFv/IgHvtfcuIRY2xtXm29WlaC5FD3oKTgj
	 fLDS9k36wz70VNh7gxVWGwZ/kZWLbywfslqXCg0Wf7/s1dJNah2p440Yo5PkQW3j66
	 ApQE6JHAkE5Hf3rboXuqbJpvRclSQeYN162x+IsJuol78vqIG0Roiv1MtQ2k3jgFHl
	 iqletisVnc4sw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 033C580ED8;
	Thu, 27 Aug 2026 19:50:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2BA9F334
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:36:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2982E400D7
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:36:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9hOIQdcwqRe5 for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 19:36:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=bbanelli@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=dxiFH+bf
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 020FB400D5
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:36:34 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-482e61a34e5so91627f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 12:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787859393; x=1788464193;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XSbml9Qo6dCyefMLfeUu9jUgePjvelsPL2Hh/2Ky4bs=;
 b=dxiFH+bfj+UMQ03vyS4Pt60W/f8mjBBuRD2Adx8/sHGTWrzZctGI3zEWJ4MDz8QBMS
 S+bwKO8K0dnxbWWZOGLFHSXgASRqnuIfefxEXHAiNAQenEnADlQRISgDldiyY6GKg07N
 Qt/l8hFEFCkaVMaO4gzFMj8gxtag0YU3miN9aGV/c8GJY5dP7bBraqDGxYpBWHU1x5qr
 MO2VULngM+wKym0j8DV+52cGSzx2BEAd/akHtygZG3OoFxe5Oi5kEcpvWYH5SbTJFbjW
 cw8BpE58az//VkxkKNIcJKpXbCK2Ar/omdLqKgXI5Kv+6FVSazAmcSUf8FYR1FbePSS8
 PDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787859393; x=1788464193;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XSbml9Qo6dCyefMLfeUu9jUgePjvelsPL2Hh/2Ky4bs=;
 b=G2LGjQBNCX3g/MldAkhjhChePJ3CPFOvxbT6ZsBGgWHlpJguWlreqyXn6R3xPUsBbW
 b4Ro18hErNBT0YP7dmPCXNjutaVfiZUtI2HMIGwot1uZVTJGuiLvPwaWi6fI/tFxhFpx
 6ohhdvx8ICqEemUoMG6XkXmFyU9lXHRJQBQQxjbseJNMMl540TDAi8Iw2/bc65uPLsjc
 /DrqlVuTA0lsX0ZpL1VHHUlBz+4Hyb8Apg/lSMPKy/fT34gZhS1S/evVQ4LF0Od7wK8E
 QkjG3vXzVVCeTEhQ6IOM8afrIfKkHxDGInQKmSZLZpv4J8PajbTxkHz6VXDsyuX6oY21
 2bbw==
X-Gm-Message-State: AFuF++mPlsk9RaA3+g6+X26EtHKXvWC9teXjaS23RZjeDzzBnxHWEvmh
 2R9ElsEmZKlkpM532CKy7/CpkRjDCB8ylS9bwMqQ/pBYxUD8QVm9aZeRrbR+ZWfu
X-Gm-Gg: AR+sD1249UwtwnyOYMAGafgnbqTmDl5oPkcvXDEybQmNO562m8/JxXgfSsy2QykZjkO
 F5ahel3dxKWK+YVtZ+YS+8wNd/Yr6r/CRZWSY5XBpEwHHJLgOoGGuXWKbxPcW7odgnn+LqKMogH
 bIN7henEnNikzG/iIL/XhQQ7re6AgsNNBzzpo7A01K/SkWkGSUnbY+QasN8VCeuE8lPyYZJHx+b
 /96IYdQz/H9lZQHbkBt5IvyR56NZ3lQjRqj/ce+4JVH7IiM1zLgDo3kaNZRH0aSGP08SyXrR/JJ
 W8YYfm1SfJu9O8I9oddqcfG/h75ryfTbod626JrNJltqUnY9e72GWwX3uwKILJMC7xFN/kUdme/
 VmNwnAspg/mg8Ivz+DjgyApv2HIhZvjU0zSDc6IP1SsZIFRRKYI+W8Za+jkpS2Huq85BRqLJzZk
 BT8x87GKvh+z9bBK1cwVnZ0xIwI5FCJqmRUM35RA6d1bgGpD2IgqqgtxEw7o37xzviplhkM3w3R
 /9M675pw9qMikbL+AczpZhSeqxFs0wxawsdMYhoQpdF8RBMeasPMEbDVA==
X-Received: by 2002:a05:6000:420b:b0:482:e10e:58df with SMTP id
 ffacd0b85a97d-482f7a03ba8mr1379200f8f.21.1787859392504; 
 Thu, 27 Aug 2026 12:36:32 -0700 (PDT)
Received: from GOLDENAXE.office-radnicka.localarea.network
 (c82-214-103-66.loc.akton.net. [82.214.103.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28e8499sm11457049f8f.26.2026.08.27.12.36.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 12:36:32 -0700 (PDT)
From: Bruno Banelli <bbanelli@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Vincent Jardin <vjardin@free.fr>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Bruno Banelli <bbanelli@gmail.com>
Subject: [PATCH] arm: mvebu: armada8k: do not offer the ATF/TEE region as free
 memory
Date: Thu, 27 Aug 2026 21:36:03 +0200
Message-ID: <20260827193602.208352-2-bbanelli@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 27 Aug 2026 19:50:39 +0000
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

mvebu_mem_map[] deliberately leaves the ATF and TEE region unmapped:

	{
		/* RAM 0-64MB */
		.phys = 0x0UL,
		.size = ATF_REGION_START,
		...
	},
	/* ATF and TEE region 0x4000000-0x5400000 not mapped */
	{
		/* RAM 66MB-2GB */
		.phys = ATF_REGION_END,
		...
	},

Nothing tells LMB about the hole, so the whole of DRAM bank 0 is added
as available memory (sizes elided from the dumps below for width):

 lmb_dump_all:
  memory.count = 0x2
  memory[0] [0x0-0xbfffffff], flags: none
  memory[1] [0x100000000-0x43fffffff], flags: none
  reserved.count = 0x4
  reserved[0] [0x4000000-0x41fffff], flags: no-map
  reserved[1] [0x7eb1d000-0x7eb1ffff], flags: no-notify, no-overwrite
  reserved[2] [0x7eb20f40-0xbfffffff], flags: no-overwrite
  reserved[3] [0x100000000-0x43fffffff], flags: no-overwrite

The only part of the hole that is reserved is the 2 MiB psci-area from
armada-ap80x.dtsi.  The remaining 18 MiB is allocatable, and since
lmb_add() notifies the EFI allocator, it is also published to EFI
payloads as EFI_CONVENTIONAL_MEMORY.  Any access to it faults:

  => md 0x4200000 4
  "Synchronous Abort" handler, esr 0x96000006, far 0x4200000
  Resetting CPU ...

ESR 0x96000006 is a data abort at the current exception level with
DFSC 0x06, a level 2 translation fault - there is no mapping, which is
exactly what mvebu_mem_map[] intends.  The same abort with WnR set
(esr 0x96000046) is what MemTest86 v11 for ARM64 hits on its first
write, because the EFI memory map it is handed says:

  0x000004000000 - 0x0000041FFFFF (2MB)  {Reserved Memory}
  0x000004200000 - 0x000006FFFFFF (46MB) {Free Memory}

Add an lmb_arch_add_memory() for Armada 8k that adds each DRAM bank
around the ATF and TEE region instead of over it, and select
LMB_ARCH_MEM_MAP for ARMADA_8K.  The hook replaces the generic
lmb_add_memory() rather than extending it, so it also has to reproduce
the LMB_LIMIT_DMA_BELOW_RAM_TOP reservation above gd->ram_top; both are
needed on this SoC, which maps only the first 2 GiB of DRAM.

After the change:

 lmb_dump_all:
  memory.count = 0x3
  memory[0] [0x0-0x3ffffff], flags: none
  memory[1] [0x5400000-0xbfffffff], flags: none
  memory[2] [0x100000000-0x43fffffff], flags: none
  reserved.count = 0x3
  reserved[0] [0x7eb1d000-0x7eb1ffff], flags: no-notify, no-overwrite
  reserved[1] [0x7eb20f40-0xbfffffff], flags: no-overwrite
  reserved[2] [0x100000000-0x43fffffff], flags: no-overwrite

  => md 0x4200000 4
  "Synchronous Abort" handler, esr 0x96000006, far 0x4200000
  => md 0x5400000 4
  05400000: 00000000 ffffffff 00000000 ffdfffff  ................

and MemTest86 completes passes instead of aborting.

Note the psci-area reservation disappears from the dump: the region is
no longer part of the LMB memory map, so boot_fdt_reserve_region() gets
-EINVAL back from lmb_alloc_mem() and skips it.  That is harmless - the
memory is not allocatable either way - but it is a visible change in
"bdinfo" output.

board_get_usable_ram_top() already clamps gd->ram_top to the 2 GiB that
mvebu_mem_map[] maps, for the same underlying reason.  A ram_top limit
cannot express a hole in the middle of a bank, hence this patch.

Tested on a SolidRun MACCHIATObin (Armada 8040) with 16 GiB of DRAM.

Signed-off-by: Bruno Banelli <bbanelli@gmail.com>
---
 arch/arm/mach-mvebu/armada8k/cpu.c | 89 ++++++++++++++++++++++++++++++
 lib/Kconfig                        |  2 +-
 2 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/armada8k/cpu.c b/arch/arm/mach-mvebu/armada8k/cpu.c
index 220b32dd02..666be973a7 100644
--- a/arch/arm/mach-mvebu/armada8k/cpu.c
+++ b/arch/arm/mach-mvebu/armada8k/cpu.c
@@ -6,8 +6,11 @@
 #include <cpu_func.h>
 #include <dm.h>
 #include <fdtdec.h>
+#include <lmb.h>
+#include <log.h>
 #include <linux/libfdt.h>
 #include <linux/sizes.h>
+#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/arch/cpu.h>
@@ -17,6 +20,8 @@
 
 #include "soc_info.h"
 
+DECLARE_GLOBAL_DATA_PTR;
+
 /* Armada 7k/8k */
 #define MVEBU_RFU_BASE			(MVEBU_REGISTER(0x6f0000))
 #define RFU_GLOBAL_SW_RST		(MVEBU_RFU_BASE + 0x84)
@@ -61,6 +66,90 @@ static struct mm_region mvebu_mem_map[] = {
 
 struct mm_region *mem_map = mvebu_mem_map;
 
+#if CONFIG_IS_ENABLED(LMB_ARCH_MEM_MAP)
+/**
+ * mvebu_lmb_reserve() - mark a region as present but not allocatable
+ * @base:	start of the region
+ * @size:	size of the region
+ */
+static void mvebu_lmb_reserve(phys_addr_t base, phys_size_t size)
+{
+	phys_addr_t addr = base;
+
+	if (lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &addr, size, LMB_NOOVERWRITE))
+		log_err("Failed to reserve 0x%llx bytes at 0x%llx\n",
+			(unsigned long long)size, (unsigned long long)base);
+}
+
+/**
+ * mvebu_lmb_add_bank() - add one memory range, honouring ram_top
+ * @base:	start of the range
+ * @size:	size of the range
+ * @ram_top:	highest address U-Boot may allocate from
+ *
+ * The reservation above @ram_top mirrors the generic lmb_add_memory(), which
+ * this hook replaces.
+ */
+static void mvebu_lmb_add_bank(phys_addr_t base, phys_size_t size, u64 ram_top)
+{
+	phys_addr_t bank_end = base + size;
+
+	lmb_add(base, size);
+
+	if (!IS_ENABLED(CONFIG_LMB_LIMIT_DMA_BELOW_RAM_TOP))
+		return;
+
+	if (base >= ram_top)
+		mvebu_lmb_reserve(base, size);
+	else if (bank_end > ram_top)
+		mvebu_lmb_reserve(ram_top, bank_end - ram_top);
+}
+
+/**
+ * lmb_arch_add_memory() - add DRAM to LMB, minus the ATF and TEE region
+ *
+ * mvebu_mem_map[] above deliberately has no entry for ATF_REGION_START to
+ * ATF_REGION_END, so U-Boot has no translation for that range and any access
+ * to it takes a translation fault. It must not be handed to LMB either:
+ * everything LMB holds as available is published to EFI payloads as
+ * EFI_CONVENTIONAL_MEMORY, and the first payload to use it aborts.
+ */
+void lmb_arch_add_memory(void)
+{
+	phys_addr_t bank_start, bank_end;
+	u64 ram_top = gd->ram_top;
+	int i;
+
+	/* Assume a 4GB ram_top if not defined */
+	if (!ram_top)
+		ram_top = 0x100000000ULL;
+
+	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
+		if (!gd->dram[i].size)
+			continue;
+
+		bank_start = gd->dram[i].start;
+		bank_end = bank_start + gd->dram[i].size;
+
+		if (bank_end <= ATF_REGION_START ||
+		    bank_start >= ATF_REGION_END) {
+			mvebu_lmb_add_bank(bank_start, gd->dram[i].size,
+					   ram_top);
+			continue;
+		}
+
+		if (bank_start < ATF_REGION_START)
+			mvebu_lmb_add_bank(bank_start,
+					   ATF_REGION_START - bank_start,
+					   ram_top);
+		if (bank_end > ATF_REGION_END)
+			mvebu_lmb_add_bank(ATF_REGION_END,
+					   bank_end - ATF_REGION_END,
+					   ram_top);
+	}
+}
+#endif
+
 void enable_caches(void)
 {
 	icache_enable();
diff --git a/lib/Kconfig b/lib/Kconfig
index 24e55ade4d..6b6b90bc91 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1295,7 +1295,7 @@ config SPL_LMB
 config LMB_ARCH_MEM_MAP
 	bool
 	depends on LMB
-	default y if FSL_LAYERSCAPE || X86
+	default y if ARMADA_8K || FSL_LAYERSCAPE || X86
 	help
 	  Some architectures have special or unique aspects which need
 	  consideration when adding memory ranges to the list of available
-- 
2.43.0

