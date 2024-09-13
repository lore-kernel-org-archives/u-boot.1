Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C52FA3736
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 09:30:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0798088A0D;
	Fri, 13 Sep 2024 11:29:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tlTNQAmS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC73B887FA; Fri, 13 Sep 2024 11:29:33 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::628])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A79388AA7
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:29:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqWML+3TIaUDNuZ//O7vYVDN+kN2dC75Ovn2tf77li05EnyNVB166O2tyo7Pe2HFveusaRNRdxA+5yZD4VElbsLhJZs1Ys9+D8Vsv8uJZcaDE3Vxg9t9W08oPscSWBLIbKsu474QnJdkBwIPln1t42TbwWu3L7baxI4x6JBxrlz/vToVN1L+NEHdlG8E1KETbA8OMBwNYT6F+2x13joUnif9l3id6so0PkLu1SsN0Pwk0cs0wPv+B5NY6zVOcHm7M+SvFhZMiedbbTqHvGe3kGDhG93pPrbiPr5MQbA2K+vCfGfXfBXu0qfq9Y4v3Hyx8trwXAKKjdsDVHLf1F0U+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJfPER67zgcRGYJKYNAnAq2IVkxhHhy32rvNe/deeQM=;
 b=R0zqVLVffyighPlcr6JhpE4xP/1TZliMHBQBMBw+AZbBfw62dlzFAFXN8ojcQFyv5Pgq5GF3L12zT3dipcMEdGrN3GUbQeWV3I+yvGr6CStx2PUkwP/FkB3z+OKZfqMY8Vh0DUQ05EiehlRjzdTkrkD4CpDR7/cSTQYYfEu3F4r9vi/5DnHSUV1DehWBMAp4Q9EaspbaB4+QslYsAcDN9p49V28TqJ/lrI/+H0D+t0Gy4iqKMZywrEyk3PeKcB5vQXvbtepmsDEXdaoI9FwSqEOOqqGgNHIpLVjjiKJ39LFl1eTD5Vowgg718d9DISxi56k4K/qrVwnKb/+ny9HESA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJfPER67zgcRGYJKYNAnAq2IVkxhHhy32rvNe/deeQM=;
 b=tlTNQAmS7TI476PaSjes1As+W7TC2CnLK3BgCZL0G+C6ehJqNHHMXA6+A0MVqbEB7tUjYtsvv7V2lwfBBZmFqd0OS9gCSRilmxlYjPUqBr9HtN84dTqwY1jO94Dhy1i0/pvDt2Zq5ugDlOw8FqXb/h8XBaA9UBBEqBgfLtSuYys=
Received: from SN6PR05CA0022.namprd05.prod.outlook.com (2603:10b6:805:de::35)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 09:29:27 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:805:de:cafe::93) by SN6PR05CA0022.outlook.office365.com
 (2603:10b6:805:de::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Fri, 13 Sep 2024 09:29:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 09:29:27 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 04:29:24 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/10] arm64: zynqmp: fix i2c mux bus description for m-a2197
 platforms
