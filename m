Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA4FE77188
	for <u-boot@archiver.kernel.org>; Thu,  2 Jan 2025 04:51:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3791A800D7;
	Thu,  2 Jan 2025 05:51:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mwQAQ4KF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5598800D7; Thu,  2 Jan 2025 05:51:01 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6221480087
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 05:50:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRmtOrNO7Q9IV6TdKeLUtTre0JhwPwdJ7UBmFm4Wn1LJIUhBdPhMCvNcAvyh3ERqnmMdl2ByOYEJ7Xc6c6bg8qt5Pfrt8dA9kaIBjzFea3vmxePH4bY2xSHRvaBT93MG9Uu/1YkiShPcDLAx71JwXtPFE1iSy/Us1F9wqVCntdVbt0ZwuQc8pQC/T0CDrhbzt1rjBGGpC15JJ/dAjvLu7N8oyMojBI39G63ft6KqHfi0Fi/BjrGHzktP5VqhvJCwv5LHCVrg0l76KfxjqnhcpJJb6hYaivmfGkFmSditTrvaGE32qFyITYk166YsvOT3p5gQEJU5SmWtn5pCkOEaYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCPAaCtoaYGUju0QloSYJI4HKky+G8Qy380smTrDJPw=;
 b=vSSB05xzFOxkDdmaGJHHS6xZAVWJyF/Dpb4WxI9UtrE2kqhCbDUtXe5cVXGXLat2cfz0lCKGe1Fyhyj9WpazXRyKT5JmI4bSNu3CtrQgVDs/0hSFIQC2aVgGDkqMQ4aSmFJ6ik54DEu1e+xKybM1hVGD67DPsxmnZcEWFz20Gb/SUTSnMMf0jXfBzZjNUEwh5zsxQCGYv9BEr9TUBaRgHGGGuMjtl7dMA0+6SA4EqVhHpPOPoNKtftGgkX1vFmx1l2v3XogdkIvShbI0/9D+yxDN3yT4eewrhS4YaZWGqtsafr8o2+loCpJsQDpiprfA8ilW7tLgvb/x83tv85zrow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=amd.com; 
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCPAaCtoaYGUju0QloSYJI4HKky+G8Qy380smTrDJPw=;
 b=mwQAQ4KFr5zd69sKyY88mgDYJ7z46vro7zC0Z79rlJDLsaoCekKJZxXWnAIUd67T6833mwrLtQup9rCu8UT+jYyrEe0B2Ao43Zb4h4VhfbJcs2UBtXiPd/LIzCbZS1XE0ZE9unU1kZtHqaYbX94FmGNItrETFs0ne84b3S/NDN4=
