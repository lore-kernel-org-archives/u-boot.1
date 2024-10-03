Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5236CCF855A
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 06:30:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB8EB891CB;
	Thu,  3 Oct 2024 08:29:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UCJsWBJI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7187B891CB; Thu,  3 Oct 2024 08:29:13 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::62a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E17E4891F4
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 08:29:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dYmxpHX5qY50KmT74cVRyZ3P+lNXv+40Ky7Mip6MMiO+XTfNRINvgZ0qUFgz25LJj4AyZ+DmyVHcnFLls50KA3i0VhkEvXJc65fpvXBbbp6q+4WXwHvc57Fi+gJMuR55mVVS7yCLBHswKwi+p+WHu7oCjYbxdOj5Esqt7JyIDBRWKsLC13EkIwSBa2sGCk/mKpdm+eVhtNSxvlCCqV4qP2HR3aUwTeyb0xmin5LZmqf8BrIYtMSeGVFAebQF8p5XPhQ1z30pOp2KX9PBBUIEnYlqZgkmlvyXJ0DGZvcTHoX89/26ccbmbcivveuY1a9LgLwJk501Qmd1oW3vW/p8gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDiGRqhoMZM7XevN6eWjRnsMupda23AvUw8utniH2IE=;
 b=WXDStgKuKuBKmDfiVmQUnf6PxZT0aEOTDhFbVvEPyQyG4UUEohy889DCYk/7IeFjOJ9FP5mkxuD0e7mmttJdi/UKJtIn3unQVvr8u4cxqeDBpG4r27JI6X9Gb2sgSJzYUlGE2bNMRnBxmFw5zF9bwMDXi6PLfBW9nSWQpOpJBD71Bud5mnNuL5Je8H89+Hov74wR3G7th73kRQULc3DSQeUlw56xOSxd34OcX+8jtHxtADJ3HGap4+Fx7y2IadmkYrsVRdud3WpfuM+LCB5rf+QexDBOCmXNsG1+KEKLunjHyPBHd/QRAa2mK+Irk7qSimSc/5HCiJ8uW05NdNVvxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDiGRqhoMZM7XevN6eWjRnsMupda23AvUw8utniH2IE=;
 b=UCJsWBJI8W8E8xpy7A3FctCSYRp8njlTyuffnWuCUr6X52Guw09iRmdcBuW3M5DUaz1jd+Jrg1GbVp9a+o9DvcgEm8vSqEnHqYyA0U0zR+MGgq2aXrRWFDa+jqdZtlafotcuAa91oMZCAjioMz8L2ktZoaQaLqyJpzlYxHc5i1Q=
Received: from MN2PR11CA0002.namprd11.prod.outlook.com (2603:10b6:208:23b::7)
 by SJ2PR12MB8012.namprd12.prod.outlook.com (2603:10b6:a03:4c7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 06:29:06 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:208:23b:cafe::39) by MN2PR11CA0002.outlook.office365.com
 (2603:10b6:208:23b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.17 via Frontend
 Transport; Thu, 3 Oct 2024 06:29:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.1 via Frontend Transport; Thu, 3 Oct 2024 06:29:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 01:29:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 01:29:03 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 3 Oct 2024 01:29:01 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v4 5/7] usb: onboard-hub: Bail out if peer hub is already
 probed
