Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE0EE77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 15:03:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41CEC80602;
	Tue,  7 Jan 2025 16:03:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lmY0YAMU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29FB7801FD; Tue,  7 Jan 2025 15:51:28 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B4FD8007D
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 15:51:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ibai.erkiaga-elorza@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggsinbwijcQjo62r2MQEr+AvHXRXoy/TRIdhP2gZ59ibsuD7TNYWxIh+mVCXLbcktUniHcywdttFxztaDQJui/cQDDu/sqkzYklx5Lo3EAxOqrgF0nIeYYVcLObCT39lwZ/WSk19cHajuC/gpvtfw8h7XKcrcBni0F7uALfWFPkzajHbHp7lLa7lUgtWMekBPP4792Aa6Mm9ZIzCUnPVFesq5zmloAnEf/2Tbp+MUrqBDjETkfLia0vO6Ja30G/+0foCMhHh+l4+nPTLomGOnTlsRVvDXJVqWDm955ddgyu8dsKihlyc5DefK46l+/2b5KPhbpZ5uwtTugull2W2gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJuoDKDASwRIThmgB1rLubt8Axo1CVYzJ7cO/rqFu+0=;
 b=CSzzSnrRGhtRkwbsXugjxxvIx6varhwXxtB4zYT6aLyRE5P/vPTxp1ozSJp0Y4Cgp2NkaZOGyMBdzDYCvwXsPlQhooIkK6X3BIVNKQjOTTJ+5BC/LEPTbHgPg/+x6fkCUj2vxn3W2bPFf1h0g8yQAvJBgqsEoUJU1Yr6lQ1ZMppJFOXYsfA7jtJeMOUSxpeG/JH1o+zeAOi+L3v9yZ5VsTFiipb1xs2kXCnfOdO5kStyb7iMJAzj1GZ+58wRqIpZqJGMp2sMryYxs1udOBYtWNhfR3Mm74UfQ33psFyt+zCXHD16WU29rlM0+LOwzTwAqlEIB8k/UsB8oc6z/PjxvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJuoDKDASwRIThmgB1rLubt8Axo1CVYzJ7cO/rqFu+0=;
 b=lmY0YAMU9KzSTIcgjwO9oOyWCSqqjKEGQUD+rnMlaX6szSYb/WW86o1NOrM93WOEeraG/J77G3FUwHK0LeeXbWg6Ri/7zL8/vbZUVe+M5eUXfZTiAPN3BVn/a8lN6zI5pDXRJ5ul90YctEXigqWMu+a17p7YYonRok06gF/2x+E=
