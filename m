Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D8FCD8CB2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 18:11:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E73108497A;
	Tue,  9 Jun 2026 20:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eudoY7rR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50D6E8493E; Tue,  9 Jun 2026 20:11:15 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F77A8493E
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 20:11:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jpk1ZAd7syrYDPx4/OlbH52Qh3hxWg8xynXfxcFlbY8iJJqtKLOJROPlqWTC5Ygm594jro0zKee+0YNPMY+d2I4lPgm4F4KynHJ4zcOxzh9/UpKzk0boSdGx1xk4TwgfJkxc0KRpUwM2ZUABdMTCZdo4mN/vpFB600ACRIVJGbhi0Tkt6G5NioJhPEEg8VBot3Zs/w5ozk5yjtvcTPgumKXDWGZ73saFsnPe4tugG9zdu9IU7VS6ZJ8Ypo9lTwCEKeBUX6B7AzQi2qLsv44RyzkAAGrklhgVTAst00aPkl81pQcJLSdJbIY5ukGwjZweS/pc5T4Y/g6SMABa2Cbm6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0DIJa+GJFn3lzq8B9/gb7EMMwTWdAAiRN/JFPqvv1w=;
 b=DQrd7C6fAkNURF3k+Iy0It9ZTgWa2QrGNMUrJbSpsHwSwzRnwzKKBTJWp9oHpgPbpTD2u/D8O5DMUpQWwVBAH8yA4rUJO3j4KUab7I6JvX1wHzaVnEIVV4YX6Y0el6Ym1iNwRE+g0Zb5Bjzdcq9mjeAa0Gr8AOpTRFZ/3T0+Y8cfnZSlqU1WYXGt2EuCQYEooaHQ72SRXNke+hupltWn8Zew/huSSnEBgKZorD1oGbRd/SAIL2gi0Yblbd/HWG/YssmgFrQhXPnCFq0Rx6wPVzOesA9RpDRBSsCly6rbpgtfEpK7+2R2051w5rd2K7CX6AA793JAQATNhBy4O/e4rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0DIJa+GJFn3lzq8B9/gb7EMMwTWdAAiRN/JFPqvv1w=;
 b=eudoY7rRjxQAH6YiB0xUaIywk+wVpdbb03t2qK/5FY0ukwZB5z0x2dLoEI8hvUoaXbxBgJ6AxVkIGn18n33uGJaDfT1i/2uM8ta4IZcJYH7XHspiNn5Gyrngwow2666jnSkeg0n4lfqBrR8RglAyd2bSxB1bQrHHoTZHiGYZ9x4=
