Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7269AD29DC9
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 05:35:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D2F8836D3;
	Tue, 13 Jan 2026 06:35:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="uqA3ByGB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 765358389A; Tue, 13 Jan 2026 06:35:44 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89B18836C8
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 06:35:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AdYPqpBjbRC4nNXuto3G9IKPa/VeK+JbZQSQ1l48ZL0wQn12OE7QFmbF2qWUck5RAHSj2YNFZJDKZzNMuXB7btsQi4LHqtfFBILtGEbysTrzks3B5WMeU+LUnD9DTo4nqsDCDSEkBw0YQgqnaMbPlUJRJN9wtNxubssq6Qt+y0ltcmIcUuJD853j19fE/YK8zG+N69kgKQvyxiemf1f0fdjV1JMQHaTHiVLNxYaXjL4H1fGoA/sjDG1IaQIbpqjwkqzSlSqSyiKUNTrn4l76N7hO4rC8arl/sanWM/kvEhcJ9dIs2SE2P/aSN3Mk3NaeACBSTahii05ldujO3XQ03w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gg9ExWgumXm8VpQ4Mzko+sxCYgypGZ3o/tURO5vgMtE=;
 b=qC1eYfAxZPsOrX8OpTbqDQomLUzhqktvVY6HnFNf23cy24gQoddy/whgAjYhwReFbxUShCoF7dQo/NmbeO6lLnTxieKppa4SRIxLBNa0HTej5kPlWqnGweN75MYhqs5+HhX6miDykcJsEpQkYb8w3HMcKQhuzlf+87lndRLy1vDONLUdB/7dHYnsGQwGZFCC0n+r/qE1r4tFq7jJmwubsIGQU+00nNNQ4zkg1VuACc4Hlem065Wo8p+G/JAyeb25jv7du7rujlvLK91xuJZs6RIfl6QyktGU7c7iVb6iwS6+0hm7ADpT+pAmY0wV35p32/QGztLoh4gmsqgL7bGFjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gg9ExWgumXm8VpQ4Mzko+sxCYgypGZ3o/tURO5vgMtE=;
 b=uqA3ByGB4lyd9pD7hdEDs73HtWlvVUnegBOc99ELdq2k00Id/ZWhevtyDakQPq93zYgmGeMrLwppLYstk1jNSm9Ckn1YoWaFdaDAlLyx+PnMLnVgtUClL6J5JPzlfN7yD4CtTooffhjoMx7vRqw7/YzTIfT8oD4fTV/bH4cX0nrE5+euANSBNWfXa8ZHNWC5NivUZvrfxTQJzyHA5igW14wTpYo7gNn7nt+so28QbXi8uvNfzydztghqJqRJp2B6kKIo75jaREIHLDSPUyquncS0j+ZLm2zbfKY0UKNomlKE2X2poXagYaiI/mhnuI7xQnurF5udm/uuqiBwb25ajA==
Received: from DB3PR08CA0021.eurprd08.prod.outlook.com (2603:10a6:8::34) by
 PA1P195MB2754.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:4e6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Tue, 13 Jan 2026 05:35:40 +0000
