Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391D5C2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 13:20:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 962D0881D6;
	Tue, 18 Jun 2024 15:20:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RHKF4Cuu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71BE2882ED; Tue, 18 Jun 2024 15:20:46 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B35E87FFB
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 15:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMDON+wbhMEmhUfBwNvVI9A8OnxcniCKfwSdXWNUpsiX2QypQY10CBXIpKtuU+Xi9/K2ZDVEKmGQGRki6+aVkT14ftrl7yEarJq+6cjxCICeUHarOQ3q9MSeksE4jD4imz+LH5U/iTE/g7I95ONYvIa8MdAz93FlnSqtDWeD2I7DgTWe1hSPc9CODP41HgrjX6yx3/rGe07ibTJHhGQ/cXk/XI2meuz4vuvp0pSrt8b4llMxTJuMibQPxKMkgW4agH8IEstYW764xreTLj28q6D9dQoirwQ0/yunvyDhCf6oo8fzenLnxHo1Aau2vyxdXnGtkXpk7SdZbxbFl6KHzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4YuB+7I89obkRQmTi3foIrwW1Mx6KI9snTuZgRVJNg=;
 b=L9Q+E0Nhm/oy+ECYNm/FipAIFE5Fl6R9hM82c6ZdL3Wzyu6zWsimIiaArdrdcWoluK4GtZu3RZcxO+JOtr9X7whzVBYkLZhXor7hDsLwJmuHH9skYmBJlh9MKkhfiafwRz7a5fsEmcxBEL514fW9zahmeHSYZNZsTA9YNvkrjX8xSu5RFlmseO1JWnJ7vEiy7OKGRJhlVysHdrK6vf2AzptHHYrmEhPeRCTCp87JMVlJ5r46RSmVVzbugY3JjuX+TbZv0QQxLZC3VZFU1CK/lUkZKmMM34KsmNQUmkPUE92jP/tHmIKdfV0YKQ9S3mJqquKystHHNEd4uWtNODYI5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4YuB+7I89obkRQmTi3foIrwW1Mx6KI9snTuZgRVJNg=;
 b=RHKF4CuuUn3TDyI1woWakT6qBZAAq7XSFLL+jiF0WPHwFhNgnvOReqF1jC3ICaIJMtDjSljMQo5HNSj0dtxcQXThEjXrIWisGudZMOVs1iTAUofY/KsYGB1UVats3UQV1YSWBmPgJXeAY7pEkgwY1v4faSMBrUTJ9Z2gqGi++Gk=
Received: from PH7P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::25)
 by LV3PR12MB9236.namprd12.prod.outlook.com (2603:10b6:408:1a5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Tue, 18 Jun
 2024 13:20:41 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::7d) by PH7P221CA0011.outlook.office365.com
 (2603:10b6:510:32a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Tue, 18 Jun 2024 13:20:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 13:20:40 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 08:20:39 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH] arm64: versal2: Remove UARTLITE from defconfig
Date: Tue, 18 Jun 2024 15:20:35 +0200
Message-ID: <c9b66495bbdef3fe94467ae43c50a74adaaeacae.1718716833.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=679; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=AKTFoifHpesD2zqIfgmdI6VRxG+GXKE5za80c5qMOe0=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrTCziUVbx7cM6uIcGQU6zWOeVLy47Je7I5j5hzfjul0t
 kaXXnjYEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACaizMQwz0Q9/9rqhOYmuQMW
 q1mUHrM2CPQnMcx3f3N25fGm47Gm28+nfrwjkdPE/WICAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|LV3PR12MB9236:EE_
