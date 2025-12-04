Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C95D1F9BC
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 11:12:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D44A83F32;
	Thu,  4 Dec 2025 12:12:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bTJjWyXH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 341D383F32; Thu,  4 Dec 2025 12:12:25 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E19683FA5
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 12:12:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eG9NHMknFktbBZVzShog1vaJ7Vy5fYgPw1Gess5/TzBuFmvefNA24yr1baOo0jhmEvOjl1z4w802DT4luiu3L9Dvb7SExGs8I5DlGT+isXXpDLIadQkwQC6paNm8DRh2DyQ8t55TyrOTGU+jntgmJ/K4XSApHF9jiZ8bKPCXqsk8gDIn3UtkMxANJ+icsOnirVTvAc6T6VyTuNEIgE/tWAREjr3Ih3g2OBWOVKu2fvEx4iwyDJ6NvgGOTMoBYOCCqjCM9vW7sB5Lp6LYYohod6v1emBDX1TebBu+A3AWan0UqSKIJaKu5V2cve5JNrRMPdcokCNWHVP46vX763DJ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQI8MqSGZTjhpJkVYqYPhcYQeY3alEjdb0flmQSdEEE=;
 b=ONM/Ujvcfm4cR8a5cAA+kwXZnIgYsdMaJFkFRPr9CA9Xb9P9brqpPkrDSapJMmO9boqZXEUxxZQUDnwWTmhxu+c66uqJODygqD4CYgINgLgQlB6UR4BnkUUYW/B5MdzIPkUvDEcDXJ1iWKN0ksjnjYuSD5od3ij7cYfA1a8E1R1I6BiUGn70keTY8wnMN6sK2I+QAXPkIXzynQ+jTAZs1zD3WBEZKVb4ap81vsIdGCHCw1GXnbd/4wKobxevKHam+DO8cpOQnjaD/oa2MpcjqY8mQGwmsZg9x/yxP1nToicmkE3Gpw0XGYg8Or0iHG6Ggh+RvaIyLFPclmNQbXSx1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=phytec.de smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQI8MqSGZTjhpJkVYqYPhcYQeY3alEjdb0flmQSdEEE=;
 b=bTJjWyXHZYobdyVNPZfJ298F+2zL1DT3wiRY1T9U0FDuShUcflaIIHlbvRcEE1T3C9NgHRT5FFc7DfcfewUVLHYyMWmQfMK+8qQ5NFozPvelHLyX7ZMWKxhabuM5NOaub++jh5/oQpcpa3lgHnrOfjfVX/TyiiFJ/ejD51XDgZM=
