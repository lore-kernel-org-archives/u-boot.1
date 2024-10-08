Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B16CED267
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 04:58:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6E7E88DC8;
	Tue,  8 Oct 2024 06:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H68TisJY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E006988D82; Tue,  8 Oct 2024 06:58:38 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::630])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAC1288DBA
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 06:58:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LaYsLFpWAIhLQ88g2uYW8MLobMI5FNHgk6XfbYjoOgL1fK7F3kM1+c3SxLA1P22expd9Vzm7nAHzVmK+4kXEquJh4cpBjNMylz2XLQneEF6StkvIplqGP4DzzbJ0u3IT/8Nc4iuvW/4B5cAepWOqP6Kn7ioe0VtQMtVj+pVBFcip6CDW0HHgG+p+je/iCnrD2KzsxTnmMu+4kG0PLePloFe+d0uoixuhHJ49Ww819v/bIo18DwqMIARxpb9ugGe3fwqcRlzBplPRbXnt1n+DUw+HXUv4hPzPZMWqdesORXQFPmM/Ras4Hl4blcEo+5f8F8QHIpUxDQ4hb69NSkV3IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYBlf/xP12dGdra2GZZxxuaGVEnOntpx4Jz91Y5Ncq4=;
 b=TBS6yUAbHrV0wCFWf6DOsKR6JLCzedFhtrJNyj1/A1A1ovCTKPqAC8KBpVs1SaZNyngYBWkejvblZJYLT3e4+CZrCf9u5+wg/ItsWaHS1L6lMt+5PGeq9WKtIW6WySlo5f+AnrN2p9ITFy07Q0xCq/APRMEdYxl/iKTUBhGp6QK+yR7xhswq9xg5wMLhZiIPg1UNxzDCxHTPxAiqb+dgh06qHH7uY5f5l5rEtxcDHwMldMO99l2OM1WTSzDggpLGW9mxoZMtJuyCgvW6c3qW3kebzuwcv6/+NkAfVgYoL1xSRQjAIy5sZzzZY7xVf9r9ygjqYxfsEcJQNAUHAB9olQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYBlf/xP12dGdra2GZZxxuaGVEnOntpx4Jz91Y5Ncq4=;
 b=H68TisJY0PhbEvSDHtYYZb8Cdn3EsuLKlkGf7+4rT3aWKJazjSTp7S/YOPj351kPz2SBjdbZHzS0874J09wIcl90eDrJ6gZLvURnwdwHrEn9Uv37nPmXcmJFNXxqa3IxFiDuP4CKhms8qcITSq+oeg+DZAZl2jcfryRFdUv5pGc=
Received: from SN6PR01CA0024.prod.exchangelabs.com (2603:10b6:805:b6::37) by
 CY8PR12MB8213.namprd12.prod.outlook.com (2603:10b6:930:71::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.23; Tue, 8 Oct 2024 04:58:33 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:805:b6:cafe::85) by SN6PR01CA0024.outlook.office365.com
 (2603:10b6:805:b6::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Tue, 8 Oct 2024 04:58:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 04:58:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Oct
 2024 23:58:31 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 7 Oct 2024 23:58:29 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v6 2/7] usb: onboard-hub: Fix the return values of regulator
 APIs
