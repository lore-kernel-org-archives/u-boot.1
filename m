Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D5CC44500
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 07:20:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECC4A8341A;
	Thu, 22 Jan 2026 08:20:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FKFFT0a4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C93CB8397D; Thu, 22 Jan 2026 08:20:11 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD5B280077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 08:20:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0GeaopGDSJAQaN2ZahAQ0W/hD83hP9G9qbFNKYLqTK1u3nvPaaqI9GPiY4kLDP8WSTOZu2WEbt1Pet09rhAlbwtXuYNjawU9+DT+M8r0hQhQ1ZL8FJ7SZ/CNamfil9j1c5rDtHn7vXgKX+CqqBn5L4ZQWi9z3crtsLkNh0batPsGPQB2WJOEoxsWPIp7zV9FhbVR+Evv9r+UEXqZ+CFsK5qfwjqNmJ1329cSaDxPqfcRIE2CQliqplD6EG+ecA6Qy1zOgOhN148u9sIIabwFIbdq1mIQY9NrdHOeIwdssU+J5IklWDz34Wyv2SNvHOd26vFYBcdSsPIV65+LGr+Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5e9JwJ4NrgNBK7TF726HnFVG5z119Fxqa8/2nf2i8s=;
 b=uML2pDwF1cQQCizW15hXwhNkM7wHVkXUPUxOQto+12LqYB/egf4SbbMmXiNZNIfZ55vkC81U84Kid+lNYFHaxiA9kxDvLD5QGZe48GtdRyXa4FhgkpCJaxCBrremrHPeodC3TjlrO8DXKU3AEVcuAYLubtGauoZEpcBWLsZzqeqCahaLffAchaAVKrl9XhafyyX5Ue5YrrC5uGskGopSEH1y3/PMy61IZ1/pnh/wjshT42mwe5gwSM7NMhM7tAkcuMWym9hSHkIP1ok4RshkFj2SIvr4FfCZX6fBnnCYRb7ibzi74qpM09pIH0PgXOfq1xt6tMtzx8crGixNmYd9QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5e9JwJ4NrgNBK7TF726HnFVG5z119Fxqa8/2nf2i8s=;
 b=FKFFT0a4W2NaFh1e8Un1JBt0el5Z7a0vNKT0fP3PrXHzYtR5Juxxe3vCtj61cOIj4TRbSMXjaxWy0YdDkQ3bjP2Uf8kmkchLa1oIDQwbznxhbn+igA/gbDUw5K1LqO3yjZuggOoa7GIuuPUTNEFPVOwQVIadEZ0Ig5N9huyUsqI=
