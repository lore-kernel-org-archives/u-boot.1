Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B61D7496B
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 05:22:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBD488918E;
	Wed, 30 Oct 2024 06:22:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s0dwtyU0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72D8789024; Wed, 30 Oct 2024 06:22:30 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B3B288EDE
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 06:22:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aa/91bkNZ8TuYjrizWBANetlPOEAttD+lT4UdDWO8Sf6CCL7ep3AXv9wSrGIPXn9Gg9+ZefXO42zNQwrk5l9V0MXjr1TVF30C9BRNqqM/8TzaEu0buoDqKI8pgRTkBAzTvO921kMDZJ9ZOmJUESpko0DXZXIWd5bvUEE0nHpCgMyNQVTU1/nqQBoWn1ger6TkZKKzhHt8HVas/h4An1iIT4qS1C+qsNbL8GRevcywnbXpim5kAvkA1/aCtJr0kqFkPLCMfWnRsZN0Fgz7ofqkX3P88y+GDOpkVHxgzH2dP7WazgfWFmCJMkMwMtvmq9fu+QWPx7SzVpkbvSbL9CnVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSTRpJuC6jBaweiXaO8gwYUYig3tjCD+xk9s+yV6LB4=;
 b=x0P16uTCTIzbM4c/ujyEiq9zQhWQq4Qyym9KtuNfdKH9l4tzA57CKfFhfDAnILJzBI8ICsBtVN7JmDl5LuHvanGRju8yOlDMEdkvPaHeDc3RaUSlB5xIT/7ezr7xplcuAVDjl2F5wtPYEO1RJtjKGX84I0Pn28G4G9BBCCVAIr0yp6xhOYYpoyRzqbiPDVeMl4xMObPr+L0tLT3FLZXNh3cYGgIU9QyAbn80Rk9mPk1Zqzk+ZKegxRDlHT9XcewAoGhvOh3OG9bKyx5x9IGfh5CalEnVhrHvsj8xgmQR5M71NGG8mlUDDQ3hqpZlkSyJP9RFBljbf3n+nkUJ9Ej3zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSTRpJuC6jBaweiXaO8gwYUYig3tjCD+xk9s+yV6LB4=;
 b=s0dwtyU0TCVT/jB1tYXXIqnZ/n9emGvYa8zUhGaVJn3xI07s4KQo63jEqdKaQ+mEAQ0TIXcRaS3u96h8POXxbzyVyeNaTeP8bGuGaEF+N/Lf9FAnrIA0OmFHH6PO9+j9jUyVekqCEXJszHxQ1Pd/rTN6pEWqGcT2FEmIS6r2GgU=
Received: from BY3PR05CA0031.namprd05.prod.outlook.com (2603:10b6:a03:39b::6)
 by SA3PR12MB8762.namprd12.prod.outlook.com (2603:10b6:806:31f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 05:22:21 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::f5) by BY3PR05CA0031.outlook.office365.com
 (2603:10b6:a03:39b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Wed, 30 Oct 2024 05:22:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 05:22:20 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 00:22:18 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Oct 2024 00:22:16 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v8 2/7] usb: onboard-hub: Fix the return values of regulator
 APIs
