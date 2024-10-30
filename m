Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A81FD7496B
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 05:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA0B9891E3;
	Wed, 30 Oct 2024 06:22:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HleDy0AY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D825B891EA; Wed, 30 Oct 2024 06:22:50 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::614])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E287891FA
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 06:22:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHCGSvBjfgQGyIbjyBQBA0fwCGFs7f2wrk64uMWyBiedZ0wUiq6JdwmoeDpma7gNs/MCGvNAHKbK/gw06v/zwC1p6njZHae88jNH2GFp+7BNABGZrhwHaJiPIzPHF3poMxCc5sWndLGRMfwzJsZ50XbvYSh+tolEGpJrGvfDSHzXKXE4MfPbTa4js3cfriHJFJF8Fxhks8T0FxiUbeC51735fq/liFN64iMUTodpEi8j/hABHOFpBzr7dal9IoxDLnOpwg8iwzgprotPe5tzj/lG+vb+qjyBY/TDyy1R54fg5qoUFeNUmj0yzuOBeFu6OC4uIqx1OxLxBzUfoPdP1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlT/8/Tc3sSlejZ78zLxrCLdeR/7bUUWHC2c4oBzfk8=;
 b=DvjEWdsVW5/0CwAOnvc+0J52sx/81eLAqYj6YGje01NnaMwCix2l+Cw6pHAWiToSJnMwFTJp/e9aZGLodT5RViHiMTylPEyYkQJjarIPzhCKELE1G8tzUg7wLCmdRB4+Y5xcIKsReQrp3i96WM+ti0ZSG4lfHXHsaPTQ9x1HVdDkjRTHHYuFEq/x2zIrqJMaVvdM0jUs5ooiYWYGQIrS5WhKYCe2+NWh6IZ9BtlAvIaw4qI8n7Q/yTe3Pco5CHdWn45auzakR4eA2wrBDbrm1xYTQCuvzRbpcywC/0zd294jTnxXts3Wk1wWeFIjLDeN2+wjZAUY6HGeO8CBwQbRSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlT/8/Tc3sSlejZ78zLxrCLdeR/7bUUWHC2c4oBzfk8=;
 b=HleDy0AYc7O/mh2rDzzKjhgmdMwK+rqGveprenLCacezVrZC3OEPBc0iL8af/CejOhwJxJuWYSCv+mw2OvSS+rph91t7+ASWrUQGU3223a6kWWAzBwiZuqRFhA48IfWRIV592M7gLKfHSE6cqsdC31yEn6XA9P+tp7VGb7p+dJc=
Received: from SJ2PR07CA0017.namprd07.prod.outlook.com (2603:10b6:a03:505::17)
 by SJ0PR12MB6781.namprd12.prod.outlook.com (2603:10b6:a03:44b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 05:22:41 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::c) by SJ2PR07CA0017.outlook.office365.com
 (2603:10b6:a03:505::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Wed, 30 Oct 2024 05:22:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 05:22:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 00:22:38 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Oct 2024 00:22:37 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v8 5/7] usb: onboard-hub: Bail out if peer hub is already
 probed
