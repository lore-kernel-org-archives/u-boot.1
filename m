Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AEA6EEB565
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 17:38:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98F9784150;
	Wed, 31 Dec 2025 18:37:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kYKHzHTK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AB5E840DE; Wed, 31 Dec 2025 18:37:12 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE3278414B
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 18:37:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/4KH92VGnjupi86oHelzSSQ6+ZbEXlOY4GkvTDchkpjp1ccp269wqBjliSZwnxKl8jX+SZ+EjlOjus/ANy9jG/kN+T2+wbKix9rDtU8fR5T3wXhHd0AXvXdO456jyCn8Tgh/uMDn4PMhu/fHQjqRVq0KzzyGEkY5jC1x+74ojvJQ90GyqlkIENbY2B85ecXjaIg79L0K6yX7HUs0qu5c7qmxVcxrr6wgGuvFTkimFHt7XFa7bU0NPSYty8P/qujCuyhYqcx0YhVkBG2JHH1qe4Gq+dlpBV9eHoy1tyBFLAjEWbI3336s8CtSH8dm0kelAcUJTLxjqAgUOyS7oq5ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rML/1s5za05i0rDd3hCmihG9CMdHh0HTkLupdstP1J0=;
 b=gMUKDXA+mdwyidlPpjaj8pplgA89j/+GBlMfAV0DhmIavTtfNsNqPG2ie0tS3hoeBn+/F7MTjJiTIKxue7jQGgfx9TSREKk7njPO/dwLGGNBiSux+KkDIMn69cDa7WM1+uOVFEmzN1mnh+y9muM2RfWLZSyj5pKKuJFU+fkw01IIXuBIyHvOvgvFycVHSO+ZT2xcizplwcvaF9oG9D/sL01tzym2O5+giLbk9hGCQX4tI8lEOBXXSBtJqe9oyA+mRL2cLEU7SPKE+eJdhh/96E44pQ2K1Aqxo/+Vbf8FqhcB4sSTHUC0MGi2HXtLq4y72MUWLKBLZ1uCdoJRjXAs/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rML/1s5za05i0rDd3hCmihG9CMdHh0HTkLupdstP1J0=;
 b=kYKHzHTKgF2zzsX8vrZvCA3wiNvV1mB95hyhBWDlL9tC1zfCSyn8vYvk+VvmYxWMj+ceYrqd1gFV26gpFNG2pkZFa4HKNIsk6UTYDezx1mv/O+nhvs4gZD6vhD9GaKFhVo9739ynsFifLSUCHAD6PhE+S3wubrfuUTBeAEBVprY=
