Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8234BCFB43C
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 05:01:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EED4B88CFD;
	Mon,  7 Oct 2024 07:01:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RBrTlepM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A41668860B; Mon,  7 Oct 2024 07:01:39 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::62e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40ED488D25
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 07:01:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aEWOlPdnunnw6jd7s9mx6JZQoJn0O9pNfAKygMjCx9TWn2B9XASiv2DUHX0IoVBK0kzL+nT6g4tNy0ZfxBoZ51nFgtuyUTMsuDG9CwnxQQzdYukgWgD8Ujj35iKqMsue+1M+fZQWenUoBr2lBiIFfRJFMeto6UHTt4wUxP5QmBpuDosdU5gfcaDHGMR8RsalQY6KPJLK5/CD1kRMPI68iC0AO7lumIOMtQyR7EoEE2c5R3nFvc4eTlBJMQ30L3BeqrK/xSxADg3vy1QmBlcVdUj96/tcHOYtbwYydIyS+YIflZP/PUuxWIEOOGrPw73Ug4mj1UUSHFF6N53yDIyIpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Af7NijA0YNK2otERavNQ5//a4sggYT+eomiJ5s+S+vk=;
 b=iMG9oq/Glj2BpTpprD8jpx7a4jfcqpAfD9Nlj5uGkbTVOglJ17za2NRVGqdwJMyd/IFoTy88W/MILONAFPdnBMpvQjA2r4hgyRIG4wt+wM0i/yZTdpk3xJTUs+4b72JJN/sYekV128OqjDV8r2zGXqCvDcDy5QEWaod+1eja7qjMMAIrQLARHALKI42gKSpPjYrxJUXjDUDj2hXl1g/urYP7S4n9e+76g/FeWxOg+Ujn2LSAE3xgNtXzRbYM8zyi4b3K11HgKbBs67xM+785PFAeaM3iWoa+h0aVQ3klcic3voUHgZ96wPUk4+giZ7L86+x6SN3syEIIYRhJtay30A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Af7NijA0YNK2otERavNQ5//a4sggYT+eomiJ5s+S+vk=;
 b=RBrTlepM7ggHQk+i8VRn3BD12LQarpSEIxV4WPtoUvgxeQQFS775SbI1nGdoUBijAYeSSGidwoMo5DmGeIydzWS1B6XvsqJbKS2eiDGrc13FoUlXLafzviUfn4CqI33ABC8pSwLTtfaBNtic54V7AxVnq0luRaUF3m4lAUPrefU=
Received: from CH0PR03CA0448.namprd03.prod.outlook.com (2603:10b6:610:10e::11)
 by SA1PR12MB6893.namprd12.prod.outlook.com (2603:10b6:806:24c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 04:46:48 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:10e:cafe::da) by CH0PR03CA0448.outlook.office365.com
 (2603:10b6:610:10e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20 via Frontend
 Transport; Mon, 7 Oct 2024 04:46:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.0 via Frontend Transport; Mon, 7 Oct 2024 04:46:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Oct
 2024 23:46:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Oct
 2024 23:46:10 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Sun, 6 Oct 2024 23:46:08 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v5 3/7] usb: onboard-hub: add support for Microchip USB5744
