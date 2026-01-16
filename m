Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158A7D47CCD
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 10:31:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F30B5839B1;
	Fri, 16 Jan 2026 11:30:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="r31YuRpk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE62A839B1; Fri, 16 Jan 2026 11:30:47 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEDB5830E4
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 11:30:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOcvSg2QWx2xcXT5NlbELPWuFyCmDEsU8cQcoHwsDxM2Df5AloCqJGACyA/nft4jPQhubtrn7CpQQpmEl54S7+E3ca1HaCqa75mPm8etog0iLTeuHcS1F95WJR7KszAiNWrzB5omfYs//Jdfi+RV618xjXk8NFBHA8q+QuSLlaJ+3Ot9MlotxxCBb6PT8qGRMKRWTwE438j2HyoWX+vJAUx9R6VwfYYpY1Y3nZPo5rYwrongaHiQ2GnNuBPdy9aUyDW3pHZDAmnVwb1F/5dN+MuHzz76dAcvkWA8chw2zwUIXntaDVWs9ftxkCGHzaX7r7JZn3NhLAT6MCeRJr3gtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncGhH/Ol/Uj9OwSBAyfZsIqbZCG0H7r8HkpnIAtcCYw=;
 b=jBKhQO4PdZn6bTgaht2L6HgwxRCLHLCA/jDF4kkIiCLq6et0a1gGIe1EnVmChswmz4vO/mG/qdEQuuOU14ZUCTCzcp2k2ZcYTTylaWaD4Cxo0lXmTucNMOMXrJY/fbjCCIYQzkfpGdCarYY/WZlL4xtvhK/jKuyl5s7p1r76RtUozMBmc0kZUlVQNxojCAu/80qR89/a1CALvkvOsay/9LaId/kB8aPi97CK/xRF+k+TIQ+ziSkGkSRIKtogrW5MQN1CdjHINdacrYPnOAeh0EoMVhbP5FVG3FgredpURmCFGu7Ab3HW1qXbnySf9sA49U5UUaU0FaLgQp6KDggs7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncGhH/Ol/Uj9OwSBAyfZsIqbZCG0H7r8HkpnIAtcCYw=;
 b=r31YuRpkPTSID+7mnxjqgMOgh3A+qM0aMQmWA+ak+YlvP8hqOXBUejlKc49S4uxdfqdTm4gSreA2wmNXvNbqG7EGrwyRZQH0HPxd/PvZ3gASrtMrXwlfrgb7jM18RK/WNT+ude5PClGXpywO/TgOtdTll9qDnPxlHZV+ocjTupg=
