Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D5ECFB43C
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 04:47:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8064088D35;
	Mon,  7 Oct 2024 06:47:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="33DIErar";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA87E88D25; Mon,  7 Oct 2024 06:47:25 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D29888D33
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 06:47:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yS3KUksh6AV1HxeBX5bNl1pHFWhH2BC8oggT1vGdwbB+5D6tbzZvva0/YDLC35uqAmhQlvAGxr3a99OwYnqYZrRP5s12MrldJ0vAF/KkaoxoWtMXTQ5wUjp4bMRYxwXmAYTf23OTsizyHgHNMQhC3MyN9ubN3/ySWoerwOCvBhXZO+CvyEHGfuwUbZQFs5RACEX2WW7ZXqY7hfTqTUaSYQArnebtRuZwkiv5aOPTUuc14zWoAIxxNfSdyyY8IUCMQJyySp6iizPXTZirqB+8uipz3mTZ6T/myYlh0bJQ3mTwW7Ujdh1MtfLQmbAUpiHjYA1WKETKrSa6Qv3GiyvFyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZuudyxIivD+NL+8xnPa1SKY9MdWwFb8Fo1m9lYq49I=;
 b=BXEGFCm5Qz0M12IKl2HLjFcoiwS6/xFt8PnaLdAGgPeXz9TGhiw+3CMfaz9hUQC1qLV2n31Eb7Y8p37zXwxRsth+R/tb68/OP9p9tn0TkJDFQv7qAL8YxvxWsuwDdE/dVgdzJLDZh+Ehb7YpAVbDRCbvgIUydXMDJIEb6fDs5qjikSg61pzcGOhxBsq8/azkSJHKILTMG4TVRgxhT3SvtD4aIupz7axEknNc1HqVZbQUgJ5jUkIj8nY17Mk3mHtZhuhHqNCygUUQouPZomoKWcK8pek5gbC/mADFzTyfAQzZ3uSK/XNVmUcKKGE2lConrMVu+6iGZrTlAIGlb2lQJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZuudyxIivD+NL+8xnPa1SKY9MdWwFb8Fo1m9lYq49I=;
 b=33DIErar3genh3E1okhJHAQtlOTe7tYHMVVtCxA8J2J2gXx3JUQmJJC5CkrreuNvtRMb60kdWmmIHKeHqYBtk4nNJHuIQk+fD9j6IKN1mrt4TET4Modd9RHgzCflOuczcMV0YuFnB+XaN6QXBNjlNllReze4U9GT9amAZyMJnj4=
Received: from BLAPR03CA0056.namprd03.prod.outlook.com (2603:10b6:208:32d::31)
 by DS7PR12MB5981.namprd12.prod.outlook.com (2603:10b6:8:7c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 04:47:18 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::a0) by BLAPR03CA0056.outlook.office365.com
 (2603:10b6:208:32d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20 via Frontend
 Transport; Mon, 7 Oct 2024 04:47:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 04:47:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Oct
 2024 23:46:46 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Oct
 2024 23:46:20 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Sun, 6 Oct 2024 23:46:19 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v5 5/7] usb: onboard-hub: Bail out if peer hub is already
 probed