Date: Tue, 8 Oct 2024 10:28:03 +0530
Message-ID: <20241008045808.28757-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241008045808.28757-1-venkatesh.abbarapu@amd.com>
References: <20241008045808.28757-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|CY8PR12MB8213:EE_
X-MS-Office365-Filtering-Correlation-Id: ee9b3a33-cb94-4b2b-e2a2-08dce755dc25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qJPFVUObwMZNw28f5AmDrHfdsnkb6mulcyxhcPfCP0dIQ28IoTW94ZxfHIeH?=
 =?us-ascii?Q?kk22eQenFv8uulVy6WGktmJj1wyzpGxuVnLWng+5Vb+fGrgTfKAOh0nGOo0k?=
 =?us-ascii?Q?bkyZY3vantoZG5zp49aEdj+mA7IeFvpXUgNpCrDHw2qWq/XFwPMXnaxG+xRG?=
 =?us-ascii?Q?zDF7rQ/hhKyUmAHg7obHGfFDzJgsjxa0+CvAw1S9/DKPay1k1MJekdfneKHL?=
 =?us-ascii?Q?HA4eGA43zkaMVonmFdv1vPif3tcXsanqfyVJfTgJJk4THisQqOOrRk4zwY+3?=
 =?us-ascii?Q?5L4LKCojt1KQEUuUhzkTeHvUBGWtDgDZsMRVs5eZJu0nLFRVBjAZOYJOAEgk?=
 =?us-ascii?Q?/t81r1Dt+j94PRco3jB1D42pG0yd1JkT6QBJX6qfeVdvdCTT+GpMD3Z146eK?=
 =?us-ascii?Q?xREsbrM2OrgIhUC8+qoD6GHKSHNYfI/hp7PrqHK/rU8F5l2zKH8NcQXbwQdO?=
 =?us-ascii?Q?tfRxdPq2sGMIFL/hFKw5fuKcWyFFWGaezp1xsaAvks2PiWfdIknEDfNm+JjX?=
 =?us-ascii?Q?vshmpGEqy3zMUh9nncfC7vncdQgDeFRHG4+JMGvk+NzlBCvj69kR2uQzdpT0?=
 =?us-ascii?Q?8y/WgjnMdCwhaxCm0UZZGJ63YhP1DT25Fc3Y3hmwNjbjj2OtRofCxAvFY5Wg?=
 =?us-ascii?Q?pt1BZnbAlFVjirq23tiDLb/gxtRQ7iVPQUfULq5y05Af6BuirE4nOtB8PbqY?=
 =?us-ascii?Q?xe44omvw61ckUHv3cN10v62COz2SIAs0AGWfiORCMsmyqj8C1AyOLooQix7y?=
 =?us-ascii?Q?FDzMY7UWTRmmcWcwMF7/3m1ZD+wkMiVfUQz327G0o6eTfIH4RRRK8wmCwMQ+?=
 =?us-ascii?Q?mCzPyuetCKQXd0eq6Gv80kOsXpufdTNO3KLpx4YUnwQAOMVkm+3hVbPNRmpt?=
 =?us-ascii?Q?w93Bnmx/NRSrxAbg8zus0q6bAdwL4zkeCdAt/94Z9QrPeuSxIPomnW8/Ng3+?=
 =?us-ascii?Q?0rdxch76VHvuo//T8yQ8XncPvRgtJnJJenNMOLfXH4bIXN6XKe1soveKDh8g?=
 =?us-ascii?Q?CBZTx+lAxa9WdDNKugbqifT/6E0mjQjquaVOc/ShfQ/xWtO/avXpwYdHsyvf?=
 =?us-ascii?Q?1j6bSJAv9szHOCrGGTEuOXUdAupttMuf56fHOuPhyGDNNNdTS+MOTolaFQdG?=
 =?us-ascii?Q?1rV8aI8AbAOSWmmwjWg4LFa8CEOzhIBog0RlW54Iy+DZmkPy+9yjCD0Q33se?=
 =?us-ascii?Q?B4BoGhKH1cso0SL85lA++jScXPi612O9N/GzV34KHTUKECrSgTvsy+mqcjqE?=
 =?us-ascii?Q?VvDv5FeH8jqVPPs/fB9ClBAXVayA4QTf2kdUoubCSERVCSNk/79y8rB7f++w?=
 =?us-ascii?Q?TQlWw8NUMOhYPrj4krO72QVop4q+yfa8RkI/WcSF8fEkjyyazd2lxhcIsVTX?=
 =?us-ascii?Q?iz3D9kARbfMPwYgj3Am2lgY/TnPI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 04:58:33.0537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9b3a33-cb94-4b2b-e2a2-08dce755dc25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8213
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
index df255d55a5..4b6e88208d 100644
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

