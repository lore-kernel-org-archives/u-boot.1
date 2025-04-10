Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DB1C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 07:55:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E533383A1A;
	Thu, 10 Apr 2025 09:55:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Ft/6kjg4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 303EC83A1B; Thu, 10 Apr 2025 09:55:45 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2072d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::72d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F326E839FA
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 09:55:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPXRnjwCPXd/NNbPfsrTjj7QtRWZ8ORfbX8wVul5jPxXVzN5DTsFq8A8Tn0VF99RbsDb17Pff2Ok5BItbhK4+xsnoPKZxZmEHvkbrEfvnUT00uwsr4sUWHIi040m331r8IVU6w6UHvAkvNQpBkohlmhsmDXT/t/8DGRELsSM1uXOuYZZCmdnu6/QeRpHeRp7JwQO9ntYR7b+dLq7kyArZH5bvy36bCpOEB7acnYUs4IhGTYa7r9vzaBrOE58vrrKs8iKtHjeebE1yvLFxfrz5FfTR3JIXqjGtD8LJCI4LuJ0EWXOZSM6sOTWo8pLuF1XxsvwXNrpwoipJv0vJzqRFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNeiZx6CyoB0yGeuhMQtuGABaWRk1wc2AHoQjHYOk/U=;
 b=DoEPs9LbhnZZRZXb4BNsSSGBwuSHIlzMscBTyBt9/+sAjyTCpa8H31JWRvZtEYwMXk5eJmJcYTB4mmvuhxnQ2IHZ+1cIntsdkoASuatp6elEF7Be7JvUQJwujN+ds/FkUAYHSxryNk2pLshtIjbJxPy5LKaEBJ1X08EF1ZcyYUOgSnT58n+V+HV8YYkdPCvmqchUmlRUtCsvbNQYJGQ9sINN/SSpIhFSK3fn0Ch9LvstTLzfCVHN/5Bx5ybvyYNu1Mdy/UzKesa2O1Hsuy49sQWY9j/7rJ/Bg85aQC3C/6A6v20tY3GWzgU6dYNYG6wfvidl7vwnSeS6o5ESrpRBiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNeiZx6CyoB0yGeuhMQtuGABaWRk1wc2AHoQjHYOk/U=;
 b=Ft/6kjg4BY1E4VNOjqE1yvJxWeuOlXGjS3KgQxJDmYYoBHjGgYWUSYFQGxfct0Mr5jQ3G/fbt4JOYW649aMP9w7kI9oivL48UnnjUhFJxcFixXuz8EoKMWIJ3dRoLc7diAwckumgmFn6RZAzN5f95AIWmSNnUSX5KEAWXYtttj5V554i6LmU7sC0t1+J97qGb17SsKdZPkqw8dFT2ILiv19QcPo8HDU1wfNptyJ/0AHTh9apkjgv41HyYmeGhryk/hhjuIqoYKiXOAXvj6nnMkC4A1tMZNa90MN2kw/QECEWXdzqHkcnpZkhOUfHWW8EnyZGoTgi3W9rGGCRQvsdeg==
Received: from CWXP123CA0013.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:73::25)
 by AM9P195MB0981.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Thu, 10 Apr
 2025 07:55:41 +0000
