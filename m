Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD223D5E124
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 04:04:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C1F788FFC;
	Fri,  8 Nov 2024 05:04:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n4mzRQes";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3914A89021; Fri,  8 Nov 2024 05:04:05 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::615])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7B5888EE4
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 05:04:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUM3jiawgLjVynFrYo8rIGvzNnQ+6rx38prJvqk6bKVMbAx5kA/m718l7SUeNMJdQKC2mQeVKkKsBDypuhqEc7jktV+D0bDH9oGgG9c5i4GTdrJptslHV5vGIOLWV7jPg2+jYjuQNjonxtWL9/+Iokp9D+sqF6ZVAC7l9o1LMSveNl/vBPpr8xg2gPwbnCMwS/mkWhfUpDc8stXXJjLhv7b0sLrXrnxq1U8p5BUsl2MsnGLzTgmtPaYQHG5zpfyPyCCTA125btOQQ9/xy2zo8wgmsdtSpJulyY0vnamV7Dgh087Sr8+ldHaH/Y+JY//eH0hJ1XQTzPIOjbm3vew9Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkTEfhFQyU+PJw1ypQXAepHMdP9jrrENaZkICh8CUXw=;
 b=vu9vm9Rv3qHoYZ8YKBf1eCHc5EvBbIMNhgGvYjmXjMmQfiIiAPO+aE+a7UxNEW7XtAnFqwIpH93WTh6gzO8dKP0w13pImaBRYtl8xikCyTjxbtd7r6ZTNMekc2XD9XIztobjsHHRZDpxsYaminlpvIdkCZFFzt65xE4wpm0xjY56JFDuc/ziYbu3rcQlx6LvLUyaYwtgBsLM6Vc4yMz5/hQDhT0TQ6t07Z06dGNI5czaIlxpF8/DIRYCRf3gqTPpY/fDVt6eyOX49fZQbmG8r0p60/jtEEfs1Uv++4W7ELGUmBrgtH4UdiJfMWx40t4rttsBVl1Wf+BS/FLTLDw99A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkTEfhFQyU+PJw1ypQXAepHMdP9jrrENaZkICh8CUXw=;
 b=n4mzRQes+r7EeIWX0tr/jiX9ro0zniCI0gxp6B9evHRHE3xLWyBBK4JBPyzgV+8w2z5PzQsJjWGPll36KBogv0/U/Whz2NzWkuPoB+RF6TX2AfmeDDihfJadTDXCxfqRXo/rM9B2sTGnkp7AJmCOTd7C8N44TyRWa1hdZl7Bmi4=
Received: from SJ0PR05CA0082.namprd05.prod.outlook.com (2603:10b6:a03:332::27)
 by PH7PR12MB5808.namprd12.prod.outlook.com (2603:10b6:510:1d4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 04:03:56 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::5a) by SJ0PR05CA0082.outlook.office365.com
 (2603:10b6:a03:332::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.11 via Frontend
 Transport; Fri, 8 Nov 2024 04:03:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 04:03:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 22:01:20 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 22:00:14 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 7 Nov 2024 22:00:12 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v10 3/7] usb: onboard-hub: add support for Microchip USB5744
