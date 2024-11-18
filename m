Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E52D49208
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 10:08:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57D0989463;
	Mon, 18 Nov 2024 11:08:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2N/bkDeN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 918AA8945E; Mon, 18 Nov 2024 11:08:21 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D467589469
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 11:08:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IwmYr055v7xm2bNeCgkgHoV1IOSSi3xkvSjrhpSHLdDT+u4A5wDRDRzyZLiBev4+Rnw8nx+/WlFSQdZ1HBV/VaI0QmfeSnPUtWou0QjSLN8m4Fc9yJUigrFubBZtI7oP6vV47cv52Z/2ps4wRWzD36DRrAAPRPh0aafW2ZPr9ZEOZnPGQOZaydGb1exY8qM9aL5pO0RrEkRqz8HFq7zcIGWH17RLN9TK4WIWlhOQZ6iNxvFTG9x3zdRItjxZ0puqQAEt2lRkIpiThnqSTznlaMTys8KoPrfzZriqywuqPxyIBELTMSbvTzbLZBc1sTCD6By0+RLtd3dUvKx9DYWAFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErXK0DaeqJkaCBVUxB7VkdpJYddOnynIkyvcJt8mypU=;
 b=muUEOUUAUOCr3d0SuqVJZFprQVHG1vsSsnPO8+7881iZLY+1OH1a+hPgvPPGbV4KmUV7omtTRHDkbPKj2jGvBIrOdeFRnB7R8e22h2L9ILTu1BhDt/ADzibbWKmyaG3DFNAaupAtfF4g3pbQ5B/rmgphx57s6hUnj4TvQHq9MVXPHAf1X+nDALO05E1QkuXBKDZMLJzVPH3lV2UNkHZ0VZDr6g+50veDZHzGK0NtL/szgGGidnHPaVZTUGk+yfh5pRkV2BvdBCah7g4VOkV2MlslpEUp7AriTTCr8ers/uPIqj+WT6PXWn/wC5zc+uRCojlWHX6KR/GGOWRP5GsIFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.12) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErXK0DaeqJkaCBVUxB7VkdpJYddOnynIkyvcJt8mypU=;
 b=2N/bkDeNjRnck1ILxumbmiWRQT1eDKEYZCRSC15VimFxVweDXuX8PWKLyFlWD8J5GYRdWpXQTfjwNEKEruXAAZPWDc3hyCHI7C/tA5gmo59IuMEXkpV7KB84bg0RLxSkO61q2ixrJ0jAzyaTuX4r8JVEQWtfrDvie2qPMixLK3w=
Received: from CH2PR03CA0018.namprd03.prod.outlook.com (2603:10b6:610:59::28)
 by CH3PR12MB7740.namprd12.prod.outlook.com (2603:10b6:610:145::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 10:08:15 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::51) by CH2PR03CA0018.outlook.office365.com
 (2603:10b6:610:59::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Mon, 18 Nov 2024 10:08:15 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.12) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.12 as permitted sender)
