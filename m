Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1190BC369A2
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 08:18:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94A7A8215F;
	Thu, 10 Apr 2025 10:17:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yINQD8aL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBD76826F3; Thu, 10 Apr 2025 10:17:57 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::622])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C7268210F
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:17:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4Az8XF5p1nBIrbyno4wAtuO18ZLxUJF0kcemEbkkcDD4jxTRdomdAy20ZQ/kyWgixnhE1p6Jk0hoIZOCv1kqYS6L8TR6OJCecqPSXp/BXLjTt8fsNN8CtQJ2+x4YVEhVpdIlfbSBnh07VbpaZqS7itB06r2JpW49jdEO5kEO1u6gDTfMSLhtqV8fWp+88P53IY2HU5gtbP3VOsbzRstMyFyKXrqXPbgfHMJ7uaxpB0kpger0A3APdBstCTLsZ+OHgRDNGWyFZZ7XUTXG2JVFo0oerDQ0XzIYKEvoGig1/7fvXTXSdRXMac04WDhwTT+scrm71fr1zuxhjyvT1Ivcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuPYlABb0sKTHhpP1muT/3+gA6YT5nI92xx/ISwbWB0=;
 b=j65lVJrPjYKmaCDlgF6w89l2pkg1gGhKwf4WIMf+cxCzzK1oz2yJTiLuA8aX3CfK/UIn4hFlgZvTnmGrvvp5fxnr3RlNnaJ1L+RY88JftRPY6H6eRzrZoqAqf4d6044teaNg+LNC0ULx+9Mw9LyYJQes+SDspsh78E6cizguQv0QxE+7YpgUzNVA0EEX2JfVdHJ881vb0trjgypCjHnNPskpkPFdRra0PR7Hw2P2CYTGLgjI/qWUBy1fm5mYvr2NWTVXw+wh8O0RMdWggxEYio7PsJDnzD0SxN80kKYA1FJgISSTgmLnu1V+RGphnQXu/RZ4vwVWcFAUnlLTC7VI5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuPYlABb0sKTHhpP1muT/3+gA6YT5nI92xx/ISwbWB0=;
 b=yINQD8aL9OP7jSIvQRz0it+bOX0PcPriVLo6PMZO68uZph9z3ayMGzRLVrMQTigdxQHC0X9/wxwu32CGOJA0qRQyGaUbyauQHyUkXeIID2h9AowlhhqFYTz3B7FtL5/dQHWDwFoZsnes2AicNhNYEljZdKpDVfBcQcd/7YVDs1s=
Received: from MN2PR07CA0007.namprd07.prod.outlook.com (2603:10b6:208:1a0::17)
 by PH8PR12MB6818.namprd12.prod.outlook.com (2603:10b6:510:1c9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Thu, 10 Apr
 2025 08:17:51 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:208:1a0:cafe::a2) by MN2PR07CA0007.outlook.office365.com
 (2603:10b6:208:1a0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.23 via Frontend Transport; Thu,
 10 Apr 2025 08:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.0 via Frontend Transport; Thu, 10 Apr 2025 08:17:51 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 03:17:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 03:17:46 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Apr 2025 03:17:45 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Marek Vasut <marex@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini <trini@konsulko.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] usb: onboard-hub: Fix return type for regulator APIs
