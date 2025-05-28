Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AA8C54F30
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 03:13:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A799831B4;
	Wed, 28 May 2025 05:13:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DmzTfVLa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6565C831C8; Wed, 28 May 2025 05:13:20 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::60b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7562D8319C
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 05:13:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VO8bRVbtGPfkIZCKR8IW6Eci7h2GgE+NRaj9dxddf1HP0sxGqIrdx7B/zGTvijZbpJEmtu8bBuaVUGWXxVDhPM8hwSJFGP404skiVLg4vJ4PbUmlzKjfocVHdP0YevU8z8tUioszG16ET+YtIIGNVWbXLCuCGuDOm3UHoS1eur8oFJ6ZXlLvCiW1Q6XJmtIyLE+fygNem+tuXV1rPbBdKSgNRtDp3jh7pypnbw3itCZ1GRsZW0xHWkUWwSFW1Yd1EykHYQ2XCOpNUvBIiJ9EwGlUp/+JrmGyUbkNBTgEpZzETZp1gonpHPgnNfNzjmP6oAqGsSGj6Np2eQ1IbrdvBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQlw64pPMii6iDBYnDFwzOsI3e2htMgeQ0AVCGVbM5c=;
 b=mag2fEpevtr5pBKfy30fkR7NrjVnqZU5h9sVwkVZ5jeqTlGLcRAkkzd0Sqgebm9j0HzZbD2MBCQ8uRZQnOb3n8UBpNIgPq1C/r2ZL+x7YXJNar7NrbA7h+Prn+9P/2zQGS19wZjBqcmkPQ0lCMB6tXjsHt5+FO8ViP9A3v0n1UG8zy4wbYLgGQkWJ9D7o6GCqpZ5C7Ze+3b7o4USPPU+qscnRZpomUcipCyA5SlDro9bZa5kUaBn4x11KiUKpecKMVXG5uWpFhamT693QKKQfAK+wQIr2PgY5wZ/Gf7tQnDlP4HQMDoy6JAEl69NmKnm/1e5KuzE7h+mukrehzCHiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQlw64pPMii6iDBYnDFwzOsI3e2htMgeQ0AVCGVbM5c=;
 b=DmzTfVLa1Hz6PyRjHyadHDs+0CsC74FWhQPaq37t03W8hOHG+GnpQZNzqFA6XzaIoqMr6OouI6SQVHxJ4nZ+v54FpZQTSUzD3BjjoGBolFg76+dcSTtgEKpyOzEXcB1K35oeKPhIRSmyr37ql06Bjl0COtrTxN34M2Jdr9cle8c=
