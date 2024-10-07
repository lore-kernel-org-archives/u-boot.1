Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B76CFB440
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 04:46:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17FAD889AA;
	Mon,  7 Oct 2024 06:46:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nNGuZCne";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1497E889AA; Mon,  7 Oct 2024 06:46:19 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::603])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8376688CF3
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 06:46:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bj47d6BKMkvc7O8DN9OARtBM57wcRv/UdKF8KOaCEtSQ5bucZo3U7S9B3zsTjZhF5xFIW3OhqscCXeGcIau8kYr8uALvtGNKMvytFC0JrWmDivTd447cloJYkZ05fiM/SJ1XSP3okDuQWGssVwawXriWsAvyRkQ0AA9MMPnZUiQnMwX2hgjdFnDQ2VutmFv6Z9lMpfk4zp+bK//LqC6AFo16akWVp6S/WZCCJw+SjvBIF+x3s+KH7+ZlVyDR2pq+Ril7KvKnss5W3KhdxMPUs6amVY6EoqO99iwy6YYcNLgUnz5QgwAYmusB6Eusqi13eq2W1LPZVXJkR4el1cPXJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcYdNdN9Ib/OZNo5tYF4ODj9+borYd78uQ29zwMs78Q=;
 b=Oh5PGUCyRTKNjSqgzhJ8/hLOUnMMVaIh2cuNHMJkSHoGeiQ420aPuPbozRkwrUZGdjOvGvMon0yPPHVYGKs6qhtrGyD18+yLxNZuZj1iSJTDsx/q1iArQTYSqHRT8iU/4ILI9wwzZNoauId2P0QsTShJau3rjnFzT+byq66hfufTEAzL8fYBG3PdVfYA8i6LmZlRCKkvAO1izlWglDvxYpVCwNYf7XM2ipzAPbKiYiEMoI3EiBnqXZWT92QaycJ5GP/0wUR0kVTRK4knNYxuOFM2PeEIXqGnx1iex2+WFRIMGIvOkUKlkaUWs9/dQ35lIrqmBny23agWUc7TpIEeWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcYdNdN9Ib/OZNo5tYF4ODj9+borYd78uQ29zwMs78Q=;
 b=nNGuZCne4n7xmcZTThrTCjav+GAdk+LxhFRhIqonP4pvVVJDq+joDFg9Q0HEcxUq8SJLsiY/KeltK1t3J0TPLPhtcSXTRxS1wfOvCAorjR0q8wFcTAKxzPDYvnUlp1jar2KBqE4GwLARHKICyVwcK0sFggApt3K4PncBHFjWWvw=
Received: from CH0PR03CA0436.namprd03.prod.outlook.com (2603:10b6:610:10e::33)
 by DM4PR12MB9070.namprd12.prod.outlook.com (2603:10b6:8:bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 04:46:10 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::5f) by CH0PR03CA0436.outlook.office365.com
 (2603:10b6:610:10e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.21 via Frontend
 Transport; Mon, 7 Oct 2024 04:46:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 04:46:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Oct
 2024 23:46:07 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Sun, 6 Oct 2024 23:46:06 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v5 2/7] usb: onboard-hub: Fix the return values of regulator
 APIs
