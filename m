Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71857C02192
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 06:52:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D4F680756;
	Fri,  7 Feb 2025 07:52:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="B4OuHnm+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E81BB807FE; Fri,  7 Feb 2025 07:51:59 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20724.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::724])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D33B680812
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 07:51:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/Bejke1yyf2WcM7OYLAeEXz1WD6/mBeWfZrO2XJ17YvLyHGHyfnt/U4/IOs2Fz3kk6sqVTFUErErHDqiGuisF5KayDG0Q9KQFhzfFb1GNo7kCqza54zypFPv2//9Kgj6oRQ45HjClqCgvPYpn6pbbjbKYKfF4iRQXNDlflH9mjk26+6RDM7vVrQU1pTL1m6Thnick7jlHEVO+ozywqG+Lhj09//gHgMbHmL2CKJeg0XXytT7ygrXMsnKWI5yLQoHEJKWt7Ax0eStpkPBXi7/6gqxC5DR80bvocIHJC6LuroM9HlnKoOC8mNDZUg+pPP3DtBu4blUCDfedDojtm70Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KP/JvHW2a7tR85pIEtxsYpxSMeli7Gm8WIKGBEIDdCA=;
 b=tf74uzYR3LOk1sp85tCGr7N5MinEFh901V7a6c5jyTDKmg5PR7EB65CmlaJiW4Wz6tc9QSOQ7ywbT2HOb5CLjQXYUox4Oo3j6hvoKtZaPtAtjR8uoxm1NZ3XWIwWWZaOULbs5jFy/fgM0g8xWEWjHhZ9hSjSZZimF0EtinCScKWVmwMBTulRpRn+S4/o+CoRvS8+hmbgq+hv35lLscPh+BRtcQZa3MIAxKKnBLyRLPa7YIbKVLfiJaQS4KgESjIIrab0wSU2DcSwFB0SPtA6b1PfjCk9e3qmVgqNf5P1uYnGqJVJRbc+Jzejfz/Rj/DWGPVLITVVaeqALhB206J0Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KP/JvHW2a7tR85pIEtxsYpxSMeli7Gm8WIKGBEIDdCA=;
 b=B4OuHnm+YSMF2zorfQ44MxYu0ckuLKHk660lQDcx296lNg9wZZdJa2gebY3AS7T9JHwR7WbwxJMR3fPLxcQ327EJH/Is6W0AX0mPEX88Fs2AfIZLUIbikP4jBcGifvTdXqBe+GapzNj+3OyIkno4pi5A+igINgrDkMk4wI461BSJqhxnebhWJ2zcrnvlxwqaxfc1hoBzkVgX1hok8cJqBi/JmzmCrDvWJsN02mLFc/rg0TwM311qIBf1tewAiu20KFda4YIesotsMjYdR3pw0CZlzAUYBEBAXWHdXNyvbg4Wev3KA6c+WIGh9skQ/twxy91idJ+9Q3uOc5c1zL8Fiw==
Received: from AM0PR10CA0066.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::19)
 by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 06:51:51 +0000
Received: from AMS0EPF00000190.eurprd05.prod.outlook.com
 (2603:10a6:208:15:cafe::f) by AM0PR10CA0066.outlook.office365.com
 (2603:10a6:208:15::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.30 via Frontend Transport; Fri,
 7 Feb 2025 06:51:51 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF00000190.mail.protection.outlook.com (10.167.16.213) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 06:51:50 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 7 Feb
 2025 07:51:50 +0100
Received: from ls-radium.phytec (172.25.39.17) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 7 Feb
 2025 07:51:47 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <ggiordano@phytec.com>,
 <u-boot@lists.denx.de>
CC: <nm@ti.com>, <n-francis@ti.com>, <nmorrisson@phytec.com>, <d-gole@ti.com>, 
 <m.otto@phytec.de>, <bb@ti.com>, <upstream@lists.phytec.de>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH 2/4] board: Phytec: phycore_am6*: Add k3 Kconfig to A53