Received: from BN9PR03CA0314.namprd03.prod.outlook.com (2603:10b6:408:112::19)
 by SN7PR10MB6474.namprd10.prod.outlook.com (2603:10b6:806:2a1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 11:12:03 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:112:cafe::76) by BN9PR03CA0314.outlook.office365.com
 (2603:10b6:408:112::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Thu,
 4 Dec 2025 11:12:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 4 Dec 2025 11:12:01 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 05:11:57 -0600
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 05:11:57 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Dec 2025 05:11:57 -0600
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B4BBuhx1464225;
 Thu, 4 Dec 2025 05:11:57 -0600
From: Anshul Dalal <anshuld@ti.com>
Date: Thu, 4 Dec 2025 16:41:55 +0530
Subject: [PATCH next v2] ti: k3: abstract common fdt api for reserved mem
 fixups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251204-fdt_refactor-v2-1-37ad350281e2@ti.com>
X-B4-Tracking: v=1; b=H4sIAHpsMWkC/z2MwQrDIBAFfyXsuQbXRIs99T9KKaJrFRoNaksg5
 N8rPfQ47zGzQ6USqcJl2KHQJ9aYUwdxGsAGk57EousMgguJgs/Mu/Yo5I1tuTDr0aFSZjJ0hq6
 s/YnbL3eDRFuDe199yQtroZD5p7gUAiXXM45STVpqhsykGt4vd21xtHmB4/gC8l46DZ0AAAA=
X-Change-ID: 20251204-fdt_refactor-cf1d166a3ae7
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <joao.goncalves@toradex.com>, Aparna Patra <a-patra@ti.com>, Bryan Brattlof
 <bb@ti.com>, Dhruva Gole <d-gole@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Aniket Limaye
 <a-limaye@ti.com>, Chintan Vankar <c-vankar@ti.com>, Moteen Shah
 <m-shah@ti.com>, Beleswar Padhi <b-padhi@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Daniel Schultz
 <d.schultz@phytec.de>, Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764846715; l=7442;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=I0k8tQYVmIbVumdyle2tHF6JIXsDGduFlWKZs5HsPxA=;
 b=MeQPkfuvVBW7vKCC8hq17xPPWDb/AHr0uNiAdSiY1Uh1cevB3PFgGP+35QfveHSglyzFx0hE3
 ENL6w4fscq5CVNSjtwBbGr/ZjmplnUhXNOe3FU/vihRRYPS1f2Sxk8e
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|SN7PR10MB6474:EE_
X-MS-Office365-Filtering-Correlation-Id: c1241c8b-e17d-487f-f996-08de3325f2ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tm42eUNOYjU4OFdjTlhWM1FzQVZPZjQ3MzNaRUxkazJyUnVSRm9VYjg5VzVO?=
 =?utf-8?B?cm5oaFp6Uy80TFpCMUNnbDlsY21RQUNMQXkyVkRvOU80MkFoT0MrdE1Ld1hj?=
 =?utf-8?B?R1AvS1RYZE5IaTZQa2dNN0N6R3VNaVVvOTIvWUM3RUk2V09ObE9Yb01FM2ZF?=
 =?utf-8?B?WFFFQUdBZHB6c3MrZnUzQ3dGYnQ5ZzhZOGlqblNhMHExdEJIMTBkc1RsL09M?=
 =?utf-8?B?ZHl6eGJaS0hVMlhIQlRqS1JCTTc3RjRnNWsyeWVIZUFxMDBHdjNaQXQxQUJu?=
 =?utf-8?B?RklWNGl6OGdZTjl6cFJJTTRjNGdmeEYzdmpWR2FzMjVERytwejlObjJEVWF4?=
 =?utf-8?B?Yk90QUpwejNyL3JQcGN6UkJHRFhVRy8yU01oQ0xmd2pQS3U3Q3lmZmlhYWNh?=
 =?utf-8?B?MEVPaG9ScVQ4UnZLSDhmUmY0Q1JwVkxFcnhCbERPb0hkblRibG9FN1NLZkhw?=
 =?utf-8?B?WU5IcFYxekhMcUR4NHlkSm5DNnZpcFZyYkhGMm1Nb1U5Vk9Gc2lvZE5SZTRw?=
 =?utf-8?B?blNndHhrUlJJb1BjYzlxOFlpL2s3SHFuOTFoRjN6K1BnYlZKUkVWb01pRUla?=
 =?utf-8?B?SVdpdDVRNXpDUEpwRHA1dkpER2VGeTMxY2tZV1oyVHllRDRJQlFmaSsvOTMx?=
 =?utf-8?B?SVRvZ1RGNU1LS3h6WjRPQWsrek9PSWl4WGFTdmNXVEN3SmU0ZGlHTDFCVUZP?=
 =?utf-8?B?M1E2RG5YM3pYem5NbVJHRFhvUGVDTW5WTE1tclF1Mm12RExWMkNOVDgyZEhw?=
 =?utf-8?B?UGYveFlydUJodzY3amtHZGEyelNVYWU3LzBDLzlmQy9hL0VHaDVjbEdSTTNP?=
 =?utf-8?B?Y0hiUzM3Z1oxNGQ1NmJiTHVnQ1R3OUQ1N2svaFRKZ2g1TGYxWG5uSDd0eUVL?=
 =?utf-8?B?V0Jxd2wxYVdNQ0RjYkQvd1JxeVE1YndHZFpFbmRIT2xjbkJaaFBaNHVDT055?=
 =?utf-8?B?MWdRY1h1WEtMQm45eU5Pbk85L1dvY1I0NVpON0VYdDdkSXYvV2EvcnFXWDhI?=
 =?utf-8?B?OEJ5aUpPbXUzTUlkRFcwbGVmeG4xbUlnNU5UV1h5b1hDZFJLT0E2T3VSZUpo?=
 =?utf-8?B?bzJnT1NLeW40NFJCRlhPOE5VVnBDdWJDY1lhL1lVaFdzaU1UdDZJZjRBc0w3?=
 =?utf-8?B?OGZpMUNMTXg1c290MVdYL0tlKytnZFF2cC90WldvbWpGNVpSdXVHTjZjaE43?=
 =?utf-8?B?M3dWQ3QzVkpZRHlXTkptcXBkcisxYlByMEY5c0paZTd0Tzdva1ZpV0xvdHpF?=
 =?utf-8?B?ZXg5ekplN1laZHUwdWl3cjFKL3V0VFY3OHIvSWFqbk9qcW1YTEdEa0p2cjRS?=
 =?utf-8?B?bTNLTUNPazRPOFBrRGwrYXY0dGtWb0xPeFQrbDF2VkJIMWlJQnFWcURXMWhQ?=
 =?utf-8?B?MVhZWlJPT0ZCTTZvbHQ0V01LOEFnM2RIc2ttRVU5VDcrTWZWWEkwZG1CMTNM?=
 =?utf-8?B?K2I5bUs2czVyQzFVRjJDSjQ4andFNHlHSEpWZERsaHIrVUJWMVZJQUVQQkZN?=
 =?utf-8?B?eGRkVGlpdlhIdHJVOTZVcDdNdnpReTJEWUZMSVlrZTFBdyt0R2xBYm9TemZW?=
 =?utf-8?B?SFlWdEtrV1JYR0hURUJjemVvTmhqTWhsRTl5Q2Zub3VXSGpjTkVEVUZOZGZw?=
 =?utf-8?B?bzl1WFRVNGFTaWxLVDk3cWZJRjFsVllNUWo0ZFhZeTlFMFE0OVBNa2o2NVcx?=
 =?utf-8?B?WkQxbzBkWUlHN2Q4a0xlUmttMy9JWE1KTXErRjA4Z0lYVXVMMy9UZ3JJbExQ?=
 =?utf-8?B?TGsyL3dtMThZWmZHczhzaFNwYVcwMlIvczYxMUVKNTd3VmlJVTd0VXJzdkVl?=
 =?utf-8?B?MmcvSVZXbDB1VTdKOU51d3hsSTE4bGZ4b0wxTGRaL3V3RW1TR1VqUFozU1pS?=
 =?utf-8?B?ZWZNdm0yTFBQMGozTFU4TzROaU9mUjFKM1JKZldCcTIvelZ0Yk5KM3Q5Umlz?=
 =?utf-8?B?QjZpY2hMblo5eDRoVFhtOXlFaVoxcVhhUTVMeEhiRGVJRmNoMExVRnM2bElu?=
 =?utf-8?B?eXRxT0hhUjJqbTAzOXZHY2s3SGlRMFY2QXNjMXpaNFpSY1V0K3JRYWlheW5i?=
 =?utf-8?B?d0F4Y0d6QXhtbWtSY0lOdDdoWkZ4N2Z2MWc1cWlsWlVaVUp6b2NiQkY2eWJ6?=
 =?utf-8?Q?b9ic=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 11:12:01.2424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1241c8b-e17d-487f-f996-08de3325f2ce
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6474
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

The usage of fdt_fixup_reserved is repeated for ATF and OP-TEE for
multiple platforms, this patch creates a single fdt API for fixing up
the reserved-memory node with added error handling.

All k3 platforms already share a common tispl template which ensures
binaries are loaded as per the respective CONFIG_*_LOAD_ADDR. And the
provided new_size for the fixup is overridden by the size from fdt node
anyways. This allows for safe abstraction of the reserved memory fixups
for all current platforms.

fdt_fixup_reserved now abstracts the ATF and OP-TEE fixups by calling
the renamed static fdt_fixup_reserved_memory function with the required
parameters.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Unlike the other fdt_fixup_* APIs such as fdt_fixup_cores_nodes_am625
which can silently fail and still proceed to a successful kernel boot,
the APIs to fix reserved-memory node have to succeed to ensure the kernel
doesn't overwrite the TFA and TEE's memory. Which is why we return an
int instead of void here.
---
Changes in v2:
- Rebase to next
- Minor fix as per reviewer comments
- Link to v1: https://lore.kernel.org/u-boot/20250522150941.563959-1-anshuld@ti.com/
---
 arch/arm/mach-k3/am62ax/am62a7_fdt.c          |  5 +----
 arch/arm/mach-k3/am62px/am62p5_fdt.c          |  4 +---
 arch/arm/mach-k3/am62x/am625_fdt.c            |  4 +---
 arch/arm/mach-k3/common.c                     | 18 ++++++------------
 arch/arm/mach-k3/common_fdt.c                 | 18 ++++++++++++++++--
 arch/arm/mach-k3/include/mach/k3-common-fdt.h |  3 +--
 arch/arm/mach-k3/j722s/j722s_fdt.c            |  5 +----
 7 files changed, 27 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-k3/am62ax/am62a7_fdt.c b/arch/arm/mach-k3/am62ax/am62a7_fdt.c
index c7c5d2f0885..bdc1747fd75 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_fdt.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_fdt.c
@@ -9,8 +9,5 @@
 
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
-	fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
-	fdt_fixup_reserved(blob, "optee", CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
-
-	return 0;
+	return fdt_fixup_reserved(blob);
 }
diff --git a/arch/arm/mach-k3/am62px/am62p5_fdt.c b/arch/arm/mach-k3/am62px/am62p5_fdt.c
index 03f56cfd9fc..68172ae9a5d 100644
--- a/arch/arm/mach-k3/am62px/am62p5_fdt.c
+++ b/arch/arm/mach-k3/am62px/am62p5_fdt.c
@@ -81,8 +81,6 @@ int ft_system_setup(void *blob, struct bd_info *bd)
 	fdt_fixup_canfd_nodes_am62p(blob, k3_has_canfd());
 	fdt_fixup_thermal_critical_trips_k3(blob, k3_get_max_temp());
 	fdt_fixup_thermal_cooling_device_cpus_am62p(blob, k3_get_core_nr());
-	fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
-	fdt_fixup_reserved(blob, "optee", CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
 
-	return 0;
+	return fdt_fixup_reserved(blob);
 }
diff --git a/arch/arm/mach-k3/am62x/am625_fdt.c b/arch/arm/mach-k3/am62x/am625_fdt.c
index e5d95ab7dd1..d666d88b7f4 100644
--- a/arch/arm/mach-k3/am62x/am625_fdt.c
+++ b/arch/arm/mach-k3/am62x/am625_fdt.c
@@ -80,8 +80,6 @@ int ft_system_setup(void *blob, struct bd_info *bd)
 	fdt_fixup_pru_node_am625(blob, k3_has_pru());
 	fdt_fixup_thermal_critical_trips_k3(blob, k3_get_max_temp());
 	fdt_fixup_thermal_cooling_device_cpus_am625(blob, k3_get_core_nr());
-	fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
-	fdt_fixup_reserved(blob, "optee", CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
 
-	return 0;
+	return fdt_fixup_reserved(blob);
 }
diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 8d804f18a1f..0a686efa131 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -273,14 +273,14 @@ void enable_caches(void)
 	if (ret)
 		debug("%s: Failed to setup dram banks\n", __func__);
 
+	ret = fdt_fixup_reserved(fdt);
+	if (ret)
+		printf("%s: Failed to perform reserved-memory fixups (%s)\n",
+		       __func__, fdt_strerror(ret));
+
 	mmu_setup();
 
 	if (CONFIG_K3_ATF_LOAD_ADDR >= CFG_SYS_SDRAM_BASE) {
-		ret = fdt_fixup_reserved(fdt, "tfa", CONFIG_K3_ATF_LOAD_ADDR,
-					 0x80000);
-		if (ret)
-			printf("%s: Failed to perform tfa fixups (%s)\n",
-			       __func__, fdt_strerror(ret));
 		ret = mmu_unmap_reserved_mem("tfa", true);
 		if (ret)
 			printf("%s: Failed to unmap tfa reserved mem (%d)\n",
@@ -288,11 +288,6 @@ void enable_caches(void)
 	}
 
 	if (CONFIG_K3_OPTEE_LOAD_ADDR >= CFG_SYS_SDRAM_BASE) {
-		ret = fdt_fixup_reserved(fdt, "optee",
-					 CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
-		if (ret)
-			printf("%s: Failed to perform optee fixups (%s)\n",
-			       __func__, fdt_strerror(ret));
 		ret = mmu_unmap_reserved_mem("optee", true);
 		if (ret)
 			printf("%s: Failed to unmap optee reserved mem (%d)\n",
@@ -463,8 +458,7 @@ void spl_perform_arch_fixups(struct spl_image_info *spl_image)
 	if (!fdt)
 		return;
 
-	fdt_fixup_reserved(fdt, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
-	fdt_fixup_reserved(fdt, "optee", CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
+	fdt_fixup_reserved(fdt);
 }
 
 void spl_board_prepare_for_boot(void)
diff --git a/arch/arm/mach-k3/common_fdt.c b/arch/arm/mach-k3/common_fdt.c
index 1e6786f6c20..cb0fb8274a5 100644
--- a/arch/arm/mach-k3/common_fdt.c
+++ b/arch/arm/mach-k3/common_fdt.c
@@ -114,8 +114,9 @@ int fdt_del_node_path(void *blob, const char *path)
 	return ret;
 }
 
-int fdt_fixup_reserved(void *blob, const char *name,
-		       unsigned int new_address, unsigned int new_size)
+static int fdt_fixup_reserved_memory(void *blob, const char *name,
+				     unsigned int new_address,
+				     unsigned int new_size)
 {
 	int nodeoffset, subnode;
 	int ret;
@@ -167,6 +168,19 @@ add_carveout:
 	return 0;
 }
 
+int fdt_fixup_reserved(void *blob)
+{
+	int ret;
+
+	ret = fdt_fixup_reserved_memory(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR,
+					0x80000);
+	if (ret)
+		return ret;
+
+	return fdt_fixup_reserved_memory(blob, "optee",
+					 CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
+}
+
 static int fdt_fixup_critical_trips(void *blob, int zoneoffset, int maxc)
 {
 	int node, trip;
diff --git a/arch/arm/mach-k3/include/mach/k3-common-fdt.h b/arch/arm/mach-k3/include/mach/k3-common-fdt.h
index 38a5bb82d95..de4d5d117c5 100644
--- a/arch/arm/mach-k3/include/mach/k3-common-fdt.h
+++ b/arch/arm/mach-k3/include/mach/k3-common-fdt.h
@@ -8,8 +8,7 @@
 
 int fdt_fixup_msmc_ram_k3(void *blob);
 int fdt_del_node_path(void *blob, const char *path);
-int fdt_fixup_reserved(void *blob, const char *name,
-		       unsigned int new_address, unsigned int new_size);
+int fdt_fixup_reserved(void *blob);
 void fdt_fixup_thermal_critical_trips_k3(void *blob, int maxc);
 
 #endif /* _K3_COMMON_FDT_H */
diff --git a/arch/arm/mach-k3/j722s/j722s_fdt.c b/arch/arm/mach-k3/j722s/j722s_fdt.c
index c7c5d2f0885..bdc1747fd75 100644
--- a/arch/arm/mach-k3/j722s/j722s_fdt.c
+++ b/arch/arm/mach-k3/j722s/j722s_fdt.c
@@ -9,8 +9,5 @@
 
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
-	fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
-	fdt_fixup_reserved(blob, "optee", CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
-
-	return 0;
+	return fdt_fixup_reserved(blob);
 }

---
base-commit: d300702c5be5a846032834abe4f01dcd3f50b3a8
change-id: 20251204-fdt_refactor-cf1d166a3ae7

Best regards,
-- 
Anshul Dalal <anshuld@ti.com>

