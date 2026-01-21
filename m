Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAC2C44522
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 12:16:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9457683A1E;
	Wed, 21 Jan 2026 13:15:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZVCnbLIh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31D278341A; Wed, 21 Jan 2026 06:48:02 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30F8D82A9E
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 06:47:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-joshi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fsZfHiSL6tYQ8ZFjD0CKbificIaMQL3etqsEURZa2WS0aX9v4T1iQeWnILtjkV589SLtzQn5GtUC9Ny93ps+F3hXvioIoeH40GNNzeqV/u1/Jh8zl9Ty/MJgyAC+jJnyU2IWNlengzsV58aGQtPObQAAuhUsNPxLA95nvX4sQH+/PwJnrTbJCwMuKQvrFMVv0debMnmypYCaU+OVIl8pq+fg+0vkuzEw7wK/zGTTrxVdSMTCrMfmei8ogHw7EJl9br+kLoT1PLxQjeu9WiGKjYGXuQMn0+bpgtQsIKJUlZ2dTO/pkzR36Pg2c8skYcmK5xnhoo68Jx0rlloG3ujLyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cneR4JWCYwR4ycG/s3wJjwjB9Gig/1c7TJX8XSvvEM=;
 b=bV9Dr1ud/w2usB8Ws0K8z5P/DsxS+jg2Wmr+KlksW1py23AKYJbBnxShaga4vJ0+JD32YNGdZ8upSubZe8yy7aEoRL6/3PjALCTSOL5Y6g18a4STcg4JWHSC8/UCa4itaklPRFHOgTLgea77xPlOcAo4lZHhk3QXImdkWL+6Q8xkZz8K/1d3tLguUk8rFduSVDOgDh2N2g/pFf80sK+wF24hDrjtT6ZB2x/Fm0CuJ3Cd4KcO+9AllTIim1oEpmWW6HF1iqWBMxiSiXfq0mrPqouiKihCrCGE+jS9C9HxZQ0jUjQQ9PBp8bwpbm7mTpwDr3JTFijW4FlJxM5qu0zrng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cneR4JWCYwR4ycG/s3wJjwjB9Gig/1c7TJX8XSvvEM=;
 b=ZVCnbLIh0ZKRIzBnPNcylLZVVH6DELVeYXTRBKv2P5XTIBJ5UVfBLMpaMowwO+Eneo8VU87sj+1mkVp+xBmUzZ6MTbhsWJ10GD1TDNWlf9dvYa1AF7EieNeMPx8B42pgXAenfMC3F9TGZzQfvhciGywa2VVRFFEZMQftGiPK8kE=
