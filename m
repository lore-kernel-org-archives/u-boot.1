Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9B0D41D6F
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 08:51:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1F82893BE;
	Tue, 12 Nov 2024 09:50:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WWDDCpPH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1343893BE; Tue, 12 Nov 2024 09:50:53 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::609])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B411989432
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 09:50:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPzGAtu/qY9ASBxpTQ/8P3IP0g9oXtRK1YXvHw6eU47SWKZSp1L9BXB6aZVWCPRP+dg6uQMBKeigejofFMwfIp/aP6YHSuFhP4zJbM2B46344oWAzDa+0UCb7PUwHJyRRYEMHg8ybqaOc/jPdyfr8Q/Y1GVMe3xmOnIxrLOZs99sV609jZnWOpzJeEdrsqY8zguxr/wEXtw6LxDkgat++CFHXbwY+gA/ik/k6Yj+7z+TbBov4W37QixWz10iGL2wIVwSsjNGoOtzmiLitAWagcO/6GRFpWlOIYKqSIbEjy8Z+7KySfFnqnA3sV9d+FNgJW1Su5866z3FaRPvSsc4Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dA0+gx0HUol3V4BBCpn1PBlCgj7fJfRazv/escQS9oU=;
 b=B5YFp8LJtBSs11pps3X+871MjAsHEDHRhuObFxLzJM5bWaBoV5WRBRt1g9urhj41S4u3r/Kfa+Pc6ZzQYaCw8PRw78AhQq4M/QmkAo8+2evJGxvaDfViAhqztgDWzFB+ZEMYZKIu+2SH6A48Rpua81rju0wDuIuIllnhO7qc+WybS1FwHDT8GWZ1f0HqoICG60aQl27n0t5iTOsufgzy5gyWyrAVWmZtmjPw8p9zzKo0ECDSJ+9yrEvq4sKq5uB/a+tkrxU/OATuESXgh5jD94t3AwbvEwAa/rEaxZbUD/2uwgELJjGA/uwINkJi5yMmzRKNzuamBQg0viceI+xWKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dA0+gx0HUol3V4BBCpn1PBlCgj7fJfRazv/escQS9oU=;
 b=WWDDCpPHQkcN8N7YDtPx+kYwBEoRuR+S3ih0EGB+lN+EMVavMN7aCwJ/Ph0E6z3iNJhiYWPwAZhL7VYWtOh0LyAdeE0avBqVX20BqBBs0Umu9NZ6sekNZ1AWlFvGTKEg0NLh98KaI7jP5UxeWieEitfLj4o88Sf7NYBRIAXAc1c=
Received: from BY5PR20CA0006.namprd20.prod.outlook.com (2603:10b6:a03:1f4::19)
 by PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 08:50:48 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::c4) by BY5PR20CA0006.outlook.office365.com
 (2603:10b6:a03:1f4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Tue, 12 Nov 2024 08:50:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 08:50:48 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 02:50:47 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 02:50:45 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 12 Nov 2024 02:50:44 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v12 5/7] usb: onboard-hub: Bail out if peer hub is already
 probed
