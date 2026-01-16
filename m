Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD60D47CD0
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 10:30:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD40E83623;
	Fri, 16 Jan 2026 11:30:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LJXRaTdU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C768B830E4; Fri, 16 Jan 2026 11:30:39 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CB18830E4
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 11:30:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXLX+AeODxIPGrd0UxqADg3sHZPtOQirE42e/TDZ9+9Z9D5tKkJSEples7XFjKDJVARkCj51RJlxoh9+Mbyx6N3T5dDyeyNgJkeRO2lDv/Y2MVtuPsvHIiJ1qm86XSH+AbpmvDU0LtRfgiFFrUrhB/VRpzjJQAr5/4y24YJBjlRDPcX136j6ndKAKz7pF7RBnW6KT+KblAAiSRiZwbBETsXwJ7SsONQ8evvA9aUdKllCnEO7m0sqrFpkbk7fBB8+AAYpcTf8UbtKj/Dm3JUHZZOtjAqPh+OZ+eje2VBXlmXc87AB9t4djg/WdrfT1CIx2l8WDCxngrsRTGgxHC8V7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sjR+eSglwMKjRY0zwMLhD3OU9PcrppEBuH6qFZae1Y=;
 b=vaOnJfooCb/vBJzt3yCdmZPXBLahKwyDvPeBVbJtSbvdX02QQPfDP3NHdtqx7e3sskQnC9tRID1XV1FrGhmTj3zy2rwCY1KE22RdnG4LyA6HLEljX1BhRC18IAuEOuAmAm+dSYkAD092KNuuqpuq/kMivtQM9IK1mLe7gH4ndGM6XiIKwYOZ7s/3ToJybwU3AuqyP768+Sv46hkA78wOcQvEY5pcqRJhZUgljbC/9tlrJgQC2MfBiugudj82eAHvJSJD9fEK9ZV28nziat49YxYO11dKAoijgYloTVzO13VFCROoDZ/5JGrv1mIoPTukOzmmVqAh4Tj5kL+NGMWM5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sjR+eSglwMKjRY0zwMLhD3OU9PcrppEBuH6qFZae1Y=;
 b=LJXRaTdUIYhQYsZbWuLb50dzN0QxKmyQqnEyRH4uAOatEzAc3Qgf1/WIqA/ikDU0WlQQaI6WnVFhXN6a47yspN9eOOSYIdo8q47GMSsKYrxplLsQGeAGbE5i0ClVKzCRojzL4egmLOGFCDdAaG3fzheD/IWynS5TsbxSYP+TNlU=
