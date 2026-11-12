Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83247606A898
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=utPJ4eGl;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AHYZEpq5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 57B37409D3;
	Thu, 12 Nov 2026 13:21:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0hRMHlrcJ45J; Thu, 12 Nov 2026 13:21:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6F71040D77
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794489676;
	b=AtIXlHBg9haJG40MPwxm9FeQe/FyctIst5JuPdJzyuTTBhIanLGrCpZbEUFlto4GkqPl
	 e/pPjAdo7OzoUA75QNifM6Wags3r9GKYOm1OCPzbErGxz+QOr4lWZLI9JdkwR1BlvR9ns
	 3LOh0N9sJ6AtIkxGIt6UD/XyhkthUgKTbwbxiohm0H0l/sgnAHknFW6RMQ/8pGSd57cRG
	 R6slptcSumf39AR3r+28vndSUKKAS7SP6RxSmD1qVIo+1z4kdABcHa5Tl1KZ/N0hAIwrk
	 XFkA/QzJ2uvtEdC9GtjoCrHLX1y8pGrZFyGk7Xs1DvAOo4PxPx4d6Ep6YXOenCsCrRA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794489676;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6YCSRQA8bsQwtdEgBhlKpMrkToJiKD4Bgh/C/OAsDCI=;
	b=jKXaooYyQce8Fww3mvbimlM90YSzF1vePyEl1RneSnr3A3Sso6aP8lPxqE7jdcCn6cL8
	 4cU4orSqFebCll7ADrN2CBZ4AMBOr9ZEtrcqhz2JzN2kMKsX3kBcQmWKNdr8I4TgPluNJ
	 k1Poj80kyVr6lkZ9Ih4qNAuRS+HaKVQPW2PhiYWyzlvKRKz3SSuDBdU3Nl2mnCRZq+OwP
	 /BLuKZ6pMxfDx7AX9XQKao8iLTZHb33sKXVVYBSt+W37d7uxdy/OIToKSA2YZoNFqJGaG
	 RAwg8aDFuKpDYuw3wFqfODQIad8wJUchSlynzjjYN5KCdKEg1tczF96hcPwWZ5JLArA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794489676;
	bh=6YCSRQA8bsQwtdEgBhlKpMrkToJiKD4Bgh/C/OAsDCI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=utPJ4eGluRfnQZoECpm8oc4gc3ainUyhelwsaGbUFwBi3Nty7aJF2gs8pHej7KYWa
	 K4gOy6umDDQTZp/WdNF9NMJvQtT2+y0vGL/wD4GaSFjOdYi2vIx19TnvBvoBCMmL3c
	 f5pZC22yCGDMJg3BEAyzPDcz8+db4sts530UDw4MsStBAVIlnkGxx47fCHRLxTHCbL
	 AAgRmNl3jlMWZNhxTewY0rZH767MZ/lodWA6emONpl27uR8SDB/ogT6Zs1p57Qfp4R
	 xix19XCIY5j3y9NIFPb7lcewCScCUGEKGHIXbPqPx+v/SGruJMltPrkEy8oZ2p1o8p
	 slQrGzrvAHVzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F71040D77;
	Thu, 12 Nov 2026 13:21:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E1817235
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 12:26:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C6F7960745
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 12:26:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w8lsbBNgmbco for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 12:26:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DFAC760729
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=kaloz@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=AHYZEpq5
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DFAC760729
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 12:26:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DC2396060D;
 Thu, 12 Nov 2026 12:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6718F1F00A05;
 Thu, 12 Nov 2026 12:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794486359;
 bh=6YCSRQA8bsQwtdEgBhlKpMrkToJiKD4Bgh/C/OAsDCI=;
 h=From:To:Cc:Subject:Date;
 b=AHYZEpq5xWlp/6f+/WH9OAV5tBZT2MS+JwTM/yBu8y5Kyn951h8RWZKAbznbyfeB6
 GajkSmdvNwgJragC8job50/debKi87dqlA9q7UczPIfYG3ndL1OHzCUFf+hvk4kMKK
 VcE7JrwDWx5NTu2eIRKD1SoCWYBqpkG15cfzbvlARS9bhi78abd1SpRnm6GoC6aptk
 iet07/XeQ+JwHgQRbY7DMt4SWPaJS0dAbH1A0zVI3OsnCdAE/M1iuWAZ4z8liZuqVr
 kerV4W5g94GU+oQIFWudGT5/+Rf9Xybiy5M7DMQcdnvaY8dgjt+/h5ZeIDPW41mZoo
 e+XgpmNMPdmvg==
