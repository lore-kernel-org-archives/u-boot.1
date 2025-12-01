Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC97D111A8
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 11:03:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D6AE83BC8;
	Mon,  1 Dec 2025 12:02:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="emik8QzD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B88183BDD; Mon,  1 Dec 2025 12:02:03 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FE1983B9B
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 12:01:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjUkhJAECDGNy8j2nSyYbPG/f7tHLcDVa4IihnuESTwIazeWh1OpmrrxphKGIz87LhwIci21kUDq91PI7jB9RsZIkgAiYSbAzn7q0IZhJZfCJj1pyrCcUvV1ZfVoJ9Nd2L1p6lCa1cmBx2VfItSgKDwNzagO33uFmUnUiZpmUiSNoGHzuksQOkzdT09y38BI7a7RHZryPoNE4qVPOzFEX7wuAqZjVMDyKigzkXoHdJxr0Q9M4zerhGgt6INzdzbQUKe1OvLWo0iHtoqZXwZNn/JMAkTvVKwNHQwaCOzcaIpbfwHY209SJ9uMEvsUhfDCsnnplk4ufycLYijx41GMbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vQr7E9I+15qnxxkGDOaja6Atl1ab9XLmYIvcIqMsw0=;
 b=YWznuBXRnI+hJyRvm5DjBIJsdecQE79/rnUC2N/5kXfYnnViqBxHONsBBQaIN2Q/9k9PVQnx8naLN6hgurtdAqrLTocFLE9X8dclcvuPki878ezc6YzSHD5cNJjxvewX4M7RB66vN1c+8IimYkS/q07l+k60FbV0iGuKFLlGCegsjBqGntG4SF2wTVH2mvyRGH39hTC5Q7IZehVUXHUi/pFE65fr6Gcdw0VhhkHqRcKaQ6cYPuBY18uHwQYMr/aJGg28HVdS2mSRYufdzlKEZQie3mE5HqqxBzHL4abQ/irMZk5fOaqy4J4r/2CNH8ETeaxgTbf9AcYrmXVuBfyOCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vQr7E9I+15qnxxkGDOaja6Atl1ab9XLmYIvcIqMsw0=;
 b=emik8QzDhYOTcy/M0ZbShZWvy8DDfTD/XluQSCp7dpPt5bVfedyrj0i3I3nFp9oGZ/JJkDcWLrvZ0okdnR19tXkzjfk+xXRopjnHy4wxQsLJrSt2fQsDXSVmnehTVf4JHH9pnJWUHd67iU6tIN7frV7qgntFqJCGpC2R1IWvw1o=
Received: from CH2PR17CA0011.namprd17.prod.outlook.com (2603:10b6:610:53::21)
 by SA2PR10MB4761.namprd10.prod.outlook.com (2603:10b6:806:112::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 11:01:53 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::e9) by CH2PR17CA0011.outlook.office365.com
 (2603:10b6:610:53::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 11:01:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 11:01:52 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 05:01:51 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 05:01:50 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Dec 2025 05:01:50 -0600
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B1B14qg306512;
 Mon, 1 Dec 2025 05:01:46 -0600
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <a-nandan@ti.com>, <m-chawdhry@ti.com>,
 <c-vankar@ti.com>, <u-kumar1@ti.com>, <j-keerthy@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>, <jm@ti.com>,
 <anshuld@ti.com>, <s-vadapalli@ti.com>, <ahalaney@redhat.com>,
 <semen.protsenko@linaro.org>, <mkorpershoek@kernel.org>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH v4 09/10] configs: j742s2_evm_a72_defconfig: Disable PCIe boot
 configs