Date: Thu, 10 Apr 2025 10:17:35 +0200
Message-ID: <7bd352562bfe638588acfee524c5df635a77c8a8.1744273054.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|PH8PR12MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed5f3f4-c0d9-4b51-929e-08dd78082fc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B+Vhd91XfejbxYcglzVT8guhqLGd2etrhCJu2r6wMKkunrmzYI/S+7SY04lf?=
 =?us-ascii?Q?SfwPpI7A54WoCcY1ItCp2CWjSvxxwYXE4iViiZVQ6RLtZzO//PnWWe0jI0pv?=
 =?us-ascii?Q?PlKEc1HjlxPlxuj5vW9jbHKOeotX9ZyeOStv12g52gbe8MWCWNjOCTMpQi71?=
 =?us-ascii?Q?PLp8GQwyoB6xLPmKrXILy+JLF4j0gekiQfLAsIlAI6FNWxIWM3BJveVi6mmX?=
 =?us-ascii?Q?Mvg71/85LcDoddlKb0+SFeGcVbzP/I1FpFO2bnyTELw7eo0gKEwxH662sn57?=
 =?us-ascii?Q?jq2F0bDc/5e/GtAAsN5i8kQ3xL4fyd7Uh0Tkm+WWlsB7C2BbDPhJC78l/lw6?=
 =?us-ascii?Q?abZ84CUB6HerIyPNyjiLXX7k9YVE6P9zi1+61Fj7hYu8MzVkNlkuDJDiwrPR?=
 =?us-ascii?Q?6h7P1iIml5zmlRdmYfjj6FPMR+gQjumQYCbQI/u7MeliGfT2buWkF/Z45zHq?=
 =?us-ascii?Q?S8IUKabdeo/yUkefBmZ+ttmlqOnWqzc/I2n65KlhG6B7kRxOicwEuvO1ZtBr?=
 =?us-ascii?Q?mcJSQN8xCGXBfW/giO9D0qB4qKCP0TTnvGQ4XLvpPdFYjRGZ4iaER2tEbHQK?=
 =?us-ascii?Q?Wp8+HbX6XWmBVpCKZL0Up1IQ7d3dSDx8IM0TXCJ7IZnKbfkrAORRKBrN76Wg?=
 =?us-ascii?Q?iWtHqv8G0AurdZLN3ucf+/omJBJSzhkAklg/9iAi94BCen77wWUoQMkcRuuw?=
 =?us-ascii?Q?JPieC+V9Qc4e6Br3YscycI0SBx5Pc2RlxDIifVYlvj77uYLkD6pTb90tHF4c?=
 =?us-ascii?Q?6vS01zz2KGsXJ4vIr4yV1bC6sEAlHhXMgudkW7HbZ5Ol1vO9Ydafvk1O7vjV?=
 =?us-ascii?Q?IEmLQhJOmZ5FaEpR+HqQFysVOtyWiZUbZepNotmyCO6wcqV6c5SGGak8g38E?=
 =?us-ascii?Q?FiGgJgEOp4ATPEnkl4Alnu122uDjPbkSaPA7bZdtgTqouTnokxZjN6P/Oa/2?=
 =?us-ascii?Q?UIdI2WidnLgTVDFMI2HBpeaHI3l5ZIKBrkDrelRMO8FeneLle+j/whUbufuN?=
 =?us-ascii?Q?e+FRqJy84egHILCOZHyDCSvQGQrzh3D28M95OfLuVP4HViNVtpMoopK+46p5?=
 =?us-ascii?Q?bJyO0qo7gf4zjj1xiTSqmX1GhpoH5gS0navZ6d0fJdPfTEkzJ8/YqL5dSx+/?=
 =?us-ascii?Q?wNDSi22NTsJ6821OTrPV2igXWwb6EnyJyRa2v5wOyNYfneooYl7+5jFIJlLu?=
 =?us-ascii?Q?5ApmJuRyfmwPZLn92wOY9QVMv59cYDlP9hNpWYGhdOgcQdYbadjluCMTTMCk?=
 =?us-ascii?Q?EYHqNcPpsyd0kA/8xxoS/3v/P5VB7utUYzZ5CZFtNxwou/zabKT6KW6tiUdk?=
 =?us-ascii?Q?blzMsLXlAQxV1F87rhA7Yspa8lOR0fBkQjyzXlQC8OcpjvwauYkjyP6lHik5?=
 =?us-ascii?Q?PzglEELhiiaCTXTeM5HirWi+tZa7vyFVEXirUvVkHxwB5MVymZ+nnHNtDMvh?=
 =?us-ascii?Q?vzHlXyuWWQS7WDUWSLvTyVjagAD8X3fVACMV46KL2SUsC67JlyccRk9sh2GJ?=
 =?us-ascii?Q?KCBssfi87PC51w21kenzKl+gPWILeZIfbEDk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 08:17:51.2703 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed5f3f4-c0d9-4b51-929e-08dd78082fc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6818
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

From: Padmarao Begari <padmarao.begari@amd.com>

Apart from ENOENT observing return value as ENOSYS when
!DM_REGULATOR that's why cover both configurations.
Changed code is not working as operation should be "&&"
not "||" (ret != -ENOENT && ret != -ENOSYS).

Also fix the remove function where the regulator_set_enable_if_allowed()
function is returning an error.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 common/usb_onboard_hub.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 7fe62b043e6a..57c84e7fce2c 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -146,7 +146,7 @@ static int usb_onboard_hub_probe(struct udevice *dev)
 	int ret;
 
 	ret = device_get_supply_regulator(dev, "vdd-supply", &hub->vdd);
-	if (ret && ret != -ENOENT) {
+	if (ret && ret != -ENOENT && ret != -ENOSYS) {
 		dev_err(dev, "can't get vdd-supply: %d\n", ret);
 		return ret;
 	}
@@ -204,16 +204,21 @@ static int usb_onboard_hub_bind(struct udevice *dev)
 static int usb_onboard_hub_remove(struct udevice *dev)
 {
 	struct onboard_hub *hub = dev_get_priv(dev);
-	int ret;
 
 	if (hub->reset_gpio)
 		dm_gpio_free(hub->reset_gpio->dev, hub->reset_gpio);
 
-	ret = regulator_set_enable_if_allowed(hub->vdd, false);
-	if (ret)
-		dev_err(dev, "can't disable vdd-supply: %d\n", ret);
+	if (hub->vdd) {
+		int ret;
 
-	return ret;
+		ret = regulator_set_enable_if_allowed(hub->vdd, false);
+		if (ret)
+			dev_err(dev, "can't disable vdd-supply: %d\n", ret);
+
+		return ret;
+	}
+
+	return 0;
 }
 
 static const struct onboard_hub_data usb2514_data = {
-- 
2.43.0

