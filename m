Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8617CD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 14:23:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0A1188386;
	Tue,  2 Apr 2024 16:23:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KTrv1pjt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C990E8811A; Tue,  2 Apr 2024 16:23:34 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FBCD8811A
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 16:23:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbcrwPBmRUEczUIETbGa2jZ/h99kZGGXrJe1rFbmZ/9G3q//Wj9eYwnfr1ZqnQSer/6GWHyAp/CGQM3D10tptC1GMimWMx+A6b7qHMWYJ5Drfs5CVoc+CGQheXm4PL7/hvl3n3J3YwFmIcvAGSnD7n2KNAjxbBMhUKGeRA4Y5+bwlWz53q8uCjeHg2P7BLSMf6Hhbwoc4RTMM6oHKVXv1lLJd8tybNpqMAlW/mDfPV8mbZSf4TdLrkNdllCEN1EWtDv5z1iyl31SK8yUQLcw7Vs9rMLod2yZ+ggwP5ZKG7icmfvFhOaYjPXSudhuCjg9EB/maFJc9CrvyVIesHuZvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzmHrCpEyS20oa0P8jX/qIxs21W67UNxJiCkrRlu+jw=;
 b=Um5n6J14xFz4EuBgHwfAfIc2KJDwP+n6+R1ZbNCoALIaXQS1JmfrYzfQQ2MkmKjeCD7CEWwNolwBX1dXwpqHiIySX35qU+Pa5HT5P/BOAns1XFhHY+DZHlFYyn+HMeJB5Cp9yInIaYNDC/eGTcIBLbww4bVyZpIPnAb3PlLyRGWtFZseYvrBVFzNqo6udoTfYanHVXX42bPW8e6rlJ0L6uY1O+E9n0ALu09IAnuIyXG0Gtz3a6uz0ESSs54cFvJRBZaYYs66URZwJ8kqYBlphwqHyOVRCxA6zZpy2hbTKk+DxfgTtm+4hc18wjRPXSCv52yTOSOI7B/uNUeVi7dyFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzmHrCpEyS20oa0P8jX/qIxs21W67UNxJiCkrRlu+jw=;
 b=KTrv1pjt4gjMxjsvLjETTI8Pgt7hLp1j1gE9AQ2vLGIIf5nFLATWlV6VRSTcy0DhS96rIFm4EuuOmW3lHwjhFxVbr8DHj/usN3uJfHXgmSsp7R/DiYCNnfWNQSTPBNiaOG//QibjdD5AteSplAvUwCB0J9fNoPlc07AwZ64wvX8=
Received: from CH0PR03CA0120.namprd03.prod.outlook.com (2603:10b6:610:cd::35)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 14:23:29 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::bc) by CH0PR03CA0120.outlook.office365.com
 (2603:10b6:610:cd::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 14:23:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 14:23:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 2 Apr
 2024 09:23:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 2 Apr
 2024 09:23:27 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 2 Apr 2024 09:23:26 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>
Subject: [PATCH] soc: zynqmp: Add the IDcode for TEG variant
Date: Tue, 2 Apr 2024 19:53:14 +0530
Message-ID: <20240402142314.7353-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: 670afa57-add3-44c8-3064-08dc53207765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KsXJErfPz6y0vxnrfCo8L3Zsk0cs7Mfg0kVLtW1cEfF+B5vfOa45oq2P30DUjNIWCc/Eq77csvMJ95txwfbKp/UX6APD4d/uOeqAA4TX/T1KNXl1gy0y7I6PrUDgp9u1dEQJPIlZiyX3xaB2Xi0DYusaIC5Aqg7ggqlsOgXTDUvxI5ZZh2q+IYfUYUQsgWhnQvdU8SjdQYJlMIE+LtihqKGJCgm3aAqOg3mjJZxnDUfuNUpcvzMG6OISGN+g1e075mZBJSlBgfjeRhI+cJivXUENGepji4TXnYTfeUf0h97gOjAaWuaEBiyxr2DHchoos3v2X4XfXEjG7dn+nuiSzHsw32J71LBewOP6thBXjzFrv18tstRGiVyR1KMYFJgXLQX8B5v1pTT3r55aZmOoavtkERGePp8Dk1C2IeupMZeRwVyy3WCkHmbzRKIm341I4Q3f+pSRC5EP39NDdEGJLD4zag+oqcOpC6eyOHd0vYkVrMCtlX7+UpCcK7ixEBtktToiZJIf28Fly8/dAF+VOACgczroOdL+tIRcHgk+Doq0yzTT/jpi3OXiEC2TEzH4O2AwG62mQ9SRKXCA3p8Xs3S6uqUORJYWGkhl7M3IuJdhR7krnvqFQQZN3fn69elBT5zHA6QDICExw/IEjb/9Lm3duj4NBUR83cjczYhTx72q8PeRv4Slk8SHyZ5WHCV19zvzjy1KlDfI7ni+w4elH1tdLqFrzRW9pn/3HGW8GWnMGFvG91N1jl0YxVnBJV3h
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 14:23:28.6321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 670afa57-add3-44c8-3064-08dc53207765
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185
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

ID code is added for zu3teg variant.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/soc/soc_xilinx_zynqmp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/soc_xilinx_zynqmp.c b/drivers/soc/soc_xilinx_zynqmp.c
index 786825d920..d8b4f172a3 100644
--- a/drivers/soc/soc_xilinx_zynqmp.c
+++ b/drivers/soc/soc_xilinx_zynqmp.c
@@ -44,6 +44,7 @@ enum {
 	ZYNQMP_VARIANT_DR = BIT(3),
 	ZYNQMP_VARIANT_DR_SE = BIT(4),
 	ZYNQMP_VARIANT_EG_SE = BIT(5),
+	ZYNQMP_VARIANT_TEG = BIT(6),
 };
 
 struct zynqmp_device {
@@ -74,6 +75,11 @@ static const struct zynqmp_device zynqmp_devices[] = {
 		.device = 3,
 		.variants = ZYNQMP_VARIANT_EG | ZYNQMP_VARIANT_CG,
 	},
+	{
+		.id = 0x04718093,
+		.device = 3,
+		.variants = ZYNQMP_VARIANT_TEG,
+	},
 	{
 		.id = 0x04721093,
 		.device = 4,
@@ -299,6 +305,8 @@ static int soc_xilinx_zynqmp_detect_machine(struct udevice *dev, u32 idcode,
 		strlcat(priv->machine, "dr", sizeof(priv->machine));
 	} else if (device->variants & ZYNQMP_VARIANT_DR_SE) {
 		strlcat(priv->machine, "dr_SE", sizeof(priv->machine));
+	} else if (device->variants & ZYNQMP_VARIANT_TEG) {
+		strlcat(priv->machine, "teg", sizeof(priv->machine));
 	}
 
 	return 0;
-- 
2.17.1