Date: Wed, 30 Oct 2024 10:51:55 +0530
Message-ID: <20241030052200.24243-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241030052200.24243-1-venkatesh.abbarapu@amd.com>
References: <20241030052200.24243-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|SA3PR12MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: c3db835f-c9de-4f4c-ccd2-08dcf8a2d409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wldCIgQCcTWVJTM5Hch9YUIVMTZoVvpNJsBoEEiQls6zf/8/UyQ/XZ31sRae?=
 =?us-ascii?Q?gjaw/zQIjwzM5b6aPs6X3tNwz+0y7eqa+kqxkufHQPcVMEb3sRPC2RoYrrFj?=
 =?us-ascii?Q?Dn/A1UHehpFZFE3p8Xs9/4t5t1ylpyTnXTBbQ/viq9jv63+N0crM3UlS59T2?=
 =?us-ascii?Q?h+aqVkW/wcCTBfddMkABljd3BqlN2qJkDK8mLdqPf0Ou61xbA/rx1ARDN7b2?=
 =?us-ascii?Q?T3S3s1DQrVgH+E2lj2TWDF95nnIGWz/YoZk/kzsFO1bz+M3Bp6WvrpMXpNvS?=
 =?us-ascii?Q?BmYaVgQHG/Ybtn9akVkBT/b77wL0MvlHff/rtqLXC7qOO/G5/HRizIF4gZfj?=
 =?us-ascii?Q?hWu8h066mbf2jErpS3YBVmHcc09gXkXyPKIzexJf2PJm+GZruHlPI4mqminG?=
 =?us-ascii?Q?3d2WUrY3/lrc95tW4C2BbcSUI8C+9P/vnk5pIYSVFzrStxTxo0n4wlI5QiQh?=
 =?us-ascii?Q?nqYQgnDn8GKBcWqEKsgP6iEFfM7A9LbDiSnISorFGjopZyAHO0YzjGG9OX9M?=
 =?us-ascii?Q?WtDsiTM+Rmsv0J93P8VT2FeNHt5U+Mhi+DcPCsI0seVfJMvwolbPy0Sg9rFz?=
 =?us-ascii?Q?6LX0ovY0MQNKZMYmdPkQhKAKViY8f66vwRbpg3cvy7sGhngMpryA9L4Mnhu7?=
 =?us-ascii?Q?nKSsvwoeWRhS4tl85dwzM4UlKWOboewMIWQvwhI95BVZsD6hhWY03vdmyGjN?=
 =?us-ascii?Q?Wm/ChY7Xw6yxdx4v0Eapg4t4lieZbOExlh/U7544ZsKIVa1EWwhuPRtGRnAL?=
 =?us-ascii?Q?85uiySTJ/f/znkpgETiqMbayoVDRzi8Kvlc8U8MeLEocL4FeLBq3HmU09pyd?=
 =?us-ascii?Q?gaJ3ubQLpbUCDIMqilCiKf2SixKl5ZoSlK6jQoisqgDrq0mj9Beq0mDg7Zev?=
 =?us-ascii?Q?NjE1/Ugf2LjJY6cFPg9YFW4Vfv/v0VHijE54JKeB5WfG02Y0Am2dfwYlsX56?=
 =?us-ascii?Q?4t3RxsVN5E8O3EqC4jITguw5A/LJ5OWn6WLxdHw7FVn3zFHHcu2pki9OoMf0?=
 =?us-ascii?Q?8XiVoPDHRCBlpc+Q5P3+z9euAmPdYiorBgoHx63iyTNO+8woWS04mpEl4xJg?=
 =?us-ascii?Q?mffnZsq/0iMXtW8uOW1+C64M/uWt2PLU7ciaHgw5v3y3/MCSttTHFoTFY2/Y?=
 =?us-ascii?Q?cz04xcrVFYds5IedrIbgsj1aQmmbNYHp6UIrfYRte7O4BOgcxslwyocA5/zf?=
 =?us-ascii?Q?8MttH+iEqKxlcC8OGhGcVzqbKjKeywyaAYnMRCpuuwXCaUk61fl0/aVO1tVA?=
 =?us-ascii?Q?LS6C4erzsaubBF6yB29bk9UpthWyDaLWH8FcglNw1GdH8s3ectbW/ly+4giB?=
 =?us-ascii?Q?10Ne42Hy590BnDCXOaUyF2BAbNBTSzlOcjO5/2hNoJeNygLNquAE72kESDa/?=
 =?us-ascii?Q?XzU/35XkPJMpokR7r5VNlySJzWWYFAyt5+xfi5bKwlCvnva2Qg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 05:22:20.4007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3db835f-c9de-4f4c-ccd2-08dcf8a2d409
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8762
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
index 4174575893..6ef9c87fc9 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -58,14 +58,18 @@ static int usb_onboard_hub_probe(struct udevice *dev)
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

