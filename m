Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485ACF531CC
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 20:37:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E548184199;
	Mon, 13 Apr 2026 22:36:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Bxw+Y+Nx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C67D4841F2; Mon, 13 Apr 2026 22:36:33 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B909884228
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 22:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HF/te6rQaMQq58S0VJSDSbMtC2QyRKOOiSyc3DHOs8fl7j/JIEgZwhNOVTgM1zSF5YhaYMHZLHhh9MW+MBuY4mZSSTFv4FT1hwmi32XZR9gXXcNhXF3PTgx5siwWODYwi6O+LPZinV9Ut8Lapu5I0/3nWp1njgNGdK73Yz8BuEKVHC0tPiP0VX4FgtmwXId59q1EIv2PSP7CCmU0rJr7U6+dKkQl99g5AvpEDeumKKhf31BZZheyQ2LJFdk/+Vb77Kq7f18hzJCxTc23ioMcsZuWzcqRDIQXQTtJx6OnkfNoi+hBFFDl/8hKzBLKuC4QkiuVMsZZeS2TMSrv9Le1pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3DtG89PlJTJOocC6rChXGvRxNuk13lze5agAMa5jk8=;
 b=C8vUdtFNYSxFopGEabX588SpVPmz8ObETDhBh8kuq7PGKODLX1oy9POjBUBzPABxJi9AmVZnPm9Pm8JBfZ4RVYbeXoHgLO8hPS7tK/M1p34Lhn5HbYP/erLtsdW0n3IzuwX1xD/Mcm320J7O4brxM8fUlPfaJEqgfcZIYRLu7SaLTDYYoi8tLtTRU0/DHeqeFHXiLpiZLmBzb3Z4sYNgHQ2lNHTwflLE9U0S9tVac3HspZpRskhxrJGPP3ttQz0Phl4uMeVRAe9BKb2dK26JUNPL8KrV20o+R6dGwz5gKqOX9Qmy0s3KtlmInuwbQcDI6Y2HdRa147VcfEyopj/yGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3DtG89PlJTJOocC6rChXGvRxNuk13lze5agAMa5jk8=;
 b=Bxw+Y+NxZMW1PdR+KMx5WiyWqsuAljrSDwBIBuTtKWND9Ggg44Lu8fi4AMZJFsjb1se5O7vt/D+JDXc0YH2Ihtge+JhCgNtMiqcOQ9Li/mrQ1q0dpD3NeuBRwG/lRYfeHxY1RVTVKwGvz8MjP9EGbfIChPj4O3uHkgz3e0bs59Y=
Received: from SJ0PR13CA0035.namprd13.prod.outlook.com (2603:10b6:a03:2c2::10)
 by BN0PR10MB4949.namprd10.prod.outlook.com (2603:10b6:408:12b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 20:36:29 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::f9) by SJ0PR13CA0035.outlook.office365.com
 (2603:10b6:a03:2c2::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.47 via Frontend Transport; Mon,
 13 Apr 2026 20:36:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 20:36:27 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Apr
 2026 15:36:12 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Apr
 2026 15:36:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Apr 2026 15:36:12 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63DKaBsg2729634;
 Mon, 13 Apr 2026 15:36:12 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv3 6/6] memory: reserve from start_addr_sp to end_addr_sp