Received: from MN2PR16CA0031.namprd16.prod.outlook.com (2603:10b6:208:134::44)
 by MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 14:51:19 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:208:134:cafe::ff) by MN2PR16CA0031.outlook.office365.com
 (2603:10b6:208:134::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 14:51:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:51:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:51:19 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:51:18 -0600
Received: from xirengwts04.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 7 Jan 2025 08:51:18 -0600
From: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
To: Michal Simek <michal.simek@amd.com>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Ibai Erkiaga
 <ibai.erkiaga-elorza@amd.com>
Subject: [U-Boot][PATCH] zynqmp_gqspi: update to log_debug
Date: Tue, 7 Jan 2025 14:51:08 +0000
Message-ID: <20250107145110.2855213-1-ibai.erkiaga-elorza@amd.com>
X-Mailer: git-send-email 2.42.0.325.g3a06386e31
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: ibai.erkiaga-elorza@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|MN2PR12MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: d587a945-dbbc-45df-8730-08dd2f2abf05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a8G8LwTdJ4KMN0SeFjZc7OGpbbjKHhDKy/rxpdm0xnOPiessUGMo7naionNm?=
 =?us-ascii?Q?Vd8KyTDv7oBC1SAxdz1Z6QmYwZp6JoQNwN8VZtm8s4WZXMxrXYAfXqcKv9w9?=
 =?us-ascii?Q?C2mQaql48nPDe00k8pbf3IkN1plEu2jF5a1Ic5s+JBPyJVYZ5aHgyZXa+4K2?=
 =?us-ascii?Q?ctL2j8CJaXMZMSxJLbc6+o0r9txHbAeskgZPAVSvm6T2LvIqJF1TFnnz36YA?=
 =?us-ascii?Q?y5lKo0pZocU50lF+Irox1K2Ry4osqhUOQNHIgqQKmZmvhJiUFdt44N+VxtV9?=
 =?us-ascii?Q?YXO9Hmuo4A7r+Y2o4stY2ttabWLnmnywZpUtmZO3bMETZoMVR0wMa0RZeD0t?=
 =?us-ascii?Q?Fsz/Meg+AEcTL7hOmhbP4fW8OsM+TMW4x0sPc9mRvOsGEP/zrmgrq3tOm89d?=
 =?us-ascii?Q?cnV0Ju4B+jcILVmf0OBITffW5TxKGtIdhZC+9unLmkKw674mEiHR5tViJ+ZH?=
 =?us-ascii?Q?48C+b7/R2KiPuPU0LT9EkQxld3RXMTbEOabZ2q3RBA0BaRYEaRywroJiR18X?=
 =?us-ascii?Q?AFaye36oBN7tCBZfk/4W9J8ZopLxR0Wb+FrEjDYLBOel5nb020mXQu/Oq13R?=
 =?us-ascii?Q?rODBkZypoIG/3fg0cyMKkRD7Sw8FuqBgB0MHwoFSgu6xzvwCVJjgqfXAoT+H?=
 =?us-ascii?Q?t+4EN1JXZxinPoTwJtBqsBPg7m9ejAglGfmOB2wWhj6tnp29iiyE9v+8P70i?=
 =?us-ascii?Q?4GqBQAhDvTRSlsFiJtCEtbha5Dmrp4IMUQYqW15ujkgyly3pPfVdGIKDiO51?=
 =?us-ascii?Q?MAln//iPjdg/P3WKIyxdehoOg6K0flGpsDaz1Z/3RABcft4Rk9SiCDXPqGk9?=
 =?us-ascii?Q?e21HandU5Xk9vEmZMLmdzHYw+/JIMi5wTosDJxxhOZvuhm82M0tlQm/IzvFW?=
 =?us-ascii?Q?WgMvbEx2Q/hq+a1XPN2HO8VLsLzTsToMMxE2j0Q6UHxtK9Gqt98u5Rt88qGB?=
 =?us-ascii?Q?SrWLWWdr87betI3qT2YT/pZrZnfY8mELYAP5Q3YyIEM4dFxGsCVPLWeuh1AG?=
 =?us-ascii?Q?5ENyxsU+lsohFChPmVGGArNUV1jWdK77KPbrWo8ghqlteCXzog85t7M/Y7ey?=
 =?us-ascii?Q?8dwOrb1nB9wipYLlIQjZNp/ewh0cNiilB/YfseaZrPEnYsHAQC5D5UZtMAdS?=
 =?us-ascii?Q?IxCo3MZVmrMM/zvs+6lJezwsbofbjrPhENqMMBg1SkmL75X6WAoluU2fifU1?=
 =?us-ascii?Q?2HPrFChxPkUo2P4PQQLX3i4Uuvv9pPILkdFJrbCWFgIIQbe2TE4VP34ZvM2S?=
 =?us-ascii?Q?H2jGdMGy1BLGXFxaoOYcystvmIPeLrjLRDgCR8E8ealOdT0HJyDeJmkgCCur?=
 =?us-ascii?Q?hLhkSz3Ibn2VabORJFiJaJU6YDr9oPGFHF+61YjlLraVWHZqATTWQGwznbw2?=
 =?us-ascii?Q?AKbFIk4v62N4WVBO4MPu7wtrpG9sWi+0sm4z9zWWaQuUEfNKVBnIjo4ur5uB?=
 =?us-ascii?Q?S2tQL3H3KY4VA+xc7NAtq9p+GQ08BHjArEwcTN6pzcrSz1obGidt4nw5U3dZ?=
 =?us-ascii?Q?EJIH2a1KD8igfUM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:51:19.5795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d587a945-dbbc-45df-8730-08dd2f2abf05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333
X-Mailman-Approved-At: Tue, 07 Jan 2025 16:03:29 +0100
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

Update recent parallel memory support code to move to log_debug instead
of debug as per logging in U-Boot documentation

Signed-off-by: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
---

 drivers/spi/zynqmp_gqspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/zynqmp_gqspi.c b/drivers/spi/zynqmp_gqspi.c
index 4251bf28cd3..2a095d0c58e 100644
--- a/drivers/spi/zynqmp_gqspi.c
+++ b/drivers/spi/zynqmp_gqspi.c
@@ -255,7 +255,7 @@ static u32 zynqmp_qspi_bus_select(struct zynqmp_qspi_priv *priv)
 					 GQSPI_GFIFO_CS_LOWER |
 					 GQSPI_GFIFO_CS_UPPER;
 		else
-			debug("Wrong Bus selection:0x%x\n", priv->bus);
+			log_debug("Wrong Bus selection:0x%x\n", priv->bus);
 	} else {
 		if (priv->u_page)
 			gqspi_fifo_reg = GQSPI_GFIFO_LOW_BUS |
-- 
2.42.0.325.g3a06386e31

