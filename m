Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B8CD3EE9D
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 17:23:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A0FC8397D;
	Thu, 22 Jan 2026 18:23:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QzHeL/TZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EC5583AB0; Thu, 22 Jan 2026 18:23:03 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9C2A80077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 18:22:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6OTsXklXlo2ZaEW0jUFsocTx/UpOIHAw5qf8Qk2eN/CVb6QZBoyvhyiy33mExzrTcVJJ/p2PEpE6O/U7q4eWgFweKbr17lScVXNz6U/5n9PMkTwrUWbVmT+gBjRigIS/sIsnpVsDk4nOD5TX9j6aQ083EpEl3gtvQJOvIBBmHFXLy3qB1h4be9rev5J/ls2dQXVXEHDr9TNiKmnqHRIwpRyJUeV6YmEMCY+3DrJr6vgi+K0h2+UT50ahrCvkTOKdpD8yedgQQXzhU5VrqEy0hQwpq+UGUjIJWJdr2H+KDyB8BdeTBXbr5eA0WIrJ2vHoZnfZqVdnUvBKpKiJBqdIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NluNfCYVmMHv1vM5OOh6dM//0rsiLbU3gFs4bXu3UlQ=;
 b=oKJIxWtjHvzsMchutd4tHWEDoWmxvNdrQndumgME3wWdG4nxmpG7ds2aLIvble5BjfG03ohxJvzx1WthfwE+Xw0LWwOBpf0qrZmQZlUBDBER26WlwiKwNXtz1wC6XYmoYt57F6hxHR46Yot8VaydabhIPwD57iviLI0yY4VAkS+2xmzrlNgz2KNfMcSnTFYritVl7h++1wDVv/LqQKYNrjNrQVVVuuLPhTo9yErdVXhWJgtUJzHg/gpI0prD1AKadNbpNkwPHX+KG5rKMsUAZtmq30WhutZhy8N3+aWMY3NRTVRpvfxpYRsEkYblQ9xl9Wg7pUB7ThNfPqKICuSbYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NluNfCYVmMHv1vM5OOh6dM//0rsiLbU3gFs4bXu3UlQ=;
 b=QzHeL/TZnGaiysz7tUhcSqgTvqbWGK0jKonw588Z4Y+AASzrg7e/x0h79Z92/VlSkYZsoOrAC1tVM8rnWBqXd8pPuiWcbaMYT+1ATSvBtSHBYYkovh0vrLwRcvuTQCjOI/UDtE9oukY13ixeHzA2qGnmvCug8QVCbnzyho740FQ=
Received: from BN0PR03CA0052.namprd03.prod.outlook.com (2603:10b6:408:e7::27)
 by LV3PR10MB7724.namprd10.prod.outlook.com (2603:10b6:408:1b4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 17:22:55 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::47) by BN0PR03CA0052.outlook.office365.com
 (2603:10b6:408:e7::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Thu,
 22 Jan 2026 17:22:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 17:22:54 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 11:22:53 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 11:22:53 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 22 Jan 2026 11:22:53 -0600
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60MHMmHs915711;
 Thu, 22 Jan 2026 11:22:49 -0600
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <ilias.apalodimas@linaro.org>, <malysagreg@gmail.com>,
 <sughosh.ganu@linaro.org>, <philip.molloy@analog.com>,
 <marek.vasut+renesas@mailbox.org>, <james.hilliard1@gmail.com>,
 <anshuld@ti.com>, <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <bb@ti.com>, <praneeth@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3] mkimage: Default to 8-byte alignment for DTBs added via -b
 argument
