Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02F7CD4855
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 11:03:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23DD380398;
	Tue, 12 May 2026 13:03:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="f2pUEui3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D56F5803C6; Tue, 12 May 2026 13:03:33 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BBD4801A9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 13:03:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUgFYe7rQKJHkEE0AMB6p0niGRKB/KtoX7dvtbw9SVRRnGwlwPL5FepkiOh4/rsENDmQpJdVGmyE9/znFnUOxn04W+1G5M6wYvtTUdfOUtL67zA/0RiJIBT5NbbYgwlX7G3VkKBAgcLCFmhaRoBY8zQPcPLt+nUwFG/iHHgTbkGcs0Lc6z7b4mcovXoBMfR9ApFH04KV2ZlgRcpWFOByEZk23vJB+zdAwI546rX6UzR4oC27B6Cji9EgBqk0GmRr4Zp3viBdB2y5csPNK0/CcurDPcRKQM9pCT/BirYTNuDl2LS6YR6aEBOCNsDyqwhDsZc3uZUvlxBcTf5VAVzO7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XRuhByGAnWpo0BDSbOThZFWMi8mXjbcF7bxVuwfi5M=;
 b=ZusPU+tJhLXhm2eABxsUZC6SN6b1IP1dSWJFuEbQiiv8SIYS5dIWjR7YM/cUEbI8xS7aTwG2eMreWpX4H097d+2sCdWKN+gnnN+SLD/AP714DsMtqS+x3A3tk8Tw/LZHil5rLkMLqOtmzL6QTwM2U0RoVb8iSfCDkIxpr+TRlJpMjdmjHp1nhANsUj+VcWeBWLLOtZQ7n9AT3wqhlQOmY2MKmFdjwtvSMKLyBA8iOekTvjEGq06xmhPPLK1WNPkduuDiBVuTbPNL5YZTkm5RXexMXGTCdzLMeopz3JkVU8LOvOkZf+GE4SwIGU32cYJJ1Y4yhG7Um6g69W747Sfq8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=foss.st.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XRuhByGAnWpo0BDSbOThZFWMi8mXjbcF7bxVuwfi5M=;
 b=f2pUEui3a6MQts7JCEVIYdFeiWzyk0liABCCwCnjaL/X1ChvTWhP3N6JP1K6C3qtCJf10+/UkQ7W2fBkrzW4jX6O16G+hraRKSkP1q8SLG7HwwmnENPdPtfi+89OwJkQEBKH82WUQWKhTuDJawMGD6oN07eywSgeM7NpyM7eDQs=
Received: from BLAPR03CA0115.namprd03.prod.outlook.com (2603:10b6:208:32a::30)
 by IA1PR10MB6807.namprd10.prod.outlook.com (2603:10b6:208:429::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 11:03:24 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:32a:cafe::cf) by BLAPR03CA0115.outlook.office365.com
 (2603:10b6:208:32a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Tue,
 12 May 2026 11:03:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 11:03:23 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 06:03:23 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 06:03:23 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 12 May 2026 06:03:22 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.72.233])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64CB3Lmd1651318;
 Tue, 12 May 2026 06:03:22 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Tue, 12 May 2026 16:33:13 +0530
Subject: [PATCH master] mach-k3: enable mmu after reserved memory is unmapped
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260512-am62_firewall_exception_fix-v1-1-4b274718bdac@ti.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCQAwAv1JydmGb0hX9ikiJMepKW0uyaqH07
 0Y9zsDMAiaaxWBfLaDyypYfo0O9qYBvNF4l5LMzYMQU2xoDDQm7S1Z5U993MrNMxRtXc8BITdM
 y0zbtwA+Tiuvf/QADWRGF49/b83QXLt81rOsHdtn234cAAAA=