Received: from CH0PR03CA0384.namprd03.prod.outlook.com (2603:10b6:610:119::26)
 by CY5PR10MB6189.namprd10.prod.outlook.com (2603:10b6:930:33::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Fri, 16 Jan
 2026 10:30:43 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::ea) by CH0PR03CA0384.outlook.office365.com
 (2603:10b6:610:119::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.7 via Frontend Transport; Fri,
 16 Jan 2026 10:30:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 10:30:42 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 04:30:39 -0600
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 04:30:39 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 16 Jan 2026 04:30:39 -0600
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60GAUb7U3139456;
 Fri, 16 Jan 2026 04:30:38 -0600
From: Paresh Bhagat <p-bhagat@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, <khasim@ti.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <t-pratham@ti.com>, <nm@ti.com>,
 <v-singh1@ti.com>
Subject: [PATCH 3/3] arm: dts: k3-am62d-evm-binman: Override tiboot3 filenames
 for AM62D
Date: Fri, 16 Jan 2026 16:00:10 +0530
Message-ID: <20260116103010.3947922-4-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260116103010.3947922-1-p-bhagat@ti.com>
References: <20260116103010.3947922-1-p-bhagat@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|CY5PR10MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: a5d548c6-0dd2-4c96-4243-08de54ea4cd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|34020700016|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QquKcuOBGieFyhUKJkXsFxcp432enONrDJ/M2lYvMhOK/Dw+k+yrV05zlA8t?=
 =?us-ascii?Q?mrurqJBTSVN04kwRRVEhrPWWIjnurIru96Lrgex1EqYKpw7+9XpU4lqrbGSr?=
 =?us-ascii?Q?y2ZvIPjyAxOHjW8Cq6qk/jUoOtqSaJrQCldc9k3kgeYZ9pScJHZmQqlJz+8M?=
 =?us-ascii?Q?r7jfIvQgrTGHL2SOdelZVHniCMi8No+grcIBsPsdX0Nl6QEylMLrUH+u1+TT?=
 =?us-ascii?Q?qcRvDhJ2T9hIRD/RJ8PjJU7llo1kUIuQQH6N6fCPB4R//SDXhqxn49H1/6qx?=
 =?us-ascii?Q?ZRdjLEYVV+04QSWV3MYG36jWYYGxEvzWPQHd9HPAcAehu4phHb0sDp4eBAaF?=
 =?us-ascii?Q?/zTIyCuNaWYHksw/SZHfURkA2SEcUf/PEIq6JDnL9xhcTWgTMH3DEsabVusq?=
 =?us-ascii?Q?BDEG36UnnaMJuRqxdFr9EgIdJu2096xI88wXjTJW7AoKvlpbl1IzXTwNpfKi?=
 =?us-ascii?Q?n+oXQNjah1UK48+wvdRSWHoV8d+ZtPRKIjUuvP6QSF6ea5TwLX2CiZcBq/x/?=
 =?us-ascii?Q?4/2YQk+6HN15h269ueMZ/N9YtFv+ljo1Ct8iABfzZstFh/SFsU6hvblC0xX+?=
 =?us-ascii?Q?MXSxv8eFtP5udRLP+T/bZTz/kzFF+0mkQg6FSN28MqbhYBIKtNWfdkTIPVW5?=
 =?us-ascii?Q?unwAeYEnSEhCkkW9lc/Z2OPGkj/PK2xaP+CR2oSnGrl6Gn4hR3B1Od+gsAfP?=
 =?us-ascii?Q?1ej5HHkreFVO2oM+193tq7jz4EL7vjzAspqV1Zq5Qm0rxRaoadGyuX5NQb6+?=
 =?us-ascii?Q?nnVNd2VTxYKuADVDqSrBW+RotWu64aIDQceg5PclqM2a34oLQnvCoiE7kn1X?=
 =?us-ascii?Q?+NfTSFw/l3SPuiVXIdHISY6hgsfRJxA1EqifqtLaGwTPZ/rctzPefrd2CfXQ?=
 =?us-ascii?Q?QILNhxb152OslvWFlkyflwZ5vonp9nrKmTIo2fgbFA6DRDRhxwD4lb4wAiHR?=
 =?us-ascii?Q?QGwJN8HGSeqt0FHhyKVpllgpktg08os0YcqBTc+CwSj9aW5Z1x6MvMHwmnO9?=
 =?us-ascii?Q?zTh2rxXby1H8561b4U6i5Gt2UUPcjC8GfyDGJfBf2Dqb6MiHyY2HTdJSx2YB?=
 =?us-ascii?Q?P2/3O50fw9XlJTpXwcJGYqr6gRW6InWhGMFeorCKQp9l/C9xv0bHq7QJu+Za?=
 =?us-ascii?Q?x7BBB7/UqXzQK36q+/oN8DCQuhj36hjEwgPDsfkfW6Nj9/SHqFg6vSIDjVXJ?=
 =?us-ascii?Q?CKqH1LaEv4EYcGHmIR3k843nBWJ6ixkQDQQs4d+ZGUZRdmY18K5BG5WCjmcD?=
 =?us-ascii?Q?fvdfjBMXmQH5ioujqCvMPmLMdXc+U+iXH2fhrg7FXLVHFqRtQMwkD3Jw4RX1?=
 =?us-ascii?Q?Io8lTRVcFGk3JpdL0Kd/cXcwzXZQUpPPeOXj5cdW5sZZlRVQpKVMt9MPf6de?=
 =?us-ascii?Q?XrlxnXB0JbzoGc4Igel8yyQRQOhETAe21fHfOjRdninV50K+vvXM+S2MZJKs?=
 =?us-ascii?Q?07QOHsSEjM1FDAMf0xHdDuKZCvBQ2vwRjoKTI5VNTzSUOfLAi1eIwFPrMGwR?=
 =?us-ascii?Q?GqFt+4SkDjGyXSB/MU36lC7mKfN8w8o8HsZk9fW2+Rwni+rphi6gpLZYWW+5?=
 =?us-ascii?Q?c18d0/fNsZ3WXuE0KiNZTN4hW6DN7zxUWCCtpjMyUBUopgpBfqRsSayYMJqy?=
 =?us-ascii?Q?Kjl2oROqOUbUvnB1BGriilBqED3zvueh82xGS2H/yYeL2wJ3PwU56vBZ9LYB?=
 =?us-ascii?Q?qyg5fA=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(34020700016)(82310400026)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 10:30:42.0360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d548c6-0dd2-4c96-4243-08de54ea4cd4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6189
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

Reference the tiboot3 binary labels from k3-am62a-sk-binman.dtsi and
override their filenames to use AM62D-specific names:
- tiboot3-am62dx-hs-evm.bin
- tiboot3-am62dx-hs-fs-evm.bin

Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
---
 arch/arm/dts/k3-am62d-evm-binman.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/dts/k3-am62d-evm-binman.dtsi b/arch/arm/dts/k3-am62d-evm-binman.dtsi
index 41c8746cf08..430bf8ccb79 100644
--- a/arch/arm/dts/k3-am62d-evm-binman.dtsi
+++ b/arch/arm/dts/k3-am62d-evm-binman.dtsi
@@ -63,6 +63,14 @@
 	config = "board/ti/am62ax/rm-cfg.yaml";
 };
 
+&tiboot3_am62ax_hs_evm {
+	filename = "tiboot3-am62dx-hs-evm.bin";
+};
+
+&tiboot3_am62ax_hs_fs_evm {
+	filename = "tiboot3-am62dx-hs-fs-evm.bin";
+};
+
 #endif
 
 #ifdef CONFIG_TARGET_AM62D2_A53_EVM
-- 
2.34.1

