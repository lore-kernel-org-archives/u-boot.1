Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C49D5E124
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 04:01:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15AFA88D9C;
	Fri,  8 Nov 2024 05:01:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="harEk5Ym";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E76A588D5A; Fri,  8 Nov 2024 05:01:28 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4AD088DFA
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 05:01:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHiRGCDu4yWZuuGatMGV7Ty5v3EPeg+V/zDP+I9RmBdoHgV6iKog+2x4dvl1QoE0LkKJlhFIFcRA3XDDS2FnOfDwkBLHFc8121BIbOBnX61H6EXEqbXX+vu6cb7+QSyFKYdnHkPbpT6sVQPBk+VUBQlYvy9TS/rOD3YMhwyRLk7Kpp2Z5nWiBqIBLzjUQmRTLNBLq6UydChX6KSSXMWOv3jg7cSGT/iuqHKP/kKBqaJ9wFGcqSulXf9AbbsAX7mNbbpFI6E/gpisEvT/JdfaxEOxCA++TOfxOZ83YaEYCunZc8UwFgFYF1vR7h2mzMtMkg/hABxC3qXfiJY3TcazbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CPSTY6hPGfb1sbgYRaAW2wr07nN6WBQ4wAkrsH6+Y8=;
 b=d2SJS/QCrQzNN70I/kfocds1wVt3LKRKUmSsuvEnE7J4VBCoeqS5BOsvw1lh5mKVIOEO3cIFOpsusDwQsBR8WbZdUkY+vSgxSelw0Oi1VyHdSBZa84r2AqOSed++Bhmf9IM1BF1nwzurANl9fNRrHJuDI6vhAg5j1/1ujklzFCzEgIn2Pj5C47FGTL4pWRDQ7lwcWz28bi+JeCrAtjYB9GDtfOk7Us7jwhK23kvnKjnI7oj28/no0uNpH17Ie9konycyzazyOTYDKlBIuzNUOcHr1xYtzdelFq/xN5p+rorSiyVkmNkoT1Jfnm8oXLkZ4Kj3gP11BdUDwE5WGwuUCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CPSTY6hPGfb1sbgYRaAW2wr07nN6WBQ4wAkrsH6+Y8=;
 b=harEk5YmowdfUOG68WC9vrfRUNIOsEQggJhZJsZ91D/Oy7XBBt/3sm8th4iVwjqCxEvDXZqHy5dwcqrFWC5A1/MCsSjjkwkyLYhCr9PkKUGsznr7AucCPurL3jQUhM+A9J/MJbwK7H+D5b6Y/Ad6IzY0XZhM/Gx5JXPGcDRUNQM=
Received: from MW4P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::34)
 by DM4PR12MB5770.namprd12.prod.outlook.com (2603:10b6:8:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Fri, 8 Nov
 2024 04:01:23 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::f1) by MW4P222CA0029.outlook.office365.com
 (2603:10b6:303:114::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Fri, 8 Nov 2024 04:01:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 04:01:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 22:01:20 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 22:00:12 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 7 Nov 2024 22:00:10 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v10 2/7] usb: onboard-hub: Fix the return values of regulator
 APIs
