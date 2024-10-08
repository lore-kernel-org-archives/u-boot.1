Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E892CED267
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 04:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A68288DFF;
	Tue,  8 Oct 2024 06:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uNjPY3Tt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B19F88E02; Tue,  8 Oct 2024 06:58:46 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92CF888D82
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 06:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SttEE3YF6qIObnv6lgKcEqiGlMtrwJi8aznMJLGYSs3LbT2ovDa/89qQtd6N/6CXSld23WZ911+tDEUnnGFzAO9kv53WKgF92tQNgu6e8sifvBYtIVJsCDCTK/PLQnl0d/liASctJ1JnY4TOPOajotWzXAETn3SqcdmmJGCyvCqPe5i9P47PKSETVAqO6su2SBOWVu/5axQEQiGE0lkNBEOatLh+SnLBXBHsbDof8vtPK0vVUffZasrDwQgqlR4Uanmex3tpczsd7AQALy0DkiXw7ekAdms6c3VIN/kQS7yx1NqrvxaHuCoMiPPv0LJe4lT68S54zk8C5fjh056+nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5O4R4D+8rosHmJeuFFdnM4gOjWV90CsKm5ETfiBDfc=;
 b=dkk3rEYVmQe/918lc4H+sIoY/EJZ52ZRWtxUMgW/4YrDCCismvockoy6jCE0zHAYBE9oS0kdycrECLYFwvUkJ0NA3TcnjsiScHiCAiHf4hK6Fpbi0U/5X28+egqy87vF0w76v8SxBlvh4vWtlsrrFGcMIocQ5zO2FjDaoU5pCHDTiA5JDZYq8bdcaKFPnPXG3uA0B/TEU+G+BsfqLsaTL94+Mh/ZIxsdPAf0Dehw9eiwzMJ0hPMGiwPfiOOjnRHopXgefSteNkymIMX/6FATazHus7NOAbctVe5k8nx9dsORx7pE+oYDMlUi/ILzVMcqF7S7JemrfKmSznjaAaNq/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5O4R4D+8rosHmJeuFFdnM4gOjWV90CsKm5ETfiBDfc=;
 b=uNjPY3TtY//2bjbPW8gwlBQlMLTFNcXmaP19kEVAm3nZ03w0tr6XK2m7rCj+Ll0bPpeGzY797LdjA28ORJct5VHg/gcnyOwAgL9ncFDHsacq61NxVfQJMgZldHu3h3eeJ2dh1tqclG4oeu8EaCF0lF42bL1Eu8e3VV4i5gdniYo=
Received: from CH0PR03CA0273.namprd03.prod.outlook.com (2603:10b6:610:e6::8)
 by PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 04:58:35 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::b0) by CH0PR03CA0273.outlook.office365.com
 (2603:10b6:610:e6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Tue, 8 Oct 2024 04:58:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 04:58:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Oct
 2024 23:58:33 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 7 Oct 2024 23:58:31 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v6 3/7] usb: onboard-hub: add support for Microchip USB5744
