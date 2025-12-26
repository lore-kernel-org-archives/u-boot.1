Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BE3E8FDB8
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 23:03:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1850B83A83;
	Sat, 27 Dec 2025 00:03:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VPBQyk3F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23D7F83A94; Sat, 27 Dec 2025 00:03:36 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B18C3839F1
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 00:03:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v382iEqxsh+bIGxEOEGC5jBJCtAmjKd3XocJFxcFWr/61t/ePwjJ+dNNQu88gIQBwBZ72q0vkSpBePg4cFfr7tNQEOIBkmtNFAW9y6fLxmAOE5wHDQbjPNGZznj/A1MTZUAepLao33uwH1uBHBn3uNWwvrZ0+Wo2QYQptF4UNzsw1QVOiJngS5u8FWUfh36Tv48V3SiIFA9XTqGnkW36Nu0To4+N21s+5WyOcwobGorfslXofPxWG7Za15pqZ2KOfxV4BS6oUwgjxWsyKFKLAolCRgdFcQSrundonPpuKbdHa6jn+48HB2Nppw4lUM2Rsp45u9kPIpYArPLtdGo3tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQ+VJmYZ53L40kPQorizibeeMRfHF0MmLC2hZdaHEZM=;
 b=tdq9FPkmIG+aeINstOZagwkGFh1xWmTpw4vNAxJ/4aCo+RPSjpodJzfnnOHH9ZvpP+PLx50h4WSJoiU2mxHMOeT3Nd3s8ZZqPcUgJKDBkdLIE4ztp0CcCBj0B8tzJzsJJ6xXd4uOBo7tjNeoEnaSEkNkoxMqCnCk+WwWyNT8ilgGlaWeEaq6nd50MRh4PRP8i7FwWpn6SAxFRRPG9OcmVDOEXGQtgVGESKUNxgdJvWzPXZE4KRmksekHDlefNRxY09eLeIJQZo1DEn7SyXqk56CZ8/z2JQtaDqtcbBurAQn4iAzgSEWHQ8zoQDEGKOZW8F2njb8zh8gOjlJTY8uLOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQ+VJmYZ53L40kPQorizibeeMRfHF0MmLC2hZdaHEZM=;
 b=VPBQyk3F79lOuH5VBzlBgpj519Keu1iUlw8khjS3eETWnUpM6QdXameeJGZ72s5xicvtLAmzreNPNVoKJwh0H7EfA79K5giY76CT0kd/f85q+cZ5f8hti16xskyWfcGJYI2BDZ4FFLnXj0ZsqLVjCclXmnXYckmECwmxxhrFesk=
