Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D66E68165
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 11:23:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F9AC83DC9;
	Tue, 17 Feb 2026 12:22:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OudeNyYt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5544483CB9; Tue, 17 Feb 2026 12:22:31 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5733883E0E
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 12:22:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxENWfW0m+YnnGO+IcY9knqAEmydDtqZ7NlMJcbSsFEpt6bq2pHI5hH+/kwrfu+s3iEJU/O+8Wb5W4G7nFTM7nvp7qBRbkQrJAImmypTI9+vl3qZY8n6474ZOSkL4q8lI6yHfvyqknoJvcq4+s/o58LFNpJmvbiQuYBJupG5JtALdLbmsnuu/bs/M8+wyhj+yjX7XFh5Gg42TFZae/lM9IKXySLsJCRaXmzkDGEBsujA56cG9azPhYZ08aTpnkH9CgnJKXMHALusIf3rt2G0VfNjFCgBZG88FtSCs9BVB6DmTsDBRFQpuTmDUKeNPEr2l4VmrxFifdpY99JX9k8Snw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meZP/MpVpClMzCLxio3dC6z7Z9nUlxmOsV2RQIRRCl0=;
 b=xqLNzufceETFRYeB5HoSeJChMgVZIIPTBgLD7foQNcx/4IGwCB9c3m+XcgGDHG9jFszHns5lrIDlWmZ9sTvPRzCiD980DMQsIh6Fl3QUmnMCSXusK44K+bi7agzsBETw8/p1dJ/wZwilmuJdm7hn9uBAccg91UbpZb2yDlPlecyAFHYPDpOSixBFdhYPEHY8xrxLOZDYIzM6qgXWa/iNBGpJ2XhdX2VR75NxT7jZvwOND0D2txrMT6VnXhMN97KTMXbglTftaJSYLvFa/3gXIej6GF9cupu2FMfKnEjvBY/FDPQcIJ0TzzIUPVTodDiRKtu8PpI2gxKDQiiavmJBYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meZP/MpVpClMzCLxio3dC6z7Z9nUlxmOsV2RQIRRCl0=;
 b=OudeNyYtIAMBfsOVIkP0ebr4Np8LrYXdlnRo7aCorvuOYOWku/XeIaGqYC8Jo8XY6H4u6edte7RoV4k8mPdB7GpIeHzoBTbbeQCtHlYZvnsqzxpQH8qZViXorhgXQrj74ooqxtZZ1wJ0cSJ6p5jOXOmZ0KXDj5m+fywkn4Lof14=
