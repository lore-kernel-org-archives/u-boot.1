Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341BCF30931
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 10:36:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FCFE83F9D;
	Thu,  5 Mar 2026 11:36:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dQ9mrwdf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B9AD83FA4; Thu,  5 Mar 2026 11:36:42 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4512C83F2D
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 11:36:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkmf1hSnflG3gDe1jNRYrCEg1xDne6Rl5sAA48ow4Ovn0vV7n+TCuPyfUa/2EZg39D1VBblyxpG8uHQbY6tQ89oZdoZRVWCjBLLGUIYx3F9HJRQRMnji7zGwr2uD1vIIy2qo4bDOVZn7WsirT7NsTmvZXc77u9BPGOLDCpCjSAwTzruoVXM4+TwdsSI+glrwR6TY+b4NYgqJnhRwtV63FmfldXQ3MecIob9ltReXnMhzgki20zT3rmewV3uspJOfFLT71MFnN/yI/RxzApquv4M0tDqIDNt5bOR+Fsjchx0S4twczkojRGScGdXjvaLLgzAuNvGzv/4Jjzh7TE2NQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Lx8KbCxDJVn9e4NuMQ4iHl1F1xEecPraPB5TqnkpZs=;
 b=jJ8kgqm7GG9wHFL2OVTgaJuvKsJiyTwqhqwAdV1a0117E5qAPhrX9JfqNax7CDaCq19CEn/TBwY7RQavgRSVVa4Gu43mpglqzoSs9edIeitn9yRX6AAB9TI9wgIQW6o8pFSQ8NuxndEANVzHpdfhihU5b5i7OhLYFXKkORDZzhjDp1QLHgHcpuxgvL4NIqTQheqk8Ewlz3dXKA4SgjBtLQYLRQ7AA95cxFAylwmXE1FzPkZ3jgSYJNhrQMBbV4DlOL6VEqwyDosBj84V9TenMb2WUq+yhlSMqM2pkuGuOeHaVzfTzReUVyg2uez2jWMgkME4u1Fx3Wk5YDXV7rzDqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Lx8KbCxDJVn9e4NuMQ4iHl1F1xEecPraPB5TqnkpZs=;
 b=dQ9mrwdfC3Wyv02qmoP5v+wE5Qn8YNfV2o2MgLVMYSKG0C1c22BQZHizj9dWJtc6llczVxkwGsvCASgXtupsSXjgnIVLutwzQVdAxNvegZc+XuMO/GxoK9iL2HNQdev9FicAnedF4/nrnRy0hWTGkvv7I7L0FHFFhmmbvpTjc/M=
Received: from PH8P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::24)
 by CO1PR10MB4804.namprd10.prod.outlook.com (2603:10b6:303:90::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 10:36:36 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:345:cafe::c6) by PH8P220CA0004.outlook.office365.com
 (2603:10b6:510:345::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Thu,
 5 Mar 2026 10:36:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 10:36:34 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 04:36:28 -0600
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 04:36:27 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Mar 2026 04:36:27 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 625AaPm42192509;
 Thu, 5 Mar 2026 04:36:26 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <lukma@denx.de>, <mkorpershoek@kernel.org>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] common: spl: spl_dfu.c: Fix warning associated with PCI
 subclass_code
