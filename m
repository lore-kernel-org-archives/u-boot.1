Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A00CEBF65
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 07:02:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9276989070;
	Fri, 27 Sep 2024 09:01:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FuM09BNl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE1D889081; Fri, 27 Sep 2024 09:01:47 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35A5D89089
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 09:01:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dh0+L9RlxRGegVYOHY2oijPyvjjUhYRsTa3MYPjgil5jYGz0eppOYlc3fGZUAmKbKJWNS2SWXg4/Xghom2/Hz1tsT6S9SSkHvRluQF1sNnO2TBn5uSoRpYjh4Lrvhi8qKxCS0htoBt6wI0Fls63rjO2iqrJgfVf/nwrleNn/4tIraJtRwWlsN24V2dOzm3qZ+FpZg/bO+4O64Q4mib/6LeNeiV22IxHxA8H2P0Wj/+JXx14hPns1AjZGABbLTN+6hwoW3atdCsGSTbdX4QEdu8wl+r7twh6haTb+CtyW6tTiED3I7pL7+Gzg1ES4pA5nPno1o4LOgckP5a0q0WlOBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8iKTTNGnjnIekvttA7BWSPdTAYnfX/npeQnM4e1z+T8=;
 b=ctE6Er+aLQG9iePcVkPYNxVGS+Ndz2UeUnNQlki3XrJ8tIcPfNK/fP3p3hDom3B+zLs8wyxCW53+Fr2+wYbZVUQMZqW7DAPtxpRzoOW/iZ08nFqcBffL2l3B0cs7GfriIsZyyi5rh/nijnye3K81DQoe6ZI4J8sOk5Byl+AkldQIMhZ1TxkTiXX0B9GCdTNuA2CakNawOHEmtUXgxjiiKdCL7D2jWh98PYFZQYtxtyF78Qjm6no/jdGwfFKFNgI8l1t9qcgGLpY4LXcUq9+55/VGVf7Un76q6Ogak+VXx1kGDIhKf6Il4WjRvdysm29ItecoecmAn4aDFL4UrEiNEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8iKTTNGnjnIekvttA7BWSPdTAYnfX/npeQnM4e1z+T8=;
 b=FuM09BNlxxzqlmSktb8LyAaqErm5+GTwdCNB2RnMz0vhAA9OSYwH0YRlOOg3+U8OEf2Wbc5/vxAkRnX8t3nKoN3lgrLk/Yeg5NYP0BYkyN4OwjcU1EEmsXJ4MnizY2kM33rKa8n+w6W4T1JNjkkdBAyITxdE5sUft0br/KngJzQ=
Received: from BN9PR03CA0757.namprd03.prod.outlook.com (2603:10b6:408:13a::12)
 by IA1PR12MB6532.namprd12.prod.outlook.com (2603:10b6:208:3a3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Fri, 27 Sep
 2024 07:01:41 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:13a:cafe::10) by BN9PR03CA0757.outlook.office365.com
 (2603:10b6:408:13a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22 via Frontend
 Transport; Fri, 27 Sep 2024 07:01:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 07:01:40 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 02:01:38 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 27 Sep 2024 02:01:37 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v2 2/7] usb: onboard-hub: Fix the return values of regulator
 APIs
