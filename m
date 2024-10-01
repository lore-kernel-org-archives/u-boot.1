Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FDFCEB2FE
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 05:13:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6269D89114;
	Tue,  1 Oct 2024 07:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hxcgpyGz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24EA48911B; Tue,  1 Oct 2024 07:13:11 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DC888910F
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 07:13:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=seWUqyJmWhpbV23/UAQJ12hi6QLGEtTeVQFh4WbWUhf1LoIEBaSSwmzaswGqe0MVLwgCOKTqBL6DQc7ta1XbBZ65VI3t3Tf96hUzu/lXUnWJcjOmgt05B56LXP1cIt72bd0dirR+gFB08cRC4aTBXW5DxS5Unaz1o72K81wtZT7syl4bc+vSbnSsRl0pr5GoHsvmCKmNqUgJ+uO3Ri85DU+nftKvpRhWoUuesLC1o35OHI4TlbQphQKm8ZiVcFPvYyZrqZWU71m/2CsgAJt+5InXiHMjNNaInL5xG5DQnB/TgmfUnzAmyzxGiF7h7KrXn6eCFhyFq/C+dOl3JPEohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1F41p4o8ZriZlTJSrhqdl3wD1bPE6VgsXNZn/GvGNYQ=;
 b=kXn5gfIjhl2Vg8gpEBPA2qTydyOokGai3nl7XkMCs0iDEszojLygiaiofmwlFguT4px4KSs+sbVOLrfSjCHpcTvFI+WmiyBo594/B/QVJt229Y+6dElE1tSbywyFVxqydEqUhGPTtiFfZVjMU9A0pOs2F0QByqp++pghe0ABpH88cXioST/N/yllWxPxRmHZNbhNBADwwLCQI3JAzjOYnGPe/Kqr7xGJrqr3wP7Hw5MtEzEhB+zNXTUONkly6lHrwVMiNVihPT0yFrDLOjnqf+nHBeBEpkb50TdioUJCHRqkO95dVt3xOoZql+ey2G+JkhDkEN9mYVnqLlIw2OVQeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1F41p4o8ZriZlTJSrhqdl3wD1bPE6VgsXNZn/GvGNYQ=;
 b=hxcgpyGz8TJm9E+ZO8H++YA0wCyuDfQlknSgdOfcnRq5tUEAPiCwb700jSYNPPQixR0CP6KbicsIS1QUFWB722PHrczX9ZSQWDd+UT59+wV4BvbS5DS8xz1wkjXEDZkfE37TS/RrhS16dxQTqrLOT1hpN2Y6UeTHoQpq62lH22g=
Received: from BY1P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::10)
 by DS7PR12MB5816.namprd12.prod.outlook.com (2603:10b6:8:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 05:13:05 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::5c) by BY1P220CA0015.outlook.office365.com
 (2603:10b6:a03:5c3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Tue, 1 Oct 2024 05:13:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 05:13:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 00:13:03 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 1 Oct 2024 00:13:01 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v3 3/7] usb: onboard-hub: add support for Microchip USB5744