Received: from MW4PR04CA0387.namprd04.prod.outlook.com (2603:10b6:303:81::32)
 by IA3PR10MB8615.namprd10.prod.outlook.com (2603:10b6:208:574::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Thu, 22 Jan
 2026 07:20:06 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:303:81:cafe::51) by MW4PR04CA0387.outlook.office365.com
 (2603:10b6:303:81::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Thu,
 22 Jan 2026 07:20:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 07:20:05 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 01:20:04 -0600
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 01:20:04 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 22 Jan 2026 01:20:04 -0600
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60M7K3Cf176040;
 Thu, 22 Jan 2026 01:20:04 -0600
From: Anshul Dalal <anshuld@ti.com>
Date: Thu, 22 Jan 2026 12:49:56 +0530
Subject: [PATCH master] mach-k3: am64x: add support for speed grades
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260122-am64x_speed_grade-v1-1-8a8db3147428@ti.com>
X-B4-Tracking: v=1; b=H4sIAJvPcWkC/x3MQQqDQAxG4atI1h0wU1HoVUqRMPm1WWglKUUQ7
 +7Q5bd476CAG4IezUGOn4V91gq+NVTess5IptWU29y3nDnJ0nf7GBug4+yiSFwGngbR7q6Farc
 5Jtv/zyctEl84vc7zAk+ug1lrAAAA
X-Change-ID: 20260121-am64x_speed_grade-1c71f7ad43dc
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Chintan Vankar <c-vankar@ti.com>, "Steffen
 Kothe" <steffen.kothe@skothe.net>, Neha Malcom Francis <n-francis@ti.com>, 
 Beleswar Padhi <b-padhi@ti.com>, Bryan Brattlof <bb@ti.com>, T Pratham
 <t-pratham@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Anshul Dalal
 <anshuld@ti.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769066403; l=2318;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=l3vS5G/QgmF8I3+G1ceifmnyUCai+8JBc5BBGO2G5FI=;
 b=kG1zhso3nc9S6nVJoa0dTwdMPU4YgOaFjsYRRDHK3tCe7Sa0mNk+m0eHnBbmvTXbb/pnkakTs
 ji6AS5TSFmRAS5kj9PtdECNoq7/1JMPA2110pIL/RhT7DcU9kZ5HtbK
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|IA3PR10MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: 380df850-0975-4d79-5c45-08de5986aadf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amVXaU1nQUZ5VUJPNXZHV1hIMmJnb2NGYjJMa1h4ek9ueCtzVXRBRDR2ckZn?=
 =?utf-8?B?NXg0NHpvU0Y2MUFDYTJhNWlHWlNqcjA2dlR0d2p3M0Nsa2tDOTcxQy9QYlRX?=
 =?utf-8?B?TFltRzY1Q3l3N2wzb3JwS0h3RXNNZm50MXU3T2FTMkUrYWNORS9MVUs2d1VH?=
 =?utf-8?B?aTV6VklsYnVFczFiRGFxM09hKzE2SlBYSkhPNHpaZTVQSkw0Z29BZ3R5cElw?=
 =?utf-8?B?WHVTOHU0eEVOMmpVNGFacGN3dkdsWmJlWk0xVXVCcXJEcXlyNmtPVnFsc2xJ?=
 =?utf-8?B?UDlOam9aV1lqSlNaNEJPQWszUjhlSDM3RkJHRDJJWXo4cnZQQnoxSVVEd05Z?=
 =?utf-8?B?anVNQXl4eXlneXBDek84MlMzdlF2NllhTGRWSXhjSGU0WlU2RUp1T2FXT0lu?=
 =?utf-8?B?WE1WUCtBcUZkWUdyVXVDdXZmN01zN1ZqMGU4Y3F3dWFyczM1UVZ6aXdQTUFr?=
 =?utf-8?B?TktBR0ZDZzZsdzZ3ZDBIOHRpVk5USGljNU1jdDVpWTFJdnBmbXZHRnRYbmlh?=
 =?utf-8?B?Q3p3WkFwYk1JbWs4RVFBcjBVdWsrcjdaU0o2c3hxOERwdlFLU1JSQWtmaTR5?=
 =?utf-8?B?MjJrRldHd0EzdDl1NENESm1JSU9LYWEwM0kvUXBQWDRsS1JMSWdJR2xzT0w2?=
 =?utf-8?B?RFNIUW4rTUxxN3JudHhtbUVvckFHWVRGbFJqczBUME9XVG5XS1V1S0ttMUIz?=
 =?utf-8?B?aGlFeWJBa0ZINy9nTjlodnFEVlJUbFJkUHFyaFFYUjFmTWdoL2dIMzduY2tZ?=
 =?utf-8?B?QkFub09SemFjZFJnUWs0cldOV0kxclkveGpNcjlCRmhCZ3JkRzNEZ21PUU5I?=
 =?utf-8?B?S0hYU2FmSjF3eUwyOWh6ZEM0QnRLMXM3eEhSaVRiOFRGMUtUZS8xY0JPRTFB?=
 =?utf-8?B?SFpQM1p5MlVsRy9YNVpoeENabzNvSTNqVGVMT2Q1VEdsZHpmcmwxdVRMR3dj?=
 =?utf-8?B?dllNWHpqdkdSMEM0YUo0T01CWTdmVStVcHEvMlpnMVUyaHFKQTl4VXVtajhj?=
 =?utf-8?B?RmhNeVYxcVpOR3JZdlNsQkJDZjRjTU5KcHZrcGNqd0RxZXVUa3pHeXZOR1RI?=
 =?utf-8?B?RUkyU1RBT01vMmVHeXM2cXVtYnZYVXlYdHhsM2FyNzN6OFZQa1dRdFl3Sm5K?=
 =?utf-8?B?MVlnQWw1ejAya3FKR243UHhySlFqSVVaVFZDUHBiSVE2ajZOVW1MRjljS3Ur?=
 =?utf-8?B?dllVaWI4SHV5R3pIVUNHSmxzMFB5SGQwdEhwWFFhS3RvQlJvZSt2MzBEYmU1?=
 =?utf-8?B?cHNYU0UwWVQ0OEFkbEtvYndSVjZQUEZPcVBBNVdNQmx4MmR0bFhobW84VXM4?=
 =?utf-8?B?TElYMWF0dzErbWo3b1RzR0FOZStzMVdEMTFxOEMvdnVkT3g5MG9vcTY3Y2d2?=
 =?utf-8?B?NWU4T1BteUFoS1hDcWFNaFJ6MHc5a2I2SnFONFQwaXV2TDB1M2hoOXZ0c0dI?=
 =?utf-8?B?WGk0VmJmZHdYb292VW54VGtNVVgyNXFMTEsyQkt2SXBHM2lpZ2ZsSndNL2cy?=
 =?utf-8?B?QXZNOW9YQ1FpV2ZNUnpyTVFZcVowTlBFeEh3R1VLK1d4MzdDQnVScDdXUjZO?=
 =?utf-8?B?ckY3YU1TSExRZ1UvRGpwR2xFTWppa0g5cDBkMnFTMXc4WUF1dm9YalFXSjRO?=
 =?utf-8?B?MW1BalZxRTEwbnR0R2FzVDJVSjBtMzZYY3RXZnp0SDYxWVRGaTZLMmpKOXBn?=
 =?utf-8?B?V1JDSDFDeUpYVGVMMUh1cWNJSmdJdy9ZL0dONGVTMUorL0FYeE5qN0VyYy9J?=
 =?utf-8?B?RkhKSUJybG5FVFVEUXJML2pOYXZZRlh0dXVXVUNlSm41a0xMU1NiKzR1Y1Jl?=
 =?utf-8?B?MHdjNW5zcmoySGNJbk5VVFR6N1NsZDdCK2x4OWtnZEJNV0tSV3dDOUtpQ3BD?=
 =?utf-8?B?dVd2TUJRNXh1aFdraVVCSlc3RVc3RXQ5c0Q4cXQxc1JYeURPSXIwaldCMENK?=
 =?utf-8?B?cDVaR1BaZHBVRDNpNzkwYWxiMEhyRXBmcEt3TjV1WTAvVFI0U29iUFNqVWdJ?=
 =?utf-8?B?SStVTER5RVpFUk9wODgwMzEwYUVJRlFETVM4TUJiR29UREJvdHhVU2tGbGFL?=
 =?utf-8?B?Zms1RFNoUVZSWEZsQWNLMzdMK2V3VEdnTVhsdkptS0d3ZjVnRzhzbFhGb3dq?=
 =?utf-8?B?bW5lTGdUZXBmUEFSQmE0eTQxdURRVHQySUVDVXNmRVBvQUFFK254NGR5ZWR4?=
 =?utf-8?B?d0QyMEUwZWpjTUtTbFgxNUFDUW5LRjJ4cnJuVGN2NjRmQ2pmN0pZWTBOeXZW?=
 =?utf-8?B?ZlN6RkpQREYwVTRGb2xQM2VQUFRBPT0=?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 07:20:05.9089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 380df850-0975-4d79-5c45-08de5986aadf
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8615
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

With the support for common speed grade configuration added in commit
65a6b83a9b7f ("mach-k3: refactor A53 speed grade clock-rate fixup"),
this patch extends the support to AM64x SoCs.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/am64x/am642_init.c           | 22 ++++++++++++++++++++++
 arch/arm/mach-k3/include/mach/am64_hardware.h |  4 ++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm/mach-k3/am64x/am642_init.c b/arch/arm/mach-k3/am64x/am642_init.c
index 219798315db..a15adf1cb1e 100644
--- a/arch/arm/mach-k3/am64x/am642_init.c
+++ b/arch/arm/mach-k3/am64x/am642_init.c
@@ -29,6 +29,26 @@
 #define SW_POR_MCU                             BIT(24)
 #define SW_POR_MAIN                            BIT(25)
 
+const struct k3_speed_grade_map am64_map[] = {
+	{'S', 1000000000},
+	{'K', 800000000},
+	{/* List Terminator */ },
+};
+
+char k3_get_speed_grade(void)
+{
+	u32 efuse_val = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
+	u32 efuse_speed = (efuse_val & JTAG_DEV_SPEED_MASK) >>
+			  JTAG_DEV_SPEED_SHIFT;
+
+	return ('A' - 1) + efuse_speed;
+}
+
+const struct k3_speed_grade_map *k3_get_speed_grade_map(void)
+{
+	return am64_map;
+}
+
 static void ctrl_mmr_unlock(void)
 {
 	/* Unlock all PADCFG_MMR1 module registers */
@@ -263,6 +283,8 @@ void board_init_f(ulong dummy)
 	if (ret)
 		panic("DRAM init failed: %d\n", ret);
 #endif
+
+	k3_fix_rproc_clock("/a53@0");
 }
 
 u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
diff --git a/arch/arm/mach-k3/include/mach/am64_hardware.h b/arch/arm/mach-k3/include/mach/am64_hardware.h
index 2717da07690..7e33617151e 100644
--- a/arch/arm/mach-k3/include/mach/am64_hardware.h
+++ b/arch/arm/mach-k3/include/mach/am64_hardware.h
@@ -18,6 +18,10 @@
 #define MCU_CTRL_MMR0_BASE				0x04500000
 #define CTRL_MMR0_BASE					0x43000000
 
+#define CTRLMMR_WKUP_JTAG_DEVICE_ID		(WKUP_CTRL_MMR0_BASE + 0x18)
+#define JTAG_DEV_SPEED_MASK			GENMASK(10, 6)
+#define JTAG_DEV_SPEED_SHIFT			6
+
 #define CTRLMMR_MAIN_DEVSTAT				(CTRL_MMR0_BASE + 0x30)
 
 #define MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK		0x00000078

---
base-commit: 51a884fdf3a9f88f3bbd0e4b1782cc6eb172b8a9
change-id: 20260121-am64x_speed_grade-1c71f7ad43dc

Best regards,
-- 
Anshul Dalal <anshuld@ti.com>

