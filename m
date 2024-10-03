Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81494CF855A
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 06:29:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9B6F891B1;
	Thu,  3 Oct 2024 08:29:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xCs3Se8J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C7BF8919D; Thu,  3 Oct 2024 08:29:09 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B37D6891BF
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 08:29:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAJHZ4gLOyIt00OySj1Jinc8s198fntUjfsxdJiH5EwUkVPdr5bT+Wl/4/15JU8qot8kuBbO2a94Riz/eSoQ48K+/geouPWwniK0h7uBqM1zM0awx2MUWPZJOI/5XQT456DNJALB9mIjW8iHHNGUR5/5Pt6ORAjZ0a6I3WUAjpbivvNWuvfNxDU7XoqP+MeGl8T+gPFO3Vu2NXX4Zoe3eTN8aclvQDXpaqXxnA5GKTNL9qvGKLf4tQ6texOF3w36f3rfteziWgSTBOpt98goLr34r4fXZpWVImOVSsPa7AfdRvz+JoV4THoe3jCKLKC1rOZkoH0skSmKSFT7iIJ9Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8iKTTNGnjnIekvttA7BWSPdTAYnfX/npeQnM4e1z+T8=;
 b=BhOW2DNXQY2yhftLARjVcKdc6gIsqjIedPaGGBAw2Scaa3r5b/T6YIkpHs0MyZ2eXee2E1oPUCrOYI4Touno6aacOh39Hm5F2p5sA9/ywjliBrSg/OwEr3ZxIAb+NnHu2igq64Le+ykz2xuN8B6HFgD23M+tcBAMQzRw6q+WOLJ/sDQbX4IS8SOwt4yC5dZOZ7AjQCHGIatpkA2+Xkp6hCY2RyxLk+eZ/9JyHmkREs4HP/W9OcpLra49CEHECxiq+0+7HW8fGvAccULsG5e8IkmyJTtDhFbvvwQQxMpd+KCGpMLqQMxcM0UUtMa8vicFQokGOpWw77ubnH0TZR/8pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8iKTTNGnjnIekvttA7BWSPdTAYnfX/npeQnM4e1z+T8=;
 b=xCs3Se8JblVq5Zp/+E9gY8Nhls0mSqZoXyjsAr/csj7vtWy7S9GII1uikKFVLvtNGqY/wqi2G7BEJGAeq6cy1EPg8jogiucKLgsU5zH8GqlAx2bGXwUUAR+E49mb9j9/5+4Nz2U/O9wHMdJf9GxWICkiy0Pv2pjnfT2bStrw/2U=
Received: from CYXPR02CA0025.namprd02.prod.outlook.com (2603:10b6:930:cc::23)
 by SJ2PR12MB8136.namprd12.prod.outlook.com (2603:10b6:a03:4f8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 06:28:59 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:cc:cafe::4d) by CYXPR02CA0025.outlook.office365.com
 (2603:10b6:930:cc::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Thu, 3 Oct 2024 06:28:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 06:28:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 01:28:58 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 01:28:56 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 3 Oct 2024 01:28:55 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v4 2/7] usb: onboard-hub: Fix the return values of regulator
 APIs