Received: from AM3PEPF0000A799.eurprd04.prod.outlook.com
 (2603:10a6:401:73:cafe::62) by CWXP123CA0013.outlook.office365.com
 (2603:10a6:401:73::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.40 via Frontend Transport; Thu,
 10 Apr 2025 07:55:41 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF0000A799.mail.protection.outlook.com (10.167.16.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 07:55:41 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 10 Apr
 2025 09:55:40 +0200
Received: from ls-radium.phytec (172.25.39.17) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 10 Apr
 2025 09:55:38 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <trini@konsulko.com>, <afd@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>, 
 <bb@ti.com>, <u-boot@lists.denx.de>
CC: <w.egorov@phytec.de>, <upstream@lists.phytec.de>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH v2] mach-k3: common_fdt: Move carveout struct
Date: Thu, 10 Apr 2025 00:55:25 -0700
Message-ID: <20250410075525.390331-1-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A799:EE_|AM9P195MB0981:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a1108b8-af3e-408d-4b36-08dd7805170a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PSoApULNjBKQY6oVhUao0WAEU7a/cRasGUspSePTUJ6W5WmAJ4ZHIb/bf5dF?=
 =?us-ascii?Q?JsK3ZSTbgYpFBhchbZqYrJ/cwmPJOErrEJc11o2D6LWgah9OKv5zIiT6MnTf?=
 =?us-ascii?Q?PtvDxoOpqu2NCiRh8CpE5DW31DE3sMXZDFK/RqvW4pUcLmLsOKu/xT5FJ43Y?=
 =?us-ascii?Q?YoTXL+EFyE3Gx1DVkVKY+ldN0TyimNweT5gQoyA2icQyjH6u8KLUPbd9wH2I?=
 =?us-ascii?Q?/x7WsZMWrSXrA2TXb2BFHguxmAczH5wQa4OPMRjaJH4OvWHSPeVcaoyyGbhR?=
 =?us-ascii?Q?NvrjYZERZiroTxLG+j4w0EH2/tYB9vN9eAXKMQUuOovGC7Wh09RMxvWNumFN?=
 =?us-ascii?Q?YtEtf4e7/zeqG+tSnr2vgJPhEA8s6FVgSntW1t5564acRiSWfQ/FaWpSC16A?=
 =?us-ascii?Q?5NwtXKvqG6l0FAvdg1TMIgs4PGM4V2GPyPRFXxa1/1SQVuRSdjEiM6zjprJO?=
 =?us-ascii?Q?k99PptLlvO0IPJB57Bg+8qjubiLo2MPkFFgcIUvOLNi0ky4VH3coYl6zq75h?=
 =?us-ascii?Q?WhXOHq4MTdBg8MQEte6Bmmk6Xi5qrWtRruzp7vH2w2J1EddyiKXwPq0SeK54?=
 =?us-ascii?Q?eMdwd5bFN68ePWiCvZYi4HqP8lgp2LnuipgcHMjSm0XypKAbNA0sksrGhS0T?=
 =?us-ascii?Q?vSCyuqd5WXYws3EfMGNHBnJ3sf7i/fzohFR6xlS/SzDodJzgevpvKSlKb5tF?=
 =?us-ascii?Q?JbcVWSJwn8W4ctWB6j5doahQxCpyHoBmfykJoSpzbXGp4YQmY/JCxfAf2fZ6?=
 =?us-ascii?Q?M3xx2skMy69Zs5WftUM17gBFWbI6y2T9SbUzX3ZMXM1tIGVNrh2U92kSyYSz?=
 =?us-ascii?Q?/AgbRKGa3IF2hzKd07Zi/EMu649kHcKo9ulOjBiJASOqbRmqUnADgCwdgHl8?=
 =?us-ascii?Q?snZoffKYSoU/jvM5XDHNx/9l9fK28iYVXddCAOJvRv2CpnMJODNWG2IiIZ4O?=
 =?us-ascii?Q?CCKACYOdzfRP/9V8wKafqwF9OK5XiPzPpZsQ4y3DCvdkOn8UFS2Wovbjzn+R?=
 =?us-ascii?Q?MYZKo9ZTao4qm6+4SIbwVBvDhd/jEx6PIxp0dQe7zttCPNQEnK22bkw7ZJIx?=
 =?us-ascii?Q?pln1gAhcjeuGlz3eLy6nCPKUsX60YooiGZxOWZNd+EulhSqygZAiRBsizeuS?=
 =?us-ascii?Q?+hk4ynHE9uyl8HPzawo+lbHApLPHFcvVgxk+TrhHz+bCNkcxbZG5HOd+x/Ck?=
 =?us-ascii?Q?laonSod0cS/zKl57xxa6bQG8sPtKts7aVvR66evCjdQsMFz/gW+el0tEIgCx?=
 =?us-ascii?Q?vzIBf17qNDxErg8LQFzOa6uF52u/G57z+4NGQsW+eCqAYtcBoptv/r17GUGK?=
 =?us-ascii?Q?23yqtMVVOTLoyteouN06CT0W1zcLo0aXE7TawU9uJqMfph3UYgoMPuFfLwto?=
 =?us-ascii?Q?BdyL7UabXHFwAx9Vq+7MWKRZo1ZEVv22Hq9xbpA2C2ld6E+zbTCjH9DWMRxP?=
 =?us-ascii?Q?pV7I8aH3l+fLe28s42ol0ajRuXIwG6XnGa7ZgqEKoENIaXhqkRGRnKm0dZKh?=
 =?us-ascii?Q?rHc35dT6RBGlpoMVbxqKJ95DuRHfDp3XBau5?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 07:55:41.2729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1108b8-af3e-408d-4b36-08dd7805170a
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB0981
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

Labels are not allowed before declarations. Move the carveout struct
at the beginning and only update 'end' at this point.

This will fix following error:

arch/arm/mach-k3/common_fdt.c: In function 'fdt_fixup_reserved':
arch/arm/mach-k3/common_fdt.c:156:2: error: a label can only be part of a statement and a declaration is not a statement
  156 |  struct fdt_memory carveout = {
      |  ^~~~~~
make[1]: *** [scripts/Makefile.build:256: arch/arm/mach-k3/common_fdt.o] Error 1
make: *** [Makefile:1919: arch/arm/mach-k3] Error 2

Fixes: 096aa229a9e ("mach-k3: common_fdt: create a reserved memory node")

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
Changes in v2:
  * Moved carveout struct at the beginning instead of adding an dummy statement.

 arch/arm/mach-k3/common_fdt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-k3/common_fdt.c b/arch/arm/mach-k3/common_fdt.c
index 361b0c0b31b..9437b923d49 100644
--- a/arch/arm/mach-k3/common_fdt.c
+++ b/arch/arm/mach-k3/common_fdt.c
@@ -119,6 +119,10 @@ int fdt_fixup_reserved(void *blob, const char *name,
 {
 	int nodeoffset, subnode;
 	int ret;
+	struct fdt_memory carveout = {
+		.start = new_address,
+		.end = new_address + new_size - 1,
+	};
 
 	/* Find reserved-memory */
 	nodeoffset = fdt_subnode_offset(blob, 0, "reserved-memory");
@@ -153,10 +157,7 @@ int fdt_fixup_reserved(void *blob, const char *name,
 	}
 
 add_carveout:
-	struct fdt_memory carveout = {
-		.start = new_address,
-		.end = new_address + new_size - 1,
-	};
+	carveout.end = new_address + new_size - 1;
 	ret = fdtdec_add_reserved_memory(blob, name, &carveout, NULL, 0, NULL,
 					 FDTDEC_RESERVED_MEMORY_NO_MAP);
 	if (ret < 0)
-- 
2.25.1

