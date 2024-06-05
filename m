Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EB9C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 10:03:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FD9A883DB;
	Wed,  5 Jun 2024 12:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="woYxPV60";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBA4D883A6; Wed,  5 Jun 2024 12:02:41 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8A0C88252
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 12:02:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fefCz6R8dHY9PBAmQIm58v0ZJU+oHT8RjTsHZF2v9GGDhp3fFB0DYgp+m7w+6/T3my534+e4k3aYAGb20/iVu6E/o3lWwlDO7YNiyqEjmIhvXopu9N51x4ZfALErHFjGK6QdwwIpjBxB4/jGjLPq7zCKIrUHd96BaMyvQ9AhpfL9+qdwlOJFBiM3sq/P1JEVsO6VBoq/MHdad9+hhp1T5VBdf4weoDy7FgDcjX2CApH8K+Gt/g/SnXW4vJU+iapM96qc1XSlyx172gWBhLRkkzGVS5vx/iZIJCi3tyHjeCpzifEfgqmzGh7HNJmpYXogOjLxfnWLaZiONMXmENcEBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0GbDvLhZ7n3fCsgXziV86gQ+1hRitfH4PlDMehtsPw=;
 b=ZCfQpMbufDL9LAAt/gmBq2cxaPlWRySruTgJqfpa8qQtH3DkmdBvkACfOQljLqyKxVBwWcO8/cniq0yBvVbLOrv9K9FEyNx7/ZMb7t429RsvlBEUUZk87VdQgzP93hnZWA1MmbvbNuz6pPId/C8NqJIbT1+nINRzv+noyIA1ltuKdYLtdo6Hl5hXP6N/OC9uLdCth9xPbVRDW2zVs7h3v75hhH5Nlh2S55+i2genvoumQrDZzdswfBbKBPcY5ogBIraYW0m6/9+HuQrrGIPW/uM/lqBi2EbEVMtg8WvmNZpwbr1o0vHHCjxmKDAMF194XLXZR75NPWHN/SpaoLSSRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0GbDvLhZ7n3fCsgXziV86gQ+1hRitfH4PlDMehtsPw=;
 b=woYxPV60n0nOO3bIHXljIsXqZ9fA2CyH3ED4PykrMSIWHyS1INyU0Z77ngg6Noe8NBCl+gfweUix5A4z+GuzmCFcjUWFBDQ3lZ6ic3If6+uBjv3DcjVyB+tELghqVFHCig88xzyY/CprAUgIDnD9VhCVcchiV13kLoalAZqCMF4=
Received: from DS7PR03CA0205.namprd03.prod.outlook.com (2603:10b6:5:3b6::30)
 by BL1PR12MB5873.namprd12.prod.outlook.com (2603:10b6:208:395::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Wed, 5 Jun
 2024 10:02:35 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:5:3b6:cafe::d7) by DS7PR03CA0205.outlook.office365.com
 (2603:10b6:5:3b6::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Wed, 5 Jun 2024 10:02:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 10:02:35 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 05:02:34 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 05:02:34 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 5 Jun 2024 05:02:32 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH 2/7] usb: onboard-hub: Fix the return values of regulator APIs