Date: Fri, 13 Sep 2024 11:28:47 +0200
Message-ID: <f28ff644fd2c6bdf5f2e646f6bc0e1ad0c92e8be.1726219714.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726219714.git.michal.simek@amd.com>
References: <cover.1726219714.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1742; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=kbYYw9ud87x2TIaJ3rMvIWBE0/OWwsNXOu6Wc62uEuc=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrQnrGcFK+9cmX18zcSWbwwPOxyau4x2fIvoc8m5/jhi2
 scpDp8PdcSyMAgyMciKKbJI21w5s7dyxhThi4flYOawMoEMYeDiFICJ7PdjmGccuOr9bJu7+0+q
 PJnHf8vJRfDJwUcM8wx0/DYf3JUSsI3fakGHcrnPHt+XoQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|SA0PR12MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: d7f115eb-2ca0-490f-c1ca-08dcd3d6901e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9Y91H9/QY6YMV2lvKD7RxdunCzgkCUxf0rzHD5xscuQhE0LXbWNrRAIOjy4x?=
 =?us-ascii?Q?F5Sb7h3YefLLLdgjV6FXAF52fQE8k6cZ7i1rH5cRD97ExfM5lyqKbmQeHmA+?=
 =?us-ascii?Q?jKHglCERYHXZnWkPeayaPku9R3RqVQVdcAkmL7EmuUmcVDfxSgwGDsnbx1B9?=
 =?us-ascii?Q?lY88cWEA5jR8GJXzulkVTHGZbvUsCjvpK0ZRwDcchjwE9AacPveQ/3X38Bl1?=
 =?us-ascii?Q?ALPPkt1n/H8QGplK4nrB6RzpsiXAxOrydYCFcOnp+MaTLEPaMHxvY0RdI+qC?=
 =?us-ascii?Q?vAGGmN9O6TNMDGBb/c2I4ZWnI307kswhBlv9BXBeTufIKRJhuyndUzyhxZH9?=
 =?us-ascii?Q?1VY0EU0+EWvfLXgAFcMEjrQ1Hp1UMjO54h2dK+nj66hGHCAEFuIiOEYFkVVM?=
 =?us-ascii?Q?ydYMVocuz8KF/KigkL12z6O7e7bBskmHoZqvrNXWr97h6Axlok4eab+rdfMr?=
 =?us-ascii?Q?T/klqRHEkNbDhdP5Rfi4pMo9eOFbkJC0gfVsPQHYTp2dgOoJMa/rFp0Ja01o?=
 =?us-ascii?Q?tB6LLyHt9rT/t4govU4ajVF+TiQQjpEpiuZuo8hOCU/MJTYDrkO5ZEBbKPye?=
 =?us-ascii?Q?aJBZfEsL4Zmzf4qPSv231QlGQH9OETGz1YwKSdpbaLnXHFbdDVc5Ced8NBoc?=
 =?us-ascii?Q?9svs4GhbLwCeP47I4aihzxy6sVwMNvOCZ+82WBfsJ35havHwkeJwQ54whmfY?=
 =?us-ascii?Q?3DnoQ5bD2FNEfo9YLzIlG4BMo5gsIvHltiHgjwWrR30hjsOY5roragBka8vu?=
 =?us-ascii?Q?NRmwqS5hEtzY9m7eZ4tr0pPpXAB/g9uipGa3GOWVDBBQw2IbybrjpCIMImIZ?=
 =?us-ascii?Q?bRpzPRGjYuCl1lfSh5wUrTvuMEP++xgYK0nvfdd8gYwmzL6WrOhWfyMypnYp?=
 =?us-ascii?Q?7jzI9D69i1rqAFQxZvm2OYSKBdZuesVhYVJL0PBLvtmlB8kCp8cOJAu9kN2x?=
 =?us-ascii?Q?A5BoMFZ/mvwtYn9q/ErnjCBTz71xSmT1L2Hd+5YFxLvdSQHX+Rop+iuF6u4d?=
 =?us-ascii?Q?fW3t7TdHhhkweKOm9sP5cgVnVCqxIyHBWhHMyTBfiDhrV3BsXw2CnvIUPoW4?=
 =?us-ascii?Q?HZAGA0bejN6eerDVIQoUWpG0PmVEFCB4q+DuBsZdhz/NR4gcy/ehbsyi0XFF?=
 =?us-ascii?Q?EReTmIpnhg3XWR1AWr0xmfgs8c3z4G5kpGsPv9M1++ik7y/N9ipI0yDwKNX2?=
 =?us-ascii?Q?s52A7UUPczcozhr0PEjCD0cKnjiZxB+rCTMlKXVOQsUEqQk3l3Sus/hjtJxW?=
 =?us-ascii?Q?Niik6advYofkxvlx4VRvI+6By6T87hhlQ3wpfoSYA1r08sGkCc/lLEHaVnPC?=
 =?us-ascii?Q?bxMgj3ztjDFfEHIkMl71SWiUvhHtZipOkJe5ZnGIiTPMOjQf/MYEbZCkzo3b?=
 =?us-ascii?Q?cTh5nHfSz/IimrZFHDDuKO8x488Oqly1htkvDOIWVCFJt6JQEUI0rQ3GL3pQ?=
 =?us-ascii?Q?x4988+yBUTokcrFgFfb+xK2NTwDHTBYE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 09:29:27.3383 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f115eb-2ca0-490f-c1ca-08dcd3d6901e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446
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

Uncomment reg property for bus 3 in i2c mux. It is better option than
removing the whole node.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-m-a2197-01-revA.dts | 2 +-
 arch/arm/dts/zynqmp-m-a2197-02-revA.dts | 2 +-
 arch/arm/dts/zynqmp-m-a2197-03-revA.dts | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/zynqmp-m-a2197-01-revA.dts b/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
index adffd9e78607..d6cd193a4490 100644
--- a/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
@@ -300,7 +300,7 @@
 		i2c@3 { /* MEM PMBUS - FIXME bug in schematics */
 			#address-cells = <1>;
 			#size-cells = <0>;
-			/* reg = <3>; */
+			reg = <3>;
 		};
 		i2c@4 { /* LP_I2C_SM */
 			#address-cells = <1>;
diff --git a/arch/arm/dts/zynqmp-m-a2197-02-revA.dts b/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
index b679efa4a35e..902fdd4de6cc 100644
--- a/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
@@ -288,7 +288,7 @@
 		i2c@3 { /* MEM PMBUS - FIXME bug in schematics */
 			#address-cells = <1>;
 			#size-cells = <0>;
-			/* reg = <3>; */
+			reg = <3>;
 		};
 		i2c@4 { /* LP_I2C_SM */
 			#address-cells = <1>;
diff --git a/arch/arm/dts/zynqmp-m-a2197-03-revA.dts b/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
index b2d477e6d052..f3994bca4a08 100644
--- a/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
@@ -292,7 +292,7 @@
 		i2c@3 { /* MEM PMBUS - FIXME bug in schematics */
 			#address-cells = <1>;
 			#size-cells = <0>;
-			/* reg = <3>; */
+			reg = <3>;
 		};
 		i2c@4 { /* LP_I2C_SM */
 			#address-cells = <1>;
-- 
2.43.0