Date: Fri, 8 Nov 2024 09:29:54 +0530
Message-ID: <20241108035959.19970-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241108035959.19970-1-venkatesh.abbarapu@amd.com>
References: <20241108035959.19970-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|DM4PR12MB5770:EE_
X-MS-Office365-Filtering-Correlation-Id: a36a5314-41ec-4d0e-f0ac-08dcffaa0234
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XeL0U05GwJBpEnJvt/DEGzeCCg1L7YrGpcrZ8CeUkv0afzn2sLKCIuAZfPg3?=
 =?us-ascii?Q?2s/AJP+KA3jsxMi7Ebe4sbbz5UfimVVHSzblbtwRYDGSf8vITzCg8Jr7k5M5?=
 =?us-ascii?Q?bMnCU/VdlfgAXsyZq+xUEIu02t1foXa4U1patPZWrLDqXBdt5EpjhPSjHWYq?=
 =?us-ascii?Q?eYAl9yPyWOXrgDUr8eK9hT9TZmFgCfDYwKh4z1k1nF7ph4RQorzGPP9h/dtN?=
 =?us-ascii?Q?DvV7OPWu+dPmHmLcorTRSTlWUAtp0dGEAGU6zkLZOh7f9lVsQkebaPhLv5ju?=
 =?us-ascii?Q?5lVYTbkrl3RyPttRxDDXp0bjgGDXOmpoTY/BIqQsJQlUNBs3KUd+4q6Nkz4V?=
 =?us-ascii?Q?qMujhshuyWeMd6AsaXYvezs0SCGymGrOHtBfTBDMpNacPpoKCC7KBxQZd9/s?=
 =?us-ascii?Q?PSbPtkmD/4Gzs+ZP3z7MD0szYRIGEtUgVj+QePnhKOFT6pIg7g0isEcR3UTB?=
 =?us-ascii?Q?YV93qzT8dbgaVu9Qct1TXd+cdpyJNOohRNG6fJ8bNqztAWDlYmj0H06o/zF1?=
 =?us-ascii?Q?/gmiXvuMq/3b7Tw7gR8AXKd4/QkcEJioi0FCWRWzLX79ZwRsoWf3VMPJfcBB?=
 =?us-ascii?Q?Otkq8LuZBoiJr1g8Q79hIY/qulXSKGSJsL3A+aQD1Rrzc5Gdpbk4ulVjNfHW?=
 =?us-ascii?Q?ZE0/Uo/MKlHIjEXfN6hkPJWe927CYSUlOUeazrzu3WKT8LAhe6JejS8tdctI?=
 =?us-ascii?Q?NFiSEDEdSR+5ZQiT14JG0DxZQErF7IqKDESAVmfFNzBHQfSDNjU3Bf9kDdAw?=
 =?us-ascii?Q?BK1t9gFC904N0/RZy55MndhhYF310bjSxsxgBz07rpf6FC9JeSd23NRPcw3G?=
 =?us-ascii?Q?vYtgAVL2sJAAIlCEVpAcfs0JCuP7p7Dcxj+YjT+eUGsJrg67c1Z+soHq5rrS?=
 =?us-ascii?Q?SSmQ/ZMlhlFYXhbJQS+sjUdaYw6xGywX++DqCPHJEiZ0Hpgct1tWNHoj7e9x?=
 =?us-ascii?Q?qK8yynUoLXzpBBbYGBdOGpA146YYTR2R7ciCw1fgzE5HsKW15UA99zJO87nR?=
 =?us-ascii?Q?x8kZdTZkdcI+R/EcLP8H5/DWq6bBIpho2FiM414ebOfXNlo1gxcjwcJt3GDX?=
 =?us-ascii?Q?3kUupCIN6O+1okhsi4nGSJDdURWAK9Sb0XyveeANFVbQy+xbxPciw97nQw5g?=
 =?us-ascii?Q?k+8RY3B/U7ro2UcdxkivORCYg/LmvnBJkHj9jLZ+nmxN0p5SUwwNx5Upj/Gd?=
 =?us-ascii?Q?4ek+413hxc3hHP41E10kJXluWLhSYI8MO5l6be8Y3vbtbfGzMplVEQPO4o6G?=
 =?us-ascii?Q?i4HRw+ghF0BcLs8rxn9JJlJPmVPFQzBZ2WMdhoDC/MgDRkCXSfza5AFSTXcQ?=
 =?us-ascii?Q?2mODOa59V+4rQA3KzMF7Yq3F/NwjhXJTzwUc+D31Ns8e4K9JzJL0VR0LGcrr?=
 =?us-ascii?Q?zU4IfT7HqVvxcoIVUaLKErtvIti2psIIZ8O6Vh/AQ5autusoPg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 04:01:22.4752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a36a5314-41ec-4d0e-f0ac-08dcffaa0234
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5770
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
Reviewed-by: Marek Vasut <marex@denx.de>
---
 common/usb_onboard_hub.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 43f4cee40b..827ecf9b02 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -57,14 +57,18 @@ static int usb_onboard_hub_probe(struct udevice *dev)
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
 
 	return usb_onboard_hub_reset(dev);
 }
-- 
2.17.1

