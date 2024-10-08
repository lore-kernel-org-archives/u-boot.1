Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDA0CEFC26
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 15:42:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8E3A88E8B;
	Tue,  8 Oct 2024 17:42:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VvhbRE3t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E921388E00; Tue,  8 Oct 2024 17:42:14 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 333EF88E31
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 17:42:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQwAGMXq3Wzy8ExK6hnlrIiUuGUq3F4vuKkJlX5FIUZpJPevdjxxyn/jg0xduGju5XLhzZfrOMSrCmw95W55VgGiP2BJ7txMKyjFCd6yBwzhPYiNbm1xkfJsEFkoddNajc8q+9s/j8dqWKO6vEAtXT47fHWrvNDFD6Plyz85x25h277jR69yXX+/J4ILx7NBHBTHVO6lI9n8hPU3UFX0qR9DgMa2mWa2PBQdewcZCrhwJyn2XJ6A7T5bSAzDoVM0g6oS20CV+vsAXwstJ5VIZ8Ek07xabV3awpN0c8S79PsNhPJA3JwXd6jLjasp55wd+xHjlGuInMyVdDR9nRVEzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6j0Ph+90PsFW5Qi8AlLrIsECGUYnU2rbmv1pBt+bw80=;
 b=cF5nvvPg4/tUakt7B76TK1j+FB6WpimvBUhsGb0UU6rny5St+zXun52sklM0JELrU40DkWZsyonDfLYYUADMxDDJwiWOZaWBnI7Hwg3oWr+r7x0S5Zv8RZpPQkIERjnz51F8opU90lERxMnXSDZ9+GFbSB+D/ESOZxtK8LufBH9L2z6qlxMGA+6EFKtNmwao2E8dKaP6/agN97pvId6m6Kl4p/bL/f6PwB8UIrKaOr2PMqkhWJQdBKipXniSMO1JkcDiZilW00zRrrXNkrBtLlRg57RTyVTyq3WRR/ozXpmvwXeehw716/B2Mg3RgzseGN0KyXdEqpwd5MZJZJst1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6j0Ph+90PsFW5Qi8AlLrIsECGUYnU2rbmv1pBt+bw80=;
 b=VvhbRE3trXkMZdrCLfy/74mnlIobtiIUe0s9vTHe3eMaJcbVpMv0fgGMVBBxLdozIvBb9rdfuyoAZK9omAx1Gq8xTuP0fjTYxpO3y2IdnofWwViOrOv1Fu9RgYl3sU5rITVGQRRah4/H3WS7VwLorXRyHdGulKk3qaaBt0leEmo=
Received: from BYAPR05CA0104.namprd05.prod.outlook.com (2603:10b6:a03:e0::45)
 by CY5PR12MB6153.namprd12.prod.outlook.com (2603:10b6:930:27::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 15:42:07 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:e0:cafe::9) by BYAPR05CA0104.outlook.office365.com
 (2603:10b6:a03:e0::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16 via Frontend
 Transport; Tue, 8 Oct 2024 15:42:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 15:42:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 10:42:04 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 8 Oct 2024 10:42:03 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v7 3/7] usb: onboard-hub: add support for Microchip USB5744