X-MS-Office365-Filtering-Correlation-Id: d8dc90c7-bd6c-48da-9ab4-08dc8f99737c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|82310400023|1800799021|36860700010|376011; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RMP6h9takPSxuogxrO0RnhyLQ9C1yHicTIqqXT/xbdiYEW5jMIAmMApizuBr?=
 =?us-ascii?Q?voLwnkAM56nQf+nD0wW1F3clmoblsmvaAD5xnyvsYfILusQeD453bsK0AbeC?=
 =?us-ascii?Q?6HbN/i2D8lNvJEk+Dl1tvZHMxNCfaO6qGBZZpVhPSSv9ShuNocK6eREk6e9F?=
 =?us-ascii?Q?OmsxOBFWzDFgMs9wMKx10wzVykM5l7xnb1bhoUIvvQAyol8exkk9atMpxg5i?=
 =?us-ascii?Q?+ipy1+jOqdv2Qb/ql+07q0WUOxHi6Kthl7h9tZjyCpb33XWMULTeyA1V1gs9?=
 =?us-ascii?Q?2suC/XQ3nHYAZWKzIJAstNBVhEe+kqa0gsS6WkXMDIj3KiJ2GwLcimw3Erlu?=
 =?us-ascii?Q?B1iqPwPjAYda9SAJvQdp8ccV61R8CRwr9PdlvCpTmbL97roY8qFk7W5uFQsg?=
 =?us-ascii?Q?/5Ijq45M1o6ubvjltaxZTPfhQJrBTnN2TevwvArAjiX72QJXlP4Yb+nzRRQ1?=
 =?us-ascii?Q?IAy4OoyHj0FioCTMgmJ79IT0/S2+MEn3FGxN8ptlR9XIGN0baWkA+BNKjlRT?=
 =?us-ascii?Q?+dkHrsg5TM6O3/u8FNcqWdeK24jV4fzLbrikD/kL0c0jaizUl1RjAZRpTd2i?=
 =?us-ascii?Q?7BmEjeN/qX2HwCa45EwkrzM8i91kpLXaRn+bnunD28vZ235WU54zR7oI5hbN?=
 =?us-ascii?Q?pa3/ThPc1rxNuSOs0X1U67wmlhmZyc3kVFWUVjJ+TUtDZAnWyCb5r6W/YNjQ?=
 =?us-ascii?Q?NVgy4xfT6eepYq2kYfektQj0bIKlN3yQw+NKpXl5086vSYLWmopU1kKkGKH9?=
 =?us-ascii?Q?1bCUuFeY/yvoaNAUIk30flmhP+seE3AUcLmQwzYiUuJCab5ayswjumBO99CK?=
 =?us-ascii?Q?kvXx3/d1TZxJXH6UUt97Qx4ibjYb/dh08sE+rHHHb2+F3Wg0MlClgG58rR+f?=
 =?us-ascii?Q?yC2x78EDNlEOQi/NZ6chivud30XRlZGK8JsBYqG60h3wPFmKNQsosH9mhp4c?=
 =?us-ascii?Q?9veOg0pU80r5oSfOfwI84n3Alnjs3gj+1hROM6XYXcNpKBo1Og6LsRxypk3C?=
 =?us-ascii?Q?QAoxyPwA1DUHA8Z6VY4pVgYFUQ/k106rotNIaoqc3vZdwp3DV5rNnIDy7iJz?=
 =?us-ascii?Q?anF9Y0/Vpup7Y9xMAphUcEu0I358fAXG6sz522cC3hKI0an0B5K8s6uf+TXH?=
 =?us-ascii?Q?7G4nNk9/uYE2042XqPvL+EVFnWyLUoGlWnBJnR+soyOOCnnfKCkZMkWWrgto?=
 =?us-ascii?Q?B430imNoJHRRJkIVX57rimgq0Q0MytR0n5gSqZyGGL4bDJc7v+yPtx4zrAUm?=
 =?us-ascii?Q?MKZAPnfSP8ssFmMphR5Ge5w4S8RBU8KM1z4psEn5yEfn2ti9iMHoiJlJ6Wi3?=
 =?us-ascii?Q?6e6T2aTAaRqPetBK612sS4Vmc2ATJTLN4M1qjmv6JIGbEj65Ri/FaLzC2NFi?=
 =?us-ascii?Q?vLYbw13PhgCPCRVtkCfVa4F1W5ZJr+w1rPnpy04aYLgSVxRFrQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(82310400023)(1800799021)(36860700010)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 13:20:40.9300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8dc90c7-bd6c-48da-9ab4-08dc8f99737c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9236
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

UARTLITE can be used as console but none is testing it that's why removing
it not to pop up there.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/amd_versal2_virt_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 2d611f84cd93..b071a480b517 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -119,7 +119,6 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_ARM_DCC=y
 CONFIG_PL01X_SERIAL=y
-CONFIG_XILINX_UARTLITE=y
 CONFIG_SOC_DEVICE=y
 CONFIG_SOC_AMD_VERSAL2=y
 CONFIG_SPI=y
-- 
2.43.0

