Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BD2CF2562
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 23:17:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED9CA839AC;
	Wed, 19 Nov 2025 00:17:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lIIRWFSw";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BMR5H4uy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88194839E4; Wed, 19 Nov 2025 00:17:26 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8496483946
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 00:17:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dB0rN253bz9vC6;
 Wed, 19 Nov 2025 00:17:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763507844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mKb6RTcMEeKZzLhKKcRlRLsud00SCfEGVGBjoCKSZHY=;
 b=lIIRWFSwVsS7IOC5NBblsPTl9ZWsPCJ5iZ6tcuQyy18k7Fxveaz6l0Q4LLZWGzqCfcpsbz
 A8cuD6+q7nVSeSSf1YNZm8H07Cr9Tr6s7JPP3Rn+OcNJm8mpTblu9xZasI/ZJe2+HMt6M9
 COV0x0WgR5gNdPaKTMNyc3PtZjP6IEZg1/nxHUOZ2GdXFynJR7SorjoMk/GC/rQZBlJBfx
 xvJkbujTtpMZuDK0X4v92dBcRAWJy8rqz/3JF9i+ve1lbmwL6BEDsTlTB4oeDMaR7tpVN+
 3MfddEyjecH+QAPE+unJBdB8dWDc42tgYHEW+Nb/rtDTLM91k2lsOh+rzmQ0xQ==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763507842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mKb6RTcMEeKZzLhKKcRlRLsud00SCfEGVGBjoCKSZHY=;
 b=BMR5H4uyEIKtBVJln2O0BNeGGcN8ZyKQa1JDMDyKvbaSJNQ7W3vuVQulZIPSO9yn9xKoQf
 EOx3VmoqXg27dZ6flCKkPotUf2QETZ5b+875eBx0aE53P0I8l7jcgbbL4UIKAkwOnkCVYG
 1p9LSxMHHc4sY250wjnfM53e2e1+KyC9cp1VIxvsyI6r/ApxatzUT0o0QkLNcaq4hl+I8I
 kNyHg49Ey/b5o8SVtREnfmt2DYKx7JvcopJmdcdBJdukqgZyFwoEuILRmzqrzh47Fsy0jj
 FsZjHiCtzo/TklbESa+B8PoGUnhb30Crqmz1Tu+T16PO9WLv1aOY6w0v4x+7ng==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] stm32mp: Fix handling of OPTEE in the middle of DRAM
Date: Wed, 19 Nov 2025 00:17:14 +0100
Message-ID: <20251118231717.577932-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 40221247e0e39c6a796
X-MBO-RS-META: 3z4izhirdjyxozs5rk5okmrxr41mxbm4
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

STM32MP13xx may have OPTEE-OS at 0xdd000000 even on systems with 1 GiB
of DRAM at 0xc0000000, which is not the end of DRAM anymore. This puts
the OPTEE-OS in the middle of DRAM. Currently, the code sets RAM top to
0xdd000000 and prevents the DRAM range past OPTEE at 0xe0000000..0xffffffff
from being set as cacheable and from being usable. The code also sets the
area over OPTEE as invalid region in MMU tables, which is not correct.

Adjust the code such, that it only ever sets RAM top just before OPTEE
in case the OPTEE is really at the end of DRAM, mainly to be backward
compatible. Furthermore, adjust the MMU table configuration such, that
the regions over the OPTEE are simply skipped and not reconfigured, and
the regions between end of OPTEE and RAM top are set as cacheable, if
any actually exist.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: u-boot@dh-electronics.com
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/mach-stm32mp/dram_init.c    |  4 +++-
 arch/arm/mach-stm32mp/stm32mp1/cpu.c | 11 ++++++-----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-stm32mp/dram_init.c b/arch/arm/mach-stm32mp/dram_init.c
index 34b958d7afd..e36e42e7c61 100644
--- a/arch/arm/mach-stm32mp/dram_init.c
+++ b/arch/arm/mach-stm32mp/dram_init.c
@@ -65,6 +65,7 @@ int dram_init(void)
 
 phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 {
+	phys_addr_t top = gd->ram_top;
 	phys_size_t size;
 	phys_addr_t reg;
 	u32 optee_start, optee_size;
@@ -86,7 +87,8 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 	/* Reserved memory for OP-TEE at END of DDR for STM32MP1 SoC */
 	if (IS_ENABLED(CONFIG_STM32MP13X) || IS_ENABLED(CONFIG_STM32MP15X)) {
 		if (!optee_get_reserved_memory(&optee_start, &optee_size))
-			reg = ALIGN(optee_start - size, MMU_SECTION_SIZE);
+			if (optee_start + optee_size == top)
+				reg = ALIGN(optee_start - size, MMU_SECTION_SIZE);
 	}
 
 	/* before relocation, mark the U-Boot memory as cacheable by default */
diff --git a/arch/arm/mach-stm32mp/stm32mp1/cpu.c b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
index e0c6f8ba937..252aef1852e 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/cpu.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
@@ -82,11 +82,12 @@ void dram_bank_mmu_setup(int bank)
 	     i++) {
 		addr = i << MMU_SECTION_SHIFT;
 		option = DCACHE_DEFAULT_OPTION;
-		if (use_lmb &&
-		    (lmb_is_reserved_flags(i << MMU_SECTION_SHIFT, LMB_NOMAP) ||
-		     (gd->ram_top && addr >= gd->ram_top))
-		   )
-			option = 0; /* INVALID ENTRY in TLB */
+		if (use_lmb) {
+			if (lmb_is_reserved_flags(i << MMU_SECTION_SHIFT, LMB_NOMAP))
+				continue;
+			if (gd->ram_top && addr >= gd->ram_top)
+				option = 0; /* INVALID ENTRY in TLB */
+		}
 		set_section_dcache(i, option);
 	}
 }
-- 
2.51.0

