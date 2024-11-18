Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AF1D49205
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 10:08:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E113189461;
	Mon, 18 Nov 2024 11:08:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="elAT/E5e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDDF28945E; Mon, 18 Nov 2024 11:08:20 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::603])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7383489462
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 11:08:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7tc+Q5KTecG4CfKg0sgpXDB5RgfmM1oYJeh78iGIAWzsdey4NxGq1fw/r0igGf1VclThEtiFRbYosrMY/T7VhGDhreOmJ/2QI3uk3Rxh2hNv1r4jibMT4yhknALdjmvE0vkq8SpLzJTOS7IFjftvsR45fUU/VXQLiwb4hhgq5ybPBYEXXGfvtoYkWiZi2FpWPpbX9mxCLACYgKpFUuHXqTELom7cnuUP3/prmSYzMBT7IXOjPMOl4VpwUQXMPPXkCPyCnYn6Wq63JLT5yM+mlwp+55h5hY33vPpAer0K0cGzTLaeEDosjP95ooDBtoWaka4bR6UekUw6pgWhh/2mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znsUtUI0SHxoBM0TASJcUjmneriKwqLLqTbqdM+k7TA=;
 b=SiSmbq9UOp3Q8YyQ3+QApq8bp4ldVMBJAQEwJlQB5JnRJrc1G2HRXvkMgur2B7yAB7qZ2F9oY3rUiMRgtdwtnRWaR2vNOiIILx2ejVbEZFkns4vb6sIOv+3g5kkm3yIC5Hlt67NNAMDaEolMVI9+23mCV1qHWBvM6v2e9DTz6TtLf8B5iIjci4jKPt2cq1J8lxu267ElRx26M6hdK8Qx/RNcb+g7aYnNWbmsRGkaPATlrEjSfvk8GxWy2sFGjAz7r2oDB4+OVXvC+qLmIjS5tu4kB+5bEb1gButhT8vtRNQjOEBgS0JUbNSnbfmaO4LWIQKVJaIgJktbR2rhJ89jug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.12) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znsUtUI0SHxoBM0TASJcUjmneriKwqLLqTbqdM+k7TA=;
 b=elAT/E5euUcE6yxg2/xL47NLTerXyUD+agCxAYFpOm6KtMrT0CRjr7EGs0/ng33iiKk1sdkca9mIWdaMjSP6jIo/lSUEKuz98yOyrsrPdUAcBvfCGOEIz2QQXowD2KJ/xRoikeb32wYpSgkU29l63WmvN6qtbUgp1IRCkPynz1Q=
Received: from CH0PR04CA0062.namprd04.prod.outlook.com (2603:10b6:610:74::7)
 by DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 10:08:14 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::10) by CH0PR04CA0062.outlook.office365.com
 (2603:10b6:610:74::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Mon, 18 Nov 2024 10:08:14 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.12) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.12 as permitted sender)
Received: from SATLEXMB03.amd.com (165.204.84.12) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 10:08:14 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 04:07:59 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 18 Nov 2024 04:07:57 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v13 2/7] usb: onboard-hub: Fix the return values of regulator
 APIs