Date: Mon, 13 Apr 2026 15:35:55 -0500
Message-ID: <20260413203555.1990337-7-rs@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413203555.1990337-1-rs@ti.com>
References: <20260413203555.1990337-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|BN0PR10MB4949:EE_
X-MS-Office365-Filtering-Correlation-Id: 4918ed9c-d603-4db5-e45f-08de999c5644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Db3d/MCGZdGqgVeggnVkuIrEnehe99sZmZ41jDo7AS5avENV8I+KqHHIHFJZRQvMXGQC3McHxXOPy01GjN9Xt5t96HoP7aCjIpTHMcyNXgDAm1UWQYygdPBvgZ00DVynSXsoyuUPiqKKY0satjaaBiHE2pHTxtC3pZg4c3Q1Mus0sd6X62VTGQLoyUQ4LCcHXh42WpptrzutVoArczprvTsamjz8z3r0lyB6L0pp48h90wZQ0AbXS2aUBSqzWHlKZ7ed5WVeyd7zTJkgViWbrnm2aXP0OKY154akK8S41kSwmdFgTmMYOFaiHd1VjfF6vnQHWblHxPb11wnOrJN0zCVybazq2DraQJ1ejUjVS6lm8fvfdexEAK2g1AqvT+sFZmIg/h5i6pll47Kfvks/f0Se+S2qPMMkPZHlvozLtgxyT/kQgQ3IlIAJLb++z8FTnAUZnrdJVcy4qGGieMghX3iBcwrLupyddJw3tIK7VAbEuesODNTIDqhZnE8PyuflUPotb0DFOvLSZo+6tRLHm9+sBk0AJT5vA/P5N8vtBpiekzGBMWq46fdn1tHjLZMBDPEkOEnl4Wcrp6w+Hd2ncKij5NHxme6eOv0qbZR+kEd9KyVTNQPTq8XrSjyUqxRp/tr/jWSU0vae0BLK2s+VTP9qF9bp71rB1HLIZ7K6EZQhgEz8PrmV/1ZflCxnMv+WPYMQ4mIc5OUPyr1zPH07lCF6GZFgTuW30DJkrVzWQ+Ph84NIFLPCJqwuyybxPw22rtrlGJv3MruPRJBePVr+Aw==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /BkembGn/V47f/ka58svFlvfll5CjbOA6S6YRUebmoakAeU+X7+kaxbE37ZMir8MXbDYv5aKBJAYDnwLFLMDqLm6x6sfPVgicoycA52HEiD9zxaHhxA96viiZ/fkbx3Ek7sXM6Yqr/9sY3zJbhFQz6BqZ8so+XER7hTMvH41KZBKOZlG3vZ88E3BbrMxDtH1DuNfEAWSCrNYt18TZimSZRPHFpZ5hx4v1m7WmxwW2tnkhIuew2tJ9gv5VVpWyfbnr/8H4mH1t15zRfbozhvQplQzvX966I3YZ6BAgzmV0pf3usIUAVef9I3sujrn8al1puOwTQCvxP1WeuCyaFyhc+HxPd1pgId8uRlzkgvgCB7CNcfXrM1XTZzU4lxGeihHdiEMFGIPAYJoChcJ9mLvHwTyvYMKWrajbHtLCOqcKVah6twvdWQh2FfLHhCzpZJU
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 20:36:27.3105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4918ed9c-d603-4db5-e45f-08de999c5644
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4949
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

From: Randolph Sapp <rs@ti.com>

Add a new global data struct member called end_addr_sp. This stores the
original value of relocaddr, directly from setup_dest_addr. This is
specifically to avoid any adjustments made by other init functions.

Reserve the memory from gd->start_addr_sp - CONFIG_STACK_SIZE to
gd->end_addr_sp instead of gd->ram_top. This allows platform specific
relocation addresses to work without unnecessarily painting over a large
range.