Date: Fri, 27 Sep 2024 12:31:32 +0530
Message-ID: <20240927070137.21816-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240927070137.21816-1-venkatesh.abbarapu@amd.com>
References: <20240927070137.21816-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|IA1PR12MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d270d6e-38e8-4c0b-9e80-08dcdec23cf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?djhwTV5QWBoCP7wYqPpLS3kQyydVDZoTNoN891q+RB/BEXNZDLz+4mLo9pD2?=
 =?us-ascii?Q?30ajhDU0udqqpFtKBbdnNVcPPg4Vr8baOtK30gAunZdcMcftBRT2yY0v8Bs0?=
 =?us-ascii?Q?KusPY/A2ianIIWwXXPqjrINXWXSC0OQLJXQqbpi+58cWtw8QXUwWyxLfI9j4?=
 =?us-ascii?Q?2X4/ICWnoK8X4xBvfbQAUw9fEQ2Z6sXxs8F1KwEbAczstK8u+El2UA3fVTOV?=
 =?us-ascii?Q?Opzx8LvU28S0Ba7bw2e+/TpoLe3EpxG3yIsyg1D4bunrvleaJdFTvBQyXhd9?=
 =?us-ascii?Q?GM+J2+ZrUziqCEIoxfb7O2ploo8AoAY9OYIvRNbukQl0ohnCuWrXeSn8Bywl?=
 =?us-ascii?Q?p1gYnewWx13THuZu9ttzp2K4vjYDSUVvZFWwkLVqP3rPs/qmRgdryX/FTfcA?=
 =?us-ascii?Q?KNW4QKstWS7BC6qYuM3dGPKgmu5wP6hb73Ha5ctUzILfmzSvaouz8Q02M3Kp?=
 =?us-ascii?Q?pPlSNYj7d7585FMRBzeLN/r8XpiTl+9sPXwTgxICEgDGZSafiQd8IBN8mUaF?=
 =?us-ascii?Q?moG40TcmSv6/RarJXOYfYAEe6VyMHVbusJHYcIpyonR/RREoZtxLORPnIhzC?=
 =?us-ascii?Q?7GoozxEkRm6bAE6/t7A40ogUPceg3JBWKJNnHeiHPIa9enbNwa1LrQnkvtN/?=
 =?us-ascii?Q?cLvhIuI5v0vqoW40+8jVW8zI6ThwrwbMrsOs0aPyP4acbgsVefEqCxQvp1py?=
 =?us-ascii?Q?rcG/Z80ZaVe6Etkae3rLnJuMfI1hW9RtvhL6xtMKh6NNcFiMujqKaEad0Lc8?=
 =?us-ascii?Q?LJmIBDrBs71WumeOxQBVFLX4HBnOMYvWCHjgycEcYvYW+IuenrbNRYP7TM1g?=
 =?us-ascii?Q?LvHF20aoCsYRsGhJC+t38eJ0Vmaq2Gh4Tih5ZdGD9fCyuH8GMtas47f0u7eY?=
 =?us-ascii?Q?/BeR1s1a44eJhgBxKO0l+ZYjojA5dKXDkyT5AT1Lg1BBaY1PojPfJofRkxqA?=
 =?us-ascii?Q?H8x3ATfq7lSn+gLn9vgIKwNnXM8HEs+u6hCK/0wHtawaxNz9H++zJTfONndP?=
 =?us-ascii?Q?pLRFYnFxsO2fMqEJmV5TwPRRDscEC0YQMTX5tCldVKZCdYblKMeUS7Otrmei?=
 =?us-ascii?Q?hBDTr9TQFvK9Zy/9aB3whA7q8vPDnPEHagGkOFu02DntO1oTb2Uwg2FR9xDO?=
 =?us-ascii?Q?BAAI4oYy/uuk6sMyIX6SVGN15uT9ldZA73ib0AeNku3YYKSfY+VldWdhRVi7?=
 =?us-ascii?Q?RhgxgTFLQqWo6p70g4DmEY3+RbB6CeSkjNAU6bA/P4zQX9vwLSUMA/HP2f+y?=
 =?us-ascii?Q?7WxKcV9Nhlfizi1cn/tgJ23DwJY2xcjVu8yjjgsbLJIN0LnN1aDVMinTIwTx?=
 =?us-ascii?Q?NkjFXSw5SzdGoQWmIH7PFky6sh5DjfzuUWPHxBXggk7esqMw52zoXXef1KgQ?=
 =?us-ascii?Q?H2vTBHZA4Ormbdpth7vuPKOk2LQH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 07:01:40.4031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d270d6e-38e8-4c0b-9e80-08dcdec23cf9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6532
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

