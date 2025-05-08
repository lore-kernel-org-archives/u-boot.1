Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B5CC3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 15:16:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70F0C82905;
	Thu,  8 May 2025 17:16:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="vmgJFSOS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7610A82AE9; Thu,  8 May 2025 17:16:02 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2072a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::72a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DAF8828A2
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 17:16:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCv1jPvM1S5Pc83GFfxHg4i6Uo9/nCSpy0IokuaET0q80N/K3k25mJGxwTM7y5pd/w1qNHjPY0giIXEBy+VlO7cQnMY0xBL7sMbWCVD057qJZWpLx3Mrm/NgQLTUXTAVm5Z65T3bSKOY+PNRZIckla7WlOmeeYGJ9suQ1+QUY6ripG0MA996Ub5OJWzFNE49J1NfYCzDp4Yb6cVo5WvHWtqR73M29uk1NtsdDbnfpQ8RlGhUcBTRRhTERBuASAZI6cLKJ9pgDRg65nk6ZVuFjj0xsTdxJE37TTSkTLkVsHxbmDoZx+ANwDRdgHFKpEWwzsoZr7Egany3kl9nbzVuzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWAia67iTGLhEjM0eAx1pxFeHRyII9VIgFNJKkRYoRQ=;
 b=r7XrZE8wFdgPzQ6CVov2NFg04yY7B9BfHOWgUNjB60L9KYk25dffKjYGSTPNP3A9TMi54wmH+JwByuyngNybrC2vXhtRlhin9wbr4tUSRlVdgIOoTQQrXoerQ2kFPL1R5xCV23Dyukxnuzh1ufuLC/+dOfK321Dqaz50j8T1rW887UDHecm6AB1utxoJzwsR5ZW255hkZDNvkJW7ex9/NluByPF+4knyFuNTRp0fYTGDjzMTXbaOizSybCadTjW7wbxZoe7+kSUzYIQF3tK6XydLv9i6XwbYHdd3NPv1gaNp0eYuKrrdShWWtDQDX/MqEVilpQpK29mClVbXbVgTaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWAia67iTGLhEjM0eAx1pxFeHRyII9VIgFNJKkRYoRQ=;
 b=vmgJFSOSVh5R2XFxu0TY51qbG35KKiBdfTJwyqcLz6BKYPz3NjeSQpvY4voEIMS4gj4ndr6V6nyvgRbVG2OiqZV5bQzjRG5GL4+OyALz8wUal5O00lI5e/tijr6lIwdk01Sy+EG3o492KqgBrD1/iVgn4ZjpqT0TK8ro3pEgYPPWv7cH+5um/345+4BqAQMNWWIy+Gq1r431DkYHNekzOoRW5bvhDN0HDHoUj7KmVr458kHZjddkJBBcJXeWZFCW5RObUYRR+FxUqVb1wcnAdOHA2fZL2YWtYIPmUWkuEDv/Ns50DkNQD8owPd/V84it6dFiDZP2hyfJl80CNCNd2w==
Received: from DB9PR06CA0027.eurprd06.prod.outlook.com (2603:10a6:10:1db::32)
 by AM9P195MB1203.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3ac::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Thu, 8 May
 2025 15:15:57 +0000
