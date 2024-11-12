Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4AFD41D52
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 05:13:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ECE1893AC;
	Tue, 12 Nov 2024 06:13:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fUOiMQo5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84729893AB; Tue, 12 Nov 2024 06:13:10 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::605])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9F6E893AC
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:13:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUXSGVyf0dFqjHln4nLPTvcv3Nx+stgMSxEgZHGB0UEKWa1b4lH0YJVrKaPlhWboqxM5vOn5RALzY2m4xHktSzZM7MbaIo1J6Lyl/ipB6XOKut80y+EKp1yNLQIwGehRliMAGs0xP7n5aQhJt7+wqqDzViTguqZs1lMUoHrPLab7jCcJKp2Z5Ze/j3UIty1b27hHqV2vPnMqQEvd9jR7zlz9bpuU+js361O2A9aYCMtLtT9LY7ash+RG47wDoA4iilm0qhrtf1PbXUV78YM5zDvxLZQzY9UAYT7AqxmJ5hmE5sWnUB/8aQbC3G51wa7uh94Z93SWSDq/wpRX/rnxmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6rFVr5I1DCrAmmLb2wCenpMCR6S/ZYjh9agToJLi84=;
 b=s9S/HgA8IQsWH3Eix6hi2NXM6rxL6KvIQL9TgG8KOMgDrr8MLy0kfGVk4XeRhIgoUArwHRlgv6ybLPuQUG3jehjZqdzUSw8hvDWpeieF/aybjncDcRFiKHytFvl9PKA4qK+Lhet9uE2YZEUfgx9qLBdhLdH1N8hwR5XrvCL1EP5bu2b6Y+HVS5+QdivnvaU+x3+VKTFF9ChdMPII4O4dtdjjKOTgjTDIXU47d7/UNZLpDp+TimwPhXiHw7gd/pW93+cQ6+FOqRCT/1w74/WSY7FyigPagrff4bfpNy2PYflxG9cfwv/V1Qu8MmKx9g+6VpN6ji/7C+or5kgosJ0F7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6rFVr5I1DCrAmmLb2wCenpMCR6S/ZYjh9agToJLi84=;
 b=fUOiMQo5jh5j+jImH5GbDfAXk3H27DnRv374g1pgHFFmc6XQbBRvU6ms9kVN2xfJ8Jc9fiZc3iBiNEpuBu4Z+18Chk4YIcshE8Y+hHcZQfTbZg0+dJqL/rvs9xvd7eNtU17+mMJWYKBIVG+Yx0l6ZGKwTC8Xjc82CB1SZ7S736w=
Received: from BL6PEPF00016417.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:5) by CH2PR12MB4199.namprd12.prod.outlook.com
 (2603:10b6:610:a7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 05:13:03 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2a01:111:f403:f901::3) by BL6PEPF00016417.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Tue, 12 Nov 2024 05:13:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 05:13:02 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Nov
 2024 23:12:18 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Nov
 2024 23:12:06 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Nov 2024 23:12:04 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v11 5/7] usb: onboard-hub: Bail out if peer hub is already
 probed
