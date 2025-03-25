Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03B3C36005
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 03:59:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC33F81DEC;
	Tue, 25 Mar 2025 04:58:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="qyDV5Trv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1600981951; Tue, 25 Mar 2025 04:58:43 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2071a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::71a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0C8A81B5B
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 04:58:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ykUFw/L/wYcF46GRBxYbGn/MCl1oQN2T0LAx+hFpujd+NorJl9ZpS4aSA4DYRvPHTz7K8KfflE/fCyStLJYN+Lne+u9YY4gj0j/4ahbog8vblb24hkwlgA8pf8zSi0JMJ+e+FYkbUO3k26m1QeFjAU/sG0/F0zgdzUHAJCnz1OtLMRImB8OPezpRzvTZJmqqmy1sNhs3CmEIqf9uJ2+ET6avV9yunGgrB/b5m7aLORZKwX8ONb6GDgKKv30DBwHmBV/pu8t3ODO+tCczw+nG9R03yAFw0/x9m43CcCaf5UztSwgW0yHt2/WJUD6ak0RL01YjYV1RZBeZaljUe080fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7ck/j5gwLjwLCJmEBPjUhFWKOgvH2wVgpSNf3nuXho=;
 b=DZWx6ZZRJjX73An0o9ofmSRy786Vbq68i3tIftEzgACs0mTX15UMoACfJ3xRkZt7aaJKo14481/QqTH0dGYTAThAmhuEn/lCZK9ce0vpsU4vlFTihPMi7XGUURHrv6u1zRCsgcqTgpeAPCosN2n6mKVf1O+9zQj/vNf+74AF3GRKq6JMerUIync+KJS4kSlUODPi5QORWiTGQ4FS4kTtzccqFHmu6BpfQWSEYl3Nsa1oQWEDtwQ71/lExDZQoMn6zgSW2b0R784LhMdFalLz2w0//09rzBs+dKeBoXPNvjPAAzNjFjWsmDbBsIpf5H0rDdQXul6WJG9hvUFIjcsYwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7ck/j5gwLjwLCJmEBPjUhFWKOgvH2wVgpSNf3nuXho=;
 b=qyDV5TrvQHL6PZeJq2y2MVFxHYPzRKFNHLf8a+/0pU5l8QOP6iBHiE3XrwbNHPdTqjeq2ID41/441Q1TNanyLamqORcn6muhc89E24QvBVuLMG+LlFSvmB4HBvvkYcaalBKPq5Ds2mCGSD4SWThb7h+WpKLIVEZVIjoahYdXvpLXjJINF9TGFlZdFVP603ZIQ6lXEcm2MMM0V//pzkMB8dpH8//4AgT64bSRNxEVp7TA8LnKE7X/zVuSwPWeNYrq34Ub4BWMLI8amp3gNc4YMG3qLIRVIUftwtH6Ad+cOIwBiqaYZndqLvE2PbbWBwOf93doL0vzgXDL489HazvQBw==
