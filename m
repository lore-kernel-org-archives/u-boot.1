Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B827D358DA
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 08:11:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8660D83B72;
	Thu, 29 Jan 2026 09:11:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MBBQWxDu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BB1C83B95; Thu, 29 Jan 2026 09:11:19 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73D7483B5E
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 09:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkTNSDuJ+n7WWCd/cXP4Gquu8QPP9TV6hehMrYvNuBx87AR8DLhzk5Mzu0coDLy3AnHJzHASCwfuOWhovOINprtRq+11wHP+HPXkwJ6Vws3nbQzdPAa3AEMXGwtyyvu0+lbQxKYkgo6vpBym7gnnK0G2JZbrWUv2/S6ND8U9sGoGp05h3J35EoUs0iHwNHcAD5pinxjvS4DA5vZdMBDChIDbzavEnH8juEpbr67eH59S/z/dCyWOX/WX5XrdQKdqfM3YpIkVnc8BpnIEzAwBaV4CYOVqTQiorYS7X+nAKPZG3bMyBRM4dUbWr9XfyzTDJ0s+s47rxTp+PbsBakLo7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bi7QZKcXNubNPfEL7BMqCd+XWoKZn926sPgYXK4zLIA=;
 b=HaEl9770rvcoz6c5WV06l91gYKxmFh2ADUaO7j44Lzkp5qzNbVql+0TboN4VbbLqC1nbAqBv8LdYQL1uXsjOOX3ZQYB0Qajbx5pIeExQWcH06YQiDKeyLLBG3KFJnbCYHC3vSjmvX6rQwh3jStaBTVapcfRVyNmwvAPB5G3PIH28iUA9MC1fi7NFeunHQ0anzWaO32KriOM0LB1VtVL28tYnsImCWFtZbuZXZA3UYuWt9D4hrfAb0BtcAIsm1KaGombpkgILgXIy+2AYBx1DywVthD0xjrINXl+FngQJ9M+NghAywCXMPHZsHQ207GXZv3U4p7HDBygmjAzs7IGVIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bi7QZKcXNubNPfEL7BMqCd+XWoKZn926sPgYXK4zLIA=;
 b=MBBQWxDu3Ilscg+wjREzk2ZXd9TgonnXga29qqjIXOXi0GvWfqnEILjkDnGbEe/J2Jz12A5BwISZ1Ku7qpPdGqO/attTOYkJLXAWS0G1pPR757zR5730KHiQYs0TkGmE3wMufnXki4SIUHdkKHKZAaRC4JHKoasevK/IQEPO/cQ=