Date: Tue, 12 Nov 2024 10:37:38 +0530
Message-ID: <20241112050740.15343-6-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241112050740.15343-1-venkatesh.abbarapu@amd.com>
References: <20241112050740.15343-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|CH2PR12MB4199:EE_
X-MS-Office365-Filtering-Correlation-Id: 032c73f6-007b-4641-3fac-08dd02d8aeea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bKgi6DgA8dw9pjzlfpvo1FL3u1Ox9DpR/dqpRE5cPv3jn9MCyndssiVAnYbM?=
 =?us-ascii?Q?TJQ5Kidr6Q/QOM1w+jYRl8tM46NQKZ6qLB/jLxkEAOJWzY8gPV3mQQlYKIBh?=
 =?us-ascii?Q?cD9DjvbPnJJyFEKBpGaKJ4NovbNKJ3Fojc950eFfosYTcOCx2faJ8iDf7ldw?=
 =?us-ascii?Q?U/dVKzSGL6EAu/B3jBLC5lgmQMr68zSxzPS/0mtcE5BtUpEF7/VyRk/Jck1d?=
 =?us-ascii?Q?Mx5MH5j2jD/Z6OG0jjpFLdoKgbyAhFG45VwABohH47XyGqKB2jLE5diZYp+8?=
 =?us-ascii?Q?EvljYykQY+aD1qrRTmjtYCop7pQXhqZvAbbi1jDL3tbhecsL9kk+T69ybC0J?=
 =?us-ascii?Q?uBEx2bqnx1T5GaL3Ps0WiV/WAAM4n2OEBzFJVVbH7VrrMt6v+67KQmQ4Szbs?=
 =?us-ascii?Q?kQD5Wd3FfM/02LdyHeNLKgHGbuQjvZjoqg3SqerGmC3sVqTRxmC6a/E5g2TO?=
 =?us-ascii?Q?yTIFIGo+s0ENTpPVUzP4rgJTDPF5zOZ8giGO5DfR0BwD86TCDnEndOyq0epa?=
 =?us-ascii?Q?7TlDeRyZoHIh77u5juEC59C8eU8XPGsMtexHohboJBYReHdd7QCAfdqjpLMh?=
 =?us-ascii?Q?jaOQvB8HqHrAr7Yty3uJf5f5G0gdd9dNbN0RW6hDDEJGncTGc6ji5sAVUeig?=
 =?us-ascii?Q?0ekGlLyozBOcslyUIUlgszteVDfadDox04S/SNuC7bsgBV47nUchBNhbsjx5?=
 =?us-ascii?Q?ZIbWGpwfI9SaFw/csgd9umYJJW7MDNVigj68UHrype5Gcc3kWYPsuELFMv2/?=
 =?us-ascii?Q?IIg9iDkOdDcUR2cFcURUDaEXvYZTGXn27Z8NN5IkYfo6Iu8R94euzYm1izgS?=
 =?us-ascii?Q?BIhsIiOekJp7J5SDO+qYduAhDa1a2vG3Z1TUbELtsWRQOEmiIM/R31iQa7Fj?=
 =?us-ascii?Q?rP9auSUUgd2t+9Rvv5N8/4hbcTQztQUd6lBMaNfRPdU66vUuZVGSCRTn3tmo?=
 =?us-ascii?Q?ZI0i/9cUz0GrTdCFCpZgYceAzQaEstAX0rRhznDeNh6t/+N2s8ePuAVIyKNd?=
 =?us-ascii?Q?yVaQibrQ25sNEzkIfTse+3d5URtFvR/cKHma2WD/RuLnNZ/GCrw+xqcnrvNp?=
 =?us-ascii?Q?KrST+NrkdiOLnGaGreb1n32ZbLqNpR68tHXrD2CPbM6iv6FxOhIwRL9+IFnk?=
 =?us-ascii?Q?zwXzcUoDYpngsemGrSrAeiAJIhkuk/j9zPYoO6s4448+YqSU9B3LJJLrPHiF?=
 =?us-ascii?Q?oqxep79Y7Nfg1+iD32nMycKjFJ0Ks87DmEf4Kiq1f9q+vSWfgl6rY8oIbsFH?=
 =?us-ascii?Q?FNu1B4ayrA6xSRi1c8jspS7oPIxl7rTXbskIZmFqaKb6I+0a0BYUoGN3Hu7n?=
 =?us-ascii?Q?5JnxIYvgpDB1jqlZed5o6qmmmN0V+hbL+jo4R4LT/srMOhcXm7AaAX/nf/8k?=
 =?us-ascii?Q?HR0wamUXAZbS0XoNURLBg06z7+P5SLr+/aKxhxQdRDOiXpq6OA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 05:13:02.6476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 032c73f6-007b-4641-3fac-08dd02d8aeea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4199
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

The .bind function is implemented to bind the correct
"half" of the hub that the driver wants to bind,
and returning -ENODEV for the other "half".

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 common/usb_onboard_hub.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index e209964f17..3c5f88387f 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -176,6 +176,26 @@ err:
 	return ret;
 }
 
+static int usb_onboard_hub_bind(struct udevice *dev)
+{
+	struct ofnode_phandle_args phandle;
+	const void *fdt = gd->fdt_blob;
+	int ret, off;
+
+	ret = dev_read_phandle_with_args(dev, "peer-hub", NULL, 0, 0, &phandle);
+	if (ret)  {
+		dev_err(dev, "peer-hub not specified\n");
+		return ret;
+	}
+
+	off = ofnode_to_offset(phandle.node);
+	ret = fdt_node_check_compatible(fdt, off, "usb424,5744");
+	if (!ret)
+		return 0;
+
+	return -ENODEV;
+}
+
 static int usb_onboard_hub_remove(struct udevice *dev)
 {
 	struct onboard_hub *hub = dev_get_priv(dev);
@@ -217,6 +237,7 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
 U_BOOT_DRIVER(usb_onboard_hub) = {
 	.name	= "usb_onboard_hub",
 	.id	= UCLASS_USB_HUB,
+	.bind   = usb_onboard_hub_bind,
 	.probe = usb_onboard_hub_probe,
 	.remove = usb_onboard_hub_remove,
 	.of_match = usb_onboard_hub_ids,
-- 
2.17.1