X-Change-ID: 20260512-am62_firewall_exception_fix-20a335cca769
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Dhruva Gole <d-gole@ti.com>, Mark Kettenis
 <kettenis@openbsd.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
 "Moteen Shah" <m-shah@ti.com>, Beleswar Padhi <b-padhi@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Chintan Vankar <c-vankar@ti.com>, Anshul Dalal
 <anshuld@ti.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778583801; l=4127;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=9vurPclO4upDaMpuyoZ1a/PWs2oe+W5Ihewi7gN8Ibc=;
 b=7Cx5NkOWs+QkrInSLWhHQLIvo/gsiKgN+IIcbtcO8oTABYXU8HXF6MKFiUsszJLehLabu4A2T
 qW8VMqd329mD7ubynQMJqX3yagefv190gsnSJ9w8ZDARLbC8GMqCzJ6
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|IA1PR10MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: c7f24dc7-e694-4925-7b22-08deb0161608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: nB0zeIlWVutwiYu0PkzhVJfH1pvcrn+LQG2WUY1fx75X5OuSr3hLw9pO3hItjdBH2/f/u1itHKnAgqfeTNcdgM9SKVJFBbpPfp+RHpd2cl6bsXe4TBh39frQ/BWXyDN/IZgB19+jmtx/by9DRi9+ccFhB6htWySRfUgwPCG5tciWntlnNi25zDM+pk+BnF0MJRVoh+Xw4Yv9SudNc/3yFKWPyepQszHz26vpbVfA3fo/1PcP5fdUlpyeOjTr1QLnVbkYZfvXjf4lCzuoAJVo8ZiIvc9I+4mMTUsxyD6+axQ5Tioqlqjz510AAVty5O35oZm1atF+IXcgCJRuCC3p1OwxLlGMfcL/oScBR0DteeNs6K4mZJTt51wmYituLvTzj61ab0htM43u/75GlEFtCOha+VLx742loxdKCGVW2jfprbso4FDY2elnuPU5TG+iiDiUMjOF0+z3ccljn+9qWXkX1vvSuBBHm8wTe7Tra+cCun3vMrOwWYWC4OLYJvvQb71a2XS2vQVutd/TGwbAxGhEm6KC71EKy0htRBCZRsugOQQM51zM9VBaed5Xn1xXHRqeHLRO8yk1gy88ArXeYb+VF+FKM6MkXDZIk11ECdx8PZT56VGLuDsVZl4Hfm+rw+Ie/ugkG3x/S8zWx9jiLcsTQoiiHVZ9K+8yo3dzdwl85I43R2UT5bTrsmfnDeChhJHroSvWTDv2aU+Cg3Av6bxhO5GRpoBwVIOKhuNfO5c=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F7g2uPtn+I21dsJ4OdKqKslTz65baSLqI38I6BsMRxiEx7ref/07xnBezgUqUldbeFVmTxInF44KAdicgm0J4qN5PCW8/8uh1b/J0JVtBCk0OoQj8Co9uCFYaJrlPvf9OGoM436I/xpSNnkWS9It/LLKlgjAF9verctAQW7u5XiP89vOqIGeBoZsw78SnWsl6RrLAvEFU4jazAt7kr5LGXS78xlpm6imc65tOU38mJgzLmQ3QP3CR8fBaESoAc6jIow7OSGMROLdiiIRAGlO3rYeC5P7O+J1w5thQ4jaGXVUGEwitOTvk7aP0tHONW+lNvFs5VDLpRVyUSVEMGrWA1iBrdVKL5CYcsWvK3Au4mvTd+6/a07/kNWha7Lc/1L0YddrD79ngFq/xgYsnGC//6I/R9HVWzkOGnZuTRm++UQuKAhqUyvA6sSijRXnd6Ed
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 11:03:23.7476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f24dc7-e694-4925-7b22-08deb0161608
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6807
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

Currently the sequence to enable caches for the A53/A72 core on K3
devices looks as follows:

 1. Map entire DDR banks
 2. Setup page tables and enable MMU (done by mmu_setup)
 3. Unmap reserved-memory regions
 4. Enable caches

However there is a brief period of execution between #2 and #3 where the
core can issue speculative accesses to the entire DDR space (including
the reserved-memory regions) despite the caches being disabled.

A firewall exception is triggered whenever such speculative access is
made to secure DDR region of TFA or OP-TEE. This patch fixes the issue
by re-ordering the sequence as follows:

 1. Map entire DDR banks
 2. Setup page tables
 3. Unmap reserved-memory regions
 4. Enable MMU
 5. Enable caches

