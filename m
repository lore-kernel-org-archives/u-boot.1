Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5293CD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 11:54:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7E9583EF9;
	Mon, 18 May 2026 13:54:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="agVoQJSb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68B8484664; Mon, 18 May 2026 13:54:19 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A53383EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 13:54:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jt5CrLrzBqXnX/x7ODLP33+R5NuLbvmLZKdoFYqx014mcylwDNVb9JMoJ1VGVsOQKe0/rS/9tKNMbqolT56CVQiJhixAznMTKfw8LBK1aZyj+N+N7/LpxGpVEdg/meU2fF6wAmoatzPRSsFbUSAR9V9kHeMawzdMZ2/qKSnh9bHFyBLuN8yzaxtQs/8Asw/lbxM9BporEd52Nbpd/I60R9Gw1RFFw8Sk/zGvZg0Xys1rv3fVfqxRXRz2ar1Vi30y5liHyeDoZ6SRsoekhDA9XsQcxLJ6NV2vboDWcW3HG0Wvp27R6at/yxqGUSjbzumDNA0bN3EuosYlgjbfcEBzMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKSwu92aovn3PSjMfaiZ+e8g+qJrr7AT/J9i4PY5LCY=;
 b=yK0xkuTs5WsoGrNqg9eIpvxF5ZcncGJNpx+Xd7W/7SZwvDeeTrZLVcZQsqfmn7LRHFB5lvF9iF/P0jbY6EuVCWtmjATNFAmKa05D/lsgYfZMKpEauMuXh2HuKI5R5SNmiv0DNlg23VMDZdCxPF6QVYfwAahT1Q2P6hou3VAgIB7k+P2xWsHYKt5wP/QckEWBzcoMZEfNzGTa88QCgOtOKDw+C5cQFikXLEu0+/mXjdJbQj/k2EO/HShmyRoizDaqcoW5D/v3Lt9MIBfem503qAmpiRhA1QTZFjyPrNr1dmsDCaJglThkMLCa9vOYM0F6ZOl4LnOQXkIoepDOYziM8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKSwu92aovn3PSjMfaiZ+e8g+qJrr7AT/J9i4PY5LCY=;
 b=agVoQJSbrWSjPdFm799NmETUpZfgssb80Ha2pmGtvJJQKEA0RWG5ru2FzbDvqYXE8ZTUpfkt9y2r/dTAMHpqAZ5drxl1JF1tRmVsoBGVL89odn872+VcP3/HeHwYMaxcbW9b6jf/KKYO57bQY+OItjkLV6Rhj4ehhbvMibzQ9WM=
Received: from CYZPR12CA0019.namprd12.prod.outlook.com (2603:10b6:930:8b::27)
 by MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 11:54:13 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:930:8b:cafe::89) by CYZPR12CA0019.outlook.office365.com
 (2603:10b6:930:8b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Mon, 18
 May 2026 11:54:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 11:54:12 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 18 May
 2026 06:54:11 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 18 May
 2026 06:54:11 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 18 May 2026 06:54:10 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.72.233])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64IBs93B1269235;
 Mon, 18 May 2026 06:54:10 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Mon, 18 May 2026 17:22:49 +0530
Subject: [PATCH master v2 1/2] arm: armv8: mmu: move mmu enablement out of
 mmu_setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260518-am62_firewall_exception_fix-v2-1-bd6e816ec23d@ti.com>
