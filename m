Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60456D74978
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 06:45:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19F2889214;
	Wed, 30 Oct 2024 07:44:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="40H5qn5F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4B4A891FC; Wed, 30 Oct 2024 07:44:53 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::605])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DC908920A
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 07:44:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUPHOFHgujiWii/PypKQHkFnMuGaNB+FkfpGQh+A+kaxSW9SmtZaI5WUR73axBN529nuPuWAqDHsZM85TmXYDD9UJpCV8UEzZ3KYxK09UkMxYhWaldO6lhJCo12Dbv8KYwJX9yjsQ3/JwviJcfpSLiUW35TxgIunKgTQx+KxdaKXFsjUDqiEeE68txva2koySdUJHsD42muYVUP5OiLarBZEV8MWvGc1zQlceD/60bg76vICpxqrrkFxaXkbqinuv0KTQ7W686cqCMaIaHKsb9iYCyY7KE84i6MYqszd4TkjbqrcvSKsClStVKdyHWzVOdew8xwOR+VhnrjxOqSw8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaSHtmp0jl+jly+Qik4ijvNonz6sxo7mkMJPVgIDT+E=;
 b=LYj4Jsy2Ddbs70F7tYeehvRj/nLWJh0cfvfd5t2KhuKgIrwRC6gcAJKRObwKT1pf9d/Couph6qWCqDg6rgb5j4tpSHrL92hTAthUu3fXxrKicFKGjM06tdQ3SqNXM9Jtg3yTUdB6pSV0fjGOQT2DSThwj9x7/6mSib6HPCyHPQxElUW0qVv+kbxPmrC3PvGKQgLNj1sveiwOVT3ZFJtAr9Q488wapXi3Zsm3NXA+JCLbrtqwVyEyTJdKE5IXSTyIFWR2W+iTNQWOMlSvp4ZAicEeOzpuv4TkATd0YE0QfhYwuGhkzUnIP9YD4JgmP2GKPEfjF/5ZMWnmSmEbUK2A9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaSHtmp0jl+jly+Qik4ijvNonz6sxo7mkMJPVgIDT+E=;
 b=40H5qn5FLQtZaHtcNpAOfAfhpAhnfxd+60qdpaCt2wqY0IKXAfmE3GzNbgbofpEXStHJMlNiq0esGIWbR+sqiQ8yALFgw7ubjjC4JEObJQ+CLsEZYzhcWNTiLlfanz82Ysfa9+H98GhfQYjxvNSavDWESop0ZyoyJrS7wrKkx/0=
Received: from SA0PR11CA0206.namprd11.prod.outlook.com (2603:10b6:806:1bc::31)
 by DS0PR12MB8248.namprd12.prod.outlook.com (2603:10b6:8:f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 06:44:43 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:1bc:cafe::5f) by SA0PR11CA0206.outlook.office365.com
 (2603:10b6:806:1bc::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Wed, 30 Oct 2024 06:44:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 06:44:42 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 01:43:59 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 01:43:28 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Oct 2024 01:43:26 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v9 3/7] usb: onboard-hub: add support for Microchip USB5744
