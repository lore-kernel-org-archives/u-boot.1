Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE054C3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 09:23:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC93C80107;
	Fri, 16 May 2025 11:23:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XMlXK/by";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C408A803DF; Fri, 16 May 2025 11:23:31 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::605])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79B4680079
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 11:23:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vg6PUyTP+eDCVUcnaH87KTyhbHUcWpcpB06mw3FLAYUXWMqZIUJKFnPp9YvYjGGAvYNL6+Wuih1kXWe+YFPvKAgAA44QeS/knHSylMk3rZFxGZTMRnqMHPOtv6qUYA4laRgdKJS4Nye1SB7OKvQIG/+MctvIANF6AlNIIcbDtazWf4MJqucSXQlW7fJCQjJESf3Q4f6vlqM64nGr/hzWy5wLmi07gR5ysyM0g5k6iyCAAWvcVxdjeQ1JY2/sM8A2Zgpd5/3/u8Bk7MgVu8J3xxhg43aSHC93C0/9eU4hbcjU2wEahUealOEf5BsJ+QRKypVnuJE7WMp3uOKdregC8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+RZYCZNRwruGdgEHiTR5hGtwfQYKhun3vRmr64aih0=;
 b=qkUyXZ7fbFViHZVR7dtZqoEVljEKcJY9p+r8YS6zrEtoTWS/ky9rDcdxfVmu1So9fC2BRJyC1XtB0W8ocyC6jTYLz1vN6mnsrILU3p9WZmJMD04kBWlNy67LQhelTRE7/VFZrC1UI+8khn32b+PE2dvbIUpmKZkpATRg+ODVESRlj+ScTXTgRCIw0pqilypVb3ru8XZHPtLiIoHw1tpuLVLrkQ+nRE6DayE3fYQoy5lIjOkDmFABvCjTR6LcnrAvt+RF9oonstEZu06vGFHbtWqx/B0vXfpS/lqxfUC0k9RhSLHc9BwMsrBrv6o6BUC5rjn1Wz/gdNgLd5/hWGUTzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+RZYCZNRwruGdgEHiTR5hGtwfQYKhun3vRmr64aih0=;
 b=XMlXK/bylGkIdZuXczXZlINZuce51Et7umaegxiNFwrfVKmA/3I4fqpnpbbhQiJzvjrLgi0w8IPUFZn/8vhUdnpdHRol8wk2hIXz5o77EeIoLAY+7AOKVFTmHYjUmKivcB/OxZhpqZaWVfr2bd2XsslWEAKa7gHrNPSdiBF/mQY=
