Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7FBFD2D79
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 13:12:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E159684010;
	Tue, 10 Mar 2026 14:12:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DvhEizDf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36B1E83FA7; Tue, 10 Mar 2026 11:06:43 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26FFC83981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 11:06:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-kaur@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFslOppCn4CAkLv6f5yFE4/Ec+TT1YUaJ5JPOzzQ9DBNd9BFpxGdtoz1SIJJsGjimolr7fHJqTVmbW9qYh0BSF37EhiuvYN0rAbHNRk/n16fG/F+5vejaUG+e0pTpUPei51Wg3CaAsmM7D5GC53mND74k0GD4m5VdM/whP1VYoMRx7E4LpbodrInxWL5Z9BAJqyQrWj+nGgMuUM9vZNdC9q1kaAzMZDvr14SbC8Jf1dxPchbb278vaTy44NILZUELMj8mwr3FdrYhXoK0lp5j+ddfQkhfqHDk49eq9u3IeH8MONCeCAs7iM40ZDwJ98Zw4Zuf1i0rgqDOM+QIhsKMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glXQC5jB3eKvF2C8G2OQM0VCN+K7AKp1MraujqxiZmw=;
 b=dNYTm3qyMZCj4smeaXmC/frJFb7nN04X1DmvdQ/pdjB8DxYDRwdGTPjJEd/DO7Wv8CNX9Bj62b4ELFZlcTpubSPxKNuYIA71JahPAibmFvgogX0nLI1eCjxLl+lPJ0JZBRKbFhKgGzcErN43Bjzg31JzDqklejwb7rspsrSjxz25qZRh2ccpplz9D0bYmKQ4v03hRYv4lQhPdjQmsV7i/g3TlhDjnyGN7MTKO3y0VzEr1UgdY2Vc9tNMV/KQeMpmUatv3hCt6fQ0vSMc/3QG5hDzmVRV2bzCPr6TBDgTT0uoXqGUYk3ZNnsGPHtbXzRpBe/dVdVyi+hhEyL73HXspw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glXQC5jB3eKvF2C8G2OQM0VCN+K7AKp1MraujqxiZmw=;
 b=DvhEizDf0JKewbex0F3vLRIHeWFD6l25Y/GiT2qy7jirmnfAih1RzcEqcG3xLQWmrHSBgOnbX3jJTXBn6IEHntHV3Llz8aw7DxbMzWeetdNzHh+It+OB0Nqt6XjFrcrYBUaQgiXqdKWFn6OHLMQjeI45mhDyAwWJsvoQ08e9AbY=
Received: from BN0PR07CA0022.namprd07.prod.outlook.com (2603:10b6:408:141::14)
 by DSWPR10MB997827.namprd10.prod.outlook.com (2603:10b6:8:36e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Tue, 10 Mar
 2026 10:06:37 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:408:141:cafe::bb) by BN0PR07CA0022.outlook.office365.com
 (2603:10b6:408:141::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 10:06:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.1 via Frontend Transport; Tue, 10 Mar 2026 10:06:37 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 05:06:35 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 05:06:35 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Mar 2026 05:06:35 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com
 (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.91])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62AA6Hr32355078;
 Tue, 10 Mar 2026 05:06:32 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
 <msp@baylibre.com>
CC: <u-boot@lists.denx.de>, <vishalm@ti.com>, <sebin.francis@ti.com>,
 <d-gole@ti.com>, <k-willis@ti.com>