Fixes: f1c694b8fdde ("mach-k3: map all banks using mem_map_from_dram_banks")
Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
For testing, I had used an AM62p with the following diff to enable
logging from TIFS:

  --- a/board/ti/am62px/board-cfg.yaml
  +++ b/board/ti/am62px/board-cfg.yaml
  @@ -33,5 +33,5 @@ board-cfg:
           subhdr:
               magic: 0x020C
               size: 8
  -        trace_dst_enables: 0x00
  -        trace_src_enables: 0x00
  +        trace_dst_enables: 0xd
  +        trace_src_enables: 0x3f

Without this patch an exception[1] similar to the following is observed
at A53 SPL stage:

  FWL Bit  0x1
  Exception addr  0x45B08000
  FWL Exception  0x1000100
   0x60000
   0x80002880
   0x0
   0x141201
   0x40

[1]: https://software-dl.ti.com/tisci/esd/latest/6_topic_user_guides/firewall_faq.html#how-do-i-debug-firewall-issues
---
 arch/arm/cpu/armv8/cache_v8.c    |  2 +-
 arch/arm/include/asm/armv8/mmu.h |  1 +
 arch/arm/mach-k3/common.c        | 10 +++++++++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 39479df7b21..169e68627e1 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -777,7 +777,7 @@ void setup_pgtables(void)
 		add_map(&mem_map[i]);
 }
 
-static void setup_all_pgtables(void)
+void setup_all_pgtables(void)
 {
 	u64 tlb_addr = gd->arch.tlb_addr;
 	u64 tlb_size = gd->arch.tlb_size;
diff --git a/arch/arm/include/asm/armv8/mmu.h b/arch/arm/include/asm/armv8/mmu.h
index 8aa5f9721c4..969f1745445 100644
--- a/arch/arm/include/asm/armv8/mmu.h
+++ b/arch/arm/include/asm/armv8/mmu.h
@@ -197,6 +197,7 @@ struct mm_region {
 /* Used as the memory map for MMU configuration by mmu_setup */
 extern struct mm_region *mem_map;
 void setup_pgtables(void);
+void setup_all_pgtables(void);
 
 /**
  * mem_map_from_dram_banks() - Populate mem_map with entries corresponding to
diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index b0a75988714..a910c6e3725 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -265,8 +265,10 @@ void board_prep_linux(struct bootm_headers *images)
 void enable_caches(void)
 {
 	void *fdt = (void *)gd->fdt_blob;
+	int el = current_el();
 	int ret;
 
+	/* Map all DDR banks as Normal memory */
 	ret = mem_map_from_dram_banks(K3_MEM_MAP_FIRST_BANK_IDX, K3_MEM_MAP_LEN,
 				     PTE_BLOCK_MEMTYPE(MT_NORMAL) |
 					     PTE_BLOCK_INNER_SHARE);
@@ -278,8 +280,11 @@ void enable_caches(void)
 		printf("%s: Failed to perform reserved-memory fixups (%s)\n",
 		       __func__, fdt_strerror(ret));
 
-	mmu_setup();
+	setup_all_pgtables();
+	set_ttbr_tcr_mair(el, gd->arch.tlb_addr, get_tcr(NULL, NULL),
+			  MEMORY_ATTRIBUTES);
 
+	/* Unmap reserved memory regions */
 	if (CONFIG_K3_ATF_LOAD_ADDR >= CFG_SYS_SDRAM_BASE) {
 		ret = mmu_unmap_reserved_mem("tfa", true);
 		if (ret)
@@ -294,6 +299,9 @@ void enable_caches(void)
 			       __func__, ret);
 	}
 
+	/* enable the mmu */
+	set_sctlr(get_sctlr() | CR_M);
+
 	icache_enable();
 	dcache_enable();
 }

---
base-commit: 525ef034e5bed619c0f822da5373ed1fdadc8501
change-id: 20260512-am62_firewall_exception_fix-20a335cca769

Best regards,
--  
Anshul Dalal <anshuld@ti.com>