Date: Wed, 30 Oct 2024 10:51:58 +0530
Message-ID: <20241030052200.24243-6-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241030052200.24243-1-venkatesh.abbarapu@amd.com>
References: <20241030052200.24243-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|SJ0PR12MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 5093140f-6e41-4e64-2c6e-08dcf8a2e05a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GOCgzWCafmPqygNhEekMI61IkGuRQIw4upCrCY+aA0XBqnl/dXB6Y5mTmfuG?=
 =?us-ascii?Q?vWoRF5n/jWAUZUSZ9QgG1I7hIuijf2xswW9TzU+9l8PggxRFqv7jqAwN5o2j?=
 =?us-ascii?Q?55CfX1397v9BG3rIJzajZaGbCvSweDRAsYklBaOX1LKKnYPr136SozQoWPDZ?=
 =?us-ascii?Q?ePI1CusCjvQWZBlxIU4S/e635ryoZKmhlMWGKkM8SAPIRwQ3ejrryJEicpkI?=
 =?us-ascii?Q?FgNF7tixzjLxU9zUpOcc3tlMExis2qqT8lbrzvCCQ7m79q01Ww4qk5THrX8e?=
 =?us-ascii?Q?H3DydHS5wjk77gfrd946k6r2itYZL+XMLrMI+AI0HMBfMZOX+UwZmAox8SMa?=
 =?us-ascii?Q?9g9C9YKYFbRxdz4ypGSoxZY0IlC6c9IIcODjV98s+/axHBbuIzxW64O7fuf+?=
 =?us-ascii?Q?E5EtrlZhpDxpQjBHlegfifL427pi76Oh77yQXd9oNgUKPqR6CojrmszXYSHC?=
 =?us-ascii?Q?giAFUSdO+oaNCp361heY7uS1oH+NO871V4Pbgfy5Wtu0riROvPIgC68wlipG?=
 =?us-ascii?Q?uafg4TvMhywx2VuLm91XdELRcRlZjpht2FT9CA16uevJi1HAkDVfj4wCpF6u?=
 =?us-ascii?Q?fyhayQ4oeI/k+KyjXG7lIeTtq3272C9AT5K2a/gsxp8/AW70OYNh2X+WkP6v?=
 =?us-ascii?Q?3Ozw0RcFnTNmAr4UAZncRB7MhcF/w/D/eMuKHzmesCQrNvKigRzzX511KslV?=
 =?us-ascii?Q?MOZ+ScS9JRT6PTRTFU2fMbQN2/H5Akrn/egP/K9xJOf7luQqohMXliESfSRN?=
 =?us-ascii?Q?SsfOk7wG7H+MWEWDUDgze/uTQ6Sw+CAsFAjWGjcIJWtJyTFYQktdlQAOJYkq?=
 =?us-ascii?Q?GIn6HhfTUL8ZpNNx9pbDHsvCtnC/wH511pD6GCqq94xOp1Ou2oi9SALuhi1f?=
 =?us-ascii?Q?ZG3kTUv2v12v1Mfnf6zEmgyylY1oeoCTudcsuivqzvBQgvUGydyZlUg54IXV?=
 =?us-ascii?Q?sp6gk3X0/brVD7ykxB2gEEWtgzvqpyV9xE5a5DpVi+hefc6V8uQ+tu4OpsPV?=
 =?us-ascii?Q?psrksdg5JrIUs22fB8QN/JwEA/RBCvRyJFWK8TxWt9Z8bml80CQEVSYMrLrT?=
 =?us-ascii?Q?PK+t3Hn2X3/u5hx3Jges3qM4eQ6Yr0dhz269g9b+IqTTg6/StGdKpTlAZlyi?=
 =?us-ascii?Q?Q2tL7+frl3mVA9guGLDlR3ot6j9eWWVR7t6AMB1qMrxLZz+iRMAuLi7LHqdS?=
 =?us-ascii?Q?B1j4OiaWTXNIb50KbodjGLvuYj15QK5rFxN+8g6zx7jBvTm1PSfIVn4+tfX1?=
 =?us-ascii?Q?MRr705fLvL664p6vo3dNTlckxQ2y79nJrH3M6fbSC3Dlsu7Ly386ImlqIL9V?=
 =?us-ascii?Q?Jo9bW9zalxTj+SO6KpIKbIGlnYSVGCjAAyW4xLnjBoUDCUWf4WASoobxN0Jz?=
 =?us-ascii?Q?El2xX51J3/7tMDlMAHue5GAbFO+a/z7+c6HXVEwJ5S6aJC3EvQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 05:22:41.0601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5093140f-6e41-4e64-2c6e-08dcf8a2e05a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6781
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

