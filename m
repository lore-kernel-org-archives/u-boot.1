Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1637CF855A
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 06:29:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 802A589212;
	Thu,  3 Oct 2024 08:29:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3u52tyOA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 002DD8919C; Thu,  3 Oct 2024 08:29:09 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A3CA8919E
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 08:29:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHKhHS0WABOemZ+F9zqfKLK4bouZ2plwx4SC7+oGcfYAg1f733qx4R4VE8TZszedOyE/PcNZYXcXeN/iOLr4f1zPkw+uNbT5ahNvp0x82YiYaAvQPyFtLuB83jkDj7NzxDx7WzTFncylDWSyRepJ2yi0cUQnsQ5EAcAuUEGSp6Uim/RhHADGv+4B/KxBTY1cVzAnqRnlfVlKvlgFKfI9DHCGKGndCnpLYIYPlqMeVRDlUY2FE7KoOUnaBs7sIqdwLQb1Gq6PFnI7vIFk5f2vN6zNr30kE7GujIBpZjjyuGOImcZk8IBnWacgC4m9pcuav7ut1jDYVOxsgsPtTd8t6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BoJj7gx01uw3YD5aV6u8Tga7gUWgd4PFPc8wNPzHibg=;
 b=tmPFmC2k/IHQU+jgIVUvnBSXAUYtvMy5kwQV+Hwr7ffhfO8pz9usHzGl+krv3q0TpSO1bsgKXxd8JN03fXvzULMWvDED8PqB+LMixO8vDf4J3IjxbkkJIJad8gyPA+NYgY836K7NrsiMXM6d9Oq0D+GjKC68M1rTh6yWqFYnVPtbx9XP9/TTPTyzHKSSrM1PmydWBMIrwPsGJO6U3CSbYaQs+2By2eF+RUbQyfQCayODBBzODiKmUlmvr3rve/paPsfGNWUQ0CraRN3RGHJs2tS/Hmjbn6MRH3eh7vWcdZ6xb9cpMbbRGTrycEDHd21Bmm4AjUS6facIAc3KzMktMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BoJj7gx01uw3YD5aV6u8Tga7gUWgd4PFPc8wNPzHibg=;
 b=3u52tyOASkSRiSWg5imc5RLTLUGfpkbXeoyuVR8pZPcUz/PKO9Fb0cidae2PBQicBXvK51VxZ7d+8ZSr8UzsHPALvUaSYuxheAU0AkYw5VW9pVFzPQvOnjMkUrUWXtTbzacfR78SyJPze4DHqOdkvk9oIcDDfRkHWK4byx3r52s=
Received: from BN1PR13CA0013.namprd13.prod.outlook.com (2603:10b6:408:e2::18)
 by PH7PR12MB9224.namprd12.prod.outlook.com (2603:10b6:510:2e7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 06:29:01 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:408:e2:cafe::e2) by BN1PR13CA0013.outlook.office365.com
 (2603:10b6:408:e2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9 via Frontend
 Transport; Thu, 3 Oct 2024 06:29:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.2 via Frontend Transport; Thu, 3 Oct 2024 06:29:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 01:28:59 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 3 Oct 2024 01:28:57 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v4 3/7] usb: onboard-hub: add support for Microchip USB5744
