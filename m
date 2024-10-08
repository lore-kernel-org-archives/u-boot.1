Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB7ECEFC21
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 15:43:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B7E388DD4;
	Tue,  8 Oct 2024 17:42:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kHMVe5jU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 184F588CA1; Tue,  8 Oct 2024 17:42:19 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::61a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8A9D88EC4
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 17:42:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=byXohQhtDamqbrTsFctB7HVFGxLrnm8Kj4mnISubdE5PMdMQZPPasu1JmH4NP5HVMShr+9FJf26gPgXoeKcLNd1IHrp/6j5vQU3nm9HHNkJPX/TltkztBvS8ITRZzUd4pUybnDaMrV0WfG7DaXifbNeGgSIVXWe/9FMiJ8+fQ3G+W511bHidFmIrLj+mqO22qSjN8XydhCJMYUUB2FAAPYRJMHs3s7/r/pptv3RcAI9E+ixLKBRHieGATCFVLs6etypgkzqGRYY+ATzycOxCB3KFgsvBUCsPDf0ZHPOXTmT+ea8mipPH9Kq+lvw4Lx/xvxzT5aWhnJud7YooKbIcwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlT/8/Tc3sSlejZ78zLxrCLdeR/7bUUWHC2c4oBzfk8=;
 b=lx1ut6T+5K7mYFG7IJ9BivWVmnKba///ko8scYz/mttD8J3v8dlWvD/1Ewzm3sbGDudsgO4CGM1tswQTmz/mm6J3uAMJg9AqLNERhLC1TkTgRp36OcdWMfr8Y1f+HeLySmd6cKoSJGwNfSLOdlUWeNDzqUIqWcQv2z99/QX7YSOjWplyMMyykcVHoLnrTZSszMzYSvJgVF3PO10iW5wzGRpzf3sdo30Q30y2IV3cii/QGQxSAh8zUvIASXMyuwypZzvPNcU2cgLwLx1A4N3Cw+3lR1jUz0W29Qhd5suh7vfMhD+pLyu+Qun8rSxR163yC0RsfjNPgrDLkMF9kPSo5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlT/8/Tc3sSlejZ78zLxrCLdeR/7bUUWHC2c4oBzfk8=;
 b=kHMVe5jUVcDAPLhqUB0AUSG47MZpZnu93o2zjCUJGqDa/VI2mdiCceILTIUJtyBgEFb05pFiLQRoIl/6FJLttkziaSH69f+NBBv23gqMYh7OhEbzB+nZJBeDStUnmgFsf1aEnisB9HHuWwHGq8+RMaETC9Mzzt/AMYOXc+poL0U=
Received: from MW2PR16CA0064.namprd16.prod.outlook.com (2603:10b6:907:1::41)
 by DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 15:42:12 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:907:1:cafe::f4) by MW2PR16CA0064.outlook.office365.com
 (2603:10b6:907:1::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25 via Frontend
 Transport; Tue, 8 Oct 2024 15:42:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 15:42:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 10:42:09 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 8 Oct 2024 10:42:07 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v7 5/7] usb: onboard-hub: Bail out if peer hub is already
 probed