Date: Thu, 3 Oct 2024 11:58:39 +0530
Message-ID: <20241003062844.15338-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241003062844.15338-1-venkatesh.abbarapu@amd.com>
References: <20241003062844.15338-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|SJ2PR12MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c702c5-6cf6-4c1a-904f-08dce374aa61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9pj6TIMNtMCbYi9hwEVGHVs6TTqVWWP5W4nKwgsk2EJQJ5D4FeuZFkUHnMS3?=
 =?us-ascii?Q?ZKUkxbqf/6KTebKp/ekOnYvH4zSxBFYVGJXdgKU2tOn3jj2atep1rvAgpXo4?=
 =?us-ascii?Q?KxseEjWaJU4IKnNPAC0v0JvIKDDmE6DYTt9yry73yTXoDoVmagTUlZyACz+8?=
 =?us-ascii?Q?8cVJEsiPQ6hz2KiZ8VP+/2PyIgJD67wcCbxvXAVIu8dE+W9pFCO+H5u/2HPL?=
 =?us-ascii?Q?CxikNL18fiTuO9iB0CcQh2/G0uL0J+pyWhSq5Wis0sJIsbx+1xoh7ZVwY25X?=
 =?us-ascii?Q?RqoS4fW7RJW7OmoLO3T8kwtikv1z6X/cYj3j9A4e/n2m8e4j33IRwckCjlnA?=
 =?us-ascii?Q?E7kB4QuW1FQ/4SjF0y92CSh7KZdlwftjPieswlQ0/77loC2CryD4VjoigEJy?=
 =?us-ascii?Q?GEwCZlvQkIXiyMu7r5YppRDRE1CbFNKMWmvVOLyMtrvoz/k5CegVRaNcBEnd?=
 =?us-ascii?Q?lkVlM76eDhz6vomQinY1v7BahqH+5yI/S6GjGo6WGFdmeAniofqVjlQeuLHW?=
 =?us-ascii?Q?Tcl0u1S/6T2JlWlUMn8naHxql9loQ79Z+kqVWM4Ik+GiFPkbuCxyfmNpaiLN?=
 =?us-ascii?Q?lSawa27RML7nWjMft5yGHTLXDIGYH//4+biH1XZNzYoESzymcV9hVhuD0oeS?=
 =?us-ascii?Q?aABJl7ZK17soIRCCIg7UZCmeSJ+rryOBDk4g4xRm/KQOcIdD8Vco7OZYMAG5?=
 =?us-ascii?Q?CfcDmEyGKNPvtjhGZ4HQTAygYuaFkxehGopRjgSc01sYEb7r0WukW3ssECQW?=
 =?us-ascii?Q?+d8Udl4vLXVH7RfD5Wu7Y5e3PdjkT7sGqH/fiPjm1N3//V7EZslXqhf/MnZD?=
 =?us-ascii?Q?oOk6JzKxrNFbMFr7jsVnjqm5iOcdzb928Pi5mxUsZdGqsisDOTqfhoB+Tr4h?=
 =?us-ascii?Q?mTj0ZypRbwYhWCcUqnttEzoFYYfak6shxIbMRft5knG7N8USBbzI0tKnzAAb?=
 =?us-ascii?Q?gGRMN7nsGVAtIgVL2aaR0uru9Z3qht6mD6+R3Llt8N39t/tDvZoZB97qJWvp?=
 =?us-ascii?Q?QaL8I6Ulw2ejKcwb1OLK+kUCYggClVtpNgx/msFfeJ/OYEUXJk+9YIIKsJhX?=
 =?us-ascii?Q?RgeFV9f9WPCnSFeM4+9aTLWZf2C9Zh7UJuHt7FjRA8Ey0YET1WHdnv9QIdQ4?=
 =?us-ascii?Q?vMhlhGTBAfJXsW5CBRo5ANI0ShErYn2gi8lWiF1w5fRVbngBBYPSp8ob4FJS?=
 =?us-ascii?Q?sPzG4/MKg5TrY4ERih5wJV9kbopW4vn7vuK638dleuERTe3ZT4FiOMzt7Pgf?=
 =?us-ascii?Q?JzH0fUKHlgsv3faIjtjDTa9L/Z9isvbRv0BzvYKcMS9RYoE8cDtiFQOr2xtU?=
 =?us-ascii?Q?h6Ohd4ZJhv1gHHOShhr73oLbfrNsJP435q/RtiVez8p93wtUOCH5miNZ2Wpc?=
 =?us-ascii?Q?19P4HPiWGFGb2ruMyhMtZPTGR22u?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 06:28:59.2124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c702c5-6cf6-4c1a-904f-08dce374aa61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8136
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

Don't error out if there is no vdd regulator supply, as these are
optional properties.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 common/usb_onboard_hub.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 9ecc638c7a..a9fc9bba87 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -31,14 +31,18 @@ static int usb_onboard_hub_probe(struct udevice *dev)
 	int ret;
 
 	ret = device_get_supply_regulator(dev, "vdd-supply", &hub->vdd);
-	if (ret) {
+	if (ret && ret != -ENOENT) {
 		dev_err(dev, "can't get vdd-supply: %d\n", ret);
 		return ret;
 	}
 
-	ret = regulator_set_enable_if_allowed(hub->vdd, true);
-	if (ret)
-		dev_err(dev, "can't enable vdd-supply: %d\n", ret);
+	if (hub->vdd) {
+		ret = regulator_set_enable_if_allowed(hub->vdd, true);
+		if (ret && ret != -ENOSYS) {
+			dev_err(dev, "can't enable vdd-supply: %d\n", ret);
+			return ret;
+		}
+	}
 
 	hub->reset_gpio = devm_gpiod_get_optional(dev, "reset",
 						  GPIOD_IS_OUT | GPIOD_ACTIVE_LOW);
-- 
2.17.1

