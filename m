Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7322EC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 04:59:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45BF9811B3;
	Wed,  5 Mar 2025 05:58:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="E9xf2GSp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1472180F56; Wed,  5 Mar 2025 05:58:56 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20728.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::728])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2C01811B3
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 05:58:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=du9etQ1wfHOKSkyqRPtuZyl4WEYtdSbm5mV3Kj/oNBRCi0TYy25HZ8dNh6RptkSKa4KK6Jg0ADd3xCiup50TfWTmj3ekbaZKKdJWsuWhSM/flapMzO1Tb3qz8WnXAQPy8cflywwRyRMyHPogpMUt2GpwNQWTrzHujFKkX5vgPGMWSgVzd3E5Mw2SLs12sEB260tCcpS0A2zLLVX8t4cIFefH79yROjMpTZiW81TzrI85sviY/JpvzodKTONT9LpOxPCgxuWQWm3WVUGCfOOG51AbUdXhXhu7zryACfXeVZasxQAOlsl+2Rt5ydbtzCsEt+d4A6ntfSH01hhn3Cx5Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oOy8/yAyhuFTBlROxHrH9N8VxubSEOzE5BggwDp3TI=;
 b=Kz7eMJnUWm40B4oGDcdKk8Djx/tRInUIksJ1dGjU7xqCWftSqNQ2cGTK8sRKiSz3+WfH+N1n4FDb3ZRV0GEmO48uTP6Ywomr+fULNaWFH/ADlXAzvDA6E08j2sbMyPxO1PJMeyTvjE2h45LBgUoBKJz5uTN3sYyY0iA+2QCri5VU3trQZTsAo5yxWxSQB+aR5ZovMmiIf00B7bKuglYZ4m8MhC7QFvK2bmhxNlLfi9m8nGM6EMZGs4/TMJKto+acSzjAqDqE682agwUwDJnwJuFUMgDUee1qmGsCGYHadIE+g7RdM/qbI4t26A+vAgcVakZnQdVwFpRGV3y5wHD2Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oOy8/yAyhuFTBlROxHrH9N8VxubSEOzE5BggwDp3TI=;
 b=E9xf2GSprf52YrH8GpWP2k/QfntkJuf/Egrnwk3a9Amx1pmZUQ2jvH9gL6RufxclNDOv1wrfR8Le9if3fB2TEm37U9W3/PwiVPZd+Na2IFSNuATECN8k5hwMkA6m+k8D4wui+V8WVN835mN1kLvDs4Jz8ptPGEMyA8lzuuhpHAIzWT1q0SBsY6GvOSHdYTuiw4vNKBOd5xZJ4H+GaQlRyHQwfLqIXZipG7aaHcBjWUnQzv71v27Jbt7SsJfTxxkcVzKetzwJkEDNGDopUEA7tyMJEwauaWvfenGle3Fdw4mRv320pN508YfZizSZzu6Gq7a21SKEdP0Y+LHujpaUQA==
