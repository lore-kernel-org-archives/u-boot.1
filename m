Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECEFC3ABC3
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 17:22:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA0D482A4D;
	Mon, 12 May 2025 19:22:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XO52Zbc1";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iw48Qphq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AF95829CD; Mon, 12 May 2025 19:22:23 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FE7882A4D
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 19:22:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Zx5yN1CTfz9stq;
 Mon, 12 May 2025 19:22:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1747070540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m4kZ0qrokejhOL6UjdNJuLAqzDXaaJnV7J7MVFW6APU=;
 b=XO52Zbc1SHxn86MH6zfrK0u59Y2no/sBvH0J21C9OPG5t9NFdHzA/icWoWlrOj/F9aSuNG
 JSuLAwvRE+COpi66Ran7xWeQ0JbgoQrAMIeCSgUxRuh+PwQMOR6l75vaZ+kncIdO7XMN/e
 mMiGSU7wMBCv/AD7Y0zyeO95o9IrLRL/ZlOVmzIaen4OcpW1eS5yYNhH1Rs1v3peM4zuHb
 PbRYZdj5iBLl9P+2jDq0nVghYaFCHNZDkwG9XMq+xUhvCw++VWBCRAzytosIGS5kNjKsZS
 EzPkmNTt+0N+4ZhHRaAgx4+Ew9bU5tpqLptlRaxWrN6skciOYyy/LEcXCmbtwQ==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1747070538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m4kZ0qrokejhOL6UjdNJuLAqzDXaaJnV7J7MVFW6APU=;
 b=iw48QphqR+WglhaQ9gvX4YGjcL/+7bMb5skPpLqNAVN1neeeecJCxNUpIG6GTSYQe0iRCv
 m0b9sgNJXTf9xGhfrI3CQ/ifAPrwBGVsys6ZK6VpWWkFhtPss4iJM9K2/pynBrUBPDmUmV
 z4+r+ihOb6cFopwcxCHR8d7KO1S6lCOoZIe6cQakON4iZNjGrRPqPUKz5KqUjVsyPsR05L
 pw6evJvrfjPcCxFJ22rDWZMTPqrSMnjb5K8qG/B39jvsQkRTBtTZG3ebRuMtqVYRzPVzTW
 V4gD3lbS0YLh8LN64UaL2cHyP/CXd4TURFoH+44Afi43pytbWsVmoL+EL9AUqg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Cheick Traore <cheick.traore@foss.st.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Lionel Debieve <lionel.debieve@foss.st.com>,
 Pascal Zimmermann <pzimmermann@dh-electronics.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 03/10] ARM: stm32: Limit early cache enablement in SPL to
 STM32MP15xx
Date: Mon, 12 May 2025 19:21:30 +0200
Message-ID: <20250512172149.150214-4-marek.vasut@mailbox.org>
In-Reply-To: <20250512172149.150214-1-marek.vasut@mailbox.org>
References: <20250512172149.150214-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2d17c81c8ac6c85ab4c
X-MBO-RS-META: wmdkcry3rq3tzrfe7j4tz38c66xgu1mu
X-Rspamd-Queue-Id: 4Zx5yN1CTfz9stq
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

The STM32MP13xx SRAM size is half that the SRAM size on STM32MP15xx,
disable early dcache start on STM32MP13xx as the TLB itself takes
about a quarter of the SPL size. The dcache will be enabled later,
once DRAM is available and TLB can be placed in DRAM.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Cheick Traore <cheick.traore@foss.st.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Lionel Debieve <lionel.debieve@foss.st.com>
Cc: Pascal Zimmermann <pzimmermann@dh-electronics.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/mach-stm32mp/stm32mp1/cpu.c | 9 ++++++---
 arch/arm/mach-stm32mp/stm32mp1/spl.c | 3 ++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-stm32mp/stm32mp1/cpu.c b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
index 9ab5a3ede52..1ae82489a4b 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/cpu.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
@@ -28,7 +28,9 @@
  * early TLB into the .data section so that it not get cleared
  * with 16kB allignment (see TTBR0_BASE_ADDR_MASK)
  */
+#if (!IS_ENABLED(CONFIG_XPL_BUILD) || !IS_ENABLED(CONFIG_STM32MP13X))
 u8 early_tlb[PGTABLE_SIZE] __section(".data") __aligned(0x4000);
+#endif
 
 u32 get_bootmode(void)
 {
@@ -95,18 +97,19 @@ void dram_bank_mmu_setup(int bank)
  */
 static void early_enable_caches(void)
 {
+#if (!IS_ENABLED(CONFIG_XPL_BUILD) || !IS_ENABLED(CONFIG_STM32MP13X))
 	/* I-cache is already enabled in start.S: cpu_init_cp15 */
-
 	if (CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
 		return;
 
 #if !(CONFIG_IS_ENABLED(SYS_ICACHE_OFF) && CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
-		gd->arch.tlb_size = PGTABLE_SIZE;
-		gd->arch.tlb_addr = (unsigned long)&early_tlb;
+	gd->arch.tlb_size = PGTABLE_SIZE;
+	gd->arch.tlb_addr = (unsigned long)&early_tlb;
 #endif
 
 	/* enable MMU (default configuration) */
 	dcache_enable();
+#endif
 }
 
 /*
diff --git a/arch/arm/mach-stm32mp/stm32mp1/spl.c b/arch/arm/mach-stm32mp/stm32mp1/spl.c
index 9c4fafbf478..e63bdaaf42f 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/spl.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/spl.c
@@ -220,10 +220,11 @@ void board_init_f(ulong dummy)
 	 * activate cache on DDR only when DDR is fully initialized
 	 * to avoid speculative access and issue in get_ram_size()
 	 */
-	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF) && !IS_ENABLED(CONFIG_STM32MP13X)) {
 		mmu_set_region_dcache_behaviour(STM32_DDR_BASE,
 						CONFIG_DDR_CACHEABLE_SIZE,
 						DCACHE_DEFAULT_OPTION);
+	}
 }
 
 void spl_board_prepare_for_boot(void)
-- 
2.47.2