Date: Thu, 6 Feb 2025 22:51:20 -0800
Message-ID: <20250207065122.2495923-3-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250207065122.2495923-1-d.schultz@phytec.de>
References: <20250207065122.2495923-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000190:EE_|AS4P195MB1456:EE_
X-MS-Office365-Filtering-Correlation-Id: 792a3a04-39e4-4ba4-0262-08dd4743e64b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7QHUkxTKmr2guRSwptdUCowG2SlaK93Q2dtB0V1feG3PO/fr2LnRabODjsKY?=
 =?us-ascii?Q?Rdp6/5Nifj/GWgAajXp8YAA9L2lwD1GTTlc5nnIsVoTCXuvFOUbzrUSmuG4c?=
 =?us-ascii?Q?c/FuPRgGlgeFYLh+qbjn2Q0Wk5Mg2GwpyWL7yJxm7+FpGl+18wUFlmA0ZykY?=
 =?us-ascii?Q?6oV/kArRxFiEntNENeu9q0u553BL1ivKp0TwtaNNoYAUbNhCCeD8LD/DRcH2?=
 =?us-ascii?Q?UptsD8uvBHvmhqelYyvmoSu3bv2yfvxOG6mVSLF5HPxhcHbYexgA8G972yr6?=
 =?us-ascii?Q?CGIH+4b3Ix7TcdDQ15/XpoH/i/jl4hpoi0fK05EzQdrbXt7LXl1/iYe34MOv?=
 =?us-ascii?Q?yp3Dsy6KmZGuUhiwj7cUxTcVz4vq3MO9fjawVkWEM6whhDeDepMJMJa3nmnn?=
 =?us-ascii?Q?b+pRvxgEysYOD4Gblr7nb2oDft+8AFz6apBUsER2clMCUDeWlCf0354Xrmjv?=
 =?us-ascii?Q?8Utj42Nek4T2nYWp6HOQaZDajBG5FKufBYM2L0qFmwiyeKIl/y5aTSBHYzoF?=
 =?us-ascii?Q?V+TAJs/O8nJ6mj7pAfakfliJ/6wV7fMoXDMiu2B1k+zNUiYeY0SPt+BvD1r6?=
 =?us-ascii?Q?0f6y9jEThq7CV2ujpJ5Zo+K4oUOsZ+WGJH1lAsA/pne27C9qZznzWQU1t3RQ?=
 =?us-ascii?Q?VEkTy0VvE2mmO3chQNH9bq9qKMi4tiyONNF54kTH7bYzx/nW5DEE7Aqz/nQT?=
 =?us-ascii?Q?7LMuW1wuvZYgnocPgq1/5z1kbuAAH7GwGmqr4x1QvLTm+3/8gK+NwcGP1agK?=
 =?us-ascii?Q?AvMRdZzmqxc1LwTxLyvFmQEPSdptFU69PqtSpeep8qXUaf8pXbHy7VPeR+jy?=
 =?us-ascii?Q?PZIoMwK8o9c5HTZU3SFCUw+DewFYrsMMTO++4gYwBnxs5plfufoxIK38G2kv?=
 =?us-ascii?Q?D8CIiUqzbCLS4MQOebOuTzT+41fK5NaHwSHk4XQlH43cfV5RQ+ItAd3CHhon?=
 =?us-ascii?Q?6BcvHj95NRk4jm17iPPwTV+mM2FdTjOT2r2qSsYTIi1nJmQofS7WU9InKd1t?=
 =?us-ascii?Q?CpzddOjxxfYYv+rQ2Z+5Rt3/PF0qkIG5gBpuVZvfAb1ilWrdb3DKhNasrbs7?=
 =?us-ascii?Q?jmOxPmh3VRBBMB4zaOywYwZIcs99EEu/qivchVXVinMupeLIxLVl2UKONQ1C?=
 =?us-ascii?Q?V1QuS8WwBC/GVFb0C9rncuxeOfYCMi+QggO2Z/i+7JPWL7R+keIqCDiJ9g4l?=
 =?us-ascii?Q?fhiOUc+5a8cJkCuizuFYfkFMCTv1Q8zUfIch6VVxUdEtYoDfI+nyeffh0IN7?=
 =?us-ascii?Q?Koh+WPPZWnU0UVf1vknnlWlEJX3/BQ/bPgMR6ugD37gSou9K2x0Rkv3EY9gL?=
 =?us-ascii?Q?9JzEW7BJKYcAkBQazI7Wc0ThAX5KVHXvZ0w1oOerqEgQXPsfJ4mmb2gWFq/f?=
 =?us-ascii?Q?uPpu796+CXp6LqfKk/2U9kDJGHNT96s0upQnPwi1Pd66eQoYYXpgU7HEfgxH?=
 =?us-ascii?Q?QGyPa/cFSLqyJk6UV53jhLfdHf7VQZ9Q9xAon/KUnnEWfbq+FROQ50WAUi7u?=
 =?us-ascii?Q?e1wZ6J9vMO653P4=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 06:51:50.8222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 792a3a04-39e4-4ba4-0262-08dd4743e64b
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000190.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1456
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

Add board/phytec/common/k3/Kconfig to the A53 builds to make
the PHYTEC_K3_ configs visible for this defconfig.

This patch also adds .../k3/Kconfig to the AM64x R5 build for the
same reason.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 board/phytec/phycore_am62ax/Kconfig | 1 +
 board/phytec/phycore_am62x/Kconfig  | 1 +
 board/phytec/phycore_am64x/Kconfig  | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/board/phytec/phycore_am62ax/Kconfig b/board/phytec/phycore_am62ax/Kconfig
index 516dc8e2020..81f2311ec97 100644
--- a/board/phytec/phycore_am62ax/Kconfig
+++ b/board/phytec/phycore_am62ax/Kconfig
@@ -15,6 +15,7 @@ config SYS_CONFIG_NAME
        default "phycore_am62ax"
 
 source "board/phytec/common/Kconfig"
+source "board/phytec/common/k3/Kconfig"
 
 endif
 
diff --git a/board/phytec/phycore_am62x/Kconfig b/board/phytec/phycore_am62x/Kconfig
index ecee5873c0c..6c2eb82787e 100644
--- a/board/phytec/phycore_am62x/Kconfig
+++ b/board/phytec/phycore_am62x/Kconfig
@@ -15,6 +15,7 @@ config SYS_CONFIG_NAME
        default "phycore_am62x"
 
 source "board/phytec/common/Kconfig"
+source "board/phytec/common/k3/Kconfig"
 
 endif
 
diff --git a/board/phytec/phycore_am64x/Kconfig b/board/phytec/phycore_am64x/Kconfig
index 829526c3295..ddfb4a39989 100644
--- a/board/phytec/phycore_am64x/Kconfig
+++ b/board/phytec/phycore_am64x/Kconfig
@@ -18,6 +18,7 @@ config SYS_CONFIG_NAME
        default "phycore_am64x"
 
 source "board/phytec/common/Kconfig"
+source "board/phytec/common/k3/Kconfig"
 
 endif
 
@@ -33,5 +34,6 @@ config SYS_CONFIG_NAME
        default "phycore_am64x"
 
 source "board/phytec/common/Kconfig"
+source "board/phytec/common/k3/Kconfig"
 
 endif
-- 
2.25.1