Received: from DB5PEPF00014B9C.eurprd02.prod.outlook.com
 (2603:10a6:10:1db:cafe::a1) by DB9PR06CA0027.outlook.office365.com
 (2603:10a6:10:1db::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.21 via Frontend Transport; Thu,
 8 May 2025 15:15:57 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB5PEPF00014B9C.mail.protection.outlook.com (10.167.8.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 15:15:57 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 8 May
 2025 17:15:57 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 8 May
 2025 17:15:56 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <n-francis@ti.com>, <nmorrisson@phytec.com>
Subject: [PATCH v2 1/7] board: phytec: phycore_am62x: Update environment for
 fitboot
Date: Thu, 8 May 2025 17:15:42 +0200
Message-ID: <20250508151548.162122-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9C:EE_|AM9P195MB1203:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a9acc7f-c093-4ea0-79dd-08dd8e433bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FWXhJw7C3uIadV+ZUf4TObRun3pB5bRkTE1UTHz5JChWWn1H9jBWi2Nn5DYd?=
 =?us-ascii?Q?Jmo4zQyQHwSpzkRcIm1aKpquBRYWt7uY527SPjdyYb0d+ZmXo3qd2v2DWGtr?=
 =?us-ascii?Q?2aTmqHvPzd7KcDQDXI0i4Cswt+0n0d5UwPKuN4FqpT38rBcK8Z/x5SYeDP7l?=
 =?us-ascii?Q?NjHjJPYBSWgOeoEHdhHjm1NqSAecbwB3KHvVlrdkL0iYdGpc57ZJRHJigJuf?=
 =?us-ascii?Q?G5WCHbKJ/aFzJ6+/g+I+wFysBQA/H7jGQcJmtEyV+axvi4p8FbGE9UK5GpkZ?=
 =?us-ascii?Q?8/2rYS8tAe2atDZ4+TLjIBldQA0IO2S93qpTtGGwYzY6uWJUN/4ogOtmI/uE?=
 =?us-ascii?Q?vdQ+UKdeKHGRynXAAGux2wF9X3aS261zSBu9FPnjRslkbKCNQrW6yFQ/MDq8?=
 =?us-ascii?Q?wtlTQHbOiZhydxxkZGaRSYxGNtIn3x0j5e9BjRCXWryzIPhicpEBZHDPXf8E?=
 =?us-ascii?Q?UIxkjQN/Hk1uxz1Qv6ba/gb/Yr1zI/E8ypvt75NtBpTdNFPywX8Q0LY8ZAb7?=
 =?us-ascii?Q?u9/j7mFcN+Ua5nWaiICTJkXqcoYZqeytLMfBS2T/+SQo1LeaX+AZpkB/ZEAl?=
 =?us-ascii?Q?WCcjaVUh2+t+cdlWx9h7n4Q+Oa784XFoigwZlRShJxGSojJb6efPhjkcfZlg?=
 =?us-ascii?Q?LiLgc9zIjuzeZWVUysBq4NZCdA2p6BA6CuBcx7bt1eFcQcqiagEtzf9OEYAV?=
 =?us-ascii?Q?DWPG8ExNgyko7eBZPWi/2ALaSCJRB0GwBI/+RqmfwNlDyBLLwt+etUgmfzHa?=
 =?us-ascii?Q?1CMGfTEn+kF5PIV420CnNHd182QEurjOmiH1A8fufyeT7IWBjV2pJ7pg8yY+?=
 =?us-ascii?Q?qTz/euQy6Xtk9FcgzRqqySTQhN/DvCSe7KOl0bEyq1hwC0wWNbmLuSNe53FJ?=
 =?us-ascii?Q?xtohk6aYIZEhk3tCN02/WYNLomYHs7Ah14cy+hZkG+9JJa3rY8qMk4bVvLgO?=
 =?us-ascii?Q?2IezXD8GylLvzWDGJBfnZCwc5V/qkldIEYL/YAkctom2ScB+5QApTMdKHtvK?=
 =?us-ascii?Q?Qq2l8mNoiD7IdWJeA7NsE7GALVskK4sX7O5s8bD7Oyunzk+d03t9gd+kgnGC?=
 =?us-ascii?Q?YgWYjz4+9laZcTkTVT1qFNPuwZBdg3Oz72QtP9GPF2v8XjzlWxK7sPWtj+K5?=
 =?us-ascii?Q?GDDpYMEbAFCtfXQ8Pl7naof3WldAHalzrCG9gIqjHwBnpaVdN6yfJkWesiNf?=
 =?us-ascii?Q?d4Jyvf45PFgq634+X/Dv8ilwYKpGLQdRC5CnNAXLmhf6/RDhQZBcYeKyXukf?=
 =?us-ascii?Q?hyr5dZ8OBNUuXbzLbrlRlk2o3VhzDnbFxhd4EoojkU/EcLjGVuf1kKv8hYNT?=
 =?us-ascii?Q?CEeRAO+k7cHtLtf7O89vcvfkh0s2UgluA2P/XBQn+i2Hjhsr+7N1BcuhFBm0?=
 =?us-ascii?Q?mrAsjQMHl9MosDxbIzBtc6e0ALf+ikHd/UhQNw2ElWNQp8dYvFyoE3Jhv2S0?=
 =?us-ascii?Q?SBAoIsiaXzF2VwQaNXJjHlp1jj73jJzVtA9VaYsCN8c0Ea1gLFZBvw=3D=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 15:15:57.4010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9acc7f-c093-4ea0-79dd-08dd8e433bdc
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB1203
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

From: Nathan Morrisson <nmorrisson@phytec.com>

Add fit_addr_r to the environment to allow us to boot from a FIT image.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
v1: https://lists.denx.de/pipermail/u-boot/2025-April/588142.html
v2: No changes
---
 board/phytec/phycore_am62x/phycore_am62x.env | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/phytec/phycore_am62x/phycore_am62x.env b/board/phytec/phycore_am62x/phycore_am62x.env
index 5c48e856685..40787b0cbcb 100644
--- a/board/phytec/phycore_am62x/phycore_am62x.env
+++ b/board/phytec/phycore_am62x/phycore_am62x.env
@@ -10,6 +10,7 @@ fdt_addr_r=0x88000000
 kernel_addr_r=0x82000000
 ramdisk_addr_r=0x88080000
 fdtoverlay_addr_r=0x89000000
+fit_addr_r=0x90000000
 
 fdtfile=CONFIG_DEFAULT_FDT_FILE
 mmcdev=1
-- 
2.34.1