Subject: [PATCH v2 3/4] mach-k3: am62px: Enable 32kHz LFOSC during LPM resume
Date: Tue, 10 Mar 2026 15:36:13 +0530
Message-ID: <20260310100614.951573-4-a-kaur@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260310100614.951573-1-a-kaur@ti.com>
References: <20260310100614.951573-1-a-kaur@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|DSWPR10MB997827:EE_
X-MS-Office365-Filtering-Correlation-Id: eeb8a624-e26a-4c7a-71e9-08de7e8cb78a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014; 
X-Microsoft-Antispam-Message-Info: zJ7vrHKRGBfEr9FHP/4QFwjg0vVyP8RHWZ3oUFccbvI4Z9X2EqTO7gv2RM48kjrfVFprlKd9n3R7i6TvLFuh+cH6TkybDvQQV57uvwdC4mFhSpRBiuyaIISsxWQuMWWIpDJ3SoDGkrNRkhUGWJ99CpVrjKrauLGrNDlVOBnfbs9GN8AzyIKQOkBIZuSSs9j0wG/n++4TpSUMFD01F2p+6LqC6y7oryc37iwUBfYyQDSNKmHqy8YLo4yMITX0V6SQnMN+ZGa6JPWeigieK9uk6m02lKI1TYaaY0QBZ6h4ssHO+pHXeBeN7L5dRLBusLwQrM+KXVb1UEPofwxhnkGzI/iM/HGpszUyGn0Da/qut9cBvdBTGlT/Y1T8NWLQezSVoZX0owg7yVH++5QIBUy/v8WRGezR5gUqnUjXyEEloqEN773JXNaEH1D3Tq/my2ejsRFRcxyV4YOiE7a/FJMoaTqaiNcKINe31NqlhgrdwdM1yWLb+lXL/7vt8Fr9aSm80kS3BjVsVApRxgSlx5GRpAaab6wNdxiJ9BYJ3PaMixR+T1i1hHMYZrvVaEXMshmGnFEG9xdytd14XAsjfblm/IWxf15xLkNgr9RhO/P+mUEKn8MVZEEBBJ/TnOuSw5TF88RuT3DrXNUCuWXZWfbWl/DeBH1NhMSTNzx60+vJOwjR08KJMnIrHy9k+vn3aEMUyZW7rYypbQdkjCvFpcSmx4M9/sCT7HtpWxA8wMbAb946BTQamutIgdjBTmpKIn7E
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bEXW3uGu9Sb2uxeoHYeXh7KnZNga4AW9w2fBZmCyOjb3BOBJta6edtBD9ImH6hj1qyXwM+bUhof4IDQD2YZ9miXVYgYZDSfWzrx9rmTZfseS9Bj3VMbFeY2a0PgCji6gaYwdtpgQ556wQA2ucBd//GArGmbNuV5mscVuDGQLLtjxXAgZTj3AiJU2Vf6XSGWKpdzTOoNhluz2BBTdn8RQrXYF+ZpLYk8PxGvmeCKhdIF9ZM4LdzSvGkNtxKiN18fsZriiKF6BawUDFQ/zmWYWxB8XZ1SMwbkrchSENI5XizRLA5K2XgNxtI3JFJyikZaRMOssiXb+a8h7eOZsdeup0RhpHniLayKQGp80QyadMt32bMqU+XPdWi0v6WhjoHvTffOq9r3VujISG16HdwgrIlhu490MF5r33hTY3UOhQJMSUfy6wAqMcwIqPPzEXyMa
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 10:06:37.1710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb8a624-e26a-4c7a-71e9-08de7e8cb78a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR10MB997827
X-Mailman-Approved-At: Tue, 10 Mar 2026 14:12:02 +0100
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

Enable the 32kHz low-frequency oscillator (LFOSC) during IO+DDR
low power mode resume for AM62P SoC by calling enable_32k_lfosc()
in the LPM resume path.

The 32kHz clock is required by the RTC to maintain timekeeping and
generate wakeup events during deep sleep. This ensures the clock is
available early in the resume sequence for proper RTC operation.

The function is conditionally enabled via CONFIG_TI_K3_BOARD_LFOSC
for boards with external 32.768kHz crystal oscillators.

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
---
 arch/arm/mach-k3/am62px/am62p5_init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
index 64e14636592..d78add34d71 100644
--- a/arch/arm/mach-k3/am62px/am62p5_init.c
+++ b/arch/arm/mach-k3/am62px/am62p5_init.c
@@ -258,6 +258,9 @@ void board_init_f(ulong dummy)
 	if (wkup_ctrl_is_lpm_exit()) {
 		u64 meta_data_addr;
 
+		if (IS_ENABLED(CONFIG_TI_K3_BOARD_LFOSC))
+			enable_32k_lfosc();
+
 		ret = wkup_r5f_am62_lpm_meta_data_addr(&meta_data_addr);
 		if (ret)
 			panic("Failed to get LPM meta data address %d\n", ret);
-- 
2.34.1