References: <20260518-am62_firewall_exception_fix-v2-0-bd6e816ec23d@ti.com>
In-Reply-To: <20260518-am62_firewall_exception_fix-v2-0-bd6e816ec23d@ti.com>
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Mark Kettenis <kettenis@openbsd.org>, "Patrice
 Chotard" <patrice.chotard@foss.st.com>, Moteen Shah <m-shah@ti.com>,
 "Beleswar Padhi" <b-padhi@ti.com>, Wadim Egorov <w.egorov@phytec.de>, Chintan
 Vankar <c-vankar@ti.com>, Suhaas Joshi <s-joshi@ti.com>, Anshul Dalal
 <anshuld@ti.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779105247; l=2369;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=K/j/H+56PEueo9TKLK1v0mTtn55BjVNR0Tr0th7vteE=;
 b=83G6u9UsVpXVLnc1+On5x32gNNWvvro+hQJHIyttzsjelXEG2tBkWfbsDJ8F8H3qo6rijMQ9D
 Gkhfi9yml3PAgEGUDTwrZ6qltfT5sQ4qwCktnKlvR+VWif5HaasACve
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|MN2PR10MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: 622fa1ca-9446-44ec-08dc-08deb4d42d80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ltrAqffaFOk5b+OkAvbOq1q/WEvNfOCLxTYcbK3Aa55LrBCHR8SqCPAX7fmtrgbAVwmPicCbpzDwki35BXU5DZG/YsFYYgY1uM7DjP2FatKoG0IUzA0cpZ8wmUeNt8Q1sR5oY4x9rPNAuOuQ17ZrLK9mFLeLr2EkJBLqsA9QtC81fDMzTvGBeRo78n+ooyoRO5E13q6aEQYaBDY0H5dzg/rhS/miFGSRrh2T3e2cEa45dHK1iMfPWXIcS0O3LgyNEd70TNy8B0MBKa3x2aVTd/oHlidBogqUC/C5GX7POBmnuCEDzt9Ctw4OKU+qRCJdpEEy2TeqMI+8AfR5WysGrdh3+OXhFOs5QtgFUso2Py4uYjB8amYyEzgWlVtdebXF9zXRyb4cfHgTHzN62JQacwd93wtxFFhN6mabfPBcwh2kmDT6lrd5/Hp38ppcSg//c7/H/aiYsGiFNzipJ5uH0cxig+Wq5B7+J0Q+PFJaT61fHuJoE8aaimP+Vm8p/398sg/KJg4KonyxmHtbIxVZClFarTPBvpYUZZVaKOZE0GBii5GAn7OTMG1LuOVpDBjnApOb4S93HUGcRKn42K5Ec56137seXRdvJnGc6m0Ls9LcF6a/Cn2cPVXJ1qzYvG0dEYVv03voAKyjHFekSJR3G8y5rFhHpInByjX82F+iTuoTbEpOqihEEy3q3hcoGa9fIpQMt+hLyly3u/tGCWniPugrBdNrsGKWIdfbixi0qvM=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HhWVJ0uFYu6G2OqbtPKiFMo6ck+lln++L0SJa6LGNzYH/2jKT7KvXV5Tl24W4kwt+NF+eRilGPmCvpfhQvAUoIUYzclbemXg0u7dBQE1qZiSbqGIQVvOUDOCgX/kfUKOw6qrB0b/nuKH6POojDgKiJybq2D8TX3/Fb6NlP0gEqByop26YPpWaLxgvYy1xOA4jeVZKlKCd6qmunre3DqmWd7Hv9Xh9OpOEwwBOmFnk/bMyat8zxL/eqqY+91KwuS0kvCWdZItLMau9XjTzlIhPS4GpsVU1prn81WiLT29G9xZjqLeQN/VDcFGL8nOOdBY2Lm6i6oeXckd0Jc/s6cySdRaFelIIafbiDAmUWZ5Tmipd2qn4jMhQc21/WseaPDW56wi+dHYDGOESLpkFBLFPwWHIZDmnJPIff8P200YCgaRdWHPn2auCOxRtbiHYyY3
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 11:54:12.1693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 622fa1ca-9446-44ec-08dc-08deb4d42d80
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4320
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

Currently mmu_setup for ARMv8 performs two functions, first it sets up
the page tables based the memory map provided by the board and then it
enables the MMU.

However for some platforms runtime fixes to the generated page tables
are required before the MMU can be enabled, such as K3 family of SoCs.

Therefore this patch moves the enablement of the MMU out of mmu_setup
and to a standalone mmu_enable function to give more granular control to
the platforms.

Note that no functional changes are intended from this patch.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/cpu/armv8/cache_v8.c    | 5 ++++-
 arch/arm/include/asm/armv8/mmu.h | 5 +++++
 arch/arm/mach-k3/common.c        | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 39479df7b21..7c0e3f6d055 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -810,8 +810,10 @@ __weak void mmu_setup(void)
 	el = current_el();
 	set_ttbr_tcr_mair(el, gd->arch.tlb_addr, get_tcr(NULL, NULL),
 			  MEMORY_ATTRIBUTES);
+}
 
-	/* enable the mmu */
+void mmu_enable(void)
+{
 	set_sctlr(get_sctlr() | CR_M);
 }
 
@@ -881,6 +883,7 @@ void dcache_enable(void)
 	if (!mmu_status()) {
 		__asm_invalidate_tlb_all();
 		mmu_setup();
+		mmu_enable();
 	}
 
 	/* Set up page tables only once (it is done also by mmu_setup()) */
diff --git a/arch/arm/include/asm/armv8/mmu.h b/arch/arm/include/asm/armv8/mmu.h
index 8aa5f9721c4..5359b2ad87b 100644
--- a/arch/arm/include/asm/armv8/mmu.h
+++ b/arch/arm/include/asm/armv8/mmu.h
@@ -222,6 +222,11 @@ u64 get_tcr(u64 *pips, u64 *pva_bits);
  * mmu_setup() - Sets up the mmu page tables as per mem_map
  */
 void mmu_setup(void);
+
+/**
+ * mmu_enable() - Enable the MMU by setting 'M' bit in SCTLR register
+ */
+void mmu_enable(void);
 #endif
 
 #endif /* _ASM_ARMV8_MMU_H_ */
diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index b0a75988714..396018b7a7a 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -279,6 +279,7 @@ void enable_caches(void)
 		       __func__, fdt_strerror(ret));
 
 	mmu_setup();
+	mmu_enable();
 
 	if (CONFIG_K3_ATF_LOAD_ADDR >= CFG_SYS_SDRAM_BASE) {
 		ret = mmu_unmap_reserved_mem("tfa", true);

-- 
2.53.0