Date: Thu, 22 Jan 2026 22:52:47 +0530
Message-ID: <20260122172247.2995437-1-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|LV3PR10MB7724:EE_
X-MS-Office365-Filtering-Correlation-Id: 59f0bc3d-dbaa-4dc6-8792-08de59dae0d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3U6XYx98k5zZPSXBKAg+nQCI4U0Aav+MARbFb9uzbD7+uBOCiO2AdpUPuNtS?=
 =?us-ascii?Q?6zwbO+S/8wfKSYGD2hje+V4JUoHxjjNwXeIV49CBf/wNb59ARhie1aVn7Fvo?=
 =?us-ascii?Q?bHdLLCMwjHySh3qZgMyiQYUbVCIiAhoucOtsAOIvDD6pykfdLaEOm2fw+E0r?=
 =?us-ascii?Q?HyfhGmarpdo/xGZF2TZ9MJS59A3DeqlJD6AvnPoFdapvT77DNREMPf/5bYy5?=
 =?us-ascii?Q?OP5sRkdncYEGZ8tE9wocb5dsM8dakv7DWMjoHGDLgZRQoOgyxig7ju5/gz3C?=
 =?us-ascii?Q?kvwdGI52vYP7NL/enfpN3yD1LJ3fUxLXGOk1Ab16YpxnXOZ1uW7an2rvthv4?=
 =?us-ascii?Q?bi82c3S//8pn5pREDlNn04ijKCe822xtFkWUrWPsXoioo9mEbNFybmwwfuj0?=
 =?us-ascii?Q?7C+3Aks39saKcVkZfbkAYxIA+2/UvhjCBP5yBR2Nu+UZtHTg6QwtamFFCTl+?=
 =?us-ascii?Q?dNXlPKEvyUMnPhs8H4AWevQMX19s2YichzfJxm6zE7K1PbjsgCZFf6E3egmY?=
 =?us-ascii?Q?A0XBrKB/JraK7Sikv/SPinFIJlus+lrYgDXXmVscmC+METHHGErtZsw8Mfpy?=
 =?us-ascii?Q?BszESQCuZF3H467ANfcvPVj9toGK+II5DF+IkKyjW2lX7KlM1fxapJd4S6Kf?=
 =?us-ascii?Q?I5yG37Gp5hlQ8+I0BPI3/kHlFA0a5xcXcuuOzgABHT7xPRefpqni4WMMAwrD?=
 =?us-ascii?Q?zA8o3sOwsAv3g0LjE93yOgG3H6Yq+BrRSwWCNWwENjU8iBzdN9CPka/DwUpG?=
 =?us-ascii?Q?g9cU2FrpnSBreaEC4HOGJgtGP2ya6p+vtP9qZZc+fiQ+UT5AsEPmyReT6bu+?=
 =?us-ascii?Q?imTeXFw2n2FEbNZfxvSC7busDUDxq7dtlHVL85MwbQy7TTdtaapqUUvDzD/W?=
 =?us-ascii?Q?oCb2GNO1zZbNO4q5BQyYcL7z+HwSQ6/9bT5XhHuDFGC1wHxZwTgekZvfRVWb?=
 =?us-ascii?Q?OZlF8mtstJPec2JevyAxpA9F1PNNQVElSVKxq/3r2fLWqIn+Xd9INWqxCXC6?=
 =?us-ascii?Q?B1Gzt4Y+MKlo1eAW7HB8lu/GjVMAhVeqCvNIyUlGg+8i/cfbON4yaT9XMbE/?=
 =?us-ascii?Q?w0GCRuHfwPRWm2IdfcXzWhaCXkAbJD49UdiqchMNjDV/6J4I6ux3omcwH5rG?=
 =?us-ascii?Q?RjbZjtBv2uZgh6PusSCQDV6xUQWKDIsYHEdhMQi6Z6pTsLs9+asvRx6Mz16z?=
 =?us-ascii?Q?lbWmttZkuMkeYBb/uUv1j0cuI/atlv9j0oDxv57Cf0JurafQ7Ft/bIh8Lo0W?=
 =?us-ascii?Q?bXQlkJWuQTzW+nOT+7938RFYsphoqHKI0b/3UtfwZw68uStk03vSRcwmPeUi?=
 =?us-ascii?Q?2Y2c7FpAr4Y9mgsgqE276l2XEDSl4KHaohBqQR9lfl8ylSSdq+uGQV8EBe3i?=
 =?us-ascii?Q?m93lQkp5cwQhTvHhnW1UXLTaJ+FwlZ2uA1XFqVBTfAKzH3enKMlFf0qMqJH6?=
 =?us-ascii?Q?Dp/qBotT3cxmh/5fKFDU+GPTewe60N4+Jl41BoJPyK2tkIsj3CdqWanDh4j7?=
 =?us-ascii?Q?4D0oOByJGW422Zy6o32T/zoQlCAdDjkmpogBO333VhgafB5czA61U/6H9ASL?=
 =?us-ascii?Q?gghjymjr027dVgZpdHMx9AgDXiKHIqZkHodLnJeRZ284ZmUYDnaAr+loAYOT?=
 =?us-ascii?Q?NT0spgpSTZv+UaEKAaFPzvV+zsOX9Ak2Ow+aPWWbVKEHC3+gnih5aNJn8Q3y?=
 =?us-ascii?Q?aRVktTh6MgVL9nEYyGdxTHq5nGs=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 17:22:54.2016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f0bc3d-dbaa-4dc6-8792-08de59dae0d9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7724
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

When CONFIG_SPL_MULTI_DTB_FIT is enabled, multiple device trees are
packed inside the multidtb.fit FIT image. While the individual DTBs
and the FIT image start address are 8-byte aligned, the DTBs embedded
within the FIT image are not guaranteed to maintain 8-byte alignment.

This misalignment causes -FDT_ERR_ALIGNMENT failure in
setup_multi_dtb_fit() when locating the next available DTB within the
FIT blob and setting gd->fdt_blob, because of the recent libfdt
hardening since commit 0535e46d55d7 ("scripts/dtc: Update to upstream
version v1.7.2-35-g52f07dcca47c")

The mkimage tool already supports enforcing this alignment via the -B
option, but users would have to specify it explicitly. This change
makes 8-byte alignment the default when using -b.

Reported-by: Anshul Dalal <anshuld@ti.com>
Closes: https://lore.kernel.org/u-boot/DFJ950O0QM0D.380U0N16ZO19E@ti.com
Fixes: 0535e46d55d7 ("scripts/dtc: Update to upstream version v1.7.2-35-g52f07dcca47c")
Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
Testing Done:
1. Boot tested on all TI K3 platforms.

v3: Changelog:
1. Default to 8-byte alignment for DTBs in mkimage instead of
   passing -B 0x8 in build command [Marek]
2. Remove previous R/Bs.

Link to v2:
https://lore.kernel.org/all/20260112101102.1417970-2-b-padhi@ti.com/

v2: Changelog:
1. Carry R/B, Reported-by, Closes and Fixes tag.

Link to v1:
https://lore.kernel.org/all/20260109190026.58464-2-b-padhi@ti.com/

 tools/mkimage.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/mkimage.c b/tools/mkimage.c
index 3c43962807d..9ccda2e18e2 100644
--- a/tools/mkimage.c
+++ b/tools/mkimage.c
@@ -240,6 +240,8 @@ static void process_args(int argc, char **argv)
 					params.cmdname, optarg);
 				exit(EXIT_FAILURE);
 			}
+			/* Default to 8-byte alignment for DTBs as per spec */
+			params.bl_len = 0x8;
 			break;
 		case 'B':
 			params.bl_len = strtoull(optarg, &ptr, 16);
-- 
2.34.1

