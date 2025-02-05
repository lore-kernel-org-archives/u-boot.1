Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79854C02194
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 08:02:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42FCD806FE;
	Wed,  5 Feb 2025 09:02:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="mSLQICXm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDA538078B; Wed,  5 Feb 2025 09:02:22 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20710.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::710])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DBD6807E2
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 09:02:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d30ApCXhvcJyAMTJ2fXNFZpmLVQ/7C+37i1g/aj3mrzbCsaHnsst7epxwADSZ/r4JV9XKt92jC2vaEfROTkjoHdZ0kkXths4GoOjcZ+2aYExlkoYMqNtQTP0zOJ9EzfxJsOxpaa4oWKqMcelsIlYPwVaU/RGiLnTBXDtL91kus4NwmCm/DrNhSo9QzuwgK27SS8kMg1PIyUKx7RK2I3EI1D3e3hRfi3X4MDfzBfajM+Wp8FIkbdQhm9chQK0r758HwDjsq1RBa12iFKAvw4gaNbFSeCGdy6foyhdHTWIxGf7FftkSloHmcdDj3omB1RgD1uosk5IBaPkVcgCBrAQiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4Y/VxoMvQ6urYyn5NRoFKCl5M3A2QS/OJxxggmjNMk=;
 b=DSb7MtwXtoveOhdMb/NCVwJwIgwHbwb6b7w0rnrG74moPSF01Px3++NWlzyfXK4l3IYQGH3GicU6/TcwHrKYJhUF4M89TO2nkAsFK/5qzdNCdB327Q1+77kPxrGYj+hl73gCL0SGFpGymYKT1fqRdcLztGuU+Vc8mpgVcS9uCUWMe3iUfwQSdP/632PmQJx2sXls0R09HZDUNbUVsjSDyFYlIHaifT/hdvSJpv4a6P3M//MYjvAlDN/riIn5bJY/I6jPdBahjzPUulZRz7J5mMtv40plTt/ZS0KEBAbGJhSC0KDEO30e8QmoV+q2qwOgn6hyYql1xZhBY5nrdqQ2qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4Y/VxoMvQ6urYyn5NRoFKCl5M3A2QS/OJxxggmjNMk=;
 b=mSLQICXmG2ZfTMkG0rZ6E4apt6GdcMBGo5pOgJpXuO/oEpQqkpS1v5vxDie0LHs3I9TdHZIlj99VysTVrX+qwXpLal+wuNFjHve1dyGLmkiu160dl/FNY37+PeyafuylMy8D/MvxQCla1t3jCr4D1k1JTYbpi+gVnGZnluEvB8TcRvvJ6+t0Zlc5VwHvqlJ9t8NJ7mYm+vyZXzGc3g5rju12USQ0V66aTV2REBir99sTsWXaWC0LZbypvGLVqJIRCndLxXUGu7ECoZlN2rzEk8GTdFk/LdMLeq4rLQk/XcS0dyJltRWeFGyeSs7+d132NGrcvvtNNL3U7aEzNuIGyg==
Received: from AM6PR04CA0054.eurprd04.prod.outlook.com (2603:10a6:20b:f0::31)
 by VI1P195MB0685.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:154::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 08:02:16 +0000