Received: from SJ0PR13CA0181.namprd13.prod.outlook.com (2603:10b6:a03:2c3::6)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 04:50:51 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::5c) by SJ0PR13CA0181.outlook.office365.com
 (2603:10b6:a03:2c3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.7 via Frontend Transport; Thu, 2
 Jan 2025 04:50:50 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 04:50:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 1 Jan
 2025 22:50:44 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 1 Jan
 2025 22:50:38 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 1 Jan 2025 22:50:37 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>
Subject: [PATCH] board: xilinx: Add missing prototype for set_dfu_alt_info
Date: Thu, 2 Jan 2025 10:20:26 +0530
Message-ID: <20250102045026.3427121-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|DM6PR12MB4268:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d63dcc1-8671-4bdf-44d6-08dd2ae90770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0+3Gaf7dRk7uTAw6rW0xCI3sY8FHejAZD9oujhNmWVrwp03WvDdgzLkSpeRA?=
 =?us-ascii?Q?eq3MBf80bT9bj0w7mOr5cEqVyBpn7LZ5+kMiE7bFP8dXuqnvoN5UPdM2fvHE?=
 =?us-ascii?Q?RXp/UhURTpAR1B/2QUeTSLJ07jx62Jp4zFnCGKGALtou2qkB+Sa8tstS29lR?=
 =?us-ascii?Q?XFUCzV0WGJIuPavASA5iA2zGV92VeFOjkDfNKp4ociGtJ2pXZms6S063SlYw?=
 =?us-ascii?Q?COAl57uDw3SF2RA8hBq1Pan7eGn9/7TuveN5y7uESNutZT5tv/AySqHerlqT?=
 =?us-ascii?Q?YyfS9J50MkOFKH9+lUi6M2UkmvKYdZV8ueap2F3v3LKET8seKDviDYNiLI0u?=
 =?us-ascii?Q?OeFHOuvYRqFqErmmguoV8TZkIL3ZERRNQdcZsnpFE+lMvd/8+Hkv5fPsTczo?=
 =?us-ascii?Q?ZgxOOK1V1VrsvXdXGCw0/BRM98UTEbo0H0GSq/8sB5P6OIjZvLbOYvxhsDIa?=
 =?us-ascii?Q?sZbwHTGC3CCnPnvTlxm6L9rc8qGi41Jn4AkZSvjoUOWhRWJ/7HRFY2BYwV8X?=
 =?us-ascii?Q?yQRQZlRB0WmMS0Ax/+ag+lZKoTNjHyzcZIHijXGHAMQGHAk2bd7y29/WZwjW?=
 =?us-ascii?Q?WhCq9UMA9R1KSpwCkNxHgDQ8erZ72JMLIoaynW6zJzBdXtdInumShIJ6GqzN?=
 =?us-ascii?Q?tNR5MyvcltwENlJV8J3OnctbFE2nxD9kTGy2wOStL6wcrMQaxP9cWdZy1t0M?=
 =?us-ascii?Q?+wTblcEdmdnY5wjF1kkKDOwUipTXZvbPQLRs/snHIrnshPsMr23ptLOEbYpq?=
 =?us-ascii?Q?//MbYr2d5S6xnUYMBAgmt09Bc4MLLsoPrnk6EfpH6l1GONoTcnGuHfv4DH+r?=
 =?us-ascii?Q?oBHrgK4XvlQ/dgMRxI+5+rtTT7wcKmi9InA+hwnJcFg3Wb8y60GET2pAvW0c?=
 =?us-ascii?Q?el3Ki0z3MU0FBPq078h/c1nOF/SeqNikFmvBk+C8Pb96n/zuAPmgDFhYMPea?=
 =?us-ascii?Q?lk1i1Hln4OVavtMoUKuzbwD9ZUiCQcjjVtkmxax8zRf03ohMDibnbNgDNAlV?=
 =?us-ascii?Q?rAqJ8nBbCa+5CNG46ESdVFyOJMQVV4xjihIMilGBSlmTyy1QyR7lrVCu3z4l?=
 =?us-ascii?Q?4SZS10tVR0xkwTDF7TnQYWmTUzwpPYy8Ejm4xUVbFAdsNgsoOtcR9VdRIyab?=
 =?us-ascii?Q?NBetQfBbFnt+hHGDTlS0odpyPdlXmlqSKSAxhralDSYDp4FS8d4sDwjceQkk?=
 =?us-ascii?Q?zANw3V/lrqF6niCB2+lcOMZqMZ5GsxOR7xrFY0FtddC8ex60dyG82LirZOTx?=
 =?us-ascii?Q?TNYD1C56tqskD02ioc5sIlTIkQZyQTOKo1FDkYOggF4Px9F2zV8aT9LDNPXt?=
 =?us-ascii?Q?lXY9XfjFRgUgmpr1bRPPdoNA/JmR/LHtkV2bn+UXcQU/g6nPWojHliuK2/Bh?=
 =?us-ascii?Q?rQiBhPm7pLkFrbS0AvwLSZEQZKumFuL4bp1/xmXD9YrW6S3cS2PUMruEIhjb?=
 =?us-ascii?Q?RD2R+R/OlIPiUCfNjCZBZdkQQ/n7y8vzdDytvoWplXnQJ8e7wpPR8GpsLdXV?=
 =?us-ascii?Q?DheScFT14+lMW24=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 04:50:49.5773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d63dcc1-8671-4bdf-44d6-08dd2ae90770
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268
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

Add missing prototype to fix the sparse warning,
warning: no previous prototype for 'set_dfu_alt_info'
[-Wmissing-prototypes].

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 board/xilinx/common/board.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/xilinx/common/board.h b/board/xilinx/common/board.h
index 64d657673e..ff8f9b9596 100644
--- a/board/xilinx/common/board.h
+++ b/board/xilinx/common/board.h
@@ -18,4 +18,6 @@ bool board_detection(void);
 char *soc_name_decode(void);
 
 bool soc_detection(void);
+
+void set_dfu_alt_info(char *interface, char *devstr);
 #endif /* BOARD_XILINX_COMMON_BOARD_H */
-- 
2.25.1