Date: Thu, 3 Oct 2024 11:58:42 +0530
Message-ID: <20241003062844.15338-6-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241003062844.15338-1-venkatesh.abbarapu@amd.com>
References: <20241003062844.15338-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|SJ2PR12MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d6054c3-8083-43fb-61ae-08dce374adeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rqF4aNmig42Hu1U+hJJAGHiMUV3boqalICJxBjlyl0tiWEEP4DINVSpi+OyE?=
 =?us-ascii?Q?+U/HaioMOxmy+zci0Son2fYKvuGp0P3cXMdRC5f4M2w88Nj/l/3VfNuelvrK?=
 =?us-ascii?Q?UiuyzM0otmI7mXP/bbzaZVWDmDYrKpd3YLTXYLY24Im+q4HmGWFSph7L5fC5?=
 =?us-ascii?Q?V437WlKLiG4MWrCPvZfOs5cbfIa45XA04UYO90750qM98X1ADxpFKiG4BDOi?=
 =?us-ascii?Q?lkA1i9X6hmqpNulIutWPq0HudiAKaPa6RUdZcKgXcte26p7NkZFjOr77CjAO?=
 =?us-ascii?Q?plh48D5IlIhiThGzM2td6G8ZW8QxuRbxeeTkV9uXCOV0IqlYRcVQgrOQb3Jj?=
 =?us-ascii?Q?JVoPAeTs8IJMtbC7OXSl7D02MRlLgtmj30hSR2ui+bP9JaHv4K8qTu6cY95T?=
 =?us-ascii?Q?94vrbeTEQOBwcQ5RUABDpSWR1QmQVbnuZ7DuzwGykZe2cE+sPNATZINRfnwD?=
 =?us-ascii?Q?Cpg7WkICy6AfnCMi/WAA8hQnzYcUMPRiUgvUTG79bKszb5D/v+Ewz1Rlv9mg?=
 =?us-ascii?Q?LcON5/Z1h0oRiDs528PniY7e4NnDTSp4otSR7n9l978sxo2hMydy35eWUAXH?=
 =?us-ascii?Q?dirLXbXYc19EfPAqb5ufW3eQ/ABazkPphIEMcNmmWbvtq6Q40o3kqEbH7Hdv?=
 =?us-ascii?Q?Z2Yxg6Jq/qJCeQcDbrRxVxfT9+kklq01hO1mA7DLMhRdY0ksWlhgnLY0hE6C?=
 =?us-ascii?Q?7axAinFytXo/PICSF88WWYFEunwxj3C0wlWP4absxJQa95CsNJfnXBfvC/yd?=
 =?us-ascii?Q?A+5zqM0S+jtP13hJFtXk6v57/J15st+4zG370bBDBSSqCU+yKRbYX2beetcp?=
 =?us-ascii?Q?nhXNTvPLTmagziWX1kctYZCJxJGlLW8b3ZPEW8SnS7U3ExmvP2smXL7Hjb4D?=
 =?us-ascii?Q?Iry+AsM5St7qY42Yo+tU+wduaqyX5Ry8tBx4QhTi104kyuVuQa+iMCR/LhnF?=
 =?us-ascii?Q?2GRi5Ywfn2mrp9NLPM23egrxk8zPPkYBBpJrCUf3VO4LAj8kKpEGjDjyMafY?=
 =?us-ascii?Q?V/1yGUzrsyzkWnCiYMxfcfrqLPdighvlLsOIBYBH+jHwBW8Mv/TsPgSfUoPY?=
 =?us-ascii?Q?GetOiXiZ/XxdHeYmhszTB7UBHYhElH4Ud3ePeGJRuyo3DYdfzxULKpL1ofgu?=
 =?us-ascii?Q?0jatz4lvluxt1nBLSXF1HeYiG7UbMS+Y2YScdeKe4sOcjZMOjuJN7+n8tACy?=
 =?us-ascii?Q?HDKvckfcYtiP9/iEquUtEEYu1DbSQAh9r5Ll9q3+Vep6KGZbqJ7umZbry6uM?=
 =?us-ascii?Q?8dOvw5688carRHkE6KWfrerKg9rUpgQ4qSEzSGHXjlZ3FD3V+bYhr7RXNe5i?=
 =?us-ascii?Q?YRw3w5FsmsosJ7tK/vUZ5rxYf5fIZbe+Ux4RgixTTL6WmO+kVNYlGrSW5rMv?=
 =?us-ascii?Q?1l+/fvQiT/6n0iyE26kF2yO+ouml?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 06:29:05.2426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6054c3-8083-43fb-61ae-08dce374adeb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8012
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
---
 common/usb_onboard_hub.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 94ea01a7b0..e29aaa00d4 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -162,6 +162,26 @@ err:
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
@@ -201,6 +221,7 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
 U_BOOT_DRIVER(usb_onboard_hub) = {
 	.name	= "usb_onboard_hub",
 	.id	= UCLASS_USB_HUB,
+	.bind   = usb_onboard_hub_bind,
 	.probe = usb_onboard_hub_probe,
 	.remove = usb_onboard_hub_remove,
 	.of_match = usb_onboard_hub_ids,
-- 
2.17.1

