Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA062E6C5FB
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 04:51:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3D7F895CF;
	Tue,  3 Dec 2024 05:51:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4iscgu2V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22086895D2; Tue,  3 Dec 2024 05:51:23 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::602])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E54F8950E
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 05:51:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFoGNMjVnESrkMnVRLMnTHVSvSlKgkkZN2AcuJXU93Ku0dZra9hfSomWZjyXVZGskbonfY3w3PmKQynVr2sivfCvYxhPNtJVH6mbkpu8s4iEoc5xj7o7jwwZ7IXdMqSKYTlK4gDLXTrpNytUs9Zl0jh6IMYFmC8xqeVTO+QbydpQc5xp8FVs/o+zRki+Z+P9vrz1tdaEjIzFIgKHEzEgZ8H7jWlr7DbEFm2qJYbAo5xUfagSIlkDo1Nkaerolp15g39BrbEO3ZALByZdGOhBqjxZ8tNskcLru5NrKmZtBNaERE0dSLb60OJOBD/b1qPfjlSEoSz7zPFU7K+iD8k1vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDk3GHVmBr6CaeEF1bv2hy+DAghxkwMLjiZ2tj/ZgMc=;
 b=gqmAg3+35vzBnDCRr9u4qLdOfXh8FWtC3GSFt/B8h5hunx7EukxPFl37GD0Vmg9sRtgwUnW0ZkSJ5XKJazaBrAquvJenWx3jsMbS7ZDW2ZbeLqlHqGuXSDCXjXfII5JR0V0NGBuSzRnYCxArgfmObIT90jXWj0kvhESaQgUfpzKdvBgQ1MaY4BnU2H4iNPwrGyBniQ2PfncSJQ8E6Jyp6YSngrM3o7xJKgxvJnOBgwRis4roBRlez7YISzub08IHNQqDyxuYheeS6uL5KwSm0Ila11ZtiYs4JyBKlWkCNHtKpiTzvBf0sO2ITusm+i7Jn8PujMIV0Fu1fOMK9EY46Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDk3GHVmBr6CaeEF1bv2hy+DAghxkwMLjiZ2tj/ZgMc=;
 b=4iscgu2Vy162IRFqQhY2P45fh2biuoF4D3OddzSZ45b2A9ixh3g3pYKcdRL+hrdLLUcOVaOzgtvFnE6U3LuP/ZcEbFrH35x74hfe5lTU9sdsucNrETzjP0IxOwpckW3wQQt+Seqdr82j6I4z3ZDRZl4izmKMHnN3nIlsfODj760=
Received: from BN9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::7)
 by DS0PR12MB7653.namprd12.prod.outlook.com (2603:10b6:8:13e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 04:51:15 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:408:10b:cafe::75) by BN9P223CA0002.outlook.office365.com
 (2603:10b6:408:10b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 04:51:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 04:51:15 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 22:51:13 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 22:49:58 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 2 Dec 2024 22:49:57 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH] usb: onboard-hub: Update the bind function based on
 "peer_hub" property