Received: from CH0P221CA0033.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::16)
 by IA0PR10MB6772.namprd10.prod.outlook.com (2603:10b6:208:43b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 10:30:35 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::34) by CH0P221CA0033.outlook.office365.com
 (2603:10b6:610:11d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.7 via Frontend Transport; Fri,
 16 Jan 2026 10:30:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 10:30:34 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 04:30:33 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 04:30:32 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 16 Jan 2026 04:30:32 -0600
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60GAUVXc3004223;
 Fri, 16 Jan 2026 04:30:32 -0600
From: Paresh Bhagat <p-bhagat@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, <khasim@ti.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <t-pratham@ti.com>, <nm@ti.com>,
 <v-singh1@ti.com>
Subject: [PATCH 1/3] arm: dts: k3-am62d-evm-binman: Fix device tree reference
Date: Fri, 16 Jan 2026 16:00:08 +0530
Message-ID: <20260116103010.3947922-2-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260116103010.3947922-1-p-bhagat@ti.com>
References: <20260116103010.3947922-1-p-bhagat@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|IA0PR10MB6772:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ca49106-045a-4f05-d231-08de54ea4840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013|34020700016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TaBOxu+OGy1pFs16Z66LKsn8mMLxLxfH8+a7zljmFiBQRSi4xSumlmU3G29G?=
 =?us-ascii?Q?R7aj8OkigSUKkA66rvYYsS4tkjRhr7aXp053xQHbR1YoVLo4etTbWVsly3Qn?=
 =?us-ascii?Q?cFwhWaN1IAqDOfeEMYmYA1QE8RAKlUPrXM3zgaTm8RQdEYlhgVClJ9Osy92f?=
 =?us-ascii?Q?n1+bHKpIVyX6LO1o9zekzwj9LSqAuxKGSAHXeRyrgUPg92mooE3KZVaxQ66y?=
 =?us-ascii?Q?uSKPYHAcs9a22UE+dYTcGfXIK7ZiY/+SVsZKTQt3kaEr1vIL8nmudxHaIrCP?=
 =?us-ascii?Q?vuY5uIl5Szx84go0YDRjzSveqfAvU8gDuN62PssVllFUY2hRxayBvLpx7DaQ?=
 =?us-ascii?Q?tfyYYtS+OOrHA1FqkXdgbNFqlCnFmvJZYgc5m7TOpXM7qtB4X7zfP5K0/m7l?=
 =?us-ascii?Q?9Pgwqu7Le1WjyX806us/ci7TbEP4KvY85NbE/9dJYWyzqsXFewjdxhX3UbmT?=
 =?us-ascii?Q?2lNNwuNzPI5Lv14JcRGXaLbvUMVre3MQ4OSGbvm975f8aizwbeuKP+pClr6K?=
 =?us-ascii?Q?ef9ZQ5l98y6W2Gk7UEYsAXkZ7LwAkVDhdw32yNLi4umBPXaLTELrzay1AJff?=
 =?us-ascii?Q?vkOp7GcueeFGR+bz+3FJwZMtdDYfWQ1TzEGhOoEj+fIkEnP1dseZkGjjsuU5?=
 =?us-ascii?Q?W2pt/O1qPNlf95jp9qHsnjSZJSfGHzEMMjHrXzjE2OZDMncSVNm1UVVi04c8?=
 =?us-ascii?Q?poH2klU4wfW6to4g6wV/YsZJV0Ar1R6g8b+dK7BVTUDK9x0TvO0frTdOPcEL?=
 =?us-ascii?Q?1+Hm6DHOaLMROfDd9rxheK6KYy+W6g1h6i2VSCmhQksOMKqeV2XY2lGVCQTh?=
 =?us-ascii?Q?St27W3OPUJWMm4EfEWCbFVIpDSs+dkayfJUqB+mLD9XKyQfpTC2cqNCtEr89?=
 =?us-ascii?Q?sXkneIqjo3IpgvmsObi2rzTpaJQC8z04d/OhyUrQE3P+6GtNSstcgIsjOyD8?=
 =?us-ascii?Q?aemN/w46uMqjdjISOb1bzyDA8Fex7aCounH05l9zzyS2741kN/arG26uBf7K?=
 =?us-ascii?Q?0c7UO3gLrJ3IaV4yAhfCQMw/Ozu6uw2t8Lj9pFl0Zn6+wGFqMoxh3gTgHPdu?=
 =?us-ascii?Q?Cu7TaxppkdKmZtpBmbdqJeZ96bRRXy8d3Tjjif6uhNNWBfWx+DolWpf9pVHB?=
 =?us-ascii?Q?F9K7AOX4ZksQ6lsfSdclwiLu4sfgtzJPhyqVKPbP2LZWcflqPeGbvdLKvzdp?=
 =?us-ascii?Q?yHLS5s2V9q5D/hEEHCfleZxZ4pEDfxxOruMeqdmWNvslPeTTUe86PvVMb1L7?=
 =?us-ascii?Q?dBRw++8BzmWMcY9S3OV/dSvoiF4oQllQI2/qtQ0hEejV3/TubiEKhnNnBQwt?=
 =?us-ascii?Q?oiBb/8IDzX+nIWA81UhQbMde5DQvjGKp71uDlO8TA1s+3r17xIqNkIut3+AG?=
 =?us-ascii?Q?ZZg0vzLUqKv9rdDstXdt7418Inusdet7RuWCx7hmyZ9qkrK0likP4gb34i7g?=
 =?us-ascii?Q?kMQwonrYWo+g6ncuQmuDoxu/MrevKfkFf+kAfr8lv5K5igx0ocBuWnKob/qW?=
 =?us-ascii?Q?dU4GEL2Ca3xqsOswMCsfwy2m47DUSX+ufs2UYMyWs76XLvwgBCG5eSkl/4r0?=
 =?us-ascii?Q?nFUDB1UwW3NM0L+yxedpKKgMIL1mtkONHOv/n48bwvI/zTnshyTGQ9O4FQw9?=
 =?us-ascii?Q?Fg=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(34020700016);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 10:30:34.3525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca49106-045a-4f05-d231-08de54ea4840
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6772
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

Fix ti-secure content reference from spl_am62a7_sk_dtb to
spl_am62d2_evm_dtb or AM62d dtb. Also remove redundant k3-binman.dtsi
include.

Fixes: 14dfa6b86187 ("Add initial support for AM62D2-EVM")
Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
---
 arch/arm/dts/k3-am62d-evm-binman.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/dts/k3-am62d-evm-binman.dtsi b/arch/arm/dts/k3-am62d-evm-binman.dtsi
index 3a0ab9f8b2b..41c8746cf08 100644
--- a/arch/arm/dts/k3-am62d-evm-binman.dtsi
+++ b/arch/arm/dts/k3-am62d-evm-binman.dtsi
@@ -3,7 +3,6 @@
  * Copyright (C) 2024-2025 Texas Instruments Incorporated - https://www.ti.com/
  */
 
-#include "k3-binman.dtsi"
 #include "k3-am62a-sk-binman.dtsi"
 
 #ifdef CONFIG_TARGET_AM62D2_R5_EVM
@@ -72,7 +71,7 @@
 	description = "k3-am62d2-evm";
 
 	ti-secure {
-		content = <&spl_am62a7_sk_dtb>;
+		content = <&spl_am62d2_evm_dtb>;
 		keyfile = "custMpk.pem";
 	};
 
-- 
2.34.1