Date: Mon, 7 Oct 2024 10:15:43 +0530
Message-ID: <20241007044547.23896-4-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241007044547.23896-1-venkatesh.abbarapu@amd.com>
References: <20241007044547.23896-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|SA1PR12MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: 00f9ba2b-8937-43fb-e862-08dce68b0d2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gwyE74ZFbtunylVOvsDVbHasl6n2Qprx5Ru58mZaBLFDPcxgpmuH906Y4T92?=
 =?us-ascii?Q?/4yWsfTb99mH+JNJ9fj/288mUBe4ZOlgdUkMXjMb+z/B9vUYHm83HUo2AJDR?=
 =?us-ascii?Q?cDcljaC7jr1YJkNk3OEcxGXhooW8Pm2KjDnhr64MsWmMTBzDSZty+xw/3lBs?=
 =?us-ascii?Q?pbDuMNPovETw55867RAaO+u6kbjmns95VwDU0fAVB6YwPRH1BRl6ovz2MANc?=
 =?us-ascii?Q?aWhuNqz7T5ZDw3JCs28oYJtdFYj7OQQ4438jW50VPt6Ge3qa5VxFvPpZLnhq?=
 =?us-ascii?Q?/T5hNhGg+Wh6S4vAwR3gGv8B2leJX2LsVshLhIl3MAwIr6qR2PFHQ21gLh8n?=
 =?us-ascii?Q?Iet0OLEIzz/VbT3tYpEprlAdigbiAvqt0lg5AzPec1o7B/RZ0crnmGyAso6M?=
 =?us-ascii?Q?FFq6My5Y/jd/PqYCtDPBs8OaWhxM55YnTMHlRKPRzPIePZonf3HfEij45fBi?=
 =?us-ascii?Q?p49q8N3NU/6SaHC5x7BFAIemcDvSILB08dEcnMK5zVkjMZg9W1+Z7kBvce1s?=
 =?us-ascii?Q?sD7VuIpwQSl8fzEGLzGokfGO8icUq0WOUIwbLbK7+xadS3uir2gqXv/GOfsN?=
 =?us-ascii?Q?8O7+Fe8KXseWs3UC5XMXOZkxQaB6VOa88i2DkM8l5KGPh6ZhXx8+pC05B9FE?=
 =?us-ascii?Q?vUrmVOWw/lexa6Oqlf3V7txfHd5Q4kD0GXat3Xx+y7x2K6X811zl70Ao++FB?=
 =?us-ascii?Q?znfwdgWntjYGd5VeBPm2rBjM0dQ38GUJ74HhVNrroVTpv+38pX8PzQVt6kzo?=
 =?us-ascii?Q?6T+HUrXJGb4TRvIvqOYLi2eBLXtR5rXjw4+95Hf4CW9DU4T/AqdeVwKo2VeT?=
 =?us-ascii?Q?6O6kN1BTcXb4GvdiP6bYNhPkdJtzi6EnrliOCPTPBQmje87OmNiUL5LtmKTq?=
 =?us-ascii?Q?XpvkXvWE/3927yOV/M6RIcfFQYSrkPXM/rb5ucJg7zt6qkUjpV3i5UuVEFNG?=
 =?us-ascii?Q?dv7luCrF+9W2HBcKdv0I/whTlCg+a/cAXOzmvr0Y3auDeo9vnwRy9cKH37sP?=
 =?us-ascii?Q?FEqfcFVQv1JpCxw68/MnswOQ3ziJZDhqO5WKUiMzN4hb7iExgoeKHV/IXJe5?=
 =?us-ascii?Q?0DGkrtO6gyAMKfvScY+cfTE9k2SDrm5VJR2MZYSzZmbFMqGUuYoMnGkR5HxP?=
 =?us-ascii?Q?Vpfix3zraAcjV5lK+QMpz6X6gubTHrZghUxd3AH/slXlxhY36vy/kLtEGgYs?=
 =?us-ascii?Q?yAtya1pf/0dM82rpFv8BHEifjriTbGOSQg/dpCtDehTlcaBW9YBgNpXvUxWy?=
 =?us-ascii?Q?2UpU/fU5XfHWsgMtbq0bkiYh+74aENfhY/d9+XZORpnZOXAp2eSW2SNo3HmA?=
 =?us-ascii?Q?gtLlHYXo4kz2h6aTEzslwmUlL4dgLTk8gdRwawy8BROYRgtZSENiJXyg/z7k?=
 =?us-ascii?Q?ifA9bR4pFOlaE6fMftK5MrVw6Dn5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 04:46:47.5007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f9ba2b-8937-43fb-e862-08dce68b0d2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6893
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
index c395ac4912..bb4402455c 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -96,10 +96,21 @@ static int usb_onboard_hub_remove(struct udevice *dev)
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