Received: from AM3PEPF0000A79A.eurprd04.prod.outlook.com
 (2603:10a6:20b:f0:cafe::63) by AM6PR04CA0054.outlook.office365.com
 (2603:10a6:20b:f0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.28 via Frontend Transport; Wed,
 5 Feb 2025 08:02:16 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF0000A79A.mail.protection.outlook.com (10.167.16.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 08:02:16 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Feb
 2025 09:02:14 +0100
Received: from ls-radium.phytec (172.25.39.17) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Feb
 2025 09:02:11 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <ggiordano@phytec.com>,
 <joe.hershberger@ni.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <d-gole@ti.com>, <n-francis@ti.com>, <nmorrisson@phytec.com>, 
 <m.otto@phytec.de>, <bb@ti.com>, <upstream@lists.phytec.de>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH 02/10] board: phytec: common: k3: Introduce
 PHYTEC_K3_EMBED_RAUC_ENV
Date: Wed, 5 Feb 2025 00:01:38 -0800
Message-ID: <20250205080146.1944928-3-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250205080146.1944928-1-d.schultz@phytec.de>
References: <20250205080146.1944928-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A79A:EE_|VI1P195MB0685:EE_
X-MS-Office365-Filtering-Correlation-Id: ed5317e6-6371-4d71-1b1e-08dd45bb6855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M2XraYWrIw/Ut1co7+0s1enJ6sGNDzPuDp9g6VRwavgPBq7nd8xqELJQ73Gk?=
 =?us-ascii?Q?nPn+mw/jN4JRUaW352ikEG1iu9eO3Jqj0T3uieTkT801ei6UTSSLg4dHG61o?=
 =?us-ascii?Q?O1rnpvXSXUfnQm1LUx3SUmXnPGhsgjTgYjP6ovEaVEsa5eVvMw1l/i68jw3j?=
 =?us-ascii?Q?fdbRwxb48we2E+sc2fRXG/r5hUv9iApMJBDGq0xOhXEfj+VyUQSxbvrGjGrG?=
 =?us-ascii?Q?4DP85gFbShS9sonNxjbscX8mH5srWq9BqNT7P3k1VyzMy1GztfExhR27/lA6?=
 =?us-ascii?Q?3t/6JEAVWXqhul1bR78XhnF/nztJ2YsIhVWBaC0cSIgYz3AMJqwGFsgBsSLl?=
 =?us-ascii?Q?WO+Z/mMlH7gHHGVxKYZ237S/juNerlw6RX8m13LOrq9y8oMBSFrTyvz2uV4P?=
 =?us-ascii?Q?EeDnBSgIOtvAkvlWW7BKb0IllzwR6TCznGmmR6ICg+y/le1ulKOOpNLJ2UBJ?=
 =?us-ascii?Q?IZPaMrCNwJRFl4HYoKaboRERekGR0VJug59YGKB3osLtUbB5QBV0B+IK7XZT?=
 =?us-ascii?Q?iQTiIuALnH7vspqR9LCX0g0AWTg/6M2d4wV02lP1l3WaQU+QC+Ypjsl7LV7D?=
 =?us-ascii?Q?HgnFqNGRohwdnmshAaMzwnn0G7b8gRfSfdkXK1+LIWfSZzHWiX9Msgr0C+zH?=
 =?us-ascii?Q?xI8JqaoFM7HayyE0lYp/p+HVglYi8to3xx10QbNoZVwVAM8cJDZU5sGNmgGi?=
 =?us-ascii?Q?8ej08JIa/JDiv+9p2Z2pAF5ZoeQftZ1nXOjhWcC8LvRzWLh+FXMpC1PPyDL3?=
 =?us-ascii?Q?NH/7kdj/rZu8ILH2SJOChZAzt7NA/taeZea9ulbNAfRHTNA2zsx11G1qq/XC?=
 =?us-ascii?Q?B490Paxeg1C64HG/OznYiEY+i3DjFrtxk2uaatrBK3ZuWAmefp6Uy295r7PZ?=
 =?us-ascii?Q?Vn7Zn5QzKslzkPs41/fImlSPm9QLsZ4Yl0P8mpcvstmwAh8zJqymKqQiBqOz?=
 =?us-ascii?Q?Xg4Uikgsw0PKqbnJCuMtYQ328wLaOjVssuUY2aV3XI/vOpF/Wu4DFz36b7De?=
 =?us-ascii?Q?liv/HEJ02hdLsVOW0u1mW9PTxVSQdS2GfiX2jQ2NaXBsDfpJJsvix+cVIYMX?=
 =?us-ascii?Q?E/12jsMaE4Z8b1xgR2IOEAQZmCypJH49u4eatWIMAyfPaB48CgRe57Wx/41M?=
 =?us-ascii?Q?Ta8uZKzMhl8QWAagN02ZS7Xre7LTNKnrOWe0a3oUnywxBNh0Bvs6DS0knBKk?=
 =?us-ascii?Q?94YhtzxdRSApaCw0xCZz6anba8dLH4NyiVDVb0U+ktJ5pgh53FBRrm9aclMs?=
 =?us-ascii?Q?ROCHEd7zsV1idmpum27qtMe6Z57bP4Qy6ax/EOBiFn5IyCZtCwq4jrKbf+cu?=
 =?us-ascii?Q?KrC/u2cUOZJRTPs3naItIcodIhLE++GyF0IRJYZ6BnNZ4ki8O5OQVUuip1rx?=
 =?us-ascii?Q?zGXZD6/BY5pFbrCGmlbE20JOwtjJ8RV1Jbr1rSaBOuU9CgHeiXy+4XvU+u1T?=
 =?us-ascii?Q?eeoOta060FyHhNCBLYCxWfmH6UbS+IDcP5oHlib1KAZrtkCGgn7p/niysJUT?=
 =?us-ascii?Q?BBQaQHMPsZdAhlQ=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 08:02:16.7618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5317e6-6371-4d71-1b1e-08dd45bb6855
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A79A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P195MB0685
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

This configuration enables external activation of RAUC boot.
When enabled, the boot process incorporates the PHYTEC rauc.env file.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 board/phytec/common/k3/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/board/phytec/common/k3/Kconfig b/board/phytec/common/k3/Kconfig
index 19fe927b22e..3404864c39b 100644
--- a/board/phytec/common/k3/Kconfig
+++ b/board/phytec/common/k3/Kconfig
@@ -37,3 +37,12 @@ config PHYTEC_K3_DEGENERATE_KEY
 	   copy of the original key.
 	   If PHYTEC_K3_KEY_BLOB_COPY is disabled, provide the path to the
 	   original key.
+
+config PHYTEC_K3_EMBED_RAUC_ENV
+	bool "Embed environment to handle RAUC A/B systems"
+	default n
+	help
+	   Embed RAUC environment variables into u-boot's default environment.
+	   Provides logic to select a boot partition based on environment variables
+	   and switch to the other if the boot fails.
+	   Includes include/env/phytec/rauc.env.
-- 
2.25.1

