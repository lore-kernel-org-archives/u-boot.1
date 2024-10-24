Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6CDCFA47F
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 10:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCE3D88C7B;
	Thu, 24 Oct 2024 12:42:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wwpIJRYA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74C9788D29; Thu, 24 Oct 2024 12:42:49 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::61e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB16D88BB7
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 12:42:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3NYvRu1c3UYLLWZNQp4J7IMrh0ewo6sGnefVgTSepBgTI7an2mokseNks9zP7CraWjdOsyKPEOvdim15v/6aBTGIofUhJAZFPV8fb7t3UKFuaYghUSMYpqST+C7w3DoSa/IILKJ8+pSyE7u3uacdFvSRCcft+LdU9mow/iFnAmsrp195/umPDiazJRAjKJlCR7qQK4S/12sP0fmvd9GVoT4t96ObHDLLdF1qvZ5AruqTgdhGGkzc1sFBawE1vhBBbs270EUAe3b2NaBonP9I5zjzj/9+uol5X1vyotV81xTJ0A6MSYffRAFC1wd+yadekQtQYjL7hfi7xGfmxzWgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+UkSMCAQVtHzTq+QKQoACj6B6HH/5iWCBn4xVOqdV0=;
 b=ZVJAzEgozDKoilpzMFZgnGOHCjQ6NPHZ5NfQ8lkfIV6ARQH35mSPBrH13cvX2R33yOwKfDhKUMdV6UppIEESrGqlBFjjhCJ3ZpdUsp4Rpl8FGjsNOhksafG+DXCDJ/LKyFWiPYEt5t/Bct5PltuwGecwgl7jVWQg7CbTrw7RJxX/Ti/LUCPyR4deBysbx7WB8P+S0V0vYxGSbi668t9UHRx9DxiAX3haYrvZEeuoONIzE9NHBxGjOBiMoW3ASZZfRMgspg5e1+ZGNaT+DKaS10WzufJGvy1FxVMHs1iWWVLXXOwzMR8d2QUvAIT/jwsLZ/hMMxb0p1xhg/LUveOuIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+UkSMCAQVtHzTq+QKQoACj6B6HH/5iWCBn4xVOqdV0=;
 b=wwpIJRYA1KgxRg0h0E7O3RaXyq/Gt5dslZ4pZTlj5aOIIq6hoAyZ/TdCAtGMwjDxV67G+lQqbLT3ovKsEGWBeMHC2yaW0DV7LmTvCmdO/RX+yuMJRhQmQhJeMHv474TvVNVuamrtSo8qC98fGTh0AJNPssUsmGLS7x1ExBTxZ7k=