Received: from CWLP265CA0284.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5c::32)
 by AS8P195MB1879.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:53b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Wed, 5 Mar
 2025 04:58:51 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:401:5c:cafe::2e) by CWLP265CA0284.outlook.office365.com
 (2603:10a6:401:5c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Wed,
 5 Mar 2025 04:58:50 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 04:58:50 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 05:58:48 +0100
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 05:58:47 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <joe.hershberger@ni.com>, <n-francis@ti.com>, <afd@ti.com>,
 <nmorrisson@phytec.com>, <d-gole@ti.com>
Subject: [PATCH 06/13] board: phytec: phycore_am62x: Use custom k3_dfu.env
 fragment
Date: Wed, 5 Mar 2025 05:58:31 +0100
Message-ID: <20250305045838.3614661-7-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250305045838.3614661-1-w.egorov@phytec.de>
References: <20250305045838.3614661-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|AS8P195MB1879:EE_
X-MS-Office365-Filtering-Correlation-Id: f620551d-cdb9-4206-7407-08dd5ba26bd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?POrkj86CElyvEePi06812MYNprf1YHmE2ehuf9o1pzojy+SqADO1l6N4Vwqa?=
 =?us-ascii?Q?cGw0BAVoh0tVrc3XVV0/6wfx/IxqpuvpntiAYWY4JORoZhNnACdH//5Dr0zp?=
 =?us-ascii?Q?kFHTKAjtX1UPr6mAVsOCfMswkqOyfy+LKJYIGFWLC2qo5kSfYuooeoz5JatV?=
 =?us-ascii?Q?QZO3ruV91RK00U6wZ5UKcIre6OjHYN8jGoTpnStPtjCcE1TJFNHCNURRW0Ll?=
 =?us-ascii?Q?PAF5ZzJ6lNAFqZN1UiawenGlL7SUcQlVwOSS/oNRIeRVmh+KUaGHw5xzf2Cp?=
 =?us-ascii?Q?S3SUnzaMBJ5iJH21N3VT6eIKkQxezl6U7udD3MlTxzXEj6fIGmi8pGZIBgVK?=
 =?us-ascii?Q?D6yzgOcgIKUmBJ5xMtqQdeNLLrhYAhCoZ4vaxyUzzHWKltBLDiQXy2nBs8jd?=
 =?us-ascii?Q?VzEc7urI7UKPTUv/YMXy2k6wEKDFq0DvoOj18LozyLLagIlq20SQv/CKgfjD?=
 =?us-ascii?Q?osdzs1EmtzRVwPc9vTjnwmERaMslOIMhlbOadRk4ktLqASywdwMDrmokkJdN?=
 =?us-ascii?Q?FucDnQ2lrN6CZdWrrulGK+P3LKEIGG2kpvn1sbofYv5R6Hf2QLYk2r6zimRl?=
 =?us-ascii?Q?Nwzol17LIbKGFvjkfbJJuZD37ZoYjzapkp5yAPF9TrvGdYnMxHP44mg/yHDn?=
 =?us-ascii?Q?qSzMtBymRXbUlBq2WUyLF31m9aTwb7bCVVZyE7jPHDbENxeViKUJIEOLDRYM?=
 =?us-ascii?Q?hZmzMcnyzxWzY4L9OaogZjSgVP5BK/M7zc1iO1I3AfNw/O3bMBxvzTioI5m3?=
 =?us-ascii?Q?fGBmTvc3G+WHUm5K5HneiuJHZNTiyowFIo7KI7g/S116/47ygIVNLJ+7ebhC?=
 =?us-ascii?Q?8gBQM08nWLRYi0JOWVRzsnI/0fcuEkjMpbnYfvOrTdPEo0ripZKkJqXlU027?=
 =?us-ascii?Q?oRX9KZgRJ3oq508YycKCxVc/Vy8Z1acwWVpAapsEcpp4Q6D7IU4B1fQXOrnA?=
 =?us-ascii?Q?LNtwwl0jKCx7b3JgSnw8WJuI2hhYdyEswUrzurg2drgS2fa8vRK+BoThtbKB?=
 =?us-ascii?Q?CFfBHlk01AEV8BSzpzuOqOvMkPtwUOXrxWFlJ3KoftYxUZl4vNyEYu4IqKjY?=
 =?us-ascii?Q?i5bbuFmWnHIWRdBXYyeCK+3Rw0OxUkyJuZhvgTYYfsbS8y/FK3oODV7LwOa8?=
 =?us-ascii?Q?yLMAxnGHHzRUNZJ/LIM0z8qiuABwNimjKysPj0HIyZmg7luDXnnruPwaQo8f?=
 =?us-ascii?Q?xZrHN0tTpNh58BIju/KuQ7fnB1MFuZHABCyieXaVrlQzV4e3YWUEFIv2QXKA?=
 =?us-ascii?Q?yDgWN3pQVftShOV0ko7isyEql67GF8wyyjjDAHPW04VLp/jc3xwAJmRr+D2n?=
 =?us-ascii?Q?3ZX2FrGAuJCVo/P/Sex/VXMZ3mGNZYyWZWX7OYhiAA0LFprdxiGQVF0NJKlF?=
 =?us-ascii?Q?MjadfbcuCeHtSc4T+Bu3aT7OsiM6kcwJR9HNdrvloBaiueacY5OyyrJVUBpH?=
 =?us-ascii?Q?d819sAbKwHnV1R6B9XlXH4Xh6lS4xv/DP8r3jt6C2JZanMBgE3voMZeJaYSc?=
 =?us-ascii?Q?rPzE6CkJ0ejV9qg=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 04:58:50.7662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f620551d-cdb9-4206-7407-08dd5ba26bd0
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1879
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

TI's k3_dfu.env includes redundant dfu_alt_info_* data, some of which
is incompatible with our board configuration. Replace it with a custom
variant that better aligns with our setup, ensuring correct offsets and
eliminating unnecessary entries.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/phycore_am62x/phycore_am62x.env | 2 +-
 include/env/phytec/k3_dfu.env                | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)
 create mode 100644 include/env/phytec/k3_dfu.env

diff --git a/board/phytec/phycore_am62x/phycore_am62x.env b/board/phytec/phycore_am62x/phycore_am62x.env
index 711ca3040c4..a0eacd1dfc3 100644
--- a/board/phytec/phycore_am62x/phycore_am62x.env
+++ b/board/phytec/phycore_am62x/phycore_am62x.env
@@ -1,4 +1,4 @@
-#include <env/ti/k3_dfu.env>
+#include <env/phytec/k3_dfu.env>
 #include <env/phytec/k3_mmc.env>
 #include <env/phytec/k3_net.env>
 #include <env/phytec/k3_spi.env>
diff --git a/include/env/phytec/k3_dfu.env b/include/env/phytec/k3_dfu.env
new file mode 100644
index 00000000000..0cba87da99d
--- /dev/null
+++ b/include/env/phytec/k3_dfu.env
@@ -0,0 +1,3 @@
+dfu_alt_info_ram=
+	tispl.bin ram 0x80080000 0x200000;
+	u-boot.img ram 0x81000000 0x400000
-- 
2.34.1

