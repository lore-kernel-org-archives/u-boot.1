Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CB1D4335A
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 12:48:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F026A8926F;
	Thu,  7 Nov 2024 13:48:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="isqQddJS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 770E689277; Thu,  7 Nov 2024 13:48:20 +0100 (CET)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 561728926F
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 13:48:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gs5171ZNv4uYNhrbz+ROv3aVObBIyIzm+YEUeDw9778q7crnlBvCUIEirROh/fxD8BnQ+bOFv3bVVpkWt9J46ElFX9ggAT9conJY/UFAVThUQsYRyk+MUoXK6zE9eVafKx2cOU4CiQmq7CgNgjroLMEy5HtNiXzNkl8vJNT8gotg2gdEC7Ia1TosDOAyXa/Mw+Ft4H1wMWkT/UaQhGDl/U0CJ1cTSmFKBqY3zJpouHSSy+H4sWDk5ECX/gJjWGqOrBP+bOF1MWyXZjXBIi65kjn8Q1uaguYDLc7EkVYffdSO1kVzrNVoHAkz92l3Yi2qfJ3OiTIoMfuu+vOM8YX6bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoeYHyNQPJC6PI4CqtCSqrRibXqQTI+9+fCo+w7Ym6M=;
 b=lZJLoz6h83RQM9++MhSaPpFd6ssQ237DTICnmc/OlvqQhxPm7jY/w8zGSG3kyAQVApam91vS0uGgMB36bxwdxUnFVcaBYZMUl78Zgwjai6HFcs4LT+quUBFl/is7i6HfAawZfkwSBxk4Jdso6KM1/Ns0uyMIRylj18ALjGKQNI5YM+SC2wl6gonpjwD1xARtc8eHlkgXMEEWuib4QDHPWEuZSGa/UhnhWJHNMo0yeOuNj++oheeblEvJIE+pS8YuGo7XrR86B8bXZBypLbxHDOnaXRccLmkS1dt3JTZHjItSik1xjXlvUKZeuMdnW4okwZHHwuZ8YjE5fZzXYNvAqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoeYHyNQPJC6PI4CqtCSqrRibXqQTI+9+fCo+w7Ym6M=;
 b=isqQddJSLMcnmrJztTrAf+DCSZH7QHemCODhjn2H+AwxXiSjjQ8n6JC5nrZf29riG+l9xoHBRdIOUCYmDgkK5UtK0S9yfa5sY32Rz2E8bvizSjyQG4YYRY1WJhDoUNHK6wahSWqd0vskRtXpNzOPZTIbMvV+XVNePRVS3DCgOlM=