Date: Tue, 1 Oct 2024 10:35:25 +0530
Message-ID: <20241001050529.17922-4-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241001050529.17922-1-venkatesh.abbarapu@amd.com>
References: <20241001050529.17922-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|DS7PR12MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: 36aa371a-524b-44a8-7213-08dce1d7bb5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sbTg+JuRW9F0nWJ+uicaOD03p25/kFbfpZ9Hw6kf21ISsLJ4rG0qNq6sQg8p?=
 =?us-ascii?Q?WGtyke/+thoSmI3+47KP77JZjGMmMA9Q2GuUXroPC1oHcGPQdiz4uVe59E3v?=
 =?us-ascii?Q?5yMA6ocFBuATNDh9aTUwSYFcOu13k69LWwhqT4Ep6wUwUZZKGd7wwdyYOgiv?=
 =?us-ascii?Q?0uCviFlMF/z7h6zq6ou74W9Qi4q7Rss/FvPNLvTL9yZCd5WsdKctZmC1xuPC?=
 =?us-ascii?Q?MP6YA+E43qy9fb5IZAvCiVBN4LrjfOBhnBsFdZbGPmXS49PTkWS311eB+A6I?=
 =?us-ascii?Q?GgrJodvtoTG7/kqpx25wdpC3+Wg4AaYoNLsrLhvE89vXWaXtpn4gOREYha20?=
 =?us-ascii?Q?OozMs/BAdBr49Rx8Zmje+v3reHRaaeLwvt+ZN+6yGwkTMSr+Z6tfQ5Fpdzwm?=
 =?us-ascii?Q?US61pVvWr6qn7nCQVxeeSt29P0y3N3+Hos6DAkSwgoa9Gpj/z4lgYqPsjAzN?=
 =?us-ascii?Q?zO4rLifho7RO9We4aw3PxLa6CYF9IrAYArlPYHPL7ILVLgvwALhVyXGE+sSl?=
 =?us-ascii?Q?S2c0NXit4umEyEURcTnr1FVeN+7huPi1THedzhbKNOuneiGmAShM8fKDFnnB?=
 =?us-ascii?Q?Z0MWhy4MdxOAJILCMZC9FZBIvB7+VQ0lABpGhpvpIKzsfR+whjYoTQm16UkX?=
 =?us-ascii?Q?Rzp4+1j1HADyR1z0s41Y/s3D93BohHfgMoTszwnOkQqoD0/ovx+tD1TxYCEA?=
 =?us-ascii?Q?JqZiHzQfaeIWO/S40mxlQt1Tqx0BoUUlRVflJQCVBeiu6+Joaq8Lox0Fz2SR?=
 =?us-ascii?Q?RIoa2VyVQWHPb2ItWFYlCYNDVnntIRt2tKmMBBVVhOkojtToJ/o1+1acSkan?=
 =?us-ascii?Q?/zkrS99GHAXryVNWJf/3HfaOsFb7azciJXE97U2hJXkNQs7s82U5v1kpfZrl?=
 =?us-ascii?Q?pBq74g33wKXBe3ooMVUPhkV2sBqbPGV44M6kyBrid0UsLbM9ZZLqYnHFh6Tt?=
 =?us-ascii?Q?RAnw/9fkALs6nn7vToz1zTsu5iB8RarOpTB1Dt4mhaCfZ0v4EAe3XmCW2xDE?=
 =?us-ascii?Q?yAZhoiYvgPI0DAyzsu9wNQr4zSVekZmz9ccevlfvKSaC8TAKgF0g8bFqBpn0?=
 =?us-ascii?Q?Cawkz2y/RR+5/J1diLtZVtWCL5L5u9il1GTfsdhBuK83CFve660PSWO9/tgi?=
 =?us-ascii?Q?luWrZWIehcDXUPuEqz1J98eZeIH0lJ3my0QTfYB0hTvpfbOh7TCVSdMu9Os3?=
 =?us-ascii?Q?ck0Q38ylTqPKRnL64wtUDquSa5+4MwoAtFUXVm+/nkeDaio3gQplS2ZyfHdM?=
 =?us-ascii?Q?9TxflHivmiForV2ry+wNmXSY44e1xbpBTmN1sRYhY6LHezxw97DMZcLZjtyI?=
 =?us-ascii?Q?mkUBXh0TYwP1bMkF4jgKkPQxPjL3tH+KyvSGPSeRKnROz51sHToa03bmE/2f?=
 =?us-ascii?Q?tLnPYZaEKhXWhfZ+i72PRICmnkxi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 05:13:05.5886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36aa371a-524b-44a8-7213-08dce1d7bb5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5816
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
---
 common/usb_onboard_hub.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index a9fc9bba87..8319144d10 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -82,10 +82,22 @@ static int usb_onboard_hub_remove(struct udevice *dev)
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
+	{ 	.compatible = "usb424,2514" /* USB2514B USB 2.0 */
+	}, {
+		.compatible = "usb424,2744", /* USB2744 USB 2.0 */
+		.data = (ulong)&usb5744_data,
+	}, {
+		.compatible = "usb424,5744", /* USB5744 USB 3.0 */
+		.data = (ulong)&usb5744_data,
+        }
+
 };
 
 U_BOOT_DRIVER(usb_onboard_hub) = {
-- 
2.17.1