Date: Mon, 7 Oct 2024 10:15:42 +0530
Message-ID: <20241007044547.23896-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241007044547.23896-1-venkatesh.abbarapu@amd.com>
References: <20241007044547.23896-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|DM4PR12MB9070:EE_
X-MS-Office365-Filtering-Correlation-Id: 855727ad-2db3-4db8-83de-08dce68af6ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6GgtlKmpVSuZGar4GEnJjvMq6lp5lgIw5kmJwe/J96QfJrwEl+MsQh/yo8vY?=
 =?us-ascii?Q?ydOZK0S+uipBff4fMmJ+m81HZxCI27JlVpFuTaJ3W1wL19mjeqss5uxNmJi+?=
 =?us-ascii?Q?1iAibtO4SF5qLjDMSXwrnm/CEB1xgtFx19xYl7ZVSZNAlAyGNqZ3HI2FAQqw?=
 =?us-ascii?Q?Hnil5aYiUcRS+vZSOZiEqpc3390DHaT8u4k5n88Mo3Jfq9vatLD7K6ivaSV0?=
 =?us-ascii?Q?luMo2vGsfWi8vElIqXocWbb8sHsfbT/WK2fZJHXdjcCcrfdi2/Lysj3a0Pyz?=
 =?us-ascii?Q?ks48I5zBmi3175pUaKs1fC7jbjUaSePN0VoItMlC8bRc3XiG2u24XCo5xurT?=
 =?us-ascii?Q?0bNJUiVCRL5HnvICPUnMp5BUZ5MEI9I42Br1Bjnmsmfkow3o7s6mZaC06ZZl?=
 =?us-ascii?Q?lbduN20ga6JwQcgmykhf3lIqhFjmUZTWsE7bijRNIOmHKY9Stae6U74CutXO?=
 =?us-ascii?Q?chd2fJDgqyEHroWFBqM1ZZ9nylQZhaNGi9iigAwb3wtTSWecJdaiufKmuay6?=
 =?us-ascii?Q?cHBc/6pW0bFy6eeGIlNAkoUtu5/xKl8y2eNJe58Qvm9iD3lxIk3rqVf+yyBS?=
 =?us-ascii?Q?PXG7w6M302c90ZJ0tPw9fKKOjyypMaNADJLUxRLl7qurDejgz51tPQl+MsqS?=
 =?us-ascii?Q?Xto8JUaVO63Kn/E+kIRnMP0UNgw1bhxGqUyszb+Zg0pyD1iyV5C9rm9qd3Mu?=
 =?us-ascii?Q?3wGsffnaqfuab6PNjrWw4U+YaL/lBH/bDTA9xvshAF0TtULTUSvclz1Qq7SO?=
 =?us-ascii?Q?WORFsL3w1uoUPhY0ATAq9nGJxuCaDBJkZ8sUzqI/Q1gvi6JXo1dgiFeZ3Yd0?=
 =?us-ascii?Q?s3+YtXdBHhUnPja9FJE8Mg0iEfkL5EukncwwHAO9+Ye7i2Wd6Cu/rc9cVcX7?=
 =?us-ascii?Q?3ZVlNnqvrjXrkU4Je38a9QjWKoTFZWlsdbPRrVu97/ELBhvSomWzAmIt7Y2/?=
 =?us-ascii?Q?6pA1azSlS3LvVtWeZKe97gfEFq0BNJbxN3EO7VT7BlylYphcuUW0DjeKmQLD?=
 =?us-ascii?Q?nqHPZI7Tm+YvtNKkzQWuC7icUPgH+CLNdZ9qsZCUZlyAgIp47FYQtoDFM5fW?=
 =?us-ascii?Q?8oVuiyI7iSGP8AUBnVCDjlF+JLr5It7UMNqwz7SnE20D+u1ZJb8or8GkCq3I?=
 =?us-ascii?Q?tc49cV1h102Vsluk2jJteAEsP8Zn9F/D9tiAGeasX59g+Ea+1XPBJ0HG0vbr?=
 =?us-ascii?Q?YXyX0BddWWJpHeAvCagK/qZIw76SMSHIo5PEOVVVSy0ZNAWAhQCvnXZTqoek?=
 =?us-ascii?Q?WtUESK4vG+Wh/alp/nJAVkmXPhXk36qWYtvJmRUZyZiJj2PfxXUYuGXwfq5q?=
 =?us-ascii?Q?ywnIbdv2j83RRNxnijWGMQW7xWVRJYau3z83x7gW5V8kiDpImVt16Y2MdYGl?=
 =?us-ascii?Q?Bdl/DC9n4hW5/lrKGVmn/LtrBtUI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 04:46:09.7494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 855727ad-2db3-4db8-83de-08dce68af6ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9070
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
index 4317e81ed8..c395ac4912 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -58,14 +58,18 @@ static int usb_onboard_hub_probe(struct udevice *dev)
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
 
 	ret = usb_onboard_hub_reset(dev);
 	if (ret)
-- 
2.17.1