Date: Thu, 3 Oct 2024 11:58:40 +0530
Message-ID: <20241003062844.15338-4-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241003062844.15338-1-venkatesh.abbarapu@amd.com>
References: <20241003062844.15338-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|PH7PR12MB9224:EE_
X-MS-Office365-Filtering-Correlation-Id: 174279a0-3d73-48d1-dab2-08dce374ab3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ophn/8fZnm0Miz7zR4EZEl5Zb7YABe9MsQDTQ/OaACeJIVvz1WcowYTJtCJR?=
 =?us-ascii?Q?3TDRhsBLGUyPbtntTANLlXp/tqmwWhv8UaO/XRmkYYmsyODVeAjYZWgWf82U?=
 =?us-ascii?Q?/7qI61Ml+6nD01j48696O9ZUuTREDMmb+ppq2OhqFHmN2xpWaQP9avvpXDkR?=
 =?us-ascii?Q?TtNk8GzmsZC+Q+Pf0SCiocOthmGCR3YukJyupH2iSkCMFWkk9+1qibYLkGxq?=
 =?us-ascii?Q?2ExhfJFoj9jLDlvGivmTDGJFjW9JFPoBi1hbu0HvlbFoX1ew3+tbLEcwGs3z?=
 =?us-ascii?Q?8uPDiHllguQs42P4LTz5Bz/mNtLfFcup+M/yilvW4HVTzBmCf3WwENhwBzaS?=
 =?us-ascii?Q?o2Kwnio+39SbyFyWRXbhwENQa/8Swy+qo3zY407xlYPt86jpng3Utnudz+fc?=
 =?us-ascii?Q?+RenmJuiU22TcpQ+bx118cNe20O5iasQKtdDoLkM0Bb5rMmIuT1kQNMaoSJq?=
 =?us-ascii?Q?XqVnCOWVycQT0LbKyHjd4/4xQ216lpBJquTP7PjFZXU3t/30aDLczaGzk1w3?=
 =?us-ascii?Q?U3PntZUdnPcmHrPkYr38UahqSeJWGWVbBQvvW3vpjUff4mEHpGga+AwiC9J5?=
 =?us-ascii?Q?FlaFbhnMMquHo9z0o4DJ8u7VU7WY3T+lKxNsMtTlec2DYtUjmlMQlUMmz6jh?=
 =?us-ascii?Q?eJEH95pefA/WiKA5EKprd2r1xX/+7DuzF5ZzHg6kAjsb5UlkB6kvTe0Nv+JH?=
 =?us-ascii?Q?INhqcB3ve8c0NVqh+C251i/4eAScq6BfECIKWhceEZ90kTTIhS+KAk8AMSAY?=
 =?us-ascii?Q?daRum09266mbdmWA5cojomeR18rcOLc59ydscgq9HLOCPnEI6tuBdI3GeWzm?=
 =?us-ascii?Q?ESHJJN0OWF76kNKoBIl4YTGq88gPlsMaWpck3oAg2ltayDmSGNiEvd6Qgbro?=
 =?us-ascii?Q?7paRxTkxRpmSER88GFfZqpvljo+jlN2Auf2smfLMbZnHuj93ZH4elXlWHIem?=
 =?us-ascii?Q?c4HTLnupT+8DoBdD/Do2Afn1MnoENfFl2Iuf/wDFxZrR09DfgjbNLdXc6bpD?=
 =?us-ascii?Q?L/iN1QblVeEjpP8nYH+FYP1lo1fO5xoF+kQmPRk+eNYRVvLS+Dp4TvNg3X2p?=
 =?us-ascii?Q?xbssMWZkUJI6id73U5Ywrsndq+Bf+7m6O10ENZyH5R82t21sHN6rOTu0rlOw?=
 =?us-ascii?Q?/ZSWv/Wu2wSzmQi1PZOeYwU7D6021GleiQjKtoeWkXYDypGt7c3bGNBfm+gN?=
 =?us-ascii?Q?xSDtVNPYX/NOwPxX9shLl1OVOQ1NbLU18UWpPHpLm1of6EcrLKbLSJXUOa+3?=
 =?us-ascii?Q?csolE3qEQN2kBsNSvIT75Ww34hPqLploZes8yVqvE8lTlVo3Lnsd1v1SG+Te?=
 =?us-ascii?Q?BfnqKfYnxGPQIY+KCN90QzdhiAan6953xR7IMYCTO1jSrSstoVLu/RvNVSKD?=
 =?us-ascii?Q?9xKn2Y0hok6eTd48P7a8Qv6tAxnt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 06:29:00.7590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 174279a0-3d73-48d1-dab2-08dce374ab3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9224
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
 common/usb_onboard_hub.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index a9fc9bba87..5caebf8574 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -82,10 +82,21 @@ static int usb_onboard_hub_remove(struct udevice *dev)
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

