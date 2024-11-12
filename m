Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41C4D41D52
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 05:12:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83AEA889D2;
	Tue, 12 Nov 2024 06:12:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C5g4hhk5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 781698888F; Tue, 12 Nov 2024 06:12:26 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::609])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 858F3893AA
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:12:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRm+LdRYwxgJEE4eQzdxB1Z7z/cRAjAOAZXl21e0SfYqIm4LejfWF9hnL8gzywkjHsFU8t2KwBEzo+wukL8Z/oeTmnrkyqQ4jN4m9MAuVAf1vpkhQkzaE1lfYE/2ozk84EilS+SfknwVeyxtQrmfKcZ6f3s3q+6ymh88US534F0XfiKRY3lpu8GRseRM34WkvyvGCkHYJ5GB+O3ul/CBJjkIjy9Wc/5a6looP+yMd9YRZwcftggXaD7XjiHR9Hvc3Ak5fjhR4JFAUqGHHdYTnS0eMNZI1hIrqtA2YG2IHuy7ooEcG8NwvBZgxi2uwq3wF4Q88i+T3LzkaS2i9qsaXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RP4Bg6a9E9S3dDwBsWscwqLVrRulPL2afnhz+uXo+Q=;
 b=V7wZo66BYUjEOb7upGzpkYQPHU/a9FHJaWm20AJDmU3q7TdJB5KgPJbL6zsix+YvGd7UVNRHLSgDA+vIKrnugkWcsEbb7puqIfKAd6UDcox/d8je06dQ8AKFKaYfNVOykBJqsTjz0QAJQtuhsKkj6pCrtP/idd+nbq7NTugXdV5kmsC6A9Ugrkituyt+nIJbWerQIZ9wi0RqzNkgT6+LCgrVwYkpbCC44ggY8Mfkxrdvx7e6TWN45xxgg4ZqEL+oFV7JtOB+O2YhdUMGuP4rGJ4aS4t1rdeuE/Hh/+Sgztur3njLQuwAZ5WUzW6HJKWF6CHLChbEmgZWIbQ+BDrxGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RP4Bg6a9E9S3dDwBsWscwqLVrRulPL2afnhz+uXo+Q=;
 b=C5g4hhk55u8WCeRqy8dYGo9zn+UbVkGN/RrqIJNTXF2Ey7r/Othta6DBG7vPTtWVWYREgsFGuaQEc59k36kdeTCwX5O6PPX8c9mC8bBSSF86kpTl1HZWABVGOVauxpyKKZzRiwsEX1n1qAfF03mfRNbKOkgrT6j09O7fo55UFkg=
Received: from BL6PEPF00016414.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:c) by CYYPR12MB8703.namprd12.prod.outlook.com
 (2603:10b6:930:c4::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 05:12:19 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2a01:111:f403:f901::3) by BL6PEPF00016414.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Tue, 12 Nov 2024 05:12:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 05:12:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Nov
 2024 23:12:16 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Nov
 2024 23:10:11 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Nov 2024 23:10:09 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v11 3/7] usb: onboard-hub: add support for Microchip USB5744