Received: from DB1PEPF000509FB.eurprd03.prod.outlook.com
 (2603:10a6:8:0:cafe::de) by DB3PR08CA0021.outlook.office365.com
 (2603:10a6:8::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Tue,
 13 Jan 2026 05:35:46 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DB1PEPF000509FB.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 05:35:40 +0000
Received: from phytec.de (172.25.0.51) by Postix.phytec.de (172.25.0.11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 13 Jan
 2026 06:35:38 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <ggiordano@phytec.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 3/3] configs: phycore_am62ax_r5_ethboot_defconfig: Drop
 NET_RANDOM_ETHADDR
Date: Tue, 13 Jan 2026 06:35:31 +0100
Message-ID: <20260113053531.1204984-3-w.egorov@phytec.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113053531.1204984-1-w.egorov@phytec.de>
References: <20260113053531.1204984-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FB:EE_|PA1P195MB2754:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b71ed0b-23cc-48d1-1974-08de5265965d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rqqBRS5w6/hn6nsLy5hB//Lf8FsCt82zBriDpqk9KP1dh5cUKlk++MWNcafS?=
 =?us-ascii?Q?7Ar5SLFNct+P0siz4D8oCr9hMI2fXJmnL/6zC0YLnDeMvN8353cZNaWoiZqk?=
 =?us-ascii?Q?MXqS2f780U7CRrd8YrCMPTEJsnaM1nJFM1DRZ8t65Zj3RLrRTf+feY+eXdTq?=
 =?us-ascii?Q?+0BvY9FUuJMgjo5nqqBDbSMfVLyNz7k+IEX9eekkuc8mKQg+QNdAXOU2rEqI?=
 =?us-ascii?Q?0gtYeflBHV+Tf39YEMUkbrUEU7S3lGUIqyCAMcLAud0Rzn4m1ps3tbdB0Dai?=
 =?us-ascii?Q?EIu4x8tclwP+o8nF77KOG9WXFaayp20OVfEj5RNwM9aQOeGSuS59uL6u5uDO?=
 =?us-ascii?Q?C2lBebqjiZ6UwixDOJ7NQjeZB+unw+kbdXZ+crPO3+Lx+yfbJymSQ+CTpWvo?=
 =?us-ascii?Q?HvIjd84BwLlCKPzAFUzetssOAxbr/kNd0IMBCYag1VPZTIhU62UuHGcE9Qya?=
 =?us-ascii?Q?/enJxyFD/lXX+/xrr6MoS+kSk1mJtFS1b2LQBBtbfgeNySQ1kxlQo6Jxswnw?=
 =?us-ascii?Q?/ztPawcEMYXHpk/EF8KV8mCcCtujgBZd/FL0mbYqW1Dvd4JVO7DPwNSQfRdx?=
 =?us-ascii?Q?0MmlyvpaTXDXrp/EMxu/GGDNLLszFLL8rid3Z6U1GxFRNE7omsVVj/jBj7f0?=
 =?us-ascii?Q?w3yfhHi3IHqlWCt2if6M3oxU4g3NHnctFtKbT4XxefM0zUqHkiplm/EirgBi?=
 =?us-ascii?Q?bddbfh0oSkfWVR5px2TMrM82jVE4LY81ZDBmox0f4/VLrXjKc4pDOgvuKR7S?=
 =?us-ascii?Q?7y9c6vEkXbz8H2IjUTfakUQg2b1Xbo+pOkumfcJnWgrgnwW1cxc1qoFtjJB6?=
 =?us-ascii?Q?W2T0v8X2X2CMfGWYntQayZE89SL48762J9RI2Q9f65iKkm0FzrlbK70jXP7l?=
 =?us-ascii?Q?jMvzwxHwVSJvUkxlYrWgk/Ty/uUBz2pXhJK9Ml/LV/aSt21V7p5kOGeh96gX?=
 =?us-ascii?Q?yuOFBQFO7ZzUgWmMfutf3HnVKDj4zWv8kPBr1i7BhSXRnlVikQWhYDyn9ot6?=
 =?us-ascii?Q?JIpLXPlFIxnzYPJoiM5T2iXTKKOrMVVDVcH+12yrRQR9HKodjH0sR1UWO2p1?=
 =?us-ascii?Q?M2LueidT5gNmtAbsRSoiRrOdW3bf6syBTywN23l9YxUppPmTOUz9RrNeeWDV?=
 =?us-ascii?Q?DXOsPFvumcJ0f9H2xhR3fsI2bOZGDwJXbihjnVZHz9ou+TK6tKs/XDx0/DfN?=
 =?us-ascii?Q?/jA3VFD8pcNMUy9odJnJYdNC3TQ+X7X0RhQ+eBlhEuJT2NNYKUJSJfiW29G/?=
 =?us-ascii?Q?5VacEtweDO30okxQ2ljYLfWP28sitdFisY0+t0WG0C+lSywMWmawWHukvx9O?=
 =?us-ascii?Q?PocG/Vcw5CTYqpDyaXiCbzyg1ga6TsSTTIu96+prqqWS4urAd6dRKbzwA9l+?=
 =?us-ascii?Q?8oT7D43/AFH0lNC+QmYCSQpghMNckxCZptTa+klYlWyL0CZKKKJzRz5fGGW/?=
 =?us-ascii?Q?TYMA7l+HE05qvddWrMWzjWULYKATNjkz8+sR0ByLraZ5NvlaW5S/1nz3P3XM?=
 =?us-ascii?Q?Ii0luqITXyC4CfoSYxv20wgOGqli51nPGXwukoEcUWYglPedV4vD0mHV1n5Q?=
 =?us-ascii?Q?8O76hivj9kPJuSJwe0E=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 05:35:40.0313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b71ed0b-23cc-48d1-1974-08de5265965d
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509FB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P195MB2754
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

From: Daniel Schultz <d.schultz@phytec.de>

BOOTP does not support dynamic lease expiration. Using random MAC
addresses on R5 network boot binaries would result in continuously
allocated IPs without proper release.

Since only one interface is enabled for network boot, rely on the
MAC address provided by the efuses instead.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 configs/phycore_am62ax_r5_ethboot_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/phycore_am62ax_r5_ethboot_defconfig b/configs/phycore_am62ax_r5_ethboot_defconfig
index 526d15a0dc5..d597e9d92d9 100644
--- a/configs/phycore_am62ax_r5_ethboot_defconfig
+++ b/configs/phycore_am62ax_r5_ethboot_defconfig
@@ -21,7 +21,6 @@ CONFIG_TI_K3_NAVSS_UDMA=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_OMAP24XX=y
 CONFIG_PHY_TI_DP83867=y
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_TI_AM65_CPSW_NUSS=y
 CONFIG_SPL_MMC=n
 CONFIG_SPL_DM_SPI=n
-- 
2.48.1

