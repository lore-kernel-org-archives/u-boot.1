Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FD3C369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 14:49:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B56A082A53;
	Mon, 28 Apr 2025 16:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="bxDLm8QG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 503C982B0E; Mon, 28 Apr 2025 16:49:29 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20727.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::727])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 589CA8293C
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 16:49:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJ7dy183lWrCbaCY1QidMI6kGdirHTLNdvwjmRamRhXG3riWZTwFnSXv0uwaY6LRY0OdnyfZXaFr43qa/rmqebU3H+Z0vlkeEKwH8jvFzqBjoXsXkHdh0iqPQW8DOUhicnqn5tgbrm+OVwKHpkzUJK7/O98dk5edUWVPJ2pXRP/i63g/h9QQDfBk1oCPmqJOIl5MupnJSEj/eMUWM965bq+lqLnUkvLuXO/mvVZKjex78qPTOlPc2swS4M55n31HPpdcc77/hHtPuLLLyY4cexS+j96FOdIAP0w2vS3g/+SbBAMPeKia7g6bkxOtYJOdSWJPc151VIphOvE8sI6VUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/GdWAEIkGsEq0jFFJ66Ld4u4OTLt+5q4wiGXK1xbeY=;
 b=ZEL3onEUk7vE30gLc1mJkceXDVzq53BwBEzCLeixC1eNbcgIlWJNGPZi8hNKU3EvEiKw4UsUAgn+PqK2og1Yt1zHHz67FYNwxo3NocX+kOjaWL8aWB8Y15mSE/dyxwbYkmMQ8o9APnxiCBsI5eDQDOHXK3EKTxztc1dR7Jr/tu6DADqq18T2sNqqBcpTpFeDdIK7HdYcbK6dofJZGL+Z9xPDv14N9GPMI6ZMFZkn7ooN+Z/gPBoxssD5b9Vjr7Zw6YO6ASx/XgwxNSqTKpZyabbhA5v9NxW04ybZ3v4TuwF1z0C+tmZy2AxD693eOg+cK+qen4ih2pWm1IzyUlBFLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=phytec.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/GdWAEIkGsEq0jFFJ66Ld4u4OTLt+5q4wiGXK1xbeY=;
 b=bxDLm8QGa0XZtCfBDd6oSjgFgqLSVUSctbBpvGkqVIsCoqshJV/Umq3EJUCCCvOfK6AtWSSbqeTS1k7MplwGKg8vgdwYd+vJV0URymPfsGqKmF+x/l3huQOP8RhOrPF1vxQjwWRXaR8dHDXcX2+pd73OQ7TaiT7O8TNfFV7cAQ8RUPK2mpR+I6Op9DaeGo95wocNsWdxm201kcw6osSJczCoQjA+2RRNPjzQWc/hN9jjcmZFnXZULSsO63e+YIgPJ8PCymy3mk6yAQJp58xRi4SPuTrrfgQlzZYsUyNomsWq5QN/CONxij+2hOa65C83Y54OlCAbRPSCuaDDIRpP7Q==
Received: from DB9PR06CA0006.eurprd06.prod.outlook.com (2603:10a6:10:1db::11)
 by AS8P195MB2319.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5af::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 14:49:22 +0000