Signed-off-by: Randolph Sapp <rs@ti.com>
---
 common/board_f.c                  |  9 ++++++-
 include/asm-generic/global_data.h |  6 +++++
 lib/efi_loader/efi_memory.c       |  4 +--
 lib/lmb.c                         | 41 ++++++-------------------------
 4 files changed, 23 insertions(+), 37 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index 11ad5779115..ebf2365210f 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -330,6 +330,8 @@ __weak int arch_setup_dest_addr(void)
 
 static int setup_dest_addr(void)
 {
+	int ret;
+
 	debug("Monitor len: %08x\n", gd->mon_len);
 	/*
 	 * Ram is setup, size stored in gd !!
@@ -356,7 +358,12 @@ static int setup_dest_addr(void)
 	gd->relocaddr = gd->ram_top;
 	debug("Ram top: %08llX\n", (unsigned long long)gd->ram_top);
 
-	return arch_setup_dest_addr();
+	ret = arch_setup_dest_addr();
+	if (ret != 0)
+		return ret;
+
+	gd->end_addr_sp = gd->relocaddr;
+	return ret;
 }
 
 #ifdef CFG_PRAM
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 745d2c3a966..2f3ef26a17c 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -115,6 +115,12 @@ struct global_data {
 	 * @start_addr_sp: initial stack pointer address
 	 */
 	unsigned long start_addr_sp;
+	/**
+	 * @end_addr_sp: the end of memory currently in use by uboot,
+	 *               should be the original value of the relocaddr before
+	 *               any other allocations shift it
+	 */
+	unsigned long end_addr_sp;
 	/**
 	 * @reloc_off: relocation offset
 	 */
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index b3b292ebf56..bd0d875a8cd 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -870,8 +870,8 @@ static void add_u_boot_and_runtime(void)
 	/* Add U-Boot */
 	uboot_start = ((uintptr_t)map_sysmem(gd->start_addr_sp, 0) -
 		       uboot_stack_size) & ~EFI_PAGE_MASK;
-	uboot_pages = ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
-		       uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
+	uboot_pages = ((gd->end_addr_sp - uboot_start) + EFI_PAGE_MASK) >>
+		      EFI_PAGE_SHIFT;
 	efi_update_memory_map(uboot_start, uboot_pages, EFI_BOOT_SERVICES_CODE,
 			      false, false);
 #if defined(__aarch64__)
diff --git a/lib/lmb.c b/lib/lmb.c
index 7ecc548d831..da61b005154 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -534,46 +534,19 @@ static long lmb_reserve(phys_addr_t base, phys_size_t size, u32 flags)
 
 static void lmb_reserve_uboot_region(void)
 {
-	int bank;
-	ulong end, bank_end;
+	ulong size;
 	phys_addr_t rsv_start;
-	ulong pram = 0;
 
 	rsv_start = gd->start_addr_sp - CONFIG_STACK_SIZE;
-	end = gd->ram_top;
+	size = gd->end_addr_sp - rsv_start;
 
-	/*
-	 * Reserve memory from aligned address below the bottom of U-Boot stack
-	 * until end of RAM area to prevent LMB from overwriting that memory.
-	 */
-	debug("## Current stack ends at 0x%08lx ", (ulong)rsv_start);
-
-#ifdef CFG_PRAM
-	pram = env_get_ulong("pram", 10, CFG_PRAM);
-	pram = pram << 10; /* size is in kB */
-#endif
+	debug("## Current stack ends at 0x%08lx\n", (ulong)rsv_start);
 
-	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
-		if (!gd->bd->bi_dram[bank].size ||
-		    rsv_start < gd->bd->bi_dram[bank].start)
-			continue;
-		/* Watch out for RAM at end of address space! */
-		bank_end = gd->bd->bi_dram[bank].start +
-			gd->bd->bi_dram[bank].size - 1;
-		if (rsv_start > bank_end)
-			continue;
-		if (bank_end > end)
-			bank_end = end - 1;
-
-		lmb_reserve(rsv_start, bank_end - rsv_start - pram + 1,
+	if (gd->flags & GD_FLG_SKIP_RELOC)
+		lmb_reserve((phys_addr_t)(uintptr_t)_start, gd->mon_len,
 			    LMB_NOOVERWRITE);
-
-		if (gd->flags & GD_FLG_SKIP_RELOC)
-			lmb_reserve((phys_addr_t)(uintptr_t)_start,
-				    gd->mon_len, LMB_NOOVERWRITE);
-
-		break;
-	}
+	else
+		lmb_reserve(rsv_start, size, LMB_NOOVERWRITE);
 }
 
 static void lmb_reserve_common(void *fdt_blob)
-- 
2.53.0