Received: from SJ0PR13CA0074.namprd13.prod.outlook.com (2603:10b6:a03:2c4::19)
 by CY3PR12MB9579.namprd12.prod.outlook.com (2603:10b6:930:10a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Thu, 29 Jan
 2026 08:11:12 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::e5) by SJ0PR13CA0074.outlook.office365.com
 (2603:10b6:a03:2c4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Thu,
 29 Jan 2026 08:11:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 08:11:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 29 Jan
 2026 02:11:04 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 29 Jan
 2026 00:11:03 -0800
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 29 Jan 2026 02:11:02 -0600
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, <Padmarao.Begari@amd.com>, "Pranav
 Tilak" <pranav.vinaytilak@amd.com>
Subject: [PATCH] net: phy: mscc: Enable RMII clock output for VSC8541 PHY
Date: Thu, 29 Jan 2026 13:40:54 +0530
Message-ID: <20260129081054.1703479-1-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|CY3PR12MB9579:EE_
X-MS-Office365-Filtering-Correlation-Id: 463e4c44-28ff-4a74-2583-08de5f0df760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aFG3I33IAduGVVZ99mU27DLjSH40JAZSKkTq+ktJKJcMOsvsictIqcEPw3yI?=
 =?us-ascii?Q?gWgD4DZCFKlmn0cd6Rk39PESoghhdtCQUzsIb3VMq4p+ALdDyY+2t5Pj/3ZI?=
 =?us-ascii?Q?trig05beFkoauCrN2BouzynAtsSCaYFA4Qo4tYKV586EyQHwESw9iebx+3C1?=
 =?us-ascii?Q?6W7NMbOKxRC0BIhC6PhOblnhREs7Cf+wzySAJ8VD8QFbNFbXbz200q9/Zn38?=
 =?us-ascii?Q?e2yqXR2XERgy70KdjAq5zv6h1pcQpcoQzfED4A8SmLlwhQiXYwfptwSkAP6A?=
 =?us-ascii?Q?xIObyGg3mN8CXboIQSZmyoEg5aUXW5KDCzMqt0XAi8F7xSdvUI/FaB9+KpX1?=
 =?us-ascii?Q?iqS6VOmoE59whUd3J4iwH2HiJO31ZLhiXMv1wYBFztVULpCB5kmLkaX5SpQX?=
 =?us-ascii?Q?uGXLJZtr1zElelpQI12prW5Y7shLKINzmbNufnGUp5ujmlDpJG7bc75t52cg?=
 =?us-ascii?Q?rQ/TjdtTefBfRNztaUwEdEhDt79e02ltiCnN3e8XkMqlmDNUJ2t/5iW6D6OL?=
 =?us-ascii?Q?GJLzR1Wrjx1mrcs8UA7n/4Nub1n0v4XtTNuOd+DaQLBe3NX0W1S4L8YnTQP3?=
 =?us-ascii?Q?4MJ01CeZ7RQ0Hli+pE6kKCwa6Pc2ek33ggEXKogSS4UVJvYi3IYX9qVFBuey?=
 =?us-ascii?Q?poeyQ1K6Fx2LPDbPAzaemKRB3TznaQnETDVj5XmpD1Tt+lZteceeencNTZ49?=
 =?us-ascii?Q?U5XJEBIEu1a8yQQsIIRcBl7PnTDD6RhxyBvBoB5vSQyOI6elygSuPrkrI4cF?=
 =?us-ascii?Q?m+SYQTFXqvOIj2AHoDpcHZU+AzneXZoSl/KMeylMSNI6dptVLf42VNKDIV8X?=
 =?us-ascii?Q?qeKTnlmMDqvlL8f4faiH3ncNZ4RswZvS8Qgt5fgM+Q8st0vwAiVmxkilE/QY?=
 =?us-ascii?Q?vDbLDIzcXLl51Arq0qozH7ER1XDkIVrdSZcyjLSMsq5mo/yD4J6efLAhde+/?=
 =?us-ascii?Q?nUlgoxpnK/gWNzcvIJQRBtiRDAf2Rg+IniJTUMmvlRKRgZsgSU8j26p1d5X3?=
 =?us-ascii?Q?jeq5+Q+ry99EcYZEcAAgBiVQ7RgjOsqRKhx4SVhNQjxaUHm0iIsKrm+FV8cK?=
 =?us-ascii?Q?ncC4/+SRNKOF1zWiqMFcXhtL2YIExVoJn+1m5CFhLhJLwFcA1kPc2O2tZJ5k?=
 =?us-ascii?Q?PRwPXfn16gVHt2UeAcCfNDU+xG4cax5/DttuISqz7KdJbZhZf/A5hTRej75q?=
 =?us-ascii?Q?WPlvaQJQLrFEUlQPlidZ4K10Xpcrt6wKoxciy5SnySh3oFlcjxJrBFNoIIwx?=
 =?us-ascii?Q?8UUiZp29v11fgkEa7NGBZ4xLpYlZYgIpDFsYsmI4V15jRmEXk0UgDTmo36RU?=
 =?us-ascii?Q?fMaEG57s64JeDTNT0jzWIXjy9cKsRVZGjwTbv9b5/vch35zu1nE5yHtBSJ6n?=
 =?us-ascii?Q?HWtZPoGABrPrMsQX5yOEtes0Svasg3X2EnXJr4tAbWRRACaZ+h4Ba1SoxdkZ?=
 =?us-ascii?Q?FYrlb+dklKYbSp7rjDxFV+aTdb5etD6DEOKX10vaqiRfWhxQRzM3Ih34o4yA?=
 =?us-ascii?Q?Sfxr4YqaxQyDHjOS4X+u/ErxsMhbt5F7sSlkLrG4xw2efvfncDs90u33uVdq?=
 =?us-ascii?Q?DwZwvhl/e+XkBKEddSigY0CKwaCtGfQKFEs+RoGzsJ9QggE/dJIMC/5WwrNJ?=
 =?us-ascii?Q?p75MIAPCrL0m4fDy7qVJuPgYf6Ds3TNGpMHZGvf4xjDGrMZny/2k2LKMS2jy?=
 =?us-ascii?Q?CjL3DA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 08:11:11.9873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 463e4c44-28ff-4a74-2583-08de5f0df760
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9579
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

Set RMII reference clock output to enabled (1) by default for VSC8541
PHY in RMII mode. The RMII specification requires a 50MHz reference
clock, and many board designs expect the PHY to provide this clock to
the MAC controller.

Previously, the driver defaulted rmii_clk_out to 0 (disabled) for all
interface modes, which caused the PHY to not output the required 50MHz
clock. This resulted in MAC-PHY communication failures and prevented
network operations like DHCP from working on RMII-configured boards.

This change alligns with the hardware power-up default behavior and
aligns with both the generic PHY driver and Linux MSCC PHY driver
implementations.

Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
---
 drivers/net/phy/mscc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index bd9cd952975..e93996e277c 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -1385,7 +1385,7 @@ static int vsc8541_config(struct phy_device *phydev)
 		return -EINVAL;
 	}
 	/* Default RMII Clk Output to 0=OFF/1=ON  */
-	rmii_clk_out = 0;
+	rmii_clk_out = 1;
 
 	retval = vsc8531_vsc8541_clk_skew_config(phydev);
 	if (retval != 0)
-- 
2.34.1