Received: from CH3P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::34)
 by DS3PR10MB997724.namprd10.prod.outlook.com (2603:10b6:8:346::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Fri, 26 Dec
 2025 23:03:30 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::d3) by CH3P221CA0014.outlook.office365.com
 (2603:10b6:610:1e7::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.12 via Frontend Transport; Fri,
 26 Dec 2025 23:03:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Fri, 26 Dec 2025 23:03:30 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 26 Dec
 2025 17:03:29 -0600
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 26 Dec
 2025 17:03:28 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 26 Dec 2025 17:03:28 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BQN3S0v4027943;
 Fri, 26 Dec 2025 17:03:28 -0600
From: Bryan Brattlof <bb@ti.com>
Date: Fri, 26 Dec 2025 17:03:26 -0600
Subject: [PATCH] configs: am62[ap]x_evm_r5: enable SUPPORT_EMMC_BOOT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251226-emmc-boot-fix-v1-1-417959ba4e9a@ti.com>
X-B4-Tracking: v=1; b=H4sIAD0UT2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIyMz3dTc3GTdpPz8Et20zApdY3MD0xQj88Rkc0tjJaCegqJUoDDYvOj
 Y2loAOQp2q18AAAA=
X-Change-ID: 20251226-emmc-boot-fix-3705d27ac793
To: Anshul Dalal <anshuld@ti.com>, <u-boot@lists.denx.de>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>,
 Judith Mendez <jm@ti.com>, Santhosh Kumar K <s-k6@ti.com>, Sam Protsenko
 <semen.protsenko@linaro.org>, Andrew Davis <afd@ti.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>, "Bryan
 Brattlof" <bb@ti.com>
X-Mailer: b4 0.14.2
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|DS3PR10MB997724:EE_
X-MS-Office365-Filtering-Correlation-Id: 98edeb1f-2aa7-4940-3a70-08de44d2fccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VysxYlJjMTMzVWtKSm9qYlpSSmlZTURpWi9OUVpFb3lPRkFuZGNTVVNobzJp?=
 =?utf-8?B?L0k4eUdTazRQY2dobFlJK1NaTHEyU056b1JLMHBISDZFZVEvdVJpVFgwaTlV?=
 =?utf-8?B?Ull0eFFJaWxZbGw1ZW9DQWJ4d05ZUXZQMmVXbWhGUVJ4UHJneGpSVWFmSi9v?=
 =?utf-8?B?aWtPTGpBRHZqc080Nm9KOUpOUjlZamI1ZWd3aENCU3NhTk1GZ1JzaVJaREJp?=
 =?utf-8?B?bjQzREVJZis5eFU4QnhkelQ1YjVZY0trNmEyaEZYVEpuVStKcWxBSlFmQTY1?=
 =?utf-8?B?YlM4WUlrbUU5Ri9kcVlJeGhhRm9Lc1NudVQxTzJYb1hxdEg1eVJDR0ZZQ1hs?=
 =?utf-8?B?bTRKZitwT3p5VHpJZGkrT3JyR29lZDlNSjhvYmd3d2szeGUxUVo3aHZZWjF5?=
 =?utf-8?B?T09qanhlNWtVUE9oalR3ak9Qc2ExZ1pmeDdxeHc1NUxOYzFIRWY5ajIvZ283?=
 =?utf-8?B?ZmJIK2N3Ukl6UVkzY2gxNnhNNTBtWGkwd2JXaVhBTWJYMEFqYjRoUzBHWnBE?=
 =?utf-8?B?UU5KMWJhd1lnazhsdlVnNXRRUzNUZ0NLbUJVZXY1bHR4MGcwUC9aOU92KzF4?=
 =?utf-8?B?aldYU2VPS0ZYM0NQaEFneHBNL2hoU1FvM0U3M25rL0xUZkRZcE44K0F3SStR?=
 =?utf-8?B?cHR0ZUFlRUh6Wk85dnJyM0ZWWkVORnpjUjFPK3plQUdnalJVcjErYmJCTjBi?=
 =?utf-8?B?aVo1NWt0TmlvOGdqQjVZbktKaHhkM1g3MXZsU05QbHhBWlErNTA5eG9ieERi?=
 =?utf-8?B?SExRTm9kU1ZWaTI1SlBTdlFhTXMzS0FDQjlyN2o3WDdHWWRqaXkwblpKSnhU?=
 =?utf-8?B?TjRKN3pESFFaNXhuRmVNNFd5MkcrN1ZHQnpHUEVRSmpUWXhJbVVtNlIyZVhW?=
 =?utf-8?B?M1RRRlN6NlZ4bjFoT1ZvZTlWc1V4WXBaZFZhSXNOWnJkZFZPUGJIdHNtTCsz?=
 =?utf-8?B?bGswT2xQdUlMdTc5dXhWclIrSlpNTjBlL3BxZ2NWbkFKaFBCbGFBcnZBajZJ?=
 =?utf-8?B?WkowcmtLSm9KVGFOdjdLcnJ1ZzhnY2xUMWd0ZjFBMTA0eXl4R2p4djVLL1FW?=
 =?utf-8?B?a0xIcU9VeGgza1FaM3lpN2ZPeDFRbHBWQ3VKOW12TWZiMVZFcXQzRVN4UjI4?=
 =?utf-8?B?NmFNVnp2eWpTL2JzMXZtUUp2Yy9FUG9VMmtDd3VoelhGS041WW9WTzBsV3Jy?=
 =?utf-8?B?NG5mVVJBTjhCVTZmUE1TRzRxRXE3eXUxMERTVHVPOXlkdUcranh1Mi9ORjlV?=
 =?utf-8?B?QnYzYTNXRVMzRFJyWDc4VjcrLzQ5azdRTFNNU0MwU1JRbFBmWDZBaFYyWHFY?=
 =?utf-8?B?TnpXOFYyNG54RVZHTDE3WkVlNUNkczREWUxRak9yQzhjY3RaSEdGZzN1c1Rt?=
 =?utf-8?B?VjZYSG5rcFBEVnREOUZsOTdsdVp0T3dIMWx2M3NXZnNndzJ6NFBFdythd2F3?=
 =?utf-8?B?QTIxUkgyQ3RnNUx2NWV6TTlVbGJ2M2prMkkxT2M5R2pBcXNkVHFaUUE5THIw?=
 =?utf-8?B?TDRHUFFzOTY2Uzh3WEF0N2JMdE01clBwTG1TWWtQUW8yNVExVENZQ05QN3pO?=
 =?utf-8?B?SHB5SzRIL3ZiaWxSeHBMd3UzeE1kaGw0VzFIY2hlVXZjZ2ZON0hWbmxkZ0w5?=
 =?utf-8?B?eVhrY2pwNXh1cHc2a1FRRFJ5Wjc3cFo2b2VYRGI3QnVtclRxQWZKOW5GMUl6?=
 =?utf-8?B?QUhDL05qb3hrTkhUWjhUTXFJMHZCY1FqV3lTVml6bUc2bzN0OThUZGR0NnpY?=
 =?utf-8?B?WlJjTndGNkF4U3VEbVRKaWJYOG9oWWo0NGV0MEZoZlBmRGJpb1RSMkxGckZK?=
 =?utf-8?B?VmdXMEpudWx0MkJHWFplb2ZHanVRYjdYaWJxUS9raTdBK2thWXJqTHNXMm5M?=
 =?utf-8?B?UTRhRUtIK2YwRnFpWDRnNjNNS3JnK3FLOGhFbFpyb1FyT2RXVjd1TWt5ODFW?=
 =?utf-8?B?bDZndUlkZ2krL3BSL1B1aHVaaEJHTDUydzJaR1g2NlBZRXlVdkFoOFAwa0gr?=
 =?utf-8?B?UGxJWDlDTnVQMks5LzVqRlJJZ3RmYmd3c0pMQVFBSkZ6Sk15K1EyTmlmc1Z5?=
 =?utf-8?B?c1ROOEorWkZyWWhoOTc2azc1WDNSZklGbFZZcGFtSWU2ZXlSZUJQU2xreE9h?=
 =?utf-8?Q?aPrA=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2025 23:03:30.7595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98edeb1f-2aa7-4940-3a70-08de44d2fccc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR10MB997724
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

When unifying the SD/eMMC boot behavior between the different AM62*
reference boards we missed enabling SUPPORT_EMMC_BOOT. This causes the
SPL in tiboot3.bin to look for the tispl.bin in the UDA partition in the
eMMC and fail.

Enable SUPPORT_EMMC_BOOT at the tiboot3 stage to load the next boot
binary from the active boot partition when in RAW MMC boot modes.

Fixes: 3b7893145e36 ("mach-k3: add eMMC FS boot support for am62[ap]")
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 configs/am62ax_evm_r5_defconfig | 1 +
 configs/am62px_evm_r5_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/am62ax_evm_r5_defconfig b/configs/am62ax_evm_r5_defconfig
index 64886986c4264a5d9272228e468f7057c195593a..68442947be2620cc7588503c32d40c532b42ffa3 100644
--- a/configs/am62ax_evm_r5_defconfig
+++ b/configs/am62ax_evm_r5_defconfig
@@ -82,6 +82,7 @@ CONFIG_SYS_I2C_OMAP24XX=y
 CONFIG_DM_MAILBOX=y
 CONFIG_K3_SEC_PROXY=y
 CONFIG_ESM_K3=y
+CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_SPL_MMC_SDHCI_ADMA=y
diff --git a/configs/am62px_evm_r5_defconfig b/configs/am62px_evm_r5_defconfig
index c9592d7b6c4cc037a886fe81385791269a825aa3..cf4282eac02d4381215f59285a2e0a89ba129e75 100644
--- a/configs/am62px_evm_r5_defconfig
+++ b/configs/am62px_evm_r5_defconfig
@@ -87,6 +87,7 @@ CONFIG_SYS_I2C_OMAP24XX=y
 CONFIG_DM_MAILBOX=y
 CONFIG_K3_SEC_PROXY=y
 CONFIG_ESM_K3=y
+CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y

---
base-commit: 56cac250b0839ddbad1311d3ca4231f532b5aadf
change-id: 20251226-emmc-boot-fix-3705d27ac793

Best regards,
-- 
Bryan Brattlof <bb@ti.com>