Received: from CH5P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::6)
 by CH3PR12MB8753.namprd12.prod.outlook.com (2603:10b6:610:178::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Thu, 7 Nov
 2024 12:48:14 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::f3) by CH5P222CA0014.outlook.office365.com
 (2603:10b6:610:1ee::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Thu, 7 Nov 2024 12:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 12:48:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 06:48:12 -0600
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 7 Nov 2024 06:48:09 -0600
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <padmarao.begari@amd.com>, <git@xilinx.com>, <jagan@amarulasolutions.com>,
 <n-francis@ti.com>, <d-gole@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, "Prasad
 Kummari" <prasad.kummari@amd.com>
Subject: [PATCH 2/2] spi: cadence_qspi: Fix Versal NET ospi indirect write
 timed out issue
Date: Thu, 7 Nov 2024 18:17:07 +0530
Message-ID: <20241107124708.383695-3-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20241107124708.383695-1-prasad.kummari@amd.com>
References: <20241107124708.383695-1-prasad.kummari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: prasad.kummari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|CH3PR12MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d9e8ec3-86ee-4f58-946a-08dcff2a7184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IvEp0GrELpYLDb3uzae74h7khRWnDTu6G6KARQQ4NMAS4qjkgfsNhS/jxzRV?=
 =?us-ascii?Q?4//WDyLR5HAsVUqNmeV9nXKljLHJ8QxVA6sfI0RT9D65CroeehYs8lYQoVZc?=
 =?us-ascii?Q?Sh73pC4g5ud8XDB7LF6ZqmAlP4bKRPfS28UOfILeSoc3TNKpd4enBRjf9MsX?=
 =?us-ascii?Q?KsWeKiUJKypsRHuv0sK8R0xgwJ3qLiiBlNUuE+Z8oorv4/JbY3KMJ8Va3TBq?=
 =?us-ascii?Q?VTxVTjwZsE5gOXfbzQPS17QAqkm9S8i2mt1ZJgyTZSVRJZl3FxSNjAe3N9o5?=
 =?us-ascii?Q?NB/efN1xAeJwp4jALALEItynNOa4N37oKTYsrbSMgNbiJAa0zLmyc/95ISgA?=
 =?us-ascii?Q?+Ywi5Gujid5wSHBQKwGfR0fVgrISjGcUFnj4cMiQ9pj/bopVl8LlwIcgzLAd?=
 =?us-ascii?Q?wVaG+d9HTcgEBEJGeXXQHkgC+0FmB/io1lT/kePShiUYlzpZ788iERAcZAww?=
 =?us-ascii?Q?sJixSTfNg+zol/pQi8IA+3GiefyM3WCWYRY/aHxgyFx4yoJFtjySEExe1dKV?=
 =?us-ascii?Q?rkVKHDiS3yytOk+OT72k6U9kPvlW3Oo2hgIVfbY7tPM35UMByJf/6gGmLYy4?=
 =?us-ascii?Q?B6P0N9+KnbxR+dDxFP23XAHT1FtLFiu40IDO9t7aClreJUfP8RhHvYasziB1?=
 =?us-ascii?Q?OUNbeMtjwwDW55lcLpvRKFd+RLWJVOl7tGAeQR2OG3Ff7ZNGnrfH8dCRDWGs?=
 =?us-ascii?Q?SHpVV7qVZqk7/RsEw6FB1sNCL1E+Uzyiz2H6VJ4Eezf+h+pdSXDZY8uCC5Q2?=
 =?us-ascii?Q?hHZQ1D1GMV5T8xCnusRGqY5iN/5g5eIk1eJ5LdRz5FqZxB0COF+t0LAhSxhU?=
 =?us-ascii?Q?Uiw0D3T0uYdNujXpnIk83ZgkcAsUqJx0SyNCLjOJsLLMceAapYRO2fL+G/3e?=
 =?us-ascii?Q?2C7s9R/8Js0+i3njcYw0UkJsh/ZAUF3QN2d5zJgz7j4A2016iL6qWQfb9EH0?=
 =?us-ascii?Q?MYU3eMa/pkIcr/Ub+42aTQEMvIMFAvp5Y47pxIYTFQs1XcNZzlvymEIlYgXb?=
 =?us-ascii?Q?/Gk3dx1XGSX5cPAPO0y+E3lRlLmFIdcHczrXDh8JopS4MoeX7wGtHbsq+tQ1?=
 =?us-ascii?Q?MCjItG0Z51k0yOcPtpfEfoIGWmHa8VbMEPJsnDljlDJjol8F2SENJKf7W1He?=
 =?us-ascii?Q?1CUFfmoG3lH1PRHYN9iy7r8GmLnxqkdlgv4B8MzANeE0kg4Idw0sIBtQA5TD?=
 =?us-ascii?Q?J2m/VrkydpzppxABbv1YMn+/9rgV7L0LWldfTYUHHmP6HGO9TnPEgvxzdQLV?=
 =?us-ascii?Q?u5vG1UzfGLdL4NXqmX/y6ipv9kylLCvlbj02opGdkQx/xEnEReCsACC0xVTJ?=
 =?us-ascii?Q?+KExtw7KeDUxk2fTQV2EtgvR2417IM+ehOfF8wTBZKgnt1HhjOPe1Q+ioVkl?=
 =?us-ascii?Q?u3kPEcIhvTQfCW/sZKhDcpqxF6cv7r792Llp1rjIaPSBa13aGA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 12:48:13.7210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9e8ec3-86ee-4f58-946a-08dcff2a7184
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8753
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

The readl_poll_timeout() function is currently polling for the
indirect operation completion bit with a 10ms timeout, which
triggers an "Indirect write timed out" error. The indirect done
status is also using a 10ms timeout, leading to "Indirect write
clear completion" errors. To resolve these timeouts, the timeout
value has been increased to 500ms, taking reference from the Linux
implementation.

Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
---
 drivers/spi/cadence_qspi_apb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index 3c71a5effc..c6bade60a0 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -889,7 +889,7 @@ cadence_qspi_apb_indirect_write_execute(struct cadence_spi_priv *priv,
 
 		/* Wait up to Indirect Operation Complete bit to set */
 		ret = readl_poll_timeout(priv->regbase + CQSPI_REG_IRQSTATUS, cr,
-					 cr & CQSPI_REG_IRQ_IND_COMP, 10);
+					 cr & CQSPI_REG_IRQ_IND_COMP, 500);
 
 		if (ret) {
 			printf("Indirect write timed out (%i)\n", ret);
@@ -902,7 +902,7 @@ cadence_qspi_apb_indirect_write_execute(struct cadence_spi_priv *priv,
 
 	/* Check indirect done status */
 	ret = wait_for_bit_le32(priv->regbase + CQSPI_REG_INDIRECTWR,
-				CQSPI_REG_INDIRECTWR_DONE, 1, 10, 0);
+				CQSPI_REG_INDIRECTWR_DONE, 1, 500, 0);
 	if (ret) {
 		printf("Indirect write completion error (%i)\n", ret);
 		goto failwr;
@@ -917,7 +917,7 @@ cadence_qspi_apb_indirect_write_execute(struct cadence_spi_priv *priv,
 
 	/* Check indirect done status */
 	ret = wait_for_bit_le32(priv->regbase + CQSPI_REG_INDIRECTWR,
-				CQSPI_REG_INDIRECTWR_DONE, 0, 10, 0);
+				CQSPI_REG_INDIRECTWR_DONE, 0, 500, 0);
 	if (ret) {
 		printf("Indirect write clear completion error (%i)\n", ret);
 		goto failwr;
-- 
2.44.1