Date: Tue, 3 Dec 2024 10:19:50 +0530
Message-ID: <20241203044950.119197-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|DS0PR12MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b8025a4-1e62-40e0-73d4-08dd13561e75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HM54tty5I2geaM7qH1nORm/pes//554m2/ZJZPD7LjDnUisA9O6O1URQb4ny?=
 =?us-ascii?Q?sispcmpDk3o1p5EMWxKE7WGZtsKZbe+//dmQ/UFTFd7WOiMyRZYdEByJJ76E?=
 =?us-ascii?Q?+9zURZiTXaqvXmpLPM7Mn6jNK+M3lZgjYYy33S5Wu/umrOsfmdXJN6TxUh7a?=
 =?us-ascii?Q?75/6kPvKMe9+dJguxRxar334eS6qLNRlQlUmKDdMc0CXVxDQRC8y8fv8WiOQ?=
 =?us-ascii?Q?Bof4XiRmCwV7uRGcN/yIFFTMIOm+0xLcJd5pniAiQBAQdfDDfcC7uod0vV/Y?=
 =?us-ascii?Q?mnlh9FxYdE/OSi+j/W0k/NnSqDI4IQXoI06xBltVxkhpyMpUfZO0Em73stoY?=
 =?us-ascii?Q?y/CMB3be50q2XsDBl+0AW8Klgv8mwbdBDEzas8FchMV1hMDYx4wQzxNTO7n9?=
 =?us-ascii?Q?PqPLXVznSbjvwGqIGIwWDXrjJ0NJWu/jicngqOM47ZX3jKI2nOK/V3G4Epo4?=
 =?us-ascii?Q?xvWeLV+63yNzJ9Sg700ixD+peLra7PjTSdlYIlItDQ02fqMmdA/Sm+LlW8Jm?=
 =?us-ascii?Q?cpdybefl2sADn9kNbBHuCLBdraC2nujWeGHOjor8VzgbALb8KtZJDm9cILlU?=
 =?us-ascii?Q?oLkn8+mYuoPo2uOaQJEuv5G5PVRI2/xHPwvrkIMsALcM7bjv1b6IMf/QpquN?=
 =?us-ascii?Q?Up7UPAaBAuiqQbK7oBy3/cEzLP2hcV6awWc5QkwqykG9I9AV7yB01ZYc6jeX?=
 =?us-ascii?Q?yipAIwYgaJ0hN5t9wCnOS9GzEz5KkWfzYUac06zUrSngB4Fh84lLB4dMwlHv?=
 =?us-ascii?Q?0EcqFlppfhEs4QoCnl3uqzzb4R3wTK7MARWy7Tzd9FYltrlYa4ZsQeG+NOGa?=
 =?us-ascii?Q?7qdygcP5Rnq7N0ZJ0heqf8iAk9HmV67eFxJIsFAUsMcCEDZi8y0TR5aZvA5K?=
 =?us-ascii?Q?f0Wj/LTTIIKhG/UA0Q69Sb6PaGxzjcQMey/t89hvXcuknjtQf/L2K3+qIhh7?=
 =?us-ascii?Q?jPAVhXtvTIRpYmLDHaI1EOBidndIl2GrwZpo2LTZVR+vmKhyOCo+xAh2qBqv?=
 =?us-ascii?Q?RCudldK3byPheZ/L6wF+tTVrlPQh0iSuFjP0ZFapwXTnaiBvSr9R/Oikr/8a?=
 =?us-ascii?Q?1V2EQH4tDkh3wpclHnBr42NEdaknC5Osw4EqA6ikza+Fiqdngh83Y8HsfcY1?=
 =?us-ascii?Q?uUGkdSDWE6bBCac+s/LxL5aP8HsnenlA70Y2zyGYDfVwZE+gx0mWkMLAphQ2?=
 =?us-ascii?Q?VlP3RIptN1vl/pBgIxXoTLMY0yyf/enolphtL/BETe7O25VVlP29V6b8ds/F?=
 =?us-ascii?Q?7o2WCZIuqOiQENFGLBM2TvcL8JHPQbCK1784124VrdSVPt73rOUcwDrJrVaI?=
 =?us-ascii?Q?l2IagbSpqD1WHE8IaOv2ju0xrE6MaiGA4HvDKvddS5vyJjexxW2tbJzdKH/p?=
 =?us-ascii?Q?dtgqtqxaVKwbWILfB1W0dscM7VeFO9vXLNkF409ElMPeKAEpkFJ3KEfDI5wo?=
 =?us-ascii?Q?xXwq69LftvkXwEYnILQc+1v6LwaDewaZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 04:51:15.4982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b8025a4-1e62-40e0-73d4-08dd13561e75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7653
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

Add the bool variable "peer_hub" and set this only for the
hubs which have the "peer-hub" property in their DT nodes.
Skip the bind function for usb hubs which don't have "peer-hub"
property.

Fixes: 57e30b09fc ("usb: onboard-hub: Bail out if peer hub is already probed")
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 common/usb_onboard_hub.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 6f28036e09..0a8fac38ee 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -26,6 +26,7 @@ struct onboard_hub {
 
 struct onboard_hub_data {
 	unsigned long reset_us;
+	bool peer_hub;
 	unsigned long power_on_delay_us;
 	int (*init)(struct udevice *dev);
 };
@@ -178,10 +179,15 @@ err:
 
 static int usb_onboard_hub_bind(struct udevice *dev)
 {
+	struct onboard_hub_data *data =
+		(struct onboard_hub_data *)dev_get_driver_data(dev);
 	struct ofnode_phandle_args phandle;
 	const void *fdt = gd->fdt_blob;
 	int ret, off;
 
+	if (!data->peer_hub)
+		return 0;
+
 	ret = dev_read_phandle_with_args(dev, "peer-hub", NULL, 0, 0, &phandle);
 	if (ret)  {
 		dev_err(dev, "peer-hub not specified\n");
@@ -212,12 +218,14 @@ static int usb_onboard_hub_remove(struct udevice *dev)
 }
 
 static const struct onboard_hub_data usb2514_data = {
+	.peer_hub = false,
 	.power_on_delay_us = 500,
 	.reset_us = 1,
 };
 
 static const struct onboard_hub_data usb5744_data = {
 	.init = usb5744_i2c_init,
+	.peer_hub = true,
 	.power_on_delay_us = 1000,
 	.reset_us = 5,
 };
-- 
2.34.1