Date: Fri, 8 Nov 2024 09:29:55 +0530
Message-ID: <20241108035959.19970-4-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241108035959.19970-1-venkatesh.abbarapu@amd.com>
References: <20241108035959.19970-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|PH7PR12MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: cfa510d5-fdb4-49d7-a783-08dcffaa5d9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eagTBseyzLPbzYRKcKOEylG2gNs0tpfYBe8fRvbdrFwX3BNoiX5hytSpBlnx?=
 =?us-ascii?Q?H577ocSTQbfmjT/ntnJ0kdfNaCsNAijMQK3bKZ36UZZdashy/K8sB0rloY8D?=
 =?us-ascii?Q?TPon3crB+AEXw0fUtTyJgRGjqQ/26Fr2+BaxfT7DcVSe47uG0SjBQxf9m3gw?=
 =?us-ascii?Q?497srGsPN7+DRn8Sb5vrfNa5WxW8x/dZur8TtSTWp4t51EA1i6gkX6pQw+px?=
 =?us-ascii?Q?0iWnq8q/dEvm8rUrgV3IelNLIpudOsGK/jLi7Ustm9wGxDWCOHjLo5Ci0NDK?=
 =?us-ascii?Q?rIAvWRmODHPIwcqGLh93ZwZXM37bjCFo4hkMp3sHmXn3zdh7RWbzO5Pgio8g?=
 =?us-ascii?Q?r4xnrfnQV9f9TtGmWc30svb9VRoNnJ8yvS64EaYSMnGhwdyYtz9Cy8gU7HZc?=
 =?us-ascii?Q?Mg1vnd+F9+n1AdvX3n2WIIBYkJ/9a7nQyvpU80RnHr0XthuDhApKhRbeOhvh?=
 =?us-ascii?Q?z1P+4W7eMOQ44MiZfICD2cPLcnJMojacRRIbZXPClhKG87OiKTE/sULd9/eI?=
 =?us-ascii?Q?eaNKe9Vxu2RhP4YrY6uPoODkOnpwAQm3LfG9p/pKqFMzZjCUdyAXs41dILWk?=
 =?us-ascii?Q?Z3AFKgVFIMKhIhyplRRM2Zgu471Oob6Wk2Mx7hSWso9aemE4Jk6oIyMo7Y+M?=
 =?us-ascii?Q?GuqXneqMNhiUwBbkiqsO5Be1/EseT6t7HnmHmQby4H7+FV3qQcb7dyepavNh?=
 =?us-ascii?Q?8OqNGetvELpgE3cDHFn9jKB54xlctTzjmIt0Y4UBaoK8gAPEab1iRy9PTuh9?=
 =?us-ascii?Q?5ElT3IwKZmZ5xnWtsjsToz1qujTK8FcggZ4rGvP6ZCZX9/NP/QTkhu6iuYVo?=
 =?us-ascii?Q?jMw0n5gP+2xjVkLE7wAHo4IBAgZY8MXF5ETbEKix+iCi8QHCP8aF38SwUba6?=
 =?us-ascii?Q?7PmeLLEiEvfrwtdE+yaqluhg7rxdf9+ZKubeHQYJDF4KsylnIm08WLCV1QVn?=
 =?us-ascii?Q?23b+aeJhLka1YP4coQqEz9GNpKl1iQj94rE5l8aIHpvCuWWukEaRWHQF75R1?=
 =?us-ascii?Q?YGD/C0moU4tEzP43Pu3vJWg68NuAwbSSXFJShvHCQH/PUdGjhHwJjR5esBkA?=
 =?us-ascii?Q?dXgtSJTIFnhPLS4YO4uP8AfzDSiaSg+71Tjx0dtPAVDQHFNpUdNyKT26gDBv?=
 =?us-ascii?Q?OTY6gw4N2JJZYPqreqI9n8KEC/tS4CPFzJ+FIK7efzeH8uoq4Sg8s4JWHRJO?=
 =?us-ascii?Q?USfwDCh8X2+ha299dOoHlcreC2PBIHo3sn4CYZyaBmVxQ1fbt7wing70NnKn?=
 =?us-ascii?Q?jHfUvlhH1r69CYkWSx6GQVTxmi8VsWoSM2XV1o1+h6m4CcwZWC9qAc7BeKDX?=
 =?us-ascii?Q?B6d8rhs/QaZ/wo8ilzMJaCBfhEuDzabA6Dg/Kn0V1yZPBej1NgT2wzQBCH8+?=
 =?us-ascii?Q?ugau9D5aJrvIv9xY2bzoAamUL2jcB2ognQeG8ixAAp5DW+fMJQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 04:03:55.8276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa510d5-fdb4-49d7-a783-08dcffaa5d9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5808
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
index 827ecf9b02..e604c86d8a 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -88,10 +88,21 @@ static int usb_onboard_hub_remove(struct udevice *dev)
 	return ret;
 }
 
+static const struct onboard_hub_data usb5744_data = {
+	.power_on_delay_us = 10000,
+	.reset_us = 10000,
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

