Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E56BD1F9BC
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 11:12:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E322583FE6;
	Thu,  4 Dec 2025 12:12:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ngMx9Fsa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8207083FE9; Thu,  4 Dec 2025 12:12:55 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02AB483FE6
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 12:12:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DsLP3gyEGLuh2v04mRhJ2R/IbCI4ZLrwYqNooJNSEraBJucoS0psWe2IJUHeOV8uV36ymk4xjZmfC7vuo/BCVOKUSKGlmV956l2EWP6ivYJ7zo4AQKqVDl65iMQ+ueAGOGEAdyhS5Z5Oz8Zs5UjEzoO+8tn9628B0RmR4LFlMjkik3iVQsgb0fpnsa8MH+y9FM/8FfsqmN8UuPu4SH0FF5c2OerXM/MqCW0s20hAOCqenbsrPyQaO809MXSHcWX8O7LLElCNN1HyMCG824PUDywUy0uIcibNdVggcTEgHsjJ04hBIa9U0vDSzsqF0IuB8jDC+ynNf37LNc4itZ0MgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rpqjWK2A6b8ro93MTyyMbS6wjybOE/jZeesMe+y6zU=;
 b=o62z5bLeLWbyJUh/PWRPdIM6PCyhm4YIM74fGRvbSP0QCgu7ppQrnudXvD2CWyToE6irLBcSLRwRQDRbsvOAbdNsgqkyxKtVFtukzcvOEz6POmCG9+BHQYvm96nZT5vbGickogE2iSVsDBUk0mx1HPiX+yL7J6AMwnJPTka8jcA6Yzfm80207mHQnBGpE/L8HABelrYyBCTrh7bXe75lOcwv7H4ePfZryHsETSZ2L63kF2/KCMOKzxJ/J93ZHsYJT1cZLVkbKZjVwFHHiz6yjLSA+7nobEyNKvK9u0/VnJfugHZ3PgDvzTmChGQ/NgeNs3rxsVX6EbKD83xYGjRtcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rpqjWK2A6b8ro93MTyyMbS6wjybOE/jZeesMe+y6zU=;
 b=ngMx9FsaoYqug7Y+YbuQizfNH5tjmF/5rBgVxRpnrnxA0FI95mfvD8tJOkevH7BufCPAN/BwcZVpbPOge03u+xtqyKSIh2OW5riHOjDTnk+Dip2exiPKYA14vhdUDhFaOuFptbPWsTXtMH9guYeSCte8MtC3/YgA/ObEsI1eJmo=