Received: from DU6P191CA0019.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::23)
 by AM0P195MB0689.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:16a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 03:58:35 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:540:cafe::7) by DU6P191CA0019.outlook.office365.com
 (2603:10a6:10:540::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 03:58:35 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 03:58:35 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 25 Mar
 2025 04:58:33 +0100
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 25 Mar
 2025 04:58:32 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <afd@ti.com>, <n-francis@ti.com>, <nmorrisson@phytec.com>, <vigneshr@ti.com>, 
 <s-k6@ti.com>, <dannenberg@ti.com>, <bb@ti.com>
Subject: [PATCH 5/8] arch: arm: mach-k3: am62a7: Probe CPSW NUSS in
 board_init_f()
Date: Tue, 25 Mar 2025 04:58:21 +0100
Message-ID: <20250325035824.2304200-6-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250325035824.2304200-1-w.egorov@phytec.de>
References: <20250325035824.2304200-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9B:EE_|AM0P195MB0689:EE_
X-MS-Office365-Filtering-Correlation-Id: fa58ab3e-997b-4e1c-0bec-08dd6b51510a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q85JzuIscff2feTzv4pLl5+biI8j38YxQhrBuD/1VuhCAeyxkkF024aNTNgf?=
 =?us-ascii?Q?TOJrxoGvJUZ+gSSlff9pJtoAx4GYLDlRcq5GwM4FDAjXf6qs7YoOXlTp9Jv6?=
 =?us-ascii?Q?dxddQV0bENRb5uy1SRTI/r4wozBH5/vEsLgmZSYNUvCmoHbx0iGYeOyicY5F?=
 =?us-ascii?Q?4V9YTty4iEGQkcs7u3ar3hZRCnLwOIu1qw4Lh86dH4Vte/ruQpjKsN/wFFmu?=
 =?us-ascii?Q?Lj/3rQTzkPTafVuq2aAOAHDeBYu9XvPk/2dKj5ya1GSPrKkkvWIT8aOKaQOb?=
 =?us-ascii?Q?PPSirI+pnb3xeabnCFPCONTFxYs5DCoFvPYSSBgil/emh42QuozZj9AZtipW?=
 =?us-ascii?Q?F9UB1pZesn3T0DJMLsL8NqZpRHn49sYp9wREdUkNhoxRoc6CPKF21zaNWwK2?=
 =?us-ascii?Q?9CtTBqbEzA/BTcF5UW81KgHGzAhgy+Apb6C1eD31/Lv3o1V9gGg47cUIp1qX?=
 =?us-ascii?Q?jeSvXnlr/zm+7AdFQj93N7IYh83zO397yLqsiW3eFWAT0W+WZ5I11EN9hEFG?=
 =?us-ascii?Q?hSI96w7fVg9ZApqwBq1d83b6tdbL6eSAy9KGFP2lH/cLiUd1u3LZsLtljmec?=
 =?us-ascii?Q?X8b6Az5ItgWIBKlItenDojpOt2CC12lapnzSb4bRRo82p0a2upSNAdSvVCTp?=
 =?us-ascii?Q?X35/RbBXWobPmhFJWKTSYT9S1f4zx/aD+RbmFy6KoWC9L88WN9Gr36fU1xB0?=
 =?us-ascii?Q?m9odNB3aqVZn0NQqppUKVB1qUo22nj+NHzuUTAjfHbiT/axOZynWTUpHXDlH?=
 =?us-ascii?Q?mwOdilBz89XwICx87R1ZA2BkQDA3DUDg5ig2Ce6BmlkuDBRSy+F9LYklIgBX?=
 =?us-ascii?Q?8EmeRfCu8vshorWrS92IPa6n8Q+C6Ox9wx9wbR8A9p/gopUXFOWYguYBUYEC?=
 =?us-ascii?Q?2M4TF12wcFsuMYRdevQ0QzrjVsL1Pxtq7sjh1H+/XI2b/K66zjnrvqa/syCZ?=
 =?us-ascii?Q?+cXOn2T1Ifn/1bqOo9L0tzxQ1lTQuHhITC0lJMcoEcNPSCIcTt5qPJAVZvVq?=
 =?us-ascii?Q?ucc/qeHG8hlluhvlYRM9uBqCn5JoY9tjSDgmEiCSX/b02S5XQj1kVFcH0phh?=
 =?us-ascii?Q?27IcSdr5TCFMEMxmF3gsRLXW/YkA8o8fP7PXbepXiYzTzjKc6yVk7fToCTjJ?=
 =?us-ascii?Q?iZzQ4SoIU5atZvPsB52tDV48tNTa0EOM5BSOqcqDONNiUGE7ijXB5FSEFeif?=
 =?us-ascii?Q?yA1YrIWGIwnYYWlw53Z5/Z5EvfklzlQrRyloPWQsWvmXRTnKvBwffIRgX4u7?=
 =?us-ascii?Q?/2yBjzcXhZY8l/LNQlAXFxWMcyxuD/hmKgijmhMe4Se8bOS27HdhmemtDCG9?=
 =?us-ascii?Q?6V2fgvnv8dfufKkVo8si6H/prET9KT2xHhvpWr0AyfDB+Zr+NonSLPT+ltQ7?=
 =?us-ascii?Q?L+MK+BqFE+09Hm5HwYax53x9QofJLI1CmE13g7BAdDBM0okI4Ut92iX5hN6k?=
 =?us-ascii?Q?Fsql56NmF6qxQdW+gbPyr1C+0z+ZaOGgCnpYKL2LeOIS6isEgdCUvU7kiKNT?=
 =?us-ascii?Q?8qraKZo1tfWOn9E=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 03:58:35.1833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa58ab3e-997b-4e1c-0bec-08dd6b51510a
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P195MB0689
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

Probe CPSW NUSS in am62a7 board_init_f() to support ethernet boot.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/mach-k3/am62ax/am62a7_init.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
index 698e6d5c587..52a21277227 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_init.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
@@ -194,6 +194,15 @@ void board_init_f(ulong dummy)
 
 	setup_qos();
 
+	if (IS_ENABLED(CONFIG_SPL_ETH) && IS_ENABLED(CONFIG_TI_AM65_CPSW_NUSS) &&
+	    spl_boot_device() == BOOT_DEVICE_ETHERNET) {
+		struct udevice *cpswdev;
+
+		if (uclass_get_device_by_driver(UCLASS_MISC, DM_DRIVER_GET(am65_cpsw_nuss),
+						&cpswdev))
+			printf("Failed to probe am65_cpsw_nuss driver\n");
+	}
+
 	debug("am62a_init: %s done\n", __func__);
 }
 
-- 
2.34.1