Date: Tue, 8 Oct 2024 21:11:37 +0530
Message-ID: <20241008154139.31204-6-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241008154139.31204-1-venkatesh.abbarapu@amd.com>
References: <20241008154139.31204-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|DM6PR12MB4156:EE_
X-MS-Office365-Filtering-Correlation-Id: 92766da2-042d-425e-09e0-08dce7afc6ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+nDnCoxF2H2LPCnsIEVfuZL5JZt2zUAqplxfGBD7zCtd3HjBCUj0shTS6Zxg?=
 =?us-ascii?Q?yyFH88EP8ltkSpY050TFkb+KQ/AfJ44VfVUoBKeuMKxusD5pTL7lFVlWZzVb?=
 =?us-ascii?Q?giS8s+lX+KHEp1/dwFz6dbd2LlF2zh4Cl+/XaV5MLodK/evNdb2yguAi/8h2?=
 =?us-ascii?Q?UPfZi3d2RGSmn6wqM2NgMYayPTbxhg48Paf/j4ivJwMLVDAsqb04S7/fkhRC?=
 =?us-ascii?Q?hZvi6igoL3e+CalcjAkMIwivnFJLZERsdwMSg89wxp5zTMDGzzvOPwjYjUBo?=
 =?us-ascii?Q?/8U8edqEIHjYzM4d2h0M7WRA/EPVpYgeOfXtn/M8KJif69wRN9frYcZ+zyKs?=
 =?us-ascii?Q?tITMdOZrlrC1SJpJSYpRLsV+ihN16tdIJrrxszuqy322uEykGyPusoMaGlmj?=
 =?us-ascii?Q?2BIEIU3d+9TSqo7I0W5R0SLouRRXrnPhvRyCxFeSmZczokIfi/M05zaMX2mz?=
 =?us-ascii?Q?6Nb0NRBoWOaT1zz70lvG33fyR8ud7DvTy9n4k12F54LYcA36cJna2Of8lYhF?=
 =?us-ascii?Q?10Yoj6MJ+TRPSSXGa7ATNoU84SwTcRpEiFVt+UHvGNui+vpJ3dz6+f5wqRiA?=
 =?us-ascii?Q?9/T3gO/WWCg6yRrf3akkkYzs+fxI3e4Yk/TxwjZ/AEPRia0hBT6WU7yE6weE?=
 =?us-ascii?Q?DUGHiKxZFrN4Xv+xyJei0KbtLI+pUWB3nZvQs8IYYXz5QuheGtT9JmRRqwho?=
 =?us-ascii?Q?MFUGVBkWhNtvTprz3Ml1QoG9BMgyHiNPOJ0rWAvDl5/fY6vMzyBiB5RPtkJx?=
 =?us-ascii?Q?Y978HXYRgf/lcJo38zhSkIZLUC2WiY6h+1vPmQM2uO8FmT+hZ3w41BqG9BpJ?=
 =?us-ascii?Q?sDYjasQqIgotucel2glQFB4rsn+rG9aHfsXJK1hIifcM8G2BOc/+2Pug7G/k?=
 =?us-ascii?Q?cqBdP2K6FIcqra0a/mx1XzPnHtCJ6FU6mGL6sxjxTfwaoOuvYwZxv3ubBOZk?=
 =?us-ascii?Q?dxkzRY7rbhqpJOEEYR+18/+xqATfSeJeycyYozhz32dtQa+cCEGZIGQCyH+0?=
 =?us-ascii?Q?0UJSL/je6CUBCJoNcAaS+u3tzJIBMMGCoexnIewjQBfjngHHtoQkXnEvs1pK?=
 =?us-ascii?Q?BWpYciIQaDdyVh+bc5Sd+U2as9c9zIzE96HEDt7iGBhDOpijZ5EVkzpFxk/i?=
 =?us-ascii?Q?JYZXGnaERb5s8bhWLcNfFAOQ5KXjBVnL8KMKPrdp19TYXXaW4dHABaqJoKXQ?=
 =?us-ascii?Q?Vv3kEkxiYcjPAe8IEB7BTv/RE2tps6f0hhSwyfRfqBuDIJm9P2++pqAujsTV?=
 =?us-ascii?Q?PKeJiLKxhuAIWgggT4vldFTFGzkL6R3Bf3xykATa+EKzmHOk09lwL84xXcLV?=
 =?us-ascii?Q?R+g1xeapWrDWfGMPRHum3hFxVKHVStI20+SlPy4qNOu8OH39RrEa0Tzi/PP3?=
 =?us-ascii?Q?UcIZJYPALZc/XC6UsRCLaO+ly6fQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 15:42:12.1143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92766da2-042d-425e-09e0-08dce7afc6ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156
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

The .bind function is implemented to bind the correct
"half" of the hub that the driver wants to bind,
and returning -ENODEV for the other "half".

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 common/usb_onboard_hub.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 1a3569a135..661eeb4bcf 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -177,6 +177,26 @@ err:
 	return ret;
 }
 
+static int usb_onboard_hub_bind(struct udevice *dev)
+{
+	struct ofnode_phandle_args phandle;
+	const void *fdt = gd->fdt_blob;
+	int ret, off;
+
+	ret = dev_read_phandle_with_args(dev, "peer-hub", NULL, 0, 0, &phandle);
+	if (ret)  {
+		dev_err(dev, "peer-hub not specified\n");
+		return ret;
+	}
+
+	off = ofnode_to_offset(phandle.node);
+	ret = fdt_node_check_compatible(fdt, off, "usb424,5744");
+	if (!ret)
+		return 0;
+
+	return -ENODEV;
+}
+
 static int usb_onboard_hub_remove(struct udevice *dev)
 {
 	struct onboard_hub *hub = dev_get_priv(dev);
@@ -213,6 +233,7 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
 U_BOOT_DRIVER(usb_onboard_hub) = {
 	.name	= "usb_onboard_hub",
 	.id	= UCLASS_USB_HUB,
+	.bind   = usb_onboard_hub_bind,
 	.probe = usb_onboard_hub_probe,
 	.remove = usb_onboard_hub_remove,
 	.of_match = usb_onboard_hub_ids,
-- 
2.17.1