Received: from BN0PR08CA0002.namprd08.prod.outlook.com (2603:10b6:408:142::18)
 by DS7PR12MB6189.namprd12.prod.outlook.com (2603:10b6:8:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 03:13:12 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::6f) by BN0PR08CA0002.outlook.office365.com
 (2603:10b6:408:142::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 28 May 2025 03:13:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 03:13:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 22:13:08 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 27 May 2025 22:13:07 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <hs@denx.de>, <trini@konsulko.com>, <git@amd.com>
Subject: [PATCH] i2c: mux: Fix the crash when the i2c-arbitrator node is
 present
Date: Wed, 28 May 2025 08:42:55 +0530
Message-ID: <20250528031255.1762438-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|DS7PR12MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: 59c8114c-119e-46eb-a61e-08dd9d959425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AMi0ZJ2FD0gms8F0XTXT/4JQQWS5e5/LXwIB0ZIssqqYGrl1ylIZPH3OdfFa?=
 =?us-ascii?Q?c80cL5H4vpQo1srCTqGGYey0uWK32Y6D/98eOXpqt6idh3IYnGP4sRRKvOyX?=
 =?us-ascii?Q?Y7mtwe0yGxatIhIAXvmEbZenJ0LrakkMib3KNWZn6ZuhMfvo6jCj95SGftiC?=
 =?us-ascii?Q?uALDalmEyzo3WHLaM6HzDuJWKwDb1S3idJ+bZucmuc06SDeXjtC2uokvYCih?=
 =?us-ascii?Q?5BvCOz90J/N/3MmDVbeK02j67gp4231m6CHFzgaHQNw/VvYdT+te7WsStkVI?=
 =?us-ascii?Q?zWPRGhrsDXkwLK56Cz8gNO+cZkZoc92OIzyhP5PMiC4WiXusB9Ys28xhMrqG?=
 =?us-ascii?Q?MIqzQBTMbYK4/UCGfrXb7Fd5UyI0C/CumeFf4cS9CAh7GqYqOoc/2mNSdajU?=
 =?us-ascii?Q?z39rMSSSOxH255aUNn7QhXKWpd42PMDwXc3GoI/6kRslXbBDcjYGGQ7GF7WF?=
 =?us-ascii?Q?MR+BaPMyK4Erh9m9LbOkc3KMUKhMp9HeUKUbsVc6fGughfljLj1JKKVzT+PP?=
 =?us-ascii?Q?KwKWbsWbFdCUH6iP2/49skZVCfiwHIaJHPTswTTg8AUPN8IhKUM3sY/cWHCW?=
 =?us-ascii?Q?4p2auWXE7TPsAllcXya2B8N1MqjzIVV5VnU4LbylDIaByayD5ueUlisK0IJa?=
 =?us-ascii?Q?1/8Kv+kkUWfY+DcrLxEgv3Amhb6hUWx6yeZYWCaxGFqVG3UinmaJ0EPCwFXQ?=
 =?us-ascii?Q?O3yLiC9guq4U/tl/l/7cj+eVJCfAxxZPrudqbcH23+tYJxGye1a5Q/XJrSjC?=
 =?us-ascii?Q?64tWzkGQ0zU9TNV/RxKgGt4W0Cn0kGvcm/xm8WAarTgrH97l+NLBUtjz0N7C?=
 =?us-ascii?Q?1gTBFge77N6otYZZShcwEp6T7aMm5WQGT27ttvQqsQiLI5fmLMY5Hg3hM0g4?=
 =?us-ascii?Q?V+bqz0h9traRImUEPY2R6bchMpxQWFjTShQqIro5IFVQ3sQBC55nnglwFvwJ?=
 =?us-ascii?Q?8tzn75GQOImDSrLFGOXpsiBKjClXIPMGnNj47h8NWuoMIl9JE+BtTXSPOx9M?=
 =?us-ascii?Q?zqOrNqCWFMnYpnjfD5DL3ooC0lE9PT2i8hvEeaven/FSpuJb/D4zLRebKHJC?=
 =?us-ascii?Q?u4//wnI3Bnepv2W0C185ovM/HKKrwPg4pZvbFXMqNDGiASu/QcHofqqEf1r/?=
 =?us-ascii?Q?ZGBiu5IgozSC2Ph5W1r27ER8uj3MIcE01qQaerg7EcJs/xHgMJSxMXpaYaGN?=
 =?us-ascii?Q?e4rsuZwMISQtfeWTj/pNuvtzAKHYuLiKBgAOf1lC/S0zw/NopU8SMobQBV5m?=
 =?us-ascii?Q?X9Jcke1NaiU8hpc/+l1mXKcF+pnYpi1xoHGSt5w73+c4mXNBYtVTr5UY5I4m?=
 =?us-ascii?Q?H/XEEG/S21d4bE9XrdIuVf6J/0MOtgvxPzYAfQSYnm0t7kYJQ2d3S7dJlYuc?=
 =?us-ascii?Q?fBWz0CA6eKoNNojlkFtqpw6+YF09awwxx9JyuZzhBG/LWCuNRQYjw+JGdBhX?=
 =?us-ascii?Q?tTKiYz4Cing/xyURGXtK88ch1BCWNHGG1g4S+nNYRTuTdLrboPrqRzBlfla4?=
 =?us-ascii?Q?vBSDvNsMmQS5+LMDFqb4I/HTEXj7dyZzS1/z?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 03:13:11.7231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c8114c-119e-46eb-a61e-08dd9d959425
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189
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

Observing the crash when we add the i2c-arbitrator node in the device
tree as per the DT bindings. The issue is with the child node of
i2c-arbitrator@72 i.e., i2c@f1950000->i2c-arbitrator@72->i2c-arb, as the
arbitrator uses the uclass of mux(UCLASS_I2C_MUX) and the mux uclass driver
checks for the "reg" property using the i2c_mux_child_post_bind() function,
if it won't find the "reg" property it will return -EINVAL which is leading
to the crash.
So, add the logic to check whether the  child node has the "reg" property,
if the "reg" property exists then read the "reg" and update the channel.

https://www.kernel.org/doc/Documentation/devicetree/bindings/i2c/i2c-arb.txt

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/i2c/muxes/i2c-mux-uclass.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-uclass.c b/drivers/i2c/muxes/i2c-mux-uclass.c
index d1999d21feb..b18999c1fe3 100644
--- a/drivers/i2c/muxes/i2c-mux-uclass.c
+++ b/drivers/i2c/muxes/i2c-mux-uclass.c
@@ -40,11 +40,14 @@ static int i2c_mux_child_post_bind(struct udevice *dev)
 	struct i2c_mux_bus *plat = dev_get_parent_plat(dev);
 	int channel;
 
-	channel = dev_read_u32_default(dev, "reg", -1);
-	if (channel < 0)
-		return -EINVAL;
-	plat->channel = channel;
+	ofnode node = dev_ofnode(dev);
 
+	if (ofnode_has_property(node, "reg")) {
+		channel = dev_read_u32_default(dev, "reg", -1);
+		if (channel < 0)
+			return -EINVAL;
+		plat->channel = channel;
+	}
 	return 0;
 }
 
-- 
2.34.1