Date: Wed, 30 Oct 2024 12:13:10 +0530
Message-ID: <20241030064314.28604-4-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241030064314.28604-1-venkatesh.abbarapu@amd.com>
References: <20241030064314.28604-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|DS0PR12MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a67928-ffd9-40c2-7410-08dcf8ae55f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zlxeebmxC0HVcdOZY2T+f8lUAye7BRz1Rxfejl0ykO6PFPBPOIgtIUHLyskJ?=
 =?us-ascii?Q?xLV1TKwZ3GFzbFoYEcxZzffoY8w0yBouk+EZKrIDeEoXO3R6T79O62AAKFJn?=
 =?us-ascii?Q?9GfeL9Rh7RfJ0B/aDVAH+KH34vKk9XHQi63qubzPXNQpbDz9Se3VKVbfgDGN?=
 =?us-ascii?Q?j3l7SeDu62EYZIGQCHE98FPkJc9hyiuoOcVEF9/c90nnnr1TyRClvqT3ZgyB?=
 =?us-ascii?Q?08a9HORkjXyJ68mCXQF+u1DjYX0VlKTJhUyCAiDI+24CrrS6cylsq7fph9Mz?=
 =?us-ascii?Q?KgVptXpiX5XwC/EDrDIfiOeLTpzfN+P7GzWqJcmTB/cVv4Iu8rcn9LR42LWm?=
 =?us-ascii?Q?/uj8yxObgfI6HiXvxkJuqs3BQGUd0o5NX1mV6oCAKs0kaodjD+goIbmKfLAe?=
 =?us-ascii?Q?qRNdQfAHiPJmilri8iOsmRT6uXkerkRy8/r4y92/fKXVO/bkFU8VYgpVKKec?=
 =?us-ascii?Q?kGzBes5eKhRqg+BVMguUxJu4fNVUChN1TtMew59PtizluHjYZhlxwPbkna+u?=
 =?us-ascii?Q?+5R/uNbX9DUJoczLuNcfg5GkowHuBUdGKOqcP1V2XorZNrInipcZdAbYtUQO?=
 =?us-ascii?Q?ZId+NK0bt68wmHEVTEGECSMG5GFt44mgaWSRyCmiLq/Q6OSs1tdMUXTlygPi?=
 =?us-ascii?Q?dJzy0D8fw90C5PNmfZdA17OjQFfAVNLZQI9SKOLMuh6T3la+gMvYLHpH345k?=
 =?us-ascii?Q?obm9lCUHjfLOGmBsqmG5H357MVqCvfjilPZ6uZ8m0zHJGChJOTIJlT71iBR2?=
 =?us-ascii?Q?/gSPsNowlvam3w3KPpArnJTzb/mflKG9n5n2y524uQ6ItfLt3P029LcVJykx?=
 =?us-ascii?Q?rL0Grl6q91/qrQlaljJGn2j7eX+Z1+UQZM0vPSurYmzDFyN24xpDos7thyAz?=
 =?us-ascii?Q?2wBGKscq7I0gYKi6ogjIXf9LfamBLP5gx7K5sWYL0fcroBifL4z1mewqrxq5?=
 =?us-ascii?Q?31Tmrb/UxrZgbSBPMZnMMFjHTEFPpunExRDShospKerWdMqCs5uEnEcbbIzd?=
 =?us-ascii?Q?QBnAfZSQAgMSd/7H0mkFq2vem3eKiAF5/B8kga33qkAubYlG7wJ0vcLT8mgh?=
 =?us-ascii?Q?dCIgRpmE3iaYKP8VRl0LPg6m6nKVqQidm9UM+M538D82jnZByOcSNqs5Rw3z?=
 =?us-ascii?Q?ExCLejN6H8c8D9PON8uARj6wdJsHZ/TOsDRXKjTEFJ7xtlms++PlLbpwujjj?=
 =?us-ascii?Q?q4SCCAJk03qxA+yYWgUjEoXaZvfr+qq+YXTuUj7iPbJOv3TsRWUXtpuh+5Rp?=
 =?us-ascii?Q?9DcknmEt1Whhse5t61XhhpScf2OhWA1yfr5m2/k1kPvgXdgYnpboGqLXFf+Z?=
 =?us-ascii?Q?a+Vn+xqIXl48gRxuil/6KTYKtwSy3Bpcj6hpU0zGUOYCbuLyMT7kb7nQeaGD?=
 =?us-ascii?Q?Aapcpeju7l/5N8c94Wd64coSIho17uu541im8tH/ERUibmnJPg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 06:44:42.8806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a67928-ffd9-40c2-7410-08dcf8ae55f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8248
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
index 6ef9c87fc9..fc7953e8bd 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -89,10 +89,21 @@ static int usb_onboard_hub_remove(struct udevice *dev)
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