Date: Tue, 12 Nov 2024 14:20:25 +0530
Message-ID: <20241112085027.21352-6-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241112085027.21352-1-venkatesh.abbarapu@amd.com>
References: <20241112085027.21352-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|PH0PR12MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: 062b7b08-ea14-44c8-0d1f-08dd02f71a8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E+P9KbPgD4OJhp2fgUu3NL37Ce2Q7wanwrl1brDF54m/7OkViRaFguba3bgM?=
 =?us-ascii?Q?Y6TH4HwPmUfz/5kCralFdnfbJutbCulSsB9bGVKooTdtt1GUiS/+y+DpTQec?=
 =?us-ascii?Q?TLfNgnwlxmlfPF8Tra1sNTSqJuduwa0maVw6ZBBTVuMK4t2m4DU7BmeXqUtN?=
 =?us-ascii?Q?MKJIsh6NcWVvYciKfeieal9A1JefBEp1r3ubSszbyVTxhNtOBKoJo/iclG3g?=
 =?us-ascii?Q?hVZ+MeLVk2c3ypDHj4p5z00Z6D7tTw9j4mFF+i/hZg2uhKoLIT+wgI7Bo88f?=
 =?us-ascii?Q?nsF3fRd10nDosR1gdTSUKcHEdhivgS28OzbghRKZwyREpeA0QBMzUhNPOWiX?=
 =?us-ascii?Q?zGzz90faYhb0IuTi7WYvW2qeCBd+esppP5ZT2q0l6VozXr5mJQ2YlBDAo9AT?=
 =?us-ascii?Q?GscrDrM+GycCk3leSGuTS6oRVvBxvIrAU5l23DLgG4kFT69yzvp2gvoRvR5x?=
 =?us-ascii?Q?ZxEWgsMhq4StnxCgMg0rFZ1P6cclwWoukCdnZrPFMyOBBOKgq4OBfiwIR15n?=
 =?us-ascii?Q?BKvf5GwrrHRILLcz1R/RTjORqfWfvC+9dGY9anSd8HP+6ZSNaKMjIPxuY/h5?=
 =?us-ascii?Q?flmPhshWFu4QSTvMJvdNeF6HB5WL1iHDaHoYTBbRG7Ix2uAvazQcJ168Y+JD?=
 =?us-ascii?Q?XDUBcTky0kDV7Iu2D3PU8t8sSjmVHW7O+xmSdVbv6vGCyvli4huIQP4DgvoK?=
 =?us-ascii?Q?gJy+3dewL2N9iufU85tvVp3BHgu1GkOYNVg1v1hmJNRoBE/v7ceeo0lPIUBt?=
 =?us-ascii?Q?lsrjM4LoYwcpULYaafWwAJC3bkNzqmhCxwZ1R/bEABpbWR7VCLbN3r+bf/Ae?=
 =?us-ascii?Q?X/UN+mjL/oGkJpE6kpNatB/i6jjk8m2IUsCCYm6LAq9HwmthzForB06BFl4K?=
 =?us-ascii?Q?JWPj5FejpESqJ3ROr8beeT1cgTwzKrJetm/fW8Ms6NKDipb8dcqrDnGsfYuo?=
 =?us-ascii?Q?87Ee4nVz4zvQGAon6OkNGIy0lMT8i6qAS09ljpZSy1J/l7+XRBegP9q2U5Fb?=
 =?us-ascii?Q?Ttyh8BC3o7UVbHOML2XNkf121SztjttftNY8DsboV/x53DHTDir1NnBEPGf0?=
 =?us-ascii?Q?PDiy8SmrMu9qou5GegX7tcIMV1Q2rKwcWYS4GSVo3S1ZiVGeUUvgVsR8pE9J?=
 =?us-ascii?Q?wacJVmNd47ahIYHig7q+2YdotVVpte4FOVi2XVstyfYBoFqcGp5CAonojglT?=
 =?us-ascii?Q?RNMke4NkGFLT49wQKQqhb+nuJIJWIftgvKJvaKZoTJ090P6lCsxXastKZu5p?=
 =?us-ascii?Q?B5JD/cSnbThJhjgF7gwQb96Fz2XtBEopDQkb5V49QPjztLfbxQ9NWaqLIorW?=
 =?us-ascii?Q?F+QDI3ICooDeMIfc/IY/qr4Re0oqAeNa9/VPOWyg1GerlrclGikuTCETQRc8?=
 =?us-ascii?Q?VUL3jj8HADTUQ+3LqC2Jf+p/1fYjfgUmiBpzcoXBtB2rYwlj7Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 08:50:48.0388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 062b7b08-ea14-44c8-0d1f-08dd02f71a8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7957
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
index c01cafdfe2..61780af085 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -176,6 +176,26 @@ err:
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
@@ -218,6 +238,7 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
 U_BOOT_DRIVER(usb_onboard_hub) = {
 	.name	= "usb_onboard_hub",
 	.id	= UCLASS_USB_HUB,
+	.bind   = usb_onboard_hub_bind,
 	.probe = usb_onboard_hub_probe,
 	.remove = usb_onboard_hub_remove,
 	.of_match = usb_onboard_hub_ids,
-- 
2.17.1