Received: from DB1PEPF000509E7.eurprd03.prod.outlook.com
 (2603:10a6:10:1db:cafe::4a) by DB9PR06CA0006.outlook.office365.com
 (2603:10a6:10:1db::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Mon,
 28 Apr 2025 14:49:22 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509E7.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 14:49:22 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 28 Apr
 2025 16:49:21 +0200
Received: from ls-radium.phytec (172.25.39.17) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 28 Apr
 2025 16:49:19 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <ggiordano@phytec.com>, <w.egorov@phytec.de>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <joe.hershberger@ni.com>
CC: <d.schultz@phytec.de>, <bb@ti.com>, <nmorrisson@phytec.com>,
 <upstream@lists.phytec.de>
Subject: [PATCH 2/3] include: env: phytec: k3_net: Use get_cmd
Date: Mon, 28 Apr 2025 07:49:03 -0700
Message-ID: <20250428144904.1058574-2-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250428144904.1058574-1-d.schultz@phytec.de>
References: <20250428144904.1058574-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E7:EE_|AS8P195MB2319:EE_
X-MS-Office365-Filtering-Correlation-Id: 84690df2-6cc8-46a8-4005-08dd8663dcd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hS0zCq+uIybE6OoCVFrcck9dp6m9mPEzyzSkCOf/sVCDqcnE/ZK7ffZGfG6w?=
 =?us-ascii?Q?9fPmcmVau4rySi+BdYOmN2Q+te6UMF4pK3InmWXk1JN0t4kbuIvnBuue8Zfw?=
 =?us-ascii?Q?ljctRTjoSqPNJ7YBtdTOPoIFlsOw8JWDLDIlBUKSaU552a9wef+L/Y8GPjeV?=
 =?us-ascii?Q?tWy9jXsB9SD2uCNBgD+P/VUClyQx9Kz4eZULD6ZcagBiw6VHsiyqfReA+zX9?=
 =?us-ascii?Q?GemKIgYe/I8A8Wkxe0jltnl1umHwfPxpegCgEmbWIm1iQRLRoi9l9A8RKrKt?=
 =?us-ascii?Q?gziFMtsfwR6oXikWwTpf95pzhv4Rkv2YnhfuV/ZbFN/8jyksErdBzwqdx9wr?=
 =?us-ascii?Q?2ahbZq6QbsQyE+mrqENUCvWieSNqAncyTVCGX8u3ao8/SgLWVma3C4ilTZ9B?=
 =?us-ascii?Q?/K3QxMM5OZTM5UCOwHHpwBCotqATeH4sIrLckaZISvTOAteMZnVE98Nm2dJK?=
 =?us-ascii?Q?ODuIyFocUVfVdqh5zsfEOa6VDHFgJWotPc45ZHcwheK2xOZB1G7mBiW6g23q?=
 =?us-ascii?Q?VJve9oNP2puY0jceL6+62uYYfCLxKhsFfWfyzMiL6A3/JJcOu+8COkFsijIg?=
 =?us-ascii?Q?AenNWXzro5F2QYh0rEzCQ/8/0/HM+YY+0V2GoagXfyZApIqgRDbMoX1ioCNX?=
 =?us-ascii?Q?KHM4Tj5cMv3C3fAruZmf807iSVq+jHK1PLACCRqA/HW0LoMXJq0MrgXHtZTU?=
 =?us-ascii?Q?/+sh2vMN+KClPNzYxV+tepx0bVJl7h2sUgDP/av8x+TYOqlKvUQzWr8dh5bU?=
 =?us-ascii?Q?p8RmKsznJGUulKXwi16wKAB7ANoOd4qZlrZTgeQm2cDk1bBlLYLsbnNxXafX?=
 =?us-ascii?Q?9lQj4Ssp7z4fGlXikIlJoeg+a5Q5Fdq9XZ4lLPCamSi4B+n6Wp8oqgr/409F?=
 =?us-ascii?Q?PCdOEqUaYBJJENdslubQYVXJrt3vwJu55sIyk8b3tkVK04H2dCuJLoe1qxir?=
 =?us-ascii?Q?/3Ob/ZhxH/O5biAybCy/qxEIfE7JtaoS+4vUFDOl0xbJ2lYo1w5P01/I1RMo?=
 =?us-ascii?Q?BxKLEAW2m3oO20M9d+azd7iB5Eqz7IxqgP2xxDgd5JMgywyMdNRFXkSKMdLp?=
 =?us-ascii?Q?DR/ZlhsSvQp87BUn34l8HmmyVyHofsSPM1AG+CBnpeO7MivSh8LYGj8q0E7w?=
 =?us-ascii?Q?DYXTNXPpRsF/gO1NK14Kl0JzWRH2PeGjzpHNwKVRel1Q64x5VuaMFT6OsDbg?=
 =?us-ascii?Q?HAieUWejlpLqTdPUfDwx8T1DfmnpNzTrH+Fduv93LG22Yhqepj1O18/RzsDC?=
 =?us-ascii?Q?X7YDFboRit/Znvm0v9a9tzINhdBP4bAh6w5svs5AaigmrrL3w2jce5O7B+f7?=
 =?us-ascii?Q?sQvv8C6DRv8ZuZ9BXlNseQ+ZhW44+DPoo/ebFUiQxebl87WoqcoYUpO506Al?=
 =?us-ascii?Q?aBfAfNdovB+uhzrbaq2d7B7HrYJiFqvBgrJ3zCc1qNDgIPlw7mDfhpGS4pOU?=
 =?us-ascii?Q?258+HfSjEv6N8PPD4Nk4IhBpkQeTwFHyTMuo8/x1bzfTUQaPaaE1IlodA3hG?=
 =?us-ascii?Q?MAyiF1QpyXFGA9NQeppvULrO1QJeBKZK66xg?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 14:49:22.0439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84690df2-6cc8-46a8-4005-08dd8663dcd2
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E7.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB2319
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

'net_fetch_cmd' is not defined by the K3 board files. They
use the more common 'get_cmd' from NXP products.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 include/env/phytec/k3_net.env | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/env/phytec/k3_net.env b/include/env/phytec/k3_net.env
index 2ccdc9eaa59..4d5c703cae9 100644
--- a/include/env/phytec/k3_net.env
+++ b/include/env/phytec/k3_net.env
@@ -10,8 +10,8 @@
 
 netargs=setenv bootargs console=${console} root=/dev/nfs ip=dhcp rw
 	nfsroot=${serverip}:${nfsroot},vers=4,tcp ${optargs}
-netloadimage=${net_fetch_cmd} ${kernel_addr_r} ${serverip}:/Image
-netloadfdt=${net_fetch_cmd} ${fdt_addr_r} ${serverip}:/${fdtfile}
+netloadimage=${get_cmd} ${kernel_addr_r} ${serverip}:/Image
+netloadfdt=${get_cmd} ${fdt_addr_r} ${serverip}:/${fdtfile}
 netboot=run netargs;
 	setenv autoload no;
 	dhcp;
-- 
2.25.1

