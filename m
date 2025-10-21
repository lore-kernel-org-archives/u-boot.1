Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE00CCD1AB
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 23:54:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 490A8800B6;
	Wed, 22 Oct 2025 01:54:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EC1A82B20; Wed, 22 Oct 2025 01:54:16 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E855F80077
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 01:54:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6505E1063;
 Tue, 21 Oct 2025 16:54:05 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79CDE3F66E;
 Tue, 21 Oct 2025 16:54:12 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
 Rudi Horn <dyn-git@rudi-horn.de>, linux-sunxi@lists.linux.dev
Subject: [PATCH] sunxi: dram: detect non-power-of-2 sized DRAM chips
Date: Wed, 22 Oct 2025 00:53:34 +0100
Message-ID: <20251021235334.7557-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.4
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

Some boards feature an "odd" DRAM size, where the total RAM is 1.5GB or
3GB. Our existing DRAM size detection routines can only detect power-of-2
sized configuration, and on those boards the DRAM size is overestimated,
so this typically breaks the boot quite early.

There doesn't seem to be an easy explicit way to detect those odd-sized
chips, but we can test whether the later part of the memory behaves like
memory, by verifying that a written pattern can be read back.
Experiments show that there is no aliasing effect here, as all locations
in the unimplemented range always return some fixed pattern, and cannot
be changed.

Also so far all those boards use a factor of 3 of some lower power-of-2
number, or 3/4th of some higher number. The size detection routine
discovers the higher number, so we can check for some memory cells beyond
75% of the detected size to be legit.

Add a routine the inverts all bits at a given location in memory, and
reads that back to prove that the new value was stored.
Then test the memory cell at exactly 3/4th of the detected size, and cap
the size of the memory to 75% when this test fails.

This enables boards which ship with such odd memory sizes.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
Hi,

I don't really have a board with such an odd size to test that, though the
function worked on a 12GB A733 board. But that's not supporting the SPL
or any kind of DRAM init yet, so was tested out of context.
I would be grateful if anyone with a 1.5GB or 3GB board could test this.

Thanks,
Andre

 arch/arm/include/asm/arch-sunxi/dram.h |  1 +
 arch/arm/mach-sunxi/dram_dw_helpers.c  | 16 +++++++++++++++-
 arch/arm/mach-sunxi/dram_helpers.c     | 12 ++++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-sunxi/dram.h b/arch/arm/include/asm/arch-sunxi/dram.h
index 0eccb1e6c28..59e2e980bfa 100644
--- a/arch/arm/include/asm/arch-sunxi/dram.h
+++ b/arch/arm/include/asm/arch-sunxi/dram.h
@@ -45,5 +45,6 @@ unsigned long sunxi_dram_init(void);
 void mctl_await_completion(u32 *reg, u32 mask, u32 val);
 bool mctl_mem_matches(u32 offset);
 bool mctl_mem_matches_base(u32 offset, ulong base);
+bool mctl_check_memory(phys_addr_t addr);
 
 #endif /* _SUNXI_DRAM_H */
diff --git a/arch/arm/mach-sunxi/dram_dw_helpers.c b/arch/arm/mach-sunxi/dram_dw_helpers.c
index 24767354935..14f6b24c30f 100644
--- a/arch/arm/mach-sunxi/dram_dw_helpers.c
+++ b/arch/arm/mach-sunxi/dram_dw_helpers.c
@@ -143,8 +143,22 @@ void mctl_auto_detect_dram_size(const struct dram_para *para,
 
 unsigned long mctl_calc_size(const struct dram_config *config)
 {
+	unsigned long size;
 	u8 width = config->bus_full_width ? 4 : 2;
 
 	/* 8 banks */
-	return (1ULL << (config->cols + config->rows + 3)) * width * config->ranks;
+	size = (1ULL << (config->cols + config->rows + 3)) * width *
+		config->ranks;
+
+	/*
+	 * There are boards with non-power-of-2 sized DRAM chips, like 1.5GB
+	 * or 3GB. They are detected as the larger power-of-2 (2GB and 4GB),
+	 * so test the last quarter for being able to store values.
+	 */
+	if (!mctl_check_memory(CFG_SYS_SDRAM_BASE + size / 4 * 3)) {
+		size = (size / 4) * 3;
+		debug("capping memory at %ld MB\n", size >> 20);
+	}
+
+	return size;
 }
diff --git a/arch/arm/mach-sunxi/dram_helpers.c b/arch/arm/mach-sunxi/dram_helpers.c
index 83dbe4ca98f..376b7d14f86 100644
--- a/arch/arm/mach-sunxi/dram_helpers.c
+++ b/arch/arm/mach-sunxi/dram_helpers.c
@@ -62,3 +62,15 @@ bool mctl_mem_matches(u32 offset)
 	return mctl_mem_matches_base(offset, CFG_SYS_SDRAM_BASE);
 }
 #endif
+
+bool mctl_check_memory(phys_addr_t addr)
+{
+	uint32_t orig, val;
+
+	orig = readl(addr);
+	writel(~orig, addr);
+	val = readl(addr);
+	writel(orig, addr);
+
+	return ~orig == val;
+}
-- 
2.46.4

