Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1513D2ED11
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 04:34:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 319318389A;
	Tue, 20 Jan 2026 05:34:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="m4XhRTHy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DABE839E8; Tue, 20 Jan 2026 05:34:55 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6E4182A9E
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 05:34:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGJUf3AFmrWxqGe+/UMbH24WTkJlZsdegeWWS1FyWc+NNsa9WhQY4CsGosP18fn+aUB5XsQF4zYDH73uCfHvhRHFmLMXK+efFAXi86AN0K8SnYU6tIKIACeK/1r8dWGzK82fBeQj7EqeFrbNOocaF9oFX7Vik3SLMMslqYphlLCMaBrO0skZwLAvOxzQu153UMrJtR+zBqImtuTIU8E2MXqcFnaBfqbXSCDfPGQyYvH5fPRZQc0oFUGeQop4wN7kphTm6mrZz6GfpzyjpiLZ4MzLxmSvJ5OHwiecaDgrZ6rcrnwJ00u3hHoz1qTfBsJQU694N9+RrlccROc3yBV6tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rth2zCtCNdBlO9jpRFVxXb0ceM4Rjaa98cfa9+O3jQs=;
 b=bJI5O/tOORYR+qBeARJRx7HnhudEvfd4ZWO9OA1r4zDVkuNLlfZI6g/2ZoizWj2F45haHl809cHhcB4skvYk2FeRLU5kIiLarYLce0PiW4+b+fLyFIo3zwlrDrbzGhMRXlZVNc06X17MmU6qotnZZO1GCdN869g/6MkWBUHruheBmRho8lLR5iziqYcdYinGxhRPMTAkWTEYeY4gNxg6WuMZI92L15AIrAypxvZswngiUKRajcYhwnruu7gdFXoovI5g3mtXwBSsVnTa3ya9WzP1YWVVDchVGD4jjoETd5hgixF0ytWVbuQIC6ATg7WIax+saj9KAiNueQC1oBnKcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=dh-electronics.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rth2zCtCNdBlO9jpRFVxXb0ceM4Rjaa98cfa9+O3jQs=;
 b=m4XhRTHydKFmnvmtzI37ShPGuIqtgYxOXpv3wIl0TaVAjisEYWkiBokrY45lLVtUE15Bv0fXVESVWULgJLdl0BkNfjG+E0jdxja+kKFNbc8VFqj3ECmaqm1przmbRwfHs2QK9X7geKc+oXDP1VVni3NRFtGrT4Cud9KnhIZDgpc=