Received: from BL1PR13CA0321.namprd13.prod.outlook.com (2603:10b6:208:2c1::26)
 by SA6PR10MB8183.namprd10.prod.outlook.com (2603:10b6:806:444::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 05:47:55 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::fe) by BL1PR13CA0321.outlook.office365.com
 (2603:10b6:208:2c1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 05:47:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 05:47:55 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 23:47:54 -0600
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 23:47:54 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 23:47:54 -0600
Received: from localhost (ula0507357.dhcp.ti.com [172.24.233.202])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60L5lrEI2472768;
 Tue, 20 Jan 2026 23:47:53 -0600
From: Suhaas Joshi <s-joshi@ti.com>
To: <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <n-francis@ti.com>,
 <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>, <kamlesh@ti.com>,
 <vishalm@ti.com>
Subject: [PATCH v2 5/5] arm: dts: k3-am64x-binman: Configure firewall for
 ATF/OPTEE
Date: Wed, 21 Jan 2026 11:17:12 +0530
Message-ID: <20260121054712.176939-6-s-joshi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260121054712.176939-1-s-joshi@ti.com>
References: <20260121054712.176939-1-s-joshi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|SA6PR10MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: 80fbebbf-8294-404c-592a-08de58b09fea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C5smtjsIV1wW3+9OKLXtKltB9RpAvCGumF5NBuhb1yTI1zKAE6wsSF77F5VZ?=
 =?us-ascii?Q?dCsAsZPcPWai5Yuq13CSBKSbiSrQnyyMl5Sjto4Sfj1QsHQo5DNKV40TAX2W?=
 =?us-ascii?Q?w2cHmceR+ZioyufDDlohAaq4M37Kwrsl17QJuJ0XZ6ZyC+JJf15SLtFh3GpC?=
 =?us-ascii?Q?GHlbt6ugZctopt0as8Bmfk4In0/gMxIqapoBzq3YY0tVoq+OR+DOPhLY9TN6?=
 =?us-ascii?Q?as1cH5fndXzgFkCnM20xHMGCl9dllkAUkcX0ZoDNMrXDGaUBccxPgIYxbjQe?=
 =?us-ascii?Q?MzKESnYEYFYt5XfjtKSsb5VUMhSUGgw8cSQ4LIIG0Q01Muq55rgTEAsnNSk3?=
 =?us-ascii?Q?qfP4kkLR6P68LrrTA6AKymQ8sWVghQhMOwDVfkW1YO5ubacvx6yfRsrJ6BuU?=
 =?us-ascii?Q?xFF3ZlFNIpqZe8lFba8B5F1v2mSLRBaoOXBfd8jPTgIY5EOJZ5I3chbxlrox?=
 =?us-ascii?Q?shR8tNlaSL35cGIg1zA+Hype37jxP+fwZKcJqmDgo8G2I21iSVLIYyjaX1Pc?=
 =?us-ascii?Q?YbZVoaPxPZPoYfy6rwc66YHkU3lw6E9NH1AFmeAqvAVVpRQNWI5I04aWcKjq?=
 =?us-ascii?Q?W9oAMT95tJYk7tZFV1Hn1uOs1ax6MWe9/ji3Q3Chx17D9FU6A0s+AJf40D/J?=
 =?us-ascii?Q?4zwCrNU+2spy5G0v5TSCd5poLM+uzyph4UdUNEBKPGP4CmMrpoyhpnvdtt7X?=
 =?us-ascii?Q?RnHCxWxxHhB9ruQAu4cYR6ToYVsmOTnGimABHLs/kDKmK/peXCMoP5BGMfmp?=
 =?us-ascii?Q?DmOGZOP5fUjg5Q5r6YjtYIpDGnYLWSJCzd+hE26MccJdc/kvaF1ABmpqdMp5?=
 =?us-ascii?Q?WW2B8jPGUcrcrk1Lpw6SS/HXSZX0HnhWZlshUMNGfIlURefrPIGDZUwCbpNy?=
 =?us-ascii?Q?t8QUm/sItlMDvvcm+97ENj9sUces1DfIscm8quu9FKQRetSQXWsbo0tVoa3c?=
 =?us-ascii?Q?XiROJYQDchc45H6ruuHhM6WIFWy/7X5k95Idormp0NKJaxHjOMTcHxlq/mzS?=
 =?us-ascii?Q?IbSEveOJ/xMft2L/eyLRoZZeCh3uDTPT/JNyLJxqfnYvdYhjkq+36LQON6RK?=
 =?us-ascii?Q?TNemM3phy65YHs/YmaEoT1uBtjXrzp5tTkM1B8IyjlBm6iQb6mMXg4mKBnjy?=
 =?us-ascii?Q?tj6etXtms89C7hD/sTACe6JnCEGZjfb58CduD/1umXTYXXBUDAQXRZrXOMQT?=
 =?us-ascii?Q?EcgQ6Gf/XqUDAyP66DQ8FaXAK+vDStuPV9dCLVwHn/Wocq6yMeISeDRsiYRA?=
 =?us-ascii?Q?hWMdO+0MsOWeQwb+hf9rmIELONF9r9VYMZfQSvBqnuE9dElcmxwW9d2A0cZo?=
 =?us-ascii?Q?tFVYQQ5+Ts2YUjAEwS2aWjqh+qURX+2eHtXjdtF4aM5aJ3qHMY9sNQ0MABn0?=
 =?us-ascii?Q?ptyldEMS8VGaUqBgQ4bUFwiPqr9jegotJ9mUamwhR0Z4vmvNZroQKe/1M8wv?=
 =?us-ascii?Q?k7taWbKjyglFw+NQXqeWKX+l0XGQWpAfIIhwUtzi9K363/EzbGD6+qXcTyeQ?=
 =?us-ascii?Q?guGOMl60IwrJiuqQ36Ugu+e2+6tPrqe0D/inQvvGDEpoXG9X4bnxjNKAiElS?=
 =?us-ascii?Q?N+XyTgoKRnqhdAqh9w6Kw1XYg6TrCUEBCKPTGxzq/WJW5H3SgCcWrQgnfoHy?=
 =?us-ascii?Q?y2ae8dPAq4TLfQoE8kTSvPgxev1meLdWhpiJk0udqXMzCA5cSM4OJpkQzCEz?=
 =?us-ascii?Q?YRLE7g=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 05:47:55.2341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80fbebbf-8294-404c-592a-08de58b09fea
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8183
X-Mailman-Approved-At: Wed, 21 Jan 2026 13:15:54 +0100
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

Add firewall configurations to protect ATF and OP-TEE memory regions
from non-secure reads and writes in AM64x.

Signed-off-by: Suhaas Joshi <s-joshi@ti.com>
---
 arch/arm/dts/k3-am64x-binman.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/dts/k3-am64x-binman.dtsi b/arch/arm/dts/k3-am64x-binman.dtsi
index 32e47a3f688..f3c7f2c939d 100644
--- a/arch/arm/dts/k3-am64x-binman.dtsi
+++ b/arch/arm/dts/k3-am64x-binman.dtsi
@@ -139,6 +139,37 @@
 			#address-cells = <1>;
 
 			images {
+				atf {
+					ti-secure {
+						auth-in-place = <0xa02>;
+
+						firewall-24-5 {
+							insert-template = <&firewall_armv8_atf_fg>;
+							id = <24>;
+							region = <5>;
+						};
+					};
+				};
+
+				tee {
+					ti-secure {
+						auth-in-place = <0xa02>;
+
+						firewall-1-0 {
+							insert-template = <&firewall_bg_3>;
+							id = <1>;
+							region = <0>;
+						};
+
+
+						firewall-1-1 {
+							insert-template = <&firewall_armv8_optee_fg>;
+							id = <1>;
+							region = <1>;
+						};
+					};
+				};
+
 				dm {
 					blob-ext {
 						filename = "/dev/null";
-- 
2.34.1