Received: from SATLEXMB03.amd.com (165.204.84.12) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 10:08:14 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 04:08:02 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 04:08:01 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 18 Nov 2024 04:07:59 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v13 3/7] usb: onboard-hub: add support for Microchip USB5744
Date: Mon, 18 Nov 2024 15:37:43 +0530
Message-ID: <20241118100747.30121-4-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241118100747.30121-1-venkatesh.abbarapu@amd.com>
References: <20241118100747.30121-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|CH3PR12MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ecb6400-9283-498b-76be-08dd07b8ea87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?auGkwpyd/A/0dzgasE9hEZJH5sDNfIL6yaiZ3vycxWvxn3N48TRPyX4G2GwK?=
 =?us-ascii?Q?GohiRw9GzIPW/MM5uvBJpSYUgXnb9Ppi1pKsihAMU8+BIUKTiaLCnDoLcdfu?=
 =?us-ascii?Q?L0ZLQ7Zem/Cmh6UKUPgSBDwVXNu0sW7uGLJcQk0Onhs84ZpsrP3Qke8zi3Ze?=
 =?us-ascii?Q?TZxZhjMR3pC2qqRIFuXT8hq8R1Sp+rlEza69NkwTWW/nIXe6vx6uQbKdcWUu?=
 =?us-ascii?Q?toA6EsJBziqvnu+buxiGjkJ4+PUjRVp/A+BftA8ylviTxaJdG9mrmUJl3lmn?=
 =?us-ascii?Q?boa2di+UXlY1kVmYvXw6/GjagJM1rKGj0YvpAB2cRuh7lePpBgCicmZJ/8pz?=
 =?us-ascii?Q?9pzJeNdMJpHxe9DRkO2lKrMy/C49k9ShYypJvMthb7M62vPUN9rKK0s7+I6q?=
 =?us-ascii?Q?brsP2tKQzfFiyGbKRTx6fIXP5accQ7bQl2sbfZKgIMYcM1MpRtPJ+WqCJhsC?=
 =?us-ascii?Q?rKCpjV8aDx/wGeZIg6KP9K24KBYh6FXwU0bpqCkszy192FkoWrAGZfuIFEaA?=
 =?us-ascii?Q?D/L6G9yzoEmr9+OWNdUKSjrEpSlPPnUXPN1fi/IJJAvmi/cLgGYOqiy5OzpM?=
 =?us-ascii?Q?W3yCXcwTB6GmFFDzmKDpjfvYcFKgHbqPhwXwDf8ieR6MzgqljtZx3u8IOUJw?=
 =?us-ascii?Q?oZHOJng++6F80OlzUd1dVA2Dqj1VWXhnn1tuQXEqCU0eT0VLjUoDbGzrl7D/?=
 =?us-ascii?Q?icR39kuVbQpcTCFgDZiPPBs9Gr+zUn9p4EnfmsoijlCQt72LKaly0tyR7674?=
 =?us-ascii?Q?kPTFFF20yF8eRgZ/Dhv7ZRKSEhkkP9/wUwUjQ4fPT3ytYYrQIOw3xVkzkw7D?=
 =?us-ascii?Q?nBJxKZQXs48OVlF/3odPHkN34NozdknkwPvcKoHEw/kDuTt337WbV70fNedD?=
 =?us-ascii?Q?hcSdyxJTqb+90gwr//pAsz1xPzbrHVJVquJUGRdl8NMdDwNRbrysJOco0ISa?=
 =?us-ascii?Q?skJ4ik6MywgBV7CplNXhyZF/XDc6FhCjVEb/mKwFi4A0zi775zJ0AmNSr9Q0?=
 =?us-ascii?Q?4ieHmki6hZj0pd4QMnhL78V1iAS/Iwr05Re/sUHwtnxfRzE6IMUS33qSwRen?=
 =?us-ascii?Q?rXqPJmsjmFPuDa5gXcQN2x6DEFvhbib1dDTsZO9IJdqSCdand3pKy6667A+r?=
 =?us-ascii?Q?6Ls/eO97ZrLSh6rkcEa7oXNpINYRJKZP7oJJ212g6XubUAWesXABG3SlyCiu?=
 =?us-ascii?Q?gtxC20DpeDEKcgkUIKh3sFbFnNIESxa9trIWOUvx7TZDzeDBGsIVJO1MEBu7?=
 =?us-ascii?Q?GgmpNgskGjG72xzzkD72v4pl10LgKXzpUj0NgmXFXN0DiFVnTyrGKSvMZfGB?=
 =?us-ascii?Q?XoPQlqi4Hf+cpL31Km/nDpn+0+bK0bWSDHAMX7HjKxa/hbqoyqAsOQvf777Z?=
 =?us-ascii?Q?dEiIrHw3uUg2FfJ5LCHVevMiHhRMz5e7XUEuUmioeFauwcESug=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 10:08:14.5976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ecb6400-9283-498b-76be-08dd07b8ea87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7740
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
 common/usb_onboard_hub.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 812e7749de..4860de5323 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -93,10 +93,21 @@ static const struct onboard_hub_data usb2514_data = {
 	.reset_us = 1,
 };
 
+static const struct onboard_hub_data usb5744_data = {
+	.power_on_delay_us = 1000,
+	.reset_us = 5,
+};
+
 static const struct udevice_id usb_onboard_hub_ids[] = {
 	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
 	{	.compatible = "usb424,2514",	/* USB2514B USB 2.0 */
 		.data = (ulong)&usb2514_data,
+	}, {
+		.compatible = "usb424,2744",	/* USB2744 USB 2.0 */
+		.data = (ulong)&usb5744_data,
+	}, {
+		.compatible = "usb424,5744",	/* USB5744 USB 3.0 */
+		.data = (ulong)&usb5744_data,
 	}
 };
 
-- 
2.17.1

