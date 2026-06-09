Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3429CD8CAC
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 07:48:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07C6A8484C;
	Tue,  9 Jun 2026 09:48:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BOR5DdQc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D337839A8; Tue,  9 Jun 2026 09:48:45 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 788638405A
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 09:48:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQV3mHe2WY+Jrok5rW8yLtq52cDh5pdGh2KWnLtwh+jpcpeHOiXjlcxB77cizZZLUTITiJ+AQ26GgUz9LjKazDsNCS+wlcz6/Qa1i4pQUfbQnD8sC26pqCvx67o1U/YS2KjtgmJc6QcGfRL4FOIa8sSdBR4fovanAGUJwhJK+xnACOWDUZvqzC0Ca8a42nszYI/3/8HLC5KgIM5S9tVsKwdrTHhNdydWJr4XIdtWpvs9a84bVYo/nvxLlewpYIqysLmw3bbBInstyepLMIVGq1JZVPg6iZJjliC1nMaeJ52bzkufNWBOdswLkGnkR4LZRx1epsWi8EIJq7k9a6ndQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rucPhJuAF1diZm/LPE14bPKpswPmIFN/luXAAy8/rVM=;
 b=lvKMH8Gu9zTigoBAGbglvb+bcksT1T7993P572UJ9PsC7sTNBfA+7Kge8IWDQf7F/4yWV6f6ksB1zJEX5YhcUeDy1CJWqakUAMSA6RG80z57HnMBSq0OXplZ5m/H+CEH08a/NiN6FyzMAsjl8kuXE578tH1PIFysn2Sp7oYgoueksoPLQ6s52JskZINWO+rDFzVd4a86xaAxLCa4g/iYdXiPAOFwcTAp198kVGbooV2ty7Uf+ihGAPdqK69okbK+sTRRwMinX9Xj1vx5q9qiBSRloiztIntOqNbzNkBj3xCtIVK7UUEheJCZQrcTIaf1lzm2TMTZHNux43WjvQHg7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rucPhJuAF1diZm/LPE14bPKpswPmIFN/luXAAy8/rVM=;
 b=BOR5DdQc0lKRUFcfoWBlBiWmJNP75hoXGiCtgQJ+6qQYnRZPoDXCL4YbU9OPEKoYjacUkOct4VS7lQ5vVv7I/tFvDLlAUr7Q874CpzujI8hcQwtaSRBc/TtO38kiU4H3PVH7VEg2rXO11xYtWZk1Cu7HWyNaGDq733nus1A4pvw=