From: Imre Kaloz <kaloz@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] arm: mvebu: armada8k: make DRAM bank 0 above 2 GiB usable
Date: Thu, 12 Nov 2026 13:24:36 +0100
Message-ID: <20261112122436.12314-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Nov 2026 13:21:07 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

LMB_LIMIT_DMA_BELOW_RAM_TOP, now enabled for mvebu, reserves DRAM above
gd->ram_top, which is capped at 2 GiB.  Bank 0 can reach 3 GiB, so bootm
refuses kernels loaded at 0x80080000, the ONIE default on arm64.

Map bank 0 up to its end and reserve only DRAM from 4 GiB up, which stays
unmapped.

Fixes: f9c2898c9b35 ("lmb: enable LMB_LIMIT_DMA_BELOW_RAM_TOP for ARCH_MVEBU")
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 arch/arm/mach-mvebu/arm64-common.c     |  2 +-
 arch/arm/mach-mvebu/armada8k/cpu.c     | 48 ++++++++++++--------------
 arch/arm/mach-mvebu/armada8k/dram.c    |  2 ++
 arch/arm/mach-mvebu/include/mach/cpu.h |  1 +
 4 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-mvebu/arm64-common.c b/arch/arm/mach-mvebu/arm64-common.c
index 63a12f7d77..81b19b0c80 100644
--- a/arch/arm/mach-mvebu/arm64-common.c
+++ b/arch/arm/mach-mvebu/arm64-common.c
@@ -25,7 +25,7 @@ DECLARE_GLOBAL_DATA_PTR;
  * Not all memory is mapped in the MMU. So we need to restrict the
  * memory size so that U-Boot does not try to access it. Also, the
  * internal registers are located at 0xf000.0000 - 0xffff.ffff.
- * Currently only 2GiB are mapped for system memory. This is what
+ * U-Boot restricts itself to the first 2GiB of system memory. This is what
  * we pass to the U-Boot subsystem here.
  */
 #define USABLE_RAM_SIZE		0x80000000ULL