Received: from BYAPR05CA0030.namprd05.prod.outlook.com (2603:10b6:a03:c0::43)
 by DS4PPFEAFA21C69.namprd10.prod.outlook.com (2603:10b6:f:fc00::d54)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 04:34:47 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:c0:cafe::27) by BYAPR05CA0030.outlook.office365.com
 (2603:10b6:a03:c0::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Tue,
 20 Jan 2026 04:34:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 04:34:45 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 22:34:45 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 22:34:45 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 19 Jan 2026 22:34:45 -0600
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60K4Yhe2591987;
 Mon, 19 Jan 2026 22:34:44 -0600
From: Anshul Dalal <anshuld@ti.com>
Date: Tue, 20 Jan 2026 10:04:28 +0530
Subject: [PATCH master v4] Kconfig: select
 SPL_USE_TINY_PRINTF_POINTER_SUPPORT for K3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260120-am65_dfu_fix-v4-1-36b2dfab3a64@ti.com>
X-B4-Tracking: v=1; b=H4sIANMFb2kC/33NTQ7CIBAF4KsY1mIYSklx5T2MaXAYLIu2BirRN
 L27pBt/Yly+N/nezCxRDJTYfjOzSDmkMA4lqO2GYWeHC/HgSmZSyBpA1Nz2um6dv7U+3DmAUkQ
 o9BkMK+QaqdTr3JH1Nk0U2an0XUjTGB/rlwzr9fdgBg7cIkoDAA7RH6aww7FfV7L8J2WRiNbZx
 jijtfuQ1UtKob5kVaQjaMhVvlJvclmWJ5XPdIshAQAA
X-Change-ID: 20251105-am65_dfu_fix-1144eec06b19
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Andrew Davis <afd@ti.com>, Judith Mendez
 <jm@ti.com>, Udit Kumar <u-kumar1@ti.com>, Hrushikesh Salunke
 <h-salunke@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Vignesh R
 <vigneshr@ti.com>, Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768883683; l=1792;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=JzTyQrRmRDBEaNhrhNuzzK4nIlWBrcTJBp3mlz/1BgA=;
 b=WWJbsFhapYC2/UaWu9EsDAufmpvA6JQHlM3ppd26nJh30pLdbjCblO/3yyj6GOM9paSYOx0gv
 /Xj4WH3UApoBor11vhBRgo9CmpH+w/ylPz5RW7+po1vTFmPmH/5R0/c
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|DS4PPFEAFA21C69:EE_
X-MS-Office365-Filtering-Correlation-Id: 797122f1-be4b-4035-a23c-08de57dd3d43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFVyRnlkNVZuQ2drakpnRXhpQUJPTVhRcnZJUFV2UXBLQVF2ZlR5QVVSdUZW?=
 =?utf-8?B?TG5GUkdxa3I0RlIwZ3lEVktkR3pHK0NyU1FqSG9XaW53QlA1S0Q1dmxaN01X?=
 =?utf-8?B?bGEwcUE2a0czVE5QN3Q5amVlekZQbHA4YVdRNGorMjEvUG1VZDFzS1RacUZB?=
 =?utf-8?B?SEdSd0lVc2lwNXR1azhWMHZoT25uRHUyVktHSnRvUGJxKzhVcitLN2U3aUJS?=
 =?utf-8?B?S3lFaHBqVXErbnVqWHRtdUpkN0xxdWl2VU9yTWhCU1ptZVJBcVNwd0lETm53?=
 =?utf-8?B?T2pRRGtrU0tpaTB5dG14cHBCWmUzOEtpR05iTm5SdjBhcjJOSndjeXdkSkxY?=
 =?utf-8?B?S29sRzZNcHhRc0RUQzVsVStENk9KNENoT251TzdtUjJhdnBDSTNMeWdidXlx?=
 =?utf-8?B?cDJiUTVjdXBUa0ZlaWVjcmE2eHpXdWpLUkswMm9WVldpK0dKZFVqRk90MGRp?=
 =?utf-8?B?SUNpdGxRUnltZ2FxWGJ5VHJLa3h3WE96OXRQT3BQU0xIZzZHOXlnaStuMGVV?=
 =?utf-8?B?b0RKVGdLbkRoTTBXNWU3OXRhL2NaUEwxMVVuTGdGOWtBUEZ2bXdEazdnb3Fx?=
 =?utf-8?B?ZVIzSXdFMjc1WjVoaGJvYkd1M05wR01iMy9tb3hNdm9XckxDbG13cWFmY1g3?=
 =?utf-8?B?dTEyS2JsUlZkcnhUVmlyTWUzOE54RklQRUR3aW54RnlrSHdTUkVrV2xBTUVH?=
 =?utf-8?B?cHVWaGlIbGV5RVcwY2d1WEpIOXNENDFXaG15RE1ZTlp4ZmZkREZoR2hNeUIw?=
 =?utf-8?B?VkZFeEt0SE4vL2pKajFnbk1yUVpYaFJQajdHTmdNOHdpU0FEYVc5c2FCdVI4?=
 =?utf-8?B?bTFUdzUxSGZWYTVuQ0ViRjIrUmFIMVJqMys3bStTc0JOV0JuQXN3UG1kYmEy?=
 =?utf-8?B?RmxPaFJiUlVLSEU2Yis1WjY5WDRxV3c5Wmtac3Z0TllzZkVSMStJS25TTzEx?=
 =?utf-8?B?d2RvcXFZemU3SUI3Q1ZYK1pIZERLTUhQRm1uYXY5WUFVOGZ5M096MG5tRTVq?=
 =?utf-8?B?NGgzdXgyVXJwakxRY1BySk0yVW5VM0lxN0dTVTBmKzF4bGh3dTBEZDRMYTlQ?=
 =?utf-8?B?WkhqOEhickpySm1TK2QxejBOaDh1bWJuZXdnVVp4TjRneFczZmhzbitLUzNK?=
 =?utf-8?B?QUd6eVF6Y0p3cEFQeTZyR3hjUmt6UkRBcmlqVCtxTjh4RW1MWkFEbithSUdo?=
 =?utf-8?B?N1paQ09UNnRpV0d0NFo1aHlITzl4dUZDY3NRZXYwcDJ6c0JKSkpnQnVCK1Bh?=
 =?utf-8?B?cG5nNmYvaGRTQllpY0treGRockJraGxSakRQb3BxNzFrWmVwUHIvL2dnTmV3?=
 =?utf-8?B?c204Szk3ZUptMFNjWXN2WEJVc2cvV3RBbFVNL0NzdEVRa21WMWNqQ0dRaS9Y?=
 =?utf-8?B?Q1VGMlN2N0EwUjBEZlhZbDJlRGxLZ3duNDBDUklKTWs1L2VuTXpBNGJEcWJ3?=
 =?utf-8?B?L1RYZGt3UkRoeHdoMWMrV1NqZ0hsMWUrUzJCUU1qeEdoWmRScGhiNjgyNitU?=
 =?utf-8?B?czFoTlg0OVFMNHN3RkpDdkJiL3lHUlJpTlEvaHA1ZHdKNWtBRzVYdm1UeElz?=
 =?utf-8?B?V2c2b0ZUNFpvTG15UmgycVR2ZENvZUlZcUxKUFJmSlo2SHJiY0puZ1ZOT3BJ?=
 =?utf-8?B?TUFDa1NNYTZPaXpaTG1JckFyaEE1MHpHRWFtNWhKT2N6U3pSdzBDNStWRVB0?=
 =?utf-8?B?bGVIZ2kvRVN5ajliWmV5b3g4Ty9hY3Z5ek40YkIrbHY3MnZOcWs4SGp4Yk00?=
 =?utf-8?B?VDJEQStZZENpK3dSVm9hcnlmN3crbEFDN3hlL2hxZFY2TSt6UnpBM2FiOEZM?=
 =?utf-8?B?T0hNSjBMNGFRa0MwZDRVU04zU0l1WWVHSHNRUWxPYzF5aXl3YjVUSmk4Q3li?=
 =?utf-8?B?WHRiT09jS3N0bGlwd3d0WW1wUjhqUVdGZ3NmUmN5cVg4TkN4dHIrdzZaZVZZ?=
 =?utf-8?B?aDdsRFc2NU5VMFRiMldjZlRlSUNaei9yaHRzTHlGM0tzQVZURFhBQTVwdk5w?=
 =?utf-8?B?S2ljR00yMUg0RHB6UWxLR3VhckptUXpRSEgvekhjUTJHc29jdDh2YXR5L3Fj?=
 =?utf-8?B?cUViTnVEckNOVGRrQWhnNVU3dDhacnQ3NGorRW4zNkluMzVIV2VibjM3Zkhi?=
 =?utf-8?B?YnB4Z1RmUk4wVDRJUTdyZnBNbFowemlkYzZlbHNqSGJiN0s0WmFOSkxHMnRJ?=
 =?utf-8?B?NE9MSGZqVWFoRUFrS3JPS2V2RWlzTmN4QTNLS01Ndityb1FrQThzbW5LK0Iw?=
 =?utf-8?B?S2E0dDVwY3BSem1qMVBvS0xHK0h3PT0=?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 04:34:45.9063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 797122f1-be4b-4035-a23c-08de57dd3d43
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFEAFA21C69
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

Since the commit 1e24e84db41a ("tiny-printf: Handle formatting of %p
with an extra Kconfig"), SPL_USE_TINY_PRINTF_POINTER_SUPPORT has been
made mandatory in order to use %p which would earlier have defaulted to
a 'long' print.

Without this config symbol, k3_sysfw_dfu_download fails to set the
correct value for the DFU string with:

 sprintf(dfu_str, "sysfw.itb ram 0x%p 0x%x", addr,
   CONFIG_K3_SYSFW_IMAGE_SIZE_MAX);

The value we get "sysfw.itb ram 0x? 0x41c29d40" causes a boot failure.

Therefore this patch sets SPL_USE_TINY_PRINTF_POINTER_SUPPORT for all K3
devices since the size impact is less than 100 bytes.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Changes in v4:
- Enable pointer support for only DFU configs on ARMv7 cores
- Link to v3: https://lore.kernel.org/r/20251204-am65_dfu_fix-v3-1-de18ed3f346d@ti.com

Changes in v3:
- Handle setting the config in Kconfig instead of the defconfig
- Link to v2: https://lore.kernel.org/r/20251105-am65_dfu_fix-v2-1-ccada89d966d@ti.com

Changes in v2:
- Remove unrelated changes
- Link to v1: https://lore.kernel.org/r/20251105-am65_dfu_fix-v1-1-acc29111dccf@ti.com
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0485fe78e10..2df28d71d75 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -836,6 +836,7 @@ config ARCH_K3
 	select DMA_ADDR_T_64BIT
 	select LTO
 	select SPL_LOAD_FIT if SPL
+	select SPL_USE_TINY_PRINTF_POINTER_SUPPORT if SPL_USE_TINY_PRINTF && DFU && CPU_V7R
 	imply TI_SECURE_DEVICE
 	imply DM_RNG if ARM64
 	imply TEE if ARM64

---
base-commit: cde150b5e15f291618c120e047fd85393123c091
change-id: 20251105-am65_dfu_fix-1144eec06b19

Best regards,
-- 
Anshul Dalal <anshuld@ti.com>