Received: from MW4PR03CA0349.namprd03.prod.outlook.com (2603:10b6:303:dc::24)
 by PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Thu, 24 Oct
 2024 10:42:40 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:303:dc:cafe::e3) by MW4PR03CA0349.outlook.office365.com
 (2603:10b6:303:dc::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Thu, 24 Oct 2024 10:42:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 10:42:40 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 05:42:36 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Saeed Nowshadi <saeed.nowshadi@amd.com>, Paul Alvin <alvin.paulp@amd.com>, 
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: zynqmp: Fix pwm-fan polarity
Date: Thu, 24 Oct 2024 12:42:33 +0200
Message-ID: <3e8e38b77101335f86bca0f05b3988877bb12993.1729766551.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1078; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=xOgGjohLNrNyx0KuuzAaBewXSh0F1M4B+rFRzW0p19U=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhnQplVlMVYtFG76VqzROaYl1X2347mlo4t1ndzz5XUVCd
 p/7KW7bEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACbyaQnDPNXLj4Ufqv7fapT+
 4nHSXAFb2z+znjDMFRDmypzqMXF1kJm/7Qw3zsisojIjAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|PH7PR12MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a0530a1-444f-4154-dca1-08dcf418956c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NIfm3s0hDICD2LCub9iH9qtRX7qn802sPAI1JbCDjG9Ipv1T8nAJtSq15f4W?=
 =?us-ascii?Q?7Xbbh7vVn0s9tHBEYksT+FY1fzVpna2z5z9zeNtocFMFiNUsjaTMIHlYZz31?=
 =?us-ascii?Q?VwOXCmKk5yAagqLhHcmH+LVU0MzmRPBFrBgTlTWDR4k5mXR2cg5l6NKHimvC?=
 =?us-ascii?Q?5odgHkwlYM+Hl+ckpgRVeeiz3aN8nh6SI/fmzX9UEGM2BnOxv3pLiVPdmVmd?=
 =?us-ascii?Q?m+Q4qLjcVqe5J32YWlrJ3VBAOK42wtTrNGgDwPHWUUyki4FpyuN9zGdQ4TM0?=
 =?us-ascii?Q?UdquR0OpQMQZKxngS3bkpwD1YknSWxooA0Snl40ji0vUuzZiwuPfdCpR4KL2?=
 =?us-ascii?Q?3TqIQrYrULRza6gPMgLDqlvkD5P7ZlKdPRG8tSJi/4Pkctdi6MO7DWl6Na5d?=
 =?us-ascii?Q?n+dGWVhl+eaoXZWM1c2HFyvUlOW8lLGBS7m+TzCuBZY9fVpCQ+qZC2rB/ALm?=
 =?us-ascii?Q?C4xK7paX8QibN8MdtFFS1zw3Ba+xpoaZQAht/0EaEoGCS3s3S5nFcxE8HXRP?=
 =?us-ascii?Q?N6cvsRgYFigwJvzdMl3PZLEunxkX7tGitotVCds2hM9sTZZJM09ye0QADfse?=
 =?us-ascii?Q?1kODHq7PMjx26Xk16Fa8Cyp8AqSoRxm3Qu2IDX2vqoUkt4CbH4zB5DtDusmP?=
 =?us-ascii?Q?JJDrhp5QZfmw++NVKPZwhm6wFa8bcAu8xSEZcaV3upX5qAdePJa//ygjCfOQ?=
 =?us-ascii?Q?6rzr/GK3PYbBpqH1ePmlPa2kQ826t/gLXPpjy521I9UagpBbcYp5amjG1BoL?=
 =?us-ascii?Q?yK2pGf2lPs7wAE7+KbyNcJaUDbsuk2mIeIwxFQrRTOrg1nWSWYtwrpqsJrfi?=
 =?us-ascii?Q?4m6UfnO2Hi8bLXSQjh7h18kgC2zec0je6EsunYYZIbi0b0AYTg0HoLNmWzVP?=
 =?us-ascii?Q?494YmlpGTSmljRUel6F5D/dE3YGQ8dC+cG8DBHpi/3T9b7HgRzrq5fAxuyBL?=
 =?us-ascii?Q?UBka1YptbAx70NXdORV2TCx5iE2h0U2NzabCxtuNLGgZ+CUHFnaosnmOdYfD?=
 =?us-ascii?Q?4DPRHkPF3BgoS6wgGxEQwQ4D3Ra/fG89kbw0XEB6NEFbGFwjbJGgZLDgzjZ+?=
 =?us-ascii?Q?OIXCA+Fpetll/DlprjaH3MdeVH5iNIaQbtJ6YFwQbobBpV3qlbcMiJ/pWfLA?=
 =?us-ascii?Q?zdI4caixSi7bYSeMSUX3mPXi5VWbMdCDGaXJ1sYYDlsD+16YoX1l2djMtiXM?=
 =?us-ascii?Q?ZajjNAO5/hZOQubv2n+SONFHwZdFYiazTZy1yP+6qKW3e/SfNP/qSO1vt9LL?=
 =?us-ascii?Q?JyIRPhm467cxgTTXAbcGWukve1gj5VdxoEOFAi1mOUsDRPo+vQ9ttNsO84ne?=
 =?us-ascii?Q?7hp6wKNRFkWl/XWavfnk+RlG350/1mRdzveGTi/6x6Gz4JMs8nSO8ZJXN6+a?=
 =?us-ascii?Q?wb2sz96vLPwT26tLm7siAV6YbcaGTNZ29YkioxCpIGEzOL7RnQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 10:42:40.1693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0530a1-444f-4154-dca1-08dcf418956c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5685
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

From: Saeed Nowshadi <saeed.nowshadi@amd.com>

In previous version of pwm driver, the polarity of pwm were implemented
in reverse.  In recent release, that issue in the driver is fixed,
therefore, correctly set the polarity in the device tree.

Signed-off-by: Saeed Nowshadi <saeed.nowshadi@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sc-revB.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/zynqmp-sc-revB.dts b/arch/arm/dts/zynqmp-sc-revB.dts
index 1af3f643567e..c4f70581695d 100644
--- a/arch/arm/dts/zynqmp-sc-revB.dts
+++ b/arch/arm/dts/zynqmp-sc-revB.dts
@@ -3,7 +3,7 @@
  * dts file for Xilinx ZynqMP Generic System Controller
  *
  * (C) Copyright 2021 - 2022, Xilinx, Inc.
- * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
+ * (C) Copyright 2022 - 2024, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -80,7 +80,7 @@
 	pwm-fan {
 		compatible = "pwm-fan";
 		status = "okay";
-		pwms = <&ttc0 2 40000 1>;
+		pwms = <&ttc0 2 40000 0>;
 	};
 };
 
-- 
2.43.0