Date: Mon, 7 Oct 2024 10:15:45 +0530
Message-ID: <20241007044547.23896-6-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241007044547.23896-1-venkatesh.abbarapu@amd.com>
References: <20241007044547.23896-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|DS7PR12MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: 26354e48-472b-4dc3-1002-08dce68b1f72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GKwRBDNtobBmfGRvww90i+cV6ifCUUBle/SJo19y1BOQReYlG2LXCuaH2VL4?=
 =?us-ascii?Q?EYMC4AEzGropMtI9VzjoSbzggqYDW7XcCk95oBIQLrprhBNm8nkX8YuQV0TS?=
 =?us-ascii?Q?b/BNxbiQsPTZKIqe6sW1b0QnxTTt2IdaeVonLdLquppl1gG4guEI7rTkTMAw?=
 =?us-ascii?Q?aKWvNqiIGAsUmCbBowroUpOPpTMoOO//IW6OUEHVKuniV/XEYUN/R90n4r7z?=
 =?us-ascii?Q?kQxBqkynZ2QP2LA7O+LKrEdRRC8GTWRCj0ZF2EAURYD4wNRDwyT0WAnlo5la?=
 =?us-ascii?Q?DlO69WgD/ljyvln0IPhVM2JhZ7wZ78GMV/WTZjkzXiDS3Fe9UTNKCgwMhDr3?=
 =?us-ascii?Q?fxdxBrCSsWBLaojRpESckzfEsQtOKD6rTXuFjto8c06Emw3JrsIop/sOEISt?=
 =?us-ascii?Q?iK+O66PizvNniXUm0CKWhZWWDSZUUYv43Kb3xD50F4ArXBOIBCwHvxZJGSFq?=
 =?us-ascii?Q?irydX0Z86N4YeFxepZvrq1hioBZv66vsNoGiltSTmQgdK90hvmENbE6nEj5T?=
 =?us-ascii?Q?GG1gpfCrqEOOxS90pqT8iLNykdL7pDdy9CvM6aW+9syQXuz8oc+6CVUeV46h?=
 =?us-ascii?Q?zMwS88aHy6xc3slp36yxDzxFiEGW6/E8jetr6cbyTop0TU3dIJm+oBWm8zPF?=
 =?us-ascii?Q?mqfw6jINlWVCiQRx+vRvAs5r4alST7Ni5lrSiFv/+ZT/3g6wlui7jSzycczN?=
 =?us-ascii?Q?ei9mf8vHDBVwnl15Dc9BcoADhMN2eEOjqeZ5qnA+TnsO0/IJdWXGHcZL11rT?=
 =?us-ascii?Q?BYfnAsvUIcYou+7wxPh/GW8s2AUnLoY/FCXec1zLud8wWKYpd8daTU+YAywL?=
 =?us-ascii?Q?fHrrmLlTGFlXRXoX11v4v2rbRyAlnS6vdA4EyjPvzHuVET3kIJ233MVeGHtz?=
 =?us-ascii?Q?r5ofOEr51JD/86aKm8kSCLmmKqYRRbtPGPyz3KP0zNR9MqyGuGpf7Mgt5t9I?=
 =?us-ascii?Q?yZXXItrXN+JrSOcJ1aUm6IeLndyrROOAhU+gU1zhEakgrTuIy4riYxN8a9M8?=
 =?us-ascii?Q?6o+J50dRKytACy+HO00YcRvgs+oaKTWC0NINGKeBfbgQPuc+RmE2JgkyDY9v?=
 =?us-ascii?Q?JIe4NsTsGuXnuWZqlGKi0n35WQhgAGECJTz2Lvm2dWNk4fnJS460EdMXbb41?=
 =?us-ascii?Q?agttVESCr/+f++8VOmOrclPVI3Yz8a5PBG54zJ3sHG+Lv0sAUtJeIIW4M7Ju?=
 =?us-ascii?Q?O1bw6Xx2VTN3xeIBLwLKQZQdVOXRxFyvHbSWQnEOp3G40sK90feW1z1llgHt?=
 =?us-ascii?Q?3z54AKYd6k2Em/UjMgJX88Z69sbvCxx83dH7vryD/M9SUa3eo9oFof3qnYNB?=
 =?us-ascii?Q?dm2OPjzUPydsbzjFOvSyelsNHIya51U/SU5lYlEUdh1HsDgQdImZ2g290sJH?=
 =?us-ascii?Q?/ru4LwqIa0YX/L2WGxsKDxr7/b7C?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 04:47:18.1554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26354e48-472b-4dc3-1002-08dce68b1f72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5981
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
index ba58ff8c10..e7ff86727d 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -178,6 +178,26 @@ err:
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
@@ -217,6 +237,7 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
 U_BOOT_DRIVER(usb_onboard_hub) = {
 	.name	= "usb_onboard_hub",
 	.id	= UCLASS_USB_HUB,
+	.bind   = usb_onboard_hub_bind,
 	.probe = usb_onboard_hub_probe,
 	.remove = usb_onboard_hub_remove,
 	.of_match = usb_onboard_hub_ids,
-- 
2.17.1

