Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DA3FA373A
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 10:01:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2216188D47;
	Fri, 13 Sep 2024 11:58:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wEVgL+gg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33AE188DB6; Fri, 13 Sep 2024 11:58:54 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5550188D7C
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:58:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Amm3RB5LwTFKCaf1UzJd6Sr2Qa4ps/BQrcTlmoRHbe9yZop0uoiFQ3JqYWJkhSHllSnVU6KUbXugFX5EaR3b5jNy1SN4zvYUXwqI/s9a53LofIDo4X7mv8rqqPP+oDv2oQK7DuwEn2erHhi77Mi33roYDRmXSHdhZTGkvJBjBjT9VZxsGAr4tkpJl9DBmbkTR1j+cYq0wNthaEl2YRLhIwxtq21VaVZTeH9CA+i5nS0SvyC9KNYZe5g8BhxJhLVU+ZfJF/bA2DhKC8ahj6bFqqEtavGdDtq4YLxmGvbIVuvYQcSn7HzEHpsbQXZbzwXQp47T0/Yx/kiQS3peHA+MoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sc4TdR4sOE07Hoh298/wGV0It4oLYw0y9S0yRKgBTQk=;
 b=yzxVOLTp5XCeC+B4c4snL+ndxoEZYXRplLAjFsZyN6gxL3s7tTvLXF0iI7otXQje6apUpVigPWSO04Mb1NZwoezrXBee33r0+6H8qqe6U6DTcGfAqnbxPZHCHcexUS4LD0XAflHa+aRdCWRb9kcsIABp0KPvK+LAUsp+m3ms9A+BwCLCu78kin/XJokD5Tv/WVs0C+NIrApUi0u7vPEmq7mSvyeTnDZDF/DpXP+EZT5NnSZGXs7Uyjxo1fPnt9HIrFQpnYIjHtwcthLsXi7O25KWbjRRGTRseMhywg3n5Pjk1KRjKuVgj25ri83yxKkIoo/JGmv+hDsqROQC+ROxxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sc4TdR4sOE07Hoh298/wGV0It4oLYw0y9S0yRKgBTQk=;
 b=wEVgL+gg5aA8yHDUAnAj60Esb/y7AxuB+xyqqDCYARKj6KblPxJMyzu2EtCvAJi/Bvz61RM6TEDq/3kSQa3h10to8y/KMXSS1YPy5Nh17q4b/NZBruToqO3hmAmkP6HEFbCyV1BAmNb3Nm6Q5pKVcuu5y6MmMjRTHgtpk6hqLLU=