Received: from SJ0PR13CA0118.namprd13.prod.outlook.com (2603:10b6:a03:2c5::33)
 by DM4PR10MB6087.namprd10.prod.outlook.com (2603:10b6:8:bf::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 11:22:22 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::c0) by SJ0PR13CA0118.outlook.office365.com
 (2603:10b6:a03:2c5::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 11:22:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 11:22:21 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 05:22:21 -0600
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 05:22:20 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Feb 2026 05:22:20 -0600
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [10.24.51.206] (may be
 forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61HBLutS3263329;
 Tue, 17 Feb 2026 05:22:17 -0600
From: Anurag Dutta <a-dutta@ti.com>
To: <jagan@amarulasolutions.com>, <trini@konsulko.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <boon.khai.ng@altera.com>, <a-dutta@ti.com>, <s-k6@ti.com>,
 <gehariprasath@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 6/7] arm: spl: Enumerate SPINAND as a boot device
Date: Tue, 17 Feb 2026 16:51:55 +0530
Message-ID: <20260217112156.272154-7-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217112156.272154-1-a-dutta@ti.com>
References: <20260217112156.272154-1-a-dutta@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|DM4PR10MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d861bb5-5629-499c-0e83-08de6e16d191
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nVeulul0HihAKo30AAmFvqZQx4CRlJGswKM9JVi9/fvlU+qjy6eVf9mSv10E?=
 =?us-ascii?Q?+zhu8rCY20njCxJSH35qEIQZg0xeT4GBSVEcWS30JjpFhSgOQTERP9Bnu2Lk?=
 =?us-ascii?Q?3l+bQTl6P2qJ71sOkowREGSVhlDJzLkMVNp9PE+k7x4FCER/s26Xrl28aGRe?=
 =?us-ascii?Q?1qQ1Xlo4Et+L6QHOb0YHzIGPf5jRLNMtyAgdDNP/ughZ/jqgqgMJuJ9qYlhi?=
 =?us-ascii?Q?4L+aKvVKQKIOox35VW5yGzx3KrO8gDu4mCd3Gd26OWj3nTB72b9XQMQ4RxV7?=
 =?us-ascii?Q?fCVdh7AXMf9USgJ+yJ05PvmtHIlBHlNBOvjn7LxwJ7et6571FUu0mIuM6Oks?=
 =?us-ascii?Q?AAyCKayQq+1F27AsO0E2SHQOKZ7OWzR+W+4H33+CtIgRXdGtxfwk9d9dQ11x?=
 =?us-ascii?Q?3Lh3hk0TdDBym4yTY8v4ZDr9EGSH9QrXBUXdoq/58dHevYiYaLPAqgH031nm?=
 =?us-ascii?Q?B4D7AeWPQh7OmKwi26mRzi6L4mkeEDeSzSK6BUoalVTdyHlifyv/SZHgW4lE?=
 =?us-ascii?Q?mImgC+UJxRke5wsupv3Z6oBQkXNSka0diVMWB3Zie8fENP/kTJG9TNhABdNh?=
 =?us-ascii?Q?h8fsca49oq+xvByEvDySN9X6Ey2FeWBMaocJCqj48AntJJAPEEJt2zzoLrn5?=
 =?us-ascii?Q?KpfQgiE5lzSm7EyeM1Fut0HklLoCfVFOJMIMJ8mE/LpTssdxpF1NiK0ewAtG?=
 =?us-ascii?Q?5Jgh0+9JqW1Gq5eBZ5H3QjdOHhIcHjfctgSXi5NNeR5TGoBA0BIERXkaFRPN?=
 =?us-ascii?Q?+9FFQ5tfCb+n59ivZHjRwd8HHJuwHgGY4cm6UnAcPDI5+OSzqPSkS3DVWgLe?=
 =?us-ascii?Q?FdxLKOaJ0np0SxCcwETQpnGKGC/CCZg2ByvOegz4mQhdlb6jAacns8J+RPFP?=
 =?us-ascii?Q?lvdTZDa3+CNjgPgcJrPig9WwCguXGH93c8LhOOdvg6ABU+oSOjhnexAfFbA7?=
 =?us-ascii?Q?820gcA7Z2d7eGKNWR2sYgKCYOwgA+TmuuvU4mgHtVToigcKXhbO/Sy5AwcPw?=
 =?us-ascii?Q?w90TnwLWPab1IOJYhTMos3blj6C51QyA7YUuLgogXLPiXs2ROve7F3QNcJFM?=
 =?us-ascii?Q?i5k5fNtcuHIQ3lJO0efqgM26QUod1vHmBo5OVHUDlfAbrt0t+2Qwr5y7L/Br?=
 =?us-ascii?Q?E1uOMpclrqI5ByAjkRHSHDGo1409dgpxW0D1ZM8UhgIKBHDi3t+Ok0s9Z0rT?=
 =?us-ascii?Q?GagRVn/C0HxbSMc8asid+Zg8EyArpMcEPUWgc1PeuErhTn/cyEXQgPBCYX/O?=
 =?us-ascii?Q?TrTvIIEbRcSi5Fr6MfgRhwlCcuXhXVd33UCxwoZ9RnEjXRRTnDzPpSiuFldw?=
 =?us-ascii?Q?yytMRyUWA6T1N0Kqd8IPXS48Pb7XDGSfV3orXWc92e5u5zwgpAuqaAhDkQ7t?=
 =?us-ascii?Q?cvgZTP+AHr5IJbSJWPyEk0WBgOZ1FBugiDyhec3ZhS9s1eoKnRVty/iZSuCI?=
 =?us-ascii?Q?Rkp8D1UjvOAFvAX/UOGCB7DOn5nsEbJFTkb007on/WQ+pJULY75T3IyvYb2X?=
 =?us-ascii?Q?IfPLTKb8ZTZGGtVZi8vcpz2voENpDjzIgRfhE92Mgx3ytZaS68BoaNdga4Dg?=
 =?us-ascii?Q?+OBolJY2FOS3YdYxPLXvXF3xlcSH1cHpZdwn2UtI19uhIE8/+XSOpou9RHSw?=
 =?us-ascii?Q?xn95Zl1mEXLOW53bikghl/R+6nNRZiI3Cvli4STBVM6gYMotuS0xUml5Xa+6?=
 =?us-ascii?Q?ORf/tw=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FAy2zroDIzp4y6rwRd9SWgC/LgcnRR1Wp6hLVz5Cx+Qr+W8c4duivv+JPKqd3VWog7LVrd5a51Zcag+X3Ga6cOaJl22TYX07SuWj7pMFUC+1WGsiDmFmFJWoqVFJAaHvT48F1FHBtGPwU47Gcpb2ySVAi4/sC9Nxj9FIRAZ2GFvJUO5xmSA8iC3hl8XzFo8egaV3mjfZZEt/w8q4U3r54Cu5d07gEeRWz0ZxBjT5gfLsUpoi1mcTTAJACpa/e1WbWz8sMadnIPKUp7F1+BrYhaot+k2ZTqHA6JjeHqQcj3q5QKaMlSk4FCG4pRlYXWakKTZ6xLSHv2UCaOOvKygNKMtrgyxu25BQ5b+LNY59KuWZ/u24cJlVBJnY7d73Dqprg4C8mpvGaqKQabxPDd1jrHoBqSNND80scrYQtjtNohP9AdAgyMpanO+DSJNWc8xh
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 11:22:21.6246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d861bb5-5629-499c-0e83-08de6e16d191
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6087
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

From: Apurva Nandan <a-nandan@ti.com>

Add enum BOOT_DEVICE_SPINAND in spl.h

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 arch/arm/include/asm/spl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/spl.h b/arch/arm/include/asm/spl.h
index ee79a19c05c..cd9b7942fca 100644
--- a/arch/arm/include/asm/spl.h
+++ b/arch/arm/include/asm/spl.h
@@ -20,6 +20,7 @@ enum {
 	BOOT_DEVICE_NAND,
 	BOOT_DEVICE_ONENAND,
 	BOOT_DEVICE_NOR,
+	BOOT_DEVICE_SPINAND,
 	BOOT_DEVICE_UART,
 	BOOT_DEVICE_SPI,
 	BOOT_DEVICE_USB,
-- 
2.34.1