Received: from MN0PR03CA0022.namprd03.prod.outlook.com (2603:10b6:208:52f::21)
 by CY5PR12MB6132.namprd12.prod.outlook.com (2603:10b6:930:24::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 07:48:39 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:208:52f:cafe::24) by MN0PR03CA0022.outlook.office365.com
 (2603:10b6:208:52f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.14 via Frontend Transport; Tue, 9
 Jun 2026 07:48:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 07:48:38 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 02:48:37 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 00:48:37 -0700
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 9 Jun 2026 02:48:36 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Trapti Damodar Balgi <traptidamodar.balgi@amd.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 1/9] arm64: zynqmp-dlc21-revA: Update GPIO line names mapping
Date: Tue, 9 Jun 2026 09:48:15 +0200
Message-ID: <c204b6474c821a0b46b94fa87ee69a6693fd8686.1780991287.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780991287.git.michal.simek@amd.com>
References: <cover.1780991287.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1564; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=/fKLM/xEODWe6ChR+lgWMSzM/VNPtmFCd0LqYulh0Jc=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSpH3XmXNz0ZmsMm4B3oNvbyPMJoc8Nv97ROPycwd523
 llNqwTJjlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZhIViXDf7973JdEv9ddEnz9
 IuHkD56in2JfQ5e59XX2BniW/n2dps3wv3Zmccrb7rM2v0Vbd8yOkLhgsEefv+2zevjL/ynTjiY
 sYQAA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|CY5PR12MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: f6a4204e-70b2-4daa-00d0-08dec5fb8472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: b/by4tcP3y+AvP6zMFImf8DqPeY9mWTr0bkquQ4iRIRjFQji/s6u62LTlq/m1AvD679L69ZN6h/2sO5Db6zbdbhf1vUqHbZz00ydEeTyI8UXOTwD0AxvKXGzeJwM8eFEuONz/2Ex3/7wCwcg92FeXHW5RRe8CvRChGaB0o5xLlQuJUOd8vig6wKWwGaYIx8NlFtm388yWhRTeHbc19DlpmSOGuNOO7Zo6NYZO3Bm8Xe/jlmhi1S0ab6BIqBAFUprK0ZuTMYG0ms8bbEOgz9mz9nLxIP2MA3J942oyYFvYLzt9ERfTPaIRDKlHiyEwIS8cR8enqioyk+jTxWRPavzA6VtPPDHLm5S4XZPIHHTGyH6ZAA+8QGsle88oxGNK8ZkTDFQcHBhiCRX5kchZjqFrQYaE2WmHo4oba4m3xOPKtAfxOXcWG5KUZrpH9JeZkm0c6zj3Z5H0GfpKZ5BOGCSBFCO4cC1+HCe407bI+9PjdStYrYP2FJix222WegTPXqEgoTNf1sip836FoNi2Ji3mVKystyYwnHscdJSXLmu5+VIvjutq8F1e7+Sg1AzZnVWXou3oM5S8TJhZOyVbbN8KhCrYp8zyUgvj8ip+sZS5RVikjq1k4KeJuL3mLW7BfA7FY+e1kihl9n3OAwA/dEulsFTjC4HO1MGYHmCnEx1C8xa+X+o3A2/phMVhOFPu72B3AGI5Gub8v1XIDtGvFYAKgXMtliE0dMuVP6FoF/S6OM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UNXz0fLOcvaXsU6M6ltQIAjnyncFpvZEfOjjtXYnod6cXaCbM+6ud6/NjQIU9FYevliGMj+0ERP+xCoJe81P8lupr7hc11q3Tdr2e04cwSZnla4bxeF15l23rJdHE9THBVvboYsCMyxtqpyUKi4oeSvtNkeWy/TlD2Qz+4c9ZSL2ZjK6YStPYyhOk4ax3OVNaJooyuRT+Xd8HGuQ3JB1VOWZEpPwH/JGQCgizhYVKNn4zdFsrmL9UKmsXcIWLTOMSZsGowFKoqOv6HT89QCRKtyXIXGziU0Awu3qvwye/2mIhl4UM1k/itP03N9gZQyehY0lIazysokALnxpcX/bwvMgELfr+tI/d/fjeNoTubJXQ3ee/tWRvr/l/I8BAk7APHK/kh4mgrvYdi+NH+0fZLyHrk8Hi4lUXg8N7YQkjPHBjsk7164YAQc7FCVtPGJB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:48:38.2281 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a4204e-70b2-4daa-00d0-08dec5fb8472
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6132
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

From: Trapti Damodar Balgi <traptidamodar.balgi@amd.com>

Update the gpio-line-names property to reflect the latest GPIO mapping,
including PMOD and VCCO labels.

Signed-off-by: Trapti Damodar Balgi <traptidamodar.balgi@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-dlc21-revA.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/zynqmp-dlc21-revA.dts b/arch/arm/dts/zynqmp-dlc21-revA.dts
index d48b6f3a8ec8..25cd0a09c944 100644
--- a/arch/arm/dts/zynqmp-dlc21-revA.dts
+++ b/arch/arm/dts/zynqmp-dlc21-revA.dts
@@ -119,10 +119,10 @@
 		  "USB1_STP", "USB1_DATA3", "USB1_DATA4", "USB1_DATA5", "USB1_DATA6", /* 70 - 74 */
 		  "USB1_DATA7", "ETH_MDC", "ETH_MDIO", /* 75 - 77, MIO end and EMIO start */
 		  "", "", /* 78 - 79 */
-		  "", "", "", "", "", /* 80 - 84 */
-		  "", "", "", "", "", /* 85 - 89 */
-		  "", "", "", "", "", /* 90 - 94 */
-		  "", "VCCO_500_RBIAS", "VCCO_501_RBIAS", "VCCO_502_RBIAS", "VCCO_500_RBIAS_LED", /* 95 - 99 */
+		  "", "", "", "", "PMOD_0", /* 80 - 84 */
+		  "PMOD_1", "PMOD_2", "PMOD_3", "PMOD_4", "PMOD_5", /* 85 -89 */
+		  "PMOD_6", "PMOD_7", "", "", "", /* 90 - 94 */
+		  "", "", "VCCO_501_RBIAS", "VCCO_502_RBIAS", "VCCO_500_RBIAS_LED", /* 95 - 99 */
 		  "VCCO_501_RBIAS_LED", "VCCO_502_RBIAS_LED", "SYSCTLR_VCCINT_EN", "SYSCTLR_VCC_IO_SOC_EN", "SYSCTLR_VCC_PMC_EN", /* 100 - 104 */
 		  "", "", "", "", "", /* 105 - 109 */
 		  "SYSCTLR_VCCO_500_EN", "SYSCTLR_VCCO_501_EN", "SYSCTLR_VCCO_502_EN", "SYSCTLR_VCCO_503_EN", "SYSCTLR_VCC1V8_EN", /* 110 - 114 */
-- 
2.43.0