Date: Thu, 5 Mar 2026 16:08:14 +0530
Message-ID: <20260305103815.999886-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|CO1PR10MB4804:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb00e1a-fc34-49b2-441b-08de7aa3129d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|34020700016|36860700016|1800799024; 
X-Microsoft-Antispam-Message-Info: DSfDoDU1cIIcdKwkrduGuurDPuDTU00DAGXOp60WbTIv7Q4x9p+c02sHWtqlnpDFoNSpCTHkKdT7p++eG8LvM/fTXmGU0LWuRGEz2CMzvWzs0qrV536yA3Xs/RtKrhnua0FTg008LtrMx1qV3QyM6coAM8k3YZVaojM1wCzsCFIvsm9+rAiSbRP9RCq0GK3M9gNxp4eGg228g8YXpy5yLLH4jMuqknOD+C0qdAJ5HElg1wPx1o1EBJDu5rbrK+k0ptRaix5Yy8LKPRsjvKzKQlQBngkSX79fZtZ80XfMeH14BsWyueE38KeSEXj2Io84hq2PTcjURq2otrhC1fdJR5mmCnsr6puULLS8l0ZVls4tzUdJNi9jixQVtaw8gM/IxLEnuVOb40fguWEzdadrGJ+rrbyX9PkD+lShShAe9apmLVZz34KNGfG5udzOf9QeBdVZ5cks2JNro9PhpYid/rZ6otgCdTCjhYvmq4QYFn0dyFe3MdG1WEpRo08UMR7ZljyAk82Nl0hM2yl3WVWgwifjHZwiCVSVKmL1eWuc29oLM6sEOuFhWAEtehMP9Ohyr9Ox9xE9R+spUiH+boUQ0S3YfZC+bMcYpf39xDKN6rBu6wEc1tI7k5hjNyEEz00dd3XDaBZs0laxBQNe8jA1VAXN9QL3XsHs+JehuR42pFwNo562PojbP5Vvr5ZiUAXAg3TjSxlTvh9msGi7QMm70o9EQ9Vx2pJqIZEVZg+5tHz4zY59JyjHI+oMqwkpPiS+8G6u0p8F2rH5W5f97QjLSQ==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(34020700016)(36860700016)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gsugW0k+VLyLFfjNKwjSOwL7OBdAcWTZgC6qCfLC1OM32uUHybJcIp8iaE1Z9JZtdU4KDcXpq1O7+fA/cgZphfwQJQpyrxYXIiokrbd73JYf13SEcSKixNp86HRgQRYm4Liitf3cIRLRcJENjEM0Cb4vp6PJ/pzYXd4Q/TWMPCA7BQMtr1b0dtJts7xmbRoURx4C6GhbvK6TP18MHQEKD9l3HN0xxW5PbOpsI6ZHKiqBJ3fGxM4CSuLsM3AXass89yfML7yJ+9HByBj+qFkWMn6YnT3qAWSZRuWpIuQ96FvumyHuvop//58TJz+4uQbulVmntY1paCx6xnQ6EybfLpmYpiEQXwjnVh0ubdhTni5IgHFe34Y8/EooAr9HbAEfmVsnpk9mBjlx3xFlssoSqZiR5DqJ3Dik+9OXIi6KXmfDyGWSF+M4AIscyS+t664r
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 10:36:34.3067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb00e1a-fc34-49b2-441b-08de7aa3129d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4804
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

The subclass_code member of the pci_ep_header structure is a 1-byte
field. The macro PCI_CLASS_MEMORY_RAM is a concetation of baseclass_code
and subclass_code as follows:
	PCI_BASE_CLASS_MEMORY: 0x05
	Subclass Code for RAM: 0x00
	PCI_CLASS_MEMORY_RAM:  0x0500
Hence, instead of extracting it via an implicity type conversion from int
to u8 which throws a warning, explicitly mask the bits to extract the
subclass_code.

Fixes: cde77583cf0b ("spl: Add support for Device Firmware Upgrade (DFU) over PCIe")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
f473a453b0c kbuild: Drop phandle from diff between base DT and U-Boot augmented DT if DEVICE_TREE_DEBUG=1of the master branch of U-Boot.

Regards,
Siddharth.

 common/spl/spl_dfu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl_dfu.c b/common/spl/spl_dfu.c
index b09f82790c9..7d21bb4d16a 100644
--- a/common/spl/spl_dfu.c
+++ b/common/spl/spl_dfu.c
@@ -64,7 +64,7 @@ static int dfu_over_pcie(void)
 	hdr.deviceid = CONFIG_SPL_PCI_DFU_DEVICE_ID;
 	hdr.vendorid = CONFIG_SPL_PCI_DFU_VENDOR_ID;
 	hdr.baseclass_code = PCI_BASE_CLASS_MEMORY;
-	hdr.subclass_code = PCI_CLASS_MEMORY_RAM;
+	hdr.subclass_code = PCI_CLASS_MEMORY_RAM & 0xff;
 
 	ret = pci_ep_write_header(dev, fn, &hdr);
 	if (ret) {
-- 
2.51.1

