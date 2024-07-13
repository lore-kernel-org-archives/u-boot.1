Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D3BC3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:27:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1377A888D7;
	Sat, 13 Jul 2024 15:21:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wUamKQjg";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mHkJnGf2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E774888CC; Sat, 13 Jul 2024 15:21:45 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 923B4888D7
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WLpyb33dRz9sV1;
 Sat, 13 Jul 2024 15:21:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iUKa/ToD7aswAS04hiDdk5wWGXcf002Rtbe/IAsK2FY=;
 b=wUamKQjg5x9sje9eC9IE62TdkVUk/cCkP0ssgZf0qDayVQQKvpr7z7XYR6jkxpinXzx+B5
 siinEREyJRn+lJrTWdCRh+AvX97D+JVr/YQpDWeEX5DiIBu7U7i1robcB6/k8LPMg71Smb
 Fzu56DKXHvuNlllmU9M6yY5QZyFeXu1ZVDjwhjp/dpwIYFFXBL0aW7HAOFzTPdp30YEG/g
 UDBioESeFXMZGz0fpEGVfpE5UtkTxcZVhVoelSlK37OLJ0/TFaNtNV2zMhF1VVwNIrmSr/
 PwEIiYBUqRMNQ7dlui3TZwUmqrV1lF6zX6Nw5DBf0+ZQyXa7a0JY9MSFRGN0rA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iUKa/ToD7aswAS04hiDdk5wWGXcf002Rtbe/IAsK2FY=;
 b=mHkJnGf2SRu5+pqSvAk80C8cPdTNVoxGA962WTN7UFNT47gmn7NoRc3jfNOLXTVPSK0zuQ
 oiL6vQqGL7qcZkVowCG/NwTjsFM6/eNjetsZNFfFWFqXqLBeTrym7ol8JwZQnCJF/yYl1Y
 oJo1MKwcEHVBbGGdoWRwTkoc9hVse/736HPb9bDxNrlf/iijBblV8TMNour8xPps8LYbup
 2rp4T/Bxcx8yDrdwkdIK5rhENKP5W//XcUTnxc4wcVE7m7wTP0r+h8cwxaLwZYAE4DITkv
 L+2pCjQLbna4R9aTFiLN+4Pi/opA6nMZJ5VI0//9MqmTCdScyCQZfdfpwBAa1Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 34/45] mips: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:25 +0200
Message-ID: <20240713132021.57650-34-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2edc357aa80629c3d14
X-MBO-RS-META: j4xon5qzetfb8u7eop7yzcrtoh3xgoao
X-Rspamd-Queue-Id: 4WLpyb33dRz9sV1
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/mips/include/asm/io.h                  | 1 -
 arch/mips/include/asm/isa-rev.h             | 1 -
 arch/mips/include/asm/mipsregs.h            | 6 ------
 arch/mips/include/asm/pgtable-bits.h        | 2 --
 arch/mips/mach-ath79/qca953x/clk.c          | 1 -
 arch/mips/mach-octeon/include/mangle-port.h | 1 -
 6 files changed, 12 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 3774acaadc3..4acc439ccfb 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -485,7 +485,6 @@ BUILDSTRING(q, u64)
 #define outsq outsq
 #endif
 
-
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
 #define mmiowb() wmb()
 #else
diff --git a/arch/mips/include/asm/isa-rev.h b/arch/mips/include/asm/isa-rev.h
index 683ea3454dc..8afa6aefc54 100644
--- a/arch/mips/include/asm/isa-rev.h
+++ b/arch/mips/include/asm/isa-rev.h
@@ -20,5 +20,4 @@
 #define MIPS_ISA_REV 0
 #endif
 
-
 #endif /* __MIPS_ASM_ISA_REV_H__ */
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 3db3965fcff..d02b1e50bdf 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -125,7 +125,6 @@
  */
 #define CP0_TX39_CACHE	$7
 
-
 /* Generic EntryLo bit definitions */
 #define ENTRYLO_G		(_ULCAST_(1) << 0)
 #define ENTRYLO_V		(_ULCAST_(1) << 1)
@@ -987,7 +986,6 @@
 #define CP1_FENR	$28
 #define CP1_STATUS	$31
 
-
 /*
  * Bits in the MIPS32/64 coprocessor 1 (FPU) revision register.
  */
@@ -1102,7 +1100,6 @@
 #define FPU_CSR_RU	0x2	/* towards +Infinity */
 #define FPU_CSR_RD	0x3	/* towards -Infinity */
 
-
 #ifndef __ASSEMBLY__
 
 /*
@@ -1261,7 +1258,6 @@ static inline void tlbinvf(void)
 		".set pop");
 }
 
-
 /*
  * Functions to access the R10000 performance counters.	 These are basically
  * mfc0 and mtc0 instructions from and to coprocessor register with a 5-bit
@@ -1307,7 +1303,6 @@ do {								\
 	: "r" (val), "i" (counter));				\
 } while (0)
 
-
 /*
  * Macros to access the system control coprocessor
  */
@@ -2403,7 +2398,6 @@ do {									\
 	mfhi3;								\
 })
 
-
 #define mtlo0(x)							\
 ({									\
 	__asm__(							\
diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index 481d2ef6c2f..2dacdbbcdbe 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -7,7 +7,6 @@
 #ifndef _ASM_PGTABLE_BITS_H
 #define _ASM_PGTABLE_BITS_H
 
-
 /*
  * Note that we shift the lower 32bits of each EntryLo[01] entry
  * 6 bits to the left. That way we can convert the PFN into the
@@ -189,7 +188,6 @@
  *   32-bit, R2 or later:       CCC D V G RI/R XI M A W P
  */
 
-
 #ifndef __ASSEMBLY__
 /*
  * pte_to_entrylo converts a page table entry (PTE) into a Mips
diff --git a/arch/mips/mach-ath79/qca953x/clk.c b/arch/mips/mach-ath79/qca953x/clk.c
index 379085f1ff7..e9a80c6f12f 100644
--- a/arch/mips/mach-ath79/qca953x/clk.c
+++ b/arch/mips/mach-ath79/qca953x/clk.c
@@ -61,7 +61,6 @@ int get_clocks(void)
 			& QCA953X_PLL_CLK_CTRL_CPU_POST_DIV_MASK) + 1;
 	gd->cpu_clk = pll / div;
 
-
 	val = readl(regs + QCA953X_PLL_DDR_CONFIG_REG);
 	/* VCOOUT = XTAL * DIV_INT */
 	div = (val >> QCA953X_PLL_DDR_CONFIG_REFDIV_SHIFT)
diff --git a/arch/mips/mach-octeon/include/mangle-port.h b/arch/mips/mach-octeon/include/mangle-port.h
index 7e95dcef5af..554bdc55cf2 100644
--- a/arch/mips/mach-octeon/include/mangle-port.h
+++ b/arch/mips/mach-octeon/include/mangle-port.h
@@ -43,7 +43,6 @@ static inline bool __should_swizzle_addr(u64 p)
 
 #endif /* __BIG_ENDIAN */
 
-
 # define ioswabb(a, x)		(x)
 # define __mem_ioswabb(a, x)	(x)
 # define ioswabw(a, x)		(__should_swizzle_bits(a) ? le16_to_cpu(x) : x)
-- 
2.43.0