Date: Tue, 8 Oct 2024 21:11:35 +0530
Message-ID: <20241008154139.31204-4-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241008154139.31204-1-venkatesh.abbarapu@amd.com>
References: <20241008154139.31204-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|CY5PR12MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 973c04db-677b-4b6b-1c43-08dce7afc3b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8u643CVOB70irpXuog165btvAf88uHxxWNm5xr+cre875DUYJNDjyx/zqqI2?=
 =?us-ascii?Q?tVso5NXjQ5bVsse1jCe4M3G4QrT8BiXprhiTVJp1qMS+xpqNGjSAQvt5F09L?=
 =?us-ascii?Q?EAMLOg7J/dTCcTBqTsOr6SWIlMT0E3Fb0PnbfZbILnMztOheQMthWEK+/y0M?=
 =?us-ascii?Q?mkN5SXVDYDYGDyEMGtbNcEhLxX5JmsDaJtTFcEGhs8IsoAOUYbKIm7AKGUdy?=
 =?us-ascii?Q?gb0BTMWRJMYrqYtEvbRXdEF4+npT8ddLjw+/oRiclnN/fnT/jH0JemfS0VrO?=
 =?us-ascii?Q?HqWtv9MXCTJHlanW69IEkNo+dtkhicf5yet4fz2htdNxH8Losk9pBpFfLZoF?=
 =?us-ascii?Q?8hW23zO+LFZhvAYzMZ65NciC0voRfARtQQbFPCgBhPGzgt6d1yTe95fA3eFv?=
 =?us-ascii?Q?hSA17rIqLFcS4+/IYn3Xc367BYfoApieydwbtZZz6yq6iZoxJGtyUooA3zrr?=
 =?us-ascii?Q?IIZ1HncgLbqLoCaUsk2dRcC0xcogzH3d2uavnfVYeWreoGkqFkFlJgnX4eBS?=
 =?us-ascii?Q?U6txXtn2M6EcNPtAL7+O/mpJZaCKdE+WSeWFaPmJCgq2CpsCOATVlT7vmuUR?=
 =?us-ascii?Q?MIz/j4I6roqweR6eEk+i9RZVu6tz4TqQE4YvUm4yik4lrU+tI0jz6qUNSrEm?=
 =?us-ascii?Q?H9Bv2cECBKk1FQqQgJ78863S3RB13IV+k94/dv/S1ab1DbpVyVYn/sop8ROE?=
 =?us-ascii?Q?1CHl3yzaeLiyzNPgzZAzdm3pnvl0om47pLYVrBenO3Pqs7FORxt/BDeVcamx?=
 =?us-ascii?Q?5llk+NymiduzBifKjcUQCgVfBSMq1CwgljRcPZt4EoRR1M/t3uF1O8ar3NVv?=
 =?us-ascii?Q?I+GYf7A6coTWSu+Y+OTrvbSoiObDIKjkwiQKCJvF/8MvixtbVe6XdCGKvt4q?=
 =?us-ascii?Q?Wzbz7gG42h5eZJCWhRM6MPmQGIx88bUi2ShOSIdYbm5ZB66korHdHALM4x4n?=
 =?us-ascii?Q?TTRTU3XAVpzDeij+h92U54QHrMoygKOvUBQcnynNhKE0/zmYWnzcX8KINLrQ?=
 =?us-ascii?Q?r2WkL1emLnq4DNyzA75vVTkW68v5aWjJqetCDRo7OC0sZz+m7WM//5EAOLOW?=
 =?us-ascii?Q?ch58aEedadEw1hcQdfNxeLwg8fWQ0iKZpOyPSkgj/Ffq65zoj77bHGcpHtFh?=
 =?us-ascii?Q?M4QTyM2Rnrz4TAmQdcmVlO6CDZIkW+m01ZtQEBuFzcl8v3si5KT+MmxF9OY2?=
 =?us-ascii?Q?BIoFRZOptNruLaJgd4C3uZNSWJU8V1XlKwEEGogra73IzwiM5SRGXVNiJxFx?=
 =?us-ascii?Q?jHn5QgvJPb2N7XPPoOSub7+A6vpTo6pY3H2FDa1nY40QRTSB4g3yudUCjzbA?=
 =?us-ascii?Q?VRm3hExvW7xfg4PPWdEsqQ12eB7RqhjPm/5GtfyH1vJmUR23x8qwD8u4p4i0?=
 =?us-ascii?Q?SLnZs9xeGF4k2xLln4RtIrbDR0/u?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 15:42:06.6884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 973c04db-677b-4b6b-1c43-08dce7afc3b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6153
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

Add support for the Microchip USB5744 USB3.0 and USB2.0 Hub.
The usb5744 driver trigger hub reset signal after soft reset.
The usb5744 hub need to reset after the phy initialization,
which toggles the gpio.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 common/usb_onboard_hub.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 6ef9c87fc9..53b7a9c3ba 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -89,10 +89,21 @@ static int usb_onboard_hub_remove(struct udevice *dev)
 	return ret;
 }
 
+static const struct onboard_hub_data usb5744_data = {
+	.reset_us = 10000,
+	.power_on_delay_us = 10000,
+};
+
 static const struct udevice_id usb_onboard_hub_ids[] = {
 	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
-	{ .compatible = "usb424,2514" }, /* USB2514B USB 2.0 */
-	{ }
+	{	.compatible = "usb424,2514" /* USB2514B USB 2.0 */
+	}, {
+		.compatible = "usb424,2744", /* USB2744 USB 2.0 */
+		.data = (ulong)&usb5744_data,
+	}, {
+		.compatible = "usb424,5744", /* USB5744 USB 3.0 */
+		.data = (ulong)&usb5744_data,
+	}
 };
 
 U_BOOT_DRIVER(usb_onboard_hub) = {
-- 
2.17.1