Date: Mon, 18 Nov 2024 15:37:42 +0530
Message-ID: <20241118100747.30121-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241118100747.30121-1-venkatesh.abbarapu@amd.com>
References: <20241118100747.30121-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|DS0PR12MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 4da46d4d-76f5-4726-d99d-08dd07b8ea7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XZQhhMh8ZNWNzV5Plhbg0SSOUb6SZi+x/FKarPxgjqTwpDhne+42CHneDdVq?=
 =?us-ascii?Q?hFbt/8Ab/HsWkVOr2MtsQbUBISqyTFfxlyUVI8vm2N/MZKRqULLzjXEsdLoi?=
 =?us-ascii?Q?fwhMoQEyvWFKKxft9KAa6eD5be3aAsoQ1od4/KYi28NOmwtTO1lfuH0fAabg?=
 =?us-ascii?Q?k2Xx5q+EwGzGrA55Hxpjlcd/2Mn2d9L+mC1u8N3N6fQ6lyEvQISupyfRDE/p?=
 =?us-ascii?Q?k6eIB+gvOGCKxzMM1Op107fWpp644nheinaXsLL/AMVLAu8rlJDu63tRnBRc?=
 =?us-ascii?Q?jSX/jLwCuxXakdleTydnkoEr07Lpfvzy7vtedBJBZeRmIfOgDVQk3HJjM5Lp?=
 =?us-ascii?Q?oTAngE50Yy40fbsYjK826ExMkLdBM/FMPWZgGvx6jDj2ja1jpd9/0bOKxO5e?=
 =?us-ascii?Q?R+t9AINh8U62mea/BM0RTSU7mLVa6mvWgczFMdJ/ueYA1i52RYaufsaKtNfi?=
 =?us-ascii?Q?eUU4MYSZQ9fWc/1/8E6QsFiV8GUJFnbg0ibn2odvDTS2x2u1g+iRVatlUW2O?=
 =?us-ascii?Q?+vxPmkfQRccITpqxeocgR577Pteb5BaHGTXWioOVEy4AWlhKEbk+iqRMpVSq?=
 =?us-ascii?Q?AOK/L1lq0NRRoQlTr0kiM4D3Ty3hJk0yVN00KSQWsaHvVt5mWKmY7xMcjf7F?=
 =?us-ascii?Q?FW0PKtDDMuXo2D2bXiBeORsP9CiJCGWnX1sxdL1fksHYZP2CLnMwBGdV7s50?=
 =?us-ascii?Q?g2Dg9Ejo0YS15VQEEaNbWfb04nhifWG+zlgKieuU2UvbContSqCztI/M81bO?=
 =?us-ascii?Q?aJRmtotm4607oup96xdYMCrkca2iP/fbxGuiemeDghUR5tlQIE1oEwaibOY1?=
 =?us-ascii?Q?v5XurpUxVtGj30804IjqDffId2bRhlnYxwVz8+Ba3Jv/MChF6llm5FJb+5/5?=
 =?us-ascii?Q?kEjbVXq6Dg39ZLiCObSpWCZs6ZPkoP654rFhbDxdk9MMZfAM2reIdijC5gwM?=
 =?us-ascii?Q?aHSE+MIBfNgJ5ZfOTvdQSBYgzpnmL+tCKslNn31r7ph+g3aSKsPN4Oqcblun?=
 =?us-ascii?Q?9zTXZT1r+iscKQLpBUldnW61xgY3dxzkauR4vTOqRx9uNQE/aucGh89EdXpY?=
 =?us-ascii?Q?6mh7MaseI0AZwb0JukUPJ/PJWAX7GYImZ+j1PljjnBAdA9g1UCKdbGfUG4yD?=
 =?us-ascii?Q?VYA7ts7XcutSKSrqVaATfPRxBPeWj5yZGOdKYZ6MMZpl14C5cFiZSKA8kmeG?=
 =?us-ascii?Q?UXCgeBKq6V1lJIzfW0mvdx8u4t9WXCy8TG2FdPA6UekjJIX87x04PZiiXCsJ?=
 =?us-ascii?Q?NRcH7luVt3s2Jl2z9Cu32u+vsuCTashV3c2vU7HNgl343LVjGLUgszJwGaym?=
 =?us-ascii?Q?10z4hQEO5DVqFSCJdHSuBDujNfaAm03bmupZ7dUqyMItdzYFvKFx95uzJFlw?=
 =?us-ascii?Q?Zt6W9Q0AYoi2XimFVO9oLKYyUcF6y9+8Glkh5ltMi1yso1EHHw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 10:08:14.4968 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da46d4d-76f5-4726-d99d-08dd07b8ea7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7771
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

Don't error out if there is no vdd regulator supply, as these are
optional properties.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 common/usb_onboard_hub.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index e4d1f12cb4..812e7749de 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -57,14 +57,18 @@ static int usb_onboard_hub_probe(struct udevice *dev)
 	int ret;
 
 	ret = device_get_supply_regulator(dev, "vdd-supply", &hub->vdd);
-	if (ret) {
+	if (ret && ret != -ENOENT) {
 		dev_err(dev, "can't get vdd-supply: %d\n", ret);
 		return ret;
 	}
 
-	ret = regulator_set_enable_if_allowed(hub->vdd, true);
-	if (ret)
-		dev_err(dev, "can't enable vdd-supply: %d\n", ret);
+	if (hub->vdd) {
+		ret = regulator_set_enable_if_allowed(hub->vdd, true);
+		if (ret && ret != -ENOSYS) {
+			dev_err(dev, "can't enable vdd-supply: %d\n", ret);
+			return ret;
+		}
+	}
 
 	return usb_onboard_hub_reset(dev);
 }
-- 
2.17.1