Date: Tue, 8 Oct 2024 10:28:04 +0530
Message-ID: <20241008045808.28757-4-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241008045808.28757-1-venkatesh.abbarapu@amd.com>
References: <20241008045808.28757-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|PH8PR12MB6939:EE_
X-MS-Office365-Filtering-Correlation-Id: d44cc924-9cc5-4448-6dc1-08dce755dd28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LHqE6aD8bdbFKOSE2LXDxTd8OOOl8UEP7fcY9ketgrvwYBBxkG16uBlL77sl?=
 =?us-ascii?Q?e6DTxmYBcPotxG2DiNsY9Fomi9GNGCkSRfNaUqu/bKEveBNT+JGgJTlW2EVl?=
 =?us-ascii?Q?jp8ZBVGIpHLU0xV82sF2pKvul+k8JQ3lZGswaYCRsl99d6wpDiqc5TbS5XDb?=
 =?us-ascii?Q?XQFacoTwLevrNqFnCGGkQa4B2YQbOqbxhJxPnqvqUpXC1ulRjztpGMYH249U?=
 =?us-ascii?Q?pOEB3MhoojDKQP3Vit2MENqyA6cxGIBkTs1qsjryvtxJX3qTA6YLn4wFGMR3?=
 =?us-ascii?Q?RdQPC/QAFsuyv7IlSnkk7wm3LRHmj/DkwD+Y37AepyfDF0tMFno3As/qe1OS?=
 =?us-ascii?Q?HfLOTjbJtHLQupkPxFtJbs0H2lwtB3kxb45ptjHlI5kXXO0YocwOVOoCJTTh?=
 =?us-ascii?Q?vxQHJNLs07nVgH4bZRyty0p5/0+h16J4bhkVXb4SdlA8v49b/l8XbAghVCW2?=
 =?us-ascii?Q?akj9CRd25tXY7PeOtJrHpLmJlYYxoN+UBLCplkZNZRyH1XpqjyhGEeWB0dtA?=
 =?us-ascii?Q?Xsjdo8Q2ubxy1T1FEtkGRdf2UMrx8WaANigwoXKb39b2wYRfzvvOiGKjDF2J?=
 =?us-ascii?Q?WxZmoPFZa+anpXB/6/KfWi09UT5JjJ2c4IgK9ubVicq7PwbbuAoCMKoWUIcG?=
 =?us-ascii?Q?6HdsQvssOuhkiniuhMjRtw4Qqm4xdiZ6wDjp/22LKRCnQfGOtP7xOv+o684C?=
 =?us-ascii?Q?O9JILXHLyDYRxKcKfF4aFpqGqWm3rX45UQNglXLIvbalJzL6nQbLs+KNbh6N?=
 =?us-ascii?Q?QCm0bAmMe68Oat2KsakpDyFV1aLyVeNPQodFVA0HNQ3l8n6L8w0JASozxOew?=
 =?us-ascii?Q?J2+zwCrOsoZ1rKIvU0LpiAoBrJsg2RmjbQjCaT+aMa24I3DShJ+aTjkCXlam?=
 =?us-ascii?Q?73pJLcYx75Ae9fv0VHBYy9jbB+X+a+FURF7tvvQi9E0sck7BWMkwIi2qhjlU?=
 =?us-ascii?Q?c4NRjuoDzF8RVlRiAxQyopfvkdGyMy3sEUv/dVHdyfD6PDqsKiydbyrGTol9?=
 =?us-ascii?Q?lrNaSHcAJQwHEesDBEFYxkgsO7/RXnZZqyXzb79PfDsGAvrxo9zzV3UbkVmF?=
 =?us-ascii?Q?QKWxwYjElP4EZgfi35Ux+bVC6LNmJLIT4IYXfoh4cneYunB1G655kv+5irmF?=
 =?us-ascii?Q?aq9WIwaJvA1keX7fajVQqvXMqURBPg+xWaVzTczFb4sw6A9ndJnFUy5lSc5t?=
 =?us-ascii?Q?9Sft6JJW4k8FbEMY/lt+dztEdOpMOfqpdBN1fLInARqvyULFSjADRpE8JxLp?=
 =?us-ascii?Q?wDEnChXU+Hiu5hvH2FSMQkRUyEhfvTB/uBhlzCVvKZf0QHU3uWrW+BsmWZTv?=
 =?us-ascii?Q?mrVN+yMIFybYKETMyP/fWJaDKK7GQ2hN1PfRDkrWwr1CfeQSLTZUjkdr1+xh?=
 =?us-ascii?Q?W76AWkJTFDPD3TmWtf5oupQl/wPA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 04:58:34.7637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d44cc924-9cc5-4448-6dc1-08dce755dd28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6939
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
index 4b6e88208d..6eef93171d 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -92,10 +92,21 @@ static int usb_onboard_hub_remove(struct udevice *dev)
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