Received: from CH2PR07CA0063.namprd07.prod.outlook.com (2603:10b6:610:5b::37)
 by SJ2PR10MB6992.namprd10.prod.outlook.com (2603:10b6:a03:4ce::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Thu, 4 Dec
 2025 11:12:44 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::c5) by CH2PR07CA0063.outlook.office365.com
 (2603:10b6:610:5b::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Thu, 4
 Dec 2025 11:12:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 4 Dec 2025 11:12:44 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 05:12:43 -0600
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 05:12:42 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Dec 2025 05:12:42 -0600
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B4BCfJu1457499;
 Thu, 4 Dec 2025 05:12:42 -0600
From: Anshul Dalal <anshuld@ti.com>
Date: Thu, 4 Dec 2025 16:42:40 +0530
Subject: [PATCH next v3] Kconfig: select
 SPL_USE_TINY_PRINTF_POINTER_SUPPORT for K3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251204-am65_dfu_fix-v3-1-de18ed3f346d@ti.com>
X-B4-Tracking: v=1; b=H4sIAKdsMWkC/32NwQrCMBBEf0X2bKQb22A8+R8iJW62dg9tJamhU
 vrvhhw8iceZ4b1ZIXIQjnDerRA4SZRpzOG43wH1bnywEp8z6Eo3iFWj3GCa1nevtpNFIdY1M1X
 mjhYy8gyc66K7wsjLDLfc9hLnKbzLR8Ky/dYlVKgckbaI6Im6yywHmoZiSfofqTNJ5Lw7WW+N8
 V9y27YPQNfFlOUAAAA=
X-Change-ID: 20251105-am65_dfu_fix-1144eec06b19
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Andrew Davis <afd@ti.com>, Judith Mendez
 <jm@ti.com>, Udit Kumar <u-kumar1@ti.com>, Hrushikesh Salunke
 <h-salunke@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Vignesh R
 <vigneshr@ti.com>, Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764846761; l=1583;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=QPGK41l+PeKVfKtFzOiQE/diMKiOqXKOzJbiohyuvQU=;
 b=5MM34m8M+GaPVb5jBj2JVqudLiD1C5v+ZRNa3dXLQsMg6mhfMaey/OPWZtP07ZKVdjsP0AvC5
 gJh/sD9UdGxBG6/641BNJTWrY9glxCLylKdvJZWH4pfgsHvO31EP8j7
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|SJ2PR10MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: f589c47b-51de-4edc-dca1-08de33260c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d09aZ3VDNjlqTE5pdE1hejNIK0FUMFJzS3RMOEg1OWxKbFIwQ1dmSUFGQklI?=
 =?utf-8?B?RFhhTzNSYVcyQ1ZhU3JUcEpXNmxZS1dHWStHcEtwS3d4UkVGYUZHeW9oWHNQ?=
 =?utf-8?B?R05YY1BEZ0NrK1c1anRxN2oycUpidGN5NjYzZmhMdWtaazE5L2lHZlNBOFU5?=
 =?utf-8?B?NXlCMTJkdUJ0b1huUGFEU1l1R0I1MzRWSHF6WGE5dFk5SVV2cWYxYm81Q2Fq?=
 =?utf-8?B?eFIyaDFrNWV4Q01vTXd1UjgvL3V2b3NvZU1yNG5NR1NmTkFNR1pUanNaWkRz?=
 =?utf-8?B?bHZ4a25iTmhodnFwdC9OL0lKaStiKzZFLzNNdnBqZjBLR2x4cUZjc3p3VGtV?=
 =?utf-8?B?YUZtYXVaamV3eWl1WHRjcUNwREJGbE1XdXE1R0lPYXVRRHBsQ1c3WXgzclYy?=
 =?utf-8?B?dy9GdkxFaFdLUTNQdXJSSWtWVDdFd0ZXL3FvOXBHQWh3eWJ5TnNnT3g0dDF6?=
 =?utf-8?B?d2NDc3dEUjluZ3ZEQnNZaGZ1ZERaV3VOOHJZTnFrTzFEK0VhcHIrWit2QStT?=
 =?utf-8?B?UFcwK1Q3aFVSOXVGME1SdjRVanpuVFdlNDRiNlNLNThDYmVmNmRlSUdBR0xI?=
 =?utf-8?B?N1hyTlZRaUxRMGtMQU9JazI3eTNrOExXMmNBemwrRmNiVktQK3BiU1J2K2Z0?=
 =?utf-8?B?cEFPandrODlGNmN1MThsVFlIdFhhWGEwbUp6R1NpM014WnN5eE1XVUNtMnhl?=
 =?utf-8?B?NkxTVlFZSXpwMC9yOGhra2VzM3pCdFhHbFQvc2pHUkp1STU2NFVFaXBhTkhl?=
 =?utf-8?B?S0JCR0s1c1pPb3VWRVZ1dUExWWVnK3VMbVZENXZTY081ZzlEQm1DSnNpc2Js?=
 =?utf-8?B?bzZaNEQ4b1MwTzlaL1AvRXFWaTBQUkNJa3NOeW5LbklQaXErakRUS3Vlb1dB?=
 =?utf-8?B?RzFxb0tvVS8zclFyQ1lORzRObEZ6VkhDQkdYclJ4WnNBb2lDcy95enFSdmlu?=
 =?utf-8?B?bVlRRkhJbThPdVhxaTg5WHFaME1pekVJaFcwd0Fwd3E3Ylk1WVozc2kxVEls?=
 =?utf-8?B?c2lIZXM4eGJZNTExcklERmJMekRkZExORXdNZG9URDlmaWtiR3MvdEZEaXVD?=
 =?utf-8?B?SlIxbjhLWk9xRE90R1JORWxOa29ISU93ZlpZb0N0Y3JpakVYamNUWjlKelZP?=
 =?utf-8?B?MkJiYUw1eU84bmhXM1ozR1RRVXVaS2xhczRFblVQc2lRVVcyeWlQR3RsK3Fx?=
 =?utf-8?B?OEw1dW1Xc1dvdXJyYWR0TkhTVHVYalBrb3FEMlYzdHVMR2pkVnNoWUZoZXg1?=
 =?utf-8?B?UHMrMk84TVNMTGI0QlpXMmNBdzJRckNyWGdGOHdQYVd0WldGd01DTWpkNUI4?=
 =?utf-8?B?ZVlSWWgvc0JRc2tiSkFsMDJrMUExTnZSemwrdS9DOVhDUG9UU0JJcHVObEJq?=
 =?utf-8?B?N2JxdDQzUS8za1Azc3l4ZzJSVlZ6dXNzdXEzbm5raEdzVmVPYW5XZTV5MUVS?=
 =?utf-8?B?WVFxZWxza2RELzhBV0FzeDdscWovSmhydEJvVDRJV3Zjc3hzbCtvTzhreWk5?=
 =?utf-8?B?dlB4VVNTMjhEeXBac2N4ZzlXbkRCMkY1cGc4MkpjZW8rVEpzclZWRHNjalU2?=
 =?utf-8?B?WFBzcmxoM2pzUWxha0JnS3JDRGlzeWp0NE1vbkpzcGdKOStDRFdMRms3OHNh?=
 =?utf-8?B?Y3ZSWm42d1pJNzJNaHZVVEI2K0FjMVJRN2xNdWtDZUg2WUF6Z1VTK1JsYzdL?=
 =?utf-8?B?ODVPRjZCanBwK0E1c0pOMURqaGhYNkJpWTdzMmxFcXRacS9heW1MUE56Y0ww?=
 =?utf-8?B?ZnBIR2wyZHJMQlR4NmJvSXBkcVI2SGpxbFVYZ1RaNFJPUVRKWi9RNVJ4K0ZU?=
 =?utf-8?B?NGxaaGRRSHNtK2d5WFc0a2l3ZWlJYjg2YnA4YTFncnlGR1JsZkFLL2VISGZk?=
 =?utf-8?B?ejB2WUsyTFYvRVdjNFovWDlNTGJORk9MT2dqdVVKdTUzUEhsbndLNkdDY2hT?=
 =?utf-8?B?NHAyRmUwODJGNmRVQXlLWTN5S2VSVVhFZkc4cENQUGZHcHNxeTh0ZERvdmMy?=
 =?utf-8?B?eGJ6Y3cyYjNubDF3Q1RtVlZ3WlNPSGRTMnpwNXZzKy82S0dxL3dBQWVxUkhW?=
 =?utf-8?B?YUcrQk9RRUpwWVdxWmZteDBjSUpTdERQSjdCQ2VjbVZoSHgxN21obVpoaTdz?=
 =?utf-8?Q?KCnk=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 11:12:44.1922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f589c47b-51de-4edc-dca1-08de33260c60
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6992
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
index 3db5474a05b..7756ed000b1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -830,6 +830,7 @@ config ARCH_K3
 	bool "Texas Instruments' K3 Architecture"
 	select SPL
 	select SUPPORT_SPL
+	select SPL_USE_TINY_PRINTF_POINTER_SUPPORT
 	select FIT
 	select REGEX
 	select FIT_SIGNATURE if ARM64

---
base-commit: dca19206acf2af2d339087bb62aa0b8ee1b0e326
change-id: 20251105-am65_dfu_fix-1144eec06b19

Best regards,
-- 
Anshul Dalal <anshuld@ti.com>