diff --git a/arch/arm/mach-mvebu/armada8k/cpu.c b/arch/arm/mach-mvebu/armada8k/cpu.c
index 666be973a7..c8d753998c 100644
--- a/arch/arm/mach-mvebu/armada8k/cpu.c
+++ b/arch/arm/mach-mvebu/armada8k/cpu.c
@@ -43,7 +43,7 @@ static struct mm_region mvebu_mem_map[] = {
 	},
 	/* ATF and TEE region 0x4000000-0x5400000 not mapped */
 	{
-		/* RAM 66MB-2GB */
+		/* RAM from ATF_REGION_END, 2GB or up to the end of bank 0 */
 		.phys = ATF_REGION_END,
 		.virt = ATF_REGION_END,
 		.size = SZ_2G,
@@ -66,6 +66,20 @@ static struct mm_region mvebu_mem_map[] = {
 
 struct mm_region *mem_map = mvebu_mem_map;
 
+/**
+ * a8k_mem_map_bank0() - extend the RAM entry to the end of DRAM bank 0
+ *
+ * Bank 0 ends at MMIO_REGS_PHY_BASE at most, past the default 2 GiB of the
+ * entry above the ATF and TEE region.  Call before the page table is sized.
+ */
+void a8k_mem_map_bank0(void)
+{
+	phys_addr_t bank0_end = gd->dram[0].start + gd->dram[0].size;
+
+	if (bank0_end > ATF_REGION_END + SZ_2G)
+		mvebu_mem_map[1].size = bank0_end - ATF_REGION_END;
+}
+
 #if CONFIG_IS_ENABLED(LMB_ARCH_MEM_MAP)
 /**
  * mvebu_lmb_reserve() - mark a region as present but not allocatable
@@ -82,27 +96,19 @@ static void mvebu_lmb_reserve(phys_addr_t base, phys_size_t size)
 }
 
 /**
- * mvebu_lmb_add_bank() - add one memory range, honouring ram_top
+ * mvebu_lmb_add_bank() - add one memory range, reserving it from 4 GiB up
  * @base:	start of the range
  * @size:	size of the range
- * @ram_top:	highest address U-Boot may allocate from
  *
- * The reservation above @ram_top mirrors the generic lmb_add_memory(), which
- * this hook replaces.
+ * Reserve from 4 GiB, not from gd->ram_top (2 GiB) as lmb_add_memory() does:
+ * every bank 0 range passed here is mapped and below 4 GiB; bank 1 is neither.
  */
-static void mvebu_lmb_add_bank(phys_addr_t base, phys_size_t size, u64 ram_top)
+static void mvebu_lmb_add_bank(phys_addr_t base, phys_size_t size)
 {
-	phys_addr_t bank_end = base + size;
-
 	lmb_add(base, size);
 
-	if (!IS_ENABLED(CONFIG_LMB_LIMIT_DMA_BELOW_RAM_TOP))
-		return;
-
-	if (base >= ram_top)
+	if (IS_ENABLED(CONFIG_LMB_LIMIT_DMA_BELOW_RAM_TOP) && base >= SZ_4G)
 		mvebu_lmb_reserve(base, size);
-	else if (bank_end > ram_top)
-		mvebu_lmb_reserve(ram_top, bank_end - ram_top);
 }
 
 /**
@@ -117,13 +123,8 @@ static void mvebu_lmb_add_bank(phys_addr_t base, phys_size_t size, u64 ram_top)
 void lmb_arch_add_memory(void)
 {
 	phys_addr_t bank_start, bank_end;
-	u64 ram_top = gd->ram_top;
 	int i;
 
-	/* Assume a 4GB ram_top if not defined */
-	if (!ram_top)
-		ram_top = 0x100000000ULL;
-
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
 		if (!gd->dram[i].size)
 			continue;
@@ -133,19 +134,16 @@ void lmb_arch_add_memory(void)
 
 		if (bank_end <= ATF_REGION_START ||
 		    bank_start >= ATF_REGION_END) {
-			mvebu_lmb_add_bank(bank_start, gd->dram[i].size,
-					   ram_top);
+			mvebu_lmb_add_bank(bank_start, gd->dram[i].size);
 			continue;
 		}
 
 		if (bank_start < ATF_REGION_START)
 			mvebu_lmb_add_bank(bank_start,
-					   ATF_REGION_START - bank_start,
-					   ram_top);
+					   ATF_REGION_START - bank_start);
 		if (bank_end > ATF_REGION_END)
 			mvebu_lmb_add_bank(ATF_REGION_END,
-					   bank_end - ATF_REGION_END,
-					   ram_top);
+					   bank_end - ATF_REGION_END);
 	}
 }
 #endif
diff --git a/arch/arm/mach-mvebu/armada8k/dram.c b/arch/arm/mach-mvebu/armada8k/dram.c
index af37dfa225..f5f3895d67 100644
--- a/arch/arm/mach-mvebu/armada8k/dram.c
+++ b/arch/arm/mach-mvebu/armada8k/dram.c
@@ -41,10 +41,12 @@ int a8k_dram_init_banksize(void)
 	gd->dram[0].start = CFG_SYS_SDRAM_BASE;
 	if (gd->ram_size <= max_bank0_size) {
 		gd->dram[0].size = gd->ram_size;
+		a8k_mem_map_bank0();
 		return 0;
 	}
 
 	gd->dram[0].size = max_bank0_size;
+	a8k_mem_map_bank0();
 	if (CONFIG_NR_DRAM_BANKS > 1) {
 		gd->dram[1].start = SZ_4G;
 		gd->dram[1].size = gd->ram_size - max_bank0_size;
diff --git a/arch/arm/mach-mvebu/include/mach/cpu.h b/arch/arm/mach-mvebu/include/mach/cpu.h
index 37a0050121..3585cb2ba3 100644
--- a/arch/arm/mach-mvebu/include/mach/cpu.h
+++ b/arch/arm/mach-mvebu/include/mach/cpu.h
@@ -188,6 +188,7 @@ static inline void mv_rtc_config(void) {}
 /* A8K dram functions */
 u64 a8k_dram_scan_ap_sz(void);
 int a8k_dram_init_banksize(void);
+void a8k_mem_map_bank0(void);
 
 /* A3700 dram functions */
 int a3700_dram_init(void);
-- 
2.47.3