Received: from BY3PR05CA0028.namprd05.prod.outlook.com (2603:10b6:a03:254::33)
 by PH8PR10MB6624.namprd10.prod.outlook.com (2603:10b6:510:220::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 18:11:10 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:254:cafe::3a) by BY3PR05CA0028.outlook.office365.com
 (2603:10b6:a03:254::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 18:11:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 18:11:08 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 9 Jun
 2026 13:10:27 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 9 Jun
 2026 13:10:27 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 9 Jun 2026 13:10:27 -0500
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 659IAQTO1612640;
 Tue, 9 Jun 2026 13:10:27 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, <b-liu@ti.com>,
 <afd@ti.com>, <anshuld@ti.com>
Subject: [PATCH 4/4] arm: mach-k3: Add DM reserved memory fixup
Date: Tue, 9 Jun 2026 23:40:06 +0530
Message-ID: <20260609181006.460401-5-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609181006.460401-1-p-bhagat@ti.com>
References: <20260609181006.460401-1-p-bhagat@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|PH8PR10MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: 2863a948-200c-464e-78b9-08dec6527b00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: iR+a68nNdxWg+kMXRgd8YriI6AduBV3klWLvEdbiBB6TizHjvWqQaVMLAttHtLJx+pnpmmBNCOUY0RQBf93BweEvQ6fDzM1cMRME5ddrBF/wRkPr48z9GwmHoBFxuOvKXXYDSjn89Xy+piM0mWiRzSaf+otMcZvvsayLB0e6h2zvQb8M0klpAn1miMwfcyWVu/Pq0TPVvJVIu0xmr+L60Y9cHoQknlGfNvsjHDa+HqxmwaG9FUAbV//ZCxtWD13XC8woHU1Ye3PEAyyAHQIWhCb27mZLAsDBmFknSbEdkXGyBKr58xgdv3F5ch3hzzjsb1gGu2zVsEn2SvSwS8aWPPIaQkJ+vjgK2uiEOxhjffvWIZDPE8IJMvS1z1ZqnwoxIFdtQUaJ6a1v6b7Zyk07NgdzPXaW4zHkHNpNgGCj//S2YxL5WeUcUCfRaMQN5PlbAdHMwBPEPF6lH/m775rJ19JYJOAy9DXyFJHjLTejhmco6o0RJCFzJcV6MjtxKRfSl+9PRV5j26sflxWcHGuh+37y+1IpI7s8oU79MOOkq3EB51eIr6kpMOTE5QlwbTsipLxq0W7eyxLQ1o2DFTsG4GPcJANb/9p/pB9MZClkOwk8Y19Oeyh2usD8/y2AFVuITCOll31NE5L02WnsFlu1Ep6VNKG2sOWt/677vV2CbfHJvSNpr2LPPnm/WYeywmYD3I5kHcd+iZANGKz2aI8el7VN9XNSUAs1YvTm2c81sPg=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AseUpg10K01p8y/ms3scFeFsMELGf+tSZIwy+oP8cJ6u4hY6CaYdD2yIelup1FfoHSRoZyk+4zSjYZKaBR/MuPwCG841qY4G/OYPgmZMr3/N99bTHng21F9D18qx6bzZuKbpwpCJgz8XvB3fQJ+JKjpOZyIgdZDE7z0xD3FmQg1zqfejtwGAztFUNkF9xNRnuybRBTAT3NSu1KSr1boPZu74jeXXAz455lr1kLM8wQjdLJMejLGl9LuGd1uN1x3RpzzKZ5Kc1lKNiV92NTwCkKfQfqGcL6GlbsX2azNL71Igd/RIuukfWeJay3Faq+fi/EDZGTeQx5UlHNXAa4QfoDhREiySLiejy/kvjFkw5OMCmCEUV0zXavdeFOHLIiXD7cTZnho2tFsD6+pMO/cdy8VjXVIASMnR2wc15NAidXn/yVEoc7tcpisadJck3cc0
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 18:11:08.5197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2863a948-200c-464e-78b9-08dec6527b00
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6624
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

The wkup_r5fss0_core0_memory_region reserved DDR carveout in device tree
is insufficient to accommodate the current DM firmware binary. Add fixup
for DM to expand the DM firmware reserved region from existing 0xf0000
to 0x1f00000.

Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
---
 arch/arm/mach-k3/common_fdt.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-k3/common_fdt.c b/arch/arm/mach-k3/common_fdt.c
index 25e40f6a666..2386c4a2316 100644
--- a/arch/arm/mach-k3/common_fdt.c
+++ b/arch/arm/mach-k3/common_fdt.c
@@ -177,9 +177,23 @@ int fdt_fixup_reserved(void *blob)
 	if (ret)
 		return ret;
 
-	return fdt_fixup_reserved_memory(blob, "optee",
-					 CONFIG_K3_OPTEE_LOAD_ADDR,
-					 CONFIG_K3_OPTEE_RESERVED_SIZE);
+	ret = fdt_fixup_reserved_memory(blob, "optee",
+					CONFIG_K3_OPTEE_LOAD_ADDR,
+					CONFIG_K3_OPTEE_RESERVED_SIZE);
+
+	if (ret)
+		return ret;
+
+#if defined(CONFIG_K3_DM_FW_RESERVED_ADDR) && defined(CONFIG_K3_DM_FW_RESERVED_SIZE)
+	ret = fdt_fixup_reserved_memory(blob, "dm",
+					CONFIG_K3_DM_FW_RESERVED_ADDR,
+					CONFIG_K3_DM_FW_RESERVED_SIZE);
+
+	if (ret)
+		return ret;
+#endif
+
+	return 0;
 }
 
 static int fdt_fixup_critical_trips(void *blob, int zoneoffset, int maxc)
-- 
2.34.1