Date: Wed, 5 Jun 2024 15:32:16 +0530
Message-ID: <20240605100221.3571-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240605100221.3571-1-venkatesh.abbarapu@amd.com>
References: <20240605100221.3571-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|BL1PR12MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f0a5a3-c247-471b-30ef-08dc85469fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U2xIzdWpewj+6IHvmhEAqmoHkYzrEY+ARbe1W9L0JbjtpFfr6JA0ocwXH+TR?=
 =?us-ascii?Q?QCFzcJZv21ksmUy672TAbRn06SWFijoxnTHQ0k05czwPyUu0Ms9BfOOxD19D?=
 =?us-ascii?Q?cmabVgQtoaWw6sFjKSXTgFRPjJ7UB/GP6DJXtxW0HySZ+XGVfDXM6vVMvPxy?=
 =?us-ascii?Q?sK5G4dEil59h0FFodSxqy15avB3vpeavMxYuvMFsRmId6Fcqd0rG6SeexD7N?=
 =?us-ascii?Q?pwc5nNoupoalSiULaZM9iPofV/4PCb0FuqmDeuPmGoDBmOLMNPwAW8YJfIs2?=
 =?us-ascii?Q?THirF+IvOMsLZb/zxpBRm5hZ0iRDhEbuhGFGNBbR4awVRk8XVaC+GdBs6A26?=
 =?us-ascii?Q?YX8qUPLbcJnlJWytFfCw1hE4Plw9vI4BV0duGxdC3au+XAn/h7SAF9D1eZqD?=
 =?us-ascii?Q?HDbxzyN1aeNkFE261Xu1G2wg2DApcJsOVNFkC5HupSbskIIiB/W5ZDxfTXgX?=
 =?us-ascii?Q?LauxjHe1eBtUbHA7mLTGpLZ6CPKXk3YqPSgR9Y+UMM35p8dSsC2dOcXJmCIa?=
 =?us-ascii?Q?oxykjHjPDBysTmSXEuflI7bj5+KmZswoa7Hb3HWsqDUu/pEDc/CXQxSJkUwU?=
 =?us-ascii?Q?zHRTMJmLnM6Wwh+/k78Q1+EQYUaTVXYuSEBcY3SSBH3fElcrwrPVMvWptqc5?=
 =?us-ascii?Q?bIiayPSG2HNrCH5KuhPRNlo4bXrChmNbzXyp2yC2NUj8H/hOnnYu04T5jcfa?=
 =?us-ascii?Q?XjDxWSyQQlJdelNNnJJF9PMPC0ubbwkWKj7LidlFAWnXvPTYg8Mr5Uf/uNFN?=
 =?us-ascii?Q?g109p26KBHueiYR9scu+4JqRb3ea8dU14/6q+09qJSMrECi/4NbqlZBqJlqh?=
 =?us-ascii?Q?rBduBiUa9JHx2VPc6Gp6KpPu8ymczanmeqT1u7CIVrqC+ktRyVnk+gSNM+7m?=
 =?us-ascii?Q?BDIZSkm8W0Pm81AjX0vdHw1LMykGxdZ9S+hSp7iwRQgkhroU3yVoKZUECB+6?=
 =?us-ascii?Q?gFoSO59JS5ZwoIvAJod/Z82swQdrLCAkQrtL5o2QGwts/bWgta6RMhttXQ95?=
 =?us-ascii?Q?8Z9cT2r1VzNkJYZVhtc4DKgo8yWOAAiYcQf1aFzEdaEIcDwsiJeHFv7V5wyK?=
 =?us-ascii?Q?iP3rpW8MS24xIceDfOOihkrzH90Gtw27SKSEk1Tb/act7DU3W6K60UWdmY1H?=
 =?us-ascii?Q?5ybss+/OG7UCPBsN3W4najOfH+bI7LsVIZBPbf5jjN0Qx1ZxmdD+zbVqSWWH?=
 =?us-ascii?Q?qhk8Q2pN/QuErhDTYl9sUJz5VGa0O8Zz6G6tQspsxq97PbeUfW81sLX5FK4G?=
 =?us-ascii?Q?PyD7KCcVFoOsUH1NH+khEIptnKywWDJP+q6suoHwwrpPEPr8pksatJd0JiBJ?=
 =?us-ascii?Q?EGmBfIKtRsgrGvIe9lJG9Jip9rcJO+YgatmPwy9i01VAyvmyEF0aqIOrjAAF?=
 =?us-ascii?Q?wyWh2GgC4KkF/Hsy78MF5WEmzJiQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 10:02:35.3379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f0a5a3-c247-471b-30ef-08dc85469fc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5873
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

Use the regulator API's only if the config DM_REGULATOR is enabled.
Don't error out if there is no vdd regulator supply, as these are
optional properties.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 common/usb_onboard_hub.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 2f6fb71935d..0cfaa90fce3 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -30,16 +30,22 @@ static int usb_onboard_hub_probe(struct udevice *dev)
 	struct onboard_hub *hub = dev_get_priv(dev);
 	int ret;
 
-	ret = device_get_supply_regulator(dev, "vdd-supply", &hub->vdd);
-	if (ret) {
-		dev_err(dev, "can't get vdd-supply: %d\n", ret);
-		return ret;
+	if (CONFIG_IS_ENABLED(DM_REGULATOR)) {
+		ret = device_get_supply_regulator(dev, "vdd-supply",
+						  &hub->vdd);
+		if (ret && ret != -ENOENT) {
+			dev_err(dev, "Failed to get VDD regulator: %d\n", ret);
+			return ret;
+		}
+		if (hub->vdd) {
+			ret = regulator_set_enable_if_allowed(hub->vdd, true);
+			if (ret && ret != -ENOSYS) {
+				dev_err(dev, "Failed to enable VDD regulator: %d\n", ret);
+				return ret;
+			}
+		}
 	}
 
-	ret = regulator_set_enable_if_allowed(hub->vdd, true);
-	if (ret)
-		dev_err(dev, "can't enable vdd-supply: %d\n", ret);
-
 	hub->reset_gpio = devm_gpiod_get_optional(dev, "reset",
 						  GPIOD_IS_OUT | GPIOD_ACTIVE_LOW);
 	/* property is optional, don't return error! */
-- 
2.17.1