Received: from BN6PR17CA0029.namprd17.prod.outlook.com (2603:10b6:405:75::18)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Fri, 13 Sep
 2024 09:58:46 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:405:75:cafe::18) by BN6PR17CA0029.outlook.office365.com
 (2603:10b6:405:75::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.27 via Frontend
 Transport; Fri, 13 Sep 2024 09:58:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 09:58:46 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 04:58:42 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: zynqmp: Define only one revision in zcu106-rev1.0
Date: Fri, 13 Sep 2024 11:58:39 +0200
Message-ID: <c5214b1a01032b88a394104a57624e0d91a22f29.1726221517.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=773; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=ZQF5babrhj1wct7CEIEHI2tGNyzo/oQXQN9OURPmKfQ=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrQnPBcSrO5p/v13dM6Etdq/zDKesNhHrb39dKOtgEwN/
 8ylOmcPdcSyMAgyMciKKbJI21w5s7dyxhThi4flYOawMoEMYeDiFICJrPZkWDBD4FlhjpUj41en
 kpBFZVsnHy6/dZlhrgzD/HOX5Q/pi3eHT8m5w1mcnck+HwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|SA0PR12MB4415:EE_
X-MS-Office365-Filtering-Correlation-Id: c730e816-a7fc-43c9-ccf7-08dcd3daa878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?spGssEA+Ud8i7FHP0YhN1my+p3y31ZDOipVrqKu7LT706+E4LdJVaIcji+Go?=
 =?us-ascii?Q?PPLiJRLc8tqQTeUW19z5q0HOw7hsR/9LV85dHvfUmsz4YW9HGPOfFi0aB82m?=
 =?us-ascii?Q?O6Zya9F/fe4uYyHZL0d8ye+af9LoG8vSBuV61YXAcNUTTLDI7tEI2XMuyoL5?=
 =?us-ascii?Q?qG5kEpasibfL7oQxrGmmOzquqXVb4NK0M523qmCCmzBNFuke/WkeJeTU1+4c?=
 =?us-ascii?Q?vHdW2UBxrU+sYjLVUiEKKFWTiHraL7K5s1NslFjexWTo4EBSG6v9zSHI0uss?=
 =?us-ascii?Q?Bw8DnIyhsMsHXsl9iErZTaaEogymsqJ15N5Psgur9O6tFmXvmni9t97AnF6Y?=
 =?us-ascii?Q?YskKudhQcyMst+vSVYWiZ0FWuxlMa/GwAA9obHcu+ka4Bzy9mzgdfmfTJnke?=
 =?us-ascii?Q?lz1/XFCSm3xJGC5S1x4MeD4avB7y/u4kHrOGshT7roc0rwI8TpWxuwN+haFd?=
 =?us-ascii?Q?KYU35fJN2mbV8tYJquSW9PuKzHjCZSWHQf2WDP0t7zu2spkeJaD5ghw4DXYa?=
 =?us-ascii?Q?FahxR2eXockXxUh2B+8RGRuVQ7sf+/Zu8VH9/09i2NPR3qfwInfyky3jJre0?=
 =?us-ascii?Q?+eB5t91brdTlzS5RUQDG+I4CJPCayHpPFcaLiDiZNnRYOYXwclxbtgF+jSh6?=
 =?us-ascii?Q?FfOsBoDQOUoAAwhSV5iC7GfxndzJwNzwDWvx3JpNTNJte4utBOKGmH2IE4bS?=
 =?us-ascii?Q?BtHc8SFgSHNf/NocNl06RbzNGq8IpT7dIMSuiqO6odNxIzz9T+ru9gfWRN/J?=
 =?us-ascii?Q?ESGYnlwtr3DnG2ZBMdoEvqWmFDVzeFmOpS/NWA1Tv5W5V7Cv2Y6jfiu4amrk?=
 =?us-ascii?Q?lqb2hCUMm8/BNVO2lRMaLmWxB4/LnOTztFMRiXa6hCH5FVhYOKw87lkdWfjU?=
 =?us-ascii?Q?JisOzxPxK30ymSqPW7C0vwVpIxzQz0kugj2c9X4mdJ6OI21b3lukT5B4uIIM?=
 =?us-ascii?Q?wvdEAsvPABtOtPDpVQUayVh2F5e0wfcW94MlV1Lxzsa6eeG/lD4//oo+J8Cx?=
 =?us-ascii?Q?4sBwG9hth588gkwE+9L4Q7EsjitwleJEWKMWfE6cgKoisY9OFjlE1K8kdSU5?=
 =?us-ascii?Q?jd/FZqy1rK3reT5EwJHDawhi0/xVE72wZf1MKBZquLT8YgEz/kRTFD8KD3Nq?=
 =?us-ascii?Q?fMYiL05O+GMPZ9EWSZLFW+zCE4i3IjLjRpUqCvHnl15SiGNI2h0QOtoZkay6?=
 =?us-ascii?Q?A1t5rjJsyRDqNjREAknlW6xuMs9Syp+Ah0V4I2WeC+iQYOaa/4GWpQJ3aC0T?=
 =?us-ascii?Q?Ras1Et52DFlv2DIS2VSTJ1jGpdnZE2l/Wvn2KgE/72UXweospBoKpnhCPN6n?=
 =?us-ascii?Q?/fv6+Q7vBTHYhI8RBFY8KFyJ5DNSJLmcKgnPMhUF+tYYXn1972cdaBj/NVgW?=
 =?us-ascii?Q?wSKYRWORf/x24ebosQmeGa0fr32d4fyyasBuDNOr3OlEcF+8j696SowiBBVg?=
 =?us-ascii?Q?yW57R6WzUyk0D6IMVyoFpHeJI6/SAB7N?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 09:58:46.1964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c730e816-a7fc-43c9-ccf7-08dcd3daa878
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415
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

zcu106 rev1.0 is sw compatible with revA but only one revision should be
listed in compatible string that's why remove revA and keep only rev1.0.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-zcu106-rev1.0.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/zynqmp-zcu106-rev1.0.dts b/arch/arm/dts/zynqmp-zcu106-rev1.0.dts
index a9b5826a777d..f1ec314fdefc 100644
--- a/arch/arm/dts/zynqmp-zcu106-rev1.0.dts
+++ b/arch/arm/dts/zynqmp-zcu106-rev1.0.dts
@@ -11,6 +11,6 @@
 
 / {
 	model = "ZynqMP ZCU106 Rev1.0";
-	compatible = "xlnx,zynqmp-zcu106-rev1.0", "xlnx,zynqmp-zcu106-revA",
+	compatible = "xlnx,zynqmp-zcu106-rev1.0",
 		     "xlnx,zynqmp-zcu106", "xlnx,zynqmp";
 };
-- 
2.43.0