Date: Tue, 12 Nov 2024 10:37:36 +0530
Message-ID: <20241112050740.15343-4-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241112050740.15343-1-venkatesh.abbarapu@amd.com>
References: <20241112050740.15343-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|CYYPR12MB8703:EE_
X-MS-Office365-Filtering-Correlation-Id: bdcb1f7c-f136-4587-0677-08dd02d89512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZrodHe37r11hl4Pt/IhI9ARa8v38hqXNiRFBCa/ObZ6R3e9jWtSqop78zFhI?=
 =?us-ascii?Q?2r6Zp2NxNXf/4s2QyUUfSvy3wGvtX7N7vxOa6Ttc9bRpzCYSNOd5W5eS9QxX?=
 =?us-ascii?Q?xvEUUHuWIx9yxjr9sm7ljTCeCKUqEsThuUyO3zGgKyFy3MX004rRIaKi/Hy/?=
 =?us-ascii?Q?aDEwekPr0g5kOi2Gfmnn8uFJecPekO368f/v3JkP4ePXF/oS9Q9vKTrNaLal?=
 =?us-ascii?Q?ynpD65UysQTboG/jh0ExUC6fflGh8SgORb/+TLDsyYFW7OUh/3SvElSj+xF8?=
 =?us-ascii?Q?wt3Ao48ZvWGrl/NWFoPCDqUc1Gut83i1Usks6DG5Wnleh0JFJWjdveB1hDX6?=
 =?us-ascii?Q?nQPcCshN43JtnPX4bVcua6dq1ocIdsDPoAy7y5TzJTnO5r1D8DsC4h7pfVJy?=
 =?us-ascii?Q?r2MacTSI4KN2Ny+mulL8t0HUOkaLBmP4PqrvAvx/p0+5syDtVm+Kouoqno8j?=
 =?us-ascii?Q?uETaQHKsW1u9z1jB+qwQIAcTh8P/Ws/Hk/Appos+Cw1Ymry+wetXZf61/dup?=
 =?us-ascii?Q?BmqyZ3wn05zJrMJUfwwfjltjjiMDgsuOJ/GniQLYSRdUI7KO4Myh8JSVHQzz?=
 =?us-ascii?Q?YoYx0euUkcOh41excD2G/OW27KXQIIZKjZGAyIaFRc/8MpttUlfVoOCFPT1k?=
 =?us-ascii?Q?dwUdpRRAfGrJpCyaC0+K5w5H0IAxpStOIsoMrdCGmZytoP6TqRIi7eotjzgr?=
 =?us-ascii?Q?tUpv6bhxg0tObIVcBHFbuNAib5u4t0xWMQh4b0/8HzQSRC+6B8XWGy5ABvWs?=
 =?us-ascii?Q?YwLJWIDCL1LnMTpvkGkxyN8j9znDUGdaK74w88mCO0fDmO1z3lbg2bjyHJnQ?=
 =?us-ascii?Q?zvY7Jeln7ODwhUTa0eZk+JTvKH7SdCWR8KXwsLgg/RiKdhd/mE3bqdrgBx5M?=
 =?us-ascii?Q?P7UITScievC9qdFDhlyGznvWb2iyKcSlizMIComjp9VFIrVye4Fd9FjL/5uk?=
 =?us-ascii?Q?PElHlOxui+ONEs5b2idU5NygCV/ZStbZimFs+Gzn4YijLePmCd7g0FSZj382?=
 =?us-ascii?Q?o4NKWYLJ/HtQJsYI+FZX3oGCbAc6dK40RfWAU4Ymec3DkZForqI5bpjGkyd7?=
 =?us-ascii?Q?zPu5jB4sdkrFJvgLT2wjJNTBGwgGXmAsKN7VTnPcBYIZblhVcFzzOQPh++8v?=
 =?us-ascii?Q?tQ3GKMRbotlik2JyzlBloLYbwfPMnmnsh39CcQx6f91JsoZH/7h3GRCGPhav?=
 =?us-ascii?Q?mQzj3SgTakTI0sypPiyNN+hiSXmDenwZ+i2Wc2L64vKREPuNvY4q9Dx75DEu?=
 =?us-ascii?Q?oRkNQZ0LCKhVjJNOfHvS6nmSQc56YmuReB193U1NDOJxHU5e+ZixLk0lTf04?=
 =?us-ascii?Q?ozjJ+v9Itkf0jhRLwvnURwKRIU6kOVc/q+3r0D+UxaNpTGeejvHZHziqmQqv?=
 =?us-ascii?Q?z6IzYYr9x/1U8oKaS3Zbl7+EuTC4CiQeIiuw7gLL/8MOkbcCXQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 05:12:19.3031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdcb1f7c-f136-4587-0677-08dd02d89512
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8703
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
Also update the usb2514 hub_data with the reset delay as 1us.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 common/usb_onboard_hub.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 827ecf9b02..1d146eccee 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -88,10 +88,26 @@ static int usb_onboard_hub_remove(struct udevice *dev)
 	return ret;
 }
 
+static const struct onboard_hub_data usb2514_data = {
+	.reset_us = 1,
+};
+
+static const struct onboard_hub_data usb5744_data = {
+	.power_on_delay_us = 10000,
+	.reset_us = 10000,
+};
+
 static const struct udevice_id usb_onboard_hub_ids[] = {
 	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
-	{ .compatible = "usb424,2514" }, /* USB2514B USB 2.0 */
-	{ }
+	{	.compatible = "usb424,2514", /* USB2514B USB 2.0 */
+		.data = (ulong)&usb2514_data,
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