Received: from PH7P220CA0055.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::8)
 by SJ0PR10MB4496.namprd10.prod.outlook.com (2603:10b6:a03:2d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 17:37:05 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:510:32b:cafe::c3) by PH7P220CA0055.outlook.office365.com
 (2603:10b6:510:32b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Wed,
 31 Dec 2025 17:37:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Wed, 31 Dec 2025 17:37:04 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 31 Dec
 2025 11:37:02 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 31 Dec
 2025 11:37:02 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 31 Dec 2025 11:37:02 -0600
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BVHaOr12541396;
 Wed, 31 Dec 2025 11:36:59 -0600
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3 10/11] arm: mach-k3: r5: common: Invoke boot of HSM M4 core
Date: Wed, 31 Dec 2025 23:06:20 +0530
Message-ID: <20251231173621.1069988-11-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251231173621.1069988-1-b-padhi@ti.com>
References: <20251231173621.1069988-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|SJ0PR10MB4496:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af51f9a-d604-4ec7-452a-08de489336b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5heWONg8Rtlgaxjdd8475zlidzo3XWb30IeKO4Kzbl8F0RhviAzsFQekh64a?=
 =?us-ascii?Q?wZQIX9qY1o4PruAZVQL4WF8dPpiW2B7H9k/HpBWDiGW5YZWbWdpccdh/SVGW?=
 =?us-ascii?Q?ps9rUb+88CN2rxtHn8+QW/kedTPu1O2YBDsE7YCaRHGjkRGDHE1a5GvYBM2c?=
 =?us-ascii?Q?tyuDLoFAWouseoTl7bOC1MwfsNFPGVpFHqegpXgxtjuD69+ib5Su0eCx2C4u?=
 =?us-ascii?Q?zAjpiKXql8BWAfKUSNxh+zigOvozes8dxBDtx/8oDUDVxQPJOytmfZjKkZ9M?=
 =?us-ascii?Q?Tb8Vu+FMAiS2fvgnQObRvt2jEw0idlY95iI1RcgaliiJT9TGuUdPRpJ6/RkP?=
 =?us-ascii?Q?p89dzTZO3H6LHcKQeZg/dCYW0UxGhZYFyjszC6syN2kyZVZwQWDrJiRcPhKi?=
 =?us-ascii?Q?0ww1f/lwsqF3SA7iarVpg3FNQi/uZsEiwoI47xhs2HBk0zfjZ4IsjqsEf35I?=
 =?us-ascii?Q?OBc+aL2hsP0TzgIELMjqKu6OsKTUDb4KRyCt8NPoonOxRY5tf5JElgsUENQO?=
 =?us-ascii?Q?5ezwDuA58x+aHNgrYCMINLLBRYc6qqLXcChgTabwjf76Sw6MlJsGoJxyquOI?=
 =?us-ascii?Q?KfpIvF/Gy3FcBTif6uJ9b2sRUtRLGVmgUKhUJ1HOsVNN+JdgK0DXPrjRfjIO?=
 =?us-ascii?Q?s5DKQxctaTXiH/IjoZm+rDeTfNXaTx3yxf9Rdy+hYfso3yjAv9315jBGXyHn?=
 =?us-ascii?Q?2PfcRhMe750I0aVEf4SjjpLED7ni8j8PQSp916iwM1wOuacWbkcXnwpwr53Z?=
 =?us-ascii?Q?hMDi7Y7mMODzxgTfesV0UtW88ObJiuMDPCCL0nmSROSd5R6CAtDYrPy8VG5H?=
 =?us-ascii?Q?+q96SAJJy234oqA0qZzfLsec/FQm7dCt/mhOluajqvkb4NUbrDtGSqGFBLJf?=
 =?us-ascii?Q?vrHztA6FeW+osWNCMTWefwmuaZp1P4W1TaRH074d7aSj08FhhlqtYVpxCf3Z?=
 =?us-ascii?Q?NCjp4mZiAOhQeSM+fGInoBNZ/9xUJEEFJsK3GUxjHg4J1NVN7WTJhTi7s8zP?=
 =?us-ascii?Q?aJ4BpJQzEIAvKlQbvcFiqj8R1JU5038BMuzfXbs14EJepMwc3kf2fwXVQO74?=
 =?us-ascii?Q?KrGlvDsQu4ZKjl+L0IvuQAIGmO2HdCF9Q2R6qx9koYkMtft1CF6wX209wQuX?=
 =?us-ascii?Q?CiYfX8w8riPiVp6NsqY/0k3liHvVBlxrBgav490dFQf7WLE2RE54NyBe5aTe?=
 =?us-ascii?Q?TDVkViGgebgJmGfhk3va+O7AiA1X+mYT6WRk0ucYMjT/JzCzzgUdINbwLgrV?=
 =?us-ascii?Q?2nEeB9qvKNhU5tL7SN/KPZ2TLKIbXLmYBuLMGfM7nIXTOWA03ef7bDSDXBPa?=
 =?us-ascii?Q?Hapr576IEEP0ZUNJGwBsDOhuUnlFjDsnKikJKYutS66PWtpszY9p1EECz/6i?=
 =?us-ascii?Q?q43zKI8A64gPdvYCPakhrHeovxZFAoMDmWhHFqa6D0esYW0733qRHR6Jm0ja?=
 =?us-ascii?Q?YkPturAvyYlIFa4aTsFPLb1gcPs/Sfrxby+gPKBiYcHFWKW/mUW08toeLAxy?=
 =?us-ascii?Q?pYjaFs7+ZDpaO6ZGpnv+9vam089sAwBgLJxLgEiIaa5qFtCxuKI+pBGAsatf?=
 =?us-ascii?Q?lsocKuXg67IDPqcgxQ0Do2IBIlVroOaANKSPMy2u?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 17:37:04.8380 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af51f9a-d604-4ec7-452a-08de489336b9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4496
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

The tispl.bin fit image is packed with the HSM firmware image. Populate
the "os" info of the image so that it can be detected and used to load
the HSM core. Further, invoke the load and boot of HSM core at R5 SPL
stage using the remoteprocessor framework.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
v3: Changelog:
1. Use remoteproc framework to boot HSM core.

Link to v2:
https://lore.kernel.org/all/20250506104202.16741-8-b-padhi@ti.com/

v2: Changelog:
1. Hang system boot if HSM firmware failed to boot.
2. __maybe_unused to decrease preprocessor usage.
3. Better error messages with return code.
4. Added Error case in if-elseif-else ladder.

Note:
#define PROC_ID_HSM_M4F seems to have extra tab in the diff/patch.
But when patch gets applied in file, all of them have consistent
tabs.

Link to v1:
https://lore.kernel.org/all/18e01808-499d-4690-995a-45ac5fd727d9@ti.com

 arch/arm/mach-k3/r5/common.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
index da1d1cb7230..51476722b4c 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -28,6 +28,7 @@ enum {
 	IMAGE_ID_TIFSSTUB_HS,
 	IMAGE_ID_TIFSSTUB_FS,
 	IMAGE_ID_TIFSSTUB_GP,
+	IMAGE_ID_HSM,
 	IMAGE_AMT,
 };
 
@@ -40,6 +41,7 @@ static const char *image_os_match[IMAGE_AMT] = {
 	"tifsstub-hs",
 	"tifsstub-fs",
 	"tifsstub-gp",
+	"hsm",
 };
 #endif
 
@@ -158,6 +160,20 @@ void __noreturn jump_to_image(struct spl_image_info *spl_image)
 				     &loadaddr);
 	}
 
+	if (IS_ENABLED(CONFIG_REMOTEPROC_TI_K3_HSM_M4F)) {
+		ret = rproc_load(2, fit_image_info[IMAGE_ID_HSM].load,
+				 fit_image_info[IMAGE_ID_HSM].image_len);
+		if (ret) {
+			panic("Error while loading HSM firmware, ret = %d\n", ret);
+		} else {
+			ret = rproc_start(2);
+			if (ret)
+				panic("Error while starting HSM core\n");
+			else
+				printf("Successfully loaded and started HSM core\n");
+		}
+	}
+
 	/*
 	 * It is assumed that remoteproc device 1 is the corresponding
 	 * Cortex-A core which runs ATF. Make sure DT reflects the same.
-- 
2.34.1