Date: Mon, 1 Dec 2025 16:31:02 +0530
Message-ID: <20251201110103.845413-10-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251201110103.845413-1-h-salunke@ti.com>
References: <20251201110103.845413-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|SA2PR10MB4761:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e8d9453-7f3f-4ff5-dfbe-08de30c908e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Vjch4pyuXhG8uTGVgWDL+F8prDGye9w4N0mTgnEmJjqI3ClU3QFAlEaX9cBq?=
 =?us-ascii?Q?4PkzRMtIocpiut6D5iPI1hX7bYEX9sW+6nQvFhzJD8sdD7jtD/nb5Y+OsRW6?=
 =?us-ascii?Q?3W8glHcKcB4+91ne7/fRRl/RY38jEbLZrqua4bfi54XQYDF0qq1vV6mjIQ4x?=
 =?us-ascii?Q?VTBknlW/H7GEk/ibxkGrWJMQbJ0okjJkEVhiHXgvffEnYC9EMFUxEAFrjrYd?=
 =?us-ascii?Q?DAGGG5TGikdT9UCQj65aEJ2bS8/t+EMgoXf+fNp15UrNkVCf2CXHNRCW1Dw/?=
 =?us-ascii?Q?ZJL3h2TeYMJCf8+UkDaz3PtEouJ4/2nahVFiunhICs8JyvhU+8Y+LUohPUSy?=
 =?us-ascii?Q?YFo0A+ALaMrZOLU/MlwjF2X9RpPGKpWYs5lZNfKNldZhyVrKZUvcda5EyKBY?=
 =?us-ascii?Q?xaoWgJvaGiX58dRdxAfGHG1sRf4XzOCChLqtrXlQAL4f3VQ/NXB4z/eyyCP9?=
 =?us-ascii?Q?rYO8iHrdUfbWajh+ncidFrUSp1aD9YB7lXC7CtF7qvXC5V9GstwzrefmI0Nb?=
 =?us-ascii?Q?qDRKS1h2TMbIewWP84CMZajFKLqFknpv0paDSmdOhIT1X0rIsm660DyIEf/C?=
 =?us-ascii?Q?ME4k5SgeEVLIGINU85scrdgaaiuGh2TVSLBODrq71Hp7KqXNEk+rBDVbUzTY?=
 =?us-ascii?Q?8NMWFmb0q3ARQjSmp9u88BfvAktc55Swo88UIXv1vq9zlosJTvJk+yT7zhTH?=
 =?us-ascii?Q?+CmtY1l502FfJlJDlXfis3nlJL+uTopCvMxbFQwwwd0/x30RtaypQFHe8vVV?=
 =?us-ascii?Q?HL8SeLfTK4pSqaOQPiNse+XdmGgtr6j9M/H99ba8CGo47TBhTCzDFHpJpPYR?=
 =?us-ascii?Q?bNsxFcmsvEfuCx4uvFMTFEiK4CWOnnFQD8OR4OYSE2auPw2IOQJVJEaRJIUo?=
 =?us-ascii?Q?zBmRFf1cNPddmLaU4AIlnuwRvTmGAhdloe3gLjYLOs8Lb6uZ5/LhGDNQRYyF?=
 =?us-ascii?Q?jL0eWj85z4gHDom9H3MY7vVDYo9zcgHkVJp86ggFeXnG+hipnMcpztfjP7rK?=
 =?us-ascii?Q?ZtsTeHRsXYPzhYR9+miBFxCjho6n0vp2j5qi2/jdqp+MiogYKbzguBJ/FXC+?=
 =?us-ascii?Q?iMOwY5CCquCSROcFD0WWiCXe9j7+Af/SK8eZLNSa+6o0L6z8JMW7RuQZHnTU?=
 =?us-ascii?Q?IjcYpJC359bcOWxyi+DQ4chkbOAux93go3fZIlzFwT7oo3xZEMnCs6Ib29Ct?=
 =?us-ascii?Q?k5fKJQyVZfMi9+iA9al+9M7CRuIFZywIOvrZc0C1LlEWPo5BXgSpkpgtoqBI?=
 =?us-ascii?Q?jfuRzEDlibEWJo66iYlsAF0J801NTvarWZ9ata/+VorKNNFOTBVPz0BiwQTi?=
 =?us-ascii?Q?kwoIYHNlPNdBkmDlAj7nmgicX/S5NYimTnJh3qNu0spSnNEH5jRLwNKU4l9h?=
 =?us-ascii?Q?R+zn8ZySO8YNzADElKfhH4CiuSEqfNDYPnZmVdmLTOjWBHc9vZqQ0xDsMfuI?=
 =?us-ascii?Q?GyFak+KRIsuqX5ZxfmHgQaiaUR8y+iCjKqMfscFSaxvjOev/kbP9wUAQP8Us?=
 =?us-ascii?Q?RcNzeN40kt6B/Lx3JMrGc7+V0X/IOVmySoYrGxYVNk+xHv7FmfX0ONBgwxMX?=
 =?us-ascii?Q?0bLnBiBVhTqfYkoTYRljY6cyaS/NaZ4G5b1qT1dl?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(921020);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 11:01:52.8321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8d9453-7f3f-4ff5-dfbe-08de30c908e8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4761
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

J742S2 EVM supports PCIe boot but it is not enabled yet. Disable PCI
boot related configurations that are not applicable.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 configs/j742s2_evm_a72_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/j742s2_evm_a72_defconfig b/configs/j742s2_evm_a72_defconfig
index e534ce4c2e3..3786fa5b542 100644
--- a/configs/j742s2_evm_a72_defconfig
+++ b/configs/j742s2_evm_a72_defconfig
@@ -5,5 +5,10 @@ CONFIG_ARCH_K3=y
 CONFIG_SOC_K3_J784S4=y
 CONFIG_TARGET_J742S2_A72_EVM=y
 
+CONFIG_PCI_ENDPOINT=n
+CONFIG_PCIE_CDNS_TI_EP=n
+CONFIG_SPL_PCI_ENDPOINT=n
+CONFIG_SPL_PCI_DFU=n
+
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-j742s2-evm"
 CONFIG_SPL_OF_LIST="ti/k3-j742s2-evm"
-- 
2.34.1