Received: from CH0P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::18)
 by CH3PR12MB8902.namprd12.prod.outlook.com (2603:10b6:610:17d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 16 May
 2025 09:23:24 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::6f) by CH0P223CA0014.outlook.office365.com
 (2603:10b6:610:116::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.20 via Frontend Transport; Fri,
 16 May 2025 09:23:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 16 May 2025 09:23:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 May
 2025 04:23:22 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 16 May 2025 04:23:21 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>, <sr@denx.de>
CC: <michal.simek@amd.com>, <trini@konsulko.com>, <git@amd.com>
Subject: [PATCH] pci: zynqmp: Fix the pcireg base
Date: Fri, 16 May 2025 14:53:14 +0530
Message-ID: <20250516092314.939424-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|CH3PR12MB8902:EE_
X-MS-Office365-Filtering-Correlation-Id: 29d215dc-4fd2-45e9-c363-08dd945b4ef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?odz6Z51z9FEOsUsIBk1Ie6vRoXKYZbsFA+pkQp37bxTLccZRbALQkKtBxEN0?=
 =?us-ascii?Q?BrWg3KNYoYUiZqeiXwY/couG7POXWbw/c2XHJfiMfzJmz8dlssU99diyiCNj?=
 =?us-ascii?Q?hBGHdgIh24XQr5JzwOcOOpFEpVEfZ+Cs0pYLm2Eu5Q1sEDlIOzEEW2JLsKdY?=
 =?us-ascii?Q?dca0rUVFFTawALjlmoisiNit4Oan+zopUoJsRpqRwIE/kfvb94pkVMwVBWyo?=
 =?us-ascii?Q?E3PpvH2nnJWQC0E7S6QtW5Ig3T9ju5BCWcihSq5j4TONDWnN6OpSSqnJa0X2?=
 =?us-ascii?Q?n7cnJAvyZRsLYJ9Fu3pPW3mh2yS+yZzTh6CE6in9DCmmavEzA5XeVeaHkfke?=
 =?us-ascii?Q?JOe5j9vjNMDCEkRZ0Y4/tPMmMojRBZMXGSKr6okLBlXqLuSwsugya/CAhBMX?=
 =?us-ascii?Q?pyiSAQcvq69PPR7F+mkpuTzhU7XGle18Yleug5aRkGi7T3MVDMuGFcJ36dkf?=
 =?us-ascii?Q?DUGb6NyGreYrno4d7gqXxdPQX42agXMlF1Bq/aZ2Sl+kWc6P7UQaycQMvpRp?=
 =?us-ascii?Q?VOWYsgRMiwxbAMBIiqSsUoEJOyG/MOTF9tV0BgGru50FdaavDO12Byny+JoI?=
 =?us-ascii?Q?pwtNWofHeReZLDzn76rPbvQ/2jjg21voAe2bp/ARqEx1C2qgQCoMoDLrvLVq?=
 =?us-ascii?Q?F4WdOs53P4p13kZ4xOCvHzZYJ5A7+qjJvFc7cUcYjkCNDpuPqx9aXTHhOH3B?=
 =?us-ascii?Q?/MRKu1rMWO4BW1lOLeRbXex5OH3ezZuLaBvLfiNe/qV3aqcH3SQZElSMuCJR?=
 =?us-ascii?Q?6f4aSaLvzrmYv5fhbB/5w7rnsgA7PRECeEn6RAbwq+x938fSSrQbS5/qz8uZ?=
 =?us-ascii?Q?/qvANEfT6C0YAMkbopGcIKRaU8dLRoSLy9FeP8A8mDiDUXsICPe+LNB4iqAy?=
 =?us-ascii?Q?51rC5nH98umymNAdD4CnjqqnXmzALfV13DB2yVG5G+wc1IxE7BS3kFs6iZaQ?=
 =?us-ascii?Q?dKgMxGNQAilMapq4StvI851tM2L4KmQh2SPxsLn4k9bsB9fMRSBFOkAyplKt?=
 =?us-ascii?Q?/B3EZqR8N2inFoEP2FmK8gbkrrFaP7cSTtKC8F9sClgRAuMxEy3SZmeGLs1u?=
 =?us-ascii?Q?krzGxbvgP2+gaaOu6MBjR2yUY9PdxbtFND3EY8QHsqlFRefKMaP8CuGo+q3w?=
 =?us-ascii?Q?rw06KyQV/amZfsfGVocjJh1yhmiNIutOpX8CpIXFnWfxHjjdAJMoh8Ee6xGc?=
 =?us-ascii?Q?LuWv20I/64NfWZ7f7YcQ71JX7Gs2wpXMNV9DN17Z4bp8HJdWhrXvdqYYr049?=
 =?us-ascii?Q?vkIj0Bb0AY1xHRopye6mzyAXkvv6J5rWRvugu1eOmupfDmhVpsYRBEpxmTZQ?=
 =?us-ascii?Q?b/A0B6qfeQWb8vA2eiGi6pEF2Eb1Yd9/0P2SMS0eNSMEO4cvxo5LjjuDWSqC?=
 =?us-ascii?Q?LhTsiVFXgNJhGoXtLFan8f/Zim0k5bjeB8x6B/vw5T7FatvzhSKRu60NY/7/?=
 =?us-ascii?Q?j4A06I1bMtVRpUfqgRkF577Tkw5NcfAvgPNZYwj2E+iAvZz9GgeKbpcRkB+K?=
 =?us-ascii?Q?KQD51mVOzd2RQhEJN/76criOgYu/AjEdQqX5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 09:23:24.3344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d215dc-4fd2-45e9-c363-08dd945b4ef5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8902
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

The pcireg base is not assigned to any address, reading the
pcireg base with PS_LINKUP_OFFSET which is incorrect and
giving random values. So update the pcireg base from
devicetree so that we can read the valid PCIE link status
and PHY ready status.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/pci/pcie-xilinx-nwl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/pcie-xilinx-nwl.c b/drivers/pci/pcie-xilinx-nwl.c
index 7ef2bdf57b5..e03ab3be912 100644
--- a/drivers/pci/pcie-xilinx-nwl.c
+++ b/drivers/pci/pcie-xilinx-nwl.c
@@ -303,6 +303,13 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie)
 		return PTR_ERR(pcie->breg_base);
 	pcie->phys_breg_base = res.start;
 
+	ret = dev_read_resource_byname(dev, "pcireg", &res);
+	if (ret)
+		return ret;
+	pcie->pcireg_base = devm_ioremap(dev, res.start, resource_size(&res));
+	if (IS_ERR(pcie->pcireg_base))
+		return PTR_ERR(pcie->pcireg_base);
+
 	ret = dev_read_resource_byname(dev, "cfg", &res);
 	if (ret)
 		return ret;
-- 
2.34.1

